<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

                <!--검색결과有-->
                <div class="reaserch_result">
                    <p class="reNum">검색결과 : <strong>${paginationInfo.totalRecordCount }</strong></p>
                    <div class="re_CompanyList">
                        <c:choose>
                            <c:when test="${empty cstList}">
                                <c:choose>
                                    <c:when test="${not empty personVO.cpnId && empty searchCstNm }">
                                        <p class="txt">등록된 직원 정보가 없습니다.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="txt"><span>‘${searchCstNm}’</span>에 대한 검색결과가 없습니다.</p>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <ul class="gray_dot_list">
		                            <c:forEach var="cst" items="${cstList}" varStatus="status">
		                                <input type="hidden" id="sNb2_${status.count}" value="${cst.sNb}"/>
		                                <input type="hidden" id="name2_${status.count}" value="${cst.cpnNm } : ${cst.cstNm}"/>
		                                <li>
		                                    <a href="javascript:setNetPoint('${cst.sNb}' ,'${cst.cpnSnb}' ,'${cst.cstNm}' ,'${cst.cpnNm}' ,'${cst.team}' ,'${cst.position}' );">${cst.cstNm} (${cst.cpnNm } ${cst.team } ${cst.position})</a>
		                                    <c:if test="${baseUserLoginInfo.userId eq cst.managerId or  cst.managerId eq null}">
		                                        <a class="btn_modify_con"  href="javascript:popRgstCst('UPDATE' , '${cst.sNb}' );" ><em>수정</em></a>
		                                    </c:if>
		                                </li>
		                            </c:forEach>
		                        </ul>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <!--페이지버튼-->
                <div class="btnPageZone">
                    <ui:pagination type="ib" paginationInfo = "${paginationInfo}" jsFunction="linkPage" />
                </div>
                <div class="btnZoneBox">
                	<%-- <c:if test="${type ne null }"> --%>
	                	<a href="javascript:popRgstCst('INSERT' , '');" class="p_blueblack_btn"><strong>신규입력하기</strong></a>
	                <%-- </c:if> --%>
	                <a href="javascript:window.close();" class="p_withelin_btn">취소</a>
                </div>
