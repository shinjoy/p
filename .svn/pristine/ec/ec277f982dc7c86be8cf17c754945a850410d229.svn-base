package ib.board.web;


import ib.board.service.AlarmService;
import ib.cmm.util.sim.service.AjaxResponse;

import java.util.ArrayList;
import java.util.HashMap;
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

@Controller
public class BoardAlaramController {

	@Resource(name="alarmService")
	private AlarmService alarmService;

	protected static final Log logger = LogFactory.getLog(BoardAlaramController.class);

	// 알림공지팝업 목록
	@RequestMapping(value = "/board/boardAlarm.do")
	public String boardAlarmList(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {

		model.addAttribute("pageType", "ONE");

		return "board/boardAlarm";
	}


 	/**
	 * 알람 전사 목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 08.
	 */
	@RequestMapping(value = "/board/boardAlarmAll.do")
	public String boardAlarmAll(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model)
			throws Exception {

		model.addAttribute("pageType", "ALL");

		return "board/boardAlarm";
	}

	// 알림공지팝업 목록 조회
	@RequestMapping(value = "/board/getBoardAlarmList.do")
	public void getBoardAlarmList(HttpServletRequest request,
			HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> map) throws Exception {

		Map<String, Object> result = alarmService.getAlarmBoardList(map);

		AjaxResponse.responseAjaxObject(response, result); // 결과전송
	}

	/**
	 * 등록/수정 팝업
	 * @MethodName :
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/alarm/regAlarm/pop.do")
	public String regAlarm(HttpServletRequest request,
			HttpSession session,HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{

		model.addAllAttributes(map);

		return "board/regAlarm/pop";
	}

	/**
	 * 알림 상세보기
	 * @MethodName :
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/alarm/getAlarmDetail.do")
	public void getAlarmDetail(HttpServletRequest request,
			HttpSession session,HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{

		List<Map>list=alarmService.getAlarmDetail(map);				//알림 상세

		List<Map>targetInfoList = new ArrayList();

		if(list.size()>0){

			String orgScope = list.get(0).get("alarmOrgScope").toString();
			if(orgScope.equals("ORG_MY")){

				targetInfoList = alarmService.getAlarmTargetList(map);	//타깃 리스트

			}else if(orgScope.equals("ORG_CHOICE")){

				targetInfoList = alarmService.getAlarmListOrg(map); 		//알람관계사목록
			}
		}


		HashMap resultMap = new HashMap();

		resultMap.put("list", list);
		resultMap.put("targetInfoList", targetInfoList);

		AjaxResponse.responseAjaxObject(response, resultMap);	//결과전송
	}

	/**
	 * 알림 저장
	 * @MethodName :
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/alarm/saveAlarm.do")
	public void saveAlarm(HttpServletRequest request,
			HttpSession session,HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{
		int saveCnt=0;
		Map baseLoginUser = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId",baseLoginUser.get("userId"));
		map.put("orgId", baseLoginUser.get("applyOrgId"));
		int alarmId = alarmService.saveAlarm(map);	//등록 및 수정. alarmId 0 신규등록 ,외 수정
		saveCnt=1;
		AjaxResponse.responseAjaxSave(response, saveCnt);
	}

	/**
	 * 알림 삭제
	 * @MethodName :
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/alarm/deleteAlarm.do")
	public void deleteAlarm(HttpServletRequest request,
			HttpSession session,HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{
		int saveCnt=0;
		Map baseLoginUser = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId",baseLoginUser.get("userId"));
		alarmService.deleteAlarm(map);	//삭제
		saveCnt=1;
		AjaxResponse.responseAjaxSave(response, saveCnt);
	}


	/**
	 * 알림을 받는 유저리스트
	 * @MethodName :
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/alarm/getAlarmTargetList.do")
	public void getAlarmTargetList(HttpServletRequest request,
			HttpSession session,HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{

		List<Map>list=alarmService.getAlarmTargetList(map);
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 알림 공지대상자 조회페이지
	 * @MethodName :
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="alarm/alarmTargetList/pop.do")
	public String getAlaUserList(HttpServletRequest request,
			HttpSession session,HttpServletResponse response,
			ModelMap model) throws Exception{

		return "board/alarmTargetListPop/pop";
	}


	/**
	 * 알림 공지대상자 조회
	 * @MethodName :
	 * @param
	 * @param
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/alarm/selectAlarmUser.do")
	public void selectAlarmUser(HttpServletRequest request,
			HttpSession session,HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{

		Map<String, Object> resultMap = alarmService.selectAlarmUsers(map);
		AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송
	}


	/**
	 * 알림 팝업 정보 반환
	 * @param request
	 * @param response
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/alarm/alarmInfo.do")
	public String getAlarmInfo(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			ModelMap model) throws Exception{


		String id = request.getParameter("id");
		Map map  = new HashMap<String, Object>();
		map.put("alarmId", id);

		//아이디에 해당하는 알림 팝업창 정보 반환
		Map resultMap = alarmService.selectPopupInfo(map);
		model.addAttribute("alarm", resultMap);

		return "basic/popAlarm/pop";
	}



}
