<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>




<script>

$("#closeTab").mousedown(function(){
	$("#offerPr").draggable();
});
if(typeof(CalAddCss)=='function') CalAddCss();


//파일 다운로드	... 하단 이벤트 연결 함수 process.js 에 있음
/*
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
});
*/


//////////////// memo 사이즈 조정 :S //////////////////
function resizeMemo(textareaId){
	var obj = $('#'+textareaId).get(0);		//textarea

	if(obj!=undefined){
		var dvPop = $('#offerPr').get(0);		//div popup

		if(obj.style.height.indexOf("px") == -1 || obj.style.height == "250px"){
			obj.style.height = "1px";
			obj.style.height = (20+obj.scrollHeight)+"px";
		}else{
			obj.style.height = "250px";
		}
	}
}








//----------------- 하단 사용 변수 선언 :S ------------------------
//----------------- 오늘 날짜 인지 여부 변수 -------------
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayV" />

<c:if test="${DaYF eq todayV}">
	<c:set var="isToday" value="Y" />
</c:if>


//정보정리 분석의견 별 값 세팅
<c:forEach var="oi" items="${offerInfoList}">
	<c:if test="${oi.categoryCd eq '00008'}">
	<%--$(document).find('[id^=chkStar]').val('${oi.star}'); --%>
	<c:set var="starVal" value="${oi.star}" />
	</c:if>
</c:forEach>
//----------------- 하단 사용 변수 선언 :S ------------------------



//보기모드에서 입력란 사이즈 미리 확대
<c:choose>
<c:when test="${(pageName=='PrivateWorkVeiw' or pageName =='reply') and (baseUserLoginInfo.permission > '00019'  or  baseUserLoginInfo.userName==statsList[0].rgNm)}">
	<c:set var="update_view" value="update"/><!-- update -->



	//----------------- 하단 사용 변수 선언 :S ------------------------	수정 모드에서

	//----------------- 분석의견이 있는 건 여부 변수 -------------
	<c:forEach var="oi" items="${offerInfoList}">
		<c:if test="${oi.categoryCd eq '00008' and oi.sNb ne null}">
			<c:set var="isExistAnalOpt" value="Y" />
		</c:if>
	</c:forEach>

	//----------------- 오늘 날짜 인지 여부 변수 -------------
	<%--<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayV" />--%>


	<c:forEach var="oFFer" items="${statsList}" varStatus="status">
		<c:if test="${oFFer.tmDt eq todayV}">
			<c:set var="isToday" value="Y" />
		</c:if>
	</c:forEach>


	//----------------- 하단 사용 변수 선언 :E ------------------------	수정 모드에서




</c:when>
<c:otherwise>
<%--
$(document).ready(function(){
 	for(var i=0; i<10; i++){
		resizeMemo('txtarea' + i);
	}
});
--%>
</c:otherwise>
</c:choose>
//////////////// memo 사이즈 조정 :E //////////////////






</script>

<style>
.keyPstl{display:inline-block;width:130px;vertical-align:top;} .calImg:hover{src:url(../images/calBig.jpg)!important;}
.wide_analysis{width:350px;}
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
.d_note {
    color: gray;
    font-size: 11px;
    /* width: 480px; */
    min-height: 24px !important;
    width: 330px;
}

.secretChk{
	float:right;
	padding-right:12px;
}

body{
	text-align:left;
}

.keypoint_ul li{
	font-size:11px;
}
</style>
<form id="downName" name="downName" action="<c:url value='/work/downloadProcess.do' />" method="post">
	<input type="hidden" name="makeName" id="makeName"/>
	<input type="hidden" name="recordCountPerPage" value="0"/>
</form>
<div class="popUpMenu title_area offerL" id="offerPr" style="display:block;z-index:100;">
	<%--<p class="closePopUpMenu" name="textR" title="닫기" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);">ⅹ닫기</p>--%>
	<p id="closeTab" name="textR"><span class="closePopUpMenu" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);" title="닫기">ⅹ닫기</span></p>
	<c:forEach var="oFFer" items="${statsList}" varStatus="status">
		<c:set var="cnt" value="${status.count}"/>
		<c:if test="${not empty oFFer.middleOfferCd and not empty oFFer.offerCd }">
			<c:choose>
				<c:when test="${oFFer.middleOfferCd == '00000'}">
					<c:set var="slct1st" value="00012"/>
					<c:if test="${oFFer.offerCd == '00013'}"><c:set var="slct1st" value="00013"/></c:if>
				</c:when>
				<c:otherwise>
					<c:if test="${oFFer.middleOfferCd+0 < 6}"><c:set var="slct1st" value="00010"/></c:if>
					<c:if test="${oFFer.middleOfferCd+0 < 20 and oFFer.middleOfferCd+0 > 10}"><c:set var="slct1st" value="00011"/></c:if>
					<c:if test="${oFFer.middleOfferCd+0 < 80 and oFFer.middleOfferCd+0 > 70}"><c:set var="slct1st" value="00015"/></c:if>
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:choose>
			<c:when test="${(pageName=='PrivateWorkVeiw' or pageName =='reply') and (baseUserLoginInfo.permission > '00019'  or  baseUserLoginInfo.userName==oFFer.rgNm)}"><c:set var="update_view" value="update"/><!-- update --></c:when>
			<c:otherwise><c:set var="update_view" value="view"/><!-- view --></c:otherwise>
		</c:choose>

		<c:set var="IW" 	value=""/><!-- 소개창 -->
		<c:set var="SP" 	value=""/><!-- 공동진행 -->
		<c:set var="SP_BT" 	value=""/><!-- 인물선택(직원) -->
		<c:set var="IF1" 	value=""/><!-- 정보제공자 -->
		<c:set var="IF2" 	value=""/><!-- 소개자 -->
		<c:set var="IF_BT1" value=""/><!-- 인물선택 -->
		<c:set var="CP1" 	value=""/><!-- 회사 -->
		<c:set var="CP3" 	value=""/><!-- (물건) -->
		<c:set var="CP_BT" 	value=""/><!-- 회사선택 -->
		<c:set var="CS1" 	value=""/><!-- 중개인 -->
		<c:set var="CS2" 	value=""/><!-- 고객 -->
		<c:set var="CS3" 	value=""/><!-- 회사관계자 -->
		<c:set var="CS4" 	value=""/><!-- 정보제공자 -->
		<c:set var="CS5" 	value=""/><!-- 고객(법인,개인) -->
		<c:set var="CS6" 	value=""/><!-- 통화자 -->
		<c:set var="CS_BT" 	value=""/><!-- 인물선택 -->
		<c:set var="RP" 	value=""/><!-- 리포트 -->
		<c:set var="FL" 	value=""/><!-- 파일첨부 -->
		<c:set var="NW" 	value=""/><!-- 인물정보네트워크 -->
		<c:set var="PE" 	value=""/><!-- 발행규모 -->
		<c:set var="IP" 	value=""/><!-- 투자규모 -->
		<c:set var="CH" 	value=""/><!-- 핵심체크사항 -->
		<c:set var="CH1" 	value=""/><!-- 핵심체크사항 > 분석의견 -->
		<c:set var="RW" 	value=""/><!-- 추천인 -->

		<c:set var="noneCpn" value=""/>
		<c:set var="noneCst" value=""/>

		<c:choose>
		<c:when test="${oFFer.offerCd=='00007'}"><!-- 딜.중개.받은제안 -->
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CS1" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:set var="PE" 	value="Y"/>
			<c:set var="IP" 	value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00006'}"><!-- 딜.직접발굴.제안 -->
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CS1" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:if test="${oFFer.categoryCd=='00014'}">
				<c:set var="noneCst" value="Y"/>
			</c:if>
			<c:if test="${oFFer.categoryCd!='00014'}">
				<c:set var="RW" 	value="Y"/>
				<c:set var="PE" 	value="Y"/>
				<c:set var="IP" 	value="Y"/>
			</c:if>
		</c:when>
		<c:when test="${oFFer.middleOfferCd== '00004'}"><!-- 딜.제안중 -->
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CS1" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:set var="PE" 	value="Y"/>
			<c:set var="IP" 	value="Y"/>
		</c:when>
		<c:when test="${oFFer.middleOfferCd== '00005'}"><!-- 딜.제안중(직접발굴) -->
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CS1" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:set var="PE" 	value="Y"/>
			<c:set var="IP" 	value="Y"/>

			<c:set var="RW" 	value="Y"/>
		</c:when>
		<c:when test="${oFFer.middleOfferCd=='00011'}"><!-- 자금.일임계약 -->
			<c:set var="CP1" 	value=""/>
			<c:set var="CP_BT" 	value=""/>
			<c:set var="CS5" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="PE" 	value="Y"/>

			<c:set var="entrustNnI" value="Y"/>
			<c:set var="noneCpn" value="Y"/>
		</c:when>
		<c:when test="${oFFer.middleOfferCd=='00012'}"><!-- 자금.재매각 -->
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CS2" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="PE" 	value="Y"/>
		</c:when>
		<c:when test="${oFFer.middleOfferCd=='00013'}"><!-- 자금.펀드 -->
			<c:set var="CP1" 	value=""/>
			<c:set var="CP_BT" 	value=""/>
			<c:set var="CS5" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="PE" 	value="Y"/>

			<c:set var="noneCpn" value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00001'}"><!-- 정보.미팅 -->
			<c:set var="IW" 	value="Y"/>
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CS4" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:set var="CH" 	value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00002'}"><!-- 정보.IR -->
			<c:set var="IW" 	value="Y"/>
			<c:set var="CP1" 	value=""/>
			<c:set var="CP_BT" 	value=""/>
			<c:set var="CS3" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="RP" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:set var="CH" 	value="Y"/>
			<c:set var="CH1" 	value="Y"/>

			<c:set var="noneCpn" value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00003'}"><!-- 정보.탐방 -->
			<c:set var="IW" 	value="Y"/>
			<c:set var="CP1" 	value=""/>
			<c:set var="CP_BT" 	value=""/>
			<c:set var="CS3" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="RP" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:set var="CH" 	value="Y"/>
			<c:set var="CH1" 	value="Y"/>

			<c:set var="noneCpn" value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00004'}"><!-- 정보.분석 -->
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CH" 	value="Y"/>
			<c:set var="CH1" 	value="Y"/>

			<c:set var="noneCst" value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00010'}"><!-- 정보.산업분석 -->
			<c:set var="CH" 	value="Y"/>
			<c:set var="CH1" 	value="Y"/>

			<c:set var="noneCst" value="Y"/>
			<c:set var="noneCpn" value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00005'}"><!-- 정보.제안서 -->
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>

			<c:set var="noneCst" value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00008'}"><!-- 정보.저녁미팅 -->
			<c:set var="IW" 	value="Y"/>
			<c:set var="CS4" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:set var="CH" 	value="Y"/>

			<c:set var="noneCpn" value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00009'}"><!-- 전화통화 -->
			<c:set var="CS6" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="RP" 	value="Y"/>
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CH" 	value="Y"/>
		</c:when>
		<c:when test="${oFFer.offerCd=='00013'}"><!-- 추천 -->
			<c:set var="IF1" 	value="Y"/>
			<c:set var="IF_BT1" value="Y"/>
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP3" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
			<c:set var="PE" 	value="Y"/>

			<c:set var="noneCst" value="Y"/>
		</c:when>
		<c:when test="${oFFer.middleOfferCd=='00071' || oFFer.middleOfferCd=='00072'}"><!-- 신성장.회원사 , 주주사 -->
			<c:set var="CP1" 	value="Y"/>
			<c:set var="CP_BT" 	value="Y"/>
			<c:set var="CS7" 	value="Y"/>
			<c:set var="CS_BT" 	value="Y"/>
			<c:set var="FL" 	value="Y"/>
		</c:when>
		<c:otherwise></c:otherwise>
		</c:choose>
	<c:if test="${update_view == 'update'}"><input type="hidden" id="offerSnb" value="${oFFer.sNb }"></c:if>
	<input type="hidden" id="DaY" value="${DaY}"/>
	<ul>
		<li style="width:506px;">
		<c:if test="${not empty oFFer.middleOfferCd and not empty oFFer.offerCd }">
			<input type="hidden" id='middleOfferCd_' value="${oFFer.middleOfferCd}"/>
			<input type="hidden" id='offerCd_' value="${oFFer.offerCd}"/>
			<select class="work-1stSelect" onchange="slctWork(this,'1')" <c:if test="${update_view == 'view'}">disabled="true"</c:if>><!-- 딜 -->
				<c:forEach var="cmmCd" items="${cmmCd1stSlctList}">
					<option value="${cmmCd.cd}" <c:if test="${slct1st == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
				</c:forEach>
			</select>
			<select class="work-2ndSelect" onchange="slctWork(this,'2')" <c:if test="${update_view == 'view'}">disabled="true"</c:if> <c:if test="${slct1st != '00010'}">style="display:none"</c:if>><!-- 중개 -->
				<c:forEach var="cmmCd" items="${ccdSourcingTypeList}">
					<option value="${cmmCd.cd}" <c:if test="${oFFer.middleOfferCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
				</c:forEach>
			</select>
			<select class="work-2ndSelect" onchange="slctWork(this,'2')" <c:if test="${update_view == 'view'}">disabled="true"</c:if> <c:if test="${slct1st != '00011'}">style="display:none"</c:if>><!-- 일임계약 -->
				<c:forEach var="cmmCd" items="${ccdAttractFuncList}">
					<option value="${cmmCd.cd}" <c:if test="${oFFer.middleOfferCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
				</c:forEach>
			</select>
			<select class="work-2ndSelect" onchange="slctWork(this,'2')" <c:if test="${update_view == 'view'}">disabled="true"</c:if> <c:if test="${slct1st != '00012'}">style="display:none"</c:if>><!-- 미팅 -->
				<c:forEach var="cmmCd" items="${ccdInfoRegTypeList}">
					<option value="${cmmCd.cd}" <c:if test="${oFFer.offerCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
				</c:forEach>
			</select>
			<select class="work-2ndSelect" onchange="slctWork(this,'2')" <c:if test="${update_view == 'view'}">disabled="true"</c:if> <c:if test="${slct1st != '00015'}">style="display:none"</c:if>><!-- 회원사 -->
				<c:forEach var="cmmCd" items="${ccdShareHolderList}">
					<option value="${cmmCd.cd}" <c:if test="${oFFer.middleOfferCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
				</c:forEach>
			</select>
			<select class="work-3rdSelect" onchange="slctWork(this,'3')" disabled="true" <c:if test="${slct1st != '00010'}">style="display:none"</c:if>><!-- 제안 -->
				<c:forEach var="cmmCd" items="${ccdOfferTypeList}">
					<option value="${cmmCd.cd}" <c:if test="${oFFer.offerCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
				</c:forEach>
			</select>
			<select class="work-3rdSelect" onchange="slctWork(this,'3')" <c:if test="${update_view == 'view'}">disabled="true"</c:if> <c:if test="${slct1st != '00015'}">style="display:none"</c:if>><!-- 직접섭외 -->
				<c:forEach var="cmmCd" items="${ccdPublicRelation}">
					<option value="${cmmCd.cd}" <c:if test="${oFFer.offerCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
				</c:forEach>
			</select>
			<select class="work-3rdSelect" onchange="slctWork(this,'3')" <c:if test="${update_view == 'view'}">disabled="true"</c:if> <c:if test="${oFFer.offerCd != '00010'}">style="display:none"</c:if>><!-- 산업분석 -->
				<c:forEach var="cmmCd" items="${cmmCdanalysisCpnList}">
					<option value="${cmmCd.cd}" <c:if test="${oFFer.cpnTypeCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
				</c:forEach>
			</select>
			<span id='CateCd_${cnt}' <c:if test="${slct1st != '00010' and slct1st != '00013'}">style="display:none"</c:if>><!-- &nbsp;유형: -->
				<select id='categoryCd_' <c:if test="${update_view == 'view'}">disabled="true"</c:if> onchange="chngCategoryCd(this);">
					<option value="" selected>-유형선택-</option>
                    <c:forEach var="cmmCd" items="${cmmCdCategoryList}">
					    <option value="${cmmCd.cd}" <c:if test="${oFFer.categoryCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
                    </c:forEach>
				</select>
				<select id="sellBuy" <c:if test="${oFFer.categoryCd != '00008' and oFFer.categoryCd != '00012'}">style="display:none"</c:if><c:if test="${update_view == 'view'}"> disabled="true"</c:if>>
					<option value="0" <c:if test="${oFFer.sellBuy == 0}">selected</c:if>>Sell</option>
					<option value="1" <c:if test="${oFFer.sellBuy == 1}">selected</c:if>>Buy</option>
					<option value="2" <c:if test="${oFFer.sellBuy == 2}">selected</c:if>>투자유치</option>
				</select>
			</span>
			<c:if test="${update_view == 'update'}">
			<!-- 결정시한 달력 -->
				<div class="CaliCalendar" id='CaliCal${cnt}Icon' title="결정시한"<c:if test="${slct1st != '00010'}"> style="display:none;"</c:if><c:if test="${slct1st == '00010'}"> style="display:inline-block;"</c:if>>결정시한:
					<img id='CaliCal${cnt}IconImg' class='calImg' src='../images/calendar.gif' align="absmiddle">
				</div>
				<input type="text" id="iCal${cnt}" value="${fn:substring(oFFer.dueDt,0,10)}" style="width:0px;border:0px none;background-color:transparent;visibility:hidden;"/>
				<script>if(typeof(initCal)=='function')initCal({id:"iCal${cnt}",type:"day",today:"y"});</script>
			<!-- 결정시한 달력 -->
			<!-- 소개창 -->
				<span class="mg0" id="IntroDucer" <c:if test="${IW!='Y'}">style="display:none;"</c:if>>
					<input type="hidden" id="introducerSnb_0${cnt}"/>
					<input type="hidden" id="introducerName_0${cnt}"/>
					<span class="btn s"><a onclick="popUp('${DaY}','introducer')" id="sltIntroducer_0${cnt}" class="c_title" title="소개창 팝업">소개창</a></span>
				</span>
			<!-- 소개창 -->
				<input type="hidden" id="AP_infoProviderId${cnt}" value="${oFFer.infoProvider }"/>
				<input type="hidden" id="AP_coworkerId${cnt}" value="${oFFer.coworker}"/>
				<input type="hidden" id="AP_supporterId${cnt}" value="${oFFer.supporter }"/>
				<input type="hidden" id="AP_supporterRatio${cnt}" value="${oFFer.supporter }"/>
				<input type="hidden" id="AP_supporterText${cnt}" value="${oFFer.supporterText}"/>
			</c:if>

			<span class="mg0" id="slctNnI${cnt}" <c:if test="${entrustNnI!='Y'}">style="display:none;"</c:if>>
				<input class="rdoLH mg0" type="radio" name="NnI${cnt}" value="00001" <c:if test="${oFFer.entrust=='00001'}">checked="checked"</c:if>><small style="vertical-align:top;line-height:15px;height:15px;">신규</small>
				<input class="rdoLH mg0" type="radio" name="NnI${cnt}" value="00002" <c:if test="${oFFer.entrust=='00002'}">checked="checked"</c:if>><small style="vertical-align:top;line-height:15px;height:15px;">증액</small>
			</span>

		</c:if>
			<span style="float:right;"><b>${oFFer.rgNm } </b>${oFFer.tmDt }</span>

		<c:if test="${update_view != 'view' || not empty oFFer.infoProviderNm}">
			<span id="SlctPerson_${cnt}">
				<%--
				<b><span id="coworkerTitle_${cnt}" <c:if test="${CW!='Y'}">style="display:none"</c:if>>약속자 : </span></b>
				<span id="selectStaffCstId_${cnt}" class="btn s red" style="<c:if test="${CW_BT!='Y'}">display:none;</c:if>">
				<c:if test="${update_view == 'update'}"><a id="AP_StaffCstId${cnt}" class="c_title" onclick="slctStaff(this,'${cnt}','AP_StaffCstId','AP_coworkerId')" ><c:if test="${empty oFFer.coworkerNm}">직원선택</c:if></c:if>
				<c:if test="${update_view == 'view'}"  ><a id="AP_StaffCstId${cnt}" class="c_title"></c:if>
				${oFFer.coworkerNm}
				</a></span>
				--%>
				<span id="split_${cnt}"><%-- <c:if test="${slct1st == '00010'}"><br/></c:if> --%></span>

				<b><span id="infoProviderTitle1_${cnt}" <c:if test="${IF1!='Y'}">style="display:none"</c:if>>정보제공자 : </span>
				<%-- <span id="infoProviderTitle2_${cnt}" <c:if test="${IF2!='Y'}">style="display:none"</c:if>>소개자 : </span> --%></b>
				<span id="selectInfoProvider_${cnt}" class="btn s navy" style="<c:if test="${IF_BT1!='Y'}">display:none;</c:if>">
				<c:if test="${update_view == 'update'}"><a class="c_title" onclick="popUp('${cnt}','iP')" id="AP_infoProviderNm${cnt}"><c:if test="${empty oFFer.infoProviderNm}">인물선택</c:if></c:if>
				<c:if test="${update_view == 'view'}"  ><a class="c_title"></c:if>
				<c:if test="${not empty oFFer.infoProviderNm}">${oFFer.infoProviderCpnNm} : ${oFFer.infoProviderNm}</c:if>
				</a></span>
			</span>
		</c:if>

		<c:if test="${update_view == 'update'}">
			<input type="hidden" id="AP_cpnId_${cnt}" value="${oFFer.cpnId }"/>
			<input type="hidden" id="AP_cstId_${cnt}" value="${oFFer.cstId }"/>
			<input type="hidden" id="AP_cpnSnb_${cnt}" value="${oFFer.cpnSnb }"/>
			<input type="hidden" id="prevCpnCst_${cnt}" value="${oFFer.cpnCst }"/>
		</c:if>
		<c:if test="${update_view != 'view' || not empty oFFer.cpnNm}">
			<nobr>
			<span id="slctCpn_${cnt}" <c:if test="${noneCpn=='Y'}">style="display:none;"</c:if>><b>
				<span id="cpnTitle1_${cnt}" <c:if test="${CP1!='Y'}">style="display:none"</c:if>>회사</span>
				<span id="textTmp_${cnt}"   <c:if test="${CP3!='Y'}">style="display:none"</c:if>><small>(물건)</small></span></b>
				 : <span class="btn s orange">
					<c:if test="${update_view == 'update'}"><a onclick="popUp('${cnt}','c')" id="AP_cpnNm_${cnt}" title="회사수정" class="c_title"><c:if test="${empty oFFer.cpnNm}">회사선택</c:if></c:if>
					<c:if test="${update_view == 'view'  }"><a class="c_title"></c:if>
					${oFFer.cpnNm}
				</a></span>
			</span>
			</nobr>
		</c:if>
		<c:if test="${oFFer.categoryCd == '00008' or oFFer.categoryCd == '00012'}"><nobr>
			<span id="cpnTYPE">업종:
				<select id="cpnTYPEcd">
						<option <c:if test="${oFFer.cpnTypeCd == '00000'}">selected</c:if>></option>
					<c:forEach var="cmmCd" items="${cmmCdTypeList}">
						<option value="${cmmCd.cd}" <c:if test="${oFFer.cpnTypeCd == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<input type="text" id="AP_cpnType" style="width:78px;" value="${oFFer.cpnType}" title="${oFFer.cpnType}"<c:if test="${update_view == 'view'}"> disabled="true"</c:if>/></span>
		</nobr></c:if>
		<c:if test="${oFFer.categoryCd eq '00008' or oFFer.categoryCd eq '00012' or oFFer.offerCd eq '00010'}">
			<input type="hidden" id="AP_cpnTYPE"/>
		</c:if>

			<span id="split1_${cnt}"><c:if test="${slct1st == '00012'}"><br/></c:if></span>

		<c:if test="${update_view != 'view' || not empty oFFer.cstNm}">
			<span id="slctPrsn_${cnt}" <c:if test="${noneCst=='Y'}">style="display:none;"</c:if>>
				<nobr>
					<span id="cstTitle1_${cnt}" <c:if test="${CS1!='Y'}">style="display:none"</c:if>><b>중개인</b></span>
					<span id="cstTitle2_${cnt}" <c:if test="${CS2!='Y'}">style="display:none"</c:if>><b>고객</b></span>
					<span id="cstTitle3_${cnt}" <c:if test="${CS3!='Y'}">style="display:none"</c:if>><b>회사관계자</b></span>
					<span id="cstTitle4_${cnt}" <c:if test="${CS4!='Y'}">style="display:none"</c:if>><b>정보제공자</b></span>
					<span id="cstTitle6_${cnt}" <c:if test="${CS6!='Y'}">style="display:none"</c:if>><b>통화자</b></span>
					<span id="cstTitle7_${cnt}" <c:if test="${CS7!='Y'}">style="display:none"</c:if>><b>소개자</b></span>
					<span id="cstTitle5_${cnt}" <c:if test="${CS5!='Y'}">style="display:none"</c:if>>
						<input class="rdoLH mg0" type="radio" name="CnP${cnt}" value="00002" <c:if test="${oFFer.cpnCst=='00002'}">checked="checked"</c:if>><small style="vertical-align:top;">개인</small>
						<input class="rdoLH mg0" type="radio" name="CnP${cnt}" value="00001" <c:if test="${oFFer.cpnCst=='00001'}">checked="checked"</c:if>><small style="vertical-align:top;">법인</small>
						<b>고객</b>
					</span> : <span class="btn s blue">
							<c:if test="${update_view == 'update'}"><a class="c_title" title="${oFFer.position}" onclick="popUp('_${cnt}','p')" id="AP_cstNm_${cnt}"><c:if test="${empty oFFer.cstNm}">인물선택</c:if></c:if>
							<c:if test="${update_view == 'view'}"  ><a class="c_title" title="${oFFer.position}"></c:if>
							<c:if test="${not empty oFFer.cstNm}">${oFFer.cstCpnNm} : ${oFFer.cstNm}</c:if>
							</a></span>
				</nobr>
			</span>
		</c:if>

		<c:if test="${not empty oFFer.realNm}"><br/>
			<c:choose>
				<c:when test="${fn:indexOf(oFFer.realNm,'^^^') > 0}">
					<c:set var="imgNm" value="${fn:split(oFFer.realNm, '^^^')}"/>
					<c:set var="makeNm" value="${fn:split(oFFer.makeNm, '^^^')}"/>
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
						<c:if test="${extension[lastDot]=='pdf'}">
						<c:set var="ext" value="pdf"/></c:if>
						&nbsp;<img class="mail_send filePosition" style="cursor:pointer;" id="file${imSt.count}" <c:choose><c:when test="${empty ext or ext == ''}">src="../images/file/files.png"</c:when><c:otherwise>src="../images/file/${ext}.png"</c:otherwise></c:choose>title="${im}">
						${im}<c:if test="${update_view == 'update'}"><a href="javascript:deleteFileOne(${oFFer.sNb}, '${makeNm[imSt.count-1]}');"> <font color=red>x</font></a></c:if><br/>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:set var="extension" value="${fn:split(oFFer.realNm,'.')}"/>
					<c:set var="lastDot" value="${fn:length(extension)-1}"/>
					<input type="hidden"  id="mkNames1" value="${oFFer.makeNm}"/>
					<c:set var="ext" value=""/>
					<c:if test="${extension[lastDot]=='doc' or extension[lastDot]=='docx'}"><c:set var="ext" value="doc"/></c:if>
					<c:if test="${extension[lastDot]=='xls' or extension[lastDot]=='xlsx'}"><c:set var="ext" value="xls"/></c:if>
					<c:if test="${extension[lastDot]=='ppt' or extension[lastDot]=='pptx'}"><c:set var="ext" value="ppt"/></c:if>
					<c:if test="${extension[lastDot]=='pdf'}"><c:set var="ext" value="pdf"/></c:if>
					&nbsp;<img class="mail_send filePosition" style="cursor:pointer;" id="file1" <c:choose><c:when test="${empty ext or ext == ''}">src="../images/file/files.png"</c:when><c:otherwise>src="../images/file/${ext}.png"</c:otherwise></c:choose>title="${oFFer.realNm}">
					${oFFer.realNm}<c:if test="${update_view == 'update'}"><a href="javascript:deleteFileOne(${oFFer.sNb}, '${oFFer.makeNm}');"> <font color=red>x</font></a></c:if><br/>
				</c:otherwise>
			</c:choose>
		</c:if>

		<c:if test="${update_view == 'update'}"><nobr>&nbsp;
			<span id="fileAdd_${cnt }" style="display:inline-block;text-align:right;">
				<span id="reportYN_" <c:if test="${RP!='Y'}">style="display:none;"</c:if>><label><input type="checkbox" onclick="checkReportYN(this);" <c:if test="${oFFer.reportYN eq 'Y'}">checked</c:if>><b>리포트</b></label></span>
				<%--<c:if test="${empty oFFer.realNm}"><span class="btn s"><a onclick="popUp('${DaY}','files')">파일첨부</a></span></c:if> --%>
				<span class="btn s"><a onclick="popUp('${DaY}','files')">파일첨부</a></span>
			</span></nobr>
		</c:if>

		<c:if test="${update_view == 'update'}">
			<input type="hidden" id="rcmderSnb_${cnt}" value="${oFFer.rcmdSnb}"/>
			<span class="btn s puple" id="rcmdWorkSpan_${cnt}" <c:if test="${RW!='Y'}">style="display:none;"</c:if>><a id="rcmdWork_${cnt}" onclick="popUp('${cnt}','rcmdWork','','${oFFer.cpnId }')">${oFFer.cpnId}</a></span>
			<span id="personNetwork_${cnt }" style="display:none">
				<!-- <b>인물정보 :</b> -->
				<input type="hidden" id="perNetSnb_0${cnt}"/>
				<input type="hidden" id="perNetName_0${cnt}"/>
				<span class="btn s blue">
					<a onclick="popUp('_0${cnt}','workNetp')" id="sltPerNetName_0${cnt}" class="c_title" title="이름">인물선택</a>
				</span><br/>
				<span style="display:block;margin-top:5px;">
					<font color="crimson"><b>&nbsp;※ 인물을 선택하면 해당 인물의 정보창이 팝업됩니다.
					<br/>&nbsp;※ 인맥(인물네트워크),&nbsp;&nbsp;법인네트워크,&nbsp;&nbsp;이력/정보,&nbsp;&nbsp;딜경력 등을 추가할 수 있습니다.
					</b></font>
				</span>
				<%--
				<br/><p style="height:2px;background-color:gray">&nbsp;</p>
				<b>인물소개 :</b>
				<input type="hidden" id="introducerSnb_0${cnt}"/>
				<input type="hidden" id="introducerName_0${cnt}"/>
				<span class="btn s">
					<a onclick="popUp('${DaY}','introducer')" id="sltIntroducer_0${cnt}" class="c_title" title="소개창 팝업">소개창</a>
				</span>
				--%>
			</span>
		</c:if>
			<span style="float:right;color:blue;">${oFFer.tmpNum1}</span>
		</li>

		<li><input class="m_note" type="text" id="AP_price" value="${oFFer.price}" placeholder="발행규모" style="<c:if test="${PE!='Y'}">display:none;</c:if><c:if test="${IP=='Y'}">width:246px;</c:if>margin-top:2px;<c:if test="${slct1st == '00012'}">display:none</c:if>"<c:if test="${update_view == 'view'}"> disabled="true"</c:if> <%--  <c:if test="${empty oFFer.price || oFFer.price=='발행규모'}">style="display:none;"</c:if> --%>><input class="m_note" type="text" id="AP_investPrice${cnt}" placeholder="투자규모(억)" value="${oFFer.investPrice}" style="width:246px;margin-left:2px;margin-top:2px;<c:if test="${IP!='Y'}">display:none</c:if>"<c:if test="${update_view == 'view'}"> disabled="true"</c:if>></li>

		<c:if test="${update_view == 'view'}">
			<c:if test="${CH =='Y'}"><c:forEach var="Ofif" items="${offerInfoList}" varStatus="OfifS"><c:if test="${not empty Ofif.comment }"><c:set var="nEmpty" value="${nEmpty+1}"/></c:if></c:forEach>
			<c:if test="${nEmpty>0}">
			<li style="padding-top:5px;"><b>핵심체크사항</b></li>
			<li style="width: 502px;border:2px dotted navy;">
				<ul style="padding: 2px;font-family: 맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif;">
					<c:forEach var="Ofif" items="${offerInfoList}" varStatus="OfifS"><c:if test="${not empty Ofif.comment }"><c:if test="${Ofif.cdSort eq '00001' and Ofif.offerSnb eq oFFer.sNb}"><li class="v-textarea" style="width:490px;">
						<c:if test="${Ofif.categoryCd eq '00008'}">
							<c:forEach var="starC" begin="1" end="${Ofif.star}"><img class="" id="file${starC}" src="../images/figure/star_y.png" style="width:10px;height:10px;"/></c:forEach><c:forEach var="starC" begin="${Ofif.star+1}" end="5"><img class="" id="file${starC}" src="../images/figure/star_g.png" style="width:10px;height:10px;"/>
							</c:forEach>
							(<c:if test="${Ofif.expirationDt eq '3'}">3개월</c:if>
							<c:if test="${Ofif.expirationDt eq '6'}">6개월</c:if>
							<c:if test="${Ofif.expirationDt eq '9'}">9개월</c:if>
							<c:if test="${Ofif.expirationDt eq '12'}">1년</c:if>
							<c:if test="${Ofif.expirationDt eq '24'}">2년</c:if>	)
						</c:if>
						<c:choose><c:when test="${empty Ofif.cdDc}">${Ofif.cdNm}</c:when><c:otherwise>${Ofif.cdDc}</c:otherwise></c:choose>: <b>${Ofif.comment}</b></li></c:if>
					</c:if></c:forEach>
				</ul>
			</li>
			</c:if>
			</c:if>
			<%--<li class="c_note v-textarea">${fn:replace(oFFer.memo, lf,"<br/>")}</li> 사이즈, 펼쳐보기 버튼 사용위해 하단 2줄로 대체 20150708  --%>
			<li class="c_note" style="margin-top:2px;"><textarea id="txtarea${cnt}" readonly>${oFFer.memo}</textarea></li>
			<li style="float:left;"><span class="btn s gold"><a href="#" onclick="resizeMemo('txtarea${cnt}');return false;"><i class="fa fa-arrow-circle-down"></i></i> 펼쳐보기</a></span></li>
		</c:if>
		<c:if test="${update_view == 'update'}">
			<li id="KP_title_${cnt}" style="width: 720px; padding-top:5px; padding-bottom:2px; <c:if test="${CH !='Y'}">display:none;</c:if>"><b>핵심체크사항</b><%-- &nbsp;&nbsp;&nbsp;&nbsp;<span class="btn s black" style="vertical-align:bottom;"><a class="viewKeyP" id="viewKP_${cnt}">보이기</a></span> --%></li>
			<li id="KP_slct_${cnt}" style="width: 720px; border:2px dotted navy;<c:if test="${CH !='Y'}">display:none;</c:if>">
			<ul class="keypoint_ul" style="padding: 1px;font-family: 맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif;">
				<li>
					<input type="hidden" id="kyPmaxLeng" value="${fn:length(offerInfoList)}"/>
					<c:forEach var="Ofif" items="${offerInfoList}" varStatus="OfifS"><c:if test="${Ofif.cdSort eq '00001'}"><c:set var="kpCnt" value="${kpCnt+1}"/>
						<c:if test="${not empty Ofif.sNb}"><input type="hidden" id="kyPointSnb${fn:substring(Ofif.categoryCd,3,6)}" value="${Ofif.sNb}"/></c:if><c:if test="${Ofif.categoryCd eq '00008'}"><span id="KP_ivstCmnt${cnt}"<c:if test="${CH1!='Y'}"> style="display:none"</c:if>><input type="hidden" id="chkStar_0${cnt}" value="${starVal}"/></c:if>
						<span class="keyPstl <c:if test="${Ofif.categoryCd eq '00008'}">wide_analysis</c:if>">
							<label><input type="checkbox" id="chk${fn:substring(Ofif.categoryCd,3,6)}_0${cnt}" <c:if test="${Ofif.categoryCd eq '00008' and (isExistAnalOpt eq 'Y' or isToday ne 'Y') and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> value="Y" class="input_chk" onclick="chkBoxViewTextarea(this)"<c:if test="${not empty Ofif.comment}"> checked</c:if>/><c:choose><c:when test="${empty Ofif.cdDc}">${Ofif.cdNm}</c:when><c:otherwise>${Ofif.cdDc}</c:otherwise></c:choose></label>
							<c:if test="${Ofif.categoryCd eq '00008'}">&nbsp;
							<c:forEach var="starC" begin="1" end="${Ofif.star}"><img class="hand" id="file${starC}" src="../images/figure/star_y.png" style="width:16px;height:16px;vertical-align:middle;" <c:if test="${(isExistAnalOpt ne 'Y' and isToday eq 'Y') or baseUserLoginInfo.analMaster eq 'Y'}"> onmousedown="javascript:slctStar(this);"</c:if> /></c:forEach>
							<c:forEach var="starC" begin="${Ofif.star+1}" end="5"><img class="hand" id="file${starC}" src="../images/figure/star_g.png" style="width:16px;height:16px;vertical-align:middle;" <c:if test="${(isExistAnalOpt ne 'Y' and isToday eq 'Y') or baseUserLoginInfo.analMaster eq 'Y'}"> onmousedown="javascript:slctStar(this);"</c:if> /></c:forEach>

							<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(※분석 유효기간 :
							<label><input type="radio" <c:if test="${(isExistAnalOpt eq 'Y' or isToday ne 'Y') and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="3" <c:if test="${Ofif.expirationDt eq '3'}">checked</c:if>><c:if test="${Ofif.expirationDt eq '3'}"><u></c:if>3개월 <c:if test="${Ofif.expirationDt eq '3'}"></u></c:if></label>
							<label><input type="radio" <c:if test="${(isExistAnalOpt eq 'Y' or isToday ne 'Y') and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="6" <c:if test="${Ofif.expirationDt eq '6'}">checked</c:if>><c:if test="${Ofif.expirationDt eq '6'}"><u></c:if>6개월 <c:if test="${Ofif.expirationDt eq '6'}"></u></c:if></label>
							<label><input type="radio" <c:if test="${(isExistAnalOpt eq 'Y' or isToday ne 'Y') and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="9" <c:if test="${Ofif.expirationDt eq '9'}">checked</c:if>><c:if test="${Ofif.expirationDt eq '9'}"><u></c:if>9개월 <c:if test="${Ofif.expirationDt eq '9'}"></u></c:if></label>
							<label><input type="radio" <c:if test="${(isExistAnalOpt eq 'Y' or isToday ne 'Y') and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="12" <c:if test="${Ofif.expirationDt eq '12'}">checked</c:if>><c:if test="${Ofif.expirationDt eq '12'}"><u></c:if>1년 <c:if test="${Ofif.expirationDt eq '12'}"></u></c:if></label>
							<label><input type="radio" <c:if test="${(isExistAnalOpt eq 'Y' or isToday ne 'Y') and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="24" <c:if test="${Ofif.expirationDt eq '24'}">checked</c:if>><c:if test="${Ofif.expirationDt eq '24'}"><u></c:if>2년 <c:if test="${Ofif.expirationDt eq '24'}"></u></c:if></label>
							)

							</c:if></span>
							<textarea id="kyPoint${fn:substring(Ofif.categoryCd,3,6)}_0${cnt}" <c:if test="${Ofif.categoryCd eq '00008' and (isExistAnalOpt eq 'Y' or isToday ne 'Y') and baseUserLoginInfo.analMaster ne 'Y'}">readonly="true"</c:if> class="d_note" placeholder="NEEDS 내용"<c:if test="${empty Ofif.comment }"> style="display:none"</c:if>><c:if test="${not empty Ofif.comment }">${Ofif.comment}</c:if></textarea>

						<c:if test="${Ofif.categoryCd eq '00008'}"></span></li><li></c:if>
						<%--<c:if test="${(kpCnt)%2 eq 0}"></li><li></c:if> --%>
						</li><li>
					</c:if></c:forEach>
				</li>
			</ul>
			</li>
			<li style="float:left;padding-left:655px;"><span class="btn s gold"><a href="#" onclick="resizeMemo('txtarea${cnt}');return false;"><i class="fa fa-arrow-circle-down"></i></i> 펼쳐보기</a></span></li>
			<li class="c_note" style="margin-top:2px;"><textarea id="txtarea${cnt}">${oFFer.memo}</textarea></li>
		</c:if>

		<li class="bsnsR_btn">
			<c:if test="${update_view == 'update'}">
				<span id="btn_update" class="offerR_btnOk btn s orange"><a>수정</a></span>&nbsp;&nbsp;&nbsp;
				<span id="btn_delete" class="offerR_btnDel btn s red" style="<c:if test="${isExistAnalOpt eq 'Y' and baseUserLoginInfo.analMaster ne 'Y'}">display:none;</c:if>"><a>완전삭제</a></span>
			</c:if>
			<input type="text" id="foCus_${fn:substring(oFFer.tmDt, 8,10)}_${cnt}" style="height:0.5px;width:0.5px;border:0px none;padding:0;vertical-align:bottom;">

			<span class="secretChk" style="display:none;">
				정보공개등급${oFFer.infoLevel}
				<select id="infoLevel" name="infoLevel" class="" onchange="setSelectColor(this);">
					<option value="9" style="background-color:#ffffff;">일반등급</option>
					<c:if test="${fn:contains(infoLevelList, '8')}"><option value="8" <c:if test="${oFFer.infoLevel == '8'}">selected</c:if> style="background-color:#ffbbbb;">보안8등급</option></c:if>
					<c:if test="${fn:contains(infoLevelList, '7')}"><option value="7" <c:if test="${oFFer.infoLevel == '7'}">selected</c:if> style="background-color:#ffaaaa;">보안7등급</option></c:if>
					<c:if test="${fn:contains(infoLevelList, '6')}"><option value="6" <c:if test="${oFFer.infoLevel == '6'}">selected</c:if> style="background-color:#ff9999;">보안6등급</option></c:if>
					<c:if test="${fn:contains(infoLevelList, '5')}"><option value="5" <c:if test="${oFFer.infoLevel == '5'}">selected</c:if> style="background-color:#ff8888;">보안5등급</option></c:if>
					<c:if test="${fn:contains(infoLevelList, '4')}"><option value="4" <c:if test="${oFFer.infoLevel == '4'}">selected</c:if> style="background-color:#ff7777;">보안4등급</option></c:if>
					<c:if test="${fn:contains(infoLevelList, '3')}"><option value="3" <c:if test="${oFFer.infoLevel == '3'}">selected</c:if> style="background-color:#ff5555;">보안3등급</option></c:if>
					<c:if test="${fn:contains(infoLevelList, '2')}"><option value="2" <c:if test="${oFFer.infoLevel == '2'}">selected</c:if> style="background-color:#ff4444;">보안2등급</option></c:if>
					<c:if test="${fn:contains(infoLevelList, '1')}"><option value="1" <c:if test="${oFFer.infoLevel == '1'}">selected</c:if> style="background-color:#ff2222;">보안1등급</option></c:if>
				</select>

				<span style="border:#CCC solid 1px; background-color:#FCFCFC;">
					<a href="javascript:viewInfoLevel(<c:if test="${oFFer.categoryCd == '00008'}">'m'</c:if>);"><font color="#777777">※&nbsp;정보등급보기&nbsp;</font></a>
				</span>
			</span>
		</li>
	</ul>
	</c:forEach>

	<!-- ------------------------------------------ 신규입력 ---------------------------------------------- -->

	<c:if test="${empty statsList}">
		<input type="hidden" id="offerSnb">
		<input type="hidden" id="DaY" value="${DaY}"/>
		<ul>
			<li>
				<input type="hidden" id='middleOfferCd_${cnt}' value="00001"/>
				<input type="hidden" id='offerCd_${cnt}' value="00007"/>

				<select class="work-1stSelect" onchange="slctWork(this,'1')"><!-- 딜 -->
					<c:forEach var="cmmCd" items="${cmmCd1stSlctList}">
						<option value="${cmmCd.cd}">${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<select class="work-2ndSelect" onchange="slctWork(this,'2')"><!-- 중개 -->
					<c:forEach var="cmmCd" items="${ccdSourcingTypeList}">
						<option value="${cmmCd.cd}">${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<select class="work-2ndSelect" onchange="slctWork(this,'2')" style="display:none"><!-- 일임계약 -->
					<c:forEach var="cmmCd" items="${ccdAttractFuncList}">
						<option value="${cmmCd.cd}">${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<select class="work-2ndSelect" onchange="slctWork(this,'2')" style="display:none"><!-- 미팅 -->
					<c:forEach var="cmmCd" items="${ccdInfoRegTypeList}">
						<option value="${cmmCd.cd}">${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<select class="work-2ndSelect" onchange="slctWork(this,'2')" style="display:none"><!-- 회원사 -->
					<c:forEach var="cmmCd" items="${ccdShareHolderList}">
						<option value="${cmmCd.cd}">${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<select class="work-3rdSelect" onchange="slctWork(this,'3')" disabled="true"><!-- 제안 -->
					<c:forEach var="cmmCd" items="${ccdOfferTypeList}">
						<option value="${cmmCd.cd}">${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<select class="work-3rdSelect" onchange="slctWork(this,'3')" style="display:none"><!-- 직접섭외 -->
					<c:forEach var="cmmCd" items="${ccdPublicRelation}">
						<option value="${cmmCd.cd}">${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<select class="work-3rdSelect" onchange="slctWork(this,'3')" style="display:none"><!-- 산업분석 -->
					<c:forEach var="cmmCd" items="${cmmCdanalysisCpnList}">
						<option value="${cmmCd.cd}">${cmmCd.nm}</option>
					</c:forEach>
				</select>
				<span id='CateCd_${cnt}'><!-- &nbsp;유형: -->
					<select id='categoryCd_'  onchange="chngCategoryCd(this);">
						<option value="" selected>-유형선택-</option>
						<c:forEach var="cmmCd" items="${cmmCdCategoryList}">
							<option value="${cmmCd.cd}">${cmmCd.nm}</option>
						</c:forEach>
					</select>
					<select id="sellBuy">
						<option value="0">Sell</option>
						<option value="1">Buy</option>
						<option value="2">투자유치</option>
					</select>
				</span>

			<!-- 결정시한 달력 -->
				<div class="CaliCalendar" id='CaliCal0${cnt}Icon' title="결정시한" style="display:inline-block;">결정시한:
					<img id='CaliCal0${cnt}IconImg' class='calImg' src='../images/calendar.gif' align="absmiddle">
				</div>
				<input type="text" id="iCal0${cnt}" style="width:0px;border:0px none;background-color:transparent;visibility:hidden;"/>
				<script>if(typeof(initCal)=='function')initCal({id:"iCal0${cnt}",type:"day",today:"y"});</script>
			<!-- 결정시한 달력 -->

			<!-- 소개창 -->
				<span class="mg0" id="IntroDucer" style="display:none;">
					<input type="hidden" id="introducerSnb_0${cnt}"/>
					<input type="hidden" id="introducerName_0${cnt}"/>
					<span class="btn s"><a onclick="popUp('${DaY}','introducer')" id="sltIntroducer_0${cnt}" class="c_title" title="소개창 팝업">소개창</a></span>
				</span>
			<!-- 소개창 -->

				<input type="hidden" id="AP_infoProviderId0${cnt}"/>
				<input type="hidden" id="AP_coworkerId0${cnt}"/>
				<input type="hidden" id="AP_supporterId0${cnt}"/>
				<input type="hidden" id="AP_supporterRatio0${cnt}"/>
				<input type="hidden" id="AP_supporterText0${cnt}"/>
				<span class="mg0" id="slctNnI${cnt}" style="display:none;">
					<input class="rdoLH mg0" type="radio" name="NnI0${cnt}" value="00001"><small style="vertical-align:top;line-height:15px;height:15px;">신규</small>
					<input class="rdoLH mg0" type="radio" name="NnI0${cnt}" value="00002"><small style="vertical-align:top;line-height:15px;height:15px;">증액</small>
				</span>

				<span id="SlctPerson_${cnt}">
					<%--
					<b><span id="coworkerTitle_${cnt}">약속자 : </span></b>
					<span id="selectStaffCstId_0${cnt}" class="btn s red"><a onclick="slctStaff(this,'0${cnt}','AP_StaffCstId','AP_coworkerId')" id="AP_StaffCstId0${cnt}" class="c_title" title="이름">직원선택</a></span>
					<nobr><span id="support_${cnt}"><b>공동진행</b> : </span>
					<span id="support_btn_${cnt}" class="btn s gold"><a onclick="slctStaff(this,'0${cnt}','AP_supporter','AP_supporterId','1')" id="AP_supporter0${cnt}" class="c_title" title="이름">직원선택</a></span></nobr>
					--%>

					<span id="split_${cnt}"></span>

					<b><span id="infoProviderTitle1_${cnt}" style="display:none">정보제공자 : </span>
					<%-- <span id="infoProviderTitle2_${cnt}" style="display:none">소개자 : </span> --%>
					</b><span id="selectInfoProvider_0${cnt}" class="btn s navy" style="display:none;"><a onclick="popUp('0${cnt}','iP')" id="AP_infoProviderNm0${cnt}" class="c_title" title="이름">인물선택</a></span>
				&nbsp;</span>

				<input type="hidden" id="AP_cpnId_0${cnt}" value=""/>
				<input type="hidden" id="AP_cstId_0${cnt}" value="0"/>
				<input type="hidden" id="AP_cpnSnb_0${cnt}" value="0"/>
				<nobr><span id="slctCpn_${cnt}"><b>
						<span id="cpnTitle1_${cnt}">회사</span>
						<span id="textTmp_${cnt}"><small>(물건)</small></span></b> : <span class="btn s orange"><a onclick="popUp('0${cnt}','c')" id="AP_cpnNm_0${cnt}" class="c_title" title="회사선택">회사선택</a></span>
					</span>
					<span id="cpnTYPE" style="display:none">업종:
						<select id="cpnTYPEcd">
							<c:forEach var="cmmCd" items="${cmmCdTypeList}">
								<option value="${cmmCd.cd}"<c:if test="${'00009' == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
							</c:forEach>
						</select>
						<input type="hidden" id="AP_cpnTYPE" value="00009"/>
						<input type="text" id="AP_cpnType" style="width:78px;" placeholder="업종"/></span>
				</nobr>

				<span id="split1_${cnt}"></span>

				<span id="slctPrsn_${cnt}"><nobr>
					<span id="cstTitle1_${cnt}"><b>중개인</b></span>
					<span id="cstTitle2_${cnt}" style="display:none"><b>고객</b></span>
					<span id="cstTitle3_${cnt}" style="display:none"><b>회사관계자</b></span>
					<span id="cstTitle4_${cnt}" style="display:none"><b>정보제공자</b></span>
					<span id="cstTitle5_${cnt}" class="mg0" style="display:none">
						<input class="rdoLH mg0" type="radio" name="CnP0${cnt}" value="00002" checked="checked"><small style="vertical-align:top;line-height:15px;height:15px;">개인</small>
						<input class="rdoLH mg0" type="radio" name="CnP0${cnt}" value="00001"><small style="vertical-align:top;line-height:15px;height:15px;">법인</small>
					</span>
					<span id="cstTitle7_${cnt}" style="display:none"><b>소개자</b></span>
					<span id="cstTitle6_${cnt}" style="display:none"><b>통화자</b></span> : <span class="btn s blue">
						<a onclick="popUp('_0${cnt}','p')" id="AP_cstNm_0${cnt}" class="c_title" title="이름">인물선택</a></span></nobr>
				</span>

			&nbsp;<span id="fileAdd_${cnt }" style="display:inline-block;text-align:right;">
					<span id="reportYN_" style="display:none;"><label><input type="checkbox"/><b>리포트</b></label></span>
					<span class="btn s"><a onclick="popUp('${DaY}','files')">파일첨부</a></span>
				</span>
				<input type="hidden" id="rcmderSnb_0${cnt}" value=""/>
				<span class="btn s puple" id="rcmdWorkSpan_0${cnt}" style="display:none;"><a id="rcmdWork_0${cnt}" onclick="alert('회사를 먼저 선택하세요.');">추천인</a></span>

				<span id="personNetwork_${cnt }" style="display:none">
					<!-- <b>인물정보 :</b> -->
					<input type="hidden" id="perNetSnb_0${cnt}"/>
					<input type="hidden" id="perNetName_0${cnt}"/>
					<span class="btn s blue">
						<a onclick="popUp('_0${cnt}','workNetp')" id="sltPerNetName_0${cnt}" class="c_title" title="이름">인물선택</a>
					</span><br/>
					<span style="display:block;margin-top:5px;">
						<font color="crimson"><b>&nbsp;※ 인물을 선택하면 해당 인물의 정보창이 팝업됩니다.
						<br/>&nbsp;※ 인맥(인물네트워크),&nbsp;&nbsp;법인네트워크,&nbsp;&nbsp;이력/정보,&nbsp;&nbsp;딜경력 등을 추가할 수 있습니다.
						</b></font>
					</span>
					<%--
					<br/><p style="height:2px;background-color:gray">&nbsp;</p>
					<b>인물소개 :</b>
					<input type="hidden" id="introducerSnb_0${cnt}"/>
					<input type="hidden" id="introducerName_0${cnt}"/>
					<span class="btn s">
						<a onclick="popUp('${DaY}','introducer')" id="sltIntroducer_0${cnt}" class="c_title" title="소개창 팝업">소개창</a>
					</span>
					--%>
				</span>
				<span id="totalValue" style="display:none;"><nobr>매매가기준 시가총액: <input type="input" id="totalMarketValue"/>억</nobr></span>
			</li>
			<%-- <li id="pltPersonNetwork_${cnt }" style="display:none;border:0px solid burlywood;margin-top:5px;">
				<font color="crimson"><b>&nbsp;※ 인물을 선택하면 해당 인물의 정보창이 팝업됩니다.
				<br/>&nbsp;※ 인맥(인물네트워크),&nbsp;&nbsp;법인네트워크,&nbsp;&nbsp;이력/정보,&nbsp;&nbsp;딜경력 등을 추가할 수 있습니다.
				</b></font>
			</li> --%>
			<li><input type="text" class="m_note" id="AP_price_0${cnt}" placeholder="발행규모" style="width:246px;margin-top:2px;"/><input type="text" class="m_note" id="AP_investPrice_0${cnt}" placeholder="투자규모(억)" style="width:246px;margin-left:2px;margin-top:2px;"/></li>

			<li id="KP_title_${cnt}" style="padding-top:5px;padding-bottom:2px; display:none;"><b>핵심체크사항</b><%-- &nbsp;&nbsp;&nbsp;&nbsp;<span class="btn s black" style="vertical-align:bottom;"><a class="viewKeyP" id="viewKP_${cnt}">보이기</a></span> --%></li>
			<li id="KP_slct_${cnt}" style="width: 720px;border:2px dotted navy; display:none;">
				<ul class="keypoint_ul" style="padding: 1px;font-family: 맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif;">
					<li><input type="hidden" id="kyPmaxLeng" value="${fn:length(cmmCdKeyPointList)}"/>
						<c:forEach var="kp" items="${cmmCdKeyPointList}" varStatus="kpS">
							<c:set var="kpCnt" value="${kpCnt+1}"/>
								<c:if test="${kp.cd eq '00008'}">
									<span id="KP_ivstCmnt${cnt}" style="display:none;"><input type="hidden" id="chkStar_0${cnt}" value=""/>
								</c:if>

								<span class="keyPstl <c:if test="${kp.cd eq '00008'}">wide_analysis</c:if>">
									<label><input type="checkbox" id="chk${fn:substring(kp.cd,3,6)}_0${cnt}" <c:if test="${kp.cd eq '00008' and isToday ne 'Y' and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> value="Y" class="input_chk" onclick="chkBoxViewTextarea(this)"/>
									${kp.nm}
									</label>
									<c:if test="${kp.cd eq '00008'}">
										&nbsp;<c:forEach var="starC" begin="${Ofif.star}" end="4" varStatus="starCS"><img class="hand" id="file${starCS.count}" src="../images/figure/star_g.png" style="width:16px;height:16px;vertical-align:middle;" <c:if test="${isToday eq 'Y' or baseUserLoginInfo.analMaster eq 'Y'}">onmousedown="javascript:slctStar(this);"</c:if> />
										</c:forEach>
										<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(※분석 유효기간 :
										<label><input type="radio" <c:if test="${isToday ne 'Y' and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="3">3개월</label>
										<label><input type="radio" <c:if test="${isToday ne 'Y' and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="6">6개월</label>
										<label><input type="radio" <c:if test="${isToday ne 'Y' and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="9">9개월</label>
										<label><input type="radio" <c:if test="${isToday ne 'Y' and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="12">1년 </label>
										<label><input type="radio" <c:if test="${isToday ne 'Y' and baseUserLoginInfo.analMaster ne 'Y'}">disabled="true"</c:if> name="expirationDate" value="24">2년 </label>
										)
									</c:if>
								</span>
								<textarea id="kyPoint${fn:substring(kp.cd,3,6)}_0${cnt}" class="d_note" <c:if test="${kp.cd eq '00008' and isToday ne 'Y' and baseUserLoginInfo.analMaster ne 'Y'}">readonly="true"</c:if> style="display:none;" placeholder="NEEDS 내용"></textarea>

								<c:if test="${kp.cd eq '00008'}"></span></li><li></c:if>
								<%--<c:if test="${(kpCnt)%2 == 0}"></li><li></c:if> --%>
								</li><li>
						</c:forEach>
						</span>
					</li>
				</ul>
			</li>

			<li style="float:left;padding-left:655px;"><span class="btn s gold"><a href="#" onclick="resizeMemo('txtarea${cnt}');return false;"><i class="fa fa-arrow-circle-down"></i> 펼쳐보기</a></span></li>
			<li class="c_note" style="margin-top:2px;"><textarea id="txtarea${cnt}"></textarea></li>

			<li class="bsnsR_btn">
				<span class="offerR_btnOk btn s green"><a>저장</a></span>
				<!-- <span class="offerR_btnDel">완전삭제</span> -->
				<input type="text" id="foCus_${cnt}_0" style="height:0.5px;width:0.5px;border:0px none;padding:0;vertical-align:bottom;">


				<span class="secretChk" style="display:none;">
					정보공개등급
					<select id="infoLevel" name="infoLevel" class="" onchange="setSelectColor(this);">
						<option value="9" style="background-color:#ffffff;">일반등급</option>
						<c:if test="${fn:contains(infoLevelList, '8')}"><option value="8" style="background-color:#ffbbbb;">보안8등급</option></c:if>
						<c:if test="${fn:contains(infoLevelList, '7')}"><option value="7" style="background-color:#ffaaaa;">보안7등급</option></c:if>
						<c:if test="${fn:contains(infoLevelList, '6')}"><option value="6" style="background-color:#ff9999;">보안6등급</option></c:if>
						<c:if test="${fn:contains(infoLevelList, '5')}"><option value="5" style="background-color:#ff8888;">보안5등급</option></c:if>
						<c:if test="${fn:contains(infoLevelList, '4')}"><option value="4" style="background-color:#ff7777;">보안4등급</option></c:if>
						<c:if test="${fn:contains(infoLevelList, '3')}"><option value="3" style="background-color:#ff5555;">보안3등급</option></c:if>
						<c:if test="${fn:contains(infoLevelList, '2')}"><option value="2" style="background-color:#ff4444;">보안2등급</option></c:if>
						<c:if test="${fn:contains(infoLevelList, '1')}"><option value="1" style="background-color:#ff2222;">보안1등급</option></c:if>
					</select>

					<span style="border:#CCC solid 1px; background-color:#FCFCFC;">
						<a href="javascript:viewInfoLevel();"><font color="#777777">※&nbsp;정보등급보기&nbsp;</font></a>
					</span>
				</span>
			</li>
		</ul>
	</c:if>
</div>



<script>
//파일삭제 기능 추가 20151001
function deleteFileOne(offerSnb, makeName){
	//alert(offerSnb + ',' + makeName);
	//return;
	if(confirm('삭제하시겠습니까?')){

		$.ajax({
			type:"POST",        					//POST GET
			url:"../work/deleteFileOne.do",     	//PAGEURL
			//  dataType: "html",       			//HTML XML SCRIPT JSON
			data : {offerSnb: offerSnb,
					makeName: makeName},
			timeout : 30000,       					//제한시간 지정
			cache : false,        					//true, false
			success: function whenSuccess(arg){  	//SUCCESS FUNCTION
				location.reload();
			},
			error: function whenError(x,e){    		//ERROR FUNCTION
				alert('error!');
			}
		});

	}

}

//select 색 세팅
function setSelectColor(th){
	$(th).css('background-color', $('#infoLevel option:selected').get(0).style.backgroundColor);
}


//정보등급보기 화면 팝업		... param t 수정모드에서 M&A 인경우에만 t 값이 'm' 으로 넘어온다.
function viewInfoLevel(t){

	if(typeof g_infoTypeTmp == 'undefined'){		//유형선택을 안해서 초기화 되지 않은 경우( 수정모드시 or 신규입력시 유형선택을 안했을때)
		if(t == 'm'){					//수정모드의 유형이 M&A 정보인경우
			g_infoTypeTmp = 'm';
		}else{							//그외
			g_infoTypeTmp = '';
		}
	}

	var url = "${pageContext.request.contextPath}/work/infoLevelPopup.do" + (isEmpty(g_infoTypeTmp)?'':'?it='+g_infoTypeTmp);
	var option = "left=" + (screen.width > 550?"200":"0") + ", top=" + (screen.height > 550?"100":"0") + ", width=550, height=433, menubar=no, status=no, toolbar=no, location=no, scrollbars=no, resizable=no";

	infoLevelPop = window.open(url, "_blank", option);

}


//유형선택 콤보 변경 ... 에 따른 정보등급보기 팝업 유형 결정 infoType  'm'
function chngCategoryCd(th){
	if(infoLevelPop){
		infoLevelPop.close();		//정보등급별 사용자 리스트 팝업이 열려 있는 상태로 ... 유형이 바뀐경우에는 닫아줘서 다시 열도록 유도한다. (유형에 따라 내용이 달라져야 하기 때문)
	}

	g_infoTypeTmp = ($(th).val() == '00008'?'m':'');
}


setSelectColor($('#infoLevel').get(0));		//수정 모드시 정보등급 콤보 색 세팅
</script>


<%--hover시 calImg 변화시키기--%>
<%--script>$(".calImg").hover(function(){$(".calImg").attr('src','../images/calBig.jpg');},function(){$(".calImg").attr('src','../images/calendar.gif');});</script--%>