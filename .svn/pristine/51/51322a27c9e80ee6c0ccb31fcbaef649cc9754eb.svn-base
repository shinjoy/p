<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 response.reset();
 response.setContentType("application/vnd.ms-excel;charset=utf-8"); 
 response.setHeader("Content-Disposition", "attachment; filename=IncCapExcel.xls");
 response.setHeader("Content-Description", "Tetris GameLog Data");
%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>excelDownload</title>
</head>
<body>

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
	<table>
		<thead>
			<tr>
				<th>접수일자</th>				
				<th>구분</th>
				<th>회사명</th>
				<th>증자방식</th>
				<th>발행규모(억)</th>
				<th>배정기준일</th>
				<th>신주인수권상장일</th>
				<th>청약일</th>
				<th>할인율</th>
				<th>주관회사(담당자)</th>
				<th>인수자</th>
				<th>딜 선택</th>
			</tr>
		</thead>
	</table>
	<table>
		<tbody>
			<c:forEach var="nt" items="${NoticeList}" varStatus="ntS">
				<tr>
					<td>${nt.tmDt}</td>
					<td>${nt.categoryCd}</td>
					<td>${nt.cpnNm}</td>
					<td>${nt.way}</td>
					<td>${nt.price}</td>
					<td>${nt.assignmentDt}</td>
					<td>${nt.payupDt}</td>
					<td>${nt.subscriptionDt}</td>
					<td>${nt.refixSale}%</td>
					<td>${nt.superCpn}</td>
					<td>${nt.underWriter}</td>
					<td><c:if test="${nt.tmpNum1>0}">딜 추가됨</c:if></td>					
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>