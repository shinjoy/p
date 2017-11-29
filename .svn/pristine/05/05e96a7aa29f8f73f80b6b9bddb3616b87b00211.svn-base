<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<link href="<c:url value='/css/new_network.css'/>" rel="stylesheet" type="text/css">

<!-- ============== style css :S ============== -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui.css">				<!-- jquery-ui -->
<!-- ============== style css :E ============== -->


<!--html5새로생성된 태그가 IE6~8에서 적용되게 하는 js파일-->
<!--[if lt IE 9]>
	<script src="${pageContext.request.contextPath}/js/html5shiv.js"></script>
	<script src="${pageContext.request.contextPath}/js/respond.min.js"></script>
	<script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
	<script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js"></script>
	<script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->


<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.js?ver=0.1'/>" ></script>

<script>var contextRoot="${pageContext.request.contextPath}";</script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/sys/utils.js?ver=0.1" ></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/common.js?ver=0.1"></script><!-- ajaxRequest, etc -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>


<!-- -------------- axisj source include (JS, CSS) :S -------------- -->
<%@ include file="/includeAxisj.jsp" %>
<!-- -------------- axisj source include (JS, CSS) :E -------------- -->

<!-- -------------- sjs (JS) :S -------------- -->
<script type="text/javascript" src="${pageContext.request.contextPath}/sjs/SGrid.js"></script>
<!-- -------------- sjs (JS) :E -------------- -->


<!-- -------- each page css :S -------- -->
<style type="text/css">
.modalWrap {
    position: relative;
    width: 100%;
    margin: 0em;
    background: #fff;
    z-index: 3;
    zoom: 1;
    box-shadow: none;
    -moz-box-shadow: none;
    -webkit-box-shadow: none;
}
.changeManabox .Block01 {
    float: left;
    width: 845px;
}
}
.network_st_box .scroll_cover {
    position: absolute;
    right: 0px;
    top: 0px;
    z-index: 5;
    background: #dfe3e8;
    width: 17px;
    height: 26px;
    border-bottom: #b1b5ba solid 1px;
}
.changeManabox{
	padding-left:10px;
}
.notice_script{
	padding-top:3px;
	padding-left:5px;
}
.modalWrap .mo_footer {
    border-top: #dadada solid 1px;
    padding-bottom: 20px;
}

.modalWrap .mo_container {
    margin: 0 15px;
    padding: 10px 0 10px 0;
}

.selUserStyle option{
	font-size:15px;
}
.Block01 .title{
	padding-bottom:6px;
}
.network_st_box .scroll_cover {
    height: 24px;
}
.open_letter {
    background: url(../images/work/icon_letter_open.gif) no-repeat 0 0;
    width: 16px;
    height: 15px;
    vertical-align: middle;
    display: inline-block;
}
.closed_letter {
    background: url(../images/work/icon_letter_closed.gif) no-repeat 0 0;
    width: 16px;
    height: 15px;
    vertical-align: middle;
    display: inline-block;
}
.open_letter em {
    font-size: 0px;
    visibility: hidden;
}
.closed_letter em {
    font-size: 0px;
    visibility: hidden;
}
.changeManabox {
    padding-left: 0px;
}
.mo_footer .btnZone {
    margin-top: 10px;
    text-align: center;
}
.modalWrap .mo_footer {
    border-top: #dadada solid 0px;
    padding-bottom: 10px;
}
.modalWrap .mo_container {
    margin: 0 15px;
    padding: 20px 0 0px 0;
}
.scroll_body {
    max-height: 550px;
    overflow-y: auto;
    overflow-x: hidden;
}
.network_st_box {
	margin-top:5px;
}
</style>
<!-- -------- each page css :E -------- -->


</head>

	<div class="modalWrap">
		<div class="mo_container">
	    	<div class="changeManabox">
	        	* 첫글확인 : 첫 글에 대한 수신 확인<br/>
	        	* 전체확인 : 마지막 댓글까지 모두 확인
                <!--참가자 리스트-->
				<div class="network_st_box">

					<div class="scroll_body" style="height:300px;">
	               		<table id="SGridTarget" class="network_tb_st" style="table-layout:fixed;" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
	                   	<caption>
	                       메모 참가자 수신 확인 정보
	                   	</caption>
	                   	<colgroup>
	         				<col width="13%" />	<!--NO-->
	                       	<col width="26%" />	<!--이름-->
	                       	<col width="22%" />	<!--첫글확인-->
	                       	<col width="22%" />	<!--최종확인-->
	                       	<col width="17%" />	<!--구분-->
	                   	</colgroup>
	                   	<thead>
		                        <tr>
		                        	<th scope="col">NO</th>
		                        	<th scope="col">이름</th>
		                        	<th scope="col">첫글확인</th>
		                        	<th scope="col">전체확인</th>
		                        	<th scope="col">구분</th>
		                        </tr>
		                    </thead>
	                   	<tbody>
	                   	<%--
	                       --%>
						</tbody>
	                    </table>
					</div>
				</div>

	        </div>

	    </div>
	    <div class="mo_footer">
	    	<div class="btnZone"><a href="javascript:fnObj.doClose();"><strong>닫기</strong></a></div>
	    </div>

	</div>

</html>



<script type="text/javascript">

//Global variables :S ---------------

//공통코드(외,코드)
var myGrid = new SGrid(); 		// instance


var g_list = '${list}';			//메모 참가자 수신확인 정보 리스트

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		//comCodeMenuLoc = getCommonCode('MENU_LOC', lang,  'CD', 'NM');			//메뉴위치 공통코드 (Sync ajax)
		//roleCodeCombo = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/system/getRoleCodeCombo.do');		//권한코드(콤보용) 호출

		/* if(!isEmpty(g_cstList)){
			g_cstListObj = JSON.parse(g_cstList);
			//sortByKey(g_staffListObj, 'usrNm', 'ASC');		//이름정렬
		} */

	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            	{key:"NO",	formatter:function(obj){
				    			//return (1 + obj.index) + ( ( obj.page.pageNo - 1) * obj.page.pageSize );						//페이징 반영 순서
				    			//return (obj.list.length - obj.index) + ( ( obj.page.pageNo - 1) * obj.page.pageSize );		//역순 (오류...다시 손보자!!)
				            	return ("<font color=silver>" + (obj.index + 1) + "</font>");
				            }},
	            {key:"name"			},
	            {key:"frstReadStts",	formatter:function(obj){
					var tVal = '';
					if(obj.value != '00002' && obj.item.isMaster != 'Y')
						tVal = '<span class="closed_letter"><em>안읽음</em></span>';
					else
						tVal = '<span class="open_letter"><em>읽음</em></span>';

					return tVal;
				}},
	            {key:"readStts",	formatter:function(obj){
										var tVal = '';
										if(obj.value != '00002')
											tVal = '<span class="closed_letter"><em>안읽음</em></span>';
										else
											tVal = '<span class="open_letter"><em>읽음</em></span>';

										return tVal;
									}},
				{key:"isMaster",	formatter:function(obj){
										return (obj.value=='Y'?'방장':'');
									}}

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
                		var popup = window.open('', 'cstView1', 'toolbar=no,width=1000,height=850');
                		popup.location.href="<c:url value='/person/main.do'/>?sNb=" + obj.item.sNb;
                	} */
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';

    	rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td>#[3]</td>';
    	rowHtmlStr +=	 '<td>#[4]</td>';

        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;


    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------


    	myGrid.setGridData({				//그리드 데이터 세팅
							list: JSON.parse(g_list)		//그리드 테이터
							//,page: pageObj	//페이징 데이터
   						});



    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################


    doClose: function(){
    	parent.myModal.close();
    }


  	/*
  	//저장(메뉴구조)
    doAccept: function(){

    	var list = myGrid.getList();		//선택한 고객

		var mCheckList = document.getElementsByName('mCheck');

		var cstSnbList = '';			//고객 id list
		var chkCnt = 0;
    	for(var i=0; i<mCheckList.length; i++){
    		if(mCheckList[i].checked){	//체크되어 있는 것을
    			if(chkCnt>0) cstSnbList += ',';
    			cstSnbList += list[i].sNb;
    			chkCnt++;
    		}
    	}

    	if(chkCnt == 0){
    		alertM("수락할 고객을 선택해주세요!");
    		return;
    	}



    	//등록 프로세스 진행
    	if(confirm('등록 하시겠습니까?')){

    		var url = contextRoot + "/person/doAcceptCstManager.do";
        	var param = {
        			cstList : cstSnbList	//고객 id list (sequence list)
        	}

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		var cnt = obj.resultVal;	//결과수

        		if(obj.result == "SUCCESS"){

        			//alertM("등록 되었습니다.");
        			parent.myModal.close();

        			parent.toast.push("등록 되었습니다!");

        			parent.fnObj.doSearch();	//재조회
        		}else{
        			//alertMsg();
        		}

        	};

        	//alert(JSON.stringify(param));
        	//return;

        	commonAjax("POST", url, param, callback);
    	}


    },//end doAccept



	//고객리스트 체크박스 전체체크
    chkCustAll: function(th, knd){		//knd : '1'(left) or '2'(right)
    	if(th.checked){
    		$('input:checkbox[name=mCheck' + knd + ']').attr('checked', true);		//고객전체 체크
    	}else{
    		$('input:checkbox[name=mCheck' + knd + ']').removeAttr('checked');		//고객전체 체크해제
    	}
    }
     */



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
});
</script>