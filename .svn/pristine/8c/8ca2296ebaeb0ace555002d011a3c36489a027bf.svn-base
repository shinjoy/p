<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


	<div class="mo_container" >
		<h3 class="h3_title_basic">${titleLabel} CODE 입력</h3>
		<input type="hidden" value="${codeSetId }" name="codeSetId" id="codeSetId">
		<table class="tb_regi_basic2 tb_fixed" summary="CODE 등록 (정렬값, 영문코드, 한글명, 추가/삭제)">
			<caption>CODE 등록</caption>
			<colgroup>
				<col width="80">
				<col width="*">
				<col width="*">
				<col width="65">
				<col width="80">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">정렬값</th>
					<th scope="col">영문코드</th>
					<th scope="col">한글명</th>
					<th scope="col">사용여부</th>
					<th scope="col">추가/삭제</th>
				</tr>
			</thead>
			<tbody id="tbody">
			</tbody>
		</table>
		<div class="btnZoneBox">
			<a href="#" onclick="fnObj.doSave();" class="p_blueblack_btn btn_auth"><strong>저장</strong></a>
			<a href="#" onclick="fnObj.doClose();return false;" class="p_withelin_btn">취소</a>
		</div>
	</div>





<script>
var codeSetName = "${codeSetName}";
var line = 1;
var fnObj = {
		//선로딩
		preload : function(){
			fnObj.doSearch();
		},
		
		 //코드 셋에 해당하는 코드 리스트 반환
	    doSearch: function(){ 
	    	
	    	var url = contextRoot + "/business/seleteBusinessCodeReg.do";
	    	var param = {
			    			codeSetId : $("#codeSetId").val(),
			    			orgId : '${baseUserLoginInfo.applyOrgId}'
	    				};   	
	    	    		    	    	    	
	    	var callback = function(result){
	    		
	    		var obj = JSON.parse(result);
	    		    		
	    		var list = obj.resultList;
	    		var html = "";
	    		
	    		for(var i = 0 ;i < list.length ;i++){
	    			var item = list[i];
	    			html += '<tr id="num'+ line +'">';
	    			html += '<input type="hidden" id="codeListId" name="codeListId" value="'+ item.codeListId +'"/>';
	    			html += '<input type="hidden" id="sonSetId" name="sonSetId" value="'+ item.sonSetId +'"/>';
	    			html += '<td class="bg_skyblue"><input type="num" class="input_b w100"	id="sort" name="sort" value="'+ item.sort +'" placeholder="숫자입력" title="정렬값입력"/></td>';
	    			html += '<td><input type="text" readonly="readonly" class="input_b w100" id="value" name="value" value="'+ item.value +'" placeholder="영문코드 입력" title="영문코드 입력" /></td>';
	    			html += '<td><input type="text" class="input_b w100" id="meaningKor" name="meaningKor" value="'+ item.meaningKor +'" placeholder="한글명입력" title="한글명입력" /></td>';
	    			html += '<td class="txt_center"><select id="delFlag" class="select_b w100pro" name="delFlag">';
	    			if(item.deleteFlag == 'N'){
	    				html += '<option value="Y" selected>Y</option>';
	    				html += '<option value="N">N</option>';
	    			}else{
	    				html += '<option value="Y" >Y</option>';
	    				html += '<option value="N" selected>N</option>';
	    			}
	    			html += '</select></td>';
	    			html += '<td class="txt_center"><a href="#" onclick="fnObj.addLine('+ line +');return false;" class="btn_ac_add"><em>추가</em></a></td>';
	    			html += '</tr>';
	    			line++;
	    		}
	    		
	    		$("#tbody").html(html);
	    		
	    		//데이터가 없는 경우
	    		if(obj.resultVal  == 0){		    		
		    		var innitHtml = '<tr id="num'+ line+'">';
		    		innitHtml += '<input type="hidden" id="sonSetId" name="sonSetId" value="0"/>';
		    		innitHtml += '<td class="bg_skyblue"><input type="num" class="input_b w100" value="10" name="sort" id="sort" placeholder="숫자입력" title="정렬값입력"/></td>';
		    		innitHtml += '<td><input type="text" class="input_b w100" id="value" name="value" placeholder="영문코드입력" title="영문코드입력"/></td>';
		    		innitHtml += '<td><input type="text" class="input_b w100" id="meaningKor" name="meaningKor" placeholder="한글명입력" title="한글명입력"/></td>';
		    		innitHtml += '<td class="txt_center"><select class="select_b w100pro" id="delFlag" selected name="delFlag"><option value="Y">Y</option>';
		    		innitHtml += '<option value="N">N</option></select></td>';
		    		innitHtml += '<td class="txt_center"><a href="#" onclick="fnObj.addLine('+ line +');return false;"	class="btn_ac_add"><em>추가</em></a></td>';
		    		innitHtml += '</tr>';
		    		
		    		$("#tbody").append(innitHtml);
	    		}
	    		//ie text 입력 불가 현상 방지
	    		$('input[name=sort]').focus();
	    		
	    		
	    		parent.myModal.resize();		//모달창 리사이즈 함수 호출(부모객체)
			};    		    	
	    	
	    	commonAjax("POST", url, param, callback);
	    },
	    
	    //추가
		addLine : function(index){
			line++;
			var sort = 0;
			
			var html = '<tr id="num'+ line +'">';
			html += '<input type="hidden" id="sonSetId" name="sonSetId" value="0"/>';
			html += '<td class="bg_skyblue"><input type="num" class="input_b w100" value="'+sort+'" id="sort" name="sort" placeholder="숫자입력" title="정렬값입력"/></td>';
			html += '<td><input type="text" class="input_b w100" id="value" name="value" placeholder="영문코드입력" title="영문코드입력" /></td>';
			html += '<td><input type="text" class="input_b w100" id="meaningKor" name="meaningKor" placeholder="한글명입력" title="한글명입력" /></td>';
			html += '<td class="txt_center"><select id="delFlag" class="select_b w100pro" name="delFlag"><option value="Y">Y</option><option value="N">N</option></select></td>';
			html += '<td class="txt_center"><a href="#" onclick="fnObj.addLine('+ (line) +');return false;" class="btn_ac_add"><em>추가</em></a>';
			html += '<a href="#" onclick="fnObj.removeLine('+line+');return false;" class="btn_ac_delete"><em>삭제</em></a></td>';
			html += '</tr>';
			$("#num"+index).after(html);
			
			$("#tbody tr").each(function(index, value){
				sort += 10;
				$(this).find("input[name=sort]").val(sort);
			});
			
			
			parent.myModal.resize();		//모달창 리사이즈 함수 호출(부모객체)
		},
		
		//삭제
		removeLine : function(index){
						
			line--;
			var sort = 0;
			$("#num"+index).remove();
			
			$("#tbody tr").each(function(number, value){
				sort += 10;
				$(this).find("input[name=sort]").val(sort);
			});		
			
			
			parent.myModal.resize();		//모달창 리사이즈 함수 호출(부모객체)
		},
		//저장 or 수정
		doSave : function(){
			var orgId 		= '${baseUserLoginInfo.orgId}';
			var pValue = []; // 영문코드 중복 체크
			var pArray = []; // 입력된 코드 리스트
			
			var addYn = true;
			var sortYn = true;
			var validateYn = true;
			var notDuplicateYn = true;
			var dupliNum = 0;
			
			$("#tbody tr").each(function(number, value){
				var codeListId_ = $(this).find("input[name='codeListId']").val();
				if(codeListId_ == undefined){
					codeListId_ = "0";
				}
				
				var value = $(this).find("input[name='value']").val();
				if(value != '' && codeListId_ == "0"){ //신규인것만
					value = value.toUpperCase();
					$(this).find("input[name='value']").val(value);
				}
				
				var attr = {
						codeListId : codeListId_, //기존데이터
						sort       : $(this).find("input[name='sort']").val(),
						meaningKor : $(this).find("input[name='meaningKor']").val(),
						meaningEng : value,
						value      : value,
						delFlag :  $(this).find("select[name='delFlag']").val(),
						sonSetId  :  $(this).find("input[name='sonSetId']").val()
						
				};
				
				if(attr.value == '' || attr.meaningKor == '' || attr.sort == ''){
					validateYn = false;
				}
				
				//sort 확인
				var regExp = /^[0-9]*$/;
				if(!regExp.test(attr.sort)){
					sortYn = false;
				}
				
				//영문코드 확인
				regExp = /^[A-Za-z\_]*$/;  
				if(!regExp.test(attr.value)){
					addYn = false;
				}
				
				for(var i = 0 ; i < pValue.length ; i++){
					if(pValue[i] == attr.value){
						dupliNum = number;
						notDuplicateYn = false;	
					}
				}
				
				pValue.push(attr.value);
				pArray.push(attr);
			});
			
			if(!validateYn){
				dialog.push({body:"<br>모든 입력값은 채워주세요.</b>", type:"", onConfirm:function(){	return;}});
				return;
			}
			
			if(!sortYn){
				dialog.push({body:"<br>정렬에는 숫자만 입력이 가능합니다.</b>", type:"", onConfirm:function(){	return;}});
				return;
			}
			
			if(!addYn){
				dialog.push({body:"<br>영문자와  '_' 만 입력이 가능합니다.</b>", type:"", onConfirm:function(){	return;}});
				return;
			}
			
			if(!notDuplicateYn){
				dialog.push({body:"<br>중복된 영문코드가 있습니다.</b>", type:"", onConfirm:function(){	$("input[name='value']").eq(dupliNum).focus(); return;}});
				return;
			}
			
			var params = {
					codeType : codeSetName,
					pArray   : JSON.stringify(pArray),
					codeSetId : $("#codeSetId").val()
			};
			
			
			var callback = function(result){
		  		var obj = JSON.parse(result);
		  		if(obj.result == 'SUCCESS'){
		  			alertM("저장되었습니다.");
		  			parent.fnObj.loadCodeList(codeSetName, $("#codeSetId").val());		
		  			parent.fnObj.loadCodeList("INFO_CLASS", null);
		  			//parent.location.reload();
		  			parent.myModal.close();
		  		}
			}
			
			commonAjax("POST", contextRoot+"/business/saveBusinessCodeReg.do", params, callback);
		},
		
		//취소
		doClose : function(){
			parent.myModal.close();
		}
	    
	    
}

$(function(){
	//선로딩
	fnObj.preload();
});
</script>