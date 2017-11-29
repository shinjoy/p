package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.LogUtil;
import ib.system.service.CalendarRegService;

import java.util.List;
import java.util.Map;






import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * <pre>
 * package	: ibiss.system.web
 * filename	: CalendarRegController.java
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
public class CalendarRegController {

	@Resource(name = "calendarRegService")
	private CalendarRegService calendarRegService;

	protected static final Log logger = LogFactory
			.getLog(CalendarRegController.class);

	/**
	 *
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 17.
	 */
	@RequestMapping(value = "/system/calendarMgmt.do")
	public String calendarMgmt(HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelMap model) throws Exception {


		return "system/calendarMgmt";
	}

	/**
	 * 입력된 달력 리스트 중 가장 큰 년도 가져오기
	 */
	@RequestMapping(value = "/system/getCalendarMaxYear.do")
	public void getCalendarMaxYear(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam Map<String, Object> map) throws Exception {

		int maxYear = calendarRegService.selectMaxCalendarYear(map);
		AjaxResponse.responseAjaxObject(response, maxYear); // 결과전송

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
	@RequestMapping(value = "/system/getCalendarList.do")
	public void getCalendarList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam Map<String, String> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		try{
			List<Map> list = calendarRegService.getCalendarList(map);
			AjaxResponse.responseAjaxSelect(response, list); // 결과전송
		}catch(Exception ex){
			ex.printStackTrace();
			AjaxResponse.responseAjaxFailWithMsg(response, "달력을 가져오는 도중 오류가 발생하였습니다.");
		}
	}


	/**
	 * 휴일 리스트
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/getHolidayList.do")
	public void getHolidayList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam Map<String, Object> map) throws Exception {

		List<Map> list = calendarRegService.getHolidayAllList(map);

		AjaxResponse.responseAjaxSelect(response, list); // 결과전송
	}


	/**
	 * 휴일등록
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 10. 8.
	 */
	@RequestMapping(value = "/system/addHoliday.do")
	public String addHoliday(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {



		model.addAllAttributes(map); // 받은 파라미터 화면으로 그대로 전달.

		return "system/addHoliday/pop";
	}

	/**
	 * 휴일 저장 ajax
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 10. 8.
	 */
	@RequestMapping(value = "/system/doSaveHoliday.do")
	public void doSaveModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		// JSONValue.parse(oldParamMap.get("deptInfoObj"));
		//LogUtil.printMap(map); // map console log

		int upCnt = 0;
		String message = "";

		int closeChkCnt = 0;
		try{
			//등록하려는 휴일의 마감여부 체크
			closeChkCnt = calendarRegService.getCloseChkCnt(map);
			/*String mode = map.get("mode").toString(); // 'new' or 'update'
			if ("update".equals(mode)) {
				upCnt = calendarRegService.updateHoliday(map);
			} else { // "new"
				upCnt = calendarRegService.insertHoliday(map);
			}*/

			if(closeChkCnt == 0)
				upCnt = calendarRegService.saveHolidayInfo(map);
			else if(closeChkCnt == 1){
				message = "선택하신 날짜는 마감되어 휴일로 지정할수 없습니다.";
			}else if(closeChkCnt == -1){
				message = "선택하신 날짜는 달력이 등록되지않아 휴일로 지정할수 없습니다.";
			}
		}catch(Exception ex){
			ex.printStackTrace();
			message = ex.getCause().getMessage();
			if(StringUtils.isEmpty(message)){
				message = "등록 도중 오류가 발생하였습니다.";
			}
		}

		AjaxResponse.responseAjaxSave(response, upCnt, message); // 결과전송
	}


	/**
	 * 달력 저장 ajax
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 10. 8.
	 */
	@RequestMapping(value = "/system/doUpdateCalendar.do")
	public void doUpdateCalendar(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		// JSONValue.parse(oldParamMap.get("deptInfoObj"));
		LogUtil.printMap(map); // map console log


		int upCnt = calendarRegService.updateCalendar(map); // upCnt : 실제 넘어오는 값은
															// 메뉴아이디(menuId) 이다

		AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송
	}


	/**
	 * 휴일 삭제
	 *
	 * @param :
	 * @return :
	 * @exception :
	 */
	@RequestMapping(value = "/system/deleteHoliday.do")
	public void deleteModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		calendarRegService.deleteHoliday(map);

		AjaxResponse.responseAjaxSave(response, 1); // 결과전송

	}



}