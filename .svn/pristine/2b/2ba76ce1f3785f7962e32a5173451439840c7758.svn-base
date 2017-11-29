<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	function selectInfoType(){
		var searchInfoType = $("#searchInfoTypeBuf").val();
		if(searchInfoType == ""){
			return;
		}
		var url = contextRoot + "/business/getInfoClassCode.do";
		var searchInfoTypeArr = searchInfoType.split("|");

		$("#searchInfoType").val(searchInfoTypeArr[0]);
		var sonCodeName = searchInfoTypeArr[1];
    	var param = {code : sonCodeName};
    	var callback = function(result){
    		$("#searchInfoClass").html("<option value=\"\">선택</option>");
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;		//결과수
    		var list = obj.resultList;		//결과데이터JSON

    		for(var i = 0 ; i < list.length ; i++){
    			$("#searchInfoClass").append("<option value=\""+list[i].cd+"\">"+list[i].nm+"</option>");
    		}
		};

		commonAjax("POST", url, param, callback, true);

	}
	//검색
	function linkPage(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action",contextRoot+"/business/getBusinessCommentList.do");
		commonAjaxSubmit("POST",$("#frm"),searchCallback);
	}

	// 검색 콜백
	function searchCallback(data){
		$("#listArea").html(data);
	}

	//상세팝업
	function openDetailPop(infoId){
		$("#infoId").val(infoId);
		$("#fromPage").val("comment");
		var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";
		commonPopupOpen("businessDetailPop",contextRoot+"/business/businessDetail.do",option,$("#frm"));
	}
	$(document).ready(function(){
		var colorObj = {};
		var comCodeInfoPath = getBaseCommonCode('INFO_PATH', null, 'CD', 'NM', '', '경로선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
		if(comCodeInfoPath == null){
			comCodeInfoPath = [{"CD":"", "NM":"${businessAdminRegist.pathLabel}선택"}];
		}
		var infoPathTypeTag = createSelectTag('searchInfoPath', comCodeInfoPath, 'CD', 'NM', '', null, colorObj, '', 'search_type2');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#searchInfoPathArea").html(infoPathTypeTag);

		var comCodeProgress = getBaseCommonCode('INFO_PROGRESS', null, 'CD', 'NM', '', '진행상태선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
		if(comCodeProgress == null){
			comCodeProgress = [{"CD":"", "NM":"진행상태선택"}];
		}
		var progressTag = createSelectTag('searchProgress', comCodeProgress, 'CD', 'NM', '', null, colorObj, '', 'search_type2 mgl6');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#searchProgressArea").html(progressTag);
	})
</script>



<section id="detail_contents">

<form id = "frm" name = "frm" method="post">
	<!-- 검색 : S -->
	<input type="hidden" id = "pageIndex" name = "pageIndex">
	<!-- 정보정리 리스트에서 이동한건지 코멘트에서 이동한건지 확인을 위해 -->
	<input type="hidden" id="fromPage" name="fromPage">
	<input type="hidden" id = "searchInfoType" name = "searchInfoType">

	<!-- 상세 팝업을 띄우기 위한 파라미터 -->
	<input type="hidden" id = "infoId" name = "infoId">
	<!-- 검색 : E -->
	<!--테이블구분-->
	<div class="board_classic">
		<div class="leftblock">
			<span class="count_result"><strong>전체</strong><em id = "totalCnt"></em>건</span>
			<select class="sh_count_type" id = "recordCountPerPage" name = "recordCountPerPage" title="정렬방법 선택" onchange="linkPage('1')">
				<option value="10" <c:if test = "${searchMap.recordCountPerPage eq '10' }">selected="selected"</c:if>>10개씩 보기</option>
				<option value="20" <c:if test = "${searchMap.recordCountPerPage eq '20' }">selected="selected"</c:if>>20개씩 보기</option>
				<option value="50" <c:if test = "${searchMap.recordCountPerPage eq '50' }">selected="selected"</c:if>>50개씩 보기</option>
			</select>
		</div>

		<div class="rightblock">
			<span class="vmbox">
				<label>
					<input type="checkbox" id = "searchMyList" name = "searchMyList" value="Y" onclick="linkPage('1')"
						<c:if test = "${searchMap.searchMyList eq 'Y'}">checked="checked"</c:if>
					/>
					<span>내가 쓴글</span>
				</label>
			</span>
			<span id="searchInfoPathArea"></span>
			<select class="search_type2 mgl6" title="구분선택" id="searchInfoTypeBuf" onchange="selectInfoType()">
				<option value="">${businessAdminRegist.typeLabel}선택</option>
				<c:forEach items="${infoTypeCodeList }" var = "data">
					<option value="${data.cd }|${data.sonCodeName}">${data.nm }</option>
				</c:forEach>
			</select>
			<select class="search_type2 mgl6" title="유형선택" id = "searchInfoClass" name = "searchInfoClass">
				<option value="">${businessAdminRegist.classLabel}선택</option>
			</select>
			<span id = "searchProgressArea"></span>
			<a href="javascript:linkPage('1');" class="btn_wh_bevel mgl6">검색</a>
		</div>
	</div>
	<!--//테이블구분//-->
	<div id = "listArea">
		<jsp:include page="businessCommentList_INC.jsp"></jsp:include>
	</div>
	<!--버튼영역-->
	<c:if test="${not empty businessAdminRegist }">
		<div class="btn_baordZone">
			<span class="btn_auth"><a href="#" onclick="fnObj.moveBusinessRegist();" class="btn_blueblack">정보등록</a></span>
			<%--<a href="#" class="btn_witheline">반려</a>--%>
		</div>
	</c:if>
</form>

</section>



<script type="text/javascript">

var fnObj = {
	//정보등록 팝업 이동.
	moveBusinessRegist : function(){
		var url = contextRoot + "/business/businessInfoRegist.do";
		window.open(url, 'newcr', 'resizable=no,width=968,height=720,scrollbars=yes');
	}

}

$(function(){

});

</script>