package ib.sms.service.impl;

import java.util.List;
import java.util.Map;

import ib.cmm.service.impl.ComAbstractDAO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("smsDAO")
public class SmsDAO extends ComAbstractDAO{

	//sms log 기록
	public int insertSMS(Map<String, Object> param) throws Exception{
		return  Integer.parseInt(insert("sms.insertSms", param).toString());
	}

	//sms log 조회
	public List<Map> getSmsLogList(Map<String, Object> map) throws Exception{
		return  list("sms.getSmsLogList", map);
	}

	//전송 결과 업데이트
	public void smsSendResult(Map<String, Object> map) throws Exception{
		update("sms.smsSendResult", map);
	}

	//관계사 SMS 전송 대표번호
	public String getSmsEndTelNo(Map<String, Object> map) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject("sms.getSmsEndTelNo", map);
	}

}
