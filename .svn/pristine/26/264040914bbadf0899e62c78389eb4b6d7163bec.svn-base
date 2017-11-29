<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/approve/js/approveCommon_JS.jsp" %>
<script type="text/javascript" defer="defer">
function movePage(type){
	var url = "/";
	switch(type){
	case 'reqBasic':
		url = contextRoot+"/approve/reqBasic.do";
		break;
	case 'reqReport':
		url = contextRoot+"/approve/reqReport.do";
		break;
	case 'reqVac':
		url = contextRoot+"/approve/reqVacation.do";
		break;
	case 'reqPur':
		url = contextRoot+"/approve/reqPurchase.do";
		break;
	case 'reqEdu':
		url = contextRoot+"/approve/reqEdu.do";
		break;
	case 'reqTrip':
		url = contextRoot+"/approve/reqTrip.do";
		break;
	case 'reqEvent':
		url = contextRoot+"/approve/reqEvent.do";
		break;
	case 'rest':
		url = contextRoot+"/approve/reqRest.do";
		break;
	case 'reqExpense':
		url = contextRoot+"/approve/reqExpense.do";
		break;
	}

	$("#frm").attr("action" , url).submit();
}
</script>



<section id="detail_contents">

<div class="e_doc_choicebox">
	<ul class="doc_sample_list">
		<li>
			<a href="javascript:movePage('reqBasic')">
				<p class="img_sum"><img src="../images/approve/img_sum_basic.gif" alt="기본양식"></p>
				<span><em class="icon_basic">기본양식</em></span>
			</a>
			<button type="button" id="btn_Fav_BASIC" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
		<li>
			<a href="javascript:movePage('reqReport')">
				<p class="img_sum"><img src="../images/approve/img_sum_report.gif" alt="보고서"></p>
				<span><em class="icon_report">보고서</em></span>
			</a>
			<button type="button" id="btn_Fav_REPORT" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
		<li>
			<a href="javascript:movePage('reqExpense')">
				<p class="img_sum"><img src="../images/approve/img_sum_report.gif" alt="지출결의서"></p>
				<span><em class="icon_report">지출결의서</em></span>
			</a>
			<button type="button" id="btn_Fav_EXPENSE" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
		<li>
			<a href="javascript:movePage('reqVac')">
				<p class="img_sum"><img src="../images/approve/img_sum_businesstrip.gif" alt="휴가신청"></p>
				<span><em class="icon_vacation">휴가신청</em></span>
			</a>
			<button type="button" id="btn_Fav_VACATION" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
		<li>
			<a href="javascript:movePage('reqPur')">
				<p class="img_sum"><img src="../images/approve/img_sum_purchase.gif" alt="구매신청"></p>
				<span><em class="icon_purchase">구매신청</em></span>
			</a>
			<button type="button" id="btn_Fav_PURCHASE" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
		<li>
			<a href="javascript:movePage('reqEdu')">
				<p class="img_sum"><img src="../images/approve/img_sum_traning.gif" alt="교육신청"></p>
				<span><em class="icon_traing">교육신청</em></span>
			</a>
			<button type="button" id="btn_Fav_EDUCATION" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
		<li>
			<a href="javascript:movePage('reqTrip')">
				<p class="img_sum"><img src="../images/approve/img_sum_businesstrip.gif" alt="출장신청"></p>
				<span><em class="icon_businesstrip">출장신청</em></span>
			</a>
			<button type="button" id="btn_Fav_TRIP" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
		<li>
			<a href="javascript:movePage('reqEvent')">
				<p class="img_sum"><img src="../images/approve/img_sum_familyevent.gif" alt="경조신청"></p>
				<span><em class="icon_familyevent">경조신청</em></span>
			</a>
			<button type="button" id="btn_Fav_EVENT" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
		<li>
			<a href="javascript:movePage('rest')">
				<p class="img_sum"><img src="../images/approve/img_sum_stwork.gif" alt="휴직신청"></p>
				<span><em class="icon_stwork">휴직신청</em></span>
			</a>
			<button type="button" id="btn_Fav_REST" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
		</li>
	</ul>
</div>
<form id = "frm" name = "from" method="post">
	<!-- 검색조건유지 : S -->
	<input type="hidden" id = "searchDocStatus" name = "searchDocStatus" value="${searchMap.searchDocStatus }">
	<input type="hidden" id = "searchTitle" name = "searchTitle" value="${searchMap.searchTitle }">
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" id = "pageIndex" name = "pageIndex" value="${searchMap.pageIndex }">
	<!-- 검색조건유지 : E -->
</form>

</section>