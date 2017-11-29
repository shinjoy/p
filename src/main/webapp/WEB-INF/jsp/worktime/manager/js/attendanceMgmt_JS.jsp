<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>


<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>

<script type="text/javascript">

var g_userId = '${userId}';
var g_deptId = '${deptId}';
var g_deptLevel = '${deptLevel}';
var g_deptMngrYn = '${deptMngrYn}';
var g_vipAuthYn = '${vipAuthYn}';
var g_viewAuth = '${viewAuth}';

var g_auth ="${baseUserLoginInfo.orgBasicAuth}";

	$(document).ready(function(){

		fnObj.doLoadTreeviewPage();       //검색

		if(!($("#pageType").val() == "VIEW" && g_viewAuth != "ALL")){
			moveTab('dayList');
		}

		if($("#pageType").val() == "VIEW" && g_viewAuth == "USER"){
            $("#frm #searchUserId").val(g_userId);
            $(".verticalWrap").attr("class","");
            $(".addAreaZone").hide();
        }else{
            $("#frm #searchUserId").val("");
        }

        if($("#pageType").val() == "VIEW" && g_viewAuth == "DEPT"){
            //$("#searchDeptId").val(g_deptId);
        }else{
            $("#searchDeptId").val("");
        }

        openMkWorktimePopup();  //메디카코리아 팝업 처리
	});

	function moveTab(type){
		$("#actionType").val(type);

		$("#moveTabArea").find("li").removeClass();

		var targetLi = type + "Li";

		$("#"+targetLi).addClass("current");

		linkPage(1);
	}

	//검색
    function linkPage(pageNo){
        $("#pageIndex").val(pageNo);
        var url = "";

        $("#targetOrgId").val($("#treeOrg").val());
        $("#searchUserId").val('');

        if($("#userArr").val() == '') $("#userArr").val('${baseUserLoginInfo.userId}');

        switch($("#actionType").val()){
        case 'monthList' :

        	$("#userTreeArea").show();
        	$("#wrapArea").addClass("verticalWrap");

        	if($("#searchMonth").val() == "All"){
                url=contextRoot+"/worktime/manager/attendanceYearListAjax.do";
            }else{
                url=contextRoot+"/worktime/manager/attendanceMonthListAjax.do";
            }
        	break;
        case 'dayList' :
        	$("#userTreeArea").show();
        	$("#wrapArea").addClass("verticalWrap");
        	url = contextRoot+"/worktime/manager/attendanceDayListAjax.do";
        	break;
        case 'excelList' :
        	$("#userTreeArea").hide();
        	$("#wrapArea").removeClass();
        	url = contextRoot+"/worktime/manager/attendanceExcelListAjax.do";
        }

        $("#frm").attr("action",url);
        commonAjaxSubmit("POST",$("#frm"),searchCallback);
    }

    // 검색 콜백
    function searchCallback(data){
        $("#selTapArea").html(data);

        var auth = $("#treeOrg option:selected").attr("targetAuth");

        if(auth == "READ"){
			$(".btn_auth").hide();
		}else{
			$(".btn_auth").show();
		}

        var auth = $("#treeOrg option:selected").attr("targetAuth");

		if(auth == "READ") $(".orgAuth").hide();
    }

	//근태현황(월 조회)
	function searchForMonth(obj, searchMonth){
		//$(obj).attr("class","on");
		$("#searchMonth").val(searchMonth);
		linkPage(1);
	}

	//왼쪽트리 전체 조직 선택시
    function searchAllOrg(chkbox){
		$("#searchDeptId").val("");
		$(".jstree-clicked").attr("class","jstree-anchor");
        linkPage(1);
    }

	//근태승인 팝업호출
	function openAttendanceApprov(worktimeId,actionType){
		var url = "<c:url value='/worktime/manager/attendanceApprovPopup.do'/>" + "?worktimeId="+worktimeId + "&actionType="+actionType;
	    window.open(url, 'attendanceAppro','resizable=no,width=650,height=480,scrollbars=yes');
	}

	//화면재로딩
	function openPage(){
		linkPage(1);
	}

	/*
	 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
	 */
	var fnObj = {

		doLoadTreeviewPage: function(){        //knd : null - 검색버튼, 숫자 - 페이지검색
			fnObj.setUserTree();

		},

		//사용자 트리 생성
		setUserTree: function(){

			var myUserTree = new UserTree();			//UserTree 객체생성


			/* 사용자트리 설정정보 */
			var configObj = {
					targetID : 'userTreeArea',							//대상 위치 id (div, span)
					url : contextRoot + "/common/getOrgDeptUserList.do",	//데이터 URL
					isCheckbox:true,
					isOnlyOne : false,										//선택건수 1개 여부			(false: 복수,		그외,: 한명(default))
					isAllOrg : false,										//전체 ORG 범위로의 여부		(true: 전체ORG, 		그외,: 나의권한ORG (default))
					oneOrg : '${baseUserLoginInfo.applyOrgId}',				//전달받은 한개의 ORG ID
					defaultSelectList : ['${baseUserLoginInfo.userId}'],	//기본 선택 id array 			(로딩시점 초기 기본 선택 노드 id list)
					isDeptSelectable : true,								//부서선택 가능여부(= 하위 사용자 모두 선택)		(true: 해당부서하위모두선택, 	그외,:부서선택불가 (default))
					callbackFn : fnObj.treeCallback,						//콜백 function

					defaultUseAllCheck : false,								//전체선택 디폴트 여부
					useNameSortList : true,									//이름정렬선택 리스트 사용 여부 (true: 사용,			그외,: 미사용(default))

			};

			//관리화면에서는 디폴트로 전체선택되도록
			if('${pageType}' == 'MGMT'){
				configObj.useAllCheck = true;
				configObj.defaultUseAllCheck = true;
				configObj.closeAllnode = true;

			}else{

				configObj.openDeptId = ('${baseUserLoginInfo.deptMngrYn}' == 'Y' ?  '${baseUserLoginInfo.deptId}' : '0' );

				configObj.myUserId = '${baseUserLoginInfo.userId}';				//로긴 유저아이디
				configObj.myOrgId = '${baseUserLoginInfo.orgId}';					//로긴 유저orgId
				configObj.deptManagerDeptId = '${baseUserLoginInfo.deptIdMngr}',
				configObj.authTree = true;
				configObj.useAllCheck = true;

				//권한자
				if('${baseUserLoginInfo.scheduleViewYn}' == 'Y') configObj.deptManagerDeptId = '-1';

			}

			myUserTree.setConfig(configObj);	//설정정보 세팅
			myUserTree.drawTree();				//트리 생성
		},

		//트리 선택 콜백
		treeCallback : function(userList){

            $("#userArr").val(userList);
            linkPage(1);

            openMkWorktimePopup();  //메디카코리아 팝업 처리
            //alert(userList);

		}


	};

var g_mkWorktimePopYn = false;
//메디카코리아 팝업 처리
function openMkWorktimePopup(){
    //메디카코리아이고 메디카코리아 팝업 대상자 이면 팝업함
    if(!g_mkWorktimePopYn && $("#treeOrg").val() == "75" && "${baseUserLoginInfo.mkWorktimePopYn}" == "Y"){
        var url = "http://blog.medicakorea.co.kr/eis/include/synergy_attend.php?date_gb=today&loc_gb=all";
        window.open(url, 'mkWorktimePopYn','resizable=yes,width=500,height=750,scrollbars=yes');
        g_mkWorktimePopYn = true;
    }
}

//일근태마감처리
function processWorkTimeDayEnd(){
	if($("#notApproveCnt").val() > 0){
		alert("근태승인 요청 건이 있어 일근태 마감이 불가능 합니다.");
		return;
	}else if($("#endDateYn").val() == "Y"){
        alert("근태일로부터 7일이후 일근태 마감이 가능합니다.");
        return;
    }else{
		if(confirm("근태 마감 시 \n[미로그인]->[결근], [지각]-> [지각]으로\n근태상태가 확정됩니다. \n"+$("#strSearchDate").val() + "근태를 마감하시겠습니까?")){
			$('#frm').attr('action', "<c:url value='/worktime/manager/processWorkTimeDayEndAjax.do'/>");
		    commonAjaxSubmit("POST", $("#frm"), processWorkTimeDayEndCallback);
		}
	}
}
//저장후 콜백
function processWorkTimeDayEndCallback(result){
    if(result.result == "SUCCESS"){
        alert("일근태마감처리가 완료되었습니다.");
        linkPage(1);
    }else if(result.result == "FAIL"){
        alert("일근태마감처리에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    }else{
        alert(result.result);
    }
}

//월근태마감처리
function processWorkTimeMonthEnd(){
    if($("#notApproveCnt").val() > 0){
    	if(confirm("근태승인 요청내역이 있어 "+$("#searchMonth").val()+"월 근태 마감이 불가능합니다.\n요청일 : "
    			+$("#notApproveWorkDay").val()+"일\n[확인]버튼을 클릭하시면 승인요청 날짜로이동합니다.\n이동하시겠습니까?")){
    		var searchDate = $("#searchYear").val() + "-" + $("#searchMonth").val() + "-" + $("#notApproveWorkDay").val().split(",")[0];
    		$("#actionType").val("dayList");
    		$("#searchYear").val("");
    		$("#searchMonth").val("");

    		var $frm = $('#frm');
    		$("#searchDate").val(searchDate);
    		moveTab('dayList');
    	}else{
    		return;
    	}
    }else if($("#endDateYn").val() == "Y"){
        alert("월근태마감은 다음달 7일이후 가능합니다.");
        return;
    }else{
        if(confirm("근태 마감 시 \n[미로그인]->[결근], [지각]-> [지각]으로\n근태상태가 확정됩니다. \n"+$("#searchMonth").val() + "월 근태를 마감하시겠습니까?")){
        	$("#searchDate").val("");
            $('#frm').attr('action', "<c:url value='/worktime/manager/processWorkTimeMonthEndAjax.do'/>");
            commonAjaxSubmit("POST", $("#frm"), processWorkTimeMonthEndCallback);
        }
    }
}
//저장후 콜백
function processWorkTimeMonthEndCallback(result){
    if(result.result == "SUCCESS"){
        alert("월근태마감처리가 완료되었습니다.");
        linkPage(1);
    }else if(result.result == "FAIL"){
        alert("월근태마감처리에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    }else{
        alert(result.result);
    }
}

//년별건수 상세화면 팝업
function openWortimeListPopup(searchUserId,searchMonth){
	/* var searchYear = $("#searchYear").val();
	var url = "<c:url value='/worktime/manager/openWortimeListPopup.do'/>" + "?searchUserId="+searchUserId+"&searchYear="+searchYear+"&searchMonth="+searchMonth;
    window.open(url, 'openWortimekListPopup','resizable=no,width=300,height=250,scrollbars=yes');
 */

    $("#frmYearPop input[name=searchYear]").val($("#frm select[name=searchYear]").val());
    $("#frmYearPop input[name=searchMonth]").val(searchMonth)
    $("#frmYearPop input[name=searchUserId]").val(searchUserId)

    var url = contextRoot+"/worktime/manager/openWortimeListPopup.do";
    $("#frmYearPop").attr("action",url);
    commonAjaxSubmit("POST",$("#frmYearPop"),openWortimeListPopupCallback);
}

// 년별건수 상세화면 팝업 콜백
function openWortimeListPopupCallback(data){
	var attendanceBox = "attendanceBox_"+ $("#frmYearPop input[name=searchUserId]").val()+$("#frmYearPop input[name=searchMonth]").val();
/*     $("#"+attendanceBox).html(data);
    $("#"+attendanceBox).css("display","block"); */
    $("div[name='"+attendanceBox+"']").html(data);
    $("div[name='"+attendanceBox+"']").css("display","block");
}

function closeShowlayer(attendanceBox){
	$("div[name='"+attendanceBox+"']").css("display","none");
}

function showlayer(id){
/* 	alert(id);
	$("#showPop").html($("#attendanceBox").html()); */
    if(id.style.display == 'none') {
    	id.style.display='block';
    }else{
    	id.style.display = 'none';
    }
}

//엑셀다운로드
function excelDownDayList(){
	var htmlStr = "";
	htmlStr += "<table>";
    //htmlStr += $('#SGridTargetSum').html();
    htmlStr += $('#SGridTargetSum').html().replace('부모코드초기화', '');
    htmlStr += "</table>";
	htmlStr += "<table>";
	//htmlStr += $('#SGridTarget').html();
	htmlStr += $('#SGridTarget').html().replace(/근태승인/gi, '').replace(/승인수정/gi, '');
	htmlStr += "</table>";
    // htmlStr += '<tr bgcolor=silver><td>지출일자</td><td>항목</td><td>금액</td><td>소속회사</td><td>이름</td><td>장소</td><td>지출내용</td><td>시너지참석자</td><td>등록자</td><td>상태</td></tr>';
    //htmlStr += $('#SGridTarget').html().replace(/checkbox/gi,'hidden').replace(/<em>선택<\/em>/gi, '').replace(/img/gi, 'hidden').replace(/수정/gi, '');
    //htmlStr += "</table>";
    excelDown(htmlStr, '근태현황_'+$("#capSearch").text());
}

function excelDownMonthList(){
    var htmlStr = "";
    htmlStr += "<table>";
    htmlStr += $('#SGridTarget').html();
    htmlStr += "</table>";
    excelDown(htmlStr, '근태현황_'+$("#capSearch").text());
}

//화면재로딩
function doRefreshPage(){
	var url = "";
	if($("#pageType").val() == "VIEW") url = contextRoot+"/worktime/manager/attendanceViewList.do";
	else if($("#pageType").val() == "MGMT") url = contextRoot+ "/worktime/manager/attendanceMgmt.do";

	window.location.href = url;
}

</script>

