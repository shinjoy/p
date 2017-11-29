<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
pageContext.setAttribute("cr", "\r");
pageContext.setAttribute("cn", "\n");
pageContext.setAttribute("crcn", "\r\n");
pageContext.setAttribute("sp", "&nbsp;");
pageContext.setAttribute("br", "<br/>");
%>
<script type="text/javascript">
	$(document).ready(function(){
		setImagePosition();
	});
</script>
<div>
<c:forEach items="${projectStatusList }" var = "data" varStatus="i">
	<%-- <c:if test="${i.index eq maxPageRow }"><div id = "moreListArea" style="display: none;"></c:if> --%>
	<c:if test="${i.index < maxPageRow }">
	<c:choose>
		<c:when test="${data.type eq 'WORK_DAILY_PRIVATE' }">
			<!--개인업무st-->
			<dl class="pro_historyList">
				<dt>
					<span class="tooltip">
						<a href="javascript:showlayer('${data.type }_${data.keyId }')" class="m_propic"><c:if test="${not empty data.photoNm}"><span class="photo_aspect projectStatusDt_aspect aspect_1_1_3"><img src="/imgUpLoadData/${data.photoNm}" alt="프로필사진"></span></c:if></a>
						<div class="Profile_box ${data.type }_${data.keyId }" id = "h_Profile_sBox"  style="display: none;">
							<div class="com_person_name">
								<p class="comname">${data.orgNm }</p>
								<p class="per_name"><strong>${data.name} ${data.rankNm }</strong><span>(${data.deptNm })</span></p>
								<div class="m_b_propic"><c:if test="${not empty data.photoNm}"><span class="photo_aspect projectStatusDt_aspect aspect_1_1_4"><img src="/imgUpLoadData/${data.photoNm}" alt="프로필사진"></span></c:if></div>
								<input type="hidden" name = "createUserInfo" value="${data.userId }|${data.name}">
							</div>

							<span class="intext">
								<ul class="dot_list_st02">
									<li><span class="fontB">회사번호 :</span> ${data.companyTel }</li>
									<li><span class="fontB">핸드폰 :</span> ${data.mobileTel }</li>
									<li><span class="fontB">이메일 :</span> <a href="mailto:${data.email }">${data.email }</a></li>
								</ul>
								<p><a href="javascript:openMemo('${data.userId }')" class="btn_memo"><em>업무보고 보내기</em></a></p>
							</span>
							<em class="edge_topleft"></em>
							<a href="javascript:showlayer('${data.type }_${data.keyId }')" class="closebtn"><em>닫기</em></a>
						</div>
					</span>
					<p class="m_name">${data.name }<br><span class="m_team">(${data.deptNm })</span></p>
				</dt>

				<dd>
					<div class="historykind">
						<span class="icon_st">개인업무</span>
						<span class="mgl10">업무일 : ${data.startDate }</span>
						<span class="mgl30">상태 : ${data.progressTxt } <c:if test="${data.daydiff>0 }">+${data.daydiff }</c:if></span>
						<span class="mgl30">${baseUserLoginInfo.activityTitle} : ${data.activityNm }</span>
					</div>
					<div class="protitle">
						<strong>제목 : ${data.title }</strong>
						<span class="wdate">(작성일: ${data.createDate })</span>
						<c:if test="${data.fileCnt>0 }">
							<a href="javascript:openFilePop('${data.type }','${data.fileUploadId }','${data.activityNm }')" class="btn_fileMore"><em>첨부파일</em></a>
						</c:if>
						<a href="javascript:toggleDetail('${data.type }','${data.keyId }')" id = "moreDetail_${data.type }_${data.keyId }" class="btn_moredetail mgl10" style="display: none;"><em>상세보기 펼침</em></a>
						<a href="javascript:toggleDetail('${data.type }','${data.keyId }')" id = "collapseDetail_${data.type }_${data.keyId }" class="btn_moreclose mgl10" style="display: none;"><em>상세보기 닫기</em></a>
					</div>
					<div class="condes" id = "memoDt_${data.type }_${data.keyId }">${data.memo }</div>
					<script type="text/javascript">
						var target = $("#memoDt_${data.type }_${data.keyId }");

						if(target.height()>30){
							target.addClass("multiellipsis");
							$("#moreDetail_${data.type }_${data.keyId }").show();
						}
					</script>
				</dd>
			</dl>
			<!--//개인업무st//-->
		</c:when>

		<c:when test="${data.type eq 'WORK_DAILY_TEAM' }">
			<!--팀업무st-->
			<dl class="pro_historyList">
				<dt>
					<span class="tooltip">
						<a href="javascript:showlayer('${data.type }_${data.keyId }')" class="m_propic"><c:if test="${not empty data.photoNm}"><span class="photo_aspect projectStatusDt_aspect aspect_1_1_3"><img src="/imgUpLoadData/${data.photoNm}" alt="프로필사진"></span></c:if></a>
						<div class="Profile_box ${data.type }_${data.keyId }" id = "h_Profile_sBox"  style="display: none;">
							<div class="com_person_name">
								<p class="comname">${data.orgNm }</p>
								<p class="per_name"><strong>${data.name} ${data.rankNm }</strong><span>(${data.deptNm })</span></p>
								<div class="m_b_propic"><c:if test="${not empty data.photoNm}"><span class="photo_aspect projectStatusDt_aspect aspect_1_1_4"><img src="/imgUpLoadData/${data.photoNm}" alt="프로필사진"></span></c:if></div>
								<input type="hidden" name = "createUserInfo" value="${data.userId }|${data.name }">
							</div>

							<span class="intext">
								<ul class="dot_list_st02">
									<li><span class="fontB">회사번호 :</span> ${data.companyTel }</li>
									<li><span class="fontB">핸드폰 :</span> ${data.mobileTel }</li>
									<li><span class="fontB">이메일 :</span> <a href="mailto:${data.email }">${data.email }</a></li>
								</ul>
								<p><a href="javascript:openMemo('${data.userId }')" class="btn_memo"><em>업무보고 보내기</em></a></p>
							</span>
							<em class="edge_topleft"></em>
							<a href="javascript:showlayer('${data.type }_${data.keyId }')" class="closebtn"><em>닫기</em></a>
						</div>
					</span>
					<p class="m_name">${data.name }<br><span class="m_team">(${data.deptNm })</span></p>
				</dt>

				<dd>
					<div class="historykind">
						<span class="icon_st">팀업무</span>
						<span class="mgl10">기간 : ${data.startDate } ~ ${data.endDate } <c:if test="${data.daydiff>0 }">(+${data.daydiff })</c:if></span>
						<span class="mgl30">상태 : ${data.progressTxt } </span>
						<span class="mgl30">${baseUserLoginInfo.activityTitle} : ${data.activityNm }</span>
					</div>
					<div class="protitle">
						<strong>제목 : ${data.title }</strong>
						<span class="wdate">(작성일: ${data.createDate })</span>
						<c:if test="${data.fileCnt>0 }">
							<a href="javascript:openFilePop('${data.type }','${data.fileUploadId }','${data.activityNm }')" class="btn_fileMore"><em>첨부파일</em></a>
						</c:if>
						<a href="javascript:toggleDetail('${data.type }','${data.keyId }')" id = "moreDetail_${data.type }_${data.keyId }" class="btn_moredetail mgl10"><em>상세보기 펼침</em></a>
						<a href="javascript:toggleDetail('${data.type }','${data.keyId }')" id = "collapseDetail_${data.type }_${data.keyId }" class="btn_moreclose mgl10" style="display: none;"><em>상세보기 닫기</em></a>
						<input type="hidden" id = "chkDetail_${data.type }_${data.keyId }" value="N">
					</div>
					<div class="condes multiellipsis" id = "memoDt_${data.type }_${data.keyId }">
						<div id = "memoList_${data.keyId }">
							<div class="desbox">
								<p>${data.memo }</p>
								<p class="update">${data.attr1 }</p>
							</div>
						</div>
						<!--멤버상세 내용 -->
						<div id="userDetailArea_${data.keyId }"></div>
					</div>

				</dd>
			</dl>
			<!--//팀업무st//-->
		</c:when>
		<c:when test="${data.type eq 'SCHE' }">
			<!--일정st-->
			<dl class="pro_historyList">
				<dt>
					<span class="tooltip">
						<a href="javascript:showlayer('${data.type }_${data.keyId }')" class="m_propic"><c:if test="${not empty data.photoNm}"><span class="photo_aspect projectStatusDt_aspect aspect_1_1_3"><img src="/imgUpLoadData/${data.photoNm}" alt="프로필사진"></span></c:if></a>
						<div class="Profile_box ${data.type }_${data.keyId }" id = "h_Profile_sBox"  style="display: none;">
							<div class="com_person_name">
								<p class="comname">${data.orgNm }</p>
								<p class="per_name"><strong>${data.name} ${data.rankNm }</strong><span>(${data.deptNm })</span></p>
								<div class="m_b_propic"><c:if test="${not empty data.photoNm}"><span class="photo_aspect projectStatusDt_aspect aspect_1_1_4"><img src="/imgUpLoadData/${data.photoNm}" alt="프로필사진"></span></c:if></div>
								<input type="hidden" name = "createUserInfo" value="${data.userId }|${data.name }">
							</div>

							<span class="intext">
								<ul class="dot_list_st02">
									<li><span class="fontB">회사번호 :</span> ${data.companyTel }</li>
									<li><span class="fontB">핸드폰 :</span> ${data.mobileTel }</li>
									<li><span class="fontB">이메일 :</span> <a href="mailto:${data.email }">${data.email }</a></li>
								</ul>
								<p><a href="javascript:openMemo('${data.userId }')" class="btn_memo"><em>업무보고 보내기</em></a></p>
							</span>
							<em class="edge_topleft"></em>
							<a href="javascript:showlayer('${data.type }_${data.keyId }')" class="closebtn"><em>닫기</em></a>
						</div>
					</span>
					<p class="m_name">${data.name }<br><span class="m_team">(${data.deptNm })</span></p>
				</dt>

				<dd>
					<div class="historykind">
						<span class="icon_st">일정</span>
						<span class="mgl10">기간 : ${data.startDate } ~ ${data.endDate } <c:if test="${data.daydiff>0 }">(+${data.daydiff })</c:if></span>
						<span class="mgl30">상태 : ${data.progressTxt } </span>
						<span class="mgl30">${baseUserLoginInfo.activityTitle} : ${data.activityNm }</span>
					</div>
					<div class="protitle">
						<strong>제목 : ${data.title }</strong>
						<span class="wdate">(작성일: ${data.createDate })</span>
						<c:if test="${data.fileCnt>0 }">
							<a href="javascript:openFilePop('${data.type }','${data.fileUploadId }','${data.activityNm }')" class="btn_fileMore"><em>첨부파일</em></a>
						</c:if>
						<a href="javascript:toggleDetail('${data.type }','${data.keyId }')" id = "moreDetail_${data.type }_${data.keyId }" class="btn_moredetail mgl10"><em>상세보기 펼침</em></a>
						<a href="javascript:toggleDetail('${data.type }','${data.keyId }')" id = "collapseDetail_${data.type }_${data.keyId }" class="btn_moreclose mgl10" style="display: none;"><em>상세보기 닫기</em></a>
						<input type="hidden" id = "chkDetail_${data.type }_${data.keyId }" value="N">
					</div>
					<div class="condes multiellipsis" id = "memoDt_${data.type }_${data.keyId }">
						<p>${fn:replace(data.memo, cn, br)}</p>
						<div class="mettinginfo_sum">
							<div class="box">
								<ul class="dot_list_st02">
									<li>고객/회사 : ${data.attr1}${not empty data.attr1 && not empty data.attr2 ? '/':''} ${data.attr2}</li>
									<li>장소 : ${data.attr6}</li>
								</ul>
							</div>
							<div class="box">
								<ul class="dot_list_st02">
									<li>반복설정 : ${data.attr3}</li>
									<li>알림 : ${data.attr7} / ${data.attr8}</li>
								</ul>
							</div>
							<div class="box">
								<ul class="dot_list_st02">
									<li>차량사용 : <c:choose><c:when test="${data.attr4 eq 'Y'}"> 사용함 (${data.attr5})</c:when><c:otherwise>사용안함</c:otherwise></c:choose></li>
									<li>중요도 :
										<ul class="relationGrade mgl5">
											<c:choose>
		                                        <c:when test="${data.attr9 eq 'bottom'}">
		                                            <li><a class="on" ><em>+1</em></a></li>
		                                            <li><a  class="" ><em>+2</em></a></li>
		                                            <li><a class="" ><em>+3</em></a></li>
		                                        </c:when>
		                                        <c:when test="${data.attr9 eq 'middle'}">
		                                            <li><a class="on" ><em>+1</em></a></li>
		                                            <li><a  class="on" ><em>+2</em></a></li>
		                                            <li><a class="" ><em>+3</em></a></li>
		                                        </c:when>
		                                        <c:when test="${data.attr9 eq 'top'}">
		                                            <li><a class="on" ><em>+1</em></a></li>
		                                            <li><a  class="on" ><em>+2</em></a></li>
		                                            <li><a class="on" ><em>+3</em></a></li>
		                                        </c:when>
		                                        <c:otherwise>
		                                             <li><a class="" ><em>+1</em></a></li>
		                                             <li><a  class="" ><em>+2</em></a></li>
		                                             <li><a class="" ><em>+3</em></a></li>
		                                         </c:otherwise>
		                                    </c:choose>
										</ul>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</dd>
			</dl>
			<!--//일정st//-->
			</c:when>
			<c:when test="${data.type eq 'APPROVE' }">
			<!--전자결재st-->
			<dl class="pro_historyList">
				<dt>
					<span class="tooltip">
						<a href="javascript:showlayer('${data.type }_${data.keyId }')" class="m_propic"><c:if test="${not empty data.photoNm}"><span class="photo_aspect projectStatusDt_aspect aspect_1_1_3"><img src="/imgUpLoadData/${data.photoNm}" alt="프로필사진"></span></c:if></a>
						<div class="Profile_box ${data.type }_${data.keyId }" id = "h_Profile_sBox"  style="display: none;">
							<div class="com_person_name">
								<p class="comname">${data.orgNm }</p>
								<p class="per_name"><strong>${data.name} ${data.rankNm }</strong><span>(${data.deptNm })</span></p>
								<div class="m_b_propic"><c:if test="${not empty data.photoNm}"><span class="photo_aspect projectStatusDt_aspect aspect_1_1_4"><img src="/imgUpLoadData/${data.photoNm}" alt="프로필사진"></span></c:if></div>
								<input type="hidden" name = "createUserInfo" value="${data.userId }|${data.name }">
							</div>

							<span class="intext">
								<ul class="dot_list_st02">
									<li><span class="fontB">회사번호 :</span> ${data.companyTel }</li>
									<li><span class="fontB">핸드폰 :</span> ${data.mobileTel }</li>
									<li><span class="fontB">이메일 :</span> <a href="mailto:${data.email }">${data.email }</a></li>
								</ul>
								<p><a href="javascript:openMemo('${data.userId }')" class="btn_memo"><em>업무보고 보내기</em></a></p>
							</span>
							<em class="edge_topleft"></em>
							<a href="javascript:showlayer('${data.type }_${data.keyId }')" class="closebtn"><em>닫기</em></a>
						</div>
					</span>
					<p class="m_name">${data.name }<br><span class="m_team">(${data.deptNm })</span></p>
				</dt>

				<dd>
					<div class="historykind">
						<span class="icon_st">전자결재</span><span class="icon_st2 mgl8">${data.attr1 }</span>
						<span class="mgl10">기간 : ${data.startDate } ~ ${data.endDate }</span>
						<span class="mgl30">상태 : ${data.progressTxt }</span>
						<span class="mgl30">${baseUserLoginInfo.activityTitle} : ${data.activityNm }</span>
					</div>
					<div class="protitle">
						<strong>제목 : ${data.title }</strong>
						<span class="wdate">(작성일: ${data.createDate })</span>
						<c:if test="${data.fileCnt>0 }">
							<a href="javascript:openFilePop('${data.type }','${data.fileUploadId }','${data.activityNm }')" class="btn_fileMore"><em>첨부파일</em></a>
						</c:if>
						<a href="javascript:toggleDetail('${data.type }','${data.keyId }','${data.attr2 }','${data.attr3 }','${data.attr4 }','${data.userId }','${data.attr5 }')" class="btn_morepopup mgl10"><em>상세보기</em></a>
					</div>
					<div class="condes" id = "memoDt_${data.type }_${data.keyId }">${data.memo }</div>
					<script type="text/javascript">
						var target = $("#memoDt_${data.type }_${data.keyId }");

						if(target.height()>30){
							target.addClass("multiellipsis");
							$("#moreDetail_${data.type }_${data.keyId }").show();
						}
					</script>
				</dd>
			</dl>
			<!--//전자결재st//-->
		</c:when>
	</c:choose>
	</c:if>
	<%-- <c:if test="${i.index+1 eq fn:length(projectStatusList) and i.index> (maxPageRow-1) }"></div></c:if> --%>
</c:forEach>
<c:if test="${fn:length(projectStatusList)<=0 }">
<dd class="pro_historyList">
	<div class="nocontents">프로젝트 활동 내용이 없습니다.</div>
</dd>
<script type="text/javascript">
	var chkType = $("#type").val();
	if(chkType == "ALL"){
		$(".nocontents").text("프로젝트 활동 내용이 없습니다.");
	}else if(chkType == "WORK_DAILY_PRIVATE"){
		$(".nocontents").text("조회된 개인업무 내용이 없습니다.");
	}else if(chkType == "WORK_DAILY_TEAM"){
		$(".nocontents").text("조회된 팀업무 내용이 없습니다.");
	}else if(chkType == "SCHE"){
		$(".nocontents").text("조회된 일정이 없습니다.");
	}else if(chkType == "APPROVE"){
		$(".nocontents").text("조회된 전자결재 내용이 없습니다.");
	}
</script>
</c:if>
<c:if test="${fn:length(projectStatusList)> maxPageRow }">
<!--더보기버튼-->
<div class="btn_morelist" id = "btnAllViewList">
	<a href="javascript:allViewList()"><em>더보기</em></a>
</div>
</c:if>
</div>
