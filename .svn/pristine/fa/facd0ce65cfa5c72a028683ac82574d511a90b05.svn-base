<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
<style>
.price input {width:40px;border:0;padding:0;}.hideSelect{display:none;}
.nowrap {white-space: nowrap;}
.hov{background-color:khaki;}
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

function stfClick(th){
	var obj = $(th);
	obj.hide();
	// obj.next().find('select').attr('multiple',true);
	obj.next().show();
}
function saveMargin(th){
	var rtn = 0;
	$('#workPr .midboxcontents [name=arrPrice]').each(function(){
		if($(this).val().is_null()) {
			alert('규모를 입력하세요.');
			rtn = -1;
			return false;
		}
	});if(rtn<0) return;
	$('#workPr .midboxcontents [name=arrMargin]').each(function(){
		if($(this).val().is_null()) {
			alert('매각금을 입력하세요.');
			rtn = -1;
			return false;
		}
	});if(rtn<0) return;
	$('#workPr .midboxcontents [name=arrSnb2nd]').each(function(){
		if($(this).val().is_null()) {
			alert('거래상대방을 선택하세요.');
			rtn = -1;
			return false;
		}
	});if(rtn<0) return;

	var
	data = $('.delCate0').serialize()
	,data1 = $('.delCate1').serialize()
	,data2 = $('.delCate2').serialize()
	,fn = function(){
		var fn1 = function(){
			var fn2 = function(){ saveAllDisposal(); };

			if(typeof data2!=='undefined' && data2.length>0){
				//$('#default_sup').after('<input type="hidden" class="delCate2" name="cate" value="2"/>');
				//data2 = $('.delCate2').serialize();
				ajaxModule(data2,"<c:url value='/reply/deleteSupporter.do'/>",fn2);
			}else{
				fn2();
			}
		};
		if(typeof data1!=='undefined' && data1.length>0){
			//$('#default_sup').after('<input type="hidden" class="delCate1" name="cate" value="1"/>');
			//data1 = $('.delCate1').serialize();
			ajaxModule(data1,"<c:url value='/reply/deleteSupporter.do'/>",fn1);
		}else{
			fn1();
		}
	};
	if(typeof data!=='undefined' && data.length>0){
		ajaxModule(data,"<c:url value='/reply/deleteDisposal.do'/>",fn);
	}else{
		fn();
	}
}
function closePopUpMenu(){
	$('.popUpMenu').hide();
	document.location.reload();
}
function saveAllDisposal(){
	var data = $('#workPr .midboxcontents input,#workPr .midboxcontents select').serialize()
	,url="<c:url value='/reply/saveDisposal.do'/>"
	,fn = function(){
		$('.popUpMenu').hide();
		document.location.reload();
	};
	ajaxModule(data,url,fn);
}
function addMarginDiv(th){
	var cur = $(th).prev().find('.midboxcontents:last')
	,cnt=0,incCnt=0
	,obj = $('#default').children()
	,clon = obj.clone();
	if(typeof cur!=='undefined' && cur.length>0){
		cnt = cur.find('select[id^=stf]').attr('id').split('stf')
		,incCnt = parseInt(cnt[1])+1;
	}


	clon.find('[id*=_default]').each(function(){
		var thi = $(this);
		if('intro_cstNm_default'==thi.attr('id'))
			thi.attr('onclick','popUp("'+incCnt+'","pp")');
		thi.attr('id',thi.attr('id').split('_default')[0]+incCnt);
	});

	if(typeof cur!=='undefined' && cur.length>0){
		cur.after(clon);
	}else{
		$(th).prev().find('.boxBottom').before(clon);
	}
	obj.find('[id^=snb]').val('_'+(parseInt(obj.find('[id^=snb]').val().replace('_',''))+1));
}
function deleteDiv(th,f,cate){
	var obj = $(th);
	obj.parent().remove();
	if(typeof f!=='undefined' && f.length>0){
		$('#default_sup').after('<input type="hidden" class="delCate'+cate+'" name="arrSnb" value="'+obj.parent().find('[id^='+f+']').val()+'"/>');
	}
}
function addSupporter(th){
	var obj = $(th);
	obj.prev().after($('#default_sup').html());
	obj.prev().find('[name=arrOfferSnb]').val(obj.parent().parent().find('[id^=snb]').val());
}
</script>
<div>
	<div class="popUpMenu title_area" id="workPr">
		<%--<p class="closePopUpMenu" name="textR" title="닫기" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);">ⅹ닫기</p>--%>
		<p id="closeTab" name="textR"><span class="closePopUpMenu" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);" title="닫기">ⅹ닫기</span></p>
		<ul>
			<li>
				<div class="midboxcontents">
					<input type="hidden" id="snb0" value="${offerSNB}"/>
					<input type="hidden" id="offerSnb" name="offerSnb" value="${offerSNB}">

					<div>
						<div class="inboxcontents">
							<div class="midTitle"><b>소싱자</b><br/><div id="stfWr"></div></div>
						</div>
						<c:forEach var="spt" items="${supportList}" varStatus="sptS"><c:if test="${spt.cate eq 1 and spt.offerSnb eq offerSNB}"><c:set var="sumRspt1" value="${spt.ratio + sumRspt1}"/>
						<div class="inboxcontents nowrap">
							<input type="hidden" id="offSupSnb${sptS.count}" value="${spt.sNb}"/>
							<nobr>${spt.usrNm} ${spt.ratio}%</nobr>
							<span class="btn s black" onclick="javascript:deleteDiv(this,'offSupSnb','1');"><a>x</a></span>
						</div>
						</c:if></c:forEach>
						<script>$('#stfWr').html('<nobr>'+$('#RegName').val()+' ${100-sumRspt1}'+'%</nobr>');</script>
						<span class="btn s blue" onclick="javascript:addSupporter(this);"><a>+공동진행</a></span>
					</div>
					<div style="margin-top:32px;width:20px;border-top:1px solid;"></div><div class="arrowBar">▶</div>
					<div>
						<!--매각-->
						<c:forEach var="dsps" items="${disposalList}" varStatus="dspsS"><c:set var="sumRspt1" value="0"/>
						<div class="midboxcontents">
							<input type="hidden" name="arrSnb" id="snb${dspsS.count}" value="${dsps.sNb}"/>
							<div>
								<div class="inboxcontents hov">
									<div class="midTitle" onclick="javascript:stfClick(this);"><b>매각인</b><br/><div id="stfWrk${dspsS.count}"></div></div>
									<div class="hideSelect"><b>매각인</b><br/>
										<select class="" name="arrStaffSnb" id="stf${dspsS.count}">
											<c:forEach var="stf" items="${userList}" varStatus="stfS">
											<option value="${stf.sNb}"<c:if test="${stf.usrNm eq dsps.rgNm}"> selected</c:if>>${stf.usrNm}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<c:forEach var="spt" items="${supportList}" varStatus="sptS"><c:if test="${spt.cate eq 2 and spt.offerSnb eq dsps.sNb}"><c:set var="sumRspt1" value="${spt.ratio + sumRspt1}"/>
								<div class="inboxcontents nowrap">
									<input type="hidden" id="disSupSnb${sptS.count}" value="${spt.sNb}"/>
									<nobr>${spt.usrNm} ${spt.ratio}%</nobr>
									<span class="btn s black" onclick="javascript:deleteDiv(this,'disSupSnb','2');"><a>x</a></span>
								</div>
								</c:if></c:forEach>
								<script>$('#stfWrk${dspsS.count}').html('<nobr>${dsps.rgNm} ${100-sumRspt1}'+'%</nobr>');</script>
								<span class="btn s blue" onclick="javascript:addSupporter(this);"><a>+공동진행</a></span>
							</div>
							<div class="price" style="width:50px;">
								<div class="inboxTextTop"><b>규모</b><br/><input type="text" name="arrPrice" id="price${dspsS.count}" value="${dsps.price}" placeholder="금액(억)"/></div>
								<div class="inboxTextBottom"><b>매각금</b><br/><input type="text" name="arrMargin" id="cellPrice${dspsS.count}" value="${dsps.margin}" placeholder="금액(억)"/></div>
							</div>
							<div class="arrowBar">▶</div>
							<div>
								<div class="inboxcontents hov">
									<div class="midTitle" id="intro_cstNm${dspsS.count}" onclick="popUp('${dspsS.count}','pp')"><b>거래상대방</b><br/>${dsps.cpnNm2nd}<br/><nobr>${dsps.cstNm2nd}</nobr></div>
									<input type="hidden" name="arrSnb2nd" id="rgSnb${dspsS.count}" value="${dsps.snb2nd}"/>
								</div>
							</div>
							<span class="btn s black" onclick="javascript:deleteDiv(this,'snb','0');"><a>x</a></span>
						</div>
						</c:forEach>
						<!--매각-->
						<div class="boxBottom"></div>
					</div>
					<span class="btn s blue" style="margin-left:5px;" onclick="javascript:addMarginDiv(this);"><a>+매각</a></span>
				</div>
				<div class="boxBottom"></div>
			</li>
			<li class="bsnsR_btn">
				<span class="btn s green" onclick="javascript:saveMargin(this);"><a>저장</a></span>
				<input type="text" id="BN" style="height:0.5px;width:0.5px;border:0px none;padding:0;vertical-align:bottom;">
			</li>
		</ul>
	</div>
</div>
<div id="default" style="display:none">
	<div class="midboxcontents">
		<input type="hidden" id="snb000" value="_0"/>
		<div>
			<div class="inboxcontents hov">
				<div class=""><b>매각인</b><br/>
					<select class="" name="arrStaffSnb" id="stf_default">
						<c:forEach var="stf" items="${userList}" varStatus="stfS">
						<option value="${stf.sNb}">${stf.usrNm}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<span class="btn s blue" onclick="javascript:addSupporter(this);"><a>+공동진행</a></span>
		</div>
		<div class="price" style="width:50px;">
			<div class="inboxTextTop"><b>규모</b><br/><input type="text" name="arrPrice" id="price_default" value="${dsps.price}" placeholder="금액(억)"/></div>
			<div class="inboxTextBottom"><b>매각금</b><br/><input type="text" name="arrMargin" id="cellPrice_default" value="${dsps.margin}" placeholder="금액(억)"/></div>
		</div>
		<div class="arrowBar">▶</div>
		<div>
			<div class="inboxcontents hov">
				<div class="midTitle" id="intro_cstNm_default" onclick=""><b>거래상대방</b><br/><nobr>&nbsp;</nobr></div>
				<input type="hidden" name="arrSnb2nd" id="rgSnb_default"/>
			</div>
		</div>
		<span class="btn s black" onclick="javascript:deleteDiv(this);"><a>x</a></span>
	</div>
</div>

<div id="default_sup" style="display:none">
	<div class="inboxcontents nowrap">
		<input type="hidden" name="arrOfferSnb"/>
		<select class="" name="arrSupSnb" id="stf${dspsS.count}">
			<c:forEach var="stf" items="${userList}" varStatus="stfS">
			<option value="${stf.sNb}">${stf.usrNm}</option>
			</c:forEach>
		</select>
		<select class="" name="arrRatio">
			<c:forEach var="cNt" begin="5" end="95" step="5">
			<option value="${cNt}">${cNt}%</option>
			</c:forEach>
		</select>
		<span class="btn s black" onclick="javascript:deleteDiv(this);"><a>x</a></span>
	</div>
</div>