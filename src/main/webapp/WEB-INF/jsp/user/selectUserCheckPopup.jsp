<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>var contextRoot="${pageContext.request.contextPath}";</script><!-- necessary! to import js files -->

<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery-latest.js" ></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/tree.js" ></script>

<!--

############파라미터###########

isAllOrg            //전체 ORG 범위로의 여부         .. default:N   ('Y': 전체ORG,        그외,: 나의권한ORG)
isOneOrg            //단일 ORG 범위로의 여부         .. default:N   ('Y': 단일ORG(세션 applyOrg),       그외,: 나의권한ORG)
oneOrgId            //단일 ORG 범위로의 여부         .. default:N  isOneOrg Y 이고 지정한 orgId 적용하고자하는 관계사 ID
isOneUser           //user 한명 선택 .. default 'N' ('Y': 한명만,          N: 다중)
isOneDept           //dept 한명 선택 .. default 'Y' ('Y': 한명만,          N: 다중)

isDeptSelect        //부서 단일 선택               .. default:N
isUserSelectEabled  //유저 선택 체크박스 disabled  .. default:N
isAllOrgSelect      //ORG 간에 사원선택 가능여부   .. default:N
isCloseBySelect     // 선택과동시에 창닫기 여부         .. default 'Y' ('N': 안닫힌다,     그외: 닫힌다)
userList            //default 로 선택 되게 하고싶은 유저의 userId -> 여러명 , 구분
disabledList        //default 로 disable 처리하고 싶은  userId 리스트  -> 여러명 , 구분
isEnable            //유효한 사원                 .. default 'Y' ('N': 퇴사자,          그외: 재직자)
isCheckDisable      //disable 처리된 값에대한 상위 체크박스 컨트롤 여부 .. default 'Y'    ('Y': 가능,           N: 불가)
isCheckOrgUseYn    // ORG 의 사용가능여부와 유효여부 값에 따라 선택 여부 결정 유무 default 'Y'  ('Y': 체크함,           N: 체크안함)

ex >
     팀만 조작하고 직원 체크박스는 조작 불가능                - isUserSelectEabled : Y
     단 하나의 세션에 있는 applyOrg의 사원 목록만 보여줄때         - isOneOrg : Y
     전체 모든 org 가 select 박스 리스트                  - isAllOrg : Y
     전체 모든 org 가 select 박스 리스트 ,  org 간에 선택 리스트를 공유하고 싶을때   - isAllOrg : Y ,isAllOrgSelect : Y
     전체 모든 org 가 select 박스 리스트 ,  org 간에 선택 리스트를 공유하고 싶지않을때- isAllOrg : Y ,isAllOrgSelect : N



     나의 권한이 있는 org 만  select 박스 리스트     org 간에 선택 리스트를 공유하고 싶을때         - isAllOrg : N , isAllOrgSelect : Y
                                        org 간에 선택 리스트를 공유하고 싶지않을때   - isAllOrg : N , isAllOrgSelect : N (org변경시, 선택리스트 초기화)

     첫 화면 실행시
     1. isAllOrg 과  isOneOrg 에 따라 , org리스트를 가져온다.
     2. 부모창에서  default선택리스트 [userList(userId를  , 구분)]를 전역변수로 담아둔다.
     3. orgId의 조건에 관계 없이 getAllUserList 함수에서  선택된 유저(userList) 의 정보를 가져와 전역변수로 담아둔다.
     4. 해당 org 의 부서 리스트를 가져온후 체크박스와 트리를 그리고, org 에 따른 유저리스트를 가져온다.
     5. initCheckSet 함수 에서 isAllOrgSelect 값을 판별
     6. 파라미터로 넘어온 default선택리스트 (userList)를 비교 하여 선택리스트(resultList)에 세팅해주고.
     7. default선택리스트(userList)의 체크박스에 체크 해준다.

     이후, org간 이동시.. changeOrg 함수
     1. isAllOrgSelect - Y (org간 선택리스트 공유)      saveCheckSet 함수 실행  -> 변경된 org 에 맞춰  체크박스 체크
     2. isAllOrgSelect - N (org간 선택리스트 공유가 아닐때)  resultList 초기화

 -->

<div id="compnay_dinfo" style="min-width:900px;">
    <div class="modalWrap2">
        <h1><strong id="titleNameArea">직원 선택</strong></h1>
        <div class="mo_container">

            <!-- 검색 결과창 -->
            <div id="searchArea" class="pre_search_warp" style="z-index:10000;display:none;position:absolute;">
                <div class="pre_search_con">
                    <ul class="search_table_st" id="resultArea">
                    </ul>
                </div>
                <div class="btn_prewindow" onclick="javascript:$('#searchArea').hide();return false;"><a class="funoff" href="javascript:$('#searchArea').hide();return false;">닫기</a></div>
            </div>


            <!--검색-->
            <div class="carSearchBox">
                <span class="carSearchtitle">회사</span><span id="deptClassSelectTag"></span>
                <span id="orgSelectTag">
                <select name="selOrg" id="selOrg" class="select_b w_100px" onchange="fnObj.changeOrg();">
                </select>
                </span>
                <span class="carSearchtitle mgl30" id="spanUserNameSrch">직원명</span>
                <input id="inUserName" name="inUserName" onkeypress="if(event.keyCode==13) fnObj.doSearchNm(this.value,this);" class="input_b w_148px">
                <span id="alertArea" style="color:red;padding-left:10px;"></span>

            </div>
            <!--/검색/-->

            <!--전체영역-->
            <div id="dataTr" class="wrap_select_tree mgt20">

                <!--왼쪽영역-->
                <div class="left_block">
                    <div class="treeShape_tt" id="allCheckArea"></div>
                    <div class="tabZone_tree_list" id="tabArea" style="display:none;"></div>
                    <div class="treeShape_st">
                        <ul id="treeArea" style="margin-bottom:17px"></ul>                 <!-- 왼쪽 트리 체크박스-->
                        <ul id="approveTreeArea"></ul>
                    </div>
                    <div class="allmem_array_list">
                        <ul id="treeArea2"></ul>                <!-- 왼쪽 트리 체크박스(직원별)-->
                    </div>

                    <div class="treeShape_userGroup">
                        <ul id="treeArea3"></ul>                <!-- 왼쪽 트리 체크박스(그룹별)-->
                    </div>
                </div>
                <!--/왼쪽영역/-->

                <!--오른쪽영역-->
                <div class="right_block">
                    <!--게시판카운트-->
                    <div class="board_classic mgt20">
                        <div class="leftblock">
                            <span class="count_result" id="selectCount"></span>
                        </div>
                    </div>
                    <!--//게시판카운트//-->


                   <!--선택목록-->
                   <table id="SGridTarget" class="tb_list_basic" summary="사원목록">
                       <caption>사원목록</caption>
                       <colgroup>
                          <col width="150" />
                          <col width="150" />
                          <col width="150" />
                          <col width="150" />
                          <col width="100" />
                       </colgroup>
                       <thead>
                            <th scope="col">회사</th>
                            <th scope="col">부서</th>
                            <th scope="col" class="dynamic_column"><a href="#" onclick="fnObj.doSort(0);return false;" id="sort_column_prefix0" class="sort_normal">직원명<em>정렬</em></a></th>
                            <th scope="col" class="dynamic_column"><a href="#" onclick="fnObj.doSort(1);return false;" id="sort_column_prefix1" class="sort_normal">사번<em>정렬</em></a></th>
                            <th scope="col">삭제</th>
                       </thead>
                       <tbody>

                       </tbody>
                   </table>

                   <!--선택목록(팀)-->
                   <table id="SGridTarget2" class="tb_list_basic" summary="사원목록">
                       <caption>부서목록</caption>
                       <colgroup>
                          <col width="150" />
                          <col width="150" />
                          <col width="100" />
                        </colgroup>
                       <thead>
                            <th scope="col">회사</th>
                            <th scope="col">부서</th>
                            <th scope="col">삭제</th>
                       </thead>
                       <tbody>

                       </tbody>
                   </table>
                   <!--//선택목록//-->
                </div>
                <!--/오른쪽영역/-->

            </div>
            <!--/전체영역/-->
            <div class="btnZoneBox">
            <a href="javascript:fnObj.selectFinish();" class="p_blueblack_btn"><strong>선택</strong></a>
            <a href="#" class="p_withelin_btn" id = "btnDirectInputActive" onclick="fnObj.doClose('directInput')">취소(직접입력하기)</a>
            </div>
         </div>

     </div>
</div>






<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';     //language (profile language... 'KOR' or 'ENG')

var myGrid = new SGrid();       // instance     new sjs
var myGrid2 = new SGrid();      // instance     new sjs
var mySorting = new SSorting(); // instance     new sjs


//공통코드(외,코드)
var comCodeEmpType;                 //메뉴타입
var comCodeUserStts;                //채용형태
var orgCodeCombo;                   //ORG코드(콤보용)


//검색옵션
var isAllOrg = '${isAllOrg}' == 'Y'  ? 'Y' : 'N';   //전체 ORG 범위로의 여부                        ('Y': 전체ORG,        그외,: 나의권한ORG)
var isOneOrg = '${isOneOrg}' == 'Y'  ? 'Y' : 'N';   //단일 ORG 범위로의 여부         .. default:N   ('Y': 단일ORG,        그외,: 나의권한ORG)

var oneOrgId = '${oneOrgId}';             //단일 ORG 범위로의 여부         .. default:N  isOneOrg Y 이고 지정한 orgId 적용하고자하는 관계사 ID

var isOneUser = '${isOneUser}' == 'Y'  ? 'Y' : 'N'; //유저 한명만 선택 여부       .. default:N   ('Y': 한명만,      그외,: 다중)
var isOneDept = '${isOneDept}' == 'N'  ? 'N' : 'Y'; //부서 한명만 선택 여부       .. default:Y   ('Y': 한명만,      그외,: 다중)
var isUserSelectEabled ='${isUserSelectEabled}' == 'N'  ? 'N' : 'Y';    //유저 선택 체크박스 disabled  .. default:Y
var isAllOrgSelect = '${isAllOrgSelect}' == 'Y'  ? 'Y' : 'N';           //ORG 간에 사원선택 가능여부   .. default:N
var isCloseBySelect ='${isCloseBySelect}' == 'N'  ? 'N' : 'Y';
var isEnable        =('${isEnable}' == 'N' ? 'N' : '');                 //재직자 조회시 빈값 퇴사자면 N 값
var isDeptSelect    =('${isDeptSelect}' == 'Y' ? 'Y' : 'N');            //부서 단일 선택               .. default:N

var isUserGroup    =('${isUserGroup}' == 'Y' ? 'Y' : 'N');            //유저그룹 탭 사용여부 (true: 사용,       그외,: 미사용(default))

var hasDeptTopLevel  =('${hasDeptTopLevel}' == 'Y' ? 'Y' : 'N');            //부서의 회장 부서 표시여부

var isAppoveLineAdd = ('${isAppoveLineAdd}' == 'Y' ? 'Y' : 'N');            //결재 라인 결재자 공개여부

var isCheckDisable = ('${isCheckDisable}' == '' ? 'Y' : '${isCheckDisable}'); //diable 리스트가 부서선택시 체크 선택 해제 기능을 사용할것인지 .. default:Y

var isCheckOrgUseYn = ('${isCheckOrgUseYn}' == '' ? 'Y' : '${isCheckOrgUseYn}');   // ORG 의 사용가능여부와 유효여부 값에 따라 선택 여부 결정 유무 default 'N'  ('Y': 체크함,  N: 체크안함)

var g_parentKey ='${parentKey}'         //부모창 키 값.


var g_selectUserStr ='${userList}';     //선택 유저 리스트 to String(userId값만있다)
var g_selectUserList = new Array();     //선택유저 리스트 (g_selectUserStr를 이용 db 에서 정보를 가져옴)
var g_selectDeptList =new Array();
var g_disabledList = new Array();       //선택 및 해제 불가 유저리스트

var g_userList = new Array();           //해당org의 유저리스트
var g_deptList = new Array();           //해당 org 의 부서리스트
var g_userGroupList =new Array();       //해당 org 의 부서리스트

var resultList =new Array();            //선택리스트

var g_searchList =new Array();

var g_tabFlag ='DEPT';                  //탭의 값

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

    //################# init function :S #################

    //선로딩코드
    preloadCode: function(){


        if(parent.myModal != undefined)
        parent.myModal.resize();

        var disabledList = '${disabledList}';
        g_disabledList = disabledList.split(",");

        var params = {'authOrgId':'Y', 'userId':'${baseUserLoginInfo.userId}'};     //나에게 권한이 있는 관계사만 볼 수 있다
        if(isAllOrg == 'Y'){        //전체 ORG 범위검색이면
            params = {};            //조건없이 검색(전체검색)
        }
        if(isOneOrg == 'Y'){        //단하나의 org만 검색할때
        	if(oneOrgId == ''){
        		params = {'applyOrgId':'${baseUserLoginInfo.applyOrgId}'};
        	}else{
        		params = {'applyOrgId':oneOrgId};
        	}

        }

        // ORG 의 사용가능여부와 유효여부 값에 따라 선택 여부 결정 유무 default 'N'  ('Y': 체크함,  N: 체크안함)
        params.isCheckOrgUseYn = isCheckOrgUseYn;

        orgCodeCombo = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/common/getOrgCodeCombo.do', params);       //ORG코드(콤보용) 호출

        if(orgCodeCombo == null){
            orgCodeCombo = [{ 'CD': '', 'NM' :'선택'}];
        }

        //관계사
        var defaultOrgId = (oneOrgId == '' ? '${baseUserLoginInfo.applyOrgId}' : oneOrgId);       //기본 선택 관계사
        var orgSelectTag = createSelectTag('selOrg', orgCodeCombo, 'CD', 'NM', defaultOrgId, 'fnObj.changeOrg();', {}, null, 'select_b period');    //select tag creator 함수 호출 (common.js)
        $("#orgSelectTag").html(orgSelectTag);

        if(orgCodeCombo!=null && orgCodeCombo.length<2){
            $("#selOrg").hide();
            $("#orgSelectTag").append(orgCodeCombo[0].NM);
        }

        $("#dataTr").mousedown(function(){
            $("#alertArea").html("");
            $("#searchArea").hide();        //검색창
        });

        if(isDeptSelect == 'Y'){
            $("#spanUserNameSrch").hide();
            $("#inUserName").hide();

            $("#titleNameArea").html('부서 선택');

            hasDeptTopLevel = 'N';		//부서선택일땐 무조건 회장 불포함
        }

    },


    //화면세팅
    pageStart: function(){
        $("#SGridTarget2").hide();

        //-------------------------- 그리드 설정 :S ----------------------------
        /* 그리드 설정정보 */
        var configObj = {

            targetID : "SGridTarget",       //그리드의 id

            emptyOfList : true,         //데이터가 없을때 빈 데이터 추가여부(default true)

            //그리드 컬럼 정보
            colGroup : [


            {key:"orgNm"            },
            {key:"deptNm",          formatter:function(obj){return (obj.value + (obj.item.mainYn=='N'?'<font color="silver">(겸)</font>':''));}},
            {key:"userName",         formatter:function(obj){
            												var stStr = "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+obj.item.userId+"\",$(this),\"mouseover\",null,5,-80,80)'>";
            													stStr+= obj.item.userName;
            													stStr +="</span>";
            												return stStr;
            												}
            },
            {key:"showEmpNo"        },
            {key:"chk",             formatter:function(obj){
                var str ='';
                if(isUserSelectEabled != 'N' && getArrayIndexWithValue(g_disabledList,obj.item.userId)<0){
                    str = '<button type="button" onclick="fnObj.delUser(\'' + obj.item.userId + '\',\''+ obj.item.id + '\');return false;" class="btn_s_type_g"><em>삭제</em></button>';
                }

                return str;

            }}
            ],

            body : {
                onclick: function(obj){

                }
            }

        };
        /* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
        var rowHtmlStr = '<tr>';
        rowHtmlStr +=    '<td class="txt_left">#[0]</td>';
        rowHtmlStr +=    '<td class="txt_left">#[1]</td>';      //td 에 이벤트를 준 케이스
        rowHtmlStr +=    '<td class="txt_center">#[2]</td>';

        //if(popupType != 'DEPT'){
            rowHtmlStr +=    '<td class="engst">#[3]</td>';
            rowHtmlStr +=    '<td class="txt_center">#[4]</td>';
        //}

        rowHtmlStr +=    '</tr>';
        configObj.rowHtmlStr = rowHtmlStr;


        myGrid.setConfig(configObj);        //그리드 설정정보 세팅
        //-------------------------- 그리드 설정 :E ----------------------------


        //-------------------------- 소팅 설정 :S ----------------------------
        mySorting.setConfig({
            colList : ['userName', 'empNo'],
            classNameNormal     : 'sort_normal',                //정렬기본 아이콘 css class
            classNameHighToLow  : 'sort_hightolow',             //오름정렬 아이콘 css class
            classNameLowToHigh  : 'sort_lowtohigh'              //내림정렬 아이콘 css class
        });
        //-------------------------- 소팅 설정 :E ----------------------------


    },//end pageStart.

    //화면세팅
    pageTeamStart: function(){

        $("#SGridTarget").hide();

        //-------------------------- 그리드 설정 :S ----------------------------
        /* 그리드 설정정보 */
        var configObj = {

            targetID : "SGridTarget2",      //그리드의 id

            emptyOfList : true,         //데이터가 없을때 빈 데이터 추가여부(default true)

            //그리드 컬럼 정보
            colGroup : [


            {key:"orgNm"            },
            {key:"deptNm",          formatter:function(obj){return obj.value;}},

            {key:"chk",             formatter:function(obj){
                var str ='';
                str = '<button type="button" onclick="fnObj.delUser(' + obj.item.deptId + ');return false;" class="btn_s_type_g"><em>삭제</em></button>';


                return str;

            }}
            ],

            body : {
                onclick: function(obj){

                }
            }

        };
        /* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
        var rowHtmlStr = '<tr>';
        rowHtmlStr +=    '<td class="txt_left">#[0]</td>';
        rowHtmlStr +=    '<td class="txt_left">#[1]</td>';      //td 에 이벤트를 준 케이스
        rowHtmlStr +=    '<td class="txt_center">#[2]</td>';


        rowHtmlStr +=    '</tr>';
        configObj.rowHtmlStr = rowHtmlStr;


        myGrid.setConfig(configObj);        //그리드 설정정보 세팅
        //-------------------------- 그리드 설정 :E ----------------------------


        //-------------------------- 소팅 설정 :S ----------------------------
        mySorting.setConfig({
            colList : ['userName', 'empNo'],
            classNameNormal     : 'sort_normal',                //정렬기본 아이콘 css class
            classNameHighToLow  : 'sort_hightolow',             //오름정렬 아이콘 css class
            classNameLowToHigh  : 'sort_lowtohigh'              //내림정렬 아이콘 css class
        });
        //-------------------------- 소팅 설정 :E ----------------------------


    },//end pageTeamStart.



    //org변경시
    changeOrg : function(){
        $("#searchArea").hide();
        //g_tabFlag ='DEPT';                        //탭 플래그 값 초기화
        //fnObj.getDeptList();                  //다시 체크박스를 그리고
        fnObj.selectTabZone('DEPT','ORG');
        if(isAllOrgSelect == 'Y' && isDeptSelect != 'Y'){               //org간 사원선택이 가능할때..
            fnObj.saveCheckSet();
        }else{
            resultList=[];

            myGrid.setGridData({                //그리드 데이터 세팅    *** 2 ***
                list: resultList                //그리드 테이터
            });
            $('.popup_outline').find('input:checkbox').prop("checked",false);
             $("#selectCount").html('<strong>전체</strong><em>'+resultList.length+'</em>건');
        }

    },

    //컬럼 소팅
    doSort: function(idx){

        mySorting.setSort(idx);             //소팅객체를 소팅한다.(상태값들의 변화)
        //소팅
        sortByKey(myGrid.getList(), mySorting.nowSortCol, mySorting.nowDirection);
        myGrid.refresh();
        mySorting.applySortIcon();          //소팅화면적용

     },//end doSort

    //################# init function :E #################


    //################# else function :S #################

    //이름검색
    doSearchNm : function(searchValue,th){

        g_searchList = [];

        var left = $(th).offset().left-5;
        var top = $(th).offset().top + $(th).height()+2;
        $("#searchArea").css({display:"",left:left,top:top});

        var searchList =[];
        var str ='';
        for(var i=0;i<g_userList.length;i++){
            var userName = g_userList[i].userName;
            if(userName.match(searchValue)){
                searchList.push(g_userList[i]);
                str +='<li onclick="javascript:fnObj.searchClick(\''+g_userList[i].userId+'\',\''+g_userList[i].id+'\');"><a href="" class="atcmp_keyword" onclick="return false;">';
                str +='<span class="atcmp_name">'+userName.replace(new RegExp(searchValue,"gi"), '<strong>'+searchValue+'</strong>')+'</span>';
                str +='<span class="experson">(<em class="atcmp_com">'+g_userList[i].orgNm+'</em>|<em class="atcmp_team">'+g_userList[i].deptNm+'</em>|<em class="atcmp_num">'+g_userList[i].showEmpNo+'</em>)</span></a></li>';
            }
        }

        if(searchList.length==0){
            str +='<li><a href="" class="atcmp_keyword" onclick="return false;">';
            str +='<span class="atcmp_name">검색결과가 없습니다.</span>';
            str +='</a></li>';
        }
        g_searchList = searchList;

        $("#resultArea").html(str);


    },

    //직원 검색에서 선택시
    searchClick : function(userId,id){
        if(isUserSelectEabled != 'N'){
            $("#alertArea").html("");
            if(getCountWithValue(resultList, 'userId', userId)==0){
                $("#userCheck_"+userId).prop("checked",true);
                fnObj.setSelectList(userId,'',id);
                $("#searchArea").hide();
            }else{
                $("#alertArea").html('<i class="axi axi-exclamation-circle"></i>이미 선택되어 있습니다.');
            }
        }else{
            $("#alertArea").html('<i class="axi axi-exclamation-circle"></i>해당옵션에서는 선택 불가합니다.');
        }


    },

    //팀 체크박스 세팅
    getDeptList : function(){

        var orgId = $("#selOrg").val();
        var url = contextRoot+"/common/getDeptList.do";
        var param = {
                applyOrgId  : orgId,
                enable      : isEnable,
                hasDeptTopLevel : hasDeptTopLevel,
                isAppoveLineAdd : isAppoveLineAdd,
                isDeptSelect	: isDeptSelect
        };

        var callback = function(result){

            var obj = JSON.parse(result);
            var cnt = obj.resultVal;        //결과수
            var list = obj.resultList;      //결과데이터JSON

            g_deptList = list;

            var allStr ='';
            if(isOneUser != 'Y' && isDeptSelect !='Y'){     //단일 유저 선택이아니면,
                allStr ='<div class="tnavi_title"><label><span>전체선택</span><input type="checkbox" id="allCheckBox" onclick="fnObj.allCheck(this);"></label></div>';

            }else{
                if(isDeptSelect !='Y') allStr ='<label><span>직원선택</span></label>';
                else allStr ='<label><span>부서선택</span></label>';
            }
            $("#allCheckArea").html(allStr);

            //--최상위 부서 그리드

            allStr ='';

            if(isDeptSelect != 'Y' && isUserSelectEabled !='N'){        //부서만 선택 옵션이 아니고, 유저 체크박스 선택 불가 가 아니면 탭생성

                allStr += '<ul style="border-top:none; border-right:none; ">';
                allStr += '<li id="tabZoneDept" class="current"><a href="#" onclick="fnObj.selectTabZone(\'DEPT\');" >부서별</a></li>';
                allStr += '<li id="tabZoneUser"><a href="#" onclick="fnObj.selectTabZone(\'USER\');" >직원별</a></li>';
                if(isUserGroup == "Y") {
                    allStr += '<li id="tabZoneGroup"><a href="#" onclick="fnObj.selectTabZone(\'GROUP\');" >그룹별</a></li>';
                }
                allStr += '</ul>';

                if(isUserGroup == "Y") $("#tabArea").attr("class", "tabZone_tree_list mn03");
                else $("#tabArea").attr("class", "tabZone_tree_list");

                $("#tabArea").show();
                $("#tabArea").html(allStr);
            }


            if(g_tabFlag == 'DEPT'){
                var str ='';

                for(var i =0;i<list.length;i++){

                	var chk = true;

                	if(isAppoveLineAdd == 'Y' && list[i].teamOrgId != orgId ) chk = false;


                    if(list[i].parentDeptId == 0 && chk){

                        str +='<li id="deptLi_'+list[i].deptId+'">';
                        str +='<div id="div_'+list[i].deptId+'"><label';

                        if(isOneDept == 'Y' && isDeptSelect == 'Y'){    //팀 하나만선택
                            str +=' id="deptLabel_'+list[i].deptId+'" onclick="fnObj.teamOnlySelect(\''+list[i].deptId+'\');">  ';
                        }else if(isOneDept != 'Y' && isDeptSelect == 'Y'){    //팀 다중선택
                            str +='>  ';
                            str +='<input type="checkbox" name="deptCheckBox"  id="deptCheck_'+list[i].deptId+'"  class="deptTop teamChk" value="'+list[i].deptId+'" onclick="fnObj.teamMultiSelect('+list[i].deptId+','+list[i].parentDeptId+',this);"> ';
                        }else{
                            str +='>  ';
                        }

                        if(isOneUser != 'Y' && isDeptSelect != 'Y'){        //단일 유저 선택이아니고 팀 하나만선택이 아니면
                            str +='<input type="checkbox" id="teamCheck_'+list[i].deptId+'"  class="deptTop teamChk" value="'+list[i].deptId+'" onclick="fnObj.checkDo('+list[i].deptId+',this,'+list[i].parentDeptId+');"> ';
                        }



                        str +='<i class="icon_pd"></i><span>'+list[i].deptNm+'</span></label>';
                        str +='</div>';
                        str += '<dl class="childteam" id="namedl_'+list[i].deptId+'"><dd><div id="name_'+list[i].deptId+'"></div></dd></dl>';

                        str +='<ul id="innerDeptUl_'+list[i].deptId+'" class="innerUl"></ul></li>';


                    }

                }

                $("#treeArea").html(str);

                //--최상위 부서 이외 부서 그리드

                for(var i =0;i<list.length;i++){
                    str ='';
                    userStr = '';
                    var chk = true;
                    if(isAppoveLineAdd == 'Y' && list[i].teamOrgId != orgId ) chk = false;

                    if(list[i].parentDeptId != 0  && chk){

                        str +='<li id="deptLi_'+list[i].deptId+'">';
                        str +='<div id="div_'+list[i].deptId+'"><label';

                        if(isOneDept == 'Y' && isDeptSelect == 'Y'){    //팀 하나만선택
                            str +=' id="deptLabel_'+list[i].deptId+'"  onclick="fnObj.teamOnlySelect(\''+list[i].deptId+'\');">  ';
                        }else if(isOneDept != 'Y' && isDeptSelect == 'Y'){    //팀 다중선택
                            str +='>  ';
                            str +='<input type="checkbox" class="teamChk"  name="deptCheckBox"  id="deptCheck_'+list[i].deptId+'" onclick="fnObj.teamMultiSelect('+list[i].deptId+','+list[i].parentDeptId+',this);">';
                        }else{
                            str +='>  ';
                        }

                        if(isOneUser != 'Y'  && isDeptSelect != 'Y'){       //단일 유저 선택이아니면,
                            str +='<input type="checkbox" class="teamChk" id="teamCheck_'+list[i].deptId+'" onclick="fnObj.checkDo('+list[i].deptId+',this,'+list[i].parentDeptId+');">';
                        }

                        str +='<i class="icon_pd"></i><span>'+list[i].deptNm+'</span></label>';

                        str +='</div>';
                        str += '<dl class="childteam" id="namedl_'+list[i].deptId+'"><dd><div id="name_'+list[i].deptId+'"></div></dd></dl>';
                        ///* <dl class="childteam nameDl" id="innerdl_'+list[i].deptId+'"></dl> */
                        str +='<ul id="innerDeptUl_'+list[i].deptId+'" class="innerUl"></ul></li>';

                        $("#innerDeptUl_"+list[i].parentDeptId).append(str);
                    }
                }
                fnObj.getDeptUserList();

            }else if(g_tabFlag == 'USER'){
                fnObj.getUserList();
            }

        }
        commonAjax("POST", url, param, callback, false, null, null);
   },

   //유저 그룹 리스트
   getUserGroupList : function(){

       var orgId = $("#selOrg").val();
       var url = contextRoot+"/common/getUserGroupList.do";
       var param = {
               applyOrgId  : orgId,
               enable      : 'Y'
       };

       var callback = function(result){

           var obj = JSON.parse(result);
           var cnt = obj.resultVal;        //결과수
           var list = obj.resultList;      //결과데이터JSON
           g_userGroupList = list;
           var allStr ='';
           if(isOneUser != 'Y' && isDeptSelect !='Y'){     //단일 유저 선택이아니면,
               allStr ='<div class="tnavi_title"><label><span>전체선택</span><input type="checkbox" id="allCheckBox" onclick="fnObj.allCheck(this);"></label></div>';

           }else{
               if(isDeptSelect !='Y') allStr ='<label><span>직원선택</span></label>';
               else allStr ='<label><span>부서선택</span></label>';
           }
           $("#allCheckArea").html(allStr);

           //--최상위 부서 그리드

           allStr ='';
           if(isDeptSelect != 'Y' && isUserSelectEabled !='N'){     //부서만 선택 옵션이 아니고, 유저 체크박스 선택 불가 가 아니면 탭생성

               allStr += '<ul style="border-top:none; border-right:none; ">';
               allStr += '<li id="tabZoneDept" class="current"><a href="#" onclick="fnObj.selectTabZone(\'DEPT\');" >부서별</a></li>';
               allStr += '<li id="tabZoneUser"><a href="#" onclick="fnObj.selectTabZone(\'USER\');" >직원별</a></li>';
               if(isUserGroup == "Y") {
                   allStr += '<li id="tabZoneGroup"><a href="#" onclick="fnObj.selectTabZone(\'GROUP\');" >그룹별</a></li>';
               }
               allStr += '</ul>';

               if(isUserGroup == "Y") $("#tabArea").attr("class", "tabZone_tree_list mn03");
               else $("#tabArea").attr("class", "tabZone_tree_list");

               $("#tabArea").show();
               $("#tabArea").html(allStr);
           }

           if(g_tabFlag == 'GROUP'){
               var str ='';
               for(var i =0;i<list.length;i++){
                   if(list[i].parentDeptId == 0){

                       str +='<li id="deptLi_'+list[i].deptId+'">';
                       str +='<div id="div_'+list[i].deptId+'"><label';

                       if(isOneDept == 'Y' && isDeptSelect == 'Y'){ //팀 하나만선택
                           str +=' id="deptLabel_'+list[i].deptId+'" onclick="fnObj.teamOnlySelect(\''+list[i].deptId+'\');">  ';
                       }else if(isOneDept != 'Y' && isDeptSelect == 'Y'){    //팀 다중선택
                           str +='>  ';
                           str +='<input type="checkbox" name="deptCheckBox"  id="deptCheck_'+list[i].deptId+'"  class="deptTop teamChk" value="'+list[i].deptId+'" onclick="fnObj.teamMultiSelect('+list[i].deptId+','+list[i].parentDeptId+',this);"> ';
                       }else{
                           str +='>  ';
                       }


                       if(isOneUser != 'Y' && isDeptSelect != 'Y'){        //단일 유저 선택이아니고 팀 하나만선택이 아니면
                           str +='<input type="checkbox" id="teamCheck_'+list[i].deptId+'"  class="deptTop teamChk" value="'+list[i].deptId+'" onclick="fnObj.checkDo('+list[i].deptId+',this,'+list[i].parentDeptId+');"> ';
                       }

                       str +='<i class="icon_pd"></i><span>'+list[i].deptNm+'</span></label>';
                       str +='</div>';
                       str += '<dl class="childteam" id="namedl_'+list[i].deptId+'"><dd><div id="name_'+list[i].deptId+'"></div></dd></dl>';

                       str +='<ul id="innerDeptUl_'+list[i].deptId+'" class="innerUl"></ul></li>';

                   }

               }

               $("#treeArea3").html(str);

               //--최상위 부서 이외 부서 그리드

               for(var i =0;i<list.length;i++){
                   str ='';
                   userStr = '';
                   if(list[i].parentDeptId != 0){

                       str +='<li id="deptLi_'+list[i].deptId+'">';
                       str +='<div id="div_'+list[i].deptId+'"><label';

                       if(isOneDept == 'Y' && isDeptSelect == 'Y'){ //팀 하나만선택
                           str +=' id="deptLabel_'+list[i].deptId+'"  onclick="fnObj.teamOnlySelect(\''+list[i].deptId+'\');">  ';
                       }else if(isOneDept != 'Y' && isDeptSelect == 'Y'){    //팀 다중선택
                           str +='>  ';
                           str +='<input type="checkbox" class="teamChk"  name="deptCheckBox"  id="deptCheck_'+list[i].deptId+'" onclick="fnObj.teamMultiSelect('+list[i].deptId+','+list[i].parentDeptId+',this);">';
                       }else{
                           str +='>  ';
                       }


                       if(isOneUser != 'Y'  && isDeptSelect != 'Y'){       //단일 유저 선택이아니면,
                           str +='<input type="checkbox" class="teamChk" id="teamCheck_'+list[i].deptId+'" onclick="fnObj.checkDo('+list[i].deptId+',this,'+list[i].parentDeptId+');">';
                       }

                       str +='<i class="icon_pd"></i><span>'+list[i].deptNm+'</span></label>';

                       str +='</div>';
                       str += '<dl class="childteam" id="namedl_'+list[i].deptId+'"><dd><div id="name_'+list[i].deptId+'"></div></dd></dl>';
                       ///* <dl class="childteam nameDl" id="innerdl_'+list[i].deptId+'"></dl> */
                       str +='<ul id="innerDeptUl_'+list[i].deptId+'" class="innerUl"></ul></li>';

                       $("#innerDeptUl_"+list[i].parentDeptId).append(str);

                   }
               }
               fnObj.getUserGroupDetailList();
           }
       }
       commonAjax("POST", url, param, callback, false, null, null);
  },

   //선택유저전체 리스트
   getAllUserList : function(){

        var url = contextRoot+"/common/getStaffListNameSort.do";
        var param = {
                mainYn      : 'Y' ,
                deptOrder   : 'Y' ,
                userStatus  : isEnable,
                userId      : g_selectUserStr,
                hasDeptTopLevel : hasDeptTopLevel
        };


        var callback = function(result){

            var obj = JSON.parse(result);
            var cnt = obj.resultVal;        //결과수
            var list = obj.resultList;      //결과데이터JSON
            g_selectUserList = list;
            console.log(g_selectUserList)

        }

        commonAjax("POST", url, param, callback, false, null, null);
   },

   //선택부서전체 리스트
   getAllDeptList : function(){

       var orgId = $("#selOrg").val();
        var url = contextRoot+"/common/getDeptList.do";
        var param = {
                applyOrgId  : orgId,
                enable      : isEnable,
                deptId      : g_selectUserStr,
                hasDeptTopLevel : hasDeptTopLevel
        };


        var callback = function(result){

            var obj = JSON.parse(result);
            var cnt = obj.resultVal;        //결과수
            var list = obj.resultList;      //결과데이터JSON
            g_selectDeptList = list;

        }

        commonAjax("POST", url, param, callback, false, null, null);
   },


   //유저 체크박스 세팅(부서별)
   getDeptUserList : function(){

        var orgId = $("#selOrg").val();
        var url = contextRoot+"/common/getStaffListNameSort.do";
        var param = {
                applyOrgId  : orgId,
                mainYn      : 'Y' ,
                deptOrder   : 'Y' ,
                userStatus  : isEnable,
                hasDeptTopLevel : hasDeptTopLevel,
                isAppoveLineAdd : isAppoveLineAdd
        };


        var callback = function(result){

            var obj = JSON.parse(result);
            var cnt = obj.resultVal;        //결과수
            var list = obj.resultList;      //결과데이터JSON
            g_userList = list;

            var disabledYn ='';
            if(isUserSelectEabled =='N'){
                disabledYn = 'disabled';
            }

            if(isDeptSelect !='Y'){
                for(var i = 0;i<list.length;i++){
                    var str ='';
                    var userDisabled ='';
                    var isOnclick ='onclick="fnObj.setSelectList('+list[i].userId+',\'\',\''+list[i].id+'\');"';        //단일 선택일때 disable 리스트에서 사원 클릭 옵션 제거

                    var isIconCir ='';                                                          //단일 선택일때 disable 리스트에 있으면 off 추가

					var chk = true;

                	if(isAppoveLineAdd == 'Y' && list[i].orgId != orgId ) chk = false;


                    if(chk){
	                    //사원 체크박스
	                    str+='<label ';
	                    var styleCursor = "";

	                    for(var k = 0;k<g_disabledList.length;k++){
	                        if(g_disabledList[k] ==list[i].userId ){
	                            userDisabled = ' disabled';
	                            if(isOneUser =='Y'){
	                                isOnclick =''; isIconCir =' off';
	                                styleCursor = ' style="cursor : auto"';
	                            }

	                        }

	                    }

	                    str+= isOnclick;

	                    if(isOneUser != 'Y'){       //단일 유저 선택이아니면,
	                        str+= styleCursor + ' ><input type="checkbox" name="userCheckBox" id="userCheck_'+list[i].userId+'" value="'+list[i].userId+'" '+disabledYn+' '+userDisabled+' >';
	                    }else{
	                        str+=' id="userLabel_'+list[i].userId+'" ' + styleCursor + '>';
	                    }

	                    str+= '<i class="icon_cir '+isIconCir+'"></i><span class="t_name">';
	                    str+= "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].userId+"\",$(this),\"rClick\",null,0,-80,75)'>"+ list[i].userName+'</span></span></label>';

	                    $("#name_"+list[i].deptId).append(str);     //해당팀에 이름 세팅
                    }

                }
            }

            if(isDeptSelect != 'Y'){ //유저인경우만 처리
                var innerUlList = $(".innerUl");
                for(var i=0;i<innerUlList.length;i++){
                    if($(innerUlList[i]).find('.t_name').length == 0){
                        $(innerUlList[i]).remove();
                    }
                }
            }


            var dlList = $(".nameDl");
            for(var i=0;i<dlList.length;i++){
                if($(dlList[i]).find('.t_name').length == 0){
                    $(dlList[i]).remove();
                }
            }

            // Tree Navigation
            var tNav = $('.treeShape_st');
            var tNavPlus = '\<button type=\"button\" class=\"tNavToggle plus\"\>+\<\/button\>';
            var tNavMinus = '\<button type=\"button\" class=\"tNavToggle minus\"\>-\<\/button\>';
            tNav.find('li>ul').css('display','none');
            tNav.find('ul>li:last-child').addClass('last');
            tNav.find('li>ul:hidden').parent('li').prepend(tNavPlus);
            tNav.find('li>ul:visible').parent('li').prepend(tNavMinus);
            //tNav.find('li.active').addClass('open').parents('li').addClass('open');
            tNav.find('li').addClass('open').parents('li').addClass('open');
            tNav.find('li.open').parents('li').addClass('open');
            tNav.find('li.open>.tNavToggle').text('-').removeClass('plus').addClass('minus');
            tNav.find('li.open>ul').slideDown(100);
            $('.treeShape_st .tNavToggle').click(function(){
                t = $(this);
                t.parent('li').toggleClass('open');
                if(t.parent('li').hasClass('open')){

                    t.text('-').removeClass('plus').addClass('minus');
                    t.parent('li').find('>ul').slideDown(100);
                    t.parent('li').find('>dl').slideDown(100);
                } else {
                    t.text('+').removeClass('minus').addClass('plus');
                    t.parent('li').find('>dl').slideUp(100);
                    t.parent('li').find('>ul').slideUp(100);
                }
                return false;
            });
            $('.treeShape_st a[href=#]').click(function(){
                t = $(this);
                t.parent('li').toggleClass('open');
                if(t.parent('li').hasClass('open')){
                    t.prev('button.tNavToggle').text('-').removeClass('plus').addClass('minus');
                    t.parent('li').find('>ul').slideDown(100);
                } else {
                    t.prev('button.tNavToggle').text('+').removeClass('minus').addClass('plus');
                    t.parent('li').find('>ul').slideUp(100);
                }
                return false;
            });


        }

        commonAjax("POST", url, param, callback, false, null, null);
  },

  //유저 체크박스 세팅(유저그룹별)
  getUserGroupDetailList : function(){

       var orgId = $("#selOrg").val();
       var url = contextRoot+"/common/getUserGroupDetailList.do";
       var param = {
               applyOrgId  : orgId,
               mainYn      : 'Y' ,
               deptOrder   : 'Y' ,
               userStatus  : isEnable
       };

       var callback = function(result){

           var obj = JSON.parse(result);
           var cnt = obj.resultVal;        //결과수
           var list = obj.resultList;      //결과데이터JSON
           g_userList = list;

           //console.log(g_userList);
           var disabledYn ='';
           if(isUserSelectEabled =='N'){
               disabledYn = 'disabled';
           }
           if(isDeptSelect !='Y'){
               for(var i = 0;i<list.length;i++){
                   var str ='';
                   var userDisabled ='';
                   //var isOnclick ='onclick="fnObj.setSelectList('+list[i].userId+');"';        //단일 선택일때 disable 리스트에서 사원 클릭 옵션 제거
                   var isOnclick ='onclick="fnObj.setSelectList('+list[i].userId+',\'\',\''+list[i].id+'\');"';     //단일 선택일때 disable 리스트에서 사원 클릭 옵션 제거

                   var isIconCir ='';                                                          //단일 선택일때 disable 리스트에 있으면 off 추가

                   //사원 체크박스
                   str+='<label ';

                   var styleCursor = "";
                   for(var k = 0;k<g_disabledList.length;k++){
                       if(g_disabledList[k] ==list[i].userId ){
                           userDisabled = ' disabled';
                           if(isOneUser =='Y'){
                               isOnclick ='';
                               isIconCir =' off';
                               styleCursor = ' style="cursor : auto"';
                           }

                       }

                   }

                   if(list[i].authOrgYn =='N'){
                       isOnclick ='';
                       isIconCir =' off';  //접속권한이 없는 유저는 비활성화
                       styleCursor = ' style="cursor : auto"';
                       userDisabled = 'disabled';
                   }

                   str+= isOnclick;

                   if(list[i].authOrgYn =='N' && isOneUser != 'Y'){
                       str+= styleCursor + '><input type="checkbox" name="userCheckBox" id="userCheck_'+list[i].userId+'" value="'+list[i].userId+'" '+disabledYn+' '+userDisabled+' >';
                   }else if(isOneUser != 'Y'){       //단일 유저 선택이아니면,
                       str+= styleCursor + '><input type="checkbox" name="userCheckBox" id="userCheck_'+list[i].userId+'" value="'+list[i].userId+'" '+disabledYn+' '+userDisabled+' >';
                   }else{
                       str+=' id="userLabel_'+list[i].id+'" ' + styleCursor + '>';
                   }

                   str+= '<i class="icon_cir '+isIconCir+'"></i><span class="t_name">'
                   str+=  "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].userId+"\",$(this),\"rClick\",null,0,-80,75)'>"+list[i].userName+'</span></span></label>';

                   $("#name_"+list[i].deptId).append(str);     //해당팀에 이름 세팅

               }
           }
           var innerUlList = $(".innerUl");
           for(var i=0;i<innerUlList.length;i++){
               if($(innerUlList[i]).find('.t_name').length == 0){
                   $(innerUlList[i]).remove();
               }
           }

           var dlList = $(".nameDl");
           for(var i=0;i<dlList.length;i++){
               if($(dlList[i]).find('.t_name').length == 0){
                   $(dlList[i]).remove();
               }
           }

           // Tree Navigation
           var tNav = $('.treeShape_userGroup');
           var tNavPlus = '\<button type=\"button\" class=\"tNavToggle plus\"\>+\<\/button\>';
           var tNavMinus = '\<button type=\"button\" class=\"tNavToggle minus\"\>-\<\/button\>';
           tNav.find('li>ul').css('display','none');
           tNav.find('ul>li:last-child').addClass('last');
           tNav.find('li>ul:hidden').parent('li').prepend(tNavPlus);
           tNav.find('li>ul:visible').parent('li').prepend(tNavMinus);
           //tNav.find('li.active').addClass('open').parents('li').addClass('open');
           tNav.find('li').addClass('open').parents('li').addClass('open');
           tNav.find('li.open').parents('li').addClass('open');
           tNav.find('li.open>.tNavToggle').text('-').removeClass('plus').addClass('minus');
           tNav.find('li.open>ul').slideDown(100);
           $('.treeShape_userGroup .tNavToggle').click(function(){
               t = $(this);
               t.parent('li').toggleClass('open');
               if(t.parent('li').hasClass('open')){

                   t.text('-').removeClass('plus').addClass('minus');
                   t.parent('li').find('>ul').slideDown(100);
                   t.parent('li').find('>dl').slideDown(100);
               } else {
                   t.text('+').removeClass('minus').addClass('plus');
                   t.parent('li').find('>dl').slideUp(100);
                   t.parent('li').find('>ul').slideUp(100);
               }
               return false;
           });
           $('.treeShape_userGroup a[href=#]').click(function(){
               t = $(this);
               t.parent('li').toggleClass('open');
               if(t.parent('li').hasClass('open')){
                   t.prev('button.tNavToggle').text('-').removeClass('plus').addClass('minus');
                   t.parent('li').find('>ul').slideDown(100);
               } else {
                   t.prev('button.tNavToggle').text('+').removeClass('minus').addClass('plus');
                   t.parent('li').find('>ul').slideUp(100);
               }
               return false;
           });

       }

       commonAjax("POST", url, param, callback, false, null, null);
 },


  //유저 체크박스 세팅(직원별)
  getUserList : function(){

        var orgId = $("#selOrg").val();
        var url = contextRoot+"/common/getStaffListNameSort.do";
        var param = {
                applyOrgId  : orgId,
                mainYn      : 'Y' ,
                userStatus  : isEnable,
                hasDeptTopLevel : hasDeptTopLevel,
                isDeptSelect	: isDeptSelect,
                isAppoveLineAdd : isAppoveLineAdd
        };


        var callback = function(result){

            var obj = JSON.parse(result);
            var cnt = obj.resultVal;        //결과수
            var list = obj.resultList;      //결과데이터JSON
            g_userList = list;

            if(isDeptSelect !='Y'){

                var str ='';
                var approveAreaStr = '';
                var cnt1 = 0;
                var cnt2 = 0;

                for(var i = 0;i<list.length;i++){

                	if(isAppoveLineAdd == 'Y'){
                		if(list[i].orgId == orgId || list[i].deptLevel == 'L00'){
                   			str += fnObj.userNameDivSet(list[i]);
                   			cnt1++;

                   			if(cnt1%2 == 1) str+= '</li>';

                   		}else{

                   			approveAreaStr += fnObj.userNameDivSet(list[i]);
                   			cnt2++;

                   			if(cnt2%2 == 1 && i<list.length-1) approveAreaStr+= '</li>';
                   		}



                		if(i<list.length-1) approveAreaStr+= '</li>';

                	}else{
                		str += fnObj.userNameDivSet(list[i]);
                		if(i%2 == 1 && i<list.length-1) str+= '</li>';
                	}

                }

                if(cnt2 > 0 ) approveAreaStr='<li style="clear: both; width:90%; padding-top: 10px;margin-top: 10px; border-top: 1px dashed #b3aeae;"></li>'+approveAreaStr;

                $("#treeArea2").html(str + approveAreaStr);

            }
        }

        commonAjax("POST", url, param, callback, false, null, null);
  },


  userNameDivSet : function(obj){

	  var disabledYn ='';
      if(isUserSelectEabled =='N'){
          disabledYn = 'disabled';
      }

	  var str ='';
	  var userDisabled ='';
      //var isOnclick ='onclick="fnObj.setSelectList('+list[i].userId+');"';      //단일 선택일때 disable 리스트에서 사원 클릭 옵션 제거
      var isOnclick ='onclick="fnObj.setSelectList('+obj.userId+',\'\',\''+obj.id+'\');"';       //단일 선택일때 disable 리스트에서 사원 클릭 옵션 제거

      var isIconCir ='';                                                          //단일 선택일때 disable 리스트에 있으면 off 추가


      //사원 체크박스
      str+='<li><label ';

      for(var k = 0;k<g_disabledList.length;k++){
          if(g_disabledList[k] ==obj.userId ){
              userDisabled = ' disabled';
              if(isOneUser =='Y') isOnclick =''; isIconCir =' off';

          }

      }

      str+= isOnclick;

      if(isOneUser != 'Y'){       //단일 유저 선택이아니면,
          str+='><input type="checkbox" class="userBox" name="userCheckBox" id="userCheck_'+obj.userId+'" value="'+obj.userId+'" '+disabledYn+' '+userDisabled+' >';
      }else{
          str+='id="userLabel_'+obj.userId+'"><i class="icon_cir '+isIconCir+'"></i>';
      }

      str+= '<span class="t_name">';
      str+= "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+obj.userId+"\",$(this),\"rClick\",null,0,-80,75)'>"+ obj.userName+'</span></span></label>';

	  return str;
  },


  //최초 팝업 접근시 체크 세팅.
  initCheckSet : function(){
      if(isDeptSelect != 'Y'){      //직원 선택
          for(var i=0;i<g_selectUserList.length;i++){

            if(isOneUser != 'Y'){   //유저 다중선택
                $("#userCheck_"+g_selectUserList[i].userId).prop("checked",true);
                resultList.push(g_selectUserList[i]);

            }else{                  //유저 단일선택

                resultList = [];
                resultList.push(g_selectUserList[i]);
                $("#userLabel_"+g_selectUserList[i].userId).addClass('selectUserDis');
            }

          }
      }else{                        //부서선택
          //resultList = [];
          for(var i=0;i<g_selectDeptList.length;i++){

            if(isOneDept != 'Y'){   //유저 다중선택
                $("#deptCheck_"+g_selectDeptList[i].deptId).prop("checked",true);
                resultList.push(g_selectDeptList[i]);

            }else{                  //유저 단일선택

                resultList = [];
                resultList.push(g_selectDeptList[i]);
                $("#deptLabel_"+g_selectDeptList[i].deptId).addClass('selectDeptDis');
            }

          }

      }

      myGrid.setGridData({              //그리드 데이터 세팅    *** 2 ***
            list: resultList            //그리드 테이터

      });

      mySorting.applySortIcon();        //소팅화면적용
      myGrid.refresh();

      $("#selectCount").html('<strong>전체</strong><em>'+resultList.length+'</em>건');
      if(isDeptSelect != 'Y') fnObj.checkParent();      //부모 체크박스 세팅
  },

  //org 변경시 체크 세팅,resultList가 선택이되있고, org간에 셀렉트가 가능할때만.. 그리고 탭변경시
  saveCheckSet : function(){

     for(var i=0;i<resultList.length;i++){
         $("input[name=userCheckBox]:checkbox").each(function() {
             if($(this).attr("id") == "userCheck_"+resultList[i].userId){
                 $(this).prop("checked",true);
             }
         });
        //$("#userCheck_"+resultList[i].userId).prop("checked",true);
     }

     if(g_tabFlag == 'DEPT') {
         fnObj.checkParent();                       //현재 탭이 부서별일때
     }else if(g_tabFlag == 'USER') {
         fnObj.checkAllYn();
     }else if(g_tabFlag == 'GROUP') {
         fnObj.checkParentUserGroup();
     }

     if(isOneUser == 'Y'){                                              //단일선택
         for(var i=0;i<g_userList.length;i++){
             var isSelected = false;
             for(var k=0;k<resultList.length;k++){
                 if(g_tabFlag == 'GROUP'){
                     if(resultList[k].userId ==g_userList[i].userId) {
                         $("#userLabel_"+g_userList[i].id).addClass('selectUserDis');
                         isSelected = true;
                         break;
                     }
                 }else{
                     if(resultList[k].userId ==g_userList[i].userId) {
                         $("#userLabel_"+resultList[k].userId).addClass('selectUserDis');
                     }
                 }
             }
             if(isSelected) break;
         }
     }

  },

  //탭 변경시
  selectTabZone : function(type,changType){

      g_tabFlag = type;         //현재 탭 타입을 글로벌 변수로 설정

      $("#approveTreeArea").empty();   //트리 그리드 초기화
      $("#treeArea").empty();   //트리 그리드 초기화
      $("#treeArea2").empty();  //트리 그리드 초기화
      $("#treeArea3").empty(); //트리 그리드 초기화
      $("#tabArea").empty();    //탭그리드 초기화


      //-- 부서별, 직원별 탭 디자인 변경
      if(type == 'DEPT'){       //탭이 부서별일때
          fnObj.getDeptList();        //부서리스트 -> 사원리스트 세팅
          if(isAppoveLineAdd == 'Y' && isDeptSelect != 'Y') fnObj.setApproveLine();

          $('#tabZoneDept').addClass('current');
          $('#tabZoneUser').removeClass('current');
          $('#tabZoneGroup').removeClass('current');

          $('.treeShape_st').show();
          $('.allmem_array_list').hide();
          $('.treeShape_userGroup').hide();

      }else if(type == 'USER'){
          fnObj.getDeptList();        //부서리스트 -> 사원리스트 세팅

          $('#tabZoneDept').removeClass('current');
          $('#tabZoneUser').addClass('current');
          $('#tabZoneGroup').removeClass('current');

          $('.treeShape_st').hide();
          $('.allmem_array_list').show();
          $('.treeShape_userGroup').hide();
      }if(type == 'GROUP'){
          fnObj.getUserGroupList();

          $('#tabZoneDept').removeClass('current');
          $('#tabZoneUser').removeClass('current');
          $('#tabZoneGroup').addClass('current');

          $('.treeShape_st').hide();
          $('.allmem_array_list').hide();
          $('.treeShape_userGroup').show();
      }

      if(changType != 'ORG') fnObj.saveCheckSet();      //탭 변경 전 선택된 리스트 세팅

    //유저프로필 이벤트 셋팅
  	initUserProfileEvent();

  	closeUserProfileBox();

  	$("body").attr("oncontextmenu","return false");
  },

  //전체선택 클릭시
  allCheck : function(th){
      for(var i=0; i<g_userList.length; i++){

          if($(th).is(":checked")){             //전체선택 체크되어있다

              if(isCheckDisable == 'N'){        //disable 된것 조작 불가면
                  if($("#userCheck_"+g_userList[i].userId).is(":disabled")) continue;
                  else{
                      $("input[name=userCheckBox]:checkbox").each(function() {
                             if($(this).attr("id") == "userCheck_"+g_userList[i].userId){
                                 $(this).prop("checked",true);
                             }
                          });
                      //$("#userCheck_"+g_userList[i].userId).prop("checked",true);
                  }
              }else{
                  $("input[name=userCheckBox]:checkbox").each(function() {
                     if($(this).attr("id") == "userCheck_"+g_userList[i].userId){
                         $(this).prop("checked",true);
                     }
                  });
                  //$("#userCheck_"+g_userList[i].userId).prop("checked",true);
              }

          }else{                                //전체선택 체크 해제 상태이다
             if(isCheckDisable == 'N'){         //disable 된것 조작 불가면

                 if($("#userCheck_"+g_userList[i].userId).is(":disabled")){
                     continue;
                 }else{
                     $("input[name=userCheckBox]:checkbox").each(function() {
                         if($(this).attr("id") == "userCheck_"+g_userList[i].userId ){
                             $(this).prop("checked",false);
                         }
                     });
                     //$("#userCheck_"+g_userList[i].userId).prop("checked",false);
                 }
             }else{
                 $("input[name=userCheckBox]:checkbox").each(function() {
                     if($(this).attr("id") == "userCheck_"+g_userList[i].userId ){
                         $(this).prop("checked",false);
                     }
                 });
                 //$("#userCheck_"+g_userList[i].userId).prop("checked",false);
             }
          }

         fnObj.setSelectList(g_userList[i].userId,'',g_userList[i].id);     //for 문을 돌며 user 하나하나 리스트에 담음
      }

    //유저프로필 이벤트 셋팅
  	initUserProfileEvent();
  },

  //부모 체크박스 선택
  checkDo : function(deptId,th,parentId){

      if($(th).is(":checked")){     //현재 체크 누름

         if(isCheckDisable == 'N'){     //disable 된것 조작 불가면
            $('#deptLi_'+deptId).find('input:checkbox').not(":disabled").prop("checked",true);
         }else{
             $('#deptLi_'+deptId).find('input:checkbox').prop("checked",true);
         }

      }else{


         if(isCheckDisable == 'N'){     //disable 된것 조작 불가면
             $('#deptLi_'+deptId).find('input:checkbox').not(":disabled").prop("checked",false);
         }else{
             $('#deptLi_'+deptId).find('input:checkbox').prop("checked",false);
         }

      }
      var checkList = [];

      if(parentId !=0) checkList = $('#innerDeptUl_'+parentId).find('input:checkbox');      //부모가 있는 자식노드의 팀일때, 부모안에 모든 체크박스를 찾음
      else checkList = $('#deptLi_'+deptId).find('input:checkbox').not('.teamChk');     //부모가 없을때는 부서안에 모든 체크박스를 찾음 부서체크박스 제외


      for(var i=0;i<checkList.length;i++){
         fnObj.setSelectList(checkList[i].value,'',checkList[i].value);     //for 문을 돌며 user 하나하나 리스트에 담음
      }
	    //유저프로필 이벤트 셋팅
	  	initUserProfileEvent();
  },

  //선택될때마다 리스트에 추가한다.
  setSelectList : function(userId,type,id){
      if(isOneUser != 'Y'){     //사원 다중선택
          var isChecked = false;
          $("input[name=userCheckBox]:checkbox").each(function() {
              if($(this).attr("id") == "userCheck_"+userId && $(this).prop("checked")){
                  isChecked = true;
              }
          });
          if(isChecked){      //현재 체크 누름
              for(var i=0;i<g_userList.length;i++){
                  if(userId ==g_userList[i].userId && getCountWithValue(resultList, 'userId', userId)==0){     //선택안된 유저만 담음
                      resultList=addToArray(resultList, 0, g_userList[i]);
                  }
              }
          }else{                                            //체크 해제
              if(getCountWithValue(resultList, 'userId', userId)>0){                   //유저가 있으면
                  resultList.remove(getRowIndexWithValue(resultList, 'userId', userId));  //선택유저리스트에서 제거
                }
                $("#allCheckBox").prop("checked",false);      //전체선택 체크박스 해제
          }

      }else{                    //사원 단일 선택

          $(".selectUserDis").removeClass();                //선택된 표시 전무 제거
          for(var i=0;i<g_userList.length;i++){
              if(g_tabFlag == "GROUP"){
                  if(id ==g_userList[i].id){
                      resultList =[];                           //단일 선택이니, 선택리스트 초기화 어짜피 하나만 담기니..
                      if(type != 'del'){                        //선택이라면
                          resultList.push(g_userList[i]);
                          $("#userLabel_"+id).addClass('selectUserDis');
                      }else{
                          $("#userLabel_"+id).removeClass('selectUserDis');
                      }
                  }
              }else{
                  if(userId ==g_userList[i].userId){
                      resultList =[];                           //단일 선택이니, 선택리스트 초기화 어짜피 하나만 담기니..
                      if(type != 'del'){                        //선택이라면
                          resultList.push(g_userList[i]);
                          $("#userLabel_"+userId).addClass('selectUserDis');
                      }else{
                          $("#userLabel_"+userId).removeClass('selectUserDis');
                      }
                  }
              }

          }
      }

      myGrid.setGridData({              //그리드 데이터 세팅    *** 2 ***
            list: resultList            //그리드 테이터
        });

      mySorting.applySortIcon();        //소팅화면적용

      $("#selectCount").html('<strong>전체</strong><em>'+resultList.length+'</em>건');

      if(isOneUser != 'Y' && g_tabFlag == 'DEPT') fnObj.checkParent();  //부서별 탭이고, 유저 다중선택이면 -> 부모(팀) 체크박스 세팅
      else if(g_tabFlag == 'USER') fnObj.checkAllYn();                  //사원별 탭일때, 전체 체크박스만 세팅
      else if(isOneUser != 'Y' && g_tabFlag == 'GROUP') fnObj.checkParentUserGroup();

    //유저프로필 이벤트 셋팅
  	initUserProfileEvent();
  },

  //부모 체크박스 체크 세팅
  checkParent : function(){

      var deptList = g_deptList.clone();

      sortByKey(deptList, 'levelSeq', 'DESC');  //레벨(depth)이 낮은 부서부터 체크

      for(var i =0;i<deptList.length;i++){
            var deptId = deptList[i].deptId;
            var parentDeptId = deptList[i].parentDeptId;
            var name = deptList[i].name;
            var levelSeq = deptList[i].deptOrder;

            var topTeam = parseInt($('#deptLi_'+deptId).find('input:checkbox').length);                         //부서 안에 영역의 체크박스 사원 + 팀명
            var notDisabledTopTeam = parseInt($('#deptLi_'+deptId).find('input:checkbox').not(':disabled').length); //disable 아닌  길이

            var teamChk = parseInt($('#innerDeptUl_'+deptId).find('input:checkbox:checked').length);        //(2depth 이상)부서 안에 체크된 길이
            var teamChkNotDisable = parseInt($('#innerDeptUl_'+deptId).find('input:checkbox:checked').not(':disabled').length);//(2depth 이상)부서 안에 disable 이 아니며 체크된 길이


            var nameChkNotDisable = parseInt($('#namedl_'+deptId).find('input:checkbox:checked').not(':disabled').length);  //부서 하나의 사용자 disable 이 아니며 체크된 갯수
            var nameChk = parseInt($('#namedl_'+deptId).find('input:checkbox:checked').length);                 //부서 하나의 사용자 체크된 갯수


            if(isCheckDisable == 'N'){      //diable 일때, 체크박스 선택 불가능 이다..

                if(topTeam-1>0){            //부서 체크박스 제외하고 안에 체크박스가 있으면(유저든, 하위 팀이든)

                    //-- 부서안에 모든 체크박스 중 disable 이 아닌 체크박스의 길이 -1(부서체크박스) 와
                    //-- 그 부서의 사용자 체크박스 중 disable 아니고 체크되어있는 체크박스 갯수 + 부서안에 체크박스 되어있는 길이가 같으면
                    //-- 2depth 구조일경우 최상위로 묶인 li 안에 최상위 팀 체크박스 제외, + disalbe  제외 == 최상위 안에 사원 체크박스(disalbe 미포함) + 하위 팀이 묶인 ul 안에 체크박스(disalbe 미포함)
                    //-- 즉, disable 을 제외한 모든 체크박스가 체크되있다.

                    if(notDisabledTopTeam-1 == nameChkNotDisable+teamChk ){
                      $('#deptLi_'+deptId).find('input:checkbox').not(':disabled').prop("checked",true);

                    }else{
                      $('#div_'+deptId).find('input:checkbox').not(':disabled').prop("checked",false);

                    }

                }else{      //부서안에 아무것도 없을때
                    $('#deptLi_'+deptId).find('input:checkbox').prop("disabled",true);
                    $('#deptLi_'+deptId).find('input:checkbox').prop("checked",false);
                }
            }else{      //disable 함께 조작 가능이면

                if(topTeam-1>0){

                    //-- disable 상관 안함.

                    if(topTeam-1 == nameChk+ teamChk ){     //부서안에 모든 체크박스가 체크되어있으면
                          $('#deptLi_'+deptId).find('input:checkbox').not(':disabled').prop("checked",true);
                    }else{
                          $('#div_'+deptId).find('input:checkbox').not(':disabled').prop("checked",false);

                    }

                  }else{        //부서안에 아무것도 없을때
                      if(isOneDept == 'Y'){
                          $('#deptLi_'+deptId).find('input:checkbox').prop("disabled",true);
                          $('#deptLi_'+deptId).find('input:checkbox').prop("checked",false);
                      }

                 }
            }


      }

      //-- 전체 선택 세팅
      var boxList =$('.deptTop');
      var disList =$('.deptTop:disabled');
      var checkList =$('.deptTop:checked');

      if((boxList.length-disList.length) == checkList.length){
          $("#allCheckBox").prop("checked",true);

      }

  },

  //부모 체크박스 체크 세팅
  checkParentUserGroup : function(){

      var deptList = g_userGroupList.clone();

      sortByKey(deptList, 'levelSeq', 'DESC');  //레벨(depth)이 낮은 부서부터 체크

      for(var i =0;i<deptList.length;i++){
            var deptId = deptList[i].deptId;
            var parentDeptId = deptList[i].parentDeptId;
            var name = deptList[i].name;
            var levelSeq = deptList[i].deptOrder;

            var topTeam = parseInt($('#deptLi_'+deptId).find('input:checkbox').length);                         //부서 안에 영역의 체크박스 사원 + 팀명
            var notDisabledTopTeam = parseInt($('#deptLi_'+deptId).find('input:checkbox').not(':disabled').length); //disable 아닌  길이

            var teamChk = parseInt($('#innerDeptUl_'+deptId).find('input:checkbox:checked').length);        //(2depth 이상)부서 안에 체크된 길이
            var teamChkNotDisable = parseInt($('#innerDeptUl_'+deptId).find('input:checkbox:checked').not(':disabled').length);//(2depth 이상)부서 안에 disable 이 아니며 체크된 길이


            var nameChkNotDisable = parseInt($('#namedl_'+deptId).find('input:checkbox:checked').not(':disabled').length);  //부서 하나의 사용자 disable 이 아니며 체크된 갯수
            var nameChk = parseInt($('#namedl_'+deptId).find('input:checkbox:checked').length);                 //부서 하나의 사용자 체크된 갯수


            if(isCheckDisable == 'N'){      //diable 일때, 체크박스 선택 불가능 이다..

                if(topTeam-1>0){            //부서 체크박스 제외하고 안에 체크박스가 있으면(유저든, 하위 팀이든)

                    //-- 부서안에 모든 체크박스 중 disable 이 아닌 체크박스의 길이 -1(부서체크박스) 와
                    //-- 그 부서의 사용자 체크박스 중 disable 아니고 체크되어있는 체크박스 갯수 + 부서안에 체크박스 되어있는 길이가 같으면
                    //-- 2depth 구조일경우 최상위로 묶인 li 안에 최상위 팀 체크박스 제외, + disalbe  제외 == 최상위 안에 사원 체크박스(disalbe 미포함) + 하위 팀이 묶인 ul 안에 체크박스(disalbe 미포함)
                    //-- 즉, disable 을 제외한 모든 체크박스가 체크되있다.

                    if(notDisabledTopTeam-1 == nameChkNotDisable+teamChk ){
                      $('#deptLi_'+deptId).find('input:checkbox').not(':disabled').prop("checked",true);

                    }else{
                      $('#div_'+deptId).find('input:checkbox').not(':disabled').prop("checked",false);

                    }

                }else{      //부서안에 아무것도 없을때
                    $('#deptLi_'+deptId).find('input:checkbox').prop("disabled",true);
                    $('#deptLi_'+deptId).find('input:checkbox').prop("checked",false);
                }
            }else{      //disable 함께 조작 가능이면

                if(topTeam-1>0){

                    //-- disable 상관 안함.

                    if(topTeam-1 == nameChk+ teamChk ){     //부서안에 모든 체크박스가 체크되어있으면
                          $('#deptLi_'+deptId).find('input:checkbox').not(':disabled').prop("checked",true);
                    }else{
                          $('#div_'+deptId).find('input:checkbox').not(':disabled').prop("checked",false);

                    }

                  }else{        //부서안에 아무것도 없을때
                     $('#deptLi_'+deptId).find('input:checkbox').prop("disabled",true);
                     $('#deptLi_'+deptId).find('input:checkbox').prop("checked",false);
                 }
            }


      }

      //-- 전체 선택 세팅
      var boxList =$('.deptTop');
      var disList =$('.deptTop:disabled');
      var checkList =$('.deptTop:checked');

      if((boxList.length-disList.length) == checkList.length){
          $("#allCheckBox").prop("checked",true);

      }

  },

  //--- 전체박스 체크 판별 (탭이 직원별일때 로직)
  checkAllYn : function(){
      var boxList =$('.userBox');
      var disList =$('.userBox:disabled');
      var checkList =$('.userBox:checked').not(':disabled');
      var checkAllList =$('.userBox:checked');

      if((boxList.length-disList.length) == checkList.length){
          $("#allCheckBox").prop("checked",true);

      }
  },

  //팀 단일 선택
  teamOnlySelect : function(deptId){
      $(".selectDeptDis").removeClass();

      resultList =[];
      for(var i=0;i<g_deptList.length;i++){
          if(deptId == g_deptList[i].deptId){
              resultList.push(g_deptList[i]);
              $("#deptLabel_"+deptId).addClass('selectDeptDis');
          }
      }


      myGrid.setGridData({              //그리드 데이터 세팅    *** 2 ***
            list: resultList            //그리드 테이터
        });

      mySorting.applySortIcon();        //소팅화면적용

      $("#selectCount").html('<strong>전체</strong><em>'+resultList.length+'</em>건');
  },

  //팀 다중선택
  teamMultiSelect : function(deptId,parentId,th){
      var isChecked = false;
      $("input[name=deptCheckBox]:checkbox").each(function() {
          if($(this).attr("id") == "deptCheck_"+deptId && $(this).prop("checked")){
              isChecked = true;
          }
      });
      if(isChecked){      //현재 체크 누름
          for(var i=0;i<g_deptList.length;i++){
              if(deptId ==g_deptList[i].deptId && getCountWithValue(resultList, 'deptId', deptId)==0){     //선택안된 유저만 담음
                  resultList=addToArray(resultList, 0, g_deptList[i]);
              }
          }
      }else{                                            //체크 해제
          if(getCountWithValue(resultList, 'deptId', deptId)>0){                   //유저가 있으면
              resultList.remove(getRowIndexWithValue(resultList, 'deptId', deptId));  //선택유저리스트에서 제거
            }
            $("#allCheckBox").prop("checked",false);      //전체선택 체크박스 해제
      }

      myGrid.setGridData({              //그리드 데이터 세팅    *** 2 ***
          list: resultList            //그리드 테이터
      });

    mySorting.applySortIcon();        //소팅화면적용

    $("#selectCount").html('<strong>전체</strong><em>'+resultList.length+'</em>건');

    /* if(isOneDept != 'Y' && g_tabFlag == 'DEPT') fnObj.checkParent();  //부서별 탭이고, 유저 다중선택이면 -> 부모(팀) 체크박스 세팅
    else if(g_tabFlag == 'USER') fnObj.checkAllYn();                  //사원별 탭일때, 전체 체크박스만 세팅
    else if(isOneDept != 'Y' && g_tabFlag == 'GROUP') fnObj.checkParentUserGroup(); */
  },

  //사용자 선택 빼기(-버튼)
  delUser: function(userId,id){
    if(isDeptSelect !='Y'){
        if(isOneUser != 'Y'){
            $("input[name=userCheckBox]:checkbox").each(function() {
                 if($(this).attr("id") == "userCheck_"+userId ){
                     $(this).prop("checked",false);
                 }
             });
            //$("#userCheck_"+userId).prop("checked",false);
        }
        fnObj.setSelectList(userId,'del',id);
    }else{
        if(isOneDept != 'Y'){
            $("input[name=deptCheckBox]:checkbox").each(function() {
                 if($(this).attr("id") == "deptCheck_"+userId ){
                     $(this).prop("checked",false);
                 }
             });
            //$("#userCheck_"+userId).prop("checked",false);
        }
        fnObj.teamMultiSelect(userId,id);
         /* resultList =[];
         $(".selectDeptDis").removeClass();
         myGrid.setGridData({               //그리드 데이터 세팅    *** 2 ***
            list: resultList            //그리드 테이터
        });
        $("#selectCount").html('<strong>전체</strong><em>'+resultList.length+'</em>건'); */
    }

  },

  //선택완료
  selectFinish : function(){

      if(resultList.length == 0){
        dialog.push({body:"<b>확인!</b> "+(isDeptSelect == "Y" ? "부서를" : "사원을")+" 선택해주세요!", type:"", onConfirm:function(){}});
        return;
     }
     if(parent.myModal != undefined){
         parent.fnObj.getResult(resultList,g_parentKey);    //부모창에 getResult 와 받은 키값을 넘겨준다.

     }else{
         opener.fnObj.getResult(resultList,g_parentKey);
     }

     if(isCloseBySelect == 'Y'){            //선택과동시에 창닫기가 아니면
        if(parent.myModal != undefined){
            parent.myModal.close();     //창 닫기
        }else{
         window.close();
        }
     }

  },

  //--------------------------결재라인 추가 : S

  setApproveLine : function(){


	  var list = g_deptList;
	  var orgId = $("#selOrg").val();
	  var beforeOrgId = '';


	  if(g_tabFlag == 'DEPT'){
          var str ='';
          for(var i =0;i<list.length;i++){

        	  if(list[i].teamOrgId != beforeOrgId && list[i].teamOrgId != orgId){

                  str +='<div><label>';

                  str +='<i class="icon_pd" style="height: 14px;"></i><span>'+list[i].orgNm+'</span></label>';
                  str +='</div>';
                  str += '<dl class="childteam"><dd><div></div></dd></dl>';

                  str +='<ul class="innerUl"></ul>';
        	  }


              if(list[i].parentDeptId == 0 && list[i].teamOrgId != orgId){

                  str +='<li id="deptLi_'+list[i].deptId+'"  class="topTeamLi">';
                  str +='<div id="div_'+list[i].deptId+'"><label';

                  if(isOneDept == 'Y' && isDeptSelect == 'Y'){    //팀 하나만선택
                      str +=' id="deptLabel_'+list[i].deptId+'" onclick="fnObj.teamOnlySelect(\''+list[i].deptId+'\');">  ';
                  }else if(isOneDept != 'Y' && isDeptSelect == 'Y'){    //팀 다중선택
                      str +='>  ';
                      str +='<input type="checkbox" name="deptCheckBox"  id="deptCheck_'+list[i].deptId+'"  class="deptTop teamChk" value="'+list[i].deptId+'" onclick="fnObj.teamMultiSelect('+list[i].deptId+','+list[i].parentDeptId+',this);"> ';
                  }else{
                      str +='>  ';
                  }

                  if(isOneUser != 'Y' && isDeptSelect != 'Y'){        //단일 유저 선택이아니고 팀 하나만선택이 아니면
                      str +='<input type="checkbox" id="teamCheck_'+list[i].deptId+'"  class="deptTop teamChk" value="'+list[i].deptId+'" onclick="fnObj.checkDo('+list[i].deptId+',this,'+list[i].parentDeptId+');"> ';
                  }



                  str +='<i class="icon_pd"></i><span>'+list[i].deptNm+'</span></label>';
                  str +='</div>';
                  str += '<dl class="childteam" id="namedl_'+list[i].deptId+'"><dd><div id="name_'+list[i].deptId+'"></div></dd></dl>';

                  str +='<ul id="innerDeptUl_'+list[i].deptId+'" class="innerUl"></ul></li>';


              }


        	  beforeOrgId = list[i].teamOrgId

          }

          if(str != '') $("#approveTreeArea").css({'border-top' : '1px dashed #8b9ca5' , 'padding-top': '10px'});
          $("#approveTreeArea").html(str);

          //--최상위 부서 이외 부서 그리드
 		  if(isDeptSelect != 'Y'){
	          for(var i =0;i<list.length;i++){
	              str ='';
	              userStr = '';
	              if(list[i].parentDeptId != 0  && list[i].teamOrgId != orgId){

	                  str +='<li id="deptLi_'+list[i].deptId+'">';
	                  str +='<div id="div_'+list[i].deptId+'"><label';

	                  if(isOneDept == 'Y' && isDeptSelect == 'Y'){    //팀 하나만선택
	                      str +=' id="deptLabel_'+list[i].deptId+'"  onclick="fnObj.teamOnlySelect(\''+list[i].deptId+'\');">  ';
	                  }else if(isOneDept != 'Y' && isDeptSelect == 'Y'){    //팀 다중선택
	                      str +='>  ';
	                      str +='<input type="checkbox" class="teamChk"  name="deptCheckBox"  id="deptCheck_'+list[i].deptId+'" onclick="fnObj.teamMultiSelect('+list[i].deptId+','+list[i].parentDeptId+',this);">';
	                  }else{
	                      str +='>  ';
	                  }

	                  if(isOneUser != 'Y'  && isDeptSelect != 'Y'){       //단일 유저 선택이아니면,
	                      str +='<input type="checkbox" class="teamChk" id="teamCheck_'+list[i].deptId+'" onclick="fnObj.checkDo('+list[i].deptId+',this,'+list[i].parentDeptId+');">';
	                  }

	                  str +='<i class="icon_pd"></i><span>'+list[i].deptNm+'</span></label>';

	                  str +='</div>';
	                  str += '<dl class="childteam" id="namedl_'+list[i].deptId+'"><dd><div id="name_'+list[i].deptId+'"></div></dd></dl>';
	                  ///* <dl class="childteam nameDl" id="innerdl_'+list[i].deptId+'"></dl> */
	                  str +='<ul id="innerDeptUl_'+list[i].deptId+'" class="innerUl"></ul></li>';

	                  $("#innerDeptUl_"+list[i].parentDeptId).append(str);
	              }
	          }
	          fnObj.getApproveUserList();
 		  }

      }


  },

  //결재자
  getApproveUserList : function(){

          var list = g_userList;
          var disabledYn ='';
          if(isUserSelectEabled =='N'){
              disabledYn = 'disabled';
          }
          if(isDeptSelect !='Y'){
              for(var i = 0;i<list.length;i++){
                  var str ='';
                  var userDisabled ='';
                  var isOnclick ='onclick="fnObj.setSelectList('+list[i].userId+',\'\',\''+list[i].id+'\');"';        //단일 선택일때 disable 리스트에서 사원 클릭 옵션 제거

                  var isIconCir ='';                                                          //단일 선택일때 disable 리스트에 있으면 off 추가


              	  if(isAppoveLineAdd == 'Y' && list[i].orgId != $("#selOrg").val() ){


	                  //사원 체크박스
	                  str+='<label ';
	                  var styleCursor = "";

	                  for(var k = 0;k<g_disabledList.length;k++){
	                      if(g_disabledList[k] ==list[i].userId ){
	                          userDisabled = ' disabled';
	                          if(isOneUser =='Y'){
	                              isOnclick =''; isIconCir =' off';
	                              styleCursor = ' style="cursor : auto"';
	                          }

	                      }

	                  }

	                  str+= isOnclick;

	                  if(isOneUser != 'Y'){       //단일 유저 선택이아니면,
	                      str+= styleCursor + ' ><input type="checkbox" name="userCheckBox" id="userCheck_'+list[i].userId+'" value="'+list[i].userId+'" '+disabledYn+' '+userDisabled+' >';
	                  }else{
	                      str+=' id="userLabel_'+list[i].userId+'" ' + styleCursor + '>';
	                  }

	                  str+= '<i class="icon_cir '+isIconCir+'"></i><span class="t_name">';
	                  str+= "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].userId+"\",$(this),\"rClick\",null,0,-80,75)'>"+ list[i].userName+'</span></span></label>';

	                  $("#name_"+list[i].deptId).append(str);     //해당팀에 이름 세팅
              	  }

              }
          }

          if(isDeptSelect != 'Y'){ //유저인경우만 처리
              var innerUlList = $(".innerUl");
              for(var i=0;i<innerUlList.length;i++){

                  if($(innerUlList[i]).find('.t_name').length == 0){
                      $(innerUlList[i]).remove();
                  }

              }

              var teamLiList = $(".topTeamLi");
              for(var i=0;i<teamLiList.length;i++){

                  if($(teamLiList[i]).find('.t_name').length == 0){
                      $(teamLiList[i]).remove();
                  }

              }
          }

          var dlList = $(".nameDl");
          for(var i=0;i<dlList.length;i++){
              if($(dlList[i]).find('.t_name').length == 0){
                  $(dlList[i]).remove();
              }
          }

          // Tree Navigation
          var tNav = $('.treeShape_st');
          var tNavPlus = '\<button type=\"button\" class=\"tNavToggle plus\"\>+\<\/button\>';
          var tNavMinus = '\<button type=\"button\" class=\"tNavToggle minus\"\>-\<\/button\>';
          tNav.find('li>ul').css('display','none');
          tNav.find('ul>li:last-child').addClass('last');
          tNav.find('li>ul:hidden').parent('li').prepend(tNavPlus);
          tNav.find('li>ul:visible').parent('li').prepend(tNavMinus);
          //tNav.find('li.active').addClass('open').parents('li').addClass('open');
          tNav.find('li').addClass('open').parents('li').addClass('open');
          tNav.find('li.open').parents('li').addClass('open');
          tNav.find('li.open>.tNavToggle').text('-').removeClass('plus').addClass('minus');
          tNav.find('li.open>ul').slideDown(100);
          $('.treeShape_st .tNavToggle').click(function(){
              t = $(this);
              t.parent('li').toggleClass('open');
              if(t.parent('li').hasClass('open')){

                  t.text('-').removeClass('plus').addClass('minus');
                  t.parent('li').find('>ul').slideDown(100);
                  t.parent('li').find('>dl').slideDown(100);
              } else {
                  t.text('+').removeClass('minus').addClass('plus');
                  t.parent('li').find('>dl').slideUp(100);
                  t.parent('li').find('>ul').slideUp(100);
              }
              return false;
          });
          $('.treeShape_st a[href=#]').click(function(){
              t = $(this);
              t.parent('li').toggleClass('open');
              if(t.parent('li').hasClass('open')){
                  t.prev('button.tNavToggle').text('-').removeClass('plus').addClass('minus');
                  t.parent('li').find('>ul').slideDown(100);
              } else {
                  t.prev('button.tNavToggle').text('+').removeClass('minus').addClass('plus');
                  t.parent('li').find('>ul').slideUp(100);
              }
              return false;
          });


  },

  //--------------------------결재라인 추가 : E

  doClose : function(type){
	  if(type == "directInput"){
		  opener.fnObj.directInputActive();
		  window.close();
	  }
  }

};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){

    fnObj.preloadCode();    //공통코드 or 각종선로딩코드
    if(isDeptSelect != 'Y'){
        fnObj.pageStart();      //화면세팅(사원)
    }else{
        fnObj.pageTeamStart();  //화면세팅(팀)
    }

    if(g_selectUserStr!=''){
        if(isDeptSelect == 'Y') fnObj.getAllDeptList();
        else fnObj.getAllUserList();
    }
    fnObj.getDeptList();
    //fnObj.initCheckSet();

    if(isEnable !="N") $("#btnDirectInputActive").hide();

    if(isAppoveLineAdd == 'Y' && isDeptSelect != 'Y') fnObj.setApproveLine();

    fnObj.initCheckSet();

	  //유저프로필 이벤트 셋팅
	initUserProfileEvent();
	$("body").attr("oncontextmenu","return false");
});

</script>

