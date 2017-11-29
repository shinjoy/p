<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">

    $(document).ready(function(){
    	
    });
  
   //라디오 버튼 변경
   function modifyTransferUseYn(userTransferId,selectValue){
	   
	   var url = contextRoot + "/system/modifyTransferUseYn.do";
	   var param = {
			   userTransferId	:	userTransferId,
			   useYn			:	selectValue 
	   };
	   
	   var callback = function(result){
		   
		   var obj = JSON.parse(result);
		   
		   if(obj.resultVal > 0){
			   toast.push("저장되었습니다.");
		   }else{
			   alert("서버오류!!");
		   }
		   
		   
	   };
	   
	   commonAjax("POST", url, param, callback);
	   
   }
</script>

<!--근태현황목록-->
<table id="SGridTarget" class="tb_list_basic" summary="근태현황목록(번호, 이름, 부서, 직위, 출근, 퇴근, 근태여부, 비고)">
	<caption>근태현황목록</caption>
	<colgroup>
		<col width="10%" /> <!--관계사-->
		<col width="15%" /> <!--인계자-->
		<col width="15%" /> <!--인수자-->
		<col width="10%" /> <!--사유-->
		<col width="10%" /> <!--등록일-->
		<col width="6%" /> 	<!--등록자-->
		<col width="10%" /> <!--사용여부-->
	</colgroup>
	<thead>
		<tr>
			<th scope="col">관계사</th>
			<th scope="col">인계자</th>
			<th scope="col">인수자</th>
			<th scope="col">사유</th>
			<th scope="col">등록일</th>
			<th scope="col">등록자</th>
			<th scope="col">사용여부</th>
		</tr>
	</thead>
	<tbody>
	    <c:forEach items="${tranferUserList }" var="data" varStatus="i">
		<tr>
			<td>${data.orgNm}</td>
			<td>${data.giveName}</td>
			<td>${data.takeName}</td>
			<td>${data.comment}</td>
			<td>${data.createDateFormat}</td>
			<td>${data.createdName}</td>
			<td>
				<label><input type="radio" name="useYn${data.userTransferId}" class="mgr3" onclick="modifyTransferUseYn('${data.userTransferId}','Y');" ${data.useYn == 'Y' ? 'checked=true' : ''}/><span class="mgr10">Y</span></label>
				<label><input type="radio" name="useYn${data.userTransferId}" class="mgr3" onclick="modifyTransferUseYn('${data.userTransferId}','N');" ${data.useYn == 'N' ? 'checked=true' : ''}/><span class="mgr10">N</span></label>
			</td>
			
		</tr>
		</c:forEach>
		
		<c:if test = "${fn:length(tranferUserList) <= 0 }">
            <tr>
                <td colspan="10" class="no_result">
                    <p class="nr_des">조회된 데이터가 없습니다.</p>
                </td>
            </tr>
        </c:if>
        
	</tbody>
</table>
<!--// 근태현황목록 //-->
<!--페이지목록-->

