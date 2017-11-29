<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/common/daumPost.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회사등록 | 회사 | 네트워크 | PASS (Project based Activity analysis and Sharing system)</title>
<meta name="copyright" content="COPYRIGHT@ Synergy Group" />
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/base.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript">
var dupChk = true;
$(document).ready(function(){
	$("#aCpnId").blur(function(){
		chkaCpnIdDup();
	});

	$('#foundDate2').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$('#foundDate2').attr("readonly","readonly");

	numberFormatForDigitClass();

	if($("#cpnNm").css("display")=="block"){
		$("#cpnNm").focus();
	}

	 //업무페이지에서 신규등록으로 넘어온 경우
    if($("#openPage").val() == "WORK_PAGE" && $("#frm #cpnId").val() == ""){
    	cpnPopupCallback(0 , $("#workCpnNm").val());
    }

    chkDomestic();
});

//aCpnId 중복체크
function chkaCpnIdDup(){

	var chkVal = $("input[name = 'listed']:checked").val();

	if(chkVal == "Y" && $("#aCpnId").val() != ""){
		//$("#frm #cpnId").val($("#aCpnId").val());
		$("#frm").attr("action",contextRoot+"/company/getCompanyDetailAjax.do");
		//Ajax 요청
		commonAjaxSubmit("POST",$("#frm"),chkaCpnIdDupCallback);
	}
}
//aCpnId 중복체크 콜백
function chkaCpnIdDupCallback(data){
	if(data.resultObject != undefined&&data.resultObject.cpnId != undefined && data.resultObject.cpnId != ""){
		if(confirm("이미등록된 상장코드입니다.\n["+data.resultObject.cpnNm+"] : " + data.resultObject.cpnId+"\n수정하시겠습니까?")){
			$("#frm").attr("action",contextRoot+"/company/rgstCpn.do");
			$("#frm #cpnId").val(data.resultObject.cpnId);
			$("#frm").submit();
		}
		dupChk = false;
	}else{
		dupChk = true;
	}
}
function screenResizeFull(){
	 self.moveTo(0,0); //창위치
	 self.resizeTo(screen.availWidth, screen.availHeight); //창크기
}
//회사검색팝업
function searchCpnPop(){
	var option = "width=850px,height=720px,resizable=yes,scrollbars = yes";
	commonPopupOpen("searchCpnPop",contextRoot+"/company/popUpCpn2.do",option,$("#frm"));
	//var url = "<c:url value='/company/popUpCpn2.do'/>?cpnNm="+$("#cpnNm").val();
	//window.open(url, 'searchCpnPop',option);
}
//우편번호검색
function fn_postCall(){
 	execDaumPostcode(fn_postCallCallback);
    $("#dtlAddr").val("");
    $("#dtlAddr").css("background-color","#F5F6F7");
    $("#dtlAddr").prop("readonly",true);
}
//우편번호찾기콜백
var fn_postCallCallback = function(){

	if($("#addr").val()!= ""){
		$("#addrDetail").prop("readOnly",false);
	}
};

//저장
function doSave(){

	if($("#comCd").val() == ""){
		if($("#cpnNm").css("display")=="none"){
			alert("회사 중복 체크를 진행해주세요");
			return;
		}
		if($("#cpnNm").val()==""){
	        alert("회사명을 입력해 주세요.");
	        $("#cpnNm").focus();
	        return;
	    }
	    var chkVal = $("input[name = 'listed']:checked").val();
	    /* if(chkVal == "Y" &&(!dupChk|| $("#aCpnId").val() == "")){
	        alert("상장코드를 입력해 주세요.");
	        $("#aCpnId").focus();
	        return;
	    } */
	    var domesticYn = $("input[name = 'domesticYn']:checked").val();

	    if(domesticYn == "Y"){
		    $("#phone").val($("#phone1").val()+"-"+$("#phone2").val()+"-"+$("#phone3").val());

		    if($("#phone").val().split("-").join("")!="" &&!isPhoneNumber($("#phone").val())){
		        alert("전화번호 형식에 맞지 않습니다.");
		        $("#phone1").focus();
		        return;
		    }
	    }else if(domesticYn == "N"){
	    	$("#phone").val($("#overseasPhone1").val()+"-"+$("#overseasPhone2").val()+"-"+$("#overseasPhone3").val()+"-"+$("#overseasPhone4").val());

	    	var chkPhon = $("#overseasPhone2").val()+"-"+$("#overseasPhone3").val()+"-"+$("#overseasPhone4").val();

	    	if(chkPhon.split("-").join("")!=""){

	    		if($("#overseasPhone1").val()==""){
	    			alert("국가코드를 선택해 주세요.");
	    			$("#overseasPhone1").focus();
	    			return;
	    		}

	    		if(!strInNum($("#overseasPhone2").val())||$("#overseasPhone2").val() == ""){
	    			alert("전화번호 형식에 맞지 않습니다.");
	    			$("#overseasPhone2").focus();
	    			return;
	    		}

	    		if(!strInNum($("#overseasPhone3").val())||$("#overseasPhone3").val() == ""){
	    			alert("전화번호 형식에 맞지 않습니다.");
	    			$("#overseasPhone3").focus();
	    			return;
	    		}

	    		if(!strInNum($("#overseasPhone4").val())||$("#overseasPhone4").val() == ""){
	    			alert("전화번호 형식에 맞지 않습니다.");
	    			$("#overseasPhone4").focus();
	    			return;
	    		}

		    }
	    }
	}

	$('#listedYn').val(chkVal);		//상장여부

	if(confirm("저장하시겠습니까?")){
		$("#addr").attr("disabled", false);
		$("#frm").attr("action", contextRoot + "/company/processCpnAjax.do");
		//Ajax 요청
		commonAjaxSubmit("POST", $("#frm"), callback);
	}
}

function callback(data){
	alert("정상적으로 저장되었습니다.");
	var cpnId = data.resultObject.cpnId;
	var sNb = data.resultObject.sNb;
	//업무화면에서 등록요청한 경우
    if($("#openPage").val() == "WORK_PAGE") {
        opener.cpnPopupCallback(cpnId,$("#cpnNm").val(),sNb);
        window.close();
    }else{
    	window.location.href = contextRoot+"/company/main.do?cpnId="+cpnId;
    }
}

//발행내역 상세
function viewDt(snb){
	if($("#listTr_"+snb+" .close").length>0){
		var targetAttr = $("#listTr_"+snb+" .close");
		targetAttr.removeClass();
		targetAttr.addClass("open");
	}else{
		var targetAttr = $("#listTr_"+snb+" .open");
		targetAttr.removeClass();
		targetAttr.addClass("close");
	}
	$("#dtTr_"+snb).toggle();
}
//팝업콜백
function cpnPopupCallback(cpnId , cpnNm,sNb){
	if(cpnId == 0){
		$("#cpnNm").val(cpnNm);
		$("#cpnNm").show();
	}else{
		$("#frm").attr("action",contextRoot+"/company/rgstCpn.do");
		$("#frm #cpnId").val(cpnId);
		$("#frm").submit();
	}

	$("#cpnNm").focus();
}
//대표이사 > 변경 버튼 팝업
function customerPopUp(num,flag,nm,snb,cpnId){
    // popUp 규격
    var w = '650';
    var h = '720';
    var ah = screen.availHeight - 30;
    var aw = screen.availWidth - 10;
    var val = new Object();
    var sUrl = '';

    sUrl = "../person/customerListPopup.do";
    //sUrl+='?f='+flag+'&n='+num+'&snb='+snb+'&nm='+nm;
    sUrl+='?f='+flag+'&n='+num+'&cpnId='+cpnId;
    w='500',h='600';


    h = (ah-40>h?h:ah-40);
    var xc = (aw - w) / 2;
    var yc = (ah - h) / 2;
    var option = "left=" + xc
                +",top=" + yc
                +",width=" + w
                +",height=" + h
                +",menubar=no"
                +",status=no"
                +",toolbar=no"
                +",location=no"
                +",scrollbars=yes"
                +",resizable=no"
                ;
    window.open(sUrl, "_blank", option);

    return;
}
//대표이사 > 변경 버튼 팝업 콜백
function cstPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position){

	$("#ceoName").html(cstNm);
	$("#ceoName").find("font").attr("color","");
	$("#ceoId").val(sNb);
}
//상장/비상장 라디오박스
function chkListed(){
	var chkVal = $("input[name = 'listed']:checked").val();

	if(chkVal == "Y"){
		$("#aCpnId").show();

		$("#cpnIdStr").hide();		//비상장 회사코드 자동생성 도움말

	}else{
		$("#aCpnId").hide();
		$("#aCpnId").val("");

		$("#cpnIdStr").show();		//비상장 회사코드 자동생성 도움말
	}
}

//메인화면 재로딩
function reloadMainPage(){
    opener.parent.openPage();
    window.close();
}

//국내외 구분
function chkDomestic(){
	var domesticYn = $("input[name = 'domesticYn']:checked").val();

	if(domesticYn == "Y"){
		$(".domestic").show();
		$(".overseas").hide();
	}else{
		$(".domestic").hide();
		$(".overseas").show();
	}
}
</script>
</head>
<body>
	<form id = "frm" name = "frm" method="post">
		<input type="hidden" id="cpnId" name="cpnId" value="${companyDetail.cpnId }">
		<input type="hidden" id="aCpnId" name="aCpnId" value="${companyDetail.aCpnId }">
		<input type="hidden" id="type" name="type" value="company">
		<input type="hidden" id="comCd" name="comCd" value="${companyDetail.comCd }">
		<input type="hidden" id="listedYn" name="listedYn">	<!-- 상장사 여부 -->
		<input type="hidden" id="sNb" name="sNb" value="${companyDetail.sNb }">

		<input type="hidden" name="openPage"  id="openPage" value="${openPage}"/>
		<input type="hidden" name="workCpnNm"  id="workCpnNm" value="${workCpnNm}"/>


	<div id="compnay_dinfo">
		<!--회사상세보기(회사정보)-->
		<div class="modalWrap2">
			<h1><strong>회사등록</strong></h1>
			<div class="mo_container">
				<!--회사등록-->
				<div class="RegistCompanyBox">
					<h2 class="title_arrow">
						<span>회사등록</span>
					</h2>
					<table class="net_table_apply mgt10" summary="회사정보입력(구분,이름,소속회사,부서,직위,연락처,이메일,친밀도,이력 등)">
						<caption>
							회사정보입력
						</caption>
						<colgroup>
							<col width="12%" />
							<col width="*" />
							<col width="12%" />
							<col width="35%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="IDName01">회사명</label></th>
								<td colspan="3">
									<input class="applyinput_B w_st01" id="cpnNm" name = "cpnNm" value="${companyDetail.cpnNm }" style="display: ${empty companyDetail.cpnId?'none':'block' };float: left;"/>
									<a href="javascript:searchCpnPop()" class="s_violet01_btn mgl6" style="float: left;"><em class="search">회사중복체크</em></a>
									<span class="mgl6" style="display: ${empty companyDetail.cpnId?'block':'none' };float: left;">※회사등록을 위해 회사중복체크를 진행해주세요.</span>
								</td>
							</tr>
							<tr>
								<th scope="row">국내외 구분</th>
								<td>
									<ul class="itemList">
										<c:choose>
										<c:when test="${companyDetail eq null}">
										<li>
											<label>
												<input type="radio" name="domesticYn" id="domesticYn" value="Y" onclick="chkDomestic()" <c:if test = "${companyDetail.domesticYn eq null or companyDetail.domesticYn eq 'Y'}">checked="checked"</c:if>/>
												<span>국내</span>
											</label>
										</li>
										<li>
											<label>
												<input type="radio" name="domesticYn" id="domesticYn" value="N" onclick="chkDomestic()" <c:if test = "${companyDetail.domesticYn eq 'N'}">checked="checked"</c:if>/>
												<span>해외</span>
											</label>
										</li>
										</c:when>
										<c:otherwise>
											<li>
											<c:if test = "${companyDetail.domesticYn eq null or companyDetail.domesticYn eq 'Y'}"><span>국내</span></c:if>
											<c:if test = "${companyDetail.domesticYn eq 'N'}"><span>해외</span></c:if>
											<input type="radio" name="domesticYn" id="domesticYn" value="${companyDetail.domesticYn}" checked="checked" style="display: none;"/>
											</li>
										</c:otherwise>
										</c:choose>
									</ul>
								</td>
								<th scope="row">상장여부</th>
								<td>
									<c:choose>
										<c:when test = "${companyDetail.comCd ne null }">
											상장(${companyDetail.cpnId })
										</c:when>
										<c:otherwise>
											<ul class="itemList">
												<li>
													<label>
														<input type="radio" name="listed" value="Y" onclick="chkListed()" <c:if test = "${companyDetail.aCpnId ne null}">checked="checked"</c:if>/><span>상장</span>
														<%-- <input type="text" class="input_phone" id = "aCpnId" name = "aCpnId" value="${companyDetail.aCpnId}"/> --%>
														<span id="aCpnId" name="aCpnId" style="<c:if test = "${companyDetail.aCpnId eq null}">display:none;</c:if>">
															<c:choose>
															<c:when test="${companyDetail.aCpnId ne null}">${companyDetail.aCpnId}</c:when>
															<c:otherwise>${maxASeq}</c:otherwise>
															</c:choose>
															<font color="gray">(임의 상장코드)</font>
														</span>
													</label>
												</li>
												<li>
													<label>
														<input type="radio" name="listed" value="N"  onclick="chkListed()" <c:if test = "${companyDetail.aCpnId eq null}">checked="checked"</c:if>/><span>비상장
															<c:choose>
																<c:when test="${companyDetail eq null }">
																	<!-- <span class="input_ex">(CPN ID 자동생성)</span> -->
																	<span class="spe_color_st4 mgl6" id="cpnIdStr">(* 회사코드가 자동생성됩니다.)</span>
																</c:when>
																<c:otherwise>
																	<span class="input_ex">(${companyDetail.cpnId })</span>
																</c:otherwise>
															</c:choose>
														</span>
													</label>
												</li>
											</ul>
										</c:otherwise>
									</c:choose>
									<script type="text/javascript">
									chkListed();
									</script>
									</td>
							</tr>
							<tr class="div_line">
								<th scope="row"><label for="IDName03">대표이사</label></th>
								<td>
									<c:choose>
										<c:when test="${companyDetail eq null}">
										<%-- <div style="float: left;">
											<div id = "ceoName" style="float: left;"></div>
											<a href="javascript:customerPopUp('_0','C','${companyDetail.cstNm}','${companyDetail.ceoId}');" style="float: left;" class="s_3d_gray01_btn mgl6">추가</a>
											<input type="hidden" id = "ceoId" name = "ceoId" value="${companyDetail.ceoId }">
										</div> --%>
										<!-- <span class="input_ex">대표이사 등록절차 : ①회사등록 ②소속직원 등록 ③대표이사등록</span> -->
										<p class="fontB">등록순서: 회사등록 &rarr; 소속직원 등록 &rarr; 대표이사등록</p>
										</c:when>
										<c:when test = "${companyDetail.comCd ne null }">
											${companyDetail.ceo }
										</c:when>
										<c:otherwise>
											<span id = "ceoName" class="mgr6">${companyDetail.cstNm }</span>
											<a href="javascript:customerPopUp('_0','C','${companyDetail.cstNm}','${companyDetail.ceoId}','${companyDetail.cpnId}');" class="s_3d_gray01_btn">변경</a>
											<input type="hidden" id = "ceoId" name = "ceoId" value="${companyDetail.ceoId }">
										</c:otherwise>
									</c:choose>
									<div>
								</td>
								<th scope="row"><label for="IDName04">최대주주</label></th>
								<td>
									${companyDetail.maxHolder}
								</td>
							</tr>
							<tr>
								<th rowspan="3" scope="row"><label for="IDName05">주소</label></th>
								<td>
									<c:choose>
										<c:when test="${companyDetail.domesticYn eq 'Y' }">
											<c:set var = "domesticZip" value="${companyDetail.zip}"></c:set>
										</c:when>
										<c:when test="${companyDetail.domesticYn eq 'N' }">
											<c:set var = "overseasZip" value="${companyDetail.zip}"></c:set>
										</c:when>
									</c:choose>
									<c:choose>
										<c:when test="${companyDetail.comCd eq null or companyDetail.comCd eq ''}">
											<input type="text" class="input_phone domestic" id = "zip" name = "zip" value="${domesticZip}" title="우편번호" readonly="readonly" />
											<a href="javascript:fn_postCall()" class="s_violet01_btn mgl6 domestic" id="IDName05"><em class="search">우편번호</em></a>

											<span class="overseas" style="display:inline-block; width:90px;">우편번호 :</span>
											<input type="text" class="input_phone overseas"style="width: 250px;" id = "overseasZip" name = "overseasZip" value="${overseasZip}" title="우편번호" maxlength="7"/>
										</c:when>
										<c:otherwise>

										</c:otherwise>
									</c:choose>

								</td>
								<th><label for="IDName20">결산월</label></th>
								<td><c:if test="${not empty companyDetail.accountMonth}">${companyDetail.accountMonth} 월</c:if></td>
							</tr>
							<tr>
								<td class="noline nopadding">

									<c:choose>
										<c:when test="${companyDetail.domesticYn eq 'Y' }">
											<c:set var = "domesticAddr" value="${companyDetail.addr}"></c:set>
										</c:when>
										<c:when test="${companyDetail.domesticYn eq 'N' }">
											<c:set var = "overseasAddr" value="${companyDetail.addr}"></c:set>
										</c:when>
									</c:choose>

									<c:choose>
										<c:when test="${companyDetail eq null or companyDetail.comCd eq null or companyDetail.comCd eq ''}">
											<input type="text" id = "addr" name = "addr" class="applyinput_B w100pro domestic" title="회사상세주소" value="${domesticAddr}"  disabled="disabled">

											<span class="overseas" style="display:inline-block; width:90px;">상세3 :</span>
											<input type="text" id = "overseasAddr" name = "overseasAddr" class="applyinput_B overseas"style="width: 250px;" title="회사상세주소" value="${overseasAddr}">
										</c:when>
										<c:otherwise>
											${companyDetail.addr }
										</c:otherwise>
									</c:choose>
								</td>
								<th scope="row"><label for="IDName07">주가</label></th>
								<td><c:if test="${not empty companyDetail.unitPrice}"><span>${companyDetail.unitPrice} 원</span></c:if></td>
							</tr>
							<tr>
								<td class="noline nopadding">

									<c:choose>
										<c:when test="${companyDetail.domesticYn eq 'Y' }">
											<c:set var = "domesticAddrDetail" value="${companyDetail.addrDetail}"></c:set>
										</c:when>
										<c:when test="${companyDetail.domesticYn eq 'N' }">
											<c:set var = "overseasAddrDetail" value="${companyDetail.addrDetail}"></c:set>
										</c:when>
									</c:choose>

									<c:choose>
										<c:when test="${companyDetail eq null or companyDetail.comCd eq null or companyDetail.comCd eq ''}">
											<input type="text" id = "addrDetail" name = "addrDetail" class="applyinput_B w100pro domestic" title="회사상세주소" value="${domesticAddrDetail}">

											<span class="overseas" style="display:inline-block; width:90px;">상세2(도시) :</span>
											<input type="text" id = "overseasAddrDetail" name = "overseasAddrDetail" class="applyinput_B overseas" style="width: 250px;" title="회사상세주소" value="${overseasAddrDetail}">
											<div class="overseas" style="padding-top: 5px;"></div>

											<span class="overseas" style="display:inline-block; width:90px;">상세1(주,국가) :</span>
											<input type="text" id = "addrDetail2" name = "addrDetail2" class="applyinput_B overseas" style="width: 250px;" title="회사상세주소" value="${companyDetail.addrDetail2}">
										</c:when>
										<c:otherwise>

										</c:otherwise>
									</c:choose>
								</td>
								<th scope="row"><label for="IDName08">시가총액</label></th>
								<td><c:if test="${not empty companyDetail.stockValue}"><span>${companyDetail.stockValue} 억원</span></c:if></td>
							</tr>
							<tr>
								<th scope="row"><label for="IDName09">홈페이지주소</label></th>
								<td><input type="text" class="applyinput_B w100pro" id="homepage" name = "homepage" value="${companyDetail.homepage}" /></td>
								<th><label for="IDName16">액면가</label></th>
								<td><c:if test="${not empty companyDetail.faceValue}"><span>${companyDetail.faceValue} 원</span></c:if></td>
							</tr>
							<tr>
								<th scope="row"><label for="IDName11">본사전화</label></th>
								<td>
									<c:choose>
										<c:when test="${companyDetail.comCd ne null }">
											${companyDetail.tel }
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${companyDetail.domesticYn eq 'Y' }">
													<c:set var = "phonArr" value="${fn:split(companyDetail.phone,'-') }"></c:set>
												</c:when>
												<c:when test="${companyDetail.domesticYn eq 'N' }">
													<c:set var = "overseasPhonArr" value="${fn:split(companyDetail.phone,'-') }"></c:set>
												</c:when>
											</c:choose>


											<select class="sel_phone domestic" id="phone1">
												<option value="">선택</option>
												<option value="02"  <c:if test = "${phonArr[0] eq '02'  }">selected="selected"</c:if>>02</option>
												<option value="031" <c:if test = "${phonArr[0] eq '031' }">selected="selected"</c:if>>031</option>
												<option value="032" <c:if test = "${phonArr[0] eq '032' }">selected="selected"</c:if>>032</option>
												<option value="033" <c:if test = "${phonArr[0] eq '033' }">selected="selected"</c:if>>033</option>
												<option value="041" <c:if test = "${phonArr[0] eq '041' }">selected="selected"</c:if>>041</option>
												<option value="042" <c:if test = "${phonArr[0] eq '042' }">selected="selected"</c:if>>042</option>
												<option value="043" <c:if test = "${phonArr[0] eq '043' }">selected="selected"</c:if>>043</option>
												<option value="044" <c:if test = "${phonArr[0] eq '044' }">selected="selected"</c:if>>044</option>
												<option value="049" <c:if test = "${phonArr[0] eq '049' }">selected="selected"</c:if>>049</option>
												<option value="051" <c:if test = "${phonArr[0] eq '051' }">selected="selected"</c:if>>051</option>
												<option value="052" <c:if test = "${phonArr[0] eq '052' }">selected="selected"</c:if>>052</option>
												<option value="053" <c:if test = "${phonArr[0] eq '053' }">selected="selected"</c:if>>053</option>
												<option value="054" <c:if test = "${phonArr[0] eq '054' }">selected="selected"</c:if>>054</option>
												<option value="055" <c:if test = "${phonArr[0] eq '055' }">selected="selected"</c:if>>055</option>
												<option value="061" <c:if test = "${phonArr[0] eq '061' }">selected="selected"</c:if>>061</option>
												<option value="062" <c:if test = "${phonArr[0] eq '062' }">selected="selected"</c:if>>062</option>
												<option value="063" <c:if test = "${phonArr[0] eq '063' }">selected="selected"</c:if>>063</option>
												<option value="064" <c:if test = "${phonArr[0] eq '064' }">selected="selected"</c:if>>064</option>
												<option value="070" <c:if test = "${phonArr[0] eq '070' }">selected="selected"</c:if>>070</option>
											</select>
											<span class="dashLine domestic">-</span> <input type="text" class="input_phone digit domestic" value="${phonArr[1] }" id = "phone2" title="본사전화 중간번호" maxlength="4">
											<span class="dashLine domestic">-</span> <input type="text" class="input_phone digit domestic" value="${phonArr[2] }" id = "phone3" title="본사전화 마지막번호" maxlength="4">

											<select class="sel_ability overseas" id="overseasPhone1" style="margin-left: 0px;width: 95px;">
												<option value="">국가번호선택</option>

												<c:forEach items="${contryCodeList }" var = "data">
													<option value="${data.codeValue }"  <c:if test = "${overseasPhonArr[0] eq data.codeValue  }">selected="selected"</c:if>>${data.codeNm }</option>
												</c:forEach>

											</select>
											<span class="dashLine overseas">-</span> <input type="text" class="input_phone digit overseas" value="${overseasPhonArr[1] }" id = "overseasPhone2" title="본사전화 중간번호" maxlength="7">
											<span class="dashLine overseas">-</span> <input type="text" class="input_phone digit overseas" value="${overseasPhonArr[2] }" id = "overseasPhone3" title="본사전화 마지막번호" maxlength="7">
											<span class="dashLine overseas">-</span> <input type="text" class="input_phone digit overseas" value="${overseasPhonArr[3] }" id = "overseasPhone4" title="본사전화 마지막번호" maxlength="7">



											<input type="hidden" id="phone" name = "phone" value="${companyDetail.phone }"/>



											<!-- <select class="sel_phone" id="phone1">
												<option value="">선택</option>
												<option value="010">010</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
											</select>
											<span class="dashLine">-</span> <input type="text" id = "phone2" class="input_phone" title="본사전화 중간번호" maxlength="4">
											<span class="dashLine">-</span> <input type="text" id = "phone3" class="input_phone" title="본사전화 마지막번호" maxlength="4">
											<input type="hidden" id = "phone" name = "phone"> -->
										</c:otherwise>
									</c:choose>
								</td>
								<th scope="row"><label for="IDName12">자기주식수</label></th>
								<td>${companyDetail.ownStock}</td>
							</tr>
							<tr>
								<th scope="row"><label for="IDName21">업종</label></th>
								<td>
									<c:choose>
										<c:when test="${companyDetail.comCd ne null }">
											${companyDetail.categoryBusiness}
										</c:when>
										<c:otherwise>
											<input type="text" class="applyinput_B w100pro" id="categoryBusiness" name = "categoryBusiness" value="${companyDetail.categoryBusiness}" />
										</c:otherwise>
									</c:choose>

								</td>
								<th scope="row"><label for="IDName14">자사보유지분</label></th>
								<td><c:if test="${not empty companyDetail.maxStockRate}">${companyDetail.maxStockRate} %</c:if></td>
							</tr>
							<tr>
								<th scope="row"><label for="IDName22">주요품목</label></th>
								<td>
									<c:choose>
										<c:when test="${companyDetail.comCd ne null }">
											${companyDetail.majorProduct}
										</c:when>
										<c:otherwise>
											<input type="text" class="applyinput_B w100pro" id="majorProduct" name = "majorProduct" value="${companyDetail.majorProduct}" />
										</c:otherwise>
									</c:choose>
								</td>
								<th><label for="IDName18">금액</label></th>
								<td><c:if test="${not empty companyDetail.money}"><span>${companyDetail.money} 억원</span></c:if></td>

							</tr>
							<tr>
								<th scope="row"><label for="IDName15">설립일</label></th>
								<td>
									<input class="applyinput_B w_st16" id="foundDate2" name="foundDate2" value="${companyDetail.foundDate2}" readonly />${companyDetail.foundDate}
								</td>
								<th scope="row">상장일</th>
								<td>${companyDetail.publicDate}</td>
							</tr>

							<tr class="div_line">
								<th scope="row"><label for="IDName13">주식담당전화</label></th>
								<td colspan="3">
									<!-- <select class="sel_phone" id="IDName13">
										<option>010</option>
										<option>016</option>
										<option>017</option>
										<option>018</option>
										<option>선택</option>
									</select>
									<span class="dashLine">-</span> <input type="text" class="input_phone" title="핸드폰 중간번호">
									<span class="dashLine">-</span> <input type="text" class="input_phone" title="핸드폰 마지막번호"> -->
									${companyDetail.irTel }
								</td>
							</tr>
						</tbody>
					</table>
					<%--<p class="table_notice"><span class="point">* 필수입력입니다.</span> 그외의 상세내역들도 입력해주시면 인물정보의 활용도가 높아집니다.  </p>--%>
					<div class="btnZoneBox">
						<span class="btn_auth"><a href="javascript:doSave()" class="p_blueblack_btn"><strong>저장</strong></a></span>
						<!-- <a href="javascript:doDelete()" class="p_withelin_btn">삭제</a> -->
						<a href="javascript:reloadMainPage();" class="p_withelin_btn">닫기</a>
					</div>

				<!--//회사등록//-->
			</div>
			</form>
		</div>
		<!--//회사상세보기(회사정보)//-->
	</div>
</body>
</html>
