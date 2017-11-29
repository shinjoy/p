<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="customTagUi" uri="/WEB-INF/tlds/ui.tld"%>

<link href='${pageContext.request.contextPath}/css/spectrum.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/js/spectrum.js'></script>



<style type="text/css">

.height25{
	height:25px !important;
}

</style>

<div class="mo_container">
<input type="hidden" id="titleColor"/>

	<table class="tb_basic_left">
		<colgroup>
	       <col width="30%">
	       <col width="*">
	    </colgroup>
	    <tr>
	       	<th>회의실명</th>
	       	<td>
	            <input type="text" id="meetingRoomNm" class="input_b w200px" placeholder="회의실명"/>
			</td>
	    </tr>
	    <tr>
		   	<th>위치</th>
		   	<td><input type="text" id="meetingRoomLocation" class="input_b w200px" placeholder="회의실위치"/></td>
	    </tr>
	    <tr>
	    	<th>순서</th>
	    	<td><input type="number" id="sort" class="input_b w60px number" placeholder="정렬순서" maxlength="4"/></td>
	    </tr>
	    <tr>
	       	<th>설명</th>
	       	<td> <input type="text" id="description" class="input_b w200px" placeholder="회의실설명"/></td>
	    </tr>
	    <tr>
	       	 <th>사용여부</th>
	       	 <td>
	       		<select id="enable" class="select_b w50px">
	       			<option vale="Y">Y</option>
	       			<option vale="N">N</option>
	       		</select>
	       	 </td>
	    </tr>
	    <tr>
	       	 <th>회의실타이틀 색상</th>
	       	 <td>
	       		<input type="text" id="titleColorSet" />
	       	 </td>
	    </tr>
	</table>

	<div class="btn_baordZone2">
		<customTagUi:authBtn txt="저장" orgId="${orgId }" event="href='javascript:fnObj.doSave()'" ele="a" classValue="btn_blueblack" id="rsvBtn"/>
	</div>

</div>


<script type="text/javascript">

//Global variables :S ---------------

//공통코드
var g_meetingRoomId = '${meetingRoomId}';
var g_orgId ='${orgId}';

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
	},

	//화면세팅
    pageStart: function(){
    	numberFormatForNumberClass();

    	$("#sort").bindNumber({min:0, max:1000});

    },//end pageStart.

 	//검색
    doSearch: function(){

    	var url = contextRoot + "/meetingRoom/getMeetingRoomList.do";
    	var param = {
    					meetingRoomId 	: g_meetingRoomId

    				};


    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var list = obj.resultList;

    		if(list.length>0){
    			var meetObj = list[0];

    			$("#meetingRoomNm").val(meetObj.meetingRoomNm);
        		$("#meetingRoomLocation").val(meetObj.meetingRoomLocation);
        		$("#sort").val(meetObj.sort);
        		$("#description").val(meetObj.description);
        	 	$("#enable").val(meetObj.enable);
        	 	$("#titleColorSet").spectrum("set", meetObj.titleColor);
        	 	$("#titleColor").val(meetObj.titleColor);
    		}

    	};
    	commonAjax("POST", url, param, callback, false);


    },//end doSearch

  	//예약 저장
    doSave : function(){  //시작 시간, 종료시간, 예약일, 미팅룸 아이디

        if(isEmpty($("#meetingRoomNm").val())){      //회의실명
            dialog.push({body:"<b>확인!</b> 회의실명을 입력해주세요!", type:"", onConfirm:function(){$("#meetingRoomNm").focus();}});
            return;
        }
        if(isEmpty($("#meetingRoomLocation").val())){      //회의실위치
            dialog.push({body:"<b>확인!</b> 회의실위치를 입력해주세요!", type:"", onConfirm:function(){$("#meetingRoomLocation").focus();}});
            return;
        }
        if(isEmpty($("#sort").val())){      //정렬순서
            dialog.push({body:"<b>확인!</b> 정렬순서를 입력해주세요!", type:"", onConfirm:function(){$("#sort").focus();}});
            return;
        }
        if(isEmpty($("#description").val())){      //회의실명
            dialog.push({body:"<b>확인!</b> 회의실명을 입력해주세요!", type:"", onConfirm:function(){$("#description").focus();}});
            return;
        }

    	//매개 변수가 undefined  일 경우는  예약 하기 버튼으로 접근시


    	var url = contextRoot + "/meetingRoom/doSaveMeetingRoom.do";
    	var param = {
    					meetingRoomId 		: g_meetingRoomId,
    					meetingRoomNm 		: $("#meetingRoomNm").val(),
    					meetingRoomLocation : $("#meetingRoomLocation").val(),
    					sort				: $("#sort").val(),
    					description			: $("#description").val(),
    					enable				: $("#enable").val(),
    					orgId				: g_orgId,
    					titleColor			: $("#titleColor").val()
    				};


    	var callback = function(result){


    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;

    		if(cnt>0){
    			alert("저장되었습니다.");

    			parent.myModal.close();
    			parent.fnObj.doSearch(1);

        	}else{
    			alert("실패 하였습니다.");
    		}

    	};

    	commonAjax("POST", url, param, callback, false);
    }



    //################# else function :E #################
};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅



	$("#titleColorSet").spectrum({
	    color: "#000000",
    	change: function(color) {
    		$("#titleColor").val(color.toHexString());
    	}
	});

	if(g_meetingRoomId >0 ) fnObj.doSearch();

});
</script>