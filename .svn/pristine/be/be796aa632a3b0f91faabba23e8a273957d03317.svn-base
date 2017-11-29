<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	//치환 변수 선언
	pageContext.setAttribute("cr", "\r"); //Space
	pageContext.setAttribute("cn", "\n"); //Enter
	pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
	pageContext.setAttribute("br", "<br>"); //br 태그
%>

<style type="text/css">

@page a4sheet {
	size: A4;
}


@media print{

	html,body {
		width : 21.0cm;
		margin : 0;
		padding : 0;
	}

	#printArea{
		page: a4sheet;
		border :2px solid #949494;
		page-break-after: always;
		background-color:transparent;
	}
	.logoArea{
		height:2.0cm;
		background-size : contain;
		background-repeat: no-repeat;
		background-position: right bottom;
		-webkit-print-color-adjust: exact;
	}

}

select, input, option, textarea {
    vertical-align: middle;
    font-family: "돋움";
}

.logoArea{
	height:2.5cm;
	background-repeat: no-repeat;
	background-position: right bottom;
	background-size : contain;
}
</style>



<section id="detail_contents">

	<form name="formCertDocView" id="formCertDocView" action="" method="post">
		<input type="hidden" id="docType" name="docType">
		<input type="hidden" id="userType" name="userType">
		<input type="hidden" id="formDocReqSeq" name="formDocReqSeq" value="${formDocVO.formDocReqSeq}">
		<input type="hidden" id="jumin1" name="jumin1">
		<input type="hidden" id="jumin2" name="jumin2">
	</form>
	<div class="doc_AllWrap">
		<div class="doc_viewWarp" id="printArea">
			<div class="doc_viewWarp2">
				<p class="doc_codenum"></p>
				<h3 class="print_h3title">${formDocVO.formDocNm}</h3>
				<c:if test="${userType eq 'MNG' and formDocVO.reqStatus eq 'End'}">
				<div class="sys_p_noti mgt20 mgb10" style="float: right;"><span class="icon_noti"></span><span class="pointB">최초발급후</span><span>주민번호는 삭제처리되어 **로 표시됩니다.</span></div>
				</c:if>
				<table class="doc_print_tb_st01" summary="재직증명서 (성명, 주민번호, 주소, 소속, 직위, 재직기간, 용도, 발급사유, 비고, 발급회사)">
					<caption>재직증명서 보기</caption>
					<colgroup>
						<col width="120" />
						<col width="*" />
						<col width="120" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">성명</th>
							<td><strong>${formDocVO.targetPerNm}</strong></td>
							<th scope="row">주민등록번호</th>
							<td>
								<span class="txt_num">
								<c:choose>
									<c:when test="${formDocVO.jumin1 eq ''}">
										<c:choose>
											<c:when test="${vo.docType eq 'Print'}">${vo.jumin1}-${vo.jumin2}</c:when>
											<c:otherwise>
											<input type="text" name="jumin1_" id="jumin1_" size="7" maxlength="6" style="border:1px solid #ddd;" onkeyup="fnObj.reOnlyNum(this.name, this.value);if(this.value.length == 6) $('#jumin2').focus();"/>-<input type="text" style="border:1px solid #ddd;" name="jumin2_" id="jumin2_" size="8" maxlength="7" onkeyup="fnObj.reOnlyNum(this.name, this.value);"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<input type="hidden" name="jumin1_" id="jumin1_" value="${formDocVO.jumin1}"/>
										<input type="hidden" name="jumin2_" id="jumin2_" value="${formDocVO.jumin2}"/>
										${formDocVO.jumin1}-${formDocVO.jumin2}
									</c:otherwise>
								</c:choose>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td colspan="3">${formDocVO.perAddr}</td>
						</tr>
						<tr>
							<th scope="row">부서</th>
							<td>${formDocVO.deptNm}</td>
							<th scope="row">직위</th>
							<td>${formDocVO.perPositionNm}</td>
						</tr>
						<tr>
							<th scope="row">재직기간</th>
							<td colspan="3">
								${formDocVO.period}</div>
							</td>
						</tr>
						<tr>
							<th scope="row">용도</th>
							<td colspan="3">${formDocVO.formDocUse}</td>
						</tr>
						<tr>
							<th scope="row">발급사유</th>
							<td colspan="3">${fn:replace(formDocVO.formDocReason, cn, br)}</td>
						</tr>
						<tr>
							<th scope="row">비고</th>
							<td colspan="3"><div class="doc_pointcon">${fn:replace(formDocVO.formDocEtc, cn, br)}</div></td>
						</tr>
					</tbody>
				</table>
				<p class="doc_des_st2">위 사람은 상기와 같이 근무하고 있음을 증명합니다.</p>
				<p class="doc_des_st3">${fn:split(formDocVO.reqDate, '-')[0]}년 ${fn:split(formDocVO.reqDate, '-')[1]}월 ${fn:split(formDocVO.reqDate, '-')[2]}일</p>
				<div class="doc_singnlogo">
					<div class="logoArea">
						<p class="conaddress">${comInfo.addr}</p>
						<p><span class="comname">${comInfo.comNm}</span><span class="ceo">대표이사 ${comInfo.ownNm}</span><span class="sign_here">(인)</span></p>
					</div>
				</div>
			</div>
		</div>
		<div class="btn_baordZone2" ${userType == 'PRN' ? "style='display:none'":""}>
			<c:if test="${userType ne 'MNG' && (baseUserLoginInfo.empNo eq formDocVO.reqPerSabun) && formDocVO.reqStatus eq 'New'}">
				<a href="javascript:fnObj.cancleCert('${formDocVO.formDocReqSeq}');" class="btn_witheline btn_auth" id="cancel">요청취소</a>
			</c:if>
			<c:if test="${userType eq 'MNG' && (formDocVO.reqStatus eq 'New')}">
				<a href="javascript:fnObj.returnCert('${formDocVO.formDocReqSeq}');" class="btn_witheline btn_auth" id="return">반려</a>
			</c:if>
			<c:if test="${userType eq 'MNG' && (formDocVO.reqStatus eq 'New')}">
				<a href="javascript:fnObj.print();" id="print" class="btn_witheline btn_auth">발급</a>
			</c:if>
			<a href="javascript:fnObj.reqEnd();" id="btnPrint" style="display: none;" class="btn_witheline">재직증명서 인쇄</a>
			<a href="javascript:fnObj.goList();" id="list" class="btn_witheline" >목록</a>
		</div>
	</div>

</section>



<script type="text/javascript">

//Global variables :S ---------------
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')
var myModal = new AXModal();

var fnObj = {

	preloadCode : function(){
		top.document.title = "${formDocVO.formDocNm} 상세보기";

		//소속회사 스탬프 노출 처리.
		/* <c:if test="${not empty comInfo.nameStamp}">
			var url = "../images/sp/stamp/${comInfo.nameStamp}";
			$(".logoArea").css("background-image","url('"+url+"')");
		</c:if>
		<c:if test="${not empty comInfo.orgLogo}">
			var url = "data:image/png;base64,${comInfo.orgLogo}";
			$(".logoArea").css("background-image","url('"+url+"')");
		</c:if> */
		if('${vo.docType}' == 'Print'){
			fnObj.reqEnd();
		}


	},

	// 출력 버튼 클릭 시 인쇄를 위해 뜬 팝업창이 열림과 동시에 인쇄 기능 동작.
	reqEnd : function(){
		window.print();
	},

	// 출력버튼 클릭 시 ( Print )
	print : function(type){
			if(confirm('선택하신 증명서를 발급하시겠습니까?\n(증명서 발급시 발급자는 곧 처리자가 됩니다.)')) {
				if($('#jumin1_').val().length < 6 || $('#jumin2_').val().length < 7) {
					alert('주민등록번호를 입력하셔야 합니다.');
					if($('#jumin1_').val().length < 6) $('#jumin1_').focus();
					else $('#jumin2_').focus();
					return false;
				}

				$("#jumin1").val($("#jumin1_").val());
				$("#jumin2").val($("#jumin2_").val());
				$('#docType').val("Print");
				$('#userType').val("MNG");

				var w = window.open('', 'FormDocViewPrint', 'width=850, height=800, scrollbars=yes');
				$('#formCertDocView').attr('target', 'FormDocViewPrint').attr('action', "<c:url value='/system/certDocView.do'/>").submit();

				$("#print").css("display","none");
				$("#return").css("display","none");
				$("#cancel").css("display","none");
				$('#docType').val("");
				$("#btnPrint").show();
			}
			else {
				alert('증명서 발급 취소 되었습니다.');
				return;
			}
	},

	//요청 취소
	cancleCert : function(formDocReqSeq) {
		if (confirm('선택하신 요청을 정말로 취소하시겠습니까?')) {

	    	var callback = function(result){
	    		var obj = JSON.parse(result);
	    		//console.log(obj);
	    		if(obj.result == "SUCCESS"){
	    			alert("증명서 발급 요청이 취소되었습니다.");
	    			location.href=contextRoot + "${returnListUrl}";
	    		}else{
	    			alert("오류가 발생하였습니다.");
	    			return;
	    		}
	    	};

	    	var param = {
	    		formDocReqSeq : formDocReqSeq
	    	};

	    	commonAjax("POST", "../system/cancelCertDoc.do", param, callback);
		}else
			return;

	},


	//반려
	returnCert : function(formDocReqSeq) {
		if (confirm('선택하신 요청을 반려하시겠습니까?')) {

	    	var callback = function(result){
	    		var obj = JSON.parse(result);
	    		//console.log(obj);
	    		if(obj.result == "SUCCESS"){
	    			alert("증명서가 반려되었습니다.");
	    			location.href=contextRoot + "${returnListUrl}";
	    		}else{
	    			alert("오류가 발생하였습니다.");
	    			return;
	    		}
	    	};

	    	var param = {
	    		formDocReqSeq : formDocReqSeq
	    	};

	    	commonAjax("POST", "../system/returnCertDoc.do", param, callback);
		}
	},


	//목록 이동
	goList : function() {
		location.href = contextRoot + "${returnListUrl}";
	},

	reOnlyNum : function(Obj, Value) {
		re = /[^0-9\.\,\-]/gi;
		$('#'+Obj).val(Value.replace(re,""));
	}

}


$(function() {
	fnObj.preloadCode(); //공통코드 or 각종선로딩코드
	<c:if test="${userType eq 'MNG' and formDocVO.reqStatus eq 'End'}">
	$("#btnPrint").show();
	</c:if>
});
</script>