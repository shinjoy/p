package ib.schedule.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.meetingRoom.service.MeetingRoomService;
import ib.schedule.service.SpCmmVO;
import ib.schedule.service.Utill;
import ib.schedule.service.CusVO;
import ib.schedule.service.FormDocService;
import ib.schedule.service.ScheduleService;
import ib.schedule.service.impl.ScheduleVO;
import ib.system.service.MenuPerRoleService;
import ib.approve.service.ApproveService;
import ib.cmm.service.CommonService;
import ib.cmm.util.fcc.service.StringUtil;
import ib.cmm.util.sim.service.AjaxResponse;

@Controller
public class ScheduleController {

	@Resource(name = "scheService")
	private ScheduleService scheService;

	@Resource(name = "formService")
	private FormDocService formService;

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@Resource(name="approveService")
	private ApproveService approveService;

	@Resource(name = "commonService")
	private CommonService commonService;

	@Resource(name = "meetingRoomService")
    private MeetingRoomService meetingRoomService;

	@Resource(name = "menuPerRoleService")
    private MenuPerRoleService menuPerRoleService;

	protected static final Log LOG = LogFactory.getLog(ScheduleController.class);


	// 일정관리를 위한 전년,전월,후년,후월 구하기
	@RequestMapping(value = "/GetCalData.do")
	public SpCmmVO GetCalData(SpCmmVO spCmmVO) throws Exception {
		Calendar calendar = Calendar.getInstance();

		spCmmVO.setNowYear(calendar.get(Calendar.YEAR));
		spCmmVO.setNowMonth(calendar.get(Calendar.MONTH) + 1);
		spCmmVO.setNowDay(calendar.get(Calendar.DAY_OF_MONTH));

		int dayNum = calendar.get(Calendar.DAY_OF_WEEK) ;
	    spCmmVO.setNowWeek(getWeek(dayNum));

		// 선택한 일자 대입
		if(!spCmmVO.getSelDate().equals("")) {
			spCmmVO.setSelYear(Integer.parseInt(spCmmVO.getSelDate().split("-")[0]));
			spCmmVO.setSelMonth(Integer.parseInt(spCmmVO.getSelDate().split("-")[1]));
			spCmmVO.setSelDay(Integer.parseInt(spCmmVO.getSelDate().split("-")[2]));
		}

		// 오늘날짜 대입
		if(spCmmVO.getSelYear() == 0) spCmmVO.setSelYear(spCmmVO.getNowYear());
		if(spCmmVO.getSelMonth() == 0) spCmmVO.setSelMonth(spCmmVO.getNowMonth());
		if(spCmmVO.getSelDay() == 0) spCmmVO.setSelDay(spCmmVO.getNowDay());

		// 전월 이동을 구하기
		spCmmVO.setPreYear(spCmmVO.getSelYear());
		spCmmVO.setPreMonth(spCmmVO.getSelMonth() - 1);
		if(spCmmVO.getPreMonth() < 1) {
			spCmmVO.setPreYear(spCmmVO.getSelYear() - 1);
			spCmmVO.setPreMonth(12);
		}

		// 다음달 이동 구하기
		spCmmVO.setNextYear(spCmmVO.getSelYear());
		spCmmVO.setNextMonth(spCmmVO.getSelMonth() + 1);
		if(spCmmVO.getNextMonth() > 12) {
			spCmmVO.setNextYear(spCmmVO.getSelYear() + 1);
			spCmmVO.setNextMonth(1);
		}

		calendar.set(spCmmVO.getSelYear(), spCmmVO.getSelMonth() - 1, 1);
		spCmmVO.setEndDay(calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		spCmmVO.setStartPosition(calendar.get(Calendar.DAY_OF_WEEK));
		spCmmVO.setStartWeek(getWeek(calendar.get(Calendar.DAY_OF_WEEK)));

		// 마지막날 위치 구하기
		int EndPostion = (spCmmVO.getEndDay() - (7 - (spCmmVO.getStartPosition() - 1))) % 7;
		if(EndPostion == 0) EndPostion =7;
		spCmmVO.setEndWeek(getWeek(EndPostion));

		if(EndPostion == 0) spCmmVO.setEndPosition(7);
		else spCmmVO.setEndPosition(EndPostion);
		return spCmmVO;
	}

	//요일 리턴
	public String getWeek(int dayNum){
		String week = "";
		switch(dayNum){
	        case 1:
	        	week = "일";
	            break ;
	        case 2:
	        	week = "월";
	            break ;
	        case 3:
	        	week = "화";
	            break ;
	        case 4:
	        	week = "수";
	            break ;
	        case 5:
	        	week = "목";
	            break ;
	        case 6:
	        	week = "금";
	            break ;
	        case 7:
	        	week = "토";
	            break ;
		}
		return week;
	}


	//일정 달력보기
	@RequestMapping(value = "/ScheduleCal.do")
	public String schedule(@ModelAttribute("spCmmVO") SpCmmVO spCmmVO, HttpServletRequest req, ScheduleVO vo
							, Model model, HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		/* 다른관계사 선택한 경우 자신의 사번조회 안함...
		 * if("".equals(vo.getSearchPerSabun())){
			vo.setSearchPerSabun(baseUserLoginInfo.get("empNo").toString());
		}*/

		model.addAttribute("type", "schedule");

		//------- inside origin start
		spCmmVO = GetCalData(spCmmVO);
		model.addAttribute("dateVO", spCmmVO);
		model.addAttribute("nextMonthEnd", 7 - spCmmVO.getEndPosition() + 7);
		model.addAttribute("MaxYear", scheService.getCalNextYear());
		model.addAttribute("vo", vo);
		model.addAttribute("message", spCmmVO.getInfoMessage());
		return "schedule/ScheduleCal";
	}


	//일정 달력보기 (IB to PASS)
	@RequestMapping(value = "/ScheduleCalPass.do")
	public String schedulePass(@ModelAttribute("spCmmVO") SpCmmVO spCmmVO, HttpServletRequest req, ScheduleVO vo
							, Model model, HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		model.addAttribute("type", "schedule");

		//------- inside origin start
		spCmmVO = GetCalData(spCmmVO);
		model.addAttribute("dateVO", spCmmVO);
		model.addAttribute("nextMonthEnd", 7 - spCmmVO.getEndPosition() + 7);
		model.addAttribute("MaxYear", scheService.getCalNextYear());
		model.addAttribute("vo", vo);
		model.addAttribute("message", spCmmVO.getInfoMessage());
		return "schedule/ScheduleCal/noTop";
	}


    // 일정 달력보기
	@RequestMapping(value = "/scheduleCalAjax.do")
	public String scheduleCalAjax(@ModelAttribute("spCmmVO") SpCmmVO spCmmVO, HttpServletRequest req, ScheduleVO vo
							, Model model, HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		model.addAttribute("type", "schedule");

		//------- inside origin start
		spCmmVO = GetCalData(spCmmVO);
		model.addAttribute("dateVO", spCmmVO);
		model.addAttribute("nextMonthEnd", 7 - spCmmVO.getEndPosition() + 7);

		vo.setScheGubun("");

		vo.setPerSabun(baseUserLoginInfo.get("empNo").toString());

		vo.setScheSDate("");
		vo.setScheSYear(Integer.toString(spCmmVO.getSelYear()));
		vo.setScheSMonth(Integer.toString(spCmmVO.getSelMonth()));

		vo.setOrgId(baseUserLoginInfo.get("orgId").toString());

		//vo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		vo.setApplyOrgId(vo.getSearchOrgId());

		vo.setUserId(baseUserLoginInfo.get("userId").toString());

		vo.setDeptLevel(baseUserLoginInfo.get("deptLevel").toString());
		vo.setVipAuthYn(baseUserLoginInfo.get("vipAuthYn").toString());

		model.addAttribute("ScheList", scheService.getScheduleList(vo));
		model.addAttribute("HoliList", scheService.getHolidayList(vo));

		if(spCmmVO.getSelMonth() == 12) {
			vo.setScheSYear(Integer.toString(spCmmVO.getSelYear() + 1));
			vo.setScheSMonth(Integer.toString(1));
		}else{
			vo.setScheSMonth(Integer.toString(spCmmVO.getSelMonth() + 1));
		}

		model.addAttribute("NextScheList", scheService.getScheduleList(vo));
		model.addAttribute("NextHoliList", scheService.getHolidayList(vo));
		model.addAttribute("MaxYear", scheService.getCalNextYear());
		model.addAttribute("vo", vo);
		model.addAttribute("message", spCmmVO.getInfoMessage());
		return "schedule/include/scheduleCal_contents_INC/inc";
	}

	// More리스트 보기
	@RequestMapping(value = "/ScheduleMoreList.do")
	public String scheduleMoreList(@ModelAttribute("spCmmVO") SpCmmVO spCmmVO,
			HttpServletRequest req, ScheduleVO vo, ModelMap model) throws Exception {

		Map baseUserLoginInfo = (Map)req.getSession().getAttribute("baseUserLoginInfo");

		vo.setScheSYear(Integer.toString(spCmmVO.getSelYear()));
		vo.setScheSMonth(Integer.toString(spCmmVO.getSelMonth()));

		vo.setScheGubun("");

		vo.setPerSabun(baseUserLoginInfo.get("empNo").toString());
		vo.setOrgId(baseUserLoginInfo.get("orgId").toString());
		vo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		vo.setUserId(baseUserLoginInfo.get("userId").toString());

		model.addAttribute("AlarmList", scheService.getScheduleList(vo));
		model.addAttribute("vo", vo);
		return "schedule/include/scheduleMoreList_POP/pop";
	}


	// 선택시간 차량 사용여부 받아오기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/CarListChk.do")
	public void carListChk(ScheduleVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session
			, Model model) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		vo.setOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		List<Map> list = scheService.getCarList(vo);

		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).get("carImage") != null) {
				byte[] img = (byte[]) (list.get(i).get("carImage"));
				Base64 codec = new Base64();
				list.get(i).put("carImage", codec.encodeBase64String(img));
			}
		}

		AjaxResponse.responseAjaxSelect(response, list);

	}

	// 선택일자 차량 사용 리스트
	@RequestMapping(value = "/CarUseList.do")
	public void carUseList(ScheduleVO vo,
			Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map) request.getSession().getAttribute("baseUserLoginInfo");
		vo.setUserId(baseUserLoginInfo.get("userId").toString());
		vo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		AjaxResponse.responseAjaxSelect(response, scheService.getCarUseList(vo));
	}

	// 일정 등록 페이지
	@RequestMapping(value = "/scheduleProc.do")
	public String scheduleProc(HttpServletRequest req, ScheduleVO vo, Model model) throws Exception {
		Map baseUserLoginInfo = (Map) req.getSession().getAttribute("baseUserLoginInfo");
		vo.setUserId(baseUserLoginInfo.get("userId").toString());
		vo.setOrgId(baseUserLoginInfo.get("orgId").toString());
		vo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		ScheduleVO scheVO = new ScheduleVO();
		if(vo.getEventType().equals("Edit")) {
			scheVO = scheService.getScheInfo(vo);
			model.addAttribute("ScheduleEntryList", scheService.getScheduleEntryList(vo));
		}else {
			scheVO.setScheSeq(scheService.getScheSeq());
		}

		String reqURL = req.getRequestURL().toString().replace("ScheduleProc", "ScView");	// 게시물 URL 정보


		//회의실 내역


		HashMap map = new HashMap();
		map.put("scheduleId", scheVO.getScheSeq());

		List<Map> list = meetingRoomService.getMeetingRoomRsvList(map);

		Map objMap = new HashMap();

		if(list.size() == 0) objMap = null;
		else objMap=list.get(0);

		model.addAttribute("meetingRoom", objMap);
		model.addAttribute("meetingRoomChk", list.size());


		//회의실 예약 사용 가능여부
		map = new HashMap();

		map.put("enable", "Y");
		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("roleId", baseUserLoginInfo.get("userRoleId").toString());
		map.put("menuCode", "MEETING_ROOM_RSVLIST");


		model.addAttribute("meetRsvRoleEnable", menuPerRoleService.chkMenuRoleExist(map));


		model.addAttribute("reqURL", reqURL);
		model.addAttribute("scheVO", scheVO);
		model.addAttribute("vo", vo);
		return "schedule/include/scheduleProc_POP/pop";
	}

	//유저 리스트 가져오는 부분.
	@RequestMapping(value = "/getScheduleEntryList.do")
	public void getScheduleEntryList( HttpServletRequest req,
			HttpServletResponse response,
			ScheduleVO vo, Model model,
			@RequestParam Map map) throws Exception {

		Map baseUserLoginInfo = (Map) req.getSession().getAttribute("baseUserLoginInfo");
		vo.setUserId(baseUserLoginInfo.get("userId").toString());
		vo.setOrgId(baseUserLoginInfo.get("orgId").toString());
		vo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		if(map.containsKey("eventType")&&map.get("eventType").equals("Edit")){ //수정화면에서 참가자로 등록된 리스트
			AjaxResponse.responseAjaxSelect(response, scheService.getScheduleEntryList(vo));

		}else{ //그외 선택된 유저리스트 (팝업, 등록화면)
			String selectUser = (String)map.get("searchPerSabun");
			if(!selectUser.equals("")){
				Map seachmap = new HashMap();
				seachmap.put("sabun", selectUser);
				AjaxResponse.responseAjaxSelect(response, formService.getPerList(seachmap));
			}
		}

	}

	/**
	 * dateFrom~dateTo 동안 참가자가 휴직상태/휴가 체크한다.
	 * 일정 등록을 위해 근태마감여부 체크
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  이인희
	 * @date : 2016. 11. 12.
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/schedule/getChkSchedulePerson.do")
	public void getChkSchedulePerson(HttpServletRequest req, HttpServletResponse res,
			ScheduleVO vo, 	Model model,HttpSession session,
			SessionStatus status) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		Map<String,Object> paramMap = new HashMap<String,Object>();

		//
		if(vo.getArrPerSabun().length>0){
			if(vo.getArrPerSabun().length == 1) paramMap.put("teamYn", "N");
			else paramMap.put("teamYn", "Y");

			paramMap.put("userList", vo.getArrPerSabun());
			paramMap.put("dateFrom", vo.getScheSDate());
			paramMap.put("dateTo", vo.getScheEDate());
			paramMap.put("fieldType", "empNo");
		}
		//변수값 셋팅
		List<Map<String, Object>> scheList = new ArrayList();

		if(vo.getSchePeriodFlag().equals("Y")) vo.setScheRepetFlag("None");
		if(!vo.getScheRepetFlag().equals("None")) {	// 반복일정이면..
			scheList = scheduleAddProc(vo,"CHECK");
			paramMap.put("repeatFlag", "REPEAT");
		}else{
			paramMap.put("repeatFlag", "NONE");
		}
		paramMap.put("vacationYn", vo.getVacationYn());

		//일정 등록을 위해 근태마감여부 체크
		if("Y".equals(vo.getVacationYn()) || "Y".equals(vo.getAttendYn())){
			EgovMap worktimeMap = scheService.getChkWorktiemEndYn(paramMap, scheList);

			if("FAIL".equals(worktimeMap.get("result"))){
				AjaxResponse.responseAjaxObject(res, worktimeMap);		//"FAIL" 전달
				return;
			}
		}
		EgovMap worktimeMap = new EgovMap();

		//일정 등록을 위해 휴가여부 체크
		if("Add".equals(vo.getEventType())){
			worktimeMap = scheService.getChkVacationYn(paramMap, scheList);
		}else {
			List<Map<String, Object>> repetScheduleList = scheService.getRepetScheduleList(vo);
			paramMap.put("scheSeq", vo.getScheSeq());
			worktimeMap = scheService.getChkVacationYn(paramMap, repetScheduleList);
		}


		if("FAIL".equals(worktimeMap.get("result"))){
			AjaxResponse.responseAjaxObject(res, worktimeMap);		//"FAIL" 전달
			return;
		}

		obj.put("result", "SUCCESS");

		//휴직,병가,퇴사 체크(이력 데이터조회)
		Map<String,String> msgMap = new HashMap<String,String>();
		if("Y".equals(paramMap.get("teamYn"))){
			msgMap.put("workDatePeriod", "2");
			obj=approveService.getChkAppointedPerson(paramMap,msgMap);
		}else{
			obj=approveService.getChkAppointedPerson(paramMap, null);
		}


		AjaxResponse.responseAjaxObject(res, obj);		//"SUCCESS" 전달
	}

	// 일정 등록 완료
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/ScheduleAddEnd.do")
	public void scheduleAddEnd(HttpServletRequest req, HttpServletResponse res,ScheduleVO vo,
			BindingResult bindingResult, Model model,HttpSession session,
			SessionStatus status) throws Exception {
		beanValidator.validate(vo, bindingResult);

		if(bindingResult.hasErrors()) {
			model.addAttribute("vo", vo);
			model.addAttribute("message", "등록 실패 하였습니다.");
			AjaxResponse.responseAjaxSave(res, 1,"등록 실패 하였습니다."); // 결과전송
			//return "schedule/include/scheduleProc_POP";
		}

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		vo.setOrgId(baseUserLoginInfo.get("orgId").toString());
		vo.setUserId(baseUserLoginInfo.get("userId").toString());

		if(vo.getScheGubun().equals("All")) vo.setSchePublicFlag("Y");
		if(vo.getSchePeriodFlag().equals("Y")) vo.setScheRepetFlag("None");
		if(!vo.getScheRepetFlag().equals("None")) {	// 반복일정이면..
			vo.setScheGrpCd(Long.toString(System.currentTimeMillis()));
			List list = scheduleAddProc(vo,"SCHEDULE");
			if(list.size() > 0) scheService.scheduleAllAddEnd(req, vo, list);
		} else if(vo.getSchePeriodFlag().equals("Y")) { // 기간일정이면
			vo.setScheGrpCd("Period");
			scheService.scheduleAddEnd(req, vo);  // 2016.11.07 이인희 한건만 입력하는걸로 변경함
		} else {
			scheService.scheduleAddEnd(req, vo);
		}

		status.setComplete();

		AjaxResponse.responseAjaxSave(res, 1); // 결과전송
	}

	// 일정 수정 완료
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/ScheduleEditEnd.do")
	public void scheduleEditEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session,
			ScheduleVO vo, Model model,	SessionStatus status) throws Exception {

		req.setCharacterEncoding("UTF-8");
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		vo.setOrgId(baseUserLoginInfo.get("orgId").toString());
		vo.setUserId(baseUserLoginInfo.get("userId").toString());

		//일정유형별 분기
		if("after".equals(vo.getProcFlag()) || "all".equals(vo.getProcFlag())){  //반복일정중 이 일정부터 이후 모든일정 수정,  반복일정중 전체 반복 일정 수정
			List<Map<String, Object>> repetScheduleList = scheService.getRepetScheduleList(vo);
			for(int i = 0; i < repetScheduleList.size(); i++) {
				scheService.scheduleEditEnd(req, getRepetScheduleData(vo, repetScheduleList.get(i)));
			}
		}else if("alone".equals(vo.getProcFlag())) {  // 반복일정중 이 일정만 수정이면
			scheService.scheduleEditEnd(req, vo);
		}else if(!"None".equals(vo.getScheRepetFlag())) {  //반복일정이면(단일일정에서 반복일정으로 변경시)
			scheService.scheduleDelEnd(vo);
			vo.setScheGrpCd(Long.toString(System.currentTimeMillis()));
			List list = scheduleAddProc(vo,"SCHEDULE");
			if(list.size() > 0) scheService.scheduleAllAddEnd(req, vo, list);
		}else if(vo.getSchePeriodFlag().equals("Y")){  //기간반복 일정이면
			vo.setScheGrpCd("Period");
			scheService.scheduleEditEnd(req, vo);
		}else{
			vo.setScheGrpCd("");
			scheService.scheduleEditEnd(req, vo);
		}

		status.setComplete();
		model.addAttribute("vo", vo);

		AjaxResponse.responseAjaxSave(res, 1); // 결과전송
	}

	// 일정 삭제 완료
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/ScheduleDelEnd.do")
	public void scheduleDelEnd(HttpServletRequest req, HttpServletResponse res,
			ScheduleVO vo, Model model, SessionStatus status) throws Exception {

		if("Period".equals(vo.getScheGrpCd()) || "alone".equals(vo.getProcFlag()) ){
			scheService.scheduleDelEnd(vo);
		}else if(!vo.getScheGrpCd().equals("") && !vo.getProcFlag().equals("alone")) {
			scheService.scheduleDelEndByGrpCd(vo);
		}else {
			scheService.scheduleDelEnd(vo);
		}
		status.setComplete();

		AjaxResponse.responseAjaxSave(res, 1); // 결과전송
	}

	// 반복일정 등록 프로세스
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/periodScheduleAddProc.do")
	public List scheduleAddProc(ScheduleVO vo, String makeType) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String SYy = "", SMm = "", SDd = "", EYy = "", EMm = "", EDd = "";

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		Date SDate = formatter.parse(vo.getScheSDate());
		Calendar Scalendar = Calendar.getInstance();
		Scalendar.setTime(SDate);

		Date EDate = formatter.parse(vo.getScheEDate());
		Calendar Ecalendar = Calendar.getInstance();
		Ecalendar.setTime(EDate);

		// 반복일정은 년반복, 분기반복 5년, 월반복 3년 // 나머지는 1년 을 기준으로 한다.
		int len = 0;
		if(vo.getScheRepetFlag().equals("Date")) len = 365;
		else if(vo.getScheRepetFlag().equals("Week")) len = 52;
		else if(vo.getScheRepetFlag().equals("Month")) len = 36;
		else if(vo.getScheRepetFlag().equals("Quarter")) len = 20;
		else len = 5;

		for(int i = 0; i < len; i++) {
			Map<String, Object> paramTemp = new HashMap<String, Object>();

			Scalendar.setTime(SDate);
			if(vo.getScheRepetFlag().equals("Date")) Scalendar.add(Calendar.DAY_OF_YEAR, i);
			else if(vo.getScheRepetFlag().equals("Week")) Scalendar.add(Calendar.WEEK_OF_YEAR, i);
			else if(vo.getScheRepetFlag().equals("Month")) Scalendar.add(Calendar.MONTH, i);
			else if(vo.getScheRepetFlag().equals("Quarter")) Scalendar.add(Calendar.MONTH, i*3);
			else Scalendar.add(Calendar.YEAR, i);
			SYy = Integer.toString(Scalendar.get(Calendar.YEAR));
			SMm = Integer.toString(Scalendar.get(Calendar.MONTH) + 1);
			SDd = Integer.toString(Scalendar.get(Calendar.DAY_OF_MONTH));
			if(SMm.length() == 1) SMm = "0" + SMm;
			if(SDd.length() == 1) SDd = "0" + SDd;

			Ecalendar.setTime(EDate);
			if(vo.getScheRepetFlag().equals("Date")) Ecalendar.add(Calendar.DAY_OF_YEAR, i);
			else if(vo.getScheRepetFlag().equals("Week")) Ecalendar.add(Calendar.WEEK_OF_YEAR, i);
			else if(vo.getScheRepetFlag().equals("Month")) Ecalendar.add(Calendar.MONTH, i);
			else if(vo.getScheRepetFlag().equals("Quarter")) Ecalendar.add(Calendar.MONTH, i*3);
			else Ecalendar.add(Calendar.YEAR, i);
			EYy = Integer.toString(Ecalendar.get(Calendar.YEAR));
			EMm = Integer.toString(Ecalendar.get(Calendar.MONTH) + 1);
			EDd = Integer.toString(Ecalendar.get(Calendar.DAY_OF_MONTH));
			if(EMm.length() == 1) EMm = "0" + EMm;
			if(EDd.length() == 1) EDd = "0" + EDd;

			//엑티비티 마감일 이전까지 반복일정 설정함
			String scheSDate = SYy + "-" + SMm + "-" + SDd;
			String scheEDate = EYy + "-" + EMm + "-" + EDd;
			String activityEndDate = vo.getActivityEndDate();
			if(!StringUtil.isEmpty(activityEndDate)){
				if(activityEndDate.compareTo(scheEDate) >= 0){
					if("CHECK".equals(makeType)){
						paramTemp.put("scheSDate", scheSDate);
						paramTemp.put("scheEDate", scheEDate);
						paramTemp.put("scheSeq", "0");
					}else{
						int scheSeq = Integer.parseInt(scheService.getScheSeq()) + i;
						paramTemp.put("scheSeq", scheSeq);
						paramTemp.put("scheGrpCd", vo.getScheGrpCd());
						paramTemp.put("scheGubun", vo.getScheGubun());
						paramTemp.put("projectId", vo.getProjectId());
						paramTemp.put("activityId", vo.getActivityId());
						paramTemp.put("scheSYear", SYy);
						paramTemp.put("scheSMonth", SMm);
						paramTemp.put("scheSDay", SDd);
						paramTemp.put("scheSDate", scheSDate);
						paramTemp.put("scheSTime", vo.getScheSTime());
						paramTemp.put("scheEYear", EYy);
						paramTemp.put("scheEMonth", EMm);
						paramTemp.put("scheEDay", EDd);
						paramTemp.put("scheEDate", scheEDate);
						paramTemp.put("scheETime", vo.getScheETime());
						paramTemp.put("scheAllTime", vo.getScheAllTime());
						paramTemp.put("scheTitle", vo.getScheTitle());
						paramTemp.put("scheCon", vo.getScheCon());
						paramTemp.put("scheArea", vo.getScheArea());
						paramTemp.put("scheRepetFlag", vo.getScheRepetFlag());
						paramTemp.put("scheAlarmFlag", vo.getScheAlarmFlag());
						paramTemp.put("scheAlarmHow", vo.getScheAlarmHow());
						paramTemp.put("scheImportant", vo.getScheImportant());
						paramTemp.put("schePublicFlag", vo.getSchePublicFlag());
						paramTemp.put("schePeriodFlag", vo.getSchePeriodFlag());
						paramTemp.put("carUseFlag", vo.getCarUseFlag());
						paramTemp.put("contactLoc", vo.getContactLoc());
						paramTemp.put("perSabun", vo.getPerSabun());

						paramTemp.put("carId", vo.getCarId());
						paramTemp.put("tmpCpnId", vo.getTmpCpnId());
						paramTemp.put("tmpCstId", vo.getTmpCstId());

						paramTemp.put("tmpCpnNm", vo.getTmpCpnNm());
						paramTemp.put("tmpCstNm", vo.getTmpCstNm());

						paramTemp.put("attendYn", vo.getAttendYn());

						paramTemp.put("orgId",vo.getOrgId());  //orgId 추가
					}

					list.add(paramTemp);
				}else{
					break;
				}
			}
		}
		return list;
	}

	// 반복 일정 수정/삭제 플래그 페이지
	@RequestMapping(value = "/ScheduleProcFlag.do")
	public String scheduleProcFlag(ScheduleVO vo, Model model) throws Exception {
		model.addAttribute("vo", vo);
		return "schedule/ScheduleProcFlag/pop";
	}

	// 반복 일정 데이터 받기
	@RequestMapping(value = "/GetRepetScheduleData.do")
	public ScheduleVO getRepetScheduleData(ScheduleVO vo, Map<String, Object> map) throws Exception {
		ScheduleVO DataVO = new ScheduleVO();
		DataVO.setScheSeq(map.get("scheSeq").toString());
		DataVO.setScheGrpCd(map.get("scheGrpCd").toString());
		DataVO.setPerSabun(map.get("perSabun").toString());
		DataVO.setScheGubun(map.get("scheGubun").toString());

		DataVO.setScheSDate(map.get("scheSDate").toString());
		DataVO.setScheEDate(map.get("scheEDate").toString());

//		DataVO.setScheSDate(vo.getScheSDate());
//		DataVO.setScheEDate(vo.getScheEDate());


		DataVO.setOrgId(vo.getOrgId());
		DataVO.setProjectId(vo.getProjectId());
		DataVO.setActivityId(vo.getActivityId());
		DataVO.setScheSYear(vo.getScheSYear());
		DataVO.setScheSMonth(vo.getScheSMonth());
		DataVO.setScheSDay(vo.getScheSDay());

		DataVO.setScheSTime(vo.getScheSTime());
		DataVO.setScheEYear(vo.getScheEYear());
		DataVO.setScheEMonth(vo.getScheEMonth());
		DataVO.setScheEDay(vo.getScheEDay());

		DataVO.setScheETime(vo.getScheETime());
		DataVO.setScheAllTime(vo.getScheAllTime());
		DataVO.setSchePeriodFlag(vo.getSchePeriodFlag());

		DataVO.setScheTitle(vo.getScheTitle());
		DataVO.setScheArea(vo.getScheArea());
		DataVO.setScheCon(vo.getScheCon());
		DataVO.setScheRepetFlag(vo.getScheRepetFlag());
		DataVO.setScheAlarmFlag(vo.getScheAlarmFlag());
		DataVO.setScheAlarmHow(vo.getScheAlarmHow());
		DataVO.setScheImportant(vo.getScheImportant());
		DataVO.setSchePublicFlag(vo.getSchePublicFlag());
		DataVO.setProcFlag(vo.getProcFlag());
		DataVO.setPerSabun(vo.getPerSabun());
		DataVO.setCarUseFlag(vo.getCarUseFlag());
		DataVO.setCarId(vo.getCarId());

		DataVO.setTmpCpnId(vo.getTmpCpnId());
		DataVO.setTmpCstId(vo.getTmpCstId());
		DataVO.setArrPerSabun(vo.getArrPerSabun());
		DataVO.setArrRecieveUserId(vo.getArrRecieveUserId());
		DataVO.setAttendYn(vo.getAttendYn());
		DataVO.setAppvDocType(vo.getAppvDocType());


		return DataVO;
	}

	// 선택 일정 상세보기
	@RequestMapping(value = "/ScheduleView.do")
	public String scheduleView(ScheduleVO vo, Model model, HttpServletRequest req) throws Exception {

		Map baseUserLoginInfo = (Map) req.getSession().getAttribute("baseUserLoginInfo");
		vo.setUserId(baseUserLoginInfo.get("userId").toString());
		vo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		vo.setOrgId(baseUserLoginInfo.get("orgId").toString());

		ScheduleVO scheVO = scheService.getScheInfo(vo);
		model.addAttribute("scheVO", scheVO);
		model.addAttribute("ScheduleEntryList", scheService.getScheduleEntryList(vo));
		model.addAttribute("vo", vo);

		//-- 회의실 내역
		HashMap map = new HashMap();
		map.put("scheduleId", scheVO.getScheSeq());

		List<Map> list = meetingRoomService.getMeetingRoomRsvList(map);
		Map objMap = new HashMap();

		if(list.size() == 0) objMap = null;
		else objMap=list.get(0);

		//회의실 예약 사용 가능여부
		map = new HashMap();

		map.put("enable", "Y");
		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("roleId", baseUserLoginInfo.get("userRoleId").toString());
		map.put("menuCode", "MEETING_ROOM_RSVLIST");


		model.addAttribute("meetRsvRoleEnable", menuPerRoleService.chkMenuRoleExist(map));


		model.addAttribute("meetingRoom", objMap);
		model.addAttribute("meetingRoomChk", list.size());



		return "schedule/include/scheduleView_POP/pop";
	}

	// 선택 일정 완료 처리
	@RequestMapping(value = "/ScheduleChkEnd.do")
	public void scheduleChkEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session,
			ScheduleVO vo, Model model) throws Exception {

		scheService.scheduleChkEnd(vo);
		AjaxResponse.responseAjaxSave(res, 1); // 결과전송
	}

	//메인 직원근태현황 검색 : 이인희
	@RequestMapping(value="/schedule/mainPresentEmpInfoListAjax.do")
	public void getPresentEmpInfoList(	@RequestParam Map<String,Object> paramMap
			,HttpSession session
			,HttpServletResponse response) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null)  throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		/*if("EMP".equals(paramMap.get("actionType").toString())){
			paramMap.put("totalCnt", 7);   // 보여줄 목록 갯수
		}else if("EXEC".equals(paramMap.get("actionType").toString())){
			paramMap.put("totalCnt", 3);   // 보여줄 목록 갯수
		}else{
			paramMap.put("totalCnt", 7);   // 보여줄 목록 갯수
		}*/

		//정보관리 리스트 조회
		AjaxResponse.responseAjaxObject(response, scheService.getPresentEmpInfoList(paramMap));		//"SUCCESS" 전달

	}

   //메인 임원현황 검색 : 이인희
	@RequestMapping(value="/schedule/mainExecEmpInfoListAjax.do")
	public void getExecEmpInfoList(	HttpSession session
									 , HttpServletResponse response
									 , @RequestParam Map<String,Object> paramMap) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null)  throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		paramMap.put("deptLevel", baseUserLoginInfo.get("deptLevel").toString());
		paramMap.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());

		/*if("EMP".equals(paramMap.get("actionType").toString())){
			paramMap.put("totalCnt", 7);   // 보여줄 목록 갯수
		}else if("EXEC".equals(paramMap.get("actionType").toString())){
			paramMap.put("totalCnt", 3);   // 보여줄 목록 갯수
		}else{
			paramMap.put("totalCnt", 7);   // 보여줄 목록 갯수
		}*/


		//정보관리 리스트 조회
		AjaxResponse.responseAjaxObject(response, scheService.getExecEmpInfoList(paramMap));		//"SUCCESS" 전달

	}

	//메인 일정알람 팝업
	@RequestMapping(value = "/mainScheduleAlarm.do")
	public String getmainScheduleAlarm(@ModelAttribute("spCmmVO") SpCmmVO spCmmVO, HttpSession session, HttpServletRequest req, ScheduleVO vo, ModelMap model) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null)  throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		vo.setOrgId(baseUserLoginInfo.get("orgId").toString());
		vo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		vo.setUserId(baseUserLoginInfo.get("userId").toString());
		vo.setSearchPerSabun(baseUserLoginInfo.get("empNo").toString());

		vo.setEventType("Alarm");

		vo.setDeptLevel(baseUserLoginInfo.get("deptLevel").toString());
		vo.setVipAuthYn(baseUserLoginInfo.get("vipAuthYn").toString());

		List alarmList = scheService.getScheduleList(vo);

		model.addAttribute("AlarmList", alarmList);
		model.addAttribute("vo", vo);
		return "schedule/mainScheduleAlarm/pop";
	}

	//메인 현지출근 알람 팝업
	@RequestMapping(value = "/schedule/mainSpotWorkAlarm.do")
	public String getMainSpotWorkAlarmList(HttpSession session
			 , HttpServletResponse response
			 , @RequestParam Map<String,Object> paramMap
			 , ModelMap model) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null)  throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("mainAlarmType", "scheduleSpotWork");

		List<EgovMap> resultList = scheService.getMainSpotWorkAlarmList(paramMap);

		//List alarmList = scheService.getScheduleList(vo);

		model.addAttribute("resultList", resultList);

		return "schedule/mainSpotWorkAlarm/pop";
	}

	/**
	 *
	 * 일정 SMS 전송(스케줄)
	 *
	 * @param :
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/batch/schedule/sendSmsScheduleBatch.do")
	public void sendSmsScheduleBatch(HttpServletResponse response) throws Exception {
		Map<String,Object> paramMap = new HashMap<String, Object>();
		// paramMap.put("scheAlarmHow", "PopSMS");
		scheService.sendSmsScheduleBatch(paramMap);
		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 * 스케줄 날짜변경
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  이인희
	 * @date : 2017. 7. 5.
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/schedule/moveDateForSchedule.do")
	public void moveDateForSchedule(@RequestParam Map<String,Object> paramMap
			,Model model, HttpSession session, HttpServletResponse response) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");



		//return obj
		Map<String,Object> rtnMap = new HashMap<String,Object>();
		ScheduleVO vo = new ScheduleVO();
		vo.setScheSeq(paramMap.get("scheSeq").toString());
		vo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		vo = scheService.getScheInfo(vo);

		//등록자 본인만 체크
		paramMap.put("teamYn", "N");

		String[] arrPerSabun = new String[1];  //일정참가자 사번
		arrPerSabun[0] = vo.getRegPerSabun();
		paramMap.put("userList", arrPerSabun);
		paramMap.put("dateFrom", paramMap.get("scheSDate").toString());
		paramMap.put("dateTo", paramMap.get("scheSDate").toString());
		paramMap.put("fieldType", "empNo");
		paramMap.put("repeatFlag", "NONE");

		//변수값 셋팅
		List<Map<String, Object>> scheList = new ArrayList();
		//단일일정만 가능
		vo.setScheRepetFlag("None");
		paramMap.put("vacationYn", vo.getVacationYn());

		//일정 등록을 위해 근태마감여부 체크
		if("Y".equals(vo.getVacationYn()) || "Y".equals(vo.getAttendYn())){
			EgovMap worktimeMap = scheService.getChkWorktiemEndYn(paramMap, scheList);

			if("FAIL".equals(worktimeMap.get("result"))){
				AjaxResponse.responseAjaxObject(response, worktimeMap);		//"FAIL" 전달
				return;
			}
		}
		EgovMap worktimeMap = new EgovMap();

		//일정 등록을 위해 휴가여부 체크
		worktimeMap = scheService.getChkVacationYn(paramMap, scheList);

		if("FAIL".equals(worktimeMap.get("result"))){
			AjaxResponse.responseAjaxObject(response, worktimeMap);		//"FAIL" 전달
			return;
		}

		//휴직,병가,퇴사 체크(이력 데이터조회)
		Map<String,Object> msgMap = approveService.getChkAppointedPerson(paramMap, null);

		if("FAIL".equals(msgMap.get("result"))){
			AjaxResponse.responseAjaxObject(response, msgMap);		//"FAIL" 전달
			return;
		}

		rtnMap = scheService.moveDateForSchedule(paramMap);
		rtnMap.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, rtnMap);		//"SUCCESS" 전달
	}

}