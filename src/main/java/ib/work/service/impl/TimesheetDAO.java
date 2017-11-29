package ib.work.service.impl;



import ib.cmm.service.impl.ComAbstractDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package	: ibiss.work.service.impl 
 * filename	: TimesheetDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2016. 6. 10.
 * @version : 
 *
 */
/**
 * <pre>
 * package	: ibiss.work.service.impl 
 * filename	: TimesheetDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2016. 6. 28.
 * @version : 
 *
 */
@Repository("timesheetDAO")
public class TimesheetDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(TimesheetDAO.class);

	

	/**
	 * 파트타임 일정별 시간 (activity 별 시간)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 10.
	 */
	public List<Map> getMyActTime(Map<String, String> map) throws Exception{
		
		return list("timesheet.selectMyActTime", map);
	}


	/**
	 * 타임시트 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 14.
	 */
	public List<Map> getTimesheetAll(Map<String, String> map) throws Exception{
		
		return list("timesheet.selectTimesheetAll", map);
	}


	/**
	 * 타임시트 헤더 저장
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 17.
	 */
	public int doSaveTsHeader(Map<String, Object> map) throws Exception{

		return Integer.parseInt(insert("timesheet.mergeTsHeader", map).toString());
	}


	/**
	 * 타임시트 상세 저장
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 17.
	 */
	public int doSaveTsDetail(Map<String, Object> map) throws Exception{

		return Integer.parseInt(insert("timesheet.mergeTsDetail", map).toString());
	}

	
	/**
	 * 타임시트 상세 정보
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 17.
	 */
	public List<Map> getTimesheetInfo(Map<String, String> map) throws Exception{

		return list("timesheet.selectTimesheetInfo", map);
	}


	/**
	 * 타임시트 상태 변경
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 21.
	 */
	public int doChngTsStatus(Map<String, Object> map) throws Exception{
		
		return update("timesheet.updateTimesheetStatus", map);
	}


	/**
	 * 타임시트 헤더 정보
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 24.
	 */
	public List<Map> getTimesheetHeaderInfo(Map<String, Object> map) throws Exception{
		return list("timesheet.selectTimesheetHeaderInfo", map);
	}

	
	/**
	 * 타임시트 관리자 화면 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 28.
	 */
	public List<Map> getTsListAdmin(Map<String, String> map) throws Exception{
		return list("timesheet.selectTsListAdmin", map);
	}

	
	/**
	 * 타임시트 마감처리 상태 변경(한주간 타임시트 전체)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 30.
	 */
	public int doCloseWeekTs(Map<String, Object> map) throws Exception{
		return update("timesheet.closeWeekTs", map);
	}


	/**
	 * 타임시트 승인자 화면(부서 타임시트) 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 30.
	 */
	public List<Map> getTimesheetInDept(Map<String, String> map) throws Exception{
		
		return list("timesheet.selectTimesheetInDept", map);
	}


	/**
	 * 부서원 타임시트 상세보기 (한주간)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 7. 1.
	 */
	public List<Map> getTsOneWeekInDept(Map<String, String> map) throws Exception{
		
		return list("timesheet.selectTsOneWeekInDept", map);
	}


}