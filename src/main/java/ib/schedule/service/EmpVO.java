package ib.schedule.service;

import java.io.Serializable;

import ib.schedule.service.CusVO;

public class EmpVO extends CusVO implements Serializable {

	private String infoMessage		= "";	// 경고문구
	private String docType			= "";
	private String searchKeyword	= "";
	private String orderFlag		= "";	// 정렬객체 문자, 숫자구분
	private String orderType		= "";	// 정렬타입
	private String orderKey			= "";	// 정렬기준
	private String orderObj			= "";	// 정렬객체
	private String orderObjNm		= "";	// 정렬객체명

	private String perSabun			= "";	// 사번
	private String perNm			= "";	// 사원명
	private String perJumin			= "";	// 주민등록번호
	private String perDept			= "";	// 부서
	private String comPosition		= "";	// 소속회사
	private String perPositionNm	= "";	// 직책
	private String perJob			= "";	// 직무
	private String perJoinCom		= "";	// 입사일
	private String perOutCom		= "";	// 퇴사일
	private String perComTel		= "";	// 내선번호
	private String perId			= "";	// 아이디
	private String perPW			= "";	// 비밀번호
	private String perPhone			= "";	// 핸드폰
	private String sendNumFlag		= "";	// 발신번호 등록 여부
	private String perEmail			= "";	// 이메일
	private String perAddr			= "";	// 주소
	private String perBirthday		= "";	// 생일
	private String moonFlag			= "";	// 양력(S) 음력(L) 구분
	private String seatNum			= "";	// 자리번호
	private String mailFlag			= "";	// 메일담당여부
	private String viewFlag			= "";	// 리스트 출력여부
	private String payFlag			= "";	// 급여관리 여부
	private String payAccount		= "";	// 급여 계좌번호
	private String payViewOrder		= "";	// 급여관리 출력순서
	private String maxPayOrder		= "";	// 회사별 급여순서 최대값
	private String empInsuranceFlag	= "";	// 고용보험 공제여부
	private String regDate			= "";	// 등록일
	private String regPerSabun		= "";	// 등록자사번
	private String delFlag			= "";	// 삭제여부

	private String positionCd		= "";	// 직책순번
	private String positionNm		= "";	// 직책명
	private String positionOrder	= "";	// 직책출력순서

	private String deptSeq			= "";	// 부서순번
	private String deptNm			= "";	// 부서명
	private String teamLeaderSabun	= "";	// 팀장사번
	private String teamLeaderNm		= "";	// 팀장명
	private String deptOrder		= "";	// 부서출력순서
    private String orderLog			= "";	// 기존출력순서

	private static final long serialVersionUID = -8274004534207618049L;

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

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
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

	public String getPerSabun() {
		return perSabun;
	}

	public void setPerSabun(String perSabun) {
		this.perSabun = perSabun;
	}

	public String getPerNm() {
		return perNm;
	}

	public void setPerNm(String perNm) {
		this.perNm = perNm;
	}

	public String getPerJumin() {
		return perJumin;
	}

	public void setPerJumin(String perJumin) {
		this.perJumin = perJumin;
	}

	public String getPerDept() {
		return perDept;
	}

	public void setPerDept(String perDept) {
		this.perDept = perDept;
	}

	public String getComPosition() {
		return comPosition;
	}

	public void setComPosition(String comPosition) {
		this.comPosition = comPosition;
	}

	public String getPerPositionNm() {
		return perPositionNm;
	}

	public void setPerPositionNm(String perPositionNm) {
		this.perPositionNm = perPositionNm;
	}

	public String getPerJob() {
		return perJob;
	}

	public void setPerJob(String perJob) {
		this.perJob = perJob;
	}

	public String getPerJoinCom() {
		return perJoinCom;
	}

	public void setPerJoinCom(String perJoinCom) {
		this.perJoinCom = perJoinCom;
	}

	public String getPerOutCom() {
		return perOutCom;
	}

	public void setPerOutCom(String perOutCom) {
		this.perOutCom = perOutCom;
	}

	public String getPerComTel() {
		return perComTel;
	}

	public void setPerComTel(String perComTel) {
		this.perComTel = perComTel;
	}

	public String getPerId() {
		return perId;
	}

	public void setPerId(String perId) {
		this.perId = perId;
	}

	public String getPerPW() {
		return perPW;
	}

	public void setPerPW(String perPW) {
		this.perPW = perPW;
	}

	public String getPerPhone() {
		return perPhone;
	}

	public void setPerPhone(String perPhone) {
		this.perPhone = perPhone;
	}

	public String getSendNumFlag() {
		return sendNumFlag;
	}

	public void setSendNumFlag(String sendNumFlag) {
		this.sendNumFlag = sendNumFlag;
	}

	public String getPerEmail() {
		return perEmail;
	}

	public void setPerEmail(String perEmail) {
		this.perEmail = perEmail;
	}

	public String getPerAddr() {
		return perAddr;
	}

	public void setPerAddr(String perAddr) {
		this.perAddr = perAddr;
	}

	public String getPerBirthday() {
		return perBirthday;
	}

	public void setPerBirthday(String perBirthday) {
		this.perBirthday = perBirthday;
	}

	public String getMoonFlag() {
		return moonFlag;
	}

	public void setMoonFlag(String moonFlag) {
		this.moonFlag = moonFlag;
	}

	public String getSeatNum() {
		return seatNum;
	}

	public void setSeatNum(String seatNum) {
		this.seatNum = seatNum;
	}

	public String getMailFlag() {
		return mailFlag;
	}

	public void setMailFlag(String mailFlag) {
		this.mailFlag = mailFlag;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public String getPayFlag() {
		return payFlag;
	}

	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}

	public String getPayAccount() {
		return payAccount;
	}

	public void setPayAccount(String payAccount) {
		this.payAccount = payAccount;
	}

	public String getPayViewOrder() {
		return payViewOrder;
	}

	public void setPayViewOrder(String payViewOrder) {
		this.payViewOrder = payViewOrder;
	}

	public String getMaxPayOrder() {
		return maxPayOrder;
	}

	public void setMaxPayOrder(String maxPayOrder) {
		this.maxPayOrder = maxPayOrder;
	}

	public String getEmpInsuranceFlag() {
		return empInsuranceFlag;
	}

	public void setEmpInsuranceFlag(String empInsuranceFlag) {
		this.empInsuranceFlag = empInsuranceFlag;
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

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getPositionCd() {
		return positionCd;
	}

	public void setPositionCd(String positionCd) {
		this.positionCd = positionCd;
	}

	public String getPositionNm() {
		return positionNm;
	}

	public void setPositionNm(String positionNm) {
		this.positionNm = positionNm;
	}

	public String getPositionOrder() {
		return positionOrder;
	}

	public void setPositionOrder(String positionOrder) {
		this.positionOrder = positionOrder;
	}

	public String getDeptSeq() {
		return deptSeq;
	}

	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}

	public String getDeptNm() {
		return deptNm;
	}

	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}

	public String getTeamLeaderSabun() {
		return teamLeaderSabun;
	}

	public void setTeamLeaderSabun(String teamLeaderSabun) {
		this.teamLeaderSabun = teamLeaderSabun;
	}

	public String getTeamLeaderNm() {
		return teamLeaderNm;
	}

	public void setTeamLeaderNm(String teamLeaderNm) {
		this.teamLeaderNm = teamLeaderNm;
	}

	public String getDeptOrder() {
		return deptOrder;
	}

	public void setDeptOrder(String deptOrder) {
		this.deptOrder = deptOrder;
	}

	public String getOrderLog() {
		return orderLog;
	}

	public void setOrderLog(String orderLog) {
		this.orderLog = orderLog;
	}


}