<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var myModal = new AXModal();		// instance
var myModal2 = new AXModal();		// instance

var optionStr = "";
var optionCompanyStr = "";

var now = new Date().yyyymmdd();

$(document).ready(function(){

	optionStr = $("#approveBookMarkArea").html();
	optionCompanyStr = $("#approveCompanyArea").html();

	//Drag & Drop
	setSortable();

	//ACTIVITY SETTING
	doSearchActivity();

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
			doSearch();
		}
        ,contentDivClass: "popup_outline"

	});
	//-------------------------- 모달창 :E -------------------------

	//-------------------------- 모달창 :S -------------------------
   	myModal.setConfig({
   		windowID:"myModalCT",

   		width:740,
           mediaQuery: {
               mx:{min:0, max:767}, dx:{min:767}
           },
   		displayLoading:true,
           scrollLock: false,
   		onclose: function(){

   		}
           ,contentDivClass: "popup_outline"

   	});
    //-------------------------- 모달창 :E -------------------------


});

//Drag & Drop
function setSortable(){
	var receivChk = false;
	//DRAG & DROP
	$( "#sortable_task" ).sortable({
      placeholder: "ui-state-highlight",
      start: function (event, ui) {
			 var targetId = ui.item.context.id;

			 ui.placeholder.height(ui.item.height());
	  },
      update: function (event, ui) {
    	var productOrder = $(this).sortable('toArray');
		var projectIdArr = "";
    	for(var i = 0 ;i<productOrder.length;i++){

    		if(i>0) projectIdArr+= ",";

    		var projectId = productOrder[i].split("_")[1];

    		projectIdArr+=projectId;
    	}
    	var url = contextRoot + "/project/processProjectUserRank.do";

    	var param = {
    			projectIdArr:projectIdArr,
    			searchPeriodYn:$("#searchPeriodYn").val()

    		}

    	var callback = function(result){
    		doSearch();
    	}
    	commonAjax("POST", url, param, callback, false);
      },
      opacity: 0.7

    });
	$( "#sortable_task" ).disableSelection();
}
//검색영역 연도 선택
function selectYear(){
	var url =contextRoot + "/project/getProjectMyWorkListDayListAjax.do";
	var param = {
			searchYear		: $("#searchYear").val(),
			searchMonth		: $("#searchMonth").val(),
			searchDate		: $("#searchDate").val(),
  	};

  	var callback = function(result){
		$("#dayArea").html(result);
	};
	commonAjax("POST", url, param, callback, false);

	doSearch();
}

//검색영역 월 선택
function selectMonth(){
	var month = $("#searchMonth").val();

	var day = $("#searchDate").val();

	$("#searchDate").html($("#dayOption_"+month).html());

	doSearch();
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

	doSearch();
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

//검색
function doSearch(){

	var url = contextRoot + "/project/projectMyWorkListAjax.do";
	$("#frm").attr("action",url);
	var callback = function(data){
		$("#listArea").html(data);
		//Drag & Drop
		setSortable();
		doSearchActivity();

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
				doSearch();
			}
	        ,contentDivClass: "popup_outline"

		});
		//-------------------------- 모달창 :E -------------------------

		//-------------------------- 모달창 :S -------------------------
	   	myModal.setConfig({
	   		windowID:"myModalCT",

	   		width:740,
	           mediaQuery: {
	               mx:{min:0, max:767}, dx:{min:767}
	           },
	   		displayLoading:true,
	           scrollLock: false,
	   		onclose: function(){

	   		}
	           ,contentDivClass: "popup_outline"

	   	});
	    //-------------------------- 모달창 :E -------------------------
	}
	commonAjaxSubmit("POST",$("#frm"),callback,true);
}

//Activity 검색
function doSearchActivity(){

	if($("#frm input[name='projectId']").length==0){
		return;
	}
	var url = contextRoot + "/project/getProjectMyWorkActivityAjax.do";

	$("#frm").attr("action",url);

	var year = $("#searchYear").val();
	var month = $("#searchMonth").val();
	var date = $("#searchDate").val();

	var selDate = year+"-"+(month<10?"0":"")+month+"-"+(date<10?"0":"")+date;
	$("#searchDt").val(selDate);

	var callback = function(result){

		var list = result.resultObject.projectMyWorkActivityList;

		var today = result.resultObject.today;

		var tomorrow = result.resultObject.tomorrow;
		if(list!=null&&list.length>0){
			for(var i = 0 ; i < list.length ; i++){

				var data = list[i];

				var $targetObj = $("#activityDtTable_"+data.projectId+" tbody");

				var memoPrivateCnt = parseInt(data.memoPrivateCnt);
				var memoTeamChk = parseInt(data.memoTeamChk);
				var scheCnt = parseInt(data.scheCnt);
				var apprBasicCnt = parseInt(data.apprBasicCnt);
				var apprCompanyCnt = parseInt(data.apprCompanyCnt);

				var totCnt = memoPrivateCnt+memoTeamChk+scheCnt+apprBasicCnt+apprCompanyCnt;
				var activityThCss = "";

				if($("#capSearch_"+data.projectId).length>0){
					activityThCss = "background:rgb(253, 255, 238)!important;";
				}

				var stStr = "<tr><th style='"+activityThCss+"'>";
					stStr+= data.name+" <em>("+totCnt+")</em>";

				var startDate = data.startDate;
				var endDate = data.endDate;

				if(endDate == today) stStr+=" <em>오늘종료</em>";
				else if(endDate == tomorrow) stStr+=" <em>내일종료</em>";

				stStr += "</th><td>";
				stStr += "<button type=\"button\" class=\"btn_addworkdairy2 btn_auth\"";
				stStr += " onclick='createWork("+data.projectId+","+data.activityId+")'><em>업무등록</em> </button> ";
				stStr += "<strong class=\"f_redPoint\"> ("+(memoPrivateCnt+memoTeamChk)+")</strong>";

				stStr += "<button type=\"button\" class=\"btn_addworkdairy3 btn_auth mgl10\"";
				stStr += " onclick='createSche("+data.projectId+","+data.activityId+")'><em>일정등록</em> </button> ";
				stStr += "<strong class=\"f_redPoint\">("+scheCnt+")</strong>";

				stStr += "<td><select id = \"approveBasicSelect_"+data.activityId+"\" class=\"select_b approveSelect\" onchange = \"createApprove($(this),'BASIC',"+data.projectId+","+data.activityId+",'"+data.projectName+"','"+data.startDate+"','"+data.endDate+"','"+data.expense+"')\">";
				stStr += optionStr;
				stStr += "</select> "
				stStr += "<span class=\"f_blackPoint\">("+apprBasicCnt+")</span>";

				stStr += "<select id = \"approveCompanySelect_"+data.activityId+"\" class=\"select_b mgl10 approveSelect\" onchange = \"createApprove($(this),'COMPANY',"+data.projectId+","+data.activityId+",'"+data.projectName+"','"+data.startDate+"','"+data.endDate+"','"+data.expense+"')\">";
				stStr += optionCompanyStr;
				stStr += "</select> "
				stStr += "<span class=\"f_blackPoint\">("+apprCompanyCnt+")</span></td>";

				stStr += "<td class=\"special_f_st2\">"+startDate+" ~ "+endDate+"</td>";

				stStr += "<td>";

				if(data.leaderYn=="Y"){
					stStr += "<a href=\"javascript:modifyActivity("+data.projectId+","+data.activityId+",'"+data.startDate+"','"+data.endDate+"')\" class=\"s_gray01_btn\">";
					stStr += "<em>수정</em></a>"
				}

				stStr += "</td></tr>";

				$targetObj.append(stStr);

				var endDate = data.endDate;
				var startDate = data.startDate;

				var endDateBuf =  endDate.split("-").join("");
				var startDateBuf = startDate.split("-").join("");

				var year = $("#searchYear").val();
				var month = $("#searchMonth").val();
				var date = $("#searchDate").val();

				var selDate = year+""+(month<10?"0":"")+month+""+(date<10?"0":"")+date;


				if(data.expense == "N"){
					$("#approveBasicSelect_"+data.activityId).find("option").each(function(){
						if($(this).attr("realAppvDocClass") == "EXPENSE" ||$(this).attr("realAppvDocClass") == "PURCHASE"){
							$(this).remove();
						}
					});
				}else{

					if(parseInt(now)>parseInt(endDateBuf)||parseInt(now)<parseInt(startDateBuf)||parseInt(selDate)>parseInt(endDateBuf)||parseInt(selDate)<parseInt(startDateBuf)){
						$("#approveBasicSelect_"+data.activityId).find("option").each(function(){
							if($(this).attr("realappvdocclass") == "EXPENSE" ||$(this).attr("realappvdocclass") == "PURCHASE"){
								$(this).remove();
							}
						});
					}
				}

				if(parseInt(now)>parseInt(endDateBuf)||parseInt(selDate)>parseInt(endDateBuf)||parseInt(selDate)<parseInt(startDateBuf)){
					$("#approveCompanySelect_"+data.activityId).find("option").each(function(){
						var projectType = $(this).attr("projecttype");
						if(projectType == "ING"){
							$(this).remove();
						}
					});
				}
			}
		}
	}
	commonAjaxSubmit("POST",$("#frm"),callback,true);
}

//전자결재 작성 팝업
function createApprove($obj,type,projectId,activityId,projectName,startDate,endDate,expense){
	var appvDocClass = $obj.find("option:selected").attr("appvdocclass");
	var appvCompanyId = $obj.find("option:selected").attr("appvcompanyid");
	var appvDocId = $obj.find("option:selected").attr("appvdocid");

	var realAppvDocClass = $obj.find("option:selected").attr("realAppvDocClass");
	var projectType = $obj.find("option:selected").attr("projecttype");

	var year = $("#searchYear").val();
	var month = $("#searchMonth").val();
	var date = $("#searchDate").val();

	var selDate = year+"-"+(month<10?"0":"")+month+"-"+(date<10?"0":"")+date;

	var url = "";
	if(appvDocId>0){
		url = contextRoot+"/approve/approveBookmarkForm.do";
	}else if(appvCompanyId==null||appvCompanyId == ""){
		switch(appvDocClass){
		case 'BASIC':
			url = contextRoot+"/approve/reqBasic.do";
			break;
		case 'REPORT':
			url = contextRoot+"/approve/reqReport.do";
			break;
		case 'EXPENSE':
			url=contextRoot+"/approve/reqExpense.do";
			break;
		case 'PURCHASE':
			url=contextRoot+"/approve/reqPurchase.do";
			break;
		case 'EDUCATION':
			url=contextRoot+"/approve/reqEdu.do";
			break;
		case 'TRIP':
			url=contextRoot+"/approve/reqTrip.do";
			break;
		}
	}else{
		url=contextRoot + "/approve/reqCompany.do";
	}
	var popYn = "M";
	$("#approveFrm #appvDocId").val(appvDocId);
	$("#approveFrm #appvDocClass").val(appvDocClass);
	$("#approveFrm #appvCompanyFormId").val(appvCompanyId);
	$("#approveFrm #popYn").val(popYn);
	$("#approveFrm #selDate").val(selDate);
	$("#approveFrm #projectId").val(projectId);
	$("#approveFrm #activityId").val(activityId);
	$("#approveFrm #projectName").val(projectName);

	var option = "width=1100px,height=800px,resizable=yes,scrollbars = yes";
    commonPopupOpen("approveDetailPop",url,option,$("#approveFrm"));
    $(".approveSelect").val("");
}


//이전이후날짜로
function selectDay(type){

	var year = $("#searchYear").val();
	var month = $("#searchMonth").val();
	var date = $("#searchDate").val();

	var selDate = new Date(year+"-"+month+"-"+date);

	if(type == "PREV"){
		selDate = new Date(Date.parse(selDate) - 1 * 1000 * 60 * 60 * 24);
		//selDate = addDate(-1,selDate);
	}else if(type == "NEXT"){
		selDate = new Date(Date.parse(selDate) + 1 * 1000 * 60 * 60 * 24);
		//selDate = addDate(1,selDate);
	}

	var selYear = selDate.getFullYear();
	var selMonth = selDate.getMonth()+1;
	var selDate = selDate.getDate();

	if(parseInt(year) != parseInt(selYear)){
		$("#searchYear").val(selYear);

		var url =contextRoot + "/project/getProjectMyWorkListDayListAjax.do";
		var param = {
				searchYear		: $("#searchYear").val(),
				searchMonth		: $("#searchMonth").val(),
				searchDate		: $("#searchDate").val(),
	  	};

	  	var callback = function(result){
			$("#dayArea").html(result);
		};
		commonAjax("POST", url, param, callback, false);
	}

	var monthTxt = ""+selMonth;

	$("#searchMonth").val(monthTxt);

	var month = $("#searchMonth").val();

	var day = $("#searchDate").val();

	$("#searchDate").html($("#dayOption_"+month).html());

	var dateTxt = ""+selDate;
	$("#searchDate").val(dateTxt);

	doSearch();
}

//페이지이동
function movePage(type){
	var url = "";

	if(type == "WORK"){
		var year = $("#searchYear").val();
		var month = $("#searchMonth").val();
		var date = $("#searchDate").val();

		var selDate = new Date(year+"-"+month+"-"+date);
		url = contextRoot + "/work/getDailyWork.do?selectDate="+selDate.yyyy_mm_dd();
	}else if(type == "APPROVE"){
		url = contextRoot + "/approve/draftDocList.do";
	}

	var newWin = window.open("about:blank","myWbsMovePop");
	$("#moveForm").attr("target","myWbsMovePop");

	$("#moveForm").attr("action",url).submit();
}

//업무등록팝업
function createWork(projectId,activityId){
	var year = $("#searchYear").val();
	var month = $("#searchMonth").val();
	var date = $("#searchDate").val();

	var selDate = new Date(year+"-"+(month<10?"0":"")+month+"-"+(date<10?"0":"")+date);
	var param = {
			 listId 	: 0,
			 workUserId	: "${baseUserLoginInfo.userId}",
			 workDate	: selDate.yyyy_mm_dd(),
			 projectId	: projectId,
			 activityId : activityId
   	};

	$("#projectInfoPopArea").empty();

	fnObj = {
			doSearch : function(){
				doSearch();
			},
		    viewWorkDaily : function(listId,workType,viewDate,openType){
		    	doSearch();
		    }
	}

	var url =contextRoot+"/work/workDailyRegPopup/pop.do";

   	myModal.open({
   		url: url,
   		pars: param,
   		titleBarText: '업무일지 '+'등록',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
   		method:"POST",
   		top: $(document).scrollTop()+150,
   		width: 750,
   		closeByEscKey: true				//esc 키로 닫기
	});

	$('#myModalCT').draggable();
}

//일정등록팝업
function createSche(projectId,activityId){
	var year = $("#searchYear").val();
	var month = $("#searchMonth").val();
	var date = $("#searchDate").val();
	var selDate = new Date(year+"-"+(month<10?"0":"")+month+"-"+(date<10?"0":"")+date);
	var url = "<c:url value='/scheduleProc.do'/>" + "?cmd=${vo.cmd}&EventType=Add&ParentPage=Cal&ScheSDate="+selDate.yyyy_mm_dd()+"&projectId="+projectId+"&activityId="+activityId;
    window.open(url, 'scheduleProc','resizable=no,width=780,height=700,scrollbars=yes');
}

//업무등록팝업 등록후 리턴
var fnObj;

//일정등록팝업 등록후 리턴
function openPageReload(){
	doSearch();
}
var project;
var activity;
//엑티비티수정팝업
function modifyActivity(projectId,activityId,startDate,endDate){

	var url =contextRoot + "/project/projectInfoViewPop.do";


 	 var param = {
 			 pid		 	: projectId,
 			 projectId 		: projectId
 	 };

 	 var callback = function(result){

 		 $("#projectInfoPopArea").html(result);

 		project = fnObj.getProject();
 		activity = fnObj.getActList();

 		var popTitle = "${baseUserLoginInfo.activityTitle}";

 		var url = "<c:url value='/project/updateActivityInfo.do'/>";
 		popTitle+=" 수정";
 		width = 800;

 		var year =  new Date().getFullYear();
 		var endYear = endDate.split("-")[0];

 		if(endYear !="9999"){
 			if(endYear<year){
 				year = endYear;
 			}
 		}
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

				doSearch();

			}
	        ,contentDivClass: "popup_outline"

		});
		//-------------------------- 모달창 :E -------------------------
 		 params = {
 					activityId:activityId,
 					startDate:startDate,
 					endDate:endDate,
 					year:$("#searchYear").val()
 				 };
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
	};

	commonAjax("POST", url, param, callback, false);


}
</script>