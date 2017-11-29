<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	
	<div class="mo_container">
		<h3 class="h3_title_basic">${titleLabel} CODE 입력</h3>
		<table class="tb_regi_basic2" summary="CODE 등록 (정렬값, 영문코드, 한글명, 추가/삭제)">
			<caption>CODE 등록</caption>
			<colgroup>
				<col width="80">
				<col width="*">
				<col width="*">
				<col width="60">
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
		<div class="btnZoneBox"><a href="#" onclick="fnObj.doSave();return false;" class="p_blueblack_btn"><strong>저장</strong></a>
		<a href="#" onclick="fnObj.doClose();return false;" class="p_withelin_btn">취소</a></div>
	</div>
	



<script>
var line = 1;
var fnObj = {
	//선로딩
	preload: function(){
		fnObj.doSearch();
	},
	//유형에 해당하는 코드들 검색.
	doSearch : function(){
		var callback = function(result){
			//ie text 입력 불가 현상 방지
    		
			
			var obj = JSON.parse(result);
			var list = obj.resultList;
			for(var i = 0 ;i < list.length ;i++){
				var item = list[i];
				var sort_ = item.sort;
				var div_id = "top"+item.sort;
				var html = '<tr class="code_ttbg" id="'+div_id+'">';
				html += '<input type="hidden" name="codeListId" value="'+ item.codeListId +'">';
				html += '<input type="hidden" name="sonSetId" value="'+ item.sonSetId +'">';
				html += '<td>'+item.sort+'</td><td>'+item.value+'</td><td>'+item.meaningKor+'</td><td>';
				if(item.deleteFlag == 'N'){
					html += "사용";
				}else{
					html += "미사용";
				}
				html += '</td><td class="txt_center"></td></tr>';
				if(item.codeList != null && item.codeList.length > 0){
					for(var j = 0 ; j < item.codeList.length ;j++){
						var codeItem = item.codeList[j];
						var trId = div_id+"_"+line;
						if(j == (item.codeList.length-1)){
							html += '<tr class="second_depth_last" id="'+trId +'">';
						}else{
							html += '<tr class="second_depth" id="'+trId +'">';
						}
						html += '<input type="hidden" name="codeSetId" value="'+codeItem.codeSetId+'">';
						html += '<input type="hidden" name="codeListId" value="'+codeItem.codeListId+'">';
						html += '<th class="level_second"><input type="num" class="input_b w100" value="'+ codeItem.sort+'" name="sort" placeholder="숫자입력" title="정렬값입력"></th>';
						html += '<td class="level_second"><input type="text" readonly class="input_b w100" value="'+ codeItem.value+'" name="value" placeholder="영문코드입력" title="영문코드입력" ></td>';
						html += '<td class="level_second"><input type="text" class="input_b w100" value="'+ codeItem.meaningKor+'" name="meaningKor" placeholder="한글명입력" title="한글명입력"  /></td>';
						html += '<td class="txt_center"><select id="delFlag" class="select_b w100pro" name="delFlag">';

		    			if(codeItem.deleteFlag == 'N'){
		    				html += '<option value="Y" selected>Y</option>';
		    				html += '<option value="N">N</option>';
		    			}else{
		    				html += '<option value="Y" >Y</option>';
		    				html += '<option value="N" selected>N</option>';
		    			}
		    			html += '</select></td>';
						html += '<td class="txt_center dot_line"><a href="#" onclick="fnObj.addLine('+line+','+div_id+');return false;" class="btn_ac_add"><em>추가</em></a></td>';
						html += '</tr>';
						line++;
					}
				}else{
					var trId = div_id+"_"+line;
					html += '<tr class="second_depth_last" id="'+trId+'">';
					html += '<th class="level_second"><input type="num" value="'+ (++sort_) +'" class="input_b w100" name="sort" placeholder="숫자입력" title="정렬값입력"></th>';
					html += '<td class="level_second"><input type="text" class="input_b w100"  name="value" placeholder="영문코드입력" title="영문코드입력" ></td>';
					html += '<td class="level_second"><input type="text" class="input_b w100" name="meaningKor" placeholder="한글명입력" title="한글명입력"  /></td>';
					html += '<td class="txt_center"><select class="select_b w100pro" id="delFlag" selected name="delFlag"><option value="Y">Y</option>';
					html += '<option value="N">N</option></select></td>';
					html += '<td class="txt_center dot_line"><a href="#" onclick="fnObj.addLine('+line+','+div_id+');return false;"  class="btn_ac_add"><em>추가</em></a></td>';
					html += '</tr>';
					line++;
				}
				$("#tbody").append(html);
				$('input[name=sort]').focus();
			}
			
			
			parent.myModal.resize();		//모달창 리사이즈 함수 호출(부모객체)
			
		};
		
		commonAjax("POST", contextRoot+"/business/selectCodeApplyClassList.do", null, callback);
	},
	//라인 추가
	addLine : function(index, divId){
		var div = $(divId).attr("id");
		var html = "";
		html += '<tr class="second_depth" id="'+div+ '_'+ line +'">';
		html += '<th class="level_second"><input type="num"  class="input_b w100" name="sort" placeholder="숫자입력" title="정렬값입력"></th>';
		html += '<td class="level_second"><input type="text" class="input_b w100"  name="value" placeholder="영문코드입력" title="영문코드입력" ></td>';
		html += '<td class="level_second"><input type="text" class="input_b w100" name="meaningKor" placeholder="한글명입력" title="한글명입력"  /></td>';
		html += '<td class="txt_center"><select class="select_b w100pro" id="delFlag" selected name="delFlag"><option value="Y">Y</option>';
		html += '<option value="N">N</option></select></td>';
		html += '<td class="txt_center dot_line"><a href="#" onclick="fnObj.addLine('+line+','+div+');return false;" class="btn_ac_add"><em>추가</em></a>';
		html += '<a href="#" onclick="fnObj.removeLine(\''+line+'\',\''+div+'\');return false;" class="btn_ac_delete"><em>삭제</em></a></td>';
		html += '</tr>';


		$("#"+div+"_"+index).attr("class", "second_depth");
		$("#"+div+"_"+index).after(html);


		var sort = 0;
		$("#tbody").find("[id^="+ div+"]").each(function(number, value){
			if(number == 0){
				sort = $(this).find("td").eq(0).html();
			}else{
				var nowId =  $(this).closest("tr").attr("id");
				var nextId = $(this).closest("tr").next("tr").attr("id");

				if(nextId == '' || nextId == undefined){
					$(this).closest("tr").attr("class", "second_depth_last");
				}else{
					var nextId_ =  nextId.split("_");
					var nowId_ =  nowId.split("_");
					if(nextId_[0] != nowId_[0]){
						$(this).closest("tr").attr("class", "second_depth_last");
					}
				}
			 	$(this).find("input[name='sort']").val(++sort);
			}
		});

		line++;
		
		
		parent.myModal.resize();		//모달창 리사이즈 함수 호출(부모객체)
	},
	
	
	//라인 삭제
	removeLine : function(index, divId){
		var div = divId+"_"+index;

		line--;
		var sort = 0;

		$("#"+div).remove();
		$("#tbody").find("[id^="+ divId+"]").each(function(number, value){
			if(number == 0){
				sort = $(this).find("td").eq(0).html();
			}else{
				var nextId = $(this).closest("tr").next("tr").attr("id");
								//console.log("다음아이디 :"+ divId+","+nextId);
				if(nextId == '' || nextId == undefined){
					$(this).closest("tr").attr("class", "second_depth_last");
				}else{
					var nextId_ =  nextId.split("_");
					if(nextId_[0] != divId){
						$(this).closest("tr").attr("class", "second_depth_last");
					}
				}

			 	$(this).find("input[name='sort']").val(++sort);
			}
		});

		
		parent.myModal.resize();		//모달창 리사이즈 함수 호출(부모객체)
		
	},

	//저장 혹은 수정
	doSave : function(){
		var sonSetId = 0;
		var pList = [];
		var pValue = [];

		var addYn = true;
		var validateYn = true;
		var notDuplicateYn = true;
		var sortYn = true;
		var dupliNum = 0;

		$("#tbody tr").each(function(number, value){

			if($(this).hasClass("code_ttbg")){
				//시작하는 라인인 경우
				sonSetId = $(this).find("input[name='sonSetId']").val();
			}else{
				var codeListId_ = $(this).find("input[name='codeListId']").val();
				if(codeListId_ == undefined){
					codeListId_ = "0";
				}

				var value = $(this).find("input[name='value']").val();
				if(value != ''){
					value = value.toUpperCase();
					$(this).find("input[name='value']").val(value);
				}

				var attr = {
						codeListId : codeListId_, //기존데이터
						codeSetId  : sonSetId,	//포함되는 정보의 아이디
						sort       : $(this).find("input[name='sort']").val(),
						meaningKor : $(this).find("input[name='meaningKor']").val(),
						meaningEng : value,
						value      : value,
						delFlag :  $(this).find("select[name='delFlag']").val()
				}

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
				pList.push(attr);
			}
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

		var params =
			{ codeType : "INFO_CLASS",
				pArray : JSON.stringify(pList)};
		var callback = function(result){
			var obj = JSON.parse(result);
			if(obj.result == 'SUCCESS'){
				parent.fnObj.loadCodeList("INFO_CLASS", null);
	  			parent.myModal.close();
			}
		};

		commonAjax("POST", contextRoot+"/business/saveBusinessCodeReg.do", params, callback);

	},
	//취소
	doClose : function(){
		parent.myModal.close();
	}
}

$(function(){
	fnObj.preload();
});

</script>