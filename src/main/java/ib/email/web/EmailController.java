package ib.email.web;


import ib.basic.web.Util;
import ib.cmm.LoginVO;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.email.service.EmailService;

import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
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

@Controller
public class EmailController {

	protected static final Log logger = LogFactory.getLog(EmailController.class);
	
	@Resource(name="emailService")
	private EmailService emailService;
		 
	
	/**
	 * emailView - 메일 자동 로그인 화면으로 이동한다 
	 * @return Content Page
	 * @exception Exception
	 */
	@RequestMapping(value="/email/emailView.do")
	public String emailView(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			ModelMap model) throws Exception{		
		
		// 
		try{				
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			
			Map emailLinkInfo = emailService.getEmailLinkInfo(loginUser);
			Map emailServInfo = emailService.getEmailServiceInfo(loginUser);
			
			String linkFlag = emailLinkInfo.get("mailLinkFlag").toString();
			String emailId = emailLinkInfo.get("mailId").toString();
			String emailPasswd = emailLinkInfo.get("mailPassword").toString();
			
			String serviceName = emailServInfo.get("mailServiceName").toString();
			String linkType = emailServInfo.get("mailLinkType").toString();
			String mailUrl = emailServInfo.get("mailUrl").toString();
			String mailApiUrl = emailServInfo.get("mailApiUrl").toString();
			
			// 자동로그인 설정이 되어 있지 않은 경우 셋업 화면으로 이동
			if( linkFlag.equals("N")){
				model.addAttribute("emailId", emailId);
				model.addAttribute("emailPassword", Util.decryptAES(emailPasswd, emailService.getAesSecretKey()));
				model.addAttribute("needEmailLink", "Y");				
				model.addAttribute("mode", "new");
				model.addAttribute("leftMenuStr", "emailLinkSetup");
				model.addAttribute("currentMenuKor", "메일 계정설정");
				model.addAttribute("menuKorPath","<span class='divide'>My Page</span><span class='divide current'>메일 계정설정</span>");
				return "email/emailLinkSetup/fixLeft";
			}
	
			String emailAuthUrl = "";
			// 메일플러그인에 대해 자동로그인 지원
			if( serviceName.equals("mailplug")){
				emailAuthUrl = emailService.getEmailAuthentication(serviceName, emailId, emailPasswd, mailUrl, mailApiUrl);
			
				// 만약 자동로그인 실패했을 경우 셋업 화면으로 이동			
				if( emailAuthUrl.equals("error") ) {
					model.addAttribute("emailId", emailId);
					model.addAttribute("emailPassword", Util.decryptAES(emailPasswd, emailService.getAesSecretKey()));
					model.addAttribute("needEmailLink", "Y");
					model.addAttribute("mode", "edit");
					model.addAttribute("leftMenuStr", "emailLinkSetup");
					model.addAttribute("currentMenuKor", "메일 계정설정");
					model.addAttribute("menuKorPath","<span class='divide'>My Page</span><span class='divide current'>메일 계정설정</span>");
					return "email/emailLinkSetup/fixLeft";
				}
			}
			else if( serviceName.equals("etc") ){
				emailAuthUrl = mailUrl;
			}
			
			model.addAttribute("authUrl", emailAuthUrl);
			model.addAttribute("emailLinkType", linkType);
			model.addAttribute("leftMenuStr", "emailLinkView");
			model.addAttribute("currentMenuKor", "메일");
			model.addAttribute("menuKorPath","<span class='divide'>My Page</span><span class='divide current'>메일</span>");
			
		}catch(Exception e){				
			e.printStackTrace();
		}
		return "email/emailLinkView/fixLeft";
	}
	
	
	/**
	 * emailLinkSetup - 메일계정 설정 화면으로 이동한다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return Content Page
	 * @exception Exception
	 */
	@RequestMapping(value="/email/emailLinkSetup.do")	
	public String emailLinkSetup(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			ModelMap model) throws Exception{		
		try{
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			
			Map emailLinkInfo = emailService.getEmailLinkInfo(loginUser);
			Map emailServInfo = emailService.getEmailServiceInfo(loginUser);
			
			String linkFlag = emailLinkInfo.get("mailLinkFlag").toString();
			String emailId = emailLinkInfo.get("mailId").toString();
			String emailPasswd = emailLinkInfo.get("mailPassword").toString();
			String serviceName = emailServInfo.get("mailServiceName").toString();			

			model.addAttribute("emailId", emailId);
			model.addAttribute("emailPassword", Util.decryptAES(emailPasswd, emailService.getAesSecretKey())); 
			model.addAttribute("needEmailLink", linkFlag.equals("N") ? "Y" : "N");
			model.addAttribute("mode", linkFlag.equals("N") ? "new" : "edit");// 등록, 수정 모드 지정			
			
			model.addAttribute("leftMenuStr", "emailLinkSetup");			
			model.addAttribute("currentMenuKor", "메일 계정설정");
			model.addAttribute("menuKorPath","<span class='divide'>My Page</span><span class='divide current'>메일 계정설정</span>");
		}catch(Exception e){				
			e.printStackTrace();
		}
		return "email/emailLinkSetup/fixLeft";
	}	
	
	/**
	 * getEmailInfo
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value="/email/getEmailInfo.do")
	public void getEmailInfo(
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{
		
		try{		
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
						
			Map emailLinkInfo = emailService.getEmailLinkInfo(loginUser);			
			Map emailServInfo = emailService.getEmailServiceInfo(loginUser);			

			Map obj = new HashMap();
			obj.put("emailServiceInfo", emailServInfo);
			obj.put("emailLinkInfo", emailLinkInfo);
			
			AjaxResponse.responseAjaxObject(response, obj);			//결과전송*/

		}catch(Exception e){				
			e.printStackTrace();
		}
	}
	
	
	/**
	 * getEmailInfo
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return Content Page
	 * @exception Exception
	 */
	@RequestMapping(value="/email/updateEmailLinkInfo.do")
	public void updateEmailLinkInfo(
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{
		
		try{		
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			
			map.put("userId", loginUser.get("userId"));
			map.put("orgId", loginUser.get("orgId"));
			
			String encPassword = Util.encryptAES(map.get("mailPassword").toString(), emailService.getAesSecretKey());
			//remove(key)
			if( map.get("mailLinkFlag").equals("Y"))
				map.put("mailPassword", encPassword);	
			
			int nId = emailService.updateEmailLinkInfo(map);			
						
			AjaxResponse.responseAjaxObject(response, "OK");			//결과전송*/

		}catch(Exception e){				
			e.printStackTrace();
		}
	}		
}
