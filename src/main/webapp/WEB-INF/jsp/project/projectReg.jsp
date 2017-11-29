<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>

<script type="text/javascript">
//도움말팝업토글
function showlayer(id)
{
	$("#"+id).toggle();
}
</script>
<style>
.selectDisabled{
	 pointer-events: none;
	 background:#e6e6e6!important;
}
</style>



<section id="detail_contents">
	<form name="myForm">
       	<h3 class="h3_table_title">
       		<span id="iconArea" >${baseUserLoginInfo.projectTitle} Management</span>
       		<a href="javascript:showlayer('helpProMgmt')" class="icon_question3 mgl5"><em>도움말</em></a>
     	<span class="tooltip">
			<div id="helpProMgmt" class="tooltip_box" style="display:none;">
				<span class="intext">
					<p class="title">1. 기간 </p>
					<ul class="list_st_dot3">
						<li>N 특별한 기간이 없이 언제든 하는 행동 (업무)</li>
						<li>확정 이후 : 기간 N -> Y 변경 불가 </li>
						<li>확정 이후 마감일 변경 : 마감일 이후 일정 존재 -> 변경 불가 </li>
						<li>마감일 : 시작일 ~ 종료일 기간 내 가능 </li>
					</ul>
					<p class="title">2. 예산</p>
					<ul class="list_st_dot3">
						<li>N 금액을 정하지 않고 사용가능</li>
						<li>확정 이후 ${baseUserLoginInfo.projectTitle} 예산 변경 : 지출된 금액보다 높게 설정</li>
						<li>${baseUserLoginInfo.projectTitle} 예산초과불가 : ${baseUserLoginInfo.activityTitle} 예산 금액 <= ${baseUserLoginInfo.projectTitle} 예산</li>
						<li>${baseUserLoginInfo.activityTitle} 예산 초과 허용 : ${baseUserLoginInfo.activityTitle} 예산 보다 높은 범위 허용</li>
						<li>${baseUserLoginInfo.activityTitle} 예산 초과 불가 : ${baseUserLoginInfo.activityTitle} 예산 내의 범위 허용</li>
					</ul>
					<p class="title">3. 지출</p>
					<ul class="list_st_dot3">
						<li>N ${baseUserLoginInfo.projectTitle} 내 종속된 ${baseUserLoginInfo.activityTitle}의 지출 금지</li>
						<li>확정 이후 지출이 있다면 N 변경 불가</li>
						<li>기간상관없음 : ${baseUserLoginInfo.projectTitle} 기간내 등록 가능</li>
						<li>기간내 : ${baseUserLoginInfo.activityTitle} 기간내 등록 가능</li>
					</ul>
					<p class="title">4. 직원배정</p>
					<ul class="list_st_dot3">
						<li>확정 이후 배정된 직원의 일정 존재 : 배정 직원 삭제 불가</li>
						<li>불가 직원 클릭 : 툴팁 (등록된 가장 마지막 일정 확인)</li>
					</ul>
				</span>
				<em class="edge_topcenter"></em>
				<a href="javascript:showlayer('helpProMgmt')" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a>
			</div>
		</span>
       </h3>

       	<table id="templateProject" class="tb_regi_temp" summary="Project Management, 프로젝트명, 설명, 기간, 타입, 예산, 타임시트, 지출표기, 사용여부, 참여직원">
           <caption>
               Project Management
           </caption>
           <colgroup>
               <col width="12%" />
               <col width="*" />
               <col width="12%" />
               <col width="28%" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row"><label for="inProjectName">${baseUserLoginInfo.projectTitle}명</label></th>
                   <td><input id="inProjectName" name="inProjectName" class="w100" maxlength="30"  placeholder="${baseUserLoginInfo.projectTitle} 명을 입력해주세요"></td>
                   <th scope="row"><label for="inProjectCode">${baseUserLoginInfo.projectTitle}코드</label></th>
                   <td><span id="v_projectCode">${baseUserLoginInfo.projectTitle}코드는 자동으로 채번 됩니다.</span>
                       <input type="hidden" id="inProjectCode" name="inProjectCode" class="w100" placeholder="${baseUserLoginInfo.projectTitle}코드는 자동으로 채번 됩니다."  readonly="readonly">
                   </td>
               </tr>
               <tr>
                   <th scope="row"><label for="inProjectDesc">설명</label></th>
                   <td><input id="inProjectDesc" name="inProjectDesc" class="w100" maxlength="80"  placeholder="${baseUserLoginInfo.projectTitle} 설명을 입력해 주세요" /></td>
                   <th scope="row">공개여부</th>
                   <td><span id="openRadioTag" class="radio_list"></span>
               </tr>
               <tr>
                   <th scope="row">기간</th>
                   <td>
	                   <span id="periodRadioTag" class="radio_list"></span>
		               <span id="periodPart">
	                   		<input type="text" id="inStartDate" readonly="readonly" class="input_date_type" title="시작일" /><a href="#" id="inStartBtn" onclick="fnObj.showDate('inStartDate');return false;" class="icon_calendar"><em>날짜선택</em></a> ~
	                   		<input type="text" id="inEndDate" readonly="readonly" class="input_date_type" title="종료일" onchange="fnObj.changeProjectDate('endDate');"/><a href="#" onclick="$('#inEndDate').datepicker('show');return false;" class="icon_calendar"><em>날짜선택</em></a>
		                    <strong id="calPeriod" class="mgl20 spe_color_st6 txt_letter0"></strong>
	                   </span>
	                   <strong class="noPeriodPart">N (무기한)</strong>
                   </td>

                   <!-- 일단 사용 정해지면 풀자 -->
                   <th scope="row">유형</th>
                   <td><span id="typeSelectTag" class="radio_list"></span>
                   </td>
               </tr>
               <tr>
                   <th scope="row"><label for="budgetAmt">예산</label></th>
                   <td>
                   		<span id="budgetRadioTag" class="radio_list"></span>
                   		<span id="budgetAmtPart">
                   			<input type="text" class="money_input_b number" id="budgetAmt" />원
                   		</span>
				   <th scope="row">마감일</th>
                   <td>
						<span id="closeCalendar">
							<!-- <input type="text" id="closeDate" readonly="readonly" class="input_date_type" title="마감일" onchange="fnObj.changeProjectDate('closeDate');" /> -->
							<input type="text" id="closeDate" readonly="readonly" class="input_date_type" title="마감일" />
							<a href="#" onclick="$('#closeDate').datepicker('show');return false;" class="icon_calendar"><em>날짜선택</em></a>
						</span>
						<strong class="noPeriodPart"> 무기한</strong>
                   </td>

                  <!-- 타임시트 구현까지 숨김처리 -->
                  <!--  <th scope="row">타임시트</th> -->
                   <td style="display:none;"><span id="timesheetRadioTag" class="radio_list"></span>
                   		<span id="overTsSelectTag"></span>
                   </td>
               </tr>
               <tr>
                   <th scope="row">지출</th>
                   <td><span id="expenseRadioTag" class="radio_list"></span><strong id="expenseTxtArea" class="mgr10" style="display:none;"></strong>
                   		<span id="overExSelectTag"></span>
                   		<span id="overExpenseSelectTag"></span>
                   		<span id="cardExpenseSumArea" class="current_expense mgl20"></span>		<!-- 지출금액 합계 영역 -->
                   </td>
                   <th scope="row">사용여부</th>
                   <td><span id="enableRadioTag" class="radio_list"></span>
               </tr>
               <tr>
                   <th scope="row">직원배정</th>
                   <td>
						<span id="employeeRadioTag" class="radio_list"></span>
						<strong id="employeeStatusArea" style="display:none;" class="mgr10"> 전 직원 </strong> <!-- 직원배정 여부 불가일때 표시  -->
						<!-- <a href="javascript:fnObj.openUserPopup(-1, 'project');" id="btn_select_employee_all" class="btn_select_employee2"><em>직원선택</em></a> -->
						<span id="v_employee_list"></span>
                   </td>

               </tr>
               <tr>
                   <th scope="row">지켜보는 직원</th>
                   <td>
						<a href="#" onclick="fnObj.openUserPopup(0);" class="btn_select_employee2 mgl6"><em>직원선택</em></a>
						<span id="v_viewEmployee_list"></span>
                   </td>
			   </tr>
           </tbody>
       </table>

       <!--/ Template Management /-->

       <!-- Activity Management -->
       <h3 class="h3_table_title2">${baseUserLoginInfo.activityTitle}</h3>
       <table id="SGridTarget" class="tb_regi_acti" summary="Activity Management 레벨, Activity, 기간, 예산, 지출, 타임시트, 사용여부, 직원배정, 추가/삭제">
           <caption>
               Activity Management
           </caption>
           <colgroup>
               <col width="5%" />     <!--레벨-->
               <col width="*" />    <!--Activity명-->
               <col width="214" />    <!--설명-->
               <col width="15%" />    <!--기간-->
               <col width="13%" />    <!--예산-->
               <col width="20%" />    <!--지출-->
           <%--     <col width="80" />     <!--타임시트--> --%>
               <col width="5%" />     <!--사용여부-->
               <col width="8%" />     <!--추가/삭제-->
           </colgroup>
           <thead>

           		<tr>
                   <th scope="col">레벨</th>
                   <th scope="col">${baseUserLoginInfo.activityTitle}명</th>
                   <th scope="col">설명</th>
                   <th scope="col">기간</th>
                   <th scope="col">예산</th>
                   <th scope="col">지출</th>
              	<!--    <th scope="col" style="display:none;">타임시트</th> -->
                   <th scope="col">사용여부</th>
                   <th scope="col">추가/삭제</th>
               </tr>

           </thead>
           <tfoot>
           		<tr>
           			<th colspan="4">합계</th>
           			<td class="txt_budget"><strong id="budgetSumArea">0</strong> <span>원</span></td>
           			<td class="txt_expense"><span>-</span> <strong id="expenseSumArea">0</strong> <span>원</span></td>
           			<td class="txt_total" colspan="2"><strong id="chargeSumArea">0</strong> <span>원</span></td>
           		</tr>
           </tfoot>
           <tbody>
				<%-- //// 내용  --%>
           </tbody>

       </table>
       <!--/ Activity Management /-->

       <div id="updatableMsg" style="display:none;"></div>

       <!-- 게시판 버튼 -->
       <div class="btn_baordZone2">
       	   <a href="#" id="tempSaveBtn" onclick="fnObj.doSave('N');return false;" class="btn_blueblack">임시저장</a>
           <a href="#" id="saveBtn" onclick="fnObj.doSave('Y');return false;" class="btn_blueblack btn_auth">확정</a>
           <a href="${pageContext.request.contextPath}/project/projectMgmt.do?me=35&mu=28&mr=26&v=2" class="btn_witheline">목록</a>
           <c:if test="${param.pId ne null}">
           <a href="#" id="deleteBtn" onclick="fnObj.doDelete();return false;" class="btn_witheline btn_del btn_auth" style="color:red!important;">삭제</a>
           </c:if>
       </div>
       <!--/ 게시판 버튼 /-->

		<div id = "activityLeaderArea">

		</div>
	</form>

</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')


var mode = "<c:out value='${param.pId==null?"new":"update"}'/>";	//"new", "update"	//템플릿 아이디가 넘어오는여부에 따라 모드 설정

var g_projectId = "${param.pId}";		//프로젝트 id
var g_orgId = "${baseUserLoginInfo.applyOrgId}";

var g_chgPeriod = 'N';					//기간수정가능 여부(수정 시 기간저장을 할지 판단)

var g_pjtEmpList = new Array();			//프로젝트 사용자 배정 정보를 객체로 담아두는 배열객체(저장시 서버로 보낸다)
var g_pjtEmpListDel = new Array();		//프로젝트 사용자 배정 정보를 객체로 담아두는 배열객체(저장시 서버로 보낸다) ... 삭제건

var chkOnLoadPage = "N";

var openFlagChk = "Y";

//공통코드 (외, 코드)
var codeYesNo;				//Yes or No
var codeYesNoForNm;
var codeChgPeriodYesNo;
var codeChgTimeSheetYesNo;
var codeOverExpenseYesNo;
var codeProjectType;
var codeOpenFlag;

var updateMngActivityChk = "N"; //업데이트할때 관리액티비티 존재 여부

var myModal = new AXModal();	// instance


var myGrid = new SGrid();		// instance		new sjs

var g_selUserIndex = -1;			//직원배정을 위해 직원선택 팝업시킨 row 의 index.
var g_projectConfirm = 'N';			//수정 전에 cofirm 값 .(DB에 입력된 값)
var g_projectCloseDate = '';
var g_beforeEndDate = new Date().yyyy_mm_dd();
var g_beforecloseDate = new Date().yyyy_mm_dd();

//임시저장 프로젝트에서 관리 액티비티를 추가하기위해 추가됨
var updateProjectConfirm = "Y";
var updateMngActivityData;

//리더선택 팝업일때..
var isLeaderPop = false;
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){

		//달력 세팅
		var nDate = new Date();

		fnObj.setDateShow('inStartDate',nDate);
		nDate.setMonth(nDate.getMonth()+1);
		fnObj.setDateShow('inEndDate',nDate);

		var closeDate = new Date(Date.parse(nDate)+7 *1000*60*60*24);

		fnObj.setDateShow('closeDate',closeDate);

		//코드
		codeYesNo = [{CD:'N', NM:'No'}, {CD:'Y', NM:'Yes'}];
		codeYesNoForNm = {N:'No',Y:'Yes'};					//화면에 NM 뿌려주기위해
		codeChgPeriodYesNo = [{CD:'Y', NM:'기간수정가능'}, {CD:'N', NM:'기간수정불가'}];
		codeChgTimeSheetYesNo = [{CD:'Y', NM:'기간상관없음'}, {CD:'N', NM:'기간내'}];
		codeOverExpenseYesNo = [{CD:'Y', NM:'예산초과허용'}, {CD:'N', NM:'예산초과불가'}];
		codeProjectType = getBaseCommonCode('PROJECT_TYPE', null, 'CD', 'NM', '', '선택','ALL', { orgId : g_orgId });
		codeOpenFlag = [{CD:'Y', NM:'공개'}, {CD:'N', NM:'비공개'}];

		var codeEmployee = [{CD:'A', NM:'전 직원'}, {CD:'Y', NM:'직원배정'}];


		var periodRadioTag = createRadioTag('rdPeriod', codeYesNo, 'CD', 'NM', 'Y', null, null, 'fnObj.clickRdPeriod(this);');			//radio tag creator 함수 호출 (common.js)
		$("#periodRadioTag").html(periodRadioTag);

		//공개여부
		var openRadioTag = createRadioTag('openFlag', codeOpenFlag, 'CD', 'NM', 'Y', null, null, 'fnObj.clickRdSelectSync(this,"openFlag");');			//radio tag creator 함수 호출 (common.js)
		$("#openRadioTag").html(openRadioTag);


		//예산
		var budgetRadioTag = createRadioTag('rdBudget', codeYesNo, 'CD', 'NM', 'Y', null, null, 'fnObj.clickRdSelectSync(this,"budget")');	//'fnObj.clickRdBudget(this);');			//radio tag creator 함수 호출 (common.js)
		$("#budgetRadioTag").html(budgetRadioTag);
		//타임시트
		var timesheetRadioTag = createRadioTag('rdTimesheet', codeYesNo, 'CD', 'NM', 'Y', null, null, 'fnObj.clickRdSelectSync(this,"timesheet");');	//radio tag creator 함수 호출 (common.js)
		$("#timesheetRadioTag").html(timesheetRadioTag);
		//지출표기
		var expenseRadioTag = createRadioTag('rdExpense', codeYesNo, 'CD', 'NM', 'Y', null, null, 'fnObj.clickRdSelectSync(this,"expense");');		//radio tag creator 함수 호출 (common.js)
		$("#expenseRadioTag").html(expenseRadioTag);
		//사용여부
		var enableRadioTag = createRadioTag('rdEnable', codeYesNo, 'CD', 'NM', 'Y', null, null, 'fnObj.clickRdSelectSync(this,"enable");');			//radio tag creator 함수 호출 (common.js)
		$("#enableRadioTag").html(enableRadioTag);
		//직원할당 여부
		var employeeRadioTag = createRadioTag('rdEmployee', codeEmployee, 'CD', 'NM', 'Y', null, null, 'fnObj.clickRdSelectSync(this,"employee");');	//radio tag creator 함수 호출 (common.js)
		$("#employeeRadioTag").html(employeeRadioTag);

		//기간수정가능여부
		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var chgPeriodSelectTag = createSelectTag('selChgPeriod', codeChgPeriodYesNo, 'CD', 'NM', 'Y', null, colorObj, null, 'select_b period');	//select tag creator 함수 호출 (common.js)
		$("#chgPeriodSelectTag").html(chgPeriodSelectTag);
		//유형
		var typeSelectTag = createSelectTag('selType', codeProjectType, 'CD', 'NM', 'Y', null, colorObj, null, 'select_b period');	//select tag creator 함수 호출 (common.js)
		$("#typeSelectTag").html(typeSelectTag);
		//기간수정가능여부(타임시트)
		var overTsSelectTag = createSelectTag('selOverTs', codeChgTimeSheetYesNo, 'CD', 'NM', 'Y', null, colorObj, null, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#overTsSelectTag").html(overTsSelectTag);
		//기간수정가능여부(지출표기)
		var overExSelectTag = createSelectTag('selOverEx', codeChgTimeSheetYesNo, 'CD', 'NM', 'Y', null, colorObj, null, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#overExSelectTag").html(overExSelectTag);
		//예산초과허용가능여부
		var overExpenseSelectTag = createSelectTag('selOverExpense', codeOverExpenseYesNo, 'CD', 'NM', 'Y', 'fnObj.clickRdSelectSync(this,"overExpense");', colorObj, null, 'select_b mgl6');	//select tag creator 함수 호출 (common.js)
		$("#overExpenseSelectTag").html(overExpenseSelectTag);
	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            {key:"lvl",				formatter:function(obj){return ('<input type="num" name="lvl" title="레벨" value="' + obj.value + '" readonly />');}},
            {key:"name", 			formatter:function(obj){
            							if(obj.item.activityId==null){
	            							var rdEmployee = $("input[name = 'rdEmployee']:checked").val();
	            							var openFlag = $("input[name = 'openFlag']:checked").val();
							            	if(obj.index==0){
							            		if(rdEmployee == "A"&&openFlag=="Y"){
							            			obj.value = "";
							            			obj.item.name = "";
							            		}else{
							            			obj.value = "${baseUserLoginInfo.projectTitle}관리";
							            			obj.item.name = "${baseUserLoginInfo.projectTitle}관리";
							            		}
							            	}
            							}
					            		return ('<input type="text" name="aName" class="active_input" value="' +obj.value + '" onchange="fnObj.syncActivityName(this, ' + obj.index + ');" placeholder="${baseUserLoginInfo.activityTitle}입력" title="${baseUserLoginInfo.activityTitle}입력" />');
					            	}
            },
            {key:"description",		formatter:function(obj){
						            	if(obj.item.activityId==null){
											var rdEmployee = $("input[name = 'rdEmployee']:checked").val();
											var openFlag = $("input[name = 'openFlag']:checked").val();
							            	if(obj.index==0){
							            		if(rdEmployee == "A"&&openFlag=="Y"){
							            			obj.value = "";
							            			obj.item.description = "";
							            		}else{
							            			obj.value = "${baseUserLoginInfo.projectTitle}관리";
							            			obj.item.description = "${baseUserLoginInfo.projectTitle}관리";
							            		}
							            	}
										}
					            		return ('<input type="text" name="aDesc" class="active_input" value="' + obj.value + '" onchange="fnObj.syncActivityDesc(this, ' + obj.index + ');" placeholder="${baseUserLoginInfo.activityTitle}설명" title="${baseUserLoginInfo.activityTitle}설명" />');
					            	}
            },

            {key:"period",			formatter:function(obj){

            							var disableYn = '';
            							var displayYn = '';

            							//확정이 된 프로젝트의 액티비티면
            							if(obj.item.confirm == 'Y'){
            								disableYn = ' disabled';					//수정불가
            								displayYn = ' style="display:none;"';		//달력가리기
            							}

            							var rStr = '<span>';
            							rStr+= '<input type="text" '+disableYn+' readonly id="inStartDate' + obj.index + '" value="' + obj.item.startDate + '" onchange="fnObj.syncStartDate(this,' + obj.index + ');" class="input_date_type" title="시작일" />';
            							rStr+= '<a href="#;" '+displayYn+' onclick="$(\'#inStartDate' + obj.index + '\').datepicker(\'show\');return false;" class="icon_calendar"><em>날짜선택</em></a></span>';
            							rStr+= '~ <span>';
            							rStr+= '<input type="text" '+disableYn+' readonly id="inEndDate' + obj.index + '" value="' + obj.item.endDate + '" onchange="fnObj.syncEndDate(this,' + obj.index + ');" class="input_date_type" title="종료일" />';
            							rStr+= '<a href="#;" '+displayYn+' onclick="fnObj.clickActCalendar('+obj.index+');return false;" class="icon_calendar"><em>날짜선택</em></a></span>';
            							rStr+= '<span class="activityCalArea" '+displayYn+'><a href="#;" '+displayYn+' onclick="javascript:fnObj.endDateForever(this,' + obj.index + ');" class="icon_calendar_forever mgl10">&nbsp;</a></span>';

            							return rStr;

            						}},

            {key:"budget",			formatter:function(obj){
            							var codeKnd = [{CD:'Y', NM:'Y'}, {CD:'N', NM:'N'}];
						            	var colorObj = {};
						            	var rStr = createSelectTag('selBudget'+(obj.index), codeKnd, 'CD', 'NM', obj.item.budget, 'fnObj.changeBudget(this,"' + obj.value + '",' + obj.index + ');', colorObj, null, 'yesno_select');			//select tag creator 함수 호출 (common.js)
						            	rStr += '<span name="spanBudget" style="' + (obj.value=='N'?'display:none':'') + '"><input type="text" class="money_input_b mgl6 number w100px" style="width:80px;" onchange="fnObj.syncBudgetAmt(this,' + obj.index + ');" id="budgetAmt' + obj.index + '" value="' + (obj.item.budgetAmt==null?'':obj.item.budgetAmt) + '" />원</span>';
						            	return rStr;
            						}},
            {key:"expense",			formatter:function(obj){
										var codeKnd = [{CD:'Y', NM:'Y'}, {CD:'N', NM:'N'}];
						            	var colorObj = {};
										var rStr = createSelectTag('selExpense'+(obj.index), codeKnd, 'CD', 'NM', obj.item.expense, 'fnObj.changeExpense(this,"' + obj.value + '",' + obj.index + ');', colorObj, null, 'yesno_select');		//select tag creator 함수 호출 (common.js)
						            	rStr += '<span name="spanOverExpense" id="spanOverExpenseArea'+obj.index+'"  style="' + (obj.value=='N' || obj.item.budget=='N'?'display:none':'') + '">' + createSelectTag('selOverExpense'+obj.index, codeOverExpenseYesNo, 'CD', 'NM', obj.item.overExpense, 'fnObj.changeOverExpense(this, ' + obj.index + ');', colorObj, null, 'select_b mgl6') + '</span>';	//select tag creator 함수 호출 (common.js);

						            	if(obj.item.cardExpenseSum != 0){
						            		rStr += '<span class="mgl10"><input type="text" readonly disabled class="" value=" 누적 지출 : '+Number(obj.item.cardExpenseSum).toLocaleString().split(".")[0]+'"/> 원 </span>';
						            	}


						            	return rStr;
									}},
            {key:"timesheet",		formatter:function(obj){
										var codeKnd = [{CD:'Y', NM:'Y'}, {CD:'N', NM:'N'}];
						            	var colorObj = {};
										return createSelectTag('selTimesheet'+(obj.index), codeKnd, 'CD', 'NM', obj.item.timesheet, 'fnObj.changeTimesheet(this,"' + obj.value + '",' + obj.index + ');', colorObj, null, 'yesno_select');//select tag creator 함수 호출 (common.js)
									}},
            {key:"enable",			formatter:function(obj){
										var codeKnd = [{CD:'Y', NM:'Y'}, {CD:'N', NM:'N'}];
						            	var colorObj = {};
										return createSelectTag('selEnable'+(obj.index), codeKnd, 'CD', 'NM', obj.item.enable, 'fnObj.changeEnable(this,"' + obj.value + '",' + obj.index + ');', colorObj, null, 'yesno_select');			//select tag creator 함수 호출 (common.js)
									}},
            {key:"employee",		formatter:function(obj){
										var codeKnd = [{CD:'Y', NM:'Y'}, {CD:'A', NM:'A'}];
						            	var colorObj = {};
						            	var disableYn = '';
						            	var rdEmployee =$("input[name = 'rdEmployee']:checked").val();
						            	var openFlag = $("input[name = 'openFlag']:checked").val();

						            	var mngActivityChk = "N";

						            	if(obj.item.activityId==null){

						            		obj.item.mngActivityFlag = "N";

						            		if(obj.index==0){
							            		if(rdEmployee == "A"&&openFlag=="Y"){
							            			mngActivityChk = "N";
							            			obj.item.mngActivityFlag = "N";
							            		}else{
							            			mngActivityChk = "Y";
							            			obj.item.mngActivityFlag = "Y";
							            			if(chkOnLoadPage!="Y"){
								            			var sessionUser = [{"activityId":"0","userId":${baseUserLoginInfo.userId},"defaultYn":"N","enable":"Y","userNm":"${baseUserLoginInfo.userName}","empNo":"${baseUserLoginInfo.empNo}","scheChk":"","apprChk":"","leaderYn":"N"}];
								            			g_selUserIndex = 0;

								            			fnObj.concatUserSelected(sessionUser,"FIRST");

								            			$("#btnUserDelete_${baseUserLoginInfo.userId}").hide();


							            			}
							            		}
							            	}else{
							            		if(rdEmployee == "A")  mngActivityChk = "N";
							            		else mngActivityChk = "Y";
							            	}

						            	}else{
											var employee = obj.item.employee;
						            		if(employee == "Y") mngActivityChk = "Y";
						            		else mngActivityChk = "N";

						            		if(obj.item.mngActivityFlag == "Y"){
						            			updateMngActivityChk ="Y";
						            			$("#btnUserDelete_${baseUserLoginInfo.userId}").hide();
						            		}
						            	}
						            	//프로젝트가 확정이고, 직원배정이 Y 면 셀렉트 disable 처리. -> 변경 무조건 상위 따라감.
						            	//if(obj.item.confirm == 'Y'){
						            		disableYn = 'selectDisabled';
						            	//}
						            	var rStr = createSelectTag('selEmployee'+(obj.index), codeKnd, 'CD', 'NM', obj.item.employee, 'fnObj.changeEmployee(this,"' + obj.value + '",' + obj.index + ');', colorObj, null, 'yesno_select ','disabled');	//select tag creator 함수 호출 (common.js)

						            	if(obj.item.activityId!=null){
						            		rStr+='<input type="hidden" name = "activityId" value = "'+obj.item.activityId+'">';
						            	}

						            	rStr += '<a href="#" onclick="fnObj.openUserPopup(' + obj.index + ');" class="btn_select_employee2 mgl6" style="' + (mngActivityChk=='N'?'display:none':'') + '"><em>직원선택</em></a>';

						            	rStr += '<a href="#" onclick="fnObj.openLeaderPopup(' + obj.index + ');" class="btn_select_leader mgl6" style="' + (mngActivityChk!='N'?'display:none':'') + '"><em>리더선택</em></a>';
						            	rStr += '<span id="selectedList' + (obj.index) + '"  style= "padding-left:10px;' + (mngActivityChk=='N'?'display:none;':'') + '">';

						            	//배정직원 리스트
					            		var empList = obj.item.empList;
					            		for(var i=0; i<empList.length; i++){
					            			rStr += '<span class="tooltip" ';
					            			if(obj.item.confirm == 'Y'){		//확정일때

					            				//-- 오늘 이후 스케쥴 이나 전자결재건이 있는지 --//
					            				if((empList[i].scheChk !='' & empList[i].scheChk !=undefined) || (empList[i].apprChk !=''  & empList[i].apprChk !=undefined)){

					            					rStr +=  ' onclick="fnObj.nameDetailDisplay('+obj.index+','+i+');"> <font color="#517dc6">' +empList[i].userNm +'</font>';

					            					//------ 툴팁 세팅  : S

					            				 	rStr +=' <div id="helpProMgmt" name="nameDetail'+obj.index+'_'+i+'" class="tooltip_box" style="display:none; width:200px;left:-110px;margin-left:0px;"> ';
					            					rStr +=' <span class="intext"> ';
					            					if(empList[i].scheChk !='' ){
					            						rStr +=' <ul class="list_st_dot3">';
					            						rStr +=' <li> 일정: '+empList[i].scheChk+'</li>';
					            						rStr +=' </ul>';
					            					}
					            					if(empList[i].apprChk !='' ){
					            						rStr +=' <ul class="list_st_dot3">';
					            						rStr +=' <li> 전자결재: '+empList[i].apprChk+'</li>';
					            						rStr +=' </ul>';
					            					}


					            					rStr +=' </span>';
					            					rStr +=' <em class="edge_topcenter"></em> ';
					            					rStr +=' <a href="#;" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a> ';


					            					rStr +=' </div> </span>';

					            					//------- 툴팁 세팅  : E


					            				}else{
					            					var activityPk;

					            					if(obj.item.activityId!=null) activityPk = obj.item.activityId;
					            					else activityPk = obj.index;

					            					rStr +='> '+"<input type = 'radio' class='mgr6' name = 'activityLeaderRadio_"+activityPk+"' value = '"+empList[i].userId;
					            					if(empList[i].leaderYn == "Y"){
				            							rStr += " checked = 'checked'"
				            						}

				            						rStr +="'>";

					            					rStr +=empList[i].userNm+'<a href="javascript:fnObj.delActivityUser(' + obj.index + ',' + empList[i].userId + ');" class="btn_delete_employee" style="' + (mngActivityChk=='Y'&&obj.index==0&&empList[i].userId == parseInt("${baseUserLoginInfo.userId}")?'display:none':'') + '"><em>삭제</em></a> </span> ';
					            				}
					            			}else{

					            				var activityPk;

				            					if(obj.item.activityId!=null) activityPk = obj.item.activityId;
				            					else activityPk = obj.index;

			            						rStr +='> ';
			            						rStr +="<input type = 'radio' class='mgr6' name = 'activityLeaderRadio_"+activityPk+"' value = '"+empList[i].userId;

			            						if(empList[i].leaderYn == "Y"){
			            							rStr += " checked = 'checked'";
			            						}

			            						rStr +="'>";
			            						rStr +=empList[i].userNm+'<a href="javascript:fnObj.delActivityUser(' + obj.index + ',' + empList[i].userId + ');" class="btn_delete_employee" style="' + (mngActivityChk=='Y'&&obj.index==0&&empList[i].userId == parseInt("${baseUserLoginInfo.userId}")?'display:none':'') + '"><em>삭제</em></a> </span> ';
				            				}
					            		}

						            	rStr += '</span>';

						            	rStr += '<span id="selectedAList' + (obj.index) + '"  style= "padding-left:10px;' + (mngActivityChk!='N'?'display:none;':'') + '">';
						            	var leaderCnt = 0;
						            	if(empList!=null && empList.length>0){
						            		for(var i=0; i<empList.length; i++){
						            			if(empList.leaderYn == "Y"){
						            				rStr += empList[i].userNm + "[리더]";

						            				rStr +="<input type = 'hidden' name = 'activityALeaderId_"+activityPk+"' value = '"+empList[i].userId;
				            						rStr +="'>";

				            						leaderCnt++;
						            			}
						            		}
						            	}
						            	if(leaderCnt==0){
						            		rStr +="<input type = 'hidden' name = 'activityALeaderId_"+activityPk+"' value = '";
		            						rStr +="'>";
						            	}
						            	rStr += '</span>';
										return rStr;
									}},
							
            {key:"btn",				formatter:function(obj){
            							var add = '<a href="#" onclick="fnObj.addActivity(null, ' + obj.item.level + ', ' + obj.index + ');return false;" class="btn_ac_add"><em>추가</em></a>';
            							var sub = '<a href="#" onclick="fnObj.delActivity(' + obj.index + ', ' + obj.item.level + ');return false;" class="btn_ac_delete" style="' + (obj.item.mngActivityFlag=='Y'?'display:none':'') + '"><em>삭제</em></a>';
            							var rStr = (obj.item.activityId==null?add+sub:add);		//수정시 추가만 가능하고, 신규등록은 추가/빼기 모두 가능.

	            							return rStr;
	            					}},
	        //데이터만
            {key:"level"			}
            ]

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<th scope="row" rowspan="2" class="vt">#[0]</th>';
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td>#[3]</td>';
    	rowHtmlStr +=	 '<td>#[4]</td>';
    	rowHtmlStr +=	 '<td>#[5]</td>';
    	rowHtmlStr +=	 '<td style="display:none;">#[6]</td>';
    	rowHtmlStr +=	 '<td>#[7]</td>';
    	rowHtmlStr +=	 '<td>#[9]</td>';
    	rowHtmlStr += 	 '</tr>';
    	rowHtmlStr += 	 '<tr>';
    	rowHtmlStr +=	 '<td colspan="7" style="text-align:left;">#[8]</td>';
    
        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;



    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------


    	//-------------------------- 그리드 초기 dummy 데이터 설정 :S ----------------------------
    	if(mode=="new"){

	    	var data = {
	    					lvl:'1',
	    					name:'',
	    					description:'',
	    					budget:'Y',
	    					budgetAmt:'',
	    					expense:'Y',
	    					overExpense:'Y',
	    					timesheet:'Y',
	    					confirm:'N',
	    					enable:'Y',
	    					employee:'Y',
	    					empList:[],
	    					empListDel:[],
	    					btn:'',
	    					cardExpenseSum : 0,
	    					scheChk : '',
	    					apprChk : '',
	    					mngActivityFlag : 'N'};

	    	data.level = 0;

	    	data.startDate = $('#inStartDate').val();		//프로젝트 기간 의 시작
	    	data.endDate = $('#inEndDate').val();			//프로젝트 기간 의 끝

	    	var idx = myGrid.addRow(data);


	    	fnObj.resetLevelAndClass();		//레벨 값 및 스타일 class 재세팅

	    	$(".activityCalArea").hide();	//초기 무기한 버튼 없애기
	    	$(".noPeriodPart").hide();		//무기한 알림창 없애기

	    	//datepicker 바인딩
    		fnObj.setDatePickerAct();				//기간 입력에 datepicker 사용

    	}
    	//-------------------------- 그리드 초기 dummy 데이터 설정 :E ----------------------------



    	//-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",
    		//openModalID:"kkkkk",
    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: true,
    		onclose: function(){

    		},
    		contentDivClass: "popup_outline"

    	});
    	//-------------------------- 모달창 :E -------------------------



    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

    //기간 끝날짜 수정.
    changeProjectDate : function(type){

    	//종료일 수정시
    	if(type == 'endDate'){
	    	if($("#inStartDate").val() > $("#inEndDate").val()){
	    		alert("시작일 이후로 선택해주세요.");
	    		$("#inEndDate").val('');
	    		return false;
	    	}

	    	var endDate = new Date($("#inEndDate").val());

	    	var closeDate = new Date(Date.parse(endDate)+7 *1000*60*60*24);

	    	$("#closeDate").val(closeDate.yyyy_mm_dd());
    	}

    	//종료일 수정시
    	if(type == 'closeDate'){

	    	if($("#closeDate").val() > $("#inEndDate").val()){
	    		alert("종료일 이전으로 선택해주세요.");
	    		if($("input[name=rdPeriod]:checked").val() == 'Y') $("#closeDate").val($("#inEndDate").val());
	    		return false;
	    	}
	    	if($("#closeDate").val() < $("#inStartDate").val()){
	    		alert("시작일 이후로 선택해주세요.");
	    		if($("input[name=rdPeriod]:checked").val() == 'Y') $("#closeDate").val($("#inStartDate").val());
	    		return false;
	    	}
    	}

    	g_beforeEndDate = $("#inEndDate").val();
    	g_beforecloseDate = $("#closeDate").val();

    	//끝날짜 변경시 마감날짜 변경(기간 Y 일때)
    	//if($("input[name=rdPeriod]:checked").val() == 'Y' && type == 'endDate') $("#closeDate").val($("#inEndDate").val());

    },


  	//activity row 추가
    addActivity: function(obj, level, fromIndex){

    	var inStartDate = $('#inStartDate').val();							//시작일
    	var inEndDate = $('#inEndDate').val();    							//종료일

  		var budget = $(':radio[name=rdBudget]:checked').val();				//예산					//$('#v_budget').html();	//예산 ... 'No' 이 아니면 'Yes'

  		var expense = $('input:radio[name=rdExpense]:checked').val();		//지출					//$('#v_expense').html();
  		var overExpense = $('#selOverExpense').val();						//예산초과허용 여부

  		var timesheet = $('input:radio[name=rdTimesheet]:checked').val();	//타임시트					$('#v_timesheet').html();
  		var enable = $('input:radio[name=rdEnable]:checked').val();			//사용여부					$('#v_enable').html();
  		var employee = $('input:radio[name=rdEmployee]:checked').val();		//직원배정					$('#v_employee').html();


    	var list = myGrid.dataList;


    	var data = {  lvl:''
    			  	, name:''
    			  	, description:''
    				, startDate: inStartDate
    				, endDate: inEndDate
					, budget: budget					//(budget=='No'?'N':'Y')
					, budgetAmt: ''
					, expense: expense
					, overExpense: overExpense
					, timesheet: timesheet
					, enable: enable
					, employee: employee
					, confirm: 'N'
					, empList: g_pjtEmpList.slice(0)	//[]		//직원배정
					, empListDel: []					//직원배정(삭제할건)
					, btn:''
					, cardExpenseSum : 0
					, scheChk : ''					//스케쥴 체크
					, apprChk : ''					//전자결재 체크
					, mngActivityFlag : 'N'
    	};

		data.level = level;

    	var idx = -1;
    	if(level == 0){			// ----------- level 0 인 activity 의 추가버튼을 클릭

    		var nIdx = fnObj.getIndexToLvl0(fromIndex);
    		myGrid.insertRow(data, nIdx);


        	/* $(".number").keyup(function(e) {
        		if(value!=''){
	      		  var value =e.target.value;	// 입력 값 알아내기
	      		  var result = addComma(value.replace(/,/gi,''));	// 천단위 콤마 추가한 결과값 리턴
	      		  if(result != undefined) e.target.value=result;
	      		  else e.target.value ='' ;
        		}
      		}); */


    	}else{					// ----------- level 1 인 activity 의 추가버튼을 클릭

    		if(list.length == fromIndex+1){	//마지막 activity 에서 추가버튼을 누른케이스
    			data.lvl = (1 * list[fromIndex].lvl) + 1;
    			idx = myGrid.addRow(data);

    		}else if(list[fromIndex + 1].level == 0){	//다음 activity 의 레벨이 0인 케이스

    			data.lvl = (1 * list[fromIndex].lvl) + 1;
    			idx = fromIndex + 1;
    			myGrid.insertRow(data, idx);

    		}else{

    			data.lvl = (1 * list[fromIndex].lvl) + 1;
    			idx = fromIndex + 1;
    			myGrid.insertRow(data, idx);
    		}

    	}


    	fnObj.resetLevelAndClass();		//레벨 값 및 스타일 class 재세팅

    	fnObj.setDisableSync();			//컬럼 활성화 일괄 변경

    	//datepicker 바인딩
		fnObj.setDatePickerAct();			//기간 입력에 datepicker 사용




    },//addActivity


    //0 레벨이 들어갈 index 반환 함수
    getIndexToLvl0: function(fromIndex){
    	var list = myGrid.dataList;

    	for(var i=fromIndex; i<list.length; i++){
    		if(i+1 == list.length || list[i+1].level != 1){
    			return (i+1);
    		}
    	}
    },


    //레벨 값 및 스타일 class 재세팅
    resetLevelAndClass: function(){

    	var list = myGrid.dataList;
    	var data;

    	var level;
    	var lvl;
    	var sort;

    	var cntLvl0 = 0;
    	var cntLvl1 = 0;

    	for(var i=0; i<list.length; i++){

    		level = list[i].level * 1;

    		switch(level){		//해당 레벨의 값을 1증가, 하위는 0 초기화... (cntLvl0 * 100 + cntLvl1 * 10 + cntLvl2) 가 sort(정렬)값이 된다.
	    		case 0: cntLvl0 ++;
	    				cntLvl1 = 0;

	    				lvl = cntLvl0;		//lvl
	    				break;

	    		case 1: cntLvl1 ++;

	    				lvl = cntLvl1;		//lvl
	    				break;
    		}
    		sort = (cntLvl0 * 100 + cntLvl1).toString();

    		list[i].lvl = lvl;			//lvl 세팅
    		list[i].sort = sort;		//sort 세팅


    		//레벨 input 데이터 세팅
    		$(myGrid.gridBodyObject.find('input[name=lvl]')[i]).val(lvl);


    		//class 스타일 세팅
    		if(level == 0){
    			$(myGrid.gridBodyObject.children('tr')).addClass('level_first');

    		}else{	//level == 1

    			var tr = $(myGrid.gridBodyObject.children('tr')[i]);
    			tr.removeClass('level_second');		//init
    			tr.removeClass('level_second_end');	//init

    			if(list.length == i+1){	//마지막 activity
        			tr.addClass('level_second_end');

        		}else if(list[i + 1].level == 0){	//다음 activity 의 레벨이 0인 케이스
        			tr.addClass('level_second_end');

        		}else{
        			tr.addClass('level_second');
        		}
    		}


    	}//for

    },


  	//0레벨(level_first) row 삭제
    delActivity: function(index, level){

    	//------- 0 레벨갯수가 1개뿐이면(지우려는게 자신이면) 지울 수 없도록 -----
    	var list = myGrid.dataList;
    	var cnt = 0;
    	for(var i=0; i<list.length; i++){
    		if(list[i].level == 0){		//자식이면
    			cnt++;					//counting up
    		}
    	}
    	if(cnt<=1 && level==0){
    		dialog.push({body:"<b>삭제불가</b> <br>최소한 1개의 activity는 존재해야합니다!", type:'Caution', onConfirm:function(){}});
    		return;
    	}
    	//-----------------------------------------------------------------


    	if(level == 0){		//자신을 포함한 자식노드까지 삭제

    		var childCnt = fnObj.getChildActivityCnt(index);

    		if(childCnt>0){
    			dialog.push({
        		    body:'<b>Caution</b>&nbsp;&nbsp;자식activity 가 존재합니다. 함께 삭제하시겠습니까?', top:0, type:'Caution', buttons:[
                        {buttonValue:'확인', buttonClass:'Red', onClick:fnObj.delActivityNChild, data:{fromIndex:index, cnt:childCnt}},	//, data:{param:"222"}},	//Red W100
                        {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}	//, data:'data2'},
        		    ]});

    		}else{


    			//-- row 삭제시 해당 row에 있던 직원리스트 삭제 액션.
    			var list = myGrid.getList();
    			var empList = list[index].empList;

    			var deleteUserList =[];
    			for(var i=0;i<empList.length;i++){
    				deleteUserList.push(empList[i].userId);

    			}

    			for(var i=0;i<deleteUserList.length;i++){
    				fnObj.delActivityUser(index, deleteUserList[i]);	//index - row
    			}
    			myGrid.dataList.remove(index);


        		fnObj.refreshActivityGrid();		//activity 그리드 refresh
    		}


    	}else{	//level == 1	... 자신노드 만 삭제

    		myGrid.dataList.remove(index);

    		fnObj.refreshActivityGrid();		//activity 그리드 refresh

    	}

    },

    //activity 삭제(0레벨 및 그 자식레벨)
    delActivityNChild: function(paramObj){
    	var fromIndex = paramObj.fromIndex;
    	var cnt = paramObj.cnt;

		for(var i=fromIndex+cnt; i>=fromIndex; i--){
			myGrid.dataList.remove(i);
		}

		fnObj.refreshActivityGrid();		//activity 그리드 refresh
    },

    //activity 그리드 refresh
    refreshActivityGrid: function(){

		myGrid.refresh();

    	fnObj.resetLevelAndClass();		//레벨 값 및 스타일 class 재세팅

    	fnObj.setDisableSync();			//컬럼 활성화 일괄 변경

    	//datepicker 바인딩
		fnObj.setDatePickerAct();			//기간 입력에 datepicker 사용
    },

    //0레벨의 자식레벨의 갯수 구하는 함수
    getChildActivityCnt: function(fromIndex){
		var list = myGrid.dataList;
    	var cnt = 0;
    	for(var i=fromIndex+1; i<list.length; i++){
    		if(list[i].level == 1){		//자식이면
    			cnt++;					//counting up
    		}else{
    			break;
    		}
    	}

    	return cnt;
    },

    //------------------------------- sync data :S --------------------------------

    //name sync
    syncActivityName: function(obj, index){
    	myGrid.dataList[index].name = obj.value;
    },

  	//description sync
    syncActivityDesc: function(obj, index){
    	myGrid.dataList[index].description = obj.value;
    },

    //budget sync
    changeBudget: function(obj, val, index){
    	myGrid.dataList[index].budget = obj.value;
    	var td = $(obj).parent();
    	if(obj.value =='N'){
    		td.children('span[name=spanBudget]').hide();
    		$("#spanOverExpenseArea"+index).hide();											//예산이 N 이면 지출에 예산에 대한 셀렉 숨기기
    	}else{
    		td.children('span[name=spanBudget]').show();
    		if($("#selExpense"+index).val() !='N') $("#spanOverExpenseArea"+index).show();	//예산이 Y 이면서 지출 N 이 아니면. 예산에 대한 표시
    	}

    	fnObj.setTotalPrice();		//하단 금액 세팅
    },

    //budgetAmt sync
    syncBudgetAmt: function(obj, index){

    	var chk = true;

    	if(myGrid.dataList[index].cardExpenseSum > obj.value && $("#selOverExpense"+index).val() == 'N' && $("#selExpense"+index).val() == 'Y'){		//이미 쓴 금액 보다 예산이 적고, 예산초과 불가일때
    		chk = false;
    		alert("이미 지출한 금액보다 크게 설정해주세요.");
    		$("#budgetAmt"+index).val(myGrid.dataList[index].budgetAmt);
    		$("#budgetAmt"+index).focus();
    		return;

    	}

    	if(chk){
    		myGrid.dataList[index].budgetAmt = obj.value;
    		fnObj.setTotalPrice();		//하단 금액 세팅
    	}
    },

  	//expense sync
    changeExpense: function(obj, val, index){
    	myGrid.dataList[index].expense = obj.value;


    	var td = $(obj).parent();

    	if(myGrid.dataList[index].cardExpenseSum >0 && obj.value =='N'){ //지출이 있는데 변경ㅇ 하려는 경우.
    		alert("이미 지출이 있어 변경 불가합니다.");
    		$("#selExpense"+index).val('Y');			//select Y
    		return;
    	}

    	if(obj.value =='Y' && $("#selBudget"+index).val() !='N'){    	//지출이 Y 이면서.  예산이 N 이 아니면 예산에대한 셀렉트 표시
    		td.children('span[name=spanOverExpense]').show();
    	}else{
    		td.children('span[name=spanOverExpense]').hide();
    	}

    },

    //overExpense sync
    changeOverExpense: function(th, index){

 		var chk = true;

 		//예산 Y 이고, 이미 쓴 금액 보다 예산이 적고, 예산초과 불가로 변경 시
    	if(myGrid.dataList[index].cardExpenseSum > myGrid.dataList[index].budgetAmt && $("#selOverExpense"+index).val() == 'N' && $("#selBudget"+index).val() == 'Y'){
    		chk = false;
    		alert("이미 지출한 금액이 예산보다 큽니다.예산금액을 변경 후 변경해주세요.");
    		$("#budgetAmt"+index).focus();
    		return;

    	}

    	if(chk)	myGrid.dataList[index].overExpense = th.value;

    },

  	//timesheet sync
    changeTimesheet: function(obj, val, index){
    	myGrid.dataList[index].timesheet = obj.value;
    },

  	//enable sync
    changeEnable: function(obj, val, index){
    	myGrid.dataList[index].enable = obj.value;
    },

  	//employee sync
    changeEmployee: function(obj, val, index){
    	myGrid.dataList[index].employee = obj.value;
    	var td = $(obj).parent();
    	if(obj.value =='A'){
    		td.children('a').hide();
    		td.children('div').hide();

    		var list = myGrid.getList();
    		var empList = list[index].empList;
    		var deleteList = [];
    		for(var i=0;i<empList.length;i++){
    			deleteList.push(empList[i].userId);
    		}

    		for(var i=0;i<deleteList.length;i++) fnObj.delActivityUser(index,deleteList[i]);

    	}else{
    		td.children('a').show();
    		td.children('div').show();
    	}


    	/////// 해당 row 직원배정 정보는 초기화 ///////
    	myGrid.dataList[index].empList = [];
    	myGrid.dataList[index].empListDel = [];

    	fnObj.refreshGrid();		//sync
    },

    //startDate
    syncStartDate: function(obj, index){
    	var inStartDate = $('#inStartDate').val();
    	if(inStartDate > obj.value){
    		dialog.push({body:"<b>확인!</b> 시작일은 ${baseUserLoginInfo.projectTitle}의 시작일보다 이전일 수 없습니다!", type:"", onConfirm:function(){$(obj).select();}});
    		return;
    	}
    	myGrid.dataList[index].startDate = obj.value;
    },

  	//endDate
    syncEndDate: function(obj, index){
    	var inEndDate = $('#inEndDate').val();
    	if(inEndDate < obj.value){
    		dialog.push({body:"<b>확인!</b> 종료일은 ${baseUserLoginInfo.projectTitle}의 종료일보다 이후일 수 없습니다!", type:"", onConfirm:function(){$(obj).select();}});
    		$('#inEndDate'+index).val('');
    		return;
    	}
    	myGrid.dataList[index].endDate = obj.value;
    },

    //종료일 무한대
    endDateForever: function(obj, index){
    	if($('input:radio[name=rdPeriod]:checked').val() == 'Y'){		//기간 'Y' 일때
    		dialog.push({body:"<b>확인!</b> 종료일은 ${baseUserLoginInfo.projectTitle}의 종료일보다 이후일 수 없습니다!", type:"", onConfirm:function(){}});
    		return;
    	}else{
    		myGrid.dataList[index].endDate = '9999-12-31';
  			//$("#inEndDate" + index).datepicker('setDate', makeDate(5, "99991231"));		//기간없을시 무기한으로.
  			$("#inEndDate" + index).val('9999-12-31');
    	}
    },

    //최하단 금액 세팅
    setTotalPrice : function(){
    	var list = myGrid.getList();

    	var budgetSum = 0;		//예산 합계
    	var expenseSum = 0;		//지출 합계

    	for(var i=0;i<list.length;i++){
    		if(list[i].budget == 'Y' && list[i].budgetAmt !='' && list[i].budgetAmt !=null)budgetSum += parseInt(list[i].budgetAmt);
    		if(list[i].cardExpenseSum !='' && list[i].cardExpenseSum !=null)expenseSum += parseInt(list[i].cardExpenseSum);
    	}
    	var chargeSum = parseInt(budgetSum)-parseInt(expenseSum);

    	$("#budgetSumArea").html(Number(budgetSum).toLocaleString().split(".")[0]);
    	$("#expenseSumArea").html(Number(expenseSum).toLocaleString().split(".")[0]);
    	$("#chargeSumArea").html(Number(chargeSum).toLocaleString().split(".")[0]);		//남은 금액

    },
  	//------------------------------- sync data :E --------------------------------


  	//------------------------------- click radio :S ------------------------------
  	//기간
  	clickRdPeriod: function(obj){



  		if(obj.value == 'N'){

  			$('#periodPart').hide();
  			$('#closeCalendar').hide();
  			$('.activityCalArea').show();

  			g_beforeEndDate= $("#inEndDate").val();			//변경 전에 기간을 담아둔다.
  			g_beforecloseDate= $("#closeDate").val();		//변경 전에 기간을 담아둔다.


  			//기간 ... 지금부터 9999년까지
  			if(g_projectConfirm != 'Y') $("#inStartDate").datepicker('setDate', new Date());

  			$("#inEndDate").datepicker('setDate', makeDate(5, "99991231"));		//기간없을시 무기한으로
  			$("#closeDate").datepicker('setDate', makeDate(5, "99991231"));		//기간없을시 무기한으로

  			$("#overExSelectTag").hide();										//기간이 N 일때 지출에 기간없음 셀렉트 숨기기

  		}else{	//obj.value == 'Y'

  			$('#periodPart').show();
  			$('#closeCalendar').show();
  			$('.activityCalArea').hide();
  			//기간 ... 기본..지금부터 한달

  			if(g_projectConfirm != 'Y'){
  				$("#inStartDate").datepicker('setDate', new Date());

  				if(g_beforecloseDate>'9990-01-03'){				//무기한으로 되어있다면 시작날짜 1달 후로 세팅
  					var nDate = new Date();
  	  	  			nDate.setMonth(nDate.getMonth()+1);
  	  				$("#inEndDate").datepicker('setDate', nDate);
  	  				$("#closeDate").datepicker('setDate', nDate);
  				}else{
  					$("#inEndDate").datepicker('setDate', g_beforeEndDate);
  					$("#closeDate").datepicker('setDate', g_beforecloseDate);
  				}

  			}else{
  				$("#inEndDate").datepicker('setDate', g_beforeEndDate);
  		  		$("#closeDate").datepicker('setDate', g_beforecloseDate);
  			}

  			$("#overExSelectTag").show();

  			var list = myGrid.getList();

  			for(var i=0;i<list.length;i++){
  				if(list[i].endDate > $("#inEndDate").val()){
  					$("#inEndDate"+i).datepicker('setDate', $("#inEndDate").val()); // $("#inEndDate"+i).val($("#inEndDate").val());
  					myGrid.dataList[i].endDate = $("#inEndDate").val();
  				}
  			}
  		}
  	},


  	//변경 (예산, 지출, 타임시트, 사용여부, 직원배정)
  	clickRdSelectSync: function(obj, knd){
  		//기간관련 콤보박스 visible 변경
  		if(knd == 'timesheet'){				//타임시트 변경
  			if(obj.value == 'N'){
  	  			$('#selOverTs').hide();

  	  		}else{	//obj.value == 'Y'
  	  			$('#selOverTs').show();
  	  		}

  		}else if(knd == 'expense'){			//지출 변경
  			if(obj.value == 'N'){
  	  			$('#selOverEx').hide();				//기간상관여부
  	  			$('#overExpenseSelectTag').hide();		//예산초과허용 여부
  	  		}else{	//obj.value == 'Y'
  	  			$('#selOverEx').show();				//기간상관여부
  	  		if($('input[name=rdBudget]:checked').val() == 'Y') $('#overExpenseSelectTag').show();		//예산초과허용 여부
  	  		}

  		}else if(knd == 'budget'){			//예산 변경
  			if(obj.value == 'N'){
  				$('#budgetAmtPart').hide();
  				$('#overExpenseSelectTag').hide();

  	  		}else{	//obj.value == 'Y'
  	  			$('#budgetAmtPart').show();
  	  			if($('input[name=rdExpense]:checked').val() == 'Y') $('#overExpenseSelectTag').show();
  	  		}

  		}else if(knd == 'employee'){		//직원 배정
  			if(obj.value == 'A'){

  				if($("input[name='openFlag']:checked").val() == "N"){
  					dialog.push({body:"<b>확인!</b> 비공개${baseUserLoginInfo.projectTitle}는 전 직원을 배정할수 없습니다!", type:""});

  					//$("input[name='rdEmployee'][value='Y']").prop("checked",true);
					$("input[name='rdEmployee'][value='Y']").prop("checked",true).click();

					return;
  				}


  				$('#v_employee_list').hide();		//직원선택 버튼

  				//직원 삭제 액션
  				/* var list = g_pjtEmpList.clone();
  				for(var i=0; i<list.length; i++){
  					fnObj.delProjectUser(list[i].userId);
  		    	} */

  			}else{	//obj.value == 'Y'
  	  			$('#v_employee_list').show();  	  	//직원선택 버튼
  	  		}
  		}else if(knd == 'openFlag'){
			if(obj.value == 'N'){
				if($("input[name='rdEmployee']:checked").val() == "A"){
  					dialog.push({body:"<b>확인!</b> 비공개${baseUserLoginInfo.projectTitle}는 전 직원을 배정할수 없습니다!", type:""});

  					//$("input[name='rdEmployee'][value='Y']").prop("checked",true);
					$("input[name='openFlag'][value='Y']").prop("checked",true).click();
  					//$("input[name='openFlag'][value='Y']").trigger("click");

					return;
  				}
			}
  		}
		var openFlag = $("input[name='openFlag']:checked").val();
		var rdEmployee = $("input[name='rdEmployee']:checked").val();
		if(mode=="update"&&updateProjectConfirm=="N"){
			if(updateMngActivityChk=="N"&&!(openFlag == "Y" && rdEmployee =="A")){
				var inStartDate = $('#inStartDate').val();							//시작일
	  	    	var inEndDate = $('#inEndDate').val();    							//종료일

	  	  		var budget = $(':radio[name=rdBudget]:checked').val();				//예산					//$('#v_budget').html();	//예산 ... 'No' 이 아니면 'Yes'

	  	  		var expense = $('input:radio[name=rdExpense]:checked').val();		//지출					//$('#v_expense').html();
	  	  		var overExpense = $('#selOverExpense').val();						//예산초과허용 여부

	  	  		var timesheet = $('input:radio[name=rdTimesheet]:checked').val();	//타임시트					$('#v_timesheet').html();
	  	  		var enable = $('input:radio[name=rdEnable]:checked').val();			//사용여부					$('#v_enable').html();
	  	  		var employee = $('input:radio[name=rdEmployee]:checked').val();		//직원배정					$('#v_employee').html();

	  	  		var empAddList = new Array();
	  	  		for(var i = 0 ; i <g_pjtEmpList.length;i++){
	  	  			if(parseInt(g_pjtEmpList[i].userId) == parseInt("${baseUserLoginInfo.userId}"))
	  	  				empAddList.push(g_pjtEmpList[i]);
	  	  		}
	  	  		var data ;

	  	  		if(updateMngActivityData){
	  	  			data = updateMngActivityData;
	  	  		}else{
	  	  		data = {  lvl:0
		  				, level:0
					  	, name:'${baseUserLoginInfo.projectTitle}관리'
					  	, description:'${baseUserLoginInfo.projectTitle}관리'
						, startDate: inStartDate
						, endDate: inEndDate
						, budget: budget					//(budget=='No'?'N':'Y')
						, budgetAmt: ''
						, expense: expense
						, overExpense: overExpense
						, timesheet: timesheet
						, enable: enable
						, employee: employee
						, confirm: 'N'
						, empList: empAddList.slice(0)	//[]		//직원배정
						, empListDel: []					//직원배정(삭제할건)
						, btn:''
						, cardExpenseSum : 0
						, scheChk : ''					//스케쥴 체크
						, apprChk : ''					//전자결재 체크
						, mngActivityFlag : 'Y'
					};
	  	  		}

	  			myGrid.dataList.unshift(data);

	  			updateMngActivityChk = "Y";
			}else if(updateMngActivityChk=="Y"&&(openFlag == "Y" && rdEmployee =="A")){
				updateMngActivityData = myGrid.dataList[0];
				myGrid.dataList.shift();
				updateMngActivityChk = "N";

				if(myGrid.dataList.length==0){
					var data = {
	    					lvl:'1',
	    					name:'',
	    					description:'',
	    					budget:'Y',
	    					budgetAmt:'',
	    					expense:'Y',
	    					overExpense:'Y',
	    					timesheet:'Y',
	    					confirm:'N',
	    					enable:'Y',
	    					employee:'Y',
	    					empList:[],
	    					empListDel:[],
	    					btn:'',
	    					cardExpenseSum : 0,
	    					scheChk : '',
	    					apprChk : '',
	    					mngActivityFlag : 'N'};

			    	data.level = 0;

			    	data.startDate = $('#inStartDate').val();		//프로젝트 기간 의 시작
			    	data.endDate = $('#inEndDate').val();			//프로젝트 기간 의 끝

			    	var idx = myGrid.addRow(data);
				}
			}
		}




  		var list = myGrid.dataList;
  		//--------- 그리드 해당 컬럼 데이터 일괄변경 :S --------

  		//예산이 아닐때만 데이터 변경
  		if(knd != 'budget' && knd != 'overExpense'){
	  		for(var i=0; i<list.length; i++){
	  			if(mode=="update"&& knd == "employee" && list[i]["mngActivityFlag"]=="Y") {
	  				continue;
	  			}

	  			if(!(knd == 'expense' && obj.value == 'Y') ) list[i][knd] = obj.value;		//프로젝트 지출이 N -> Y 일때 전부 변경되서 예외처리함.


			}
		}

		//--------- 그리드 해당 컬럼 데이터 일괄변경 :E --------


		//그리드 refresh
	    fnObj.refreshGrid();			//(4가지 프로세스) ... myGrid.refresh(); fnObj.resetLevelAndClass(); fnObj.setDisableSync(); fnObj.setDatePicker();

  	},

  	//액티비티 내 마감일 달력 클릭시
  	clickActCalendar : function(index){
  		var endDateVal = $('#inEndDate' + index ).val();
  		var nowYear = new Date().yyyy_mm_dd().split("-")[0];	//오늘년도

  		//해당 액티비티의 마감일 년도 세팅
  		if( endDateVal =='') endDateVal = nowYear;
  		else{ endDateVal=endDateVal.split("-")[0]; }

  		//만약 무기한 이었다면, 달력 오늘 날짜로 초기화
  		if(endDateVal>=9999){
  			$('#inEndDate' + index ).datepicker('setDate', new Date().yyyy_mm_dd());
  			$('#inEndDate' + index ).val(new Date().yyyy_mm_dd());
  		}
  		$('#inEndDate' + index ).datepicker('show');
  	},



  	//해당 컬럼 활성화 일괄 변경
  	setDisableSync: function(){
  		//예산
  		var budget = $(':radio[name=rdBudget]:checked').val();		//$('#v_budget').html();									//예산 ... 'No' 이 아니면 'Yes'
  		/* $(myGrid.gridBodyObject.find('select[name^=selBudget]')).each(function(){
			if(budget=='N'){
  				$(this).attr('disabled', 'true');
  				$(this).css('background-color','#EEE');
			}else{
				$(this).removeAttr('disabled');
				$(this).css('background-color','#FFF');
			}
		}); */
  		//지출
  		var expense = $(':radio[name=rdExpense]:checked').val();	//$('#v_expense').html();								//지출

  		$(myGrid.gridBodyObject.find('select[name^=selExpense]')).each(function(){
			if(expense=='N'){
  				$(this).attr('disabled', 'true');
  				$(this).css('background-color','#EEE');
			}else{
				$(this).removeAttr('disabled');
				$(this).css('background-color','#FFF');
			}
		});

  		//지출-예산초과가능 여부
  		var overExpense = $('#selOverExpense').val();
  		/* $(myGrid.gridBodyObject.find('select[name^=selOverExpense]')).each(function(){
			if(overExpense=='N'){
  				$(this).attr('disabled', 'true');
  				$(this).css('background-color','#EEE');
			}else{
				$(this).removeAttr('disabled');
				$(this).css('background-color','#FFF');
			}
		}); */

  		//타임시트
  		var rdTimesheet = $(':radio[name=rdTimesheet]:checked').val();
  		$(myGrid.gridBodyObject.find('select[name^=selTimesheet]')).each(function(){
			if(rdTimesheet=='N'){
  				$(this).attr('disabled', 'true');
				$(this).css('background-color','#EEE');
			}else{
				$(this).removeAttr('disabled');
				$(this).css('background-color','#FFF');
			}
		});

  		//사용여부
  		var rdEnable = $(':radio[name=rdEnable]:checked').val();
  		$(myGrid.gridBodyObject.find('select[name^=selEnable]')).each(function(){
			if(rdEnable=='N'){
  				$(this).attr('disabled', 'true');
				$(this).css('background-color','#EEE');
			}else{
				$(this).removeAttr('disabled');
				$(this).css('background-color','#FFF');
			}
		});

  		//직원배정
  		var rdEmployee = $(':radio[name=rdEmployee]:checked').val();
  		$(myGrid.gridBodyObject.find('select[name^=selEmployee]')).each(function(){
  			$(this).addClass('selectDisabled');
			//if(rdEmployee=='N'){
  				$(this).attr('disabled', 'true');
				$(this).css('background-color','#EEE');
			/* }else{
				//$(this).removeAttr('disabled');
				$(this).removeClass('selectDisabled');
				//$(this).css('background-color','#FFF');
			} */
		});

  		//무기한 버튼 활성화
  		var periodType = $(':radio[name=rdPeriod]:checked').val();

  		if(periodType == 'Y'){
  			$(".activityCalArea").hide();
  		}else{
  			$(".activityCalArea").show();
  		}

  	},

  	//------------------------------- click radio :E ------------------------------


  	//저장 doSave
  	doSave: function(confirmFlag){		//확정여부

  		var list = myGrid.dataList;


		//--------------- validation :S ---------------
		var frm = document.myForm;

    	if(isEmpty(frm.inProjectName.value)){			//템플릿명
    		dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.projectTitle}명을 입력해주세요!", type:"", onConfirm:function(){frm.inProjectName.focus();}});
    		return;
    	}
    	if(isEmpty(frm.inProjectDesc.value)){			//설명
    		dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.projectTitle} 설명을 입력해주세요!", type:"", onConfirm:function(){frm.inProjectDesc.focus();}});
    		return;
    	}

    	//-------------  프로젝트 validation S
    	if($('input:radio[name=rdPeriod]:checked').val() == 'Y'){		//기간 'Y' 일때
    		var startDate = $('#inStartDate');
    		var endDate = $('#inEndDate');
    		var closeDate = $('#closeDate');

    		// 시작일이 종료일보다 클 경우
    		if(startDate > endDate){
    			dialog.push({body:"<b>확인!</b> 시작일이 종료일보다  이후일 수 없습니다!", type:"", onConfirm:function(){startDate.select();}});
        		return;
    		}

    		// 마감일이 프로젝트 종료일이  보다 클경우
    		 if(closeDate.val() < startDate.val()){
    			dialog.push({body:"<b>확인!</b> 마감일이 ${baseUserLoginInfo.projectTitle} 시작일보다 이전일 수 없습니다!", type:"", onConfirm:function(){closeDate.select();}});
        		return;
    		}

    		// 시작일이 마감일 보다 클경우
    		if(startDate.val() > closeDate.val()){
    			dialog.push({body:"<b>확인!</b> 시작일이 마감일보다 이후일 수 없습니다!", type:"", onConfirm:function(){closeDate.select();}});
        		return;
    		}

    		if(g_projectConfirm == 'Y' && g_projectCloseDate != $("#closeDate").val()){		//확정 건이면서 마감일이 변경되었을때

    			var chk = fnObj.chkCloseDate();		//마감일 체크
    			if(chk == false){

    				return;
    			}
    		}

    	}

    	if(isEmpty(frm.selType.value)){			//유형
    		dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.projectTitle} 유형을 입력해주세요!", type:"", onConfirm:function(){frm.selType.focus();}});
    		return;
    	}

    	//프로젝트 예산 Y 이면 예산 금액 체크
    	if($("input[name=rdBudget]:checked").val() == 'Y'&& $("#budgetAmt").val() == ''){
    		dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.projectTitle} 예산금액을 입력해주세요!", type:"", onConfirm:function(){$("#budgetAmt").focus();}});
       		return;
    	}

    	//유효 값 체크
    	if($("input[name=rdBudget]:checked").val() == 'Y'&& isNaN($("#budgetAmt").val())){
    		dialog.push({body:"<b>확인!</b> 금액은 숫자로 입력해주세요!", type:"", onConfirm:function(){$("#budgetAmt").focus();}});
       		return;
    	}


    	//-------------  프로젝트 validation E


    	//-------------  activity validation

    	var totalBudget =0;				//총예산금액
    	var totalCardExpense =0;		//쓴금액

    	for(var i=0; i<list.length; i++){
    		if(isEmpty(list[i].name)){						//Activity명
        		dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.activityTitle} 명을 입력해주세요!", type:"", onConfirm:function(){$(myGrid.gridBodyObject.find('input[name=aName]')[i]).focus();}});
        		return;
        	}
        	if(isEmpty(list[i].description)){				//Activity설명
        		dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.activityTitle} 설명을 입력해주세요!", type:"", onConfirm:function(){$(myGrid.gridBodyObject.find('input[name=aDesc]')[i]).focus();}});
        		return;
        	}

        	var startDate = $('#inStartDate').val();
        	var eachStartDate = $('#inStartDate' + i);
        	var endDate = $('#inEndDate').val();
        	var eachEndDate = $('#inEndDate' + i);

        	if($('input:radio[name=rdPeriod]:checked').val() == 'Y'){		//기간 'Y' 일때

            	if(startDate > eachStartDate.val()){
            		dialog.push({body:"<b>확인!</b> 시작일은 ${baseUserLoginInfo.projectTitle}의 시작일보다 이전일 수 없습니다!", type:"", onConfirm:function(){eachStartDate.select();}});
            		return;
            	}
            	if(endDate < eachEndDate.val()){
            		dialog.push({body:"<b>확인!</b> 종료일은 ${baseUserLoginInfo.projectTitle}의 종료일보다 이후일 수 없습니다!", type:"", onConfirm:function(){eachEndDate.select();}});
            		return;
            	}
        	}

        	//직원선택 Y 인데 선택된 직원이 없을때.
        	var userSelectYn = $('#selEmployee' + i);

        	if(userSelectYn.val() == 'Y' && (list[i].empList).length==0){
        		dialog.push({body:"<b>확인!</b> 레벨 "+(i+1)+" 의 사원을 선택해 주세요!", type:""});
        		return;
        	}

        	if(eachStartDate.val() >eachEndDate.val()){
        		dialog.push({body:"<b>확인!</b> 시작일은 종료일보다 이후일 수 없습니다!", type:"", onConfirm:function(){eachStartDate.select();}});
        		return;
        	}

        	if(list[i].budget == 'Y' && (list[i].budgetAmt == '' || list[i].budgetAmt == null)){		//예산 Y 일때. 빈값 체크

           		dialog.push({body:"<b>확인!</b> 예산을 입력해주세요!", type:"", onConfirm:function(){$(myGrid.gridBodyObject.find('#budgetAmt'+i)).focus();}});
           		return;

        	}else if(list[i].budget == 'Y' && !(list[i].budgetAmt == '' || list[i].budgetAmt == null || isNaN(list[i].budgetAmt))){	//예산 Y 이면서, 금액이 있을때.
        		totalBudget += parseInt(list[i].budgetAmt);		//예산 금액 더함.

        	}else if(list[i].budget == 'Y' && isNaN(list[i].budgetAmt)){	//금액이 숫자가 아닐때.
        		dialog.push({body:"<b>확인!</b> 예산을 숫자로 입력해주세요!", type:"", onConfirm:function(){$(myGrid.gridBodyObject.find('#budgetAmt'+i)).focus();}});
           		return;
        	}

        	totalCardExpense += parseInt(list[i].cardExpenseSum);
        }

    	//프로젝트 예산 금액이 있고, 예산 허용불가 일때
    	if($("input[name=rdBudget]:checked").val() == 'Y'&& $("#selOverExpense").val() == 'N'  ){

    		// 액티비티의 정해준 예산 금액과 비교한다.
    		if(totalBudget>$("#budgetAmt").val()){
    			dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.activityTitle}의 예산금액의 합이 ${baseUserLoginInfo.projectTitle} 예산금액보다 큽니다!", type:"", onConfirm:function(){$("#budgetAmt").focus();}});
           		return;
    		}

    		//지출 금액과 비교한다.
    		if(totalCardExpense>$("#budgetAmt").val()){
    			dialog.push({body:"<b>확인!</b> 이미 지출한 금액의 합이 ${baseUserLoginInfo.projectTitle} 예산금액보다 큽니다!", type:"", onConfirm:function(){$("#budgetAmt").focus();}});
           		return;
    		}
    	}



    	//--------------- validation :E ---------------

    	/* $(".number").each(function(){
			$(this).val($(this).val().split(",").join(""));
		}); */



    	//저장
    	if(confirm('저장하시겠습니까?')){

    		var url = contextRoot + "/project/doSaveProject.do";
        	var param = {
        			mode		 : mode,						//"new" or "update"
        			orgId		 : g_orgId,						//ORG_Id
        			projectId	 : g_projectId,					//"update" mode 일경우

        			confirm		 : confirmFlag,					//프로젝트 컨펌 여부 ( 확정인지 Y, 임시저장인지 N )
        			beforeConfirm: g_projectConfirm,			//프로젝트 컨펌 수정전의 값(현재 DB입력 값)
        			projectName	 : frm.inProjectName.value,		//프로젝트명
        			projectCode   : frm.inProjectCode.value,     //프로젝트명
        			projectDesc	 : frm.inProjectDesc.value,		//프로젝트 설명

        			period		 : $('input:radio[name=rdPeriod]:checked').val(),		//기간					//($('#v_period').html()=='No'?'N':'Y'),
        			startDate	 : $('#inStartDate').val(),					//시작일
        			endDate		 : $('#inEndDate').val(),					//종료일
        			closeDate	 : $('#closeDate').val(),					//마감일

        			projectType	 : frm.selType.value,			//타입
        			openFlag	 : $(':radio[name=openFlag]:checked').val(),			//공개여부

        			budget		 : $(':radio[name=rdBudget]:checked').val(),					//예산			//($('#v_budget').html()=='No'?'N':'Y'),
        			budgetAmt	 : isEmpty($('#budgetAmt').val())?0:$('#budgetAmt').val(),		//예산금액

        			timesheet	 : $(':radio[name=rdTimesheet]:checked').val(),					//타임시트					//($('#v_timesheet').html()=='No'?'N':'Y'),
        			overTs		 : $('#selOverTs').val(),							//타임시트(기간관계 여부)				//frm.selOverTs.value,

        			expense		 : $(':radio[name=rdExpense]:checked').val(),					//지출						($('#v_expense').html()=='No'?'N':'Y'),
        			overEx		 : $('#selOverEx').val(),							//지출 기간상관여부
        			overExpense	 : $('#selOverExpense').val(),						//예산초과지출 허용 여부

        			enable		 : $(':radio[name=rdEnable]:checked').val(),		//사용여부					//($('#v_enable').html()=='No'?'N':'Y'),
        			employee	 : $(':radio[name=rdEmployee]:checked').val(),		//직원배정					//($('#v_employee').html()=='No'?'N':'Y'),

        			aList :	  JSON.stringify(list)			//그리드 데이터 리스트 (JSON 문자열로 전달)

        	};

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		//세션로그아웃 >> 재로그인
        		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
        			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
        			return;
        		}

        		var projectId = obj.resultVal;	//templateId

        		if(obj.result == "SUCCESS"){

        			fnObj.viewProject(projectId);

        		}else{
        			//alertMsg();
        		}

        	};

        	commonAjax("POST", url, param, callback);

    	}
  	},//doSave

  	//--마감일 체크
  	chkCloseDate : function(){

  		var rslt;	// = true;

		var url = contextRoot + "/project/chkCloseDate.do";
		var param = {
    			projectId		: g_projectId,
    			changeCloseDate	: $("#closeDate").val()
		};

		var callback = function(result){

			var obj = JSON.parse(result);
			var resultObject = obj.resultObject;

			if( resultObject.schCnt ==0 && resultObject.appvCnt ==0 ){
				rslt = true;
			}else{

				rslt = false;

				url = contextRoot + "/project/alertCloseDatePop/pop.do";
				param ={obj : JSON.stringify(resultObject)};
				myModal.open({
		 	   		url: url,
		 	   		pars: param,
		 	   		titleBarText: '경고창',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		 	   		method:"POST",
		 	   		top: $(document).scrollTop()+150,
		 	   		width: 650,
		 	   		closeByEscKey: true				//esc 키로 닫기
		   		});

		   		$('#myModalCT').draggable();

		   	}
		};
		commonAjax("POST", url, param, callback, false);

		return rslt;
  	},


  	//프로젝트 보기
    viewProject: function(projectId){

    	//현재 페이지 파라미터 추출---------
    	var url = decodeURIComponent(location.href);
     	var params = url.substring( url.indexOf('?')+1, url.length );	// url에서 '?' 문자 이후의 파라미터 문자열까지 자르기
    	//-------------------------------

    	var url = contextRoot+"/project/projectView.do" + "?pId=" + projectId + "&saved=yes&" + params;

    	document.location.href = url;

    },//viewProject


    //엑셀다운
    excelDownload: function(){
    	 excelDown(myGrid.getExcelFormat('html'), "download");		//common.js
    },


  	//프로젝트 정보 불러와 세팅
    setProjectInfo: function(pId){
    	var url = "<c:url value='/project/getProjectInfo.do'/>";
    	var param = {
    					projectId : pId
    				};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var jsonObj = obj.resultObject;		//결과데이터JSON

    		var project = jsonObj.pProject;		//템플릿 프로젝트
    		var actList = jsonObj.pActivity;	//템플릿 activity

    		if(obj.result == "SUCCESS"){

    	    	//----- 내용뿌리기 :S -----

    	    	var frm = document.myForm;

    	    	//프로젝트
    	    	frm.inProjectName.value		= project.name;				//프로젝트명
    	    	frm.inProjectDesc.value		= project.description;		//프로젝트 설명
    	    	frm.inProjectCode.value       = project.projectCode;      //프로젝트 코드
    	    	$("#v_projectCode").html(project.projectCode);

    	    	$('input:radio[name=rdPeriod]').val([project.period]);	//기간
    	    	if(project.period == 'Y'){								//기간 'Y'
    	    		$('#inStartDate').val(project.startDate);
    	    		$('#inEndDate').val(project.endDate);
    	    		$('#closeDate').val(project.closeDate);				//마감일
    	    		$('.noPeriodPart').hide();	//기간 없음 출력

    	    	}else{		//기간 'N'
    	    		$('#periodPart').hide();	//기간 입력 필드 숨기기
    	    		$('#closeCalendar').hide();	//기간 입력 필드 숨기기

    	    		if(project.confirm == 'Y') $('.noPeriodPart').show();	//확정 Y 일때만 기간 없음 출력
    	    		else $('.noPeriodPart').hide();

    	    		//기간 ... 지금부터 9999년까지
    	  			$("#inStartDate").datepicker('setDate', new Date());
    	  			$("#inEndDate").datepicker('setDate', makeDate(5, "99991231"));		//기간없을시 무기한으로
    	  			$("#closeDate").datepicker('setDate', makeDate(5, "99991231"));		//기간없을시 무기한으로
    	  			$('#overExSelectTag').hide();			//지출 기간상관여부 숨김

    	    	}

    	    	g_beforeEndDate = project.endDate;
    	    	g_beforecloseDate = project.closeDate;


    	    	$('#selType').val(project.projectType);									//유형
    	    	$('input:radio[name=openFlag]').val([project.openFlag]);				//공개여부

    	    	$('input:radio[name=rdBudget]').val([project.budget]);					//예산

    	    	if(project.budget == 'Y'){
    	    		$('#budgetAmt').val(project.budgetAmt);								//예산금액

    	    	}else{
    	    		$('#budgetAmtPart').hide();
    	    		$('#overExpenseSelectTag').hide();									//예산초과허용 여부 숨김

    	    	}

    	    	$('input:radio[name=rdTimesheet]').val([project.timesheet]);			//타임시트
    	    	if(project.timesheet == 'Y'){
    	    		$('#selOverTs').val(project.overTs);								//기간상관여부
    	    	}else{
    	    		$('#selOverTs').hide();
    	    	}


    	    	$('input:radio[name=rdExpense]').val([project.expense]);				//지출
       	    	if(project.expense == 'Y'){
       	    		$('#selOverEx').val(project.overEx);								//기간상관여부

       	    		$('#selOverExpense').val(project.overExpense);

       	    	}else{
       	    		$('#overExSelectTag').hide();			//지출 기간상관여부 숨김
       	    		$('#overExpenseSelectTag').hide();		//예산초과허용 여부 숨김
       	    	}



    	    	$('input:radio[name=rdEnable]').val([project.enable]);				//사용여부

    	    	$('input:radio[name=rdEmployee]').val([project.employee]);			//직원배정

    	    	//-- 프로젝트 직원배정 세팅
    	    	var eStr = '';
				for(var i=0; i<empList.length; i++){
					if(i==0) eStr += '(';
					eStr += '<span class="tooltip" ';



					if(project.confirm == 'Y'){		//확정일때

						//-- 오늘 이후 스케쥴 이나 전자결재건이 있는지 --//
        				if((empList[i].scheChk !='' & empList[i].scheChk !=undefined) || (empList[i].apprChk !=''  & empList[i].apprChk !=undefined)){
        					eStr +=  ' onclick="fnObj.nameDetailDisplay(\'p\','+i+');"> <font color="#517dc6">' +empList[i].userNm +'</font>';


        					//------ 툴팁 세팅  : S

        				 	eStr +=' <div id="helpProMgmt" name="nameDetailp_'+i+'" class="tooltip_box" style="display:none; width:200px;left:-110px;margin-left:0px;"> ';
        					eStr +=' <span class="intext"> ';
        					if(empList[i].scheChk !='' ){
        						eStr +=' <ul class="list_st_dot3">';
        						eStr +=' <li> 일정: '+empList[i].scheChk+'</li>';
        						eStr +=' </ul>';
        					}
        					if(empList[i].apprChk !='' ){
        						eStr +=' <ul class="list_st_dot3">';
        						eStr +=' <li> 전자결재: '+empList[i].apprChk+'</li>';
        						eStr +=' </ul>';
        					}


        					eStr +=' </span>';
        					eStr +=' <em class="edge_topcenter"></em> ';
        					eStr +=' <a href="#;" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a> ';


        					eStr +=' </div> </span>';

        					//------- 툴팁 세팅  : E


        				}else{

        					eStr +='> '+empList[i].userNm+'<a href="javascript:fnObj.delProjectUser(' + empList[i].userId + ');" class="btn_delete_employee" id="btnUserDelete_'+empList[i].userId+'"><em>삭제</em></a> </span> ';
        				}

        			}else{
        				eStr +='> '+empList[i].userNm+'<a href="javascript:fnObj.delProjectUser(' + empList[i].userId + ');" class="btn_delete_employee" id="btnUserDelete_'+empList[i].userId+'"><em>삭제</em></a> </span> ';
    				}

					if(i==empList.length-1) eStr += ')';
           		}
				//$('#v_employee_list').html(eStr);

				//-----------------

    	    	if(project.employee=='Y'){
    	    		$('#btn_select_employee_all').show();
    	    		$('#v_employee_list').show();
    	    	}else{
    	    		$('#btn_select_employee_all').hide();
    	    		$('#v_employee_list').hide();
    	    	}

    	    	g_projectConfirm = project.confirm;		//DB 에 입력된 원래 confirm 값 세팅
    	    	g_projectCloseDate = project.closeDate;	//DB 에 입력된 원래 closeDate 값 세팅

    	    	updateProjectConfirm=project.confirm;
    	    	//확정일때
    	    	if(project.confirm == 'Y'){

    	    		$("#inEndDate").datepicker('option', 'minDate', project.originEndDate);		//최초종료일 이후만
	    	    	$("#closeDate").datepicker('option', 'minDate', new Date().yyyy_mm_dd());

    	    		$("#tempSaveBtn").hide();		//임시저장 버튼 숨김
    	    		$("#saveBtn").html("저장");		//확정 버튼 저장으로 text 바꾸기
    	    		$("#deleteBtn").hide();			//삭제버튼 숨기기

    	    		$("#inStartBtn").hide();		//시작일 버튼 숨기기
    	    		$("#inStartDate").prop("disabled",true);		//시작일 버튼 숨기기

    	    		if(project.period == 'Y'){		//확정이고 기간 Y 일때는
    	    			$("#inEndDate").datepicker('option', 'minDate', project.endDate);		//최소 입력할수 있는 종료일를 현재 DB 종료일 이후로 세팅한다.

    	    			//--경과일 표시
    	    			var str ='';
    	    			var chk = diffDay(project.endDate,project.originEndDate);
    	    			if(chk>0) str += '+'+chk+'일 지연';
    	    			else str = '';
    	    			if(project.endDate != project.originEndDate){
    	    				$("#calPeriod").html( (str != '' ?   '('+str+')' : '')    +' 최초종료일:'+(project.originEndDate).replace(/-/gi,'/')+'');
    	    			}
    	    		}else{
    	    			$("#periodRadioTag").hide(); 		//무기한 프로젝트면 기간 여부 숨김처리
    	    		}

    	    		//총 지출 표시
    	    		if(project.cardExpenseSum !=0 ){
    	    			$("#cardExpenseSumArea").html('<strong>현재 :</strong> <span> '+ Number(project.cardExpenseSum).toLocaleString().split(".")[0] +'</span> <em>원</em></span><button type="button" class="btn_s_type_g mgl10" onclick="fnObj.expenseListPop();">상세보기</button>');
    	    			$("#expenseRadioTag").hide();
    	    			$("#expenseTxtArea").html(project.expense);
    	    			$("#expenseTxtArea").show();


    	    		}
    	    		//직원 배정 control
    	    		if(project.employee == 'A'){
    	    			$("#employeeRadioTag").hide();		//확정이며 직원배정 N 일때 라디오 버튼 숨김
    	    			$("#employeeStatusArea").show();	//Y 글자 표시
    	    		}else{
    	    			$("#employeeRadioTag").show();		//확정이며 직원배정 N 일때 라디오 버튼 숨김

    	    		}
    	    	}

    	    	g_pjtEmpList = empList;													//프로젝트 직원배정 정보 ...배열객체



    	    	//activity
	    		myGrid.setGridData({
									list: actList,	//그리드 테이터
									page: null		//페이징 데이터
								});

	    		//datepicker 바인딩
	    		fnObj.setDatePickerAct();			//기간 입력에 datepicker 사용

	    		fnObj.setTotalPrice();				//하단 금액세팅

    			//----- 내용뿌리기 :E -----


	    		fnObj.resetLevelAndClass();			//레벨 값 및 스타일 class 재세팅

	    		fnObj.setDisableSync();				//컬럼 활성화 일괄 변경


	    		var empList = (project.empList=='') ? [] : project.empList;
	    		console.log(empList)
    	    	for(var i=0; i<empList.length; i++){

    	    		if(empList[i].leaderYn == "Y"){
	    	    		var activityId = empList[i].activityId;

	    	    		var selEmployee = $("input[name='activityId'][value='"+activityId+"']").parent().find("select[name*='selEmployee']").val();

	    	    		if(selEmployee == "Y"){
	    	    			$("input[name='activityId'][value='"+activityId+"']").parent().find("input[name*='activityLeaderRadio_'][value='"+empList[i].userId+"']").prop("checked",true);
	    	    		}


    	    		}


    	    	}

   	  			//수정가능 항목 메세지 보이기
   	  			$('#updatableMsg').show();

    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);

    },//setProjectInfo


  	//기간 입력에 datepicker 사용 (액티비티)
    setDatePickerAct: function(){

    	var list = myGrid.getList();
    	var startDate;
    	var endDate;
    	for(var i=0; i<list.length; i++){


    		startDate = list[i].startDate;
    		if(startDate!=null){
    			startDate = startDate.substring(5,7) + '/' + startDate.substring(8,10) + '/' +startDate.substring(0,4);
    		}

    		fnObj.setDateShow("inStartDate"+i, new Date(startDate));


    		endDate = list[i].endDate;
    		if(endDate!=null){
    			endDate = endDate.substring(5,7) + '/' + endDate.substring(8,10) + '/' +endDate.substring(0,4);
    		}
    		fnObj.setDateShow("inEndDate"+i, new Date(endDate));


    	}//for
    },//setDatePicker


  	//사원선택 팝업	(idx : activity index, rdEmployee : 전직원일때)
    openUserPopup: function(idx){

    	g_selUserIndex = idx;					//그리드의 idx ... 	■■■■ global variable ■■■■

    	var list = myGrid.getList();
    	var empList = list[idx].empList;		//해당 row 의 직원 리스트


    	var userStr ='';
    	var userDisableStr ='';

    	var arr =new Array();
    	var disabledList =[];

    	for(var i=0;i<empList.length;i++){
    		arr.push(empList[i].userId);

    		if((empList[i].scheChk != '' || empList[i].apprChk != '') &&  list[idx].activityId !=undefined ) disabledList.push(empList[i].userId);	//일정이 있는 참가자는 삭제할수 없다.
    		if(idx == 0 &&  myGrid.dataList[0].mngActivityFlag == "Y" && parseInt(empList[i].userId) == parseInt("${baseUserLoginInfo.userId}")){
    			 disabledList.push(empList[i].userId); // 관리 액티비티에서 작성자를 제거할수없다...수정화면이 작성자만 접근되므로 세션 userId와 비교한다.
    		}
  		}

    	if(arr.length>0) userStr = arr.join(',');
    	if(disabledList.length>0)  userDisableStr = disabledList.join(',');

    	var paramList = [];
        var paramObj ={ name : 'userList'   ,value : userStr};
        paramList.push(paramObj);

        paramObj ={ name : 'disabledList'   ,value : userDisableStr};		//선택 불가
        paramList.push(paramObj);

        paramObj ={ name : 'isCheckDisable'   ,value : 'N'};				//상위에 따른 선택불가
        paramList.push(paramObj);


        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
        paramList.push(paramObj);

        isLeaderPop = false;
       /*  paramObj ={ name : 'parentKey' ,value : knd};
        paramList.push(paramObj); */
       userSelectPopCall(paramList);		//공통 선택 팝업 호출

    },


    //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
    getResult: function(userList, pKey){

    	var list = myGrid.getList();
    	var empList = list[g_selUserIndex].empList;		//해당 row 의 직원 리스트
    	var deleteUserList = [];						//체크 해제된 직원리스트

    	var newUserList =[];
    	for(var i=0;i<userList.length;i++){
    		var empObj = {activityId : '0', userId : userList[i].userId, defaultYn: 'N', enable:'Y', userNm: userList[i].userName, empNo : userList[i].empNo, loginId : userList[i].loginId, scheChk: '', apprChk: '',leaderYn: 'N'};
    		newUserList.push(empObj);
    	}

    	for(var i=0;i<empList.length;i++){
    		var idx = getRowIndexWithValue(newUserList, 'userId', empList[i].userId);	//현재 그리드 데이터에 있는데..팝업에서 호출받은 리스트에 없으면 유저 삭제로본다.
    		if(idx == -1){
    			deleteUserList.push(empList[i].userId);								//체크 해제된 직원리스트

    		}
    	}

    	for(var i=0;i<deleteUserList.length;i++){

    		fnObj.delActivityUser(g_selUserIndex,deleteUserList[i]);		//삭제 액션
		}

    	fnObj.concatUserSelected(newUserList);

    	toast.push('배정OK!');
    },


    //사원선택 팝업에서 선택한 사원을 데이터셋에 반영(개별 activity)
    concatUserSelected: function(userList, vEnd){

    	chkOnLoadPage = "Y";

    	var list = myGrid.getList();

    	var empList = list[g_selUserIndex].empList;			//배정직원 리스트
    	if(empList.length == 0){
    		empList = [];
    	}
    	var empListDel = list[g_selUserIndex].empListDel;		//삭제할 직원
    	if(!$.isArray(list[g_selUserIndex].empListDel)){
    		list[g_selUserIndex].empListDel = [];
    		empListDel = list[g_selUserIndex].empListDel;
    	}

    	//삭제리스트에 동일한 사원이 있으면 제거
       	for(var i=0; i<userList.length; i++){
       		var idx = getRowIndexWithValue(empListDel, 'userId', userList[i].userId);			//같은 사원을 선택했을 경우에는
       		if(idx > -1){
       			empListDel.remove(idx);															//기 삭제건이 있으면 제거
       		}
       	}
      	//추가
       	for(var i=0; i<userList.length; i++){
       		var idx = getRowIndexWithValue(empList, 'userId', userList[i].userId);				//같은 사원을 선택했을 경우에는
       		if(idx == -1){
       			//var empObj = {activityId : '0', userId : userList[i].userId, defaultYn: 'N', enable:'Y', userNm: userList[i].userName, empNo : userList[i].empNo, loginId : userList[i].loginId, scheChk: '', apprChk: ''};
       			empList.push(userList[i]);														//없을경우에 추가
       		}
       	}
       	list[g_selUserIndex].empList = empList;				//list 에 반영
       	list[g_selUserIndex].empListDel = empListDel;      	//list 에 반영

       	if(vEnd != 'FIRST'){
       		fnObj.refreshGrid();		//sync
       	}

       	///////////////// 프로젝트 직원배정에도 추가 //////////////////
       	if(vEnd != 'END'){	//무한loop방지
       		fnObj.concatPjtEmpList(userList, 'END');			//project 직원배정 추가
       	}
    },


  	//그리드 refresh
    refreshGrid: function(){

    	myGrid.refresh();


		fnObj.resetLevelAndClass();		//레벨 값 및 스타일 class 재세팅

    	fnObj.setDisableSync();			//컬럼 활성화 일괄 변경

    	//datepicker 바인딩
		fnObj.setDatePickerAct();			//기간 입력에 datepicker 사용
    },


  	//project 직원배정 추가 (activity 전체에 추가해준다.)
    concatPjtEmpList: function(eList, vEnd){
    	//삭제리스트에 동일한 직원데이터가 있으면 제거
    	for(var i=0; i<eList.length; i++){
    		var idx = getRowIndexWithValue(g_pjtEmpListDel, 'userId', eList[i].userId);	//같은 직원을 선택했을 경우에는
    		if(idx > -1){
    			g_pjtEmpListDel.remove(idx);
    		}
    	}

   		//추가
    	for(var i=0; i<eList.length; i++){
    		var idx = getRowIndexWithValue(g_pjtEmpList, 'userId', eList[i].userId);		//같은 직원이 있는지 보고
    		if(idx == -1){    																//없으면
    			g_pjtEmpList.push(eList[i]);												//추가
    		}
    	}

    	fnObj.setPjtEmpList();		//sync


		//////////activity list 반영(프로젝트 전체에 해당 직원을 추가해주는 것으로 한다.) /////////
		if(vEnd != 'END'){	//무한loop방지
	    	var cnt = myGrid.getDataCount();
			for(var i=0; i<cnt; i++){
				g_selUserIndex = i;	//모든 activity 에 대해 반영하기 위해
	    		fnObj.concatUserSelected(eList, 'END');		//activity 별 직원배정 추가
	    	}
		}
    },


    //project 직원배정 임시삭제(x버튼)
    delProjectUser: function(userId, vEnd){

    	for(var i=0; i<g_pjtEmpList.length; i++){
    		if(g_pjtEmpList[i].userId == userId){
    			g_pjtEmpList.remove(i);
    			g_pjtEmpListDel.push({userId:userId});		//삭제건에 추가
    		}
    	}

    	fnObj.setPjtEmpList();		//sync


    	////////// activity list 반영(프로젝트 전체에 해당 직원을 빼주는 것으로 한다.) /////////
    	if(vEnd != 'END'){	//무한loop방지
	    	var list = myGrid.getList();
	    	for(var i=0; i<list.length; i++){
	    		fnObj.delActivityUser(i, userId, 'END');	//activity 별 직원배정 임시삭제	(*'END' delActivityUser 에서 마무리되도록.. delProjectUser재호출 방지,무한루프방지)
	    	}
    	}

    },


  	//프로젝트 직원배정 표시 (g_pjtEmpList 내용으로 화면에 표기)
    setPjtEmpList: function(){
		var pjtEmpListDiv = document.getElementById('v_employee_list');
		pjtEmpListDiv.innerHTML = '';	//초기화

		var eStr = ' ';
		for(var i=0; i<g_pjtEmpList.length; i++){
			if(i==0) eStr += '(';
			 eStr += '<span class="tooltip" ';
				if(g_projectConfirm == 'Y'){		//확정일때
					//-- 오늘 이후 스케쥴 이나 전자결재건이 있는지 --//
    				if( (g_pjtEmpList[i].scheChk !='' &&g_pjtEmpList[i].scheChk !=undefined) ||(g_pjtEmpList[i].apprChk !='' && g_pjtEmpList[i].apprChk !=undefined)){

    					eStr +=  ' onclick="fnObj.nameDetailDisplay(\'p\','+i+');"> <font color="#517dc6">' +g_pjtEmpList[i].userNm +'</font>';

    					//------ 툴팁 세팅  : S

    				 	eStr +=' <div id="helpProMgmt" name="nameDetailp_'+i+'" class="tooltip_box" style="display:none; width:200px;left:-110px;margin-left:0px;"> ';
    					eStr +=' <span class="intext"> ';
    					if(g_pjtEmpList[i].scheChk !='' ){
    						eStr +=' <ul class="list_st_dot3">';
    						eStr +=' <li> 일정: '+g_pjtEmpList[i].scheChk+'</li>';
    						eStr +=' </ul>';
    					}
    					if(g_pjtEmpList[i].apprChk !='' ){
    						eStr +=' <ul class="list_st_dot3">';
    						eStr +=' <li> 전자결재: '+g_pjtEmpList[i].apprChk+'/li>';
    						eStr +=' </ul>';
    					}


    					eStr +=' </span>';
    					eStr +=' <em class="edge_topcenter"></em> ';
    					eStr +=' <a href="#;" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a> ';


    					eStr +=' </div> </span>';

    					//------- 툴팁 세팅  : E


    				}else{
    					eStr +='> '+g_pjtEmpList[i].userNm+'<a href="javascript:fnObj.delProjectUser(' + g_pjtEmpList[i].userId + ');" class="btn_delete_employee" id="btnUserDelete_'+g_pjtEmpList[i].userId+'"><em>삭제</em></a> </span> ';
    				}

    			}else{
    				eStr +='> '+g_pjtEmpList[i].userNm+'<a href="javascript:fnObj.delProjectUser(' + g_pjtEmpList[i].userId + ');" class="btn_delete_employee" id="btnUserDelete_'+g_pjtEmpList[i].userId+'"><em>삭제</em></a> </span> ';

    			}
				eStr += '</span>';
				if(i==g_pjtEmpList.length-1) eStr += ')';


		}

		$('#v_employee_list').html(eStr);

		if(myGrid.dataList[0].mngActivityFlag == "Y")
			$("#btnUserDelete_${baseUserLoginInfo.userId}").hide();
    },


  	//activity 직원배정 임시삭제(x버튼)
    delActivityUser: function(idx, userId, vEnd){

    	var list = myGrid.getList();

    	var empList = list[idx].empList;				//배정직원
    	if(!$.isArray(list[idx].empListDel)){			//배정삭제직원
    		list[idx].empListDel = [];
    	}

    	for(var i=0; i<empList.length; i++){
    		if(empList[i].userId == userId){
    			list[idx].empList.remove(i);
    			list[idx].empListDel.push({userId:userId});		//삭제건에 추가
    		}
    	}

    	fnObj.refreshGrid();		//sync



		////////////////프로젝트에도 반영 ///////////////
    	//삭제한 것이 다른 activity 어디에도 없는 마지막이었을경우에 project에서도 삭제해주기위해
    	if(vEnd != 'END'){	//무한loop방지
    		var eCnt = 0;
        	for(var i=0; i<list.length; i++){
        		if(list[i].employee == 'N') continue;		//직원배정여부가 'N'이면 카운팅대상에서 제외

        		var eList = list[i].empList;				//배정직원

            	for(var k=0; k<eList.length; k++){
            		if(eList[k].userId == userId){			//다른 activity 에 여전히 존재할때
            			eCnt++;
            		}
            	}
        	}
        	if(eCnt == 0){									//다른 activity 에 없을때
        		fnObj.delProjectUser(userId, 'END');		//project 직원배정 임시삭제
        	}
    	}

    },


    //프로젝트 삭제
    doDelete: function(){

		if(confirm('[주의!!]\n\n 정말 삭제하시겠습니까?\n')){

    		var url = contextRoot + "/project/doDeleteProject.do";
        	var param = {
        			mode		 : mode,						//"new" or "update"
        			//templateId	 : g_templateId,				//템플릿 id
        			projectId	 : g_projectId,					//"update" mode 일경우

        	};

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		//세션로그아웃 >> 재로그인
        		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
        			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
        			return;
        		}

        		var projectId = obj.resultVal;	//templateId

        		if(obj.result == "SUCCESS"){

        			document.location.href="${pageContext.request.contextPath}/project/projectMgmt.do?me=35&mu=28&mr=26&v=2";

        		}else{
        			//alertMsg();
        		}

        	};

        	commonAjax("POST", url, param, callback);

    	}

    },

 	 //달력 세팅
    setDateShow : function(obj,date){

    	$('#'+obj).datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			showOn: "button",

			yearRange: 'c-7:c+7',
		 	monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		    monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		    dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'], // 요일 텍스트 설정
		    dayNamesShort: ['일','월','화','수','목','금','토'], // 요일 텍스트 축약 설정
		    dayNamesMin: ['일','월','화','수','목','금','토'], // 요일 최소 축약 텍스트 설정
		    showButtonPanel: false,
			isRTL: false,

		    buttonText: ""
		});

    	$("#"+obj).datepicker('setDate', date);
    },

    //사람별 등록 일정
    nameDetailDisplay : function(rowIdx,idx){

    	if($("div[name=nameDetail"+rowIdx+"_"+idx+"]").css("display") == "none") $("div[name=nameDetail"+rowIdx+"_"+idx+"]").show();
    	else $("div[name=nameDetail"+rowIdx+"_"+idx+"]").hide();
    },

    //지출 상세보기
    expenseListPop : function(){

    	if($('#expenseFrm')!=undefined) $('#expenseFrm').remove();
    	var url =contextRoot+"/project/expenseListPop/pop.do";

    	//form 생성
    	var str ='<form method="POST" name="expenseFrm" id="expenseFrm" action="'+url+'" target="expensePop">';
		str +='<input type="hidden" name="projectId" id="projectId" value="'+g_projectId+'"> ';
    	str +='</form>';

    	$(document.body).append(str);


    	var option = "left=" + (screen.width > 1400?"550":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=700, height=400, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	window.open('','expensePop',option);

    	document.expenseFrm.submit(); // target에 쏜다.
    	return false;

    },

    showDate : function(obj){
    	$('#'+obj).datepicker('show')
    },

  	//리더선택 팝업	(idx : activity index, rdEmployee : 전직원일때)
    openLeaderPopup: function(idx){

    	g_selUserIndex = idx;					//그리드의 idx ... 	■■■■ global variable ■■■■

    	var list = myGrid.getList();
    	var empList = list[idx].empList;		//해당 row 의 직원 리스트


    	var userStr ='';
    	var userDisableStr ='';

    	var arr =new Array();
    	var disabledList =[];

    	for(var i=0;i<empList.length;i++){
    		arr.push(empList[i].userId);

    		if((empList[i].scheChk != '' || empList[i].apprChk != '') &&  list[idx].activityId !=undefined ) disabledList.push(empList[i].userId);	//일정이 있는 참가자는 삭제할수 없다.
    		if(idx == 0 &&  myGrid.dataList[0].mngActivityFlag == "Y" && parseInt(empList[i].userId) == parseInt("${baseUserLoginInfo.userId}")){
    			 disabledList.push(empList[i].userId); // 관리 액티비티에서 작성자를 제거할수없다...수정화면이 작성자만 접근되므로 세션 userId와 비교한다.
    		}
  		}

    	if(arr.length>0) userStr = arr.join(',');
    	if(disabledList.length>0)  userDisableStr = disabledList.join(',');

    	var paramList = [];
        var paramObj ={ name : 'userList'   ,value : userStr};
        paramList.push(paramObj);

        paramObj ={ name : 'disabledList'   ,value : userDisableStr};		//선택 불가
        paramList.push(paramObj);

        paramObj ={ name : 'isCheckDisable'   ,value : 'N'};				//상위에 따른 선택불가
        paramList.push(paramObj);


        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
        paramList.push(paramObj);

        isLeaderPop = true;

       /*  paramObj ={ name : 'parentKey' ,value : knd};
        paramList.push(paramObj); */
       userSelectPopCall(paramList);		//공통 선택 팝업 호출

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
		fnObj.setProjectInfo('${param.pId}');
	}

	//--콤마생성
	/*  $(".number").keyup(function(e) {

	  var value =e.target.value;	// 입력 값 알아내기
	  if(value!=''){
		  var result = addComma(value.replace(/,/gi,''));	// 천단위 콤마 추가한 결과값 리턴
		  if(result != undefined) e.target.value=result;
		  else e.target.value ='' ;
	  }
	 });  */


});

</script>