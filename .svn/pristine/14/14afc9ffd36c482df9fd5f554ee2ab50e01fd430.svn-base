package ib.gboard.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.board.service.impl.BoardDAO;
import ib.file.service.FileService;
import ib.gboard.service.GboardService;
import ib.schedule.service.ScheduleService;


@Service("gBoardService")
public class GboardServiceImpl extends AbstractServiceImpl implements GboardService {

	@Resource(name="gBoardDAO")
	private GboardDAO gBoardDAO;

	@Resource(name = "scheService")
	private ScheduleService scheService;

	@Resource(name = "fileService")
	private FileService fileService;

	/*================================신규 게시판 구현==========================*/
	//일반게시판 그룹 목록
	public List<EgovMap> getGboardGoupMapList(Map<String,Object> paramMap) throws Exception{
		return gBoardDAO.getGboardGoupMapList(paramMap);
	}

	public Map<String, Object> getBoardContentList(Map<String, Object> param) throws Exception {

    	Map<String, Object> map = new HashMap<String, Object>();

		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());


		int totalCount = gBoardDAO.getBoardContentList(param).size();

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

		List<Map> resultList = gBoardDAO.getBoardContentList(param);

		//게시판의 글쓰기 권한을 조회한다.
		String writerType = gBoardDAO.getBoardWriteType(param);
		map.put("writerType", writerType);
    	map.put("list", resultList);


    	return map;
    }
	//게시판 조회수 올리기
    public int updateViewCount(Map<String, Object> map) throws Exception{

    	int chk =0;
    	List<Map>list = gBoardDAO.getBoardContent(map);
    	if(list != null){
    		int viewCount = Integer.parseInt(list.get(0).get("hit").toString());
    		map.put("viewCount", viewCount+1);
    		gBoardDAO.updateViewCount(map);
    		chk =1;
    	}
    	return chk;
    }
  //게시판 글 등록 및 수정
    public int saveBoardContent(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("contentId").toString());
    	int chk =0;
    	if(seq==0){														//등록
    		seq = gBoardDAO.insertBoardContent(param);

    	}else{															//수정
    		gBoardDAO.updateBoardContent(param);

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
    //게시판 다음글 이전글 정보
    public Map<String, Object> getBoardContentPrevNext(Map<String, Object> param) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();

    	param.put("searchType", "prev");
    	map.put("prev", gBoardDAO.getBoardContentPrev(param));

    	param.put("searchType", "next");
    	map.put("next", gBoardDAO.getBoardContentPrev(param));

    	return map;
    }
    //게시판 삭제
    public int deleteContent(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("contentId").toString());

    	try{
    		//게시글 상태값 바꾸고
        	gBoardDAO.updateBoardContentDelFlag(param);
        	//본글 파일 지우고
        	fileService.updateDelFlag(param);
        	//댓글 상태값 바꾸고

        	//댓글에 파일 상태값 바꾸고

        	//댓글에 파일지우고


    	}catch(Exception e){
    		seq = -1;
    		e.getMessage();
    	}
    	return seq;
    }
    //게시판 댓글 리스트
    public List<Map> getBoardCommentList(Map<String, Object> map) throws Exception{


    	List<Map>resultList = new ArrayList();
    	List<Map>list = gBoardDAO.getBoardCommentList(map);
    	for(int i=0;i<list.size();i++){
    		Map resultMap = new HashMap();
    		Map param = new HashMap();
    		param.put("uploadId", list.get(i).get("commentId"));
    		param.put("uploadType", "GBOARD_COMMENT");
    		resultMap.put("commentList", list.get(i));
    		resultMap.put("fileList", fileService.getFileList(param));
    		resultList.add(i, resultMap);
    	}

    	return resultList;
    }


	//게시판 그룹 리스트
	public List<Map> getGboardGoupList(Map<String, Object> map) throws Exception{
		return gBoardDAO.getGboardGoupList(map);
	}


    //게시판 글정보
    public List<Map> getBoardContent(Map<String, Object> param) throws Exception {
    	//user열람 정보를 저장
    	gBoardDAO.updateReadUserId(param);
    	return gBoardDAO.getBoardContent(param);

    }
    //게시판 댓글 등록 및 수정
    public int saveBoardComment(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("commentId").toString());
    	int chk =0;
    	if(seq==0){														//등록
    		seq = gBoardDAO.insertBoardComment(param);

    	}else{															//수정
    		gBoardDAO.updateBoardComment(param);

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

    //게시판 댓글 삭제
    public int deleteComment(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("commentId").toString());

    	try{
    		//게시글 상태값 바꾸고
        	gBoardDAO.updateBoardCommentDelFlag(param);
        	//본글 파일 지우고
        	fileService.updateDelFlag(param);

        }catch(Exception e){
    		seq = -1;
    		e.getMessage();
    	}
    	return seq;
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
  			gBoardDAO.updateReadUserId(map);
  		}

  		return cnt;
  	}

    /**************************************************************************************************
	 * 관리자 화면
	 **************************************************************************************************/

  //게시판 그룹 리스트
  	public Map<String, Object> getBoardGroupList(Map<String, Object> param) throws Exception{

  		Map<String, Object> map = new HashMap<String, Object>();

  		List<Map<String,String>> resultList = gBoardDAO.getBoardGroupList(param);
  		int totalCount = resultList.size();

  		map.put("totalCount", totalCount);
  		map.put("list", resultList);

  		return map;
  	}

  	//그룹안에 카테고리 리스트 ( 및 상세정보)
      public List<Map> getBoardCateList(Map<String, Object> map) throws Exception {
      	return gBoardDAO.getBoardCateList(map);
      }

      //그룹 등록 및 수정
      public String saveBoardGroup(Map<String, Object> map) throws Exception {
      	String chk="0";

      	//신규등록
      	if(map.get("groupId").toString().equals("0")){
      		chk=gBoardDAO.insertBoardGroup(map);
      	}else{//수정
      		chk = map.get("groupId").toString();
      		gBoardDAO.updateBoardGroup(map);
      	}
      	return chk;
      }

      //카테고리 등록 및 수정
      public String saveBoardCate(Map<String, Object> map) throws Exception{
      	String gboardId="0";

      	//신규등록
      	if(map.get("gboardId").toString().equals("0")){
      		gboardId=gBoardDAO.insertBoardCate(map);
      		map.put("gboardId", map.get("gboardId").toString());
      	}else{//수정
      		gboardId = map.get("gboardId").toString();
      		gBoardDAO.updateBoardCate(map);
      	}

      	String writerType = map.get("writerType").toString();
      	if("ALL".equals(writerType)){
      		gBoardDAO.deleteGboardWriter(map);
      	}else if("DEPT".equals(writerType)){
      		/*map.put("writerDeptId", map.get("arrDeptId").toString());
      		gBoardDAO.deleteGboardWriter(map);
      		gBoardDAO.insertGboardWriter(map);*/
      		///////
      		String[] arrDeptId = map.get("arrDeptId").toString().split(",");
      		gBoardDAO.deleteGboardWriter(map);

      		for(String writerDeptId : arrDeptId){
      			map.put("writerDeptId", writerDeptId);
      			gBoardDAO.insertGboardWriter(map);
      		}

      	}else if("USER".equals(writerType)){
      		String[] arrUserId = map.get("arrUserId").toString().split(",");
      		gBoardDAO.deleteGboardWriter(map);

      		for(String writerUserId : arrUserId){
      			map.put("writerUserId", writerUserId);
      			gBoardDAO.insertGboardWriter(map);
      		}
      	}

      	String readType = map.get("readType").toString();
      	if("ALL".equals(readType)){
      		gBoardDAO.deleteGboardRead(map);
      	}else if("DEPT".equals(readType)){
      		/*map.put("readDeptId", map.get("arrReadDeptId").toString());
      		gBoardDAO.deleteGboardRead(map);
      		gBoardDAO.insertGboardRead(map);*/

      		String[] arrReadDeptId = map.get("arrReadDeptId").toString().split(",");
      		gBoardDAO.deleteGboardRead(map);

      		for(String readDeptId : arrReadDeptId){
      			map.put("readDeptId", readDeptId);
      			gBoardDAO.insertGboardRead(map);
      		}

      	}else if("USER".equals(readType)){
      		String[] arrReadUserId = map.get("arrReadUserId").toString().split(",");
      		gBoardDAO.deleteGboardRead(map);

      		for(String readUserId : arrReadUserId){
      			map.put("readUserId", readUserId);
      			gBoardDAO.insertGboardRead(map);
      		}
      	}

      	return gboardId;
      }

      //일반게시판쓰기권한자 목록
      public List<Map> getGboardWriterList(Map<String, Object> map) throws Exception {
      	return gBoardDAO.getGboardWriterList(map);
      }
      //일반게시판읽기권한자 목록
      public List<Map> getGboardReaderList(Map<String, Object> map) throws Exception {
      	return gBoardDAO.getGboardReaderList(map);
      }


}