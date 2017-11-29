<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main</title>
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/new_ib.css'/>" rel="stylesheet" type="text/css">
<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.min.js'/>" ></script>
<script>
End = function(cpnId,cpnNm){
	//var arg= window.dialogArguments;
	var rVal = new Object();
	
	rVal.f = <c:if test="${empty MDf}">Request('f')</c:if><c:if test="${not empty MDf}">'${MDf}'</c:if>;
	rVal.n = <c:if test="${empty MDn}">Request('n')</c:if><c:if test="${not empty MDn}">'${MDn}'</c:if>;
	rVal.nm = cpnNm;
	rVal.snb = cpnId;
	
	if (window.opener) window.opener.returnPopUp(rVal);
	window.close();
};
</script>
</head>
<body>

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
	
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<input type="hidden" id="tmpTak" value="popUpReg">

	<header>
	</header>
	<section>
		<article>
			<table class="net_table_apply">
				<colgroup>
		          <col width="24%">
		          <col width="*">
       			</colgroup>
       			<tbody>
					<tr>
						<td colspan="2">
							<input type="radio" name="rdo_offer" id="offerListed"><label for="offerListed">상장</label>
							<input type="radio" name="rdo_offer" id="offerNlisted" checked="checked"><label for="offerNlisted">비상장</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="star">*</span>코드</th>
						<td>
							<span id="cpn__id">${maxCpnId+1}</span>
							<input type="text" id="cpn_id" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="star">*</span>회사명</th>
						<td colspan="1">
							<input type="text" id="cpn_nm" class="applyinput_B w_st01" value="${cpnNm}"/>
						</td>
					</tr>
					<%-- <tr>
						<th class="tbColor inputLine">대표이사</th>
						<td>
							<input type="hidden" id="AP_cstId_0" value="${workVO.cstId }"/>
							<a onclick="popUp('_0','p')" id="AP_cstNm_0" class="c_title" title="이름">이름선택</a>
						</td>
					</tr> --%>
				
					<tr>
						<td colspan="2">
						<p class="bsnsR_btn">
							<span class="newCpn_btnOk btn s blue"><a>저장</a></span>
						</p>
						</td>
					</tr>
				</tbody>
			</table>
		</article>
	</section>
</body>
</html>