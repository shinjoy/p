<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/gboardTree.js?ver=0.2"></script>			<!-- jstree 사용하여 사용자선택 트리 공통 구현 -->
<link rel="stylesheet" href="<c:url value='/daumeditor/css/editor.css'/>" type="text/css" charset="utf-8"/>
<script src="<c:url value='/daumeditor/js/editor_loader.js'/>" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" defer="defer">
	var orgNm = "${baseUserLoginInfo.applyOrgNm }";

	var myGboardTree = new GboardTree(); 	//UserTree 객체생성

	$(document).ready(function(){
		setVisibleLeftMenuSpace(0);
		setGBoardTree();
	});
	//우측 컨텐츠 영역에 선택한 gboardId 의 리스트 페이지를 불러온다.
	function viewListPage(gboardId,gboardName,groupName,listCount,fileYn,replyYn,noticeYn,gboardDesc,openFlag){
		$("#searchGboardId").val(gboardId);
		$("#searchBoardTitle").val(gboardName);
		$("#searchGroupName").val(groupName);
		$("#sel_page_size").val(listCount);
		$("#searchFileYn").val(fileYn);
		$("#searchReplyYn").val(replyYn);
		$("#searchNoticeYn").val(noticeYn);
		$("#searchGboardDesc").val(gboardDesc);
		$("#openFlag").val(openFlag);
		$("#frm").attr("action",contextRoot+"/gboard/getGboardListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),includeContentsPageCallback);
	}

	//우측 컨텐츠 영역을 호출하기위한 ajax메서드의 콜백함수이다(리턴벨류는 jsp일때만 사용한다.)
	function includeContentsPageCallback(data){


		$("#gboardContents").html(data);

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
		//$(".jstree-anchor").removeClass("jstree-clicked");
		//$("#"+$("#searchGboardId").val()+"_anchor").addClass("jstree-clicked");
	}

	//글쓰기 화면
	function doWriteContent(){
		$("#searchGboardContentId").val(0);
		$("#frm").attr("action",contextRoot+"/gboard/boardContentWrite.do");
		commonAjaxSubmit("POST",$("#frm"),includeContentsPageCallback);
	}
	//사용자 트리 생성
	function setGBoardTree(){
		var firstGboardIdBuf = $("#treeSelectUl li").eq(0).attr("id");
		if(firstGboardIdBuf != undefined) {
			var firstGboardId = firstGboardIdBuf.split("_")[1];

			if($("#mainGboardId").val()!=""){
				firstGboardId =$("#mainGboardId").val();
				$("#mainGboardid").val("");
			}
	        /* 사용자트리 설정정보 */
	        var configObj = {
	                targetID : 'userListAreaTree',                          //대상 위치 id (div, span)
	                url : contextRoot + "/gboard/getGboardGroupListAjax.do",    //데이터 URL
	                callbackFn : getNodeInfo,                           //콜백 function
	                isCallbackEnable : true,
	                orgNm : orgNm,
	                firstGboardId:firstGboardId
	        };

	        myGboardTree.setConfig(configObj);  //설정정보 세팅
	        myGboardTree.drawTree();                //트리 생성
		}
	}

	//노트 선택 콜백 함수
	function getNodeInfo(nodeId){
		$("#moveListType").val("node");
		$("#gboard_"+nodeId).trigger("click");
	}

	//리스트 페이지
	function goListPage(){
		$("#moveListType").val("view");
		$("#frm").attr("action",contextRoot+"/gboard/getGboardListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),includeContentsPageCallback);
	}
</script>
<!-- 일반게시판은 모든화면이 include구조이기 때문에 좌측 트리영역 or 게시판 리스트 검색 파라미터만 이 폼을 사용하고 등록/수정/삭제때는  include jsp에서 별도의 form을 만들어 호출해야한다. -->
<form id = "frm" name = "frm">
	<input type="hidden" id = "searchGboardId" name = "searchGboardId">
	<input type="hidden" id = "searchBoardTitle">
	<input type="hidden" id = "searchGroupName">
	<input type="hidden" id = "sel_page_size">
	<input type="hidden" id = "searchFileYn">
	<input type="hidden" id = "searchReplyYn">
	<input type="hidden" id = "searchNoticeYn">
	<input type="hidden" id = "searchGboardDesc">
	<input type="hidden" id = "searchGboardContentId" value="0">

	<!-- 검색조건 유지 -->
	<input type="hidden" id = "searchKeyWordBuf">
	<input type="hidden" id = "searchTypeBuf">
	<input type="hidden" id = "currentPage">
	<input type="hidden" id = "moveListType">
	<input type="hidden" id = "openFlag">

	<!-- 메인화면에서 링크클릭시 넘어오는 파라미터 -->
	<input type="hidden" id = "mainGboardId" value="${gboardId }">
	<input type="hidden" id = "mainContentId" value="${contentId }">
</form>
<div id="treeSelect" style="display: none;">
	<ul id = "treeSelectUl">
		<c:forEach var = "data" items="${gboardGroupMapList }">
			<li id = "treeSelectLi_${data.gboardId }">
				<a id = "gboard_${data.gboardId }" href = "#this" onclick="viewListPage('${data.gboardId }','${data.gboardName }','${data.groupName }','${data.listCount }','${data.fileYn }','${data.replyYn }','${data.noticeYn }','${data.gboardDesc }','${data.openFlag }')">${data.groupName }-${data.gboardName }</a>
			</li>
		</c:forEach>
	</ul>
</div>

<c:choose>
    <c:when test="${empty gboardGroupMapList }">
        <table class="board_list_st01" summary="사내게시판 목록" >
              <caption>사내게시판 목록</caption>
              <colgroup>
                  <col width="*" />    <!-- 제목 -->
              </colgroup>
              <thead>
                 <!--  <tr>
                      <th scope="col">번호</th>
                  </tr> -->
              </thead>
              <tbody>
                   <tr><td>등록된 사내 게시판이 없습니다.</td></tr>
              </tbody>
          </table>
    </c:when>
    <c:otherwise>
        <div class="verticalWrap">
		    <div class="addAreaZone">
		        <div id="userListAreaTree">
		            <ul>

		            </ul>
		        </div>
		    </div>
		    <div id = "gboardContents">
		        <section id="detail_contents">

		        </section>
		    </div>
		</div>
    </c:otherwise>
</c:choose>


