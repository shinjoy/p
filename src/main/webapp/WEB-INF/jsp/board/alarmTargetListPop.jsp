<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% 
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

%>
	<div class="popModal_wrap">
		<h3 class="pop_title">대상자조회</h3>
		<!-- <a href="javascript:window.close();" class="popup_close"><em>닫힘</em></a> -->
		<div class="conBox">
			<div class="carSearchBox">
			<span class="carSearchtitle"><label for="IDNAME01">분류</label></span>
         	<span class="radio_list2 divide_line" id="alarmTargetTypeDiv"></span>
			<!-- <button name="reg_btn" onclick="fnObj.doSearch();" style="margin-left:5px;padding:5px 20px 5px 20px; border:1px solid #bbbfce;border-radius:2px; background-color:#f1f1f1;">검색</button> -->
		</div>
		<table id="SGridTarget" class="tb_list_basic mgt30" summary="공지대상자리스트">
		       <caption>
		          공지대상자 리스트
		       </caption>
		       <colgroup>
		       		<col width="60" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
               </colgroup>
               <thead>
               	 <tr>
           	 		<th scope="col">번호</th>
         		 	<th scope="col">소속부서</th>
         		 	<th scope="col">이름</th>
         		 	<th scope="col">직책</th>
         		 	<th scope="col">사번</th>
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
    
    </div>
   </div>  



<script type="text/javascript">

//Global variables :S ---------------

//공통코드

var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs

var curPageNo = 1;				//현재페이지번호
var pageSize = 15;				//페이지크기(상수 설정)

var g_gridListStr;							  //그리드 데이터 string (객체화되기전 문자열 json... JSON.parse 로 객체로 만들어사용) (증권사 필터링을 위해..)
var g_codeSet ='NOTICE_TARGET_TYPE';

//Global variables :E ---------------

/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
		
	preloadCode : function(){
		
		var alarmTargetType = getBaseCommonCode(g_codeSet, '', 'CD', 'NM', null, '', '', {orgId : "${baseUserLoginInfo.applyOrgId}"} );	
		if(alarmTargetType == null){
			alarmTargetType = [{'CD': '', 'NM':'선택'}];
		}
		
		var alarmTarget=createRadioTag('alarmTarget', alarmTargetType, 'CD', 'NM', 'NOTICE', 0, 0, 'fnObj.doSearch();', null);
		$("#alarmTargetTypeDiv").html(alarmTarget);
	},
		
	//화면세팅
    pageStart: function(){
    			
    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	 var configObj = {
    		
    		targetID : "SGridTarget",		//테이블아이디
    		
    		//그리드 컬럼 정보
    		colGroup : [    		
            {key : "no", 	formatter : function(obj) { 
								return (1 + obj.index) + ( ( obj.page.pageNo - 1) * obj.page.pageSize);
			}},
            {key:"deptNm"},
            {key:"usrNm"},
            {key:"position"},
            {key:"sabun"}        
            ]
            
    	};	
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td>#[3] </td>';				
    	rowHtmlStr +=	 '<td class="txt_num">#[4]</td>';	
    	rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr; 
        
    	
    	myGrid.setConfig(configObj); 
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
    },//end pageStart.
    
    //검색
    doSearch: function(page){ 
    	
    	var searchType='';	
 	    var alarmTarget=$(':input:radio[name="alarmTarget"]:checked').val();	
 	 
 	    var url = contextRoot+"/common/getStaffListNameSortForPaging.do";
 		var param = {
 				searchType	: alarmTarget,	//검색 타입 (B_CARD,MANAGER -법인카드,팀장)	
 				applyOrgId  : '${baseUserLoginInfo.applyOrgId}',
 				mainYn      : 'Y', 
 				deptOrder   : 'Y',
 				pageSize	: pageSize,
 				pageNo		: (page == null ? 1 : page)
 		};   	
    	var callback = function(result){
    		
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;		//결과수
    		var list = obj.resultList;		//결과데이터JSON
			
    		curPageNo = obj.pageNo;			//현재페이지세팅(global variable)
    		
    		
    		var pageObj = {						//페이징 데이터
					pageNo : curPageNo,
					pageSize : pageSize,
					pageCount: obj.pageCount,
					listTotalCount : obj.totalCount
				};
    		
    		myPaging.setPaging(pageObj);		//페이징 데이터 세팅	*** 1 ***
    		
    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list,		//그리드 테이터
								page: pageObj	//페이징 데이터
    						});
    		
    		g_gridListStr = result;				//따로 전역변수에 넣어둔다
    	};
    	
    
    	commonAjax("POST", url, param, callback, true, null, null);
    	
    },//end doSearch
    

};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	
	fnObj.pageStart();		//화면세팅		
	fnObj.doSearch();
});




</script>