<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<link href='${pageContext.request.contextPath}/css/fullCalendar/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/css/fullCalendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='${pageContext.request.contextPath}/css/fullCalendar/scheduler.min.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/js/fullCalendar/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/js/fullCalendar/fullcalendar.js'></script>
<script src='${pageContext.request.contextPath}/js/fullCalendar/scheduler.min.js'></script>


<style type="text/css">

.wtime{
	width:6em;
}

.wMeet{
	width:10.8em;
}

#containerWrap {
    padding: 0px 9px 9px 9px;
}

 #container {
    width: 249px;
    margin: 0 auto;
}


.fc-widget-header{height:30px;}

</style>


<body>

<div id="containerWrap" style="margin:10px;">
	<strong class="mgt10" style="font-size:16px;font-weight:bold;">회의실 예약내역 <span class="mgr10">(${fn:replace(choiceDate,'-','/')})</span></strong>
	<div id="dataArea"></idv>    
	
</div> <!-- containerWrap -->	

		
	
</body>


<script type="text/javascript">

var g_meetingRoomList = [];
var g_rsvList = [];

var fnObj = {
		
		//################# init function :S #################
		
		//선로딩코드
		preloadCode: function(){
			
		},
		
		//화면세팅
	    pageStart: function(){
	    	
	    
	    	
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
	    	
	    	
	    	
			var url = contextRoot + "/meetingRoom/getMeetingRoomRsvList.do";
	    	var param = {
	    					choiceDate 		: '${choiceDate}',
	    					meetingRoomId 	: ''
	    				};
	    	
	    	
	    	var callback = function(result){
	    		
	    		var obj = JSON.parse(result);
	    		var list = obj.resultList;	
	    	
	    		g_rsvList = list ;			//전역변수로 예약내역리스트 담아둠
	    	
	    	};
	    	commonAjax("POST", url, param, callback, false);
	    	
	    },//end doSearch
	    
	    
	  	//calendarGrid set
	   	setCalendarGrid : function(selectDate){
	   		
			$('#dataArea').fullCalendar({
				
				schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
				defaultView: 'agendaDay',
				defaultDate: '${choiceDate}',
				editable: false,
				selectable: false,
				eventLimit: true, 				//더보기 갯수
				minTime : '08:00:00',			//표시최소시간
				maxTime : '22:00:00',			//표시최대시간
				allDaySlot : false,				//하루종일 사용 여부
				slotEventOverlap: false,		//겹침 사용 (시간중복시 오버랩 사용여부)
				lazyFetching : false,
				
			
				header: {
					left: '',	//왼쪽 <> today 버튼 
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
				aspectRatio : 2.3,				// 달력의 너비와 높이의 종횡비를 결정 숫자가 클수록 높이가 낮아짐
				
				//-- 데이터 셋 S
				
				resources: g_meetingRoomList, 	// 컬럼 리스트  ... ex> { id: 'b', title: 'Room B', eventColor: 'green' }, 
				
			    eventSources: [ {overlap : false, events: g_rsvList} ],  //view List  [{ id: '1', resourceId: '31', start: '2017-03-07T17:00:00', end: '2017-03-07T18:00:00', title: 'event 1' } ],	
	 			
	 			//-- 데이터 셋 E
	 			
	 			selectHelper: true,
	 			
			});
	   	},
	    

};



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.getMeetingRoomList();
	fnObj.doSearch();
	fnObj.setCalendarGrid();
	
});

</script>