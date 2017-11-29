<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="modalWrap2">
	<h1><strong>인사정보</strong></h1>
	<div class="mo_container">
		<!--검색창-->
		<div id="personnelSerach">
			<div class="carSearchBox">
			    <label>
			        <span class="carSearchtitle">직원명</span>
			        <input id="staffNm" name="staffNm" onKeyup="fnObj.checkEnter(event,'emp');" class="input_b2 w180px">
				</label>
				<button type="button" onclick="fnObj.searchEmployee();" class="btn_g_black mgl10">조회</button>
				<label>
				    <span class="carSearchtitle mgl30">직무명</span>
				    <input id="workNm" name="workNm" onKeyup="fnObj.checkEnter(event,'work');" class="input_b2 w180px">
				</label>
				<button type="button" onclick="fnObj.searchWork();" class="btn_g_black mgl10">조회</button>
			</div>
		</div>
		<%-- <div id="personnelSerach">
			<table class="tb_ProfileInfo" summary="고객검색">
				<caption>고객검색</caption>
				<colgroup>
					<col width="80" />
					<col width="*" />
					<col width="80" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" rowspan="2" class="bgGray">
						<label	for="company">직원명</label></th>
						<td><input type="text" id="staffNm" name="staffNm"	 onKeyup="fnObj.checkEnter(event,'emp');"	class="applyinput_B" />
						<a href="javascript:fnObj.searchEmployee()" class="mgl8 s_violet01_btn"><em class="search">조회</em></a></td>
						<th scope="row" rowspan="2" class="bgGray">
						<label	for="company">직무명</label></th>
						<td><input type="text" id="workNm" name="workNm"	 onKeyup="fnObj.checkEnter(event,'work');"	 class="applyinput_B" />
						<a href="javascript:fnObj.searchWork()" class="mgl8 s_violet01_btn"><em class="search">조회</em></a></td>
					</tr>
				</tbody>
			</table>
		</div> --%>
		<!--//검색창//-->
		<!--정보공유(정보입력)-->
		<!--기본정보-->
		<!-- <h2 class="title_arrow mgt20">기본정보</h2> -->
		<table class="tb_search_popup mgt20" summary="기본정보(이름,연락처, 학력사항, 경력사항 )">
			<caption>기본정보</caption>
			<colgroup>
				<col width="150" />
				<col width="80" />
				<col width="80" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<td rowspan="6" class="picpro">
						<!-- <img src="../images/support_m/img_pro_bg.gif" alt="" /> -->
						<c:choose>
							<c:when test="${not empty makeNm }">
								<div class="photo_aspect aspect_3_4" id = "previewId"><img id="prev_previewId" src="<c:url value='/data/${makeNm}' />" /></div>
							</c:when>
							<c:otherwise>
								<div class="photo_aspect aspect_3_4" id = "previewId"></div>
							</c:otherwise>
						</c:choose>
					</td>
					<th rowspan="2" class="bg_skyblue3">이름</th>
					<th class="bg_skyblue2">한글</th>
					<td><span id="userNameKor"></span></td>
				</tr>
				<tr>
					<th class="bg_skyblue2">영문</th>
					<td><span id="userNameEng"></span></td>
				</tr>
				<tr>
					<th rowspan="3" class="bg_skyblue3">연락처</th>
					<th class="bg_skyblue2">휴대폰</th>
					<td><span id="mobileNumber"></span></td>
				</tr>
				<tr>
					<th class="bg_skyblue2">내선번호</th>
					<td><span id="phoneNumber"></span></td>
				</tr>
				<tr>
					<th class="bg_skyblue2">이메일</th>
					<td><p><span id="email"></span></p></td>
				</tr>
				<tr>
					<th class="bg_skyblue3">주소</th>
					<td colspan="2"><span id="address"></span></td>
				</tr>
			</tbody>
		</table>
		<!--//기본정보//-->
		<!--직무정보-->
		<h3 class="h3_title_basic mgt20">직무정보</h3>
		<table class="tb_search_popup" summary="직무정보(소속관계사, 소속회사, 소속부서, 직위, 채용형태, 담당업무, 입사일, 정직원발령일)">
			<caption>직무정보</caption>
			<colgroup>
				<col width="130">
				<col width="*">
				<col width="130">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="bg_skyblue3">소속관계사</th>
					<td><span id="orgNm"></span></td>
					<th scope="row" class="bg_skyblue3">소속회사</th>
					<td><span id="companyNm"></span></td>
				</tr>
				<tr>
					<th scope="row" class="bg_skyblue3">소속부서</th>
					<td colspan="3" id="deptNm"></td>
				</tr>
				<tr>
					<th scope="row" class="bg_skyblue3">직위</th>
					<td><span id="rankNm"></span> <span class="rank_txt_color">(최종수정일 :
							<span id="promotionDt"></span>)</span></td>
					<th scope="row" class="bg_skyblue3">채용형태</th>
					<td><span id="empTypeNm"></span><span class="rank_txt"><span id="userStatusNm"></span></span></td>
				</tr>
				<tr>
					<th scope="row" class="bg_skyblue3">담당업무</th>
					<td colspan="3"><span id="workStr"></span></td>
				</tr>
				<tr>
					<th scope="row" class="bg_skyblue3">입사일</th>
					<td><span class="period_nb" id="joinDate"></span></td>
					<th scope="row" class="bg_skyblue3">정직원발령일</th>
					<td><span class="period_nb" id="hireDate"></span></td>
				</tr>
			</tbody>
		</table>
		<!--//직무정보//-->
		<!--학력사항-->
		<%-- <h3 class="h3_title_basic mgt20">학력사항</h3>
		<table class="tb_search_popup" summary="학력사항(재학기간, 학교명, 전공, 구분)">
			<caption>학력사항</caption>
			<thead>
				<tr>
					<th class="bg_skyblue3" scope="col"><strong>재학기간</strong></th>
					<th class="bg_skyblue3" scope="col"><strong>학교명</strong></th>
					<th class="bg_skyblue3" scope="col"><strong>전공</strong></th>
					<th class="bg_skyblue3" scope="col"><strong>구분</strong></th>
				</tr>
			</thead>
			<tbody id="academicTbody">
			</tbody>
		</table>
		<!--//학력사항//-->
		<!--경력기간-->
		<h3 class="h3_title_basic mgt20">경력사항</h3>
		<table class="tb_search_popup " summary="경력사항 (근무기간, 회사명, 직위, 직무분)">
			<caption>학력사항</caption>
			<thead>
				<tr>
					<th class="bg_skyblue3" scope="col"><strong>근무기간</strong></th>
					<th class="bg_skyblue3" scope="col"><strong>회사명</strong></th>
					<th class="bg_skyblue3" scope="col"><strong>직위</strong></th>
				</tr>
			</thead>
			<tbody id="careerTbody">
			</tbody>
		</table> --%>
		<!--//경력기간//-->

		<!--버튼모음-->
		<div class="btnZoneBox">
			<a href="javascript:fnObj.doClose();" class="p_withelin_btn">닫기</a>
		</div>
		<!--//버튼모음//-->

		<!-- 검색 시 사용 -->
		<form id="frm" name="frm">
			<input type="hidden" name="type" id="type">
			<input type="hidden" name="userName" id="userName">
			<input type="hidden" name="workStr" id="workStr">
		</form>
<script>
var userId ="${userId}";
var fnObj = {
	 preLoad: function(){

		  var url = contextRoot+ "/basic/selectListUserPopForOrg.do";
	 	  var param = {
	 			userId: userId
	 	  };

	 		var callback = function(result){
	 			var obj = JSON.parse(result);
	 			//console.log(obj);
	 			//사용자 상세정보
	 			var userDetail = obj.resultObject.userDetail;
	 			var userCareer = obj.resultObject.userCareer;
	 			var userAcademic = obj.resultObject.userAcademic;
	 			var userDeptList = obj.resultObject.userDeptList;
	 			var photoMap = obj.resultObject.photoMap;

	 			$("#userNameKor").html(userDetail.name);
	 			$("#userNameEng").html(userDetail.engNm);
	 			$("#phoneNumber").html(userDetail.homTel);
	 			$("#mobileNumber").html(userDetail.mobileTel);
	 			$("#email").html(userDetail.email);
	 			$("#address").html('${baseUserLoginInfo.orgId}' != userDetail.orgId ? '*****' : (userDetail.homeAddr1 + userDetail.homeAddr2));

	 			$("#companyNm").html(userDetail.companyNm);
	 			$("#orgNm").html(userDetail.orgNm);
	 			$("#rankNm").html(userDetail.rankNm);
	 			if('${baseUserLoginInfo.orgId}' == userDetail.orgId) $("#userStatusNm").html('('+userDetail.userStatusNm+')');

	 			$("#empTypeNm").html('${baseUserLoginInfo.orgId}' != userDetail.orgId ? '*****': userDetail.empTypeNm);

	 			$("#joinDate").html('${baseUserLoginInfo.orgId}' != userDetail.orgId ? '*****' : userDetail.joinDate);
	 			$("#hireDate").html('${baseUserLoginInfo.orgId}' != userDetail.orgId ? '*****' : userDetail.hiredDate);

	 			$("#promotionDt").html(userDetail.promotionDt);
	 			$("#workStr").html(userDetail.work);

	 			if(userDetail.imgNm != ''){
	 				$(".picpro").html('<img id="prev_previewId" style="width: 150px;height: 200px;" src="/imgUpLoadData/'+userDetail.imgNm +'" />');
	 			}else{
	 				$(".picpro").html('<img	src="../images/support_m/img_pro_bg.gif" alt="" />');
	 			}

	 			//부서 처리
	 			var mainDept = "";
	 			var managerYn = "";
	 			var deptlist = "";
	 			for(var i = 0 ;i < userDeptList.length ;i++){
	 				var userDeptList_ = userDeptList[i];
	 				if(userDeptList_.mainYn == "Y"){
	 					//대표부서 처리
	 					mainDept = userDeptList_.deptNm;
	 				}else{
	 					if(deptlist != ""){
	 						deptlist += ",";
	 					}
	 					deptlist += userDeptList_.deptNm;
	 				}
	 				if(userDeptList_.isManager == "Y"){
	 					//부서장 처리
	 					managerYn = "(부서장)";
	 				}
	 			}
	 			var html = '<span class="team_txt_bold">'+mainDept+'</span>';
	 			html += '<span class="rank_txt_color" id="deptManage">'+ managerYn +'</span>';
	 			html += deptlist;
	 			$("#deptNm").html(html);

	 			//학력사항
	 			/* var academicHtml = "";
	 			if(userAcademic != null && userAcademic.length > 0){
		 			for(var i =0 ; i < userAcademic.length ;i++){
		 				var userAcademic_ = userAcademic[i];
		 				academicHtml += '<tr>';
		 				academicHtml += '<td><span class="period_nb">'+ userAcademic_.enteredDt +' ~ '+ userAcademic_.graduateDt +'</span></td>';
		 				academicHtml += '<td class="left_txt">'+ userAcademic_.academicNm +'</td>';
		 				academicHtml += '<td>'+userAcademic_.major+'</td>';
		 				academicHtml += '<td>'+ userAcademic_.graduateTypeNm+ '</td>';
		 				academicHtml += '</tr>';
		 			}
	 			}else{
	 				academicHtml = '<tr><td colspan="4" class="no_result"><p class="nr_des">입력된 학력사항이 없습니다.</p></td></tr>';
	 			}
	 			$("#academicTbody").append(academicHtml); */

	 			//경력사항
	 		/* 	var careerHtml = "";
	 			if(userCareer != null && userCareer.length > 0){
		 			for(var i = 0 ;i < userCareer.length ; i++){
		 				var userCareer_ = userCareer[i];
		 				careerHtml += '<tr><td>';
		 				careerHtml += '<span class="period_nb">'+ userCareer_.joinCpnDt +' ~ '+ userCareer_.resignCpnDt +'</span></td>';
		 				careerHtml += '<td class="left_txt">'+ userCareer_.cpnNm+'</td>';
		 				careerHtml += '<td>'+ userCareer_.rankNm+'</td>';
						careerHtml += '</tr>';
		 			}
		 		}else{
		 			careerHtml = '<tr><td colspan="3" class="no_result"><p class="nr_des">입력된 경력 사항이 없습니다.</p></td></tr>';
	 			}
	 			$("#careerTbody").append(careerHtml); */
	 		}
	 		commonAjax("POST", url, param, callback);
	 }
	 //직원 명 조회
	, searchEmployee: function(){
		var staffNm = $("#staffNm").val();
		var url = contextRoot +"/basic/searchStaffNmWorkPop.do";
		var frm = document.frm;
		frm.action = url;
		frm.method = "post";
		frm.userName.value = staffNm;
		frm.type.value = "1";
		frm.submit();

	}
	//직무명 조회
	, searchWork : function(){
		var workNm = $("#workNm").val();
		var url = contextRoot +"/basic/searchStaffNmWorkPop.do";

		var frm = document.frm;
		frm.action = url;
		frm.method = "post";
		frm.workStr.value = workNm;
		frm.type.value = "2";
		frm.submit();
	}
	//enter 클릭 여부
	, checkEnter : function(e, type){
		if(e.keyCode == 13){
			if(type == 'emp'){
				fnObj.searchEmployee();
			}else{
				fnObj.searchWork();
			}
		}else
			return;
	}
	//닫기
	,doClose : function(){
		window.close();
	}
};

$(function(){
	fnObj.preLoad();
})
</script>

