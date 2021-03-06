<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi?autoload= {'modules':[{'name':'visualization','version':'1.1','packages': ['corechart']}]}"></script>
<script type="text/javascript" src="https://www.google.com/jsapi?autoload= {'modules':[{'name':'visualization','version':'1.1','packages': ['bar']}]}"></script>
<script type="text/javascript">
/* google.charts.load('current', {'packages':['bar']});
google.charts.load('current', {'packages':['corechart']}); */
google.load("visualization", "1", {packages: ["corechart"]});
google.load("visualization", "1", {packages: ["bar"]});
/*=========================================== Global variables : S ===========================================*/
var g_userId = '${userId}';
var g_deptId = '${deptId}';
var g_deptLevel = '${deptLevel}';
var g_deptMngrYn = '${deptMngrYn}';
var g_vipAuthYn = '${vipAuthYn}';
var g_viewAuth = '${viewAuth}';
//화면로딩후
var resizeId;
/*=========================================== Global variables : E ===========================================*/

$(document).ready(function(){
	preloadCode(); // 선로딩코드
  	pageStart();   // 달력세팅
  	//-- 트리검색 : 전체(A, 0), 부서(D, 부서ID), 유저(U, 유저ID)
	//-- //ALL:프로젝트/부서 보임 / DEPT:부서만 보임 PROJECT:프로젝트만보임 //doSearch:받을 펑션
  	selectProjectDeptTreeTab("ALL", getDept, getProject, "PROJECT", "0");
});

var g_pieChartOptions = {
        title: '',
        sliceVisibilityThreshold:0,
        pieHole: 0.3,
        pieSliceTextStyle: {
            color: 'black',
          },
        /* chartArea:{left:0,top:0,width:'100%',height:'90%'}, */
        chartArea:{width:'100%',height:'95%'},
        width: 320,
        height: 300,

        legend: {position: 'right'},
    /*     backgroundColor:'yellow', */
};

var g_barChartOptions = {
        chart: {
               title: '',
               subtitle: '',
               },
         bars: 'horizontal', // Required for deptCompareBarChart Bar Charts.
         /* backgroundColor:'yellow', */
         chartArea:{left:10,top:10,right:10,bottom:10,width:'90%',height:'90%'},
};

/*=========================================== Global googleChart : S ===========================================*/
/*-------------------------------------------Dept:S------------------------------------------*/
//-- 구글 파이차트(프로젝트전체)
function projectPieChart(){
	var tempSave, expect, progress, pending, stop, closeReady, closed;
	var deptId = $("#deptId").val();
	var searchUserId  = $("#searchUserId").val();
	var url    = contextRoot+'/project/projectPieChartAjax.do';
	var param = {deptId:deptId,
		   		 searchUserId:searchUserId,
		   		applyOrgId : g_selectOrgId
		  }

	var callback = function(result){
        var obj = JSON.parse(result);
        var rObj = obj.resultObject;

     	// null보임처리
        if( rObj.cnt != 0 ){
			tempSave   = rObj.result.tempSaveRate;   // 임시저장
			expect     = rObj.result.expectRate;     // 예정
			progress   = rObj.result.progressRate;   // 진행
			pending    = rObj.result.pendingRate;    // 보류
			stop       = rObj.result.stopRate;       // 중단
			closeReady = rObj.result.closeReadyRate; // 마감대기
			closed     = rObj.result.closedRate;     // 마감
			var data = google.visualization.arrayToDataTable([
												            ['Task', 'Hours per Day'],
												            ['임시저장', tempSave],
												            ['예정', expect],
												            ['진행', progress],
												            ['보류', pending],
												            ['중단', stop],
												            ['마감대기', closeReady],
												            ['마감', closed]
												            ]);

				var chart = new google.visualization.PieChart(document.getElementById('projectPieChart'));
				chart.draw(data, g_pieChartOptions);
				/* $("#projectPieChart").css("width",380+"px");
				$("#projectPieChart").css("height",350+"px"); */
        }else if( rObj.cnt == 0 ){
			$("#projectPieChart").removeAttr( 'style' );
        }
    };
    commonAjax("POST", url, param, callback);
}

//-- 구글 파이차트(액티비티전체)
function activityPieChart(){
	var expect, progress, disable, closed;
	var deptId = $("#deptId").val();
	var searchUserId  = $("#searchUserId").val();
	var url = "";
	var gubun = "";

	url = contextRoot+'/project/activityPieChartAjax.do';

	var param  = {deptId:deptId,
	   		      searchUserId:searchUserId,
	   		   applyOrgId : g_selectOrgId
	   	}

	var callback = function(result){
        var obj = JSON.parse(result);
        var rObj = obj.resultObject;

     	// null보임처리
        if( rObj.cnt != 0 ){
	        expect   = rObj.result.expectRate;  // 예정
			progress = rObj.result.progressRate; // 진행
			disable  = rObj.result.disableRate;  // 사용안함
			closed   = rObj.result.closedRate;   // 마감

			var data = google.visualization.arrayToDataTable([
												            ['Task'  ,'Hours per Day'],
												            ['예정'   , expect],
												            ['진행'   , progress],
												            ['사용안함', disable],
												            ['마감'   , closed]
												            ]);

			var chart = new google.visualization.PieChart(document.getElementById('activityPieChart'));
			chart.draw(data, g_pieChartOptions);
        }else if( rObj.cnt == 0 ){
			$("#activityPieChart").removeAttr('style');
        }
	};
	commonAjax("POST", url, param, callback);
}

//-- 구글 파이차트(업무일지전체)
function officePieChart(){
	var workTeam, workPrivate;
	var deptId = $("#deptId").val();
	var searchUserId  = $("#searchUserId").val();
	var url    = contextRoot+'/project/officePieChartAjax.do';
	var param  = {deptId:deptId,
	   		      searchUserId:searchUserId,
	   		   applyOrgId : g_selectOrgId
	     }

	var callback = function(result){
		var obj = JSON.parse(result);
        var rObj = obj.resultObject;

        // null보임처리
        if( rObj.cnt != 0 ){

	        workTeam    = rObj.result.workTeamRate;    // 팀업무
			workPrivate = rObj.result.workPrivateRate; // 개인업무

			var data = google.visualization.arrayToDataTable([
												            ['Task' ,'Hours per Day'],
												            ['팀업무' , workTeam],
												            ['개인업무', workPrivate]
												            ]);

			var chart = new google.visualization.PieChart(document.getElementById('officePieChart'));
			chart.draw(data, g_pieChartOptions);
        }else if( rObj.cnt == 0 ){
        	$("#officePieChart").removeAttr('style');
        }
	};
	commonAjax("POST", url, param, callback);
}

//-- 구글 막대차트(부서비교)
function drawDeptCompareChart(){
	var projectAttendCnt, activityAttendCnt, workTeamCnt, workPrivateCnt, deptNm, deptIds;
	var deptData = ([['', '참여프로젝트', '참여액티비티', '팀업무', '개인업무']]);
	var deptId = $("#deptId").val();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var choiceyear = $("#choiceYear").val();

	if( choiceYear=='' ){
    	choiceYear = nowDate.substring(0,4);
  	}

  	var choiceDate = '';
	if( choiceMonth=='' ){
    	choiceDate = '';
	    if( startDate>endDate ){
	      	return false;
	    }
  	}else{
	    if( parseInt(choiceMonth)<10 && choiceMonth.length<2 ){
			choiceMonth = '0'+choiceMonth;
	    }
    	choiceDate = choiceYear+'-'+choiceMonth;
  	}

	var url    = contextRoot+'/project/deptCompareChartAjax.do';
	var param  = {deptId:deptId,
			   	  choiceDate:choiceDate,
                  startDate:startDate,
               	  endDate:endDate,
               	applyOrgId : g_selectOrgId
         }

	var callback = function(result){
		var obj = JSON.parse(result);
        var rObj = obj.resultObject;

        // null보임처리
        if( rObj.result.length !=0 ){

			for( var i=0; i<rObj.result.length; i++ ){
				projectAttendCnt  = rObj.result[i].projectAttendCnt;
				activityAttendCnt = rObj.result[i].activityAttendCnt;
				workTeamCnt       = rObj.result[i].workTeamCnt;
				workPrivateCnt    = rObj.result[i].workPrivateCnt;
				deptNm            = rObj.result[i].deptNm;

				deptData.push([ deptNm , projectAttendCnt, activityAttendCnt, workTeamCnt, workPrivateCnt ]);
			}

			var chartData = google.visualization.arrayToDataTable(deptData);

			var cssSize = 65;
			$("#deptCompareBarChart").height(cssSize * deptData.length);

			var chart = new google.charts.Bar(document.getElementById('deptCompareBarChart'));
			chart.draw(chartData, google.charts.Bar.convertOptions(g_barChartOptions));
        }
	};
	commonAjax("POST", url, param, callback);
}

/*-------------------------------------------Dept:E-------------------------------------------*/

/*-------------------------------------------Project:S----------------------------------------*/
// [액티비티 진행상태]
function projectActivityPieChart(){

	var expectStatusStr = $("th[name=expectStatus_").text(); // 진행상태(예정)
	var expectRateStr = $("td[name=expectRate_").text();     // 진행상태(예정)

	var progressStatusStr = $("th[name=progressStatus_").text(); // 진행상태(진행)
	var progressRateStr = $("td[name=progressRate_").text();     // 진행상태(진행)

	var disableStatusStr = $("th[name=disableStatus_").text(); // 진행상태(사용안함)
	var disableRateStr = $("td[name=disableRate_").text();     // 진행상태(사용안함)

	var closedStatusStr = $("th[name=closedStatus_").text(); // 진행상태(마감)
	var closedRateStr = $("td[name=closedRate_").text();     // 진행상태(마감)

	// 분기사용(이미지null 처리)
	var totCnt = parseFloat(expectRateStr)+parseFloat(progressRateStr)
				+parseFloat(disableRateStr)+parseFloat(closedRateStr);

	var expectData = [expectStatusStr, parseFloat(expectRateStr)];
	var progressData = [progressStatusStr, parseFloat(progressRateStr)];
	var disableData = [disableStatusStr, parseFloat(disableRateStr)];
	var closedData = [closedStatusStr, parseFloat(closedRateStr)];

	var workArray = new Array();

	var initData = ["Task","Hours per Day"];

	workArray.push(initData);
	workArray.push(expectData);
	workArray.push(progressData);
	workArray.push(disableData);
	workArray.push(closedData);

   	// null보임처리
   	if( totCnt == 100 ){
		var data = google.visualization.arrayToDataTable(workArray);

		var chart = new google.visualization.PieChart(document.getElementById('projectActivityPieChart'));
		chart.draw(data, g_pieChartOptions);
	}else if( totCnt == 0 ){
		$("#projectActivityPieChart").removeAttr('style');
	}
}

// [업무전체 진행상태]
function projectWorkTotalPieChart(){

	var workStr = $("td[name*=totalRate_").text();  // 업무전체 퍼센트
	var statusStr = $("th[name*=statusNm_").text(); // 상태

	var workSplit = workStr.split("%");

	var arr = [];

	var workArray = new Array();

	var initData = ["Task","Hours per Day"];

	workArray.push(initData);

	$("td[name*=totalRate_").each(function(i){
		if($(this).text() != "0.0%"){
			var rateStr = $(this).text();
	        var rate = rateStr.split("%").join("");
	        var rateKey = $(this).parent().find("th").text();
	        var arrayObj = [rateKey,parseFloat(rate)];

	        workArray.push(arrayObj);
		}
	});

   	// null보임처리
   	if( workArray.length != 1){
		var data = google.visualization.arrayToDataTable(workArray);

		var chart = new google.visualization.PieChart(document.getElementById('projectWorkTotalPieChart'));
		chart.draw(data, g_pieChartOptions);
	}else{
		$("#projectWorkTotalPieChart").removeAttr('style');
	}
}

// [팀업무/개인업무 비율]
function projectTeamPrivatePieChart(){

	// 카운트
    var workTeamCnt    = 0.0;
    var workPrivateCnt = 0.0;
    var totalCnt       = 0.0;
    // 백분율
    var teamSum     = 0.0;
    var privateSum  = 0.0;
    var totalSum    = 0.0;
    var teamRate    = 0.0;
    var privateRate = 0.0;
    var totalRate   = 0.0;
    var rate = "%";

    // 데이터 총계
    $("tr[name*='teamPrivateWork_']").each(function(){
        var thisName = $(this).attr("name");
        var indexId = thisName.split("_")[1];
        // 팀업무 카운트
        $("input[name=workTeamCnt_"+indexId+"]").each(function(){
            workTeamCnt=workTeamCnt+parseFloat($(this).val());
        });
        // 개인업무 카운트
        $("input[name=workPrivateCnt_"+indexId+"]").each(function(){
            workPrivateCnt=workPrivateCnt+parseFloat($(this).val());
        });
        // 업무전체 카운트
        $("input[name=totalCnt_"+indexId+"]").each(function(){
            totalCnt=totalCnt+parseFloat($(this).val());
        });
    });

    teamSum = workTeamCnt;
    privateSum = workPrivateCnt;
    totalSum = totalCnt;

    // 백분율
    $("tr[name*='teamPrivateWork_']").each(function(){
        var thisName = $(this).attr("name");
        var indexId = thisName.split("_")[1];

        if(teamSum == 0) teamRate = 0.0;
        else teamRate = $("input[name=workTeamRate_"+indexId+"]").val()/teamSum * 100;

        if(privateSum == 0) privateRate = 0.0;
        else privateRate = $("input[name=workPrivateRate_"+indexId+"]").val()/privateSum * 100;

        if(totalSum == 0) totalRate =0.0;
        else totalRate = $("input[name=totalRate_"+indexId+"]").val()/totalSum * 100;

        // 팀업무
        var teamRt = 0.0;
        if(workTeamCnt!=0.0)$("td[name=workTeamRate_"+indexId).text( teamRate.toFixed(1).concat(rate) );
        else $("td[name=workTeamRate_"+indexId).text( teamRt.toFixed(1).concat(rate) );

        // 개인
        var privateRt = 0.0;
        if(privateRate != 0.0)$("td[name=workPrivateRate_"+indexId).text( privateRate.toFixed(1).concat(rate) );
        else $("td[name=workPrivateRate_"+indexId).text( privateRt.toFixed(1).concat(rate) );

        // 업무전체
        $("td[name=totalRate_"+indexId).text( totalRate.toFixed(1).concat(rate) );
    });

    var hdSum = 0.0;
    var hdTeamRate = 0.0;

    hdSum = workTeamCnt + workPrivateCnt;
    var teamRate = workTeamCnt / hdSum * 100;       //팀Rate
    var privateRate = workPrivateCnt / hdSum * 100; //개인Rate

	var teamVal = 0.0;
    teamVal = teamRate;
	var priVal = 0.0;
	priVal = privateRate;

	if(isNaN(teamRate)) teamVal=0;
	if(isNaN(privateRate)) priVal=0;

	var teamRt = 0.0;
	teamRt = teamRate.toFixed(1);
	var privateRt = 0.0;
	privateRt = privateRate.toFixed(1);

   	// null보임처리
	if( teamVal!=0 || priVal!=0 ){

		var data = google.visualization.arrayToDataTable([
											            ['Task'  ,'Hours per Day'],
											            ['팀업무'  , teamRate],
											            ['개인업무' , privateRate]
											            ]);

		var chart = new google.visualization.PieChart(document.getElementById('projectTeamPrivatePieChart'));
		chart.draw(data, g_pieChartOptions);
	}else if( teamVal==0 && priVal==0 ){
		$("#projectTeamPrivatePieChart").removeAttr('style');
	}
}

// [팀업무 진행상태]
function projectTeamTotalPieChart(){

	var workStr = $("td[name*=workTeamRate_").text();  // 팀업무 퍼센트
	var statusStr = $("th[name*=statusNm_").text();    // 상태

	var workSplit = workStr.split("%");

	var arr = [];

	var workArray = new Array();

	var initData = ["Task","Hours per Day"];

	workArray.push(initData);

	var rate = 0.0;
	$("td[name*=workTeamRate_").each(function(i){

		var rateStr = $(this).text();

		rate = rateStr.split("%").join("");

		var rateKey = $(this).parent().find("th").text();

		var arrayObj = [rateKey,parseFloat(rate)];

		workArray.push(arrayObj);
	});
   	if( rate != 0){
		var data = google.visualization.arrayToDataTable(workArray);

		var chart = new google.visualization.PieChart(document.getElementById('projectTeamTotalPieChart'));
		chart.draw(data, g_pieChartOptions);
	}else if(rate==0){
		$("#projectTeamTotalPieChart").removeAttr('style');
	}
}

// [개인업무 진행상태]
function projectPrivateTotalPieChart(){

	var workStr = $("td[name*=workPrivateRate_").text();  // 팀업무 퍼센트
	var statusStr = $("th[name*=statusNm_").text();    // 상태

	var workSplit = workStr.split("%");

	var arr = [];

	var workArray = new Array();

	var initData = ["Task","Hours per Day"];

	workArray.push(initData);

	$("td[name*=workPrivateRate_").each(function(i){
		if($(this).text() != "0.0%"){
			var rateStr = $(this).text();
	        var rate = rateStr.split("%").join("");
	        var rateKey = $(this).parent().find("th").text();
	        var arrayObj = [rateKey,parseFloat(rate)];

	        workArray.push(arrayObj);
		}
	});

   	// null보임처리
   	if( workArray.length != 1){
		var data = google.visualization.arrayToDataTable(workArray);

		var chart = new google.visualization.PieChart(document.getElementById('projectPrivateTotalPieChart'));
		chart.draw(data, g_pieChartOptions);
	}else{
		$("#projectPrivateTotalPieChart").removeAttr('style');
	}
}

/*-------------------------------------------Project:E------------------------------------------*/

/*=========================================== Global googleChart : E ===========================================*/
//-- getProject: 리턴 함수
function getProject(projectId, projectName, employee){

	var kindType;
	// 프로젝트 전체 는 부서별 전체와 동일
	if( projectId == 0 ){
		// 프로젝트 건별 클릭 -> 부서별TOP Hide
        $("#searchArea").show(); // Middle(부서별)
        $("#bottomDept").show();   // Bottom(전체클릭)
        $("#bottomUsr").show();    // Bottom(부서및사용자)

        $("#deptId").val("");
        $("#projectId").val(projectId);
        $("#employee").val(employee);
        $("#projectName").val(projectName);

		$("#kindType").val("A")

	 	doSearchBottom();  // projectBottomArea
		doSearchTop();     // deptTop
	}else if( projectId != 0 ){
		// 프로젝트 건별 클릭 -> 부서별TOP Hide
		$("#searchArea").hide(); // Middle(부서별)
		$("#bottomDept").hide();   // Bottom(전체클릭)
		$("#bottomUsr").hide();    // Bottom(부서및사용자)

		$("#deptId").val("");
		$("#projectId").val(projectId);
		$("#employee").val(employee);
		$("#projectName").val(projectName);

		doSearchProjectTop();
	}
}

//-- getDept : 리턴 함수
function getDept(kindType, key){
	$("#kindType").val(kindType); // kindType

	//-- 부서
	if( kindType=="D" ){
		$("#searchUserId").val("");
		$("#deptId").val(key);
	//-- 유저
	}else if( kindType=="U" ){
		$("#deptId").val("");
		$("#searchUserId").val(key);
	//-- 전체
	}else if( kindType=="A" ){
		$("#searchUserId").val("");
		$("#deptId").val(key);
	}
 	doSearchBottom(); // projectBottomArea
 	doSearchTop();    // deptTopArea
}

//-- 부서/개인 /전체 Html설정 및 합계 분기처리
function getPrivateTeamActivityWork(kindType){

	if( kindType!="A" ){
	 	//-- 부서및개인 클릭 시, 프로젝트 셀병합
	 	var compareProjectId = 0;

	  	$("th[name*='compareProjectTr_']").each(function(){
	  		var thisName = $(this).attr("name");

	  		var projectId = thisName.split("_")[1];

	  		if( compareProjectId != projectId ){
	   			var cnt = $("th[name='"+$(this).attr("name")+"']").length;

	   			$(this).attr("rowspan", cnt+1); // rowspan '계' 추가
	   			compareProjectId = projectId;

	   			var workPrivateTotCnt = 0.0;
	   		 	var workTeamTotCnt = 0.0;
	   		 	var workPrivateTeamTotCnt = 0.0;
	   			// 개인업무
	   			$("input[name=workPrivateCnt_"+projectId+"]").each(function(){
	   				workPrivateTotCnt=workPrivateTotCnt+parseFloat($(this).val());
	   			});
	   			// 팀업무
	   			$("input[name=workTeamCnt_"+projectId+"]").each(function(){
	   				workTeamTotCnt=workTeamTotCnt+parseFloat($(this).val());
	   			});
	   			// 계(세로)
	   			$("input[name=workPrivateTeamTotCnt_"+projectId+"]").each(function(){
	   				workPrivateTeamTotCnt=workPrivateTeamTotCnt+parseFloat($(this).val());
	   			});

	   			var stStr = "";
	   			    stStr += "<tr class='sumrow'>";
	   			    stStr += "<td>계</td>";
	   				stStr += "<td>"+ workPrivateTotCnt.toFixed(1) +"</td>";
	   				stStr += "<td>"+ workTeamTotCnt.toFixed(1) +"</td>";
	   				stStr += "<td>"+ workPrivateTeamTotCnt.toFixed(1) +"</td></tr>";

	   			$("th[name='"+$(this).attr("name")+"']").eq(cnt-1).parent().after(stStr);

	  		}else{
	  			$(this).remove();
	  		}
	  	});
	// 전체
	}else{

	}
}

//-- 프로젝트액티비티 진행상태 /전체 Html설정 및 합계 분기처리
function getProjectTeamPrivateWork(){
	// 액티비티 진행상태
	projectActivityPieChart()
	// 팀업무/개인업무 비율 차트
	projectTeamPrivatePieChart();
	// 업무전체 진행상태
	projectWorkTotalPieChart();
	// 팀업무 진행상태
	projectTeamTotalPieChart();
	// 개인업무 진행상태
	projectPrivateTotalPieChart();
}

function preloadCode(){

	$("#bottomUsr").hide(); // 전체(default)이면 부서/개인 숨김

	setDatepicker('startDate');
  	setDatepicker('endDate');

  	yearSetting();  // 년도 셀렉트박스 세팅
  	monthSetting(); // 월 세팅
}

// datepicker 설정
function setDatepicker(obj){

	$('#'+obj).datepicker({
    	dateFormat: 'yy-mm-dd',
    	changeMonth: true,
    	changeYear: true,
    	showOn: "button",
    	yearRange: 'c-7:c+7',
     	monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'],      // 개월 텍스트 설정
      	monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
      	dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'], // 요일 텍스트 설정
      	dayNamesShort: ['일','월','화','수','목','금','토'],               // 요일 텍스트 축약 설정
      	dayNamesMin: ['일','월','화','수','목','금','토'],                 // 요일 최소 축약 텍스트 설정
      	showButtonPanel: false,
    	isRTL: false,
   		buttonText: ""
	});
}

// 년도 세팅
function yearSetting(){
	var nowDate= new Date().yyyy_mm_dd();
	var nowYear = nowDate.substring(0,4); // 현재 년도
	var pastYear = nowYear - 5;

  	var str ='<select id="choiceYear" class="select_b w_date" onchange="changeYear();">';

  	for( var i=pastYear; i<=parseInt(nowYear)+1; i++ ){
    	var chk = '';
    	if( nowYear==i ){
      		chk ='selected="selected"';
    	}
    	str += '<option value="'+ i+'" '+chk+'>'+ i+'</option>';
  	}
  	str += '</select>';

  	$("#yearArea").html(str);
}

// 년도 변경(이벤트)
function changeYear(){
	g_year = $("#choiceYear").val();
	var dateArr = g_year.split("-");

	var startDate = $("#startDate").val().split("-");
	var endDate   = $("#endDate").val().split("-");

	startDate = dateArr[0]+"-"+startDate[1]+"-"+startDate[2];
	endDate   = dateArr[0]+"-"+endDate[1]+"-"+endDate[2];

	$("#startDate").val(startDate);
	$("#endDate").val(endDate);

	doSearchBottom();
}

// 월 세팅(이벤트)
function monthSetting(){
	var nowDate = new Date();
  	var month   = nowDate.getMonth() + 1; // 현재 월
  	var str     = '';

  	for( var i=1; i<=12; i++ ){
    	str += '<button type="button" id="month_'+i+'" onclick="monthClick('+i+');">'+i+'월</button>';
	}

  	$("#monthDiv").html(str);

  	$("#month_"+month).addClass("on");
  	$('#choiceMonth').val(month);
}

// 월 선택
function monthClick(i){
	$(".on").removeClass();
  	$("#month_"+i).addClass("on");
  	$("#choiceMonth").val(i);

  	var kindType = $("#kindType").val();
  	var nowDate   = new Date($("#choiceYear").val(), i,1);
	nowDate.setMonth(nowDate.getMonth()-1); //한달 전해야 이번달이 됨
	var firstDate = new Date(nowDate.getFullYear(),nowDate.getMonth(),1);
	var lastDate  = new Date(nowDate.getFullYear(),nowDate.getMonth()+1,0);

  	$('#startDate').val(getDateFormat(firstDate));
  	$('#endDate').val(getDateFormat(lastDate));

  	doSearchBottom();
}

// 달력 세팅
function pageStart(){
	/*=========================================== 달력 세팅 : S ===========================================*/
	var nowDate = new Date();
	var dateArr = nowDate.yyyy_mm_dd().split('-');
	var nowWeekName = nowDate.getDay(); 			//오늘 번호
	var setNum = 0;
	if( nowWeekName>0 && nowWeekName<7 ){			//오늘 월~토
	  setNum = 4-nowWeekName;
	}else{											//오늘 일
	  setNum = -3;									//목요일 번호
	}

	var firstDate = new Date(nowDate.getFullYear(), nowDate.getMonth(),1);
	var lastDate  = new Date(nowDate.getFullYear(), nowDate.getMonth()+1,0);

  	$('#startDate').val(getDateFormat(firstDate));
  	$('#endDate').val(getDateFormat(lastDate));

	var thuDay = new Date(dateArr[0],parseInt(dateArr[1])-1,parseInt(dateArr[2]));	//목요일 날짜
	var thuStr = thuDay.yyyy_mm_dd();

	var thuArr = thuStr.split("-");															//목요일 기준
	var friDay = new Date(thuArr[0],parseInt(thuArr[1])-1,parseInt(thuArr[2])-30);			//-6 지난주 금
	var friStr = friDay.yyyy_mm_dd();

	/*=========================================== 달력 세팅 : E ===========================================*/
}

// 조회버튼
function clickSearch(){
	var kindType = $("#kindType").val();
	if( $('#startDate').val() > $('#endDate').val() ){
		alert("검색기간의 종료일은 시작일보다 이전일 수 없습니다.");
        $("#startDate").focus();
        return;
	}
	doSearchBottom();
}

// Top검색(부서별)
function doSearchTop(){

	var choiceYear 	= $("#choiceYear").val();
  	var choiceMonth = $("#choiceMonth").val();
  	var startDate   = $("#startDate").val();
  	var endDate     = $("#endDate").val();
  	var nowDate     = new Date().yyyy_mm_dd();
  	var userList    = [];

  	var deptId   = $("#deptId").val();
  	var kindType = $("#kindType").val();
  	var searchUserId    = $("#searchUserId").val();

  	if( choiceYear=='' ){
    	choiceYear = nowDate.substring(0,4);
  	}

  	var choiceDate = '';
	if( choiceMonth=='' ){
    	choiceDate = '';
	    if( startDate>endDate ){
	      	return false;
	    }
  	}else{
	    if( parseInt(choiceMonth)<10 && choiceMonth.length<2 ){
			choiceMonth = '0'+choiceMonth;
	    }
    	choiceDate = choiceYear+'-'+choiceMonth;
  	}

	$("#h3Title").hide(); // 공통사용으로 인한 삭제

	var url = contextRoot + "/project/projectStatisTopAjax.do";

  	var param = {
				choiceDate 		: choiceDate,
          		startDate 		: startDate,
          		endDate 		: endDate,
          		searchDeptId 	: $("#searchDeptId").val(),
          		searchOrgId     : $("#searchOrgId").val(),
          		deptId          : deptId,
          		kindType        : kindType,
          		searchUserId           : searchUserId,
          		applyOrgId : g_selectOrgId
        		}

	var callback = function(result){

  		var targetOrgId = $("#treeOrg").val()==null?$("#targetOrgId").val():$("#treeOrg").val();
		$("#projectTopArea").html(result);

		projectPieChart();  // 프로젝트 진행상태
		activityPieChart(); // 액티비티 진행상태
		officePieChart();   // 업무일지 진행상태

		$("#searchArea").show();
  	}
  	commonAjax("POST", url, param, callback, false, '', '');
}

// Bottom검색(부서별)
var choiceMonth;
function doSearchBottom(){
	var choiceYear 	= $("#choiceYear").val();
  	var choiceMonth = $("#choiceMonth").val();
  	var startDate   = $("#startDate").val();
  	var endDate     = $("#endDate").val();
  	var nowDate     = new Date().yyyy_mm_dd();

  	var deptId   = $("#deptId").val();
  	var kindType = $("#kindType").val();
  	var searchUserId    = $("#searchUserId").val();

  	if( choiceYear=="" ){
    	choiceYear = nowDate.substring(0,4);
  	}

  	var choiceDate = '';
	if( choiceMonth=="" ){
    	choiceDate = '';
	    if( startDate>endDate ){
	    	alert("검색기간의 종료일은 시작일보다 이전일 수 없습니다.");
	    	return false;
	    }
  	}else{
	    if( parseInt(choiceMonth)<10 && choiceMonth.length<2 ){
			choiceMonth = '0'+choiceMonth;
	    }
    	choiceDate = choiceYear+'-'+choiceMonth;
  	}

	var url = contextRoot + "/project/projectStatisBottomAjax.do";
  	var param = {
				choiceDate 		: choiceDate,
          		startDate 		: startDate,
          		endDate 		: endDate,
          		deptId          : deptId,
          		kindType        : kindType,
          		searchUserId           : searchUserId,
          		applyOrgId : g_selectOrgId
        		}

	var callback = function(result){

  		var targetOrgId = $("#treeOrg").val()==null?$("#targetOrgId").val():$("#treeOrg").val();
		$("#projectBottomArea").html(result);

		if( $("#kindType").val() != "U" ){
			drawDeptCompareChart();
		}

		if( $("#kindType").val()=="D" ){
			$("#bottomDept").hide();
			$("#bottomUsr").show();
		}else if( $("#kindType").val()=="U" ){
			$("#bottomDept").hide();
			$("#bottomUsr").show();
		}else if( $("#kindType").val()=="A" ){
			$("#bottomDept").show();
			$("#bottomUsr").hide();
		}else if( $("#projectId").val()==0){
		//}else if( key==0){
			$("#bottomDept").show();
		}

		getPrivateTeamActivityWork(kindType); // 부서/개인 Html설정 및 합계
  	}
  	commonAjax("POST", url, param, callback, false, '', '');
}

// Top검색(프로젝트별)
function doSearchProjectTop(){

  	var projectId  = $("#projectId").val();
  	var employee  = $("#employee").val();
  	var searchUserId      = $("#searchUserId").val();
  	var searchActivityId = $("#searchActivityId").val();
	$("#h3Title").remove();
	var url = contextRoot + "/project/projectActivityWorkStatusAjax.do";
  	var param = {
  				projectId  : projectId,
  			    searchUserId      : searchUserId,
  			    searchActivityId : searchActivityId,
  			  employee : employee,
  			applyOrgId : g_selectOrgId
    }
	var callback = function(result){
  		var targetOrgId = $("#treeOrg").val()==null?$("#targetOrgId").val():$("#treeOrg").val();
		$("#projectTopArea").html(result);
		$("#h3Title").hide();
		var searchUserId = $("#searchUserId").val();

		$("#spanProjectName").text($("#projectName").val());
		getProjectTeamPrivateWork();   // 프로젝트/팀업무/개인업무/업무전체 설정
  	}
  	commonAjax("POST", url, param, callback, false, '', '');
}

// Bottom검색(프로젝트별)
function doSearchProjectBottom(kindType, key){
	var choiceYear 	= $("#choiceYear").val();
  	var choiceMonth = $("#choiceMonth").val();
  	var startDate   = $("#startDate").val();
  	var endDate     = $("#endDate").val();
  	var nowDate     = new Date().yyyy_mm_dd();

  	var deptId   = $("#deptId").val();
  	var kindType = $("#kindType").val();
  	var searchUserId    = $("#searchUserId").val();

  	if( choiceYear=="" ){
    	choiceYear = nowDate.substring(0,4);
  	}

  	var choiceDate = '';
	if( choiceMonth=="" ){
    	choiceDate = '';
	    if( startDate>endDate ){
	    	alert("검색기간의 종료일은 시작일보다 이전일 수 없습니다.");
	    	return false;
	    }
  	}else{
	    if( parseInt(choiceMonth)<10 && choiceMonth.length<2 ){
			choiceMonth = '0'+choiceMonth;
	    }
    	choiceDate = choiceYear+'-'+choiceMonth;
  	}

	var url = contextRoot + "/project/projectStatisBottomAjax.do";
  	var param = {
				choiceDate 		: choiceDate,
          		startDate 		: startDate,
          		endDate 		: endDate,
          		deptId          : deptId,
          		kindType        : kindType,
          		searchUserId           : searchUserId,
          		applyOrgId : g_selectOrgId
        		}

	var callback = function(result){
  		var targetOrgId = $("#treeOrg").val()==null?$("#targetOrgId").val():$("#treeOrg").val();
		$("#projectBottomArea").html(result);

		if( $("#kindType").val()!="U" ){
			drawDeptCompareChart();
		}

		if( $("#kindType").val()=="D" ){
			$("#bottomDept").hide();
			$("#bottomUsr").show();
		}else if( $("#kindType").val()=="U" ){
			$("#bottomDept").hide();
			$("#bottomUsr").show();
		}else if( $("#kindType").val()=="A" ){
			$("#bottomDept").show();
			$("#bottomUsr").hide();
		}
  	}
  	commonAjax("POST", url, param, callback, false, '', '');
}

// 직원선택
function changeTargetUsrId(){
	doSearchProjectTop();
}

// 액티비티 선택
function changeTargetActivityId(){
	doSearchProjectTop();
}
//프로젝트정보 새창 띄우기
function openProjectStatus(projectId){
	if(projectId == "0") projectId = $("#projectId").val();
	var url = contextRoot+"/project/projectStatusDetail.do?saved=&pId="+projectId;
	window.open(url, '_blank');

}
</script>