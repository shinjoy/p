<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!--결재문서함-->
    <table class="tb_list_basic" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
        <caption>결재문서함 목록</caption>
        <colgroup>
            <col width="100" />
            <col width="100" />
            <col width="80" />
            <col width="180" />
            <col width="*" />
            <col width="120" />
            <col width="200" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col">상신일</th>
                <th scope="col">등록일</th>
                <th scope="col">구분</th>
                <th scope="col">문서번호</th>
                <th scope="col">제목</th>
                <th scope="col">등록자</th>
                <th scope="col">수신확인현황</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${rcDocList }" var = "data">
                <tr onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
                    <td class="num_date_type"><fmt:formatDate value="${data.submitDate }" pattern="yyyy-MM-dd" /></td>
                    <td class="num_date_type"><fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd" /></td>
                    <td class="e_doc_type">${data.appvDocTypeNm }</td>
                     <td class="e_doc_type">${data.appvDocNum }</td>
                    <td class="txt_doc_title">
                    	<c:choose>
                    		<c:when test="${data.appvDocClass eq 'BASIC'}">
                    			기본양식 _&nbsp;
                    		</c:when>
                    		<c:when test="${data.appvDocClass eq 'REPORT'}">
                    			보고서 _&nbsp;
                    		</c:when>
                    	</c:choose>

                    		${data.title }
                    	<c:if test="${data.commentCnt >0}">
							<span class="ripple">(${data.commentCnt })</span>
						</c:if>
						<c:if test="${data.newYn eq 'Y'}">
							<span class="icon_new"><em>new</em></span>
						</c:if>
                    </td>
                    <td class="doc_writer">
	                    <span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,5,-200,200)'>
								${data.userNm }
						</span>
                    </td>
                    <td class="app_state">
                        <c:choose>
                            <c:when test="${empty data.readDate}"><span class="icon st_request" style="width: 80%;">수신요청</span></c:when>
                            <c:when test="${not empty data.readDate}"><span class="icon st_finish" style="width: 80%;">수신확인:${data.rcReceiptName }(${data.rcReceiptCnt }/${data.totReceiptCnt })</c:when>
                        </c:choose>



                    </td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(rcDocList)<=0 }">
                <tr>
                    <td colspan="7" class="no_result">
                        <p class="nr_des">조회된 데이터가 없습니다.</p>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <!--//결재문서함//-->
    <!--페이지목록-->
    <div class="btnPageZone">
        <ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
    </div>
    <!--//페이지목록//-->
<script type="text/javascript">
    $("#totalCnt").text("${paginationInfo.totalRecordCount }");
</script>