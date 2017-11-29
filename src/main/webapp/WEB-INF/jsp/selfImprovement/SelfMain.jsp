<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Main</title>
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">

<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/part/self.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/calendar_beans_v2.0.js'/>" ></script>
<script>
CalAddCss();
$(document).ready(function(){
	if('<c:out value='${deleteCnt}'/>' > 0 ) {
		alert('<c:out value='${message}'/>');	
		location.href ="<c:url value='index.do' />";
	}
	if('<c:out value='${saveCnt}'/>' > 0 ) {
		location.href ="<c:url value='index.do' />";
	}

	//메모 버튼 클릭시
	$(document).on("click",".memoBtn",function(){
		var t_num = $(this).attr('id').split('_');
		divId = 'bsnsPmemo_'+ t_num[1];
		divShow($(this));
	});
	
	$(document).on("change","#choiceYear", function(){
		 var frm = document.modifyRec;
		 frm.action = "index.do";
		 frm.submit();
	});
	
	//파일 다운로드
	$(document).on("click",".filePosition",function(){
		var obj = $(this).parent();
		// var frm = document.getElementById('modifyRec');//sender form id
		// frm.action = "downloadProcess.do";//target frame name
		// frm.submit();
		var obj_id = $(this).attr('id');
		var num = obj_id.split('ile');
		$("#makeName").val(obj.find('[id^=mkNames'+num[1]+']').val());
		// document.downName.submit();
		$("#downName").submit();
		// alert("업로드까지는 완료 되었습니다.\n다운로드는 빠른시일내로 완료하겠습니다.");
	});
});


function refresh(){
	location.href ="<c:url value='index.do' />";
}

</script>

</head>
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<body>
<div id="wrap">

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
						
<form id="downName" name="downName" action="<c:url value='/work/downloadProcess.do' />" method="post">
	<input type="hidden" name="makeName" id="makeName"/>
	<input type="hidden" name="recordCountPerPage" value="0"/>
</form>
	
		<!-- 메모   -->
			<c:forEach var="plan" items="${selfList}" varStatus="planStatus">
			<div class="popUpMenu title_area" id="bsnsPmemo_${planStatus.count }">
				<input type="hidden" id="bsnsPsnb${planStatus.count }" value="${plan.sNb}"/>
				
				<p class="closePopUpMenu" title="닫기" onclick="parent.closePopUpMenu(this)">ⅹ닫기</p>
				<ul>
					<li class="c_note"><textarea id="memoarea${planStatus.count }">${plan.note}</textarea></li>
				</ul>
				<p class="bsnsR_btn">
					<span class="btn s green" id="bsnsPlanSaveBtn_${planStatus.count }"><a onclick="bsnsPsave('bsnsPlanSaveBtn_${planStatus.count }');">저장</a></span>
				</p>
			</div>
			</c:forEach>
			
			<div class="popUpMenu title_area" id="bsnsPmemo_0">
				<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
				<ul>
					<li class="c_note"><textarea id="memoarea0" placeholder="메모"></textarea></li>
				</ul>
			</div>
		<!-- 메모   -->

	<section>
		<div class="fixed-top" style="z-index:10;">
		
		<header>
			<form id="modifyRec" name="modifyRec" method="post" action="<c:url value='/selfImprovement/index.do' />">
				<input type="hidden" name="sorting" id="sorting">
			<div class="year_wrap">
			
				<c:set var="now" value="<%= new java.util.Date() %>"/>
				<fmt:formatDate var="cur_year" value='${now}' pattern='yyyy'/>
				
				
				<span class="year">
					<select id='choiceYear' name='choiceYear'>
						<c:forEach var="year" begin="2013" end="${cur_year}">
							<option value="${year}"
							<c:choose>
								<c:when test="${choiceYear == null}">
									<c:if test="${year == cur_year}">selected</c:if>>
								</c:when>
								<c:otherwise>
									<c:if test="${year == choiceYear}">selected</c:if>>
								</c:otherwise>
							</c:choose> 
							${year}</option>
						</c:forEach>
					</select>
				</span>
				
			</div>
			</form>
		</header>
		<div style="float:left;padding:10px 0 0 70px;"><span class="btn s"><a onclick="popUp('','files')">보고서양식 업로드</a></span>
		<span>
		<c:forEach var="tmpF" items="${tempFileList}" varStatus="tf">
			<input type="hidden" id="mkNames${tf.count}" value="${tmpF.makeNm}"/>
			<c:set var="extension" value="${fn:split(tmpF.realNm,'.')}"/>
			<c:set var="lastDot" value="${fn:length(extension)-1}"/>
			<c:set var="ext" value=""/>
			<c:if test="${extension[lastDot]=='doc' or extension[lastDot]=='docx'}"><c:set var="ext" value="doc"/></c:if>
			<c:if test="${extension[lastDot]=='xls' or extension[lastDot]=='xlsx'}"><c:set var="ext" value="xls"/></c:if>
			<c:if test="${extension[lastDot]=='ppt' or extension[lastDot]=='pptx'}"><c:set var="ext" value="ppt"/></c:if>
			<c:if test="${extension[lastDot]=='pdf'}"><c:set var="ext" value="pdf"/></c:if>
	
			&nbsp;<img class="mail_send filePosition" id="file${tf.count}"
			<c:choose>
				<c:when test="${empty ext or ext == ''}">src="../images/file/files.png"</c:when>
				<c:otherwise>src="../images/file/${ext}.png"</c:otherwise>
			</c:choose>
			title="${tmpF.realNm}" align="absmiddle"><span id="ffile${tf.count}" class="mail_send filePosition" style="display: inline-block;vertical-align: bottom;"><b>보고서양식</b></span>
		</c:forEach>
		</span>
		</div>
		
			<table class="t_skinR00" style="width:100%;margin-top:35px;padding-right:5px;">
				<thead>
					<tr>
 						<th rowspan="2" class="bgYlw" style="width:120px">취득/수료/완료일자</th>
 						<th rowspan="2" class="bgYlw nameD">입력자</th>
 						<th rowspan="2" class="bgYlw" style="width:50px;">선택</th>
						<th rowspan="2" class="bgYlw" style="width:200px;">자격/면허/교육/도서명</th>
						<th rowspan="2" class="bgYlw" style="width:200px;">기관명</th>
						<th rowspan="2" class="bgYlw">증빙자료</th>
						<th rowspan="2" class="bgYlw" style="width:50px;">회사지원</th>
						<th rowspan="2" class="bgYlw" style="width:45px;">비고</th>
					</tr>
					<tr style="height:1px;"></tr>
				</thead>
				
			</table>
		</div>
		<div style="padding-top:60px;">
			<input type="hidden" id="cardD" value="card">
			<form name="insertSelf" id="insertSelf" method="post">

			<input type="hidden" name="obtainDt" id="tmDt">
			<table class="t_skinR00" style="width:100%">
				<tbody>
					<tr>
						<td class="cent bgRed" style="width:120px">
							<span id="cardDate">&nbsp;</span>
							<div id='CaliCal0Icon' style="padding-top: 1px; float: right;">
								<img id='CaliCal0IconImg' class='calImg' src='../images/calendar.gif'>
							</div>
							
							<input type="hidden" id="iCal0"/>
							<script>initCal({id:"iCal0",type:"day",today:"y"});</script>
						</td>
						<td class="cent bgRed nameD">${baseUserLoginInfo.userName }</td>
						<td class="cent bgRed" style="width:50px;">
							<select name="titleCd">
								<option value="00001">교육</option>
								<option value="00002">도서</option>
								<option value="00003">자격</option>
							</select>
						</td>
						<td class="cent bgRed" style="width:200px;"><input type="text" class="w96 pd0" id="title" name="title" /></td>
						<td class="cent bgRed" style="width:200px;"><input type="text" class="w96 pd0" id="issue" name="issue"/></td>
						<td class="cent bgRed"><input type="text" class="w96 pd0" id="proof" name="proof"/></td>
						<td class="cent bgRed w50p"><input type="text" class="w96 pd0 id="support" name="support"/></td>
						<td class="cent bgRed" style="width:45px;"><span class="btn s green"><a onclick="selfSubmit(this)">저장</a></span></td>
					</tr>
					
					<c:forEach var="self" items="${selfList}" varStatus="status">
					<tr>
						<td class="cent">${self.obtainDt}</td>
						<input type="hidden" id="snb${status.count}" value="${self.sNb}">
						<td class="cent">${self.usrNm}</td>
						<td class="cent">${self.titleCd}</td>
						<td class="cent">${self.title}</td>
						<td class="cent">${self.issue}</td>
						<td class="cent">${self.proof}
							<div style="float:left;padding-left:5px;">
							<c:if test="${baseUserLoginInfo.loginId == self.rgId}"><span class="btn s"><a onclick="popUp('${status.count}','files')">업로드</a></span></c:if>
							<span>
								<c:if test="${not empty self.realNm}">
									<c:choose>
										<c:when test="${fn:indexOf(self.realNm,'^^^') > 0}">
											<c:set var="imgNm" value="${fn:split(self.realNm, '^^^')}"/>
											<c:set var="makeNm" value="${fn:split(self.makeNm, '^^^')}"/>
		
											<c:forEach var="mkNm" items="${makeNm}" varStatus="mkSt">
												<input type="hidden" id="mkNames${mkSt.count}" value="${mkNm}"/>
											</c:forEach>
		
											<c:forEach var="im" items="${imgNm}" varStatus="imSt">
												<c:set var="extension" value="${fn:split(im,'.')}"/>
												<c:set var="lastDot" value="${fn:length(extension)-1}"/>
												<c:set var="ext" value=""/>
												<c:if test="${extension[lastDot]=='doc' or extension[lastDot]=='docx'}"><c:set var="ext" value="doc"/></c:if>
												<c:if test="${extension[lastDot]=='xls' or extension[lastDot]=='xlsx'}"><c:set var="ext" value="xls"/></c:if>
												<c:if test="${extension[lastDot]=='ppt' or extension[lastDot]=='pptx'}"><c:set var="ext" value="ppt"/></c:if>
												<c:if test="${extension[lastDot]=='pdf'}"><c:set var="ext" value="pdf"/></c:if>
		
												&nbsp;<img class="mail_send filePosition" id="file${imSt.count}"
												<c:choose>
													<c:when test="${empty ext or ext == ''}">src="../images/file/files.png"</c:when>
													<c:otherwise>src="../images/file/${ext}.png"</c:otherwise>
												</c:choose>
												title="${im}">
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:set var="extension" value="${fn:split(self.realNm,'.')}"/>
											<c:set var="lastDot" value="${fn:length(extension)-1}"/>
											<input type="hidden"  id="mkNames1" value="${self.makeNm}"/>
											<c:set var="ext" value=""/>
											<c:if test="${extension[lastDot]=='doc' or extension[lastDot]=='docx'}"><c:set var="ext" value="doc"/></c:if>
											<c:if test="${extension[lastDot]=='xls' or extension[lastDot]=='xlsx'}"><c:set var="ext" value="xls"/></c:if>
											<c:if test="${extension[lastDot]=='ppt' or extension[lastDot]=='pptx'}"><c:set var="ext" value="ppt"/></c:if>
											<c:if test="${extension[lastDot]=='pdf'}"><c:set var="ext" value="pdf"/></c:if>
		
											&nbsp;<img class="mail_send filePosition" id="file1"
											<c:choose>
												<c:when test="${empty ext or ext == ''}">src="../images/file/files.png"</c:when>
												<c:otherwise>src="../images/file/${ext}.png"</c:otherwise>
											</c:choose>
											title="${self.realNm}">
										</c:otherwise>
									</c:choose>
								</c:if>
							</span>
							</div>
						</td>
						<td class="cent" style="width:50px;">
							
						</td>
						<td class="cent" style="width:45px;">
							<c:if test="${baseUserLoginInfo.userName==self.usrNm}">
								<span class="btn s red"><a onclick="delSelf(this, ${status.count})">삭제</a></span>
							</c:if>
							<c:if test="${not empty self.sNb }"><a class="memoBtn" id="mm_${status.count}"><img src="<c:url value='/images/edit-5-icon.png'/>" title="메모 입력" <c:if test="${fn:length(self.note)>1}">style="background-color:red"</c:if>></a></c:if></td>
					</tr>
					</c:forEach>
					
				</tbody>
			</table>
			</form>
		</div>
	</section>
</div>
<div class="clear"></div>
</body>
</html>