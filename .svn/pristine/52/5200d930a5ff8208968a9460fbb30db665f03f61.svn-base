<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<form id = "frmLine" name = "codeFrm" method="post">
<input type="hidden" id="appvHeaderId" name="appvHeaderId" value="${appvHeaderId}" />
<input type="hidden" id="userId" name="userId" value="${baseUserLoginInfo.userId}" />
<!-- 직원별 결재라인 지정시 사용함. 지우지 말것
<input type="hidden" id="deptId" name="deptId" value="${baseUserLoginInfo.deptId}" />
<input type="hidden" id="deptNm" name="deptNm" value="${baseUserLoginInfo.deptNm}" />
-->

    <!-- 등록/수정페이지 -->
    <h3 class="grid_title">결재라인 상세정보</h3>
    <table id="lineTable" class="datagrid_input" summary="결재라인 관리 (문서이름, 타입, 금액, 사용여부, 마감여부, 수정자, 등록자)"  arrayVoName="approveVoList" >
        <caption>프로젝트목록</caption>
        <colgroup>
            <col width="100" />
            <col width="14%" span="2" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="80" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col">승인순서</th>
                <th scope="col">승인방식</th>
                <th scope="col">결재유형</th>
                <th scope="col">상세유형</th>
                <!-- <th scope="col">수정자</th> -->
                <th scope="col">최종등록자</th>
                <th scope="col">삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${approveLineList}" varStatus="status">
            <tr id="lineTableTr">
                <td class="txt_center">
                    <input type="hidden" id="appVoList.deptId" name="appVoList.deptId" value="${result.deptId}" />
                    <input type="hidden" id="appVoList.appvUserId" name="appVoList.appvUserId" value="${result.appvUserId}" />
                    <input type="text" id="appVoList.appvSeq" name="appVoList.appvSeq"  value="${result.appvSeq}"  maxlength="4"  class="input_b w_st06" title="승인순서입력" />
                </td>
                <td class="txt_center">
                    <select id="appVoList.appvClass" name="appVoList.appvClass" class="select_b w100pro" title="승인방식선택">
                        <!-- <option value="">승인방식선택</option> -->
                        <!-- <option value="APPROVAL">결재</option> -->
                        <c:forEach var="cmmCd1" items="${cmmCdAppvClassList}" varStatus="status1">
                            <option value="${cmmCd1.cd}"  ${result.appvClass eq cmmCd1.cd ? 'selected' : ''}>${cmmCd1.nm}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <select id="appVoList.appvLineType" name="appVoList.appvLineType"  onChange="changeAppvLineType(this);" class="select_b w100pro" title="결재유형선택">
                        <option value="">결재유형선택</option>
                        <c:forEach var="cmmCd2" items="${cmmCdAppvLineTypeList}" varStatus="status2">
                            <option value="${cmmCd2.cd}"  ${result.appvLineType eq cmmCd2.cd ? 'selected' : ''}>${cmmCd2.nm}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <span id="spanSelectAppvLineBtn">
                        <c:choose>
                            <c:when test="${result.appvLineType eq 'OTHER_DEPT'}">
                                <a onclick="javascript:fnObj.openUserPopup(this, 'DEPT');" class="btn_select_team"><em>부서선택</em></a>
                            </c:when>
                            <c:when test="${result.appvLineType eq 'USER'}">
                                <a onclick="javascript:fnObj.openUserPopup(this, 'USER');" class="btn_select_employee"><em>직원선택</em></a>
                            </c:when>
                        </c:choose>
                    </span>
                    <span id="spanAppvLineDisplayNm">
                        <c:choose>
                            <c:when test="${result.appvLineType eq 'OTHER_DEPT'}">
                                ${result.deptNm}
                            </c:when>
                            <c:when test="${result.appvLineType eq 'USER'}">
                                ${result.appvUserNm}
                            </c:when>
                            <c:otherwise>
                                ${result.appvLineTypeNm}
                            </c:otherwise>
                        </c:choose>
                     </span>
                </td>
                <%-- <td class="txt_center">${result.updatedNm}</td> --%>
                <td class="txt_center">${result.createdNm}</td>
                <td class="txt_center"><button type="button" onClick="deleteRowLine(this);" class="btn_s_type_g btn_auth">삭제</button></td>
            </tr>
            </c:forEach>
            <c:if test="${fn:length(approveLineList) <= 0 }">
            <tr>
                <td id="lineTableNoData" class="no_result" colspan="6">조회된 데이터가 없습니다.</td>
            </tr>
            </c:if>
        </tbody>
    </table>
    <!--//등록/수정페이지//-->
</form>