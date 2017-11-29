<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회사리스트 | 회사 | 네트워크 | PASS (Project based Activity analysis and Sharing system)</title>
<meta name="copyright" content="COPYRIGHT@ Synergy Group" />
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon" />
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/base.js"></script>
    <!--html5새로생성된 태그가 IE6~8에서 적용되게 하는 js파일-->
    <!--[if lt IE 9]>
            <script src="/js/html5shiv.js" ></script>
    <![endif]-->

    <!--미디어쿼리가 IE6~8에서 적용되게 하는 js파일-->
    <!--[if lt IE 9]>
            <script src="/js/respond.min.js" ></script>
    <![endif]-->

    <!-- Load jQuery Here -->
    <!--[if lt IE 9]>
            <script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
            <script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js"></script>
            <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<script type="text/javascript">
$(document).ready(function(){
	searchNetList();

	if($("#cpnUserArea").prop("scrollHeight")>126&&$("#cpnUserArea").prop("scrollHeight")  > $("#cpnUserArea").innerHeight()){
	    // 세로 스크롤바가 있을 경우 처리
	    $("#cpnUserListBtnArea").show();
	    $("#cpnUserListOpenAll").show();
	}

});
//직원전체보기
function openCpnUserList(){
	$("#cpnUserArea").css("max-height","none");
	$("#cpnUserListClose").show();
	$("#cpnUserListOpenAll").hide();
	//style="height: 109px;overflow-y: scroll;";
}closeCpnUserList
//직원전체보기 닫기
function closeCpnUserList(){
	$("#cpnUserArea").css("max-height","109px");
	$("#cpnUserListClose").hide();
	$("#cpnUserListOpenAll").show();
	//style="height: 109px;overflow-y: scroll;";
}
//직원 체크박스 클릭
function checkCus(){
	if($("input[type='checkbox']:checked").length==0){
		$("#searchAll").prop("checked",true);
	}else{
		if($("#searchAll").prop("checked")){
			if($("input[type='checkbox']:checked").length>1){
				$("#searchAll").prop("checked",false);
			}
		}else{
			$("#searchAll").prop("checked",false);
		}
	}
	$("tr[id*='netTr_']").hide();
	$("input[type='checkbox']").each(function(){
		if($(this).prop("checked")){
			$("tr[id*='netTr_"+$(this).val()+"']").show();
		}
	});

}

//친밀도 체크
function chkRelationDegree(th, val){
    for(var i=1; i<=5; i++){
        if(i <= val){
            $('#relDeg'+i).attr('class', 'on');
        }else{
            $('#relDeg'+i).attr('class', '');
        }
    }
    $('#relDegree').val('0000'+val);        //친밀도 세팅
    $('#spanRelDeg').text('(+'+val +  ')');        //친밀도 텍스트표시
}
//인물팝업 오픈
function openPersonPop(snb){
	var url = "<c:url value='/person/main.do'/>?sNb=" + snb+"&tabType=PERSON";
	window.open(url, 'cstView', 'resizable=no,width=968,height=720,scrollbars=yes');
}
//관련인물페이지로이동
function goCpnInfoPage(){
	$("#frm").attr("action", contextRoot+"/company/main.do");
	$("#frm").submit();
}
//선택한 직원의 네트워크 리스트 받아오기
function searchNetList(){
	var snb = $("input[name = 'sNbRadio']:checked").val();
	$("#sNb").val(snb);
	linkPage('1');
}

//검색
function linkPage(pageNo){
	$("#pageIndex").val(pageNo);
	$("#frm").attr("action", contextRoot+"/company/getPersonNetAjax.do");
	commonAjaxSubmit("POST", $("#frm"), searchCallback);
}
//콜백
function searchCallback(data){
	$("#netListArea").html(data);
	var cstTrId = "";
	var cpnTrId = "";

	$("td[id*='cusTd_']").each(function(){

		if($(this).attr("id")!=cstTrId){
			cstTrId = $(this).attr("id");

		}else{
			var rowSpan = parseInt($("#"+cstTrId).attr("rowspan"));
				$("#"+cstTrId).attr("rowspan", rowSpan+1);
			 $(this).remove();

		}

	});
	$("td[id*='cpn_']").each(function(){

		if($(this).attr("id")!=cpnTrId){
			cpnTrId = $(this).attr("id");
		}else{
			var rowSpan = parseInt($("#"+cpnTrId).attr("rowspan"));
			$("#"+cpnTrId).attr("rowspan", rowSpan+1);
			 $(this).remove();

		}

	});

	if($("#ceoId").length==1){
		var ceoId = $("#ceoId").val();
		/* var ceoLength = $(".netTr_"+ceoId).length-1;
		for(var i = 0 ; i<ceoLength+1 ; i++){
			$("#ceoHtmlBuf").prepend($(".netTr_"+ceoId).eq(ceoLength-i).clone())
		}
		$("#netTable tbody .netTr_"+ceoId).remove();
		$("#netTable tbody").prepend($("#ceoHtmlBuf").html()); */
		$(".netTr_"+ceoId).eq(0).find("#customerPosition1").text("대표이사");

	}
}
function openPage(){
//
}


//메인화면 재로딩
function reloadMainPage(){
    opener.parent.openPage();
    window.close();
}
</script>
<style>
.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
    z-index: 1000000;
}
.wrap-loading div{ /*로딩 이미지*/
    position: fixed;
    top:50%;
    left:50%;
    margin-left: -21px;
    margin-top: -21px;
    z-index: 1000000;
}
.display-none{ /*감추기*/
    display:none;
}

</style>
</head>
<body>
	<div class="wrap-loading display-none">
	    <div><img src="${pageContext.request.contextPath}/images/ajax_loading.gif" /></div>
	</div>
	<form id = "frm" name = "frm" method="post">
		<input type="hidden" id = "cpnId" name = "cpnId" value="${companyVO.cpnId }">
		<input type="hidden" id = "sNb" name = "sNb">
		<input type="hidden" id = "pageIndex" name = "pageIndex">
		<input type="hidden" id = "chkOrgStr" name = "chkOrgStr" value="${chkOrg }">

	<div id="compnay_dinfo">
		<!--회사상세보기(관련인물)-->
		<div class="modalWrap2">
			<h1><strong>[${companyDetail.cpnNm }] 관련인물</strong> </h1>
			<!--tab-->
			<div class="gtabZone">
				<ul>
					<li><a href="javascript:goCpnInfoPage()">회사정보</a></li>
					<li class="on"><a href="javascript:reloadPage()">관련인물</a></li>
					<!-- <li><a href="javascript:alert('준비중입니다.')">분석자료</a></li> -->
				</ul>
			</div>
			<c:set var="chkOrgStr" value="${chkOrg}" />
			<!--//tab//-->
			<div class="mo_container">
				<!--인물네트워크-->
				<h2 class="title_arrow">
					<span>인물네트워크<!-- <em id = "netType" class="between">( ↔ 전체 )</em> --></span>
					<%--<c:if test="${chkOrgStr eq 'Y' }">
						<em class="spe_color_st6 mgl8">[${cpnNm }]은 루트안내를 표시하지 않습니다.</em>
					</c:if> --%>

					<div class="title_arrow_rightBox">
						<%--<a href="#" class="s_3d_gray01_btn"><em class="add">관련인물추가</em></a>--%>
					</div>
				</h2>
				<!--직원리스트-->
				<div class="com_netgroup_Box" id = "cpnUserArea" >
					<dl class="">
						<dt style="width: 100px;">[${companyDetail.cpnNm }]<br>직원선택</dt>
						<dd>
							<ul class="netgroup_list">
								<c:forEach items="${cpnUserList }" var = "data" varStatus="i">
									<li>
										<label>
											<input name = "sNbRadio" type="radio" value="${data.sNb }" onclick="searchNetList()" <c:if test = "${i.index eq 0 }">checked="checked" </c:if>/>
											<strong>${data.cstNm }</strong>
											<c:if test="${!empty data.position}"><em>${data.position }</em></c:if>

											<c:if test="${data.orderby eq 1 }">
												<input type="hidden" id = "ceoId" value="${data.sNb }">
											</c:if>
										</label>
									</li>
								</c:forEach>
							</ul>

						</dd>
					</dl>
				</div>
				<div class="memberBox_controll" id = "cpnUserListBtnArea" style="display: none;">
					<a href="javascript:closeCpnUserList()" class="btn_td_close" id = "cpnUserListClose" style="display: none;"><em>닫기</em></a>
					<a href="javascript:openCpnUserList()" class="btn_td_open" id = "cpnUserListOpenAll" style="display: none;"><em>열기</em></a>
				</div>
				<div class="com_netgroup_Box">
					<dt style="width: 100px;">관계사선택</dt>
					<dd>
						<ul class="netgroup_list">
							<span class="" style="padding-top: 5px;"></span><select class="select_b mgl5" name = "searchOrgId" id = "searchOrgId" onchange="searchNetList()">
								<c:forEach var = "data" items="${orgIdList }">
									<option value="${data.orgId }" <c:if test = "${baseUserLoginInfo.applyOrgId eq data.orgId}">selected="selected"</c:if>>${data.cpnNm }</option>
								</c:forEach>
							</select>
						</ul>
					</dd>
				</div>

				<div id = "netListArea">

				</div>
				<!--//인물네트워크//-->
				<div class="btn_baordZone"><a href="javascript:reloadMainPage();" class="p_withelin_btn">닫기</a></div>
			</div>
		</div>
		<!--//회사상세보기(관련인물)//-->
	</div>
	</form>
	<div id = "ceoHtmlBuf" style="display: none;"></div>
</body>
</html>
