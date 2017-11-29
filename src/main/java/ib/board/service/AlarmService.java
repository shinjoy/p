package ib.board.service;


import java.util.List;
import java.util.Map;

public interface AlarmService {

	public Map<String, Object> getAlarmBoardList(Map param) throws Exception;

	public Map<String, Object> getAlarmUserList(Map<String, Object> map) throws Exception;



	/**
	 * 알림 상세
	 * @param
	 * @return List
	 */
	public List<Map> getAlarmDetail(Map<String, Object> map)throws Exception;

 	/**
	 * 알람관계사목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 08.
	 */
	public List<Map> getAlarmListOrg(Map<String, Object> map)throws Exception;

	/**
	 * 알림 저장
	 * @param
	 * @return
	 */
	public int saveAlarm(Map<String, Object> map)throws Exception;
	/**
	 * 알림 삭제
	 * @param
	 * @return Map
	 */
	public void deleteAlarm(Map<String, Object> map)throws Exception;
	/**
	 * 알림 팝업 정보 반환
	 * @param
	 * @return Map
	 */
	public Map selectPopupInfo(Map<String, Object> map) throws Exception;

	/**
	 * 알림 팝업창 조건에 부합하는지 확인
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectPopUser(Map<String, Object> map) throws Exception;

	/**
	 * 알림 팝업창 아이디 리스트 반환.
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectPopupIds() throws Exception;

	/**
	 * target 테이블에 저장. (보낼사람)
	 * @param
	 * @return
	 */
	public void insertTarget(Map<String, Object> map)throws Exception;

	/**
	 * target리스트
	 * @param
	 * @return
	 */
	public List<Map> getAlarmTargetList(Map<String, Object> map)throws Exception;

	/**
	 * 알림 공지대상자 리스트 반환
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map selectAlarmUsers(Map<String, Object> param) throws Exception;

	/**
	 * 소속 부서 리스트 반환
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectDeptList(Map<String, Object> param) throws Exception;

}
