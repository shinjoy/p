package ib.schedule.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.meetingRoom.service.impl.MeetingRoomDAO;
import ib.personnel.service.impl.ManagementDAO;
import ib.schedule.service.SpCmmVO;
import ib.sms.service.SmsService;
import ib.cmm.util.fcc.service.StringUtil;
import ib.schedule.service.ScheduleService;

@Service("scheService")
public class ScheduleServiceImpl extends AbstractServiceImpl implements ScheduleService{

	@Resource(name = "scheduleDAO")
	private ScheduleDAO scheduleDAO;

	@Resource(name = "smsService")
	private SmsService smsService;

	@Resource(name="meetingRoomDAO")
	MeetingRoomDAO meetingRoomDAO;

	@Resource(name = "managementDAO")
    private ManagementDAO managementDAO;

	// 등록된 달력 최대연도 불러오기
	public String getCalNextYear() throws Exception {
		return scheduleDAO.getCalNextYear();
	}

	// 선택시간 차량 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getCarList(ScheduleVO vo) throws Exception {
		return scheduleDAO.getCarList(vo);
	}

	// 선택일자 차량 사용 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getCarUseList(ScheduleVO vo) throws Exception {
		return scheduleDAO.getCarUseList(vo);
	}

	// 일정 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getScheduleList(ScheduleVO vo) throws Exception {
		List<EgovMap> scheduleList = scheduleDAO.getScheduleList(vo);
		List<EgovMap> newScheduleList = new ArrayList<EgovMap>();
		EgovMap newScheSDayMap = new EgovMap();
		int arrScheSDay[] = new int[32];
		int oldScheSDay = 0;
		int newScheSDay = 0;
		int scheSDayCnt = 1;

		for(EgovMap scheduleMap : scheduleList){
			newScheSDay = (Integer)scheduleMap.get("scheCalDay");
			if(oldScheSDay == newScheSDay){
				scheSDayCnt++;
			}else{
				arrScheSDay[oldScheSDay] = scheSDayCnt;
				scheSDayCnt =1;
			}
			oldScheSDay = (Integer)scheduleMap.get("scheCalDay");
		}
		arrScheSDay[oldScheSDay] = scheSDayCnt;

		for(EgovMap scheduleMap : scheduleList){
			int intScheSDay = (Integer)scheduleMap.get("scheCalDay");
			scheduleMap.put("calDayCnt", arrScheSDay[intScheSDay]);
			newScheduleList.add(scheduleMap);
		}
		return newScheduleList;
	}

	// 휴일 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getHolidayList(ScheduleVO vo) throws Exception {
		return scheduleDAO.getHolidayList(vo);
	}

	// 선택 일정 정보 받아오기
	public ScheduleVO getScheInfo(ScheduleVO vo) throws Exception {
		return scheduleDAO.getScheInfo(vo);
	}

	// 선택 일정 참가자 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getScheduleEntryList(ScheduleVO vo) throws Exception {
		return scheduleDAO.getScheduleEntryList(vo);
	}

	// 선택 일정 완료 처리
	public void scheduleChkEnd(ScheduleVO vo) throws Exception {
		scheduleDAO.scheduleChkEnd(vo);
	}

	// 일정 등록을 위한 일정시퀀스 받아오기
	public String getScheSeq() throws Exception {
		return scheduleDAO.getScheSeq();
	}

	// 일정 일괄 등록 완료
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void scheduleAllAddEnd(HttpServletRequest req, ScheduleVO vo, List list) throws Exception {
		log.debug(list.toString());
		scheduleDAO.scheduleAllAddEnd(list);

		List<Map<String, Object>> ScheList = list;

		String[] arrPerSabun = vo.getArrPerSabun();
		List<Map<String, Object>> EntryList = new ArrayList<Map<String, Object>>();

		for(int k = 0; k < ScheList.size(); k++) {
			for(int i=0;i<arrPerSabun.length;i++){
				Map<String, Object> entryParam = new HashMap<String, Object>();

				entryParam.put("scheSeq", ScheList.get(k).get("scheSeq"));
				entryParam.put("perSabun", arrPerSabun[i]);
				entryParam.put("regPerSabun", vo.getPerSabun());
				entryParam.put("delFlag", "N");

				//orgId 추가.....
				entryParam.put("orgId", vo.getOrgId());
				entryParam.put("tmpCpnId", vo.getTmpCpnId());
				entryParam.put("tmpCstId", vo.getTmpCstId());

				if(!entryParam.get("perSabun").equals("")){
					EntryList.add(entryParam);

					/************************************************************
					 * 휴직/병가인경우 BS_USER_STTS_HIST 이력저장
					 * APPV_DOC_TYPE = SICK:병가 -> H, REST:휴직 -> L
					 ************************************************************/
					String appvDocType = vo.getAppvDocType();

					if("SICK".equals(appvDocType) || "REST".equals(appvDocType)) {
						String userStatus = "";
						if("SICK".equals(appvDocType)) userStatus = "H";
						else if("REST".equals(appvDocType)) userStatus = "L";

						Map<String,Object> procUserStatusMap = new HashMap<String, Object>();
						procUserStatusMap.put("scheSeq", ScheList.get(k).get("scheSeq"));
						procUserStatusMap.put("perSabun", arrPerSabun[i]);
						procUserStatusMap.put("userStatus", userStatus);
						procUserStatusMap.put("sttsFromDt", ScheList.get(k).get("scheSDate"));
						procUserStatusMap.put("sttsEndDt", ScheList.get(k).get("scheEDate"));
						procUserStatusMap.put("sttsMemo", vo.getScheTitle());
						procUserStatusMap.put("sessionUserId", vo.getUserSeq());
						procUserStatusMap.put("userLoginId", vo.getUserSeq());

						managementDAO.insertUserSttsHist(procUserStatusMap);
						managementDAO.updateUserStatus(procUserStatusMap);
					}
				}
			}
		}
		if(EntryList.size() > 0) scheduleDAO.scheduleEntryProcEnd(EntryList);	// 일정 참가자 등록/수정 완료

		//SMS 전송, 한건만 전송
		sendSmsForSchedule(vo);
		/*for(int k = 0; k < ScheList.size(); k++) {
			ScheduleVO smsScheduleVo = (ScheduleVO)ScheList.get(k);
			smsScheduleVo.setArrRecieveUserId(vo.getArrRecieveUserId());
			smsScheduleVo.setUserId(vo.getUserId());
			sendSmsForSchedule(smsScheduleVo);
		}*/

	}

	// 일정 등록 완료
	public void scheduleAddEnd(HttpServletRequest req, ScheduleVO vo) throws Exception {

		String seq = scheduleDAO.getScheSeq();
		vo.setScheSeq(seq);
		scheduleDAO.scheduleAddEnd(vo);  // 일정 등록
		System.out.println(vo.getUserSeq());
		//회의실 예약
		if(vo.getMeetingRoomUseFlag().equals("Y")){

			HashMap<String, Object>map = new HashMap();
			map.put("startDate", vo.getScheSDate());
			map.put("endDate", vo.getScheSDate());
			map.put("startTime", vo.getMeetStartTime());
			map.put("endTime", vo.getMeetEndTime());
			map.put("comment", vo.getScheTitle());

			map.put("meetingRoomId", vo.getMeetingRoomId());
			//map.put("rsvId", vo.getRsvId());

			map.put("rsvUserId", vo.getUserSeq());
			map.put("userSeq", vo.getUserSeq());

			map.put("scheduleId",seq);

			meetingRoomDAO.intsertRsvMeetingRoom(map);

		}

		String[] arrPerSabun = vo.getArrPerSabun();
		List<Map<String, Object>> entryList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> smsList = new ArrayList<Map<String, Object>>();

		for(int i=0;i<arrPerSabun.length;i++){
			Map<String, Object> entryParam = new HashMap<String, Object>();

			entryParam.put("scheSeq", vo.getScheSeq());
			entryParam.put("perSabun", arrPerSabun[i]);
			entryParam.put("regPerSabun", vo.getPerSabun());
			entryParam.put("delFlag", "N");
			//이인희 EntryParam.put("delFlag", req.getParameter("EntryDelFlagAry" + oOo));

			entryParam.put("orgId", vo.getOrgId());  //orgId 추가
			entryParam.put("tmpCpnId", vo.getTmpCpnId());
			entryParam.put("tmpCstId", vo.getTmpCstId());

			if(!entryParam.get("perSabun").equals("")){
				entryList.add(entryParam);

				/************************************************************
				 * 휴직/병가인경우 BS_USER_STTS_HIST 이력저장
				 * APPV_DOC_TYPE = SICK:병가 -> H, REST:휴직 -> L
				 ************************************************************/
				String appvDocType = vo.getAppvDocType();

				if("SICK".equals(appvDocType) || "REST".equals(appvDocType)) {
					String userStatus = "";
					if("SICK".equals(appvDocType)) userStatus = "H";
					else if("REST".equals(appvDocType)) userStatus = "L";

					Map<String,Object> procUserStatusMap = new HashMap<String, Object>();
					procUserStatusMap.put("perSabun", arrPerSabun[i]);
					procUserStatusMap.put("userStatus", userStatus);
					procUserStatusMap.put("sttsFromDt", vo.getScheSDate());
					procUserStatusMap.put("sttsEndDt", vo.getScheEDate());
					procUserStatusMap.put("sttsMemo", vo.getScheTitle());
					procUserStatusMap.put("sessionUserId", vo.getUserSeq());
					procUserStatusMap.put("userLoginId", vo.getUserSeq());
					procUserStatusMap.put("scheSeq", vo.getScheSeq());

					managementDAO.deleteUserSttsHistSche(procUserStatusMap); //삭제

					managementDAO.insertUserSttsHist(procUserStatusMap);
					managementDAO.updateUserStatus(procUserStatusMap);
				}
			}

			if(entryList.size() > 0){
				scheduleDAO.scheduleEntryProcEnd(entryList);	// 일정 참가자 일괄 등록/수정 완료
			}
		}
		//SMS 전송
		sendSmsForSchedule(vo);

	}

	// 선택된 반복 일정 리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getRepetScheduleList(ScheduleVO vo) throws Exception {
		return scheduleDAO.getRepetScheduleList(vo);
	}

	// 일정 수정 완료
	public void scheduleEditEnd(HttpServletRequest req, ScheduleVO vo) throws Exception {

		//Alone 일때 참가자 리스트 재 입력을위해 처음에  지운다.
		scheduleDAO.scheduleEntryDelEnd(vo);
		String[] arrPerSabun = vo.getArrPerSabun();
		List<Map<String, Object>> EntryList = new ArrayList<Map<String, Object>>();

		/************************************************************
		 * 휴직/병가인경우 BS_USER_STTS_HIST 이력삭제 후 재등록함
		 * APPV_DOC_TYPE = SICK:병가 -> H, REST:휴직 -> L
		 ************************************************************/
		String appvDocType = vo.getAppvDocType();
		Map<String,Object> procUserStatusMap = new HashMap<String, Object>();
		procUserStatusMap.put("scheSeq", vo.getScheSeq());
		if("SICK".equals(appvDocType) || "REST".equals(appvDocType)) {
			managementDAO.deleteUserSttsHistSche(procUserStatusMap); //삭제
		}


		for(int i=0;i<arrPerSabun.length;i++){
			Map<String, Object> entryParam = new HashMap<String, Object>();
			entryParam.put("scheSeq", vo.getScheSeq());
			entryParam.put("perSabun", arrPerSabun[i]);
			entryParam.put("regPerSabun", vo.getPerSabun());
			entryParam.put("delFlag", "N");
			entryParam.put("orgId", vo.getOrgId());  //orgId 추가
			entryParam.put("tmpCpnId", vo.getTmpCpnId());
			entryParam.put("tmpCstId", vo.getTmpCstId());

			if(!entryParam.get("perSabun").equals("")){
				EntryList.add(entryParam);

				/************************************************************
				 * 휴직/병가인경우 BS_USER_STTS_HIST 이력저장
				 * APPV_DOC_TYPE = SICK:병가 -> H, REST:휴직 -> L
				 ************************************************************/

				if("SICK".equals(appvDocType) || "REST".equals(appvDocType)) {
					String userStatus = "";
					if("SICK".equals(appvDocType)) userStatus = "H";
					else if("REST".equals(appvDocType)) userStatus = "L";

					procUserStatusMap.put("perSabun", arrPerSabun[i]);
					procUserStatusMap.put("userStatus", userStatus);
					procUserStatusMap.put("sttsFromDt", vo.getScheSDate());
					procUserStatusMap.put("sttsEndDt", vo.getScheEDate());
					procUserStatusMap.put("sttsMemo", vo.getScheTitle());
					procUserStatusMap.put("sessionUserId", vo.getUserSeq());
					procUserStatusMap.put("userLoginId", vo.getUserSeq());

					managementDAO.insertUserSttsHist(procUserStatusMap);
					managementDAO.updateUserStatus(procUserStatusMap);
				}
			}
		}
		if(EntryList.size() > 0){
			scheduleDAO.scheduleEntryProcEnd(EntryList);		// 일정 참가자 일괄 등록/수정 완료
		}

		if("after".equals(vo.getProcFlag()) || "all".equals(vo.getProcFlag())){  //반복일정중 이 일정부터 이후 모든일정 수정,  반복일정중 전체 반복 일정 수정
			scheduleDAO.scheduleAllEditEnd(vo);
		}else{
			scheduleDAO.scheduleEditEnd(vo);
		}


		//회의실 예약
		if(vo.getMeetingRoomUseFlag().equals("Y")){

			HashMap<String, Object>map = new HashMap();
			map.put("startDate", vo.getScheSDate());
			map.put("endDate", vo.getScheSDate());
			map.put("startTime", vo.getMeetStartTime());
			map.put("endTime", vo.getMeetEndTime());
			map.put("comment", vo.getScheTitle());

			map.put("meetingRoomId", vo.getMeetingRoomId());
			map.put("rsvId", vo.getRsvId());

			map.put("rsvUserId", vo.getUserSeq());
			map.put("userSeq", vo.getUserSeq());
			map.put("scheduleId",vo.getScheSeq());


			if(vo.getRsvId()!=0) meetingRoomDAO.updateRsvMeetingRoom(map);
			else  meetingRoomDAO.intsertRsvMeetingRoom(map);



		}else{
			if(vo.getRsvId()!=0){

				HashMap<String, Object>map = new HashMap();
				map.put("rsvId", vo.getRsvId());
				meetingRoomDAO.doDeleteRsvMeetingRoom(map);
			}
		}

		//SMS 전송
		sendSmsForSchedule(vo);
	}

	//일정 SMS 전송
	public void sendSmsForSchedule(ScheduleVO vo) throws Exception {
		//SMS 전송용 현재시간
		Date from = new Date();
		SimpleDateFormat transFormatNow = new SimpleDateFormat("yyyyMMddHHmmss");
		String strNowDate = transFormatNow.format(from);

		//SMS 전송용 예약전송시간
		Date sDate = transFormatNow.parse(vo.getScheSDate().replace("-", "")+"090000");
		long ltime= 0;
		if(!StringUtil.isEmpty(vo.getScheAlarmFlag()) && !"0".equals(vo.getScheAlarmFlag())){
			ltime = sDate.getTime() - ((24*60*60*1000) * Integer.parseInt(vo.getScheAlarmFlag()));
		}else{
			ltime = sDate.getTime();
		}
		sDate=new Date(ltime);
		String strReceiveDate = transFormatNow.format(sDate);

		String period = "";
        if("N".equals(vo.getScheAllTime())){
        	period = vo.getScheSDate() + " (" +vo.getScheSTime()+ ") ~ "
        			+ vo.getScheEDate()  + " (" +vo.getScheETime()+ ")";
        }else{
        	period = vo.getScheSDate() + " ~ " + vo.getScheEDate();
        }
		String smsContent = "[일정] '" + vo.getScheTitle() + " ["+period+"]";

		String[] arrRecieveUserId = vo.getArrRecieveUserId();
		for(int i=0;i<arrRecieveUserId.length;i++){
			Map<String, Object> entryParam = new HashMap<String, Object>();
			if("Y".equals(vo.getSmsSendFlag())) {	// 문자전송체크이면
				entryParam.put("smsTitle", "일정알림");
				entryParam.put("sendUserId", vo.getUserId());
				entryParam.put("recieveUserId", arrRecieveUserId[i]);
				entryParam.put("recieveCustomerId", null);
				entryParam.put("content", smsContent);
				entryParam.put("reserveDate", strNowDate);
				entryParam.put("userId", vo.getUserId());
				entryParam.put("userIdList", arrRecieveUserId[i]);
				entryParam.put("customerList", "");
				entryParam.put("type", "");
				if(!entryParam.get("userIdList").equals("")) {
					smsService.insertSmsLog(entryParam);
				}
			}
			//알림설정에 SMS 전송 포함인경우
			/*if("PopSMS".equals(vo.getScheAlarmHow())) {	// 문자전송체크이면
				entryParam.put("smsTitle", "일정알림");
				entryParam.put("sendUserId", vo.getUserId());
				entryParam.put("recieveUserId", arrRecieveUserId[i]);
				entryParam.put("recieveCustomerId", null);
				entryParam.put("content", smsContent);
				entryParam.put("reserveDate", strReceiveDate);  // SMS 전송시간
				entryParam.put("userId", vo.getUserId());
				entryParam.put("userIdList", arrRecieveUserId[i]);
				entryParam.put("customerList", "");
				entryParam.put("type", "");
				if(!entryParam.get("userIdList").equals("")) {
					smsService.insertSmsLog(entryParam);
				}
			}*/

		}
	}

	// 일정 삭제 완료
	public void scheduleDelEnd(ScheduleVO vo) throws Exception {
		scheduleDAO.scheduleEntryDelEnd(vo);
		scheduleDAO.scheduleDelEnd(vo);

		//--회의실 내역 삭제
		HashMap map = new HashMap();
		map.put("scheduleId", vo.getScheSeq());
		meetingRoomDAO.doDeleteRsvMeetingRoom(map);

		//이력삭제 휴직,병가이력삭제
		map.put("scheSeq", vo.getScheSeq());
		managementDAO.deleteUserSttsHistSche(map); //삭제
	}

	// 일정 삭제 완료(반복일정그룹코드)
	public void scheduleDelEndByGrpCd(ScheduleVO vo) throws Exception {
		scheduleDAO.scheduleEntryDelEndByGrpCd(vo);
		scheduleDAO.scheduleDelEndByGrpCd(vo);

		//이력삭제 휴직,병가이력삭제
		HashMap map = new HashMap();
		map.put("scheSeq", vo.getScheSeq());
		managementDAO.deleteUserSttsHistSche(map); //삭제
	}


	//업무일지 - 일정정보
	public List<Map> getScheduleWork(Map<String, Object> map) throws Exception {

		List<Map> scheList = scheduleDAO.getScheduleWork(map);

		return scheList;
	}

	/**
	 * 메인화면 직원근태현황
	 * @param List
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public List<EgovMap> getPresentEmpInfoList(Map<String, Object> map) throws Exception{
		return scheduleDAO.getPresentEmpInfoList(map);
	}

	/**
	 * 메인 현지출근 알람 팝업 목록
	 * @param List
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public List<EgovMap> getMainSpotWorkAlarmList(Map<String, Object> map) throws Exception{
		return scheduleDAO.getMainSpotWorkAlarmList(map);
	}

	/**
	 * 메인화면 임원현황
	 * @param List
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public List<EgovMap> getExecEmpInfoList(Map<String, Object> map) throws Exception{
		return scheduleDAO.getExecEmpInfoList(map);
	}

	/**
	* 네트워크 > 고객의 상세정보중 최근미팅 이력정보
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getCustomerMeetList(Map<String, Object> map) throws Exception{
		return scheduleDAO.getCustomerMeetList(map);
	}


	//일정 SMS 전송(스케줄)
	public void sendSmsScheduleBatch(Map<String,Object> paramMap) throws Exception {
		List<EgovMap> smsScheduleList = scheduleDAO.getScheduleSmsList(paramMap);
		//SMS 전송용 현재시간
		Date from = new Date();
		from.setTime(from.getTime()+ 10 *60000);
		SimpleDateFormat transFormatNow = new SimpleDateFormat("yyyyMMddHHmmss");
		String strNowDate = transFormatNow.format(from);
		for(EgovMap egovMap : smsScheduleList){
			String period = "";
	        if("N".equals(egovMap.get("scheAllTime").toString())){
	        	period = egovMap.get("scheSDate").toString()  + " (" +egovMap.get("scheSTime").toString()+ ") ~ "
	        			+ egovMap.get("scheEDate").toString()  + " (" +egovMap.get("scheETime").toString()+ ")";
	        }else{
	        	period = egovMap.get("scheSDate").toString() + " ~ " + egovMap.get("scheEDate").toString();
	        }
			String smsContent = "[일정] '" + egovMap.get("scheTitle").toString() + " ["+period+"]";

			Map<String, Object> entryParam = new HashMap<String, Object>();
			entryParam.put("smsTitle", "일정알림");
			entryParam.put("sendUserId", egovMap.get("sendUserId").toString());
			entryParam.put("recieveUserId", egovMap.get("recvUserId").toString());
			entryParam.put("recieveCustomerId", null);
			entryParam.put("content", smsContent);
			entryParam.put("reserveDate", strNowDate);  // SMS 전송시간
			entryParam.put("userId", egovMap.get("sendUserId").toString());
			entryParam.put("userIdList", egovMap.get("recvUserId").toString());
			entryParam.put("customerList", "");
			entryParam.put("type", "");
			smsService.insertSmsLog(entryParam);
		}
	}

	/**
	* 근태마감여부확인
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public EgovMap getChkWorktiemEndYn(Map<String, Object> map, List<Map<String, Object>> scheList) throws Exception{

		if("REPEAT".equals(map.get("repeatFlag"))){
			String[] scheSDate = new String[scheList.size()];
			String[] scheEDate = new String[scheList.size()];
			for(int k = 0; k < scheList.size(); k++) {
				scheSDate[k] = scheList.get(k).get("scheSDate").toString();
				scheEDate[k] = scheList.get(k).get("scheSDate").toString();
			}
			map.put("scheSDate", scheSDate);
			map.put("scheEDate", scheEDate);
		}

		//일정 등록을 위해 근태마감여부 체크
		EgovMap worktimeMap = new EgovMap();
		List<EgovMap> resultList = scheduleDAO.getChkWorktiemEndYn(map);
		if(resultList == null || resultList.size() ==0){
			worktimeMap.put("result", "SUCCESS");
		}else{
			String msg ="";
			for(EgovMap resultMap : resultList){
				if(resultList.size() == 1){
					msg = resultMap.get("orgNm") + " 관계사의 "+resultMap.get("workDate") +"은 근태마감처리되어 등록할 수 없습니다.";
				}else{
					msg = resultMap.get("orgNm") + " 관계사의 "+resultMap.get("workDate") +"(외 " +resultList.size() + "건)은 근태마감처리되어 등록할 수 없습니다.";
				}
				worktimeMap.put("result", "FAIL");
				worktimeMap.put("msg", msg);
				break;
			}
		}

		return worktimeMap;
	}

	/**
	* 일정 등록을 위해 휴가여부 체크
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public EgovMap getChkVacationYn(Map<String, Object> map, List<Map<String, Object>> scheList) throws Exception{

		if("REPEAT".equals(map.get("repeatFlag"))){
			List<Map<String, String>> searchCondition = new ArrayList<Map<String, String>>();
			Map<String, String> searchMap = null;

			for(int k = 0; k < scheList.size(); k++) {
				searchMap = new HashMap<String, String>();
				searchMap.put("scheSDate", scheList.get(k).get("scheSDate").toString());
				searchMap.put("scheEDate", scheList.get(k).get("scheEDate").toString());
				searchMap.put("scheSeq", scheList.get(k).get("scheSeq").toString());
				searchCondition.add(searchMap);
			}
			map.put("searchCondition", searchCondition);
		}


		//일정 등록을 위해 휴가여부 체크
		EgovMap worktimeMap = new EgovMap();
		List<EgovMap> resultList = scheduleDAO.getChkVacationYn(map);
		if(resultList == null || resultList.size() ==0){
			worktimeMap.put("result", "SUCCESS");
		}else{
			String msg ="";
			for(EgovMap resultMap : resultList){
				if("Y".equals(map.get("teamYn"))){
					msg = "참가자로 지정하신 " + resultMap.get("userNm")+"님은 "+resultMap.get("scheSDate")+"부터 "+resultMap.get("scheEDate")+"까지 휴가중입니다.";
					if(resultList.size() > 1) msg += "(외 " +(resultList.size()-1) + "건)";
					msg += "\n그래도 참가자로 지정하시겠습니까?";
					worktimeMap.put("msgType", "CONFIRM");
				}else{
					msg = resultMap.get("userNm")+"님은 "+resultMap.get("scheSDate")+"부터 "+resultMap.get("scheEDate")+"까지 휴가중입니다.";
					msg += "\n일정 등록을 하실 수 없습니다.";
					worktimeMap.put("msgType", "ALERT");
				}

				worktimeMap.put("result", "FAIL");
				worktimeMap.put("msg", msg);
				break;
			}
		}

		return worktimeMap;
	}

	/**
	* 스케줄 날짜변경
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public EgovMap moveDateForSchedule(Map<String, Object> map) throws Exception{
		EgovMap returnMap = new EgovMap();
		int cnt = scheduleDAO.updateScheduleDate(map);

		return returnMap;
	}
}
