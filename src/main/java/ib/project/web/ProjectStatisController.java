package ib.project.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tika.parser.ParseContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.project.service.ProjectStatisService;
import ib.system.service.OrgCompanyRegService;


/**
 * <pre>
 * package	:
 * filename	:
 * </pre>
 *
 *
 *
 * @author	:
 * @date	:
 * @version :
 *
 */
@Controller
public class ProjectStatisController {

	@Resource(name="projectStatisService")
	private ProjectStatisService projectStatisService;

	@Resource(name = "orgCompanyRegService")
	private OrgCompanyRegService orgCompanyRegService;

	protected static final Log logger = LogFactory.getLog(ProjectMgmtController.class);

	/**
	 * 프로젝트 목록 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		:
	 * @date		:
	 */
	@RequestMapping(value = "/project/projectStatisList.do")
	public String projectStatisList(HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response,
			ModelMap model,
			@RequestParam Map<String, Object> paramMap) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));

		return "project/projectStatisList";
	}


	/**
	 * 프로젝트, 액티비티, 업무일지 통계(부서별)Ajax
	 *
	 * @param     :
	 * @return    :
	 * @exception :
	 * @author    :
	 * @date      :
	 */
	@RequestMapping(value = "/project/projectStatisTopAjax.do")
	public String projectStatisTopAjax(@RequestParam Map<String,Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpSession session) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		model.addAttribute("userId", baseUserLoginInfo.get("userId"));  		// 사용자ID
		model.addAttribute("userName", baseUserLoginInfo.get("userName"));  	// 사용자이름
		model.addAttribute("deptId", baseUserLoginInfo.get("deptId"));  		// 부서ID
		model.addAttribute("deptNm", baseUserLoginInfo.get("deptNm"));  		// 부서명
		model.addAttribute("deptLevel", baseUserLoginInfo.get("deptLevel"));    // 부서레벨
		model.addAttribute("deptMngrYn", baseUserLoginInfo.get("deptMngrYn"));  // 부서장 여부
		model.addAttribute("vipAuthYn", baseUserLoginInfo.get("vipAuthYn"));  // 특별권한 여부

		//paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));

		//-- 유저...
		if( paramMap.get("kindType").toString().equals("U") ){
			EgovMap userInfo = projectStatisService.getUserName(paramMap);
			model.addAttribute("userInfo", userInfo);
		//-- 부서...
		}else if( paramMap.get("kindType").toString().equals("D") ||
			paramMap.get("kindType").toString().equals("A") ){
			EgovMap deptInfo = projectStatisService.getDeptName(paramMap);
			model.addAttribute("deptInfo", deptInfo);
		}

		//-- 프로젝트전체(임시저장, 예정, 진행, 보류, 중단, 마감대기, 마감)
		EgovMap projectStatus = projectStatisService.getProjectStatus(paramMap);
		model.addAttribute("projectStatus", projectStatus);

		//-- 액티비티전체(예정, 진행, 사용안함, 마감)
		EgovMap activityStatus = projectStatisService.getActivityStatus(paramMap);
		model.addAttribute("activityStatus", activityStatus);

		//-- 업무일지전체(팀업무/개인업무)
		EgovMap officeDaily = projectStatisService.getOfficeDaily(paramMap);
		model.addAttribute("officeDaily", officeDaily);

		return "project/include/projectStatisTopList_INC/inc";
	}

	/**
	 * 부서별비교/개인 통계 Ajax
	 *
	 * @param     :
	 * @return    :
	 * @exception :
	 * @author    :
	 * @date      :
	 */
	@RequestMapping(value = "/project/projectStatisBottomAjax.do")
	public String projectStatisBottomAjax(@RequestParam Map<String,Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpSession session) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		model.addAttribute("userId", baseUserLoginInfo.get("userId"));  		// 사용자ID
		model.addAttribute("deptId", baseUserLoginInfo.get("deptId"));  		// 부서ID
		model.addAttribute("deptLevel", baseUserLoginInfo.get("deptLevel"));    // 부서레벨
		model.addAttribute("deptMngrYn", baseUserLoginInfo.get("deptMngrYn"));  // 부서장 여부
		model.addAttribute("vipAuthYn", baseUserLoginInfo.get("vipAuthYn"));  // 특별권한 여부

		//paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));


		String listType = paramMap.get("kindType").toString();
		//-- 부서별비교(참여 프로젝트, 참여 액티비티, 팀업무, 개인업무)
		if( listType.equals("A") ){
			List<Map> deptCompareList = projectStatisService.getDeptCompareList(paramMap);
			model.addAttribute("deptCompareList", deptCompareList);
		//-- 개인별(프로젝트, 액티비티, 개인업무, 팀업무)
		}else if( listType.equals("D") || listType.equals("U") ){
			List<Map> projectInfoList = projectStatisService.getProjectInfoList(paramMap);
			model.addAttribute("projectInfoList", projectInfoList);
		}

		return "project/include/projectStatisBottomList_INC/inc";
	}

	/**
	 * 프로젝트전체(PieChart)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		:
	 * @date		:
	 */
	@RequestMapping(value="/project/projectPieChartAjax.do")
	@ResponseBody
	public void projectPieChartAjax(
			HttpServletResponse response,
			Model model,
			HttpSession session,
			@RequestParam Map<String, Object> map
			) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		// map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		EgovMap result = projectStatisService.getProjectStatus(map);

		Integer cnt = Integer.parseInt(result.get("totalCnt").toString());

		HashMap<String, Object> obj = new HashMap<String, Object>();

		// 삽입(프론트에서 배열형태로 받는다)
		obj.put("result", result);
		obj.put("cnt", cnt);

		AjaxResponse.responseAjaxObject(response, obj);
	}

	/**
	 * 액티비티전체(PieChart)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		:
	 * @date		:
	 */
	@RequestMapping(value="/project/activityPieChartAjax.do")
	public void activityPieChartAjax(
			HttpServletResponse response,
			Model model,
			HttpSession session,
			@RequestParam Map<String, Object> map
			) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		// map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		EgovMap result = projectStatisService.getActivityStatus(map);

		Integer cnt = Integer.parseInt(result.get("totalCnt").toString());

		HashMap<String, Object> obj = new HashMap<String, Object>();

		// 삽입(프론트에서 배열형태로 받는다)
		obj.put("result", result);
		obj.put("cnt", cnt);

		AjaxResponse.responseAjaxObject(response, obj);
	}

	/**
	 * (프로젝트)액티비티전체(PieChart)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		:
	 * @date		:
	 */
	@RequestMapping(value="/project/projectActivityPieChartAjax.do")
	public void projectActivityPieChartAjax(
			HttpServletResponse response,
			Model model,
			HttpSession session,
			@RequestParam Map<String, Object> map
			) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("projectId", map.get("projectId").toString());

		//-- 프로젝트 액티비티전체(예정, 진행, 사용안함, 마감)
		EgovMap result = projectStatisService.getProjectActivityStatus(map);

		Integer cnt = Integer.parseInt(result.get("totalCnt").toString());

		HashMap<String, Object> obj = new HashMap<String, Object>();

		// 삽입(프론트에서 배열형태로 받는다)
		obj.put("result", result);
		obj.put("cnt", cnt);

		AjaxResponse.responseAjaxObject(response, obj);
	}

	/**
	 * 업무일지전체(PieChart)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		:
	 * @date		:
	 */
	@RequestMapping(value="/project/officePieChartAjax.do")
	public void officePieChartAjax(
			HttpServletResponse response,
			Model model,
			HttpSession session,
			@RequestParam Map<String, Object> map
			) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		//map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		EgovMap result = projectStatisService.getOfficeDaily(map);
		float cnt = Float.parseFloat(result.get("workTotalCnt").toString());

		HashMap<String, Object> obj= new HashMap<String, Object>();

		// 삽입(프론트에서 배열형태로 받는다)
		obj.put("result", result);
		obj.put("cnt", cnt);

		AjaxResponse.responseAjaxObject(response, obj);
	}

	/**
	 * 부서별비교(BarChart)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		:
	 * @date		:
	 */
	@RequestMapping(value="/project/deptCompareChartAjax.do")
	public void deptCompareChartAjax(
			HttpServletResponse response,
			Model model,
			HttpSession session,
			@RequestParam Map<String, Object> map
			) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		// map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		List<Map> result = null;
		result = projectStatisService.getDeptCompareList(map);
		HashMap<String, Object> obj = new HashMap<String, Object>();

		// 삽입(프론트에서 배열형태로 받는다)
		obj.put("result", result);

		AjaxResponse.responseAjaxObject(response, obj);
	}

	/**
	 * 프로젝트 액티비티전체
	 *
	 * @param     :
	 * @return    :
	 * @exception :
	 * @author    :
	 * @date      :
	 */
	@RequestMapping(value = "/project/projectActivityWorkStatusAjax.do")
	public String projectActivityStatusAjax(
			@RequestParam Map<String, Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpSession session) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		//paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));

		//-- 프로젝트 액티비티전체(예정, 진행, 사용안함, 마감)
		EgovMap projectActivityStatus = projectStatisService.getProjectActivityStatus(paramMap);
		model.addAttribute("projectActivityStatus", projectActivityStatus);
		//-- 팀업무, 개인업무, 업무전체
		List<Map> projectTeamPrivateWorkList = projectStatisService.getProjectTeamPrivateWorkList(paramMap);
		model.addAttribute("projectTeamPrivateWorkList", projectTeamPrivateWorkList);
		//-- 직원
		model.addAttribute("projectUserList", projectStatisService.getProjectUserList(paramMap));
		//-- 액티비티
		model.addAttribute("activityList", projectStatisService.getActivityList(paramMap));

		//프로젝트별 참여도
		List<Map> projectWorkList = projectStatisService.getProjectWorkList(paramMap);
		model.addAttribute("projectWorkList", projectWorkList);

		model.addAllAttributes(paramMap);

		return "project/include/projectStatisProjectList_INC/inc";
	}
}
