package ib.system.web;


import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.RolePerUserService;

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
 * filename	: RolePerUserController.java
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
public class RolePerUserController {

	@Resource(name = "rolePerUserService")
	private RolePerUserService rolePerUserService;


	protected static final Log logger = LogFactory.getLog(RolePerUserController.class);


	/**
	 * 사용자별권한 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 26.
	 */
	@RequestMapping(value = "/system/rolePerUser.do")
	public String rolePerUser(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {


		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("system/rolePerUser") == -1){
			return "redirect:/";
		}


		return "system/rolePerUser";
	}


	/**
	 * 사용자리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	@RequestMapping(value = "/system/getUserList.do")
	public void getUserList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {



		List<Map> list = rolePerUserService.getUserList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송


	}

	
	/**
	 * 사용자리스트 - 권한설정을 위한 
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	@RequestMapping(value = "/system/getUserListByRole.do")
	public void getUserListByRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {



		List<Map> list = rolePerUserService.getUserListByRole(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	

	/**
	 * 권한변경
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 30.
	 */
	@RequestMapping(value = "/system/changeRoleCode.do")
	public void changeRoleCode(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session,
			@RequestParam Map<String,String> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int cnt = rolePerUserService.mergeRoleCode(map);

		AjaxResponse.responseAjaxSave(response, cnt);	//결과전송
	}

}