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

<form name="viewerFrm" id="viewerFrm" action="" method="post">
<input type="hidden" name="userStr"  id="userStr"/>
<input type="hidden" name="disabledStr"  id="disabledStr"/>
<input type="hidden" name="activityId"  id="activityId"/>
<input type="hidden" name="projectId"  id="projectId"/>
<input type="hidden" name="employee"  id="employee"/>
<input type="hidden" name="openFlag"  id="openFlag"/>
<input type="text" name="tempInput"  id="tempInput" /> <!--  //화면이 포커스를 잃어서 임의로 설정 2017.04.17 이인희 -->

</form>

<form name="downForm" id="downForm"></form>

<div id="progressTxtArea" style="display:none;"></div>
	<div class="modalWrap2">

		<div class="mo_container2">
			<div class="teamView_allWrap">
				<!--팀리더뷰-->
				<div class="leaderViewWrap">
					<!--타이틀-->
					<div class="titleZone">
						<h3 class="h3_title">Team Leader View</h3>
						<span class="team_leader" id="leaderNameArea"></span>
					</div>
					<!--//타이틀//-->

					<!--상세내용-->
					<div class="leaderconWrap" id="detailArea">
						<h4 class="h4_view_title">
							<span class="icon_teamwork_b"><em>team</em></span>
							<span id="important"></span><span id="titleArea">관계사 관리시스템</span>
							<span class="icon_new"><em>new</em></span>
						</h4>
						<table class="tb_view_simple" id="SGridTarget" summary="일정등록 (기안자, 흐름도, 요약) 안내">
							<caption>업무일지상세보기</caption>
							<colgroup>
								<col width="75" />
								<col width="*" />
							</colgroup>
							<tbody>
							</tbody>
						</table>
						<div class="btnZoneBox" id="leaderBtnArea">
							<!-- <a id="endBtn" href="javascript:fnObj.endWorkDaily('Y');" class="p_blueblack_btn"><strong>종료처리</strong></a>
							<a id="cancelBtn" href="javascript:fnObj.endWorkDaily('N');" class="p_withelin_btn"><strong>종료처리취소</strong></a> -->
							<a id="editBtn" href="javascript:fnObj.editDisplay();" class="p_blueblack_btn btn_auth"><strong>수정</strong></a>
							<a id="deleteBtn" href="javascript:fnObj.deleteWorkDaily();" class="p_blueblack2_btn btn_auth"><strong>삭제</strong></a>
						</div>
					</div>
					<!--//상세내용//-->
					<!--수정 뷰-->
					<div class="leaderconWrap"  id="editArea" style="display:none;">

						<table class="tb_basic_left" id="SGridTarget2" summary="일정등록 (기안자, 흐름도, 요약) 안내">
							<caption>업무일지상세보기</caption>
							<colgroup>
								<col width="100" />
								<col width="*" />
							</colgroup>
							<tbody>
							</tbody>
						</table>
						<div class="btnZoneBox">
							<a id="saveBtn" href="javascript:fnObj.editDaily();" class="p_blueblack_btn"><strong>저장</strong></a>
							<a id="editCancelBtn" href="javascript:fnObj.editDisplay();" class="p_withelin_btn"><strong>수정취소</strong></a>
						</div>
					</div>
					<!--//수정 뷰//-->
				</div>
				<!--//팀리더뷰//-->

				<!--팀멤버뷰-->
				<div class="t_memberViewWrap">
					<!--타이틀-->
					<div class="titleZone">
						<h3 class="h3_title">Team Members View</h3>
						<span class="team_members">전체 (<strong><span id="userCountArea"></span></strong>)</span>
					</div>
					<!--//타이틀//-->

					<!--팀멤버상세보기-->
					<div class="t_memberconWrap">
						<!--멤버리스트-->
						<div class="showall_mList">
							<p><span class="divline">Member</span><span id="userNameArea"></span></p>
							<div class="state_remark">
								<span class="st_ing">계획/진행</span>
								<span class="st_finish">완료</span>
								<span class="st_drop">보류</span>
							</div>
						</div>
						<!--//멤버리스트//-->

						<!--멤버상세 내용 -->
						<div id="userDetailArea"></div>

					</div>
					<!--//팀멤버상세보기//-->
				</div>
				<!--//팀멤버뷰//-->
			</div>

			<div class="btnZoneBox">
				<a href="javascript:parent.myModal.close();"  class="p_grayline_btn">닫기</a>
			</div>

		</div>
	</div>

<script type="text/javascript">

//Global variables :S ---------------

//공통코드

var myModal = new AXModal();		// instance


var myGrid = new SGrid();		// instance		new sjs
var myGrid2 = new SGrid();		// instance		new sjs


var loginUserId = '${baseUserLoginInfo.userId}';
var g_workUserId = '${workUserId}';				//업무일지 유저아이디
var g_listId = '${listId}';						//업무일지 아이디(seq)

var g_workDate = '${workDate}';					//선택 날짜
var g_openType ='${openType}';					//VIEW or EDIT
var g_idx =0;

var g_entryUserList = []; 						//선택한 유저 리스트.

var g_leaderMemoList = [];						//리더메모 정보 리스트
var g_teamMemoList = [];						//팀메모 정보 리스트

var g_leaderMemoListNew = [];                      //시용자메모목록
var g_teamMemoListNew = [];                      //팀메모목록
var g_workReaderList = [];

var g_readerType = "";

var progressSelect ='';
var leaderProgressSelect ='';

var g_separator ='VII@';						//메모저장시 구분자 추가

var g_readerTypeTag ="";

var g_popType = "";


//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
 var fnObj = {

	preloadCode : function(){
		parent.myModal.resize();

		//$("#myModalCT_close").attr('id', 'dd')


		if(g_openType =='EDIT'){
			$("#editArea").show();
			$("#detailArea").hide();
		}

		//공통코드조회
        var comCodeType = getBaseCommonCode('WORK_READER_TYPE', null, 'CD', 'NM', null, null, null, { orgId : "${baseUserLoginInfo.applyOrgId}" });
        //라디오박스 생성
        g_readerTypeTag = createRadioTag('readerType', comCodeType, 'CD', 'NM', null, null, null, 'fnObj.clickReaderType(this)');    //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)

	},

	pageStart : function(){

		//-------------------------- 그리드 설정 :S ----------------------------
		/* 그리드 설정정보 */
		var configObj = {


			targetID : "SGridTarget", //테이블아이디


			//그리드 컬럼 정보
			colGroup : [
			{key : "project"      , formatter : function(obj) {
			    var str = "<div><strong>";
			    str += "["+obj.item.projectNm+"-";
			    str += obj.item.activityNm+"]</strong> 기간 : "+obj.item.activityStartDate+" ~ "+obj.item.lastDate+"</div>";

			    return str;
			}},
			{key : "workDate"	 , formatter : function(obj) {

										var workDate = obj.item.workDate;			//시작일
										var completeDate = obj.item.completeDate;	//종료일
										var nowDate = new Date().yyyy_mm_dd();

										var lastDay = '';

										var str ='  '+workDate.replace(/-/gi,'/')+' ~ ';
										if(completeDate == '' || obj.item.complete == 'N'){ //작업 완료일이 없으면,
											str +='미정 ';
											lastDay = nowDate;

										}else{
											str +=' '+completeDate.replace(/-/gi,'/');
											lastDay = completeDate;
										}
										var diff = diffDay(lastDay,workDate);

										str += '<span class="work_date" style="padding-left:5px;">(';
										if(diff == 0){
											str += '당일';
										}else if(diff > 0){
											str += '+'+diff;
										}else{
											if( new Date().yyyy_mm_dd() <= lastDay && obj.item.complete == 'Y'){
												str += '완료';
											}else{
												str += '계획';
											}
										}

										str +=')</span>';
										return str;
			}},
			{key : "createdName" , formatter : function(obj) {

										var str = "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+obj.item.createdBy+"\",$(this),\"mouseover\",null,-5,-80,100)'>";
											str+= obj.item.createdName+'</span>(';
										//--- 나랑 관계사가 다를때 관계사명 표시
										if(obj.item.orgId != '${baseUserLoginInfo.orgId}'){
											str+=obj.item.orgNm+'/';
										}
										str+=obj.item.deptNm+'/'+obj.item.position+')</em>';

										return str;

			}},


			{key : "memo"	 	 , formatter : function(obj) {

												//var memoList = obj.item.memo.split(g_separator);
												var memoList = g_leaderMemoListNew;

												var str ='';
												for(var i=0;i<memoList.length;i++){
													//if(memoList[i] != ""){
														//var memoObj = JSON.parse(memoList[i]);
														str +='<div class="leaderhistory">';
														str +='<dl>';
														str +='<dt>업무내용</dt>';
														str +='<dd class="messagecon">'+devUtil.fn_escapeReplace(memoList[i].memo).replace(/(?:\r\n|\r|\n)/g, '<br />');+'</dd>';
														str +='<dd><span class="update">'+memoList[i].createDate+'</span></dd>';

														//첨부파일(일반)
				                                          var fileNameStr = memoList[i].fileNameStr;
				                                          // fileNameStr ->   file_seq,'|',file_size,'|',org_file_nm  , 파일목록은 ":"로 구분
				                                          if(fileNameStr != ""){
				                                              var fileSize = 0;
				                                              var fileHtml = '';
				                                              var downFileList =new Array();

				                                              var fileList = fileNameStr.split(":");
				                                              for(var k=0;k<fileList.length;k++){
				                                                  var arrFile = fileList[k].split("|");
				                                                  fileHtml+='<li><a href=javascript:downLoadFile("'+arrFile[0]+'")>' + arrFile[2] + '</a></li>'
				                                                  fileSize += parseInt(arrFile[1]);
				                                                  downFileList.push(arrFile[0]);
				                                              }


				                                              str +='<dd class="fileAddList_b">';
				                                              str +='<p class="title"><strong>첨부파일</strong><span class="count">'+fileList.length+'개<em>'+getFileSize(fileSize) +'</em></span>';
				                                              str += '<a href="javascript:fileDown(\'' + downFileList.join(",") + '\','+ fileList.length +')" class="s_white01_btn" id="filedownloadAll" style="">모두저장</a></p>';
				                                              str +='<ul id="fileArea">';
				                                              str += fileHtml;
				                                              str +='</ul>';
				                                              str +='</dd>';
				                                              str +='</dl>';
				                                          }
				                                      str +='</div>';
												}

												if(loginUserId == obj.item.createdBy){		//팀장이면,
													str +='<div class="leaderhistory write">';
													str +='<dl>';
													str +='<dt><span class="tm_name">'+'${baseUserLoginInfo.userName}'+'</span>';
													str +='<em class="tm_position">('+'${baseUserLoginInfo.deptNm}'+'/'+'${baseUserLoginInfo.rankNm}'+')</em>';
													str +='<span class="update">'+new Date().yyyy_mm_dd()+'</span></dt>';
													str +='<dd class="messagecon"><textarea id="leaderMemoView" class="txtarea_b w100pro" placeholder="내용을 입력하세요." title="메세지입력"></textarea></dd>';
													str +='<dd class="fileAddList_m noline">';
													str +='<p class="addfilett">';
													str +='<span id="fileInputArea" class="file_btn_bg btn_auth"><input name="upFile1" type="file" multiple="" onchange="fnObj.newFileUpload(\'VIEW\');" class="file_btn_cover"></span><span class="size" id="size1"><strong>파일<span>0MB</span></strong> / <em>100MB</em></span>';
													str +='<span class="btn_zone"><button class="btn_s_type_g btn_auth" onclick="fnObj.updateLeaderMemo(\'MEMO\',\'View\');">추가등록</button><button class="btn_s_type_g" onclick="$(\'#leaderMemoView\').val(\'\');">취소</button></span>';
													str +='</p>';
													str +='<div class="addFileList">';
													str +='<ul id="uploadFileList" class="fileList" style="display:none;"></ul>';
													str +='</div>';
													str +='</dd>';
													str +='</dl>';
													str +='</div>';
												}
												return str;

			}},
			{key : "progressTxt" , formatter : function(obj) {
										var str ='<span class="';

										if(obj.item.complete == 'Y'){	//완료
											str+='st_finish';
										}else{
											str+='st_ing';
										}

										str+='">'+obj.item.progressTxt+'</span>';

										return str;
			}},
			{key : "createDate", formatter : function(obj) {
					var str = 	obj.item.createDate;

					return str.split("-").join("/")
			}}

			],
			body : {
				onclick : function(obj, e) {

				}
			}
		};

		/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
		var rowHtmlStr = '<tr>';
		rowHtmlStr += '<th>${baseUserLoginInfo.projectTitle}</th>';
        rowHtmlStr += '<td>#[0]</td>';
        rowHtmlStr += '</tr>';
		rowHtmlStr += '<th scope="row">기간</th>';
		rowHtmlStr += '<td class="project_date">#[1]</td>';
		rowHtmlStr += '</tr>';
		rowHtmlStr += '<tr>';
		rowHtmlStr += '<th scope="row">작성자</th>';
		rowHtmlStr += '<td class="project_leader">#[2]</td>';
		rowHtmlStr += '</tr>';

		rowHtmlStr += '<tr>';
		rowHtmlStr += '<th scope="row">작성일</th>';
		rowHtmlStr += '<td class="project_leader">#[5]</td>';
		rowHtmlStr += '</tr>';

		rowHtmlStr += '<tr class="pdb12">';
		rowHtmlStr += '<th scope="row">참가자</th>';
		rowHtmlStr += '<td class="teammemberList" id="teamNameArea"></td>';
		rowHtmlStr += '</tr>';

		rowHtmlStr += '<tr class="pdb12" style="display:none;">';
        rowHtmlStr += '<th scope="row">추가열람권한</th>';
        rowHtmlStr += '<td class="teammemberList" id="workReaderListArea"></td>';
        rowHtmlStr += '</tr>';

		rowHtmlStr += '<tr class="divb_line pdt12 pdb12">';
		rowHtmlStr += '<th scope="row">상세내용</th>';
		rowHtmlStr += '<td class="pdd00">#[3]</td>';
		rowHtmlStr += '</tr>';
		rowHtmlStr += '<tr class="divb_line pdt12 pdb12">';
		rowHtmlStr += '<th scope="row">진행상태</th>';
		rowHtmlStr += '<td class="project_state">#[4]</td>';
		rowHtmlStr += '</tr>';
		configObj.rowHtmlStr = rowHtmlStr;
		myGrid.setConfig(configObj);

		//-------------------------- 그리드 설정 :E ----------------------------

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

	},

	//수정 화면
	editPageStart : function(){

		//-------------------------- 그리드 설정 :S ----------------------------
		/* 그리드 설정정보 */
		var configObj = {


			targetID : "SGridTarget2", //테이블아이디


			//그리드 컬럼 정보
			colGroup : [
			{key : "project"      , formatter : function(obj) {
			    var str = "<div><strong>";
			    str += "["+obj.item.projectNm+"-";
			    str += obj.item.activityNm+"]</strong> 기간 : "+obj.item.activityStartDate+" ~ "+obj.item.lastDate+"</div>";

			    return str;
			}},
			{key : "title"	 	 , formatter : function(obj) {  					//제목
										var str ='';
										str+='<input type="text" id="title" placeholder="업무명을 입력해주세요" class="w100" value="'+obj.item.title+'" />';
										return str;
			}},
			{key : "workDate"	 , formatter : function(obj) {						//기간

										var workDate = obj.item.workDate;			//시작일
										var completeDate = obj.item.completeDate;	//종료일
										var nowDate = new Date().yyyy_mm_dd();

										var lastDay = '';

										var str ='  '+workDate.replace(/-/gi,'/')+' ~ ';
										if(completeDate == '' || obj.item.complete == 'N'){ //작업 완료일이 없으면,
											str +='미정 ';
											lastDay = nowDate;

										}else{
											str +=' '+completeDate.replace(/-/gi,'/');
											lastDay = completeDate;
										}
										var diff = diffDay(lastDay,workDate);

										str += '<span class="work_date" style="padding-left:5px;">(';
										if(diff == 0){
											str += '당일';
										}else if(diff > 0){
											str += '+'+diff;
										}else{
											if( new Date().yyyy_mm_dd() <= lastDay && obj.item.complete == 'Y'){
												str += '완료';
											}else{
												str += '계획';
											}

										}

										str +=')</span>';
										return str;
			}},
			{key : "memo"	 	 , formatter : function(obj) { 						//업무내용 세팅
										//var memoList = obj.item.memo.split(g_separator);
			                            var memoList = g_leaderMemoListNew;
										var str ='';

										for(var i=0;i<memoList.length;i++){
											str +='<div class="leaderhistory">';
											str +='<dl>';
											str +='<dt>업무내용</dt>';
											str +='<dd class="messagecon">'+devUtil.fn_escapeReplace(memoList[i].memo).replace(/(?:\r\n|\r|\n)/g, '<br />')+'</dd>';
											str +='<dd><span class="update">'+memoList[i].createDate+'</span></dd>';



											//첨부파일(일반)
                                            var fileNameStr = memoList[i].fileNameStr;
                                            // fileNameStr ->   file_seq,'|',file_size,'|',org_file_nm  , 파일목록은 ":"로 구분
                                            if(fileNameStr != ""){
                                                var fileSize = 0;
                                                var fileHtml = '';
                                                var downFileList =new Array();

                                                var fileList = fileNameStr.split(":");
                                                for(var k=0;k<fileList.length;k++){
                                                    var arrFile = fileList[k].split("|");
                                                    fileHtml+='<li><a href=javascript:downLoadFile("'+arrFile[0]+'")>' + arrFile[2] + '</a></li>'
                                                    fileSize += parseInt(arrFile[1]);
                                                    downFileList.push(arrFile[0]);
                                                }

                                                str +='<dd class="fileAddList_b">';
                                                str +='<p class="title"><strong>첨부파일</strong><span class="count">'+fileList.length+'개<em>'+getFileSize(fileSize) +'</em></span>';
                                                str += '<a href="javascript:fileDown(\'' + downFileList.join(",") + '\','+ fileList.length +')" class="s_white01_btn" id="filedownloadAll" style="">모두저장</a></p>';
                                                str +='<ul id="fileArea">';
                                                str += fileHtml;
                                                str +='</ul>';
                                                str +='</dd>';
                                            }
                                            str +='</dl>';
                                            str +='</div>';

										}

										if(loginUserId == obj.item.createdBy){		//팀장이면, 추가등록 창 생성

											str +='<div class="leaderhistory write">';
											str +='<dl>';
											str +='<dt><span class="tm_name">'+'${baseUserLoginInfo.userName}'+'</span>';
											str +='<em class="tm_position">('+'${baseUserLoginInfo.deptNm}'+'/'+'${baseUserLoginInfo.rankNm}'+')</em>';
											str +='<span class="update">'+new Date().yyyy_mm_dd()+'</span></dt>';
											str +='<dd class="messagecon"><textarea id="leaderMemoEdit" class="txtarea_b w100pro" placeholder="내용을 입력하세요." title="메세지입력"></textarea></dd>';

											str +='<dd class="fileAddList_m noline">';
                                            str +='<p class="addfilett">';
                                            str +='<span id="fileInputAreaLeaderEdit" class="file_btn_bg"><input name="upFile2" type="file" multiple="" onchange="fnObj.newFileUpload(\'LEADER_EDIT\');" class="file_btn_cover"></span><span class="size" id = "size2"><strong>파일<span>0MB</span></strong> / <em>100MB</em></span>';
                                            str +='</p>';
                                            str +='<div class="addFileList">';
                                            str +='<ul id="uploadFileListLeaderEdit" class="fileList" style="display:none;"></ul>';
                                            str +='</div>';
                                            str +='</dd>';

											str +='</dl>';
											str +='</div>';
										}
										return str;

			}},
			{key : "important"   , formatter : function(obj) {  					//중요도 세팅
										var str ='<ul class="importantGrade mgl5">';


										str+='<li><a name="important" id="important_1"  href="javascript:fnObj.setImportant(1);"><em>+1</em></a></li>';
										str+='<li><a name="important" id="important_2"  href="javascript:fnObj.setImportant(2);"><em>+2</em></a></li>';
										str+='<li><a name="important" id="important_3"  href="javascript:fnObj.setImportant(3);"><em>+3</em></a></li>';
										str+='</ul>';

										return str;
			}},
			{key : "" 		 	, formatter : function(obj) {  						//참가자 이름 영역
										var str ='<div class="newjoinList" id="userSelectArea">';

										var memberList =obj.etc;
										for(var i=0;i<memberList.length;i++){
											str +=' <strong>'+memberList[i].userName+'</strong>(';

											//--- 나랑 관계사가 다를때 관계사명 표시
											if(memberList[i].orgId != '${baseUserLoginInfo.orgId}'){
												str+=memberList[i].orgNm+'/';
											}
											str+=memberList[i].position+')';


											/* if(i <memberList.length-1 ) str +=','; */
											/* if((i+1)%4 ==0 ) str +='<br/>'; */
											str +='</span>';
										}


										str +='</div>';

										return str;
			}},
			{key : "progress" 	 , formatter : function(obj) {  					//진행상태
										var str ='<div id="leaderProgressArea">'+leaderProgressSelect+'</div>';

										return str;
			}},





			],
			body : {
				onclick : function(obj, e) {

				}
			}
		};

		/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
		var rowHtmlStr = '<tr>';
		rowHtmlStr += '<th>${baseUserLoginInfo.projectTitle}</th>';
        rowHtmlStr += '<td>#[0]</td>';
        rowHtmlStr += '</tr>';
		rowHtmlStr += '<th scope="row">업무명</th>';
		rowHtmlStr += '<td>#[1]</td>';
		rowHtmlStr += '</tr>';
		rowHtmlStr += '<tr>';
		rowHtmlStr += '<th scope="row">기간</th>';
		rowHtmlStr += '<td class="project_date">#[2]</td>';
		rowHtmlStr += '</tr>';
		rowHtmlStr += '<tr class="divb_line pdt12 pdb12">';
		rowHtmlStr += '<th scope="row">업무내용</th>';
		rowHtmlStr += '<td class="pdd00">#[3]</td>';
		rowHtmlStr += '</tr>';
		rowHtmlStr += '<tr>';
		rowHtmlStr += '<th scope="row">중요도</th>';
		rowHtmlStr += '<td class="vm">#[4]</td>';
		rowHtmlStr += '</tr>';
		rowHtmlStr += '<tr>';
		rowHtmlStr += '<th scope="row" rowspan="2">참가자</th>';
		rowHtmlStr += '<td class="vm"><a href="javascript:fnObj.userPop();" class="btn_select_employee4"><em>참가자추가</em></a></td>';
		rowHtmlStr += '</tr>';
		rowHtmlStr += '<tr class="dot_line">';
		rowHtmlStr += '<td>#[5]</td>';
		rowHtmlStr += '</tr>';

		rowHtmlStr += '<tr style="display:none;">';
		rowHtmlStr += '    <th scope="row"  id="approveCcTh">추가열람권한</th>';
		rowHtmlStr += '    <td>';
		rowHtmlStr += '        <span id="readerTypeTag"  class="radio_list2"></span>';
		rowHtmlStr += '        <a id = "readerTypeDept" href="javascript:fnObj.openEmpPopup(\'DEPT\');" class="btn_select_team mgl10" style="display: none;">';
		rowHtmlStr += '            <em>부서선택</em>';
		rowHtmlStr += '        </a>';
		rowHtmlStr += '        <a id = "readerTypeUser" href="javascript:fnObj.openEmpPopup(\'USER\');" class="btn_select_employee mgl10" style="display: none;">';
		rowHtmlStr += '            <em>직원선택</em>';
		rowHtmlStr += '        </a>';
		rowHtmlStr += '    </td>';
		rowHtmlStr += '</tr>';
		rowHtmlStr += '<tr id = "approveCcTr" style="display: none;">';
		rowHtmlStr += '    <td class="dot_line" id = "approveCcArea">';
		rowHtmlStr += '    </td>';
		rowHtmlStr += '</tr>';

		rowHtmlStr += '<tr>';
		rowHtmlStr += '<th scope="row">진행상태</th>';
		rowHtmlStr += '<td class="project_state">#[6]</td>';
		rowHtmlStr += '</tr>';
		configObj.rowHtmlStr = rowHtmlStr;
		myGrid2.setConfig(configObj);

		//-------------------------- 그리드 설정 :E ----------------------------

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

	},

	//업무일지 정보
	getWorkDaily : function(){

		var url =contextRoot + "/work/getWorkDaily.do";

	   	 var param = {
	   			 listId	: g_listId,
	   			 orgId : '${baseUserLoginInfo.applyOrgId}'
	   	 };

	   	 var callback = function(result){
	   		var obj = JSON.parse(result);
            var totalObj = obj.resultObject;
            var list = totalObj.workList;
            g_leaderMemoListNew = totalObj.memoList;

            g_workReaderList = totalObj.workReaderList;

    		//var list = obj.resultList;
    		g_leaderMemoList = list;
    		$("#titleArea").html(devUtil.fn_escapeReplace(list[0].title));
    		$("#important").addClass('icon_important_L'+list[0].important);

			var str = "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[0].createdBy+"\",$(this),\"mouseover\",null,-5,-80,100)'>";

    		str += list[0].createdName+'</span><em>(';
    		//--- 나랑 관계사가 다를때 관계사명 표시
			if(list[0].orgId != '${baseUserLoginInfo.orgId}'){
				str+=list[0].orgNm+'/';
			}
			str+=list[0].deptNm+'/'+list[0].position+')</em>';

			$("#leaderNameArea").html(str);
			$("#activityId").val(list[0].activityId);
			$("#employee").val(list[0].employee);

			$("#projectId").val(list[0].projectId);
			$("#openFlag").val(list[0].openFlag);


    		//타인이 봤을때,
    		if(list[0].createdBy != loginUserId){
    			$("#leaderBtnArea").hide();
			}else{
				//등록된 코멘트가 있으면 삭제불가능
				if(g_leaderMemoListNew.length > 1 || g_teamMemoListNew.length > 0){
					$("#deleteBtn").hide();
				}
			}

    		var progress = getBaseCommonCode('WORKDAILY_PROGRESS', '', 'CD', 'NM', null, '', '', { orgId : list[0].orgId} );
    		if(progress == null){
    			progress = [{ 'CD': '', 'NM' :'선택'}];
    		}
    		progressSelect = createSelectTag('progress', progress, 'CD', 'NM', null, '', {}, '', 'select_b w_st05');	//select tag creator 함수 호출 (common.js)
    		leaderProgressSelect = createSelectTag('leaderProgress', progress, 'CD', 'NM', null, '', {}, '', 'select_b w_st05');	//select tag creator 함수 호출 (common.js)

    		//그리드 데이터 세팅

			myGrid.setGridData({ 	//그리드 데이터 세팅	*** 2 ***
				list : list, 		//그리드 테이터

			});

			//열람권한
            g_readerType = list[0].readerType;

    	};

    	commonAjax("POST", url, param, callback, false);


	},

	//업무일지 팀원의 정보
	getWorkDailyTeam : function(){

		var url =contextRoot + "/work/getWorkDailyTeam.do";

	   	 var param = {
	   			 listId	: g_listId,
	   			 orgId : '${baseUserLoginInfo.applyOrgId}'
	   	 };

	   	 var callback = function(result){
	   		var obj = JSON.parse(result);
            var totalObj = obj.resultObject;
            var list = totalObj.workList;
            g_teamMemoListNew = totalObj.memoList;


    		//var list = obj.resultList;
    		g_teamMemoList = list;

    		/* 수정화면 그리드 데이터 세팅 (display:none;) */

    		//타인이 봤을때,
            if(list[0].createdBy != loginUserId){
                $("#leaderBtnArea").hide();
            }else{
                //등록된 코멘트가 있으면 삭제불가능
                if(g_leaderMemoListNew.length > 1 || g_teamMemoListNew.length > 0){
                    $("#deleteBtn").hide();
                }
            }

    		//그리드 데이터 세팅
    		myGrid2.setGridData({ 	//그리드 데이터 세팅	*** 2 ***
				list : g_leaderMemoList, 	//그리드 테이터
				etc  : g_teamMemoList, 		//그리드 테이터

			});

			fnObj.setImportant(g_leaderMemoList[0].important);


			$("#leaderProgress").append('<option value="COMPLETE">완료</option>');

			//----- 리더메모 진행상태 표시 설정
			var leaderProgress=g_leaderMemoList[0].progress;

    		if(g_leaderMemoList[0].complete == 'Y') leaderProgress ='COMPLETE';
    		//if(g_leaderMemoList[0].complete == 'D') leaderProgress ='DROP';

			$("#leaderProgress").val(leaderProgress); //진행상태 표시


			/*--------------------------------팀원 상세보기 화면----------------------------*/

			var imgFileList=[];
			var nameAreaStr = '';
    		var nameStr = '';
    		var str = '';

    		if(g_leaderMemoList[0].imgNm != ''){
    			var obj ={userId : g_leaderMemoList[0].empId , imgNm : g_leaderMemoList[0].imgNm};
    			imgFileList.push(obj)
    		}

    		for(var i=0;i<list.length;i++){
    			if(list.imgNm != ''){
    				var obj ={userId : list[i].empId , imgNm : list[i].imgNm};
    				imgFileList.push(obj)
    			}

    		}
    		for(var i=0;i<list.length;i++){


				g_entryUserList.push(list[i].empId);			//참가자로 등록된 유저 세팅

    			nameAreaStr += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].userId+"\",$(this),\"mouseover\",null,-5,-80,100)'>";
    			nameAreaStr += list[i].userName+'</span></strong>(';
    			//--- 나랑 관계사가 다를때 관계사명 표시
				if(list[i].orgId != '${baseUserLoginInfo.orgId}'){
					nameAreaStr+=list[i].orgNm+'/';
				}
				nameAreaStr+=list[i].position+')';


    			nameStr +=list[i].userName;

    			if(i < list.length -1){
    				nameAreaStr +=', ';
    				nameStr +=', ';
    			}
    			 if((i+1)%4 == 0){
    				nameAreaStr +='<br>';
    			}

    			//div 열림 세팅
    			str +='<div id="user_'+list[i].empId+'" class="memberBoxsum';
    			if(list[i].complete == 'Y'){			//완료일때 색상 표시
    				str+=' state_finish';
    			}else if(list[i].complete == 'D' || list[i].progress == 'HOLD'){		//보류,드랍일때 색상 표시
    				str+=' state_drop';
    			}

    			if(list[i].empId == loginUserId){			//해당 사원이 봤을때
    				str+=' open';
    			}
    			str+='">';


    			//리스트 상단
    			str +='<dl class="update_sum" style="cursor:pointer;" onclick="fnObj.detailDisplay('+list[i].empId+');">';
    			if(list[i].imgNm==''){
    				str +='<dt>'+"<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].userId+"\",$(this),\"mouseover\",null,-5,-80,80)'>"+'<img src="'+contextRoot+'/images/work/bg_pic_tm.gif" alt="임시파일"></span></dt>';
    			}else{
    				//str +='<dt><img src="<c:url value="/file/downFile.do?uploadType=PROFILEIMG&downFileList='+list[i].userProfileSeq+'"/>"></dt>';
    				//str +='<dt><img src="'+list[i].imgPath+'"></dt>';

    				str +='<dt>'+"<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].userId+"\",$(this),\"mouseover\",null,-5,-80,80)'>"+'<img class="userImg" src="/imgUpLoadData/'+list[i].imgNm+'" alt="'+list[i].userName+'"></span></dt>';
    				//encodeURI( list[i].imgNm, "UTF-8")
    			}
    			str +='<dd><strong class="tm_name">';
    			str +=list[i].userName+'</strong><em class="tm_position">(';

    			//--- 나랑 관계사가 다를때 관계사명 표시
				if(list[i].orgId != '${baseUserLoginInfo.orgId}'){
					str+=list[i].orgNm+'/';
				}
				str+=list[i].deptNm+'/'+list[i].position+')</em><span class="tm_upcon">';


    			var memoList =[];

    			if(list[i].empMemo != ""){
    				//var memoList = list[i].empMemo.split(g_separator);
    				var memoList = g_teamMemoListNew;
    				var workCount =0;
	    			for(var k=0;k<memoList.length;k++){
	    				if(list[i].empId == memoList[k].empId && memoList[k].memo != ""){
		    				//var obj = JSON.parse(memoList[k]);
		    				if(k == memoList.length-1){
		    					str +=devUtil.fn_escapeReplace(memoList[k].memo)+'</span>';
		    					str +='<span class="update">'+memoList[k].createDate;
		    					str +='</span>';
		    					if(memoList[k].createDate.substring(0,10) == new Date().yyyy_mm_dd()){		//오늘 등록한것만  new
		    						str +='<span class="icon_new"><em>new</em></span>';
		    					}

		    				}
		    				workCount++;
	    				}

	    			}
    			}
    			str +='</dd>';
    			str +='</dl>';
    			str +='<span class="counticonZone"><span class="addfile_count">'+'</span>';
    			str +='<span class="work_count">'+workCount+'</span></span>';
    			str +='</div>';


    			/* --------------------------------------------------상세 내역-------------------------------------- */

    			str+=' <div class="m_workhistoryWrap" id="detailArea_'+list[i].empId+'" style="display:none;"> ';
    			str+=' <div class="m_workhistoryBox"> ';


    			var laststr ='';
    			for(var k=0;k<memoList.length;k++){
    				if(list[i].empId == memoList[k].empId && memoList[k].memo != ""){
	    				//var obj = JSON.parse(memoList[k]);
	    				str+=' <div class="m_bubbleWrap';
	    				if(loginUserId == memoList[k].userId){		//작성자 입장에서 볼때,
	    					str+=' mine';
	    				}
	    				str+='"> ';
	    				str+='<div class="workmessageBox">';
	    				str+='<dl>';

	    				//--일단 프로 필이 있는지 판별
	    				//var photoList = getCodeInfo('', '', '', null, null, null, '/file/getFileList.do', {uploadType : 'PROFILEIMG', uploadId : obj.userId});
	    				var photoObj = getRowObjectWithValue(imgFileList, "userId", memoList[k].userId);



	    				//-- 프로필 이미지 세팅
	    				if(photoObj == null){
	        				str +='<dt>'+"<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+memoList[k].userId+"\",$(this),\"mouseover\",null,-5,-80,80)'>"+'<img src="'+contextRoot+'/images/work/bg_pic_tm.gif" alt="임시파일"></span></dt>';
	        			}else{
	        				//str +='<dt><img src="<c:url value="/file/downFile.do?uploadType=PROFILEIMG&downFileList=&uploadId='+obj.userId+'"/>"></dt>';
	        				str +='<dt>'+"<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+memoList[k].userId+"\",$(this),\"mouseover\",null,-5,-80,80)'>"+'<img class="userImg" src="/imgUpLoadData/'+photoObj.imgNm+'"  alt="'+memoList[k].userName+'"></span></dt>';

	        			}
	    				str+='<dd><span class="tm_name">';
	    				str+=memoList[k].userName+'</span><em class="tm_position">(';

	    				//--- 나랑 관계사가 다를때 관계사명 표시
	    				if(memoList[k].orgId != undefined && memoList[k].orgId != '${baseUserLoginInfo.orgId}'){
	    					str+=memoList[k].orgNm+'/';
	    				}
	    				str+=memoList[k].deptNm+'/'+memoList[k].rankNm+')</em>';


	    				str+='<span class="update">'+memoList[k].createDate+'</span></dd>';
	    				var memo = devUtil.fn_escapeReplace(memoList[k].memo)
	    				str+='<dd class="messagecon">'+memo.replace(/(?:\r\n|\r|\n)/g, '<br />')+'</dd>';

	    				//첨부파일(일반)
                        var fileNameStr = memoList[k].fileNameStr;
                        // fileNameStr ->   file_seq,'|',file_size,'|',org_file_nm  , 파일목록은 ":"로 구분
                        if(fileNameStr != ""){
                            var fileSize = 0;
                            var fileHtml = '';
                            var downFileList =new Array();

                            var fileList = fileNameStr.split(":");
                            for(var j=0;j<fileList.length;j++){
                                var arrFile = fileList[j].split("|");
                                fileHtml+='<li><a href=javascript:downLoadFile("'+arrFile[0]+'")>' + arrFile[2] + '</a></li>'
                                fileSize += parseInt(arrFile[1]);
                                downFileList.push(arrFile[0]);
                            }

                            str +='<dd class="fileAddList_b">';
                            str +='<p class="title"><strong>첨부파일</strong><span class="count">'+fileList.length+'개<em>'+getFileSize(fileSize) +'</em></span>';
                            str += '<a href="javascript:fileDown(\'' + downFileList.join(",") + '\','+ fileList.length +')" class="s_white01_btn" id="filedownloadAll" style="">모두저장</a></p>';
                            str +='<ul id="fileArea">';
                            str += fileHtml;
                            str +='</ul>';
                            str +='</dd>';
                        }

                        str+='</div>';
                        str+='</div>';

    				}

    			}

    			//------메세지입력창
    			//입력 부
    			if(list[i].empId == loginUserId || list[i].createdBy == loginUserId){			//해당 사원이 봤을때 팀 리더 봤을때
    				str+='<div class="btn_position"><button type="button" class="btn_add_message" onclick="fnObj.empMemoDisplay('+list[i].empId+');"><em>내용추가</em></button></div>';
    				str+='<div class="m_bubbleWrap mine write" id="empMemoArea_'+list[i].empId+'" style="display:none;">';
    				str+='<div class="workmessageBox">';

    				str+='<dl>';

    				//-- 프로필 이미지 세팅
    				if('${baseUserLoginInfo.myPhotoNm}' == ''){
    					str+='<dt><img src="'+contextRoot+'/images/work/bg_pic_tm.gif" alt="임시파일"></dt>';
    				}else{
    					//str+='<dt><img src="<c:url value="/file/downFile.do?uploadType=PROFILEIMG&downFileList=${baseUserLoginInfo.myPhoto}"/>"></dt>';
    					str+='<dt><img class="userImg" src="/imgUpLoadData/${baseUserLoginInfo.myPhotoNm}"  alt="${baseUserLoginInfo.name}"></dt>';
    				}

    				str+='<dd><span class="tm_name">'+'${baseUserLoginInfo.userName}'+'</span>';
    				str+='<em class="tm_position">('+'${baseUserLoginInfo.deptNm}'+'/'+'${baseUserLoginInfo.rankNm}'+')</em><span class="update">'+new Date().yyyy_mm_dd().replace(/-/gi,'/')+'</span></dd>';
    				str+='<dd class="messagecon">';
    				str+='<textarea class="txtarea_b w100pro" id="textArea_'+list[i].empId+'" placeholder="내용을 입력하세요." title="메세지입력"></textarea>';
    				str+='</dd>';
    				str +='<dd class="fileAddList_m noline">';
					str +='<p class="addfilett">';
					str +='<span id="fileInputAreaTeamEdit_'+list[i].empId+'" class="file_btn_bg"><input name="upFile3" type="file" multiple="" onchange="fnObj.newFileUpload(\'TEAM_EDIT\','+list[i].empId+');" class="file_btn_cover"></span><span class="size" id = "size3"><strong>파일<span>0MB</span></strong> / <em>100MB</em></span>';
					str +='<span class="btn_zone">';
					str+='<button class="btn_s_type_g" onclick="fnObj.updateTeamMemo('+list[i].empId+',\'MEMO\','+list[i].teamListId+');">등록</button>';
                    str+='<button class="btn_s_type_g" onclick="fnObj.empMemoDisplay('+list[i].empId+');">취소</button>';
					str +='</p>';

					str +='<div class="addFileList">';
                    str +='<ul id="uploadFileListTeamEdit_'+list[i].empId+'" class="fileList" style="display:none;"></ul>';
                    str +='</div>';

					str +='</dd>';
					str+='</dl>';
    				str+='<span class="edge_point"></span>';
    				str+='</div>';


    				str+='</div>';

    			}


    			str+='</div>';
				str+='</div>';


				if(list[i].empId == loginUserId){	//해당 사원 진행사항 변경
					str+='<div class="m_workhistoryState" id="progressArea_'+list[i].empId+'">';
					str+='<span class="title">진행상황</span>';
					str+='<span id="progressSelectArea_'+list[i].empId+'"></span>';
					str+='<button class="btn_s_type_g mgl6" onclick="fnObj.updateTeamMemo('+list[i].empId+',\'PROGRESS\','+list[i].teamListId+')">적용</button>';
					str+='</div>';
				}else{
					str+='<div class="m_workhistoryState" id="progressArea_'+list[i].empId+'" style="display:none;">';
					str+='<span class="title">진행상황</span>';
					str+='<span class="';

					if(list[i].complete == 'D' || list[i].progress == 'HOLD'){		//보류,드랍
						str+='st_drop';
					}else if(list[i].complete == 'Y'){	//완료
						str+='st_finish';
					}else{
						str+='st_ing';
					}

					str+=' ">'+list[i].progressTxt+'</span></div>';
				}

				/* --------------------------------------------------상세 내역-------------------------------------- */

    		}

    		$("#teamNameArea").html(nameAreaStr);
    		$("#userCountArea").html(list.length+'명');
    		$("#userNameArea").html(nameStr);
    		$("#userDetailArea").html(str);
    		$("#progressSelectArea_"+loginUserId).html(progressSelect);
    		var obj = getRowObjectWithValue(g_teamMemoList, 'empId', loginUserId);	//전체 리스트중 해당 empId 의 키값으로 obj추출

    		$("#progress").append('<option value="COMPLETE">완료</option>');


    		//-------팀원 진행상태 세팅
    		if(obj!=null){
    			var progress=obj.progress;
        		if(obj.complete == 'Y') progress ='COMPLETE';
        		//if(obj.complete == 'D') progress ='DROP';
        		$("#progress").val(progress);
    		}


    		fnObj.detailDisplay('${baseUserLoginInfo.userId}');

    		//열람권한
	        $("#readerTypeTag").html(g_readerTypeTag);
	        //All에 체크
	        $("input[type='radio'][name='readerType'][value='"+g_readerType+"']").prop("checked", true);
	        $("input[type='radio'][name='readerType'][value='NONE']").parent().find("span").text("설정하지않음(참가자만 열람)");

            $("#approveCcArea").empty();
            if(g_readerType == 'DEPT'){
                $("#readerTypeDept").show();
                $("#readerTypeUser").hide();
                for(var i = 0 ; i <g_workReaderList.length; i++){
                    $("#approveCcTh").attr("rowspan","2");
                    $("#approveCcTr").show();
                   var usrHtml = '';
                   usrHtml += '<span class="employee_list" >';
                   usrHtml += '<strong>'+ g_workReaderList[i].deptNm +'</strong><a href="#" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                   usrHtml += '<input type="hidden" name="arrDeptId" id="arrDeptId" value="'+g_workReaderList[i].deptId+'"/>';
                   usrHtml += '</span>';

                   $("#approveCcArea").append(usrHtml);
                }
            }else if(g_readerType == 'USER'){
                $("#readerTypeDept").hide();
                $("#readerTypeUser").show();
                for(var i = 0 ; i <g_workReaderList.length; i++){
                    $("#approveCcTh").attr("rowspan","2");
                    $("#approveCcTr").show();

                    var usrHtml = '';
                    usrHtml += '<span class="employee_list" >';
                    usrHtml += '<strong>'+ g_workReaderList[i].userNm +'</strong><a href="#" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                    usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+g_workReaderList[i].userId+'"/>';
                    usrHtml += '</span>';
                    $("#approveCcArea").append(usrHtml);
                }
            }else if(g_readerType == 'NONE'){
                $("#readerTypeDept").hide();
                $("#readerTypeUser").hide();
            }

            ////////////////////////////
            var usrHtml2 = '<strong>' + g_leaderMemoList[0].readerTypeNm + "</strong>&nbsp;&nbsp;";
            if(g_readerType == 'DEPT'){
                for(var i = 0 ; i <g_workReaderList.length; i++){
                   usrHtml2 += '<span class="employee_list" >';
                   usrHtml2 += g_workReaderList[i].deptNm;
                   usrHtml2 += '</span>';
                   if(i < g_workReaderList.length -1){
                       usrHtml2 +=',';
                   }
                }
            }else if(g_readerType == 'USER'){
                for(var i = 0 ; i <g_workReaderList.length; i++){
                    usrHtml2 += '<span class="employee_list" >';
                    usrHtml2 += g_workReaderList[i].userNm;
                    usrHtml2 += '</span>';
                    if(i < g_workReaderList.length -1){
                    	usrHtml2 +=',';
                    }
                }
            }

            //추가열람권한
            $("#workReaderListArea").html(usrHtml2);

          //프로젝트 공개여부에 따른 설정
            var openFlag = g_leaderMemoList[0].openFlag;
            if(openFlag == "N"){  //비공개
                $("input[type='radio'][name='readerType'][value='ALL']").prop("disabled", "disabled");
                $("input[type='radio'][name='readerType'][value='DEPT']").prop("disabled", "disabled");
                $("input[type='radio'][name='readerType'][value='USER']").prop("disabled", "");
                $("input[type='radio'][name='readerType'][value='NONE']").prop("disabled", "");
            }else{  // 공개
                $("input[type='radio'][name='readerType'][value='ALL']").prop("disabled", "");
                $("input[type='radio'][name='readerType'][value='DEPT']").prop("disabled", "");
                $("input[type='radio'][name='readerType'][value='USER']").prop("disabled", "");
                $("input[type='radio'][name='readerType'][value='NONE']").prop("disabled", "");
            }

    	};

    	commonAjax("POST", url, param, callback, false);

	},


	//팀 메모 추가 및 진행상태 변경
	updateTeamMemo : function(empId,type,teamListId){
		var complete = 'N';
		var completeDate = '1988-09-12';

		var param = {
	   			 listId		 	: g_listId,
	   			 empId			: empId,
	   			type           : type,
	   			teamListId           : teamListId,
	   	};

		if(type =='MEMO'){		//메모 추가
			var memo = $("#textArea_"+empId).val();
			//var obj = getRowObjectWithValue(g_teamMemoList, 'empId', empId);	//전체 리스트중 해당 empId 의 키값으로 obj추출
			//var memoList = JSON.parse(obj.empMemo);
			if(memo == ''){
		   		alert("메모를 입력해주세요");
		   		$("#textArea_"+empId).focus();
		   		return;
		   	}
			param.memo = memo;

			/*=========== 첨부파일 : S =========== */
	        var fileList ='';

	        var fileSeqList     = $("input[name=fileSeq3]");         //시퀀스 리스트
	        var orgFileNmList   = $("input[name=orgFileNm3]");       //파일명 리스트
	        var newFileNmList   = $("input[name=newFileNm3]");       //새로운 저장 파일명 리스트
	        var filePathList    = $("input[name=filePath3]");        //경로 리스트
	        var fileSizeList    = $("input[name=fileSize3]");        //파일 크기 리스트
	        var jArray = new Array();

	        var fileAllSize = 0;
	        $("input[name=fileSize3]").each(function(index, value){
	            fileAllSize += parseInt($(this).val());
	        });     //기존 파일 크기 리스트


	        for(var i=0;i<fileSeqList.length;i++){

	            var fileSeq      = fileSeqList[i].value;
	            var orgFileNm    = orgFileNmList[i].value;
	            var newFileNm    = newFileNmList[i].value;
	            var filePath     = filePathList[i].value;
	            var fileSize     = fileSizeList[i].value;

	            if(fileSeq == 0){                               //신규 등록건만 추가
	                var jobj = new Object();
	                jobj.fileSeq=fileSeq;
	                jobj.orgFileNm=orgFileNm;
	                jobj.newFileNm=newFileNm;
	                jobj.filePath=filePath;
	                jobj.fileSize=fileSize;
	                jobj.uploadType='TEAM_WORK_MEMO';
	                jArray.push(jobj);
	            }
	        }

	        var totalObj = new Object();
	        totalObj.items=jArray;                                          //items 란 키값으로 totalObj에 jobj를 담은 jArray를 세팅
	        fileList = JSON.stringify(totalObj);                            //totalObj 를 string 변환

	        if(jArray.length ==0) fileList = '';                            //파일이 없을때는 빈값


	        if(fileAllSize/(1024*1024) >100){
	            alertM("전체 최대용량 100MB 까지 첨부 가능합니다.");
	            return false;
	        }

	        /*=========== 첨부파일 : E =========== */

	        param.fileList = fileList;

		}else{		//진행상태 수정
			var progress = $("#progress").val();

			if(progress == 'COMPLETE' /* || progress == 'DROP' */){		//완료  or drop 이면 progress 는 세팅안함
				complete = 'Y';
		   		//else complete = 'D';
		   		completeDate = new Date().yyyy_mm_dd();
		   		progress = '';
		   	}

			param.progress = progress;
			param.complete = complete;
			param.completeDate = completeDate;

		}

		var url =contextRoot + "/work/updateTeamMemo.do";

	   	var callback = function(result){
   			var obj = JSON.parse(result);
	   		var chk = obj.resultVal;
	   		if(chk>0){
	   		 	toast.push("저장하였습니다.");
	   			fnObj.getWorkDailyTeam();
	   			if(empId !='${baseUserLoginInfo.userId}'){		//같지 않을때만 닫음.
	   				fnObj.detailDisplay(empId);
	   			}

	   		}else{
	   			dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
	   		}

	   		//유저프로필 이벤트 셋팅
	   		initUserProfileEvent();
	   		//메모영역 url자동링크
	   		autolink($(".messagecon"));

   		};

   		commonAjax("POST", url, param, callback, false);

	},

	//업무일지삭제
    deleteWorkDaily : function(){

        if(!confirm("해당 업무일지를 삭제하시겠습니까?")){
            return;
        }
        var url =contextRoot + "/work/deleteWorkDaily.do";

        var param = {
                 listId         : g_listId,
                 workType       : 'TEAM'

        };

        var callback = function(result){
            var obj = JSON.parse(result);
            var cnt = obj.resultVal;
            if(cnt>0){
                //fnObj.doSearch(loginUserId);
                parent.myModal.close();

                if(parent.fnObj == undefined){
                    parent.sheduleObj.getWorkDailyList();
                }else{
                    parent.fnObj.doSearch(loginUserId,'N');
                }

            }else{
                dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
            }
        };

        commonAjax("POST", url, param, callback, false);
    },

	//리더 메모 추가 및 진행상태 변경
	updateLeaderMemo : function(type,areaType){			//type. 메모인지 진행사항 변경인지 , areaType. 뷰의 메모추가인지 수정의 메모추가인지

		/*=========== 첨부파일 : S =========== */
		var typeSeq = "1";
		if(areaType =='Edit'){
			typeSeq = "2";
		}
        var fileList ='';

        var fileSeqList     = $("input[name=fileSeq"+typeSeq+"]");         //시퀀스 리스트
        var orgFileNmList   = $("input[name=orgFileNm"+typeSeq+"]");       //파일명 리스트
        var newFileNmList   = $("input[name=newFileNm"+typeSeq+"]");       //새로운 저장 파일명 리스트
        var filePathList    = $("input[name=filePath"+typeSeq+"]");        //경로 리스트
        var fileSizeList    = $("input[name=fileSize"+typeSeq+"]");        //파일 크기 리스트
        var jArray = new Array();

        var fileAllSize = 0;
        $("input[name=fileSize"+typeSeq+"]").each(function(index, value){
            fileAllSize += parseInt($(this).val());
        });     //기존 파일 크기 리스트


        for(var i=0;i<fileSeqList.length;i++){

            var fileSeq      = fileSeqList[i].value;
            var orgFileNm    = orgFileNmList[i].value;
            var newFileNm    = newFileNmList[i].value;
            var filePath     = filePathList[i].value;
            var fileSize     = fileSizeList[i].value;

            if(fileSeq == 0){                               //신규 등록건만 추가
                var jobj = new Object();
                jobj.fileSeq=fileSeq;
                jobj.orgFileNm=orgFileNm;
                jobj.newFileNm=newFileNm;
                jobj.filePath=filePath;
                jobj.fileSize=fileSize;
                jobj.uploadType='WORK_MEMO';
                jArray.push(jobj);
            }
        }

        var totalObj = new Object();
        totalObj.items=jArray;                                          //items 란 키값으로 totalObj에 jobj를 담은 jArray를 세팅
        fileList = JSON.stringify(totalObj);                            //totalObj 를 string 변환

        if(jArray.length ==0) fileList = '';                            //파일이 없을때는 빈값


        if(fileAllSize/(1024*1024) >100){
            alertM("전체 최대용량 100MB 까지 첨부 가능합니다.");
            return false;
        }

        /*=========== 첨부파일 : E =========== */

        var param = {
                 listId         : g_listId,
                fileList       :   fileList                //신규 파일 리스트
        };

        if(type =='MEMO'){      //메모 추가
            var memo = $("#leaderMemo"+areaType).val();
            if(memo == ''){
                alert("메모를 입력해주세요");
                $("#leaderMemo"+areaType).focus();
                return;
            }
            param.memo = memo;

        }

		var url =contextRoot + "/work/updateLeaderMemo.do";

	   	var callback = function(result){
   			var obj = JSON.parse(result);
	   		var chk = obj.resultVal;
	   		if(chk>0){
	   			fnObj.getWorkDaily();
	   			fnObj.getWorkDailyTeam();


	   		}else{
	   			dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
	   		}

	   		//유저프로필 이벤트 셋팅
	   		initUserProfileEvent();
	   		//메모영역 url자동링크
	   		autolink($(".messagecon"));
   		};

   		commonAjax("POST", url, param, callback, false);

	},

	//업무일지 변경
	editDaily : function(){
		var title = $("#title").val();
		var progress = $("#leaderProgress").val();
		var complete = 'N';
		var completeDate = '1988-09-12';


		var important =0;						//중요도
	   	var starList = $("a[name=important]");

	   	for(var i=0;i<starList.length;i++){
	   		if($(starList[i]).hasClass("on")){
	   			important++;
	   		}
	   	}

	   	if(title == ''){
	   		alert("제목을 입력해주세요");
	   		$("#title").focus();
	   		return;
	   	}

	   	/////진행상태 수정 -> 계획 진행 보류 일때만, 완료 일땐 complete 변경시킴
	   	var objCnt = getCountWithValue(g_teamMemoList, 'complete', 'N');	//전체 리스트중 미완료일정 갯수

	   	if(progress == 'COMPLETE'/*  || progress == 'DROP' */){		//완료  or drop 이면 progress 는 세팅안함
	   		/* if(progress != 'DROP'){ */
	   			complete = 'Y';
	   			if(objCnt != 0){
	   				if(!confirm("아직 완료하지 않은 직원이 있습니다. 완료처리를 하시겠습니까?")){ return;}
	   			}
	   		/* }else complete = 'D'; */
	   		completeDate = new Date().yyyy_mm_dd();
	   		progress = '';
	   	}

		var selectUserIdList = $("input[name=selectUserId]");	//시퀀스 리스트

    	var userArr = new Array();

    	for(var i=0;i<selectUserIdList.length;i++){

    		var rowUserIdStr = selectUserIdList[i].value;			//하나의 상세업무에 등록된 아이디 리스트
     		userArr.push(rowUserIdStr);
    	}

    	var arrDeptId  = [];
        $("input[name=arrDeptId]").each(function(){
            arrDeptId.push($(this).val());
        });

        var arrUserId  = [];
        $("input[name=arrUserId]").each(function(){
            arrUserId.push($(this).val());
        });

        var readerType = $("input[name='readerType']:checked").val();
        if(readerType == "DEPT" && arrDeptId.join() == ""){
            alert("열람권한에서 부서를 선택하여 주세요.");
            $("#readerType").focus();
            return;
        }

        if(readerType == "USER" && arrUserId.join() == ""){
            alert("열람권한에서 사용자를 선택하여 주세요.");
            $("#readerType").focus();
            return;
        }

		var param = {
				 listId		 	: g_listId,
	   			 important 		: important,
	   			 title			: title,
	   			 progress		: progress,
	   			 teamList		: userArr.join(','),
	   			 workType		: 'TEAM',
	   			 complete		: complete,
	   			 completeDate	: completeDate,
	   			 workDate     : g_workDate,

	   			workDatePeriod : '1',
                workDateStart : g_workDate,
                workDateEnd : g_workDate,
	   			readerType : $("input[name='readerType']:checked").val(),
                arrUserId : arrUserId.join(),
                arrDeptId : arrDeptId.join()
	   	};

		var url =contextRoot + "/work/getChkWorkPerson.do";

		var callback = function(result){

            var obj = JSON.parse(result);
            var data = obj.resultObject;

            if(data.result =="SUCCESS"){
                url =contextRoot + "/work/saveWorkDaily.do";
                commonAjax("POST", url, param, workDailyCallback, false);

            }else{
                if(data.msg != null){
                    alert(data.msg);  // 참가자로 지정하신 ... 병가/휴직 ... 참가자로 지정할 수 없습니다.
                    return;
                }else{
                    dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
                }
            }

        };

	   	var workDailyCallback = function(result){

   			var obj = JSON.parse(result);
	   		var chk = obj.resultVal;
	   		if(chk>0){
	   			if($("#leaderMemoEdit").val() != ''){
	   				fnObj.updateLeaderMemo('MEMO','Edit');
	   			}

	   			fnObj.editDisplay();
	   			if(parent.fnObj == undefined){
    				parent.sheduleObj.getWorkDailyList();
    			}else{
    				parent.fnObj.doSearch(loginUserId,'N');
    			}

	   		}else{
	   			dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
	   		}
   		};

   		commonAjax("POST", url, param, callback, false);

	},


    /* ---------------------------------------display 이벤트 세팅 영역-------------------------------------- */

	//메모 추가
	empMemoDisplay : function(empId){

		if($("#empMemoArea_"+empId).css("display") == 'none'){
			$("#empMemoArea_"+empId).show();
			$("#textArea_"+empId).focus();
		}else{
			$("#empMemoArea_"+empId).hide();
			$("#textArea_"+empId).val('');
		}

		parent.myModal.resize();

	},

	//상세내역 펼침
	detailDisplay : function(empId){

		if($("#detailArea_"+empId).css("display") == 'none'){
			$("#detailArea_"+empId).show();
			$("#progressArea_"+empId).show();
			$("#user_"+empId).addClass("open");
		}else{
			$("#detailArea_"+empId).hide();
			//메모입력 숨김
			if($("#empMemoArea_"+empId).css("display") != 'none'){
				$("#empMemoArea_"+empId).hide();
				$("#textArea_"+empId).val('');
			}
			$("#progressArea_"+empId).hide();
			$("#user_"+empId).removeClass("open");
		}
		//alert($(".leaderViewWrap").height());
		$('.t_memberconWrap').css({ minHeight: $(".leaderViewWrap").height(),paddingBottom: "10px"});
		//$(".t_memberconWrap").css("minHeight","1000px;");
		parent.myModal.resize();

	},

    //수정이동
    editDisplay : function(){

    	fnObj.getWorkDaily();		//업무일지 정보 받아오기
    	fnObj.getWorkDailyTeam();	//업무일지 팀원정보 받아오기

    	if($("#editArea").css("display") == 'none'){
    		$("#editArea").show();
        	$("#detailArea").hide();
    	}else{
    		$("#editArea").hide();
        	$("#detailArea").show();
    	}
    	//유저프로필 이벤트 셋팅
    	initUserProfileEvent();
    	closeUserProfileBox();

    	//메모영역 url자동링크
    	autolink($(".messagecon"));
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

 	//삭제버튼 클릭
 	deleteUser : function(userId){
 		$("#userOneArea_"+userId).remove();


 	},


  	//유저선택 공통 팝업
    userPop : function(){

    	g_popType = "TEAM";

    	//이미 db에 저장된 참가자
    	var disabledStr ='';
    	disabledStr = g_entryUserList.join(',');


    	var userStr ='';
    	var arr =g_entryUserList.clone();
    	var selectUserList =$("input[name=selectUserId]");

    	for(var i=0;i<selectUserList.length;i++){
    		arr.push(selectUserList[i].value);
  		}
    	userStr = arr.join(',');

    	$("#userStr").val(userStr);
    	$("#disabledStr").val(disabledStr);

    	//1. 공개프로젝트 전직원     : 전사직원선택 가능
        //2. 공개프로젝트 직원 할당 : 프로젝트에 할당된 직원만
        // 3. 비공개 프로젝트          : 프로젝트에 할당된 직원만
        var openFlag = $("#openFlag").val();
        var employee = $("#employee").val();

        if(openFlag == "Y" && employee == "A"){
        	var paramList = [];
            var paramObj ={ name : 'userList'   ,value : userStr};
            paramList.push(paramObj);
            paramObj ={ name : 'disabledList' ,value : disabledStr};
            paramList.push(paramObj);

            /* paramObj ={ name : 'isAllOrg' ,value : 'Y'};
            paramList.push(paramObj);
            paramObj ={ name : 'isAllOrgSelect' ,value : 'Y'};
            paramList.push(paramObj); */
            paramObj ={ name : 'isOneOrg' ,value : 'Y'};
            paramList.push(paramObj);

            paramObj ={ name : 'isCheckDisable' ,value : 'N'};
            paramList.push(paramObj);

            paramObj ={ name : 'hasDeptTopLevel' ,value : 'Y'};
            paramList.push(paramObj);  //부서의 회장 부서 표시여부

            userSelectPopCall(paramList);       //공통 선택 팝업 호출 */
        }else{
        	var option = "width=650px,height=520px,resizable=yes,scrollbars = yes";
            commonPopupOpen("searchCpnPop",contextRoot+"/work/projectUserListPopup.do",option,$("#viewerFrm"));
        }
 	},

 	//직원선택 팝업   (idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
    openEmpPopup: function(type){
        g_popType = type;

        //1. 공개프로젝트    : 해당 관계사 내에서만 가능
        //2. 비공개 프로젝트 : 프로젝트에 할당된 직원만
        var openFlag = $("#openFlag").val();

        if(openFlag == "Y"){
            var arrDeptId = [];
            $("input[name=arrDeptId]").each(function(){
                arrDeptId.push($(this).val());
            });

            var arrUserId  = [];
            $("input[name=arrUserId]").each(function(){
                arrUserId.push($(this).val());
            });

            var paramList = [];
            var paramObj ={ name : 'userList'   ,value :  (type=='USER') ? arrUserId.join() : arrDeptId.join() };
            paramList.push(paramObj);
            paramObj ={ name : 'isOneOrg' ,value : 'Y'};
            paramList.push(paramObj);
            paramObj ={ name : 'isAllOrgSelect' ,value : 'Y'};  //관계사 직원 다중선택가능 옵션
            paramList.push(paramObj);
            paramObj ={ name : 'isDeptSelect' , value : (type=='USER') ? 'N' : 'Y'};  //직원,부선 옵션
            paramList.push(paramObj);
            paramObj ={ name : 'isOneDept' ,value : 'N'};
            paramList.push(paramObj);

            userSelectPopCall(paramList);       //공통 선택 팝업 호출
        }else{
            var arrUserId  = [];
            $("input[name=arrUserId]").each(function(){
                arrUserId.push($(this).val());
            });

            var userStr = arrUserId.join(',');
            $("#userStr").val(userStr);

            var option = "width=650px,height=520px,resizable=yes,scrollbars = yes";
            commonPopupOpen("searchCpnPop",contextRoot+"/work/projectUserListPopup.do",option,$("#viewerFrm"));
        }

    },

 	//직원 선택
  	getResult : function(resultList){
  		if(g_popType == "TEAM"){
  			var str ='';
  	        var seqArr =[];
  	        var selectList = [];

  	        var brCnt = 1;

  	        for(var i=0;i<resultList.length;i++){
  	            var dupEmpYn = false;
  	            $("input[name=selectUserId]").each(function(){
  	                if($(this).val() == resultList[i].userId){
  	                    dupEmpYn = true;
  	                    return;
  	                }
  	            });

  	            if(!dupEmpYn && getArrayIndexWithValue(g_entryUserList, resultList[i].userId)<0){       //등록된 사람이 없을때,

  	                str +='<span class="employee_list" id="userOneArea_'+resultList[i].userId+'"><strong>'+resultList[i].userName+'</strong>(';
  	                str +=resultList[i].position+')<a onclick="javascript:fnObj.deleteUser('+resultList[i].userId+');" class="btn_delete_employee"><em>삭제</em></a>';
  	                str +='<input type="hidden" name="selectUserId" value="'+resultList[i].userId+'"/>';
  	                /* if(i<resultList.length-1){
  	                        str+=',';
  	                } */
  	                str+='</span>';
  	                brCnt++;
  	                //if(brCnt%4 ==1) str+='<br/>';
  	            }
  	        }
  	        $("#userSelectArea").append(str);                   //참가자 이름
  		}else if(g_popType == "DEPT"){
            $("#approveCcArea").empty();
            for(var i = 0 ; i <resultList.length; i++){
                $("#approveCcTh").attr("rowspan","2");
                $("#approveCcTr").show();
               var usrHtml = '';
               usrHtml += '<span class="employee_list" >';
               usrHtml += '<strong>'+ resultList[i].deptNm +'</strong><a href="#;" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
               usrHtml += '<input type="hidden" name="arrDeptId" id="arrDeptId" value="'+resultList[i].deptId+'"/>';
               usrHtml += '</span>';

               $("#approveCcArea").append(usrHtml);
            }
        }else if(g_popType == "USER"){
            $("#approveCcArea").empty();
            for(var i = 0 ; i <resultList.length; i++){
                $("#approveCcTh").attr("rowspan","2");
                $("#approveCcTr").show();

                var usrHtml = '';
                usrHtml += '<span class="employee_list" >';
                usrHtml += '<strong>'+ resultList[i].userNm +'</strong><a href="#;" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+resultList[i].userId+'"/>';
                usrHtml += '</span>';

                $("#approveCcArea").append(usrHtml);
            }
        }

  		parent.myModal.resize();

  	},
  	//신규 파일 등록시
    newFileUpload : function(type,empId){
        var url = contextRoot+"/file/uploadFiles.do"

        var typeSeq = "0";

        if(type == "LEADER_EDIT") typeSeq = "2";
        else if(type == "TEAM_EDIT") typeSeq = "3"
        else typeSeq="1";

        var callback = function(result){
            var list = result.resultList;

            var str='';
            for(var i=0;i<list.length;i++){
                var fileObj = list[i];
                str +='<li id="li_'+g_idx+'">' + fileObj.orgFileNm ;
                str +='<input type="hidden" name="fileSeq'+typeSeq+'" value="0">' ;
                str +='<input type="hidden" name="orgFileNm'+typeSeq+'" value="'+fileObj.orgFileNm+'">' ;
                str +='<input type="hidden" name="newFileNm'+typeSeq+'" value="'+fileObj.newFileNm+'">' ;
                str +='<input type="hidden" name="filePath'+typeSeq+'" value="'+fileObj.filePath+'">' ;
                str +='<input type="hidden" name="fileSize'+typeSeq+'" value="'+fileObj.fileSize+'">' ;
                str +='&nbsp; <span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+',\''+type+'\',\''+empId+'\');" class="fileDelete"><em>삭제</em></a></li>';
                g_idx++;


            }
            //파일 태그 재 생성.

            if(type == "LEADER_EDIT"){
            	$('#fileInputAreaLeaderEdit').append('<input name="upFile'+typeSeq+'" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload(\''+type+'\');">');
            	$('#uploadFileListLeaderEdit').append(str);
                $('#uploadFileListLeaderEdit').show();
            }else if(type == "TEAM_EDIT"){
            	$('#fileInputAreaTeamEdit_'+empId).append('<input name="upFile'+typeSeq+'" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload(\''+type+'\','+empId + ');">');
                $('#uploadFileListTeamEdit_'+empId).append(str);
                $('#uploadFileListTeamEdit_'+empId).show();
            }else{
            	$('#fileInputArea').append('<input name="upFile'+typeSeq+'" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload(\''+type+'\');">');
            	$('#uploadFileList').append(str);
                $('#uploadFileList').show();
            }

            var viewCheckSize = checkFileSize(typeSeq);

            $("#size"+typeSeq).html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");

            parent.myModal.resize();

        }
        //용량체크
        var fileAllSize = 0;
        var fileList = $("input[name=upFile"+typeSeq+"]")[0].files;
		for(var i=0;i<fileList.length;i++){
			fileAllSize+=(parseInt(fileList[i].size));
		}
        $("input[name=fileSize"+typeSeq+"]").each(function(index, value){
            fileAllSize += parseInt($(this).val());
        });
        if(fileAllSize/(1024*1024) >100){
            alertM("전체 최대용량 100MB 까지 첨부 가능합니다.");
            return false;
        }
        commonAjaxForFileCreateForm(url,"","upFile"+typeSeq,"100","fileSize"+typeSeq, callback , "");

    },

    //파일 바로 삭제
      newFileDelete : function(newFileNm,filePath,idx,type,empId){
          var url = contextRoot + "/file/deleteFile.do";
          var param = { newFileNm : newFileNm , filePath : filePath};
          var callback = function(result){
              var obj = JSON.parse(result);
              var cnt = obj.resultVal;
              if(cnt>0){
                  $("#li_"+idx).remove();
                  if(type == "LEADER_EDIT"){
                	  if($('#uploadFileListLeaderEdit').children().length == 0) $('#uploadFileListLeaderEdit').hide();    //ul 숨기기
                  }else if(type == "TEAM_EDIT"){
                      if($('#uploadFileListTeamEdit_'+empId).children().length == 0) $('#uploadFileListTeamEdit_'+empId).hide();    //ul 숨기기
                  }else{
                	  if($('#uploadFileList').children().length == 0) $('#uploadFileList').hide();    //ul 숨기기
                  }
                  typeSeq = "0";
                  if(type == "LEADER_EDIT") typeSeq = "2";
                  else if(type == "TEAM_EDIT") typeSeq = "3"
                  else typeSeq="1";
                  var viewCheckSize = checkFileSize(typeSeq);
                  $(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");
              }
          };
          commonAjax("POST", url, param, callback, false);
      },

    //열람권한 선택시
      clickReaderType : function(){
          $("#approveCcArea").empty();
          $("#approveCcTh").attr("rowspan","1");
          $("#approveCcTr").hide();
          if($("input[name='readerType']:checked").val()=='ALL'){
              $("#readerTypeDept").hide();
              $("#readerTypeUser").hide();
          }else if($("input[name='readerType']:checked").val()=='DEPT'){
              $("#readerTypeDept").show();
              $("#readerTypeUser").hide();
          }else if($("input[name='readerType']:checked").val()=='USER'){
              $("#readerTypeDept").hide();
              $("#readerTypeUser").show();
          }else if($("input[name='readerType']:checked").val()=='NONE'){
              $("#readerTypeDept").hide();
              $("#readerTypeUser").hide();
              //fnObj.changeNone();
          }
      },
    //열람권한 선택 사용자 부서 삭제시
      deleteStaff : function(obj){

          var span = $(obj).parent();
          span.remove();

          if( $("#approveCcArea").html().trim()==''){
              $("#approveCcTh").attr("rowspan","1");
              $("#approveCcTr").hide();
          }
          if( $("#approveReadCcArea").html()==''){
              $("#approveReadCcTh").attr("rowspan","1");
              $("#approveReadCcTr").hide();
          }
      },




};//end fnObj.


//파일 사이즈 체크해서 단위와 함께 표시
function getFileSize(fSize){
   var fSExt = new Array('Bytes', 'KB', 'MB', 'GB');
   var j=0;
   while(fSize>900){fSize/=1024;j++;}
   var fileSize = (Math.round(fSize*100)/100)+fSExt[j];
   return fileSize;
}

//파일 사이즈 체크해서 단위와 함께 표시
 function checkFileSize(typeSeq){
    var fSExt = new Array('Bytes', 'KB', 'MB', 'GB');
    var j=0;
    var fSize = 0;
    $("input[name=fileSize"+typeSeq+"]").each(function(index, value){
        fSize += parseInt($(this).val());
    });

    while(fSize>900){fSize/=1024;j++;}
    var fileSize = (Math.round(fSize*100)/100)+fSExt[j];
    return fileSize;
 }


//전체파일다운로드
function fileDown (downFileList, fileCnt){
   if(fileCnt ==0){
       alert("파일이 없습니다.");
       return false;
   }else if(fileCnt > 1){      //다중다운로드일때
       url = contextRoot + "/file/downFilesTozip.do?uploadType=${detailMap.appvDocClass}&downFileList="+downFileList;
   }else{
       url = contextRoot + "/file/downFile.do?uploadType=${detailMap.appvDocClass}&downFileList="+downFileList;
   }
   var frm = document.downForm;
   frm.action = url;
   frm.method = "POST";
   frm.submit();
}

//파일다운
function downLoadFile(fileSeq){

   var downFileList =new Array();
   downFileList.push(fileSeq);
   if(downFileList.length ==0){
       alert("파일을 선택해 주세요");
       return false;
   }else if(downFileList.length > 1){      //다중다운로드일때
       url = contextRoot + "/file/downFilesTozip.do?uploadType=${detailMap.appvDocClass}&downFileList="+downFileList.join(",");
   }else{
       url = contextRoot + "/file/downFile.do?uploadType=${detailMap.appvDocClass}&downFileList="+downFileList.join(",");
   }
   var frm = document.downForm;
   frm.action = url;
   frm.method = "POST";
   frm.submit();
}

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();		//공통코드 or 각종선로딩코드
	fnObj.pageStart();
	fnObj.editPageStart();
	fnObj.getWorkDaily();		//업무일지 정보 받아오기
	fnObj.getWorkDailyTeam();	//업무일지 팀원정보 받아오기

	//$('.userImg').imageTooltip();

	//화면이 포커스를 잃어서 임의로 설정 2017.04.17 이인희
	$("#tempInput").focus();
	$("#tempInput").hide();

	//유저프로필 이벤트 셋팅
	initUserProfileEvent();
	//메모영역 url자동링크
	autolink($(".messagecon"));

});
</script>


