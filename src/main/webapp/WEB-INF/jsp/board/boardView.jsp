<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<section id="detail_contents">

	<form name="downForm" id="downForm"></form>


	<!--공지사항-->
	<article id="board_conbox">

		<table class="tb_regi_basic"
			summary="정보정리내용안내 (제목, 작성자, 작성일, 경로, 금액, 일자, 직원, 내용, 진행상태)">
			<caption>정보정리내용안내</caption>
			<colgroup>
				<col width="120">
				<col width="*">
				<col width="120">
				<col width="150">
				<col width="200">
				<col width="150">
				<col width="160">
				<col width="140">
				<col width="160">
				<col width="70">
			</colgroup>

			<tbody>
				<tr>
					<th>제목</th>
					<td colspan="2"><span id="iconNotice"></span><span id="titleArea"></span></td>
					<th>작성자</th>
					<td id="createNm"></td>
					<th>등록일</th>
					<td class="txt_date" id="createdDate"></td>
					<th>조회수</th>
					<td class="txt_center" id="hitCount"></td>
				</tr>
				<tr>
					<th>관계사명</th>
					<td id="orgNm" colspan="2"></td>
					<th class="periodArea">공개기간<a href="javascript:fnObj.editOpenDate();" id="openPeriodEditBtn" style="display:none;" class="btn_s_type_blue2 mgl10">수정</a></th>
					<td colspan="3" class="txt_date periodArea" id="openPeriod"></td>
					<th class="statusArea">상태값</th>
					<td class="statusArea txt_center"><span class="state_business" id="approveStatus"></span></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="8">
						<div class="board_contents" id="boardContents"
							name="boardContents"></div> <!--첨부파일리스트-->
						<div class="view_fileListWrap fileDisplay" id="main_file_list">
							<dl class="view_fileList" id="uploadFileList" name="uploadFileList">
								<dt>첨부파일</dt>
								<dd>
									<ul class="in_fileList" id="fileList">
									</ul>
									<div id="fileBtn" class="mgt10">
										<a href="#;return false;" onclick="javascript:fnObj.fileDown('SEL');" class="btn_s_type_g "><em>선택받기</em></a>
										<a href="#;return false;" onclick="javascript:fnObj.fileDown('ALL');" class="btn_s_type_g"><em>전체받기</em></a>
									</div>
								</dd>
							</dl>

						</div> <!--//첨부파일리스트//-->
					</td>
				</tr>
				<tr id="openAllOrgTr">
					<th>공개범위</th>
					<td colspan="8">
						<ul id="openOrgListArea"></ul>
					</td>
				</tr>
				<tr id="approveTr" style="display:none;">
					<th>결재의견 및 상태</th>
					<td colspan="8">
						<table class="purchase_grid_tb mgt10 mgb10"
							summary="구매내역입력(구매물품, 단가, 수량, 금액)">
							<caption>구매내역입력</caption>
							<colgroup>
								<col width="100">
								<col width="*">
								<col width="70">
								<col width="130">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">결재자</th>
									<th scope="col">결재의견</th>
									<th scope="col">상태</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tfoot class="appRippleBox" id="approveEditArea">
								<tr>
									<th class="txt_center">결재의견</th>
									<td colspan="3">
										<div class="RippleCon">
											<dl class="normal bg_on">
												<dt>
													<span class="name">${baseUserLoginInfo.userName}</span>
													<span class="date nowDateArea"></span>
												</dt>
												<dd class="commentBox">
													<div class="txtArea">
														<textarea class="txtArea_b" id="approveNote" placeholder="승인 또는 반송시 결재의견을 작성하실 수 있습니다." title="내용입력"></textarea>
													</div>
												</dd>
												<dd class="btnZone">
													<span><a href="javascript:fnObj.saveApprove('APPROVE');" class="btn_re_agree"><em>승인</em></a></span>
													<a href="javascript:fnObj.saveApprove('REJECT');" class="btn_re_noagree"><em>반송</em></a>
												</dd>

											</dl>
										</div>
									</td>
								</tr>
							</tfoot>
							<tbody id="approveArea"></tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>

		<!-- 댓글 -->
		<div class="board_rippleWrap commentDisplay">
			<div class="rippleSum">
				<span class="opinion_control"><a href="javascript:;" onclick="javascript:fnObj.displayComment();return false;" class="close btn_auth" id="rippleSum">댓글
				<span class="count" id="commentCount"></span></a></span>
				<!--댓글닫기-->
			</div>
			<div id="RippleZone">
				<!--리플목록-->
				<div id="commentListDiv">
					<div id="commentList" class="RippleCon"></div>
				</div>
				<!--//리플목록//-->
				<!--일반 답글입력폼-->

				<form name="fileForm" id="fileForm" method="post">
					<dl class="normal bg_on">
						<dt>
							<span class="name">${baseUserLoginInfo.userName}</span><span class="date nowDateArea"></span><label class="mgl15 secretArea"><input type="checkbox" id="secretYn_0"><span>비밀글</span></label>
						</dt>
						<dd class="commentBox">
							<div class="txtArea">
								<textarea class="txtArea_b" placeholder="내용을 입력해주세요" title="내용입력" id="commentText" name="commentText"></textarea>
								<button type="button" onclick="javascrit:fnObj.saveComment(0,0,0,this.form.name);return false;" class="btn_comment btn_auth">Comment</button>
							</div>
						</dd>
						<dd class="addFileList fileDisplay" id="fileTr">
							<p class="titleZone">
								<span id="fileInputArea" class="file_btn_bg"><input name="upFile" type="file" multiple onchange="fnObj.newFileUpload('','');" class="file_btn_cover"></span>
							</p>
							<ul id="commentUploadFileList" style="display: none;"></ul>
						</dd>
					</dl>
				</form>

				<!--//일반 답글입력폼//-->
			</div>
			<!-- RippleZone -->
			<ul class="board_s_list">
				<li id="prevContent">이전글<span id="prevClass"></span><span id="prevTitle"></span></li>
				<li id="nextContent">다음글<span id="nextClass"></span><span id="nextTitle"></span></li>
			</ul>

		</div>
		<!-- 	board_rippleWrap -->
		<!-- //댓글// -->
	</article>

	<!--//공지사항//-->
	<div class="btn_baordZone2">
		<a href="${pageContext.request.contextPath}/board/boardList/${groupUid}/${cboardUid}.do" class="btn_witheline">목록</a>
		<a href="#" onclick="javascript:fnObj.doEditContent();" id="editBtn" class="btn_blueblack btn_auth" style="display: none;">수정</a>
		<a href="#" onclick="javascript:fnObj.doDeleteContent();" id="deleteBtn" class="btn_grayline btn_auth" style="display: none;">삭제</a>
	</div>
	</div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
var myModal = new AXModal();		// instance

var g_groupId 	= ''; //게시판 그룹ID
var g_cboardId 	= '${cboardId}';
var g_contentId	= '${contentId}';

var g_groupUid 	= '${groupUid}';
var g_cboardUid	= '${cboardUid}';

var fileList = '';
var downFileList =new Array();
var g_idx =0;
var delArray=new Array();
var commentList = new Array();
var g_boardFileYn;
var g_boardReplyYn;
var g_boardNoticeYn;

var g_secretYn;

var g_boardInfo = new Object();
var g_contentInfo = new Object();

var contentRegId = '';			//게시글 유저아이디
//Global variables :E ---------------



var fnObj = {

    pageStart: function(){
		//리사이즈 가능한 textarea 의 리사이즈기능을 막는다. (재정의를 통해?!)
    	$("#content").resizable({});

    	//-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",

    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: false,
    		onclose: function(){

    		}
            ,contentDivClass: "popup_outline"

    	});
    	//-------------------------- 모달창 :E -------------------------
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
    			g_groupId = list[i].groupId;
    			$("#boardTitle").html(list[i].cboardName);
    			$("#groupName").html(list[i].groupName);
    			$("#cboardName").html(list[i].cboardName);
    			$("#searchCount").val(list[i].listCount);
    			g_cboardId=list[i].cboardId;				//게시판 아이디 세팅

    			g_boardFileYn = list[i].fileYn;
    			g_boardReplyYn= list[i].replyYn;
    			g_boardNoticeYn= list[i].noticeYn;
    			g_secretYn = list[i].secretYn;

    			if(g_boardFileYn == 'N'){					//게시판 파일첨부 사용여부
    				$(".fileDisplay").hide();
    			}
    			if(g_boardReplyYn == 'N'){					//게시판 파일첨부 사용여부
    				$(".commentDisplay").hide();
    			}

    		}


    	};

		commonAjax("POST", url, param, callback, false);
    },

  	//검색
    doSearch : function(){

    	var url = contextRoot + "/board/getBoardContent.do";
    	var param = {
    					contentId : g_contentId
    				}

    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var infoMap = obj.resultObject;
    		var list = infoMap.boardInfo;		//글정보
    		var openOrgInfoList = infoMap.boardOpenOrgInfo;

    		for(var i=0;i<list.length;i++){

    			g_contentInfo =  list[i];

    			var stStr = "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].createdBy+"\",$(this),\"mouseover\",null,0,-200,200)'>";
    				stStr+= list[i].createNm+"</span>";
    			$('#createNm').html(stStr);
    			$('#createdDate').text(list[i].createdDate);
    			$('#hitCount').text(list[i].hit);
    			//$('#contentId').text(list[i].contentId);
    			//공지사항 아이콘
    			var dateStr = new Date().yyyy_mm_dd();
    			if(list[i].noticeStartDate<= dateStr&& dateStr <= list[i].noticeEndDate && list[i].noticeFlag=='Y' && g_boardNoticeYn == 'Y'){
					$('#iconNotice').addClass("icon_notice");
				}else{
					$('#iconNotice').removeClass("icon_notice");
				}
    			$('#titleArea').html(devUtil.fn_escapeReplace(list[i].title));
    			$('#boardContents').html(list[i].content);
    			$("#commentCount").html(list[i].commentCount);
    			$(".nowDateArea").html(new Date().yyyy_mm_dd().replace(/-/gi,'.'));

    			$('#openPeriod').html(list[i].openStartDate+'~'+list[i].openEndDate);
    			$('#orgNm').html(list[i].orgNm);

    			$("#commentCount").html(list[i].commentCount);


    			//******결재의견 및 상태값
    			if(g_boardInfo.approveYn == 'Y'){


    				var statusStr = '';
        			if(list[i].approveStatus == 'TEMP') statusStr='임시저장';
        			else if(list[i].approveStatus == 'REQUEST')	statusStr='승인요청';
        			else if(list[i].approveStatus == 'APPROVE') statusStr='승인';
        			else if(list[i].approveStatus == 'REJECT') statusStr='반송';

        			$("#approveStatus").html(statusStr);

	    			var approveStr = '';

	    			if(list[i].approveStatus == 'APPROVE' || list[i].approveStatus == 'REJECT'){ //승인일때


	    				approveStr += '<tr>';
	    				approveStr += '<td class="txt_center">'+list[i].approveName+'</td>';
	    				approveStr += '<td>'+list[i].approveNote+'</td>';
	    				approveStr += '<td class="txt_center"><span class="state_business">';
	    				if(list[i].approveStatus == 'APPROVE') approveStr += '승인';
	    				if(list[i].approveStatus == 'REJECT') approveStr += '반송';
	    				approveStr += '</span></td>';
	    				approveStr += '<td class="txt_date txt_center">'+list[i].approveDate+'</td>';
	    				approveStr += '</tr>';

	    				$("#approveEditArea").hide();
	    			}else{
	    				approveStr = '<tr><td colspan="4" class="txt_center">승인 대기중입니다.</td></tr>';
	    				$("#approveEditArea").show();



	    			}
	    			$("#approveArea").html(approveStr);

	    			if(g_boardInfo.staffUserId != '${baseUserLoginInfo.userId}') $("#approveEditArea").hide();

	    			if(list[i].approveStatus != 'TEMP'){
	    				$("#approveTr").show();

	    				//특별권한자나 작성자는 공개기간 수정버튼 노출
	    				if(list[i].createdBy == '${baseUserLoginInfo.userId}'
	    						|| list[i].editOpenAuth == 'Y') $("#openPeriodEditBtn").show();
	    			}


    			}


    			//******수정 삭제버튼 세팅
    			g_contentRegId = list[i].createdBy;
    			if(list[i].createdBy == '${baseUserLoginInfo.userId}'){

    				$("#deleteBtn").show();
    				if(list[i].cboardId == g_cboardId){		//해당 게시글이 등록된 카테고리에서 수정버튼 활성화
    					$("#editBtn").show();
    				}
    			}

    			//******승인형 게시판(수정 삭제버튼 세팅)
    			if(list[i].approveYn == 'Y'){
    				if(list[i].approveStatus != 'TEMP') $("#editBtn").hide();		//임시저장이 아니면 수정불가
    				if(list[i].approveStatus == 'APPROVE') $("#deleteBtn").hide();	//승인후 삭제불가
    			}

				//******공개범위

				var str ='';
    			//전사 세팅 게시판이고 모든 관게사 게시 면 - 전사
    			if(list[i].openAllYn == 'Y' && list[i].allOrg == 'Y'){

    				str ='<li>[전사]</li>';

    			//전사 세팅 게시판이고 관게사 게시 아니면 - 관계사
    			}else{
    				for(var k=0; k<openOrgInfoList.length; k++){
       	    			str += '<li>['+openOrgInfoList[k].orgNm+'] ';
       	    			var first = '<span class="userProfileTargetArea" onmousedown = "openUserProfileBox(\'';
       	    			var last = '\',$(this),\'mouseover\',null,10,0,0)">';
						//프로필세팅
       	    			str += ((openOrgInfoList[k].userList.replace(/#userProfile#/gi, first)).replace(/#endPrefix#/gi, last)).replace(/#span#/gi, ' </span>');

       	    			str += '</li>';

       	    		}


    			}
    			$("#openOrgListArea").html(str);
    			//******비밀글
				if(g_secretYn == 'Y') $('.secretArea').show();
				else $('.secretArea').hide();

    			//테이블 상단 관계사명/공개기간/상태값

    			var colspanCnt = 2;
    			//g_boardInfo.staffUserId != '${baseUserLoginInfo.userId}'
    			if(g_boardInfo.openPeriodYn == 'N'){
    				colspanCnt = colspanCnt+4;
    				$(".periodArea").hide();
    			}
    			if(g_boardInfo.approveYn == 'N'){
    				colspanCnt = colspanCnt+2;
    				$(".statusArea").hide();
    			}

    			$("#orgNm").attr('colspan',colspanCnt);

				//브라우저 타이틀(title tag) 변경
    			document.title = devUtil.fn_escapeReplace(list[i].title) + ' - PASS';

    			//유저프로필 이벤트 셋팅
    			initUserProfileEvent();

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
    		fileList = list;
    		var fileHtml = '';
    		if(list.length>0){
	    		for(var i=0;i<list.length;i++){
					fileHtml += '<label><li><input type="checkbox" name="fileChk" value="'+list[i].fileSeq+'"><span style="margin-left:5px;">' + list[i].orgFileNm + '</span>';
					fileHtml +='<input type="hidden" name="fileSeq" value="'+list[i].fileSeq+'">' ;
					fileHtml +='<input type="hidden" name="newFileNm" value="'+list[i].newFileNm+'">' ;
					fileHtml +='<input type="hidden" name="filePath" value="'+list[i].filePath+'">' ;
					fileHtml += '<span>(' + parseInt(list[i].fileSize/1024) + 'KB)</span></li></label>';

					$('#fileList').html(fileHtml);
				}
    		}else{

    			$('#main_file_list').hide();		//첨부파일 영역 아예 안보이도록
    		}

    	}
    	commonAjax("POST", url, param, callback, false);
    },

 	//이전글 다음글 받아오기
    getBoardContentPrevNext : function(){
    	var url = contextRoot + "/board/getBoardContentPrevNext.do";
    	var param = {
    					contentId : g_contentId,
    					cboardId  : g_cboardId
    				}

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var resultObj = obj.resultObject;
    		var prevObj = resultObj.prev;
    		var nextObj = resultObj.next;
    		var nowDate = new Date().yyyy_mm_dd();
    		//이전글
    		if( prevObj != null){
				if( prevObj.noticeFlag=='Y' && prevObj.noticeStartDate <= nowDate && prevObj.noticeEndDate >= nowDate) $('#prevClass').addClass("icon_notice mgl30 mgr6");
				else $('#prevClass').addClass("mgl30");

				var titleLink = "<a href='javascript:fnObj.viewContent("+ prevObj.contentId +")'>" + devUtil.fn_escapeReplace(prevObj.title) + "</a>";
				$('#prevTitle').html(titleLink );

				$('#prevContent').show();
			}
			else{
				$('#prevContent').hide();
			}

    		//다음글
    		if( nextObj != null){
				if( nextObj.noticeFlag=='Y' && nextObj.noticeStartDate <= nowDate && nextObj.noticeEndDate >= nowDate) $('#nextClass').addClass("icon_notice mgl30 mgr6");
				else $('#nextClass').addClass("mgl30");

				var titleLink = "<a href='javascript:fnObj.viewContent("+ nextObj.contentId +")'>" + devUtil.fn_escapeReplace(nextObj.title) + "</a>";
				$('#nextTitle').html(titleLink);

				$('#nextContent').show();
			}
			else{
				$('#nextContent').hide();
			}

    	}
    	commonAjax("POST", url, param, callback, false);
    },

 	// 이전 및 다음글보기
    viewContent	: function(contentId){
    	//조회수 올리고
    	var url = contextRoot + "/board/boardViewCount.do";
    	var param = {contentId : contentId};

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;		//결과수
    		if(cnt>0){
				location.href = '${pageContext.request.contextPath}/board/boardContentView/'+g_groupUid+'/'+g_cboardUid+'.do?cboardId=' + g_cboardId + '&contentId=' + contentId;
	        }else{
    			alert("게시글 조회에 실패하였습니다.");
    			return;
    		}

    	};

		commonAjax("POST", url, param, callback, false);

    },//end viewContent

    /*================================================= 본글 기능 : S ==============================================*/

    //수정
 	doEditContent : function(){

    	var url = '${pageContext.request.contextPath}/board/boardContentWrite/'+g_groupUid+'/'+g_cboardUid+'.do?cboardId=' + g_cboardId + '&contentId=' + g_contentId;
    	location.href=url;
    },

    //본글 삭제
    doDeleteContent	: function(){

    	if(confirm("해당 게시글을 삭제하시겠습니까?")){
	    	var url = contextRoot + "/board/deleteContent.do";
	    	var param = {
	    			 contentId 		: g_contentId,
	    			 uploadId 		: g_contentId,
	    			 uploadType 	: 'BOARD'
	    	}
	    	var callback = function(result){

	    		var obj = JSON.parse(result);
	    		var cnt = obj.resultVal;		//결과수

	    		if(cnt > 0){
	    			alert("삭제되었습니다.");
	    			location.href = contextRoot + '/board/boardList/'+g_groupUid+'/'+g_cboardUid+'.do';
	    		}else{
	    			if(cnt == -10){
	    				alert("이미 결재가 진행되어 삭제불가합니다.");
	    			}else alert("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
	    		}

	    	};

	    	commonAjax("POST", url, param, callback);
    	}

    },

    /*================================================= 본글 기능 : E ==============================================*/

    /*================================================= 파일 기능 : S ==============================================*/

    //파일 다운로드
    fileDown : function(type){
    		downFileList = new Array();
    		//전체다운로드
    		var checkList =$("input[name=fileChk]:checked");
    		for(var i=0;i<fileList.length;i++){
    			if(type == 'ALL'){									//전체다운로드
    				downFileList.push(fileList[i].fileSeq);
    			}else{
    				for(var k=0;k<checkList.length;k++){
	    				if(checkList[k].value == fileList[i].fileSeq){	//체크된 값 만..
	    					downFileList.push(fileList[i].fileSeq);
	    				}
	    			}
    			}
			}
    		if(downFileList.length ==0){
    			alert("파일을 선택해 주세요");
    			return false;
    		}else if(downFileList.length > 1){		//다중다운로드일때
    			url = contextRoot + "/file/downFilesTozip.do?uploadType=BOARD&downFileList="+downFileList.join(",");
    		}else{
    			url = contextRoot + "/file/downFile.do?uploadType=BOARD&downFileList="+downFileList.join(",");
    		}

    		//window.open(url);
    		 var frm = document.downForm;
    		frm.action = url;
    		frm.method = "POST";
    		frm.submit();
    },

  	//댓글 파일 다운로드
    fileDownComment : function(fileSeq){
    	url = contextRoot + "/file/downFile.do?uploadType=BOARD_COMMENT&downFileList="+fileSeq;
    	var frm = document.downForm;
		frm.action = url;
		frm.method = "POST";
		frm.submit();
    },

    //파일 바로 삭제
    newFileDelete : function(newFileNm,filePath,idx){
    	var url = contextRoot + "/file/deleteFile.do";
    	var param = { newFileNm : newFileNm , filePath : filePath};
    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		if(cnt>0){
    			if($("#li_"+idx).parent().children().length==1) $("#li_"+idx).parent().hide();		//지우려는 파일이 마지막일 경우 파일을 지우기전에 첨부파일 구분선을 숨긴다.
    			$("#li_"+idx).remove();
    		}
    	};
    	commonAjax("POST", url, param, callback, false);
    },

    //수정시 db 에 이미 저장된 파일삭제 할땐. 바로삭제하지않고 리스트를 만든다.
    setDelFile: function(fileSeq,idx){
    	delArray.push(fileSeq);
    	if($("#li_"+idx).parent().children().length<2) $("#li_"+idx).parent().hide();		//지우려는 파일이 마지막일 경우 파일을 지우기전에 첨부파일 구분선을 숨긴다.
    	$("#li_"+idx).remove();
    },//end setDelFile

  	//신규 파일 등록시
    newFileUpload : function(recommentId,commentId){		//엄마, 나

		var url = contextRoot+"/file/uploadFiles.do"


   		var callback = function(result){

   			var list = result.resultList;
   			var str='';
   			for(var i=0;i<list.length;i++){
   				var fileObj = list[i];
   				str +='<li id="li_'+g_idx+'">' + fileObj.orgFileNm ;
   				str +='<input type="hidden" name="commentFileSeq" value="0">' ;
   				str +='<input type="hidden" name="commentOrgFileNm" value="'+fileObj.orgFileNm+'">' ;
   				str +='<input type="hidden" name="commentNewFileNm" value="'+fileObj.newFileNm+'">' ;
   				str +='<input type="hidden" name="commentFilePath" value="'+fileObj.filePath+'">' ;
   				str +='<input type="hidden" name="commentFileSize" value="'+fileObj.fileSize+'">' ;
   				str +='<span class="num_st">' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
   				g_idx++;

   			}

   			//파일 태그 재 생성.
   			$('#fileInputArea'+commentId).append('<input name="upFile'+commentId+'" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload(\''+recommentId+'\',\''+commentId+'\');">');


   			$('#commentUploadFileList'+commentId).append(str);
   			$('#commentUploadFileList'+commentId).show();


   		}

   		commonAjaxForFileCreateForm(url,"",'upFile'+commentId,"100","commentFileSize", callback , "");

    },


   	/*================================================= 파일 기능 : E ==============================================*/

    /*================================================= 댓글 기능 : S ==============================================*/

  	// 댓글 정보를 가져와서 화면에 출력한다
    getCommentList : function(){
    	var url = contextRoot + "/board/getBoardCommentList.do";
    	var param = {
    					contentId: g_contentId
    				}

    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var resultList = obj.resultList;
    		commentList = resultList;
    		var rootList = [];

    		for(var i=0; i < resultList.length; i++){

    			var commentMap = resultList[i];
				var commentObj = commentMap['commentList'];			//하나의 첫 댓글
				var fileList = commentMap['fileList'];				//

				//처음에 depth 가  0 일때 새로운 0이 나타날때까지 count 를 해서 그 글에 엮인 댓글 수를 판단.
    			//댓글수가 0이면 삭제시 남길 필요가 없고,
    			//0이 아니면 남겨야 함...

    			var childCount =0;
    			var chk =-1;
    			for(var k=0; k < resultList.length; k++){
    				var commentMap2 = resultList[k];
    				var commentObj2 = commentMap2['commentList'];
    				if(commentObj['commentId'] == commentObj2['commentId'] && commentObj2['commentIdx'] == 0 ){	//첫 판단
    					chk =0;
    				}
    				if(chk ==0 && commentObj2['commentIdx'] != 0 && commentObj2['deleteFlag'] == 'N'){	//해당 글의 하위 글일때
    					childCount++;
    				}
    				if(commentObj['commentId'] != commentObj2['commentId'] && commentObj2['commentIdx'] == 0 ){	//두번째 판단
    					chk =-1;
    				}

        		}

    			var customStyle = "";
				var isRoot = false;
				var replyClass ="ripple";

				if( commentObj['recommentId'] == 0 || commentObj['recommentId'] == null){
					customStyle = "";
					isRoot = true;
					replyClass = "";
				}

				var htmlTmp = '';


				//if(commentObj['deleteFlag'] == 'Y' && commentObj['recommentCount'] >0){							//하위 글이 있고 본글 삭제시
				if(childCount != 0 && commentObj['deleteFlag'] == 'Y' ){											//하위 글이 있고 본글 삭제시
					htmlTmp += "<dl class='normal " + replyClass + "' id='comment" + commentObj['commentId'] + "'>";
					htmlTmp += "	<dd class='comment' id='commentBox" + commentObj['commentId'] +"'><font color='gray'>삭제된 댓글 입니다.</font></dd>";
					htmlTmp += "</dl>";
					htmlTmp += "</div>";
		            //htmlTmp += '<span id="ddd'+ commentObj['commentId'] +'"></span>';
				}else if(commentObj['deleteFlag'] == 'N'){														//삭제 안된 글
					htmlTmp += "<dl class='normal " + replyClass + " commentGrp" + commentObj['recommentId'] + "' id='comment" + commentObj['commentId'] + "'>";
	    			htmlTmp += '<div id="editDiv'+commentObj['commentId']+'" class="editFormDiv" style="display: none;"></div>';		//수정 폼 영역
	    			htmlTmp += "<div class='commentDiv' id='commentDiv" + commentObj['commentId'] + "'>";
	    			/*=============================== 이름,날짜,내용 영역 : S ================================*/

	    			htmlTmp += "	<dt>";

	    			htmlTmp += "	<span class='name2'>";
	    			htmlTmp += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+commentObj['createdBy']+"\",$(this),\"mouseover\",null,5,-80,80)'>";
	    			htmlTmp += commentObj['createNm'] + "</span></span>";
	    			htmlTmp += "	<span class='date'>" + commentObj['createdDate'] + "</span>";
	    			htmlTmp += "	</dt>";

	    			var content = devUtil.fn_escapeReplace(commentObj['content']).replace(/(?:\r\n|\r|\n)/g, '<br>');

	    			//비밀글 (글 등록자나 게시글 등록자)
	    			if(g_secretYn == 'Y' && commentObj['secretYn'] == 'Y'
	    					&& (commentObj['createdBy'] != '${baseUserLoginInfo.userId}' && g_contentRegId != '${baseUserLoginInfo.userId}')){
	    				content = '*******';
	    			}

	    			htmlTmp += "	<dd class='comment' id='commentBox" + commentObj['commentId'] + "' secretYn='"+commentObj['secretYn']+"'><span class='reply_target'>" + (commentObj['pUserNm'].length>0?'@':'') +  commentObj['pUserNm'] + '</span>' + content.split(" ").join("&nbsp;");

	    			if(g_secretYn == 'Y' && commentObj['secretYn'] == 'Y') htmlTmp +='<span class="icon_secret mgl5"><em>비공개</em></span>';

	    			htmlTmp +=" </dd>";

	    			/*=============================== 이름,날짜,내용 영역 : E ================================*/

	    			/*=============================== 답글 수정 삭제 버튼 영역 : S ================================*/
	    			htmlTmp += "<dd class='btnZone' id='reply" + commentObj['commentId'] + "' style='" + customStyle + "'>";
	    			htmlTmp += "<span><a href='#' onclick='javascript:fnObj.showRecommentForm(0," + commentObj['commentId'] +"," + commentObj['commentIdx'] +");return false;' class='btn_re_ripple btn_auth'><em>답글</em></a></span>";

	    			var editCssDisplay = "none;";

	    			if('${baseUserLoginInfo.userId}'== commentObj['createdBy']){ //내가쓴 글일때,슈퍼메니저 수정 삭제
	    				editCssDisplay = "inline-block;";
	    			}
    				htmlTmp += '<span><a href="#" style="display:'+editCssDisplay+'" onclick="javascript:fnObj.editRecommentForm(' + commentObj["commentId"] +','+ commentObj["recommentId"] +','+ commentObj["commentIdx"] +',\''+commentObj["createdDate"]+'\');return false;" class="btn_re_edit btn_auth"><em>수정</em></a></span>';
    				htmlTmp += "<span><a href='#' style='display:"+editCssDisplay+"' onclick='javascript:fnObj.deleteRecomment(" + commentObj['commentId'] +"," + commentObj['recommentId'] + ");return false;' class='btn_re_delete btn_auth'><em>삭제</em></a></span>";

	                htmlTmp += "</dd>";
	                /*=============================== 답글 수정 삭제 버튼 영역 : E ================================*/

	                if(fileList.length>0){
	                	//게시판에 파일기능 사용에만
	                	if(g_boardFileYn == 'Y'){

		                	htmlTmp += '<dd class="addFileList fileDisplay">';
		                	if(fileList.length>0){
		                		htmlTmp += '<ul class="in_fileList">';
		                	}
		    				for(var k=0;k<fileList.length;k++){

		    					htmlTmp += "<label><li class='fileDiv' id='file" + commentObj['commentId'] + "'><a href='#' onclick='fnObj.fileDownComment("+fileList[k].fileSeq+");'>" + fileList[k].orgFileNm + "</a>";
		    					htmlTmp += '<span class="num_st">' + parseInt(fileList[k].fileSize/1024) + 'KB</span></li></label>';
		    				}
		    				if(fileList.length>0){
		    					htmlTmp += "</ul>";
		                	}
		    				htmlTmp += "</dd>";
	                	}
	    			}
	                htmlTmp += "</dl>";
	                htmlTmp += "</div>";

	          	}
				htmlTmp += '<span id="ddd'+ commentObj['commentId'] +'"></span>';
	    		if( isRoot ){
	            	$('#commentList').append(htmlTmp);
					rootList.push(commentObj['commentId']);
				}
				else{
					if(rootList.indexOf(commentObj['recommentId']) >= 0){
						rootList.push(commentObj['commentId']);
                		$('#ddd' + commentObj['recommentId'] ).append(htmlTmp);
	                }else{
	                	$('#ddd' + commentObj['recommentId'] ).parent().append(htmlTmp);
	                }

				}
	    		//유저프로필 이벤트 셋팅
	    		initUserProfileEvent();
    		}

    	};

    	commonAjax("POST", url, param, callback,false);
    },

	//댓글 등록
    saveComment	: function(commentId,recommentId,commentIdx,frm){

    	var fileList ='';
    	var delFileList='';
    	var frm =$('form[name='+frm+']');
    	var commentText =frm.find('textarea[name=commentText]').val();

    	if(commentText==''){
    		alert("내용을 입력해주세요.");
    		frm.find('textarea[name=commentText]').focus();
    		return false;
    	}

    	/*=========== 첨부파일 : S =========== */
    	var fileSeqList 	= frm.find("input[name=commentFileSeq]");			//시퀀스 리스트
    	var orgFileNmList 	= frm.find("input[name=commentOrgFileNm]");			//파일명 리스트
    	var newFileNmList 	= frm.find("input[name=commentNewFileNm]");			//새로운 저장 파일명 리스트
    	var filePathList 	= frm.find("input[name=commentFilePath]");			//경로 리스트
    	var fileSizeList 	= frm.find("input[name=commentFileSize]");			//파일 크기 리스트
    	var jArray = new Array();

    	if(fileSeqList != undefined){

	    	for(var i=0;i<fileSeqList.length;i++){

	    		var fileSeq		 = fileSeqList[i].value;
	    		var orgFileNm 	 = orgFileNmList[i].value;
	    		var newFileNm  	 = newFileNmList[i].value;
	    		var filePath 	 = filePathList[i].value;
	    		var fileSize 	 = fileSizeList[i].value;

	    		if(fileSeq == 0){										//신규 등록건만 추가
		    		var jobj = new Object();
					jobj.fileSeq=fileSeq;
					jobj.orgFileNm=orgFileNm;
					jobj.newFileNm=newFileNm;
					jobj.filePath=filePath;
					jobj.fileSize=fileSize;
					jobj.uploadType='BOARD_COMMENT';
					jArray.push(jobj);
	    		}
	    	}

	    	var totalObj = new Object();
			totalObj.items=jArray;										//items 란 키값으로 totalObj에 jobj를 담은 jArray를 세팅
			fileList = JSON.stringify(totalObj);						//totalObj 를 string 변환
    	}

		if(jArray.length ==0) fileList = '';							//파일이 없을때는 빈값

		if(delArray.length !=0){										//수정시 삭제한 파일들의 리스트

			delFileList = delArray.join(",");
		}

		var url = contextRoot + "/board/saveBoardComment.do";
    	/*=========== 첨부파일 : E =========== */

    	var param = {
    			commentId		:	commentId,
    			contentId		:	g_contentId,
    			recommentId		:	recommentId,
    			commentIdx		:	commentIdx,
    			content			: 	commentText,
    			fileList		:   fileList,				//신규 파일 리스트
    			delFileList		:   delFileList,			//수정시 삭제한 파일들의 시퀀스 리스트
    			secretYn		: 	(g_secretYn == 'Y' && $("#secretYn_"+commentId).is(':checked') ? 'Y' : 'N')

    	}

    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;

    		if(cnt>0){
    			var url = document.location.pathname+document.location.search;
    			window.location.href = url;


    		}else{
    			alert("등록 실패!!");
    		}
    	};

    	commonAjax('POST', url, param, callback);
    },

    //댓글 삭제
    deleteRecomment : function(commentId){

    	if(confirm("댓글을 삭제하시겠습니까?")){
	    	var param = {commentId : commentId , uploadId : commentId};
	    	var url = contextRoot + "/board/deleteBoardComment.do";
	    	var callback = function(result){
	    		var obj = JSON.parse(result);
	    		var cnt = obj.resultVal;
	    		if(cnt>0){
	    			//fnObj.viewContent(g_contentId);
	    			//opener.fnObj.doSearch(opener.curPageNo);	//목록화면 재조회 호출.
	   			 	document.location.reload();
	    		}
	    	}

	    	commonAjax("POST", url, param, callback, false);
    	}
    },

    /*================================================= 댓글 기능 : E ==============================================*/

    /*================================================= 댓글 폼 : S ==============================================*/

    //답글 신규 폼
 	showRecommentForm : function(commentId,recommentId,commentIdx){		//commentId , 본인 recomment 엄마

    	fnObj.removeEditForm();
    	var typeSeq ='';

    	commentIdx++;
    	var htmlTmp ='';

    	htmlTmp += '<div name="recommentForm" class="recommentForm">';
    	htmlTmp += '<form name="fileForm'+recommentId+'" id="fileForm'+recommentId+'" class="fileForm">';
    	//htmlTmp += '<div class="RippleGroup bg_on">';
    	//htmlTmp += '<div class="RippleCon">';
    	htmlTmp += "<dl class='normal bg_on ripple' id='recommentForm" + recommentId + "'>";
    	htmlTmp += '<dt><span class="name2">${baseUserLoginInfo.userName}</span><span class="date">'+new Date().yyyy_mm_dd().replace(/-/gi,'.')+'</span>';

    	//비밀글
    	if(g_secretYn == 'Y') htmlTmp += '<label class="mgl15 secretArea"><input type="checkbox" id="secretYn_'+commentId+'"><span>비밀글</span></label>';
		htmlTmp += '</dt>';
    	htmlTmp += "<dd class='commentBox'>";
    	htmlTmp += "	<div class='txtArea'>";
		htmlTmp += "	<textarea class='txtArea_b'  placeholder='내용을 입력해주세요' title='내용입력' name='commentText' id='recommentText' ></textarea>";
		htmlTmp += "	<button type='button' onclick='javascript:fnObj.saveComment("+commentId+"," + recommentId + "," + commentIdx + ",this.form.name);return false;' class='btn_comment btn_auth'>Comment</button>";
		htmlTmp += "	</div>";
		htmlTmp += "</dd>";

		htmlTmp += "<dd class='btnZone'><span><a href='#' onclick='javascript:fnObj.removeEditForm();return false;' class='btn_re_cancel2 btn_auth'><em>답글취소</em></a></span></dd>";		//"</form></dl>";

		//게시판에 파일기능 사용에만
		if(g_boardFileYn == 'Y'){

			htmlTmp += '<dd class="addFileList fileDisplay" id="fileTr">';
	    	htmlTmp += '	<p class="titleZone">';
	    	htmlTmp += '<span id="fileInputArea'+commentId+'" class="file_btn_bg"><input name="upFile'+commentId+'" type="file" multiple onchange="fnObj.newFileUpload('+recommentId+','+commentId+');" class="file_btn_cover"></span>';

	    	htmlTmp += '	</p>';
	    	htmlTmp += '	<ul id="commentUploadFileList'+commentId+'" style="display:none;"></ul>';
	   		htmlTmp += '</dd>';
		}
   		htmlTmp += '</dl>';
   		htmlTmp += '</form>';
    	htmlTmp += '</div>';

    	$('#comment' + recommentId).after(htmlTmp);


	},

    //취소
    cancleRecomment:function(){
    	$("dl[name=recommentForm]").remove();
    },


    //댓글 수정 폼
 	editRecommentForm : function(commentId,recommentId,commentIdx,createDate){

 		fnObj.removeEditForm();	//수정폼 초기화

    	var c = $('#commentBox' + commentId);
    	var htmlTmp = '<div class="editFormDiv"><form name="fileForm'+commentId+'" id="fileForm'+commentId+'" class="fileForm" method="post">';
    	htmlTmp += '<div class="RippleGroup bg_on">';
    	htmlTmp += '<div class="RippleCon">';
    	htmlTmp += '<dl class="normal bg_on ' + (c.parent().parent().hasClass('ripple')?'ripple':'') + '">';		//원글의 답글 여부에 따라 ripple 클래스 추가
    	htmlTmp += '<dt><span class="name">${baseUserLoginInfo.userName}</span><span class="date">'+createDate+'</span>';
    	//비밀글
    	if(g_secretYn == 'Y') htmlTmp += '<label class="mgl15 secretArea"><input type="checkbox" id="secretYn_'+commentId+'" '+($(c).attr('secretYn') == 'Y' ? 'checked="true"' : '') +'><span>비밀글</span></label>';

    	htmlTmp += '</dt>';
    	htmlTmp += '<dd class="commentBox">';

    	htmlTmp += "<div class='txtArea'>";

   		var c_copy = c.clone();
   		$(c_copy).find('span').remove();   		//수정시 상위 댓글 입력자 이름 제거

   		var c_copy_text =  c_copy.html();
   		var c_copy_text2 = c_copy_text.split("<br>").join("\r\n");
		htmlTmp += "<textarea class='txtArea_b' placeholder='내용을 입력해주세요' title='내용입력' name='commentText' id='commentEditText'>" + c_copy_text2 + "</textarea>";
		htmlTmp += "<button type='button' onclick='javascript:fnObj.saveComment("+commentId+"," + recommentId + "," + commentIdx + ",this.form.name);return false;' class='btn_comment btn_auth'>Comment</button></div>";
		htmlTmp += '</dd>';

		htmlTmp += "<dd class='btnZone'>";
		htmlTmp += "<span><a href='#' onclick='javascript:fnObj.removeEditForm();return false;' class='btn_re_modi_cancel btn_auth'><em>수정취소</em></a></span>";
		htmlTmp += "</dd>";

		var setShow = false;

		//게시판에 파일기능 사용에만
		if(g_boardFileYn == 'Y'){

	    	htmlTmp += '<dd class="addFileList fileDisplay" id="fileTr">';
	    	htmlTmp += '<p class="titleZone">';
	    	htmlTmp += '<span id="fileInputArea'+commentId+'" class="file_btn_bg"><input name="upFile'+commentId+'" type="file" multiple onchange="fnObj.newFileUpload('+recommentId+','+commentId+');" class="file_btn_cover"></span>';


	    	htmlTmp += '</p>';
	    	htmlTmp += '<ul id="commentUploadFileList'+commentId+'" style="display:none;">';
	    	for(var i=0; i < commentList.length; i++){
				var commentMap = commentList[i];
				var commentObj = commentMap['commentList'];
				var fileList = commentMap['fileList'];
				for(k=0;k<fileList.length;k++){
					if(fileList[k]['uploadId'] == commentId){
						setShow = true;
						var fileObj = fileList[k];
						htmlTmp +='<li id="li_'+g_idx+'">' + fileObj.orgFileNm ;
						htmlTmp +='<input type="hidden" name="commentFileSeq" value="'+fileObj.fileSeq+'">' ;
						htmlTmp +='<input type="hidden" name="commentOrgFileNm" value="'+fileObj.orgFileNm+'">' ;
						htmlTmp +='<input type="hidden" name="commentNewFileNm" value="'+fileObj.newFileNm+'">' ;
						htmlTmp +='<input type="hidden" name="commentFilePath" value="'+fileObj.filePath+'">' ;
						htmlTmp +='<input type="hidden" name="commentFileSize" value="'+fileObj.fileSize+'">' ;
						htmlTmp +='<span class="num_st">' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.setDelFile('+fileObj.fileSeq+','+g_idx+');" class="fileDelete btn_auth"><em>삭제</em></a></li>';
		    			g_idx++;
					}
				}
	    	}
	    	htmlTmp += '</ul>';
   			htmlTmp += '</dd>';
		}
   		htmlTmp += '</dl>';
    	htmlTmp += '</div>';
    	htmlTmp += '</div>';
		htmlTmp += '</form></div>';
		$('#editDiv' + commentId).show();
		$('#editDiv' + commentId).parent().after(htmlTmp);
		$('#comment' + commentId).hide();
    	$('#file'+commentId).hide();

    	if(setShow) $('#commentUploadFileList'+commentId).show();
    },

    //수정 폼 초기화
    removeEditForm : function(){

    	$(".editFormDiv").hide();
    	$(".editFormDiv").empty();
    	$(".commentDiv").show();
    	$(".fileDiv").show();
    	delArray=new Array();
    	$("div[name=recommentForm]").remove();

    	$("dl[id^=comment]").show();
    },

	//코멘트 영역 숨기기 보이기
    displayComment : function(){
    	if( $('#rippleSum').hasClass('close') ){
    		$('#rippleSum').removeClass('close');
    		$('#commentListDiv').hide();
    	}
    	else{
    		$('#rippleSum').addClass('close');
    		$('#commentListDiv').show();
    	}
    },

    //승인 반송 저장
    saveApprove : function(type){


    	if(confirm((type == 'APPROVE' ? '승인' : '반송') + " 하시겠습니까?")){
	    	var param = {
	    			contentId 		: g_contentId,
	    			approveNote 	: $("#approveNote").val(),
	    			approveStatus 	: type
	    	};

	    	var url = contextRoot + "/board/saveApprove.do";
	    	var callback = function(result){
	    		var obj = JSON.parse(result);
	    		var cnt = obj.resultVal;
	    		if(cnt>0){

	   			 	document.location.reload();
	    		}
	    	}

	    	commonAjax("POST", url, param, callback, false);
    	}
    },

  	//공개기간수정
    editOpenDate : function(){

		var url = contextRoot + "/board/editOpenPeriodPop/pop.do";

		var params = {
				contentId		: g_contentInfo.contentId,
				openStartDate 	: g_contentInfo.openStartDateDash,
				openEndDate 	: g_contentInfo.openEndDateDash
		}

		myModal.open({
       		url: url,
       		pars: params,
       		titleBarText: '공개기간수정',
       		method:"POST",
       		top: 200,
       		width: 640,
       	 	closeByEscKey: true				//esc 키로 닫기
       	});

	    $('#myModalCT').draggable();

    },//end writeOpen

    /*================================================= 댓글 폼 : E ==============================================*/

};


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */


$(function(){
	fnObj.getBoardCateInfo();			//게시판 정보 가져오기
	fnObj.doSearch();					//게시판 글 정보
	fnObj.getFileList();				//게시판 글 파일리스트
	fnObj.getBoardContentPrevNext();	//게시판 이전 다음글
	fnObj.getCommentList();

});

</script>