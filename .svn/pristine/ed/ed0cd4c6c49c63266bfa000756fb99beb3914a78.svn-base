package ib.user.web;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
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

import com.google.gson.Gson;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.EgovFileScrty;
import ib.cmm.util.sim.service.LogUtil;
import ib.system.service.OrgCompanyRegService;
import ib.user.service.UserService;
import net.sf.json.JSONObject;


/**
 * <pre>
 * package	: ibiss.user.web
 * filename	: UserController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 8. 17.
 * @version :
 *
 */
@Controller
public class UserController {

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "orgCompanyRegService")
	private OrgCompanyRegService orgCompanyRegService;


	protected static final Log logger = LogFactory.getLog(UserController.class);


	/**
	 * 사용자 관리 페이지이동
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 8. 17.
	 */
	@RequestMapping(value = "/user/userMgmt.do")
	public String userMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {


		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("user/userMgmt") == -1){
			return "redirect:/";
		}


		return "user/userMgmt";
	}



	/**
	 * 사용자 리스트 데이터 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 10.
	 */
	@RequestMapping(value = "/user/getUserList.do")
	public void getUserList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("hideSynergyUserYn", baseUserLoginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부

		List<Map> resultMap = userService.getUserList(map);

		AjaxResponse.responseAjaxSelect(response, resultMap);	//결과전송

	}

	/**
	 * 사용자등록 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/user/addUser.do")
	public String addUser(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		logger.debug("############# UserController.addUser()  ########  param : ["+ map +"] ##########");

		//등록시 (orgId 값 반환)
		if(StringUtils.equals((String)map.get("mode"), "new")){
			//관계사 정보 반환(관계사 코드포함) => 로그인 아이디 : 관계사 코드 + 사번 , 사번 : 자유입력
			Map resultMap = userService.getOrgInfoForGrouping(map);
			map.put("orgInfo", resultMap);	//관계사 코드 반환
			model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		}else{
			//수정모드 시 (userInfoObj)에 담겨서 전달.
			String userInfo = (String)map.get("userInfoObj");
			if(StringUtils.isNotEmpty(userInfo)){
				JSONObject obj = JSONObject.fromObject(userInfo);
				if(obj != null && !obj.isEmpty()){
					map.put("orgId", obj.getString("orgId"));

					Map resultMap = userService.getOrgInfoForGrouping(map);
					map.put("orgInfo", resultMap);	//관계사 코드 반환
					model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
				}
			}
		}
		return "user/addUser/pop";
	}

	//사번 유효성 체크 (로그인 아이디 : 관계사 코드 + 사번 , 사번 : 자유입력)
	@RequestMapping(value = "/user/checkPerSabun.do")
	public void checkPerSabun(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		Map result = new HashMap();
		//관계사 정보 반환(관계사 코드포함) => 로그인 아이디 : 관계사 코드 + 사번 , 사번 : 자유입력
		Map resultMap = userService.getOrgPersabun(map);
		result.put("empNo", resultMap);

		//아이디 체크
		int cnt = 0;
		if(!(map.get("loginId").toString().equals(""))) cnt = userService.chkValidation(map);

		result.put("id", cnt);

		AjaxResponse.responseAjaxObject(response, result);	//결과전송
	}

	//소속관계사 팝업
	@RequestMapping(value = "/user/orgAuthCompanyPop.do")
	public String orgAuthCompanyPop(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "user/orgAuthCompanyPop/pop";
	}

	//소속 관계사 리스트 팝업
	@RequestMapping(value = "/user/orgAuthCompanyPopList.do")
	public void orgAuthCompanyPopList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId"));
		//사용자가 접근 가능한 관계자 리스트 반환.
		Map resultMap = userService.getAccessOrgInfoList(map);
		AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송
	}

	//소속회사 팝업
	@RequestMapping(value = "/user/orgAuthCompanyListPop.do")
	public String orgAuthCompanyListPop(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "user/orgAuthCompanyListPop/pop";
	}

	/**
	 * 소속회사 리스트 반환
	 * ( 선택한 관계사의 비즈니스 그룹에 속하는 회사 리스트만 노출)
	 * @param request
	 * @param response
	 * @param session
	 * @param model
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/getCompanyByBusinessList.do")
	public void getCompanyByBusinessList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {


		Map resultMap = userService.getCompanyByGroupingList(map);
		AjaxResponse.responseAjaxSelectForPage(response, 	resultMap);	//결과전송
	}



	/**
	 * 회사 코드 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	@RequestMapping(value = "/user/getCompanyCode.do")
	public void getCompanyCode(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {


		List<Map> list = userService.getCompanyCode(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 주소검색  팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/user/searchZipAddr.do")
	public String searchZipAddr(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "user/searchZipAddr/pop";
	}


	/**
	 * 주소(우편번호)검색 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 10.
	 */
	@RequestMapping(value = "/user/doSearchZipAddr.do")
	public void doSearchZipAddr(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {



		//List<Map> resultMap = userService.doSearchZipAddr(map);

		/*
		 * map 구성
		 * search	검색어 (>> srchwrd 로 넘긴다)
		 * countPerPage	페이지크기
		 * currentPage 현재 페이지
		 */

		String reqStr = "http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll";
		String serviceKey = "vgxbeRq5Btc%2BjHxu%2FIK0FFD7YTJ%2BvfP%2FELt0cki6jOyFrZ3AfX5ANv0D3y0NOZvo7pmRffgvVdOl8pfX2BCrFw%3D%3D";		//2년마다 갱신(http://www.data.go.kr)

		reqStr += "?ServiceKey=" + serviceKey + "&countPerPage=" + map.get("countPerPage") + "&currentPage=" + map.get("currentPage");
		reqStr += "&srchwrd=" + URLEncoder.encode(map.get("search").toString(), "UTF-8");

		URL reqUrl = new URL(reqStr);
		URLConnection src = reqUrl.openConnection();

		BufferedReader br = new BufferedReader(new InputStreamReader(src.getInputStream(), "UTF-8"));


		String xml = org.apache.commons.io.IOUtils.toString(br);	//요청하여 얻은 xml 결과


		//xml 전송
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HashMap result = new HashMap();

		Gson gson = new Gson();

		result.put("result", 	"SUCCESS");
		result.put("resultVal",	1);
		result.put("resultMsg",	"");
		result.put("resultList", xml);


		logger.debug("######result json string######:"+gson.toJson(result));
		out.print(gson.toJson(result));

	}


	/**
	 * 사용자 저장 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	@RequestMapping(value = "/user/doSaveUser.do")
	public void doSaveUser(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		LogUtil.printMap(map);	//map console log

		map.put("userPwd", EgovFileScrty.encryptPassword(map.get("userPwd").toString()));		//비밀번호 암호화

		//map.put("userSeq", loginUser.getUserId());	//user_id(sequence)
		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)
		map.put("rgId", loginUser.get("loginId").toString());
		map.put("usrCusId", loginUser.get("cusId").toString());
		map.put("regOrgId", loginUser.get("orgId").toString());
		try {
			String mode = map.get("mode").toString(); // 'new' or 'update'
			int upCnt = 0;
			if ("update".equals(mode)) {
				// 수정
				upCnt = userService.updateUser(map);

			} else { // "new"
				// 신규 사원번호
				//String userNo = userService.getNewUserNo(loginUser.get("applyOrgId").toString()); // 신규 사원번호를 따온다.
				//map.put("empNo", userNo); // 따온 신규 사원번호를 추가하여 등록서비스에 넘긴다.
				// 신규등록
				upCnt = userService.insertUser(map); // upCnt : 실제 넘어오는 값은
														// 사용자아이디(userId) 이다
			}

			AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	/**
	 * 비밀번호 초기화
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 21.
	 */
	@RequestMapping(value = "/user/doInitPwd.do")
	public void doInitPwd(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userPwd", EgovFileScrty.encryptPassword(map.get("userPwd").toString()));		//비밀번호 암호화

		//map.put("userSeq", loginUser.getUserId());	//user_id(sequence)
		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int upCnt = 0;
		upCnt = userService.doInitPwd(map);

		AjaxResponse.responseAjaxSave(response, upCnt);	//결과전송

	}
	/**
	 * 사용자별 그룹관리 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 03. 23.
	 */
	@RequestMapping(value = "/user/processUserGroupInfoPopup.do")
	public String regCstPopup(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) return "/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		List<Map> getUserGroupList = userService.getUserGroupList(map);
		model.addAttribute("getUserGroupList", getUserGroupList);
		return "user/processUserGroupInfoPopup/pop";
	}
	/**
	 *
	 * 그룹관리 - 사용자 그룹을 조회
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/user/getUserGroupList.do")
	public void getUserGroupList(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		List<Map> orgUserGroupList= userService.getUserGroupList(map);

		AjaxResponse.responseAjaxSelect(response, orgUserGroupList);		//"SUCCESS" 전달

	}

	/**
	 * 유저 프로필박스
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 8. 17.
	 */
	@RequestMapping(value = "/user/getUserProfileAjax.do")
	public String getUserProfile(HttpServletRequest request,
			HttpSession session, HttpServletResponse response,@RequestParam Map map, ModelMap model) throws Exception {

		EgovMap userProfileMap = userService.getUserProfile(map);

		model.addAttribute("userProfileMap",userProfileMap);
		return "common/personnelProfileBox/noHeader";
	}

	/**
	 * 메인 유저 모듈 순번 처리
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 11. 27.
	 */
	@RequestMapping(value = "/user/processUserMainModule.do")
	public void processUserMainModule(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("roleId", baseUserLoginInfo.get("userRoleId").toString());

		Integer result = userService.processUserMainModule(map);


		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}
	
	/**
	 * 사용자 validation체크
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 20.
	 */
	@RequestMapping(value = "/user/chkValidation.do")
	public void chkValidation(HttpServletRequest request,
			HttpSession session, HttpServletResponse response,@RequestParam Map<String, Object> map) throws Exception{

		int cnt = userService.chkValidation(map);

		AjaxResponse.responseAjaxObject(response, cnt);

	}

}