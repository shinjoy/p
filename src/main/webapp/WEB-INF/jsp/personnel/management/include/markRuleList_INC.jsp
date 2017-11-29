<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<jsp:useBean id="now" class="java.util.Date" />
<table class="tb_list_basic" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
    <caption>결재문서함 목록</caption>
    <colgroup>
        <col width="150" />
        <col width="150" />
        <col width="*" />
        <col width="200" />
        <col width="150" />
        <col width="150" />

    </colgroup>
    <thead>
        <tr>
            <th scope="col">메뉴</th>
            <th scope="col">권한</th>
            <th scope="col">기준설정</th>
            <th scope="col">사용여부</th>
            <th scope="col">수정자</th>
            <th scope="col">등록자</th>
        </tr>
    </thead>
    <tbody>
		<c:forEach var="data" items="${markRuleList }">
			<tr>
				<td>
					${data.newContentMarkClassName }
					<input type="hidden" name = "newContentMarkClass|${data.newContentMarkClass }|${data.newContentMarkType }" value="${data.newContentMarkClass }">
				</td>
				<td>
					${data.newContentMarkTypeName==null?'-':data.newContentMarkTypeName }
					<input type="hidden" name = "newContentMarkType|${data.newContentMarkClass }|${data.newContentMarkType }" value="${data.newContentMarkType }">
				</td>
				<td class="txt_left">
					<label>
						<input type="radio"  name="readTimeYn|${data.newContentMarkClass }|${data.newContentMarkType }" onclick="chkReadTime($(this))"
								value="Y" <c:if test = "${data.readTimeYn eq 'Y'  }">checked="checked"</c:if>>
						<span>
							<c:choose>
								<c:when test="${data.newContentMarkType eq 'APPROVER'}">결재 즉시 <span class="icon_new" ><em>new</em></span> 삭제</c:when>
								<c:when test="${data.newContentMarkType eq 'RECEIVER'}">열람/수신확인 즉시 <span class="icon_new" ><em>new</em></span> 삭제</c:when>
								<c:otherwise>열람 즉시 <span class="icon_new" ><em>new</em></span> 삭제</c:otherwise>
							</c:choose>
						</span>
					</label><br><br>
					<label>
						<input type="radio"  name="readTimeYn|${data.newContentMarkClass }|${data.newContentMarkType }" onclick="chkReadTime($(this))"
								value="N" <c:if test = "${data.readTimeYn eq 'N'  }">checked="checked"</c:if>>
						<span>설정기간 경과 후 <span class="icon_new" ><em>new</em></span> 삭제</span>
					</label><br><br>
					<input type="text" class="input_b w42px number" id = "markDayCnt|${data.newContentMarkClass }|${data.newContentMarkType }" name = "markDayCnt|${data.newContentMarkClass }|${data.newContentMarkType }"
						title="일수"  maxlength="4" onkeyup="isNumChk($(this))"<c:if test = "${data.readTimeYn eq 'Y'  }">disabled="disabled"</c:if> value="${data.markDayCnt }"/>
					<span>일</span>
				</td>
				<td>
					<span class="radio_list2">
                        <label><input type="radio"  name="useYn|${data.newContentMarkClass }|${data.newContentMarkType }"  value="Y" <c:if test = "${data.useYn eq 'Y'  }">checked="checked"</c:if>><span>YES</span></label>
                        <label><input type="radio"  name="useYn|${data.newContentMarkClass }|${data.newContentMarkType }"  value="N" <c:if test = "${data.useYn eq 'N'  }">checked="checked"</c:if>><span>NO</span></label>
                    </span>
				</td>
				<td>${data.updatedName }</td>
				<td>
					${data.createdName }
					<input type="hidden" name = "createdBy|${data.newContentMarkClass }|${data.newContentMarkType }" value="${data.createdBy }">
					<input type="hidden" name = "createDate|${data.newContentMarkClass }|${data.newContentMarkType }" value="${data.createDate }">
				</td>
		</c:forEach>
    </tbody>
</table>

