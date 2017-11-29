<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<link rel="stylesheet" href="<c:url value='/daumeditor/css/editor.css'/>" type="text/css" charset="utf-8"/>
<script src="<c:url value='/daumeditor/js/editor_loader.js'/>" type="text/javascript" charset="utf-8"></script>


<section id="detail_contents">

	<div style="margin:20px;">

        <!--공지사항등록-->
        <table class="board_regist_st01" summary="공지사항 입력(공지설정, 제목, 내용, 첨부파일, 공개설정)">
            <caption>공지사항입력</caption>
            <colgroup>
                <col width="120" />
                <col width="*" />
            </colgroup>
            <!-- 공지설정 기능 사용여부 체크 -->
          	<tr class="noticeTr">
                <th scope="row"  class="noticeTr">헤드라인설정</th>
                <td class="itemList noticeTr" >
                    <!-- <label><input type="checkbox" id="inputNotice" name="notice"/><span>공지하기</span></label>  -->

                	 <label><input type="radio" checked="checked" name="noticeYn" value="N" onclick="fnObj.checkNotice(this.value);"/><span>일반 </span></label>
                	 <label><input type="radio" name="noticeYn" value="Y" onclick="fnObj.checkNotice(this.value);"/><span>헤드라인 </span></label>
                	<!-- <label><input type="radio" name="noticeYn" value="ALL" /><span>전체공지 </span></label> -->


                    <div class="noti_period noticeDate" style="display:none;"><span class="title">헤드라인기간</span>
                    	<input type="text" id="noticeStartDate" class="input_date" style="width:75px;" readonly="readonly"/>
						<a href="#" onclick="javascript:fnObj.clickDate('noticeStartDate');return false;" class="icon_calendar" ></a>

	                    <span>~</span>

	                    <input type="text" id="noticeEndDate" class="input_date" style="width:75px;" readonly="readonly"/>
						<a href="#" onclick="javascript:fnObj.clickDate('noticeEndDate');return false;" class="icon_calendar" ></a>



						<label><input type="checkBox" id="allBoard" value="Y" /><span>모든 게시판에 공지</span></label>
						<!-- <label id="allOrgArea"><input type="checkBox" id="allOrg" value="Y" /><span>전사 공지사항</span></label> -->
	                </div>
                </td>
            </tr>
            <tr id="openPeriodArea">
            	<th scope="row" >공개기간</th>
            	<td class="itemList">
					<div class="noti_period mgl0">
						<input type="text" id="openStartDate" class="input_date" value="2016-04-22" title="시작일선택">
						<a href="javascript:;" onclick="javascript:fnObj.clickDate('openStartDate');return false;" class="icon_calendar" ></a>
						<span>~</span>
						<input type="text" id="openEndDate" class="input_date mgl6" value="2016-04-22" title="종료일선택">
						<a href="javascript:;" onclick="javascript:fnObj.clickDate('openEndDate');return false;" class="icon_calendar" ></a>
						<a href="javascript:;" onclick="javascript:fnObj.clickDate('forever');return false" class="icon_calendar_forever mgl10">&nbsp;</a>
					</div>
				</td>
            </tr>
         	<tr>
                <th scope="row" class="titleRow"><label for="id06">제목</label></th>
                <td class="titleRow"><input type="text" value="" class="input_s_b w100pro" id="inputTitle" name="inputTitle" placeholder="제목을 입력해주세요" /></td>
            </tr>
            <tr>
                <th scope="row"><label for="id07">내용</label></th>
                <td class="conEditor" id="content">
                	<jsp:include page="/daumeditor/editor.jsp" flush="true">
                		<jsp:param value="board" name="type"/>
                	</jsp:include>
                </td>
            </tr>

        	<tr id="fileTr">
            	<%-- <form name="fileForm" id="fileForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/file/uploadFiles.do";> --%>
                <th scope="row">파일첨부</th>
                <td class="r_addFileList">
                <p class="posi_btn">
                	<span id="fileInputArea" class="file_btn_bg"><input name="upFile" type="file" multiple onchange="fnObj.newFileUpload();" class="file_btn_cover"></span>
				</p>

                    <!--파일없을땐 지워주세요-->
                    <ul id="uploadFileList" class="fileList" style="display:none;"></ul>
                    <!--//파일없을땐 지워주세요//-->
                    <p class="file_notice">* 전체 최대용량 100MB 까지 첨부 가능합니다.</p>
                </td>
               <!--   </form> -->
            </tr>
            <c:if test="${cboardId eq 11 }">
            	<tr>
	                <th scope="row">정보등급</th>
	                <td>
	                	<div id = "boardInfoLvTag"></div>
	                	<script type="text/javascript">
	                	var comBoardInfoLv = getBaseCommonCode('BOARD_INFO_LEVEL', null, 'CD', 'NM', null,'','', { orgId : "${baseUserLoginInfo.applyOrgId}" });
	                	var comBoardInfoLvTag = createRadioTag('infoLevel', comBoardInfoLv, 'CD', 'NM', 'C', 10, 3);	//radio tag creator 함수 호출 (common.js)
	            		$("#boardInfoLvTag").html(comBoardInfoLvTag);
	                	</script>
	                </td>
	            </tr>

            </c:if>
			<tr>
				<th scope="row">공개범위</th>
				<td class="pdd00">
					<table class="datagrid_input noline" id="choiceOrgTable" summary="인사정보 부가정보입력 (가족관계)">
						<caption>인사정보 부가정보입력</caption>
						<colgroup>
							<col width="180">
							<col width="*">
							<col width="80">
						</colgroup>
						<tbody>
							<tr class="openAllOrgArea">
								<td colspan="3" class="itemList bg_skyblue">
									<label><input type="radio" checked="checked" name="orgScope" value="Y" onclick="fnObj.orgOpenScope();"><span>전사</span></label>
									<label><input type="radio" name="orgScope" value="N" onclick="fnObj.orgOpenScope();"><span>관계사선택</span></label>
								</td>
							</tr>
							<tr id="openAllOrgYArea">
								<td colspan="3">[전사]</td>
							</tr>

						</tbody>
					</table>
				</td>
			</tr>
        </table>
        <!--//공지사항등록//-->
        <div class="btn_baordZone2">
        	<a href="javascript:;" onclick="javascript:fnObj.doSave('TEMP');" class="btn_blueblack btn_auth" id="tempBtn" style="display:none;"><em>임시저장</em></a>
            <a href="${pageContext.request.contextPath}/board/boardList/${groupUid}/${cboardUid}.do" class="btn_witheline">취소</a>
            <a href="javascript:;" onclick="javascript:fnObj.doSave('REQUEST');" class="btn_blueblack btn_auth"><em id="saveBtn">저장</em></a>

        </div>

	</div>

</section>



<script type="text/javascript">

//Global variables :S ---------------

/**openAllOrg 	-  Y 전사 /N 사내
 * allOrg		-  openAllOrg(Y) 	&& allOrg(Y) 	-  전사
 *				-  					&& allOrg(N) 	-  관계사
 *				-  openAllOrg(N) 면 	무조건 allOrg(N) 	-  사내
 */


var fileSeqArray = new Array();		//업로드된 파일 key list
var isSaved = false; 				//저장을 했는지 여부(저장하며 자동으로 닫힐때 발생하는 이벤트와 저장안하고 닫을때 차별)

var inputTitleBorder;				//제목 border style
var contentBorder;					//내용 border style

var myUpload1 =  new AXUpload5();	//instance

var g_cboardId 	= '${cboardId}';
var g_contentId	= '${contentId}';

var g_groupUid 	= '${groupUid}';
var g_cboardUid	= '${cboardUid}';

var g_idx =0;						//파일 idx
var g_rowIdx = 0;					//orgIdx

var delArray = new Array();
var saveFileList ;
var orgCodeCombo = new Array();
var g_boardInfo = new Object();

//Global variables :E ---------------



var fnObj = {

    pageStart : function(){

    	//달력 세팅
    	fnObj.setDatepicker('noticeStartDate');
    	fnObj.setDatepicker('noticeEndDate');
    	fnObj.setDatepicker('openStartDate');
    	fnObj.setDatepicker('openEndDate');

    	var nowDate = new Date();
    	$("#noticeStartDate").datepicker('setDate', nowDate);
    	$("#noticeEndDate").datepicker('setDate', new Date(nowDate.getFullYear(),nowDate.getMonth(),parseInt(nowDate.getDate())+7));
    	$("#openStartDate").datepicker('setDate', nowDate);
    	$("#openEndDate").datepicker('setDate', new Date(nowDate.getFullYear(),nowDate.getMonth(),parseInt(nowDate.getDate())+7));

    	//if(g_groupUid != 'notice') $("#allOrgArea").hide();	//공지가 아닐때 전사공지 숨기기
    	var params = {};
		orgCodeCombo = getCodeInfo('', 'optionValue', 'optionText', null, null, null, '/common/getOrgCodeCombo.do', params);	//ORG코드(콤보용) 호출


    },	//end function pageStart.

    //게시판 정보
    getBoardCateInfo : function(){
    	var url = contextRoot + "/board/getBoardCateList.do";
    	var param = {cboardId : g_cboardId, applyOrgId : '${baseUserLoginInfo.applyOrgId}'};
    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var list = obj.resultList;
    		for(var i=0;i<list.length;i++){
    			g_boardInfo = list[i];

    			$("#boardTitle").html(list[i].cboardName);
    			$("#groupName").html(list[i].groupName);
    			$("#cboardName").html(list[i].cboardName);
    			$("#searchCount").val(list[i].listCount);
    			g_cboardId=list[i].cboardId;				//게시판 아이디 세팅

    			if(list[i].noticeYn == 'N'){				//게시판 헤드라인 사용여부
    				$(".noticeTr").hide();
    				$(".titleRow").css("border-top","#516279 solid 1px");
    			}
    			if(list[i].fileYn == 'N'){					//게시판 파일첨부 사용여부
    				$(".fileTr").hide();
    			}

    			if(list[i].approveYn == 'Y'){				//저장 버튼 승인버튼으루 && 임시저장 버튼
    				$("#tempBtn").show();
    				$("#saveBtn").html('저장 후 승인요청');
    			}

    			if(list[i].openPeriodYn == 'Y') $("#openPeriodArea").show();	//공개기간 설정여부
    			else  $("#openPeriodArea").hide();

    			if(list[i].openAllYn == 'Y'){
    				$(".openAllOrgArea").show();					//공개여부
    				fnObj.orgOpenScope();
    			}else{
    				$("#orgSelBox_0").attr('disabled',true);		//관계사 셀렉트박스
    				$(".openAllOrgArea").hide();					//공개범위 라디오
    				$("#openAllOrgYArea").hide();					//전사
    			}


    			fnObj.selectTargetOrg('0');

    		}
    	};

		commonAjax("POST", url, param, callback, false);
    },

  	//검색
    doSearch: function(){

    	var url = contextRoot + "/board/getBoardContent.do";
    	var param = {
    					contentId : g_contentId
    				}

    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var infoMap = obj.resultObject;
    		var list = infoMap.boardInfo;						//글정보
    		var openOrgInfoList = infoMap.boardOpenOrgInfo;		//관계사 타깃

    		for(var i=0;i<list.length;i++){
    			// 공지사항
    			if(list[i].noticeFlag == 'Y'){
    				$('input:radio[name=noticeYn]:input[value=Y]').trigger("click");//prop("checked", true);

    			}
    			if(list[i].noticeStartDate > '2000-01-01')  $("#noticeStartDate").val(list[i].noticeStartDate);
    			if(list[i].noticeEndDate >'2000-01-01')  $("#noticeEndDate").val(list[i].noticeEndDate);

    			if(list[i].allOrg == 'Y') $("#allOrg").prop("checked",true);
    			if(list[i].allBoard == 'Y') $("#allBoard").prop("checked",true);



    			if(list[i].openAllYn == 'Y'){						//전사형
    				$(".openAllOrgArea").show();					//전사 관계사선택 라디오 & (+)버튼
    				$("input[name='orgScope'][value='"+list[i].allOrg+"']").prop("checked",true);
    				fnObj.orgOpenScope();
    			}

    			$('#inputTitle').val(list[i].title); // 제목
				$("input[name='infoLevel'][value='"+list[i].infoLevel+"']").prop("checked",true);
    			Editor.modify({						 // 내용
    				"content": list[i].content		 /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
    			});

    			//전사가 아닐때 - 사내형 혹은 관계사선택
				if(list[i].allOrg != 'Y'){

					$(".openAllOrgNArea").remove();
					g_rowIdx = 0;

					if(list[i].openAllYn != 'N'){	//관계사선택
						for(var k=0; k<openOrgInfoList.length; k++){

							fnObj.addTrTargetSelect(openOrgInfoList[k]);

	    				}
					}else{							//사내
						var obj = getRowObjectWithValue(openOrgInfoList, 'orgId', '${baseUserLoginInfo.applyOrgId}');
						console.log(obj)
						fnObj.addTrTargetSelect(obj);
					}

					//사내
					if(list[i].openAllYn == 'N'){
						$(".openAllOrgArea").hide();
						$("#orgSelBox_0").attr('disabled',true);

					}
				}

    		}
    	}
    	commonAjax("POST", url, param, callback, false);
    },//end doSearch

    //첨부파일 리스트
    getFileList : function(){
    	var url = contextRoot + "/file/getFileList.do";
    	var param = {
    					uploadId 	: g_contentId,
    					uploadType  : 'BOARD'
    				}

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
	    			str +='<span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.setDelFile('+fileObj.fileSeq+','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
	    			g_idx++;
				}
	    		$('#uploadFileList').html(str);

	    		$('#uploadFileList').show();

    		}

    	}
    	commonAjax("POST", url, param, callback, false);
    },


  	//저장
    doSave : function(approveStatus){

    	var noticeYn = $("input:radio[name='noticeYn']:checked").val();
    	var noticeStartDate = $("#noticeStartDate").val();
    	var noticeEndDate = $("#noticeEndDate").val();

    	var openStartDate = $("#openStartDate").val();
    	var openEndDate = $("#openEndDate").val();

    	var allBoard = 'N';
    	var allOrg = 'N';

    	var fileList ='';
    	var title = $('#inputTitle').val();
    	var delFileList='';
    	var infoLevel = '';
    	if($("input[name='infoLevel']").length>0) infoLevel = $("input[name='infoLevel']:checked").val();
    	if($("#allBoard").is(":checked")) allBoard = 'Y';

    	if(g_boardInfo.approveYn == 'Y' && approveStatus == 'REQUEST' && g_boardInfo.staffUserId == ''){
    		alert("승인자 설정 후 승인요청 해주세요");
    		return;
    	}


    	if(noticeYn == 'N'){		//헤드라인 설정 안함이면 ..
    		noticeStartDate = '1900-01-01';
    		noticeEndDate = '1900-01-01';
    		allBoard = 'N';


    	}else{						//날짜 유효성
    		if(noticeStartDate>noticeEndDate){
    			alert("날짜를 확인 해주세요.");
    			$('#noticeStartDate').focus();
        		return;
    		}
    	}

    	//공개기간
    	if(g_boardInfo.openPeriodYn == 'Y'){
    		if(openStartDate>openEndDate){
    			alert("날짜를 확인 해주세요.");
    			$('#openStartDate').focus();
        		return;
    		}
    	}else{
    		openStartDate = '1900-01-01';
    		openEndDate = '9999-01-01';
    	}

		//공개범위
		if(g_boardInfo.openAllYn == 'Y'){
			allOrg = $("input:radio[name='orgScope']:checked").val();
		}

    	if(title == ''){
    		alert("제목을 입력해주세요.");
    		$('#inputTitle').focus();
    		return;
    	}
    	if(Editor.getContent() == '<p><br></p>'){
			alert("내용을 적어주세요.");
			return;
		}

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
				jobj.uploadType='BOARD';
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

		var url = contextRoot + "/board/saveBoardContent.do";
    	/*=========== 첨부파일 : E =========== */


    	/*=========== 관계사 설정 : S ==========*/
		var orgList = [];
	    var selectOrgInfoList = new Array();

	    var chk = true;

	    //전사 아닐때
	    if(allOrg != 'Y'){
	    	$('select[id*="orgSelBox_"]').each(function() {
	    		var selectUserList = [];
	    		var roIdx = $(this).attr('ref-val');
				var targetOrg = $('input[name=targetOrg_'+roIdx+']:checked').val();

	    		orgList.push(this.value);

	    		if((targetOrg == 'USER' || targetOrg == 'DEPT') && $('input[name=selectUser'+roIdx+']').length == 0 ){

	    			alert("직원을 선택해주세요.");
	    			$(this).focus();
	    			chk = false;

	    		}else{

		    		$('input[name=selectUser'+roIdx+']').each(function() {
		    			selectUserList.push(this.value);

		    	    });

		    		var infoObj = {targetOrgId : this.value, openTargetOrg : targetOrg  ,targetList : selectUserList.join(',') };

		    		selectOrgInfoList.push(infoObj);
	    		}

	    	});

	    	if(!chk) return;

	    	var sorted_arr = orgList.slice().sort();

	    	for (var i = 0; i < orgList.length - 1; i++) {

	    		if (sorted_arr[i + 1] == sorted_arr[i]) {
	    	        alert("중복되는 관계사가 존재합니다.");
	    	        return;
	    	    }
	    	}

	    }

	    /*=========== 관계사 설정 : E ==========*/

    	var param = {
    			contentId		:	g_contentId,
    			noticeFlag		:	noticeYn,
    			allOrg			:	allOrg,
    			allBoard		:	allBoard,
    			noticeStartDate :	noticeStartDate,
    			noticeEndDate	:	noticeEndDate,
    			openStartDate	:	openStartDate,
    			openEndDate		:	openEndDate,
    			cboardId		: 	g_cboardId,
    			title			: 	$('#inputTitle').val(),
    			content			: 	Editor.getContent(),
    			fileList		:   fileList,					//신규 파일 리스트
    			delFileList		:   delFileList,				//수정시 삭제한 파일들의 시퀀스 리스트
    			infoLevel		:   infoLevel,
    			selectOrgInfoList : selectOrgInfoList.length > 0 ? JSON.stringify(selectOrgInfoList) : '',
    			approveStatus	:	approveStatus,
    			approveYn		: 	g_boardInfo.approveYn
    	}


    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		if(cnt>0){

    			if(g_cboardUid == 'improvement'){
    				alert("개선사항이 접수되었습니다. 담당자가 확인 후 처리합니다.");
    			}else{
    				alert("완료되었습니다.");
    			}

    			location.href = contextRoot + '/board/boardList/'+g_groupUid+'/'+g_cboardUid+'.do';
    		}else{
    			if(cnt == -8){
    				alert("승인자 설정 후 승인요청 해주세요");

    			}else if(cnt == -10){
    				alert("이미 승인요청 되었습니다.");

    			}else alert("등록 실패!!");
    		}


    	};
    	commonAjax("POST", url, param, callback, false);
    },//end doSave


    //수정시 db 에 이미 저장된 파일삭제 할땐. 바로삭제하지않고 리스트를 만든다.
    setDelFile: function(fileSeq,idx){

    	delArray.push(fileSeq);
    	$("#li_"+idx).remove();

    	if($('#uploadFileList').children().length == 0) $('#uploadFileList').hide();			//ul 숨기기

    },//end setDelFile

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
    		}
    	};
    	commonAjax("POST", url, param, callback, false);
    },

	//datepicker 설정
    setDatepicker : function(obj){
		$('#'+obj).datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			yearRange: 'c-7:c+7',
		 	monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		    monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		    dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'], // 요일 텍스트 설정
		    dayNamesShort: ['일','월','화','수','목','금','토'], // 요일 텍스트 축약 설정
		    dayNamesMin: ['일','월','화','수','목','금','토'], // 요일 최소 축약 텍스트 설정
		    showButtonPanel: false,
			isRTL: false,
		    buttonText: ""
		});
    },

    //달력클릭
    clickDate : function(obj){

    	if(obj == 'forever') $("#openEndDate").val('9999-12-31');
    	else{
    		if(obj == 'openEndDate' && $("#openEndDate").val() > '3000-01-01')  $("#openEndDate").val(new Date().yyyy_mm_dd());

    		$('#'+obj).datepicker('show');
    		$("#ui-datepicker-div").zIndex("9999");

    	}
    },

    //헤드라인 버튼 클릭
    checkNotice : function(value){
    	if(value == 'Y'){
    		$(".noticeDate").show();
    	}else{
    		$(".noticeDate").hide();
    		$("#allBoard").prop("checked",false);
    		$("#allOrg").prop("checked",false);
    	}
    },

    //신규 파일 등록시
  	newFileUpload : function(){
   		//$("#fileForm").submit();

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
   				str +='<span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
   				g_idx++;

   			}

   			//파일 태그 재 생성.
   			$('#fileInputArea').append('<input name="upFile" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload();">');


   			$('#uploadFileList').append(str);
   			$('#uploadFileList').show();

   		}

   		commonAjaxForFileCreateForm(url,"","upFile","100","fileSize", callback , "");

   	},

   	//관계사 선택
   	orgOpenScope : function(){
   		var orgScope = $('input[name="orgScope"]:checked').val();

   		if(orgScope == 'Y'){
   			$("#openAllOrgYArea").show();
   			$(".openAllOrgNArea").hide();
   		}else {
   			$("#openAllOrgYArea").hide();
   			$(".openAllOrgNArea").show();
   			$(".openAllOrgNArea").remove();
   			g_rowIdx=0;
   			fnObj.addTrTargetSelect();
   		}
   	},

  	//관계사 선택에 라디오 선택(전체 부서선택 직접선택)
    selectTargetOrg : function(idx){
		var chkValue = $('input[name="targetOrg_'+idx+'"]:checked').val();

		if(chkValue != 'ALL'){

			$('#userBtn_'+idx).show();	//직원선택 버튼
			$('#userList_'+idx).empty();

			//if(chkValue == 'DEPT') fnObj.getUserList(idx);

			if(chkValue == 'DEPT') $("#userBtn_"+idx).attr('class','btn_select_team mgl5');
	  	    else if(chkValue == 'USER') $("#userBtn_"+idx).attr('class','btn_select_employee mgl5');

		}else{
			$('#userBtn_'+idx).hide();
			$('#userList_'+idx).html('[전체]');
		}


    },

    //******** 직원 선택 : S **********//
   	userPop : function(idx){

		var paramList = [];


	    var userList = [];

	    $('input[name=selectUser'+idx+']').each(function() {
		   	userList.push(this.value);

	    });

	    var paramObj ={ name : 'userList'   ,value : userList.join(',')};
		paramList.push(paramObj);

	    var alarmType = '';
		var applyOrgId ='';

  	    var targetOrg = $('input[name="targetOrg_'+idx+'"]:checked').val();

	    paramObj ={ name : 'isOneOrg' ,value : 'Y' };
        paramList.push(paramObj);

        paramObj ={ name : 'oneOrgId' ,value : $('#orgSelBox_'+idx).val() };
        paramList.push(paramObj);

        paramObj ={ name : 'isUserSelectEabled' ,value : (targetOrg == 'DEPT' ? 'N':'Y')};
        paramList.push(paramObj);
        paramObj ={ name : 'isAllOrgSelect' ,value : 'N'};
        paramList.push(paramObj);
        paramObj ={ name : 'isCheckDisable' ,value : (targetOrg == 'DEPT' ? 'Y':'N')};
        paramList.push(paramObj);
        paramObj ={ name : 'parentKey' ,value : idx};
        paramList.push(paramObj);


        userSelectPopCall(paramList);		//공통 선택 팝업 호출

	},

	getResult : function(resultList, parentKey){
		var str ='';
		var beforeDeptSeq ='';

		var target = $('input[name="targetOrg_'+parentKey+'"]:checked').val();

		sortByKey(resultList,'deptSeq','ASC');		//부서 정렬 조건

		for(var i=0;i<resultList.length;i++){
			if(target == 'DEPT'){			//부서선택시

				if(beforeDeptSeq != resultList[i].deptSeq){
					str +='</span>';
					str +='<span id="user_'+resultList[i].deptSeq+'" class="employee_list"><span>'+resultList[i].deptNm+'</span>';
					str +='<a href="javascript:fnObj.deleteUser('+resultList[i].deptSeq+',\''+parentKey+'\');" class="btn_delete_employee"><em>삭제</em></a>, ';
				}
				str +='<input type="hidden" name="selectUser'+parentKey+'" value="'+resultList[i].staffSnb+'">';
				beforeDeptSeq = resultList[i].deptSeq;

			}else{
				str +='<span id="user_'+resultList[i].staffSnb+'" class="employee_list"><span>'+resultList[i].usrNm+'</span><em>('+resultList[i].position+')</em>';
				str +='<a href="javascript:fnObj.deleteUser('+resultList[i].staffSnb+',\''+parentKey+'\');" class="btn_delete_employee"><em>삭제</em></a>';
				if(i<resultList.length-1){
					str +=	',';
				}
				str +='<input type="hidden" name="selectUser'+parentKey+'" value="'+resultList[i].staffSnb+'">';
				str +='</span>';
			}
		}

		$("#userList_"+parentKey).html(str);
	},

	deleteUser : function(userId,idx){
		$('#userList_'+idx).find("#user_"+userId).remove();
	},
	//******** 직원 선택 : E **********//

	//******** tr 추가 삭제 : S ******//
	addTrTargetSelect : function(dataObj){
		var str = '';

		str += '<tr name="row_'+g_rowIdx+'" class="openAllOrgNArea">';
		str += '<td rowspan="2" class="vt">';

		str += '<SELECT class="select_b mgr20" id="orgSelBox_'+g_rowIdx+'" ref-val="'+g_rowIdx+'" onchange="fnObj.initOrgTr(\''+g_rowIdx+'\');">';
		for(var i=0; i<orgCodeCombo.length; i++){
			str += '<option value="'+orgCodeCombo[i].optionValue+'">'+orgCodeCombo[i].optionText+'</option>';
		}
		str += '</SELECT></td>';
		str += '<td class="itemList txt_left">';

		str += '<label><input type="radio" name="targetOrg_'+g_rowIdx+'" value="ALL" onchange="fnObj.selectTargetOrg(\''+g_rowIdx+'\');" checked="checked"/><span>전체</span></label>';
		str += '<label><input type="radio" name="targetOrg_'+g_rowIdx+'" value="DEPT" onchange="fnObj.selectTargetOrg(\''+g_rowIdx+'\');"/><span>부서선택</span></label>';
		str += '<label><input type="radio" name="targetOrg_'+g_rowIdx+'" value="USER" onchange="fnObj.selectTargetOrg(\''+g_rowIdx+'\');"/><span>직접선택</span></label>';

		str += '<a href="javascript:fnObj.userPop(\''+g_rowIdx+'\');" id="userBtn_'+g_rowIdx+'" class="btn_select_employee mgl5" style="display:none;"><em>직원선택</em></a></td>';
		str += '</td>';

		str += '<td rowspan="2" class="txt_center vt">';


		str += '<a href="javascript:fnObj.addTrTargetSelect();" class="btn_ac_add openAllOrgArea"><em>추가</em></a>';

		if(g_rowIdx >0){
			str += '<a href="javascript:fnObj.deleteRow('+g_rowIdx+');" class="btn_ac_delete openAllOrgArea"><em>삭제</em></a>';
		}
		str += '</td>';
		str += '</tr>';


		str += '<tr name="row_'+g_rowIdx+'" class="dot_line openAllOrgNArea">';
		str += '<td class="txt_left"><span id="userList_'+g_rowIdx+'" class="employee_list mgt10">[전체]</span></td>';
		str += '</tr>';


    	$("#choiceOrgTable tbody").append(str);

    	if(typeof dataObj == 'object'){
    		$('#orgSelBox_'+g_rowIdx).val(dataObj.orgId);
    		$('input[name="targetOrg_'+g_rowIdx+'"][value="'+dataObj.openTargetOrg+'"]').prop("checked",true);

    		if(dataObj.openTargetOrg != 'ALL')$("#userBtn_"+g_rowIdx).show();
    		if(dataObj.targetList.length>0) fnObj.getResult(dataObj.targetList,g_rowIdx);	//사원세팅

    		if(dataObj.openTargetOrg == 'DEPT') $("#userBtn_"+g_rowIdx).attr('class','btn_select_team mgl5');
	  	    else if(dataObj.openTargetOrg == 'USER') $("#userBtn_"+g_rowIdx).attr('class','btn_select_employee mgl5');

    	}

    	g_rowIdx++;
    },

    deleteRow : function(idx){
		$('tr[name="row_'+idx+'"]').remove();
    },

    //관계사 셀렉트 박스 변경 시 초기화
    initOrgTr : function(idx){

    	$('input[name="targetOrg_'+idx+'"][value="ALL"]').prop("checked",true);
    	$('#userList_'+idx).html('[전체]');
    }

};

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){

	fnObj.pageStart();
	fnObj.addTrTargetSelect();
	fnObj.getBoardCateInfo();			//게시판 정보 가져오기

	if(g_contentId>0){
		fnObj.doSearch();				//게시판 글 정보
		fnObj.getFileList();			//게시판 파일 정보
	}

});

</script>