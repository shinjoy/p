<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="deatailconWrap">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_emailset">
					<p class="title">사내메일, 이제 PASS에서 사용하세요.</p>
					<p class="des">메일계정만 추가하면 쉽게 연동이 가능합니다.</p>
				</div>
			</div>
			<div class="email_chBox">
				<div class="email_chCon">
					<p class="idch"><input type="text" class="input_b" placeholder="아이디" /></p>
					<p class="passch"><input type="text" class="input_b" placeholder="비밀번호" /></p>
					<p class="sys_p_noti"><span class="icon_noti"></span><span>사내메일 연동 시</span> <span class="pointB"> 자동로그인 상태로 변경</span><span>됩니다.</span></p>
					<button type="button" class="email_ckbtn">사내메일<br/>연동하기</button>
				</div>
			</div>
		</div>
	</section>
</div>



<div class="deatailconWrap">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_emailset">
					<p class="title">PASS는 사내메일을 연동하여 사용합니다.</p>
					<p class="des">사용중인 사내메일 로그인 정보를 입력해주세요.</p>
				</div>
			</div>
			<div class="email_chBox">
				<div class="email_chCon">
					<p class="idch"><input type="text" class="input_b" placeholder="아이디" disabled="disabled" readonly="readonly" /></p>
					<p class="passch"><input type="text" class="input_b" placeholder="비밀번호" /></p>
					<p class="sys_p_noti"><span class="icon_noti"></span><span>현재 사용중인 사내메일의 연동해제를 원하시면 <a href="javascript:alert('사내메일 연동해제시 등록된 메일계정도 함께 삭제됩니다.');" class="pointB">[연동해제]</a>를 눌러주세요.</span><br/><span class="pointred">(연동해제시 등록된 메일계정은 삭제됩니다.)</span></p>
					<button type="button" class="email_ckbtn">메일계졍<br/>정보변경</button>
				</div>
			</div>
		</div>
	</section>
</div>


<div class="deatailconWrap">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_emailout">
					<p class="title">메일계정이 정상적으로 변경되었습니다.</p>
					<p class="des">확인버튼 클릭시 메일 서비스로 이동됩니다.</p>
				</div>
			</div>
			<div class="email_btnZone">
				<button type="button" class="btn_blueblack">확인</button>
			</div>
		</div>
	</section>
</div>


<div class="deatailconWrap">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_emailout">
					<p class="title">계정정보가 정상적으로 삭제되었습니다.</p>
					<p class="des">메일서비스를 이용하시려면 사내메일 로그인 정보를 다시 등록해주세요.</p>
				</div>
			</div>
			<div class="email_btnZone">
				<button type="button" class="btn_blueblack">계정설정</button><button type="button" class="btn_witheline">메인으로</button>
			</div>
		</div>
	</section>
</div>


<div class="deatailconWrap">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_changepass">
					<p class="title">비밀번호가 정상적으로 변경되었습니다.</p>
					<p class="des">변경된 비밀번호로 재로그인 해주시기 바랍니다.</p>
					<p class="des2">확인버튼 클릭시 자동 로그아웃 됩니다.</p>
				</div>
			</div>
			<div class="email_btnZone">
				<button type="button" class="btn_blueblack">확인</button>
			</div>
		</div>
	</section>
</div>