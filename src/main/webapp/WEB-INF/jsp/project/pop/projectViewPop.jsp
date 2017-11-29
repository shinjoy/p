<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<form id = "moveForm2" name = "moveForm2" method="post"></form>

<!-- -------- each page css :S -------- -->
<style type="text/css">
tbody tr:hover { background:#f5f7f8; /*f7f8f9*/ }
tbody tr.tr_selected { background:#edf1f2; /*f7f8f9*/ }
</style>
<!-- -------- each page css :E -------- -->


	<section id="detail_contents" class = "projectViewSection" >
   	<!-- Project Management -->
       <h3 class="h3_table_title">${baseUserLoginInfo.projectTitle} Management
       <a href="javascript:fnObj.openDetailPop('PROJECT');" id="editHistoryBtn" style="display:none;" class="btn_v_black mgl6"><em>수정이력</em></a>
       <a id="btnGoModifyPage" class="btn_s_type_g mgl5" href="javascript:fnObj.moveModifyPage()" style="display: none;"><em>수정하러가기</em></a>
       </h3>
       <a href="" class="popup_close"></a>
       <table class="tb_regi_temp" summary="Project Management, 프로젝트명 설명, 기간, 타입, 예산, 타임시트, 지출표기, 사용여부, 참여직원">
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
                   <th scope="row">${baseUserLoginInfo.projectTitle}명</th>
                   <td colspan="3">
                   		<strong><span id="v_projectName"></span></strong>
                   		<span style="float: right;">
                   			<span id="createArea"></span>
                   			<span id="updateArea"></span>
                   		</span>
                   </td>
               </tr>
               <tr>
                   <th scope="row">${baseUserLoginInfo.projectTitle}코드</th>
                   <td>
                        <strong><span id="v_projectCode"></span></strong>
                   </td>
                   <th scope="row">공개여부</th>
                   <td><span id="v_openFlag"></span></td>
               </tr>
               <tr>
                   <th scope="row">설명</th>
                   <td><span id="v_projectDesc"></span></td>
                   <th scope="row">유형</th>
                   <td><span id="v_projectType"></span></td>

               </tr>
               <tr>
                   <th scope="row">기간</th>
                   <td>
                   	<span id="v_period" style="font-weight: bold;"></span>
                   	<span id="v_chgPeriod"></span>
                   	<strong id="v_originEndDate" class="mgl20 spe_color_st6 txt_letter0"></strong>
                   </td>
                   <th scope="row">마감일</th>
                   <td>
                   	<span id="v_closeDate"></span>
                   	<strong id="v_originCloseDate" class="mgl20 spe_color_st6 txt_letter0"></strong>
                   </td>

                   <!-- 일단 사용 정해지면 풀자 -->
                   <th scope="row" style="display:none;">타입</th>
                   <td style="display:none;"><span id="v_projectType"></span></span>
                   </td>
               </tr>
               <tr>
                   <th scope="row">예산</th>
                   <td><span id="v_budget"></span><span id="v_budgetAmt" class="spe_color_st3"></span></td>
                    <th scope="row">사용여부</th>
                   <td><span id="v_enable"></span></td>
                  <!--  <th scope="row">타임시트</th> -->
                   <td style="display:none;">
                   	<span id="v_timesheet"></span>
                   	<span id="v_overTs"></span>
                   </td>
               </tr>
               <tr>
                   <th scope="row">지출</th>
                   <td>
					<span id="v_expense"></span>
                    <span id="v_overEx"></span>
                    <span id="v_overExpense"></span>
                    <span id="cardExpenseSumArea" class="current_expense mgl20"></span>
                   </td>
                   <th scope="row">확정여부</th>
                   <td><span id="v_confirm"></span></td>
               </tr>

               <tr>
                   <th scope="row">상태</th>
                   <td><span id="v_status"></span></td>
                   <th scope="row">지켜보는직원</th>
                   <td>
                   		<span id="v_viewEmployee"></span>
                   		<span id="v_viewEmployee_list"></span>
                   </td>
               </tr>

               <tr>
                   <th scope="row">직원배정</th>
                   <td colspan="3">
                   		<span id="v_employee"></span>
                   		<span id="v_employee_list"></span>
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
           	   <col width="3%" />
               <col width="18%" />
               <col width="*" 	/>
               <col width="18%" />
               <col width="10%" />
               <col width="15%" />
       <%--         <col width="6%" /> --%>
               <col width="8%" />
               <col width="20%" />
           </colgroup>
           <thead>
               <tr>
               	   <th scope="col">NO</th>
                   <th scope="col">Activity명</th>
                   <th scope="col">설명</th>
				   <th scope="col">기간</th>
                   <th scope="col">예산</th>
                   <th scope="col">지출</th>
                 <!--   <th scope="col">타임시트</th> -->
                   <th scope="col">사용여부</th>
                   <th scope="col">직원배정</th>
               </tr>
           </thead>
           <tfoot>
           		<tr>
           			<th colspan="4">합계</th>
           			<td class="txt_budget"><strong id="budgetSumArea">0</strong> <span>원</span></td>
           			<td class="txt_expense" style="padding:0px;text-align:center;"><span>-</span> <strong id="expenseSumArea">0</strong> <span>원</span></td>
           			<td class="txt_total" colspan="2"><strong id="chargeSumArea">0</strong> <span>원</span></td>
           		</tr>
           </tfoot>
           <tbody>
				<%-- //// 내용  --%>
           </tbody>
       </table>
       <!--/ Activity Management /-->
       <!-- 게시판 버튼 -->

       <div class="btn_baordZone2" id = "popBtnArea" style="display: none;">
       <a href="javascript:;" onclick="myModal.close('my-modal-div');" class="btn_witheline">닫기</a>
       </div>
       <!--/ 게시판 버튼 /-->
   </section>
<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')


//var g_templateId;			//템플릿 프로젝트 id


//공통코드 (외, 코드)
var codeYesNo;				//Yes or No
var codeEmployee;			//ALL or Yes
var codeEmployeeForNm;
var codeYesNoForNm;
var codeChgPeriodYesNo;
var codeChgTimeSheetYesNo;
var codeTemplateType;
var codeOverExpenseYesNo;

//프로젝트 상태
var codeProjectStatusNm;	//프로젝트 상태

//종료일
var endDate;

//마감일
var closeDate;

var myModal = new AXModal();	// instance
var myModal2 = new AXModal();	// instance

var myGrid = new SGrid();		// instance		new sjs

var g_projectId = 0;
var g_projectConfirm = 'N';
var g_orgId = 0;
var g_projectName = "";			//프로젝트 이름
var g_projectCode = "";			//프로젝트 코드

var project;		//프로젝트
var actList;	//activity
//지출팝업
var expensePop;

var g_myAuthIds ='${baseUserLoginInfo.myAuthIds}';			//인수인계자 아이디
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){

		codeYesNo = [{CD:'N', NM:'No'}, {CD:'Y', NM:'Yes'}];
		codeYesNoForNm = {N:'<b>N</b>',Y:'<b><font color=red>Y</font></b>'};					//화면에 NM 뿌려주기위해
		//codeChgPeriodYesNo = [{CD:'Y', NM:'기간수정가능'}, {CD:'N', NM:'기간수정불가'}];
		codeChgTimeSheetYesNo = [{CD:'Y', NM:'기간상관없음'}, {CD:'N', NM:'기간내'}];
		codeTemplateType =  getBaseCommonCode('PROJECT_TYPE', null, 'CD', 'NM', '', '선택','ALL', { orgId : '${baseUserLoginInfo.applyOrgId}' });
		codeOverExpenseYesNo = [{CD:'Y', NM:'예산초과허용'}, {CD:'N', NM:'예산초과불가'}];
		codeEmployee = [{CD:'A', NM:'전 직원'}, {CD:'Y', NM:'Yes'}];
		codeEmployeeForNm = {A:'<b>전 직원</b>',Y:'<b><font color=red>Y</font></b>'};

		codeProjectStatusNm = {EXPECT:'예정',PROGRESS:'진행',CLOSE_READY:'마감대기',CLOSED:'마감',TEMP_SAVE:'임시저장',PENDING:'보류',STOP:'중단',PENDING_CANCEL:'보류취소',STOP_CANCEL:'중단취소'};
	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
			{key:"",				formatter:function(obj){
										var pV = parseInt(1*obj.item.sort/100);		//부모 순번
										var sV = parseInt(1*obj.item.sort%100);		//자식 순번
										return ( pV + (sV>0?'-'+sV:'') );

			}},

			{key:"namelvl",			formatter:function(obj){
							var str = '<span>' + obj.item.name +'</span>';

							var empList = obj.item.empList;

							for(var i = 0 ; i <empList.length;i++){
								var empObj = empList[i];

								if(empObj.leaderYn == "Y" && g_myAuthIds.indexOf('|'+empObj.userId+'|') != -1){

										str += '<div>';
										str += '<a class="btn_s_type_g mgl5" href="javascript:fnObj.openDetailPop(\'EDIT\','+obj.item.activityId+',\''+obj.item.startDate+'\',\''+obj.item.endDate+'\')"><em>수정</em></a>';
										str += '<a class="btn_s_type_g mgl5" href="javascript:fnObj.openDetailPop(\'HISTORY\','+obj.item.activityId+')"><em>이력보기</em></a>';
										str += '</div>';

								}
							}


							return str;

			}},
            {key:"description",		formatter:function(obj){return (obj.value);}},

            {key:"period",			formatter:function(obj){
            							var str = (obj.item.startDate).replace(/-/gi,'/') + ' ~ ' + (obj.item.endDate).replace(/-/gi,'/')

            							//확정일때만 액티비티 상태 표기
            							if(g_projectConfirm == 'Y'){
	            							str += '<span class="spe_color_st3"><em>(';
	            							if(new Date().yyyy_mm_dd()  <= obj.item.endDate   && obj.item.startDate <= new Date().yyyy_mm_dd()){
	            								str += '진행';
	            							}else if(obj.item.endDate < new Date().yyyy_mm_dd()){
	            								str += '마감';
	            							}else if(obj.item.startDate > new Date().yyyy_mm_dd()){
	            								str += '예정';
	            							}
	            							str += ')</em></span>';
            							}
            							return str;

            }},

            {key:"budget",			formatter:function(obj){return (obj.value=='Y'?formatMoney(obj.item.budgetAmt,'INSERT') + ' 원':codeYesNoForNm[obj.value]);}},

            {key:"expense",			formatter:function(obj){
            							var rStr = codeYesNoForNm[obj.value];

            							if(obj.value == 'Y' && obj.item.budget == 'Y'){		//지출이 Y 면서  예산이 N 일때만 예산 초과에 대한 txt 보여줌.
            								rStr += ' (' + getRowObjectWithValue(codeOverExpenseYesNo, 'CD', obj.item.overExpense)['NM'] + ')';
            							}

            							//액티비티 사용금액
            							if(obj.item.cardExpenseSum != 0){
						            		rStr += '<strong class="mgl10">'+Number(obj.item.cardExpenseSum).toLocaleString().split(".")[0]+'  </strong>원 사용';
						            	}



            							return rStr;}},

            {key:"timesheet",		formatter:function(obj){return (codeYesNoForNm[obj.value]);}},
            {key:"enable",			formatter:function(obj){return (codeYesNoForNm[obj.value]);}},
            {key:"employee",		formatter:function(obj){
            							var rStr = codeEmployeeForNm[obj.value];

							           	rStr += '<div id="selectedList' + (obj.index) + '" style="' + (obj.value=='A'?'display:none':'') + '">';
							           	//배정직원 리스트
							       		var empList = obj.item.empList;
							       		for(var i=0; i<empList.length; i++){
							       			if(empList[i].leaderYn == "Y" ) {

							       				rStr += '<span class="task_leader" onmouseover="openLeaderHelpPop($(this))"  onmouseout="closeLeaderHelpPop()">'+empList[i].userNm+'</span>';
							       			}else{
							       				rStr += '<span>'+empList[i].userNm+'</span>';
							       			}

							       			if(i<empList.length-1) rStr += ', ';
							       		}

							           	rStr += '</div>';

            							return rStr;}},
            {key:"bgcolor",			formatter:function(obj){
            							if(obj.item.enable == 'N'){
            								return 'silver';					//사용여부가 'N' 일때 어둡게
            							}else{
            								return '';
            							}
            						}}

            ]

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr style="background-color:#[9]!important;">';
    	rowHtmlStr +=	 '<th scope="row" style="text-align:center;">#[0]</th>';
    	rowHtmlStr +=	 '<td>#[1]</th>';
    	rowHtmlStr +=	 '<td class="special_f_st2" style="text-align:left;">#[2]</td>';
    	rowHtmlStr +=	 '<td class="special_f_st2">#[3]</td>';
    	rowHtmlStr +=	 '<td>#[4]</td>';
    	rowHtmlStr +=	 '<td>#[5]</td>';
    	rowHtmlStr +=	 '<td  style="display:none;">#[6]</td>';
    	rowHtmlStr +=	 '<td>#[7]</td>';
    	rowHtmlStr +=	 '<td class="joinmb_list">#[8]</td>';
        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;


    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅

    	//-------------------------- 모달창 :S -------------------------
	   	myModal2.setConfig({
	   		windowID:"myModalCT",

	   		width:740,
	           mediaQuery: {
	               mx:{min:0, max:767}, dx:{min:767}
	           },
	   		displayLoading:true,
	           scrollLock: false,
	   		onclose: function(){
	   			//내용가져오기
	   			fnObj.setProjectInfo();
	   			mask.open();

	   		}
	           ,contentDivClass: "popup_outline"

	   	});
   		//-------------------------- 모달창 :E -------------------------
    	//-------------------------- 그리드 설정 :E ----------------------------

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################


  	//프로젝트 정보 불러와 세팅
    setProjectInfo: function(){
    	var pid = '${param.pId}';
    	//g_templateId = tId;		//전역변수에 세팅

    	var url = "<c:url value='/project/getProjectInfo.do'/>";

    	var orgId = "${treeOrg}" == ""?'${baseUserLoginInfo.applyOrgId}':"${treeOrg}";

    	var param = {
    					projectId : pId,
    					orgId : orgId
    				};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var jsonObj = obj.resultObject;		//결과데이터JSON

    		project = jsonObj.pProject;		//프로젝트
    		actList = jsonObj.pActivity;	//activity
    		viewEntryList = jsonObj.viewEntryList;		//지켜보는직원

    		if(obj.result == "SUCCESS"){

    			g_projectId = project.projectId;		//프로젝트 아이디
    			g_projectConfirm = project.confirm;		//프로젝트 확정여부
    			g_orgId = project.orgId;				//프로젝트 orgId
    			g_projectName = project.name;			//프로젝트 이름
    			g_projectCode = project.projectCode;	//프로젝트 코드
    	    	//----- 내용뿌리기 :S -----

    	    	//프로젝트
    	    	$('#v_projectName').html(project.name);								//프로젝트명
    	    	$('#v_projectCode').html(project.projectCode);                               //프로젝트코드
    	    	$('#v_projectDesc').html(project.description);						//프로젝트설명
    	    	$('#v_projectType').html(project.projectTypeNm);						//프로젝트타입
    	    	$("#v_confirm").html(codeYesNoForNm[project.confirm]);								//확정여부
    	    	$("#v_status").html(codeProjectStatusNm[project.projectStatus]);								//상태

    	    	var openFlagStr = project.openFlag=="Y"?"공개":"비공개";
    	    	$("#v_openFlag").html(openFlagStr);								//공개여부


    	    	if(project.period == 'Y'){
    	    		$('#v_period').html((project.startDate).replace(/-/gi,'/') + ' ~ ' + (project.endDate).replace(/-/gi,'/'));		//시작일 ~ 종료일
    	    		$('#v_closeDate').html((project.closeDate).replace(/-/gi,'/'));							//마감일

    	    		//기간이 Y 이고 확정 상태이면
    	    		if(project.confirm == 'Y'){

    	    			var originEndDate = project.originEndDate==null?"":project.originEndDate;

    	    			var originCloseDate = project.originCloseDate==null?"":project.originCloseDate;

    	    			$("#v_originEndDate").html(' (최초 종료일:'+(originEndDate).replace(/-/gi,'/')+')');

    	    			$("#v_originCloseDate").html(' (최초 마감일:'+(originCloseDate).replace(/-/gi,'/')+')');

    	    		}
    	    	}else{
    	    		$('#v_period').html(codeYesNoForNm[project.period] + ' (기간상관없음)');							//기간
    	    		$('#v_closeDate').html('기간상관없음');															//기간
    	    	}
    	    	//확정 상태이면
	    		if(project.confirm == 'Y'){

	    			if(parseInt(project.createdBy)==parseInt("${baseUserLoginInfo.userId}")){
		    			if(project.pendingFlag == 'N' && project.stopFlag == 'N'){
		    				$("#btnPendingProject").show();
		    				$("#btnStopProject").show();
		    			}else if(project.pendingFlag == 'Y' && project.stopFlag == 'N'){
		    				$("#btnPendingProjectCancel").show();
		    			}else if(project.pendingFlag == 'N' && project.stopFlag == 'Y'){
		    				$("#btnStopProjectCancel").show();
		    			}
	    			}
	    		}

    	    	//$('#v_projectType').html(getRowObjectWithValue(codeTemplateType, 'CD', project.projectType)['NM']);					//타입

    	    	if(project.budget == 'Y'){
    	    		var korNum = numToKorean(''+project.budgetAmt);
    	    		$('#v_budgetAmt').html(formatMoney(''+project.budgetAmt, 'INSERT') + '원 ' + (isEmpty(korNum)?'':'<em>(' + korNum + ')</em>'));	//예산
    	    	}else{
    	    		$('#v_budget').html(codeYesNoForNm[project.budget]);				//예산
    	    	}
    	    	$('#v_timesheet').html(codeYesNoForNm[project.timesheet]);			//타임시트
    	    	if(project.timesheet == 'Y')
    	    		$('#v_overTs').html('&nbsp;(' + getRowObjectWithValue(codeChgTimeSheetYesNo, 'CD', project.overTs)['NM'] + ')');		//기간상관여부
    	    	$('#v_expense').html(codeYesNoForNm[project.expense]);				//지출
    	    	if(project.expense == 'Y'){
    	    		$('#v_overEx').html('&nbsp;(' + getRowObjectWithValue(codeChgTimeSheetYesNo, 'CD', project.overEx)['NM'] + ')');		//기간상관여부
    	    		if(project.budget == 'Y') $('#v_overExpense').html('&nbsp;(' + getRowObjectWithValue(codeOverExpenseYesNo, 'CD', project.overExpense)['NM'] + ')');	//예산초과지출허용 여부

    	    		if(project.cardExpenseSum !=0 ){
    	    			var stStr = '<strong>현재 :</strong> <span> '+ Number(project.cardExpenseSum).toLocaleString().split(".")[0] +'</span> <em>원</em></span>';

    	    			var pmId = "|"+project.createdBy.toString()+"|";
    	    			if("${baseUserLoginInfo.myAuthIds}".indexOf(pmId)>-1){
    	    				stStr+='<button type="button" class="btn_s_type_g mgl10" onclick="fnObj.expenseListPop();">상세보기</button>'
    	    			}
    	    			$("#cardExpenseSumArea").html(stStr);
    	    		}else{
    	    			$("#cardExpenseSumArea").html('');
    	    		}

    	    	}
    	    	$('#v_enable').html(codeYesNoForNm[project.enable]);				//사용여부



    	    	$('#v_employee').html(codeEmployeeForNm[project.employee]);			//직원배정
    	    	var empList = project.empList;
    	    	var eStr = '';
				for(var i=0; i<empList.length; i++){
					if(i==0) eStr += '&nbsp;(';
					eStr += empList[i].userNm;
					if(i==empList.length-1){
						eStr += ')';
					}else{
						eStr += ', ';
					}
           		}
				$('#v_employee_list').html(eStr);
    	    	if(project.employee=='Y'){
    	    		$('#v_employee_list').show();
    	    	}else{
    	    		$('#v_employee_list').hide();
    	    	}

    	    	$('#v_viewEmployee').html(viewEntryList.length > 0 ? '<strong style="color:red;">Y</strong>' : 'N');			//지켜보는직원

    	    	var vStr = '';
				for(var i=0; i<viewEntryList.length; i++){
					if(i==0) vStr += '&nbsp;(';
					vStr += viewEntryList[i].userNm;
					if(i == viewEntryList.length-1){
						vStr += ')';
					}else{
						vStr += ', ';
					}
           		}
				$('#v_viewEmployee_list').html(vStr);

				if(viewEntryList.length > 0){
    	    		$('#v_viewEmployee_list').show();
    	    	}else{
    	    		$('#v_viewEmployee_list').hide();
    	    	}

    	    	$('#createArea').html('<strong>등록자: </strong>'+project.createNm+' ('+(project.createDate).replace(/-/gi,'/')+')');
    	    	$('#updateArea').html('| <strong>최종수정자: </strong>'+project.updateNm+' ('+(project.updateDate).replace(/-/gi,'/')+')');


    	    	if(project.createdBy == '${baseUserLoginInfo.userId}') $("#editBtn").show();
    	    	else $("#editBtn").hide();

    	    	if(g_myAuthIds.indexOf('|'+project.createdBy+'|') != -1){
    	    		$("#editHistoryBtn").show();
    	    		$("#btnGoModifyPage").show();

    	    	}else{
    	    		$("#editHistoryBtn").hide();
    	    		$("#btnGoModifyPage").hide();
    	    	}
    	    	//activity
	    		myGrid.setGridData({
									list: actList,	//그리드 테이터
									page: null		//페이징 데이터
	    						});


    			//----- 내용뿌리기 :E -----

    			//합계 계산
	    		var budgetSum = 0;		//예산 합계
	        	var expenseSum = 0;		//지출 합계

	        	for(var i=0;i<actList.length;i++){
	        		if(actList[i].budget == 'Y' && actList[i].budgetAmt !='' && actList[i].budgetAmt !=null)budgetSum += parseInt(actList[i].budgetAmt);
	        		if(actList[i].cardExpenseSum !='' && actList[i].cardExpenseSum !=null)expenseSum += parseInt(actList[i].cardExpenseSum);
	        	}

	        	var chargeSum = parseInt(budgetSum)-parseInt(expenseSum);

    			$("#budgetSumArea").html(Number(budgetSum).toLocaleString().split(".")[0]);
    	    	$("#expenseSumArea").html(Number(expenseSum).toLocaleString().split(".")[0]);
    	    	$("#chargeSumArea").html(Number(chargeSum).toLocaleString().split(".")[0]);		//남은 금액


	    		fnObj.resetLevelAndClass();			//레벨 값 및 스타일 class 재세팅


	    		if("yes" == "${param.saved}"){	    //저장후 상세보기 페이지로 넘어온경우
	    			parent.toast.push("저장OK!");	//저장 메세지를 보여준다.
	    		}else if("cancel" == "${param.saved}"){	//보류취소 , 중지 취소인경우
	    			parent.toast.push("${baseUserLoginInfo.projectTitle} 기간과 마감일을 확인해주세요");	//확인 메세지를 보여준다.
	    		}

    		}else{
    			//alertMsg();
    		}

    		//부모창의 화면셋팅을 위한 함수....(부모 jsp에 구현)
    		setPageSearchInfo();

    		try{
    			expensePop.fnObj.preloadCode();
    		}catch(exception){
            	//window.opener.openPageReload();
            	//opener.location.reload();
            }

    	};

    	commonAjax("POST", url, param, callback,false);

    },//setProjectInfo


    //레벨 값 및 스타일 class 재세팅
    resetLevelAndClass: function(){

    	var list = myGrid.dataList;

    	var level;

    	for(var i=0; i<list.length; i++){

    		level = list[i].level * 1;

    		//class 스타일 세팅
    		if(level == 0){
    			$(myGrid.gridBodyObject.children('tr')[i]).addClass('level_first_v');

    		}else{	//level == 1

    			var tr = $(myGrid.gridBodyObject.children('tr')[i]);
    			tr.removeClass('level_second_v');		//init
    			tr.removeClass('level_second_v_end');	//init

    			if(list.length == i+1){	//마지막 activity
        			tr.addClass('level_second_v_end');

        		}else if(list[i + 1].level == 0){	//다음 activity 의 레벨이 0인 케이스
        			tr.addClass('level_second_v_end');

        		}else{
        			tr.addClass('level_second_v');
        		}
    		}

    	}//for

    },

  	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
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


    	var option = "left=" + (screen.width > 1400?"550":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=1200, height=700, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	expensePop =window.open('','expensePop',option);

    	document.expenseFrm.submit(); // target에 쏜다.
    	return false;

    },
    getProject:function(){
    	return project;
    },
    getActList:function(){
    	return actList;
    },

    //프로젝트 팝업 & 액티비티 수정 / 히스토리 팝업
    openDetailPop : function(type, activityId, startDate, endDate){

    	var nowDate = new Date();
    	var width = 1400;
    	var url = "<c:url value='/project/viewActivityUpdateHist.do'/>";

    	if(type == 'HISTORY'){


    		popTitle =" ${baseUserLoginInfo.activityTitle} 수정이력";

    		params = {
    				activityId	:	activityId
    		};


    	}else if(type == 'EDIT'){

    		url = "<c:url value='/project/updateActivityInfo.do'/>";

    		popTitle =" ${baseUserLoginInfo.activityTitle} 수정";



    		var year = nowDate.getFullYear();
    		var endYear = endDate.split("-")[0];

    		if(endYear !="9999"){
    			if(endYear<year){
    				year = endYear;
    			}
    		}

    		params = {
    				activityId	:	activityId,
    				startDate	:	startDate,
    				endDate		:	endDate,
    				year		:	year
    		};

    	}else if(type == 'PROJECT'){

			url = "<c:url value='/project/viewProjectHistoryList.do'/>";

    		popTitle =" ${baseUserLoginInfo.projectTitle} 수정이력";

    		params = {
    				projectId	:	g_projectId,
    				projectName	:	g_projectName

    		};

    	}

	 	myModal2.open({
			windowID:"myModalCT",
			url: url,
			pars: params,
			titleBarText: popTitle,		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
			method:"POST",
			top: $(window).scrollTop() + 150,
			width: width,
			closeByEscKey: true			//esc 키로 닫기
		});

		$('#myModalCT').draggable();
    },
    moveModifyPage:function(){

    	$("#moveForm2").attr("action",contextRoot + "/project/projectReg.do?saved=&pId="+project.projectId);

    	var newWin = window.open("about:blank","projectModifyPop");
    	$("#moveForm2").attr("target","projectModifyPop");

    	$("#moveForm2").submit();
    }
  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	//fnObj.doSearch();		//검색
	//fnObj.setTooltip();
	pId = "${projectId}";
	$("#popBtnArea").show();
	$("#viewBtnArea").hide();

	$(".projectViewSection").attr("id" , "projectDetail")

	//내용가져오기
	fnObj.setProjectInfo();

});
</script>