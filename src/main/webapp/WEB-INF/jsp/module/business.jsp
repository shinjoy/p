<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
		//최초 정보셋팅
		businessObj.doSearch();
	});
	var businessObj = {
			doSearch : function(){
				$("#businessFrm").attr("action",contextRoot+"/business/mainBusinessInfoListAjax.do");
				commonAjaxSubmit("POST",$("#businessFrm"),businessObj.mainBusinessCallback);
			},
			mainBusinessCallback:function(data){
				$("#businessArea").empty();

				//list obj
				var list = data.resultObject;

				if(list == undefined || list.length<1){
					//nodata
					$("#businessArea").append("<div class=\"m_nocontxt\">등록된 정보가 없습니다.</div>");

				}else{
					for(var i = 0 ; i <list.length ; i++){

						var dataObj = list[i];
						//tmpl txt
						var businessTmpl = $("#businessTmpl").text();

						businessTmpl = businessTmpl.split("##infoId##").join(dataObj.infoId);
						businessTmpl = businessTmpl.split("##infoPathNm##").join(dataObj.infoPathNm);
						if(dataObj.infoTypeNm!=undefined&&dataObj.infoTypeNm!=""){
							businessTmpl = businessTmpl.split("##infoTypeNm##").join(dataObj.infoTypeNm);
							businessTmpl = businessTmpl.split("##infoTypeDisplay##").join("inline");
						}else
							businessTmpl = businessTmpl.split("##infoTypeDisplay##").join("none");

						if(dataObj.infoClassNm!=undefined&&dataObj.infoClassNm!=""){
							businessTmpl = businessTmpl.split("##infoClassNm##").join(dataObj.infoClassNm);
							businessTmpl = businessTmpl.split("##infoClassDisplay##").join("inline");
						}else
							businessTmpl = businessTmpl.split("##infoClassDisplay##").join("none");

						var title = "["+dataObj.cpnNm1+"]"+devUtil.fn_escapeReplace(dataObj.title);
						businessTmpl = businessTmpl.split("##title##").join(title);

						if(parseInt(dataObj.commentCnt) != 0){
							businessTmpl = businessTmpl.split("##commentCnt##").join(dataObj.commentCnt);
							businessTmpl = businessTmpl.split("##commentCntCss##").join("inline");
						}else
							businessTmpl = businessTmpl.split("##commentCntCss##").join("none");

						var stStr = "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+dataObj.createdBy+"\",$(this),\"mouseover\",null,0,-300,300)'>";
						stStr+= dataObj.createdByNm+"</span>";
						businessTmpl = businessTmpl.split("##createdByNm##").join(stStr);

						if(dataObj.newYn == "Y")
							businessTmpl = businessTmpl.split("##newYnCss##").join("inline");
						else
							businessTmpl = businessTmpl.split("##newYnCss##").join("none");
						var createDate = new Date(dataObj.updateDate);
						var yearStr = createDate.getFullYear()+"";
						var year = yearStr.substring(2,4);
						var month = createDate.getMonth();
						var day = createDate.getDate();
						month = month+1 <10?"0"+(month+1):month+1;
						day = day <10?"0"+day:day;
						businessTmpl = businessTmpl.split("##createDate##").join(year+"/"+(month)+"/"+day);

						$("#businessArea").append(businessTmpl);
					}
				}
				//유저프로필 이벤트 셋팅
				initUserProfileEvent();

			},
			//상세팝업
			openDetailPop : function(infoId){
				$("#businessFrm #infoId").val(infoId);
				$("#businessFrm #fromPage").val("main");
				var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";
				commonPopupOpen("businessDetailPop",contextRoot+"/business/businessDetail.do",option,$("#businessFrm"));
			},
			//더보기 버튼 클릭시...
			moveMorePage : function(){
				$("#businessFrm #recordCountPerPage").val("10");
				$("#businessFrm").attr("action",contextRoot+"/business/businessInfoList.do").submit();

			}
	}



</script>
<!-- List Tmpl... -->
<script type="text" id = "businessTmpl">
	<li>
		<div class="fl_block">
			<a href="javascript:businessObj.openDetailPop('##infoId##')">
				<span class="info_type_cway">##infoPathNm##</span>
				<span class="info_type_c1" style = "display:##infoTypeDisplay##">##infoTypeNm##)</span>
				<span class="info_type_c2" style = "display:##infoClassDisplay##">##infoClassNm##</span>
				<span>##title##</span>
			</a>
			<span class="icon_comment"  style = "display:##commentCntCss##">(##commentCnt##)</span>
			<div style = "display:##newYnCss##"><span class="icon_new" ><em>new</em></span></div>
		</div>
		<div class="fr_block"><span class="bs_name">##createdByNm##</span><span class="bs_date">##createDate##</span></div>
	</li>
</script>
<form id = "businessFrm" name = "businessFrm" method="post">
	<!-- 상세화면 이동을 위한 파라미터  :S -->
	<input type="hidden" id ="infoId" name = "infoId">
	<input type="hidden" id ="fromPage" name = "fromPage">
	<input  type="hidden" id ="sortCol" name = "sortCol" value="UPDATE_DATE">
	<input  type="hidden" id ="sortAD" name = "sortAD" value="DESC">
	<!-- <input type="hidden" id ="recordCountPerPage" name = "recordCountPerPage" value="9"> -->
	<!-- 상세화면 이동을 위한 파라미터  :E -->
	<h2 class="module_title">
	    <strong onclick="businessObj.moveMorePage()">영업정보</strong>
	    <c:if test="${baseUserLoginInfo.vipAuthYn eq 'Y'}"><span>(전체)</span></c:if>
	</h2>
	<div class="module_conBox">
		<ul class="board_mbs_list" id = "businessArea">

		</ul>
		<%--<div class="m_nocontxt">내용이 없습니다.</div>--%>
		<%--<p class="addbtnzone"><button type="button" class="btn_addbusiness" onclick="javascript:void(window.open('/business/business_info_regist.jsp', 'newcr','resizable=no,width=968,height=720,scrollbars=yes'))"><em>정보공유등록</em></button></p>--%>
	</div>
<a href="javascript:businessObj.moveMorePage()" class="btn_more"><em>더보기</em></a>
</form>