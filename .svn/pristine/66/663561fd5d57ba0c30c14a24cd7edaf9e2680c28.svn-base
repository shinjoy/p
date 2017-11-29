<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<section id="detail_contents">
	<!-- 게시판 정렬목록 -->
	<div class="carSearchBox">
		<label>
			<span class="carSearchtitle">소속관계사</span>
			<select id="selectOrgId" name="selectOrgId" onChange="fnObj.doSearch(1);"  class="select_b" title="관계사 선택"></select>
		</label>
		<select id="searchType" class="select_b mgl30">
			<option value="name">이름</option>
			<option value="id">아이디</option>
		</select>
		<input id="searchText" type="text" placeholder="검색내용" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_b2 w200px mgl10" title="관계사 코드 검색" /><a href="javascript:fnObj.doSearch(1);" class="btn_g_black mgl10"><em>검색</em></a>
		<!-- <a href="#" onclick="fnObj.doSearch(1);" class="btn_wh_bevel">검색</a>	 -->
	</div>

	<div class="board_classic mgt20">
		<div class="leftblock">
			<span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
			<select id="sel_page_size" onChange="fnObj.setPageSize(true);" class="sh_count_type" title="정렬방법 선택">
				<option value="10">10개씩 보기</option>
				<option value="15" selected>15개씩 보기</option>
				<option value="30">30개씩 보기</option>
				<option value="50">50개씩 보기</option>
			</select>
		</div>
	</div>
    <!--/ 게시판 정렬목록 /-->
	<!-- 프로젝트 목록 -->
	<table id="SGridTarget" class="tb_list_basic" summary="관계사 목록">
		<caption>관계사 목록</caption>
		<colgroup>
			<col width="5%" />
			<col width="7%" />
			<col width="7%" />
			<col width="8%" />
			<col width="6%" />
			<col width="10%" />
			<col width="10%" />
			<col width="33%" />
		</colgroup>
        <thead>
            <tr>
                <th scope="col">순번</th>
                <th scope="col"><a href="#" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">사원명<em>정렬</em></a></th>
                <th scope="col"><a href="#" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">사번<em>정렬</em></a></th>
                <th scope="col"><a href="#" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">사원아이디<em>정렬</em></a></th>
                <th scope="col">직위</th>
                <th scope="col"><a href="#" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">소속회사<em>정렬</em></a></th>
               	<th scope="col">소속관계사</th>
            	<th scope="col">추가관계사</th>
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
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

var myOrgModal = new AXModal();	// instance


var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs
var orgCodeCombo;				//소속관계사

var g_assetId = '';				//선택하여 수정대상인 자산id


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
		var params = {'authOrgId':'N', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, null, '/common/getOrgCodeCombo.do', params);	//ORG코드(콤보용) 호출
		for(var i = 0 ;i < orgCodeCombo.length ;i++){
			var item = orgCodeCombo[i];
			$("<option />",{ value : item.orgId , text : item.orgNm}).appendTo("#selectOrgId");
			var orgId = '${baseUserLoginInfo.applyOrgId}';
			$("#selectOrgId").val(orgId);
		}

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
            //{key:"chk",				formatter:function(obj){return ("<input type='checkbox' name='mCheck' value='" + obj.value + "' onclick='fnObj.clickCheckbox(this, " + obj.index + ");' " + ((obj.value==1)?"checked":"") + " />");}},
            {key:"rnum"			},
            {key:"userName"		},
            {key:"showEmpNo"	},
            {key:"loginId"		},
            {key:"rankNm"		},
            {key:"companyNm"	},
            {key:"orgNm"		,	formatter:function(obj){
            							return "<span class='tagsOrg'>"+ obj.value +(obj.item.roleNm != null ? "-"+obj.item.roleNm.replace('W','<font color="#E7A1B0"><b>W</b></font>')+'</span>' : '</span><font color=red>미등록</font>')+"";
            }},
            {key:"OrgAccessType",	formatter:function(obj){
						var orgIdStr = obj.item.orgIds;
						var cpnNmStr = obj.item.cpnNms;

						var html = "<div>";
						if(orgIdStr != undefined){
							var orgIdAttr = orgIdStr.split(",");
							var cpnNmAttr = cpnNmStr.split(",");
							for(var i = 0 ; i < orgIdStr.length ;i++){
								var orgId = orgIdAttr[i];
								var cpnNm = cpnNmAttr[i];
								if(orgId != undefined){
									var cpnNmArr = cpnNm.split("VII@");
									html += "<span class='tagsOrg'>"+ cpnNmArr[0]+"-";
									if(cpnNmArr[1] == ''){
										html += "<font color=red>미등록</font></span>";
									}else{
										var roleTmp = cpnNmArr[1].replace('W','<font color="#E7A1B0"><b>W</b></font>').replace('R','<font color="#1589FF"><b>R</b></font>')
										html += roleTmp+"</span>";
									}

								}
							}
						}
						html += "</div>";
						return html;
            	}
			}
            ],

            body : {
                onclick: function(obj){
                	fnObj.openOrgPopup(obj.item);
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	//rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td>#[0]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td>#[1]</td>'; //사원명
    	rowHtmlStr +=	 '<td class="txt_letter0">#[2]</td>'; //사번
    	rowHtmlStr +=	 '<td class="txt_letter0">#[3]</td>'; //사원아이디
    	rowHtmlStr +=	 '<td>#[4]</td>'; //직위
    	rowHtmlStr +=	 '<td>#[5]</td>'; //소속회사
    	rowHtmlStr +=	 '<td class="txt_left">#[6]</td>'; //소속관계자
    	rowHtmlStr +=	 '<td class="txt_left">#[7]</td>'; //추가관계사권한
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
			colList : ['userName','empNo', 'loginId', 'companyNm'],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
		});
    	//-------------------------- 소팅 설정 :E ----------------------------

    	mySorting.setSort(1);

    	//-------------------------- 모달창 :S -------------------------
    	myOrgModal.setConfig({
    		windowID:"myModalCT2",
    		mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:false,
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


    	var url = contextRoot + "/system/getUserListForOrgId.do";
    	var param = {
		    			pageSize: pageSize,
		    			pageNo:	page,

		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,

		    			orgId : $("#selectOrgId").val(),
		    			searchType: $('#searchType').val(),		//사용자 아이디
		    			searchText : $("#searchText").val() 		//사용자이름
		    		};


    	var callback = function(result){

    		var obj = JSON.parse(result);


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

    	pageSize = $('#sel_page_size').val();

    	//검색도 바로할 경우 ... isSearch ... true
		if(isSearch){
			fnObj.doSearch(1);
    	}
    },
    openOrgPopup : function(obj){
    	var url = "../system/orgAuthCompanyRegister.do";
    	var params = {
    			selectOrgId : obj.orgId,
    			selectUserId : obj.userId,
    			selectUserName : obj.userName,
    			selectUserRankNm : obj.rankNm,
    			selectOrgName : $("#selectOrgId option:selected").text()
    	};

    	myOrgModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '관계사 권한설정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 10,
    		width: 1300,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT2').draggable();
    },
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