package ib.worktime.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.cmm.service.impl.ComAbstractDAO;


/**
 * <pre>
 * package  : ib.personnel.service.impl
 * filename : ManagementDAO.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2013. 1. 10.
 * @version : 1.0.0
 */
@Repository("worktimeDAO")
public class WorktimeDAO extends ComAbstractDAO{

	//근태관리 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorktimeList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeList", paramMap);
	}

	//근태관리 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorktimeMainList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeMainList", paramMap);
	}

	//근태관리 목록 : 월별 마감여부
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorktimeEndYnByMonthList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeEndYnByMonthList", paramMap);
	}

	//근태관리 목록 : 년별 마감여부
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorktimeEndYnByYearList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeEndYnByYearList", paramMap);
	}

	//근태관리 목록 : 월별
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorktimeByMonthList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeByMonthList", paramMap);
	}

	//근태관리 목록 : 년별
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorktimeByYearList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeByYearList", paramMap);
	}

	//근태 상세조회
	public EgovMap getWorktime(Map<String,Object> paramMap) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("worktimeDAO.getWorktime", paramMap);
	}

	//근태승인 저장
	public Integer doSaveAttendanceApprov(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("worktimeDAO.doSaveAttendanceApprov", paramMap);
	}

	//출근인정요청 저장
	public Integer doSaveAttendanceApprovReq(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("worktimeDAO.doSaveAttendanceApprovReq", paramMap);
	}

	//근태현황 통계
	public EgovMap getWorktimeStatistics(Map<String,Object> paramMap) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("worktimeDAO.getWorktimeStatistics", paramMap);
	}

	//근태정보 : 년도별
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorktimeInfoByYearList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeInfoByYearList", paramMap);
	}

	//근태마감 여부: 일
	public EgovMap getWorktimeEndInfoForDay(Map<String,Object> paramMap) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("worktimeDAO.getWorktimeEndInfoForDay", paramMap);
	}

	//근태마감 여부: 월
	public EgovMap getWorktimeEndInfoForMonth(Map<String,Object> paramMap) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("worktimeDAO.getWorktimeEndInfoForMonth", paramMap);
	}

	//근태마감 여부: 월
	public EgovMap getWorktimeEndInfoForMonth2(Map<String,Object> paramMap) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("worktimeDAO.getWorktimeEndInfoForMonth2", paramMap);
	}

	//일근태마감처리
	public Integer updateWorkTimeEndForEnd(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("worktimeDAO.updateWorkTimeEndForEnd", paramMap);
	}

	//일근태 처리: 결근처리(미로그인시)
	public Integer updateWorkTimeForEndOfNoWork(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("worktimeDAO.updateWorkTimeForEndOfNoWork", paramMap);
	}

	//달력조회:월별
	@SuppressWarnings("unchecked")
	public List<EgovMap> getCalendarPerMonth(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getCalendarPerMonth", paramMap);
	}
	//파일저장
	public Integer insertWorktimeExcelFile(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt =(Integer)insert("worktimeDAO.insertWorktimeExcelFile", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}
	//근태관리 엑셀 등록
	public Integer insertWorktimeExcel(Map<String, String> param) throws Exception{
		return (Integer)insert("worktimeDAO.insertWorktimeExcel", param);
	}
	//근태일괄관리 업로드엑셀파일리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorkTimeExcelFileList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorkTimeExcelFileList", paramMap);
	}

	//근태일괄관리 엑셀 업로드 사용자조회
	public List<EgovMap> getAttendUserInfo(Map<String, String> paramMap) throws Exception {
		return list("worktimeDAO.getAttendUserInfo", paramMap);
	}

	//근태일괄철 엑셀 업로드 벨리데이션
	public Integer updateWorktimeExcelErrorMsg(Map<String, String> paramMap) throws Exception{
		Integer cnt = 0;

		//출퇴근 시간 (같은날 같은사용자의 출근시간보다 퇴근시간이 이전일수 없다.)
		cnt = update("worktimeDAO.updateWorktimeExcelErrorMsgForIntime", paramMap);
		return cnt;
	}

	//근태일괄처리 엑셀 업로드 벨리데이션 후 파일 업데이트
	public Integer updateWorktimeExcelFileResult(Map<String, String> paramMap) throws Exception{
		return update("worktimeDAO.updateWorktimeExcelFileResult", paramMap);
	}
	//업로드한 엑셀의 업로드 대상 출근 기록을 조회한다.
	public List<EgovMap> getWorktimeExcelIntimeList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeExcelIntimeList", paramMap);
	}
	//엑셀 일괄처리 유저의 출근부 기록이 없을경우 인서트한다.(출근)
	public Integer insertWorkTimeForExcelUserIntime(EgovMap map) throws Exception{
		return (Integer)update("worktimeDAO.insertWorkTimeForExcelUserIntime", map);
	}

	//엑셀 일괄처리 유저의 출근부 기록이 없을경우 인서트한다.(출근)
	public Integer updateWorkTimeForExcelUserIntime(EgovMap map) throws Exception{
		return (Integer)update("worktimeDAO.updateWorkTimeForExcelUserIntime", map);
	}

	//업로드한 엑셀의 업로드 대상 퇴근 기록을 조회한다.
	public List<EgovMap> getWorktimeExcelOuttimeList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeExcelOuttimeList", paramMap);
	}
	//엑셀 일괄처리 유저의 출근부 기록이 없을경우 인서트한다.(퇴근)
	public Integer insertWorkTimeForExcelUserOuttime(EgovMap map) throws Exception{
		return (Integer)update("worktimeDAO.insertWorkTimeForExcelUserOuttime", map);
	}
	//엑셀 일괄처리 유저의 출근부 기록이 없을경우 인서트한다.(퇴근)
	public Integer updateWorkTimeForExcelUserOuttime(EgovMap map) throws Exception{
		return (Integer)update("worktimeDAO.updateWorkTimeForExcelUserOuttime", map);
	}
	//엑셀 일괄처리 유저의 출근부 기록이 없을경우 출근부마감데이터 생성
	public Integer insertWorkTimeEndByExcelUpload(Map<String, Object> map) throws Exception{
		return (Integer)update("worktimeDAO.insertWorkTimeEndByExcelUpload", map);
	}
	//엑셀 일괄처리 적용 여부를 업데이트한다.
	public Integer updateWorkTimeExcelApply(Map<String, Object> map) throws Exception{
		return (Integer)update("worktimeDAO.updateWorkTimeExcelApply", map);
	}
	//엑셀 파일 정보
	public EgovMap getExcelFileInfo(Map<String,Object> paramMap) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("worktimeDAO.getExcelFileInfo", paramMap);
	}
	//출근인정 요청안내 : 메인
	@SuppressWarnings("unchecked")
	public List<EgovMap> getWorktimeReqAlarmList(Map<String, Object> paramMap) throws Exception {
		return list("worktimeDAO.getWorktimeReqAlarmList", paramMap);
	}
}
