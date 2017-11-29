<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<section id="detail_contents">

	<div class="carSearchBox">
		<span class="carSearchtitle">기간조회</span>
		<input type="text" value="" class="input_date_type input_b mgl5" id="alarmStart" onclick="$(this).val('');"  readonly="readonly" />
		<a href="#" onclick="$('#alarmStart').datepicker('show');return false;" class="icon_calendar"></a>
		~
		<input type="text" value="" class="input_date_type input_b mgl5" id="alarmEnd"  onclick="$(this).val('');"  readonly="readonly" />
		<a href="#" onclick="fnObj.getEndDate();" class="icon_calendar"></a>

		<input class="input_b2 w200px mgl20" id="alarmText" onkeyup="if(event.keyCode==13) fnObj.doSearch(1);" placeholder="내용검색">
		<a href="javascript:fnObj.doSearch(1);" class="btn_g_black mgl10"><em>검색</em></a>

		<div class="btnRightZone">
			<button type="button" onClick="javascript:fnObj.targetListPop();" class="btn_b_skyblue mgl6"><em class="btn_popuptab">대상자조회</em>
			</button>
		</div>
	</div>
	<div class="board_classic mgt20">
		<div class="leftblock">
			<span class="count_result"><strong>전체</strong><em id="totalCount"></em>건</span>
			<select id="pageSize" name="pageSize" class="sh_count_type" title="정렬방법 선택" onchange="fnObj.doSearch(1);">
				<option value="10">10개씩 보기</option>
                <option value="15">15개씩 보기</option>
                <option value="30">30개씩 보기</option>
                <option value="50">50개씩 보기</option>
			</select>
		</div>
		<div class="rightblock">
			<span id =alarmTargetTypeDiv></span>
			<select id="alarmType" class="select_b mgl10 search_type" onchange="fnObj.doSearch(1);">
				<option value="">알림타입</option>
				<option value="POPUP">팝업</option>
			</select>
		</div>
	</div>

	<!-- 공지알림 목록 -->
	<table id="SGridTarget" class="tb_list_basic" summary="자산관리 마스터 리스트(자산코드, 자산분류, 자산유형, 게정, 자산명, 구입일자, 금액, 수량, 상태)">
		<caption>공지알림 리스트</caption>
		<colgroup>
              	<col width="50" />
				<col width="100" />
				<col width="120" class="allArea" style="display:none;"/>
				<col width="80" />
				<col width="100" />
				<col width="*" />
				<col width="100" />
				<col width="100" />
				<col width="100" />
				<col width="100" />
		</colgroup>
		<thead>
			<tr>
                <th scope="col">번호</th>
       	 		<th scope="col">진행여부</th>
       	 		<th scope="col" class="allArea" style="display:none;">팝업공지 범위</th>
     		 	<th scope="col">분류</th>
     		 	<th scope="col">알림타입</th>
     		 	<th scope="col">내용</th>
     		 	<th scope="col">등록자</th>
     		 	<th scope="col"><a href="javascript:;" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">알림시작일<em>정렬</em></a></th>
     		    <th scope="col"><a href="javascript:;" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">알림종료일<em>정렬</em></a></th>
     		    <th scope="col"><a href="javascript:;" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">등록일<em>정렬</em></a></th>
            </tr>
		</thead>
		<tbody></tbody>
	</table>
	<!-- 페이지 목록 -->
	<div class="btnPageZone" id="btnPageZone">
		<button type="button" class="pre_end_btn"><em>맨처음 페이지</em></button>
		<button type="button" class="pre_btn"><em>이전 페이지</em></button>
        <button type="button" class="next_btn"><em>다음 페이지</em></button>
		<button type="button" class="next_end_btn"><em>맨마지막 페이지</em></button>
	</div>
	<div class="btn_baordZone">
		<a href="javascript:fnObj.regAlarmPop(0)" class="btn_blueblack btn_auth">신규등록</a>
  	</div>
	<!--/ 페이지 목록 /-->

</section>



<script type="text/javascript">
//Global variables :S ---------------

//공통코드

var myGrid = new SGrid(); // instance		new sjs
var myPaging = new SPaging(); // instance		new sjs
var mySorting = new SSorting(); // instance		new sjs
var myModal = new AXModal();	// instance


var curPageNo = 1; //현재페이지번호
var pageSize = 10; //페이지크기(상수 설정)

var g_codeSet ='NOTICE_TARGET_TYPE';
var targetDivisionList = [];
var targetList = []; //알림 정보 받아올 경우 타겟 리스트

var alarmTargetType;

//Global variables :E ---------------

/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//선로딩코드
	preloadCode : function() {
		//공통코드
		//Calendar 적용.
		fnObj.setCalendar("alarmStart",null,"N");
		fnObj.setCalendar("alarmEnd","0","N");
		var colorObj = {};

		alarmTargetType = getBaseCommonCode(g_codeSet, '', 'CD', 'NM', '', '전체', '', { orgId : "${baseUserLoginInfo.applyOrgId}" });

		if(alarmTargetType == null){
			alarmTargetType = [{ 'CD' :'', 'NM':'전체'}];
		}

		var alarmTarget = createSelectTag('alarmTarget', alarmTargetType, 'CD', 'NM', null, 'fnObj.doSearch(1);', colorObj, '', 'select_b search_type');	//select tag creator 함수 호출 (common.js)
		$("#alarmTargetTypeDiv").html(alarmTarget);


		//페이지크기 세팅
		fnObj.setPageSize();
	},

	//화면세팅
	pageStart : function() {

		//-------------------------- 그리드 설정 :S ----------------------------
		/* 그리드 설정정보 */
		var configObj = {
			targetID : "SGridTarget", //테이블아이디

			priorityBind : "2", //eventbind 순서(1: "tr(default)", 2: "td")

			//그리드 컬럼 정보
			colGroup : [
			{key : "no"	   , 		formatter : function(obj) {
										return obj.page.listTotalCount - (obj.index+ parseInt(( obj.page.pageNo - 1) * obj.page.pageSize));
									}},
			{key : "viewYn",		formatter : function(obj) { //현재 공지중인 알림 배경색 설정
										var txt = '';
										if (obj.item.alarmStart <= new Date().yyyy_mm_dd() && new Date().yyyy_mm_dd() <= obj.item.alarmEnd) {
											txt = '<span class="icon st_ing">진행중</span>';
										} else if (new Date().yyyy_mm_dd() < obj.item.alarmStart) {
											txt = '<span class="icon st_predoc">예정</span>';
										} else
											txt = '<span class="icon st_finish">완료</span>';
										return txt;
									}},

			{key : "alarmOrgScope",	formatter : function(obj) {
										var str = '';

										if(obj.item.alarmOrgScope == "ORG_MY"){
											str += '자사';
										}else if(obj.item.alarmOrgScope == "ORG_ALL"){
											str += '전사';
										}else{
											str += '관계사';

											if(obj.item.orgCount>1) str += ' '+(obj.item.orgCount)+'곳';
										}

										return str;
									}},
			{key : "alarmTargetText", formatter : function(obj) {
										var str = '';
										//alarmTargetOrg
										if(obj.item.alarmOrgScope == "ORG_CHOICE"){
											if(obj.item.alarmTargetOrg != ''){
												var splitObj = (obj.item.alarmTargetOrg).split(',');

												var beforeStr = '';
												for(var i=0; i<splitObj.length; i++){
													if(i==0){
														beforeStr = splitObj[i];
														if(beforeStr == 'NOTICE') str ='전체';
														if(beforeStr == 'DEPART') str ='부서선택';
														if(beforeStr == 'SEL_USER') str ='직접선택';
													}

													if(splitObj[i] != beforeStr){
														str += ' 외';
														break;
													}
												}
											}


										}else if(obj.item.alarmOrgScope == "ORG_ALL"){

											str = '전사';

										}else{
											str = obj.item.alarmTargetText;
										}

										return str;

									}},
			{key : "alarmType"},
			{key : "alarmText",		formatter : function(obj) {
										var alarmText = obj.item.alarmText;
										if (alarmText.length > 50) {
											alarmText = alarmText.substring(0, 50)
													+ "...";
										}
										return alarmText;
									}},
			{key : "createdName"},
			{key : "alarmStart" },
			{key : "alarmEnd"	},
			{key : "createDate" },
			],
			body : {
				onclick : function(obj, e) {
					fnObj.regAlarmPop(obj.item.alarmId);
				}
			}

		};

		/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
		var rowHtmlStr = '<tr>';
		rowHtmlStr += '<td>#[0]</td>';
		rowHtmlStr += '<td class="app_state">#[1]</td>';
		rowHtmlStr += '<td class="txt_f11 allArea" style="display:none;">#[2]</td>';
		rowHtmlStr += '<td class="txt_f11">#[3]</td>';
		rowHtmlStr += '<td class="doc_writer">#[4]</td>';
		rowHtmlStr += '<td class="doc_writer">#[5] </td>';
		rowHtmlStr += '<td class="num_date_start">#[6] </td>';
		rowHtmlStr += '<td class="num_date_end">#[7] </td>';
		rowHtmlStr += '<td class="num_date_type">#[8] </td>';
		rowHtmlStr += '<td class="num_date_type">#[9] </td>';
		rowHtmlStr += '</tr>';
		configObj.rowHtmlStr = rowHtmlStr;
		myGrid.setConfig(configObj);

		//-------------------------- 그리드 설정 :E ----------------------------

		//-------------------------- 페이징 설정 :S ----------------------------

		myPaging.setConfig({ //페이징 설정정보 세팅

			targetID : "btnPageZone", //대상 페이징 id ... <div>
			pageSize : pageSize, //global variable value

			preEndBtnClass : 'pre_end_btn', //맨처음 페이지 	버튼 클래스명
			preBtnClass : 'pre_btn', //이전 페이지		버튼
			nextBtnClass : 'next_btn', //다음 페이지		버튼
			nextEndBtnClass : 'next_end_btn', //맨마지막 페이지	버튼 클래스명

			curPageNoClass : 'current', //현재페이지를 표시해주기위한 style Class name
			clickFnName : 'fnObj.doSearch' //페이지 이동 함수명(버튼 클릭)

		});

		//-------------------------- 페이징 설정 :E ----------------------------
		//-------------------------- 소팅 설정 :S ----------------------------
		mySorting.setConfig({
			colList : [ 'alarm_start', 'alarm_end', 'create_date' ], //알림시작일,알림종료일,등록일
			classNameNormal : 'sort_normal', //정렬기본 아이콘 css class
			classNameHighToLow : 'sort_hightolow', //오름정렬 아이콘 css class
			classNameLowToHigh : 'sort_lowtohigh', //내림정렬 아이콘 css class
			defaultSortDirection : 'DESC' //기본 정렬 방향
		});
		//-------------------------- 소팅 설정 :E ----------------------------


	},//end pageStart.

	//검색
	doSearch : function(page) {

		var pageSize = $("#pageSize").val();
		var alarmTarget = $("#alarmTarget").val(); 	//법인카드 전체 임원 등의 타깃
		var alarmType = $("#alarmType").val();		//팝업 or sms
		var alarmText = $("#alarmText").val(); 		//내용검색
		var alarmStart = $("#alarmStart").val(); 	//시작일 검색
		var alarmEnd  = $("#alarmEnd").val(); 		//종료일 검색

		if (page == null)	page = 1; //현재 페이지 초기값 세팅
		if(alarmStart !='' && alarmEnd !=''){
			if(alarmStart > alarmEnd){
				alert("기간 설정이 잘못되었습니다.");
				return;
			}
		}
		var url = contextRoot + "/board/getBoardAlarmList.do";
		var param = {
				pageSize 		: pageSize, 				//페이지 사이즈
				pageNo 			: page, 					//페이지번호
				applyOrgId 		: '${baseUserLoginInfo.applyOrgId}' ,
				alarmTarget 	: alarmTarget,
				alarmType 		: alarmType,
				alarmText 		: alarmText,
				alarmStart 		: alarmStart,
				alarmEnd  		: alarmEnd,
				codeSet			: g_codeSet,
				sortCol 		: mySorting.nowSortCol, 	//소팅 컬럼명
				sortVal 		: mySorting.nowDirection,	//소팅 타입(DESC,ASC)
				scopeAll		: ('${pageType}' == 'ALL' ? 'Y' : 'N')
		};

		var callback = function(result) {

			var obj = JSON.parse(result);
			var cnt = obj.resultObject.totalCount; //결과수
			var list = obj.resultObject.list; //결과데이터JSON

			curPageNo = obj.resultObject.pageNo; //현재페이지세팅(global variable)

			var pageObj = { //페이징 데이터
				pageNo : curPageNo,
				pageSize : pageSize,
				pageCount : obj.resultObject.pageCount,
				listTotalCount : cnt
			};

			myPaging.setPaging(pageObj); //페이징 데이터 세팅	*** 1 ***

			myGrid.setGridData({ //그리드 데이터 세팅	*** 2 ***
				list : list, //그리드 테이터
				page : pageObj
			//페이징 데이터
			});

			mySorting.applySortIcon(); //소팅화면적용
			$("#totalCount").html(cnt);

			if('${pageType}' == 'ALL') $(".allArea").show();
		};

		commonAjax("POST", url, param, callback);

	},//end doSearch

	//등록 팝업 열기
    regAlarmPop: function(alarmId){
    	var url = "${pageContext.request.contextPath}/alarm/regAlarm/pop.do?alarmId="+alarmId+"&pageType=${pageType}";
    	var option = "left=" + (screen.width > 1400?"700":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=820, height=660, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	window.open(url, "_blank", option);
    },//end regAlarmPop

  	//대상자조회  열기
    targetListPop: function(){
    	var url = "${pageContext.request.contextPath}/alarm/alarmTargetList/pop.do";
    	var option = "left=" + (screen.width > 1400?"700":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=968, height=720, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	window.open(url, "_blank", option);
    },//end regAlarmPop

	//컬럼 소팅
	doSort : function(idx) {
		//--------------------
    	mySorting.setSort(idx);				//소팅객체를 소팅한다.(상태값들의 변화)
    	fnObj.doSearch(1);
      	//--------------------
	},

	//페이지 사이즈 세팅
	setPageSize : function(isSearch) {

		pageSize = $('#pageSize').val();

		//검색도 바로할 경우 ... isSearch ... true
		if (isSearch) {
			fnObj.doSearch(1);
		}
	},

	setCalendar : function(target, setToday){


		$("#"+target).datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
	        prevText: '이전달',
	        nextText: '다음달',
			yearRange: 'c-1:c+2',
		});

		var newDate = new Date(Date.now() + addDate * 24*60*60*1000);
		if(setToday == 'Y'){
			$("#"+target).datepicker('setDate', newDate);
		}
	},


	getEndDate: function(){
		//alert($('#alarmStart').val());
		fnObj.setCalendar("alarmEnd", $('#alarmStart').val(), "N");

		$('#alarmEnd').datepicker('show');
	}


};//end fnObj.

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function() {
	fnObj.preloadCode(); //선코딩
	fnObj.pageStart(); //화면세팅
	fnObj.doSearch();


});


</script>
