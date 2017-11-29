package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.LogUtil;
import ib.system.service.CalendarWeekService;

import java.util.List;
import java.util.Map;





import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * <pre>
 * package	: ibiss.system.web 
 * filename	: CalendarWeekController.java
 * </pre>
 * 
 * 
 * 
 * @author : SangHyun Park
 * @date : 2015. 9. 17.
 * @version :
 * 
 */
@Controller
public class CalendarWeekController {

	@Resource(name = "calendarWeekService")
	private CalendarWeekService calendarWeekService;

	protected static final Log logger = LogFactory
			.getLog(CalendarWeekController.class);

	/**
	 * 
	 * 
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 17.
	 */
	@RequestMapping(value = "/system/calendarWeek.do")
	public String calendarWeek(HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelMap model) throws Exception {

		
		
		return "system/calendarWeek";
	}

	/**
	 * 달력 리스트
	 * 
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/getCalendarWeekList.do")
	public void getCalendarWeekList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam Map<String, String> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)
		
		List<Map> list = calendarWeekService.getCalendarWeekList(map);
		
		AjaxResponse.responseAjaxSelect(response, list); // 결과전송
	}
	
	
	/**
	 * 달력 오픈여부 저장 ajax
	 * 
	 * @param :
	 * @return :
	 * @exception :
	 */
	@RequestMapping(value = "/system/doUpdateCalendarWeek.do")
	public void doUpdateCalendar(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int upCnt = calendarWeekService.updateCalendarWeek(map); // upCnt : 실제 넘어오는 값은
																 // 메뉴아이디(menuId) 이다
		
		AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송
	}
	
	/**
	 * 해당일의 달력이 오픈되었는지 
	 * 
	 * @param :
	 * @return :
	 * @exception :
	 * @author : sjy
	 * @date : 2016.11.24
	 */
	@RequestMapping(value = "/system/selectCalendarOpenChk.do")
	public void selectCalendarOpenChk(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", loginUser.get("applyOrgId").toString());		

		int upCnt = calendarWeekService.selectCalendarOpenChk(map); 
															
		
		AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송
	}
}