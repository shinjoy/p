package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.DeptRegService;
import ib.system.service.OrgCompanyRegService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

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
 * filename	: DeptRegController.java
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
public class DeptRegController {

	@Resource(name = "deptRegService")
	private DeptRegService deptRegService;

	@Resource(name = "orgCompanyRegService")
	private OrgCompanyRegService orgCompanyRegService;

	protected static final Log logger = LogFactory.getLog(DeptRegController.class);


	/**
	 * 부서관리
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 17.
	 */
	@RequestMapping(value = "/system/deptMgmt.do")
	public String deptMgmt(HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelMap model) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		Map paramMap = new HashMap<String,Object>();
		paramMap.put("userId", loginUser.get("userId"));
		paramMap.put("orgBasicAuth", loginUser.get("orgBasicAuth"));
		model.addAttribute("orgCompList", orgCompanyRegService.getOrgRelationAuthListOnlyUserId(paramMap));

		return "system/deptMgmt";
	}



	/**
	 * 부서 리스트
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/getDeptList.do")
	public void getDeptList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam Map<String, String> map) throws Exception {

		map.put("orgId", (String)map.get("targetOrgId"));
		List<Map> list = deptRegService.getDeptList(map);

		AjaxResponse.responseAjaxSelect(response, list); // 결과전송
	}


	/**
	 * 부서등록
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/addDept.do")
	public String addDept(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());

		//수정인 경우 관계사 정보 매핑처리
		if(StringUtils.equals((String)map.get("mode"), "update")){
			JSONObject obj = JSONObject.fromObject(map.get("deptInfoObj"));
			String orgId = obj.get("orgId").toString();
			map.put("targetOrgId", orgId);
		}

		int businessGroupCnt = deptRegService.getBusinessGroupCnt(map);
		map.put("businessGroupCnt", businessGroupCnt);

		model.addAllAttributes(map); // 받은 파라미터 화면으로 그대로 전달.

		return "system/addDept/pop";
	}


	/**
	 * 부서 저장 ajax
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/doSaveDept.do")
	public void doSaveModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		String mode = map.get("mode").toString(); // 'new' or 'update'

		//지정된 관계사
		String orgId = map.get("targetOrgId").toString();
		map.put("orgId",orgId);

		int upCnt = 0;
		if ("update".equals(mode)) {
			upCnt = deptRegService.updateDept(map);
		} else { // "new"
			upCnt = deptRegService.insertDept(map); // upCnt : 실제 넘어오는 값은
													// 메뉴아이디(menuId) 이다
		}

		AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송
	}


	/**
	 * 부서 저장 ajax
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/doSaveParentDept.do")
	public void doSaveParentDept(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, String> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		int upCnt = deptRegService.doSaveParentDept(map); // upCnt : 실제 넘어오는 값은

		AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송
	}


	/**
	 * 부서 트리 정보 저장 ajax
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/doSaveMoveDeptInfo.do")
	public void doSaveMoveDeptInfo(HttpServletRequest request,
								HttpServletResponse response, ModelMap model, HttpSession session,
								@RequestParam Map<String, String> map) throws Exception {
		try{
			Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
			map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

			int upCnt = deptRegService.doSaveMoveDeptInfo(map); // upCnt : 실제 넘어오는 값은

			AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송

		}catch(Exception e){
			logger.error("부서 트리 정보 저장 에러!", e);
			e.printStackTrace();
			throw e;
		}
	}


	/**
	 * 부서삭제 (enable N)
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/deleteDept.do")
	public void deleteModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int upCnt = 0;
		upCnt = deptRegService.deleteDept(map);

		AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송

	}



	/**
	 * 부서 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/system/getDeptListCombo.do")
	public void getDeptListCombo(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(StringUtils.isNotEmpty((String)map.get("targetOrgId"))){
			map.put("orgId", (String)map.get("targetOrgId"));
		}
		List<Map> list = deptRegService.getDeptListCombo(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 부서별 사용자 관리
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 9. 14.
	 */
	@RequestMapping(value = "/system/userPerDept.do")
	public String userPerDept(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {



		model.addAllAttributes(map); // 받은 파라미터 화면으로 그대로 전달.

		return "system/userPerDept";
	}


	/**
	 * 부서 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: SangHyun Park
	 * @date		: 2015. 9. 16.
	 */
	@RequestMapping(value = "/system/getUserListOfDept.do")
	public void getUserListOfDept(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("hideSynergyUserYn", baseUserLoginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부

		List<Map> list = deptRegService.getUserListOfDept(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 매니저 지정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: SangHyun Park
	 * @date		: 2015. 9. 16.
	 */
	@RequestMapping(value = "/system/doSaveManager.do")
	public void doSaveManager(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int upCnt = deptRegService.doSaveManager(map);
		AjaxResponse.responseAjaxSave(response, upCnt);

	}

	/**
	 * 부서원 저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: SangHyun Park
	 * @date		: 2015. 9. 16.
	 */
	@RequestMapping(value = "/system/updateUserDepartmentForMove.do")
	public void updateUserDepartmentForMove(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String, Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int upCnt = deptRegService.updateUserDepartmentForMove(map);
		AjaxResponse.responseAjaxSave(response, upCnt);

	}
}