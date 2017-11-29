<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<form name="viewerFrm" id="viewerFrm" action="" method="post"></form>
<div class="modalWrap2">
	<!-- <form name="myform" id="myform"> -->
		<input type="hidden" id="targetDate" name="targetDate" value="${targetDate}">
		<input type="hidden" id="targetOrgId" name="targetOrgId" value="${targetOrgId }">
		<input type="hidden" id="infoId" name="infoId" value="${infoId}">
		<%-- <h1><strong>[영업관리]</strong>영업정보 <c:if test="${mode == 'new'}">등록</c:if><c:if test="${mode == 'update'}">수정</c:if></h1> --%>
		<h1><strong>[영업정보]</strong></h1>

		<div class="mo_container">
				<!--정보공유(정보입력)-->
				<!--타이틀-->
				<h3 class="h3_title_basic">
					<c:if test="${mode == 'new'}">영업정보 등록  </c:if>
					<c:if test="${mode == 'update'}">영업정보 수정</c:if>
				</h3>
				<p class="title_noti_right">
					( 적용날짜 :
					<c:choose>
					<c:when test="${not empty targetDate }">${targetDate}</c:when>
					<c:otherwise><fmt:formatDate value="${toDay}" pattern="yyyy/MM/dd" /></c:otherwise>
					</c:choose>
					)
				</p>
				<!--//타이틀//-->
				<!--직원,인물,회사-->
				<table class="tb_basic_left" summary="정보공유(정보입력)">
					<caption>정보공유(정보입력)</caption>
					<colgroup>
						<col width="18%">
						<col width="308">
						<col width="160">
						<col width="308">
					</colgroup>
					<tbody>
							<tr>
							<th><label for="SIDNAME01"><span>${staffLabel1}</span></label></th>
							<td <c:if test="${staffUse2 != 'Y' }">colspan="3"</c:if>>
								<a href="#" onclick="fnObj.openStaffPopup(1);return false;" class="btn_select_employee mgl6"><em>직원선택</em></a>
								<div id = "staffName1Area" <c:if test="${fn:length(staff1List)>0 }">class = "mgt10"</c:if>>
									<c:if test="${fn:length(staff1List)>0 }">
										<c:forEach var = "data" items="${staff1List }" varStatus="i">
											<span class="employee_list staff1List" id = 'staff1List_${data.userId }'><span><c:if test="${i.index != 0 }"><div id = 'staff1List_comma' style='display:inline'>,</div></c:if>${data.staffName }</span><em>(${data.staffRankNm })</em><input type="hidden" id = "staff1Id" name = "staff1Id" value="${data.userId }"><a href="javascript:deleteStaff('1','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
										</c:forEach>
									</c:if>
								</div>
							</td>
							<c:if test="${staffUse2 == 'Y' }">
								<th><label for="SIDNAME02"><span>${staffLabel2}</span></label></th>
								<td>
									<a href="#" onclick="fnObj.openStaffPopup(2);return false;" class="btn_select_employee mgl6"><em>직원선택</em></a>
									<div id = "staffName2Area" <c:if test="${fn:length(staff2List)>0 }">class = "mgt10"</c:if>>
										<c:if test="${fn:length(staff2List)>0 }">
											<c:forEach var = "data" items="${staff2List }" varStatus="i">
												<span class="employee_list staff2List" id = 'staff2List_${data.userId }'><span><c:if test="${i.index != 0 }"><div id = 'staff2List_comma' style='display:inline'>,</div></c:if>${data.staffName }</span><em>(${data.staffRankNm })</em><input type="hidden" id = "staff2Id" name = "staff2Id" value="${data.userId }"><a href="javascript:deleteStaff('2','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
											</c:forEach>
										</c:if>
									</div>
								</td>
							</c:if>

						</tr>
						<tr>
							<th><label for="SIDNAME03"><span>${custLabel1}</span><span class="star">*</span></label></th>
							<td <c:if test="${custUse2 != 'Y' }">colspan="3"</c:if>>
								<input type="hidden" class="input_b" id="custId1" name="custId1" value="${inform.custId1}"/>
								<input type="text" class="input_b" id="custName1" name="custName1" value="${inform.custName1}" readonly/>
								<a href="#" onclick="fnObj.openCustPopup(3);return false;" class="s_violet01_btn mgl6"><em class="search">인물</em></a>
							</td>
							<c:if test="${custUse2 == 'Y' }">
								<th><label for="SIDNAME04"><span>${custLabel2}</span></label></th>
								<td>
									<input type="hidden" class="input_b" id="custId2" name="custId2" value="${inform.custId2}"/>
									<input type="text" class="input_b" id="custName2" name="custName2" value="${inform.custName2}" readonly/>
									<a href="#" onclick="fnObj.openCustPopup(4);return false;" class="s_violet01_btn mgl6"><em class="search">인물</em></a>
								</td>
							</c:if>

						</tr>
						<tr>
							<th><label for="SIDNAME05"><span>${cpnLabel1}</span> <span class="star">*</span></label></th>
							<td <c:if test="${cpnUse2 != 'Y' }">colspan="3"</c:if>>
								<input type="hidden" class="input_b" id="cpnId1" name="cpnId1"  value="${inform.cpnId1}"/>
								<input type="text" class="input_b"  id="cpnName1" name="cpnName1"  value="${inform.cpnName1}" readonly/>
								<a href="#" onclick="fnObj.openCompanyPopup('COMPANY',5);return false;" class="s_violet01_btn mgl6"><em class="search">회사</em></a></td>
							<c:if test="${cpnUse2 == 'Y' }">
							<th><label for="SIDNAME06"><span>${cpnLabel2}</span> </label></th>
							<td>
								<input type="hidden" class="input_b" id="cpnId2" name="cpnId2"  value="${inform.cpnId2}" />
								<input type="text" class="input_b"  id="cpnName2" name="cpnName2"  value="${inform.cpnName2}" readonly/>
								<a href="#" onclick="fnObj.openCompanyPopup('COMPANY',6);return false;" class="s_violet01_btn mgl6"><em class="search">회사</em></a></td>
							</tr>
							</c:if>

					</tbody>
				</table>
				<!--//직원,인물,회사//-->
				<!--코드, 진행상태, 금액, 일자, 제목, 내용, 파일첨부-->
				<table class="tb_basic_left top_noline" summary="정보공유(정보입력)">
					<caption>정보공유(정보입력)</caption>
					<colgroup>
						<col width="18%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">${pathLabel }<span class="star">*</span></th>
							<td colspan="5">
								<span class="radio_list2">
									<c:forEach items ="${pathCodeList}" var="item">
										<c:if test="${item.deleteFlag == 'N' }">
											<label><input type="radio" name="infoPath" ${inform.infoPath == item.value ? "checked" : "" } value="${item.value}"><span>${item.meaningKor}</span></label>
										</c:if>
									</c:forEach>
								</span>
							</td>
						</tr>
						<c:if test="${typeUse == 'Y' }">
						<tr>
							<th scope="row">${typeLabel}</th>
							<td colspan="5">
								<span class="radio_list2">
									<c:forEach items ="${typeCodeList}" var="item" varStatus="i">
										<c:if test="${item.deleteFlag == 'N' }">
											<label><input type="radio" name="infoType" ${inform.infoType == item.value ? "checked" : "" }  onclick="fnObj.checkClassType('${item.sonSetId}');" value="${item.value}"><span>${item.meaningKor}</span></label>
										</c:if>
									</c:forEach>
								</span>
							</td>
						</tr>
						</c:if>
						<c:if test="${classUse == 'Y' }">
						<tr>
							<th scope="row">${classLabel}</th>
							<td colspan="5">
								<span class="radio_list2" id="class_list">
									<c:forEach items ="${classCodeList[0].codeList}" var="item">
										<c:if test="${item.deleteFlag == 'N' &&  mode == 'update' }">
											<label><input type="radio" name="infoClass" value="${item.value}" ${inform.infoClass == item.value ? "checked" : "" }><span>${item.meaningKor}</span></label>
										</c:if>
									</c:forEach>
								</span>
							</td>
						</tr>
						</c:if>
						<tr>
							<th><label for="IDNAME01">${priceLabel1}</label></th>
							<td><input type="text" class="input_mrb" id="infoPrice1" onKeyup="javascript:fnObj.checkValuePrice('infoPrice1');"  name="infoPrice1" value='${inform.infoPrice1}'/> ${priceUnit1}</td>
							<c:if test="${priceUse2 == 'Y' }">
								<th><label for="IDNAME02">${priceLabel2}</label></th>
								<td><input type="text" class="input_mrb" id="infoPrice2" onKeyup="javascript:fnObj.checkValuePrice('infoPrice2');" name="infoPrice2" value="${inform.infoPrice2}"/> ${priceUnit2}</td>
							</c:if>
							<c:if test="${priceUse2 == 'N' }">
								<td colspan="2" style="border-left:0px;"></td>
							</c:if>
							<c:if test="${priceUse3 == 'Y' }">
								<th><label for="IDNAME03">${priceLabel3}</label></th>
								<td><input type="text" class="input_mrb" id="infoPrice3" name="infoPrice3" onKeyup="javascript:fnObj.checkValuePrice('infoPrice3');" value="${inform.infoPrice3}"/> ${priceUnit3}</td>
							</c:if>
							<c:if test="${priceUse3 == 'N' }">
								<td colspan="2" style="border-left:0px;"></td>
							</c:if>
						</tr>
						<tr>
							<th><label for="IDNAME05">${dateLabel1}</label></th>
							<td><input type="text"  class="input_b3" id="infoDate1" name="infoDate1" readonly onclick="$(this).val('');" value="${inform.infoDate1}"/>
								<a href="#" onclick="$('#infoDate1').datepicker('show');return false;" class="icon_calendar"><em>날짜선택</em></a></td>
							<c:if test="${dateUse2 == 'Y' }">
								<th><label for="IDNAME06">${dateLabel2}</label></th>
								<td><input type="text" class="input_b3" id="infoDate2" name="infoDate2" readonly onclick="$(this).val('');" value="${inform.infoDate2}"/>
								<a href="#" onclick="$('#infoDate2').datepicker('show');return false;" class="icon_calendar"><em>날짜선택</em></a></td>
							</c:if>
							<c:if test="${dateUse2 == 'N' }">
								<td colspan="2" style="border-left:0px;"></td>
							</c:if>
							<c:if test="${dateUse3 == 'Y' }">
								<th><label for="IDNAME07">${dateLabel3}</label></th>
								<td><input type="text" class="input_b3" id="infoDate3" value="${inform.infoDate3}" onclick="$(this).val('');" readonly name="infoDate3" />
								<a href="#" onclick="$('#infoDate3').datepicker('show');return false;" class="icon_calendar"><em>날짜선택</em></a></td>
							</c:if>
							<c:if test="${dateUse3 == 'N' }">
								<td colspan="2" style="border-left:0px;"></td>
							</c:if>
						</tr>

						<tr class="div_bline">
							<th scope="row"><label for="idName01">제목<span class="star">*</span></label></th>
							<td colspan="5"><input type="text" id="title" placeholder="제목을 입력해주세요." class="w100" name="title" value="${inform.title}"></td>
						</tr>

						<tr>
							<th scope="row"><label for="idName02">내용</label></th>
							<td colspan="5"><textarea name="memo" cols="" rows="" id="memo" placeholder="내용을 입력해주세요" class="txtarea_b2 w100" ><c:out value="${inform.memo}"/></textarea></td>
						</tr>

						<tr>
							<form name="fileForm" id="fileForm" method="post">
							<th>파일첨부</th>
							<td colspan="5" class="pdd00">
								<div class="addFileList">
									<p class="titleZone">
										<span class="title">

											<span id="fileInputArea" class="file_btn_bg"><input name="upFile" type="file" multiple onchange="fnObj.newFileUpload();" class="file_btn_cover"></span>

										</span>

										<span class="size"><strong>파일<span>0MB</span></strong> / <em>100MB</em></span>
									</p>
									<!-- <ul id="file_list"></ul> -->

									<!--파일없을땐 지워주세요-->
				                    <ul id="uploadFileList" class="fileList" style="display:none;"></ul>
				                    <!--//파일없을땐 지워주세요//-->
								</div>
							</td>
							</form>
						</tr>

						<tr>
							<th scope="row">${progressLabel}<span class="star">*</span></th>
							<td colspan="5">
								<span class="radio_list2">
									<c:forEach items="${progressCodeList}" var="item" varStatus="i">
										<label><input type="radio" name="progress" ${inform.progress == item.value || i.index == 0  ? "checked" :"" } value="${item.value}"><span>${item.meaningKor}</span></label>
									</c:forEach>
								</span>
							</td>
						</tr>
						<tr>
			                <th scope="row">정보 보안등급</th>
			                <td colspan="5">
			                	<span class="radio_list2"  id = "boardInfoLvTag"></span>
			                	<script type="text/javascript">
			                	var checkedVal = "${inform.infoLevel}" == ""?"C":"${inform.infoLevel}";

			                	var comBoardInfoLv = getBaseCommonCode('BUSINESS_INFO_LEVEL', null, 'CD', 'NM', null,'','', { orgId : "${baseUserLoginInfo.applyOrgId}" });
			                	var comBoardInfoLvTag = createRadioTag('infoLevel', comBoardInfoLv, 'CD', 'NM', checkedVal, 10, 3);	//radio tag creator 함수 호출 (common.js)
			            		$("#boardInfoLvTag").html(comBoardInfoLvTag);
			                	</script>
			                </td>
			            </tr>
					</tbody>
				</table>
				<!--//코드, 진행상태, 금액, 일자, 제목, 내용, 파일첨부//-->
				<div class="btnZoneBox">
					<a href="#" onclick="fnObj.doSave();return false;" class="p_blueblack_btn"><strong>저장</strong></a>
					<a href="#" onclick="fnObj.doClose();return false;" class="p_withelin_btn">취소</a>
				</div>
			<!--//정보공유(정보입력)//-->
		</div>
	<!-- </form> -->
</div>



<script>
var mode =  "${mode}";
var line = 1; //첨부파일 div 순번
var allFileSize = 0;
var	prevVal = "";
var type = 0; //팝업 순번
var myModal = new AXModal();	// instance
var preserveFile = [];  // 최종 전달된 파일 배열
var deleteFileIds = []; // 삭제될 파일


var g_idx =0;						//파일 idx
var delArray = new Array();
var saveFileList ;



var fnObj = {
	preload : function(){
		//날짜 세팅
		fnObj.setCalendar("infoDate1","0","N");
		fnObj.setCalendar("infoDate2","0","N");
		fnObj.setCalendar("infoDate3","0","N");

		myModal.setConfig({
    		windowID:"myModalCT",
    		width:800,
            mediaQuery: {
                mx:{min:0, max:720}, dx:{min:720}
            },
    		displayLoading:true,
            scrollLock: true,
    		onclose: function(){
    		}
            ,contentDivClass: "popup_outline"
    	});


		<c:forEach items="${typeCodeList}" var="item">
			var value = "${item.value}";
			var infoType = "${inform.infoType}";
			if(value == infoType){
				var showYn = "${item.deleteFlag}";
				if(showYn == "Y"){
					$("#class_list").html("");
				}
			}
		</c:forEach>
	},
	//페이지 세팅(업로드된 파일 처리)
	pageSetting : function(){
		if(mode == "update"){

			fnObj.getFileList();

			/*
			var param = { infoId : $("#infoId").val() };
			var callback = function(result){
				var obj = JSON.parse(result);

				var list = obj.resultList;
				var html = "";
				for(var i =0 ; i < list.length ; i++){
					var item = list[i];
					var fSize = item.fileSize;
			    	var fileSize = checkFileSize(fSize);
			    	allFileSize += fSize;
					html += '<li id="file'+line+'">';
					html += '<a href="#">'+item.orgFileNm+'</a><span class="num_st">';
					html += fileSize +'</span><a href="#" onclick="fnObj.deleteExistfile('+line+','+ item.fileSeq+ ','+ item.fileSize+ ');return false;" class="delete_btn"><em>삭제</em></a></li>';
					line++;
				}
				$("#file_list").append(html);

				if(list.length==0){	//파일이 존재하지 않으면 파일공간(ul)도 안보이도록
					$("#file_list").hide();
				}

				var viewCheckSize = checkFileSize(allFileSize);
				$(".size").html("<strong>"+viewCheckSize +"</strong>/<em>5MB</em>");

			};
			commonAjax("POST", contextRoot+"/business/getBusinessInfoFileList.do", param, callback)
 */

		}else{	//mode == "new"
			//$("#file_list").hide();
			$("#uploadFileList").hide();
		}
	},


	//첨부파일 리스트
    getFileList : function(){
    	var url = contextRoot + "/file/getFileList.do";
    	var param = {
    					uploadId 	: $("#infoId").val(),	//g_contentId,
    					uploadType  : 'INFO_FILE'
    				};

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var list = obj.resultList;
    		var str = '';
    		saveFileList = list;
    		if(list.length>0){
	    		for(var i=0;i<list.length;i++){

	    			var fileObj = list[i];
	    			str +='<li id="li_'+g_idx+'">' + fileObj.orgFileNm ;
	    			str +='<input type="hidden" name="fileSeq" value="'+fileObj.fileSeq+'">' ;
	    			str +='<input type="hidden" name="orgFileNm" value="'+fileObj.orgFileNm+'">' ;
	    			str +='<input type="hidden" name="newFileNm" value="'+fileObj.newFileNm+'">' ;
	    			str +='<input type="hidden" name="filePath" value="'+fileObj.filePath+'">' ;
	    			str +='<input type="hidden" name="fileSize" value="'+fileObj.fileSize+'">' ;
	    			str +='&nbsp; <span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.setDelFile('+fileObj.fileSeq+','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
	    			g_idx++;
				}
	    		$('#uploadFileList').html(str);

	    		$('#uploadFileList').show();

	    		var viewCheckSize = checkFileSize();
	   			$(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");

    		}

    	};
    	commonAjax("POST", url, param, callback, false);
    },


	//날짜 세팅.
	setCalendar : function(target, addDate, setToday){

		$("#"+target).datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			yearRange: 'c-1:c+9'
			//maxDate: '30d'
		});

		var newDate = new Date(Date.now() + addDate * 24*60*60*1000);
		if(setToday == 'Y'){
			$("#"+target).datepicker('setDate', newDate);
		}
	},
	//구분 선택에 따른 유형 변경
	checkClassType : function(sonSetId){
		var callback = function(result){
			var obj = JSON.parse(result);
    		var list = obj.resultList;

    		var html = "";
    		for(var i =0 ;i < list.length ;i++){
    			var item = list[i];
    			if(item.deleteFlag == 'N'){
    				html += '<label> <input type="radio" name="infoClass" value="'+ item.value +'"/><span>'+item.meaningKor+'</span></label> ';
    			}
    		}
    		$("#class_list").html(html);

		}
		var param = { codeSetId : sonSetId};
		commonAjax("POST", contextRoot+"/business/seleteBusinessCodeReg.do", param, callback);
	},
	//실제 input type="file" 클릭
	triggerfile : function(){
		$("#shadowFile").trigger("click");
	},

	/* upLoadFile : function(){
		var files = $("#shadowFile")[0].files;
		var showAlert = false;

		var html = "";
		for(var i = 0 ;i < files.length ;i++){
			var file = files[i];
			var fileName = file.name;
			var regexp = new RegExp("^[a-zA-Zㄱ-ㅎ가-힣0-9\.\-\_\\[\\]\\(\\)]*$");
			var checkYn = regexp.test(fileName);
			if(!checkYn){
				alertM("["+fileName +"]은 파일명 형식(특수문자는 _,-,(,),. 만 가능)에 맞지 않습니다.");
				return;
			}

			//기존 파일과 같은지 비교.
			var addYn = true;
			for(var j = 0 ; j < preserveFile.length ;j++){
				var compareFile = preserveFile[j];
				//console.log(file.name +","+ compareFile.name);
				if(file.name == compareFile.name){
					addYn = false;
					showAlert=true;
				}
			}

			$("#file_list li").each(function(){
				var existFileName = $(this).find("a").html();
				//console.log(existFileName);
				if(fileName == existFileName){
					addYn = false;
					showAlert=true;
				}
			});


			//기존 파일과 중복이 아닌경우 저장
			if(addYn){
				//파일 사이즈 구하기.
		    	var fSize = file.size;
		    	var fileSize = checkFileSize(fSize);
		    	allFileSize += fSize;

		    	if(allFileSize/(1024*1024) > 5){
		    		alertM("전체 최대용량 5MB 까지 첨부 가능합니다.");
		    		allFileSize = allFileSize - fSize;
		    		return;
		    	}

		    	preserveFile.push(file);
		    	//console.log(preserveFile);
				html += '<li id="file'+line+'"><a href="#">'+file.name+'</a><span class="num_st">';
				html += fileSize +'</span><a href="#" onclick="fnObj.deletefile('+line+',\''+file.name+'\');return false;" class="delete_btn"><em>삭제</em></a></li>';
				line++;
			}
		}

		if(showAlert){
			alertM("기존 첨부한 파일과 이름이 같은 파일은 첨부되지 않습니다.");
		}

		$("#file_list").append(html);

		//파일존재여부에 따라 공간(ul) 안보이도록
		if($("#file_list").html().length == 0){
			$("#file_list").hide();
		}else{
			$("#file_list").show();
		}

		var viewCheckSize = checkFileSize(allFileSize);
		$(".size").html("<strong>"+viewCheckSize +"</strong>/<em>5MB</em>");

	}, */

	//파일 삭제
	deletefile : function(line, fileName){
		$("#file"+line).remove();

		var removeIndex = 0;
		var fileSize = 0;
		preserveFile.map(function(value, index){
			if(value.name == fileName){
				//이름이 같으면 삭제.
				removeIndex = index;
				fileSize = value.size;
			}
		});


		$("#shadowFile").val("");

		preserveFile.splice(removeIndex,1);
		//console.log(preserveFile);
		//var fileSizes = allFileSize - fileSize;
		//allFileSize = fileSizes;

		var viewCheckSize = checkFileSize(fileSizes);
		$(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");


		//파일존재여부에 따라 공간(ul) 안보이도록
		if($("#file_list").html().length == 0){
			$("#file_list").hide();
		}

	},
	//기존 파일 삭제처리
	deleteExistfile : function(index, fileId, fileSize){
		$("#file"+index).remove();

		//삭제처리할 아이디 저장
		deleteFileIds.push(fileId);

		var fileSizes = allFileSize - fileSize;
		allFileSize = fileSizes;
		var viewCheckSize = checkFileSize(fileSizes);
		$(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");


		//파일존재여부에 따라 공간(ul) 안보이도록
		if($("#file_list").html().length == 0){
			$("#file_list").hide();
		}
	},
	//직원 검색
	openStaffPopup : function(num){ //직원 팝업

		var userStr ='';
		var paramList = [];
		if(num ==1 ) {

			$("input[name='staff1Id']").each(function(i){
				if(i!=0) userStr += ",";

				userStr+= $(this).val();
			});

		}
		if(num ==2 ) {
			$("input[name='staff2Id']").each(function(i){
				if(i!=0) userStr += ",";

				userStr+= $(this).val();
			});
		}

		var paramList = [];
        var paramObj ={ name : 'userList'   ,value : userStr};
        paramList.push(paramObj);

        /* paramObj ={ name : 'isOneUser' ,value : 'Y'};
        paramList.push(paramObj); */

        paramObj ={ name : 'isUserGroup' ,value : 'Y'};
        paramList.push(paramObj);
        paramObj ={ name : 'isAllOrgSelect' ,value : 'Y'};
        paramList.push(paramObj);

        userSelectPopCall(paramList);		//공통 선택 팝업 호출


        type = num;

	},
	//인물 검색
	openCustPopup : function(num){ //
		type = num;
		 var option = "width=650px,height=720px,resizable=yes,scrollbars = yes";
	     commonPopupOpen("searchCpnPop",contextRoot+"/person/customerListPopup.do",option,$("#viewerFrm"));
	},
	//회사 검색
	openCompanyPopup : function(companyPopType, num){
		type = num;
		 $("#companyPopType").val(companyPopType);
	     var option = "width=650px,height=720px,resizable=yes,scrollbars = yes";
	     commonPopupOpen("searchCpnPop",contextRoot+"/company/popUpCpn.do",option,$("#viewerFrm"));
	},
	//저장
	doSave : function(){

		var fileList ='';
    	var delFileList='';

    	/*=========== 첨부파일 : S =========== */
    	var fileSeqList 	= $("input[name=fileSeq]");			//시퀀스 리스트
    	var orgFileNmList 	= $("input[name=orgFileNm]");		//파일명 리스트
    	var newFileNmList 	= $("input[name=newFileNm]");		//새로운 저장 파일명 리스트
    	var filePathList 	= $("input[name=filePath]");		//경로 리스트
    	var fileSizeList 	= $("input[name=fileSize]");		//파일 크기 리스트
    	var jArray = new Array();

    	var fileAllSize = 0;
    	$("input[name=fileSize]").each(function(index, value){
    		fileAllSize += parseInt($(this).val());
    	});		//기존 파일 크기 리스트


    	for(var i=0;i<fileSeqList.length;i++){

    		var fileSeq		 = fileSeqList[i].value;
    		var orgFileNm 	 = orgFileNmList[i].value;
    		var newFileNm  	 = newFileNmList[i].value;
    		var filePath 	 = filePathList[i].value;
    		var fileSize 	 = fileSizeList[i].value;

    		if(fileSeq == 0){								//신규 등록건만 추가
	    		var jobj = new Object();
				jobj.fileSeq=fileSeq;
				jobj.orgFileNm=orgFileNm;
				jobj.newFileNm=newFileNm;
				jobj.filePath=filePath;
				jobj.fileSize=fileSize;
				jobj.uploadType='INFO_FILE';
				jArray.push(jobj);
    		}
    	}

    	var totalObj = new Object();
		totalObj.items=jArray;											//items 란 키값으로 totalObj에 jobj를 담은 jArray를 세팅
		fileList = JSON.stringify(totalObj);							//totalObj 를 string 변환

		if(jArray.length ==0) fileList = '';							//파일이 없을때는 빈값

		if(delArray.length !=0){										//수정시 삭제한 파일들의 리스트

			delFileList = delArray.join(",");
		}

    	if(fileAllSize/(1024*1024) >100){
    		alertM("전체 최대용량 100MB 까지 첨부 가능합니다.");
    		return false;
    	}

    	/*=========== 첨부파일 : E =========== */


		/*========== :S ==========*/

    	//인물1 체크
		if($('#custName1').val() == '' || $('#custId1').val() == ''){
			alertM("${custLabel1}을 선택해주세요.");
			return;
		}

		//회사1 체크
		if($('#cpnName1').val() == '' || $('#cpnId1').val() == ''){
			alertM("${cpnLabel1}을 선택해주세요.");
			return;
		}

		//경로 체크
		if( $("input:radio[name='infoPath']:checked").val() == ''  ||  $("input:radio[name='infoPath']:checked").val() == undefined){
			alertM("${pathLabel}을 선택해주세요.");
			return;
		}

		//제목 체크
		if($('#title').val() == ''){
			alertM("제목을 입력해주세요.");
			return;
		}

		//진행사항 체크
		if($("input:radio[name='progress']:checked").val() == '' ||  $("input:radio[name='progress']:checked").val() == undefined || $("input:radio[name='progress']:checked").val() == 'undefined'){
			alertM("${progressLabel}을 선택해주세요.");
			return;
		}

		var numRegexp = new RegExp("^[0-9\,\.]*$");
		if($("input[name='infoPrice1']").val() != undefined && !numRegexp.test($("input[name='infoPrice1']").val())){
			alert("가격은 숫자만 가능합니다.");
			return;
		}
		if($("input[name='infoPrice2']").val() != undefined && !numRegexp.test($("input[name='infoPrice2']").val())){
			alert("가격은 숫자만 가능합니다.");
			return;
		}
		if($("input[name='infoPrice3']").val() != undefined && !numRegexp.test($("input[name='infoPrice3']").val())){
			alert("가격은 숫자만 가능합니다.");
			return;
		}

		/*========== :E ==========*/






		/* if(allFileSize/(1024*1024) > 5){
			alertM("전체 최대용량 5MB 까지 첨부 가능합니다.");
    		return false;
    	} */
/*
		var frm = document.myform;

		//인물1 체크
		if(frm.custName1.value == '' || frm.custId1.value == ''){
			alertM("${custLabel1}을 선택해주세요.");
			return;
		}

		//회사1 체크
		if(frm.cpnName1.value == '' || frm.cpnId1.value == ''){
			alertM("${cpnLabel1}을 선택해주세요.");
			return;
		}

		//경로 체크
		if( $("input:radio[name='infoPath']:checked").val() == ''  ||  $("input:radio[name='infoPath']:checked").val() == undefined){
			alertM("${pathLabel}을 선택해주세요.");
			return;
		}

		//제목 체크
		if(frm.title.value == ''){
			alertM("제목을 입력해주세요.");
			return;
		}

		//진행사항 체크
		if($("input:radio[name='progress']:checked").val() == '' ||  $("input:radio[name='progress']:checked").val() == undefined || $("input:radio[name='progress']:checked").val() == 'undefined'){
			alertM("${progressLabel}을 선택해주세요.");
			return;
		}

		var numRegexp = new RegExp("^[0-9\,\.]*$");
		if($("input[name='infoPrice1']").val() != undefined && !numRegexp.test($("input[name='infoPrice1']").val())){
			alert("가격은 숫자만 가능합니다.");
			return;
		}
		if($("input[name='infoPrice2']").val() != undefined && !numRegexp.test($("input[name='infoPrice2']").val())){
			alert("가격은 숫자만 가능합니다.");
			return;
		}
		if($("input[name='infoPrice3']").val() != undefined && !numRegexp.test($("input[name='infoPrice3']").val())){
			alert("가격은 숫자만 가능합니다.");
			return;
		}
 */
		var callback = function(result){
			var obj = JSON.parse(result);
			if(obj.result == 'SUCCESS'){
				dialog.push({body:'<b>확인</b> 저장되었습니다.', type:'', onConfirm: function(){
					opener.location.reload();
					window.close();
				}});

			}else{
				alertM("저장도중 오류가 발생하였습니다.");
				return;
			}
		};

		var staff1IdArr = [];

		$("input[name = 'staff1Id']").each(function(){
			staff1IdArr.push($(this).val());
		});

		var staff2IdArr = [];

		$("input[name = 'staff2Id']").each(function(){
			staff2IdArr.push($(this).val());
		});

		var staff1IdStr = staff1IdArr.join(",");
		var staff2IdStr = staff2IdArr.join(",");

		var url = contextRoot+"/business/savebusinessInfoRegist.do";
		var param = {
				 mode : mode
				,infoId : $('#infoId').val()
				,staff1IdStr : staff1IdStr
				,staff2IdStr : staff2IdStr
				,custId1 : $('#custId1').val()
				,custName1: $('#custName1').val()
				,custId2  : ( $("input[name='custId2']").val() == undefined || $("input[name='custId2']").val() == '') ? 0 :  $("input[name='custId2']").val()
				,custName2:  ( $("input[name='custName2']").val() == undefined) ? '' :  $("input[name='custName2']").val()
				,cpnId1: $('#cpnId1').val()
				,cpnName1 : $('#cpnName1').val()
				,cpnId2:  ( $("input[name='cpnId2']").val() == undefined ) ? '' :  $("input[name='cpnId2']").val()
				,cpnName2 : ( $("input[name='cpnName2']").val() == undefined) ? '' :  $("input[name='cpnName2']").val()
				,infoPath:   $("input:radio[name='infoPath']:checked").val()
				,infoType:  ( $("input:radio[name='infoType']:checked").val() == undefined) ? '' : $("input:radio[name='infoType']:checked").val()
				,infoClass: ( $("input:radio[name='infoClass']:checked").val() == undefined) ? '' : $("input:radio[name='infoClass']:checked").val()
				,infoPrice1: ( $("input[name='infoPrice1']").val() == undefined || $("input[name='infoPrice1']").val() == '') ? 0 : ($("input[name='infoPrice1']").val()).replace(/[,]/gi, '')
				,infoPrice2: ( $("input[name='infoPrice2']").val() == undefined || $("input[name='infoPrice2']").val() == '') ? 0 : ($("input[name='infoPrice2']").val()).replace(/[,]/gi, '')
				,infoPrice3: ( $("input[name='infoPrice3']").val() == undefined || $("input[name='infoPrice3']").val() == '') ? 0 : ($("input[name='infoPrice3']").val()).replace(/[,]/gi, '')
				,infoDate1: ( $("input[name='infoDate1']").val() == undefined || $("input[name='infoDate1']").val() == '') ? 0 : $("input[name='infoDate1']").val()
				,infoDate2: ( $("input[name='infoDate2']").val() == undefined || $("input[name='infoDate2']").val() == '') ? 0 : $("input[name='infoDate2']").val()
				,infoDate3: ( $("input[name='infoDate3']").val() == undefined || $("input[name='infoDate3']").val() == '') ? 0 :  $("input[name='infoDate3']").val()
				,title : $('#title').val()
				,memo: $('#memo').val()
				,progress: $("input:radio[name='progress']:checked").val()
				,targetOrgId : $("#targetOrgId").val()
				,targetDate : $("#targetDate").val()
				,infoLevel : $("input[name='infoLevel']:checked").val()

				,fileList		:   fileList				//신규 파일 리스트
    			,delFileList	:   delFileList				//수정시 삭제한 파일들의 시퀀스 리스트
		};

		if(mode == "update"){
			param.deleteFileIds = deleteFileIds;
			url = contextRoot+"/business/updatebusinessInfoRegist.do";
		}

		commonAjax("POST", url, param, callback);

	},
	//직원 선택 시 콜백
    getResult: function(listObj, pKey){

    	$("#staffName"+type+"Area").empty();
		for(var i = 0 ; i <listObj.length; i++){
			$("#staffName"+type+"Area").addClass("mgt10");

			var stStr = "";
			stStr += "<span class=\"employee_list staff"+type+"List\" id = 'staff"+type+"List_"+listObj[i].userId+"'>";
			if($("#staffName"+type+"Area .staff"+type+"List").length>0) stStr+="<span><div id = 'staff"+type+"List_comma' style='display:inline'>,</div>";
			else  stStr+="<span>";
			stStr += listObj[i].userName+"</span><em>("+listObj[i].rankNm+")</em>";
			stStr += "<input type=\"hidden\" id = \"staff"+type+"Id\" name = \"staff"+type+"Id\" value=\""+listObj[i].userId+"\">";
			stStr += "<a href=\"javascript:deleteStaff('"+type+"','"+listObj[i].userId+"')\" class=\"btn_delete_employee\"><em>삭제</em></a></span>";
			$("#staffName"+type+"Area").append(stStr);
		}
    },
    //제목 만들기
    setTitle : function(){
    	var title  = "";
    	//구분 + 회사1 + 유형
    	var type = $("input:radio[name='infoType']:checked").next().text();
    	var company = $("#cpnName1").val();
    	var classInfo = $("input:radio[name='infoClass']:checked").next().text();

    	var title = type +" "+ company +" "+ classInfo;
    	$("#title").val(title);

    },
	//창 닫기
	doClose : function(){
		window.close();
	},
	checkValuePrice : function(id){
		var numRegexp = new RegExp("^[0-9\,\.]*$");
		var value = $("#"+id).val();
		if(!numRegexp.test(value)){
			value = value.replace(/[^0-9\,\.]/gi,"");
			$("#"+id).val(value);
		}

	    var tmps = value.replace(/[^0-9\.]/g, '');

	    //소수점 두번째까지 가능.
	    var regexp = /^\d*(\.\d{0,2})?$/;
	    if(tmps.search(regexp) ==  -1){
	    	tmps = prevVal;
	    }else{
	    	prevVal = tmps;
	    }

        var tmps2 = tmps.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
        $("#"+id).val(tmps2);

	},


	//신규 파일 등록시
  	newFileUpload : function(){
		var url = contextRoot+"/file/uploadFiles.do"


   		var callback = function(result){

			var list = result.resultList;
   			var str='';
   			for(var i=0;i<list.length;i++){
   				var fileObj = list[i];
   				str +='<li id="li_'+g_idx+'">' + fileObj.orgFileNm ;
   				str +='<input type="hidden" name="fileSeq" value="0">' ;
   				str +='<input type="hidden" name="orgFileNm" value="'+fileObj.orgFileNm+'">' ;
   				str +='<input type="hidden" name="newFileNm" value="'+fileObj.newFileNm+'">' ;
   				str +='<input type="hidden" name="filePath" value="'+fileObj.filePath+'">' ;
   				str +='<input type="hidden" name="fileSize" value="'+fileObj.fileSize+'">' ;
   				str +='&nbsp; <span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
   				g_idx++;


   			}

   			//파일 태그 재 생성.
   			$('#fileInputArea').append('<input name="upFile" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload();">');
   			$('#uploadFileList').append(str);
   			$('#uploadFileList').show();


   			var viewCheckSize = checkFileSize();

   			$(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");

   		}

   		commonAjaxForFileCreateForm(url,"","upFile","100","fileSize", callback , "");

  	},


  /* 	//파일 업로드 후
  	setFileUploadInfo : function(res){

  		var fileSize = 0;
    	$("input[name=fileSize]").each(function(index, value){
    		fileSize += parseInt($(this).val());
    	});

    	if(fileSize/(1024*1024) >5){
			alertM("전체 최대용량 5MB 까지 첨부 가능합니다.");
			return false;
		}

    	var obj = JSON.parse(res);
		var list = obj.resultList;
		var str='';
		for(var i=0;i<list.length;i++){
			var fileObj = list[i];
			str +='<li id="li_'+g_idx+'">' + fileObj.orgFileNm ;
			str +='<input type="hidden" name="fileSeq" value="0">' ;
			str +='<input type="hidden" name="orgFileNm" value="'+fileObj.orgFileNm+'">' ;
			str +='<input type="hidden" name="newFileNm" value="'+fileObj.newFileNm+'">' ;
			str +='<input type="hidden" name="filePath" value="'+fileObj.filePath+'">' ;
			str +='<input type="hidden" name="fileSize" value="'+fileObj.fileSize+'">' ;
			str +='&nbsp; <span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
			g_idx++;

			fileSize += parseInt(fileObj.fileSize);
		}

		if(fileSize/(1024*1024) >5){
			alertM("전체 최대용량 5MB 까지 첨부 가능합니다.");
			return false;
		}else{
			$('#uploadFileList').append(str);
			$('#uploadFileList').show();
		}

  	}, */


  	//파일 바로 삭제
    newFileDelete : function(newFileNm,filePath,idx){
    	var url = contextRoot + "/file/deleteFile.do";
    	var param = { newFileNm : newFileNm , filePath : filePath};
    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		if(cnt>0){
    			$("#li_"+idx).remove();
    			if($('#uploadFileList').children().length == 0) $('#uploadFileList').hide();	//ul 숨기기
    			var viewCheckSize = checkFileSize();
    			$(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");
    		}
    	};
    	commonAjax("POST", url, param, callback, false);
    },


  	//수정시 db 에 이미 저장된 파일삭제 할땐. 바로삭제하지않고 리스트를 만든다.
    setDelFile: function(fileSeq,idx){

    	delArray.push(fileSeq);
    	$("#li_"+idx).remove();

    	if($('#uploadFileList').children().length == 0) $('#uploadFileList').hide();			//ul 숨기기

    	var viewCheckSize = checkFileSize();
		$(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");

    }//end setDelFile


};//fnObj
function deleteStaff(type,userId){
	$("#staff"+type+"List_"+userId).remove();

	$("span[id*='staff"+type+"List_']").eq(0).find("#staff"+type+"List_comma").remove();
	if($("span[id*='staff"+type+"List_']").length==0){

		$("#staffName"+type+"Area").removeClass("mgt10");
	}

}
//파일 사이즈 체크해서 단위와 함께 표시
function checkFileSize(){
	var fSExt = new Array('Bytes', 'KB', 'MB', 'GB');
	var j=0;
	var fSize = 0;
	$("input[name=fileSize]").each(function(index, value){
		fSize += parseInt($(this).val());
	});




	while(fSize>900){fSize/=1024;j++;}
	var fileSize = (Math.round(fSize*100)/100)+fSExt[j];
	return fileSize;
}

//회사 선택시 콜백
function cpnPopupCallback(cpnId, cpnNm, sNb){
	//console.log(cpnId, cpnNm, sNb);
	if(type == 5){
		$("#cpnId1").val(cpnId);
		$("#cpnName1").val(cpnNm);
	}else if(type ==6 ){
		$("#cpnId2").val(cpnId);
		$("#cpnName2").val(cpnNm);
	}
}

//인물 선택시 콜백
function cstPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position){
	//console.log(sNb,cpnSnb,cstNm,cpnNm,team,position);
	if(type == 3){
		$("#custId1").val(sNb);
		$("#custName1").val(cstNm);
	}else if(type == 4){
		$("#custId2").val(sNb);
		$("#custName2").val(cstNm);
	}
}

$(function(){
	fnObj.preload();
	fnObj.pageSetting();

	if("${mode == 'new'}"=="true"){
		$("input[name='infoType']:checked").trigger("click");
	}




});

</script>