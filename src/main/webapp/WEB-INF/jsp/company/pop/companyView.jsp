<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
function showlayer(id){
	if(id.style.display == 'none')
    {id.style.display='block';}
    else{id.style.display = 'none';}
}
function screenResizeFull(){
	 self.moveTo(0,0); //창위치
	 self.resizeTo(screen.availWidth, screen.availHeight); //창크기
}
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
function goModifyPage(){
	//var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";
	//$("#frm").attr("action", contextRoot+"/company/rgstCpn.do");
	//var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";
	//window.open(contextRoot+"/company/rgstCpn.do?cpnId="+$("#cpnId").val(),"companyProcessPop",option);
	//commonPopupOpen("companyProcessPop","",option,$("#frm"));
	//$("#frm").submit();

	window.location.href = contextRoot+"/company/rgstCpn.do?cpnId="+$("#cpnId").val();
}
function slctCpn(cpnId){
	window.opener.linkPage($("#pageIndex",opener.document).val());
	window.close();

}
//관련인물페이지로이동
function goPersonNetPage(){
	$("#frm").attr("action", contextRoot+"/company/personNet.do");
	$("#frm").attr("method","post");
	$("#frm").submit();
}

//메인화면 재로딩
function reloadMainPage(){
    opener.parent.openPage();
    window.close();
}

//회사 삭제
function deleteCompany(){
	if(confirm("삭제하시겠습니까?")){
		var url =  contextRoot+"/company/deleteCompany.do"
		var param = {
			sNb		: "${companyDetail.sNb}",
			aCpnId  : "${companyDetail.aCpnId}"
		};
		var callback = function(data){
			var result = JSON.parse(data);
			//성공이면 성공메세지를 , 실패면 서버단에서 보내온 실패 메세지를 보여준다.
			if(result.resultObject.result=="SUCCESS"){
				alert("삭제되었습니다.");
				reloadMainPage();
			}else{
				alert("이미 등록된 정보가있어 삭제할수 없습니다.");
				return;
			}
		};
		commonAjax("POST", url, param, callback, false);
	}
}
</script>

	<div id="compnay_dinfo">
		<!--회사상세보기(회사정보)-->
		<div class="modalWrap2">
			<h1><strong>[${companyDetail.cpnNm }] 회사정보</strong></h1>
			<!--tab-->
			<div class="gtabZone">
				<ul>
					<li class="on"><a href="#">회사정보</a></li>
					<c:if test="${baseUserLoginInfo.customerInfoLevel eq 'G' || baseUserLoginInfo.customerInfoLevel eq 'E'}">
                        <li><a href="javascript:goPersonNetPage()">관련인물</a></li>
                    <!-- <li><a href="javascript:alert('준비중입니다.')">분석자료</a></li> -->
                    </c:if>

				</ul>
			</div>
			<!--//tab//-->
			<div class="mo_container">
				<!--회사소개-->
				<div class="comLogoExplain">
					<div class="comLogo"><a href="#" target="_blank"><img src="../images/network/no_images.gif" alt="${companyDetail.cpnNm } 로고"></a></div>
					<div class="comExplain">
						<h3 class="com_title">
							<span class="comName">${companyDetail.cpnNm }
							<c:choose>
								<c:when test = "${companyDetail.aCpnId ne null }">
									<em class="comNumber">(${companyDetail.aCpnId })</em>
									<em class="icon_market">상 장&nbsp;</em>
								</c:when>
								<c:otherwise>
									<em class="comNumber">(${companyDetail.cpnId })</em>
								</c:otherwise>
							</c:choose>
							<c:if test="${companyDetail.domesticYn eq 'N'}">해외</c:if>
							</span>
							<c:if test = "${companyDetail.comCd ne null }">
								<c:if test="${not empty companyDetail.unitPrice}">
									<fmt:parseNumber var = "unitPrice" value="${fn:replace(companyDetail.unitPrice,',','')}" />
									<fmt:parseNumber var = "beforeUnitPrice" value="${fn:replace(companyDetail.beforeUnitPrice,',','')}" />
									<c:set var = "fluctuations" value="${unitPrice - beforeUnitPrice }" />
									<fmt:formatNumber var = "rate" value="${fluctuations/unitPrice*100 }" pattern="0.00" />
									<fmt:formatNumber var = "fluctuationsStr" value="${fluctuations }" type="number" />
									<c:choose>
										<c:when test="${fluctuations>0 }">
											<span class="rate_up">
										</c:when>
										<c:otherwise>
											<span class="rate_down">
										</c:otherwise>
									</c:choose>
										<span>${companyDetail.unitPrice }</span>
											<em class="txt">전일대비</em>
											<span class="arrow">
												${fluctuationsStr }
												<em>(${rate }%)</em>
											</span>
											</span>

										<%-- <span>${companyDetail.unitPrice}</span>
									<em class="txt">전일대비(작업할것)</em><span class="arrow">80<em>(-3.08%)</em></span></span> --%>
								</c:if>
							</c:if>
							<%--<span class="rate_up">2,515<em class="txt">전일대비</em><span class="arrow">80<em>(+0.08%)</em></span></span>--%>
						</h3>
						<ul class="cominfoList">
							<li>
								<span class="icon_address">
									<c:if test="${companyDetail.domesticYn eq 'Y'}">
										주소 :
										<c:if test = "${companyDetail.zip ne null and companyDetail.zip != '' }">
											(${companyDetail.zip})
										</c:if>
										${companyDetail.addr}
										<c:if test = "${companyDetail.addrDetail ne null and companyDetail.addrDetail ne '' }">
											${companyDetail.addrDetail}
										</c:if>
									</c:if>

									<c:if test="${companyDetail.domesticYn eq 'N'}">
										${companyDetail.addr}
										<c:if test="${not empty companyDetail.addr and not empty companyDetail.addrDetail}">,${companyDetail.addrDetail }</c:if>
										<c:if test="${(not empty companyDetail.addr or not empty companyDetail.addrDetail) and not empty companyDetail.addrDetail2}">,${companyDetail.addrDetail2 }</c:if>
									</c:if>
								</span>
								<c:if test="${companyDetail.domesticYn eq 'N'}">
									<span class="mgl25">우편번호 : ${companyDetail.zip }</span>
								</c:if>
							</li>

							<li>
								<span  class="icon_tell">연락처 : <c:if test="${companyDetail.domesticYn eq 'N' and fn:length(fn:split(companyDetail.phone,'-'))>0 }">+</c:if>${companyDetail.phone}
									<%-- <c:if test = "${companyDetail.irTel ne null and companyDetail.irTel ne '' }">
										(주식담당 : ${companyDetail.irTel})
									</c:if> --%>
								</span>
								<span class="icon_homepage mgl25">
								홈페이지 : ${companyDetail.homepage }
								</span>
							</li>
						</ul>
					</div>
				</div>
				<table class="net_table_apply" summary="회사소개(회사명, 설립일, 직원수, 업종, 주요품목, 대표이사, 계열, 최대주주, 최대주주 지분, 결산월, 시가총액, 상장주식수, 자기주식수, 자사보유지분, 액면가, 자산총액)">
					<caption>회사소개</caption>
					<colgroup>
							<col width="10%" />
							<col width="*" />
							<col width="12%" />
							<col width="18%" />
							<col width="12%" />
							<col width="17%" />
						</colgroup>
					<tr>
						<th scope="row">회사명</th>
						<td>${companyDetail.cpnNm }
							<!-- 수정내역 숨김 -->
							<!-- <span class="tooltip">
								<div id="comnameHistory" class="tooltip_box" style="display:none;">
									<h3 class="title"><strong>회사명변경이력 (추후 작업예정)</strong></h3>
									<span class="intext">
										<ul class="list_st_dot2">
											<li>우리이티아이(주)</li>
											<li>우리이티아이(주)</li>
										</ul>
									</span>
									<em class="edge_topcenter"></em>
									<a href="javascript:showlayer(comnameHistory)" class="closebtn_s"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기" /></a>
								</div>
								<a href="javascript:showlayer(comnameHistory)"><img src="../images/common/icon_question.png" alt="?"></a>
							</span> -->
						</td>
						<th scope="row">대표이사</th>
						<td>
							<c:choose>
								<c:when test="${companyDetail.comCd ne null }">
									${companyDetail.ceo}
								</c:when>
								<c:otherwise>
									${companyDetail.cstNm }
								</c:otherwise>
							</c:choose>

							<!-- db 저장 데이터 자체를 보여줌  -->
							<!-- <span class="tooltip">
								<div id="ceonameHistory" class="tooltip_box"  style="display:none;">
									<span class="intext">
										<ul class="list_st_dot2">
											<li>윤철주, 성보경</li>
											<li>윤철주</li>
										</ul>
									</span>
									<em class="edge_topcenter"></em>
									<a href="javascript:showlayer(ceonameHistory)" class="closebtn_s"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기" /></a>
								</div>
								<a href="javascript:showlayer(ceonameHistory)"><img src="../images/common/icon_question.png" alt="?"></a>
							</span> -->
						</td>
						<th scope="row">시가총액</th>
						<td class="moneyst"><c:if test="${not empty companyDetail.stockValue}"><span>${companyDetail.stockValue} 억원</span></c:if></td>
					</tr>
					<tr>
						<th scope="row">설립일</th>
						<td class="numst">
						    ${fn:replace(companyDetail.foundDate2,'-','/')}
						    <c:if test="${not empty companyDetail.publicDate }">
						        <em class="fontGray f11">(상장일 : ${fn:replace(companyDetail.publicDate,'-','/')}</em>
						    </c:if>
						</td>

						<th scope="row">최대주주</th>
						<td>${companyDetail.maxHolder}</td>
						<th scope="row">자기주식수</th>
						<td class="moneyst">${companyDetail.ownStock}</td>
					</tr>
					<!-- <tr>
						<th scope="row">직원수</th>
						<td class="numst">175 <em class="fontGray f11">(2014/12)</em></td>
						<th scope="row">최대주주</th>
						<td>우리조명(주)외 11</td>
						<th scope="row">자기주식수</th>
						<td class="moneyst">2,452,446</td>
					</tr> -->
					<tr>
						<th scope="row" rowspan="2">업종</th>
						<td rowspan="2">${companyDetail.categoryBusiness}</td>
						<th scope="row">자사보유 지분</th>
						<td class="numst"><c:if test="${not empty companyDetail.maxStockRate}">${companyDetail.maxStockRate} %</c:if></td>
						<!-- <th scope="row">최대주주 지분</th>
						<td class="moneyst">5.92%</td> -->
						<th scope="row">금액</th>
						<td class="moneyst"><c:if test="${not empty companyDetail.money}"><span>${companyDetail.money} 억원</span></c:if></td>
					</tr>
					<tr>
						<th scope="row">결산월</th>
						<td class="numst"><c:if test="${not empty companyDetail.accountMonth}">${companyDetail.accountMonth} 월</c:if></td>
						<th scope="row">액면가</th>
						<td class="moneyst"><c:if test="${not empty companyDetail.faceValue}"><span>${companyDetail.faceValue} 원</span></c:if></td>
					</tr>
					<tr>
						<th scope="row">주요품목</th>
						<td colspan="5">${companyDetail.majorProduct}</td>

					</tr>
				</table>
				<!--//회사소개//-->
				<div class="btnZoneBox">
				    <span class="btn_auth"><a href="javascript:goModifyPage()" class="p_blueblack_btn"><strong>수정</strong></a></span>
				    <a href="javascript:reloadMainPage();" class="p_withelin_btn">닫기</a>
				    <c:if test="${empty companyDetail.refOrgId and baseUserLoginInfo.vipAuthYn eq 'Y' }">
				    	<span class="btn_auth mgl6"><a href="javascript:deleteCompany()" class="p_blueblack_btn"><strong>삭제</strong></a></span>
				    </c:if>
				</div>
			</div>
		</div>
		<!--//회사상세보기(회사정보)//-->
	</div>
	<form id = "frm" name = "frm">
		<input type="hidden" name = "cpnId" id = "cpnId" value="${companyDetail.cpnId }">
		<input type="hidden" name = "orgId" id = "orgId" value="${companyDetail.orgId }">
		<input type="hidden" name = "cpnNm" id = "cpnNm" value="${companyDetail.cpnNm }">
	</form>
