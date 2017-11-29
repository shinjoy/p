package ib.schedule.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.schedule.service.impl.ScheduleVO;

public interface ScheduleService {

	String getCalNextYear() throws Exception;													// 등록된 달력 최대연도 불러오기

	@SuppressWarnings("rawtypes")
	List getCarList(ScheduleVO vo) throws Exception;											// 선택시간 차량 리스트 받아오기
	@SuppressWarnings("rawtypes")
	List getCarUseList(ScheduleVO vo) throws Exception;											// 선택일자 차량 사용 리스트 받아오기

	// 일정 리스트 받아오기
	@SuppressWarnings("rawtypes")
	List getScheduleList(ScheduleVO vo) throws Exception;

	// 휴일 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getHolidayList(ScheduleVO vo) throws Exception ;

	// 선택 일정 정보 받아오기
	ScheduleVO getScheInfo(ScheduleVO vo) throws Exception;

	// 선택 일정 참가자 리스트 받아오기
	@SuppressWarnings("rawtypes")
	List getScheduleEntryList(ScheduleVO vo) throws Exception;

	void scheduleChkEnd(ScheduleVO vo) throws Exception;										// 선택 일정 완료 처리
	String getScheSeq() throws Exception;														// 일정 등록을 위한 일정시퀀스 받아오기

	// 일정 일괄 등록 완료
	@SuppressWarnings("rawtypes")
	void scheduleAllAddEnd(HttpServletRequest req, ScheduleVO vo, List list) throws Exception;

	// 일정 등록 완료
	void scheduleAddEnd(HttpServletRequest req, ScheduleVO vo) throws Exception;

	@SuppressWarnings("rawtypes")
	List getRepetScheduleList(ScheduleVO vo) throws Exception;									// 선택된 반복 일정 리스트 받아오기
	void scheduleEditEnd(HttpServletRequest req, ScheduleVO vo) throws Exception;				// 일정 수정 완료

	void scheduleDelEnd(ScheduleVO vo) throws Exception;										// 일정 삭제 완료

	void scheduleDelEndByGrpCd(ScheduleVO vo) throws Exception;							// 일정 삭제 완료(반복일정그룹코드)

	//업무일지 - 일정정보
	List<Map> getScheduleWork(Map<String, Object> map) throws Exception;

	/**
	 * 메인화면 직원근태현황
	 * @param List
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public List<EgovMap> getPresentEmpInfoList(Map<String, Object> map) throws Exception;

	/**
	 * 메인 현지출근 알람 팝업 목록
	 * @param List
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public List<EgovMap> getMainSpotWorkAlarmList(Map<String, Object> map) throws Exception;


	/**
	 * 메인화면 임원현황
	 * @param List
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public List<EgovMap> getExecEmpInfoList(Map<String, Object> map) throws Exception;

	/**
	* 네트워크 > 고객의 상세정보중 최근미팅 이력정보
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getCustomerMeetList(Map<String, Object> map) throws Exception;

	//일정 SMS 전송(스케줄)
	public void sendSmsScheduleBatch(Map<String,Object> paramMap) throws Exception;

	public EgovMap getChkWorktiemEndYn(Map<String, Object> map, List<Map<String, Object>> scheList) throws Exception;

	public EgovMap getChkVacationYn(Map<String, Object> map, List<Map<String, Object>> scheList) throws Exception;

	public EgovMap moveDateForSchedule(Map<String, Object> map) throws Exception;

}