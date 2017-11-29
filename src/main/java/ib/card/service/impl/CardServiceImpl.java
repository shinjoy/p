package ib.card.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;








import ib.card.service.CardService;
import ib.card.service.CardVO;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.baroservice.ws.BaroService_CARDSoap;
import com.baroservice.ws.BaroService_CARDSoapProxy;
import com.baroservice.ws.CardLog;
import com.baroservice.ws.PagedCardLog;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("cardService")
public class CardServiceImpl extends AbstractServiceImpl implements CardService {

	@Resource(name="cardDAO")
	CardDAO cardDao;

	//지출 조회
	public List<Map> selectCardList(Map<String, Object> map) throws Exception {
		return cardDao.selectCardList(map);
	}
	//지출 등록
	public int regCardUse(Map<String, Object> map) throws Exception {
		int sNb =Integer.parseInt(map.get("sNb").toString());	  //지출 등록 후 시퀀스
		String chk ="";
		if(sNb==0){							//지출 등록
			chk="add";
			sNb=cardDao.insertCardUse(map);
		}else{								//수정
			updateCardUse(map);
		}
		/*지출에 포함된 직원 등록*/
		if(sNb>0){							//정상등록
			map.put("sNb", sNb);


			deleteCardUsedStaffList(map);	//삭제후
			String userListStr = (String)map.get("userListStr");
			if(!userListStr.equals("")){
				String [] userListArr = userListStr.split(",");
				for(int i=0;i<userListArr.length;i++){
						map.put("userId", userListArr[i]);
						insertCardUsedStaffListBysabun(map);  // 재등록

				}
			}

			deleteCardUsedCusStaffList(map);	//삭제후
			String cusUserListStr = (String)map.get("cusUserListStr");
			if(!cusUserListStr.equals("")){
				String [] cusUserListArr = cusUserListStr.split(",");
				for(int i=0;i<cusUserListArr.length;i++){

						map.put("cstSnb", cusUserListArr[i]);
						insertCardUsedCusStaff(map);  // 재등록

				}
			}
		}
		/*==================================feedback 입력 : S============================*/
		String memo="";
		/*if(chk.equals("add")){							//신규 등록일때만 feedback 입력
			map.put("cardSnb",map.get("sNb"));
			map.put("useDate",map.get("tmDt"));
			List<Map>userList =selectCardUserList(map);
			//등록된 참가자가 있고, 야근 혹은 점심 직원일때
			if(userList !=null && userList.size()>0 && (map.get("dv").equals("60") || map.get("dv").equals("55"))){
				if(map.get("dv").equals("60")){			//야근 등록일때
					for(int i=0;i<userList.size();i++){
		    			String leaveTime = (userList.get(i).get("leaveWorkTime")).toString();
		    			if(leaveTime.equals("")){											//퇴근기록이없거나
		    				memo +=userList.get(i).get("cstNm")+", ";
		    			}else if(Integer.parseInt(leaveTime.replaceAll(":",""))<210000){	//9시이전 퇴근
		    				memo +=userList.get(i).get("cstNm")+", ";
		    			}
					}
				}
				if(!memo.equals("")){														//야근일때만...
					memo +=" 퇴근시간 미준수(9시 이전)";
				}
				if(Integer.parseInt(map.get("price").toString())/userList.size()>10000){ 	//금액초과
	    			memo +=" 1인 식대초과(1인당 1만원 지원)";
	    		}
			}
			if(!memo.equals("")){
	    		CardVO cardVO= new CardVO();
	    		cardVO.setFeedback("S : "+memo);
	    		cardVO.setsNb(map.get("sNb").toString());
	    		cardDao.updateCardFeedback(cardVO);			//feedback 입력
    		}
		}*/
		/*==================================feedback 입력 : E============================*/

		/*==================================소모품 입력  : S================================*/
		delectCardMro(map);	//삭제 후
		if(!map.get("supplies").equals("")  && sNb>0){	//구매내역이 있고, 정상등록일때

			JSONObject suppliesObj = JSONObject.fromObject(map.get("supplies"));		//supplies 라는 파라미터로 넘어온 소모품 str 를 obj로
			JSONArray suppliesObjList = suppliesObj.getJSONArray("items");				//obj 에 키(items) 을 array로
			Map<String,Object>suppliedMap = new HashMap();
			suppliedMap.put("sNb", sNb);
			for(int i=0;i<suppliesObjList.size();i++){
				JSONObject supplies=(JSONObject)suppliesObjList.get(i);
				String code = supplies.getString("code");
				String name = supplies.getString("name");
				String count = supplies.getString("count");
				String price = supplies.getString("price");
				suppliedMap.put("mroCode", code);	//현재 사용하지 않음.
				suppliedMap.put("mroName", name);
				suppliedMap.put("qty", count);
				suppliedMap.put("price", price);
				try{
					sNb=insertCardMro(suppliedMap);	//등록
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		/*==================================소모품 입력  : E================================*/
		return sNb;
	}
	//지출 수정
	public void updateCardUse(Map<String, Object> map) throws Exception {
		cardDao.updateCardUse(map);
	}
	//피드백 수정
	public int updateCardFeedback(CardVO cardVO) throws Exception {
		return cardDao.updateCardFeedback(cardVO);
	}
	//지출 삭제
	public void deleteCardUse(Map<String, Object> map) throws Exception {
		cardDao.deleteCardUse(map);
	}
	//지출 참가자 조회
	public List<Map> selectCardUserList(Map<String, Object> map)throws Exception {
		return cardDao.selectCardUserList(map);
	}
	//지출 고객 조회
	public List<Map> selectCardCusUserList(Map<String, Object> map)throws Exception {
		return cardDao.selectCardCusUserList(map);
	}
	//지출 참가자 등록
	public int insertCardUsedStaffListBysabun(Map<String, Object> map)throws Exception {
		return cardDao.insertCardUsedStaffListBysabun(map);  //등록;
	}
	//지출 고객 등록
	public int insertCardUsedCusStaff(Map<String, Object> map)throws Exception {
		return cardDao.insertCardUsedCusStaff(map);  //등록;
	}
	//지출 참가자 삭제
	public void deleteCardUsedStaffList(Map<String, Object> map)throws Exception {
		 cardDao.deleteCardUsedStaffList(map);  //등록;
	}
	//지출 고객 삭제
	public void deleteCardUsedCusStaffList(Map<String, Object> map)throws Exception {
		 cardDao.deleteCardUsedCusStaffList(map);
	}
	//지출 소모품 조회
	public List<Map> selectCardMro(Map<String, Object> map) throws Exception {
		return cardDao.selectCardMro(map);
	}
	//지출 소모품 등록
	public int insertCardMro(Map<String, Object> map) throws Exception {
		return cardDao.insertCardMro(map);
	}
	//지출 소모품 삭제
	public void delectCardMro(Map<String, Object> map) throws Exception {
		cardDao.delectCardMro(map);
	}
	//최초 데이터 년도 조회
	public String selectMinYear(Map<String, Object> map) throws Exception {
		return cardDao.selectMinYear(map);
	}
	//통계 dv
	public List<Map> selectDvCardStatistics(Map<String, Object> map) throws Exception {
		return cardDao.selectDvCardStatistics(map);
	}
	//통계 dv2
	public List<Map> selectDv2CardStatistics(Map<String, Object> map) throws Exception {
		return cardDao.selectDv2CardStatistics(map);
	}
	//통계 월별
	public List<Map> selectMonthCardStatistics(Map<String, Object> map) throws Exception {
		return cardDao.selectMonthCardStatistics(map);
	}
	// 지출입력설정 리스트
	public EgovMap getCardExpenseSetupDetail(Map<String, Object> paramMap) throws Exception {
		return cardDao.getCardExpenseSetupDetail(paramMap);
	}
	// 지출담당자설정 리스트
	public List<EgovMap> getCardManagerSetupList(Map<String, Object> paramMap) throws Exception {
		return cardDao.getCardManagerSetupList(paramMap);
	}
	// 지출입력설정 저장
	public Integer processCardExpenseSetup(Map<String, Object> map) throws Exception {
		int cnt = 0;

    	// orgId : 지출입력설정 삭제
		cardDao.deleteCardExpenseSetup(map);

		// orgId : 지출담당자설정 삭제
		//cardDao.deleteCardManagerSetup(map);

		// 지출담당자
		String[] arrUserId = (String[])map.get("arrUserId");

		// orgId : 지출입력설정 등록
		for( String staffUserId : arrUserId ){
			map.put("orgId"        , map.get("orgId"));
			map.put("sessionUserId", map.get("sessionUserId"));
    		map.put("staffUserId"  , staffUserId);
    		map.put("createdBy"    , map.get("createdBy"));
    		map.put("createDate"   , map.get("createDate"));

    		cardDao.insertCardExpenseSetup(map);
    	}

    	return cnt;
	}
	// 법인카드 설정 조회
	public List<EgovMap> getCardCorpInfoSetupList(Map<String, Object> map) throws Exception {
		return cardDao.getCardCorpInfoSetupList(map);
	}
	// 법인카드 설정 저장/수정
	public Integer processCardCorpor(Map<String, Object> map) throws Exception {
		Integer cnt = 0;

		String cardCorpInfoId = map.get("cardCorpInfoId").toString();

		EgovMap regCheck = null;
		List<EgovMap> cardRegCheck = cardDao.getCardCheck(map);
		String cardNumCnt  = "";
		//String cardUserCnt = "";

		// 신규 카드번호/소유자 체크
		if( cardCorpInfoId.equals("0") ){
			for( int i=0; i<cardRegCheck.size(); i++ ){
				regCheck = cardRegCheck.get(0);

				cardNumCnt  = regCheck.get("cardNumCnt").toString();
				//cardUserCnt = regCheck.get("cardUserCnt").toString();

				if(Integer.parseInt(cardNumCnt)>0){
					cnt=9999;
					return cnt;
				}/*else if(Integer.parseInt(cardUserCnt)>0){
					cnt=-1;
					return cnt;
				}*/
			}
			map.put("cardLinkYn", "N");
			cardDao.insertCardCorpInfo(map);
		// 수정 카드번호/소유자 체크
		}else{
			for( int i=0; i<cardRegCheck.size(); i++ ){
				regCheck = cardRegCheck.get(0);

				cardNumCnt  = regCheck.get("cardNumCnt").toString();
				//cardUserCnt = regCheck.get("cardUserCnt").toString();

				if(Integer.parseInt(cardNumCnt)>0){
					cnt=9999;
					return cnt;
				}/*else if(Integer.parseInt(cardUserCnt)>0){
					cnt=-1;
					return cnt;
				}*/
			}
			cnt = cardDao.updateCardCorpInfo(map);
		}

		//연동된 카드 사용내역  등록자 변경
		cnt = cardDao.updateCardUsedToRgId(map);

		return cnt;
	}
	// 법인카드 설정 삭제
	public Integer deleteCardCorpInfo(Map<String, Object> map) throws Exception {
		return cardDao.deleteCardCorpInfo(map);
	}
	// 법인카드 연동 저장
	public Integer processCardLinkage(Map<String, Object> map) throws Exception {
		Integer cnt = 0;

		cnt = cardDao.insertCardLinkage(map);

		return cnt;
	}
	// 법인카드 연동 확인
	public Integer processCardLk(Map<String,Object> map) throws Exception{
		Integer cnt = 0;

		String cardCorpSetupId = (String)map.get("cardCorpSetupId");
		String orgCardLinkYn   = (String)map.get("orgCardLinkYn");

		Integer chkCnt = cardDao.getProcessCardLk(map);

		if( chkCnt == 0 ){
			cardDao.insertCardLinkage(map);
		}else{
			cardDao.updateCardLinkAge(map);
		}

		return cnt;
	}
	// 법인연동 수정(해지)
	public Integer updateCardLkCancel(Map<String, Object> map) throws Exception {
		Integer cnt = 0;
		cardDao.updateCardLkCancel(map);

		return cnt;
	}
	// [임시]법인카드 사용내역 연동 기능 여부 화면
	public EgovMap getCardCorpSetup(Map<String, Object> paramMap) throws Exception {
		return cardDao.getCardCorpSetup(paramMap);
	}
	//승인처리 수정
	public Integer updateApproval(Map<String, Object> map) throws Exception {
		int cnt = 0;

		cardDao.updateApproval(map);

		return cnt;
	}
	//
	public EgovMap baseInfo(Map<String, Object> map) throws Exception {

		return cardDao.baseInfo(map);
	}
	public EgovMap getCardSetupNote(Map<String, Object> map) throws Exception {
		return cardDao.getCardSetupNote(map);
	}
	// 카드선택
	public List<EgovMap> getCardSelectList(Map<String, Object> map) throws Exception {
		return cardDao.getCardSelectList(map);
	}

	/**
	 * 법인카드설정 저장
	 * @MethodName : insertCardCorpInfoForLink
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer insertCardCorpInfoForLink(Map<String, Object> paramMap) throws Exception{
  		Integer cardCnt = cardDao.existCardCorp(paramMap);
  		Integer returnValue =0;
  		//등록된 카드가 없으면 등록함
  		if(cardCnt == 0) 	 returnValue = cardDao.insertCardCorpInfo(paramMap);
  		return returnValue;
  	}
 // 바로빌 연동 카드정보 가져오기
  	public int  getBarobillCardUsedList(Map<String, Object> map) throws Exception {
  		// 바로빌 연동 카드정보 가져오기
  		List<EgovMap> barobillCardCorpList = cardDao.getBarobillCardCorpList(map);

  		int CountPerPage = 100;			//페이지수
 		int CurrentPage = 1;			//현재페이지
 		BaroService_CARDSoap BS_CARD = new BaroService_CARDSoapProxy();
  		for(EgovMap barobillCard : barobillCardCorpList){
  			String CERTKEY = barobillCard.get("linkAuthCode").toString(); //운영 인증키
 			String CorpNum =barobillCard.get("corpNum").toString();			//연계사업자 사업자번호 ('-' 제외, 10자리)
 			String ID = barobillCard.get("linkAuthId").toString();					//연계사업자 아이디  synerib
 			String CardNum = barobillCard.get("cardNum").toString();		//카드번호  5585269202584838
 			String BaseDate = map.get("baseDate").toString();		//기준날짜

 			PagedCardLog cardLog = BS_CARD.getCardLog(CERTKEY, CorpNum, ID, CardNum, BaseDate, CountPerPage, CurrentPage);

 			if (cardLog.getCurrentPage() < 0) { //실패
 				System.out.println("[FAIL]"+cardLog.getCurrentPage());
 			} else { //성공
 				System.out.println("[SUCCESS]"+cardLog);
 			}

 			CardLog[] cardLogList = cardLog.getCardLogList();
 			System.out.println("## LogList : " + cardLogList.length);

 			for(CardLog log : cardLogList){
 				// 테이블에 카드 사용내역 Insert 구문 넣기
 				Calendar dt = Calendar.getInstance();

 		        SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMddHHmmss");
 		        Date to = transFormat.parse(log.getUseDT());
 				dt.setTime(to);

 				/*System.out.println("## ************************* ##");
 				System.out.println("## 카드번호 : " + log.getCardNum());

 				System.out.println("## 사용시간 : " + log.getUseDT());

 				System.out.println("## 년 : " + dt.get(Calendar.YEAR));
 				System.out.println("## 월 : " + (dt.get(Calendar.MONTH) + 1));
 				System.out.println("## 일 : " + dt.get(Calendar.DATE));
 				System.out.println("## 시각 : " + dt.getTime());

 				System.out.println("## 공급가액 : " + log.getAmount());
 				System.out.println("## 부가세 : " + log.getTax());
 				System.out.println("## 봉사료 : " + log.getServiceCharge());
 				System.out.println("## 합계금액: " + log.getTotalAmount());
 				System.out.println("## 카드승인금액 : " + log.getCardApprovalCost());

 				System.out.println("## 가맹점 : " + log.getUseStoreName());
 				System.out.println("## 가맹점번호 : " + log.getUseStoreNum());
 				System.out.println("## 카드승인번호 : " + log.getCardApprovalNum());
 				System.out.println("## 카드승인형태 : " + log.getCardApprovalType());*/

 				Map<String,Object> insertMap = new HashMap<String,Object>();
 				insertMap.put("orgId", barobillCard.get("orgId").toString());
 				insertMap.put("cardCorpUseYn", "Y");
 				insertMap.put("cardCorpInfoId", barobillCard.get("cardCorpInfoId").toString());

 				insertMap.put("price", log.getCardApprovalCost());
 				insertMap.put("tmDt", log.getUseDT());
 				insertMap.put("year", dt.get(Calendar.YEAR));
 				insertMap.put("month", dt.get(Calendar.MONTH) + 1);

 				insertMap.put("cardCorpLinkKey", log.getCardNum() + "_" + log.getCardApprovalNum());
 				insertMap.put("place", log.getUseStoreName());

 				String cardOwnerUserId ="-1";
 				if(barobillCard.get("cardOwnerUserId") != null){
 					cardOwnerUserId = barobillCard.get("cardOwnerUserId").toString();
 				}else{
 					cardOwnerUserId ="-1";
 				}
 				insertMap.put("rgId", cardOwnerUserId);

 				Integer cardCnt = cardDao.existCardCorpUsed(insertMap);
 		  		Integer sNb =0;
 		  		//등록된 카드가 없으면 등록함
 		  		if(cardCnt == 0) 	 sNb = cardDao.insertCardUseForBarobill(insertMap);   //카드사용내역 등록
 			}
  		}
  		return 1;
  	}
  	/**
	 * 메인 법인카드 사용 미등록 팝업
	 * @MethodName : getCardCorpUsedListForMainPop
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public List<EgovMap> getCardCorpUsedListForMainPopList(Map<String, Object> paramMap) throws Exception{
  		return cardDao.getCardCorpUsedListForMainPopList(paramMap);
  	}

  	/**
	 * 등록 사원 체크
	 * @MethodName : getCardCorpUsedListForMainPop
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public Integer getSelectUserCnt(Map<String, Object> paramMap) throws Exception{
  		String cardSnb = paramMap.get("cardSnb").toString();

  		Integer cnt = 0;

  		if(!cardSnb.equals("0")){
  			List<Map> selectCardUserList = cardDao.selectCardUserList(paramMap);

  			if(selectCardUserList!=null){
  				cnt = selectCardUserList.size();
  			}
  		}
  		return cnt;
  	}

  	 /**
	 * 승인/미승인 카운터
	 * @MethodName : getApproveYnCntMapList
	 * @param
	 * @return
	 * @throws Exception
	 */
  	public List<EgovMap> getApproveYnCntMapList(Map<String, Object> paramMap) throws Exception{
  		return cardDao.getApproveYnCntMapList(paramMap);
  	}
}
