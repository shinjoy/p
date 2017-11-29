<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!--테이블구분-->
<div class="board_classic">
	<div class="leftblock">
		<c:choose>
			<c:when test="${companyVO.searchText ne null and companyVO.searchText ne ''}">
				<span class="count_result"><strong class="fontRed f12">'${companyVO.searchText}'</strong><span class="mgr6">검색결과</span><em>${paginationInfo.totalRecordCount }</em>건</span>
			</c:when>
			<c:otherwise>
				<span class="count_result"><strong>전체</strong><em>${paginationInfo.totalRecordCount }</em>건</span>
			</c:otherwise>
		</c:choose>

		<%--<select class="sh_count_type" title="정렬방법 선택">
	<option value="">15개씩 보기</option>
	<option value="">30개씩 보기</option>
	<option value="">50개씩 보기</option>
</select>--%>
	</div>
	<div class="rightblock">
		<select class="search_type" id = "searchType2" name = "searchType2" onchange="linkPage('1')" title="검색분류 선택">
			<option value="">회사전체</option>
			<option value="listed"
				<c:if test = "${companyVO.searchType2 eq 'listed' }">selected="selected"</c:if>
			>상장</option>
			<option value="unListed"
				<c:if test = "${companyVO.searchType2 eq 'unListed' }">selected="selected"</c:if>
			>비상장</option>
		</select>
		<%--<input type="text" placeholder="검색어입력" class="input_txt_b" title="게시판검색">
<a href="template_manage.jsp" class="btn_wh_bevel">검색</a>--%>
	</div>
</div>
<!--//테이블구분//-->
<!--회사리스트-->
<table class="tb_list_basic" summary="보고서 리스트 (등록일, 제목, 상태, 작성자, 조회)">
	<caption>보고서 리스트</caption>
	<colgroup>
		<col width="*" />
		<col width="100" />
		<col width="100" />
		<col width="*" />
		<col width="100" />
		<%-- <col width="100" /> --%>
	</colgroup>
	<thead>
		<tr>
			<th scope="col">회사명</th>
			<th scope="col">국내외구분</th>
			<th scope="col">상장여부</th>
			<th scope="col">기업내용(업종/대표이름/시가총액/주가)</th>
			<th scope="col">등록일</th>
			<!-- <th scope="col">작성자</th> -->
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${companyListLeft }" var = "data">
			<tr onclick="slctCpn('${data.cpnId }')">
				<td class="txt_b_title">${data.cpnNm }</td>
				<td>${data.domesticYn == 'Y'?'국내':'해외' }</td>
				<td>
					<c:choose>
						<c:when test="${data.aCpnId ne null}">
							<img src="../images/network/icon_kospi.gif" alt="코스피">
						</c:when>
						<c:otherwise>
							<img src="../images/network/icon_unlisted.gif" alt="비상장">
						</c:otherwise>
					</c:choose>

				</td>
				<td class="txt_left">
					${data.categoryBusiness }/
					<c:choose>
						<c:when test="${data.comCd ne null }">
							${data.ceo}
						</c:when>
						<c:otherwise>
							${data.cstNm }
						</c:otherwise>
					</c:choose>
					/${data.stockValue }/${data.unitPrice }
					</td>
				<td class="num_date_type">${data.rgDt }</td>
				<%-- <td class="writer">${data.rgNm }</td> --%>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(companyListLeft)<=0 }">
			<tr>
				<td colspan="6" class="no_result">
					<p class="nr_title">
						<strong>'${companyVO.searchText}'</strong>에 대한 검색결과가 없습니다.
					</p>
					<p class="nr_des">회사신규등록 버튼을 눌러 추가해주세요.</p>
				</td>
			</tr>
		</c:if>
	</tbody>
</table>
<!--//회사리스트//-->
<!--게시판페이지버튼-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
</div>
<!--//게시판페이지버튼//-->