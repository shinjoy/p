package ib.work.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import ib.common.util.DateUtil;
import ib.file.service.FileService;
import ib.work.service.WorkMemoService;
import ib.work.service.WorkVO;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("workMemoService")
public class WorkMemoServiceImpl extends AbstractServiceImpl implements WorkMemoService {

    @Resource(name="workMemoDAO")
    private WorkMemoDAO workMemoDAO;

    @Resource(name = "workDAO")
    private WorkDAO workDAO;

	@Resource(name = "fileService")
	private FileService fileService;

    protected static final Log logger = LogFactory.getLog(WorkMemoServiceImpl.class);




	//메모리스트
	public Map<String, Object> getMemoList(Map<String, Object> param) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		//parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());

		map.put("pageNo", param.get("pageNo"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.

		int totalCount = workMemoDAO.getMemoListCount(param);				//총 건수
		map.put("totalCount", totalCount);

		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;		//총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를 (+1)여부결정
		map.put("pageCount", pageCount);										//총 페이지수

		param.put("offset", (pageNo-1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize

		map.put("list", workMemoDAO.getMemoList(param));				//목록리스트

		return map;		//Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총 페이지수), list(리스트)

	}


	//메모 상세
	public List<Map> getMemoDetail(Map<String, String> map) throws Exception {

		return workMemoDAO.getMemoDetail(map);
	}


	//메모 읽음 상태 업데이트
	public int updateMemoStatus(Map<String, Object> map) throws Exception {

		int upCnt = 0;

		if("0".equals(map.get("mainSnb").toString())){		//최초작성자가 나
			upCnt = workMemoDAO.updateMemoReplyStatus(map);	//ib_reply 를 모두 바꿈으로 상태 저장

		}else{												//최초작성자가 다른이
			upCnt = workMemoDAO.updateMemoMainStatus(map);	//ib_comment 에 상태 저장

		}

		return upCnt;
	}



	//메모 참여자 수신 확인 정보
	public List<Map> getMemoRecvInfo(Map<String, String> map) throws Exception {

		return workMemoDAO.getMemoRecvInfo(map);
	}

	//메모 재발송
	public int memoResend(Map<String, Object> map) throws Exception {

		int upCnt = 0;


		//main 등록
		int mainSnb = workMemoDAO.cloneResendMemoMain(map);
		map.put("mainSnb", mainSnb + "");
		//sub 등록
		upCnt = workMemoDAO.cloneResendMemoSub(map);

		//파일 등록
		map.put("offerSnb", mainSnb + "");	//새로운 메모 키
		workMemoDAO.cloneResendFile(map);


		return upCnt;
	}

	/*신규 구현*/

	//메모 룸 생성 및 수정
	public int saveMemoRoom(Map<String, Object> map) throws Exception {
		int memoRoomId = Integer.parseInt(map.get("memoRoomId").toString());

		if(memoRoomId == 0){	//새로운 방생성

			memoRoomId = workMemoDAO.insertMemoRoom(map);

		}else{				//방 수정
			workMemoDAO.updateMemoRoom(map);
		}


		return memoRoomId;
	}

	//메모 룸 정보
	public List<Map> getRoomInfo(Map<String, Object> map) throws Exception{

		return workMemoDAO.getRoomInfo(map);

	}

	//메모 룸 참가자 정보
	public List<Map> getRoomEntryList(Map<String, Object> map) throws Exception{


		return workMemoDAO.getRoomEntryList(map);

	}

	//메모 참가자 등록 및 수정
	public int saveRoomEntry(Map<String, Object> map) throws Exception {
		int memoRoomId = Integer.parseInt(map.get("memoRoomId").toString());

		String entryStr = map.get("entryUserList").toString();
		String deleteStr = map.get("deleteUserList").toString();

		String [] entryUserList = (entryStr =="" ?  null : entryStr.split(","));	//신규 리스트 파라미터(userId)
		String [] deleteUserList =(deleteStr =="" ? null : deleteStr.split(","));   //삭제 리스트 파라미터(memoRoomEntryId)

		if(entryUserList != null){
			for(int i=0;i<entryUserList.length;i++){
				HashMap param = new HashMap();
				param.put("deleteFlag", "N");
				param.put("memoRoomId", memoRoomId);
				param.put("entryUserId", entryUserList[i]);
				param.put("userId",  map.get("userId"));
				workMemoDAO.insertRoomEntry(param);

			}
		}

		if(deleteUserList != null){
			for(int i=0;i<deleteUserList.length;i++){
				HashMap param = new HashMap();
				param.put("deleteFlag", "Y");
				param.put("memoRoomEntryId", deleteUserList[i]);
				param.put("userId",  map.get("userId"));
				workMemoDAO.deleteRoomEntry(param);
			}
		}

		return memoRoomId;
	}

	//메모 저장 및 수정
	public int saveMemoComment(Map<String, Object> map) throws Exception{
		int memoCommentId = Integer.parseInt(map.get("memoCommentId").toString());
		int chk =0;

		map.put("usrSeq",map.get("userId"));
		if(memoCommentId == 0){	//글 신규등록

			memoCommentId = workMemoDAO.insertMemoComment(map);

		}else{					//글 수정
			workMemoDAO.updateMemoComment(map);

			if(!map.get("delFileList").toString().equals("")){		//정상저장 이고 파일이 있을때
   			 String [] arr = map.get("delFileList").toString().split(",");
   			 map.put("fileArr", arr);
   			 fileService.updateDelFlag(map);						//파일 db저장 된거 삭제
			}
		}

		if(memoCommentId!=0 && !map.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때

			map.put("uploadId",memoCommentId);
    		chk = fileService.insertFileListJson(map);				//파일 db저장
    		if(chk==0) memoCommentId = 0;
		}

		//메모 커멘트 수정/등록시 메모 방 COMMENT_UPDATE_DATE 수정
		workMemoDAO.updateMemoRoomForComment(map);

		return memoCommentId;
	}

	//메모 룸 글리스트
	public List<Map> getRoomMemoList(Map<String, Object> map) throws Exception{

		return workMemoDAO.getRoomMemoList(map);
	}

	//읽음 확인 업데이트
	public void updateLastReadDate(Map<String, Object> map) throws Exception{

		workMemoDAO.updateLastReadDate(map);
	}

	//메모고정여부 업데이트
	public void updateMemoFixedYn(Map<String, Object> map) throws Exception{
		workMemoDAO.updateMemoFixedYn(map);
	}

	//메모정보
	public List<Map> getCommentInfo(Map<String, Object> map) throws Exception{

		return workMemoDAO.getCommentInfo(map);
	}

	//메모삭제
	public int deleteComment(Map<String, Object> map) throws Exception{
		int seq = Integer.parseInt(map.get("memoCommentId").toString());

    	try{
    		//게시글 상태값 바꾸고
    		workMemoDAO.deleteCommentDelFlag(map);
        	//본글 파일 지우고
        	fileService.updateDelFlag(map);

    	}catch(Exception e){
    		seq = -1;
    		e.getMessage();
    	}
    	return seq;

	}

	//메모  첫글 삭제
	public	int doDeleteFirstComment(Map<String, Object> map) throws Exception{

		int readCount = workMemoDAO.getMemoReadCount(map);

		System.out.println(readCount);

		if(readCount == 0){
			//게시글 상태값 바꾸고
    		workMemoDAO.deleteCommentDelFlag(map);
    		//게시글 상태값 바꾸고
    		workMemoDAO.deleteEntryDelFlag(map);
    		//룸을 지운다
    		workMemoDAO.deleteMemoRoom(map);
      }

		return readCount;
	}

	//업무일지 메모 조회
	public List<Map> getRoomList(Map<String, Object> map) throws Exception{

		return workMemoDAO.getRoomList(map);
	}
	
	 /**
	 *  메모 자동 발송
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 18.
	 */
	
	public int autoMemoSend(Map<String, Object>map) throws Exception{
		
		
		/*
  		 * comment		    :  메모내용 (필수)	
  		
  		 * 
  		 * orgId			:  orgId (필수)	
  		 * userId			:  등록자 userId (필수)	
  		 * 
  		 * entryUserList	   :  entryUserList.userId (참가자 아이디) 빈값 전직원한테 보냄
  		 * 
  		*/
		
		
		map.put("roomType", "N");
		map.put("important", "0");
		map.put("viewDate", new SimpleDateFormat("yyyy-MM-dd" , Locale.getDefault()).format(Calendar.getInstance().getTime()));
		
		List entryUserList = (List) map.get("entryUserList");
		
		//방을 만들고
		int memoRoomId = workMemoDAO.insertMemoRoom(map);
		
		map.put("memoRoomId", memoRoomId);
		
		//직원을 넣고
		if(entryUserList.size() == 0){		//전직원
			
			map.put("entryUserList", "");
			
		}
		map.put("deleteFlag", "N");
		
		workMemoDAO.insertRoomEntryAll(map);
		
		//메모를 발송한다.
		int memoCommentId = workMemoDAO.insertMemoComment(map);
		
		return memoCommentId;
	}





}
