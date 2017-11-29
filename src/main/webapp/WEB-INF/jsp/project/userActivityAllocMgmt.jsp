<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->
<style type="text/css">
tbody tr:hover { background:#f5f7f8; /*f7f8f9*/ }
tbody tr.tr_selected { background:#edf1f2; /*f7f8f9*/ }

.tb_regi_acti thead th:first-child {
    font-weight: bold;
    color: #3b4354;
    line-height: 16px;
    padding: 9px 10px 10px;
    text-align: center;
    letter-spacing: -0.5px;
    border-right: #cacbce solid 1px;
}

.board_classic .rightblock .search_type_yn {
    float: left;
    width: 60px;
    height: 23px;
    line-height: 17px;
    box-sizing: border-box;
    vertical-align: middle;
    border: #c2c2c2 solid 1px;
    color: #5a5a5a;
    float: left;
    padding: 3px 5px;
    margin-right:100px;
}
</style>
<!-- -------- each page css :E -------- -->



    <section id="detail_contents">
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
            <a href="#" onclick="fnObj.doSearch(1);" class="btn_g_black mgl10 mgr20"><em>검색</em></a>
        </div>

        <!-- 게시판 정렬목록 -->
        <div class="board_classic">
            <div class="leftblock">
                <span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
                <select id="sel_page_size" onChange="fnObj.setPageSize(true);" class="sh_count_type" title="정렬방법 선택">
                    <option value="15">15개씩 보기</option>
                    <option value="30">30개씩 보기</option>
                    <option value="50">50개씩 보기</option>
                </select>
            </div>
            <div class="rightblock">
            </div>
        </div

        <!-- 프로젝트 목록 -->
        <!-- 프로젝트 목록 -->
        <table id="SGridTarget" class="tb_list_basic" summary="프로젝트관리">
            <caption>프로젝트목록</caption>
            <colgroup>
                <col width="5%" />
                <col width="*" />
                <col width="8%" />
                <col width="17%" />
                <col width="16%" />
                <col width="7%" />
                <col width="6%" />
                <col width="6%" />
                <col width="5%" />
                <col width="6%" />
                <col width="6%" />
                <col width="5%" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col"><a href="#;" onclick="fnObj.doSort(4);" id="sort_column_prefix4" class="sort_normal">구분<em>오름차순</em></a></th>
                    <th scope="col">${baseUserLoginInfo.projectTitle}명</th>
                    <th scope="col">유형</th>
                    <th scope="col">설명</th>
                    <th scope="col">
                        <a href="#;" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">&nbsp;<em>오름차순</em></a>
                        <a href="#;" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">기간<em>오름차순</em></a>
                    </th>
                    <th scope="col">상태값</th>
                    <th scope="col"><a href="#;" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">확정여부<em>오름차순</em></a></th>
                    <th scope="col"><a href="#;" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">예산<em>내림차순</em></a></th>
                    <th scope="col">지출</th>
                    <th scope="col"><a href="#;" onclick="fnObj.doSort(5);" id="sort_column_prefix5" class="sort_normal">사용여부<em>오름차순</em></a></th>
                    <th scope="col">등록일</th>
                    <th scope="col">등록자</th>
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



        <!-- -------------------------------------------- 하단 프로젝트 정보 :S --------------------------------------------------- -->
        <br/>
        <!-- Project Management -->
       <h3 class="h3_table_title">${baseUserLoginInfo.projectTitle} Information</h3>
       <a href="" class="popup_close"></a>
       <table class="tb_regi_temp" summary="Project Management, 프로젝트명 설명, 기간, 타입, 예산, 타임시트, 지출표기, 사용여부, 참여직원">
           <caption>
               Project Management
           </caption>
           <colgroup>
               <col width="12%" />
               <col width="*" />
               <col width="12%" />
               <col width="28%" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row">${baseUserLoginInfo.projectTitle}명</th>
                   <td colspan="3">
                        <strong><span id="v_projectName"></span></strong>
                        <span style="float: right;">
                            <span id="createArea"></span>
                            <span id="updateArea"></span>
                        </span>
                   </td>
               </tr>
               <tr>
                   <th scope="row">${baseUserLoginInfo.projectTitle}코드</th>
                   <td>
                        <strong><span id="v_projectCode"></span></strong>
                   </td>
                   <th scope="row">공개여부</th>
                   <td><span id="v_openFlag"></span></td>
               </tr>
               <tr>
                   <th scope="row">설명</th>
                   <td><span id="v_projectDesc"></span></td>
                   <th scope="row">유형</th>
                   <td><span id="v_projectType"></span></td>
               </tr>
               <tr>
                   <th scope="row">기간</th>
                   <td>
                    <span id="v_period" style="font-weight: bold;"></span>
                    <span id="v_chgPeriod"></span>
                    <strong id="v_originEndDate" class="mgl20 spe_color_st6 txt_letter0"></strong>
                   </td>
                   <th scope="row">마감일</th>
                   <td>
                    <span id="v_closeDate"></span>
                    <strong id="v_originCloseDate" class="mgl20 spe_color_st6 txt_letter0"></strong>
                   </td>

                   <!-- 일단 사용 정해지면 풀자 -->
                   <th scope="row" style="display:none;">타입</th>
                   <td style="display:none;"><span id="v_projectType"></span></span>
                   </td>
               </tr>
               <tr>
                   <th scope="row">예산</th>
                   <td><span id="v_budget"></span><span id="v_budgetAmt" class="spe_color_st3"></span></td>
                   <th scope="row">사용여부</th>
                   <td><span id="v_enable"></span></td>
                  <!--  <th scope="row">타임시트</th> -->
                   <td style="display:none;">
                    <span id="v_timesheet"></span>
                    <span id="v_overTs"></span>
                   </td>
               </tr>
               <tr>
                   <th scope="row">지출</th>
                   <td>
                    <span id="v_expense"></span>
                    <span id="v_overEx"></span>
                    <span id="v_overExpense"></span>
                    <span id="cardExpenseSumArea" class="current_expense mgl20"></span>
                   </td>
                   <th scope="row">확정여부</th>
                   <td><span id="v_confirm"></span></td>
               </tr>
               <tr>
                   <th scope="row">직원배정</th>
                   <td>
                        <span id="employeeRadioTag" class="radio_list" style="display:none;" ></span>
                        <strong id="employeeStatusArea" style="display:none;" class="mgr10"> 전 직원 </strong> <!-- 직원배정 여부 불가일때 표시  -->
                        <span id="v_employee_list"></span>
                   </td>
                   <th scope="row">상태</th>
                   <td><span id="v_status"></span></td>

               </tr>
           </tbody>
       </table>

       <!--/ Template Management /-->

       <!-- Activity Management -->
       <h3 class="h3_table_title2">${baseUserLoginInfo.activityTitle}</h3>
       <table id="SGridTarget2" class="tb_regi_acti" summary="Activity Management 레벨, Activity, 기간, 예산, 지출, 타임시트, 사용여부, 직원배정, 추가/삭제">
           <caption>
               Activity Management
           </caption>
           <colgroup>
               <col width="5%" />     <!--레벨-->
               <col width="*" />    <!--Activity명-->
               <col width="214" />    <!--설명-->
               <col width="15%" />    <!--기간-->
               <col width="13%" />    <!--예산-->
               <col width="20%" />    <!--지출-->
           <%--     <col width="80" />     <!--타임시트--> --%>
               <col width="5%" />     <!--사용여부-->
           </colgroup>
           <thead>
               <tr>
                   <th scope="col">레벨</th>
                   <th scope="col">${baseUserLoginInfo.activityTitle}명</th>
                   <th scope="col">설명</th>
                   <th scope="col">기간</th>
                   <th scope="col">예산</th>
                   <th scope="col">지출</th>
                <!--    <th scope="col" style="display:none;">타임시트</th> -->
                   <th scope="col">사용여부</th>
               </tr>
           </thead>
           <tfoot>
                <tr>
                    <th colspan="3">합계</th>
                    <td class="txt_budget"><strong id="budgetSumArea">0</strong> <span>원</span></td>
                    <td class="txt_expense" style="padding:0px;text-align:center;"><span>-</span> <strong id="expenseSumArea">0</strong> <span>원</span></td>
                    <td class="txt_total" colspan="2"><strong id="chargeSumArea">0</strong> <span>원</span></td>
                </tr>
           </tfoot>
           <tbody>
				<%-- //// 내용  --%>
           </tbody>
       </table>

       <!-- 게시판 버튼 -->
       <div class="btn_baordZone2">
           <a href="#" id="btnSave" onclick="fnObj.doSave();return false;" class="btn_blueblack btn_auth">저장</a>
       </div>
       <!--/ 게시판 버튼 /-->
       <!-- -------------------------------------------- 하단 프로젝트 정보 :E --------------------------------------------------- -->

    </section>




<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var myModal = new AXModal();	// instance


var myGrid = new SGrid();		// instance		new sjs
var myGrid2 = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs


var curPageNo = 1;				//현재페이지번호
var pageSize = 10;				//페이지크기(상수 설정)

var g_projectId = '';			//프로젝트 id


var g_pjtEmpList = new Array();         //프로젝트 사용자 배정 정보를 객체로 담아두는 배열객체(저장시 서버로 보낸다)
var g_pjtEmpListDel = new Array();      //프로젝트 사용자 배정 정보를 객체로 담아두는 배열객체(저장시 서버로 보낸다) ... 삭제건

var codeProjectStatusNm;    //프로젝트 상태

var updateMngActivityChk = "N"; //업데이트할때 관리액티비티 존재 여부
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		codeYesNo = [{CD:'N', NM:'No'}, {CD:'Y', NM:'Yes'}];
		codeYesNoForNm = {N:'<b>N</b>',Y:'<b><font color=red>Y</font></b>'};		//{N:'No',Y:'Yes'};					//화면에 NM 뿌려주기위해
		codeChgPeriodYesNo = [{CD:'Y', NM:'기간수정가능'}, {CD:'N', NM:'기간수정불가'}];
		codeChgTimeSheetYesNo = [{CD:'Y', NM:'기간상관없음'}, {CD:'N', NM:'기간내'}];
		codeTemplateType = getBaseCommonCode('PROJECT_TYPE', null, 'CD', 'NM', '', '선택','ALL', { orgId : '${baseUserLoginInfo.applyOrgId}' });
		codeOverExpenseYesNo = [{CD:'Y', NM:'예산초과허용'}, {CD:'N', NM:'예산초과불가'}];

		codeProjectStatusNm = {EXPECT:'예정',PROGRESS:'진행',CLOSE_READY:'마감대기',CLOSED:'마감',TEMP_SAVE:'임시저장',PENDING:'보류',STOP:'중단',PENDING_CANCEL:'보류취소',STOP_CANCEL:'중단취소'};

		//comCodeMenuType = getCommonCode('MENU_TYPE', lang, 'CD', 'NM', '', '전체보기', 'ALL');		//메뉴타입 공통코드 (Sync ajax)

		//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
		//this.addComCodeArray(comCodeMenuType);

		//직원할당 여부
		var codeEmployee = [{CD:'A', NM:'전 직원'}, {CD:'Y', NM:'직원배정'}];
        var employeeRadioTag = createRadioTag('rdEmployee', codeEmployee, 'CD', 'NM', 'Y', null, null, 'fnObj.clickRdSelectSync(this,"employee");');    //radio tag creator 함수 호출 (common.js)
        $("#employeeRadioTag").html(employeeRadioTag);

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
            {key:"projectTypeNm",     formatter:function(obj){return obj.value;}}
            ],

            body : {
                onclick: function(obj){
                    fnObj.setProjectInfo(obj.item.projectId);
                }
            }

        };
        /* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
        var rowHtmlStr = '<tr>';
        rowHtmlStr +=    '<td>#[0]</td>';
        rowHtmlStr +=    '<td class="txt_title_type" style="cursor:pointer;">#[2]</td>';        //td 에 이벤트를 준 케이스
        rowHtmlStr +=   '<td>#[14]</td>';
        rowHtmlStr +=    '<td style="display:none;">#[3]</td>';
        rowHtmlStr +=    '<td style="text-align:left;">#[4]</td>';
        rowHtmlStr +=    '<td class="num_date_type">#[5]</td>';
        rowHtmlStr +=    '<td>#[1]</td>';
        rowHtmlStr +=    '<td>#[6]</td>';
        rowHtmlStr +=    '<td class="num_money_type" style="#[12]">#[7]</td>';
        /* rowHtmlStr +=     '<td style="display:none;">#[7]</td>'; */          //타임 시트임.
        rowHtmlStr +=    '<td>#[8]</td>';
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


    	//-------------------------- 그리드2 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj2 = {

    		targetID : "SGridTarget2",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            /* {key:"lvl",             formatter:function(obj){return ('<input type="num" name="lvl" title="레벨" value="' + obj.value + '" readonly />');}}, */
            /* {key:"namelvl",         formatter:function(obj){
                                        var pV = parseInt(1*obj.item.sort/100);     //부모 순번
                                        var sV = parseInt(1*obj.item.sort%100);     //자식 순번
                                        return ('<span>' + obj.item.name + '<em>(' + pV + (sV>0?'-'+sV:'') + ')</em></span>');}}, */
           {key:"",                formatter:function(obj){
                                            var pV = parseInt(1*obj.item.sort/100);     //부모 순번
                                            var sV = parseInt(1*obj.item.sort%100);     //자식 순번
                                            return ( pV + (sV>0?'-'+sV:'') );

                }},
            {key:"namelvl",          formatter:function(obj){
                    var pV = parseInt(1*obj.item.sort/100);     //부모 순번
                    var sV = parseInt(1*obj.item.sort%100);     //자식 순번
                    return ('<span>' + obj.item.name +'</span>');}},
            {key:"description",     formatter:function(obj){return (obj.value);}},

            {key:"period",          formatter:function(obj){
							                var str = (obj.item.startDate).replace(/-/gi,'/') + ' ~ ' + (obj.item.endDate).replace(/-/gi,'/')

							                //확정일때만 액티비티 상태 표기
						                    str += '<span class="spe_color_st3"><em>(';
						                    if(new Date().yyyy_mm_dd()  <= obj.item.endDate   && obj.item.startDate <= new Date().yyyy_mm_dd()){
						                        str += '진행';
						                    }else if(obj.item.endDate < new Date().yyyy_mm_dd()){
						                        str += '마감';
						                    }else if(obj.item.startDate > new Date().yyyy_mm_dd()){
						                        str += '예정';
						                    }
						                    str += ')</em></span>';
							                return str;}},
          {key:"budget",          formatter:function(obj){return (obj.value=='Y'?formatMoney(obj.item.budgetAmt,'INSERT') + ' 원':codeYesNoForNm[obj.value]);}},
          {key:"expense",         formatter:function(obj){
                                        var rStr = codeYesNoForNm[obj.value];

                                        if(obj.value == 'Y' && obj.item.budget == 'Y'){     //지출이 Y 면서  예산이 N 일때만 예산 초과에 대한 txt 보여줌.
                                            rStr += ' (' + getRowObjectWithValue(codeOverExpenseYesNo, 'CD', obj.item.overExpense)['NM'] + ')';
                                        }

                                        //액티비티 사용금액
                                        if(obj.item.cardExpenseSum != 0){
                                            rStr += '<strong class="mgl10">'+Number(obj.item.cardExpenseSum).toLocaleString().split(".")[0]+'  </strong>원 사용';
                                        }
                                        return rStr;}},
            {key:"timesheet",       formatter:function(obj){return (codeYesNoForNm[obj.value]);}},
            {key:"enable",          formatter:function(obj){return (codeYesNoForNm[obj.value]);}},
            {key:"employee",        formatter:function(obj){
                                        var codeKnd = [{CD:'Y', NM:'Y'}, {CD:'A', NM:'A'}];
                                        var colorObj = {};
                                        var disableYn = '';

                                        var rdEmployee =$("input[name = 'rdEmployee']:checked").val();
						            	var openFlag = $("input[name = 'openFlag']:checked").val();

						            	var mngActivityChk = "N";

						            	var employee = obj.item.employee;
					            		if(employee == "Y") mngActivityChk = "Y";
					            		else mngActivityChk = "N";
					            		if(obj.item.mngActivityFlag == "Y"){
					            			updateMngActivityChk ="Y";

					            			$("#btnUserDelete_${baseUserLoginInfo.userId}").remove();
					            		}

                                        //프로젝트가 확정이고, 직원배정이 Y 면 셀렉트 disable 처리. -> 변경 무조건 상위 따라감.
                                        //if(obj.item.confirm == 'Y'){
                                            disableYn = 'selectDisabled';
                                        //}
                                        var rStr = createSelectTag('selEmployee'+(obj.index), codeKnd, 'CD', 'NM', obj.item.employee, 'fnObj.changeEmployee(this,"' + obj.value + '",' + obj.index + ');', colorObj, null, 'yesno_select ','disabled'); //select tag creator 함수 호출 (common.js)

                                        rStr += '<a href="#" id="btnOpenUserPopup" onclick="fnObj.openUserPopup(' + obj.index + ');" class="btn_select_employee2 mgl6" style="' + (mngActivityChk=='N'?'display:none':'') + '"><em>직원선택</em></a>';
                                        rStr += '<span id="selectedList' + (obj.index) + '"  style= "padding-left:10px;' + (mngActivityChk=='N'?'display:none;':'') + '">';

                                        //배정직원 리스트
                                        var empList = obj.item.empList;
                                        for(var i=0; i<empList.length; i++){
                                            rStr += '<span class="tooltip" ';

                                            if(obj.item.confirm == 'Y'){        //확정일때

                                                //-- 오늘 이후 스케쥴 이나 전자결재건이 있는지 --//
                                                if((empList[i].scheChk !='' & empList[i].scheChk !=undefined) || (empList[i].apprChk !=''  & empList[i].apprChk !=undefined)){

                                                    rStr +=  ' onclick="fnObj.nameDetailDisplay('+obj.index+','+i+');"> <font color="#517dc6">' +empList[i].userNm +'</font>';

                                                    //------ 툴팁 세팅  : S

                                                    rStr +=' <div id="helpProMgmt" name="nameDetail'+obj.index+'_'+i+'" class="tooltip_box" style="display:none; width:200px;left:-110px;margin-left:0px;"> ';
                                                    rStr +=' <span class="intext"> ';
                                                    if(empList[i].scheChk !='' ){
                                                        rStr +=' <ul class="list_st_dot3">';
                                                        rStr +=' <li> 일정: '+empList[i].scheChk+'</li>';
                                                        rStr +=' </ul>';
                                                    }
                                                    if(empList[i].apprChk !='' ){
                                                        rStr +=' <ul class="list_st_dot3">';
                                                        rStr +=' <li> 전자결재: '+empList[i].apprChk+'</li>';
                                                        rStr +=' </ul>';
                                                    }


                                                    rStr +=' </span>';
                                                    rStr +=' <em class="edge_topcenter"></em> ';
                                                    rStr +=' <a href="#;" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a> ';


                                                    rStr +=' </div> </span>';

                                                    //------- 툴팁 세팅  : E


                                                }else{
                                                	if(mngActivityChk=='Y'&&obj.index==0&&empList[i].userId == parseInt("${baseUserLoginInfo.userId}")){
                                                		rStr +='> '+empList[i].userNm+' </span> ';
                                                	}else{
                                                    	rStr +='> '+empList[i].userNm+'<a href="javascript:fnObj.delActivityUser(' + obj.index + ',' + empList[i].userId + ');" class="btn_delete_employee" style="' + (mngActivityChk=='Y'&&obj.index==0&&empList[i].userId == parseInt("${baseUserLoginInfo.userId}")?'display:none':'') + '"><em>삭제</em></a> </span> ';
                                                	}
                                                }
                                            }else{
                                            	if(mngActivityChk=='Y'&&obj.index==0&&empList[i].userId == parseInt("${baseUserLoginInfo.userId}")){
                                            		rStr +='> '+empList[i].userNm+' </span> ';
                                            	}else{
                                                	rStr +='> '+empList[i].userNm+'<a href="javascript:fnObj.delActivityUser(' + obj.index + ',' + empList[i].userId + ');" class="btn_delete_employee" style="' + (mngActivityChk=='Y'&&obj.index==0&&empList[i].userId == parseInt("${baseUserLoginInfo.userId}")?'display:none':'') + '"><em>삭제</em></a> </span> ';
                                            	}
                                            }
                                        }

                                        rStr += '</span>';

                                        return rStr;
                                    }},
            //데이터만
            {key:"level"            }
            ]

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr2 = '<tr>';
    	rowHtmlStr2 +=    '<th scope="row" rowspan="2" class="vt">#[0]</th>';
        rowHtmlStr2 +=    '<td>#[1]</td>';
        rowHtmlStr2 +=    '<td>#[2]</td>';
        rowHtmlStr2 +=    '<td>#[3]</td>';
        rowHtmlStr2 +=    '<td>#[4]</td>';
        rowHtmlStr2 +=    '<td>#[5]</td>';
        rowHtmlStr2 +=    '<td style="display:none;">#[6]</td>';
        rowHtmlStr2 +=    '<td>#[7]</td>';
        rowHtmlStr2 +=    '</tr>';
        rowHtmlStr2 +=    '<tr>';
        rowHtmlStr2 +=    '<td colspan="7" style="text-align:left;">#[8]</td>';
        rowHtmlStr2 +=    '</tr>';

    	configObj2.rowHtmlStr = rowHtmlStr2;


    	myGrid2.setConfig(configObj2);		//그리드 설정정보 세팅
    	//-------------------------- 그리드2 설정 :E ----------------------------


    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	if(page==null) page=1;

    	var url = contextRoot + "/project/getProjectList.do";
    	var param = {
		    			pageSize: pageSize,
		    			pageNo:	page,

		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,

		    			/* projectType    : $('#srch_project_type').val(),                        //프로젝트 타입 */
                        knd         : '',                                                   //검색 종류
                        search      : $('#srch_search').val(),                          //검색 어
                        employee    : $("#employee option:selected").val(),                                 //구분
                        projectType   : $("#projectType option:selected").val(),                                 //유형
                        openFlag   : $("#openFlag option:selected").val(),                                 //공개
                        projectStatus       : $("#projectStatus option:selected").val(),                    //상태
                        nearClose      : ($("#nearClose").is(":checked") == true ? 'Y' : 'N')                    //마감 임박
                        /* confirm      : 'Y'                                    //상태 진행여부 */
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

    	commonAjax("POST", url, param, callback);

    	fnObj.resetProjectInfo("");

    },//end doSearch

  //프로젝트 정보 리셋
    resetProjectInfo: function(pId){

        g_projectId = pId;                      //전역변수에 세팅 (선택하여 직원배정 수정중인 프로젝트 id)

        //----- 내용뿌리기 :S -----
        //프로젝트
        $('#v_projectName').html("");                             //프로젝트명
        $('#v_projectCode').html("");                               //프로젝트코드
        $('#v_projectDesc').html("");                      //프로젝트설명
        $("#v_confirm").html("");                             //확정여부

        $('#v_period').html("");     //시작일 ~ 종료일
        $('#v_closeDate').html("");                         //마감일

        $("#v_originEndDate").html("");
        $('#v_period').html("");                          //기간
        $('#v_closeDate').html("");                                                           //기간
        $('#v_projectType').html("");                 //타입

        $('#v_budgetAmt').html("");  //예산
        $('#v_budget').html("");                //예산

        $('#v_timesheet').html("");          //타임시트
        $('#v_overTs').html("");        //기간상관여부
        $('#v_expense').html("");              //지출
        $('#v_overEx').html("");        //기간상관여부
        $('#v_overExpense').html(""); //예산초과지출허용 여부
        $("#cardExpenseSumArea").html("");

        $('#v_enable').html("");                //사용여부
        $('#v_employee_list').html("");

        $("#employeeRadioTag").hide();      //확정이며 직원배정 N 일때 라디오 버튼 숨김
        $("#employeeStatusArea").hide();    //전직원 글자 표시
        $('#v_employee_list').show();

        $('#createArea').html("");
        $('#updateArea').html("");

        g_pjtEmpList = "";                                                 //프로젝트 직원배정 정보 ...배열객체

        //activity
        var actList = {};
        myGrid2.setGridData({
            list: actList,  //그리드 테이터
            page: null      //페이징 데이터
        });


        $("#budgetSumArea").html("");
        $("#expenseSumArea").html("");
        $("#chargeSumArea").html("");     //남은 금액

        fnObj.resetLevelAndClass();         //레벨 값 및 스타일 class 재세팅

    },//resetProjectInfo


  	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },


    //컬럼 소팅
    doSort: function(idx){

    	mySorting.setSort(idx);				//소팅객체를 소팅한다.(상태값들의 변화)

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


    //------------------------------------------------- Project Information :S ----------------------------------------------------

  	//프로젝트 정보 불러와 세팅
    setProjectInfo: function(pId){

    	g_projectId = pId;						//전역변수에 세팅 (선택하여 직원배정 수정중인 프로젝트 id)


    	var url = "<c:url value='/project/getProjectInfo.do'/>";
    	var param = {
    					projectId : pId
    				};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var jsonObj = obj.resultObject;		//결과데이터JSON

    		var project = jsonObj.pProject;		//프로젝트
    		var actList = jsonObj.pActivity;	//activity

    		if(obj.result == "SUCCESS"){


    	    	//----- 내용뿌리기 :S -----

    	    	//프로젝트
    	    	$('#v_projectName').html(project.name);								//프로젝트명
    	    	$('#v_projectCode').html(project.projectCode);                               //프로젝트코드
    	    	$('#v_projectDesc').html(project.description);						//프로젝트설명
    	    	$("#v_confirm").html(codeYesNoForNm[project.confirm]);                             //확정여부
    	    	$("#v_status").html(codeProjectStatusNm[project.projectStatus]);                              //상태

    	    	var openFlagStr = project.openFlag=="Y"?"공개":"비공개";
                $("#v_openFlag").html(openFlagStr);                             //공개여부

    	    	if(project.period == 'Y'){
                    $('#v_period').html((project.startDate).replace(/-/gi,'/') + ' ~ ' + (project.endDate).replace(/-/gi,'/'));     //시작일 ~ 종료일
                    $('#v_closeDate').html((project.closeDate).replace(/-/gi,'/'));                         //마감일

                    //기간이 Y 이고 확정 상태이면
                    if(project.confirm == 'Y'){

                    	if(project.originEndDate != null) $("#v_originEndDate").html(' (최초 종료일:'+(project.originEndDate).replace(/-/gi,'/')+')');
                    	else($("#v_originEndDate").html(''));

    	    			if(project.originCloseDate != null) $("#v_originCloseDate").html(' (최초 마감일:'+(project.originCloseDate).replace(/-/gi,'/')+')');
    	    			else($("#v_originCloseDate").html(''));
                    }
                }else{
                    $('#v_period').html(codeYesNoForNm[project.period] + ' (기간상관없음)');                          //기간
                    $('#v_closeDate').html('기간상관없음');                                                           //기간
                }
                $('#v_projectType').html(getRowObjectWithValue(codeTemplateType, 'CD', project.projectType)['NM']);                 //타입

                if(project.budget == 'Y'){
                    var korNum = numToKorean(''+project.budgetAmt);
                    $('#v_budgetAmt').html(formatMoney(''+project.budgetAmt, 'INSERT') + '원 ' + (isEmpty(korNum)?'':'<em>(' + korNum + ')</em>'));  //예산
                }else{
                    $('#v_budget').html(codeYesNoForNm[project.budget]);                //예산
                }
                $('#v_timesheet').html(codeYesNoForNm[project.timesheet]);          //타임시트
                if(project.timesheet == 'Y')
                    $('#v_overTs').html('&nbsp;(' + getRowObjectWithValue(codeChgTimeSheetYesNo, 'CD', project.overTs)['NM'] + ')');        //기간상관여부
                $('#v_expense').html(codeYesNoForNm[project.expense]);              //지출
                if(project.expense == 'Y'){
                    $('#v_overEx').html('&nbsp;(' + getRowObjectWithValue(codeChgTimeSheetYesNo, 'CD', project.overEx)['NM'] + ')');        //기간상관여부
                    if(project.budget == 'Y') $('#v_overExpense').html('&nbsp;(' + getRowObjectWithValue(codeOverExpenseYesNo, 'CD', project.overExpense)['NM'] + ')'); //예산초과지출허용 여부

                    if(project.cardExpenseSum !=0 ){
                        $("#cardExpenseSumArea").html('<strong>현재 :</strong> <span> '+ Number(project.cardExpenseSum).toLocaleString().split(".")[0] +'</span> <em>원</em></span>');
                    }

                }
                $('#v_enable').html(codeYesNoForNm[project.enable]);                //사용여부

                //-- 프로젝트 직원배정 세팅
                var empList = (project.empList=='') ? [] : project.empList;
                var eStr = '';
                for(var i=0; i<empList.length; i++){
                    if(i==0) eStr += '(';
                    eStr += '<span class="tooltip" ';

                    //-- 오늘 이후 스케쥴 이나 전자결재건이 있는지 --//
                    if((empList[i].scheChk !='' & empList[i].scheChk !=undefined) || (empList[i].apprChk !=''  & empList[i].apprChk !=undefined)){
                        eStr +=  ' onclick="fnObj.nameDetailDisplay(\'p\','+i+');"> <font color="#517dc6">' +empList[i].userNm +'</font>';


                        //------ 툴팁 세팅  : S

                        eStr +=' <div id="helpProMgmt" name="nameDetailp_'+i+'" class="tooltip_box" style="display:none; width:200px;left:-110px;margin-left:0px;"> ';
                        eStr +=' <span class="intext"> ';
                        if(empList[i].scheChk !='' ){
                            eStr +=' <ul class="list_st_dot3">';
                            eStr +=' <li> 일정: '+empList[i].scheChk+'</li>';
                            eStr +=' </ul>';
                        }
                        if(empList[i].apprChk !='' ){
                            eStr +=' <ul class="list_st_dot3">';
                            eStr +=' <li> 전자결재: '+empList[i].apprChk+'</li>';
                            eStr +=' </ul>';
                        }


                        eStr +=' </span>';
                        eStr +=' <em class="edge_topcenter"></em> ';
                        eStr +=' <a href="#;" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a> ';


                        eStr +=' </div> </span>';

                        //------- 툴팁 세팅  : E


                    }else{
                        eStr +='> '+empList[i].userNm+'<a href="javascript:fnObj.delProjectUser(' + empList[i].userId + ');" class="btn_delete_employee" id="btnUserDelete_'+empList[i].userId+'"><em>삭제</em></a> </span> ';
                    }

                    if(i==empList.length-1) eStr += ')';
                }
                $('#v_employee_list').html(eStr);

                //-----------------

                $('input:radio[name=rdEmployee]').val([project.employee]);          //직원배정

                if(project.employee=='Y'){
                    //$('#btn_select_employee_all').show();
                    $("#employeeRadioTag").show();      //확정이며 직원배정 N 일때 라디오 버튼 숨김
                    $("#employeeStatusArea").hide();    //전직원 글자 표시
                    $('#v_employee_list').show();
                }else{
                    //$('#btn_select_employee_all').hide();
                    $("#employeeRadioTag").hide();      //확정이며 직원배정 N 일때 라디오 버튼 숨김
                    $("#employeeStatusArea").show();    //전직원 글자 표시
                    $('#v_employee_list').hide();
                }

                $('#createArea').html('<strong>등록자: </strong>'+project.createNm+' ('+(project.createDate).replace(/-/gi,'/')+')');
                $('#updateArea').html('| <strong>최종수정자: </strong>'+project.updateNm+' ('+(project.updateDate).replace(/-/gi,'/')+')');

    	    	g_pjtEmpList = empList;													//프로젝트 직원배정 정보 ...배열객체



    	    	//activity
	    		myGrid2.setGridData({
									list: actList,	//그리드 테이터
									page: null		//페이징 데이터
	    						});


    			//----- 내용뿌리기 :E -----

	    		//합계 계산
                var budgetSum = 0;      //예산 합계
                var expenseSum = 0;     //지출 합계

                for(var i=0;i<actList.length;i++){
                    if(actList[i].budget == 'Y' && actList[i].budgetAmt !='' && actList[i].budgetAmt !=null)budgetSum += parseInt(actList[i].budgetAmt);
                    if(actList[i].cardExpenseSum !='' && actList[i].cardExpenseSum !=null)expenseSum += parseInt(actList[i].cardExpenseSum);
                }

                var chargeSum = parseInt(budgetSum)-parseInt(expenseSum);

                $("#budgetSumArea").html(Number(budgetSum).toLocaleString().split(".")[0]);
                $("#expenseSumArea").html(Number(expenseSum).toLocaleString().split(".")[0]);
                $("#chargeSumArea").html(Number(chargeSum).toLocaleString().split(".")[0]);     //남은 금액


	    		fnObj.resetLevelAndClass();			//레벨 값 및 스타일 class 재세팅

	    		//참여자 수정은 등록자만 가능
	    		if(project.createdBy == '${baseUserLoginInfo.userId}'||'${baseUserLoginInfo.orgBasicAuth}' == "SUPER"){
	    		    $("#btnSave").show();
	    		    $('input:radio[name=rdEmployee]').attr("disabled",false);
                    $(".btn_delete_employee").show();
                    if($('input:radio[name=rdEmployee]:checked').val()!="A")
                    	$("#btnOpenUserPopup").show();
	    		}else{
	    			$("#btnSave").hide();
	    			$('input:radio[name=rdEmployee]').attr("disabled",true);
	    			$(".btn_delete_employee").hide();
	    			$(".btn_select_employee2").hide();
	    			$("#btnOpenUserPopup").hide();
	    		}

	    		if('${baseUserLoginInfo.orgBasicAuth}' == "READ"){
	    			$(".btn_auth").hide();
	    		}else if('${baseUserLoginInfo.orgBasicAuth}' == "SUPER"){
	    			$(".btn_auth").show();
	    		}

    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);

    },//setProjectInfo


    //레벨 값 및 스타일 class 재세팅
    resetLevelAndClass: function(){

    	var list = myGrid2.dataList;

    	var level;

    	for(var i=0; i<list.length; i++){

    		level = list[i].level * 1;

    		//class 스타일 세팅
    		if(level == 0){
    			$(myGrid2.gridBodyObject.children('tr')[i*2]).addClass('level_first_v');
    			$(myGrid2.gridBodyObject.children('tr')[i*2+1]).addClass('level_first_v');

    		}else{	//level == 1
    			//첫줄
    			var tr = $(myGrid2.gridBodyObject.children('tr')[i*2]);
    			tr.removeClass('level_second_v');		//init
    			tr.removeClass('level_second_v_end');	//init

    			if(list.length == i+1){	//마지막 activity
        			tr.addClass('level_second_v_end');

        		}else if(list[i + 1].level == 0){	//다음 activity 의 레벨이 0인 케이스
        			tr.addClass('level_second_v_end');

        		}else{
        			tr.addClass('level_second_v');
        		}

    			//둘째줄
    			tr = $(myGrid2.gridBodyObject.children('tr')[i*2+1]);
    			tr.removeClass('level_second_v');		//init
    			tr.removeClass('level_second_v_end');	//init

    			if(list.length == i+1){	//마지막 activity
        			tr.addClass('level_second_v_end');

        		}else if(list[i + 1].level == 0){	//다음 activity 의 레벨이 0인 케이스
        			tr.addClass('level_second_v_end');

        		}else{
        			tr.addClass('level_second_v');
        		}
    		}

    	}//for

    },


    //사원선택 팝업   (idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
    openUserPopup: function(idx, knd){

        g_selUserIndex = idx;                   //그리드의 idx ...  ■■■■ global variable ■■■■

        var list = myGrid2.getList();
        var empList = list[idx].empList;        //해당 row 의 직원 리스트

        var userStr ='';
        var userDisableStr ='';

        var arr =new Array();
        var disabledList =[];

        for(var i=0;i<empList.length;i++){
            arr.push(empList[i].userId);

            if((empList[i].scheChk != '' || empList[i].apprChk != '') &&  list[idx].activityId !=undefined ) disabledList.push(empList[i].userId);  //일정이 있는 참가자는 삭제할수 없다.
            if(idx == 0 &&  myGrid2.dataList[0].mngActivityFlag == "Y" && parseInt(empList[i].userId) == parseInt("${baseUserLoginInfo.userId}")){
   			 disabledList.push(empList[i].userId); // 관리 액티비티에서 작성자를 제거할수없다...수정화면이 작성자만 접근되므로 세션 userId와 비교한다.
   			}
        }

        if(arr.length>0) userStr = arr.join(',');
        if(disabledList.length>0)  userDisableStr = disabledList.join(',');

        var paramList = [];
        var paramObj ={ name : 'userList'   ,value : userStr};
        paramList.push(paramObj);

        paramObj ={ name : 'disabledList'   ,value : userDisableStr};       //선택 불가
        paramList.push(paramObj);

        paramObj ={ name : 'isCheckDisable'   ,value : 'N'};                //상위에 따른 선택불가
        paramList.push(paramObj);


        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
        paramList.push(paramObj);

       /*  paramObj ={ name : 'parentKey' ,value : knd};
        paramList.push(paramObj); */

        userSelectPopCall(paramList);       //공통 선택 팝업 호출

    },


  	//사원 및 부서 선택 팝업에서 선택한 데이터를 처리
    getResult: function(userList, pKey){

        var list = myGrid2.getList();
        var empList = list[g_selUserIndex].empList;     //해당 row 의 직원 리스트
        var deleteUserList = [];                        //체크 해제된 직원리스트

        var newUserList =[];
        for(var i=0;i<userList.length;i++){
            var empObj = {activityId : '0', userId : userList[i].userId, defaultYn: 'N', enable:'Y', userNm: userList[i].userName, empNo : userList[i].empNo, loginId : userList[i].loginId, scheChk: '', apprChk: ''};
            newUserList.push(empObj);
        }

        for(var i=0;i<empList.length;i++){
            var idx = getRowIndexWithValue(newUserList, 'userId', empList[i].userId);   //현재 그리드 데이터에 있는데..팝업에서 호출받은 리스트에 없으면 유저 삭제로본다.
            if(idx == -1){
                deleteUserList.push(empList[i].userId);                             //체크 해제된 직원리스트

            }
        }

        for(var i=0;i<deleteUserList.length;i++){

            fnObj.delActivityUser(g_selUserIndex,deleteUserList[i]);        //삭제 액션
        }

        fnObj.concatUserSelected(newUserList);

        toast.push('배정OK!');
    },



    //사원선택 팝업에서 선택한 사원을 데이터셋에 반영(개별 activity)
    concatUserSelected: function(userList, vEnd){

        var list = myGrid2.getList();

        var empList = list[g_selUserIndex].empList;         //배정직원 리스트

        if(empList.length == 0){
            empList = [];
        }

        var empListDel = list[g_selUserIndex].empListDel;       //삭제할 직원
        if(!$.isArray(list[g_selUserIndex].empListDel)){
            list[g_selUserIndex].empListDel = [];
            empListDel = list[g_selUserIndex].empListDel;
        }


        //삭제리스트에 동일한 사원이 있으면 제거
        for(var i=0; i<userList.length; i++){
            var idx = getRowIndexWithValue(empListDel, 'userId', userList[i].userId);           //같은 사원을 선택했을 경우에는
            if(idx > -1){
                empListDel.remove(idx);                                                         //기 삭제건이 있으면 제거
            }
        }

        //추가
        for(var i=0; i<userList.length; i++){
            var idx = getRowIndexWithValue(empList, 'userId', userList[i].userId);              //같은 사원을 선택했을 경우에는
            if(idx == -1){
                //var empObj = {activityId : '0', userId : userList[i].userId, defaultYn: 'N', enable:'Y', userNm: userList[i].userName, empNo : userList[i].empNo, loginId : userList[i].loginId, scheChk: '', apprChk: ''};
                empList.push(userList[i]);                                                      //없을경우에 추가
            }
        }

        list[g_selUserIndex].empList = empList;             //list 에 반영
        list[g_selUserIndex].empListDel = empListDel;       //list 에 반영

        fnObj.refreshGrid();        //sync


        ///////////////// 프로젝트 직원배정에도 추가 //////////////////
        if(vEnd != 'END'){  //무한loop방지
            fnObj.concatPjtEmpList(userList, 'END');            //project 직원배정 추가
        }
    },


  	//그리드 refresh
    refreshGrid: function(){

    	myGrid2.refresh();

    	fnObj.resetLevelAndClass();     //레벨 값 및 스타일 class 재세팅

        //fnObj.setDisableSync();         //컬럼 활성화 일괄 변경

        //datepicker 바인딩
        //fnObj.setDatePickerAct();           //기간 입력에 datepicker 사용
    },


  //project 직원배정 추가 (activity 전체에 추가해준다.)
    concatPjtEmpList: function(eList, vEnd){

        //삭제리스트에 동일한 직원데이터가 있으면 제거
        for(var i=0; i<eList.length; i++){
            var idx = getRowIndexWithValue(g_pjtEmpListDel, 'userId', eList[i].userId); //같은 직원을 선택했을 경우에는
            if(idx > -1){
                g_pjtEmpListDel.remove(idx);
            }
        }

        //추가
        for(var i=0; i<eList.length; i++){
            var idx = getRowIndexWithValue(g_pjtEmpList, 'userId', eList[i].userId);        //같은 직원이 있는지 보고
            if(idx == -1){                                                                  //없으면
                g_pjtEmpList.push(eList[i]);                                                //추가
            }
        }

        fnObj.setPjtEmpList();      //sync


        //////////activity list 반영(프로젝트 전체에 해당 직원을 추가해주는 것으로 한다.) /////////
        if(vEnd != 'END'){  //무한loop방지
            var cnt = myGrid2.getDataCount();
            for(var i=0; i<cnt; i++){
                g_selUserIndex = i; //모든 activity 에 대해 반영하기 위해
                fnObj.concatUserSelected(eList, 'END');     //activity 별 직원배정 추가
            }
        }
    },

    //project 직원배정 임시삭제(x버튼)
    delProjectUser: function(userId, vEnd){

        for(var i=0; i<g_pjtEmpList.length; i++){
            if(g_pjtEmpList[i].userId == userId){
                g_pjtEmpList.remove(i);
                g_pjtEmpListDel.push({userId:userId});      //삭제건에 추가
            }
        }

        fnObj.setPjtEmpList();      //sync


        ////////// activity list 반영(프로젝트 전체에 해당 직원을 빼주는 것으로 한다.) /////////
        if(vEnd != 'END'){  //무한loop방지
            var list = myGrid2.getList();
            for(var i=0; i<list.length; i++){
                fnObj.delActivityUser(i, userId, 'END');    //activity 별 직원배정 임시삭제  (*'END' delActivityUser 에서 마무리되도록.. delProjectUser재호출 방지,무한루프방지)
            }
        }

    },


  //프로젝트 직원배정 표시 (g_pjtEmpList 내용으로 화면에 표기)
    setPjtEmpList: function(){
        var pjtEmpListDiv = document.getElementById('v_employee_list');
        pjtEmpListDiv.innerHTML = '';   //초기화

        var eStr = ' ';
        for(var i=0; i<g_pjtEmpList.length; i++){
            if(i==0) eStr += '(';
             eStr += '<span class="tooltip" ';
                //if(g_projectConfirm == 'Y'){        //확정일때

                    //-- 오늘 이후 스케쥴 이나 전자결재건이 있는지 --//
                    if( (g_pjtEmpList[i].scheChk !='' &&g_pjtEmpList[i].scheChk !=undefined) ||(g_pjtEmpList[i].apprChk !='' && g_pjtEmpList[i].apprChk !=undefined)){

                        eStr +=  ' onclick="fnObj.nameDetailDisplay(\'p\','+i+');"> <font color="#517dc6">' +g_pjtEmpList[i].userNm +'</font>';

                        //------ 툴팁 세팅  : S

                        eStr +=' <div id="helpProMgmt" name="nameDetailp_'+i+'" class="tooltip_box" style="display:none; width:200px;left:-110px;margin-left:0px;"> ';
                        eStr +=' <span class="intext"> ';
                        if(g_pjtEmpList[i].scheChk !='' ){
                            eStr +=' <ul class="list_st_dot3">';
                            eStr +=' <li> 일정: '+g_pjtEmpList[i].scheChk+'</li>';
                            eStr +=' </ul>';
                        }
                        if(g_pjtEmpList[i].apprChk !='' ){
                            eStr +=' <ul class="list_st_dot3">';
                            eStr +=' <li> 전자결재: '+g_pjtEmpList[i].apprChk+'/li>';
                            eStr +=' </ul>';
                        }


                        eStr +=' </span>';
                        eStr +=' <em class="edge_topcenter"></em> ';
                        eStr +=' <a href="#;" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a> ';


                        eStr +=' </div> </span>';

                        //------- 툴팁 세팅  : E


                    }else{
                        eStr +='> '+g_pjtEmpList[i].userNm+'<a href="javascript:fnObj.delProjectUser(' + g_pjtEmpList[i].userId + ');" class="btn_delete_employee" id="btnUserDelete_'+g_pjtEmpList[i].userId+'"><em>삭제</em></a> </span> ';
                    }

               /*  }else{
                    eStr +='> '+g_pjtEmpList[i].userNm+'<a href="javascript:fnObj.delProjectUser(' + g_pjtEmpList[i].userId + ');" class="btn_delete_employee"><em>삭제</em></a> </span> ';

                } */
                eStr += '</span>';
                if(i==g_pjtEmpList.length-1) eStr += ')';


        }


        $('#v_employee_list').html(eStr);

        if(updateMngActivityChk == "Y")
			$("#btnUserDelete_${baseUserLoginInfo.userId}").hide();
    },


  //activity 직원배정 임시삭제(x버튼)
    delActivityUser: function(idx, userId, vEnd){

        var list = myGrid2.getList();

        var empList = list[idx].empList;                //배정직원
        if(!$.isArray(list[idx].empListDel)){           //배정삭제직원
            list[idx].empListDel = [];
        }

        for(var i=0; i<empList.length; i++){
            if(empList[i].userId == userId){
                list[idx].empList.remove(i);
                list[idx].empListDel.push({userId:userId});     //삭제건에 추가
            }
        }

        fnObj.refreshGrid();        //sync



        ////////////////프로젝트에도 반영 ///////////////
        //삭제한 것이 다른 activity 어디에도 없는 마지막이었을경우에 project에서도 삭제해주기위해
        if(vEnd != 'END'){  //무한loop방지
            var eCnt = 0;
            for(var i=0; i<list.length; i++){
                if(list[i].employee == 'N') continue;       //직원배정여부가 'N'이면 카운팅대상에서 제외

                var eList = list[i].empList;                //배정직원

                for(var k=0; k<eList.length; k++){
                    if(eList[k].userId == userId){          //다른 activity 에 여전히 존재할때
                        eCnt++;
                    }
                }
            }
            if(eCnt == 0){                                  //다른 activity 에 없을때
                fnObj.delProjectUser(userId, 'END');        //project 직원배정 임시삭제
            }
        }

    },


  	//직원배정 저장 doSave
  	doSave: function(){

  		var list = myGrid2.dataList;


		//--------------- validation :S ---------------
		//var frm = document.myForm;
  		if(g_projectId == ''){
  			dialog.push({body:"<b>확인!</b> 프로젝트를 선택하고 배정정보를 저장해주세요!<br><br>(상단 프로젝트목록에서 선택!)", type:"Caution", onConfirm:function(){}});
    		return;
  		}

  		var list = myGrid2.dataList;
  		for(var i=0; i<list.length; i++){
  		    //직원선택 Y 인데 선택된 직원이 없을때.
            var userSelectYn = $('#selEmployee' + i);

            if(userSelectYn.val() == 'Y' && (list[i].empList).length==0){
                dialog.push({body:"<b>확인!</b> 레벨 "+(i+1)+" 의 사원을 선택해 주세요!", type:""});
                return;
            }
  		}


    	//--------------- validation :E ---------------


    	//저장

    	/* alert(JSON.stringify(g_pjtEmpList));
  		alert(JSON.stringify(g_pjtEmpListDel));
    	return; */


    	var url = contextRoot + "/project/doSaveUserProjectAlloc.do";
    	var param = {

    			projectId : g_projectId,				//전역변수에 있는 project id
    			employee  : $(':radio[name=rdEmployee]:checked').val(),      //직원배정                  //($('#v_employee').html()=='No'?'N':'Y'),
    			aList :	  JSON.stringify(list)			//그리드 데이터 리스트 (JSON 문자열로 전달)

    	};
    	/* alert(JSON.stringify(param));
    	return; */
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		if(obj.result == "SUCCESS"){

    			toast.push("저장OK!");

    			fnObj.setProjectInfo(g_projectId);		//프로젝트 정보 재 로딩

    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);


  	}, //doSave

  //변경 (예산, 지출, 타임시트, 사용여부, 직원배정)
    clickRdSelectSync: function(obj, knd){

        //기간관련 콤보박스 visible 변경
        if(knd == 'employee'){        //직원 배정
            if(obj.value == 'A'){
                $('#v_employee_list').hide();       //직원선택 버튼

                //직원 삭제 액션
                /* var list = g_pjtEmpList.clone();
                for(var i=0; i<list.length; i++){
                    fnObj.delProjectUser(list[i].userId);
                } */

            }else{  //obj.value == 'Y'
                $('#v_employee_list').show();       //직원선택 버튼
            }
        }


        var list = myGrid2.dataList;

        //--------- 그리드 해당 컬럼 데이터 일괄변경 :S --------

        //예산이 아닐때만 데이터 변경
        if(knd != 'budget' && knd != 'overExpense'){
            for(var i=0; i<list.length; i++){
                if(!(knd == 'expense' && obj.value == 'Y') ) list[i][knd] = obj.value;      //프로젝트 지출이 N -> Y 일때 전부 변경되서 예외처리함.

            }
        }

        //--------- 그리드 해당 컬럼 데이터 일괄변경 :E --------


        //그리드 refresh
        fnObj.refreshGrid();            //(4가지 프로세스) ... myGrid.refresh(); fnObj.resetLevelAndClass(); fnObj.setDisableSync(); fnObj.setDatePicker();

    }

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
});
</script>