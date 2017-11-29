package ib.schedule.service.impl;

import ib.cmm.util.fcc.service.StringUtil;
import ib.schedule.service.CusVO;

public class ScheduleVO extends CusVO {

	private static final long serialVersionUID = -8274004534207618049L;

	private String cmd					= "";
	private String eventType			= "";
	private String contactLoc			= "";
	private String parentPage			= "";	// 요청페이지
	private String perSabun				= "";	// 사번
	private String regDate				= "";	// 등록일
	private String regDateStr			= "";	// 등록일(yyyy-MM-dd)
	private String regPerSabun			= "";	// 등록자사번
	private String regPerNm				= "";	// 등록자
	private String regPerPhone			= "";
	private String editDate				= "";	// 수정일
	private String delDate				= "";	// 삭제일
	private String delFlag				= "";	// 삭제여부
	private String searchSDate			= "";
	private String searchEDate			= "";
	private String searchPerSabun		= "";
	private String searchQuery			= "";
	private String sMSContent			= "";
	private String holiDocFlag			= "";	// 휴가보고서여부 (Y - 휴가보고서, N - 일반보고서, F - 경조사보고서)


	private String scheSeq				= "";	// 스케쥴시퀀스
	private String scheGrpCd			= "";	// 반복일정 그룹코드
	private String scheGubun			= "";	// 일정구분 All - 전체일정, Along - 개인일정
	private String scheGubunNm			= "";

	private String mnaType				= "";	// 일정 분류 M&A 상세분류 (미팅,실사,중개,관리)
	private String isMna				= "";	// M&A

	private String scheSYear			= "";	// 시작년
	private String scheSMonth			= "";	// 시작월
	private String scheSDay				= "";	// 시작일
	private String scheSDate			= "";	// 시작일자
	private String scheSTime			= "";	// 시작시간
	private String scheEYear			= "";	// 종료년
	private String scheEMonth			= "";	// 종료월
	private String scheEDay				= "";	// 종료일
	private String scheEDate			= "";	// 종료일자
	private String scheETime			= "";	// 종료시간
	private String scheAllTime			= "";	// 종일일정 구분 Y - 종일일정, N - 특정시간
	private String schePeriodFlag		= "";


	private String scheTitle			= "";	// 스케쥴명
	private String scheArea				= "";	// 장소
	private String scheCon				= "";	// 스케쥴내용

	private String scheRepetFlag		= "";	// 반복여부
	private String scheRepetFlagNm		= "";	// 반복여부
	private String scheAlarmFlag		= "";	// 알림시기
	private String scheAlarmFlagNm		= "";	// 알림시기
	private String scheAlarmHow			= "";	// 알림방법
	private String scheAlarmHowNm		= "";	// 알림방법
	private String scheImportant		= "";	// 중요도
	private String scheImportantNm		= "";	// 중요도
	private String scheChkFlag			= "";	// 확인여부
	private String scheChkDate			= "";	// 확인일
	private String schePublicFlag		= "";	// 공개여부
	private String procFlag				= "";	// 반복 일정 관련 플래그

	private String carUseFlag			= "";
	private String carNum				= "";
	private String carId;
	private String carArriveTime		= "";
	private String carFloor				= "";
	private String carUsePerNm			= "";


	private String tmpCpnId;	//회사코드			ib_company		20160303
	private String tmpCstId;	//고객 id (sequence) ib_customer
	private String tmpCpnNm            = "";
	private String tmpCstNm            = "";

	private String company				= "";	//임시회사명
	private String companyId;	//회사코드
	private String companyNm			= "";	//회사명
	private String customerId;	//고객id
	private String customer				= "";	//임시고객명
	private String customerNm			= "";	//고객명

	private String beforePage 			= ""; 	//모바일 화면 전환용..
	private String sortType				= "";	//스케쥴 정렬 순서

	private String[] arrPerSabun;  //일정참가자 사번

	private String[] chkboxStaff;  //직원트리선택박스

	private String[] arrSmsToNum;  //일정참가자 핸드폰번호

	private String appvDocId;
	private String loginId;
	private String userId;
	private String carNumber;

	private String[] arrRecieveUserId;  //SMS 전송 받을 User ID

	private String searchScheSTime			= "";	// 시작시간
	private String searchScheETime			= "";	// 종료시간

	private String selYear;
	private String selMonth;
	private String selDay;

	private String eventPage;
	private String searchScheSDate			= "";	// 시작일자

	private String[] arrSearchPerSabun;

	private String recvUserId;
	private String sendUserId;

	private String projectId;
	private String activityId;
	private String projectNm;
	private String activityNm;
	private String activityStartDate;
	private String activityEndDate;
	private String projectStartDate;
	private String projectEndDate;
	private String lastDate;

	private String regPerRankNm;

	private String nextMonthEnd;

	private String searchOrgId;


	private String meetStartTime 		= ""; 	//회의실 예약 시작
	private String meetEndTime			= "";	//회의실 예약 종료
	private String meetingRoomId		= "";	//회의실 아이디
	private Integer rsvId				= 0;	//회의실 예약 아이디
	private String meetingRoomUseFlag	= "";	//회의실 사용 여부 플래그

	private String userSeq				= "";	//유저 시퀀스

	private String deptLevel;
	private String openFlag;
	private String employee;

	private String attendYn;  //현지출근 여부
	private String vacationYn;
	private String appvDocType;
	private String worktimeEndYn;

	//작성자 유저시퀀시
	private String regUserId;

	private String vipAuthYn;


	public String getMeetStartTime() {
		return meetStartTime;
	}
	public void setMeetStartTime(String meetStartTime) {
		this.meetStartTime = meetStartTime;
	}
	public String getMeetEndTime() {
		return meetEndTime;
	}
	public void setMeetEndTime(String meetEndTime) {
		this.meetEndTime = meetEndTime;
	}
	public String getMeetingRoomId() {
		return meetingRoomId;
	}
	public void setMeetingRoomId(String meetingRoomId) {
		this.meetingRoomId = meetingRoomId;
	}
	public Integer getRsvId() {
		return rsvId;
	}
	public void setRsvId(Integer rsvId) {
		this.rsvId = rsvId;
	}
	public String getMeetingRoomUseFlag() {
		return meetingRoomUseFlag;
	}
	public void setMeetingRoomUseFlag(String meetingRoomUseFlag) {
		this.meetingRoomUseFlag = meetingRoomUseFlag;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	public String getBeforePage() {
		return beforePage;
	}
	public void setBeforePage(String beforePage) {
		this.beforePage = beforePage;
	}

	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getCompanyNm() {
		return companyNm;
	}
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public String getContactLoc() {
		return contactLoc;
	}
	public void setContactLoc(String contactLoc) {
		this.contactLoc = contactLoc;
	}
	public String getParentPage() {
		return parentPage;
	}
	public void setParentPage(String parentPage) {
		this.parentPage = parentPage;
	}
	public String getPerSabun() {
		return perSabun;
	}
	public void setPerSabun(String perSabun) {
		this.perSabun = perSabun;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegDateStr() {
		return regDateStr;
	}
	public void setRegDateStr(String regDateStr) {
		this.regDateStr = regDateStr;
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
	public String getRegPerPhone() {
		return regPerPhone;
	}
	public void setRegPerPhone(String regPerPhone) {
		this.regPerPhone = regPerPhone;
	}
	public String getEditDate() {
		return editDate;
	}
	public void setEditDate(String editDate) {
		this.editDate = editDate;
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
	public String getSearchPerSabun() {
		return searchPerSabun;
	}
	public void setSearchPerSabun(String searchPerSabun) {
		this.searchPerSabun = searchPerSabun;
	}
	public String getSearchQuery() {
		return searchQuery;
	}
	public void setSearchQuery(String searchQuery) {
		this.searchQuery = searchQuery;
	}
	public String getsMSContent() {
		return sMSContent;
	}
	public void setsMSContent(String sMSContent) {
		this.sMSContent = sMSContent;
	}
	public String getHoliDocFlag() {
		return holiDocFlag;
	}
	public void setHoliDocFlag(String holiDocFlag) {
		this.holiDocFlag = holiDocFlag;
	}
	public String getScheSeq() {
		return scheSeq;
	}
	public void setScheSeq(String scheSeq) {
		this.scheSeq = scheSeq;
	}
	public String getScheGrpCd() {
		return scheGrpCd;
	}
	public void setScheGrpCd(String scheGrpCd) {
		this.scheGrpCd = scheGrpCd;
	}
	public String getScheGubun() {
		return scheGubun;
	}
	public void setScheGubun(String scheGubun) {
		this.scheGubun = scheGubun;
	}
	public String getScheGubunNm() {
		return scheGubunNm;
	}
	public void setScheGubunNm(String scheGubunNm) {
		this.scheGubunNm = scheGubunNm;
	}

	public String getMnaType() {
		return mnaType;
	}
	public void setMnaType(String mnaType) {
		this.mnaType = mnaType;
	}
	public String getIsMna() {
		return isMna;
	}
	public void setIsMna(String isMna) {
		this.isMna = isMna;
	}
	public String getScheSYear() {
		return scheSYear;
	}
	public void setScheSYear(String scheSYear) {
		this.scheSYear = scheSYear;
	}
	public String getScheSMonth() {
		return scheSMonth;
	}
	public void setScheSMonth(String scheSMonth) {
		this.scheSMonth = scheSMonth;
	}
	public String getScheSDay() {
		return scheSDay;
	}
	public void setScheSDay(String scheSDay) {
		this.scheSDay = scheSDay;
	}
	public String getScheSDate() {
		return scheSDate;
	}
	public void setScheSDate(String scheSDate) {
		this.scheSDate = scheSDate;
	}

	public String getScheSTime() {
		return scheSTime;
	}
	public void setScheSTime(String scheSTime) {
		this.scheSTime = scheSTime;
	}
	public String getScheEYear() {
		return scheEYear;
	}
	public void setScheEYear(String scheEYear) {
		this.scheEYear = scheEYear;
	}
	public String getScheEMonth() {
		return scheEMonth;
	}
	public void setScheEMonth(String scheEMonth) {
		this.scheEMonth = scheEMonth;
	}
	public String getScheEDay() {
		return scheEDay;
	}
	public void setScheEDay(String scheEDay) {
		this.scheEDay = scheEDay;
	}
	public String getScheEDate() {
		return scheEDate;
	}
	public void setScheEDate(String scheEDate) {
		this.scheEDate = scheEDate;
	}

	public String getScheETime() {
		return scheETime;
	}
	public void setScheETime(String scheETime) {
		this.scheETime = scheETime;
	}
	public String getScheAllTime() {
		return scheAllTime;
	}
	public void setScheAllTime(String scheAllTime) {
		this.scheAllTime = scheAllTime;
	}
	public String getSchePeriodFlag() {
		return schePeriodFlag;
	}
	public void setSchePeriodFlag(String schePeriodFlag) {
		this.schePeriodFlag = schePeriodFlag;
	}
	public String getScheTitle() {
		return scheTitle;
	}
	public void setScheTitle(String scheTitle) {
		this.scheTitle = scheTitle;
	}
	public String getScheArea() {
		return scheArea;
	}
	public void setScheArea(String scheArea) {
		this.scheArea = scheArea;
	}
	public String getScheCon() {
		return scheCon;
	}
	public void setScheCon(String scheCon) {
		this.scheCon = scheCon;
	}
	public String getScheRepetFlag() {
		return scheRepetFlag;
	}
	public void setScheRepetFlag(String scheRepetFlag) {
		this.scheRepetFlag = scheRepetFlag;
	}
	public String getScheRepetFlagNm() {
		return scheRepetFlagNm;
	}
	public void setScheRepetFlagNm(String scheRepetFlagNm) {
		this.scheRepetFlagNm = scheRepetFlagNm;
	}
	public String getScheAlarmFlag() {
		return scheAlarmFlag;
	}
	public void setScheAlarmFlag(String scheAlarmFlag) {
		this.scheAlarmFlag = scheAlarmFlag;
	}
	public String getScheAlarmFlagNm() {
		return scheAlarmFlagNm;
	}
	public void setScheAlarmFlagNm(String scheAlarmFlagNm) {
		this.scheAlarmFlagNm = scheAlarmFlagNm;
	}
	public String getScheAlarmHow() {
		return scheAlarmHow;
	}
	public void setScheAlarmHow(String scheAlarmHow) {
		this.scheAlarmHow = scheAlarmHow;
	}
	public String getScheAlarmHowNm() {
		return scheAlarmHowNm;
	}
	public void setScheAlarmHowNm(String scheAlarmHowNm) {
		this.scheAlarmHowNm = scheAlarmHowNm;
	}
	public String getScheImportant() {
		return scheImportant;
	}
	public void setScheImportant(String scheImportant) {
		this.scheImportant = scheImportant;
	}
	public String getScheImportantNm() {
		return scheImportantNm;
	}
	public void setScheImportantNm(String scheImportantNm) {
		this.scheImportantNm = scheImportantNm;
	}
	public String getScheChkFlag() {
		return scheChkFlag;
	}
	public void setScheChkFlag(String scheChkFlag) {
		this.scheChkFlag = scheChkFlag;
	}
	public String getScheChkDate() {
		return scheChkDate;
	}
	public void setScheChkDate(String scheChkDate) {
		this.scheChkDate = scheChkDate;
	}
	public String getSchePublicFlag() {
		return schePublicFlag;
	}
	public void setSchePublicFlag(String schePublicFlag) {
		this.schePublicFlag = schePublicFlag;
	}
	public String getProcFlag() {
		return procFlag;
	}
	public void setProcFlag(String procFlag) {
		this.procFlag = procFlag;
	}
	public String getCarUseFlag() {
		return carUseFlag;
	}
	public void setCarUseFlag(String carUseFlag) {
		this.carUseFlag = carUseFlag;
	}
	public String getCarNum() {
		return carNum;
	}
	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}
	public String getCarArriveTime() {
		return carArriveTime;
	}
	public void setCarArriveTime(String carArriveTime) {
		this.carArriveTime = carArriveTime;
	}
	public String getCarFloor() {
		return carFloor;
	}
	public void setCarFloor(String carFloor) {
		this.carFloor = carFloor;
	}
	public String getCarUsePerNm() {
		return carUsePerNm;
	}
	public void setCarUsePerNm(String carUsePerNm) {
		this.carUsePerNm = carUsePerNm;
	}
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public String[] getArrPerSabun() {
		return arrPerSabun;
	}
	public void setArrPerSabun(String[] arrPerSabun) {
		this.arrPerSabun = arrPerSabun;
	}

	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getCustomerNm() {
		return customerNm;
	}
	public void setCustomerNm(String customerNm) {
		this.customerNm = customerNm;
	}
	public String getTmpCpnNm() {
		return tmpCpnNm;
	}
	public void setTmpCpnNm(String tmpCpnNm) {
		this.tmpCpnNm = tmpCpnNm;
	}
	public String getTmpCstNm() {
		return tmpCstNm;
	}
	public void setTmpCstNm(String tmpCstNm) {
		this.tmpCstNm = tmpCstNm;
	}
	public String[] getChkboxStaff() {
		return chkboxStaff;
	}
	public void setChkboxStaff(String[] chkboxStaff) {
		this.chkboxStaff = chkboxStaff;
	}
	public String[] getArrSmsToNum() {
		return arrSmsToNum;
	}
	public void setArrSmsToNum(String[] arrSmsToNum) {
		this.arrSmsToNum = arrSmsToNum;
	}

	/**  재정의함 **/
	public String getCarId() {
		if(StringUtil.isEmpty(carId)) return null;
		else return carId;
	}
	public void setCarId(String carId) {
		this.carId = carId;
	}

	public String getTmpCpnId() {
		if(StringUtil.isEmpty(tmpCpnId)) return null;
		else return tmpCpnId;
	}
	public void setTmpCpnId(String tmpCpnId) {
		this.tmpCpnId = tmpCpnId;
	}
	public String getTmpCstId() {
		if(StringUtil.isEmpty(tmpCstId)) return null;
		else return tmpCstId;
	}
	public void setTmpCstId(String tmpCstId) {
		this.tmpCstId = tmpCstId;
	}
	public String getAppvDocId() {
		return appvDocId;
	}
	public void setAppvDocId(String appvDocId) {
		this.appvDocId = appvDocId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCarNumber() {
		return carNumber;
	}
	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}
	public String[] getArrRecieveUserId() {
		return arrRecieveUserId;
	}
	public void setArrRecieveUserId(String[] arrRecieveUserId) {
		this.arrRecieveUserId = arrRecieveUserId;
	}
	public String getSearchScheSTime() {
		return searchScheSTime;
	}
	public void setSearchScheSTime(String searchScheSTime) {
		this.searchScheSTime = searchScheSTime;
	}
	public String getSearchScheETime() {
		return searchScheETime;
	}
	public void setSearchScheETime(String searchScheETime) {
		this.searchScheETime = searchScheETime;
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
	public String getSelDay() {
		return selDay;
	}
	public void setSelDay(String selDay) {
		this.selDay = selDay;
	}

	public String getEventPage() {
		return eventPage;
	}
	public void setEventPage(String eventPage) {
		this.eventPage = eventPage;
	}
	public String getSearchScheSDate() {
		return searchScheSDate;
	}
	public void setSearchScheSDate(String searchScheSDate) {
		this.searchScheSDate = searchScheSDate;
	}
	public String[] getArrSearchPerSabun() {
		if(searchPerSabun != null){
			arrSearchPerSabun = searchPerSabun.split(",");
		}
		return arrSearchPerSabun;
	}
	public void setArrSearchPerSabun(String[] arrSearchPerSabun) {
		this.arrSearchPerSabun = arrSearchPerSabun;
	}
	public String getRecvUserId() {
		return recvUserId;
	}
	public void setRecvUserId(String recvUserId) {
		this.recvUserId = recvUserId;
	}
	public String getSendUserId() {
		return sendUserId;
	}
	public void setSendUserId(String sendUserId) {
		this.sendUserId = sendUserId;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getActivityId() {
		return activityId;
	}
	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}
	public String getProjectNm() {
		return projectNm;
	}
	public void setProjectNm(String projectNm) {
		this.projectNm = projectNm;
	}
	public String getActivityNm() {
		return activityNm;
	}
	public void setActivityNm(String activityNm) {
		this.activityNm = activityNm;
	}
	public String getActivityStartDate() {
		return activityStartDate;
	}
	public void setActivityStartDate(String activityStartDate) {
		this.activityStartDate = activityStartDate;
	}
	public String getActivityEndDate() {
		return activityEndDate;
	}
	public void setActivityEndDate(String activityEndDate) {
		this.activityEndDate = activityEndDate;
	}

	public String getNextMonthEnd() {
		return nextMonthEnd;
	}
	public void setNextMonthEnd(String nextMonthEnd) {
		this.nextMonthEnd = nextMonthEnd;
	}
	public String getProjectEndDate() {
		return projectEndDate;
	}
	public void setProjectEndDate(String projectEndDate) {
		this.projectEndDate = projectEndDate;
	}
	public String getProjectStartDate() {
		return projectStartDate;
	}
	public void setProjectStartDate(String projectStartDate) {
		this.projectStartDate = projectStartDate;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	public String getSearchOrgId() {
		return searchOrgId;
	}
	public void setSearchOrgId(String searchOrgId) {
		this.searchOrgId = searchOrgId;
	}
	public String getRegPerRankNm() {
		return regPerRankNm;
	}
	public void setRegPerRankNm(String regPerRankNm) {
		this.regPerRankNm = regPerRankNm;
	}
	public String getDeptLevel() {
		return deptLevel;
	}
	public void setDeptLevel(String deptLevel) {
		this.deptLevel = deptLevel;
	}
	public String getOpenFlag() {
		return openFlag;
	}
	public void setOpenFlag(String openFlag) {
		this.openFlag = openFlag;
	}
	public String getEmployee() {
		return employee;
	}
	public void setEmployee(String employee) {
		this.employee = employee;
	}
	public String getAttendYn() {
		return attendYn;
	}
	public void setAttendYn(String attendYn) {
		this.attendYn = attendYn;
	}
	public String getVacationYn() {
		return vacationYn;
	}
	public void setVacationYn(String vacationYn) {
		this.vacationYn = vacationYn;
	}
	public String getAppvDocType() {
		return appvDocType;
	}
	public void setAppvDocType(String appvDocType) {
		this.appvDocType = appvDocType;
	}
	public String getWorktimeEndYn() {
		return worktimeEndYn;
	}
	public void setWorktimeEndYn(String worktimeEndYn) {
		this.worktimeEndYn = worktimeEndYn;
	}
	public String getRegUserId() {
		return regUserId;
	}
	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}
	public String getVipAuthYn() {
		return vipAuthYn;
	}
	public void setVipAuthYn(String vipAuthYn) {
		this.vipAuthYn = vipAuthYn;
	}

}