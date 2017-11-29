<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("input[type = 'checkbox']").on("click",function(){
			if($(this).attr("id")=="chkAll"){
				if($(this).prop("checked")){
					$("input[type = 'checkbox']").not("input[disabled = 'disabled']").prop("checked",true);
				}else{
					$("input[type = 'checkbox']").not("input[disabled = 'disabled']").prop("checked",false);
				}
				return;
			}
			var chkboxlength = $("input[type = 'checkbox']").not("input[disabled = 'disabled']").not("#chkAll").length;

			if($("input[type = 'checkbox']:checked").not("#chkAll").length == chkboxlength){
				$("#chkAll").prop("checked",true);
			}else{
				$("#chkAll").prop("checked",false);
			}
		});
	});
</script>
<c:if test = "${searchMap.listType eq 'reqList' }">
<!--결재문서함-->
	<table class="tb_list_basic" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)" id = "listTable">
		<caption>결재문서함 목록</caption>
		<colgroup>
			<col width="100" />
			<col width="110" />
			<col width="180" />
			<col width="*" />
			<col width="100" />
			<col width="120" />
			<col width="100" />
			<col width="100" />
			<col width="120" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">종결일</th>
				<th scope="col">문서종류</th>
				<th scope="col">문서번호</th>
				<th scope="col">제목</th>
				<th scope="col">진행상태</th>
				<th scope="col">관계사명</th>
				<th scope="col">작성자</th>
				<th scope="col">대상자</th>
				<th scope="col">상신부서</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${reqDocList }" var = "data">
				<tr onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">
					<td class="num_date_type"><fmt:formatDate value="${data.appvEndDate }" pattern="yyyy-MM-dd" /><c:if test = "${empty data.appvEndDate}">-</c:if></td>
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
	                   		<c:when test="${data.appvDocClass eq 'COMPANY'}">
	                   			사내서식 _&nbsp;
	                   		</c:when>
	                   	</c:choose>
	                   		${data.title } <c:if test = "${data.userId ne data.writerId }">(대리)</c:if>
	                   	<c:if test="${data.commentCnt >0}">
							<span class="ripple">(${data.commentCnt })</span>
						</c:if>
						<c:if test="${data.newYn eq 'Y'}">
							<span class="icon_new"><em>new</em></span>
						</c:if>
	                   </td>
	                <td class="app_state">
						<c:choose>
							<c:when test="${data.docStatus eq 'WORKING' }"><span class="icon st_predoc">${data.docStatusNm }</c:when>
							<c:when test="${data.docStatus eq 'SUBMIT' or data.docStatus eq 'CNL_SUBMIT' }"><span class="icon st_request">${data.docStatusNm }</c:when>
							<c:when test="${data.docStatus eq 'APPROVE' }"><span class="icon st_ing">${data.docStatusNm }(${data.lastAppvEmpNm })</c:when>
							<c:when test="${data.docStatus eq 'REJECT' or data.docStatus eq 'CNL_REJECT' }"><span class="icon st_reject">${data.docStatusNm }(종결)</c:when>
							<c:when test="${data.docStatus eq 'COMMIT' or data.docStatus eq 'CNL_COMMIT' }"><span class="icon st_finish">${data.docStatus eq 'COMMIT'?'승인':data.docStatusNm }(종결)</c:when>
						</c:choose>

						</span>
					</td>
					<td>${data.orgNm }</td>
					<td class="doc_writer">
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.writerId }",$(this),"mouseover",null,5,-200,200)'>
							${data.writerNm }
						</span>
					</td>
					<td class="doc_writer">
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,5,-200,200)'>
							${data.userNm }
						</span>
					</td>
					<td class="e_doc_type">${data.writerDeptNm }</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(reqDocList)<=0 }">
				<tr>
					<td colspan="9" class="no_result">
						<p class="nr_des">조회된 데이터가 없습니다.</p>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</c:if>
<c:if test = "${searchMap.listType eq 'proxyList' }">
<table class="tb_list_basic" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)" id = "listTable">
		<caption>결재문서함 목록</caption>
		<colgroup>
			<col width="100" />
			<col width="100" />
			<col width="110" />
			<col width="180" />
			<col width="*" />
			<col width="100" />
			<col width="120" />
			<col width="100" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">상신일</th>
				<th scope="col">종결일</th>
				<th scope="col">문서종류</th>
				<th scope="col">문서번호</th>
				<th scope="col">제목</th>
				<th scope="col">진행상태</th>
				<th scope="col">관계사명</th>
				<th scope="col">원결재자</th>
				<th scope="col">결재실행자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${reqDocList }" var = "data">
				<tr onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">
					<td class="num_date_type"><fmt:formatDate value="${data.submitDate }" pattern="yyyy-MM-dd" /><c:if test = "${empty data.submitDate}">-</c:if></td>
					<td class="num_date_type"><fmt:formatDate value="${data.appvEndDate }" pattern="yyyy-MM-dd" /><c:if test = "${empty data.appvEndDate}">-</c:if></td>
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
	                   		<c:when test="${data.appvDocClass eq 'COMPANY'}">
	                   			사내서식 _&nbsp;
	                   		</c:when>
	                   	</c:choose>
	                   		${data.title } <c:if test = "${data.userId ne data.writerId }">(대리)</c:if>
	                   	<c:if test="${data.commentCnt >0}">
							<span class="ripple">(${data.commentCnt })</span>
						</c:if>
						<c:if test="${data.newYn eq 'Y'}">
							<span class="icon_new"><em>new</em></span>
						</c:if>
	                   </td>
	                <td class="app_state">
						<c:choose>
							<c:when test="${data.docStatus eq 'WORKING' }"><span class="icon st_predoc">${data.docStatusNm }</c:when>
							<c:when test="${data.docStatus eq 'SUBMIT' or data.docStatus eq 'CNL_SUBMIT' }"><span class="icon st_request">${data.docStatusNm }</c:when>
							<c:when test="${data.docStatus eq 'APPROVE' }"><span class="icon st_ing">${data.docStatusNm }(${data.lastAppvEmpNm })</c:when>
							<c:when test="${data.docStatus eq 'REJECT' or data.docStatus eq 'CNL_REJECT' }"><span class="icon st_reject">${data.docStatusNm }(종결)</c:when>
							<c:when test="${data.docStatus eq 'COMMIT' or data.docStatus eq 'CNL_COMMIT' }"><span class="icon st_finish">${data.docStatus eq 'COMMIT'?'승인':data.docStatusNm }(종결)</c:when>
						</c:choose>

						</span>
					</td>
					<td>${data.orgNm }</td>
					<td class="doc_writer">
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvAssignId }",$(this),"mouseover",null,5,-200,200)'>${data.appvAssignNm }</span>
					</td>
					<td class="doc_writer">
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvEmpId }",$(this),"mouseover",null,5,-300,300)'>${data.appvEmpIdNm }</span>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(reqDocList)<=0 }">
				<tr>
					<td colspan="9" class="no_result">
						<p class="nr_des">조회된 데이터가 없습니다.</p>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</c:if>
<c:if test = "${searchMap.listType eq 'pendList' or searchMap.listType eq 'nextList' or searchMap.listType eq 'previous' or searchMap.listType eq 'allList' }">
	<table class="tb_list_basic" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)" id = "listTable">
		<caption>결재문서함 목록</caption>
		<colgroup>
			<col width="40" />
			<col width="100" />
			<col width="100" />
			<col width="110" />
			<col width="180" />
			<col width="*" />
			<col width="100" />
			<col width="120" />
			<col width="100" />
			<col width="100" />
			<col width="120" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><label><input type="checkbox" id = "chkAll"/><em class="hidden">전체선택</em></label></th>
				<th scope="col">상신일</th>
				<th scope="col">최근결재일</th>
				<th scope="col">문서종류</th>
				<th scope="col">문서번호</th>
				<th scope="col">제목</th>
				<th scope="col">진행상태</th>
				<th scope="col">관계사명</th>
				<th scope="col">작성자</th>
				<th scope="col">대상자</th>
				<th scope="col">상신부서</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${reqDocList }" var = "data">
				<tr>
					<td>
						<label>
							<input type="checkbox" id = "chkedDoc" name = "chkedDoc"
								value="${data.appvDocId }|${data.appvDocClass }|${data.appvDocType }|${data.docStatus }|${data.appvProcessId}|${data.appvAgencyId}|${data.dateTo}"
								<%-- <c:if test = "${data.appvStatus ne 'REQ' and data.appvStatus ne 'REQ_ACENCY' and data.appvStatus ne 'WAIT'}">disabled="disabled"</c:if> --%>
								/><em class="hidden">선택</em>
						</label>
					</td>
					<td class="num_date_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')"><fmt:formatDate value="${data.submitDate }" pattern="yyyy-MM-dd" /><c:if test = "${empty data.submitDate}">-</c:if></td>
					<td class="num_date_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')"><fmt:formatDate value="${data.appvCurrentDate }" pattern="yyyy-MM-dd" /><c:if test = "${empty data.appvCurrentDate}">-</c:if></td>
					<td class="e_doc_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">${data.appvDocTypeNm }</td>
					<td class="e_doc_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">${data.appvDocNum }</td>
	                   <td class="txt_doc_title" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">
	                   	<c:choose>
	                   		<c:when test="${data.appvDocClass eq 'BASIC'}">
	                   			기본양식 _&nbsp;
	                   		</c:when>
	                   		<c:when test="${data.appvDocClass eq 'REPORT'}">
	                   			보고서 _&nbsp;
	                   		</c:when>
	                   		<c:when test="${data.appvDocClass eq 'COMPANY'}">
	                   			사내서식 _&nbsp;
	                   		</c:when>
	                   	</c:choose>
	                   		${data.title } <c:if test = "${data.userId ne data.writerId }">(대리)</c:if>
	                   	<c:if test="${data.commentCnt >0}">
							<span class="ripple">(${data.commentCnt })</span>
						</c:if>
						<c:if test="${data.newYn eq 'Y'}">
							<span class="icon_new"><em>new</em></span>
						</c:if>
	                   </td>
	                <td class="app_state" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">
						<c:choose>
							<c:when test="${data.docStatus eq 'WORKING' }"><span class="icon st_predoc">${data.docStatusNm }</c:when>
							<c:when test="${data.docStatus eq 'SUBMIT' or data.docStatus eq 'CNL_SUBMIT' }"><span class="icon st_request">${data.docStatusNm }</c:when>
							<c:when test="${data.docStatus eq 'APPROVE' }"><span class="icon st_ing">${data.docStatusNm }(${data.lastAppvEmpNm })</c:when>
							<c:when test="${data.docStatus eq 'REJECT' or data.docStatus eq 'CNL_REJECT' }"><span class="icon st_reject">${data.docStatusNm }(종결)</c:when>
							<c:when test="${data.docStatus eq 'COMMIT' or data.docStatus eq 'CNL_COMMIT' }"><span class="icon st_finish">${data.docStatus eq 'COMMIT'?'승인':data.docStatusNm }(종결)</c:when>
						</c:choose>

						</span>
					</td>
					<td>${data.orgNm }</td>
					<td class="doc_writer" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">${data.writerNm }</td>
					<td class="doc_writer" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">${data.userNm }</td>
					<td class="doc_writer" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">${data.writerDeptNm }</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(reqDocList)<=0 }">
				<tr>
					<td colspan="11" class="no_result">
						<p class="nr_des">조회된 데이터가 없습니다.</p>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</c:if>
<%-- <c:if test = "${searchMap.listType ne 'reqList' }">
<table class="tb_list_basic" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)" id = "listTable">
		<caption>결재문서함 목록</caption>
		<colgroup>
			<col width="40" />
			<col width="110" />
			<col width="80" />
			<col width="180" />
			<col width="*" />
			<col width="120" />
			<col width="100" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><label><input type="checkbox" id = "chkAll"/><em class="hidden">전체선택</em></label></th>
				<th scope="col">등록일</th>
				<th scope="col">구분</th>
				<th scope="col">문서번호</th>
				<th scope="col">제목</th>
				<th scope="col">등록자</th>
				<th scope="col">결재상태</th>
				<th scope="col">진행상황</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${reqDocList }" var = "data">
				<tr>
					<td>
						<label>
							<input type="checkbox" id = "chkedDoc" name = "chkedDoc"
								value="${data.appvDocId }|${data.appvDocClass }|${data.appvDocType }|${data.docStatus }|${data.appvProcessId}|${data.appvAgencyId}|${data.dateTo}"
								<c:if test = "${data.appvStatus ne 'REQ' and data.appvStatus ne 'REQ_ACENCY' and data.appvStatus ne 'WAIT'}">disabled="disabled"</c:if>
								/><em class="hidden">선택</em>
						</label>
					</td>
					<td class="num_date_type"  onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')"><fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd" /></td>
					<td class="e_doc_type"  onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">${data.appvDocTypeNm }</td>
					<td class="e_doc_type">${data.appvDocNum }</td>
                    <td class="txt_doc_title"  onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">
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
					<td class="doc_writer"  onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,5,-200,200)'>
							${data.userNm }
						</span>
					</td>
					<td class="app_state"  onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">
						<c:choose>
							<c:when test="${data.appvStatus eq 'WAIT' }"><span class="icon st_stay"></c:when>
							<c:when test="${data.appvStatus eq 'REQ' }"><span class="icon st_stay"></c:when>
							<c:when test="${data.appvStatus eq 'REQ_ACENCY' }"><span class="icon st_stay"></c:when>
							<c:when test="${data.appvStatus eq 'REJECT' }"><span class="icon st_reject"></c:when>
							<c:when test="${data.appvStatus eq 'APPROVE' }"><span class="icon st_okay"></c:when>
							<c:when test="${data.appvStatus eq 'ENTRUST' }"><span class="icon st_replace"></c:when>
						</c:choose>
						${data.appvStatusNm }
						</span>
					</td>
					<td class="app_state"  onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }','${data.appvProcessId }')">
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
			<c:if test="${fn:length(reqDocList)<=0 }">
				<tr>
					<td colspan="8" class="no_result">
						<p class="nr_des">조회된 데이터가 없습니다.</p>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</c:if> --%>
<!--//결재문서함//-->
<!--페이지목록-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
</div>
<!--//페이지목록//-->
<input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }">
<script type="text/javascript">
	$("#totalCnt").text("${paginationInfo.totalRecordCount }");
</script>