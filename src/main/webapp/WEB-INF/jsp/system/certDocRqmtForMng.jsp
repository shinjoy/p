<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 증명서 요청내역( 인사팀만 접근하는 페이지 )  -->
<style>
.rightblock .sh_count_type
{
	width: 110px;
    line-height: 17px;
    height: 23px;
    padding: 3px 5px;
    box-sizing: border-box;
    vertical-align: middle;
    border: #c2c2c2 solid 1px;
    color: #5a5a5a;
}

.datagrid_basic{
    letter-spacing: -0.08px;
    width: 100%;
    border: #c3c3c3 solid 1px;
}
 </style>



<section id="detail_contents">

   	<form name="certDocForm" id="certDocForm">
   		<input type="hidden" name="formDocCd" id="formDocCd">
   		<input type="hidden" name="formDocReqSeq" id="formDocReqSeq">
	</form>


	<div class="carSearchBox">
		<select name="year" id="year" class="select_b w_date">
			<c:forEach begin="2016" end="${maxYear}" step="1" var="status">
					<option value="${status}">${status}년</option>
			</c:forEach>
		</select>
		<select name="month" id="month" class="select_b w_date mgl6" onchange="fnObj.selectMonth(this.value);">
			<c:forEach begin="1" end="13" step="1" varStatus="status">
				<c:choose>
					<c:when test="${status.count eq 13}">
						<option value="13" >전체</option>
					</c:when>
					<c:otherwise>
						<option value="${status.count}" >${status.count}월</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		<span class="carSearchtitle mgl40">기간조회</span>
           <input type="text" value="" class="input_b" id="inputStartDate" style="height:24px;" onclick="$(this).val('');" readonly="readonly"/>
           <a href="#" onclick="$('#inputStartDate').datepicker('show');return false;" class="btn_calendar" style="margin-left:-5px;border:0px solid #c2c2c2;padding:0px;"></a>
           <span class="between_txt">~ </span> <input type="text" id="inputEndDate" style="height:24px;"  onclick="$(this).val('');" value="" class="input_b" readonly="readonly"/>
           <a href="#" onclick="$('#inputEndDate').datepicker('show');return false;" class="btn_calendar" style="margin-left:-5px;border:0px solid #c2c2c2;padding:0px;"></a>
           <a href="#" onclick="fnObj.doSearch(1);" class="btn_g_black mgl10">조회</a>
	</div>
	<div class="board_classic mgt20">
		<div class="leftblock">
         	<span class="count_result"><strong>전체</strong><em id="total_count"></em>건</span>
            <select id="sel_page_size" onChange="fnObj.setPageSize(true);" class="sh_count_type" title="정렬방법 선택">
             	<option value="10">10개씩 보기</option>
             	<option value="15">15개씩 보기</option>
                 <option value="30">30개씩 보기</option>
                 <option value="50">50개씩 보기</option>
            </select>
         </div>
        <div class="rightblock">
        	<span style="margin-right:15px;display:none;">
        		소속관계사 :
        		<select name="targetOrgId" class="sh_count_type" id="targetOrgId" onchange="fnObj.changeTargetOrgId();">
        		<c:forEach items="${orgList}" var="item">
        			<option value="${item.orgId}" ${item.orgId == baseUserLoginInfo.applyOrgId ? "selected" : ""}>${item.cpnNm}</option>
        		</c:forEach>
        		</select>
	        </span>
        	<span style="margin-right:15px;">
        		요청자 :
        		<select name="reqUserId"  class="sh_count_type" id="reqUserId" onchange="fnObj.persearhEnd('req', this.value);">
					<option value="">전체</option>
					<c:forEach var="result" items="${empList}" varStatus="status">
						<option value="${result.userId}">${result.perNm}</option>
					</c:forEach>
				</select>
			</span>
			대상자 :
			<select name="targetUserId"  class="sh_count_type" id="targetUserId" onchange="fnObj.persearhEnd('target', this.value);">
				<option value="">전체</option>
				<c:forEach var="result" items="${allEmpList}" varStatus="status">
					<option value="${result.userId}">${result.perNm}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<!-- 프로젝트 목록 -->
	<table id="SGridTarget" class="tb_list_basic" summary="증명서 요청내역(순번, 증명서종류, 용도, 요청자, 대상자, 요청일자, 완료일자, 처리자, 처리상태)">
	      <caption>증명서 요청내역</caption>
	      <colgroup>
	        <col width="50" />
			<col width="400" />
			<col width="*" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
	      </colgroup>
	      <thead>
	          <tr>
	              <th scope="col">순번</th>
	              <th scope="col"><a href="#" onclick="fnObj.doSort(0);" id="sort_column_prefix0" class="sort_normal">증명서종류<em>정렬</em></a></th>
	              <th scope="col"><a href="#" onclick="fnObj.doSort(1);" id="sort_column_prefix1" class="sort_normal">용도<em>정렬</em></a></th>
	              <th scope="col"><a href="#" onclick="fnObj.doSort(2);" id="sort_column_prefix2" class="sort_normal">요청자<em>정렬</em></a></th>
	              <th scope="col"><a href="#" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">대상자<em>정렬</em></a></th>
	              <th scope="col"><a href="#" onclick="fnObj.doSort(4);" id="sort_column_prefix4" class="sort_normal">요청일자<em>정렬</em></a></th>
	              <th scope="col"><a href="#" onclick="fnObj.doSort(5);" id="sort_column_prefix5" class="sort_normal">완료일자<em>정렬</em></a></th>
	              <th scope="col"><a href="#" onclick="fnObj.doSort(6);" id="sort_column_prefix6" class="sort_normal">처리자<em>정렬</em></a></th>
	              <th scope="col"><a href="#" onclick="fnObj.doSort(7);" id="sort_column_prefix7" class="sort_normal">처리상태<em>정렬</em></a></th>
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
	 <div class="btn_baordZone" id = "writerArea">
	 	<a href="javascript:fnObj.doWriteContent()" class="btn_blueblack btn_auth">경력증명서 발급</a>
	 </div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')
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

		$("#inputStartDate").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			yearRange: 'c-1:c+9',
			maxDate: '+0d'
		});

		$("#inputEndDate").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			yearRange: 'c-1:c+9',
			maxDate: '+0d'
		});

		var year = "${vo.year}";
		var month = "${vo.month}";

		$("#year").val(year);
		$("#month").val( parseInt(month));

		//fnObj.changeTargetOrgId();

		//페이지크기 세팅
		fnObj.setPageSize();
	},


	//화면세팅
    pageStart: function(){


    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            {key:""					, 	formatter:function(obj){

            								return  ((obj.index+1)+ parseInt(( obj.page.pageNo - 1) * obj.page.pageSize));}},
            {key:"formDocNm"		},
            {key:"formDocUse"		},
            {key:"reqPerNm"			, 	formatter:function(obj){
											var reqPerNm = obj.item.reqPerNm;
											if(reqPerNm == null) reqPerNm ="담당자";
											return  reqPerNm;}},
            {key:"targetPerNm"		},
            {key:"reqDate"			},
            {key:"reqEndDate"		},
            {key:"reqEndPerNm",		},
            {key:"reqStatus", 		formatter:function(obj){
												var str ='';
												if(obj.item.reqStatus =='Return'){
													str='<span class="icon st_reject">반려</span>';
												}else if(obj.item.reqStatus =='End'){
													str='<span class="icon st_finish">완료</span>';
												}else if(obj.item.reqStatus =='Temp'){
													str='<span class="icon st_ing">임시저장</span>';
												}else{
													str='<span class="icon st_ing">진행</span>';
												}/* else{
													str='<span>-</span>';
												} */
												return str;
									}},
            ],

            body : {
                onclick: function(obj){
                	/* ***** obj *****
                		obj.c 		- column index,
						obj.index 	- row index,
						obj.item 	- row data object,
						obj.list 	- grid data object
                	*/

                	fnObj.certDocView(obj.item);

                }
            }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td>#[0]</td>';		//td 에 이벤트를 준 케이스
    	rowHtmlStr +=	 '<td class="e_doc_type">#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td class="doc_writer">#[3]</td>';
    	rowHtmlStr +=	 '<td class="doc_writer">#[4]</td>';
    	rowHtmlStr +=	 '<td class="num_date_type">#[5]</td>';
    	rowHtmlStr +=	 '<td class="num_date_type">#[6]</td>';
    	rowHtmlStr +=	 '<td class="doc_writer">#[7]</td>';
    	rowHtmlStr +=	 '<td class="app_state">#[8]</td>';
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
			colList : ['formDocNm', 'formDocUse', 'reqPerNm', 'targetPerNm', 'reqDate', 'reqEndDate', 'reqEndPerNm', 'reqStatusNm' ],
			classNameNormal		: 'sort_normal',				//정렬기본 아이콘 css class
			classNameHighToLow	: 'sort_hightolow',				//오름정렬 아이콘 css class
			classNameLowToHigh	: 'sort_lowtohigh'				//내림정렬 아이콘 css class
		});
    	//-------------------------- 소팅 설정 :E ----------------------------



    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	if(page==null) page=1;

    	if($("#inputStartDate").val() != "" && $("#inputEndDate").val() == ""){
    		alertM("기간조회의 종료일을 입력해주세요.");
    		return;
    	}

    	if($("#inputStartDate").val() == "" && $("#inputEndDate").val() != ""){
    		alertM("기간조회의 시작일을 입력해주세요.");
    		return;
    	}

    	if($("#inputStartDate").val() > $("#inputEndDate").val() ){
    		alertM("기간이 잘못 입력되었습니다.");
    		return;
    	}


    	var url = contextRoot + "/system/certDocRqmtList.do";
    	var param = {
		    			pageSize: pageSize,
		    			pageNo:	page,

		    			sortCol: mySorting.nowSortCol,
		    			sortVal: mySorting.nowDirection,

		    			//knd: '',	//$('#srch_knd').val(),				//검색 종류
		    			month: $('#month').val(),
		    			year : $("#year").val(),

		    			inputStartDate : $("#inputStartDate").val(),
		    			inputEndDate : $("#inputEndDate").val(),

		    			reqUserId: $("#reqUserId").val(),
    					targetUserId : $("#targetUserId").val(),
    					targetOrgId : $("#targetOrgId").val()

		    		};

    	var callback = function(result){
    		//console.log(result);
    		var obj = JSON.parse(result);

    		var cnt = obj.totalCount;		//결과수
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


			//전체 건수 세팅
			$('#total_count').html(cnt);

    	};

    	commonAjax("POST", url, param, callback);

    }, //end doSearch
    //타겟 소속관계사 변경.
    changeTargetOrgId : function(){
    	var url = contextRoot + "/system/certDocRqmtForMng.do";
    	 $("<input type='text' value='"+ $("#targetOrgId").val() +"' />")
         .attr("id", "targetOrgId")
         .attr("name", "targetOrgId")
         .appendTo("#certDocForm");
    	 $("#certDocForm").attr("action", url).attr("method", "post").submit();
    },
    //요청자, 대상자 검색.
    persearhEnd : function(type, value){
    	if(type == 'target'){
    		$("#reqUserId").val("");
    	}else{
    		$("#targetUserId").val("");
    	}
    	fnObj.doSearch(1);
    },
    //월별 검색
    selectMonth : function(value){
    	$("#inputStartDate").val("");
    	$("#inputEndDate").val("");
    	fnObj.doSearch(1);
    },

    //페이지 사이즈 세팅
    setPageSize: function(isSearch){

    	pageSize = $('#sel_page_size').val();

    	//검색도 바로할 경우 ... isSearch ... true
		if(isSearch){
			fnObj.doSearch(1);
    	}
    },
  	//재정렬
  	doSort : function(index){
  		mySorting.setSort(index);

  		//소팅
        fnObj.doSearch(1);
        myGrid.refresh();


		mySorting.applySortIcon();			//소팅화면적용
  	},//doSort

  	doExcel : function(){
  		 excelDown(myGrid.getExcelFormat('html'), "download");
  	},
  	//증명서 상세보기
	certDocView : function(item) {
		$("#formDocCd").val(item.formDocCd);
		$("#formDocReqSeq").val(item.formDocReqSeq);

		$("#certDocForm").attr("action","../system/certDocViewForMng.do");
		$("#certDocForm").attr("method","post");
		$("#certDocForm").submit();

	},
	//관리자 경력증명서 작성
	doWriteContent : function(){
		location.href= "../system/careerMngCert.do";
	}

  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색
});
</script>