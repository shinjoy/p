/**
 *
 */
package ib.card.service.impl;

import ib.card.service.CardVO;
import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;




import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package  : ib.card.service.impl
 * filename : CardDAO.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 11. 14.
 * @version : 1.0.0
 */

@Repository("cardDAO")
public class CardDAO extends ComAbstractDAO{


	/**
	 *
	 * @MethodName : updateCardFeedback
	 * @param cardVO
	 * @return
	 */
	public int updateCardFeedback(CardVO VO) throws Exception {
		return (Integer)update("card.updateCardFeedback", VO);
	}

	/**
	 * 최초 입력 년도
	 * @MethodName : selectMinYear
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String selectMinYear(Map<String,Object>map) throws Exception {
		return (String) selectByPk("card.selectMinYear", map);
	}

	/**
	 * 지출 리스트
	 * @MethodName : selectCardList
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectCardList(Map<String,Object>map) throws Exception {
		return list("card.selectCardList", map);
	}

	/**
	 * 소모품 리스트
	 * @MethodName : selectCardMro
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectCardMro(Map<String,Object>map) throws Exception {
		return list("card.selectCardMro", map);
	}

	/**
	 * 지출 참가자 리스트
	 * @MethodName : selectCardUserList
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectCardUserList(Map<String,Object>map) throws Exception {
		return list("card.selectCardUserList", map);
	}
	/**
	 * 지출 고객 리스트
	 * @MethodName : selectCardUserList
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectCardCusUserList(Map<String,Object>map) throws Exception {
		return list("card.selectCardCusUserList", map);
	}

	/**
	 * 지출 등록
	 * @MethodName : insertCardUse
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertCardUse(Map<String,Object> map) throws Exception {
		return (Integer)insert("card.insertCardUse", map);
	}

	/**
	 * 지출 수정
	 * @MethodName : updateCardUse
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateCardUse(Map<String,Object>map) throws Exception {
		update("card.updateCardUse", map);
	}

	/**
	 * 지출 삭제
	 * @MethodName : deleteCardUse
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteCardUse(Map<String,Object>map) throws Exception {
		delete("card.deleteCardUsed",map);
	}

	/**
	 * 지출 참가자 등록
	 * @MethodName : insertCardUsedStaffListBysabun
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertCardUsedStaffListBysabun(Map<String,Object>map) throws Exception {
		return (Integer)insert("card.insertCardUsedStaffListBysabun", map);
	}
	/**
	 * 지출 고객 등록
	 * @MethodName : insertCardUsedCusStaff
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertCardUsedCusStaff(Map<String,Object>map) throws Exception {
		return (Integer)insert("card.insertCardUsedCusStaff", map);
	}

	/**
	 * 참가자 삭제
	 * @MethodName : deleteCardUsedStaffList
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteCardUsedStaffList(Map<String,Object>map) throws Exception {
		delete("card.deleteCardUsedStaffList", map);
	}

	/**
	 * 고객 삭제
	 * @MethodName : deleteCardUsedStaffList
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteCardUsedCusStaffList(Map<String,Object>map) throws Exception {
		delete("card.deleteCardUsedCusStaffList", map);
	}

	/**
	 * 소모품 등록
	 * @MethodName : insertCardMro
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertCardMro(Map<String,Object>map) throws Exception {
		return (Integer)insert("card.insertCardMro", map);
	}

	/**
	 * 소모품 삭제
	 * @MethodName : delectCardMro
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void delectCardMro(Map<String,Object>map) throws Exception {
		delete("card.delectCardMro", map);
	}

	/**
	 * 통계 dv
	 * @MethodName : selectDvCardStatistics
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectDvCardStatistics(Map<String,Object>map) throws Exception {
		return list("card.selectDvCardStatistics", map);
	}

	/**
	 * 통계 dv2
	 * @MethodName : selectDv2CardStatistics
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectDv2CardStatistics(Map<String,Object>map) throws Exception {
		return list("card.selectDv2CardStatistics", map);
	}

	/**
	 * 통계 월별
	 * @MethodName : selectMonthCardStatistics
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectMonthCardStatistics(Map<String,Object>map) throws Exception {
		return list("card.selectMonthCardStatistics", map);
	}

	/**
	 * 지출입력설정 리스트
	 * @MethodName : getCardExpenseSetupDetail
	 * @param
	 * @return
	 * @throws Exception
	 */
	public EgovMap getCardExpenseSetupDetail(Map<String, Object>paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("card.getCardExpenseSetupDetail", paramMap);
	}

	/**
	 * 지출담당자설정 리스트
	 * @MethodName : getCardManagerSetupList
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> getCardManagerSetupList(Map<String, Object>paramMap) throws Exception {
		return list("card.getCardManagerSetupList", paramMap);
	}

	/**
	 * 지출입력설정 삭제
	 * @MethodName : deleteCardExpenseSetup
	 * @param
	 * @return
	 * @throws Exception
	 */
	public Integer deleteCardExpenseSetup(Map<String, Object>paramMap) throws Exception {
		return (Integer)delete("card.deleteCardExpenseSetup", paramMap);
	}

	/**
	 * 지출담당자설정 삭제
	 * @MethodName : deleteCardManagerSetup
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer deleteCardManagerSetup(Map<String, Object> paramMap) throws Exception{
  		return (Integer)delete("card.deleteCardManagerSetup", paramMap);
  	}

  	/**
	 * 지출입력설정 저장
	 * @MethodName : insertCardExpenseSetup
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer insertCardExpenseSetup(Map<String, Object> paramMap) throws Exception{
  		return (Integer)insert("card.insertCardExpenseSetup", paramMap);
  	}

  	/**
	 * 지출담당자설정 저장
	 * @MethodName : insertCardExpenseSetup
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer insertCardManagerSetup(Map<String, Object> paramMap) throws Exception{
  		return (Integer)insert("card.insertCardManagerSetup", paramMap);
  	}

  	/**
	 * 법인카드설정 리스트
	 * @MethodName : getCardCorpInfoSetupList
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> getCardCorpInfoSetupList(Map<String, Object>paramMap) throws Exception {
		return list("card.getCardCorpInfoSetupList", paramMap);
	}

	/**
	 * 법인카드설정 저장
	 * @MethodName : insertCardCorpInfo
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer insertCardCorpInfo(Map<String, Object> paramMap) throws Exception{
  		return (Integer)insert("card.insertCardCorpInfo", paramMap);
  	}

  	/**
	 * 법인카드 Number/User 중복체크
	 * @MethodName
	 * @param
	 * @return
	 * @throws
	 */
  	@SuppressWarnings("unchecked")
	public List<EgovMap> getCardCheck(Map<String,Object>map) throws Exception {
		return list("card.getCardCheck", map);
	}

  	/**
	 * 법인카드설정 저장 수정
	 * @MethodName : updateCardCorpInfo
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer updateCardCorpInfo(Map<String, Object> paramMap) throws Exception {
  		return (Integer)update("card.updateCardCorpInfo", paramMap);
  	}

  	/**
	 * 법인카드설정 삭제
	 * @MethodName : deleteCardCorpInfo
	 * @param      :
	 * @return     :
	 * @throws     : Exception
	 */
  	public Integer deleteCardCorpInfo(Map<String, Object> paramMap) throws Exception {
  		return (Integer)update("card.deleteCardCorpInfo", paramMap);
  	}

  	/**
	 * 법인카드연동 저장
	 * @MethodName : insertCardLinkage
	 * @param      :
	 * @return     :
	 * @throws Exception
	 */
  	public Integer insertCardLinkage(Map<String, Object> paramMap) throws Exception {
  		return (Integer)insert("card.insertCardLinkage", paramMap);
  	}

  	/**
  	 * 법인카드연동 확인
  	 * @MethodName : deleteCardCorpInfo
  	 * @param      :
  	 * @return	   :
  	 * @throws     : Exception
  	 */
  	public Integer getProcessCardLk(Map<String,Object> paramMap) throws Exception{
  		return (Integer)getSqlMapClientTemplate().queryForObject("card.getProcessCardLk", paramMap);
  	}

  	/**
	 * 법인카드연동  수정
	 * @MethodName : updateCardLinkAge
	 * @param      :
	 * @return     :
	 * @throws     : Exception
	 */
  	public Integer updateCardLinkAge(Map<String, Object> paramMap) throws Exception {
  		return (Integer)update("card.updateCardLinkAge", paramMap);
  	}

  	/**
	 * [임시]법인카드 사용내역 연동 기능 여부 화면
	 * @MethodName : getCardCorpSetup
	 * @param      :
	 * @return     :
	 * @throws     :
	 */
	public EgovMap getCardCorpSetup(Map<String, Object>paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("card.getCardCorpSetup", paramMap);
	}

	/**
	 * 법인카드연동  수정(해지)
	 * @MethodName : updateCardLkCancel
	 * @param      :
	 * @return     :
	 * @throws     : Exception
	 */
  	public Integer updateCardLkCancel(Map<String, Object> paramMap) throws Exception {
  		return (Integer)update("card.updateCardLkCancel", paramMap);
  	}

  	/**
	 * 승인처리 수정
	 * @MethodName : updateApproval
	 * @param      :
	 * @return     :
	 * @throws Exception
	 */
	public Integer updateApproval(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("card.updateApproval", paramMap);
	}

	/**
	 *
	 * @MethodName : baseInfo
	 * @param      :
	 * @return     :
	 * @throws     :
	 */
	@SuppressWarnings("unchecked")
	public EgovMap baseInfo(Map<String, Object>paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("card.baseInfo", paramMap);
	}

	/**
	 * 최초 유의사항
	 * @MethodName : getCardSetupNote
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public EgovMap getCardSetupNote(Map<String,Object>map) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("card.getCardSetupNote", map);
	}

  	/**
	 * 카드선택
	 * @MethodName
	 * @param
	 * @return
	 * @throws
	 */
  	@SuppressWarnings("unchecked")
	public List<EgovMap> getCardSelectList(Map<String,Object>map) throws Exception {
		return list("card.getCardSelectList", map);
	}

  	/**
	 * 카드등록여부(이인희)
	 * @MethodName : getCardSetupNote
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Integer existCardCorp(Map<String,Object>map) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("card.existCardCorp", map);
	}
	/**
	 * 메인 법인카드 사용 미등록 팝업
	 * @MethodName : getCardCorpUsedListForMainPop
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public List<EgovMap> getCardCorpUsedListForMainPopList(Map<String, Object> paramMap) throws Exception{
  		return list("card.getCardCorpUsedListForMainPopList", paramMap);
  	}

	/**
	 * 바로빌 연동 카드정보 가져오기
	 * @MethodName
	 * @param
	 * @return
	 * @throws
	 */
  	@SuppressWarnings("unchecked")
	public List<EgovMap> getBarobillCardCorpList(Map<String,Object>map) throws Exception {
		return list("card.getBarobillCardCorpList", map);
	}

  	/**
	 * 지출 등록 (바로빌 법인카드 연동)
	 * @MethodName : insertCardUse
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int insertCardUseForBarobill(Map<String,Object> map) throws Exception {
		return (Integer)insert("card.insertCardUseForBarobill", map);
	}

	/**
	 * 카드사용내역등록여부(이인희)
	 * @MethodName : getCardSetupNote
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Integer existCardCorpUsed(Map<String,Object>map) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("card.existCardCorpUsed", map);
	}

	/**
	 * 연동된 카드 사용내역 등록자 변경
	 * @MethodName : updateApproval
	 * @param      :
	 * @return     :
	 * @throws Exception
	 */
	public Integer updateCardUsedToRgId(Map<String, Object> paramMap) throws Exception {
		return (Integer)update("card.updateCardUsedToRgId", paramMap);
	}

	/**
	 * 승인/미승인 카운터
	 * @MethodName : getApproveYnCntMapList
	 * @param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> getApproveYnCntMapList(Map<String, Object>paramMap) throws Exception {
		return list("card.getApproveYnCntMapList", paramMap);
	}

}