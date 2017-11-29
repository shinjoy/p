package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.ModulePerRoleService;

import java.util.ArrayList;
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

import com.google.gson.Gson;


/**
 * <pre>
 * package	: ibiss.system.web
 * filename	: ModulePerRoleController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 8. 5.
 * @version :
 *
 */
@Controller
public class ModulePerRoleController {

	@Resource(name = "modulePerRoleService")
	private ModulePerRoleService modulePerRoleService;



	protected static final Log logger = LogFactory.getLog(ModulePerRoleController.class);


	/**
	 * 권한별 모듈 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/modulePerRole.do")
	public String modulePerRole(HttpServletRequest request, @RequestParam Map<String,String> map,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {
		
		if(StringUtils.isNotEmpty((String)map.get("targetOrgId"))){
			model.addAttribute("targetOrgId", (String)map.get("targetOrgId"));
		}
		
		return "system/modulePerRole";
	}


	/**
	 * 권한 별 모듈리스트(권한별모듈 페이지)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/system/getModulePerRole.do")
	public void getModulePerRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {

		
		List<Map> list = modulePerRoleService.getModulePerRole(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 권한별 모듈 저장 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 23.
	 */
	@RequestMapping(value = "/system/doSaveModulePerRole.do")
	public void doSaveModulePerRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		String jsonStr = (String)map.get("pList");
		Gson gson = new Gson();
		ArrayList<Map> p = null;
		p = gson.fromJson(jsonStr, ArrayList.class);

		//logger.debug("#########################" + p.size() + "############AAAAAAAAAA############");

		for(int i=0; i<p.size(); i++){
			logger.debug("###############" + p.get(i).get("moduleId") + ":::::" + p.get(i).get("sort"));
		}

		int upCnt = 1;							//성공 '1'(임시값)

		map.put("pList", p);					//json string 을 ArrayList 로 바꿔 전달한다.

		modulePerRoleService.doSaveModulePerRole(map);


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}


	/**
	 * 권한별 모듈 복사(팝업창열기)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	@RequestMapping(value = "/system/copyRoleModule.do")
	public String copyRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {



		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		model.put("isModule", "YES");	//권한별 모듈 복사임을 전달

		return "system/copyRole/pop";
	}


	/**
	 * 권한별 모듈 복사 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	@RequestMapping(value = "/system/doCopyModuleByRole.do")
	public void doCopyModuleByRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("orgId",loginUser.get("orgId").toString());
		int upCnt = modulePerRoleService.doCopyModulePerRole(map);	//복사

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}

}