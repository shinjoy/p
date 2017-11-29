package ib.basic.web;

import ib.basic.service.OrgService;
import ib.cmm.util.sim.service.AjaxResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
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

import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class OrgController {

	protected static final Log logger = LogFactory.getLog(OrgController.class);

	@Resource(name="orgService")
	private OrgService orgService;



	@RequestMapping(value="/basic/organizationList.do")
	public String organizationList(ModelMap model
			,HttpSession session, HttpServletRequest request) throws Exception {


		return "basic/organizationList/noLeft";
	}

	//조직도의 회사 리스트
	@RequestMapping(value="/basic/getCompanyStructList.do")
	public void getCompanyStructList(@RequestParam Map map, HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {


		List<Map> companyList= orgService.getCompanyStructList(map);

		AjaxResponse.responseAjaxSelect(response, companyList);		//"SUCCESS" 전달
	}

	//조직도의 등록 회사 리스트
	@RequestMapping(value="/basic/getCompanyList.do")
	public void getCompanyList(@RequestParam Map map, HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {


		List<Map> companyList= orgService.getCompanyList(map);

		AjaxResponse.responseAjaxSelect(response, companyList);		//"SUCCESS" 전달
	}

	//조직도 회사 저장
	@RequestMapping(value="/basic/saveCompanyStruct.do")
	public void saveCompanyStruct(@RequestParam Map map, HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {


		orgService.saveCompanyStruct(map);

		AjaxResponse.responseAjaxSave(response, 1);
	}

	//조직도 회사 저장
	@RequestMapping(value="/basic/deleteCompanyStruct.do")
	public void deleteCompanyStruct(@RequestParam Map map, HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {


		orgService.deleteCompanyStruct(map);

		AjaxResponse.responseAjaxSave(response, 1);
	}

	//회사 선택시 부서 반환
	@RequestMapping(value="/basic/getDeptListForOrg.do")
	public void getDeptListForOrg(@RequestParam Map map, HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {

		logger.debug("################## orgController.getDeptListForOrg() #############");
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String userId = baseUserLoginInfo.get("userId").toString();

		List<Map> deptList= orgService.getDeptListForOrg(map);

		AjaxResponse.responseAjaxSelect(response, deptList);		//"SUCCESS" 전달
	}

	//회사 선택시 부서 사원 정보 반환
	@RequestMapping(value="/basic/getUserListForDept.do")
	public void getUserListForDept(@RequestParam Map map, HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {

		logger.debug("################## orgController.getUserListForDept() #############");
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String userId = baseUserLoginInfo.get("userId").toString();
		map.put("hideSynergyUserYn", baseUserLoginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부

		List<Map> deptList= orgService.selectDeptUserList(map);

		AjaxResponse.responseAjaxSelect(response, deptList);		//"SUCCESS" 전달
	}

	//사원 정보 팝업 보기
	@RequestMapping(value="/basic/getOrgUserPop.do")
	public String getOrgUserPop(@RequestParam Map map, HttpServletResponse response,ModelMap model
			,HttpSession session, HttpServletRequest request) throws Exception {
		logger.debug("################## orgController.getOrgUserPop() #############");
		model.addAllAttributes(map);
		return "basic/orgPersonnelView/pop";
	}

	//사원 상세 정보 보기
	@RequestMapping(value="/basic/selectListUserPopForOrg.do")
	public void selectListUserPopForOrg(@RequestParam Map map, HttpServletResponse response,ModelMap model
			,HttpSession session, HttpServletRequest request) throws Exception {
		logger.debug("################## orgController.selectListUserPopForOrg() #############");
		map.put("realPath", request.getRealPath("/data/"));
		Map result = orgService.selectUserDetailInfoForOrg(map);
		AjaxResponse.responseAjaxObject(response, result);		//"SUCCESS" 전달
	}

	//직원혹은 직무 검색 시
	@RequestMapping(value="/basic/searchStaffNmWorkPop.do")
	public String searchStaffNmWorkPop(ModelMap model,@RequestParam Map map
			,HttpSession session, HttpServletRequest request) throws Exception {

		model.addAllAttributes(map);
		return "basic/orgPersonnelSearch/pop";
	}

	//직원명 검색
	@RequestMapping(value="/basic/searchStaffNmForOrg.do")
	public void searchStaffNmForOrg(@RequestParam Map map, HttpServletResponse response,ModelMap model
			,HttpSession session, HttpServletRequest request) throws Exception {
		logger.debug("################## orgController.searchStaffNmForOrg() ########### param : ["+ map +"]############");
		List<Map> list = orgService.searchStaffNmOrWorkForOrg(map);
		AjaxResponse.responseAjaxSelect(response, list);
	}

	//직무명 검색
	@RequestMapping(value="/basic/searchWorkNmForOrg.do")
	public void searchWorkNmForOrg(@RequestParam Map map, HttpServletResponse response,ModelMap model
			,HttpSession session, HttpServletRequest request) throws Exception {
		logger.debug("################## orgController.searchWorkNmForOrg() ############ param : ["+ map +"]############");
		List<Map> list = orgService.searchStaffNmOrWorkForOrg(map);
		AjaxResponse.responseAjaxSelect(response, list);
	}
}
