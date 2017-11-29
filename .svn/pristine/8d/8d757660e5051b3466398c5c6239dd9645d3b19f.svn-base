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

	<!--결재문서함-->
	<table class="tb_list_basic" summary="기안문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
		<caption>기안문서함 목록</caption>
		<colgroup>
			<col width="40" />
			<col width="120" />
			<col width="120" />
			<col width="120" />
			<col width="180" />
			<col width="*" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><label><input type="checkbox" id = "chkAll"/><em class="hidden">전체선택</em></label></th>
				<th scope="col">유형</th>
				<th scope="col">문서종류 </th>
				<th scope="col">문서타입 </th>
				<th scope="col">문서번호 </th>
				<th scope="col">제목</th>
				<th scope="col">설정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${approveBookmarkFormList}" var = "data">
				<tr>
					<td>
						<label>
							<input type="checkbox" id = "chkedDoc" name = "chkedDoc"
								value="${data.bookmarkAppvDocClass}|${data.bookmarkAppvDocClass eq 'COMPANY'?data.bookmarkAppvCompanyId:data.bookmarkAppvDocId}|${data.appvDocClass}|${data.appvDocId}"
								/><em class="hidden">선택</em>
						</label>
					</td>
					<td onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.bookmarkAppvCompanyId }')">
						<c:choose>
							<c:when test="${data.type eq 'SUBMIT' }">상신</c:when>
							<c:when test="${data.type eq 'BASIC' }">기본서식</c:when>
							<c:when test="${data.type eq 'COMPANY' }">사내서식</c:when>
						</c:choose>
					</td>
					<td onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.bookmarkAppvCompanyId }')">${data.appvDocClassNm }</td>

					<td class="e_doc_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.bookmarkAppvCompanyId }')">
						${data.appvDocTypeNm }
					</td>
					<td>
						${data.appvDocNum }
					</td>
					<td class="txt_doc_title" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.bookmarkAppvCompanyId }')">
						<c:choose>
	                   		<c:when test="${data.appvDocId ne 0 and data.appvDocClass eq 'BASIC'}">
	                   			기본양식 _
	                   		</c:when>
	                   		<c:when test="${data.appvDocId ne 0 and data.appvDocClass eq 'REPORT'}">
	                   			보고서 _
	                   		</c:when>
	                   		<c:when test="${data.appvDocId ne 0 and data.appvDocClass eq 'COMPANY'}">
	                   			사내서식 _
	                   		</c:when>
	                   	</c:choose>
	                   	${data.title }

	                    <c:if test = "${data.userId ne data.writerId }">(대리)</c:if>
						<c:if test="${data.commentCnt >0}">
							<span class="ripple">(${data.commentCnt })</span>
						</c:if>
					</td>
					<td class="num_date_type" onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.bookmarkAppvCompanyId }')"><fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(approveBookmarkFormList)<=0 }">
				<tr>
					<td colspan="7" class="no_result">
						<p class="nr_des">조회된 데이터가 없습니다.</p>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
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