<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){

	});

	//탭 분류1
	function moveTopTab(type){

		$(".topTabLi").removeClass("on");
		$("#"+type+"Li").addClass("on");

		if(type == "codesetTopInfo1"){

			$("#codesetTopInfo1").show();
			$("#codesetTopInfo2").hide();
			$("#tabArea").show();
		}else if(type == "codesetTopInfo2"){
			$("#codesetTopInfo1").hide();
			$("#codesetTopInfo2").show();
			$("#tabArea").hide();
		}

		parent.myModal.resize();
	}

	//탭 분류2
	function moveTab(type){
		$(".tabLi").removeClass("current");
		$(".point").remove();
		$("#"+type+"Li").addClass("current");
		$("#"+type+"Li").append("<em class=\"point\"></em>");

		$(".tabArea").hide();
		$("#"+type).show();

		parent.myModal.resize();
	}
</script>
<div id="compnay_dinfo">
	<!--업무일지등록-->
	<div class="modalWrap2">
		<!--tab-->
		<div class="gtabZone">
			<ul>
				<li class="on topTabLi" id = "codesetTopInfo1Li"><a href="javascript:moveTopTab('codesetTopInfo1')">코드관리란?</a></li>
				<li class="topTabLi" id = "codesetTopInfo2Li"><a href="javascript:moveTopTab('codesetTopInfo2')">코드List 등록 수정방법</a></li>
			</ul>
		</div>
		<!--//tab//-->
		<div class="mo_container">
			<div class="gray_notibox">
				코드관리란 : PASS의 일부 항목들을 각각 사내 특성에 맞게 등록, 수정하여 사용하실 수 있게 하는 기능으로
				항목들의 대분류를 코드SET이라 하고 코드SET 아래 소분류 목록은 코드List이며 소분류는 코드라 칭합니다
			</div>
			<!--subtab-->
			<ul class="tabZone_st08 count_n08 mgt20" id = "codesetTopInfo1">
				<li class="current tabLi" id = "codesetInfo1Li"><a href="javascript:moveTab('codesetInfo1')">개요</a><em class="point"></em></li>
				<li class="tabLi" id = "codesetInfo2Li"><a href="javascript:moveTab('codesetInfo2')">업무일지 진행형태</a></li>
				<li class="tabLi" id = "codesetInfo3Li"><a href="javascript:moveTab('codesetInfo3')">고객유형</a></li>
				<li class="tabLi" id = "codesetInfo4Li"><a href="javascript:moveTab('codesetInfo4')">직위</a></li>
				<li class="tabLi" id = "codesetInfo5Li"><a href="javascript:moveTab('codesetInfo5')">${baseUserLoginInfo.projectTitle} 유형</a></li>
				<li class="tabLi" id = "codesetInfo6Li"><a href="javascript:moveTab('codesetInfo6')">경조사 분류</a></li>
				<li class="tabLi" id = "codesetInfo7Li"><a href="javascript:moveTab('codesetInfo7')">기타휴가 분류</a></li>
				<li class="tabLi" id = "codesetInfo9Li"><a href="javascript:moveTab('codesetInfo9')">계정과목</a></li>
			</ul>
			<!--/subtab/-->
			<!--guide이미지-->
			<div id = "tabArea">
			<p class="mgt10 tabArea" id = "codesetInfo1"><img src="../images/system/img_codeset01.png" alt="코드SET_개요안내" /></p>
			<p class="mgt10 tabArea" id = "codesetInfo2" style="display: none;"><img src="../images/system/img_codeset02.png" alt="코드SET_업무일지 진행형태안내" /></p>
			<p class="mgt10 tabArea" id = "codesetInfo3" style="display: none;"><img src="../images/system/img_codeset03.png" alt="코드SET_고객유형안내" /></p>
			<p class="mgt10 tabArea" id = "codesetInfo4" style="display: none;"><img src="../images/system/img_codeset04.png" alt="코드SET_직위안내" /></p>
			<p class="mgt10 tabArea" id = "codesetInfo5" style="display: none;"><img src="../images/system/img_codeset05.png" alt="코드SET_${baseUserLoginInfo.projectTitle} 유형안내" /></p>
			<p class="mgt10 tabArea" id = "codesetInfo6" style="display: none;"><img src="../images/system/img_codeset06.png" alt="코드SET_경조사 분류안내" /></p>
			<p class="mgt10 tabArea" id = "codesetInfo7" style="display: none;"><img src="../images/system/img_codeset07.png" alt="코드SET_기타휴가 분류안내" /></p>
			<p class="mgt10 tabArea" id = "codesetInfo9" style="display: none;"><img src="../images/system/img_codeset09.png" alt="코드SET_계정과목안내" /></p>
			</div>
			<!--/guide이미지/-->

			<!--guide이미지-->
			<p class="mgt10" id = "codesetTopInfo2" style="display: none;"><img src="../images/system/img_codeset08.png" alt="코드SET_${baseUserLoginInfo.projectTitle} 유형" /></p>
			<!--/guide이미지/-->

			<div class="btnZoneBox"><a href="javascript:parent.myModal.close()" class="p_withelin_btn">닫기</a></div>
		</div>
	</div>
	<!--//회사상세보기(회사정보)//-->
</div>
