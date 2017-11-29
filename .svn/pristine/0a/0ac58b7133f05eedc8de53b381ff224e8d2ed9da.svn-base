package ib.schedule.service;

import java.io.Serializable;

import ib.basic.service.BaseVo;

@SuppressWarnings("serial")
public class SpCmmVO extends BaseVo implements Serializable {
	private String searchCondition 		= "";	// 검색조건
	private String searchKeyword 		= "";	// 검색어
	private String searchUseYn			= "";	// 검색어 사용여부
	private String infoMessage			= "";	// 경고문구
	private String docType				= "";	// 문서 타입
	private String docNm				= "";	// 문서 이름
	private String docPage				= "";	// 문서 페이지

	private int pageIndex				= 1;	// 현재페이지
    private int pageUnit				= 5;	// 페이지갯수
    private int pageSize				= 1;	// 페이지 사이즈
    private int firstIndex				= 1;	// firstIndex
    private int lastIndex				= 1;	// lastIndex
    private int recordCountPerPage		= 1;	// recordCountPerPage
    private int seq;							// 페이징서 순번

    private String orderFlag			= "";	// 정렬객체 문자, 숫자구분
    private String orderType			= "";	// 정렬타입
    private String orderKey				= "";	// 정렬기준
    private String orderObj				= "";	// 정렬객체
    private String orderObjNm			= "";	// 정렬객체명

    private String zipCode				= "";	// 우편번호
    private String sido					= "";	// 특별시,광역시,도
    private String gugun				= "";	// 시,군,구
    private String dong					= "";	// 읍,면,동,리,건물명
    private String bunji				= "";	// 번지,아파트동,호수
    private String zipCodeSeq			= "";	// 데이터 순서

    private String cellColor			= "onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#FFFFFF';\"";						// 일임
    private String cellColor2			= "bgcolor=\"#EAEAEA\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#EAEAEA';\"";	// 일임외
    private String notCellColor			= "bgcolor=\"#F9BBBB\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#F9BBBB';\"";	// 일임 거래 해지
    private String noneCellColor		= "bgcolor=\"#FEEFDE\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#FEEFDE';\"";	// 일임 거래 미등록
    private String hopeCellColor		= "bgcolor=\"#B8FCFA\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#B8FCFA';\"";	// 잠재
    private String etcCellColor			= "bgcolor=\"#DDEEFF\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#DDEEFF';\"";	// 기타
    private String sellCellColor		= "bgcolor=\"#C2C2C2\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#C2C2C2';\"";	// 매각
    private String joinCellColor		= "bgcolor=\"#AEAED7\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#AEAED7';\"";	// 공동투자고객
    private String jamunCellColor		= "bgcolor=\"#FFE0C1\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#FFE0C1';\"";	// 자문고객


	private String claimColor			= "bgcolor=\"#E9FEF5\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#E9FEF5';\"";	// 투자개요 행사가능
	private String callOptionColor		= "bgcolor=\"#8EC5D4\" onmouseover=\"this.style.background='#FEFFD5';\" onmouseout=\"this.style.background='#8EC5D4';\"";	// 투자개요 콜옵션 행사일 해당

	private String numOpt				= "size=\"14\" style=\"text-align:right;\" onkeyup=\"NumFormat(this.name, this.value);\"";
	private String numOpt_S				= "size=\"10\" style=\"text-align:right;\" onkeyup=\"NumFormat(this.name, this.value);\"";
	private String dateOpt				= "size=\"12\" maxlength=\"10\" onkeyup=\"DateFormat(this.name, this.value);\"";

//	private String DivFix				= "style=\"height:100%;overflow:auto;scrollbar-face-color:#DADFE4;scrollbar-highlight-color:#FFFFFF;scrollbar-3dlight-color:#AEBACB;scrollbar-shadow-color:#7B8DA5;scrollbar-darkshadow-color:white;scrollbar-track-color:WHITE;scrollbar-arrow-color:white;\"";
	private String divFix				= "style=\"height:100%;overflow:auto;\"";
	private String baseFocus			= "onfocusin=\"BaseInFocus(this.id);\" onfocusout=\"BaseOutFocus(this.id);\"";
	private String focus				= "onfocusin=\"InFocus(this.id);\" onfocusout=\"OutFocus(this.id);\"";

	private int nowYear					= 0;	// 현재년
	private int nowMonth				= 0;	// 현재월
	private int nowDay					= 0;	// 현재일
	private String nowWeek			= "";	// 현재요일
	private int selYear					= 0;	// 선택년
	private int selMonth				= 0;	// 선택월
	private int selDay					= 0;	// 선택일
	private int startDay				= 1;	// 해당월의 시작일
	private int endDay					= 0;	// 해당월의 마지막일
	private String startWeek			= "";	// 해당월의 시작일 요일
	private String endWeek			= "";	// 해당월의 마지막일 요일
	private int startPosition			= 0;	// 해당월의 시작일의 위치
	private int endPosition				= 0;	// 해당월의 마지막일 위치
	private int preYear					= 0;	// 전년
	private int preMonth				= 0;	// 전월
	private int nextYear				= 0;	// 후년
	private int nextMonth				= 0;	// 후월

	private String selDate				= "";	// 선택년월일
	private String searchSDate			= "";	// 검색 시작일
	private String searchEDate			= "";	// 검색 종료일
	private String objNm				= "";	// 객체이름
	private String submitFlag			= "";	// 달력 선택후 서브밋 여부
	private String regPerSabun			= "";

	private String mailTemp				= "<img src=\"http://106.250.177.91:8280/SynergyCus/images/sp/report/ReportBottom.gif\" width=\"250\" border=\"0\" alt=\"시너지 투자자문(주)\"><div style=\"border:3px solid #b4cef3;border-radius:10px;width:40%;min-width:700px;padding:10px;line-height:20pt;font-weight:bold;font-size:12pt;font-family:맑은 고딕, Verdana, Geneva, sans-serif;\">";


	public String getSearchCondition() {return searchCondition;}
	public void setSearchCondition(String searchCondition) {this.searchCondition = searchCondition;}

	public String getSearchKeyword() {return searchKeyword;}
	public void setSearchKeyword(String searchKeyword) {this.searchKeyword = searchKeyword;}

	public String getSearchUseYn() {return searchUseYn;}
	public void setSearchUseYn(String searchUseYn) {this.searchUseYn = searchUseYn;}

	public int getPageIndex() {return pageIndex;}
	public void setPageIndex(int pageIndex) {this.pageIndex = pageIndex;}

	public int getPageUnit() {return pageUnit;}
	public void setPageUnit(int pageUnit) {this.pageUnit = pageUnit;}

	public int getPageSize() {return pageSize;}
	public void setPageSize(int pageSize) {this.pageSize = pageSize;}

	public int getFirstIndex() {return firstIndex;}
	public void setFirstIndex(int firstIndex) {this.firstIndex = firstIndex;}

	public int getLastIndex() {return lastIndex;}
	public void setLastIndex(int lastIndex) {this.lastIndex = lastIndex;}

	public int getRecordCountPerPage() {return recordCountPerPage;}
	public void setRecordCountPerPage(int recordCountPerPage) {this.recordCountPerPage = recordCountPerPage;}

	public int getSeq() {return seq;}
	public void setSeq(int seq) {this.seq = seq;}


	public String getInfoMessage() {
		return infoMessage;
	}
	public void setInfoMessage(String infoMessage) {
		this.infoMessage = infoMessage;
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
	public String getOrderObj() {
		return orderObj;
	}
	public void setOrderObj(String orderObj) {
		this.orderObj = orderObj;
	}
	public String getOrderObjNm() {
		return orderObjNm;
	}
	public void setOrderObjNm(String orderObjNm) {
		this.orderObjNm = orderObjNm;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getBunji() {
		return bunji;
	}
	public void setBunji(String bunji) {
		this.bunji = bunji;
	}
	public String getZipCodeSeq() {
		return zipCodeSeq;
	}
	public void setZipCodeSeq(String zipCodeSeq) {
		this.zipCodeSeq = zipCodeSeq;
	}
	public String getCellColor() {
		return cellColor;
	}
	public void setCellColor(String cellColor) {
		this.cellColor = cellColor;
	}
	public String getCellColor2() {
		return cellColor2;
	}
	public void setCellColor2(String cellColor2) {
		this.cellColor2 = cellColor2;
	}
	public String getNotCellColor() {
		return notCellColor;
	}
	public void setNotCellColor(String notCellColor) {
		this.notCellColor = notCellColor;
	}
	public String getNoneCellColor() {
		return noneCellColor;
	}
	public void setNoneCellColor(String noneCellColor) {
		this.noneCellColor = noneCellColor;
	}
	public String getHopeCellColor() {
		return hopeCellColor;
	}
	public void setHopeCellColor(String hopeCellColor) {
		this.hopeCellColor = hopeCellColor;
	}
	public String getEtcCellColor() {
		return etcCellColor;
	}
	public void setEtcCellColor(String etcCellColor) {
		this.etcCellColor = etcCellColor;
	}
	public String getSellCellColor() {
		return sellCellColor;
	}
	public void setSellCellColor(String sellCellColor) {
		this.sellCellColor = sellCellColor;
	}
	public String getJoinCellColor() {
		return joinCellColor;
	}
	public void setJoinCellColor(String joinCellColor) {
		this.joinCellColor = joinCellColor;
	}
	public String getJamunCellColor() {
		return jamunCellColor;
	}
	public void setJamunCellColor(String jamunCellColor) {
		this.jamunCellColor = jamunCellColor;
	}
	public String getClaimColor() {
		return claimColor;
	}
	public void setClaimColor(String claimColor) {
		this.claimColor = claimColor;
	}
	public String getCallOptionColor() {
		return callOptionColor;
	}
	public void setCallOptionColor(String callOptionColor) {
		this.callOptionColor = callOptionColor;
	}
	public String getNumOpt() {
		return numOpt;
	}
	public void setNumOpt(String numOpt) {
		this.numOpt = numOpt;
	}
	public String getNumOpt_S() {
		return numOpt_S;
	}
	public void setNumOpt_S(String numOpt_S) {
		this.numOpt_S = numOpt_S;
	}
	public String getDateOpt() {
		return dateOpt;
	}
	public void setDateOpt(String dateOpt) {
		this.dateOpt = dateOpt;
	}
	public String getDivFix() {
		return divFix;
	}
	public void setDivFix(String divFix) {
		this.divFix = divFix;
	}
	public String getBaseFocus() {
		return baseFocus;
	}
	public void setBaseFocus(String baseFocus) {
		this.baseFocus = baseFocus;
	}
	public String getFocus() {
		return focus;
	}
	public void setFocus(String focus) {
		this.focus = focus;
	}
	public int getNowYear() {
		return nowYear;
	}
	public void setNowYear(int nowYear) {
		this.nowYear = nowYear;
	}
	public int getNowMonth() {
		return nowMonth;
	}
	public void setNowMonth(int nowMonth) {
		this.nowMonth = nowMonth;
	}
	public int getNowDay() {
		return nowDay;
	}
	public void setNowDay(int nowDay) {
		this.nowDay = nowDay;
	}
	public int getSelYear() {
		return selYear;
	}
	public void setSelYear(int selYear) {
		this.selYear = selYear;
	}
	public int getSelMonth() {
		return selMonth;
	}
	public void setSelMonth(int selMonth) {
		this.selMonth = selMonth;
	}
	public int getSelDay() {
		return selDay;
	}
	public void setSelDay(int selDay) {
		this.selDay = selDay;
	}
	public int getStartDay() {
		return startDay;
	}
	public void setStartDay(int startDay) {
		this.startDay = startDay;
	}
	public int getEndDay() {
		return endDay;
	}
	public void setEndDay(int endDay) {
		this.endDay = endDay;
	}
	public int getStartPosition() {
		return startPosition;
	}
	public void setStartPosition(int startPosition) {
		this.startPosition = startPosition;
	}
	public int getEndPosition() {
		return endPosition;
	}
	public void setEndPosition(int endPosition) {
		this.endPosition = endPosition;
	}
	public int getPreYear() {
		return preYear;
	}
	public void setPreYear(int preYear) {
		this.preYear = preYear;
	}
	public int getPreMonth() {
		return preMonth;
	}
	public void setPreMonth(int preMonth) {
		this.preMonth = preMonth;
	}
	public int getNextYear() {
		return nextYear;
	}
	public void setNextYear(int nextYear) {
		this.nextYear = nextYear;
	}
	public int getNextMonth() {
		return nextMonth;
	}
	public void setNextMonth(int nextMonth) {
		this.nextMonth = nextMonth;
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
	public String getObjNm() {
		return objNm;
	}
	public void setObjNm(String objNm) {
		this.objNm = objNm;
	}
	public String getSubmitFlag() {
		return submitFlag;
	}
	public void setSubmitFlag(String submitFlag) {
		this.submitFlag = submitFlag;
	}
	public String getRegPerSabun() {
		return regPerSabun;
	}
	public void setRegPerSabun(String regPerSabun) {
		this.regPerSabun = regPerSabun;
	}
	public String getMailTemp() {
		return mailTemp;
	}
	public void setMailTemp(String mailTemp) {
		this.mailTemp = mailTemp;
	}
	public String getNowWeek() {
		return nowWeek;
	}
	public void setNowWeek(String nowWeek) {
		this.nowWeek = nowWeek;
	}
	public String getStartWeek() {
		return startWeek;
	}
	public void setStartWeek(String startWeek) {
		this.startWeek = startWeek;
	}
	public String getEndWeek() {
		return endWeek;
	}
	public void setEndWeek(String endWeek) {
		this.endWeek = endWeek;
	}


}