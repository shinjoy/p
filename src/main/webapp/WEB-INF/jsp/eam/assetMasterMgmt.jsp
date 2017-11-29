<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->
<style type="text/css">

#displayModeUpdate{
	/* color: #69b4ff; */
	display	:none;
}
/* print style */
@media print {

#IB_Snb, #IB_Navi { display:none; }
#contentsWrap { border-left:0px;}
#contentsWrap{ width: 96%;}

}

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

<div class="wrap-loading display-none">
    <div><img src="${pageContext.request.contextPath}/images/ajax_loading.gif" /></div>
</div>
<!-- -------- each page css :E -------- -->



<section id="detail_contents">

	<form name="myForm">

        <!-- 게시판 정렬목록 -->
        <div class="board_classic">
            <div class="leftblock">
            	<span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
                <select id="sel_page_size" onChange="fnObj.setPageSize(true);" class="sh_count_type" title="정렬방법 선택">
                	<option value="10">10개씩 보기</option>
                	<option value="15">15개씩 보기</option>
                    <option value="30">30개씩 보기</option>
                    <option value="50">50개씩 보기</option>
                </select>
            </div>
            <div class="rightblock" style="text-align:right;">
                <!-- <span style="padding-right:50px;">관계사 <div id="orgSelectDiv" style="display:inline-block;"></div></span> -->
              	<div style="display:inline-block;">
              		<input id="srch_search" type="text" placeholder="자산마스터 검색" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" style="float:none;" title="자산마스터 검색" />
                	<a href="#" onclick="fnObj.doSearch(1);" class="btn_wh_bevel" style="float:none;">검색</a>
                </div>

           </div>
        </div>
        <!--/ 게시판 정렬목록 /-->
        <!-- 프로젝트 목록 -->
		<table id="SGridTarget" class="datagrid_basic lineadd" summary="자산관리 마스터 리스트(자산코드, 자산분류, 자산유형, 게정, 자산명, 구입일자, 금액, 수량, 상태)">
            <caption>자산마스터 목록</caption>
            <colgroup>
               <col width="10%" />
               <col width="10%" />
               <col width="12%" />
               <col width="12%" />
               <col width="*" />
               <col width="10%" />
               <col width="10%" />
               <col width="10%" />
               <col width="10%" />
           </colgroup>
            <thead>
                <tr>
                    <th scope="col">자산코드</th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">자산분류<em>정렬</em></a></th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">자산유형<em>정렬</em></a></th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">계정<em>정렬</em></a></th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">자산명<em>정렬</em></th>
                    <th scope="col">구입일자</th>
                    <th scope="col">금액</th>
                    <th scope="col">수량</th>
                    <th scope="col">상태</th>
                   <!--  <th scope="col">사용여부</th> -->
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <!--/ 템플릿 목록 /-->
        <!-- 페이지 목록 -->
        <div class="btnPageZone" id="btnPageZone">
            <button type="button" class="pre_end_btn"><em>맨처음 페이지</em></button>
            <button type="button" class="pre_btn"><em>이전 페이지</em></button>

            <button type="button" class="next_btn"><em>다음 페이지</em></button>
            <button type="button" class="next_end_btn"><em>맨마지막 페이지</em></button>
        </div>
        <!--/ 페이지 목록 /-->

		<h3 class="grid_title">
			[ 자산 - <span id="assetNameArea" class="pointsetcolor"></span>  <span id="displayModeNew"> 등록</span>
			<span id="displayModeUpdate"> 수정</span> ]
		</h3>
        <table id="reg_input_grid" class="datagrid_input" summary="자산마스터 등록/수정 ( 자산코드, 자산유형, 자산이름, 계정 )">
            <caption>자산마스터 등록/수정</caption>
            <colgroup>
                <col width="12%">
                <col width="17%">
                <col width="12%">
                <col width="17%">
                <col width="12%">
                <col width="17%">
            </colgroup>
            <tbody>
            	<tr id="companyNameArea">
                	<th scope="row"><label for="regOrgSelBox">등록회사</label></th>
                    <!-- <td colspan="2"><div id="regOrgSelectTag"></div></td> -->
                   	<!-- <th scope="row"><label for="regOrgSelBox">등록회사</label></th> -->
                    <td colspan="5"><div id="regCompanySelectTag"></div></td>
                </tr>
                <tr>
                	<th scope="row"><label for="selAssetClass">자산분류</label></th>
                    <td><div id="assetClassSelectTag"></div></td>
                    <th scope="row"><label for="selAssetType">자산유형</label></th>
                    <td><div id="assetTypeSelectTag"></div></td>
                    <th scope="row"><label for="selAssetAccount">계정</label></th>
                    <td><div id="assetAccountSelectTag"></div></td>

                </tr>
                <tr>
                	<th scope="row"><label for="inAssetCode">자산코드</label></th>
                    <td><input id="inAssetCode" name="inAssetCode" class="w100" placeholder="" readonly="readonly" style="background-color:#EFEFEF!important;"/></td>
                   	<th><label for="inAssetName">자산명</label></th>
                    <td><input id="inAssetName" name="inAssetName" class="w100" placeholder="자산명을 입력하세요"/></td>
                    <th><label for="inGetDate">구입일자</label></th>
                    <td><input type="text" id="inGetDate" class="input_date_type" title="구입일자"  readonly="readonly"/><a href="#" onclick="$('#inGetDate').datepicker('show');return false;" class="icon_calendar"><em>날짜선택</em></a></td>

                </tr>

                <tr>
                    <th scope="row"><label for="inGetPrice">금액</label></th>
                    <td><input type="text" id="inGetPrice" name="inGetPrice" class="w100 input_b num_money_type number" maxlength="13" placeholder="원" /></td>
                    <th><label for="qty">수량</label></th>
                    <td><input type="text" id="qty" name="qty" class="w100 input_b num_money_type number" maxlength="10" placeholder="ea" value="1" /></td>
                    <th><label for="selAssetStatus">상태</label></th>
                    <td><div id="assetStatusSelectTag"></div></td>
                </tr>
            </tbody>
        </table>
        <ul class="dot_list_st02 mgt10">
        	<li>신규추가는 신규추가 버튼을 누르고 정보입력후 저장을 눌러 추가합니다.</li>
        </ul>
        <!-- <p class="notice_script">* 신규추가는 신규추가 버튼을 누르고 정보입력후 저장을 눌러 추가합니다.</p> -->
        <div class="btn_baordZone2" style="display:none;" id="btn_update">
            <a href="javascript:fnObj.setNew();"` id="btn_new" class="btn_blueblack btn_auth">신규추가</a>
            <a href="javascript:fnObj.doSave();" id="btn_update" class="btn_witheline btn_auth">수정</a>
            <a href="javascript:fnObj.tryDel();" id="btn_del" class="btn_witheline btn_auth">삭제</a>
         </div>
         <div class="btn_baordZone2" id="btn_save">
            <a href="javascript:fnObj.doSave();" class="btn_witheline btn_auth">저장</a>
        </div>


	</form>

</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')
//공통코드 (외, 코드)
var codeYesNo;				//Yes or No
var codeYesNoForNm;
var codeChgPeriodYesNo;
var codeChgTimeSheetYesNo;
var codeOverExpenseYesNo;
var codeProjectType;
var orgCodeCombo;				//ORG 코드
var myModal = new AXModal();	// instance


var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs


var g_assetId = '';				//선택하여 수정대상인 자산id


var curPageNo = 1;				//현재페이지번호
var pageSize = 10;				//페이지크기(상수 설정)


//div popup 방식을 위한 글쓰기,수정 위한 변수
var mode;						//"new", "view", "update"

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		numberFormatForNumberClass();
		/*
		//코드
		codeYesNo = [{CD:'N', NM:'No'}, {CD:'Y', NM:'Yes'}];
		codeYesNoForNm = {N:'No',Y:'Yes'};					//화면에 NM 뿌려주기위해
		codeChgPeriodYesNo = [{CD:'Y', NM:'기간수정가능'}, {CD:'N', NM:'기간수정불가'}];
		codeChgTimeSheetYesNo = [{CD:'Y', NM:'기간상관없음'}, {CD:'N', NM:'기간내표기'}];
		codeOverExpenseYesNo = [{CD:'Y', NM:'예산초과허용'}, {CD:'N', NM:'예산초과불가'}];
		codeProjectType = [{CD:'A', NM:'Type A'}, {CD:'B', NM:'Type B'}, {CD:'C', NM:'Type C'}];		// //////////////// 바꿔야 할 부분!!!! 실제 데이터로..
		*/
		//공통코드
		comCodeAssetClass = getBaseCommonCode('ASSET_CLASS', lang, 'CD', 'NM', null, null, 'SELECT', {orgId : "${baseUserLoginInfo.applyOrgId}" });		//자산분류 공통코드 (Sync ajax)
		if(comCodeAssetClass == null){
			comCodeAssetClass = [{ 'CD':'', 'NM':'선택'}];
		}
		comCodeAssetType = getBaseCommonCode('ASSET_TYPE', lang, 'CD', 'NM', null, null, 'SELECT' , {orgId : "${baseUserLoginInfo.applyOrgId}" });			//자산유형 공통코드 (Sync ajax)
		if(comCodeAssetType == null){
			comCodeAssetType = [{ 'CD':'', 'NM':'선택'}];
		}
		comCodeAssetAccount = getBaseCommonCode('ASSET_ACCOUNT', lang, 'CD', 'NM', null, null, 'SELECT' , {orgId : "${baseUserLoginInfo.applyOrgId}" });	//자산계정 공통코드 (Sync ajax)
		if(comCodeAssetAccount == null){
			comCodeAssetAccount = [{ 'CD':'', 'NM':'선택'}];
		}
		comCodeAssetStatus = getBaseCommonCode('ASSET_STATUS', lang, 'CD', 'NM', null, null, 'SELECT' , {orgId : "${baseUserLoginInfo.applyOrgId}" });		//자산상태 공통코드 (Sync ajax)
		if(comCodeAssetStatus == null){
			comCodeAssetStatus = [{ 'CD':'', 'NM':'선택'}];
		}

		//관계사 추가(org 콤보박스)
		var params = {'authOrgId':'Y', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, 'SELECT', '/common/getOrgCodeCombo.do', params);
		if(orgCodeCombo == null){
			orgCodeCombo = [{ 'CD':'', 'NM':'선택'}];
		}

		//기간수정가능여부
		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var assetClassSelectTag = createSelectTag('selAssetClass', comCodeAssetClass, 'CD', 'NM', '', null, colorObj, null, 'w100 select_b');	//select tag creator 함수 호출 (common.js)
		$("#assetClassSelectTag").html(assetClassSelectTag);
		var assetTypeSelectTag = createSelectTag('selAssetType', comCodeAssetType, 'CD', 'NM', '', null, colorObj, null, 'w100 select_b');	//select tag creator 함수 호출 (common.js)
		$("#assetTypeSelectTag").html(assetTypeSelectTag);
		var assetAccountSelectTag = createSelectTag('selAssetAccount', comCodeAssetAccount, 'CD', 'NM', '', null, colorObj, null, 'w100 select_b');	//select tag creator 함수 호출 (common.js)
		$("#assetAccountSelectTag").html(assetAccountSelectTag);
		var assetStatusSelectTag = createSelectTag('selAssetStatus', comCodeAssetStatus, 'CD', 'NM', '', null, colorObj, null, 'w100 select_b');	//select tag creator 함수 호출 (common.js)
		$("#assetStatusSelectTag").html(assetStatusSelectTag);

		//관계사 추가(org 셀렉트박스 검색)
		/* var orgSelectTag = createSelectTag('searchOrgSelBox', orgCodeCombo, 'optionValue', 'optionText', '${baseUserLoginInfo.applyOrgId}', 'fnObj.doSearch(1);', colorObj, null, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#orgSelectDiv").html(orgSelectTag); */

		//관계사 추가(org 셀렉트박스 등록)
		/* var regOrgSelectTag = createSelectTag('regOrgSelBox', orgCodeCombo, 'optionValue', 'optionText', '${baseUserLoginInfo.applyOrgId}', 'fnObj.getCompanyList();', colorObj, null, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#regOrgSelectTag").html(regOrgSelectTag); */

		$("#inGetDate").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			yearRange: 'c-1:c+9',
			maxDate: '+0d'
		});
		$("#inGetDate").datepicker('setDate', new Date());

		//fnObj.getCompanyList();	//회사리스트 세팅

		//페이지크기 세팅
		fnObj.setPageSize();
	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {
    		columnCountForEmpty : 9,
    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            //{key:"chk",				formatter:function(obj){return ("<input type='checkbox' name='mCheck' value='" + obj.value + "' onclick='fnObj.clickCheckbox(this, " + obj.index + ");' " + ((obj.value==1)?"checked":"") + " />");}},
            {key:"assetCode"		},
            {key:"assetClassNm"		},
            {key:"assetTypeNm"		},
            {key:"accountNameNm"	},
            {key:"assetName"		},
            {key:"getDate"			},
            {key:"getPrice",		formatter:function(obj){return formatMoney(obj.value,'INSERT');}},
            {key:"qty"	   ,		formatter:function(obj){return formatMoney(obj.value,'INSERT');}},
            {key:"statusNm"			},
            //데이터만
            {key:"projectId" 		}
          /*   {key:"enable" 		} */
            ],

            body : {
                onclick: function(obj){
                	/* ***** obj *****
                		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
                	*/
                	//if(obj.c > 0){
                	fnObj.setAssetInfo(obj.item);
                	//}
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	//rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td scope="row">#[0]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td>#[3]</td>';
    	rowHtmlStr +=	 '<td>#[4]</td>';
    	rowHtmlStr +=	 '<td class="num_date_type">#[5]</td>';
    	rowHtmlStr +=	 '<td class="num_money_type">#[6]</td>';
    	rowHtmlStr +=	 '<td class="num_money_type">#[7]</td>';
    	rowHtmlStr +=	 '<td>#[8]</td>';
    	/* rowHtmlStr +=	 '<td>#[10]</td>'; */
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
			colList : ['assetClassNm', 'assetTypeNm', 'accountNameNm', 'assetName'],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
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
    			//toast.push("모달 close");

				//if(window[myModal.winID].isSaved == false){		//저장을 안한상태로 창이 닫힐때, 이미 업로드한 파일은 삭제
    			//	window[myModal.winID].fnObj.deleteFile();	//팝업창 내 파일삭제함수 호출.
    			//}
    		}
            ,contentDivClass: "popup_outline"
    	});
    	//-------------------------- 모달창 :E -------------------------


    	//입력폼 disable 기본
    	//setDisableChildren($('#reg_input_grid').get(0));

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	if(page==null) page=1;
    	//alert($('#searchOrgSelBox').val());
    	var url = contextRoot + "/eam/getAssetMasterList.do";
    	var param = {
		    			pageSize: pageSize,
		    			pageNo:	page,

		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,

		    			//knd: '',	//$('#srch_knd').val(),				//검색 종류
		    			search: $('#srch_search').val(),				//검색 어
		    			orgId : '${baseUserLoginInfo.applyOrgId}'//$('#searchOrgSelBox').val()
		    		};


    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}


    		var cnt = obj.resultVal;		//결과수
    		var list = obj.resultList;		//결과데이터JSON


    		curPageNo = obj.pageNo;			//현재페이지세팅(global variable)


    		var pageObj = {						//페이징 데이터
					pageNo : curPageNo,
					pageSize : pageSize,
					pageCount: obj.pageCount
				}

    		//alert(JSON.stringify(pageObj));

    		myPaging.setPaging(pageObj);		//페이징 데이터 세팅	*** 1 ***

    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list,		//그리드 테이터
								page: pageObj	//페이징 데이터
    						});

    		//alert(JSON.stringify(list));

    		//mySorting.clearSort();			//소팅초기화
			mySorting.applySortIcon();		//소팅화면적용


			//전체 건수 세팅
			$('#total_count').html(obj.totalCount);

    	};

    	commonAjax("POST", url, param, callback,true);

    },//end doSearch


  	//자산마스터 정보 선택 세팅
    setAssetInfo: function(obj){
    	var frm = document.myForm;

    	//모드 확인 텍스트 세팅
		$('#displayModeNew').hide();
    	$('#btn_save').hide();
		$('#displayModeUpdate').show();		//수정모드
		$("#btn_update").show();

		//입력폼 enable
    	setEnableChildren($('#reg_input_grid').get(0));

    	g_assetId = obj.assetId;

    	$("#assetNameArea").html(obj.assetName);


    	frm.inAssetCode.value		= obj.assetCode;
		frm.selAssetClass.value 	= obj.assetClass;
		frm.selAssetType.value 		= obj.assetType;
		frm.selAssetAccount.value 	= obj.accountName;
		frm.inAssetName.value 		= obj.assetName;
		frm.inGetDate.value 		= obj.getDate;
		frm.inGetPrice.value 		= obj.getPrice;
		frm.selAssetStatus.value 	= obj.status;

		//추가
		frm.qty.value 				= obj.qty;
		//frm.regOrgSelBox.value 		= obj.orgId;
		//fnObj.getCompanyList();	// 회사 검색
		frm.regCompanySelBox.value 	= obj.ownCompany;


    },//setAssetInfo


  	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },


    //페이지 사이즈 세팅
    setPageSize: function(isSearch){

    	pageSize = $('#sel_page_size').val();

    	//검색도 바로할 경우 ... isSearch ... true
		if(isSearch){
			fnObj.doSearch(1);
    	}
    },


    //신규추가
    setNew: function(){
		var frm = document.myForm;

		$("#assetNameArea").html('');
		//모드 확인 텍스트 세팅
		$('#displayModeNew').show();		//신규모드
		$('#btn_save').show();
		$('#displayModeUpdate').hide();
		$('#btn_update').hide();

		//입력폼 enable
    	//setEnableChildren($('#reg_input_grid').get(0));


    	g_assetId = '';

    	frm.inAssetCode.value		= '';
		//frm.selAssetClass.value 	= '';
		//frm.selAssetType.value 		= '';
		//frm.selAssetAccount.value 	= '';
		frm.inAssetName.value 		= '';
		frm.inGetDate.value 		= new Date().yyyy_mm_dd();
		frm.inGetPrice.value 		= '';
		//frm.inOwnCompany.value		= '';
		frm.qty.value 				= '1';
		//frm.selAssetStatus.value 	= '';
    },


  	//저장 doSave
  	doSave: function(){

  		var list = myGrid.dataList;


		//--------------- validation :S ---------------
		var frm = document.myForm;

    	if(isEmpty(frm.selAssetClass.value)){			//자산분류
    		dialog.push({body:"<b>확인!</b> 자산분류를 입력해주세요!", type:"", onConfirm:function(){frm.selAssetClass.focus();}});
    		return;
    	}
    	if(isEmpty(frm.selAssetType.value)){			//자산유형
    		dialog.push({body:"<b>확인!</b> 자산유형을 입력해주세요!", type:"", onConfirm:function(){frm.selAssetType.focus();}});
    		return;
    	}
    	if(isEmpty(frm.selAssetAccount.value)){			//계정
    		dialog.push({body:"<b>확인!</b> 계정을 입력해주세요!", type:"", onConfirm:function(){frm.selAssetAccount.focus();}});
    		return;
    	}
    	if(isEmpty(frm.inAssetName.value)){			//자산명
    		dialog.push({body:"<b>확인!</b> 자산명을 입력해주세요!", type:"", onConfirm:function(){frm.inAssetName.focus();}});
    		return;
    	}
    	if(isEmpty(frm.inGetPrice.value)){				//금액
    		dialog.push({body:"<b>확인!</b> 금액을 입력해주세요!", type:"", onConfirm:function(){frm.inGetPrice.focus();}});
    		return;
    	}
    	if(isEmpty(frm.selAssetStatus.value)){				//상태
    		dialog.push({body:"<b>확인!</b> 상태를 입력해주세요!", type:"", onConfirm:function(){frm.selAssetStatus.focus();}});
    		return;
    	}

    	$(".number").each(function(){
			$(this).val($(this).val().split(",").join(""));
		});

  		///////////////////////////////////////////// 바서.....activity 명 , 설명 입력 validation 추가하자!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    	//--------------- validation :E ---------------

    	//저장&수정
    	var url = contextRoot + "/eam/doSaveAssetMaster.do";
    	var param = {

    			assetId		 : g_assetId,

    			assetClass	 : frm.selAssetClass.value,
    			assetType	 : frm.selAssetType.value,
    			assetAccount : frm.selAssetAccount.value,
    			assetName	 : frm.inAssetName.value,
    			getDate		 : frm.inGetDate.value,
    			getPrice	 : frm.inGetPrice.value,

    			orgId	 	 : '${baseUserLoginInfo.applyOrgId}',						//frm.regOrgSelBox.value,
    			ownCompany 	 : frm.regCompanySelBox.value,
    			qty		 	 : frm.qty.value,
    			status		 : frm.selAssetStatus.value

    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		g_assetId = obj.resultVal;	//assetId

    		if(obj.result == "SUCCESS"){

    			toast.push("성공하였습니다.");

    			fnObj.doSearch();

    			//신규모드
    			fnObj.setNew();

    		}else{
    			dialog.push({body:"<b>오류가 발생하였습니다.</b>", type:"warning", onConfirm:function(){return;}});

    		}

    	};

    	commonAjax("POST", url, param, callback);


  	},//doSave
  	//재정렬
  	doSort : function(index){

  		// 로딩 이미지 보여주기 처리
		$('.wrap-loading').removeClass('display-none');

  		mySorting.setSort(index);

  		fnObj.doSearch(1);

  		//소팅
        myGrid.refresh();
        mySorting.applySortIcon();			//소팅화면적용

    	// 로딩 이미지 감추기 처리
        $('.wrap-loading').addClass('display-none');
  	},//doSort


  	//삭제시도
  	tryDel: function(){
  		var trList = $('#SGridTarget').find('tr[class=tr_selected]');
  		if(trList.length == 0){
  			dialog.push({body:"<b>확인!</b> 삭제할 건을 선택해주세요!", type:"", onConfirm:function(){}});
    		return;
  		}

  		var list = myGrid.getList();
  		for(var i=0; i<list.length; i++){
  			if(list[i].assetId == g_assetId){
  				dialog.push({
        		    body:'<b>경고:</b>&nbsp;&nbsp;삭제하시겠습니까?<br><br>[자산명:<b> ' + list[i].assetName + ' </b>]', top:0, type:'Caution', buttons:[
                        {buttonValue:'확인', buttonClass:'Red', onClick:fnObj.doDel, data:{assetId:list[i].assetId}},	//, data:{param:"222"}},	//Red W100
                        {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}	//, data:'data2'},
                        //{buttonValue:'button3', buttonClass:'Green', onClick:fnObj.btnClick, data:'data3'}
        		    ]});
  				break;
  			}
  		}
  	},
  	//삭제
  	doDel: function(param){
  		//alert(param.assetId);

  		var url = contextRoot + "/eam/doDelAssetMaster.do";
    	var param = {

    			assetId		 : param.assetId

    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		if(obj.result == "SUCCESS"){

    			toast.push("삭제OK!");

    			//fnObj.doSearch();

    			//신규모드
    			//fnObj.setNew();

    			var url = document.location.pathname+document.location.search;
    			window.location.href = url;

    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);

  	},

  	doPrint : function(){
  		window.print();
  	},

  	//orgId 선택시 companylist
  	getCompanyList : function(){

  		var companyList = getCodeInfo(lang, 'optionValue', 'optionText', null, null, 'SELECT', '/common/getCompanyListCombo.do', {orgId : '${baseUserLoginInfo.applyOrgId}', excGrpRefOrgId : 'Y'});
  		var regCompanySelectTag = createSelectTag('regCompanySelBox', companyList, 'optionValue', 'optionText', null, null, {}, null, 'select_b');
  	  	$("#regCompanySelectTag").html(regCompanySelectTag);


  	   	if(companyList==null || companyList.length<2){			//관계사의 하위 회사가 없을때는 숨김 처리.
  			$("#companyNameArea").hide();
  		}

  	}

  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.getCompanyList();
	fnObj.pageStart();		//화면세팅

	fnObj.doSearch();		//검색
	//fnObj.setTooltip();
});
</script>