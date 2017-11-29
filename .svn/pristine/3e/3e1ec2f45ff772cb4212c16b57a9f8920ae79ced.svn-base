<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<style>
.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
    z-index: 1000000;
}
.wrap-loading div{ /*로딩 이미지*/
    position: fixed;
    top:50%;
    left:50%;
    margin-left: -21px;
    margin-top: -21px;
    z-index: 1000000;
}
.display-none{ /*감추기*/
    display:none;
}

</style>

<script type="text/javascript">
$(document).ready(function(){

})

//공통코드
var comCodeCstType;			//고객구분
var myModal = new AXModal();		// instance
var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs
var curPageNo = 1;				//현재페이지번호
var pageSize = 15;				//페이지크기(상수 설정)
var mode;						//"new", "view", "update"
var fileSeqArray = new Array();		//업로드된 파일 key list
var fileSeqArrayTemp = new Array();	//업로드된 파일 key list (글저장을 누르기전...글에 파일키가 등록되기 전 상태)
var g_staffList = new Array();							//담당자 전체 리스트 ... [{cusId:'123', usrNm:'시너지'}]
var g_stockCpnList = new Array();						//증권사 array
var g_gridListStr;										//그리드 데이터 string (객체화되기전 문자열 json... JSON.parse 로 객체로 만들어사용) (증권사 필터링을 위해..)
var g_sortCol = '';		//소팅 컬럼
var g_sortAD = '';		//소팅 방향(A or D)
//Global variables :E ---------------

/*
* 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
*/
var fnObj = {
	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		/* comCodeCstType = getBaseCommonCode('CUSTOMER_TYPE', null, 'CD', 'NM');		//고객구분('00013') 공통코드 (Sync ajax)
		var cstRadioTag = createRadioTag('rdCstType', comCodeCstType, 'CD', 'NM', null, 17, null, 'fnObj.clickRdCstType(this)');	//'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#cstRadioTag").html(cstRadioTag);

		var cstRadioTagPop = createRadioTag('rdCstTypePop', comCodeCstType, 'CD', 'NM', null, null, null, 'fnObj.clickRdCstTypePop(this)', 'H');	//'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#cstRadioTagPop").html(cstRadioTagPop); */


		//페이지크기 세팅
		pageSize = 15;  // 페이지 사이즈 일단 고정 이인희
//		fnObj.setPageSize();


		//고객구분 변경 레이어 팝업 이벤트 추가(마우스 영역 벗어날때 닫기)
		$('#divPopCstType').mouseleave(function(){
			$('#divPopCstType').hide();
			$('input[name=rdCstTypePop]').attr('checked', false);
		});

	},


	//화면세팅
  pageStart: function(){

  	//-------------------------- 그리드 설정 :S ----------------------------
  	/* 그리드 설정정보 */
  	var configObj = {

  		targetID : "SGridTarget",		//그리드의 id

  		//그리드 컬럼 정보
  		colGroup : [
          {key:"chk",			formatter:function(obj){return (isEmpty(obj.item.isSending)?"":"<b><font color=red>T</font></b>") + ("<input type='checkbox' name='mCheck' " + (isEmpty(obj.item.isSending)&&('${baseUserLoginInfo.userId}' == obj.item.staffId || obj.item.staffId==null||obj.item.usrRank=="F"||obj.item.usrRank=="R")?"":"style='display:none;' disabled isSend='Y'") + " value='" + obj.value + "' />");}},
          {key:"cstNm", 		formatter:function(obj){return obj.value;}},
          {key:"custTypeNm",    formatter:function(obj){return obj.value;}},        //업종
          {key:"cpnNm"		},
          {key:"team"       },                                                  //부서 신규로 넣을것 이인희
          {key:"position"		},													//직책
          {key:"phn1",		formatter:function(obj){
          						var val = '';

          						if('${baseUserLoginInfo.userId}' == obj.item.userId || '${baseUserLoginInfo.customerInfoLevel}' == 'G'){

          							if(obj.value==null) return val;

          							if(obj.item.domesticYn =="N") val +='+';

          							val += obj.value;
          						}else{
          		                  val = '비노출'
          		                }
          						return val;
          					}},													//연락처
          {key:"email",		formatter:function(obj){
									var val = '';
									if('${baseUserLoginInfo.userId}' == obj.item.userId || '${baseUserLoginInfo.customerInfoLevel}' == 'G'){
										val = obj.value;
									}else{
						                  val = '비노출'
						            }
									return val;
								}},
          {key:"usrNm",     formatter:function(obj){
              var val = '';
              if('${baseUserLoginInfo.userId}' == obj.item.userId || '${baseUserLoginInfo.customerInfoLevel}' == 'G' || '${baseUserLoginInfo.customerInfoLevel}' == 'E'){
                  val = obj.value;
              }else{
                  val = '비노출'
              }
              return val;
          }},
          {key:"lvCd",		formatter:function(obj){
              var val = '';
              if('${baseUserLoginInfo.userId}' == obj.item.userId || '${baseUserLoginInfo.customerInfoLevel}' == 'G' || '${baseUserLoginInfo.customerInfoLevel}' == 'E'){
                  val = !isEmpty(obj.item.lvCd)?parseInt(obj.item.lvCd):'';
              }else{
                  val = '비노출'
              }
              return val;
          }},
          /* {key:"netCnt",		formatter:function(obj){return (obj.value==0?'':obj.value);}}, */
          {key:"lastDt",        formatter:function(obj){
              var val = '';
              if('${baseUserLoginInfo.userId}' == obj.item.userId || '${baseUserLoginInfo.customerInfoLevel}' == 'G' || '${baseUserLoginInfo.customerInfoLevel}' == 'E'){
                  val = obj.value;
              }else{
                  val = '비노출'
              }
              return val;
          }},
          {key:"lastType"	,     formatter:function(obj){
              var val = '';
              if('${baseUserLoginInfo.userId}' == obj.item.userId || '${baseUserLoginInfo.customerInfoLevel}' == 'G' || '${baseUserLoginInfo.customerInfoLevel}' == 'E'){
                  val = obj.value;
              }else{
                  val = '비노출'
              }
              return val;
          }},
          {key:"lastNm"	,       formatter:function(obj){
              var val = '';
              if('${baseUserLoginInfo.userId}' == obj.item.userId || '${baseUserLoginInfo.customerInfoLevel}' == 'G' || '${baseUserLoginInfo.customerInfoLevel}' == 'E'){
                  val = obj.value;
              }else{
            	  val = '비노출'
              }
              return val;
          }},
          {key:"rgDt"			},
          {key:"domesticYn"	,       formatter:function(obj){
              var val = obj.value;

              return val=="Y"?"국내":"해외";
          }}
          ],


          body : {
              onclick: function(obj, e){
                /* KJS 수정
              	if(obj.c == 3){
              		fnObj.openCstTypePop(obj.item.sNb, obj.item.custType, obj.index, e);

              	}else
                */
                if(obj.c > 0){	// && obj.c < 7
              		//fnObj.viewProject(obj.item.projectId);
              		//alert('보기 연결:::' + obj.item.sNb);
                    var url = "<c:url value='/person/main.do'/>?sNb=" + obj.item.sNb + "&searchOrgId="+ $("#searchOrgId").val();
              		var popup = window.open(url, 'cstView', 'resizable=no,width=968,height=600,scrollbars=yes');
              		//popup.location.href="<c:url value='/person/main.do'/>?sNb=" + obj.item.sNb;

              	}

              }
          }
  	};
  	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
  	var rowHtmlStr = '<tr>';
  	rowHtmlStr +=	 '<td class="checkinput"><label>#[0]<em>선택</em></label></td>';
  	rowHtmlStr +=	 '<td>#[1]</td>';
  	rowHtmlStr +=    '<td class="txt_left" >#[2]</td>';              //업종
  	rowHtmlStr +=    '<td >#[14]</td>';              //국내외구분
  	rowHtmlStr +=	 '<td class="txt_left" >#[3]</td>';  //회사
  	rowHtmlStr +=    '<td class="txt_left" >#[4]</td>';  //부서
  	rowHtmlStr +=	 '<td class="txt_left" >#[5]</td>';									//직책
  	rowHtmlStr +=	 '<td class="txt_left" >#[6]</td>';
  	rowHtmlStr +=	 '<td class="txt_left engst">#[7]</td>';							//이메일
  	rowHtmlStr +=	 '<td class="txt_left engst">#[8]</td>';													//담당자
  	rowHtmlStr +=	 '<td >#[9]</td>';						//친밀도
  	rowHtmlStr +=	 '<td class="numst pointcolor02">#[10]</td>';						//연락일
  	rowHtmlStr +=	 '<td class="txt_left">#[11]</td>';									//내용
  	rowHtmlStr +=	 '<td >#[12]</td>';													//등록자
  	rowHtmlStr +=	 '<td class="numst pointcolor02">#[13]</td>';
    rowHtmlStr +=	 '</tr>';
  	configObj.rowHtmlStr = rowHtmlStr;


  	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
  	//-------------------------- 그리드 설정 :E ----------------------------

  	//-------------------------- 페이징 설정 :S ----------------------------
  	myPaging.setConfig({				//페이징 설정정보 세팅

			targetID		: "btnPageZone",		//대상 페이징 id ... <div>
			pageSize		: pageSize,				//global variable value

			preEndBtnClass	: 'pre_end_btn',		//맨처음 페이지 	버튼 클래스명
			preBtnClass		: 'pre_btn',			//이전 페이지		버튼
			nextBtnClass	: 'next_btn',			//다음 페이지		버튼
			nextEndBtnClass	: 'next_end_btn',		//맨마지막 페이지	버튼 클래스명

			curPageNoClass	: 'current',			//현재페이지를 표시해주기위한 style Class name
			clickFnName		: 'fnObj.doSearch'		//페이지 이동 함수명(버튼 클릭)

  	});
  	//-------------------------- 페이징 설정 :E ----------------------------


  	//-------------------------- 소팅 설정 :S ----------------------------
  	mySorting.setConfig({
			colList : ['cstNm', 'cpnNm', 'custTypeNm', 'lastDt', 'rgDt', 'usrNm'],						//['PROJECT_TYPE', 'END_DATE', 'BUDGET_AMT'],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh',				//내림정렬 아이콘 css class
			defaultSortDirection: 'DESC'						//기본 정렬 방향
		});
  	//-------------------------- 소팅 설정 :E ----------------------------


  	//-------------------------- 모달창 :S -------------------------
  	myModal.setConfig({
  		windowID:"myModalCT",
  		//openModalID:"kkkkk",
  		width:740,
          mediaQuery: {
              mx:{min:0, max:767}, dx:{min:767}
          },
  		displayLoading:true,
          scrollLock: true,
  		onclose: function(){

  		}
        ,contentDivClass: "popup_outline"
  	});
  	//-------------------------- 모달창 :E -------------------------

  },//end pageStart.
	//################# init function :E #################


  //################# else function :S #################
  //퇴사자담당
  doSearchFireStaff: function(){
	  if($("#searchFireStaff").prop("checked")){

		  $("#searchNoStaff").prop("checked",false);
		  $("#actionType").val("All");
		  doUnCheckAllTreeUser();
		  fnObj.doSearch(1);
	  }else{
		  $("#actionType").val("Alone");
		  var userId = "${baseUserLoginInfo.userId}";
		  $("#"+userId+"_anchor").trigger("click");
	  }
  },
  //미담당고객
  doSearchNoStaff:function(){
	  if($("#searchNoStaff").prop("checked")){

		  $("#searchFireStaff").prop("checked",false);
		  $("#actionType").val("All");
		  doUnCheckAllTreeUser();
		  fnObj.doSearch(1);
	  }else{
		  $("#actionType").val("Alone");
		  var userId = "${baseUserLoginInfo.userId}";
		  $("#"+userId+"_anchor").trigger("click");
	  }
  },
  //검색버튼 클릭시
  doSearchName: function(){
	    $("#actionType").val("All");
	    var actionType = $("#actionType").val();
		if(actionType == "All" && !$("#searchFireStaff").prop("checked")&&!$("#searchNoStaff").prop("checked")){  //고객명 이나 회사명으로 검색하는 경우
		    if($('#srchCustNm').val().length <= 1 && $('#srchCpnNm').val().length <= 1){
		        alert('검색어는 두글자 이상 입력하시기 바랍니다!')
		        return;
		    }
		}
		doUnCheckAllTreeUser();
		fnObj.doSearch(1);
  },

  //검색
  doSearch: function(page){
	var actionType = $("#actionType").val();
	if(actionType != "All" &&  !$("#searchFireStaff").prop("checked")&&!$("#searchNoStaff").prop("checked")){
  		 // 회사명,고객명 검색조건 리셋
        $('#srchCustNm').val("");          //고객명
        $('#srchCpnNm').val("");              //회사명
  	}
  	//--------- 고객구분
  	var cstType = $("#cstType").val();
  	if(isEmpty(cstType)) cstType = '';		//undefined >> ''
  	var url = contextRoot + "/person/getCustList.do";

  	var param = {
		pageSize: pageSize,
		pageNo:	page,

		/* staffCusId */
		searchStaffId: $("#searchStaffId").val(),		//staffIdStr,					//담당자
		//isNotyet: (g_chargeType=='notyet'?'Y':''),			//미담당고객 여부
		//isUnstaffCst: (g_chargeType=='unstaffcst'?'Y':''),	//퇴사자고객 여부
		//isNew: (g_chargeType=='new'?'Y':''),				//신규등록 고객 여부

		cstType: cstType,									//고객구분
		isStock: (cstType=='00001'?'Y':''),				//고객구분 이 증권사IB 여부	'Y'

		srchCustNm: $('#srchCustNm').val(),					//고객명
		srchCustNmKor: engTypeToKor($('#srchCustNm').val()),//고객명(한글로)

		srchCpnNm: $('#srchCpnNm').val(),					//회사명
		actionType: actionType,
		searchFireStaff:$("#searchFireStaff:checked").val(),
		searchNoStaff:$("#searchNoStaff:checked").val(),
		searchOrgId:$("#searchOrgId").val()

	};

  	var callback = function(result){

  		var obj = JSON.parse(result);
  		var cnt = obj.resultVal;		//결과수
  		var list = obj.resultList;		//결과데이터JSON

  		curPageNo = obj.pageNo;         //현재페이지세팅(global variable)

        var pageObj = {                     //페이징 데이터
                    pageNo : curPageNo,
                    pageSize : pageSize,
                    pageCount: obj.pageCount
                }

        myPaging.setPaging(pageObj);        //페이징 데이터 세팅    *** 1 ***
  		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list		//그리드 테이터
								//,page: pageObj	//페이징 데이터
  						});
  		if(list == "") $('#spanStockCpn').css('overflow-y', '');

  		g_gridListStr = result;				//따로 전역변수에 넣어둔다

		fnObj.setStockCpnChkbox(list);			//증권사 체크박스 세팅

		//전체 건수 세팅
		$('#total_count').html(cnt);

		//소팅 초기화
		mySorting.clearSort();
		//----- 하단 기본 소팅 설정은 기본정책에 따라 바꿔준다.
		//mySorting.nowDirection = 'DESC';
		mySorting.setSort(3);				//소팅객체를 소팅한다.(상태값들의 변화)
		mySorting.applySortIcon();			//소팅화면적용
  	};



  	fnObj.setCheckedStaffName();  //선태된 담당자 이름 보여주기

  	commonAjax("POST", url, param, callback, true);

  },//end doSearch



	//나에게 신규 할당된 고객 확인 >> 팝업
  doSearchNewInCharge: function(page){
	var url = contextRoot + "/person/getChkPersonNoticeInfo.do";
	var param = {};
	var callback = function(result){
		var data =  JSON.parse(result);
		if(data.resultObject.result =="SUCCESS"){
			if(parseInt(data.resultObject.cnt)>0){
				//if(confirm('나에게 신규 할당된 고객이 존재합니다.\n\n' + confirmStr)){

				////////////////////////////////수락 프로세스 추가 /////////////////////////////////////
 				var url = "<c:url value='/person/newCstInChargePopup.do'/>";
      			var params = {};

 	        	myModal.open({
 	        		url: url,
 	        		pars: params,
 	        		titleBarText: '나에게 할당된 고객 리스트',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
 	        		method:"POST",
 	        		top: 150,
 	        		width: 900,
 	        		closeByEscKey: true				//esc 키로 닫기
 	        	});

 	        	$('#myModalCT').draggable();


  			//}
			}
		}
	}
	commonAjax("POST", url, param, callback);
  },//end doSearchNewInCharge


	//글보기
  viewMenu: function(menuInfoObj){
  	var url = "<c:url value='/system/addMenu.do'/>";
  	var params = {mode:'update',
  				  menuInfoObj:JSON.stringify(menuInfoObj)};//("mode=view&boardSeq="+boardSeq+"&btype=1&cate=1").queryToObject();	//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

  	myModal.open({
  		url: url,
  		pars: params,
  		titleBarText: '메뉴수정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
  		method:"POST",
  		top: 150,
  		width: 650,
  		closeByEscKey: true			//esc 키로 닫기
  	});

  	$('#myModalCT').draggable();
  },//end writeOpen


	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
  addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
  },


	//체크박스 전체 체크
  allCheck: function(){

 		var chkList = document.getElementsByName('mCheck');
 		//var list = myGrid.getList();
 		//var addIdx = chkList.length/2;
 		var toBe = document.getElementsByName('allChk')[0].checked;
 		for(var i=0; i<chkList.length; i++){
     		chkList[i].checked = toBe;		//체크여부
     		//list[i-addIdx].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
     	}

  },

//사용자 트리 생성
  setUserTree: function(){

      var myUserTree = new UserTree();            //UserTree 객체생성

      /* 사용자트리 설정정보 */
      var configObj = {
              targetID : 'userListAreaTree',                          //대상 위치 id (div, span)
              url : contextRoot + "/common/getOrgDeptUserList.do",    //데이터 URL
              isCheckbox:true,
              isOnlyOne : false,                                      //선택건수 1개 여부            (false: 복수,     그외,: 한명(default))
              isAllOrg : false,                                       //전체 ORG 범위로의 여부        (true: 전체ORG,       그외,: 나의권한ORG (default))
              /* oneOrg : '${baseUserLoginInfo.applyOrgId}',             //전달받은 한개의 ORG ID */
              oneOrg : '${baseUserLoginInfo.applyOrgId}',             //전달받은 한개의 ORG ID
              defaultSelectList : [$("#userId").val()],    //기본 선택 id array            (로딩시점 초기 기본 선택 노드 id list)
              isDeptSelectable : true,                                //부서선택 가능여부(= 하위 사용자 모두 선택)     (true: 해당부서하위모두선택,  그외,:부서선택불가 (default))
              callbackFn : fnObj.selStaff,                            //콜백 function
              useAllCheck : true ,                                    //전체선택 기능 사용 여부     (true: 사용,          그외,: 미사용(default))
              rtnField : 'userId',                                     // userId, cusId, empNo
              useNameSortList : true,								//이름정렬선택 리스트 사용 여부 (true: 사용,		그외,: 미사용(default))
              isOrgCallbackEnable : true,                               //콜백 함수 enable 상태       (false: disable,    그외,: enable (default))
              orgCallbackFn : fnObj.selOrg                            //콜백 function

      };

      myUserTree.setConfig(configObj);    //설정정보 세팅
      myUserTree.drawTree();              //트리 생성
  },

  selOrg : function(orgId){ //type : ALL 전체
	  $("#searchOrgId").val(orgId);
	  if(parseInt("${baseUserLoginInfo.orgId}") != parseInt(orgId)&&parseInt("${baseUserLoginInfo.applyOrgId}") != parseInt(orgId)){
		  $(".btn_auth").hide();
	  }else{
		  $(".btn_auth").show();
	  }
	  var url = contextRoot + "/person/getCustomerTypeList.do";

	  var $frm = $("<form></form>");

	  var $param = $("<input></input>").attr("name","searchOrgId").attr("type","hidden").val(orgId);

	  $frm.append($param);
	  $frm.attr("action",url);

      /* var param = {
              searchOrgId: orgId
      }; */
      var callback = function(result){
    	  $("#customerTypeTab").empty();
    	  $("#customerTypeTab").html(result);
      };
      commonAjaxSubmit("POST",$frm,callback);
     // commonAjax("POST", url, param, callback);
  },


  //LEFT 사원 선택
  selStaff : function(userList){ //type : ALL 전체선택 , 빈값 : 개별선택 , 이외 : 부서SEQ

  	  $("#searchFireStaff").prop("checked",false);
  	  $("#searchNoStaff").prop("checked",false);
	  $("#searchStaffId").val(userList);
	  $("#actionType").val("Alone");
      fnObj.doSearch(1);
  },

  setCheckedStaffName : function(){
	  var url = contextRoot + "/person/getUserNameList.do";
      var param = {
    		  searchStaffId: $("#searchStaffId").val()
      };
      var callback = function(result){
          var obj = JSON.parse(result);
          var rsltObj = obj.resultObject; //결과수

          if(obj.result == "SUCCESS"){
        	  var userList = rsltObj.userList;
              var strHtml = '';
              var staffNmLst = '담당자 : ';
              var staffCnt = 0;

              for(var i=0; i<userList.length; i++){
                  //var userId = userList[i].userId.replace("_anchor","");
                  //var chkName = $("#"+ userList[i] +"").text();
                  var userId = userList[i].userId;
                  var chkName = userList[i].name;

                  if(staffCnt == 0) staffNmLst += chkName;
                  strHtml += '<span class="employee_list"><span>'+chkName+'</span><a href="javascript:fnObj.unSelStaffAny(\''+userId+'\');" class="btn_delete_employee"><em>삭제</em></a></span>';
                  staffCnt ++

              }


              if($("#actionType").val() == "All"){
                  strHtml = '<span class="employee_list"><span>전체</span></span>';
                  $("#divStaffNameList").html(strHtml);
                  staffNmLst = "검색결과 : " + $("#srchCpnNm").val() + " " + $("#srchCustNm").val();
              }else{
                  $("#divStaffNameList").html(strHtml);
                  if(staffCnt > 1) staffNmLst += " 외 " + (staffCnt-1)+ " 명";
              }

              $('#spanChargeNm').html(staffNmLst);        //담당자명 세팅
              $('#divResultStaff').show();
          }else{
              //alertMsg();
          }
      };
      commonAjax("POST", url, param, callback);
  },

  //선택한 속성 삭제시
  unSelStaffAny : function(userId){
	  /* var span = $(obj).parent();
      span.remove(); */
	  doUnCheckTreeUser(userId);

	  var searchStaffId = $("#searchStaffId").val();
	  searchStaffId = searchStaffId.replace(","+userId,"");
	  searchStaffId = searchStaffId.replace(userId,"");
	  if(searchStaffId.substring(0,1) == ',') searchStaffId = searchStaffId.replace(",","");

	  $("#searchStaffId").val(searchStaffId);
	  fnObj.doSearch(1);

      /*
      $('input:checkbox[name="chkboxStaff"]:checked').each(function(){
          if(cusId == $(this).val()) $(this).prop("checked",false);
      });
      fnObj.selStaff(''); */
  },


  //담당자 해제
  unSelStaff: function(){
  	$('#chkboxShowAll').removeAttr('checked');						//전체보기 해제
  	$('input:checkbox[name=chkboxStaff]').removeAttr('checked');	//담당자 해제
  	$('#chkboxNotyet').removeAttr('checked');						//미담당고객 해제
  	$('#chkboxUnstaffCst').removeAttr('checked');					//퇴사자고객 해제
  },


  //고객구분 체크
  clickRdCstType: function(cstType,obj){
	//$('#liCusType').attr('class','');
	$("li[id^='liCusType']").attr('class','');
	$(obj).parent().attr('class','current');

  	$("#cstType").val(cstType);

  	fnObj.doSearch(1);
  },


  //증권사 전체
  clickStockCpnAll: function(th){
  	$(th).attr('checked', true);								//전체 체크
  	$('input:radio[name=chkStockCpn]').removeAttr('checked');	//증권사 라디오 체크해제


  	//그리드 데이터 마지막 DB검색의 데이터로 세팅
  	var list = JSON.parse(g_gridListStr).resultList;
  	myGrid.setGridData({			//그리드 데이터 세팅
			list: list					//그리드 테이터
		});
  	if(list == "") $('#spanStockCpn').css('overflow-y', '');


  	//소팅 초기화
		mySorting.clearSort();
		//----- 하단 기본 소팅 설정은 기본정책에 따라 바꿔준다.
		mySorting.setSort(1);				//소팅객체를 소팅한다.(상태값들의 변화)
		mySorting.applySortIcon();			//소팅화면적용
  },


  //증권사 라디오박스 세팅
  setStockCpnChkbox: function(listObj){

  	var stockCpnChkboxStr = '';		//체크박스 html string

  	g_stockCpnList = new Array();	//초기화

  	var cnt = listObj.length;		//고객수

  	for(var i=0; i<cnt; i++){
  		if(listObj[i].cpnCate == '증권'){

  			if(g_stockCpnList.indexOf(listObj[i].cpnId) == -1){		//없는 증권사이면
  				stockCpnChkboxStr += '<li><label><input type="radio" name="chkStockCpn" onclick="fnObj.findStockCpn(\'' + listObj[i].cpnId + '\');" value="' + listObj[i].cpnId + '" />' + listObj[i].cpnNm + '</label></li>';	//추가
  				g_stockCpnList.push(listObj[i].cpnId);				//추가된 증권사 리스트에 추가
  			}

  		}
  	}

  	$('#spanStockCpn').html(stockCpnChkboxStr);
  },

  //증권사 필터링
  findStockCpn: function(cpnId){

  	$('#chkboxStockCpnAll').removeAttr('checked');		//증권사 전체 체크박스 체크해제


  	var list = JSON.parse(g_gridListStr).resultList;
  	var cnt = list.length;

  	for(var i=cnt-1; i>=0; i--){
  		if(list[i].cpnId != cpnId) list.remove(i);
  	}

  	myGrid.setGridData({			//그리드 데이터 세팅
			list: list					//그리드 테이터
		});
  	if(list == "") $('#spanStockCpn').css('overflow-y', '');
  },

  //증권사 div height toggle
  showAllStockCpn: function(){
  	if($('#spanStockCpn').height() == 45){
  		$('#spanStockCpn').css('max-height', '1000px');
  		$('#spanStockCpn').css('overflow-y', '');
  	}else{
  		$('#spanStockCpn').css('max-height', '45px');
  		$('#spanStockCpn').css('overflow-y', 'auto');
  	}
  },

  //그리드 div height toggle
  showAllGrid: function(){
  	var gridH = $('#SGridTarget').height() + 50;
  	if($('.scroll_body').height() == 450){
  		$('.scroll_body').css('height', gridH);
  		$('.scroll_body').css('max-height', gridH);
  	}else{
  		$('.scroll_body').css('height', '450px');
  		$('.scroll_body').css('max-height', '450px');
  	}
  },


  //담당자 변경
  chngChrgStaff: function(){
  	var jObj = $('input:checkbox[name=mCheck]:checked');
  	if(jObj.length == 0){
        alert("고객을 선택하신 후 담당자변경을 진행하시기 바랍니다.");
        return;
    }else if(jObj.length > 0){

  		///////////////////////////// 담당자 변경 팝업 ////////////////////////////

  		var url = "<c:url value='/person/chngCstManagerPopup.do'/>";
      	var params = {};	//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

      	//params 에 고객리스트 전달------
      	var tObj = [];					//임시 객체(배열)
      	var list = myGrid.getList();	//그리드 데이터(array object)

      	var chkboxAll = document.getElementsByName('mCheck');		//고객 체크박스
      	for(var i=0; i<chkboxAll.length; i++){
      		if(chkboxAll[i].checked){
      			tObj.push({sNb:list[i].sNb, cstNm: list[i].cstNm, cpnNm:list[i].cpnNm, usrNm:list[i].usrNm,usrCusId:list[i].usrCusId});
      		}
      	}

      	params.cstList = JSON.stringify(tObj);				//선택한 고객리스트 														/***** param 1 *****/

      	//params 에 담당자(사원)리스트 전달------
      	params.staffList = JSON.stringify(g_staffList);		//담당자 리스트(사원리스트) 전달 (궂이 다시 코드를 가져올 필요없이 재 사용)		/***** param 2 *****/

        /* var paramList1 = params.cstList;
        var paramList2 = params.staffList;

        paramList1=paramList1.replace(/{/g, "");
        paramList1=paramList1.replace(/}/g, "");
        paramList1=paramList1.replace(/:/g, "=")
        paramList1=paramList1.replace(/,/g, "&");
        paramList1=paramList1.replace(/"/g, "");
        paramList1=paramList1.replace("[", "");
        paramList1=paramList1.replace(/]/g, "");

        paramList2=paramList2.replace(/{/g, "");
        paramList2=paramList2.replace(/}/g, "");
        paramList2=paramList2.replace(/:/g, "=")
        paramList2=paramList2.replace(/,/g, "&");
        paramList2=paramList2.replace(/"/g, "");
        paramList2=paramList2.replace("[", "");
        paramList2=paramList2.replace(/]/g, "");

        url += "?temp=1&" + paramList1 + "&" + paramList2;
        alert(url);
        window.open(url, 'chngChrgStaff','resizable=no,width=900,height=630,scrollbars=yes');
        */

      	myModal.open({
      		url: url,
      		pars: params,
      		titleBarText: '담당자 변경',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
      		method:"POST",
      		top: $(window).scrollTop() + 150,
      		width: 900,
      		closeByEscKey: true				//esc 키로 닫기
      	});

      	$('#myModalCT').draggable();
  	}
  },

  //고객리스트 체크박스 전체체크
  chkCustAll: function(th){
  	if(th.checked){
  		//$('input:checkbox[name=mCheck]').attr('checked', true);		//고객전체 체크
  		$('input:checkbox[name=mCheck]').each(function(idx, el){
  			if(isEmpty($(el).attr('isSend'))) $(el).attr('checked', true);
  		});		//고객전체 체크
  	}else{
  		$('input:checkbox[name=mCheck]').removeAttr('checked');		//고객전체 체크해제
  	}
  },


	//컬럼 소팅
  doSort: function(idx){
  	// 로딩 이미지 보여주기 처리
		$('.wrap-loading').removeClass('display-none');

  	//--------------------
  	mySorting.setSort(idx);				//소팅객체를 소팅한다.(상태값들의 변화)

		//소팅
      sortByKey(myGrid.getList(), mySorting.nowSortCol, mySorting.nowDirection);
      myGrid.refresh();


		mySorting.applySortIcon();			//소팅화면적용
		//--------------------

		// 로딩 이미지 감추기 처리
      $('.wrap-loading').addClass('display-none');
  },


	//신규고객등록
  regCstPopup: function(){
	  var url = "<c:url value='/person/regCstPopup.do'/>";
	  window.open(url, 'regCstPopupNew','resizable=no,width=968,height=630,scrollbars=yes');

	  /* var url = "<c:url value='/person/regCstPopup.do'/>";
     	var params = {};	//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.


     	myModal.open({
     		url: url,
     		pars: params,
     		titleBarText: '신규고객등록',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
     		method:"POST",
     		top: 150,
     		width: 720,
     		closeByEscKey: true				//esc 키로 닫기
     	});

     	$('#myModalCT').draggable(); */

  },

  //고객구분 수정 레이어 팝업
  /* KJS 수정
  openCstTypePop: function(cstId, custType, rowIdx, e){

  	$('#cstIdToChngCstType').val(cstId);		//고객구분을 바꿀 고객의 id 세팅...hidden input
  	$('#rowIdxToChngCstType').val(rowIdx);		//grid row index

	var divTop = e.clientY-5; 		//상단 좌표 위치 안맞을시 e.pageY
	var divLeft = e.clientX-10; 		//좌측 좌표 위치 안맞을시 e.pageX

	$('#divPopCstType').css({
		"top"	: divTop,
		"left"	: divLeft
	}).show();

	$('#divPopCstTypeClose').click(function(){$('#divPopCstType').hide();});

	if(!isEmpty(custType))
		$('input[name=rdCstTypePop][value=' + custType + ']').attr('checked', true);	//바꾸려는 고객의 기 고객구분으로 기본 체크 상태로.
  },


  //고객구분 수정 레이어 팝업 에서 고객구분 클릭
  clickRdCstTypePop: function(th) {

  	////////// 고객구분 변경 프로세스 ///////////

  	//custTypeNm
  	var list = myGrid.getList();
  	list[$('#rowIdxToChngCstType').val()].custTypeNm = th.nextSibling.nodeValue;		//고객구분 한글명 변경(데이터셋에만... db는 하단 ajax 호출)
  	list[$('#rowIdxToChngCstType').val()].custType = $(th).val();						//고객구분 코드

  	//alert(list[$('#rowIdxToChngCstType').val()].custTypeNm);
  	//$('input[name=rdCstTypePop]

  	myGrid.refresh();				//화면 반영

  	$('#divPopCstType').hide();		//레이어 팝업 닫기(숨기기)


  	//////////// 수정 ajax
  	var url = contextRoot + "/person/doSaveCstType.do";
  	var param = {
  			cstId	: $('#cstIdToChngCstType').val(),
  			cstType : $(th).val()
  	}

  	var callback = function(result){

  		var obj = JSON.parse(result);

  		var cnt = obj.resultVal;	//결과수

  		if(obj.result == "SUCCESS"){
  			toast.push("등록 되었습니다!");
  		}else{
  		}

  	};

  	commonAjax("POST", url, param, callback);
  },
  */


  //고객삭제
  delCst: function(){
  	var jObj = $('input:checkbox[name=mCheck]:checked');
  	if(jObj.length == 0){
  		alert("고객을 선택하신 후 삭제를 진행하시기 바랍니다.");
  		return;
  	} else if(jObj.length > 0){

  		var list = myGrid.getList();	//그리드 데이터(array object)

      	var cstSnbList = '';			//고객 id list

      	var chkedCnt = jObj.length;		//체크한 고객수
      	var myCstCnt = 0;				//체크한 나의 담당 고객수
      	var chkboxAll = document.getElementsByName('mCheck');		//고객 체크박스
      	for(var i=0; i<chkboxAll.length; i++){
      		if(chkboxAll[i].checked){
      			if('${baseUserLoginInfo.userId}' == list[i].userId){		//삭제하려는 고객이 나의 고객일때
      				if(myCstCnt>0) cstSnbList += ',';
      				cstSnbList += list[i].sNb;					//삭제대상 고객 리스트에 추가

      				myCstCnt++;
      			}
      		}
      	}


      	if(myCstCnt == 0){
      		alertM('\n담당인 고객을 선택하시기 바랍니다.\n');
      		return;
      	}

		//console.log(list)

      	//등록 프로세스 진행
      	var delMsg = '[주의 !!]\n\n 삭제 하시겠습니까?\n\n';
      	if(chkedCnt > myCstCnt){
      		delMsg += '(** 확인사항 **)\n삭제는 담당인 고객만 삭제됩니다\n선택한 ' + chkedCnt + '명중 담당인 ' + myCstCnt + '명이 삭제됩니다\n\n';
      	}
      	if(confirm(delMsg)){

      		var url = contextRoot + "/person/doDelCst.do";
          	var param = {
          			cstList : cstSnbList
          	}

          	var callback = function(result){

          		var obj = JSON.parse(result);

          		var cnt = obj.resultVal;	//결과수

          		if(obj.result == "SUCCESS"){

          			//alertM("등록 되었습니다.");
          			//parent.myModal.close();

          			toast.push("삭제 되었습니다!");
          			//parent.fnObj.doSearch();


          			//화면반영 ------------------------
          			//데이터 삭제
          			for(var i=chkboxAll.length-1; i>=0; i--){
                  		if(chkboxAll[i].checked && '${baseUserLoginInfo.userId}' == list[i].userId){
                  			list.splice(i,1);		//삭제
                  		}
          			}
          			myGrid.refresh();	//반영

          		}else{
          			//alertMsg();
          		}

          	};

          	//alert(JSON.stringify(param));
          	//return;

          	commonAjax("POST", url, param, callback);
      	}


  	}
  },

	//################# else function :E #################

};//end fnObj.


	/*
	* 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
	*/
	$(function(){
		fnObj.preloadCode();	//공통코드 or 각종선로딩코드
		fnObj.pageStart();		//화면세팅
		fnObj.setUserTree();
		fnObj.doSearchNewInCharge();	//나에게 할당된 신규 건 체크 >> 팝업
		if("${baseUserLoginInfo.orgId}"!="${baseUserLoginInfo.applyOrgId}"){
			var userIdList = [];
			fnObj.selStaff(userIdList);
		}

	});
	//왼쪽 메뉴관련 열기, 닫기
	function setVisibleLeftMenu(n){
	    var containerNm = 'container';
	    if(document.getElementById('container')==null){
	        containerNm = 'ADM_container';
	    }

	    var divLeft = $('#leftPanel')[0];		//왼쪽 메뉴 공간 div
	    if(n==0){
	        $(divLeft).hide();
	       // $('#btnLeftMenuHide').hide();	//왼쪽메뉴 숨김버튼 숨기기
	        //$('#btnLeftMenuShow').show();	//왼쪽메뉴 보기버튼 보이게
	        $('#rightPanel').css('width', '100%');	//내용 100%
	    }else{
	        $(divLeft).show();
	      //  $('#btnLeftMenuHide').show();
	      //  $('#btnLeftMenuShow').hide();
	        $('#rightPanel').css('width', 'auto');	//내용 88%(원복)
	    }
	}

	/////////////////////////////////////////////////////////////////////////////////
	/////////////// 추가된 스크립트 ////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////

	//화면 리로딩
	function openPage(){
	    fnObj.doSearch(curPageNo);
	}

	//엑셀 다운로드
	function excelDownload(){
		var url = "<c:url value='/person/getCustListForExcel.do'/>";

		if($("#cstType").val() == '00001') $("#isStock").val("Y");  //고객구분 이 증권사IB 여부   'Y'
		else $("#isStock").val("");

		$("#srchCustNmKor").val(engTypeToKor($('#srchCustNm').val()));  //고객명(한글로)

	    $("#frmPerson").attr("action", url);
	    commonAjaxSubmit("POST", $("#frmPerson"), excelDownloadCallback);
	}

	function excelDownloadCallback(data){
		excelDown(data, '네트워크_고객_' +(new Date().yyyy_mm_dd()));
	}
</script>
