<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->
<style type="text/css">
/* .datagrid_basic {
    letter-spacing: -0.08px;
    width: 100%;
    border: #c3c3c3 solid 1px;
}
.datagrid_input input {
    height: 20px;
    line-height: 20px;
    border: #cecece solid 1px;
    text-indent: 4px;
    box-sizing: border-box;
    vertical-align: middle;
    color: #858585;
}
select, input, option, textarea {
    vertical-align: middle;
    font-family: "돋움";
}
.datagrid_basic tbody td:first-child{
	font-weight: bold;
}
 */
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
<div id="imageArea" class="cartooltip"  style="display:none;position:absolute;height: expression( this.scrollHeight > 99 ? 200px : auto );z-index:1;">
	<div id="nowCarpop" class="tooltip_box" style="overflow:auto; overflow-x:hidden;width:260px;height:auto;">

	<div id="detail_imgt_pop" style="dispaly:none";>
	</div>
	<em class="edge_topcenter"></em>
	<a href="#" onclick="javascript:$('#imageArea').hide();$('#detail_imgt_pop').hide();return false;" class="closebtn_s">
	<img src="../images/common/icon_car_tooltip_close.gif" alt="닫기" />
	</a>
	</div>
</div>
<section id="detail_contents">

	<form name="myForm" id="myForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/eam/doSaveCar.do";>
		<input type="hidden" name="carId" id="carId"/>
		<input type="hidden" name="assetId" id="assetId"/>

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
            <div class="rightblock">
              	<div style="display:inline-block;">
                	<input id="srch_search" type="text" style="float:none;" placeholder="자산마스터 검색" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="자산마스터 검색" />
                	<a href="#" onclick="fnObj.doSearch(1);" class="btn_wh_bevel" style="float:none;">검색</a>
                </div>
            </div>
        </div>
        <!--/ 게시판 정렬목록 /-->
        <!-- 프로젝트 목록 -->
		<table id="SGridTarget" class="datagrid_basic lineadd" summary="차량 리스트 (자산코드, 자산분류, 자산명, 차량번호, 차량닉네임, 모델명, 오토/수동, 누적거리, 사용여부, 상태, 사진)">
            <caption>차량 리스트</caption>
            <colgroup>
               <col width="*" /> <!--자산코드-->
               <col width="*" /> <!--자산분류-->
               <col width="*" /> <!--자산명-->
               <col width="*" /> <!--차량번호-->
               <col width="*" /> <!--차량닉네임-->
               <col width="*" /> <!--모델명-->
               <col width="*" /> <!--오토/수동-->
               <col width="*" /> <!--누적거리-->
               <col width="*" /> <!--사용여부-->
               <col width="*" /> <!--상태-->
               <col width="*" /> <!--사진-->
           </colgroup>
            <thead>
                <tr>
                    <th scope="col">자산코드</th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">자산분류<em>정렬</em></a></th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">자산명<em>정렬</em></a></th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">차량번호<em>정렬</em></a></th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">차량닉네임<em>정렬</em></a></th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(4);" id="sort_column_prefix4" class="sort_normal">모델명<em>정렬</em></a></th>
                    <th scope="col">오토/수동</th>
                    <th scope="col">초기 주행거리</th>
                    <th scope="col">사용여부</th>
                    <th scope="col">상태</th>
                    <th scope="col">사진</th>
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

		<h3 class="grid_title">[ <span id="carNameArea" class="pointsetcolor"></span> 차량정보 - <span id="RegEditArea">수정</span> ]</h3>
        <table id="reg_input_grid" class="datagrid_input" summary="차량정보 등록/수정 ( 차량코드, 차량번호, 차량닉넴, 모델명, 오토/수동, 누적거리, 사용여부, 상태, 사진)">
            <caption>차량정보 등록/수정</caption>
            <colgroup>
                <col width="10%" />
                <col width="17%" />
                <col width="10%" />
                <col width="17%" />
                <col width="10%" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="inCarCode">자산코드</label></th>
                    <td><input id="inCarCode" name="inCarCode" class="input_b w100" placeholder="" readonly="readonly" disabled="disabled" /></td>
                    <th scope="row"><label for="inCarNumber">자산분류</label></th>
                    <td><input id="assetClassNm" name="assetClassNm" class="input_b w100" placeholder="" readonly="readonly" disabled="disabled" /></td>
                    <th scope="row"><label for="inCarNick">자산명</label></th>
                    <td><input id="assetName" name="assetName" class="input_b w100" placeholder="" readonly="readonly" disabled="disabled" /></td>
                </tr>
                <tr>
                	<th scope="row"><label for="inCarNumber">차량번호</label></th>
                    <td><input type="text" id="inCarNumber" name="inCarNumber" class="w100 input_b"></td>
                    <th scope="row"><label for="inCarNick">차량닉네임</label></th>
                    <td><input type="text" id="inCarNick" name="inCarNick" class="w100 input_b"></td>
                     <th scope="row"><label for="inCarModel">모델명</label></th>
                    <td><input type="text" id="inCarModel" name="inCarModel" class="w100 input_b"></td>
                </tr>
                <tr>
                    <th><label for="selAutoYn">오토/수동</label></th>
                    <td><div id="autoYnSelectTag"></div></td>
                    <th><label for="inMileage">초기 주행거리</label></th>
                    <td><input type="text" id="inMileage" name="inMileage" class="w100 input_b num_money_type number" maxlength="10" placeholder="km"></td>
               		 <th scope="row"><label for="selEnable">사용여부</label></th>
                    <td><div id="enableSelectTag"></div></td>
                </tr>
                <tr>
                    <th><label for="selCarStatus">상태</label></th>
                    <td><div id="carStatusSelectTag"></div></td>
                    <th><label for="selAssetStatus">사진</label></th>
                    <td colspan="3">
                    	<!-- <a href="javascript:fnObj.imageFile();" class="btn_file_finder"><em>이미지찾기</em></a> -->
                    	<span id="fileInputArea" class="file_btn_bg">
                    		<input name="inFile" id="inFile" type="file" multiple onchange="fnObj.changeFile();" class="file_btn_cover">
                    	</span>
                    	<span id="carImageFile" class="employee_list"></span></td>
                		<input type="hidden" name="fileDelYn" id="fileDelYn" value="N"/>
                </tr>
            </tbody>
        </table>
        <ul class="dot_list_st02 mgt10">
        	<li>입력하실 차량을 목록에서 선택하신후에 정보를 입력하시기 바랍니다.</li>
        	<li>자산 등록 후 꼭 차량등록을 해야 사용가능합니다. <span class="imsicode">(자산코드 파란색)</span></li>
        </ul>
        <!-- <p class="notice_script">* 입력하실 차량을 목록에서 선택하신후에 정보를 입력하시기 바랍니다.</p>
        <p class="notice_script">* 자산 등록 후 꼭 차량등록을 해야 사용가능합니다.(자산코드 파란색)</p> -->
        <div class="btn_baordZone2">
            <%--<a href="javascript:fnObj.setNew();" class="btn_blueblack">신규추가</a> --%>
            <a href="javascript:fnObj.doSave();" class="btn_witheline btn_auth"><span id="editBtnName">수정</span></a>
           <!--  <a href="javascript:fnObj.tryDel();" id="deleteBtn" class="btn_witheline">삭제</a> -->
        </div>


	<!-- <input type="file" name="inFile" id="inFile" style="display:none;" onchange="fnObj.changeFile();" /> -->

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

var myModal = new AXModal();	// instance


var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs


var g_carId = '';				//선택하여 수정대상인 자산id


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
		//공통코드
		codeAutoYesNo = [{CD:'Y', NM:'오토'}, {CD:'N', NM:'수동'}];		//오토/수동

		codeEnableYesNo = [{CD:'Y', NM:'사용중'}, {CD:'N', NM:'불가'}];
		codeEnableYesNoForNm = {'Y':'사용중', 'N':'불가'};

		comCodeCarStatus = getBaseCommonCode('CAR_STATUS', lang, 'CD', 'NM', '', '선택', 'SELECT', { orgId : "${baseUserLoginInfo.applyOrgId}"});			//상태 공통코드 (Sync ajax)
		if(comCodeCarStatus == null){
			comCodeCarStatus = [{'CD':'', 'NM':'선택'}];
		}
		//관계사 추가(org 콤보박스)
		var params = {'authOrgId':'Y', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		var orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, 'SELECT', '/common/getOrgCodeCombo.do', params);
		if(orgCodeCombo == null){
			orgCodeCombo = [{'CD':'', 'NM':'선택'}];
		}
		//기간수정가능여부
		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var autoYnSelectTag = createSelectTag('selAutoYn', codeAutoYesNo, 'CD', 'NM', '', null, colorObj, null, 'w100 select_b');	//select tag creator 함수 호출 (common.js)
		$("#autoYnSelectTag").html(autoYnSelectTag);
		var enableSelectTag = createSelectTag('selEnable', codeEnableYesNo, 'CD', 'NM', '', null, colorObj, null, 'w100 select_b');	//select tag creator 함수 호출 (common.js)
		$("#enableSelectTag").html(enableSelectTag);
		var carStatusSelectTag = createSelectTag('selCarStatus', comCodeCarStatus, 'CD', 'NM', '', null, colorObj, null, 'w100 select_b');	//select tag creator 함수 호출 (common.js)
		$("#carStatusSelectTag").html(carStatusSelectTag);

		/* //관계사 추가(org 셀렉트박스 검색)
		var orgSelectTag = createSelectTag('searchOrgSelBox', orgCodeCombo, 'optionValue', 'optionText', '${baseUserLoginInfo.applyOrgId}', 'fnObj.doSearch(1);', colorObj, null, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#orgSelectDiv").html(orgSelectTag); */

		//페이지크기 세팅
		fnObj.setPageSize();

		//입력폼 disable 기본
    	setDisableChildren($('#reg_input_grid').get(0));

	},


	//화면세팅
    pageStart: function(){

    	$("#RegEditArea").html('등록');

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {
    		columnCountForEmpty : 11,
    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            //{key:"chk",				formatter:function(obj){return ("<input type='checkbox' name='mCheck' value='" + obj.value + "' onclick='fnObj.clickCheckbox(this, " + obj.index + ");' " + ((obj.value==1)?"checked":"") + " />");}},
            {key:"carCode"			},
            {key:"assetClassNm"		},
            {key:"assetName"		},
            {key:"carNumber"		},
            {key:"carNick"			},
            {key:"carModel"			},
            {key:"autoYn",			formatter:function(obj){return (obj.value=='Y')?'오토':(obj.value=='N')?'수동':'';}},
            {key:"mileage",			formatter:function(obj){return (obj.item.carId==null?'': "<span class='kmnumcolor'>" + formatMoney(obj.value,'INSERT') + "</span><span class='kmcolor'>km</span>");}},
            {key:"enable",			formatter:function(obj){

            							var str = '';
            							if(obj.value == 'N') str += '<span class="fontRed"> ';
            							if(obj.value != null) str +=codeEnableYesNoForNm[obj.value];
            							if(obj.value == 'N') str += '</span> ';
            							return str;

            }},
            {key:"carStatusNm"		},
            {key:"carImage",		formatter:function(obj){
            										if(obj.item.carId==null){
            											return '';
            										}else if(isEmpty(obj.value)){
            											return ('<img src="../images/eam/car.jpg" />');
            										}else{
            											var str ='<div  onclick="fnObj.imageView(\''+obj.value+'\',this);" style="z-index:100; cusor:pointer;">';
            											str+='<img width="90" height="56" src="data:image/png;base64,' + obj.value + '" />';
            											str+='</div>';
            											return str;
            										}
            						}},
            {key:"carId",			formatter:function(obj){
            										var str ='';
													if(obj.item.carId==null){
														return ' class="imsicode" ';
									}}
            }
            ],

            body : {
                onclick: function(obj){
                	/* ***** obj *****
                		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
                	*/
                	if(obj.c <9){
                		fnObj.setCarInfo(obj.item);
                	}/* else{
                		fnObj.imageView('<img  src="data:image/png;base64,' + obj.item.carImage + '" />');
                	}   */
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	//rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td scope="row" #[11]>#[0]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td>#[3]</td>';
    	rowHtmlStr +=	 '<td>#[4]</td>';
    	rowHtmlStr +=	 '<td>#[5]</td>';
    	rowHtmlStr +=	 '<td>#[6]</td>';
    	rowHtmlStr +=	 '<td class="num_money_type">#[7]</td>';
    	rowHtmlStr +=	 '<td>#[8]</td>';
    	rowHtmlStr +=	 '<td>#[9]</td>';
    	rowHtmlStr +=	 '<td>#[10]</td>';
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
			colList : ['assetClassNm', 'assetName','carNumber', 'carNick', 'carModel'],
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



    	//차량 사진 [이미지파일] 표기 기본 숨기기
    	$('#carImageFile').hide();


    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page, knd, idx){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	$('#inFile').val('');
    	$("#detail_imgt_pop").hide();
		$("#imageArea").hide();

    	if(page==null) page=1;

    	var url = contextRoot + "/eam/getCarList.do";
    	var param = {
		    			pageSize: pageSize,
		    			pageNo:	page,

		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,
		    			orgId  : '${baseUserLoginInfo.applyOrgId}',		//$("#searchOrgSelBox").val(),
		    			//knd: '',	//$('#srch_knd').val(),		//검색 종류
		    			search: $('#srch_search').val()			//검색 어
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


    		myPaging.setPaging(pageObj);		//페이징 데이터 세팅	*** 1 ***

    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list,		//그리드 테이터
								page: pageObj	//페이징 데이터
    						});


    		//mySorting.clearSort();			//소팅초기화
			mySorting.applySortIcon();		//소팅화면적용


			//전체 건수 세팅
			$('#total_count').html(obj.totalCount);


			//$("#RegEditArea").html('수정');
			$("#editBtnName").html('수정');
    		$("#deleteBtn").show();

			//저장후 재검이 이루어질때 저장건 기본 선택되도록.
			if(knd == 'RE'){
				myGrid.setSelectRow(idx);
			}


    	};


    	commonAjax("POST", url, param, callback,true);

    },//end doSearch


  	//차량 정보 선택 세팅
    setCarInfo: function(obj){

    	//차량 이름 세팅
		$("#carNameArea").html(obj.assetName);

    	if(obj.carId == null){
    		$("#RegEditArea").html('등록');
    		$("#editBtnName").html('등록');
    		$("#deleteBtn").hide();
    	}else{
    		$("#RegEditArea").html('수정');
    		$("#editBtnName").html('수정');
    		$("#deleteBtn").show();
    	}

    	var frm = document.myForm;

    	g_carId = obj.carId;

    	frm.assetClassNm.value 		= obj.assetClassNm;
    	frm.assetName.value 		= obj.assetName;
    	frm.inCarCode.value			= obj.carCode;
		frm.inCarNumber.value	 	= obj.carNumber;
		frm.inCarNick.value 		= obj.carNick;
		frm.inCarModel.value 		= obj.carModel;
		frm.selAutoYn.value 		= obj.autoYn==null?'Y':obj.autoYn;
		frm.inMileage.value 		= obj.mileage;
		frm.selEnable.value 		= obj.enable==null?'Y':obj.enable;
		frm.selCarStatus.value 		= obj.carStatus==null?'':obj.carStatus;
		if(isEmpty(obj.carImage)){
			$('#carImageFile').hide();
		}else{
			$('#carImageFile').html('[이미지파일]<a href="javascript:fnObj.delImageFile();" class="btn_delete_employee"><em>삭제</em></a>');
			$('#carImageFile').show();
		}

		$("#fileDelYn").val('N');
		//입력폼 enable
    	setEnableChildren($('#reg_input_grid').get(0));

    },//setCarInfo


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

    imageView : function(src,th) {
    	if($("#detail_imgt_pop").css("display") == "none"){
    		var right = window.innerWidth-( $(th).position().left + $(th).width());
        	var top =  $(th).position().top+40;

        	$("#imageArea").css({display:"",right:right,top:top,width:'150px'});
        	$("#detail_imgt_pop").html('<img style="width:100%;" src="data:image/png;base64,' + src + '" />');
        	 $("#detail_imgt_pop").show();
        	$("#imageArea").show();
      	}else{
      		$("#detail_imgt_pop").hide();
    		$("#imageArea").hide();

    	}

    },


  	//저장 doSave
  	doSave: function(){

  		var idxList = myGrid.getSelectRowIndex();		//선택한 row index 리스트

  		if(idxList.length == 0){
  			dialog.push({body:"<b>확인!</b> 차량을 선택해주세요!", type:"Caution", onConfirm:function(){}});
    		return;
  		}

  		var list = myGrid.getList();

		//--------------- validation :S ---------------
		var frm = document.myForm;

    	if(isEmpty(frm.inCarNumber.value)){			//차량번호
    		dialog.push({body:"<b>확인!</b> 차량번호를 입력해주세요!", type:"", onConfirm:function(){frm.inCarNumber.focus();}});
    		return;
    	}
    	if(isEmpty(frm.inCarNick.value)){			//차량닉넴
    		dialog.push({body:"<b>확인!</b> 차량닉넴을 입력해주세요!", type:"", onConfirm:function(){frm.inCarNick.focus();}});
    		return;
    	}
    	if(isEmpty(frm.inCarModel.value)){			//모델명
    		dialog.push({body:"<b>확인!</b> 모델명을 입력해주세요!", type:"", onConfirm:function(){frm.inCarModel.focus();}});
    		return;
    	}
    	if(isEmpty(frm.inMileage.value)){			//누적거리
    		dialog.push({body:"<b>확인!</b> 누적거리를 입력해주세요!", type:"", onConfirm:function(){frm.inMileage.focus();}});
    		return;
    	}
    	if(isEmpty(frm.selCarStatus.value)){		//상태
    		dialog.push({body:"<b>확인!</b> 상태를 입력해주세요!", type:"", onConfirm:function(){frm.selCarStatus.focus();}});
    		return;
    	}
    	$(".number").each(function(){
			$(this).val($(this).val().split(",").join(""));
		});

    	//--------------- validation :E ---------------


    	$("#carId").val(g_carId);
    	$("#assetId").val(list[idxList[0]].assetId);

    	$("#myForm").submit();

    	//------------------------------------ie 9 에서 안됨.
    	//저장
    	/* var file = frm.inFile.files;

    	var url = contextRoot + "/eam/doSaveCar.do";
    	var param = {

    			carId		 : g_carId,
    			assetId		 : list[idxList[0]].assetId,
    			fileDelYn	 : frm.fileDelYn.value,
    			carCode		 : frm.inCarCode.value,
    			carNumber	 : frm.inCarNumber.value,
    			carNick		 : frm.inCarNick.value,
    			carModel	 : frm.inCarModel.value,
    			autoYn		 : frm.selAutoYn.value,
    			mileage		 : frm.inMileage.value,
    			enable		 : frm.selEnable.value,
    			carStatus	 : frm.selCarStatus.value
    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}


    		if(obj.result == "SUCCESS"){

    			toast.push("성공하였습니다.");

    			g_carId = obj.resultVal;		//g_carId 전역변수 세팅

    			fnObj.doSearch(curPageNo, 'RE', myGrid.getSelectRowIndex()[0]);	//재검색

    		}else{
    			if(obj.resultVal == -1){dialog.push({body:"<b>사진파일 크기는 200kb 이하로 올려주세요.</b>", type:"warning", onConfirm:function(){return;}}); }
    			else dialog.push({body:"<b>오류가 발생하였습니다.</b>", type:"warning", onConfirm:function(){return;}});
    		}

    	};

    	commonAjaxForFile(file, url, param, callback); */

  	},//doSave

  	successResult : function(result){


  		var obj = JSON.parse(result);

  		if(obj.result == "SUCCESS"){
  			toast.push("성공하였습니다.");
  			g_carId = obj.resultVal;		//g_carId 전역변수 세팅
  			fnObj.doSearch(curPageNo, 'RE', myGrid.getSelectRowIndex()[0]);	//재검색

  		}else{

  			if(obj.resultVal == -1){dialog.push({body:"<b>사진파일 크기는 200kb 이하로 올려주세요.</b>", type:"warning", onConfirm:function(){return;}}); }
			else dialog.push({body:"<b>오류가 발생하였습니다.</b>", type:"warning", onConfirm:function(){return;}});
  		}

  	},

  /* 	imageFile: function(){
  		$('#inFile').trigger('click');
  	}, */

  	changeFile: function(){
  		if(isEmpty($('#inFile').val())){	//지워진거다.
  			$('#carImageFile').html("");
  			$('#carImageFile').hide();
  			$('#fileDelYn').val('Y');
  		}else{
  			var fullName =$('#inFile').val();
  			var fileName = fullName.substring(fullName.lastIndexOf("\\")+1,fullName.length);
  			var ext = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length).toLowerCase();

  			if(!(ext == "png" || ext == "jpg" || ext == "jpeg" || ext == "bmp"||ext == "gif")){
  				alert("이미지 파일만 등록 가능합니다.");
  				return;

  			}else{
  				$('#carImageFile').html(fileName+'<a href="javascript:fnObj.delImageFile();" class="btn_delete_employee"><em>삭제</em></a>');
  	  			$('#carImageFile').show();
  	  			$('#fileDelYn').val('N');
  			}
  		}
  	},

  	delImageFile: function(){
  		$('#inFile').val('');
  		fnObj.changeFile();
  	},
  	doPrint : function(){
  		window.print();
  	}

  	//삭제시도
  	,tryDel: function(){
  		var trList = $('#SGridTarget').find('tr[class=tr_selected]');
  		if(trList.length == 0){
  			dialog.push({body:"<b>확인!</b> 삭제할 건을 선택해주세요!", type:"", onConfirm:function(){}});
    		return;
  		}

  		var list = myGrid.getList();
  		for(var i=0; i<list.length; i++){
  			if(list[i].carId == g_carId){
  				dialog.push({
        		    body:'<b>경고 : </b>&nbsp;&nbsp;삭제하시겠습니까?<br><br>[자산명:<b> ' + list[i].assetName + ' </b>]', top:0, type:'Caution', buttons:[
                        {buttonValue:'확인', buttonClass:'Red', onClick:fnObj.doDel, data:{ carId :  list[i].carId, assetId : list[i].assetId }},
                        {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}	//, data:'data2'},
                        //{buttonValue:'button3', buttonClass:'Green', onClick:fnObj.btnClick, data:'data3'}
        		    ]});
  				break;
  			}
  		}
  	},
  	//삭제
  	doDel: function(param){

  		var url = contextRoot + "/eam/doDelCar.do";
    	var param = {

    			assetId		 : param.assetId,
    			carId		 : param.carId
    	};

		//console.log(param);
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		if(obj.result == "SUCCESS"){

    			toast.push("성공하였습니다.");

    			fnObj.doSearch();

    		}else{
    			dialog.push({body:"<b>오류가 발생하였습니다.</b>", type:"warning", onConfirm:function(){return;}});
    		}

    	};

    	commonAjax("POST", url, param, callback);

  	},

  	//재정렬
  	doSort : function(index){

  		// 로딩 이미지 보여주기 처리
		$('.wrap-loading').removeClass('display-none');
		//--------------------

  		mySorting.setSort(index);
  		fnObj.doSearch();
  		//소팅
        //sortByKey(myGrid.getList(), mySorting.nowSortCol, mySorting.nowDirection);
        myGrid.refresh();


		mySorting.applySortIcon();			//소팅화면적용

		// 로딩 이미지 감추기 처리
        $('.wrap-loading').addClass('display-none');
  	},//doSort


  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색
	//fnObj.setTooltip();

	$('#myForm').ajaxForm({
		beforeSend: function() {
		},
		success: function(res) {
			fnObj.successResult(res);
		},
		error : function(){

		}
	});

});
</script>