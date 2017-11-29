package ib.pass.web;

import ib.cmm.util.sim.service.EgovFileScrty;
import ib.cmm.util.sim.service.LogUtil;
import ib.pass.service.PassService;
import ib.user.service.UserCommonService;
import ib.user.service.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class PassController {

	
	@Resource(name = "passService")
    private PassService passService;
	
	@Resource(name = "userCommonService")
	private UserCommonService userCommonService;
	
	@Resource(name = "userService")
	private UserService userService;
	

	/** log */
    protected static final Log logger = LogFactory.getLog(PassController.class);

    /**
	 * 기본화면으로 진입
	 * 
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="pass/ibPass.do")
	public String ibPass(ModelMap model,
						HttpSession session,
						HttpServletRequest request,
						@RequestParam Map<String,String> map) throws Exception{
		
		String targetUrl = "work/getDailyWorkPass.do";		//기본화면 (세션 존재시)

		String loginId = EgovFileScrty.decode(map.get("ibtopass"));
		
		
		if(session.getAttribute("baseUserLoginInfo") != null){
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			
			if(loginUser.get("loginId").toString().equals(loginId)){
				return "redirect:/" + targetUrl;				
			}else{				
				session.invalidate();		//session initialize
			}
		}
		
		map.put("loginId", loginId);
		String password = passService.getUserPwdByLoginId(map);				//사용자정보 가져옴
		
		
		model.put("loginId", loginId);
		model.put("password", password);
		model.put("targetUrl", targetUrl);
		
		logger.debug("#########loginId#########: " + loginId);
		logger.debug("#########password#########: " + password);
		logger.debug("#########targetUrl#########: " + targetUrl);
		
    	return "pass/ibPass/noHeader";

    }
    
	
	/**
	 * IB to PASS 화면 로긴 오픈 (PASS버튼)
	 * 
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="pass/ibPassOpen.do")
	public String ibPassOpen(ModelMap model,
						HttpSession session,
						HttpServletRequest request,
						@RequestParam Map<String,String> map) throws Exception{

		
		String targetUrl = "";		//기본화면 (세션 존재시)

		String loginId = EgovFileScrty.decode(map.get("ibtopass"));
		
		
		if(session.getAttribute("baseUserLoginInfo") != null){
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			
			if(loginUser.get("loginId").toString().equals(loginId)){
				return "redirect:/"+targetUrl;				
			}else{				
				session.invalidate();		//session initialize
			}
		}
		
		map.put("loginId", loginId);
		String password = passService.getUserPwdByLoginId(map);				//사용자정보 가져옴
		
		
		model.put("loginId", loginId);
		model.put("password", password);
		model.put("targetUrl", targetUrl);
		
		logger.debug("#########loginId#########: " + loginId);
		logger.debug("#########password#########: " + password);
		logger.debug("#########targetUrl#########: " + targetUrl);
		
    	return "pass/ibPassOpen/noHeader";

    }
	

	/**
	 * PASS 상태 정보 통합 컨트롤
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2017. 3. 27.
	 */
	@RequestMapping(value = "/rest/api.do", method = {RequestMethod.POST})
	@ResponseBody
	public Map<String,String> getCompanyList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestBody Map<String,Object> map) throws Exception {
	

		String apiKey = map.get("apiKey").toString();				//서비스 종류


		List<Map> list = null;		
		HashMap result = new HashMap();
		Map resultMap = new HashMap();
		int upCnt = -1;

		Gson gson = new GsonBuilder().serializeNulls().create();
		
		try{
			//========================= 주는 프로세스 ==========================
			if("REQ_NEW_COUNT".equals(apiKey)){								//각종 신규 정보 (개선요청게시판 신규건 등..)
				
				list = passService.getNewArticleList(null);
				result.put("newArticleList", gson.toJson(list));
				
			}else if("REQ_PASS_SYNERGY_USER_STATUS".equals(apiKey)){		//시너지 사용자 상태 정보
				
				list = passService.getSynergyUserStatusList(null);		
				result.put("passSynergyUserStatusList", gson.toJson(list));
			
			}else if("REQ_PASS_SYNERGY_USER_BASE_CODE".equals(apiKey)){		//시너지 사용자 BASE CODE 20170919 ksm
				
				list = passService.getSynergyUserBaseCodeList(map);
				result.put("passSynergyUserBaseCode", gson.toJson(list));
				
			}else if("REQ_PASS_SYNERGY_USER_ROLE_COMBO".equals(apiKey)){		//시너지 사용자 ROLE 20170919 ksm
			
				list = passService.getSynergyUserRoleCodeCombo(map);
				result.put("passSynergyUserRoleCombo", gson.toJson(list));
				
			}else if("REQ_PASS_SYNERGY_USER_COMPANY_COMBO".equals(apiKey)){		//시너지 사용자 소속회사 20170920 ksm
			
				list = passService.getSynergyUserRoleCompanyCombo(map);
				result.put("passSynergyUserCompanyCombo", gson.toJson(list));
				
			}else if("REQ_PASS_SYNERGY_DEPT_COMBO".equals(apiKey)){		//시너지 사용자 부서 20170920 ksm
				
				list = passService.getSynergyDeptCombo(map);
				result.put("passSynergyDeptCombo", gson.toJson(list));
				
			}else if("REQ_PASS_SYNERGY_USER_SAVE".equals(apiKey)){		//시너지 사용자 PASS 등록 20170921 ksm				
				
				resultMap = passService.getUserInfoByLoginId(map);		//IB 로그인유저 로그인ID로 PASS 정보 얻기 
				
				map.put("userPwd", EgovFileScrty.encryptPassword(map.get("userPwd").toString()));		//비밀번호 암호화
				map.put("userSeq", resultMap.get("userId").toString());
				map.put("rgId", resultMap.get("loginId").toString());
				map.put("usrCusId", resultMap.get("cusId").toString());
				map.put("regOrgId", resultMap.get("orgId").toString());
				
				upCnt = userService.insertUser(map);
				
				result.put("passSynergyUserSaveCnt", upCnt);
				
			}else if("REQ_PASS_SYNERGY_USER_FIRE".equals(apiKey)){		//시너지 사용자 퇴직 처리 20170921 ksm
												
				resultMap = passService.getUserInfoByLoginId(map);		//IB 로그인유저 로그인ID로 PASS 정보 얻기 
				map.remove("saveLoginId");								//param 로그인ID 초기화
								
				map.put("sessionUserId", resultMap.get("userId").toString());	//IB 로그인유저 PASS userID
				map.put("userLoginId", resultMap.get("loginId").toString());	//IB 로그인유저 PASS 로그인ID
				
				map.put("saveLoginId", map.get("usrId").toString());	//찾을려는 로그인ID 퇴사 대상자ID로  
				resultMap = passService.getUserInfoByLoginId(map);		//IB 퇴사 대상자 로그인ID로 PASS 정보 얻기 
				
				map.put("userId", resultMap.get("userId").toString());	//퇴사 대상자 userID
				upCnt = passService.doSynergyUserFire(map);		
				
				result.put("passSynergyUserFireCnt", upCnt);
			}
		
			result.put("successYN", "Y");
			result.put("failureMsg","");
				
			return result;
			
		}catch(Exception e){			
			logger.error("PASS 상태 정보 통합 컨트롤", e);
			e.printStackTrace();
			result.put("successYN", 		"N");
			result.put("failureMsg",		"ERROR");
			return result;			
		}

	}
	

}