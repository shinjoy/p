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
		<input type="hidden" name="targetUserId" id="targetUserId">
		<input type="hidden" name="formDocUse" id="formDocUse" >
		<input type="hidden" name="jumin1" id="jumin1" >
		<input type="hidden" name="jumin2" id="jumin2" >
		<input type="hidden" name="juminFlag" id="juminFlag">
		<input type="hidden" name="formDocEtc" id="formDocEtc">
		<input type="hidden" name="composition" id="composition">
		<input type="hidden" name="formDocReason" id="formDocReason">
		<input type="hidden" name="employForm" id="employForm">
		<input type="hidden" name="targetNm" id="targetNm">
		<input type="hidden" name="perAddr"	id="perAddr"/>
		<input type="hidden" name="perDept" id="perDept"/>
		<input type="hidden" name="perDeptNm" id = "perDeptNm"/>
		<input type="hidden" name="perPositionNm" id="perPositionNm"/>
		<input type="hidden" name="comPositionNm" id="comPositionNm"/>
		<input type="hidden" name="ceoNm" id="ceoNm"/>
		<input type="hidden" name="period" id="period"/>
		<input type="hidden" name="reqStatus" id="reqStatus"/>
		<input type="hidden" name="docType" id="docType"/>
		<input type="hidden" name="formDocReqSeq" id="formDocReqSeq" value="${formDocVO.formDocReqSeq }"/>
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
					<th scope="row" rowspan="2"><label for="perSabun">성명</label><span class="star">*</span></th>
					<td rowspan="2">
						<span class = "directInputArea">
							<input class="input_b directInput" id="targetNmStr" name = "targetNmStr" value="${formDocVO.targetNm }" placeholder="이름 직접입력" />
						</span>
					</td>
						<th scope="row" rowspan="2"><label for="juminFlag_">주민등록번호<span class="star">*</span></label></th>
						<td>
							<span class="radio_list2">
								<label for="juminY"><input type="radio" name="juminFlag_" id="juminY" value="Y" onclick="fnObj.juminFlagChk()" <c:if test = "${formDocVO.juminFlag eq 'Y' }">checked="checked"</c:if>/><span>공개</span></label>
								<label for="juminN"><input type="radio" name="juminFlag_" id="juminN" value="N" onclick="fnObj.juminFlagChk()" <c:if test = "${formDocVO.juminFlag eq 'N' }">checked="checked"</c:if>/><span>비공개</span></label>
							</span>
						</td>
					</td>
					</tr>
						<tr>
							<td class="dot_line">
								<span id="EqualPer">
									<input type="text" class="input_b w_45pro"	name="jumin1_" id="jumin1_" value="${formDocVO.realJumin1 }" size="7" maxlength="6" onkeyup="fnObj.reOnlyNum(this.name, this.value);if(this.value.length == 6) $('#jumin2_').focus();" />
									<span class="dashLine">-</span>
									<input type="text" name="jumin2_" id="jumin2_" value="${formDocVO.realJumin2 }" size="8" class="input_b w_45pro"  maxlength="7" onkeyup="fnObj.reOnlyNum(this.name, this.value);" />
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
					<th scope="row">주소<span class="star">*</span></th>
					<td colspan="3">
						<span class = "directInputArea" ><input class="input_b directInput" id="perAddrStr" name = "perAddrStr" value="${formDocVO.perAddr }" style="width:100%;" placeholder="주소 직접입력" /></span>

					</td>
				</tr>
				<tr>
					<th scope="row">부서<span class="star">*</span></em></th>
					<td>
						<span class = "directInputArea"><input class="input_b directInput" style="width:100%;" id="perDeptNmStr"  name = "perDeptNmStr" value="${formDocVO.perDeptNm }" placeholder="부서 직접입력" /></span>
					</td>
					<th scope="row"><label for="perPositionNm">직위<span class="star">*</span></label></th>
					<td>
						<span class = "directInputArea"><input class="input_b directInput" style="width:100%;" id="perPositionNmStr" name = "perPositionNmStr" value="${formDocVO.perPositionNm }" placeholder="직위 직접입력" /></span>
					</td>
				</tr>
				<tr>
					<th scope="row">기간<span class="star">*</span></th>
					<td>
						<c:set var = "periodBuf" value="${fn:split(formDocVO.period,'~') }"></c:set>
						<span class = "directInputArea">
							<input type="text"  id="dateFrom" name="dateFrom" value="${fn:trim(periodBuf[0]) }" class="input_b input_date_type directInput" title="시작일" />
							<span class="dashLine">~</span>
							<input type="text"  id="dateTo" name="dateTo" value="${fn:trim(periodBuf[1]) }" class="input_b input_date_type directInput" title="종료일" />
						</span>

					</td>
					<th scope="row">채용형태<span class="star">*</span></th>
					<td><input class="input_b directInput" style="width:100%;" id="employFormStr"  name = "employFormStr" value="${formDocVO.employForm }" placeholder="채용형태입력" /></td>
				</tr>
				<tr>
					<th scope="row">용도<span class="star">*</span></th>
					<td colspan="3">
						<span class="radio_list2">
							<c:set var = "useSelBuf" value="${fn:split(formDocVO.formDocUse,'-') }"></c:set>
							<c:set var = "useSel" value="${fn:trim(useSelBuf[0]) }"></c:set>
							<label for="UseSel1"><input type="radio" name="useSel" id="UseSel1" value="등기소제출용" <c:if test = "${useSel eq '등기소제출용' }">checked="checked"</c:if> onclick="fnObj.useFlag('1', this.value);"><span id="span1" name="useSpan">등기소제출용</span></label>
							<label for="UseSel2"><input type="radio" name="useSel" id="UseSel2" value="은행제출용" <c:if test = "${useSel eq '은행제출용' }">checked="checked"</c:if> onclick="fnObj.useFlag('2', this.value);"><span id="span2" name="useSpan">은행제출용</span></label>
							<label for="UseSel3"><input type="radio" name="useSel" id="UseSel3" value="증권사제출용" <c:if test = "${useSel eq '증권사제출용' }">checked="checked"</c:if> onclick="fnObj.useFlag('3', this.value);"><span id="span3" name="useSpan">증권사제출용</span></label>
							<label for="UseSel4"><input type="radio" name="useSel" id="UseSel4" value="법원제출용" <c:if test = "${useSel eq '법원제출용' }">checked="checked"</c:if> onclick="fnObj.useFlag('4', this.value);"><span id="span4" name="useSpan">법원제출용</span></label>
							<label for="UseSel5"><input type="radio" name="useSel" id="UseSel5" value="write" <c:if test = "${useSel eq '기타' }">checked="checked"</c:if> onclick="fnObj.useFlag('5', this.value);"><span id="span5" name="useSpan">기타</span></label>

							<input type="text" class="input_b w200px mgl6" name="useWrite" value="${fn:trim(useSelBuf[1]) }" id="UseWrite" />
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row">비고</th>
					<td colspan="3">
						<textarea name="formDocEtc_" id="formDocEtc_" class="txtarea_b2 w100pro mgt5 mgb5" placeholder="비고에 입력한 내용은 경력증명서에도 함께 입력됩니다.">${formDocVO.formDocEtc }</textarea></td>
				</tr>
				<tr>
					<th scope="row">요청사항</th>
					<td colspan="3">
						<textarea name="formDocUse_" id="formDocReason_" class="txtarea_b2 w100pro mgt5 mgb5" placeholder="경력증명서 발행 담당자에게 요청하고 싶은 내용을 입력하는 곳입니다.&#13;&#10;경력증명서에 요청내용이 함께 들어가지 않습니다.&#13;&#10;퇴사자의 연락처를 함께 입력해주시면 세부내용 확인시 도움이 됩니다.">${formDocVO.formDocReason }</textarea></td>
				</tr>
				<tr>
					<th scope="row">발급회사<span class="star">*</span></th>
					<td>

						<span class = "directInputArea" ><input class="input_b directInput" style="width:100%;" id="comPositionNmStr"  name = "comPositionNmStr" value="${formDocVO.comPositionNm }" placeholder="발급회사 직접입력" /></span>


					</td>
					<th scope="row">대표자명<span class="star">*</span></th>
					<td>
						<span class = "directInputArea"><input class="input_b directInput" style="width:100%;" id="ceoNmStr"  name = "ceoNmStr" value="${formDocVO.ceoNm }" placeholder="대표자명 직접입력" /></span>


					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn_baordZone2" id="btn_save">
			<a href="#" class="btn_witheline btn_auth" onclick="fnObj.doSave('New');">경력증명서 발급</a>
			<a href="#" class="btn_witheline btn_auth" onclick="fnObj.doSave('Temp');">임시저장</a>
			<a href="#" class="btn_witheline btn_auth" onclick="fnObj.goList();">목록</a>
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


		//경력증명서 대상자 이름 바뀐 경우
		setTargetUserId : function(userId){
			$("#targetUserId").val(userId);
			$('#formDocProc').attr('action', "../system/careerCert.do").submit();
		},

		//경력증명서 관계사를 변경한 경우
		setTargetOrgId : function(){
			$("#targetOrgId").val($("#targetOrgId_").val());
			$("#targetUserId").val("");
			$('#formDocProc').attr('action', "../system/careerCert.do").submit();
		},
		//목록 이동
		goList : function() {
			location.href = contextRoot + "/system/certDocRqmtForMng.do";
		},
		doSave : function(reqStatus){
			$("#reqStatus").val(reqStatus);
			if(reqStatus == "New"){
				$("#docType").val("mngCert");
			}else{
				$("#docType").val("");
			}

			// 증명서 "#"요청 완료
			if($("#targetNmStr").val() == ""){
				alert('직원 성명을 입력해주세요.');
				return false;
			}


			if(reqStatus == "Temp"){
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
			}else{
				//관리자 임시저장 / 수정완료시 체크 : S
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

				//관리자 임시저장 / 수정완료시 체크 : E
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

			$("#perAddr").val($("#perAddrStr").val());
			$("#perDeptNm").val($("#perDeptNmStr").val());
			$("#perPositionNm").val($("#perPositionNmStr").val());
			$("#comPositionNm").val($("#comPositionNmStr").val());
			$("#targetNm").val($("#targetNmStr").val());
			$("#ceoNm").val($("#ceoNmStr").val());
			$("#period").val($("#dateFrom").val()+" ~ "+$("#dateTo").val())
			$("#directInputYn").val("Y");

			var callback = function(result){
	    		var obj = JSON.parse(result);
	    		//console.log(obj);
	    		if(obj.result == 'SUCCESS'){
	    			alert("완료되었습니다.");

	    			if($("#docType").val()=="mngCert"){
	    				$('#formDocProc').attr('action', "<c:url value='/system/certDocViewForMng.do'/>").submit();
	    			}else{
	    				location.href= "../system/certDocRqmtForMng.do";
	    			}
	    		}else{
	    			alert("증명서 발급 요청 도중 오류가 발생하였습니다.");
	    			return;
	    		}

	      	};
			var confirmStr = "";

			if(reqStatus == "New"){
				if(!confirm("발급하시면 더 이상 수정은 불가능합니다.\n발급 하시겠습니까?")){
					return;
				}
			}

	    	commonAjax("POST", "../system/certDocReqProc.do", $("#formDocProc").serialize(), callback);

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
	fnObj.juminFlagChk();

	var useVal = $("input:radio[name=useSel]:checked").val();
	if (useVal == 'write') {
		$('#UseWrite').show();
		$('#UseWrite').focus();
	} else
		$('#UseWrite').hide();
});
</script>