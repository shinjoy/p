<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script>

$(document).ready(function(){
	//유저프로필 이벤트 셋팅
	initUserProfileEvent();
 });

//고객선택시 부모창으로 이동
function doSaveUserList(){
	var resultList =[];                     //선택리스트

	$("input[name=chkUserId]:checked").each(function() {
		var userInfo = $(this).val();
		var arrUser = userInfo.split(":");

		var personInfo = new Object();
		personInfo.userId = arrUser[0];
		personInfo.userName = arrUser[1];
		personInfo.position = arrUser[2];

		personInfo.userNm = arrUser[1];
		personInfo.empNo = arrUser[3];
		personInfo.deptNm = arrUser[4];
		personInfo.orgId = arrUser[5];
		personInfo.orgNm = arrUser[6];


		resultList.push(personInfo);
    });

	opener.fnObj.getResult(resultList);
	window.close();
}

//직원전체 선택 /해제
function chkUserAll(th){
    if(th.checked){
        $('input:checkbox[name=chkUserId]').each(function(idx, el){
            $(el).attr('checked', true);
        });     //고객전체 체크
    }else{
    	var arrDisabledUser = "${disabledStr}";
    	if(arrDisabledUser != ""){
    		var tmpDisUser = arrDisabledUser.split(",");

   			$('input:checkbox[name=chkUserId]').each(function(idx, el){
   				for(var i=0;i<tmpDisUser.length;i++){
   					if($(el).val().split(":")[0] != tmpDisUser[i]){
                        $(el).attr('checked', false);
                    }else{
                        $(el).attr('checked', true);
                    }
   				}
   	        });
    	}else{
    		$('input:checkbox[name=chkUserId]').removeAttr('checked');     //고객전체 체크해제
    	}
    }
}
</script>


    <div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>[참여직원선택]</strong></h1>
            <div class="mo_container">


                <div class="board_classic">
                    <div class="leftblock">
                        <span class="count_result"><strong>전체</strong><em>${fn:length(activityUserList)}</em>건</span>
                    </div>
                    <div class="rightblock">
                    </div>
                </div>
                <table class="tb_regi_basic2" summary="직원선택 (부서, 직원명, 사번)">
                    <caption>직원선택</caption>
                    <colgroup>
                        <col width="30" />  <!--체크박스-->
                        <col width="*" />   <!--부서-->
                        <col width="*" />   <!--직원명-->
                        <col width="100" /> <!--사번-->
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">
                                <%-- <c:if test="${empty disabledStr}"> --%>
                                    <input onclick="chkUserAll(this);" type="checkbox"  title="직원선택" />
                                <%-- </c:if> --%>
                            </th>
                            <th scope="col">부서</th>
                            <th scope="col">직원명</th>
                            <th scope="col">사번</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="data" items="${activityUserList}" varStatus="status">
	                        <tr>
	                            <c:set var="arrTmpUserId" value="${fn:split(userStr,',')}" />
	                            <c:set var="tmpUserChecked" value="" />

								<c:forEach var="tmpUser" items="${arrTmpUserId}" varStatus="u">
								    <c:if test="${tmpUser eq data.userId}">
								        <c:set var="tmpUserChecked" value="checked"/>
								    </c:if>
								</c:forEach>

								<c:set var="arrDisabledUser" value="${fn:split(disabledStr,',')}" />
                                <c:set var="tmpUserDisabled"  value="" />

                                <c:forEach var="tmpDisUser" items="${arrDisabledUser}" varStatus="u">
                                    <c:if test="${tmpDisUser eq data.userId}">
                                        <c:set var="tmpUserDisabled" value="disabled"/>
                                    </c:if>
                                </c:forEach>

	                            <td class="txt_center">
	                                <input type="checkbox"  id="chkUserId" name="chkUserId"  value="${data.userId}:${data.userNm}:${data.position}:${data.empNo}:${data.deptNm}:${data.orgId}:${data.orgNm}" title="직원선택"  ${tmpUserChecked} ${tmpUserDisabled}/>
	                            </td>
	                            <td>${data.deptNm}</td>
	                            <td class="txt_center">
	                            <span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId}",$(this),"mouseover",null,0,-150,150)'>
	                            	${data.userNm}
	                            </span>
	                            </td>
	                            <td class="txt_center">${data.empNoView}</td>
	                        </tr>
                        </c:forEach>
                        <c:if test="${empty activityUserList}">
                            <tr>
				                <td colspan="4" class="no_result">
				                    <p class="nr_des">등록된 참여직원이 없습니다.</p>
				                </td>
				            </tr>
                        </c:if>
                    </tbody>
                </table>
                <div class="btnZoneBox">
                    <a href="javascript:doSaveUserList();" class="p_blueblack_btn"><strong>선택</strong></a>
                    <a href="javascript:window.close();" class="p_withelin_btn">취소</a>
                 </div>
            </div>
        </div>
        <!--//업무일지등록//-->
    </div>

