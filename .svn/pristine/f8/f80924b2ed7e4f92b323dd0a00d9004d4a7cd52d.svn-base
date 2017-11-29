package ib.worktime.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface WorktimeService {

	//근태관리 목록
	public List<EgovMap> getWorktimeList(Map<String,Object> paramMap) throws Exception;

	//근태관리 목록
	public List<EgovMap> getWorktimeMainList(Map<String,Object> paramMap) throws Exception;

	//근태관리 목록 : 월별 마감여부
	public List<EgovMap> getWorktimeEndYnByMonthList(Map<String,Object> paramMap) throws Exception;

	//근태관리 목록 : 년별 마감여부
	public List<EgovMap> getWorktimeEndYnByYearList(Map<String,Object> paramMap) throws Exception;

	//근태관리 목록 : 월별
	public List<EgovMap> getWorktimeByMonthList(Map<String,Object> paramMap) throws Exception;

	//근태관리 목록 : 년별
	public List<EgovMap> getWorktimeByYearList(Map<String,Object> paramMap) throws Exception;

	//근태상세조회
	public EgovMap getWorktime(Map<String,Object> paramMap) throws Exception;

	//근태승인 저장
	public int doSaveAttendanceApprov(Map<String,Object> paramMap) throws Exception;

	//출근인정요청 저장
	public int doSaveAttendanceApprovReq(Map<String,Object> paramMap) throws Exception;

	//근태현황 통계
	public EgovMap getWorktimeStatistics(Map<String,Object> paramMap) throws Exception;

	//근태정보 : 년도별
	public List<EgovMap> getWorktimeInfoByYearList(Map<String,Object> paramMap) throws Exception;

	//근태마감 여부 : 일
	public EgovMap getWorktimeEndInfoForDay(Map<String,Object> paramMap) throws Exception;

	//근태마감 여부 : 월
	public EgovMap getWorktimeEndInfoForMonth(Map<String,Object> paramMap) throws Exception;

	//근태마감 여부 : 월
	public EgovMap getWorktimeEndInfoForMonth2(Map<String,Object> paramMap) throws Exception;

	//일근태마감처리
	public int processWorkTimeDayEnd(Map<String,Object> paramMap) throws Exception;

	//월근태마감처리
	public int processWorkTimeMonthEnd(Map<String,Object> paramMap) throws Exception;

	//달력조회:월별
	public List<EgovMap> getCalendarPerMonth(Map<String,Object> paramMap) throws Exception;
	//출근부 엑셀 업로드
	public Map uploadWorktimeExcel(Map<String, Object> map, File fNewname1) throws Exception;
	//근태일괄관리 업로드엑셀파일리스트
	public List<EgovMap> getWorkTimeExcelFileList(Map<String,Object> paramMap) throws Exception;

	//엑셀 업로드 일괄처리
	public int processAttendanceExcelInfo(Map<String,Object> paramMap) throws Exception;

	//엑셀 파일 정보
	public EgovMap getExcelFileInfo(Map<String,Object> paramMap) throws Exception;
	//엑셀 파일 다운로드
	public void doFileDownloadExcel( String filePath,String fileNm,String orgFileNm, HttpServletRequest req, HttpServletResponse res) throws Exception;

	//출근인정 요청안내 : 메인
	public List<EgovMap> getWorktimeReqAlarmList(Map<String,Object> paramMap) throws Exception;
}
