<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<style>
.datagrid_basic {
    letter-spacing: -0.08px;
    width: 100%;
    border: #c3c3c3 solid 1px;    
}
</style>



  <section style="padding:20px;min-height:600px;">
        <!-- 게시판 정렬목록 -->                     
        <div class="board_classic">
            <div class="leftblock">
            	<span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
                <select id="sel_page_size" onChange="fnObj.setPageSize(true);" class="sh_count_type" title="정렬방법 선택">
                	<option value="10">10개씩 보기</option>
                	<option value="15" selected>15개씩 보기</option>
                </select>
            </div>
            <div class="rightblock">
                <input id="srch_cpnId" type="text" placeholder="회사 코드 검색" style="padding-right:1px;" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="회사 코드 검색" />
                <input id="srch_cpnNm" type="text" placeholder="회사명 검색" onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="회사명 검색" />
                <a href="#" onclick="fnObj.doSearch(1);" class="btn_wh_bevel">검색</a>
            </div>
        </div>
        <!--/ 게시판 정렬목록 /-->
        <!-- 프로젝트 목록 -->
		<table id="SGridTarget" class="datagrid_basic" summary="관계사 회사목록">
            <caption>관계사 회사목록</caption>
            <colgroup>
               <col width="10%" />
               <col width="40%" />               
               <col width="50%" />
           </colgroup>
            <thead>
                <tr>
                    <th scope="col">순번</th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">회사 코드<em>정렬</em></a></th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">회사명<em>정렬</em></a></th>
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



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs

var curPageNo = 1;				//현재페이지번호
var pageSize = 15;				//페이지크기(상수 설정)


//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	
	//################# init function :S #################
	
	//선로딩코드
	preloadCode: function(){
		
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
            {key:"rnum"		},
            {key:"cpnId"		},
            {key:"cpnNm"		},
            ],
            
            body : {
                onclick: function(obj){
                	fnObj.doSetParent(obj.item);
                	               	
                }
            }
            
    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';    	
    	//rowHtmlStr +=	 '<td>#[0]</td>';    	
    	rowHtmlStr +=	 '<td scope="row">#[0]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
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
			colList : ['cpnId','cpnNm'],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
		});
    	//-------------------------- 소팅 설정 :E ----------------------------
    	
    	
    },//end pageStart.
  	//################# init function :E #################
    
    
    //################# else function :S #################
    
  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색 
    	
    	if(page==null) page=1;
    
    	var url = contextRoot + "/system/getOrgIbCompanyList.do";
    	var param = {
		    			pageSize: pageSize,
		    			pageNo:	page,
		    			
		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,
		    			
		    			cpnId: $('#srch_cpnId').val(),			//검색 어
		    			cpnNm: $('#srch_cpnNm').val()			//검색 어
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
    
    
  	//재정렬
  	doSort : function(index){
  		
  		mySorting.setSort(index);
  		
  		fnObj.doSearch();
        
  		myGrid.refresh();
        mySorting.applySortIcon();			//소팅화면적용
  	},//doSort
  	
    //부모창에 전달.
  	doSetParent : function(item) {
		parent.fnObj.updateValue(item);
		parent.myModal.close();
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