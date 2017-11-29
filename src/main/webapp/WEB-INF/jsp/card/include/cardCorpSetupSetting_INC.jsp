<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

	<form id="linkAgefrm" name="linkAgefrm">
		<!--법인카드 사용내역 연동 기능 사용여부-->

		<h3 class="h3_title_basic mgt20">
		    <span>2. 법인카드 사용내역 연동 기능 사용여부</span>
	    </h3>
        <article class="paymentsetBox">
            <div class="gray_notibox radio_list4">
                <label>
                    <input class="disableUse authChk" name="orgCardLinkYn" id="orgCardLinkYn" type="radio" value="N" <c:if test="${getCardCorpSetup.orgCardLinkYn eq 'N' || getCardCorpSetup.orgCardLinkYn == null}">checked="checked"</c:if> onclick="linkageYn('N');"/><span>미사용</span>
                </label>
                <label>
                    <input name="orgCardLinkYn" class="authChk" id="orgCardLinkYn" type="radio" value="Y" <c:if test="${getCardCorpSetup.orgCardLinkYn eq 'Y'}">checked="checked" </c:if>onclick="linkageYn('Y')"/><span>사용</span>
                </label>
            </div>
	        <p class="notice_script">* 법인카드 승인내역을 PASS와 자동으로 연동시켜주는 기능입니다.</p>
	        <p class="notice_script">* 해당 서비스를 제공하는 업체에 서비스 신청 후 연동에 필요한 정보를  입력하여 연동되면 사용가능합니다.</p>
	    </article>

        <h3 class="h3_title_basic">
            <span>3. 연동정보</span>
        </h3>

		<!-- 법인카드 사용내역 연동 기능 사용여부 -->
		<div class="deatailconWrap" id="deatailconWrap">
		    <table class="tb_regi_basic" summary="연동정보 저장">
				<caption>법인카드 사용내역 연동 기능 사용여부</caption>
				<colgroup>
					<col width="200">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<input type="hidden" name="cardCorpSetupId" id="cardCorpSetupId" value="${getCardCorpSetup.cardCorpSetupId }" />
						<th scope="row"><span class="star">* </span>사업자등록번호</th>
						<input type="hidden" name="bizNo" id="bizNo" value="${getCardCorpSetup.corpNum }" />
						<input type="hidden" name="corpNum" id="corpNum" value="${getCardCorpSetup.corpNum }" />
						<td>
							<input type="text" name="bizNum1" id="bizNum1" value="" size="3" maxlength="3" class="input_b w190px disableUse" onkeyup="isNumChk($(this));"/>
						  - <input type="text" name="bizNum2" id="bizNum2" value="" size="2" maxlength="2" class="input_b w190px disableUse" onkeyup="isNumChk($(this));"/>
						  - <input type="text" name="bizNum3" id="bizNum3" value="" size="5" maxlength="5" class="input_b w190px disableUse" onkeyup="isNumChk($(this));"/>
						  <p class="notice_script">* 귀사의 사업자번호를 입력해주시면 됩니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="star">* </span>대상업체선택</th>
						<td><div id="agentSelectTag" class="disableUse"></div></td>
					</tr>

					<tr>
						<th><label for="linkAuthCode"><span class="star">* </span>인증코드입력</label></th>
						<td>
						    <input type="text" class="input_b w240px disableUse" name="linkAuthCode" id="linkAuthCode" value="${getCardCorpSetup.linkAuthCode }" required="required" onkeyup="setNumChk($(this));" placeholder='"-"까지 입력해주세요'  maxlength="45">
						</td>
 						</td>
					</tr>
					<tr>
						<th><label for="linkAuthId"><span class="star">* </span>아이디</label></th>
						<td><input type="text" class="input_b w240px disableUse" name="linkAuthId" id="linkAuthId" value="${getCardCorpSetup.linkAuthId }" required="required" maxlength="20"></td>
					</tr>
					<tr>
						<th><label for="linkAuthPw"><span class="star">* </span>비밀번호</label></th>
						<td><input type="password" class="input_b w240px disableUse" name="linkAuthPw" id="linkAuthPw" value="${getCardCorpSetup.linkAuthPw }" required="required" maxlength="20"></td>
					</tr>
				</tbody>
			</table>
		</div>
		<br>

		<!--버튼영역-->
         <div class="btn_baordZone2">
             <a id="disableUse" name="disableUse"  href="javascript:doSaveLinkage();" class="btn_blueblack btn_auth disableUse">연동/저장</a>
             <a id="disableUse" name="disableUse"  href="javascript:linkageReset();" class="btn_witheline btn_auth disableUse">초기화</a>
         </div>
         <!--//버튼영역//-->
	</form>
	<!-- //법인카드 사용내역 연동 기능 사용여부 //-->


