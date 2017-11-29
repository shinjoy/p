<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/jsp/approve/js/approveCommon_JS.jsp" %>
<!-- Daum Editor... -->
<link rel="stylesheet" href="<c:url value='/daumeditor/css/editor.css'/>" type="text/css" charset="utf-8"/>
<script src="<c:url value='/daumeditor/js/editor_loader.js'/>" type="text/javascript" charset="utf-8"></script>
<form id = "tx_editor_form" name = "tx_editor_form" ></form>
<!-- Daum Editor... -->
<style type="text/css">
    #ui-datepicker-div
    {
        z-index: 9999999!important;
    }

	.appv_icon_favor { display:inline-block; z-index:1; background:url(${pageContext.request.contextPath}/images/approve/bg_star.png) no-repeat center center; width:40px; height:30px; }
	.appv_icon_favor em { display:none; }
	.appv_icon_favor.on { background:url(${pageContext.request.contextPath}/images/approve/bg_star_on.png) no-repeat center center; }
</style>
<%@ include file="./js/reqCompany_JS.jsp" %>

<section id="detail_contents">
<form id = "frm" name = "frm" method="post">
	<!-- DocClass 고정.... -->
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="COMPANY">
	<!-- 연차휴가만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="${companyFormMap.appvDocTypeName }">
	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId">

	<!-- 검색조건유지 : S -->
	<input type="hidden" id = "searchDocStatus" name = "searchDocStatus" value="${searchMap.searchDocStatus }">
	<input type="hidden" id = "searchTitle" name = "searchTitle" value="${searchMap.searchTitle }">
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" id = "pageIndex" name = "pageIndex" value="${searchMap.pageIndex }">
	<!-- 검색조건유지 : E -->

	<!-- 사내서식 APPV_COMPANY_FORM_ID  -->
	<input type="hidden" id = "appvCompanyFormId" name = "appvCompanyFormId" value="${companyFormMap.appvCompanyFormId}">
	<input type="hidden" id = "companyFileUseYn" name = "companyFileUseYn" value="${companyFormMap.fileUseYn}">
	<input type="hidden" id = "companyFileUseType" name = "companyFileUseType" value="${companyFormMap.fileUseType}">

	<!-- Popup에서 열렸을때 넘어오는 파라미터 -->
	<input type="hidden" name = "popYn" value="${popYn }">

	<div class="doc_AllWrap">
		<h3 style="font-family:'NanumBarun'; font-size:30px; letter-spacing:0; text-align:center; line-height:1.4; ">
			${companyFormMap.appvDocTypeName }
		</h3>

		<p class="table_notice" style="float: right;"><span class="point">*</span> 필수입력입니다.</p>

		<!--휴가신청서작성-->
		<table class="tb_regi_basic" summary="휴가신청(문서종류, 결재자, 신청자, 연락처, 소속/직위,연락처, 휴가기간, 사용일/잔여일, 사유, 업무인수자, 대결자, 참조인선택)">
			<caption>사내서식작성</caption>
			<colgroup>
				<col width="120" />
				<col width="*" />
				<col width="110" />
				<col width="28%" />
			</colgroup>
			<tbody>
				<tr>
					<th>대상자<c:if test="${companyFormMap.userType eq 'STAFF' }"><span class="star">*</span></c:if></th>
					<td><span id = "staffNameArea">${baseUserLoginInfo.userName }</span>
						<c:if test="${companyFormMap.userType eq 'STAFF' }">
							<a href="javascript:openSelectUserPop('userType')" class="btn_select_employee"><em>직원선택</em></a>
							<input type="hidden" id = "selectStaffId" name = "selectStaffId" value="${baseUserLoginInfo.userId}">
						</c:if>
					</td>
					<th><label for="IDNAME04">소속/직위</label></th>
					<td>
						<span id = "selectStaffInfoArea">
						${baseUserLoginInfo.deptNm }<span class="dashLine"> / </span>
						${baseUserLoginInfo.rankNm }
						</span>
					</td>
				</tr>
				<c:if test="${companyFormMap.linkDocUseYn eq 'Y' or companyFormMap.scheduleUseYn eq 'Y' }">
					<tr>
						<c:if test="${companyFormMap.linkDocUseYn eq 'Y'}">
						<th id = "linkDocTh">연결 결재문서<c:if test="${companyFormMap.linkDocUseType eq 'MANDATORY' }"><span class="star">*</span></c:if></th>
						<td <c:if test="${companyFormMap.scheduleUseYn ne 'Y'}">colspan="3"</c:if>>
							<div id = "refDocBefore">
								<a href="javascript:openApproveRefDocPop()" class="btn_s_type_g"><em>결재문서 선택</em></a>
							</div>
						</td>
						</c:if>
						<c:if test="${companyFormMap.scheduleUseYn eq 'Y'}">
							<th scope="row">일정<c:if test="${companyFormMap.scheduleUseType eq 'MANDATORY' }"><span class="star">*</span></c:if></th>
							<td <c:if test="${companyFormMap.linkDocUseYn ne 'Y'}">colspan="3"</c:if>>
								<input class="input_b w180px" id="workDailyStr" value="" placeholder="일정선택" onclick="openSchePop();$(this).blur();">

								<input type="hidden" id = "scheSeq" name = "scheSeq">

								<button type="button" class="mgl6 btn_s_replay" onclick="doRefleshSche();"><em>일정초기화</em></button>
							</td>
						</c:if>
					</tr>
					<c:if test="${companyFormMap.linkDocUseYn eq 'Y'}">
					<tr id = "linkDocTr" style="display: none;">
						<td colspan="3" class="dot_line" id = "linkDocArea">
						</td>
					</tr>
					</c:if>
				</c:if>

				<c:if test = "${companyFormMap.projectType eq 'ALL'}">
					<tr>
						<th>${baseUserLoginInfo.projectTitle }<span class="star">*</span></th>
						<td colspan="3">
							<div id = "projectSelectBefore">
								<a href="javascript:openApproveProjectPop()" class="btn_s_type_g"><em>${baseUserLoginInfo.projectTitle }선택</em></a>
							</div>
							<div id = "projectSelectAfter" style="display: none;">
								<span id = "projectName">운영시스템소스클린징작업(SP1704006)</span>
								<span id = "activityArea">
									<select id = "activityId" name = "activityId" class="select_b mgl6">
										<option value="">${baseUserLoginInfo.activityTitle } 선택</option>
									</select>
								</span>
								<span id = "activityDescArea" class="mgl10"></span>
								<button type="button" class="mgl6 btn_s_replay" onclick="doRefleshProject()"><em>부모코드초기화</em></button>
							</div>

							<input type="hidden" id = "projectId" name = "projectId">
						</td>
					</tr>
				</c:if>
				<c:if test = "${companyFormMap.projectType eq 'ING'}">
					<tr>
						<th scope="row"><label for="projectId">${baseUserLoginInfo.projectTitle }<span class="star">*</span></label></th>
						<td colspan="3">
						<!-- <select class="select_b" title="일정분류선택" id = "scheType" name = "scheType">
						</select> -->

							<span id = "projectArea"></span>
							<span id = "activityArea">
								<select id = "activityId" name = "activityId" class="select_b mgl6">
									<option value="">${baseUserLoginInfo.activityTitle } 선택</option>
								</select>
							</span>
							<span id = "activityDescArea" class="mgl10"></span>
						</td>
					</tr>

					<script type="text/javascript">
					var now = new Date();
					var year = now.getFullYear();
					var month = now.getMonth();
					var day = now.getDate();
					var nowMonth = (month+1)>=10?(month+1):"0"+(month+1);
					var nowDay = (day)>=10?(day):"0"+(day);
					var nowStr = year+"-"+nowMonth+"-"+(nowDay);
					var colorObj = {};
					var orgId = "${baseUserLoginInfo.orgId}";

					//프로젝트 셋팅
					function setProjectArea(){
						var commonPropject = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.projectTitle } 선택', { orgId : orgId,userId : $("#selectStaffId").val(),type:"PROJECT",incApproveActivity:"N",startDate:nowStr});
						var projectTag = createSelectTagForProject('projectId', commonPropject, 'CD', 'NM', '', null, {}, null, 'select_b','PROJECT');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)

				        $("#projectArea").html(projectTag);

				        $("#projectId").change(function(){
				        	chgProjectId();
				        })
						if($("#projectId").val()!=""){
							$("#projectId").change();
						}
					}

					setProjectArea();

			      	//프로젝트 셀렉트박스 체인지
			    	function chgProjectId(){
			    		var projectId = $("#projectId").val();
			    		$("#activityDescArea").text("");
			    		if(projectId == ""){
			    			$("#activityId").html("<option value = ''>${baseUserLoginInfo.activityTitle } 선택</option>");
			    			return;
			    		}
			    		var commonActivity = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.activityTitle } 선택', { orgId : orgId,projectId : projectId ,userId : "${baseUserLoginInfo.userId}",type:"ACTIVITY",incApproveActivity:"N",startDate:$("#dateFrom").val()});
			    		var activityTag = createSelectTagForProject('activityId', commonActivity, 'CD', 'NM', '', null, colorObj, null, 'select_b mgl6','ACTIVITY');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
			    		$("#activityArea").html(activityTag);

			    		$("#activityId").change(function(){
			    			$("#activityDescArea").text("");
			    			if($("#activityId").val()==""){
			    				$("#activityDescArea").text("");
			    				return;
			    			}
			    			var startDateStr = $("#activityId option:selected").attr("startdate");
			    			var endDateStr = $("#activityId option:selected").attr("enddate");

			    			$("#activityDescArea").text("기간 : "+startDateStr + " ~ " + endDateStr);
			    		});
			    		if($("#activityId").val()!="") $("#activityId").change();
			    	}

					</script>
				</c:if>
				<c:if test="${companyFormMap.titleUseYn eq 'Y'}">
					<tr>
						<th scope="row"><label for="why">제목<span class="star">*</span></label></th>
						<td colspan="3"><input class="input_b w100pro" id="why" name="why" placeholder="제목입력"/></td>
					</tr>
				</c:if>

				<tr>
					<th scope="row">내용</th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
	                	</jsp:include>
						<input type="hidden" id="memo" name = "memo" value='<c:out value="${companyFormMap.docContent }" />'>
					</td>
				</tr>
				<c:if test="${companyFormMap.fileUseYn eq 'Y'}">
					<tr>
						<th>파일첨부<c:if test="${companyFormMap.fileUseType eq 'MANDATORY' }"><span class="star">*</span></c:if></th>
						<td colspan="3" class="r_addFileList">
			                <p class="posi_btn">

								<span id="fileInputArea" class="file_btn_bg"><input name="upFile" type="file" multiple onchange="newFileUpload();" class="file_btn_cover"></span>
							</p>

			                    <!--파일없을땐 지워주세요-->
			                    <ul id="uploadFileList" class="fileList" style="display: none;">
			                	</ul>
			                    <!--//파일없을땐 지워주세요//-->
			                    <p class="file_notice">* 전체 최대용량 100MB 까지 첨부 가능합니다.</p>
			                </td>
					</tr>
				</c:if>
				<tr>
					<th id = "approveLineTh" rowspan="1">결재라인</th>
					<td colspan="3">
						   <span id = "appvHeaderNameArea">

		                   </span>


						   <c:if test="${companyFormMap.approveLineType eq 'INPUT' }">
							   <label ><input id = "individualYn" name = "individualYn" value="Y" type="checkbox" class="mgl10 mgr3" onchange="individualChk()"><span>직접선택</span></label>
							   <a id = "appvLineBtn" class="btn_s_type_g mgl5" href="javascript:openAppvLinePop()" style="display: none;"><em>결재라인작성</em></a>
						   </c:if>
					</td>
				</tr>
				<tr id = "approveLineTr" style="display: none;">
					<td colspan="3" class="dot_line">
						<div id = "approveLineArea">
						</div>
					</td>
				</tr>

				<tr>
					<th scope="row" id = "approveCcTh">참조인선택</th>
					<td colspan="3">
						<span class="radio_list2">
							<label>
								<input type="radio" name="approveCcType" value="NONE" checked="checked" onclick="approveCcBtnToggle()">
								<span>선택안함</span>
							</label>
							<label>
								<input type="radio" name="approveCcType" value="MY_ORG_ALL" onclick="approveCcBtnToggle()"/>
								<span>전체</span>
							</label>
							<label>
								<input type="radio" name="approveCcType" value="MY_TEAM" onclick="approveCcBtnToggle()">
								<span>소속팀</span>
							</label>
							<label>
								<input type="radio" name="approveCcType" value="SELECT" onclick="approveCcBtnToggle()">
								<span>직접선택</span>
							</label>
						</span>
						<a id = "approveCcBtn" href="javascript:openSelectUserPop('approveCc')" class="btn_select_employee mgl10" style="display: none;">
							<em>직원선택</em>
						</a>
					</td>
				</tr>
				<tr id = "approveCcTr" style="display: none;">
					<td colspan="3" class="dot_line" id = "approveCcArea">
					</td>
				</tr>

				<!-- 수신 추가 :S -->
				<tr>
					<th scope="row" id = "approveRcTh">수신인선택</th>
					<td colspan="3">
						<span class="radio_list2">
							<label>
								<input type="radio" name="approveRcType" value="NONE" checked="checked" onclick="approveRcBtnToggle()">
								<span>선택안함</span>
							</label>
							<label>
								<input type="radio" name="approveRcType" value="MY_ORG_ALL" onclick="approveRcBtnToggle()"/>
								<span>전체</span>
							</label>
							<label>
								<input type="radio" name="approveRcType" value="MY_TEAM" onclick="approveRcBtnToggle()">
								<span>소속팀</span>
							</label>
							<label>
								<input type="radio" name="approveRcType" value="SELECT" onclick="approveRcBtnToggle()">
								<span>직접선택</span>
							</label>
						</span>
						<a id = "approveRcBtn" href="javascript:openSelectUserPop('approveRc')" class="btn_select_employee mgl10" style="display: none;">
							<em>직원선택</em>
						</a>
					</td>
				</tr>
				<tr id = "approveRcTr" style="display: none;">
					<td colspan="3" class="dot_line" id = "approveRcArea">
					</td>
				</tr>
				<!-- 수신 추가 :E -->
				<tr>
					<th scope="row">결재완료전<br>열람허용</th>
					<td colspan="3">
						<label><input type="checkbox" id = "appvBeforeApproveReadYn" class="mgr3" name = "appvBeforeApproveReadYn" value="Y" <c:if test = "${appvReadDocSetupMap.approveYn eq 'Y' }">checked="checked"</c:if> ><span>결재/합의 허용</span></label>
						<label><input type="checkbox" id = "appvBeforeCcReadYn" class="mgl10 mgr3" name = "appvBeforeCcReadYn" value="Y" <c:if test = "${appvReadDocSetupMap.ccYn eq 'Y' }">checked="checked"</c:if>><span>참조 허용</span></label>
						<label><input type="checkbox" id = "appvBeforeReceiveReadYn" class="mgl10 mgr3" name = "appvBeforeReceiveReadYn" value="Y" <c:if test = "${appvReadDocSetupMap.receiveYn eq 'Y' }">checked="checked"</c:if>><span>수신 허용</span></label>
					</td>
				</tr>

			</tbody>
		</table>
		<!--// 휴가/휴직/복직/신청서작성 //-->
		<c:if test="${searchMap.popYn ne 'Y' }">
			<!--버튼모음-->
			<div class="btn_baordZone2">
				<a href="javascript:doSave()" class="btn_blueblack btn_auth btn_myOrg">임시저장</a>
				<c:choose>
					<c:when test="${popYn eq 'M' }">
						<a href="javascript:window.close()" class="btn_witheline">닫기</a>
					</c:when>
					<c:otherwise>
						<a href="javascript:goDraftListPage()" class="btn_witheline">취소</a>
					</c:otherwise>
				</c:choose>
			</div>
			<!--//버튼모음//-->
		</c:if>
	</div>
	<div id = "lineIndividualArea" style="display: none;"></div>
</form>
</section>