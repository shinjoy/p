package ib.work.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.work.service.TimesheetService;

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

import com.google.gson.Gson;


/**
 * <pre>
 * package	: ibiss.work.web 
 * filename	: TimesheetController.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2016. 6. 2.
 * @version : 
 *
 */
@Controller
public class TimesheetController {

	@Resource(name = "timesheetService")
	private TimesheetService timesheetService;

	
	protected static final Log logger = LogFactory.getLog(TimesheetController.class);

	

	/**
	 * 타임시트 페이지
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "work/timesheet.do")
	public String timesheet(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, @RequestParam Map<String,String> map, ModelMap model) throws Exception {
		
		/*
		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("work/timesheet") == -1){
			return "redirect:/";
		}*/
		
		
		return "/work/timesheet";
	}
	
	
	/**
	 * 일정별 시간 (activity 별 시간)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 10.
	 */
	@RequestMapping(value = "/work/getMyActTime.do")
	public void getMyActTime(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {
		
		
		//일정
		List<Map> list = timesheetService.getMyActTime(map);
		
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	/**
	 * 타임시트 정보 (선택한 한건)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 10.
	 */
	@RequestMapping(value = "/work/getTimesheetInfo.do")
	public void getTimesheetInfo(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {
		
		
		
		//activity time
		List<Map> list = timesheetService.getTimesheetInfo(map);
		
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	/**
	 * 타임시트 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 14.
	 */
	@RequestMapping(value = "/work/getTimesheetAll.do")
	public void getTimesheetAll(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {
		
		
		
		//타임시트리스트
		List<Map> list = timesheetService.getTimesheetAll(map);
		
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	/**
	 * 타임시트 저장 ajax
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @throws Exception 
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/work/doSaveTimesheet.do")
	public void doSaveTimesheet(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
			
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		
		map.put("userSeq", loginInfo.get("userId"));		//user_id(sequence)
	
		
		String mode = map.get("mode").toString();		//'new' or 'update'
		
		
		//dayObject (json string) --> Map 									//날짜정보
		String jsonDay = (String)map.get("dayObject");
		Gson gson = new Gson();
		Map dayMap = null;
		dayMap = gson.fromJson(jsonDay, java.util.HashMap.class);
		
		
		//hList (json string) --> ArrayList									//그리드 정보 (activity 별 시간 등 정보)
		String jsonStr = (String)map.get("hList");		
		ArrayList<Map> actTmList = null;
		actTmList = gson.fromJson(jsonStr, java.util.ArrayList.class);
		
		
		//------ 시간 SUM	... timesheet 헤더 등록을 위해
		double tmDay1=0.0, tmDay2=0.0, tmDay3=0.0, tmDay4=0.0, tmDay5=0.0, tmDay6=0.0, tmDay7=0.0; 
		String tmp = "";
		double total = 0.0;
		
		//activity time sum
		for(int i=0; i<actTmList.size(); i++){
			tmp = actTmList.get(i).get("tmDay1").toString(); 
			tmDay1 += tmp.length()>0? Double.parseDouble(tmp) : 0;
			tmp = actTmList.get(i).get("tmDay2").toString();
			tmDay2 += tmp.length()>0? Double.parseDouble(tmp) : 0;
			tmp = actTmList.get(i).get("tmDay3").toString();
			tmDay3 += tmp.length()>0? Double.parseDouble(tmp) : 0;
			tmp = actTmList.get(i).get("tmDay4").toString();
			tmDay4 += tmp.length()>0? Double.parseDouble(tmp) : 0;
			tmp = actTmList.get(i).get("tmDay5").toString();
			tmDay5 += tmp.length()>0? Double.parseDouble(tmp) : 0;
			tmp = actTmList.get(i).get("tmDay6").toString();
			tmDay6 += tmp.length()>0? Double.parseDouble(tmp) : 0;
			tmp = actTmList.get(i).get("tmDay7").toString();
			tmDay7 += tmp.length()>0? Double.parseDouble(tmp) : 0;
		}
		
		total = tmDay1 + tmDay2 + tmDay3 + tmDay4 + tmDay5 + tmDay6 + tmDay7;		//총합
		
		/*
			tsHdrId : '',
			pjtId : newPjt[i].value,
			pjtNm : $(newPjt[i]).find(':selected').text(),
			actId : newAct[i].value,
			actNm : $(newAct[i]).find(':selected').text(),
			tmDay1 : '', tmDay2 : '', tmDay3 : '', tmDay4 : '', tmDay5 : '', tmDay6 : '', tmDay7 : '',
			oriTmDay1 : '', oriTmDay2 : '', oriTmDay3 : '', oriTmDay4 : '', oriTmDay5 : '', oriTmDay6 : '', oriTmDay7 : '',
			tmWeek: ''
		 */
		
		int upCnt = 1;								//성공 '1'(임시값)
		int tsHeaderId = -1;
				
		map.put("tmDay1", tmDay1);
		map.put("tmDay2", tmDay2);
		map.put("tmDay3", tmDay3);
		map.put("tmDay4", tmDay4);
		map.put("tmDay5", tmDay5);
		map.put("tmDay6", tmDay6);
		map.put("tmDay7", tmDay7);
		map.put("total", total);
		map.put("orgId", loginInfo.get("orgId"));
		
				
		//map.put("hList", actTmList);				//json string 을 ArrayList 로 바꿔 전달한다.
		
		//-------------------------------------------- HEADER 저장 :S ------------------------------------------------
		if("new".equals(mode)){						//신규등록
			
			//타임시트 헤더 등록 --- ①
			tsHeaderId = timesheetService.doSaveTsHeader(map);						//trHeaderId	신규 추가된 헤더 id
			
			
			
		}else{	//"update"							//수정저장
			
			//타임시트 헤더 등록 --- ①
			timesheetService.doSaveTsHeader(map);									//화면에서 넘어온 trHeaderId 로 수정

			tsHeaderId = Integer.parseInt(map.get("tsHeaderId").toString());		//화면에서 넘어온 헤더 id
		}
		//-------------------------------------------- HEADER 저장 :E ------------------------------------------------
		
		//-------------------------------------------- DETAIL 저장 :S ------------------------------------------------
		List<Map> dtlList = new ArrayList<Map>();
		
		for(int i=0; i<actTmList.size(); i++){
			for(int k=1; k<=7; k++){
				
				if(actTmList.get(i).get("tmDay"+k).toString().length() == 0) continue;		//값이 없으면 skip
				
				Map dtlMap = new HashMap();
				
				dtlMap.put("tsHeaderId", 	tsHeaderId);						//신규 추가된 헤더 id 바인딩
				dtlMap.put("pjtId",			actTmList.get(i).get("pjtId"));
				dtlMap.put("actId", 		actTmList.get(i).get("actId"));
				dtlMap.put("enterDate", 	dayMap.get("day"+k));
				dtlMap.put("workTime", 		actTmList.get(i).get("tmDay"+k));
				dtlMap.put("userSeq", 		loginInfo.get("userId"));
				
				//타임시트 상세 등록 --- ②
				timesheetService.doSaveTsDetail(dtlMap);
			}
		}
		//-------------------------------------------- DETAIL 저장 :E ------------------------------------------------
		
				
		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
			
	}
	
	
	/**
	 * 타임시트 상태변경 ajax
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @throws Exception 
	 * @date		: 2016. 6. 21.
	 */
	@RequestMapping(value = "/work/doChngTsStatus.do")
	public void doChngTsStatus(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
			
		
		
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", loginInfo.get("userId"));		//user_id(sequence)
			
		
		String chngType = "";
		if(map.containsKey("chngType")){	//변경요청타입	...	'CANCEL_SUBMIT' 승인요청취소
			chngType = map.get("chngType").toString();
		}
		if("CANCEL_SUBMIT".equals(chngType)){	//'CANCEL_SUBMIT' 승인요청취소
			//상태변경할 타임시트 정보(현재 상태 체크)
			List<Map> list = timesheetService.getTimesheetHeaderInfo(map);
			
			String status = list.get(0).get("status").toString();		//상태
			String statusNm = list.get(0).get("statusNm").toString();	//상태명
			
			Map obj = new HashMap<String,String>();
			obj.put("status", status);
			obj.put("statusNm", statusNm);
			if("REQUEST".equals(status)){	//승인요청 상태일때
				int	upCnt = timesheetService.doChngTsStatus(map);
				obj.put("realResult", upCnt<1?"FAIL":"SUCCESS");
				
			}else{		//승인요청 상태가 아닐때 (이미 승인처리 했거나, 반려처리를 했을때)
				obj.put("realResult", "FAIL");
			}
			
			AjaxResponse.responseAjaxObject(response, obj);
			
			
		}else{		//일반변경
			
			int	upCnt = timesheetService.doChngTsStatus(map);
			
			AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
		}
		
	}
	
	
	//---------------------------- 타임시트 관리자 화면 관련 :S -----------------------------
	
	/**
	 * 타임시트 관리자 페이지
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/work/timesheetAdmin.do")
	public String timesheetAdmin(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {
		
		
		/*//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("work/timesheetAdmin") == -1){
			return "redirect:/";
		}
		*/
		
		return "work/timesheetAdmin";
	}
	
	
	/**
	 * 타임시트 관리자 화면 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 28.
	 */
	@RequestMapping(value = "/work/getTsListAdmin.do")
	public void getTsListAdmin(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {
		
		//타임시트리스트
		List<Map> list = timesheetService.getTsListAdmin(map);
		
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	/**
	 * 관리자화면 마감처리 ajax
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @throws Exception 
	 * @date		: 2016. 6. 30.
	 */
	@RequestMapping(value = "/work/doCloseWeekTs.do")
	public void doCloseWeekTs(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
			
		
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", loginInfo.get("userId"));		//user_id(sequence)
		
			
		int	upCnt = timesheetService.doCloseWeekTs(map);
		
		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송		
	}
	
	
	
	//---------------------------- 타임시트 승인자 화면 관련 :S -----------------------------
	
	/**
	 * 타임시트 승인자 페이지
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 6. 30.
	 */
	@RequestMapping(value = "/work/timesheetApprv.do")
	public String timesheetApprv(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {
		
		
		/*//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("work/timesheetApprv") == -1){
			return "redirect:/";
		}
		*/
		
		return "work/timesheetApprv";
	}
	
	
	/**
	 * 타임시트 승인자 화면(부서 타임시트) 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 30.
	 */
	@RequestMapping(value = "/work/getTimesheetInDept.do")
	public void getTimesheetInDept(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {
		
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("applyOrgId", loginInfo.get("applyOrgId").toString());
		//타임시트리스트
		List<Map> list = timesheetService.getTimesheetInDept(map);
		
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
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
	@RequestMapping(value = "/work/getTsOneWeekInDept.do")
	public void getTsOneWeekInDept(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {
		
		
		
		//activity time
		List<Map> list = timesheetService.getTsOneWeekInDept(map);
		
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	/**
	 * 타임시트 승인 반려 처리 ajax
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @throws Exception 
	 * @date		: 2016. 7. 26.
	 */
	@RequestMapping(value = "/work/doChngTsApprov.do")
	public void doChngTsApprov(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
		
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", loginInfo.get("userId"));		//user_id(sequence)
			
		int	upCnt = timesheetService.doChngTsApprov(map);
		
		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}
	
}