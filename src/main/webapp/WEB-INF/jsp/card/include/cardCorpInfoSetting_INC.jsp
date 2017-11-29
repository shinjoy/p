<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!--법인카드 설정-->
<form id="cardCorpInfoFrm" name="cardCorpInfoFrm">
	<div  id="cardCorpInfoArea">

	<h3 class="h3_title_basic mgt20"><span>1. 법인카드등록</span>
        <a id="loadInfoBtn" class="s_violet01_btn mgl15" href="javascript:getCorporationCardLinkList();"><em>카드정보 불러오기</em></a>
    </h3>
    <p class="notice_script">* 법인카드 정보를 등록하시면 카드소지자 관리 및 지출입력시 카드를 선택하여 입력 가능 합니다.</p>

	<table class="tb_list_basic" summary="법인카드 설정(번호, 카드사, 카드번호, 카드별명, 소유자, 사용여부, 비고, 등록자, 수정자)">
		<caption>법인카드 설정</caption>
		<colgroup>
			<col width="50" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="80" class="cardLinkYnView"/>	<!-- 연동 여부 -->
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="120" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">카드사</th>
				<th scope="col">카드번호</th>
				<th scope="col">카드별명</th>
				<th scope="col">소유자</th>
				<th scope="col">사용여부</th>
				<th scope="col" class="cardLinkYnView">연동 여부</th>
				<th scope="col">비고</th>
				<th scope="col">등록자</th>
				<th scope="col">수정자</th>
				<th scope="col" colspan="2">-</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
			<c:when test="${not empty cardCorpInfoSetupList}">
			<c:forEach items="${cardCorpInfoSetupList }" var="data" varStatus="i">
				<tr id="cardCompany_${data.cardCorpInfoId }">
					<th>
						<span class="">${i.index+1}</span>
						<input type="hidden" name="cardCorpInfoId" value="${data.cardCorpInfoId }">
					</th>
					<!-- 카드사 -->
					<td>
						<span class="cardCompanyView">${data.cardCompany }</span>
						<input name="cardCompanyModi" id="cardCompany_${i.index }"type="text" value="${data.cardCompany }" class="cardCorpInfoInput input_b w100" title="카드사 입력">
						<!--
						<span class="cardCompanyView">${data.cardCompanyNm }</span>
						<input type="hidden" id="cardCompany_${i.index }" value="${data.cardCompany }">
						<span class="cardCorpInfoInput" id="cardCompanyTag${i.index }"></span>

						<script type="text/javascript">
							$("#cardCompanyTag${i.index }").html(docStatusTypeTag);

							$("#cardCompanyTag${i.index }").find("#cardCompany").val("${data.cardCompany}")
						</script>
						-->
					</td>
					<!-- 카드번호 -->
					<div id="notice"></div>

					<td>
						<span class="cardCompanyView" id="cardNumHt1${i.index }" class="AXInput W30 each">
						<em id="cardNumView">${data.cardNum1 }-${data.cardNumPw2 }-${data.cardNumPw3 }-${data.cardNum4 }</em>
 					    <%-- <em id="cardNumView">${data.cardNum }</em> --%>
						</span>
						<input type="hidden" name="cardNo" id="cardNo_${i.index }" value="${data.cardNum }" />
						<input name="cardNum" id="cardNum1${i.index }" value="${data.cardNum1 }" type="text" class="AXInput W30 cardCorpInfoInput" size="4" maxlength="4" onkeyup="cardNumChk($(this));" title="카드번호1 입력"><em class="cardCorpInfoInput">-</em>
						<input name="cardNum" id="cardNum2${i.index }" value="${data.cardNum2 }" type="text" class="AXInput W30 cardCorpInfoInput" size="4" maxlength="4" onkeyup="cardNumChk($(this));" title="카드번호2 입력"><em class="cardCorpInfoInput">-</em>
						<input name="cardNum" id="cardNum3${i.index }" value="${data.cardNum3 }" type="text" class="AXInput W30 cardCorpInfoInput" size="4" maxlength="4" onkeyup="cardNumChk($(this));" title="카드번호3 입력"><em class="cardCorpInfoInput">-</em>
						<input name="cardNum" id="cardNum4${i.index }" value="${data.cardNum4 }" type="text" class="AXInput W30 cardCorpInfoInput" size="4" maxlength="4" onkeyup="cardNumChk($(this));" title="카드번호4 입력">
						<!-- 기존 텍스트박스
						<input name="cardNum" id="cardNum${i.index }" type="text" value="${data.cardNum }" class="AXInput W30 cardCorpInfoInput" title="카드번호 입력">
						-->
					</td>

					<!-- 카드별명 -->
					<td>
						<span class="cardCompanyView">${data.cardNickNm }</span>
						<input name="cardNickname" id="cardNickname${i.index }"type="text" value="${data.cardNickNm }" class="input_b w100 cardCorpInfoInput" title="카드별명 입력">
					</td>
					<!-- 소유자 -->
					<td>
						<!-- <input type="hidden" id="cardOwnerUserId_${i.index }" value="${data.cardOwnerUserId }"> -->
						<button type="button" id="cardCorpInfoInput_${i.index }" class="cardCorpInfoInput btn_select_employee mgl6" onclick="fnObj.openEmpPopupCorp('CARDMODY', '', '','${i.index }')"><em>직원선택</em></button>
						<input type="hidden" name="cardOwnerUserId" id="cardOwnerUserId_${i.index }" value="${data.cardOwnerUserId }">
						<span class="cardCompanyView2">
							<span id="spanCardModi_${i.index }">
								<c:if test="${not empty data.cardOwnerUserId }">
									<em>${data.cardOwnerUserNm }(${data.rankNm })</em>
								</c:if>
							</span>
						</span>
					</td>
					<!-- 사용여부 -->
					<td class="radio_list4">
						<input type="hidden" id="cardCompany_${data.cardCorpInfoId }_useYn" value="${data.useYn }">
						<c:choose>
							<c:when test="${!empty data.useYn }">
							<label>
								<input type="radio" name="useYn_cardCompany_${data.cardCorpInfoId }" disabled="disabled" value="Y" <c:if test = "${data.useYn eq 'Y' }">checked="checked"</c:if>/><span>Yes</span>
							</label>
							<label>
								<input type="radio" name="useYn_cardCompany_${data.cardCorpInfoId }" disabled="disabled" value="N" <c:if test = "${data.useYn eq 'N' }">checked="checked"</c:if>/><span>No</span>
							</label>
							</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>

					<!-- 연동 여부 -->
					<td class="radio_list4 cardLinkYnView">
						<input type="hidden" name="cardLinkYn_${i.index }" id="cardCompany_${data.cardCorpInfoId }_cardLinkYn" value="${data.cardLinkYn }">
						<span class="">${empty data.cardLinkYn?'-':data.cardLinkYn }</span>
					</td>
					<!-- 비고 -->
					<td>
						<span class="cardCompanyView">${data.comment }
							<c:if test="${empty data.cardLinkYn }"><p class="notice_script">[카드번호 확인 필요]</p></c:if>
							<c:if test="${data.cardInputYn eq 'N' }"><p class="notice_script">[세부 정보 추가 필요]</p></c:if>

						</span>
						<input type="text" name="comment" id="comment${i.index }" value="${data.comment }" class="input_b w100 cardCorpInfoInput" title="비고내용 입력">
					</td>
					<td>
						<span class="" title="등록자">${data.createdByNm }</span>
					</td>
					<td>
						<span class="" title="수정자">${data.updatedByNm }</span>
					</td>
					<td>
						<a href="javascript:showUpdateForm('cardCompany_${data.cardCorpInfoId }','${i.index }')" class="s_gray01_btn btn_auth cardCompanyView"><em>수정</em></a>
						<!-- <a href="javascript:deleteCard('${data.cardCorpInfoId }')" class="s_gray01_btn mgl8 cardCompanyView"><em>삭제</em></a> -->
						<a href="javascript:doSaveCard('cardCompany_${data.cardCorpInfoId }', '${i.index }')" class="btn_s_type_blue2 btn_auth cardCorpInfoInput"><em>저장</em></a>
						<button type="button" id="btnReset" class="btn_s_replay mgl8 cardCorpInfoInput" onclick="reset('${i.index}')"><em>새로고침</em></button>
					</td>
				</tr>
			</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="11" align="center" style="height:45px;">등록된 내용이 없습니다.</td>
				</tr>
			</c:otherwise>
			</c:choose>
			<tr id="new">
				<th>
					<input type="hidden" name="cardCorpInfoId" value="0">
				</th>
				<!-- 카드사 -->
				<td>
					<!-- <span id="cardCompanyTag"></span> -->
					<input name="cardCompany" type="text" class="input_b w100" title="카드사 입력">
				</td>
				<!-- 카드번호 -->
				<td>
					<input name="cardNum11" id="cardNum1" type="text" class="AXInput W30" size="4" maxlength="4" onkeyup="cardNumChk($(this));" title="카드번호1 입력">
				  - <input name="cardNum22" id="cardNum2" type="text" class="AXInput W30" size="4" maxlength="4" onkeyup="cardNumChk($(this));" title="카드번호2 입력">
				  -	<input name="cardNum33" id="cardNum3" type="text" class="AXInput W30" size="4" maxlength="4" onkeyup="cardNumChk($(this));" title="카드번호3 입력">
				  -	<input name="cardNum44" id="cardNum4" type="text" class="AXInput W30" size="4" maxlength="4" onkeyup="cardNumChk($(this));" title="카드번호4 입력">
				</td>
				<!-- 카드별명 -->
				<td>
					<input name="cardNickname" type="text" class="input_b w100" title="카드별명 입력">
				</td>
				<!-- 소유자 -->
				<td>
					<a class="btn_select_employee mgl6" href="javascript:fnObj.openEmpPopupCorp('CARD', '', '');"><em>직원선택</em></a>
					<!-- <div class="gray_notibox" id="spanCard"> -->
<%-- 			            <c:forEach items="${cardManagerSetupList}" var="data" varStatus="status"> --%>
							<span class="cardCorpInfo_list" id="spanCard">
<%-- 							<span>${data.userName}</span> --%>
								<input type="hidden" name="arrUserId" id="arrUserId" value="" />
							</span>
<%-- 			   			</c:forEach> --%>
			        <!-- </div> -->
				</td>
				<!-- 사용여부 -->
				<td class="radio_list4">
					<label>
						<input name="useYn_new" type="radio" value="Y" checked="checked" /><span>Yes</span>
					</label>
					<label>
						<input name="useYn_new" type="radio" value="N"/><span>No</span>
					</label>
				</td>
				<!-- 연동 여부 -->
				<td class="cardLinkYnView"></td>
				<!-- 비고 -->
				<td>
					<input type="text" name="comment" class="input_b w100" placeholder="" title="비고내용 입력">
				</td>
				<!-- 버튼 -->
				<td class="colspanCtrl" colspan="3">
					<a href="javascript:doSaveCard('new')" class="btn_s_type_blue2 btn_auth"><em>추가/저장</em></a>
					<button type="button" class="btn_s_type_blue2 btn_auth" onclick="reset('new')"><em>초기화</em></button>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
</form>
<!--// 법인카드 설정 //-->
