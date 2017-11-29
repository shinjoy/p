<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<c:set var="agreeYn" value="N"></c:set>
<table class="signBoxWrap">
    <caption>결재라인</caption>
    <colgroup>
        <col width="*" />
        <col width="20" />
        <col width="*" />
    </colgroup>
    <tr>
    	<td class="approve_signBox">
            <table class="sign_tb_st" summary="결재라인">
                <caption>결재라인</caption>
                <colgroup>
                    <col width="20" />
                    <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                        <c:if test="${data.appvAssignId ne null and data.appvClass eq 'APPROVAL' }">
                            <col width="*" />
                        </c:if>
                    </c:forEach>
                </colgroup>
                <tr class="sign_here">
                    <th scope="row" rowspan="2">결재</th>
                    <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                        <c:if test="${data.appvAssignId ne null and data.appvClass eq 'APPROVAL' }">
                            <c:choose>
                                <c:when test="${data.appvStatus eq 'APPROVE' }"><td><img src="${pageContext.request.contextPath}/images/approve/sign_approve.gif" alt="승인"></td></c:when>
                                <c:when test="${data.appvStatus eq 'REJECT' }"><td><img src="${pageContext.request.contextPath}/images/approve/sign_reject.gif" alt="거절"></td></c:when>
                                <c:otherwise><td>&nbsp;</td></c:otherwise>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                </tr>
                <tr class="part_type">
                    <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                        <c:if test="${data.appvAssignId ne null and data.appvClass eq 'APPROVAL' }">
                            <td>
                                <p>
                                	<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvAssignId}",$(this),"mouseover",null,5,-80,80)'>
				           				<strong>${data.appvAssignNm}</strong>
				           			</span>
                                	<em>(${data.rankNm})</em>
                                </p>
                                <p><span>${data.deptNm}</span></p>
                        </c:if>
                    </c:forEach>
                </tr>
            </table>
        </td>
         <td>&nbsp;</td>
        <td class="agree_signBox">
            <table class="sign_tb_st" summary="합의라인">
                <caption>합의라인</caption>
                <colgroup>
                    <col width="20" />
                    <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                        <c:if test="${data.appvAssignId ne null and data.appvClass eq 'AGREE' }">
                            <c:if test="${i.index > -1 }">
                                <c:set var="agreeYn" value="Y"></c:set>
                            </c:if>
                            <col width="*" />
                        </c:if>
                    </c:forEach>
                </colgroup>
                <tr class="sign_here">
                    <th scope="row" rowspan="2">합의</th>
                    <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                        <c:if test="${data.appvAssignId ne null and data.appvClass eq 'AGREE' }">
                            <c:choose>
                                <c:when test="${data.appvStatus eq 'APPROVE' }"><td><img src="${pageContext.request.contextPath}/images/approve/sign_approve.gif" alt="승인"></td></c:when>
                                <c:when test="${data.appvStatus eq 'REJECT' }"><td><img src="${pageContext.request.contextPath}/images/approve/sign_reject.gif" alt="거절"></td></c:when>
                                <c:otherwise><td>&nbsp;</td></c:otherwise>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                </tr>
                <tr class="part_type">
                    <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                        <c:if test="${data.appvAssignId ne null and data.appvClass eq 'AGREE' }">
                            <td>
                                <p>
                                	<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvAssignId}",$(this),"mouseover",null,5,-80,80)'>
				           				<strong>${data.appvAssignNm}</strong>
				           			</span>
                                	<em>(${data.rankNm})</em>
                                </p>
                                <p><span>${data.deptNm}</span></p>
                        </c:if>
                    </c:forEach>
                </tr>
            </table>
        </td>
    </tr>
</table>
<script type="text/javascript">
	var agreeYn = "${agreeYn}";

	if(agreeYn == 'N') $(".agree_signBox").hide();

</script>





















    <div class="agree_signBox">
        <%--<table class="sign_tb_st" summary="결재라인(담당자/팀장/부서장/대표)">
            <caption>합의라인</caption>
            <colgroup>
                <col width="20" />
                <col width="23.5%" span="4" />
            </colgroup>
            <tr class="sign_here">
                <th scope="row" rowspan="2">합의</th>
                <td><img src="../images/approve/@sign01.gif" alt=""></td>
                <td><img src="../images/approve/@sign02.gif" alt=""></td>
                <td><img src="../images/approve/@sign03.gif" alt=""></td>
                <td>&nbsp;</td>
            </tr>
            <tr class="part_type">
                <td>담당자</td>
                <td>팀장</td>
                <td>부서장</td>
                <td>대표</td>
            </tr>
        </table>--%>
    </div>
   <%--  <div class="approve_signBox" style="width: inherit;">
        <table class="sign_tb_st" summary="결재라인">
            <caption>결재라인</caption>
            <colgroup>
                <col width="20" />
                <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                	<c:if test="${data.appvAssignId ne null }">
		                <col width="90" span="4" />
	                </c:if>
                </c:forEach>
            </colgroup>
            <tr class="sign_here">
                <th scope="row" rowspan="2">결재</th>
                <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                	<c:if test="${data.appvAssignId ne null and data.appvClass eq 'APPROVAL' }">
	                    <c:choose>
	                        <c:when test="${data.appvStatus eq 'APPROVE' }"><td><img src="${pageContext.request.contextPath}/images/approve/sign_approve.gif" alt="승인"></td></c:when>
	                        <c:when test="${data.appvStatus eq 'REJECT' }"><td><img src="${pageContext.request.contextPath}/images/approve/sign_reject.gif" alt="거절"></td></c:when>
	                        <c:otherwise><td>&nbsp;</td></c:otherwise>
	                    </c:choose>
                    </c:if>
                </c:forEach>
            </tr>
            <tr class="part_type">
                <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                	<c:if test="${data.appvAssignId ne null and data.appvClass eq 'APPROVAL' }">
                    	<td>
                    		<p><strong>${data.appvAssignNm}</strong><em>(${data.rankNm})</em></p>
                    		<p><span>${data.deptNm}</span></p>
                    </c:if>
                </c:forEach>
            </tr>
            <tr class="sign_here">
                <th scope="row" rowspan="2">합의</th>
                <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                	<c:if test="${data.appvAssignId ne null and data.appvClass eq 'AGREE'}">
	                    <c:choose>
	                        <c:when test="${data.appvStatus eq 'APPROVE' }"><td><img src="${pageContext.request.contextPath}/images/approve/sign_approve.gif" alt="승인"></td></c:when>
	                        <c:when test="${data.appvStatus eq 'REJECT' }"><td><img src="${pageContext.request.contextPath}/images/approve/sign_reject.gif" alt="거절"></td></c:when>
	                        <c:otherwise><td>&nbsp;</td></c:otherwise>
	                    </c:choose>
                    </c:if>
                </c:forEach>
            </tr>
            <tr class="part_type">
                <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                	<c:if test="${data.appvAssignId ne null and data.appvClass eq 'AGREE' }">
                    	<td>
                    		<p><strong>${data.appvAssignNm}</strong><em>(${data.rankNm})</em></p>
                    		<p><span>${data.deptNm}</span></p>
                    </c:if>
                </c:forEach>
            </tr>
        </table>
    </div> --%>