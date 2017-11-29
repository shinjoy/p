package com.baroservice.ws;


import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.baroservice.ws.BaroService_CARDSoap;
import com.baroservice.ws.BaroService_CARDSoapProxy;
import com.baroservice.ws.Card;

public class AaaTestCard {

	public static void main(String[] args) {
		System.out.println("AAAAA");
		// TODO Auto-generated method stub
		AaaTestCard testCard = new AaaTestCard();
		testCard.getCardTest();
		testCard.getCardLogTest();
	}

	public void getCardTest(){
		try {

			// 법인카드 정보 조회 - 개발
			/*
			String CERTKEY = "31A762E6-717A-49E1-BA8E-095E52AB6F0C";			//개발 인증키
			String CERTKEY = "A34D1994-FB10-43FF-A4DD-08DA06829220"; //운영 인증키
			String CorpNum = "2648132143";			//연계사업자 사업자번호 ('-' 제외, 10자리)
			String ID = "synergyib";					//연계사업자 아이디
			String CardNum = "5585269202584838";			//카드번호
			*/

			// 법인카드 정보 조회 - 운영(DB로 뺌. 기록차 남겨둠)
			String CERTKEY = "A34D1994-FB10-43FF-A4DD-08DA06829220"; //운영 인증키
			String CorpNum = "1178162851";			//연계사업자 사업자번호 ('-' 제외, 10자리) 2648132143
			//String ID = "synerib";					//연계사업자 아이디
			//String CardNum = "5585269202584838";			//카드번호

			//String CERTKEY = "A34D1994-FB10-43FF-A4DD-08DA06829220";			//인증키
			//String CorpNum = "6178185145";			//연계사업자 사업자번호 ('-' 제외, 10자리)

			//inhee test
			//String CERTKEY = "31A762E6-717A-49E1-BA8E-095E52AB6F0C";			//인증키
			//String CorpNum = "2648132143";			//연계사업자 사업자번호 ('-' 제외, 10자리)


			BaroService_CARDSoap BS_CARD = new BaroService_CARDSoapProxy();

			Card[] result = BS_CARD.getCard(CERTKEY, CorpNum);

			String cardNum = "";
			String cardCompanyName = "";

			try {
				for(int i=0;i<result.length;i++){
					cardNum = result[i].getCardNum();
					cardCompanyName = result[i].getCardCompanyName();
					System.out.println("[cardNum]"+cardNum +"   [cardCompanyName]"+cardCompanyName);

					if (Long.parseLong(result[i].getCardNum()) < 0) { //실패
						System.out.println("[FAIL]"+cardNum);
					} else { //성공
						System.out.println("[SUCCESS]"+result);
					}
				}
			} catch (NumberFormatException e) {
				System.out.println("[NumberFormatException]"+e.getMessage());
			}
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("[RemoteException]"+e.getMessage());
		}
	}

	public void getCardLogTest(){
		try {

			// 법인카드 정보 조회 - 개발
			/*
			String CERTKEY = "31A762E6-717A-49E1-BA8E-095E52AB6F0C";			//개발 인증키
			String CERTKEY = "A34D1994-FB10-43FF-A4DD-08DA06829220"; //운영 인증키
			String CorpNum = "2648132143";			//연계사업자 사업자번호 ('-' 제외, 10자리)
			String ID = "synergyib";					//연계사업자 아이디
			String CardNum = "5585269202584838";			//카드번호
			*/

			// 법인카드 정보 조회 - 운영(DB로 뺌. 기록차 남겨둠)
			String CERTKEY = "A34D1994-FB10-43FF-A4DD-08DA06829220"; //운영 인증키
			String CorpNum = "1178162851";			//연계사업자 사업자번호 ('-' 제외, 10자리)
			String ID = "admin5981";					//연계사업자 아이디  synerib
			String CardNum = "4079160144011210";			//카드번호  5585269202584838

			//String CERTKEY = "A34D1994-FB10-43FF-A4DD-08DA06829220";			//인증키
			//String CorpNum = "6178185145";			//연계사업자 사업자번호 ('-' 제외, 10자리)

			//개발테스트
			//String CERTKEY = "31A762E6-717A-49E1-BA8E-095E52AB6F0C";			//인증키
			//String CorpNum = "2648132143";			//연계사업자 사업자번호 ('-' 제외, 10자리)
			//String ID = "synergyib";					//연계사업자 아이디
			//String CardNum = "5585269225027625";			//카드번호
			String BaseDate = "20170801";			//기준날짜
			int CountPerPage = 100;			//페이지당 갯수
			int CurrentPage = 1;			//현재페이지

			BaroService_CARDSoap BS_CARD = new BaroService_CARDSoapProxy();

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


				System.out.println("## ************************* ##");
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
				System.out.println("## 카드승인형태 : " + log.getCardApprovalType());



			}


		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("[RemoteException]"+e.getMessage());
		} catch(Exception ex){
			System.out.println("[Exception]"+ex.getMessage());
		}finally{

		}
	}
}
