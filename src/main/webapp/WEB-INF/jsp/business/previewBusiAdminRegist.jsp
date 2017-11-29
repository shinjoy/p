<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<div class="modalWrap2">
	<div class="mo_container">
		<h3 class="h3_title_basic">
		[미리보기]정보등록
		</h3>
		<p class="title_noti_right">
			( 적용날짜 :
			<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />
			)
		</p>
	<!--직원,인물,회사-->
	<table class="tb_basic_left" summary="정보공유(정보입력)">
	<caption>정보공유(정보입력)</caption>
	<colgroup>
		<col width="160">
		<col width="*">
		<col width="160">
		<col width="*">
	</colgroup>
	<tbody>
		<tr>
			<th><label for="SIDNAME01">${staffLabel1}</label></th>
			<td>
				<a href="#" class="btn_select_employee mgl6"><em>직원선택</em></a>
				<div id = "staffName1Area"class = "mgt10">
						<span class="employee_list staff1List" id = 'staff1List_1'><span>홍길동</span><em>(시스템기획팀)</em><a href="javascript:deleteStaff('1','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
						<span class="employee_list staff1List" id = 'staff1List_1'><span><div id = 'staff1List_comma' style='display:inline'>,</div>김철수</span><em>(전략기획팀)</em><a href="javascript:deleteStaff('1','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
				</div>
			</td>
			<c:if test="${staffUse2 == 'Y' }">
				<th><label for="SIDNAME02">${staffLabel2}</label></th>
				<td>
				<a href="#"	class="btn_select_employee mgl6"><em>직원선택</em></a>
				<div id = "staffName1Area" class = "mgt10">
						<span class="employee_list staff1List" id = 'staff1List_1'><span>홍길동</span><em>(시스템기획팀)</em><a href="javascript:deleteStaff('1','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
						<span class="employee_list staff1List" id = 'staff1List_1'><span><div id = 'staff1List_comma' style='display:inline'>,</div>김철수</span><em>(전략기획팀)</em><a href="javascript:deleteStaff('1','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
				</div>
				</td>
			</c:if>
			<c:if test="${staffUse2 == 'N' }">
				<th style="background:#fff;border-left:0px;border-right:0px;"><label for="SIDNAME02"></label></th><td style="background:#fff;border-left:0px;"></td>
			</c:if>
		</tr>
		<tr>
			<th><label for="SIDNAME03">${custLabel1}<span class="star">*</span></label></th>
			<td><input type="text" class="input_b" disabled	id="SIDNAME03" value="홍길동" /> <a
				href="#"
				class="s_violet01_btn mgl6"><em class="search">인물</em></a></td>
			<c:if test="${custUse2 == 'Y' }">
			<th><label for="SIDNAME04">${custLabel2}</label></th>
			<td><input type="text" class="input_b" 	id="SIDNAME04" disabled value="홍길동" /> <a
				href="#" class="s_violet01_btn mgl6"><em class="search">인물</em></a></td>
			</c:if>
			<c:if test="${custUse2 == 'N' }">
				<th style="background:#fff;border-left:0px;border-right:0px;"><label for="SIDNAME04"></label></th><td style="background:#fff;border-left:0px;"></td>
			</c:if>
		</tr>
		<tr>
			<th><label for="SIDNAME05">${cpnLabel1}</label></th>
			<td><input type="text" class="input_b"	disabled id="SIDNAME05" value="회사명" /> <a
				href="#"
				class="s_violet01_btn mgl6"><em class="search">회사</em></a></td>
			<c:if test="${cpnUse2 == 'Y' }">
				<th><label for="SIDNAME06">${cpnLabel2}</label></th>
				<td><input type="text" class="input_b" 	id="SIDNAME06" disabled value="회사명"/> <a
					href="#" class="s_violet01_btn mgl6"><em class="search">회사</em></a></td>
			</c:if>
			<c:if test="${cpnUse2 == 'N' }">
				<th style="background:#fff;border-left:0px;border-right:0px;"><label for="SIDNAME06"></label></th><td style="background:#fff;border-left:0px;"></td>
			</c:if>
		</tr>
	</tbody>
</table>
<!--//직원,인물,회사//-->
<!--코드, 진행상태, 금액, 일자, 제목, 내용, 파일첨부-->
<table class="tb_basic_left top_noline" summary="정보공유(정보입력)">
	<caption>정보공유(정보입력)</caption>
	<colgroup>
		<col width="160">
		<col width="*">
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">${pathLabel}<span class="star">*</span></th>
			<td colspan="5"><span class="radio_list2">
					<c:forEach items="${pathCodeList}" var="item" varStatus="status">
						 <label><input	type="radio" name="name01" ${status.index == 0 ? "checked":"" }><span>${item.meaningKor}</span></label>
					</c:forEach>
			</span></td>
		</tr>
		<c:if test="${typeUse == 'Y' }">
			<tr>
				<th scope="row">${typeLabel}</th>
				<td colspan="5"><span class="radio_list2">
					<c:forEach items="${typeCodeList}" var="item" varStatus="status">
							 <label><input	type="radio" onclick="fnObj.checkClassType('${item.sonSetId}');" name="name02" ${status.index == 0 ? "checked":"" }><span>${item.meaningKor}</span></label>
						</c:forEach>
				</span></td>
			</tr>
		</c:if>
		<c:if test="${classUse == 'Y' }">
			<tr>
				<th scope="row">${classLabel}</th>
				<td colspan="5"><span class="radio_list2" id="class_list">
					<c:forEach items="${classCodeList[0].codeList}" var="item" >
						<c:if test='${item.deleteFlag ==  "N"}'>
							<label><input type="radio" name="name03" /><span>${item.meaningKor}</span></label>
						</c:if>
					</c:forEach>
				</span></td>
			</tr>
		</c:if>

		<tr>
			<th><label for="IDNAME01">${priceLabel1}</label></th>
			<td><input type="text" class="input_mrb" id="IDNAME01" disabled value="10"/> ${priceUnit1}</td>
			<c:if test="${priceUse2 == 'Y' }">
				<th><label for="IDNAME02">${priceLabel2}</label></th>
				<td><input type="text" class="input_mrb" id="IDNAME02" disabled value="10"/> ${priceUnit2}</td>
			</c:if>
			<c:if test="${priceUse2 == 'N' }">
				<td colspan="2" style="border-left:0px;"></td>
			</c:if>
			<c:if test="${priceUse3 == 'Y' }">
				<th><label for="IDNAME03">${priceLabel3}</label></th>
				<td><input type="text" class="input_mrb" id="IDNAME03" disabled value="10"/> ${priceUnit3}</td>
			</c:if>
			<c:if test="${priceUse3 == 'N' }">
				<td colspan="2" style="border-left:0px;"></td>
			</c:if>
		</tr>
		<tr>
			<th><label for="IDNAME05">${dateLabel1}</label></th>
			<td><input type="text" value="2015-06-15" class="input_b3" disabled
				id="IDNAME05" /><a href="#" class="icon_calendar"><em>날짜선택</em></a></td>
			<c:if test="${dateUse2 == 'Y' }">
			<th><label for="IDNAME06">${dateLabel2}</label></th>
			<td><input type="text"  class="input_b3" disabled value="2015-06-15"
				id="IDNAME06" /><a href="#" class="icon_calendar"><em>날짜선택</em></a></td>
			</c:if>
			<c:if test="${dateUse2 == 'N' }">
				<td colspan="2" style="border-left:0px;"></td>
			</c:if>
			<c:if test="${dateUse3 == 'Y' }">
			<th><label for="IDNAME07">${dateLabel3}</label></th>
			<td><input type="text" value="2015-06-15" class="input_b3" disabled value="2015/06/15"
				id="IDNAME07" /><a href="#" class="icon_calendar"><em>날짜선택</em></a></td>
			</c:if>
			<c:if test="${dateUse3 == 'N' }">
				<td colspan="2" style="border-left:0px;"></td>
			</c:if>
		</tr>

		<tr class="div_bline">
			<th scope="row"><label for="idName01">제목<span class="star">*</span></label></th>
			<td colspan="5"><input type="text" id="idName01"
				placeholder="제목을 입력해주세요" class="w100" disabled></td>
		</tr>

		<tr>
			<th scope="row"><label for="idName02">내용</label></th>
			<td colspan="5"><textarea name="" cols="" rows="" id="idName02"
					placeholder="내용을 입력해주세요" class="txtarea_b2 w100" disabled></textarea></td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td colspan="5" class="pdd00">
				<div class="addFileList">
					<p class="titleZone">
						<span class="title"><a href="#" class="btn_s_type_g"><em
								class="icon_file">파일첨부</em></a></span> <span class="size"><strong>파일<span>0MB</span></strong>
							/ <em>5MB</em></span>
					</p>

				</div>
			</td>
		</tr>
		<tr>
			<th scope="row">${progressLabel}<span class="star">*</span></th>
			<td colspan="5"><span class="radio_list2">
						<c:forEach items="${progressCodeList}" var="progressCode" varStatus="status">
							<label><input type="radio" name="name08" ${status.index == 0 ? "checked":"" }/><span>${progressCode.meaningKor}</span></label>
						</c:forEach>
			</span></td>
		</tr>
		<tr>
            <th scope="row">정보 보안등급</th>
            <td colspan="5">
            	<span class="radio_list2"  id = "boardInfoLvTag"></span>
            	<script type="text/javascript">
            	var checkedVal ="C";

            	var comBoardInfoLv = getBaseCommonCode('BUSINESS_INFO_LEVEL', null, 'CD', 'NM', null,'','', { orgId : "${baseUserLoginInfo.applyOrgId}" });
            	var comBoardInfoLvTag = createRadioTag('infoLevel', comBoardInfoLv, 'CD', 'NM', checkedVal, 10, 3);	//radio tag creator 함수 호출 (common.js)
        		$("#boardInfoLvTag").html(comBoardInfoLvTag);
            	</script>
            </td>
        </tr>
	</tbody>
</table>
<!--//코드, 진행상태, 금액, 일자, 제목, 내용, 파일첨부//-->
<!--버튼모음-->
<div class="btnZoneBox">
	<a href="#" onclick="fnObj.doClose();return false;" class="p_blueblack_btn"><strong>닫기</strong></a>
</div>
<!--//버튼모음//-->
<!--//정보공유(정보입력)//-->
</div>
</div>


<script>
var fnObj = {
	//구분 선택에 따른 유형 변경
	checkClassType : function(sonSetId){
		var callback = function(result){
			var obj = JSON.parse(result);
    		var list = obj.resultList;

    		var html = "";
    		for(var i =0 ;i < list.length ;i++){
    			var item = list[i];
    			html += '<label><input type="radio" name="name03" /><span>'+ item.meaningKor+'</span></label>';
    		}
    		$("#class_list").html(html);
		}
		var param = { codeSetId : sonSetId};
		commonAjax("POST", contextRoot+"/business/seleteBusinessCodeReg.do", param, callback);
	},
	doClose : function(){
		window.close();
	}
}


</script>

