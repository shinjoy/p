<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href='${pageContext.request.contextPath}/css/fullCalendar/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/css/fullCalendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='${pageContext.request.contextPath}/css/fullCalendar/scheduler.min.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/js/fullCalendar/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/js/fullCalendar/fullcalendar.js'></script>
<script src='${pageContext.request.contextPath}/js/fullCalendar/scheduler.min.js'></script>


<style type="text/css">

html h2, body h2 {
    font-size: 20px;
    font-weight:bold;
}

/* 회의실별 테이블 */

.meeting_room_table {
    letter-spacing: -0.1px;
    width: 100%;
    overflow: auto;
    width: 100%;
}

.meeting_room_table thead th {
    background: #dfe3e8;
    font-weight: normal;
    color: #33383f;
    line-height: 1.4;
    padding: 3px 3px 3px;
    text-align: center;
    border-right: #b9c1ce solid 1px;
    border-bottom: #b1b5ba solid 1px;
    border-top: #b1b5ba solid 1px;
    border-left: #b9c1ce solid 1px;
    font-size: 13px;
    vertical-align: middle;
    letter-spacing: -0.05em;
}

.meeting_room_table tbody td{
    border-right: #dadcdd solid 1px;
    border-bottom: #dadada solid 1px;
    vertical-align: top;
    text-align: center;
    font-size: 12px;
    line-height: 1.4;
    color: #636c7f;
    letter-spacing: 0px;
    padding: 6px 10px 3px;
    min-hight : 20px;
}

.meeting_room_table tbody th{
    border-right: #dadcdd solid 1px;
    border-bottom: #dadada solid 1px;
    border-left: #dadada solid 1px;
    vertical-align: middle;
    text-align: center;
    font-size: 12px;
    line-height: 1.4;
    color: #636c7f;
    letter-spacing: 0px;
    padding: 3px 10px 3px;
}

.meeting_room_table tbody tr:nth-child(2n) { background:#f7f7f7; }


/* 주별 테이블 */

.meeting_room_week_table {
    letter-spacing: -0.1px;
    width: 100%;
    overflow: auto;
    width: 100%;
}

.meeting_room_week_table thead th {
    background: #dfe3e8;
    font-weight: normal;
    color: #33383f;
    line-height: 1.4;
    padding: 8px 3px 8px;
    text-align: center;
    border-right: #b9c1ce solid 1px;
    border-bottom: #b1b5ba solid 1px;
    border-top: #b1b5ba solid 1px;
    border-left: #b9c1ce solid 1px;
    font-size: 13px;
    vertical-align: middle;
    letter-spacing: -0.05em;
}

.meeting_room_week_table tbody td{
    border-right: #dadcdd solid 1px;
    border-bottom: #dadada solid 1px;
    vertical-align: top;
    text-align: center;
    font-size: 12px;
    line-height: 1.4;
    color: #636c7f;
    letter-spacing: 0px;
    padding: 6px 10px 3px;
    min-hight : 20px;
}

.meeting_room_week_table tbody td:first-child{
    border-left: #dadada solid 1px;

}

.fc-resource-cell{cursor:pointer;}


/* 회의실별 날짜 <> 표기 */

.fc-widget-header{height:38px;background:#fffff;}

.fc-content{padding: 10px;}

.fc-button {
    box-sizing: border-box;
    height: 2.1em;
    font-size: 1em;
    white-space: nowrap;
    cursor: pointer;
    margin: 0px;
    padding: 0px 0.8em;
    margin: 0px 0px 0px -5px;
}

.other_rsv_div{background:rgb(204, 204, 204);border:1px solid #b0b8bb;color:black;}		/* 타인 div */
.noUsed{background:white;}
.enableUsed{background:#fffae3;}

/* 툴팁 */

.toolTip {
	position: absolute;
	z-index: 10;
	display:none;

}

.toolTip .detailArea {
	width: 200px;
	background-color: white;
    color: #020202;
	text-align: left;
	border-radius: 5px;
	padding: 10px 5px;
	border:1px solid #4e4b46;

}

.toolTip .detailArea::after {
	content: "";
	position: absolute;
	bottom: 100%;
	left: 50%;
	margin-left: -10px;
	border-width: 10px;
	border-style: solid;
	border-color: transparent transparent #4e4b46 transparent;

}

#containerWrap{padding:10px;}

.rsvDiv{

    border: 1px solid #cccccc;
    padding: 10px;
    border-radius: 7px;
    margin-top: 10px;


}

.myDiv{

    border: 1px solid #207eda;
    padding: 10px;
    border-radius: 7px;
    margin-top: 10px;
    cursor: pointer;


}
</style>

<!-- 회의실 정보 -->
<div id="infoMeetingRoom" class="toolTip">
	<p class="detailArea">

		<strong class="mgl10">위치 : </strong><strong id="locationArea" style="color: #ec8909;"></strong><br/>
		<strong class="mgl10">설명 : </strong><span id="descriptionArea"></span>

	</p>
</div>
<!-- //회의실 정보// -->



<input type="hidden" id="scheduleId" value="0"/>
<input type="hidden" id="rsvId" value="0"/>

<body>
<input type="hidden" id="usrId">
<section id="detail_contents">
	<div id="rightPanel">
   		<div style="width:100%;">
	    	<!-- TAB  -->
    		<div id="container">
    			<ul class="tabZone_st03">
					<li id="dayListLi" class="current"  rel="tabs-1"><a href="#;">Day</a></li>
					<li id="weekListLi" class="" rel="tabs-2"><a href="#;">Week</a></li>
					<li id="roommListLi" class="" rel="tabs-3"><a href="#;">Room</a></li>
				</ul>

				<div class="mgt20" style="text-align:center;"><h2 id="dateArea"></h2></div>

				<div class="mgt20" style="text-align:right;margin-right:5px;">
	    			<input type="text" id="choiceDate" class="input_b w100px" readonly="readonly" onchange="fnObj.refreshPage(this.value);"/>
					<a href="#" onclick="$('#choiceDate').datepicker('show');return false;" class="icon_calendar"></a>

				  	<button name="reg_btn" class="btn_b_black mgl20 btn_auth" onclick="fnObj.openRsvPop();">
						<span id="regTxtSpan" style="color:white;">예약하기</span>
					</button>
				</div>


		  	 	 <div class="tab_container mgt10">
					  <div id="tabs-1" class="tab_content">
					  	  <div id="dp" style="padding:10px;"></div>
					  </div>

					  <div id="tabs-2" class="tab_content">

					  	  <div id="weekDateArea" class="fc-toolbar fc-header-toolbar" style="display:none;margin-left: 1.2em;margin-top: 1em;">
					  	  	<div class="fc-left">
					  	  		<div class="fc-button-group">
					  	  			<button type="button" class="fc-prev-button fc-button fc-state-default fc-corner-left" onclick="fnObj.moveWeek('-7');">
					  	  				<span class="fc-icon fc-icon-left-single-arrow"></span>
					  	  			</button>
					  	  			<button type="button" class="fc-next-button fc-button fc-state-default fc-corner-right" onclick="fnObj.moveWeek('+7');">
					  	  				<span class="fc-icon fc-icon-right-single-arrow"></span>
					  	  			</button>
					  	  		</div>
					  	  		<button type="button" id="weekBtn" class="fc-today-button fc-button fc-state-default fc-corner-left fc-corner-right  fc-state-disabled"  style="margin-left: 0.5em;padding:6px;" onclick="fnObj.moveWeek('week');">this Week</button>
					  	  	</div>
					  	  	<div class="fc-right"></div>
					  	  	<div class="fc-clear"></div>
					  	  </div>


					  	  <div id="weekArea" style="padding:10px;"></div>
					  </div>

					  <div id="tabs-3" class="tab_content">

					  	  <div class="fc-toolbar fc-header-toolbar" style="margin-left: 1.2em;margin-top: 1em;">
					  	  	<div class="fc-left">
					  	  		<div class="fc-button-group">
					  	  			<button type="button" class="fc-prev-button fc-button fc-state-default fc-corner-left" onclick="fnObj.moveDate('-1');">
					  	  				<span class="fc-icon fc-icon-left-single-arrow"></span>
					  	  			</button>
					  	  			<button type="button" class="fc-next-button fc-button fc-state-default fc-corner-right" onclick="fnObj.moveDate('+1');">
					  	  				<span class="fc-icon fc-icon-right-single-arrow"></span>
					  	  			</button>
					  	  		</div>
					  	  		<button type="button" id="todayBtn" class="fc-today-button fc-button fc-state-default fc-corner-left fc-corner-right  fc-state-disabled"  style="margin-left: 0.5em;padding:6px;" onclick="fnObj.moveDate('today');">today</button>
					  	  	</div>
					  	  	<div class="fc-right"></div>
					  	  	<div class="fc-clear"></div>
					  	  </div>

						  <div id="containerWrap">
						  	 	<table class="meeting_room_table" style="table-layout:fixed;" >
					  	 		 	<colgroup>
			                            <col width="150" /> <!--회의실명-->
			                            <col width="200" /> <!--시간-->
			                            <col width="*" /> 	<!--등록 일정-->
			                            <col width="100" /> <!--사용자-->
			                            <col width="100" /> <!--등록자-->
			                        </colgroup>
			                        <thead>
			                            <tr>
			                            	<th style="padding:7px;">회의실명</th>
			                            	<th>시간</th>
			                            	<th>등록 일정</th>
			                            	<th>사용자</th>
			                            	<th>등록자</th>
			                            </tr>
			                        </thead>
			                        <tbody id="dataArea"></tbody>
						  	 	</table>
						  	 	<div class="mgt10">* 사용가능 회의실 표시 (바탕 노란색)</div>
				             </div> <!-- containerWrap -->
					  </div>
			 	</div>
			</div>
			<!-- // TAB //  -->
		</div>
 	</div><!-- rightPanel -->

</section>
</body>
</html>



<script type="text/javascript">

//Global variables :S ---------------

//공통코드

var myModal = new AXModal();		// instance
var myGrid = new SGrid();		// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs

var g_sabun ="${baseUserLoginInfo.empNo}";					//로그인유저사번
var g_loginId ="${baseUserLoginInfo.loginId}";				//로그인유저아이디

var g_meetingRoomList =[];				//회의실 리스트
var g_rsvList =[];						//예약 내역 리스트
var g_noRsvList = [];					//예약 불가 리스트

var g_selectRoomId = 0;
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){

		//공통코드
		fnObj.setDatepicker('choiceDate');
		$( "#choiceDate" ).val($.datepicker.formatDate('yy-mm-dd', new Date()));

		fnObj.setDatepicker('rsvDate');
		$( "#rsvDate" ).val($.datepicker.formatDate('yy-mm-dd', new Date()));


	},

	//화면세팅
    pageStart: function(){

    	//-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",
    		//openModalID:"kkkkk",
    		width:850,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		scrollLock: true,
    		displayLoading : false,
            contentDivClass: "popup_outline"
    	});
    	//-------------------------- 모달창 :E -------------------------

    },//end pageStart.

    //회의실 가져오기
    getMeetingRoomList : function(){

    	var url = contextRoot + "/meetingRoom/getMeetingRoomList.do";
    	var param = {
    					orgId 	: '${baseUserLoginInfo.applyOrgId}',
    					enable	: 'Y'

    				};


    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var list = obj.resultList;

    		g_meetingRoomList = list;


    	};
    	commonAjax("POST", url, param, callback, false);

    },

 	//검색
    doSearch: function(){

    	$("#rsvId").val(0);
    	$("#dateArea").html($("#choiceDate").val().replace(/-/gi,'/'));

		var url = contextRoot + "/meetingRoom/getMeetingRoomRsvList.do";
    	var param = {
    					choiceDate 		: $("#choiceDate").val(),
    					meetingRoomId 	: '',
    					orgId 			: '${baseUserLoginInfo.applyOrgId}',
    				};


    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var list = obj.resultList;


    		for(var i=0;i<list.length;i++) {

    			//내가 쓴게 아니면 어떠한 이벤트도 불가 처리
    			if(list[i].createdBy != '${baseUserLoginInfo.userId}'){
    				list[i].resourceEditable = false;
        			list[i].editable = false;
        			list[i].startEditable = false;
        			list[i].durationEditable = false;
        			list[i].className ='other_rsv_div';


    			}else{
    				list[i].resourceEditable = true;
        			list[i].editable = true;
        			list[i].startEditable = true;
        			list[i].durationEditable = true;

    			}


    		}

    		g_rsvList = list ;			//전역변수로 예약내역리스트 담아둠

    	 	var str ='';
    		var rowCount = 0;
    		var beforeMeetingRoomId =0;


    		var now = new Date();
    		var nowTime = fillzero(now.getHours(), 2) + '' +fillzero(now.getMinutes(), 2) + '' +fillzero(now.getSeconds(), 2);


    		//회의실 리스트 수
    		if(g_meetingRoomList.length>0){
	    		for(var i=0; i<g_meetingRoomList.length;i++){

	    			var meetingRoomId = g_meetingRoomList[i].id;
	    			rowCount = getCountWithValue(list, 'meetingRoomId', meetingRoomId);	//해당일 예약된건(회의실 별)

	    			//회의실이 바뀔때
	    			if(meetingRoomId != beforeMeetingRoomId){

	    				var nowUseCount = 0;
	    				var usedClass ='class="enableUsed"';
	    				str +='<tr>';

	    				for(var k=0;k<list.length;k++){
	    					//지금 시간에 예약 내역이 있는 지 판별
	    					if(meetingRoomId == list[k].meetingRoomId
	    							&&( (list[k].startTime.replace(/:/gi,'')< nowTime &&  nowTime < list[k].endTime.replace(/:/gi,'')) )){

	    						nowUseCount++;
	    					}

	    				}

	    				//예약건이 있다.
	    				if(nowUseCount  != 0) usedClass = 'class="noUsed"';
	    				//오늘이 아니면 무조건 no 처리
	    				if($("#choiceDate").val() != new Date().yyyy_mm_dd() ) usedClass = 'class="noUsed"';

	    	    		str +='<th '+usedClass+' rowspan="'+(rowCount < 3 ? 3 : rowCount)+'"><span >'+g_meetingRoomList[i].title+'</span></th>';

	    			}


	    			var gridCount =0;
	    			for(var k=0;k<list.length;k++){
	    				if(list[k].meetingRoomId == meetingRoomId){
	    					if(gridCount !=0) str +='<tr>';		//새로운 행 추가시

	    					str +='<td>'+list[k].showStartTime+' ~ '+list[k].showEndTime +'</td>';
	                		str +='<td style="text-align:left;">'+list[k].comment;

	                		//수정 삭제 버튼 세팅
	                		if('${baseUserLoginInfo.userId}' == list[k].createdBy) {

	    						str +='<span style="margin-left:10px;"><button class="btn_s_type_g " onclick="fnObj.editSet('+list[k].rsvId+');"><span style="color:#182198;"><strong>수정</strong></span></button> ';
	                			str +='<button class="btn_s_type_g " onclick="fnObj.doDelete('+list[k].rsvId+');"><span style="color:#d22525;"><strong>삭제</strong></span></button> <span>';

	                		}


	                		str +='</td>';
	                		str +='<td>'+list[k].rsvUserNm+'</td>';
	                		str +='<td>'+list[k].regNm+'</td>';
	                		str +='</tr>';

	                		gridCount++;
	    				}
	    			}

	    			var emtpyCount =0;

	    			//default 3 row
	    			if(gridCount <3){
	    				for(var k=0;k<3-gridCount;k++){
	        				if(emtpyCount !=0) str +='<tr>';

	        				str +='<td>  .</td>';
	                   		str +='<td>  .</td>';
	                   		str +='<td>  .</td>';
	                   		str +='<td>  .</td>';
	                   		//str +='<td colspan="3">예약된 내역이 없습니다.</td>'
	                   		str +='</tr>';

	                   		emtpyCount++;

	        			}
	        		}

	    			beforeMeetingRoomId =  g_meetingRoomList[i].id;
	    		}
    		}else{
    			str+='<tr><td colspan="5">등록된 회의실이 없습니다.</td></tr>';
    		}

    		$("#dataArea").html(str);

    		$(".fc-resource-cell").mouseover(function(){

    	    	var top =  $(this).offset().top-$(".con_titleZone").offset().top +40 ;
    	    	var left = $(this).position().left + ($(this).width()/2)-60;

    	    	$("#infoMeetingRoom").css({'top':top, 'left':left});

    	    	var roomObj = getRowObjectWithValue(g_meetingRoomList,'id',$(this).attr("data-resource-id"));

    	    	if(roomObj!=null){
    	    		$("#descriptionArea").html(roomObj.description);
    	        	$("#locationArea").html(roomObj.meetingRoomLocation);
    	        	$("#infoMeetingRoom").show();

    	    	}
    	   });

			$(".fc-resource-cell").mouseout(function(){
				$("#infoMeetingRoom").hide();
    	   });

    	};
    	commonAjax("POST", url, param, callback, false);

    },//end doSearch

  	//예약 저장
    doSave : function(fStartTime,fEndTime,fRsvDate,fMeetingRoomId){  //시작 시간, 종료시간, 예약일, 미팅룸 아이디

    	var rsvChk = 'true';

    	//매개 변수가 undefined  일 경우는  예약 하기 버튼으로 접근시

    	var selectRoomId = (fMeetingRoomId == undefined ? $("#selectRoomId").val() : fMeetingRoomId);
    	var startTime = (fStartTime == undefined ? $("#startTime").val() : fStartTime);
    	var endTime =  (fEndTime == undefined ? $("#endTime").val() : fEndTime);
    	var rsvDate = (fRsvDate == undefined ? $("#rsvDate").val() : fRsvDate);
    	var rsvType = $("input:radio[name=rsvType]:checked").val();
    	var comment = ( rsvType == 'schedule' ? $("#scheTitle").val() : $("#comment").val());
    	var scheduleId = $("#scheduleId").val();
    	var rsvId = $("#rsvId").val();

    	if(fStartTime  == undefined){	//예약하기 버튼으로 접근시에만 예약 가능 여부 판별하면 된다.
    		rsvChk = fnObj.chkSelectRoom(rsvDate,startTime,endTime,selectRoomId,rsvId);
    	}

    	if(rsvChk == 'false'){
    		alert("이미 예약건이 존재합니다.");
    		return;
    	}

    	if( rsvType == 'schedule' && scheduleId == '0'){	//스케줄 선택시

    		alert("일정을 선택해 주세요");
    		return;
    	}

    	if(endTime < startTime ) {
    		alert("시작 시간과 종료시간을 확인해주세요");
    		$("#startTime").focus();
    		return;
    	}

    	var url = contextRoot + "/meetingRoom/doSaveRsvMeetingRoom.do";
    	var param = {
    					startDate 		: rsvDate,
    					endDate 		: rsvDate,
    					startTime		: startTime,
    					endTime			: endTime,
    					scheduleId		: scheduleId,
    					comment			: comment,
    					rsvUserId		:  '',
    					meetingRoomId 	: selectRoomId,
    					rsvId			: rsvId
    				};


    	var callback = function(result){


    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;

    		if(cnt>0){
    			$("#rsvId").val(0);
    			alert("저장되었습니다.");
    			$("#useUserId").val('');

        		//재 그리드
        		$('#choiceDate').val(rsvDate);
        		fnObj.doSearch();

        		$('#dp').fullCalendar( 'gotoDate', rsvDate );		//해당 날짜로이동

    		}else{
    			alert("실패 하였습니다.");
    		}

    		$('#dp').fullCalendar( 'removeEvents' );
            $('#dp').fullCalendar( 'addEventSource', g_rsvList);
            $('#dp').fullCalendar( 'refetchEvents' );



    	};

    	commonAjax("POST", url, param, callback, false);
    },

    //삭제
    doDelete : function(rsvId){


    	if(!confirm("삭제 하시겠습니까?")) return;

    	var rsvId = (rsvId >0 ? rsvId :$("#rsvId").val());

    	var url = contextRoot + "/meetingRoom/doDeleteRsvMeetingRoom.do";
    	var param = {
    					rsvId			: rsvId
    				};


    	var callback = function(result){

    		$("#rsvId").val(0);

			fnObj.refreshPage('1'); //리프레쉬
    	};

    	commonAjax("POST", url, param, callback, false);
    },

   	//calendarGrid set
   	setCalendarGrid : function(selectDate){

		$('#dp').fullCalendar({

			schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
			defaultView: 'agendaDay',
			defaultDate: selectDate,
			editable: true,
			selectable: true,
			eventLimit: true, 				//더보기 갯수
			minTime : '08:00:00',			//표시최소시간
			maxTime : '22:00:00',			//표시최대시간
			allDaySlot : false,				//하루종일 사용 여부
			slotEventOverlap: false,		//겹침 사용 (시간중복시 오버랩 사용여부)
			nowIndicator : true,			//현재시간 표시
			lazyFetching : false,

			selectOverlap: function(event) {					//신규 drag 겹칠때 return
		        return;
		    },

		    eventOverlap: function(stillEvent, movingEvent) {	//drag 이동 겹칠때 return
		        return;
		    },

			header: {
				left: 'prev,next today',	//왼쪽 <> today 버튼
				center: '',			//title 표시
				right: ''			//month,agendaWeek,agendaDay,listWeek 등 등
			},

			views: {
				agendaTwoDay: {
					type: 'agenda',
					duration: { days: 2 },
					groupByDateAndResource : true,	//그룹 표시
					eventLimit: 1 ,

				}
			},

			titleFormat:'YYYY/MM/DD',		// 타이틀 포맷 형식
			smallTimeFormat : 'HH시',
			timeFormat: 'HH:mm',
			contentHeight: 580,				// 높이 -- 지정가능
			aspectRatio : 1,				// 달력의 너비와 높이의 종횡비를 결정 숫자가 클수록 높이가 낮아짐

			//-- 데이터 셋 S

			resources: g_meetingRoomList, 	// 컬럼 리스트  ... ex> { id: 'b', title: 'Room B', eventColor: 'green' },

		    eventSources: [ {overlap : false, events: g_rsvList} ],  //view List  [{ id: '1', resourceId: '31', start: '2017-03-07T17:00:00', end: '2017-03-07T18:00:00', title: 'event 1' } ],

 			//-- 데이터 셋 E

 			selectHelper: true,

 			//-- 이벤트 설정 관련 : S

 			//날짜 변경 로딩 시 이벤트
 			viewRender: function(view,element){

				var moment = $('#dp').fullCalendar('getDate');
				$( "#choiceDate" ).val(moment.format().split('T')[0]);
				$("#dateArea").html($("#choiceDate").val().replace(/-/gi,'/'));
				fnObj.doSearch();

				$('#dp').fullCalendar( 'removeEvents' );
	            $('#dp').fullCalendar( 'addEventSource', g_rsvList);
	            $('#dp').fullCalendar( 'refetchEvents' );


			},

 			//선택 이벤트 - selectable
 			select: function(start, end, jsEvent, view, resource) {
				var startArr = start.format().split('T');
				var endArr = end.format().split('T');

				if(startArr.length>1 && endArr.length>1){
					var selectDate = startArr[0];
					var startTime = startArr[1];
					var endTime = endArr[1];

					//예약 가능 여부 판별
					var result = fnObj.chkSelectRoom(selectDate,startTime,endTime,resource.id);

					if(result == 'true'){

						g_selectRoomId = resource.id;
						fnObj.openRsvPop(selectDate,startTime,endTime,resource.id);
						$('#dp').fullCalendar('unselect');

					}

				}else{
					alert('선택 오류 !!');
				}

 			},

 			//데이터 클릭 시
 			eventClick: function(event) {
 				if(event.createdBy == '${baseUserLoginInfo.userId}'){
	 				var selectDate =event.startDate;
	 				var startTime = event.startTime;
	 				var endTime =event.endTime;
	 				var meetingRoomId =event.meetingRoomId;

	 				$("#rsvId").val(event.rsvId);
	 				$("#scheduleId").val(event.scheduleId);

	 				var eventObj = {scheduleId : event.scheduleId , comment : event.comment, userId :event.rsvUserId };

	 				fnObj.openRsvPop(selectDate,startTime,endTime,meetingRoomId,event.rsvId,JSON.stringify(eventObj));		//수정 창
 				}

 			},

			// div 이동 시
 			eventDrop : function(event, delta, revertFunc) {

 				var newMeetingNm = getRowObjectWithValue(g_meetingRoomList, 'id', event.resourceId).title;	//새로운 미팅룸
 				var meetingNm = getRowObjectWithValue(g_meetingRoomList, 'id', event.meetingRoomId).title;	//저장 미팅룸

 				var startTime = ((event.start.format()).split("T")[1]).substring(0,5);

 				if (!confirm(event.comment+' : '+meetingNm+' ('+event.showStartTime+') -> ' +newMeetingNm+' ('+startTime+') 로 변경하시겠습니까?')) {
 		            revertFunc();
 		        }else{

 		        	var chk = 'true';

 		        	var rsvDate = (event.start.format()).split("T")[0];
 		        	startTime = (event.start.format()).split("T")[1];
 		        	//console.log(event.end)
 		        	var endTime = (event.end.format()).split("T")[1];
 		        	var rsvId = event.rsvId;

 		        	if(fnObj.chkSelectRoom(rsvDate,startTime,endTime,event.resourceId,rsvId) == 'false'){
 		        		revertFunc();
 		        	}else{
 		        		$("#rsvId").val(rsvId);
 		        		$("#scheduleId").val(event.scheduleId);

 	 		       		//시작 시간, 종료시간, 예약일, 미팅룸 아이디
 	 		       		fnObj.doSave(startTime,endTime,rsvDate,event.resourceId); //변경 사항 저장 .
 		        	}

 		        }

 		    },

 		    //div 늘리기 or 줄이기
 		    eventResize : function(event, delta, revertFunc) {

 			    var startTime = ((event.start.format()).split("T")[1]).substring(0,5);
				var endTime = ((event.end.format()).split("T")[1]).substring(0,5);

				if (!confirm(event.comment+' : ('+event.showStartTime+' ~ '+event.showEndTime+' -> ' +startTime+' ~ '+endTime+') 로 변경하시겠습니까?')) {
		            revertFunc();
		        }else{

		        	var chk = 'true';

 		        	var rsvDate = (event.start.format()).split("T")[0];
 		        	startTime = (event.start.format()).split("T")[1];
 		        	endTime = (event.end.format()).split("T")[1];

 		        	var rsvId = event.rsvId;

 		        	if(fnObj.chkSelectRoom(rsvDate,startTime,endTime,event.resourceId,rsvId) == 'false'){
 		        		revertFunc();

 		        	}else{
 		        		$("#rsvId").val(rsvId);
 		        		$("#scheduleId").val(event.scheduleId);
 	 		       		//시작 시간, 종료시간, 예약일, 미팅룸 아이디
 	 		       		fnObj.doSave(startTime,endTime,rsvDate,event.resourceId); //변경 사항 저장 .
 		        	}


		        }

		    }

 		 	//-- 이벤트 설정 관련 : E
		});
   	},

   	//해당 룸의 사용 예약이 있는지 판별
   	chkSelectRoom : function(selectDate,startTime,endTime,meetingRoomId,rsvId){

   		var rslt = 'false';

   		var url = contextRoot + "/meetingRoom/getMeetingRoomRsvList.do";
    	var param = {
    					choiceDate 		: selectDate,
    					meetingRoomId 	: (meetingRoomId == undefined || meetingRoomId == ''  ? '' : meetingRoomId) ,
    					enable			: 'Y',
    					rsvStartTime	: startTime.split(':')[0]+':'+startTime.split(':')[1]+':01',
    					rsvEndTime		: endTime,
    					rsvId			: (rsvId == undefined || rsvId == ''  ? '' : rsvId)
    				};


    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var list = obj.resultList;

    		if(meetingRoomId == '' || meetingRoomId == undefined) g_noRsvList = list;		//전체 검색건만 불가능한 회의실리스트 세팅

    		if(list.length == 0){		//예약 가능
    			rslt = 'true';
    		}

    	}

    	commonAjax("POST", url, param, callback, false);

    	return rslt;

   	},

	//수정 팝업(회의실 별 에서 클릭시)
   	editSet : function(rsvId){

   		$("#rsvId").val(rsvId);


   		var rsvObj =  getRowObjectWithValue(g_rsvList, 'rsvId', rsvId);


		$("#scheduleId").val(rsvObj.scheduleId);

		var eventObj = {scheduleId : rsvObj.scheduleId , comment : rsvObj.comment, userId :rsvObj.rsvUserId };

		fnObj.openRsvPop(rsvObj.startDate, rsvObj.startTime, rsvObj.endTime, rsvObj.meetingRoomId, rsvId,JSON.stringify(eventObj));		//수정 창

   	},


   	//예약 하기 팝업
   	openRsvPop : function(selectDate,startTime,endTime,meetingRoomId,rsvId,eventObj){

   		var param ={
   					selectDate	:	selectDate == undefined ? $("#choiceDate").val() : selectDate,
   					startTime	:	startTime,
   					endTime		:	endTime,
   					meetingRoomId:	meetingRoomId,
   					rsvId		:	rsvId,
   					eventObj	:	eventObj

   		}

   		var url =contextRoot+"/meetRoom/meetRoomRsvReg/pop.do";
   		myModal.open({
    		url: url,
    		pars: param,
    		titleBarText: '회의실예약',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: 200,
 	   		width: 550,
 	   		displayLoading : false,
    		closeByEscKey: true				//esc 키로 닫기
    	});


   		$('#myModalCT').draggable();
   	},



  	//예약 가능 룸 리스트 가져오기
   	enableRsvRoomList : function(){

   		fnObj.chkSelectRoom($("#rsvDate").val(),$("#startTime").val(),$("#endTime").val(),'',$("#rsvId").val());	  //사용불가 미팅룸 리스트

   		var enableRsvRoomList = [];

   		for(var i=0;i<g_meetingRoomList.length;i++){

   			if(getCountWithValue(g_noRsvList, 'meetingRoomId', g_meetingRoomList[i].id) == 0){
   				enableRsvRoomList.push(g_meetingRoomList[i]);
   			}
   		}


   		//meetingRoomArea 회의실 셀렉트 박스 생성

  		var roomSelectTag = createSelectTag('selectRoomId', enableRsvRoomList, 'id', 'title', g_selectRoomId, '', '', 'height:26px;width:150px;margin-right:10px;');
  		$("#meetingRoomArea").html(roomSelectTag);
  		$("#meetingRoomArea").show();

  		$("#selectRoomId").focus();

   	},


  	//datepicker 설정
    setDatepicker : function(obj){
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
    },

    //<> 버튼으로 이동시 (day)
    moveDate : function(value){

    	var nt = new Date($("#choiceDate").val());

    	if(value !='today') nt.setDate(nt.getDate() + parseInt(value)); // <>
    	else nt = new Date();			//today

    	var moveResult = nt.yyyy_mm_dd();
    	$("#choiceDate").val(moveResult);


    	//today 버튼 비활성화
    	if(moveResult == new Date().yyyy_mm_dd()) $("#todayBtn").addClass('fc-state-disabled');
    	else  $("#todayBtn").removeClass('fc-state-disabled');

    	$("#dateArea").html(moveResult.replace(/-/gi,'/'));

		fnObj.doSearch();


		$('#dp').fullCalendar( 'removeEvents' );
   		$('#dp').fullCalendar( 'addEventSource', g_rsvList);
        $('#dp').fullCalendar( 'refetchEvents' );

        $('#dp').fullCalendar( 'gotoDate', $("#choiceDate").val());		//해당 날짜로이동
    },

    //<> 버튼으로 이동시 (week)
    moveWeek : function(value){

    	$("#weekDateArea").show();

    	if(value == 'week'){
    		$("#choiceDate").val(new Date().yyyy_mm_dd());
    		value =0;

    	}

    	var selectDate = $("#choiceDate").val(); //기준일

    	var dateArr = selectDate.split('-');
    	var year = dateArr[0];
        var month = dateArr[1];
        var day = dateArr[2];
    	var nowSelectDate = new Date(year, month-1, day);

    	nowSelectDate.setDate(nowSelectDate.getDate()+parseInt(value));			//시작 날짜 세팅

     	var intDayCnt1 = 0;
        var intDayCnt2 = 0;

        var i = nowSelectDate.getDay(); //기준일의 요일을 구한다.( 0:일요일, 1:월요일, 2:화요일, 3:수요일, 4:목요일, 5:금요일, 6:토요일 )


        if ((i > 0) && (i < 7)) { //기준일이 월~토 일때
            intDayCnt1 = 1 - i;
            intDayCnt2 = 7 - i;

        }else if (i == 0) {  	//기준일이 일요일일때
            intDayCnt1 = -6;
            intDayCnt2 = 0;
        }
        //기준일의 주의 월요일의 날짜와 토요일의 날짜
        var startDate = new Date(nowSelectDate.getFullYear(), nowSelectDate.getMonth(), nowSelectDate.getDate() + intDayCnt1);
        var endDate =  new Date(nowSelectDate.getFullYear(), nowSelectDate.getMonth(), nowSelectDate.getDate() + intDayCnt2);


        fnObj.getWeekRsvList(startDate,endDate);

        if(value != 0) $("#choiceDate").val(startDate.yyyy_mm_dd());


       // endDate =  new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate() + 4);

        $("#dateArea").html(startDate.yyyy_mm_dd().replace(/-/gi,'/')+' ~ '+ endDate.yyyy_mm_dd().replace(/-/gi,'/'));

      	//week 버튼 비활성화


      	//같은 주인지 판별
      	if(startDate.getFullYear() ==  new Date().getFullYear() && yearOfWeekNum(startDate) == yearOfWeekNum(new Date())) $("#weekBtn").addClass('fc-state-disabled');
    	else  $("#weekBtn").removeClass('fc-state-disabled');

    },

    //일주일 데이터
    getWeekRsvList : function(startDate,endDate){


        var url = contextRoot + "/meetingRoom/getMeetingRoomRsvList.do";

    	var param = {
				startDate 		: startDate.yyyy_mm_dd(),
				endDate 		: endDate.yyyy_mm_dd(),
				meetingRoomId 	: '',
				orgId 			: '${baseUserLoginInfo.applyOrgId}',
			};


		var callback = function(result){
			var obj = JSON.parse(result);
    		var list = obj.resultList;

    		g_rsvList = list;

    		var week = new Array("일", "월", "화", "수", "목", "금", "토");

    		var str = '<table class="meeting_room_week_table">';
    		str += '<colgroup>';
    		str += '<col width="100">';
    		str += '<col width="100">';
    		str += '<col width="100">';
    		str += '<col width="100">';
    		str += '<col width="100">';
    		str += '<col width="100">';
    		str += '<col width="100">';

    		str += '</colgroup>';
    		str += '<thead>';
    		str += '<tr>';
    		for(var i=0;i<7;i++){
    			var dateSet = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate() + i);
    			var weekNum = dateSet.getDay();


    			var color="black";

    			if(weekNum == 6) color="#2727ef";	//토
    			if(weekNum == 0) color="#f33737";	//일



    			str += '<th onclick="fnObj.openRsvPop(\''+dateSet.yyyy_mm_dd()+'\');"><strong style="color:'+color+';">'+week[weekNum]+'</strong> ('+(dateSet.yyyy_mm_dd()).replace(/-/gi,'/')+')';
    			str += '<i class="axi axi-plus-square mgl10" style="cursor:pointer;"></i></th>';
    		}
    		str += '</tr>';
    		str += '</thead>';

    		str += '<tbody>';
    		str += '<tr>';
    		if(list.length>0){
	    		for(var i=0;i<7;i++){

	    			//str += '<td>';

	    			//비교날짜
	    			var curDate =  (new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate() + i)).yyyy_mm_dd();

	    			str += '<td '+(curDate == new Date().yyyy_mm_dd() ? 'style="background:#fffae3;"':'')+'>';

	    			for(var k=0;k<list.length;k++){

	    				if(list[k].startDate == curDate){

	    					str += '<div ';

	    					if(list[k].createdBy == '${baseUserLoginInfo.userId}'){
	    						str += 'class="myDiv" onclick="fnObj.editSet('+list[k].rsvId+');" style="cursor:pointer;">';
	    					}else{
	    						str += ' class="rsvDiv">';
	    					}



	    					str += '<div><i class="axi axi-clock-o mgr5"></i><strong>'+list[k].showStartTime+' ~ '+list[k].showEndTime;
	    					str += '</strong></div>';
	    					str += '<div><strong style="color:'+list[k].titleColor+'">'+list[k].meetingRoomNm;
	    					str += '</strong></div>';
	    					str += '<div>'+list[k].title;
	    					str += '</div>';
	    					str += '</div>';
	    				}
	    			}

		    		str += '</td>';

	    		}
			}else  str += '<td colspan="7">데이터가 존재 하지 않습니다.</td>';

    		str += '</tr>';
    		str += '</tbody>';
    		str += '</table>';
    		$("#weekArea").html(str);

		};

		commonAjax("POST", url, param, callback, false);

    },

    //새로고침
    refreshPage : function(rsvDate){

    	if($("#weekListLi").hasClass('current')){
    		if(rsvDate !=1) $('#choiceDate').val(rsvDate);
    		fnObj.moveWeek(0);

    	}else{

    		if(rsvDate == '1'){
	    		//재 그리드
	    		$('#choiceDate').val();

	    		fnObj.doSearch();

	    		$('#dp').fullCalendar( 'removeEvents' );
	            $('#dp').fullCalendar( 'addEventSource', g_rsvList);
	            $('#dp').fullCalendar( 'refetchEvents' );

	    	}else{
	    		//재 그리드
	    		$('#choiceDate').val(rsvDate);
	    		fnObj.doSearch();

	    		$('#dp').fullCalendar( 'gotoDate', rsvDate );		//해당 날짜로이동

	    		$('#dp').fullCalendar( 'removeEvents' );
	            $('#dp').fullCalendar( 'addEventSource', g_rsvList);
	            $('#dp').fullCalendar( 'refetchEvents' );
	    	}
    	}

    }


    /* ====================================== 화면 세팅 관련 : E ===================================*/


    //################# else function :E #################
};//end fnObj.



function top_menu_new(sUrl, frame) {

	if (frame=="mainFrame") {
		parent.mainFrame.location.href = sUrl;
	}else if (frame == "leftFrame") {
		parent.leftFrame.location.href = sUrl;
	}
}


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();		//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.getMeetingRoomList();	//회의실 리스트 가져오기

 	$(".tab_content").hide();
    $(".tab_content:first").show();

    $("ul.tabZone_st03 li").click(function () {
        $("ul.tabZone_st03 li").removeClass("current");
        $(this).addClass("current");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()

        if(activeTab!='tabs-2')fnObj.moveDate(0);		//싱크 맞춰주기위해
        else fnObj.moveWeek(0);

    });



    fnObj.doSearch();

    fnObj.setCalendarGrid(new Date().yyyy_mm_dd());



});
</script>