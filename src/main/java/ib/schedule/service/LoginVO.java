package ib.schedule.service;

import java.io.Serializable;

import ib.schedule.service.EmpVO;

public class LoginVO extends EmpVO implements Serializable {

	private String InfoMessage		= "";				// 경고문구
	private String cmd				= "";				// 명령

	/** IB Login **/
	private String ibId			= "";
	private String ibPw			= "";
	private String flag				= "";
	/** IB Login **/

	private String perSabun			= "";				// 사번
	private String perNm			= "";				// 사원명
	private String perDept			= "";				// 부서
	private String perPositionNm	= "";				// 직책
	private String comPosition		= "";				// 소속
	private String perJoinCom		= "";				// 입사일
	private String perId			= "";				// 아이디
	private String perPW			= "";				// 비밀번호
	private String perPhone			= "";				// 핸드폰
	private String perEmail			= "";				// 이메일
	private String perAddr			= "";				// 주소
	private String gmailId			= "";				// Gmail 계정
	private String gmailPw			= "";				// Gmail 비밀번호
	private String regDate			= "";				// 등록일
	private String regPerSabun		= "";				// 등록자사번
	private String delFlag			= "";				// 삭제여부

	private String oldPerPW			= "";				// 기존비밀번호
	private String newPerPW			= "";				// 신규비밀번호
	private String rePerPW			= "";				// 비밀번호확인

	private String fileSeq			= "";				// 파일순번
	private String fileNm			= "";				// 파일명
	private String fileUpNm			= "";				// 업로드된 파일명
	private String filePath			= "";				// 파일경로
	private long fileSize			= 0L;				// 파일크기
	private int fileOrder			= 0;				// 파일출력순서
	private int maxFileSize			= 10 * 1024 * 1024;	// 파일크기

	/** 고객 게시판 **/
	private String cusCd			= "";				// 고객코드
	private String cusNm			= "";				// 고객명
	private String cusId			= "";				// 고객아이디
	private String cusPW			= "";				// 고객비밀번호
	private String useFlag			= "";				// 계정 사용여부
	private String cusTel			= "";				// 고객 전화번호
	private String cusStatus		= "";				// 고객상태
	private String latelyVisit		= "";				// 최근방문일자
	private String visitCnt			= "";				// 방문횟수
	/** 고객 게시판 **/


	private String usrCusId			= "";				//사용자 고객 cusId (ib_customer.snb)
	private String staffSnb			= "";				//ib_staff.snb
	private String division			= "";				//division


	private static final long serialVersionUID = -8274004534207618049L;

	public String getInfoMessage() {return InfoMessage;}
	public void setInfoMessage(String infoMessage) {InfoMessage = infoMessage;}

	public String getUsrCusId() {
		return usrCusId;
	}
	public void setUsrCusId(String usrCusId) {
		this.usrCusId = usrCusId;
	}
	public String getStaffSnb() {
		return staffSnb;
	}
	public void setStaffSnb(String staffSnb) {
		this.staffSnb = staffSnb;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
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
	public String getPerDept() {
		return perDept;
	}
	public void setPerDept(String perDept) {
		this.perDept = perDept;
	}
	public String getPerPositionNm() {
		return perPositionNm;
	}
	public void setPerPositionNm(String perPositionNm) {
		this.perPositionNm = perPositionNm;
	}
	public String getComPosition() {
		return comPosition;
	}
	public void setComPosition(String comPosition) {
		this.comPosition = comPosition;
	}
	public String getPerJoinCom() {
		return perJoinCom;
	}
	public void setPerJoinCom(String perJoinCom) {
		this.perJoinCom = perJoinCom;
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
	public String getOldPerPW() {
		return oldPerPW;
	}
	public void setOldPerPW(String oldPerPW) {
		this.oldPerPW = oldPerPW;
	}
	public String getNewPerPW() {
		return newPerPW;
	}
	public void setNewPerPW(String newPerPW) {
		this.newPerPW = newPerPW;
	}
	public String getRePerPW() {
		return rePerPW;
	}
	public void setRePerPW(String rePerPW) {
		this.rePerPW = rePerPW;
	}
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
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
	public String getCusTel() {
		return cusTel;
	}
	public void setCusTel(String cusTel) {
		this.cusTel = cusTel;
	}
	public String getCusStatus() {
		return cusStatus;
	}
	public void setCusStatus(String cusStatus) {
		this.cusStatus = cusStatus;
	}
	public String getLatelyVisit() {
		return latelyVisit;
	}
	public void setLatelyVisit(String latelyVisit) {
		this.latelyVisit = latelyVisit;
	}
	public String getVisitCnt() {
		return visitCnt;
	}
	public void setVisitCnt(String visitCnt) {
		this.visitCnt = visitCnt;
	}
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public String getIbId() {
		return ibId;
	}
	public void setIbId(String ibId) {
		this.ibId = ibId;
	}
	public String getIbPw() {
		return ibPw;
	}
	public void setIbPw(String ibPw) {
		this.ibPw = ibPw;
	}
	public String getGmailId() {
		return gmailId;
	}
	public void setGmailId(String gmailId) {
		this.gmailId = gmailId;
	}
	public String getGmailPw() {
		return gmailPw;
	}
	public void setGmailPw(String gmailPw) {
		this.gmailPw = gmailPw;
	}


}