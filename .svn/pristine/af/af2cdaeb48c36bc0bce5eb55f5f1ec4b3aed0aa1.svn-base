<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" defer="defer">
	$(window).load(function(){
		//최초 정보셋팅
		networkObj.doSearch('all');
	});
	var networkObj = {
			selectedType : "",
			networkCsseJSon : {"COMPANY":"net_company","CUSTOMER":"net_people","MYCUSTOMER":"net_people"},
			doSearch : function(type){
				//탭활성화 초기화
				$(".netWorkTab").removeClass("current");
				//선택한 타입을 전역으로 갖는다.
				networkObj.selectedType = type;
				switch(type){
				//상신문서
				case 'all':
					//탭활성화
					$("#netWorkTabAll").addClass("current");
					$("#networkFrm #searchType").val("ALL");
					//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","searchType").val("ALL");
					//$("#networkFrm").append($searchInput);

					$("#networkFrm").attr("action",contextRoot+"/company/mainListAjax.do");
					//7개만 조회
					//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
					//$("#networkFrm").append($searchInput);

					commonAjaxSubmit("POST",$("#networkFrm"),networkObj.mainNetworkCallback);

					break;
				//회사
				case 'company':
					//탭활성화
					$("#netWorkTabCompany").addClass("current");

					$("#networkFrm").attr("action",contextRoot+"/company/mainListAjax.do");

					$("#networkFrm #searchType").val("COMPANY");
					//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","searchType").val("COMPANY");
					//$("#networkFrm").append($searchInput);

					commonAjaxSubmit("POST",$("#networkFrm"),networkObj.mainNetworkCallback);

					break;
				//고객
				case 'customer':
					//탭활성화
					$("#netWorkTabCustomer").addClass("current");

					$("#networkFrm").attr("action",contextRoot+"/company/mainListAjax.do");

					$("#networkFrm #searchType").val("CUSTOMER");
					//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","searchType").val("CUSTOMER");
					//$("#networkFrm").append($searchInput);

					commonAjaxSubmit("POST",$("#networkFrm"),networkObj.mainNetworkCallback);

					break;
				//내담당
				case 'mycustomer':
					//탭활성화
					$("#netWorkTabMyCustomer").addClass("current");

					$("#networkFrm").attr("action",contextRoot+"/company/mainListAjax.do");

					$("#networkFrm #searchType").val("MYCUSTOMER");
					//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","searchType").val("CUSTOMER");
					//$("#networkFrm").append($searchInput);

					commonAjaxSubmit("POST",$("#networkFrm"),networkObj.mainNetworkCallback);
					break;
				}
			},
			//콜백함수
			mainNetworkCallback : function(data){
				$("#netWorkArea").empty();

				//list obj
				var list = data.resultObject;

				if(list == undefined || list.length<1){
					//nodata
					$("#netWorkArea").append("<div class=\"m_nocontxt\">정보가 없습니다.</div>");

				}else{
					for(var i = 0 ; i <list.length ; i++){
						//tmpl txt
						var networkTmpl = $("#mainNetworkTmpl").text();
						var dataObj = list[i];
						networkTmpl = networkTmpl.split("##sNb##").join(dataObj.sNb);
						networkTmpl = networkTmpl.split("##name##").join(dataObj.name);

						var rgNmStr = "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+dataObj.rgUserId+"\",$(this),\"mouseover\",null,0,-300,300)'>"
							rgNmStr+= dataObj.rgNm+"</span>";
						networkTmpl = networkTmpl.split("##rgNm##").join(rgNmStr);
						networkTmpl = networkTmpl.split("##rgDtStr##").join(dataObj.rgDtStr);
						//진행상태별 css
						var networkCss = networkObj.networkCsseJSon[dataObj.type];
						networkTmpl = networkTmpl.split("##networkCsse##").join(networkCss);

						var infoType = "";

						if(dataObj.infoType == "update") infoType = "수정";
						else if(dataObj.infoType == "create") infoType = "추가";

						networkTmpl = networkTmpl.split("##infoType##").join(infoType);

						var popupFnc = "";
						if(dataObj.type == 'COMPANY'){
							popupFnc = "openCompanyPop";
							networkTmpl = networkTmpl.split("##type##").join("회사");
						}else if (dataObj.type == 'CUSTOMER'||dataObj.type == 'MYCUSTOMER'){
							popupFnc = "openCustomerPop";
							networkTmpl = networkTmpl.split("##type##").join("고객");
						}

						networkTmpl = networkTmpl.split("##popupFnc##").join(popupFnc);

						if(dataObj.newYn == "Y")
							networkTmpl = networkTmpl.split("##newYnCss##").join("inline");
						else
							networkTmpl = networkTmpl.split("##newYnCss##").join("none");


						$("#netWorkArea").append(networkTmpl);
					}
				}
				//유저프로필 이벤트 셋팅
				initUserProfileEvent();
			},
			//더보기 버튼 클릭시...
			moveMorePage : function(){
				switch(networkObj.selectedType){
				//전체
				case 'all':
					$("#networkFrm").attr("action",contextRoot+"/company/index.do").submit();
					break;
				//회사
				case 'company':
					$("#networkFrm").attr("action",contextRoot+"/company/index.do").submit();
					break;
				//고객
				case 'customer':
					$("#networkFrm").attr("action",contextRoot+"/person/personMgmt.do").submit();
					break;
				//내담당고객
				case 'mycustomer':
					$("#networkFrm").attr("action",contextRoot+"/person/personMgmt.do").submit();
					break;
				}
			},
			//상세팝업
			openCompanyPop : function(cpnId){
				var option = "width=968px,height=550px,resizable=yes,scrollbars = yes";
				window.open(contextRoot+"/company/main.do?cpnId="+cpnId,"companyPop",option);
			},
			openCustomerPop : function(sNb){
				var url = "<c:url value='/person/main.do'/>?sNb=" + sNb;
          		var popup = window.open(url, 'cstView', 'resizable=no,width=968,height=720,scrollbars=yes');
			}
	}
</script>

<!-- List Tmpl... -->
<script type="text" id = "mainNetworkTmpl">
	<div class="busi_infoBox" style="cursor:pointer;" onclick="javascript:networkObj.##popupFnc##('##sNb##')">
		<p class="conBox"><span class="icon_new" style = "display:##newYnCss##"><em>new</em></span><span class="mbsicon_set ##networkCsse##">##type##</span><span class="info_type_c2">##infoType##</span><span>##name##</span></p>
		<p class="writeinfo"><span class="writer">##rgNm##ㆍ</span><span class="date">##rgDtStr##</span></p>
	</div>
</script>
<!--네트워크-->
<form id = "networkFrm" name = "networkFrm" method="post">
	<input type="hidden" id = "searchType" name = "searchType">
	<div class="busi_infoWrap">
		<div class="labelsetLine">
			<h3><strong>네트워크(디자인x)</strong><a href="javascript:networkObj.moveMorePage()" class="rdmore_btn"><em>더보기</em></a></h3>
			<%--<button type="button" class="toggle_sort all"><em>전체</em></button>--%>
			<!-- <button type="button" class="toggle_sort personal"><em>개인</em></button> -->
		</div>
		<div class="module_tabList">
			<ul>
				<li class="netWorkTab current notDraggable" id = "netWorkTabAll"><a href="javascript:networkObj.doSearch('all')">전체</a></li>
				<li class="netWorkTab notDraggable" id = "netWorkTabCompany"><a href="javascript:networkObj.doSearch('company')">회사</a></li>
				<li class="netWorkTab notDraggable" id = "netWorkTabCustomer"><a href="javascript:networkObj.doSearch('customer')">고객</a></li>
				<li class="netWorkTab notDraggable" id = "netWorkTabMyCustomer"><a href="javascript:networkObj.doSearch('mycustomer')">내담당</a></li>
			</ul>
		</div>
		<div class="busi_infoList" id = "netWorkArea">
		</div>
	</div>
</form>
<!--//네트워크//-->
