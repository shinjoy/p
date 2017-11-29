package ib.system.service.impl;


import ib.system.service.CalendarWeekService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("calendarWeekService")
public class CalendarWeekServiceImpl extends AbstractServiceImpl implements CalendarWeekService {

    @Resource(name="calendarWeekDAO")
    private CalendarWeekDAO calendarWeekDAO;    
    
    protected static final Log logger = LogFactory.getLog(CalendarWeekServiceImpl.class);

 
    
  	//달력리스트
    public List<Map> getCalendarWeekList(Map<String, String> map) throws Exception {
    	    	
    	
    	// 데이타 검증 작업 시작
    	
		return calendarWeekDAO.getCalendarWeekList(map);
	}
    
    //휴일등록(수정)
  	public int updateCalendarWeek(Map<String, Object> map) throws Exception {
  		
  		int svCnt = calendarWeekDAO.updateCalendarWeek(map);				//권한수정
  		
  		return svCnt;
  	}
  	
  	//해당 달력 오픈 여부
  	public int selectCalendarOpenChk(Map<String, Object> map) throws Exception{
  		return calendarWeekDAO.selectCalendarOpenChk(map);
  	}
  	
}
