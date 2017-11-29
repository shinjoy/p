<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){


	});
	
</script>
<!--전체게시판-->
<div class="all_boardWrap">
	<div class="labelsetLine">
		<h3><strong>전체 게시판</strong><a href="#" class="rdmore_btn"><em>더보기</em></a></h3>
		<button type="button" class="toggle_sort all"><em>전체</em></button>
		<%--<button type="button" class="toggle_sort personal"><em>개인</em></button>--%>
	</div>
	<div class="module_tabList">
		<ul>
			<li class="current">시간별</li>
			<li>새글</li>
			<li>새덧글</li>
		</ul>
	</div>
	<div class="all_boardList">
		<div class="bg_notice">
			<dl class="all_boardBox">
				<dt><span class="boardtype">공지</span><span class="typeNotice">Notice</span></dt>
				<dd>
					<p class="conBox"><span class="icon_new"><em>new</em></span><strong>[시너지] [부분기능 개선] PASS 업무구분 현황외 일부기능 개선안내</strong></p>
					<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment n_read">[3]</span></p>
				</dd>
			</dl>
			<dl class="all_boardBox">
				<dt><span class="boardtype">공지</span><span class="typeNotice">Notice</span></dt>
				<dd>
					<p class="conBox"><span class="icon_new"><em>new</em></span><strong>[시너지] 전사공지글 등록안내</strong></p>
					<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment n_read">[3]</span></p>
				</dd>
			</dl>
		</div>
		<dl class="all_boardBox">
			<dt><span class="boardtype">사내</span></dt>
			<dd>
				<p class="conBox"><span>[부분기능 개선] PASS 업무구분 현황외 일부기능 개선안내</span></p>
				<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment">[3]</span></p>
			</dd>
		</dl>
		<dl class="all_boardBox">
			<dt><span class="boardtype">요청</span></dt>
			<dd>
				<p class="conBox"><span class="icon_secret"><em>비공개</em></span><span>[부분기능 개선] 메인화면 / 업무메모 기능개선, 직원프로필보기/사이트바로가기</span></p>
				<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment">[3]</span></p>
			</dd>
		</dl>
		<dl class="all_boardBox">
			<dt><span class="boardtype">사내</span></dt>
			<dd>
				<p class="conBox"><span>[부분기능 개선] PASS 업무구분 현황외 일부기능 개선안내</span></p>
				<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment">[3]</span></p>
			</dd>
		</dl>
		<dl class="all_boardBox">
			<dt><span class="boardtype">요청</span></dt>
			<dd>
				<p class="conBox"><span class="icon_secret"><em>비공개</em></span><span>[부분기능 개선] 메인화면 / 업무메모 기능개선, 직원프로필보기/사이트바로가기</span></p>
				<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment">[3]</span></p>
			</dd>
		</dl>
		<dl class="all_boardBox">
			<dt><span class="boardtype">사내</span></dt>
			<dd>
				<p class="conBox"><span>[부분기능 개선] PASS 업무구분 현황외 일부기능 개선안내</span></p>
				<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment">[3]</span></p>
			</dd>
		</dl>
		<dl class="all_boardBox">
			<dt><span class="boardtype">사내</span></dt>
			<dd>
				<p class="conBox"><span>[부분기능 개선] PASS 업무구분 현황외 일부기능 개선안내</span></p>
				<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment">[3]</span></p>
			</dd>
		</dl>
		<dl class="all_boardBox">
			<dt><span class="boardtype">사내</span></dt>
			<dd>
				<p class="conBox"><span>[부분기능 개선] PASS 업무구분 현황외 일부기능 개선안내</span></p>
				<p class="writeinfo"><span class="writer">장원화ㆍ</span><span class="date">17/10/23</span><span class="icon_comment">[3]</span></p>
			</dd>
		</dl>
		
	</div>
</div>
<!--//전체게시판//-->
