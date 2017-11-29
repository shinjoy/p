<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



	<div class="mo_container">
		<div class="board_classic">
			<div class="leftblock">
				<span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
			</div>
			<div class="rightblock">
				<input id="srch_comNm" type="text" placeholder="회사명 " onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="회사명 "" />
				<a href="#" onclick="fnObj.doSearch(1);" class="btn_wh_bevel">검색</a>
		    </div>
		</div>
		<!-- 프로젝트 목록 -->
		<table id="SGridTarget" class="datagrid_basic lineadd" summary="비즈니스 그룹 목록">
			<caption>선택가능한 소속 회사 정보</caption>
			<colgroup>
				<col width="80" /> 
				<col width="20%" />
				<col width="*" /> 
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col"><a href="#" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">회사 코드<em>정렬</em></a></th>
					<th scope="col"><a href="#" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">회사 명<em>정렬</em></a></th>
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
		<h3 class="sys_grid_title mgt20">[ 선택 소속회사 ]</h3>
		<div class="grayComBox" style="height:48px;">
			<form name="myForm" method="post" >
				<div id="selectCompInfo"></div>
			</form>
		</div>
		<div class="btnZoneBox"><a class="p_withelin_btn" href="#" onclick="fnObj.doSave()">적용</a></div>
	</div>



<script type="text/javascript">

//Global variables :S ---------------
var lang = '${baseUserLoginInfo.lang}';
var mode ="new";
var orgId = "${targetOrgId}";
var targetList = [];

var g_targetCompanyList = '${targetCompanyList}';

var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs

var curPageNo = 1;				//현재페이지번호
var pageSize = 10;				//페이지크기(상수 설정)
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
    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {
    		
    		targetID : "SGridTarget",		//그리드의 id
    		
    		//그리드 컬럼 정보
    		colGroup : [    	
    		 {key:"rnum"		},
    		 {key:"cpnId"		},
             {key:"cpnNm"		},
            ],
            
            body : {
                onclick: function(obj){
                	fnObj.setCompanyList(obj.item);      	
                }
            }
            
    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';    		
    	rowHtmlStr +=	 '<td scope="row">#[0]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td><span class="txt_letter0">#[1]</span></td>';
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
			colList : ['cpnId', "replace(CPN_NM,'(주)','')"],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
		});
    	//-------------------------- 소팅 설정 :E ----------------------------
    	
    },//end pageStart.
  	//################# init function :E #################
  	//검색
    doSearch : function(page){
    	    	
    	    	if(page==null) page=1;
    	    
    	    	var url = contextRoot + "/system/addGroupingCompanyList.do";
    	    	var param = {
    			    			pageSize: pageSize,
    			    			pageNo:	page,
    			    			
    			    			sortCol: mySorting.nowSortCol,
    			    			sortVal: mySorting.nowDirection,
    			    			
    			    			//knd: '',	//$('#srch_knd').val(),				//검색 종류
    			    			orgId: orgId,			//검색 어
    			    			srch_comNm : $("#srch_comNm").val() //회사명
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
    					};
    	    		
    	    		myPaging.setPaging(pageObj);		//페이징 데이터 세팅	*** 1 ***
    	    		
    	    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
    									list: list,		//그리드 테이터
    									page: pageObj	//페이징 데이터
    	    						});
    	    		
    				mySorting.applySortIcon();		//소팅화면적용
    				
    				//그룹명 리스트
    				groupList = list;
    				
    				//전체 건수 세팅
    				$('#total_count').html(obj.totalCount);
    				
    	    	};
    	    	
    	    	commonAjax("POST", url, param, callback, false);
    	    	
    	    
    },
    
    //파라미터로 받은 소속회사 세팅 
    getCompanyParameterSet : function(){
    	var companyList =[];
    	
    	if(g_targetCompanyList != '') companyList = JSON.parse('${targetCompanyList}');
    	for(var i=0;i<companyList.length;i++){
    		
    		fnObj.setCompanyList(companyList[i]);
    	}


    	//창 내용에 따라 사이즈 재조정
		parent.myGroupingModal.resize();
    },
    
  	//저장
    doSave: function(){ 
    	
    	//-------------------- validation :S --------------------
    	if(targetList == null || targetList.length < 1){
    		alertM("관계사에 소속될 회사를 선택해주세요!");
    		return;
    	}
    
    	parent.fnObj.getIncludeCompany(targetList);
    	parent.myGroupingModal.close();
    },//end doSave
    
    //소속회사 선택
    setCompanyList : function(item){
    	for(var i = 0 ; i < targetList.length ;i++){
    		var value = targetList[i];
    		if(value.sNb == item.sNb){
    			return;
    		}
    	}
    	var str='<span class="employee_list" id="'+item.sNb+'_span">';
    	str+='<span class="fontBlue">'+item.cpnNm+'</span>';
    	str+='<a onclick="javascript:fnObj.tryDel('+item.sNb+');" class="btn_delete_employee"><em>삭제</em></a>, </span>';
    	$("#selectCompInfo").append(str);
    	/* $("<span />", { id: item.sNb+"_span", class: "tags", text : item.cpnNm, onClick : "fnObj.tryDel("+item.sNb+");"}).appendTo("#selectCompInfo"); */
    	targetList.push(item);
    	
    	
    },
    
    //소속회사 제거
    tryDel : function(sNb){
    	if(confirm("제거하시겠습니까?")){
			for(var i = 0 ;i < targetList.length ;i++){
				var item = targetList[i];
				if(sNb == item.sNb){
					targetList.splice(i,1);
					$("#"+sNb+"_span").remove();
				}
			}
    	}
    },
    

  	//재정렬
  	doSort : function(index){
  		
  		mySorting.setSort(index);
  		
  		fnObj.doSearch();
        
  		myGrid.refresh();
        mySorting.applySortIcon();			//소팅화면적용
  	}//doSort
       
    
  	//################# else function :E #################
    
};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();
	fnObj.getCompanyParameterSet();
	
});

</script>