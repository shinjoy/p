package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.PageRolePerRoleService;

import java.util.HashMap;
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


/**
 * <pre>
 * package	: ibiss.system.web
 * filename	: PageRolePerRoleController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 10. 28.
 * @version :
 *
 */
@Controller
public class PageRolePerRoleController {

	@Resource(name = "pageRolePerRoleService")
	private PageRolePerRoleService pageRolePerRoleService;


	protected static final Log logger = LogFactory.getLog(PageRolePerRoleController.class);


	/**
	 * 권한별 화면권한 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 8. 4.
	 */
	@RequestMapping(value = "/system/pageRolePerRole.do")
	public String pageRolePerRole(HttpServletRequest request,@RequestParam Map<String,String> map,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {

		if(StringUtils.isNotEmpty((String)map.get("targetOrgId"))){
			model.addAttribute("targetOrgId", (String)map.get("targetOrgId"));
		}

		return "system/pageRolePerRole";
	}


	/**
	 * 권한별 화면권한 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 28.
	 */
	@RequestMapping(value = "/system/getPageRoleList.do")
	public void getPageRoleList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {



		List<Map> list = pageRolePerRoleService.getPageRoleList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 화면권한 변경
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 28.
	 */
	@RequestMapping(value = "/system/changePageRole.do")
	public void changePageRole(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session,
			@RequestParam Map<String,String> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		String chkCol = map.get("chkCol").toString();
		String chkVal = map.get("chkVal").toString();
		if("OPEN".equals(chkCol)){
			map.put("open", chkVal);
		}else if("SELECT".equals(chkCol)){
			map.put("select", chkVal);
		}else if("INSERT".equals(chkCol)){
			map.put("insert", chkVal);
		}else if("UPDATE".equals(chkCol)){
			map.put("update", chkVal);
		}else if("DELETE".equals(chkCol)){
			map.put("delete", chkVal);
		}

		int cnt = pageRolePerRoleService.mergePageRole(map);

		AjaxResponse.responseAjaxSave(response, cnt);	//결과전송
	}


	/**
	 * 화면권한 일괄 변경(컬럼헤드 체크박스)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 28.
	 */
	@RequestMapping(value = "/system/changePageRoleAll.do")
	public void changePageRoleAll(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session,
			@RequestParam Map<String,String> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		String chkCol = map.get("chkCol").toString();
		String chkVal = map.get("chkVal").toString();
		HashMap<String, String> rMap = new HashMap<String, String>();
		rMap.put(chkCol, chkVal);

		int cnt = pageRolePerRoleService.changePageRoleAll(map);

		AjaxResponse.responseAjaxObject(response, rMap);	//결과전송
	}


}