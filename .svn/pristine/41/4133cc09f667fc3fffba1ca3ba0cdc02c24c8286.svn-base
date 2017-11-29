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
function setCstInfo(sNb,cpnSnb,cstNm,cpnNm,team,position){
	//console.debug(parent);
	if(opener.cstDupChkPopupCallback){
		opener.cstDupChkPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position);
	}else{
		opener.parent.cstDupChkPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position);
	}

	window.close();
}
//고객 신규입력하기
function setNewCst(){
	alert("고객명을 확인해주세요.");
	opener.cstDupChkPopupCallback($("#searchCstNm").val());
	window.close();
}

//고객 수정하기
function updateCstInfo(sNb){
    var url = "<c:url value='/person/modifyCst.do'/>" + "?sNb=" + sNb;
    opener.parent.location.href = url;
    window.close();
}
</script>


    <div id="compnay_dinfo">
        <!--회사상세보기(회사정보)-->
        <div class="modalWrap2">
            <h1><strong>고객중복체크</strong></h1>
            <div class="mo_container">
                <div id="CompanySerach">
                    <form name="searchCpn" id="searchCpn" action="<c:url value='/person/customerDupChkPopupAjax.do' />" method="post">
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
                    <jsp:include page="./include/customerDupChkPopup_INC.jsp"></jsp:include>
                </div>

                <!--//검색결과有//-->
            </div>
        </div>
        <!--//회사상세보기(회사정보)//-->
    </div>

