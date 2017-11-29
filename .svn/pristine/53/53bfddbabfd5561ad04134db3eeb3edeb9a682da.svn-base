package ib.system.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.cmm.service.CommonService;
import ib.cmm.util.fcc.service.StringUtil;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.RoleRegService;
import ib.user.service.UserService;


/**
 * <pre>
 * package	: ibiss.system.web
 * filename	: RoleRegController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version :
 *
 */
@Controller
public class RoleRegController {

	@Resource(name = "roleRegService")
	private RoleRegService roleRegService;

	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "commonService")
	private CommonService commonService;

	protected static final Log logger = LogFactory.getLog(RoleRegController.class);



	/**
	 * 권한코드 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/system/getRoleCodeCombo.do")
	public void getRoleCodeCombo(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {


		List<Map> list = roleRegService.getRoleCodeCombo(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 관계사별 권한코드 리스트 (관계사별 권한코드 콤보박스 용)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 11. 11.
	 */
	@RequestMapping(value = "/system/getRoleCodeByOrgCombo.do")
	public void getRoleCodeByOrgCombo(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginInfo.get("userId").toString());

		List<Map> list = roleRegService.getRoleCodeByOrgCombo(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 권한관리 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/roleMgmt.do")
	public String roleMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {


		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("system/roleMgmt") == -1){
			return "redirect:/";
		}


		return "system/roleMgmt";
	}


	/**
	 * 권한코드 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/system/getRoleCodeList.do")
	public void getRoleCodeList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {



		List<Map> list = roleRegService.getRoleCodeList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 권한등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/addRole.do")
	public String addRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {



		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "system/addRole/pop";
	}


	/**
	 * 권한 저장 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/doSaveRole.do")
	public void doSaveModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		String mode = map.get("mode").toString();	//'new' or 'update'

		int upCnt = 0;
		if("update".equals(mode)){
			upCnt = roleRegService.updateRole(map);
		}else{	//"new"
			upCnt = roleRegService.insertRole(map);	//upCnt : 실제 넘어오는 값은 메뉴아이디(menuId) 이다
		}


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
	}


	/**
	 * 권한삭제 (enable N)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 21.
	 */
	@RequestMapping(value = "/system/deleteRole.do")
	public void deleteModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		int upCnt = 0;
		upCnt = roleRegService.deleteRole(map);

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}

	/////////////////////////결재자 공개 추가////////////////////////////////////////////////////
	/**
	 * 관계사별 결재자공개 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/addOrgCommonAppvLine.do")
	public String regCstPopup(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		List<Map> getUserGroupList = userService.getUserGroupList(map);
		model.addAttribute("getUserGroupList", getUserGroupList);

		List<Map> orgIdList = userService.getOrgIdList("");  //전체 관계사 리스트
		model.addAttribute("orgIdList", orgIdList);

		return "system/addOrgCommonAppvLine";
	}

	/**
	 * 관계사별 결재자공개(삭제 / 저장)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 21.
	 */
	@RequestMapping(value = "/system/processOrgCommonAppvLine.do")
	public void processOrgCommonAppvLine(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());		//applyOrgId


		int upCnt = 0;
		upCnt = roleRegService.processOrgCommonAppvLine(map);

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}

	/**
	 * 관계사별 결재자공개 조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 21.
	 */
	@RequestMapping(value = "/system/searchOrgCommonAppvLine.do")
	public void searchOrgCommonAppvLine(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());		//applyOrgId

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		List<EgovMap> searchOrgCommonAppvLineList = roleRegService.searchOrgCommonAppvLineList(map);

		ArrayList<Integer> userList = new ArrayList<Integer>();

		for(EgovMap e:searchOrgCommonAppvLineList){
			String userId = e.get("userId").toString();
			userList.add(Integer.parseInt(userId));
		}
		obj.put("searchOrgCommonAppvLineList", searchOrgCommonAppvLineList);
		obj.put("userList", userList);
		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	
	//------------------------------인수인계자 설정 : S
	
	/**
	* 인수인계자 설정 페이지
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2016. 10. 12.
	*/
	@RequestMapping(value = "/system/transferUserList.do")
	public String transferUserList(HttpServletRequest request, HttpServletResponse response, ModelMap model,
	HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
	
		if(session.getAttribute("baseUserLoginInfo")==null) return "/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		
		List<EgovMap>tranferUserList = roleRegService.transferUserList(map);
		
		HashMap paramMap = new HashMap();
		paramMap.put("authOrgId","Y");
		paramMap.put("code","code");
		paramMap.put("name","name");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		
		List<Map> orgList = commonService.getOrgCodeCombo(paramMap);
		
		model.addAttribute("tranferUserList", tranferUserList);
		model.addAttribute("orgList", orgList);
		
		
		return "system/transferUserList";
	}
	
	/**
	* 인수인계자 설정 페이지 리스트 
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 12.
	*/
	
	@RequestMapping(value = "/system/transferUserListAjax.do")
	public String transferUserListAjax(
			@RequestParam Map<String,Object> map
			,Model model
			,HttpServletResponse response
			,HttpSession session) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		
		List<EgovMap>tranferUserList = roleRegService.transferUserList(map);
		
		model.addAttribute("tranferUserList", tranferUserList);
		
		return "system/include/transfer_userList_INC/inc";
	}
	
	/**
	* 인수인계자 설정 페이지 - 사용여부 수정 
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 13.
	*/
	
	@RequestMapping(value = "/system/modifyTransferUseYn.do")
	public void modifyTransferUseYn(
			@RequestParam Map<String,Object> map
			,Model model
			,HttpServletResponse response
			,HttpSession session) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		
		int cnt = roleRegService.modifyTransferUseYn(map);
		
		
		AjaxResponse.responseAjaxSave(response, cnt);
	}
	
	/**
	* 인수인계자 등록 페이지  
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 13.
	*/
	
	@RequestMapping(value = "/system/createTransferUserPop.do")
	public String createTransferUserPage(
			@RequestParam Map<String,Object> map
			,Model model
			,HttpServletResponse response
			,HttpSession session) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
	
		HashMap paramMap = new HashMap();
		paramMap.put("authOrgId","Y");
		paramMap.put("code","code");
		paramMap.put("name","name");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		
		List<Map> orgList = commonService.getOrgCodeCombo(paramMap);
		
		model.addAttribute("orgList", orgList);
		
		return "system/pop/transferUserCreatePop/pop";
	}
	
	/**
	* 인수인계자 설정 등록
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 16.
	*/
	
	@RequestMapping(value = "/system/createTransferUser.do")
	public void createTransferUser(
			@RequestParam Map<String,Object> map
			,Model model
			,HttpServletResponse response
			,HttpSession session) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		
		int saveCnt = 0;
		
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		
		int count = roleRegService.transferDatachk(map);
		
		if(count>0){
			saveCnt = -8;
		}else{
			saveCnt = roleRegService.createTransferUser(map);
		}
		
		
		AjaxResponse.responseAjaxSave(response, saveCnt);
	}

	

}