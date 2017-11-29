package ib.board.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("alarmDAO")
public class AlarmDAO extends ComAbstractDAO {

	// 알림리스트
	@SuppressWarnings("unchecked")
	public List<Map> getAlarmList(Map<String, Object> map) throws Exception {
		return list("alarm.getAlarmList", map);
	}

	/**
	 * 알람관계사목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 08.
	 */
	@SuppressWarnings("unchecked")
	public List<Map> getAlarmListOrg(Map<String, Object> map) throws Exception {
		return list("alarm.getAlarmListOrg", map);
	}


	//알림 리스트 총 갯수
	public int getAlarmListCnt(Map<String,Object> map) throws Exception{
		return Integer.parseInt(selectByPk("alarm.getAlarmListCnt", map)
				.toString());
	}

	// 알림등록시 사원리스트 반환
	@SuppressWarnings("unchecked")
	public List<Map> getAlarmPersonList(Map<String, Object> map) throws Exception {
		return list("alarm.getAlarmPersonList", map);
	}

	// 알림등록시 회사리스트 반환
	@SuppressWarnings("unchecked")
	public List<Map> getAlarmDivisionList(Map<String, Object> map) throws Exception {
		return list("alarm.getAlarmDivisionList", map);
	}

	// 알림등록시 부서리스트 반환
	@SuppressWarnings("unchecked")
	public List<Map> getAlarmDeptList(Map<String, Object> map) throws Exception {
		return list("alarm.getAlarmDeptList", map);
	}

	// 타겟 유저 등록
	public void insertAlarmTarget(Map param) throws Exception {
		insert("alarm.insertAlarmTarget", param);
	}

	/**
	 * 알람 관계사 목록 지우기
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 07.
	 */
	public void deleteAlarmOrg(Map param) throws Exception {
		delete("alarm.deleteAlarmOrg", param);
	}

	/**
	 * 알람 관계사 목록 저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 07.
	 */
	public Integer insertAlarmOrg(Map<String, Object> param) throws Exception {
		return Integer.parseInt(insert("alarm.insertAlarmOrg", param).toString());
	}

	// 타겟 유저 삭제
	public void deleteAlarmTarget(Map param) throws Exception {
		delete("alarm.deleteAlarmTarget", param);
	}

	// 알림 등록
	public String insertAlarm(Map param) throws Exception {
		return (String) insert("alarm.insertAlarm", param);
	}

	// 알림 수정
	public void updateAlarm(Map param) throws Exception {
		update("alarm.updateAlarm", param);
	}

	// 알림 삭제 (이긴하나 날짜만 변경함.)
	public void deleteAlarm(Map param) throws Exception {
		update("alarm.deleteAlarm", param);
	}

	/**
	 * 알림 팝업창 조건 체크
	 *
	 * @param Map
	 *            <String, Object> 로그인아이디,사번
	 * @return 사용자 정보 반환
	 * @throws Exception
	 */
	public Map selectPopUser(Map<String, Object> map) throws Exception {
		return (Map) getSqlMapClientTemplate().queryForObject("alarm.selectPopUser", map);
	}

	/**
	 * 알림 팝업창 아이디 리스트 반환.
	 *
	 * @return 알림 팝업창 기준 아이디 값 리스트
	 * @throws Exception
	 */
	public List<Map> selectPopupIds() throws Exception {
		return list("alarm.selectPopupIds", null);
	}

	/**
	 * 알림 팝업창 정보 반환
	 *
	 * @param alarmVO 아이디 값
	 * @return 알림 팝업 정보
	 * @throws Exception
	 */
	public Map selectPopupInfo(Map param) throws Exception {
		return (Map) getSqlMapClientTemplate().queryForObject(
				"alarm.selectPopupInfo", param);
	}

	// 타겟 유저 리스트
	public List<Map> getAlarmTargetList(Map param)
			throws Exception {
		return list("alarm.getAlarmTargetList", param);
	}

	/**
	 * 알림 공지대상자 리스트 반환
	 *
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectAlarmUsers(Map<String, Object> map) throws Exception {
		return list("alarm.selectAlarmUsers", map);
	}

	/**
	 * 알림 공지대상자 리스트 총 갯수 반환
	 *
	 * @param param
	 * @return
	 */
	public int selectAlarmUsersCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return Integer.parseInt(selectByPk("alarm.selectAlarmUsersCount", map)
				.toString());
	}

	/**
	 * 소속 부서리스트 반환
	 *
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectDeptList(Map<String, Object> map) throws Exception {
		return list("alarm.selectDeptList", map);
	}

}
