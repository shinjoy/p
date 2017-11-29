<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




	<form name="myForm">
		<!--모달 담당자변경-->
	        
	            <div class="mo_container">
	            	<div class="changeManabox">
	            		<!--1차선택-->
	                	<div class="Block01">
	                    	<h2 class="title">1차 선택 고객</h2>
	                        <!--고객 리스트-->
				            <div class="network_st_box">
				            	<span class="scroll_cover"></span>
				                <div class="scroll_header">
				                    <table class="network_tb_st" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
				                        <caption>고객관리 리스트</caption>
				                        <colgroup>
				                            <col width="35" /> <!--선택-->
				                            <col width="70" /> <!--이름-->
				                            <col width="*" /> <!--회사-->
				                            <col width="70" /> <!--기담당자-->
				                        </colgroup>
				                        <thead>
				                            <tr>
				                            	<th scope="col" class="checkinput"><label><input id="chkAllLeft" onclick="fnObj.chkCustAll(this, '');" type="checkbox" /><em>전체선택</em></label></th>
				                            	<th scope="col">이름</th>
				                            	<th scope="col">회사</th>
				                            	<th scope="col">기담당자</th>
				                            </tr>
				                        </thead>
				                    </table>
				                </div>
								<div class="scroll_body">
				                    <table id="SGridTarget" class="network_tb_st" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
				                        <caption>고객 리스트</caption>
				                        <colgroup>
				                            <col width="35" /> <!--선택-->
				                            <col width="70" /> <!--이름-->
				                            <col width="*" /> <!--회사-->
				                            <col width="70" /> <!--고객구분-->
				                        </colgroup>
				                        <tbody>
				                        	<%--
				                            --%>
			                            </tbody>
			                        </table>
			                    </div>
							</div>
							<p class="notice_script"><span class="red">*</span>1차 선택한 고객들을 최종 확인하여 오른쪽으로 이동시키기 바랍니다.</p>
	                    </div>
	                    <!--//1차선택//-->
	                    <!--이동버튼-->
	                    <div class="btn_arrow_halbox">
							<button type="button" class="AXButton graarrow" onclick="fnObj.moveRight();"><i class="axi axi-chevron-right2" style="font-size:12px;"></i></button>
							<button type="button" class="AXButton graarrow" onclick="fnObj.moveLeft();"><i class="axi axi-chevron-left2" style="font-size:12px;"></i></button>
						</div>
						<!--//이동버튼//-->
						<!--최종선택고객-->
	                    <div class="Block03">
	                    	<h2 class="title">최종 선택 고객</h2>
	                    	<div class="title_des_mnager"><span class="fontRed mgr10">담당자 선택</span><span id="userSelectTag"></span></div>
							<!--최종선택리스트-->
				            <div class="network_st_box">
				            	<span class="scroll_cover"></span>
				                <div class="scroll_header">
				                    <table class="network_tb_st" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
				                        <caption>고객관리 리스트</caption>
				                        <colgroup>
				                            <col width="35" /> <!--선택-->
				                            <col width="70" /> <!--이름-->
				                            <col width="*" /> <!--회사-->
				                            <col width="70" /> <!--기담당자-->
				                        </colgroup>
				                        <thead>
				                            <tr>
				                            	<th scope="col" class="checkinput"><label><input id="chkAllRight" onclick="fnObj.chkCustAll(this, '2');" type="checkbox" /><em>전체선택</em></label></th>
				                            	<th scope="col">이름</th>
				                            	<th scope="col">회사</th>
				                            	<th scope="col">기담당자</th>
				                            </tr>
				                        </thead>
				                    </table>
				                </div>
								<div class="scroll_body">
				                    <table id="SGridTarget2" class="network_tb_st" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
				                        <caption>고객 리스트</caption>
				                        <colgroup>
				                            <col width="35" /> <!--선택-->
				                            <col width="70" /> <!--이름-->
				                            <col width="*" /> <!--회사-->
				                            <col width="70" /> <!--고객구분-->
				                        </colgroup>
				                        <tbody>
				                        	<%--
				                            --%>
			                            </tbody>
			                        </table>
			                    </div>
							</div>
	                    </div>
	                    <!--//최종선택고객//-->
	                </div>
	            </div>
	            <div class="mo_footer">
	            	<div class="btnZone"><a href="javascript:fnObj.doSave();"><strong>담당자변경</strong></a></div>
	            </div>
	        
	    <!--//모달 담당자변경//-->
	</form>




<script type="text/javascript">
//Global variables :S ---------------

//공통코드(외,코드)
var comCodeMenuLoc;				//메뉴위치코드
var roleCodeCombo;				//권한코드

//var mySearch = new AXSearch(); 	// instance
//var mySearch2 = new AXSearch(); // instance (오른쪽)
var myGrid = new SGrid(); 		// instance
var myGrid2 = new SGrid(); 		// instance	(오른쪽)

var myModal = new AXModal();	// instance


var g_cstList = '${cstList}';		//고객리스트
var g_cstListObj = [];

var g_staffList = ${staffList};	//담당자리스트(사원 전체) ... 콤보박스용
var g_staffListObj = [];



//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){

		if(!isEmpty(g_cstList)){
			g_cstListObj = JSON.parse(g_cstList);
			//sortByKey(g_staffListObj, 'usrNm', 'ASC');		//이름정렬
		}

		/* if(!isEmpty(g_staffList)){
			g_staffListObj = JSON.parse(g_staffList);
			sortByKey(g_staffListObj, 'usrNm', 'ASC');		//이름정렬
		} */
		g_staffListObj = g_staffList;
		sortByKey(g_staffListObj, 'usrNm', 'ASC');		//이름정렬

		var colorObj = {};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var userSelectTag = createSelectTag('selStaff', g_staffListObj, 'id', 'usrNm', '${baseUserLoginInfo.userId}', null, colorObj, 90, 'select_b');	//select tag creator 함수 호출 (common.js)
		$("#userSelectTag").html(userSelectTag);



		<%--	혹시 필요할 수 있을것같아 남김...개발후 삭제!!!!
		//권한코드관리 권한코드 선택메뉴
		<div style="float:left;display:none;"><!-- /////////////////////////// 일단 숨겨놓고 추가하자!!!!!!!!!!!!!!!!!!!!!!! ////////////////// -->
			<h3>권한코드관리</h3>
			<div id="roleSelectTag"></div>
	    </div>
		//var roleCodeList = this.getRoleCodeList('CD', 'NM', '', '선택');		//권한코드리스트 호출    ........ 어떻게 할지  결정후 진행!!!!!!!!!!!!!!!!!
		var colorObj = {'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var roleSelectTag = createSelectTag('selUserRole', comCodeRoleCd, 'CD', 'NM', 'DEVELOP', 'fnObj.changeRoleCode(this);', colorObj);	//select tag creator 함수 호출 (common.js)
		$("#roleSelectTag").html(roleSelectTag);
		--%>
	},


	//화면세팅
    pageStart: function(){

    	//=================================================== 왼쪽 :s ======================================================
    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            {key:"chk",			formatter:function(obj){return ("<input type='checkbox' name='mCheck' />");}},
            {key:"cstNm"		},
            {key:"cpnNm"		},
            {key:"usrNm"		}
            ],

            body : {
                onclick: function(obj){
                	/* ***** obj *****
                		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
                	*/
                	/* if(obj.c > 0 && obj.c < 7){
                		//fnObj.viewProject(obj.item.projectId);
                		alert('보기 연결');
                	} */
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td class="checkinput"><label>#[0]<em>선택</em></label></td>';
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td class="left_txt">#[2]</td>';
    	rowHtmlStr +=	 '<td class="txt_center">#[3]</td>';
        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;


    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------


    	myGrid.setGridData({				//그리드 데이터 세팅
							list: g_cstListObj		//그리드 테이터
							//,page: pageObj	//페이징 데이터
   						});


    	//=================================================== 왼쪽 :E ======================================================


    	//=================================================== 오른쪽 :S =====================================================
    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj2 = {

    		targetID : "SGridTarget2",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            {key:"chk",			formatter:function(obj){return ("<input type='checkbox' name='mCheck2' />");}},
            {key:"cstNm"		},
            {key:"cpnNm"		},
            {key:"usrNm"		}
            ],

            body : {
                onclick: function(obj){
                	/* ***** obj *****
                		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
                	*/
                	/* if(obj.c > 0 && obj.c < 7){
                		//fnObj.viewProject(obj.item.projectId);
                		alert('보기 연결');
                	} */
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr2 = '<tr>';
    	rowHtmlStr2 +=	 '<td class="checkinput"><label>#[0]<em>선택</em></label></td>';
    	rowHtmlStr2 +=	 '<td>#[1]</td>';
    	rowHtmlStr2 +=	 '<td class="left_txt">#[2]</td>';
    	rowHtmlStr2 +=	 '<td class="txt_center">#[3]</td>';
        rowHtmlStr2 +=	 '</tr>';
    	configObj2.rowHtmlStr = rowHtmlStr2;


    	myGrid2.setConfig(configObj2);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------


    	myGrid2.setGridData({				//그리드 데이터 세팅
							list: []		//그리드 테이터
							//,page: pageObj	//페이징 데이터
   						});

    	//=================================================== 오른쪽 :E =====================================================


    	//초기 체크상태로 되도록
    	$('#chkAllLeft').attr('checked', true);
    	fnObj.chkCustAll($('#chkAllLeft').get(0), '');

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################


  	//저장(메뉴구조)
    doSave: function(){

    	var list = myGrid2.getList();		//선택한 고객


    	if(list.length == 0){
    		alertM('\n등록할 고객을 선택하시기 바랍니다.\n(오른쪽으로 이동)');
    		return;
    	}

    	var usrId = $('#selStaff').val();			//선택한 담당자 id
    	if(usrId == ''){
    		alertM('담당자를 선택하시기 바랍니다.');
    		$('#selStaff').focus();
    		return;
    	}

    	var cstSnbList = '';			//고객 id list
    	var isExist = false;
    	for(var i=0; i<list.length; i++){
    		if(usrId == list[i].usrCusId){
    			isExist = true;
    		}else{
    			cstSnbList += ',' + list[i].sNb;
    		}
       	}

    	if(isExist) alert("기담당자와 변경하고자 하는 담당자가 동일한 경우 담당자 변경이 이루어지지 않습니다. ");
        if(cstSnbList == "") {
        	alert("변경할 대상 담당자가 없습니다.");
        	return;
        }

    	//등록 프로세스 진행
    	if(confirm('담당자를 변경 하시겠습니까?')){

    		var url = contextRoot + "/stockFirmManage/doSaveCstManager.do";
        	var param = {
        			cstList : cstSnbList,	//고객 id list (sequence list)
        			usrId	: usrId,		//담당자 cusId (고객 snb)
        	}

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		var cnt = obj.resultVal;	//결과수

        		if(obj.result == "SUCCESS"){

        			//alertM("등록 되었습니다.");
        			parent.myModal.close();

        			parent.toast.push("등록 되었습니다!");
        			parent.fnObj.doSearchNewInCharge();
        			parent.fnObj.doSearch(1);
        		}else{
        			//alertMsg();
        		}

        	};

        	//alert(JSON.stringify(param));
        	//return;

        	commonAjax("POST", url, param, callback);
    	}


    },//end doSave


    //오른쪽으로 이동 (메뉴리스트 >> 권한별메뉴등록)
    moveRight: function(){
    	var leftList = myGrid.getList();								//왼쪽   그리드 데이터
    	var rightList = myGrid2.getList();								//오른쪽 그리드 데이터
    	var rCnt = rightList.length;

    	var chkCnt = 0;			//이동을 위해 체크한 수
    	var chkIndex = -1;		//체크한 row index
    	var moveObj;			//체크해서 이동할 row Object

    	var mCheckList = document.getElementsByName('mCheck');

    	for(var i=mCheckList.length-1; i>=0; i--){
    		if(mCheckList[i].checked){	//체크되어 있는 것을
    			chkCnt++;
    			moveObj = leftList[i];										//이동할 row data
    			//leftList.splice(i, 1);									//체크 요소를 삭제

    			//myGrid2.pushList(moveObj);								//오른쪽 그리드에 추가
    			rightList = addToArray(rightList, rCnt, moveObj);

    			leftList.remove(i);
    		}
    	}


    	myGrid.refresh();
    	myGrid2.setGridData({list:rightList});

    	$('#chkAllLeft').removeAttr('checked');		//체크박스 전체선택 해제
    	$('#chkAllRight').removeAttr('checked');	//체크박스 전체선택 해제

    	if(chkCnt == 0){
    		alertM("이동할 고객을 선택해주세요!");
    		return;
    	}
    },

  	//왼쪽으로 이동
    moveLeft: function(){
    	var leftList = myGrid.getList();								//왼쪽   그리드 데이터
    	var rightList = myGrid2.getList();								//오른쪽 그리드 데이터
    	var lCnt = leftList.length;

    	var chkCnt = 0;			//이동을 위해 체크한 수
    	var chkIndex = -1;		//체크한 row index
    	var moveObj;			//체크해서 이동할 row Object

    	var mCheckList = document.getElementsByName('mCheck2');

    	for(var i=mCheckList.length-1; i>=0; i--){
    		if(mCheckList[i].checked){	//체크되어 있는 것을
    			chkCnt++;
    			moveObj = rightList[i];										//이동할 row data
    			//leftList.splice(i, 1);									//체크 요소를 삭제

    			//myGrid2.pushList(moveObj);								//오른쪽 그리드에 추가
    			leftList = addToArray(leftList, lCnt, moveObj);

    			rightList.remove(i);
    		}
    	}


    	myGrid2.refresh();
    	myGrid.setGridData({list:leftList});

    	$('#chkAllLeft').removeAttr('checked');		//체크박스 전체선택 해제
    	$('#chkAllRight').removeAttr('checked');	//체크박스 전체선택 해제

    	if(chkCnt == 0){
    		alertM("이동할 고객을 선택해주세요!");
    		return;
    	}
    },




	//고객리스트 체크박스 전체체크
    chkCustAll: function(th, knd){		//knd : '1'(left) or '2'(right)
    	if(th.checked){
    		$('input:checkbox[name=mCheck' + knd + ']').attr('checked', true);		//고객전체 체크
    	}else{
    		$('input:checkbox[name=mCheck' + knd + ']').removeAttr('checked');		//고객전체 체크해제
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
	//fnObj.doSearch();		//검색(메뉴리스트)
	//fnObj.doSearch2();		//검색(권한별메뉴)
	//fnObj.setTooltip();
	
	parent.myModal.resize();		//팝업 리사이즈
	
});
</script>