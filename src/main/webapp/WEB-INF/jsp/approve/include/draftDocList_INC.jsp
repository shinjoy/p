<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<c:if test="${listType eq 'temp' }">
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
	<!--결재문서함-->
	<table class="tb_list_basic" summary="기안문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
		<caption>기안문서함 목록</caption>
		<colgroup>
			<col width="40" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="*" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><label><input type="checkbox" id = "chkAll"/><em class="hidden">전체선택</em></label></th>
				<th scope="col">저장일</th>
				<th scope="col">문서종류 </th>
				<th scope="col">결재라인 </th>
				<th scope="col">제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${draftDocList}" var = "data">
				<tr>
					<td>
						<label>
							<input type="checkbox" id = "chkedDoc" name = "chkedDoc" <c:if test ="${data.appvDocClass eq 'EXPENSE'}">disabled="disabled"</c:if>
								value="${data.appvDocId }|${data.appvDocClass }|${data.appvDocType }|${data.docStatus }|${data.appvProcessId}|${data.individualYn}|${data.appvHeaderId}|${data.familyEventsId}"
								/><em class="hidden">선택</em>
						</label>
					</td>
					<td class="num_date_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')"><fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd" /></td>
					<td class="e_doc_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">${data.appvDocTypeNm }</td>
					<td class="e_doc_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
						${data.appvHeaderIdNm }
						<c:if test="${empty data.appvHeaderIdNm and data.individualYn eq 'Y' }">직접입력</c:if>
					</td>
					<td class="txt_doc_title" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
						<c:choose>
	                   		<c:when test="${data.appvDocClass eq 'BASIC'}">
	                   			기본양식 _
	                   		</c:when>
	                   		<c:when test="${data.appvDocClass eq 'REPORT'}">
	                   			보고서 _
	                   		</c:when>
	                   		<c:when test="${data.appvDocClass eq 'COMPANY'}">
	                   			사내서식 _
	                   		</c:when>
	                   	</c:choose>
	                   	${data.title }

	                    <c:if test = "${data.userId ne data.writerId }">(대리)</c:if>
						<c:if test="${data.commentCnt >0}">
							<span class="ripple">(${data.commentCnt })</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(draftDocList)<=0 }">
				<tr>
					<td colspan="5" class="no_result">
						<p class="nr_des">조회된 데이터가 없습니다.</p>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</c:if>
<c:if test="${listType eq 'draft' }">
	<!--결재문서함-->
	<table class="tb_list_basic" summary="기안문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
		<caption>기안문서함 목록</caption>
		<colgroup>
			<col width="100" />
			<col width="100" />
			<col width="110" />
			<col width="180" />
			<col width="*" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">상신일</th>
				<th scope="col">종결일</th>
				<th scope="col">문서종류 </th>
				<th scope="col">문서번호 </th>
				<th scope="col">제목 </th>
				<th scope="col">진행상황</th>
				<th scope="col">지불여부</th>
				<th scope="col">수신현황</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${draftDocList}" var = "data">
				<tr onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
					<td class="num_date_type">
                    	<fmt:formatDate value="${data.submitDate }" pattern="yyyy-MM-dd" />
                    </td>
					<td class="num_date_type"><fmt:formatDate value="${data.appvEndDate }" pattern="yyyy-MM-dd" /><c:if test = "${empty data.appvEndDate}">-</c:if></td>
					<td class="e_doc_type">${data.appvDocTypeNm }</td>
					<td class="e_doc_type">${data.appvDocNum }</td>
					<td class="txt_doc_title">
						<c:choose>
	                   		<c:when test="${data.appvDocClass eq 'BASIC'}">
	                   			기본양식 _
	                   		</c:when>
	                   		<c:when test="${data.appvDocClass eq 'REPORT'}">
	                   			보고서 _
	                   		</c:when>
	                   		<c:when test="${data.appvDocClass eq 'COMPANY'}">
	                   			사내서식 _
	                   		</c:when>
	                   	</c:choose>
	                   	${data.title }

	                    <c:if test = "${data.userId ne data.writerId }">(대리)</c:if>
						<c:if test="${data.commentCnt >0}">
							<span class="ripple">(${data.commentCnt })</span>
						</c:if>
						<c:if test="${data.newYn eq 'Y'}">
							<span class="icon_new"><em>new</em></span>
						</c:if>
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
					<td>
						<c:choose>
							<c:when test="${data.expenseYn eq 'Y'}">
							지급(${data.expenseUserNm })
							</c:when>
							<c:when test="${data.expenseYn eq 'N'}">
							미지급(${data.expenseUserNm })
							</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
					<td class="doc_writer">
						<c:if test="${data.receiverCnt>0}">
							<c:choose>
								<c:when test="${empty data.rcReceiptId}">수신미확인</c:when>
								<c:otherwise>
									<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.rcReceiptId }",$(this),"mouseover",null,5,-200,200)'>
										수신확인(${data.rcReceiptName })
									</span>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${data.receiverCnt<=0}">-</c:if>
					</td>

				</tr>
			</c:forEach>
			<c:if test="${fn:length(draftDocList)<=0 }">
				<tr>
					<td colspan="8" class="no_result">
						<p class="nr_des">조회된 데이터가 없습니다.</p>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</c:if>
<!--//결재문서함//-->
<!--페이지목록-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
</div>
<input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }">
<!--//페이지목록//-->
<script type="text/javascript">
	$("#totalCnt").text("${paginationInfo.totalRecordCount }");
</script>