package ib.work.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * package  : ib.work.service.impl
 * filename : WorkDAO.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 28.
 * @version : 1.0.0
 */
@Repository("workMemoDAO")
public class WorkMemoDAO extends ComAbstractDAO{




	/**
	 * 메모 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 15.
	 */
	public List<Map> getMemoList(Map<String, Object> param) throws Exception{

		return list("work.selectMemoList", param);
	}


	/**
	 * 메모 건수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 15.
	 */
	public int getMemoListCount(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("work.selectMemoListCount", param).toString());
	}



	/**
	 * 메모 상세
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 18.
	 */
	public List<Map> getMemoDetail(Map<String, String> map) throws Exception{
		return list("work.selectMemoDetail", map);
	}



	/**
	 * 메모 읽음 상태 업데이트		ib_comment
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 20.
	 */
	public int updateMemoMainStatus(Map<String, Object> map) throws Exception{

		return update("work.updateMemoMainStatus", map);
	}


	/**
	 * 메모 읽음 상태 업데이트		ib_reply
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 20.
	 */
	public int updateMemoReplyStatus(Map<String, Object> map) throws Exception{

		return update("work.updateMemoReplyStatus", map);
	}



	/**
	 * 메모 참여자 수신 확인 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 22.
	 */
	public List<Map> getMemoRecvInfo(Map<String, String> map) {
		return list("work.selectMemoRecvInfo", map);
	}

	/**
	 * 메모 재전송 (메인 데이터)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 5. 16.
	 */
	public int cloneResendMemoMain(Map<String, Object> map) {
		return Integer.parseInt(insert("work.cloneResendMemoMain", map).toString());
	}



	/**
	 * 메모 재전송 (서브 데이터)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 5. 16.
	 */
	public int cloneResendMemoSub(Map<String, Object> map) {

		return update("work.cloneResendMemoSub", map);
	}


	/**
	 * 메모 파일 재전송
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 5. 17.
	 */
	public void cloneResendFile(Map<String, Object> map) {

		update("work.cloneResendFile", map);
	}


	/**
	 * 추천종목 >> 제안중딜 등록 파일카피등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 5. 24.
	 */
	public void clonePropDealFile(Map<String, Object> map) {

		update("work.clonePropDealFile", map);
	}

	/*신규 구현*/


	/**
	 * 메모 룸 생성
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int insertMemoRoom(Map<String, Object> map) {
		return Integer.parseInt(insert("workDaily.insertMemoRoom", map).toString());
	}

	/**
	 * 메모 룸 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getRoomInfo(Map<String, Object> map) {

		return list("workDaily.getRoomInfo", map);
	}

	/**
	 * 메모 참여자 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getRoomEntryList(Map<String, Object> map) {

		return list("workDaily.getRoomEntryList", map);
	}

	/**
	 * 메모 룸 글리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getRoomMemoList(Map<String, Object> map) {

		return list("workDaily.getRoomMemoList", map);
	}

	/**
	 * 메모 룸 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void updateMemoRoom(Map<String, Object> map) {
		update("workDaily.updateMemoRoom", map);
	}

	/**
	 * 메모 참가자 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int insertRoomEntry(Map<String, Object> map) {
		return Integer.parseInt(insert("workDaily.insertRoomEntry", map).toString());
	}

	/**
	 * 메모 참가자 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void deleteRoomEntry(Map<String, Object> map) {
		update("workDaily.deleteRoomEntry", map);
	}

	/**
	 * 메모 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int insertMemoComment(Map<String, Object> map) {
		return Integer.parseInt(insert("workDaily.insertMemoComment", map).toString());
	}

	/**
	 * 메모 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void updateMemoComment(Map<String, Object> map) {
		update("workDaily.updateMemoComment", map);
	}

	/**
	 * 메모 읽음 확인 업데이트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void updateLastReadDate(Map<String, Object> map) {
		update("workDaily.updateLastReadDate", map);
	}

	/**
	 * 메모고정여부 업데이트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void updateMemoFixedYn(Map<String, Object> map) {
		update("workDaily.updateMemoFixedYn", map);
	}

	/**
	 * 메모 글 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getCommentInfo(Map<String, Object> map) {
		return list("workDaily.getCommentInfo", map);
	}

	/**
	 * 메모 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void deleteCommentDelFlag(Map<String, Object> map) {
		delete("workDaily.deleteCommentDelFlag", map);
	}

	/**
	 * 업무일지 메모 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */

	public List<Map> getRoomList(Map<String, Object> map) {

		return list("workDaily.getRoomList", map);

	}

	/**
	 * 메모 읽은 사람 count
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 11. 21.
	 */
	public int getMemoReadCount(Map<String, Object> map) throws Exception{
		return	Integer.parseInt(selectByPk("workDaily.getMemoReadCount", map).toString());

	}

	/**
	 * 메모 참여자 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void deleteEntryDelFlag(Map<String, Object> map) {
		 delete("workDaily.deleteEntryDelFlag", map);
	}

	/**
	 * 메모 방삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void deleteMemoRoom(Map<String, Object> map) {
		delete("workDaily.deleteMemoRoom", map);
	}

	/**
	 * 메모 등록 대표 ID 가져오기
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: inhee
	 * @date		: 2017. 04. 04.
	 */
	public int getUserIdOfAdmin(Map<String, Object> map) throws Exception{
		return	Integer.parseInt(selectByPk("workDaily.getUserIdOfAdmin", map).toString());

	}

	/**
	 * 메모 커멘트 수정/등록시 메모 방 COMMENT_UPDATE_DATE 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: inhee
	 * @date		: 2017. 7. 17.
	 */
	public void updateMemoRoomForComment(Map<String, Object> map) {
		update("workDaily.updateMemoRoomForComment", map);
	}
	
	/**
	 * 메모 참가자 List 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: inhee
	 * @date		: 2017. 7. 17.
	 */
	public int insertRoomEntryAll(Map<String, Object> map) {
		
		return Integer.parseInt(insert("workDaily.insertRoomEntryAll", map).toString());
	}



}