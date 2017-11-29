<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->
<style type="text/css">
#selDeptClass{
	height:23px;
}
#selIncharge{
	height:23px;
}
.btn_witheline{	
	height:12px !important;
}
#SGridTarget tbody td {
    padding: 2px 10px 0px;
    text-align: center;
}
#SGridTarget{
    border-color: #e6e6e6;
}
#SGridHeader{
	margin-top: 10px;
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
    padding: 1px 20px 0px;
    text-align: center;
}
.user_list_in_dept {
	height:360px;
    /* max-height: 200px; */
    overflow-y: auto;
    border-bottom: #c7cdd8 solid 1px;
    border-right: #c7cdd8 solid 1px;
    border-left: #c7cdd8 solid 1px;
}
table.tb_list_basic {
	table-layout:fixed;
}
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
			<tr style="display:none;">
				<td height="20px;"><span style="display:none;"><span id="deptClassSelectTag"></span></span></td>
				<td>부서장 <input type="checkbox" id="inchargeDeptMgr"><!-- <span id="inchargeSelectTag"></span> -->				
				</td>
			</tr>
			<tr>
				<td valign="top"><div id="jstree" class="demo" style="margin-top:1em;"></div></td>
				<td valign="top">
				<!-- <span class="btn_baordZone"><a href="#" onclick="fnObj.addDeptIncharge();return false;" class="btn_witheline">부서추가</a></span> -->
				<table id="SGridHeader" class="tb_list_basic" summary="사원목록">
		            <caption>사원목록 해드</caption>
		            <colgroup>
		                <col width="30" />
		                <col width="150" />
		                <col width="100" />
		            </colgroup>
		        	<thead>
		                <tr>
		                    <th height="20" scope="col"></th>
		                    <th scope="col">부서</th>
		                    <th scope="col">부서장</th>
		                </tr>
		            </thead>
		        </table>
				<!-- ================================= 부서 사원 :S ================================== -->
				<div class="user_list_in_dept">
				<table id="SGridTarget" class="tb_list_basic" summary="사원목록">
		            <caption>사원목록</caption>
		            <colgroup>
		                <col width="30" /> 
		                <col width="150" />
		                <col width="100" />
		            </colgroup>
		        	<thead>
		            </thead>
		            <tbody>		            
		            </tbody>    
		        </table>
		        </div>
				<!-- ================================= 부서 사원 :E ================================== -->
				</td>
			</tr>
		</tbody>
	</table>
		
	<div class="btn_baordZone mgt10 mgb10">    
		<a href="#" onclick="fnObj.selectDeptIncharge();return false;" class="p_blueblack_btn">확 인</a>        
    </div>

</div>




<script type="text/javascript">

//Global variables :S --------------- 
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

var myGrid = new SGrid();		// instance		new sjs


//공통코드(외,코드)
var comCodeEmpType;					//메뉴타입
var comCodeUserStts;				//채용형태


//검색옵션('Y': 한명, 그외,: 다수(default))
var isOnlyOne = '${isOnlyOne}';		//사용자 선택인원 한명여부

//화면에서 넘어온 기등록 리스트
var deptInchargeList = new Array();		//'${deptInchargeList}'
var targetOrgId = "${orgId}";

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
		comCodeIncharge = getBaseCommonCode('INCHARGE', lang, 'CD', 'NM', '', '선택', 'SELECT');		//채용형태 공통코드 (Sync ajax)
		
		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var deptClassSelectTag = createSelectTag('selDeptClass', comCodeDeptClass, 'CD', 'NM', '', 'fnObj.changeDeptClass(this)', colorObj, 80);	//select tag creator 함수 호출 (common.js)		
		$("#deptClassSelectTag").html(deptClassSelectTag);
		//var inchargeSelectTag = createSelectTag('selIncharge', comCodeIncharge, 'CD', 'NM', '', '', colorObj, 150);	//select tag creator 함수 호출 (common.js)		
		//$("#inchargeSelectTag").html(inchargeSelectTag);
		
		
		//var companyRadioTag = createRadioTag('rdCompany', companyCode, 'CD', 'NM', 'EMP');	//radio tag creator 함수 호출 (common.js)
		//$("#companyRadioTag").html(companyRadioTag);
		
		
		//화면에서 넘어온 기등록 리스트 데이터
		deptInchargeList = JSON.parse('${deptInchargeList}');
		
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

            {key:"chk",				formatter:function(obj){
            	return (obj.item.incharge == 'DEPT_MGR'?'':('<a href="#" onclick="fnObj.delDeptIncharge(' + obj.index + ');return false;" class="btn_ac_delete"><em>삭제</em></a>'));
            }},
            {key:"deptNm" 			},
            {key:"inchargeNm", 		formatter:function(obj){
										if(obj.item.incharge == 'DEPT_MGR')
											return '부서장';
            						}}
            
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
    	var rowHtmlStr = '<tr>';    	
    	rowHtmlStr +=	 '<td style="height:23px;">#[0]</td>';    	
    	rowHtmlStr +=	 '<td>#[1]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td>#[2]</td>';
        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr; 
        
    	
    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------
    	
    	
    },//end pageStart.
        
  	//################# init function :E #################
    
    
    //################# else function :S #################
    
    
    //그리드 기본 데이터 세팅
    setGridDataInit: function(){
    	myGrid.setGridData({list:deptInchargeList});
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
    	var param = {deptClass : deptClass, orgId: targetOrgId};
    			
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
    	
		//$.jstree.defaults.core.multiple = false;
		
		var deptTree = $('#jstree').jstree({
					//'plugins': ["checkbox"],		//["wholerow","checkbox"],
					'core' : {
						'data' : treeObj,
						'multiple' : false
					}
				}).bind('changed.jstree', function(e, data){			
					//$('#selIncharge').focus();		//부서 선택시 직책을 선택하도록 포커싱을 줘서 확인시킨다.
					
				}).bind('select_node.jstree', function(e, data){			
					fnObj.addDeptIncharge();			//부서추가
					
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
		parent.myModal.resize();
    },
    
    
    //부서 및 직책 선택(임시)
    addDeptIncharge: function(){
    	
    	//부서
		var deptIdList = $('#jstree').jstree('get_selected');
    	if(deptIdList.length == 0){
			dialog.push({body:"<b>확인!</b> 부서를 선택해 주시기 바랍니다!", type:"", onConfirm:function(){}});
			return;
		}
		//직책
		var deptClass = $('#inchargeDeptMgr').is(":checked");		//부서장 체크여부
		
		/* if(isEmpty(deptClass)){
			dialog.push({body:"<b>확인!</b> 직책을 선택해 주시기 바랍니다!", type:"", onConfirm:function(){$('#selIncharge').focus();}});
			return;
		} */
		
		
		var obj = {
				deptId: deptIdList[0],
				deptNm: $('#jstree').jstree().get_selected(true)[0].text,
				incharge: deptClass==true?'DEPT_MGR':'',
				inchargeNm: deptClass==true?'부서장':''			//$('#selIncharge option:selected').text()
			};
		
		var done = false;	//처리 여부
    	var list = myGrid.getList();    	
    	for(var i=0; i<list.length; i++){				//이미 선택한 부서가 있는 지 체크한다.
    		if(list[i].deptId == deptIdList[0]){						// && list[i].incharge == deptClass){
    			list[i] = obj;		//이미 선택한 부서가 있으면 덮어쓴다
    			done = true;		//완료 flag    			
    		}
    	}
    	
    	if(!done){				//이미 선택한 부서가 없을시
    		list.push(obj);		//추가한다.
    	}
    	    	
    	//그리드 세팅
    	myGrid.setGridData({				//그리드 데이터 세팅
			list: list						//그리드 테이터
		});    	
    },
    
  	//부서 및 직책 선택 빼기(임시)
    delDeptIncharge: function(index){
    	
    	var list = myGrid.getList();	//임시 선택된 사용자 리스트
    	
  		list.remove(index);			//삭제
       	
    	//그리드 세팅
    	myGrid.setGridData({				//그리드 데이터 세팅
			list: list						//그리드 테이터
		});    	
    },
    
    //사용자 선택해서 부모화면에 넘기기
    selectDeptIncharge: function(){
    	
    	var list = myGrid.getList();	//임시 선택된 사용자 리스트
    	var cnt = list.length;
    	
    	if(cnt == 0){
    		dialog.push({body:"<b>확인!</b> 부서 및 직책을 선택해주세요!", type:"", onConfirm:function(){}});
    		return;
    	}
    	
    	////////////////// 부모 화면으로 선택한 사원정보를 넘긴다 ///////////////// 
    	
    	parent.fnObj.concatDeptInchargeList(list);
    	
    	parent.myModal.close();						//창 닫기
    }
    
  	//################# else function :E #################
    
};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
		
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	
	//그리드 기본 데이터 세팅
	fnObj.setGridDataInit();
	
	
});

</script>

	