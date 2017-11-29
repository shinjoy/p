package ib.system.web;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.ModuleRegService;

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
 * filename	: ModuleRegController.java
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
public class ModuleRegController {

	@Resource(name = "moduleRegService")
	private ModuleRegService moduleRegService;


	protected static final Log logger = LogFactory.getLog(ModuleRegController.class);


	/**
	 * 모듈등록 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/moduleMgmt.do")
	public String moduleMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {



		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("system/moduleMgmt") == -1){
			return "redirect:/";
		}


		return "system/moduleMgmt";
	}


	/**
	 * 모듈 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/getModuleList.do")
	public void getModuleList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {



		List<Map> list = moduleRegService.getModuleList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 모듈등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/addModule.do")
	public String addModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {



		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "system/addModule/pop";
	}


	/**
	 * 모듈 저장 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/doSaveModule.do")
	public void doSaveModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		String mode = map.get("mode").toString();	//'new' or 'update'

		//orgId set.....:S
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();

		map.put("orgId",orgId);		//orgId set.....:E

		int upCnt = 0;
		if("update".equals(mode)){
			upCnt = moduleRegService.updateModule(map);
		}else{	//"new"
			upCnt = moduleRegService.insertModule(map);	//upCnt : 실제 넘어오는 값은 메뉴아이디(menuId) 이다
		}


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}


	/**
	 * 모듈삭제 (enable N)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 21.
	 */
	@RequestMapping(value = "/system/deleteModule.do")
	public void deleteModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		int upCnt = 0;
		upCnt = moduleRegService.deleteModule(map);

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}

}