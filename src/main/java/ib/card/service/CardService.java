package ib.card.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface CardService {


	/**
	 * 지출 조회
	 * @param
	 * @return List
	 */
	public List<Map> selectCardList(Map<String, Object> map)throws Exception;
	/**
	 * 지출 내역 등록
	 * @param
	 * @return int
	 */
	public int regCardUse(Map<String, Object> map)throws Exception;
	/**
	 * 지출 내역 수정
	 * @param
	 * @return int
	 */
	public void updateCardUse(Map<String, Object> map) throws Exception;
	/**
	 * 피드백 수정
	 * @param
	 * @return int
	 */
	public int updateCardFeedback(CardVO cardVO) throws Exception;
	/**
	 * 지출 내역 삭제
	 * @param
	 * @return int
	 */
	public void deleteCardUse(Map<String, Object> map) throws Exception;
	/**
	 * 지출 참가자 조회
	 * @param
	 * @return List
	 */
	public List<Map> selectCardUserList(Map<String, Object> map)throws Exception;
	/**
	 * 지출 사원 조회
	 * @param
	 * @return List
	 */
	public List<Map> selectCardCusUserList(Map<String, Object> map)throws Exception;
	/**
	 * 지출 참가자 등록
	 * @param
	 * @return int
	 */
	public int insertCardUsedStaffListBysabun(Map<String, Object> map) throws Exception;
	/**
	 * 지출 참가자 삭제
	 * @param
	 * @return
	 */
	public void deleteCardUsedStaffList(Map<String, Object> map) throws Exception;
	/**
	 * 소모품 내역 조회
	 * @param
	 * @return List
	 */
	public List<Map> selectCardMro(Map<String, Object> map)throws Exception;
	/**
	 * 소모품 등록
	 * @param
	 * @return int
	 */
	public int insertCardMro(Map<String, Object> map) throws Exception;
	/**
	 * 소모품 삭제
	 * @param
	 * @return
	 */
	public void delectCardMro(Map<String, Object> map) throws Exception;
	/**
	 * 최초 데이터 년도 조회
	 * @param
	 * @return String
	 */
	public String selectMinYear(Map<String, Object> map)throws Exception;
	/**
	 * 통계 dv
	 * @param
	 * @return
	 */
	public List<Map> selectDvCardStatistics(Map<String, Object> map)throws Exception;
	/**
	 * 통계 dv2
	 * @param
	 * @return
	 */
	public List<Map> selectDv2CardStatistics(Map<String, Object> map)throws Exception;
	/**
	 * 월별 통계
	 * @param
	 * @return
	 */
	public List<Map> selectMonthCardStatistics(Map<String, Object> map)throws Exception;
	/**
	 * 지출입력설정 리스트
	 * @param
	 * @return
	 */
	public EgovMap getCardExpenseSetupDetail(Map<String, Object> paramMap)throws Exception;
	/**
	 * 지출담당자설정 리스트
	 * @param
	 * @return
	 */
	public List<EgovMap> getCardManagerSetupList(Map<String, Object> paramMap)throws Exception;

	/**
	 * 지출입력설정 저장
	 * @param
	 * @return
	 */
    public Integer processCardExpenseSetup(Map<String, Object> map) throws Exception;

	/**
	 * 법인카드 설정 조회
	 * @param
	 * @return
	 */
    public List<EgovMap> getCardCorpInfoSetupList(Map<String, Object> map) throws Exception;

    /**
	 * 법인카드 설정 저장/수정
	 * @param
	 * @return
	 */
    public Integer processCardCorpor(Map<String, Object> map) throws Exception;

    /**
	 * 법인카드 설정 삭제
	 * @param
	 * @return
	 */
    public Integer deleteCardCorpInfo(Map<String, Object> map) throws Exception;

    /**
	 * 법인카드연동 확인
	 * @param
	 * @return
	 */
    public Integer processCardLk(Map<String,Object> map) throws Exception;

    /**
	 * 법인카드 연동 저장
	 * @param
	 * @return
	 */
    public Integer processCardLinkage(Map<String, Object> map) throws Exception;

    /**
	 * [임시]법인카드 사용내역 연동 기능 여부 화면
	 * @param
	 * @return
	 */
	public EgovMap getCardCorpSetup(Map<String, Object> paramMap)throws Exception;

	/**
	 * 법인카드연동 수정(해지)
	 * @param
	 * @return
	 */
    public Integer updateCardLkCancel(Map<String, Object> map) throws Exception;

    /**
	 * 승인처리 수정
	 * @param
	 * @return
	 */
	public Integer updateApproval(Map<String, Object> map) throws Exception;

	/**
	 *
	 * @param
	 * @return
	 */
	public EgovMap baseInfo(Map<String, Object> map)throws Exception;
	/**
	 * 최초 데이터 유의사항 조회
	 * @param
	 * @return String
	 */
	public EgovMap getCardSetupNote(Map<String, Object> map)throws Exception;

	/**
	 * 카드선택
	 * @param
	 * @return
	 */
    public List<EgovMap> getCardSelectList(Map<String, Object> map) throws Exception;

    /**
	 * 법인카드설정 저장
	 * @MethodName : insertCardCorpInfoForLink
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer insertCardCorpInfoForLink(Map<String, Object> paramMap) throws Exception;

  	/**
	 * 바로빌 연동 카드정보 가져오기
	 * @param
	 * @return
	 */
    public int getBarobillCardUsedList(Map<String, Object> map) throws Exception;

  	 /**
	 * 메인 법인카드 사용 미등록 팝업
	 * @MethodName : getCardCorpUsedListForMainPop
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public List<EgovMap> getCardCorpUsedListForMainPopList(Map<String, Object> paramMap) throws Exception;
  	/**
	 * 등록 사원 체크
	 * @MethodName : getCardCorpUsedListForMainPop
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer getSelectUserCnt(Map<String, Object> paramMap) throws Exception;
  	 /**
	 * 승인/미승인 카운터
	 * @MethodName : getApproveYnCntMapList
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public List<EgovMap> getApproveYnCntMapList(Map<String, Object> paramMap) throws Exception;
}
