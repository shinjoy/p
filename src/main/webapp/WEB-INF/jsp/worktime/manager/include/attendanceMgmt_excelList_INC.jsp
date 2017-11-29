<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">

	var myModal = new AXModal();	// instance

	var myModal2 = new AXModal();	// instance

    $(document).ready(function(){

    	myModal2.setConfig({
    		windowID:"myModalCT",

    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: false,
    		onclose: function(){
    			linkPage(1);
    		}
            ,contentDivClass: "popup_outline"

    	});

        var nowYear = new Date().getFullYear();
        for (i = (nowYear+3); i > 2000; i--){
            $('#searchYear').append($('<option />').val(i).html(i));
        }

        if ( $.browser.msie ) {
            var expr = new RegExp('>[ \t\r\n\v\f]*<', 'g');
            $('#contentsArea').html( ($('#contentsArea').html() + "").replace(expr, '><')  );
        }

        $("#frm select[name=searchYear]").val('${searchYear}');

    });
  	//csv양식다운로드
	function downTmpl(){
		var downPop = window.open('<c:url value="/data/attendanceTmpl/attendance_sample.xlsx" />');
	}
  	//가이드보기 팝업
  	function openGuidPop(){
  		myModal.openDiv({
  			modalID: "guidArea",
  			titleBarText: '사원 선택',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
  			method:"POST",
  			top: 10,
  			width: 900,
  			closeByEscKey: true				//esc 키로 닫기
  		});

  		$('#guidArea').draggable();
  	}

  	//일괄등록팝업
  	function openAttendanceExcelPop(){
  		var url = "<c:url value='/worktime/manager/attendanceExcelPop.do'/>";

		var params = {};
		myModal2.open({
			windowID:"myModalCT",
			url: url,
			pars: params,
			titleBarText: '근태정보 파일업로드',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
			method:"POST",
			top: $(window).scrollTop() + 150,
			width: 1200,
			closeByEscKey: true			//esc 키로 닫기
		});

		$('#myModalCT').draggable();
  	}

  	//엑셀파일다운로드
  	function downloadExcel(worktimeExcelFileId){
  		url = contextRoot + "/worktime/downExcelFile.do?worktimeExcelFileId="+worktimeExcelFileId;
  		window.open(url);
  	}
</script>
<input type="hidden" name = "strSearchDate"  id = "strSearchDate" value="${fn:split(searchDate,'-')[0]}년 ${fn:split(searchDate,'-')[1]}월 ${fn:split(searchDate,'-')[2]}일" />
<input type="hidden" name = "searchMonth" id = "searchMonth" value="${searchMonth}" />
<input type="hidden" name = "searchDate"  id = "searchDate" value="${searchDate}" />

<div  class="carSearchBox mgt20">
	<span class="carSearchtitle"><label for="searchYear">년도선택</label></span>
	<select class="select_b w_date" id="searchYear" name = "searchYear"   onchange="linkPage(1)"></select>
	<span class="btn_monthZone mgl10">
		 <button type="button" onClick="searchForMonth(this,'01')" class="${searchMonth eq '01' ? 'on':''}">1월</button>
		 <button type="button" onClick="searchForMonth(this,'02')" class="${searchMonth eq '02' ? 'on':''}">2월</button>
		 <button type="button" onClick="searchForMonth(this,'03')" class="${searchMonth eq '03' ? 'on':''}">3월</button>
		 <button type="button" onClick="searchForMonth(this,'04')" class="${searchMonth eq '04' ? 'on':''}">4월</button>
		 <button type="button" onClick="searchForMonth(this,'05')" class="${searchMonth eq '05' ? 'on':''}">5월</button>
		 <button type="button" onClick="searchForMonth(this,'06')" class="${searchMonth eq '06' ? 'on':''}">6월</button>
		 <button type="button" onClick="searchForMonth(this,'07')" class="${searchMonth eq '07' ? 'on':''}">7월</button>
		 <button type="button" onClick="searchForMonth(this,'08')" class="${searchMonth eq '08' ? 'on':''}">8월</button>
		 <button type="button" onClick="searchForMonth(this,'09')" class="${searchMonth eq '09' ? 'on':''}">9월</button>
		 <button type="button" onClick="searchForMonth(this,'10')" class="${searchMonth eq '10' ? 'on':''}">10월</button>
		 <button type="button" onClick="searchForMonth(this,'11')" class="${searchMonth eq '11' ? 'on':''}">11월</button>
		 <button type="button" onClick="searchForMonth(this,'12')" class="${searchMonth eq '12' ? 'on':''}">12월</button>
		 <button type="button" onClick="searchForMonth(this,'All')" class="${searchMonth eq 'All' ? 'on':''}">전체보기</button>
	 </span>
</div>


<ul class="dot_list_st02 mgb20 mgt20">
	<li><span>근태정보를 엑셀양식에 맞춰 작성후 업로드 하시면</span> <strong class="fontB">근태정보가 일괄적으로 적용</strong><span>됩니다.</span><button type="button" class="btn_b2_skyblue mgl10" onclick="downTmpl()"><em class="icon_XLS">엑셀양식 다운</em></button></li>
	<li>문서업로드시 발생하는 오류 내역을 체크하여 엑셀양식을 수정반복을 진행한후 일괄등록을 적용하시기바랍니다.<button type="button" class="btn_b_skyblue mgl10" onclick="javascript:openGuidPop()"><em>가이드보기</em></button></li>
	<li>
	등록건수의 “확인필요”란
	<p>&nbsp;-출근인정요청/승인/반려 이력이 있는 경우</p>
	<p>&nbsp;-혹은 관리자가 근태관리 기능을 이용해 관리한 이력이 있는 경우</p>
	<p>&nbsp;-또는 출근이력이 없는 날짜에 퇴근 시간을 엑셀로 입력하는 경우로 </p>
	이러한 관리 이력이 있음에도 근태엑셀데이터를 업로드 적용한 건수를 말합니다.
	</li>
</ul>
<%--<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span><button type="button" class="btn_b2_skyblue"><em class="icon_XLS">엑셀양식 다운</em></button> 버튼으로 양식을 다운받은후 해당서식으로 근태문서를 작성합니다.</span></div>--%>
<!--연차기본셋팅-->

<!--연차상세옵션-->

<table class="tb_list_basic" summary="근태일괄관리 (이름, 입사일, 소속, 월별현황, 총지각횟수,휴가차감일수, 총근무시간)">
	<caption>연차기본셋팅 입력화면</caption>
	<colgroup>
		<col width="3%" /> <!--번호-->
		<col width="*" /> <!--문서이름-->
		<col width="15%" /> <!--적용여부-->
		<col width="15%" /> <!--등록건수-->
		<col width="15%" /> <!--등록자-->
		<col width="10%" /> <!--등록일-->
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">문서이름</th>
			<th scope="col">적용여부</th>
			<th scope="col">등록건수(확인필요)</th>
			<th scope="col">등록자</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${fileList }" var="data" varStatus="i">
			<tr onclick="downloadExcel('${data.worktimeExcelFileId}')">
				<td>${i.index+1 }</td>
				<td class="txt_b_title"><a href="#">${data.orgFileName }</a></td>
				<td>${data.applyYn eq 'Y'?'적용':'미적용' }</td>
				<td>
					<strong class="state_tt3">${data.uploadCnt }건</strong>
					<span class="attend_list2">(<em class="st_modify">${data.attendReqCnt }건</em>)</span>
				</td>
				<td>${data.createdNm }</td>
				<td class="txt_letter0">${data.createDate }</td>
			</tr>
		</c:forEach>

		<c:if test="${fn:length(fileList)<=0 }">
			<tr>
				<td colspan="6" class="no_result">검색결과가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<!--// 연차상세옵션 //-->

<!--버튼모음-->
<div class="btn_baordZone2">
	<a href="javascript:openAttendanceExcelPop()" class="btn_blueblack btn_auth">근태 일괄등록</a>
</div>
<!--//버튼모음//-->


<!-- 가이드 팝업 -->
<div id = "guidArea" class="AXModalBox" style="display: none;z-index: 6000;position: absolute;top:50%;left: 20%;padding: 0px;width:900px;background: white;" >
	<table class="popHeader windowbox" style="border-collapse:collapse; border:1px #000 solid; border-bottom:0px;" cellspacing="0" width="100%" height="31px">
		<tbody>
			<tr>
				<td width="100%" bgcolor="white" style="color:white;font-size:13px;padding-left:7px;background-image:linear-gradient(#20304a, #20304a);">
					<b style="float: left;">근태정보 파일업로드</b>
					<a id="AXModalA162314863_close" class="closeBtn" style="float: right;" href="javascript:myModal.close('guidArea')"><em>닫기</em></a>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="mo_container" style="padding: 12px 12px 12px 12px">
		<h3 class="h3_title_basic"><span>근태일괄등록 파일업로드</span></h3>
		<div class="re_CompanyList">
			<ul class="gray_dot_list">
				<li>정상출근ㆍ지각은 <strong class="fontB">출ㆍ퇴근기준시간과 실제 출ㆍ퇴근 시간을 근거로</strong> 시스템이 판단합니다.</li>
				<li>출ㆍ퇴근일 입력하여 근태기록을 작성하며, 입력데이터가 없는 셀은 공란으로 둡니다.</li>
				<li>기존에 출퇴근한 이력이 있는 날짜도 엑셀 업로드시 <strong class="fontB">엑셀파일을 기준으로 업데이트</strong> 됩니다. (<span class="txt_underline">일근태마감시 포함</span>)</li>
				<li><span class="txt_underline">주말출근의 경우 지각여부 체크되지 않습니다.</span></li>
				<li><strong class="fontBlue">* 항목은 필수입력항목</strong>입니다.(이름, 부서, 출근기준시간, 퇴근기준시간)</li>
				<li>출ㆍ퇴근일이 입력된 경우 출ㆍ퇴근 시간은 필수 입력항목이 됩니다.</li>
			</ul>
			<div class="attendGuideBox">
				<img src="${pageContext.request.contextPath}/images/approve/img_excelguide2.png" alt="등록가이드">
				<ul class="hidden">
					<li>이름, 부서, 출근기준시간, 퇴근기준시간은 필수입력정보입니다.</li>
					<li>1열 항목명을 제외한 2열 DB에 등록됩니다.</li>
				</ul>
				<%--<ol class="red_numList">
					<li class="iconNumber"><strong>다른날짜</strong> 출ㆍ퇴근 등록케이스</li>
					<li class="iconNumber num02"><strong>출근만 등록한</strong> 경우</li>
					<li class="iconNumber num03">다른직원과<strong> 출퇴근기준이 다른경우</strong></li>
					<li class="iconNumber num04"><strong>한직원의 여러일자</strong> 출ㆍ퇴근 등록케이스</li>
					<li class="iconNumber num05"><strong>퇴근만 등록한</strong> 경우</li>
					<li class="iconNumber num06"><strong>같은날짜</strong> 출ㆍ퇴근 등록케이스</li>
				</ol>--%>
			</div>
		</div>

		<div class="cvsuploadWrap">

		</div>
		<div class="btnZoneBox">
			<a href="javascript:myModal.close('guidArea')" class="p_withelin_btn">닫기</a>
		</div>
	</div>
</div>