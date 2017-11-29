<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

    <div class="datagrid_basic_wrap">
        <table class="datagrid_basic" id="approveHeaderTable" summary="결재라인 관리 (문서이름, 타입, 금액, 사용여부, 마감여부, 수정자, 등록자)">
            <caption>프로젝트목록</caption>
            <colgroup>
               <col width="120px"/>
                <col width="120px"/>
                <col width="180px"  />
                <col width="120px"/>
                <col width="120px"/>
                <col width="120px" />
                <col width="80px" />
                <col width="80px" />
                <col width="100px" />
                <col width="100px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" rowspan="2">문서종류</th>
                    <th scope="col" rowspan="2">문서타입</th>
                    <th scope="col" rowspan="2">결재라인명</th>
                    <th scope="col" colspan="3">금액</th>
                    <th scope="col" rowspan="2">사용여부</th>
                    <th scope="col" rowspan="2">마감여부</th>
                    <th scope="col" rowspan="2">수정자</th>
                    <th scope="col" rowspan="2">등록자</th>
                </tr>
                <tr>
                    <th scope="col">전결사용</th>
                    <th scope="col">from</th>
                    <th scope="col">to</th>
                </tr>
            </thead>
            <tbody>
            	<c:set value="N" var = "companyHeaderYn"></c:set>
                <c:forEach var="result" items="${approveHeaderList}" varStatus="status">
	                <c:if test="${status.index eq 0 and result.appvDocClass ne 'COMPANY' }">
	                	<tr>
	                		<td style="font-weight:bold; text-align:left!important;color:#387cc8!important;" colspan="10">>기본서식</td>
	                	</tr>
	                </c:if>
	                <c:if test="${result.appvDocClass eq 'COMPANY' and companyHeaderYn eq 'N'}">
	                	<c:set value="Y" var = "companyHeaderYn"></c:set>
	                	<tr>
	                		<td style="font-weight:bold; text-align:left!important;color:#387cc8!important;" colspan="10">>사내서식</td>
	                	</tr>
	                </c:if>
                <tr onclick="javascript:setUpdFormAppHeader(this, '${result.appvHeaderId}' , '${result.appvDocClass}' , '${result.appvDocType}', '${result.appvHeaderName}','${result.minAmount}', '${result.maxAmount}', '${result.enable}', '${result.closed}','${result.decisionYn}');">
                    <td class="txt_title_type">${result.appvDocClassNm}</td>
                    <td class="txt_left">${result.appvDocTypeNm}</td>
                    <td class="txt_left">${result.appvHeaderName}</td>
                    <td class="txt_center">${result.decisionYn eq 'Y'?'사용':'-'}</td>
                    <td class="txt_letter0">
                        <c:choose>
                            <c:when test="${empty result.minAmount}">-</c:when>
                            <c:otherwise><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${result.minAmount}" /></c:otherwise>
                        </c:choose>
                    </td>
                    <td class="txt_letter0">
                        <c:choose>
                            <c:when test="${empty result.maxAmount}">-</c:when>
                            <c:otherwise><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${result.maxAmount}" /></c:otherwise>
                        </c:choose>
                    </td>
                    <td><span class="special_f_st2 spe_color_st${result.enable eq 'N' ? '4' : '6'}">${result.enable eq 'N' ? 'NO' : 'YES'}</span></td>
                    <td><span class="special_f_st2 spe_color_st${result.closed eq 'N' ? '4' : '6'}">${result.closed eq 'N' ? 'NO' : 'YES'}</span></td>
                    <td>${result.updatedNm}</td>
                    <td>${result.createdNm}</td>
                </tr>
                </c:forEach>
                <c:if test="${fn:length(approveHeaderList) <= 0 }">
	            <tr>
	                <td id="lineTableNoData1"  colspan="8">조회된 데이터가 없습니다.</td>
	            </tr>
	            </c:if>
            </tbody>
        </table>
    </div>