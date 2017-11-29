<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
<style>
.popUpMenu .midTitle {
	padding: 3px 0 5px;
}
.inboxcontents,.inboxText{
	max-width:140px;
	padding: 2px 5px;
	border-radius: 5px;
	background-color: white;
}
.inboxcontents{
	border: 1px solid gray;
	box-shadow: 2px 2px 5px #888;
	margin-right: 5px;
}
.midboxcontents{
	display:flex;
	padding:5px;
	border: 2px dotted gray;
	border-bottom: 0;
	border-radius: 5px;
}
.midboxcontents:after {content:""; display:block; clear:both;}.midboxcontents>div{float:left;}
.boxBottom{
	display:flex;
	padding:0;
	border:0;
	border-top: 2px dotted gray;
	border-radius: 5px;
	height:2px;
}
.inboxTextTop,.inboxTextBottom {padding-left: 5px;}
.inboxTextTop {border-bottom:1px solid;}
.arrowBar {padding-top:23px;}
.price input {width:40px;border:0;padding:0;}.hideSelect{display:none;}
.nowrap {white-space: nowrap;}
.hov,.hh{background-color:khaki;}
.handd:hover{cursor:pointer;background-color:#faac58}
.popUpMenu .closePopUpMenu{
    font-weight: bold;
	padding:0 !important;
}
.popUpMenu #closeTab{
	margin: 0;
	text-align: right;
	
	background-color: #323232;
    border-bottom: 1px solid hsl(0, 0%, 95%);
    color: hsl(0, 0%, 100%);
	border-radius: 4px 4px 0 0;
    font-weight: bold;
    padding: 7px 12px 7px 15px;
    position: relative;
}
</style>
<script type="text/JavaScript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
<script>
$("#closeTab").mousedown(function(){
	$("#workPr").draggable();
});

function closePopUpMenu(){
	$('.popUpMenu').hide();
	if('${close}'!='stats')document.location.reload();
}
</script>
<div>
	<div class="popUpMenu title_area" id="workPr">
		<%--<p class="closePopUpMenu" name="textR" title="닫기" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);">ⅹ닫기</p>--%>
		<p id="closeTab" name="textR"><span class="closePopUpMenu" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);" title="닫기">ⅹ닫기</span></p>
	
		<ul>
			<li>
						<!--매각-->
					<c:forEach var="dsps" items="${disposalList}" varStatus="dspsS"><c:set var="sumRspt1" value="0"/>
		<c:if test="${dsps.offerSnb != saveSnb}">
			<c:set var="saveSnb" value="${dsps.offerSnb}"/>
			<c:if test="${dspsS.count>1}"><div class="boxBottom"></div></div></div><div class="boxBottom"></div></c:if>
				<b>${dsps.cpnNm}</b> ${dsps.categoryNm}
				<div class="midboxcontents">
					<div>
						<div class="inboxcontents" style="width:64px">
							<div class="midTitle"><b>소싱자</b><br/><div id="stfWr">${dsps.usrNm}</div></div>
						</div>
						<c:forEach var="spt" items="${supportList}" varStatus="sptS"><c:if test="${spt.cate eq 1 and spt.offerSnb eq offerSNB}"><c:set var="sumRspt1" value="${spt.ratio + sumRspt1}"/>
						<div class="inboxcontents nowrap<c:if test="${mainNm eq spt.usrNm}"> hh</c:if>">
							<input type="hidden" id="offSupSnb${sptS.count}" value="${spt.sNb}"/>
							<div class="midTitle"><nobr>${spt.usrNm} ${spt.ratio}%</nobr></div>
						</div>
						</c:if></c:forEach>
						<%--
						<script>$('#stfWr').html('<nobr>'+$('#RegName').val()+' ${100-sumRspt1}'+'%</nobr>');</script>
						--%>
					</div>
					<div style="margin-top:29px;width:20px;border-top:1px solid;"></div><div class="arrowBar">▶</div>
					<div>
		</c:if>
						<div class="midboxcontents">
							<input type="hidden" name="arrSnb" id="snb${dspsS.count}" value="${dsps.sNb}"/>
							<div>
								<div class="inboxcontents<c:if test="${mainNm eq dsps.rgNm}"> hh</c:if>">
									<div class="midTitle"><b>매각인</b><br/><div id="stfWrk${dspsS.count}"></div></div>
								</div>
								<c:forEach var="spt" items="${supportList}" varStatus="sptS"><c:if test="${spt.cate eq 2 and spt.offerSnb eq dsps.sNb}"><c:set var="sumRspt1" value="${spt.ratio + sumRspt1}"/>
								<div class="inboxcontents nowrap<c:if test="${mainNm eq spt.usrNm}"> hh</c:if>">
									<input type="hidden" id="disSupSnb${sptS.count}" value="${spt.sNb}"/>
									<div class="midTitle"><nobr>${spt.usrNm} ${spt.ratio}%</nobr></div>
								</div>
								</c:if></c:forEach>
								<script>$('#stfWrk${dspsS.count}').html('<nobr>${dsps.rgNm} ${100-sumRspt1}'+'%</nobr>');</script>
							</div>
							<div class="price" style="width:50px;">
								<div class="inboxTextTop"><b>규모</b><br/><input type="text" name="arrPrice" id="price${dspsS.count}" value="${dsps.price}" placeholder="금액(억)"/></div>
								<div class="inboxTextBottom"><b>매각금</b><br/><input type="text" name="arrMargin" id="cellPrice${dspsS.count}" value="${dsps.margin}" placeholder="금액(억)"/></div>
							</div>
							<div class="arrowBar">▶</div>
							<div>
								<div class="inboxcontents handd" onclick="popUp('','rcmdCst','','${dsps.snb2nd}');">
									<div class="midTitle" id="intro_cstNm${dspsS.count}"><b>거래상대방</b><br/>${dsps.cpnNm2nd}<br/><nobr>${dsps.cstNm2nd}</nobr></div>
									<input type="hidden" name="arrSnb2nd" id="rgSnb${dspsS.count}" value="${dsps.snb2nd}"/>
								</div>
							</div>
						</div>
						</c:forEach>
						<!--매각-->
						<div class="boxBottom"></div>
					</div>
				</div>
				<div class="boxBottom"></div>
			</li>
			<li class="bsnsR_btn">
				<input type="text" id="BN" style="height:0.5px;width:0.5px;border:0px none;padding:0;vertical-align:bottom;">
			</li>
		</ul>
	</div>
</div>
