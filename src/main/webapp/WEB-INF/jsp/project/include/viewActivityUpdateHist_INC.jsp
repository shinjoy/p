<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:scriptlet>
		pageContext.setAttribute("lf", "\n");
	</jsp:scriptlet>
 <table class="tb_list_basic" summary="엑티비티 수정이력">
       <caption>엑티비티 수정이력</caption>
       <colgroup>
           <col width="250" />
           <col width="*" />
           <col width="*" />
           <col width="*" />
           <col width="120" />
           <col width="100" />
       </colgroup>
       <thead>
           <tr>
           	<c:if test="${readTimeYn eq 'Y' }">
           	<th scope="col"><input onclick="contentIdChkAll2($(this));" id = "contentIdChkAll" type="checkbox"></th>
           	</c:if>
               <th scope="col">기간</th>
               <th scope="col">참여자</th>
               <th scope="col">진척율</th>
               <th scope="col">사유</th>
               <th scope="col">수정일</th>
               <th scope="col">수정자</th>
           </tr>
       </thead>
       <tbody>
       		<c:forEach items="${wbsWorkSearchList }" var="data">
       			<tr>
       				<td class="num_date_type">
	                	<fmt:formatDate value="${data.startDate }" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${data.endDate }" pattern="yyyy-MM-dd" />
	                </td>
	                <td>
	                	<span class = "joinmb_list"> 
							<c:set value="${fn:replace(data.concatStr,'#leaderF#','<span class=\"task_leader\">')}" var="leaderReplace"/>
							<c:set value="${fn:replace(leaderReplace,'#noLeaderF#','<span>')}" var="entryReplace"/>
							${fn:replace(entryReplace,'#strEnd#','</span>') } 
						</span>	
	                </td>
	       			<td>
	       				${data.progressRate }% (${data.baseProgressYn eq 'Y'?'산출기준':'수기관리' })
	       			</td>
	       			<td>
	       				${fn:replace(data.updateReason,lf,'<br>') }
	       			</td>
	       			<td class="num_date_type">
	                	<fmt:formatDate value="${data.updateDate }" pattern="yyyy-MM-dd" />
	                </td>
	       			<td>
	       				${data.createdNm }
	       			</td>
       			</tr>
       		</c:forEach>
       		<c:if test="${fn:length(wbsWorkSearchList)<=0 }">
				<tr>
					<td colspan="6" class="no_result">
						<p class="nr_des">조회된 데이터가 없습니다.</p>
					</td>
				</tr>
			</c:if>

       </tbody>
</table>
<!--페이지목록-->
<div class="btnPageZone">
    <ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="activityViewLinkPage" />

    <input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }">
</div>
<!--//페이지목록//-->