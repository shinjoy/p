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

<section id="detail_contents">
	<!--검색-->
	<div class="carSearchBox mgb20">
            <span class="carSearchtitle mgl10">구분 :</span>
            <span class="rd_List">
                <label>
                    <select id="employee" class="select_b" onchange="fnObj.doSearch();">
                        <option value="">전체</option>
                        <option value="Y">직원배정</option>
                        <option value="A">전직원</option>
                    </select>
                </label>
            </span>
            <span class="carSearchtitle mgl10">유형 :</span>
            <span class="rd_List">
                <label>
                    <span id = "projectTypeArea"></span>
                </label>
            </span>
            <span class="carSearchtitle mgl10">공개 :</span>
            <span class="rd_List">
                <label>
                    <select id="openFlag" class="select_b" onchange="fnObj.doSearch();">
                        <option value="">전체</option>
                        <option value="Y">공개</option>
                        <option value="N">비공개</option>
                    </select>
                </label>
            </span>
            <span class="carSearchtitle mgl10">상태 :</span>
            <span class="rd_List">
                <label>
                    <span id = "projectStatusArea"></span>
                </label>
            </span>
            <span class="carSearchtitle mgl10">마감 임박 :</span>
            <span class="rd_List">
                <label>
                    <input type="checkbox" id = "nearClose" name = "nearClose" value="Y" onclick="fnObj.doSearch();"/>
                </label>
            </span>
            <input id="srch_search" type="text" placeholder="${baseUserLoginInfo.projectTitle}를 검색하세요" value="" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_b2 w200px  mgl20" title="${baseUserLoginInfo.projectTitle}검색" />
            <a href="#" onclick="fnObj.doSearch(1);" class="btn_g_black mgl10 mgr20"><em>검색</em></a><button type="button" class="btn_s_replay mgl6" onclick="fnObj.initialization();"><em>초기화</em></button>
        </div>
	<!--//검색//-->
	<!--게시판정렬-->
	<div class="board_classic">
		 <div class="leftblock">
			<span class="count_result"><strong>전체</strong><em id="total_count">68</em>건</span>
			 <select id="sel_page_size" onchange="fnObj.setPageSize(true);" class="sh_count_type" title="정렬방법 선택">
				<option value="15">15개씩 보기</option>
				 <option value="30">30개씩 보기</option>
				 <option value="50">50개씩 보기</option>
			 </select>
			 <c:if test="${baseUserLoginInfo.vipAuthYn eq 'Y' }">
		          <ul class="classic_kind">
		              <li><button type="button" class="btn_toggle on" id = "btnEmployee" onclick="fnObj.searchEmployee()">개인</button></li>
		          </ul>
	          </c:if>
		 </div>
		 <div class="rightblock">
		 </div>
	 </div>
	 <!--//게시판정렬//-->
	 <!--프로젝트목록-->
	 <table id="SGridTarget" class="tb_list_basic" summary="프로젝트관리">
		 <caption>프로젝트목록</caption>
		 <colgroup>
			<col width="5%">
			 <col width="*">
			 <col width="7%">
			 <col width="18%">
			 <col width="16%">
			 <col width="5%">
			 <col width="6%">
			 <col width="6%">
			 <col width="6%">
			 <col width="5%">
		 </colgroup>
		<thead>
			 <tr>
				<th scope="col"><a href="#;" onclick="fnObj.doSort(4);" id="sort_column_prefix4" class="sort_normal">구분<em>오름차순</em></a></th>
				<th scope="col">${baseUserLoginInfo.projectTitle}명</th>
				<th scope="col">유형</th>
				<th scope="col">
                    <a href="#;" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">&nbsp;<em>오름차순</em></a>
                    <a href="#;" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">기간<em>오름차순</em></a>
                </th>
				<th scope="col">참여인원</th>
				<th scope="col">상태값</th>
				<th scope="col"><a href="#;" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">확정여부<em>오름차순</em></a></th>
				<th scope="col"><a href="#;" onclick="fnObj.doSort(5);" id="sort_column_prefix5" class="sort_normal">사용여부<em>오름차순</em></a></th>
				<th scope="col">등록일</th>
				<th scope="col">등록자</th>
			 </tr>
		 </thead>
		 <tbody>

		</tbody>
	 </table>
	 <!-- 페이지 목록 -->
        <div class="btnPageZone" id="btnPageZone">
            <button type="button" class="pre_end_btn"><em>맨처음 페이지</em></button>
            <button type="button" class="pre_btn"><em>이전 페이지</em></button>

            <button type="button" class="next_btn"><em>다음 페이지</em></button>
            <button type="button" class="next_end_btn"><em>맨마지막 페이지</em></button>
        </div>
        <!--/ 페이지 목록 /-->
</section>

<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';     //language (profile language... 'KOR' or 'ENG')

//공통코드
//var comCodeRoleCd;                //권한코드
var comCodeMenuType;            //메뉴타입

var myModal = new AXModal();    // instance


var myGrid = new SGrid();       // instance     new sjs
var myPaging = new SPaging();   // instance     new sjs
var mySorting = new SSorting(); // instance     new sjs


var curPageNo = 1;              //현재페이지번호
var pageSize = 10;              //페이지크기(상수 설정)


//div popup 방식을 위한 글쓰기,수정 위한 변수
var mode;                       //"new", "view", "update"
var g_boardSeq;                 //글 id

//var articleObj;                   //글보기 데이터

var fileSeqArray = new Array();     //업로드된 파일 key list
var fileSeqArrayTemp = new Array(); //업로드된 파일 key list (글저장을 누르기전...글에 파일키가 등록되기 전 상태)

var superAllChkYn = "Y";
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

    //################# init function :S #################

    //선로딩코드
    preloadCode: function(){
        //공통코드
        //comCodeMenuType = getCommonCode('MENU_TYPE', lang, 'CD', 'NM', '', '전체보기', 'ALL');        //메뉴타입 공통코드 (Sync ajax)

        //'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
        //this.addComCodeArray(comCodeMenuType);

        var colorObj = {};
        var comCodeProjectType = getBaseCommonCode('PROJECT_TYPE', null, 'CD', 'NM', '', '전체','', { orgId : "${baseUserLoginInfo.applyOrgId}" });
        var projectTypeTag = createSelectTag('projectType', comCodeProjectType, 'CD', 'NM', '', "fnObj.doSearch(1)", colorObj, '', 'select_b');
        $("#projectTypeArea").html(projectTypeTag);

        var comCodeProjectStatus = getBaseCommonCode('PROJECT_STATUS', null, 'CD', 'NM', '', '전체','', { orgId : "${baseUserLoginInfo.applyOrgId}" });
        var projectStatusTag = createSelectTag('projectStatus', comCodeProjectStatus, 'CD', 'NM', '', "fnObj.doSearch(1)", colorObj, '', 'select_b');
        $("#projectStatusArea").html(projectStatusTag);

        //페이지크기 세팅
        fnObj.setPageSize();
    },


    //화면세팅
    pageStart: function(){

        //-------------------------- 그리드 설정 :S ----------------------------
        /* 그리드 설정정보 */
        var configObj = {

            targetID : "SGridTarget",       //그리드의 id

            //그리드 컬럼 정보
            colGroup : [
            {key:"employee",                formatter:function(obj){
                                                        if(obj.value == 'Y') return '직원배정';
                                                        else return '전직원';

            }},
            {key:"projectStatusNm",     formatter:function(obj){return obj.value;}},
            {key:"name",            formatter:function(obj){

                    var rtnStr = obj.value;
                    rtnStr +=  '(' + obj.item.projectCode + ')';
                    if(obj.item.newYn=='Y'){
                        rtnStr += '<span class="icon_new"><em>new</em></span>';
                    }

                    if(obj.item.openFlag=='N'){  //공개여부 : 비공개
                        rtnStr +=  '<span class="board_secret"></span>';
                    }
                    return rtnStr;
                    /* return (obj.value + (obj.item.newYn=='Y'?('<span class="icon_new"><em>new</em></span>'):''));return ( */
            }},
            {key:"projectType",     formatter:function(obj){return obj.value;}},
            {key:"description"      },
            {key:"period",          formatter:function(obj){return ((obj.value=='Y'?((obj.item.startDate).replace(/-/gi,'/') + ' ~ ' + (obj.item.endDate).replace(/-/gi,'/') + ' (마감일:'+(obj.item.closeDate).replace(/-/gi,'/')+')'):'<b>무기한</b> (상시업무)'));}},
            {key:"confirm",         formatter:function(obj){return ((obj.value=='Y'?'<strong class="fontRed">Y</strong>':'<strong>N</strong>'));}},
            {key:"budget",          formatter:function(obj){return ((obj.value=='Y'?(formatMoney(''+obj.item.budgetAmt,'INSERT')):'<strong>N</strong>'));}},
            {key:"expense",         formatter:function(obj){return ((obj.value=='Y'?'<strong class="fontRed">Y</strong>':'<strong>N</strong>'));}},
            /* {key:"timesheet",        formatter:function(obj){return ((obj.value=='Y'?'<strong class="fontRed">Y</strong>':'<strong>N</strong>'));}}, */
            {key:"enable",          formatter:function(obj){return ((obj.value=='Y'?'<strong class="fontRed">Y</strong>':'<strong>N</strong>'));}},
            {key:"createDate",      formatter:function(obj){return (obj.value).replace(/-/gi,'/');}},
            {key:"createNm"         },
            {key:"budgetStyle",     formatter:function(obj){return ((obj.item.budget=='N'?'text-align:center!important;font-family:돋움!important;font-size:1em;':''));}},
            {key:"projectCode",     formatter:function(obj){return obj.value;}},
            {key:"projectTypeNm",     formatter:function(obj){return obj.value;}},
            {key:"projectAttendUserCnt",            formatter:function(obj){
                var projectAttendUserCnt = obj.value;
                var rtnStr = "";
                if(obj.item.employee == 'A'){
                	rtnStr = "전직원";
                }else if(projectAttendUserCnt > 0){
                	rtnStr = obj.item.projectAttendUser + "외 " + projectAttendUserCnt + "인";
                }else{
                	rtnStr = obj.item.projectAttendUser;
                }
                return rtnStr;
                /* return (obj.value + (obj.item.newYn=='Y'?('<span class="icon_new"><em>new</em></span>'):''));return ( */
            }}
            ],

            body : {
                onclick: function(obj){
                    fnObj.viewProject(obj.item.projectId);
                }
            }

        };
        /* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
        var rowHtmlStr = '<tr>';
        rowHtmlStr +=    '<td>#[0]</td>';
        rowHtmlStr +=    '<td class="txt_title_type" style="cursor:pointer;">#[2]</td>';        //td 에 이벤트를 준 케이스
        rowHtmlStr +=   '<td>#[14]</td>';
        rowHtmlStr +=    '<td class="num_date_type">#[5]</td>';
        rowHtmlStr +=    '<td>#[15]</td>';
        rowHtmlStr +=    '<td class="num_date_type">#[1]</td>';
        rowHtmlStr +=    '<td>#[6]</td>';
        rowHtmlStr +=    '<td>#[9]</td>';
        rowHtmlStr +=    '<td class="num_date_type">#[10]</td>';
        rowHtmlStr +=    '<td class="num_date_type">#[11]</td>';
        rowHtmlStr +=    '</tr>';
        configObj.rowHtmlStr = rowHtmlStr;


        myGrid.setConfig(configObj);        //그리드 설정정보 세팅
        //-------------------------- 그리드 설정 :E ----------------------------


        //-------------------------- 페이징 설정 :S ----------------------------

        myPaging.setConfig({                //페이징 설정정보 세팅

            targetID        : "btnPageZone",        //대상 페이징 id ... <div>
            pageSize        : pageSize,             //global variable value

            preEndBtnClass  : 'pre_end_btn',        //맨처음 페이지   버튼 클래스명
            preBtnClass     : 'pre_btn',            //이전 페이지        버튼
            nextBtnClass    : 'next_btn',           //다음 페이지        버튼
            nextEndBtnClass : 'next_end_btn',       //맨마지막 페이지  버튼 클래스명

            curPageNoClass  : 'current',            //현재페이지를 표시해주기위한 style Class name
            clickFnName     : 'fnObj.doSearch'      //페이지 이동 함수명(버튼 클릭)

        });

        //-------------------------- 페이징 설정 :E ----------------------------


        //-------------------------- 소팅 설정 :S ----------------------------
        mySorting.setConfig({
            colList : ['START_DATE', 'END_DATE', 'CONFIRM', 'BUDGET_AMT', 'EMPLOYEE','ENABLE'],
            classNameNormal     : 'sort_normal',                //정렬기본 아이콘 css class
            classNameHighToLow  : 'sort_hightolow',             //오름정렬 아이콘 css class
            classNameLowToHigh  : 'sort_lowtohigh'              //내림정렬 아이콘 css class
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

                //if(window[myModal.winID].isSaved == false){       //저장을 안한상태로 창이 닫힐때, 이미 업로드한 파일은 삭제
                //  window[myModal.winID].fnObj.deleteFile();   //팝업창 내 파일삭제함수 호출.
                //}
            }
        });
        //-------------------------- 모달창 :E -------------------------

    },//end pageStart.
    //################# init function :E #################


    //################# else function :S #################

    //검색
    doSearch: function(page){       //knd : null - 검색버튼, 숫자 - 페이지검색

        if(page==null) page=1;

        var url = contextRoot + "/project/getProjectList.do";
        var param = {
                        pageSize    : pageSize,
                        pageNo      :   page,

                        sortCol     : mySorting.nowSortCol,
                        sortVal     : mySorting.nowDirection,

                        /* projectType  : $('#srch_project_type').val(),                        //프로젝트 타입 */
                        knd         : '',                                                   //검색 종류
                        search      : $('#srch_search').val(),                          //검색 어
                        employee    : $("#employee option:selected").val(),                                 //구분
                        projectType   : $("#projectType option:selected").val(),                                 //유형
                        openFlag   : $("#openFlag option:selected").val(),                                 //공개
                        projectStatus       : $("#projectStatus option:selected").val(),                    //상태
                        nearClose      : ($("#nearClose").is(":checked") == true ? 'Y' : 'N'),                    //마감 임박
                        confirm		: "Y",
                        superAllChkYn : superAllChkYn
                        //$("input[name=fileChk]:checked");

                    };


        var callback = function(result){

            var obj = JSON.parse(result);

            //세션로그아웃 >> 재로그인
            if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
                window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
                return;
            }


            var cnt = obj.resultVal;        //결과수
            var list = obj.resultList;      //결과데이터JSON


            curPageNo = obj.pageNo;         //현재페이지세팅(global variable)


            var pageObj = {                     //페이징 데이터
                    pageNo : curPageNo,
                    pageSize : pageSize,
                    pageCount: obj.pageCount
                }

            //alert(JSON.stringify(pageObj));

            myPaging.setPaging(pageObj);        //페이징 데이터 세팅    *** 1 ***

            myGrid.setGridData({                //그리드 데이터 세팅    *** 2 ***
                                list: list,     //그리드 테이터
                                page: pageObj   //페이징 데이터
                            });

            //alert(JSON.stringify(list));

            //mySorting.clearSort();            //소팅초기화
            mySorting.applySortIcon();      //소팅화면적용


            //전체 건수 세팅
            $('#total_count').html(obj.totalCount);

        };


        //alert(JSON.stringify(param));

        commonAjax("POST", url, param, callback);


    },//end doSearch


    //프로젝트 보기
    viewProject: function(projectId){

        //현재 페이지 파라미터 추출---------
        var url = decodeURIComponent(location.href);


        //-------------------------------
        var url = "<c:url value='/project/projectStatusDetail.do'/>" + "?pId=" + projectId +"&pageNo="+myPaging.pageNo;


        document.location.href = url;

    },//end viewProject



    //엑셀다운
    excelDownload: function(){
         excelDown(myGrid.getExcelFormat('html'), "download");      //common.js
    },


    //툴팁 세팅
    setTooltip: function(){
        var tooltipStr = '';
        /*for(var i=1; i<comCodeRoleCd.length; i++){
            tooltipStr += comCodeRoleCd[i].NM + " : " + comCodeRoleCd[i].DESCRIPTION + "<br>";
        }*/
        tooltipStr += "수정을 하시려면 해당 '아이디', '한글명', '영문명' 중 하나를 클릭하시기 바랍니다";

        AXPopOver.bind({
            id:"myPopOver",
            theme:"AXPopOverTooltip",   // 선택항목
            width:"200",                // 선택항목
            body:tooltipStr             //"설명입니다.<br/>액시스제이는 이렇게 유용 합니다."
        });
        $("#ttipUserRole").bind("mouseover", function(event){
            AXPopOver.open({id:"myPopOver", sendObj:{}}, event); // event 직접 연결 방식
        });
    },

    //메뉴등록 버튼 클릭
    addOpen: function(){
        var url = "<c:url value='/system/addMenu.do'/>";
        var params = {mode:'new'};  //"btype=1&cate=1".queryToObject();     //게시판유형(board_type), 게시판 카테고리 를 넘긴다.

        //params 에 코드리스트 전달------
        var list = myGrid.getList();    //그리드 데이터(array object)
        var codeList  = '';             //코드리스트(','로 연결된 문자열)
        for(var i=0; i<list.length; i++){
            codeList += list[i].menuEng.toUpperCase() + ',';
        }
        params.codeList = codeList;     //파라미터에 추가(key,value)
        //-----------------------------

        myModal.open({
            url: url,
            pars: params,
            titleBarText: '메뉴등록',       //titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
            method:"POST",
            top: 150,
            width: 540,
            closeByEscKey: true             //esc 키로 닫기
        });

        $('#myModalCT').draggable();
    },//end writeOpen


    //글보기
    viewMenu: function(menuInfoObj){
        var url = "<c:url value='/system/addMenu.do'/>";
        var params = {mode:'update',
                      menuInfoObj:JSON.stringify(menuInfoObj)};//("mode=view&boardSeq="+boardSeq+"&btype=1&cate=1").queryToObject();    //게시판유형(board_type), 게시판 카테고리 를 넘긴다.

        myModal.open({
            url: url,
            pars: params,
            titleBarText: '메뉴수정',       //titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
            method:"POST",
            top: 150,
            width: 650,
            closeByEscKey: true         //esc 키로 닫기
        });

        $('#myModalCT').draggable();
    },//end writeOpen


    //배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
        for(var i=0; i<obj.length; i++){
            obj[i].optionValue = obj[i].CD;     //'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
            obj[i].optionText  = obj[i].NM;     //'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
        }
    },


    //체크박스 전체 체크
    allCheck: function(){

        var chkList = document.getElementsByName('mCheck');
        //var list = myGrid.getList();
        //var addIdx = chkList.length/2;
        var toBe = document.getElementsByName('allChk')[0].checked;
        for(var i=0; i<chkList.length; i++){
            chkList[i].checked = toBe;      //체크여부
            //list[i-addIdx].chk = toBe?1:0;    //그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        }

    },

    //컬럼 소팅
    doSort: function(idx){

        mySorting.setSort(idx);             //소팅객체를 소팅한다.(상태값들의 변화)

        fnObj.doSearch(1);
    },

    //페이지 사이즈 세팅
    setPageSize: function(isSearch){

        pageSize = $('#sel_page_size').val();

        //검색도 바로할 경우 ... isSearch ... true
        if(isSearch){
            fnObj.doSearch(1);
        }
    },
  //초기화
  initialization: function(){
        $("#srch_search").val("");
        $("#employee").val("");
        $("#projectType").val("");
        $("#projectStatus").val("");
        $("#openFlag").val("");
        $("input:checkbox[name='nearClose']").prop("checked", false);

        mySorting.clearSort();
        mySorting.nowSortCol ="";
        mySorting.nowDirection ="";

        $("#sel_page_size").val("15");
        pageSize = $('#sel_page_size').val();

        fnObj.doSearch();
    }
    ,

    //개인,전체 검색버튼
    searchEmployee : function(){

    	if($("#btnEmployee").hasClass("on")){
    		superAllChkYn = "N";
    		$("#btnEmployee").removeClass("on");
    		/* $("#employee").val("Y"); */
    		$("#btnEmployee").text("전체");

    		fnObj.doSearch(1);
    	}else{
    		$("#btnEmployee").addClass("on");
    		superAllChkYn = "Y";
    		/* $("#employee").val(""); */
    		$("#btnEmployee").text("개인");
    		fnObj.doSearch(1);
    	}
    }

    //################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
    fnObj.preloadCode();    //공통코드 or 각종선로딩코드
    fnObj.pageStart();      //화면세팅
    fnObj.doSearch();       //검색
    //fnObj.setTooltip();
});
</script>