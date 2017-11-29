<%@ page language="java" contentType="text/html;" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>주가정보일괄등록 | 회사 | 네트워크 | PASS (Project based Activity analysis and Sharing system)</title>
<meta name="copyright" content="COPYRIGHT@ Synergy Group" />
<script>var contextRoot="${pageContext.request.contextPath}";</script><!-- necessary! to import js files -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/base.js"></script>


<script>

	$(document).ready(
		function (){
			if('<c:out value='${upload}'/>' > '0' ) {
				//window.returnValue=rVal;
				alert("SUCCESS!");
				window.close();
			}

			if('<c:out value='${upload}'/>' == '0' ) {
				alert("FAIL!!\n\n${failMsg}");
				window.close();
			}
		}
	);
	/* ${message} */



	//일괄 업로드
	function doUpload() {
		if($('#fileUrl').val() == '') {
			alert('파일선택을 하시기 바랍니다!');
			return false;
		}

		$('#fileForm').attr('action', "<c:url value='/company/uploadStockProcess.do'/>").submit();
	}

	//도움말팝업토글
	function showlayer(id)
	{
		$("#"+id).toggle();
	}

	//csv양식다운로드
	function downTmpl(){
		var downPop = window.open('<c:url value="/data/csvTmpl/stockInfo.csv" />');
	}

	//파일찾아보기 버튼클릭
	function openFile(){
	$("#fileUrl").click();
	}

	//파일 경로를 인풋텍스트에 넣는다
	function fileSelect(){
		var fullFileNm = $("#fileUrl").val();
		var fileNm = fullFileNm.substring(fullFileNm.lastIndexOf("\\")+1);
		$("#fileNm").val(fileNm);
	}
</script>
</head>
<body>
<form id="fileForm" name="fileForm" method="post" enctype="multipart/form-data">
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<div id="compnay_dinfo">
		<!--회사상세보기(회사정보)-->
		<div class="modalWrap2">
			<h1><strong>[주가정보 일괄등록]</strong> 주가정보업로드</h1>
			<div class="mo_container">
				<h3 class="h3_title_basic"><span>주가정보 CSV 업로드</span><span class="spe_color_st5 mgl6">(주가정보 일괄등록ㆍ수정가능)</span></h3>
				<div class="cvsuploadWrap">
					<div class="re_CompanyList">
						<ul class="gray_dot_list">
							<li><span>주가정보를 CSV양식에 맞춰 작성 후 업로드 하시면 회사등록 및 수정이 일괄적으로 적용됩니다.</span><button type="button" class="btn_b_skyblue mgl10" onclick="downTmpl()"><em class="icon_down">CSV양식 다운</em></button> <a href="#"></a></li>
							<li><span>파일은 <strong class="fontB">반드시 CSV파일형식</strong>이여야 합니다.</span><button type="button" onClick="javascript:showlayer('cvsGuideBox')" class="btn_b_skyblue mgl10"><em>등록가이드</em></button></li>
						</ul>
						<div id="cvsGuideBox" style="display:none;">
							<img src="../images/network/csv_guide.png" alt="등록가이드" />
							<ul class="hidden">
								<li>등록정보는 법인코드, 법인명, 업종, 상장일자, 주요품목입니다.</li>
								<li>1열 항목명을 제외한 2열 DB에 등록됩니다. *데이터가 없는 열은 반드시 <strong>삭제</strong>해주세요.</li>
							</ul>
						</div>
					</div>
				</div>

				<div id="CompanySerach">
					<table class="tb_ProfileInfo" summary="회사검색">
						<caption>회사검색</caption>
						<colgroup>
							<col width="160" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row" rowspan="2" class="bgGray"><label for="company">주가정보 CSV 파일</label></th>
								<td>
									<input type="text" class="applyinput_B w240px" id="fileNm" readonly="readonly"/>
									<a href="javascript:openFile()" class="mgl8 s_violet01_btn"><em class="search">찾아보기</em></a>
									<input type="file" name="fileUrl" id="fileUrl" style="display: none;" onchange="fileSelect()"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btnZoneBox"><a href="javascript:doUpload()" class="p_blueblack_btn"><strong>업로드</strong></a><a href="javascript:window.close()" class="p_withelin_btn">취소</a></div>
				<!--//검색결과有//-->
			</div>
		</div>
		<!--//회사상세보기(회사정보)//-->
	</div>
</form>
</body>
</html>