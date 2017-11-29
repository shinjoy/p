<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->
<style type="text/css">
.btn_wh_bevel_wide {
    float: left;
    background: url(../images/common/bg_btn_bevel.gif) repeat-x center center;
    width: 170px;
    height: 21px;
    line-height: 21px;
    vertical-align: middle;
    border: #c2c2c2 solid 1px;
    color: #666;
    display: inline-block;
    font-size: 11px;
    font-weight: bold;
    text-align: center;
}
.btn_wh_bevel_wide_right_margin{
    float: left;
    width: 30px;
    height: 21px;
}
.h3_table_title2 {
    background: #f0f2f4;
    height: 18px;
    font-weight: bold;
    font-size: 13px;
    line-height: 18px;
    padding: 8px 0;
    text-align: center;
    color: #777d8a;
    border-left: #b9c1ce solid 1px;
    border-right: #b9c1ce solid 1px;
    border-top: #b9c1ce solid 1px;
    letter-spacing: 0.5px;
    margin-top: 10px;
}

.tb_regi_acti .level_first_v_empty th {
    background: #ffffff;
    padding-left: 4%;
    box-sizing: border-box;
    text-align: left;
    text-indent: 0px;
    color: #3b4354;
    border-top: #cacbce solid 1px;
    border-right: none;
    border-left: none;
}
.tb_regi_acti .level_first_v_empty{
    background: #ffffff!important;
    border-right: none;
    border-left: none;
}
.tb_regi_acti tr.level_first_v_empty td {border-left: none!important; border-top: #cacbce solid 1px; border-bottom: #cacbce solid 1px;}
.project_first_v_row{
	background: #eff1f4;
	font-weight: bold;
	border-bottom: #cacbce solid 1px;
	border-left:#cacbce solid 1px !important;
}
.level_first_v_empty > .project_first_v_row{
	background: #ffffff!important;
	font-weight: bold;
	border-bottom: #cacbce solid 1px;
	border-top: #cacbce solid 1px;
}
.level_first_v_empty{
	height: 30px;
}
</style>
<!-- -------- each page css :E -------- -->



    <section id="detail_contents">
        <!-- 게시판 정렬목록 -->
        <div class="board_classic">
            <div class="leftblock">
            	<span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
                <select id="sel_page_size" onChange="fnObj.setPageSize(true);" class="sh_count_type" title="정렬방법 선택">
                	<option value="15">15개씩 보기</option>
                    <option value="30">30개씩 보기</option>
                    <option value="50">50개씩 보기</option>
                </select>

            	<span class="btn_wh_bevel_wide_right_margin"></span>

                <span class="count_result"><strong>개인선택</strong></span>
                <a href="javascript:fnObj.openUserPopup();" class="btn_wh_bevel_wide">
					<span id="masterUser"></span>
					<font color="blue"><i class="axi axi-search3" style="font-size:12px;padding-left:10px;"></i></font>
				</a>
            </div>
            <div class="rightblock">

            	<select id="srch_project_type" class="search_type" style="display:none;" onchange="fnObj.doSearch(1);" title="${baseUserLoginInfo.projectTitle} 타입 선택">
                <option value="">전체</option>
                    <option value="A">A 타입</option>
                    <option value="B">B 타입</option>
                    <option value="C">C 타입</option>
                </select>

                <input id="srch_search" type="text" placeholder="${baseUserLoginInfo.projectTitle}를 검색하세요" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="${baseUserLoginInfo.projectTitle}검색" />
                <a href="#" onclick="fnObj.doSearch(1);" class="btn_wh_bevel">검색</a>
            </div>
        </div>
        <!--/ 게시판 정렬목록 /-->
        <!-- 프로젝트 목록 -->
		<table id="SGridTarget" class="tb_list_basic" summary="프로젝트관리">
            <caption>프로젝트목록</caption>
            <colgroup>
            	<col width="2.5%"/>
            	<col width="5%" />
                <col width="*" />
               <col width="7%" />
                <col width="18%" />
                <col width="16%" />
                <col width="6%" />
                <col width="8%" />
               <%--  <col width="6%" /> --%>
                <col width="5%" />
                <col width="6%" />
                <col width="7%" class="myArea"/>
            </colgroup>
        	<thead>
                <tr>
					<th scope="col"><label for=""><input type="checkbox" name='allChk' onclick='fnObj.allCheck();' /><span class="blind">전체선택</span></label></th>
                    <th scope="col"><a href="#;" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">구분<em>오름차순</em></a></th>
                    <th scope="col">${baseUserLoginInfo.projectTitle}명</th>
                    <th scope="col">유형</th>
                    <th scope="col">설명</th>
                    <th scope="col">
                        <a href="#;" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">&nbsp;<em>오름차순</em></a>
                        <a href="#;" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">기간<em>오름차순</em></a>
                    </th>
                    <th scope="col">상태값</th>
                    <th scope="col"><a href="#;" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">예산<em>내림차순</em></a></th>
                    <th scope="col">지출</th>
                    <!-- <th scope="col"><a href="#;" onclick="fnObj.doSort(4);" id="sort_column_prefix4" class="sort_normal">사용여부<em>오름차순</em></a></th> -->
                    <th scope="col">사용여부</th>
                    <th scope="col">등록일</th>
                    <th scope="col" class="myArea">기본</th>
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

		<!-- Activity Management -->
       <h3 class="h3_table_title2">${baseUserLoginInfo.activityTitle}</h3>
       <table id="SGridTarget2" class="tb_regi_acti" summary="Activity Management 레벨, Activity, 기간, 예산, 지출, 타임시트, 사용여부, 직원배정, 추가/삭제">
           <caption>
               Activity Management
           </caption>
           <colgroup>
           	   <col width="14%" />
           	   <col width="6%" />
           	   <col width="14%" />
           	   <col width="*"   />
               <col width="16%" />
               <col width="10%" />
               <col width="7%"  />
               <col width="7%"/>
           </colgroup>
           <thead>
               <tr>
               	   <th scope="col">${baseUserLoginInfo.projectTitle}명</th>
               	   <th scope="col">${baseUserLoginInfo.projectTitle}코드</th>
                   <th scope="col">${baseUserLoginInfo.activityTitle}명</th>
                   <th scope="col">설명</th>
				   <th scope="col">기간</th>
                   <th scope="col">예산</th>
                   <th scope="col">지출</th>
                 <!--   <th scope="col">타임시트</th> -->
                   <!-- <th scope="col">배정</th> -->
                   <th scope="col">기본</th>
               </tr>
           </thead>
           <tbody>
				<%-- //// 내용  --%>
           </tbody>
       </table>
       <!--/ Activity Management /-->
    </section>




<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드 (외, 코드)
var codeYesNoForNm;
var codeOverExpenseYesNo;

var myModal = new AXModal();	// instance


var myGrid = new SGrid();		// instance		new sjs
var myGrid2 = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs


var curPageNo = 1;				//현재페이지번호
var pageSize = 10;				//페이지크기(상수 설정)


var g_masterUserId;				//마스터사원ID (activity 배분 대상 사원)

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		codeYesNoForNm = {N:'<b>N</b>',Y:'<b><font color=red>Y</font></b>'};					//화면에 NM 뿌려주기위해
		codeOverExpenseYesNo = [{CD:'Y', NM:'예산초과허용'}, {CD:'N', NM:'예산초과불가'}];


		//마스터 사용자(activity 배분 대상 사원) 기본 세팅(로그인 사용자로)
		var str = '직원선택';

		if('${baseUserLoginInfo.orgId}' == '${baseUserLoginInfo.applyOrgId}'){
			g_masterUserId = '${baseUserLoginInfo.userId}';
			var empNo =  '${baseUserLoginInfo.empNo}';
			var idx = empNo.indexOf('_');
			var showEmpNo = empNo.substring(idx+1);
			str = '${baseUserLoginInfo.userName}' + ' (' + showEmpNo + ')';
		}


		$('#masterUser').html(str);


		//페이지크기 세팅
		fnObj.setPageSize();
	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            {key:"chk",				formatter:function(obj){
            							return ("<input type='checkbox' name='mCheck' value='" + obj.value + "' onclick='fnObj.setActivityListInfo(this," + obj.item.projectId + ");' " + ((obj.value==1)?"checked":"") + " />" );

            }},
            {key:"employee",				formatter:function(obj){
													if(obj.value == 'Y') return '직원배정';
													else return '전직원';

			}},
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
            {key:"description"		},
            {key:"period",			formatter:function(obj){return ((obj.value=='Y'?((obj.item.startDate).replace(/-/gi,'/') + ' ~ ' + (obj.item.endDate).replace(/-/gi,'/') + ' (마감일:'+(obj.item.closeDate).replace(/-/gi,'/')+')'):'무기한'));}},
            {key:"budget",			formatter:function(obj){return ((obj.value=='Y'?(formatMoney(''+obj.item.budgetAmt,'INSERT')):'<b>N</b>'));}},
            {key:"projectStatusNm",     formatter:function(obj){return obj.value;}},
            {key:"expense",			formatter:function(obj){return ((obj.value=='Y'?'<b><font color=red>Y</font></b>':'<b>N</b>'));}},
          /*   {key:"timesheet",		formatter:function(obj){return ((obj.value=='Y'?'<b><font color=red>Y</font></b>':'<b>N</b>'));}}, */
            {key:"enable",			formatter:function(obj){return ((obj.value=='Y'?'<b><font color=red>Y</font></b>':'<b>N</b>'));}},
            {key:"createDate",		formatter:function(obj){return (obj.value).replace(/-/gi,'/');}},
            {key:"defaultYn",		formatter:function(obj){return ( "<input type='radio' name='defaultPjt'  onclick='fnObj.clickCheckbox(this, " + obj.index + ", \"PROJECT\");' " + ((obj.value=='Y')?"checked":"") + " />" );}},
            {key:"budgetStyle",		formatter:function(obj){return ((obj.item.budget=='N'?'text-align:center!important;font-family:돋움!important;font-size:1em;':''));}},
            {key:"projectCode",    formatter:function(obj){return obj.value;}},
            {key:"projectTypeNm",     formatter:function(obj){return obj.value;}}
            ],

	    	body : {
	            onclick: function(obj){
	            	if(obj.c > 0 && obj.c <= 9){
	            		var chkList = document.getElementsByName('mCheck');
	            		document.getElementsByName('mCheck')[obj.index].checked = chkList[obj.index].checked?false:true;	//반대 값으로 세팅

	            	    fnObj.setActivityListInfo(); 		//프로젝트 Activity list 세팅
	            	}
	            }
	        }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td class>#[1]</td>';
    	rowHtmlStr +=	 '<td class="txt_title_type" style="cursor:pointer;">#[2]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=    '<td>#[13]</td>';
    	rowHtmlStr +=	 '<td style="text-align:left;">#[3]</td>';
    	rowHtmlStr +=	 '<td class="num_date_type" >#[4]</td>';
    	rowHtmlStr +=	 '<td>#[6]</td>';
    	rowHtmlStr +=	 '<td class="num_money_type" style="#[11]">#[5]</td>';
    	rowHtmlStr +=	 '<td>#[7]</td>';
    	rowHtmlStr +=	 '<td>#[8]</td>';
    	rowHtmlStr +=	 '<td class="num_date_type">#[9]</td>';
    	rowHtmlStr +=	 '<td  class="myArea">#[10]</td>';


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
			colList : ['START_DATE', 'END_DATE', 'BUDGET_AMT' , 'EMPLOYEE','ENABLE'],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
		});
    	//-------------------------- 소팅 설정 :E ----------------------------


    	//-------------------------- 그리드2 설정 :S ----------------------------
    	/* 그리드2 설정정보 */
    	var configObj2 = {

    		targetID : "SGridTarget2",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
			{key:"projectNm"},

            {key:"namelvl",			formatter:function(obj){
            							if(obj.item.name=='') return '';	//빈라인
            							var pV = parseInt(1*obj.item.sort/100);		//부모 순번
            							var sV = parseInt(1*obj.item.sort%100);		//자식 순번
            							return ('<span>' + obj.item.name + '<em>(' + pV + (sV>0?'-'+sV:'') + ')</em></span>');}},
            {key:"description",		formatter:function(obj){return (obj.value);}},

            {key:"period",			formatter:function(obj){if(obj.item.name=='') return '';	//빈라인
            												return ((obj.item.startDate).replace(/-/gi,'/') + ' ~ ' + (obj.item.endDate.substring(0,4)=='9999'?'<b> 무기한': (obj.item.endDate).replace(/-/gi,'/')) );}},

            {key:"budget",			formatter:function(obj){return (obj.value=='Y'?formatMoney(obj.item.budgetAmt,'INSERT') + ' 원':codeYesNoForNm[obj.value]);}},

            {key:"expense",			formatter:function(obj){
            							var rStr = codeYesNoForNm[obj.value];
            							if(obj.value == 'Y'){
            								rStr += '(' + getRowObjectWithValue(codeOverExpenseYesNo, 'CD', obj.item.overExpense)['NM'] + ')';
            							}
            							return rStr;}},

           /*  {key:"timesheet",		formatter:function(obj){return (codeYesNoForNm[obj.value]);}}, */
            /*
            {key:"allocate",		formatter:function(obj){if(obj.item.name=='') return '';	//빈라인
            												return ("<input type='checkbox' name='allocate' onclick='fnObj.clickCheckboxTry(this, " + obj.index + ");' " + ((obj.value=='Y')?"checked":"") + " />");}},
            */
            {key:"default",			formatter:function(obj){
            								if(obj.item.name=='') return '';	//빈라인
            								if('${baseUserLoginInfo.userId}' != g_masterUserId) return '';	//빈라인
            								else return ( "<input type='checkbox' name='default'  onclick='fnObj.clickCheckbox(this, " + obj.index + ", \"ACTIVITY\");' " + ((obj.value=='Y')?"checked":"") + " />" );}},

            {key:"projectCode"      },
            //데이터만
            //{key:"sort"		 	}
            ]

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr2 = '<tr>';
    	rowHtmlStr2 +=	 '<td class="project_first_v_row" style="text-align:left;">#[0]</td>';
    	rowHtmlStr2 +=  '<td class="project_first_v_row" >#[7]</td>';
    	rowHtmlStr2 +=	 '<th scope="row">#[1]</th>';
    	rowHtmlStr2 +=	 '<td class="special_f_st2" style="text-align:left;">#[2]</td>';
    	rowHtmlStr2 +=	 '<td class="special_f_st2">#[3]</td>';
    	rowHtmlStr2 +=	 '<td>#[4]</td>';
    	rowHtmlStr2 +=	 '<td>#[5]</td>';
    	rowHtmlStr2 +=	 '<td class="myArea">#[6]</td>';
    	//rowHtmlStr2 +=	 '<td>#[7]</td>';
    	//rowHtmlStr2 +=	 '<td>#[8]</td>';
        rowHtmlStr2 +=	 '</tr>';
    	configObj2.rowHtmlStr = rowHtmlStr2;


    	myGrid2.setConfig(configObj2);		//그리드 설정정보 세팅
    	//-------------------------- 그리드2 설정 :E ----------------------------


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

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	if(page==null) page=1;

    	var url = contextRoot + "/project/getUserProjectList.do";
    	var param = {
    					userId: g_masterUserId,

		    			pageSize: pageSize,
		    			pageNo:	page,

		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,

		    			projectType: $('#srch_project_type').val(),		//프로젝트 타입
		    			knd: '',	//$('#srch_knd').val(),				//검색 종류
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

			//class="myArea"

			if(g_masterUserId != '${baseUserLoginInfo.userId}'){
				$('.myArea').hide();

			}else $('.myArea').show();


			document.getElementsByName('allChk')[0].checked = true;
			fnObj.allCheck();

    	};

    	commonAjax("POST", url, param, callback);

    },//end doSearch


  	//프로젝트 보기
    viewProject: function(projectId){

    	//현재 페이지 파라미터 추출---------
    	var url = decodeURIComponent(location.href);
     	var params = url.substring( url.indexOf('?')+1, url.length );	// url에서 '?' 문자 이후의 파라미터 문자열까지 자르기
    	//-------------------------------

    	var url = "<c:url value='/project/projectView.do'/>" + "?saved=&pId=" + projectId + "&" + params;


    	document.location.href = url;

    },//end viewProject


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


   		//프로젝트 Activity list 세팅
   	    fnObj.setActivityListInfo();

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


  	//사원선택 팝업
    openUserPopup: function(){


    	var paramList = [];
        var paramObj ={ name : 'isOneOrg' ,value : 'Y'};
        paramList.push(paramObj);

        paramObj ={ name : 'parentKey' ,value : 'ACT_USER'};
        paramList.push(paramObj);

        paramObj ={ name : 'isOneUser' ,value : 'Y'};
        paramList.push(paramObj);

        userSelectPopCall(paramList);		//공통 선택 팝업 호출


    },


  	//사원 및 부서 선택 팝업에서 선택한 데이터를 처리
    actionBySelData: function(listObj, pKey){

    	fnObj.masterUserSelected(listObj);

    	toast.push('선택OK!');
    },


    //사원선택 처리
    getResult: function(list){
    	$('#masterUser').html(list[0].userNm + ' (' + list[0].showEmpNo + ')');

    	//activity 배분 대상 사원 id (전역변수 세팅)
		g_masterUserId = list[0].userId;


    	//fnObj.setActivityListInfo();	//프로젝트 Activity list 재 호출
    	fnObj.doSearch(1);
    	myGrid2.setGridDataEmpty();		//activity 리스트 초기화
    	document.getElementsByName('allChk')[0].checked = false;		//전체체크 해제(만약 체크되어 있었다면 해제)

    },


  	//프로젝트 Activity list 세팅
    setActivityListInfo: function(){

    	//activity grid 초기화.
    	myGrid2.setGridDataEmpty();
    	//g_selProjectIdList 초기화.
    	g_selProjectIdList = [];

    	var chkList = document.getElementsByName('mCheck');
   		var list = myGrid.getList();
   		//var addIdx = chkList.length/2;
   		for(var i=0; i<chkList.length; i++){
       		if(chkList[i].checked){
       			fnObj.setActivityInfo(list[i].projectId);		//프로젝트별 activity 를 불러와 추가
       		}
       	}
    },


  	//프로젝트 Activity list 불러온다
    setActivityInfo: function(pId){

    	var url = "<c:url value='/project/getUserProjectInfo.do'/>";
    	var param = {
    					projectId : pId,
    					userId	: g_masterUserId,
    					/* employee : 'Y', */
    					enable : 'Y'
    				};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var jsonObj = obj.resultObject;		//결과데이터JSON

    		var project = jsonObj.pProject;		//프로젝트
    		var actList = jsonObj.pActivity;	//activity

    		if(obj.result == "SUCCESS"){
    	    	//----- 내용뿌리기 :S -----
    	    	if(myGrid2.getDataCount()>0 && actList.length > 0){
    	    		actList = addToArray(actList, 0, {name:'', level:0});		//리스트에 추가
    	    	}
    	    	actList = myGrid2.getList().concat(actList);	//리스트에 추가

    	    	//activity
	    		myGrid2.setGridData({
									list: actList,	//그리드 테이터
									page: null		//페이징 데이터
	    						});

    			//----- 내용뿌리기 :E -----
	    		fnObj.resetLevelAndClass();			//레벨 값 및 스타일 class 재세팅
	    		tableRowspan('SGridTarget2', 2, 1);	 //프로젝트명, 프로젝트코드 rowspan 처리
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback, false);	//비동기로호출하여 체크가 순간적으로 2개이상 이루어질때, 순서가 트러지는것을 방지

    },//setProjectInfo


    //레벨 값 및 스타일 class 재세팅
    resetLevelAndClass: function(){

    	var list = myGrid2.dataList;

    	var level;

    	for(var i=0; i<list.length; i++){

    		level = list[i].level * 1;

    		//class 스타일 세팅
    		if(level == 0){

    			if(list[i].name==''){
    				$(myGrid2.gridBodyObject.children('tr')[i]).addClass('level_first_v_empty');
    			}else{
    				$(myGrid2.gridBodyObject.children('tr')[i]).addClass('level_first_v');
    			}

    		}else{	//level == 1

    			var tr = $(myGrid2.gridBodyObject.children('tr')[i]);
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


  	//체크박스 선택
  	clickCheckbox: function(obj, index, knd){		//* knd : 'PROJECT' or 'ACTIVITY'

  		if('${baseUserLoginInfo.orgId}' == '${baseUserLoginInfo.applyOrgId}'){
  			var projectId = '';
  	        var activityId = '';

  	        if(knd == 'PROJECT'){
  	            projectId = myGrid.getList()[index].projectId;
  	        }else if(knd == 'ACTIVITY'){
  	            projectId = myGrid2.getList()[index].projectId;
  	            activityId = myGrid2.getList()[index].activityId;
  	        }

  	        /* alert('projectId:::' + projectId + ', activityId:::' + activityId);
  	        return; */

  	        var url = contextRoot + "/project/changeUserDefaultPjtAct.do";
  	        var param = {
  	                knd         : knd,

  	                projectId   : projectId,            //project id
  	                activityId  : activityId,           //activity id

  	                userId      : g_masterUserId,       //user id

  	                defaultYn   : 'Y'                   //default 여부 값
  	        };


  	        var callback = function(result){

  	            var obj = JSON.parse(result);

  	            //세션로그아웃 >> 재로그인
  	            if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
  	                window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
  	                return;
  	            }

  	            var cnt = obj.resultVal;    //결과수

  	            if(obj.result == "SUCCESS"){ //alert("저장하였습니다!");
  	                toast.push("저장하였습니다!");

  	              if(knd == 'ACTIVITY'){
                      fnObj.setActivityListInfo();    //프로젝트 Activity list 재 로딩(수정결과 반영)
                  }

  	               /*  if(knd == 'PROJECT'){
  	                    var list = document.getElementsByName('defaultPjt');
  	                    for(var i=0; i<list.length; i++){
  	                        list[i].checked = (i==index) ? true:false;        //체크여부
  	                    }
  	                }else if(knd == 'ACTIVITY'){
  	                    fnObj.setActivityListInfo();    //프로젝트 Activity list 재 로딩(수정결과 반영)
  	                } */
  	            }
  	        };

  	        commonAjax("POST", url, param, callback);
  		}

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