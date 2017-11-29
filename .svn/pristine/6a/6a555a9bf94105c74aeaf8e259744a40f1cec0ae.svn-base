<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/JavaScript" src="<c:url value='/js/part/login.js'/>"></script>
<script>
var fnObj = {
		pageStart : function() {
			$('#btnLeftMenuHide').show();	//왼쪽메뉴 숨김버튼 숨기기
			$('#btnLeftMenuShow').hide();	//왼쪽메뉴 보기버튼 보이게
		}
};

$(function() {
	fnObj.pageStart(); //화면세팅
});
</script>
<div class="deatailconWrap" id="modifyUsrIng">
	<section id="detail_contents">
		<div class="doc_AllWrap">
			<input type="hidden" id="loginId" value="${baseUserLoginInfo.loginId}">
			<input type="hidden" id="userId" value="${baseUserLoginInfo.userId}">
			<ul class="dot_list_st02 mgb20">
				<li>현재 비밀번호를 입력한 후 새로 사용할 비밀번호를 입력해주세요.</li>
				<li>사용중인 비밀번호를 잊으신 경우 관리자에게 문의하시면 비밀번호를 초기화 할 수 있습니다.</li>
				<li>영문,숫자,특수문자를 혼용하시면 보다 안전합니다. <em>(6자 이상 12자 이하, 영문은 대소문자 구분)</em></li>
			</ul>
			<!--재직증명서 신청-->
			<table class="tb_regi_basic" summary="비밀번호 변경">
				<caption>비밀번호 변경</caption>
				<colgroup>
					<col width="140" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">이름</th>
						<td><c:out value='${userInfo.userName}'/></td>
					</tr>
					<tr>
						<th scope="row">아이디</th>
						<td><c:out value='${userInfo.loginId}'/></td>
					</tr>
					<tr>
						<th><label for="cuPasswd">현재비밀번호</label><span class="star">*</span></th>
						<td><input type="password" class="input_b w240px" required="required" id="cuPasswd" maxlength="12"/></td>
					</tr>
					<tr>
						<th><label for="passwd">변경할 비빌번호</label><span class="star">*</span></th>
						<td><input type="password" class="input_b w240px" id="passwd" required="required"  maxlength="12"/><span
							class="spe_color_st4 mgl10">(영문, 숫자포함 6자~12자 이내, 영문 대소문자 구분)</span></td>
					</tr>
					<tr>
						<th><label for="passwd2">비빌번호 재입력</label><span class="star">*</span></th>
						<td><input type="password" class="input_b w240px" id="passwd2" required="required" maxlength="12"/></td>
					</tr>
				</tbody>
			</table>
			<!--// 비밀번호 변경 //-->

			<!--버튼모음-->
			<div class="btn_baordZone2">
				<a href="#"	class="btn_blueblack" id="modifyUsr_btnOk">저장</a>
			</div>
			<!--//버튼모음//-->
		</div>
	</section>
</div>
<div class="deatailconWrap" id="modifyUsrEnd" style="display:none">
    <section id="detail_contents">
        <div class="email_loginWrap">
            <div class="email_titleBox">
                <div class="can_emailout">
                    <p class="title">비밀번호가 정상적으로 변경되었습니다.</p>
                    <p class="des">변경된 비밀번호로 재로그인 해주시기 바랍니다.</p>
                    <p class="des2">확인버튼 클릭시 자동 로그아웃 됩니다.</p>
                </div>
            </div>
            <div class="email_btnZone">
                <button class="btn_blueblack" type="button" onClick="logout();">확인</button>
            </div>
        </div>
    </section>
</div>