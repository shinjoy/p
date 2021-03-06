package ib.meetingRoom.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.meetingRoom.service.MeetingRoomService;
import ib.meetingRoom.service.impl.MeetingRoomServiceImpl;
import ib.system.service.CertificationRqmtService;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class MeetingRoomController {


	@Resource(name = "meetingRoomService")
    private MeetingRoomService meetingRoomService;

	@Resource(name = "certificationRqmtService")
	private CertificationRqmtService certificationRqmtService;

	/** log */
    protected static final Log LOG = LogFactory.getLog(MeetingRoomController.class);

    // 카운트 prefix
  	String prefix = "<span class=\"menuRipple\">(";
  	// 카운트 suffix
  	String suffix = ")</span>";

     @ModelAttribute
 	public void common(Model model, HttpServletRequest request, HttpSession session) {
 		Map<String, Object> menuMap = new HashMap<String, Object>();

 		///////////////// ajax조회면 실행하지 않는다 : S
 		String ajaxHeader = request.getHeader("X-Requested-With");
 		String winId = request.getParameter("winID");	//AxisModal

		if ((ajaxHeader != null && ajaxHeader.equals("XMLHttpRequest"))||winId!=null)
			return;
 		///////////////// ajax조회면 실행하지 않는다 : E
 		try{
 			Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

			Map<String,Object> paramMap = new HashMap<String, Object>();
			paramMap.put("targetOrgId", baseUserLoginInfo.get("applyOrgId").toString());

			Calendar car = Calendar.getInstance();

			String month = (car.get(Calendar.MONTH)+1)+"";
			month = String.format("%02d", Integer.parseInt(month));
			paramMap.put("month", month);
			paramMap.put("year", car.get(Calendar.YEAR));

			Integer certDocRqmtListCnt = certificationRqmtService.getCertDocRqmtListCnt(paramMap);
			menuMap.put("MENU_CERT_DOC_RQMT_MNG",prefix + certDocRqmtListCnt + suffix);

			model.addAttribute("menuSummaryMap", menuMap);
 		}catch(Exception e){
 			LOG.info(
 					"=========================================업무지원 좌측메뉴 새글알림 조회도중 오류발생=============================== ");
 			e.printStackTrace();
 		}
     }
    //예약화면
	@RequestMapping(value="/meetingRoom/meetingRoomRsvMgmt.do")
	public String meetingRoomRsvMgmt(
			HttpSession session,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		return "/meetingRoom/meetingRoomRsvMgmt";
    }

	// 회의실 예약 리스트 팝업(일정)
	@RequestMapping(value = "/meetingRoomListPop.do")
	public String meetingRoomListPop(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		model.addAllAttributes(map);
		return "meetingRoom/meetingRoomListPop/pop";
	}

	//예약 내역 가저오기
	@RequestMapping(value="/meetingRoom/getMeetingRoomRsvList.do")
	public void getMeetingRoomRsvList(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		Map userInfo = (HashMap)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", userInfo.get("userId").toString());


		List list= meetingRoomService.getMeetingRoomRsvList(map);

		AjaxResponse.responseAjaxSelect(response,list);

    }

	//일정 내역
	@RequestMapping(value="/meetingRoom/getScheduleList.do")
	public void getScheduleList(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("sessionUserId", baseUserLoginInfo.get("userId").toString());
		map.put("deptLevel", baseUserLoginInfo.get("deptLevel").toString());
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());

		List list= meetingRoomService.getScheduleList(map);

		AjaxResponse.responseAjaxSelect(response,list);

    }

	//예약하기
	@RequestMapping(value="/meetingRoom/doSaveRsvMeetingRoom.do")
	public void doSaveRsvMeetingRoom(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		Map userInfo = (HashMap)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", userInfo.get("userId").toString());

		int chk = meetingRoomService.doSaveRsvMeetingRoom(map);

		AjaxResponse.responseAjaxSave(response, chk);

    }

	//삭제하기
	@RequestMapping(value="/meetingRoom/doDeleteRsvMeetingRoom.do")
	public void doDeleteRsvMeetingRoom(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		Map userInfo = (HashMap)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", userInfo.get("userId").toString());

		meetingRoomService.doDeleteRsvMeetingRoom(map);

		AjaxResponse.responseAjaxSave(response, 1);

    }

	//예약 팝업
	@RequestMapping(value="/meetRoom/meetRoomRsvReg/pop.do")
	public String meetRoomRsvReg(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		model.addAllAttributes(map);

		return "meetingRoom/meetingRoomRsvRegPop/pop";

	}

    //회의실 관리
	@RequestMapping(value="/meetingRoom/meetingRoomMgmt.do")
	public String meetingRoomMgmt(
			HttpSession session,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		return "/meetingRoom/meetingRoomMgmt";
    }


	//회의실 리스트
	@RequestMapping(value="/meetingRoom/getMeetingRoomList.do")
	public void getMeetingRoomList(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{


		List list= meetingRoomService.getMeetingRoomList(map);

		AjaxResponse.responseAjaxSelect(response,list);

    }



	//회의실등록 팝업
	@RequestMapping(value="/meetRoom/openRegMeetingRoomPop/pop.do")
	public String openRegMeetingRoomPop(
			HttpSession session,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		model.addAllAttributes(map);

		return "meetingRoom/openRegMeetingRoomPop/pop";
    }


	//회의실 저장
	@RequestMapping(value="/meetingRoom/doSaveMeetingRoom.do")
	public void doSaveMeetingRoom(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		Map userInfo = (HashMap)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", userInfo.get("userId").toString());

		int cnt= meetingRoomService.doSaveMeetingRoom(map);

		AjaxResponse.responseAjaxSave(response,cnt);

    }

	//회의실 순서 업데이트
	@RequestMapping(value="/meetingRoom/doSortChange.do")
	public void doSortChange(
			HttpSession session,
			HttpServletResponse response,
			HttpServletRequest request,
			ModelMap model,
			@RequestParam Map<String,Object> map ) throws Exception{

		Map userInfo = (HashMap)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", userInfo.get("userId").toString());

		int cnt= meetingRoomService.doSortChange(map);

		AjaxResponse.responseAjaxSave(response,cnt);

    }



}
