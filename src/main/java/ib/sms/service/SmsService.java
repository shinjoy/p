package ib.sms.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SmsService {
	
	//sms log기록
	public int insertSmsLog(Map<String, Object> map) throws Exception;
	
	//sms 기록 조회
	public List getSmsLogList(Map<String, Object> map) throws Exception;
		
	//sms 발송
	public int sendSms(Map<String, Object> map) throws Exception;
	
	//sms 결과
	public void smsSendResult(HttpServletRequest req) throws Exception;
	
	

}
