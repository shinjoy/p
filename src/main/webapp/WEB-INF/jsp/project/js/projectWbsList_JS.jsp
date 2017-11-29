<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
var myModal = new AXModal();		// instance

var wbsProcessCss = new Object();
$(document).ready(function(){
	//선로딩코드
	preloadCode();
});

//선로딩코드
function preloadCode(){
	var colorObj = {};
    var comCodeProjectType = getBaseCommonCode('PROJECT_TYPE', null, 'CD', 'NM', '', '전체','', { orgId : "${baseUserLoginInfo.applyOrgId}" });
    var projectTypeTag = createSelectTag('projectType', comCodeProjectType, 'CD', 'NM', '', "doSearch(0)", colorObj, '', 'select_b');
    $("#projectTypeArea").html(projectTypeTag);

    var comCodeProjectStatus = getBaseCommonCode('PROJECT_STATUS', null, 'CD', 'NM', '', '전체','', { orgId : "${baseUserLoginInfo.applyOrgId}" });
    var projectStatusTag = createSelectTag('projectStatus', comCodeProjectStatus, 'CD', 'NM', '', "doSearch(0)", colorObj, '', 'select_b');
    $("#projectStatusArea").html(projectStatusTag);
}

//프로젝트 상세조회
function showProjectDetailPop(projectId){
	var url =contextRoot + "/project/projectInfoViewPop.do";
	$("#my-modal-div").css("");

  	 var param = {
  			 pid		 	: projectId,
  			 projectId 		: projectId
  	 };

  	 var callback = function(result){
  		 $("#my-modal-div").css("");
  		 $("#projectInfoPopArea").html(result);
  		 showProjectDetailPop2();
	};

	commonAjax("POST", url, param, callback, false);
}

//프로젝트 디테일 팝업
function showProjectDetailPop2(){
	myModal.openDiv({
		modalID: "my-modal-div",
		targetID: "compnay_dinfo2",
		width:1200,
		closeByEscKey:true
	});
	$(".popHeader").hide();
	$("#my-modal-div_close").hide();
	$('#my-modal-div').draggable();

}
function setPageSearchInfo(){

}

//더보기
function doSearch(pageNo){
	$("#btnAllViewList").remove();

	$("#pageIndex").val(parseInt(pageNo)+1);

	var url = contextRoot + "/project/projectWbsListAjax.do";

	$("#frm").attr("action",url);

	var callback = function(data){
		if(pageNo >0){
			$("#projectWbsListArea").append(data);
		}else{
			$("#projectWbsListArea").html(data);
		}
	}
	commonAjaxSubmit("POST",$("#frm"),callback);

}
//검색박스 초기화
function clearSearchBox(){
	$("#searchBox").find("select").val("");

	$("#nearClose").prop("checked",false);

	$("#searchTxt").val("");

	$("#searchChkArea").find("input").prop("checked",false);

	$("#projectStatus").val("PROGRESS");
	$("#searchprojectViewer").val("N");
	$("#searchuseYn").val("N");

	//개인,전체버튼
	$("#btnEmployee").addClass("on");
	$("#employee").val("");
	$("#btnEmployee").text("개인");
}
//탭이동
function moveTab(type){

	$("#tabArea li").removeClass();

	$("#tab_"+type).addClass("current");


	if(type == "NOPERIOD"){
		$("#searchPeriodYn").val("N");
	}else{
		$("#searchPeriodYn").val("Y");
	}

	clearSearchBox();

	doSearch(0);
}
//검색 체크박스
function searchChkBox(type){
	if(type != "disableProject"){
		if($("#"+type).prop("checked"))
			$("#search"+type).val("Y");
		else
			$("#search"+type).val("N");
	}else{
		if($("#disableProject").prop("checked"))
			$("#projectStatus").val("ADDDISABLED");
		else
			$("#projectStatus").val("PROGRESS");
	}

	doSearch(0);
}
//엑티비티 상세를본다
function viewActivityDt(projectId,thisYear){
	if($("#toggleDtImageArea_"+projectId).hasClass("on")){
		$("#toggleDtImageArea_"+projectId).removeClass("on");
		$("#toggleDtImageArea_"+projectId).find("img").attr("src","${pageContext.request.contextPath}/images/support_w/th_icon_closed.gif");
		$("#activityDtTr_"+projectId).empty();


	}else{
		$("#toggleDtImageArea_"+projectId).addClass("on");
		$("#toggleDtImageArea_"+projectId).find("img").attr("src","${pageContext.request.contextPath}/images/support_w/th_icon_open.gif");
		$("#activityDtTr_"+projectId).empty();

		viewAjaxActivityDt(projectId,thisYear);
	}
}

//엑티비티 상세조회
function viewAjaxActivityDt(projectId,thisYear){
	var url = "<c:url value='/project/getProjectWbsActivityDtAjax.do'/>";

	 params = {
			 	projectId:projectId,
			 	thisYear:thisYear,
			 	searchNoUseYn:$("#searchnouseYn").val(),
			 	searchProjectViewer:$("#searchprojectViewer").val()
			 };
	 var callback = function(result){
		 $("#activityDtTr_"+projectId).html(result);
	 }
	 commonAjax("POST", url, params, callback,true);

}

//엑티비티 유저 상세를본다
function viewActivityUserDt(activityId){
	if($("#toggleActivityDtImageArea_"+activityId).hasClass("on")){
		$("#toggleActivityDtImageArea_"+activityId).removeClass("on");
		$("#toggleActivityDtImageArea_"+activityId).find("img").attr("src","${pageContext.request.contextPath}/images/support_w/th_icon_closed.gif");


		//$("#activityDtTr_"+activityId).empty();

		$(".activityDtUserArea_"+activityId).toggle();
	}else{
		$("#toggleActivityDtImageArea_"+activityId).addClass("on");
		$("#toggleActivityDtImageArea_"+activityId).find("img").attr("src","${pageContext.request.contextPath}/images/support_w/th_icon_open.gif");
		//$("#activityDtTr_"+projectId).empty();
		$(".activityDtUserArea_"+activityId).toggle();
	}
}

//wbs 엑티비티 상세영역에서 주차별/직원별 업무일지를 조회한다.
function searchActivityWbsWorkDetail(projectId,activityId , year,startDate,endDate,startWeekNum,endWeekNum,activityName){

	var url =contextRoot + "/project/projectInfoViewPop.do";

	 var param = {
			 pid		 	: projectId,
			 projectId 		: projectId
	 };

	var callback = function(result){
 		$("#projectInfoPopArea").html(result);

 		var project = fnObj.getProject();
 		var actList = fnObj.getActList();

 		var activityObj;
		for(var i = 0 ; i<actList.length; i++){
			if(parseInt(actList[i].activityId) == parseInt(activityId)){
				activityObj = actList[i];
				var empList = activityObj.empList;
				for(var j = 0 ; j <empList.length;j++){
					var empObj = empList[j];
					var copyHtml = $("#activityDtTotArea_"+activityId).html();

					var stStr = "<tr id = 'activityDtUserArea_"+activityId+"_"+empObj.userId+"' class='activityDtUserArea_"+activityId+"' style='display:none;'>";
					var nameStr = empObj.userNm;

					if(empObj.leaderYn=="Y"){
						nameStr += "<br>[리더]";
					}
					//copyHtml=copyHtml.split(activityName).join(nameStr);
					copyHtml=copyHtml.split("##userId##").join(empObj.userId);
					copyHtml=copyHtml.split("##userNm##").join(empObj.userNm);
					copyHtml=copyHtml.split("##rankNm##").join(empObj.position);


					copyHtml=copyHtml.split("activityDtTotAreaNm").join("activityDtUserAreaNm_"+activityId+"_"+empObj.userId);
					copyHtml=copyHtml.split("activityDtTotArea").join("activityDtUserArea_"+activityId+"_"+empObj.userId);
					//copyHtml=copyHtml.split("activityDtTotAreaTot").join("activityUserTotAreaTot_"+activityId+"_"+empObj.userId);

					stStr = stStr + copyHtml + "</tr>";

					$("#activityDtTable_"+activityId+" tbody").append(stStr);

					var stStr = "<tr id = 'activityDtUserArea_"+activityId+"_"+empObj.userId+"'>";
					var nameStr = "";

					if(empObj.leaderYn=="Y"){
						nameStr += ""+ '<span class="task_leader" onmouseover="openLeaderHelpPop($(this))"  onmouseout="closeLeaderHelpPop()"></span>'
					}

					nameStr += empObj.userNm;
					copyHtml=copyHtml.split("activityDtTotAreaTot").join("activityUserTotAreaTot_"+activityId+"_"+empObj.userId);

					nameStr+='<span id = "activityUserTotAreaTot_'+activityId+'_'+empObj.userId+'"></span>';

					$("#activityDtTable_"+activityId+" tbody").find(".name:last").html(nameStr);


					//copyHtml=copyHtml.split(activityName).join(nameStr);

				}

				$("#activityDtTable_"+activityId+" tbody").find(".endDate").each(function(i){
					if(i>0) $(this).remove();
				});
				$("#activityDtTable_"+activityId+" tbody").find(".startDate").each(function(i){
					if(i>0) $(this).remove();
				});
			}
		}


		var url = contextRoot + "/project/searchActivityWbsWorkDetailAjax.do";
		var param = {
				activityId 	: activityId,
				year  : year,
				startDate:startDate,
				endDate:endDate

			}
		var callback = function(result){

			var obj = JSON.parse(result);

			var wbsWorkSearchList = obj.resultObject.wbsWorkSearchList;

			var cnt = 0;
			var totCnt = 0;

			var compareUsreId = 0;

			if(wbsWorkSearchList!=null){
				for(var i = 0 ; i <wbsWorkSearchList.length;i++){
					var workObj = wbsWorkSearchList[i];

					var month = parseInt(workObj.month);
					var weekNum = workObj.weeknum;

					var userId = workObj.empId;
					var $targetObj = $("#activityDtTable_"+activityId+" #activityDtUserArea_"+activityId+"_"+userId+"_"+month+"_"+weekNum).find(".acti_RgList");

					if($targetObj.length == 0){
						activityObj = workObj.activityId;
						var copyHtml = $("#activityDtTotArea_"+activityId).html();
						var stStr = "<tr id = 'activityDtUserArea_"+activityId+"_"+userId+"' class='activityDtUserArea_"+activityId+"' style='display:none;'>";

						//copyHtml=copyHtml.split("##userId##").join(userId);
						//copyHtml=copyHtml.split("##userNm##").join(nameStr);
						//copyHtml=copyHtml.split("##rankNm##").join(workObj.userRankNm);

						copyHtml=copyHtml.split("activityDtTotAreaNm").join("activityDtUserAreaNm_"+activityId+"_"+userId);
						copyHtml=copyHtml.split("activityDtTotArea").join("activityDtUserArea_"+activityId+"_"+userId);
						copyHtml=copyHtml.split("activityDtTotAreaTot").join("activityUserTotAreaTot_"+activityId+"_"+userId);

						stStr = stStr + copyHtml + "</tr>";

						$("#activityDtTable_"+activityId+" tbody").append(stStr);
						var nameStr = workObj.name;
						nameStr +='<span id = "activityUserTotAreaTot_'+activityId+'_'+userId+'"></span>';

						$("#activityDtTable_"+activityId+" tbody").find(".name:last").html(nameStr);

						$("#activityDtTable_"+activityId+" tbody").find(".endDate").each(function(i){
							if(i>0) $(this).remove();
						});
						$("#activityDtTable_"+activityId+" tbody").find(".startDate").each(function(i){
							if(i>0) $(this).remove();
						});

						$targetObj = $("#activityDtTable_"+activityId+" #activityDtUserArea_"+activityId+"_"+userId+"_"+month+"_"+weekNum).find(".acti_RgList");


					}
					var cssStr = "";

					if(workObj.complete=="Y"){
						cssStr = "done_rg";

						$targetObj.find(".done_rg").remove();
					}else{
						cssStr = wbsProcessCss[workObj.progress];
					}

					var stStr = "<li class='"+cssStr+"'></li>";

					$targetObj.find(".no_acti_rg,.delay_rg").remove();
					$targetObj.append(stStr);

					var liLength = $targetObj.find("li").length;

					$targetObj.removeClass();

					$targetObj.addClass("n"+liLength);
					$targetObj.addClass("acti_RgList");
					cnt +=  workObj.cnt;
					if(wbsWorkSearchList.length == i+1 || workObj.empId != wbsWorkSearchList[i+1].empId){

						$("#activityUserTotAreaTot_"+activityId+"_"+workObj.empId).text("("+cnt+")");
						cnt = 0;
					}
					totCnt +=  workObj.cnt;
				}
			}
			$("#activityDtTotArea_"+activityId).find("#activityDtTotAreaTot").text("("+totCnt+")");

			var wbsWorkActivityTotMap = obj.resultObject.wbsWorkActivityTotMap;

			var progressRate = wbsWorkActivityTotMap.progressRate;

			if(progressRate == 0){
				var $targetObj = $("#activityDtTable_"+activityId).find(".startDate");

				if($targetObj.length == 0){
					$targetObj = $("#activityDtTable_"+activityId).find(".start");
				}else{
					$targetObj = $targetObj.parent();
				}

				$targetObj.find(".acti_RgList li").eq(0).html("<span class=\"num\">"+progressRate+"%</span>");
			}else{
				var totCnt = $("#activityDtTotArea_"+activityId).find(".acti_RgList").has("li").length;
				try{
				totCnt = parseFloat(totCnt);
				progressRate = parseFloat(progressRate);
				}catch(e){
				}

				var comCnt = parseInt(totCnt*(progressRate/100));

				if(comCnt == 0) comCnt = 1;


				$("#activityDtTotArea_"+activityId).find(".acti_RgList").has("li").each(function(i){
					$(this).empty();

					var stStr = "";
					if(i==0){
						try{
						progressRate=progressRate.toFixed(0);
						}catch(e){

						}
					}

					if(i+1 == comCnt){
						stStr+="<span class=\"num\">"+progressRate+"%</span>"
					}

					$(this).append("<li class=\"done_rg\">"+stStr+"</li>");

					if(i+1 == comCnt){
						return false;
					}
				});
			}

		}

		commonAjax("POST", url, param, callback, false);
	}
	commonAjax("POST", url, param, callback, false);
}
function openLeaderHelpPop($obj){
	$("#leaderHelpPop").show();
	$("#leaderHelpPopTooltipBox").show();
	var obj = $obj.offset();

    $("#leaderHelpPop").css("top",obj.top-150).css("left",obj.left-225).css("position","absolute").css("z-index","9999999");
}
function closeLeaderHelpPop(){
	$("#leaderHelpPop").hide();
	$("#leaderHelpPopTooltipBox").hide();
}

function openHelpPop($obj){
	$("#helpPop").show();
	$("#helpPopTooltipBox").show();
	var obj = $obj.offset();

    $("#helpPop").css("top",obj.top-150).css("left",obj.left-240).css("position","absolute").css("z-index","9999999");
}

function closeHelpPop(){
	$("#helpPop").hide();
	$("#helpPopTooltipBox").hide();
}

function searchEmployee(){

	if($("#btnEmployee").hasClass("on")){
		$("#superAllChkYn").val("N");
		$("#btnEmployee").removeClass("on");
		/* $("#employee").val("Y"); */
		$("#btnEmployee").text("전체");

		doSearch(0);
	}else{
		$("#btnEmployee").addClass("on");
		$("#superAllChkYn").val("Y");
		/* $("#employee").val(""); */
		$("#btnEmployee").text("개인");
		doSearch(0);
	}
}
</script>