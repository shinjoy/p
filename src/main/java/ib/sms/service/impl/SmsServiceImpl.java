package ib.sms.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;













import ib.basic.web.UtilReplaceTag;
import ib.cmm.util.fcc.service.StringUtil;
import ib.sms.service.SmsService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("smsService")
public class SmsServiceImpl extends AbstractServiceImpl implements SmsService {

	 @Resource(name="smsDAO")
	 private SmsDAO smsDAO;

	public int insertSmsLog(Map<String, Object> map) throws Exception {

		int saveCnt =0;
		int smsId =0;	//sms id
		String content = map.get("content").toString();		//내용
		String type = map.get("type").toString();			//특별한 케이스인 경우 처리를 위해사용
		String strTemp = "";


		/*  SMSType				: 문자전송 타입
		 *  content				: 내용
		 *	recieveUserId		: 받는이(직원) -여러명일경우 , 구분
		 *  recieveCustomerId	: 받는이(고객) -여러명일경우 , 구분
		 *  userId				: 작성자
		 *  sendUserId			: 보내는이(id)
		 *  reserveDate			: 발송시간
		 *
		*/

		Map smsMap = new HashMap();
		smsMap.put("userId",map.get("userId")); 			//작성자(userId)
		smsMap.put("sendUserId",map.get("sendUserId")); 	//보내는 사람(bs_user_master 의 userId)

		//관계사 SMS 전송 대표번호 가져오기
		String smsEndTelNo = smsDAO.getSmsEndTelNo(smsMap);
		//관계사 SMS 전송 대표번호가 있는경우만 SMS 전송함
		if(!StringUtil.isEmpty(smsEndTelNo)){
			smsMap.put("smsEndTelNo", smsEndTelNo);

		   Integer bytes = content.getBytes().length;
	        if(bytes>90){
	        	smsMap.put("smsType","5"); // LMS
	        }else{
	        	smsMap.put("smsType","3"); // SMS
	        }

			strTemp +=content;
			strTemp = strTemp.replace("\r", "");
			smsMap.put("content",strTemp);						//문자 내용

			smsMap.put("reserveDate",map.get("reserveDate"));	//문자발송시간

			String userIdStr = (map.get("userIdList").toString());
			String customerIdStr = (map.get("customerList").toString());

			String [] userIdArr = (userIdStr.equals("") ? null : (map.get("userIdList").toString()).split(","));			//sms 받을 사람들..(직원)
			String [] customerArr = (customerIdStr.equals("") ? null : (map.get("customerList").toString()).split(",")); 	//sms 받을 사람들..(고객)

			//직원
			if(userIdArr !=null){
				for(int i=0;i<userIdArr.length;i++){
					if(!userIdArr[i].equals("")){
						smsMap.put("recieveUserId",userIdArr[i]);		//받는이
						try{

							smsId = smsDAO.insertSMS(smsMap);
							smsMap.put("smsId", smsId);
							sendSms(smsMap);


						}catch(Exception e){

							e.printStackTrace();
						}
					}
				}
			}

			//고객
			if(customerArr !=null){
				for(int i=0;i<customerArr.length;i++){
					if(!customerArr[i].equals("")){
						smsMap.put("recieveCustomerId",customerArr[i]);		//받는이
						try{
							smsId = smsDAO.insertSMS(smsMap);
							smsMap.put("smsId", smsId);
							sendSms(smsMap);

						}catch(Exception e){

							e.printStackTrace();
						}
					}
				}
			}
		}

		return saveCnt;
	}

	//log 조회
	public List<Map> getSmsLogList(Map<String, Object> map) throws Exception{

		return smsDAO.getSmsLogList(map);
	}


	//SMS발송
	public int sendSms(Map<String, Object> smsMap){
		int chk=0;

		try{
			List<Map>list = getSmsLogList(smsMap);

			for(int i=0;i<list.size();i++){

					UtilReplaceTag rpTag = new UtilReplaceTag();
					StringBuffer buffer = new StringBuffer();
					String uid ="synergy";
					String pwd ="00synergy00";
					String sendType=list.get(i).get("smsType").toString();
					String toNumber=list.get(i).get("recieveNumber").toString();
					String contents=rpTag.replaceTag(list.get(i).get("content").toString(),"decode");
					contents=URLEncoder.encode(contents, "UTF-8");	//인코딩.
					String fromNumber=list.get(i).get("sendNumber").toString();
					String startTime=list.get(i).get("reserveDate").toString();


					String indexCode=list.get(i).get("smsId").toString();

					String returnType="1";
					String nType="2";


					String returnUrl ="";
					String url = "https://biz.moashot.com/EXT/URLASP/mssendUTF.asp";

					URL obj = new URL(url);

					URLConnection conn = obj.openConnection();

					String urlParameters = "uid="+uid+"&pwd="+pwd+"&sendType="+sendType+"&toNumber="+toNumber+"&contents="+contents+"&fromNumber="+fromNumber;
				    urlParameters+="&startTime="+startTime+"&indexCode="+indexCode+"&returnType="+returnType+"&nType="+nType+"&returnUrl="+returnUrl;
				    conn.setDoOutput(true);
				    OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
				    // 파라미터를 wr에 넣어주고 flush
				    wr.write(urlParameters);
				    wr.flush();
				    // in에 readLine이 null이 아닐때까지 StringBuffer에 append
				    BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				    String inputLine;
				    while ((inputLine = in.readLine()) != null) {
				         buffer.append(inputLine);
				    }
				    in.close();
				    wr.close();
			}

		}catch(Exception e){
			chk =-1;
		}
		return chk;
	}

	//sms 결과
	public void smsSendResult(HttpServletRequest req) throws Exception{

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String Data = req.getParameter("data");				// 인덱스코드,전송결과값
		String SeqTemp = "";

		for(int i = 0; i < Data.split(",").length; i++) {
			Map<String, Object> paramTemp = new HashMap<String, Object>();

			if((i%2) == 0) SeqTemp = Data.split(",")[i];
			else {
				paramTemp.put("smsId", SeqTemp);
				paramTemp.put("resultFlag", Data.split(",")[i]);
			}
			paramTemp.put("sendDate", req.getParameter("send_start"));
			paramTemp.put("resultDate", req.getParameter("send_end"));
			if((i%2) == 1) smsDAO.smsSendResult(paramTemp);
		}


	}

}
