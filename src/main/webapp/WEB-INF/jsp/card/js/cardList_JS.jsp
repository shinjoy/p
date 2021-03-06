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
<style>
.display-none {
    display:none;
}

.word_wrap2{
	max-height: 39px;
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    word-wrap: break-word;
    text-overflow: ellipsis;
}
.word_wrap{
	text-overflow:ellipsis;
	white-space:nowrap;
	word-wrap:normal;
	width:100px;
	overflow:hidden;

}
</style>
<script>
function newMap() {
	var map = {};
  	map.value = {};
  	map.getKey = function(id) {
    	return "k_"+id;
  	};
  	map.put = function(id, value) {
    	var key = map.getKey(id);
    	map.value[key] = value;
  	};

  	map.get = function(id) {
    	var key = map.getKey(id);
    	if( map.value[key] ) {
      		return map.value[key];
    	}
    	return null;
  	};

	  return map;
}

function showlayer(id){
	if( id.style.display == 'none' ){id.style.display='block';}
	else{id.style.display = 'none';}
}

//화면재로딩
function doRefreshPage(){
	var url = contextRoot+"/card/cardIndex.do";

	window.location.href = url;
}

function setdayFull(knd){
	var h = '';
   	if( knd == 'week_allday' )
   		h = '99px';
   	else
   		h = '200px';

   	if( $('#'+knd).css('max-height') == h )
   		$('#'+knd).css('max-height','none');
   	else
   		$('#'+knd).css('max-height', h);
}
//Global variables :S ---------------

//공통코드

var g_chargeType	   = '';								  //담당자 타입	...	'all':전체보기, 'notyet':미담당보기, '':특정담당자, 'new':신규등록고객(꼽사리)
var g_chargeStaffCusId = "${baseUserLoginInfo.cusId}";		  //담당자 사원 고객id ... 담당자 일경우 (처음에는 로그인 사용자 고객id)
var g_division         = "${baseUserLoginInfo.orgId}";	      //관계사id
var g_staffList        = new Array();						  //담당자 전체 리스트 ... [{cusId:'123', usrNm:'시너지'}]
var g_sabun            = "${baseUserLoginInfo.empNo}";		  //로그인유저사번
var g_loginId          = "${baseUserLoginInfo.loginId}";	  //로그인유저아이디
var g_permission       = "${baseUserLoginInfo.permission}";	  //permission
var g_deptId           = "${baseUserLoginInfo.deptId}";		  //teamId
var g_deptMngr         = "${baseUserLoginInfo.deptMngrEmpNo}";//부서장 사번
var g_sortCol          = '';								  //소팅 컬럼
var g_sortAD           = '';								  //소팅 방향(A or D)

var cardList ;
var dv2List=[];												   //dv2 리스트
var dvList=[];												   //dv 리스트

var orgCardLinkYn = "${baseInfo.orgCardLinkYn}";				//카드사용연동여부
var staffUserId = "${baseInfo.staffUserId}";  					//지출처리자 아이디
var staffDeptId = "${baseInfo.staffDeptId}";
var cardUseCnt = parseInt("${baseInfo.cardUseCnt}");  			 //사용 소유 카드 개수
var usedCardCnt;												 //조회 목록에서 카드정보가 있는 데이터의 개수
var cardLinkYnCnt = parseInt("${baseInfo.cardLinkYnCnt}");

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		dv2List = getBaseCommonCode('ACCOUNT_SUBJECT', '', 'CD', 'NM', null, '', '',{ orgId : "${baseUserLoginInfo.applyOrgId}"});
		if(dv2List == null){
			dv2List = [{ 'CD': '', 'NM' :'선택'}];
		}
		dvList = getBaseCommonCode('', '', 'CD', 'NM', null, '', '',{sSortOrder : 'Y' , parentCodeSetNm : 'ACCOUNT_SUBJECT', orgId : "${baseUserLoginInfo.applyOrgId}"});
		if(dvList == null){
			dvList = [{ 'CD': '', 'NM' :'선택'}];
		}
		fnObj.setDatepicker('startDate');
		fnObj.setDatepicker('endDate');

		fnObj.yearSetting();		//년도 셀렉트박스 세팅
    	fnObj.monthSetting();		//월 세팅
    	fnObj.searchTypeSetting();	//분류 세팅
    },

	//화면세팅
    pageStart: function(){

    	/*=========================================== 달력 세팅 : S ===========================================*/
    	var nowDate = new Date();
    	var dateArr = nowDate.yyyy_mm_dd().split('-');
    	var nowWeekName =nowDate.getDay(); 				//오늘 번호
    	var setNum = 0;
    	if(nowWeekName>0 && nowWeekName<7){				//오늘 월~토
    		setNum = 4-nowWeekName;
    	}else{											//오늘 일
    		setNum = -3;								//목요일 번호
    	}
    	var thuDay = new Date(dateArr[0],parseInt(dateArr[1])-1,parseInt(dateArr[2])+setNum);	//목요일 날짜
    	var thuStr = thuDay.yyyy_mm_dd();
    	$("#endDate").val(thuStr);

    	var thuArr = thuStr.split("-");															//목요일 기준
    	var friDay = new Date(thuArr[0],parseInt(thuArr[1])-1,parseInt(thuArr[2])-6);			//-6 지난주 금
    	var friStr = friDay.yyyy_mm_dd();
    	$("#startDate").val(friStr);
    	/*=========================================== 달력 세팅 : E ===========================================*/

    },//end pageStart.

    // 승인등록
	regApproval: function(approveYn, sNb){

		var url  = contextRoot + "/card/insertApproval.do";
		var jObj;
		var approValMsg = '';

		//승인
		if(approveYn == 'Y'){

			jObj = $('input:checkbox[class=approvalChk]:checked');

			if( jObj.length==0 ){
				alert("승인항목을 선택하신 후 승인하시기 바랍니다.");
				return;

			}else{

		    	var snbList = ''; 			 					// snb list
	    		var chkedCnt = jObj.length;  					// 체크한 승인수
	    		var checkList = $("input[class='approvalChk']"); // sNb 체크박스

	    		for( var i=0; i<checkList.length; i++ ){
		    		if( checkList[i].checked ){
		    			snbList += ',';
		    			snbList += $(checkList[i]).attr('rel-val');
		    		}
		    	}

		    	snbList = snbList.substring(1); // 앞 ','제거

		    	approValMsg = chkedCnt + ' 건 모두 승인처리 하시겠습니까?';
			}

		}else{//승인취소


			snbList = sNb;
			approValMsg = '승인취소 하시겠습니까?';
		}

		if( confirm(approValMsg) ){

			$("input[name*='chkAll_']").prop("checked", false);

    		var param = {
       				sNbList 	: snbList,
       				approveYn	: approveYn
       		};

    		var callback = function(result){
    	   		var obj = JSON.parse(result);
    	   		var cnt = obj.resultVal;

    	   		if( obj.result == "SUCCESS" ){
    	   			alert("완료되었습니다.");
    		   		fnObj.doSearch();

    	   		}else{
    	   			alert("서버오류입니다.");
    	   		}

    	   	};
    		commonAjax("POST", url, param, callback, false, null, null);

    	}

	},


  	//검색
    doSearch: function(){
    	$(".click_memo").removeClass();
    	$("#memoArea").hide();

    	var choiceYear 	= $("#choiceYear").val();
    	var choiceMonth = $("#choiceMonth").val();
    	var startDate = $("#startDate").val();
    	var endDate = $("#endDate").val();
    	var dv2 = $("#dv2").val();
    	var nowDate = new Date().yyyy_mm_dd();
    	var userList = [];
    	if(choiceYear==''){
    		choiceYear  = nowDate.substring(0,4);
    	}

    	var choiceDate ='';
    	if(choiceMonth==''){
    		choiceDate  = '';
    		if(startDate>endDate){
    			alert("시작일이 종료일보다 이후 입니다.");
    			return false;
    		}
    	}else{
    		if(parseInt(choiceMonth)<10 && choiceMonth.length<2){
    			choiceMonth='0'+choiceMonth;
    		}
    		choiceDate =choiceYear+'-'+choiceMonth;
    	}
    	if(dv2 == 0){dv2 = '';}
		var url = contextRoot + "/card/getCardList.do";
    	var param = {
		    			dv2 			: dv2,
						choiceDate 		: choiceDate,
						startDate 		: startDate,
						endDate 		: endDate,
						usrId 			: $("#usrId").val(),
						searchDeptId 	: $("#searchDeptId").val(),
						searchOrgId     : $("#searchOrgId").val(),
						sorting			: '3',
						checkCount		: $('input:checkbox[name="chkboxStaff"]:checked').length
    				};


    	var callback = function(result){

    		var obj = JSON.parse(result);
    		cardList = obj.cardList;
    		var deptList = obj.deptList;
    		var baseInfo = obj.baseInfo;

    		fnObj.doDrawTableHeader(deptList, cardList, 0);					//데이터 그리드

    		$('#total_count').html(' '+cardList.length);

    		var targetOrgId = $("#treeOrg").val()==null?$("#targetOrgId").val():$("#treeOrg").val();
    		staffUserId = baseInfo.staffUserId;
    		staffDeptId = baseInfo.staffDeptId;

			// 지출등록버튼 노출여부 판단.
			if( targetOrgId != "${baseUserLoginInfo.orgId}" || baseInfo.orgCardLinkYn=="Y"){
				$("#regYnBtn").hide();
			}else{
				$("#regYnBtn").show();


			}

			fnObj.displayBtn();


    	};
    	commonAjax("POST", url, param, callback, false, '', '');

    },//end doSearch

	//그리드
    doDrawTableHeader : function(deptUserList, cardList, deptId){


    	var compareDeptId = 0;
    	var str = '';

    	for(var i=0; i<deptUserList.length; i++){
    		var data = deptUserList[i];

    		if(data.deptId != compareDeptId){

    			if(i != 0){
    				str += '</tbody>';
    				str += '</table>';
    				str += '</div>';
    				str += '</div>';

    				str += '<div class="btn_baordZone" style=" border:none;margin:0px;padding-top: 20px;">';
        			str += '<a href="javascript:fnObj.regApproval(\'Y\');" class="btn_blueblack btnApproval" style="display:none;">승인</a>';
        			str += '</div>';

    			}




    			str += '<h3 class="h3_title_basic mgt20"><span>'+data.deptNm+'</span></h3>';
    			str += '<div class="spending_st_box">';
    			str += '<span class="scroll_cover"  onclick="javascript:setdayFull(\'sp_scroll_body_'+data.deptId+'\');"></span>';
    			str += '<div class="sp_scroll_header">';
    			str += '<table class="tb_list_basic" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">';
    			str += '<caption>지출 리스트</caption>';

    			str += '<colgroup>';
    			str += '<col width="3%"  class="chkBoxArea"/>';
    			str += '<col width="10%" />';
    			str += '<col width="7%"  />';
    			str += '<col width="10%" />';
    			str += '<col width="10%" />';
    			str += '<col width="10%" />';
    			str += '<col width="5%"  />';
    			str += '<col width="*"  />';
    			str += '<col width="8%" />';
    			str += '<col width="9%" />';
    			str += '<col width="10%" />';
    			str += '<col width="6%"  />';
    			str += '</colgroup>';


    			str += '<thead>';
    	        str += '     <tr>';
    	        str += '         <th scope="col" class = "chkBoxArea"><label><input type="checkbox" id="chkAll_'+data.deptId+'" name="chkAll_'+data.deptId+'" onclick="fnObj.tableChkBoxEventSet('+data.deptId+',\'Y\');"/><em class="hidden">전체선택</em></label></th>';
    	        str += '         <th scope="col" class = "cardUseArea"><a href="javascript:;" onclick="fnObj.doSort(\'card\',this,'+data.deptId+');" id="card'+data.deptId+'" name="sortBtn'+data.deptId+'" class="sort_normal">카드</a></th>';
    	        str += '         <th scope="col"><a href="javascript:;" onclick="fnObj.doSort(\'tmDt\',this,'+data.deptId+');" id="tmDt'+data.deptId+'" name="sortBtn'+data.deptId+'" class="sort_hightolow">지출일자</a></th>';
    	        str += '         <th scope="col">업무구분</th>';

    	        str += '         <th scope="col"><a href="javascript:;" onclick="fnObj.doSort(\'dvStr\',this,'+data.deptId+');" id="dvStr'+data.deptId+'" name="sortBtn'+data.deptId+'" class="sort_normal">항목</a></th>';

    	        str += '         <th scope="col">사용처/장소</th>';
    	        str += '         <th scope="col">금액</th>';

    	        str += '         <th scope="col">지출내용</th>';
    	        str += '         <th scope="col">참석자</th>';
    	        str += '         <th scope="col"><a href="javascript:;" onclick="fnObj.doSort(\'staffNm\',this,'+data.deptId+');" id="staffNm'+data.deptId+'" name="sortBtn'+data.deptId+'" class="sort_normal">등록자</a></th>';
    			str += '		 <th scope="col">비고</th>';
    	        str += '         <th scope="col"><a href="javascript:;" onclick="fnObj.doSort(\'approveYn\',this,'+data.deptId+');" id="approveYn'+data.deptId+'" name="sortBtn'+data.deptId+'" class="sort_normal">승인</a></th>';
    	        str += '     </tr>';
    	        str += ' </thead>';
    	        str += ' </table>';
    			str += ' </div>';


    			str += '<div id="sp_scroll_body_'+data.deptId+'" class="sp_scroll_body" style="min-height: 200px;">';
    	        str += ' 	<table class="tb_list_basic" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">';
    	        str += '     	<colgroup>';
    	        str += '			<col width="3%"  class="chkBoxArea"/>';
    			str += '			<col width="10%" />';
    			str += '			<col width="7%"  />';
    			str += '			<col width="10%" />';
    			str += '			<col width="10%" />';
    			str += '			<col width="10%" />';
    			str += '			<col width="5%"  />';
    			str += '			<col width="*"  />';
    			str += '			<col width="8%" />';
    			str += '			<col width="9%" />';
    			str += '			<col width="10%" />';
    			str += '			<col width="6%"  />';
    	        str += '        </colgroup>';
    	        str += '        <tbody id="tbody_'+data.deptId+'">';

    		}

    		compareDeptId = data.deptId;

    	}

    	$("#listArea").html(str);

    	/* 데이터 그리드 */
    	fnObj.doDrawTableData(cardList,0);
    	fnObj.sumSetting();

    },

    /* 데이터 그리드 */
    doDrawTableData : function(cardList,deptId){


    	var str = '';

    	for(var i=0; i<cardList.length; i++){

    		var onlyDeptChk = false;

    		var data = cardList[i];


    		if(deptId == '0'){

    			onlyDeptChk = true;
    			str = '';

    		}else if(deptId != '0' && data.deptId == deptId ) onlyDeptChk = true;

    		if(onlyDeptChk){



		    	str += ' <tr>';
				str += ' 	<td class="chkBoxArea"><input type="checkBox" id="subChk'+data.sNb+'" name="subChk'+data.deptId+'" '+(data.approveYn == 'Y' ? 'disabled="true"' : '')+' class="approvalChk" rel-val="'+data.sNb+'" onclick="fnObj.tableChkBoxEventSet('+data.deptId+',\'N\');"/></td>';
				str += ' 	<td onclick="fnObj.cardRegView('+data.sNb+');">'+data.cardNickname+'</td>';
				str += ' 	<td onclick="fnObj.cardRegView('+data.sNb+');">'+data.tmDt+'</td>';
				str += ' 	<td onclick="fnObj.cardRegView('+data.sNb+');"><div class="word_wrap2">'+data.projectNm+':'+data.activityNm+'</div></td>';
				str += ' 	<td onclick="fnObj.cardRegView('+data.sNb+');">'+data.dv2Str+'/'+data.dvStr+'</td>';
				str += ' 	<td onclick="fnObj.cardRegView('+data.sNb+');">'+data.place+'</td>';
				str += ' 	<td onclick="fnObj.cardRegView('+data.sNb+');">'+data.price+'</td>';
				str += '  	<td onclick="fnObj.cardRegView('+data.sNb+');">'+data.note+'</td>';
				str += '	<td onclick="fnObj.cardRegView('+data.sNb+');">'+data.staff+'</td>';
				str += '	<td>'+data.staffNm;

				if("${baseUserLoginInfo.orgBasicAuth}" != "READ"&&((data.sabun == '${baseUserLoginInfo.empNo}' && data.approveYn == 'N') ||"${baseUserLoginInfo.orgBasicAuth}" == "SUPER")){

					str += '<div><a name="reg_btn" class="btn_s_type_g" onclick="fnObj.cardReg('+data.sNb+',\''+data.approveYn+'\')" style="cursor:pointer;">수정</a>';
					str += '<a name="reg_btn" class="btn_s_type_g" onclick="fnObj.doDelete('+data.sNb+',\''+data.approveYn+'\')" style="cursor:pointer;">삭제</a></div>';
				}

				str += '	</td>';
				str += '	<td>';
				str += '	<a class="memoBtn" onclick="fnObj.openMemo(this,'+data.sNb+');" style="cursor:pointer;"><em>비고입력</em></a>';
				str += '	<span class="memoCon"><a onclick="fnObj.openMemo(this,'+data.sNb+');" style="word-break: break-all;">'+data.feedback+'</a></span>';
				str += '	<div id="memo_'+data.sNb+'" class="memoInnerArea"></div>';
				str += '	</td>';
				str += '	<td>';
				str += '	<input type="hidden" id="approvalId" value="'+data.approvalId+'"/>';

				if(data.approveYn == 'Y'){
					str += '<span class=""><em value="kakakak">승인('+data.approvalNm+')</em></span>';

					str += '<div><a name="reg_btn" class="btn_s_type_g btn_auth btnApprovalCan" onclick="fnObj.regApproval(\'N\','+data.sNb+')" style="cursor:pointer;">승인취소</a></div>';
				}else{
					str += '<span class=""><em value="kakakak">미승인</em></span>';
				}

				str += '</td>';
				str += '</tr>';


    		}

    		if(deptId == 0) $("#tbody_"+data.deptId).append(str);	//전체 다시 그리기
    	}


    	if(deptId != '0') $("#tbody_"+deptId).html(str);			//해당 부서에만 그리기

    },

    //LEFT 사원 선택
    selStaff : function(userList,orgId){
    	$("#searchOrgId").val(orgId);
    	$("#usrId").val(userList);
    	fnObj.doSearch();
    },

    /* ====================================== 팝업 관련 : S ===================================*/

    //지출등록팝업
    cardReg: function(sNb){
    	var url = "${pageContext.request.contextPath}/card/regCard/pop.do?cardSnb="+sNb;
    	var option = "left=" + (screen.width > 1400?"700":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=900, height=700, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	window.open(url, "_blank", option);
    },

  	//지출보기팝업
    cardRegView: function(sNb){
    	var url = "${pageContext.request.contextPath}/card/regCardView/pop.do?cardSnb="+sNb;
    	var option = "left=" + (screen.width > 1400?"700":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=900, height=700, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	window.open(url, "_blank", option);
    },


    //메모팝업
	openMemo : function(th,sNb){


    	//일단 비우고
    	$(".memoInnerArea").empty();

    	$("#feedbackSelect").val('');
    	$("#memoText").val('');
    	var obj = getRowObjectWithValue(cardList,'sNb',sNb);	//리스트중에 해당 sNb 의 정보를 뽑아낸다
    	var memo = obj.feedback;

    	if(memo == null || memo == ''){
    		memo='';
    		var textAreaTxt ='';
        	$("#memoSave").show();
    		$("#memoEdit").hide();

    	}else{
    		$("#memoText").val(memo);
    		$("#memoSave").hide();
    		$("#memoEdit").show();
    	}

    	var txt = '';

    	txt+='<div id="memoArea" class="memoAreaWrap">';
   		txt+='	<h4 class="memotitle">[비고입력]</h4>';
		txt+=' 	<div id="memoSpending"><textarea class="txtarea_b w100pro" id="memoText" placeholder="정해진 규정내 지출 필요합니다." value="" >'+memo+'</textarea></div>';
		txt+='	<div class="btnzone">';
		txt+='	<a href="javascript:fnObj.regMemo();" id="memoSave" class="btn_s_type_g" style="cursor:pointer;">'+(memo == null || memo == '' ? '등록' : '수정')+'</a>';
		txt+='	<a href="javascript:fnObj.eleMemoDiv('+sNb+');" class="btn_s_type_g" style="cursor:pointer;">닫기</a>';
		txt+='</div>';
		txt+='</div>';

    	$("#cardSnb").val(sNb);
    	$("#memo_"+sNb).html(txt);
		$("#memo_"+sNb).show();
	},

	//소모품 팝업
	viewSupplies : function(sNb){
    	var url = "${pageContext.request.contextPath}/card/popSupplies/pop.do?cardSnb="+sNb;
    	var option = "left=" + (screen.width > 1400?"750":"0") + ", top=" + (screen.height > 810?"250":"0") + ", width=400, height=300, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	window.open(url, "_blank", option);
    },


	/* ====================================== 팝업 관련 : E ===================================*/

	/* ====================================== 메모 관련 : S ===================================*/

	//메모 셀렉트 변경 textArea 세팅
    setText : function(memo){
    	if($("#feedbackSelect").val() != ''){
    		if(memo!=''){
    			$("#memoText").val(memo+$("#feedbackSelect option:selected").text()+'\n');
    		}else{
    			$("#memoText").val($("#feedbackSelect option:selected").text());
    		}
    	}else{
    		$("#memoText").val("");
    	}
    },

    //메모등록,수정
	regMemo : function(){
			if($('#memoText').val() == ''){
				alert("내용을 입력하세요");
				return false;
			}

		 	var param ={
		 			sNb		: $("#cardSnb").val(),
		 			feedback: $('#memoText').val()

		 	};

		    var url = "../card/insertCardFeedback.do";

		    var callback = function(){

		    	$("#memoArea").hide();
				alert("저장되었습니다.");
				fnObj.doSearch();
		    }

		    commonAjax("POST", url, param, callback, false);

	},

	//메모 click 초기화.
	eleMemoDiv : function(sNb){
		$("#memo_"+sNb).empty();
		$('#memo_'+sNb).hide();
	},
	/* ====================================== 메모 관련 : E ===================================*/

	//삭제
	doDelete: function(sNb){
		if(confirm("삭제하시겠습니까?")){
		   	var url = contextRoot + "/card/deleteCardUse.do";
		   	var param = {sNb : sNb};
		   	var callback = function(result){
		   		var obj = JSON.parse(result);
		   		var chk = obj.resultVal;
		   		if(chk>0){
		   			alert("삭제되었습니다.");
			   		fnObj.doSearch();
		   		}else{
		   			alert("서버오류!!!.");
		   		}

		   	};
			commonAjax("POST", url, param, callback, false, null, null);
		}
   	},//end doDelete

   	//엑셀다운로드
    excelDownList: function(){
    	var htmlStr = "<table>";
    	//htmlStr += '<tr bgcolor=silver><td>카드</td><td>항목</td><td>금액</td><td>소속회사</td><td>이름</td><td>장소</td><td>지출내용</td><td>시너지참석자</td><td>등록자</td><td>상태</td></tr>';
    	htmlStr += $('#listArea').html().replace(/checkbox/gi,'hidden').replace(/<em>선택<\/em>/gi, '').replace(/img/gi, 'hidden').replace(/수정/gi, '');
    	htmlStr += "</table>";
    	htmlStr += "<table>";
    	htmlStr += $('#SGridTargetSum').html();
    	htmlStr += "</table>";
    	excelDown(htmlStr, '지출'+(new Date().yyyy_mm_dd()));
    },


    /* ====================================== 화면 세팅 관련 : S ===================================*/




    //컬럼 소팅
    doSort: function(sortCol, obj, deptId){

    	var direction = "DESC";

    	if($(obj).attr('class') == 'sort_hightolow'){
    		direction = "ASC";
    		$(obj).attr('class', 'sort_lowtohigh');
    	}else{
    		$(obj).attr('class', 'sort_hightolow');
    	}

    	$('[name="sortBtn'+deptId+'"]').not('[id="'+sortCol+deptId+'"]').attr('class','sort_normal');

        sortByKey(cardList, sortCol, direction);

        fnObj.doDrawTableData(cardList, deptId);


        var targetOrgId = $("#treeOrg").val()==null?$("#targetOrgId").val():$("#treeOrg").val();

		// 지출등록버튼 노출여부 판단.
		if( targetOrgId != "${baseUserLoginInfo.orgId}" || orgCardLinkYn=="Y"){
			$("#regYnBtn").hide();
		}else{
			$("#regYnBtn").show();
		}
	/* 	// 지출 승인버튼 노출 여부 판단.
		if("${baseUserLoginInfo.orgBasicAuth}" != "READ" && targetOrgId == "${baseUserLoginInfo.orgId}"
					&& ("${baseUserLoginInfo.userId}" == staffUserId
						|| "${baseUserLoginInfo.deptId}" == staffDeptId)){
			$(".btnApproval").show();
			$(".chkBoxArea").show();

		}else{

			$(".btnApproval").hide();
			$(".chkBoxArea").hide();
		}
 */
		fnObj.displayBtn();

    },//end doSort

    displayBtn : function(){

    	var targetOrgId = $("#treeOrg").val()==null?$("#targetOrgId").val():$("#treeOrg").val();

    	// 지출 승인버튼 노출 여부 판단.
		if(targetOrgId == "${baseUserLoginInfo.orgId}"
				&& ("${baseUserLoginInfo.userId}" == staffUserId
					|| "${baseUserLoginInfo.deptId}" == staffDeptId)){
			$(".btnApproval").show();
			$(".chkBoxArea").show();
			$('.btnApprovalCan').show();

		}else{

			$(".btnApproval").hide();
			$(".chkBoxArea").hide();
			$('.btnApprovalCan').hide();
		}

		//슈퍼는 승인취소 가능
		var targetAuth = $("#treeOrg option:selected").attr('targetAuth');
		if(targetAuth =='SUPER') $('.btnApprovalCan').show();

    },

    //분류세팅 -> 추후 코드화를 위해
    searchTypeSetting : function(){
    	var str = '<label for="dv2" class="carSearchtitle">분류</label><select id="dv2" class="select_b" onchange="fnObj.doSearch();">';
    	str += '<option value="0">전체</option>';
		for(var i=0; i< dv2List.length; i++){
			str += '<option value="'+dv2List[i].CD+'">'+dv2List[i].NM+'</option>';
		}
    	str += '</select>';
    	$("#searchTypeDiv").html(str);
    },//end searchTypeSetting


    //년도 세팅(셀렉트박스)
    yearSetting : function(){

    	var nowDate= new Date().yyyy_mm_dd();
    	var nowYear = nowDate.substring(0,4);
    	var str ='<label for="choiceYear" class="carSearchtitle mgl10">년도</label><select id="choiceYear" class="select_b w_date"  onchange="fnObj.doSearch();">';
    	for(var i="${minYear}";i<=parseInt(nowYear)+1;i++){
    		var chk ='';
    		if(nowYear == i){
    			chk ='selected="selected"';
    		}
    		str += '<option value="'+ i+'" '+chk+'>'+ i+'</option>';
    	}
    	str += '</select>';

    	$("#yearDiv").html(str);
    },//end yearSetting


    //월 세팅
    monthSetting : function(){
    	var nowDate= new Date();
    	var month = nowDate.getMonth() + 1;		//현재 월
    	var str ='';
    	for(var i=1;i<=12;i++){
    		str += '<button type="button" id="month_'+i+'" onclick="fnObj.monthClick('+i+');">'+i+'월</button>';
    	}
    	$("#monthDiv").html(str);

    	$("#month_"+month).addClass("on");
    	$('#choiceMonth').val(month);

    },//end monthSetting

    //월 선택
    monthClick : function(i){
    	$(".on").removeClass();
    	$("#month_"+i).addClass("on");
    	$('#choiceMonth').val(i);
    	$('#startDate').val('');
    	$('#endDate').val('');
    	fnObj.doSearch();
    },//end monthClick

    //검색버튼 클릭
    clickSearch : function(){
    	$(".select_m").removeClass("select_m");
    	$('#choiceMonth').val('');
    	fnObj.doSearch();
    },

  	//합계 세팅
    sumSetting: function(){
    	$("#detailSum").html('');

    	dv2 = $("#dv2").val();
    	var totalSum =0;
    	var sumMap =newMap();
    	var cardList2 = cardList.clone();

    	sortByKey(cardList2, "dv", "ASC");		//dv 순서 정렬

    	for(var i=0; i<cardList2.length; i++){
			totalSum +=cardList2[i].price;		//전체 총 합계
    	}


    	//하나의 항목별 금액
   		for(var p=0; p<dvList.length; p++){
   			var sum =0;
   			var dv ='';
			for(var i=0; i<cardList2.length; i++){
				if(dvList[p].CD == cardList2[i].dv){			//dv가 같을때
					dv = cardList2[i].dv;								//dv세팅
					sum += cardList2[i].price; 							//합계
				}
			}
			sumMap.put(dv,sum);											//객체에 각 항목을 담는다.
 		}

   		var str ='';
   		var count =0;
   		var idx =0;

   		if(dv2==0){
   			for(var i=0;i<dv2List.length;i++){							//분류리스트
	    		var sum =0;

	    		//항목 리스트
	    		for(var k=0;k<dvList.length;k++){

	    			if(dvList[k].codeName == dv2List[i].sonCodeName){	//항목리스트가 분류리스트(그룹이름)에 포함되어있으면
	        			sum += sumMap.get(dvList[k].CD);		//객체에서 해당 금액 추출 합친다.
	        		}
	    		}


	    		if(i == 0){
    				str +='<tr>';
    	   			str +='<th rowspan="'+dv2List.length+'">세<br>부<br>항<br>목</th>';
    	   			str +='<th class="bg_gray">'+dv2List[i].NM+'</th>';
    	   			str +='<td class="txt_money"><span>'+Number(sum).toLocaleString().split(".")[0]+'</span><em>원</em></td>';
    	   			str +='</tr>';
    			}else{
    				str +='<tr>';
    	   			str +='<th class="bg_gray">'+dv2List[i].NM+'</th>';
    	   			str +='<td class="txt_money"><span>'+Number(sum).toLocaleString().split(".")[0]+'</span><em>원</em></td>';
    	   			str +='</tr>';
    			}

	    	}


   		}else{//전체가 아닐때

	    	for(var i=0; i<dvList.length; i++){
	    		var obj = getRowObjectWithValue(dv2List, 'sonCodeName', dvList[i].codeName);
	    		if(obj.CD == dv2){					//항목리스트와 선택 분류(그룹이름)가 같으면
	    			count++;
	    		}
	    	}

	    	for(var i=0; i<dvList.length; i++){
	    		var obj = getRowObjectWithValue(dv2List, 'sonCodeName', dvList[i].codeName);
	    		if(obj.CD == dv2){					//항목리스트와 선택 분류(그룹이름)가 같으면
	    			if(idx == 0){
	    				str +='<tr>';
	    	   			str +='<th rowspan="'+count+'">세<br>부<br>항<br>목</th>';
	    	   			str +='<th class="bg_gray">'+dvList[i].NM+'</th>';
	    	   			str +='<td class="txt_money"><span>'+Number(sumMap.get(dvList[i].CD)).toLocaleString().split(".")[0]+'</span><em>원</em></td>';
	    	   			str +='</tr>';
	    			}else{
	    				str +='<tr>';
	    	   			str +='<th class="bg_gray">'+dvList[i].NM+'</th>';
	    	   			str +='<td class="txt_money"><span>'+Number(sumMap.get(dvList[i].CD)).toLocaleString().split(".")[0]+'</span><em>원</em></td>';
	    	   			str +='</tr>';
	    			}
	    			idx++;
	    		}
	    	}

   			//$("#dv2NameP").html($("#dv2 option:selected").text());
   		}

    	$("#totalSum").html(Number(totalSum).toLocaleString().split(".")[0]);
    	$("#detailSum").html(str);

    },//end sumSetting.

	//사용자 트리 생성
	setUserTree: function(){

		var myUserTree = new UserTree();			//UserTree 객체생성

		/* 사용자트리 설정정보 */
		var configObj = {
				targetID : 'userListAreaTree',							//대상 위치 id (div, span)
				url : contextRoot + "/common/getOrgDeptUserList.do",	//데이터 URL
				isCheckbox:true,
				isOnlyOne : false,										//선택건수 1개 여부			(false: 복수,		그외,: 한명(default))
				isAllOrg : false,										//전체 ORG 범위로의 여부		(true: 전체ORG, 		그외,: 나의권한ORG (default))
				oneOrg : '${baseUserLoginInfo.applyOrgId}',				//전달받은 한개의 ORG ID
				defaultSelectList : ['${baseUserLoginInfo.userId}'],	//기본 선택 id array 			(로딩시점 초기 기본 선택 노드 id list)
				isDeptSelectable : true,								//부서선택 가능여부(= 하위 사용자 모두 선택)		(true: 해당부서하위모두선택, 	그외,:부서선택불가 (default))
				callbackFn : fnObj.selStaff,							//콜백 function

				useNameSortList : true,									//이름정렬선택 리스트 사용 여부 (true: 사용,			그외,: 미사용(default))
				openDeptId : ('${baseUserLoginInfo.deptMngrYn}' == 'Y' ?  '${baseUserLoginInfo.deptId}' : '0' ),
				myUserId : '${baseUserLoginInfo.userId}',				//로긴 유저아이디
				myOrgId : '${baseUserLoginInfo.orgId}',					//로긴 유저orgId
				deptManagerDeptId : '${baseUserLoginInfo.deptIdMngr}',
				authTree : true,
				useAllCheck : true,
				pageType : 'CARD',
				myDeptId : '${baseUserLoginInfo.deptId}',

		};

		//권한자
		if('${baseUserLoginInfo.cardViewYn}' == 'Y') configObj.deptManagerDeptId = '-1';
		else if('${baseInfo.staffDeptId}' == '${baseUserLoginInfo.deptId}'
				|| '${baseInfo.staffUserId}' == '${baseUserLoginInfo.userId}'){
			configObj.deptManagerDeptId = '';
		}

		myUserTree.setConfig(configObj);	//설정정보 세팅
		myUserTree.drawTree();				//트리 생성
	},


  	//datepicker 설정
    setDatepicker : function(obj){
		$('#'+obj).datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			maxDate: new Date(),
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
    //테이블 체크박스 컨트롤
    tableChkBoxEventSet : function(deptId,allYn){

		if(allYn == 'Y'){
			if($("#chkAll_"+ deptId).prop("checked")){
				$("input[type='checkbox'][name='subChk"+deptId+"']").not(":disabled").prop("checked",true);
			}else{
				$("input[type='checkbox'][name='subChk"+deptId+"']").not(":disabled").prop("checked",false);
			}
			return;
		}
		var chkboxlength = $("input[type = 'checkbox'][name='subChk"+deptId+"']").not(":disabled").length;

		if($("input[type = 'checkbox'][name='subChk"+deptId+"']:checked").length == chkboxlength){
			$("#chkAll_"+ deptId).prop("checked",true);
		}else{
			$("#chkAll_"+ deptId).prop("checked",false);
		}

    }

    /* ====================================== 화면 세팅 관련 : E ===================================*/


    //################# else function :E #################
};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){

	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅

	$("#userTreeArea").show();
	$("#userDeptTreeArea").hide();
	fnObj.setUserTree();


});
</script>

