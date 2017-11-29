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
public interface CalendarWeekService {

	
	//달력리스트
	List<Map> getCalendarWeekList(Map<String, String> map) throws Exception;
	public int updateCalendarWeek(Map<String, Object> map) throws Exception;
	
	//해당 달력 오픈 여부
	public int selectCalendarOpenChk(Map<String, Object> map) throws Exception;

}
