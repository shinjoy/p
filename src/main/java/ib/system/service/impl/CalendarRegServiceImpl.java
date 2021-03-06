package ib.system.service.impl;


import ib.system.service.CalendarRegService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("calendarRegService")
public class CalendarRegServiceImpl extends AbstractServiceImpl implements CalendarRegService {

    @Resource(name="calendarRegDAO")
    private CalendarRegDAO calendarRegDAO;

    protected static final Log logger = LogFactory.getLog(CalendarRegServiceImpl.class);



  	/**
  	 * 달력 리스트 반환하기
  	 *
  	 * 해당 관계사에 해당하는 날짜가 없는 경우 새로 생성해준다.
  	 */
    public List<Map> getCalendarList(Map<String, String> map) throws Exception {


    	// 달력리스트 가져오기
    	List<Map> calendar = calendarRegDAO.selectCalendarList(map);

    	// 재량 휴일리스트 가져오기
    	List<Map> holiday =  calendarRegDAO.selectHolidayList(map);

    	// 법적 휴일 리스트 가져오기
    	List<Map> nationalHoliday =  calendarRegDAO.selectNationalHolidayList(map);

    	//관계사 정보 가져오기
    	Map orgInfo = calendarRegDAO.selectOrgComInfo(map);

    	//***********************************************************
    	// 달력과 휴일 조합하여 데이타 만들기

    	/*String[] arrWeekDayKor = {"일","월","화","수","목","금","토"};
    	String[] arrWeekDayEng = {"SUNDAY","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY"};
    	String[] arrWeekDayEngShort = {"SUN","MON","TUE","WED","THU","FRI","SAT"};
    	String[] arrMonthEng = {"JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE",
    					"JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"};
    	String[] arrMonthEngShort = {"JAN","FEB","MAR","APR","MAY","JUN",
    				"JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};



    	if(calendar == null || calendar.size() < 1){
    		// 검색조건 가져오기
			String calYear = map.get("calYear").toString();	// 년
			String mm = map.get("mm").toString();			// 월

			int yearValue = Integer.parseInt(calYear), monthValue = Integer.parseInt(mm);
			Calendar cal = Calendar.getInstance();
			cal.set(yearValue, monthValue - 1, 1);
			int endDay = cal.getActualMaximum(Calendar.DATE);

			cal.setFirstDayOfWeek(2);

			for( int idx = 1; idx <= endDay; idx++ ){
				cal.set(yearValue, monthValue - 1, idx);

				int yearWeek = cal.get(cal.WEEK_OF_YEAR);
				if( monthValue == 12 && yearWeek == 1 ) yearWeek = 53;

				// 날짜 등록 시 휴일 체크해서 휴일로 설정할지 아닐지 결정해야 함

				Map<String, String> dayMap = new HashMap<String, String>();
				dayMap.put("orgId", map.get("orgId"));
				dayMap.put("sysDate", calYear + "-" + mm + "-" + String.valueOf(idx));
				dayMap.put("calYear", calYear);
				dayMap.put("mm", mm);
				dayMap.put("dd", String.valueOf(idx));
				dayMap.put("month", arrMonthEng[cal.get(cal.MONTH)]);
				dayMap.put("monAb", arrMonthEngShort[cal.get(cal.MONTH)]);
				dayMap.put("weekNum", String.valueOf(cal.get(cal.DAY_OF_WEEK)));
				dayMap.put("weekKor", arrWeekDayKor[cal.get(cal.DAY_OF_WEEK) - 1]);
				dayMap.put("weekEng", arrWeekDayEng[cal.get(cal.DAY_OF_WEEK) - 1]);
				dayMap.put("weekAb",  arrWeekDayEngShort[cal.get(cal.DAY_OF_WEEK) - 1]);
				dayMap.put("yearWeek", String.valueOf(yearWeek));

				dayMap.put("userSeq", map.get("userSeq"));
				dayMap.put("monthWeek", String.valueOf(cal.get(cal.WEEK_OF_MONTH)));

				dayMap = getHolidayInfo(cal, dayMap, holiday, orgInfo, nationalHoliday);
				dayMap.put("mode", "insert");
				calendarRegDAO.insertCalendar(dayMap);

				calendar.add(dayMap);
			}

    	}*/

    	return calendar;
	}

    //휴일 정보에 따른 calendar 정보 정리
    private Map getHolidayInfo(Calendar cal, Map<String, String> map, List<Map> holidayList, Map orgInfo, List<Map> nationalHoliday) throws Exception{
		//HashMap<String, String> map = new HashMap<String, String>();

		int weekCount = cal.get(cal.DAY_OF_WEEK) - 1;

		String nationalHol = "N";
		String nationalHolType = "";

		//법정 공휴일은 다른 필드에 영향을 주지 않는다. (FORMAL_HOL 필드값만 채움)
		for(int nIdx = 0; nIdx < nationalHoliday.size(); nIdx++ ){
				Map<String, String> holidayMap = nationalHoliday.get(nIdx);
				logger.debug("######################법정공휴일 :"+ holidayMap);
				//휴일이 있는 경우
				if( holidayMap.get("holMm").equals(map.get("mm")) &&
					holidayMap.get("holDd").equals(map.get("dd")) ){
					//반복이 아닌 경우 (년도까지 비교)
					if(holidayMap.get("repeatYn").equals("N")){
						if(!holidayMap.get("holYyyy").equals(map.get("calYear"))){
							continue;
						}
					}
					nationalHol = "Y";
					nationalHolType = holidayMap.get("holType");
					break;
				}
		}

		int nHolidayIndex = -1;
		logger.debug("## holidayMap Size : " + holidayList.size());
		for(int nIdx = 0; nIdx < holidayList.size(); nIdx++ ){
			Map<String, String> holidayMap = holidayList.get(nIdx);

			logger.debug("#####"+holidayMap.get("holiday"));

			//휴일이 있는 경우
			if( holidayMap.get("holMm").equals(map.get("mm")) &&
				holidayMap.get("holDd").equals(map.get("dd")) ){
				//반복이 아닌 경우 (년도까지 비교)
				if(holidayMap.get("repeatYn").equals("N")){
					if(!holidayMap.get("holYyyy").equals(map.get("calYear"))){
						continue;
					}
				}
				nHolidayIndex = nIdx;
				map.put("holiday", "Y");
				map.put("holType",null);
				map.put("formalHol", "Y");
				map.put("formalHolType", holidayMap.get("holType"));
				map.put("nationalHol",nationalHol);
				map.put("nationalHolType", nationalHolType);
				map.put("holPaid", holidayList.get(nHolidayIndex).get("holPaid").toString());
				map.put("costingYn","N");
				map.put("timesheetYn","N");
				map.put("inTime", null);
				map.put("outTime", null);
				if(weekCount == 0 ){//일요일
					map.put("nationalHol", "Y");
					map.put("holType", "일요일");
				}
				if(weekCount == 6){//토요일
					map.put("nationalHol", "Y");
					map.put("holType", "토요일");
				}

				return map;
			}
		}

		if( weekCount == 0 ){
			map.put("holiday", "Y");
			map.put("formalHol","N");
			map.put("nationalHol","Y");
			map.put("holType","일요일");
			map.put("holPaid", "N");
			map.put("costingYn","N");
			map.put("timesheetYn","N");
			map.put("inTime", null);
			map.put("outTime", null);
			map.put("nationalHolType", "");
			map.put("formalHolType", "");
		}
		//일요일
		else if( weekCount == 6 ){
			map.put("holiday", "Y");
			map.put("formalHol","N");
			map.put("nationalHol","Y");
			map.put("holType","토요일");
			map.put("holPaid", "N");
			map.put("costingYn","N");
			map.put("timesheetYn","N");
			map.put("inTime", null);
			map.put("outTime", null);
			map.put("nationalHolType", "");
			map.put("formalHolType", "");
		}
		else{
			//법정 공휴일인 경우
			if(StringUtils.equals(nationalHol, "Y")){
				map.put("holiday", "Y");
				map.put("nationalHol","Y");
				map.put("nationalHolType", nationalHolType);
			}else{
				map.put("holiday", "N");
				map.put("nationalHol","N");
			}
			map.put("formalHol","N");
			map.put("holType",null);
			map.put("holPaid", "Y");
			map.put("costingYn","Y");
			map.put("timesheetYn","Y");

			String inTime =  String.valueOf(orgInfo.get("inTime"));
			String outTime =  String.valueOf(orgInfo.get("outTime"));
			if(StringUtils.isNotEmpty(inTime)){
				map.put("inTime", inTime);
			}else
				map.put("inTime", null);

			if(StringUtils.isNotEmpty(outTime)){
				map.put("outTime", outTime);
			}else
				map.put("outTime", null);
		}

		return map;
	}

    //휴일리스트 반환
    public List<Map> getHolidayList(Map<String, String> map) throws Exception {


    	// 데이타 검증 작업 시작

		return calendarRegDAO.getHolidayList(map);
	}

    //휴일등록(수정)
  	public int updateCalendar(Map<String, Object> map) throws Exception {

  		int svCnt = calendarRegDAO.updateCalendar(map);				//권한수정

  		return svCnt;
  	}

  	//달력 데이터중 가장 큰 년도
  	public int selectMaxCalendarYear(Map<String, Object> map) throws Exception {

  		int maxYear = calendarRegDAO.selectMaxCalendarYear(map);

  		return maxYear;
  	}




  	//휴일 등록 및 수정
  	public int saveHolidayInfo(Map<String, Object> map) throws Exception {

  		int key = 1;

  		String beforeRepeat  ="N"; //전에 반복여부
  		String editRepeat = map.get("repeatYn").toString();	//수정 반복 여부
  		Map holiInfoMap = null;
  		Map thisInfo = null; 		//holId 기준으로 가저온 휴일정보

  		//bs_calendar 에 저장된 가장 마지막 년도를 가져온다.
		int maxYear = selectMaxCalendarYear(map);

		//일단 holId 기준으로 수정 후
		if(!map.get("holId").equals("0")){
			thisInfo = calendarRegDAO.selectHolidayInfo(map);	//holId 기준으로 가저온 휴일정보
			beforeRepeat = thisInfo.get("repeatYn").toString();	//업데이트 전 반복여부

			calendarRegDAO.updateHoliday(map);

		}


  		if(editRepeat.equals("Y") && beforeRepeat.equals("N")){	 //반복일때 ( 수정 : 반복 N -> 반복 Y로 변경시 ,등록 : 반복 Y)


			//현재 년도
			Calendar nowDate = Calendar.getInstance( );
			int nowYear = Integer.parseInt(map.get("holYyyy").toString()); //nowDate.get(Calendar.YEAR);

			SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
			Date currentTime = new Date();
			String oTime = mSimpleDateFormat.format ( currentTime ); 			//현재시간 (String)

			for(int i=nowYear;i<=maxYear;i++){

				//오늘이후 체크 로직 삭제 170512 psj........
				//Date memDelStartDate = mSimpleDateFormat.parse(nowYear+"-"+map.get("holMm")+"-"+map.get("holDd"));
				//Date currentDate =  mSimpleDateFormat.parse( oTime );
				//int compare = currentDate.compareTo( memDelStartDate ); 		// 날짜비교

				//if(compare< 0){	//오늘 이후 만,
					String insertDate = i+"-"+map.get("holMm")+"-"+map.get("holDd");	//실제 기록될 날짜,
					String orgDate = map.get("holidayDate").toString();
					map.put("holidayDate", insertDate);
					map.put("holYyyy", i);


					//-------날짜 유효 검사
					boolean result;
					insertDate = insertDate.replaceAll("-", "");
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMdd", java.util.Locale.KOREA);

					formatter.setLenient ( false );
					Date formatDate = null;
					try {
					       formatDate = formatter.parse(insertDate);
					       result = true;
					}catch (java.text.ParseException e){
						   result = false;
					}


					//-------날짜 유효 검사가 true  일때만, 2.29 같은 처리를 위함.

					if(result){
						holiInfoMap = calendarRegDAO.selectHolidayInfo(map);			//해당일에 등록된 휴일이 있는지 판별,
						if(holiInfoMap == null){
							//bs_holiday 기록
							calendarRegDAO.insertHoliday(map);

							//입력 받은 날짜보다 큰 거나 같은 calendar 데이터만 업데이트
							map.put("holidayDate", orgDate);
							updateCalendarInfo(map,"Y","contain");
						}
						else{
							if(!(!map.get("holId").equals("0") && nowYear == i)) throw new Exception(insertDate.replaceAll("-", "/")+" 일이 이미 휴일에 등록되어 있습니다.");
						}
					}
				//}

			}

  		}else if(editRepeat.equals("N")){		//반복이 아닐때

  			//신규일땐, 등록
  			if(map.get("holId").equals("0")){

	  			if(Integer.parseInt(map.get("holYyyy").toString())<=maxYear){

	  				holiInfoMap = calendarRegDAO.selectHolidayInfo(map);									//해당일에 등록된 휴일이 있는지 판별,

	  				if(holiInfoMap == null){

	  					calendarRegDAO.insertHoliday(map); 				//bs_holiday 기록
						updateCalendarInfo(map,"Y","equal");			//입력 받은 날짜보다 큰 거나 같은 calendar 데이터만 업데이트 X -> 반복이 아니니 무조건 해당날짜만 (JY)20171011 
	  				}
	  	  			else throw new Exception("해당 날짜에 해당하는 휴일이 이미 등록되어있습니다.");

	  			}else throw new Exception("해당 날짜에 달력정보가 없기때문에, 휴일을 등록할 수 없습니다.");

  			}else{	//신규가 아닐때

  				//해당일을 update 반복 -> 'N' 으로 ( holId 기준으로)
  				calendarRegDAO.updateHoliday(map);

  				//해당일 이후의 휴일은 날짜이후 삭제처리
  				map.put("allChange", "Y");
  				calendarRegDAO.deleteHoliday(map);	//삭제처리

  				updateCalendarInfo(map,"N","after");					//입력 받은 날짜보다 큰 거calendar 데이터만 업데이트
  			}
  		}

  		return key;
  	}

  	// bs calendar update
	//2017.01.03 sjy
	//파라미터 map, holiday 여부 , 업데이트 범위 (해당 날짜를 포함안시킴 after)
	public void updateCalendarInfo(Map<String, Object> map,String holiYn,String range) throws Exception {

		HashMap calendarMap = new HashMap();

		calendarMap.put("holiday", holiYn);
		calendarMap.put("formalHol", holiYn);
		calendarMap.put("holType", null);
		calendarMap.put("holidayDate", map.get("holidayDate").toString());
		calendarMap.put("orgId", map.get("orgId"));
		calendarMap.put("holMm", map.get("holMm"));
		calendarMap.put("holDd", map.get("holDd"));
		calendarMap.put("range", range);

		calendarRegDAO.updateCalendarForHoli(calendarMap);

	}


	//휴일삭제 -> enable N 처리
	public void deleteHoliday(Map<String, Object> map) throws Exception {

		calendarRegDAO.deleteHoliday(map);	//삭제처리
		updateCalendarInfo(map,"N","equal");
	}

	//달력리스트 만, 가져오기 sjy 2016.11.01
	public List<Map> getOnlyCalendarList(Map<String, Object> map) throws Exception {
    	// 달력리스트 가져오기
    	return calendarRegDAO.selectOnlyCalendarList(map);
	}

	//전체 휴일리스트(재량, 법정)
	public List<Map> getHolidayAllList(Map<String, Object> map) throws Exception {
		return calendarRegDAO.selectHolidayAllList(map);
	}

	//등록하려는 휴일의 마감여부 체크
	public int getCloseChkCnt(Map<String, Object> map) throws Exception{
		return calendarRegDAO.getCloseChkCnt(map);
	}


}
