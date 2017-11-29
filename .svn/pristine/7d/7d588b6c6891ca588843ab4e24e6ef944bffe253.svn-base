package ib.user.web;


import ib.cmm.util.sim.service.AjaxResponse;
import ib.user.service.UserProfileService;



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
 * package	: ibiss.user.web
 * filename	: UserProfileController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 8. 25.
 * @version :
 *
 */
@Controller
public class UserProfileController {

	@Resource(name = "userProfileService")
	private UserProfileService userProfileService;


	protected static final Log logger = LogFactory.getLog(UserProfileController.class);


	/**
	 * 사용자 프로파일 페이지이동
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 8. 17.
	 */
	@RequestMapping(value = "/user/userProfile.do")
	public String userProfile(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {



		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("user/userProfile") == -1){
			return "redirect:/";
		}


		return "user/userProfile";
	}


	/**
	 * 사용자 프로파일 리스트 데이터 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 10.
	 */
	@RequestMapping(value = "/user/getUserProfile.do")
	public void getUserProfile(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("hideSynergyUserYn", baseUserLoginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부

		List<Map> resultMap = userProfileService.getUserProfile(map);

		AjaxResponse.responseAjaxSelect(response, resultMap);	//결과전송

	}


	/**
	 * 사용자 프로파일 변경 (변경부분저장)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 8. 26.
	 */
	@RequestMapping(value = "/user/changeUserProfile.do")
	public void changeUserProfile(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session,
			@RequestParam Map<String,String> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		//map.put("userSeq", loginUser.getUserId());		//user_id(sequence)
		map.put("userSeq", loginUser.get("userId").toString());		//user_id(sequence)

		int cnt = userProfileService.changeUserProfile(map);

		//세션 수정
		if(map.get("mainReqYn") != null && "Y".equals(map.get("mainReqYn").toString())){
			Map baseInfo = (Map)session.getAttribute("baseUserLoginInfo");
			baseInfo.put("mainBoardHeadlineYn", map.get("mainBoardHeadlineYn").toString());
			session.setAttribute("baseUserLoginInfo", baseInfo);
		}

		AjaxResponse.responseAjaxSave(response, cnt);	//결과전송
	}




	/**
	 * 사용자 프로파일 수정 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 8. 26.
	 */
	@RequestMapping(value = "/user/popupUserProfile.do")
	public String popupUserProfile(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "user/popupUserProfile/pop";
	}



}