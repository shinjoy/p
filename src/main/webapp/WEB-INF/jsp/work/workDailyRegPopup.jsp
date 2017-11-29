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

	<div id="compnay_dinfo">
		<!--업무일지등록-->
		<div class="modalWrap2">
			<div class="gtabZone mgb10" id="tabArea">
				<ul>
					<li id="personalLi" name="tabBtn" class="on"><a href="#;return false;" onclick="javascript:fnObj.changeTab('personalLi');">개인 업무</a></li>
					<li id="teamLi" name="tabBtn"><a href="#;return false;" onclick="javascript:fnObj.changeTab('teamLi');">팀 업무</a></li>
				</ul>
			</div>
			<div class="mo_container">
				<!--업무등록 (TO DO)-->

				<table class="tb_basic_left" summary="일정등록 (기안자, 흐름도, 요약) 안내">
					<caption>
						업무등록
					</caption>
					<colgroup>
						<col width="100" />
						<col width="35%" />
						<col width="100" />
						<col width="*" />
					</colgroup>
					 <tr>
						<th scope="row">${baseUserLoginInfo.projectTitle }</th>
						<td id = "projectAreaTd" colspan="3">
							<span id = "projectArea"></span>
							<span id = "activityArea">
								<select id = "activityId" name = "activityId" class="select_b mgl6">
									<option value="">${baseUserLoginInfo.projectTitle } 선택</option>
								</select>
							</span>
							<span id = "activityDescArea" class="mgl10"></span>
						</td>
					</tr>
					<tr id="workDateLine" >
                        <th scope="row"><label for="title">업무기간</label></th>
                        <td colspan="3">
                            <select id="workDatePeriod" name="workDatePeriod"  onChange="fnObj.changeWorkDate();" class="select_b"  title="업무기간">
                                 <option value="1" selected>1일</option>
                                 <option value="2">2일</option>
                                 <option value="3">3일</option>
                                 <option value="4">4일</option>
                                 <option value="5">5일</option>
                                 <option value="6">6일</option>
                                 <option value="7">7일</option>
                             </select>
                             <input type="text" class="input_date_type mgl15" name="workDateStart" id="workDateStart" value="${workDate}"  readonly="readonly"  title="시작일"  size="10" maxlength="10">
                             &nbsp;&nbsp;~<input type="text" class="input_date_type mgl15" name="workDateEnd" id="workDateEnd" value="${workDate}"  readonly="readonly"  title="종료일"  size="10" maxlength="10" >
                        </td>
                    </tr>
					<tr>
						<th scope="row"><label for="title">업무명</label></th>
						<td colspan="3"><input type="text" id="title" placeholder="업무명을 입력해주세요" class="w100" value="" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="memo">상세내용</label></th>
						<td  colspan="3"><textarea name="" cols="" rows="" placeholder="내용을 입력해주세요" class="txtarea_b4 w100" id="memo"></textarea></td>
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
						<th scope="row">중요도</th>
						<td class="vm">
							<ul class="importantGrade mgl5">
								<li><a name="important" id="important_1" href="javascript:fnObj.setImportant(1);"><em>+1</em></a></li>
								<li><a name="important" id="important_2" href="javascript:fnObj.setImportant(2);"><em>+2</em></a></li>
								<li><a name="important" id="important_3" href="javascript:fnObj.setImportant(3);"><em>+3</em></a></li>
							</ul>
						</td>
						<th scope="row">진행상황</th>
						<td class="vm">
							<div id="progressArea"></div>
							<div id="progressTxtArea" style="display:none;"></div>
						</td>
					</tr>
					<tr id="dotUserBtnLine" style="border-bottom: #9298a2 solid 1px;">
						<th scope="row"  id="dotUserBtnLineTh">참가자</th>
						<td class="vm" colspan="3">
							<a href="javascript:fnObj.userPop();" class="btn_select_employee"><em>직원선택</em></a>
						</td>
					</tr>
					<tr class="dot_line" id="dotUserLine" style="display:none;">
						<td colspan="3">
							<span id="userSelectArea"></span>
						</td>
					</tr>

					<tr style="display:none;">
	                    <th scope="row"  id="approveCcTh">열람권한</th>
	                    <td colspan="3">
	                        <span id="readerTypeTag"  class="radio_list2"></span>
	                        <a id = "readerTypeDept" href="javascript:fnObj.openEmpPopup('DEPT');" class="btn_select_team mgl10" style="display: none;">
	                            <em>부서선택</em>
	                        </a>
	                        <a id = "readerTypeUser" href="javascript:fnObj.openEmpPopup('USER');" class="btn_select_employee mgl10" style="display: none;">
	                            <em>직원선택</em>
	                        </a>
	                    </td>
	                </tr>
	                <tr id = "approveCcTr" style="display: none;">
	                    <td colspan="3" class="dot_line" id = "approveCcArea">
	                    </td>
	                </tr>
				</table>
				<div class="btnZoneBox">
					<a id="regBtn" href="javascript:fnObj.saveWorkDaily();" class="p_blueblack_btn"><strong>저장</strong></a>
					<a href="javascript:parent.myModal.close();" class="p_withelin_btn">취소</a>
				</div>
			</div>

		</div>
		<!--//업무일지등록//-->
	</div>
</form>

<script type="text/javascript">

//Global variables :S ---------------

//공통코드

var myModal = new AXModal();		// instance


var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
//var mySorting = new SSorting();	// instance		new sjs


var g_loginUserId = '${baseUserLoginInfo.userId}';
var g_loginUserName = '${baseUserLoginInfo.userName}';
var g_workUserId = '${workUserId}';				//업무일지 유저아이디
var g_listId = '${listId}';						//업무일지 아이디(seq)

var g_workDate = '${workDate}';					//선택 날짜
var g_workDateHolyYn = "N";                 //주말포함 등록여부
var g_workDateWeek = 0;
var g_idx =0;

var g_entryUserList = []; 						//선택한 유저 리스트.

var g_tabType = "personalLi";  //개인업무:personalLi ,  팀업무 : teamLi

//Global variables :E ---------------
var colorObj = {};
var orgId = "${baseUserLoginInfo.orgId}";

var delArray = new Array();
var g_workMemoId = "";

var g_popType = "";

/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
 var fnObj = {

	preloadCode : function(){
		var progress = getBaseCommonCode('WORKDAILY_PROGRESS', '', 'CD', 'NM', null, '', '', { orgId : "${baseUserLoginInfo.applyOrgId}"} );
		if(progress == null){
			progress = [{ 'CD': '', 'NM' :'선택'}];
		}
		var progressSelect = createSelectTag('progressWork', progress, 'CD', 'NM', null, '', {}, '', 'select_b w_st14');	//select tag creator 함수 호출 (common.js)
		$("#progressArea").html(progressSelect);
		$("#progressWork").append('<option value="COMPLETE">완료</option>');

		g_workDateWeek = getDateWeek(g_workDate);  //0일,1월,2화,3수,4목,5금,6토
		if(g_workDateWeek ==  0 || g_workDateWeek ==  6) g_workDateHolyYn = "Y";
		else g_workDateHolyYn = "N";

		//공통코드조회
        var comCodeType = getBaseCommonCode('WORK_READER_TYPE', null, 'CD', 'NM', null, null, null, { orgId : "${baseUserLoginInfo.applyOrgId}" });
      //라디오박스 생성
        var radioTag = createRadioTag('readerType', comCodeType, 'CD', 'NM', null, 17, null, 'fnObj.clickReaderType(this)');    //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
      //화면 셋팅
        $("#readerTypeTag").html(radioTag);
      //All에 체크
        $("input[type='radio'][name='readerType'][value='ALL']").prop("checked", true);

        $("input[type='radio'][name='readerType'][value='NONE']").parent().find("span").text("설정하지않음(본인만 열람)");


	},

	pageStart : function(){

		fnObj.changeTab('personalLi');

		if(g_listId>0){		//수정일때는 참가자 추가 버튼 안보이게
			$("#tabArea").hide();
			$("#dotUserBtnLine").hide();

		}else{
			commonPropject = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.projectTitle } 선택', { orgId : orgId,userId : "${baseUserLoginInfo.userId}",type:"PROJECT",incApproveActivity:"N",startDate:"${workDate}" });
			var projectTag = createSelectTagForProject('projectId', commonPropject, 'CD', 'NM', '', null, {}, null, 'select_b','PROJECT');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	        //$("#scheType").html(projectTag);
	        $("#projectArea").html(projectTag);

	        $("#projectId").change(function(){
	        	chgProjectId();
	        });


	        $("#activityDescArea").text("");
	        $("#activityId").html("<option value = ''>${baseUserLoginInfo.activityTitle } 선택</option>");

	        if($("#projectId").val()!="") $("#projectId").change();
		}


	},

	//업무일지 (개인) 정보
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
            var memoList = totalObj.memoList;
            var workReaderList = totalObj.workReaderList;

    		// var list = obj.resultList;

    		$("#memo").val(memoList[0].memo);
    		$("#title").val(list[0].title);
    		fnObj.setImportant(list[0].important);

    		var progress=list[0].progress;
    		if(list[0].complete == 'Y') progress ='COMPLETE';

    		$("#progressWork").val(progress);

    		var str = "<div><strong>";
			str += list[0].projectNm+"-";
			str += list[0].activityNm+"</strong> 기간 : "+list[0].activityStartDate+" ~ "+list[0].lastDate+"</div>";
			str += '<input type="hidden" name="projectId" id="projectId" value="'+list[0].projectId+'"/>';
			str += '<input type="hidden" name="openFlag" id="openFlag" value="'+list[0].openFlag+'"/>';
			str += '<input type="hidden" name="employee" id="employee" value="'+list[0].employee+'"/>';
    		$("#projectAreaTd").html(str);

    		//첨부파일 정보
    		g_workMemoId = memoList[0].workMemoId;
    		fnObj.getFileList(memoList[0].workMemoId);

    		 //프로젝트 공개여부에 따른 설정
            var openFlag = list[0].openFlag;
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

          //열람권한
            var readerType = list[0].readerType;
            $("input[type='radio'][name='readerType'][value='"+readerType+"']").prop("checked", true);

    		$("#approveCcArea").empty();
            if(readerType == 'DEPT'){
                $("#readerTypeDept").show();
                $("#readerTypeUser").hide();
                for(var i = 0 ; i <workReaderList.length; i++){
                    $("#approveCcTh").attr("rowspan","2");
                    $("#approveCcTr").show();
                   var usrHtml = '';
                   usrHtml += '<span class="employee_list" >';
                   usrHtml += '<strong>'+ workReaderList[i].deptNm +'</strong><a href="#" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                   usrHtml += '<input type="hidden" name="arrDeptId" id="arrDeptId" value="'+workReaderList[i].deptId+'"/>';
                   usrHtml += '</span>';

                   $("#approveCcArea").append(usrHtml);
                }
            }else if(readerType == 'USER'){
                $("#readerTypeDept").hide();
                $("#readerTypeUser").show();
                for(var i = 0 ; i <workReaderList.length; i++){
                    $("#approveCcTh").attr("rowspan","2");
                    $("#approveCcTr").show();

                    var usrHtml = '';
                    usrHtml += '<span class="employee_list" >';
                    usrHtml += '<strong>'+ workReaderList[i].userNm +'</strong><a href="#" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                    usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+workReaderList[i].userId+'"/>';
                    usrHtml += '</span>';
                    $("#approveCcArea").append(usrHtml);
                }
            }else if(readerType == 'NONE'){
                $("#readerTypeDept").hide();
                $("#readerTypeUser").hide();
            }
    	};

    	commonAjax("POST", url, param, callback, false);
	},

	//탭 변경
	changeTab : function(liId){
		g_tabType = liId;

		$("li[name=tabBtn]").removeClass("on");
		$("#"+liId).addClass("on");

		if(liId == 'personalLi'){				//개인 업무 선택시

			$("#dotUserBtnLine").attr("style", "border-bottom: #9298a2 solid 1px;");
			$("#dotUserBtnLine").hide();		//직원 선택 숨김
			$("#dotUserLine").hide();			//직원 선택 숨김
			$("#dotUserBtnLineTh").attr("rowspan","1");

			if('${listId}'>0){  // 수정이면
				$("#workDateLine").hide();     // 기간 선택 표시
			}else{
				$("#workDateLine").show();     // 기간 선택 숨김
			}
			$("#approveCcTh").text("열람권한");
			$("input[type='radio'][name='readerType'][value='NONE']").parent().find("span").text("설정하지않음(본인만 열람)");
		}else{							//팀 업무 선택시
			$("#dotUserBtnLine").show();		//직원 선택 표시
			$("#workDateLine").hide();     //기간 선택 숨김

			$("#approveCcTh").text("추가열람권한");
			$("input[type='radio'][name='readerType'][value='NONE']").parent().find("span").text("설정하지않음(참가자만 열람)");
		}
		$("#userSelectArea").empty();

		/* if($("input[name='readerType']:checked").val()=='NONE'){
            fnObj.changeNone();
        } */

		parent.myModal.resize();

	},

	//업무기간변경
    changeWorkDate : function(){
    	var workDatePeriod = $('#workDatePeriod option:selected').val();
    	if(workDatePeriod > 1 && (g_workDateWeek ==  0 || g_workDateWeek ==  6)){
    		if(confirm("주말을 선택하셨습니다.\n주말을 포함해서 등록하시려면 '확인'을 \n다음 업무일부터 등록하시려면 '취소'를 클릭하여 주십시요.")){  //확인
    			g_workDateHolyYn = "Y";
    			$("#workDateStart").val('${workDate}');
    			$("#workDateEnd").val(getNextDate('${workDate}', workDatePeriod));
    		}else{  //취소
    			var nextTerm = 1;
    			if(g_workDateWeek ==  0) nextTerm=2;
    			else if(g_workDateWeek ==  6) nextTerm=3;

    			var newWorkDate = getNextDate('${workDate}',nextTerm);
    			g_workDate = newWorkDate;

    			$("#workDateStart").val(newWorkDate);
    			$("#workDateEnd").val(getNextDate(newWorkDate, workDatePeriod));
    			g_workDateHolyYn = "N";
    		}
    	}else if(workDatePeriod == 1 && (g_workDateWeek ==  0 || g_workDateWeek ==  6)){
    		g_workDate = '${workDate}';
    		$("#workDateStart").val(g_workDate);
            $("#workDateEnd").val(g_workDate);
            g_workDateHolyYn = "Y";
    	}else{
    		g_workDate = '${workDate}';
            $("#workDateStart").val(g_workDate);
            $("#workDateEnd").val(getNextDate(g_workDate, workDatePeriod));
            g_workDateHolyYn = "N";
    	}

    },

	//업무일지 등록
	saveWorkDaily : function(){

	   	var important =0;						//중요도
	   	var starList = $("a[name=important]");
	   	var title = $("#title").val();			//제목
	   	var memo = $("#memo").val();			//내용
	   	var workType ='PRIVATE';				//팀업무 여부
	   	var progress = $("#progressWork").val();

	   	var complete = 'N';
		var completeDate = '1988-09-12';

		var projectId = $("#projectId").val();
		var activityId = $("#activityId").val();

		/////진행상태 수정 -> 계획 진행 보류 일때만, 완료 일땐 complete 변경시킴

	   	if(progress == 'COMPLETE'){		//완료  or drop 이면 progress 는 세팅안함
	   		complete = 'Y';
	   		//else complete = 'D';
	   		completeDate = new Date().yyyy_mm_dd();
	   		progress = 'PLAN';

	   	}

	   	for(var i=0;i<starList.length;i++){
	   		if($(starList[i]).hasClass("on")){
	   			important++;
	   		}
	   	}
	   	if(projectId == ""){
			alert("${baseUserLoginInfo.projectTitle}를 선택해 주세요.");
			$("#projectId").focus();
			return;
		}

		if(activityId == ""){
			alert("${baseUserLoginInfo.activityTitle}을/를 선택해 주세요.");
			$("#activityId").focus();
			return;
		}

		if($("#activityId").length>0){
			var activityEndDate = $("#activityId option:selected").attr("enddate");

			var activityEndDateBuf = activityEndDate.split("-").join("");

			var workDateEnd = $("#workDateEnd").val();

			var workDateEndBuf = workDateEnd.split("-").join("");

			if(parseInt(workDateEndBuf)>parseInt(activityEndDateBuf)){
				alert("[${baseUserLoginInfo.activityTitle}]의 종료일이 업무기간의 종료일보다 이전인 업무는 만들 수 없습니다.");
				return;
			}
		}



	   	if(title == ''){
	   		alert("제목을 입력해주세요");
	   		$("#title").focus();
	   		return;
	   	}


	   	/*========================================== 팀 업무등록 세팅 ==============================================*/

    	var teamList = '';

    	var selectUserIdList = $("input[name=selectUserId]");	//시퀀스 리스트

    	var userArr = new Array();

    	for(var i=0;i<selectUserIdList.length;i++){

    		var rowUserIdStr = selectUserIdList[i].value;			//하나의 상세업무에 등록된 아이디 리스트
     		userArr.push(rowUserIdStr);
    	}

    	//팀 메모
		var empMemo ='';

		/* var jobj = new Object();
		jobj.userId=g_loginUserId;
		jobj.name='${baseUserLoginInfo.userName}';
		jobj.regDate=getTimeStamp();
		jobj.position='${baseUserLoginInfo.rankNm}';
		jobj.deptNm='${baseUserLoginInfo.deptNm}';
		jobj.orgNm='${baseUserLoginInfo.orgNm}';
		jobj.orgId='${baseUserLoginInfo.orgId}';
		jobj.empMemo=memo; */

		if($("#teamLi").hasClass("on") && memo == ""){
			alert("상세내용을 입력해주세요.");
			$("#memo").focus();
			return;
		}

		/* if($("#teamLi").hasClass("on")){
			memo =JSON.stringify(jobj);
		} */

		if($("#teamLi").hasClass("on") && selectUserIdList.length == 0){
			alert("참가자를 선택해 주세요.");
			return;
		}

		if(userArr.join(',')!='' && $("#teamLi").hasClass("on")){//선택된 유저리스트가 있을고 탭이 팀일때 팀업무.
	   		workType = 'TEAM';
	   	}


        /*=========== 첨부파일 : S =========== */
        var fileList ='';
        var delFileList='';

        var fileSeqList     = $("input[name=fileSeq]");         //시퀀스 리스트
        var orgFileNmList   = $("input[name=orgFileNm]");       //파일명 리스트
        var newFileNmList   = $("input[name=newFileNm]");       //새로운 저장 파일명 리스트
        var filePathList    = $("input[name=filePath]");        //경로 리스트
        var fileSizeList    = $("input[name=fileSize]");        //파일 크기 리스트
        var jArray = new Array();

        var fileAllSize = 0;
        $("input[name=fileSize]").each(function(index, value){
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

        if(delArray.length !=0){                                        //수정시 삭제한 파일들의 리스트

            delFileList = delArray.join(",");
        }

       /*  if(fileAllSize/(1024*1024) >30){
            alertM("전체 최대용량 30MB 까지 첨부 가능합니다.");
            return false;
        } */

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



        /*=========== 첨부파일 : E =========== */

 		var url =contextRoot + "/work/getChkWorkPerson.do";



	   	var param = {
	   			 listId		 	: g_listId,
	   			 important 		: important,
	   			 projectId      : projectId,
	   			 activityId     : activityId,
	   			 title			: title,
	   			 memo			: memo,
	   			 workDate		: g_workDate,
	   			 workDateHolyYn        : g_workDateHolyYn,

	   			 workType		: workType,
	   			 progress		: progress,
	   			 teamList		: userArr.join(','),
	   			 empMemo		: empMemo,
	   			 complete		: complete,
	   			 completeDate	: completeDate,
	   			 fileList       :   fileList,                //신규 파일 리스트
                 delFileList    :   delFileList,             //수정시 삭제한 파일들의 시퀀스 리스트
                 workMemoId : g_workMemoId,
                 workDatePeriod : $('#workDatePeriod option:selected').val(),
                 workDateStart : $('#workDateStart').val(),
                 workDateEnd : $('#workDateEnd').val(),
                 readerType : $("input[name='readerType']:checked").val(),
                 arrUserId : arrUserId.join(),
                 arrDeptId : arrDeptId.join()
	   	};

	   	var callback = function(result){
			var obj = JSON.parse(result);
			var data = obj.resultObject;

		    if(data.result =="SUCCESS"){
		        url =contextRoot + "/work/saveWorkDaily.do";
		        commonAjax("POST", url, param, workDailyCallback, false);

		    }else{
		        if(data.msg != null){
		        	if($('#workDatePeriod option:selected').val() == "1"){
		        		alert(data.msg);  // 참가자로 지정하신 ... 병가/휴직 ... 참가자로 지정할 수 없습니다.
	                    return;
		        	}else{
		        		if(confirm(data.msg)){  // 참가자로 지정하신 ... 병가/휴직 ... 그래도 참가자로 지정하시겠습니까?"
		        			url =contextRoot + "/work/saveWorkDaily.do";
		                    commonAjax("POST", url, param, workDailyCallback, false);
		        		}else{
		        			return;
		        		}
		        	}

		        }else{
		            dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
		        }
		    }

    	};

    	var workDailyCallback = function(result){
            var obj = JSON.parse(result);
            var listId = obj.resultVal;
            if(listId>0){

                if(parent.fnObj == undefined){
                    parent.sheduleObj.getWorkDailyList();
                }else{
                    parent.fnObj.doSearch(g_loginUserId,'N');
                }

                parent.myModal.close();
                if(workType == 'TEAM'){

                    if(parent.fnObj == undefined){
                        parent.sheduleObj.viewWorkDaily(listId,workType,g_workDate,'VIEW');
                    }else{
                        parent.fnObj.viewWorkDaily(listId,workType,g_workDate,'VIEW');      //팀 업무일때 바로 상세화면
                    }
                }
            }else{
                dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
            }
        };

    	commonAjax("POST", url, param, callback, false);
    },

	//별표세팅
    setImportant : function(val){

    	var starList = $("a[name=important][class=on]");

    	$("a[name=important]").removeClass("on");

    	 for(var i=1;i<=val;i++){
    		 $("#important_"+i).addClass("on");
    	 }
    	 if(val == 1 && starList.length ==1){
			 $("#important_1").removeClass("on");
		 }

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

  //유저선택 공통 팝업
    userPop : function(){

        g_popType = "TEAM";

        var userStr ='';
        var arr =[];
        var selectUserList =$("input[name=selectUserId]");

        if($("#projectId").val() == ""){
            alert("${baseUserLoginInfo.projectTitle}를 선택해 주세요.");
            $("#projectId").focus();
            return;
        }else if($("#activityId").val() == ""){
            alert("${baseUserLoginInfo.activityTitle}을/를 선택해 주세요.");
            $("#activityId").focus();
            return;
        }

        for(var i=0;i<selectUserList.length;i++){
            arr.push(selectUserList[i].value);
        }
        userStr = arr.join(',');

        $("#userStr").val(userStr);

        //1. 공개프로젝트 전직원     : 전사직원선택 가능
        //2. 공개프로젝트 직원 할당 : 프로젝트에 할당된 직원만
        // 3. 비공개 프로젝트          : 프로젝트에 할당된 직원만
        var openFlag = "";
        var employee = "";

        if('${listId}'>0){  // 수정이면
            openFlag = $("#openFlag").val();
            employee = $("#employee").val();
        }else{
        	openFlag = $("#projectId option:selected").attr("openFlag");
            employee = $("#projectId option:selected").attr("employee");
        }


        if(openFlag == "Y" && employee == "A"){
            var paramList = [];
            var paramObj ={ name : 'userList'   ,value : userStr};
            paramList.push(paramObj);
           /*  paramObj ={ name : 'isAllOrg' ,value : 'N'};
            paramList.push(paramObj);
            paramObj ={ name : 'isAllOrgSelect' ,value : 'N'};
            paramList.push(paramObj); */

            paramObj ={ name : 'isOneOrg' ,value : 'Y'};
            paramList.push(paramObj);

            paramList

            paramObj ={ name : 'hasDeptTopLevel' ,value : 'Y'};
            paramList.push(paramObj);  //부서의 회장 부서 표시여부

            userSelectPopCall(paramList);     //공통 선택 팝업 호출
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
        var openFlag = "";
        if('${listId}'>0){  // 수정이면
        	openFlag = $("#openFlag").val();
        }else{
        	if($("#projectId").val() == ""){
                alert("${baseUserLoginInfo.projectTitle}을/를 선택해 주세요.");
                $("#projectId").focus();
                return;
            }else if($("#activityId").val() == ""){
                alert("${baseUserLoginInfo.activityTitle}을/를 선택해 주세요.");
                $("#activityId").focus();
                return;
            }
        	openFlag = $("#projectId option:selected").attr("openFlag");
        }

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
  	        var selectUserIdList = $("input[name=selectUserId]");   //시퀀스 리스트
  	        var newArr = [];
  	        var selectList = [];

  	        for(var i=0;i<selectUserIdList.length;i++){
  	            selectList.push(selectUserIdList[i]);
  	        }

  	        var brCnt = 1;

  	        for(var i=0;i<resultList.length;i++){

  	            if(getArrayIndexWithValue(selectList, resultList[i].userId)<0){     //등록된 사람이 없을때,

  	                str +='<span class="employee_list" id="userOneArea_'+resultList[i].userId+'"><strong>'+resultList[i].userName+'</strong>(';
  	                str +=resultList[i].position+')<a onclick="javascript:fnObj.deleteUser('+resultList[i].userId+');" class="btn_delete_employee"><em>삭제</em></a>';
  	                str +='<input type="hidden" name="selectUserId" value="'+resultList[i].userId+'"/>';
  	                /* if(i<resultList.length-1){
  	                        str+=', ';
  	                } */
  	                str+='</span>';
  	                brCnt++;
  	                //if(brCnt%6 ==1) str+='<br/>';
  	            }else{
  	                alert("이미 참가자로 등록된 사람이 있습니다.");
  	                return;
  	            }

  	        }

  	        $("#userSelectArea").html(str);                 //참가자 이름
  	        fnObj.dotLineDisplaySet();
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

  //삭제버튼 클릭
    deleteUser : function(userId){
        $("#userOneArea_"+userId).remove();
        fnObj.dotLineDisplaySet();

    },

  	//점선줄 판별
  	dotLineDisplaySet : function(){
		var selectUserIdList = $("input[name=selectUserId]");	//시퀀스 리스트

  		//점선 줄 보이기
  		if(selectUserIdList.length>0){
  			$("#dotUserLine").show();
  			$("#dotUserBtnLine").attr("style", "border-bottom:0px; !important");
  			$("#dotUserBtnLineTh").attr("rowspan","2");
  		}
  		else{
  			$("#dotUserLine").hide();
  			$("#dotUserBtnLine").attr("style", "border-bottom: #9298a2 solid 1px;");
  			$("#dotUserBtnLineTh").attr("rowspan","1");
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
                str +='&nbsp; <span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:fnObj.newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
                g_idx++;


            }

            //파일 태그 재 생성.
            $('#fileInputArea').append('<input name="upFile" type="file" multiple class="file_btn_cover"  onchange="fnObj.newFileUpload();">');
            $('#uploadFileList').append(str);
            $('#uploadFileList').show();


            var viewCheckSize = checkFileSize();

            $(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");

            parent.myModal.resize();

        }

        commonAjaxForFileCreateForm(url,"","upFile","100","fileSize", callback , "");

    },

  //첨부파일 리스트
    getFileList : function(workMemoId){
        var url = contextRoot + "/file/getFileList.do";
        var param = {
                        uploadId    : workMemoId,   //g_contentId,
                        uploadType  : 'WORK_MEMO'
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
  //수정시 db 에 이미 저장된 파일삭제 할땐. 바로삭제하지않고 리스트를 만든다.
    setDelFile: function(fileSeq,idx){

        delArray.push(fileSeq);
        $("#li_"+idx).remove();

        if($('#uploadFileList').children().length == 0) $('#uploadFileList').hide();            //ul 숨기기

        var viewCheckSize = checkFileSize();
        $(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");

    },  //end setDelFile
  //파일 바로 삭제
    newFileDelete : function(newFileNm,filePath,idx){
        var url = contextRoot + "/file/deleteFile.do";
        var param = { newFileNm : newFileNm , filePath : filePath};
        var callback = function(result){
            var obj = JSON.parse(result);
            var cnt = obj.resultVal;
            if(cnt>0){
                $("#li_"+idx).remove();
                if($('#uploadFileList').children().length == 0) $('#uploadFileList').hide();    //ul 숨기기
                var viewCheckSize = checkFileSize();
                $(".size").html("<strong>"+viewCheckSize +"</strong>/<em>100MB</em>");
            }
        };
        commonAjax("POST", url, param, callback, false);
    },

  //비공개 프로젝트는 배정된 직원을 기본으로 보여준다.
     /* changeNone : function(){
    	if(g_tabType == "teamLi"){  //팀업무

    		var url = contextRoot + "/work/getProjectUserList.do";
            var param = { projectId : $("#projectId").val()};
            var callback = function(result){
            	var obj = JSON.parse(result);
            	var totalObj = obj.resultObject;
                var projectUserList = totalObj.projectUserList;

                $("#approveCcArea").empty();
                for(var i = 0 ; i <projectUserList.length; i++){
                    $("#approveCcTh").attr("rowspan","2");
                    $("#approveCcTr").show();

                    var usrHtml = '';
                    usrHtml += '<span class="employee_list" >';
                    usrHtml += '<strong>'+ projectUserList[i].userNm +'</strong><a href="#;" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                    usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+projectUserList[i].userId+'"/>';
                    usrHtml += '</span>';

                    $("#approveCcArea").append(usrHtml);
                }
            };
            commonAjax("POST", url, param, callback, false);


        }else if(g_tabType == "personalLi"){  //개인업무
            $("#approveCcArea").empty();
            $("#approveCcTh").attr("rowspan","2");
            $("#approveCcTr").show();

            var usrHtml = '';
            usrHtml += '<span class="employee_list" >';
            usrHtml += '<strong>'+ g_loginUserName +'</strong>';
            usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+g_loginUserId+'"/>';
            usrHtml += '</span>';

            $("#approveCcArea").append(usrHtml);
        }
    } */



 };//end fnObj.

//프로젝트 셀렉트박스 체인지
 function chgProjectId(){
 	var projectId = $("#projectId").val();

 	resetuserSelectArea();

 	$("#activityDescArea").text("");
 	if(projectId == ""){
 		$("#activityId").html("<option value = ''>${baseUserLoginInfo.activityTitle } 선택</option>");
 		return;
 	}

 	var commonActivity = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.activityTitle } 선택', { orgId : orgId,projectId : projectId, userId : "${baseUserLoginInfo.userId}" ,type:"ACTIVITY",incApproveActivity:"N",startDate:"${workDate}"});
 	var activityTag = createSelectTagForProject('activityId', commonActivity, 'CD', 'NM', '', null, colorObj, null, 'select_b mgl6','ACTIVITY');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
 	$("#activityArea").html(activityTag);

 	var openflag = $("#projectId option:selected").attr("openflag");
    var employee = $("#projectId option:selected").attr("employee");

    if(openflag == "N"){  //비공개
        $("input[type='radio'][name='readerType'][value='ALL']").prop("disabled", "disabled");
        $("input[type='radio'][name='readerType'][value='DEPT']").prop("disabled", "disabled");
        $("input[type='radio'][name='readerType'][value='USER']").prop("disabled", "");
        $("input[type='radio'][name='readerType'][value='NONE']").prop("disabled", "");
        $("input[type='radio'][name='readerType'][value='NONE']").prop("checked", true);

    }else{  // 공개
    	$("input[type='radio'][name='readerType'][value='ALL']").prop("disabled", "");
        $("input[type='radio'][name='readerType'][value='DEPT']").prop("disabled", "");
        $("input[type='radio'][name='readerType'][value='USER']").prop("disabled", "");
        $("input[type='radio'][name='readerType'][value='NONE']").prop("disabled", "");
        $("input[type='radio'][name='readerType'][value='ALL']").prop("checked", true);
    }

  //열람권한 리셋.
    fnObj.clickReaderType();

    parent.myModal.resize();

 	$("#activityId").change(function(){
 		resetuserSelectArea();
 		$("#activityDescArea").text("");
 		if($("#activityId").val()==""){
 			$("#activityDescArea").text("");
 			return;
 		}
 		var startDateStr = $("#activityId option:selected").attr("startdate");
 		var endDateStr = $("#activityId option:selected").attr("enddate");

 		$("#activityDescArea").text("기간 : "+startDateStr + " ~ " + endDateStr);
 	});
 	if($("#activityId").val()!="") $("#activityId").change();
 }

 //참가자 Area Reset
 function resetuserSelectArea(){
	 $("#userSelectArea").empty();
     $("#dotUserLine").hide();
     $("#dotUserBtnLineTh").attr("rowspan","1");
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
/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();		//공통코드 or 각종선로딩코드
	fnObj.pageStart();
	if('${listId}'>0){  // 수정이면
		fnObj.getWorkDaily();	//업무일지 정보 받아오기
		$("#workDateLine").hide();     //기간 선택 숨김
	}


	if("${projectId}"!=""){
		$("#projectId").val("${projectId}");

		chgProjectId();

		$("#activityId").val("${activityId}");
	}


});
</script>


