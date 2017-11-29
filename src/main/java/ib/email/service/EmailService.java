package ib.email.service;

import java.util.List;
import java.util.Map;

public interface EmailService {

	// 관계사 이메일 서비스 정보 조회
	public Map getEmailServiceInfo(Map param) throws Exception;

	// 사용자 이메일 연동 정보 조회 
	public Map getEmailLinkInfo(Map param) throws Exception;
	
	// 자동로그인 URL 확보
	public String getEmailAuthentication(String serviceName, String emailId, String emailPassword, String mailUrl, String mailApiUrl) throws Exception;

	public int updateEmailLinkInfo(Map<String, Object> map) throws Exception;

	public String getAesSecretKey() throws Exception;
}
