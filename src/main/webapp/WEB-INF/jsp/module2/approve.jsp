<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" defer="defer">
//상태별 css 이미지 style
//var approveDocStatusCsseJSon = {"WORKING":"st_predoc","SUBMIT":"st_request","APPROVE":"st_ing","REJECT":"st_reject","COMMIT":"st_finish"};
//var selectedType="";

$(window).load(function(){
	if('${baseUserLoginInfo.vipAuthYn}' == "Y"){
		approveObj.doSearch('all','A');
	}else{
		approveObj.doSearch('req','Y');
	}
	//최초 정보셋팅

});


var approveObj = {
		selectedType : "",
		doSearch : function(type,secretYn){

			if(secretYn == "A"){
	            $("#approveListAll").hide();
	            $("#approveListUser").show();

	            $(".approveSecretY").hide();

	            $("#approveTabArea").prepend($("#allTabTmpl").text());

	            $("#secretYn").val(secretYn);

	            $("#approveDetailPopYn").val("Y");
	        }else if(secretYn == "Y"){
	        	$("#approveListAll").show();
		        $("#approveListUser").hide();
	            $(".approveSecretY").show();
	            $(".approveSecretN").remove();

	            $("#secretYn").val(secretYn);

	            $("#approveDetailPopYn").val("A");

	            if('${baseUserLoginInfo.vipAuthYn}' != "Y")
	        		$("#approveListAll").remove();
	        }else{
	            secretYn = $("#secretYn").val();
	            $("#approveDetailPopYn").val("A");

	            if('${baseUserLoginInfo.vipAuthYn}' != "Y")
	        		$("#approveListAll").remove();
	        }

			//탭활성화 초기화
			$(".approveTab").removeClass("current");
			//선택한 타입을 전역으로 갖는다.
			approveObj.selectedType = type;
			switch(type){
			//전체
			case 'all':
				//탭활성화
				$("#approveTabAll").addClass("current");

				$("#approveFrm").attr("action",contextRoot+"/approve/mainAppvDocListAjax.do");
				//7개만 조회
				//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
				//$("#approveFrm").append($searchInput);

				commonAjaxSubmit("POST",$("#approveFrm"),approveObj.mainApproveCallback);

				break;
			//상신
			case 'approve':
				//탭활성화
				$("#approveTabApprove").addClass("current");

				$("#approveFrm").attr("action",contextRoot+"/approve/mainDraftDocListAjax.do");

				$("#approveDraftIngYn").val("Y");
				//7개만 조회
				//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
				//$("#approveFrm").append($searchInput);

				commonAjaxSubmit("POST",$("#approveFrm"),approveObj.mainApproveCallback);

				break;
			//기안문서
			case 'draft':
				//탭활성화
				$("#approveTabDraft").addClass("current");

				$("#approveFrm").attr("action",contextRoot+"/approve/mainDraftDocListAjax.do");

				$("#approveDraftIngYn").val("N");
				//7개만 조회
				//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
				//$("#approveFrm").append($searchInput);

				commonAjaxSubmit("POST",$("#approveFrm"),approveObj.mainApproveCallback);

				break;
			//결재문서
			case 'req':
				//탭활성화
				$("#approveTabReq").addClass("current");

				$("#approveFrm").attr("action",contextRoot+"/approve/mainReqDocListAjax.do");
				//7개만 조회
				//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
				//("#approveFrm").append($searchInput);
				$("#approveFrm #listType").val("pendList");
				commonAjaxSubmit("POST",$("#approveFrm"),approveObj.mainApproveCallback);

				break;
			//참조문서
			case 'ref':
				//탭활성화
				$("#approveTaqRef").addClass("current");

				$("#approveFrm").attr("action",contextRoot+"/approve/mainRefDocListAjax.do");
				//7개만 조회
				//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
				//$("#approveFrm").append($searchInput);

				commonAjaxSubmit("POST",$("#approveFrm"),approveObj.mainApproveCallback);

				break;
			//수신문서
			case 'rc':
				//탭활성화
				$("#approveTaqRc").addClass("current");

				$("#approveFrm").attr("action",contextRoot+"/approve/mainRcDocListAjax.do");
				//7개만 조회
				//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
				//$("#approveFrm").append($searchInput);

				commonAjaxSubmit("POST",$("#approveFrm"),approveObj.mainApproveCallback);

				break;
			//취소승인문서
			case 'cancel':
				//탭활성화
				$("#approveTaqCancel").addClass("current");

				$("#approveFrm").attr("action",contextRoot+"/approve/mainCancelReqDocListAjax.do");
				//7개만 조회
				//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
				//$("#approveFrm").append($searchInput);

				commonAjaxSubmit("POST",$("#approveFrm"),approveObj.mainApproveCallback);

				break;
				//지출문서
			case 'expense':
				//탭활성화
				$("#approveTaqExpense").addClass("current");

				$("#approveFrm").attr("action",contextRoot+"/approve/mainExpenseDocListAjax.do");
				//7개만 조회
				//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","recordCountPerPage").val("7");
				//$("#approveFrm").append($searchInput);

				commonAjaxSubmit("POST",$("#approveFrm"),approveObj.mainApproveCallback);

				break;
			}

		},
		//콜백함수
		mainApproveCallback : function(data){
			$("#approveArea").empty();

			//list obj
			var list = data.resultObject;

			if(list == undefined || list.length<1){
				//nodata

                var approveTypeText = "";

                if(approveObj.selectedType == "draft") approveTypeText = "기안";
                else if(approveObj.selectedType == "approve") approveTypeText = "보낸결재";
                else if(approveObj.selectedType == "req") approveTypeText = "받은결재";
                else if(approveObj.selectedType == "ref") approveTypeText = "참조";
                else if(approveObj.selectedType == "cancel") approveTypeText = "취소승인";
                else if(approveObj.selectedType == "expense") approveTypeText = "지출";

				$("#approveArea").append("<div style='padding:80px' class=\"m_nocontxt\">"+approveTypeText+"문서가 없습니다.</div>");

			}else{
				for(var i = 0 ; i <list.length ; i++){
					//tmpl txt
					var approveTmpl = $("#mainApproveTmpl").text();
					var dataObj = list[i];
					approveTmpl = approveTmpl.split("##appvDocId##").join(dataObj.appvDocId);
					approveTmpl = approveTmpl.split("##appvDocClass##").join(dataObj.appvDocClass);
					approveTmpl = approveTmpl.split("##appvDocType##").join(dataObj.appvDocType);
					approveTmpl = approveTmpl.split("##docStatus##").join(dataObj.docStatus);
					approveTmpl = approveTmpl.split("##approveProcessId##").join(dataObj.approveProcessId);
					approveTmpl = approveTmpl.split("##docStatusNm##").join(dataObj.docStatusNm);
					approveTmpl = approveTmpl.split("##userId##").join(dataObj.userId);

					//진행상태별 css
					/* var docStatusCss = approveObj.approveDocStatusCsseJSon[dataObj.docStatus];
					approveTmpl = approveTmpl.split("##docStatusCss##").join(docStatusCss); */
					approveTmpl = approveTmpl.split("##title##").join(dataObj.title);
					approveTmpl = approveTmpl.split("##appvDocClassNm##").join(dataObj.appvDocClassNm);


					if(parseInt(dataObj.commentCnt) != 0){
						approveTmpl = approveTmpl.split("##commentCnt##").join(dataObj.commentCnt);
						approveTmpl = approveTmpl.split("##commentCntCss##").join("inline");
					}else
						approveTmpl = approveTmpl.split("##commentCntCss##").join("none");
					//new아이콘
					if(dataObj.newYn !=null && dataObj.newYn == "Y"){
						approveTmpl = approveTmpl.split("##newYnCss##").join("inline-block");
					}else{
						approveTmpl = approveTmpl.split("##newYnCss##").join("none");
					}

					//받은문서상태 css

					if(approveObj.selectedType =='req'){
						approveTmpl = approveTmpl.split("##listTypeCss##").join("block");
						approveTmpl = approveTmpl.split("##listTypeNm##").join(dataObj.listTypeNm);
					}else{
						approveTmpl = approveTmpl.split("##listTypeCss##").join("none");
					}


					approveTmpl = approveTmpl.split("##userNm##").join(dataObj.userNm);


					//listType
					approveTmpl = approveTmpl.split("##listType##").join(dataObj.listType);

					var createDate = new Date(dataObj.createDate);
					var yearStr = createDate.getFullYear()+"";
					var year = yearStr.substring(2,4);
					var month = createDate.getMonth();
					var day = createDate.getDate();
					month = (month+1) <10?"0"+(month+1):(month+1);
					day = day <10?"0"+day:day;

					approveTmpl = approveTmpl.split("##createDate##").join(year+"/"+month+"/"+day);
					$("#approveArea").append(approveTmpl);
				}
			}
			//유저프로필 이벤트 셋팅
			initUserProfileEvent();
		},
		//더보기 버튼 클릭시...
		moveMorePage : function(){
			switch(approveObj.selectedType){
			//기안문서
			case 'draft':
				$("#approveFrm").attr("action",contextRoot+"/approve/draftDocList.do").submit();
				break;
			//결재문서
			case 'req':
				$("#approveFrm").attr("action",contextRoot+"/approve/approvePendList.do").submit();
				break;
			//참조문서
			case 'ref':
				$("#approveFrm").attr("action",contextRoot+"/approve/approveRefList.do").submit();
				break;
			//취소승인
			case 'cancel':
				$("#approveFrm").attr("action",contextRoot+"/approve/reqCancelList.do").submit();
				break;
				//지출문서
			case 'expense':
				$("#approveFrm").attr("action",contextRoot+"/approve/approveExpenseList.do").submit();
				break;
			}
		},
		goDetailPage:function(appvDocId,appvDocClass, appvDocType, docStatus, approveProcessId,listType){

			$("#approveFrm #appvDocId").val(appvDocId);
			$("#approveFrm #appvDocClass").val(appvDocClass);
			$("#approveFrm #appvDocType").val(appvDocType);
			$("#approveFrm #docStatus").val(docStatus);
			$("#approveFrm #approveProcessId").val(approveProcessId);

			if(approveObj.selectedType == 'all'){
				var option = "width=1100px,height=800px,resizable=yes,scrollbars = yes";
			    commonPopupOpen("approveDetailPop",contextRoot+"/approve/getApproveDrfDetail.do",option,$("#approveFrm"));

			    return;
			}

			var url = "";
			switch(approveObj.selectedType){

			//상신문서
			case 'approve':
				$("#approveFrm #listType").val("draft");
				url = contextRoot+"/approve/getApproveDrfDetail.do";


				break;
			//기안문서
			case 'draft':
				$("#approveFrm #listType").val("docList");
				url = contextRoot+"/approve/getApproveDrfDetail.do";
				break;
			//결재문서
			case 'req':
				$("#approveFrm #listType").val(listType);

				if(listType == 'reqList'){
					url = contextRoot+"/approve/getApproveReqDetail.do";
				}else if(listType == 'proxyList'){
					url = contextRoot+"/approve/approveProxyDetail.do";
				}else if(listType == 'pendList'){
					url = contextRoot+"/approve/approvePendDetail.do";
				}else if(listType == 'nextList'){
					url = contextRoot+"/approve/approveNextDetail.do";
				}else if(listType == 'previous'){
					url = contextRoot+"/approve/approvePreviousDetail.do";
				}
				break;
			//참조문서
			case 'ref':
				$("#approveFrm #listType").val("refList");
				url = contextRoot+"/approve/getApproveRefDetail.do";
				break;
			//참조문서
			case 'rc':
				$("#approveFrm #listType").val("rcList");
				url = contextRoot+"/approve/getApproveRcDetail.do";
				break;
			//취소승인
			case 'cancel':
				$("#approveFrm #listType").val("cancelList");
				url = contextRoot+"/approve/getApproveCancelDetail.do";
				break;
			//지출문서
			case 'expense':
				$("#approveFrm #listType").val("expenseList");
				url = contextRoot+"/approve/approveExpenseDetail.do";
				break;
			}
			var option = "width=1100px,height=800px,resizable=yes,scrollbars = yes";
		    commonPopupOpen("approveDetailPop",url,option,$("#approveFrm"));

			//var newWin = window.open("about:blank","mainApproveNewWin");

			//$("#approveFrm").attr("target","mainApproveNewWin");

			//$("#approveFrm").attr("action",url).submit();

		}
}

</script>
<script type="text" id = "allTabTmpl">
	<li class="approveTab approveSecretN notDraggable" id = "approveTabAll"><a href="javascript:approveObj.doSearch('all')">전체</a></li>
</script>
<!-- List Tmpl... -->
<script type="text" id = "mainApproveTmpl">
	<dl class="elect_approBox">
		<dt><span class="e_docState">##docStatusNm##</span><span class="e_docBox" style = "display:##listTypeCss##">##listTypeNm##</span></dt>
		<dd style="cursor:pointer;" onclick="approveObj.goDetailPage('##appvDocId##','##appvDocClass##','##appvDocType##','##docStatus##','##approveProcessId##','##listType##')">
			<p class="e_doctype">[##appvDocClassNm##]</p>
			<p class="conBox"><span class="icon_new"  style = "display:##newYnCss##"><em>new</em></span><span>##title##</span></p>
			<p class="writeinfo"><span class="writer"><span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("##userId##",$(this),"mouseover",null,0,-300,300)'>##userNm##ㆍ</span></span><span class="date">##createDate##</span><span class="icon_comment n_read"  style = "display:##commentCntCss##">[##commentCnt##]</span></p>
		</dd>
	</dl>
</script>
<form id = "approveFrm" name = "approveFrm" method="post">
	<!-- 상세화면 이동을 위한 파라미터  :S -->
	<input type="hidden" id = "appvDocId" name = "appvDocId">
	<input type="hidden" id = "appvDocClass" name = "appvDocClass">
	<input type="hidden" id = "appvDocType" name = "appvDocType">
	<input type="hidden" id = "docStatus" name = "docStatus">
	<input type="hidden" id = "approveProcessId" name = "approveProcessId">
	<input type="hidden" id = "listType"  name = "listType">
	<input type="hidden" id = "secretYn"  name = "secretYn">
	<input type="hidden" id = "approveDetailPopYn" name = "approveDetailPopYn" value="A">
	<input type="hidden" id = "approveDraftIngYn" name = "approveDraftIngYn" value="N">
	<!-- 상세화면 이동을 위한 파라미터  :E -->

	<!--전자결재-->
	<div class="elect_approWrap">
		<div class="labelsetLine">
			<h3><strong>전자결재</strong><a href="javascript:approveObj.moveMorePage()" class="rdmore_btn"><em>더보기</em></a></h3>
			<button  id="approveListAll" type="button"  onclick="approveObj.doSearch('all','A');" class="toggle_sort all" style="display: none;"><em>전체</em></button>
			<button  id="approveListUser" type="button"  onclick="approveObj.doSearch('req','Y');" class="toggle_sort personal" style="display: none;"><em>개인</em></button>
		</div>
		<div class="module_tabList" style="zoom: 0.92;">
			<ul id = "approveTabArea">
				<li class="approveTab approveSecretY notDraggable" id = "approveTabReq"><a href="javascript:approveObj.doSearch('req')">받은결재</a></li>
				<li class="approveTab approveSecretY notDraggable" id = "approveTabApprove"><a href="javascript:approveObj.doSearch('approve')">보낸결재</a></li>
				<!-- <li class="approveTab approveSecretY" id = "approveTabDraft"><a href="javascript:approveObj.doSearch('draft')">기안</a></li> -->
				<li class="approveTab approveSecretY notDraggable" id = "approveTaqRef"><a href="javascript:approveObj.doSearch('ref')">참조</a></li>
				<li class="approveTab approveSecretY notDraggable" id = "approveTaqRc"><a href="javascript:approveObj.doSearch('rc')">수신</a></li>
				<c:if test="${approveExpenseCnt != null and approveExpenseCnt >0 }">
					<li class="approveTab approveSecretY notDraggable" id = "approveTaqExpense"><a href="javascript:approveObj.doSearch('expense')">지출문서</a></li>
					<!-- <li class="approveTab approveSecretY" id = "approveTaqCancel"><a href="javascript:approveObj.doSearch('cancel')">취소승인</a></li> -->
				</c:if>
			</ul>
		</div>
		<div class="elect_approList" id = "approveArea">

		</div>
	</div>
	<!--//전자결재//-->
</form>
