<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:scriptlet>
	pageContext.setAttribute("lf", "\n");
</jsp:scriptlet>
		<!--업무일지등록-->
	<div class="modalWrap2" style="margin-bottom: 20px;">
		<div class="mo_container">
			<div class="sys_p_noti mgb10"><span class="icon_noti"></span><span>프로젝트:</span> <span class="pointB" id = "projectNm"></span> <span id = "projectCode"></span><span class="icon_noti mgl20"></span><span>액티비티:</span> <span class="pointB" id = "activityNm"></span></div>

			<table class="tb_regi_basic2" summary="CODE 등록 (정렬값, 영문코드, 한글명, 추가/삭제)">
				<caption>CODE 등록</caption>
				<colgroup>
					<col width="50">
					<col width="100">
					<col width="80">
					<col width="120">
					<col width="120">
					<col width="*">
					<col width="80">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">업무일지</th>
						<th scope="col">등록자</th>
						<th scope="col">업무일</th>
						<th scope="col">완료일</th>
						<th scope="col">내용</th>
						<th scope="col">진행상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${wbsActivityViewMonthList }" var="data" varStatus="i">
						<tr>
							<td class="bg_skyblue vt">${i.index+1 }</td>
							<td class="txt_center vt">${data.workTypeNm }</td>
							<td class="txt_center vt">${data.userNm }</td>
							<td class="txt_center vt">${data.workDate }</td>
							<td class="txt_center vt"><c:if test = "${data.complete eq 'Y' }">${data.completeDate }</c:if></td>
							<td class="vt"><div class="multiLine2">${data.memo }</div></td>
							<td class="txt_center vt">
								<c:choose>
									<c:when test="${data.complete eq 'Y' }">완료</c:when>
									<c:otherwise>${data.progressNm }</c:otherwise>
								</c:choose>

							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(wbsActivityViewMonthList)<=0 }">
						<tr>
							<td colspan="7" class="no_result">
								<p class="nr_des">조회된 데이터가 없습니다.</p>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<div class="btnZoneBox"><a href="javascript:parent.myModal.close();" class="p_withelin_btn">닫기</a></div>
		</div>

	</div>
	<!--//업무일지등록//-->
<script type="text/javascript">
	$(document).ready(function(){
		var activityObj;

		var actList = parent.actList;
		for(var i = 0 ; i<actList.length; i++){
			if(parseInt(actList[i].activityId) == parseInt("${activityId }")){
				activityObj = actList[i];
			}
		}
		$("#projectNm").text(parent.project.name);
		$("#projectCode").text("("+parent.project.projectCode+")");
		$("#activityNm").text(activityObj.name);
	});
</script>