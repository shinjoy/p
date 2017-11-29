package ib.approve.service.impl;


import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.approve.service.ApproveVo;
import ib.cmm.service.impl.ComAbstractDAO;


/**
 * <pre>
 * package	: ibiss.system.service.impl
 * filename	: ApproveDAO.java
 * </pre>
 *
 * 전자결재 DAO
 *
 * @author :  Inhee
 * @date : 2017. 7. 24.
 * @version :
 *
 */
@Repository("approveSetDAO")
public class ApproveSetDAO extends ComAbstractDAO{


	protected static final Log logger = LogFactory.getLog(ApproveSetDAO.class);

	//필수수신참조자설정 리스트
  	public List<EgovMap> getAppvReceiverSetupList(Map<String,Object> paramMap) throws Exception{
  		return list("approveSet.getAppvReceiverSetupList", paramMap);
  	}

  //필수수신참조자설정 삭제
  	public Integer deleteAppvReceiverSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approveSet.deleteAppvReceiverSetup", paramMap);
  	}

  //필수수신참조자설정 저장
  	public Integer insertAppvReceiverSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)insert("approveSet.insertAppvReceiverSetup", paramMap);
  	}

  //필수수신참조자설정 키값 가져오기
  	public EgovMap getAppvReceiverSetupKey(Map<String,Object> paramMap) throws Exception{
  		return (EgovMap)getSqlMapClientTemplate().queryForObject("approveSet.getAppvReceiverSetupKey", paramMap);
  	}

  	//필수수신참조자 삭제
  	public Integer deleteAppvReceiverUser(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approveSet.deleteAppvReceiverUser", paramMap);
  	}

  //필수수신참조자 저장
  	public Integer insertAppvReceiverUser(Map<String,Object> paramMap) throws Exception{
  		return (Integer)insert("approveSet.insertAppvReceiverUser", paramMap);
  	}

  //종결전 문서열람설정 리스트
  	public List<EgovMap> getAppvReadSetupList(Map<String,Object> paramMap) throws Exception{
  		return list("approveSet.getAppvReadSetupList", paramMap);
  	}

  //종결전 문서열람설정 삭제
  	public Integer deleteAppvReadSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approveSet.deleteAppvReadSetup", paramMap);
  	}

  //종결전 문서열람설정 저장
  	public Integer insertAppvReadSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)insert("approveSet.insertAppvReadSetup", paramMap);
  	}

  	/*********************************************************/
    //지출결의서설정 리스트
  	public EgovMap getAppvExpenseSetupDetail(Map<String,Object> paramMap) throws Exception{
  		return (EgovMap)getSqlMapClientTemplate().queryForObject("approveSet.getAppvExpenseSetupDetail", paramMap);
  	}

    //지출결의서설정 삭제
  	public Integer deleteAppvExpenseSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approveSet.deleteAppvExpenseSetup", paramMap);
  	}

    //지출결의서설정 저장
  	public Integer insertAppvExpenseSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)insert("approveSet.insertAppvExpenseSetup", paramMap);
  	}

    //지출담당자설정 리스트
  	public List<EgovMap> getAppvManagerSetupList(Map<String,Object> paramMap) throws Exception{
  		return list("approveSet.getAppvManagerSetupList", paramMap);
  	}

    //지출담당자설정 삭제
  	public Integer deleteAppvManagerSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approveSet.deleteAppvManagerSetup", paramMap);
  	}

    //지출담당자설정 저장
  	public Integer insertAppvManagerSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)insert("approveSet.insertAppvManagerSetup", paramMap);
  	}

  	//지출일설정 리스트
  	public List<EgovMap> getAppvDaySetupList(Map<String,Object> paramMap) throws Exception{
  		return list("approveSet.getAppvDaySetupList", paramMap);
  	}

    //지출일설정 삭제
  	public Integer deleteAppvDaySetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approveSet.deleteAppvDaySetup", paramMap);
  	}

    //지출일설정 저장
  	public Integer insertAppvDaySetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)insert("approveSet.insertAppvDaySetup", paramMap);
  	}

  	//필수수신참조자설정 리스트
  	public List<EgovMap> getOrgReceiverSetupList(Map<String,Object> paramMap) throws Exception{
  		return list("approveSet.getOrgReceiverSetupList", paramMap);
  	}

  	//미결알림 셋팅 리스트
  	public List<EgovMap> appvAlarmSetupList(Map<String,Object> paramMap) throws Exception{
  		return list("approveSet.appvAlarmSetupList", paramMap);
  	}
  	//미결알림 세팅 저장
  	public Integer insertAppvAlarmSetup(Map<String,Object> paramMap) throws Exception{
  		return (Integer)insert("approveSet.insertAppvAlarmSetup", paramMap);
  	}

  	//미결알림 세팅 수정
  	public Integer updateAppvAlarmSetup(Map<String,Object> paramMap) throws Exception{
  		return update("approveSet.updateAppvAlarmSetup", paramMap);
  	}

}