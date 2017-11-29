<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script>

$(document).ready(function(){
    $("#searchCstNm").focus();
 });

function linkPage(pageNo){
    $('#pageIndex').val(pageNo);
    $('#cstNmKor').val(engTypeToKor($('#searchCstNm').val()));
    commonAjaxSubmit("POST",$("#searchCpn"),callback);
}

//Ajax Callback
function callback(data){
    $("#listArea").html(data);
}


//고객선택시 부모창으로 이동
function setNetPoint(sNb,cpnSnb,cstNm,cpnNm,team,position){
	if(opener.cstPopupCallback){
		opener.cstPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position);
	}else{
		opener.parent.cstPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position);
	}

	window.close();
}
//고객 신규입력하기
function popRgstCst(actionType,sNb){
	var popStatus = null;
	if(opener.reOpenCst){
		popStatus = opener.reOpenCst($("#searchCstNm").val(), actionType, sNb);
    }else{
    	popStatus = opener.parent.reOpenCst($("#searchCstNm").val(), actionType, sNb);
    }
	window.close();
	popStatus.focus();
}
</script>


    <div id="compnay_dinfo">
        <!--회사상세보기(회사정보)-->
        <div class="modalWrap2">
            <h1><strong>고객검색</strong></h1>
            <div class="mo_container">
                <!-- <ul class="gray_arrow_list">
                    <li>소속회사명을 검색해 보세요 시너지넷 DB에 있으면 가입이 훨씬 수월합니다. </li>
                    <li>회사가 검색되지 않으면 ‘신규입력하기’ 버튼을 눌러 내용을 구체적으로 입력해주세요<br />
                    아니면 시너지넷 관리자에게 연락부탁드립니다. (고객센터 : 02-586-5981)</li>
                </ul> -->
                <div id="CompanySerach">
                    <form name="searchCpn" id="searchCpn" action="<c:url value='/person/customerListPopupAjax.do' />" method="post">
				    <input type="hidden" id="pageIndex" name="pageIndex">
				    <input type="hidden" id="cstNmKor" name="cstNmKor" value="${searchCstNm}">
				    <input type="hidden" id="cpnId" name="cpnId" value="${personVO.cpnId}">
                    <table class="tb_ProfileInfo" summary="고객검색">
                        <caption>고객검색</caption>
                        <colgroup>
                            <col width="140" />
                            <col width="*" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row" rowspan="2" class="bgGray"><label for="searchCstNm">이름</label></th>
                                <td>
                                    <input type="text" id="searchCstNm" name="searchCstNm"  onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" value="${searchCstNm}" class="applyinput_B" />
                                    <a href="javascript:linkPage('1')" class="mgl8 s_violet01_btn"><em class="search">검색</em></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </form>
                </div>


                <div id = "listArea">
                    <jsp:include page="./include/customerListPopup_INC.jsp"></jsp:include>
                </div>

                <!--//검색결과有//-->
            </div>
        </div>
        <!--//회사상세보기(회사정보)//-->
    </div>

