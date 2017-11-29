<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<section id="detail_contents">
	<!--타이틀-->
	<h4 class="board_titleBox">
		<div class="fl_block"><span class="h4_title" id="gboardTitleNm">이용약관</span> <span class="h4_destxt" id="gboardDescNm" style="">PASS의 회원약관은 다음과 같은 내용을 담고 있습니다. </span></div>
		<div class="fr_block">
			<span class="txt_des">약관개정일 : </span>
			<select class="select_b" title="검색분류 선택" id="searchType">
				<option value="20170928">2017.09.28</option>
			</select>
		</div>
	</h4>
	<!--//타이틀//-->
	<!--약관목록-->
	<div class="ruleListZone">
		<ul>
			<li><a href="#rule01_01"><span>제1조</span><strong>목적</strong></a></li>
			<li><a href="#rule02_01"><span>제2조</span><strong>정의</strong></a></li>
			<li><a href="#rule03_01"><span>제3조</span><strong>약관의 게시와 개정</strong></a></li>
			<li><a href="#rule04_01"><span>제4조</span><strong>약관의 해석</strong></a></li>
			<li><a href="#rule05_01"><span>제5조</span><strong>이용계약 체결</strong></a></li>
			<li><a href="#rule06_01"><span>제6조</span><strong>회원정보의 변경</strong></a></li>
			<li><a href="#rule07_01"><span>제7조</span><strong>개인정보 보호의무</strong></a></li>
			<li><a href="#rule08_01"><span>제8조</span><strong>회원의 아이디 및 비밀번호의 관리에 대한 의무</strong></a></li>
			<li><a href="#rule09_01"><span>제9조</span><strong>사용자, 관계사에 대한 통지</strong></a></li>
			<li><a href="#rule10_01"><span>제10조</span><strong>회사의 의무</strong></a></li>
			<li><a href="#rule11_01"><span>제11조</span><strong>사용자, 관계사의 의무</strong></a></li>
			<li><a href="#rule12_01"><span>제12조</span><strong>서비스 제공등</strong></a></li>
			<li><a href="#rule13_01"><span>제13조</span><strong>서비스의 변경</strong></a></li>
			<li><a href="#rule14_01"><span>제14조</span><strong>정보의 제공 및 광고의 게재</strong></a></li>
			<li><a href="#rule15_01"><span>제15조</span><strong>게시물의 저작권</strong></a></li>
			<li><a href="#rule16_01"><span>제16조</span><strong>게시물의 관리</strong></a></li>
			<li><a href="#rule17_01"><span>제17조</span><strong>권리의 귀속</strong></a></li>
			<li><a href="#rule18_01"><span>제18조</span><strong>포인트</strong></a></li>
			<li><a href="#rule19_01"><span>제19조</span><strong>계약해제, 해지등</strong></a></li>
			<li><a href="#rule20_01"><span>제20조</span><strong>이용제한</strong></a></li>
			<li><a href="#rule21_01"><span>제21조</span><strong>책임제한</strong></a></li>
			<li><a href="#rule22_01"><span>제22조</span><strong>준거법 및 재판관할</strong></a></li>
			<li><a href="#rule99_01"><span>부칙</span><strong>부칙</strong></a></li>
		</ul>
	</div>
	<!--//약관목록//-->
	<%@ include file ="includeRule/s_20170925.html" %>
</section>
				
