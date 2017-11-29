<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회사리스트 | 회사 | 네트워크 | PASS (Project based Activity analysis and Sharing system)</title>
<meta name="copyright" content="COPYRIGHT@ Synergy Group" />
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/base.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">

</script>
<script type="text/javascript">
function linkPage(pageNo){
	$("#pageIndex").val(pageNo);
	//document.searchCpn.submit();
	//Ajax 요청으로 바꿈
	commonAjaxSubmit("POST",$("#frm"),callback);
}
//Ajax Callback
function callback(data){
	$("#listArea").html(data);
}
//
function selectedCpn(cpnId,cpnNm,sNb,refOrgid){
	//$(opener.document).find("#frm #cpnId").val(cpnId);
	//$(opener.document).find("#frm").submit();

	opener.cpnPopupCallback(cpnId,cpnNm,sNb,refOrgid);
	window.close();
}
</script>
</head>
<body>
	<div id="compnay_dinfo">
		<!--회사상세보기(회사정보)-->
		<div class="modalWrap2">
			<h1><strong>회사검색</strong></h1>
			<div class="mo_container">
				<!-- <ul class="gray_arrow_list">
					<li>소속회사명을 검색해 보세요 시너지넷 DB에 있으면 가입이 훨씬 수월합니다. </li>
					<li>회사가 검색되지 않으면 ‘신규입력하기’ 버튼을 눌러 내용을 구체적으로 입력해주세요<br />
					아니면 시너지넷 관리자에게 연락부탁드립니다. (고객센터 : 02-586-5981)</li>
				</ul> -->
				<div id="CompanySerach">
					<form id = "frm" name = "frm" action="<c:url value='/company/searchCpnAjax.do' />">
						<input type="hidden" id = "pageIndex" name = "pageIndex">
						<table class="tb_ProfileInfo" summary="회사검색">
							<caption>회사검색</caption>
							<colgroup>
								<col width="140" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" rowspan="2" class="bgGray"><label for="company">회사명</label></th>
									<td><input type="text" id="cpnNm" name="cpnNm" class="applyinput_B" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" autocomplete="off" /><a href="javascript:linkPage('1')" class="mgl8 s_violet01_btn"><em class="search">검색</em></a></td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>

				<div id = "listArea">
					<%-- <c:if test="${searchName ne null and searchName ne '' }"> --%>
					<!--검색결과有-->
					<div class="reaserch_result">
						<p class="reNum">검색결과 : <strong>${paginationInfo.totalRecordCount }</strong></p>
						<div class="re_ComchkList">
						
							<!-- 회사중복체크 -->
							<table class="tb_list_basic3" id="SGridTarget">
								<colgroup>
								<col width="60">
								<col width="*">
								<col width="*">
								<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">회사</th>
										<th scope="col">대표이사</th>
										<th scope="col">회사주소</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>2</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>3</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>4</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>5</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>6</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>7</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>8</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>9</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
									<tr>
										<td>10</td>
										<td class="com_namest"><a href="#">(주)시너지파트너스</a></td>
										<td class="com_ceost">홍길동</td>
										<td class="com_addst">서울특별시 서초구 강남대로 275 강남메인타워 12층</td>
									</tr>
								</tbody>
							</table>
							<!--// 회사중복체크 //-->
							
							<!-- 회사검색이 없을때 신규등록유도 -->
							<table class="tb_list_basic3" id="SGridTarget">
								<colgroup>
								<col width="60">
								<col width="*">
								<col width="*">
								<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">회사</th>
										<th scope="col">대표이사</th>
										<th scope="col">회사주소</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="4" class="no_result">검색결과가 없습니다. 신규등록해 주세요.</td>
									</tr>
								</tbody>
							</table>
							<!--// 회사검색이 없을때 신규등록유도 //-->
							<c:choose>
								<c:when test="${fn:length(companyList)>0 }">
									<ul class="gray_dot_list">
										<c:forEach var = "data" items="${companyList }">
											<li><a href="javascript:selectedCpn('${data.cpnId }','${data.cpnNm }','${data.sNb }','${data.refOrgId }')">${data.cpnNm }</a></li>
										</c:forEach>
									</ul>
								</c:when>
								<c:otherwise>
									<p class="txt"><span>‘${searchName }’</span>에 대한 검색결과가 없습니다.</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<!--게시판페이지버튼-->
					<c:choose>
						<c:when test="${fn:length(companyList)>0 }">
							<div class="btnPageZone">
								<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
							</div>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>

					<!--//게시판페이지버튼//-->
					
					<div class="btnZoneBox">
						<span class="btn_auth"><a href="javascript:fnObj.doSave();" class="p_blueblack_btn"><strong>신규등록</strong></a></span>
						<a href="javascript:window.close();" class="p_withelin_btn">닫기</a>
					</div>
					
					<div class="btnZoneBox">
						<c:if test="${type ne null }">
							<a href="javascript:selectedCpn('')" class="p_blueblack_btn"><strong>신규입력하기</strong></a>
						</c:if>
						<a href="javascript:window.close()" class="p_withelin_btn">취소</a>
					</div>
					
					
					
					
					<table class="tb_list_basic3" id="SGridTarget">
						<colgroup>
						<col width="60">
						<col width="*">
						<col width="*">
						<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">이름</th>
								<th scope="col">핸드폰</th>
								<th scope="col">회사</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>2</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>3</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>4</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>5</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>6</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>7</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>8</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>9</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
							<tr>
								<td>10</td>
								<td class="com_ceost"><a href="#">홍길동</a></td>
								<td class="com_phnst">010-1234-5678</td>
								<td class="com_namest">(주)시너지파트너스</td>
							</tr>
						</tbody>
					</table>
					
					
					<!-- 고객검색이 없을때 신규등록유도 -->
					<table class="tb_list_basic3" id="SGridTarget">
						<colgroup>
						<col width="60">
						<col width="*">
						<col width="*">
						<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">이름</th>
								<th scope="col">핸드폰</th>
								<th scope="col">회사</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="4" class="no_result">검색결과가 없습니다. 신규등록해 주세요.</td>
							</tr>
						</tbody>
					</table>
					<!--// 고객검색이 없을때 신규등록유도 //-->
					
				<%-- </c:if> --%>
				</div>
				<!--//검색결과有//-->
			</div>
		</div>
		<!--//회사상세보기(회사정보)//-->
	</div>
</body>
</html>
