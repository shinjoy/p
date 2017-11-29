package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.MenuPerRoleService;
import ib.system.service.RoleRegService;

import java.util.ArrayList;
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
 * package	: ibiss.system.web
 * filename	: MenuPerRoleController.java
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
public class MenuPerRoleController {

	@Resource(name = "menuPerRoleService")
	private MenuPerRoleService menuPerRoleService;

	@Resource(name = "roleRegService")
	private RoleRegService roleRegService;


	protected static final Log logger = LogFactory.getLog(MenuPerRoleController.class);


	/**
	 * 권한별 메뉴 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/menuPerRole.do")
	public String menuPerRole(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model, @RequestParam Map<String,String> map) throws Exception {


		logger.debug("#############################파라미터########"+ map +","+ map.get("targetOrgId"));
		model.addAttribute("targetOrgId" , map.get("targetOrgId"));

		return "system/menuPerRole";
	}


	/**
	 * 권한 및 메뉴위치 별 메뉴리스트(권한별메뉴 페이지)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/system/getMenuByRole.do")
	public void getMenuByRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {


		List<Map> list = menuPerRoleService.getMenuByRoleMenu(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 권한별 메뉴 저장 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 23.
	 */
	@RequestMapping(value = "/system/doSaveMenuByRole.do")
	public void doSaveMenuByRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		String jsonStr = (String)map.get("pList");
		Gson gson = new Gson();
		ArrayList<Map> p = null;
		p = gson.fromJson(jsonStr, ArrayList.class);

		

		for(int i=0; i<p.size(); i++){
			logger.debug("###############" + p.get(i).get("menuId") + ":::::" + p.get(i).get("sort"));
		}

		int upCnt = 1;							//성공 '1'(임시값)

		map.put("pList", p);					//json string 을 ArrayList 로 바꿔 전달한다.

		menuPerRoleService.doSaveMenuByRole(map);


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}


	/**
	 * 권한복사(팝업창열기)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	@RequestMapping(value = "/system/copyRole.do")
	public String copyRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "system/copyRole/pop";
	}
	
	/**
	 * 권한복사(팝업창열기) -선택메뉴
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	@RequestMapping(value = "/system/copySelectRole.do")
	public String copySelectRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "system/copySelectRole/pop";
	}


	/**
	 * 권한별 메뉴 복사 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	@RequestMapping(value = "/system/doCopyMenuByRole.do")
	public void doCopyMenuByRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		/*orgId set.....:S
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();

		map.put("orgId",orgId);
		*/

		int upCnt = menuPerRoleService.doCopyMenuByRole(map);	//복사

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}


	/**
	 * 권한별 메뉴 복사(상단메뉴와 동일하게 복사) ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	@RequestMapping(value = "/system/doCopyByTop.do")
	public void doCopyByTop(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("orgId",loginUser.get("orgId").toString());

		int upCnt = menuPerRoleService.doCopyByTop(map);	//복사

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}
	
	
	//-- 권한별 메뉴 선택복사 20170223 sjy
	
	/**
	 * 권한별 메뉴 선택 복사 
	 */
	
	@RequestMapping(value = "/system/doCopySelectRoleMenuList.do")
	public void doCopySelectRoleMenuList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int upCnt = menuPerRoleService.doCopySelectRoleMenuList(map);	//복사

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}

	
	
	
	/**
	 * 메뉴미리보기
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 */
	@RequestMapping(value = "/system/showPreviewMenu.do")
	public String showPreviewMenu(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);
		
		return "system/menuPreviewPop/pop";
	}

}