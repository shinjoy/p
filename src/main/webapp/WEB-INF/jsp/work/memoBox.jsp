<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<input type="hidden" id="important" value="1">

<div id="pop_memo_regiwrap" >
	<!--업무일지등록-->
	<div class="modalWrap2">
		<div class="mo_container2">
			<!--채팅전체-->
			<div class="chat_window">
				<!--참가자 수신확인목록-->
				<span class="tooltip">
					<div id="joinMemberList" class="tooltip_box" style="display:none;">
						<div class="wrap_autoscroll">
							<h3 class="title">참가자 수신확인 목록</h3>
							<span class="intext">
								<table class="tb_list_basic3" id="SGridTarget">
									<colgroup>
										<col width="30" />
										<col width="*" />
										<col width="26%" span="2" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" colspan="2">이름</th>
											<th scope="col">첫글확인</th>
											<th scope="col">전체확인</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
								<ul class="list_st_dot3 mgt10">
									<li><span class="state_icon_no_check"><em>첫글</em></span> : 첫글 미확인</li>
									<li><span class="state_icon_check"><em>첫글</em></span> : 첫글 확인</li>
									<li><span class="icon_comment n_read"></span> <span class="spe_color_st6">(no)</span> : 미확인 댓글이 있을때</li>
									<li><span class="icon_comment"></span> <span class="f11 fontGray">(ok)</span> : 미확인 댓글이 없을때</li>
								</ul>
								<div class="btn_popZone2 mgt15">
									<a href="javascript:fnObj.showlayer('joinMemberList')"; class="btn_witheline">닫힘</a>
								</div>
							</span>
							<em class="edge_topleft"></em>
						</div>
					</div>
				</span>
				<div class="join_em_list">
					<div class="fl_block">
						<em class="title_icon_count" style="cursor:pointer;" onclick="javascript:fnObj.showEntryInfo('joinMemberList');"><span id="entryCnt">1</span></em>
						<em><span id="entryName">나</span></em>
					</div>

					<div id="inputDiv1" class="fr_block">
						<a href="javascript:fnObj.userPop();" class="btn_add_people"><em>사람추가</em></a>
						<a href="javascript:fnObj.doSaveMemoFixedYn('Y');" class="btn_memoFixedY" id="memoFixedY"><em>메모고정</em></a>
						<a href="javascript:fnObj.doSaveMemoFixedYn('N');" class="btn_memoFixedN" id="memoFixedN" style="display:none;"><em>메모고정해지</em></a>
					</div>
					<div id="inputDiv3" class="fr_block" style="display:none;">
                        <a href="javascript:fnObj.attendMemoRoomEntry();" class="btn_appmemo"><em>메모참여하기</em></a>
                        <!-- <span class="btn_zone"><button class="btn_s_type_g" onclick="fnObj.attendMemoRoomEntry();">메모참여하기</button></span> -->
                    </div>

				</div>
				<!--대화내용-->
				<div id="chatContent" class="chat_flow"></div>

				<!--// 대화내용 //-->

				<!--대화입력창-->
				<div id="inputDiv2" class="communi_inputBox">
					<div class="option_list">
						<span id="roomInfo" style="display:none;">
							<span>중요체크</span>
							<ul class="relationGrade" style="margin-right:10px;">
								<li><a name="important" id="important_1" href="javascript:fnObj.setImportant(1);"><em>+1</em></a></li>
								<li><a name="important" id="important_2" href="javascript:fnObj.setImportant(2);"><em>+2</em></a></li>
								<li><a name="important" id="important_3" href="javascript:fnObj.setImportant(3);"><em>+3</em></a></li>
							</ul>
							<label style="margin-right:10px;"><input type="checkbox" id="roomType" value="S"/><span>비밀글</span></label>
						</span>
						<span><label><input type="checkbox" id="sendSemeChk" /><span>SMS알림</span></label></span>
					</div>

                    <p class="file_list">
						<span id="fileInputArea" class="file_btn_bg"><input name="upFile" type="file" multiple onchange="fnObj.newFileUpload();" class="file_btn_cover"></span>
						<span  id="uploadFileList"></span>
					</p>

                    <div class="txtArea">
                    	<textarea id="comment" class="txtArea_b" placeholder="내용을 입력하세요"></textarea>
                    	<a href="javascript:fnObj.doClickSave();" class="btn_send"><em><span id="btnName">보내기</span></em></a>
                    </div>
                    <span class="btnzone" id="modifyCancle" style="display:none;">
						<span><a href="javascript:fnObj.initArea();" class="btn_re_modi_cancel"><em>수정취소</em></a></span>
					</span>
                </div>
				<!--//대화입력창//-->
			</div>
			<!--//채팅전체//-->
		</div>

	</div>
	<!--//회사상세보기(회사정보)//-->

	<!--창닫기-->
    <div class="btnZoneBox">
        <a href="javascript:window.close();" class="p_withelin_btn" >닫기</a>
    </div>
     <!--//창닫기//-->
</div>

<script type="text/javascript">

//Global variables :S ---------------

//공통코드

var myModal = new AXModal();		// instance


var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
//var mySorting = new SSorting();	// instance		new sjs


var loginUserId = '${baseUserLoginInfo.userId}';
var g_workUserId = '${workUserId}';	//업무일지 유저아이디

var g_memoRoomId ='${memoRoomId}';
var g_idx =0;
var g_memoCommentId =0;		//수정시 클릭한 메모 아이디

var g_roomObj =new Object;	//방정보
var g_entryUserList = []; 	//db 저장 유저 리스트.
var g_newUserList = [] ; 	//새로 선택 리스트
var delArray = new Array();	//저장된 파일 지운 리스트

var g_firstCommentCnt =0; 	//첫게시자의 글 갯수 카운트

var g_viewDate;

var msie = browserDetect.browser!="Explorer"?20:0;
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){


	},


	//화면세팅
    pageStart: function(){


		if(g_memoRoomId ==0){			//첫글 등록시
			$("#roomInfo").show();
			$("#memoFixedY").hide();
			$("#memoFixedN").hide();

            if('Y' == '${baseUserLoginInfo.wholeMemoViewYn}' && '${workUserCnt}' > 1) {  //2017.03.16 전체메모 권한여부의 권한이 있는경우 타인 메모 등록 가능함
            	$("#entryName").html('${workUserName}');          //참가자 이름
                $("#entryCnt").html('${workUserCnt}');   //참가자 수
            }
		}

		if(g_workUserId != loginUserId){//타인걸 볼때
			$("#memoFixedY").hide();
            $("#memoFixedN").hide();
		}

		var configObj = {


				targetID : "SGridTarget", //테이블아이디


				//그리드 컬럼 정보
				colGroup : [
				{key : ""	   		, formatter : function(obj) { 		//방장표시 1
										var str = '';
										if(obj.item.roomOwner ==1){
											str='roommaker';
										}
										return str;

									}},
				{key : ""	   		, formatter : function(obj) { 		//방장표시 2
										var str = '';
										if(obj.item.roomOwner ==1){
											str='<span class="state_icon_send"></span>';
										}
										return str;
									}},
				{key : ""			, formatter : function(obj) { 		//이름
										var str = "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+obj.item.entryUserId+"\",$(this),\"mouseover\",null,5,-0,0)'>"
											str+= '<strong>'+obj.item.userName+'</strong>';
											str+= "</span>";
										 //--- 회사가 다를때 회사명 표시
										 if(obj.item.orgId != '${baseUserLoginInfo.orgId}'){
											 str += '<em>('+obj.item.orgNm+')</em>';
										 }
										str +='</strong>';
										if(obj.item.roomOwner ==1){
											str+='<em>방장</em>';
										}
										return str;
									}},
				{key : ""		 	, formatter : function(obj) { 		//첫글 확인여부
										var str = '';
										if(obj.item.firstRead == 'Y'){
											str='<span class="state_icon_check"><em>첫글</em></span>';
										}else{
											str='<span class="state_icon_no_check"><em>첫글</em></span>';
										}
										return str;
									}},
				{key : ""		 	, formatter : function(obj) { 		//전체 확인여부
										var str = '';
										if(obj.item.noReadCount ==0){
											str='<span class="icon_comment"></span> <span class="f11 fontGray">(ok)</span>';
										}else{
											str='<span class="icon_comment n_read"></span> <span class="spe_color_st6">(no)</span>';
										}
										return str;
									}}

				],
				body : {
					onclick : function(obj, e) {

					}
				}

			};

			/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
			var rowHtmlStr = '<tr id="tr_#[0]">';
			rowHtmlStr += '<td>#[1]</td>';
			rowHtmlStr += '<td class="joinmember">#[2]</td>';
			rowHtmlStr += '<td>#[3]</td>';
			rowHtmlStr += '<td>#[4]</td>';
			rowHtmlStr += '</tr>';
			configObj.rowHtmlStr = rowHtmlStr;
			myGrid.setConfig(configObj);


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



    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(){

    	fnObj.initArea();
    	fnObj.getRoomInfo();'getMemoList'
    	fnObj.getRoomEntry();
    	fnObj.getRoomComment();
    	//parent.myModal.resize();

    },//end doSearch


    //파일선택
    selectFile: function(){
    	$('input[name="upFile"]').click();
    },


    //입력창 및 변수 초기화
    initArea : function(){
    	/* 초기화 */
    	g_memoCommentId =0 ;
    	g_idx =0;
    	g_roomObj =new Object;			//방정보
    	g_entryUserList = []; 			//db 저장 유저 리스트.
    	g_newUserList = [] ; 			//새로 선택 리스트
    	delArray = new Array();			//저장된 파일 지운 리스트
    	$("#uploadFileList").empty();	//파일리스트비우고
    	$("#comment").val('');			//내용지우고
    	$("#btnName").html("보내기");
    	$("#memoFixedY").show();
    	$("#modifyCancle").hide();

    },

    //방정보 가져오기
    getRoomInfo : function(){

    	var url = contextRoot + "/work/getRoomInfo.do";
    	var param = { memoRoomId : g_memoRoomId };

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		var list = obj.resultList;
    		g_roomObj = list[0];

    		//비밀글 중요도 display설정
    		fnObj.setImportant(g_roomObj.important);
    		if(g_roomObj.roomType == 'S')$("#roomType").prop("checked",true);

    		g_viewDate = g_roomObj.viewDate;

    		//내가 방장일때만 방정보를 바꿀수 있다.
    		if(g_roomObj.createdBy == loginUserId){
    			$("#roomInfo").show();
    		}
    	};
    	commonAjax("POST", url, param, callback, false);
    },

  	//참가자 정보 가져오기
    getRoomEntry : function(){

    	var url = contextRoot + "/work/getRoomEntryList.do";
    	var param = { memoRoomId : g_memoRoomId };

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		var list = obj.resultList;

    		var str ='';

    		//var entryUserCnt = 0;
    		var isEntry = false;   //참여자인경우만 메모등록 가능함
    		var memoFixedYn = "N";  //메모확인자의 메모고정여부
    		for(var i=0; i<list.length;i++){
    			if(list[i].entryUserId == '${baseUserLoginInfo.userId}'){
    				isEntry = true;
    				memoFixedYn = list[i].memoFixedYn;
    			}
    			g_entryUserList.push(list[i].entryUserId);
    			if(loginUserId == g_workUserId && list.length == 1 && list[i].entryUserId == loginUserId){				//나만등록한 메모
						str='나';

				}else{
					if(i<7){
						str += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].entryUserId+"\",$(this),\"mouseover\",null,5,-40,40)'>";
					}else{
						str += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].entryUserId+"\",$(this),\"mouseover\",null,5,-200,200)'>";
					}
					str+=list[i].userName;
					str+="</span>";

	        		if(i<list.length-1){
	        			str+=',';
	        		}

	        		//entryUserCnt++;
				}

    		}

    		//참여자인경우만 메모등록 가능함
   			if(isEntry){
   				$("#inputDiv1").show();
   				$("#inputDiv2").show();
   				$("#inputDiv3").hide();

   			   //메모고정여부에 따른 버튼 처리
   	            if(memoFixedYn == "Y"){
   	            	$("#memoFixedY").hide();
   	            	$("#memoFixedN").show();
   	            }else{
   	            	$("#memoFixedY").show();
                    $("#memoFixedN").hide();
   	            }

   				window.resizeTo(750, 870+msie);
   			}else{
   				if('${baseUserLoginInfo.vipAuthYn}' == "Y"){  //특별권한자 참여하기 버튼
   					$("#inputDiv1").hide();
                    $("#inputDiv2").hide();
   					$("#inputDiv3").show();
   				}else{  //메모참여자가 아닌경우
   					$("#inputDiv1").hide();
   	                $("#inputDiv2").hide();
   	                $("#inputDiv3").hide()
   				}
   				window.resizeTo(750, 680+msie);
   			}



    		/* if(str.length>40){
    			str = str.substring(0,40)+'...';
    		} */


    		/* if(entryUserCnt>11){
    			str += '...';
    		} */
    		$("#entryName").html(str);			//참가자 이름
    		$("#entryCnt").html(list.length);	//참가자 수

    		myGrid.setGridData({ //그리드 데이터 세팅	*** 2 ***
				list : list 	 //그리드 테이터
			});
    	};
    	commonAjax("POST", url, param, callback, false);
    },

  	//글 리스트 (대화창 세팅)
    getRoomComment : function(){

    	var url = contextRoot + "/work/getRoomMemoList.do";
    	var param = { memoRoomId : g_memoRoomId };

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		var list = obj.resultList;

    		var oneChat = '';
 	        var preUserId = '';
 	        var timeLineDay = '';
 	        g_firstCommentCnt =0;		//초기화
 	        var firstUserId ='';
 	        var firstCommentCnt =0;
 	        //채팅창 초기화
 	        var chatObj = $('#chatContent');
	        chatObj.html('');
	        chatObj.append('<div style="color:#f56060;font-weight:bold;"><font color=#f56060>메모지정일 : '+g_viewDate+'</div>');

 	        for(var i=0; i<list.length; i++){

 	        	if(list[i].createDate.substr(0,10) != timeLineDay && list[i].type == 'COMMENT'){			//새로운 날일때 날짜 추가
 	        		timeLineDay = list[i].createDate.substr(0,10);
 	        		var timeArr = timeLineDay.split("-");
 	        		chatObj.append('<p class="flow_date"><span>' + timeArr[0]+'년 '+timeArr[1]+'월 '+timeArr[2]+'일 '+(timeLineDay==new Date().yyyy_mm_dd()?' (오늘)':getWeekName(timeArr[0],timeArr[1],timeArr[2])+'요일')  + '</span></p>');		//time line 추가

 	        		preNm = '';		//이름 초기화 (날이 달라져서 타임라인이 찍히면 무조건 이름을 찍어준다.)
 	        		preUserId='';
 	        	}

 	        	//---------마지막글 삭제에 필요한 로직 추가
 	        	if(i == 0){							//첫번째 글의 유저아이디
 	        		firstUserId = list[i].userId;
 	        	}

 	        	if(firstUserId == list[i].userId && list[i].type != 'FILE'){	//첫번째 유저아이디랑 글의 유저아이디가 같다면 ++
 	        		firstCommentCnt++;
 	        	}else{								//아니면 초기화... 더이상 카운트 하지 않는다.
 	        		firstUserId ='';
 	        	}

 	        	if(list[i].type == 'COMMENT'){	// 메모 ----------------------

 	        		oneChat = '<div class="communiBox';
 		        	if(list[i].userId == loginUserId)
 						oneChat += 'Rignt">';				//내가 쓴글(오른쪽)
 					else
 						oneChat += '">';					//다른이 글(왼쪽)
 					//
 					oneChat += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].userId+"\",$(this),\"mouseover\",null,10,0,0)'>";
 					if(preUserId != list[i].userId && list[i].userId != loginUserId ){
 						if(list[i].imgNm != '' ) oneChat += '<div class="pic"><img class="userImg" src="/imgUpLoadData/'+list[i].imgNm+'" alt="'+list[i].name+'"/></div>';
 						else oneChat += '<div class="pic"></div>';
 					}
 					oneChat +="</span>";

 					oneChat += '<ul class="conBox"><li class="nametime">';
 					if(preUserId != list[i].userId && list[i].userId != loginUserId){
 						oneChat += '<strong>' + list[i].name + '</strong>';
 	 					if('${baseUserLoginInfo.orgId}'!= list[i].orgId){
 	 						oneChat += '<span>('+list[i].companyNm+')</span>';
 	 					}

 					}

 					oneChat += '<span>' + list[i].createDate.substr(10) + '</span><span class="count">'+(list[i].noReadCount == 0 ? '' : list[i].noReadCount)+'</span></li>';
 					oneChat += '<li class="bubble"><span class="arrow"></span>';

 					var commentStr = list[i].comment;

 					if(commentStr.indexOf('<em>[상세보기]</em>')<0){

 						commentStr = devUtil.fn_escapeReplace(commentStr);

 						if(commentStr.indexOf('##moveCommonWbsPage($')>-1){
 							var commentStrBuf = commentStr.split("##moveCommonWbsPage($");

 							var projectId = commentStrBuf[1].substring(0,commentStrBuf[1].indexOf('$'));
 							commentStr = commentStrBuf[0];

 							commentStr+= "<span style=\"cursor: pointer;text-decoration: underline;color: #5882FA\" onclick=\"moveCommonWbsPage("+projectId+");\"><em>[상세보기]</em></span>";
 						}
 					}



 					oneChat += '<p>'+commentStr.replace(/(?:\r\n|\r|\n)/g, '<br />'); + '</p>';

 					if(list[i].userId == loginUserId && list[i].readCount == 0){
 						oneChat += '<span class="btnzone"><a href="javascript:fnObj.getCommentInfo('+list[i].memoCommentId+');" class="btn_re_edit"><em>수정</em></a>';
 						oneChat += '<a href="javascript:fnObj.doChkDeleteComment('+list[i].memoCommentId+',\''+firstUserId+'\');" class="btn_re_delete"><em>삭제</em></a></span>';

 					}

 					oneChat +='</li></ul></div>';

 	        	}else if(list[i].type == 'FILE'){		// 파일 ---------------------------------------

 	        		oneChat = '<p class="flow_filedown">' + list[i].name + '님이 <a href="javascript:fnObj.fileDownComment(\'';
 	        		oneChat += list[i].memoCommentId + '\');">' + list[i].comment + '</a> 파일을 보냈습니다.</p>';

 	        	}else if(list[i].type == 'OUT'){		// 나가기 ---------------------------------------

 	        		oneChat = '<p class="flow_filedown">' + list[i].name + '님이 대화에서 나갔습니다.</p>';
 	        	}

 	        	preUserId = list[i].userId;


 				chatObj.append(oneChat);					//한건의 채팅 메모 추가
 	        }

 	        g_firstCommentCnt =firstCommentCnt;

 	        //채팅창 스크롤 가장아래로 ...최신것보이게
 	        chatObj[0].scrollTop = chatObj[0].scrollHeight;

    	};
    	commonAjax("POST", url, param, callback, false);

    },

    //글 하나의 정보
    getCommentInfo : function(memoCommentId){
    	$("#btnName").html("수정");
    	var url = contextRoot + "/work/getCommentInfo.do";
    	var param = { memoCommentId : memoCommentId };

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		var list = obj.resultList;

    		if(cnt>0){
    			$("#comment").val(list[0].comment);
    		}
    		fnObj.getFileList(memoCommentId);
    		g_memoCommentId = memoCommentId;
    		$("#modifyCancle").show();

    	};
    	commonAjax("POST", url, param, callback, false);

    },

    //첨부파일 리스트
    getFileList : function(memoCommentId){
    	var url = contextRoot + "/file/getFileList.do";
    	var param = {
    					uploadId 	: memoCommentId,
    					uploadType  : 'MEMO'
    				}

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var list = obj.resultList;
    		var str = '';
    		saveFileList = list;
    		if(list.length>0){
	    		for(var i=0;i<list.length;i++){

	    			var fileObj = list[i];
	    			str +='<span class="file_name" id="li_'+g_idx+'">' + fileObj.orgFileNm ;
	    			str +='<input type="hidden" name="fileSeq" value="'+fileObj.fileSeq+'">' ;
	    			str +='<input type="hidden" name="orgFileNm" value="'+fileObj.orgFileNm+'">' ;
	    			str +='<input type="hidden" name="newFileNm" value="'+fileObj.newFileNm+'">' ;
	    			str +='<input type="hidden" name="filePath" value="'+fileObj.filePath+'">' ;
	    			str +='<input type="hidden" name="fileSize" value="'+fileObj.fileSize+'">' ;
	    			str +='<a href="javascript:fnObj.setDelFile('+fileObj.fileSeq+','+g_idx+');" class="btn_delete_employee"><em>삭제</em></a>,</span>';
	    			g_idx++;
				}
	    		$('#uploadFileList').html(str);
    		}
    	}
    	commonAjax("POST", url, param, callback, false);
    },

  	//신규 파일 등록시
  	newFileUpload : function(){


   		var url = contextRoot+"/file/uploadFiles.do"


   		var callback = function(result){



   			var list = result.resultList;
   			var str='';
   			for(var i=0;i<list.length;i++){
   				var fileObj = list[i];
   				str +='<span class="file_name" id="li_'+g_idx+'" class="file_name">' + fileObj.orgFileNm ;
   				str +='<input type="hidden" name="fileSeq" value="0">' ;
   				str +='<input type="hidden" name="orgFileNm" value="'+fileObj.orgFileNm+'">' ;
   				str +='<input type="hidden" name="newFileNm" value="'+fileObj.newFileNm+'">' ;
   				str +='<input type="hidden" name="filePath" value="'+fileObj.filePath+'">' ;
   				str +='<input type="hidden" name="fileSize" value="'+fileObj.fileSize+'">' ;
   				str +='<a href="javascript:fnObj.newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+');" class="btn_delete_employee"><em>삭제</em></a>,</span>';
   				g_idx++;


   			}

   			//파일 태그 재 생성.
   			$('#fileInputArea').append('<input name="upFile" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload();">');


   			$('#uploadFileList').append(str);

   			fnObj.windowResize(); //화면 리사이징

   		}

   		commonAjaxForFileCreateForm(url,"","upFile","100","fileSize", callback , "",'','');

  	},

  	windowResize : function(){
  		var heightOffset = window.outerHeight - window.innerHeight;
        var widthOffset = window.outerWidth - window.innerWidth;
        var height = document.getElementById("pop_memo_regiwrap").clientHeight + heightOffset;
        var width = document.getElementById("pop_memo_regiwrap").clientWidth + widthOffset;
        window.resizeTo(width, height);
  	},



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

    //수정시 db 에 이미 저장된 파일삭제 할땐. 바로삭제하지않고 리스트를 만든다.
    setDelFile: function(fileSeq,idx){

    	delArray.push(fileSeq);
    	$("#li_"+idx).remove();
    },//end setDelFile

  	//댓글 파일 다운로드
    fileDownComment : function(fileSeq){
    	url = contextRoot + "/file/downFile.do?uploadType=MEMO&downFileList="+fileSeq;
    	window.open(url);
    },

    //별표세팅
    setImportant : function(val){
    	 var starList = $(".on").length;

    	 $(".on").removeClass("on");

    	 for(var i=1;i<=val;i++){
    		 $("#important_"+i).addClass("on");
    	 }
    	 if(val == 1 && starList ==1){
			 $("#important_1").removeClass("on");
		 }

     },

     //저장 버튼 클릭
     doClickSave : function(){
    	//내가쓴건지 타인이쓴건지 판별

    	if(g_memoRoomId == 0 || g_roomObj.createdBy == loginUserId){		//신규등록이거나 내가씀
    		fnObj.doSaveRoom();
    	}else{
    		fnObj.doSaveComment(g_memoRoomId);
		}

     },


     //방생성 및 수정
     doSaveRoom : function(){

    	 var memoRoomId =g_memoRoomId;
    	 var important =0;
    	 var starList = $("a[name=important]");

    	 for(var i=0;i<starList.length;i++){
    		if($(starList[i]).hasClass("on")){
    			important++;
    		}
    	 }

    	var comment = $("#comment").val();


     	if(comment == ''){
     		alert("내용을 입력해 주세요.");
     		return false;
     	}

    	 var chk = $("#roomType").is(":checked");
    	 var roomType = (chk ==true ? 'S' : 'N');

    	 var url =contextRoot + "/work/saveMemoRoom.do";

    	 var param = {
    			 memoRoomId 	: memoRoomId ,
    			 important 		: important,
    			 roomType		: roomType,
    			 viewDate		: '${viewDate}'
    	 };

    	 var callback = function(result){
     		var obj = JSON.parse(result);
     		var memoRoomId = obj.resultVal;
     		if(memoRoomId>0){
     			if(g_memoRoomId ==0){					//첫글 등록이면, 참가자 넣기 , 글 등록하기

     				fnObj.doSaveEntry(memoRoomId);
     				fnObj.doSaveComment(memoRoomId);

     			}else{									//아니면, 글 등록만..
     				fnObj.doSaveComment(memoRoomId);
     			}
     		}else{
     			dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
     		}


     	};

     	commonAjax("POST", url, param, callback, false);


     },

     //2017.09.08 대표이사/회장/시너지 권한자에게 메모참여하기 기능추가
     attendMemoRoomEntry : function(){
    	 if(confirm("현재 메모에 참여하시겠습니까?")){
    		 g_newUserList.push('${baseUserLoginInfo.userId}');

             var str ='';

             if(g_newUserList.length < 7){
                 str += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+"${baseUserLoginInfo.userId}"+"\",$(this),\"mouseover\",null,5,-40,40)'>";
             }else{
                 str += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+"${baseUserLoginInfo.userId}"+"\",$(this),\"mouseover\",null,5,-200,200)'>";
             }
             str+= "${baseUserLoginInfo.userName}";
             str+="</span>";

             $("#entryName").html(str);          //참가자 이름
             $("#entryCnt").html(g_newUserList.length+1); //참가자 수

             if(g_memoRoomId>0){                 //신규가 아닐때 바로 등록
                 fnObj.doSaveEntry(g_memoRoomId);
                 fnObj.getRoomEntry();
                 fnObj.doSearch();
             }
             //유저프로필 이벤트 셋팅
             initUserProfileEvent();

          	 //메모영역 url자동링크
         	 autolink($(".bubble"));
             window.resizeTo(750, 850+msie+msie);
    	 }

     },


     //참가자 등록
     doSaveEntry : function(memoRoomId){
    	 var entryUserList =[];		//등록 리스트
		 var deleteUserList =[];	//삭제 리스트

		 if(g_memoRoomId == 0){		//첫글 등록시
			 if(getArrayIndexWithValue(g_newUserList, loginUserId)<0){
				 if('Y' == '${baseUserLoginInfo.wholeMemoViewYn}' && '${workUserCnt}' > 1) {  //2017.03.16 전체메모 권한여부의 권한이 있는경우 타인 메모 등록 가능함
					 entryUserList.push('${arrWorkUserId}');  //
				 }else{
					 entryUserList.push(loginUserId);  // 작성자 = 나 무조건 참가자로 등록 첫등록
				 }
			 }
		 }

		for(var i=0 ; i<g_newUserList.length; i++){
			if(getArrayIndexWithValue(g_entryUserList, g_newUserList[i])<0){				//참가자 리스트에 신규로 등록한 사람이 없으면, 등록
				entryUserList.push(g_newUserList[i]);
			 }
		 }
		 g_entryUserList = entryUserList;
		 var url =contextRoot + "/work/saveRoomEntry.do";

    	 var param = {
    			 memoRoomId 			: memoRoomId,
    			 entryUserList 			: entryUserList.join(","),
    			 deleteUserList			: deleteUserList.join(",")
    	 };

    	 var callback = function(result){
    		 if(g_memoRoomId >0){
    			 toast.push("완료되었습니다.");

    			if(opener.parent.memoObj != undefined){
    				 opener.parent.memoObj.getMemoList();
     			}else{

     				if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
     					if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
     						if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
	     						opener.parent.fnObj.doSearch(g_workUserId);
     						}
     					}
     				}
     			}

    		}

    	 }

    	 commonAjax("POST", url, param, callback, false);

     },

     //글 등록
     doSaveComment : function(memoRoomId){
    	var fileList ='';
    	var delFileList='';
    	var comment = $("#comment").val();


    	if(comment == ''){
    		alert("내용을 입력해 주세요.");
    		return false;
    	}


    	/*=========== 첨부파일 : S =========== */
     	var fileSeqList 	= $("input[name=fileSeq]");			//시퀀스 리스트
     	var orgFileNmList 	= $("input[name=orgFileNm]");		//파일명 리스트
     	var newFileNmList 	= $("input[name=newFileNm]");		//새로운 저장 파일명 리스트
     	var filePathList 	= $("input[name=filePath]");		//경로 리스트
     	var fileSizeList 	= $("input[name=fileSize]");		//파일 크기 리스트
     	var jArray = new Array();

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
 				jobj.uploadType='MEMO';
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
 		/*=========== 첨부파일 : E =========== */


 		var url =contextRoot + "/work/saveMemoComment.do";

    	 var param = {
    			 memoRoomId 			: memoRoomId,
    			 memoCommentId			: g_memoCommentId,
    			 fileList 				: fileList,
    			 comment				: comment,
    			 delFileList			: delFileList				//수정시 삭제한 파일들의 시퀀스 리스트
    	 };

    	 var callback = function(result){
    		var obj = JSON.parse(result);
      		var cnt = obj.resultVal;
    	 	if(cnt>0){

    	 		g_memoRoomId = memoRoomId;


    	 		if($("#sendSemeChk").is(":checked")){		//문자전송 체크시
    	 			fnObj.doSendSms();
        	 	}
    	 		fnObj.doSaveLastReadDate("N");
    	 	}else{
    	 		dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
    	 	}

     		//메모영역 url자동링크
     		autolink($(".bubble"));

    	 }

    	 commonAjax("POST", url, param, callback, false);

     },

     //문자전송
     doSendSms : function(){


    	 //미래메모인지 체크한다
    	 var now = new Date();

    	 var nowStr = now.yyyymmdd();

    	 var reserveDate = getTimeStampStr();
    	 if(parseInt(nowStr)<parseInt("${fn:replace(viewDate,'-','')}")){
    		 reserveDate = "${fn:replace(viewDate,'-','')}"+"090000";
    	 }

    	 var comment = '[메모][작성자:'+'${baseUserLoginInfo.userName}' + ']'+$("#comment").val();

    	 if(comment.length > 70){
    		 comment=comment.substring(0,70)+"...";
    	 }
    	 var url = contextRoot + "/sms/sendSms.do";
    	 var param = {
    			 sendUserId		:	'${baseUserLoginInfo.userId}',	//보내는이
    			 userIdList		:	g_entryUserList.join(","),		//문자를 받을 유저 아이디(직원)
    			 customerList	:	'',								//문자를 받을 유저 아이디(고객)
    			 content		:	comment,						//문자내용
    			 reserveDate	:	reserveDate,					//날짜
    			 type			:	''								//특별한 케이스일경우 타입을 추가해 서비스에서 처리해주면 된다.(대표번호로 보내기)

	     }

    	 var callback = function(result){

	      		var obj = JSON.parse(result);
	      		var cnt = obj.resultVal;		//결과수

	     };

	     commonAjax("POST", url, param, callback, false);


     },

     //글 삭제 전 첫글 여부 판별
     doChkDeleteComment : function(memoCommentId,firstId){
    	if(firstId != '' && g_firstCommentCnt == 1){	//룸 생성자의 첫번째 글이면
    		fnObj.doDeleteFirstComment(memoCommentId);	//방 삭제 로직으로...
    	}else{											//이외 일반 글 삭제
    		fnObj.doDeleteComment(memoCommentId);
    	}

     },

     //글삭제
     doDeleteComment : function(memoCommentId){

     	var url = contextRoot + "/work/deleteComment.do";
     	var param = {
     			 memoCommentId 	: memoCommentId,
     			 uploadId 		: memoCommentId,
     			 uploadType 	: 'MEMO'
     	}
     	var callback = function(result){

     		var obj = JSON.parse(result);
     		var cnt = obj.resultVal;		//결과수

     		if(cnt > 0){
     			//toast.push("삭제되었습니다.");
     			fnObj.doSearch();	//목록화면 재조회 호출.

     		}else{
     			alert("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
     		}

     	};

     	commonAjax("POST", url, param, callback);

     },

     //첫글 삭제
     doDeleteFirstComment : function(memoCommentId){

    	if(!confirm("해당 글을 삭제하면 참가자 및 모든 목록에서 삭제됩니다. 삭제하시겠습니까?")){
    		return false;
    	}
      	var url = contextRoot + "/work/doDeleteFirstComment.do";
      	var param = {
      			 memoRoomId		: g_memoRoomId,
      			 uploadId 		: memoCommentId,
      			 uploadType 	: 'MEMO'
      	}
      	var callback = function(result){

      		var obj = JSON.parse(result);
      		var cnt = obj.resultVal;		//결과수

      		if(cnt == 0){
      			alert("삭제되었습니다.");

      			window.close();
      			if(opener.parent.memoObj != undefined){
      				 opener.parent.memoObj.getMemoList();
       			}else{
       				if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
       					if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
       						opener.parent.fnObj.doSearch(g_workUserId);
       					}
       				}
       			}


      		}else{
      			alert("다른 사람이 이미 글을 읽어 삭제할수 없습니다.");
      		}

      	};

      	commonAjax("POST", url, param, callback);

     },

   	 //읽음 업데이트
     doSaveLastReadDate : function(isFirst){

 		var url =contextRoot + "/work/saveLastReadDate.do";

    	 var param = {
    			 memoRoomId  : g_memoRoomId
    	};

    	 var callback = function(result){
    		var obj = JSON.parse(result);
      		var cnt = obj.resultVal;
    	 	if(cnt>0){
    	 		if(isFirst == "N"){
    	 			toast.push("완료되었습니다.");
                    fnObj.doSearch();
    	 		}
    	 		if(opener.parent.memoObj != undefined){
   				 opener.parent.memoObj.getMemoList();
    			}else{
    				if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
    					if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
    						opener.parent.fnObj.doSearch(g_workUserId,'N');
    					}
    				}
    			}
    	 	}else{
    	 		dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
    	 	}

    	 }

    	 commonAjax("POST", url, param, callback, false);

     },

   //메모고정여부 업데이트
     doSaveMemoFixedYn : function(memoFixedYn){

        var url =contextRoot + "/work/saveMemoFixedYn.do";

         var param = {
                 memoRoomId  : g_memoRoomId,
                 memoFixedYn : memoFixedYn
        };

         var callback = function(result){
            var obj = JSON.parse(result);
            var cnt = obj.resultVal;
            if(cnt>0){
                toast.push("완료되었습니다.");
                fnObj.doSearch();
                if(opener.parent.memoObj != undefined){
                 opener.parent.memoObj.getMemoList();
                }else{
                    if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
                        if(opener.parent.isWorkDailyPage != undefined&&opener.parent.isWorkDailyPage){
                            opener.parent.fnObj.doSearch(g_workUserId,'N');
                        }
                    }
                }
            }else{
                dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
            }

         }

         commonAjax("POST", url, param, callback, false);

     },

     //유저선택 공통 팝업
     userPop : function(){

       var selectUserList = [];
       var disabledList =[];
       if(g_memoRoomId == 0){				//신규등록시
    	   selectUserList = g_newUserList ;
    	  if(getArrayIndexWithValue(g_newUserList, loginUserId)<0)	{
    		  if('Y' == '${baseUserLoginInfo.wholeMemoViewYn}' && '${workUserCnt}' > 1) {  //2017.03.16 전체메모 권한여부의 권한이 있는경우 타인 메모 등록 가능함
    			  selectUserList.push('${arrWorkUserId}');  //
              }else{
            	  selectUserList.push(loginUserId);    //나 무조건
              }
    	   }
    	   disabledList.push(loginUserId);
       }else{
    	   selectUserList = g_entryUserList ;
    	   disabledList  = g_entryUserList ;
       }


       var paramList = [];
       var paramObj ={ name : 'userList'   ,value : selectUserList};
       paramList.push(paramObj);
       paramObj ={ name : 'disabledList'   ,value : disabledList};
       paramList.push(paramObj);
       paramObj ={ name : 'isAllOrg' ,value : 'Y'};
       paramList.push(paramObj);
       paramObj ={ name : 'isAllOrgSelect' ,value : 'Y'};
       paramList.push(paramObj);
       paramObj ={ name : 'isCheckDisable' ,value : 'N'};
       paramList.push(paramObj);

       paramObj ={ name : 'isUserGroup' ,value : 'Y'};
       paramList.push(paramObj);

       paramObj ={ name : 'hasDeptTopLevel' ,value : 'Y'};
       paramList.push(paramObj);  //부서의 회장 부서 표시여부

       userSelectPopCall(paramList);		//공통 선택 팝업 호출
    },

  	//직원 선택
  	getResult : function(resultList){
  		g_newUserList =[];
  		var str ='';
  		for(var i=0;i<resultList.length;i++){
  			g_newUserList.push(resultList[i].userId);

  			if(i<7){
				str += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+resultList[i].userId+"\",$(this),\"mouseover\",null,5,-40,40)'>";
			}else{
				str += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+resultList[i].userId+"\",$(this),\"mouseover\",null,5,-200,200)'>";
			}
  			str+=resultList[i].userName;
  			str+="</span>";
    		if(i<resultList.length-1){
    				str+=',';
    		}
    		if(resultList.length == 1) str ='나';

    		$("#entryName").html(str);			//참가자 이름
    		$("#entryCnt").html(resultList.length);	//참가자 수
  		}
  		if(g_memoRoomId>0){					//신규가 아닐때 바로 등록

  			fnObj.doSaveEntry(g_memoRoomId);
  			fnObj.getRoomEntry();
  			//fnObj.doSearch();
  		}

    	//유저프로필 이벤트 셋팅
    	initUserProfileEvent();

    	//메모영역 url자동링크
    	autolink($(".bubble"));
  	},

  	//참가자 툴팁
  	showEntryInfo : function(obj){

  		//fnObj.getRoomEntry();
  	  	if($("#entryCnt").text()>1 && g_memoRoomId>0 ) fnObj.showlayer(obj); 		//레이어 세팅 신규가 아니고 참가자가 1 이상일떄

  	},

  	showlayer : function(obj){
  		if($("#"+obj).css("display") == 'none'){ $("#"+obj).css("display","block");}
 		else{$("#"+obj).css("display","none");}
  	}




     ////////////////////////////////////////////////////////////////////////////////////////////////////////



  	//################# else function :E #################



};//end fnObj.





/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();		//공통코드 or 각종선로딩코드
	fnObj.pageStart();			//화면세팅
	if('${memoRoomId}'>0){		//메모 방 정보
		fnObj.getRoomInfo();
		fnObj.getRoomEntry();
    	fnObj.getRoomComment();
    	fnObj.doSaveLastReadDate("Y");  //메모확인 들어오면 무조건 메모확인된걸로 함
    	//$('.userImg').imageTooltip();
	}else{
		window.resizeTo(750, 870+msie);
	}
	//유저프로필 이벤트 셋팅
	initUserProfileEvent();

	//메모영역 url자동링크
	autolink($(".bubble"));
});

//wbs화면으로 이동
function moveCommonWbsPage(projectId){
	opener.location.href = contextRoot + "/project/projectStatusDetail.do?pId="+projectId+"&type=memo";

}
</script>