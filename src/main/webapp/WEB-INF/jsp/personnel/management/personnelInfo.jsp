<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="customTagUi" uri="/WEB-INF/tlds/ui.tld"%>

<%@ include file="/WEB-INF/jsp/common/daumPost.jsp"%>
<%@ include file="./js/personnelInfo_JS.jsp"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script src="${pageContext.request.contextPath}/js/sp/monthPicker.min.js"></script>
<!-- 진급 템플릿 -->
<script type="text" id = "rankTmpl">
	<tr>
		<td class="txt_center">
			<input type="text"  class="input_b input_date_type" name = "promotionDt" value="" placeholder="진급날짜" title="진급날짜입력" />
		<td>
			<div id="rankNew" name="rankNew">
			</div>
		</td>
		<td><input type="text"  class="input_b w100pro" name = "memo" placeholder="진급사유입력" title="진급사유입력" /></td>
		<td class="txt_center">
			<a href="#this" onclick="deleteRank($(this))" class="btn_ac_delete" <c:if test = "${fn:length(userInsideCareer)<=0 }">style="display:none"</c:if>><em>삭제</em></a>
		</td>
	</tr>
</script>
<!-- 가족 템플릿 -->
<script type="text" id = "familyTmpl">
<tr>
	<td>
		<div id="relationNew" name= 'relationNew'>
		</div>
	</td>
	<td><input type="text"  class="input_b w100pro" name="familyNm" placeholder="이름입력" title="가족이름입력" /></td>
	<td class="txt_center">
		<input type="text"  class="input_b input_date_type" name="birthDt" placeholder="생년월일" title="가족생년월일입력" />
	</td>
	<td><input class="input_b w100pro" name="job" placeholder="직업입력" title="가족직업입력" /></td>
	<td class="txt_center">
		<select name = "liveinYn" class="select_b w100pro">
			<option value="">선택</option>
			<option value="Y">동거</option>
			<option value="N">비동거</option>
		</select>
	</td>
	<td class="txt_center">
		<a href="#this" onclick="addFamily()" class="btn_ac_add"><em>추가</em></a>
		<a href="#this" onclick="deleteFamily($(this))" class="btn_ac_delete"><em>삭제</em></a>
	</td>
</tr>


</script>
<!-- 학력 템플릿 -->
<script type="text" id = "academicTmpl">
<tr>
	<td class="txt_center">
		<input type="text"  class="input_b input_date_type" name="enteredDt" placeholder="입학년월" title="입학년월" />
		<span class="dashLine">~</span>
		<input type="text"  class="input_b input_date_type" name="graduateDt" placeholder="졸업년월" title="졸업년월" />
	</td>
	<td>
		<input type="text"  class="input_b w_100px mgr6" id = "academicNm" name = "academicNm" placeholder="학교명입력" title="학교명입력" />
		<span id = "schoolTypeArea" name = "schoolTypeArea">

		</span>

	</td>
	<td><input type="text"  class="input_b w100pro" id="major" name = "major" placeholder="전공학과입력" title="전공학과입력" /></td>
	<td>
		<div id = "graduateTypeArea" name = "graduateTypeArea">
		</div>

	</td>
	<td class="txt_center">
		<a href="#this" onclick="addAcademic()" class="btn_ac_add" ><em>추가</em></a>
		<a href="#this" onclick="deleteAcademic($(this))" class="btn_ac_delete"><em>삭제</em></a>
	</td>
</tr>
</script>
<!-- 경력 템플릿 -->
<script type="text" id = "careerTmpl">
<tr>
	<td class="txt_center">
		<input type="text" name="joinCpnDt" class="input_b input_date_type" title="입사일" />
		<span class="dashLine"> ~ </span>
		<input type="text"  name="resignCpnDt" class="input_b input_date_type" title="퇴사일" />
	</td>
	<td><input type="text"  class="input_b w100pro" name = "companyNm" placeholder="회사명입력" title="회사명입력" /></td>
	<td>
		<div id = "careerRankArea" name = "careerRankArea">

		</div>
	</td>
	<td><input type="text"  class="input_b w100pro" name = "careerJob" placeholder="직무입력" title="직무입력" /></td>
	<td class="txt_center">
		<a href="#this" class="btn_ac_add" onclick="addCareer()"><em>추가</em></a>
		<a href="#this" class="btn_ac_delete" onclick="deleteCareer($(this))"><em>삭제</em></a>
	</td>
</tr>
</script>
<!-- 자격증 템플릿 -->
<script type="text" id = "licenseTmpl">
<tr>
	<td><input type="text" class="input_b w100pro" name="licenseNm" placeholder="자격증/면허증입력" title="자격증/면허증입력" /></td>
	<td><input type="text" class="input_b w100pro" name = "issue"  placeholder="발행처/기관입력" title="발행처/기관입력" /></td>
	<td class="txt_center">
		<input type="text" class="input_b input_date_type" name="obtainDt" placeholder="취득일자" title="취득일자입력" />
	</td>
	<td class="txt_center">
		<a href="#this" class="btn_ac_add" onclick="addLicense()"><em>추가</em></a>
		<a href="#this" class="btn_ac_delete" onclick="deleteLicense($(this))"><em>삭제</em></a>
	</td>
</tr>
</script>
<!-- 재직상태 템플릿 -->
<script type="text" id = "sttsTmpl">
<tr>
	<td class="txt_center">
		<select class="select_b " name = "userStatus" id = "userStatus_${data.sNb}" title="직위선택">
		</select>
	<td>
		<input type="text" class="input_b input_date_type mgl6" name = "sttsFromDt" value="${data.sttsFromDt}" title="시작일" />
		<span class="dashLine">~</span>
	<div id = "sttsEndDtArea" style="display: inline;">
		<input type="text" class="input_b input_date_type mgl6" name = "sttsEndDt" value="${data.sttsEndDt}" title="종료일" />
	</div>

	</td>
	<td><input type="text" class="input_b w100pro" name="sttsMemo" value="${data.memo}"  placeholder="사유입력" title="사유입력" /></td>
	<td class="txt_center">
		<a href="#this" onclick="addStts()" class="btn_ac_add"><em>추가</em></a>
	</td>
</tr>
</script>
<section id="detail_contents">
<form id = "frm" name = "frm" method="post" enctype="multipart/form-data">
<div class="doc_AllWrap">
	<h3 class="h3_title_basic">기본정보</h3>
	<!--기본정보-->
  <table class="tb_regi_basic2" summary="인사정보 기본정보입력 (이름, 생년월일, 사번, 소속회사, 부서, 직위, 핸드폰, )">
		<caption>인사정보 기본정보입력</caption>
		<colgroup>
			<col width="60" />
			<col width="50" />
			<col width="50" />
			<col width="190" />
			<col width="85" />
			<col width="*" />
			<col width="170" />
		</colgroup>
		<tbody>
			<tr>
				<th rowspan="15">기본<br>정보</th>
				<th rowspan="2" class="bg_skyblue2">성명</th>
				<th class="bg_skyblue2"><label for="name">한글</label></th>
				<td><input type="text" class="input_b w100pro" id="name" name = "name" value="${userDetail.name }" placeholder="국문입력" /></td>
				<th class="bg_skyblue2">사번</th>
				<td>
					${userDetail.empNoView }
					<!--사번이 만들어지는 규칙대로 자동으로 불러와집니다. 수정불가-->
					<input type="hidden" id = "inputUserNo" value="${userDetail.empNoView }">
				</td>
				<td rowspan="7" class="picpro" >
				<c:choose>
					<c:when test="${profileImgSeq>0 }">
						<div class="photo_aspect aspect_3_4" id = "previewId"><img id="prev_previewId" src="<c:url value='/file/downFile.do?uploadType=PROFILEIMG&downFileList=${profileImgSeq}' />" /></div>
					</c:when>
					<c:otherwise>
						<div class="photo_aspect aspect_3_4" id = "previewId"><img id="prev_previewId" src="" /></div>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr>
				<th class="bg_skyblue2"><label for="engNm">영어</label></th>
				<td><input type="text" class="input_b w100pro" id="engNm" name="engNm" value="${userDetail.engNm }" onkeyup="engNmChk()" placeholder="영문입력" /></td>
				<th class="bg_skyblue2">로그인ID</th>
				<td>
					${userDetail.loginId }
					<button id="btnInitPwd" type="button" style="float: right;" class="btn_s_type_g btn_auth mgl6" onclick="tryInitPwd();"><em class="p_reset">비밀번호 초기화</em></button>
				</td>
			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2">소속회사</th>
				<%-- <td>${userDetail.companyNm }</td> --%>
				<td>
				<button type="button" class="btn_s_type2 addOnly" onclick="fnObj.openCompany(${userDetail.orgId}); return false;" id="openCompanyButton" style="<c:if test="${userDetail.orgCompanyCnt <= 1}">display:none;</c:if>"><em class="icon_search">선택</em></button>
				<span id="AP_CpnNm">${userDetail.companyNm}</span>
				<input type="hidden" id="AP_CpnSnb" name="cpnSnb" value="${userDetail.company}">
				<input type="hidden" id="ori_AP_CpnSnb" name="oriCpnSnb" value="${userDetail.company}">
				</td>

				<th class="bg_skyblue2">소속 관계사</th>
				<td>${userDetail.orgNm }</td>
			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="IDNAME05">채용형태</label></th>
				<td id = "userStatusArea">
					<!-- <select class="select_b w100pro" id="IDNAME05" title="채용형태">

					</select> -->
				</td>
				<th class="bg_skyblue2">직위</th>
				<td>${userDetail.rankNm }</td>
			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="IDNAME05">권한설정</label></th>
				<td colspan="3">
					<input class="input_b w120px" title="관계사명" value="${userDetail.orgNm }"  readonly />
					<span id="roleSelectArea" style="display: inline;"></span>
				</td>

			</tr>
			<tr>
				<th rowspan="2" colspan="2" class="bg_skyblue2"><label for="IDNAME06">부서선택</label></th>
				<td colspan="3">
					<a href="javascript:fnObj.openUserPopup()" class="btn_select_team"><em>부서선택</em></a>
					<span>대표부서:</span>
					<select id="mainDept" name = "mainDept" class="select_b">
						<option value="">선택</option>
						<c:forEach items="${userDeptList }" var = "data">
							<option value="${data.deptId }" <c:if test = "${data.mainYn eq 'Y' }">selected="selected"</c:if>>${data.deptNm }</option>
						</c:forEach>
					</select>
				</td>
			</tr>

			<tr>
				<td colspan="3" class="dot_line" id = "deptArea">
					<c:forEach items="${userDeptList }" var = "data" varStatus="i">
						<span class="employee_list2">
							<span>
								<input type="hidden" name="incharge" value="${data.incharge }">
								<input type="hidden" name="deptNm" value="${data.deptNm }">
								<input type="hidden" name="deleteFlag" value="N">
								<c:if test="${i.index gt 0}">, </c:if>${data.deptNm}<c:if test="${data.incharge eq 'DEPT_MGR'}"><em>(부서장)</em></c:if>
							</span>
							<input type="hidden" name="deptId" value="${data.deptId }">
							<c:if test="${data.incharge ne 'DEPT_MGR' }"><a href="#this" onclick="deleteDept($(this))" class="btn_delete_employee"><em>삭제</em></a></c:if><%-- <c:if test="${i.index lt fn:length(userDeptList)-1 }">, </c:if> --%>
						</span>
					</c:forEach>
					<!-- <span class="employee_list"><span>박정인</span><em>(대리)</em><a href="#" class="btn_delete_employee"><em>삭제</em></a></span> -->
				</td>

			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="IDNAME04">재직상태</label></th>
				<td>
					${userDetail.userStatusNm }
				</td>
				<th class="bg_skyblue2"><label for="IDNAME04">부재중확인</label></th>
				<td>
					<span class="radio_list2">
						<label>
							<input type="radio" name="outOfOfficeTracking" id = "outOfOfficeTracking" value="Y"
								<c:if test = "${userDetail.outOfOfficeTracking eq 'Y' }">checked="checked"</c:if>
							><span>예</span>
						</label>
						<label>
							<input type="radio" name="outOfOfficeTracking" id = "outOfOfficeTracking" value="N"
								<c:if test = "${userDetail.outOfOfficeTracking eq 'N' }">checked="checked"</c:if>
							><span>아니오</span>
						</label>
					</span>
				</td>
				<td class="txt_center dot_line addFileList">

					<!-- <input type="file" multiple="true" name="shadowFile" id="shadowFile" style="display:none;" onchange="previewImage(this,'previewId')">
					<button type="button" onclick="document.getElementById('shadowFile').click();" class="btn_s_type_g">파일찾기</button> -->

					<span id="fileInputArea" class="file_btn_bg"><input name="upFile" type="file" multiple onchange="previewImage(this,'previewId');" class="file_btn_cover" style="position:relative;"></span>
					<c:if test="${profileImgSeq>0 }">
						<button type="button" onclick="deleteProfileFile()" class="btn_s_type_g mgl6">파일삭제</button>
					</c:if>
				</td>
			</tr>

			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="IDNAME04">휴직이력</label></th>
				<td colspan="4">
				  	<!--재직상태-->
					<table width="100%" class="tb_regi_basic2 mgt10" summary="재직상태입력 " id = "sttsTable">
						<caption>재직상태정보입력</caption>
						<colgroup>
							<col width="30" />
							<col width="250" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th width="110" class="bg_skyblue" scope="col">상태</th>
								<th width="125" class="bg_skyblue" scope="col">날짜</th>
								<th width="*" class="bg_skyblue" scope="col">사유</th>
							</tr>
								<c:forEach items="${userSttsHist }" var = "data" varStatus="i">
								<tr>
									<td class="txt_center">
										${data.userStatusNm }
									<td>
										${data.sttsFromDt}
										<span class="dashLine">~</span>
										${data.sttsEndDt}

									</td>
									<td>${data.memo}</td>
								</tr>
								</c:forEach>
								<c:if test="${fn:length(userSttsHist)<=0 }">
									<td colspan="3" class="no_result">
										<p class="nr_des">조회된 데이터가 없습니다.</p>
									</td>
								</c:if>
						</tbody>
					</table>
					<!--//진급//-->
			   </td>

			</tr>

			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="hiredDate">입사일</label></th>
				<td>
					<input  type="text" class="input_b input_date_type" id="hiredDate" name = "hiredDate" value="<fmt:formatDate value="${userDetail.hiredDate}" pattern="yyyy-MM-dd"/>" />
				</td>
				<th class="bg_skyblue2"><label for="passport">담당업무</label></th>
				<td colspan="2"><input type="text"  class="input_b w100pro" id="work" name="work" value="${userDetail.work }" /></td>
			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="joinDate">정직원 발령</label></th>
				<td><input type="text"  class="input_b input_date_type" id="joinDate" name="joinDate" value="<fmt:formatDate value="${userDetail.joinDate}" pattern="yyyy-MM-dd"/>" />

				<th class="bg_skyblue2"><label for="birth">생일</label></th>
				<td colspan="2">
					<input type="text" class="input_b input_date_type" id="birth" name="birth" value="<fmt:formatDate value="${userDetail.birth}" pattern="yyyy-MM-dd"/>" title="생일선택" />
					<!--주민번호에서 생일이 자동으로 불러와지지만 수정은 가능하게...주민번호랑 실제 생일 다를수 있음~!-->
					<select id = "solar" name="solar" class="select_b mgl6" title="양력/음력선택">
						<option value="">선택</option>
						<option value="Y" <c:if test = "${userDetail.solar eq 'Y' }">selected="selected"</c:if>>양력</option>
						<option value="N" <c:if test = "${userDetail.solar eq 'N' }">selected="selected"</c:if>>음력</option>
					</select>
				</td>
			</tr>
			<tr>
				<th colspan="2" rowspan="2" class="bg_skyblue2">주소</th>
				<td colspan="4">
					<input type="text" class="sel_phone" id="zip" name="homeZip" value="${userDetail.homeZip }" title="우편번호 앞번호" readonly />

					<a href="javascript:fn_postCall()" class="s_violet01_btn mgl6" id="IDName18"><em class="search">우편번호검색</em></a>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="text"  class="input_b w100pro mgb8" id="addr" name = "homeAddr1" value="${userDetail.homeAddr1 }" title="주소입력" readonly />
					<input type="text"  class="input_b w100pro" id="homeAddr2" name = "homeAddr2" value="${userDetail.homeAddr2 }" placeholder="주소입력" title="상세주소입력" readonly="readonly"/>
				</td>
			</tr>

            <tr>
				<th colspan="2" class="bg_skyblue2"><label for="IDNAME20">진급</label></th>
				<td colspan="4">
					<!--진급-->
					<table width="100%" class="tb_regi_basic2 mgt10" summary="인사정보 부가정보입력 (진급)" id = "rankTable">
						<caption>인사정보 부가정보입력</caption>
						<colgroup>
							<col width="110" />
							<col width="125" />
							<col width="*" />
							<col width="30" />
						</colgroup>
						<tbody>
							<tr>
								<th width="110" class="bg_skyblue" scope="col">진급날짜</th>
								<th width="125" class="bg_skyblue" scope="col">직위</th>
								<th width="*" class="bg_skyblue" scope="col">진급사유</th>
								<th width="30" class="bg_skyblue" scope="col">추가</th>
							</tr>
							<c:forEach items="${userInsideCareer }" var = "data" varStatus="i">
								<%-- <tr>
									<td class="txt_center">
										<input class="input_b input_date_type" name = "promotionDt" value="<fmt:formatDate value="${data.promotionDt}" pattern="yyyy-MM-dd"/>" placeholder="진급날짜" title="진급날짜입력" />
									<td>
										<select class="select_b w100pro" name = "rank" id = "rank_${data.sNb}" title="직위선택">
										</select>
										<script type="text/javascript">

										//id/name , codeStr, value , text ,selectValue ,onchange....
										var comTag = createSelectTag('rank', comCodeRankType, 'CD', 'NM', '${data.rank}', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
										$("#rank_${data.sNb}").html(comTag);
										</script>
									</td>
									<td><input class="input_b w100pro" name="memo" value="${data.memo }" placeholder="진급사유입력" title="진급사유입력" /></td>
									<td class="txt_center">
										<c:if test="${i.index+1 eq fn:length(userInsideCareer) }">
											<a href="#this" onclick="addRank()" id = "rankAddBtn" class="btn_ac_add"><em>추가</em></a>
										</c:if>
									</td>
								</tr> --%>
								<tr>
									<td class="txt_center">
										<fmt:formatDate value="${data.promotionDt}" pattern="yyyy-MM-dd"/>
									<td>
										${data.position }
									</td>
									<td>${data.memo }</td>
									<td class="txt_center">
										<c:if test="${i.index+1 eq fn:length(userInsideCareer) }">
											<a href="#this" onclick="addRank()" id = "rankAddBtn" class="btn_ac_add"><em>추가</em></a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test = "${fn:length(userInsideCareer)<=0 }">
								<script type="text/javascript">
									$("#rankTable").append($("#rankTmpl").text());
									var comTag = createSelectTag('rank', comCodeRankType, 'CD', 'NM', '', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
									$("#rankNew").html(comTag);
								</script>
							</c:if>
						</tbody>
					</table>
					<!--//진급//-->
				</td>
			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2">퇴직</th>
				<td>
					<select class="select_b " name = "userStatus" id = "userStatusNew" title="직위선택" >
						<option value="">선택</option>
						<option value="F" <c:if test = "${fireInfo.userStatus eq 'F'}">selected="selected"</c:if>>퇴사</option>
						<option value="R" <c:if test = "${fireInfo.userStatus eq 'R'}">selected="selected"</c:if>>해고</option>
					</select>
					<!-- 퇴사/해고만 처리하기위해 하드코딩 -->
					<!-- <script type="text/javascript">
					//id/name , codeStr, value , text ,selectValue ,onchange....
					var comTag = createSelectTag('userStatus', comCodeUserStatusType, 'CD', 'NM', '', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
					$("#userStatusNew").html(comTag);
					$("#userStatusNew option:eq(1)").remove();
					</script> -->
					<input type="text"  class="input_b input_date_type mgl6" value="${fireInfo.sttsFromDt}" name = "sttsFromDt" title="시작일" />
				</td>
				<th class="bg_skyblue2">사유</th>
				<td colspan="2"><input type="text"  class="input_b w100pro" name="sttsMemo"  value="${fireInfo.memo}" placeholder="사유입력" title="사유입력" /></td>
			</tr>
		</tbody>
	</table>
	<!--//기본정보//-->
    <!--기본정보(연락처)-->
	<table class="tb_regi_basic2 mgt10" summary="인사정보 기본정보입력 (이름, 생년월일, 사번, 소속회사, 부서, 직위, 핸드폰, )">
	  <caption>인사정보 기본정보입력</caption>
		<colgroup>
			<col width="60" />
			<col width="100" />
			<col width="*" />
			<col width="85" />
			<col width="362" />
		</colgroup>
		<tbody>
			<tr>
				<th rowspan="3">연락처</th>
				<th class="bg_skyblue2"><label for="mobileTel1">핸드폰</label></th>
				<td>
					<c:set var = "mobilePhonArr" value="${fn:split(userDetail.mobileTel,'-') }"></c:set>
					<select class="sel_phone" id="mobileTel1">
						<option value="">선택</option>
						<option value="010" <c:if test = "${mobilePhonArr[0] eq '010' }">selected="selected"</c:if>>010</option>
						<option value="011" <c:if test = "${mobilePhonArr[0] eq '011' }">selected="selected"</c:if>>011</option>
						<option value="016" <c:if test = "${mobilePhonArr[0] eq '016' }">selected="selected"</c:if>>016</option>
						<option value="017" <c:if test = "${mobilePhonArr[0] eq '017' }">selected="selected"</c:if>>017</option>
						<option value="018" <c:if test = "${mobilePhonArr[0] eq '018' }">selected="selected"</c:if>>018</option>
						<option value="019" <c:if test = "${mobilePhonArr[0] eq '019' }">selected="selected"</c:if>>019</option>
					</select>
					<span class="dashLine">-</span> <input type="text" class="input_phone" value="${mobilePhonArr[1] }" id = "mobileTel2" title="핸드폰 중간번호" maxlength="4">
					<span class="dashLine">-</span> <input type="text" class="input_phone" value="${mobilePhonArr[2] }" id = "mobileTel3" title="핸드폰 마지막번호" maxlength="4">
					<input type="hidden" id="mobileTel" name = "mobileTel" value="${userDetail.mobileTel }"/>
				</td>
				<th class="bg_skyblue2"><label for="companyTel">내선번호</label></th>
				<td>
					<c:set var = "companyTelArr" value="${fn:split(userDetail.companyTel,'-') }"></c:set>
					<select class="sel_phone" id="companyTel1">
						<option value="">선택</option>
						<option value="02" <c:if test = "${companyTelArr[0] eq '02' }">selected="selected"</c:if>>02</option>
						<option value="031" <c:if test = "${companyTelArr[0] eq '031' }">selected="selected"</c:if>>031</option>
						<option value="032" <c:if test = "${companyTelArr[0] eq '032' }">selected="selected"</c:if>>032</option>
						<option value="033" <c:if test = "${companyTelArr[0] eq '033' }">selected="selected"</c:if>>033</option>
						<option value="041" <c:if test = "${companyTelArr[0] eq '041' }">selected="selected"</c:if>>041</option>
						<option value="042" <c:if test = "${companyTelArr[0] eq '042' }">selected="selected"</c:if>>042</option>
						<option value="043" <c:if test = "${companyTelArr[0] eq '043' }">selected="selected"</c:if>>043</option>
						<option value="044" <c:if test = "${companyTelArr[0] eq '044' }">selected="selected"</c:if>>044</option>
						<option value="049" <c:if test = "${companyTelArr[0] eq '049' }">selected="selected"</c:if>>049</option>
						<option value="051" <c:if test = "${companyTelArr[0] eq '051' }">selected="selected"</c:if>>051</option>
						<option value="052" <c:if test = "${companyTelArr[0] eq '052' }">selected="selected"</c:if>>052</option>
						<option value="053" <c:if test = "${companyTelArr[0] eq '053' }">selected="selected"</c:if>>053</option>
						<option value="054" <c:if test = "${companyTelArr[0] eq '054' }">selected="selected"</c:if>>054</option>
						<option value="055" <c:if test = "${companyTelArr[0] eq '055' }">selected="selected"</c:if>>055</option>
						<option value="061" <c:if test = "${companyTelArr[0] eq '061' }">selected="selected"</c:if>>061</option>
						<option value="062" <c:if test = "${companyTelArr[0] eq '062' }">selected="selected"</c:if>>062</option>
						<option value="063" <c:if test = "${companyTelArr[0] eq '063' }">selected="selected"</c:if>>063</option>
						<option value="064" <c:if test = "${companyTelArr[0] eq '064' }">selected="selected"</c:if>>064</option>
						<option value="070" <c:if test = "${companyTelArr[0] eq '070' }">selected="selected"</c:if>>070</option>
					</select>
					<span class="dashLine">-</span> <input type="text" class="input_phone" value="${companyTelArr[1] }" id = "companyTel2" title="본사전화 중간번호" maxlength="4">
					<span class="dashLine">-</span> <input type="text" class="input_phone" value="${companyTelArr[2] }" id = "companyTel3" title="본사전화 마지막번호" maxlength="4">

					<input type="hidden" id="companyTel" name = "companyTel" value="${userDetail.companyTel }"/>
				</td>
			</tr>
			<tr>
				<th class="bg_skyblue2"><label for="homeTel1">집전화</label></th>
				<td>
					<c:set var = "homeTelArr" value="${fn:split(userDetail.homeTel,'-') }"></c:set>
					<select class="sel_phone" id="homeTel1">
						<option value="">선택</option>
						<option value="02" <c:if test = "${homeTelArr[0] eq '02' }">selected="selected"</c:if>>02</option>
						<option value="031" <c:if test = "${homeTelArr[0] eq '031' }">selected="selected"</c:if>>031</option>
						<option value="032" <c:if test = "${homeTelArr[0] eq '032' }">selected="selected"</c:if>>032</option>
						<option value="033" <c:if test = "${homeTelArr[0] eq '033' }">selected="selected"</c:if>>033</option>
						<option value="041" <c:if test = "${homeTelArr[0] eq '041' }">selected="selected"</c:if>>041</option>
						<option value="042" <c:if test = "${homeTelArr[0] eq '042' }">selected="selected"</c:if>>042</option>
						<option value="043" <c:if test = "${homeTelArr[0] eq '043' }">selected="selected"</c:if>>043</option>
						<option value="044" <c:if test = "${homeTelArr[0] eq '044' }">selected="selected"</c:if>>044</option>
						<option value="049" <c:if test = "${homeTelArr[0] eq '049' }">selected="selected"</c:if>>049</option>
						<option value="051" <c:if test = "${homeTelArr[0] eq '051' }">selected="selected"</c:if>>051</option>
						<option value="052" <c:if test = "${homeTelArr[0] eq '052' }">selected="selected"</c:if>>052</option>
						<option value="053" <c:if test = "${homeTelArr[0] eq '053' }">selected="selected"</c:if>>053</option>
						<option value="054" <c:if test = "${homeTelArr[0] eq '054' }">selected="selected"</c:if>>054</option>
						<option value="055" <c:if test = "${homeTelArr[0] eq '055' }">selected="selected"</c:if>>055</option>
						<option value="061" <c:if test = "${homeTelArr[0] eq '061' }">selected="selected"</c:if>>061</option>
						<option value="062" <c:if test = "${homeTelArr[0] eq '062' }">selected="selected"</c:if>>062</option>
						<option value="063" <c:if test = "${homeTelArr[0] eq '063' }">selected="selected"</c:if>>063</option>
						<option value="064" <c:if test = "${homeTelArr[0] eq '064' }">selected="selected"</c:if>>064</option>
						<option value="070" <c:if test = "${homeTelArr[0] eq '070' }">selected="selected"</c:if>>070</option>
					</select>
					<span class="dashLine">-</span> <input type="text" class="input_phone" value="${homeTelArr[1] }" id = "homeTel2" title="집전화 중간번호" maxlength="4">
					<span class="dashLine">-</span> <input type="text" class="input_phone" value="${homeTelArr[2] }" id = "homeTel3" title="집전화 마지막번호" maxlength="4">

					<input type="hidden" id="homeTel" name = "homeTel" value="${userDetail.homeTel }"/>
				</td>
				<th class="bg_skyblue2"><label for="email">이메일</label></th>
				<td><input class="input_b w100pro" id="email" name = "email" value="${userDetail.email }" /></td>
			</tr>

			<tr>
				<th class="bg_skyblue2"><label for="sosTel1">긴급연락</label></th>
				<td colspan="3" id = "sosTelArea">
					<c:set var = "sosTelArr" value="${fn:split(userDetail.sosTel,'-') }"></c:set>
					<select class="sel_phone" id="sosTel1">
						<option value="">선택</option>
						<option value="010" <c:if test = "${sosTelArr[0] eq '010' }">selected="selected"</c:if>>010</option>
						<option value="011" <c:if test = "${sosTelArr[0] eq '011' }">selected="selected"</c:if>>011</option>
						<option value="016" <c:if test = "${sosTelArr[0] eq '016' }">selected="selected"</c:if>>016</option>
						<option value="017" <c:if test = "${sosTelArr[0] eq '017' }">selected="selected"</c:if>>017</option>
						<option value="018" <c:if test = "${sosTelArr[0] eq '018' }">selected="selected"</c:if>>018</option>
						<option value="019" <c:if test = "${sosTelArr[0] eq '019' }">selected="selected"</c:if>>019</option>
						<option value="02" <c:if test = "${sosTelArr[0] eq '02' }">selected="selected"</c:if>>02</option>
						<option value="031" <c:if test = "${sosTelArr[0] eq '031' }">selected="selected"</c:if>>031</option>
						<option value="032" <c:if test = "${sosTelArr[0] eq '032' }">selected="selected"</c:if>>032</option>
						<option value="033" <c:if test = "${sosTelArr[0] eq '033' }">selected="selected"</c:if>>033</option>
						<option value="041" <c:if test = "${sosTelArr[0] eq '041' }">selected="selected"</c:if>>041</option>
						<option value="042" <c:if test = "${sosTelArr[0] eq '042' }">selected="selected"</c:if>>042</option>
						<option value="043" <c:if test = "${sosTelArr[0] eq '043' }">selected="selected"</c:if>>043</option>
						<option value="044" <c:if test = "${sosTelArr[0] eq '044' }">selected="selected"</c:if>>044</option>
						<option value="049" <c:if test = "${sosTelArr[0] eq '049' }">selected="selected"</c:if>>049</option>
						<option value="051" <c:if test = "${sosTelArr[0] eq '051' }">selected="selected"</c:if>>051</option>
						<option value="052" <c:if test = "${sosTelArr[0] eq '052' }">selected="selected"</c:if>>052</option>
						<option value="053" <c:if test = "${sosTelArr[0] eq '053' }">selected="selected"</c:if>>053</option>
						<option value="054" <c:if test = "${sosTelArr[0] eq '054' }">selected="selected"</c:if>>054</option>
						<option value="055" <c:if test = "${sosTelArr[0] eq '055' }">selected="selected"</c:if>>055</option>
						<option value="061" <c:if test = "${sosTelArr[0] eq '061' }">selected="selected"</c:if>>061</option>
						<option value="062" <c:if test = "${sosTelArr[0] eq '062' }">selected="selected"</c:if>>062</option>
						<option value="063" <c:if test = "${sosTelArr[0] eq '063' }">selected="selected"</c:if>>063</option>
						<option value="064" <c:if test = "${sosTelArr[0] eq '064' }">selected="selected"</c:if>>064</option>
						<option value="070" <c:if test = "${sosTelArr[0] eq '070' }">selected="selected"</c:if>>070</option>
					</select>
					<span class="dashLine">-</span> <input type="text" class="input_phone" value="${sosTelArr[1] }" id = "sosTel2" title="집전화 중간번호" maxlength="4">
					<span class="dashLine">-</span> <input type="text" class="input_phone" value="${sosTelArr[2] }" id = "sosTel3" title="집전화 마지막번호" maxlength="4">

					<input type="hidden" id="sosTel" name = "sosTel" value="${userDetail.sosTel }"/>

				</td>
			</tr>
		</tbody>
	</table>
	<!--// 기본정보(연락처) //-->
 	<!--부가정보-->
	<table class="tb_regi_basic2 mgt10" summary="인사정보 기본정보입력 (이름, 생년월일, 사번, 소속회사, 부서, 직위, 핸드폰, )">
	  <caption>인사정보 기본정보입력</caption>
		<colgroup>
			<col width="60" />
			<col width="100" />
			<col width="*" />
			<col width="85" />
			<col width="362" />
		</colgroup>
		<tbody>
			<tr>
			  <th rowspan="3">부가 정보</th>
				<th class="bg_skyblue2"><label for="hobby">취미</label></th>
				<td><input type="text"  class="input_b w100pro" id="hobby" name = "hobby" value="${userDetail.hobby }"></td>
				<th class="bg_skyblue2"><label for="IDNAME26">혈액형</label></th>
				<td>
					<span class="radio_list2" id = "bloodArea">
					</span>
				</td>
			</tr>
			<tr>
				<th class="bg_skyblue2"><label for="IDNAME27">결혼일</label></th>
				<td class="txt_left">
					<span class="radio_list2">
						<label>
							<input type="radio" name="married" id = "nomarried" value="N"
								<c:if test = "${userDetail.marriedDate eq null or userDetail.marriedDate eq '' }">checked="checked"</c:if>
							/><span>미혼</span>
						</label>
						<label>
							<input type="radio" name="married" id = "married" value="Y"
								<c:if test = "${userDetail.marriedDate ne null and userDetail.marriedDate ne '' }">checked="checked"</c:if>
							><span>기혼</span>
						</label>
						<input class="input_b input_date_type" id = "marriedDate" name = "marriedDate" value="${userDetail.marriedDate }"  placeholder="결혼일" title="결혼일" />
					</span>
				</td>
				<th class="bg_skyblue2"><label for="IDNAME28">종교</label></th>
				<td>
					<span class="radio_list2" id="religionArea">

					</span>
				</td>
			</tr>
			<tr>
				<th class="bg_skyblue2"><label for="passport">여권번호</label></th>
				<td colspan="3"><input type="text"  class="input_b w100pro" id="passport" name="passport" value="${userDetail.passport }" /></td>
			</tr>
			<!-- <tr>
				<th class="bg_skyblue2"><label for="IDNAME17">여권번호</label></th>
				<td colspan="3"><input class="input_b w100pro" id="IDNAME17" value="" placeholder="여권번호입력" /></td>
			</tr> -->
		</tbody>
	</table>
	<!--// 부가정보 //-->
	<h3 class="h3_title_basic mgt40">학력 및 경력사항</h3>
	<!--부가정보작성-->
		<!--가족관계-->
		<table class="tb_regi_basic2" summary="인사정보 부가정보입력 (가족관계)" id = "familyTable">
			<caption>인사정보 부가정보입력</caption>
			<colgroup>
				<col width="60" />
				<col width="100" />
				<col width="*" />
				<col width="115" />
				<col width="*" />
				<col width="94" />
				<col width="90" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" id = "familyTitle">가족<br>관계</th>
					<th scope="col" class="bg_skyblue">관계</th>
					<th scope="col" class="bg_skyblue">성명</th>
					<th scope="col" class="bg_skyblue">생년월일</th>
					<th scope="col" class="bg_skyblue">직업</th>
					<th scope="col" class="bg_skyblue">동거여부</th>
					<th scope="col" class="bg_skyblue">추가/삭제</th>
				</tr>
				<c:forEach items="${userFamily }" var = "data">
					<tr>
						<td>
							<div id = "relation_${data.sNb }"  name= 'relationNew'>
							</div>
							<script type="text/javascript">

							//id/name , codeStr, value , text ,selectValue ,onchange....
							var comTag = createSelectTag('relation', comCodeFamilyType, 'CD', 'NM', '${data.relation}', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
							$("#relation_${data.sNb}").html(comTag);
							</script>
						</td>
						<td><input type="text"  class="input_b w100pro" name="familyNm" value="${data.familyNm }" placeholder="이름입력" title="가족이름입력" /></td>
						<td class="txt_center">
							<input class="input_b input_date_type" name="birthDt" value="${data.birthDt }" placeholder="생년월일" title="가족생년월일입력" />
						</td>
						<td><input type="text"  class="input_b w100pro" name="job" value="${data.job }" placeholder="직업입력" title="가족직업입력" /></td>
						<td class="txt_center">
							<select name = "liveinYn" class="select_b w100pro">
								<option value="">선택</option>
								<option value="Y" <c:if test = "${data.liveinYn eq 'Y' }">selected="selected"</c:if>>동거</option>
								<option value="N" <c:if test = "${data.liveinYn eq 'N' }">selected="selected"</c:if>>비동거</option>
							</select>
						</td>
						<td class="txt_center">
							<a href="#this" onclick="addFamily()" class="btn_ac_add"><em>추가</em></a>
							<a href="#this" onclick="deleteFamily($(this))" class="btn_ac_delete"><em>삭제</em></a>
						</td>
					</tr>
				</c:forEach>
				<c:if test = "${fn:length(userFamily)<=0 }">
					<script type="text/javascript">
						$("#familyTable tbody").append($("#familyTmpl").text());

						var familyTypeTag = createSelectTag('relation', comCodeFamilyType, 'CD', 'NM', '', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)

						$("#relationNew").html(familyTypeTag);
					</script>
				</c:if>
			</tbody>
		</table>
		<!--//가족관계//-->

		<!--학력사항-->
		<table class="tb_regi_basic2 mgt10" summary="인사정보 부가정보입력 (학력사항)" id = "academicTable">
			<caption>인사정보 부가정보입력</caption>
			<colgroup>
				<col width="60" />
				<col width="240" />
				<col width="240" />
				<col width="*" />
				<col width="94" />
				<col width="90" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" id = "academicTitle">학력<br>사항</th>
					<th scope="col" class="bg_skyblue">재학기간</th>
					<th scope="col" class="bg_skyblue">학교명</th>
					<th scope="col" class="bg_skyblue">전공</th>
					<th scope="col" class="bg_skyblue">구분</th>
					<th scope="col" class="bg_skyblue">추가/삭제</th>
				</tr>
				<c:forEach items="${userAcademic }" var="data">
					<tr>
						<td class="txt_center">
							<input type="text"  class="input_b input_date_type" name="enteredDt" value="${data.enteredDt }-01" placeholder="입학년월" title="입학년월" />
							<span class="dashLine">~</span>
							<input type="text"  class="input_b input_date_type" name="graduateDt" value="${data.graduateDt }-01" placeholder="졸업년월" title="졸업년월" />
						</td>
						<td>
							<input type="text"  class="input_b w_100px mgr6" id = "academicNm" name = "academicNm" value="${data.academicNm }" placeholder="학교명입력" title="학교명입력" />
							<span id = "schoolType_${data.sNb }" name = "schoolTypeArea">
							</span>
							<script type="text/javascript">
							//id/name , codeStr, value , text ,selectValue ,onchange....
							var schoolTypeTag = createSelectTag('schoolType', comCodeSchoolTypeType, 'CD', 'NM', '${data.schoolType }', null, colorObj, 100, 'select_b');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
							$("#schoolType_${data.sNb }").html(schoolTypeTag);
							</script>
						</td>
						<td><input type="text"  class="input_b w100pro" id="major" name = "major" placeholder="전공학과입력" value="${data.major }" title="전공학과입력" /></td>
						<td>
							<div id = "graduateType_${data.sNb }" name = "graduateTypeArea">
							</div>
							<script type="text/javascript">
							//id/name , codeStr, value , text ,selectValue ,onchange....
							var graduateTypeTag = createSelectTag('graduateType', comCodeGraduateType, 'CD', 'NM', '${data.graduateType}', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
							$("#graduateType_${data.sNb }").html(graduateTypeTag);
							</script>
						</td>
						<td class="txt_center">
							<a href="#this" onclick="addAcademic()" class="btn_ac_add" ><em>추가</em></a>
							<a href="#this" onclick="deleteAcademic($(this))" class="btn_ac_delete"><em>삭제</em></a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(userAcademic)<=0 }">
					<script type="text/javascript">
					addAcademic();
					</script>
				</c:if>
			</tbody>
		</table>
		<!--//학력사항//-->

		<!-- working...psj -->
		<!--경력사항-->
		<table class="tb_regi_basic2 mgt10" summary="인사정보 부가정보입력 (경력사항)" id = "careerTable">
			<caption>인사정보 부가정보입력</caption>
			<colgroup>
				<col width="60" />
				<col width="240" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="90" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" id = "careerTitle">경력<br>사항</th>
					<th scope="col" class="bg_skyblue">입사일/퇴사일</th>
					<th scope="col" class="bg_skyblue">회사명</th>
					<th scope="col" class="bg_skyblue">직위</th>
					<th scope="col" class="bg_skyblue">직무</th>
					<th scope="col" class="bg_skyblue">추가/삭제</th>
				</tr>
				<c:forEach items="${userCareer }" var = "data">
					<tr>
						<td class="txt_center">
							<input type="text" name="joinCpnDt" value="${data.joinCpnDt }" class="input_b input_date_type" title="입사일" />
							<span class="dashLine"> ~ </span>
							<input type="text"  name="resignCpnDt" value="${data.resignCpnDt }" class="input_b input_date_type" title="퇴사일" />
						</td>
						<td><input type="text"  class="input_b w100pro" name = "companyNm" value="${data.companyNm }" placeholder="회사명입력" title="회사명입력" /></td>
						<td>
							<div id = "careerRank_${data.sNb }"  name = "careerRankArea">

							</div>
							<script type="text/javascript">
							//id/name , codeStr, value , text ,selectValue ,onchange....
							var comTag = createSelectTag('careerRank', comCodeRankType, 'CD', 'NM', '${data.rank}', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
							$("#careerRank_${data.sNb }").html(comTag);
							</script>
						</td>
						<td><input class="input_b w100pro" name = "careerJob" value="${data.job }" placeholder="직무입력" title="직무입력" /></td>
						<td class="txt_center">
							<a href="#this" class="btn_ac_add" onclick="addCareer()"><em>추가</em></a>
							<a href="#this" class="btn_ac_delete" onclick="deleteCareer($(this))"><em>삭제</em></a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(userCareer)<=0 }">
					<script type="text/javascript">
					addCareer();
					</script>
				</c:if>
			</tbody>
		</table>
		<!--//경력사항//-->
		<!--자격증-->
		<table class="tb_regi_basic2 mgt10" summary="인사정보 부가정보입력 (자격증)" id = "licenseTable">
			<caption>인사정보 부가정보입력</caption>
			<colgroup>
				<col width="60" />
				<col width="*" />
				<col width="*" />
				<col width="115" />
				<col width="90" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" id = "licenseTitle">자격증</th>
					<th scope="col" class="bg_skyblue">자격증/면허증</th>
					<th scope="col" class="bg_skyblue">발행처/기관</th>
					<th scope="col" class="bg_skyblue">취득날짜</th>
					<th scope="col" class="bg_skyblue">추가/삭제</th>
				</tr>
				<c:forEach items="${userLicense }" var = "data">
					<tr>
						<td><input type="text"  class="input_b w100pro" name="licenseNm"  value="${data.licenseNm }" placeholder="자격증/면허증입력" title="자격증/면허증입력" /></td>
						<td><input type="text"  class="input_b w100pro" name = "issue" value="${data.issue }" placeholder="발행처/기관입력" title="발행처/기관입력" /></td>
						<td class="txt_center">
							<input type="text"  class="input_b input_date_type" name="obtainDt" value="${data.obtainDt }" placeholder="취득일자" title="취득일자입력" />
						</td>
						<td class="txt_center">
							<a href="#this" class="btn_ac_add" onclick="addLicense()"><em>추가</em></a>
							<a href="#this" class="btn_ac_delete" onclick="deleteLicense($(this))"><em>삭제</em></a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(userLicense)<=0 }">
					<script type="text/javascript">
					addLicense();
					</script>
				</c:if>
			</tbody>
		</table>
		<!--//자격증//-->
	<!--검색조건유지  -->
	<input type="hidden" name="searchOrdId" value="${searchMap.searchOrdId }">
	<input type="hidden" name="searchDeptId2" value="${searchMap.searchDeptId }">
	<input type="hidden" name="searchDeptIdBuf" value="${searchMap.searchDeptIdBuf }">
	<input type="hidden" name="recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" name="searchText" value="${searchMap.searchText }">
	<input type="hidden" name="pageIndex" value="${searchMap.pageIndex }">
	<input type="hidden" name="userId" value="${searchMap.userId }">
	<input type="hidden" name="searchUserStatus" value="${searchMap.searchUserStatus }">
	<input type="hidden" name="searchOrder" value="${searchMap.searchOrder }">

	<!-- 유저org -->
	<input type="hidden" name="userOrgId" value="${userDetail.orgId }">
	<!-- 재직상태 추가 여부 -->
	<c:choose>
		<c:when test="${fn:length(userSttsHist)<=0 }">
			<input type="hidden" id = "sttsFlag" name="sttsFlag" value="Y">
		</c:when>
		<c:otherwise>
			<input type="hidden" id = "sttsFlag" name="sttsFlag" value="N">
		</c:otherwise>
	</c:choose>

	<!-- 진급상태 추가 여부 -->
	<c:choose>
		<c:when test="${fn:length(userInsideCareer)<=0 }">
			<input type="hidden" id = "rankFlag" name="rankFlag" value="Y">
		</c:when>
		<c:otherwise>
			<input type="hidden" id = "rankFlag" name="rankFlag" value="N">
		</c:otherwise>
	</c:choose>

	<!--버튼모음-->
	<div class="btn_baordZone2">
		<%-- <c:if test="${userDetail.orgId eq baseUserLoginInfo.orgId }"> --%>
			<!-- <span class="btn_auth"><a href="javascript:doSave()" class="btn_blueblack">확인</a></span> -->
		<%-- </c:if> --%>

		<customTagUi:authBtn txt="확인" orgId="${userDetail.orgId }" event="href='javascript:doSave()'" ele="a" classValue="btn_blueblack" id="btnSave"/>

		<a href="javascript:goListPage()" class="btn_witheline">취소</a>
	</div>
	<!--//버튼모음//-->
</div>
</form>
</section>