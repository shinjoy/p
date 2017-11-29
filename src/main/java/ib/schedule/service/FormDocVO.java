package ib.schedule.service;

import java.io.Serializable;

import ib.schedule.service.EmpVO;

public class FormDocVO extends EmpVO implements Serializable {

	private static final long serialVersionUID = -8274004534207618049L;
	private String keyWord					= "";
	private String selYear					= "";
	private String selMonth					= "";
	private String searchSDate				= "";
	private String searchEDate				= "";
	private String formDocCd				= "";	// 증명서코드
	private String formDocNm				= "";	// 증명서명

	private String formDocReqSeq			= "";	// 증명서 요청 순번
	private String reqPerSabun				= "";	// 요청자 사번
	private String reqPerNm					= "";	// 요청자명
	private String targetPerSabun			= "";	// 해당자 사번
	private String targetPerNm				= "";	// 해당자명
	private String jumin1					= "";	// 주민번호1
	private String jumin2					= "";	// 주민번호2
	private String juminFlag				= "";	// 주민번호 공개여부
	private String period					= "";	// 기간
	private String formDocEtc				= "";	// 비고
	private String formDocUse				= "";	// 용도
	private String formDocReason			= "";	// 발급사유 (요청자와 해당자가 다를때만 사용)
	private String reqDate					= "";	// 요청일
	private String reqEndPerSabun			= "";	// 요청 완료자 사번
	private String reqEndDate				= "";	// 요청완료일
	private String reqStatus				= "";	// 요청상태

	public String getKeyWord() {
		return keyWord;
	}
	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}
	public String getSelYear() {
		return selYear;
	}
	public void setSelYear(String selYear) {
		this.selYear = selYear;
	}
	public String getSelMonth() {
		return selMonth;
	}
	public void setSelMonth(String selMonth) {
		this.selMonth = selMonth;
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
	public String getFormDocCd() {
		return formDocCd;
	}
	public void setFormDocCd(String formDocCd) {
		this.formDocCd = formDocCd;
	}
	public String getFormDocNm() {
		return formDocNm;
	}
	public void setFormDocNm(String formDocNm) {
		this.formDocNm = formDocNm;
	}
	public String getFormDocReqSeq() {
		return formDocReqSeq;
	}
	public void setFormDocReqSeq(String formDocReqSeq) {
		this.formDocReqSeq = formDocReqSeq;
	}
	public String getReqPerSabun() {
		return reqPerSabun;
	}
	public void setReqPerSabun(String reqPerSabun) {
		this.reqPerSabun = reqPerSabun;
	}
	public String getReqPerNm() {
		return reqPerNm;
	}
	public void setReqPerNm(String reqPerNm) {
		this.reqPerNm = reqPerNm;
	}
	public String getTargetPerSabun() {
		return targetPerSabun;
	}
	public void setTargetPerSabun(String targetPerSabun) {
		this.targetPerSabun = targetPerSabun;
	}
	public String getTargetPerNm() {
		return targetPerNm;
	}
	public void setTargetPerNm(String targetPerNm) {
		this.targetPerNm = targetPerNm;
	}
	public String getJumin1() {
		return jumin1;
	}
	public void setJumin1(String jumin1) {
		this.jumin1 = jumin1;
	}
	public String getJumin2() {
		return jumin2;
	}
	public void setJumin2(String jumin2) {
		this.jumin2 = jumin2;
	}
	public String getJuminFlag() {
		return juminFlag;
	}
	public void setJuminFlag(String juminFlag) {
		this.juminFlag = juminFlag;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getFormDocEtc() {
		return formDocEtc;
	}
	public void setFormDocEtc(String formDocEtc) {
		this.formDocEtc = formDocEtc;
	}
	public String getFormDocUse() {
		return formDocUse;
	}
	public void setFormDocUse(String formDocUse) {
		this.formDocUse = formDocUse;
	}
	public String getFormDocReason() {
		return formDocReason;
	}
	public void setFormDocReason(String formDocReason) {
		this.formDocReason = formDocReason;
	}
	public String getReqDate() {
		return reqDate;
	}
	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}
	public String getReqEndPerSabun() {
		return reqEndPerSabun;
	}
	public void setReqEndPerSabun(String reqEndPerSabun) {
		this.reqEndPerSabun = reqEndPerSabun;
	}
	public String getReqEndDate() {
		return reqEndDate;
	}
	public void setReqEndDate(String reqEndDate) {
		this.reqEndDate = reqEndDate;
	}
	public String getReqStatus() {
		return reqStatus;
	}
	public void setReqStatus(String reqStatus) {
		this.reqStatus = reqStatus;
	}
}