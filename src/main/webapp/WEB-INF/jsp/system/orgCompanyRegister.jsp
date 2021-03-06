<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<section id="detail_contents">
	<form name="myForm" id="myForm"  enctype="multipart/form-data">
       	<input type="hidden" id="orgId" name="orgId" value="${orgMap.orgId}" />
     <!--   	<input type="file" name="inFile" id="inFile" style="display:none;" onchange="fnObj.changeFile();" /> -->
        <table id="reg_input_grid" class="datagrid_input tb_fixed" summary="관계사 등록/수정">
            <caption>관계사 등록/수정</caption>
            <colgroup>
                <col width="180"> <!--구분-->
                <col width="*">   <!--입력-->
                <col width="120"> <!--구분-->
                <col width="*">   <!--입력-->
                <col width="120"> <!--구분-->
                <col width="*"> <!--입력-->
            </colgroup>
            <tbody>
                <tr>
                	<th scope="row"><label for="businessGroup">비즈니스그룹 선택</label></td></th>
                    <td colspan="5"><select id="businessGroup" name="businessGroup" class="select_b">
                    		<option value="">선택</option>
                    	</select>
                    	<a href="#" class="btn_s_type_g mgl6" onclick="fnObj.addBusinessGroup()">그룹추가</a>
                    </td>
                </tr>
				<tr>
					<th scope="row"><label for="orgName">회사 선택</label></th>
					<td colspan="5" class="vm">
						<span>
							<span id="orgName"></span> <input type="hidden" id="companySnb" name="companySnb" value="${orgMap.companySnb}">
							<input type="hidden" id="companyName" name="companyName" class="mgr6">
							<c:if test="${mode eq 'new'}">
								<a href="#" class="btn_s_type_g" onclick="fnObj.searhOrgPop()">검색</a>
							</c:if>
						</span>
						<span class="mgl20">
	                    	<label>
	                    		<input type="checkbox" id="groupingOrgYn" name="groupingOrgYn" ${orgMap.groupingOrgYn == 'Y' ? "checked": ""} onchange="fnObj.changeVal();">
	                    		<span>추가소속회사 존재여부</span><span class="mgl6 fontRed">(다수개 회사를 포함하는 관계사 - 체크시 하단에서 반드시, 관계사 소속회사를 추가합니다!)</span>
	                    	</label>
                    	</span>
					</td>
				</tr>
				<tr class="containCompnayArea" style="display:none;">
					<th rowspan="2"><label for="include_company"><strong>관계사 소속회사</strong></label></th>
                    <td colspan="5">
                    	<a href="#" class="btn_s_type_g" onclick="fnObj.searhIncludeCompany()">소속회사 추가</a>
                    </td>
                </tr>
                <tr class="containCompnayArea" style="display:none;" >
                    <td colspan="5" class="dotline">
                    	<span id="addCompany"></span>
                    </td>
                </tr>
				<tr>
					<th scope="row"><label for="orgCode">관계사 PREFIX</label></th>
					<td colspan="5">
						<input id="orgCode" name="orgCode" maxlength="2" class="input_b" placeholder="관계사 코드" value="${orgMap.orgCode}" <c:if test="${mode ne 'new'}">readonly </c:if> />
						<c:if test="${mode eq 'new' }"><a href="#" class="btn_s_type_g" onclick="fnObj.checkOrgCode()">유효성 검사</a></c:if>
					</td>
				</tr>
				<tr>
                    <th scope="row"><label for="orgCode">접속 도메인</label></th>
                    <td colspan="5">
                        <input id="domain" name="domain" maxlength="45" class="input_b w50pro" placeholder="접속 도메인" value="${orgMap.domain}" />
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="IDName10">SMS발송대표번호</label></th>
                    <td colspan="5">
                        <input type="text" id="smsEndTelNo_1"  name="smsEndTelNo_1"  value="${fn:split(orgMap.smsEndTelNo,'-')[0]}" maxlength="4" class="input_phone digit" title="SMS발송대표번호 앞번호" />
                        <span class="dashLine">-</span> <input type="text" id="smsEndTelNo_2"  name="smsEndTelNo_2"  value="${fn:split(orgMap.smsEndTelNo,'-')[1]}" maxlength="4" class="input_phone digit" title="SMS발송대표번호 중간번호" />
                        <span class="dashLine">-</span> <input type="text" id="smsEndTelNo_3"  name="smsEndTelNo_3"  value="${fn:split(orgMap.smsEndTelNo,'-')[2]}" maxlength="4" class="input_phone digit" title="SMS발송대표번호 마지막번호" />
                    </td>
                </tr>

				<tr>
					<th scope="row"><label for="orgDesc">설명</label></th>
					<td colspan="5"> <input id="orgDesc" name="orgDesc" maxlength="100"  class="input_b w50pro" placeholder="설명을 입력하세요." value="${orgMap.description}"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="">출퇴근 시간 입력</label></th>
                    <td colspan="5">
                    	<select id="inputInTimeFirst" class="select_b w42px"><c:forEach var="item" begin="0" end="12">
                    		<fmt:formatNumber var="no" minIntegerDigits="2" value="${item}" />
                    		<option value="${no }" ${ orgMap.inputInTimeFirst == no ? "selected" : "" }>${no }</option>
                    	</c:forEach></select> <span class="dashLine">:</span>
                    	<select id="inputInTimeSecond" class="select_b w42px"><c:forEach var="item" begin="0" end="59">
                    	 	<fmt:formatNumber var="no" minIntegerDigits="2" value="${item}" />
                    		<option value="${no }" ${ orgMap.inputInTimeSecond == no ? "selected" : "" }>${no }</option>
                    	</c:forEach></select> <span class="dashLine">~</span>
                    	<select  id="inputOutTimeFirst" class="select_b w42px"><c:forEach var="item" begin="12" end="24">
                    		<fmt:formatNumber var="no" minIntegerDigits="2" value="${item}" />
                    		<option value="${no }" ${ orgMap.inputOutTimeFirst == no ? "selected" : "" }>${no }</option>
                    	</c:forEach></select> <span class="dashLine">:</span>
                    	<select id="inputOutTimeSecond" class="select_b w42px"><c:forEach var="item" begin="0" end="59">
                    		<fmt:formatNumber var="no" minIntegerDigits="2" value="${item}" />
                    		<option value="${no }" ${ orgMap.inputOutTimeSecond == no ? "selected" : "" }>${no }</option>
                    	</c:forEach></select>
                    </td>
				</tr>
				<tr>
					<th scope="row"><label for="codeMgmtAdminYn">시스템코드 최상위권한 여부</label></th>
                    <td colspan="5">
                    	<select id="codeMgmtAdminYn" class="select_b w42px" name="codeMgmtAdminYn">
                    		<option value='Y' ${orgMap.codeMgmtAdminYn == 'Y' ? "selected": ""}>Y</option>
                    		<option value='N' ${orgMap.codeMgmtAdminYn == 'N' ? "selected": ""}>N</option>
                    	</select>
                    </td>
               	</tr>
               	<tr>
					<th scope="row"><label for="codeMgmtAdminYn">${baseUserLoginInfo.projectTitle} 사용여부</label></th>
                    <td colspan="5">
                    	<span class="radio_list2">
	                    	<label><input type="radio" name="projectUseYn" value="Y" ${mode == 'new' ? "checked" : ''} ${orgMap.projectUseYn=='Y' ? "checked" : '' } />사용</label>
	                    	<label class="mgl10"><input type="radio" name="projectUseYn" disabled="disabled" value="N" ${mode == 'new' ? "": ''} ${orgMap.projectUseYn=='N' ? "checked" : ''}/>사용안함</label>

	                    	<span class="mgl6 fontRed">(업무구분은 사용필수 항목입니다.)</span>
                    	</span>
                    </td>
               	</tr>
               	<tr>
                    <th scope="row"><label for="codeMgmtAdminYn">결재 사용여부</label></th>
                    <td colspan="5">
                        <span class="radio_list2">
                            <label><input type="radio" name="approveUseYn" value="Y" ${mode == 'new' ? "" : ''} ${orgMap.approveUseYn=='Y' ? "checked" : '' } />사용</label>
                            <label class="mgl10"><input type="radio" name="approveUseYn" value="N" ${mode == 'new' ? "checked": ''} ${orgMap.approveUseYn=='N' ? "checked" : ''}/>사용안함</label>
                        </span>

                        <span class="mgl6 fontRed">(사용이 권장사항이며 사용안함 체크시 휴가업무구분을 이용하여 휴가 건을 근태에 반영합니다.)</span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="secomeUseYn">세콤 연동 여부</label></th>
                    <td colspan="5">
                        <span class="radio_list2">
                            <label><input type="radio" name="secomeUseYn" value="Y" ${mode == 'new' ? "" : ''} ${orgMap.secomeUseYn=='Y' ? "checked" : '' } />사용</label>
                            <label class="mgl10"><input type="radio" name="secomeUseYn" value="N" ${mode == 'new' ? "checked": ''} ${orgMap.secomeUseYn=='N' ? "checked" : ''}/>사용안함</label>
                        </span>

                        <span class="mgl6 fontRed">(사용 체크시 PASS 로그인 출/퇴근 처리 사용안함 처리됩니다.)</span>
                    </td>
                </tr>
				<tr>
					<th scope="row"><label for="orgImageFile">로고 이미지</label></th>
                    <td colspan="5">
                    <!-- <a href="javascript:fnObj.imageFile();" class="btn_file_finder"><em>이미지찾기</em></a> -->
                    <span id="fileInputArea" class="file_btn_bg"><input name="inFile" id="inFile" type="file" multiple onchange="fnObj.changeFile();" class="file_btn_cover"></span>
                    	<span id="orgImageFile" style="display:none;" class="employee_list"><span id="imgName"></span><a href="javascript:fnObj.delImageFile();" class="btn_delete_employee"><em>삭제</em></a></span>
                    	<span><img id="orgImageFileView" width="140" style="display:none;" height="47" src="data:image/png;base64,${orgMap.orgLogoData}" /></span>
               		</td>
               	</tr>
				<tr>
					<th scope="row"><label for="addr">주소</label></th>
					<td colspan="5">
						<input id="addr" name="addr" class="input_b w50pro"  maxlength="200" placeholder="주소를 입력하세요." value="${orgMap.addr}"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="addr">소속직원 사용가능 여부</label></th>
					<td colspan="5">
                    	<span class="radio_list2">
	                    	<label><input type="radio" name="useYn" value="Y" ${mode == 'new' ? "checked" : ''} ${orgMap.useYn=='Y' ? "checked" : '' } checked="checked"/>사용</label>
	                    	<label class="mgl10"><input type="radio" name="useYn" value="N" ${mode == 'new' ? "": ''} ${orgMap.useYn=='N' ? "checked" : ''}/>사용안함</label>
                    	</span>
                    </td>
				</tr>
				<c:if test="${mode != 'new' }">
					<tr>
						<th scope="row"><label for="addr">관계사 유효여부</label></th>
						<td colspan="5">
							<span class="radio_list2">
		                    	<label><input type="radio" name="enable" onchange="fnObj.chkEnable()" value="Y" ${mode == 'new' ? "checked" : ''} ${orgMap.enable=='Y' ? "checked" : '' } checked="checked"/>사용</label>
		                    	<label class="mgl10"><input type="radio" onchange="fnObj.chkEnable()" name="enable" value="N" ${mode == 'new' ? "": ''} ${orgMap.enable=='N' ? "checked" : ''}/>사용안함</label>
	                    	</span>
	                    </td>
					</tr>
				</c:if>
				<!-- 메일 연동 설정 -->
				<tr>
					<th scope="row"><label for="mailUseYn">메일 사용여부</label></th>
					<td>
                    	<select id="mailUseYn" class="w42px select_b" name="mailUseYn" onChange="fnObj.changeMailUseYn();">
                    		<option value='N' ${orgMap.mailUseYn == 'N' ? "selected": ""}>N</option>
                    		<option value='Y' ${orgMap.mailUseYn == 'Y' ? "selected": ""}>Y</option>
                    	</select>
                    </td>
                    <th scope="row"><label for="mailServiceName">메일 계정 선택<br/>(아래: API URL)</label></th>
					<td>
						<select id="mailServiceName" class="select_b" name="mailServiceName" onChange="fnObj.changeMailServiceName();" disabled>
                    		<option value='mailplug' ${orgMap.mailServiceName == 'mailplug' ? "selected": ""}>메일플러그</option>
                    		<option value='etc' ${orgMap.mailServiceName == 'etc' ? "selected": ""}>기타</option>
                    	</select>
                    	<span><input id="mailUrl" name="mailUrl" class="input_b w50pro mgl6" placeholder="URL 입력" value="${orgMap.mailUrl}" disabled/><br/>
                    	<input id="mailApiUrl" name="mailApiUrl" class="input_b w100pro mgl6" style="margin-left:0px;margin-top:3px;" placeholder="API URL 입력" value="${orgMap.mailApiUrl}" disabled/></span>
					<th scope="row"><label for="mailLinkType" >링크방식</label></th>
					<td>
						<select id="mailLinkType" class="select_b" name="mailLinkType"  disabled>
                    		<option value='child' ${orgMap.mailLinkType == 'child' ? "selected": ""}>자창</option>
                    		<option value='new' ${orgMap.mailLinkType == 'new' ? "selected": ""}>새창</option>
                    	</select>
					</td>
				</tr>
				<!-- 프로젝트 타이틀 -->
                <tr>
                    <th scope="row"><label for="projectTitle">${baseUserLoginInfo.projectTitle} 타이틀</label></th>
                    <td>
                        <input id="projectTitle" name="projectTitle" class="input_b w100pro"  maxlength="20" placeholder="${baseUserLoginInfo.projectTitle} 타이틀" value="${orgMap.projectTitle}"/>
                    </td>
                    <th scope="row"><label for="activityTitle">${baseUserLoginInfo.activityTitle} 타이틀</label></th>
                    <td>
                        <input id="activityTitle" name="activityTitle" class="input_b w100pro" maxlength="20"  placeholder="${baseUserLoginInfo.activityTitle} 타이틀" value="${orgMap.activityTitle}"/>
                    </td>
                    <th scope="row"><label for="tsTitle" >타임시트 타이틀</label></th>
                    <td>
                        <input id="tsTitle" name=tsTitle class="input_b w100pro" maxlength="20"  placeholder="타임시트 타이틀" value="${orgMap.tsTitle}"/>
                    </td>
                </tr>
                <!-- 유효사용자 수 -->
                <tr>
                    <th scope="row"><label for="avalUserCnt">유효사용자 수</label></th>
                    <td colspan="5">
                        <input id="avalUserCnt" name="avalUserCnt" class="input_b digit" maxlength="9"  placeholder="유효사용자 수" value="${orgMap.avalUserCnt}"/>
                    </td>
                </tr>
			</tbody>
        </table>


		<c:if test="${mode ne 'new'}">
			<div class="btn_baordZone2" id="btn_update">
            	<a href="javascript:fnObj.doUpdate();" id="btn_update" class="p_blueblack_btn btn_auth">수정</a>
            	<!-- <a href="javascript:fnObj.doDel();" id="btn_del" class="p_withelin_btn">삭제</a> -->
            	<a href="javascript:fnObj.doList();" class="p_withelin_btn">목록</a>
        	 </div>
		</c:if>
		<c:if test="${mode eq 'new'}">
			  <div class="btn_baordZone2" id="btn_save">
           		<a href="javascript:fnObj.doSave();" class="p_blueblack_btn btn_auth">저장</a>
               	<a href="javascript:fnObj.doList();" class="p_withelin_btn">목록</a>
       		 </div>
		</c:if>
	</form>
</section>

<script type="text/JavaScript" src="<c:url value='/js/process.js'/>" ></script>

<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')
var orgLogoYn = "${orgMap.orgLogo}";
var myModal = new AXModal();	// 관계사-회사 선택 모달
var myBusinessModal = new AXModal(); // 비즈니스 그룹 등록 모달
var myGroupingModal = new AXModal(); // 관계사 소속회사 등록 모달

//var myGrid = new AXGrid(); 		// instance
//var myGrid2 = new AXGrid(); 	// instance	(오른쪽)

var targetCompanyList = [];
var oldTargetCompanyList = [];

//div popup 방식을 위한 글쓰기,수정 위한 변수
var mode = "${mode}";						//"new", "view", "update"
var orgCodecheck; 							//관계사 코드 유효성 검사

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//비즈니스 그룹 selectbox 생성.
		fnObj.doSelectBusinessGroup("${orgMap.businessGrpSeq}");

		//관계사 명 설정.
		$("#orgName").html("${orgMap.cpnNm}");
		//이미지 설정.
		if(orgLogoYn == 'Y'){
			//이미지가 있는 경우.
			//$("#imgName").html("[이미지 있음]");
			$('#orgImageFile').show();
			$('#orgImageFileView').show();
  		}

		targetCompanyList = [];		//JSON.parse("${orgIncludeCompList}");
		oldTargetCompanyList = [];	//JSON.parse("${orgIncludeCompList}");

		var targetAllinfoList = [];		//이미 존재하는 소속회사 리스트

		<c:forEach items="${orgIncludeCompList}" var="item">
			//$("<span />", { class: "tags",  text : "${item.cpnNm}"}).appendTo("#addCompany");
			targetAllinfoList.push({'sNb':'${item.companySnb}','cpnNm':'${item.cpnNm}'});
			targetCompanyList.push({'sNb':'${item.companySnb}'});
			oldTargetCompanyList.push({'sNb':'${item.companySnb}'});
		</c:forEach>

		//이미 존재하는 소속회사 세팅
		if(targetAllinfoList.length > 0) {
			$('.containCompnayArea').show();
			fnObj.getIncludeCompany(targetAllinfoList);
		}

		//디폴트 시간세팅
		if(mode == 'new'){
			$("#inputInTimeFirst").val("09");
			$("#inputInTimeSecond").val("00");
			$("#inputOutTimeFirst").val("18");
			$("#inputOutTimeSecond").val("00");
		}

	},


	//화면세팅
    pageStart: function(){


    	//-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",
    		width:740,
    		 mediaQuery: {
                 mx:{min:0, max:767}, dx:{min:767}
             },
    		displayLoading:true,
            scrollLock: true,
            contentDivClass: "popup_outline"
    	});

    	myBusinessModal.setConfig({
    		windowID:"myModalCT2",
    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: true,
            contentDivClass: "popup_outline",
            onclose : function(){
            	//비즈니스 그룹에 대한 수정이 끝난 경우 selectbox reload
            	fnObj.doSelectBusinessGroup();
            }
    	});

    	myGroupingModal.setConfig({
    		windowID:"myModalCT3",
    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: true,
            onclose : function(){
            }
    	});
    	//-------------------------- 모달창 :E -------------------------

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################



    //비즈니스 그룹추가 팝업이 닫히면 selectbox다시 그려줌.
    doSelectBusinessGroup  : function(businessGrp){
    	var url = contextRoot + "/system/selectBusinessGroupFor.do";
    	var param = {};
    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		$("#businessGroup").html(""); //초기화.
    		$("<option />",{ value : "" , text : "선택"}).appendTo("#businessGroup");
    		for(var i =0 ;i < list.length ;i++){
    			var item = list[i];
    			$("<option />",{ value : item.businessGrpSeq , text : item.businessGrpNm}).appendTo("#businessGroup");
    		}

    		//수정페이지인 경우 비즈니스 그룹 설정.
    		if(businessGrp != null){
    			$("#businessGroup").val(businessGrp);
    		}
    	};

    	commonAjax("POST", url, param, callback);

    },//end  doSelectBusinessGroup


  	//저장 doSave
  	doSave: function(){

		//var list = myGrid2.getList();					//그리드 데이터 리스트


    	var newTargetList = [];

    	for(var i = 0 ; i < targetCompanyList.length ;i++){
    		newTargetList.push("sNb:"+targetCompanyList[i].sNb);
    	}

		//--------------- validation :S ---------------
		var frm = document.myForm;

    	if(isEmpty(frm.businessGroup.value)){			//비즈니스 그룹
    		dialog.push({body:"<b>확인!</b> 비즈니스 그룹을 선택해주세요!", type:"", onConfirm:function(){frm.businessGroup.focus();}});
    		return;
    	}

    	if(isEmpty(frm.companySnb.value)){			//관계사 이름
    		dialog.push({body:"<b>확인!</b> 관계사를 선택해주세요!", type:"", onConfirm:function(){frm.companySnb.focus();}});
    		return;
    	}

    	if($("#groupingOrgYn").is(":checked") && targetCompanyList.length < 1){
    		dialog.push({body:"<b>확인!</b> 관계사 소속회사를 선택해주세요.", type:""});
    		return;
    	}

    	if(isEmpty(frm.orgCode.value)){			//관계사 코드
    		dialog.push({body:"<b>확인!</b> 관계사코드를 입력해주세요!", type:"", onConfirm:function(){frm.orgCode.focus();}});
    		return;
    	}

    	if(orgCodecheck == null || orgCodecheck == ''){
    		dialog.push({body:"<b>확인!</b> 관계사코드를 유효성검사를 해주세요!", type:"", onConfirm:function(){frm.orgCode.focus();}});
    		return;
    	}

    	if($("#domain").val() != "" && !getUrlCheck($("#domain").val())){
            dialog.push({body:"<b>확인!</b> 접속도메인이 URL형식에 맞지않습니다.", type:"", onConfirm:function(){frm.domain.focus();}});
            return;
        }

    	if($("#inputInTimeFirst").val() == "00"){
    		dialog.push({body:"<b>확인!</b> 출근시간을 선택해주세요.", type:""});
    		return;
    	}
		/*
    	var file = frm.inFile.files;
    	if(file != null && file.length > 0){
    		if( file[0].size > 65356){
    			dialog.push({body:"<b>이미지 사이즈가 너무 큽니다.</b>", type:"warning", onConfirm:function(){return;}});
    			return;
    		}else if(file[0].type != "image/png" && file[0].type != 'image/jpeg' && file[0].type != 'image/jpg' && file[0].type != 'image/gif'){
    			dialog.push({body:"<b>.png, .jpeg, .jpg, .gif 파일만 업로드 가능합니다. </b>", type:"warning", onConfirm:function(){return;}});
    			return;
    		}
    	}else{
    		dialog.push({body:"<b>확인!</b> 로고 이미지를 선택해주세요.", type:""});
    		return;
    	}*/

    	if(isEmpty(frm.addr.value)){			//주소
    		dialog.push({body:"<b>확인!</b> 주소를 입력해주세요!", type:"", onConfirm:function(){frm.addr.focus();}});
    		return;
    	}

    	if(isEmpty(frm.projectTitle.value)){
            dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.projectTitle} 타이틀을 입력해주세요!", type:"", onConfirm:function(){frm.projectTitle.focus();}});
            return;
        }

    	if(isEmpty(frm.activityTitle.value)){
            dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.activityTitle} 타이틀을 입력해주세요!", type:"", onConfirm:function(){frm.activityTitle.focus();}});
            return;
        }

    	if(isEmpty(frm.tsTitle.value)){
            dialog.push({body:"<b>확인!</b> 타임시트 타이틀을 입력해주세요!", type:"", onConfirm:function(){frm.tsTitle.focus();}});
            return;
        }

    	if(isEmpty(frm.avalUserCnt.value)){
            dialog.push({body:"<b>확인!</b> 유효사용자 수를 입력해주세요!", type:"", onConfirm:function(){frm.avalUserCnt.focus();}});
            return;
        }

    	var inTime = $("#inputInTimeFirst").val()+":"+ $("#inputInTimeSecond").val();
    	var outTime = $("#inputOutTimeFirst").val()+":"+ $("#inputOutTimeSecond").val();



    	var smsEndTelNo = "";
        if($('#smsEndTelNo_1').val()  != "" && $('#smsEndTelNo_2').val() != "" && $('#smsEndTelNo_3').val() != ""){
        	smsEndTelNo  = $('#smsEndTelNo_1').val()  + "-" + $('#smsEndTelNo_2').val() + "-" + $('#smsEndTelNo_3').val();
        }

        if(smsEndTelNo.is_null() && (!$('#smsEndTelNo_1').val().is_null() || !$('#smsEndTelNo_2').val().is_null() || !$('#smsEndTelNo_3').val().is_null())){
        	dialog.push({body:"<b>확인!</b> SMS발송대표번호를 정확히 입력하세요!", type:"", onConfirm:function(){frm.smsEndTelNo_1.focus();}});
            return;
        }


    	//--------------- validation :E ---------------

    	//저장
    	var url = contextRoot + "/system/setOrgCompanyInfo.do";
    	var param = {

    			companySnb			: frm.companySnb.value, //관계사 s_nb
    			orgCode				: frm.orgCode.value,
    			description	 		: frm.orgDesc.value,
    			businessGroup 		: frm.businessGroup.value,
    			addr				: frm.addr.value,
    			inTime				: inTime,
    			outTime				: outTime,
    			targetCompanyList 	: JSON.stringify(newTargetList),
    			groupingOrgYn  		: $("#groupingOrgYn").is(":checked"),
    			projectUseYn  		: $("input[name=projectUseYn]:checked").val(),
    			approveUseYn        : $("input[name=approveUseYn]:checked").val(),
    			secomeUseYn         : $("input[name=secomeUseYn]:checked").val(),
    			codeMgmtAdminYn 	: frm.codeMgmtAdminYn.value,
    			duringYear 			: 3,
    			useYn 				: $("input[name=useYn]:checked").val(),
    			projectTitle    	: frm.projectTitle.value,
                activityTitle   	: frm.activityTitle.value,
                tsTitle         	: frm.tsTitle.value,
                avalUserCnt     	: frm.avalUserCnt.value,
                domain         		: frm.domain.value,
                smsEndTelNo 		: smsEndTelNo,

             	// 메일연동정보 업데이트
    			mailUseYn			: $("select[name='mailUseYn']").val(),
    			mailServiceName 	: $("select[name='mailServiceName']").val(),
    			mailUrl				: $("#mailUrl").val(),
    			mailApiUrl			: $("#mailApiUrl").val(),
    			mailLinkType		: $("select[name='mailLinkType']").val()
    	};

    	var callback = function(result){

    		var obj = result;
    		$("#overlay").hide();
    		if(obj.resultVal >0){
    			toast.push("성공하였습니다.");
    			location.href= contextRoot+"/system/orgCompanyRegisterList.do";
    		}else if(obj.resultVal == -1){
    			dialog.push({body:"<b>이미지 사이즈가 너무 큽니다.</b>", type:"warning", onConfirm:function(){return;}});
    		}else if(obj.resultVal == -2){
    			dialog.push({body:"<b>.png, .jpeg, .jpg, .gif 파일만 업로드 가능합니다.</b>", type:"warning", onConfirm:function(){return;}});
    		}else{
    			dialog.push({body:"<b>저장도중 오류가 발생하였습니다.</b>", type:"warning", onConfirm:function(){return;}});
    		}

    		$("#fileInputArea").append('<input name="inFile" id="inFile" type="file" class="file_btn_cover"  onchange="fnObj.changeFile();">');

    	};

    	$("#overlay").show();
    	//commonAjaxForFile(file, url, param, callback);
    	commonAjaxForFileCreateForm(url,"","inFile","6","", callback , "",param);

  	},//doSave

  	//수정
  	doUpdate : function(){
		//var list = myGrid2.getList();					//그리드 데이터 리스트

    	var newTargetList = [];
    	for(var i = 0 ; i < targetCompanyList.length ;i++){
    		newTargetList.push("sNb:"+targetCompanyList[i].sNb);
    	}

    	//이전 SNB 정보
    	var oldTargetList = [];
    	for(var i = 0 ;i < oldTargetCompanyList.length ;i++){
    		oldTargetList.push("sNb: "+ oldTargetCompanyList[i].sNb);
    	}

		//--------------- validation :S ---------------
		var frm = document.myForm;


    	if(isEmpty(frm.businessGroup.value)){			//비즈니스 그룹
    		dialog.push({body:"<b>확인!</b> 비즈니스 그룹을 선택해주세요!", type:"", onConfirm:function(){frm.businessGroup.focus();}});
    		return;
    	}

    	if(isEmpty(frm.addr.value)){			//주소
    		dialog.push({body:"<b>확인!</b> 주소를 입력해주세요!", type:"", onConfirm:function(){frm.addr.focus();}});
    		return;
    	}

    	if($("#groupingOrgYn").is(":checked") && targetCompanyList.length < 1){
    		dialog.push({body:"<b>확인!</b> 관계사 소속회사를 선택해주세요.", type:""});
    		return;
    	}

    	if($("#domain").val() != "" && !getUrlCheck($("#domain").val())){
            dialog.push({body:"<b>확인!</b> 접속도메인이 URL형식에 맞지않습니다.", type:"", onConfirm:function(){frm.domain.focus();}});
            return;
        }

    	var inTime = $("#inputInTimeFirst").val()+":"+ $("#inputInTimeSecond").val();
    	var outTime = $("#inputOutTimeFirst").val()+":"+ $("#inputOutTimeSecond").val();

    	if($("#inputInTimeFirst").val() == "00"){
    		dialog.push({body:"<b>확인!</b> 출근시간을 선택해주세요.", type:""});
    		return;
    	}

    	if(isEmpty(frm.projectTitle.value)){
            dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.projectTitle} 타이틀을 입력해주세요!", type:"", onConfirm:function(){frm.projectTitle.focus();}});
            return;
        }

        if(isEmpty(frm.activityTitle.value)){
            dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.activityTitle} 타이틀을 입력해주세요!", type:"", onConfirm:function(){frm.activityTitle.focus();}});
            return;
        }

        if(isEmpty(frm.tsTitle.value)){
            dialog.push({body:"<b>확인!</b> 타임시트 타이틀을 입력해주세요!", type:"", onConfirm:function(){frm.tsTitle.focus();}});
            return;
        }

        if(isEmpty(frm.avalUserCnt.value)){
            dialog.push({body:"<b>확인!</b> 유효사용자 수를 입력해주세요!", type:"", onConfirm:function(){frm.avalUserCnt.focus();}});
            return;
        }

        var smsEndTelNo = "";
        if($('#smsEndTelNo_1').val()  != "" && $('#smsEndTelNo_2').val() != "" && $('#smsEndTelNo_3').val() != ""){
        	smsEndTelNo  = $('#smsEndTelNo_1').val()  + "-" + $('#smsEndTelNo_2').val() + "-" + $('#smsEndTelNo_3').val();
        }

        if(smsEndTelNo.is_null() && (!$('#smsEndTelNo_1').val().is_null() || !$('#smsEndTelNo_2').val().is_null() || !$('#smsEndTelNo_3').val().is_null())){
            dialog.push({body:"<b>확인!</b> SMS발송대표번호를 정확히 입력하세요!", type:"", onConfirm:function(){frm.smsEndTelNo_1.focus();}});
            return;
        }

    	/* var file = frm.inFile.files;
    	if(file != null && file.length > 0){
    		if( file[0].size > 65356){
    			dialog.push({body:"<b>이미지 사이즈가 너무 큽니다.</b>", type:"warning", onConfirm:function(){return;}});
    			return;
    		}else if(file[0].type != "image/png" && file[0].type != 'image/jpeg' && file[0].type != 'image/jpg' && file[0].type != 'image/gif'){
    			dialog.push({body:"<b>.png, .jpeg, .jpg, .gif 파일만 업로드 가능합니다. </b>", type:"warning", onConfirm:function(){return;}});
    			return;
    		}

    	}else{
    		dialog.push({body:"<b>확인!</b> 로고 이미지를 선택해주세요.", type:""});
    		return;
    	} */
    	//--------------- validation :E ---------------

    	//저장
    	var url = contextRoot + "/system/updateOrgCompanyInfo.do";
    	var param = {
    			orgId		 	 : frm.orgId.value, 				//관계사 org_id
    			description	 	 : frm.orgDesc.value,
    			businessGrpSeq 	 : frm.businessGroup.value,
    			orgLogoYn 		 : orgLogoYn,
    			addr			 : frm.addr.value,
    			companySnb 		 : frm.companySnb.value,
    			inTime			 : inTime,
    			outTime			 : outTime,
       			targetCompanyList : JSON.stringify(newTargetList),
       			oldTargetList : JSON.stringify(oldTargetList),
    			groupingOrgYn  	: $("#groupingOrgYn").is(":checked"),
    			projectUseYn  	: $("input[name=projectUseYn]:checked").val(),
    			approveUseYn     : $("input[name=approveUseYn]:checked").val(),
    			secomeUseYn         : $("input[name=secomeUseYn]:checked").val(),
    			codeMgmtAdminYn : frm.codeMgmtAdminYn.value,
    			useYn 			: $("input[name=useYn]:checked").val(),
    			enable			: $("input[name=enable]:checked").val(),
    			// 메일연동정보 업데이트
    			mailUseYn		: $("select[name='mailUseYn']").val(),
    			mailServiceName : $("select[name='mailServiceName']").val(),
    			mailUrl			: $("#mailUrl").val(),
    			mailApiUrl		: $("#mailApiUrl").val(),
    			mailLinkType	: $("select[name='mailLinkType']").val(),
    			projectTitle    : frm.projectTitle.value,
                activityTitle   : frm.activityTitle.value,
                tsTitle         : frm.tsTitle.value,
                avalUserCnt     : frm.avalUserCnt.value,
                domain         	: frm.domain.value,
                smsEndTelNo 	: smsEndTelNo
    	};

    	var callback = function(result){

    		var obj = result;


    		if(obj.resultVal >0){
    			toast.push("성공하였습니다.");
    			location.href= contextRoot+"/system/orgCompanyRegisterList.do";
    		}else if(obj.resultVal == -1){
    			dialog.push({body:"<b>이미지 사이즈가 너무 큽니다.</b>", type:"warning", onConfirm:function(){return;}});
    		}else if(obj.resultVal == -2){
    			dialog.push({body:"<b>.png, .jpeg, .jpg, .gif 파일만 업로드 가능합니다.</b>", type:"warning", onConfirm:function(){return;}});
    		}else{
    			dialog.push({body:"<b>수정도중 오류가 발생하였습니다.</b>", type:"warning", onConfirm:function(){return;}});
    		}

    		$("#fileInputArea").append('<input name="inFile" id="inFile" type="file" class="file_btn_cover"  onchange="fnObj.changeFile();">');

    	};

    	//commonAjaxForFile(file, url, param, callback);
    	commonAjaxForFileCreateForm(url,"","inFile","6","", callback , "",param);
  	},


  	//################# else function :E #################


 /* 	imageFile: function(){
  		$('#inFile').trigger('click');
  	}, */
  	//파일 변경시
  	changeFile: function(){
  		var fileName = $('#inFile').val();

  		if(fileName != ""){
	  		var ind = fileName.lastIndexOf("\\");
	  		var name = fileName.substring(ind+1);
	  		$("#imgName").html(name);

	  		$('#orgImageFileView').hide();		//기존 로고는 안보이도록
  		}
  		if(isEmpty(fileName)){
  			$('#orgImageFile').hide();
  			$('#orgImageFileView').hide();
  			orgLogoYn = 'N';
  		}else{
  			$('#orgImageFile').show();
  			orgLogoYn = 'Y';
  		}
  	},

  	//파일 삭제
  	delImageFile: function(){
  		$('#fileInputArea').html('');
  		$("#imgName").html("");

  		$("#fileInputArea").append('<input name="inFile" id="inFile" type="file" class="file_btn_cover"  onchange="fnObj.changeFile();">');

  		fnObj.changeFile();
  	},

    //비즈니스 그룹 추가 모달 창 보이기
  	addBusinessGroup: function(){
  		var params = {};
    	myBusinessModal.open({
    		url: "../system/addBusinessGroup.do",
    		pars: params,
    		titleBarText: '비즈니스 그룹추가',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: 200,
    		width: 550,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT2').draggable();
  	},

  	//목록으로 이동.
    doList : function(){
    	location.href=contextRoot+"/system/orgCompanyRegisterList.do";
    },

    //관계사 찾는 모달 창 보이기.
    searhOrgPop : function(){

    	var params = {};
    	myModal.open({
    		url: contextRoot +"/system/orgCompanyListPop.do",
    		pars: params,
    		titleBarText: '관계사 회사설정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: 200,
    		width: 650,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    },

    //모달창에서 부모창으로 데이터 전달받는 함수.
    updateValue : function(item){
    	$("#orgName").html(item.cpnNm);
    	$("#companyName").val(item.cpnNm);
    	$("#companySnb").val(item.sNb);
    },

    //관계사 코드 유효성 검사
    checkOrgCode: function(){
    	var frm = document.myForm;
    	var orgCode = $("#orgCode").val();
    	if(orgCode == ""){
    		dialog.push({body:"<b>확인!</b> 관계사 코드를 입력해주세요!", type:"", onConfirm:function(){frm.orgCode.focus();}});
    		return;
    	}

    	//첫문자가 영문인지
    	if(isAlpha(orgCode)){
    		dialog.push({body:"<b>확인!</b> 영문으로 입력해주세요!", type:"", onConfirm:function(){frm.orgCode.focus();}});
    		return;
    	}

    	var url = contextRoot + "/system/checkOrgCompanyCode.do";
    	var param = {
    			orgCode		 : $("#orgCode").val()
    	};

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		if(obj.result == "SUCCESS"){
    			if(obj.resultObject.cnt == 0){
    				alertM("사용가능한 코드입니다.");
    				orgCodecheck = orgCode;
    				$('#orgCode').val(frm.orgCode.value.toUpperCase());
    				return;
    			}else
    				dialog.push({body:"<b>중복된 값입니다.</b>", type:"warning", onConfirm:function(){ $("#orgCode").val(""); return;}});

    		}else{
    			dialog.push({body:"<b>중복된 값입니다.</b>", type:"warning", onConfirm:function(){ $("#orgCode").val(""); return;}});
    		}

    	};

    	commonAjax("POST", url, param, callback);

    },

    //시너지 회사 같은 껍데기만 있는 회사인 경우 - 실질적으로 포함되는 회사들 추가
    searhIncludeCompany : function(){
    	if(!$("#groupingOrgYn").is(":checked")){
    		alertM("Grouping 관계사인 경우에만 추가할 수 있습니다.");
    		return;
    	}

    	var params = {
    				targetOrgId 		: $("#orgId").val(),
    				targetCompanyList 	:  (targetCompanyList.length>0 ? JSON.stringify(targetCompanyList) : '')
    	};

    	myGroupingModal.open({
    		url: contextRoot + "/system/addGroupingCompany.do",
    		pars: params,
    		titleBarText: '관계사 소속회사 설정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: 50,
    		width: 650,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT3').draggable();

    },

    //소속회사 설정 모달에서 결과 받아오기
    getIncludeCompany : function(result){
    	var str ='';
    	targetCompanyList = result;

    	for(var i = 0 ; i < targetCompanyList.length ; i++){
    		var item = targetCompanyList[i];

    		str+='<span class="employee_list2" id="'+item.sNb+'_span">';
        	str+='<span class="fontB">'+item.cpnNm+' </span>';
        	str+='<a onclick="javascript:fnObj.tryDel('+item.sNb+');" class="btn_delete_employee"><em>삭제</em></a>, </span>';

    	}
    	$("#addCompany").html(str);
    },

    //그룹핑 관계사 체크 시
    changeVal : function(){
    	//선택 비활성 시 초기화.
    	if(!$("#groupingOrgYn").is(":checked")){
    		$("#addCompany").html("");
    		$(".containCompnayArea").hide();
    		targetCompanyList = [];
    	}else{
    		$(".containCompnayArea").show();
    	}
    },

    //소속회사 제거
    tryDel : function(sNb){
    	if(confirm("제거하시겠습니까?")){
			for(var i = 0 ;i < targetCompanyList.length ;i++){
				var item = targetCompanyList[i];
				if(sNb == item.sNb){
					targetCompanyList.splice(i,1);
					$("#"+sNb+"_span").remove();
				}
			}
    	}
    },

    //유효여부가 사용안함일때 사용여부도 사용안함으로 바꿔준다
    chkEnable : function(){
    	if($("input[name='enable']:checked").val() == "N"){
    		$("input[name='useYn'][value='N']").prop("checked",true);
    	}
    },

    // 메일 사용여부에 따른 옵션
    changeMailUseYn : function(){
    	if($("select[name='mailUseYn']").val() == "Y"){
    		$('#mailServiceName').prop("disabled", false);
    		$('#mailUrl').prop("disabled", false);
    		$('#mailLinkType').prop("disabled", false);

    	}else{
    		$('#mailServiceName').prop("disabled", true);
    		$('#mailUrl').prop("disabled", true);
    		$('#mailLinkType').prop("disabled", true);
    	}
    },

    // 메일서비스에 따른 옵션
    changeMailServiceName: function(){
    	if($("select[name='mailServiceName']").val() == "etc"){
    		//$('#mailUrl').prop("disabled", false);
    		$('#mailApiUrl').prop("disabled", true);

    	}
    	else{
    		//$('#mailUrl').prop("disabled", true);
    		//$('#mailUrl').val('');
    		$('#mailApiUrl').prop("disabled", false);
    	}
    }



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	if("${mode}" == 'update'){
		$(".con_titleZone h2").html("관계사 수정");
		$(".location .current").html("관계사 수정");
	}

	fnObj.changeMailUseYn();
	fnObj.changeMailServiceName();

	numberFormatForDigitClass();
});
</script>