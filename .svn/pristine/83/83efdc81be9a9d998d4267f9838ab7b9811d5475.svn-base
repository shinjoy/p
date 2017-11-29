<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->
<style>
.h3_title_line {
    background: rgba(96, 109, 118, 0.44);
    height: 1px;
    margin-bottom: 12px;
}
.datagrid_basic {
    letter-spacing: -0.08px;
    width: 100%;
    border: #c3c3c3 solid 1px;    
}
.datagrid_input {
    height: 23px;
    line-height: 20px;
    border: #cecece solid 1px;
    text-indent: 4px;
    box-sizing: border-box;
    vertical-align: middle;
    color: #858585;
}
</style>
<!-- -------- each page css :E -------- -->



<div style="padding:10px; background-color:white;min-height:500px;">
	<form name="myForm" method="post">
		<div style="height: 5px"></div>
		<input type="hidden" name="businessGrpSeq" id="businessGrpSeq">
		<table cellpadding="0" cellspacing="0" class="datagrid_basic" style="width: 100%;">
			<!-- AXFormTable : width 100% >> 98% (재정의) -->
			<colgroup>
				<col width="30%" />
				<col width="*"/>
			</colgroup>
			<thead>
                <tr>	
                	<th>비즈니스 그룹명</th>
                	<th>설명</th>
                </tr>
            </thead>
			<tbody>
				<tr>
					<td>
						<span id="deptClassSelectTag"></span> 
						<input id="businessGrpNm" type="text" name="businessGrpNm" placeholder="비즈니스 그룹명" value="" class="w50 datagrid_input" />
					</td>
					<td>
							<input id="description" type="text" name="description"
								placeholder="상세설명을 입력하세요." value="" class="w100 datagrid_input" />
					</td>
				</tr>
			</tbody>
		</table>

		<div style="margin: 5px; text-align: center;">
			<div class="btn_baordZone2" id="btn_save" style="margin-top:10px;">
				<a href="javascript:fnObj.doSave();" class="btn_blueblack" id="registerBtn">추가</a> 
				<a href="javascript:fnObj.doSave();" class="btn_blueblack" id="updateBtn" style="display:none;">수정</a> 
				<a href="javascript:fnObj.tryDel();" class="btn_witheline" id="deleteBtn" style="display: none;">삭제</a> 
				<a href="javascript:fnObj.doNew();" class="btn_witheline" id="newBtn" style="display: none;">신규등록</a>
			</div>
		</div>
	</form>

	<div style="height: 5px"></div>
	<div class="h3_title_line"></div>
	<div class="board_classic">
            <div class="leftblock">
            	<span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
            </div>
            <div class="rightblock">
                <input id="srch_grpNm" type="text" placeholder="비즈니스 그룹명 " onkeypress="if(event.keyCode==13) fnObj.doSearch(1);" class="input_txt_b" title="비즈니스 그룹명 "" />
                <a href="#" onclick="fnObj.doSearch(1);" class="btn_wh_bevel">검색</a>
            </div>
        </div>
	   <!-- 프로젝트 목록 -->
		<table id="SGridTarget" class="datagrid_basic" summary="비즈니스 그룹 목록">
            <caption>비즈니스 그룹 목록</caption>
            <colgroup>
            	<col width="5%" /> 
               <col width="20%" />
               <col width="20%" />               
               <col width="10%" />
           </colgroup>
            <thead>
                <tr>
                	 <th scope="col">순번</th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">비즈니스 그룹명<em>정렬</em></a></th>
                    <th scope="col">설명</th>
                    <th scope="col"><a href="#" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">등록일자<em>정렬</em></a></th>
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
     
</div>



<script type="text/javascript">

//Global variables :S ---------------
var lang = '${baseUserLoginInfo.lang}';
var mode ="new";
var groupList = [];

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
    		 {key:"businessGrpNm"		},
             {key:"description"		},
             {key:"createDate"		},
            ],
            
            body : {
                onclick: function(obj){
                	fnObj.setBusinessGroup(obj.item);      	
                }
            }
            
    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';    		
    	rowHtmlStr +=	 '<td scope="row">#[0]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td>#[3]</td>';
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
			colList : ['businessGrpNm', 'createDate'],
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
    	    
    	    	var url = contextRoot + "/system/getBusinessGroupList.do";
    	    	var param = {
    			    			pageSize: pageSize,
    			    			pageNo:	page,
    			    			
    			    			sortCol: mySorting.nowSortCol,
    			    			sortVal: mySorting.nowDirection,
    			    			
    			    			//knd: '',	//$('#srch_knd').val(),				//검색 종류
    			    			businessGrpNm: $('#srch_grpNm').val()			//검색 어
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
    				
    				//그룹명 리스트
    				groupList = list;
    				
    				//전체 건수 세팅
    				$('#total_count').html(obj.totalCount);
    	    		
    	    	};
    	    	
    	    	commonAjax("POST", url, param, callback);
    	    	
    	    
    },        
  	//저장
    doSave: function(){ 
    	
    	//-------------------- validation :S --------------------
    	var frm = document.myForm;
        
    	if(isEmpty(frm.businessGrpNm.value)){		//부서분류
    		dialog.push({body:"<b>확인!</b> 그룹명을 입력해주세요!", type:"", onConfirm:function(){frm.businessGrpNm.focus();}});
    		return;
    	}
    	if(isEmpty(frm.description.value)){			//부서코드
    		dialog.push({body:"<b>확인!</b> 상세설명을 입력해주세요.", type:"", onConfirm:function(){frm.description.focus();}});
    		return;
    	}
    	
    	//----- 같은 비즈니스 그룹명이 있는 경우 ---
    	if(mode == "new"){
			for(var i = 0; i < groupList.length ;i++){
				if(groupList[i].businessGrpNm == frm.businessGrpNm.value){
					dialog.push({body:"<b>확인!</b> 중복된 비즈니스 그룹명 입니다! <br><br> 다른 비즈니스 그룹명을 입력해주세요!", type:"warning", onConfirm:function(){frm.businessGrpNm.focus();}});
		    		return;
				}
			} 
    	}
    	    	
    	//-------------------- validation :E --------------------
    	
    	var url = contextRoot + "/system/setBusinessGroup.do";
    	var param = {
    			mode: mode,			//화면 모드 mode : "new", "update"
    			businessGrpNm			: frm.businessGrpNm.value,
    			description		: frm.description.value,
    			businessGrpSeq : frm.businessGrpSeq.value
    	}
    	
    	var callback = function(result){
    			
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;	//결과수
    		
    		if(obj.result == "SUCCESS"){ 
    			fnObj.doNew();
    			fnObj.doSearch();			//목록화면 재조회 호출.
    			parent.myBusinessModal.close();
    		}else{
    			//alertMsg();
    			alert("저장도중 오류가 발생하였습니다.");
    			return;
    		}
    		
    	};
    	
    	commonAjax("POST", url, param, callback);
    },//end doSave
    
    //목록 클릭시 수정모드로 
    setBusinessGroup : function(item){
    	$("#businessGrpNm").val(item.businessGrpNm);
    	$("#description").val(item.description);
    	$("#businessGrpSeq").val(item.businessGrpSeq);
    	mode = "update";
    	$("#deleteBtn").show();
    	$("#updateBtn").show();
    	$("#newBtn").show();
    	$("#registerBtn").hide();
    },
    //신규등록 버튼 클릭시
    doNew : function(){
    	$("#businessGrpNm").val("");
    	$("#description").val("");
    	$("#businessGrpSeq").val("");
    	$("#updateBtn").hide();
    	$("#deleteBtn").hide();
    	$("#newBtn").hide();
    	$("#registerBtn").show();
    	mode = "new";
    },
    
    tryDel : function(){
		var frm = document.myForm;
        
    	if(isEmpty(frm.businessGrpSeq.value)){		//비즈니스 그룹명 선택여부
    		dialog.push({body:"<b>확인!</b> 삭제하실 그룹명을 선택해주세요!", type:"", onConfirm:function(){return;}});
    		return;
    	}
    	
    	var url = contextRoot + "/system/deleteBusinessGroup.do";
    	var param = {
    			businessGrpSeq : frm.businessGrpSeq.value
    	}
    	
    	var callback = function(result){
    			
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;	//결과수
    		
    		if(obj.result == "SUCCESS"){    
    			alert("삭제되었습니다.");
    			fnObj.doNew();
    			fnObj.doSearch();			//목록화면 재조회 호출.
    		}else{
    			//alertMsg();
    			alert("삭제도중 오류가 발생하였습니다.");
    			return;
    		}
    		
    	};
    	
    	commonAjax("POST", url, param, callback);
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
	
});

</script>