package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.CodePerRoleService;

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
 * filename	: CodePerRoleController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 10. 29.
 * @version :
 *
 */
@Controller
public class CodePerRoleController {

	@Resource(name = "codePerRoleService")
	private CodePerRoleService codePerRoleService;


	protected static final Log logger = LogFactory.getLog(CodePerRoleController.class);



	/**
	 * 권한별 코드 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 29.
	 */
	@RequestMapping(value = "/system/codePerRole.do")
	public String codePerRole(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {



		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("system/codePerRole") == -1){
			return "redirect:/";
		}


		return "system/codePerRole";
	}


	/**
	 * 권한별 코드SET,값 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 29.
	 */
	@RequestMapping(value = "/system/getCodeSetValuePerRole.do")
	public void getCodeSetValuePerRole(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {



		List<Map> list = codePerRoleService.getCodeSetValuePerRole(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}

	/**
	 * 권한별 코드 변경
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 29.
	 */
	@RequestMapping(value = "/system/changeExclusion.do")
	public void changeExclusion(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session,
			@RequestParam Map<String,String> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		int cnt = codePerRoleService.changeExclusion(map);

		AjaxResponse.responseAjaxSave(response, cnt);	//결과전송
	}


}