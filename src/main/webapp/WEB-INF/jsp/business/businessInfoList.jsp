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
			$("#searchInfoClass").html("<option value=\"\">${businessAdminRegist.classLabel} 전체</option>");
			$("#searchInfoType").val("");
			linkPage(1);
			return;
		}
		var url = contextRoot + "/business/getInfoClassCode.do";
		var searchInfoTypeArr = searchInfoType.split("|");

		$("#searchInfoType").val(searchInfoTypeArr[0]);
		var sonCodeName = searchInfoTypeArr[1];
    	var param = {code : sonCodeName};
    	var callback = function(result){
    		$("#searchInfoClass").html("<option value=\"\">${businessAdminRegist.classLabel} 전체</option>");
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;		//결과수
    		var list = obj.resultList;		//결과데이터JSON

    		for(var i = 0 ; i < list.length ; i++){
    			$("#searchInfoClass").append("<option value=\""+list[i].cd+"\">"+list[i].nm+"</option>");
    		}

    		linkPage(1);
		};

		commonAjax("POST", url, param, callback, true);

	}
	//검색어 검색
	/* function searchText(){
		if($("#searchKeyword").val()==""){
			alert("검색어를 입력해 주세요.");
			return;
		}
		linkPage(1);
	} */
	//검색
	function linkPage(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action",contextRoot+"/business/getBusinessInfoList.do");
		commonAjaxSubmit("POST",$("#frm"),searchCallback);
	}

	// 검색 콜백
	function searchCallback(data){
		$("#listArea").html(data);

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	}
	//재로딩시 체크
	function loadListSortButton(){
	    var sortCol = $("#sortCol").val();
	    var sortAD = $("#sortAD").val();
	    var changeName = "sort_normal";

	    if(sortAD == "ASC") changeName = "sort_lowtohigh";
	    else if(sortAD == "DESC") changeName = "sort_hightolow";
	    else changeName = "sort_normal";

	    if(sortCol == "CREATE_DATE"){
	        $("#aCreateDate").attr("class",changeName);
	        $("#aUpdateDate").attr("class","sort_normal");
	        $("#aViewDate").attr("class","sort_normal");
	    }else if(sortCol == "UPDATE_DATE"){
	        $("#aCreateDate").attr("class","sort_normal");
	        $("#aUpdateDate").attr("class",changeName);
	        $("#aViewDate").attr("class","sort_normal");
	    }else if(sortCol == "VIEW_DATE"){
	        $("#aCreateDate").attr("class","sort_normal");
	        $("#aUpdateDate").attr("class","sort_normal");
	        $("#aViewDate").attr("class",changeName);
	    }else{
	        $("#aCreateDate").attr("class","sort_normal");
	        $("#aUpdateDate").attr("class","sort_hightolow");
	        $("#aViewDate").attr("class","sort_normal");
	    }
	}

	//목록정렬
	function setListSort(sortCol,obj){
	    var nowName = $(obj).attr("class");
	    var sortAD = "ASC";

	    if(nowName == "sort_normal") sortAD = "ASC";
	    else if(nowName == "sort_lowtohigh") sortAD = "DESC";
	    else if(nowName == "sort_hightolow") sortAD = "ASC";
	    else sortAD = "ASC";

	    $("#sortCol").val(sortCol);
	    $("#sortAD").val(sortAD);
	    linkPage("1");
	}

	//상세팝업
	function openDetailPop(infoId){
		$("#infoId").val(infoId);
		$("#fromPage").val("list");
		var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";
		commonPopupOpen("businessDetailPop",contextRoot+"/business/businessDetail.do",option,$("#frm"));

		$("#frm").attr("target","");
	}
	//초기화
	function initialization(){
		$("#searchInfoPath").val("");
		$("#searchProgress").val("");
		$("#searchInfoClass").val("");
		$("#searchInfoTypeBuf").val("");
		$("#searchInfoType").val("");
		$("#searchKeyword").val("");
		$("#searchInfoTypeBuf").change();

		linkPage('1');

	}
	$(document).ready(function(){
		var colorObj = {};
		var comCodeInfoPath = getBaseCommonCode('INFO_PATH', null, 'CD', 'NM', '', '${businessAdminRegist.pathLabel} 전체','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
		if(comCodeInfoPath == null){
			comCodeInfoPath = [{"CD":"", "NM":"${businessAdminRegist.pathLabel} 전체"}];
		}
		var infoPathTypeTag = createSelectTag('searchInfoPath', comCodeInfoPath, 'CD', 'NM', '', "linkPage(1)", colorObj, '', 'search_type2');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#searchInfoPathArea").html(infoPathTypeTag);

		var comCodeProgress = getBaseCommonCode('INFO_PROGRESS', null, 'CD', 'NM', '', '진행상태  전체','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
		if(comCodeProgress == null){
			comCodeProgress = [{"CD":"", "NM":"진행상태  전체"}];
		}
		var progressTag = createSelectTag('searchProgress', comCodeProgress, 'CD', 'NM', '', "linkPage(1)", colorObj, '', 'search_type2 mgl6');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#searchProgressArea").html(progressTag);
		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	})
</script>

<style>
.search_type2{
    line-height: 17px;
    height: 23px;
    box-sizing: border-box;
    vertical-align: middle;
    border: #c2c2c2 solid 1px;
    color: #5a5a5a;
}
</style>


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
			<span class="vmbox">
				<label class = "mgl10">
					<input type="checkbox" id = "searchMyList" name = "searchMyList" value="Y" onclick="linkPage('1')"
						<c:if test = "${searchMap.searchMyList eq 'Y'}">checked="checked"</c:if>
					/>
					<span>내가 쓴글</span>
				</label>
			</span>
			<span id = "searchInfoPathArea" style="padding-left:15px;"></span>
			<select class="search_type2 mgl6" title="${businessAdminRegist.typeLabel} 선택" id = "searchInfoTypeBuf" name = "searchInfoTypeBuf"  onchange="selectInfoType()">
				<option value="">${businessAdminRegist.typeLabel} 전체</option>
				<c:forEach items="${infoTypeCodeList }" var = "data">
					<option value="${data.cd }|${data.sonCodeName}">${data.nm }</option>
				</c:forEach>
			</select>
			<select class="search_type2 mgl6 mgl6" title="${businessAdminRegist.classLabel} 선택" id = "searchInfoClass" name = "searchInfoClass" onchange="linkPage('1')">
				<option value="">${businessAdminRegist.classLabel}  전체</option>
			</select>
			<span id = "searchProgressArea"></span>
		</div>

		<div class="rightblock">
			<input type="text" placeholder="검색어입력" class="input_txt_b" title="게시판검색" id="searchKeyword" name = "searchKeyword" onkeypress="if(event.keyCode==13) {linkPage('1');return false;}">
			<a href="javascript:linkPage(1);" class="btn_wh_bevel mgl6" style="float:left;">검색</a>
			<button type="button" class="btn_s_replay mgl6" onclick="initialization();"><em>초기화</em></button>
		</div>
	</div>
	<!--//테이블구분//-->
	<div id = "listArea">
		<jsp:include page="businessInfoList_INC.jsp"></jsp:include>
	</div>
	<!--버튼영역-->
	<%-- <c:if test="${baseUserLoginInfo.applyOrgId == baseUserLoginInfo.orgId}">auth_style.jsp 로 대체 --%>
		<div class="btn_baordZone">
		<c:if test="${not empty businessAdminRegist }">
			<span class="btn_auth"><a href="#" onclick="fnObj.moveBusinessRegist();" class="btn_blueblack">정보등록</a></span>
			<%--<a href="#" class="btn_witheline">반려</a>--%>
		</c:if>
		<c:if test="${empty businessAdminRegist }">
			<a href="#" onclick="javascript:alertM('정보등록을 위한 기본 정보가 등록 되어있지 않습니다.');" class="btn_blueblack">정보등록</a>
		</c:if>
		</div>
	<%-- </c:if> --%>
</form>

</section>



<script type="text/javascript">

var fnObj = {
	//정보등록 팝업 이동.
	moveBusinessRegist : function(){
		var url = contextRoot + "/business/businessInfoRegist.do";
		window.open(url, 'newcr', 'resizable=no,width=968,height=770,scrollbars=yes');
	}

}

$(function(){

});

</script>