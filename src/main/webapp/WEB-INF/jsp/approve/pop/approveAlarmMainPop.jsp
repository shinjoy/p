<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javaScript" language="javascript">
	$(document).ready(function () {
		$(window).load(function() {

		});
	});


	//상세보기 열기
    function goDetailPage(type,appvDocId,appvDocClass, appvDocType, docStatus, approveProcessId){

    	$("#approveFrm #appvDocId").val(appvDocId);
		$("#approveFrm #appvDocClass").val(appvDocClass);
		$("#approveFrm #appvDocType").val(appvDocType);
		$("#approveFrm #docStatus").val(docStatus);
		$("#approveFrm #approveProcessId").val(approveProcessId);



		var url = "";

		if(type == "APPROVE" || type == "AGREE"){
			$("#approveFrm #listType").val("pendList");
			url = contextRoot+"/approve/approvePendDetail.do";
		}else if(type == "RECEIVE"){
			$("#approveFrm #listType").val("rcList");
			url = contextRoot+"/approve/getApproveRcDetail.do";
		}else if(type == "FINANCE"){
			$("#approveFrm #listType").val("expenseList");
			url = contextRoot+"/approve/approveExpenseDetail.do";
		}

		var option = "width=1100px,height=800px,resizable=yes,scrollbars = yes";
	    commonPopupOpen("approveDetailPop",url,option,$("#approveFrm"));
    }

  //창 닫기 클릭시 쿠키 처리
    function closeWin() {

        if(document.getElementById("check_today").checked){
            /* setCookie("cookie_"+"${alarm.alarmId}", "done", 1); // 쿠기 만료일 하루 뒤 */
            setCookie("cookie_approveAlarmMainPop", "done", 1); // 쿠기 만료일 하루 뒤
            window.close();
        }else{
            window.close();
        }
    }

  var approveObj = {
		  doSearch: function(popType){
			  url = contextRoot+"/approve/approveAlarmMainPop.do";
			  $("#approveFrm").attr("action",url);

			  $("#approveFrm").submit();
		  }
  }

</script>
	<form id = "approveFrm" name = "approveFrm" method="post">
		<!-- 상세화면 이동을 위한 파라미터  :S -->
		<input type="hidden" id = "appvDocId" name = "appvDocId">
		<input type="hidden" id = "appvDocClass" name = "appvDocClass">
		<input type="hidden" id = "appvDocType" name = "appvDocType">
		<input type="hidden" id = "docStatus" name = "docStatus">
		<input type="hidden" id = "approveProcessId" name = "approveProcessId">
		<input type="hidden" id = "listType"  name = "listType">
		<input type="hidden" id = "approveDetailPopYn" name = "approveDetailPopYn" value="A">
		<input type="hidden" id = "approveDraftIngYn" name = "approveDraftIngYn" value="N">
	</form>
    <div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>[전자결재 미결문서 알림팝업]</strong></h1>
            <div class="mo_container2">
                <div class="popalarmWrap">
                	<h3 class="h3_title_basic">미결(수신확인,지출확인 포함) 알림</h3>
                    <!--출근인정 요청안내-->
                    <table class="tb_list_basic3" summary="출근인정 요청안내 (이름, 부서(직책), 요청사유, 지각일)">
                        <caption>전자결재 미결문서 알림 안내</caption>
                        <colgroup>
                            <col width="100" />
                            <col width="80" />
                            <col width="100" />
                            <col width="80" />
                            <col width="110" />
                            <col width="*" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">상신일(종결일)</th>
                                <th scope="col">지연일수</th>
                                <th scope="col">문서타입</th>
                                <th scope="col">상신자</th>
                                <th scope="col">부서(직책)</th>
                                <th scope="col">제목</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${sendAppvAlarmList}" varStatus="status">
                                <tr onclick="goDetailPage('${data.type}','${data.appvDocId}')" style="cursor: pointer;">
                                    <td>
                                    	<c:choose>
	                                    	<c:when test="${data.type eq 'AGREE' or data.type eq 'APPROVE' }">
	                                    		<fmt:formatDate value='${data.submitDate}' pattern='yyyy-MM-dd'/>
	                                    	</c:when>
	                                    	<c:otherwise>
	                                    		<fmt:formatDate value='${data.submitDate}' pattern='yyyy-MM-dd'/>
	                                    		(<fmt:formatDate value='${data.targetDate}' pattern='yyyy-MM-dd'/>)
	                                    	</c:otherwise>
                                    	</c:choose>
                                    </td>
                                    <td>
                                    	${data.diffDay}
                                    </td>
                                    <td>
                                    	${data.appvDocTypeNm }
                                    </td>
                                    <td>${data.name}</td>
                                    <td>${data.userDeptNm}(${data.rankNm })</td>
                                    <td>${data.docTitle }</td>
                                </tr>
                            </c:forEach>
                            <c:if test = "${fn:length(sendAppvAlarmList)<=0}">
                                <tr>
                                    <td colspan="6" class="no_result">
                                        <p class="nr_des">조회된 데이터가 없습니다.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <p class="notice_script">* 목록을 클릭하시면 팝업으로 해당문서 확인 가능합니다.</p>
                </div>
            </div>
            <!--창닫기-->
            <div class="todayclosebox">
                <div class="fl_block"><label><input type="checkbox"  name="check_today" id="check_today"  onclick="closeWin();"/><span>오늘은 그만보기</span></label></div>
                <div class="fr_block"><button type="button" class="btn_close" onClick="closeWin();"><span>닫기</span><span>X</span></button></div>
            </div>
            <!--//창닫기//-->
        </div>
        <!--//업무일지등록//-->
    </div>

