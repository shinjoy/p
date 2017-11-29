<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id = "frm" name ="frm">
	<input type="hidden" id = "projectExpenseId" name = "projectExpenseId">
	<div id="compnay_dinfo">
		<!--업무일지등록-->
		<div class="modalWrap2">
			<h1><strong>[${baseUserLoginInfo.projectTitle} 지출 내역]</strong></h1>
			<div class="mo_container">
				<div class="sys_p_noti mgb10"><span class="icon_noti"></span><span class="pointB">지출등록(법인카드 사용내역 포함), 지출결의서에 등록된 지출 목록입니다.</span></div>
				<div class="sys_p_noti mgb10"><span class="icon_noti"></span><span class="pointB">중복 지출 등록된 경우 비차감 처리 할 수 있습니다.</span></div>

				 <p class="table_notice"><span class="point">* ${baseUserLoginInfo.projectTitle} 예산</span>: <span id = "projectBudgetAmt"></span> </p>
				 <p class="table_notice"><span class="point">* 지출</span>:
					 <span id="v_expense"></span>
	                 <span id="v_overEx"></span>
	                 <span id="v_overExpense"></span>
	                 <span id="cardExpenseSumArea" class="current_expense mgl20"></span>
				 </p>
				<br>
				<table id="SGridTarget" class="tb_list_basic" summary="CODE 등록 (정렬값, 영문코드, 한글명, 추가/삭제)">
					<caption>지출 리스트</caption>
					<colgroup>
						<col width="40" />
						<col width="100">
						<col width="100">
						<col width="150">
						<col width="100">
						<col width="100">
						<col width="*">
						<col width="100">
						<col width="*">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><label><input type="checkbox" id = "chkAll"/><em class="hidden">전체선택</em></label></th>
							<th scope="col">구분</th>
							<th scope="col">등록종류</th>
							<th scope="col">${baseUserLoginInfo.activityTitle}</th>
							<th scope="col">차감일</th>
							<th scope="col">지출비용</th>
							<th scope="col">문서번호/카드번호</th>
							<th scope="col">등록자</th>
							<th scope="col">비고</th>

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

		        <div class="btn_baordZone2" id="viewBtnArea">
		           <a href="#" onclick="fnObj.nonExpenseAll();" class="btn_blueblack btn_auth">비차감</a>
		       </div>
			</div>
		</div>
		 <!--창닫기-->
	    <div class="todayclosebox">
	        <div class="fr_block"><button type="button" class="btn_close" onClick="window.close();"><span>닫기</span><span>X</span></button></div>
	    </div>
	    <!--//창닫기//-->
		<!--//업무일지등록//-->
	</div>
</form>
<form id = "approveFrm" name = "approveFrm" method="post">

	<!-- 상세화면 이동을 위한 파라미터  :S -->
	<input type="hidden" id = "appvDocId" name = "appvDocId">
	<input type="hidden" id = "appvDocClass" name = "appvDocClass">

	<input type="hidden" id = "approveDetailPopYn" name = "approveDetailPopYn" value="Y">
	<!-- 상세화면 이동을 위한 파라미터  :E -->
</form>
<script type="text/javascript">


var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs


var curPageNo = 1;				//현재페이지번호
var pageSize = 10;				//페이지크기(상수 설정)

var g_projectId = '${projectId}';

var projectInfo;

var actList;
var fnObj = {

	preloadCode: function(){
		projectInfo=opener.parent.fnObj.getProject();

		actList = opener.parent.fnObj.getActList();

		var codeYesNoForNm = opener.parent.codeYesNoForNm;

		if(projectInfo.budget == 'Y'){
    		var korNum = numToKorean(''+projectInfo.budgetAmt);
    		$('#projectBudgetAmt').html(formatMoney(''+projectInfo.budgetAmt, 'INSERT') + '원 ' + (isEmpty(korNum)?'':'<em>(' + korNum + ')</em>'));	//예산
    	}else{
    		$('#projectBudgetAmt').html(codeYesNoForNm[projectInfo.budget]);				//예산
    	}

		$('#v_expense').html(codeYesNoForNm[projectInfo.expense]);				//지출
    	if(projectInfo.expense == 'Y'){

    		var getRowObjectWithValue = opener.parent.getRowObjectWithValue;
    		var codeOverExpenseYesNo = opener.parent.codeOverExpenseYesNo;
    		var codeChgTimeSheetYesNo = opener.parent.codeChgTimeSheetYesNo;


    		$('#v_overEx').html('&nbsp;(' + getRowObjectWithValue(codeChgTimeSheetYesNo, 'CD', projectInfo.overEx)['NM'] + ')');		//기간상관여부
    		if(projectInfo.budget == 'Y') $('#v_overExpense').html('&nbsp;(' + getRowObjectWithValue(codeOverExpenseYesNo, 'CD', projectInfo.overExpense)['NM'] + ')');	//예산초과지출허용 여부

    		if(projectInfo.cardExpenseSum !=0 ){
    			$("#cardExpenseSumArea").html('<strong>현재 :</strong> <span> '+ Number(projectInfo.cardExpenseSum).toLocaleString().split(".")[0] +'</span> <em>원</em></span>');
    		}

    	}
	},

	pageStart: function(){

		//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
    		{key:"chk",			formatter:function(obj){
    													var stStr = "<input type='checkbox' name='mCheck' value = '";
    														stStr+= obj.item.projectId+"|"+obj.item.activityId+"|"+obj.item.projectExpenseRefId+"|"
    																+obj.item.projectExpenseType+"|"+obj.item.projectExpenseClass+"|"+obj.item.price+"|"
    																+obj.item.userId+"|"+obj.item.createDate+"' ";

    													if(obj.item.lastProjectDeductYn == "N"){
    														stStr+= "disabled='disabled'";
    													}
    														stStr+=	"/>";
    													return stStr;
    													}},
            {key:"expenseType", 	formatter:function(obj){return (obj.value == 'APPR' ? '전자결재' : '지출');}},
            {key:"activityName",	formatter:function(obj){return obj.value;}},
            {key:"price"	   ,	formatter:function(obj){return Number(obj.value).toLocaleString().split(".")[0] +' 원';}},
            {key:"userName"},
            {key:"createDate"},
            {key:"expenseNm"},
            {key:"title"},
            {key:"comment",formatter:function(obj){
            										var stStr = obj.value;

            										if(obj.item.lastProjectDeductYn == "N"){

            											stStr += "<a id = \"amountModifyBtn\" class=\"btn_s_type_g mgl5\" ";
            											stStr += "href=\"javascript:fnObj.processExpense('"+obj.item.lastProjectExpenseId+"')\"><em>차감처리</em></a>";
													}
            										return stStr;
            									  }},
            {key:"projectExpenseRefId"},
            {key:"projectExpenseType"},
            {key:"projectExpenseClass"},
            ],
            //
            body : {
                onclick: function(obj){
					if(obj.c!=0&&obj.c!=8){
						var projectExpenseType = obj.item.projectExpenseType;

						var projectExpenseRefId = obj.item.projectExpenseRefId;
						var param = {projectExpenseType:projectExpenseType,projectExpenseRefId:projectExpenseRefId};

						var url = contextRoot + "/project/getValidProjectExpenseView.do";

						var callback = function(data){
							var obj = JSON.parse(data);

							if(obj.resultObject.result == "SUCCESS"){
								if(projectExpenseType == "APPROVE"){
									$("#approveFrm #appvDocId").val(projectExpenseRefId);
									$("#approveFrm #appvDocClass").val('EXPENSE');

									var option = "width=898px,height=800px,resizable=yes,scrollbars = yes";
								    commonPopupOpen("approveDetailPop",contextRoot+"/approve/getApproveDrfDetail.do",option,$("#approveFrm"));
								}else if(projectExpenseType == "CARD"){
									//지출등록팝업
							    	var url = "${pageContext.request.contextPath}/card/regCard/pop.do?cardSnb="+projectExpenseRefId+"&projectViewYn=Y";
							    	var option = "left=" + (screen.width > 1400?"700":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=900, height=700, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
							    	window.open(url, "_blank", option);
								}
							}else{
								alert(obj.resultObject.msg);
								return;
							}

						};

						commonAjax("POST", url, param, callback, true, null, null);
					}
                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td>#[1]</td>';
    	rowHtmlStr +=	 '<td>#[6]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td class="txt_center d_day_st">#[5]</td>';
    	rowHtmlStr +=	 '<td class="txt_right">#[3]</td>';
    	rowHtmlStr +=	 '<td class="txt_center">#[7]</td>';
    	rowHtmlStr +=	 '<td class="txt_center">#[4]</td>';
    	rowHtmlStr +=	 '<td>#[8]</td>';

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
			colList : ['A.expenseType', 'A.price', 'userName', 'A.createDate'],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
		});
    	//-------------------------- 소팅 설정 :E ----------------------------

	},

	doSearch: function(page){

		if(page==null) page=1;

    	var url = contextRoot + "/project/getExpenseList.do";
    	var param = {
		    			pageSize: pageSize,
		    			pageNo:	page,

		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,

		    			projectId : g_projectId
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



			//소팅 초기화
			//mySorting.clearSort();
			//mySorting.setSort(3);				//소팅객체를 소팅한다.(상태값들의 변화)
			mySorting.applySortIcon();			//소팅화면적용

			//전체 건수 세팅
			//$('#total_count').html(obj.totalCount);

			//체크박스 컨트롤
			$("input[type = 'checkbox']").on("click",function(){
				if($(this).attr("id")=="chkAll"){
					if($(this).prop("checked")){
						$("input[type = 'checkbox']").not("input[disabled = 'disabled']").prop("checked",true);
					}else{
						$("input[type = 'checkbox']").not("input[disabled = 'disabled']").prop("checked",false);
					}
					return;
				}
				var chkboxlength = $("input[type = 'checkbox']").not("input[disabled = 'disabled']").not("#chkAll").length;

				if($("input[type = 'checkbox']:checked").not("#chkAll").length == chkboxlength){
					$("#chkAll").prop("checked",true);
				}else{
					$("#chkAll").prop("checked",false);
				}
			});

    	};

    	commonAjax("POST", url, param, callback);


	},

	  //컬럼 소팅
    doSort: function(idx){

    	mySorting.setSort(idx);				//소팅객체를 소팅한다.(상태값들의 변화)
    	fnObj.doSearch(1);
    	myGrid.refresh();
    	mySorting.applySortIcon();			//소팅화면적용
        //myGrid.refresh();
       // mySorting.applySortIcon();			//소팅화면적용

    },
    //비차감 일괄처리
    nonExpenseAll:function(){
    	if($("input[name='mCheck']:checked").length == 0){
			alert("최소 한건 이상 선택해 주세요.");
			return;
		}

    	var callback = function(result){
    		opener.parent.fnObj.setProjectInfo();

    		alert("저장되었습니다.");

    		//fnObj.preloadCode();

    		fnObj.doSearch();
    	}

    	if(confirm("선택하신 지출내역을 비차감 처리하시겠습니까?")){
    		$("#frm").attr("action",contextRoot+"/project/processNonExpenseAll.do");
    		commonAjaxSubmit("POST",$("#frm"),callback,true);
    	}
    },
    //차감 처리
    processExpense:function(lastProjectExpenseId){
    	var callback = function(result){
    		opener.parent.fnObj.setProjectInfo();
    		alert("차감처리되었습니다.");

    		//fnObj.preloadCode();

    		fnObj.doSearch();


    	}
    	if(confirm("차감 처리하시겠습니까?")){

    		$("#projectExpenseId").val(lastProjectExpenseId);
    		$("#frm").attr("action",contextRoot+"/project/processExpense.do");
    		commonAjaxSubmit("POST",$("#frm"),callback,true);
    	}
    }
};

$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//화면세팅
})
</script>


