<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<section id="detail_contents">

		<h4 class="board_titleBox"><span class="h4_title" id = "gboardTitleNm">게시판 타이틀</span> <span class="h4_destxt" id = "gboardDescNm" style="display: none;"></span></h4>
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


                    <div class="noti_period" style="display:none;"><span class="title">헤드라인기간</span>
                    	<input type="text" id="noticeStartDate" class="input_date" style="width:75px;" readonly="readonly"/>
						<a href="#" onclick="javascript:fnObj.clickDate('noticeStartDate');return false;" class="icon_calendar" ></a>

	                    <span>~</span>

	                    <input type="text" id="noticeEndDate" class="input_date" style="width:75px;" readonly="readonly"/>
						<a href="#" onclick="javascript:fnObj.clickDate('noticeEndDate');return false;" class="icon_calendar" ></a>



						<!-- <label id = "allBoardArea"><input type="checkBox" id="allBoard" value="Y" /><span>모든 게시판 공지</span></label> -->
						<!-- <label id="allOrgArea"><input type="checkBox" id="allOrg" value="Y" /><span>전사 게시판 공지</span></label> -->
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
                	<jsp:include page="/daumeditor/editor.jsp"></jsp:include>
                </td>
            </tr>

        	<tr id="fileTr">

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

            </tr>

        </table>
        <!--//공지사항등록//-->
        <div class="btn_baordZone2">
            <a href="#;return false;" onclick="javascript:goListPage();" class="btn_witheline">취소</a>
            <a href="#;return false;" onclick="javascript:fnObj.doSave();" class="btn_blueblack btn_auth">확인</a>
        </div>

</section>



<script type="text/javascript">

//Global variables :S ---------------


var fileSeqArray = new Array();		//업로드된 파일 key list
var isSaved = false; 				//저장을 했는지 여부(저장하며 자동으로 닫힐때 발생하는 이벤트와 저장안하고 닫을때 차별)

var inputTitleBorder;				//제목 border style
var contentBorder;					//내용 border style

var myUpload1 =  new AXUpload5();	//instance

var g_gboardId 	= $("#searchGboardId").val();
var g_contentId	= $("#searchGboardContentId").val();

var g_idx =0;						//파일 idx

var delArray = new Array();
var saveFileList ;

//Global variables :E ---------------



var fnObj = {

    pageStart : function(){

    	//달력 세팅
    	fnObj.setDatepicker('noticeStartDate');
    	fnObj.setDatepicker('noticeEndDate');
    	var nowDate = new Date();
    	$("#noticeStartDate").datepicker('setDate', nowDate);
    	$("#noticeEndDate").datepicker('setDate', new Date(nowDate.getFullYear(),nowDate.getMonth(),parseInt(nowDate.getDate())+7));
    	//if(g_groupUid != 'notice') $("#allOrgArea").hide();	//공지가 아닐때 전사공지 숨기기

    	//if($("#openFlag").val() == 'N') $("#allBoardArea").hide();


    },	//end function pageStart.

    //게시판 정보
    getBoardCateInfo : function(){
    	if($("#searchNoticeYn").val() == 'N'){				//게시판 헤드라인 사용여부
			$(".noticeTr").hide();
			$(".titleRow").css("border-top","#516279 solid 1px");
		}
		if($("#searchFileYn").val() == 'N'){					//게시판 파일첨부 사용여부
			$("#fileTr").hide();
		}
    },

  	//검색
    doSearch: function(){

    	var url = contextRoot + "/gboard/getBoardContent.do";
    	var param = {
    					contentId : g_contentId
    				}

    	var callback = function(result){

    		var obj = JSON.parse(result);
    		//var infoMap = obj.resultObject;
    		var list= obj.resultList;
    		for(var i=0;i<list.length;i++){
    			// 공지사항
    			if(list[i].noticeFlag == 'Y'){
    				$('input:radio[name=noticeYn]:input[value=Y]').trigger("click");//prop("checked", true);

    			}
    			if(list[i].noticeStartDate > '2000-01-01')  $("#noticeStartDate").val(list[i].noticeStartDate);
    			if(list[i].noticeEndDate >'2000-01-01')  $("#noticeEndDate").val(list[i].noticeEndDate);

    			if(list[i].allBoard == 'Y') $("#allBoard").prop("checked",true);

    			$('#inputTitle').val(list[i].title); // 제목
    			Editor.modify({						 // 내용
    				"content": list[i].content		 /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
    			});

    		}
    	}
    	commonAjax("POST", url, param, callback, false);
    },//end doSearch

    //첨부파일 리스트
    getFileList : function(){
    	var url = contextRoot + "/file/getFileList.do";
    	var param = {
    					uploadId 	: g_contentId,
    					uploadType  : 'GBOARD'
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
	    			str +='<span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.setDelFile('+fileObj.fileSeq+','+g_idx+');" class="fileDelete btn_auth"><em>삭제</em></a></li>';
	    			g_idx++;
				}
	    		$('#uploadFileList').html(str);
	    		$('#uploadFileList').show();
    		}

    	}
    	commonAjax("POST", url, param, callback, false);
    },


  	//저장
    doSave : function(){

    	var noticeYn = $("input:radio[name='noticeYn']:checked").val();
    	var noticeStartDate = $("#noticeStartDate").val();
    	var noticeEndDate = $("#noticeEndDate").val();

    	var allBoard = 'N';
    	var allOrg = 'N';

    	var fileList ='';
    	var title = $('#inputTitle').val();
    	var delFileList='';
    	var infoLevel = '';
    	if($("input[name='infoLevel']").length>0) infoLevel = $("input[name='infoLevel']:checked").val();
    	if($("#allBoard").is(":checked")) allBoard = 'Y';
    	if($("#allOrg").is(":checked")) allOrg = 'Y';


    	if(noticeYn == 'N'){		//헤드라인 설정 안함이면 ..
    		noticeStartDate = '1900-01-01';
    		noticeEndDate = '1900-01-01';
    		allBoard = 'N';
        	allOrg = 'N';

    	}else{						//날짜 유효성
    		if(noticeStartDate>noticeEndDate){
    			alert("날짜를 확인 해주세요.");
    			$('#noticeStartDate').focus();
        		return false;
    		}
    	}
    	if(title == ''){
    		alert("제목을 입력해주세요.");
    		$('#inputTitle').focus();
    		return false;
    	}
    	if(Editor.getContent() == '<p><br></p>'){
			alert("내용을 적어주세요.");
			return false;
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
				jobj.uploadType='GBOARD';
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

		var url = contextRoot + "/gboard/saveBoardContent.do";
    	/*=========== 첨부파일 : E =========== */

    	var param = {
    			contentId		:	g_contentId,
    			noticeFlag		:	noticeYn,
    			allBoard		:	allBoard,
    			noticeStartDate :	noticeStartDate,
    			noticeEndDate	:	noticeEndDate,
    			gboardId		: 	g_gboardId,
    			title			: 	$('#inputTitle').val(),
    			content			: 	Editor.getContent(),
    			fileList		:   fileList,				//신규 파일 리스트
    			delFileList		:   delFileList				//수정시 삭제한 파일들의 시퀀스 리스트
    	}


    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		if(cnt>0){
    			//opener.fnObj.doSearch(1);
    			//fnObj.viewContent(cnt);
    			if(g_cboardUid == 'improvement'){
    				alert("개선사항이 접수되었습니다. 담당자가 확인 후 처리합니다.");
    			}else{
    				alert("완료되었습니다.");
    			}

    			if(g_contentId == "0"){
	    			$("#moveListType").val('node');
	    			$("#frm").attr("action",contextRoot+"/gboard/getGboardListAjax.do");

	    			commonAjaxSubmit("POST",$("#frm"),includeContentsPageCallback);
    			}else{
    				goListPage();
    			}
    		}else{
    			alert("등록 실패!!");
    		}


    	};
    	commonAjax('POST', url, param, callback);
    },//end doSave


    //수정시 db 에 이미 저장된 파일삭제 할땐. 바로삭제하지않고 리스트를 만든다.
    setDelFile: function(fileSeq,idx){

    	delArray.push(fileSeq);
    	$("#li_"+idx).remove();
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
    	$('#'+obj).datepicker('show');
    	$("#ui-datepicker-div").zIndex("9999");
    },

    //헤드라인 버튼 클릭
    checkNotice : function(value){
    	if(value == 'Y'){
    		$(".noti_period").show();
    	}else{
    		$(".noti_period").hide();
    		$("#allBoard").prop("checked",false);
    		$("#allOrg").prop("checked",false);
    	}
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
   				str +='<span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+');" class="fileDelete btn_auth"><em>삭제</em></a></li>';
   				g_idx++;


   			}

   			//파일 태그 재 생성.
   			$('#fileInputArea').append('<input name="upFile" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload();">');



  			$('#uploadFileList').append(str);
  			$('#uploadFileList').show();


   		}

   		commonAjaxForFileCreateForm(url,"","upFile","100","fileSize", callback , "");

  	}


};

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.getBoardCateInfo();			//게시판 정보 가져오기
	fnObj.pageStart();
	if(g_contentId>0){
		fnObj.doSearch();				//게시판 글 정보
		fnObj.getFileList();			//게시판 파일 정보
	}
	//$("#gboardTitleNm").text($("#searchBoardTitle").val()+" 글쓰기");
	$("#gboardTitleNm").text($("#searchBoardTitle").val());
	var desc = $("#searchGboardDesc").val();
	if(desc != ""){
		$("#gboardDescNm").text(desc);
		$("#gboardDescNm").show();
	}



});

</script>