<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<body>
<section id="detail_contents">
	<div class="carSearchBox">
		<label for="orgSelBox"><span class="carSearchtitle">회사선택</span></label>
		<select class="select_b mgr20" id="orgSelBox" name = "orgSelBox" title="회사선택" onchange="fnObj.doSearch();">
			<c:forEach items="${accessOrgIdList }" var = "data">
				<option value="${data.orgId }"
					<c:if test = "${data.orgId eq baseUserLoginInfo.applyOrgId}">selected="selected"</c:if>
				>${data.cpnNm }</option>
			</c:forEach>
		</select>
		<input class="input_b2 w200px mgl10" id="search" name="search" placeholder="회의실명" onkeypress="if(event.keyCode==13) {fnObj.doSearch(); return false;}"/>
		<a href="javascript:fnObj.doSearch();" class="btn_g_black mgl10"><em>검색</em></a>
	</div>

	<div class="board_classic mgt10">
		<div class="leftblock">
			<div class="sys_p_noti mgt10 mgb10"><span class="icon_noti"></span><span class="pointB">[순서변경방법]</span><span> Drag & Drop 을 이용해 정렬 후 <strong>순서변경버튼</strong>을 클릭하면 순서를 변경할 수 있습니다.</span></div>
		</div>

	</div>

	<div class="spending_st_box mgt10">
		<span class="scroll_cover" onclick="javascript:setdayFull('sp_scroll_body');"></span>
		<div class="sp_scroll_header">

			<table class="spending_tb_basic">
				<colgroup>
					<col width="40">
					<col width="150">
					<col width="100">
					<col width="40">
					<col width="120">
					<col width="40">
					<col width="40">
				</colgroup>
				<thead>
					<tr>
						<th style="padding:10px;">번호</th>
						<th><a href="#;" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">회의실 명<em>오름차순</em></a></th>
						<th><a href="#;" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">위치<em>오름차순</em></a></th>
						<th><a href="#;" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">순서<em>오름차순</em></a></th>
						<th>설명</th>
						<th><a href="#;" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">사용여부<em>오름차순</em></a></th>
						<th>등록자</th>
					</tr>
				</thead>

			</table>
		</div>
		<div class="sp_scroll_body">
			<table class="spending_tb_basic" id="SGridTarget">
				<colgroup>
					<col width="40">
					<col width="150">
					<col width="100">
					<col width="40">
					<col width="120">
					<col width="40">
					<col width="40">
				</colgroup>

				<tbody></tbody>
			</table>
		</div>
	</div>
	<div class="btn_baordZone2">
		<a href="javascript:fnObj.openRegMeetingRoomPop(0);" class="btn_blueblack btn_auth">회의실 등록</a>
		<a href="javascript:fnObj.doSortChange();" class="btn_witheline btn_auth">순서변경</a>
	</div>

</section>
</body>



<script type="text/javascript">




function setdayFull(knd){
    	var h = '';
    	if(knd == 'week_allday')
    		h = '99px';
    	else
    		h = '450px';

    	if($('.'+knd).css('max-height') == h)
    		$('.'+knd).css('max-height','none');
    	else
    		$('.'+knd).css('max-height', h);
}



//Global variables :S ---------------

//공통코드

var myModal = new AXModal();		// instance
var myGrid = new SGrid();		// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs
//var myPaging = new SPaging();	// instance		new sjs

var g_dataList = [];

var curPageNo = 1;		//현재페이지번호
var g_pageSize = 15;	//페이지크기

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

    	var configObj = {
        		columnCountForEmpty : 7,
        		targetID : "SGridTarget",		//그리드의 id

        		//그리드 컬럼 정보
        		colGroup : [

                {key:"no" ,  		formatter:function(obj){
										var str = '';
										str=obj.index+1;

										return str ;
				}},
                {key:"meetingRoomNm"},
                {key:"meetingRoomLocation"},
                {key:"sort"},
                {key:"description"},
                {key:"enable"},
                {key:"createdNm"},
                {key:"meetingRoomId"},
                {key:"titleColor"},
                ],


                body : {
                    onclick: function(obj, e){
                    	fnObj.openRegMeetingRoomPop(obj.item.meetingRoomId);
                    }
                }
        };


        	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */

        	var rowHtmlStr = '<tr id="#[7]">';
        	rowHtmlStr +=	 '<td class="b_num">#[0]</td>';
        	rowHtmlStr +=	 '<td class="b_title" style="cursor:pointer;color:#[8];">#[1]</td>';		//td 에 이벤트를 준 케이스
        	rowHtmlStr +=	 '<td class="b_writer">#[2]</td>';
        	rowHtmlStr +=	 '<td class="b_date">#[3]</td>';
        	rowHtmlStr +=	 '<td class="b_count">#[4]</td>';
        	rowHtmlStr +=	 '<td class="b_count">#[5]</td>';
        	rowHtmlStr +=	 '<td class="b_count">#[6]</td>';
            rowHtmlStr +=	 '</tr>';
        	configObj.rowHtmlStr = rowHtmlStr;


        	myGrid.setConfig(configObj);		//그리드 설정정보 세팅

        	//-------------------------- 그리드 설정 :E ----------------------------

        	//-------------------------- 소팅 설정 :S ----------------------------
	    	mySorting.setConfig({
				colList : ['meet.MEETING_ROOM_NM', 'meet.MEETING_ROOM_LOCATION', 'meet.SORT', 'meet.ENABLE'],
				classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
				classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
				classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
			});
	    	//-------------------------- 소팅 설정 :E ----------------------------



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

 	//검색
    doSearch: function(){

    	var url = contextRoot + "/meetingRoom/getMeetingRoomList.do";
    	var param = {
    					search 	: $("#search").val(),
    					orgId 	: $("#orgSelBox").val(),
    					//pageSize: $("#recordCountPerPage").val(),
    	    			//pageNo	: (page == undefined ? 1 :page),
    	    			sortCol		: mySorting.nowSortCol,
		    			sortVal		: mySorting.nowDirection,
    				};


    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var list = obj.resultList;

    		g_dataList = list;


    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list,		//그리드 테이터
							});

    		$('#totalCount').text(list.length);

    		mySorting.applySortIcon();		//소팅화면적용

    	};
    	commonAjax("POST", url, param, callback, false);

    },//end doSearch

    //컬럼 소팅
    doSort: function(idx){
		mySorting.setSort(idx);				//소팅객체를 소팅한다.(상태값들의 변화)
		fnObj.doSearch(1);
    },

  	//순서변경
    doSortChange : function(){

    	//소팅 시작 숫자.
    	var startSortIdx = 1;

		var trList = $("#SGridTarget tbody").find('tr');
    	var cloneList = g_dataList.clone();


    	//아이디 리스트 순서대로
    	for(var i=0;i<trList.length;i++){
    		var id = $(trList[i]).attr('id');

    		for(var k=0;k<cloneList.length;k++){

    			if(id == cloneList[k].meetingRoomId) cloneList[k].sort = startSortIdx+i;

        	}
    	}

    	var url = contextRoot + "/meetingRoom/doSortChange.do";
    	var param = {
    					sortList : JSON.stringify(cloneList)
    				};


    	var callback = function(result){


    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;

    		alert("변경되었습니다.");
    		fnObj.doSearch();
    	};

    	commonAjax("POST", url, param, callback, false);
    },

    //회의실 등록 팝업
    openRegMeetingRoomPop : function(meetingRoomId){

    	var param ={
    				meetingRoomId	:	meetingRoomId,
    				orgId			:	$("#orgSelBox").val()
		}

		var url =contextRoot+"/meetRoom/openRegMeetingRoomPop/pop.do";
		myModal.open({
			url: url,
			pars: param,
			titleBarText: '회의실등록',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
			method:"POST",
			top: 200,
		   	width: 550,
		   	displayLoading : false,
			closeByEscKey: true				//esc 키로 닫기
		});


		$('#myModalCT').draggable();
    }
};



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();

	$( '#SGridTarget tbody' ).sortable({
		items: "tr",
	    selectedClass: "selected",
	    sort : function(){},


	});

});
</script>