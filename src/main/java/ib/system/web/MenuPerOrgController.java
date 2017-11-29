package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.MenuPerOrgService;

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
 * package	: ib.system.web 
 * filename	: MenuPerOrgController.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2016. 10. 19.
 * @version : 
 *
 */
@Controller
public class MenuPerOrgController {

	@Resource(name = "menuPerOrgService")
	private MenuPerOrgService menuPerOrgService;


	protected static final Log logger = LogFactory.getLog(MenuPerOrgController.class);


	/**
	 * 관계사별 메뉴 권한
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/menuPerOrg.do")
	public String munePerOrg(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {


		return "system/menuPerOrg";
	}
	
	//관계사별 메뉴 리스트 
	@RequestMapping(value = "/system/getMenuListByOrg.do")
	public void getMenuListByOrg(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
	
		map.put("orgId", map.get("targetOrgId"));
		List<Map> list = menuPerOrgService.getMenuListByOrg(map);
		AjaxResponse.responseAjaxSelect(response, list);
	}
	
	//관계사별 메뉴 리스트 저장
	@RequestMapping(value = "/system/saveMenuListByOrg.do")
	public void saveMenuListByOrg(HttpServletResponse response, HttpSession session, @RequestParam Map<String,Object> map) throws Exception{
		
		try{
			Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
			map.put("userRegId", loginUser.get("userId"));
			int saveCnt = menuPerOrgService.saveMenuListByOrg(map);
			AjaxResponse.responseAjaxSave(response, saveCnt);
		}catch(Exception ex){
			ex.printStackTrace();
			AjaxResponse.responseAjaxFailWithMsg(response, "관계사별 메뉴 리스트를 저장하는 도중 오류가 발생하였습니다.");
		}
	}

}