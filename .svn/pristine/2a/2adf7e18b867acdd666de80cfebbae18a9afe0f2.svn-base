package ib.gboard.service.impl;

import ib.board.service.PagingInfo;

import java.io.Serializable;



public class GboardVO extends PagingInfo implements Serializable {

	private static final long serialVersionUID = -8274004534207618049L;
	private String sabun="";
	// 게시판 그룹
	private String grpCd					= "";			// 그룹코드
	private String grpNm					= "";			// 그룹명
	private String grpInfo					= "";			// 그룹설명
	private String grpOrder					= "";			// 그룹순서
	private String grpOrderLog				= "";			// 그룹순서로그
	private String confirmProcFlag			= "";			// 컨펌여부

	// 게시판 카테고리 종류
	private String cateCd					= "";			// 게시판코드
	private String cateNm					= "";			// 게시판명
	private String cateInfo					= "";			// 게시판설명
	private String cateOrder				= "";			// 게시판순서
	private String cateOrderLog				= "";			// 게시판순서로그
	private String confirmPerSabun			= "";			// 승인게시판의 경우 승인자사번 (유무에 따라 승인기능 사용여부 판단)
	private String confirmPerNm				= "";
	private String oldCateCd				= "";
	private String oldWriteCd				= "";

	private String optCd					= "";
	private int optSeq						= 0;
	private int optSeqLog					= 0;
	private String optFlag					= "";	// 참조인 및 중간승인자 구분

	// 게시물
	private String writeCd					= "";	// 글순번
	private String writeTitle				= "";	// 제목
	private String writeCon					= "";	// 내용
	private String noticeFlag				= "";	// 공지여부
	private String noticeSDate				= "";	// 공지시작일
	private String noticeEDate				= "";	// 공지종료일
	private int hit							= 0;	// 조회수
	private String writeStatus				= "";	// 글상태
	private String boardVer					= "";	// 글버전
	private String readDate					= "";	// 조회일

	// 휴가보고서
	private String holiDocFlag				= "";	// 휴가보고서여부 (Y - 휴가보고서, N - 일반보고서, F - 경조사보고서)
	private String holiFlag					= "";	// 휴가유형 half - 반차, all - 종일
	private String holiFlagNm				= "";
	private String halfFlag					= "";	// 반차유형 am - 오전, pm - 오후
	private String halfFlagNm				= "";
	private String holiSDate				= "";	// 휴가시작일
	private String holiSDateNm				= "";
	private String holiEDate				= "";	// 휴가종료일
	private String holiEDateNm				= "";
	private String holiUseDay				= "";	// 총사용일
	private String holiCancelCd				= "";	// 휴가 취소 부모글

	// 경조사 보고서
	private String eventSelCd1				= "";	// 경조사분류
	private String eventSelCd2				= "";	// 세부분류
	private String eventDay					= "";	// 경조일
	private String eventDoc					= "";	// 경조 증빙서류

	// 댓글
	private String replyCd					= "";	// 댓글코드
	private String replyCon					= "";	// 댓글내용
	private String replyPerSabun			= "";	// 댓글작성자코드
	private String replyPerNm				= "";	// 댓글작성자명
	private String readFlag					= "";

	// 결제정보
	private String confirmSeq				= "";	// 결제순번
	private String confirmStatus			= "";	// 결제상태 (ing - 진행, return - 반송, end - 완료)
	private String confirmCon				= "";	// 결제내용
	private String confirmDate				= "";	// 결제일자
	private String middleCnt				= "";	// 중간승인자수
	private String endCnt					= "";	// 중간승인자 승인 수
	private String returnCnt				= "";	// 중간승인자 반송 수


	// 공통
	private String perSabun					= "";
	private String perPositionNm			= "";
	private String perDept					= "";
	private String perJoinCom				= "";
	private String cmd						= "";
	private String popFlag					= "";
	private String eventType				= "";
	private String regPerSabun				= "";
	private String regPerNm					= "";
	private String regDate					= "";
	private String regYear					= "";
	private String regMonth					= "";
	private String editPerSabun				= "";
	private String editDate					= "";
	private String delPerSabun				= "";
	private String delDate					= "";
	private String delFlag					= "";
	private String fileSeq					= "";	// 파일순번
	private String fileNm					= "";	// 파일명
	private String fileUpNm					= "";	// 업로드된 파일명
	private String filePath					= "";	// 파일경로
	private String fileIco					= "";	// 파일확장자아이콘
	private long fileSize					= 0L;	// 파일크기
	private int fileOrder					= 0;	// 파일출력순서
	private int maxFileSize					= 10 * 1024 * 1024;	// 파일크기

	private String orderFlag				= "";	// 정렬객체 문자, 숫자구분
	private String orderType				= "";	// 정렬타입
	private String orderKey					= "";	// 정렬기준
	private String orderObj					= "";	// 정렬객체
	private String orderObjNm				= "";	// 정렬객체명
	private String keyType					= "";	// 검색조건
	private String keyWord					= "";	// 검색어
	private String division 				= "";   //회사


	public String getSabun() {
		return sabun;
	}
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getGrpCd() {
		return grpCd;
	}
	public void setGrpCd(String grpCd) {
		this.grpCd = grpCd;
	}
	public String getGrpNm() {
		return grpNm;
	}
	public void setGrpNm(String grpNm) {
		this.grpNm = grpNm;
	}
	public String getGrpInfo() {
		return grpInfo;
	}
	public void setGrpInfo(String grpInfo) {
		this.grpInfo = grpInfo;
	}
	public String getGrpOrder() {
		return grpOrder;
	}
	public void setGrpOrder(String grpOrder) {
		this.grpOrder = grpOrder;
	}
	public String getGrpOrderLog() {
		return grpOrderLog;
	}
	public void setGrpOrderLog(String grpOrderLog) {
		this.grpOrderLog = grpOrderLog;
	}
	public String getConfirmProcFlag() {
		return confirmProcFlag;
	}
	public void setConfirmProcFlag(String confirmProcFlag) {
		this.confirmProcFlag = confirmProcFlag;
	}
	public String getCateCd() {
		return cateCd;
	}
	public void setCateCd(String cateCd) {
		this.cateCd = cateCd;
	}
	public String getCateNm() {
		return cateNm;
	}
	public void setCateNm(String cateNm) {
		this.cateNm = cateNm;
	}
	public String getCateInfo() {
		return cateInfo;
	}
	public void setCateInfo(String cateInfo) {
		this.cateInfo = cateInfo;
	}
	public String getCateOrder() {
		return cateOrder;
	}
	public void setCateOrder(String cateOrder) {
		this.cateOrder = cateOrder;
	}
	public String getCateOrderLog() {
		return cateOrderLog;
	}
	public void setCateOrderLog(String cateOrderLog) {
		this.cateOrderLog = cateOrderLog;
	}
	public String getConfirmPerSabun() {
		return confirmPerSabun;
	}
	public void setConfirmPerSabun(String confirmPerSabun) {
		this.confirmPerSabun = confirmPerSabun;
	}
	public String getConfirmPerNm() {
		return confirmPerNm;
	}
	public void setConfirmPerNm(String confirmPerNm) {
		this.confirmPerNm = confirmPerNm;
	}
	public String getOldCateCd() {
		return oldCateCd;
	}
	public void setOldCateCd(String oldCateCd) {
		this.oldCateCd = oldCateCd;
	}
	public String getOldWriteCd() {
		return oldWriteCd;
	}
	public void setOldWriteCd(String oldWriteCd) {
		this.oldWriteCd = oldWriteCd;
	}
	public String getOptCd() {
		return optCd;
	}
	public void setOptCd(String optCd) {
		this.optCd = optCd;
	}
	public int getOptSeq() {
		return optSeq;
	}
	public void setOptSeq(int optSeq) {
		this.optSeq = optSeq;
	}
	public int getOptSeqLog() {
		return optSeqLog;
	}
	public void setOptSeqLog(int optSeqLog) {
		this.optSeqLog = optSeqLog;
	}
	public String getOptFlag() {
		return optFlag;
	}
	public void setOptFlag(String optFlag) {
		this.optFlag = optFlag;
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
	public String getNoticeFlag() {
		return noticeFlag;
	}
	public void setNoticeFlag(String noticeFlag) {
		this.noticeFlag = noticeFlag;
	}
	public String getNoticeSDate() {
		return noticeSDate;
	}
	public void setNoticeSDate(String noticeSDate) {
		this.noticeSDate = noticeSDate;
	}
	public String getNoticeEDate() {
		return noticeEDate;
	}
	public void setNoticeEDate(String noticeEDate) {
		this.noticeEDate = noticeEDate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getWriteStatus() {
		return writeStatus;
	}
	public void setWriteStatus(String writeStatus) {
		this.writeStatus = writeStatus;
	}
	public String getBoardVer() {
		return boardVer;
	}
	public void setBoardVer(String boardVer) {
		this.boardVer = boardVer;
	}
	public String getReadDate() {
		return readDate;
	}
	public void setReadDate(String readDate) {
		this.readDate = readDate;
	}
	public String getHoliDocFlag() {
		return holiDocFlag;
	}
	public void setHoliDocFlag(String holiDocFlag) {
		this.holiDocFlag = holiDocFlag;
	}
	public String getHoliFlag() {
		return holiFlag;
	}
	public void setHoliFlag(String holiFlag) {
		this.holiFlag = holiFlag;
	}
	public String getHoliFlagNm() {
		return holiFlagNm;
	}
	public void setHoliFlagNm(String holiFlagNm) {
		this.holiFlagNm = holiFlagNm;
	}
	public String getHalfFlag() {
		return halfFlag;
	}
	public void setHalfFlag(String halfFlag) {
		this.halfFlag = halfFlag;
	}
	public String getHalfFlagNm() {
		return halfFlagNm;
	}
	public void setHalfFlagNm(String halfFlagNm) {
		this.halfFlagNm = halfFlagNm;
	}
	public String getHoliSDate() {
		return holiSDate;
	}
	public void setHoliSDate(String holiSDate) {
		this.holiSDate = holiSDate;
	}
	public String getHoliSDateNm() {
		return holiSDateNm;
	}
	public void setHoliSDateNm(String holiSDateNm) {
		this.holiSDateNm = holiSDateNm;
	}
	public String getHoliEDate() {
		return holiEDate;
	}
	public void setHoliEDate(String holiEDate) {
		this.holiEDate = holiEDate;
	}
	public String getHoliEDateNm() {
		return holiEDateNm;
	}
	public void setHoliEDateNm(String holiEDateNm) {
		this.holiEDateNm = holiEDateNm;
	}
	public String getHoliUseDay() {
		return holiUseDay;
	}
	public void setHoliUseDay(String holiUseDay) {
		this.holiUseDay = holiUseDay;
	}
	public String getHoliCancelCd() {
		return holiCancelCd;
	}
	public void setHoliCancelCd(String holiCancelCd) {
		this.holiCancelCd = holiCancelCd;
	}
	public String getEventSelCd1() {
		return eventSelCd1;
	}
	public void setEventSelCd1(String eventSelCd1) {
		this.eventSelCd1 = eventSelCd1;
	}
	public String getEventSelCd2() {
		return eventSelCd2;
	}
	public void setEventSelCd2(String eventSelCd2) {
		this.eventSelCd2 = eventSelCd2;
	}
	public String getEventDay() {
		return eventDay;
	}
	public void setEventDay(String eventDay) {
		this.eventDay = eventDay;
	}
	public String getEventDoc() {
		return eventDoc;
	}
	public void setEventDoc(String eventDoc) {
		this.eventDoc = eventDoc;
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
	public String getReadFlag() {
		return readFlag;
	}
	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
	public String getConfirmSeq() {
		return confirmSeq;
	}
	public void setConfirmSeq(String confirmSeq) {
		this.confirmSeq = confirmSeq;
	}
	public String getConfirmStatus() {
		return confirmStatus;
	}
	public void setConfirmStatus(String confirmStatus) {
		this.confirmStatus = confirmStatus;
	}
	public String getConfirmCon() {
		return confirmCon;
	}
	public void setConfirmCon(String confirmCon) {
		this.confirmCon = confirmCon;
	}
	public String getConfirmDate() {
		return confirmDate;
	}
	public void setConfirmDate(String confirmDate) {
		this.confirmDate = confirmDate;
	}
	public String getMiddleCnt() {
		return middleCnt;
	}
	public void setMiddleCnt(String middleCnt) {
		this.middleCnt = middleCnt;
	}
	public String getEndCnt() {
		return endCnt;
	}
	public void setEndCnt(String endCnt) {
		this.endCnt = endCnt;
	}
	public String getReturnCnt() {
		return returnCnt;
	}
	public void setReturnCnt(String returnCnt) {
		this.returnCnt = returnCnt;
	}
	public String getPerSabun() {
		return perSabun;
	}
	public void setPerSabun(String perSabun) {
		this.perSabun = perSabun;
	}
	public String getPerPositionNm() {
		return perPositionNm;
	}
	public void setPerPositionNm(String perPositionNm) {
		this.perPositionNm = perPositionNm;
	}
	public String getPerDept() {
		return perDept;
	}
	public void setPerDept(String perDept) {
		this.perDept = perDept;
	}
	public String getPerJoinCom() {
		return perJoinCom;
	}
	public void setPerJoinCom(String perJoinCom) {
		this.perJoinCom = perJoinCom;
	}
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public String getPopFlag() {
		return popFlag;
	}
	public void setPopFlag(String popFlag) {
		this.popFlag = popFlag;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public String getRegPerSabun() {
		return regPerSabun;
	}
	public void setRegPerSabun(String regPerSabun) {
		this.regPerSabun = regPerSabun;
	}
	public String getRegPerNm() {
		return regPerNm;
	}
	public void setRegPerNm(String regPerNm) {
		this.regPerNm = regPerNm;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegYear() {
		return regYear;
	}
	public void setRegYear(String regYear) {
		this.regYear = regYear;
	}
	public String getRegMonth() {
		return regMonth;
	}
	public void setRegMonth(String regMonth) {
		this.regMonth = regMonth;
	}
	public String getEditPerSabun() {
		return editPerSabun;
	}
	public void setEditPerSabun(String editPerSabun) {
		this.editPerSabun = editPerSabun;
	}
	public String getEditDate() {
		return editDate;
	}
	public void setEditDate(String editDate) {
		this.editDate = editDate;
	}
	public String getDelPerSabun() {
		return delPerSabun;
	}
	public void setDelPerSabun(String delPerSabun) {
		this.delPerSabun = delPerSabun;
	}
	public String getDelDate() {
		return delDate;
	}
	public void setDelDate(String delDate) {
		this.delDate = delDate;
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
	public String getFileIco() {
		return fileIco;
	}
	public void setFileIco(String fileIco) {
		this.fileIco = fileIco;
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
	public String getKeyType() {
		return keyType;
	}
	public void setKeyType(String keyType) {
		this.keyType = keyType;
	}
	public String getKeyWord() {
		return keyWord;
	}
	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}


}