package ib.work.service;

import java.util.List;
import java.util.Map;


/**
 * <pre>
 * package	: ib.work.service
 * filename	: WorkMemoService.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2016. 4. 15.
 * @version :
 *
 */
public interface WorkMemoService {


	//메모리스트
	Map<String, Object> getMemoList(Map<String, Object> map) throws Exception;

	//메모 상세
	List<Map> getMemoDetail(Map<String, String> map) throws Exception;

	//메모 읽음 상태 업데이트
	int updateMemoStatus(Map<String, Object> map) throws Exception;


	//메모 참여자 수신 확인 정보
	List<Map> getMemoRecvInfo(Map<String, String> map) throws Exception;

	//메모 재발송
	int memoResend(Map<String, Object> map) throws Exception;


	/*신규 구현*/

	//메모 룸 생성 및 수정
	int saveMemoRoom(Map<String, Object> map) throws Exception;

	//메모 룸 정보
	List<Map> getRoomInfo(Map<String, Object> map) throws Exception;

	//메모 룸 참여자 정보
	List<Map> getRoomEntryList(Map<String, Object> map) throws Exception;

	//메모 룸 글 리스트 (화면표시)
	List<Map> getRoomMemoList(Map<String, Object> map) throws Exception;

	//메모 참가자 등록 및 수정
	int saveRoomEntry(Map<String, Object> map) throws Exception;

	//메모  등록 및 수정
	int saveMemoComment(Map<String, Object> map) throws Exception;

	//읽음확인
	void updateLastReadDate(Map<String, Object> map) throws Exception;

	//메모고정여부 업데이트
	void updateMemoFixedYn(Map<String, Object> map) throws Exception;

	//메모 정보
	List<Map> getCommentInfo(Map<String, Object> map) throws Exception;

	//메모  삭제
	int deleteComment(Map<String, Object> map) throws Exception;

	//메모  첫글 삭제
	int doDeleteFirstComment(Map<String, Object> map) throws Exception;

	//업무일지 메모 조회
	List<Map> getRoomList(Map<String, Object> map) throws Exception;
	
	 /**
	 *  메모 자동 발송
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 18.
	 */
	
	int autoMemoSend(Map<String, Object>map) throws Exception;


}
