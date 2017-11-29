package ib.schedule.service;

import java.io.Serializable;

import ib.basic.service.BaseVo;

public class CusVO extends BaseVo implements Serializable {
	/////////////////////////////////////////////////////////////////////////
	private String cmd						= "";
	private String url						= "";
	private String sNb						= "";	// IB 연결코드
	private String ceo						= "";	// 대표이사

	/**	투자개요 세부내역	**/
	private String isicCd					= "";	// 연관순번

	/**	문자	**/
	private int smsSeq						= 0;	// 순번
	private String smsTitle					= "";	// 전송제목
	private String smsType					= "";	// 전송구분 (3.단문문자/5.장문문자/6.이미지포함문자)
	private String smsToNum					= "";	// 수신자번호 (하이픈제거/동보전송시 , 로 구분)
	private String smsFromNum				= "";	// 발신자번호 (하이픈제거)
	private String smsContent				= "";	// 내용
	private String smsReserTime				= "";	// 발신시간(예약시간)	(년(4)월(2)일(2)시(2)분(2)초(2) 로 설정)
	private String smsSendTime				= "";	// 전송시작시간
	private String smsEndTime				= "";	// 전송완료시간
	private String smsSendFlag				= "";	// 전송결과 (1.성공/7.잘못된번호/16.수신거부/19.기타)
	private String smsFlag					= "";	// 문자연동구분자 (메일, 보고서, 일반)

	private String highSearchQuery			= "";	// 고급검색
	private String highSearchData			= "";	// 고급검색데이터
	private String highSearchSDate			= "";
	private String highSearchEDate			= "";
	private String searchCondition			= "";	// 검색조건
	private String searchKeyword			= "";	// 검색어
	private String orderFlag				= "";	// 정렬조건(S 문자 I 숫자)
	private String orderType				= "";	// 정렬타입
	private String orderKey					= "";	// 정렬기준
	private String newWinFlag				= "";	// 새창여부
	private String eventFlag				= "";	// 발생 이벤트 구분자
	private String infoMessage				= "";	// 경고문구
	private String objNm					= "";	// 객체명
	private String selDate					= "";	// 선택일자
	private String searchSDate				= "";	// 기간검색 시작일
	private String searchEDate				= "";	// 기간검색 종료일
	private String docType					= "";	// 문서 타입
	private String docNm					= "";	// 문서 이름
	private String docPage					= "";	// 문서 페이지

	private String statsType				= "";	// 통계타입
	private String regDate					= "";	// 등록일
	private String regPerSabun				= "";	// 등록자사번
	private String editDate					= "";
	private String editPerSabun				= "";	// 수정자사번
	private String delDate					= "";	// 삭제일
	private String delPerSabun				= "";	// 삭제자사번
	private String delFlag					= "";	// 삭제여부

	private String fileSeq					= "";	// 파일순번
	private String fileGubun				= "";	// 정산시 파일 구분 (info - 안내문, trade - 갱신계약서, report - 연간리포트)
	private String fileNm					= "";	// 파일명
	private String fileUpNm					= "";	// 업로드된 파일명
	private String filePath					= "";	// 파일경로
	private long fileSize					= 0L;	// 파일크기
	private int fileOrder					= 0;	// 파일출력순서
	private int maxFileSize					= 10 * 1024 * 1024;	// 파일크기
	private String nameStamp				= "";	// 회사 명판


	/**	고객	**/
	private String cusCd					= "";	// 고객코드
	private String cusNm					= "";	// 고객명
	private String copyCusCd				= "";	// 복사할 고객코드
	private String copyCusNm				= "";	// 복사할 고객명
	private String cusType					= "";	// 회사종류(1.법인/2.개인)
	private String cusCorType				= "";	// 회사유형(1.유가증권/2.코스닥/3.비상장)
	private String regNum_1					= "";	// 사업자등록번호1
	private String regNum_2					= "";	// 사업자등록번호2
	private String regNum_3					= "";	// 사업자등록번호3
	private String cusRegNum				= "";	// 사업자등록번호
	private String corRegNum_1				= "";	// 법인등록번호1
	private String corRegNum_2				= "";	// 법인등록번호2
	private String cusCorRegNum				= "";	// 법인등록번호
	private String cusOwnNm					= "";	// 대표자명
	private String ownJumin_1				= "";	// 대표자주민번호1
	private String ownJumin_2				= "";	// 대표자주민번호2
	private String cusOwnJumin				= "";	// 대표자주민번호
	private String cusTel					= "";	// 전화번호
	private String cusPhone					= "";	// 핸드폰번호
	private String cusFax					= "";	// 팩스번호
	private String cusEmail					= "";	// 이메일
	private String cusPost					= "";	// 우편번호
	private String cusAddr					= "";	// 우편발송주소
	private String cusStatus				= "";	// 고객구분(1.투자유치가능고객/2.일임고객/3.기타/4.매각/5.해지)
	private String cusStatusNm				= "";
	private String cusStatusOrder			= "";
	private String cusSubStatus				= "";	// 세부고객구분(1.일임외관리/2.일임외비관리/3.매각보증/4.매각무보증
	private String cusTradeEndDate			= "";	// 해지일자
	private String cusAddInvestFlag			= "";	// 추가투자 가능여부 (1.가능/2.불가능)
	private String cusManagerNm				= "";	// 내부담당자명
	private String cusManagerSabun			= "";	// 내부담당자사번
	private String cusInviteNm				= "";	// 유치자명
	private String cusInviteSabun			= "";	// 유치자사번
	private String cusMailingPerNm			= "";	// 메일담당자명
	private String cusMailingPerSabun		= "";	// 메일담당자사번
	private String cusEtc					= "";	// 기타사항
	private String cusOfficeNm				= "";	// 근무처명
	private String cusOfficePosition		= "";	// 근무처 직급
	private String cusOfficeTel				= "";	// 근무처 직통번호
	private String cusOfficeEtc				= "";	// 근무처 비고
	private String cusId					= "";	// 고객 아이디
	private String cusPW					= "";	// 고객 비밀번호
	private String useFlag					= "";	// 고객 계정 사용여부

	/**	공동유치자	**/
	private String inviteRate				= "";	// 공동유치비율
	private String inviteReason				= "";	// 공동유치사유

	/** 외부협력자 **/
	private String collaboPerSabun			= "";	// 외부협력자 사번
	private String collaboRate				= "";	// 외부협력자 비율
	private String collaboReason			= "";	// 외부협력자 사유

	/** 외부사람정보 **/
	private String outPerSabun				= "";	// 외부사람 사번
	private String outPerNm					= "";	// 외부사람 이름

	/**	연관고객	**/
	private String conSeq					= "";	// 연관순번
	private String conCusCd					= "";	// 연관고객코드
	private String conCusNm					= "";	// 연관고객명
	private String conCusStatus				= "";	// 연관고객상태

	/**	고객 담당자	**/
	private String cusPerCd					= "";	// 담당자코드
	private String cusPerNm					= "";	// 담당자명
	private String cusPerPosition			= "";	// 담당자직급
	private String cusPerPositionNm			= "";	// 담당자직급명
	private String cusPerPhone				= "";	// 담당자 연락처
	private String cusPerTel				= "";	// 담당자 직통번호
	private String cusPerEmail				= "";	// 담당자 이메일
	private String cusMailingFlag			= "";	// 메일링 대상여부 (1.대상/2.비대상)
	private String cusPerPost				= "";	// 담당자 우편번호
	private String cusPerAddr				= "";	// 담당자 주소
	private String cusPerEtc				= "";	// 담당자 비고

	/**	종목	**/
	private String comCd					= "";	// 회사코드
	private String comNm					= "";	// 회사명
	private String cateCd					= "";	// 종목코드 Cash 예수금 / CMA CMA / ComKeep 당사보관 / CusKeep 고객보관 / Except 제외금액
	private String oldCateCd				= "";	// 기존의 종목코드
	private String cateNm					= "";	// 종목명
	private String cateType					= "";	// 구분	1.유가증권 / 2.현금
	private String cateTypeNm				= "";	// 구분명
	private String subCateCd				= "";	// 타입코드 1.채권 / 2.주식 / 3.워런트 / 4.CB / 5.EB / 6.잠재주식 / 7.전환권리 / 8.교환권리
	private String subCateNm				= "";	// 타입명
	private String cateNum					= "";	// 종목의 회차
	private String upFlag					= "";	// 상장여부 Y.상장 / N.비상장

	/**	시가	**/
	private String priceSeq					= "";	// 시가순번
	private String priceDate				= "";	// 시가등록일
	private String unitPrice				= "";	// 종목별단가
	private String publicStock				= "";	// 상장주식수
	private String stockValue				= "";	// 시가총액
	private String ownStock					= "";	// 자기주식수
	private String faceValue				= "";	// 액면가

	/**	분석(회사정보)	**/
	private String accountMonth				= "";	// 결산월
	private String marketType				= "";	// 시장구분
	private String addr						= "";	// 주소
	private String tel						= "";	// 전화번호
	private String busiType					= "";	// WICS업종명(소)
	private String maxHolder				= "";	// 최대주주명
	private String maxHaveStockRate			= "";	// 최대주주보유보통주지분율
	private String foundDate				= "";	// 설립일
	private String publicDate				= "";	// 상장일
	private String empCnt					= "";	// 종업원수

	/**	계약	**/
	private String tradeCd					= "";	// 계약코드
	private String tradeType				= "";	// 계약 구분 (1.기간/2.건별)
	private String tradeTypeNm				= "";	// 계약 구분명 (기간/건별)
	private String tradeQuarter				= "";	// 쿼터
	private String tradeFirstDate			= "";	// 최초계약일
	private String tradeStartDate			= "";	// 계약일
	private String tradeEndDate				= "";	// 해지일
	private String tradeStartPeriod			= "";	// 계약기간 시작일
	private String tradeEndPeriod			= "";	// 계약기간 끝일
	private String tradeCharge				= "";	// 수수료율
	private String tradeHopeMoney			= "";	// 쿼터(투자희망액)
	private String tradeSecAccount			= "";	// 증권계좌
	private String tradeCMAAccount			= "";	// CMA계좌
	private String tradeHost				= "";	// 매매주체
	private String tradeSpot				= "";	// 매매지점
	private String tradeStatus				= "";	// 계약상태(1.진행/2.해지)
	private String tradeDocFlag				= "";	// 계약서 제출여부
	private String confirmFlag				= "";	// 확인서 제출여부

	private String calcuCd					= "";	// 정산코드
	private String calcuType				= "";	// 정산타입 (Calcu.정산/NoneCalcu.무정산)
	private String calcuDate				= "";	// 정산일
	private String returnMoney				= "";	// 수익금액(정산일당시)
	private String returnRate				= "";	// 수익율(정산일당시)
	private String returnCharge				= "";	// 성과수수료(정산일당시)
	private String sellUnitPrice			= "";	// 매도단가
	private String sellUnitPriceDate		= "";	// 매도단가 입력일
	private String sellUnitPricePerSabun	= "";	// 매도단가 입력자 사번
	private String hostSeq					= "";	// 매매주체 순번

	/**	계약금	**/
	private String tradeMoneyCd				= "";	// 계약금 코드
	private String tradeMoneyFlag			= "";	// 입출금 구분 (1.입금/2.출금)
	private String tradeMoney				= "";	// 금액
	private String tradeMoneyDate			= "";	// 입출금일자
	private String oldTradeMoney			= "";	// 기존 입출금액
  private String oldTradeMoneyDate		= "";	// 기존 입출금일자
  private String depositMoney			= "";	// 실제 거치되어 있는 현재 금액(입금-출금)

	/**	투자 현황	**/
	private String investType				= "";	// 투자 형태 구분 (1.매수/2.매도)
	private String investCd					= "";	// 투자현황코드
	private String investCnt				= "";	// 투자 수량
	private String investUnitPrice			= "";	// 매수/매도 당시의 단가
	private String investTradeMoney			= "";	// 매매대금 (수량 * 단가)
	private String oddlotMoney				= "";	// 단주대금
	private String investCharge				= "";	// 수수료
	private String investTax				= "";	// 세금
	private String investCalcuMoney			= "";	// 정산금액 (매매대금 - 수수료 - 세금)
	private String oldInvestCalcuMoney		= "";	// 기존 정산금액 (매매대금 - 수수료 - 세금)
	private String investDate				= "";	// 매수/매도일자
	private String oldInvestDate			= "";	// 기존의 매수/매도일자
	private String procType					= "";	// 등록방법 '' - 직접, InSum - 사모투자세부내용, Event - 행사
	private String addMethod				= "";	// 등록방법(로그)

	private String buyInvestCnt				= "";	// 매수수량
	private String buyInvestUnitPrice		= "";	// 매수단가
	private String buyInvestTradeMoney		= "";	// 매수대금
	private String sellInvestCnt			= "";	// 매도수량
	private String sellInvestUnitPrice		= "";	// 매도단가
	private String sellInvestTradeMoney		= "";	// 매도대금
	private String nowInvestCnt				= "";	// 현재수량
	private String nowCalcuMoney			= "";	// 현재금액
	private String nowCash					= "";	// 현재 현금
	private String nowSecurity				= "";	// 현재 유가증권
	private String cashType					= "";	// 1.현금등록(예수금, CMA) 2.기타등록(제외금액, 고객보관, 당사보관)

	private String pastMoneyCd				= "";	// 평가코드
	private String pastInvestCnt			= "";	// 평가수량
	private String pastUnitPrice			= "";	// 평가단가
	private String pastCalcuMoney			= "";	// 평가액
	private String pastInvestDate			= "";	// 평가일
	private String pastCash					= "";	// 평가일 현금
	private String pastSecurity				= "";	// 평가일 유가증권
	private String pastFlag					= "";	// 평가액 등록 여부

	private String investMoneyTmp			= "";	// 예수금Tmp
	private String applyFlag				= "";	// 예수금Tmp 적용여부
	private String applyDate				= "";	// 예수금Tmp 적용일자
	private String applyPerSabun			= "";	// 예수금Tmp 적용자 사번

	/** 매매대상 메모 **/
	private String investMemoSeq			= "";	// 매매대상 메모 순번
	private String investMemo				= "";	// 매매대상 메모

	/**	투자개요	**/
	private String inSuCd					= "";	// 투자개요코드
	private String inSuNm					= "";	// 투자개요명
	private String inSuCom					= "";	// 발행회사
	private String warCateCd				= "";	// 연관 워런트 코드
	private String warCateNm				= "";	// 연관 워런트 명
	private String secCateCd				= "";	// 연관 주식 코드
	private String secCateNm				= "";	// 연관 주식 명
	private String bondCateCd				= "";	// 연관 채권/CB/EB 코드
	private String bondCateNm				= "";	// 연관 채권/CB/EB 명
	private String inSuChungDay				= "";	// 청약일
	private String inSuNabDay				= "";	// 납입일
	private String inSuSaChaeDay			= "";	// 사채만기일
	private String inSuExpiryRate			= "";	// 만기이자율
	private String inSuRepayDay				= "";	// 조기상환일
	private String inSuRepayIza				= "";	// 조기상환이자율
	private String inSuRepayPeriod1			= "";	// 조기상환신청기간1
	private String inSuRepayPeriod2			= "";	// 조기상환신청기간2
	private String inSuRepayFlag			= "";	// 조기상환신청여부
	private String inSuRepayDate			= "";	// 조기상환신청완료일
	private String inSuRepayPerSabun		= "";	// 조기상환신청완료자사번
	private String inSuRepayMethod			= "";	// 조기상환방법
	private String inSuRepayRate			= "";	// 조기상환율
	private String inSuIzaDay				= "";	// 이자지급일
	private String inSuIzaFlag				= "";	// 이자지급여부
	private String inSuIzaDate				= "";	// 이자지급완료일
	private String inSuIzaPerSabun			= "";	// 이자지급완료자사번
	private String inSuSurfaceRate			= "";	// 표면이자율
	private String inSuSurfaceDay			= "";	// 표면이자지급시기
	private String inSuFirstPrice			= "";	// 최초행사가액
	private String inSuBasePrice			= "";	// 기준행사가액
	private String inSuRefixLimit			= "";	// 리픽싱한도
	private String inSuRefixLimitPrice		= "";	// 리픽싱한도가액
	private String inSuNowPrice				= "";	// 현재행사가액
	private String inSuRefixDay				= "";	// 리픽싱일자
	private String inSuRefixReason			= "";	// 리픽싱 발생 사유
	private String inSuRefixReasonCd		= "";	// 리픽싱 발생 사유 코드
	private String inSuRefixFlag			= "";	// 리픽싱여부
	private String inSuRefixDate			= "";	// 리픽싱완료일
	private String inSuRefixPerSabun		= "";	// 리픽싱완료자사번
	private String inSuRefixMethod			= "";	// 리픽싱방법
	private String inSuClaimStart			= "";	// 권리행사시작일
	private String inSuClaimEnd				= "";	// 권리행사종료일
	private String inSuClaimFlag			= "";	// 권리행사여부
	private String inSuClaimDate			= "";	// 권리행사 완료일
	private String inSuClaimPerSabun		= "";	// 권리행사 완료자 사번
	private String inSuBuyBack				= "";	// 바이백
	private String inSuBuyBackPre			= "";	// 바이백프리미엄
	private String inSuCallOption			= "";	// 콜옵션
	private String inSuYtc					= "";	// YTP
	private String inSuCallStart			= "";	// 콜 시작일
	private String inSuCallEnd				= "";	// 콜 종료일
	private String inSuOutMoney				= "";	// 총발행금액
	private String inSuSumMoney				= "";	// 총투자금액
	private String inSuBondForm				= "";	// 채권보유형태
	private String inSuWar					= "";	// 워런트
	private String secTotalCnt				= "";	// 총발행수량
	private String secShare					= "";	// 지분율
	private String ownWar					= "";	// 자기자본 워런트 총액
	private String alarmDate1				= "";	// 알람일자1
	private String alarmDate2				= "";	// 알람일자2
	private String refixDateTmp				= "";	// 리픽싱시 매수를 위한 리픽싱일자 Tmp
	private String inSuNowPriceTmp			= "";	// 리픽싱시 리픽싱전의 행사가액 Tmp
	private String inSuRefixSeq				= "";	// 리픽싱순번
	private String inSuRefixPrice			= "";	// 리픽싱후 금액
	private String mailPassType				= "";	// 메일전달 종류 event - 행사, repay - 조기상환
	private String homeViewFlag				= "";	// 홈페이지 출력여부
	private String homeViewFlagNm			= "";
	private String returnDate				= "";	// 회수일



	/** 투자개요 워런트 **/
	private String warGrpCd					= "";	// 워런트그룹코드
	private String warCd					= "";	// 워런트코드
	private String warMoney					= "";	// 워런트권종
	private String warSeqNum				= "";	// 워런트일련번호
	private String warSetFlag				= "";	// 워런트부여여부

	/** 투자개요 채권 **/
	private String bondGrpCd				= "";	// 채권그룹코드
	private String bondCd					= "";	// 채권코드
	private String bondMoney				= "";	// 채권권종
	private String bondSeqNum				= "";	// 채권일련번호
	private String bondSetFlag				= "";	// 채권부여여부

	/** 투자개요 분석&탐방 **/
	private String memo						= "";
	private String offerType				= "";
	private String fileFlag					= "";

	/** 채권매각 고객 세부 정보 **/
	private String bondCusSeq				= "";	// 채권매각고객순번
	private String targetMoney				= "";	// 대상금액
	private String toDoSellDay				= "";	// 매각예정일
	private String extraPeriod				= "";	// 잔여기간
	private String extraDay					= "";	// 잔여일
	private String repayMoney				= "";	// 조기상환금액
	private String periodIza				= "";	// 기간이자
	private String sumReturnMoney			= "";	// 총회수금액
	private String reqReturnRate			= "";	// 요구수익율
	private String dealPrice				= "";	// 매매단가
	private String dealPriceOpt				= "";	// 단리,복리	(Dan - 단리 // Bok - 복리)
	private String dealPriceOptNm			= "";
	private String dealMoney				= "";	// 매매금액
	private String dealMoneyOpt				= "";	// 매매금액단위	(Won - 원단위 // Man - 만단위 // Jik - 직접입력)
	private String dealMoneyOptNm			= "";
	private String dealTax					= "";	// 세금
	private String realDealMoney			= "";	// 실거래금액
	private String assureFlag				= "";	// 보증여부		(Y - 여 // N - 부)
	private String assureFlagNm				= "";
	private String withHoldingFlag			= "";	// 원천징수여부	(Y - 여 // N - 부)
	private String putEventDay				= "";	// 풋행사시기
	private String putCycle					= "";	// 풋주기
	private String putEventFlag				= "";	// 풋행사 플래그 (in - 내부, out - 외부)
	private String eventTargetMoney			= "";	// 풋행사한 대상금액

	/** 채권매각 고객 풋행사정보 **/
	private String bondEventSeq				= "";	// 행사순번
	private String buyMoney					= "";	// 매수금액
	private String buyDay					= "";	// 매수일
	private String sellDay					= "";	// 매도일
	private String passPeriod				= "";	// 경과기간

	/**	보고서	**/
	private String reportCd					= "";	// 레포트코드
	private String reportSDate				= "";	// 운용기간1
	private String reportEDate				= "";	// 운용기간2
	private String impDate					= "";	// 부과일자
	private String chargeFlag				= "";	// 수수료구분
	private String chargeMoney				= "";	// 금액
	private String payLimit					= "";	// 납입기한
	private String payFlag					= "";	// 납부결과
	private String calcuInfo				= "";	// 정산 코멘트
	private String secInfo					= "";	// 유가증권 코멘트
	private String manaInfo					= "";	// 운용내역 코멘트
	private String accMoney					= "";	// 누적 수익 금액
	private String periodMoney				= "";	// 기간 수익 금액
	private String startValue				= "";	// 기초 평가액
	private String startCash				= "";	// 기초 평가액 현금
	private String startSec					= "";	// 기초 평가액 유가증권
	private String endValue					= "";	// 기말 평가액
	private String endCash					= "";	// 기말 평가액 현금
	private String endSec					= "";	// 기말 평가액 유가증권
	private String commitFlag				= "";	// 마감여부
	private String commitDate				= "";	// 마감일자
	private String commitPerSabun			= "";	// 마감자사번
	private String calcuAddMoney			= "";

	/**	메일	**/
	private String mailCd					= "";	// 메일코드
	private String mailTitle				= "";	// 메일제목
	private String mailCon					= "";	// 메일내용
	private String mailFileFlag				= "";	// 파일첨부여부
	private String mailRePerNm				= "";	// 수신자명
	private String mailRePerEmail			= "";	// 수신자 이메일
	private String mailSePerSabun			= "";	// 발신자사번
	private String mailSePerNm				= "";	// 발신자명
	private String mailSePerEmail			= "";	// 발신자 이메일
	private String mailSendDate				= "";	// 발신일자
	private String mailKey					= "";	// 수신확인키
	private String mailOpenFlag				= "";	// 수신여부

	/**	투자제안	**/
	private String investOfferCd			= "";	// 투자제안코드
	private String investOfferNm			= "";	// 투자제안명
	private String investOfferCon			= "";	// 투자제안내용
	private String investOfferMoney			= "";	// 총투자금액
	private String mailingViewFlag			= "";	// 메일링 출력여부
	private String hiddenFlag				= "";	// 숨김여부
	private int viewOrder					= 0;	// 출력순서
	private String scheSeq					= "";

	/**	고객분배	**/
	private String divOfferCd				= "";	// 분배코드
	private String divOfferMoney			= "";	// 분배 금액
	private String investOfferFlag			= "";	// 투자제안여부
	private String divConfirmFlag			= "";	// 분배 확정 여부
	private String divInMoneyFlag			= "";	// 분배 입금 여부

	private String offerMemoSeq				= "";	// 메모순번
	private String offerMemo				= "";	// 메모

	/**	고객게시판	**/
	// 공통
	private String eventType				= "";	// 이벤트타입
	private String eventTypeTmp				= "";	// 이벤트타입Tmp
	private String readFlag					= "";	// 게시물 읽음여부
	private String menuCon					= "";	// 고객별 메뉴 설명
	private String regPerNm					= "";

	// 운용보고서
	private String nowSumMoney				= "";	// 기말평가액
	private String accPer					= "";	// 누적 수익율
	private String addAvgPer				= "";	// 가중평균수익율
	private String realNowCash				= "";	// 실제 현재 현금
	private String warSecurity				= "";	// 워런트평가이익
	private String nowTotalSumMoney			= "";	// 총평가액
	private String addAvgPeriod				= "";	// 가중평균일임기간
	private String hdnAccPer				= "";	// 워런트포함 누적수익율
	private String hdnAddAvgPer				= "";	// 워런트포함 가중평균수익율

	// 문의게시판
	private String writeCd					= "";	// 글코드
	private String writeTitle				= "";	// 글제목
	private String writeCon					= "";	// 글내용
	private String writePerNm				= "";	// 작성자성명
	private String writePerSabun			= "";	// 작성자코드
	private String writePW					= "";	// 게시물 비밀번호

	// 문의게시판댓글
	private String replyCd					= "";	// 댓글코드
	private String replyCon					= "";	// 댓글내용
	private String replyPerSabun			= "";	// 댓글작성자코드
	private String replyPerNm				= "";	// 댓글작성자명



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	private static final long serialVersionUID = -8274004534207618049L;


	public String getSearchCondition() {return searchCondition;}
	public void setSearchCondition(String searchCondition) {this.searchCondition = searchCondition;}

	public String getSearchKeyword() {return searchKeyword;}
	public void setSearchKeyword(String searchKeyword) {this.searchKeyword = searchKeyword;}

	/**	고객	**/
	public String getsNb() {return sNb;}
	public void setsNb(String sNb) {this.sNb = sNb;}

	public String getHighSearchQuery() {
		return highSearchQuery;
	}
	public void setHighSearchQuery(String highSearchQuery) {
		this.highSearchQuery = highSearchQuery;
	}
	public String getHighSearchData() {
		return highSearchData;
	}
	public void setHighSearchData(String highSearchData) {
		this.highSearchData = highSearchData;
	}
	public String getHighSearchSDate() {
		return highSearchSDate;
	}
	public void setHighSearchSDate(String highSearchSDate) {
		this.highSearchSDate = highSearchSDate;
	}
	public String getHighSearchEDate() {
		return highSearchEDate;
	}
	public void setHighSearchEDate(String highSearchEDate) {
		this.highSearchEDate = highSearchEDate;
	}
	public String getOrderFlag() {
		return orderFlag;
	}
	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	public String getOrderKey() {
		return orderKey;
	}
	public void setOrderKey(String orderKey) {
		this.orderKey = orderKey;
	}
	public String getNewWinFlag() {
		return newWinFlag;
	}
	public void setNewWinFlag(String newWinFlag) {
		this.newWinFlag = newWinFlag;
	}
	public String getEventFlag() {
		return eventFlag;
	}
	public void setEventFlag(String eventFlag) {
		this.eventFlag = eventFlag;
	}
	public String getInfoMessage() {
		return infoMessage;
	}
	public void setInfoMessage(String infoMessage) {
		this.infoMessage = infoMessage;
	}
	public String getObjNm() {
		return objNm;
	}
	public void setObjNm(String objNm) {
		this.objNm = objNm;
	}
	public String getSelDate() {
		return selDate;
	}
	public void setSelDate(String selDate) {
		this.selDate = selDate;
	}
	public String getSearchSDate() {
		return searchSDate;
	}
	public void setSearchSDate(String searchSDate) {
		this.searchSDate = searchSDate;
	}
	public String getSearchEDate() {
		return searchEDate;
	}
	public void setSearchEDate(String searchEDate) {
		this.searchEDate = searchEDate;
	}
	public String getDocType() {
		return docType;
	}
	public void setDocType(String docType) {
		this.docType = docType;
	}
	public String getDocNm() {
		return docNm;
	}
	public void setDocNm(String docNm) {
		this.docNm = docNm;
	}
	public String getDocPage() {
		return docPage;
	}
	public void setDocPage(String docPage) {
		this.docPage = docPage;
	}
	public String getStatsType() {
		return statsType;
	}
	public void setStatsType(String statsType) {
		this.statsType = statsType;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegPerSabun() {
		return regPerSabun;
	}
	public void setRegPerSabun(String regPerSabun) {
		this.regPerSabun = regPerSabun;
	}
	public String getEditDate() {
		return editDate;
	}
	public void setEditDate(String editDate) {
		this.editDate = editDate;
	}
	public String getEditPerSabun() {
		return editPerSabun;
	}
	public void setEditPerSabun(String editPerSabun) {
		this.editPerSabun = editPerSabun;
	}
	public String getDelDate() {
		return delDate;
	}
	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}
	public String getDelPerSabun() {
		return delPerSabun;
	}
	public void setDelPerSabun(String delPerSabun) {
		this.delPerSabun = delPerSabun;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getFileGubun() {
		return fileGubun;
	}
	public void setFileGubun(String fileGubun) {
		this.fileGubun = fileGubun;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getFileUpNm() {
		return fileUpNm;
	}
	public void setFileUpNm(String fileUpNm) {
		this.fileUpNm = fileUpNm;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public int getFileOrder() {
		return fileOrder;
	}
	public void setFileOrder(int fileOrder) {
		this.fileOrder = fileOrder;
	}
	public int getMaxFileSize() {
		return maxFileSize;
	}
	public void setMaxFileSize(int maxFileSize) {
		this.maxFileSize = maxFileSize;
	}
	public String getNameStamp() {
		return nameStamp;
	}
	public void setNameStamp(String nameStamp) {
		this.nameStamp = nameStamp;
	}
	public String getCusCd() {
		return cusCd;
	}
	public void setCusCd(String cusCd) {
		this.cusCd = cusCd;
	}
	public String getCusNm() {
		return cusNm;
	}
	public void setCusNm(String cusNm) {
		this.cusNm = cusNm;
	}
	public String getCopyCusCd() {
		return copyCusCd;
	}
	public void setCopyCusCd(String copyCusCd) {
		this.copyCusCd = copyCusCd;
	}
	public String getCopyCusNm() {
		return copyCusNm;
	}
	public void setCopyCusNm(String copyCusNm) {
		this.copyCusNm = copyCusNm;
	}
	public String getCusType() {
		return cusType;
	}
	public void setCusType(String cusType) {
		this.cusType = cusType;
	}
	public String getCusCorType() {
		return cusCorType;
	}
	public void setCusCorType(String cusCorType) {
		this.cusCorType = cusCorType;
	}
	public String getRegNum_1() {
		return regNum_1;
	}
	public void setRegNum_1(String regNum_1) {
		this.regNum_1 = regNum_1;
	}
	public String getRegNum_2() {
		return regNum_2;
	}
	public void setRegNum_2(String regNum_2) {
		this.regNum_2 = regNum_2;
	}
	public String getRegNum_3() {
		return regNum_3;
	}
	public void setRegNum_3(String regNum_3) {
		this.regNum_3 = regNum_3;
	}
	public String getCusRegNum() {
		return cusRegNum;
	}
	public void setCusRegNum(String cusRegNum) {
		this.cusRegNum = cusRegNum;
	}
	public String getCorRegNum_1() {
		return corRegNum_1;
	}
	public void setCorRegNum_1(String corRegNum_1) {
		this.corRegNum_1 = corRegNum_1;
	}
	public String getCorRegNum_2() {
		return corRegNum_2;
	}
	public void setCorRegNum_2(String corRegNum_2) {
		this.corRegNum_2 = corRegNum_2;
	}
	public String getCusCorRegNum() {
		return cusCorRegNum;
	}
	public void setCusCorRegNum(String cusCorRegNum) {
		this.cusCorRegNum = cusCorRegNum;
	}
	public String getCusOwnNm() {
		return cusOwnNm;
	}
	public void setCusOwnNm(String cusOwnNm) {
		this.cusOwnNm = cusOwnNm;
	}
	public String getOwnJumin_1() {
		return ownJumin_1;
	}
	public void setOwnJumin_1(String ownJumin_1) {
		this.ownJumin_1 = ownJumin_1;
	}
	public String getOwnJumin_2() {
		return ownJumin_2;
	}
	public void setOwnJumin_2(String ownJumin_2) {
		this.ownJumin_2 = ownJumin_2;
	}
	public String getCusOwnJumin() {
		return cusOwnJumin;
	}
	public void setCusOwnJumin(String cusOwnJumin) {
		this.cusOwnJumin = cusOwnJumin;
	}
	public String getCusTel() {
		return cusTel;
	}
	public void setCusTel(String cusTel) {
		this.cusTel = cusTel;
	}
	public String getCusPhone() {
		return cusPhone;
	}
	public void setCusPhone(String cusPhone) {
		this.cusPhone = cusPhone;
	}
	public String getCusFax() {
		return cusFax;
	}
	public void setCusFax(String cusFax) {
		this.cusFax = cusFax;
	}
	public String getCusEmail() {
		return cusEmail;
	}
	public void setCusEmail(String cusEmail) {
		this.cusEmail = cusEmail;
	}
	public String getCusPost() {
		return cusPost;
	}
	public void setCusPost(String cusPost) {
		this.cusPost = cusPost;
	}
	public String getCusAddr() {
		return cusAddr;
	}
	public void setCusAddr(String cusAddr) {
		this.cusAddr = cusAddr;
	}
	public String getCusStatus() {
		return cusStatus;
	}
	public void setCusStatus(String cusStatus) {
		this.cusStatus = cusStatus;
	}
	public String getCusStatusNm() {
		return cusStatusNm;
	}
	public void setCusStatusNm(String cusStatusNm) {
		this.cusStatusNm = cusStatusNm;
	}
	public String getCusStatusOrder() {
		return cusStatusOrder;
	}
	public void setCusStatusOrder(String cusStatusOrder) {
		this.cusStatusOrder = cusStatusOrder;
	}
	public String getCusSubStatus() {
		return cusSubStatus;
	}
	public void setCusSubStatus(String cusSubStatus) {
		this.cusSubStatus = cusSubStatus;
	}
	public String getCusTradeEndDate() {
		return cusTradeEndDate;
	}
	public void setCusTradeEndDate(String cusTradeEndDate) {
		this.cusTradeEndDate = cusTradeEndDate;
	}
	public String getCusAddInvestFlag() {
		return cusAddInvestFlag;
	}
	public void setCusAddInvestFlag(String cusAddInvestFlag) {
		this.cusAddInvestFlag = cusAddInvestFlag;
	}
	public String getCusManagerNm() {
		return cusManagerNm;
	}
	public void setCusManagerNm(String cusManagerNm) {
		this.cusManagerNm = cusManagerNm;
	}
	public String getCusManagerSabun() {
		return cusManagerSabun;
	}
	public void setCusManagerSabun(String cusManagerSabun) {
		this.cusManagerSabun = cusManagerSabun;
	}
	public String getCusInviteNm() {
		return cusInviteNm;
	}
	public void setCusInviteNm(String cusInviteNm) {
		this.cusInviteNm = cusInviteNm;
	}
	public String getCusInviteSabun() {
		return cusInviteSabun;
	}
	public void setCusInviteSabun(String cusInviteSabun) {
		this.cusInviteSabun = cusInviteSabun;
	}
	public String getCusMailingPerNm() {
		return cusMailingPerNm;
	}
	public void setCusMailingPerNm(String cusMailingPerNm) {
		this.cusMailingPerNm = cusMailingPerNm;
	}
	public String getCusMailingPerSabun() {
		return cusMailingPerSabun;
	}
	public void setCusMailingPerSabun(String cusMailingPerSabun) {
		this.cusMailingPerSabun = cusMailingPerSabun;
	}
	public String getCusEtc() {
		return cusEtc;
	}
	public void setCusEtc(String cusEtc) {
		this.cusEtc = cusEtc;
	}
	public String getCusOfficeNm() {
		return cusOfficeNm;
	}
	public void setCusOfficeNm(String cusOfficeNm) {
		this.cusOfficeNm = cusOfficeNm;
	}
	public String getCusOfficePosition() {
		return cusOfficePosition;
	}
	public void setCusOfficePosition(String cusOfficePosition) {
		this.cusOfficePosition = cusOfficePosition;
	}
	public String getCusOfficeTel() {
		return cusOfficeTel;
	}
	public void setCusOfficeTel(String cusOfficeTel) {
		this.cusOfficeTel = cusOfficeTel;
	}
	public String getCusOfficeEtc() {
		return cusOfficeEtc;
	}
	public void setCusOfficeEtc(String cusOfficeEtc) {
		this.cusOfficeEtc = cusOfficeEtc;
	}
	public String getCusId() {
		return cusId;
	}
	public void setCusId(String cusId) {
		this.cusId = cusId;
	}
	public String getCusPW() {
		return cusPW;
	}
	public void setCusPW(String cusPW) {
		this.cusPW = cusPW;
	}
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}
	public String getInviteRate() {
		return inviteRate;
	}
	public void setInviteRate(String inviteRate) {
		this.inviteRate = inviteRate;
	}
	public String getInviteReason() {
		return inviteReason;
	}
	public void setInviteReason(String inviteReason) {
		this.inviteReason = inviteReason;
	}
	public String getCollaboPerSabun() {
		return collaboPerSabun;
	}
	public void setCollaboPerSabun(String collaboPerSabun) {
		this.collaboPerSabun = collaboPerSabun;
	}
	public String getCollaboRate() {
		return collaboRate;
	}
	public void setCollaboRate(String collaboRate) {
		this.collaboRate = collaboRate;
	}
	public String getCollaboReason() {
		return collaboReason;
	}
	public void setCollaboReason(String collaboReason) {
		this.collaboReason = collaboReason;
	}
	public String getOutPerSabun() {
		return outPerSabun;
	}
	public void setOutPerSabun(String outPerSabun) {
		this.outPerSabun = outPerSabun;
	}
	public String getOutPerNm() {
		return outPerNm;
	}
	public void setOutPerNm(String outPerNm) {
		this.outPerNm = outPerNm;
	}
	public String getConSeq() {
		return conSeq;
	}
	public void setConSeq(String conSeq) {
		this.conSeq = conSeq;
	}
	public String getConCusCd() {
		return conCusCd;
	}
	public void setConCusCd(String conCusCd) {
		this.conCusCd = conCusCd;
	}
	public String getConCusNm() {
		return conCusNm;
	}
	public void setConCusNm(String conCusNm) {
		this.conCusNm = conCusNm;
	}
	public String getConCusStatus() {
		return conCusStatus;
	}
	public void setConCusStatus(String conCusStatus) {
		this.conCusStatus = conCusStatus;
	}
	public String getCusPerCd() {
		return cusPerCd;
	}
	public void setCusPerCd(String cusPerCd) {
		this.cusPerCd = cusPerCd;
	}
	public String getCusPerNm() {
		return cusPerNm;
	}
	public void setCusPerNm(String cusPerNm) {
		this.cusPerNm = cusPerNm;
	}
	public String getCusPerPosition() {
		return cusPerPosition;
	}
	public void setCusPerPosition(String cusPerPosition) {
		this.cusPerPosition = cusPerPosition;
	}
	public String getCusPerPositionNm() {
		return cusPerPositionNm;
	}
	public void setCusPerPositionNm(String cusPerPositionNm) {
		this.cusPerPositionNm = cusPerPositionNm;
	}
	public String getCusPerPhone() {
		return cusPerPhone;
	}
	public void setCusPerPhone(String cusPerPhone) {
		this.cusPerPhone = cusPerPhone;
	}
	public String getCusPerTel() {
		return cusPerTel;
	}
	public void setCusPerTel(String cusPerTel) {
		this.cusPerTel = cusPerTel;
	}
	public String getCusPerEmail() {
		return cusPerEmail;
	}
	public void setCusPerEmail(String cusPerEmail) {
		this.cusPerEmail = cusPerEmail;
	}
	public String getCusMailingFlag() {
		return cusMailingFlag;
	}
	public void setCusMailingFlag(String cusMailingFlag) {
		this.cusMailingFlag = cusMailingFlag;
	}
	public String getCusPerPost() {
		return cusPerPost;
	}
	public void setCusPerPost(String cusPerPost) {
		this.cusPerPost = cusPerPost;
	}
	public String getCusPerAddr() {
		return cusPerAddr;
	}
	public void setCusPerAddr(String cusPerAddr) {
		this.cusPerAddr = cusPerAddr;
	}
	public String getCusPerEtc() {
		return cusPerEtc;
	}
	public void setCusPerEtc(String cusPerEtc) {
		this.cusPerEtc = cusPerEtc;
	}
	public String getComCd() {
		return comCd;
	}
	public void setComCd(String comCd) {
		this.comCd = comCd;
	}
	public String getComNm() {
		return comNm;
	}
	public void setComNm(String comNm) {
		this.comNm = comNm;
	}
	public String getCateCd() {
		return cateCd;
	}
	public void setCateCd(String cateCd) {
		this.cateCd = cateCd;
	}
	public String getOldCateCd() {
		return oldCateCd;
	}
	public void setOldCateCd(String oldCateCd) {
		this.oldCateCd = oldCateCd;
	}
	public String getCateNm() {
		return cateNm;
	}
	public void setCateNm(String cateNm) {
		this.cateNm = cateNm;
	}
	public String getCateType() {
		return cateType;
	}
	public void setCateType(String cateType) {
		this.cateType = cateType;
	}
	public String getCateTypeNm() {
		return cateTypeNm;
	}
	public void setCateTypeNm(String cateTypeNm) {
		this.cateTypeNm = cateTypeNm;
	}
	public String getSubCateCd() {
		return subCateCd;
	}
	public void setSubCateCd(String subCateCd) {
		this.subCateCd = subCateCd;
	}
	public String getSubCateNm() {
		return subCateNm;
	}
	public void setSubCateNm(String subCateNm) {
		this.subCateNm = subCateNm;
	}
	public String getCateNum() {
		return cateNum;
	}
	public void setCateNum(String cateNum) {
		this.cateNum = cateNum;
	}
	public String getUpFlag() {
		return upFlag;
	}
	public void setUpFlag(String upFlag) {
		this.upFlag = upFlag;
	}
	public String getPriceSeq() {
		return priceSeq;
	}
	public void setPriceSeq(String priceSeq) {
		this.priceSeq = priceSeq;
	}
	public String getPriceDate() {
		return priceDate;
	}
	public void setPriceDate(String priceDate) {
		this.priceDate = priceDate;
	}
	public String getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getPublicStock() {
		return publicStock;
	}
	public void setPublicStock(String publicStock) {
		this.publicStock = publicStock;
	}
	public String getStockValue() {
		return stockValue;
	}
	public void setStockValue(String stockValue) {
		this.stockValue = stockValue;
	}
	public String getOwnStock() {
		return ownStock;
	}
	public void setOwnStock(String ownStock) {
		this.ownStock = ownStock;
	}
	public String getFaceValue() {
		return faceValue;
	}
	public void setFaceValue(String faceValue) {
		this.faceValue = faceValue;
	}
	public String getAccountMonth() {
		return accountMonth;
	}
	public void setAccountMonth(String accountMonth) {
		this.accountMonth = accountMonth;
	}
	public String getMarketType() {
		return marketType;
	}
	public void setMarketType(String marketType) {
		this.marketType = marketType;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getBusiType() {
		return busiType;
	}
	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}
	public String getMaxHolder() {
		return maxHolder;
	}
	public void setMaxHolder(String maxHolder) {
		this.maxHolder = maxHolder;
	}
	public String getMaxHaveStockRate() {
		return maxHaveStockRate;
	}
	public void setMaxHaveStockRate(String maxHaveStockRate) {
		this.maxHaveStockRate = maxHaveStockRate;
	}
	public String getFoundDate() {
		return foundDate;
	}
	public void setFoundDate(String foundDate) {
		this.foundDate = foundDate;
	}
	public String getPublicDate() {
		return publicDate;
	}
	public void setPublicDate(String publicDate) {
		this.publicDate = publicDate;
	}
	public String getEmpCnt() {
		return empCnt;
	}
	public void setEmpCnt(String empCnt) {
		this.empCnt = empCnt;
	}
	public String getTradeCd() {
		return tradeCd;
	}
	public void setTradeCd(String tradeCd) {
		this.tradeCd = tradeCd;
	}
	public String getTradeType() {
		return tradeType;
	}
	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	public String getTradeTypeNm() {
		return tradeTypeNm;
	}
	public void setTradeTypeNm(String tradeTypeNm) {
		this.tradeTypeNm = tradeTypeNm;
	}
	public String getTradeQuarter() {
		return tradeQuarter;
	}
	public void setTradeQuarter(String tradeQuarter) {
		this.tradeQuarter = tradeQuarter;
	}
	public String getTradeFirstDate() {
		return tradeFirstDate;
	}
	public void setTradeFirstDate(String tradeFirstDate) {
		this.tradeFirstDate = tradeFirstDate;
	}
	public String getTradeStartDate() {
		return tradeStartDate;
	}
	public void setTradeStartDate(String tradeStartDate) {
		this.tradeStartDate = tradeStartDate;
	}
	public String getTradeEndDate() {
		return tradeEndDate;
	}
	public void setTradeEndDate(String tradeEndDate) {
		this.tradeEndDate = tradeEndDate;
	}
	public String getTradeStartPeriod() {
		return tradeStartPeriod;
	}
	public void setTradeStartPeriod(String tradeStartPeriod) {
		this.tradeStartPeriod = tradeStartPeriod;
	}
	public String getTradeEndPeriod() {
		return tradeEndPeriod;
	}
	public void setTradeEndPeriod(String tradeEndPeriod) {
		this.tradeEndPeriod = tradeEndPeriod;
	}
	public String getTradeCharge() {
		return tradeCharge;
	}
	public void setTradeCharge(String tradeCharge) {
		this.tradeCharge = tradeCharge;
	}
	public String getTradeHopeMoney() {
		return tradeHopeMoney;
	}
	public void setTradeHopeMoney(String tradeHopeMoney) {
		this.tradeHopeMoney = tradeHopeMoney;
	}
	public String getTradeSecAccount() {
		return tradeSecAccount;
	}
	public void setTradeSecAccount(String tradeSecAccount) {
		this.tradeSecAccount = tradeSecAccount;
	}
	public String getTradeCMAAccount() {
		return tradeCMAAccount;
	}
	public void setTradeCMAAccount(String tradeCMAAccount) {
		this.tradeCMAAccount = tradeCMAAccount;
	}
	public String getTradeHost() {
		return tradeHost;
	}
	public void setTradeHost(String tradeHost) {
		this.tradeHost = tradeHost;
	}
	public String getTradeSpot() {
		return tradeSpot;
	}
	public void setTradeSpot(String tradeSpot) {
		this.tradeSpot = tradeSpot;
	}
	public String getTradeStatus() {
		return tradeStatus;
	}
	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}
	public String getTradeDocFlag() {
		return tradeDocFlag;
	}
	public void setTradeDocFlag(String tradeDocFlag) {
		this.tradeDocFlag = tradeDocFlag;
	}
	public String getConfirmFlag() {
		return confirmFlag;
	}
	public void setConfirmFlag(String confirmFlag) {
		this.confirmFlag = confirmFlag;
	}
	public String getCalcuCd() {
		return calcuCd;
	}
	public void setCalcuCd(String calcuCd) {
		this.calcuCd = calcuCd;
	}
	public String getCalcuType() {
		return calcuType;
	}
	public void setCalcuType(String calcuType) {
		this.calcuType = calcuType;
	}
	public String getCalcuDate() {
		return calcuDate;
	}
	public void setCalcuDate(String calcuDate) {
		this.calcuDate = calcuDate;
	}
	public String getReturnMoney() {
		return returnMoney;
	}
	public void setReturnMoney(String returnMoney) {
		this.returnMoney = returnMoney;
	}
	public String getReturnRate() {
		return returnRate;
	}
	public void setReturnRate(String returnRate) {
		this.returnRate = returnRate;
	}
	public String getReturnCharge() {
		return returnCharge;
	}
	public void setReturnCharge(String returnCharge) {
		this.returnCharge = returnCharge;
	}
	public String getSellUnitPrice() {
		return sellUnitPrice;
	}
	public void setSellUnitPrice(String sellUnitPrice) {
		this.sellUnitPrice = sellUnitPrice;
	}
	public String getSellUnitPriceDate() {
		return sellUnitPriceDate;
	}
	public void setSellUnitPriceDate(String sellUnitPriceDate) {
		this.sellUnitPriceDate = sellUnitPriceDate;
	}
	public String getSellUnitPricePerSabun() {
		return sellUnitPricePerSabun;
	}
	public void setSellUnitPricePerSabun(String sellUnitPricePerSabun) {
		this.sellUnitPricePerSabun = sellUnitPricePerSabun;
	}
	public String getHostSeq() {
		return hostSeq;
	}
	public void setHostSeq(String hostSeq) {
		this.hostSeq = hostSeq;
	}
	public String getTradeMoneyCd() {
		return tradeMoneyCd;
	}
	public void setTradeMoneyCd(String tradeMoneyCd) {
		this.tradeMoneyCd = tradeMoneyCd;
	}
	public String getTradeMoneyFlag() {
		return tradeMoneyFlag;
	}
	public void setTradeMoneyFlag(String tradeMoneyFlag) {
		this.tradeMoneyFlag = tradeMoneyFlag;
	}
	public String getTradeMoney() {
		return tradeMoney;
	}
	public void setTradeMoney(String tradeMoney) {
		this.tradeMoney = tradeMoney;
	}
	public String getTradeMoneyDate() {
		return tradeMoneyDate;
	}
	public void setTradeMoneyDate(String tradeMoneyDate) {
		this.tradeMoneyDate = tradeMoneyDate;
	}
	public String getOldTradeMoney() {
		return oldTradeMoney;
	}
	public void setOldTradeMoney(String oldTradeMoney) {
		this.oldTradeMoney = oldTradeMoney;
	}
	public String getOldTradeMoneyDate() {
		return oldTradeMoneyDate;
	}
	public void setOldTradeMoneyDate(String oldTradeMoneyDate) {
		this.oldTradeMoneyDate = oldTradeMoneyDate;
	}
	public String getDepositMoney() {
		return depositMoney;
	}
	public void setDepositMoney(String depositMoney) {
		this.depositMoney = depositMoney;
	}
	public String getInvestType() {
		return investType;
	}
	public void setInvestType(String investType) {
		this.investType = investType;
	}
	public String getInvestCd() {
		return investCd;
	}
	public void setInvestCd(String investCd) {
		this.investCd = investCd;
	}
	public String getInvestCnt() {
		return investCnt;
	}
	public void setInvestCnt(String investCnt) {
		this.investCnt = investCnt;
	}
	public String getInvestUnitPrice() {
		return investUnitPrice;
	}
	public void setInvestUnitPrice(String investUnitPrice) {
		this.investUnitPrice = investUnitPrice;
	}
	public String getInvestTradeMoney() {
		return investTradeMoney;
	}
	public void setInvestTradeMoney(String investTradeMoney) {
		this.investTradeMoney = investTradeMoney;
	}
	public String getOddlotMoney() {
		return oddlotMoney;
	}
	public void setOddlotMoney(String oddlotMoney) {
		this.oddlotMoney = oddlotMoney;
	}
	public String getInvestCharge() {
		return investCharge;
	}
	public void setInvestCharge(String investCharge) {
		this.investCharge = investCharge;
	}
	public String getInvestTax() {
		return investTax;
	}
	public void setInvestTax(String investTax) {
		this.investTax = investTax;
	}
	public String getInvestCalcuMoney() {
		return investCalcuMoney;
	}
	public void setInvestCalcuMoney(String investCalcuMoney) {
		this.investCalcuMoney = investCalcuMoney;
	}
	public String getOldInvestCalcuMoney() {
		return oldInvestCalcuMoney;
	}
	public void setOldInvestCalcuMoney(String oldInvestCalcuMoney) {
		this.oldInvestCalcuMoney = oldInvestCalcuMoney;
	}
	public String getInvestDate() {
		return investDate;
	}
	public void setInvestDate(String investDate) {
		this.investDate = investDate;
	}
	public String getOldInvestDate() {
		return oldInvestDate;
	}
	public void setOldInvestDate(String oldInvestDate) {
		this.oldInvestDate = oldInvestDate;
	}
	public String getProcType() {
		return procType;
	}
	public void setProcType(String procType) {
		this.procType = procType;
	}
	public String getAddMethod() {
		return addMethod;
	}
	public void setAddMethod(String addMethod) {
		this.addMethod = addMethod;
	}
	public String getBuyInvestCnt() {
		return buyInvestCnt;
	}
	public void setBuyInvestCnt(String buyInvestCnt) {
		this.buyInvestCnt = buyInvestCnt;
	}
	public String getBuyInvestUnitPrice() {
		return buyInvestUnitPrice;
	}
	public void setBuyInvestUnitPrice(String buyInvestUnitPrice) {
		this.buyInvestUnitPrice = buyInvestUnitPrice;
	}
	public String getBuyInvestTradeMoney() {
		return buyInvestTradeMoney;
	}
	public void setBuyInvestTradeMoney(String buyInvestTradeMoney) {
		this.buyInvestTradeMoney = buyInvestTradeMoney;
	}
	public String getSellInvestCnt() {
		return sellInvestCnt;
	}
	public void setSellInvestCnt(String sellInvestCnt) {
		this.sellInvestCnt = sellInvestCnt;
	}
	public String getSellInvestUnitPrice() {
		return sellInvestUnitPrice;
	}
	public void setSellInvestUnitPrice(String sellInvestUnitPrice) {
		this.sellInvestUnitPrice = sellInvestUnitPrice;
	}
	public String getSellInvestTradeMoney() {
		return sellInvestTradeMoney;
	}
	public void setSellInvestTradeMoney(String sellInvestTradeMoney) {
		this.sellInvestTradeMoney = sellInvestTradeMoney;
	}
	public String getNowInvestCnt() {
		return nowInvestCnt;
	}
	public void setNowInvestCnt(String nowInvestCnt) {
		this.nowInvestCnt = nowInvestCnt;
	}
	public String getNowCalcuMoney() {
		return nowCalcuMoney;
	}
	public void setNowCalcuMoney(String nowCalcuMoney) {
		this.nowCalcuMoney = nowCalcuMoney;
	}
	public String getNowCash() {
		return nowCash;
	}
	public void setNowCash(String nowCash) {
		this.nowCash = nowCash;
	}
	public String getNowSecurity() {
		return nowSecurity;
	}
	public void setNowSecurity(String nowSecurity) {
		this.nowSecurity = nowSecurity;
	}
	public String getCashType() {
		return cashType;
	}
	public void setCashType(String cashType) {
		this.cashType = cashType;
	}
	public String getPastMoneyCd() {
		return pastMoneyCd;
	}
	public void setPastMoneyCd(String pastMoneyCd) {
		this.pastMoneyCd = pastMoneyCd;
	}
	public String getPastInvestCnt() {
		return pastInvestCnt;
	}
	public void setPastInvestCnt(String pastInvestCnt) {
		this.pastInvestCnt = pastInvestCnt;
	}
	public String getPastUnitPrice() {
		return pastUnitPrice;
	}
	public void setPastUnitPrice(String pastUnitPrice) {
		this.pastUnitPrice = pastUnitPrice;
	}
	public String getPastCalcuMoney() {
		return pastCalcuMoney;
	}
	public void setPastCalcuMoney(String pastCalcuMoney) {
		this.pastCalcuMoney = pastCalcuMoney;
	}
	public String getPastInvestDate() {
		return pastInvestDate;
	}
	public void setPastInvestDate(String pastInvestDate) {
		this.pastInvestDate = pastInvestDate;
	}
	public String getPastCash() {
		return pastCash;
	}
	public void setPastCash(String pastCash) {
		this.pastCash = pastCash;
	}
	public String getPastSecurity() {
		return pastSecurity;
	}
	public void setPastSecurity(String pastSecurity) {
		this.pastSecurity = pastSecurity;
	}
	public String getPastFlag() {
		return pastFlag;
	}
	public void setPastFlag(String pastFlag) {
		this.pastFlag = pastFlag;
	}
	public String getInvestMoneyTmp() {
		return investMoneyTmp;
	}
	public void setInvestMoneyTmp(String investMoneyTmp) {
		this.investMoneyTmp = investMoneyTmp;
	}
	public String getApplyFlag() {
		return applyFlag;
	}
	public void setApplyFlag(String applyFlag) {
		this.applyFlag = applyFlag;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getApplyPerSabun() {
		return applyPerSabun;
	}
	public void setApplyPerSabun(String applyPerSabun) {
		this.applyPerSabun = applyPerSabun;
	}
	public String getInvestMemoSeq() {
		return investMemoSeq;
	}
	public void setInvestMemoSeq(String investMemoSeq) {
		this.investMemoSeq = investMemoSeq;
	}
	public String getInvestMemo() {
		return investMemo;
	}
	public void setInvestMemo(String investMemo) {
		this.investMemo = investMemo;
	}
	public String getInSuCd() {
		return inSuCd;
	}
	public void setInSuCd(String inSuCd) {
		this.inSuCd = inSuCd;
	}
	public String getInSuNm() {
		return inSuNm;
	}
	public void setInSuNm(String inSuNm) {
		this.inSuNm = inSuNm;
	}
	public String getInSuCom() {
		return inSuCom;
	}
	public void setInSuCom(String inSuCom) {
		this.inSuCom = inSuCom;
	}
	public String getWarCateCd() {
		return warCateCd;
	}
	public void setWarCateCd(String warCateCd) {
		this.warCateCd = warCateCd;
	}
	public String getWarCateNm() {
		return warCateNm;
	}
	public void setWarCateNm(String warCateNm) {
		this.warCateNm = warCateNm;
	}
	public String getSecCateCd() {
		return secCateCd;
	}
	public void setSecCateCd(String secCateCd) {
		this.secCateCd = secCateCd;
	}
	public String getSecCateNm() {
		return secCateNm;
	}
	public void setSecCateNm(String secCateNm) {
		this.secCateNm = secCateNm;
	}
	public String getBondCateCd() {
		return bondCateCd;
	}
	public void setBondCateCd(String bondCateCd) {
		this.bondCateCd = bondCateCd;
	}
	public String getBondCateNm() {
		return bondCateNm;
	}
	public void setBondCateNm(String bondCateNm) {
		this.bondCateNm = bondCateNm;
	}
	public String getInSuChungDay() {
		return inSuChungDay;
	}
	public void setInSuChungDay(String inSuChungDay) {
		this.inSuChungDay = inSuChungDay;
	}
	public String getInSuNabDay() {
		return inSuNabDay;
	}
	public void setInSuNabDay(String inSuNabDay) {
		this.inSuNabDay = inSuNabDay;
	}
	public String getInSuSaChaeDay() {
		return inSuSaChaeDay;
	}
	public void setInSuSaChaeDay(String inSuSaChaeDay) {
		this.inSuSaChaeDay = inSuSaChaeDay;
	}
	public String getInSuExpiryRate() {
		return inSuExpiryRate;
	}
	public void setInSuExpiryRate(String inSuExpiryRate) {
		this.inSuExpiryRate = inSuExpiryRate;
	}
	public String getInSuRepayDay() {
		return inSuRepayDay;
	}
	public void setInSuRepayDay(String inSuRepayDay) {
		this.inSuRepayDay = inSuRepayDay;
	}
	public String getInSuRepayIza() {
		return inSuRepayIza;
	}
	public void setInSuRepayIza(String inSuRepayIza) {
		this.inSuRepayIza = inSuRepayIza;
	}
	public String getInSuRepayPeriod1() {
		return inSuRepayPeriod1;
	}
	public void setInSuRepayPeriod1(String inSuRepayPeriod1) {
		this.inSuRepayPeriod1 = inSuRepayPeriod1;
	}
	public String getInSuRepayPeriod2() {
		return inSuRepayPeriod2;
	}
	public void setInSuRepayPeriod2(String inSuRepayPeriod2) {
		this.inSuRepayPeriod2 = inSuRepayPeriod2;
	}
	public String getInSuRepayFlag() {
		return inSuRepayFlag;
	}
	public void setInSuRepayFlag(String inSuRepayFlag) {
		this.inSuRepayFlag = inSuRepayFlag;
	}
	public String getInSuRepayDate() {
		return inSuRepayDate;
	}
	public void setInSuRepayDate(String inSuRepayDate) {
		this.inSuRepayDate = inSuRepayDate;
	}
	public String getInSuRepayPerSabun() {
		return inSuRepayPerSabun;
	}
	public void setInSuRepayPerSabun(String inSuRepayPerSabun) {
		this.inSuRepayPerSabun = inSuRepayPerSabun;
	}
	public String getInSuRepayMethod() {
		return inSuRepayMethod;
	}
	public void setInSuRepayMethod(String inSuRepayMethod) {
		this.inSuRepayMethod = inSuRepayMethod;
	}
	public String getInSuRepayRate() {
		return inSuRepayRate;
	}
	public void setInSuRepayRate(String inSuRepayRate) {
		this.inSuRepayRate = inSuRepayRate;
	}
	public String getInSuIzaDay() {
		return inSuIzaDay;
	}
	public void setInSuIzaDay(String inSuIzaDay) {
		this.inSuIzaDay = inSuIzaDay;
	}
	public String getInSuIzaFlag() {
		return inSuIzaFlag;
	}
	public void setInSuIzaFlag(String inSuIzaFlag) {
		this.inSuIzaFlag = inSuIzaFlag;
	}
	public String getInSuIzaDate() {
		return inSuIzaDate;
	}
	public void setInSuIzaDate(String inSuIzaDate) {
		this.inSuIzaDate = inSuIzaDate;
	}
	public String getInSuIzaPerSabun() {
		return inSuIzaPerSabun;
	}
	public void setInSuIzaPerSabun(String inSuIzaPerSabun) {
		this.inSuIzaPerSabun = inSuIzaPerSabun;
	}
	public String getInSuSurfaceRate() {
		return inSuSurfaceRate;
	}
	public void setInSuSurfaceRate(String inSuSurfaceRate) {
		this.inSuSurfaceRate = inSuSurfaceRate;
	}
	public String getInSuSurfaceDay() {
		return inSuSurfaceDay;
	}
	public void setInSuSurfaceDay(String inSuSurfaceDay) {
		this.inSuSurfaceDay = inSuSurfaceDay;
	}
	public String getInSuFirstPrice() {
		return inSuFirstPrice;
	}
	public void setInSuFirstPrice(String inSuFirstPrice) {
		this.inSuFirstPrice = inSuFirstPrice;
	}
	public String getInSuBasePrice() {
		return inSuBasePrice;
	}
	public void setInSuBasePrice(String inSuBasePrice) {
		this.inSuBasePrice = inSuBasePrice;
	}
	public String getInSuRefixLimit() {
		return inSuRefixLimit;
	}
	public void setInSuRefixLimit(String inSuRefixLimit) {
		this.inSuRefixLimit = inSuRefixLimit;
	}
	public String getInSuRefixLimitPrice() {
		return inSuRefixLimitPrice;
	}
	public void setInSuRefixLimitPrice(String inSuRefixLimitPrice) {
		this.inSuRefixLimitPrice = inSuRefixLimitPrice;
	}
	public String getInSuNowPrice() {
		return inSuNowPrice;
	}
	public void setInSuNowPrice(String inSuNowPrice) {
		this.inSuNowPrice = inSuNowPrice;
	}
	public String getInSuRefixDay() {
		return inSuRefixDay;
	}
	public void setInSuRefixDay(String inSuRefixDay) {
		this.inSuRefixDay = inSuRefixDay;
	}
	public String getInSuRefixReason() {
		return inSuRefixReason;
	}
	public void setInSuRefixReason(String inSuRefixReason) {
		this.inSuRefixReason = inSuRefixReason;
	}
	public String getInSuRefixReasonCd() {
		return inSuRefixReasonCd;
	}
	public void setInSuRefixReasonCd(String inSuRefixReasonCd) {
		this.inSuRefixReasonCd = inSuRefixReasonCd;
	}
	public String getInSuRefixFlag() {
		return inSuRefixFlag;
	}
	public void setInSuRefixFlag(String inSuRefixFlag) {
		this.inSuRefixFlag = inSuRefixFlag;
	}
	public String getInSuRefixDate() {
		return inSuRefixDate;
	}
	public void setInSuRefixDate(String inSuRefixDate) {
		this.inSuRefixDate = inSuRefixDate;
	}
	public String getInSuRefixPerSabun() {
		return inSuRefixPerSabun;
	}
	public void setInSuRefixPerSabun(String inSuRefixPerSabun) {
		this.inSuRefixPerSabun = inSuRefixPerSabun;
	}
	public String getInSuRefixMethod() {
		return inSuRefixMethod;
	}
	public void setInSuRefixMethod(String inSuRefixMethod) {
		this.inSuRefixMethod = inSuRefixMethod;
	}
	public String getInSuClaimStart() {
		return inSuClaimStart;
	}
	public void setInSuClaimStart(String inSuClaimStart) {
		this.inSuClaimStart = inSuClaimStart;
	}
	public String getInSuClaimEnd() {
		return inSuClaimEnd;
	}
	public void setInSuClaimEnd(String inSuClaimEnd) {
		this.inSuClaimEnd = inSuClaimEnd;
	}
	public String getInSuClaimFlag() {
		return inSuClaimFlag;
	}
	public void setInSuClaimFlag(String inSuClaimFlag) {
		this.inSuClaimFlag = inSuClaimFlag;
	}
	public String getInSuClaimDate() {
		return inSuClaimDate;
	}
	public void setInSuClaimDate(String inSuClaimDate) {
		this.inSuClaimDate = inSuClaimDate;
	}
	public String getInSuClaimPerSabun() {
		return inSuClaimPerSabun;
	}
	public void setInSuClaimPerSabun(String inSuClaimPerSabun) {
		this.inSuClaimPerSabun = inSuClaimPerSabun;
	}
	public String getInSuBuyBack() {
		return inSuBuyBack;
	}
	public void setInSuBuyBack(String inSuBuyBack) {
		this.inSuBuyBack = inSuBuyBack;
	}
	public String getInSuBuyBackPre() {
		return inSuBuyBackPre;
	}
	public void setInSuBuyBackPre(String inSuBuyBackPre) {
		this.inSuBuyBackPre = inSuBuyBackPre;
	}
	public String getInSuCallOption() {
		return inSuCallOption;
	}
	public void setInSuCallOption(String inSuCallOption) {
		this.inSuCallOption = inSuCallOption;
	}
	public String getInSuYtc() {
		return inSuYtc;
	}
	public void setInSuYtc(String inSuYtc) {
		this.inSuYtc = inSuYtc;
	}
	public String getInSuCallStart() {
		return inSuCallStart;
	}
	public void setInSuCallStart(String inSuCallStart) {
		this.inSuCallStart = inSuCallStart;
	}
	public String getInSuCallEnd() {
		return inSuCallEnd;
	}
	public void setInSuCallEnd(String inSuCallEnd) {
		this.inSuCallEnd = inSuCallEnd;
	}
	public String getInSuOutMoney() {
		return inSuOutMoney;
	}
	public void setInSuOutMoney(String inSuOutMoney) {
		this.inSuOutMoney = inSuOutMoney;
	}
	public String getInSuSumMoney() {
		return inSuSumMoney;
	}
	public void setInSuSumMoney(String inSuSumMoney) {
		this.inSuSumMoney = inSuSumMoney;
	}
	public String getInSuBondForm() {
		return inSuBondForm;
	}
	public void setInSuBondForm(String inSuBondForm) {
		this.inSuBondForm = inSuBondForm;
	}
	public String getInSuWar() {
		return inSuWar;
	}
	public void setInSuWar(String inSuWar) {
		this.inSuWar = inSuWar;
	}
	public String getSecTotalCnt() {
		return secTotalCnt;
	}
	public void setSecTotalCnt(String secTotalCnt) {
		this.secTotalCnt = secTotalCnt;
	}
	public String getSecShare() {
		return secShare;
	}
	public void setSecShare(String secShare) {
		this.secShare = secShare;
	}
	public String getOwnWar() {
		return ownWar;
	}
	public void setOwnWar(String ownWar) {
		this.ownWar = ownWar;
	}
	public String getAlarmDate1() {
		return alarmDate1;
	}
	public void setAlarmDate1(String alarmDate1) {
		this.alarmDate1 = alarmDate1;
	}
	public String getAlarmDate2() {
		return alarmDate2;
	}
	public void setAlarmDate2(String alarmDate2) {
		this.alarmDate2 = alarmDate2;
	}
	public String getRefixDateTmp() {
		return refixDateTmp;
	}
	public void setRefixDateTmp(String refixDateTmp) {
		this.refixDateTmp = refixDateTmp;
	}
	public String getInSuNowPriceTmp() {
		return inSuNowPriceTmp;
	}
	public void setInSuNowPriceTmp(String inSuNowPriceTmp) {
		this.inSuNowPriceTmp = inSuNowPriceTmp;
	}
	public String getInSuRefixSeq() {
		return inSuRefixSeq;
	}
	public void setInSuRefixSeq(String inSuRefixSeq) {
		this.inSuRefixSeq = inSuRefixSeq;
	}
	public String getInSuRefixPrice() {
		return inSuRefixPrice;
	}
	public void setInSuRefixPrice(String inSuRefixPrice) {
		this.inSuRefixPrice = inSuRefixPrice;
	}
	public String getMailPassType() {
		return mailPassType;
	}
	public void setMailPassType(String mailPassType) {
		this.mailPassType = mailPassType;
	}
	public String getHomeViewFlag() {
		return homeViewFlag;
	}
	public void setHomeViewFlag(String homeViewFlag) {
		this.homeViewFlag = homeViewFlag;
	}
	public String getHomeViewFlagNm() {
		return homeViewFlagNm;
	}
	public void setHomeViewFlagNm(String homeViewFlagNm) {
		this.homeViewFlagNm = homeViewFlagNm;
	}
	public String getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	public String getWarGrpCd() {
		return warGrpCd;
	}
	public void setWarGrpCd(String warGrpCd) {
		this.warGrpCd = warGrpCd;
	}
	public String getWarCd() {
		return warCd;
	}
	public void setWarCd(String warCd) {
		this.warCd = warCd;
	}
	public String getWarMoney() {
		return warMoney;
	}
	public void setWarMoney(String warMoney) {
		this.warMoney = warMoney;
	}
	public String getWarSeqNum() {
		return warSeqNum;
	}
	public void setWarSeqNum(String warSeqNum) {
		this.warSeqNum = warSeqNum;
	}
	public String getWarSetFlag() {
		return warSetFlag;
	}
	public void setWarSetFlag(String warSetFlag) {
		this.warSetFlag = warSetFlag;
	}
	public String getBondGrpCd() {
		return bondGrpCd;
	}
	public void setBondGrpCd(String bondGrpCd) {
		this.bondGrpCd = bondGrpCd;
	}
	public String getBondCd() {
		return bondCd;
	}
	public void setBondCd(String bondCd) {
		this.bondCd = bondCd;
	}
	public String getBondMoney() {
		return bondMoney;
	}
	public void setBondMoney(String bondMoney) {
		this.bondMoney = bondMoney;
	}
	public String getBondSeqNum() {
		return bondSeqNum;
	}
	public void setBondSeqNum(String bondSeqNum) {
		this.bondSeqNum = bondSeqNum;
	}
	public String getBondSetFlag() {
		return bondSetFlag;
	}
	public void setBondSetFlag(String bondSetFlag) {
		this.bondSetFlag = bondSetFlag;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getFileFlag() {
		return fileFlag;
	}
	public void setFileFlag(String fileFlag) {
		this.fileFlag = fileFlag;
	}
	public String getBondCusSeq() {
		return bondCusSeq;
	}
	public void setBondCusSeq(String bondCusSeq) {
		this.bondCusSeq = bondCusSeq;
	}
	public String getTargetMoney() {
		return targetMoney;
	}
	public void setTargetMoney(String targetMoney) {
		this.targetMoney = targetMoney;
	}
	public String getToDoSellDay() {
		return toDoSellDay;
	}
	public void setToDoSellDay(String toDoSellDay) {
		this.toDoSellDay = toDoSellDay;
	}
	public String getExtraPeriod() {
		return extraPeriod;
	}
	public void setExtraPeriod(String extraPeriod) {
		this.extraPeriod = extraPeriod;
	}
	public String getExtraDay() {
		return extraDay;
	}
	public void setExtraDay(String extraDay) {
		this.extraDay = extraDay;
	}
	public String getRepayMoney() {
		return repayMoney;
	}
	public void setRepayMoney(String repayMoney) {
		this.repayMoney = repayMoney;
	}
	public String getPeriodIza() {
		return periodIza;
	}
	public void setPeriodIza(String periodIza) {
		this.periodIza = periodIza;
	}
	public String getSumReturnMoney() {
		return sumReturnMoney;
	}
	public void setSumReturnMoney(String sumReturnMoney) {
		this.sumReturnMoney = sumReturnMoney;
	}
	public String getReqReturnRate() {
		return reqReturnRate;
	}
	public void setReqReturnRate(String reqReturnRate) {
		this.reqReturnRate = reqReturnRate;
	}
	public String getDealPrice() {
		return dealPrice;
	}
	public void setDealPrice(String dealPrice) {
		this.dealPrice = dealPrice;
	}
	public String getDealPriceOpt() {
		return dealPriceOpt;
	}
	public void setDealPriceOpt(String dealPriceOpt) {
		this.dealPriceOpt = dealPriceOpt;
	}
	public String getDealPriceOptNm() {
		return dealPriceOptNm;
	}
	public void setDealPriceOptNm(String dealPriceOptNm) {
		this.dealPriceOptNm = dealPriceOptNm;
	}
	public String getDealMoney() {
		return dealMoney;
	}
	public void setDealMoney(String dealMoney) {
		this.dealMoney = dealMoney;
	}
	public String getDealMoneyOpt() {
		return dealMoneyOpt;
	}
	public void setDealMoneyOpt(String dealMoneyOpt) {
		this.dealMoneyOpt = dealMoneyOpt;
	}
	public String getDealMoneyOptNm() {
		return dealMoneyOptNm;
	}
	public void setDealMoneyOptNm(String dealMoneyOptNm) {
		this.dealMoneyOptNm = dealMoneyOptNm;
	}
	public String getDealTax() {
		return dealTax;
	}
	public void setDealTax(String dealTax) {
		this.dealTax = dealTax;
	}
	public String getRealDealMoney() {
		return realDealMoney;
	}
	public void setRealDealMoney(String realDealMoney) {
		this.realDealMoney = realDealMoney;
	}
	public String getAssureFlag() {
		return assureFlag;
	}
	public void setAssureFlag(String assureFlag) {
		this.assureFlag = assureFlag;
	}
	public String getAssureFlagNm() {
		return assureFlagNm;
	}
	public void setAssureFlagNm(String assureFlagNm) {
		this.assureFlagNm = assureFlagNm;
	}
	public String getWithHoldingFlag() {
		return withHoldingFlag;
	}
	public void setWithHoldingFlag(String withHoldingFlag) {
		this.withHoldingFlag = withHoldingFlag;
	}
	public String getPutEventDay() {
		return putEventDay;
	}
	public void setPutEventDay(String putEventDay) {
		this.putEventDay = putEventDay;
	}
	public String getPutCycle() {
		return putCycle;
	}
	public void setPutCycle(String putCycle) {
		this.putCycle = putCycle;
	}
	public String getPutEventFlag() {
		return putEventFlag;
	}
	public void setPutEventFlag(String putEventFlag) {
		this.putEventFlag = putEventFlag;
	}
	public String getEventTargetMoney() {
		return eventTargetMoney;
	}
	public void setEventTargetMoney(String eventTargetMoney) {
		this.eventTargetMoney = eventTargetMoney;
	}
	public String getBondEventSeq() {
		return bondEventSeq;
	}
	public void setBondEventSeq(String bondEventSeq) {
		this.bondEventSeq = bondEventSeq;
	}
	public String getBuyMoney() {
		return buyMoney;
	}
	public void setBuyMoney(String buyMoney) {
		this.buyMoney = buyMoney;
	}
	public String getBuyDay() {
		return buyDay;
	}
	public void setBuyDay(String buyDay) {
		this.buyDay = buyDay;
	}
	public String getSellDay() {
		return sellDay;
	}
	public void setSellDay(String sellDay) {
		this.sellDay = sellDay;
	}
	public String getPassPeriod() {
		return passPeriod;
	}
	public void setPassPeriod(String passPeriod) {
		this.passPeriod = passPeriod;
	}
	public String getReportCd() {
		return reportCd;
	}
	public void setReportCd(String reportCd) {
		this.reportCd = reportCd;
	}
	public String getReportSDate() {
		return reportSDate;
	}
	public void setReportSDate(String reportSDate) {
		this.reportSDate = reportSDate;
	}
	public String getReportEDate() {
		return reportEDate;
	}
	public void setReportEDate(String reportEDate) {
		this.reportEDate = reportEDate;
	}
	public String getImpDate() {
		return impDate;
	}
	public void setImpDate(String impDate) {
		this.impDate = impDate;
	}
	public String getChargeFlag() {
		return chargeFlag;
	}
	public void setChargeFlag(String chargeFlag) {
		this.chargeFlag = chargeFlag;
	}
	public String getChargeMoney() {
		return chargeMoney;
	}
	public void setChargeMoney(String chargeMoney) {
		this.chargeMoney = chargeMoney;
	}
	public String getPayLimit() {
		return payLimit;
	}
	public void setPayLimit(String payLimit) {
		this.payLimit = payLimit;
	}
	public String getPayFlag() {
		return payFlag;
	}
	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}
	public String getCalcuInfo() {
		return calcuInfo;
	}
	public void setCalcuInfo(String calcuInfo) {
		this.calcuInfo = calcuInfo;
	}
	public String getSecInfo() {
		return secInfo;
	}
	public void setSecInfo(String secInfo) {
		this.secInfo = secInfo;
	}
	public String getManaInfo() {
		return manaInfo;
	}
	public void setManaInfo(String manaInfo) {
		this.manaInfo = manaInfo;
	}
	public String getAccMoney() {
		return accMoney;
	}
	public void setAccMoney(String accMoney) {
		this.accMoney = accMoney;
	}
	public String getPeriodMoney() {
		return periodMoney;
	}
	public void setPeriodMoney(String periodMoney) {
		this.periodMoney = periodMoney;
	}
	public String getStartValue() {
		return startValue;
	}
	public void setStartValue(String startValue) {
		this.startValue = startValue;
	}
	public String getStartCash() {
		return startCash;
	}
	public void setStartCash(String startCash) {
		this.startCash = startCash;
	}
	public String getStartSec() {
		return startSec;
	}
	public void setStartSec(String startSec) {
		this.startSec = startSec;
	}
	public String getEndValue() {
		return endValue;
	}
	public void setEndValue(String endValue) {
		this.endValue = endValue;
	}
	public String getEndCash() {
		return endCash;
	}
	public void setEndCash(String endCash) {
		this.endCash = endCash;
	}
	public String getEndSec() {
		return endSec;
	}
	public void setEndSec(String endSec) {
		this.endSec = endSec;
	}
	public String getCommitFlag() {
		return commitFlag;
	}
	public void setCommitFlag(String commitFlag) {
		this.commitFlag = commitFlag;
	}
	public String getCommitDate() {
		return commitDate;
	}
	public void setCommitDate(String commitDate) {
		this.commitDate = commitDate;
	}
	public String getCommitPerSabun() {
		return commitPerSabun;
	}
	public void setCommitPerSabun(String commitPerSabun) {
		this.commitPerSabun = commitPerSabun;
	}
	public String getCalcuAddMoney() {
		return calcuAddMoney;
	}
	public void setCalcuAddMoney(String calcuAddMoney) {
		this.calcuAddMoney = calcuAddMoney;
	}
	public String getMailCd() {
		return mailCd;
	}
	public void setMailCd(String mailCd) {
		this.mailCd = mailCd;
	}
	public String getMailTitle() {
		return mailTitle;
	}
	public void setMailTitle(String mailTitle) {
		this.mailTitle = mailTitle;
	}
	public String getMailCon() {
		return mailCon;
	}
	public void setMailCon(String mailCon) {
		this.mailCon = mailCon;
	}
	public String getMailFileFlag() {
		return mailFileFlag;
	}
	public void setMailFileFlag(String mailFileFlag) {
		this.mailFileFlag = mailFileFlag;
	}
	public String getMailRePerNm() {
		return mailRePerNm;
	}
	public void setMailRePerNm(String mailRePerNm) {
		this.mailRePerNm = mailRePerNm;
	}
	public String getMailRePerEmail() {
		return mailRePerEmail;
	}
	public void setMailRePerEmail(String mailRePerEmail) {
		this.mailRePerEmail = mailRePerEmail;
	}
	public String getMailSePerSabun() {
		return mailSePerSabun;
	}
	public void setMailSePerSabun(String mailSePerSabun) {
		this.mailSePerSabun = mailSePerSabun;
	}
	public String getMailSePerNm() {
		return mailSePerNm;
	}
	public void setMailSePerNm(String mailSePerNm) {
		this.mailSePerNm = mailSePerNm;
	}
	public String getMailSePerEmail() {
		return mailSePerEmail;
	}
	public void setMailSePerEmail(String mailSePerEmail) {
		this.mailSePerEmail = mailSePerEmail;
	}
	public String getMailSendDate() {
		return mailSendDate;
	}
	public void setMailSendDate(String mailSendDate) {
		this.mailSendDate = mailSendDate;
	}
	public String getMailKey() {
		return mailKey;
	}
	public void setMailKey(String mailKey) {
		this.mailKey = mailKey;
	}
	public String getMailOpenFlag() {
		return mailOpenFlag;
	}
	public void setMailOpenFlag(String mailOpenFlag) {
		this.mailOpenFlag = mailOpenFlag;
	}
	public String getInvestOfferCd() {
		return investOfferCd;
	}
	public void setInvestOfferCd(String investOfferCd) {
		this.investOfferCd = investOfferCd;
	}
	public String getInvestOfferNm() {
		return investOfferNm;
	}
	public void setInvestOfferNm(String investOfferNm) {
		this.investOfferNm = investOfferNm;
	}
	public String getInvestOfferCon() {
		return investOfferCon;
	}
	public void setInvestOfferCon(String investOfferCon) {
		this.investOfferCon = investOfferCon;
	}
	public String getInvestOfferMoney() {
		return investOfferMoney;
	}
	public void setInvestOfferMoney(String investOfferMoney) {
		this.investOfferMoney = investOfferMoney;
	}
	public String getMailingViewFlag() {
		return mailingViewFlag;
	}
	public void setMailingViewFlag(String mailingViewFlag) {
		this.mailingViewFlag = mailingViewFlag;
	}
	public String getHiddenFlag() {
		return hiddenFlag;
	}
	public void setHiddenFlag(String hiddenFlag) {
		this.hiddenFlag = hiddenFlag;
	}
	public int getViewOrder() {
		return viewOrder;
	}
	public void setViewOrder(int viewOrder) {
		this.viewOrder = viewOrder;
	}
	public String getScheSeq() {
		return scheSeq;
	}
	public void setScheSeq(String scheSeq) {
		this.scheSeq = scheSeq;
	}
	public String getDivOfferCd() {
		return divOfferCd;
	}
	public void setDivOfferCd(String divOfferCd) {
		this.divOfferCd = divOfferCd;
	}
	public String getDivOfferMoney() {
		return divOfferMoney;
	}
	public void setDivOfferMoney(String divOfferMoney) {
		this.divOfferMoney = divOfferMoney;
	}
	public String getInvestOfferFlag() {
		return investOfferFlag;
	}
	public void setInvestOfferFlag(String investOfferFlag) {
		this.investOfferFlag = investOfferFlag;
	}
	public String getDivConfirmFlag() {
		return divConfirmFlag;
	}
	public void setDivConfirmFlag(String divConfirmFlag) {
		this.divConfirmFlag = divConfirmFlag;
	}
	public String getDivInMoneyFlag() {
		return divInMoneyFlag;
	}
	public void setDivInMoneyFlag(String divInMoneyFlag) {
		this.divInMoneyFlag = divInMoneyFlag;
	}
	public String getOfferMemoSeq() {
		return offerMemoSeq;
	}
	public void setOfferMemoSeq(String offerMemoSeq) {
		this.offerMemoSeq = offerMemoSeq;
	}
	public String getOfferMemo() {
		return offerMemo;
	}
	public void setOfferMemo(String offerMemo) {
		this.offerMemo = offerMemo;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public String getEventTypeTmp() {
		return eventTypeTmp;
	}
	public void setEventTypeTmp(String eventTypeTmp) {
		this.eventTypeTmp = eventTypeTmp;
	}
	public String getReadFlag() {
		return readFlag;
	}
	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
	public String getMenuCon() {
		return menuCon;
	}
	public void setMenuCon(String menuCon) {
		this.menuCon = menuCon;
	}
	public String getRegPerNm() {
		return regPerNm;
	}
	public void setRegPerNm(String regPerNm) {
		this.regPerNm = regPerNm;
	}
	public String getNowSumMoney() {
		return nowSumMoney;
	}
	public void setNowSumMoney(String nowSumMoney) {
		this.nowSumMoney = nowSumMoney;
	}
	public String getAccPer() {
		return accPer;
	}
	public void setAccPer(String accPer) {
		this.accPer = accPer;
	}
	public String getAddAvgPer() {
		return addAvgPer;
	}
	public void setAddAvgPer(String addAvgPer) {
		this.addAvgPer = addAvgPer;
	}
	public String getRealNowCash() {
		return realNowCash;
	}
	public void setRealNowCash(String realNowCash) {
		this.realNowCash = realNowCash;
	}
	public String getWarSecurity() {
		return warSecurity;
	}
	public void setWarSecurity(String warSecurity) {
		this.warSecurity = warSecurity;
	}
	public String getNowTotalSumMoney() {
		return nowTotalSumMoney;
	}
	public void setNowTotalSumMoney(String nowTotalSumMoney) {
		this.nowTotalSumMoney = nowTotalSumMoney;
	}
	public String getAddAvgPeriod() {
		return addAvgPeriod;
	}
	public void setAddAvgPeriod(String addAvgPeriod) {
		this.addAvgPeriod = addAvgPeriod;
	}
	public String getHdnAccPer() {
		return hdnAccPer;
	}
	public void setHdnAccPer(String hdnAccPer) {
		this.hdnAccPer = hdnAccPer;
	}
	public String getHdnAddAvgPer() {
		return hdnAddAvgPer;
	}
	public void setHdnAddAvgPer(String hdnAddAvgPer) {
		this.hdnAddAvgPer = hdnAddAvgPer;
	}
	public String getWriteCd() {
		return writeCd;
	}
	public void setWriteCd(String writeCd) {
		this.writeCd = writeCd;
	}
	public String getWriteTitle() {
		return writeTitle;
	}
	public void setWriteTitle(String writeTitle) {
		this.writeTitle = writeTitle;
	}
	public String getWriteCon() {
		return writeCon;
	}
	public void setWriteCon(String writeCon) {
		this.writeCon = writeCon;
	}
	public String getWritePerNm() {
		return writePerNm;
	}
	public void setWritePerNm(String writePerNm) {
		this.writePerNm = writePerNm;
	}
	public String getWritePerSabun() {
		return writePerSabun;
	}
	public void setWritePerSabun(String writePerSabun) {
		this.writePerSabun = writePerSabun;
	}
	public String getWritePW() {
		return writePW;
	}
	public void setWritePW(String writePW) {
		this.writePW = writePW;
	}
	public String getReplyCd() {
		return replyCd;
	}
	public void setReplyCd(String replyCd) {
		this.replyCd = replyCd;
	}
	public String getReplyCon() {
		return replyCon;
	}
	public void setReplyCon(String replyCon) {
		this.replyCon = replyCon;
	}
	public String getReplyPerSabun() {
		return replyPerSabun;
	}
	public void setReplyPerSabun(String replyPerSabun) {
		this.replyPerSabun = replyPerSabun;
	}
	public String getReplyPerNm() {
		return replyPerNm;
	}
	public void setReplyPerNm(String replyPerNm) {
		this.replyPerNm = replyPerNm;
	}
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public int getSmsSeq() {
		return smsSeq;
	}
	public void setSmsSeq(int smsSeq) {
		this.smsSeq = smsSeq;
	}
	public String getSmsTitle() {
		return smsTitle;
	}
	public void setSmsTitle(String smsTitle) {
		this.smsTitle = smsTitle;
	}
	public String getSmsType() {
		return smsType;
	}
	public void setSmsType(String smsType) {
		this.smsType = smsType;
	}
	public String getSmsToNum() {
		return smsToNum;
	}
	public void setSmsToNum(String smsToNum) {
		this.smsToNum = smsToNum;
	}
	public String getSmsFromNum() {
		return smsFromNum;
	}
	public void setSmsFromNum(String smsFromNum) {
		this.smsFromNum = smsFromNum;
	}
	public String getSmsContent() {
		return smsContent;
	}
	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}
	public String getSmsReserTime() {
		return smsReserTime;
	}
	public void setSmsReserTime(String smsReserTime) {
		this.smsReserTime = smsReserTime;
	}
	public String getSmsSendTime() {
		return smsSendTime;
	}
	public void setSmsSendTime(String smsSendTime) {
		this.smsSendTime = smsSendTime;
	}
	public String getSmsEndTime() {
		return smsEndTime;
	}
	public void setSmsEndTime(String smsEndTime) {
		this.smsEndTime = smsEndTime;
	}
	public String getSmsSendFlag() {
		return smsSendFlag;
	}
	public void setSmsSendFlag(String smsSendFlag) {
		this.smsSendFlag = smsSendFlag;
	}
	public String getSmsFlag() {
		return smsFlag;
	}
	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}
	public String getIsicCd() {
		return isicCd;
	}
	public void setIsicCd(String isicCd) {
		this.isicCd = isicCd;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}

	///////////////////////////////////////////////////////////////////////

}