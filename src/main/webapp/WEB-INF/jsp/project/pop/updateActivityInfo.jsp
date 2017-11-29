<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>

<form name="activityModifyForm" id = "activityModifyForm" method="post">
	<input type="hidden" id = "projectId" name = "projectId">
	<input type="hidden" id = "activityId" name = "activityId" value="${activityId }">
	<input type="hidden" id = "year" name = "year" value="${year }">
	<input type="hidden" id = "searchStartDate" name = "searchStartDate" value="${startDate }">
	<input type="hidden" id = "searchEndDate" name = "searchEndDate" value="${endDate }">
	<input type="hidden" id = "beforeProgress" name = "searchEndDate" value="${progressRate }">
	<input type="hidden" id = "beforeBaseProgressYn" name = "searchEndDate" value="${progressRate }">
	<input type="hidden" id = "name" name = "name">
	<div class="mo_container">
		<input type="hidden" name="familyEventsId" id = "familyEventsId">
		<table class="tb_basic_left">
	    	<colgroup>
				<col width="130" />
				<col width="*" />
			</colgroup>
			<tbody>
			    <tr>
                    <th scope="row">기간</th>
                    <td>
                      	<input type="text" id = "startDate" name = "startDate" value="" class="input_date_type" title="시작일" />
                      	<span class="mgl6">~</span>
                      	<input type="text" id = "endDate" name = "endDate" value="" class="input_date_type" title="종료일" />
                    </td>
                </tr>
			    <tr>
                    <th scope="row"><label for="eventTypeSelectTag">참여자</label></th>
                    <td class="joinmb_list pd0">
                    	<div class="btnZone_pd">
                    	<a href="#" id="activityUserAddBtn" onclick="openUserPopup();" class="btn_select_employee" style=""><em>직원선택</em></a>
	                    	<span id = "leaderArea">

	                    	</span>
                    	</div>
                    	<div id = "employeeArea">

                    	</div>

                    </td>
                </tr>
		 		<tr>
		 			<th scope="row"><label for="amount">진척율</label></th>
		 			<td>

		 				<label>
		 					<input type="radio" class="mgl8" name="baseProgressYn" value="Y" onclick="chgProgressInput()"
		 						<c:if test = "${baseProgressYn eq 'Y'}"> checked="checked"</c:if>
		 					>
		 					<span>산출기준적용</span>
		 				</label>
		 				<label>
		 					<input type="radio" class="mgl8" name="baseProgressYn" value="N"  onclick="chgProgressInput()"
		 						<c:if test = "${baseProgressYn eq 'N'}"> checked="checked"</c:if>
		 					>
		 					<span>수기관리적용</span>
		 				</label>
		 				<span id = "progressRateInputArea">
			 				<input type="text" name="progressRate" id="progressRate" class="percen_input_b number" maxlength="3" value="${progressRate }">
						</span>
		 			</td>
		 		</tr>
				<tr>
		 			<th scope="row"><label for="period">사유</label></th>
		 			<td>
		 				<textarea id="updateReason" name="updateReason" class="textarea_basic w100pro" placeholder="사유를 입력하세요."></textarea>
		 			</td>
		 		</tr>

			</tbody>
		</table>
		<div class="btnZoneBox">
			<button id="btnSave" type="button" class="p_blueblack_btn" onclick="doActivityUpdate();"><strong>저장</strong></button>
			<!-- <button id="btnDel" type="button" class="p_withelin_btn" onclick="fnObj.tryDelete();">삭제</button> -->
			<button id="btnDel" type="button" class="p_withelin_btn" onclick="parent.myModal2.close();">닫기</button>
		</div>
	</div>
	<input type="hidden" name = "comment" id="comment">
</form>

<script type="text/javascript">
var project;
var actObj;

var disabledCnt = 0;
var disabledUserList = new Array();

var initProgressRate = parseInt("${progressRate }");
$(document).ready(function(){
	numberFormatForNumberClass();
	//프로젝트 엑티비티 셋팅
	project = parent.project;

	$("#projectId").val(project.projectId);

	var isEmployeeAdd;
	if(project.employee == "Y"){
		 isEmployeeAdd = true;
	}else{
		$("#employeeArea").text("전직원");
		isEmployeeAdd = false;
		$("#activityUserAddBtn").hide();
	}
	var actList = parent.actList;
	for(var i = 0 ; i<actList.length; i++){
		if(parseInt(actList[i].activityId) == parseInt("${activityId }")){
			actObj = actList[i];
		}
	}
	///////////////////////////////날짜 DATEPICKER : S///////////////////////////////
	var actEndDate = actObj.endDate;
	var actStartDate = actObj.startDate;
	$('#startDate').val(actStartDate);
	$('#endDate').val(actEndDate);
	$('#startDate').attr("readonly","readonly");
	$('#endDate').attr("readonly","readonly");


	//배정직원 리스트
	var empList = actObj.empList;
	var isDateModify = true;
	for(var i=0; i<empList.length; i++){
		var isDisabledUser=false;


		if(actEndDate.split("-")[0]!="9999"){

		if(actObj.confirm == 'Y'){		//확정일때

			if((empList[i].scheChk !='' && empList[i].scheChk !=undefined) || (empList[i].apprChk !='' && empList[i].apprChk !=undefined)|| (empList[i].memoTeamChk !=''  & empList[i].memoTeamChk !=undefined)|| (empList[i].memoPrivateChk !=''  & empList[i].memoPrivateChk !=undefined)){
				disabledUserList.push(empList[i].userId);
				isDisabledUser = true;

				if(isDateModify) isDateModify = false;

			}
			}
		}

		var leaderYn = empList[i].leaderYn;
		if(isEmployeeAdd && leaderYn !="Y"){

			var stStr = "";
			stStr += "<span class=\"employee_list activityUserList\" id = 'activityUserList_"+empList[i].userId+"'";

			if(isDisabledUser){
				stStr +=  ' onclick="nameDetailDisplay(\'p\','+i+');"';
			}

			stStr +=">";

			if(i>1) stStr+="<span><div id = 'activityUserList_comma' style='display:inline'>,</div>";
			else stStr+="<span>";

			if(isDisabledUser){
				stStr += '<font color="#517dc6">';
			}
			stStr += empList[i].userNm;

			if(isDisabledUser){
				stStr += '</font>';
			}

			stStr +="<em>("+empList[i].position+")</em></span>";

			stStr += "<input type=\"hidden\" name = \"activityUser\" value=\""+empList[i].userId+"\">";
			if(!isDisabledUser){
				stStr += "<a href=\"javascript:deleteStaff('"+empList[i].userId+"')\" class=\"btn_delete_employee\"><em>삭제</em></a>";
			}else{
				stStr +='<input type="hidden" name = "disabledUser" value="'+empList[i].userId+'">';
				disabledCnt++;
				//------ 툴팁 세팅  : S
				stStr +='<span class="tooltip">';
			 	stStr +=' <div id="helpProMgmt" name="nameDetailp_'+i+'" class="tooltip_box" style="display:none; width:200px;left:-110px;margin-left:0px;"> ';
				stStr +=' <span class="intext"> ';
				if(empList[i].scheChk !='' ){
					stStr +=' <ul class="list_st_dot3">';
					stStr +=' <li> 일정: '+empList[i].scheChk+'</li>';
					stStr +=' </ul>';
				}
				if(empList[i].apprChk !='' ){
					stStr +=' <ul class="list_st_dot3">';
					stStr +=' <li> 전자결재: '+empList[i].apprChk+'</li>';
					stStr +=' </ul>';
				}

				if(empList[i].memoTeamChk !='' ){
					stStr +=' <ul class="list_st_dot3">';
					stStr +=' <li> 팀업무: '+empList[i].memoTeamChk+'</li>';
					stStr +=' </ul>';
				}

				if(empList[i].memoPrivateChk !='' ){
					stStr +=' <ul class="list_st_dot3">';
					stStr +=' <li> 개인업무: '+empList[i].memoPrivateChk+'</li>';
					stStr +=' </ul>';
				}


				stStr +=' </span>';

				stStr +=' <a href="javascript:nameDetailDisplay(\'p\','+i+');" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a> ';
				stStr +=' <em class="edge_topcenter" style="left:50px;"></em> ';

				stStr +=' </div> </span>';
			}
			stStr += "</span>";

			$("#employeeArea").append(stStr);


		}



		if(leaderYn == "Y"){
			var stStr = "";

			stStr += "<span class=\"task_leader activityUserList\" id = 'activityUserList_"+empList[i].userId+"'";

			if(isDisabledUser){
				stStr +=  ' onclick="nameDetailDisplay(\'p\','+i+');"';
			}

			stStr +=">";

			if(isDisabledUser){
				stStr += '<font color="#517dc6">';
			}
			stStr += empList[i].userNm;

			if(isDisabledUser){
				stStr += '</font>';
			}
			stStr +="<em>("+empList[i].position+")</em></span>";


			stStr += "<input type=\"hidden\" name = \"activityUser\" value=\""+empList[i].userId+"\">";
			stStr += "<input type=\"hidden\" name = \"activityLeaderUser\" value=\""+empList[i].userId+"\">";
			if(isDisabledUser){
				//------ 툴팁 세팅  : S
				stStr +='<span class="tooltip">';
			 	stStr +=' <div id="helpProMgmt" name="nameDetailp_'+i+'" class="tooltip_box" style="display:none; width:200px;left:-110px;margin-left:0px;"> ';
				stStr +=' <span class="intext"> ';
				if(empList[i].scheChk !='' ){
					disabledCnt++;
					stStr +=' <ul class="list_st_dot3">';
					stStr +=' <li> 일정: '+empList[i].scheChk+'</li>';
					stStr +=' </ul>';
				}
				if(empList[i].apprChk !='' ){
					disabledCnt++;
					stStr +=' <ul class="list_st_dot3">';
					stStr +=' <li> 전자결재: '+empList[i].apprChk+'</li>';
					stStr +=' </ul>';
				}
				if(empList[i].memoTeamChk !='' ){
					stStr +=' <ul class="list_st_dot3">';
					stStr +=' <li> 팀업무: '+empList[i].memoTeamChk+'</li>';
					stStr +=' </ul>';
				}

				if(empList[i].memoPrivateChk !='' ){
					stStr +=' <ul class="list_st_dot3">';
					stStr +=' <li> 개인업무: '+empList[i].memoPrivateChk+'</li>';
					stStr +=' </ul>';
				}

				stStr +=' <em class="edge_topcenter" style="left:50px;"></em> ';
				stStr +=' </span>';

				stStr +=' <a href="javascript:nameDetailDisplay(\'p\','+i+');" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a> ';


				stStr +=' </div> </span>';
			}

			stStr += "</span>";
			$("#leaderArea").append(stStr);
		}
	}
	var employeeAreaTxt = $("#employeeArea").text().trim();

	if(employeeAreaTxt == "") $("#employeeArea").hide();

	if(actEndDate.split("-")[0]!="9999"){
		$('#endDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'}).prop("readonly",true);
	}

	if(isDateModify){

		$('#startDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
		if(actEndDate.split("-")[0]!="9999"){
			$('#endDate').datepicker("option", "maxDate", project.endDate);
			$('#endDate').datepicker("option", "minDate", project.startDate);
		}
		$('#startDate').datepicker("option", "maxDate", project.endDate);
		$('#startDate').datepicker("option", "minDate", project.startDate);

		$('#startDate').datepicker("option", "onClose", function ( selectedDate ) {
			if(actEndDate.split("-")[0]!="9999"){
	        $("#endDate").datepicker( "option", "minDate", selectedDate );
			}
	     });
		if(actEndDate.split("-")[0]!="9999"){
			$('#endDate').datepicker("option", "onClose", function ( selectedDate ) {
		            $("#startDate").datepicker( "option", "maxDate", selectedDate );
		      });
		}
	}else{
		if(actEndDate.split("-")[0]!="9999"){
			$('#endDate').datepicker("option", "maxDate", project.endDate);
			$('#endDate').datepicker("option", "minDate", $("#endDate").val());
		}
	}

	chgProgressInput();
});
var disabledArr =[];
//참여자 추가 팝업
function openUserPopup(){
	var paramList = [];
	var param = "";

	var userStr ='';
	var disabledStr ='';
	var arr =[];

	var selectUserList =$("input[name='activityUser']");
	var disabledList =$("input[name='activityLeaderUser'],input[name='disabledUser']");
	for(var i=0;i<selectUserList.length;i++){
		arr.push(selectUserList[i].value);
		}

	userStr = arr.join(',');

	for(var i=0;i<disabledList.length;i++){
		disabledArr.push(disabledList[i].value);
		}

	disabledStr = disabledArr.join(',');

	var paramObj ={ name : 'userList'   ,value : userStr};
    paramList.push(paramObj);
    paramObj ={ name : 'disabledList'   ,value : disabledStr};		//선택 불가
    paramList.push(paramObj);
    paramObj ={ name : 'isOneOrg' ,value : 'Y'};
    paramList.push(paramObj);

    userSelectPopCall(paramList);		//공통 선택 팝업 호출
}

var fnObj = {

	    //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
	    getResult: function(list){
	    	fnObj.actionBySelData(list);
	    },
		 //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
	    actionBySelData: function(listObj){
			$("#employeeArea").empty();

			var leaderId = $("input[name = 'activityLeaderUser']").val();

	    	for(var i = 0 ; i <listObj.length; i++){
	    		if(leaderId == listObj[i].userId){
					continue;
				}
	    		var stStr = "";
				stStr += "<span class=\"employee_list activityUserList\" id = 'activityUserList_"+listObj[i].userId+"'";

				stStr += ">";
				if(i>0) stStr+="<span><div id = 'activityUserList_comma' style='display:inline'>,</div>";
				else stStr+="<span>";

				stStr += listObj[i].userName+"</span><em>("+listObj[i].rankNm+")</em>";

				stStr += "<input type=\"hidden\" name = \"activityUser\" value=\""+listObj[i].userId+"\">";

				var isDisabled = false;
				for(var j = 0 ; j <disabledArr.length ; j++){
					if(disabledArr[j]== listObj[i].userId) isDisabled = true;
				}
				if(!isDisabled)
					stStr += "<a href=\"javascript:deleteStaff('"+listObj[i].userId+"')\" class=\"btn_delete_employee\"><em>삭제</em></a>";

				stStr += "</span>";

				$("#employeeArea").append(stStr);
	    	}

	    	var employeeAreaTxt = $("#employeeArea").text().trim();

	    	if(employeeAreaTxt == "") $("#employeeArea").hide();
	    	else $("#employeeArea").show();

	    }
}

//참여자 삭제
function deleteStaff(userId){
	$("#activityUserList_"+userId).remove();

	$("span[id*='activityUserList_']").eq(0).find("#activityUserList_comma").remove();

	var employeeAreaTxt = $("#employeeArea").text().trim();

	if(employeeAreaTxt == "") $("#employeeArea").hide();
	else $("#employeeArea").show();
}
//저장
function doActivityUpdate(){

	if($("#updateReason").val().trim() == ""){
		alert("수정사유를 입력해 주세요.");
		$("#updateReason").focus();
		return;
	}

	if(confirm("저장하시겠습니까?")){
		var now = new Date();
		var comment = "*[${baseUserLoginInfo.activityTitle} 수정 알림]\n\n";

		comment+="[${baseUserLoginInfo.projectTitle}] : "+project.name + "(" + project.projectCode + ")\n";
		comment+="[${baseUserLoginInfo.activityTitle}] : "+actObj.name+"\n";
		comment+="[수정자] : ${baseUserLoginInfo.userName}\n";
		comment+="[수정일] : "+now.yyyy_mm_dd();

		//////////수정 내용이 있는지 체크해서 메모에 추가한다 :S

		//날짜수정체크
		var initStartDate = actObj.startDate;
		var initEndDate = actObj.endDate;

		if(initStartDate!=$("#startDate").val() || initEndDate!=$("#endDate").val()){
			comment+="\n[기간변경]\n    ";
			comment+="-변경전 : "+initStartDate+" ~ "+initEndDate;
			comment+="\n    -변경후 : "+$("#startDate").val()+" ~ "+$("#endDate").val();
		}
		//참여자 수정 체크
		var empList = actObj.empList;
		var isModifyUser = false;
		if(project.employee == "Y"){
			if(empList.length>0){
				for(var k = 0 ; k < empList.length ; k++){
					if($("input[name='activityUser'][value='"+empList[k].userId+"']").length==0){
						isModifyUser = true;
					}
				}
				if(empList.length != $("input[name='activityUser']").length){
					isModifyUser = true;
				}
			}else if($("input[name='activityUser']").length>0){
				isModifyUser = true;
			}
		}
		if(isModifyUser){
			var initUserStr = "";

			var modifyUserStr = "";

			for(var k = 0 ; k < empList.length ; k++){

				var empObj = empList[k];

				if(k>0) initUserStr +=",";

				initUserStr += empObj.userNm+"("+empObj.position+")";

				if(empObj.leaderYn=="Y"){
					initUserStr += "[리더]";
				}
			}
			$("#leaderArea input[name='activityUser']").each(function(){
				modifyUserStr+=$(this).parent().find("span").eq(0).text();
				modifyUserStr += "[리더]";
				//modifyUserStr+=$(this).parent().find("em").eq(0).text();
			});

			$("#employeeArea input[name='activityUser']").each(function(i){

				if(modifyUserStr.trim()!="" && i == 0) modifyUserStr+=",";

				modifyUserStr+=$(this).parent().find("span").eq(0).text();
				modifyUserStr+="";
				//modifyUserStr+=$(this).parent().find("em").eq(0).text();
			});
			comment+="\n[참여자변경]\n    ";
			comment+="-변경전 : "+initUserStr;
			comment+="\n    -변경후 : "+modifyUserStr;
		}
		var initBaseProgressYn ="${baseProgressYn}";
		var modifyBaseProgressYn =  $("input[name='baseProgressYn']:checked").val();

		if(initBaseProgressYn != modifyBaseProgressYn || initProgressRate!=parseInt($("#progressRate").val())){

			comment+="\n[진척율변경]\n    ";
			comment+="-변경전 : "

			if(initBaseProgressYn == "Y") comment+= "산출기준적용";
			else comment+= initProgressRate+"%";

			comment+="\n    -변경후 : ";

			if(modifyBaseProgressYn == "Y") comment+= "산출기준적용";
			else comment+= $("#progressRate").val()+"%";

		}
		//////////수정 내용이 있는지 체크해서 메모에 추가한다 :E

		comment+="\n\n[사유]\n";
		comment+=$("#updateReason").val();
		comment+= "\n\n##moveCommonWbsPage($"+project.projectId+"$)##";

		$("#comment").val(comment);
		var name = actObj.name;

		$("#name").val(name);

		$("#activityModifyForm").attr("action",contextRoot+"/project/updateActivityInfoAjax.do");
		commonAjaxSubmit("POST",$("#activityModifyForm"),doActivityUpdateCallback);
	}
}

//저장 콜백
function doActivityUpdateCallback(data){
	if(data.resultObject.result =="SUCCESS"){

		alert("저장되었습니다.");

		parent.myModal2.close();

	}else{
		alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
	}
}

//진척율 리셋
function resetProgressRate(year,activityId){
	$("#activityModifyForm").attr("action",contextRoot+"/project/updateActivityProgressRate.do");
	commonAjaxSubmit("POST",$("#activityModifyForm"),resetProgressRateCallback);
}

//진척율 리셋 콜백
function resetProgressRateCallback(data){
	if(data.resultObject.result =="SUCCESS"){

	}else{
		alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
	}
}
//사람별 등록 일정
function nameDetailDisplay(rowIdx,idx){

	if($("div[name=nameDetail"+rowIdx+"_"+idx+"]").css("display") == "none") $("div[name=nameDetail"+rowIdx+"_"+idx+"]").show();
	else $("div[name=nameDetail"+rowIdx+"_"+idx+"]").hide();
}

function chgProgressInput(){

	var val = $("input[name='baseProgressYn']:checked").val();
	if(val == "Y"){
		$("#progressRateInputArea").hide();
	}else{
		$("#progressRateInputArea").show();
	}
}
</script>