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
<script type="text/JavaScript" src="<c:url value='/js/process.js'/>" ></script>

<script>var contextRoot="${pageContext.request.contextPath}";</script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/sys/utils.js" ></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/common.js"></script><!-- ajaxRequest, etc -->
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
    padding: 20px 0 10px 0;
}

.selUserStyle option{
	font-size:15px;
}
.Block01 .title{
	padding-bottom:6px;
}
.scroll_body {
    overflow-y: hidden;
    overflow-x: hidden;
}
.s_gray01_btn {
    background: url(../images/common/bg_gray_sbtn.gif) repeat-x left bottom;
    border: #b7b7b7 solid 1px;
    border-radius: 2px;
    color: #888;
    padding: 4px 5px 5px;
    font-size: 11px;
    vertical-align: middle;
    font-weight: normal;
    font-family: "돋움",Dotum,"굴림",Gulim,arial,sans-serif;
}
</style>
<!-- -------- each page css :E -------- -->


</head>

	<form name="myForm">

		<!--모달 담당자변경-->
	        <div class="modalWrap">
	            <div class="mo_container">
	            	<div class="changeManabox">
                    	<h2 class="title" style="color:;">정보공개등급별 사용자리스트</h2>
                        <!--고객 리스트-->
			            <div class="network_st_box">
							<div class="scroll_body" style="height:295px;">
			                    <table id="SGridTarget" class="network_tb_st" style="table-layout:fixed;" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
			                        <caption>
			                            정보공개 등급별 사용자리스트
			                        </caption>
			                        <colgroup>
			                            <col width="70" /> <!--버튼-->
			                            <col width="100" /> <!--등급-->
			                            <col width="*" /> <!--사용자-->
			                        </colgroup>
			                        <thead>
			                            <tr>
			                            	<th scope="col">선택</th>
			                            	<th scope="col">등급</th>
			                            	<th scope="col">사용자</th>
			                            </tr>
			                        </thead>
			                        <tbody>
			                        	<%--
			                            --%>
		                            </tbody>
		                        </table>
		                    </div>
						</div>
						<%--<p class="notice_script"><span class="red">*</span>1차 선택한 고객들을 최종 확인하여 오른쪽으로 이동시키기 바랍니다.</p> --%>

	                </div>


	            </div>
	            <div class="mo_footer">
	            	<div class="btnZone"><a href="javascript:window.close();"><strong>닫기</strong></a></div>
	            </div>
	        </div>

	    <!--//모달 담당자변경//-->


	</form>

</html>



<script type="text/javascript">

//Global variables :S ---------------

//공통코드(외,코드)
//var comCodeMenuLoc;				//메뉴위치코드
//var roleCodeCombo;				//권한코드

//var mySearch = new AXSearch(); 	// instance
//var mySearch2 = new AXSearch(); // instance (오른쪽)
var myGrid = new SGrid(); 		// instance
//var myGrid2 = new SGrid(); 		// instance	(오른쪽)

var myModal = new AXModal();	// instance


var g_infoType = '${it}';		//정보 타입		'm': M&A  or other


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

		/*
		if(!isEmpty(g_cstList)){
			g_cstListObj = JSON.parse(g_cstList);
		} */
	},


	//화면세팅
    pageStart: function(){

    	//M&A 정보공개등급 일 경우
    	if(g_infoType == 'm'){
    		$('.title').html('<font color=blue>[M&A]</font> 정보공개등급별 사용자리스트');
    	}

    	//등급 폰트 칼라 object
    	var colorObj = ['#ff2222',  	//보안1등급
    	                '#ff4444',  	//보안2등급
    	                '#ff5555',  	//보안3등급
    	                '#ff7777',  	//보안4등급
    	                '#ff8888',  	//보안5등급
    	                '#ff9999',  	//보안6등급
    	                '#ffaaaa',  	//보안7등급
    	                '#ffbbbb'];		//보안8등급


    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
				{key:"btn",			formatter:function(obj){return '<a href="javascript:fnObj.selLevel(' + obj.item.lvl + ');" class="s_gray01_btn" ><em class="del">&nbsp;선택&nbsp;</em></a>';}},
            	{key:"lvl",			formatter:function(obj){
            							if(obj.value == 9){
            								return '일반등급';
            							}else{
            								return '<b><font color=' + colorObj[obj.value] + '>보안' + obj.value + '등급</font></b>';
            							}
            							return obj.value;}},
            	{key:"names",		formatter:function(obj){
            							if(obj.item.lvl == 9){
            								return '전체공개';
            							}
            							return obj.value;}}
            ],

            body : {
                onclick: function(obj){
                	/* ***** obj *****
                		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
                	*/
                	if(obj.c == 2){
                		//
                	}
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr height="27">';
    	rowHtmlStr +=	 '<td style="cursor:pointer;">#[0]</td>';
    	rowHtmlStr +=	 '<td style="cursor:pointer;">#[1]</td>';
    	rowHtmlStr +=	 '<td class="left_txt" style="cursor:pointer;">#[2]</td>';
        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;


    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------



    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################


  	//등급별 사용자 보기
    doSearch: function(){

    	var url = contextRoot + "/work/getInfoLevelUser.do";
    	var param = {
		    			infoType : g_infoType
		    		};


    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;		//결과수
    		var list = obj.resultList;		//결과데이터JSON



    		//alert(JSON.stringify(list));
    		//return;


    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list		//그리드 테이터
								//page: pageObj	//페이징 데이터
    						});


    	};


    	//commonAjax("POST", url, param, callback, true, beforeFn, completeFn);
    	commonAjax("POST", url, param, callback, true, null, null);

    },//doSearch



	//등급선택
    selLevel: function(lvl){
    	var sel = $('#infoLevel', opener.document);
    	sel.val(lvl);
    	opener.setSelectColor(sel.get(0));

    	window.close();		//닫기
    }




  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색(메뉴리스트)

});
</script>