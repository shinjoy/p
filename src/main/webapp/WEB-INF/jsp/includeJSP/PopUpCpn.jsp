<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
	<div class="_popUpWidth">
		<table class="pop_tb_basic">
			<thead>
				<tr>
					<th>법인명</th>
					<th style="width:60px;">코드</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="cpn" items="${companyList}" varStatus="status">
				<tr class="link" onclick="End('${cpn.cpnId}','${cpn.cpnNm }','${cpn.sNb}');">
					<td class="cent"><b>${cpn.cpnNm }</b></td>
					<td class="cent" style="padding: 5px 0 5px 0 !important;">${cpn.aCpnId}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<c:if test="${not empty companyList }"><br/>
		<div align="center">
			<ui:pagination type="image" paginationInfo = "${paginationInfo}" jsFunction="linkPage" />
		</div>
		</c:if>

		<c:if test='${param.fromInside ne "y"}'>
		<div class="cent" style="float:right;padding-right:5px;"><br/>
			<span class="btn black s"><a onclick="popRgstCpn();">등록하기</a></span>
		</div>
		</c:if>
		
		<div class="btn_pop_basic">
			<button type="button" class="btn_pop_gray01" style="height:26px;" onClick="javascript:window.close();">닫기</button>
			<!-- <button type="button" class="btn_pop_white01">확인</button> -->
		</div> 
		
	</div>
<!-- <script>$("tr:even").css("background-color", "#E0F8F7");</script> -->