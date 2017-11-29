package ib.schedule.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.cmm.service.impl.ComAbstractDAO;
import ib.schedule.service.SpCmmVO;


@Repository("scheduleDAO")
public class ScheduleDAO extends ComAbstractDAO {
	// 달력 생성을 위한 년도 불러오기
	public String getCalNextYear() throws Exception {
		return (String)selectByPk("scheduleDAO.GetCalNextYear", "");
	}


	// 선택시간 차량 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getCarList(ScheduleVO vo) throws Exception {
		return list("scheduleDAO.GetCarList", vo);
	}

	// 선택일자 차량 사용 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getCarUseList(ScheduleVO vo) throws Exception {
		return list("scheduleDAO.GetCarUseList", vo);
	}

	// 일정 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getScheduleList(ScheduleVO vo) throws Exception {
		return list("scheduleDAO.getScheduleList", vo);
	}

	// 휴일 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getHolidayList(ScheduleVO vo) throws Exception {
		return list("scheduleDAO.getHolidayList", vo);
	}

	// 선택 일정 정보 받아오기
	public ScheduleVO getScheInfo(ScheduleVO vo) throws Exception {
		return (ScheduleVO)selectByPk("scheduleDAO.GetScheInfo", vo);
	}

	// 선택일정 참가자 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getScheduleEntryList(ScheduleVO vo) throws Exception {
		return list("scheduleDAO.GetScheduleEntryList", vo);
	}

	// 선택 일정 완료 처리
	public void scheduleChkEnd(ScheduleVO vo) throws Exception {
		update("scheduleDAO.ScheduleChkEnd", vo);
	}

	// 일정 등록을 위한 일정시퀀스 받아오기
	public String getScheSeq() throws Exception {
		return (String)selectByPk("scheduleDAO.GetScheSeq", "");
	}

	// 일정 일괄 등록 완료
	@SuppressWarnings("rawtypes")
	public void scheduleAllAddEnd(List list) throws Exception {
		insert("scheduleDAO.ScheduleAllAddEnd", list);
	}

	// 일정 등록 완료
	public void scheduleAddEnd(ScheduleVO vo) throws Exception {
		insert("scheduleDAO.ScheduleAddEnd", vo);
	}

	// 일정 참가자 일괄 등록/수정 완료
	@SuppressWarnings("rawtypes")
	public void scheduleEntryProcEnd(List list) throws Exception {
		insert("scheduleDAO.ScheduleEntryProcEnd", list);
	}

	// 개인일정일시 작성자 참가 등록 완료
	public void scheduleEntryAddEnd(ScheduleVO vo) throws Exception {
		insert("scheduleDAO.ScheduleEntryAddEnd", vo);
	}

	// 선택된 반복 일정 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getRepetScheduleList(ScheduleVO vo) throws Exception {
		return list("scheduleDAO.GetRepetScheduleList", vo);
	}

	// 일정 수정 완료
	public void scheduleEditEnd(ScheduleVO vo) throws Exception {
		update("scheduleDAO.ScheduleEditEnd", vo);
	}

	// 일정 수정 완료(반복일정)
	public void scheduleAllEditEnd(ScheduleVO vo) throws Exception {
		update("scheduleDAO.scheduleAllEditEnd", vo);
	}

	// 일정 삭제 완료
	public void scheduleDelEnd(ScheduleVO vo) throws Exception {
		update("scheduleDAO.ScheduleDelEnd", vo);
	}

	// 일정 삭제 완료(반복일정그룹코드)
	public void scheduleDelEndByGrpCd(ScheduleVO vo) throws Exception {
		update("scheduleDAO.ScheduleDelEndByGrpCd", vo);
	}

	// 일정 참가자 삭제 완료
	public void scheduleEntryDelEnd(ScheduleVO vo) throws Exception {
		delete("scheduleDAO.ScheduleEntryDelEnd", vo);
	}

	// 일정 참가자 삭제 완료(반복일정그룹코드)
	public void scheduleEntryDelEndByGrpCd(ScheduleVO vo) throws Exception {
		delete("scheduleDAO.ScheduleEntryDelEndByGrpCd", vo);
	}

	//업무일지 - 일정정보
	public List getScheduleWork(Map<String, Object> map) throws Exception {
		return list("scheduleDAO.selectScheduleWork", map);
	}

	/**
	* 메인화면 직원근태현황
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getPresentEmpInfoList(Map<String, Object> map) throws Exception{
		return list("scheduleDAO.getPresentEmpInfoList", map);
	}

	/**
	* 메인 현지출근 알람 팝업 목록
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getMainSpotWorkAlarmList(Map<String, Object> map) throws Exception{
		return list("scheduleDAO.getMainSpotWorkAlarmList", map);
	}


	/**
	* 메인화면 임원현황
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getExecEmpInfoList(Map<String, Object> map) throws Exception{
		return list("scheduleDAO.getExecEmpInfoList", map);
	}

	/**
	* 네트워크 > 고객의 상세정보중 최근미팅 이력정보
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getCustomerMeetList(Map<String, Object> map) throws Exception{
		return list("scheduleDAO.getCustomerMeetList", map);
	}

	/**
	* 일정알림 배치
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getScheduleSmsList(Map<String, Object> map) throws Exception{
		return list("scheduleDAO.getScheduleSmsList", map);
	}

	//일정 등록을 위해 근태마감여부 체크
	public List<EgovMap> getChkWorktiemEndYn(Map<String,Object> paramMap) throws Exception{
		return list("scheduleDAO.getChkWorktiemEndYn", paramMap);
	}

	//일정 등록을 위해 휴가여부 체크
	public List<EgovMap> getChkVacationYn(Map<String,Object> paramMap) throws Exception{
		return list("scheduleDAO.getChkVacationYn", paramMap);
	}

	// 스케줄 날짜변경
	public Integer updateScheduleDate(Map<String, Object> map) throws Exception {
		return (Integer)update("scheduleDAO.updateScheduleDate", map);
	}
}