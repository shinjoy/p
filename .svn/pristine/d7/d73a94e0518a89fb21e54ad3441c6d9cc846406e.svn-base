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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/base.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">

</script>
<script type="text/javascript">
function linkPage(pageNo){
	$("#pageIndex").val(pageNo);
	//document.searchCpn.submit();
	//Ajax 요청으로 바꿈
	commonAjaxSubmit("POST",$("#frm"),callback);
}
//Ajax Callback
function callback(data){
	$("#listArea").html(data);
}
//
function selectedCpn(cpnId,cpnNm,sNb,refOrgid){
	//$(opener.document).find("#frm #cpnId").val(cpnId);
	//$(opener.document).find("#frm").submit();
	if(cpnId == 0){
		alert("회사명을 확인해주세요.");
		opener.cpnPopupCallback(cpnId,$("#cpnNm").val());
	}else{
		opener.cpnPopupCallback(cpnId,cpnNm,sNb,refOrgid);
	}
	window.close();
}
</script>
</head>
<body>
	<div id="compnay_dinfo">
		<!--회사상세보기(회사정보)-->
		<div class="modalWrap2">
			<h1><strong>회사검색</strong></h1>
			<div class="mo_container">
				<!-- <ul class="gray_arrow_list">
					<li>소속회사명을 검색해 보세요 시너지넷 DB에 있으면 가입이 훨씬 수월합니다. </li>
					<li>회사가 검색되지 않으면 ‘신규입력하기’ 버튼을 눌러 내용을 구체적으로 입력해주세요<br />
					아니면 시너지넷 관리자에게 연락부탁드립니다. (고객센터 : 02-586-5981)</li>
				</ul> -->
				<div id="CompanySerach">
					<form id = "frm" name = "frm" action="<c:url value='/company/searchCpnAjax2.do' />">
						<input type="hidden" id = "pageIndex" name = "pageIndex">
						<table class="tb_ProfileInfo" summary="회사검색">
							<caption>회사검색</caption>
							<colgroup>
								<col width="140" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" rowspan="2" class="bgGray"><label for="company">회사명</label></th>
									<td><input type="text" id="cpnNm" name="cpnNm" value="${searchName }" class="applyinput_B" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" autocomplete="off" /><a href="javascript:linkPage('1')" class="mgl8 s_violet01_btn"><em class="search">검색</em></a></td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>

				<div id = "listArea">
					<jsp:include page="../include/popSearchCom2_INC.jsp"></jsp:include>
				</div>
				<!--//검색결과有//-->
			</div>
		</div>
		<!--//회사상세보기(회사정보)//-->
	</div>
</body>
</html>
