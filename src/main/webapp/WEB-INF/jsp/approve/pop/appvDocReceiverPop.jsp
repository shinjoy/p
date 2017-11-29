<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<div class="mo_container2">
	<!--문서열람목록-->
	<div class="referListWrap">
		<div class="fl_block">
			<h3 class="h3_title_basic">수신문서 열람</h3>
			<div class="group_doc_read">
				<ul id = "rcReadUl">

				</ul>
			</div>
		</div>
		<div class="fr_block">
			<h3 class="h3_title_basic">수신문서 미열람</h3>
			<div class="group_doc_notyet">
				<ul id = "rcNotReadUl">

				</ul>
			</div>
		</div>
	</div>
	<!--//문서열람목록//-->
	<div class="btnZoneBox">
		<a href="javascript:parent.myModal.close()" class="p_withelin_btn">닫기</a>
	</div>
	<!--//검색결과有//-->
</div>

<script type="text/javascript">
	function innerRcInfo(targetId , name , status , date , min){
		var stStr = "";
		if(targetId == "rcReadUl"){
				stStr += "<li><span class='name'>";
				stStr += name + "</span><span class='st_doc_txt'>("+status+")"+"<span class='date'>"+date+"</span><span class='time'>"+min+"</span></li>";
		}else if(targetId == "rcNotReadUl"){
			stStr += "<li><span class='name'>";
			stStr += name +"</span></li>";
		}

		$("#"+targetId).prepend(stStr);
	}
</script>
<c:forEach items="${rcReceiverList }" var = "data">
	<c:choose>
		<c:when test="${not empty data.readDate}">
			<script type="text/javascript">
			innerRcInfo("rcReadUl","${data.userNm}","${data.receiptYn eq 'Y'? '수신확인':'열람'}","<fmt:formatDate value='${data.readDate}' pattern='yyyy/MM/dd'/>","<fmt:formatDate value='${data.readDate}' pattern='HH:mm'/>");
			</script>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
			innerRcInfo("rcNotReadUl","${data.userNm}",null,null);
			</script>
		</c:otherwise>
	</c:choose>
</c:forEach>

<div style="height: 60px;"></div>
