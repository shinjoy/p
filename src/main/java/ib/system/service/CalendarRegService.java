package ib.system.service;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	: ibiss.system.service
 * filename	: CalendarRegService.java
 * </pre>
 *
 *
 *
 * @author	: SangHyun Park
 * @date	: 2015. 9. 14.
 * @version :
 *
 */
public interface CalendarRegService {


	//달력 데이터중 가장 큰 년도
	public int selectMaxCalendarYear(Map<String, Object> map) throws Exception;

	//달력리스트
	List<Map> getCalendarList(Map<String, String> map) throws Exception;

	// 달력 수정
	int updateCalendar(Map<String, Object> map) throws Exception;

	//부서리스트(콤보)
	//List<Map> getDeptListCombo(Map<String, String> map) throws Exception;

	//휴일리스트
	List<Map> getHolidayList(Map<String, String> map) throws Exception;

	public int saveHolidayInfo(Map<String, Object> map) throws Exception;
/*
	//휴일등록(신규)
	int insertHoliday(Map<String, Object> map) throws Exception;

	//휴일등록(수정)
	int updateHoliday(Map<String, Object> map) throws Exception;*/

	//휴일삭제
	void deleteHoliday(Map<String, Object> param) throws Exception;

	//달력리스트 만, 가져오기 sjy 2016.11.01
	public List<Map> getOnlyCalendarList(Map<String, Object> map) throws Exception;

	//달력리스트에서 보이는 전체 휴일(법정,재량 휴일)
	List<Map> getHolidayAllList(Map<String, Object> map) throws Exception;

	//등록하려는 휴일의 마감여부 체크
	public int getCloseChkCnt(Map<String, Object> map) throws Exception;
}
