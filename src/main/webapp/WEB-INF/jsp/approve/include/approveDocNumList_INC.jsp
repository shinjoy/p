<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<jsp:useBean id="now" class="java.util.Date" />
<table class="tb_list_basic" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
    <caption>결재문서함 목록</caption>
    <colgroup>
        <col width="100" />
        <col width="100" />
        <col width="110" />
        <col width="100" />
        <col width="110" />
        <col width="160" />
        <col width="*" />
        <col width="90" />
        <col width="90" />
    </colgroup>
    <thead>
        <tr>
            <th scope="col">문서종류</th>
            <th scope="col">문서타입</th>
            <th scope="col">날짜</th>
            <th scope="col">구분</th>
            <th scope="col">번호</th>
            <th scope="col">사용여부</th>
            <th scope="col">예시</th>
            <th scope="col">수정자</th>
            <th scope="col">등록자</th>
        </tr>
    </thead>
    <tbody>
		<c:forEach var="data" items="${approveDocNumList }">
			<tr>
				<td id = "${data.appvDocClass }">${data.appvDocClassName }</td>
				<td>${data.appvDocTypeName }</td>
				<td id = "ruleDate_${fn:trim(data.appvDocType) }">
				</td>
				<td>${data.appvDocNumRuleMidName }</td>
				<td id = "numRule_${fn:trim(data.appvDocType) }"></td>
				<td>
					<span class="radio_list2">
                        <label><input type="radio"  name="useYn|${data.appvDocType }|${data.appvDocClass }"  value="Y" <c:if test = "${data.useYn eq 'Y'  }">checked="checked"</c:if>><span>YES</span></label>
                        <label><input type="radio"  name="useYn|${data.appvDocType }|${data.appvDocClass }"  value="N" <c:if test = "${data.useYn eq 'N'  }">checked="checked"</c:if>><span>NO</span></label>
                    </span>
				</td>
				<td id = "exStr_${data.appvDocType }">
					<c:choose>
						<c:when test="${data.appvDocNumRuleDate eq 'YYYYMMDD' }">
							<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="todayV" />
							<c:set var="appvDocNumRuleDateEX" value="${todayV }"/>
						</c:when>
						<c:when test="${data.appvDocNumRuleDate eq 'YYMMDD' }">
							<fmt:formatDate value="${now}" pattern="yyMMdd" var="todayV" />
							<c:set var="appvDocNumRuleDateEX" value="${todayV }"/>
						</c:when>
						<c:when test="${data.appvDocNumRuleDate eq 'YYMM' }">
							<fmt:formatDate value="${now}" pattern="yyMM" var="todayV" />
							<c:set var="appvDocNumRuleDateEX" value="${todayV }"/>
						</c:when>
							<c:when test="${data.appvDocNumRuleDate eq 'MMDD' }">
							<fmt:formatDate value="${now}" pattern="MMdd" var="todayV" />
							<c:set var="appvDocNumRuleDateEX" value="${todayV }"/>
						</c:when>
					</c:choose>

					<c:choose>
						<c:when test="${data.appvDocNumRuleSeq eq '5DIGIT' }">
							<c:set var="appvDocNumRuleSeqEX" value="00001"/>
						</c:when>
						<c:when test="${data.appvDocNumRuleSeq eq '4DIGIT' }">
							<c:set var="appvDocNumRuleSeqEX" value="0001"/>
						</c:when>
						<c:when test="${data.appvDocNumRuleSeq eq '3DIGIT' }">
							<c:set var="appvDocNumRuleSeqEX" value="001"/>
						</c:when>
					</c:choose>

					${appvDocNumRuleDateEX }-${data.appvDocNumRuleMidName }-${appvDocNumRuleSeqEX }

					<!-- midName 저장을 위해 히든값을 넣는다 -->
					<input type="hidden" name = "appvDocNumRuleMidName|${data.appvDocType }|${data.appvDocClass }" value="${data.appvDocNumRuleMidName }">
				</td>
				<td>${data.updatedName }</td>
				<td>
					${data.createdName }
					<input type="hidden" name = "createdBy|${data.appvDocType }|${data.appvDocClass }" value="${data.createdBy }">
					<input type="hidden" name = "createDate|${data.appvDocType }|${data.appvDocClass }" value="${data.createDate }">
				</td>
			</tr>
			<script type="text/javascript" defer="defer">
			var comTag = createSelectTag('appvDocNumRuleDate|${data.appvDocType }|${data.appvDocClass }', comAppvDocNumRuleDate, 'CD', 'NM', '${data.appvDocNumRuleDate}', 'setExText($(this))', colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
			var comNumTag = createSelectTag('appvDocNumRuleSeq|${data.appvDocType }|${data.appvDocClass }', comAppvDocNumRuleSeq, 'CD', 'NM', '${data.appvDocNumRuleSeq}', 'setExText($(this))', colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
			$("#ruleDate_${fn:trim(data.appvDocType) }").html(comTag);
			$("#numRule_${fn:trim(data.appvDocType) }").html(comNumTag);
			</script>
		</c:forEach>
    </tbody>
</table>

