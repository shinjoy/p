<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
			<table class="t_skinR00">
				<colgroup>
					<col width="80">
					<col width="55">
					<col width="55">
					<col width="55">
					<col width="120">
					<col width="200">
					<col width="90">
					<col width="85">
					<col width="200">
				</colgroup>
				<thead>
					<tr style="line-height:120%;">
						<th onclick="sortTable();" class="hand bgYlw">일자<br/>▼</th>
						<th onclick="sortTable(3);" class="hand bgYlw">입력자<br/>▼</th>
						<%-- <th onclick="sortTable(1);" class="hand bgYlw personName">약속자<br/>▼</th> --%>
						<th onclick="sortTable(6);" class="hand bgYlw ststsPrivate pd0">업종<br/>▼</th>
						<th onclick="sortTable(2);" class="hand bgYlw pd0">정보<br/>제공자<br/>▼</th>
						<th onclick="sortTable(4);" class="hand bgYlw">회사명<br/>▼</th>
						<th class="bgYlw">내용</th>
						<th onclick="sortTable(7);" class="hand bgYlw pd0">정보<br/>중요도<br/>▼</th>
						<th class="bgYlw">진행사항</th>
						<th class="bgYlw">메모</th>
					</tr>
					<tr style="height:1px;"></tr>
				</thead>
			</table>
		</div>
		<div>
			<table class="t_skinR00">
				<colgroup>
					<col width="80">
					<col width="55">
					<col width="55">
					<col width="55">
					<col width="120">
					<col width="200">
					<col width="90">
					<col width="85">
					<col width="200">
				</colgroup>
				<tbody>
					<c:forEach var="financ" items="${financingList}" varStatus="financStatus">
					<tr <c:if test="${financ.kpcProcess == '10000'}">style="background-color:#B9B9B9"</c:if><c:if test="${financ.kpcProcess == '00002'}">style="background-color:#E7E7E7"</c:if><c:if test="${financ.kpcProcess == '00003'}">style="background-color:#A9F5BC"</c:if>>
						<td class="cent"><nobr>${financ.tmDt}</nobr></td>
						<input type="hidden" id="snb${financStatus.count}" value="${financ.sNb }"/>
						<td class="cent">${financ.rgNm}</td>
						<%-- <td class="cent personName">${financ.coworker}<c:if test="${empty financ.coworker}">${financ.infoProviderNm}</c:if></td> --%>
						<td class="cent"><c:if test="${tmpNum2!='statsPrivateList'}">${financ.cateBsns}</c:if><c:if test="${tmpNum2=='statsPrivateList'}">${financ.categoryNm}</c:if></td>
						<td class="cent" title="${financ.cstCpnNm}">${financ.cstNm}</td>
						<%-- <td class="cent"><span class="btn s green"><a class="pass2pe" id="btnPass_${financStatus.count}" >
																	<c:if test="${not empty financ.coworker }">${financ.coworker }</c:if>
																	<c:if test="${empty financ.coworker }">약속자</c:if>
																	</a></span></td> --%>
						<td class="cent navy bold" onclick="popUp('','rcmdCpn','','${financ.cpnSnb}')"><a>${financ.cpnNm}<c:if test="${empty financ.cpnNm}">${financ.cstCpnNm}</c:if></a></td>
						<td class="hov hand cent" onclick="statsOfferdivAjax(event,'${financ.rgNm}',this.parentNode.parentNode,'${financ.sNb}')">${financ.financing}</td>
						<td class="cent">
							<table class="t pd0"><tr><c:forEach var="loop5" varStatus="L5" begin="1" end="5">
								<td class="tabImportant<c:if test="${financ.lvCd>=L5.count}"> bgLightGray</c:if>" title="${L5.count}" onclick="javascript:selectLv('${L5.count}','${financ.offerSnb}','modifyRec')"></td>
							</c:forEach></tr></table>
						</td>
						<td class="cent">
						<form name=procKPC id="procKPC${financStatus.count}" action="<c:url value='/work/processKPC.do' />" method="post">
							<input type="hidden" name="sNb" value="${financ.sNb }"/>
							<input type="hidden" name="url" value="financing" />
							<select class='processKPC' id='kpcProcess_${financStatus.count}' name='kpcProcess'<%-- <c:if test="${baseUserLoginInfo.userName!=offer.rgNm}">disabled="disabled"</c:if> --%>>
								<c:forEach var="cmmCd" items="${cmmCdProgressList}">
									<option value="${cmmCd.cd}" <c:if test="${financ.kpcProcess == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
								</c:forEach>
							</select>
						</form>
						</td>
						<td>
							<a class="memo_m" id="memo_${financ.sNb}">
							<c:choose>
								<c:when test="${empty financ.subMemo}"><font style="color:gray"><nobr><small>메모를 입력하세요.</small></nobr></font></c:when>
								<c:otherwise>${fn:substring(financ.subMemo,0,18)}<c:if test="${fn:length(financ.subMemo) > 18}">...</c:if></c:otherwise>
							</c:choose>
							</a>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

<%-- 메모 --%>
<div>
<c:forEach var="offer" items="${financingList}" varStatus="status">
	<div class="popUpMenu title_area" id="memoPr${offer.sNb}" name="textR">
	<c:choose>
	<c:when test="${baseUserLoginInfo.permission > '00019'  or baseUserLoginInfo.userName==offer.rgNm}">
		<input type="hidden" id="dealMemoSNb${offer.sNb}" value="${offer.memoSNb }">
		<input type="hidden" id="memoTmDt${offer.sNb}" value="${offer.tmDt }">
		<input type="hidden" id="memoCpnNm${offer.sNb}" value="${offer.cpnNm }">
		<input type="hidden" id="memoRgNm${offer.sNb}" value="${offer.rgNm }">
		<p class="closePopUpMenu" name="textR">ⅹ닫기</p>
		<ul>
			<c:choose>
				<c:when test="${empty offer.subMemo}">
				<li class="c_note"><textarea id="memoarea0" placeholder="메모를 입력하세요."></textarea></li>
				</c:when>
				<c:otherwise>
				<li class="c_note"><textarea id="memoarea${offer.sNb}">${offer.subMemo}</textarea></li>
				</c:otherwise>
			</c:choose>
		</ul>
		<p class="bsnsR_btn">
			<span class="btn s green" onclick="subMemo(this)"><a><spring:message code="button.save" /></a></span>&nbsp;&nbsp;&nbsp;
			<input type="text" id="RM_${offer.sNb}" style="height:1px;width:1px;border:0px none;padding:0;vertical-align:bottom;">
			<!-- <span class="dealMemo_btnDel">완전삭제</span> -->
		</p>
	</c:when>
	<c:otherwise>
		<input type="hidden" id="memoSNb${offer.sNb}" value="${offer.sNb }">
		<p class="closePopUpMenu" name="textR">ⅹ닫기</p>
		<ul>
			<li class="c_note v-textarea">${fn:replace(offer.subMemo, lf,"<br/>")}</li>
			<input type="text" id="RM_${offer.sNb}" style="height:1px;width:1px;border:0px none;padding:0;vertical-align:bottom;">
		</ul>
	</c:otherwise>
	</c:choose>
	</div>
</c:forEach>
</div>
<%-- 메모 --%>
<div id="offerDiv"><div id="offerPr" style="display: none;"></div></div>