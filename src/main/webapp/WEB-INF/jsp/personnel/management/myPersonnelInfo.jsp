<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<section id="detail_contents">
<form id = "frm" name = "frm" method="post" action="${pageContext.request.contextPath}/mypersonnel/myPageMain.do">
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
				<th rowspan="13">기본<br>정보</th>
				<th rowspan="2" class="bg_skyblue2">성명</th>
				<th class="bg_skyblue2"><label for="name">한글</label></th>
				<td>${userDetail.name }</td>
				<th class="bg_skyblue2">사번</th>
				<td colspan="2">
					${userDetail.empNoView }
					<!--사번이 만들어지는 규칙대로 자동으로 불러와집니다. 수정불가-->
				</td>
				<td rowspan="6" class="picpro" id = "previewId">
					<c:choose>
						<c:when test="${profileImgSeq>0 }">
							<div class="photo_aspect aspect_3_4"><img id="prev_previewId" src="<c:url value='/file/downFile.do?uploadType=PROFILEIMG&downFileList=${profileImgSeq}' />" /></div>
						</c:when>
						<c:otherwise>
							<div class="photo_aspect aspect_3_4" id = "prev_previewId"><img id="prev_previewId" src="" /></div>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th class="bg_skyblue2"><label for="engNm">영어</label></th>
				<td>${userDetail.engNm }</td>
				<th class="bg_skyblue2">로그인ID</th>
				<td colspan="2">${userDetail.loginId }</td>
			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2">소속그룹</th>
				<td>${userDetail.companyNm }</td>
				<th class="bg_skyblue2">소속 관계사</th>
				<td colspan="2">${userDetail.orgNm }</td>
			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="IDNAME05">채용형태</label></th>
				<td id = "userStatusArea">
					${userDetail.empNm }
					<!-- <select class="select_b w100pro" id="IDNAME05" title="채용형태">

					</select> -->
				</td>
				<th class="bg_skyblue2">직위</th>
				<td colspan="2">${userDetail.rankNm }</td>
			</tr>
			<tr>
				<th rowspan="2" colspan="2" class="bg_skyblue2"><label for="IDNAME06">부서</label></th>
				<td colspan="4">
					<span>대표부서:</span>
						<c:forEach items="${userDeptList }" var = "data">
							<c:if test = "${data.mainYn eq 'Y' }">${data.deptNm }</c:if>
						</c:forEach>
				</td>
			</tr>

			<tr>
				<td colspan="4" class="dot_line" id = "deptArea">
					<c:forEach items="${userDeptList }" var = "data" varStatus="i">
							<span class="employee_list2">
								<c:if test="${i.index ne 0 }">, </c:if>
								${data.deptNm }
								<input type="hidden" name = "incharge" value="${data.incharge }">
								<input type="hidden" name = "deptNm" value="${data.deptNm }">
								<input type="hidden" name = "deleteFlag" value="N">
								<c:if test="${data.incharge eq 'DEPT_MGR' }">
									<em>(부서장)</em>
								</c:if>
							</span>

							<input type="hidden" name="deptId" value="${data.deptId }">
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
				<td colspan="3">
					<c:if test = "${userDetail.outOfOfficeTracking eq 'Y' }">예</c:if>
					<c:if test = "${userDetail.outOfOfficeTracking eq 'N' }">아니오</c:if>
				</td>

			</tr>

			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="IDNAME04">휴직이력</label></th>
				<td colspan="5">
				  	<!--재직상태-->
					<table width="100%" class="tb_regi_basic2" summary="재직상태입력 " id = "sttsTable">
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
									<td class="txt_center">
										<fmt:formatDate value="${data.sttsFromDt}" pattern="yyyy/MM/dd"/>
										<span class="dashLine">~</span>
										<fmt:formatDate value="${data.sttsEndDt}" pattern="yyyy/MM/dd"/>

									</td>
									<td>${data.memo}</td>
								</tr>
								</c:forEach>
								<c:if test="${fn:length(userSttsHist)<=0 }">
									<td colspan="3" class="no_result" style="text-align: center;">
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
					<fmt:formatDate value="${userDetail.hiredDate}" pattern="yyyy/MM/dd"/>
				</td>
				<th class="bg_skyblue2"><label for="passport">담당업무</label></th>
				<td colspan="3">${userDetail.work }</td>
			</tr>
			<tr>
				<th colspan="2" class="bg_skyblue2"><label for="joinDate">정직원 발령</label></th>
				<td><fmt:formatDate value="${userDetail.joinDate}" pattern="yyyy/MM/dd"/></td>

				<th class="bg_skyblue2"><label for="birth">생일</label></th>
				<td colspan="3">
					<fmt:formatDate value="${userDetail.birth}" pattern="yyyy/MM/dd"/>
					<c:if test = "${userDetail.solar eq 'Y' }">양력</c:if>
					<c:if test = "${userDetail.solar eq 'N' }">음력</c:if>
				</td>
			</tr>
			<tr>
				<th colspan="2" rowspan="2" class="bg_skyblue2">주소</th>
				<td colspan="5">
					${userDetail.homeZip }
				</td>
			</tr>
			<tr>
				<td colspan="5">
					${userDetail.homeAddr1 }<br>
					${userDetail.homeAddr2 }
				</td>
			</tr>

            <tr>
				<th colspan="2" class="bg_skyblue2"><label for="IDNAME20">진급</label></th>
				<td colspan="5">
					<!--진급-->
					<table width="100%" class="tb_regi_basic2" summary="인사정보 부가정보입력 (진급)" id = "rankTable">
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
							</tr>
							<c:forEach items="${userInsideCareer }" var = "data" varStatus="i">
								<tr>
									<td class="txt_center">
										<fmt:formatDate value="${data.promotionDt}" pattern="yyyy/MM/dd"/>
									<td>
										${data.position }
									</td>
									<td>${data.memo }</td>
								</tr>
							</c:forEach>
							<c:if test = "${fn:length(userInsideCareer)<=0 }">
								<tr>
				                    <td colspan="3" class="no_result" style="text-align: center;">
				                        <p class="nr_des">검색 결과가 없습니다.</p>
				                    </td>
				                </tr>
							</c:if>
						</tbody>
					</table>
					<!--//진급//-->
				</td>
			</tr>
			<%-- <tr>
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
			</tr> --%>
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
					${userDetail.mobileTel }
				</td>
				<th class="bg_skyblue2"><label for="companyTel">내선번호</label></th>
				<td>
					${userDetail.companyTel }
				</td>
			</tr>
			<tr>
				<th class="bg_skyblue2"><label for="homeTel1">집전화</label></th>
				<td>
					${userDetail.homeTel }
				</td>
				<th class="bg_skyblue2"><label for="email">이메일</label></th>
				<td>${userDetail.email }</td>
			</tr>

			<tr>
				<th class="bg_skyblue2"><label for="sosTel1">긴급연락</label></th>
				<td colspan="3" id = "sosTelArea">
					${userDetail.sosTel}(${userDetail.sosWhoNm})

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
				<td>${userDetail.hobby }</td>
				<th class="bg_skyblue2"><label for="IDNAME26">혈액형</label></th>
				<td>
					<c:if test="${!empty userDetail.bloodRhNm}">(${userDetail.bloodRhNm })</c:if>
					${userDetail.bloodNm }
				</td>
			</tr>
			<tr>
				<th class="bg_skyblue2"><label for="IDNAME27">결혼일</label></th>
				<td class="txt_left">
					<c:if test = "${userDetail.marriedDate eq null or userDetail.marriedDate eq '' }">
					미혼
					</c:if>
					<c:if test = "${userDetail.marriedDate ne null and userDetail.marriedDate ne '' }">
					기혼(<fmt:formatDate value="${userDetail.marriedDate}" pattern="yyyy/MM/dd"/>)
					</c:if>
				</td>
				<th class="bg_skyblue2"><label for="IDNAME28">종교</label></th>
				<td>
					${userDetail.religionNm }
				</td>
			</tr>
			<tr>
				<th class="bg_skyblue2"><label for="passport">여권번호</label></th>
				<td colspan="3">${userDetail.passport }</td>
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
				<col width="*" />
				<col width="*" />
				<col width="115" />
				<col width="*" />
				<col width="*" />
				<col width="90" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="${fn:length(userFamily)+1 }" scope="row" id = "familyTitle">가족<br>관계</th>
					<th scope="col" class="bg_skyblue">관계</th>
					<th scope="col" class="bg_skyblue">성명</th>
					<th scope="col" class="bg_skyblue">생년월일</th>
					<th scope="col" class="bg_skyblue">직업</th>
					<th scope="col" class="bg_skyblue">동거여부</th>
				</tr>
				<c:forEach items="${userFamily }" var = "data">
					<tr>
						<td>
							 ${data.relationNm }
						</td>
						<td>${data.familyNm }</td>
						<td class="txt_center">
							<fmt:formatDate value="${data.birthDt}" pattern="yyyy/MM/dd"/>
						</td>
						<td>${data.job }</td>
						<td class="txt_center">
							<c:if test = "${data.liveinYn eq 'Y' }">동거</c:if>
							<c:if test = "${data.liveinYn eq 'N' }">비동거</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test = "${fn:length(userFamily)<=0 }">
					<tr>
	                    <td colspan="6" class="no_result">
	                        <p class="nr_des">검색 결과가 없습니다.</p>
	                    </td>
	                </tr>
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
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" rowspan="${fn:length(userAcademic)+1 }" id = "academicTitle">학력<br>사항</th>
					<th scope="col" class="bg_skyblue">재학기간</th>
					<th scope="col" class="bg_skyblue">학교명</th>
					<th scope="col" class="bg_skyblue">전공</th>
					<th scope="col" class="bg_skyblue">구분</th>
				</tr>
				<c:forEach items="${userAcademic }" var="data">
					<tr>
						<td class="txt_center">
							${fn:replace(data.enteredDt,'-','/')}
							<span class="dashLine">~</span>
							${fn:replace(data.graduateDt,'-','/')}
						</td>
						<td>
							${data.academicNm }(${data.schoolTypeNm })
						</td>
						<td>${data.major }</td>
						<td>
							${data.graduateTypeNm }
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(userAcademic)<=0 }">
					<tr>
	                    <td colspan="5" class="no_result" style="text-align: center;">
	                        <p class="nr_des">검색 결과가 없습니다.</p>
	                    </td>
	                </tr>
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
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" rowspan="${fn:length(userCareer)+1 }" id = "careerTitle">경력<br>사항</th>
					<th scope="col" class="bg_skyblue">입사일/퇴사일</th>
					<th scope="col" class="bg_skyblue">회사명</th>
					<th scope="col" class="bg_skyblue">직위</th>
					<th scope="col" class="bg_skyblue">직무</th>
				</tr>
				<c:forEach items="${userCareer }" var = "data">
					<tr>
						<td class="txt_center">
							<fmt:formatDate value="${data.joinCpnDt}" pattern="yyyy/MM/dd"/>
							<span class="dashLine"> ~ </span>
							<fmt:formatDate value="${data.resignCpnDt}" pattern="yyyy/MM/dd"/>
						</td>
						<td>${data.companyNm }</td>
						<td>
							${data.rankNm }
						</td>
						<td>${data.job }</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(userCareer)<=0 }">
					<tr>
	                    <td colspan="5" class="no_result" style="text-align: center;">
	                        <p class="nr_des">검색 결과가 없습니다.</p>
	                    </td>
	                </tr>
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
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" rowspan="${fn:length(userLicense)+1 }" id = "licenseTitle">자격증</th>
					<th scope="col" class="bg_skyblue">자격증/면허증</th>
					<th scope="col" class="bg_skyblue">발행처/기관</th>
					<th scope="col" class="bg_skyblue">취득날짜</th>
				</tr>
				<c:forEach items="${userLicense }" var = "data">
					<tr>
						<td>${data.licenseNm }</td>
						<td>${data.issue }</td>
						<td class="txt_center">
							<fmt:formatDate value="${data.obtainDt}" pattern="yyyy/MM/dd"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(userLicense)<=0 }">
					<tr>
	                    <td colspan="4" class="no_result" style="text-align: center;">
	                        <p class="nr_des">검색 결과가 없습니다.</p>
	                    </td>
	                </tr>
				</c:if>
			</tbody>
		</table>
		<!--//자격증//-->
	<!--버튼모음-->
	<!-- <div class="btn_baordZone2">
		<a href="javascript:$('#frm').submit()" class="btn_blueblack">확인</a>
	</div> -->
	<!--//버튼모음//-->
</div>
</form>
</section>