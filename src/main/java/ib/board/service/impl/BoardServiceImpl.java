package ib.board.service.impl;

import ib.board.service.BoardService;
import ib.board.service.impl.BoardDAO;
import ib.file.service.FileService;
import ib.schedule.service.ScheduleService;
import ib.schedule.service.Utill;
import ib.schedule.service.impl.ScheduleVO;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("boardService")
public class BoardServiceImpl extends AbstractServiceImpl implements BoardService {

	@Resource(name="boardDAO")
	private BoardDAO boardDAO;

	@Resource(name = "scheService")
	private ScheduleService scheService;

	@Resource(name = "fileService")
	private FileService fileService;


	/*================================신규 게시판 구현==========================*/
	//그룹안에 카테고리 리스트 ( 및 상세정보)
    public List<Map> getBoardCateList(Map<String, Object> map) throws Exception {
    	return boardDAO.getBoardCateList(map);
    }

	//게시판 그룹 리스트
	public Map<String, Object> getBoardGroupList(Map<String, Object> param) throws Exception{

		Map<String, Object> map = new HashMap<String, Object>();

		List<Map<String,String>> resultList = boardDAO.getBoardGroupList(param);
		int totalCount = resultList.size();

		map.put("totalCount", totalCount);
		map.put("list", resultList);

		return map;
	}

    //그룹 Uid 중복검사
    public int countChkGroupUid(Map<String, Object> map) throws Exception {
    	return boardDAO.countChkGroupUid(map);
    }

    //그룹 등록 및 수정
    public String saveBoardGroup(Map<String, Object> map) throws Exception {
    	String chk="0";

    	//신규등록
    	if(map.get("groupId").toString().equals("0")){
    		chk=boardDAO.insertBoardGroup(map);
    	}else{//수정
    		chk = map.get("groupId").toString();
    		boardDAO.updateBoardGroup(map);
    	}
    	return chk;
    }

    //게시판 카테고리 Uid 중복검사
    public int countChkCboardUid(Map<String, Object> map) throws Exception {
    	return boardDAO.countChkCboardUid(map);
    }

    //카테고리 등록 및 수정
    public String saveBoardCate(Map<String, Object> map) throws Exception{
    	String chk="0";

    	//신규등록
    	if(map.get("cboardId").toString().equals("0")){
    		chk=boardDAO.insertBoardCate(map);
    	}else{//수정
    		chk = map.get("cboardId").toString();
    		boardDAO.updateBoardCate(map);
    	}
    	return chk;
    }

    public Map<String, Object> getBoardContentList(Map<String, Object> param) throws Exception {

    	Map<String, Object> map = new HashMap<String, Object>();

		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());


		int totalCount = boardDAO.getBoardContentList(param).size();

		map.put("pageNo", param.get("pageNo"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.
		map.put("search", param.get("search"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.
		map.put("totalCount", totalCount);

		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;		//총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를 (+1)여부결정
		map.put("pageCount", pageCount);										//총 페이지수

		map.put("offset", (pageNo-1) * pageSize);
		map.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize

		param.put("offset", (pageNo-1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize

		List<Map> resultList = boardDAO.getBoardContentList(param);
    	map.put("list", resultList);


    	return map;
    }

    //게시판 글정보
    public List<Map> getBoardContent(Map<String, Object> param) throws Exception {
    	//user열람 정보를 저장
    	boardDAO.updateReadUserId(param);
    	return boardDAO.getBoardContent(param);

    }

    //게시판 다음글 이전글 정보
    public Map<String, Object> getBoardContentPrevNext(Map<String, Object> param) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();

    	param.put("searchType", "prev");
    	map.put("prev", boardDAO.getBoardContentPrev(param));

    	param.put("searchType", "next");
    	map.put("next", boardDAO.getBoardContentPrev(param));

    	return map;
    }

    //게시판 글 등록 및 수정
    public int saveBoardContent(Map<String, Object> param) throws Exception {

    	//게시판 정보가져오기
    	List<Map> boardInfo = boardDAO.getBoardCateList(param);

    	if(boardInfo.size() >0){
    		//공개기간 설정
    		if(boardInfo.get(0).get("openPeriodYn").toString().equals("N")){
    			param.put("openStartDate", new SimpleDateFormat("yyyy-MM-dd" , Locale.getDefault()).format(Calendar.getInstance().getTime()));
    			param.put("openEndDate", "9999-01-01");
    		}

    		//승인여부
    		if(boardInfo.get(0).get("approveYn").toString().equals("N")){

    			param.put("approveStatus", null);

    		}else{
    			//승인자가 없다.
    			if(boardInfo.get(0).get("staffUserId").toString().equals("")
        				&& param.get("approveStatus").toString().equals("REQUEST")){
        			return -8;
        		}
    		}

    	}

    	int seq = Integer.parseInt(param.get("contentId").toString());
    	int chk =0;
    	if(seq==0){														//등록
    		seq = boardDAO.insertBoardContent(param);

    	}else{

    		List<Map>list = boardDAO.getBoardContent(param);

    		if(list.size()>0){
    			Map contentInfo = list.get(0);

    			//수정올렸을때 이미 승인요청한 건
    			if(boardInfo.get(0).get("approveYn").toString().equals("Y")
    					&& contentInfo.get("approveStatus").toString().equals("REQUEST")){
    				return -10;
    			}
    		}

    		boardDAO.updateBoardContent(param);//수정

    		if(!param.get("delFileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    			 String [] arr = param.get("delFileList").toString().split(",");
    			 param.put("fileArr", arr);
    			 fileService.updateDelFlag(param);						//파일 db저장 된거 삭제
    		}

    		deleteOpenOrgWithTarget(param);		//수정일때 관계사 타겟 지움(직원 + 관계사)

    	}

    	param.put("contentId", seq);

    	insertTargetOrg(param);					//관계사 타겟 저장(직원 + 관계사)


    	if(seq!=0 && !param.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    		param.put("uploadId",seq);
    		chk = fileService.insertFileListJson(param);				//파일 db저장
    		if(chk==0) seq = 0;
		}

    	return seq;
    }

    //게시판 삭제
    public int deleteContent(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("contentId").toString());

    	List<Map>list = boardDAO.getBoardContent(param);

		if(list.size()>0){
			Map contentInfo = list.get(0);

			//삭제 요청했는데 이미 승인이나 반려가남.
			if(contentInfo.get("approveYn").toString().equals("Y")
					&& (contentInfo.get("approveStatus").toString().equals("APPROVE")
							|| contentInfo.get("approveStatus").toString().equals("REJECT"))){
				return -10;
			}
		}

    	try{
    		//게시글 상태값 바꾸고
        	boardDAO.updateBoardContentDelFlag(param);
        	//본글 파일 지우고
        	fileService.updateDelFlag(param);



    	}catch(Exception e){
    		seq = -1;
    		e.getMessage();
    	}
    	return seq;
    }

    //게시판 댓글 등록 및 수정
    public int saveBoardComment(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("commentId").toString());
    	int chk =0;
    	if(seq==0){														//등록
    		seq = boardDAO.insertBoardComment(param);

    	}else{															//수정
    		boardDAO.updateBoardComment(param);

    		if(!param.get("delFileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    			 String [] arr = param.get("delFileList").toString().split(",");
    			 param.put("fileArr", arr);
    			 fileService.updateDelFlag(param);						//파일 db저장 된거 삭제
    		}
    	}

    	if(seq!=0 && !param.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    		param.put("uploadId",seq);
    		chk = fileService.insertFileListJson(param);				//파일 db저장
    		if(chk==0) seq = 0;
		}

    	return seq;
    }

    //게시판 댓글 리스트
    public List<Map> getBoardCommentList(Map<String, Object> map) throws Exception{


    	List<Map>resultList = new ArrayList();
    	List<Map>list = boardDAO.getBoardCommentList(map);
    	for(int i=0;i<list.size();i++){
    		Map resultMap = new HashMap();
    		Map param = new HashMap();
    		param.put("uploadId", list.get(i).get("commentId"));
    		param.put("uploadType", "BOARD_COMMENT");
    		resultMap.put("commentList", list.get(i));
    		resultMap.put("fileList", fileService.getFileList(param));
    		resultList.add(i, resultMap);
    	}

    	return resultList;
    }

    //게시판 댓글 삭제
    public int deleteComment(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("commentId").toString());

    	try{
    		//게시글 상태값 바꾸고
        	boardDAO.updateBoardCommentDelFlag(param);
        	//본글 파일 지우고
        	fileService.updateDelFlag(param);

        }catch(Exception e){
    		seq = -1;
    		e.getMessage();
    	}
    	return seq;
    }

    //게시판 조회수 올리기
    public int updateViewCount(Map<String, Object> map) throws Exception{

    	int chk =0;
    	List<Map>list = boardDAO.getBoardContent(map);
    	if(list != null){
    		int viewCount = Integer.parseInt(list.get(0).get("hit").toString());
    		map.put("viewCount", viewCount+1);
    		boardDAO.updateViewCount(map);
    		chk =1;
    	}
    	return chk;
    }

    //공지게시판 - 메인
	public List<Map> getBoard1List(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return boardDAO.noticeAllForMain(map);
	}

	//업무 게시판 - 메인
	public List<Map> getBoard2List(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		map.put("boardId", "11");
		return boardDAO.generalListForMain(map);
	}

	//사내 게시판 - 메인
	public List<Map> getBoard3List(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		map.put("boardId", "9");
		return boardDAO.generalListForMain(map);
	}

	//게시판 읽음 처리 (리스트)
  	public int updateReadUserIdList(Map<String, Object> map) throws Exception{
  		String chkContentId = map.get("chkContentId").toString();
  		chkContentId = chkContentId.replaceAll("\"", "");
  		chkContentId = chkContentId.replaceAll("\\[", "");
  		chkContentId = chkContentId.replaceAll("\\]", "");
  		String[] chkContentIdArr = chkContentId.split(",");
  		int cnt = 0;
  		for(int i = 0 ; i < chkContentIdArr.length;i++){
  			map.put("contentId", chkContentIdArr[i]);
  			boardDAO.updateReadUserId(map);
  		}

  		return cnt;
  	}

  	/**
	 * 게시판 공개 관계사
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public List<Map> getBoardContentOpenOrg(Map<String, Object> map) throws Exception{

		List<Map> orgList = boardDAO.getBoardContentOpenOrg(map);

		for(int i=0; i<orgList.size(); i++){
			map.put("cboardOpenOrgId", orgList.get(i).get("cboardOpenOrgId").toString());
			orgList.get(i).put("targetList",boardDAO.getBoardContentOpenUser(map));
		}

		return orgList;
	}

	 /**
	 * 게시판 공개 유저 리스트
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public List<Map> getBoardContentOpenUser(Map<String, Object> map) throws Exception{

		return boardDAO.getBoardContentOpenUser(map);
	}

	 /**
	 * 게시판 승인자 저장
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public int doSaveOrgSetup(Map<String, Object> map) throws Exception{

		int cnt =0;

		boardDAO.deleteOrgSetup(map);			//해당 org 삭제

		String userListStr = map.get("userListStr").toString();

		if(!userListStr.equals("")){
			TypeReference<List<Map>> mapType = new TypeReference<List<Map>>() {};
		 	List<Map> userList = new ObjectMapper().readValue(userListStr, mapType);
		 	map.put("userList",userList);

			cnt = boardDAO.insertOrgSetup(map);
		}
		return cnt;

	}

	 /**
	 * 승인 반송처리
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 23.
	 */
	public void saveApprove(Map<String, Object> map) throws Exception{

		String contentIdArr = (map.containsKey("contentIdArr") ? map.get("contentIdArr").toString() : "");
		String approveStatus = map.get("approveStatus").toString();
		String approveNote = (map.get("approveNote").equals("") ? (approveStatus.equals("APPROVE") ? "승인" : "반송")+" 되었습니다." : map.get("approveNote").toString());

		map.put("approveNote", approveNote);

		if(!contentIdArr.equals("")){
			String [] arr = contentIdArr.split(",");

			for(int i=0; i<arr.length; i++){
				map.put("contentId", arr[i]);
				map.put("approveStatus", approveStatus);
				boardDAO.saveApprove(map);
			}
		}else{

			boardDAO.saveApprove(map);
		}

	}

	/**
	 * 관계사 타겟 및 직원 삭제
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 23.
	 */
	public void deleteOpenOrgWithTarget(Map<String, Object> map) throws Exception{

		boardDAO.deleteBoardOpenTarget(map);
		boardDAO.deleteBoardOpenOrg(map);

	}

	/**
	 * 타겟목록 저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 23.
	 */
	public void insertTargetOrg(Map<String, Object> map) throws Exception {

		String selectOrgInfoListStr = map.get("selectOrgInfoList").toString();

		if(!selectOrgInfoListStr.equals("")){
			Gson gson = new Gson();
			ArrayList <Map> selectOrgInfoList =null;
			selectOrgInfoList = gson.fromJson(selectOrgInfoListStr, java.util.ArrayList.class);

			for(int i=0; i<selectOrgInfoList.size(); i++){

				Map paramMap = new HashMap(selectOrgInfoList.get(i));
				paramMap.put("contentId", map.get("contentId").toString());
				paramMap.put("userId", map.get("userId").toString());

				//타겟 저장
				int cboardOpenOrgId = boardDAO.insertBoardOpenOrg(paramMap);

				//target 직원 저장
				if(!paramMap.get("openTargetOrg").toString().equals("ALL")
						&& !paramMap.get("targetList").toString().equals("")){

					String targetStr =paramMap.get("targetList").toString();
					String [] targetArr = targetStr.split(",");

					paramMap.put("targetArr", targetArr);
					boardDAO.insertBoardOpenTarget(paramMap);
				}


			}

		}


	}

	/**
	 * 공개기간수정
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 24.
	 */
	public void editOpenPeriod(Map<String, Object> map) throws Exception{
		boardDAO.editOpenPeriod(map);
	}


}