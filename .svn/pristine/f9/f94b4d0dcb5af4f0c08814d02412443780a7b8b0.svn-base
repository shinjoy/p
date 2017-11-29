<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	$(document).ready(function(){
		// 체크박스 클릭 이벤트 :S
		$("input[type = 'checkbox']").on("click",function(){
			if($(this).attr("id")=="chkAll"){
				if($(this).prop("checked")){
					$("input[type = 'checkbox']").not("input[disabled = 'disabled']").prop("checked",true);

					$("input[name = 'chkedDoc']").each(function(){
						if($("input[name='refDocStr'][value = '"+$(this).val()+"']").length>0){
							return true;
						}else{
							var stStr = "<input type = 'hidden' name = 'refDocStr' value = '"+$(this).val()+"'>";
							$("#selRefDocListArea").append(stStr);
						}
					});

				}else{
					$("input[type = 'checkbox']").not("input[disabled = 'disabled']").prop("checked",false);

					$("input[name = 'chkedDoc']").each(function(){
						if($("input[name='refDocStr'][value = '"+$(this).val()+"']").length>0){
							$("input[name='refDocStr'][value = '"+$(this).val()+"']").remove();
						}
					});
				}
				return;
			}else{
				if($(this).prop("checked")){
					var stStr = "<input type = 'hidden' name = 'refDocStr' value = '"+$(this).val()+"'>";
					$("#selRefDocListArea").append(stStr);
				}else{
					$("input[name='refDocStr'][value = '"+$(this).val()+"']").remove();
				}
			}
			var chkboxlength = $("input[type = 'checkbox']").not("input[disabled = 'disabled']").not("#chkAll").length;

			if($("input[type = 'checkbox']:checked").not("#chkAll").length == chkboxlength){
				$("#chkAll").prop("checked",true);
			}else{
				$("#chkAll").prop("checked",false);
			}
		});
		// 체크박스 클릭 이벤트 :E

		//입력된 연결문서 체크
		$("input[name = 'chkedDoc']").each(function(){
			if($("input[name='refDocStr'][value = '"+$(this).val()+"']").length>0){
				$(this).prop("checked",true);
			}
		});
		if($("input[name = 'chkedDoc']:checked").length == $("input[name = 'chkedDoc']").length) $("#chkAll").prop("checked",true);

	});
</script>
<!--검색결과有-->
<table class="tb_list_basic" summary="알림내용 (알림날짜, 분류, 사원선택, 알림타입, 내용)">
	<caption>알림내용222</caption>
	<colgroup>
		<col width="40">
		<col width="80">
		<col width="110">
		<col width="80">
		<col width="*">
		<col width="*">
		<col width="80">
		<col width="110">
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><label><input type="checkbox" id = "chkAll"/><em class="hidden">전체선택</em></label></th>
			<th scope="col">구분</th>
			<th scope="col">종결일</th>
			<th scope="col">문서종류</th>
			<th scope="col">문서번호</th>
			<th scope="col">제목</th>
			<th scope="col">완료상태</th>
			<th scope="col">작성자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${approveRefDocList }" var = "data">
			<tr>
				<td>
					<label>
						<input type="checkbox" id = "chkedDoc" name = "chkedDoc" value="${data.appvDocId }|${data.docTitle }" /><em class="hidden">선택</em>
					</label>
				</td>
				<td onclick="openAppvDetailPop('${data.appvDocId}')">
					<c:choose>
						<c:when test="${data.userStatus eq 'SUBMIT' }">상신</c:when>
						<c:when test="${data.userStatus eq 'APPROVE' }">기결</c:when>
						<c:when test="${data.userStatus eq 'RECEIVER' }">수신</c:when>
						<c:when test="${data.userStatus eq 'cc' }">참조</c:when>
					</c:choose>
				</td>
				<td onclick="openAppvDetailPop('${data.appvDocId}')"><fmt:formatDate value="${data.appvEndDate }" pattern="yyyy-MM-dd" /><c:if test = "${empty data.appvEndDate}">-</c:if></td>
				<td onclick="openAppvDetailPop('${data.appvDocId}')">${data.appvDocTypeNm }</td>
				<td onclick="openAppvDetailPop('${data.appvDocId}')">${data.appvDocNum }</td>
				<td onclick="openAppvDetailPop('${data.appvDocId}')">${data.docTitle }</td>
				<td class="app_state" onclick="openAppvDetailPop('${data.appvDocId}')">
					<c:choose>
						<c:when test="${data.docStatus eq 'WORKING' }"><span class="icon st_predoc">${data.docStatusNm }</c:when>
						<c:when test="${data.docStatus eq 'SUBMIT' or data.docStatus eq 'CNL_SUBMIT' }"><span class="icon st_request">${data.docStatusNm }</c:when>
						<c:when test="${data.docStatus eq 'APPROVE' }"><span class="icon st_ing">${data.docStatusNm }</c:when>
						<c:when test="${data.docStatus eq 'REJECT' or data.docStatus eq 'CNL_REJECT' }"><span class="icon st_reject">${data.docStatusNm }</c:when>
						<c:when test="${data.docStatus eq 'COMMIT' or data.docStatus eq 'CNL_COMMIT' }"><span class="icon st_finish">${data.docStatusNm }</c:when>
					</c:choose>

					</span>
				</td>
				<td onclick="openAppvDetailPop('${data.appvDocId}')">${data.createdNm }</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(approveRefDocList) <=0}">
			<td class="no_result" colspan="8">조회된 데이터가 없습니다.</td>
		</c:if>
	</tbody>
</table>
<!--게시판페이지버튼-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
</div>
<!--//게시판페이지버튼//-->
<input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }">
