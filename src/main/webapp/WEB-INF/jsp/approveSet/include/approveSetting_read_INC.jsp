<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<jsp:useBean id="now" class="java.util.Date" />
<table class="tb_list_basic mgt30" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
    <caption>결재문서함 목록</caption>
    <colgroup>
        <col width="100" />
        <col width="100" />
        <col width="150" />
        <col width="150" />
        <col width="150" />
        <col width="90" />
        <col width="90" />
    </colgroup>
    <thead>
        <tr>
            <th scope="col">문서종류</th>
            <th scope="col">문서타입</th>
            <th scope="col">결재/합의자</th>
            <th scope="col">수신자</th>
            <th scope="col">참조자</th>
            <th scope="col">수정자</th>
            <th scope="col">등록자</th>
        </tr>
    </thead>
    <tbody>
		<c:forEach var="data" items="${appvReadSetupList }">
			<tr>
				<td id = "${data.appvDocClass }">${data.appvDocClassName }</td>
				<td>${data.appvDocTypeName }</td>
				<td>
					<span class="radio_list2">
                        <label><input type="radio"  name="approveYn|${data.appvKey }"  value="Y" <c:if test = "${data.approveYn eq 'Y'  }">checked="checked"</c:if>><span>YES</span></label>
                        <label><input type="radio"  name="approveYn|${data.appvKey }"  value="N" <c:if test = "${data.approveYn eq 'N'  }">checked="checked"</c:if>><span>NO</span></label>
                    </span>
				</td>
				<td>
                    <span class="radio_list2">
                        <label><input type="radio"  name="receiveYn|${data.appvKey }"  value="Y" <c:if test = "${data.receiveYn eq 'Y'  }">checked="checked"</c:if>><span>YES</span></label>
                        <label><input type="radio"  name="receiveYn|${data.appvKey }"  value="N" <c:if test = "${data.receiveYn eq 'N'  }">checked="checked"</c:if>><span>NO</span></label>
                    </span>
                </td>
                <td>
                    <span class="radio_list2">
                        <label><input type="radio"  name="ccYn|${data.appvKey }"  value="Y" <c:if test = "${data.ccYn eq 'Y'  }">checked="checked"</c:if>><span>YES</span></label>
                        <label><input type="radio"  name="ccYn|${data.appvKey }"  value="N" <c:if test = "${data.ccYn eq 'N'  }">checked="checked"</c:if>><span>NO</span></label>
                    </span>
                </td>
				<td>${data.updatedName }</td>
				<td>
				    ${data.createdName }
				    <input type="hidden" name = "createdBy|${data.appvKey }" value="${data.createdBy }">
                    <input type="hidden" name = "createDate|${data.appvKey }" value="${data.createDate }">
				</td>
			</tr>
		</c:forEach>
    </tbody>
</table>

<!--버튼영역-->
    <div class="btn_baordZone2">
        <a href="javascript:doSave();" class="btn_blueblack btn_auth">저장</a>
        <a href="javascript:doSearch();" class="btn_witheline btn_auth">취소</a>
    </div>
    <!--//버튼영역//-->

