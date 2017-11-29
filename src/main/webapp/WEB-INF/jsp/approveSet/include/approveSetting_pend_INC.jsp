<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
	<br>
	<span class="sys_p_noti mgt10" style="width: 200px;"><span class="icon_noti "></span><span class="pointB mgt10">"즉시" </span><span class="mgt10">설정시 SMS로만 알림이 발송되고 </span><span class="pointB mgt10">"*일"</span><span class="mgt10">로 설정시 SMS와 팝업으로 양쪽으로 알림이 발송됩니다. </span></span>
	<!--미결알림셋팅-->
	<table class="tb_list_basic mgt10" summary="미결알림셋팅 (결재권한구분, 기준설정, 사용여부, 수정자, 등록자)">
		<caption>
			미결알림셋팅
		</caption>
		<colgroup>
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">결재권한구분</th>
				<th scope="col">기준설정</th>
				<th scope="col">사용여부</th>
				<th scope="col">수정자</th>
				<th scope="col">등록자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${appvAlarmSetupList }" var="data">
				<tr>
					<td>
						${data.name }
						<input type="hidden" name = "appvAlarmSetupType" value="${data.appvAlarmSetupType }">
						<input type="hidden" name = "type_${data.appvAlarmSetupType }" value="${empty data.createdBy? 'create':'update' }">
					</td>
					<td class="txt_left radio_list2 vm">
						<label><input type="radio" value="IMMEDIATELY" onclick="chkAlarmSetupType('baseSetupType_${data.appvAlarmSetupType }')" name="baseSetupType_${data.appvAlarmSetupType }" <c:if test = "${data.baseSetupType eq 'IMMEDIATELY' }"> checked="checked"</c:if>/>즉시</label>
						<label><input type="radio" value="PERIOD" onclick="chkAlarmSetupType('baseSetupType_${data.appvAlarmSetupType }')" name="baseSetupType_${data.appvAlarmSetupType }" title="기준설정" <c:if test = "${data.baseSetupType eq 'PERIOD' }"> checked="checked"</c:if>/></label>
						<input type="text" id = "baseSetupPeriod_${data.appvAlarmSetupType }" name = "baseSetupPeriod_${data.appvAlarmSetupType }" maxlength="3"
								value="${data.baseSetupPeriod }" class="input_b w42px number" title="숫자입력" <c:if test = "${data.baseSetupType ne 'PERIOD' }"> disabled="disabled"</c:if>/>
						<span class="mgl6">일 경과시</span>
					</td>
					<td class="radio_list2">
						<label><input type="radio" value="Y" name="useYn_${data.appvAlarmSetupType }" <c:if test = "${data.useYn eq 'Y' }"> checked="checked"</c:if> />Yes</label>
						<label><input type="radio" value="N" name="useYn_${data.appvAlarmSetupType }"<c:if test = "${data.useYn eq 'N' }"> checked="checked"</c:if> />No</label>
					</td>
					<td>${data.createdNm }</td>
					<td>${data.updatedNm }</td>
				</tr>

			</c:forEach>
		</tbody>
	</table>
<!--//미결알림셋팅//-->
<!--버튼영역-->
<div class="btn_baordZone2">
	<a href="javascript:doSaveAppvAlarmSetup()" class="btn_blueblack">저장</a>
	<a href="javascript:doSearch()" class="btn_witheline">취소</a>
</div>
<!--//버튼영역//-->
