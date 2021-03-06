<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="/WEB-INF/jsp/common/daumPost.jsp"%>	<%-- 우편번호, 주소검색 --%>
<style>
.star{
    color: #ff6240;
    margin-left: 3px;
    font-weight: bold;
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 11px;
}
</style>
<script type="text/JavaScript" src="<c:url value='/js/process.js?ver=0.1'/>" ></script>
<form name="myForm" method="post">
	<div class="mo_container">
		<table class="tb_basic_left">
	    	<colgroup>
				<col width="100" />
				<col width="290" />
				<col width="110" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="inputLoginId">로그인 ID</label></th>
		 			<td>
		  				<input id="inputLoginId" type="text" name="loginId" readonly="readonly" value="" class="input_b w120px" />
		  				<label><input name="selfId" id="selfId" class="mgl3 mgr3" type="checkbox" onclick="fnObj.selfChkLoginId();"/><span>직접입력</span></label>
		   				<button type="button" id="checkEditId" style="display:none;" class="btn_s_type2 mgl6" onclick="fnObj.doCheckId();return false;"><em class="icon_search">유효검사</em></button>
		   				<input type="hidden" name="userSeq" readonly>
		  			</td>
		 			<th scope="row"><label for="inputUserNo">사번<span class="star">*</span></label></th>
		 			<td bgcolor="#F7F7F7">
		  				<input type="hidden" id="inputEmpNo" name="inputEmpNo">
		  				<c:if test="${mode eq 'new' }">
		  					<input id="inputUserNo" type="text" name="userNo" class="input_b"/>
		  					<button type="button" id="btnLoginIdChk" class="btn_s_type2 mgl6" onclick="fnObj.doUserNoChk();return false;"><em class="icon_search">유효검사</em></button>
		  				</c:if>
		   				<c:if test="${mode eq 'update'}">
		   					<input id="inputUserNo" readonly type="text" name="userNo" class="input_b w120px"  />
		   				</c:if>
		  			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputUserName">이름<span class="star">*</span></label></th>
		 			<td><input id="inputUserName" type="text" name="userName" placeholder="이름을 입력하세요" value="" class="input_b w120px" /></td>
		 			<th scope="row">비밀번호</th>
		 			<td>
		  				<span id="msgDefalutPwd">기본 비밀번호로 세팅됩니다.</span>
		  				<span id="btnInitPwd"></span>
		  				<!-- <button id="btnInitPwd" type="button" class="btn_s_type_g btn_auth" onclick="fnObj.tryInitPwd();"><em class="p_reset">비밀번호 초기화</em></button> -->
		  			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row">채용형태<span class="star">*</span></th>
		 			<td colspan="3" class="vt"><span class="radio_list3" id="empTypeRadioTag"></span></td>
		 		</tr>
				<tr>
					<th scope="row" <c:if test="${mode ne 'new'}">style="display:none;"</c:if>>네트워크 고객</th>
		 			<td colspan="3" <c:if test="${mode ne 'new'}">style="display:none;"</c:if>>
		  				<input type="hidden" id="cusId" name="cusId">
		   				<a href="#;" onclick="fnObj.openCustPopup();return false;" id="cus_id" class="btn_s_type_g" title="관계사명"><em>선택</em></a>
		   				<c:if test="${mode eq 'new'}">
		   				<span class="fontRed">* 미선택시 신규등록됩니다.</span>
		   				<span class="tooltip1"><!-- 도움말 툴팁 -->
							<a href="javascript:showlayer(networkHlep)" class="btn_icon_advice"><em>도움말</em></a>
							<div id="networkHlep" class="tooltip_box" style="display:none;">
								<div class="wrap_autoscroll">
									<span class="intext">
										<h3 class="title">네트워크 고객?</h3>
										<ul class="list_st_dot3 mgb20">
										  	<li class="f11">네트워크 고객 정보에서의 사용자정보</li>
											<li class="f11">이미 고객으로 등록되어진 사용자라면 검색해서 선택</li>
										</ul>
									</span>
									<em class="edge_topright"></em>
									<a href="javascript:showlayer(networkHlep)" class="closebtn_s"><img src="/PASS/images/common/icon_car_tooltip_close.gif" alt="닫기"></a>
								</div>
							</div>
						</span>
		   				<!-- <i id='ttipUserRole' class='axi axi-help2'>&nbsp;</i> -->

		   				</c:if>
		  			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="Org_cp">권한설정<span class="star">*</span></label></th>
		 			<td colspan="3">
		  				<input type="hidden" id="orgComId" name="orgComId">
		  				<input type="hidden" id="oriOrgId" name="oriOrgId">
		  				<input type="hidden" id="avalUserCnt" name="avalUserCnt" value="${orgInfo.avalUserCnt}" >
		  				<input type="hidden" id="remainUserCnt" name="remainUserCnt" value="${orgInfo.remainUserCnt}">
		   				<input type="text" onclick="fnObj.openOrgPopup();return false;" class="input_b w150px" id="Org_cp" title="관계사명"  readonly />
		  				<span id="roleSelectArea" style="display: inline;"></span>
		  			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="openCompanyButton">소속회사</label></th>
		 			<td>
		 				<button type="button" class="btn_s_type2 addOnly" onclick="fnObj.openCompany(); return false;" id="openCompanyButton" style="<c:if test="${orgInfo.cnt <= 1}">display:none;</c:if>"><em class="icon_search">선택</em></button>
				   		<span id="AP_CpnNm">${orgInfo.cpnNm}</span>
			   			<input type="hidden" id="AP_CpnSnb" name="cpnSnb" value="${orgInfo.companySnb}">
				   		<input type="hidden" id="ori_AP_CpnSnb" name="oriCpnSnb" value="${orgInfo.companySnb}">
		  			</td>
		 			<th scope="row" rowspan="2"><label for="btnDeptSelect">부서<span class="star">*</span></label></th>
		 			<td>
		  				<button id="btnDeptSelect" type="button" class="btn_s_type2 addOnly mgr10" onclick="fnObj.openDeptPopup();"><em class="icon_search">부서선택</em></button>
		   				<strong class="fontB"><label for="selDeptMain">대표부서</label></strong>
		   				<span id="deptMainSelectTag"></span>
		   			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selRank">직위<span class="star">*</span></label></th>
		 			<td><div id="rankSelectTag"></div></td>
		 			<td class="dotline"><div id="deptInchargeDiv"></div></td>
		 		</tr>
		 		<tr>
	 				<th scope="row"><label for="inputHiredDate">입사일<span class="star">*</span></label></th>
	 				<td><input id="inputHiredDate" type="text" name="hiredDate" placeholder="입사일 입력" onchange="fnObj.chkHire()" value="" class="input_b w120px" /></td>
	 				<th scope="row"><label for="inputJoinDate">정식입사일<span class="star">*</span></label></th>
	 				<td>
	 					<input id="inputJoinDate" type="text" name="joinDate" placeholder="정식입사일 입력"  onchange="fnObj.chkJoin()"  value="" class="input_b w150px" />

	 					<span class="radio_list2 mgl6 addOnly"><label><input name="chkSameHire" id="chkSameHire"  type="checkbox" onclick="fnObj.chkSameHire()"/><span>입사일과동일</span></label></span>
	 				</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="mobileTel1">핸드폰<span class="star">*</span></label></th>
		 			<td>
		 				<select class="sel_phone" id="mobileTel1">
			 				<option value="">선택</option>
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
			 			</select>
			 			<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "mobileTel2" title="핸드폰 중간번호" maxlength="4">
						<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "mobileTel3" title="핸드폰 마지막번호" maxlength="4">
			 		</td>
		 			<th scope="row"><label for="inputEmail">이메일<span class="star">*</span></label></th>
		 			<td><input id="inputEmail" type="text" name="email" placeholder="이메일 입력" value="" class="input_b w100pro" /></td>
		 		</tr>

		 		<tr>
		 			<th scope="row"><label for="companyTel1">내선전화</label></th>
		 			<td>
		 				<select class="sel_phone" id="companyTel1"></select>
		 				<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "companyTel2" title="내선전화 중간번호" maxlength="4">
						<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "companyTel3" title="내선전화 마지막번호" maxlength="4">
		 			</td>
		 			<th scope="row"><label for="companyFaxTel1">회사팩스</label></th>
		 			<td class="last">
		 				<select class="sel_phone" id="companyFaxTel1"></select>
		 				<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "companyFaxTel2" title="팩스 중간번호" maxlength="4">
						<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "companyFaxTel3" title="팩스  마지막번호" maxlength="4">
		 			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row" rowspan="2"><label for="btnZipAddrSearch">집주소</label></th>
		 			<td colspan="3">
		  				<input id="inputHomeZip" type="text" name="homeZip" placeholder="우편번호" value="" class="input_b w120px" readonly title="우편번호" />
		  				<button id="btnZipAddrSearch" type="button" class="btn_s_type2 mgl6 addOnly" onclick="fnObj.searchZipAddr();"><em class="icon_search">주소검색</em></button>
		 			</td>
		 		</tr>
		 		<tr>
		 			<td colspan="3" class="dotline">
		  				<p><input id="inputHomeAddr1" type="text" name="homeAddr1" placeholder="기본주소" value="" class="input_b w100pro" readonly title="주소" /></p>
		  				<p class="mgt5"><input id="inputHomeAddr2" type="text" name="homeAddr2" placeholder="나머지주소를 입력하세요" value="" class="input_b w100pro" readonly title="상세주소" /></p>
		 			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row" rowspan="2"><label for="homeTel1">집전화</label></th>
		 			<td rowspan="2">
		 				<select class="sel_phone" id="homeTel1"></select>
		 				<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "homeTel2" title="집전화 중간번호" maxlength="4">
						<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "homeTel3" title="집전화 마지막번호" maxlength="4">
		 			</td>
		 			<th scope="row" rowspan="2"><label for="inputSosTel">비상연락처</label></th>
		 			<td>
		 				<strong class="fontB"><label for="selSosWho">관계</label></strong><span id="sosWhoSelectTag" class="mgl6"></span>
		 			</td>
		 		</tr>
		 		<tr>
		 			<td class="dotline">
		 				<select class="sel_phone" id="sosTel1"></select>
		 				<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "sosTel2" title="긴급 중간번호" maxlength="4">
						<span class="dashLine">-</span> <input type="text" class="input_phone input_b" id = "sosTel3" title="긴급  마지막번호" maxlength="4">
		 			</td>
		 		</tr>


		 		<tr>
		 			<th scope="row"><label for="userStts">상태</label></th>
		 			<td><!-- <div id="userSttsRadioTag"></div> --><div id="userStts"></div><div id="firedDate"></div></td>
		 			<th scope="row"><label for="inputWork">담당업무</label></th>
		 			<td>
		 				<!-- <input id="inputFiredDate" type="text" name="firedDate" placeholder="퇴사일 입력" value="" class="input_b w100pro" /> -->
		 				<input id="inputWork" type="text" name="userWork" placeholder="담당업무 입력" value="" class="input_b w100pro" />
		 			</td>
		 		</tr>
			</tbody>
		</table>
		<div class="mgt10"><span class="star">* </span><strong>수정</strong>은 경영지원 > 인사정보 메뉴에서 가능합니다.</div>
		<div class="btnZoneBox">
			<a href="javascript:fnObj.doSave();" id="btnSave" class="p_blueblack_btn btn_auth addOnly"><strong>저장</strong></a>
			<a href="javascript:parent.myModal.close();" class="p_withelin_btn">닫기</a>
		</div>
	</div>
</form>




<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드(외,코드)
var comCodeEmpType;					//메뉴타입
var comCodeUserStts;				//채용형태

var comCodeRank //직위 공통코드 (Sync ajax)
var comCodeSosWho;//비상연락처 관계
var comCodeBlood ;
var comCodeBloodRh;
var comCodeReligion; //종교
var myModal = new AXModal();		// instance
var myOrgModal = new AXModal();		//관계사
var myComModal = new AXModal();		//소속회사


var mode = "<c:out value='${mode==null?"new":mode}'/>";			//"new", "update"
var userInfoObj = '${userInfoObj}';			//사용자 정보
var deptInchargeObj = '${deptInchargeObj}';	//사용자 부서(직책)정보
var deptInchargeList = new Array();								//사용자 부서(직책)정보를 객체로 담아두는 배열객체(저장시 서버로 보낸다)
var deptInchargeListDel = new Array();							//사용자 부서(직책)정보를 객체로 담아두는 배열객체(저장시 서버로 보낸다) ... 삭제건
var codeList = "${codeList}";									//기존 등록된 코드 리스트 문자열 ex) 'EAM,SYSTEM,ROL_PER_USER,...'

var orgCode = "${orgInfo.orgCode}";										//관계사 코드
var secomeUseYn = "${orgInfo.secomeUseYn}";								//관계사의 세콤연동여부(등록시 사용자프로필 설정에 사용한다.)
var loginIdValidChk = null;				//유효검사를 통과한 로그인ID
var empNoValidChk = null;				//유효검사를 통과한 사번

var oriLoginId;						//"update" mode 수정전 로그인Id

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드

		comCodeEmpType = getBaseCommonCode('EMP_TYPE', lang, 'CD', 'NM',null,'','',{orgId : "${orgId}" });		//채용형태 공통코드 (Sync ajax)
	 	if(comCodeEmpType == null ){
	 		comCodeEmpType = [{ "CD" : "" , "NM" : "선택"}];
    	}
		comCodeUserStts = getBaseCommonCode('USER_STTS', lang, 'CD', 'NM',null,'','',{orgId : "${orgId}" });		//사용자상태 공통코드 (Sync ajax)
	 	if(comCodeUserStts == null ){
	 		comCodeUserStts = [{ "CD" : "" , "NM" : "선택"}];
    	}
		comCodeRank = getBaseCommonCode('RANK', lang, 'CD', 'NM', '', '선택', 'SELECT',{orgId : "${orgId}" });				//직위 공통코드 (Sync ajax)
		if(comCodeRank == null ){
			comCodeRank = [{ "CD" : "" , "NM" : "선택"}];
    	}
		comCodeSosWho = getBaseCommonCode('SOS_WHO', lang, 'CD', 'NM', '', '선택', 'SELECT',{orgId : "${orgId}" });	//긴급연락망관계 공통코드 (Sync ajax)
		if(comCodeSosWho == null ){
			comCodeSosWho = [{ "CD" : "" , "NM" : "선택"}];
    	}
		/* comCodeBlood = getBaseCommonCode('BLOOD', lang, 'CD', 'NM',null,'','',{orgId : "${orgId}" });			//혈액형 공통코드 (Sync ajax)
		if(comCodeBlood == null ){
			comCodeBlood = [{ "CD" : "" , "NM" : "선택"}];
    	}
		comCodeBloodRh = getBaseCommonCode('BLOOD_RH', lang, 'CD', 'NM', '', '선택', 'SELECT',{orgId : "${orgId}" });		//혈액형RH 공통코드 (Sync ajax)
		if(comCodeBloodRh == null ){
			comCodeBloodRh = [{ "CD" : "" , "NM" : "선택"}];
    	}
		comCodeReligion = getBaseCommonCode('RELIGION', lang, 'CD', 'NM',null,'','',{orgId : "${orgId}" });		//종교 공통코드 (Sync ajax)
		if(comCodeReligion == null ){
			comCodeReligion = [{ "CD" : "" , "NM" : "선택"}];
    	} */

		var empTypeRadioTag = createRadioTag('rdEmpType', comCodeEmpType, 'CD', 'NM', 'REG', '', '');	//radio tag creator 함수 호출 (common.js)
		$("#empTypeRadioTag").html(empTypeRadioTag);
		//var userSttsRadioTag = createRadioTag('rdUserStts', comCodeUserStts, 'CD', 'NM', 'W', 10);	//radio tag creator 함수 호출 (common.js)
		//$("#userSttsRadioTag").html(userSttsRadioTag);
		//var bloodRadioTag = createRadioTag('rdBlood', comCodeBlood, 'CD', 'NM', '', 10);	//radio tag creator 함수 호출 (common.js)
		//$("#bloodRadioTag").html(bloodRadioTag);
		//var religionRadioTag = createRadioTag('rdReligion', comCodeReligion, 'CD', 'NM', '', 10);	//radio tag creator 함수 호출 (common.js)
		//$("#religionRadioTag").html(religionRadioTag);

		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var rankSelectTag = createSelectTag('selRank', comCodeRank, 'CD', 'NM', '', '', colorObj, 120, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#rankSelectTag").html(rankSelectTag);
		var sosWhoSelectTag = createSelectTag('selSosWho', comCodeSosWho, 'CD', 'NM', '', '', colorObj, 120, 'mgl6 select_b');	//select tag creator 함수 호출 (common.js)
		$("#sosWhoSelectTag").html(sosWhoSelectTag);
		//var bloodRhSelectTag = createSelectTag('selBloodRh', comCodeBloodRh, 'CD', 'NM', '', '', colorObj, 50);	//select tag creator 함수 호출 (common.js)
		//$("#bloodRhSelectTag").html(bloodRhSelectTag);



		var telArr = [
						{value :  '02'  , nm : '02'},
		              	{value :  '031' , nm : '031'},
		              	{value :  '032' , nm : '032'},
		              	{value :  '033' , nm : '033'},
		              	{value :  '041' , nm : '041'},
		              	{value :  '042' , nm : '042'},
		              	{value :  '043' , nm : '043'},
		              	{value :  '044' , nm : '044'},
		              	{value :  '049' , nm : '049'},
		              	{value :  '051' , nm : '051'},
		              	{value :  '052' , nm : '052'},
		              	{value :  '053' , nm : '053'},
		              	{value :  '054' , nm : '054'},
		            	{value :  '055' , nm : '055'},
		            	{value :  '061' , nm : '061'},
		            	{value :  '062' , nm : '062'},
		            	{value :  '063' , nm : '063'},
		            	{value :  '070' , nm : '070'},

		];

		var str = '<option value="">선택</option>';
		for(var i=0;i<telArr.length;i++){
			str+='<option value="'+telArr[i].value+'">'+telArr[i].nm+'</option>';
		}

		$("#homeTel1").html(str);
		$("#companyTel1").html(str);
		$("#companyFaxTel1").html(str);

		str+='<option value="010">010</option>';
		str+='<option value="011">011</option>';
		str+='<option value="016">016</option>';
		str+='<option value="017">017</option>';
		str+='<option value="018">018</option>';
		str+='<option value="019">019</option>';

		$("#sosTel1").html(str);


	},


	//화면세팅
    pageStart: function(){

    	//--------- date field :S -----------
		//$("#inputMarriedDate").bindDate();		//결혼일		//위에 input tag 로 만들어준다음에 calendar bind
		//$("#inputMarriedDate").val(new Date().yyyy_mm_dd());
		//$("#inputFiredDate").bindDate();		//퇴사일
		$("#inputHiredDate").bindDate();		//입사일
		$("#inputJoinDate").bindDate();			//정식입사일
		//--------- date field :E -----------

		//--------- phone field :S ----------
		/* $("#inputCompanyTel").bindPattern({pattern: "phone"});
		$("#inputCompanyFax").bindPattern({pattern: "phone"});
		$("#inputHomeTel").bindPattern({pattern: "phone"});
		$("#inputMobileTel").bindPattern({pattern: "phone"});
		$("#inputSosTel").bindPattern({pattern: "phone"}); */

		/* $(".phoneArea").keyup(function(){
			var str = phoneFormatDash($(this).val());
			$(this).val(str);
		}).change(function(){
			var str = phoneFormatDash($(this).val());
			$(this).val(str);
		});
 */




		//--------- phone field :E ----------


		//신규등록 & 수정 모드에 따른 화면세팅
		if(mode=="new"){			//신규등록

			//비밀번호 초기화 버튼 display 여부 & 문구
			$("#btnInitPwd").hide();		//비밀번호 초기화 버튼
			$("#msgDefalutPwd").show();		//문구(기본비밀번호세팅 관련 문구)

		}else{	//mode=="update"	//수정

			//비밀번호 초기화 버튼 display 여부 & 문구
			$("#btnInitPwd").show();
			$("#msgDefalutPwd").hide();

		}



		//-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",
    		//openModalID:"kkkkk",
    		width:850,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:false,
            scrollLock: true,
    		onclose: function(){
    			//toast.push("모달 close");

				//if(window[myModal.winID].isSaved == false){		//저장을 안한상태로 창이 닫힐때, 이미 업로드한 파일은 삭제
    			//	window[myModal.winID].fnObj.deleteFile();	//팝업창 내 파일삭제함수 호출.
    			//}
    		}
            ,contentDivClass: "popup_outline"
    	});

		//소속관계사
    	myOrgModal.setConfig({
    		windowID:"myModalCT2",
    		width:850,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:false,
            scrollLock: true,
    		onclose: function(){
    			//toast.push("모달 close");

				//if(window[myModal.winID].isSaved == false){		//저장을 안한상태로 창이 닫힐때, 이미 업로드한 파일은 삭제
    			//	window[myModal.winID].fnObj.deleteFile();	//팝업창 내 파일삭제함수 호출.
    			//}
    		}
            ,contentDivClass: "popup_outline"
    	});

    	//소속회사
    	myComModal.setConfig({
    		windowID:"myModalCT3",
    		width:850,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
            displayLoading:false,
            scrollLock: true,
    		onclose: function(){
    			//toast.push("모달 close");

				//if(window[myModal.winID].isSaved == false){		//저장을 안한상태로 창이 닫힐때, 이미 업로드한 파일은 삭제
    			//	window[myModal.winID].fnObj.deleteFile();	//팝업창 내 파일삭제함수 호출.
    			//}
    		}
            ,contentDivClass: "popup_outline"
    	});
    	//-------------------------- 모달창 :E -------------------------

    },//end pageStart.

  	//################# init function :E #################


    //################# else function :S #################

  	//저장
    doSave: function(){

    	//-------------------- validation :S --------------------
    	var frm = document.myForm;

    	var mobileTel =  $("#mobileTel1").val()+'-'+$("#mobileTel2").val()+'-'+$("#mobileTel3").val();
    	var homeTel =  '';
    	var companyTel = '';
    	var sosTel =  '';
    	var companyFaxTel =  '';


	    if(mode == "new" && frm.avalUserCnt.value != 0 && frm.remainUserCnt.value <= 0){
	    	dialog.push({body:"<b>확인!</b> 등록가능한 유효 사용자수를 초과하여 신규직원을 등록할 수 없습니다!", type:"", onConfirm:function(){frm.orgComId.focus();}});
	    	return;
	    }

    	if(isEmpty(frm.userNo.value)){			//사번
    		dialog.push({body:"<b>확인!</b> 사번을 입력해주세요!", type:"", onConfirm:function(){frm.userNo.focus();}});
    		return;
    	}


    	if(mode == "new"){									//신규일때는 유효성 체크
    		if(empNoValidChk != frm.userNo.value){		//사번번호가가 유효성체크를 통과한 사번인지..
        		dialog.push({body:"<b>확인!</b> 사번 유효성 검사를 실행해주세요!", type:"", onConfirm:function(){}});
        		return;
        	}

    	}

    	if(isEmpty(frm.inputLoginId.value)){			//로그인ID
    		dialog.push({body:"<b>확인!</b> 로그인ID를 입력해주세요!", type:"", onConfirm:function(){frm.inputLoginId.focus();}});
    		return;
    	}

    	if(mode == "new"){									//신규일때는 유효성 체크

    		if(loginIdValidChk != frm.inputLoginId.value){		//사번번호가가 유효성체크를 통과한 사번인지..
        		dialog.push({body:"<b>확인!</b> 로그인 아이디 유효성 검사를 실행해주세요!", type:"", onConfirm:function(){}});
        		return;
        	}
    	}

    	if(isEmpty(frm.userName.value)){		//이름
    		dialog.push({body:"<b>확인!</b> 이름을 입력해주세요!", type:"", onConfirm:function(){frm.userName.focus();}});
    		return;
    	}
    	if(isEmpty($('input:radio[name=rdEmpType]:checked').val())){		//채용형태
    		dialog.push({body:"<b>확인!</b> 채용형태를 입력해주세요!", type:"", onConfirm:function(){}});
    		return;
    	}

    	if(isEmpty(frm.cpnSnb.value)){		//소속회사
    		dialog.push({body:"<b>확인!</b> 소속회사를 입력해주세요!", type:"", onConfirm:function(){ return;}});
    		return;
    	}
    	if(isEmpty(frm.orgComId.value)){			//관계사
    		dialog.push({body:"<b>확인!</b> 소속관계사를 입력해주세요!", type:"", onConfirm:function(){frm.orgComId.focus();}});
    		return;
    	}

    	if(isEmpty(frm.selRank.value)){			//직위
    		dialog.push({body:"<b>확인!</b> 직위을 입력해주세요!", type:"", onConfirm:function(){frm.selRank.focus();}});
    		return;
    	}

    	if(isEmpty(frm.selUserRole.value)){		//권한
    		dialog.push({body:"<b>확인!</b> 권한을 선택해주세요!", type:"", onConfirm:function(){frm.selUserRole.focus();}});
    		return;
    	}

    	//alert(JSON.stringify(deptInchargeList));
    	if(deptInchargeList.length>0 && isEmpty(deptInchargeList[0].deptId)){
    		deptInchargeList.remove(0);		//'선택' 삭제
    	}
    	if(deptInchargeList.length == 0){
    		dialog.push({body:"<b>확인!</b> 부서를 입력해주세요!", type:"", onConfirm:function(){}});
    		return;
    	}
    	if(isEmpty(frm.selDeptMain.value)){		//대표부서
    		dialog.push({body:"<b>확인!</b> 대표부서를 입력해주세요!", type:"", onConfirm:function(){frm.selDeptMain.focus();}});
    		return;
    	}

    	if(isEmpty(frm.hiredDate.value)){		//입사일
    		dialog.push({body:"<b>확인!</b> 입사일을 입력해주세요!", type:"", onConfirm:function(){frm.hiredDate.focus();}});
    		return;
    	}

    	if(isEmpty(frm.joinDate.value)){		//정식입사일
    		dialog.push({body:"<b>확인!</b> 정식입사일을 입력해주세요!", type:"", onConfirm:function(){frm.joinDate.focus();}});
    		return;
    	}

    	if(isEmpty($("#mobileTel1").val()) || isEmpty($("#mobileTel2").val()) || isEmpty($("#mobileTel3").val())){		//핸드폰
    		dialog.push({body:"<b>확인!</b> 핸드폰을 입력해주세요!", type:"", onConfirm:function(){$("#mobileTel1").val();}});
    		return;
    	}

    	//내선전화
    	if($("#companyTel1").val()!=""||$("#companyTel2").val()!=""||$("#companyTel3").val()!=""){
    		companyTel=$("#companyTel1").val()+"-"+$("#companyTel2").val()+"-"+$("#companyTel3").val();

    		if(!isPhoneNumber(companyTel)){
    			alert("내선전화 형식에 맞지 않습니다.");
    			$("#companyTel1").focus();
    			return;
    		}
    	}

    	//집전화
    	if($("#homeTel1").val()!=""||$("#homeTel2").val()!=""||$("#homeTel3").val()!=""){
    		homeTel=$("#homeTel1").val()+"-"+$("#homeTel2").val()+"-"+$("#homeTel3").val();

    		if(!isPhoneNumber(homeTel)){
    			alert("집전화 형식에 맞지 않습니다.");
    			$("#homeTel1").focus();
    			return;
    		}
    	}

    	//팩스
    	if($("#companyFaxTel1").val()!=""||$("#companyFaxTel2").val()!=""||$("#companyFaxTel3").val()!=""){
    		companyFaxTel=$("#companyFaxTel1").val()+"-"+$("#companyFaxTel2").val()+"-"+$("#companyFaxTel3").val();

    		if(!isMobileNumber(companyFaxTel)){
    			alert("팩스 형식에 맞지 않습니다.");
    			$("#companyFaxTel1").focus();
    			return;
    		}
    	}

    	//긴급전화
    	if($("#sosTel1").val()!=""||$("#sosTel2").val()!=""||$("#sosTel3").val()!=""){
    		sosTel= $("#sosTel1").val()+"-"+$("#sosTel2").val()+"-"+$("#sosTel3").val();

    		if(!isPhoneNumber(sosTel)){
    			alert("긴급전화 형식에 맞지 않습니다.");
    			$("#sosTel1").focus();
    			return;
    		}
    	}



    	if(isEmpty(frm.email.value)){			//이메일
    		dialog.push({body:"<b>확인!</b> 이메일을 입력해주세요!", type:"", onConfirm:function(){frm.email.focus();}});
    		return;
    	}

    	if(!isEmail(frm.email.value)){			//이메일
    		dialog.push({body:"<b>확인!</b> 이메일 형식에 맞지 않습니다!", type:"", onConfirm:function(){frm.email.focus();}});
    		return;
    	}
    	/* if(isEmpty(frm.sosTel.value)){		//비상연락처
    		dialog.push({body:"<b>확인!</b> 비상연락처를 입력해주세요!", type:"", onConfirm:function(){frm.sosTel.focus();}});
    		return;
    	}   */

    	if(!isEmpty(sosTel) && isEmpty(frm.selSosWho.value)){		//비상연락처 - 관계
    		dialog.push({body:"<b>확인!</b> 비상연락처-관계를 입력해주세요!", type:"", onConfirm:function(){frm.selSosWho.focus();}});
    		return;
    	}
    	/*
    	var userStts = $('input:radio[name=rdUserStts]:checked').val();		//frm.rdUserStts.value;
    	if((userStts=='F' || userStts=='R') && isEmpty(frm.firedDate.value)){		//userStts=='F':퇴사, 'R':해고 일때에는 '퇴사일'을 반드시 등록하도록
    		dialog.push({body:"<b>확인!</b> 퇴사일을 입력해주세요!", type:"", onConfirm:function(){frm.firedDate.focus();}});
    		return;
    	}

    	var isFired = false;												//퇴사일을 입력했지만 퇴사과련 상태값이 아닐때 퇴사 상태로 바꾸고 저장할지 묻는다.
    	if(!isEmpty(frm.firedDate.value) && (userStts!='F' && userStts!='R')){
    		if(confirm('퇴사 처리 하시겠습니까?')){
    			$('input:radio[name=rdUserStts][value=F]').prop('checked', true);
    			isFired = true;		//퇴사처리 의사 확인
    		}
    	}

    	if(!isFired && !isEmpty(frm.firedDate.value)){		//바로 위의 경우에 해당하지 않지만 퇴사 상태인경우 한번 묻는다.
    		if(!confirm('퇴사 처리 하시겠습니까?')){
    			return;										//퇴사처리 아니면 멈추고 끝낸다.
    		}
    	}
 */
    	//-------------------- validation :E --------------------

    	var url = contextRoot + "/user/doSaveUser.do";
    	var param = {
    			mode: mode,													//화면 모드 mode : "new", "update"
    			uId: frm.userSeq.value,										//user sequence key
    			loginId: frm.loginId.value,									//login Id
    			empNo : frm.inputEmpNo.value,								//사번
    			userPwd: frm.userNo.value + '!@',											//기본 비밀번호(신규등록 일때 등록...mode:"new")userName: frm.userName.value,							//이름
    			userName: frm.userName.value,								//이름
    			cusId: $('#cusId').val(),									//고객 id
    			empType: $('input:radio[name=rdEmpType]:checked').val(),	//직원타입
    			//company: frm.selCompany.value,							//소속회사
    			orgId : frm.orgComId.value,									//관계사 아이디
    			oriOrgId : frm.oriOrgId.value,								//기존관계사 아이디
    			company : frm.cpnSnb.value,									//소속회사 snb
    			oriCompany : frm.oriCpnSnb.value,							//원 소속회사 snb
    			rank: frm.selRank.value,									//직위
    			rankNm: frm.selRank.options[frm.selRank.selectedIndex].text,//직위명
    			userRole : frm.selUserRole.value,							//권한
    			deptIncharge: JSON.stringify(deptInchargeList),				//부서(직책) json string
    			deptInchargeDel: JSON.stringify(deptInchargeListDel),		//부서(직책) json string ... 삭제할 건
    			mainDeptId: frm.selDeptMain.value,							//대표부서 id

    			companyTel: companyTel,	//frm.companyTel.value.replace(/-/gi,''),			//회사전화
    			companyFax: companyFaxTel,			//회사팩스
    			homeZip: frm.homeZip.value.replace(/-/gi,''),				//집우편번호
    			homeAddr1: frm.homeAddr1.value,								//집주소1
    			homeAddr2: frm.homeAddr2.value,								//집주소2
    			homeTel: homeTel,											//집전화
    			mobileTel: mobileTel,										//휴대폰
    			email: frm.email.value,										//이메일
    			hiredDate: (frm.hiredDate.value).replace(/-/gi,''),			//입사일
    			joinDate: (frm.joinDate.value).replace(/-/gi,''),			//정식입사일
    			sosTel: sosTel,												//비상연락망
    			sosWho: frm.selSosWho.value,								//비상연락망 관계
    			userWork: frm.userWork.value,								//담당업무
    			userStatus: 'W',											//재직상태
    			secomeUseYn:secomeUseYn										//관계사 세콤연동여부
    			/* blood: $('input:radio[name=rdBlood]:checked').val(),		//혈액형
    			bloodRh: frm.selBloodRh.value,								//혈액형 RH
    			religion: $('input:radio[name=rdReligion]:checked').val(),	//종교 */
    			//passport: frm.passport.value,								//여권번호
    			//marriedDate: frm.marriedDate.value.replace(/-/gi,''),		//결혼일
    			//userStatus: $('input:radio[name=rdUserStts]:checked').val(),//사용자상태
    			//firedDate: frm.firedDate.value.replace(/-/gi,'')			//퇴사일
    	};


    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			parent.fnObj.doSearch();					//목록화면 재조회 호출.
    			parent.myModal.close();						//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("저장OK!");

    		}else{
    			if(cnt == -10){
    				dialog.push({body:"<b>확인!</b> 이미 사용중인 ID가 있습니다.", type:"", onConfirm:function(){}});
            		return;
    			}else if(cnt == -20){
    				dialog.push({body:"<b>확인!</b> 중복된 사번 입니다.", type:"", onConfirm:function(){}});
            		return;
    			}
    		}

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSave


    //유효검사
    doUserNoChk: function(){

    	var frm = document.myForm;

    	var userNo = frm.userNo.value;		//등록하려는 사번


    	//-------------------- validation :S --------------------

    	if(isEmpty(userNo)){
    		dialog.push({body:"<b>확인!</b> 사번을 입력하시기 바랍니다!", type:"", onConfirm:function(){frm.userNo.focus();return;}});
    		return;
    	}

    	//첫문자가 영문인지
    	if(strInNumNEnNotUnder(userNo)){
    		dialog.push({body:"<b>확인!</b> 영문+숫자로만 입력해주세요!", type:"", onConfirm:function(){frm.userNo.focus();return;}});
    		return;
    	}

    	var url = contextRoot + "/user/checkPerSabun.do";
    	var param = {
    			empNo: orgCode+"_"+ userNo,
    			orgId: $("#orgComId").val(),
    			loginId : $("#inputLoginId").val()
    	}

    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var resultObj = obj.resultObject;	//결과

    		if(obj.result == "SUCCESS"){

    			var chk = true;

    			if(resultObj.empNo.cnt<1){
    				if(!$('#selfId').is(':checked') && resultObj.id >0) chk = false;

    			}else chk = false;

    			if(chk){

    				dialog.push({body:"<b>OK!</b> 사용가능한 사번입니다.", type:"", onConfirm:function(){
	    				empNoValidChk = userNo;	//통과한 사번을 저장해둔다.
						var empNo = orgCode+"_"+userNo;
						$("#inputEmpNo").val(empNo);

						//직접 입력아닐때
						if(!$('#selfId').is(':checked')){
							var loginId = orgCode+userNo;
		    				$("#inputLoginId").val(loginId);
		    				loginIdValidChk = loginId;
						}

					}});

    			}else{

    				var str = '';

    				if(resultObj.empNo.cnt>0) str = ' 중복된 사번입니다.';
    				else if(!$('#selfId').is(':checked') && resultObj.id >0) str = ' 이미 사용중인 ID가 있습니다.';

    				dialog.push({body:"<b>확인!</b>"+str, type:"warning", onConfirm:function(){
    					empNoValidChk = null;
						frm.userNo.value = "";

						if(!$('#selfId').is(':checked')){
							loginIdValidChk = null;
							frm.inputLoginId.value = "";
						}
					}});

    			}


    		}else{
    			alertM("유효성 검사 도중 오류가 발생하였습니다.");
    			return;
    		}

    	};

    	commonAjax("POST", url, param, callback);

    	//-------------------- validation :E --------------------


    },


  	//비밀번호 초기화 시도
    tryInitPwd: function(){
    	dialog.push({
		    body:'<b>Caution</b>&nbsp;&nbsp;비밀번호를 초기화 하시겠습니까?', top:0, type:'Caution', buttons:[
                {buttonValue:'확인', buttonClass:'Red', onClick:fnObj.doInitPwd},	//, data:{param:"222"}},	//Red W100
                {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}	//, data:'data2'},
                //{buttonValue:'button3', buttonClass:'Green', onClick:fnObj.btnClick, data:'data3'}
		    ]});
    },

    //비밀번호 초기화
	doInitPwd: function(){

		var frm = document.myForm;

    	var url = contextRoot + "/user/doInitPwd.do";
    	var param = {
    			uId: frm.userSeq.value,
    			userPwd: $('#inputUserNo').val() + '!@'		//'1234'		//초기화 비밀번호
    	};
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){
    			//parent.fnObj.doSearch(parent.curPageNo);	//목록화면 재조회 호출.
    			//parent.myModal.close();						//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("비밀번호 초기화 OK!");
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);

    },


    //사용자정보 가져오기
    getUserInfo: function(){
		var frm = document.myForm;

    	var userInfo = JSON.parse(userInfoObj);	//.replace(/&#034;/gi,'"').replace(/&amp;/gi,'&'));    				//사용자정보 ...객체

    	var userOrgId = userInfo.orgId;


    	var tmpObj = JSON.parse(deptInchargeObj);
    	//var tmpObj = JSON.parse(deptInchargeObj);	//.replace(/&#034;/gi,'"').replace(/&amp;/gi,'&'));
    	if(tmpObj!=null){
    		deptInchargeList = tmpObj;													//부서(직책)정보 ...배열객체
    	}

    	//사용자정보 세팅
		frm.userNo.value = userInfo.showEmpNo;
    	frm.inputEmpNo.value = userInfo.empNo;
		frm.loginId.value = userInfo.loginId;
		frm.userSeq.value= userInfo.userId;
		empNoValidChk = frm.userNo.value;
		loginIdValidChk = frm.loginId.value;

		//관계사 정보 세팅
		frm.orgComId.value = userInfo.orgId;
		frm.oriOrgId.value = userInfo.orgId;
		if(userInfo.orgId != null) $("#Org_cp").val(userInfo.orgNm);

		//소속회사 정보 세팅
		if(userInfo.companyNm != null){
			$("#AP_CpnNm").html(userInfo.companyNm);
			frm.cpnSnb.value = userInfo.company;
		}

		oriLoginId = userInfo.empNo;			//수정 저장시 원래 사번정보와 비교위해저장해둔다.

		frm.userName.value = userInfo.name;

		//고객 cus_id
		if(!isEmpty(userInfo.cusId)){
			$('#cusId').val(userInfo.cusId);		//고객 id
			$('#cus_id').html(userInfo.cusNm);		//고객명
		}

		//frm.rdEmpType.value = userInfo.empType;
		$('input:radio[name=rdEmpType][value="' + userInfo.empType + '"]').prop('checked', true);

		//frm.selCompany.value = (userInfo.company == undefined||userInfo.company == ''?'':userInfo.company);
		frm.selRank.value = userInfo.rank;
		$("#selRank").hide();
		$("#rankSelectTag").append($("#selRank option:selected").text());



		//------- 부서(직책) :S -------
		fnObj.setDeptIncharge();		//부서(직책)표시 함수 호출.
		//------- 부서(직책) :E -------

		//frm.companyTel.value = toPhoneFormat(userInfo.companyTel);
		//frm.companyFax.value = toPhoneFormat(userInfo.companyFax);
		if(!isEmpty(userInfo.homeZip) && userInfo.homeZip !='null') frm.homeZip.value = userInfo.homeZip;
		if(!isEmpty(userInfo.homeAddr1) && userInfo.homeAddr1 !='null') frm.homeAddr1.value = userInfo.homeAddr1;
		if(!isEmpty(userInfo.homeAddr2) && userInfo.homeAddr2 !='null') frm.homeAddr2.value = userInfo.homeAddr2;
		//frm.homeTel.value = toPhoneFormat(userInfo.homeTel);

		if(!isEmpty(userInfo.homeTel)){
			var arr = userInfo.homeTel.split('-');
			$("#homeTel1").val(arr[0]);
			$("#homeTel2").val(arr[1]);
			$("#homeTel3").val(arr[2]);

		}

		if(!isEmpty(userInfo.mobileTel)){
			var arr = userInfo.mobileTel.split('-');
			$("#mobileTel1").val(arr[0]);
			$("#mobileTel2").val(arr[1]);
			$("#mobileTel3").val(arr[2]);

		}

		if(!isEmpty(userInfo.sosTel)){
			var arr = userInfo.sosTel.split('-');
			$("#sosTel1").val(arr[0]);
			$("#sosTel2").val(arr[1]);
			$("#sosTel3").val(arr[2]);

		}

		if(!isEmpty(userInfo.companyTel)){
			var arr = userInfo.companyTel.split('-');
			$("#companyTel1").val(arr[0]);
			$("#companyTel2").val(arr[1]);
			$("#companyTel3").val(arr[2]);

		}

		if(!isEmpty(userInfo.companyFax)){
			var arr = userInfo.companyFax.split('-');
			$("#companyFaxTel1").val(arr[0]);
			$("#companyFaxTel2").val(arr[1]);
			$("#companyFaxTel3").val(arr[2]);

		}


		//frm.mobileTel.value = toPhoneFormat(userInfo.mobileTel);
		frm.email.value = userInfo.email;
		//frm.homepage.value = userInfo.homepage;
		//frm.hobby.value = userInfo.hobby;

		frm.hiredDate.value = (userInfo.hiredDate == undefined?'':userInfo.hiredDate);
		frm.joinDate.value = (userInfo.joinDate == undefined?'':userInfo.joinDate);
		//frm.sosTel.value = toPhoneFormat(userInfo.sosTel);
		//frm.homeTel.value = toPhoneFormat(userInfo.homeTel);
		frm.selSosWho.value = userInfo.sosWho;
		//frm.rdBlood.value = userInfo.blood;
		//$('input:radio[name=rdBlood][value="' + userInfo.blood + '"]').prop('checked', true);
		//frm.selBloodRh.value = userInfo.bloodRh;					//혈액형 RH

		//frm.rdReligion.value = userInfo.religion;
		//$('input:radio[name=rdReligion][value="' + userInfo.religion + '"]').prop('checked', true);
		//frm.passport.value = userInfo.passport;
		//frm.marriedDate.value = (userInfo.marriedDate == undefined?'':userInfo.marriedDate);
		//frm.rdUserStts.value = userInfo.userStatus;
		//$('input:radio[name=rdUserStts][value="' + userInfo.userStatus + '"]').prop('checked', true);
		var userSttsNm = getRowObjectWithValue(comCodeUserStts, 'CD', userInfo.userStatus)['NM'];
		$('#userStts').html(userSttsNm);
		//frm.firedDate.value = (userInfo.firedDate == undefined?'':userInfo.firedDate);
		$('#firedDate').html(userInfo.firedDate == undefined?'':userInfo.firedDate);

		frm.userWork.value = (userInfo.work == 'null' ? '': userInfo.work );		//담당업무

    },//end getArticle


    //부서(직책) 임시삭제
    delDeptIn: function(obj, deptId, incharge){
    	var mainDeptId = $("#selDeptMain").val();
    	if(deptId == mainDeptId){
    		alert("대표부서로 선택된 부서는 삭제할수 없습니다.");
    		return;
    	}
    	for(var i=0; i<deptInchargeList.length; i++){
    		if(deptInchargeList[i].deptId == deptId && deptInchargeList[i].incharge == incharge){
    			deptInchargeList.remove(i);
    			deptInchargeListDel.push({deptId:deptId, incharge:incharge});	//삭제건에 추가
    		}
    	}

    	fnObj.setDeptIncharge();		//sync
    },

    //부서(직책) 표시 (deptInchargeList 내용으로 화면에 표기)
    setDeptIncharge: function(){
		var deptInDiv = document.getElementById('deptInchargeDiv');
		deptInDiv.innerHTML = '';	//초기화

		var mainDeptId = '';		//main dept id

		for(var i=0; i<deptInchargeList.length; i++){
			if(deptInchargeList[i].deptId=='') continue;	//'선택' 은 넘긴다.

			var oSpan = document.createElement('span');
			oSpan.innerText = deptInchargeList[i].deptNm + (deptInchargeList[i].incharge == 'DEPT_MGR'? ' (부서장)':'');

			if(deptInchargeList[i].incharge != 'DEPT_MGR'){
				var oA = document.createElement('a');
				oA.setAttribute('class', 'btn_delete_employee');
				oA.setAttribute('href', 'javascript:fnObj.delDeptIn(this,'+deptInchargeList[i].deptId+',"'+deptInchargeList[i].incharge+'");');
				var oEm = document.createElement('em');
				oEm.innerText = '삭제';
				oA.appendChild(oEm);
				oSpan.appendChild(oA);
			}
			if(i>0){
			var space = document.createElement('span');
			space.innerHTML = ',';
			deptInDiv.appendChild(space);	//부서간 띄우기
			}
			deptInDiv.appendChild(oSpan);

			//대표부서 세팅을 위해 따로 저장해둔다.
			if(deptInchargeList[i].mainYn == 'Y'){
				mainDeptId = deptInchargeList[i].deptId;
			}
		}


		//대표부서
		var colorObj = {};
		/* if(deptInchargeList.length==0 || deptInchargeList[0].deptId!=''){	//선택적으로, 첫번째 선택에 ''(공백) 값의 '선택' option 을 넣어준다.
			deptInchargeList = addToArray(deptInchargeList, 0, {deptId:'',deptNm:'선택'});
		} */
		var deptMainSelectTag = createSelectTag('selDeptMain', deptInchargeList, 'deptId', 'deptNm', mainDeptId, '', colorObj, 140, 'select_b mgl6');	//select tag creator 함수 호출 (common.js)
		$("#deptMainSelectTag").html(deptMainSelectTag);

		$("#inputHiredDate").bindDate();		//입사일
		$("#inputJoinDate").bindDate();			//정식입사일
    },

    //부서(직책) 추가 (* list : 부서(직책) 배열 객체)
    concatDeptInchargeList: function(list){
    	//삭제리스트에 동일한 부서데이터가 있으면 제거
    	for(var i=0; i<list.length; i++){
    		var idx = getRowIndexWithValue(deptInchargeListDel, 'deptId', list[i].deptId);	//같은 부서를 선택했을 경우에는
    		if(idx > -1){
    			deptInchargeListDel.remove(idx);
    		}
    	}

   		//추가
    	for(var i=0; i<list.length; i++){
    		var idx = getRowIndexWithValue(deptInchargeList, 'deptId', list[i].deptId);		//같은 부서를 선택했을 경우에는
    		if(idx > -1){
    			deptInchargeList[idx].incharge = list[i].incharge;							//직책을 바꿔주는 것으로
    			deptInchargeList[idx].inchargeNm = list[i].inchargeNm;						//직책을 바꿔주는 것으로
    		}else{
    			deptInchargeList.push(list[i]);
    		}
    	}


    	fnObj.setDeptIncharge();		//sync
    },

    //사용여부 선택
    selEnableChnged: function(obj){
    	//background-color
    	var styleStr = $("#" + obj.id + " > option[value='" + obj.value + "']").attr('style');
    	$(obj).attr('style', styleStr);
    },


  	//주소검색 팝업
    searchZipAddr: function(){
    	/* var url = "<c:url value='/user/searchZipAddr.do'/>";
    	window.open(url, 'loginPop', 'scrollbars=no width=700 height=670'); */

    	execDaumPostcodePop(function(zip, fullAddr){
    		//console.log('zzzzzzzzzzzzzz' + zip);
    		/* $("#inputHomeZip").val(zip);
    		$("#inputHomeAddr1").val(fullAddr);
    		if($("#inputHomeAddr1").val()!= ""){
    			$("#inputHomeAddr2").prop("readOnly", false);
    		} */
    	});

        $("#inputHomeAddr2").val("");
        $("#inputHomeAddr2").prop("readonly",true);

    },//end writeOpen


    openCompany : function(){
    	//소속회사 팝업
    	if($("#orgComId").val() == ""){
    		alertM("소속관계사를 선택해주세요.");
    		return;
    	}
    	var url = "../user/orgAuthCompanyListPop.do";
    	var params = {
    			targetOrgId : $("#orgComId").val()
    	};
    	myComModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '소속회사 선택',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		//top: 10,
    		width: 600,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT3').draggable();
    },
    //소속회사 선택
    setCompany : function(item){
    	//console.log(item);
    	$("#AP_CpnNm").html(item.cpnNm);
    	$("#AP_CpnSnb").val(item.sNb);
    },
    //소속 관계사 팝업
    openOrgPopup : function(){

    	<c:if test="${mode eq 'update'}">
    	toast.push({body:"관계사 변경은 불가능합니다!", type:"Warning"});
    	return;
    	</c:if>

    	var url = "../user/orgAuthCompanyPop.do";
    	var params = {};
    	myOrgModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '관계사 선택',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		//top: 10,
    		width: 700,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT2').draggable();
    },
    //소속 관계사 선택
    setOrgId : function(item){
    	//console.log(item);
    	$("#Org_cp").val(item.cpnNm);
    	$("#orgComId").val(item.orgId);
    	$("#avalUserCnt").val(item.avalUserCnt);
    	$("#remainUserCnt").val(item.remainUserCnt);
    	orgCode = item.orgCode;
    	fnObj.getRoleList();
    	//시너지가 아닌 일반 회사의 경우
    	if(item.groupingOrgYn == 'N'){
    		$("#AP_CpnNm").html(item.cpnNm);
    		$("#AP_CpnSnb").val(item.companySnb);
    		$("#openCompanyButton").hide();
    	}else{
    		//시너지와 같은 그룹핑 회사인 경우
    		$("#AP_CpnSnb").val("");
    		$("#AP_CpnNm").html("");
    		$("#openCompanyButton").show();
    	}


    	comCodeRank = getBaseCommonCode('RANK', lang, 'CD', 'NM', '', '선택', 'SELECT',{"orgId" : item.orgId });
       	comCodeEmpType = getBaseCommonCode('EMP_TYPE', lang, 'CD', 'NM',null,'','',{"orgId" : item.orgId });		//채용형태 공통코드 (Sync ajax)
       	if(comCodeEmpType == null ){
       		comCodeEmpType = [{ "CD" : "" , "NM" : "선택"}];
    	}
       	comCodeUserStts = getBaseCommonCode('USER_STTS', lang, 'CD', 'NM',null,'','',{"orgId" : item.orgId });		//사용자상태 공통코드 (Sync ajax)
       	if(comCodeUserStts == null ){
       		comCodeUserStts = [{ "CD" : "" , "NM" : "선택"}];
    	}
       	comCodeSosWho = getBaseCommonCode('SOS_WHO', lang, 'CD', 'NM', '', '선택', 'SELECT',{"orgId" : item.orgId });	//긴급연락망관계 공통코드 (Sync ajax)
       	if(comCodeSosWho == null ){
       		comCodeSosWho = [{ "CD" : "" , "NM" : "선택"}];
    	}
       	comCodeBlood = getBaseCommonCode('BLOOD', lang, 'CD', 'NM',null,'','',{"orgId" : item.orgId });			//혈액형 공통코드 (Sync ajax)
       	if(comCodeBlood == null ){
       		comCodeBlood = [{ "CD" : "" , "NM" : "선택"}];
    	}
       	comCodeBloodRh = getBaseCommonCode('BLOOD_RH', lang, 'CD', 'NM', '', '선택', 'SELECT',{"orgId" : item.orgId });		//혈액형RH 공통코드 (Sync ajax)
       	if(comCodeBloodRh == null ){
       		comCodeBloodRh = [{ "CD" : "" , "NM" : "선택"}];
    	}
       	comCodeReligion = getBaseCommonCode('RELIGION', lang, 'CD', 'NM',null,'','',{"orgId" : item.orgId });		//종교 공통코드 (Sync ajax)
      	if(comCodeReligion == null ){
      		comCodeReligion = [{ "CD" : "" , "NM" : "선택"}];
    	}

    	if(comCodeRank == null){
    		comCodeRank = [{ "CD" : "" , "NM" : "선택"}];
    	}else
    		comCodeRank.unshift({ "CD" : "" , "NM" : "선택"});

    	var rankSelectTag = createSelectTag('selRank', comCodeRank, 'CD', 'NM', '', '', {}, 100);	//select tag creator 함수 호출 (common.js)
    	$("#rankSelectTag").html(rankSelectTag);


		var empTypeRadioTag = createRadioTag('rdEmpType', comCodeEmpType, 'CD', 'NM', 'REG', 10);	//radio tag creator 함수 호출 (common.js)
		$("#empTypeRadioTag").html(empTypeRadioTag);
		var userSttsRadioTag = createRadioTag('rdUserStts', comCodeUserStts, 'CD', 'NM', 'W', 10);	//radio tag creator 함수 호출 (common.js)
		$("#userSttsRadioTag").html(userSttsRadioTag);
		var bloodRadioTag = createRadioTag('rdBlood', comCodeBlood, 'CD', 'NM', '', 10);	//radio tag creator 함수 호출 (common.js)
		$("#bloodRadioTag").html(bloodRadioTag);
		var religionRadioTag = createRadioTag('rdReligion', comCodeReligion, 'CD', 'NM', '', 10);	//radio tag creator 함수 호출 (common.js)
		$("#religionRadioTag").html(religionRadioTag);

		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var rankSelectTag = createSelectTag('selRank', comCodeRank, 'CD', 'NM', '', '', colorObj, 100);	//select tag creator 함수 호출 (common.js)
		$("#rankSelectTag").html(rankSelectTag);
		var sosWhoSelectTag = createSelectTag('selSosWho', comCodeSosWho, 'CD', 'NM', '', '', colorObj, 80);	//select tag creator 함수 호출 (common.js)
		$("#sosWhoSelectTag").html(sosWhoSelectTag);
		var bloodRhSelectTag = createSelectTag('selBloodRh', comCodeBloodRh, 'CD', 'NM', '', '', colorObj, 50);	//select tag creator 함수 호출 (common.js)
		$("#bloodRhSelectTag").html(bloodRhSelectTag);

    	//부서 삭제
    	deptInchargeList = new Array();
		deptInchargeListDel = new Array();
    	$("#deptMainSelectTag").html("");
    	$("#deptInchargeDiv").html("");

    	//로그인 아이디 없앰.
    	if(mode == "new"){
    		$("#inputLoginId").val("");
    		$("#inputUserNo").val("");
    		empNoValidChk = null;
    		loginIdValidChk = null;
    	}


    },

    //관계사 권한 리스트 가져오기
    getRoleList : function(){
    	var userInfo = (mode=="update" && userInfoObj.length>0 ? JSON.parse(userInfoObj) : '');
    	var params = {'orgId':$("#orgComId").val() , enable : 'Y'};
		roleIdCombo = getCodeInfo(lang, 'CD', 'NM', '', '선택', 'SELECT', '/system/getRoleCodeCombo.do', params);		//권한코드(콤보용) 호출
		if(roleIdCombo == null){
			roleIdCombo = [{'CD': '', 'NM':'선택'}];
		}
		var htmlStr = createSelectTag('selUserRole', roleIdCombo, 'CD', 'NM', (userInfo != '' ? userInfo.roleId : ''), '', {}, '', 'select_b  w120px' );
		$("#roleSelectArea").html(htmlStr);
    },

    //부서(직책)선택 팝업
    openDeptPopup: function(){
    	if($("#orgComId").val() == ''){
    		dialog.push({body:"<b>경고!</b> 소속관계사를 먼저 선택해주세요!", type:"", onConfirm:function(){}});
    		return;
    	}
    	var url = "<c:url value='/user/selectDeptInchargePopup.do'/>";
    	var params = {
    					deptInchargeList : JSON.stringify(deptInchargeList),
    					orgId : $("#orgComId").val()
    				//	isOnlyOne:'Y'	//검색옵션('Y': 한명, 그외,: 다수(default))
    				};

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '부서 및 직책 선택',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    	//	top: 10,
    		width: 600,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();

    },


  	//인물 검색
 	openCustPopup : function(num){
		var option = "width=930px,height=760px,resizable=yes,scrollbars = yes";
		window.open(contextRoot+"/person/customerListPopup.do", "searchCpnPop" , option);
 	},
 	//정식입사일 입사일과 동일 체크박스 클릭
 	chkSameHire : function(){
 		if($("#chkSameHire").is(":checked")){
 			if($("#inputHiredDate").val()!=""){
 				$("#inputJoinDate").val($("#inputHiredDate").val());
 			}else{
 				alert("입사일을 먼저 입력해 주세요.");
 				$("#chkSameHire").prop("checked",false);
 			}
 		}
 	},
 	//입사일이 변할때 입사동일 체크박스가 체크되어있으면 동기화
 	chkHire : function(){
 		if($("#chkSameHire").prop("checked")){
 			if($("#inputHiredDate").val()!=""){
 				$("#inputJoinDate").val($("#inputHiredDate").val());
 			}else{
 				$("#inputJoinDate").val("");
 				$("#chkSameHire").prop("checked",false);
 			}
 		}
 	},
 	//정식 입사일이 변할때 입사동일 체크박스가 체크되어있으면 동기화
	chkJoin: function(){
		if($("#chkSameHire").prop("checked")){
			if($("#inputHiredDate").val()!= $("#inputJoinDate").val()){
				$("#chkSameHire").prop("checked",false);
			}
		}
	},
	//loginId 직접입력 선택
	selfChkLoginId : function(){

		if($("#selfId").is(':checked')){

			$("#checkEditId").show();
			$("#inputLoginId").attr('readonly',false);

		}else{
			$("#checkEditId").hide();
			$("#inputLoginId").attr('readonly',true);
			if($("#inputUserNo").val() != ''){
				$("#inputLoginId").val(orgCode+$("#inputUserNo").val());
				loginIdValidChk = orgCode+$("#inputUserNo").val();
			}
		}

	},
	//loginId 유효성 검사 및 중복 확인
	doCheckId : function(){

		var frm = document.myForm;

		//validation
		var id = $('#inputLoginId').val();
		if(isEmpty(id) || strInNumNEnNotUnder(id)){
			var str = '';
			if(isEmpty(id)) str ='입력해주세요!';
			else if(strInNumNEnNotUnder(id)) str ='영문+숫자로 입력해주세요!';

			dialog.push({body:"<b>확인!</b> 로그인ID를 "+str, type:"", onConfirm:function(){frm.inputLoginId.focus();}});
			return;
		}

		var url = contextRoot + '/user/chkValidation.do';
		var param = {loginId : id};

		var callback = function(result){
			var obj = JSON.parse(result);
			var resultObj = obj.resultObject;

			if(obj.result == "SUCCESS"){

				if(resultObj > 0){
					dialog.push({body:"<b>확인!</b>이미 사용중인 ID가 있습니다.", type:"", onConfirm:function(){

						loginIdValidChk = null;
						frm.inputLoginId.value = "";
						frm.inputLoginId.focus();

					}});
					return;
				}

				if(resultObj == 0){
					dialog.push({body:"<b>OK!</b> 사용가능한 ID입니다.", type:"", onConfirm:function(){
						loginIdValidChk = id;
						frm.inputLoginId.value = id;
					}});

				}

			}

		};

		commonAjax("POST", url, param, callback, false);

	}

  	//################# else function :E #################

};//end fnObj.


function showlayer(id){
	if(id.style.display == 'none'){id.style.display='block';}
	else{id.style.display = 'none';}
}

//인물 검색 콜백
function cstPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position){
	$('#cus_id').html(cstNm);
	$('#cusId').val(sNb);
}


//우편번호찾기콜백
function fn_postCallCallback(zip, fullAddr){
	$("#inputHomeZip").val(zip);
	$("#inputHomeAddr1").val(fullAddr);
	if($("#inputHomeAddr1").val()!= ""){
		$("#inputHomeAddr2").prop("readOnly", false);
	}
}


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */


$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅

	//수정모드일때 내용가져오기
	if(mode=="update" && userInfoObj.length>0){

		fnObj.getUserInfo();
		fnObj.getRoleList();
		$("input").attr("disabled","disabled");
		$("select").attr("disabled","disabled");
		$("select").css("background","#f3f3f3");


		$(".AXanchorDateHandle").hide();
		$(".addOnly").hide();
		$(".btn_delete_employee").hide();
		$(".btn_delete_employee").next($("<span>,</span>"));

		$(".btn_auth").remove();

	}else{
		var orgId_ = "${orgId}";
		var frm = document.myForm;
		frm.orgComId.value = orgId_;
		if(orgId_ != null){
			frm.orgComId.value = orgId_;
			$("#Org_cp").val("${orgName}");
		}

		fnObj.getRoleList();

	}


});

</script>