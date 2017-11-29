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
 * @author	:  Park
 * @date	: 2016. 10. 20.
 * @version :
 *
 */
@Repository("approveDAO")
public class ApproveDAO extends ComAbstractDAO{


	protected static final Log logger = LogFactory.getLog(ApproveDAO.class);

	//휴가 신청서 작성시 연차정보 조회
	public EgovMap getUserHolidaySum(Map map) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getUserHolidaySum", map);
	}

	//출장신청 저장...
	public Integer insertTripApprove(Map<String, Object> paramMap) throws Exception {
		return (Integer)insert("approve.insertTripApprove", paramMap);
	}
	//출장신청 수정
	public Integer updateTripApprove(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("approve.updateTripApprove", paramMap);
	}
	//품의서 수정
	public Integer updateApproveDoc(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("approve.updateApproveDoc", paramMap);
	}

	//경조사신청 저장...
	public Integer insertEventApprove(Map<String, Object> paramMap) throws Exception {

		return (Integer)insert("approve.insertEventApprove", paramMap);
	}
	//구매신청 수정...
	public Integer modifyEventApprove(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("approve.modifyEventApprove", paramMap);
	}
	//교육신청 저장...
	public Integer insertEducationApprove(Map<String, Object> paramMap) throws Exception {
		return (Integer)insert("approve.insertEducationApprove", paramMap);
	}
	//교육청 수정...
	public Integer modifyEducationApprove(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("approve.modifyEducationApprove", paramMap);
	}
	//교육참여자 삭제
	public Integer deleteEntryWorker(Map<String, Object> paramMap) throws Exception {
		return (Integer)delete("approve.deleteEntryWorker", paramMap);
	}

	//구매신청 품의리스트 저장
	public Integer insertBuyList(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("approve.insertBuyList", paramMap);
	}
	//지출결의서 지출 품의리스트 저장
	public Integer insertExpenseList(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("approve.insertExpenseList", paramMap);
	}
	//지출결의서 지출 품의리스트삭제
	public Integer deleteExpenseList(Map<String, Object> paramMap) throws Exception {
		return delete("approve.deleteExpenseList", paramMap);
	}
	//출장비 리스트 저장
	public Integer insertTripList(Map<String, Object> paramMap) throws Exception {
		return (Integer)insert("approve.insertTripList", paramMap);
	}

	//참조인저장
	public Integer insertApproveCc(Map<String, Object> paramMap) throws Exception {
		Integer cnt = 0 ;
		//if(paramMap.get("approveCcId")!=null){
			cnt = (Integer)insert("approve.insertApproveCc", paramMap);
		//}
		return cnt;
	}
	//수신인저장
	public Integer insertApproveRc(Map<String, Object> paramMap) throws Exception {
		Integer cnt = 0 ;
		//if(paramMap.get("approveRcId")!=null){
			cnt = (Integer)insert("approve.insertApproveRc", paramMap);
		//}
		return cnt;
	}
	//품의 참가자 저장
	public Integer insertEntryWorker(Map<String, Object> paramMap) throws Exception {
		return (Integer)insert("approve.insertEntryWorker", paramMap);
	}
	//참조인삭제
	public Integer deleteApproveCc(Map<String, Object> paramMap) throws Exception {
		return (Integer)delete("approve.deleteApproveCc", paramMap);
	}
	//수신인삭제
	public Integer deleteApproveRc(Map<String, Object> paramMap) throws Exception {
		return (Integer)delete("approve.deleteApproveRc", paramMap);
	}
	//출장비내역 삭제
	public Integer deleteApproveTripList(Map<String, Object> paramMap) throws Exception {
		return (Integer)delete("approve.deleteApproveTripList", paramMap);
	}

	//구매물품 삭제
	public Integer deleteBuyList(Map<String, Object> paramMap) throws Exception {
		return (Integer)delete("approve.deleteBuyList", paramMap);
	}

	//휴가일수를 차감한다
	public Integer updateUserHoliSum(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("approve.updateUserHoliSum", paramMap);
	}
	//휴가일수를 저장한다.
	public Integer insertUserHoliSumHist(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("approve.insertUserHoliSumHist", paramMap);
	}

	//품의서 상세 조회
	public EgovMap getApproveDocDetail(Map map) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getApproveDocDetail", map);
	}


	//기안문서 summary
	public EgovMap getDraftSummary(Map<String,Object> paramMap) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getDraftSummary", paramMap);
	}
	//결재문서 summary
	public EgovMap getReqSummary(Map<String,Object> paramMap) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getReqSummary", paramMap);
	}
	//기안문서 List
	public List<EgovMap> getDraftDocList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getDraftDocList", paramMap);
	}
	//결재문서 List
	public List<EgovMap> getReqDocList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getReqDocList", paramMap);
	}
	//메인화면결재문서 List
	public List<EgovMap> getReqDocListForMain(Map<String,Object> paramMap) throws Exception{
		return list("approve.getReqDocListForMain", paramMap);
	}
	//승인취소 List
	public List<EgovMap> getCancelDocList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getCancelDocList", paramMap);
	}
	//참조문서 List
	public List<EgovMap> getRefDocList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getRefDocList", paramMap);
	}
	//수신문서 List
	public List<EgovMap> getRcDocList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getRcDocList", paramMap);
	}
	//지출문서 List
	public List<EgovMap> getAppvDocExpenseList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getAppvDocExpenseList", paramMap);
	}
	//지출문서 총개수
	public Integer getAppvDocExpenseListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getAppvDocExpenseListTotalCnt", paramMap);
	}
	//기안문서 총개수
	public Integer getDraftDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getDraftDocListTotalCnt", paramMap);
	}
	//결재문서 총개수
	public Integer getReqDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getReqDocListTotalCnt", paramMap);
	}
	//승인취소문서 총개수
	public Integer getCancelDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getCancelDocListTotalCnt", paramMap);
	}
	//참조문서 총개수
	public Integer getRefDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getRefDocListTotalCnt", paramMap);
	}
	//수신문서 총개수
	public Integer getRcDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getRcDocListTotalCnt", paramMap);
	}
	//품의 참조자를 조회한다
	public List<EgovMap> getApproveCcList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getApproveCcList", paramMap);
	}
	//품의 수신자를 조회한다
	public List<EgovMap> getApproveRcList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getApproveRcList", paramMap);
	}
	//결재라인을 검색 List
	public List<EgovMap> getApproveLine(Map<String, Object> paramMap) throws Exception {
		return list("approve.getApproveLine", paramMap);
	}
	//직접지정 결재라인을 검색 List
	public List<EgovMap> getApproveLineIndividual(Map<String, Object> paramMap) throws Exception {
		return list("approve.getApproveLineIndividual", paramMap);
	}
	//품의서 상신
	public Integer insertApproveProcess(Map<String,Object> paramMap) throws Exception{
		return (Integer)insert("approve.insertApproveProcess", paramMap);
	}
	//품의서 상신(결재라인직접지정)
	public Integer insertApproveProcessIndividual(Map<String,Object> paramMap) throws Exception{
		return (Integer)insert("approve.insertApproveProcessIndividual", paramMap);
	}
	//중복결재라인 삭제
	public Integer deleteDupApproveProcess(Map<String,Object> paramMap) throws Exception{
		return (Integer)delete("approve.deleteDupApproveProcess", paramMap);
	}
	//품의서 상태변경
	public Integer modifyAprvStatus(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.modifyAprvStatus", paramMap);
	}
	//취소처리시 품의서 상태변경
	public Integer modifyCancelAprvStatus(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.modifyCancelAprvStatus", paramMap);
	}

	//승인대리자 처리
	public Integer insertApproveAgency(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.insertApproveAgency", paramMap);
	}
	//승인대리자 삭제
	public Integer deleteApproveAgency(Map<String,Object> paramMap) throws Exception{
		return (Integer)delete("approve.deleteApproveAgency", paramMap);
	}
	//품의승인절차 상태값변경
	public Integer updateProcessStatus(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.updateProcessStatus", paramMap);
	}
	//인처리시 해당 순번 중 승인처리 되지 않은 CNT 조회
	public Integer getNoApproveCntSemeAppvSeq(Map<String, Object> paramMap) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getNoApproveCntSemeAppvSeq", paramMap);
	}
	//승인시 다음결재라인을 REQ로  UPDATE
	public Integer modifyAprvProcessApproveStatus(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.modifyAprvProcessApproveStatus", paramMap);
	}
	//결재라인중 승인하지않은 cnt
	public Integer getApproveProcessNotCommitCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getApproveProcessNotCommitCnt", paramMap);
	}
	//휴가품의서  마지막결재라인 승인처리인 경우 각 품의문서의 상태값을 승인으로, 중간단계인 경우 승인진행으로 변경
	public Integer modifyAprvStatusApprove(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.modifyAprvStatusApprove", paramMap);
	}
	//마지막결재라인 승인처리인 경우 각 품의문서의 상태값을 승인으로, 중간단계인 경우 승인진행으로 변경
	public Integer modifyAprvStatusApproveBefore(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.modifyAprvStatusApproveBefore", paramMap);
	}

	 //경조사 분류코드를 조회한다
    public List<EgovMap> familyEventsIdList(Map<String, Object> paramMap) throws Exception{
    	return list("approve.familyEventsIdList",paramMap);
    }


    //====================================품의서 추가정보
	//구매리스트 조회
	public List<EgovMap> getApproveBuyList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getApproveBuyList", paramMap);
	}
	//지출리스트 조회
	public List<EgovMap> getApproveExpenseList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getApproveExpenseList", paramMap);
	}

	//품의참가자리스트 조회
	public List<EgovMap> getApproveEntryWokerList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getApproveEntryWokerList", paramMap);
	}

	//출장비리스트 조회
	public List<EgovMap> getApproveTripList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getApproveTripList", paramMap);
	}
	//경조사 상신떄 경조 마지막 날짜와 휴일포함 여부를 update한다
	public Integer modifyApproveEventSubmitInfo(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.modifyApproveEventSubmitInfo", paramMap);
	}

	/**
	 * 품의승인 헤더 번호 가져오기
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer selectApprovalHeaderId(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.selectApprovalHeaderId", map);
	}

	/**
	 * 품의승인 헤더 번호 가져오기(직접지정)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer selectApprovalHeaderIdIndividual(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.selectApprovalHeaderIdIndividual", map);
	}

	/**
	 * 품의승인절차상신전 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer createApprovaeProcessNoSubmit(Map<String, Object> map) throws Exception{
		return update("approve.createApprovaeProcessNoSubmit", map);
	}

	/**
	 * 품의승인절차상신전 등록(직접지정)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer createApprovaeProcessNoSubmitIndividual(Map<String, Object> map) throws Exception{
		return update("approve.createApprovaeProcessNoSubmitIndividual", map);
	}


	/**
	 * 품의승인절차상신전 부서정보 없는 개수 조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer selectApprovaeProcessNoSubmitNoDeptCount(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.selectApprovaeProcessNoSubmitNoDeptCount", map);
	}
	/**
	 * 품의승인절차상신전 부서정보 없는 개수 조회(직접지정)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer selectApprovaeProcessNoSubmitNoDeptCountIndividual(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.selectApprovaeProcessNoSubmitNoDeptCountIndividual", map);
	}


	/**
	 * 품의승인절차상신전 부서정보 업데이트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer updateApprovaeProcessNoSubmit(Map<String, Object> map) throws Exception{
		return update("approve.updateApprovaeProcessNoSubmit", map);
	}
	/**
	 * 품의승인절차상신전 부서정보 업데이트(직접지정)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer updateApprovaeProcessNoSubmitIndividual(Map<String, Object> map) throws Exception{
		return update("approve.updateApprovaeProcessNoSubmitIndividual", map);
	}

	/**
	 * 품의승인절차상신전 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public Integer deleteApprovaeProcessNoSubmit(Map<String, Object> paramMap) throws Exception{
		return (Integer)delete("approve.deleteApprovaeProcessNoSubmit", paramMap);
	}
	//경조사 마지막일 조회
    public EgovMap getEventLastDay(Map<String, Object> paramMap) throws Exception{
    	return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getEventLastDay", paramMap);
    }
    //품의서 삭제
  	public Integer deleteApproveDoc(Map<String, Object> paramMap) throws Exception {
  		return (Integer)delete("approve.deleteApproveDoc", paramMap);
  	}

  	public EgovMap familyEventsDetail(Map<String, Object> paramMap) throws Exception {
  		return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.familyEventsDetail", paramMap);
  	}
  	//품의서 승인시 실제 결재자 업데이트
	public Integer modifyAprvProcessAprvEmpId(Map<String, Object> map) throws Exception{
		return update("approve.modifyAprvProcessAprvEmpId", map);
	}

	//실제 승인/반려자의 코멘트 입력
	public Integer modifyAppvComment(Map<String,Object> paramMap) throws Exception{
		return (Integer)update("approve.modifyAppvComment", paramMap);
	}
	//결제 처리 코멘트 리스트
  	public List<EgovMap> getApproveProcessComment(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getApproveProcessComment", paramMap);
  	}

	//휴가품이서 완료 후 처리
	public Integer insertErpSchApproveVacProcessAfter(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt =(Integer)insert("approve.insertErpSchApproveVacProcessAfter", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}
	//휴가품이서 완료 후 처리2
	public Integer insertErpEntrySchApproveVacProcessAfter(Map<String, Object> map) throws Exception{
		return (Integer)insert("approve.insertErpEntrySchApproveVacProcessAfter", map);
	}
	//경조사품이서 완료 후 처리
	public Integer insertErpSchApproveEventProcessAfter(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt =(Integer)insert("approve.insertErpSchApproveEventProcessAfter", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}
	//경조사품이서 완료 후 처리2
	public Integer insertErpEntrySchApproveEventProcessAfter(Map<String, Object> map) throws Exception{
		return (Integer)insert("approve.insertErpEntrySchApproveEventProcessAfter", map);
	}

	//교육 품이서 완료 후 처리1
	public Integer insertErpSchApproveEduProcessAfter(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt =(Integer)insert("approve.insertErpSchApproveEduProcessAfter", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}
	//교육 품이서 완료 후 처리2
	public Integer insertErpEntryApproveEduProcessAfter(Map<String, Object> map) throws Exception{
		return (Integer)insert("approve.insertErpEntryApproveEduProcessAfter", map);
	}

	//출장 품이서 완료 후 처리1
	public Integer insertErpSchApproveTripProcessAfter(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt =(Integer)insert("approve.insertErpSchApproveTripProcessAfter", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}
	//출장 품이서 완료 후 처리2
	public Integer insertErpEntryApproveTripProcessAfter(Map<String, Object> map) throws Exception{
		return (Integer)insert("approve.insertErpEntryApproveTripProcessAfter", map);
	}
	//dateFrom~dateTo 동안 승인대행자 / 동행자가 휴직상태라면 조회한다.
  	public List<EgovMap> getChkAppointedPerson(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getChkAppointedPerson", paramMap);
  	}
  	//휴가,출장,교육,경조사 선택날짜가 가능한지 체크한다.
    public EgovMap getEnableApprove(Map<String,Object> paramMap) throws Exception{
    	return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getEnableApprove", paramMap);
    }
    //경조사 코드관리 페이지의 리스트를 조회한다
    public List<Map> getEventCodeList(Map<String,Object> map) throws Exception{
    	return list("approve.getEventCodeList", map);
    }
    //경조사 중복여부 체크
    public Integer getChkEventInfoCount(Map<String,Object> map) throws Exception{
    	return (Integer)getSqlMapClientTemplate().queryForObject("approve.getChkEventInfoCount", map);
    }
    //경조사 기준정보 저장
    public Integer insertEventInfo(Map<String,Object> map) throws Exception{
    	return (Integer)insert("approve.insertEventInfo", map);
    }
    //지출결의서 기준정보 저장
    public Integer insertExpenseApprove(Map<String,Object> map) throws Exception{
    	return (Integer)insert("approve.insertExpenseApprove", map);
    }
    //지출결의서 기준정보 수정
    public Integer updateExpenseApprove(Map<String,Object> map) throws Exception{
    	return (Integer)insert("approve.updateExpenseApprove", map);
    }

    //경조사 기준정보 update
    public Integer updateEventInfo(Map<String,Object> map) throws Exception{
    	return (Integer)update("approve.updateEventInfo", map);
    }
    //경조사 기준정보 delete
    public Integer deleteEventInfo(Map<String,Object> map) throws Exception{
    	return (Integer)delete("approve.deleteEventInfo", map);
    }
    //품의서 BASE정보를 저장한다
    public Integer insertApproveDoc(Map<String,Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("approve.insertApproveDoc", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
    }
    //품의서 승인취소요청
  	public Integer processApproveCancelReq(Map<String,Object> paramMap) throws Exception{
  		return update("approve.processApproveCancelReq", paramMap);
  	}
  	//승인취소 완료시 스케줄/엔트리 업데이트
  	public Integer updateErpSchApproveCancel(Map<String,Object> paramMap) throws Exception{
  		return update("approve.updateErpSchApproveCancel", paramMap);
  	}
  	//품의서 취소승인권한
  	public Integer getCancelRoleCnt(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getCancelRoleCnt", paramMap);
  	}
  	//휴가,휴직 ,경조 저장시 프로젝트,엑티비티 정보를 조회한다.
    public EgovMap getActivityInfo(Map<String,Object> paramMap) throws Exception{
    	return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getActivityInfo", paramMap);
    }
    //품의서 문서번호 리스트
  	public List<EgovMap> approveDocNumList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.approveDocNumList", paramMap);
  	}
  	//품의서 문서번호삭제
  	public Integer deleteAppvDocNumRule(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approve.deleteAppvDocNumRule", paramMap);
  	}
	//품의서 문서번호저장
  	public Integer insertAppvDocNumRule(Map<String,Object> paramMap) throws Exception{
  		return (Integer)insert("approve.insertAppvDocNumRule", paramMap);
  	}
  	//참조자가 조회하면 READ_DATE를 업데이트한다
  	public Integer updateAppvCcReadDate(Map<String,Object> paramMap) throws Exception{
  		return update("approve.updateAppvCcReadDate", paramMap);
  	}
  	//수신자가 조회하면 READ_DATE를 업데이트한다
  	public Integer updateAppvRcReadDate(Map<String,Object> paramMap) throws Exception{
  		return update("approve.updateAppvRcReadDate", paramMap);
  	}
  	//품의서 수신 확인 전 다른 수신자가 먼저 수신확인했는지 체크한다.
  	public Integer getAppvRcChkCnt(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getAppvRcChkCnt", paramMap);
  	}
  	//수신확인
  	public Integer updateAppvRcReceipt(Map<String,Object> paramMap) throws Exception{
  		return update("approve.updateAppvRcReceipt", paramMap);
  	}
  	//결재라인명 리스트 조회
  	public List<EgovMap> getAppvHeaderList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getAppvHeaderList", paramMap);
  	}
  	//보고서 - 일정 선택 팝업
  	public List<EgovMap> getAppvScheduleList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getAppvScheduleList", paramMap);
  	}
  	//결재라인 순서삭제
  	public Integer deleteApproveHeaderIndividual(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approve.deleteApproveHeaderIndividual", paramMap);
  	}
  	//결재라인 해더삭제
  	public Integer deleteApproveLineIndividual(Map<String,Object> paramMap) throws Exception{
  		return (Integer)delete("approve.deleteApproveLineIndividual", paramMap);
  	}
  	//결재라인 직접지정 정보를 저장한다
    public Integer insertApproveHeaderIndividual(Map<String,Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("approve.insertApproveHeaderIndividual", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
    }
	//결재라인 등록
	public int insertApproveLineIndividual(ApproveVo vo) throws Exception{
		return update("approve.insertApproveLineIndividual", vo);
	}
	//결재순서 목록조회
  	public List<Map> selectApproveLineListIndividual(Map<String, Object> map) throws Exception{
  		return list("approve.selectApproveLineListIndividual", map);
  	}
  	//결재자가 경조사의 금액 변경
  	public int modifyAprvEventAmount(Map<String,Object> map) throws Exception{
  		return update("approve.modifyAprvEventAmount", map);
  	}
  	//상신하려는 문서의 문서번호 사용여부를 조회한다
  	public Integer appvDocNumUseChk(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.appvDocNumUseChk", paramMap);
  	}

  	///////////////////////////////////////////////////////////////////////////////////////

  	//전체문서 총개수
  	public Integer getAppvDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getAppvDocListTotalCnt", paramMap);
  	}
  	//전체문서 List
  	public List<EgovMap> getAppvDocList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getAppvDocList", paramMap);
  	}
  	//사내서식저장
  	public Integer insertApproveCompanyForm(Map<String, Object> paramMap) throws Exception {
  		Integer cnt = 0 ;
		cnt = (Integer)insert("approve.insertApproveCompanyForm", paramMap);
  		return cnt;
  	}
  	//사내서식수정
  	public Integer updateApproveCompanyForm(Map<String, Object> paramMap) throws Exception {

  		return update("approve.updateApproveCompanyForm", paramMap);
  	}
  	//사내서식 수정 전 결재라인이 있다면 문서타입을 업데이트한다
  	public Integer updateApproveLineForCompanyForm(Map<String, Object> paramMap) throws Exception {
  		return update("approve.updateApproveLineForCompanyForm", paramMap);
  	}

  	//사내서식삭제
  	public Integer deleteApproveCompanyForm(Map<String, Object> paramMap) throws Exception {

  		return update("approve.deleteApproveCompanyForm", paramMap);
  	}
	//사내서식 구분 유효성 체크
  	public Integer getAppvDocNumRuleMidNameCnt(Map<String, Object> map) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getAppvDocNumRuleMidNameCnt", map);
  	}
  	//사내서식 List
  	public List<EgovMap> getCompanyFormList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getCompanyFormList", paramMap);
  	}
  	//사내서식 총개수
  	public Integer getCompanyFormListTotalCnt(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getCompanyFormListTotalCnt", paramMap);
  	}
  	//사내서식 폼 상세
  	public EgovMap getCompanyFormInfo(Map<String,Object> paramMap) throws Exception{
  		return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getCompanyFormInfo", paramMap);
  	}
  	//연결 결재문서 List
  	public List<EgovMap> getApproveRefDocList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getApproveRefDocList", paramMap);
  	}
  	//연결 결재문서 List 총개수
  	public Integer getApproveRefDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getApproveRefDocListTotalCnt", paramMap);
  	}
  	//종결전 문서열람 정보를 조회
  	public EgovMap getAppvReadDocSetup(Map<String,Object> paramMap) throws Exception{
  		return (EgovMap)getSqlMapClientTemplate().queryForObject("approve.getAppvReadDocSetup", paramMap);
  	}

  	//연결 결재문서를 저장한다
  	public Integer insertLinkRefDocId(Map<String,Object> paramMap) throws Exception{
  		return  (Integer)insert("approve.insertLinkRefDocId", paramMap);
  	}
  	//연결 결재문서를 삭제한다
  	public Integer deleteLinkRefDoc(Map<String,Object> paramMap) throws Exception{
  		return  delete("approve.deleteLinkRefDoc", paramMap);
  	}

  	//연결 결재문서를 조회한다
  	public List<EgovMap> getApproveLinkDocList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getApproveLinkDocList", paramMap);
  	}
  	//필수참가자저장
  	public Integer insertApproveCcSetup(Map<String, Object> paramMap) throws Exception {
  		return (Integer)insert("approve.insertApproveCcSetup", paramMap);
  	}
	//필수수진자저장
  	public Integer insertApproveReceiverSetup(Map<String, Object> paramMap) throws Exception {
  		return (Integer)insert("approve.insertApproveReceiverSetup", paramMap);
  	}
  	//상신 이후 필수 참가자 , 수신자 조회
  	public List<EgovMap> getOrgReceiverSetupList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getOrgReceiverSetupList", paramMap);
  	}
  	//서식 즐겨찾기 저장
  	public Integer insertAppvFavList(Map<String, Object> paramMap) throws Exception {
  		return (Integer)insert("approve.insertAppvFavList", paramMap);
  	}
  	//서식 즐겨찾기삭제
  	public Integer deleteAppvFavList(Map<String, Object> paramMap) throws Exception {
  		return (Integer)insert("approve.deleteAppvFavList", paramMap);
  	}
  	//즐겨찾기 목록(등록/수정/상세페이지)
  	public List<EgovMap> getAppvFavListAjax(Map<String, Object> paramMap) throws Exception {
  		return list("approve.getAppvFavListAjax", paramMap);
  	}
  	//사내서식 user열람 정보를 저장
  	public Integer updateCompanyFormReadUserId(Map<String, Object> paramMap) throws Exception {
  		return update("approve.updateCompanyFormReadUserId", paramMap);
  	}
  	//즐겨찾기 서식 리스트
  	public List<EgovMap> getApproveBookmarkFormList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getApproveBookmarkFormList", paramMap);
  	}
  	//My업무구분에서 전자결재 SELECT박스 즐겨찾기 조회
  	public List<EgovMap> getApproveBookmarkFormListForMyWorkList(Map<String,Object> paramMap) throws Exception{
  		return list("approve.getApproveBookmarkFormListForMyWorkList", paramMap);
  	}
  	//서식 즐겨찾기 리스트 총개수
  	public Integer getApproveBookmarkFormListTotalCnt(Map<String, Object> paramMap) throws Exception {
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getApproveBookmarkFormListTotalCnt", paramMap);
  	}

  	//지출결의서 지급처리
  	public Integer processExpenseYn(Map<String, Object> paramMap) throws Exception {
  		return update("approve.processExpenseYn", paramMap);
  	}

  	//취소 커멘트 입력
  	public Integer modifyCancelComment(Map<String, Object> paramMap) throws Exception {
  		return update("approve.modifyCancelComment", paramMap);
  	}

  	//취소 합의자가 있는지 조회
  	public Integer getCancelChkCnt(Map<String, Object> paramMap) throws Exception {
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getCancelChkCnt", paramMap);
  	}

 	//결재품의서 내용수정
  	public Integer updateAppvMemoInfo(Map<String, Object> paramMap) throws Exception {
  		return update("approve.updateAppvMemoInfo", paramMap);
  	}
  	//결재품의서 내용 수정 코멘트 등력
  	public Integer insertUpdateAppvComment(Map<String, Object> paramMap) throws Exception {
  		return (Integer)insert("approve.insertUpdateAppvComment", paramMap);
  	}
  	//수신인 타입 수정
  	public Integer updateApproveRcType(Map<String, Object> paramMap) throws Exception {
  		return update("approve.updateApproveRcType", paramMap);
  	}
  	//참조인 타입 수정
  	public Integer updateApproveCcType(Map<String, Object> paramMap) throws Exception {
  		return update("approve.updateApproveCcType", paramMap);
  	}

 	//중복 문서타입 카운트
  	public Integer getAppvDocTypeNameCnt(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getAppvDocTypeNameCnt", paramMap);
  	}
  	//읽음처리
  	public Integer updateAppvDocReadId(Map<String, Object> paramMap) throws Exception {
  		return update("approve.updateAppvDocReadId", paramMap);
  	}
  	//다음 결재도 같은사람인지 체크
  	public Integer getChkDupAppvReqUserCnt(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getChkDupAppvReqUserCnt", paramMap);
  	}









	////////////////////////////////좌측메뉴 새글알림///////////////////////////////
	//사내서식 조회
	public Integer getMenuApproveCompanyCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getMenuApproveCompanyCnt", paramMap);
	}
	//임시저장 new 조회
	public Integer getMenuMenuApproveTemp(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getMenuMenuApproveTemp", paramMap);
	}
	//받은결재 new 조회
	public Integer getMenuApproveReqList(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getMenuApproveReqList", paramMap);
	}
	//참조문서 new 조회
	public Integer getMenuApproveReference(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getMenuApproveReference", paramMap);
	}
	//수신문서 new 조회
	public Integer getMenuApproveReceived(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getMenuApproveReceived", paramMap);
	}
	//지출문서 new 조회
	public Integer getMenuApproveExpense(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getMenuApproveExpense", paramMap);
	}




	///////////////////////////////////////////전자결재 배치 url : S///////////////////////////////////////////////////////
	//전자결재 미결알람 보내기
	public List<EgovMap> getSendAppvAlarmList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getSendAppvAlarmList", paramMap);
	}
	//전자결재 미결알람 보내기 개수
	public Integer getSendAppvAlarmListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("approve.getSendAppvAlarmListTotalCnt", paramMap);
	}

	///////////////////////////////////////////전자결재 배치 url : E///////////////////////////////////////////////////////

	//전자결재 미결알람 보내기(즉시 :결재)
	public List<EgovMap> getApproveImApproveAlarmList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getApproveImApproveAlarmList", paramMap);
	}

	//전자결재 미결알람 보내기(즉시 :수신,지출)
	public List<EgovMap> getApproveImCommitAlarmList(Map<String,Object> paramMap) throws Exception{
		return list("approve.getApproveImCommitAlarmList", paramMap);
	}
}