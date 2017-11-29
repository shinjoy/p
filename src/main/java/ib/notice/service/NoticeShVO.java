package ib.notice.service;

import ib.work.service.WorkVO;


/**
 * <pre>
 * package  : ib.notice.service
 * filename : NoticeVO.java
 * </pre>
 * 
 * @author  : ChanWoo Lee
 * @since   : 2014. 4. 23.
 * @version : 1.0.0
 */
@SuppressWarnings("serial")
public class NoticeShVO extends WorkVO{
	
	private String sNb			 = "";// '순번'
	private String tmDt			 = "";// '공시일자'
	private String debtor			 = "";// '채무자'
	private String cpnNm			 = "";// '회사이름'
	private String cpnSnb			 = "";// '회사순번'
	private String cpnId			 = "";// '회사코드'
	private String majorSh			 = "";// '최대주주'
	private String totalCount			 = "";// '내역건수'
	private String creditor			 = "";// '채권자'
	private String securityAmount			 = "";// '담보설정금액'
	private String securityType			 = "";// '담보권 종류'
	private String securityShareCnt				 = "";// '담보제공 주식수'
	private String keepYn			 = "";// '보호예수'
	private String securityDt			 = "";// '담보제공기간'
	private String comment			 = "";// '기타'
	private String rgDt			 = "";// '등록일'
	
	
	public String getsNb() {
		return sNb;
	}
	public void setsNb(String sNb) {
		this.sNb = sNb;
	}
	public String getTmDt() {
		return tmDt;
	}
	public void setTmDt(String tmDt) {
		this.tmDt = tmDt;
	}
	public String getDebtor() {
		return debtor;
	}
	public void setDebtor(String debtor) {
		this.debtor = debtor;
	}
	public String getCpnNm() {
		return cpnNm;
	}
	public void setCpnNm(String cpnNm) {
		this.cpnNm = cpnNm;
	}
	public String getCpnSnb() {
		return cpnSnb;
	}
	public void setCpnSnb(String cpnSnb) {
		this.cpnSnb = cpnSnb;
	}
	public String getCpnId() {
		return cpnId;
	}
	public void setCpnId(String cpnId) {
		this.cpnId = cpnId;
	}
	public String getMajorSh() {
		return majorSh;
	}
	public void setMajorSh(String majorSh) {
		this.majorSh = majorSh;
	}
	public String getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}
	public String getCreditor() {
		return creditor;
	}
	public void setCreditor(String creditor) {
		this.creditor = creditor;
	}
	public String getSecurityAmount() {
		return securityAmount;
	}
	public void setSecurityAmount(String securityAmount) {
		this.securityAmount = securityAmount;
	}
	public String getSecurityType() {
		return securityType;
	}
	public void setSecurityType(String securityType) {
		this.securityType = securityType;
	}
	public String getSecurityShareCnt() {
		return securityShareCnt;
	}
	public void setSecurityShareCnt(String securityShareCnt) {
		this.securityShareCnt = securityShareCnt;
	}
	public String getKeepYn() {
		return keepYn;
	}
	public void setKeepYn(String keepYn) {
		this.keepYn = keepYn;
	}
	public String getSecurityDt() {
		return securityDt;
	}
	public void setSecurityDt(String securityDt) {
		this.securityDt = securityDt;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getRgDt() {
		return rgDt;
	}
	public void setRgDt(String rgDt) {
		this.rgDt = rgDt;
	}
	
	
		
}
