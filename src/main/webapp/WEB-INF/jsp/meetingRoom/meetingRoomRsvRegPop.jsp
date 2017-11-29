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

.height25{
	height:25px !important;
}

</style>

<input type="hidden" id="scheduleId" value="0"/>
<input type="hidden" id="rsvId" value="0"/>


<div class="mo_container">
	
	<table class="tb_basic_left">
		<colgroup>
	       <col width="30%">
	       <col width="*">
	    </colgroup>
	    <tr>
	       	<th>사용 날짜</th>
	       	<td>
	            <input type="text" id="rsvDate" class="input_b w100px" readonly="readonly"/>
				<a href="#" onclick="$('#rsvDate').datepicker('show');return false;" class="icon_calendar"></a>
			</td>
	    </tr>
	    <tr>
		   	<th>사용자</th>
		   	<td><span id="userArea"></span></td>
	    </tr>
	    <tr>
	    	<th>사용시간</th>
	    	<td> <span id="timeArea"></span></td>
	    </tr>
	    <tr>
	       	<th>사용목적</th>
	       	<td>
	            <label><input type="radio" name="rsvType" value="schedule" checked onclick="fnObj.selectRsvType('schedule');"/>일정 선택</label>
				<label><input type="radio" name="rsvType" value="doWrite" onclick="fnObj.selectRsvType('doWrite');"/>직접 입력</label>
				<input type="hidden" id="scheTitle"/>
				
				<!-- 일정선택 시 보여지는 화면 -->
				<div id="scheduleArea" class="mgt10" style="display:none;">
					<div id="scheTitleArea" class="input_b w200px height25" style="float:left;"  onclick="fnObj.getScheduleList(this);"></div>
				
					<button type="button" class="btn_s_type_g mgl10" style="margin-top:1px;" onclick="fnObj.refreshField('schedule');"><em class="p_reset">초기화</em></button>
					
					
					<div id="scheduleListArea" style="box-shadow: 2px 2px 2px 0px grey;display:none; position:absolute;left: 145px;;width:70%;height: expression( this.scrollHeight > 99 ? 200px : auto ); border:1px solid #cccccc;  background-color:white; z-index:10000;">
						<div id="content" class="content" style="padding: 20px;"></div>
						<div class="mgb10" style="text-align:center;"><button type="button" class="btn_s_type_g " onclick='$("#scheduleListArea").hide();'>닫기</button></div>
					</div>
				</div>
				<!-- //일정선택 시 보여지는 화면// -->
		
				<!-- 직접입력 시 보여지는 창 -->
				<div id="doWriteArea" class="mgt10"  style="display:none;">
					<input type="text" id="comment" class="input_b w200px height25"/>
					<button type="button" class="btn_s_type_g mgl6" onclick="fnObj.refreshField('doWrite');"><em class="p_reset">초기화</em></button>
				</div>
	            <!-- //직접입력 시 보여지는 창// -->
	        </td>
	        </tr>
	        <tr>
	       		<th>회의실</th>
	       		<td><span id="meetingRoomArea" style="display:none;" ></span><!-- 회의실 셀렉트박스 --></td>
	        </tr>
	              
	</table>

	<div class="btn_baordZone2">
		<a id="rsvBtn" class="btn_blueblack btn_auth" href="javascript:fnObj.doSave();">예약</a>
		<a id="delBtn" class="btn_grayline btn_auth" href="javascript:fnObj.doDelete();" style="display:none;">삭제</a>
	</div>	
	
</div>


<script type="text/javascript">

//Global variables :S ---------------

//공통코드

var myGrid = new SGrid();		// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs

var g_sabun ="${baseUserLoginInfo.empNo}";					//로그인유저사번
var g_loginId ="${baseUserLoginInfo.loginId}";				//로그인유저아이디

var g_meetingRoomList =[];				//회의실 리스트
var g_rsvList =[];						//예약 내역 리스트
var g_noRsvList = [];					//예약 불가 리스트 

var g_selectRoomId = 0;


var g_rsvId='${rsvId}';
var g_eventObjStr = '${eventObj}';
var g_eventObj ;
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
		
		
		
		//-- 직원 셀렉트 세팅 : S
   		
   		var userList = getCodeInfo(null,"","",null, null, null,'/common/getStaffListNameSort.do', {applyOrgId : '${baseUserLoginInfo.applyOrgId}' , mainYn : 'Y' , deptOrder : 'Y'});
		var userSelectTag = createSelectTag('userUserId', userList, 'userId', 'usrNm','${baseUserLoginInfo.userId}', '', '', '','select_b w_date' );		
   		
		$("#userArea").html(userSelectTag);
		
		//-- 직원 셀렉트 세팅 : E	
		
		fnObj.selectRsvType('schedule');
		parent.myModal.resize();
	
	},
	
	//화면세팅
    pageStart: function(){
    	
    	$("#rsvDate").val('${selectDate}');
    	
    	if(g_rsvId =='undefined' || g_rsvId==0 || g_rsvId=='' ){	//신규 등록건
			$("#delBtn").hide();
			$("#delBtn").hide();
			
			
			
		}else{
			
			if(g_eventObjStr !='undefined'){
	  			g_eventObj = JSON.parse(g_eventObjStr);
	  			$("#scheduleId").val(g_eventObj.scheduleId);
	  			if(g_eventObj.scheduleId == 0){
		  			$("#comment").val(g_eventObj.comment);
		  			$("input:radio[name=rsvType][value=doWrite]").trigger("click");
		  		
		  		}else{
		  			$("#scheTitle").val(g_eventObj.comment);
		  			$("#scheTitleArea").html(g_eventObj.comment);
		  			$("input:radio[name=rsvType][value=schedule]").val("schedule");
		  		}
	  			$("#userUserId").val(g_eventObj.userId);
			
			}
	  		
	  		$("#rsvId").val(g_rsvId);
	  		
	  		$("#delBtn").show();
	  		$("input:radio[name=rsvType]:checked").trigger("click");
		}
    	
    	
		//-- 시간 셀렉트 박스 세팅 : S
   		var endTime ='${endTime}';
   		var startTime ='${startTime}';
   		
		if(endTime == 'undefined' || endTime == null || endTime == '') endTime='09:00:00';
   		var timeArr = [];
   		
   		for(var i=8;i<22;i++){
   			
   			var timeStr = fillzero(i,2);	//2자리로 맞춘다
   			
   			timeArr.push({id : timeStr+':00:00' , name : timeStr+':00'});
   			timeArr.push({id : timeStr+':30:00' , name : timeStr+':30'});
   		}
   		
   		timeArr.push({id : '22:00:00' , name : '22:00'});
   																								//fnObj.enableRsvRoomList();
   		var startTimeSelectTag = createSelectTag('startTime', timeArr, 'id', 'name', startTime, 'fnObj.setEndTime();', '', '','select_b w_date');
   		var endTimeSelectTag = createSelectTag('endTime', timeArr, 'id', 'name', endTime, '', '', '','select_b w_date');
   		
   		$("#timeArea").html(startTimeSelectTag+' ~ '+endTimeSelectTag);
   		
   		//-- 시간 셀렉트 박스 세팅 : E
   		
   		
		
		g_selectRoomId ='${meetingRoomId}';
    	
    	
    	
    },//end pageStart.
   
 	//검색
    doSearch: function(){ 
    	
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
    	
    	if(selectRoomId == null){
    		alert("회의실을 선택해주세요.");
    		return;
    	}
    	
    	if(rsvChk == 'false'){
    		alert("이미 예약건이 존재합니다.");
    		return;
    	}
    	
    	if( rsvType == 'schedule' && scheduleId == '0'){	//스케줄 선택시
    		
    		alert("일정을 선택해 주세요");
    	//	$("#scheTitle").focus();
    		return;
    	}
    	
    	if(endTime <= startTime ) {
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
    					rsvUserId		: fStartTime  == undefined ? $("#userUserId").val() : '',	//예약하기 팝업에서만 변경가능
    					meetingRoomId 	: selectRoomId,
    					rsvId			: rsvId
    				};
    	
    	
    	var callback = function(result){
    		
    		
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;	
    		
    		if(cnt>0){
    			alert("저장되었습니다.");
    			
    			parent.myModal.close();
    			parent.fnObj.refreshPage(rsvDate);
        		
        	}else{
    			alert("실패 하였습니다.");
    		}
    		
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
    		
    		parent.myModal.close();
    		parent.fnObj.refreshPage('1');
    		
    		
    	};
    	
    	commonAjax("POST", url, param, callback, false);
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
   	
   	
  
   	//--------------------- 레이어 팝업 함수 : S
   	

   	setEndTime : function(){
   		var newEndTime = '';
   		var endTime = parseInt($("#startTime").val().split(':')[0])+1;
   		
   		if(endTime > 21) newEndTime ='22:00:00';
   		else newEndTime = fillzero(endTime,2)+':'+$("#startTime").val().split(':')[1]+':00';
   		$("#endTime").val(newEndTime);
   		
   		fnObj.enableRsvRoomList();
   	},
   	
   	//라디오 버튼 선택
   	selectRsvType : function(value){
   		
   		$('#scheduleListArea').hide();
   		
   		if(value == 'schedule'){
   			$('#doWriteArea').hide();
   			fnObj.refreshField('doWrite');
   			
   		}else if(value == 'doWrite'){
   			
   			$('#scheduleArea').hide();
   			fnObj.refreshField('schedule');
   			
   		}else{
   			
   			$("input:radio[name=rsvType]").prop("checked",false);
   			$('#doWriteArea').hide();
   			$('#scheduleArea').hide();
   			fnObj.refreshField('all');
   		}
   		$('#'+value+'Area').show();
   		
   		
   	},
   	
   	//초기화
   	refreshField : function(value){
   		
   		if(value == 'schedule'){		//스케쥴 영역 초기화
   			$("#scheTitle").val('');
   			$("#scheTitleArea").html('');
   			$("#scheduleId").val(0);
   			
   		}else if(value == 'doWrite'){							//직접입력 영역 초기화 
   			$('#comment').val('');
   			
   			
   		}else{
   			
   			$("#scheTitle").val('');
   			$("#scheduleId").val(0);
   			$("#scheTitleArea").html('');
   			$('#comment').val('');
   		}
   		
   	},
   	
   	//스케줄 가져오기
   	getScheduleList : function(){
   		var dateArr = $("#rsvDate").val().split('-');
   		
   		var param = {
   				 userId 	: $("#userUserId").val(),
      			 selectDate	: $("#rsvDate").val(),
      			 selectYear	: parseInt(dateArr[0]),
      			 selectMonth: parseInt(dateArr[1]),
      			 selectDay	: parseInt(dateArr[2]),
      	};

    	var url = contextRoot+"/meetingRoom/getScheduleList.do";
    	
		var callback = function(result){
    		
    		var obj = JSON.parse(result);
    		var list = obj.resultList;	
    		var str = '';
    		
    		str = '<table class="car2Popup_tb_st">';

			str += '<colgroup>';
			str += '<col width="40%" />';
			str += '<col width="*" />';
			str += '</colgroup>';
			
			str += '<thead>';
			str += '<tr>';
			str += '<th><strong>날짜</strong></th>';
			str += '<th><strong>내용</strong></th>';
			str += '</tr>';
			str += '</thead>';
			
			str += '<tr>';
    		
    		//일정이 없음.
    		if(list.length == 0){
    			
    			str += '<td colspan="2"><strong>해당 일에 일정이 없습니다.</strong></td></tr>';
        		
    		}else{
    			
    			
    			
    			
    			for(var i=0;i<list.length;i++){
    				
    				var scheObj = list[i];
    				var endTimeClass ='';
    				
    				//날짜가 같지 않을때 강조
    				if(scheObj.scheEDate != scheObj.scheSDate){
    					endTimeClass ='otherDay';
    				}
    				
    				str += '<tr onclick="fnObj.timeChk(\''+scheObj.scheSDate +'\',\''+scheObj.scheEDate+'\',\''+scheObj.startTime+'\',\''+scheObj.endTime+'\',\''+scheObj.scheSeq+'\',\''+scheObj.scheTitle+'\');">';
    				str += '<td>'+scheObj.startTime+' ('+fillzero(scheObj.scheSMonth,2)+'/'+fillzero(scheObj.scheSDay,2)+ ') ' ;
    				str +=  '<br/> ~ '  ;
    				str += scheObj.endTime+'<span class="'+endTimeClass+'"> ('+fillzero(scheObj.scheEMonth,2)+'/'+fillzero(scheObj.scheEDay,2)+') </span>' +' </td>';
    				
    				
    				str += '<td>'+scheObj.scheTitle+' </td>';
    				str += '</tr>';
    			}
    			str += '</table>';
    		}
    		
    		$("#content").html(str);
    		
    		
    		$("#scheduleListArea").css({display:""});
	    	
    		
    	}
   		
    	commonAjax("POST", url, param, callback, false);
   		
   	},
   	
   	//일정 선택시 
   	timeChk : function(scheSDate,scheEDate,startTime,endTime,scheSeq,scheTitle){
   		
   		if(confirm("일정의 시간으로 사용 시간을 변경하시겠습니까?")){
   			
   			if(parseInt((startTime).split(':')[0]) > 21 || parseInt((endTime).split(':')[0]) > 21){
   				
   				alert("오후 10 시 이후의 일정은 일정의 시간으로 예약 할 수 없습니다.");
   				return;
   				
   			}else if(scheEDate != scheSDate){
   	   			
   				alert("일정 시작일과 종료일이 달라 시작시간 + 1시간으로 종료시간이 세팅됩니다.");
   	   			$("#startTime").val(startTime+':00');
   	   			
   	   			var setEndTime = fillzero(parseInt(startTime.split(':')[0]) + 1,2) +':'+ startTime.split(':')[1]+ ':00' ;
   	   			if(parseInt(startTime.split(':')[0]) + 1 > 21){
   	   				setEndTime = '22:00:00';
   	   			}
   	   			
   	   			$("#endTime").val(setEndTime);
   	   			
   	   		}else{
   	   			
   	   			$("#startTime").val(startTime+':00');
   	   			$("#endTime").val(endTime+':00');
   	   			
   	   		}	
   		}
   		
   		
   		$("#scheduleId").val(scheSeq);
   		$("#scheTitle").val(scheTitle);
   		$("#scheTitleArea").html(scheTitle);
   		$("#scheduleListArea").hide();
   		
   		fnObj.enableRsvRoomList();
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
  		 
  		var roomSelectTag = createSelectTag('selectRoomId', enableRsvRoomList, 'id', 'title', g_selectRoomId, '', '', '없음','select_b mgr20');	
  		$("#meetingRoomArea").html(roomSelectTag);
  		$("#meetingRoomArea").show();
  		
  		$("#selectRoomId").focus();
   		
   	},
   	
  	//--------------------- 레이어 팝업 함수 : E
   	
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
    
  
    /* ====================================== 화면 세팅 관련 : E ===================================*/
    
   
    //################# else function :E #################
};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.doSearch();
	fnObj.pageStart();		//화면세팅
	fnObj.enableRsvRoomList();	 //회의실 리스트 세팅 
		
    
    
    
 	
});
</script>