<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
	<c:if test="${fn:length(cstList) != 0}">
	<div style="padding-right:10px;margin-bottom:5px;">
		<table class="t_skinR00">
			<thead>
				<tr><td>
					<table class="t_skinR00"><thead>
						<tr><th class="nameD bgYlw">이름</th><th class="bgYlw">회사</th></tr>
						<tr><th class="bgYlw" colspan="2">직책</th></tr>
					</thead></table>
				</td></tr>
			</thead>
			<tbody>
			<c:forEach var="cst" items="${cstList}" varStatus="status">
				<tr name="result_searched${status.count}" class="pd0 mg0 hand" onclick="slctCst('${cst.sNb}');">
					<td style="padding:0px;">
						<table style="width:100%"><tbody>
							<tr><td class="bd0 pd0 mg0 cent" style="border-right: lightgray solid 1px;width:47px;font-weight:bold;">${cst.cstNm }</td><td class="pd0 mg0" style="font-weight:bold;"><nobr>${cst.cpnNm }</nobr></td></tr>
							<tr><td class="bd0 pd0 mg0" colspan="2" style="text-align:right;font-size:11px;color:gray;">${cst.position}</td></tr>
						</tbody></table>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	</c:if>

	<c:if test="${not empty cstList }">
	<div align="center">
		<ui:pagination type="image" paginationInfo = "${paginationInfo}" jsFunction="linkPage" />
	<%--     <div align="left"><c:out value='${message}'/></div> --%>
	</div>
	</c:if>
	<c:if test="${fn:length(cstList) == 0}"><br/>
	<div class="cent">
		<spring:message code="common.nodata.msg" /><br/><br/>
		<!-- <script>rgstCst('${fn:length(cstList)}');</script> -->
	</div>
	</c:if>
	<c:if test="${fn:length(cstList) <= 20}"><br/>
	<div class="cent">
		<span class="btn black s"><a onclick="rgstCst('${fn:length(cstList)}');">인물 등록하기</a></span>
	</div>
	</c:if>

	<div class="cent"><br/>
		<!-- <span class="btn black s">
			<a onclick="popUp('_0','cstExcel')" id="AP_cstNm_0" class="c_title" title="업로드">인물 일괄업로드</a>
		</span> -->
		<c:if test="${baseUserLoginInfo.permission > '00019'}">
		<span class="btn s">
			<a id="excelDown" title="다운로드">인물 일괄다운로드</a>
		</span>
		</c:if>
	</div>

<form id="excelDownload" name="excelDownload" action="<c:url value='/person/main.do' />" method="post"></form>
<form id="customerName" name="customerName" action="<c:url value='/person/main.do' />" method="post"><input type="hidden" id="s_Name" name="sNb"></form>
<%-- <form id="rgstCstNm" name="rgstCstNm" action="<c:url value='/person/rgstCst.do' />" method="post">
	<input type="hidden" id="s_Name" name="cstNm">
	<input type="hidden" id="s_Name2" name="searchCstNm" value="${searchName}">
</form> --%>
<script>$(".t_skinR00>tbody>tr:even").css("background-color", "#E0F8F7");</script>