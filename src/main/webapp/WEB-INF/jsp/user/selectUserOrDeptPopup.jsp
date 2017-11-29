<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<%--
//////////////////// 사원, 부서 선택 공통팝업 DESCRIPTION ////////////////////////

1. 팝업 시키는 부모화면
- 팝업 파라미터
	parentKey 		: 부모창으로 그대로 받는 사용자 정의된 키값(부모창에서 복수의 팝업이 열릴때 구분을 위함 ... 단일 종류로 열때는 필요없음) 
    isOnlyOne		: 선택건수 1개 여부			('Y': 한명(한부서), 	그외: 복수(default))	... default 'N'
    isAllOrg		: 전체 ORG 범위로의 여부		('Y': 전체ORG, 		그외: 나의권한ORG)	... default 'N'
    oneOrg			: 전달받은 한개의 ORG ID (나의 권한과 무관한 전달받은 ORG Id)
    isCloseBySelect	: 선택과동시에 창닫기 여부		('N': 안닫힌다,		그외: 닫힌다)			... default 'Y'
   	popupType		: 검색값 종류					('USER': 사원, 		'DEPT',: 부서)		... default 'USER'
   	isEnable		: 유효한 사원					('N': 퇴사자,		그외: 재직자)			... default 'Y'
   	isHiddenDept	: 부서트리 숨김여부			('Y': 트리 숨기기,	그외:보이게)			... default 'N'

- 콜백 함수
	fnObj.actionBySelData(list, parentKey);		//(선택한 Array Object, parentKey)
												//list object : [{orgId, orgNm, deptId, deptNm, userId, userName},...]

///////////////////////////////////////////////////////////////////////////////
 --%>


<!-- -------- each page css :S -------- -->
<style type="text/css">
#selDeptClass{
	height:23px;
}
#SGridTarget tbody td {
    padding: 2px 10px 0px;
    text-align: center;
}
#SGridTarget{
    border-color: #e6e6e6;
}
#SGridTarget2 tbody td {
    padding: 2px 10px 0px;
    text-align: center;
}
#SGridTarget2{;
    border-color: #e6e6e6;
}
.tb_regi_temp{
	border-top: #c7cdd8 solid 1px;
}
.tb_regi_temp tbody tr:first-child td {
    background: white;
	border-bottom: #e6e6e6 solid 1px;
}
.tb_list_basic tbody tr td:first-child {
    border-left: #ffffff solid 1px;
}
.tb_regi_temp tbody th {
    padding: 1px 10px 0px;
    text-align: center;
}
.user_list_in_dept {
	height:230px;
    /* max-height: 200px; */
    overflow-y: auto;
    border-bottom: #c7cdd8 solid 1px;
    border-right: #c7cdd8 solid 1px;
    border-left: #c7cdd8 solid 1px;
}
.user_list_in_dept2 {
	height:122px;
    /* max-height: 200px; */
    overflow-y: auto;
    border-top: #c7cdd8 solid 1px;
    border-bottom: #c7cdd8 solid 1px;
    border-right: #c7cdd8 solid 1px;
    border-left: #c7cdd8 solid 1px;
}
table.tb_list_basic { table-layout:fixed; }
table.tb_list_basic td { overflow: hidden; }
.btn_baordZone {
    border-top: #7f7f7f solid 0px;
    margin-top: 0px;
    padding-top: 7px;
    text-align: center;
}

</style>
<!-- -------- each page css :E -------- -->



<div style="padding:5px; background-color:white;">
	
	<table class="tb_regi_temp" style="height:420px;">
        <colgroup>
        	<col width="30%" />
            <col width="70" />
        </colgroup>
    	<tbody>
			<tr>
				<td height="20px;"><span style="display:none;">부서유형 <span id="deptClassSelectTag"></span></span><!-- 사용안함 -->
					<span id="orgSelectTag" class="radio_list"></span>
				</td>
				<td><span id="spanUserNameSrch">사원명 <input id="inUserName" name="inUserName" onkeypress="if(event.keyCode==13) fnObj.doSearchNm();" style="width:200px;" /></span></td>
			</tr>
			<tr>
				<td valign="top" <c:if test="${isHiddenDept eq 'Y'}">style="display:none;"</c:if> >
					<div style="overflow-y:auto; height:400px;">
					<div id="jstree" class="demo" style="margin-top:1em;"></div>
					</div>
				</td>
				
				<td valign="top" <c:if test="${isHiddenDept eq 'Y'}">colspan="2"</c:if> >
								
				<table class="tb_list_basic" summary="사원목록">
		            <caption>사원목록 해드</caption>
		            <colgroup>
		                <col width="40" />
		                <col width="133" />
		                <col width="132" />
		                <col width="102" class="dynamic_column" />
		                <col width="100" class="dynamic_column" />
		            </colgroup>
		        	<thead>
		                <tr>
		                    <th scope="col">
		                    	<c:choose>
		                    	<c:when test="${isOnlyOne eq 'Y'}">&nbsp;<%-- nothing --%></c:when>
		                    	<c:otherwise><label for=""><input type="checkbox" name='allChk' onclick='fnObj.allCheck();' /><span class="blind">전체선택</span></label>
		                    	</c:otherwise>
		                    	</c:choose>
		                    </th>
		                    <th scope="col">회사</th>
		                    <th scope="col">부서</th>
		                    <th scope="col" class="dynamic_column"><a href="#" onclick="fnObj.doSort(0);return false;" id="sort_column_prefix0" class="sort_normal">사원명<em>정렬</em></a></th>
		                    <th scope="col" class="dynamic_column"><a href="#" onclick="fnObj.doSort(1);return false;" id="sort_column_prefix1" class="sort_normal">사번<em>정렬</em></a></th>		                    
		                </tr>
		            </thead>
		        </table>
				<!-- ================================= 부서 사원 :S ================================== -->
				<div class="user_list_in_dept">
				<table id="SGridTarget" class="tb_list_basic" summary="사원목록">
		            <caption>사원목록</caption>
		            <colgroup>
		                <col width="40" /> 
		                <col width="133" />
		                <col width="133" />
		                <col width="101" class="dynamic_column" />
		                <col width="100" class="dynamic_column" />
		            </colgroup>
		        	<thead>
		            </thead>
		            <tbody>		            
		            </tbody>    
		        </table>
		        </div>
				<!-- ================================= 부서 사원 :E ================================== -->				
				<font color="#99a" style="font-size:11px;"><strong>선택 리스트</strong></font>	
				<center>		
				<%--<a href="#" onclick="fnObj.addSelList();return false;" class="btn_ac_add"><em>추가</em></a> --%>
				</center>							
				<!-- ================================= 부서 사원(선택) :S ================================== -->
				<div class="user_list_in_dept2">
				<table width="530" id="SGridTarget2" class="tb_list_basic" summary="사원목록">
		            <caption>사원목록</caption>
		            <colgroup>
		                <col width="40" /> 
		                <col width="133" />
		                <col width="133" />
		                <col width="101" class="dynamic_column" />
		                <col width="100" class="dynamic_column" />
		            </colgroup>
		        	<thead>
		            </thead>
		            <tbody>		            
		            </tbody>
		        </table>
		        </div>
				<!-- ================================= 부서 사원(선택) :E ================================== -->

				</td>
			</tr>
		</tbody>
	</table>
		
	<div class="btn_baordZone">    
		<a href="#" onclick="fnObj.selectSelList();return false;" class="p_blueblack_btn">선 택</a>        
    </div>

</div>




<script type="text/javascript">

//Global variables :S --------------- 
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

var myGrid = new SGrid();		// instance		new sjs
var myGrid2 = new SGrid();		// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs


//공통코드(외,코드)
var comCodeEmpType;					//메뉴타입
var comCodeUserStts;				//채용형태
var orgCodeCombo;					//ORG코드(콤보용)


//검색옵션
var isOnlyOne = '${isOnlyOne}';				//선택건수 1개 여부			('Y': 한명(한부서), 	그외,: 복수(default))
var isAllOrg = '${isAllOrg}';				//전체 ORG 범위로의 여부		('Y': 전체ORG, 		그외,: 나의권한ORG)
var oneOrg = '${oneOrg}';					//전달받은 한개의 ORG ID
var popupType = '${popupType}';				//검색값 종류					('USER': 사원, 		'DEPT',: 부서)		... default 'USER'
var isCloseBySelect = '${isCloseBySelect}';	//
var isEnable	= ('${isEnable}' == '' ? 'Y' : '${isEnable}'); //유효한 사원('N': 퇴사자,			그외: 재직자)	... default 'Y'
//부모페이지 식별키(팝업시키는 부모페이지에서 키값을 보낸다)
var parentKey = '${parentKey}';		//선택한 사용자를 넘기는 함수에서 부모키별로 구현된 동작을 시키기 위해
var isHiddenDept = ('${isHiddenDept}' == '' ? 'N' : '${isHiddenDept}');	//부서트리 숨김여부			('Y': 트리 숨기기,	그외:보이게)			... default 'N'

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	
	//################# init function :S #################
	
	//선로딩코드
	preloadCode: function(){
		
		
		//공통코드
		comCodeDeptClass = getBaseCommonCode('DEPT_CLASS', lang, 'CD', 'NM');		//채용형태 공통코드 (Sync ajax)
		
		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var deptClassSelectTag = createSelectTag('selDeptClass', comCodeDeptClass, 'CD', 'NM', '', 'fnObj.changeDeptClass(this)', colorObj, 80);	//select tag creator 함수 호출 (common.js)		
		$("#deptClassSelectTag").html(deptClassSelectTag);
		
		
		var params = {'authOrgId':'Y', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		if(isAllOrg == 'Y'){		//전체 ORG 범위검색이면
			params = {};		//조건없이 검색(전체검색)
		}
		if(oneOrg != ''){			//ORG ID 가 한개 있으면(한개의 ORG 만을 조회)
			params = {'applyOrgId':oneOrg};
		}
		orgCodeCombo = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/common/getOrgCodeCombo.do', params);		//ORG코드(콤보용) 호출
				
		//관계사
		var defaultOrgId = '${baseUserLoginInfo.applyOrgId}';		//기본 선택 관계사
		var orgSelectTag = createSelectTag('selOrg', orgCodeCombo, 'CD', 'NM', defaultOrgId, 'fnObj.changeOrg(this)', colorObj, null, 'select_b period');	//select tag creator 함수 호출 (common.js)
		$("#orgSelectTag").html(orgSelectTag);
		
	},
	
	
	//화면세팅
    pageStart: function(){
    	
    	//-------------------------- 부서 TREE :S ----------------------------
    	fnObj.setDeptTree();						//부서 TREE 세팅 함수 호출
		//-------------------------- 부서 TREE :E ----------------------------
    	
    	
    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {
    		
    		targetID : "SGridTarget",		//그리드의 id
    		
    		emptyOfList : false,			//데이터가 없을때 빈 데이터 추가여부(default true)
    		
    		//그리드 컬럼 정보
    		colGroup : [

            {key:"chk",				formatter:function(obj){return ("<input type='checkbox' name='mCheck' onclick='fnObj.clickUserCheckbox({direct:1,c:1,index:" + obj.index + "})' />");}}, 	//"' onclick='fnObj.clickCheckbox(this, " + obj.index + ");' " + ((obj.value==1)?"checked":"") + " />");}},
            {key:"orgNm" 			},
            {key:"deptNm", 			formatter:function(obj){return (obj.value + (obj.item.mainYn=='N'?'<font color="silver">(겸)</font>':''));}},
            {key:"userNm" 			},
            {key:"empNo" 			}
            
            //데이터만            
            //{key:"templateId" 		}
            //{key:"newYn"	 		}
            ],
                        
            body : {
	            onclick: function(obj){
	            	/* ***** obj *****
	            		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
	            	*/
					
	            	if(obj.c > 0){
	            		fnObj.clickUserCheckbox(obj);
	            	}
	            }
	        }
            
    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';    	
    	rowHtmlStr +=	 '<td>#[0]</td>';    	
    	rowHtmlStr +=	 '<td>#[1]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	
    	if(popupType != 'DEPT'){
	    	rowHtmlStr +=	 '<td>#[3]</td>';
	    	rowHtmlStr +=	 '<td>#[4]</td>';
    	}
    	
    	rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr; 
        
    	
    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------
    	
    	
    	//-------------------------- 소팅 설정 :S ----------------------------    	
    	mySorting.setConfig({
			colList : ['NAME', 'EMP_NO'],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
		});
    	//-------------------------- 소팅 설정 :E ----------------------------
    	
    	
    	//-------------------------- 그리드(선택 하단) 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj2 = {
    		
    		targetID : "SGridTarget2",		//그리드의 id
    		
    		emptyOfList : false,			//데이터가 없을때 빈 데이터 추가여부(default true)
    		
    		//그리드 컬럼 정보
    		colGroup : [

            {key:"chk",				formatter:function(obj){return ('<a href="#" onclick="fnObj.delUser(' + obj.index + ');return false;" class="btn_ac_delete"><em>삭제</em></a>');}}, 	//"' onclick='fnObj.clickCheckbox(this, " + obj.index + ");' " + ((obj.value==1)?"checked":"") + " />");}},
            {key:"orgNm" 			},
            {key:"deptNm"			},
            {key:"userNm" 			},
            {key:"empNo" 			}
            
            //데이터만            
            //{key:"templateId" 		}
            //{key:"newYn"	 		}
            ],
            
            
            body : {
                onclick: function(obj){
                    
                	/* ***** obj *****
                		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
                	*/
                	
                	/* if(obj.c > 0){
                		fnObj.viewTemplate(obj.item.templateId, '${param.popYn}');
                	} */
                	
                },
                
                ondblclick: function(obj){
                	
                }
                
            }
            
    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr2 = '<tr>';    	
    	rowHtmlStr2 +=	 '<td>#[0]</td>';    	
    	rowHtmlStr2 +=	 '<td>#[1]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr2 +=	 '<td>#[2]</td>';
    	
    	if(popupType != 'DEPT'){
	    	rowHtmlStr2 +=	 '<td>#[3]</td>';
	    	rowHtmlStr2 +=	 '<td>#[4]</td>';
    	}
    	
    	rowHtmlStr2 +=	 '</tr>';
    	configObj2.rowHtmlStr = rowHtmlStr2; 
        
    	
    	myGrid2.setConfig(configObj2);		//그리드 설정정보 세팅
    	//-------------------------- 그리드(선택 하단) 설정 :E ----------------------------
		    	
    	
    	
    	
    	//--------------- 데이터 유형 에 따라 컬럼히든처리	popupType --------------
    	if(popupType == 'DEPT'){	//부서 선택 팝업이면
    		
    		$('#spanUserNameSrch').hide();	//사원명 검색 hidden
    		
    		$('.dynamic_column').hide();	//부서관련 컬럼 hidden
    		
    	}
    	
    	
    },//end pageStart.
        
  	//################# init function :E #################
    
    
    //################# else function :S #################
    
    
  	//사원선택 체크
    clickUserCheckbox: function(obj){
    	
    	/* alert(obj.c + ',' + obj.index);
    	return;
    	 */

    	if(obj.c > 0){
    		var chkList = document.getElementsByName('mCheck');
    		if(obj.direct!=1){		//direct==1 ... 체크박스를 직접클릭해서 호출된경우(체크박스를 직접클릭하면 이미 체크상태변화가 되었기 때문에 하단 반대값 세팅을 해주면 안된다)
    			document.getElementsByName('mCheck')[obj.index].checked = chkList[obj.index].checked?false:true;	//반대 값으로 세팅
    		}
    		
    		if(chkList[obj.index].checked){		//체크된 상태이면
    			var list2 = myGrid2.getList();
    			var selObj = myGrid.getList()[obj.index];
    			if(popupType == 'DEPT'){
    				if(getCountWithValue(list2, 'deptId', selObj.deptId)==0){		//추가한 부서가 없으면
    	    			fnObj.addSelList(obj.index); 		//추가
        			}
    			}else{	//popupType == 'USER'
    				if(getCountWithValue(list2, 'userId', selObj.userId)==0){		//추가한 사용자가 없으면
    	    			fnObj.addSelList(obj.index); 		//추가
        			}
    			}
    			
    		}else{
    			var idx = -1;			//하단 그리드 row index
    			var list = myGrid2.getList();
    			var deptId = myGrid.getList()[obj.index].deptId;
    			var userId = myGrid.getList()[obj.index].userId;	            			
    			for(var i=0; i<list.length; i++){
    				if(list[i].deptId==deptId && list[i].userId==userId){
    					idx = i;
    					break;
    				}
    			}
    			if(idx != -1)
    				fnObj.delUser(idx);		//사용자삭제
    		}
    	    
    	}
    },
    
    
  	//체크박스 전체 체크
    allCheck: function(){
    	
   		var chkList = document.getElementsByName('mCheck');
   		var toBe = document.getElementsByName('allChk')[0].checked;
   		for(var i=0; i<chkList.length; i++){
       		chkList[i].checked = toBe;		//체크여부       		
       	}
   	
   		
   		if(toBe){
   			//전체이동
   	   		fnObj.addSelList();
   		}else{
   			myGrid2.setGridDataEmpty();		//기선택 전체삭제
   		}
   		
    },
    
    
    //부서유형 변경
    changeDeptClass: function(obj){
    	fnObj.setDeptTree();
    },
    
    //부서 트리
    setDeptTree: function(){
    	
    	var deptClass = $('#selDeptClass').val();
    	
    	
    	//------------------------- 부서 TREE data :S --------------------------
    	var url = contextRoot + "/user/getDeptListForTree.do";
    	var param = {deptClass : deptClass};
    	param.orgId = $('#selOrg').val();		//선택 관계사
    			
    	var callback = function(result){
    		
    		var obj = JSON.parse(result);
    		
    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}
    		    		
    		var cnt = obj.resultVal;	//결과수
    		var obj = obj.resultObject;	//결과데이터JSON

    		fnObj.makeDeptTree(eval(obj));	//TREE 생성 호출
    		
    	};
    	
    	commonAjax("POST", url, param, callback);
    	//------------------------- 부서 TREE data :E --------------------------
		
    },
    
    
  	//부서 트리 생성
    makeDeptTree: function(treeObj){
    	
    	$('#jstree').jstree('destroy');
    	
		//-------------------------- 부서 TREE :S ----------------------------
    	    	
		
		var deptTree = $('#jstree').jstree(
				{
					//'plugins': ["checkbox"],		//["wholerow","checkbox"],
					'core' : {
						'data' : treeObj,
						'multiple' : false			//한개 선택
					}
					
				}).bind('changed.jstree', function(e, data){
			
					$('#inUserName').val('');			//사원명 검색 필드 초기화.
					
					if(popupType == 'DEPT'){
						fnObj.getDeptInfo(data.selected);	//alert(data.selected);							//또는 data.selected[0]
					
					}else{
						fnObj.getUserListInDept(data.selected);	//alert(data.selected);							//또는 data.selected[0]
					}
										
				}).bind('ready.jstree', function(e, data){
					$(this).jstree("open_all");		//전체 펼침
				});
				
		<%--
			data 에 배열객체(트리데이터)를 바인딩
			
			*속성
			id : node value ??
			text : node name
			children : node array object
			state : node status object	 ex){"selected" : true, "opened" : true}
			icon : user icon (image file, or css class name)
		
		--%>
    	
		//-------------------------- 부서 TREE :E ----------------------------
		
    },
    
    
  	//사원 검색(부서별)
    getUserListInDept: function(deptId){
    	
    	if(deptId == null || deptId == ""){
    		deptIdVal = '';			//전체검색
    	}else{
    		deptIdVal = deptId[0];
    	}
    	    	
    	var deptClass = $('#selDeptClass').val();
    	var userName = $('#inUserName').val();
    	
    	//------------------------- 부서 TREE data :S --------------------------
    	var url = contextRoot + "/user/getUserListInDept.do";
    	var param = {deptClass : deptClass
    				,deptId : deptIdVal
    				,orgId : $('#selOrg').val()		//선택 관계사
    				
    				,sortCol : mySorting.nowSortCol
	    			,sortVal : mySorting.nowDirection
    				
    				,search : userName
    				,enable : isEnable //유효사원
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
    	    
    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list		//그리드 테이터
    						});
    		
			mySorting.applySortIcon();		//소팅화면적용
			
			
			//전체 건수 세팅
			//$('#total_count').html(obj.totalCount);
    		
    	};
    	
    	commonAjax("POST", url, param, callback);
    	//------------------------- 부서 TREE data :E --------------------------
		
    },
    
    
  	//사원명 검색
    doSearchNm: function(){
    	
    	//var deptIdList = $('#jstree').jstree('get_selected');
    	
    	//fnObj.getUserListInDept(deptIdList);
    	var userNm = $('#inUserName').val();
    	if(userNm.length == 0){
    		toast.push({body:'사원명을 입력하시기 바랍니다!', type:'Warning'});		//Warning, Caution
    		return;
    	}
    	
    	fnObj.getUserListInDept();					//부서관계없이 검색 되도록
    },
    
    
  	//컬럼 소팅
    doSort: function(idx){
    	
    	mySorting.setSort(idx);				//소팅객체를 소팅한다.(상태값들의 변화)
    	
    	var deptIdList = $('#jstree').jstree('get_selected');
    	
    	fnObj.getUserListInDept(deptIdList);
    },
    
    
    //사용자,부서 선택 이동(임시)
    addSelList: function(idx){			//*idx : 특정 index ... 만약 null 이면 체크된 전체를 일괄로 넘긴다.
    	
    	var list = myGrid.getList();
    	var chkList = document.getElementsByName('mCheck');
    	
    	var listSel = myGrid2.getList();	//임시 선택된 사용자 리스트
    	
    	if(idx==null){		//특정 index 추가가 아닌 체크된 전체를 넘기는 케이스(일괄이동)
    		for(var i=0; i<chkList.length; i++){
        		if(chkList[i].checked && (getCountWithValue(listSel, 'empNo', list[i].empNo)==0)){
        			
        			if(listSel.length == 1 && isOnlyOne == 'Y'){
        				dialog.push({body:"<b>확인!</b> 1건만 선택이 가능합니다!", type:"", onConfirm:function(){}});
        				break;
        			}
        			
           			listSel.push(list[i]);		//추가
           		}
           	}
    		
    	}else{				//특정 index (1명 선택)
    		if(listSel.length > 0 && isOnlyOne == 'Y'){
				dialog.push({body:"<b>확인!</b> 1건만 선택이 가능합니다!", type:"", onConfirm:function(){
					$('input[name=mCheck]')[idx].checked = false;
				}});
				return;
			}
    	
    		listSel.push(list[idx]);			//추가
    	}
    	
    	
    	
    	//그리드 세팅
    	myGrid2.setGridData({				//그리드 데이터 세팅
			list: listSel					//그리드 테이터
		});    	
    },
    
  	//사용자 선택 빼기(임시)
    delUser: function(index){
    	
    	var listSel = myGrid2.getList();	//임시 선택된 사용자 리스트
    	
  		listSel.remove(index);			//삭제
       	
    	//그리드 세팅
    	myGrid2.setGridData({				//그리드 데이터 세팅
			list: listSel					//그리드 테이터
		});    	
    },
    
    
  	//관계사 변경
    changeOrg: function(){
    	
    	fnObj.setDeptTree(this);		//부서정보(트리) 재 세팅
    	
    	
    	myGrid.setGridDataEmpty();		//기선택 전체삭제
    	//myGrid2.setGridDataEmpty();		//기선택 전체삭제
    },
    
    
  	//부서 검색(부서별)
    getDeptInfo: function(){
    	
    	//부서 트리
    	var deptId = $('#jstree').jstree().get_selected("id")[0].id;
    	var deptNm = $('#jstree').jstree().get_selected("id")[0].text;
    	var orgId = $('#selOrg').val();
    	var orgNm = $('#selOrg :selected').text();
    	
    	var selObj = {'deptId': deptId
					 ,'deptNm': deptNm
					 ,'orgId': orgId
					 ,'orgNm': orgNm
    				};
    	var list = [];
    	list.push(selObj);
    	
    	myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
			list: list		//그리드 테이터
		});

		mySorting.applySortIcon();		//소팅화면적용
		
		
		
		//선택 리스트에도 바로 추가할지 세팅
		var list2 = myGrid2.getList();
		if(isOnlyOne == 'Y'){				//단수 선택모드
			///////////nothing/////////		//바로추가는 못하게(그리드에서 선택하도록)
		}else{								//복수 선택모드
			if(getCountWithValue(list2, 'deptId', selObj.deptId)==0){		//추가한 부서가 없으면
				//선택 리스트에도 바로 추가
				list2.push(selObj);
				myGrid2.refresh();
			}
		}
    },
    
    
    //사용자,부서 선택해서 부모화면에 넘기기
    selectSelList: function(){
    	
    	var listSel = myGrid2.getList();	//임시 선택된 사용자 리스트
    	var cnt = listSel.length;
    	
    	if(cnt == 0){
    		dialog.push({body:"<b>확인!</b> " + (popupType=='DEPT'?"부서를":"사원을") + " 선택해주세요!", type:"Caution", onConfirm:function(){}});
    		return;
    	}
    	
    	
    	
    	//////// 부모 화면 function call ////////
    	parent.fnObj.actionBySelData(listSel, parentKey);		//(Array Object, parentKey)  ... parentKey 는 부모창에서 받은것 그대로 전달(부모화면내 구분이 필요할때)
    	
    	if(isCloseBySelect == 'N'){			//선택과동시에 창닫기가 아니면
    		//////nothing//////							//창 안닫고
    	}else{								//창닫기면
    		parent.myModal.close();						//창 닫기
    	}
    	
    	
    	
    	
    	////////////////// 부모 화면으로 선택한 사원정보를 넘긴다 ///////////////// 
    	/*
			*확인사항*
			- 하단 내용은 부모화면 별로 다르게 구현한다.
			- 부모화면에서 팝업시킬때 던져주는 parentKey 로 구분한다.
		*/
    	//alert(JSON.stringify(listSel));
    	
    	/* if(parentKey == "PJT_REG"){				//'PJT_REG' 프로젝트 등록 화면의 직원선택 버튼
    		parent.fnObj.concatUserSelected(listSel);
        	        	
        	parent.myModal.close();						//창 닫기
        	
    	}else if(parentKey == "PJT_REG_ALL"){	//'PJT_REG' 프로젝트 등록 화면의 직원선택 버튼(프로젝트 하위 activity 전체 적용)
    		parent.fnObj.concatPjtEmpList(listSel);
        	        	
        	parent.myModal.close();						//창 닫기
        	
    	}else if(parentKey == "ACT_USER"){		//'ACT_USER' 개인별조회 화면의 사원검색    		
    		parent.fnObj.masterUserSelected(listSel);
        	
        	parent.myModal.close();						//창 닫기
    	} */
    	
    }
    
    
  	//################# else function :E #################
    
};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	
});

</script>











	<script>
//	$(function () {
		
		//$.jstree.defaults.checkbox.three_state = false;			//연쇄작용 여부(포함관계)
		//$.jstree.defaults.checkbox.whole_node = false;			//연쇄작용 여부(포함관계)
		//$.jstree.defaults.core.multiple = false;
		
		/* $.jstree.defaults.core.dblclick_toggle = false;			//더블클릭시 child 노드 펼침닫힘 여부 (체크박스 아닐때 더블클릭으로 선택 기능 할 수 있겠다)
		
		var tree = $('#jstree').jstree(
				{
					'plugins': ["checkbox"],		//["wholerow","checkbox"],
					'core' : {
						'data' : [
									{
										id : '1',
										text : "Same but with checkboxes",
										children : [
											{ id : '1-1', text : "initially selected", state : { selected : false } },
											{ id : '1-2', text : "custom icon URL", icon : "//jstree.com/tree-icon.png" },
											{ id : '1-3', text : "initially open", state : { opened : true }, children : [ {id : '1-3-1', text:"Another node"} ] },
											{ id : '1-4', text : "custom icon class", icon : "glyphicon glyphicon-leaf" }
										]
									}
									//,"And wholerow selection"
						]
					}
				});
		
		
		tree.bind('changed.jstree', function(e, data){
			alert(data.selected);							//또는 data.selected[0]
		});
		
		tree.bind('loaded.jstree', function(e, data){
			data.instance.open_all();
			
		});
		
		
		parent.myModal.resize(); */
		
//	});
	<%--
		data 에 배열객체(트리데이터)를 바인딩
		
		*속성
		id : node value ??
		text : node name
		children : node array object
		state : node status object	 ex){"selected" : true, "opened" : true}
		icon : user icon (image file, or css class name)
	
	--%>
		
	</script>
	