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
    function openDetail(){
        parent.opener.location = contextRoot+"/card/cardIndex.do";
        	//	+ "&searchMonth="+ searchMonth;
        window.close();
    }

  //창 닫기 클릭시 쿠키 처리
    function closeWin() {

        if(document.getElementById("check_today").checked){
            /* setCookie("cookie_"+"${alarm.alarmId}", "done", 1); // 쿠기 만료일 하루 뒤 */
            setCookie("cookie_cardCorpUsedMainPop", "done", 1); // 쿠기 만료일 하루 뒤
            window.close();
        }else{
            window.close();
        }
    }

</script>

    <div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>[법인카드 사용등록]</strong></h1>
            <div class="mo_container2">
                <div class="popalarmWrap">
                    <!--출근인정 요청안내-->
                    <table class="tb_list_basic3" summary="출근인정 요청안내 (이름, 부서(직책), 요청사유, 지각일)">
                        <caption>출근인정 요청안내</caption>
                        <colgroup>
                            <col width="100" />
                            <col width="80" />
                            <col width="180" />
                            <col width="*" />
                            <col width="*" />
                            <col width="80" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">지출일</th>
                                <th scope="col">소유자</th>
                                <th scope="col">카드번호</th>
                                <th scope="col">사용처</th>
                                <th scope="col">금액</th>
                                <th scope="col">상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${cardCorpUsedList}" varStatus="status">
                                <tr onClick="openDetail();"  style="cursor:pointer;">
                                    <td><fmt:formatDate value='${data.tmDt}' pattern='yyyy-MM-dd'/></td>
                                    <td>
                                    	<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.cardOwnerUserId}",$(this),"mouseover",null,0,0,0)'>
                                    	${data.cardOwnerUserNm}
                                    	</span>
                                    </td>
                                    <td>
                                    	<c:set var = "cardNumBuf" value="${fn:split(data.cardNum,'-') }" />
                                    	${cardNumBuf[0]}-****-****_${cardNumBuf[3] }
                                    </td>
                                    <td>${data.place}</td>
                                    <td class="txt_money"><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.price}" /></td>
                                    <td>미등록</td>
                                </tr>
                            </c:forEach>
                            <c:if test = "${fn:length(cardCorpUsedList)<=0}">
                                <tr>
                                    <td colspan="5" class="no_result">
                                        <p class="nr_des">조회된 데이터가 없습니다.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <p class="notice_script">* 승인 후 1주일이 경과하여도 등록하지 않은 법인카드 사용 목록입니다.</p>
                    <p class="notice_script">* 목록을 클릭하시면 지출등록 메뉴로 이동되어 바로 등록하실 수 있습니다.</p>
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

