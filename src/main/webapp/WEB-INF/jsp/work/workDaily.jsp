<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>

<style>

.first_contact_from {
    background: url(../images/work/icon_recive2.gif) no-repeat left center;
    position: absolute;
    left: 3px;
    top: 3px\0/IE8+9;
    padding-left: 15px;
    font-size: 11px;
    font-weight: bold;
    font-family: "돋움";
    color: #252525;
    display: inline-block;
    height: 12px;

}

.first_contact_to {
    background: url(../images/work/icon_send2.gif) no-repeat left center;
    position: absolute;
    left: 3px;
    top: 3px\0/IE8+9;
    padding-left: 15px;
    font-size: 11px;
    font-weight: bold;
    font-family: "돋움";
    color: #252525;
    display: inline-block;
    height: 12px;

}
.helperArea .divide_line { height:3px; background:#e3e5ea; padding: 0 0 0 0; overflow:hidden; margin-top:10px; }
.helperArea .divide_line:hover { outline:none; }
.helperArea + .todo_list { border-top:#b9c1ce dashed 1px; margin-bottom:11px; margin-top:0px; }
.helperArea { padding:10px 12px 12px 12px;}
.helperArea li { width:100%; float:none; *zoom:1; padding:3px 3px 3px 25px; box-sizing:border-box; line-height:14px; vertical-align:middle; list-style:none;}
.helperArea li:hover { outline:#b9c1ce dashed 1px; }
.helperArea li:after { content:""; display:block; clear:both; height:0; }
.helperArea .fl_block { float:left; width:88%; vertical-align:middle; }
.helperArea .fl_block input  { /*margin-left:-18px; margin-right:4px; vertical-align:middle; line-height:14px;*/ }
.helperArea .fr_block { float:right; }
.helperArea .fr_block .state_txt { color:#a6adb3; text-align:right; }
.helperArea .fr_block .state_date { color:#e8702e; text-align:right; font-size:11px; font-family:Tahoma, Geneva, sans-serif; }
.helperArea li:hover .btn_modify_con, .todo_list li:hover .btn_delete_con { display:inline-block; }
.helperArea .con_txt { padding:0 2px; }
.helperArea .con_txt .time { margin-right:12px; font-size:11px; font-family:Tahoma, Geneva, sans-serif; vertical-align:middle; line-height:14px; font-style:oblique; color:#738491; }
.helperArea .ck_finish .time { color:#abb3ba!important; }
.helperArea .manager { margin-left:8px; color:#4597e4; font-size:11px; background:url(../images/work/bg_manager.gif) no-repeat left center; vertical-align:middle; line-height:14px; padding-left:8px; display:inline-block; letter-spacing:-1px; }
.helperArea li:first-child .btn_work_add { margin-top:0px; margin-bottom:30px; }
.helperArea li:first-child .btn_schedule_add { margin-top:0px; margin-bottom:30px; }

.no_read_exist{
	border-top:#b9c1ce dashed 1px;
}

.fold_down {
    background: url(../images/system/sys_tb_open.png) no-repeat;
    width: 60px;
    height: 21px;
}
.fold_up {
    background: url(../images/system/sys_tb_close.png) no-repeat;
    width: 83px;
    height: 21px;
}
</style>

<!--  정보 공유 창 띄우기 위해 필요 -->
<form name="frm" id="frm" method="post">
    <input type="hidden" name="targetOrgId" id="targetOrgId">
    <input type="hidden" name="targetDate" id="targetDate">
    <input type="hidden" name="infoId" id="infoId">
</form>


<div class="verticalWrap">
	<div class="addAreaZone">
		<div id="userListAreaTree">
		</div>
	</div>

	<section id="detail_contents">


		<!--업무일지-->
		<div class="carSearchBox">
			<span class="carSearchtitle"><label for="choiceYear">년도선택</label></span>
			<span id="yearArea"></span>
			<span id="monthArea" class="btn_monthZone mgl10"></span>
		</div>
		<!--업무일지_기간검색-->
        <div class="wd_search_set mgt20">
            <div class="leftblock"><span class="stitle">검색기간 : </span>
            <input type="text"  id="searchStartDate" name="searchStartDate" value="" class="input_b input_date_type" title="시작일"  readonly="readonly"><!-- <a href="#" class="icon_calendar"><em>날짜선택</em></a> -->
            <span class="dashLine">~</span>
            <input type="text" id="searchEndDate" name="searchEndDate" value="" class="input_b input_date_type" title="종료일"  readonly="readonly"><!-- <a href="#" class="icon_calendar"><em>날짜선택</em></a>  -->
            <span class="fontGray f11 mgl5">(검색기간 최대 6개월)</span></div>
            <div class="rightblock">
                <span class="stitle">범위 : </span>
                <span class="vmbox">
                    <label><input type="checkbox"  id="searchDailyTypeWork" name="searchDailyTypeWork"  value="WORK" checked/><span class="mgr10">업무일지</span></label>
                    <label><input type="checkbox" id="searchDailyTypeSales" name="searchDailyTypeSales"  value="SALES" checked/><span class="mgr10">영업정보</span></label>
                    <label><input type="checkbox" id="searchDailyTypeMemo" name="searchDailyTypeMemo"  value="MEMO" checked/><span>업무메모</span></label>
                </span>
                <input type="text" class="input_b" title="검색어 입력"  placeholder="검색어 입력"  id="searchKeyword" name="searchKeyword"  onkeypress="if(event.keyCode==13) {fnObj.doSearchByKeyword(); return false;}"  value="" />
                <a href="javascript:fnObj.doSearchByKeyword();" class="btn_wh_bevel">검색</a>
                <button type="button" class="btn_s_replay" onclick="fnObj.doResetByKeyword('KEYWORD');"><em>검색초기화</em></button>
            </div>
        </div>
		<!--//업무일지(월별검색)//-->
		<h3 class="h3_table_title mgt20"><span id="dateArea"></span></h3>
		<div id="oneday_wrap">
			<span class="scroll_cover" onclick="javascript:setdayFull('oneday_conBox');"><em>전체열기</em></span>
			<div class="oneday_header">
				<table class="calander_oneday_st">
					<colgroup>
						<col width="80" />
						<col width="32%" />
						<col width="*" />
						<col width="32%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="row">구분</th>
							<th scope="col" class="titleZone"><span class="title">업무일지</span><span id="workTitleArea" class="destxt">TO DO LIST</span></th>
							<th scope="col" class="titleZone"><span class="title">영업정보</span><span id="salesTitleArea" class="destxt">BUSINESS INFO</span></th>
							<th scope="col" class="titleZone"><span class="title">업무메모</span><span id="memoTitleArea" class="destxt">MEMO LIST</span></th>
						</tr>
					</thead>

				</table>
			</div>
			<div class="oneday_conBox" style="overflow-x:hidden!important">

				<table class="calander_oneday_st" id="SGridTarget">
					<colgroup>
						<col width="80" />
						<col width="32%" />
						<col width="*" />
						<col width="32%" />
					</colgroup>
					<tbody>
					</tbody>
				</table>
				<div class = "helperArea" style="padding: 0px;">
					<div id = "helperArea">

					</div>
				</div>
			</div>
		</div>

	</section>
</div>

<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript">
function setdayFull(knd){
	var h = '';
	if(knd == 'week_allday')
		h = '99px';
	else
		h = '600px';

	if($('.'+knd).css('max-height') == h)
		$('.'+knd).css('max-height','none');
	else
		$('.'+knd).css('max-height', h);
}
//Global variables :S ---------------

//공통코드

var myModal = new AXModal();		// instance

var myGrid1 = new SGrid();		// instance		new sjs
var myGrid = new SGrid();		// instance		new sjs
var myPaging = new SPaging();	// instance		new sjs
//var mySorting = new SSorting();	// instance		new sjs

var myUserTree = new UserTree(); 	//UserTree 객체생성

var loginUserId = '${baseUserLoginInfo.userId}';
var loginUserEmpNo = '${baseUserLoginInfo.empNo}';
var g_applyOrgId ='${baseUserLoginInfo.applyOrgId}';

var g_workUserId = '';
var g_year ='';
var g_month ='';
var g_searchActionType = "MONTH";

var g_selectDate =('${selectDate}' =='' ? new Date().yyyy_mm_dd() : '${selectDate}');

var g_chkbox_seq = 0;			//체크박스 유니크 id 추가를 위한 변수

var g_noReadAllYn = 'N';		//미열람메모/고정메모 전체보기 상태 ... 'Y':전체보기, 'N':일부보기

//메모팝업 위치관련 변수 :S
var memoPopupCnt = 0;
var memoPopupWidth = (window.screenX || window.screenLeft || 0)+50;
var memoPopupHegit = (window.screenY || window.screenTop || 0)+50;
//메모팝업 위치관련 변수 :E
//Global variables :E ---------------

//업무 드래그 이동/복사에 필요한 파라미터
var listId = "";

var targetTdId = "";

var dialogChk = true;

var isWorkDailyPage = true;
//
/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//선로딩코드
	preloadCode : function(){
		/* $('#searchStartDate').datepicker('setDate', new Date().yyyy_mm_dd());
		$('#searchEndDate').datepicker('setDate', new Date().yyyy_mm_dd()); */

		$('#searchStartDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
        $('#searchEndDate').datepicker(E_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});

        var nowDate = new Date();
        var firstDate = new Date(nowDate.getFullYear(),nowDate.getMonth(),1);
        var lastDate = new Date(nowDate.getFullYear(),nowDate.getMonth()+1,0);

        var nowDate6 = new Date(nowDate.getFullYear(),nowDate.getMonth(),1);
        nowDate6.setMonth(nowDate6.getMonth() + 6);

        $('#searchStartDate').val(getDateFormat(firstDate));
        $('#searchEndDate').val(getDateFormat(lastDate));


	},

	//화면세팅
	defaultPageStart : function() {

		fnObj.setYear();
		fnObj.setMonth();


		//-------------------------- 그리드 설정 :S ----------------------------
		/* 그리드 설정정보 */
		var configObj = {


			targetID : "SGridTarget", //테이블아이디


			//그리드 컬럼 정보
			colGroup : [
			{key : "date"	   , formatter : function(obj) { 		//날짜
									var str = obj.item;
									var dateArr =str.split('-');
									var txtColor ='';

									var weekName = getWeekName(dateArr[0],dateArr[1],dateArr[2]);
									var nowDate = new Date(dateArr[0],dateArr[1]-1,dateArr[2]);

									//요일번호
									var selDay = new Date(dateArr[0],dateArr[1]-1,dateArr[2]);
									var dayName = selDay.getDay();

									if(dayName == 6){
										txtColor ='df_saturday';
									}else if(dayName == 0){
										txtColor ='df_sunday';
									}
									//var str = ;
									return '<p class="'+txtColor+' " id=date_'+dateArr[2]+'><strong>'+dateArr[1]+'/'+dateArr[2]+'</strong><em>('+weekName+')</em></p>';
								}},
			{key : ""		  	},
			{key : ""			},		//정보공유

			{key : ""			},
			{key : ""			, formatter : function(obj) { //날짜 tr 아이디값
										return obj.item;
			}}
			],
			body : {
				onclick : function(obj, e) {

				}
			}

		};

		/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
		var rowHtmlStr = '<tr id="tr_#[4]">';
		rowHtmlStr += '<th>#[0]</th>';
		rowHtmlStr += '<td class="conrelative">#[1]</td>';
		rowHtmlStr += '<td class="conrelative">#[2]</td>';
		rowHtmlStr += '<td class="conrelative">#[3]</td>';
		rowHtmlStr += '</tr>';
		configObj.rowHtmlStr = rowHtmlStr;
		myGrid1.setConfig(configObj);

		//-------------------------- 그리드 설정 :E ----------------------------

	},//end defaultPageStart.

	//화면세팅
	pageStart : function() {

		fnObj.setYear();
		fnObj.setMonth();


		//-------------------------- 그리드 설정 :S ----------------------------
		/* 그리드 설정정보 */
		var configObj = {


			targetID : "SGridTarget", //테이블아이디


			//그리드 컬럼 정보
			colGroup : [

			{key : "date"	   , formatter : function(obj) { 		//날짜
									var str = obj.item;
									var dateArr =str.split('-');
									var txtColor ='';
									var holiType ='';
									var holidayList = obj.etc.holidayList;
									var weekName = getWeekName(dateArr[0],dateArr[1],dateArr[2]);
									var nowDate = new Date(dateArr[0],dateArr[1]-1,dateArr[2]);
									var holType ='';
									var holiStr = '';

									if(g_searchActionType == "KEYWORD"){  // 검색영역
										var str = '<p class="monthdate_id"><strong>'+obj.item+'</strong></p>';
										return str;
									}else if(g_searchActionType == "MONTH"){  //월별검색
										holiStr +='<div class="explain_tooltip mgt5">';
	                                    holiStr +='<div class="spe_datetxt">';
	                                    for(var i=0; i<holidayList.length; i++){

	                                        if(holidayList[i].sysDate == obj.item){
	                                            holType = holidayList[i].holType;
	                                            txtColor ='df_holiday';

	                                            //-- 법정 공휴일
	                                            if(holidayList[i].nationalHol == 'Y'){
	                                                //토일
	                                                if(holType != null) holiStr +='<span>'+holType+'</span>';
	                                                //토일 이외의 법정공휴일
	                                                if(holidayList[i].nationalHolType != '') holiStr +='<span class="common" style="width:100%;display:inline-block;">'+holidayList[i].nationalHolType+'</span>';

	                                            }
	                                            //-- 재량휴일
	                                            if(holidayList[i].formalHol == 'Y'){
	                                                holiStr +='<span class="common" style="width:100%;display:inline-block;">'+holidayList[i].formalHolType+'</span>';
	                                            }
	                                        }
	                                    }

	                                    holiStr +='</div>';
	                                    holiStr +='</div>';

	                                    var dayName = nowDate.getDay();

	                                    if(dayName == 6){
	                                        txtColor ='df_saturday';
	                                    }else if(dayName == 0){
	                                        txtColor ='df_sunday';
	                                    }

	                                    //var str = '<span style="'+txtColor+'" id=date_'+dateArr[2]+'>'+dateArr[1]+'/'+dateArr[2]+'<em>('+weekName+')</em></span>';
	                                    var str = '<p class="'+txtColor+'" id=date_'+dateArr[2]+'><strong>'+dateArr[1]+'/'+dateArr[2]+'</strong><em>('+weekName+')</em></p>';

	                                    str+=holiStr;

	                                    if(obj.item == new Date().yyyy_mm_dd()){
	                                        str +='<div class="vm_typho mgt10"><input type="checkbox" checked="checked" class="b_chst" id="stas1" onclick="fnObj.displayTeamWork();"/><label for="stas1">팀업무</label></div>';

	                                    }
	                                    str +='';

	                                    return str;
									}


			}},	//날짜 요일 표시

			{key : "idx1"	, formatter : function(obj) { 							//업무 일지

									var workDailyList = obj.etc.personalWorkDailyList;
									var existCount =0;
									/*================================ 개인 업무일지 : S ================================*/
									var str = '<ul class="todo_list ';
									if(g_searchActionType == "KEYWORD"){  // 검색영역
										str+=' result">'
									}else if(g_searchActionType == "MONTH"){  //월별검색
										//본인일때만 개인업무 복사,이동
	                                    if(g_workUserId == loginUserId){
	                                        str+=' darggableUl">'
	                                    }else str+='" style="display: list-item;">';
									}


									for(var i=0; i<workDailyList.length; i++){
										var dailyWorkDate = "";
										if(g_searchActionType == "KEYWORD"){  // 검색영역
											dailyWorkDate = workDailyList[i].workMonth;
										}else if(g_searchActionType == "MONTH"){  //월별검색
											dailyWorkDate = workDailyList[i].workDate;
										}

										if(obj.item == dailyWorkDate){ 			//해당 날짜의 업무일지일때,

											var workDailyCss = workDailyList[i].workType == "PRIVATE"?"darggableLi":"nonDraggable";
											if(g_searchActionType == "KEYWORD"){  // 검색영역
												workDailyCss = "nonDraggable";
											}

											existCount++;

											str+='<li class="'+workDailyCss+' " ';
											if(workDailyCss!="") str+= 'id = "workDailyLi_'+workDailyList[i].listId+'"';
											str+='>';

											if(g_searchActionType == "KEYWORD"){  // 검색영역
												str+='<span class="wd_re_Date">'+workDailyList[i].workDay+'<em>('+workDailyList[i].workDateWeek+')</em></span>';
                                            }

											str+='<span class="fl_block" id = "draggableSpantag_'+workDailyList[i].listId+'">';

											str+='<input type="checkbox" class="chst" id="unique_checkbox' + (++g_chkbox_seq) + '" ';

											if(workDailyList[i].createdBy == loginUserId && g_workUserId == loginUserId){	//본일일때만체크박스 생성
													str +='onclick="fnObj.endWorkDaily(\''+workDailyList[i].listId+'\',\''+workDailyList[i].complete+'\',\''+workDailyList[i].progress+'\',\''+obj.item+'\');"';
											}else{
												str+=' disabled="disabled" ';
											}

											if(workDailyList[i].complete == 'Y'){	//완료일정일때 체크
												str+=' checked="checked" ';
											}

											str+='title="업무종료 체크"/><label for="unique_checkbox' + g_chkbox_seq + '"><em class="hidden">오늘할일체크</em></label>';


											str+='<a href="javascript:fnObj.viewWorkDaily('+workDailyList[i].listId+',\''+workDailyList[i].workType+'\',\''+obj.item+'\',\'VIEW\');" class="con_txt ' ;


											if(workDailyList[i].complete == 'Y'){		//완료일정일때 해당일정 줄긋기
												str+='ck_finish';
											}
											str+='" id = "draggableAtag_'+workDailyList[i].listId+'">';

											str+='<span class="icon_important_L'+workDailyList[i].important+'"></span>';



											if(g_searchActionType == "KEYWORD") str+= replaceAll(devUtil.fn_escapeReplace(workDailyList[i].title), $("#searchKeyword").val().trim(),'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
											else str+= devUtil.fn_escapeReplace(workDailyList[i].title);

											str+='</a>';

											if(g_workUserId == loginUserId && workDailyList[i].createdBy == loginUserId){	//내가 내 화면 볼때 and 오늘 등록일정만 버튼

												str+='<a href="javascript:fnObj.openWorkDaily('+workDailyList[i].listId+',\''+obj.item+'\',\'EDIT\');" class="btn_modify_con"><em>수정</em></a>';


												if(workDailyList[i].createdBy == loginUserId)	//내가 내글 일때만 삭제 처리(팀 업무 때문에 팀업무는 팀리더만 삭제가능)
												str+='<a href="javascript:fnObj.deleteWorkDaily('+workDailyList[i].listId+',\''+workDailyList[i].workType+'\')" class="btn_delete_con"><em>삭제</em></a>';
											}

											str+='</span>';

											str+='<span class="fr_block">';
											str+='<em class="state_txt">'+workDailyList[i].progressTxt+'</em>';
											str+='</span></li>';
										}

									}

									/*================================개인 업무일지 : E ================================*/


									/*================================ 일정 : S ===================================*/
									var scheList = obj.etc.scheList;

									for(var i=0; i<scheList.length; i++){
										var viewDate = "";
                                        if(g_searchActionType == "KEYWORD"){  // 검색영역
                                        	viewDate = scheList[i].viewMonth;
                                        }else if(g_searchActionType == "MONTH"){  //월별검색
                                        	viewDate = scheList[i].viewDate;
                                        }


										if(obj.item == viewDate){				//scheList[i].scheSDate){ 			//해당 날짜의 업무일지일때,
											existCount++;

											str += '<li class = "notDraggable">';

											if(g_searchActionType == "KEYWORD"){  // 검색영역
                                                str+='<span class="wd_re_Date">'+scheList[i].viewDay+'<em>('+scheList[i].viewDateWeek+')</em></span>';
                                            }

											str += '<span class="fl_block">';

											str+='<input type="checkbox" class="chst" id="unique_checkbox' + (++g_chkbox_seq) + '" ';

											if(scheList[i].perSabun == loginUserEmpNo && g_workUserId == loginUserId){	//본인일정일때만 체크박스 생성
												str +='onclick="fnObj.chkSchedule(\''+scheList[i].scheSeq+'\',\''+scheList[i].scheChkFlag+'\');"';
											}else{
												str+=' disabled="disabled" ';
											}

											if(scheList[i].scheChkFlag == 'Y'){	//완료일정일때 체크
												str+=' checked="checked" ';
											}


											str+='title="업무종료 체크"/><label for="unique_checkbox' + g_chkbox_seq + '"><em class="hidden">오늘할일체크</em></label>';


											str += '<a href="javascript:fnObj.viewSchedule('+scheList[i].scheSeq+');" class="con_txt ' ;

											if(scheList[i].scheChkFlag == 'Y'){		//완료일정일때 해당일정 줄긋기
												str+='ck_finish';
											}
											str+='">';

											var scheTitle = "";
											var activityNm = "";

											if(g_searchActionType == "KEYWORD") scheTitle = replaceAll(scheList[i].scheTitle, $("#searchKeyword").val().trim(),'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
                                            else scheTitle = scheList[i].scheTitle;

											if(g_searchActionType == "KEYWORD") activityNm = replaceAll(devUtil.fn_escapeReplace(scheList[i].activityNm), $("#searchKeyword").val().trim(),'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
                                            else activityNm = devUtil.fn_escapeReplace(scheList[i].activityNm);


											scheTitle = devUtil.fn_escapeReplace(scheTitle);

											if(scheList[i].scheAllTime=='Y'){		//종일일정 이면
												str += '[' + activityNm + ']' + scheTitle + '</a>';
											}else{
												str += '<span class="time">' + scheList[i].scheSTime + '</span>' + '[' + activityNm + ']' + scheTitle + '</a>';
											}

											/* if(g_workUserId == loginUserId && scheList[i].regPerSabun == loginUserEmpNo){	//내가 내 화면 볼때 and 내가 등록한 일정만 버튼

												str2+='<a href="javascript:fnObj.viewSchedule('+scheList[i].scheSeq+');" class="btn_modify_con"><em>수정</em></a>';

												//if(workDailyList[i].createdBy == loginUserId)	//내가 내글 일때만 삭제 처리(팀 업무 때문에 팀업무는 팀리더만 삭제가능)
												str2+='<a href="javascript:fnObj.deleteSchedule('+scheList[i].scheSeq+')" class="btn_delete_con"><em>삭제</em></a>';
											} */

											str+='</span>';

											str+='<span class="fr_block"><em class="state_txt">' + (scheList[i].scheChkFlag=='Y'?'완료':(scheList[i].scheSDate>new Date().yyyy_mm_dd() && obj.item>new Date().yyyy_mm_dd()?'계획':'진행')) + '</em></span></li>';

										}
									}

									/*================================ 일정 : E ===================================*/

									str += '</ul>';

									//if(existCount == 0) str='';

									/*================================ 팀 업무일지 : S ================================*/
									var teamWorkDailyList = obj.etc.teamWorkDailyList;
									var str2 = '';
									if(g_searchActionType == "KEYWORD"){  // 검색영역
										str2 = '<ul class="todo_list result">';
									}else if(g_searchActionType == "MONTH"){  //월별검색
										str2 = '<ul class="todo_list teamArea">';
									}

									existCount = 0;

									for(var i=0; i<teamWorkDailyList.length; i++){
                                        var teamWorkDate = "";
                                        if(g_searchActionType == "KEYWORD"){  // 검색영역
                                            teamWorkDate = teamWorkDailyList[i].workMonth;
                                        }else if(g_searchActionType == "MONTH"){  //월별검색
                                            teamWorkDate = teamWorkDailyList[i].workDate;
                                        }

										if(obj.item == teamWorkDate){ 			//해당 날짜의 업무일지일때,
											existCount++; //팀업무 갯수 카운트

											str2+='<li class="'+(teamWorkDailyList[i].dailyType == 'BEFORE' ? 'beforeArea' : '')+'">';

											if(g_searchActionType == "KEYWORD"){  // 검색영역
												str2+='<span class="wd_re_Date">'+teamWorkDailyList[i].workDay+'<em>('+teamWorkDailyList[i].workDateWeek+')</em></span>';
                                            }

											str2+='<span class="fl_block">';

											str2+='<input type="checkbox" class="chst" id="unique_checkbox' + (++g_chkbox_seq) + '" ';

											if(teamWorkDailyList[i].createdBy == loginUserId && g_workUserId == loginUserId){	//본일일때만체크박스 생성
												str2 +='onclick="fnObj.endWorkDaily(\''+teamWorkDailyList[i].listId+'\',\''+teamWorkDailyList[i].complete+'\',\''+teamWorkDailyList[i].progress+'\',\''+obj.item+'\');"';
											}else{
												str2+=' disabled="disabled" ';
											}

											if(teamWorkDailyList[i].complete == 'Y'){	//완료일정일때 체크
												str2+=' checked="checked" ';
											}

											str2+='title="업무종료 체크"/><label for="unique_checkbox' + g_chkbox_seq + '"><em class="hidden">오늘할일체크</em></label>';


											str2+='<a href="javascript:fnObj.viewWorkDaily('+teamWorkDailyList[i].listId+',\''+teamWorkDailyList[i].workType+'\',\''+obj.item+'\',\'VIEW\');" class="con_txt ' ;


											if(teamWorkDailyList[i].complete == 'Y'){	//완료일정일때 해당일정 줄긋기
												str2+='ck_finish';
											}
											str2+='">';
											str2+='<span class="icon_teamwork"></span>';
											str2+='<span class="icon_important_L'+teamWorkDailyList[i].important+'"></span>';

											if(g_searchActionType == "KEYWORD") str2+= replaceAll(devUtil.fn_escapeReplace(teamWorkDailyList[i].title), $("#searchKeyword").val().trim(),'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
                                            else str2+= devUtil.fn_escapeReplace(teamWorkDailyList[i].title);

											str2+='</a>';

											if(g_workUserId == loginUserId && teamWorkDailyList[i].createdBy == loginUserId){	//내가 내 화면 볼때 and 오늘 등록일정만 버튼

												str2+='<a href="javascript:fnObj.viewWorkDaily('+teamWorkDailyList[i].listId+',\''+teamWorkDailyList[i].workType+'\',\''+obj.item+'\',\'EDIT\');" class="btn_modify_con"><em>수정</em></a>';
												/* 	팀업무는 삭제 불가처리 20170413
												if(teamWorkDailyList[i].createdBy == loginUserId)	//내가 내글 일때만 삭제 처리(팀 업무 때문에 팀업무는 팀리더만 삭제가능)
													str2+='<a href="javascript:fnObj.deleteWorkDaily('+teamWorkDailyList[i].listId+',\''+teamWorkDailyList[i].workType+'\')" class="btn_delete_con"><em>삭제</em></a>';
												 */
											}

											str2+='</span>';


											str2+='<span class="fr_block">';

											if(teamWorkDailyList[i].dailyType == 'BEFORE'){
												str2+='<em class="state_date">'+(teamWorkDailyList[i].workDayCount >0 ? '+' : '-')+teamWorkDailyList[i].workDayCount+'</em>';
											}else{
												str2+='<em class="state_txt">'+teamWorkDailyList[i].progressTxt+'</em>';
											}


											str2+='</span></li>';
										}

									}

									str2+='</ul>';

									if(existCount ==0 ) str2='';

									/*================================ 팀 업무일지 : E ================================*/


									if(loginUserId == g_workUserId && g_searchActionType == "MONTH"){
										str2+= '<div class="btn_addworkZone">';
										// 2016.12.29. 이인희 업무일지사용 사용여부가 'N'이면 업무등록 불가함
										if("${baseUserLoginInfo.worklistYn}" != "N"){
											str2+= '<button type="button" class="btn_addworkdairy2 btn_auth" onClick="javascript:fnObj.openWorkDaily(0,\''+obj.item+'\');"><em>업무등록</em></button>';
										}

										str2+= '<button type="button" class="btn_addworkdairy3 btn_auth" onClick="javascript:fnObj.addSchedule(\'' + obj.item + '\')"><em>일정등록</em></button>';
										str2+= '</div>';
									}


									return str + str2;
			}},	//업무일지

			{key : "idx2"	 , formatter : function(obj){	//정보공유
									var businessDailyList = obj.etc.businessDailyList;

									var str ='';
									if(g_searchActionType == "KEYWORD"){  // 검색영역
										str = '<ul class="share_info_list result">';
                                    }else if(g_searchActionType == "MONTH"){  //월별검색
                                    	str = '<ul class="share_info_list teamArea">';
                                    }

									for(var i = 0 ; i < businessDailyList.length ;i++){
										var viewDate = "";
                                        if(g_searchActionType == "KEYWORD"){  // 검색영역
                                            viewDate = businessDailyList[i].viewMonth;
                                        }else if(g_searchActionType == "MONTH"){  //월별검색
                                            viewDate = businessDailyList[i].viewDate;
                                        }
										if(obj.item == viewDate){

											str += "<li><div class='fl_block'>";
											str += "<a href='#' onclick='fnObj.openDetailWindow("+businessDailyList[i].infoId+");'>";

											if(g_searchActionType == "KEYWORD"){  // 검색영역
                                                str+='<span class="wd_re_Date">'+businessDailyList[i].viewDay+'<em>('+businessDailyList[i].viewDateWeek+')</em></span>';
                                            }

											var pathMeaningKOR = "";
											var typeMeaningKOR = "";
											var typeSubMeaningKOR = "";

                                            if(businessDailyList[i].pathMeaningKOR != null && g_searchActionType == "KEYWORD") pathMeaningKOR = replaceAll(devUtil.fn_escapeReplace(businessDailyList[i].pathMeaningKOR),$("#searchKeyword").val().trim() ,'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
                                            else pathMeaningKOR = devUtil.fn_escapeReplace(businessDailyList[i].pathMeaningKOR);

                                            if(businessDailyList[i].typeMeaningKOR != null && g_searchActionType == "KEYWORD") typeMeaningKOR = replaceAll(devUtil.fn_escapeReplace(businessDailyList[i].typeMeaningKOR),$("#searchKeyword").val().trim() ,'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
                                            else typeMeaningKOR = devUtil.fn_escapeReplace(businessDailyList[i].typeMeaningKOR);

                                            if(businessDailyList[i].typeSubMeaningKOR != null && g_searchActionType == "KEYWORD") typeSubMeaningKOR = replaceAll(devUtil.fn_escapeReplace(businessDailyList[i].typeSubMeaningKOR),$("#searchKeyword").val().trim() ,'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
                                            else typeSubMeaningKOR = devUtil.fn_escapeReplace(businessDailyList[i].typeSubMeaningKOR);

											str += "<span class='info_type_cway'>"+pathMeaningKOR+ "</span>";
											str += "<span class='info_type_c1'>"+typeMeaningKOR+ "</span>";
											str += "<span class='info_type_c2'>"+typeSubMeaningKOR + "</span>";

											var cpnName1 = "";
											if(businessDailyList[i].cpnName1 != null && g_searchActionType == "KEYWORD") cpnName1 = replaceAll(businessDailyList[i].cpnName1,$("#searchKeyword").val().trim() ,'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
											else cpnName1 = businessDailyList[i].cpnName1;

											//var
											str += "<span>"+cpnName1+ "</span></a>";

											str += " <span class='icon_comment'>("+ businessDailyList[i].cnt +")</span>";
											if(businessDailyList[i].newYn == 'NEW'){
												str += "<span class='icon_new'><em>new</em></span>";
											}
											str+="</div>";
											//str+="<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+businessDailyList[i].createdBy+"\",$(this),\"mouseover\",null,5,-100,100)'>";
											str += "<div class='fr_block'>"+ businessDailyList[i].userName+"</div>";
											//str += "</span>";
											str +="</li>"
										}
									}

									if(g_searchActionType == "MONTH"){  //월별검색
										//if("${baseUserLoginInfo.orgId}" == obj.etc.businessOrgId){  나랑 같은 orgId에 속한 사람 것만 작성이 가능
	                                    //로그인 유저만 작성할 수 있도록
	                                    if(loginUserId == g_workUserId){
	                                        if(obj.etc.businessOrgInfoYn == null){
	                                            str+= '<button type="button" class="btn_addbusiness btn_auth" onClick="javascript:alertM(\'정보등록을 위한 기본 정보가 등록 되어있지 않습니다.\');"><em>정보 등록</em></button>';
	                                        }else if('${isBusinessInfoList}' == 'N'){
	                                            //업무일지 > 정보등록(영업정보)시 권한체크 임시로직, 차후삭제 필요 2017.04.13. 이인희
	                                            str+= '<button type="button" class="btn_addbusiness btn_auth" onClick="javascript:alertM(\'영업정보입력 권한이 없습니다.\');"><em>정보 등록</em></button>';
	                                        }else
	                                            str+= '<button type="button" class="btn_addbusiness btn_auth" onClick="javascript:fnObj.openInfoWindow(\''+obj.etc.businessOrgId  +'\',\''+obj.item+'\');"><em>정보 등록</em></button>';
	                                    }
									}
									return str;
			}},		//정보공유

			{key : "idx3"		,formatter : function(obj) { 		//메모(업무보고)
										var str ='';

										//읽지 않은 이전 업무보고:S
										var memoListNoRead = obj.etc.memoListNoRead;
										if(obj.item == new Date().yyyy_mm_dd() && memoListNoRead.length > 0){

											str +='<div style="display:inline-block;width:100%;font-weight:bold;padding: 10px 30px 0px 10px;color:silver;">미열람메모/고정메모 <span style="display:inline-block;width:50%;text-align:right;">전체 ' + memoListNoRead.length + ' 건</span></div>';

											str +='<div class="no_read_list" style="overflow:hidden;text-overflow:ellipsis;"><ul class="memo_list">';

											for(var i=0; i<memoListNoRead.length; i++){
												str +='<li style="cursor:pointer;padding: 3px 28px 3px 20px;" onclick="javascript:fnObj.openMemo('+memoListNoRead[i].memoRoomId+', \'\', \'' + memoListNoRead[i].viewDate + '\');">';

													str +='<span class="';

													if(memoListNoRead[i].createdBy == '${baseUserLoginInfo.userId}' ){	//발신일때

														str +='first_contact_to">';		//안읽었을떄 아이콘

													}else{														//수신일때

														str +='first_contact_from">';	//안읽었을떄 아이콘

													}

													str+='</span>';

												str +='<div class="fl_block" style="width:60%;">';
												str +='<a>';


												if(memoListNoRead[i].important>0){									//중요도
													str +='<span class="icon_important_L'+memoListNoRead[i].important+'"><em>!!!</em></span> ';
												}

												if(memoListNoRead[i].roomType == 'S'){								//비밀글
													str +='<span class="icon_secret"><em>비밀글</em></span> ';
													str +='<span>********************************</span>';
												}else{

													var commentStr = memoListNoRead[i].comment;
													if(commentStr!=null&&commentStr.indexOf('<em>[상세보기]</em>')<0){

								 						commentStr = devUtil.fn_escapeReplace(commentStr);

								 						if(commentStr.indexOf('##moveCommonWbsPage($')>-1){
								 							commentStr = commentStr.substring(0,commentStr.indexOf('##moveCommonWbsPage($'));
								 						}
								 					}

													str +='<span> '+commentStr+'</span>';
												}

												str +='</a>';

												if(memoListNoRead[i].commentCount>0) str +=' <span class="icon_comment n_read">('+memoListNoRead[i].commentCount+')</span>'; //댓글 수

												if(memoListNoRead[i].fileCnt>0) str +=' <span class="icon_clip">('+memoListNoRead[i].fileCnt+')</span>'; //파일 카운트

												if(memoListNoRead[i].newYn == 'Y') str +=' <span class="icon_new" style="margin-left: 0px;"><em>new</em></span>';		//신규 댓글이나 글이 오늘등록된건

												str +='</div>';


												str +='<div class="fr_block" style="width:40%;">';

												if(memoListNoRead[i].realEntryCnt >0) str +='<span style="color:#949494;">'+memoListNoRead[i].viewDate.replace(/-/gi,'/')+'</span>';

												if(memoListNoRead[i].createdBy == '${baseUserLoginInfo.userId}' && memoListNoRead[i].realEntryCnt >0 ){  	//발신
													str +='<span class=" mgl10">';
													str +=memoListNoRead[i].entryTopName+'</span>';

													if(memoListNoRead[i].topOrgId !='${baseUserLoginInfo.orgId}'){					//다른 org일때
														str +='('+memoListNoRead[i].topCompanyNm+')';
													}
													str +='</span>';

													str +='<span class="icon_count_em">'+memoListNoRead[i].entryCnt+'</span>';
												}else{
													str +='<span class=" mgl10">';
													if(memoListNoRead[i].createdBy == '${baseUserLoginInfo.userId}' && memoListNoRead[i].realEntryCnt ==0){ //내가 나한테썻을때

														str +='나</span>';

													}else{

														str += memoListNoRead[i].userName;
														if(memoListNoRead[i].orgId !='${baseUserLoginInfo.orgId}'){					//다른 org일때
															str +='('+memoListNoRead[i].companyNm+')';
														}
														str +='</span>';

														if(memoListNoRead[i].realEntryCnt >0){
															str +='<span class="icon_count_em">'+memoListNoRead[i].entryCnt+'</span>';
														}

													}
												}

												str +='</div>';
												str +='</li>';

											}//for

											str += '</ul></div>';

											//펼침 접기 버튼
											if(memoListNoRead.length > 5){		//미열람메모/고정메모 5건보다 많을경우 버튼 생성
												str += '<div class="" style="display:inline-block;text-align:center;width:95%;padding:3px 0px 3px 0px;">';
												str += '	<a href="javascript:fnObj.setNoReadAllYn();" style="display:inline-block;" class="fold_down"><em style="display:none;">전체펼침</em></a>';
												str += '</div>';
											}


										}//if	//읽지 않은 이전 업무보고:E



										//업무보고(메모)
										var memoList = obj.etc.memoList;

										if(g_searchActionType == "KEYWORD"){  // 검색영역
	                                    	str +='<ul class="memo_list result ';
	                                    }else if(g_searchActionType == "MONTH"){  //월별검색
	                                    	str +='<ul class="memo_list ';
	                                    }

										if(obj.item == new Date().yyyy_mm_dd() && memoListNoRead.length > 0) str += ' no_read_exist';
										str +='">';
										for(var i=0; i<memoList.length; i++){
											var viewDate = "";
	                                        if(g_searchActionType == "KEYWORD"){  // 검색영역
	                                            viewDate = memoList[i].viewMonth;
	                                        }else if(g_searchActionType == "MONTH"){  //월별검색
	                                            viewDate = memoList[i].viewDate;
	                                        }

											if(obj.item == viewDate){ //해당 메모 룸 생성일일때,
												str +='<li style="cursor:pointer;" onclick="javascript:fnObj.openMemo('+memoList[i].memoRoomId+');">';

												if(g_searchActionType == "KEYWORD"){  // 검색영역
	                                                str+='<span class="wd_re_Date">'+memoList[i].viewDay+'<em>('+memoList[i].viewDateWeek+')</em></span>';
	                                            }

												if(memoList[i].createdBy == g_workUserId && memoList[i].realEntryCnt ==0){ //내가 나한테썻을때
													str +='<span class="state_icon_memo">메모</span>';

												}else{

													str +='<span class="';

													if(memoList[i].noReadCount == 0) str +='state_icon_check">';	//읽으면 무조건 연두색아이콘

													if(memoList[i].createdBy == g_workUserId ){						//발신일때

														if(memoList[i].noReadCount > 0) str +='state_icon_send">';	//안읽었을떄 아이콘
														str +='발신';
													}else{															//수신일때

														if(memoList[i].noReadCount > 0) str +='state_icon_order">';//안읽었을떄 아이콘
														str +='수신';
													}
													str+='</span>';


												}

												str +='<div class="fl_block">';
												str +='<a>';
												if(memoList[i].important>0){								//중요도
													str +='<span class="icon_important_L'+memoList[i].important+'"><em>!!!</em></span> ';
												}


												if(memoList[i].roomType == 'S'){							//비밀글
													str +='<span class="icon_secret"><em>비밀글</em></span> ';
													str +='<span>********************************</span>';
												}else{

													var comment = "";

													var commentStr = memoList[i].comment;

													if(commentStr!=null&&commentStr.indexOf('<em>[상세보기]</em>')<0){

								 						commentStr = devUtil.fn_escapeReplace(commentStr);

								 						if(commentStr.indexOf('##moveCommonWbsPage($')>-1){
								 							commentStr = commentStr.substring(0,commentStr.indexOf('##moveCommonWbsPage($'));
								 						}
								 					}

		                                            if(g_searchActionType == "KEYWORD") comment = replaceAll(commentStr, $("#searchKeyword").val().trim(),'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
		                                            else comment = commentStr;

													str +='<span> '+comment+'</span>';
												}

												str +='</a>';

												if(memoList[i].commentCount>0){								//댓글 수
													str +=' <span class="icon_comment n_read">('+memoList[i].commentCount+')</span>';
												}


												if(memoList[i].fileCnt>0){									//파일 카운트
													str +=' <span class="icon_clip">('+memoList[i].fileCnt+')</span>';
												}


												str +='</div>';
												str +='<div class="fr_block">';
												if(memoList[i].createdBy == g_workUserId && memoList[i].realEntryCnt >0 ){  	//발신
													str +='<span class="contact_to">';
													str +=memoList[i].entryTopName+'';
													if(memoList[i].topOrgId !='${baseUserLoginInfo.orgId}'){					//다른 org일때
														str +='('+memoList[i].topCompanyNm+')';
													}
													str +='</span></div>';
													str +='<span class="icon_count_em">'+memoList[i].entryCnt
													str +='</span>';
												}else{
													str +='<span class="contact_from">';
													if(memoList[i].createdBy == loginUserId && memoList[i].realEntryCnt ==0){ 	//내가 나한테썻을때
														str +='나</span></div>';
													}else{

														str += memoList[i].userName;
														if(memoList[i].orgId !='${baseUserLoginInfo.orgId}'){
															str +='('+memoList[i].companyNm+')';
														}
														str +='</span></div>';
														if(memoList[i].realEntryCnt >0){
															str +='<span class="icon_count_em">'+memoList[i].entryCnt+'</span>';
														}

													}
												}

												str +='</li>';

											}

										}
										/*************************************************
										** 메모 마지막 생성한날도 화면에 보여줌 (2017.07.17. 이인희)
										**************************************************/
										if(g_searchActionType != "KEYWORD"){  // 검색영역
											var memoLastUpdateList = obj.etc.memoLastUpdateList;

	                                        for(var i=0; i<memoLastUpdateList.length; i++){
	                                            var viewDate = "";
	                                            if(g_searchActionType == "KEYWORD"){  // 검색영역
	                                                viewDate = memoLastUpdateList[i].viewMonth;
	                                            }else if(g_searchActionType == "MONTH"){  //월별검색
	                                                viewDate = memoLastUpdateList[i].viewDate;
	                                            }

	                                            if(obj.item == viewDate){ //해당 메모 룸 생성일일때,
	                                                str +='<li style="cursor:pointer;" onclick="javascript:fnObj.openMemo('+memoLastUpdateList[i].memoRoomId+');">';

	                                                if(g_searchActionType == "KEYWORD"){  // 검색영역
	                                                    str+='<span class="wd_re_Date">'+memoLastUpdateList[i].viewDay+'<em>('+memoLastUpdateList[i].viewDateWeek+')</em></span>';
	                                                }

	                                                if(memoLastUpdateList[i].createdBy == g_workUserId && memoLastUpdateList[i].realEntryCnt ==0){ //내가 나한테썻을때
	                                                    str +='<span class="state_icon_memo">메모</span>';

	                                                }else{

	                                                    str +='<span class="';

	                                                    if(memoLastUpdateList[i].noReadCount == 0) str +='state_icon_check">';    //읽으면 무조건 연두색아이콘

	                                                    if(memoLastUpdateList[i].createdBy == g_workUserId ){                     //발신일때

	                                                        if(memoLastUpdateList[i].noReadCount > 0) str +='state_icon_send">';  //안읽었을떄 아이콘
	                                                        str +='발신';
	                                                    }else{                                                          //수신일때

	                                                        if(memoLastUpdateList[i].noReadCount > 0) str +='state_icon_order">';//안읽었을떄 아이콘
	                                                        str +='수신';
	                                                    }
	                                                    str+='</span>';


	                                                }

	                                                str +='<div class="fl_block">';
	                                                str +='<a>';
	                                                if(memoLastUpdateList[i].important>0){                                //중요도
	                                                    str +='<span class="icon_important_L'+memoLastUpdateList[i].important+'"><em>!!!</em></span> ';
	                                                }


	                                                if(memoLastUpdateList[i].roomType == 'S'){                            //비밀글
	                                                    str +='<span class="icon_secret"><em>비밀글</em></span> ';
	                                                    str +='<span>********************************</span>';
	                                                }else{
	                                                    var comment = "";

	                                                    var commentStr = memoLastUpdateList[i].comment;

	                                                    if(commentStr!=null&&commentStr.indexOf('<em>[상세보기]</em>')<0){

	                                                        commentStr = devUtil.fn_escapeReplace(commentStr);

	                                                        if(commentStr.indexOf('##moveCommonWbsPage($')>-1){
	                                                            commentStr = commentStr.substring(0,commentStr.indexOf('##moveCommonWbsPage($'));
	                                                        }
	                                                    }

	                                                    if(g_searchActionType == "KEYWORD") comment = replaceAll(commentStr, $("#searchKeyword").val().trim(),'<span class="mark_st">' + $("#searchKeyword").val().trim() + '</span>');           //내용
	                                                    else comment = commentStr;

	                                                    str +='<span> '+comment+'</span>';
	                                                }

	                                                str +='</a>';

	                                                if(memoLastUpdateList[i].commentCount>0){                              //댓글 수
	                                                    str +=' <span class="icon_comment n_read">('+memoLastUpdateList[i].commentCount+')</span>';
	                                                }


	                                                if(memoLastUpdateList[i].fileCnt>0){                                  //파일 카운트
	                                                    str +=' <span class="icon_clip">('+memoLastUpdateList[i].fileCnt+')</span>';
	                                                }


	                                                str +='</div>';
	                                                str +='<div class="fr_block">';
	                                                if(memoLastUpdateList[i].createdBy == g_workUserId && memoLastUpdateList[i].realEntryCnt >0 ){      //발신
	                                                    str +='<span class="contact_to">';
	                                                    str +=memoLastUpdateList[i].entryTopName+'';
	                                                    if(memoLastUpdateList[i].topOrgId !='${baseUserLoginInfo.orgId}'){                    //다른 org일때
	                                                        str +='('+memoLastUpdateList[i].topCompanyNm+')';
	                                                    }
	                                                    str +='</span></div>';
	                                                    str +='<span class="icon_count_em">'+memoLastUpdateList[i].entryCnt
	                                                    str +='</span>';
	                                                }else{
	                                                    str +='<span class="contact_from">';
	                                                    if(memoLastUpdateList[i].createdBy == loginUserId && memoLastUpdateList[i].realEntryCnt ==0){   //내가 나한테썻을때
	                                                        str +='나</span></div>';
	                                                    }else{

	                                                        str += memoLastUpdateList[i].userName;
	                                                        if(memoLastUpdateList[i].orgId !='${baseUserLoginInfo.orgId}'){
	                                                            str +='('+memoLastUpdateList[i].companyNm+')';
	                                                        }
	                                                        str +='</span></div>';
	                                                        if(memoLastUpdateList[i].realEntryCnt >0){
	                                                            str +='<span class="icon_count_em">'+memoLastUpdateList[i].entryCnt+'</span>';
	                                                        }

	                                                    }
	                                                }

	                                                str +='</li>';

	                                            }

	                                        }
										}

										/*************************************************/

										if(g_searchActionType == "MONTH"){  //월별검색
											if(loginUserId == g_workUserId){
	                                            str+= '<button type="button" class="btn_addmemo btn_auth" onClick="javascript:fnObj.openMemo(0,\''+obj.item+'\');"><em>메모 등록</em></button>';
	                                        }else if('Y' == '${baseUserLoginInfo.wholeMemoViewYn}') {  //2017.03.16 전체메모 권한여부의 권한이 있는경우 타인 메모 등록 가능함
	                                            str+= '<button type="button" class="btn_addmemo btn_auth" onClick="javascript:fnObj.openMemo(0,\''+obj.item+'\');"><em>메모 등록</em></button>';
	                                        }
										}

										return str;
			}},	//메모

			{key : "idx4"	 	, formatter : function(obj) { //날짜 tr 아이디값


									return obj.item;

			}},	//날짜 tr 아이디값

			{key : "idx5"		, formatter : function(obj) { //휴일 표시
									var trClass =''
									var holidayList = obj.etc.holidayList;
									for(var i=0; i<holidayList.length; i++){

										if(holidayList[i].sysDate == obj.item){
											trClass='class="no_workbg"';
										}
									}

									return trClass;
			}}, //휴일 표시

			],
			body : {
				onclick : function(obj, e) {

				}
			}

		};

		/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
		var rowHtmlStr = '<tr id="tr_#[4]" #[5]>';
        rowHtmlStr += '<th>#[0]</th>';
        rowHtmlStr += '<td class="conrelative draggableTd" id = "draggableTd_#[4]">#[1]</td>';
        rowHtmlStr += '<td class="conrelative">#[2]</td>';
        rowHtmlStr += '<td class="conrelative">#[3]</td>';
        rowHtmlStr += '</tr>';
        configObj.rowHtmlStr = rowHtmlStr;
        myGrid.setConfig(configObj);

		//-------------------------- 그리드 설정 :E ----------------------------

		//-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",

    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: false,
    		onclose: function(){

    		}
            ,contentDivClass: "popup_outline"

    	});
    	//-------------------------- 모달창 :E -------------------------

    },//end pageStart.


    //default 로 달력 그려줌.
	doDefaultCalendar : function(userId){
		var nowDate = new Date().yyyy_mm_dd();
		var dateArr = nowDate.split("-");

		if(g_year != '') dateArr[0]=g_year;
		if(g_month!= '') dateArr[1]=g_month;

		var lastDay = ( new Date( dateArr[0], dateArr[1], 0) ).getDate();		//마지막 날짜

		var dateList = [];
		for(var i=1;i<=lastDay;i++){
			dateList.push(dateArr[0]+'-'+dateArr[1]+'-'+fillzero(i, 2));
		}

		myGrid1.setGridData({ 	//그리드 데이터 세팅	*** 2 ***
			list : dateList 	//그리드 테이터
		});


		//날짜 세팅
		var startDate = dateArr[1]+'.01';
		var endDate = dateArr[1]+'.'+lastDay;
		startDate += '('+getWeekName(dateArr[0],dateArr[1],'01')+')';
		endDate += '('+getWeekName(dateArr[0],dateArr[1],lastDay)+')';
		$("#dateArea").html(dateArr[0]+'년 '+dateArr[1]+'월<em> - '+ startDate+' ~ '+endDate+'</em>');
		$("#tr_"+new Date().yyyy_mm_dd()).addClass("today_bg");

		//fnObj.setDateFocus();

	},


	//전체 정보 업무일지 정보공유 메모
	doSearch : function(userId,scrollYn){

		g_workUserId = userId;

		var dateArr = g_selectDate.split("-");

		if(g_year != '') dateArr[0]=g_year;
		if(g_month!= '') dateArr[1]=g_month;

		var lastDay = ( new Date( dateArr[0], dateArr[1], 0) ).getDate();		//마지막 날짜

		var url = contextRoot + "/work/selectWorkDailyList.do";

		var param = {
				userId		: g_workUserId,
				loginUserId	: loginUserId,
				secretYn	: (g_workUserId == loginUserId ? 'Y' : 'N'),		//조회자 본인 여부
				selectMonth : dateArr[0]+'-'+dateArr[1],
				calYear 	: dateArr[0],
				mm 			: dateArr[1],
				orgId 		: g_applyOrgId,
				option 		: 'holiday',
				treeOrg		: $("#treeOrg").val(),

				searchStartDate     : $("#searchStartDate").val(),
                searchEndDate     : $("#searchEndDate").val(),

                searchDailyTypeWork     : ($("input[name=searchDailyTypeWork]:checked").val() == undefined ? '':$("input[name=searchDailyTypeWork]:checked").val()),  //업무일지
                searchDailyTypeSales     : ($("input[name=searchDailyTypeSales]:checked").val() == undefined ? '':$("input[name=searchDailyTypeSales]:checked").val()),  //영업정보
                searchDailyTypeMemo     : ($("input[name=searchDailyTypeMemo]:checked").val() == undefined ? '':$("input[name=searchDailyTypeMemo]:checked").val()),  //업무보고

                searchKeyword     : $("#searchKeyword").val().trim(),
                searchActionType     : g_searchActionType
		};


		var callback = function(result){

			var obj = JSON.parse(result);

			if(g_searchActionType == "KEYWORD"){  // 검색영역
				myGrid.setGridData({ //그리드 데이터 세팅  *** 2 ***
                    list : obj.resultObject.searchMothList, //그리드 테이터
                    etc : obj.resultObject
                });
			    var personalWorkDailyListCnt = obj.resultObject.personalWorkDailyList.length;
			    var teamWorkDailyListCnt = obj.resultObject.teamWorkDailyList.length;
			    var scheListCnt = obj.resultObject.scheList.length;
			    var businessDailyListCnt = obj.resultObject.businessDailyList.length;
			    var memoListCnt = obj.resultObject.memoList.length;

			    var totalCnt = personalWorkDailyListCnt + teamWorkDailyListCnt + scheListCnt + businessDailyListCnt + memoListCnt;

			    var dateAreaHtml = obj.resultObject.searchStartDate + ' ~ ' + obj.resultObject.searchEndDate;
			    dateAreaHtml += '<em class="mgl15">(검색결과 : '+totalCnt+')</em>';

			    var workTitleAreaHtml = '('+(personalWorkDailyListCnt + teamWorkDailyListCnt + scheListCnt) +')';
			    var salesTitleAreaHtml = '('+businessDailyListCnt +')';
			    var memoTitleAreaHtml = '('+memoListCnt +')';

				$("#dateArea").html(dateAreaHtml);
				$("#workTitleArea").html(workTitleAreaHtml);
				$("#salesTitleArea").html(salesTitleAreaHtml);
				$("#memoTitleArea").html(memoTitleAreaHtml);

				$('.oneday_conBox').scrollTop(1);

            }else if(g_searchActionType == "MONTH"){ //월별검색
            	var dateList = [];
                for(var i=1;i<=lastDay;i++){
                    dateList.push(dateArr[0]+'-'+dateArr[1]+'-'+fillzero(i, 2));
                }

            	myGrid.setGridData({ //그리드 데이터 세팅  *** 2 ***
                    list : dateList, //그리드 테이터
                    etc : obj.resultObject

                });

                var teamWork = ($("#teamWork").is(":checked") || $("#teamWork").val() == undefined ? 'Y' : 'N');

                if(teamWork == 'N'){
                    $("#teamWork").prop("checked",false);
                    $(".teamArea").hide();
                }
               // $('.oneday_conBox').scrollTop($('#date_01').position().top-100);
                //날짜 세팅
                var startDate = dateArr[1]+'.01';
                var endDate = dateArr[1]+'.'+lastDay;
                startDate += '('+getWeekName(dateArr[0],dateArr[1],'01')+')';
                endDate += '('+getWeekName(dateArr[0],dateArr[1],lastDay)+')';

                $("#dateArea").html(dateArr[0]+'년 '+dateArr[1]+'월<em> - '+ startDate+' ~ '+endDate+'</em>');
                $("#workTitleArea").html("TO DO LIST");
                $("#salesTitleArea").html("BUSINESS INFO");
                $("#memoTitleArea").html("MEMO LIST");

                $("#tr_"+new Date().yyyy_mm_dd()).addClass("today_bg");

                /* if(targetTdId!=""){
                    var targetDtBuf = targetTdId.split("_")
                    var targetDt = targetDtBuf[1];

                    var targetDate = targetDt.split("-");
                    $('.oneday_conBox').scrollTop($('#date_'+targetDate[2]).position().top-150);

                     targetTdId = "";

                }else if(scrollYn != 'N') fnObj.setDateFocus(); */

                if(scrollYn != 'N'&&targetTdId=="") fnObj.setDateFocus();
                //미열람메모/고정메모 펼침,접기 버튼 액션
                fnObj.foldNoRead();     //현재 상태로 재세팅

                fnObj.pageSetting(); //개인업무 > 드래그 > 복사 ,이동 기능을위해 만듬 psj.

                if("${baseUserLoginInfo.orgBasicAuth}" == "READ" || $("#treeOrg option:selected").attr("targetAuth")== "READ"){
                	$(".btn_auth").hide();
                }else{
                	$(".btn_auth").show();
                }

            }


			//메모말풍선
			openMemoHelpArea(0,10,0);
            /* g_searchActionType = "MONTH"; */
		};
		commonAjax("POST", url, param, callback, true);
	},

	//검색영역에서 검색시
    doSearchByKeyword : function(){

    	var searchStartDate = new Date($('#searchStartDate').val());
    	var searchEndDate = new Date($('#searchEndDate').val());

    	var searchStartDate6 = searchStartDate;
    	searchStartDate6.setMonth(searchStartDate6.getMonth() + 6);

    	var searchDailyTypeWork = ($("input[name=searchDailyTypeWork]:checked").val() == undefined ? '':$("input[name=searchDailyTypeWork]:checked").val()); //업무일지
    	var searchDailyTypeSales = ($("input[name=searchDailyTypeSales]:checked").val() == undefined ? '':$("input[name=searchDailyTypeSales]:checked").val());  //영업정보
    	var searchDailyTypeMemo = ($("input[name=searchDailyTypeMemo]:checked").val() == undefined ? '':$("input[name=searchDailyTypeMemo]:checked").val());  //업무보고

    	if($("#searchKeyword").val().trim() == ""){
    		alert("검색어를 입력해 주세요.");
            $("#searchKeyword").val('');
            $("#searchKeyword").focus();
            return;
    	}

    	if($('#searchStartDate').val() > $('#searchEndDate').val()){
    		alert("검색기간의 종료일은 시작일보다 이전일 수 없습니다.");
            $("#searchStartDate").focus();
            return;
    	}

    	if(searchStartDate6 <= searchEndDate){
            alert("검색기간은 최대 6개월까지 가능합니다.");
            $("#searchStartDate").focus();
            return;
        }

    	if(searchDailyTypeWork =="" && searchDailyTypeSales =="" && searchDailyTypeMemo ==""){
    		alert("적어도 하나이상의 범위를 선택 하셔야 합니다.");
    		$("input[name=searchDailyTypeWork]").focus();
    		return;
    	}

        $("#searchKeyword").val($("#searchKeyword").val().trim());

    	g_searchActionType = "KEYWORD";
    	fnObj.doSearch(g_workUserId);
    },

  //검색영역리셋
    doResetByKeyword : function(resetType){

    	if(resetType == "KEYWORD"){
    		var nowDate = new Date();
            var firstDate = new Date(nowDate.getFullYear(),nowDate.getMonth(),1);
            var lastDate = new Date(nowDate.getFullYear(),nowDate.getMonth()+1,0);

            $('#searchStartDate').val(getDateFormat(firstDate));
            $('#searchEndDate').val(getDateFormat(lastDate));

            g_selectDate = new Date().yyyy_mm_dd();
            var dateArr = g_selectDate.split("-");

            $("#choiceYear").val(dateArr[0]);
            g_year = dateArr[0];

            $(".on").removeClass();
            $("#month_"+parseInt(dateArr[1])).addClass("on");
            g_month = dateArr[1];

    	}else if(resetType == "MONTH"){
    		var dateArr = g_selectDate.split("-");
            if(g_year != '') dateArr[0]=g_year;
            if(g_month!= '') dateArr[1]=g_month;

    		var nowDate = new Date(dateArr[0], dateArr[1],1);
    		nowDate.setMonth(nowDate.getMonth()-1); //한달 전해야 이번달이 됨
    		var firstDate = new Date(nowDate.getFullYear(),nowDate.getMonth(),1);
    		var lastDate = new Date(nowDate.getFullYear(),nowDate.getMonth()+1,0);

            $('#searchStartDate').val(getDateFormat(firstDate));
            $('#searchEndDate').val(getDateFormat(lastDate));
    	}


        $('#searchDailyTypeWork').attr('checked', true);
        $('#searchDailyTypeSales').attr('checked', true);
        $('#searchDailyTypeMemo').attr('checked', true);
        $("#searchKeyword").val("");

        g_searchActionType = "MONTH";

        if(resetType == "KEYWORD"){
            fnObj.doSearch(g_workUserId);
        }
    },


	//사용자 트리 생성
	setUserTree: function(){


		/* 사용자트리 설정정보 */
		var configObj = {
				targetID : 'userListAreaTree',							//대상 위치 id (div, span)
				url : contextRoot + "/common/getOrgDeptUserList.do",	//데이터 URL
				isOnlyOne : true,										//선택건수 1개 여부			(false: 복수,		그외,: 한명(default))
				isAllOrg : false,										//전체 ORG 범위로의 여부		(true: 전체ORG, 		그외,: 나의권한ORG (default))
				oneOrg : '${baseUserLoginInfo.applyOrgId}',				//전달받은 한개의 ORG ID
				defaultSelectList : ['${baseUserLoginInfo.userId}'],	//기본 선택 id array 			(로딩시점 초기 기본 선택 노드 id list)
				isDeptSelectable : false,								//부서선택 가능여부(= 하위 사용자 모두 선택)		(true: 해당부서하위모두선택, 	그외,:부서선택불가 (default))
				callbackFn : fnObj.selStaff,							//콜백 function
				useAllCheck : false,									//전체선택 기능 사용 여부		(true: 사용,			그외,: 미사용(default))
				isCallbackEnable : true,
				useNameSortList : true,									//이름정렬선택 리스트 사용 여부 (true: 사용,		그외,: 미사용(default))
				isUserGroup : true,                                 	//유저그룹 탭 사용여부 (true: 사용,       그외,: 미사용(default))
				hasDeptTopLevel    : true,                              //부서의 회장 부서 표시여부  (true: 포함,     그외,: 미포함(default))
				openDeptId : ('${baseUserLoginInfo.deptMngrYn}' == 'Y' ?  '${baseUserLoginInfo.deptId}' : '0' ),
				myUserId : '${baseUserLoginInfo.userId}',				//로긴 유저아이디
				myOrgId : '${baseUserLoginInfo.orgId}',					//로긴 유저orgId
				deptManagerDeptId : '${baseUserLoginInfo.deptIdMngr}',
				authTree : true

		};

		 if('${baseUserLoginInfo.workViewYn}' == 'Y') configObj.deptManagerDeptId = '-1';

		myUserTree.setConfig(configObj);	//설정정보 세팅
		myUserTree.drawTree();				//트리 생성


	},

	//직원선택후 콜백
	selStaff: function(userList,orgId){

		fnObj.doSearch(userList);
	},



	//----------------------------------업무일지 업무 : S	-----------------------------------------------//

 	//업무일지 등록 팝업
	openWorkDaily : function(listId,viewDate){


   		var param = {
   			 listId 	: listId,
   			 workUserId	: g_workUserId,
   			 workDate	: viewDate
	   	};

 	    var url =contextRoot+"/work/workDailyRegPopup/pop.do";

 	   	myModal.open({
 	   		url: url,
 	   		pars: param,
 	   		titleBarText: '업무일지 '+(listId>0 ? '수정' : '등록')+'',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
 	   		method:"POST",
 	   		top: $(document).scrollTop()+150,
 	   		width: 750,
 	   		closeByEscKey: true				//esc 키로 닫기
   		});

   		$('#myModalCT').draggable();
    },


 	//업무일지 보기화면
    viewWorkDaily : function(listId,workType,viewDate,openType){


    	var url =contextRoot+"/work/workDailyViewPopup/pop.do";
    	var width = 750;
    	if(workType == 'TEAM'){	//팀업무
    		//url 바꾸기
    		url =contextRoot+"/work/workDailyTeamViewPopup/pop.do";
    		width = 1300;
    	}

    	var param = {
      			 listId 	: listId,
      			 workUserId	: g_workUserId,
      			 workDate	: viewDate,
      			 openType	: openType
      	};


 	   	myModal.open({
 	   		url: url,
 	   		pars: param,
 	   		titleBarText: '업무일지 상세',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
 	   		method:"POST",
 	   		top: $(document).scrollTop()+150,
 	   		width: width,
 	   		closeButton: false,
 	   		changeCloseBtn: true,
 	   		closeByEscKey: true					//esc 키로 닫기
   		});

   		$('#myModalCT').draggable();

    },

    //업무일지종료처리
    endWorkDaily : function(listId,nowComplete,progress,workDate){

    	var complete = 'N';
		var completeDate = '1988-09-12';


    	if(nowComplete == 'N'){			//현재 미완료된 일정이다.
    		complete = 'Y';
    		completeDate = new Date().yyyy_mm_dd();
    	}


    	var url =contextRoot + "/work/endWorkDaily.do";


	   	 var param = {
	   			 listId		 	: listId,
	   			 complete 		: complete,
	   			 completeDate	: completeDate,
	   			 progress 		: progress

	   	 };

	   	 var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		if(cnt>0){
    			fnObj.doSearch(loginUserId,'N');

    		}else{
    			dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
    		}
    	};

    	commonAjax("POST", url, param, callback, false);
    },

    //업무일지삭제
    deleteWorkDaily : function(listId,workType){

    	if(!confirm("해당 업무일지를 삭제하시겠습니까?")){
    		return;
    	}
    	var url =contextRoot + "/work/deleteWorkDaily.do";

    	var param = {
	   			 listId		 	: listId,
	   			workType		: workType

	   	};

	   	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		if(cnt>0){
    			fnObj.doSearch(loginUserId,'N');

    		}else{
    			dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
    		}
    	};

    	commonAjax("POST", url, param, callback, false);
    },

  	//----------------------------------업무일지 업무 : E	-----------------------------------------------//



  	//----------------------------------업무일지 일정 : S	-----------------------------------------------//

  	//일정 등록
	addSchedule : function(selDate) {

		//if(schePopFlag){
			//Month = $('#SelMonth').val();
            //if(Month.length == 1) Month = "0" + Month;
            //if(SelDay.length == 1) SelDay = "0" + SelDay;
            //SelDate = $('#SelYear').val() + "-" + Month + "-" + SelDay;

            var url = "<c:url value='/scheduleProc.do'/>" + "?cmd=${vo.cmd}&EventType=Add&ParentPage=Cal&ScheSDate="+selDate;
            window.open(url, 'scheduleProc','resizable=no,width=780,height=700,scrollbars=yes');
		//}
		//schePopFlag = true;
	},


  	//일정 보기
    viewSchedule : function(scheSeq){
		schePopFlag = false;
	    var url = "<c:url value='/ScheduleView.do?ScheSeq=" + scheSeq + "'/>";
	    window.open(url, 'scheduleView','resizable=no,width=674,height=700,scrollbars=yes');
	    schePopFlag = true;
    },


  	//일정 종료처리
    chkSchedule : function(scheSeq, complete){

		var url = contextRoot + "/work/updateScheduleStts.do";

		var param = {
				scheSeq	 : scheSeq,
	   			sttsCd : (complete=='Y'?'N':'Y')
		};

		var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		if(cnt>0){
	    		toast.push("변경되었습니다!");
    			fnObj.doSearch(loginUserId,'N');

    		}else{
    			dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
    		}
    	};

    	commonAjax("POST", url, param, callback, true);
    },


  	//----------------------------------업무일지 일정 : E	-----------------------------------------------//


  	//----------------------------------메모 : S			-----------------------------------------------//

	//메모창 오픈
	openMemo : function(memoRoomId, viewDate, pastDate){

   		var param = {
   			 memoRoomId : memoRoomId,
   			 workUserId	: g_workUserId,
   			 viewDate	: viewDate
	   	};

 	   var url =contextRoot+"/work/memoBox/pop.do" + "?memoRoomId="+memoRoomId+"&workUserId="+g_workUserId+"&viewDate="+viewDate;

 	   var popWidth  = '750'; // 파업사이즈 너비
	   var popHeight = '780'; // 팝업사이즈 높이

	   var option = 'resizable=yes,width='+popWidth+', height='+popHeight+', scrollbars=auto';

	   memoPopupWidth = memoPopupWidth+50;

	   if(memoPopupCnt%6 == 0) memoPopupWidth = (window.screenX || window.screenLeft || 0)+50;

	   if(memoPopupCnt>0){
		   if(memoPopupCnt%6 ==0) memoPopupHegit =memoPopupHegit +50;
	   }

	   if(memoPopupCnt ==18){
		   memoPopupCnt = 0;
		   memoPopupWidth = (window.screenX || window.screenLeft || 0)+50;
		   memoPopupHegit = (window.screenY || window.screenTop || 0)+50;
	   }
	   memoPopupCnt++;

	   var winPop = window.open(url, '_blank', option);

	   winPop.moveTo(memoPopupWidth,memoPopupHegit);

 	   	/* myModal.open({
 	   		url: url,
 	   		pars: param,
 	   		titleBarText: '메모',
 	   		method:"POST",
 	   		top: $(document).scrollTop()+10,
 	   		width: 750,
 	   		closeByEscKey: true				//esc 키로 닫기
   		});

   		$('#myModalCT').draggable(); */
    },

  	//----------------------------------메모 : E		-----------------------------------------------//


  	//----------------------------------정보공유 : S	-----------------------------------------------//


  	//정보 공유 열기
    openInfoWindow : function( businessOrgId, viewDate ){
    	var form = document.frm;
    	form.targetOrgId.value = businessOrgId;
    	form.targetDate.value = viewDate;

		var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";
		commonPopupOpen("businessRegisterPop",contextRoot+"/business/businessInfoRegist.do", option , $("#frm"));
    },

    //정보 상세페이지 열기
    openDetailWindow : function( infoId ){
    	var form = document.frm;
    	form.infoId.value = infoId;

		var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";
		commonPopupOpen("businessDetailPop",contextRoot+"/business/businessDetail.do", option , $("#frm"));
    },


  	//----------------------------------정보공유 : E	-----------------------------------------------//


    //년도 세팅
    setYear : function(){
    	//var nowDate= new Date().yyyy_mm_dd();
    	var nowYear = g_selectDate.substring(0,4);
    	var str ='<select id="choiceYear" class="select_b w_date" onchange="fnObj.changeYear();">';
    	for(var i="2012";i<=parseInt(nowYear)+1;i++){
    		var chk ='';
    		if(nowYear == i){
    			chk ='selected="selected"';
    		}
    		str += '<option value="'+ i+'" '+chk+'>'+ i+'</option>';
    	}
    	str += '</select>';
    	$("#yearArea").html(str);
    },

	//월 세팅
    setMonth : function(){
    	//var nowDate= new Date().yyyy_mm_dd();
    	var nowMonth = g_selectDate.substring(5,7);

    	var str ='';
    	for(var i=1; i<13; i++){
    		str += '<button type="button" id="month_'+i+'" onclick="fnObj.changeMonth('+i+');">'+i+'월</button>';
    	}

    	$("#monthArea").html(str);
    	$("#month_"+parseInt(nowMonth)).addClass("on");
    },

    //년도 변경
    changeYear : function(){
    	g_year =$("#choiceYear").val();
    	g_searchActionType = "MONTH";

    	fnObj.doResetByKeyword("MONTH");  // 밑에 검색 리셋
    	fnObj.doSearch(g_workUserId);
    },

    //월 변경
    changeMonth : function(month){
    	$(".on").removeClass();
    	$("#month_"+month).addClass("on");
    	g_month = fillzero(month, 2);
    	g_searchActionType = "MONTH";

    	fnObj.doResetByKeyword("MONTH");  // 밑에 검색 리셋
    	fnObj.doSearch(g_workUserId);
    },



    //첫 로드시 현재 날짜로 스크롤 이동
    setDateFocus : function(){

    	if(g_selectDate==''){
    		g_selectDate = new Date().yyyy_mm_dd();
    	}
    	var dateArr = g_selectDate.split("-");

    	if(g_month == "" || ($("#choiceYear").val() + g_month) == (dateArr[0] + dateArr[1])){

    		$('.oneday_conBox').scrollTop($('#date_'+dateArr[2]).position().top-100);

    	}else{

    		$('.oneday_conBox').scrollTop(1);
    	}
    },

    //지난일정 보기 버튼
    displayTeamWork : function(){
    	if($("#stas1").is(":checked")){
    		$(".teamArea").show();
    	}else{
    		$(".teamArea").hide();
    	}
    },


   //미열람메모/고정메모 펼침,접기 버튼 액션
    foldNoRead : function(){
    	if($('.no_read_list').length > 0){
		    if(g_noReadAllYn == 'Y'){		//펼침
				$('.no_read_list').css('height', $('.no_read_list')[0].scrollHeight + 'px');		//'300px');

				$('.fold_down').addClass('fold_up');
				$('.fold_down').removeClass('fold_down');

			}else{				//접기
				var thisHeight = $('.no_read_list')[0].scrollHeight;

				$('.no_read_list').css('height', (thisHeight < 131 ? thisHeight : 131) + 'px');

				$('.fold_up').addClass('fold_down');
				$('.fold_up').removeClass('fold_up');
			}
    	}
    },


  	//미열람메모/고정메모 전체보기, 세션 세팅
    setNoReadAllYn : function (){
    	//미열람메모/고정메모 전체보기 상태 ... 'Y':전체보기, 'N':일부보기		■■■■ global variable ■■■■
    	g_noReadAllYn = (g_noReadAllYn == 'N'?'Y':'N');		//현재 상태 반대 세팅

    	fnObj.foldNoRead();		//미열람메모/고정메모 펼침,접기 버튼 액션
    },
  	//화면이 모두 로드된 다음 추가 이벤트
    pageSetting : function(){

    	var receivChk = false;

    	/** drag n drop **/
    	$( ".darggableUl" ).sortable({
    		start: function (event, ui) {
    			 receivChk = false;

    			 var targetId = ui.item.context.id;
    		},
    		stop: function (event, ui) {
     			if(!receivChk) return false;

     			 var targetId = ui.item.context.id;

    			 var listIdBuf = targetId.split("_");

    			 listId = listIdBuf[1];

    			 var $target = $("#"+targetId).parent().parent();
    			 dialogChk = false;
    			 targetTdId = $target.attr("id");
    			 dialog.push({body:'<b>확인</b> 선택하신 업무에\n원하는 액션을 선택해 주세요', type:'Caution', buttons:[
    					{buttonValue:'복사', buttonClass:'Red', onClick:fnObj.moveDailyWork, data:'COPY'},
    					{buttonValue:'이동', buttonClass:'Blue', onClick:fnObj.moveDailyWork, data:'MOVE'},
    					{buttonValue:'취소', buttonClass:'Green', onClick:fnObj.moveDailyWork, data:'CANCEL'}
    				],
    				onclose:function(){
    					if(!dialogChk) fnObj.doSearch(g_workUserId);
    				}
    			 });


    		 },
    		 receive : function (event, ui){

				receivChk = true;
    		 },
    		 connectWith : ".darggableUl",
    		 items: "li:not(.notDraggable)",
    		 placeholder: "ui-state-highlight",
    		 axis:"y",
    		 scrollSensitivity: 10,
    		 forcePlaceholderSize: true,
    		 appendTo: '#helperArea',
    		 helper: 'clone'
    	}).disableSelection();

    	$( '.darggableUl' ).bind( "sortstart", function (event, ui) {
            ui.helper.css('margin-left', '90px' );
        });

    },
    moveDailyWork:function(type){

    	dialogChk = true;
    	if(type == 'CANCEL'){
    		fnObj.doSearch(g_workUserId);
    		return false;
    	}

    	var url = contextRoot + "/work/processWorkDaily.do";

    	var targetDtBuf = targetTdId.split("_")
    	var targetDt = targetDtBuf[1];

		var param = {
				listId		: listId,
				targetDt	: targetDt,
				type		: type

		};
		var callback = function(data){
			var result = JSON.parse(data);
			//성공이면 성공메세지를 , 실패면 서버단에서 보내온 실패 메세지를 보여준다.
			if(result.resultObject.result=="SUCCESS"){
				toast.push('저장되었습니다.');
			}else{
				dialog.push({body:"<b>확인!</b> "+result.resultObject.msg, type:""});
			}

			fnObj.doSearch(g_workUserId);

		};
		commonAjax("POST", url, param, callback, false);
    }
};//fnObj

//일정 등록후 콜백
function openPageReload(){
	fnObj.doSearch(g_workUserId,'N');
}

//프로젝트 종료 예정 팝업
function alarmProjectEnd() {
    // 프로젝트 종료 예정 정보가 있는경우 팝업호출함
    if('${projectEndPopupShow}' == 'Y'){
        var cookie = "cookie_alarmProjectEnd";
        if (getCookie(cookie) == ""){
            var url = "<c:url value='/work/mainProjectEndAlarm.do'/>";
            window.open(url, 'alarmProjectEnd', 'resizable=yes,width=650, height=300, scrollbars=yes');
        }
    }
}


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.defaultPageStart();
	fnObj.pageStart();		//화면세팅
	fnObj.doDefaultCalendar();
	fnObj.setUserTree();

	alarmProjectEnd();

	//유저프로필 이벤트 셋팅
	initUserProfileEvent();

	//메모말풍선
	openMemoHelpArea(0,10,0);
});
</script>




