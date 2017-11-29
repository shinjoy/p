<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style type="text/css">
.tr_selected{background-color:#EEF;}
.wrap{
	width:100%;
}
</style>



<section id="detail_contents">

    <div class="wrap" style="min-height:900px;">

			<!--게시판검색-->
			<div class="board_classic">
				<div class="leftblock">
                	<span class="count_result"><strong>전체</strong><em id="totalCount"></em>건</span>
                    	<select class="sh_count_type" id="sel_page_size" title="정렬방법 선택" onchange="fnObj.setPageSize(true);">
                          	  <option value="15">15개씩 보기</option>
                          	  <option value="20">20개씩 보기</option>
                              <option value="30">30개씩 보기</option>
                              <option value="50">50개씩 보기</option>
                        </select>
                         <ul class="classic_kind readTimeChkbox">
                            <li><button type="button" class="btn_toggle on" onclick="readChkAll()">읽음</button></li>
                        </ul>
				</div>
                <div class="rightblock">
                	<select class="search_type" title="검색분류 선택" id="searchType">
                    	<option value="">전체</option>
                        <option value="title">제목</option>
                        <option value="writer">작성자</option>
                        <option value="content">제목+내용</option>
					</select>
                    <input type="text" placeholder="검색어입력" class="input_txt_b" title="게시판검색" id="searchKeyword" onkeyup="if(event.keyCode==13) fnObj.doSearch(1);">
                    <a href="javascript:fnObj.doSearch(1);" class="btn_wh_bevel">검색</a>
				</div>
			</div>

			<table class="board_list_st01" id="SGridTarget" summary="템플릿게시판 (가입일, 제목, 회사명, 자료링크)" >
               <caption>공지사항 목록</caption>
               <colgroup>
               	   <col class="readTimeChkbox" width="10" />  		<!-- 체크박스 -->

                   <col width="60" />  	<!-- 번호 -->
                   <col class="approveEnableArea" width="100" /> 	<!-- 상태 -->
                   <col width="200" />	<!-- 관계사 -->
                   <col width="*" /> 	<!-- 제목 -->
                   <col width="130" />	<!-- 등록일 -->
                   <col width="100" />	<!-- 작성자 -->
                   <col width="80" />	<!-- 조회수 -->

               </colgroup>
               <thead>
                   <tr>
                   	   <th class="readTimeChkbox" scope="col"><input onclick="contentIdChkAll($(this));" id = "contentIdChkAll" type="checkbox"></th>
                   	   <th scope="col">번호</th>
                   	   <th class="approveEnableArea" scope="col">상태</th>
                   	   <th scope="col">관계사</th>
                       <th scope="col">제목</th>
                       <th scope="col">등록일</th>
                       <th scope="col">작성자</th>
                       <th scope="col">조회수</th>
                   </tr>
               </thead>
               <tbody>
               	<!-- ////////// 내용 위치 ///////// -->
           	   </tbody>
           </table>
		   <div id="detailBoardDiv" style="padding-top:10px;color:red;text-align:right;"></div>
           <!--페이지버튼-->
           <div class="btnPageZoneWrap">
            <div class="btnPageZone" id="btnPageZone">
                <button type="button" class="pre_end_btn"><em>맨처음 페이지</em></button>
                <button type="button" class="pre_btn"><em>이전 페이지</em></button>
                <!-- ////////// 페이지 숫자 버튼 위치 ///////// -->
                <button type="button" class="next_btn"><em>다음 페이지</em></button>
                <button type="button" class="next_end_btn"><em>맨마지막 페이지</em></button>
            </div>
           </div>

           <div class="btn_baordZone">
			<a href="javascript:fnObj.doWriteContent(0)" class="btn_blueblack btn_auth">글쓰기</a>
  		   </div>

	</div>
	<input type="hidden" id = "currentPage" name = "currentPage" value="1">

</section>



<script type="text/javascript">
//Global variables :S ---------------


var curPageNo = 1;		//현재페이지번호
var g_pageSize = 15;	//페이지크기

var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs

var mySearch = new AXSearch(); 	// instance
var myModal = new AXModal();	// instance


var g_groupUid = '${groupUid}';
var g_cboardUid = '${cboardUid}';

var g_cboardId = '';

var g_boardFileYn;
var g_boardReplyYn;
var g_boardNoticeYn;
var g_boardStaffUserId;
var g_boardApproveYn;

var readTimeYn = "N";
//Global variables :E ---------------
/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################
	preloadCode : function(){

	},

	//화면세팅
    pageStart: function(){

    	var configObj = {
    		columnCountForEmpty : 6,
    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [


    		{key:"NO",				formatter:function(obj){
    														  	var dateStr = new Date().yyyy_mm_dd();
    														  	var str ='';
    															if(obj.item.sort == 1 && obj.item.noticeFlag=='Y'){
    																if(obj.item.contentType == 'NOTICE' ||  g_boardNoticeYn == 'Y')
    																str+='<span class="icon_notice"><em>notice</em></span>';
    																else str+=obj.item.contentId;

    															}else{
    																str+= obj.page.listTotalCount - (obj.index+ parseInt(( obj.page.pageNo - 1) * obj.page.pageSize));
    																//str+=obj.item.contentId;
    															}

    															return str ;
    														}},
    		{key:"approveStatus",	formatter:function(obj){

    														  	var str ='';

    														  	if(obj.item.approveStatus == 'TEMP') str = '임시저장';
    														  	else if(obj.item.approveStatus == 'REQUEST') str = '승인요청';
    														  	else if(obj.item.approveStatus == 'APPROVE') str = '승인';
    														  	else if(obj.item.approveStatus == 'REJECT') str = '반송';

    														  	return str ;
    														}},

    		{key:"orgNm"},
            {key:"title", 			formatter:function(obj){
												            	var dateStr = new Date().yyyy_mm_dd();
															  	var str ='';
																/* if(obj.item.sort == 1  && obj.item.noticeFlag=='Y'){
																	if(obj.item.contentType == 'NOTICE' && obj.item.allOrg == 'Y'){
																		str+='<strong class="noti_comname">[' + obj.item.orgNm + ']  </strong>';
																	}
																	str+='<strong>' + devUtil.fn_escapeReplace(obj.value) + '</strong>';
																}else{ */
																	str+= devUtil.fn_escapeReplace(obj.value);
																//}
																if(obj.item.fileCount >0 && (g_boardFileYn == 'Y' || obj.item.contentType == 'NOTICE') ){
																	str+= '<i class="axi axi-attach-file" style="font-size:15px;color:silver;"></i>';
																}

																var newYn = obj.item.newYn;
																if(newYn!=null && newYn =="Y"){
																	str+= '<span class="icon_new"><em>new</em></span>';
																}
																return str;
															}},
            {key:"createBy",		formatter:function(obj){
            												var stStr = "";
            												stStr+="<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+obj.item.createdBy+"\",$(this),\"mouseover\",null,5,-100,100)'>";
            												stStr+= obj.item.createNm;
            												stStr+="</span>";
            												return stStr;
            												}},
            {key:"createdDate",		formatter:function(obj){return obj.value;}},
            {key:"hit"				},

            //데이터만
          	{key:"noticeClassName", formatter:function(obj){ return (obj.item.noticeFlag=='Y' && obj.item.sort == 1 ?'setNotice':''); }},
            {key:"commentCount", 	formatter:function(obj){
            													var str = obj.item.commentCount==0 || g_boardReplyYn == 'N' ? '':'<span class="ripple">(' + obj.item.commentCount + ')</span>';

            													var replyNewYn = obj.item.replyNewYn;
            													var newYn = obj.item.newYn;
																//본글에 달렸는지
            													if((newYn==null || newYn !="Y") && replyNewYn !=null && replyNewYn == "Y"){
																	str+= '<span class="icon_new"><em>new</em></span>';
																}

            													return str;
            												}},
          	{key:"chk",				formatter:function(obj){
				return "<input type = 'checkbox' name = 'contentIdChk' value = '"+obj.item.contentId+"'>";
				}
			}
            ],


            body : {
                onclick: function(obj, e){
                	if(obj.c !=0){
                		fnObj.viewContent(obj.item.contentId,obj.item.groupUid,obj.item.cboardUid,obj.item.cboardId);
                	}

                }
            }
        };


    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */

    	var rowHtmlStr = '<tr class="#[8]">';
    	rowHtmlStr +=	 '<td class="readTimeChkbox">#[9]</td>';

    	rowHtmlStr +=	 '<td class="b_num">#[0]</td>';		//번호
    	rowHtmlStr +=	 '<td class="b_num approveEnableArea">#[1]</td>';		//상태
    	rowHtmlStr +=	 '<td class="b_num">#[2]</td>';		//관계사명
    	rowHtmlStr +=	 '<td class="b_title" style="cursor:pointer;">#[3]#[8]</td>';	//제목
    	rowHtmlStr +=	 '<td class="b_date">#[5]</td>';	//등록일
    	rowHtmlStr +=	 '<td class="b_writer">#[4]</td>';		//등록자
    	rowHtmlStr +=	 '<td class="b_count">#[6]</td>';		//조회수
        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;


    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅

    	//-------------------------- 그리드 설정 :E ----------------------------


    	//-------------------------- 페이징 설정 :S ----------------------------

    	myPaging.setConfig({				//페이징 설정정보 세팅

			targetID		: "btnPageZone",		//대상 페이징 id ... <div>
			pageSize		: g_pageSize,			//global variable value

			preEndBtnClass	: 'pre_end_btn',		//맨처음 페이지 	버튼 클래스명
			preBtnClass		: 'pre_btn',			//이전 페이지		버튼
			nextBtnClass	: 'next_btn',			//다음 페이지		버튼
			nextEndBtnClass	: 'next_end_btn',		//맨마지막 페이지	버튼 클래스명

			curPageNoClass	: 'current',			//현재페이지를 표시해주기위한 style Class name
			clickFnName		: 'fnObj.doSearch'		//페이지 이동 함수명(버튼 클릭)

    	});


    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){
    	var searchKeyword = $("#searchKeyword").val();
    	var searchType = $("#searchType").val();

    	var applyOrgId = '${baseUserLoginInfo.applyOrgId}';

    	if(g_cboardUid == 'improvement'){
	    	var orgId = "${baseUserLoginInfo.orgId}";

	    	if(orgId == "1") applyOrgId = "";
    	}

    	var url = contextRoot + "/board/getBoardContentList.do";
    	var param = {
    			cboardId		: g_cboardId,
    			pageSize		: g_pageSize,
    			pageNo			: page,
    			searchType		: searchType,
    			searchKeyword 	: searchKeyword,
    			noticeYn		: g_boardNoticeYn,
    			noNotice		: (g_cboardUid == 'improvement' ? 'Y' : 'N'),
    			isAuth			: (g_boardStaffUserId == '${baseUserLoginInfo.userId}' ? 'Y' : 'N')
    	};


    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var infoMap = obj.resultObject;
    		var list= infoMap.list;
    		readTimeYn = infoMap.readTimeYn;
    		curPageNo = infoMap.pageNo;		//현재페이지세팅.

    		var pageObj = {						//페이징 데이터
					pageNo 	  : parseInt(curPageNo),
					pageSize  : g_pageSize,
					pageCount : infoMap.pageCount,
					listTotalCount : infoMap.totalCount
				};

    		myPaging.setPaging(pageObj);		//페이징 데이터 세팅	*** 1 ***

    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list,		//그리드 테이터
								page: pageObj	//페이징 데이터
    						});

    		$('#totalCount').text(infoMap.totalCount);

    		$("#contentIdChkAll").prop("checked",false);

    		if(g_groupUid != "notice"||readTimeYn != "Y"){
    			$(".readTimeChkbox").remove();
    		}

    		//
			if(g_boardApproveYn == 'N') $(".approveEnableArea").remove();

    		//유저프로필 이벤트 셋팅
    		initUserProfileEvent();
    	};
    	$("#currentPage").val(page);
    	commonAjax("POST", url, param, callback,false);
    },//end doSearch

    //게시판 정보
    getBoardCateInfo : function(){
    	var url = contextRoot + "/board/getBoardCateList.do";
    	var param = {cboardUid : g_cboardUid, applyOrgId : '${baseUserLoginInfo.applyOrgId}'};
    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var list = obj.resultList;
    		for(var i=0;i<list.length;i++){

    			$("#boardTitle").html(list[i].cboardName);
    			$("#groupName").html(list[i].groupName);
    			$("#cboardName").html(list[i].cboardName);
    			$("#sel_page_size").val(list[i].listCount);

    			g_cboardId=list[i].cboardId;				//게시판 아이디 세팅
    			g_pageSize = list[i].listCount;
    			g_boardFileYn = list[i].fileYn;
    			g_boardReplyYn= list[i].replyYn;
    			g_boardNoticeYn= list[i].noticeYn;
				g_boardStaffUserId = list[i].staffUserId;

				g_boardApproveYn = list[i].approveYn;
    			/* var str ='헤드라인 기능:'+(g_boardNoticeYn =='Y' ? 'O' : 'X');
    			str +=' , 파일첨부 기능:'+(g_boardFileYn =='Y' ? 'O' : 'X');
    			str +=' , 댓글 기능:'+(g_boardReplyYn =='Y' ? 'O' : 'X');

    			$("#detailBoardDiv").html(str); */
    		}
    	};

		commonAjax("POST", url, param, callback, false);
    },

  	// 글보기
    viewContent : function(contentId,groupUid,cboardUid,cboardId){

    	//조회수 올리고
    	var url = contextRoot + "/board/boardViewCount.do";
    	var param = {contentId : contentId};

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;		//결과수
    		if(cnt>0){

	    		//fnObj.doSearch(curPageNo);
	    		location.href = '${pageContext.request.contextPath}/board/boardContentView/'+groupUid+'/'+cboardUid+'.do?cboardId=' + cboardId + '&contentId=' + contentId;
	        	//var option = "left=" + (screen.width > 1400?"500":"0") + ", top=" + (screen.height > 810?"80":"0") + ", width=1000, height=860, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
	        	//window.open(url, "", option);
    		}else{
    			alert("게시글 조회에 실패하였습니다.");
    			return;
    		}

    	};

		commonAjax("POST", url, param, callback, false);
    },//end viewContent

 	// 글쓰기
    doWriteContent : function(contentId){

    	location.href = '${pageContext.request.contextPath}/board/boardContentWrite/'+g_groupUid+'/'+g_cboardUid+'.do?cboardId=' + g_cboardId + '&contentId=' + contentId;
    	//var option = "left=" + (screen.width > 1400?"500":"0") + ", top=" + (screen.height > 810?"80":"0") + ", width=1000, height=860, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	//window.open(url, "", option);

    },//end doWriteContent

    //페이지 사이즈 세팅
    setPageSize: function(isSearch){

    	g_pageSize = $('#sel_page_size').val();

    	//검색도 바로할 경우 ... isSearch ... true
		if(isSearch){
			fnObj.doSearch(1);
    	}
    },

  	//################# else function :E #################

};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();
	fnObj.getBoardCateInfo();		//게시판 카테고리 정보
	fnObj.setPageSize();
	fnObj.pageStart();				//화면세팅
	fnObj.doSearch(1);				//검색

	//유저프로필 이벤트 셋팅
	initUserProfileEvent();
});
//체크박스 전체 선택/해재
function contentIdChkAll($obj){
	var isChk = $obj.prop("checked");

	$("input[name = 'contentIdChk']").each(function(){
		$(this).prop("checked",isChk);
	})
}
//체크박스 읽음 처리
function readChkAll(){
	var url = contextRoot + "/board/processReadContentList.do";

	var chkContentId =[];

	$("input[name = 'contentIdChk']:checked").each(function(){
		chkContentId.push($(this).val());
	});
	if(chkContentId.length<1){
		alert("읽음 처리할 게시글을 선택해 주세요.");
		return;
	}

	var param = {
		chkContentId:JSON.stringify(chkContentId)
	};

	var callback = function(result){
		fnObj.doSearch($("#currentPage").val());
	}
	commonAjax("POST", url, param, callback, false);
}
</script>