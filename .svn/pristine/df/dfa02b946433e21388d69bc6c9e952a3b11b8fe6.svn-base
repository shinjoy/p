<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<!-- -------- each page css :S -------- -->
<style type="text/css">
.tb_time_input input {
    width: 80%;
}
.oriVal{
	padding-left:3px;
	padding-bottom:1px;
	color:#ddd;
	font-weight:bold;
	width: 10%;
	display:inline-block;
	text-align:right;
	vertical-align:bottom;
}
.weekend_font{
	opacity:0.5;
}
.finish_timesheet .finish_mark {
    position: absolute;
    top: 50%;
    left: 50%;
    z-index: 1;
    margin-left: -169px;
    margin-top: -25px;
    opacity: 0.2;
}
input.closedInput{
	border:1px dotted #EEEEEE!important;
}
.finish_timesheet .tb_time_input, .finish_timesheet .timesheet_date { opacity:1.0; }

/* .tb_time_list tbody tr.tr_selected {
	font-weight: bold;
    border-top: solid 2px #999;
    border-bottom: solid 2px #999;
    border-left: solid 3px #999;
    padding-bottom: 3px;
} */

.timesheet_wrap {
    max-height: 400px;
}
.tb_time_list tbody td {
    border-top: #999999 solid 1px;
}
.tb_time_input tbody td {
	border-top: #DDDDDD solid 1px;
}
.btn_finish_ok {
    min-width: 10px;
    padding: 0 20px;
}
.btn_no_finish {
    min-width: 10px;
    padding: 0 20px;
    color: #555555!important;
    background: white;
}
.tb_time_list tbody tr.finish_line td {
    border-top: #999999 solid 1px;
}
.tsOneWeek{	/* 한주간 선택한 td */
    border-top: solid 1px #ffbbbb!important;
    border-left: solid 2px #ffbbbb!important;
    border-right: solid 1px #ffbbbb!important;
    border-bottom: solid 1px #ffbbbb!important;
    padding-bottom: 3px;

    background: #ffeee0;
}
.tsOneWeekMan{	/* 한주간 선택한 td */
    border-top: solid 1px #ffbbbb!important;
    border-left: solid 1px #ffbbbb!important;
    border-right: solid 1px #ffbbbb!important;
    border-bottom: solid 1px #ffbbbb!important;
    padding-bottom: 3px;

    background: #ffeee0;
}
/* .tsOneWeek a{
	background: #ffeee0!important;
	color:#ffbbbb!important;
	border:0px solid #ffbbbb!important;
} */
</style>
<!-- -------- each page css :E -------- -->




    <section id="detail_contents">


        <!--title-->
        <div class="timesheet_titleZone">
        	<h3 class="h3_design_title">Timesheet Approval</h3>
            <p class="sub_title"><strong>직원들의 타임시트 승인처리를</strong> 하는 곳입니다.</p>
            <p class="des_txt">타임시트 승인 및 반려 처리를 할 수 있습니다.</p>
        </div>
        <!--//title//-->
        <!--타임시트목록-->
        <h4 class="timesheet_title">
            <span class="timesheet_name"><em>[<c:out value="${baseUserLoginInfo.deptNm}"></c:out>]</em></span>
            <span class="space01"><%--<a href="#" class="btn_s_type">직원선택</a> --%></span>
            <span class="space02" id="srchYearSelectTag">
            <%--<select class="date_select" title="년도선택">
                <option>2015년</option>
                <option>2015년</option>
                <option>2015년</option>
            </select> --%></span>
            <span class="space02" id="srchSMonthSelectTag"></span>
                ~
            <span class="space03" id="srchEMonthSelectTag"></span>
            <span><a href="javascript:fnObj.getTimesheetAll();" class="btn_s_type">기간조회</a></span>
            <span style="padding-left:8px;"><a href="javascript:fnObj.getTsAllThisWeek();" class="btn_s_type">지난주</a></span>
        </h4>

        <div class="timesheet_wrap">
        	<table class="tb_time_list" summary="타임시트 목록조회(기간, 총업무시간, 진행상태 안내)" >
            	<caption>타임시트 목록조회</caption>
                <colgroup>
                    <col width="" />
                    <col width="3%" />
                    <col width="7%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="12%" />
                    <col width="12%" />
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">기간</th>
                    <th scope="col"><%--<label><input type="checkbox" /><span class="blind">전체선택</span></label> --%></th>
                    <th scope="col">부서원</th>
                    <th scope="col">월</th>
                    <th scope="col">화</th>
                    <th scope="col">수</th>
                    <th scope="col">목</th>
                    <th scope="col">금</th>
                    <th scope="col" class="weekend_font"><font color=blue>토</font></th>
                    <th scope="col" class="weekend_font"><font color=red>일</font></th>
                    <th scope="col">합계</th>
                    <th scope="col">진행상태</th>
                </tr>
                </thead>
                <tbody></tbody>
			</table>
        </div>
        <div id="timesheet_cntnt" class="timesheet_wrap">
        	<table id="SGridTarget" class="tb_time_list" summary="타임시트 목록조회(기간, 총업무시간, 진행상태 안내)" >
            	<caption>타임시트 목록조회</caption>
                <colgroup>
                	<col width="" />
                	<col width="3%" />
                    <col width="7%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="6%" />
                    <col width="12%" />
                    <col width="12%" />
                </colgroup>
                <thead>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
        <p class="notice_script"><!-- * 회색처리된 부분은 마감되어 수정하실 수 없습니다. --></p>
        <!--//타임시트목록//-->

        <div style="padding-left:23.2%;">&nbsp;
        	<a id="btn_cmmt" href="javascript:fnObj.doApprove('checked','commit');" class="btn_finish_ok">선택승인</a>&nbsp;
            <a id="btn_rjct" href="javascript:fnObj.doApprove('checked','reject');" class="btn_no_finish">선택반려</a>
            &nbsp; * 선택한 건에 대한 '승인' 및 '반려' 처리
		</div>



        <!-- ========================================== 상세보기 :S ================================== -->
        <div id="dvOneWeekDtl" style="display:none;margin-top:30px;">
        	&nbsp;* 상세보기
        	<h5 id="tsCalYearWeekDtl" class="timesheet_date" style="max-width:968px;margin-top:3px!important;">상세보기</h5>
        	<table id="SGridTarget2" class="tb_time_input"  style="max-width:1000px;" summary="타임시트 상세조회(기간, 총업무시간, 진행상태 안내)" >
            	<caption>타임시트 상세조회</caption>
                <colgroup>
                	<col width="" />
                	<col width="25%" />
                    <col width="25%" />
                    <col width="8%" />
                    <col width="12%" />
                    <col width="17%" />
                </colgroup>
                <thead>
                	<tr>
                    <th scope="col">이름</th>
                    <th scope="col">업무</th>
                    <th scope="col">구분</th>
                    <th scope="col">시간</th>
                    <th scope="col">진행상태</th>
                    <th scope="col"></th>
                	</tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
        <!-- ========================================== 상세보기 :E ================================== -->



        <!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 개인보기 :S ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->

        <div id="divTimesheetInput" class="" style="display:none;"><!-- finish_timesheet -->
        	<span id="spanTimesheetInput" class="finish_mark" style="display:none;"><img src="../images/work/p_script_txt.png" alt="마감되어 수정 할 수 없습니다."></span>

        <h5 id="tsCalYearWeek" class="timesheet_date" style="max-width:1168px;">2015년 10월 4주차 <span>(10/19 ~ 10/25)</span></h5>
        <table id="SGridTarget3" class="tb_time_input" style="max-width:1200px;" summary="2015년 10월 4주차 (Project, Activity, 일주일간의 업무시간)" >
            <caption>2099년 01월 1주차 업무</caption>
            <colgroup>
                <col width="18%" />
                <col width="18%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">업무</th>
                    <th scope="col">구분</th>
                    <th scope="col"><span id="day1Header">10/12</span><em>(월)</em></th>
                    <th scope="col"><span id="day2Header">10/13</span><em>(화)</em></th>
                    <th scope="col"><span id="day3Header">10/14</span><em>(수)</em></th>
                    <th scope="col"><span id="day4Header">10/15</span><em>(목)</em></th>
                    <th scope="col"><span id="day5Header">10/16</span><em>(금)</em></th>
                    <th scope="col" class="weekend_font"><span id="day6Header">10/17</span><em>(<font color=blue>토</font>)</em></th>
                    <th scope="col" class="weekend_font"><span id="day7Header">10/18</span><em>(<font color=red>일</font>)</em></th>
                    <th scope="col">합계</th>
                </tr>
            </thead>
            <tbody>

            </tbody>
            <tfoot>

            	<%--
            	<tr id="trNewActTime0" class="tr_divide_line" style="background:#ffffff;">
                    <th class="txt_left" style="background:#f5f7f8;">
                    	<span id="pjtSelectTag0"></span>
					</th>
					<th class="txt_left" style="background:#f5f7f8;">
						<span id="actSelectTag0"></span><span style="display:inline-block;width:22%;text-align:right;"><a href="javascript:fnObj.addNewActTimeRow();" style="font-size:14px;"><i class="fa fa-plus-square" aria-hidden="true"></i></a></span>
					</th>
                    <td><input id="addActT10" type="text" onchange="fnObj.syncSum();" title="시간입력" /><span class="oriVal"></span></td>
                    <td><input id="addActT20" type="text" onchange="fnObj.syncSum();" title="시간입력" /><span class="oriVal"></span></td>
                    <td><input id="addActT30" type="text" onchange="fnObj.syncSum();" title="시간입력" /><span class="oriVal"></span></td>
                    <td><input id="addActT40" type="text" onchange="fnObj.syncSum();" title="시간입력" /><span class="oriVal"></span></td>
                    <td><input id="addActT50" type="text" onchange="fnObj.syncSum();" title="시간입력" /><span class="oriVal"></span></td>
                    <td><input id="addActT60" type="text" onchange="fnObj.syncSum();" title="시간입력" /><span class="oriVal"></span></td>
                    <td><input id="addActT70" type="text" onchange="fnObj.syncSum();" title="시간입력" /><span class="oriVal"></span></td>
                    <td><span id="addActTSum0" style="font-weight:normal;color:#4566bb;font-size:12px;">0</span></td>
                </tr> --%>

            	<tr id="trActTimeSum">
                	<th scope="row" rowspan="2">합계</th>
                	<th scope="row">Working</th>
                    <td><span id="colSumWork1"></span></td>
                    <td><span id="colSumWork2"></span></td>
                    <td><span id="colSumWork3"></span></td>
                    <td><span id="colSumWork4"></span></td>
                    <td><span id="colSumWork5"></span></td>
                    <td><span id="colSumWork6"></span></td>
                    <td><span id="colSumWork7"></span></td>
                    <td><span id="totSumWork" class="sum_result"></span></td>
                </tr>
                <tr>
                	<th scope="row">Overtime</th>
                    <td><span id="colSumOver1"></span></td>
                    <td><span id="colSumOver2"></span></td>
                    <td><span id="colSumOver3"></span></td>
                    <td><span id="colSumOver4"></span></td>
                    <td><span id="colSumOver5"></span></td>
                    <td><span id="colSumOver6"></span></td>
                    <td><span id="colSumOver7"></span></td>
                    <td><span id="totSumOver" class="sum_result"></span></td>
                </tr>
            </tfoot>
        </table>
        </div>

        <!-- 게시판 버튼 -->
        <!-- <div class="btn_baordZone2">
        	<a id="btn_sbmt" href="javascript:fnObj.doSubmit();" class="btn_blueblack" style="display:none;">승인요청</a>
            <a id="btn_updt" href="javascript:fnObj.doEdit();" class="btn_witheline" style="display:none;">수정</a>

            <a id="btn_sbca" href="javascript:fnObj.doCancelSbmt();" class="btn_blueblack" style="display:none;">요청취소</a>

            <a id="btn_save" href="javascript:fnObj.doSave();" class="btn_blueblack">저장</a>
            <a id="btn_canc" href="javascript:fnObj.doCancelEdit();" class="btn_witheline">취소</a>
        </div> -->
        <!--/ 게시판 버튼 /-->

        <!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 개인보기 :E ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->

    </section>


<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

var searchDate;							//검색할 기준일 (기본은..당일)

//한주의 날짜를 가지는 객체 (day1:'20150824', ..., day7:'20150830')
var dayObject = {};
//var dayNmObject = {'KOR':['월','화','수','목','금','토','일'], 'ENG':['MON','TUE','WED','THU','FRI','SAT','SUN']};	//요일객체

var g_calYear = '';						//선택한 타임시트 calYear  (년도)
var g_yearWeek = '';					//선택한 타임시트 yearWeek (년주차)
var	g_tsHeaderId = '';					//현재 보고있는 주간시트 id ... g_mode : "view", "update"


//공통코드 (외, 코드)
var codeYear;				//year
var codeMonth;				//month

var codeMyActivity;			//나의 activity (콤보용) 호출
var codeMyProject;			//나의 project  (콤보용) 호출

var g_addNewActTimeRowIdx = 0;	//추가한 row index ... (추가 삭제 반복하여 생기는 중복 id값을 방지하기 위해 사용하는 임시값)


var myModal = new AXModal();	// instance


var myGrid = new SGrid();		// instance		new sjs
var myGrid2 = new SGrid();		// instance		new sjs
var myGrid3 = new SGrid();		// instance		new sjs
//var myPaging = new SPaging();	// instance		new sjs
//var mySorting = new SSorting();	// instance		new sjs


//var curPageNo = 1;				//현재페이지번호
//var pageSize = 10;				//페이지크기(상수 설정)


var g_mode = "new";				//"new", "view", "update"


//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){

		//코드
		codeYear = [];		//년도
		var cYear = new Date().getFullYear();
		for(var i=0; i<4; i++){
			codeYear.push({'CD':cYear-2+i, 'NM':(cYear-2+i) + '년'});
		}

		codeMonth = [];		//월
		var cMonth = 1 + new Date().getMonth();
		for(var i=0; i<12; i++){
			codeMonth.push({'CD':i+1, 'NM':fillzero(i+1, 2) + '월'});
		}


		//나의 activity (콤보용) 호출
		codeMyActivity = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/project/getUserActivityListForTimesheet.do', {userId:'${baseUserLoginInfo.userId}',applyOrgId : '${baseUserLoginInfo.applyOrgId}'});
		codeMyActivity.unshift({pjtId:'', pjtNm:'선택', actId:'', actNm:'선택'});

		//나의 project (콤보용) 호출
		codeMyProject = new Array();
		var tmpVal = '-';
		for(var i=0; i<codeMyActivity.length; i++){
			if(tmpVal != codeMyActivity[i].pjtId){
				codeMyProject.push(codeMyActivity[i]);
				tmpVal = codeMyActivity[i].pjtId;
			}
		}
		//alert(JSON.stringify(codeMyActivity));


		//검색 년도
		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var srchYearSelectTag = createSelectTag('selSrchYear', codeYear, 'CD', 'NM', cYear, null, colorObj, null, 'date_select');	//select tag creator 함수 호출 (common.js)
		$("#srchYearSelectTag").html(srchYearSelectTag);
		//검색 시작월
		var srchSMonthSelectTag = createSelectTag('selSrchSMonth', codeMonth, 'CD', 'NM', 1, null, colorObj, null, 'date_select');	//select tag creator 함수 호출 (common.js)
		$("#srchSMonthSelectTag").html(srchSMonthSelectTag);
		//검색 종료월
		var srchEMonthSelectTag = createSelectTag('selSrchEMonth', codeMonth, 'CD', 'NM', cMonth, null, colorObj, null, 'date_select');	//select tag creator 함수 호출 (common.js)
		$("#srchEMonthSelectTag").html(srchEMonthSelectTag);


		//activity combo
		var actSelectTag0 = createSelectOptgroupTag('selActivity0', codeMyActivity, 'pjtId', 'pjtNm', 'actId', 'actNm', '', 'fnObj.changeActivity(this, 0)', colorObj, '75%', '');	//select tag creator 함수 호출 (common.js)
		$("#actSelectTag0").html(actSelectTag0);

		//project combo
		var pjtSelectTag0 = createSelectTag('selProject0', codeMyProject, 'pjtId', 'pjtNm', '', 'fnObj.changeProject(this, 0)', colorObj, '75%', '');	//select tag creator 함수 호출 (common.js)
		$("#pjtSelectTag0").html(pjtSelectTag0);



	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 설정 grid :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [

            {key:"calWeekInfo", formatter:function(obj){

            						if(obj.index>0 && obj.list[obj.index-1].week == obj.item.week) return '';	//이전 기간과 동일하면 안보여준다.

            						var termStr = '';
            						termStr = '<span><a href="javascript:fnObj.getTsOneWeek('+obj.index+');" class="btn_s_type" style="background:#CCCCCC;border:#CCCCCC solid 1px;height:18px;line-height:18px;padding:0 7;">상세보기</a></span> &nbsp;&nbsp;&nbsp;';

            						termStr += '<strong>' + obj.item.month + '월 ' + obj.item.week + '주차</strong> (' + obj.item.stDt + ' ~ ' + obj.item.edDt + ')';
            						var preWeek = new Date();
            						preWeek.setDate(preWeek.getDate() - 7);
            						if(obj.item.sDate <= preWeek.yyyy_mm_dd() && preWeek.yyyy_mm_dd() <= obj.item.tDate){	//현재 주에서는 승인요청 숨긴다
            							termStr += '<span style="font-size:11px!important;font-weight:bold!important;padding-left:20px;color:#5555FF!important;">지난주</span>';
            						}
            						if(obj.item.sDate <= new Date().yyyy_mm_dd() && new Date().yyyy_mm_dd() <= obj.item.tDate){	//현재 주에서는 승인요청 숨긴다
            							termStr += '<span style="font-size:11px!important;font-weight:bold!important;padding-left:20px;color:#995555!important;">이번주</span>';
            						}
            						return termStr;
            					}},
            {key:"chk",			formatter:function(obj){
            						if(obj.item.userId=='-1' || !(obj.item.open == 'O' && obj.item.status == 'REQUEST'))		//부서원 건이 아니거나, 요청건이 아니면
            							return "";		//"<input type='checkbox' name='mCheck' style='display:none;'>";					//체크박스는 숨긴다.
            						return ("<input type='checkbox' name='mCheck' value='" + obj.item.tsHeaderId + "' onclick='fnObj.setTimesheetInfo(this," + obj.item.projectId + ");' />");
            					}},
            {key:"userNm"		},
            {key:"monday",		formatter:function(obj){return (obj.value == 0? '':obj.value);}},
            {key:"tuesday",		formatter:function(obj){return (obj.value == 0? '':obj.value);}},
            {key:"wednesday",	formatter:function(obj){return (obj.value == 0? '':obj.value);}},
            {key:"thursday",	formatter:function(obj){return (obj.value == 0? '':obj.value);}},
            {key:"friday",		formatter:function(obj){return (obj.value == 0? '':obj.value);}},
            {key:"saturday",	formatter:function(obj){return (obj.value == 0? '':obj.value);}},
            {key:"sunday",		formatter:function(obj){return (obj.value == 0? '':obj.value);}},
            {key:"total",		formatter:function(obj){
            						var val = isEmpty(obj.value)?'-':obj.value;
            						if(obj.item.userId == '-1') val = '<font color=purple>' + val + '</font>';
									return val;
								}},
            {key:"statusNm",	formatter:function(obj){
            						var val = obj.value==null?'':obj.value;

            						if(obj.item.open == 'C') val = '<b><font color=silver>마감</font></b>';
            						else if(obj.item.open == 'W') val = '오픈전';
            						else val = '';		//obj.item.open == 'O'

            						if(obj.item.status == 'CLOSED'){
            							val = '<b><font color=silver>마감</font></b>';
            						}else if(obj.item.status != null){
	            						if(obj.item.open != 'O'){
            								val += '(<span class="state_txt">' + obj.value + '</span>)';
            							}else{
            								val = '<span class="state_txt">' + obj.value + '</span>';
            								if(obj.item.status == 'REQUEST') val = '<b>' + val + '</b>';
            							}

            						}else{		//obj.item.status == null	//데이터 없는 건(주 week)
            							if(obj.item.open == 'O')
            								val = '<span class="state_txt">대기</span>';
            							else if(obj.item.tsHeaderId == null){
            								val += '(<font color="#FF9999">미등록</font>)';
            							}
            						}

           							return val;
           						}},
           	{key:"finishClass",	formatter:function(obj){
        							if(obj.item.open == 'C' || obj.item.open == 'W' || obj.item.open == 'SUM' || obj.item.status == 'CLOSED'){
        								return 'finish_line';
        							}
        						}},
        	{key:"calWeekHeadStyle", formatter:function(obj){
            						if(obj.index>0 && obj.list[obj.index-1].week == obj.item.week) return 'border-top:0px;';	//이전 기간과 동일하면 안보여준다.
        						}},
        	{key:"calWeekTailStyle", formatter:function(obj){
            						if(obj.index>0 && obj.list[obj.index-1].week == obj.item.week) return 'border-top:1px dotted #DDDDDD;';	//이전 기간 과 동일하면
        						}},
        	{key:"calWeekBodyStyle", formatter:function(obj){
            						if(obj.item.userId == '-1') return 'border-top:1px dotted #DDDDDD;';							//합계 row 이면 선을 보여준다.
            						else if(obj.index>0 && obj.list[obj.index-1].week == obj.item.week) return 'border-top:0px;';	//이전 기간 과 동일하면 안보여준다.
            						else return '';
        						}},
        	{key:"calWeekCmmtStyle", formatter:function(obj){
        							if(obj.item.open == 'O' && obj.item.status == 'REQUEST')
        								return 'background:#7fbfec;border-top:1px solid #267ebc;border-bottom:1px solid #267ebc;border-left:1px solid #267ebc;';	//이전 기간 과 동일하면 안보여준다.
        						}},
        	{key:"calWeek1stTdClass", formatter:function(obj){
        							return 'tdRow' + obj.index;
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
					/* if(obj.c == 0){
						fnObj.getTsOneWeek(obj.index, obj.item);

					}else */
					/* if(obj.c > 0){
	            		fnObj.clickTimesheet(obj.index, obj.item);	//.tDate, obj.item.tsHeaderId, obj.item.calYear, obj.item.week);
	            	} */



	            }
	        }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr class="#[12]">';
    	rowHtmlStr +=	 '<td style="#[13] cursor:default;text-align:left;" class="#[17]">#[0]</td>';		//background:white;
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[1]</th>';
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[2]</td>';
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[3]</td>';
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[4]</td>';
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[5]</td>';
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[6]</td>';
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[7]</td>';
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[8]</td>';
    	rowHtmlStr +=	 '<td style="#[15] cursor:default;">#[9]</td>';
    	rowHtmlStr +=	 '<td style="#[14] cursor:default;"><strong>#[10]</strong></td>';
    	rowHtmlStr +=	 '<td style="#[14] #[16] cursor:default;">#[11]</td>';
        rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;

    	<%--
		<tr class="finish_line">
            <td><label><input type="checkbox" /><span class="blind">선택</span></label></td>
            <td>09월 1주차 (08/30~09/05)</td>
            <td>8</td>
            <td>8</td>
            <td>8</td>
            <td>8</td>
            <td>8</td>
            <td>4</td>
            <td>&nbsp;</td>
            <td><strong>44</strong></td>
            <td>마감완료</td>
        </tr>
		--%>


    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 grid :E ---------------------


    	//-------------------------- 그리드 설정 grid2 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj2 = {

    		targetID : "SGridTarget2",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [

            {key:"userNm"		, formatter:function(obj){
									if(obj.index>0 && obj.list[obj.index-1].userId == obj.item.userId){ return '';}	//이전 이름 과 동일하면 안보여준다.
            						else{
            							return '<span><a href="javascript:fnObj.clickTimesheetOneMan('+obj.index+');" class="btn_s_type" style="background:#CCCCCC;border:#CCCCCC solid 1px;height:18px;line-height:18px;padding:0 7;">상세</a></span> &nbsp;&nbsp;' + obj.value;            						}
								}},
            {key:"pjtNm"		},
            {key:"actNm"		},

            {key:"workTime",	formatter:function(obj){return '<font color="purple">' + (obj.value==null?'':obj.value) + '</font></b>';}},		//(obj.value == 0? '':obj.value);}},

            {key:"statusNm",	formatter:function(obj){
            						var val = obj.value==null?'':obj.value;

            						if(obj.item.open == 'C') val = '마감';
            						else if(obj.item.open == 'W') val = '오픈전';
            						else val = '';		//obj.item.open == 'O'

            						if(obj.item.status == 'CLOSED'){
            							val = '마감';
            						}else if(obj.item.status != null){
	            						if(obj.item.open != 'O'){
            								val += '(<span class="state_txt">' + obj.value + '</span>)';
            							}else{
            								val = '<span class="state_txt">' + obj.value + '</span>';
            							}

            						}else{		//obj.item.status == null	//데이터 없는 건(주 week)
            							if(obj.item.open == 'O')
            								val = '<span class="state_txt">대기</span>';
            							else if(obj.item.tsHeaderId == null){
            								val += '<font color="#FF9999">미등록</font>';
            							}
            						}


            						if(obj.index>0 && obj.list[obj.index-1].userId == obj.item.userId) return '';	//이전 이름 과 동일하면 안보여준다.
									else return val;
           						}},
           	{key:"btn",			formatter:function(obj){
					           		if(obj.index>0 && obj.list[obj.index-1].userId == obj.item.userId){ return '';	//이전 이름 과 동일하면 안보여준다.
					           		}else{
					           			if(obj.item.status == 'REQUEST'){
					           				return '<a id="btn_cmmt" href="javascript:fnObj.doApprove(\'direct\', \'commit\', '+ obj.item.tsHeaderId +');" class="btn_finish_ok">승인</a>&nbsp; <a id="btn_rjct" href="javascript:fnObj.doApprove(\'direct\', \'reject\');" class="btn_no_finish">반려</a>';
					           			}else{ return '';}
					           		}
        						}},
        	{key:"calWeekHeadStyle", formatter:function(obj){
            						if(obj.index>0 && obj.list[obj.index-1].userId == obj.item.userId) return 'border-top:0px;';	//이전 이름 과 동일하면 안보여준다.
        						}},
        	{key:"calWeekTailStyle", formatter:function(obj){
            						if(obj.index>0 && obj.list[obj.index-1].userId == obj.item.userId) return 'border-top:1px dotted #DDDDDD;';	//이전 이름 과 동일하면
        						}},
        	{key:"calWeekBodyStyle", formatter:function(obj){
            						if(obj.item.userId == '-1') return 'border-top:1px dotted #DDDDDD;';							//합계 row 이면 선을 보여준다.
            						else if(obj.index>0 && obj.list[obj.index-1].userId == obj.item.userId) return 'border-top:0px;';	//이전 기간 과 동일하면 안보여준다.
            						else return '';
        						}},
        	{key:"calWeek1stTdClass", formatter:function(obj){
        							return 'tdRowMan' + obj.index;
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
	            	/* if(obj.c > 0){
	            		fnObj.clickTimesheet(obj.index, obj.item);	//.tDate, obj.item.tsHeaderId, obj.item.calYear, obj.item.week);
	            	} */
	            }
	        }

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr2 = '<tr>';
    	rowHtmlStr2 +=	 '<td style="#[6]" class="#[9]">#[0]</th>';
    	rowHtmlStr2 +=	 '<td style="#[8] text-align:left;">#[1]</td>';							//background:#f5f7f8;
    	rowHtmlStr2 +=	 '<td style="#[8] text-align:left;">#[2]</td>';							//background:#f5f7f8;
    	rowHtmlStr2 +=	 '<td style="#[8] "><strong>#[3]</strong></td>';						//background:#fff0f0;
    	rowHtmlStr2 +=	 '<td style="#[8]">#[4]</td>';
    	rowHtmlStr2 +=	 '<td style="#[8]">#[5]</td>';
        rowHtmlStr2 +=	 '</tr>';
    	configObj2.rowHtmlStr = rowHtmlStr2;


    	myGrid2.setConfig(configObj2);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 grid2 :E ----------------------------


    	//-------------------------- 그리드 설정 grid3 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj3 = {

    		targetID : "SGridTarget3",		//그리드의 id

    		//그리드 컬럼 정보
    		colGroup : [
            {key:"pjtNm"			},
            {key:"actNm"			},
            {key:"tmDay1",			formatter:function(obj){return ('<input id="actT1' + obj.index + '" type="text" value="' + obj.value + '" title="시간입력" onchange="fnObj.syncActTime(this, 1, ' + obj.index + ');" /><span class="oriVal">' + obj.item.oriTmDay1 + '</span>');}},
            {key:"tmDay2",			formatter:function(obj){return ('<input id="actT2' + obj.index + '" type="text" value="' + obj.value + '" title="시간입력" onchange="fnObj.syncActTime(this, 2, ' + obj.index + ');" /><span class="oriVal">' + obj.item.oriTmDay2 + '</span>');}},
            {key:"tmDay3",			formatter:function(obj){return ('<input id="actT3' + obj.index + '" type="text" value="' + obj.value + '" title="시간입력" onchange="fnObj.syncActTime(this, 3, ' + obj.index + ');" /><span class="oriVal">' + obj.item.oriTmDay3 + '</span>');}},
            {key:"tmDay4",			formatter:function(obj){return ('<input id="actT4' + obj.index + '" type="text" value="' + obj.value + '" title="시간입력" onchange="fnObj.syncActTime(this, 4, ' + obj.index + ');" /><span class="oriVal">' + obj.item.oriTmDay4 + '</span>');}},
            {key:"tmDay5",			formatter:function(obj){return ('<input id="actT5' + obj.index + '" type="text" value="' + obj.value + '" title="시간입력" onchange="fnObj.syncActTime(this, 5, ' + obj.index + ');" /><span class="oriVal">' + obj.item.oriTmDay5 + '</span>');}},
            {key:"tmDay6",			formatter:function(obj){return ('<input id="actT6' + obj.index + '" type="text" value="' + obj.value + '" title="시간입력" onchange="fnObj.syncActTime(this, 6, ' + obj.index + ');" /><span class="oriVal">' + obj.item.oriTmDay6 + '</span>');}},
            {key:"tmDay7",			formatter:function(obj){return ('<input id="actT7' + obj.index + '" type="text" value="' + obj.value + '" title="시간입력" onchange="fnObj.syncActTime(this, 7, ' + obj.index + ');" /><span class="oriVal">' + obj.item.oriTmDay7 + '</span>');}},
            {key:"tmWeek",			formatter:function(obj){
            							var sum = 0;
            							for(var i=1; i<=7; i++){
            								sum += 1 * obj.item['tmDay'+i];
            							}
            							return '<span id="tmWeek' + obj.index + '" class="sum_result" style="color:purple;font-weight:bold;">' + sum + '</span>';

            							//return '<span id="tmWeek' + obj.index + '" class="sum_result">' + obj.value + '</span>';
            						}}
            ]

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr3 = '<tr>';
    	rowHtmlStr3 +=	 '<th scope="row">#[0]</th>';
    	rowHtmlStr3 +=	 '<th class="txt_left">#[1]</td>';
    	rowHtmlStr3 +=	 '<td>#[2]</td>';
    	rowHtmlStr3 +=	 '<td>#[3]</td>';
    	rowHtmlStr3 +=	 '<td>#[4]</td>';
    	rowHtmlStr3 +=	 '<td>#[5]</td>';
    	rowHtmlStr3 +=	 '<td>#[6]</td>';
    	rowHtmlStr3 +=	 '<td>#[7]</td>';
    	rowHtmlStr3 +=	 '<td>#[8]</td>';
    	rowHtmlStr3 +=	 '<td>#[9]</td>';		// style="background:#fff0f0;"
        rowHtmlStr3 +=	 '</tr>';
    	configObj3.rowHtmlStr = rowHtmlStr3;

    	<%--
		<tr>
            <th scope="row">IB업무</th>
            <th class="txt_left">meeting</th>
            <td><input type="text" value="2" title="시간입력" /><span class="oriVal">2.5</span></td>
            <td><input type="text" title="시간입력" /></td>
            <td><input type="text" value="2" title="시간입력" /></td>
            <td><input type="text" value="3" title="시간입력" /></td>
            <td><input type="text" title="시간입력" /></td>
            <td><input type="text" title="시간입력" /></td>
            <td><input type="text" title="시간입력" /></td>
            <td><span class="sum_result">7</span></td>
        </tr>
		--%>


    	myGrid3.setConfig(configObj3);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 grid2 :E ---------------------


		//-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",
    		//openModalID:"kkkkk",
    		width:850,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: true,
    		onclose: function(){
    			//toast.push("모달 close");

				//if(window[myModal.winID].isSaved == false){		//저장을 안한상태로 창이 닫힐때, 이미 업로드한 파일은 삭제
    			//	window[myModal.winID].fnObj.deleteFile();	//팝업창 내 파일삭제함수 호출.
    			//}

				fnObj.resetSelect();	//타임블럭 선택 초기화

    		}
    	});
    	//-------------------------- 모달창 :E -------------------------


    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

    //전체 타임시트
    getTimesheetAll: function(preWeek){

    	var url = contextRoot + "/work/getTimesheetInDept.do";
    	var param = {
    			deptId: '${baseUserLoginInfo.deptId}',
    			year: $('select[name=selSrchYear]').val(),
    			stMonth: $('select[name=selSrchSMonth]').val(),
    			edMonth: $('select[name=selSrchEMonth]').val(),
    			sDate: (preWeek=='PRE_WEEK'?new Date().yyyy_mm_dd():'')
    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

			//alert(JSON.stringify(list));
    		//return;


    		//가져온 json 데이터를 조작하여 합계 row 를 추가해준다.	...새로운 배열객체로

    		var obj = {week:'', tsHeaderId:'-1', userId:'-1', userNm:'<b>합계</b>', monday:0, tuesday:0, wednesday:0, thursday:0, friday:0, saturday:0, sunday:0, total:0, open:''};
    		var nList = [];
    		for(var i=0; i<cnt; i++){

    			obj.week = list[i].week;
    			if(list[i].tsHeaderId != null){
    				obj.monday 		+= 1 * list[i].monday;
    				obj.tuesday 	+= 1 * list[i].tuesday;
    				obj.wednesday 	+= 1 * list[i].wednesday;
    				obj.thursday 	+= 1 * list[i].thursday;
    				obj.friday 		+= 1 * list[i].friday;
    				obj.saturday 	+= 1 * list[i].saturday;
    				obj.sunday 		+= 1 * list[i].sunday;
    				obj.total 		+= 1 * list[i].total;
    			}

    			//new array object 에 copy
    			nList.push(list[i]);


    			if(i==cnt-1 || (i<cnt-1 && list[i+1].week != list[i].week)){
    				nList.push(obj);	//list 에 add
    				if(list[i].open == 'C') obj.open = 'SUM';
    				//new obj
    				obj = {week:'', tsHeaderId:'-1', userId:'-1', userNm:'<b>합계</b>', monday:0, tuesday:0, wednesday:0, thursday:0, friday:0, saturday:0, sunday:0, total:0, open:''};	//new object 초기화
    			}
    		}



    		myGrid.setGridData({list:nList});		//그리드 데이터 세팅

    		//스크롤 제일 아래로
    		$("#timesheet_cntnt").scrollTop($("#timesheet_cntnt")[0].scrollHeight);


    		/* if(oriRowIdx == null){

    			//지난주 row index 찾기
    			var lastWkIdx = -1;		//지난주 index
    			var srchDt = new Date();
    			srchDt.setDate(new Date().getDate() - 7);	//일주일 전일을 기준일로
    			for(var i=list.length-1;i>=0;i--){
    				if(list[i].sDate <= srchDt.yyyy_mm_dd() && srchDt.yyyy_mm_dd() <= list[i].tDate){		//전주에 해당하면
    					lastWkIdx = i;
    				}
    			}


    			if(lastWkIdx > -1){
    				fnObj.clickTimesheet(lastWkIdx, list[lastWkIdx]);				//지난주 건 클릭
    			}else{
    				fnObj.clickTimesheet(list.length-1, list[list.length-1]);		//마지막 건 클릭
    			}

    		}else{

    			fnObj.clickTimesheet(oriRowIdx, list[oriRowIdx]);		//저장 전 선택되어 있던 건 클릭
    		} */

    	};

    	commonAjax("POST", url, param, callback);

    },


    //지난주
    getTsAllThisWeek: function(){
    	//var cdYr = codeYear.length;
    	$('#selSrchYear').val(new Date().getFullYear());		//codeYear[cdYr-1].CD

    	$('#selSrchSMonth').val(1);
    	$('#selSrchEMonth').val(new Date().getMonth() + 1);

    	fnObj.getTimesheetAll('PRE_WEEK');		//조회	... 지난주옵션 'PRE_WEEK'
    },


    //상세보기 (선택한 주간의)
    getTsOneWeek: function(rIdx){

    	var list = myGrid.getList();
    	var week = list[rIdx].week;


    	var userIdList = '';				//선택한 주간의 부서원 id 리스트		userId 리스트
    	var tsHeaderIdList = '';			//선택한 주간의 타임시트 id 리스트		tsHeaderId 리스트
    	//userIdList, tsHeaderIdList 생성
		for(var i=0; i<list.length; i++){
			if(week == list[i].week){						//해당 주간의

				//부서원 id 를 모아 string 으로 만들어준다.
				if(userIdList.length>0){
					userIdList += ',';
				}
				userIdList += list[i].userId;				//추가해준다.


				//타임시트 id 를 모아 string 으로 만들어준다.
				if(list[i].tsHeaderId > 0){					//타임시트가 존재하는 row 면
					if(tsHeaderIdList.length>0){
						tsHeaderIdList += ',';
					}
					tsHeaderIdList += list[i].tsHeaderId;	//추가해준다.
				}
			}
		}//for


		var url = contextRoot + "/work/getTsOneWeekInDept.do";
    	var param = {
    			userIdList		: '(' + userIdList + ')',
    			tsHeaderIdList	: '(' + (tsHeaderIdList==''?'\'\'':tsHeaderIdList) + ')'
    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

			//alert(JSON.stringify(list));
    		//return;

    		$('#dvOneWeekDtl').show();				//한주상세 그리드 보이기
    		$('#divTimesheetInput').hide();			//한주상세 개인 보기는 숨긴다(앞서 열려있는게 있다면)

    		myGrid2.setGridData({list:list});		//그리드 데이터 세팅

    		var item = myGrid.getList()[rIdx];		//선택 row data

    		searchDate = new Date(item.tDate);    	//기준일세팅
    		fnObj.setDayObject();					//기준 검색일의 한주간 날짜 객체 세팅.(dayObject)

        	//----- 상단 주간 날짜 세팅 :S -----
        	var tsCalYearWeek = '';
        	tsCalYearWeek += item.month + '월 <font color=purple>' + item.week + '주차</font> <span>(';
        	tsCalYearWeek += dayObject['day1'].substring(4,6) * 1 + '/' + dayObject['day1'].substring(6,8) * 1;
        	tsCalYearWeek += ' ~ ';
        	tsCalYearWeek += dayObject['day7'].substring(4,6) * 1 + '/' + dayObject['day7'].substring(6,8) * 1;
        	tsCalYearWeek += ')</span>';
    		$('#tsCalYearWeekDtl').html(tsCalYearWeek);			//2015년 10월 4주차 <span>(10/19 ~ 10/25)</span>
    		//----- 상단 주간 날짜 세팅 :E -----


    		//선택주 highlight style
    		$('.tsOneWeek').removeClass('tsOneWeek');	//init
    		$('.tdRow'+rIdx).addClass('tsOneWeek');		//class 주기


    		/*
    		//가져온 json 데이터를 조작하여 합계 row 를 추가해준다.	...새로운 배열객체로

    		var obj = {week:'', userId:'-1', userNm:'<b>합계</b>', monday:0, tuesday:0, wednesday:0, thursday:0,	friday:0, saturday:0, sunday:0,	total:0};
    		var nList = [];
    		for(var i=0; i<cnt; i++){

    			obj.week = list[i].week;
    			if(list[i].tsHeaderId != null){
    				obj.monday 		+= 1 * list[i].monday;
    				obj.tuesday 	+= 1 * list[i].tuesday;
    				obj.wednesday 	+= 1 * list[i].wednesday;
    				obj.thursday 	+= 1 * list[i].thursday;
    				obj.friday 		+= 1 * list[i].friday;
    				obj.saturday 	+= 1 * list[i].saturday;
    				obj.sunday 		+= 1 * list[i].sunday;
    				obj.total 		+= 1 * list[i].total;
    			}

    			//new array object 에 copy
    			nList.push(list[i]);


    			if(i==cnt-1 || (i<cnt-1 && list[i+1].week != list[i].week)){
    				nList.push(obj);	//list 에 add
    				obj = {week:'', userId:'-1', userNm:'<b>합계</b>', monday:0, tuesday:0, wednesday:0, thursday:0,	friday:0, saturday:0, sunday:0,	total:0};	//new object 초기화
    			}
    		}



    		myGrid.setGridData({list:nList});		//그리드 데이터 세팅

    		//스크롤 제일 아래로
    		$("#timesheet_cntnt").scrollTop($("#timesheet_cntnt")[0].scrollHeight);
 			*/

    	};

    	commonAjax("POST", url, param, callback);
    },


    //타임시트 한건 클릭
    clickTimesheet: function(rIdx, item){		//tDate, tsHeaderId, calYear, week){
    	$('input[name=mCheck]:checked').prop('checked', false);		//체크 모두 해제
    	$('input[name=mCheck]')[rIdx].checked = true;				//해당 row checkbox check!
    	myGrid.setSelectRow(rIdx);									//행 선택

    	fnObj.resetNewActTimeRow();		//추가 row 입력 행들 초기화

    	g_calYear = item.calYear;		//선택한 타임시트 calYear  (년도)
    	g_yearWeek = item.week;			//선택한 타임시트 yearWeek (년주차)


    	fnObj.doSearchWeek(item);		//.tDate, item.tsHeaderId);
    },


  	//타임시트 개인 한건 클릭(상세보기 > 상세)
    clickTimesheetOneMan: function(rIdx){		//tDate, tsHeaderId, calYear, week){
    	/*
    	$('input[name=mCheck]:checked').prop('checked', false);		//체크 모두 해제
    	$('input[name=mCheck]')[rIdx].checked = true;				//해당 row checkbox check!
    	myGrid.setSelectRow(rIdx);									//행 선택
    	 */

    	//선택건 highlight style
 		$('.tsOneWeekMan').removeClass('tsOneWeekMan');	//init
 		$('.tdRowMan'+rIdx).addClass('tsOneWeekMan');		//class 주기


    	var item = myGrid2.getList()[rIdx];

    	fnObj.resetNewActTimeRow();		//추가 row 입력 행들 초기화

    	g_calYear = item.calYear;		//선택한 타임시트 calYear  (년도)
    	g_yearWeek = item.week;			//선택한 타임시트 yearWeek (년주차)


    	fnObj.doSearchWeek(item);		//.tDate, item.tsHeaderId);
    },


    //project select change
    changeProject: function(th, idx){
    	var pjtId = $(th).val();

    	var newObj = null;
    	if(pjtId == ''){
    		newObj = codeMyActivity;

    	}else{
    		newObj = codeMyActivity.filter(function(value, index){
        		if(value.pjtId == pjtId) return true;
        	});
    		newObj.unshift({pjtId:'', pjtNm:'선택', actId:'', actNm:'선택'});
    	}


    	//activity combo	재생성
    	//var callbackFnStr = (pjtId == ''? 'fnObj.changeActivity(this,' + idx + ')' : '');		//프로젝트가 선택안된 상태일때만 activity select tag 에 이벤트 함수 바인딩
    	var callbackFnStr = 'fnObj.changeActivity(this,' + idx + ')';
		var actSelectTag = createSelectOptgroupTag('selActivity'+idx, newObj, 'pjtId', 'pjtNm', 'actId', 'actNm', '', callbackFnStr, {}, '75%', '');	//select tag creator 함수 호출 (common.js)
		$("#actSelectTag" + idx).html(actSelectTag);

    },


  	//activity select change
    changeActivity: function(th, idx){

    	//이미 리스트에 존재하는지 체크 :S --------------------------
    	if(!isEmpty(th.value)){		//'선택' 외의 값을 선택했을때
    		//grid data check
        	if(fnObj.isExistActivity(th)){
        		alert('이미 리스트에 존재합니다!\n\n - ' + $(th).find('option[value=' + th.value + ']').text());
        		$(th).val('');
        		return;
        	}
        	//new add check
        	var newList = $('select[id^=selActivity]');
        	for(var i=0; i<newList.length; i++){
        		if(newList[i].id != ('selActivity'+idx) && newList[i].value == th.value){
        			alert('이미 리스트에 존재합니다!\n\n - ' + $(th).find('option[value=' + th.value + ']').text());
            		$(th).val('');
            		return;
        		}
        	}
    	}
    	//이미 리스트에 존재하는지 체크 :E --------------------------


    	var actId = $(th).val();

    	var pjtId = getRowObjectWithValue(codeMyActivity, 'actId', actId)['pjtId'];

    	$('#selProject' + idx).val(pjtId);


    	/*	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 바서 위에 부분에 이벤트 재귀현상이 발생하면 하단 으로 대체(재생성 방법)
    	//activity combo	재생성
		var pjtSelectTag = createSelectOptgroupTag('selProject'+idx, codeMyProject, 'pjtId', 'pjtNm', pjtId, 'fnObj.changeActivity(' + idx + ')', {}, '75%', '');	//select tag creator 함수 호출 (common.js)
		$("#pjtSelectTag" + idx).html(pjtSelectTag);
    	*/
    },


    //존재하는 activity 인지 체크
    isExistActivity: function(th){
    	//grid list check
    	var list = myGrid3.getList();
    	for(var i=0; i<list.length; i++){
    		if(list[i].actId == th.value) return true;
    	}

    	return false;
    },


    //신규 row 추가
    addNewActTimeRow: function(){

    	g_addNewActTimeRowIdx ++;		//index 추가	... global variable.

    	//var idx = $("tr[id^=trNewActTime]").length;		//추가할 index
    	var idx = g_addNewActTimeRowIdx;


    	var rowStr = '';
    	rowStr += '<tr id="trNewActTime' + idx + '" class="tr_divide_line" style="background:#ffffff;">';
    	rowStr += '<th class="txt_left" style="background:#f5f7f8;">';
    	rowStr += '<span id="pjtSelectTag' + idx + '"></span>';
    	rowStr += '</th>';
    	rowStr += '<th class="txt_left" style="background:#f5f7f8;">';
    	rowStr += '<span id="actSelectTag' + idx + '"></span>';
    	rowStr += '<span style="display:inline-block;width:22%;text-align:right;"><a href="javascript:fnObj.delNewActTimeRow(' + idx + ');" style="font-size:14px;"><i class="fa fa-minus-square" aria-hidden="true"></i></a></span>';
    	rowStr += '</th>';

    	for(var i=1; i<=7; i++){
    		rowStr += '<td><input id="addActT' + i + idx + '" onchange="fnObj.syncSum();" type="text" title="시간입력" /><span class="oriVal"></span></td>';
    	}

    	rowStr += '<td><span id="addActTSum' + idx + '" style="font-weight:normal;color:#4566bb;font-size:12px;">0</span></td>';
    	rowStr += '</tr>';

    	$(rowStr).insertBefore('#trActTimeSum');



    	///////// select tag create
    	//activity combo
		var actSelectTag = createSelectOptgroupTag('selActivity'+idx, codeMyActivity, 'pjtId', 'pjtNm', 'actId', 'actNm', '', 'fnObj.changeActivity(this, ' + idx + ')', {}, '75%', '');	//select tag creator 함수 호출 (common.js)
		$("#actSelectTag" + idx).html(actSelectTag);

		//project combo
		var pjtSelectTag = createSelectTag('selProject'+idx, codeMyProject, 'pjtId', 'pjtNm', '', 'fnObj.changeProject(this, ' + idx + ')', {}, '75%', '');	//select tag creator 함수 호출 (common.js)
		$("#pjtSelectTag" + idx).html(pjtSelectTag);


    	<%--
    	<tr id="trNewActTime0" class="tr_divide_line" style="background:#ffffff;">
	        <th class="txt_left" style="background:#f5f7f8;">
	        	<span id="pjtSelectTag0"></span>
			</th>
			<th class="txt_left" style="background:#f5f7f8;">
				<span id="actSelectTag0"></span>
	            <span style="display:inline-block;width:22%;text-align:right;"><a href="javascript:fnObj.addNewActTimeRow();" class="btn_ac_add"><em>추가</em></a></span>
			</th>
	        <td><input type="text" title="시간입력" /><span class="oriVal"></span></td>
	        <td><input type="text" title="시간입력" /><span class="oriVal"></span></td>
	        <td><input type="text" title="시간입력" /><span class="oriVal"></span></td>
	        <td><input type="text" title="시간입력" /><span class="oriVal"></span></td>
	        <td><input type="text" title="시간입력" /><span class="oriVal"></span></td>
	        <td><input type="text" title="시간입력" /><span class="oriVal"></span></td>
	        <td><input type="text" title="시간입력" /><span class="oriVal"></span></td>
	        <td><span style="font-weight:normal;color:#4566bb;font-size:12px;">0</span></td>
	    </tr>
    	--%>
    },


  	//신규 row 삭제
    delNewActTimeRow: function(idx){
    	$('#trNewActTime' + idx).remove();		//삭제

    	fnObj.syncSum();		//sync sum
    },


  	//신규 row 리셋
    resetNewActTimeRow: function(){

    	var newActTr = $('tr[id^=trNewActTime]');
    	for(var i=1; i<newActTr.length; i++){	//기본 추가 row(i==0) 를 제외하고  (i>0)
    		$(newActTr[i]).remove();			//삭제
    	}

    	$('select[id=selActivity0]').val('');		//project  선택 초기화
    	$('select[id=selProject0]').val('');		//activity 선택 초기화

    	for(var i=1; i<=7; i++){
    		$('input[id^=addActT'+i+']').val('');	//시간입력란 초기화
    	}

    },


  	//개인 한주간 상세
    doSearchWeek: function(item){		//tDate, tsHeaderId){

    	//개인 한주간 상세 그리드 보이기
    	$('#divTimesheetInput').show();


    	/*
    	//기준 검색일 세팅			global variable
    	if(item.tDate == null){
    		searchDate = new Date();
    		searchDate.setDate(new Date().getDate() - 7);	//일주일 전일을 기준일로

    	}else{
    		searchDate = new Date(item.tDate);
    	}

    	fnObj.setDayObject();			//기준 검색일의 한주간 날짜 객체 세팅.
 		*/
    	g_tsHeaderId = item.tsHeaderId;		//현재 보고있는 주간시트 id 세팅 ... g_mode : "view", "update"			■■■	global variable ■■■


    	//----- 상단 주간 날짜 세팅 :S -----
    	/* var tsCalYearWeek = '';
    	tsCalYearWeek += item.calYear + '년 ' + item.month + '월 <font color=purple>' + item.week + '주차</font> <span>(';
    	tsCalYearWeek += dayObject['day1'].substring(4,6) * 1 + '/' + dayObject['day1'].substring(6,8) * 1;
    	tsCalYearWeek += ' ~ ';
    	tsCalYearWeek += dayObject['day7'].substring(4,6) * 1 + '/' + dayObject['day7'].substring(6,8) * 1;
    	tsCalYearWeek += ')</span>';
    	$('#tsCalYearWeek').html(tsCalYearWeek);			//2015년 10월 4주차 <span>(10/19 ~ 10/25)</span>
    	 */

    	$('#tsCalYearWeek').html('<font style="font-weight:normal;">' + item.userNm + '&nbsp;&nbsp;의&nbsp;</font>&nbsp;&nbsp;&nbsp;' + $('#tsCalYearWeekDtl').html());			//2015년 10월 4주차 <span>(10/19 ~ 10/25)</span>

    	for(var i=1; i<=7; i++){
    		$('#day'+i+'Header').html(dayObject['day'+i].substring(4,6) * 1 + '/' + dayObject['day'+i].substring(6,8) * 1);		//요일오른쪽 날짜 7개 세팅
    	}
    	//----- 상단 주간 날짜 세팅 :S -----


    	//----- 업무 시간 불러오기 :S ------

    	if(!isEmpty(g_tsHeaderId)){    		//모드 ... view
	    	g_mode = 'view';				//view 모드 세팅					■■■	global variable ■■■

    		fnObj.getTimesheetInfo();		//선택한 타임시트 불러오기

    	}else if(item.open == 'C' || item.open == 'W'){		//데이터 없지만 마감된 주
    		g_mode = 'view';				//view 모드 세팅					■■■	global variable ■■■

    		myGrid3.setGridData({list:[]});	//그리드 데이터 세팅
    		fnObj.syncSum();				//합계 연산
    		fnObj.setInputMode();			//입력 모드 에 따른 입력란 세팅 (g_mode)

    	}else{    							//모드 ... new
    		g_mode = 'new';					//new 모드 세팅					■■■	global variable ■■■

    		fnObj.getWorkInfo();			//업무정보를 세팅
    	}

    },


    //날짜 세팅
    setDayObject: function(){
    	dayObject = fnObj.getWeekDate(searchDate);
    },


  	//업무정보를 세팅
    getWorkInfo: function(){

    	var url = contextRoot + "/work/getMyActTime.do";
    	var param = {
    			userId		: '${baseUserLoginInfo.userId}',
    			startDate	: dayObject.day1,
    			endDate		: dayObject.day7
    	};


    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON


    		//---------------- activity 시간 표시 :S ------------------
    		// grid data 생성
    		var gridData = [];
    		var obj = null;
    		var tmpActId = '';
    		for(var i=0; i<list.length; i++){
    			if(tmpActId != list[i].actId){		//새로운 row object 생성
    				obj = {
    						tsHeaderId : '',
    						pjtId : list[i].pjtId,
    						pjtNm : list[i].pjtNm,
    						actId : list[i].actId,
    						actNm : list[i].actNm,
    						tmDay1 : '', tmDay2 : '', tmDay3 : '', tmDay4 : '', tmDay5 : '', tmDay6 : '', tmDay7 : '',
    						oriTmDay1 : '', oriTmDay2 : '', oriTmDay3 : '', oriTmDay4 : '', oriTmDay5 : '', oriTmDay6 : '', oriTmDay7 : '',
    						tmWeek: ''
    				};

					gridData.push(obj);
    			}

    			//해당일에 데이터 세팅
    			for(var k=1; k<=7; k++){
    				if(list[i].tDate == dayObject['day'+k]){
    					obj['oriTmDay'+k] = list[i].hr;
    				}
    			}

    			tmpActId = list[i].actId;
    		}

    		myGrid3.setGridData({list:gridData});		//그리드 데이터 세팅
    		//---------------- activity 시간 표시 :E ------------------


    		//신규 등록일 경우에는 디폴트값 세팅함수 호출
    		if(g_mode == 'new'){
    			fnObj.setDefaultTm();		//orTmDay(N) to tmDay(N)
    		}


    		fnObj.syncSum();				//합계 연산


    		fnObj.setInputMode();			//입력 모드 에 따른 입력란 세팅 (g_mode)
    	};

    	commonAjax("POST", url, param, callback);

    },//end getWorkInfo


  	//타임시트 정보를 세팅
    getTimesheetInfo: function(){

    	var url = contextRoot + "/work/getTimesheetInfo.do";
    	var param = {
    			tsHeaderId	: g_tsHeaderId,

    			userId		: '${baseUserLoginInfo.userId}',
    			startDate	: dayObject.day1,
    			endDate		: dayObject.day7
    	};


    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		//alert(JSON.stringify(list));
    		//return;

    		//---------------- activity 시간 표시 :S ------------------
    		// grid data 생성
    		var gridData = [];
    		var obj = null;
    		var tmpActId = '';
    		for(var i=0; i<list.length; i++){
    			if(tmpActId != list[i].actId){		//새로운 row object 생성
    				obj = {
    						tsHeaderId : '',
    						pjtId : list[i].pjtId,
    						pjtNm : list[i].pjtNm,
    						actId : list[i].actId,
    						actNm : list[i].actNm,
    						tmDay1 : '', tmDay2 : '', tmDay3 : '', tmDay4 : '', tmDay5 : '', tmDay6 : '', tmDay7 : '',
    						oriTmDay1 : '', oriTmDay2 : '', oriTmDay3 : '', oriTmDay4 : '', oriTmDay5 : '', oriTmDay6 : '', oriTmDay7 : '',
    						tmWeek: ''
    				};

					gridData.push(obj);
    			}

    			//해당일에 데이터 세팅
    			for(var k=1; k<=7; k++){
    				if(list[i].tDate == dayObject['day'+k]){
    					obj['tmDay'+k] = list[i].tmDay;
    					obj['oriTmDay'+k] = list[i].oriTmDay;
    				}
    			}

    			tmpActId = list[i].actId;
    		}

    		myGrid3.setGridData({list:gridData});		//그리드 데이터 세팅
    		//---------------- activity 시간 표시 :E ------------------


    		fnObj.syncSum();				//합계 연산


    		fnObj.setInputMode();			//입력 모드 에 따른 입력란 세팅 (g_mode)
    	};

    	commonAjax("POST", url, param, callback);

    },//end getWorkInfo


  	//신규 등록일 경우에는 디폴트값 세팅함수 호출
	setDefaultTm: function(){		//orTmDay(N) to tmDay(N)
		var list = myGrid3.getList();
		for(var i=0; i<list.length; i++){
			for(var k=1; k<=7; k++){
				list[i]['tmDay'+k] = list[i]['oriTmDay'+k];
			}
		}

		myGrid3.refresh();
    },


    //숫자 변경 이벤트 리스너
    syncActTime: function(th, cNo, rIdx){		//cNo: column no, rIdx: row index
    	var list = myGrid3.getList();
    	//row sync
    	/* var rsum = 0;
    	for(var i=1; i<=7; i++){
    		rsum += 1 * $('#actT' + i + rIdx).val();
    	} */

    	list[rIdx]['tmDay'+cNo] = isEmpty(th.value)?'':1*th.value;

    	myGrid3.refresh();		//grid sync

    	fnObj.syncSum();		//sync sum
    },


    //합계 연산
    syncSum: function(){

    	var list = myGrid3.getList();
    	//col sync
    	var csum = 0;
    	var totSumWork = 0;
    	var totSumOver = 0;
    	var addActTCols = new Array(8);
    	for(var i=1; i<=7; i++){
    		//grid sum
    		for(var k=0; k<list.length; k++){
        		csum += 1 * $('#actT' + i + k).val();
        	}

    		//추가 sum
    		addActTCols[i] = $('input[id^=addActT'+i+']');
    		for(var t=0; t<addActTCols[i].length; t++){
    			csum += 1 * $(addActTCols[i][t]).val();
    		}

    		$('#colSumWork' + i).html(csum>8?8:csum);			//일간 규정업무
    		$('#colSumOver' + i).html(csum>8?csum-8:'');		//초과업무

    		totSumWork += (csum>8?8:csum);
    		totSumOver += (csum>8?csum-8:0);

    		csum = 0;
    	}



    	//추가 row ... row sum
    	var tmpSum = 0;
    	var addActTSumLst = $('span[id^=addActTSum]');
    	for(var m=0; m<addActTSumLst.length; m++){
    		for(var n=1; n<=7; n++){
    			tmpSum += 1 * $(addActTCols[n][m]).val();
    		}
    		$(addActTSumLst[m]).html(tmpSum);
    		tmpSum = 0;
    	}


    	//total
    	$('#totSumWork').html(totSumWork);
		$('#totSumOver').html(totSumOver);
    },


  	//검색일의 한주간 날짜 객체 반환 함수(day1(월요일), ..., day7(일요일)))
  	getWeekDate: function(d) {
		var obj = {};
		var sDate = new Date(d);
		var day = sDate.getDay();
		var diff = sDate.getDate() - day + (day == 0 ? -6 : 1); 	// 해당일의 월요일

		todayIndex = -1;		//오늘해당요일 index global variable ... init.

		for(var i=0; i<7; i++){
			obj['day'+(i+1)] = new Date(sDate.setDate(diff + i)).yyyymmdd();
			sDate = new Date(d);

			if(new Date().yyyymmdd() == obj['day'+(i+1)]){
				todayIndex = i+1;			//1~7 중 오늘의 index 값 세팅 (global variable setting!!) ... 전역변수 세팅!!!
			}
		}

		return obj;
	},


	//입력 모드 에 따른, 입력란 세팅		('view' 모드 or 'update' 모드 or 'new' 모드)
	setInputMode: function(){

		var idx = myGrid.getSelectRowIndex()[0];
		var item = myGrid.getList()[idx];

		var closedYn = 'N';

		if(g_mode == 'view'){					//... 데이터 없으면서 닫힌것(itme.open 이 'C'or'W')도 포함 !!
			$('input[id^=actT]').prop('readonly', true);

			$('#trNewActTime0').hide();						//추가 row 숨김


			//버튼 세팅
						//일단 모두 숨기고 보일것만 상태에 따라 보이도록.
			$('#btn_sbmt').hide();				//승인요청
			$('#btn_updt').hide();				//수정
			$('#btn_sbca').hide();				//승인요청취소
			$('#btn_save').hide();				//저장
			$('#btn_canc').hide();				//취소
			if(item.status == 'CLOSED' || item.open == 'C' || item.open == 'W'){		//----- 진행상태 : 마감 or 데이터 없으면서 닫힌것(itme.open 이 'C'or'W')
				closedYn = 'Y';					//마감스타일적용 ... (하단 fnObj.setClosedStyle(closedYn) 호출)

			}else if(item.status == 'REJECT'){	//----- 진행상태 : 반려
				$('#btn_updt').show();			//수정

			}else if(item.status == 'REQUEST'){	//----- 진행상태 : 승인요청
				$('#btn_sbca').show();			//승인요청취소

			}else if(item.status == 'WRITE'){	//----- 진행상태 : 작성중
				$('#btn_sbmt').show();			//승인요청
				$('#btn_updt').show();			//수정
			}else{
				//모두 안보임		'COMMIT' 승인
			}

			/*
			if(item.tDate >= new Date().yyyy_mm_dd()){//현재 주에서는 승인요청 숨긴다
				$('#btn_sbmt').hide();			//승인요청
			} */

		}else{		//g_mode == 'new' or 'update'

			$('input[id^=actT]').prop('readonly', false);

			$('#trNewActTime0').show();						//추가 row 보이게

			//버튼 세팅
			$('#btn_sbmt').hide();				//승인요청
			$('#btn_updt').hide();				//수정
			$('#btn_sbca').hide();				//승인요청취소
			$('#btn_save').show();				//저장

			if(g_mode == 'update'){
				$('#btn_canc').show();			//취소
			}else{		//new
				$('#btn_canc').hide();			//취소
			}

			/* //마감(데이터 없으면서) ... 버튼모두hide
			if(item.open != 'O'){		//O:open, C:close, W:wait
				$('#btn_save').hide();			//저장
				$('#trNewActTime0').hide();		//추가 row 숨김

				closedYn = 'Y';					//마감스타일적용 ... (하단 fnObj.setClosedStyle(closedYn) 호출)
			} */

		}

		fnObj.setClosedStyle(closedYn);		//마감스타일적용 함수호출
	},


	//마감스타일 적용
	setClosedStyle: function(yn){
		if(yn == 'Y'){
			$('input[id^=actT]').addClass('closedInput');				//border 스타일적용	css('border', '1px dotted #EEEEEE');

			$('#divTimesheetInput').addClass('finish_timesheet');		//마감 레이어 적용
			$('#spanTimesheetInput').show();
		}else{
			$('input[id^=actT]').removeClass('closedInput');			//border 스타일적용 제거

			$('#divTimesheetInput').removeClass('finish_timesheet');	//마감 레이어 제거
			$('#spanTimesheetInput').hide();
		}
	},


	//수정모드 전환
	doEdit: function(){
		g_mode = 'update';					//update 모드 세팅					■■■	global variable ■■■

		fnObj.setInputMode();
	},


	//수정모드 취소 ... 다시 보기 모드로
	doCancelEdit: function(){

		var idx = myGrid.getSelectRowIndex()[0];
		var item = myGrid.getList()[idx];

		fnObj.clickTimesheet(idx, item);			//그리드 클릭 상태로 되돌려 보기모드로
	},


	//저장 doSave
  	doSave: function(){

  		var list = myGrid3.dataList;


  		var listForSave = list.clone();		//그리드 데이터를 복재하여 저장을 위해 담는다.

  		var obj = null;

  		//추가 activity time input element 접근 array
  		var addActTCols = new Array(8);
    	for(var i=1; i<=7; i++){
    		addActTCols[i] = $('input[id^=addActT'+i+']');
    	}



  		//추가한 데이터를 추가한다.
    	var newAct = $('select[id^=selActivity]');
    	var newPjt = $('select[id^=selProject]');
    	for(var i=0; i<newAct.length; i++){
    		if(newAct[i].value != ''){		//추가된 activity time row 가 존재하면

    			//저장할 데이터 row 를 생성
    			obj = {
    					tsHeaderId : '',
    					pjtId : newPjt[i].value,
    					pjtNm : $(newPjt[i]).find(':selected').text(),
    					actId : newAct[i].value,
    					actNm : $(newAct[i]).find(':selected').text(),
    					tmDay1 : '', tmDay2 : '', tmDay3 : '', tmDay4 : '', tmDay5 : '', tmDay6 : '', tmDay7 : '',
    					oriTmDay1 : '', oriTmDay2 : '', oriTmDay3 : '', oriTmDay4 : '', oriTmDay5 : '', oriTmDay6 : '', oriTmDay7 : '',
    					tmWeek: ''
    			};

    			//해당일에 데이터 세팅
    			for(var k=1; k<=7; k++){
    				obj['tmDay'+k] = addActTCols[k][i].value;
    			}

    			listForSave.push(obj);
    		}
    	}


		//--------------- validation :S ---------------

    	//--------------- validation :E ---------------


    	//저장
    	//alert(JSON.stringify(dayObject));
    	//alert(JSON.stringify(listForSave));
    	//return;


    	if(confirm('저장하시겠습니까?')){

    		var url = contextRoot + "/work/doSaveTimesheet.do";
        	var param = {
        			mode		: g_mode,						//"new" or "update"

        			userId		: '${baseUserLoginInfo.userId}',	//userId

        			tsHeaderId	: g_tsHeaderId,					//"update" g_mode 일경우

        			calYear		: g_calYear,
        			yearWeek	: g_yearWeek,
        			dayObject	: JSON.stringify(dayObject),	//주간 날짜 json string	... ex  {"day1":"20160606", "day2":"20160607", "day3":"20160608", ...}

        			hList		: JSON.stringify(listForSave),	//그리드 데이터 리스트 (JSON 문자열로 전달)
        	};

        	//alert(JSON.stringify(param));
        	//return;

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		//세션로그아웃 >> 재로그인
        		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
        			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
        			return;
        		}

        		var projectId = obj.resultVal;	//templateId

        		if(obj.result == "SUCCESS"){

        			toast.push("저장OK!");

        			//fnObj.viewProject(projectId);

        			fnObj.getTimesheetAll(myGrid.getSelectRowIndex()[0]);		//목록 재조회 ... 재조회후 저장한 건이 클릭되어 보이도록 index 전달

        		}else{
        			//alertMsg();
        		}

        	};

        	commonAjax("POST", url, param, callback);

    	}
  	},//doSave


  	//승인요청
  	doSubmit: function(){

  		//alert('승인요청 진행!!!');

		var list = myGrid3.dataList;


		//--------------- validation :S ---------------
		if(isEmpty(g_tsHeaderId)){
			alert('승인요청할 타임시트가 없습니다!');
			return;
		}
    	//--------------- validation :E ---------------


    	//저장
    	//alert(JSON.stringify(dayObject));
    	//alert(JSON.stringify(listForSave));
    	//return;


    	if(confirm('승인요청 하시겠습니까?')){

    		var url = contextRoot + "/work/doChngTsStatus.do";
        	var param = {
        			tsHeaderId	: g_tsHeaderId,					//"update" g_mode 일경우
        			status		: 'REQUEST'
        	};

        	//alert(JSON.stringify(param));
        	//return;

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		//세션로그아웃 >> 재로그인
        		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
        			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
        			return;
        		}

        		if(obj.result == "SUCCESS"){

        			toast.push("승인요청OK!");

        			//fnObj.viewProject(projectId);

        			fnObj.getTimesheetAll(myGrid.getSelectRowIndex()[0]);		//목록 재조회 ... 재조회후 저장한 건이 클릭되어 보이도록 index 전달

        		}else{
        			//alertMsg();
        		}

        	};

        	commonAjax("POST", url, param, callback);

    	}

  	},


  	//승인요청취소
  	doCancelSbmt: function(){


		//--------------- validation :S ---------------
		if(isEmpty(g_tsHeaderId)){
			alert('승인요청취소할 타임시트가 없습니다!');
			return;
		}
    	//--------------- validation :E ---------------


    	if(confirm('승인요청을 취소 하시겠습니까?\n\n(※상태변경: 승인요청→작성중)')){

    		var url = contextRoot + "/work/doChngTsStatus.do";
        	var param = {
        			tsHeaderId	: g_tsHeaderId,					//"update" g_mode 일경우
        			status		: 'WRITE',

        			chngType	: 'CANCEL_SUBMIT'				//상태변경 타입 'CANCEL_SUBMIT' 승인요청취소
        	};

        	//alert(JSON.stringify(param));
        	//return;

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		//세션로그아웃 >> 재로그인
        		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
        			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
        			return;
        		}

        		if(obj.result == "SUCCESS"){

        			var resultObj = obj.resultObject;

        			if(resultObj.realResult == 'SUCCESS'){
        				toast.push("승인요청취소OK!");

        			}else{	//resultObj.realResult == 'FAIL'
        				alert('[실패!!]\n\n승인요청취소 하려는 건의 진행상태가 승인자에 의해 "' + resultObj.statusNm + '"으로 변경되어\n 취소처리를 할 수 없습니다.');
        			}

        			fnObj.getTimesheetAll(myGrid.getSelectRowIndex()[0]);		//목록 재조회 ... 재조회후 저장한 건이 클릭되어 보이도록 index 전달

        		}else{
        			//alertMsg();
        		}

        	};

        	commonAjax("POST", url, param, callback);
    	}

  	},


  	//승인,반려 처리
  	doApprove: function(knd, typ, tsHeaderId){		//*knd: 'checked'(체크박스 체크건) or 'direct'(개별건 바로) , *typ: 'commit'(승인) or 'reject'(반려)

  		//--------------- validation :S ---------------

  		var tsHeaderIdLst = '';				//처리할 타임시트 id 리스트

  		var chkList = null;					//체크박스 리스트

  		if(knd == 'checked'){		//체크박스 선택승인 처리

  			chkList = $('input[name=mCheck]:checked');		//체크박스 선택건

  			if(chkList.length == 0){
  				alert('선택한 타임시트가 없습니다!\n' + (typ=='commit'?'승인':'반려') + '처리할 타임시트를 선택해주세요!!');
  				return;
  	  		}

  			for(var i=0; i<chkList.length; i++){
  				tsHeaderIdLst += chkList[i].value + ',';
  			}

  		}else{						//한건 승인처리
  			tsHeaderIdLst = tsHeaderId + ',';
  		}


  		//alert(tsHeaderIdLst);
  		//return;

    	//--------------- validation :E ---------------


    	if(confirm((typ=='commit'?'승인':'반려') + '처리 하시겠습니까?')){

    		var url = contextRoot + "/work/doChngTsApprov.do";
        	var param = {
        			tsHeaderIdLst	: tsHeaderIdLst,					//타임시트 id 리스트(한개 이상... 구분자 ',')
        			status			: (typ=='commit'?'COMMIT':'REJECT')
        	};

        	//alert(JSON.stringify(param));
        	//return;

        	var callback = function(result){

        		var obj = JSON.parse(result);

        		//세션로그아웃 >> 재로그인
        		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
        			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
        			return;
        		}

        		if(obj.result == "SUCCESS"){

        			toast.push("처리 OK!");

        			//fnObj.viewProject(projectId);

        			fnObj.getTimesheetAll(myGrid.getSelectRowIndex()[0]);		//목록 재조회 ... 재조회후 저장한 건이 클릭되어 보이도록 index 전달

        			//location.reload(true);
        			$('#dvOneWeekDtl').hide();				//한주상세 그리드 숨기기
            		$('#divTimesheetInput').hide();			//한주상세 개인 보기는 숨기기

        		}else{
        			//alertMsg();
        		}

        	};

        	commonAjax("POST", url, param, callback);

    	}

  	}


  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){

	fnObj.preloadCode();		//공통코드 or 각종선로딩코드
	fnObj.pageStart();			//화면세팅

	fnObj.getTimesheetAll('PRE_WEEK');	//타임시트(지난주)

});
</script>