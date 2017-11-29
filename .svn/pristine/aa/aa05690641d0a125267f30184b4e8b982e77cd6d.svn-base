package ib.system.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.Calendar;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Set;

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
@Repository("calendarRegDAO")
public class CalendarRegDAO extends ComAbstractDAO{


	protected static final Log logger = LogFactory.getLog(CalendarRegDAO.class);

	//달력리스트 조회
	public List<Map> selectCalendarList(Map<String, String> map) throws Exception{
		return list("system.selectCalendarList", map);
	}

	//달력리스트 조회
	public List<Map> selectOnlyCalendarList(Map<String, Object> map) throws Exception{
		return list("system.selectCalendarList", map);
	}

	// 휴일리스트 가져오기(재량)
	public List<Map> selectHolidayList(Map<String, String> map) throws Exception{
		return list("system.selectHolidayList", map);
	}

	// 휴일리스트 가져오기(법적)
	public List<Map> selectNationalHolidayList(Map<String, String> map) throws Exception{
		return list("system.selectNationalHolidayList", map);
	}

	//관계사 정보 가져오기
	public Map selectOrgComInfo(Map<String, String> map) throws Exception{
		return (Map) super.getSqlMapClientTemplate().queryForObject("system.selectOrgComInfo", map);
	}

	//calendar 정보 입력하기.
	public void insertCalendar(Map map) throws Exception{
		insert("system.insertCalendar", map);
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
	public int updateCalendar(Map<String, Object> map) throws Exception{
		return update("system.updateCalendar", map);
	}

	/**
	 * 달력수정 - holiday 의 반복 및 사용여부 풀었을때 수정기능
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: SangHyun Park
	 * @date		: 2015. 10. 13.
	 */
	public int updateCalendarForHoli(Map<String, Object> map) throws Exception{
		return update("system.updateCalendarForHoli", map);
	}






	/**
	 * 휴일리스트 조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: SangHyun Park
	 * @date		: 2015. 10. 08.
	 */
	public List<Map> getHolidayList(Map<String, String> map) throws Exception{
		return  list("system.selectHolidayList", map);
	}

	//휴일 등록(신규)
	public int insertHoliday(Map<String, Object> map) throws Exception{
		return (Integer) insert("system.insertHoliday", map);
	}

	//휴일 중복 여부 체크
	public int selectDupHoliday(Map<String, Object> map) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("system.selectDupHoliday", map);
	}

	//해당 관계사의 날짜가 존재하는지 여부 체크
	public int selectCalendarInfo(Map<String, Object> map) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("system.selectCalendarInfo", map);
	}

	//해당 날짜의 공휴일들을 체크함(법정휴일인지)
	public Map checkHoliday(Map<String, Object> map){
		return (Map) super.getSqlMapClientTemplate().queryForObject("system.checkHoliday", map);
	}

	//해당 관계사의 bs_calendar 에 등록된 가장 마지막 년도
	public int selectMaxCalendarYear(Map<String, Object> map) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("system.selectMaxCalendarYear", map);
	}


	/**
	 * 휴일수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: SangHyun Park
	 * @date		: 2015. 9. 14.
	 */
	public int updateHoliday(Map<String, Object> map) throws Exception{
		return update("system.updateHoliday", map);
	}


	/**
	 * 휴일삭제(DELETE_FLAG 컬럼수정)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: SangHyun Park
	 * @date		: 2015. 9. 14.
	 */
	public int deleteHoliday(Map<String, Object> param) throws Exception{
		return delete("system.deleteHoliday", param);
	}

	/**
	 * 전체 휴일 선택(법정, 재량)
	 * @param map
	 * @return
	 */
	public List<Map> selectHolidayAllList(Map<String, Object> map) {
		return list("system.selectHolidayAllList", map);
	}


	/*신규 추가 */

	public Map selectHolidayInfo(Map<String, Object> map) throws Exception{
		return (Map) super.getSqlMapClientTemplate().queryForObject("system.selectHolidayInfo", map);
	}

	//등록하려는 휴일의 마감여부 체크
	public int getCloseChkCnt(Map<String, Object> map) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("system.getCloseChkCnt", map);
	}

}