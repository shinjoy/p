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
        	<c:if test="${readTimeYn eq 'Y' }">
        	<col width="10" />  	<!-- 체크박스 -->
        	</c:if>
            <col width="100" />
            <col width="100" />
            <col width="80" />
            <col width="180" />
            <col width="*" />
            <col width="120" />
            <col width="100" />
        </colgroup>
        <thead>
            <tr>
            	<c:if test="${readTimeYn eq 'Y' }">
            	<th scope="col"><input onclick="contentIdChkAll2($(this));" id = "contentIdChkAll" type="checkbox"></th>
            	</c:if>
                <th scope="col">상신일</th>
                <th scope="col">등록일</th>
                <th scope="col">구분</th>
                <th scope="col">문서번호</th>
                <th scope="col">제목</th>
                <th scope="col">등록자</th>
                <th scope="col">진행상황</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${refDocList }" var = "data">
                <tr>
                	<c:if test="${readTimeYn eq 'Y' }">
                	<td><input type="checkbox" name = "contentIdChk" value="${data.appvDocId }"></td>
                	</c:if>
                	<td class="num_date_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
                    	<fmt:formatDate value="${data.submitDate }" pattern="yyyy-MM-dd" />
                    </td>
                    <td class="num_date_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
                    	<fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd" />
                    </td>
                    <td class="e_doc_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
                    	${data.appvDocTypeNm }
                    </td>
                    <td class="e_doc_type">${data.appvDocNum }</td>
                    <td class="txt_doc_title" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
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
							${data.writerNm }
						</span>
                    </td>
                    <td class="app_state">
                        <c:choose>
                            <c:when test="${data.docStatus eq 'WORKING' }"><span class="icon st_predoc"></c:when>
                            <c:when test="${data.docStatus eq 'SUBMIT' or data.docStatus eq 'CNL_SUBMIT' }"><span class="icon st_request"></c:when>
                            <c:when test="${data.docStatus eq 'APPROVE' }"><span class="icon st_ing"></c:when>
                            <c:when test="${data.docStatus eq 'REJECT' or data.docStatus eq 'CNL_REJECT' }"><span class="icon st_reject"></c:when>
                            <c:when test="${data.docStatus eq 'COMMIT' or data.docStatus eq 'CNL_COMMIT' }"><span class="icon st_finish"></c:when>
                        </c:choose>
                        ${data.docStatusNm }
                        </span>

                    </td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(refDocList)<=0 }">
                <tr>
                    <td colspan="<c:choose><c:when test="${readTimeYn eq 'Y' }">8</c:when><c:otherwise>7</c:otherwise></c:choose>" class="no_result">
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
    <!--버튼영역-->
	<div class="btn_baordZone readTimeChkbox" id = "btn_readTimeYn" style="display: none;">
		 <a href="javascript:readChkAll()" class="btn_witheline btn_auth">읽음</a>
	</div>
	<!--//버튼영역//-->
<script type="text/javascript">
    $("#totalCnt").text("${paginationInfo.totalRecordCount }");

    <c:if test="${readTimeYn eq 'Y' }">
    	$("#btn_readTimeYn").show();
    </c:if>
    <c:if test="${readTimeYn ne 'Y' }">
    	$("#btn_readTimeYn").hide();
    </c:if>
</script>