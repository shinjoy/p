package ib.sms.web;

import ib.cmm.util.sim.service.AjaxResponse;

import ib.sms.service.SmsService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class SmsController {

	
	protected static final Log logger = LogFactory.getLog(SmsController.class);
	
	@Resource(name = "smsService")
	private SmsService smsService;
	
	
	/*
	 * 	문자 전송 필수 파라미터
	 * 
	 * 	sendUserId		보내는이 - 변경을위해 파라미터로 받음.
	 *	userIdList		문자를 받을 유저 아이디(직원)	-여러명 , 구분
	 *	customerList	문자를 받을 유저 아이디(고객)	-여러명 , 구분
	 *	content			문자내용
	 *	reserveDate		실제 발송시간
	 *	type			특별한 케이스일경우 타입을 추가해 서비스에서 처리해주면 된다.
	 *
	 *
	*/

	//sms 전송
	@RequestMapping(value="/sms/sendSms.do")
	public void doSmsSend(HttpServletResponse response,
			HttpSession session,@RequestParam Map<String,Object> map) throws Exception{
		
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId",loginInfo.get("userId"));		
		int saveCnt = smsService.insertSmsLog(map);
		AjaxResponse.responseAjaxSave(response, saveCnt);
	}
		
	// 문자 전송결과 받기
	@RequestMapping(value = "/sms/smsSendResult.do")
	public void smsSendResult(HttpServletRequest req) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		smsService.smsSendResult(req);
	
	}
	
	

	
}