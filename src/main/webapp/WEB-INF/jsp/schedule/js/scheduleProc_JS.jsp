<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="js/sp/synergy_util.js"></script>

<script type="text/javaScript" language="javascript">
var g_meetingRoomList = [];	//전체회의실 리스트
var g_noRsvList =[];		//불가능한 회의실리스트 세팅
var contextRoot="${pageContext.request.contextPath}";
var myModal = new AXModal();    // instance

	//var divisionList = [];      //디비전 리스트

	$(document).ready(function () {
	    $(window).load(function() {

	        //디비전 리스트 가져오기
	       // divisionList= getCodeInfo(null,null,null,null,null,null,"/common/getDivisionList.do",{userId : '${baseUserLoginInfo.userId}'});
	        //참조인 전체선택 체크박스 세팅

	       /*  for(var i=0;i<divisionList.length;i++){
	            var htmlStr = '';
	            htmlStr += '<label><input type="checkbox" name="Entry" id="Entry" class="Entry_'+divisionList[i].divCode+'" onclick="javascript:SelAll(this.name, ' + i + ', \'' + divisionList[i].divCode + '\');"/>';
	            htmlStr += '전체선택('+divisionList[i].divName + ')</label>';
	            $('#'+divisionList[i].divCode+"_div").html(htmlStr);        // 전체선택 체크박스
	        }
 */


	        myModal.setConfig({
	            windowID:"myModalCT",
	            width:800,
	            mediaQuery: {
	                mx:{min:0, max:720}, dx:{min:720}
	            },
	            displayLoading:true,
	            scrollLock: true,
	            onclose: function(){
	            }
	            ,contentDivClass: "popup_outline"
	        });
 			var projectId = "${param.projectId}";
 			var eventType = "${vo.eventType}";
 			if(projectId!=""&&eventType!="Edit"){
 				$("#projectId").val("${param.projectId}").change();

 				$("#activityId").val("${param.activityId}").change();
 			}

	    });


	  	//-- 시간 셀렉트 박스 세팅 : S

   		var timeArr = [];

   		for(var i=8;i<22;i++){

   			var timeStr = fillzero(i,2);	//2자리로 맞춘다

   			timeArr.push({id : timeStr+':00:00' , name : timeStr+':00'});
   			timeArr.push({id : timeStr+':30:00' , name : timeStr+':30'});
   		}

   		timeArr.push({id : '22:00:00' , name : '22:00'});
   																								//fnObj.enableRsvRoomList();
   		var startTimeSelectTag = createSelectTag('meetStartTime', timeArr, 'id', 'name', '', 'setMeetingRoomList("Y");', '', '60','select_b type');
   		var endTimeSelectTag = createSelectTag('meetEndTime', timeArr, 'id', 'name', '', 'setMeetingRoomList("Y");', '', '60','select_b type');

   		$("#useTimeArea").html('<strong style="margin-left:10px;">사용시간 : </strong>'+startTimeSelectTag+' ~ '+endTimeSelectTag);


	    getMeetingRoomList();		//회의실 리스트 가져오기

	    if($('#eventType').val() == 'Add') scheDateSet();
        else  ScheInfoSet();


	    $('input:checkbox[name=CarUseFlagChk]').click(function() {
	        if($('input[name="AllTime"]').is(":checked")) {
	            TimeChange('sTime', 'AM8:30');
	            TimeChange('eTime', 'PM6:00');
	        }
	        else {
	            TimeChange('sTime', $('#sTime').val());
	            TimeChange('eTime', $('#eTime').val());
	        }
	        if($('input:checkbox[name=CarUseFlagChk]:checked').val() == 'Y') {
	        	$('#trCarNum').show();
	        	$('#divCarNum').show();
	        }else{
	        	$('#trCarNum').hide();
	        	$('#divCarNum').hide();
	        }
	    });

	    if('${vo.eventType}' == 'Add' || ('${vo.eventType}' == 'Edit' && !('${vo.procFlag}' == 'after' || '${vo.procFlag}' == 'all'))) {
	        $('#scheSDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	        $('#scheEDate').datepicker(E_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});

	        $('#scheSDate').datepicker("option", "onClose", function ( selectedDate ) {
	        	if(selectedDate != $('#scheEDate').val()){
	                $('input:radio[name="ScheRepetFlag"]:input[value="None"]').attr("checked", true);
	                $('input:radio[name="ScheRepetFlag"]').attr("disabled",true);
	            } else if($('#eventType').val() == 'Add'){
	                $('input:radio[name="ScheRepetFlag"]').attr("disabled",false);
	            }
		      });

	        $('#scheEDate').datepicker("option", "onClose", function ( selectedDate ) {
	        	if(selectedDate != $('#scheSDate').val()){
	                $('input:radio[name="ScheRepetFlag"]:input[value="None"]').attr("checked", true);
	                $('input:radio[name="ScheRepetFlag"]').attr("disabled",true);
	            } else if($('#eventType').val() == 'Add'){
	                $('input:radio[name="ScheRepetFlag"]').attr("disabled",false);
	            }
		      });
	    }

	    if('${vo.eventType}' == 'Add'){
	    	setProject();  //업무구분 셋팅
	        //setActivity('${scheVO.projectId}');  //활동구분 셋팅
	    }

	    if('${meetRsvRoleEnable}' == 0) $(".meetingAreaGroup").hide();




	});

	// 선택시간 차량 사용여부 받아오기
	function carListChk() {
	    /* $("#searchScheSTime").val($('#scheSTime').val());
	    $("#searchScheETime").val($('#scheETime').val()); */
	    $("#searchScheSTime").val($('#sTime').val());
        $("#searchScheETime").val($('#eTime').val());

	    $('#scheduleProc').attr('action', contextRoot + "/CarListChk.do");
	    commonAjaxSubmit("POST", $("#scheduleProc"), CarListChkCallback);
	}

	function CarListChkCallback(result){
        var list = result.resultList;
        var strHtml = "";
        strHtml += '<ul class="com_car_list">';
        if(list.length == 0){
        	strHtml += '<li>';
            strHtml += '<dl class="car_num">';
            strHtml +=  '등록가능한 차량이 없습니다.';
            strHtml += '</dl>';
            strHtml += '</li>';
        }else{
            for(var k=0;k<list.length;k++){
            	strHtml += '<li>';
                strHtml += '<dl class="car_num">';
                strHtml += '<dt>';
                if(isEmpty(list[k].carImage)){
                    strHtml += '<img src="<c:url value='/images/eam/car.jpg'/>" />';
                }else{
                    strHtml += '<img src="data:image/png;base64,' + list[k].carImage + '" />';
                }
                strHtml += '</dt>';
                if($("#scheCarId").val() == list[k].carId) {
                    strHtml += '<dd><label><input type="radio" id="carId"  name="carId"  value="'+list[k].carId+'" checked/>'+list[k].carNumber+'</label></dd>';
                }else if(list[k].carUseFlag == 'Y' && list[k].scheSeq == $('#scheSeq').val()) {
                    strHtml += '<dd><label><input type="radio" id="carId"  name="carId"  value="'+list[k].carId+'"/>'+list[k].carNumber+'</label></dd>';
                }else if(list[k].carUseFlag == 'N'){
                    strHtml += '<dd><label><input type="radio" id="carId"  name="carId"  value="'+list[k].carId+'"/>'+list[k].carNumber+'</label></dd>';
                }
                /* else{
                    strHtml += '<dd><label><input type="radio" id="carId"  name="carId"  value="'+list[k].carId+'" disabled/>'+list[k].carNumber+'</label></dd>';
                } */
                strHtml += '</dl>';
                strHtml += '</li>';
            }
        }

        strHtml += '</ul>';

        $('#divCarNum').empty();
        $('#divCarNum').html(strHtml);
    }

	// 선택일자 차량 사용 리스트
	function carUseList() {
	    $('#scheduleProc').attr('action', contextRoot + "/CarUseList.do");

	    //일정보기 ajax 호출
	    commonAjaxSubmit("POST", $("#scheduleProc"), carUseListCallback);
	}
	function carUseListCallback(result){
		var list = result.resultList;
		var strHtml = ""
		if(list.length == 0){
			strHtml +=  '<tr>';
			strHtml +=  '    <td class="car_num" colspan="3">등록 내역이 없습니다.</td>';
			strHtml +=  '</tr>';
		}else{
			for(var k=0;k<list.length;k++){
	            strHtml +=  '<tr>';
	            strHtml +=  '    <td class="car_num">'+list[k].carNumber+'</td>';
	            strHtml +=  '    <td class="car_member"><span>'+list[k].perNm+'</span></td>';  //<em>(차장)</em>
	            strHtml +=  '    <td class="car_time">'+list[k].sTime+' ~ '+list[k].eTime+'</td>';
	            strHtml +=  '</tr>';
	        }
		}

		$("#tableCarUseList tbody").empty();
	    $("#tableCarUseList tbody").html(strHtml);
	    $("#caruseMemberList").show();
	    //showlayer("carUseLlistArea");
	}
	function hideCaruseMemberList(){
		$("#caruseMemberList").hide();
	}

	// 일정 등록시 일자 설정
	function scheDateSet() {
	    $('#scheSDate').val($('#scheSDate', parent.document).val());
	    $('#ScheTitle').focus();
	    TimeSet();
	}

	// 일정 수정시 데이터 셋
	function ScheInfoSet() {
	    TimeSet();
	    $('#sTime').val('${scheVO.scheSTime}');
	    $('#eTime').val('${scheVO.scheETime}');

	    if('${scheVO.scheGubun}' == 'All') $('#SMSView').show();
	    else $('#SMSView').hide();

	    if('${scheVO.scheGubun}' == 'Alone') {
	    	$('#spanSecret').show();
	    	if('${scheVO.schePublicFlag}' == 'N'){
                $('#Secret').attr('checked', true);
            }
            $('#EntryView').hide();
        }else{
        	$('#spanSecret').hide();
        	$('#EntryView').show();
        }

        if('${scheVO.schePublicFlag}' == 'Y'){
        	$('input:checkbox[name="Secret"]').attr("checked", false);
        }else{
        	$('input:checkbox[name="Secret"]').attr("checked", true);
        }

	    if('${scheVO.scheAllTime}' == 'Y') {
	        $('#scheAllTime').val("Y");
	        $('#sTime').hide();
	        $('#eTime').hide();
	        $('input[name="AllTime"]').attr("checked", true);
	    }
	    $('input:checkbox[name="CarUseFlagChk"]:input[value="${scheVO.carUseFlag}"]').attr("checked", true);
	    if('${scheVO.carUseFlag}' == 'Y') {
	    	$('#trCarNum').show();
	        $('#divCarNum').show();
	        $('#carId').val('${scheVO.carId}');
	    }

	  	var title  = ' <c:out value="${scheVO.scheTitle}"/>';
	  	var scheArea  = '${scheVO.scheArea}';

	    $('#ScheTitle').val(title.replace(/&lt;/g, '<').replace(/&gt;/g,'>'));
	    $('#ScheArea').val(scheArea.replace(/&lt;/g, '<').replace(/&gt;/g,'>'));
	    $('#scheSDate').val('${scheVO.scheSDate}');
	    $('#scheEDate').val('${scheVO.scheEDate}');
	    $('#selDate').val('${scheVO.scheSDate}');
	    $('#ScheAlarmFlag').val('${scheVO.scheAlarmFlag}');
	    $('input:radio[name="ScheRepetFlag"]:input[value="${scheVO.scheRepetFlag}"]').attr("checked", true);

	    if('${scheVO.scheAlarmHow}' == 'None'){
	    	$("input:checkbox[id='ScheAlarmHowCheck']").attr("checked",false);
	    	$('#AlarmHow').attr("disabled",true);
            $('#ScheAlarmFlag').attr("readonly",true);
	    }else{
	    	$("input:checkbox[id='ScheAlarmHowCheck']").attr("checked",true);
	    	$('#AlarmHow').attr("disabled",false);
	    	$('#AlarmHow').val('${scheVO.scheAlarmHow}');
            $('#ScheAlarmFlag').attr("readonly",false);
	    }

       $('#ScheAlarmHow').val('${scheVO.scheAlarmHow}');

	    //중요도 체크
	    chkScheImportant('${scheVO.scheImportant}');

	    //세부내용 세팅
	    <% pageContext.setAttribute("newLine","\r\n");%>
        $('#ScheCon').val('<c:out value="${fn:replace(scheVO.scheCon, newLine, 'NNNEEEWWW')}"/>');
        var contTmp = $('#ScheCon').val();
        $('#ScheCon').val(contTmp.split('NNNEEEWWW').join('\n').replace(/&lt;/g, '<').replace(/&gt;/g,'>'));
        $('#tmpCpnNm').val('${scheVO.companyNm}');
        $('#tmpCpnId').val('${scheVO.companyId}');
        $('#tmpCstNm').val('${scheVO.customerNm}');
        $('#tmpCstId').val('${scheVO.customerId}');

        $('#scheSDate').datepicker("option", "minDate", $("#activityStartDate").val());

        //반복설정 셋팅
        schePeriodChk();


        //회의실 세팅
        if('${meetingRoomChk}'>0){
        	$("#meetingRoomUseFlag").prop("checked",true);
        	$("#rsvId").val('${meetingRoom.rsvId}');
        	$("#meetStartTime").val('${meetingRoom.startTime}');
        	$("#meetEndTime").val('${meetingRoom.endTime}');

        	setMeetingRoomList("N");
        	$('#meetRoomRsvArea').show();

        	$("#selectRoomId").val('${meetingRoom.meetingRoomId}');
        }
        // 휴가관련 일정이면  참여자 선택 불가, 고객/회사 선택 불가
        if('${scheVO.vacationYn}' == 'Y'){
        	/* $("#sTime").attr("disabled",true);
            $("#eTime").attr("disabled",true); */
            entrySet("Alone");
            $("#CstView").hide();
        }
    }
    // 일정 시간 설정
    function TimeSet() {
        for(var Hour = 0; Hour < 24; Hour++) {
            for(var Min = 0; Min < 2; Min++) {
                if(Hour >= 12) {
                    Hh = Hour;
                    Color = '#e4e7ec';
                }
                else {
                    Hh = Hour;
                    Color = '#fff';
                }
                if(Hh < 10) Hh = "0" + Hh;

                if(Min == 0) Mm = ':00';
                else Mm = ':30';

                var Now = new Date();
                var SHh = Now.getHours();
                var EHh = Now.getHours() + 1;

                if(SHh == Hour) {
                    $('#sTime').append("<option value='"+ Hh + Mm+"' style='background:"+Color+";' selected>"+Hh + Mm+"</option>");
                    if('${scheVO.scheSeq}' == '') {
                        $('#scheSTime').val(Hh + Mm);
                    }
                    else {
                        $('#scheSTime').val('${scheVO.scheSTime}');
                    }
                }
                else $('#sTime').append("<option value='" + Hh + Mm+"' style='background:"+Color+";'>"+Hh + Mm+"</option>");

                if(EHh == Hour) {
                    $('#eTime').append("<option value='" + Hh + Mm+"' style='background:"+Color+";' selected>"+Hh + Mm+"</option>");
                    if('${scheVO.scheSeq}' == '') {
                        $('#scheETime').val(Hh + Mm);
                    }
                    else {
                        $('#scheETime').val('${scheVO.scheETime}');
                    }
                }
                else {
                    $('#eTime').append("<option value='"+ Hh + Mm+"' style='background:"+Color+";'>"+Hh + Mm+"</option>");
                }
            }
        }
    }

    // 종일일정 설정
    function AllTimeSet() {
        if($('input[name="AllTime"]').is(":checked")) {
            $('#scheAllTime').val("Y");
            $('#scheSTime').val('08:30');
            $('#scheETime').val('18:00');
            $('#sTime').hide();
            $('#eTime').hide();
        }
        else {
            $('#scheAllTime').val("N");
            $('#scheSTime').val('');
            $('#scheETime').val('');
            $('#sTime').show();
            $('#eTime').show();
        }
        carListChk();
    }

    //화면에서 일정 시작시간 변경시
    function changeStartTime(Obj, Val){
        $('#Sche'+Obj+'AMPM').val(Val.substr(0, 2));
        $('#Sche'+Obj).val(Val.substr(2));

    	var sTime = $('#sTime').val();
    	var eTime = $('#eTime').val();
    	var sTimeArr =sTime.split(":");

    	if(sTime == "23:00"){
    		eTime = "23:30";
    	}else if(sTime == "23:30"){
    		eTime = "23:30";
    	}else{
    		var eTimeTemp = parseInt(sTimeArr[0]) + 1;
    		if(eTimeTemp < 10) eTimeTemp = "0" + eTimeTemp;
    		eTime = eTimeTemp + ":" + sTimeArr[1];
    	}
        $("#eTime").val(eTime);
        TimeChange('eTime', eTime);
    }

    // 일정시간 변경
    function TimeChange(Obj, Val) {
        var EAP = '', ET = '', EM = '';
        $('#Sche'+Obj+'AMPM').val(Val.substr(0, 2));
        $('#Sche'+Obj).val(Val.substr(2));
        carListChk();
        changeScheTime();
    }

    // 기간에 따른 반복 여부
    function schePeriodChk() {
    	if($("#procFlag").val() == "alone"){
    		$('input:radio[name="ScheRepetFlag"]:input[value="None"]').attr("checked", true);
               $('input:radio[name="ScheRepetFlag"]').attr("disabled",true);
    	}else if($("#procFlag").val() == "after" || $("#procFlag").val() == "all"){
               $('input:radio[name="ScheRepetFlag"]').attr("disabled",true);
           }else{
    		if($('#scheSDate').val() != $('#scheEDate').val()){
                $('input:radio[name="ScheRepetFlag"]:input[value="None"]').attr("checked", true);
                $('input:radio[name="ScheRepetFlag"]').attr("disabled",true);
            } else {
                $('input:radio[name="ScheRepetFlag"]').attr("disabled",false);
            }
    	}
		//수정일때 반복여부는 무조건 비활성화
    	if($('#eventType').val() != 'Add') {
    		$('input:radio[name="ScheRepetFlag"]').attr("disabled",true);
    	}

        carListChk();
    }

 	// 참가자 활성화 작업
    function entrySet(Val) {
        if(Val == "All") {
            $('#schePublicFlag').val('Y');
            $('#EntryView').show();     //참가자 활성화
        }else {
        	$('#EntryView').hide();    //참가자 비활성화
            //참가자 초기화
            var usrHtml = '';
            usrHtml += '<span class="employee_list" >';
            usrHtml += '<strong>${baseUserLoginInfo.userName}</strong>(${baseUserLoginInfo.deptNm})';
            usrHtml += '<input type="hidden" name="arrPerSabun" id="arrPerSabun" value="${baseUserLoginInfo.empNo}"/>';
            usrHtml += '<input type="hidden" name="arrRecieveUserId" id="arrRecieveUserId" value="${baseUserLoginInfo.userId}"/>';
            usrHtml += '</span>';
            $("#spanEmpNmList").html(usrHtml);
        }
    }

 	//----회의실 추가 건 : S

 	// 선택일자 회의실 현황(회의실 팝업)
	function meetingRoomRsvList() {
		var choiceDate = $('#scheSDate').val();
		URL = contextRoot + '/meetingRoomListPop.do?choiceDate='+ choiceDate ;
		var w = '700';
		var h = '650';
		var ah = screen.availHeight - 30;
		var aw = screen.availWidth - 10;
		var xc = (aw - w) / 2;
		var yc = (ah - h) / 2;
		var option = "left=" + xc
		+",top=" + yc
		+",width=" + w
		+",height=" + h

		window.open(URL, 'meetingRoomList', option);
	}

    //회의실 클릭
    function  clickMeetUse(){
    	setMeetingRoomList("Y");
        if($('input:checkbox[name=meetingRoomUseFlag]:checked').val() == 'Y') {
        	$('#meetRoomRsvArea').show();
        	changeScheTime();

        }else{
        	$('#meetRoomRsvArea').hide();
        	$("#ScheArea").val('');

        }

    }

	//스케쥴 시간변경시
	function changeScheTime(){
		//시간 세팅
		var scheStart = $("#sTime").val();
		var scheEnd = $("#eTime").val();

		var startTime = parseInt(scheStart.replace(/:/gi,''));
		var endTime = parseInt(scheEnd.replace(/:/gi,''));

		//스케쥴이 다른날
		if($("#scheSDate").val() != $("#scheEDate").val()){
			endTime = parseInt(startTime)+100;
		}

		//8시 이전 일경우 8 시로
		if(startTime<800) startTime=800;
		if(endTime<=800) endTime=900;

		//10시 이후일 경우 9시로
		if(startTime>2200) startTime=2200;
		if(endTime>2200) endTime=2200;

		if((startTime)>(endTime)){
			alert("시간을 다시 확인해주세요.");
			$("#sTime").focus();
			return;
		}

		startTime = fillzero(startTime,4);
		endTime = fillzero(endTime,4);


		startTime = startTime.substring(0,2)+':'+startTime.substring(2,4)+':00';
		endTime = endTime.substring(0,2)+':'+endTime.substring(2,4)+':00';

		$("#meetStartTime").val(startTime);
  		$("#meetEndTime").val(endTime);

  		setMeetingRoomList("Y");
	}

 	//회의실 가져오기
    function getMeetingRoomList(){

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

    }


	//회의실 세팅
	function setMeetingRoomList(scheAreaSetYn){
		$('#meetRoomSelectDiv').empty();
		meetingRoomChk('',$("#meetStartTime").val(),$("#meetEndTime").val(),$("#rsvId").val());		//미팅룸 리스트 조회

		//사용가능 회의실 세팅
		var enableRsvRoomList = [];
   		for(var i=0;i<g_meetingRoomList.length;i++){
   			if(getCountWithValue(g_noRsvList, 'meetingRoomId', g_meetingRoomList[i].id) == 0){
   				enableRsvRoomList.push(g_meetingRoomList[i]);
   			}
   		}

   		if(enableRsvRoomList.length==0){
   			enableRsvRoomList.push({'id':'','title':'회의실없음'});
   		}

   		var roomSelectTag = createSelectTag('selectRoomId', enableRsvRoomList, 'id', 'title', '', 'setArea();', '', '','select_b type');
	  	$("#meetRoomSelectDiv").html(roomSelectTag);

  		if('${meetRsvRoleEnable}' != 0 && $("#selectRoomId").val() !='' && scheAreaSetYn == 'Y'){
  			setArea();
  		}
	}

	function setArea(){
		if($('input:checkbox[name=meetingRoomUseFlag]:checked').val() == 'Y'){
			$("#ScheArea").val($("#selectRoomId :selected").text());
		}
	}

	//회의실 사용가능 체크
	function meetingRoomChk(meetingRoomId,startTime,endTime,rsvId){

		var rslt = false;

		var url = contextRoot + "/meetingRoom/getMeetingRoomRsvList.do";

    	var param = {
    					choiceDate 		: $("#scheSDate").val(),
    					meetingRoomId 	: (meetingRoomId == undefined || meetingRoomId == ''  ? '' : meetingRoomId) ,
    					enable			: 'Y',
    					rsvStartTime	: startTime.split(':')[0]+':'+startTime.split(':')[1]+':01',
    					rsvEndTime		: endTime,
    					rsvId			: (rsvId == undefined || rsvId == '' || rsvId == 0  ? '' : rsvId)
    				};


    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var list = obj.resultList;

    		if(meetingRoomId == '' || meetingRoomId == undefined) g_noRsvList = list;		//전체 검색건만 불가능한 회의실리스트 세팅

    		if(list.length == 0){		//예약 가능
    			rslt = true;
    		}

    	}

    	commonAjax("POST", url, param, callback, false);

    	return rslt;
	}


    //----회의실 추가 건 : E

    function SelAll(Obj, idx, divCd) {          //idx ... division list index ... 0:'SYNERGY', 1:'FIDES'        divCd...  'SYNERGY', 'FIDES'
        var All = $($('input:checkbox[name='+Obj+']')[idx]);
        var ChkList = $('input[name='+Obj+'Ary]');
        var DelList = $('input[name='+Obj+'DelAry]');

        if(!All.is(':checked')) {// 전체선택 체크박스가 해제되었다면
            for(var i=0; i<ChkList.length; i++) {
                if('${baseUserLoginInfo.empNo}' == ChkList[i].value|| !$(ChkList[i]).hasClass(divCd)) continue; //본인제외
                ChkList[i].checked = false;
                DelList[i].value = "Y";             //체크해제
            }
        }
        else { // 그게 아니라면
            for(var i=0; i<ChkList.length; i++) {
                if(!$(ChkList[i]).hasClass(divCd)||'${baseUserLoginInfo.empNo}' == ChkList[i].value) continue;//본인제외
                ChkList[i].checked = true;          // 모든 체크박스를 체크
                DelList[i].value = "N";             //체크
            }
        }
    }

    // 참가자 개별선택
    function OneSel(Obj) {
        if($('#'+Obj).is(':checked')) $('#'+Obj.replace("Ary", "DelAry")).val("N");
        else $('#'+Obj.replace("Ary", "DelAry")).val("Y");
    }

    // 알림발생시기 설정
    function AlarmChk() {
    	if($("input:checkbox[id='ScheAlarmHowCheck']").is(":checked")){
               $('#AlarmHow').attr("disabled",false);
               $('#ScheAlarmFlag').attr("readonly",false);
           }else{
           	$('#AlarmHow').attr("disabled",true);
           	$('#ScheAlarmFlag').attr("readonly",true);
           }
    }

    // 일정 등록/수정 완료
    function ScheduleProcEnd() {
        var ToNum_tmp, index_tmp, cnt = 0;

        if(!($("#eventType").val() == 'Edit' && $("#scheGrpCd").val() != '' && $("#scheGrpCd").val() != 'Period' && $("#procFlag").val() != 'alone')){
        	if($('#scheAllTime').val() == 'N') {
        		$('#scheSTime').val($('#sTime').val());
        		$('#scheETime').val($('#eTime').val());
            }
        }

        var strScheSDateFull = $('#scheSDate').val() + $('#scheSTime').val();
        var strScheEDateFull = $('#scheEDate').val() + $('#scheETime').val();

		if(strScheSDateFull > strScheEDateFull){
		    alert("기간 시작일시가 종료일시보다 이후 입니다.");
		    $('#scheSDate').focus();
		    return;
		}

		if($('#projectId option:selected').val() == "undefined" || $('#projectId option:selected').val() == "") {
            alert('${baseUserLoginInfo.projectTitle}을/를 선택하셔야 합니다.');
            $('#projectId').focus();
            return;
        }
        if($('#activityId option:selected').val() == "undefined" || $('#activityId option:selected').val() == "") {
            alert('${baseUserLoginInfo.activityTitle}을/를 선택하셔야 합니다.');
            $('#activityId').focus();
            return;
        }

		//일정마감일은 프로젝트와 엑티비티 최종마감일은 이전이여야함
		var lastDate = $('#lastDate').val();
		var projectStartDate = $('#projectStartDate').val();
		var projectEndDate = $('#projectEndDate').val();
		var scheEndDate = $('#scheEDate').val();
		var scheStartDate = $('#scheSDate').val();
		var activityStartDate = $('#activityStartDate').val();
		var activityEndDate = $('#activityEndDate').val();

	    //엑티비티 시작일은 일정시작일보다 이전이여야함
        if(scheStartDate < activityStartDate){
            alert("기간 시작일이 ${baseUserLoginInfo.activityTitle} 기간과 맞지 않습니다.\n기간을 다시 등록해주세요.\n[${baseUserLoginInfo.activityTitle} 기간: "+activityStartDate+" ~ "+activityEndDate+"]");
            $('#scheSDate').focus();
            return;
        }

         //엑티비티 종료일은 일정종료일보다 이후이여야함
         if(scheEndDate > activityEndDate){
        	 alert("기간 종료일이 ${baseUserLoginInfo.activityTitle} 기간과 맞지 않습니다.\n기간을 다시 등록해주세요.\n[${baseUserLoginInfo.activityTitle} 기간: "+activityStartDate+" ~ "+activityEndDate+"]");
        	 $('#scheEDate').focus();
             return;
         }

		/* if((scheEndDate > lastDate) || (projectStartDate > scheStartDate)){
		    alert("기간마감일이 ${baseUserLoginInfo.projectTitle} 기간과 맞지 않습니다.\n기간을 다시 등록해주세요.\n[${baseUserLoginInfo.projectTitle} 기간: "+projectStartDate+" ~ "+lastDate+"]");
		    $('#scheEDate').focus();
		    return;
		} */

        if($('input:checkbox[name=CarUseFlagChk]:checked').val() == 'Y' && $('input:radio[name="carId"]:checked').val() == undefined) {
            alert('차량을 선택해 주세요. \n선택하실 차량이 없으실 경우 차량사용여부의 \'사용함\'의 선택을 해지하여 주세요.');
            return;
        }

        //--회의실 추가
		if($('input:checkbox[name=meetingRoomUseFlag]:checked').val() == 'Y' && ($("#selectRoomId").val() =='' || $("#selectRoomId").val() == null)) {
			alert('회의실을 선택해 주세요');
			$("#selectRoomId").focus();
			return;

		}

		if($('input:checkbox[name=meetingRoomUseFlag]:checked').val() == 'Y'
				&& $("#meetStartTime").val() >= $("#meetEndTime").val()
		) {
			alert('회의실 예약 시간을 확인해주세요');
			$("#meetStartTime").focus();
			return;

		}

		//중복 여부 확인
		if($('input:checkbox[name=meetingRoomUseFlag]:checked').val() == 'Y'){

			if(!meetingRoomChk($("#selectRoomId").val() ,$("#meetStartTime").val() ,$("#meetEndTime").val() ,$("#rsvId").val())){
				alert('이미 예약된 회의실 입니다.');
				$("#selectRoomId").focus();
				return;
			}else{
				$("#meetingRoomId").val($("#selectRoomId").val());
			}

		}

		if( ($('#scheSDate').val() != $('#scheEDate').val() || $('input:radio[name="ScheRepetFlag"]:checked').val() != 'None')
				&& $('input:checkbox[name="meetingRoomUseFlag"]:checked').val()== 'Y'){

			alert("반복이나 기간일정은 회의실 예약이 불가하여, 회의실 예약 설정은 취소됩니다.");

			$('input:checkbox[name=meetingRoomUseFlag]').prop("checked",false);

		}


        var frm = document.scheduleProc;
        var activityId = $('#activityId option:selected').val();

        if($('#ScheTitle').val() == "") {
            alert('제목을 입력하셔야 합니다.');
            $('#ScheTitle').focus();
            return;
        }

        if($('#arrPerSabun').size() == 0){
            alert('참가자가 없습니다. 선택해주시기 바랍니다.');
            return;
        }

        if($('#ScheAlarmFlag').val() == "") {
               alert('알람발생 시점을 입력하셔야 합니다.');
               $('#ScheAlarmFlag').focus();
               return;
           }

        $('#scheSYear').val($('#scheSDate').val().split('-')[0]);
        $('#scheSMonth').val($('#scheSDate').val().split('-')[1]);
        $('#scheSDay').val($('#scheSDate').val().split('-')[2]);
        $('#scheEYear').val($('#scheEDate').val().split('-')[0]);
        $('#scheEMonth').val($('#scheEDate').val().split('-')[1]);
        $('#scheEDay').val($('#scheEDate').val().split('-')[2]);

        if($("input:checkbox[id='ScheAlarmHowCheck']").is(":checked")){
        	$('#ScheAlarmHow').val($('#AlarmHow').val());
           }else{
           	$('#ScheAlarmHow').val("None");
           }

        //공개여부
        if($("input:checkbox[id='Secret']").is(":checked")){
             $('#schePublicFlag').val("N");
         }else{
         	$('#schePublicFlag').val("Y");
         }

        if($('#scheSDate').val() != $('#scheEDate').val()){
        	$('#schePeriodFlag').val('Y');
        }else{
        	$('#schePeriodFlag').val('N');
        }

        //차량사용여부
        if($('input:checkbox[name=CarUseFlagChk]:checked').val() == 'Y'){
        	$("#CarUseFlag").val("Y");
        }else{
        	$("#CarUseFlag").val("N");
        	$('input:radio[name="carId"]').removeAttr("checked");
        }

        //현지출근여부
        if($('input:checkbox[name=attendYnChk]:checked').val() == 'Y'){
            $("#attendYn").val("Y");
        }else{
            $("#attendYn").val("N");
        }

        $("#scheduleProc").attr("action", "<c:url value='/schedule/getChkSchedulePerson.do'/>");
        commonAjaxSubmit("POST",$("#scheduleProc"),getChkSchedulePersonCallback);
    }
  	//대결자 / 동행자 체크 콜백
    function getChkSchedulePersonCallback(data){
        if(data.resultObject.result =="SUCCESS"){
        	$('input:radio[name="ScheRepetFlag"]').attr("disabled",false);
        	if($('#eventType').val() == 'Add') {
                $('#scheduleProc').attr('action', "<c:url value='/ScheduleAddEnd.do'/>");
            }else{
                $('#eventType').val("Edit");
                $('#scheduleProc').attr('action', "<c:url value='/ScheduleEditEnd.do'/>");
            }
        	commonAjaxSubmit("POST", $("#scheduleProc"), saveScheduleProcCallback);
        }else{
            if(data.resultObject.msg != null){
            	if(data.resultObject.msgType == "CONFIRM"){
            		if(confirm(data.resultObject.msg)){
            			$('input:radio[name="ScheRepetFlag"]').attr("disabled",false);
                        if($('#eventType').val() == 'Add') {
                            $('#scheduleProc').attr('action', "<c:url value='/ScheduleAddEnd.do'/>");
                        }else{
                            $('#eventType').val("Edit");
                            $('#scheduleProc').attr('action', "<c:url value='/ScheduleEditEnd.do'/>");
                        }
                        commonAjaxSubmit("POST", $("#scheduleProc"), saveScheduleProcCallback);
            		}else{
            			return;
            		}
            	}else{
            		alert(data.resultObject.msg);  // 참가자로 지정하신 ... 병가/휴직 ... 참가자로 지정할 수 없습니다.
            		return;
            	}


            }
        }
    }

    //일정 등록/수정후 콜백
    function saveScheduleProcCallback(result){
    	if(result.result == "SUCCESS"){
            alert("정상적으로 저장되었습니다.");
            try{
            	opener.parent.openPageReload();
            }catch(exception){
            	window.opener.openPageReload();
            	//opener.location.reload();
            }
            window.close();
        }else if(result.result == "FAIL"){
            alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        }else{
        	alert(result.result);
        }
    }

    // 수정취소
    function ScheView() {
        $('#eventType').val("View");
        $('#scheduleProc').attr('action', "<c:url value='/ScheduleView.do'/>").submit();
    }

    //제목 자동생성 호출
    function setAutoMakeTitle(){
        var form = document.scheduleProc;
        var title = '';
        //회사
        var cpV = $('#tmpCpnNm').val();
        if(cpV.trim().length > 0){
            title += $('#tmpCpnNm').val() + ' ';                        //회사정보 ( 회사명 )
        }
        var csV = $('#tmpCstNm').val();
        if(csV.trim().length > 0){
            title += $('#tmpCstNm').val() + ' ';                        //인물정보 ( 인물명 )
        }
        // $('#ScheTitle').val(title); //제목  2016.11.21 이인희  제목 자동생성 안함
        $('#ScheCon').val(title);   //내용에도 추가
    }

    //인물, 회사 선택 된것 화면에 추가
    function returnPopUp(rVal){
        var flag = rVal.f
        var nm = rVal.nm
        var num = rVal.n;

        if(flag=='c'){
            var tmpSpan = document.createElement("span");
            tmpSpan.innerHTML = rVal.nm;

            var cpnNm = $(tmpSpan).text();      //위에서 임시로  span 을 만들어 내부에 테그를포함한 회사명을 넣어놓고 text()로 텍스트만 뽑아낸다.
            var cpnId = rVal.snb;

            $('#tmpCpnNm').val(cpnNm);      //회사명 표시
            $('#tmpCpnId').val(cpnId);      //회사 ID 임시저장

            $('#ScheArea').val(cpnNm);      //장소 표시
        }else{
            //인물
            var tmpSpan = document.createElement("span");
            tmpSpan.innerHTML = rVal.nm;

            var cstNm = $(tmpSpan).text();      //위에서 임시로  span 을 만들어 내부에 테그를포함한 인물명을 넣어놓고 text()로 텍스트만 뽑아낸다.
            var cstId = rVal.snb;

            $('#tmpCstNm').val(cstNm);      //인물명 표시
            $('#tmpCstId').val(cstId);      //인물 ID 임시저장

            //회사
            tmpSpan.innerHTML = rVal.cpnNm;
            var cpnNm = $(tmpSpan).text();      //위에서 임시로  span 을 만들어 내부에 테그를포함한 회사명을 넣어놓고 text()로 텍스트만 뽑아낸다.
            var cpnId = rVal.cpnId;

            $('#tmpCpnNm').val(cpnNm);      //회사명 표시
            $('#tmpCpnId').val(cpnId);      //회사 ID 임시저장

            $('#ScheArea').val(cpnNm);      //장소 표시
        }
        setAutoMakeTitle();             //제목 자동생성 호출
        mnaPopup.close();   //팝업닫기
    }

    //------------------------------------- mna 추가 관련 회사 선택 팝업용 :E -------------------------------------


    //-------------------------------------------------------------------------------------------------
    //--------------------------------------- 신규추가 -----------------------------------------------
    //-------------------------------------------------------------------------------------------------


    var fnObj = {
        //직원선택 팝업   (idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
        openEmpPopup: function(){
        	var userStr ='';
            var arr =[];
            var disabledList =[];
            var selectUserList =$("input[name=arrRecieveUserId]");

            if($("#projectId").val() == ""){
                alert("${baseUserLoginInfo.projectTitle}을/를 선택해 주세요.");
                $("#projectId").focus();
                return;
            }else if($("#activityId").val() == ""){
                alert("${baseUserLoginInfo.activityTitle}을/를 선택해 주세요.");
                $("#activityId").focus();
                return;
            }

            for(var i=0;i<selectUserList.length;i++){
                arr.push(selectUserList[i].value);
            }
            userStr = arr.join(',');

            $("#userStr").val(userStr);

            disabledList.push('${baseUserLoginInfo.userId}');

            /* var paramList = [];
            var paramObj ={ name : 'userList'   ,value : userStr};
            paramList.push(paramObj);
            paramObj ={ name : 'isAllOrg' ,value : 'Y'};
            paramList.push(paramObj);
            paramObj ={ name : 'isAllOrgSelect' ,value : 'Y'};  //관계사 직원 다중선택가능 옵션
            paramList.push(paramObj); */

            ////////////////////////////
            //1. 공개프로젝트 전직원     : 전사직원선택 가능
            //2. 공개프로젝트 직원 할당 : 프로젝트에 할당된 직원만
            // 3. 비공개 프로젝트          : 프로젝트에 할당된 직원만
            var openFlag = "Y";
            var employee = "Y";
            if($('#eventType').val() == 'Add'){
            	openFlag = $("#projectId option:selected").attr("openFlag");
            	employee = $("#projectId option:selected").attr("employee");
            }else{
            	openFlag = $("#openFlag").val();
            	employee = $("#employee").val();
            }

            if(openFlag == "Y" && employee == "A"){
            	var paramList = [];
                var paramObj ={ name : 'userList'   ,value : userStr};
                paramList.push(paramObj);
                paramObj ={ name : 'disabledList'   ,value : disabledList};
                paramList.push(paramObj);
                paramObj ={ name : 'isAllOrg' ,value : 'Y'};
                paramList.push(paramObj);
                paramObj ={ name : 'isAllOrgSelect' ,value : 'Y'};
                paramList.push(paramObj);
                paramObj ={ name : 'isCheckDisable' ,value : 'N'};
                paramList.push(paramObj);

                paramObj ={ name : 'isUserGroup' ,value : 'Y'};
                paramList.push(paramObj);

                paramObj ={ name : 'hasDeptTopLevel' ,value : 'Y'};
                paramList.push(paramObj);  //부서의 회장 부서 표시여부

                 userSelectPopCall(paramList);       //공통 선택 팝업 호출
            }else{
            	$("#disabledStr").val('${baseUserLoginInfo.userId}');
            	var option = "width=650px,height=520px,resizable=yes,scrollbars = yes";
                commonPopupOpen("searchCpnPop",contextRoot+"/work/projectUserListPopup.do",option,$("#scheduleProc"));
            }
        },

        //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
        getResult: function(resultList){
        	var dupEmpYn = false;
        	var usrHtml = '';
        	$("#spanEmpNmList").html("");  //리셋
        	// 로그인한 유저 참가자 생성
        	usrHtml = '';
            usrHtml += '<span class="employee_list" >';
            usrHtml += '<strong>${baseUserLoginInfo.userName}</strong>(${baseUserLoginInfo.deptNm})';
            usrHtml += '<input type="hidden" name="arrPerSabun" id="arrPerSabun" value="${baseUserLoginInfo.empNo}"/>';
            usrHtml += '<input type="hidden" name="arrRecieveUserId" id="arrRecieveUserId" value="${baseUserLoginInfo.userId}"/>';
            usrHtml += '</span>';
            $("#spanEmpNmList").append(usrHtml);

		    for(var i=0;i<resultList.length ;i++){
		    	dupEmpYn = false;
                $("input[name=arrPerSabun]").each(function(){
                    if($(this).val() == resultList[i].empNo){
                        dupEmpYn = true;
                        return;
                    }
                });
                if(!dupEmpYn){
                	var orgNm = "";
                    if(resultList[i].orgId != '${baseUserLoginInfo.orgId}') orgNm = resultList[i].orgNm + "-";
                    else orgNm = "";

                    usrHtml = '';
                    usrHtml += '<span class="employee_list" >';
                    usrHtml += '<strong>'+ resultList[i].userNm +'</strong>('+orgNm+resultList[i].deptNm+')<a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                    //usrHtml += '<strong>'+ resultList[i].userNm +'</strong>('+orgNm+resultList[i].deptNm+')';
                    //if(i<resultList.length-2) usrHtml+=',';

                    usrHtml += '<input type="hidden" name="arrPerSabun" id="arrPerSabun" value="'+resultList[i].empNo+'"/>';
                    usrHtml += '<input type="hidden" name="arrRecieveUserId" id="arrRecieveUserId" value="'+resultList[i].userId+'"/>';
                    usrHtml += '</span>';

                    $("#spanEmpNmList").append(usrHtml);
                }
        	}
        }
    };//end fnObj.

    //직원선택 삭제
    function deleteEmp(obj){
    	var span = $(obj).parent();
    	span.remove();
    }

    //고객선택 팝업
    function customerPopUp(){
        var option = "width=650px,height=720px,resizable=yes,scrollbars = yes";
        commonPopupOpen("searchCpnPop",contextRoot+"/person/customerListPopup.do",option,$("#viewerFrm"));
    }

    //고객선택 팝업 Callback
    function cstPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position){
    	$("#tmpCstNm").val(cstNm);
        $("#tmpCstId").val(sNb);
        $("#tmpCpnNm").val(cpnNm);
        $("#tmpCpnId").val(cpnSnb);
        $('#ScheArea').val(cpnNm);      //장소 표시

        setAutoMakeTitle();             //제목 자동생성 호출
    }

    //회사선택 팝업
    function companyPopUp(companyPopType){
        $("#companyPopType").val(companyPopType);
        var option = "width=650px,height=720px,resizable=yes,scrollbars = yes";
        commonPopupOpen("searchCpnPop",contextRoot+"/company/popUpCpn.do",option,$("#viewerFrm"));
    }

    //회사선택 팝업 Callback
    function cpnPopupCallback(cpnId,cpnNm,sNb){
    	$("#tmpCstNm").val("");
        $("#tmpCstId").val("");

        $("#tmpCpnNm").val(cpnNm);
        $("#tmpCpnId").val(sNb);
        $('#ScheArea').val(cpnNm);      //장소 표시
        setAutoMakeTitle();             //제목 자동생성 호출
    }

   //고객선택 초기화
    function resetCst(){
    	$("#spanCustNmList").html("");
        $("#tmpCstNm").val("");
        $("#tmpCstId").val("");
        setAutoMakeTitle();             //제목 자동생성 호출
    }
    //회사선택 초기화
    function resetCpn(){
    	$("#spanCompNmList").html("");
        $("#tmpCpnNm").val("");
        $("#tmpCpnId").val("");
        $('#ScheArea').val("");      //장소 표시
        setAutoMakeTitle();             //제목 자동생성 호출
    }

  //참가자 Area Reset
    function resetUserSelectArea(){
        var usrHtml = '';
        $("#spanEmpNmList").html("");  //리셋
        // 로그인한 유저 참가자 생성
        usrHtml = '';
        usrHtml += '<span class="employee_list" >';
        usrHtml += '<strong>${baseUserLoginInfo.userName}</strong>(${baseUserLoginInfo.deptNm})';
        usrHtml += '<input type="hidden" name="arrPerSabun" id="arrPerSabun" value="${baseUserLoginInfo.empNo}"/>';
        usrHtml += '<input type="hidden" name="arrRecieveUserId" id="arrRecieveUserId" value="${baseUserLoginInfo.userId}"/>';
        usrHtml += '</span>';
        $("#spanEmpNmList").append(usrHtml);
    }

    //업무구분 셋팅
    function setProject(){
    	var colorObj = {};
        var comCodeProject = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.projectTitle } 선택', { orgId : "${baseUserLoginInfo.applyOrgId}",userId : "${baseUserLoginInfo.userId}",type:"PROJECT",incApproveActivity:"${baseUserLoginInfo.approveUseYn eq 'Y'?'N':'Y'}",startDate : $("#scheSDate").val() });
        	//getBaseCommonCode('PJT_CODE', null, 'CD', 'NM', '', '업무구분', null, { orgId : "${baseUserLoginInfo.applyOrgId}" });
        var projectTag = createSelectTagForProject('projectId', comCodeProject, 'CD', 'NM', '${scheVO.projectId}', null, colorObj, null, 'select_b','PROJECT');
        	//createSelectTag('projectId', comCodeProject, 'CD', 'NM', '${scheVO.projectId}', null, colorObj, null, 'select_b');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#projectTag").html(projectTag);

       //업무구분 선택시
        $("#projectId").change(function(){
        	setActivity($(this).val());
        	resetUserSelectArea();  //참가자 Area Reset
        }).change();

        setMeetingRoomList("N");
    }

    //활동구분 셋팅
    function setActivity(projectId){
        $("#activityDescArea").html("");
    	if(projectId == ""){
    		$("#activityId").html("<option value = ''>${baseUserLoginInfo.activityTitle } 선택</option>");
        }else{
        	var colorObj = {};
            var comCodeActivity = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.activityTitle } 선택', { orgId : "${baseUserLoginInfo.applyOrgId}",projectId : projectId ,userId : "${baseUserLoginInfo.userId}" ,type:"ACTIVITY",incApproveActivity:"${baseUserLoginInfo.approveUseYn eq 'Y'?'N':'Y'}" ,startDate : $("#scheSDate").val()});
            var activityTag = createSelectTagForProject('activityId', comCodeActivity, 'CD', 'NM', '${scheVO.activityId}', null, colorObj, null, 'select_b mgl6','ACTIVITY');
            $("#activityTag").html(activityTag);
        }
        //활동구분 선택시
        $("#activityId").change(function(){
        	chngProject();
        	resetUserSelectArea();  //참가자 Area Reset
        });
        if($("#activityId").val()!="") $("#activityId").change();
    }

  //분류 선택 onclick
    function chngProject(){
        var activityId = $('#activityId option:selected').val();

        $("#activityDescArea").html("");
        if(activityId==""){
            $("#activityDescArea").html("");
            return;
        }

        var activityStartDate = $("#activityId option:selected").attr("startdate");
        var activityEndDate = $("#activityId option:selected").attr("enddate");
        var projectStartDate = $("#projectId option:selected").attr("startdate");
        var projectEndDate = $("#projectId option:selected").attr("enddate");
        var lastDate = $("#projectId option:selected").attr("lastDate");

        var vacationYn = $("#activityId option:selected").attr("vacationYn");  //휴가 엑티비티 여부
        var appvDocType = $("#activityId option:selected").attr("appvDocType");  //

        $("#vacationYn").val(vacationYn);
        $("#appvDocType").val(appvDocType);

        //휴가관련 Activity 이면 현지출근 비활성화
        if(vacationYn == "Y"){
            $("#attendYnArea").hide();
            $('input:checkbox[name="attendYnChk"]').attr("checked", false);
        }else{
        	$("#attendYnArea").show();
        }

        //휴가관련 Activity 이면 일정시간 Fix
        //ANNUAL_ALL(연차), ANNUAL_AM(오전반차), ANNUAL_PM(오후반차), EVENT(경조사), SICK(병가), REST(휴직)
        //ETC_ALL(기타휴가), ETC_AM(기타휴가오전반차), ETC_PM(기타휴가오후반차)
        if(appvDocType == "ANNUAL_ALL" || appvDocType == "EVENT" || appvDocType == "SICK" || appvDocType == "REST" || appvDocType == "ETC_ALL"){
        	$("#sTime").val('09:00');
        	$("#eTime").val('18:00');
        	TimeChange('sTime', $('#sTime').val());
        	TimeChange('eTime', $('#eTime').val());
        	/* $("#sTime").attr("disabled",true);
            $("#eTime").attr("disabled",true); */
        }else if(appvDocType == "ANNUAL_AM" || appvDocType == "ETC_AM"){
        	$("#sTime").val('09:00');
            $("#eTime").val('14:00');
            TimeChange('sTime', $('#sTime').val());
            TimeChange('eTime', $('#eTime').val());
            /* $("#sTime").attr("disabled",true);
            $("#eTime").attr("disabled",true); */
        }else if(appvDocType == "ANNUAL_PM" || appvDocType == "ETC_PM"){
            $("#sTime").val('14:00');
            $("#eTime").val('18:00');
            TimeChange('sTime', $('#sTime').val());
            TimeChange('eTime', $('#eTime').val());
            /* $("#sTime").attr("disabled",true);
            $("#eTime").attr("disabled",true); */
        }else{
        	/* $("#sTime").attr("disabled",false);
            $("#eTime").attr("disabled",false); */
        	//TimeSet();  //프로젝트/엑티비티가 변해도 타임리셋 안함(2017.09.12 by inhee)
        }


        $('#activityStartDate').val(activityStartDate);
        $('#activityEndDate').val(activityEndDate);
        $('#projectStartDate').val(projectStartDate);
        $('#projectEndDate').val(projectEndDate);
        $('#lastDate').val(lastDate);

        $("#activityDescArea").html("<br/>기간 : " + activityStartDate + " ~ " + activityEndDate);

        if(activityId == 'PRIVATE'){                      //개인메모 이면 일정구분(숨기있음)이 개인일정으로 선택되도록
            $('#scheGubun').val('Alone');
            $('#spanSecret').show();  //비공개 활성화
            $('#Secret').attr('checked', true);
            entrySet("Alone");
        }else{                                              //일정구분 > 전체일정
            $('#scheGubun').val('All');
            $('#Secret').attr('checked', false);
            $('#spanSecret').hide();           //비공개 비활성화
            entrySet("All");
        }

      //휴가관련 Activity 이면 고갟/회사 비활성화, 참가자 비활성화
        if(appvDocType == "ANNUAL_ALL" || appvDocType == "EVENT" || appvDocType == "SICK" || appvDocType == "REST"
                || appvDocType == "ANNUAL_AM" || appvDocType == "ANNUAL_PM"
                	|| appvDocType == "ETC_ALL" || appvDocType == "ETC_AM" || appvDocType == "ETC_PM"){
            entrySet("Alone");
            $("#CstView").hide();
            $("#tmpCstId").val("");
            $("#tmpCpnId").val("");
            $("#tmpCstNm").val("");
            $("#tmpCpnNm").val("");
        }else{
            entrySet("All");
            $("#CstView").show();
        }

        setAutoMakeTitle();     //제목자동생성 호출
    }

    //중요도 체크
    function chkScheImportant(scheImportant){
    	if($('#ScheImportant').val() == "bottom" && scheImportant == "bottom"){
    		$('#ScheImportantViewBottom').attr('class', '');
            $('#ScheImportantViewMiddle').attr('class', '');
            $('#ScheImportantViewTop').attr('class', '');
            $('#ScheImportant').val("");        //중요도 세팅
    	}else{
    		if(scheImportant == "bottom"){
                $('#ScheImportantViewBottom').attr('class', 'on');
                $('#ScheImportantViewMiddle').attr('class', '');
                $('#ScheImportantViewTop').attr('class', '');
            }else if(scheImportant == "middle"){
                $('#ScheImportantViewBottom').attr('class', 'on');
                $('#ScheImportantViewMiddle').attr('class', 'on');
                $('#ScheImportantViewTop').attr('class', '');
            }else if(scheImportant == "top"){
                $('#ScheImportantViewBottom').attr('class', 'on');
                $('#ScheImportantViewMiddle').attr('class', 'on');
                $('#ScheImportantViewTop').attr('class', 'on');
            }else{
                $('#ScheImportantViewBottom').attr('class', '');
                $('#ScheImportantViewMiddle').attr('class', '');
                $('#ScheImportantViewTop').attr('class', '');
            }
            $('#ScheImportant').val(scheImportant);        //중요도 세팅
    	}
    }
    function cancelButton(){
    	if('${vo.eventType}' == 'Edit' && '${scheVO.projectId}' != ''){
    		ScheView();
        }else{
        	window.close();
        }
    }
</script>