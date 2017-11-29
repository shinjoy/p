package ib.work.service;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	: ibiss.work.service 
 * filename	: TimesheetService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2016. 6. 10.
 * @version : 
 *
 */
public interface TimesheetService {

	//파트타임 일정별 시간 (activity 별 시간)
	List<Map> getMyActTime(Map<String, String> map) throws Exception;

	//타임시트 리스트
	List<Map> getTimesheetAll(Map<String, String> map) throws Exception;

	//타임시트 헤더 저장
	int doSaveTsHeader(Map<String, Object> map) throws Exception;

	//타임시트 상세 저장
	int doSaveTsDetail(Map<String, Object> dtlMap) throws Exception;

	//타임시트 정보(상세 정보)
	List<Map> getTimesheetInfo(Map<String, String> map) throws Exception;

	//타임시트 상태변경
	int doChngTsStatus(Map<String, Object> map) throws Exception;

	//타임시트 헤더 정보
	List<Map> getTimesheetHeaderInfo(Map<String, Object> map) throws Exception;

	//타임시트 관리자 화면 리스트
	List<Map> getTsListAdmin(Map<String, String> map) throws Exception;

	//타임시트 마감처리 상태 변경(한주간 타임시트 전체)
	int doCloseWeekTs(Map<String, Object> map) throws Exception;

	//타임시트 승인자 화면(부서 타임시트) 리스트
	List<Map> getTimesheetInDept(Map<String, String> map) throws Exception;

	//부서원 타임시트 상세보기 (한주간)
	List<Map> getTsOneWeekInDept(Map<String, String> map) throws Exception;

	//승인 반려 처리
	int doChngTsApprov(Map<String, Object> map) throws Exception;
	
}
