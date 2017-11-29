<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
//치환 변수 선언
pageContext.setAttribute("cr", "\r"); //Space
pageContext.setAttribute("cn", "\n"); //Enter
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br>"); //br 태그
%>

<style type="text/css">
.datagrid_basic {
    letter-spacing: -0.08px;
    width: 100%;
    border: #c3c3c3 solid 1px;
}
.datagrid_input input {
    height: 20px;
    line-height: 20px;
    border: #cecece solid 1px;
    text-indent: 4px;
    box-sizing: border-box;
    vertical-align: middle;
    color: #858585;
}
/*#reg_input_grid tbody tr th{
	height: 51px;
	font-weight: bold;
}*/
select, input, option, textarea {
    vertical-align: middle;
    font-family: "돋움";
}
</style>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>


<section id="detail_contents">


	<form name="formDocProc" id="formDocProc" action="" method="post">
		<input type="hidden" name="targetUserId" id="targetUserId" value="${perInfo.userId}">
		<input type="hidden" name="formDocUse" id="formDocUse" >
		<input type="hidden" name="jumin1" id="jumin1" >
		<input type="hidden" name="jumin2" id="jumin2" >
		<input type="hidden" name="juminFlag" id="juminFlag">
		<input type="hidden" name="formDocEtc" id="formDocEtc">
		<input type="hidden" name="composition" id="composition">
		<input type="hidden" name="directInputYn" id="directInputYn">
		<input type="hidden" name="formDocReason" id="formDocReason">
		<input type="hidden" name="employForm" id="employForm">
		<input type="hidden" name="formDocReqSeq" id="formDocReqSeq">
		<input type="hidden" name="reqStatus" id="reqStatus"/>
		<input type="hidden" name="docType" id="docType"/>
		<input type="hidden" name="targetNm" id="targetNm" value="${perInfo.perNm}">
		<input type="hidden" name="targetOrgId" id="targetOrgId" value="${vo.targetOrgId}">
		<input type="hidden" name="formDocNm"	value="${vo.formDocNm}"/>
		<input type="hidden" name="formDocCd"	value="${vo.formDocCd}"/>
		<input type="hidden" name="reqUserId"	value="${baseUserLoginInfo.userId}"/>
		<input type="hidden" name="perAddr"	id="perAddr"	value="${perInfo.perAddr}"/>
		<input type="hidden" name="perDept" id="perDept"	value="${perInfo.perDept}"/>
		<input type="hidden" name="perDeptNm" id = "perDeptNm"	value="${perInfo.deptNm}"/>
		<input type="hidden" name="perPositionNm" id="perPositionNm"	value="${perInfo.perPositionNm}"/>
		<input type="hidden" name="comPositionNm" id="comPositionNm"	value="${perInfo.cpnNm}"/>
		<input type="hidden" name="ceoNm" id="ceoNm"	value="${perInfo.ownNm}"/>
		<input type="hidden" name="period" id="period"	value="${perInfo.perJoinCom} ~ ${perInfo.perOutCom}"/>
		<input type="hidden" name="mngChk" id="mngChk"	value="${mngChk}"/>
	</form>
	<div class="doc_AllWrap">
		<ul class="dot_list_st02">
			<li>주민번호는 증명서 발급후 바로 삭제됩니다.</li>
		</ul>
		<table id="reg_input_grid" class="tb_regi_basic" summary="경력증명서 신청" >
			<caption>경력증명서 신청</caption>
			<colgroup>
				<col width="120" />
				<col width="*" />
				<col width="120" />
				<col width="32%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" rowspan="2"><label for="perSabun">성명<span class="star">*</span></label></th>
					<td rowspan="2">
						<strong id="userNameArea" style="display:none;"><span id="nameDiv" class="mgr10">${perInfo.perNm}</span></strong>
						<a href="javascript:fnObj.userPop();" class="btn_select_employee btn_auth"><em>직원선택</em></a>


						<span style="display: inline;" class="radio_list2 mgl10"><label><input type="checkbox" id="directInput" onclick="fnObj.toggleDirectInput()" /><span><strong>직접입력</strong></span></label></span>

						<span class = "directInputArea" style="display: none;">
							<input class="input_b directInput" id="targetNmStr" name = "targetNmStr" placeholder="이름 직접입력" />
						</span>
					</td>
						<th scope="row" rowspan="2"><label for="juminFlag_">주민등록번호<c:if test = "${mngChk eq 'Y' }"><span class="star">*</span></c:if></label></th>
						<td>
							<span class="radio_list2">
								<label for="juminY"><input type="radio" name="juminFlag_" id="juminY" value="Y" onclick="fnObj.juminFlagChk()"/><span>공개</span></label>
								<label for="juminN"><input type="radio" name="juminFlag_" id="juminN" value="N" onclick="fnObj.juminFlagChk()" /><span>비공개</span></label>
							</span>
						</td>
					</td>
					</tr>
						<tr>
							<td class="dot_line">
								<span id="EqualPer">
									<input type="text" class="input_b w_45pro"	name="jumin1_" id="jumin1_" size="7" maxlength="6" onkeyup="fnObj.reOnlyNum(this.name, this.value);if(this.value.length == 6) $('#jumin2_').focus();" />

									<span class="dashLine">-</span>
									<input type="text" name="jumin2_" id="jumin2_" size="8" class="input_b w_45pro"  maxlength="7" onkeyup="fnObj.reOnlyNum(this.name, this.value);" />
									<span id = "jumin2_blind" style="display: none;">******</span><br>
								</span>
								<span id="NoneEqualPer" style="display: none;">
								<p class="spe_color_st6">(본인이 아닐 경우 주민등록번호는 입력하지 않으셔도 됩니다.)</p>
							</span>
						</td>
					</tr>
					<!-- <th scope="row">
						<label for="juminFlag">주민등록번호<span class="star">*</span></label>
					</th>
					<td>
						<input type="text" name="jumin1_" id="jumin1_" size="7" maxlength="6" class="input_b w_45pro" onkeyup="fnObj.reOnlyNum(this.name, this.value);if(this.value.length == 6) $('#jumin2_').focus();"/>
						-
						<input type="text" name="jumin2_" id="jumin2_" size="8" maxlength="7"  class="input_b w_45pro" onkeyup="fnObj.reOnlyNum(this.name, this.value);"/><br/>
					</td> -->
				</tr>
				<tr>
					<th scope="row">주소<c:if test = "${mngChk eq 'Y' }"><span class="star">*</span></c:if></th>
					<td colspan="3">
						<span class = "directNonInputArea">${perInfo.perAddr}</span>
						<span class = "directInputArea" style="display: none;"><input class="input_b directInput" id="perAddrStr" style="width:100%;" name = "perAddrStr" placeholder="주소 직접입력" /></span>

					</td>
				</tr>
				<tr>
					<th scope="row">부서<c:if test = "${mngChk eq 'Y' }"><span class="star">*</span></c:if></em></th>
					<td>
						<span class = "directNonInputArea">${empty perInfo.deptNm ? '' : (perInfo.deptNm)}</span>
						<span class = "directInputArea" style="display: none;"><input class="input_b directInput" style="width:100%;" id="perDeptNmStr"  name = "perDeptNmStr" placeholder="부서 직접입력" /></span>
					</td>
					<th scope="row"><label for="perPositionNm">직위<c:if test = "${mngChk eq 'Y' }"><span class="star">*</span></c:if></label></th>
					<td>
						<span class = "directNonInputArea">${perInfo.perPositionNm}</span>
						<span class = "directInputArea" style="display: none;"><input class="input_b directInput" style="width:100%;" id="perPositionNmStr"  name = "perPositionNmStr" placeholder="직위 직접입력" /></span>
					</td>
				</tr>
				<tr>
					<th scope="row">기간<c:if test = "${mngChk eq 'Y' }"><span class="star">*</span></c:if></th>
					<td>
						<span class = "directNonInputArea">${perInfo.perJoinCom} ${empty perInfo.perOutCom ? '' : '~'}  ${empty perInfo.perOutCom ? '' : perInfo.perOutCom}</span>
						<span class = "directInputArea" style="display: none;">
							<input type="text"  id="dateFrom" name="dateFrom" class="input_b input_date_type directInput" title="시작일" />
							<span class="dashLine">~</span>
							<input type="text"  id="dateTo" name="dateTo" class="input_b input_date_type directInput" title="종료일" />
						</span>

					</td>
					<th scope="row">채용형태<c:if test = "${mngChk eq 'Y' }"><span class="star">*</span></c:if></th>
					<td><input class="input_b directInput" style="width:100%;" id="employFormStr"  name = "employFormStr" placeholder="채용형태입력" /></td>
				</tr>
				<tr>
					<th scope="row">용도<span class="star">*</span></th>
					<td colspan="3">
						<span class="radio_list2">
							<label for="UseSel1"><input type="radio" name="useSel" id="UseSel1" value="등기소제출용" onclick="fnObj.useFlag('1', this.value);"><span id="span1" name="useSpan">등기소제출용</span></label>
							<label for="UseSel2"><input type="radio" name="useSel" id="UseSel2" value="은행제출용" onclick="fnObj.useFlag('2', this.value);"><span id="span2" name="useSpan">은행제출용</span></label>
							<label for="UseSel3"><input type="radio" name="useSel" id="UseSel3" value="증권사제출용" onclick="fnObj.useFlag('3', this.value);"><span id="span3" name="useSpan">증권사제출용</span></label>
							<label for="UseSel4"><input type="radio" name="useSel" id="UseSel4" value="법원제출용" onclick="fnObj.useFlag('4', this.value);"><span id="span4" name="useSpan">법원제출용</span></label>
							<label for="UseSel5"><input type="radio" name="useSel" id="UseSel5" value="write" onclick="fnObj.useFlag('5', this.value);"><span id="span5" name="useSpan">기타</span></label>

							<input type="text" class="input_b w200px mgl6" name="useWrite" id="UseWrite" />
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row">비고</th>
					<td colspan="3">
						<textarea name="formDocEtc_" id="formDocEtc_" class="txtarea_b2 w100pro mgt5 mgb5" placeholder="비고에 입력한 내용은 경력증명서에도 함께 입력됩니다."></textarea></td>
				</tr>
				<tr>
					<th scope="row">요청사항</th>
					<td colspan="3">
						<textarea name="formDocUse_" id="formDocReason_" class="txtarea_b2 w100pro mgt5 mgb5" placeholder="경력증명서 발행 담당자에게 요청하고 싶은 내용을 입력하는 곳입니다.&#13;&#10;경력증명서에 요청내용이 함께 들어가지 않습니다.&#13;&#10;퇴사자의 연락처를 함께 입력해주시면 세부내용 확인시 도움이 됩니다."></textarea></td>
				</tr>
				<tr>
					<th scope="row">발급회사<c:if test = "${mngChk eq 'Y' }"><span class="star">*</span></c:if></th>
					<td>
						<span class = "directNonInputArea">
							<input type="hidden" id="company" name="company" value="${perInfo.company}">
							<span name="issueSpan" style="margin-right: 8px; margin-bottom: 3px;"> ${perInfo.cpnNm}</span>
						</span>
						<span class = "directInputArea" style="display: none;"><input class="input_b directInput" style="width:100%;" id="comPositionNmStr"  name = "comPositionNmStr" placeholder="발급회사 직접입력" /></span>


					</td>
					<th scope="row">대표자명<c:if test = "${mngChk eq 'Y' }"><span class="star">*</span></c:if></th>
					<td>
						<span class = "directNonInputArea">
							<span name="issueSpan" style="margin-right: 8px; margin-bottom: 3px;"> ${perInfo.ownNm}</span>
						</span>
						<span class = "directInputArea" style="display: none;"><input class="input_b directInput" style="width:100%;" id="ceoNmStr"  name = "ceoNmStr" placeholder="대표자명 직접입력" /></span>


					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn_baordZone2" id="btn_save">
			<c:if test="${mngChk eq 'Y' }"><a href="#" class="btn_witheline btn_auth" onclick="fnObj.doSave('New');">경력증명서 발급</a></c:if>
			<c:if test="${mngChk eq 'Y' }"><a href="#" class="btn_witheline btn_auth" onclick="fnObj.doSave('Temp');">임시저장</a></c:if>
			<c:if test="${mngChk ne 'Y' }"><a href="#" class="btn_witheline btn_myOrg btn_auth" onclick="fnObj.doSave();">경력증명서 발급 요청</a></c:if>
		</div>
	</div>

</section>




<script type="text/javascript">
var myModal = new AXModal();	// instance

var fnObj = {

		preloadCode : function(){

			if('${perInfo.perNm}' != "") $("#userNameArea").show();

			$('#dateFrom').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
			$('#dateFrom').attr("readonly","readonly");
			$('#dateTo').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'}).prop("readonly",true);
			$('#dateTo').attr("readonly","readonly");


		},


		//화면세팅
		pageStart : function(){
			//modal setting
			myModal.setConfig({
	    		windowID:"myModalCT",
	    		//width:850,
	            mediaQuery: {
	                mx:{min:0, max:767}, dx:{min:767}
	            },
	    		displayLoading:true,
	            scrollLock: true,
	    		onclose: function(){

	    		}
	            ,contentDivClass: "popup_outline"
	    	});

		},
		//사람 찾기 팝업에서 직접입력 닫기버튼클릭
		directInputActive : function(){
			$("#directInput").prop("checked",true);
			fnObj.toggleDirectInput();
		},
		//경력증명서 대상자 이름 바뀐 경우
		setTargetUserId : function(userId){
			$("#targetUserId").val(userId);
			if($("#mngChk").val() == "Y"){
				$('#formDocProc').attr('action', "../system/careerMngCert.do").submit();
			}else {
				$('#formDocProc').attr('action', "../system/careerCert.do").submit();
			}
		},

		//경력증명서 관계사를 변경한 경우
		setTargetOrgId : function(){
			$("#targetOrgId").val($("#targetOrgId_").val());
			$("#targetUserId").val("");
			$('#formDocProc').attr('action', "../system/careerCert.do").submit();
		},

		doSave : function(reqStatus){

			if(reqStatus !=undefined){
				$("#reqStatus").val(reqStatus);
				if(reqStatus == "New"){
					$("#docType").val("mngCert");
				}else{
					$("#docType").val("");
				}
			}

			var isDirect = $("#directInput").prop("checked");

			if(isDirect){
				// 증명서 "#"요청 완료
				if($("#targetNmStr").val() == ""){
					alert('직원 성명을 입력해주세요.');
					return false;
				}

				//관리자 임시저장 / 수정완료시 체크 : S
				if("${mngChk}" == "Y"){
					if ($("input:radio[name='juminFlag_']:checked").val() == undefined) {
						alert('주민등록번호 공개여부를 선택하셔야 합니다.');
						return false;
					}

					if($('#jumin1_').val().length != 6){
						alert('주민등록번호 앞자리를 정확히 입력하셔야 합니다.');
						$('#jumin1_').focus();
						return false;
					}else{
						var jumin1 = $('#jumin1_').val();
			    		if(!isValidDate(jumin1)){
			    			alert("주민등록번호 앞자리를 정확히 입력하셔야 합니다.");
			    			$('#jumin1_').focus();
			    			return false;
			    		}
					}

					var chkFlag = $("input[name='juminFlag_']:checked").val();
			    	if(chkFlag =="N"){
			    		if($('#jumin2_').val().length != 1){
							alert('주민등록번호 뒷자리를 입력하셔야 합니다.');
							$('#jumin2_').focus();
							return false;
						}else{
							var jumin2 = $('#jumin2_').val();

							if(1>parseInt(jumin2)||4<parseInt(jumin2)){
								alert("주민등록번호 형식에 맞지 않습니다.");
								return false;
							}
						}
			    	}else if(chkFlag =="Y"){
			    		var juminNo = $('#jumin1_').val() + $('#jumin2_').val();

			    		if(!checkResIdNo(juminNo)){
			    			alert('주민등록번호 형식에 맞지 않습니다.');
			    			$('#jumin1_').focus();
			    			return;
			    		}
			    	}
					//주소
			    	if($("#perAddrStr").val()==""){
			    		alert("주소를 입력해 주세요.");
			    		return;
			    	}
					//부서
			    	if($("#perDeptNmStr").val()==""){
			    		alert("부서를 입력해 주세요.");
			    		$("#perDeptNmStr").focus();
			    		return;
			    	}

					if($("#dateFrom").val() == ""){
						alert("시작일을 입력해 주세요.");
						$("#dateFrom").focus();
						return;
					}
					//직위
			    	if($("#perPositionNmStr").val()==""){
			    		alert("직위를 입력해 주세요.");
			    		$("#perPositionNmStr").focus();
			    		return;
			    	}

			    	//채용형태
			    	if($("#employFormStr").val()==""){
			    		alert("채용형태를 입력해 주세요.");
			    		$("#employFormStr").focus();
			    		return;
			    	}

			    	// 회사
					if($("#comPositionNmStr").val() == ""){
						alert('발급회사를 입력해주세요.');
						$("#comPositionNmStr").focus();
						return false;
					}

					// 대표자
					if($("#ceoNmStr").val() == ""){
						alert('대표자명을 입력해주세요.');
						$("#ceoNmStr").focus();
						return false;
					}

				}
				//관리자 임시저장 / 수정완료시 체크 : E
				var dateFrom = $("#dateFrom").val().split("-").join("");
				var dateTo = $("#dateTo").val().split("-").join("");
				if($("#dateFrom").val()!=""&&$("#dateTo").val()!=""){
					if(parseInt(dateFrom)>parseInt(dateTo)){
						alert("기간의 종료일이 시작일보다 이전일 수 없습니다. ");
						return;
					}
				}


			}else{
				// 증명서 "#"요청 완료
				if($("#targetUserId").val() == ""){
					alert('직원을 선택해주세요.');
					return false;
				}
			}

			if ($("input:radio[name='juminFlag_']:checked").val() != undefined||$('#jumin1_').val()!=""||$('#jumin2_').val()!="") {
				if($('#jumin1_').val().length != 6){
					alert('주민등록번호 앞자리를 정확히 입력하셔야 합니다.');
					$('#jumin1_').focus();
					return false;
				}else{
					var jumin1 = $('#jumin1_').val();
		    		if(!isValidDate(jumin1)){
		    			alert("주민등록번호 앞자리를 정확히 입력하셔야 합니다.");
		    			$('#jumin1_').focus();
		    			return false;
		    		}
				}

				var chkFlag = $("input[name='juminFlag_']:checked").val();
		    	if(chkFlag =="N"){
		    		if($('#jumin2_').val().length != 1){
						alert('주민등록번호 뒷자리를 입력하셔야 합니다.');
						$('#jumin2_').focus();
						return false;
					}else{
						var jumin2 = $('#jumin2_').val();

						if(1>parseInt(jumin2)||4<parseInt(jumin2)){
							alert("주민등록번호 형식에 맞지 않습니다.");
							return false;
						}
					}
		    	}else if(chkFlag =="Y"){
		    		var juminNo = $('#jumin1_').val() + $('#jumin2_').val();

		    		if(!checkResIdNo(juminNo)){
		    			alert('주민등록번호 형식에 맞지 않습니다.');
		    			$('#jumin1_').focus();
		    			return;
		    		}
		    	}
			}

			$("#jumin1").val($('#jumin1_').val());
			$("#jumin2").val($('#jumin2_').val());
			$("#juminFlag").val($("input:radio[name='juminFlag_']:checked").val());




			//비고입력
			$("#formDocEtc").val($("#formDocEtc_").val());
			$("#formDocReason").val($("#formDocReason_").val());

			//회사 정보
			$("#composition").val($("#company").val());

			//채용형태
			$("#employForm").val($("#employFormStr").val());

			///////////용도 벨리데이션 :S
	    	var useVal = $("input:radio[name=useSel]:checked").val();
			if (useVal == undefined) {
				alert('용도를 선택하셔야 합니다.');
				return false;
			}

			//용도 입력.
			if (useVal == 'write'){
				if($('#UseWrite').val() == ""){
					alert('기타 사유를 입력해주세요');
					$('#UseWrite').focus();
					return false;
				}else{
					$('#formDocUse').val('기타 - '+$('#UseWrite').val());
				}

			}
			else
				$('#formDocUse').val(useVal);

			///////////용도 벨리데이션 :E

			//관리자 입력이면
			if("${mngChk}" == "Y"&&!isDirect){
				if ($("input:radio[name='juminFlag_']:checked").val() == undefined) {
					alert('주민등록번호 공개여부를 선택하셔야 합니다.');
					return false;
				}

				if($('#jumin1_').val().length != 6){
					alert('주민등록번호 앞자리를 정확히 입력하셔야 합니다.');
					$('#jumin1_').focus();
					return false;
				}else{
					var jumin1 = $('#jumin1_').val();
		    		if(!isValidDate(jumin1)){
		    			alert("주민등록번호 앞자리를 정확히 입력하셔야 합니다.");
		    			$('#jumin1_').focus();
		    			return false;
		    		}
				}

				var chkFlag = $("input[name='juminFlag_']:checked").val();
		    	if(chkFlag =="N"){
		    		if($('#jumin2_').val().length != 1){
						alert('주민등록번호 뒷자리를 입력하셔야 합니다.');
						$('#jumin2_').focus();
						return false;
					}else{
						var jumin2 = $('#jumin2_').val();

						if(1>parseInt(jumin2)||4<parseInt(jumin2)){
							alert("주민등록번호 형식에 맞지 않습니다.");
							return false;
						}
					}
		    	}else if(chkFlag =="Y"){
		    		var juminNo = $('#jumin1_').val() + $('#jumin2_').val();

		    		if(!checkResIdNo(juminNo)){
		    			alert('주민등록번호 형식에 맞지 않습니다.');
		    			$('#jumin1_').focus();
		    			return;
		    		}
		    	}

		    	//주소
		    	if($("#perAddr").val()==""){
		    		alert("주소를 입력해 주세요.");
		    		return ;
		    	}
		    	//부서
		    	if($("#perDeptNm").val()==""){
		    		alert("부서를 입력해 주세요.");
		    		return ;
		    	}
		    	//직위
		    	if($("#perPositionNm").val()==""){
		    		alert("직위를 입력해 주세요.");
		    		return ;
		    	}
		    	//관리자 임시저장 / 수정완료시 체크 : E
				var dateFrom = $("#dateFrom").val().split("-").join("");
				var dateTo = $("#dateTo").val().split("-").join("");
				if($("#dateFrom").val()!=""&&$("#dateTo").val()!=""){
					if(parseInt(dateFrom)>parseInt(dateTo)){
						alert("기간의 종료일이 시작일보다 이전일 수 없습니다. ");
						return;
					}
				}
		    	//기간
		    	if($("#period").val()==""){
		    		alert("기간을 입력해 주세요.");
		    		return ;
		    	}
				///////////용도 벨리데이션 :S
		    	/* var useVal = $("input:radio[name=useSel]:checked").val();
				if (useVal == undefined) {
					alert('용도를 선택하셔야 합니다.');
					return false;
				}

				//용도 입력.
				if (useVal == 'write'){
					if($('#UseWrite').val() == ""){
						alert('기타 사유를 입력해주세요');
						$('#UseWrite').focus();
						return false;
					}else{
						$('#formDocUse').val('기타 - '+$('#UseWrite').val());
					}

				}
				else
					$('#formDocUse').val(useVal); */

		    	// 회사
				if($("#comPositionNm").val() == ""){
					alert('발급회사를 입력해주세요.');
					return false;
				}

				// 대표자
				if($("#ceoNm").val() == ""){
					alert('대표자명을 입력해주세요.');
					return false;
				}


			}


			//직접입력이면....
			if(isDirect){
				$("#perAddr").val($("#perAddrStr").val());
				$("#perDeptNm").val($("#perDeptNmStr").val());
				$("#perPositionNm").val($("#perPositionNmStr").val());
				$("#comPositionNm").val($("#comPositionNmStr").val());
				$("#targetNm").val($("#targetNmStr").val());
				$("#ceoNm").val($("#ceoNmStr").val());
				$("#period").val($("#dateFrom").val()+" ~ "+$("#dateTo").val())
				$("#directInputYn").val("Y");

			}else
				$("#directInputYn").val("N");

			var callback = function(result){
	    		var obj = JSON.parse(result);
	    		//console.log(obj);
	    		if(obj.result == 'SUCCESS'){
	    			alert("증명서 발급 요청이 완료되었습니다.");

	    			if($("#mngChk").val() == "Y"){

	    				var formDocReqSeq= obj.resultObject;

	    				$("#formDocReqSeq").val(formDocReqSeq);

	    				$("#formDocProc").attr("action", "../system/certDocViewForMng.do").submit();
	    			}else{
	    				location.href= "../system/certDocRqmt.do";
	    			}
	    		}else{
	    			alert("증명서 발급 요청 도중 오류가 발생하였습니다.");
	    			return;
	    		}

	      	};


	    	commonAjax("POST", "../system/certDocReqEnd.do", $("#formDocProc").serialize(), callback);

		},

		reOnlyNum : function(Obj, Value) {
			re = /[^0-9\.\,\-]/gi;
			$('#'+Obj).val(Value.replace(re,""));
		},

		//사원선택 팝업	(idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
	    userPop: function(){

	    	var paramList = [];
	        var paramObj ={ name : 'userList'   ,value : $("#targetUserId").val()};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isCheckDisable' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isEnable' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isOneUser' ,value : 'Y'};
	        paramList.push(paramObj);
	        userSelectPopCall(paramList);		//공통 선택 팝업 호출

	    },


	    //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
	    getResult: function(list){
	    	fnObj.setTargetUserId(list[0].userId);
	    },
	  	//용도 클릭시
		useFlag : function(cnt, value) {
			if (value == 'write') {
				$('#UseWrite').show();
				$('#UseWrite').focus();
			} else
				$('#UseWrite').hide();

		},
	    //직접입력 체크
	    toggleDirectInput : function(){
	    	if($("#directInput").prop("checked")){
				$(".directInputArea").show();
				$(".directNonInputArea").hide();
				$("#targetUserId").val("");
				$("#userNameArea").empty();
				$("#userNameArea").hide();
	    	}else{
	    		$(".directInputArea").hide();
	    		$(".directNonInputArea").show();
	    		$("#targetNm").val("");
	    		$(".directInput").val("");
	    	}
	    },
	    //주민번호공개여부체크
	    juminFlagChk : function(){
	    	var chkFlag = $("input[name='juminFlag_']:checked").val();
	    	if(chkFlag =="N"){
	    		$("#jumin2_").attr("maxlength","1");
	    		$("#jumin2_").css("width","20px");
	    		$("#jumin2_blind").css("display","inline-block");
	    		var jumin2_ = $("#jumin2_").val();

	    		if(jumin2_.length>1){
	    			$("#jumin2_").val(jumin2_.substring(0,1));
	    		}
	    	}else if(chkFlag =="Y"){
	    		$("#jumin2_").attr("maxlength","7");
	    		$("#jumin2_").css("width","");
	    		$("#jumin2_blind").hide();
	    	}
	    }


};

$(function() {
	fnObj.preloadCode(); 	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
});
</script>