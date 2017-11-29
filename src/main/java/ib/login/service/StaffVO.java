package ib.login.service;

import ib.work.service.WorkVO;


/**
 * <pre>
 * package  : ib.login.service
 * filename : StaffVO.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 22.
 * @version : 1.0.0
 */
@SuppressWarnings("serial")
public class StaffVO extends WorkVO{

	private String sNb = "";
	private String srtCd = "";
	private String cstId = "";
	private String usrId = "";
	private String usrPw = "";
	private String usrNm = "";
	private String joinDt = "";
	private String email = "";
	private String phn1 = "";
	private String phn2 = "";
	private String phn3 = "";
	private String ip = "";
	private String loginDt = "";
	private String permission = "";
	private String sabun = "";
	private String flag = "";

	private String analMaster = "";
	private String infoLevel = "";
	private String mnaLevel  = "";
	private String reviewLevel = "";
	private String deptNm ="";		///부서

	private String division="";
	private String hqName="";		//회사명 ex> 시너지 파트너스 , 시너지벤처투자. bs_company_hq
	private String position="";		//직급

	private String carWorkYn; 		//차량사용여부 ->bs_user_profile

	private String statSeq;			//직원정렬

	public String getCarWorkYn() {
		return carWorkYn;
	}
	public void setCarWorkYn(String carWorkYn) {
		this.carWorkYn = carWorkYn;
	}

	public void setHqName(String hqName) {
		this.hqName = hqName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}

	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getHqName() {
		return hqName;
	}

	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	/**
	 * @return the sNb
	 */
	public String getsNb() {
		return sNb;
	}
	/**
	 * @param sNb the sNb to set
	 */
	public void setsNb(String sNb) {
		this.sNb = sNb;
	}
	/**
	 * @return the srtCd
	 */
	public String getSrtCd() {
		return srtCd;
	}
	/**
	 * @param srtCd the srtCd to set
	 */
	public void setSrtCd(String srtCd) {
		this.srtCd = srtCd;
	}
	/**
	 * @return the usrId
	 */
	public String getUsrId() {
		return usrId;
	}
	/**
	 * @param usrId the usrId to set
	 */
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	/**
	 * @return the usrPw
	 */
	public String getUsrPw() {
		return usrPw;
	}
	/**
	 * @param usrPw the usrPw to set
	 */
	public void setUsrPw(String usrPw) {
		this.usrPw = usrPw;
	}
	/**
	 * @return the usrNm
	 */
	public String getUsrNm() {
		return usrNm;
	}
	/**
	 * @param usrNm the usrNm to set
	 */
	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the phn1
	 */
	public String getPhn1() {
		return phn1;
	}
	/**
	 * @param phn1 the phn1 to set
	 */
	public void setPhn1(String phn1) {
		this.phn1 = phn1;
	}
	/**
	 * @return the phn2
	 */
	public String getPhn2() {
		return phn2;
	}
	/**
	 * @param phn2 the phn2 to set
	 */
	public void setPhn2(String phn2) {
		this.phn2 = phn2;
	}
	/**
	 * @return the phn3
	 */
	public String getPhn3() {
		return phn3;
	}
	/**
	 * @param phn3 the phn3 to set
	 */
	public void setPhn3(String phn3) {
		this.phn3 = phn3;
	}
	/**
	 * @return the ip
	 */
	public String getIp() {
		return ip;
	}
	/**
	 * @param ip the ip to set
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}
	/**
	 * @return the loginDt
	 */
	public String getLoginDt() {
		return loginDt;
	}
	/**
	 * @param loginDt the loginDt to set
	 */
	public void setLoginDt(String loginDt) {
		this.loginDt = loginDt;
	}
	/**
	 * @return the permission
	 */
	public String getPermission() {
		return permission;
	}
	/**
	 * @param permission the permission to set
	 */
	public void setPermission(String permission) {
		this.permission = permission;
	}
	/**
	 * @return the joinDt
	 */
	public String getJoinDt() {
		return joinDt;
	}
	/**
	 * @param joinDt the joinDt to set
	 */
	public void setJoinDt(String joinDt) {
		this.joinDt = joinDt;
	}
	/**
	 * @return the cstId
	 */
	public String getCstId() {
		return cstId;
	}
	/**
	 * @param cstId the cstId to set
	 */
	public void setCstId(String cstId) {
		this.cstId = cstId;
	}
	/**
	 * @return the sabun
	 */
	public String getSabun() {
		return sabun;
	}
	/**
	 * @param sabun the sabun to set
	 */
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}
	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}
	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getAnalMaster() {
		return analMaster;
	}
	public void setAnalMaster(String analMaster) {
		this.analMaster = analMaster;
	}
	public String getInfoLevel() {
		return infoLevel;
	}
	public void setInfoLevel(String infoLevel) {
		this.infoLevel = infoLevel;
	}
	public String getMnaLevel() {
		return mnaLevel;
	}
	public void setMnaLevel(String mnaLevel) {
		this.mnaLevel = mnaLevel;
	}
	public String getReviewLevel() {
		return reviewLevel;
	}
	public void setReviewLevel(String reviewLevel) {
		this.reviewLevel = reviewLevel;
	}
	public String getStatSeq() {
		return statSeq;
	}
	public void setStatSeq(String statSeq) {
		this.statSeq = statSeq;
	}

}
