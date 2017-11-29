<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<% pageContext.setAttribute("LF", "\n"); %>
<!--댓글폼(결재라인)-->
<div class="e_doc_rippleWrap">
	<!--댓글요약-->
	<div class="rippleSum">
		<!-- <span class="opinion_control"><a href="#" onclick="javascript:fnObj.displayComment();return false;" class="close" id="rippleSum">댓글<span class="count" id="commentCount">(0)</span></a></span> -->
		<%--<a href="#">결재의견<span class="count">(4)</span></a>--%><!--댓글열기-->
		<span class="opinion_control"><a href="javascript:toggleRippleZone()" id = "toggleBtn" class="close"><span>결재의견</span><span class="count">(${fn:length(commentList) })</span></a></span><!--댓글닫기-->
	</div>
	<!--//댓글요약//-->
	<!--댓글리스트-->
	<div id="RippleZone">
		<c:set var = "status" value="" />
		<c:forEach items="${commentList }" var = "data" varStatus="i">
			<c:if test="${status ne data.appvStatus }">

				<c:set var = "status" value="${data.appvStatus }"/>
				<div class="RippleGroup">
					<h4 class="RippleTitle">
						<c:choose>
							<c:when test="${data.appvStatus eq 'CANCEL' }">회수<br>처리의견</c:when>
							<c:when test="${data.appvStatus eq 'RECIEVER' }">수신의견</c:when>
							<c:when test="${data.appvStatus eq 'EXPENSE' }">지출완료<br>의견</c:when>
							<c:when test="${data.appvStatus eq 'UPDATE' }">수정의견</c:when>
							<c:otherwise>처리의견</c:otherwise>
						</c:choose>

					</h4>
						<div class="RippleCon">
			</c:if>
			<dl class="normal">
				<dt>
					<span class="name">
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvEmpId}",$(this),"mouseover",null,0,0,0,0)'>
							${data.commentUserNm }
						</span>
					</span>
					<span class="date"><fmt:formatDate value="${data.updateDate }" pattern="yyyy-MM-dd" /></span></dt>
				<dd class="comment">${fn:replace(fn:replace(data.appvComment,'\\n','<br>'), LF, '<br>') }</dd>
			</dl>
			<c:if test="${status ne commentList[i.index+1].appvStatus }">
				</div></div>
			</c:if>
		</c:forEach>

		<c:if test="${searchMap.listType eq 'pendList' or searchMap.listType eq 'previous' or searchMap.listType eq 'nextList'}">
                         <!--일반 답글입력폼-->
				<div class="RippleGroup bg_on">
					<h4 class="RippleTitle">처리의견</h4>
					<div class="RippleCon">
						<dl class="normal bg_on">
							<dt><span class="name">${baseUserLoginInfo.userName }</span><!-- <span class="date">2015.02.01</span> --></dt>
							<dd class="commentBox">
								<div class="txtArea">
									<textarea class="txtArea_b" id = "appvComment" name = "appvComment" placeholder="내용을 입력해주세요" title="내용입력"></textarea>
									<!-- <a href="javascript:addComment()" class="btn_comment">Comment</a> -->
								</div>
							</dd>
						</dl>
					</div>
				</div>
			</c:if>
		</div>
	</div>
