<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!--사이트바로가기 관리-->
<table class="tb_list_basic" summary="사이트바로가기 관리 (순서, 사이트명, 링크명, URL, 링크방식, 비고, 사용여부, 추가/삭제)">
	<caption>금액분류</caption>
	<colgroup>
		<col width="60" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="120" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">순서</th>
			<th scope="col">사이트명</th>
			<th scope="col">링크명 <em class="f11">(노출명)</em></th>
			<th scope="col">URL</th>
			<th scope="col">링크방식</th>
			<th scope="col">비고</th>
			<th scope="col">사용여부</th>
			<th scope="col" colspan="2">추가/삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${quickLinkList }" var = "data">
			<tr id = "quicLink_${data.quickLinkId }">
				<th>
					<span class = "quickLinkView">${data.sort }</span>
					<input type="hidden" name = "quickLinkId" value="${data.quickLinkId }">
					<input name = "sort" id = "sort_quicLink_${data.quickLinkId }" value="${data.sort }" type="text" class="input_b w100 sort quickLinkInput" placeholder="" title="메뉴노출 순서입력">
				</th>
				<td>
					<span class = "quickLinkView">${data.siteName }</span>
					<input name="siteName" type="text" value="${data.siteName }" class="input_b w100 quickLinkInput" placeholder="사이트명 입력" title="사이트명 입력">
				</td>
				<td>
					<span class = "quickLinkView"><strong class="fontB">${data.linkName }</strong></span>
					<input name="linkName" type="text" value="${data.linkName }" class="input_b w100 quickLinkInput" placeholder="링크명 입력" title="링크명 입력(상단노출)">
				</td>
				<td class="txt_left">
					<c:set var="urlBuf">
              				<c:choose>
							<c:when test="${not fn:startsWith(data.linkUrl , 'http://') and not fn:startsWith(data.linkUrl , 'https://') }">
								http://${data.linkUrl }
							</c:when>
							<c:otherwise>
								${data.linkUrl }
							</c:otherwise>
						</c:choose>
					</c:set>

					<span class = "quickLinkView"><a href="${urlBuf }" class="fontBlue" target="_blank">${data.linkUrl }</a></span>
					<input name="linkUrl" type="text"  value="${data.linkUrl }" class="input_b w100 quickLinkInput" placeholder="사이트링크 입력" title="사이트링크 입력">
				</td>
				<td class="radio_list4">
					<input type="hidden" id = "quicLink_${data.quickLinkId }_linkType" value="${data.linkType}">
					<label>
						<input name = "linkType_quicLink_${data.quickLinkId }" type="radio" disabled="disabled" value="BLANK" <c:if test = "${data.linkType eq 'BLANK' }">checked="checked"</c:if>/><span>새창</span>
					</label>
					<label>
						<input name = "linkType_quicLink_${data.quickLinkId }" type="radio" disabled="disabled" value="SELF" <c:if test = "${data.linkType eq 'SELF' }">checked="checked"</c:if>/><span>자창</span>
					</label>
				</td>
				<td>
					<span class = "quickLinkView">${data.comment }</span>
					<input type="text" name = "comment"  value="${data.comment }" class="input_b w100 quickLinkInput" placeholder="비고내용 입력" title="비고내용 입력">
				</td>
				<td class="radio_list4">
					<input type="hidden" id = "quicLink_${data.quickLinkId }_useYn" value="${data.useYn}">
					<label>
						<input type="radio" name="useYn_quicLink_${data.quickLinkId }" disabled="disabled" value="Y" <c:if test = "${data.useYn eq 'Y' }">checked="checked"</c:if>/><span>YES</span>
					</label>
					<label>
						<input type="radio" name="useYn_quicLink_${data.quickLinkId }" disabled="disabled" value="N" <c:if test = "${data.useYn eq 'N' }">checked="checked"</c:if>/><span>NO</span>
					</label>
				</td>
				<td>
					<a href="javascript:showUpdateForm('quicLink_${data.quickLinkId }')" class="s_gray01_btn btn_auth quickLinkView"><em>수정</em></a>
					<a href="javascript:deleteQuicMenu('${data.quickLinkId }')" class="s_gray01_btn mgl8 btn_auth quickLinkView"><em>삭제</em></a>
					<a href="javascript:doSave('quicLink_${data.quickLinkId }')" class="btn_s_type_blue2 quickLinkInput"><em>저장</em></a>
					<button type="button" id = "btnReset" class="btn_s_replay mgl8 quickLinkInput" onclick="reset('quicLink_${data.quickLinkId }')"><em>새로고침</em></button>
				</td>
			</tr>
		</c:forEach>

		<tr id = "new">
			<th>
				<input type="hidden" name = "quickLinkId" value="0">
				<input name = "sort" id = "sort_new" type="text" class="input_b w100 sort" placeholder="" title="메뉴노출 순서입력">
			</th>
			<td>
				<input name="siteName" type="text" class="input_b w100" placeholder="사이트명 입력" title="사이트명 입력">
			</td>
			<td>
				<input name="linkName" type="text" class="input_b w100" placeholder="링크명 입력" title="링크명 입력(상단노출)">
			</td>
			<td>
				<input name="linkUrl" type="text" class="input_b w100" placeholder="사이트링크 입력" title="사이트링크 입력">
			</td>
			<td class="radio_list4">
				<label>
					<input name = "linkType_new" type="radio" value="BLANK" checked="checked" /><span>새창</span>
				</label>
				<label>
					<input name = "linkType_new" type="radio" value="SELF"/><span>자창</span>
				</label>
			</td>
			<td>
				<input type="text" name = "comment" class="input_b w100" placeholder="비고내용 입력" title="비고내용 입력">
			</td>
			<td class="radio_list4">
				<label>
					<input type="radio" name="useYn_new" value="Y" checked="checked"/><span>YES</span>
				</label>
				<label>
					<input type="radio" name="useYn_new" value="N" /><span>NO</span>
				</label>
			</td>
			<td>
				<a href="javascript:doSave('new')" class="btn_s_type_blue2 btn_auth"><em>저장</em></a>
				<button type="button" class="btn_s_replay mgl8" onclick="reset('new')"><em>새로고침</em></button>
			</td>
		</tr>
	</tbody>
</table>
<!--// 사이트바로가기 관리 //-->

