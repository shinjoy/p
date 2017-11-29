package ib.system.web;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ib.cmm.util.sim.service.AjaxResponse;
import ib.system.service.CodeRegService;


/**
 * <pre>
 * package	: ibiss.system.web
 * filename	: CodeRegController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 8. 10.
 * @version :
 *
 */
@Controller
public class CodeRegController {

	@Resource(name = "codeRegService")
	private CodeRegService codeRegService;


	protected static final Log logger = LogFactory.getLog(CodeRegController.class);



	/**
	 * 코드등록 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/codeMgmt.do")
	public String codeMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {

		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("system/codeMgmt") == -1){
			return "redirect:/";
		}

		return "system/codeMgmt";
	}


	/**
	 * 시스템코드 등록 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 27.
	 */
	@RequestMapping(value = "/system/systemCodeMgmt.do")
	public String systemCodeMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {


		return "system/systemCodeMgmt";
	}


	/**
	 * 공통코드 리스트(코드SET)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/system/getCodeSet.do")
	public void getCodeSet(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map userInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", userInfo.get("applyOrgId").toString());

		//검색으로 넘어온 orgId가 있는 경우
		if(map.get("targetOrgId") != null){
			map.put("orgId", map.get("targetOrgId"));
		}

		List<Map> list = codeRegService.getCodeSet(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 코드SET 검색
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/searchCodeSetPop.do")
	public String searchCodeSetPop(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {



		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "system/searchCodeSetPop/pop";
	}


	/**
	 * 코드SET 저장 ajax(COMMON)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/doSaveCodeSet.do")
	public void doSaveModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		String mode = map.get("mode").toString();	//'new' or 'update'
		int upCnt = 0;
		if("update".equals(mode)){
			upCnt = codeRegService.updateCodeSet(map);
		}else{	//"new"
			upCnt = codeRegService.insertCodeSet(map);	//upCnt : 실제 넘어오는 값은 아이디(codeSetId) 이다
		}


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}


	/**
	 * 코드SET 저장 ajax (SYSTEM)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/doSaveCodeSetForSystem.do")
	public void doSaveCodeSetForSystem(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		String mode = map.get("mode").toString();	//'new' or 'update'
		int upCnt = 0;
		if("update".equals(mode)){
			//update는 모든 관계사를 수정해야함으로 코드셋네임으로 찾아서 바꿔야함!
			upCnt = codeRegService.updateCodeSetForSystem(map);
		}else{	//"new"
			//모든 관계사에 대하여 INSERT 처리
			upCnt = codeRegService.insertCodeSetForSystem(map);
		}


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}


	/**
	 * 공통코드 리스트(코드LIST)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/system/getCodeList.do")
	public void getCodeList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {



		List<Map> list = codeRegService.getCodeList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 코드LIST 저장 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/doSaveCodeList.do")
	public void doSaveCodeList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		String mode = map.get("mode").toString();	//'new' or 'update'
		int upCnt = 0;
		if("update".equals(mode)){
			upCnt = codeRegService.updateCodeList(map);
		}else{	//"new"
			upCnt = codeRegService.insertCodeList(map);	//upCnt : 실제 넘어오는 값은 아이디(codeListId) 이다
		}


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}


	/**
	 * 코드LIST 저장 ajax (SYSTEM)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/doSaveCodeListForSystem.do")
	public void doSaveCodeListForSystem(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)


		String mode = map.get("mode").toString();	//'new' or 'update'
		int upCnt = 0;
		if("update".equals(mode)){
			upCnt = codeRegService.updateCodeListForSystem(map);
		}else{	//"new"
			upCnt = codeRegService.insertCodeListForSystem(map);	//upCnt : 실제 넘어오는 값은 아이디(codeListId) 이다
		}


		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}
	/**
	 * 코드안내 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/codeMgmtHelpPop.do")
	public String codeMgmtHelpPop(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "system/codeMgmtHelpPop/pop";
	}

	/**
	 * 공통코드,시스템코드 통합 dup chk
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/system/getCodeDupChk.do")
	public void getCodeDupChk(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map<String,Object> obj = new HashMap<String,Object>();

		Integer chkCnt = codeRegService.getCodeDupChkCnt(map);
		obj.put("chkCnt", chkCnt);

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달

	}

}