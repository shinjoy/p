<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">

</script>

<div id="compnay_dinfo">
		<div class="modalWrap2">

			 <div class="mo_container2">
			 	<div class="popalarmWrap">
			 		<h3 class="h3_title_basic">경고!!</h3>
			 		<div class="popcon_uni mgt10">
			 			<div>진행중인 업무가 존재하여 선택한 날짜에 ${baseUserLoginInfo.projectTitle} 마감이 <font style="color:red; font-weight:bold;" >불가능</font>합니다. </div>
			 			<div>현재 마감 가능일정은 <font style="color:blue; font-weight:bold;" id="enableDate"></font> 이며, 진행중 업무 삭제(취소) 시 이전일을 설정할 수 있습니다.</div>
			 		</div>

			 		<div class="popcon_uni mgt30" style="font-size:15px;font-weight:bold;">
			 			<div id="scheCnt"></div>
			 			<div id="approveCnt"></div>
			 		</div>
			 	</div>
			 </div>

            <!--창닫기-->
		    <div class="todayclosebox">
		        <div class="fr_block"><button type="button" class="btn_close" onClick="parent.myModal.close();"><span>닫기</span><span>X</span></button></div>
		    </div>

		</div>
	</div>





<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')



//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		var objStr = '${obj}';

		var obj = JSON.parse(objStr);

		$("#enableDate").html(obj.endLastDate);
		$("#scheCnt").html('일정 : '+ fillzero(obj.schCnt,2) +' 건');
		$("#approveCnt").html('전자결재 : '+fillzero(obj.appvCnt,2) +' 건');


	},


	//화면세팅
    pageStart: function(){



    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅

});

</script>