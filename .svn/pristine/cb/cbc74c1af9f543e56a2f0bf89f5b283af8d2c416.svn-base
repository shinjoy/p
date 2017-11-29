package ib.system.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.HashMap;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package	: ibiss.system.service.impl 
 * filename	: DeptRegDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: SangHyun Park
 * @date	: 2015. 9. 14.
 * @version : 
 *
 */
@Repository("calendarWeekDAO")
public class CalendarWeekDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(CalendarWeekDAO.class);

	/**
	 * 부서목록
	 * 
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: SangHyun Park
	 * @date		: 2015. 9. 14.
	 */
	public List<Map> getCalendarWeekList(Map<String, String> map) throws Exception{
			
		String selectedMonth = map.get("month");
			// 달력리스트 가져오기
			List<Map> calendarWeek = list("system.selectCalendarWeekList", map);

			//return calendarWeek;
			
			//***********************************************************
			// 달력과 휴일 조합하여 데이타 만들기		
			
			// DB에 등록되어 있다면 가져온 데이타로 구성하기
			// 등록되어 있지 않다면 신규로 데이터 작성후 재조회 하기
	/*		if( calendarWeek.size() == 0 )
			{				
				// 검색조건 가져오기
				String calYear = map.get("calYear");	// 년
				String userId = map.get("userId");
				
				int yearValue = Integer.parseInt(calYear);
				
				// 1 : 일요일, 2 : 월요일
								
				
				for( int week_no = 1; week_no <= 53; week_no++ )
				{	
					Date sunday, saturday;
					
				    Calendar cal = Calendar.getInstance();
				    
				    // 주차 기준 일요일 경우
				    //cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
				    
				    // 주차 기준 월요일 경우
				    cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
				    cal.set(Calendar.YEAR, yearValue);
				    cal.set(Calendar.WEEK_OF_YEAR, week_no);
				    
				    if( week_no == 1 ) cal.set(yearValue, 0, 1);
				    
				    sunday = cal.getTime();
				    int currMonth = cal.get(cal.MONTH) + 1;
				    
				    // 주차 기준 일요일 경우
				    //cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
				    
				    // 주차 기준 월요일 경우
				    cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
				    cal.set(Calendar.YEAR, yearValue);
				    cal.set(Calendar.WEEK_OF_YEAR, week_no);
				    
				    if( week_no == 53 ) cal.set(yearValue, 11, 31);
				    
				    saturday = cal.getTime();
				   
				    
				    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
				    
					Map<String, String> weekMap = new HashMap<String, String>();					
					weekMap.put("calYear", calYear);
					weekMap.put("week", String.valueOf(week_no));
					weekMap.put("month", String.valueOf(currMonth));
					weekMap.put("startDate", sdf.format(sunday));
					weekMap.put("endDate", sdf.format(saturday));
					weekMap.put("open", "Y");
					weekMap.put("fiscalYear", calYear);
					weekMap.put("userSeq", userId);
					weekMap.put("orgId", map.get("orgId"));
					
					insert("system.insertCalendarWeek", weekMap);
					//검색조건에 월이 있는 경우
					if(StringUtils.isNotEmpty(selectedMonth) && StringUtils.equals(selectedMonth, String.valueOf(currMonth)))
						calendarWeek.add(weekMap);
				}
			}*/			
			
		return calendarWeek; 
	}
	
	/**
	 * 달력수정
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: SangHyun Park
	 * @date		: 2015. 10. 13.
	 */
	public int updateCalendarWeek(Map<String, Object> map) throws Exception{
		return update("system.updateCalendarWeek", map);
	}
	
	
	public void getWeekRange(int year, int week_no) {

	    Calendar cal = Calendar.getInstance();

		// 1 : 일요일, 2 : 월요일
		cal.setFirstDayOfWeek(2);				
		
	    cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
	    cal.set(Calendar.YEAR, year);
	    cal.set(Calendar.WEEK_OF_YEAR, week_no);
	    Date monday = cal.getTime();

	    cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
	    cal.set(Calendar.YEAR, year);
	    cal.set(Calendar.WEEK_OF_YEAR, week_no);
	    Date sunday = cal.getTime();

	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
	    System.out.println( "1주차 Start : " + sdf.format(monday));
	    System.out.println( "1주차 End: " + sdf.format(sunday));
	    //return new Map<String,String>(sdf.format(monday), sdf.format(sunday));
	}
	
	//해당 달력 오픈여부
	public int selectCalendarOpenChk(Map<String, Object> map) throws Exception{
		return Integer.parseInt(selectByPk("system.selectCalendarOpenChk", map).toString());
	}
	
	
}