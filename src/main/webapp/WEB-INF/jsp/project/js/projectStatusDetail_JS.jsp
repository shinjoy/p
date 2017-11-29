<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

var myModal = new AXModal();		// instance

var wbsProcessCss = new Object();
var popTargetActivityId;
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

window.onload = function() {
 /*  var url = "<c:url value='/project/projectInfoViewPop.do'/>";
  var callback = function(result){
	  $("#projectInfoPopArea").html(result);
  }
  $("#frm").attr("action",url);
  commonAjaxSubmit("POST",$("#frm"),callback); */
 // commonAjax("POST", url, param, callback);

  	var progress = getBaseCommonCode('WORKDAILY_PROGRESS', '', 'CD', 'NM', null, '', '', { orgId :"${baseUserLoginInfo.orgId}"} );
	if(progress == null){
		progress = [{ 'CD': '', 'NM' :'선택'}];
	}
	leaderProgressSelect = createSelectTag('leaderProgress', progress, 'CD', 'NM', null, '', {}, '', 'select_b w_st05');	//select tag creator 함수 호출 (common.js)




	var moveType = "${param.type}";

	if(moveType == "memo"){
		$("#treeArea").hide();
		$(".verticalWrap").css("background","none");
		var url = "<c:url value='/project/projectInfoViewPop.do'/>";
	    var callback = function(result){
		  $("#projectInfoPopArea").html(result);
		 // doSearchProjectTree("${param.pId}","WBS");
	    }
	    $("#frm").attr("action",url);
	    commonAjaxSubmit("POST",$("#frm"),callback,false);
		moveTab("WBS");

	}else{
		selectProjectDeptTreeTab("PROJECT",null,doSearchProjectTree,null,"${param.pId}","${param.pageNo}","NONE");
	}
};

//화면 최초 로드 후 검색조건을 셋팅함(레이어 팝업 영역에서 프로젝트 정보를 가지고 있어야 함 ....var project , var actList)
function setPageSearchInfo(){
	//프로젝트명 셋팅
	var projectNm = project.name;
	$("#projectNmText").text(projectNm);
	//비공개 열쇠모양 노출여부
	var openFlag = project.openFlag;

	if(openFlag == "N") $("#openNtextArea").show();

	//일정 ,메모 ,업무 , 전자결재가 있는 직원을 검색 셀렉트박스에 셋팅
	/* var empList = project.empList;
	var empStr = "";
	for(var i = 0 ;i<empList.length ; i++){
		var scheChk2 = empList[i].scheChk2;
		var apprChk2 = empList[i].apprChk2;
		var memoChk = empList[i].memoChk;

		if(scheChk2!=""||apprChk2!=""||memoChk!=""){
			empStr += '<option value="'+empList[i].userId+'">'+empList[i].userNm+'</option>';
		}
	}

	$("#searchUserId").append(empStr); */
	var empStr = "";
	var userInfoList = new Set();
	$("input[name='createUserInfo']").each(function(){
		var userInfo = $(this).val();
		userInfoList.add(userInfo);
	});
	$("#searchUserId").html("<option value=\"\">직원 : 전체</option>")
	userInfoList.forEach(function(userInfo){
		var userInfoBuf = userInfo.split("|");
		var userId = userInfoBuf[0];
		var userNm = userInfoBuf[1];
		empStr += '<option value="'+userId+'">'+userNm+'</option>';
	});

	if(empStr!="") $("#searchUserId").append(empStr);


	var activityStr = "";

	for(var i = 0 ; i <actList.length;i++){
		activityStr += '<option value="'+actList[i].activityId+'">'+actList[i].name+'</option>';
	}

	$("#searchActivityId").append(activityStr);
}
//레이어 보였다 안보였다
function showlayer(id){
	$("."+id).toggle();
}

//검색
function doSearch(){
	var url =contextRoot+"/project/projectStatusDetailAjax.do";

	if($("#type").val() == "WBS") {
		url =contextRoot+"/project/projectStatusDetailWbsAjax.do";

		$("#searchUserId").hide();
		$("#searchActivityId").hide();
		$("#searchOrder").hide();
	}else{
		$("#searchUserId").show();
		$("#searchActivityId").show();
		$("#searchOrder").show();
	}

	$("#frm").attr("action",url);

	commonAjaxSubmit("POST",$("#frm"),searchCallback,false);
}

//검색 콜백
function searchCallback(data){

	$("#projectDetailListArea").html(data);

	//var chk =$("#chkSearchMore").val();
	//if(chk == "Y")
	//	$("#btnAllViewList").hide();

}

//검색
function doSearchProjectTree(projectId,type){
	$("#projectId").val(projectId);
	$("#pId").val(projectId);
	$("#chkSearchMore").val("N");

	$("#maxPageRow").val(5);

	$("#searchTreeYn").val("Y");

	$("input[name = 'treeOrg']").remove();

	var $treeOrgInput = $("<input></input>").attr("type","hidden").attr("name","treeOrg").val($("#selectOrgId").val());

	$("#frm").append($treeOrgInput);

	$("#type").val("ALL");
	var url = "<c:url value='/project/projectInfoViewPop.do'/>";
	var callback = function(result){
		  $("#projectInfoPopArea").html(result);

		  $("#searchTreeYn").val("N");
	 }
	 $("#frm").attr("action",url);
	commonAjaxSubmit("POST",$("#frm"),callback,false);
	moveTab("ALL");

	if(type == "WBS") moveTab("WBS");
	//$("#frm").attr("action",contextRoot+"/project/projectStatusDetailAjax.do");
	//commonAjaxSubmit("POST",$("#frm"),searchCallback,false);
}

//검색 콜백
function searchCallback(data){

	/* var searchTreeYn = $("#searchTreeYn").val();
	if(searchTreeYn == "Y"){
		 var url = "<c:url value='/project/projectInfoViewPop.do'/>";
		 var callback = function(result){
			  $("#projectInfoPopArea").html(result);
			  setPageSearchInfo();
			  $("#searchTreeYn").val("N");
		 }
		 $("#frm").attr("action",url);
		 commonAjaxSubmit("POST",$("#frm"),callback,false);
	} */


	$("#projectDetailListArea").html(data);


	//var chk =$("#chkSearchMore").val();
	//if(chk == "Y")
	//	$("#btnAllViewList").hide();

}
//탭이동
function moveTab(type){
	$("#type").val(type);

	$("#tabArea li").removeClass();

	$("#tab_"+type).addClass("current");

	$("#chkSearchMore").val("N");

	$("#maxPageRow").val(5);

	doSearch();
}

//더보기 클릭
function allViewList(){
	$("#chkSearchMore").val("Y");

	/* $("#btnAllViewList").hide(); */

	/* $("#moreListArea").slideDown(); */
	setImagePosition();

	$("#maxPageRow").val(parseInt($("#maxPageRow").val())+15);

	doSearch();
}
//프로젝트 디테일 팝업
function showProjectDetailPop(){
	myModal.openDiv({
		modalID: "my-modal-div",
		targetID: "compnay_dinfo2",
		width:1200,
		closeByEscKey:true
	});
	$(".popHeader").hide();
	$("#my-modal-div_close").hide();
	$('#my-modal-div').draggable();

}

//리스트의 상세보기버튼
function toggleDetail(type,keyId,attr1,attr2,attr3,attr4,attr5){
	switch(type){
	case 'WORK_DAILY_PRIVATE':
		$("#memoDt_"+type+"_"+keyId).toggleClass("multiellipsis");
		$("#moreDetail_"+type+"_"+keyId).toggle();
		$("#collapseDetail_"+type+"_"+keyId).toggle();
		break;
	case 'WORK_DAILY_TEAM':
		$("#memoDt_"+type+"_"+keyId).toggleClass("multiellipsis");
		$("#moreDetail_"+type+"_"+keyId).toggle();
		$("#collapseDetail_"+type+"_"+keyId).toggle();
		var  chkDetail = $("#chkDetail_"+type+"_"+keyId).val();
		if(chkDetail=="N"){
			//getWorkDaily(keyId);
			getWorkDailyTeam(keyId);
			 $("#chkDetail_"+type+"_"+keyId).val("Y");
		}

		break;
	case 'SCHE':
		$("#memoDt_"+type+"_"+keyId).toggleClass("multiellipsis");
		$("#moreDetail_"+type+"_"+keyId).toggle();
		$("#collapseDetail_"+type+"_"+keyId).toggle();
		break;
	case 'APPROVE':


		var projectExpenseType = 'APPROVE';

		var projectExpenseRefId = keyId;
		var param = {projectExpenseType:projectExpenseType,projectExpenseRefId:projectExpenseRefId};

		var url = contextRoot + "/project/getValidProjectExpenseView.do";

		var callback = function(data){
			var obj = JSON.parse(data);

			if(obj.resultObject.result == "SUCCESS"){
				if(projectExpenseType == "APPROVE"){
					var param2 = {
							appvDocId 	: keyId,
							appvDocClass	: attr1,
							appvDocType	: attr2,
							docStatus : attr3,
							userId : attr4,
							orgId : attr5,
							applyOrgId : attr5,
							listType : 'projectStatus'
					   	};

					    var url =contextRoot+"/project/projectStatusDetailApprovePop.do";

					   	myModal.open({
					   		url: url,
					   		pars: param2,
					   		titleBarText: '전자결재 상세',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
					   		method:"POST",
					   		top: $(document).scrollTop(),
					   		width: 1100,
					   		closeByEscKey: true				//esc 키로 닫기
				  		});

				  		$('.AXModalBox').draggable();
				}
			}else{
				alert(obj.resultObject.msg);
				return;
			}

		};

		commonAjax("POST", url, param, callback, true, null, null);

		break;
	}

}

//리스트의 파일 팝업
function openFilePop(type,fileUploadId,activityNm){

	var url =contextRoot+"/project/projectStatusDetailFileListPop.do";
	var width = 750;
	var uploadType = "";

	switch(type){
	case 'WORK_DAILY_PRIVATE':
		uploadType = 'WORK_MEMO';
		break;
	}

	var param = {
			type 	: type,
			fileUploadId	: fileUploadId,
			uploadType:uploadType
 	};


    myModal2.open({
   		url: url,
   		pars: param,
   		titleBarText:'['+activityNm+'] 첨부파일목록',				//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
   		method:"POST",
   		top: $(document).scrollTop()+150,
   		width: 750,
   		closeButton: true,
   		changeCloseBtn: true,
   		closeByEscKey: true					//esc 키로 닫기
	});

   	$('.AXModalBox').draggable();

}
var g_leaderMemoList = [];						//리더메모 정보 리스트
var g_listId;
var g_leaderMemoListNew = [];                      //시용자메모목록
var loginUserId = '${baseUserLoginInfo.userId}';
var leaderProgressSelect ='';
var g_entryUserList = []; 						//선택한 유저 리스트.
var progressSelect ='';
//수정 화면
function editPageStart(){
	var url =contextRoot + "/work/getWorkDaily.do";

  	 var param = {
  			 listId	: g_listId,
  			 orgId : '${baseUserLoginInfo.applyOrgId}'
  	 }
  	var callback = function(result){
  		var obj = JSON.parse(result);
        var totalObj = obj.resultObject;
        var list = totalObj.workList;
        g_leaderMemoList = list;
        g_leaderMemoListNew = totalObj.memoList;
  	 }
  	commonAjax("POST", url, param, callback, false);
	//-------------------------- 그리드 설정 :S ----------------------------
}

//업무일지 팀원의 정보
function getWorkDailyTeam(keyId){
	g_listId = keyId;

	editPageStart();

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

		setImportant(g_leaderMemoList[0].important);


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


			nameAreaStr +=' <strong>'+list[i].userName+'</strong>(';

			//--- 나랑 관계사가 다를때 관계사명 표시
			if(list[i].orgId != '${baseUserLoginInfo.orgId}'){
				nameAreaStr+=list[i].orgNm+'/';
			}
			nameAreaStr+=list[i].position+')';


			nameStr +=list[i].userName;

			if(i < list.length -1){
				nameAreaStr +=',';
				nameStr +=', ';
			}
			/* if((i+1)%4 == 0){
				nameAreaStr +='<br>';
			} */

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
			str +='<dl class="update_sum" style="cursor:pointer;" onclick="detailDisplay('+list[i].empId+');">';
			if(list[i].imgNm==''){
				str +='<dt><img src="'+contextRoot+'/images/work/bg_pic_tm.gif" alt="임시파일"></dt>';
			}else{
				//str +='<dt><img src="<c:url value="/file/downFile.do?uploadType=PROFILEIMG&downFileList='+list[i].userProfileSeq+'"/>"></dt>';
				//str +='<dt><img src="'+list[i].imgPath+'"></dt>';

				str +='<dt><img class="userImg" src="/imgUpLoadData/'+list[i].imgNm+'" alt="'+list[i].userName+'"></dt>';
				//encodeURI( list[i].imgNm, "UTF-8")
			}

			str +='<dd><strong class="tm_name">'+list[i].userName+'</strong><em class="tm_position">(';

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
	    					str +=memoList[k].memo+'</span>';
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
        				str +='<dt><img src="'+contextRoot+'/images/work/bg_pic_tm.gif" alt="임시파일"></dt>';
        			}else{
        				//str +='<dt><img src="<c:url value="/file/downFile.do?uploadType=PROFILEIMG&downFileList=&uploadId='+obj.userId+'"/>"></dt>';
        				str +='<dt><img class="userImg" src="/imgUpLoadData/'+photoObj.imgNm+'"  alt="'+memoList[k].userName+'"></dt>';

        			}
    				str+='<dd><span class="tm_name">'+memoList[k].userName+'</span><em class="tm_position">(';

    				//--- 나랑 관계사가 다를때 관계사명 표시
    				if(memoList[k].orgId != undefined && memoList[k].orgId != '${baseUserLoginInfo.orgId}'){
    					str+=memoList[k].orgNm+'/';
    				}
    				str+=memoList[k].deptNm+'/'+memoList[k].rankNm+')</em>';


    				str+='<span class="update">'+memoList[k].createDate+'</span></dd>';
    				str+='<dd class="messagecon">'+memoList[k].memo.replace(/(?:\r\n|\r|\n)/g, '<br />')+'</dd>';

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
				str +='<span id="fileInputAreaTeamEdit_'+list[i].empId+'" class="file_btn_bg"><input name="upFile" type="file" multiple="" onchange="fnObj.newFileUpload(\'TEAM_EDIT\','+list[i].empId+');" class="file_btn_cover"></span><span class="size"><strong>파일<span>0MB</span></strong> / <em>5MB</em></span>';
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

			/* --------------------------------------------------상세 내역-------------------------------------- */

		}

		$("#userDetailArea_"+keyId).html(str);
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


		detailDisplay('${baseUserLoginInfo.userId}');

		setTeamMemoList(keyId);

	};

	commonAjax("POST", url, param, callback, false);

}

//팀메모 리스트 셋팅
function setTeamMemoList(keyId){
	var stStr = "";

	var memoList = g_leaderMemoListNew;

	for(var i = 0 ; i<memoList.length;i++){
		stStr += '<div class="desbox">';
		stStr += '<p>'+memoList[i].memo.replace(/(?:\r\n|\r|\n)/g, '<br />')+'</p>';
		var createDate = memoList[i].createDate;
		stStr += '<p class="update">'+createDate.split("/").join("-")+'</p>';

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


            stStr +='<dd class="fileAddList_b">';
            stStr +='<p class="title"><strong>첨부파일</strong><span class="count">'+fileList.length+'개<em>'+getFileSize(fileSize) +'</em></span>';
            stStr += '<a href="javascript:fileDown(\'' + downFileList.join(",") + '\','+ fileList.length +')" class="s_white01_btn" id="filedownloadAll" style="">모두저장</a></p>';
            stStr +='<ul id="fileArea">';
            stStr += fileHtml;
            stStr +='</ul>';
            stStr +='</dd>';
            stStr +='</dl>';
        }
        stStr +='</div>';
	}

	$("#memoList_"+keyId).html(stStr);
}
//별표세팅
function setImportant(val){
	 var starList = $(".on").length;

	 $(".on").removeClass("on");

	 for(var i=1;i<=val;i++){
		 $("#important_"+i).addClass("on");
	 }
	 if(val == 1 && starList ==1){
		 $("#important_1").removeClass("on");
	 }

}
//상세내역 펼침
function detailDisplay(empId){

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
 $("#downForm2").attr("action",url);
 $("#downForm2").attr("method","POST");

 $("#downForm2").submit();
}

//파일 사이즈 체크해서 단위와 함께 표시
function getFileSize(fSize){
   var fSExt = new Array('Bytes', 'KB', 'MB', 'GB');
   var j=0;
   while(fSize>900){fSize/=1024;j++;}
   var fileSize = (Math.round(fSize*100)/100)+fSExt[j];
   return fileSize;
}


var myModal2 = new AXModal();		// instance
var now = new Date();
myModal2.setConfig({
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
//메모창 오픈
function openMemo(userId){
	var memoRoomId = 0;
	var viewDate = now.yyyy_mm_dd();
		var param = {
			 memoRoomId : memoRoomId,
			 workUserId	: userId,
			 viewDate	: viewDate
   	};

	    var url =contextRoot+"/work/memoBox2/pop.do";

	    personnelProfileMemoModal.open({
	   		url: url,
	   		pars: param,
	   		titleBarText: '메모',				//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
	   		method:"POST",
	   		top: $(document).scrollTop()+80,
	   		width: 750,
	   		closeByEscKey: true				//esc 키로 닫기
		});

	   	$('.AXModalBox').draggable();
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
   $("#downForm2").attr("action",url);
   $("#downForm2").attr("method","POST");

   $("#downForm2").submit();
}

//첨부파일 텝에서 화면을 그린다
function makeFileArea(type,keyId,name,rankNm,activityNm,startDate,fileUploadId){
	var fileCnt = 0;
	var fileSize = 0;
	var stStr = "";

	var url = contextRoot + "/file/getFileList.do";

	if(type == "WORK_DAILY_PRIVATE") type = "개인업무";
	else if(type == "WORK_DAILY_TEAM") type = "팀업무";
	else if(type == "SCHE") type = "일정";
	else if(type == "APPROVE") type = "전자결재";
	if(fileUploadId.indexOf(",")>-1){
		var fileUploadIdBuf = fileUploadId.split(",");
		for(var i = 0 ; i <fileUploadIdBuf.length ; i++){
			var param = {
					uploadId 	: fileUploadIdBuf[i],
					uploadType  : "${uploadType}"
				}
			var callback = function(result){
				var obj = JSON.parse(result);
				var list = obj.resultList;
				fileList = list;
				var fileHtml = '';

				if(list.length>0){
		    		for(var i=0;i<list.length;i++){

		    			fileHtml+="<dl class=\"pro_fileList last\">";
		    			fileHtml+="<dt><a href='javascript:downLoadFile(\""+list[i].fileSeq+"\")'>"+list[i].orgFileNm+"</a></dt>";
		    			fileHtml+="<dd>";
		    			fileHtml+="<div class=\"historykind\">";
		    			fileHtml+="<span>등록자 : "+name+" "+rankNm+"</span>";
		    			fileHtml+="<span class=\"mgl30\">업무유형 : "+type+"</span>";
		    			fileHtml+="<span class=\"mgl30\">${baseUserLoginInfo.activityTitle} : "+activityNm+"</span>";
		    			fileHtml+="<span class=\"mgl30\">등록일 : "+startDate+"</span>";
		    			fileHtml+="</div></dd></dl>";
					}
				}else{
					//$('#fileList').html('<li>첨부된 파일이 없습니다.</li>');
					//$("#fileBtn").hide();

					//$('#fileArea').hide();		//첨부파일 영역 아예 안보이도록
				}

				$("#projectDetailListArea").append(fileHtml);
			}

			commonAjax("POST", url, param, callback, false);
		}

	}else{
		var param = {
				uploadId 	: fileUploadId,
				uploadType  : "${uploadType}"
			}
		var callback = function(result){
			var obj = JSON.parse(result);
			var list = obj.resultList;
			fileList = list;
			var fileHtml = '';
			if(list.length>0){
	    		for(var i=0;i<list.length;i++){
	    			fileHtml+="<dl class=\"pro_fileList last\">";
	    			fileHtml+="<dt><a href='javascript:downLoadFile(\""+list[i].fileSeq+"\")'>"+list[i].orgFileNm+"</a></dt>";
	    			fileHtml+="<dd>";
	    			fileHtml+="<div class=\"historykind\">";
	    			fileHtml+="<span>등록자 : "+name+" "+rankNm+"</span>";
	    			fileHtml+="<span class=\"mgl30\">업무유형 : "+type+"</span>";
	    			fileHtml+="<span class=\"mgl30\">${baseUserLoginInfo.activityTitle} : "+activityNm+"</span>";
	    			fileHtml+="<span class=\"mgl30\">등록일 : "+startDate+"</span>";
	    			fileHtml+="</div></dd></dl>";


				}
	    		$("#projectDetailListArea").append(fileHtml);
			}else{
				//$('#fileList').html('<li>첨부된 파일이 없습니다.</li>');
				//$("#fileBtn").hide();
			}
		}
		commonAjax("POST", url, param, callback, false);
	}


}
//화면의 이미지 위치를 조정한다
function setImagePosition(){
	var divs = document.querySelectorAll('.projectStatusDt_aspect');
	for (var i = 0; i < divs.length; ++i) {
	  var div = divs[i];
	  var divAspect = div.offsetHeight / div.offsetWidth;
	  div.style.overflow = 'hidden';
		  var img = div.querySelector('img');
		  var imgAspect = img.height / img.width;

		// 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
		  var imgWidthActual = div.offsetHeight / imgAspect;
		  var imgWidthToBe = div.offsetHeight / divAspect;
		  var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2);
		  img.style.cssText = 'width: auto; height: 100%; margin-left: '
		                  + marginLeft + 'px;'

	}
}

//wbs 엑티비티 상세영역에서 주차별/직원별 업무일지를 조회한다.
function searchActivityWbsWorkDetail(activityId , year,startDate,endDate,startWeekNum,endWeekNum,nowWeekNum){
	var url = contextRoot + "/project/searchActivityWbsWorkDetailAjax.do";

	var period =project.period;

	var param = {
			activityId 	: activityId,
			year  : year,
			startDate:startDate,
			endDate:endDate,
			period:period

		}
	var callback = function(result){

		var obj = JSON.parse(result);

		var wbsWorkSearchList = obj.resultObject.wbsWorkSearchList;

		var cnt = 0;
		var totCnt = 0;

		var compareUsreId = 0;
		if(wbsWorkSearchList!=null){
			for(var i = 0 ; i <wbsWorkSearchList.length;i++){
				var workObj = wbsWorkSearchList[i];

				var month = parseInt(workObj.month);
				var weekNum = workObj.weeknum;

				var userId = workObj.empId;
				var $targetObj = $("#activityDtTable_"+activityId+" #activityDtUserArea_"+activityId+"_"+userId+"_"+month+"_"+weekNum).find(".acti_RgList");

				if($targetObj.length == 0){
					activityObj = workObj.activityId;
					var copyHtml = $("#activityDtTotArea_"+activityId).html();
					var stStr = "<tr id = 'activityDtUserArea_"+activityId+"_"+userId+"'>";
					var nameStr = workObj.name;

					copyHtml=copyHtml.split("전체").join(nameStr);

					copyHtml=copyHtml.split("##userId##").join(userId);
					copyHtml=copyHtml.split("##userNm##").join(nameStr);
					copyHtml=copyHtml.split("##rankNm##").join(workObj.userRankNm);

					copyHtml=copyHtml.split("activityDtTotAreaNm").join("activityDtUserAreaNm_"+activityId+"_"+userId);
					copyHtml=copyHtml.split("activityDtTotArea").join("activityDtUserArea_"+activityId+"_"+userId);
					copyHtml=copyHtml.split("activityDtTotAreaTot").join("activityUserTotAreaTot_"+activityId+"_"+userId);

					stStr = stStr + copyHtml + "</tr>";

					$("#activityDtTable_"+activityId+" tbody").append(stStr);

					$("#activityDtTable_"+activityId+" tbody").find(".endDate").each(function(i){
						if(i>0) $(this).remove();
					});
					$("#activityDtTable_"+activityId+" tbody").find(".startDate").each(function(i){
						if(i>0) $(this).remove();
					});

					$targetObj = $("#activityDtTable_"+activityId+" #activityDtUserArea_"+activityId+"_"+userId+"_"+month+"_"+weekNum).find(".acti_RgList");


				}

				var cssStr = "";

				if(workObj.complete=="Y"){
					cssStr = "done_rg";

					$targetObj.find(".done_rg").remove();
				}else{
					cssStr = wbsProcessCss[workObj.progress];
				}

				var stStr = "<li class='"+cssStr+"'></li>";

				$targetObj.find(".no_acti_rg,.delay_rg").remove();
				$targetObj.append(stStr);

				var liLength = $targetObj.find("li").length;

				$targetObj.removeClass();

				$targetObj.addClass("n"+liLength);
				$targetObj.addClass("acti_RgList");
				cnt +=  workObj.cnt;
				if(wbsWorkSearchList.length == i+1 || workObj.empId != wbsWorkSearchList[i+1].empId){

					$("#activityDtUserArea_"+activityId+"_"+workObj.empId+"Tot").text("("+cnt+")");
					cnt = 0;
				}
				totCnt +=  workObj.cnt;
			}
		}

		$("#activityDtTotArea_"+activityId).find("#activityDtTotAreaTot").text("("+totCnt+")");

		var wbsWorkActivityTotMap = obj.resultObject.wbsWorkActivityTotMap;

		var progressRate = wbsWorkActivityTotMap.progressRate;
		if(progressRate == 0){
			var $targetObj = $("#activityDtTable_"+activityId).find(".startDate");

			if($targetObj.length == 0){
				$targetObj = $("#activityDtTable_"+activityId).find(".start");
			}else{
				$targetObj = $targetObj.parent();
			}

			$targetObj.find(".acti_RgList li").eq(0).html("<span class=\"num\">"+progressRate+"%</span>");
		}else{
			var totCnt = $("#activityDtTotArea_"+activityId).find(".acti_RgList").has("li").length;
			try{
			totCnt = parseFloat(totCnt);
			progressRate = parseFloat(progressRate);
			}catch(e){
			}

			var comCnt = parseInt(totCnt*(progressRate/100));

			if(comCnt == 0) comCnt = 1;


			$("#activityDtTotArea_"+activityId).find(".acti_RgList").has("li").each(function(i){
				$(this).empty();

				var stStr = "";
				if(i==0){
					try{
					progressRate=progressRate.toFixed(0);
					}catch(e){

					}
				}

				if(i+1 == comCnt){
					stStr+="<span class=\"num\">"+progressRate+"%</span>"
				}

				$(this).append("<li class=\"done_rg\">"+stStr+"</li>");

				if(i+1 == comCnt){
					return false;
				}
			});
		}


	}

	commonAjax("POST", url, param, callback, false);
}

function wbsActivityViewMonth(activityId , year , month,weekNum,userId,userNm,rankNm){

	if(userId=="##userId##") return;

	var url =  contextRoot + "/project/searchWbsActivityViewMonthDetail.do";
	var params = {
		activityId 	: activityId,
		year  : year,
		month:month,
		weekNum:weekNum,
		searchUserId : userId

	}

	myModal.open({
		windowID:"myModalCT",
		url: url,
		pars: params,
		titleBarText: userNm+"["+rankNm+"]"+" 업무일지 상세목록",		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: $(window).scrollTop() + 150,
		width: 1200,
		closeByEscKey: true			//esc 키로 닫기
	});

	$('#myModalCT').draggable();

}

//wbs월단위 엑티비티 상세
function wbsActivityViewMonth2(activityId , year , month,weekNum,startDate,endDate){
	var url =  contextRoot + "/project/searchWbsActivityViewMonthDetail2.do";
	var params = {
		activityId 	: activityId,
		year  : year,
		month:month,
		startDate:startDate,
		endDate:endDate
	}
	var callback = function(data){

		$("#activityDtTr_"+activityId+"_month").html(data);

		var targetHtml = $("#activityMonthDtTable_"+activityId+" tbody").html();
		targetHtml = targetHtml.trim();

		if(targetHtml=="") $("#activityDtTr_"+activityId+"_month").empty();
	}

	commonAjax("POST", url, params, callback, false);
}

//wbs 엑티비티 상세영역에서 월별/직원별 업무일지를 조회한다.
function searchActivityMonthWbsWorkDetail(activityId , year,startDate,endDate,searchStartDt,searchEndDt){
	var url = contextRoot + "/project/searchActivityMonthWbsWorkDetail.do";

	var period =project.period;

	var param = {
			activityId 	: activityId,
			year  : year,
			startDate:startDate,
			endDate:endDate,
			period:period,
			searchStartDt:searchStartDt,
			searchEndDt:searchEndDt

		}
	var callback = function(result){

		var obj = JSON.parse(result);

		var wbsWorkSearchList = obj.resultObject.wbsWorkSearchList;

		var cnt = 0;
		var totCnt = 0;

		var compareUsreId = 0;
		if(wbsWorkSearchList!=null){
			for(var i = 0 ; i <wbsWorkSearchList.length;i++){
				var workObj = wbsWorkSearchList[i];

				var month = parseInt(workObj.month);
				var date = workObj.date;
				var userId = workObj.empId;
				var $targetObj = $("#activityMonthDtTable_"+activityId+" #activityMonthDtUserArea_"+activityId+"_"+userId).find("#activityMonthDtTotArea_"+activityId+"_"+userId+"_"+date).find(".acti_RgList");


				if($targetObj.length == 0){
					activityObj = workObj.activityId;
					var copyHtml = $("#activityMonthDtTotArea_"+activityId).html();
					var stStr = "<tr id = 'activityMonthDtUserArea_"+activityId+"_"+userId+"'>";
					var nameStr = workObj.name;

					copyHtml=copyHtml.split("전체").join(nameStr);

					copyHtml=copyHtml.split("##userId##").join(userId);
					copyHtml=copyHtml.split("##userNm##").join(nameStr);
					copyHtml=copyHtml.split("##rankNm##").join(workObj.userRankNm);

					copyHtml=copyHtml.split("activityMonthDtTotAreaNm").join("activityMonthDtTotAreaNm_"+activityId+"_"+userId);
					copyHtml=copyHtml.split("activityMonthDtTotArea_"+activityId).join("activityMonthDtTotArea_"+activityId+"_"+userId);
					copyHtml=copyHtml.split("activityMonthDtTotAreaTot").join("activityMonthDtTotAreaTot_"+activityId+"_"+userId);

					stStr = stStr + copyHtml + "</tr>";

					$("#activityMonthDtTable_"+activityId+" tbody").append(stStr);

					$("#activityMonthDtTable_"+activityId+" tbody").find(".endDate").each(function(i){
						if(i>0) $(this).remove();
					});
					$("#activityMonthDtTable_"+activityId+" tbody").find(".startDate").each(function(i){
						if(i>0) $(this).remove();
					});

					$targetObj = $("#activityMonthDtTable_"+activityId+" #activityMonthDtTotArea_"+activityId+"_"+userId+"_"+date).find(".acti_RgList");


				}

				var cssStr = "";

				if(workObj.complete=="Y"){
					cssStr = "done_rg";
					$targetObj.find(".done_rg").remove();
				}else{
					cssStr = wbsProcessCss[workObj.progress];
				}

				var stStr = "<li class='"+cssStr+"'></li>";

				$targetObj.find(".no_acti_rg,.delay_rg").remove();

				$targetObj.append(stStr);

				var liLength = $targetObj.find("li").length;

				$targetObj.removeClass();

				$targetObj.addClass("n"+liLength);
				$targetObj.addClass("acti_RgList");
				cnt +=  workObj.cnt;
				if(wbsWorkSearchList.length == i+1 || workObj.empId != wbsWorkSearchList[i+1].empId){

					$("#activityDtMonthUserArea_"+activityId+"_"+workObj.empId+"Tot").text("("+cnt+")");
					cnt = 0;
				}
				totCnt +=  workObj.cnt;
			}
		}

		$("#activityMonthDtTable_"+activityId+ " tbody tr").eq(0).remove();

	}

	commonAjax("POST", url, param, callback, false);
}

//프로젝트 월 상세 삭제
function wbsActivityViewMonthHide(activityId){
	$("#activityDtTr_"+activityId+"_month").empty();
}

//참여자 셋팅
function setMemoSendList(){
	var setMemoSendUserArr = [];

	$("tr[id *= 'activityDtUserArea_"+popTargetActivityId+"']").each(function(){
		var targetId = $(this).attr("id");

		var userId = targetId.split("_")[2];

		setMemoSendUserArr.push(userId);
	});

	return setMemoSendUserArr;
}
</script>
