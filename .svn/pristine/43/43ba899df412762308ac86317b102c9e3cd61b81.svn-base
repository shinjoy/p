<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="js/regCstPopup_JS.jsp" %>

<form id="searchCst" name="searchCst" action="<c:url value='/person/main.do' />" method="post">
    <input type="hidden" id="nameSearch" name="cstNm">
</form>

<form id="personLeft" name="personLeft" action="<c:url value='/person/personMgmt.do' />" method="post"></form>
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<input type="hidden" id="tmpTak" value="${page}">
<input type="hidden" id="cst_snb" value="">
<input type="hidden" id="rtn" value="">

<input type="hidden" id="fromMain" value="${fromMain}"> <!-- 메인페이지 위젯 추가를 통해 등록하는 것인지 체크 ...fromMain=='y' -->

<form id="customerName" name="customerName" action="<c:url value='/person/main.do' />" method="post">
    <input type="hidden" id="sNb" name="sNb" value="${cst.sNb}">
</form>

<form id="viewerFrm" name="viewerFrm" >
<input type="hidden" id="searchCstNm" name="searchCstNm">

</form>


<form name="rgstForm">
<input type="hidden" id="actionType" name="actionType" value="${actionType}"/>
<input type="hidden" id="sNb" name="sNb" value="${cst.sNb}">
<input type="hidden" id="cstId" name="cstId" value="${cst.cstId}">
<input type="hidden" id="customerDupChkCnt" name="customerDupChkCnt" value="0">
<input type="hidden" id="companyPopType" name="companyPopType"/>

<input type="hidden" name="openPage"  id="openPage" value="${openPage}"/>
<input type="hidden" name="workCstNm"  id="workCstNm" value="${workCstNm}"/>

    <!--인물등록-->
    <div id="RegistNewPerson">
        <div class="modalWrap2">
            <h1><strong>${actionType eq 'INSERT' ? '고객신규등록':'고객수정' }</strong></h1>
            <div class="mo_container">
                <div class="RegistPersonBox">
                    <h2 class="title_arrow"><span>고객정보</span></h2>
                    <table class="net_table_apply" summary="고객정보입력(구분,이름,소속회사,부서,직위,연락처,이메일,친밀도,이력 등)">
                        <caption>고객정보입력</caption>
                        <colgroup>
                            <col width="12%" />
                            <col width="37%" />
                            <col width="8%" />
                            <col width="*" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row">인물구분<span class="star">*</span></th>
                                <td colspan="3">
                                    <span id="cstRadioTag" class="radio_list3"></span>
                                </td>
                            </tr>
                            <tr class="point">
                                <th scope="row" rowspan="2"><label for="cstNm">이름<span class="star">*</span></label></th>
                                <td rowspan="2">
                                    <input type="hidden" id="oldCstNm" value="${cst.cstNm}" />
                                    <input type="text" id="cstNm" value="${cst.cstNm}" style="ime-mode:active;display:none;" class="applyinput_B w_st01" />
                                    <a href="javascript:customerDupChkPopup();" class="s_violet01_btn mgl6"><em class="search">고객중복체크</em></a>
                                    <div id="divDupComment"><br/>※고객등록을 위해 고객중복체크를 진행해주세요.</div>
                                </td>
                                <th scope="row"><label for="mfSex">성별</label></th>
                                <td>
                                    <ul class="itemList">
                                        <li><label><input type="radio" id="mfSex" name="mfSex"  value="M"  ${cst.mfSex eq 'M' ? 'checked':''}/><span>남자</span></label></li>
                                        <li><label><input type="radio" id="mfSex" name="mfSex" value="F"  ${cst.mfSex eq 'F' ? 'checked':''}/><span>여자</span></label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                            	<th scope="row"><label for="domesticYn">국내외<br>구분<span class="star">*</span></label></th>
                            	 <td>
                                    <ul class="itemList">
                                        <li><label><input type="radio" name="domesticYn"  value="Y"  onclick="chkDomestic()" ${cst.domesticYn eq null or cst.domesticYn eq 'Y' ? 'checked':''}/><span>국내</span></label></li>
                                        <li><label><input type="radio" name="domesticYn" value="N"  onclick="chkDomestic()" ${cst.domesticYn eq 'N' ? 'checked':''}/><span>해외</span></label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="cpnId">소속회사</label></th>
                                <td>
                                    <input class="regist" type="hidden" id="cpnId"  value="${cst.cpnId }"/>
                                    <input type="text" class="applyinput_B w_st01" id="cpnNm" value="${cst.cpnNm}"  readonly="readonly"/>
                                    <%-- <c:if test="${empty cst.cpnId}"> --%>
                                    <c:if test="${(cst.userCnt eq 0) || (empty cst.userCnt) }"> <!-- bs_user_master 에 퇴사/해고가 아닌 사용자 등록카운트 -->
                                    	<a href="javascript:companyPopUp('COMPANY');" class="s_violet01_btn mgl6"><em class="search">검색</em></a>
                                    </c:if>
                                    <%-- </c:if> --%>
                                </td>
                                <th scope="row"><label for="IDName03">생년월일</label></th>
                                <td>
                                    <input type="text" class="applyinput_B w_st06" id="birth"  name="birth" value="${cst.birth}"  readonly="readonly" />
                                    <!-- <a href="#" class="btn_calendar"><img src="../images/network/icon_calendar.gif" alt="생년월일선택" /></a> -->
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="IDName04">소속부서</label></th>
                                <td><input type="text" class="applyinput_B w_st01" id="team"  value="${cst.team}" /></td>
                                <th scope="row">결혼여부</th>
                                <td>
                                    <ul class="itemList">
                                        <li><label><input type="radio" name="married"  id="married"  value="N"  ${cst.married eq 'N' ? 'checked':''}/><span>미혼</span></label></li>
                                        <li><label><input type="radio" name="married"  id="married"  value="Y"  ${cst.married eq 'Y' ? 'checked':''}/><span>기혼</span></label></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="IDName05">직위<span class="star">*</span></label></th>
                                <td><input type="text" id="position" value="${cst.position}" style="ime-mode:active;" class="applyinput_B w_st01" />
                                </td>
                                <th>자녀관계</th>
                                <td><ul class="itemList">
                                        <!-- <li><label><input type="radio" name="kind04" /><span>없음</span></label></li>
                                        <li><label><input type="radio" name="kind04" /><span>있음</span></label></li> -->
                                        <li><label>
                                                <span>男</span>
                                                <select class="sel_count" id="childM" name="childM">
                                                    <option value="0">0</option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                    <option value="6">6</option>
                                                    <option value="7">7</option>
                                                    <option value="8">8</option>
                                                    <option value="9">9</option>
                                                    <option value="10">10</option>
                                                </select>
                                            </label>
                                        </li>
                                        <li>
                                            <label>
                                                <span>女</span>
                                                <select class="sel_count"  id="childF" name="childF">
                                                    <option value="0">0</option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                    <option value="6">6</option>
                                                    <option value="7">7</option>
                                                    <option value="8">8</option>
                                                    <option value="9">9</option>
                                                    <option value="10">10</option>
                                                </select>
                                            </label>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="myWork">담당업무<span class="star">*</span></label></th>
                                <td><input type="text" class="applyinput_B w_st01" id="myWork"  name="myWork"  value="${cst.myWork}" /></td>
                                <th><label for="hometown">출생지</label></th>
                                <td><input type="text" class="applyinput_B w_st01" id="hometown"  name="hometown" value="${cst.hometown}" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="phn1_1">핸드폰<span class="star">*</span></label></th>
                                <td>
                                	<c:choose>
										<c:when test="${cst.domesticYn eq 'Y' }">
											<c:set var = "phn1" value="${cst.phn1}"></c:set>
										</c:when>
										<c:when test="${cst.domesticYn eq 'N' }">
											<c:set var = "overseasPhn1" value="${cst.phn1}"></c:set>
										</c:when>
									</c:choose>

                                    <input type="hidden" id="oldPhn1" value="${cst.phn1}" />

                                    <select class="sel_phone domestic" id="phn1_1"  name="phn1_1">
                                        <option value="">선택</option>
                                        <option value="010" <c:if test = "${fn:split(phn1,'-')[0] eq '010'  }">selected="selected"</c:if>>010</option>
                                        <option value="011" <c:if test = "${fn:split(phn1,'-')[0] eq '011'  }">selected="selected"</c:if>>011</option>
                                        <option value="016" <c:if test = "${fn:split(phn1,'-')[0] eq '016'  }">selected="selected"</c:if>>016</option>
                                        <option value="017" <c:if test = "${fn:split(phn1,'-')[0] eq '017'  }">selected="selected"</c:if>>017</option>
                                        <option value="018" <c:if test = "${fn:split(phn1,'-')[0] eq '018'  }">selected="selected"</c:if>>018</option>
                                        <option value="019" <c:if test = "${fn:split(phn1,'-')[0] eq '019'  }">selected="selected"</c:if>>019</option>
                                    </select>
                                    <span class="dashLine domestic">-</span> <input type="text" id="phn1_2"  name="phn1_2"  value="${fn:split(phn1,'-')[1]}" maxlength="4" class="input_phone digit domestic" title="핸드폰 중간번호" />
                                    <span class="dashLine domestic">-</span> <input type="text" id="phn1_3"  name="phn1_3"  value="${fn:split(phn1,'-')[2]}" maxlength="4" class="input_phone digit domestic" title="핸드폰 마지막번호" />

                                    <select class="sel_ability overseas" id="overseas_phn1_0" style="margin-left: 0px;width: 95px;">
										<option value="">국가번호선택</option>

										<c:forEach items="${contryCodeList }" var = "data">
											<option value="${data.codeValue }"  <c:if test = "${fn:split(overseasPhn1,'-')[0] eq data.codeValue  }">selected="selected"</c:if>>${data.codeNm }</option>
										</c:forEach>
									</select>
									<input type="text" id="overseas_phn1_1"  name="overseas_phn1_1"  value="${fn:split(overseasPhn1,'-')[1]}" maxlength="7" class="input_phone digit overseas" title="회사직통전화 앞번호" />
                                    <span class="dashLine overseas">-</span> <input type="text" id="overseas_phn1_2"  name="overseas_phn2_2"  value="${fn:split(overseasPhn1,'-')[2]}" maxlength="7" class="input_phone digit overseas" title="회사직통전화 중간번호" />
                                    <span class="dashLine overseas">-</span> <input type="text" id="overseas_phn1_3"  name="overseas_phn2_3"  value="${fn:split(overseasPhn1,'-')[3]}" maxlength="7" class="input_phone digit overseas" title="회사직통전화 마지막번호" />
                                </td>
                                <th rowspan="3"><label for="IDName20">학력</label></th>
                                <td rowspan="3" class="acaAbilitycon">
                                    <ul class="acaAbilityList">
                                        <li>
                                            <span id="schoolType1Tag" ></span>
                                            <input type="text"  id="schoolNm1"  value="${customerSchoolList[0].schoolNm }" class="applyinput_B w_st05" placeholder="학교명"/>
                                            <input type="text"  id="major1"  value="${customerSchoolList[0].major }" class="applyinput_B w_st05 mgl6" placeholder="전공" title="전공입력" /><span id="graduate1Tag"></span>
                                        </li>
                                        <li>
                                            <span id="schoolType2Tag" ></span>
                                            <input type="text"  id="schoolNm2"  value="${customerSchoolList[1].schoolNm }"  class="applyinput_B w_st05" placeholder="학교명"/>
                                            <input type="text"  id="major2"  value="${customerSchoolList[1].major }"  class="applyinput_B w_st05 mgl6" placeholder="전공" title="전공입력" /><span id="graduate2Tag"></span>
                                        </li>
                                        <li>
                                            <span id="schoolType3Tag" ></span>
                                            <input type="text"  id="schoolNm3"  value="${customerSchoolList[2].schoolNm }"  class="applyinput_B w_st05" placeholder="학교명"/>
                                            <input type="text"  id="major3"  value="${customerSchoolList[2].major }"  class="applyinput_B w_st05 mgl6" placeholder="전공" title="전공입력" /><span id="graduate3Tag"></span>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="IDName10">회사직통전화</label></th>
                                <td>
                                	<c:choose>
										<c:when test="${cst.domesticYn eq 'Y' }">
											<c:set var = "phn2" value="${cst.phn2}"></c:set>
										</c:when>
										<c:when test="${cst.domesticYn eq 'N' }">
											<c:set var = "overseasPhn2" value="${cst.phn2}"></c:set>
										</c:when>
									</c:choose>


                                    <input type="text" id="phn2_1"  name="phn2_1"  value="${fn:split(phn2,'-')[0]}" maxlength="4" class="input_phone digit domestic" title="회사직통전화 앞번호" />
                                    <span class="dashLine domestic">-</span> <input type="text" id="phn2_2"  name="phn2_2"  value="${fn:split(phn2,'-')[1]}" maxlength="4" class="input_phone digit domestic" title="회사직통전화 중간번호" />
                                    <span class="dashLine domestic">-</span> <input type="text" id="phn2_3"  name="phn2_3"  value="${fn:split(phn2,'-')[2]}" maxlength="4" class="input_phone digit domestic" title="회사직통전화 마지막번호" />

                                    <select class="sel_ability overseas" id="overseas_phn2_0" style="margin-left: 0px;width: 95px;">
										<option value="">국가번호선택</option>

										<c:forEach items="${contryCodeList }" var = "data">
											<option value="${data.codeValue }"  <c:if test = "${fn:split(overseasPhn2,'-')[0] eq data.codeValue  }">selected="selected"</c:if>>${data.codeNm }</option>
										</c:forEach>
									</select>
									<input type="text" id="overseas_phn2_1"  name="overseas_phn2_1"  value="${fn:split(overseasPhn2,'-')[1]}" maxlength="7" class="input_phone digit overseas" title="회사직통전화 앞번호" />
                                    <span class="dashLine overseas">-</span> <input type="text" id="overseas_phn2_2"  name="overseas_phn2_2"  value="${fn:split(overseasPhn2,'-')[2]}" maxlength="7" class="input_phone digit overseas" title="회사직통전화 중간번호" />
                                    <span class="dashLine overseas">-</span> <input type="text" id="overseas_phn2_3"  name="overseas_phn2_3"  value="${fn:split(overseasPhn2,'-')[3]}" maxlength="7" class="input_phone digit overseas" title="회사직통전화 마지막번호" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="IDName11">팩스</label></th>
                                <td>
									<c:choose>
										<c:when test="${cst.domesticYn eq 'Y' }">
											<c:set var = "fax" value="${cst.fax}"></c:set>
										</c:when>
										<c:when test="${cst.domesticYn eq 'N' }">
											<c:set var = "overseasFax" value="${cst.fax}"></c:set>
										</c:when>
									</c:choose>
                                    <input type="text" id="fax_1"  name="fax_1"  value="${fn:split(fax,'-')[0]}"  maxlength="4" class="input_phone digit domestic" title="팩스 앞번호" />
                                    <span class="dashLine domestic">-</span> <input type="text" id="fax_2"  name="fax_2"  value="${fn:split(fax,'-')[1]}"  maxlength="4" class="input_phone digit domestic"  title="팩스 중간번호" />
                                    <span class="dashLine domestic">-</span> <input type="text" id="fax_3"  name="fax_3"  value="${fn:split(fax,'-')[2]}"  maxlength="4" class="input_phone digit domestic" title="팩스 마지막번호" />

                                    <select class="sel_ability overseas" id="overseas_fax_0" style="margin-left: 0px;width: 95px;">
										<option value="">국가번호선택</option>

										<c:forEach items="${contryCodeList }" var = "data">
											<option value="${data.codeValue }"  <c:if test = "${fn:split(overseasFax,'-')[0] eq data.codeValue  }">selected="selected"</c:if>>${data.codeNm }</option>
										</c:forEach>
									</select>
									<input type="text" id="overseas_fax_1"  name="overseas_fax_1"  value="${fn:split(overseasFax,'-')[1]}"  maxlength="7" class="input_phone digit overseas" title="팩스 앞번호" />
                                    <span class="dashLine overseas">-</span> <input type="text" id="overseas_fax_2"  name="fax_2"  value="${fn:split(overseasFax,'-')[2]}"  maxlength="7" class="input_phone digit overseas"  title="팩스 중간번호" />
                                    <span class="dashLine overseas">-</span> <input type="text" id="overseas_fax_3"  name="fax_3"  value="${fn:split(overseasFax,'-')[3]}"  maxlength="7" class="input_phone digit overseas" title="팩스 마지막번호" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="IDName12">이메일</label></th>
                                <td>
                                    <input type="text" class="applyinput_B w_st01" id="email"  name="email"  value="${cst.email}"  />
                                </td>
                                <th><label for="IDName13">집전화</label></th>
                                <td>
									<c:choose>
										<c:when test="${cst.domesticYn eq 'Y' }">
											<c:set var = "homePhone" value="${cst.homePhone}"></c:set>
										</c:when>
										<c:when test="${cst.domesticYn eq 'N' }">
											<c:set var = "overseasHomePhone" value="${cst.homePhone}"></c:set>
										</c:when>
									</c:choose>
                                    <input type="text" id="homePhone_1" name="homePhone_1"  value="${fn:split(homePhone,'-')[0]}" maxlength="4" class="input_phone digit domestic" title="집전화 앞번호" />
                                    <span class="dashLine domestic">-</span> <input type="text" id="homePhone_2" name="homePhone_2"  value="${fn:split(homePhone,'-')[1]}" maxlength="4" class="input_phone digit domestic" title="집전화 중간번호" />
                                    <span class="dashLine domestic">-</span> <input type="text" id="homePhone_3" name="homePhone_3"  value="${fn:split(homePhone,'-')[2]}"  maxlength="4" class="input_phone digit domestic" title="집전화 마지막번호" />


                                    <select class="sel_ability overseas" id="overseas_homePhone_0" style="margin-left: 0px;width: 95px;">
										<option value="">국가번호선택</option>

										<c:forEach items="${contryCodeList }" var = "data">
											<option value="${data.codeValue }"  <c:if test = "${fn:split(overseasHomePhone,'-')[0] eq data.codeValue  }">selected="selected"</c:if>>${data.codeNm }</option>
										</c:forEach>
									</select>

									<input type="text" id="overseas_homePhone_1" name="overseas_homePhone_1"  value="${fn:split(overseasHomePhone,'-')[1]}" maxlength="7" class="input_phone digit overseas" title="집전화 앞번호" />
                                    <span class="dashLine overseas">-</span> <input type="text" id="overseas_homePhone_2" name="overseas_homePhone_2"  value="${fn:split(overseasHomePhone,'-')[2]}" maxlength="7" class="input_phone digit overseas" title="집전화 중간번호" />
                                    <span class="dashLine overseas">-</span> <input type="text" id="overseas_homePhone_3" name="overseas_homePhone_3"  value="${fn:split(overseasHomePhone,'-')[3]}"  maxlength="7" class="input_phone digit overseas" title="집전화 마지막번호" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="IDName16">담당자(직원)<span class="star">*</span></label></th>
                                <td colspan="3" class="vmanager">
                                	<span id="userSelectTag" style="<c:if test="${actionType eq 'UPDATE' }">display:none;</c:if>"></span>
                                	<c:if test="${actionType eq 'UPDATE' }">
                                		<span id = "staffNm">${cst.usrNm}</span>
                               		</c:if>
                                    <span>과(와)의</span>
                                    <strong class="mgl10">친밀도</strong>
                                    <input type="hidden" name="relDegree" id="relDegree"  ><!-- default value 1 -->
                                    <ul class="relationGrade mgl5">
                                        <li><a href="javascript:fnObj.chkRelationDegree(this,1);"  id="relDeg1" ><em>+1</em></a></li>
                                        <li><a href="javascript:fnObj.chkRelationDegree(this,2);"  id="relDeg2" ><em>+2</em></a></li>
                                        <li><a href="javascript:fnObj.chkRelationDegree(this,3);"  id="relDeg3" ><em>+3</em></a></li>
                                        <li><a href="javascript:fnObj.chkRelationDegree(this,4);"  id="relDeg4" ><em>+4</em></a></li>
                                        <li><a href="javascript:fnObj.chkRelationDegree(this,5);"  id="relDeg5"><em>+5</em></a></li>
                                        <li><span id="spanRelDeg" class="count">(+0)</span></li>
                                    </ul>
                                    <strong class="mgl25">관계메모</strong><input type="text" name="memo" id="memo"  value="${cst.memo}" class="applyinput_B w_st17 mgl6" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">이력</th>
                                <td colspan="3">
                                    <ul class="profileList">
                                        <li>
                                            <input type="hidden" id="companyId1"  value="${customerCareerList[0].companyId}" />
                                            <input type="text" id="companyNm1"  value="${customerCareerList[0].cpnNm}"  readonly="readonly" class="applyinput_B w_st03" placeholder="회사명" title="회사명입력" />
                                            <!-- <a href="javascript:companyPopUp('COMPANY_HIST1');" class="s_violet01_btn mgl6"><em class="search">검색</em></a> -->
                                            <a href="javascript:companyPopUp('COMPANY_HIST1');"" class="s_3d_gray01_btn mgl6">검색</a>
                                            <input type="text" id="departTeam1"   value="${customerCareerList[0].departTeam}"  class="applyinput_B w_st03 mgl8" placeholder="부서/직위" title="부서/직위입력" />
                                            <input type="text" id="careerMemo1"   value="${customerCareerList[0].memo}"  class="applyinput_B w_st07" placeholder="이력메모" title="이력입력" />
                                            <span class="txt_vm mgl15">재직기간 :&nbsp;</span>
                                            <select id="startDate1"  class="sel_datayear" title="재직기간 시작일 선택">
                                            </select>
                                            <span class="txt_vm">&nbsp;~&nbsp;</span>
                                            <select id="endDate1"  class="sel_datayear" title="재직기간 종료일 선택">
                                            </select>
                                        </li>
                                        <li>
                                            <input type="hidden" id="companyId2"  value="${customerCareerList[1].companyId}"  />
                                            <input type="text" id="companyNm2"   value="${customerCareerList[1].cpnNm}"  readonly="readonly" class="applyinput_B w_st03" placeholder="회사명" title="회사명입력" />
                                            <!-- <a href="javascript:companyPopUp('COMPANY_HIST2');" class="s_violet01_btn mgl6"><em class="search">검색</em></a> -->
                                            <a href="javascript:companyPopUp('COMPANY_HIST2');"" class="s_3d_gray01_btn mgl6">검색</a>
                                            <input type="text" id="departTeam2"  value="${customerCareerList[1].departTeam}"  class="applyinput_B w_st03 mgl8" placeholder="부서/직위" title="부서/직위입력" />
                                            <input type="text" id="careerMemo2"  value="${customerCareerList[1].memo}"  class="applyinput_B w_st07" placeholder="이력메모" title="이력입력" />
                                            <span class="txt_vm mgl15">재직기간 :&nbsp;</span>
                                            <select id="startDate2"  class="sel_datayear" title="재직기간 시작일 선택">
                                            </select>
                                            <span class="txt_vm">&nbsp;~&nbsp;</span>
                                            <select id="endDate2"  class="sel_datayear" title="재직기간 종료일 선택">
                                            </select>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <p class="table_notice"><span class="point">* 필수입력입니다.</span> 그외의 상세내역들도 입력해주시면 인물정보의 활용도가 높아집니다.  </p>
                    <div class="btnZoneBox">
                        <span class="btn_auth"><a href="javascript:fnObj.doSave();" class="p_blueblack_btn"><strong>저장</strong></a></span>
                        <a href="javascript:reloadMainPage();" class="p_withelin_btn">닫기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
    <!--//인물등록//-->

