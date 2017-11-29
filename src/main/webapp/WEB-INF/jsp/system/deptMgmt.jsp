<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<div class="verticalWrap">
    <div class="addAreaZone">
        <div class="tnavi_title">
            <span>
            	<select id="targetOrgId" name="targetOrgId" class="select_b w80pro" onChange="fnObj.doLoadTreeview()">
                    <c:forEach items="${orgCompList}" var="item">
                        <option value="${item.orgId}" ${ item.orgId == baseUserLoginInfo.applyOrgId ? "selected" : "" } targetAuth = "${item.authChk }">${item.cpnNm}</option>
                    </c:forEach>
                </select>
            </span>
        </div>
        <div id="AXJSTree" class="tnavi_treezone"></div>
    </div>
    <section id="detail_contents">
        <div style="display:none;">
            <div id="AXSearchTarget"></div>
        </div>
        <div class="sys_p_noti dotline_top"><span class="icon_noti"></span><span class="pointB">부서정보수정</span><span>은 부서를 선택한후 표데이터를 클릭하시기 바랍니다.</span><span class="pointred"> (부서트리구조는 드래그 앤 드롭을 통해 수정할 수 있습니다.)</span></div>
        <h3 class="h3_title_basic" >선택부서</h3>
        <div id="AXGridTarget"></div>
        <h3 class="h3_title_basic mgt30" >선택부서 인원</h3>
        <div id="AXGridUserList"></div>
        <div class="systemBtnzone">
            <button type="button" class="AXButton Classic btn_auth" onclick="fnObj.addOpen();"><i class="axi axi-add" style="font-size:12px;"></i> 부서등록</button>
            <button type="button" class="AXButton Classic btn_auth" onclick="fnObj.doSaveManager();"><i class="axi fa-check-circle fa-lg" style="font-size:12px;"></i> 부서장 지정</button>
            <button type="button" class="AXButton Classic btn_auth" onclick="fnObj.openDeptPopup();"><i class="axi fa-check-circle fa-lg" style="font-size:12px;"></i> 부서이동</button>
        </div>
    </section>
</div>


<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';     //language (profile language... 'KOR' or 'ENG')

//공통코드
var comCodeDeptClass;           //부서분류
var comCodeDeptLevel;           //부서레벨

//var mySearch = new AXSearch();    // instance
var myGrid = new AXGrid();      // instance
var myGrid2 = new AXGrid();     // instance (오른쪽)

var myModal = new AXModal();    // instance

var selDeptCode;
var selDeptId;
var selLevel;


var selDeptClass = "ORG";
var selUserId;
var selUserName;

//부서이동 드래그 드랍때 저장할지 여부판단
var moveChk = true;
//Global variables :E ---------------



/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

    //################# init function :S #################

    //선로딩코드
    preloadCode: function(){

        //공통코드
        comCodeDeptClass = getBaseCommonCode('DEPT_CLASS', lang, 'CD', 'NM' , null, '', '', {orgId : "${baseUserLoginInfo.applyOrgId}"});
        if(comCodeDeptClass == null){//코드타입 공통코드 (Sync ajax)
            comCodeDeptClass = [{'CD':'','NM':'선택'}];
        }
        comCodeDeptLevel = getBaseCommonCode('DEPT_LEVEL', lang, 'CD', 'NM' , null, '', '', {orgId : "${baseUserLoginInfo.applyOrgId}"});                       //코드타입 공통코드 (Sync ajax)
        if(comCodeDeptLevel == null){
            comCodeDeptLevel = [{'CD':'','NM':'선택'}];
        }
        //'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
        this.addComCodeArray(comCodeDeptClass);
        this.addComCodeArray(comCodeDeptLevel);
    },


    //화면세팅
    pageStart: function(){

        //-------------------------- 그리드 :S -------------------------
        myGrid.setConfig({
            targetID : "AXGridTarget",
            theme : "AXGrid",

            fixedColSeq : 4,    //컬럼고정 index
            fitToWidth : false, //true, //넓이에맞게
            colHeadAlign : "center",    //헤드의 기본 정렬. "left"|"center"|"right"

            height: 170,        //grid height


            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            colGroup : [
                {key:"NO",      label:"NO",     width:"40",     align:"center", sort: false,  formatter:function(){
                    return ("<span class='fontGray\'>" + (this.index + 1) + "</span");
                }},

            /*     {key:"deptCode",     label:"부서코드",       width:"80",     align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}}, */
                {key:"korName",         label:"부서명(한글)",    width:"120",    align:"center"},
                {key:"engName",         label:"부서명(영문)",    width:"140",    align:"center"},
                {key:"deptDesc",        label:"설명",         width:"150",    align:"left"},
                {key:"manager",         label:"부서장",            width:"65",     align:"center"},
                {key:"levelName",       label:"부서 레벨",      width:"80",     align:"center"},
                /* {key:"dummy",            label:"가상부서여부",     width:"100",    align:"center"}, */
                {key:"parentDeptNm",    label:"상위부서",       width:"150",    align:"center"},
                {key:"enable",          label:"사용여부",       width:"90",     align:"center"},
            ],
            body : {
                onclick: function(){
                    if(this.c >= 1){                            //부서보기
                        fnObj.viewDept(this.list[this.index]);  //부서정보보기 (부서정보 객체전달)

                    }

                }

            },
            page:{
                paging:false,
                status:{formatter: null}
            }

        });
        //-------------------------- 그리드 :E -------------------------

        //-------------------------- 그리드2 :S -------------------------
        myGrid2.setConfig({
            targetID : "AXGridUserList",
            theme : "AXGrid",

            fixedColSeq : 4,            //컬럼고정 index
            //fitToWidth : true,        //true, //넓이에맞게
            colHeadAlign : "center",    //헤드의 기본 정렬. "left"|"center"|"right"
            colHeadTool : false,        //컬럼 display 여부를 설정
            height: 400,                //grid height

            autoChangeGridView: {       // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            colGroup : [
                {key:"chk",     label:"<input type='checkbox' name='allChkLeft' readonly='true' onclick='fnObj.allCheck(0);' />",  width:"30",  align:"center", sort: false,  formatter:function(){
                    return ("<input type='checkbox' name='mCheckLeft' onclick='fnObj.clickCheckboxL(this, " + this.index + ");' " + ((this.value==1)?"checked":"") + " />");
                }},
                {key:"NO",      label:"NO",     width:"40",     align:"center", sort: false,  formatter:function(){
                    return ("<span class='fontGray\'>" + (this.index + 1) + "</span>");
                }},

                {key:"name",        label:"이름",             width:"65",     align:"center"},
                {key:"loginId",     label:"로그인ID",      width:"110",    align:"center",     formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"showEmpNo",   label:"사번",             width:"100",    align:"center",     formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"companyNm",   label:"소속회사",       width:"120",    align:"center"},
                {key:"rankNm",      label:"직위",             width:"65",     align:"center"},
                {key:"deptNm",      label:"부서",             width:"120",    align:"center",     formatter:function(){
                                                                                                    if(this.item.mainYn == 'N') return this.value + '<font color=silver>(겸직)</font>';
                                                                                                    else return this.value;
                                                                                                }},
                {key:"isManager",   label:"부서장",            width:"65",     align:"center",     formatter:function(){return (this.value=="Y"?("<font color=#407bea>부서장</font>"):"");}},
                {key:"mobileTel",   label:"핸드폰",            width:"95",     align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
                {key:"email",       label:"이메일",            width:"140",    align:"left"},
               /*  {key:"companyTel",  label:"회사전화",       width:"95",     align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
                {key:"companyFax",  label:"회사팩스",       width:"95",     align:"center",  formatter:function(){return toPhoneFormat(this.value);}}, */
                {key:"empTypeNm",   label:"채용형태",       width:"90",     align:"center"},
                {key:"mainYn",   label:"대표부서여부",       width:"110",     align:"center"}

            ],
            body : {
                onclick: function(){
                    if(this.c >= 1){        //메뉴보기
                        selUserId = this.list[this.index].userId;
                        selUserName = this.list[this.index].name;

                    }

                },

                ondblclick: function(){}

            },
            page:{
                paging:false,
                status:{formatter: null}
            }

        });
        //-------------------------- 그리드 :E -------------------------

        //-------------------------- 모달창 :S -------------------------
        myModal.setConfig({
            windowID:"myModalCT",
            //openModalID:"kkkkk",
            width:740,
            mediaQuery: {
                mx:{min:0, max:1200}, dx:{min:767}
            },
            displayLoading:true,
            scrollLock: true,
            onclose: function(){}
            ,contentDivClass: "popup_outline"
        });
        //-------------------------- 모달창 :E -------------------------

    },//end pageStart.
    //################# init function :E #################


    //################# else function :S #################
    //체크박스 전체 체크
    allCheck: function(knd){
         var chkList = document.getElementsByName('mCheckLeft');
         var list = myGrid2.getList();
         var addIdx = chkList.length/2;
         var toBe = document.getElementsByName('allChkLeft')[1].checked;
         for(var i=chkList.length/2; i<chkList.length; i++){
             chkList[i].checked = toBe;      //체크여부
             list[i-addIdx].chk = toBe?1:0;  //그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
         }
    },

  // 그리드 체크박스 클릭 이벤트 핸들러 (그리드 data Sync)
    clickCheckboxL: function(obj, idx){
        var list = myGrid2.getList();
        if(obj.checked){
            list[idx].chk = 1;
        }else{
            list[idx].chk = 0;
        }
    },

    doLoadTreeview: function(page){     //knd : null - 검색버튼, 숫자 - 페이지검색

        myGrid.reloadList();

        var url = contextRoot + "/system/getDeptList.do";
        var param = {targetOrgId : $("#targetOrgId").val()};

        var callback = function(result){

            var obj = JSON.parse(result);

            for(var n = 0; n < obj.resultVal; n++)
            {
                if( obj.resultList[n].parent == 0 )
                    obj.resultList[n].parent = "#";
            }

            fnObj.viewTree(obj.resultList);     //부서 트리 생성

            myGrid.clearSort();                 //소팅초기화
            myGrid.setData({list:[]});

            myGrid2.clearSort();
            myGrid2.setData({list:[]});

            var auth = $("#targetOrgId option:selected").attr("targetAuth");

			if(auth == "READ"){
				$(".btn_auth").hide();
			}else{
				$(".btn_auth").show();
			}
        };

        commonAjax("POST", url, param, callback);
    },//end doLoadTreeview


    // 트리 노드 선택 시 상세 검색
    doSearchDetail: function(data){     //knd : null - 검색버튼, 숫자 - 페이지검색

        //multiple인지 체크하기
        var clickLength = $(".jstree-wholerow-clicked").length;


        var param = {
                //search: selDeptCode,          // 부서ID
                selDeptId : selDeptId,
                deptClass: selDeptClass,            // 매니저ID
                targetOrgId : $("#targetOrgId").val()
                };
        var url = contextRoot + "/system/getDeptList.do";

        //var param = mySearch.getParam().queryToObjectDec();   //query string 을 객체로 바꿔준다.      *queryToObjectDec 디코딩해서

        var callback = function(result){

            var obj = JSON.parse(result);

            var cnt = obj.resultVal;    //결과수
            var list = obj.resultList;  //결과데이터JSON

            if(clickLength < 1 ){ //단일클릭일 경우 초기화 시킴
                myGrid.setData({list: []});
                myGrid2.setData({list: []});
            }


            //트리 multiple 선택 시 배열 추가함.
            var beforeList = myGrid.getList();
            if(beforeList == null || beforeList.length < 1){
                beforeList = list;
            }else{
                for(var i = 0 ; i < list.length ; i++){
                    var addYn = true;
                    beforeList.forEach(function(value){
                        if(value.deptId == list[i].deptId){
                            addYn = false;
                        }
                    });
                    if(addYn)
                        beforeList.push(list[i]);
                }
            }

            var gridData = {list: beforeList};

            myGrid.clearSort();         //소팅초기화
            myGrid.setData(gridData);   //그리드에결과반영
        };

        commonAjax("POST", url, param, callback, false);            //그리드 1(부서정보)를 세팅하기전에,그리드 2(사원리스트)를 제대로 세팅 못하는 버그 발생. false 추가. sjy

    },//end doSearch

    //부서이동 부서트리 팝업
    openDeptPopup: function(type){

        g_userTargetType  = "DEPT";
        var arrUserId = [];
        var chkCnt = 0;         //이동을 위해 체크한 수

        var userList = myGrid2.getList();
        for(var i=0; i<userList.length; i++){
            if(userList[i].chk == 1){   //체크되어 있는 것을
                chkCnt++;
                arrUserId.push(userList[i].userId);   //이동할 row data
            }
        }
        if(chkCnt == 0){
            alertM("사용자를 먼저 선택해주시기 바랍니다!");
            return;
        }

        var paramList = [];
        var paramObj ={ name : 'userList'   ,value :  selDeptId };
        paramList.push(paramObj);
        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
        paramList.push(paramObj);
        paramObj ={ name : 'oneOrgId' ,value : $("#targetOrgId").val()};
        paramList.push(paramObj);
        paramObj ={ name : 'isAllOrgSelect' ,value : 'N'};  //관계사 직원 다중선택가능 옵션
        paramList.push(paramObj);
        paramObj ={ name : 'isDeptSelect' , value :  'Y'};  //직원,부서 옵션
        paramList.push(paramObj);
        paramObj ={ name : 'isOneDept' ,value : 'Y'};
        paramList.push(paramObj);

        userSelectPopCall(paramList);       //공통 선택 팝업 호출

    },
  //부서 선택
 // 사원 및 부서 선택 팝업에서 선택한 데이터를 처리
    getResult: function(resultList){
    	var deptId = resultList[0].deptId;
    	var userList =[];
        var userStr ='';
        var mainYnList =[];
        var mainYnStr ='';

        var userGridList = myGrid2.getList();
        for(var i=0; i<userGridList.length; i++){
            if(userGridList[i].chk == 1){   //체크되어 있는 것을
            	userList.push(userGridList[i].userId);   //이동할 row data
            	mainYnList.push(userGridList[i].mainYn);   //이동할 row data
            }
        }
        userStr = userList.join(',');
        mainYnStr = mainYnList.join(',');

    	var url = contextRoot + "/system/updateUserDepartmentForMove.do";

        var param = {
                oldDeptId: selDeptId,          // 부서ID
                deptId: deptId,
                userList: userStr,          // 유저목록
                mainYnList: mainYnStr          // 대표부서여부
        };

        var callback = function(result){

            var obj = JSON.parse(result);

            var cnt = obj.resultVal;    //결과수

            if(obj.result == "SUCCESS"){
                toast.push("부서이동이 완료되었습니다.");

                myGrid2.clearSort();            //소팅초기화
                myGrid2.setData({list : []});       //그리드에결과반영

                //변경 정보 재로딩
                fnObj.doSearchDetail();         //선택부서 정보
                fnObj.doGetUserListOfDept();    //선택부서 인원정보

            }else{
                //alertMsg();
            }
        };
        commonAjax("POST", url, param, callback);
    },


    // 부서장 지정
    doSaveManager: function(){      //knd : null - 검색버튼, 숫자 - 페이지검색

    	var arrUserId = [];
        var chkCnt = 0;         //이동을 위해 체크한 수
        var chkUserId = "";
        var chkUserName = "";

        var userList = myGrid2.getList();
        for(var i=0; i<userList.length; i++){
            if(userList[i].chk == 1){   //체크되어 있는 것을
                chkCnt++;
                chkUserId = userList[i].userId;   //선택된 부서장 row data
                chkUserName = userList[i].name;   //선택된 부서장 row data
            }
        }
        if(chkCnt == 0){
            alertM("사용자를 먼저 선택해주시기 바랍니다!");
            return;
        }else if(chkCnt != 1){
            alertM("사용자를 한명만 선택해주시기 바랍니다!");
            return;
        }
        selUserId = chkUserId;
        selUserName = chkUserName ;

        var url = contextRoot + "/system/doSaveManager.do";

        var param = {
                deptId: selDeptId,          // 부서ID
                manager: selUserId          // 매니저ID
                };


        var callback = function(result){

            var obj = JSON.parse(result);

            var cnt = obj.resultVal;    //결과수

            if(obj.result == "SUCCESS"){
                toast.push(selUserName + "님이 부서장으로 지정되었습니다.");

                myGrid2.clearSort();            //소팅초기화
                myGrid2.setData({list : []});       //그리드에결과반영

                //변경 정보 재로딩
                fnObj.doSearchDetail();         //선택부서 정보
                fnObj.doGetUserListOfDept();    //선택부서 인원정보

            }else{
                //alertMsg();
            }


        };

        commonAjax("POST", url, param, callback);
    },//end doSearch


    //부서트리 정보 저장
    doSaveMoveDeptInfo: function(deptInfoObj){
        var url = contextRoot + "/system/doSaveMoveDeptInfo.do";

        var param = {
        		deptInfoObj : JSON.stringify(deptInfoObj)
        };

        var callback = function(result){

            var obj = JSON.parse(result);

            //세션로그아웃 >> 재로그인
            if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
                window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
                return;
            }

            var cnt = obj.resultVal;    //결과수
            //console.debug(obj.result);
            if(obj.result == "SUCCESS"){
                toast.push("부서이동이 완료되었습니다.");
                fnObj.doLoadTreeview();     //부서트리 세팅
            }else{
                //alertMsg();
            }
        };

        commonAjax("POST", url, param, callback);

    },


    //엑셀다운
    excelDownload: function(){
         excelDown(myGrid.getExcelFormat('html'), "download");      //common.js
    },


    //부서등록 버튼 클릭
    addOpen: function(){
        var url = "<c:url value='/system/addDept.do'/>";
        var params = {
                mode:'new'
                ,targetOrgId : $("#targetOrgId").val()
                ,parentDeptId: selDeptId
                ,level:selLevel};       //"btype=1&cate=1".queryToObject();     //게시판유형(board_type), 게시판 카테고리 를 넘긴다.

        //params 에 코드리스트 전달------
        var list = myGrid.getList();    //그리드 데이터(array object)
        var codeList  = '';             //코드리스트(','로 연결된 문자열)
        for(var i=0; i<list.length; i++){
            codeList += list[i].deptCode.toUpperCase() + ',';
        }
        params.codeList = codeList;     //파라미터에 추가(key,value)
        //-----------------------------

        myModal.open({
            url: url,
            pars: params,
            titleBarText: '부서등록',       //titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
            method:"POST",
            top: 150,
            width: 620,
            closeByEscKey: true             //esc 키로 닫기
        });

        $('#myModalCT').draggable();
    },//end writeOpen

    //부서별 사용자 관리 버튼 클릭
    userPerDeptOpen: function(){
        var url = "<c:url value='/system/userPerDept.do'/>";
        var params = {mode:'new'};      //"btype=1&cate=1".queryToObject();     //게시판유형(board_type), 게시판 카테고리 를 넘긴다.

        //params 에 코드리스트 전달------
        var list = myGrid.getList();    //그리드 데이터(array object)
        var codeList  = '';             //코드리스트(','로 연결된 문자열)
        for(var i=0; i<list.length; i++){
            codeList += list[i].deptCode.toUpperCase() + ',';
        }
        params.codeList = codeList;     //파라미터에 추가(key,value)
        //-----------------------------

        myModal.open({
            url: url,
            pars: params,
            titleBarText: '부서별 사용자 관리',     //titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
            method:"POST",
            top: 150,
            width: 1200,
            height:500,
            closeByEscKey: true             //esc 키로 닫기
        });

        $('#myModalCT').draggable();
    },//end writeOpen


    //부서보기
    viewDept: function(deptInfoObj){

        var url = "<c:url value='/system/addDept.do'/>";
        var params = {mode:'update',
                      deptId: deptInfoObj.deptId,                   // 부서ID
                      deptInfoObj:JSON.stringify(deptInfoObj)};     //이미 리스트에서 읽은 정보를 팝업에 전달

        myModal.open({
            url: url,
            pars: params,
            titleBarText: '부서수정',       //titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
            method:"POST",
            top: 150,
            width: 620,
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


    //부서 트리 생성
    viewTree : function (jsonDeptData) {

        myGrid.clearSort();             //소팅초기화
        myGrid2.clearSort();            //소팅초기화

        $('#AXJSTree').jstree('destroy');
        $('#AXJSTree').jstree({
                        'core' : {
                                "check_callback" : true
                                ,'data' : jsonDeptData
                        },
                        "themes" : {
                                "variant" : "large",
                                "icons": "true"
                        },
                        "plugins" : [
                                      "dnd", "themes", "crrm", "json_data"      //, "wholerow"
                        ],
                        "dnd" : {
                            "is_draggable" : function () {
                            	var auth = $("#targetOrgId option:selected").attr("targetAuth");

                 				if(auth == "READ"){

                 					return false;
                 				}else return true;
                        },
                        "drag_check" : function (data) {
                                if(data.r.attr("id") == "phtml_1") {
                                    return false;
                                }

                                return {
                                    after : false,
                                    before : false,
                                    inside : true
                                };
                        },
                        "drag_finish" : function () {
                            //console.debug(data);
                            //alert("DRAG OK");
                        }
                }}).bind("ready.jstree",function(event,data){       /* loaded.jstree */
                     $(this).jstree("open_all");


                }).bind("select_node.jstree", function (event, data) {


                    selDeptId = data.node.original.deptId;
                    selLevel = data.node.original.level;
                    selDeptCode = data.node.original.deptCode;

                    fnObj.doSearchDetail();         //선택부서 정보
                    fnObj.doGetUserListOfDept();    //선택부서 인원정보

                 }).bind("move_node.jstree",function(event,data){
                	var auth = $("#targetOrgId option:selected").attr("targetAuth");

     				if(auth == "READ"){
     					alert("해당관계사에 부서수정 권한이 없습니다.");
     					moveChk = false;
     					fnObj.doLoadTreeview();     //부서트리 세팅
     					return false;
     				}

                    if(!moveChk){
                        moveChk = true;
                        return false;
                    }
                    var treeObj = $('#AXJSTree').jstree(true).get_json();       //트리 데이터 object
                    var parent = data.parent;

                    //enable N 인경우 이동불가
                    if(data.node.original.enable == "N") {
                        var old_parent = data.old_parent;
                        var old_position = data.old_position;
                        moveChk = false;
                        $('#AXJSTree').jstree(true).move_node(data.node,old_parent,old_position);

                        dialog.push({body:"<b>확인!</b> 사용여부가 'N'인경우에는 부서이동을 하실 수 없습니다.", type:""});
                        return false;
                    }

                    if(parent!="#"){
                    	var targetNode = $('#AXJSTree').jstree(true).get_node(data.parent);
                    	//enable N 인경우 이동불가
                        if(targetNode.original.enable == "N") {
                            var old_parent = data.old_parent;
                            var old_position = data.old_position;
                            moveChk = false;
                            $('#AXJSTree').jstree(true).move_node(data.node,old_parent,old_position);

                            dialog.push({body:"<b>확인!</b> 사용여부가 'N'인경우에는 부서이동을 하실 수 없습니다.", type:""});
                            return false;
                        }

                         var level = data.node.original.level;
                         if(level == "L00") {
                             var old_parent = data.old_parent;
                             var old_position = data.old_position;
                             moveChk = false;
                             $('#AXJSTree').jstree(true).move_node(data.node,old_parent,old_position);

                             dialog.push({body:"<b>확인!</b> 상위부서가 있을경우 부서레벨을 회장으로 선택할 수 없습니다.", type:""});
                             return false;
                         }
                    }
                    //console.log("========== treeObj ==========\n");
                    //console.log(treeObj);

                    var deptInfoObj = fnObj.getDeptMoveInfoObj(treeObj);        //저장을 위해 트리 데이터에 추가 (deptId, depth, sort, parent)
                    //console.log("========== deptInfoObj ===========\n");
                    //console.log(deptInfoObj);
                    fnObj.doSaveMoveDeptInfo(deptInfoObj);

                }).bind("dblclick.jstree",function(event,data){
                    //fnObj.doSearchAndPopup(event);
                });

    },


    //선택부서 인원
    doGetUserListOfDept: function (data){

        selUserId = null;

        var url = contextRoot + "/system/getUserListOfDept.do";
        var param = {
                deptCode: selDeptCode
               ,deptId: selDeptId
               ,firedType : 1       //유효사용자
               ,orgId : $("#targetOrgId").val()
        };

        var callback = function(result){

            var obj = JSON.parse(result);

            var cnt = obj.resultVal;    //결과수
            var list = obj.resultList;  //결과데이터JSON

            var beforeList = [];

            for(var i = 0 ;i < list.length ; i++)
                beforeList.push(list[i]);

            var gridData = {list:beforeList};

            myGrid2.clearSort();            //소팅초기화
            myGrid2.setData(gridData);      //그리드에결과반영
        };

        commonAjax("POST", url, param, callback);
    },




    //---level 세팅 재귀함수 호출 : S
    //이동한 부서 정보
    getDeptMoveInfoObj: function(treeObj){

        var newObj = [];
        var depth = 1;
        for(var i=0;i<treeObj.length;i++){
            //alert(treeObj[i].id);
            newObj.push({'deptId':treeObj[i].id, 'depth':depth, 'sort':i, 'parent':0});
            if(treeObj[i].children.length>0){
                fnObj.setChildDeptMoveInfo(treeObj[i].children, depth + 1, newObj, treeObj[i].id);          //자식트리 정보
            }
        }

        return newObj;
    },

    //자식트리 정보
    setChildDeptMoveInfo: function(childrenObj, depth, newObj, parent){
        for(var i=0;i<childrenObj.length;i++){
            newObj.push({'deptId':childrenObj[i].id, 'depth':depth, 'sort':i, 'parent':parent});
            if(childrenObj[i].children.length>0){
                fnObj.setChildDeptMoveInfo(childrenObj[i].children, depth + 1, newObj, childrenObj[i].id);      //자식트리 정보(제귀호출)
            }
        }
    }
    //---level 세팅 재귀함수 호출 : E

    //################# else function :E #################

};//end fnObj.





/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
    fnObj.preloadCode();        //공통코드 or 각종선로딩코드
    fnObj.pageStart();          //화면세팅
    fnObj.doLoadTreeview();     //부서트리 세팅

});



</script>