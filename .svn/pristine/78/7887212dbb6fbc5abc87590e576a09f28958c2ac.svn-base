<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

                <!--검색결과有-->
                <div class="reaserch_result">
                    <p class="reNum">검색결과 : <strong>${paginationInfo.totalRecordCount }</strong></p>
                        <table class="tb_list_basic3" id="SGridTarget">
	                        <colgroup>
	                        <col width="60">
	                        <col width="*">
	                        <col width="*">
	                        <col width="*">
	                        </colgroup>
	                        <thead>
	                            <tr>
	                                <th scope="col">번호</th>
	                                <th scope="col">이름</th>
	                                <th scope="col">핸드폰</th>
	                                <th scope="col">회사</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <c:forEach var="cst" items="${cstList}" varStatus="status">
	                                <input type="hidden" id="sNb2_${status.count}" value="${cst.sNb}"/>
                                    <input type="hidden" id="name2_${status.count}" value="${cst.cpnNm } : ${cst.cstNm}"/>
		                            <tr>
		                                <td>${status.count}</td>
		                                <td class="com_ceost"><a href="javascript:updateCstInfo('${cst.sNb}' ,'${cst.cpnSnb}' ,'${cst.cstNm}' ,'${cst.cpnNm}' ,'${cst.team}' ,'${cst.position}' );">${cst.cstNm}</a></td>
		                                <td class="com_phnst">${cst.mobile}</td>
		                                <td class="com_namest">${cst.cpnNm}</td>
		                            </tr>
		                        </c:forEach>
		                            <c:if test="${empty cstList}">
		                                <c:choose>
		                                    <c:when test="${not empty personVO.cpnId && empty searchCstNm }">
		                                        <tr>
                                                    <td colspan="4" class="no_result">검색결과가 없습니다. 신규등록해 주세요.</td>
                                                </tr>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <tr>
			                                        <td colspan="4" class="no_result"><span>‘${searchCstNm}’</span>에 대한 검색결과가 없습니다. 신규등록해 주세요.</td>
			                                    </tr>
		                                    </c:otherwise>
		                                </c:choose>
		                            </c:if>

	                        </tbody>
	                    </table>

                </div>
                <!--페이지버튼-->
                <div class="btnPageZone">
                    <ui:pagination type="ib" paginationInfo = "${paginationInfo}" jsFunction="linkPage" />
                </div>
                <div class="btnZoneBox">
                	<span class="btn_auth"><a href="javascript:setNewCst();" class="p_blueblack_btn"><strong>신규등록</strong></a></span>
	                <a href="javascript:window.close();" class="p_withelin_btn">닫기</a>
                </div>
