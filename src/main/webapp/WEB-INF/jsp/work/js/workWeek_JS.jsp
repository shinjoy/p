<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	//Global variables :S ---------------

	var loginUserId = '${baseUserLoginInfo.userId}';
	var loginUserEmpNo = '${baseUserLoginInfo.empNo}';
	var g_applyOrgId ='${baseUserLoginInfo.applyOrgId}';

	var g_workUserId = '';
	var g_year ='';
	var g_month ='';
	var g_searchActionType = "MONTH";

	var g_selectDate =('${selectDate}' =='' ? new Date().yyyy_mm_dd() : '${selectDate}');

	var g_chkbox_seq = 0;			//체크박스 유니크 id 추가를 위한 변수

	var g_noReadAllYn = 'N';		//읽지않은 이전 업무보고 전체보기 상태 ... 'Y':전체보기, 'N':일부보기

	var searchDeptId = "";

	var myModal = new AXModal();		// instance
	//Global variables :E ---------------
	$(document).ready(function(){
		setYear();
		setMonth();

		setUserTree();

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
    	//유저프로필 이벤트 셋팅
    	initUserProfileEvent();

	});
	//사용자 트리 생성
    function setUserTree(){

        var myUserTree = new UserTree();            //UserTree 객체생성

        /* 사용자트리 설정정보 */
        var configObj = {
                targetID : 'userListAreaTree',                          //대상 위치 id (div, span)
                url : contextRoot + "/common/getOrgDeptUserList.do",    //데이터 URL
                isCheckbox:true,
                isOnlyOne : false,                                      //선택건수 1개 여부            (false: 복수,     그외,: 한명(default))
                isAllOrg : false,                                       //전체 ORG 범위로의 여부        (true: 전체ORG,       그외,: 나의권한ORG (default))
                oneOrg : '${baseUserLoginInfo.applyOrgId}',             //전달받은 한개의 ORG ID
                defaultSelectList : ['${baseUserLoginInfo.empNo}'],    //기본 선택 id array            (로딩시점 초기 기본 선택 노드 id list)
                isDeptSelectable : true,                                //부서선택 가능여부(= 하위 사용자 모두 선택)     (true: 해당부서하위모두선택,  그외,:부서선택불가 (default))
                callbackFn : selStaff,                            		//콜백 function

                rtnField : 'empNo',                                     // userId, cusId, empNo
                useNameSortList : true,									//이름정렬선택 리스트 사용 여부 (true: 사용,		그외,: 미사용(default))
                hasDeptTopLevel    : true,                              //부서의 회장 부서 표시여부  (true: 포함,     그외,: 미포함(default))
                openDeptId : ('${baseUserLoginInfo.deptMngrYn}' == 'Y' ?  '${baseUserLoginInfo.deptId}' : '0' ),
				myUserId : '${baseUserLoginInfo.empNo}',				//로긴 유저아이디
				myOrgId : '${baseUserLoginInfo.orgId}',					//로긴 유저orgId
				deptManagerDeptId : '${baseUserLoginInfo.deptIdMngr}',
				authTree : true,
				useAllCheck : true
        };
		//전체 업무일지 열람 권한 적용
        if('${baseUserLoginInfo.workViewYn}' == 'Y') configObj.deptManagerDeptId = '-1';

        myUserTree.setConfig(configObj);    //설정정보 세팅
        myUserTree.drawTree();              //트리 생성
    }

	//검색
	function selStaff(userList,orgId){
		g_workUserId = userList;
		doSearch();

	}
	//년도 세팅
    function setYear(){
    	//var nowDate= new Date().yyyy_mm_dd();
    	var nowYear = g_selectDate.substring(0,4);
    	var str ='<select id="choiceYear" class="select_b w_date" onchange="changeYear();">';
    	for(var i="2012";i<=parseInt(nowYear)+1;i++){
    		var chk ='';
    		if(nowYear == i){
    			chk ='selected="selected"';
    		}
    		str += '<option value="'+ i+'" '+chk+'>'+ i+'</option>';
    	}
    	str += '</select>';
    	$("#yearArea").html(str);
    }

	//월 세팅
    function setMonth(){
    	//var nowDate= new Date().yyyy_mm_dd();
    	var nowMonth = g_selectDate.substring(5,7);

    	var str ='';
    	for(var i=1; i<13; i++){
    		str += '<button type="button" id="month_'+i+'" onclick="changeMonth('+i+');">'+i+'월</button>';
    	}

    	$("#monthArea").html(str);
    	$("#month_"+parseInt(nowMonth)).addClass("on");
    }

 	 //년도 변경
    function changeYear(){
    	g_year =$("#choiceYear").val();
    	g_searchActionType = "MONTH";

    	doSearch();
    }

    //월 변경
    function changeMonth(month){
    	$(".on").removeClass();
    	$("#month_"+month).addClass("on");
    	g_month = fillzero(month, 2);
    	g_searchActionType = "MONTH";

    	doSearch();
    }

    //검색
    function doSearch(){
    	searchDeptId = "";
		if(g_workUserId.length == 0||g_workUserId==0){

			if($(".jstree-clicked").length>0){

			}else{
				$("#weekWorkCalArea").html('<dd class="pro_historyList"><div class="nocontents">직원을 선택해 주세요.</div></dd>');
			}

			return;
		}
		var dateArr = g_selectDate.split("-");

		if(g_year != '') dateArr[0]=g_year;
		if(g_month!= '') dateArr[1]=g_month;

		var lastDay = ( new Date( dateArr[0], dateArr[1], 0) ).getDate();		//마지막 날짜

		var url = contextRoot + "/work/selectWorkWeekList.do";

		var param = {
				userIdStr	: g_workUserId.join(","),
				loginUserId	: loginUserId,
				secretYn	: (g_workUserId == loginUserId ? 'Y' : 'N'),		//조회자 본인 여부
				selectMonth : dateArr[0]+'-'+dateArr[1],
				calYear 	: dateArr[0],
				mm 			: dateArr[1],
				orgId 		: g_applyOrgId,
				option 		: 'holiday',
				treeOrg		: $("#treeOrg").val(),
                searchActionType     : g_searchActionType
		};


		var callback = function(result){
			$("#weekWorkCalArea").html(result);

			//유저프로필 이벤트 셋팅
	    	initUserProfileEvent();
		};
		commonAjax("POST", url, param, callback, true);
    }

    //부서별 검색
    function searchDept(deptId , type){
    	var $targetFrm = $("#workWeekFrm_"+deptId);

    	searchDeptId = deptId;

    	//조회 유저 리스트 스트링 만들기
    	var userIdStr = "";

    	$($targetFrm.find("input[name='weekSearchUserId']")).each(function(i){
    		if(i>0) userIdStr+=",";

    		userIdStr += $(this).val();
    	});

    	//조회주차
    	var weekNum = $targetFrm.find("input[name='weekNum']").val();

    	//연도
    	var year = $targetFrm.find("input[name='weekYear']").val();

    	var url = contextRoot + "/work/selectWorkWeekListAjax.do";

		var param = {
				userIdStr	: userIdStr,
				loginUserId	: loginUserId,
				secretYn	: (g_workUserId == loginUserId ? 'Y' : 'N'),		//조회자 본인 여부
				weekNum		: weekNum,
				year		: year,
				type		: type,
				orgId 		: g_applyOrgId,
				option 		: 'holiday',
				treeOrg		: $("#treeOrg").val(),
                searchActionType     : g_searchActionType
		};


		var callback = function(result){

			$("#workWeekArea_"+deptId).html(result).attr("id","");

			//유저프로필 이벤트 셋팅
	    	initUserProfileEvent();
		};
		commonAjax("POST", url, param, callback, false);

    }

    //그리드 데이터 정보 조회
    function doSearchMainContents(){

    	var startStr = "";
    	var endStr = "";

    	var userIdStr = "";
    	//연도
    	var year = "";
    	//주차
    	var weekNum = "";
    	if(searchDeptId!=""){

    		var $targetFrm = $("#workWeekFrm_"+searchDeptId);

    		startStr = $targetFrm.find("input[name='startStr']").val();
    		endStr = $targetFrm.find("input[name='endStr']").val();

    		$($targetFrm.find("input[name='weekSearchUserId']")).each(function(i){
        		if(i>0) userIdStr+=",";

        		userIdStr += $(this).val();
        	});

    		year = $targetFrm.find("input[name='weekYear']").val();

    		//조회주차
        	weekNum = $targetFrm.find("input[name='weekNum']").val();
    	}else{
    		startStr = $("input[name='startStr']").eq(0).val();
    		endStr = $("input[name='endStr']").eq(0).val();

    		userIdStr=g_workUserId.join(",");

    		year = $("input[name='weekYear']").eq(0).val();
    		//조회주차
        	weekNum = $("input[name='weekNum']").eq(0).val();
    	}

		var url = contextRoot + "/work/selectWorkWeekMainList.do";

		var param = {
				userIdStr	: userIdStr,
				loginUserId	: loginUserId,
				secretYn	: (g_workUserId == loginUserId ? 'Y' : 'N'),		//조회자 본인 여부
				startStr 	: startStr,
				endStr 		: endStr,
				year		: year,
				weekNum		: weekNum,
				orgId 		: g_applyOrgId,
				option 		: 'holiday',
				treeOrg		: $("#treeOrg").val()
		};


		var callback = function(result){
			var obj = JSON.parse(result);

			//개인메모
			var personalWorkDailyList = obj.resultObject.personalWorkDailyList;
			//팀업무
			var teamWorkDailyList = obj.resultObject.teamWorkDailyList;
			//일정
			var scheList = obj.resultObject.scheList;
			//영업정보
			var businessDailyList = obj.resultObject.businessDailyList;

			//비고
			var workWeekNoteList = obj.resultObject.workWeekNoteList;

			viewContents(personalWorkDailyList,teamWorkDailyList,scheList,businessDailyList,workWeekNoteList);

		};
		commonAjax("POST", url, param, callback, false);
    }

    //달력 화면 내용을 표시한다.
    function viewContents(personalWorkDailyList,teamWorkDailyList,scheList,businessDailyList,workWeekNoteList){
    	//일정 셋팅
		for(var i = 0 ; i <scheList.length;i++){
			var stStr = "";
			var scheInfo = scheList[i];

			stStr += "<li><span class=\"fl_block\">";
			stStr += "<a href=\"javascript:viewSchedule("+scheInfo.scheSeq+");\" id='scheDt_"+scheInfo.scheSeq+"' class=\"con_txt ";

			if(scheInfo.scheChkFlag == 'Y'){		//완료일정일때 해당일정 줄긋기
				stStr+='ck_finish';
			}
			stStr+='">';
			stStr += "<span class=\"time\">";
			stStr += scheInfo.scheSTime
			stStr += "</span>";
			stStr += "["+scheInfo.activityNm+"]";
			stStr += devUtil.fn_escapeReplace(scheInfo.scheTitle);
			stStr += "</a></span><span class=\"fr_block\"><em class=\"state_txt\">";

			var workDate = scheInfo.viewDate;
			stStr += (scheInfo.scheChkFlag=='Y'?'완료':(scheInfo.scheSDate>new Date().yyyy_mm_dd() && workDate>new Date().yyyy_mm_dd()?'계획':'진행'));


			stStr += "</em></span></li>";

			var userId = scheInfo.regPerId;

			var entryId = scheInfo.entryId;

			var workDateBuf = workDate.split("-");
			if($("#todoList_"+userId+"_"+workDateBuf[1]+"_"+workDateBuf[2]).find("#scheDt_"+scheInfo.scheSeq).length == 0)
				$("#todoList_"+userId+"_"+workDateBuf[1]+"_"+workDateBuf[2]).append(stStr);

			if(userId!=entryId){
				if($("#todoList_"+entryId+"_"+workDateBuf[1]+"_"+workDateBuf[2]).find("#scheDt_"+scheInfo.scheSeq).length == 0)
					$("#todoList_"+entryId+"_"+workDateBuf[1]+"_"+workDateBuf[2]).append(stStr);
			}
		}

		//개인 업무 셋팅
		for(var i = 0 ; i <personalWorkDailyList.length;i++){
			var stStr = "";
			var personalWorkDailyInfo = personalWorkDailyList[i];

			stStr += "<li><span class=\"fl_block\">";
			stStr += "<a href=\"javascript:viewWorkDaily("+personalWorkDailyInfo.listId+",'"+personalWorkDailyInfo.workType+"','"+personalWorkDailyInfo.workDate+"','VIEW');\" class=\"con_txt\">";
			stStr += "<span>";
			stStr += devUtil.fn_escapeReplace(personalWorkDailyInfo.title);
			stStr += "</span>";
			stStr += "</a></span><span class=\"fr_block\"><em class=\"state_txt\">";
			stStr += personalWorkDailyInfo.progressTxt;
			stStr += "</em></span></li>";

			var userId = personalWorkDailyInfo.empId;

			var workDate = personalWorkDailyInfo.orgWorkDate;
			var workDateBuf = workDate.split("-");

			$("#todoList_"+userId+"_"+workDateBuf[1]+"_"+workDateBuf[2]).append(stStr);
		}

		//팀 업무 셋팅
		for(var i = 0 ; i <teamWorkDailyList.length;i++){
			var stStr = "";
			var teamWorkDailyInfo = teamWorkDailyList[i];

			stStr += "<li><span class=\"fl_block\">";
			stStr += "<a href=\"javascript:viewWorkDaily("+teamWorkDailyInfo.listId+",'"+teamWorkDailyInfo.workType+"','"+teamWorkDailyInfo.workDate+"','VIEW');\" class=\"con_txt\">";
			stStr += "<span class=\"icon_teamwork\"></span>";
			stStr += "<span class=\"icon_important_L";
			stStr += teamWorkDailyInfo.important;
			stStr += "\"><em></em></span>"
			stStr += devUtil.fn_escapeReplace(teamWorkDailyInfo.title);
			stStr += "</a></span><span class=\"fr_block\">";
			var dailyType = teamWorkDailyInfo.dailyType;

			if(dailyType=="BEFORE"){
				stStr += "<em class=\"state_date\">";
				stStr +=(teamWorkDailyInfo.workDayCount >0 ? '+' : '-')+teamWorkDailyInfo.workDayCount;
				stStr += "</em></span></li>";
			}else{
				stStr += "<em class=\"state_txt\">";
				stStr += teamWorkDailyInfo.progressTxt;
				stStr += "</em></span></li>";
			}

			var userId = teamWorkDailyInfo.empId;

			var workDate = teamWorkDailyInfo.orgWorkDate;
			var workDateBuf;

			var teamListUserStr = teamWorkDailyInfo.teamListUserStr;

			if(dailyType=="BEFORE"){
				var nowStr = new Date().yyyy_mm_dd();
				workDateBuf = nowStr.split("-");

			}else{
				workDateBuf = workDate.split("-");
			}

			if(teamListUserStr!=null){
				var teamListUserStrBuf = teamListUserStr.split(",");

				for(var j = 0 ; j <teamListUserStrBuf.length ; j++){
					if(userId != teamListUserStrBuf[j]){
						$("#todoList_"+teamListUserStrBuf[j]+"_"+workDateBuf[1]+"_"+workDateBuf[2]).append(stStr);
					}
				}
			}

			$("#todoList_"+userId+"_"+workDateBuf[1]+"_"+workDateBuf[2]).append(stStr);

		}
		//영업정보 셋팅
		for(var i = 0 ; i < businessDailyList.length ;i++){
			var stStr = "";
			var businessDailyInfo = businessDailyList[i];

			stStr += "<li><span class=\"fl_block\">";
			stStr += "<a href=\"javascript:openDetailWindow("+businessDailyInfo.infoId+");\" class=\"con_txt\">";

			var pathMeaningKOR = "";
			var typeMeaningKOR = "";
			var typeSubMeaningKOR = "";

			pathMeaningKOR = businessDailyInfo.pathMeaningKOR;
			typeMeaningKOR = businessDailyInfo.typeMeaningKOR;
			typeSubMeaningKOR = businessDailyInfo.typeSubMeaningKOR;


			stStr += "<span class='info_type_cway'>"+pathMeaningKOR+ "</span>";
			stStr += "<span class='info_type_c1'>"+typeMeaningKOR+ "</span>";
			stStr += "<span class='info_type_c2'>"+typeSubMeaningKOR + "</span>";
			stStr += "<span>"+businessDailyInfo.cpnName1+"</span></a>";

			stStr += " <span class='icon_comment'>("+ businessDailyInfo.cnt +")</span>";

			if(businessDailyInfo.newYn == 'NEW'){
				stStr += "<span class='icon_new'><em>new</em></span>";
			}
			stStr += "</div></li>";

			var userId = businessDailyInfo.createdBy;

			var workDate = businessDailyInfo.viewDate;


			var workDateBuf=workDate.split("-");


			var staffUserStr = businessDailyInfo.staffUserStr;
			if(staffUserStr!=null){
				var staffUserStrBuf = staffUserStr.split(",");

				for(var j = 0 ; j <staffUserStrBuf.length ; j++){
					if(userId != staffUserStrBuf[j]){
						$("#shareInfo_"+staffUserStrBuf[j]+"_"+workDateBuf[1]+"_"+workDateBuf[2]).append(stStr);

					}
				}
			}
			$("#shareInfo_"+userId+"_"+workDateBuf[1]+"_"+workDateBuf[2]).append(stStr);

		}

		//비고
		for(var i = 0 ; i <workWeekNoteList.length;i++){
			var workWeekNoteInfo = workWeekNoteList[i];

			var note = devUtil.fn_escapeReplace(workWeekNoteInfo.note);
			$("#memoText_"+workWeekNoteInfo.userId).val(note);
			note = note.replace(/(?:\r\n|\r|\n)/g, '<br />');
			$("#memoArea_"+workWeekNoteInfo.userId).html(note);
		}

		$(".todo_list").each(function(){
			var htmlStr = $(this).html().trim();

			if(htmlStr == ""){
				$(this).remove();
			}
		});

		$(".share_info_list").each(function(){
			var htmlStr = $(this).html().trim();

			if(htmlStr == ""){
				$(this).remove();
			}
		});

    }


  	//업무일지 보기화면
    function viewWorkDaily(listId,workType,viewDate,openType){


    	var url =contextRoot+"/work/workDailyViewPopup/pop.do";
    	var width = 750;
    	if(workType == 'TEAM'){	//팀업무
    		//url 바꾸기
    		url =contextRoot+"/work/workDailyTeamViewPopup/pop.do";
    		width = 1300;
    	}

    	var param = {
      			 listId 	: listId,
      			 workUserId	: g_workUserId,
      			 workDate	: viewDate,
      			 openType	: openType
      	};


 	   	myModal.open({
 	   		url: url,
 	   		pars: param,
 	   		titleBarText: '업무일지 상세',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
 	   		method:"POST",
 	   		top: $(document).scrollTop()+150,
 	   		width: width,
 	   		closeButton: false,
 	   		changeCloseBtn: true,
 	   		closeByEscKey: true					//esc 키로 닫기
   		});

   		$('#myModalCT').draggable();

    }

  	//일정 보기
    function viewSchedule(scheSeq){
	    var url = "<c:url value='/ScheduleView.do?ScheSeq=" + scheSeq + "'/>";
	    window.open(url, 'scheduleView','resizable=no,width=674,height=700,scrollbars=yes');
	    schePopFlag = true;
    }

  	//정보 상세페이지 열기
    function openDetailWindow( infoId ){
		var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";

		var url=contextRoot+"/business/businessDetail.do?infoId="+infoId;
		window.open(url, 'businessDetailPop',option);
    }
  	//메모등록 영역 show
  	function openMemo(userId){
  		$("#memoInnerArea_"+userId).show();
  	}
  	//메모등록 영역 hide
  	function eleMemoDiv(userId){
  		$("#memoInnerArea_"+userId).hide();
  	}
  	//메모등록
  	function regMemo(userId,deptId,startStr,endStr){

  		var $targetFrm = $("#workWeekFrm_"+deptId);

    	//조회주차
    	var weekNum = $targetFrm.find("input[name='weekNum']").val();

    	//연도
    	var year = $targetFrm.find("input[name='weekYear']").val();


  		var url =contextRoot+"/work/processWorkWeekNoteAjax.do";
  		var param = {
  				userId	: userId,
  				startStr: startStr,
  				endStr	: endStr,
  				deptId	: deptId,
  				year	: year,
  				weekNum	: weekNum,
				note 	: $("#memoText_"+userId).val()
		};


		var callback = function(result){
			searchDept(deptId , 'NONE');
		};
		commonAjax("POST", url, param, callback, true);
  	}

  	//엑셀 다운
  	function excelDownload(){

  		var result = $("#weekWorkCalArea").html();

  		$("#weekWorkCalAreaExcel").html(result);

  		$("#weekWorkCalAreaExcel").find(".memoInnerArea").remove();
  		$("#weekWorkCalAreaExcel").find(".memoBtn").remove();
  		$("#weekWorkCalAreaExcel").find(".btn_arrow").remove();

  		$("#weekWorkCalAreaExcel").find("a").each(function(){
  			var txt = $(this).text();

  			$(this).parent().append("<span>"+txt+"</span>");

  			$(this).remove();
  		})


  		var targetHtml = $("#weekWorkCalAreaExcel").html();
  		excelDown(targetHtml, '주간보고_' +(new Date().yyyy_mm_dd()));
  	}
	var sheduleObj = {
			getWorkDailyList : function(){
				doSearch();
			}
	}

	//인쇄
	function workWeekPrint(){
		$(".share_info_list").removeClass("share_info_list").addClass("print_info_list");
		$(".icon_teamwork").removeClass("icon_teamwork").addClass("icon_teamwork_buf");
		$(".mine").removeClass("mine").addClass("mine_buf");


		$(".icon_teamwork_buf").text("[팀업무]");
		window.print();

		$(".print_info_list").removeClass("print_info_list").addClass("share_info_list");
		$(".mine_buf").removeClass("mine_buf").addClass("mine");
		$(".icon_teamwork_buf").removeClass("icon_teamwork_buf").addClass("icon_teamwork");
		$(".icon_teamwork").text("");
	}
</script>