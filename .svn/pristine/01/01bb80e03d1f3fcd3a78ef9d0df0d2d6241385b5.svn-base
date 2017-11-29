<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<section id="detail_contents">
    <form id="myForm" name="myForm" method="post">
   		 <input type="hidden" id="orgId" name="orgId">
   	</form>
    <!-- 게시판 정렬목록 -->
    <div class="sys_search_box">
		<div id="AXSearchTarget" class="fl_block"></div>
	</div>

	<div class="board_classic mgt10">
		<div  class="leftblock">

		<span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
	    <select id="sel_page_size" name="sel_page_size" onChange="fnObj.setPageSize(true);" class="sh_count_type" title="정렬방법 선택">
	    	<!-- <option value="5">5개씩 보기</option> -->
	    	<option value="10">10개씩 보기</option>
	    	<option value="15">15개씩 보기</option>
	        <option value="30">30개씩 보기</option>
	        <option value="50">50개씩 보기</option>
	    </select>
		</div>

    </div>
   <!--  <div class="board_classic">
        <div class="leftblock">

        </div>
        <div class="rightblock">
            <input id="srch_cpnId" type="text" placeholder="검색어입력" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="검색어 검색" />
            <input id="srch_cpnNm" type="text" placeholder="관계사 명 " onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="관계사 명 검색" />
            <input id="srch_cpnId" type="text" placeholder="관계사 코드" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="관계사 코드 검색" />
            <a href="#" onclick="fnObj.doSearch(1);" class="btn_wh_bevel">검색</a>
        </div>
    </div> -->
    <!--/ 게시판 정렬목록 /-->
    <!-- 프로젝트 목록 -->
	<table id="SGridTarget" class="tb_list_basic mgt10" summary="관계사 목록">
    	<caption>관계사 목록</caption>
        <colgroup>
           <col width="4%" />			<!-- 순번 -->
           <col width="10%" />			<!-- 비지니스그룹명 -->
           <col width="10%" />			<!-- 관계사명 -->
           <col width="6%" />			<!-- 관계사회사코드 -->
           <col width="10%" />			<!-- 추가소속회사 -->

           <col width="11%" />			<!-- 설명 -->
           <col width="5%" />			<!-- 관계사 prefix -->
           <col width="5%" />			<!-- 시스템코드 최상위 권한여부 -->
           <col width="5%" />			<!-- 프로젝트 사용여부 -->
           <col width="5%" />			<!-- 메일 사용여부 -->
           <col width="5%" />			<!-- 소속직원사용여부 -->
           <col width="5%" />			<!-- 관계사 유효여부 -->
           <col width="6%" />			<!-- 달력데이터 -->

           <col width="8%" />			<!-- 로고 -->
           <col width="6%" />			<!-- 등록일 -->
       </colgroup>
       <thead>
            <tr>
                <th scope="col">순번</th>
                <th scope="col"><a href="#;" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">비즈니스 그룹명<em>정렬</em></a></th>
                <th scope="col"><a href="#;" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">관계사 명<em>정렬</em></a></th>
                <th scope="col"><a href="#;" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">관계사<br>회사코드<em>정렬</em></a></th>
                <th scope="col">추가소속회사</th>
                <th scope="col">설명</th>
                <th scope="col">관계사 PREFIX</th>
                <th scope="col">최상위<br>권한여부</th>
                <th scope="col">${baseUserLoginInfo.projectTitle}<br>사용여부</th>
                <th scope="col">메일<br>사용여부</th>
                <th scope="col">소속직원<br>사용여부</th>
                <th scope="col">관계사<br>유효여부</th>
                <th scope="col">달력데이터</th>

            	<th scope="col">로고 정보</th>
            	<th scope="col"><a href="#;" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">등록 일자<em>정렬</em></a></th>
            </tr>
        </thead>
        <tbody>
		</tbody>
	</table>
	<!--/ 프로젝트 목록 /-->
    <!-- 페이지 목록 -->
    <div class="btnPageZone" id="btnPageZone">
         <button type="button" class="pre_end_btn"><em>맨처음 페이지</em></button>
         <button type="button" class="pre_btn"><em>이전 페이지</em></button>
         <button type="button" class="next_btn"><em>다음 페이지</em></button>
         <button type="button" class="next_end_btn"><em>맨마지막 페이지</em></button>
    </div>
    <div class="btn_baordZone" id="btn_register">
        <a href="javascript:fnObj.doRegister();" id="btn_new" class="btn_blueblack btn_auth">신규등록</a>
    </div>
    <!--/ 페이지 목록 /-->
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

var myModal = new AXModal();	// instance

var mySearch = new AXSearch(); 	// instance
var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs


var g_assetId = '';				//선택하여 수정대상인 자산id
var pageSelectTag =[];

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

		/* var obj ={optionValue : "10" , optionText : "10개씩 보기" };
		obj.optionValue = "10";
		obj.optionText = "10개씩 보기";
		pageSelectTag.push(obj);
		obj.optionValue = "15";
		obj.optionText = "15개씩 보기";
		pageSelectTag.push(obj);

		console.log(pageSelectTag); */

		/* pageSelectTag.push({optionValue : "10" , optionText : "10개씩 보기" });
		pageSelectTag.push({optionValue : "15" , optionText : "15개씩 보기" });
		pageSelectTag.push({optionValue : "20" , optionText : "20개씩 보기" });
		pageSelectTag.push({optionValue : "30" , optionText : "30개씩 보기" }); */




	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 검색 :S ---------------------------
    	mySearch.setConfig({
            targetID : "AXSearchTarget",
            theme : "AXSearch",

            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },

            onsubmit: function(){	// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
				fnObj.doSearch(1);
			},

			rows:[
					{display:true, addClass:"", style:"", list:[
   						/*
						{label:"", type:"selectBox", width:"", key:"sel_page_size", addClass:"sh_count_type", valueBoxStyle:"",value:"",
							options: pageSelectTag,
							AXBind:{
								type:"select", config:{
									onchange:function(){
										fnObj.setPageSize(true);	//조회
									}
								}
							},
						}, */
   						{type:"inputText", width:"200", key:"srch_cpnId", placeholder:"검색어입력", addClass:"secondItem mgl10", valueBoxStyle:"", value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},
   						{type : "button",  width:"40", value : "검색", addClass:"mgl10",
	   						onclick: function(){
								//검색호출
								fnObj.doSearch(1);

							}

   						}

   					]},
			     ]

        });//end mySearch.setConfig
    	//-------------------------- 검색 :E ---------------------------

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            //{key:"chk",				formatter:function(obj){return ("<input type='checkbox' name='mCheck' value='" + obj.value + "' onclick='fnObj.clickCheckbox(this, " + obj.index + ");' " + ((obj.value==1)?"checked":"") + " />");}},
            {key:"rnum"			},
            {key:"businessGrpNm"},
            {key:"cpnNm"		},
            {key:"cpnId"		},
            {key:"orgCode",			formatter:function(obj){return '<font color=#1589FF><b>' + obj.value + '</b></font>';}},
            {key:"codeMgmtAdminYn",	formatter:function(obj){
            							return obj.value;
            						}},
            {key:"projectUseYn"	},
            {key:"useYn"		},
            {key:"enable"		},
            {key:"minMaxYear",		formatter:function(obj){
	            						if(isEmpty(obj.item.minYear)) return '';
	            						else return obj.item.minYear + ' ~ ' + obj.item.maxYear;
	            					}},
            {key:"description"	},
            {key:"createDate",		formatter:function(obj){return (obj.item.createDate).replace(/-/gi,'/');}},
            {key:"orgLogo",			formatter:function(obj){
										if(obj.item.orgLogo == null){
											return '';
										}else{
											return ('<img width="110" height="30" src="data:image/png;base64,' + obj.item.orgLogo + '" />');
										}
									}
			},
			{key:"otherCpnList",	formatter:function(obj){
										if(!isEmpty(obj.value)) return obj.value.split('|').join('<br>');
									}
			},
			{key:"mailUseYn",		formatter:function(obj){
										var rslt = obj.item.mailUseYn;
										if(rslt == 'Y') rslt += ('<br/>(' + (obj.item.mailServiceName=='mailplug'?'메일플러그':'기타') + ')<br/>' + obj.item.mailUrl);
										return rslt;
									}
			}
            ],

            body : {
                onclick: function(obj){
                	fnObj.moveToUpdatePage(obj.item);
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr style="cursor:pointer;">';
    	//rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td scope="row">#[0]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td class="txt_left">#[1]</td>';
    	rowHtmlStr +=	 '<td class="txt_left">#[2]</td>';
    	rowHtmlStr +=	 '<td>#[3]</td>';
    	rowHtmlStr +=	 '<td class="txt_left">#[13]</td>';
    	rowHtmlStr +=	 '<td class="txt_left">#[10]</td>';
    	rowHtmlStr +=	 '<td>#[4]</td>';

    	rowHtmlStr +=	 '<td>#[5]</td>';
    	rowHtmlStr +=	 '<td>#[6]</td>';
    	rowHtmlStr +=	 '<td>#[14]</td>';
    	rowHtmlStr +=	 '<td>#[7]</td>';
    	rowHtmlStr +=	 '<td>#[8]</td>';
    	rowHtmlStr +=	 '<td>#[9]</td>';
    	rowHtmlStr +=	 '<td>#[12]</td>';
    	rowHtmlStr +=	 '<td>#[11]</td>';

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
			colList : ['businessGrpNm','cpnNm', 'cpnId', 'createDate'],
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
    	//페이지크기 세팅
		fnObj.setPageSize();

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	if(page==null) page=1;

    	var url = contextRoot + "/system/getOrgCompanyList.do";
    	var param = {
		    			pageSize: pageSize,
		    			pageNo:	page,

		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,

		    			//knd: '',	//$('#srch_knd').val(),				//검색 종류
		    			//cpnNm: $('#srch_cpnNm').val(),		//검색 어
		    			cpnId : $("input[name=srch_cpnId]").val() 		//회사
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

			mySorting.applySortIcon();		//소팅화면적용


			//전체 건수 세팅
			$('#total_count').html(obj.totalCount);

    	};

    	commonAjax("POST", url, param, callback);

    },//end doSearch



    //페이지 사이즈 세팅
    setPageSize: function(isSearch){

    	pageSize = $('select[name=sel_page_size]').val();

    	//검색도 바로할 경우 ... isSearch ... true
		if(isSearch){
			fnObj.doSearch(1);
    	}
    },

  	//신규 등록 doRegister
  	doRegister: function(){

  		location.href="../system/orgCompanyRegister.do";

  	},//doRegister
  	//재정렬
  	doSort : function(index){

		mySorting.setSort(index);

  		fnObj.doSearch(1);

  		//소팅
        myGrid.refresh();
        mySorting.applySortIcon();			//소팅화면적용

  	},//doSort

  	//수정페이지로 이동.
  	moveToUpdatePage : function(item){
  		//console.log(item);
  		$("#orgId").val(item.orgId);
  		$("#myForm").attr("action",contextRoot +"/system/orgCompanyRegister.do").submit();

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
});
</script>