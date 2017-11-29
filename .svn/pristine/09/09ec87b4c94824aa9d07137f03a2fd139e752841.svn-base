<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!--//직원리스트//-->
 <table class="net_table_view" summary="인물정보입력(구분,이름,소속회사,부서,직위,연락처,이메일,친밀도,이력 등)" id = "netTable">
	<caption>
		인물정보입력
	</caption>
	<colgroup>
		<col width="8%" /><!--직원-->
		<col width="12%" /><!--회사명-->
		<col width="12%" /><!--이름(직위)-->
		<col width="13%" /><!--친밀도-->
		<col width="7%" /><!--레벨-->
		<col width="*" /><!--루트안내-->
		<col width="15%" /><!--관계메모-->
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><!-- <a href="#" class="sort_normal"> -->직원<!-- <em>정렬</em></a> --></th>
			<th scope="col">회사명</th>
			<th scope="col">이름 <em class="f11">(직위)</em></th>
			<th scope="col">
				<span class="explain_tooltip">
					<div id="relationLevel" class="tooltip_box">
						<span class="intext">
							<ul class="levelList">
								<li class="level01"><strong>+1</strong> : 한두번 만난사이</li>
								<li class="level02"><strong>+2</strong> : 명함없이 서로 인지하는 사이</li>
								<li class="level03"><strong>+3</strong> : 사적으로 술한잔 할수있는사이</li>
								<li class="level04"><strong>+4</strong> : 딜에 대한 정보를 공유할 수있는 사이</li>
								<li class="level05"><strong>+5</strong> : 사적 고민을 상담할 수 있는 사이</li>
							</ul>
						</span>
						<em class="edge_topcenter">친밀도</em>
					</div>
					<img src="../images/network/icon_question.gif" alt="?">
				</span>
				친밀도
				<!-- <a href="#" class="sort_normal">친밀도<em>정렬</em></a> -->
			</th>
			<th scope="col"><!-- <a href="#" class="sort_normal"> -->레벨<!-- <em>정렬</em></a> --></th>
			<th scope="col">루트안내</th>
			<th scope="col">관계메모</th>
			<!-- <th scope="col">수정/삭제</th> -->
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${netList }" var = "data">
			<tr id = "netTr_${data.customerSnb1 }" class = "netTr_${data.customerSnb1 }">
				<td id = "cusTd_${data.customerSnb1 }" rowspan="1" class="com_position_name">
					<strong id = "customerPosition1">
						${data.customerPosition1 }
					</strong><br>
					<a href="javascript:openPersonPop('${data.customerSnb1 }')">${data.customerName1 }</a>
				</td>
				<td id = "cpn_${data.customerSnb1 }_${data.customerCpnId2}" rowspan="1">
					<c:if test="${empty data.customerCpnId2 }">소속회사없음</c:if>
					${data.customerCpnName2}
				</td>
				<td class="name_position">
					<a href = "javascript:openPersonPop('${data.customerSnb2 }')">${data.customerName2 }<em>(${data.customerPosition2 })</em></a>
				</td>
				<td class="txt_left">
					<fmt:parseNumber var = "lvl" value="${data.customerLvCd2 }"></fmt:parseNumber>
					<ul class="relationGrade">
						<li><a href="#" style="cursor: default;" <c:if test = "${lvl>0 }"> class="on"</c:if>><em>+1</em></a></li>
						<li><a href="#" style="cursor: default;" <c:if test = "${lvl>1 }"> class="on"</c:if>><em>+2</em></a></li>
						<li><a href="#" style="cursor: default;" <c:if test = "${lvl>2 }"> class="on"</c:if>><em>+3</em></a></li>
						<li><a href="#" style="cursor: default;" <c:if test = "${lvl>3 }"> class="on"</c:if>><em>+4</em></a></li>
						<li><a href="#" style="cursor: default;" <c:if test = "${lvl>4 }"> class="on"</c:if>><em>+5</em></a></li>
						<li><span class="count">(+${lvl })</span></li>
					</ul>
				</td>
				<td>
				<c:choose>
					<c:when test="${data.customerSnb4 ne null}">
						3
					</c:when>
					<c:when test="${data.customerSnb3 ne null}">
						2
					</c:when>
					<c:otherwise>1</c:otherwise>
				</c:choose>
				</td>
				<td class="rootStep">
					<c:if test="${searchOrgId ne data.orgId1 }">
						<span><a href="javascript:openPersonPop('${data.customerSnb1 }')">${data.customerName1}</a></span>
						<span class="tooltip <c:if test = "${data.customerSnb3 eq null }">synergyMB</c:if>"><a href="javascript:openPersonPop('${data.customerSnb2 }')">${data.customerName2}</a></span>
						<c:if test="${data.customerSnb3 ne null}">
							<span class="tooltip <c:if test = "${data.customerSnb4 eq null}">synergyMB</c:if>"><a href="javascript:openPersonPop('${data.customerSnb3 }')">${data.customerName3}</a></span>
						</c:if>
						<c:if test="${data.customerSnb4 ne null}">
							<span class="tooltip synergyMB"><a href="javascript:openPersonPop('${data.customerSnb4 }')">${data.customerName4}</a></span>
						</c:if>
					</c:if>
				</td>




				<td class="txt_left">${data.customerNote2 }</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(netList)<=0 }">
			<td colspan="7" class="no_result">
				<p class="nr_des">직원 정보가 없습니다.</p>
			</td>
		</c:if>
		</tr>
	</tbody>
</table>
<!--//회사리스트//-->
<!--게시판페이지버튼-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
</div>

<!--//게시판페이지버튼//-->
