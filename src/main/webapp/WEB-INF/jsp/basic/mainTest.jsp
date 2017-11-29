<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/passMainScrollControll.js"></script><!-- jquery , ajaxRequest, etc -->
<<style>
<!--
.darggableUl{min-height: 50px;}
-->
</style>
<script type="text/javascript" defer="defer">
/*
 * Main Module작성시 ul/li 태그
 * .darggableUl : 해당 클래스를 선언한 ul태그 자식요소 li는 드래그&드랍 기능이 적용됨
 * .notDraggable : 해당 클래스를 선언한 li태그는 드래그&드랍 기능에서 제외됨
 */
$(document).ready(function(){
	setPassMainScrollPrc();

	setPassMainModulePrc();
});

//메인 영역별 스크롤 컨트롤 셋텡
function setPassMainScrollPrc(){
	passMainScrollInit();

	//passMainScrollControll(".main_moduleWrap",	"#detail_contents", "#main_moduleWrap-in");
	passMainScrollControll(".main_fixWrap",	"#detail_contents", "#main_fixWrap-in");

	passMainScrollControll("#mainModu_01_s",	".topWarp", "#mainModu_01_i");
	passMainScrollControll("#mainModu_02_s",	".topWarp", "#mainModu_02_i");
	passMainScrollControll("#mainModu_03_s",	".topWarp", "#mainModu_03_i");
}

//메인 영역 모듈 이동 컨트롤 셋팅
function setPassMainModulePrc(){
	var receivChk = false;

	var wscrolltop ="";
	var sortableFirst = false;
	/** drag n drop **/
	$( ".darggableUl" ).sortable({
		start: function (event, ui) {
			 /* if(sortableFirst){
                wscrolltop = $(window).scrollTop();
             } */

            /*  if(browserInfo.browser == "Explorer")
			 	wscrolltop = $(window).scrollTop(); */
             //sortableFirst = true;

             ui.placeholder.height(ui.item.height());

		},
		update:function (event, ui) {
			var updateUserModuleStr = "";

			if (this === ui.item.parent()[0]) {
				/* if (ui.sender !== null) { */

		        	updateUserModuleStr += "0";

		        	$("#mainModu_01_i ul li:not('.notDraggable')").each(function(){

						if($(this).attr("moduleCode")){
							updateUserModuleStr+="|"+$(this).attr("moduleId");
						}
					});
		        	updateUserModuleStr += ",1";
					$("#mainModu_02_i ul li:not('.notDraggable')").each(function(){

						if($(this).attr("moduleCode")){
							updateUserModuleStr+="|"+$(this).attr("moduleId");
						}
					});

					updateUserModuleStr += ",2";
					$("#mainModu_03_i ul li:not('.notDraggable')").each(function(){

						if($(this).attr("moduleCode")){
							updateUserModuleStr+="|"+$(this).attr("moduleId");
						}
					});

					updateUserModuleStr += ",3";
					$("#main_fixWrap-in ul li:not('.notDraggable')").each(function(){

						if($(this).attr("moduleCode")){
							updateUserModuleStr+="|"+$(this).attr("moduleId");
						}
					});

					var url = contextRoot + "/user/processUserMainModule.do";
					var param = {updateUserModuleStr:updateUserModuleStr};

					var callback = function(result){

					}
					commonAjax("POST", url, param, callback, true);
					//console.log("END")
		        /* }*/
		    }

		 },
		stop: function (event, ui) {
			jQuery(window).trigger("passMainScrollControll");
			//setPassMainScrollPrc();

		 },
        sort: function (event, ui) {
        /*  if(browserInfo.browser == "Explorer")
            	ui.helper.css({'top': ui.position.top + wscrolltop + 'px'}); */


         jQuery(window).trigger("passMainScrollControll");
        },
		connectWith : ".darggableUl",
		items: "li:not(.notDraggable)",
		placeholder: "ui-state-highlight",
		scrollSensitivity: 10,
		cursor: 'move',
		tolerance: 'pointer',
		helper: 'clone',
	    opacity: 0.8,
	    zIndex: 100000000
	}).disableSelection();

}
</script>
<section id="detail_contents" style="padding-left: 150px;min-width: 1050px;">
	<div class="main_moduleWrap">
		<div id="main_moduleWrap-in">
		<!--상단전체-->
		<div class="topWarp">
		<div id = "main-top01">
			<div id="mainModu_01_s">
					<div id="mainModu_01_i">
						<ul id="sortable_Mmodule" class="darggableUl">
							<!-- Fixed User Profile -->
							<jsp:include page="../module2/userProfile.jsp"></jsp:include>
							<!-- 모듈 리스트 -->
							<c:forEach items="${moduleList }" var = "data">
								<c:if test="${data.coordinateXx eq 0 }">
									<li class="${data.theme } userSetModuleArea" moduleCode = "${data.moduleCode }" moduleId = "${data.moduleId }" coordinateXx = "${data.coordinateXx }" coordinateYy="${data.coordinateYy }">
										<jsp:include page="..${data.moduleIncUrl }"></jsp:include>
									</li>
								</c:if>
							</c:forEach>

						</ul>
					</div>
				</div>
			</div>
			<div id = "main-top02">
			<div id="mainModu_02_s">
					<div id="mainModu_02_i" >
						<ul id="sortable_Mmodule2"  class="darggableUl">
							<!-- 모듈 리스트 -->
							<c:forEach items="${moduleList }" var = "data">
								<c:if test="${data.coordinateXx eq 1 }">
									<li class="${data.theme } userSetModuleArea" moduleCode = "${data.moduleCode }" moduleId = "${data.moduleId }" coordinateXx = "${data.coordinateXx }" coordinateYy="${data.coordinateYy }">
										<jsp:include page="..${data.moduleIncUrl }"></jsp:include>
									</li>
								</c:if>
							</c:forEach>

						</ul>
					</div>
				</div>
			</div>
			<div id = "main-top03">
			<div id="mainModu_03_s">
					<div id="mainModu_03_i" >
						<ul id="sortable_Mmodule3" class="darggableUl">
							<!-- 모듈 리스트 -->
							<c:forEach items="${moduleList }" var = "data">
								<c:if test="${data.coordinateXx eq 2 }">
									<li class="${data.theme } userSetModuleArea" moduleCode = "${data.moduleCode }" moduleId = "${data.moduleId }" coordinateXx = "${data.coordinateXx }" coordinateYy="${data.coordinateYy }">
										<jsp:include page="..${data.moduleIncUrl }"></jsp:include>
									</li>
								</c:if>
							</c:forEach>

						</ul>
					</div>
				</div>
			</div>
		</div>
		<!--//상단전체//-->
		<!--하단전체 Fixed-->
		<jsp:include page="../module2/viewProject.jsp"></jsp:include>
	</div>
	</div>

	<div class="main_fixWrap">
		<div id="main_fixWrap-in">
		<!--상단전체-->
		<ul id="sortable_Smodule" class="darggableUl">
			<!-- 모듈 리스트 -->
			<c:forEach items="${moduleList }" var = "data">
				<c:if test="${data.coordinateXx eq 3 }">
					<li class="${data.theme } userSetModuleArea" moduleCode = "${data.moduleCode }" moduleId = "${data.moduleId }" coordinateXx = "${data.coordinateXx }" coordinateYy="${data.coordinateYy }">
						<jsp:include page="..${data.moduleIncUrl }"></jsp:include>
					</li>
				</c:if>
			</c:forEach>

		</ul>
		<!--//상단전체//-->
	</div>
	</div>

	<div class = "rightWing">
		<a href="javascript:void(0);" onclick="window.scrollTo(0,0);" class="main_top_btn">맨위로</a>
		<a href="javascript:void(0);" onclick="window.scrollTo(0,$(document).height());" class="main_bot_btn">맨아래로</a>
	</div>
</section>
