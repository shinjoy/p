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



<!-- -------- each page css :E -------- -->


</head>

	<form name="myForm">

		<!--모달 담당자변경-->
	        <div class="modalWrap2">
	            <div class="mo_container"  id = "newCstInChargeArea">
	            	<div class="changeManabox" >
	                	<div class="Block03">
	                    	<h2 class="title"><span class="fontRed">나에게 신규 할당된 고객리스트 입니다!</span></h2>
	                        <!--고객 리스트-->
				            <div class="network_st_box">

			                    <table class="network_tb_st" style="table-layout:fixed;" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
			                        <caption>고객관리 리스트</caption>
			                        <colgroup>
			                            <col width="35" /> <!--선택-->
			                            <col width="70" /> <!--이름-->
			                            <col width="*" /> <!--회사-->
			                            <col width="100" /> <!--고객구분-->
			                            <col width="130" /> <!--직위-->
			                            <col width="100" /> <!--연락처-->
			                            <col width="70" /> <!--기담당자-->
			                            <col width="*" /> <!--인물구분-->
			                        </colgroup>
			                        <thead>
			                            <tr>
			                            	<th scope="col" class="checkinput"><label><input id="chkAllLeft" onclick="fnObj.chkCustAll(this, '');" type="checkbox" /><em>전체선택</em></label></th>
			                            	<th scope="col">이름</th>
			                            	<th scope="col">회사</th>
			                            	<th scope="col">고객구분</th>
			                            	<th scope="col">직위</th>
			                            	<th scope="col">연락처</th>
			                            	<th scope="col">이전담당자</th>
			                            	<th scope="col">인물구분</th>
			                            </tr>
			                        </thead>
			                    </table>

			                    <table id="SGridTarget" class="network_tb_st" style="table-layout:fixed;" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
			                        <caption>고객 리스트</caption>
			                        <colgroup>
			                            <col width="35" /> <!--선택-->
			                            <col width="70" /> <!--이름-->
			                            <col width="*" /> <!--회사-->
			                            <col width="100" /> <!--고객구분-->
			                            <col width="130" /> <!--직위-->
			                            <col width="100" /> <!--연락처-->
			                            <col width="70" /> <!--기담당자-->
			                        </colgroup>
			                        <tbody>
			                        	<%--
			                            --%>
		                            </tbody>
		                        </table>
							</div>
							<%--<p class="notice_script"><span class="red">*</span>1차 선택한 고객들을 최종 확인하여 오른쪽으로 이동시키기 바랍니다.</p> --%>
	                    </div>
	                </div>
	            </div>
	            <div class="mo_footer"  id="btnAccept" >
                    <div class="btnZone">
                        <a href="javascript:fnObj.doAccept();"><strong>수락</strong></a>
                        <a id="btnClose1" href="javascript:fnObj.closeThisPop();" class="p_withelin_btn">닫기</a>
                    </div>
                </div>


	            <div class="mo_container" id="customerChangeArea">
	                <c:if test="${fn:length(customerChangeManagerList)>0 }">
						<br>
						<div class="changeManabox">
		                	<div class="Block03">
		                    	<h2 class="title"><span class="fontRed">관계사 추가 담당자 지정 고객 리스트입니다!</span></h2>
		                        <!--고객 리스트-->
					            <div class="network_st_box">

					                    <table class="network_tb_st" style="table-layout:fixed;" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
					                        <caption>고객관리 리스트</caption>
					                        <colgroup>
					                            <col width="70" /> <!--이름-->
					                            <col width="*" /> <!--회사-->
					                            <col width="110" /> <!--고객구분-->
					                            <col width="130" /> <!--직위-->
					                            <col width="100" /> <!--연락처-->
					                            <col width="70" /> <!--추가담당자-->
					                            <col width="*" /> <!--관계사-->
					                            <col width="80" /> <!--확인-->
					                        </colgroup>
				                        <thead>
				                            <tr>
				                            	<th scope="col">이름</th>
				                            	<th scope="col">회사</th>
				                            	<th scope="col">고객구분</th>
				                            	<th scope="col">직위</th>
				                            	<th scope="col">연락처</th>
				                            	<th scope="col">추가담당자</th>
				                            	<th scope="col">관계사</th>
				                            	<th scope="col">확인</th>
				                            </tr>
				                        </thead>
				                        <tbody>
                                            <c:forEach items="${customerChangeManagerList }" var = "data">
                                                <tr>
                                                    <td>${data.cstNm }</td>
                                                    <td class="left_txt">${data.cpnNm }</td>
                                                    <td class="left_txt">${data.categoryPersonNm }</td>
                                                    <td>${data.position }</td>
                                                    <td>${data.phn1 }</td>
                                                    <td>${data.otherManagerNm }</td>
                                                    <td>${data.updatedCpnNm }</td>
                                                    <td><button type="button" onClick="fnObj.openPersonDetailPop('${data.customerId}');" class="btn_g_black mgl10">조회</button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
					                </table>

								</div>
								<%--<p class="notice_script"><span class="red">*</span>1차 선택한 고객들을 최종 확인하여 오른쪽으로 이동시키기 바랍니다.</p> --%>
		                    </div>
		                </div>
	                </c:if>
	                <c:if test="${fn:length(customerChangeInfoList)>0 }">
						<br>
						<div class="changeManabox">
		                	<div class="Block03">
		                    	<h2 class="title"><span class="fontRed">추가 담당자가 정보를 업데이트한 고객리스트입니다!</span></h2>
		                        <!--고객 리스트-->
					            <div class="network_st_box">
				                    <table class="network_tb_st" style="table-layout:fixed;" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
				                        <caption>고객관리 리스트</caption>
				                        <colgroup>
					                            <col width="70" /> <!--이름-->
					                            <col width="*" /> <!--회사-->
					                            <col width="110" /> <!--고객구분-->
					                            <col width="130" /> <!--직위-->
					                            <col width="100" /> <!--연락처-->
					                            <col width="70" /> <!--추가담당자-->
					                            <col width="*" /> <!--관계사-->
					                            <col width="80" /> <!--확인-->
					                        </colgroup>
				                        <thead>
				                            <tr>
				                            	<th scope="col">이름</th>
				                            	<th scope="col">회사</th>
				                            	<th scope="col">고객구분</th>
				                            	<th scope="col">직위</th>
				                            	<th scope="col">연락처</th>
				                            	<th scope="col">추가담당자</th>
				                            	<th scope="col">관계사</th>
				                            	<th scope="col">확인</th>
				                            </tr>
				                        </thead>
				                        <tbody>
                                            <c:forEach items="${customerChangeInfoList }" var = "data">
                                                <tr>
                                                    <td>${data.cstNm }</td>
                                                    <td class="left_txt">${data.cpnNm }</td>
                                                    <td class="left_txt">${data.categoryPersonNm }</td>
                                                    <td>${data.position }</td>
                                                    <td>${data.phn1 }</td>
                                                    <td>${data.otherManagerNm }</td>
                                                    <td>${data.updatedCpnNm }</td>
                                                    <td><button type="button" onClick="fnObj.openPersonDetailPop('${data.customerId}');" class="btn_g_black mgl10">조회</button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
				                    </table>

								</div>
								<%--<p class="notice_script"><span class="red">*</span>1차 선택한 고객들을 최종 확인하여 오른쪽으로 이동시키기 바랍니다.</p> --%>
		                    </div>
		                </div>
	                </c:if>
	            </div>
	            <div class="mo_footer" id="btnClose2" >
	            	<div class="btnZone">
	            	    <a href="javascript:fnObj.closeThisPop();" class="p_withelin_btn">닫기</a>
	            	</div>
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


var g_cstList;		//고객리스트 (신규할당된)
var g_cstListObj = [];

//공통코드
var categorYPersonCdType = getBaseCommonCode('CUSTOMER_TYPE', null, 'CD', 'NM', '', '선택', null, { orgId : "${baseUserLoginInfo.applyOrgId}" });

//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){

		var url = contextRoot + "/person/getCustListNewInCharge.do";
	  	var param = {};

	  	var callback = function(result){
	  		var obj = JSON.parse(result);

	  		var cnt = obj.resultVal;		//결과수
	  		var list = obj.resultList;		//결과데이터JSON

	  		if(list.length > 0){
	      	    g_cstList = JSON.stringify(list);				//선택한 고객리스트 														/***** param 1 *****/
	  		}
	  	};

	  	commonAjax("POST", url, param, callback, false);

		if(!isEmpty(g_cstList)){
			g_cstListObj = JSON.parse(g_cstList);
			//sortByKey(g_staffListObj, 'usrNm', 'ASC');		//이름정렬
		}

	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            {key:"chk",			formatter:function(obj){
            	return ("<input type='checkbox' name='mCheck' />");
            	}
            },
            {key:"cstNm"		},
            {key:"cpnNm"		},
            {key:"custTypeNm"	},		//고객구분
            {key:"position"		},		//직위
            {key:"phn1"			},		//연락처
            {key:"usrNm"		},		//기담당자
            {key:"chk",			formatter:function(obj){
            									var searchAppvDocClassTag = createSelectTag('categoryPersonCd', categorYPersonCdType, 'CD', 'NM', obj.item.custType, null, {}, '', 'select_b w100pro');
											    return (searchAppvDocClassTag);
											            	}
			}
            ],

            body : {
                onclick: function(obj){
                	/* ***** obj *****
                		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
                	*/
                	if(obj.c > 0 && obj.c < 7){
                		var popup = window.open('', 'cstView1', 'toolbar=no,width=1000,height=850');
                		popup.location.href="<c:url value='/person/main.do'/>?sNb=" + obj.item.sNb;
                	}
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td class="checkinput"><label>#[0]<em>선택</em></label></td>';
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td class="left_txt">#[2]</td>';
    	rowHtmlStr +=	 '<td class="left_txt">#[3]</td>';
    	rowHtmlStr +=	 '<td>#[4]</td>';
    	rowHtmlStr +=	 '<td>#[5]</td>';
    	rowHtmlStr +=	 '<td>#[6]</td>';
    	rowHtmlStr +=	 '<td>#[7]</td>';
        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;


    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------


    	myGrid.setGridData({				//그리드 데이터 세팅
							list: g_cstListObj		//그리드 테이터
							//,page: pageObj	//페이징 데이터
   						});



    	//초기 체크상태로 되도록
    	$('#chkAllLeft').attr('checked', true);
    	fnObj.chkCustAll($('#chkAllLeft').get(0), '');


    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################


  	//저장(메뉴구조)
    doAccept: function(){

    	var list = myGrid.getList();		//선택한 고객
    	var chkCnt = 0;
    	var cstSnbList = '';
    	var custTypeList = '';

    	var chk = true;

    	$("input[name = 'mCheck']").each(function(i){
    		if($(this).prop("checked")){
    			if(chkCnt>0) {
    				cstSnbList += ',';
    				custTypeList += ',';
    			}
    			cstSnbList += list[i].sNb;

    			var custType = $(this).parent().parent().parent().find("select[name='categoryPersonCd']").val();

    			if(custType == null || custType == ""){
    				chk = false;
    				return false;
    			}
    			custTypeList += custType;
    			chkCnt++;
    		}
    	});

    	if(!chk){
    		alertM("인물구분을 선택해주세요!");
    		return;
    	}

    	if(chkCnt == 0){
    		alertM("수락할 고객을 선택해주세요!");
    		return;
    	}

    	//등록 프로세스 진행
    	if(confirm('수락 하시겠습니까?')){

    		var url = contextRoot + "/person/doAcceptCstManager.do";
        	var param = {
        			cstList : cstSnbList,	//고객 id list (sequence list)
        			custTypeList:custTypeList
        	}

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		var cnt = obj.resultVal;	//결과수

        		if(obj.result == "SUCCESS"){
        			// parent.myModal.close();
        			parent.toast.push("수락 되었습니다!");
        			//parent.fnObj.doSearch(1);	//재조회

        			fnObj.reloadInCharge();

        		}else{
        			//alertMsg();
        		}

        	};

        	commonAjax("POST", url, param, callback);
    	}


    },//end doAccept

    reloadInCharge : function(){

        var url = contextRoot + "/person/getCustListNewInCharge.do";
        var param = {};

        var callback = function(result){
            var obj = JSON.parse(result);

            var cnt = obj.resultVal;        //결과수
            var list = obj.resultList;      //결과데이터JSON

            if(list.length > 0){
                g_cstList = JSON.stringify(list);               //선택한 고객리스트                                                         /***** param 1 *****/
                g_cstListObj = JSON.parse(g_cstList);
                fnObj.pageStart();      //화면세팅
            }else{
                $("#btnAccept").hide();
                $("#newCstInChargeArea").hide();
            }

			//담당자 변경정보가 없으면
			if("${fn:length(customerChangeInfoList)}" == "0" && "${fn:length(customerChangeManagerList)}" == "0"){
			    $("#btnClose1").show();
			    $("#btnClose2").hide();
			    $("#customerChangeArea").hide();
			}else{
			    $("#btnClose1").hide();
			    $("#btnClose2").show();
			    $("#customerChangeArea").show();
			}

			if(list.length == 0 && "${fn:length(customerChangeInfoList)}" == "0" && "${fn:length(customerChangeManagerList)}" == "0"){
				parent.myModal.close();
	            parent.fnObj.doSearch(1); //재조회
			}else{
				parent.myModal.resize();
			}
        };

        commonAjax("POST", url, param, callback, false);


    },



	//고객리스트 체크박스 전체체크
    chkCustAll: function(th, knd){		//knd : '1'(left) or '2'(right)
    	if(th.checked){
    		$('input:checkbox[name=mCheck' + knd + ']').attr('checked', true);		//고객전체 체크
    	}else{
    		$('input:checkbox[name=mCheck' + knd + ']').removeAttr('checked');		//고객전체 체크해제
    	}
    },
    //고객상세팝업
    openPersonDetailPop:function(snb){
    	var url = "<c:url value='/person/main.do'/>?sNb=" + snb + "&searchOrgId=${baseUserLoginInfo.applyOrgId}";
   		var popup = window.open(url, 'cstView', 'resizable=no,width=968,height=600,scrollbars=yes');
    },

    //현재창 닫기
    closeThisPop : function(){
    	parent.myModal.close();
        parent.fnObj.doSearch(1); //재조회
    },


  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드

	//if(g_cstList.length!=null && g_cstList.length>0){
	if(!isEmpty(g_cstList)){
		fnObj.pageStart();		//화면세팅
	}else{
		$("#btnAccept").hide();
		$("#newCstInChargeArea").hide();
	}

	//담당자 변경정보가 없으면
	if("${fn:length(customerChangeInfoList)}" == "0" && "${fn:length(customerChangeManagerList)}" == "0"){
		$("#btnClose1").show();
		$("#btnClose2").hide();
		$("#customerChangeArea").hide();
	}else{
		$("#btnClose1").hide();
        $("#btnClose2").show();
        $("#customerChangeArea").show();
	}




	//fnObj.doSearch();		//검색(메뉴리스트)
	//fnObj.doSearch2();		//검색(권한별메뉴)
	//fnObj.setTooltip();
});
</script>