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
        <col width="250" />
        <col width="250" />
        <col width="150" />
        <col width="90" />
        <col width="90" />
    </colgroup>
    <thead>
        <tr>
            <th scope="col">문서종류</th>
            <th scope="col">문서타입</th>
            <th scope="col">필수수신자</th>
            <th scope="col">필수참조자</th>
            <th scope="col">사용여부</th>
            <th scope="col">수정자</th>
            <th scope="col">등록자</th>
        </tr>
    </thead>
    <tbody>
		<c:forEach var="data" items="${appvReceiverSetupList }">
			<tr>
				<td id = "${data.appvDocClass }">${data.appvDocClassName }</td>
				<td>${data.appvDocTypeName }</td>
				<td class="txt_left">
				    <a href="javascript:fnObj.openEmpPopup('RECEIVER', '${data.appvKey}', '${data.spanKey}');" class="btn_select_employee" ><em>직원선택</em></a>&nbsp;
				    <span id="spanReceiver_${data.spanKey}">
				        <c:if test="${not empty data.receiverNames }">
					        <c:set var="arrUserName" value="${fn:split(data.receiverNames,':::::')}" />
					        <c:forEach items="${arrUserName}" var="userName" varStatus="userNameStatus">
					            <span class="employee_list" >
                                  <span>${fn:split(userName,'||-||')[1] }</span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>
                                  <input type="hidden" name="arrUserId" id="arrUserId" value="userId|${data.appvKey}|RECEIVER|${fn:split(userName,'||-||')[0] }" />
                                </span>
					        </c:forEach>
					    </c:if>
					</span>
				</td>
				<td class="txt_left">
				    <a href="javascript:fnObj.openEmpPopup( 'CC' , '${data.appvKey}','${data.spanKey}');" class="btn_select_employee" ><em>직원선택</em></a>&nbsp;
				    <span id="spanCc_${data.spanKey}">
                        <c:if test="${not empty data.ccNames }">
                         <c:set var="arrUserName" value="${fn:split(data.ccNames,':::::')}" />
                         <c:forEach items="${arrUserName}" var="userName" varStatus="userNameStatus">
                             <span class="employee_list" >
                                  <span>${fn:split(userName,'||-||')[1] }</span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>
                                  <input type="hidden" name="arrUserId" id="arrUserId" value="userId|${data.appvKey}|CC|${fn:split(userName,'||-||')[0] }" />
                             </span>
                         </c:forEach>
                        </c:if>
                    </span>
				</td>
				<td>
					<span class="radio_list2">
                        <label><input type="radio"  name="useYn|${data.appvKey }"  value="Y" <c:if test = "${data.useYn eq 'Y'  }">checked="checked"</c:if>><span>YES</span></label>
                        <label><input type="radio"  name="useYn|${data.appvKey }"  value="N" <c:if test = "${data.useYn eq 'N'  }">checked="checked"</c:if>><span>NO</span></label>
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



