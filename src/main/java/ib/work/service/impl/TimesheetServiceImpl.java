package ib.work.service.impl;



import ib.work.service.TimesheetService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("timesheetService")
public class TimesheetServiceImpl extends AbstractServiceImpl implements TimesheetService {

    @Resource(name="timesheetDAO")
    private TimesheetDAO timesheetDAO;
    
    protected static final Log logger = LogFactory.getLog(TimesheetServiceImpl.class);

    
    
	//파트타임 일정별 시간 (activity 별 시간)
	public List<Map> getMyActTime(Map<String, String> map) throws Exception {

		return timesheetDAO.getMyActTime(map);
	}


	//타임시트 리스트
	public List<Map> getTimesheetAll(Map<String, String> map) throws Exception {
		
		return timesheetDAO.getTimesheetAll(map);
	}


	//타임시트 헤더 저장
	public int doSaveTsHeader(Map<String, Object> map) throws Exception {
		
		return timesheetDAO.doSaveTsHeader(map);
	}
	
	
	//타임시트 상세 저장
	public int doSaveTsDetail(Map<String, Object> map) throws Exception {
		
		return timesheetDAO.doSaveTsDetail(map);
	}

	
	//타임시트 상세 정보
	public List<Map> getTimesheetInfo(Map<String, String> map) throws Exception {

		return timesheetDAO.getTimesheetInfo(map);
	}
	
	
	//타임시트 상태 변경
	public int doChngTsStatus(Map<String, Object> map) throws Exception {

		return timesheetDAO.doChngTsStatus(map);
	}

	
	//타임시트 헤더 정보
	public List<Map> getTimesheetHeaderInfo(Map<String, Object> map) throws Exception {
		
		return timesheetDAO.getTimesheetHeaderInfo(map);
	}
	
	
	//타임시트 관리자 화면 리스트
	public List<Map> getTsListAdmin(Map<String, String> map) throws Exception {
		
		return timesheetDAO.getTsListAdmin(map);
	}

	
	//타임시트 마감처리 상태 변경(한주간 타임시트 전체)
	public int doCloseWeekTs(Map<String, Object> map) throws Exception {
		
		return timesheetDAO.doCloseWeekTs(map);
	}
	
	
	//타임시트 승인자 화면(부서 타임시트) 리스트
	public List<Map> getTimesheetInDept(Map<String, String> map) throws Exception {
		
		return timesheetDAO.getTimesheetInDept(map);
	}


	//부서원 타임시트 상세보기 (한주간)
	public List<Map> getTsOneWeekInDept(Map<String, String> map) throws Exception {
		return timesheetDAO.getTsOneWeekInDept(map);
	}
	
	
	//승인 반려 처리
	public int doChngTsApprov(Map<String, Object> map) throws Exception {

		String tsHeaderIdLst = map.get("tsHeaderIdLst").toString();		//타임시트 id
		String[] idLst = tsHeaderIdLst.split(",");
		
		int uCnt = 0;
		for(int i=0; i<idLst.length; i++){
			map.put("tsHeaderId", idLst[i]);
			uCnt += timesheetDAO.doChngTsStatus(map);		//승인 반려 처리
		}
		
		return uCnt;
	}
	
}
