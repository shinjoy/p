package ib.system.web;

import ib.basic.interceptor.MenuNavigationService;
import ib.basic.interceptor.MenuVO;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.MenuPerRoleService;
import ib.system.service.MenuRegService;
import ib.system.service.TabPerRoleService;

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
 * filename	: TabPerRoleController.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 8. 4.
 * @version : 
 *
 */
@Controller
public class TabPerRoleController {

	@Resource(name = "tabPerRoleService")
	private TabPerRoleService tabPerRoleService;
	
	@Resource(name = "menuPerRoleService")
	private MenuPerRoleService menuPerRoleService;
	
	@Resource(name = "menuNavigationService")
	private MenuNavigationService menuNavigationService;

	
	protected static final Log logger = LogFactory.getLog(TabPerRoleController.class);


	/**
	 * 권한별 탭 페이지
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 8. 4.
	 */
	@RequestMapping(value = "/system/tabPerRole.do")
	public String tabPerRole(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {		
				
		/*
		List<MenuVO> menuTabList = menuNavigationService.getSearchTabList(request,baseLoginUser);
		
		model.addAttribute("menuTabList", menuTabList);
		*/
		
		return "system/tabPerRole";
	}

	
	/**
	 * 권한 별 탭리스트 
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 8. 4.
	 */
	@RequestMapping(value = "/system/getTabPerRole.do")
	public void getTabPerRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {

		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		
		map.put("orgId", loginInfo.get("applyOrgId").toString());
		
		List<Map> list = tabPerRoleService.getTabPerRole(map);
				
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	/**
	 * 메뉴 별 탭리스트 
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 10. 21.
	 */
	@RequestMapping(value = "/system/getTabPerMenu.do")
	public void getTabPerMenu(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {

		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");		
		map.put("orgId", loginInfo.get("applyOrgId").toString());
		
		List<Map> list = tabPerRoleService.getTabPerMenu(map);
				
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	@RequestMapping(value = "/system/setTopMenu.do")
	public String setTopMenu(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {
		logger.debug("##### TabPerRoleController.setTopMenu() #### param : "+  map + "################");
				
		//roleId 검색
		int roleId = (int)tabPerRoleService.selectRoleInfo(map);
		map.put("roleId", roleId);
		
		//MENU_LEVEL : 0인 메뉴 리스트 반환.
		List<MenuVO> topMenuList = tabPerRoleService.selectMenuForTabRegister(map);
		model.addAttribute("topMenuList", topMenuList);
		
		//메인화면 테이블에 저장된 상위메뉴 정보
		//(메뉴 아이디:상위메뉴아이디:중간메뉴아이디:하단메뉴아이디) 순으로 저장됨.
		String paramList = (String)map.get("pageParamMenuList");
		
		//선택된 메뉴들의 상세 정보 반환(기존 저장된 상위 메뉴 정보 검색)
		List<MenuVO> menuList = tabPerRoleService.getMenuInfoInfo(map);
		model.addAttribute("menuList", menuList);
		model.addAttribute("roleId", roleId);
		model.addAttribute("pageParamMenuList", paramList);
		
		return "system/setTopMenu/pop";
	}
	
	
	@RequestMapping(value = "/system/tabMenu.do")
	public void selectMenuForTabRegister(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session,  @RequestParam Map<String,Object> map) throws Exception {
		
				
		String roleIdStr = (String)map.get("roleId");
		map.put("roleId", Integer.parseInt(roleIdStr));
		List<MenuVO> list = tabPerRoleService.selectMenuForTabRegister(map);
		AjaxResponse.responseAjaxObject(response, list);	//결과전송
	}

	
	/**
	 * 권한별 탭 저장 ajax
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 23.
	 */
	@RequestMapping(value = "/system/doSaveTabPerMenu.do")
	public void doSaveTabPerRole(HttpServletRequest request,
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
			logger.debug("###############" + p.get(i).get("menuId") + ":::::" + p.get(i).get("sort"));
		}
		
		int upCnt = 1;							//성공 '1'(임시값)
		
		map.put("pList", p);					//json string 을 ArrayList 로 바꿔 전달한다.
		
		tabPerRoleService.doSaveTabPerRole(map);
		
		
		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송
		
	}

	
	/**
	 * 권한별 탭 복사(팝업창열기)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	@RequestMapping(value = "/system/copyRoleTab.do")
	public String copyRoleTab(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		
		
		
		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
		
		model.put("menuType", "NOTTREE");	//권한별 메뉴 복사와 차별 !!!!!
		
		return "system/copyRole/pop";
	}
	
	
	/*메뉴 등록시 탭 등록 동시 처리를 위해 신규 구현.(sjy)
	 * 
	 * 2017-01-16
	 * sjy 
	 * 메뉴등록과 메뉴별 탭 등록의 기능 합치기 위한 신규 구현.
	 * */
	
	//탭선택 팝업창 
	@RequestMapping(value = "/system/setTopMenuPop.do")
	public String setTopMenuPop(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {
		
		return "system/setTopMenuPop/pop";
	}
	
	//탭선택 창에 메뉴 그리드를 위한 데이터 세팅
	@RequestMapping(value = "/system/getMenuListForTab.do")
	public void getMenuList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session,  @RequestParam Map<String,String> map) throws Exception {
		
		//roleText = 'SYS_MGR'; 슈퍼 관리자를 기준( 메뉴가 다 존재) roleId   가져옴
		
		map.put("roleText", "SYS_MGR");
		
		String roleId =Integer.toString(tabPerRoleService.selectRoleInfo(map));	
		map.put("roleId", roleId);
		map.put("menuLoc", "TOP");
		List<Map> list = menuPerRoleService.getMenuByRoleMenu(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
}