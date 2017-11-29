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

<script type="text/javascript">
//도움말팝업토글
function showlayer(id)
{
    $("#"+id).toggle();
}
</script>
<style>
.selectDisabled{
     pointer-events: none;
     background:#e6e6e6!important;
}
</style>



<section id="detail_contents">
    <form name="myForm">
    <input type="hidden" id="inStartDate" />
    <input type="hidden" id="inEndDate" />
        <h3 class="h3_table_title">
            <span id="iconArea" >PASS 기본업무 관리</span>
       </h3>
        <table id="templateProject" class="tb_regi_temp" summary="Project Management, 프로젝트명, 설명, 기간, 타입, 예산, 타임시트, 지출표기, 사용여부, 참여직원">
           <caption>
               PASS 기본업무 관리
           </caption>
           <colgroup>
               <col width="12%" />
               <col width="*" />
               <col width="12%" />
               <col width="28%" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row"><label for="inProjectName">${baseUserLoginInfo.projectTitle}명</label></th>
                   <td><input id="inProjectName" name="inProjectName" class="w100" maxlength="30"  placeholder="${baseUserLoginInfo.projectTitle} 명을 입력해주세요"></td>
                   <td colspan="2"></td>
               </tr>
               <tr>
                   <th scope="row"><label for="inProjectDesc">설명</label></th>
                   <td><input id="inProjectDesc" name="inProjectDesc" class="w100" maxlength="80"  placeholder="${baseUserLoginInfo.projectTitle} 설명을 입력해 주세요" /></td>
                   <td colspan="2"></td>
               </tr>
               <tr>
                   <th scope="row">기간</th>
                   <td>
                       No (기간상관없음)
                   </td>
                   <th scope="row">마감일</th>
                   <td>기간상관없음</td>
               </tr>
               <tr>
                   <th scope="row"><label for="budgetAmt">예산</label></th>
                   <td colspan="3">No</td>
               </tr>
               <tr>
                   <th scope="row">지출</th>
                   <td>No</td>
                   <th scope="row">사용여부</th>
                   <td>Yes</span>
               </tr>
               <tr>
                   <th scope="row">직원배정</th>
                   <td colspan="3">전 직원</td>
               </tr>
           </tbody>
       </table>

       <!--/ Template Management /-->

       <!-- Activity Management -->
       <h3 class="h3_table_title2">${baseUserLoginInfo.activityTitle}</h3>
       <table id="SGridTarget" class="tb_regi_acti" summary="Activity Management 레벨, Activity, 기간, 예산, 지출, 타임시트, 사용여부, 직원배정, 추가/삭제">
           <caption>
               Activity Management
           </caption>
           <colgroup>
               <col width="5%" />     <!--레벨-->
               <col width="*" />    <!--Activity명-->
               <col width="20%" />    <!--설명-->
               <col width="20%" />    <!--기간-->
               <col width="10%" />    <!--예산-->
               <col width="10%" />    <!--지출-->
           <%--     <col width="80" />     <!--타임시트--> --%>
               <col width="5%" />     <!--사용여부-->
               <col width="8%" />     <!--추가/삭제-->
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
                   <th scope="col">추가/삭제</th>
               </tr>
           </thead>
           <tbody>
                <%-- //// 내용  --%>
           </tbody>

       </table>
       <!--/ Activity Management /-->

       <div id="updatableMsg" style="display:none;"></div>

       <!-- 게시판 버튼 -->
       <div class="btn_baordZone2">
           <a href="#" id="saveBtn" onclick="fnObj.doSave();return false;" class="btn_blueblack btn_auth">저장</a>
       </div>
       <!--/ 게시판 버튼 /-->

    </form>

</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';     //language (profile language... 'KOR' or 'ENG')

var mode = "<c:out value='${projectId==null?"new":"update"}'/>";    //"new", "update"   //템플릿 아이디가 넘어오는여부에 따라 모드 설정

var g_projectId = "${projectId}";       //프로젝트 id
var g_orgId = "${baseUserLoginInfo.applyOrgId}";

var g_chgPeriod = 'N';                  //기간수정가능 여부(수정 시 기간저장을 할지 판단)

var g_pjtEmpList = new Array();         //프로젝트 사용자 배정 정보를 객체로 담아두는 배열객체(저장시 서버로 보낸다)
var g_pjtEmpListDel = new Array();      //프로젝트 사용자 배정 정보를 객체로 담아두는 배열객체(저장시 서버로 보낸다) ... 삭제건

var g_actListLength = 0;  // Activity List 갯수


var myModal = new AXModal();    // instance


var myGrid = new SGrid();       // instance     new sjs

var g_selUserIndex = -1;            //직원배정을 위해 직원선택 팝업시킨 row 의 index.
var g_projectCloseDate = '';
var g_beforeEndDate = new Date().yyyy_mm_dd();
var g_beforecloseDate = new Date().yyyy_mm_dd();

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

    //################# init function :S #################

    //선로딩코드
    preloadCode: function(){

        //달력 세팅
        var nDate = new Date();

        fnObj.setDateShow('inStartDate',nDate);
        fnObj.setDateShow('inEndDate','9999-12-31');
    },


    //화면세팅
    pageStart: function(){

        //-------------------------- 그리드 설정 :S ----------------------------
        /* 그리드 설정정보 */
        var configObj = {
            targetID : "SGridTarget",       //그리드의 id

            //그리드 컬럼 정보
            colGroup : [
            {key:"lvl",             formatter:function(obj){return ('<input type="num" name="lvl" title="레벨" value="' + obj.value + '" readonly />');}},
            {key:"name",            formatter:function(obj){return ('<input type="text" name="aName" class="active_input" value="' + obj.value + '" onchange="fnObj.syncActivityName(this, ' + obj.index + ');" placeholder="${baseUserLoginInfo.activityTitle}입력" title="${baseUserLoginInfo.activityTitle}입력" />');}},
            {key:"description",     formatter:function(obj){return ('<input type="text" name="aDesc" class="active_input" value="' + obj.value + '" onchange="fnObj.syncActivityDesc(this, ' + obj.index + ');" placeholder="${baseUserLoginInfo.activityTitle}설명" title="${baseUserLoginInfo.activityTitle}설명" />');}},
            {key:"period",          formatter:function(obj){

                                        var disableYn = '';
                                        var displayYn = '';

                                        disableYn = ' disabled';                 //수정불가
                                        displayYn = ' style="display:none;"';       //달력가리기

                                        var rStr = '<span>';
                                        rStr+= obj.item.startDate;
                                        rStr+= '<input type="hidden" '+disableYn+' id="inStartDate' + obj.index + '" value="' + obj.item.startDate + '"  />';
                                        rStr+= '</span>';
                                        rStr+= '~ <span>';
                                        rStr+= obj.item.endDate;
                                        rStr+= '<input type="hidden" '+disableYn+' id="inEndDate' + obj.index + '" value="' + obj.item.endDate + '"/>';
                                        rStr+= '</span>';

                                        return rStr;

                                    }},

            {key:"budget",          formatter:function(obj){
                                        var rStr = 'No';
                                        return rStr;
                                    }},
            {key:"expense",         formatter:function(obj){
                                        var rStr = 'No';
                                        return rStr;
                                    }},
            {key:"enable",          formatter:function(obj){
                                        var codeKnd = [{CD:'Y', NM:'Y'}, {CD:'N', NM:'N'}];
                                        var colorObj = {};
                                        var disableYn = '';
                                        if(obj.item.appvDocClass != "") disableYn = 'disabled';
                                        return createSelectTag('selEnable'+(obj.index), codeKnd, 'CD', 'NM', obj.item.enable, 'fnObj.changeEnable(this,"' + obj.value + '",' + obj.index + ');', colorObj, null, 'yesno_select', disableYn);            //select tag creator 함수 호출 (common.js)
                                    }},
            {key:"btn",             formatter:function(obj){
                                        var add ='';
                                        if((g_actListLength-1) <= obj.index){
                                            add = '<a href="#" onclick="fnObj.addActivity(null, ' + obj.item.level + ', ' + obj.index + ');return false;" class="btn_ac_add"><em>추가</em></a>';
                                        }
                                        var sub = '<a href="#" onclick="fnObj.delActivity(' + obj.index + ', ' + obj.item.level + ');return false;" class="btn_ac_delete"><em>삭제</em></a>';
                                        var rStr = (obj.item.activityId==null?add+sub:add);     //수정시 추가만 가능하고, 신규등록은 추가/빼기 모두 가능.

                                        return rStr;
                                    }},
            //데이터만
            {key:"level"            }
            ]

        };
        /* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
        var rowHtmlStr = '<tr>';
        rowHtmlStr +=    '<th scope="row" class="vt">#[0]</th>';
        rowHtmlStr +=    '<td>#[1]</td>';
        rowHtmlStr +=    '<td>#[2]</td>';
        rowHtmlStr +=    '<td>#[3]</td>';
        rowHtmlStr +=    '<td>#[4]</td>';
        rowHtmlStr +=    '<td>#[5]</td>';
        rowHtmlStr +=    '<td>#[6]</td>';
        rowHtmlStr +=    '<td>#[7]</td>';
        rowHtmlStr +=    '</tr>';
        configObj.rowHtmlStr = rowHtmlStr;



        myGrid.setConfig(configObj);        //그리드 설정정보 세팅
        //-------------------------- 그리드 설정 :E ----------------------------


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

            },
            contentDivClass: "popup_outline"

        });
        //-------------------------- 모달창 :E -------------------------

    },//end pageStart.
    //################# init function :E #################


    //################# else function :S #################

    //activity row 추가
    addActivity: function(obj, level, fromIndex){

        var inStartDate = $('#inStartDate').val();                         //시작일
        var inEndDate = $('#inEndDate').val();                              //종료일

        var budget = "N";              //예산                    //$('#v_budget').html();    //예산 ... 'No' 이 아니면 'Yes'

        var expense = "N";       //지출                    //$('#v_expense').html();
        var overExpense = "N";                       //예산초과허용 여부

        var enable = "Y";         //사용여부                  $('#v_enable').html();
        var employee = "A";     //직원배정                  $('#v_employee').html();

        var list = myGrid.dataList;

        var data = {  lvl:''
                    , name:''
                    , description:''
                    , startDate: inStartDate
                    , endDate: inEndDate
                    , budget: budget                    //(budget=='No'?'N':'Y')
                    , budgetAmt: ''
                    , expense: expense
                    , overExpense: overExpense
                    , enable: enable
                    , employee: employee
                    , empList: g_pjtEmpList.slice(0)    //[]        //직원배정
                    , empListDel: []                    //직원배정(삭제할건)
                    , btn:''
                    , cardExpenseSum : 0
                    , scheChk : ''                  //스케쥴 체크
                    , apprChk : ''                  //전자결재 체크

        };

        data.level = level;

        var idx = -1;
        if(level == 0){         // ----------- level 0 인 activity 의 추가버튼을 클릭

            var nIdx = fnObj.getIndexToLvl0(fromIndex);
            myGrid.insertRow(data, nIdx);

        }else{                  // ----------- level 1 인 activity 의 추가버튼을 클릭

            if(list.length == fromIndex+1){ //마지막 activity 에서 추가버튼을 누른케이스
                data.lvl = (1 * list[fromIndex].lvl) + 1;
                idx = myGrid.addRow(data);

            }else if(list[fromIndex + 1].level == 0){   //다음 activity 의 레벨이 0인 케이스

                data.lvl = (1 * list[fromIndex].lvl) + 1;
                idx = fromIndex + 1;
                myGrid.insertRow(data, idx);

            }else{

                data.lvl = (1 * list[fromIndex].lvl) + 1;
                idx = fromIndex + 1;
                myGrid.insertRow(data, idx);
            }

        }


        fnObj.resetLevelAndClass();     //레벨 값 및 스타일 class 재세팅


    },//addActivity


    //0 레벨이 들어갈 index 반환 함수
    getIndexToLvl0: function(fromIndex){
        var list = myGrid.dataList;

        for(var i=fromIndex; i<list.length; i++){
            if(i+1 == list.length || list[i+1].level != 1){
                return (i+1);
            }
        }
    },


    //레벨 값 및 스타일 class 재세팅
    resetLevelAndClass: function(){

        var list = myGrid.dataList;
        var data;

        var level;
        var lvl;
        var sort;

        var cntLvl0 = 0;
        var cntLvl1 = 0;

        for(var i=0; i<list.length; i++){

            level = list[i].level * 1;

            switch(level){      //해당 레벨의 값을 1증가, 하위는 0 초기화... (cntLvl0 * 100 + cntLvl1 * 10 + cntLvl2) 가 sort(정렬)값이 된다.
                case 0: cntLvl0 ++;
                        cntLvl1 = 0;

                        lvl = cntLvl0;      //lvl
                        break;

                case 1: cntLvl1 ++;

                        lvl = cntLvl1;      //lvl
                        break;
            }
            sort = (cntLvl0 * 100 + cntLvl1).toString();

            list[i].lvl = lvl;          //lvl 세팅
            list[i].sort = sort;        //sort 세팅


            //레벨 input 데이터 세팅
            $(myGrid.gridBodyObject.find('input[name=lvl]')[i]).val(lvl);


            //class 스타일 세팅
            if(level == 0){
                $(myGrid.gridBodyObject.children('tr')).addClass('level_first');

            }else{  //level == 1

                var tr = $(myGrid.gridBodyObject.children('tr')[i]);
                tr.removeClass('level_second');     //init
                tr.removeClass('level_second_end'); //init

                if(list.length == i+1){ //마지막 activity
                    tr.addClass('level_second_end');

                }else if(list[i + 1].level == 0){   //다음 activity 의 레벨이 0인 케이스
                    tr.addClass('level_second_end');

                }else{
                    tr.addClass('level_second');
                }
            }


        }//for

    },


    //0레벨(level_first) row 삭제
    delActivity: function(index, level){

        //------- 0 레벨갯수가 1개뿐이면(지우려는게 자신이면) 지울 수 없도록 -----
        var list = myGrid.dataList;
        var cnt = 0;
        for(var i=0; i<list.length; i++){
            if(list[i].level == 0){     //자식이면
                cnt++;                  //counting up
            }
        }
        if(cnt<=1 && level==0){
            dialog.push({body:"<b>삭제불가</b> <br>최소한 1개의 activity는 존재해야합니다!", type:'Caution', onConfirm:function(){}});
            return;
        }
        //-----------------------------------------------------------------


        if(level == 0){     //자신을 포함한 자식노드까지 삭제

            var childCnt = fnObj.getChildActivityCnt(index);

            if(childCnt>0){
                dialog.push({
                    body:'<b>Caution</b>&nbsp;&nbsp;자식 ${baseUserLoginInfo.activityTitle} 가 존재합니다. 함께 삭제하시겠습니까?', top:0, type:'Caution', buttons:[
                        {buttonValue:'확인', buttonClass:'Red', onClick:fnObj.delActivityNChild, data:{fromIndex:index, cnt:childCnt}},   //, data:{param:"222"}},    //Red W100
                        {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}    //, data:'data2'},
                    ]});

            }else{


                //-- row 삭제시 해당 row에 있던 직원리스트 삭제 액션.
                var list = myGrid.getList();
                var empList = list[index].empList;

                myGrid.dataList.remove(index);

                fnObj.refreshActivityGrid();        //activity 그리드 refresh
            }
        }else{  //level == 1    ... 자신노드 만 삭제

            myGrid.dataList.remove(index);

            fnObj.refreshActivityGrid();        //activity 그리드 refresh

        }

    },

    //activity 삭제(0레벨 및 그 자식레벨)
    delActivityNChild: function(paramObj){
        var fromIndex = paramObj.fromIndex;
        var cnt = paramObj.cnt;

        for(var i=fromIndex+cnt; i>=fromIndex; i--){
            myGrid.dataList.remove(i);
        }

        fnObj.refreshActivityGrid();        //activity 그리드 refresh
    },

    //activity 그리드 refresh
    refreshActivityGrid: function(){

        myGrid.refresh();

        fnObj.resetLevelAndClass();     //레벨 값 및 스타일 class 재세팅


    },

    //0레벨의 자식레벨의 갯수 구하는 함수
    getChildActivityCnt: function(fromIndex){
        var list = myGrid.dataList;
        var cnt = 0;
        for(var i=fromIndex+1; i<list.length; i++){
            if(list[i].level == 1){     //자식이면
                cnt++;                  //counting up
            }else{
                break;
            }
        }

        return cnt;
    },

    //------------------------------- sync data :S --------------------------------

    //name sync
    syncActivityName: function(obj, index){
        myGrid.dataList[index].name = obj.value;
    },

    //description sync
    syncActivityDesc: function(obj, index){
        myGrid.dataList[index].description = obj.value;
    },

    //budget sync
    changeBudget: function(obj, val, index){
        myGrid.dataList[index].budget = obj.value;
        var td = $(obj).parent();
        if(obj.value =='N'){
            td.children('span[name=spanBudget]').hide();
            $("#spanOverExpenseArea"+index).hide();                                         //예산이 N 이면 지출에 예산에 대한 셀렉 숨기기
        }else{
            td.children('span[name=spanBudget]').show();
            if($("#selExpense"+index).val() !='N') $("#spanOverExpenseArea"+index).show();  //예산이 Y 이면서 지출 N 이 아니면. 예산에 대한 표시
        }
    },

    //enable sync
    changeEnable: function(obj, val, index){
        myGrid.dataList[index].enable = obj.value;
    },

    //------------------------------- sync data :E --------------------------------

    //저장 doSave
    doSave: function(){

        var list = myGrid.dataList;

        //--------------- validation :S ---------------
        var frm = document.myForm;

        if(isEmpty(frm.inProjectName.value)){           //템플릿명
            dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.projectTitle}명을 입력해주세요!", type:"", onConfirm:function(){frm.inProjectName.focus();}});
            return;
        }
        if(isEmpty(frm.inProjectDesc.value)){           //설명
            dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.projectTitle} 설명을 입력해주세요!", type:"", onConfirm:function(){frm.inProjectDesc.focus();}});
            return;
        }

        //-------------  activity validation
        for(var i=0; i<list.length; i++){
            if(isEmpty(list[i].name)){                      //Activity명
                dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.activityTitle} 명을 입력해주세요!", type:"", onConfirm:function(){$(myGrid.gridBodyObject.find('input[name=aName]')[i]).focus();}});
                return;
            }
            if(isEmpty(list[i].description)){               //Activity설명
                dialog.push({body:"<b>확인!</b> ${baseUserLoginInfo.activityTitle} 설명을 입력해주세요!", type:"", onConfirm:function(){$(myGrid.gridBodyObject.find('input[name=aDesc]')[i]).focus();}});
                return;
            }

            var startDate = $('#inStartDate').val();
            var eachStartDate = $('#inStartDate' + i);
            var endDate = $('#inEndDate').val();
            var eachEndDate = $('#inEndDate' + i);

        }
        //--------------- validation :E ---------------
        //저장
        if(confirm('저장하시겠습니까?')){
            var url = contextRoot + "/project/doSaveBaseProject.do";
            var param = {
                    mode         : mode,                        //"new" or "update"
                    orgId        : g_orgId,                     //ORG_Id
                    projectId    : g_projectId,                 //"update" mode 일경우
                    projectName  : frm.inProjectName.value,     //프로젝트명
                    projectDesc  : frm.inProjectDesc.value,     //프로젝트 설명
                    aList :   JSON.stringify(list)          //그리드 데이터 리스트 (JSON 문자열로 전달)
            };

            var callback = function(result){
                var obj = JSON.parse(result);
                //세션로그아웃 >> 재로그인
                if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
                    window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
                    return;
                }
                var projectId = obj.resultVal;  //templateId
                if(obj.result == "SUCCESS"){
                    alert("저장되었습니다.");
                    document.location.href = contextRoot+"/project/projectBaseMgmt.do";
                }else{
                    //alertMsg();
                }
            };
            commonAjax("POST", url, param, callback);
        }
    },//doSave


    //엑셀다운
    excelDownload: function(){
         excelDown(myGrid.getExcelFormat('html'), "download");      //common.js
    },


    //프로젝트 정보 불러와 세팅
    setProjectInfo: function(pId){
        var url = "<c:url value='/project/getBaseProjectInfo.do'/>";
        var param = {
        		projectId : pId,
                baseProjectId : pId
                    };
        var callback = function(result){

            var obj = JSON.parse(result);

            var jsonObj = obj.resultObject;     //결과데이터JSON

            var project = jsonObj.pProject;     //템플릿 프로젝트
            var actList = jsonObj.pActivity;    //템플릿 activity

            if(obj.result == "SUCCESS"){
                g_actListLength = actList.length;

                //----- 내용뿌리기 :S -----
                var frm = document.myForm;

                //프로젝트
                frm.inProjectName.value     = project.name;             //프로젝트명
                frm.inProjectDesc.value     = project.description;      //프로젝트 설명

                //activity
                myGrid.setGridData({
                                    list: actList,  //그리드 테이터
                                    page: null      //페이징 데이터
                                });


                //----- 내용뿌리기 :E -----
                fnObj.resetLevelAndClass();         //레벨 값 및 스타일 class 재세팅

                //수정가능 항목 메세지 보이기
                $('#updatableMsg').show();

            }else{
                //alertMsg();
            }

        };

        commonAjax("POST", url, param, callback);

    },//setProjectInfo

    //그리드 refresh
    refreshGrid: function(){

        myGrid.refresh();



        fnObj.resetLevelAndClass();     //레벨 값 및 스타일 class 재세팅

    },

     //달력 세팅
    setDateShow : function(obj,date){

        $('#'+obj).datepicker({
            dateFormat: 'yy-mm-dd',
            changeMonth: true,
            changeYear: true,
            showOn: "button",

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

        $("#"+obj).datepicker('setDate', date);
    },

    //################# else function :E #################



};//end fnObj.

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
    fnObj.preloadCode();    //공통코드 or 각종선로딩코드
    fnObj.pageStart();      //화면세팅
    fnObj.setProjectInfo('${projectId}');
});

</script>