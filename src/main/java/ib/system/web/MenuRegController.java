package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.LogUtil;
import ib.system.service.MenuRegService;

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
 * filename	: MenuRegController.java
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
public class MenuRegController {

	@Resource(name = "menuRegService")
	private MenuRegService menuRegService;


	protected static final Log logger = LogFactory.getLog(MenuRegController.class);


	/**
	 * 메뉴등록 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/menuMgmt.do")
	public String memberList(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {


		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("system/menuMgmt") == -1){
			return "redirect:/";
		}


		return "system/menuMgmt";
	}


	/**
	 * 메뉴리스트(메뉴관리 페이지)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/getMenuList.do")
	public void getMenuList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {
		
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		
		map.put("orgId", loginInfo.get("applyOrgId").toString());
		List<Map> list = menuRegService.getMenuList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	/**
	 * 권한별 메뉴 리스트 (관계사에 의해)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/getMenuListForOrg.do")
	public void getMenuListForOrg(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {
		
		List<Map> list = menuRegService.getMenuListByOrg(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 메뉴등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/addMenu.do")
	public String write(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {



		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "system/addMenu/pop";
	}


	/**
	 * 메뉴 저장 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/doSaveMenu.do")
	public void doSaveMenu(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		LogUtil.printMap(map);	//map console log

		//map.put("userSeq", loginUser.getUserId());	//user_id(sequence)
		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("menuSubPath", null);				//!!!!!!!!!!!!!!!!!!!!!!!!!!!!임시 컬럼!!!!!!!!!!


		String mode = map.get("mode").toString();	//'new' or 'update'
		//orgId set.....:S
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();

		map.put("orgId",orgId);
		//orgId set.....:E

		int upCnt = 0;
		if("update".equals(mode)){
			upCnt = menuRegService.updateMenu(map);
		}else{	//"new"
			upCnt = menuRegService.insertMenu(map);	//upCnt : 실제 넘어오는 값은 메뉴아이디(menuId) 이다
		}


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}


	/**
	 * 메뉴삭제 (enable N)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 21.
	 */
	@RequestMapping(value = "/system/deleteMenu.do")
	public void deleteMenu(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		//map.put("userSeq", loginUser.getUserId());	//user_id(sequence)
		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int upCnt = 0;
		upCnt = menuRegService.deleteMenu(map);

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}
	
	
	/**
	 * 메뉴 유효체크 (이미 존재하는지)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/getMenuCodeExist.do")
	public void getMenuCodeExistYn(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {
		
		String existYn = menuRegService.getMenuCodeExistYn(map);
		
		AjaxResponse.responseAjaxObject(response, existYn);	//결과전송
	}
}