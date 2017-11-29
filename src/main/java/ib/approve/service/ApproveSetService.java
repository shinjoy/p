package ib.approve.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package	: ibiss.approve.service
 * filename	: ApproveSetService.java
 * </pre>
 *
 * 전자결재 서비스
 *
 * @author :  Inhee
 * @date : 2017. 7. 24.
 * @version :
 *
 */
public interface ApproveSetService {
	//필수수신참조자설정 리스트
  	public List<EgovMap> getAppvReceiverSetupList(Map<String,Object> paramMap) throws Exception;

  	//필수수신참조자설정 저장
    public Integer processAppvReceiverSetup(Map<String,Object> map) throws Exception;

    //종결전 문서열람설정 리스트
  	public List<EgovMap> getAppvReadSetupList(Map<String,Object> paramMap) throws Exception;

  	//종결전 문서열람설정 저장
    public Integer processAppvReadSetup(Map<String,Object> map) throws Exception;

    //지출결의서설정 리스트
  	public EgovMap getAppvExpenseSetupDetail(Map<String,Object> paramMap) throws Exception;

  	//지출담당자설정 리스트
  	public List<EgovMap> getAppvManagerSetupList(Map<String,Object> paramMap) throws Exception;

  	//지출일설정 리스트
  	public List<EgovMap> getAppvDaySetupList(Map<String,Object> paramMap) throws Exception;

  	//지출결의서설정 저장
    public Integer processAppvExpenseSetup(Map<String,Object> map) throws Exception;

    //필수 수신자 , 참가자 리스트 조회
  	public List<EgovMap> getOrgReceiverSetupList(Map<String,Object> paramMap) throws Exception;

  	//미결알림 셋팅 리스트
  	public List<EgovMap> appvAlarmSetupList(Map<String,Object> paramMap) throws Exception;

  	// 미결알림 세팅 저장
    public Integer processAppvAlarmSetup(Map<String,Object> map) throws Exception;
}
