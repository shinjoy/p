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
					<th scope="col">이름</th>
					<th scope="col">회사</th>
					<th scope="col">직위</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="cst" items="${cstList}" varStatus="status">
				<tr name="result_searched${status.count}" class="link" onclick="End('${cst.sNb}','${cst.cstNm }','${cst.cpnId}','${cst.cpnNm }','${cst.position }','${cst.cpnSnb }');">
					<td class="cent" style="text-align:left;padding: 5px 0 5px 5px!important;"><b>${cst.cstNm }</b></td>
					<td class="cent">${cst.cpnNm }</td>
					<td class="cent">${cst.position }</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<c:if test="${not empty cstList }"><br/>
		<div align="center"><ui:pagination type="image" paginationInfo = "${paginationInfo}" jsFunction="linkPage" /></div>
		</c:if>
		
		<%--<c:if test="${empty cstList }"><script>popRgstCst('${fn:length(cstList)}');</script></c:if> --%>

		<%-- <c:if test="${fn:length(cstList) <= 5}">
		<div style="text-align:center;"><br/>
			<span style="cursor:pointer;"><a onclick="window.resizeTo(700,500);popRgstCst('${fn:length(cstList)}');" class="btn_finish_ok">신규 등록하기</a></span>
		</div>
		</c:if> --%>
		
		<div class="btn_pop_basic">
			<button type="button" class="btn_pop_gray01" style="height:26px;margin-left:100px;" onClick="javascript:window.close();">닫기</button>
			<span style="cursor:pointer;float:right;"><a onclick="window.resizeTo(730,500);popRgstCst('${fn:length(cstList)}');" class="btn_finish_ok">신규 등록하기</a></span>
			<!-- <button type="button" class="btn_pop_white01">확인</button> -->
		</div> 
		
	</div>
<!-- <script>$("tr:even").css("background-color", "#E0F8F7");</script> -->