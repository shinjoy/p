<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
$(document).ready(function(){
	loadNetListSortButton();
});
</script>

<input type="hidden" id="sortCol" name="sortCol" value="${cst.sortCol }">
<input type="hidden" id="sortAD" name="sortAD" value="${cst.sortAD }"">
<!--------------------------------------------------------------------------------------
-- 인물네트워크 목록
---------------------------------------------------------------------------------------->
                    <!--인물네트워크-->
                    <h2 class="title_arrow">
                        <span>인물네트워크<em class="between">( ↔ ${cst.cstNm} )</em></span>
                        <div class="title_arrow_rightBox">
                            <span class="btn_auth"><a href="javascript:resetPerson('SHOW');"  class="s_3d_gray01_btn"><em class="add">관련인물추가</em></a></span>
                        </div>
                    </h2>
                    <table class="net_table_view" summary="인물정보입력(구분,이름,소속회사,부서,직위,연락처,이메일,친밀도,이력 등)">
                        <caption>인물정보입력</caption>
                        <colgroup>
                            <col width="10%" /><!--이름-->
                            <col width="*" /><!--회사명-->
                            <col width="*" /><!--직위-->
                            <col width="13%" /><!--친밀도-->
                            <col width="*" /><!--관계메모-->
                            <col width="11%" /><!--수정/삭제-->
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col"><a id="aCstNm" onClick="setNetListSort('CST_NM',this);" class="sort_normal" style="cursor:pointer;">이름<em>정렬</em></th>
                                <th scope="col"><a id="aCpnNm"  onClick="setNetListSort('CPN_NM',this);" class="sort_normal" style="cursor:pointer;">회사명<em>정렬</em></th>
                                <th scope="col">직위</th>
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
                                            <em class="edge_topcenter"></em>
                                        </div>
                                        <img src="../images/network/icon_question.gif" alt="?">
                                    </span>
                                    <a id="aLvCd"  onClick="setNetListSort('LV_CD',this);" class="sort_normal" style="cursor:pointer;">친밀도<em>정렬</em>
                                </th>
                                <th scope="col">관계메모</th>
                                <th scope="col">수정/삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${fn:length(netList) > 0}">
                                <c:forEach var="netP" items="${netList}" varStatus="status">
                                   <input type="hidden" id="arrNetCstId" name="arrNetCstId"  value="${netP.cstId}"/>
		                            <input type="hidden" id="snb2${netP.sNb}" value="${netP.cstId}"/>
		                            <input type="hidden" id="snb1${netP.sNb}" value="${cst.sNb}"/>
		                            <input type="hidden" id="npnm${netP.sNb}" value="${cst.cstNm} - ${netP.cstNm}"/>
		                            <tr>
		                                <td><a href="javascript:openNewPerson('${netP.cstId}');" >${netP.cstNm}</a></td>
		                                <td>${netP.cpnNm}</td>
		                                <td>${netP.position}</td>
		                                <td>
		                                  <%--이인희 <td onclick="slctCst('${netP.cstId}');" title="${netP.position}" style="vertical-align:top;"><nobr><b>${netP.cstNm}</b></nobr></td> --%>
		                                    <%-- <c:forEach var="loop5" varStatus="L5" begin="1" end="5">
		                                        <c:if test="${netP.lvCd>=L5.count}">bgLightGray</c:if>
		                                    </c:forEach> --%>
		                                    <ul class="relationGrade">
		                                        <li><a class="${netP.lvCd >= 1 ? 'on' : '' }" ><em>+1</em></a></li>
		                                        <li><a class="${netP.lvCd >= 2 ? 'on' : '' }"><em>+2</em></a></li>
		                                        <li><a class="${netP.lvCd >= 3 ? 'on' : '' }"><em>+3</em></a></li>
		                                        <li><a class="${netP.lvCd >= 4 ? 'on' : '' }"><em>+4</em></a></li>
		                                        <li><a class="${netP.lvCd >= 5 ? 'on' : '' }"><em>+5</em></a></li>
		                                        <li><span class="count">(+${fn:substring(netP.lvCd, 4, 5)})</span></li>
		                                    </ul>
		                                </td>
		                                <td class="txt_left">
		                                	${fn:replace(netP.note,lf, "<br/>")}
		                                	<c:if test="${netP.managerYn eq 'Y' }">(담당자)</c:if>
		                                </td>
		                                <td>
		                                    <c:if test="${baseUserLoginInfo.cusId eq netP.snb1st or baseUserLoginInfo.cusId eq netP.snb2nd}">
		                                    <span class="btn_auth"><a  href="javascript:modifyPerson('${netP.sNb}', '${netP.cstNm}','${netP.cpnNm}','${netP.position}','${netP.lvCd}','${netP.note}','${netP.team}','${fn:substring(netP.lvCd, 4, 5)}' ,'${netP.snb1st}','${netP.snb2nd}')" class="s_white01_btn">수정</a></span><span class="btn_auth"><a href="javascript:deleteNet('${cst.sNb}','${netP.sNb}');"  class="s_white01_btn mgl6">삭제</a></span>
		                                    </c:if>
		                                </td>
		                            </tr>
		                        </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
	                                <td colspan="6" class="no_result">인물 네트워크가 없습니다.</td>
	                            </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>

                    <!--//인물네트워크//-->
<!--게시판페이지버튼-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPageNetwork" />
</div>
<!--//게시판페이지버튼//-->