package ib.project.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.ibm.icu.text.SimpleDateFormat;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.approve.service.ApproveService;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.LogUtil;
import ib.common.util.PaginationUtil;
import ib.common.util.DateUtil;
import ib.project.service.ProjectMgmtService;


/**
 * <pre>
 * package	: ibiss.project.web
 * filename	: ProjectMgmtController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 10. 16.
 * @version :
 *
 */
@Controller
public class ProjectMgmtController {

	@Resource(name = "projectMgmtService")
	private ProjectMgmtService projectMgmtService;

	@Resource(name="approveService")
	private ApproveService approveService;


	protected static final Log logger = LogFactory.getLog(ProjectMgmtController.class);


	/**
	 * 프로젝트 목록 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/project/projectMgmt.do")
	public String projectMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {

		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "project/projectMgmt";
	}



	/**
	 * 템플릿 프로젝트 리스트 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/project/getProjectList.do")
	public void getProjectList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {

		Map baseUserLoginInfo = (HashMap)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());				//ORG_ID
		map.put("userId", baseUserLoginInfo.get("userId").toString());				//userId
		map.put("deptLevel", baseUserLoginInfo.get("deptLevel").toString());
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());
		map.put("myAuthIds", baseUserLoginInfo.get("myAuthIds").toString());

		Map<String,Object> resultMap;

		resultMap = projectMgmtService.getProjectList((Map)map);

		AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송

	}


	/**
	 * 프로젝트 등록 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/project/projectReg.do")
	public String projectReg(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
		return "project/projectReg2";
	}




	/**
	 * 프로젝트 등록 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	@RequestMapping(value = "/project/doSaveProject.do")
	public void doSaveProject(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map resultMap =  new HashMap();
		String msg = "";

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());					//user_id(sequence)
		map.put("userName", loginUser.get("userName").toString());				//userName
		map.put("sessionProjectTitle", loginUser.get("projectTitle").toString());//프로젝트 타이틀 명
		map.put("sessionActivityTitle", loginUser.get("activityTitle").toString());//프로젝트 타이틀 명

		LogUtil.printMap(map);	//map console log

		String jsonStr = (String)map.get("aList");
		Gson gson = new Gson();
		ArrayList<Map> actList = null;
		actList = gson.fromJson(jsonStr, java.util.ArrayList.class);

		//activity 들중 dummy 데이터 삭제
		for(int i=actList.size()-1; i>=0; i--){
			//logger.debug("###############" + actList.get(i).get("name") + ":::::" + actList.get(i).get("sort"));

			if(actList.get(i).get("activityId")!=null) {
				actList.get(i).put("activityId", (int)Double.parseDouble((actList.get(i).get("activityId").toString())));		//화면에서 넘어올때, 숫자가 gson에 의해 소숫점으로 변환되는것을 정수화
			}
			actList.get(i).put("level", (int)Double.parseDouble((actList.get(i).get("level").toString())));		//화면에서 넘어올때, 숫자가 gson에 의해 소숫점으로 변환되는것을 정수화

			if("".equals(actList.get(i).get("name").toString().trim())){
				actList.remove(i);
			}else {
				actList.get(i).put("projectId",	map.get("projectId"));		//프로젝트id	추가
				actList.get(i).put("userSeq", 	loginUser.get("userId").toString()); 	//수정자id	추가
			}
		}


		int upCnt = 1;								//성공 '1'(임시값)

		map.put("aList", actList);					//json string 을 ArrayList 로 바꿔 전달한다.

		String mode = map.get("mode").toString();	//'new' or 'update'

		if("update".equals(mode)){					//수정저장

			//날짜 validation
			List<EgovMap> dateList = projectMgmtService.getEditMinMaxDate((Map)map);

			boolean enableChk = true;


			//-------------프로젝트 기간 밸리데이션 : S

			if(dateList.size()>0){

				Map MaxObj = DateUtil.getMaxDate(dateList, "maxDate");
				Map MinObj = DateUtil.getMinDate(dateList, "minDate");

				Date startDt;
				Date endDt;
				Date minDt;
	  			Date maxDt;

	  			startDt = DateUtil.getDate(map.get("startDate").toString(),"yyyy-MM-dd");
	  			endDt = DateUtil.getDate(map.get("endDate").toString(),"yyyy-MM-dd");

	  			minDt = DateUtil.getDate(MinObj.get("minDate").toString(),"yyyy-MM-dd");
	  			maxDt = DateUtil.getDate(MaxObj.get("maxDate").toString(),"yyyy-MM-dd");

	  			int startChk = DateUtil.getDiffDayCountTwoDate(startDt,minDt);
	  			int endChk = DateUtil.getDiffDayCountTwoDate(maxDt,endDt);

	  			if(startChk<0 || endChk<0){

	  				enableChk = false;

	  				if(startChk<0){
	  					msg = "등록된 " + MinObj.get("typeStr").toString()+" 이(가) 있습니다. \n시작일을 "+ MinObj.get("minDate").toString()+" 이전으로 설정해주세요.";
	  				}else{
	  					msg = "등록된 " + MaxObj.get("typeStr").toString()+" 이(가) 있습니다. \n종료일을 "+ MaxObj.get("maxDate").toString()+" 이후로 설정해주세요.";
	  				}

	  			}

			}

			//-------------액티비티 기간 밸리데이션 : S

			if(enableChk){

				for(int i=0; i<actList.size(); i++){

					List<EgovMap> actDateList = projectMgmtService.getEditMinMaxDate((Map)actList.get(i));

					Map MaxObj = DateUtil.getMaxDate(actDateList, "maxDate");
					Map MinObj = DateUtil.getMinDate(actDateList, "minDate");

					Date startDt;
					Date endDt;
					Date minDt;
		  			Date maxDt;

		  			startDt = DateUtil.getDate(actList.get(i).get("startDate").toString(),"yyyy-MM-dd");
		  			endDt = DateUtil.getDate(actList.get(i).get("endDate").toString(),"yyyy-MM-dd");

		  			minDt = DateUtil.getDate(MinObj.get("minDate").toString(),"yyyy-MM-dd");
		  			maxDt = DateUtil.getDate(MaxObj.get("maxDate").toString(),"yyyy-MM-dd");

		  			int startChk = DateUtil.getDiffDayCountTwoDate(startDt, minDt);
		  			int endChk = DateUtil.getDiffDayCountTwoDate(maxDt, endDt);

		  			if(startChk<0 || endChk<0){

		  				enableChk = false;

		  				if(startChk<0){
		  					msg = actList.get(i).get("name")+"에 등록된 " + MinObj.get("typeStr").toString()+"이(가) 있습니다. \n시작일을 "+ MinObj.get("minDate").toString()+" 이전으로 설정해주세요.";
		  				}else{
		  					msg = actList.get(i).get("name")+"에 등록된 " + MaxObj.get("typeStr").toString()+"이(가) 있습니다.	\n종료일을 "+ MaxObj.get("maxDate").toString()+" 이후로 설정해주세요.";
		  				}

		  				break;

		  			}

				}
			}


			if(enableChk){

				projectMgmtService.updateProject(map);
				upCnt = Integer.parseInt(map.get("projectId").toString());		//upCnt : 수정한 projectId

			}else{
				upCnt = -8;

			}




		}else{	//"new"								//신규등록
			map.put("projectClass", "GENERAL");  // 프로젝트 등록시 프로젝트유형 디폴트값으로 'GENERAL' 입력함
			upCnt = projectMgmtService.insertProject(map);					//upCnt : 실제 넘어오는 값은 아이디(projectId) 이다
		}

		resultMap.put("resultVal",upCnt);
		resultMap.put("resultMsg",msg);

		AjaxResponse.responseAjaxObject(response, resultMap);
	}


	/**
	 * 프로젝트 복사 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	@RequestMapping(value = "/project/doCopyProject.do")
	public void doCopyProject(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int newProjectId = projectMgmtService.copyProject(map);

		AjaxResponse.responseAjaxSave(response, newProjectId);	//결과전송
		//return "project/projectReg";
	}

	/**
	 * 프로젝트 보기 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/projectView.do")
	public String projectView(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "project/projectView";
	}


	/**
	 * 프로젝트 보기 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/getProjectInfo.do")
	public void getProjectInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map<String,Object> result = new HashMap<String,Object>();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());	//user_id(sequence)
		map.put("deptLevel", baseUserLoginInfo.get("deptLevel").toString());
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());

		//프로젝트
		List<Map> tList = projectMgmtService.getProjectInfo(map);
		result.put("pProject", (tList.size()>0)?tList.get(0):null);

		//activity
		List<Map> list = projectMgmtService.getActivityList((Map)map);
		result.put("pActivity", list);

		//프로젝트 or 액티비티 등록 업무,일정,전자결재 날짜조회
		List<EgovMap> dateList = projectMgmtService.getEditMinMaxDate((Map)map);
		result.put("dateList", dateList);

		//지켜보는직원 리스트
		List<EgovMap> viewEntryList = projectMgmtService.getViewEntryList((Map)map);
		result.put("viewEntryList", viewEntryList);


		AjaxResponse.responseAjaxObject(response, result);	//결과전송
	}



	//--------------------------------------------------- 프로젝트 참여 관련 --------------------------------------------------------

	/**
	 * 프로젝트 참여 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 19.
	 */
	@RequestMapping(value = "/project/userActivityAllocMgmt.do")
	public String userActivityAllocMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {


		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("project/userActivityAllocMgmt") == -1){
			return "redirect:/";
		}


		return "project/userActivityAllocMgmt";
	}


	/**
	 * 프로젝트, activity 별 배정직원 등록 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	@RequestMapping(value = "/project/doSaveUserProjectAlloc.do")
	public void doSaveUserProjectAlloc(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");


		LogUtil.printMap(map);	//map console log

		map.put("userSeq", loginUser.get("userId").toString());	//user_id(sequence)

		String jsonStr = (String)map.get("aList");
		Gson gson = new Gson();
		ArrayList<Map> actList = null;
		actList = gson.fromJson(jsonStr, java.util.ArrayList.class);

		//activity 들중 dummy 데이터 삭제
		for(int i=actList.size()-1; i>=0; i--){
			//logger.debug("###############" + actList.get(i).get("name") + ":::::" + actList.get(i).get("sort"));

			actList.get(i).put("activityId", (int)Double.parseDouble((actList.get(i).get("activityId").toString())));	//화면에서 넘어올때, 숫자가 gson에 의해 소숫점으로 변환되는것을 정수화
			actList.get(i).put("level", (int)Double.parseDouble((actList.get(i).get("level").toString())));				//화면에서 넘어올때, 숫자가 gson에 의해 소숫점으로 변환되는것을 정수화

			actList.get(i).put("projectId",	map.get("projectId"));		//프로젝트id	추가
			actList.get(i).put("userSeq", 	loginUser.get("userId").toString()); 	//수정자id	추가

		}


		int upCnt = 1;								//성공 '1'(임시값)

		map.put("aList", actList);					//json string 을 ArrayList 로 바꿔 전달한다.

		LogUtil.printMap(map);	//map console log	///////////////////////////////////////////////////////!!!!!!!!!!! 삭제 하자 테스트!!!!!!!!!!!!!!!!!!!

		projectMgmtService.updateProjectUserAlloc(map);

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}

	//--------------------------------------------------- 개인별 조회 관련 --------------------------------------------------------

	/**
	 * 개인별 조회 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 19.
	 */
	@RequestMapping(value = "/project/userActivityMgmt.do")
	public String userActivityMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {


		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("project/userActivityMgmt") == -1){
			return "redirect:/";
		}


		return "project/userActivityMgmt";
	}


	/**
	 * 개인별 프로젝트 리스트 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 24.
	 */
	@RequestMapping(value = "/project/getUserProjectList.do")
	public void getUserProjectList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {

		Map userInfo = (HashMap)session.getAttribute("baseUserLoginInfo");
		map.put("applyOrgId", userInfo.get("applyOrgId").toString());				//ORG_ID
		map.put("orgId", userInfo.get("orgId").toString());				//ORG_ID

		Map<String,Object> resultMap;

		resultMap = projectMgmtService.getUserProjectList((Map)map);

		AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송

	}


	/**
	 * 개인별 프로젝트 보기 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/getUserProjectInfo.do")
	public void getUserProjectInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map userInfo = (HashMap)session.getAttribute("baseUserLoginInfo");
		map.put("applyOrgId", userInfo.get("applyOrgId").toString());				//ORG_ID

		Map<String,Object> result = new HashMap<String,Object>();

		//프로젝트
		List<Map> tList = projectMgmtService.getUserProjectInfo(map);
		result.put("pProject", (tList.size()>0)?tList.get(0):null);

		//activity
		List<Map> list = projectMgmtService.getUserActivityList((Map)map);
		result.put("pActivity", list);


		AjaxResponse.responseAjaxObject(response, result);	//결과전송
	}


	/**
	 * 개인별 기본 project 및 activity 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 25.
	 */
	@RequestMapping(value = "/project/changeUserDefaultPjtAct.do")
	public void changeUserDefaultPjtAct(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");


		LogUtil.printMap(map);	//map console log

		map.put("userSeq", loginUser.get("userId").toString());	//user_id(sequence)

		int upCnt = projectMgmtService.changeUserDefaultPjtAct(map);

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
	}


	/**
	 * activity 별 직원배정 등록 및 삭제 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 23.
	 */
	/*@RequestMapping(value = "/project/changeActivityUser.do")
	public void changeActivityUser(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		//SESSION check!
		String resStr = SessionUtil.getSessionCheckResult(request, response, SessionUtil.RES_TYPE_CLOSE);	//* RES_TYPE_CLOSE : 팝업로그인창 클로징
		if(!SessionUtil.SESSION_PASS.equals(resStr)){	//세션성공이 아닌경우(세션만료)
			return;
		}

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");


		LogUtil.printMap(map);	//map console log

		map.put("userSeq", loginUser.getUserId());	//user_id(sequence)

		int upCnt = projectMgmtService.changeActivityUser(map);

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
	}*/


	/**
	 * 프로젝트 삭제 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 06. 07.
	 */
	/*@RequestMapping(value = "/project/doDeleteProject.do")
	public void doDeleteProject(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");


		LogUtil.printMap(map);	//map console log

		map.put("userSeq", loginUser.get("userId").toString());	//user_id(sequence)


		String mode = map.get("mode").toString();	//'new' or 'update'

		int upCnt = 0;
		if("update".equals(mode)){					//수정모드 이면서 삭제

			projectMgmtService.deleteProject(map);	//삭제

			upCnt = Integer.parseInt(map.get("projectId").toString());		//upCnt : 수정한 projectId

		}

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
	}*/


	/**
	 * 개인별 activity list (타임시트 사용) ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/getUserActivityListForTimesheet.do")
	public void getUserActivityListForTimesheet(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		List<Map> list = projectMgmtService.getUserActivityListForTimesheet(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}

	/**
	 * 프로젝트/엑티비티 조회 (공통js)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/project/getBaseCommonProject.do")
	public void getBaseCommonProject(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("roleId", loginUser.get("userRoleId").toString());		//user_id(sequence)

		List<Map> list = projectMgmtService.getBaseCommonProject(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 마감일 정보
	 *

	 */
	@RequestMapping(value = "/project/chkCloseDate.do")
	public void chkCloseDate(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		Map resultMap = projectMgmtService.chkCloseDateInfo(map);

		AjaxResponse.responseAjaxObject(response, resultMap);	//결과전송
	}

	/**
	 * 마감일 경고창
	 *
	 */
	@RequestMapping(value = "/project/alertCloseDatePop/pop.do")
	public String alertCloseDatePop(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		model.addAllAttributes(map);

		return "/project/alertCloseDatePop/pop";
	}


	/**
	 * 출장비, 구매품의 ,교육품의,지출 프로젝트 금액 벨리데이션
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/project/getProjectExpenseValid.do")
	public void getProjectExpenseValid(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		EgovMap expenseMap = projectMgmtService.getProjectExpenseValid(map);
		AjaxResponse.responseAjaxObject(response, expenseMap);	//결과전송
	}

	/**
	 * 프로젝트 지출 상세 팝업
	 *
	 */
	@RequestMapping(value = "/project/expenseListPop/pop.do")
	public String expenseListPop(@RequestParam Map<String,Object> map,
			HttpSession session, ModelMap model) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		model.addAllAttributes(map);

		return "project/pop/expenseListPop/pop";
	}

	/**
	 * 프로젝트 지출 리스트
	 *
	 */
	@RequestMapping(value = "/project/getExpenseList.do")
	public void getExpenseList(@RequestParam Map<String,Object> map,HttpServletResponse response,
			HttpSession session, ModelMap model) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());

		Map resultMap = projectMgmtService.getExpenseList(map);

		AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송

	}

	/************************************************************************************
	 * 기본 프로젝트
	 ************************************************************************************/

	/**
	 * 프로젝트 > 기본관리 > 휴가항목
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/project/projectVacationMgmt.do")
	public String projectVacationMgmt(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		map.put("projectClass", "VACATION");
		Map resultMap = projectMgmtService.getBaseProjectId(map);

		map.put("projectId", resultMap.get("projectId").toString());
		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
		return "project/projectVacationMgmt";
	}

	/**
	 * 프로젝트 > 기본관리 > 기본업무
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/project/projectBaseMgmt.do")
	public String projectBaseMgmt(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		map.put("projectClass", "BASE");
		Map resultMap = projectMgmtService.getBaseProjectId(map);

		map.put("projectId", resultMap.get("projectId").toString());
		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
		return "project/projectBaseMgmt";
	}

	/**
	 * 프로젝트 기본보기 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/getBaseProjectInfo.do")
	public void getBaseProjectInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map<String,Object> result = new HashMap<String,Object>();

		//프로젝트
		EgovMap projectMap = projectMgmtService.getBaseProjectInfo(map);
		result.put("pProject", projectMap);

		//activity
		List<Map> list = projectMgmtService.getBaseActivityList((Map)map);
		result.put("pActivity", list);

		AjaxResponse.responseAjaxObject(response, result);	//결과전송
	}

	/**
	 * 프로젝트 등록 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	@RequestMapping(value = "/project/doSaveBaseProject.do")
	public void doSaveBaseProject(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		LogUtil.printMap(map);	//map console log

		String jsonStr = (String)map.get("aList");
		Gson gson = new Gson();
		ArrayList<Map> actList = null;
		actList = gson.fromJson(jsonStr, java.util.ArrayList.class);

		//activity 들중 dummy 데이터 삭제
		for(int i=actList.size()-1; i>=0; i--){
			//logger.debug("###############" + actList.get(i).get("name") + ":::::" + actList.get(i).get("sort"));

			if(actList.get(i).get("activityId")!=null) {
				actList.get(i).put("activityId", (int)Double.parseDouble((actList.get(i).get("activityId").toString())));		//화면에서 넘어올때, 숫자가 gson에 의해 소숫점으로 변환되는것을 정수화
			}
			actList.get(i).put("level", (int)Double.parseDouble((actList.get(i).get("level").toString())));		//화면에서 넘어올때, 숫자가 gson에 의해 소숫점으로 변환되는것을 정수화

			if("".equals(actList.get(i).get("name").toString().trim())){
				actList.remove(i);
			}else {
				actList.get(i).put("projectId",	map.get("projectId"));		//프로젝트id	추가
				actList.get(i).put("userSeq", 	loginUser.get("userId").toString()); 	//수정자id	추가
			}
		}

		int upCnt = 1;								//성공 '1'(임시값)
		map.put("aList", actList);					//json string 을 ArrayList 로 바꿔 전달한다.

		projectMgmtService.updateBaseProject(map);
		upCnt = Integer.parseInt(map.get("projectId").toString());		//upCnt : 수정한 projectId

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
	}

	/**
	 * 프로젝트 상태변경(보류,중단,보류취소,중단취소)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	@RequestMapping(value = "/project/processStatus.do")
	public void processStatus(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", loginUser.get("userId").toString());						//user_id(sequence)
		map.put("userName", loginUser.get("userName").toString());					//userName
		map.put("sessionProjectTitle", loginUser.get("projectTitle").toString());	//프로젝트 타이틀 명

		int upCnt = projectMgmtService.processStatus(map);
		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
		//return "project/projectReg";
	}

	//프로젝트 현황퍼블요청........................................
	@RequestMapping(value = "/project/projectStatusList.do")
	public String projectStatusList(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		return "project/projectStatusList";
	}
	@RequestMapping(value = "/project/projectStatusDetail.do")
	public String projectStatusDetail(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());		//user_id(sequence)

		map.put("chkSearchMore","N");
		map.put("maxPageRow", 5);

		/*List<Map> projectStatusList = projectMgmtService.searchProjectStatusList(map);

		model.addAttribute("projectStatusList", projectStatusList);
		model.addAttribute("maxPageRow", 5);*/

		return "project/projectStatusDetail";
	}

	/**
	 * 프로젝트 상세 조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/projectInfoViewPop.do")
	public String projectInfoViewPop(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "project/pop/projectViewPop/inc";
	}

	/**
	 * 프로젝트 현황 리스트 > 첨부파일 목록 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/projectStatusDetailFileListPop.do")
	public String projectStatusDetailFileListPop(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "project/pop/projectStatusDetailFileListPop/pop";
	}

	/**
	 *
	 * 기안문서 //결재문서//참조문서 상세화면으로 이동한다.
	 *
	 * @param : HttpSession
	 * @return : String "approve/getApproveDetail"
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/project/projectStatusDetailApprovePop.do")
	public String getApproveDetail(HttpSession session,
								  @RequestParam Map<String,Object> paramMap,
								  Model model
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
        paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		EgovMap detailMap = approveService.getApproveDetail(paramMap);
		model.addAttribute("detailMap", detailMap);

		model.addAttribute("approveLineMap", approveService.getApproveLine(paramMap));

		model.addAttribute("searchMap",paramMap);

		//의견
		if(!detailMap.get("docStatus").toString().equals("WORKING")){
			model.addAttribute("commentList", approveService.getApproveProcessComment(paramMap));
		}

		return "approve/approveDocDetail/pop";

	}
	//프로젝트 현황 검색(전체/개인업무/팀업무/일정/전자결재/첨부파일)
	@RequestMapping(value = "/project/projectStatusDetailAjax.do")
	public String projectStatusDetailAjax(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());		//user_id(sequence)

		Integer maxPageRowBuf = Integer.parseInt(map.get("maxPageRow").toString())+1;
		map.put("maxPageRowBuf", maxPageRowBuf);
		List<Map> projectStatusList = projectMgmtService.searchProjectStatusList(map);

		model.addAttribute("projectStatusList", projectStatusList);
		model.addAttribute("maxPageRow", map.get("maxPageRow").toString());



		String returnString = "project/include/projectStatusDetail_list_INC/inc";
		String type = map.get("type").toString();
		if(type.equals("FILE")){
			returnString= "project/include/projectStatusDetail_file_INC/inc";
		}
		//String searchTreeYn = map.get("searchTreeYn").toString();

		//if(searchTreeYn.equals("Y")) returnString = "project/include/projectStatusDetail_contents_INC/inc";

		return returnString;
	}

	//프로젝트 현황 검색(WBS)
	@RequestMapping(value = "/project/projectStatusDetailWbsAjax.do")
	public String projectStatusDetailWbsAjax(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());		//user_id(sequence)

		List<EgovMap> wbsSummaryMaplist = projectMgmtService.searchWbsSummaryMapList(map);

		model.addAttribute("wbsSummaryMaplist",wbsSummaryMaplist);

		return "project/include/projectStatusDetail_wbs_INC/inc";
	}

	//지출 일괄 비차감 처리
	@RequestMapping(value = "/project/processNonExpenseAll.do")
	public void processNonExpenseAll(HttpSession session, @RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "mCheck", required = false) String[] mCheck, HttpServletResponse response)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("userName", baseUserLoginInfo.get("userName").toString());

		paramMap.put("mCheck", mCheck);

		projectMgmtService.processNonExpenseAll(paramMap);
		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}
	//지출 비용차감 처리
	@RequestMapping(value = "/project/processExpense.do")
	public void processExpense(HttpSession session, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("userName", baseUserLoginInfo.get("userName").toString());

		projectMgmtService.processExpense(paramMap);
		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	//지출 관련 상세 팝업 열람 권한 체크
	@RequestMapping(value = "/project/getValidProjectExpenseView.do")
	public void getValidProjectExpenseView(HttpSession session, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("myAuthIds", baseUserLoginInfo.get("myAuthIds").toString());

		String resultMsg =projectMgmtService.getValidProjectExpenseView(paramMap);
		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		if(resultMsg.equals("SUCCESS")){
			obj.put("result", "SUCCESS");
		}else{
			obj.put("result", "FAIL");
			obj.put("msg",resultMsg);
		}

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	////프로젝트 공통 트리에서 조회
	@RequestMapping(value = "/project/getProjectTreeList.do")
	public String getProjectTreeList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map baseUserLoginInfo = (HashMap)session.getAttribute("baseUserLoginInfo");

		if(!map.containsKey("orgId")){
			map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());				//ORG_ID
		}
		map.put("userId", baseUserLoginInfo.get("userId").toString());				//userId
		map.put("deptLevel", baseUserLoginInfo.get("deptLevel").toString());
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());
		map.put("myAuthIds", baseUserLoginInfo.get("myAuthIds").toString());

		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (map.containsKey("treePageIndex") && !map.get("treePageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(map.get("treePageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 15;

		/*if (map.containsKey("recordCountPerPage") && !map.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}
*/
		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(3);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		map.put("offset", firstRecordIndex);
		map.put("limit", recordCountPerPage);

		List<Map> projectTreeList = projectMgmtService.getProjectTreeList(map);
		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("projectTreeList",projectTreeList);

		return "common/include/projectDeptTree_projectTree_INC/inc";
	}

	//엑티비티 상세 검색(WBS)
	@RequestMapping(value = "/project/projectStatusWbsActivityDetailAjax.do")
	public String projectStatusWbsActivityDetailAjax(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());		//user_id(sequence)

		Calendar cal = Calendar.getInstance();

		String endDt = map.get("wbsActivityEndDt").toString();

		String startDt = map.get("wbsActivityStartDt").toString();

		String activityId = map.get("wbsActivityId").toString();

		map.put("activityId", activityId);

		String[] endDtBuf = endDt.split("-");

		int endYear = Integer.parseInt(endDtBuf[0]);

		//종료일의 주차 구하기
		Calendar dateCal = Calendar.getInstance();

		//오늘주차
		Integer nowWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);
		//오늘 달 (calendar class month)
		Integer nowMonth = dateCal.get(Calendar.MONTH);
		//오늘 일
		Integer nowDay = dateCal.get(Calendar.DATE);

		dateCal.set(Calendar.YEAR, endYear);
		dateCal.set(Calendar.MONTH, Integer.parseInt(endDtBuf[1])-1);
		dateCal.set(Calendar.DATE, Integer.parseInt(endDtBuf[2]));

		Integer endWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);


		String[] startDtBuf = startDt.split("-");


		dateCal.set(Calendar.YEAR, Integer.parseInt(startDtBuf[0]));
		dateCal.set(Calendar.MONTH, Integer.parseInt(startDtBuf[1])-1);
		dateCal.set(Calendar.DATE, Integer.parseInt(startDtBuf[2]));

		Integer startWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);

		int nowYear = cal.get(Calendar.YEAR);

		//조회연도
		Integer searchYear = nowYear;
		map.put("searchYear", searchYear);
		if(endYear<nowYear){
			searchYear=endYear;

			nowWeekNum = 99;

			cal.set(Calendar.YEAR, searchYear);
		}

		//조회 연도/달의 주차를 구함 (index : 0~11<달을 의미한다. )
		List<Integer> weekNumList = new ArrayList<Integer>();

		for(int i = 0 ; i <12 ; i++){
			cal.set(Calendar.MONTH,i);
			cal.set(Calendar.DATE,1);
			Integer lastday = cal.getActualMaximum(Calendar.DATE);

			cal.set(Calendar.DATE, lastday);

			weekNumList.add(cal.get(Calendar.WEEK_OF_MONTH));
		}

		//초기 rg셋팅



		model.addAttribute("weekNumList", weekNumList);

		model.addAttribute("endDt", endDt);
		model.addAttribute("startDt", startDt);
		model.addAttribute("thisYear", searchYear.toString());
		model.addAttribute("activityId",activityId);
		model.addAttribute("endWeekNum",endWeekNum);
		model.addAttribute("startWeekNum",startWeekNum);
		model.addAttribute("nowWeekNum",nowWeekNum);
		model.addAttribute("nowMonth",nowMonth);
		model.addAttribute("nowDay",nowDay);
		model.addAttribute("nowYear",nowYear);



		return "project/include/projectStatusDetail_wbsActivityDt_INC/inc";
	}

	/**
	 * wbs 엑티비티 상세영역에서 주차별/직원별 업무일지를 조회한다.
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/searchActivityWbsWorkDetailAjax.do")
	public void searchActivityWbsWorkDetailAjax(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map<String,Object> result = new HashMap<String,Object>();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());	//user_id(sequence)

		//해당 연도의 업무를 조회한다
		List<EgovMap> wbsWorkSearchList = projectMgmtService.getWbsWorkSearchList(map);

		result.put("wbsWorkSearchList", wbsWorkSearchList);

		//해당 엑티비티의 전체 진척률을 조회한다.
		EgovMap wbsWorkActivityTotMap = projectMgmtService.getWbsWorkActivityTotMap(map,wbsWorkSearchList);

		result.put("wbsWorkActivityTotMap", wbsWorkActivityTotMap);

		AjaxResponse.responseAjaxObject(response, result);	//결과전송
	}

	//프로젝트 상세 검색(WBS)
	@RequestMapping(value = "/project/searchProjectWbsWorkDetailAjax.do")
	public String searchProjectWbsWorkDetailAjax(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());		//user_id(sequence)

		Calendar cal = Calendar.getInstance();

		String endDt = map.get("wbsProjectEndDt").toString();

		String startDt = map.get("wbsProjectStartDt").toString();

		String projectId = map.get("wbsProjectId").toString();

		map.put("projectId", projectId);

		String[] endDtBuf = endDt.split("-");

		int endYear = Integer.parseInt(endDtBuf[0]);

		//종료일의 주차 구하기
		Calendar dateCal = Calendar.getInstance();

		//오늘주차
		Integer nowWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);
		//오늘 달 (calendar class month)
		Integer nowMonth = dateCal.get(Calendar.MONTH);
		//오늘 일
		Integer nowDay = dateCal.get(Calendar.DATE);

		dateCal.set(Calendar.YEAR, endYear);
		dateCal.set(Calendar.MONTH, Integer.parseInt(endDtBuf[1])-1);
		dateCal.set(Calendar.DATE, Integer.parseInt(endDtBuf[2]));

		Integer endWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);


		String[] startDtBuf = startDt.split("-");


		dateCal.set(Calendar.YEAR, Integer.parseInt(startDtBuf[0]));
		dateCal.set(Calendar.MONTH, Integer.parseInt(startDtBuf[1])-1);
		dateCal.set(Calendar.DATE, Integer.parseInt(startDtBuf[2]));

		Integer startWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);

		int nowYear = cal.get(Calendar.YEAR);

		//조회연도
		Integer searchYear = nowYear;
		map.put("searchYear", searchYear);
		if(endYear<nowYear){
			searchYear=endYear;

			nowWeekNum = 99;

			cal.set(Calendar.YEAR, searchYear);
		}

		//조회 연도/달의 주차를 구함 (index : 0~11<달을 의미한다. )
		List<Integer> weekNumList = new ArrayList<Integer>();

		for(int i = 0 ; i <12 ; i++){
			cal.set(Calendar.MONTH,i);
			cal.set(Calendar.DATE,1);
			Integer lastday = cal.getActualMaximum(Calendar.DATE);

			cal.set(Calendar.DATE, lastday);

			weekNumList.add(cal.get(Calendar.WEEK_OF_MONTH));
		}

		//프로젝트 진척률을 조회한다.
		map.put("year", searchYear.toString());
		Map<String,Object> progressMap = projectMgmtService.getProjectProgressInfo(map);

		model.addAttribute("progressMap", progressMap);
		model.addAttribute("weekNumList", weekNumList);

		model.addAttribute("endDt", endDt);
		model.addAttribute("startDt", startDt);
		model.addAttribute("thisYear", searchYear.toString());
		model.addAttribute("projectId",projectId);
		model.addAttribute("endWeekNum",endWeekNum);
		model.addAttribute("startWeekNum",startWeekNum);
		model.addAttribute("nowWeekNum",nowWeekNum);
		model.addAttribute("nowMonth",nowMonth);
		model.addAttribute("nowDay",nowDay);
		model.addAttribute("nowYear",nowYear);
		return "project/include/projectStatusDetail_wbsProjectDt_INC/inc";
	}

	//프로젝트 상세 검색(WBS)
	@RequestMapping(value = "/project/updateActivityInfo.do")
	public String updateActivityInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception{

		//해당 연도의 업무를 조회한다
		List<EgovMap> wbsWorkSearchList = projectMgmtService.getWbsWorkSearchList(map);

		//해당 엑티비티의 전체 진척률을 조회한다.
		EgovMap wbsWorkActivityTotMap = projectMgmtService.getWbsWorkActivityTotMap(map,wbsWorkSearchList);

		//result.put("wbsWorkActivityTotMap", wbsWorkActivityTotMap);
		String progressRate = wbsWorkActivityTotMap.get("progressRate").toString();

		Double progressRate2 = Double.parseDouble(progressRate);

		model.addAttribute("activityId",map.get("activityId"));
		model.addAttribute("year",map.get("year"));
		model.addAttribute("progressRate",Math.round(progressRate2));
		model.addAttribute("baseProgressYn", wbsWorkActivityTotMap.get("baseProgressYn"));
		model.addAttribute("startDate",map.get("startDate"));
		model.addAttribute("endDate",map.get("endDate"));

		return "project/pop/updateActivityInfo/pop";
	}

	//엑티비티 상세 수정
	@RequestMapping(value = "/project/updateActivityInfoAjax.do")
	public void updateActivityInfo(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "activityUser", required = false) String[] activityUser) throws Exception {

		logger.info("do Update Activity Info ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("sessionActivityTitle", baseUserLoginInfo.get("activityTitle").toString());//프로젝트 타이틀 명
		if (activityUser != null)
			paramMap.put("activityUser", activityUser);


		projectMgmtService.updateActivityInfo(paramMap);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	//프로젝트 엑티비티 수정이력(WBS)
	@RequestMapping(value = "/project/viewActivityUpdateHist.do")
	public String viewActivityUpdateHist(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		//////////////////////////조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (map.containsKey("pageIndex") && !map.get("pageIndex").toString().equals("")) {
		pageIndex = Integer.parseInt(map.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (map.containsKey("recordCountPerPage") && !map.get("recordCountPerPage").toString().equals("")) {
		recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		map.put("firstIndex", firstRecordIndex);
		map.put("recordCountPerPage", recordCountPerPage);

		//수정내역조회
		List<EgovMap> wbsWorkSearchList = projectMgmtService.viewActivityUpdateHist(map);

		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("wbsWorkSearchList", wbsWorkSearchList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("activityId",map.get("activityId"));


		return "project/pop/viewActivityUpdateHist/pop";
	}

	//프로젝트 엑티비티 수정이력(WBS)
	@RequestMapping(value = "/project/viewActivityUpdateHistAjax.do")
	public String viewActivityUpdateHistAjax(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		//////////////////////////조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (map.containsKey("pageIndex") && !map.get("pageIndex").toString().equals("")) {
		pageIndex = Integer.parseInt(map.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (map.containsKey("recordCountPerPage") && !map.get("recordCountPerPage").toString().equals("")) {
		recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		map.put("firstIndex", firstRecordIndex);
		map.put("recordCountPerPage", recordCountPerPage);

		//수정내역조회
		List<EgovMap> wbsWorkSearchList = projectMgmtService.viewActivityUpdateHist(map);

		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("wbsWorkSearchList", wbsWorkSearchList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("activityId",map.get("activityId"));


		return "project/include/viewActivityUpdateHist_INC/inc";
	}

	//프로젝트 엑티비티 월 주차 상세(WBS)
	@RequestMapping(value = "/project/searchWbsActivityViewMonthDetail.do")
	public String searchWbsActivityViewMonthDetail(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_WEEK,1);
		String year = map.get("year").toString();
		String month = map.get("month").toString();
		String weekNum = map.get("weekNum").toString();
		cal.set(Calendar.YEAR, Integer.parseInt(year));
		cal.set(Calendar.MONTH, Integer.parseInt(month));
		cal.set(Calendar.WEEK_OF_MONTH , Integer.parseInt(weekNum));

		Integer startMonth = cal.get(Calendar.MONTH);


		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String searchStartDt = sdf.format(cal.getTime());

		cal.set(Calendar.DAY_OF_WEEK,7);

		String searchEndDt = sdf.format(cal.getTime());

		Integer endMonth = cal.get(Calendar.MONTH);

		if(startMonth!=endMonth){

			if(startMonth == Integer.parseInt(month)){
				cal.set(Calendar.MONTH, startMonth);
				cal.set(Calendar.DATE,cal.getActualMaximum(Calendar.DATE));
				searchEndDt = sdf.format(cal.getTime());
			}else{
				cal.set(Calendar.MONTH, endMonth);
				cal.set(Calendar.DATE,1);
				searchStartDt = sdf.format(cal.getTime());
			}
		}


		map.put("searchStartDt", searchStartDt);
		map.put("searchEndDt", searchEndDt);

		List<EgovMap> wbsActivityViewMonthList = projectMgmtService.getWbsActivityViewMonthList(map);


		model.addAttribute("wbsActivityViewMonthList",wbsActivityViewMonthList);
		model.addAttribute("activityId",map.get("activityId"));


		return "project/pop/searchWbsActivityViewMonthDetail/pop";
	}

	//wbs월단위 엑티비티 상세
	@RequestMapping(value = "/project/searchWbsActivityViewMonthDetail2.do")
	public String searchWbsActivityViewMonthDetail2(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());		//user_id(sequence)

		Calendar cal = Calendar.getInstance();

		//오늘 달 (calendar class month)
		Integer nowMonth = cal.get(Calendar.MONTH);
		//오늘 일
		Integer nowDay = cal.get(Calendar.DATE);
		Integer nowYear = cal.get(Calendar.YEAR);

		String activityId = map.get("activityId").toString();

		map.put("activityId", activityId);

		String year = map.get("year").toString();
		String month = map.get("month").toString();

		cal.set(Calendar.DATE, 1);
		cal.set(Calendar.YEAR, Integer.parseInt(year));
		cal.set(Calendar.MONTH, Integer.parseInt(month));

		model.addAttribute("activityId", activityId);
		model.addAttribute("month", month);
		model.addAttribute("lastDay", cal.getActualMaximum(Calendar.DATE));
		model.addAttribute("thisYear", year);


		model.addAttribute("nowMonth",nowMonth);
		model.addAttribute("nowDay",nowDay);
		model.addAttribute("nowYear",nowYear);
		model.addAttribute("startDt",map.get("startDate"));
		model.addAttribute("endDt",map.get("endDate"));

		return "project/include/projectStatusDetail_wbsActivityMonthDt_INC/inc";
	}

	/**
	 * wbs 엑티비티 상세영역에서 월별/직원별 업무일지를 조회한다.
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/project/searchActivityMonthWbsWorkDetail.do")
	public void searchActivityMonthWbsWorkDetail(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map<String,Object> result = new HashMap<String,Object>();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());	//user_id(sequence)

		//해당 연도의 업무를 조회한다
		List<EgovMap> wbsWorkSearchList = projectMgmtService.getWbsWorkSearchList(map);

		result.put("wbsWorkSearchList", wbsWorkSearchList);

		//해당 엑티비티의 전체 진척률을 조회한다.
		/*EgovMap wbsWorkActivityTotMap = projectMgmtService.getWbsWorkActivityTotMap(map,wbsWorkSearchList);

		result.put("wbsWorkActivityTotMap", wbsWorkActivityTotMap);*/

		AjaxResponse.responseAjaxObject(response, result);	//결과전송
	}

	//진척율 리셋
	@RequestMapping(value = "/project/updateActivityProgressRate.do")
	public void updateActivityProgressRate(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("do Update Activity Progress reset ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());


		projectMgmtService.updateActivityProgressRate(paramMap);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	////////////////////////////////////////////신규 추가 17.10.12
	/**
	 * MY단위업무
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/projectMyWorkList.do")
	public String projectMyWorkList(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));
		map.put("orgId", baseUserLoginInfo.get("applyOrgId"));

		//처음 로드할때 오늘날짜 선택
		Calendar cal = Calendar.getInstance();

		Integer year = cal.get(Calendar.YEAR);

		Integer month = cal.get(Calendar.MONTH)+1;

		Integer date = cal.get(Calendar.DATE);


		model.addAttribute("searchYear",year);
		model.addAttribute("searchMonth",month);
		model.addAttribute("searchDate",date);

		//검색 날짜 셋팅을위해 매달의 마지막 날짜를 구한다
		Map<Integer,Integer> dayList = new HashMap<Integer, Integer>();
		for(int i = 0 ; i <12 ; i++){
			cal.set(Calendar.MONTH, i);
			Integer lastday = cal.getActualMaximum(Calendar.DATE);

			dayList.put(i+1, lastday);
		}
		model.addAttribute("dayList",dayList);


		//초기 진입할때검색조건
		map.put("searchPeriodYn", "N");

		//검색일 str을 만든다
		String searchDate = year+"-"+month+"-"+date;

		map.put("searchDate", searchDate);

		//MY단위업무 프로젝트 검색
		List<EgovMap> myProjectList = new ArrayList();

		if((baseUserLoginInfo.get("applyOrgId").toString()).equals(baseUserLoginInfo.get("orgId").toString())){

			myProjectList = projectMgmtService.getMyWorkProjectList(map);
		}

		model.addAttribute("myProjectList", myProjectList);

		//전자결재 SELECT박스 즐겨찾기 조회
		List<EgovMap> approveBookMarkList = approveService.getApproveBookmarkFormListForMyWorkList(map);

		model.addAttribute("approveBookMarkList", approveBookMarkList);
		//전자결재 사내서식 조회
		map.put("recordCountPerPage", "0");
		map.put("useDocYn", "Y");
		map.put("ruleUseYn", "N");
		List<EgovMap> companyFormList = approveService.getCompanyFormList(map);
		model.addAttribute("companyFormList", companyFormList);




		return "project/projectMyWorkList";
	}

	/**
	 * MY단위업무 검색 Ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/projectMyWorkListAjax.do")
	public String projectMyWorkListAjax(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));

		//처음 로드할때 오늘날짜 선택
		Calendar cal = Calendar.getInstance();

		Integer year = Integer.parseInt(map.get("searchYear").toString());

		Integer month = Integer.parseInt(map.get("searchMonth").toString());
		Integer date = Integer.parseInt(map.get("searchDate").toString());

		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month-1);

		//조회 날짜가 조회한 월의 마지막 일보다 크다면 마지막날짜가 조회되도록한다.
		Integer maxDate = cal.getActualMaximum(Calendar.DATE);

		if(maxDate<date) date = maxDate;


		cal.set(Calendar.DATE, date);

		//검색 날짜 셋팅을위해 매달의 마지막 날짜를 구한다
		Map<Integer,Integer> dayList = new HashMap<Integer, Integer>();
		for(int i = 0 ; i <12 ; i++){
			cal.set(Calendar.MONTH, i);
			Integer lastday = cal.getActualMaximum(Calendar.DATE);

			dayList.put(i+1, lastday);
		}
		model.addAttribute("dayList",dayList);

		//검색일 str을 만든다
		String searchDate = year+"-"+month+"-"+date;

		map.put("searchDate", searchDate);

		//MY단위업무 프로젝트 검색
		List<EgovMap> myProjectList = new ArrayList();

		if((baseUserLoginInfo.get("applyOrgId").toString()).equals(baseUserLoginInfo.get("orgId").toString())){

			myProjectList = projectMgmtService.getMyWorkProjectList(map);
		}
		//List<EgovMap> myProjectList = projectMgmtService.getMyWorkProjectList(map);

		model.addAttribute("myProjectList", myProjectList);

		return "project/include/projectMyWorkList_INC/inc";
	}

	/**
	 * My단위업무 연도 변경 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/getProjectMyWorkListDayListAjax.do")
	public String getProjectMyWorkListDayListAjax(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));

		//조회 데이터 셋팅
		Calendar cal = Calendar.getInstance();

		Integer year = Integer.parseInt(map.get("searchYear").toString());

		Integer month = Integer.parseInt(map.get("searchMonth").toString());
		Integer date = Integer.parseInt(map.get("searchDate").toString());

		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month-1);

		//조회 날짜가 조회한 월의 마지막 일보다 크다면 마지막날짜가 조회되도록한다.
		Integer maxDate = cal.getActualMaximum(Calendar.DATE);

		if(maxDate<date) date = maxDate;


		cal.set(Calendar.DATE, date);


		model.addAttribute("searchYear",year);
		model.addAttribute("searchMonth",month);
		model.addAttribute("searchDate",date);

		//검색 날짜 셋팅을위해 매달의 마지막 날짜를 구한다
		Map<Integer,Integer> dayList = new HashMap<Integer, Integer>();
		for(int i = 0 ; i <12 ; i++){
			cal.set(Calendar.MONTH, i);
			Integer lastday = cal.getActualMaximum(Calendar.DATE);

			dayList.put(i+1, lastday);
		}
		model.addAttribute("dayList",dayList);

		return "project/include/projectMyWorkList_dayOptionList_INC/inc";
	}

	/**
	 * My단위업무 Activity조회 Ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/getProjectMyWorkActivityAjax.do")
	public void getProjectMyWorkActivityAjax(HttpSession session
										  , HttpServletResponse response
										  , @RequestParam Map<String, Object> paramMap
										  , @RequestParam(value = "projectId", required = false) String[] projectIdArr
										  ) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		//프로젝트 별 엑티비티를 조회한다.
		paramMap.put("projectIdArr", projectIdArr);

		List<EgovMap> projectMyWorkActivityList = projectMgmtService.getProjectMyWorkActivity(paramMap);

		obj.put("projectMyWorkActivityList", projectMyWorkActivityList);

		//내일종료 , 오늘종료를 표시해주기위해 내일날짜와 오늘날짜를 구함
		Calendar cal = Calendar.getInstance();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		String today = sdf.format(cal.getTime());

		obj.put("today", today);

		cal.add(Calendar.DATE, 1);

		String tomorrow = sdf.format(cal.getTime());

		obj.put("tomorrow", tomorrow);

		obj.put("result", "SUCCESS");


		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 * WBS조회 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/projectWbsList.do")
	public String projectWbsList(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));

		//초기 진입할때는 상시업무만 검색한다
		map.put("searchPeriodYn", "N");
		//초기 진입할때는 진행프로젝트만 검색한다
		map.put("projectStatus", "PROGRESS");
		map.put("searchProjectViewer", "N");
		map.put("searchNoUseYn", "N");
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn"));
		//페이징 기초데이터
		Integer recordCountPerPage = 5;

		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, recordCountPerPage, 10);
		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		map.put("firstIndex", firstRecordIndex);
		map.put("recordCountPerPage", recordCountPerPage);
		//wbs조회 프로젝트 검색
		List<EgovMap> projectWbsList = projectMgmtService.getProjectWbsList(map);

		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("projectWbsList", projectWbsList);

		List<EgovMap> wbsSummaryMaplist = projectMgmtService.searchWbsSummaryMapList(map);

		model.addAttribute("wbsSummaryMaplist",wbsSummaryMaplist);

		return "project/projectWbsList";
	}

	/**
	 * WBS조회 페이지 Ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/projectWbsListAjax.do")
	public String projectWbsListAjax(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,Object> map) throws Exception {

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn"));

		//페이징 기초데이터
		Integer recordCountPerPage = 5;

		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, recordCountPerPage, 10);
		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		map.put("firstIndex", firstRecordIndex);
		map.put("recordCountPerPage", recordCountPerPage);
		//wbs조회 프로젝트 검색
		List<EgovMap> projectWbsList = projectMgmtService.getProjectWbsList(map);

		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("projectWbsList", projectWbsList);

		return "project/include/projectWbsList_INC/inc";
	}

	/**
	 * WBS조회 activity 상세 Ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/getProjectWbsActivityDtAjax.do")
	public String getProjectWbsActivityDtAjax(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());		//applyOrgId(sequence)

		//wbs조회 프로젝트 검색
		List<EgovMap> projectWbsActivityList = projectMgmtService.getProjectWbsActivityList(map);

		model.addAttribute("projectWbsActivityList", projectWbsActivityList);

		return "project/include/projectWbsList_activityDt_INC/inc";
	}

	/**
	 * My 단위업무 > 프로젝트 우선순위설정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/processProjectUserRank.do")
	public void processProjectUserRank(HttpSession session
										  , HttpServletResponse response
										  , @RequestParam Map<String, Object> paramMap
										  ) throws Exception{
		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("userId", loginUser.get("userId").toString());		//user_id(sequence)
		paramMap.put("applyOrgId", loginUser.get("applyOrgId").toString());		//applyOrgId(sequence)
		Map<String,Object> obj = new HashMap<String, Object>();

		projectMgmtService.processProjectUserRank(paramMap);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *  프로젝트 우선순위 중복 체크
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 12.
	 */

	@RequestMapping(value = "/project/chkSort.do")
	public void chkSort(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> map) throws Exception {


		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		String jsonStr = map.get("dataListStr").toString();
		System.out.println(jsonStr);
		//Gson gson = new Gson();
		//ArrayList<Map> dataList = null;
		//dataList = gson.fromJson(jsonStr, java.util.ArrayList.class);

		map.put("dataList", jsonStr.split(","));

		int chk = projectMgmtService.sortChk(map);

		if(chk != 0){
			chk = -8;
		}

		AjaxResponse.responseAjaxSave(response, chk); // "SUCCESS" 전달
	}

	/**
	 *  프로젝트 우선순위
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 12.
	 */

	@RequestMapping(value = "/project/saveSort.do")
	public void saveSort(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> map) throws Exception {


		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		String jsonStr = map.get("dataListStr").toString();

		Gson gson = new Gson();
		ArrayList<Map> dataList = null;
		dataList = gson.fromJson(jsonStr, java.util.ArrayList.class);

		map.put("dataList", dataList);


		projectMgmtService.saveSort(map);
		obj.put("result", "SUCCESS");


		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *  프로젝트 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 12.
	 */
	@RequestMapping(value = "/project/deleteProject.do")
	public void deleteProject(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> map) throws Exception {


		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("userId", baseUserLoginInfo.get("userId").toString());

		String confrimYn = map.get("confrimYn").toString();

		int cnt = -1;

		boolean deleteChk = false;		//삭제 가능여부 판별

		//확정상태
		if(confrimYn.equals("Y")){
			//날짜 validation
			map.put("onlyMax", "Y");

			List<EgovMap> dateList = projectMgmtService.getEditMinMaxDate((Map)map);

			if(dateList.size()>0){

				if(dateList.get(0).get("orgMinDate").toString().equals("") && dateList.get(0).get("orgMaxDate").toString().equals("")){
					deleteChk = true;
				}else{
					deleteChk = false;
				}
			}

		}else deleteChk = true;

		if(deleteChk){

			projectMgmtService.deleteProject(map);
			cnt = 1;

		}else cnt = -8;


		AjaxResponse.responseAjaxSave(response, cnt); // "SUCCESS" 전달
	}

	/**
	 *  프로젝트 수정이력
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */

	@RequestMapping(value = "/project/viewProjectHistoryList.do")
	public String viewProjectUpdateHist(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception{

		if (session.getAttribute("baseUserLoginInfo") == null) throw new Exception();

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());


		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (map.containsKey("pageIndex") && !map.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(map.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 5;

		if (map.containsKey("recordCountPerPage") && !map.get("recordCountPerPage").toString().equals("")) {
		recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);	// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(5);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		map.put("firstIndex", firstRecordIndex);
		map.put("recordCountPerPage", recordCountPerPage);

		List<Map>list = projectMgmtService.getProjectInfo(map);

		Map projectInfoMap = new HashMap();
		if(list.size() > 0) projectInfoMap = list.get(0);

		model.addAttribute("projectInfoMap", projectInfoMap);

		//수정내역조회
		List<EgovMap> projectHistoryList = projectMgmtService.getProjectHistoryList(map);

		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("projectHistoryList", projectHistoryList);

		model.addAttribute("projectId",map.get("projectId"));


		return "project/pop/viewProjectHistoryList/pop";
	}

	/**
	 *  프로젝트 수정이력 AJAX
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */

	@RequestMapping(value = "/project/viewProjectHistoryListAjax.do")
	public String viewProjectHistoryListAjax(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception{

		if (session.getAttribute("baseUserLoginInfo") == null) throw new Exception();

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());


		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (map.containsKey("pageIndex") && !map.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(map.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 5;

		if (map.containsKey("recordCountPerPage") && !map.get("recordCountPerPage").toString().equals("")) {
		recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);	// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(5);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		map.put("firstIndex", firstRecordIndex);
		map.put("recordCountPerPage", recordCountPerPage);

		//수정내역조회
		List<EgovMap> projectHistoryList = projectMgmtService.getProjectHistoryList(map);

		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("projectHistoryList", projectHistoryList);

		model.addAttribute("projectId",map.get("projectId"));


		return "project/include/viewProjectHistoryList_INC/inc";
	}



}
