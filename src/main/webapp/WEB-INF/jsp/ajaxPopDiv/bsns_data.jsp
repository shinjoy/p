<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
<!-- 업무일지 -->
<script type="text/JavaScript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
<script>
$("#closeTab").mousedown(function(){
	$("#workPr").draggable();
});
</script>
<div>
	<c:forEach var="bsnsRcd" items="${bsnsList}" varStatus="bsnsS">
			<div class="popUpMenu title_area" id="workPr">
				<input type="hidden" id="DaY" value="${DaY}"/>
		<c:choose>
			<c:when test="${baseUserLoginInfo.permission > '00019'  or  baseUserLoginInfo.userName==bsnsRcd.name}">
				<input type="hidden" id="bsnsRecSNb" value="${bsnsRcd.sNb }">
				<%--<p class="closePopUpMenu" name="textR" title="닫기" onclick="if(typeof(closePopUpMenu)=='function')closePopUpMenu(this);">ⅹ닫기</p>--%>
				<p id="closeTab" name="textR"><span class="closePopUpMenu" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);" title="닫기">ⅹ닫기</span></p>
				<ul>
					<li class="c_title">
						<select id="bsnsRecPriv" style="display:none;"><option value="1" <c:if test="${bsnsRcd.bsnsRecPrivate == '1'}">selected</c:if>>개인</option><option value="2" <c:if test="${bsnsRcd.bsnsRecPrivate == '2'}">selected</c:if>>전체</option></select>
						<input type="text" class="n_note" id="txt" style="width:500px;margin-bottom:3px;" value="${bsnsRcd.title}"/></li>
					<li class="c_note"><textarea id="txtarea">${bsnsRcd.note}</textarea></li>
					<%-- <li class="c_note"><textarea id="txtarea">${fn:replace(bsnsRcd.note, "<br/>",lf)}</textarea></li> --%>
					<li class="bsnsR_btn">
						<span class="bsnsR_btnOk btn s orange"><a>수정</a></span>&nbsp;&nbsp;&nbsp;
						<span class="bsnsR_btnDel btn s red"><a>완전삭제</a></span>
						<input type="text" id="BN" style="height:0.5px;width:0.5px;border:0px none;padding:0;vertical-align:bottom;">
					</li>
				</ul>
			</c:when>

			<c:otherwise>
				<%--<p class="closePopUpMenu" name="textR" title="닫기" onclick="if(typeof(closePopUpMenu)=='function')closePopUpMenu(this);">ⅹ닫기</p>--%>
				<p id="closeTab" name="textR"><span class="closePopUpMenu" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);" title="닫기">ⅹ닫기</span></p>
				<ul>
					<li class="c_title">
						<select disabled><option value="1" <c:if test="${bsnsRcd.bsnsRecPrivate == '1'}">selected</c:if>>개인</option><option value="2" <c:if test="${bsnsRcd.bsnsRecPrivate == '2'}">selected</c:if>>전체</option></select>
						<input type="text" class="n_note" disabled="true" value="${bsnsRcd.title}"/></li>
					<li class="c_note v-textarea">${fn:replace(bsnsRcd.note, lf,"<br/>&nbsp;&nbsp;")}</li>
				</ul>
			</c:otherwise>
		</c:choose>
			</div>
	</c:forEach>
	<c:if test="${empty bsnsList and empty insideList}">
		<div class="popUpMenu title_area" id="workPr" name="textR">
			<input type="hidden" id="bsnsRecSNb">
			<input type="hidden" id="DaY" value="${DaY}"/>
			<%--<p class="closePopUpMenu" name="textR" title="닫기" onclick="if(typeof(closePopUpMenu)=='function')closePopUpMenu(this);">ⅹ닫기</p>--%>
			<p id="closeTab" name="textR"><span class="closePopUpMenu" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);" title="닫기">ⅹ닫기</span></p>
			<ul>
				<li class="c_title">
					<select id="bsnsRecPriv0" style="display:none;"><option value="1">개인</option><option value="2">전체</option></select>
					<input type="text" class="n_note" id="txt" placeholder="제목" style="width:500px;margin-bottom:3px;"/></li>
				<li class="c_note"><textarea id="txtarea" placeholder="일지를 입력하세요."></textarea></li>
				<li class="bsnsR_btn">
					<span class="bsnsR_btnOk btn s green"><a>저장</a></span>&nbsp;&nbsp;&nbsp;
					<%-- <span class="bsnsR_btnDel">완전삭제</span> --%>
					<input type="text" id="BN" style="height:0.5px;width:0.5px;border:0px none;padding:0;vertical-align:bottom;">
				</li>
			</ul>
		</div>
	</c:if>
	<c:forEach var="inside" items="${insideList}" varStatus="inS">
		<div class="popUpMenu title_area" id="workPr">
			<p id="closeTab" name="textR"><span class="closePopUpMenu" title="닫기" onclick="javascript:if(typeof(closePopUpMenu)=='function')closePopUpMenu(this);">ⅹ닫기</span></p>
			<ul>
				<li class="c_title">
					<select disabled  style="display:none;"><option value="1" <c:if test="${inside.bsnsRecPrivate == '1'}">selected</c:if>>개인</option><option value="2" <c:if test="${inside.bsnsRecPrivate == '2'}">selected</c:if>>전체</option></select>
					<input type="text" class="n_note" style="width:500px;" disabled="true" value="${inside.title}"/></li>
				<li class="c_note v-textarea">${fn:replace(inside.note, lf,"<br/>&nbsp;&nbsp;")}</li>
			</ul>
		</div>
	</c:forEach>
</div>
<script>if(typeof(resize4phone)=='function'){if($(window).width()<1010){resize4phone();}}</script>
<!-- 업무일지 -->