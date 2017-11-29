<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="customTagUi" uri="/WEB-INF/tlds/ui.tld"%>

<form name="myForm" method="post">
	<input type="hidden" id="inputUserId" name="userId" value="">
	<div class="mo_container">
		<table class="tb_basic_left">
	    	<colgroup>
				<col width="150" />
				<col width="*" />
				<col width="170" />
				<col width="*" />
				<col width="140" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
		 			<th scope="row"><label for="inputEmpNo">사번</label></th>
		 			<td bgcolor="#F7F7F7">
		 				<input id="inputEmpNo" type="text" 	name="showEmpNo" placeholder="" value="" class="input_b w100pro" readonly="readonly" />
		 				<input id="inputEmpNo" type="hidden" name="empNo" placeholder="" value="" class="input_b w100pro" readonly="readonly" />
		 			</td>
		 			<th scope="row"><label for="inputLoginId">로그인 ID</label></th>
		 			<td bgcolor="#F7F7F7"><input id="inputLoginId" type="text" name="loginId" placeholder="" value="" class="input_b w100pro"  readonly="readonly"/></td>
		 			<th scope="row"><label for="inputUserName">이름</label></th>
		 			<td bgcolor="#F7F7F7"><input id="inputUserName" type="text" name="userName" placeholder="" value="" class="input_b w100pro"  readonly="readonly"/></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selLanguage">사용언어</label></th>
		 			<td id="languageSelectTag"></td>
		 			<th scope="row"><label for="selTimezone">시간대</label></th>
		 			<td id="timezoneSelectTag"></td>
		 			<th scope="row"><label for="selStatus">사용</label></th>
		 			<td id="statusSelectTag"></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="workViewYn">업무일지<br>전체열람</label></th>
		 			<td id="workViewYnSelectTag"></td>
		 			<th scope="row"><label for="cardViewYn">지출등록<br>전체열람</label></th>
		 			<td id="cardViewYnSelectTag"></td>
		 			<th scope="row"><label for="scheduleViewYn">근태<br>전체열람</label></th>
		 			<td id="scheduleViewYnSelectTag"></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selPayrollYn">급여대상</label></th>
		 			<td id="payrollYnSelectTag"></td>
					<th scope="row"><label for="selSystemYn">시스템사용</label></th>
		 			<td id="systemYnSelectTag"></td>
		 			<th scope="row"><label for="selwholeMemoViewYn">전사메모권한</label></th>
		 			<td id="wholeMemoViewYnSelectTag"></td>

		 		</tr>

		 		<tr>
		 			<th scope="row"><label for="selBusinessInfoLevel">영업정보조회권한</label></th>
		 			<td id="businessInfoLevelTag"></td>
		 			<th scope="row"><label for="selCustomerInfoLevel">고객정보조회권한</label></th>
		 			<td id="customerInfoLevelTag"></td>
					<th scope="row"><label for="selBoardInfoLevel">업무게시판조회권한</label></th>
		 			<td id="boardInfoLevelTag"></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selProjectYn">${baseUserLoginInfo.projectTitle}할당</label></th>
		 			<td id="projectYnSelectTag"></td>
		 					<th scope="row"><label for="">차량사용여부</label></th>
		 			<td id="carWorkYnSelectTag"></td>
		 			<th scope="row"><label for="selAttendYn">출근체크대상</label></th>
		 			<td id="attendYnSelectTag"></td>

		 		</tr>
		 		<tr>
					<th scope="row"><label for="selMobileAttend">모바일출근사용</label></th>
		 			<td id="mobileAttendSelectTag"></td>
		 			<th scope="row"><label for="selLoginAttend">PC출근사용</label></th>
		 			<td id="loginAttendSelectTag"></td>
					<th scope="row"><label for="selSecomAttend">세콤출근</label></th>
		 			<td id="secomAttendSelectTag"></td>
				</tr>

		 		<tr>

		 			<th scope="row"><label for="selExpenseYn">지출입력필수자</label></th>
		 			<td id="expenseYnSelectTag"></td>
		 			<th scope="row"><label for="selSecurityLogin">보안서버로그인</label></th>
		 			<td id="securityLoginSelectTag"></td>
		 			<th scope="row"><label for="selSingleSignOn">싱글사인온</label></th>
		 			<td id="singleSignOnSelectTag"></td>



		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selCostingYn">비용분석대상자</label></th>
		 			<td id="costingYnSelectTag"></td>
		 			<th scope="row"><label for="selTimesheetYn">타임시트필수자</label></th>
		 			<td id="timesheetYnSelectTag"></td>
		 			<th scope="row"><label for="selMakeProject">${baseUserLoginInfo.projectTitle}생성</label></th>
		 			<td id="makeProjectSelectTag"></td>

		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selCloseProject">${baseUserLoginInfo.projectTitle}마감</label></th>
		 			<td id="closeProjectSelectTag"></td>
		 			<th scope="row"><label for="selCloseTimesheet">타임시트마감</label></th>
		 			<td id="closeTimesheetSelectTag"></td>
		 			<th scope="row"><label for="selOpenCalendar">캘린더오픈</label></th>
		 			<td id="openCalendarSelectTag"></td>


		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selCloseCalendar">캘린더마감</label></th>
		 			<td id="closeCalendarSelectTag"></td>
		 			<th scope="row"><label for="bCardYn">법인카드소지여부</label></th>
		 			<td id="bCardYnSelectTag"></td>
		 			<th scope="row"><label for="bCardControl">법인카드관리대상여부</label></th>
		 			<td id="bCardControlSelectTag"></td>
		 		</tr>
			</tbody>
		</table>
		<div class="btnZoneBox">
			<customTagUi:authBtn txt="저장" orgId="${targetOrgId }" event="onclick='fnObj.doSave();'" ele="button" classValue="p_blueblack_btn" id="btnSave"/>
		</div>
	</div>
</form>





<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드(외,코드)
var comCodeLanguage;				//사용언어
var comCodeTimezone;				//시간대

var customerInfoLevelObj;			//고객정보 조회권한
var businessInfoLevelObj;			//영업정보 조회권한
var boardInfoLevelObj;				//업무게시판 조회권한

var codeYn;							//'Y', 'N'

var mode = "<c:out value='${mode==null?"new":mode}'/>";	//"new", "update"

var userInfoObj = "<c:out value='${userInfoObj}'/>";	//"update" mode 사용자 프로파일 정보

var empNo = "${empNo}";									//사번(사용자 관리에서 띄울때는, 사번만 받아와서 재조회(ajax)하도록 하는 방식)
var targetOrgId= "${targetOrgId}";						//사번의관계사
//Global variables :E ---------------

/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		comCodeLanguage = getBaseCommonCode('LANGUAGE', lang, 'CD', 'NM', null, '', '', { orgId : targetOrgId});		//사용언어 공통코드 (Sync ajax)
		comCodeTimezone = getBaseCommonCode('TIMEZONE', lang, 'CD', 'NM', null, '', '', { orgId : targetOrgId});		//시간대 공통코드 (Sync ajax)

		customerInfoLevelObj = getBaseCommonCode('CUSTOMER_INFO_LEVEL', lang, 'CD', 'NM', null, '', '', { orgId : targetOrgId});		//시간대 공통코드 (Sync ajax)
		boardInfoLevelObj = getBaseCommonCode('BOARD_INFO_LEVEL', lang, 'CD', 'NM', null, '', '',{ orgId : targetOrgId});		//시간대 공통코드 (Sync ajax)
		businessInfoLevelObj = getBaseCommonCode('BUSINESS_INFO_LEVEL', lang, 'CD', 'NM', null, '', '', { orgId : targetOrgId});		//시간대 공통코드 (Sync ajax)


		codeYn = [{'CD':'Y', 'NM':'Y'}, {'CD':'N', 'NM':'N'}];

		//사용언어
		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var languageSelectTag = createSelectTag('selLanguage', comCodeLanguage, 'CD', 'NM', '', '', colorObj, null, 'select_b w100pro', 'disabled');		//select tag creator 함수 호출 (common.js)
		$("#languageSelectTag").html(languageSelectTag);
		//시간대
		colorObj = {};
		var timezoneSelectTag = createSelectTag('selTimezone', comCodeTimezone, 'CD', 'NM', '', '', colorObj, null, 'select_b w100pro', 'disabled');		//select tag creator 함수 호출 (common.js)
		$("#timezoneSelectTag").html(timezoneSelectTag);

		//사용
		colorObj = {'Y':'#fffee0', 'N':'#EEEEEE'};
		var statusSelectTag = createSelectTag('selStatus', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');				//select tag creator 함수 호출 (common.js)
		$("#statusSelectTag").html(statusSelectTag);
		//급여대상
		var payrollYnSelectTag = createSelectTag('selPayrollYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
		$("#payrollYnSelectTag").html(payrollYnSelectTag);
		//시스템사용
		var systemYnSelectTag = createSelectTag('selSystemYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');			//select tag creator 함수 호출 (common.js)
		$("#systemYnSelectTag").html(systemYnSelectTag);

		//프로젝트할당
		var projectYnSelectTag = createSelectTag('selProjectYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
		$("#projectYnSelectTag").html(projectYnSelectTag);

		//프로젝트할당
		var carWorkYnSelectTag = createSelectTag('selCarWorkYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
		$("#carWorkYnSelectTag").html(carWorkYnSelectTag);

		//출근체크대상
		var attendYnSelectTag = createSelectTag('selAttendYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');			//select tag creator 함수 호출 (common.js)
		$("#attendYnSelectTag").html(attendYnSelectTag);
		//모바일출근사용
		var mobileAttendSelectTag = createSelectTag('selMobileAttend', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#mobileAttendSelectTag").html(mobileAttendSelectTag);
		//세콤출근
		var secomAttendSelectTag = createSelectTag('selSecomAttend', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#secomAttendSelectTag").html(secomAttendSelectTag);
		//PC출근연동
		var loginAttendSelectTag = createSelectTag('selLoginAttend', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#loginAttendSelectTag").html(loginAttendSelectTag);
		//보안서버로그인
		var securityLoginSelectTag = createSelectTag('selSecurityLogin', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');//select tag creator 함수 호출 (common.js)
		$("#securityLoginSelectTag").html(securityLoginSelectTag);
		//싱글사인온
		var singleSignOnSelectTag = createSelectTag('selSingleSignOn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');	//select tag creator 함수 호출 (common.js)
		$("#singleSignOnSelectTag").html(singleSignOnSelectTag);

		//업무일지 전체열람
		var workViewYnSelectTag = createSelectTag('workViewYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#workViewYnSelectTag").html(workViewYnSelectTag);
		//지출 전체열람
		var cardViewYnSelectTag = createSelectTag('cardViewYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');//select tag creator 함수 호출 (common.js)
		$("#cardViewYnSelectTag").html(cardViewYnSelectTag);
		//근태 전체열람
		var scheduleViewYnSelectTag = createSelectTag('scheduleViewYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#scheduleViewYnSelectTag").html(scheduleViewYnSelectTag);


		//출근체크대상 선택시
        $("#selAttendYn").change(function(){
        	fnObj.changeAttendYn();
        });
		//출근체크대상 관련항목 선택시
        $("#selMobileAttend").change(function(){
        	fnObj.changeAttendYnElse();
        });
        $("#selSecomAttend").change(function(){
        	fnObj.changeAttendYnElse();
        });
        $("#selLoginAttend").change(function(){
        	fnObj.changeAttendYnElse();
        });
        $("#selSecurityLogin").change(function(){
        	fnObj.changeAttendYnElse();
        });
        $("#selSingleSignOn").change(function(){
        	fnObj.changeAttendYnElse();
        });


		//지출입력필수자
		var expenseYnSelectTag = createSelectTag('selExpenseYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');		//select tag creator 함수 호출 (common.js)
		$("#expenseYnSelectTag").html(expenseYnSelectTag);
		//비용분석대상자
		var costingYnSelectTag = createSelectTag('selCostingYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
		$("#costingYnSelectTag").html(costingYnSelectTag);
		//타임시트필수자
		var timesheetYnSelectTag = createSelectTag('selTimesheetYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');	//select tag creator 함수 호출 (common.js)
		$("#timesheetYnSelectTag").html(timesheetYnSelectTag);
		//프로젝트 생성 권한
		var makeProjectSelectTag = createSelectTag('selMakeProject', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');	//select tag creator 함수 호출 (common.js)
		$("#makeProjectSelectTag").html(makeProjectSelectTag);
		//프로젝트 마감 권한
		var closeProjectSelectTag = createSelectTag('selCloseProject', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');	//select tag creator 함수 호출 (common.js)
		$("#closeProjectSelectTag").html(closeProjectSelectTag);
		//타임시트 마감 권한
		var closeTimesheetSelectTag = createSelectTag('selCloseTimesheet', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');	//select tag creator 함수 호출 (common.js)
		$("#closeTimesheetSelectTag").html(closeTimesheetSelectTag);
		//캘린더 오픈 권한
		var openCalendarSelectTag = createSelectTag('selOpenCalendar', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#openCalendarSelectTag").html(openCalendarSelectTag);
		//캘린더 마감 권한
		var closeCalendarSelectTag = createSelectTag('selCloseCalendar', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#closeCalendarSelectTag").html(closeCalendarSelectTag);

		//고객정보조회권한
		var customerInfoLevelTag = createSelectTag('selCustomerInfoLevel', customerInfoLevelObj, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#customerInfoLevelTag").html(customerInfoLevelTag);
		//영업관리조회권한
		var businessInfoLevelTag = createSelectTag('selBusinessInfoLevel', businessInfoLevelObj, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#businessInfoLevelTag").html(businessInfoLevelTag);
		//업무게시판조회권한
		var boardInfoLevelTag = createSelectTag('selBoardInfoLevel', boardInfoLevelObj, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#boardInfoLevelTag").html(boardInfoLevelTag);

		//법인카드 소지여부 권한
		var bCardYnSelectTag = createSelectTag('bCardYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');	//select tag creator 함수 호출 (common.js)
		$("#bCardYnSelectTag").html(bCardYnSelectTag);

		//법인카드 관리대상여부
		var bCardControlSelectTag = createSelectTag('bCardControl', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b', 'disabled');	//select tag creator 함수 호출 (common.js)
		$("#bCardControlSelectTag").html(bCardControlSelectTag);

	},


	//화면세팅
    pageStart: function(){


    },//end pageStart.

  	//################# init function :E #################


    //################# else function :S #################

  	//저장
    doSave: function(){

    	//-------------------- validation :S --------------------
    	var frm = document.myForm;

		/*
    	if(isEmpty(frm.loginId.value)){			//로그인ID
    		dialog.push({body:"<b>확인!</b> 로그인ID를 입력해주세요!", type:"", onConfirm:function(){frm.loginId.focus();}});
    		return;
    	}
    	*/
    	//-------------------- validation :E --------------------

    	var url = contextRoot + "/user/changeUserProfile.do";
    	var param = {
    			userId			: frm.userId.value,								//id
    			empNo			: frm.empNo.value,								//사번

    			userLang     	: frm.selLanguage.value,
    			timezone        : frm.selTimezone.value,
    			status          : frm.selStatus.value,
    			payrollYn       : frm.selPayrollYn.value,
    			systemYn        : frm.selSystemYn.value,
    			wholeMemoViewYn      : frm.selWholeMemoViewYn.value,
    			projectYn       : frm.selProjectYn.value,
    			carWorkYn       : frm.selCarWorkYn.value,
    			attendYn        : frm.selAttendYn.value,
    			mobileAttend    : frm.selMobileAttend.value,
    			secomAttend     : frm.selSecomAttend.value,
    			loginAttend     : frm.selLoginAttend.value,
    			securityLogin   : frm.selSecurityLogin.value,
    			singleSignOn    : frm.selSingleSignOn.value,
    			expenseYn       : frm.selExpenseYn.value,
    			costingYn       : frm.selCostingYn.value,
    			timesheetYn     : frm.selTimesheetYn.value,
    			makeProject		: frm.selMakeProject.value,
    			closeProject	: frm.selCloseProject.value,
    			closeTimesheet	: frm.selCloseTimesheet.value,
    			openCalendar  	: frm.selOpenCalendar.value,
    			closeCalendar 	: frm.selCloseCalendar.value,
    			bCardYn			: frm.bCardYn.value,
    			bCardControl	: frm.bCardControl.value,

    			businessInfoLevel	: frm.selBusinessInfoLevel.value,
    			customerInfoLevel	: frm.selCustomerInfoLevel.value,
    			boardInfoLevel		: frm.selBoardInfoLevel.value,

    			workViewYn			: frm.workViewYn.value,
    			cardViewYn			: frm.cardViewYn.value,
    			scheduleViewYn		: frm.scheduleViewYn.value

    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    		}

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			parent.fnObj.doSearch();					//목록화면 재조회 호출.
    			parent.myModal.close();						//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("저장OK!");
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSave


    //사용자 프로파일 정보 세팅하기	(infoObj 가 있는 경우는 사용자 관리(사용자등록)에서 사번으로 팝업시킨 경우)
    setUserProfileInfo: function(infoObj){
		var frm = document.myForm;
		var userInfo;

		if(infoObj == null){
			userInfo = JSON.parse(userInfoObj.replace(/&#034;/gi,'"'));
		}else{
			userInfo = infoObj;
		}

		//console.log(userInfo);

    	//사용자 프로파일정보 세팅
    	frm.userId.value = userInfo.userId;		//pk id

    	if(userInfo.orgId == "1"){
    		var colorObj = {};
    		//업무일지사용
    		var wholeMemoViewYnSelectTag = createSelectTag('selWholeMemoViewYn', codeYn, 'CD', 'NM', '', 'fnObj.selColorChnged(this)', colorObj, 50, 'select_b');		//select tag creator 함수 호출 (common.js)
    		$("#wholeMemoViewYnSelectTag").html(wholeMemoViewYnSelectTag);
    		}else{
    			var stStr = "<span>N</span><input type = 'hidden' name = 'selWholeMemoViewYn' value = 'N'>"
    			$("#wholeMemoViewYnSelectTag").html(stStr);
    		}

		frm.empNo.value = userInfo.empNo;
		frm.showEmpNo.value = userInfo.showEmpNo;
		frm.loginId.value = userInfo.loginId;
		frm.userName.value = userInfo.name;

		frm.selLanguage.value = userInfo.userLang;
		frm.selTimezone.value = userInfo.timezone;
		frm.selStatus.value = userInfo.status;
		frm.selPayrollYn.value = userInfo.payrollYn;
		frm.selSystemYn.value = userInfo.systemYn;
		frm.selWholeMemoViewYn.value = userInfo.wholeMemoViewYn;
		frm.selProjectYn.value = userInfo.projectYn;
		frm.selAttendYn.value = userInfo.attendYn;
		frm.selMobileAttend.value = userInfo.mobileAttend;
		frm.selSecomAttend.value = userInfo.secomAttend;
		frm.selLoginAttend.value = userInfo.loginAttend;
		frm.selSecurityLogin.value = userInfo.securityLogin;
		frm.selSingleSignOn.value = userInfo.singleSignOn;
		frm.selExpenseYn.value = userInfo.expenseYn;
		frm.selCostingYn.value = userInfo.costingYn;
		frm.selTimesheetYn.value = userInfo.timesheetYn;
		frm.selMakeProject.value = userInfo.makeProject;
		frm.selCloseProject.value = userInfo.closeProject;
		frm.selCloseTimesheet.value = userInfo.closeTimesheet;
		frm.selOpenCalendar.value = userInfo.openCalendar;
		frm.selCloseCalendar.value = userInfo.closeCalendar;
		frm.bCardYn.value = userInfo.bCardYn;
		frm.selCarWorkYn.value = userInfo.carWorkYn;

		frm.selBusinessInfoLevel.value = userInfo.businessInfoLevel;
		frm.selCustomerInfoLevel.value = userInfo.customerInfoLevel;
		frm.selBoardInfoLevel.value = userInfo.boardInfoLevel;

		frm.bCardControl.value = userInfo.bCardControl;

		frm.workViewYn.value = userInfo.workViewYn;
		frm.cardViewYn.value = userInfo.cardViewYn;
		frm.scheduleViewYn.value = userInfo.scheduleViewYn;


		//콤보박스 칼라 변경 (함수 호출)
		fnObj.selColorChnged(frm.selLanguage);
		fnObj.selColorChnged(frm.selTimezone);
		fnObj.selColorChnged(frm.selStatus);
		fnObj.selColorChnged(frm.selPayrollYn);
		fnObj.selColorChnged(frm.selSystemYn);
		if(userInfo.orgId == "1"){
			fnObj.selColorChnged(frm.selWholeMemoViewYn);
		}
		fnObj.selColorChnged(frm.selProjectYn);
		fnObj.selColorChnged(frm.selCarWorkYn);
		fnObj.selColorChnged(frm.selAttendYn);
		fnObj.selColorChnged(frm.selMobileAttend);
		fnObj.selColorChnged(frm.selSecomAttend);
		fnObj.selColorChnged(frm.selLoginAttend);
		fnObj.selColorChnged(frm.selSecurityLogin);
		fnObj.selColorChnged(frm.selSingleSignOn);
		fnObj.selColorChnged(frm.selExpenseYn);
		fnObj.selColorChnged(frm.selCostingYn);
		fnObj.selColorChnged(frm.selTimesheetYn);
		fnObj.selColorChnged(frm.selMakeProject);
		fnObj.selColorChnged(frm.selCloseProject);
		fnObj.selColorChnged(frm.selCloseTimesheet);
		fnObj.selColorChnged(frm.selOpenCalendar);
		fnObj.selColorChnged(frm.selCloseCalendar);
		fnObj.selColorChnged(frm.bCardYn);
		fnObj.selColorChnged(frm.bCardControl);

		fnObj.selColorChnged(frm.selBusinessInfoLevel);
		fnObj.selColorChnged(frm.selCustomerInfoLevel);
		fnObj.selColorChnged(frm.selBoardInfoLevel);

		fnObj.selColorChnged(frm.workViewYn);
		fnObj.selColorChnged(frm.cardViewYn);
		fnObj.selColorChnged(frm.scheduleViewYn);



    },//end getArticle



    //콤보박스 칼라 변경
    selColorChnged: function(obj){
    	//background-color
    	var styleStr = $("#" + obj.id + " > option[value='" + obj.value + "']").attr('style');
    	$(obj).attr('style', styleStr);
    },


  	//사용자 프로파일 정보 가져오기
    getUserProfileInfo: function(){

		var url = contextRoot + "/user/getUserProfile.do";
		var param = {empNo:empNo};


		var callback = function(result){

			var obj = JSON.parse(result);

			//세션로그아웃 >> 재로그인
			if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
				window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
				return;
			}


			var cnt = obj.resultVal;	//결과수
			var list = obj.resultList;	//결과데이터JSON

			if(list.length>0){
				fnObj.setUserProfileInfo(list[0]);	//사용자 프로파일 정보 세팅 함수 호출!
			}

		};

		commonAjax("POST", url, param, callback);
    },

    //출근체크관련 데이터 변경시
    changeAttendYn: function(){
    	var frm = document.myForm;
    	var  selAttendYn = frm.selAttendYn.value;
    	if(selAttendYn == "N"){
    		frm.selMobileAttend.value = "N";
    		frm.selSecomAttend.value = "N";
    		frm.selLoginAttend.value = "N";
    		frm.selSecurityLogin.value = "N";
    		frm.selSingleSignOn.value = "N";

    		fnObj.selColorChnged(frm.selAttendYn);
            fnObj.selColorChnged(frm.selMobileAttend);
            fnObj.selColorChnged(frm.selSecomAttend);
            fnObj.selColorChnged(frm.selLoginAttend);
            fnObj.selColorChnged(frm.selSecurityLogin);
            fnObj.selColorChnged(frm.selSingleSignOn);
    	}
    },
    //출근체크관련 데이터 변경시
    changeAttendYnElse: function(){
        var frm = document.myForm;
        var  selMobileAttend = frm.selMobileAttend.value;
        var  selSecomAttend = frm.selSecomAttend.value;
        var  selLoginAttend = frm.selLoginAttend.value;
        var  selSecurityLogin = frm.selSecurityLogin.value;
        var  selSingleSignOn = frm.selSingleSignOn.value;

        if(selMobileAttend == "Y" || selSecomAttend == "Y"  || selLoginAttend == "Y"  || selSecurityLogin == "Y"  || selSingleSignOn == "Y" ){
            frm.selAttendYn.value = "Y";

            fnObj.selColorChnged(frm.selAttendYn);
            fnObj.selColorChnged(frm.selMobileAttend);
            fnObj.selColorChnged(frm.selSecomAttend);
            fnObj.selColorChnged(frm.selLoginAttend);
            fnObj.selColorChnged(frm.selSecurityLogin);
            fnObj.selColorChnged(frm.selSingleSignOn);
        }

    }


  	//################# else function :E #################

};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅

	//수정모드일때 내용가져오기
	if(mode=="update"){
		if(userInfoObj.length>0){
			fnObj.setUserProfileInfo();		//부모창에서 가져온 데이터를 그대로 세팅해준다. set...
		}else if(empNo.length>0){
			fnObj.getUserProfileInfo();		//사용자번호(사번) 으로 데이터를 가져(ajax)온다. get...
		}
	}

});

</script>