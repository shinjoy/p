package ib.email.service.impl;

import ib.basic.web.Util;
import ib.email.service.EmailService;

import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("emailService")
public class EmailServiceImpl extends AbstractServiceImpl implements EmailService {

	//final private String MAILPLUG_AUTH_URL = "https://ma191.mailplug.co.kr/lw_api/auth_sso";				// 메일플러그 자동로그인 URL
	final private String secretKey = "synergyEmail!@34";			// 메일 암호 암/복호화 키값
	
	protected static final Log logger = LogFactory
			.getLog(EmailServiceImpl.class);

	@Resource(name = "emailDAO")
	private EmailDAO emailDAO;

	
	// 이메일 서비스 정보(이메일 서비스 주소 등)
	public Map getEmailServiceInfo(Map param) throws Exception {
		return emailDAO.getEmailServiceInfo(param);
	}

	// 사용자 이메일 링크 정보 및 이메일 계정 정보 조회
	public Map getEmailLinkInfo(Map param) throws Exception {		
		return emailDAO.getEmailLinkInfo(param);
	}
	
	public String getEmailAuthentication(String serviceName, String emailId, String emailPassword, String mailUrl, String mailApiUrl) throws Exception{
		
		String authUrl = "";
		
		// 메일플러그 자동로그인 프로세스
		if( serviceName.equals("mailplug")){
			
			// 비밀번호 복호화
			String decEmailPasswd = Util.decryptAES(emailPassword, secretKey);			
		
			String locationUrl = "";
				
			// 자동로그인 시도
			URL urlObj = new URL(mailApiUrl);	
			HttpURLConnection conn = (HttpURLConnection)urlObj.openConnection();	
			
			conn.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded");
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setDefaultUseCaches(false);
			
			String urlParameters = "cid=" + emailId + "&cpw=" + decEmailPasswd;
			urlParameters += "&pw_type=1";
			
			urlParameters += "&host_domain=" + mailUrl.substring(mailUrl.indexOf('.')+1);	//synergynet.co.kr";
			urlParameters += "&cdomain=" + mailUrl;											//mail.synergynet.co.kr";
			
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
	
		    wr.write(urlParameters);
		    wr.flush();
		    wr.close();
		    
		    String params = "";
		    
		    try{
		    	authUrl = conn.getHeaderField("Location");

		    	//로그인 성공 여부를 확인하기 위해 데이타 파싱
		    	params = authUrl.substring(authUrl.indexOf("myvalue=") + 8);
		    	
		    }catch(Exception e){
		    	e.printStackTrace();
		    	return "error";
		    }
		    
		    if( params.length() == 0 ) authUrl = "error";
		}
		
		return authUrl;
	}
			

	public int updateEmailLinkInfo(Map<String, Object> param) throws Exception{
		return emailDAO.updateEmailLinkInfo(param);
	}
	
	public String getAesSecretKey() throws Exception{
		return secretKey;
	}
}
