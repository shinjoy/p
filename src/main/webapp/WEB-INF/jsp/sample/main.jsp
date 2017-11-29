<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<section id="detail_contents">
	<div class="main_moduleWrap">
		<!-- 고정 업무 캘린더 영역 -->
		<jsp:include page="../module/workFixed.jsp"></jsp:include>

		<!-- 모듈 리스트 -->
		<c:forEach items="${moduleList }" var = "data">
			<div class="m_moduleBox ${data.theme }">
				<jsp:include page="..${data.moduleIncUrl }"></jsp:include>
			</div>
		</c:forEach>


		<!--정보공유13_신규정보+코멘트-->
		<div class="m_moduleBox busi_com_module">
			<h2 class="module_title"><strong>정보공유 및 코멘트</strong><span></span></h2>
			<div class="module_conBox">
				<ul class="mtab_st01">
					<li class="current"><a href="#">신규정보</a></li>
					<li><a href="#">신규코멘트</a></li>
				</ul>
				<ul class="board_mbs_list">
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="info_type_cway">미팅</span><span class="info_type_c1">NEEDS)</span><span class="info_type_c2">M&amp;A_</span>
								<span>(사)공공기술사업화기업협회</span>
							</a>
							<span class="icon_comment">(3)</span><span class="icon_new"><em>new</em></span>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="info_type_cway">IR</span><span class="info_type_c1">정보)</span><span class="info_type_c2">업황_</span>
								<span>able 코스피200선물플러스 ETN</span>
							</a>
							<span class="icon_comment">(3)</span><span class="icon_new"><em>new</em></span>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="info_type_cway">탐방</span>
								<span>Able KQ Monthly Best 11 ETN</span>
							</a>
							<span class="icon_new"><em>new</em></span>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="info_type_cway">분석</span><span class="info_type_c1">NEEDS)</span><span class="info_type_c2">CB/EB_</span>
								<span>SK 이노베이션</span>
							</a>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="info_type_cway">미팅</span><span class="info_type_c1">NEEDS)</span><span class="info_type_c2">SC01_</span>
								<span>KH바텍</span>
							</a>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="info_type_cway">IR</span><span class="info_type_c2">SC01_</span>
								<span>LG 이노텍</span>
							</a>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="info_type_cway">탐방</span><span class="info_type_c1">자산)</span><span class="info_type_c2">자산운용_</span>
								<span>AJ인베스트먼트파트너스</span>
							</a>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
				</ul>
				<%--<div class="m_nocontxt">내용이 없습니다.</div>--%>
			</div>
			<a href="/business/business_info_list.jsp" class="btn_more"><em>더보기</em></a>
		</div>
		<!--//정보공유13_신규정보+코멘트//-->

		<!--정보공유14_게시판모음-->
		<div class="m_moduleBox all_board_module">
			<h2 class="module_title"><strong>PASS 게시판</strong><span></span></h2>
			<div class="module_conBox">
				<ul class="mtab_st01">
					<li class="current"><a href="#">전체</a></li>
					<li><a href="#">공지</a></li>
					<li><a href="#">업무</a></li>
					<li><a href="#">사내</a></li>
				</ul>
				<ul class="board_mbs_list">
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="bs_title">[공지] 2016년도 건강검진 시행 안내</span>
							</a>
							<span class="icon_comment">(3)</span><span class="icon_new"><em>new</em></span>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="bs_title">[인사] 신설 법인(시너지인베스트먼트) 및 직원 소속 변경</span>
							</a>
							<span class="icon_comment">(3)</span><span class="icon_new"><em>new</em></span>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="bs_title">[공지] 상용 소프트웨어 조사</span>
							</a>
							<span class="icon_new"><em>new</em></span>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="bs_title">[공지] 2016년 상반기 해외워크샵(발리)</span>
							</a>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="bs_title">[인사] 시너지파트너스(주) 신주연 사원 정직원 발령</span>
							</a>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="bs_title">[인사] 시너지아이비투자 윤혜림 대리 정직원 발령</span>
							</a>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
					<li>
						<div class="fl_block">
							<a href="javascript:void(window.open('/business/business_info_view.jsp', 'newinfov','resizable=no,width=968,height=720,scrollbars=yes'))">
								<span class="bs_title">[인사] 시너지투자자문 김대홍 상무 정직원 발령</span>
							</a>
						</div>
						<div class="fr_block"><span class="bs_name">이명철</span><span class="bs_date">16/11/07</span></div>
					</li>
				</ul>
				<%--<div class="m_nocontxt">내용이 없습니다.</div>--%>
			</div>
			<a href="/board/notice.jsp" class="btn_more"><em>더보기</em></a>
		</div>
		<!--//정보공유14_게시판모음//-->
	</div>
</section>
