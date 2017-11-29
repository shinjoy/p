<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!--------------------------------------------------------------------------------------
-- 추천 네트워크
---------------------------------------------------------------------------------------->
                    <!--추천 네트워크 in Synergy-->
                    <h2 class="title_arrow mgt30">
                    	<span>추천 네트워크<em class="between">( ↔ ${cst.cstNm} )</em></span>
                    	<select class="select_b" name = "searchOrgId" id = "searchOrgId" onchange="linkPageRoot(1)">
							<c:forEach var = "data" items="${orgIdList }">
								<option value="${data.orgId }" <c:if test = "${personVO.searchOrgId eq data.orgId}">selected="selected"</c:if>>${data.cpnNm }</option>
							</c:forEach>
						</select>
                    </h2>

                    <table class="net_table_view" summary="인물정보입력(구분,이름,소속회사,부서,직위,연락처,이메일,친밀도,이력 등)">
                        <caption>인물정보입력</caption>
                        <colgroup>
                            <col width="6%" /><!--순번-->
                            <col width="*%" /><!--루트안내-->
                            <col width="8%" /><!--레벨-->
                            <col width="9%" /><!--친밀도-->
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">루트안내</th>
                                <th scope="col">레벨<!-- 이인희<a href="#" class="sort_normal">레벨<em>정렬</em> --></a></th>
                                <th scope="col">친밀도<!-- 이인희<a href="#" class="sort_normal">친밀도<em>정렬</em> --></a></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var = "tableCount" value="0"></c:set>
                            <c:choose>
	                            <c:when test="${fn:length(networkList) > 0}">
	                            	<c:forEach var="data" items="${networkList}" varStatus="status">
	                            		<c:choose>
	                            			<c:when test="${data.orgId3 eq null and data.orgId4 eq null and data.orgId2 ne null }">
	                            				<c:set var = "tableCount" value="${tableCount+1 }"></c:set>
	                            				<tr>
	                            					<td>${paginationInfo2.currentPageNo*paginationInfo2.recordCountPerPage+tableCount-paginationInfo2.recordCountPerPage }</td>
	                            					<td class="rootStep">
					                            		<span><a href="javascript:openNewPerson('${data.customerSnb1}');" >${data.customerName1}</a></span>
			                            				<span class="tooltip synergyMB"><a href="javascript:openNewPerson('${data.customerSnb2}');" >${data.customerName2}</a></span>
	                            					</td>
	                            					<td>1</td>
	                            					<td class="relationNum">
			                            			 (+${fn:substring(data.customerLvCd2, 4, 5)})
				                                </td>
	                            				</tr>
	                            			</c:when>
	                            			<c:when test="${data.orgId3 ne null and data.orgId4 eq null }">
	                            				<c:set var = "tableCount" value="${tableCount+1 }"></c:set>
	                            				<tr>
	                            					<td>${paginationInfo2.currentPageNo*paginationInfo2.recordCountPerPage+tableCount-paginationInfo2.recordCountPerPage }</td>
	                            					<td class="rootStep">
					                            		<span><a href="javascript:openNewPerson('${data.customerSnb1}');" >${data.customerName1}</a></span>
					                            		<span><a href="javascript:openNewPerson('${data.customerSnb2}');" >${data.customerName2}</a></span>
			                            				<span class="tooltip synergyMB"><a href="javascript:openNewPerson('${data.customerSnb3}');" >${data.customerName3}</a></span>
	                            					</td>
	                            					<td>2</td>
	                            					<td class="relationNum">
			                            			 (+${fn:substring(data.customerLvCd2, 4, 5)})
				                                </td>
	                            				</tr>
	                            			</c:when>
	                            			<c:when test="${data.orgId4 ne null }">
	                            				<c:set var = "tableCount" value="${tableCount+1 }"></c:set>
	                            				<tr>
	                            					<td>${paginationInfo2.currentPageNo*paginationInfo2.recordCountPerPage+tableCount-paginationInfo2.recordCountPerPage }</td>
	                            					<td class="rootStep">
					                            		<span><a href="javascript:openNewPerson('${data.customerSnb1}');" >${data.customerName1}</a></span>
					                            		<span><a href="javascript:openNewPerson('${data.customerSnb2}');" >${data.customerName2}</a></span>
					                            		<span><a href="javascript:openNewPerson('${data.customerSnb3}');" >${data.customerName3}</a></span>
			                            				<span class="tooltip synergyMB"><a href="javascript:openNewPerson('${data.customerSnb4}');" >${data.customerName4}</a></span>
	                            					</td>
	                            					<td>3</td>
	                            					<td class="relationNum">
			                            			 (+${fn:substring(data.customerLvCd2, 4, 5)})
				                                </td>
	                            				</tr>
	                            			</c:when>
	                            		</c:choose>
	                            		</c:forEach>
			                    </c:when>
			                    <c:otherwise>
			                         <tr>
		                                <td colspan="4" class="no_result">추천 네트워크가 없습니다.</td>
		                            </tr>
			                    </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                    <!--//추천 네트워크 in Synergy//-->

                    <!--게시판페이지버튼-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo2}" type="ib" jsFunction="linkPageRoot" />
</div>
<!--//게시판페이지버튼//-->
<div class="btnZoneBox">
   <a href="javascript:reloadMainPage();" class="p_withelin_btn">닫기</a>
</div>
