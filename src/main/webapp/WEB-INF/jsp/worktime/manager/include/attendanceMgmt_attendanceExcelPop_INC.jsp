<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<style type="text/css">
.s_violet01_btn .file_btn_cover { position:absolute; width:67px; height:25px;opacity:0; z-index:1;cursor:pointer; display:inline-block; }

.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
    z-index: 1000000;
}
.wrap-loading div{ /*로딩 이미지*/
    position: fixed;
    top:50%;
    left:50%;
    margin-left: -21px;
    margin-top: -21px;
    z-index: 1000000;
}
.display-none{ /*감추기*/
    display:none;
}

</style>
<script type="text/javascript">

	var worktimeExcelFileId = 0;

	//파일선택
	function selectFile(){
		var fileValue = $("#upFile").val().split("\\");
		var fileName = fileValue[fileValue.length-1]; // 파일명

		$("#fileName").val(fileName);
	}

	//업로드
	function excelUpload(){

		if($("#upFile").val() == ""){
			alert("파일을 선택해 주세요.");
			return;
		}

		var re = /^.+\.((xlsx)|(xls))$/i;
        if (!re.test($("#upFile").val())) {
        	alert("엑셀 파일만 첨부 가능합니다.");  //이미지 파일만 첨부 가능합니다.
            return;
        }
		var url = contextRoot+"/worktime/uploadWorktimeExcel.do"
   		var callback = function(result){
			var g_idx = 0;
			//에러건수
			var errorCnt = 0;
			//정상건수
			var normalCnt = 0;

   			var uploadList = result.resultObject.resultMapList;
			//전체건수
   			var totCnt = uploadList.length;

			//요청건수
			var reqCnt = result.resultObject.attendReqCnt;

			if(totCnt>0){
				if(result.resultObject.errorYn == "N"){
					worktimeExcelFileId = result.resultObject.worktimeExcelFileId;
					$("#btnSave").show();
					$("#btnUpload").hide();
				}
			}

   			var stStr = "";
   			for(var i = 0 ; i < uploadList.length ; i++){

   				var uploadInfo = uploadList[i];
   				g_idx++;
   				var errorYn = "N";

   				if(uploadInfo.errorYn != "N"){
   					errorYn = uploadInfo.errorYn;
   					errorCnt ++;
   				}

   				var warningYn = uploadInfo.warningYn;

   				if(errorYn == "N" && warningYn =="N") normalCnt++;

   				var trCassName="";
   				if(errorYn == "Y") trCassName = "ck_error";
   				else if(warningYn == "Y") trCassName = "ck_ing";

   				var name = uploadInfo.name == undefined?"":uploadInfo.name;
   				var deptName = uploadInfo.deptName == undefined?"":uploadInfo.deptName;
   				var inTimeBase = uploadInfo.inTimeBase == undefined?"":uploadInfo.inTimeBase;
   				var outTimeBase = uploadInfo.outTimeBase == undefined?"":uploadInfo.outTimeBase;
   				var inTimeDate = uploadInfo.inTimeDate == undefined?"":uploadInfo.inTimeDate;
   				var inTime = uploadInfo.inTime == undefined?"":uploadInfo.inTime;
   				var outTimeDate = uploadInfo.outTimeDate == undefined?"":uploadInfo.outTimeDate;
   				var outTime = uploadInfo.outTime == undefined?"":uploadInfo.outTime;

   				stStr+= "<tr class = '"+trCassName+"'>";
   				stStr+= "<td>"+g_idx+"</td>";
   				stStr+= "<td>"+name+"</td>";
   				stStr+= "<td>"+deptName+"</td>";
   				stStr+= "<td class='txt_letter0'>"+inTimeBase+"</td>";
   				stStr+= "<td class='txt_letter0'>"+outTimeBase+"</td>";
   				stStr+= "<td class='txt_letter0'>"+inTimeDate+"</td>";
   				stStr+= "<td class='txt_letter0'>"+inTime+"</td>";
   				stStr+= "<td class='txt_letter0'>"+outTimeDate+"</td>";
   				stStr+= "<td class='txt_letter0'>"+outTime+"</td>";
   				stStr+= "<td class='txt_letter0'>"

   				if(uploadInfo.warningText!=""){
					var warningText =  uploadInfo.warningText;

					var warnintTextBuf = warningText.split("|");

					for(var x = 0 ; x < warnintTextBuf.length ; x++){

						var warning = 	warnintTextBuf[x];
						if(warning!=undefined&&warning!=""){
							stStr+= "<p class='p_ing'>확인필요: "+warning+"</p>";
						}
					}
   				}

   				if(uploadInfo.errorText!=""){
					var errorText =  uploadInfo.errorText;

					var errorTextBuf = errorText.split("|");

					for(var x = 0 ; x < errorTextBuf.length ; x++){

						var error = 	errorTextBuf[x];
						if(error!=undefined&&error!=""){
							stStr+= "<p class='p_error'>오류: "+error+"</p>";
						}
					}
   				}
   				stStr+= "</td></tr>";

   			}

   			$("#uploadTable tbody").html(stStr);
   			//파일 태그 재 생성.
   			$("#upFile").remove();
   			$('#fileInputArea').prepend('<input name="upFile" id="upFile" type="file" multiple onchange="selectFile();" class="file_btn_cover">');
			$("#fileName").val("");

   			$("#fileName").text("");
   			$("#errorCnt ").text(errorCnt );
   			$("#normalCnt ").text(normalCnt );
   			$("#totCnt ").text(totCnt+"건" );
   			$("#reqCnt ").text(reqCnt );

   			parent.myModal2.resize();

   		}
		//업로드 파일 번호 초기화
		worktimeExcelFileId = 0;
   		commonAjaxForFileCreateForm(url,"",'upFile',"","commentFileSize", callback , "");
	}

	//일괄처리
	function processAttendanceExcelInfo(){
		var url = contextRoot + "/worktime/processAttendanceExcelInfo.do";
		var param = {
				worktimeExcelFileId: worktimeExcelFileId
		}
		var callback = function(result){
			var obj = JSON.parse(result);
			if(obj.result == "SUCCESS"){
				alert("정상처리되었습니다.");
				parent.myModal2.close();
			}else{
				alert("시스템 처리중 오류가 발생했습니다. 담당자에게 문의해주세요.");
				parent.myModal2.close();
			}
		}

		commonAjax("POST", url, param, callback);
	}
</script>
<div class="wrap-loading display-none">
    <div><img src="${pageContext.request.contextPath}/images/ajax_loading.gif" /></div>
</div>
<div id="compnay_dinfo">
	<div class="modalWrap2">
		<div class="mo_container">
			<h3 class="h3_title_basic"><span>근태일괄등록 파일업로드</span></h3>
			<div id="CompanySerach">
				<table class="tb_ProfileInfo" summary="회사검색">
					<caption>회사검색</caption>
					<colgroup>
						<col width="140" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" rowspan="2" class="bgGray"><label for="company">근태 엑셀파일</label></th>
							<td>
								<input type="text" id="fileName" class="applyinput_B w240px" readonly="readonly"/>
								<span class="mgl8 s_violet01_btn" id = "fileInputArea"><input name="upFile" id="upFile" type="file" onchange="selectFile()" multiple class="file_btn_cover"><em class="search">찾아보기</em></span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		<ul class="gray_dot_list mgt10 ">
				<li>엑셀양식에 맞춰 근태정보를 작성한 후 업로드하시면 해당일에 출/퇴근 시간이 일괄적으로 적용됩니다.</li>
				<li>업로드 후 오류 및 알림내역을 확인하고 오류가 없을때까지 엑셀파일을 수정반복해서 업로드합니다.</li>
				<li>파일은 <strong class="fontB">반드시 지정된 엑셀양식</strong>으로 하며, 일괄적용하면 <strong class="fontB">기존에 등록된 내역은 모두 엑셀 내용으로 덮어쓰기</strong> 됩니다. (확인필요 포함)</li>
				<%--<li>출근인정요청/승인/반려 근태 승인진행중인 경우 엑셀로 덮어버리면
		</li>--%>
			</ul>
			<div class="board_classic dotlineadd">
				<div class="leftblock">
					<span class="count_result2">
						<strong class="total_title">전체</strong>
						<a href="#" class="total_count" id = "totCnt">0건</a>
						<span class="attend_list ">
							(<span class="ck_normal"><em>정상:</em><a href="#" id = "normalCnt">0</a></span>
							<span class="ck_ing"><em>확인필요:</em><a href="#" id = "reqCnt">0</a></span>
							<span class="ck_error"><em>오류:</em><a href="#" id = "errorCnt">0</a></span>)
						</span>
					</span>
				</div>
				<%--<div class="rightblock">
					<span class="vmbox mgr0"><label class="mgr10"><input type="checkbox" /><span>정상</span></label><label class="mgr10"><input type="checkbox" /><span>확인필요</span></label><label class="mgr10"><input type="checkbox" /><span>오류</span></label><label class="mgr10"><input type="checkbox" /><span>확인필요+오류</span></label></span>
				</div>--%>
			</div>
			<div class="cvsuploadWrap">
				<table class="tb_list_basic4 table_vt" summary="2016년 지각현황 (이름, 입사일, 소속, 월별현황, 총지각횟수,휴가차감일수, 총근무시간)" id = "uploadTable">
					<caption>연차기본셋팅 입력화면</caption>
					<colgroup>
						<col width="4%" /> <!--번호-->
						<col width="8%" /> <!--이름-->
						<col width="15%" /> <!--부서-->
						<col width="9%" span="6" /> <!--시간/날짜-->
						<col width="*" /> <!--오류 및 알림내역-->
					</colgroup>
					<thead>
						<tr>
							<th rowspan="2" scope="col">번호</th>
							<th rowspan="2" scope="col">이름</th>
							<th rowspan="2" scope="col">부서</th>
							<th colspan="2" scope="col">기준시간</th>
							<th rowspan="2" scope="col">출근일</th>
							<th rowspan="2" scope="col">출근</th>
							<th rowspan="2" scope="col">퇴근일</th>
							<th rowspan="2" scope="col">퇴근</th>
							<th rowspan="2" scope="col">오류 및 알림내역</th>
						</tr>
						<tr>
							<th scope="col">출근</th>
							<th scope="col">퇴근</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="10" class="no_result">파일을 업로드해주세요.</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btnZoneBox">
				<a href="javascript:processAttendanceExcelInfo()" id="btnSave" class="p_blueblack_btn" style="display: none;"><strong>일괄적용</strong></a>
				<a href="javascript:excelUpload()" id = "btnUpload" class="p_blueblack_btn"><strong>업로드</strong></a>
				<a href="javascript:parent.myModal2.close()" class="p_withelin_btn">취소</a></div>
			<!--//검색결과有//-->
		</div>
	</div>
</div>