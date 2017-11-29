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
/* 
.tb_time_list tbody tr.tr_selected {
	font-weight: bold;
    border-top: solid 2px #999;    
    border-bottom: solid 2px #999;
    border-left: solid 3px #999;
    padding-bottom: 3px;
} */
.scroll_cover { position:absolute; right:0px; top:0px; z-index:50; background:#dfe3e8; width:17px; height:51px; border-bottom:#b1b5ba solid 1px; vertical-align:middle; font-size:10px; line-height:51px; text-align:center; display:inline-block; cursor:pointer; *display:none; }
</style>
<!-- -------- each page css :E -------- -->


	<section id="detail_contents">
      
        <!--title-->
        <div class="timesheet_titleZone">
        	<h3 class="h3_design_title">TimeSheet Deadline</h3>
            <p class="sub_title"><strong>직원들의 타임시트 마감을</strong> 관리하는 곳입니다.</p>
            <p class="des_txt">미입력자부분의 직원들을 확인하고 '재촉하기'버튼으로 타임시트 작성과 승인을 요청할수 있으며, <br>
            모든 직원이 완료상태일때만 마감이 가능합니다.</p>
        </div>
        <!--//title//-->
        <!--타임시트목록-->
        <h4 class="timesheet_title">
        	<%--
            <span class="space02"><select class="date_select" title="년도선택">
                <option>2015년</option>
                <option>2015년</option>
                <option>2015년</option>
            </select></span>
            <span class="space02"><select class="date_select" title="시작월선택">
                    <option>09월</option>
                    <option>10월</option>
                    <option>11월</option>
                </select></span>
                ~
            <span class="space03"><select class="date_select" title="끝월선택">
                    <option>11월</option>
                    <option>12월</option>
                    <option>01월</option>
                </select></span>
            <span><a href="#" class="btn_s_type">기간조회</a></span>
             --%>
            
            <span class="space02" id="srchYearSelectTag"></span>
            <span class="space02" id="srchSMonthSelectTag"></span>
                ~
            <span class="space03" id="srchEMonthSelectTag"></span>
            <span><a href="javascript:fnObj.getTimesheetAll();" class="btn_s_type">기간조회</a></span>
            <span style="padding-left:8px;"><a href="javascript:fnObj.getTsAllThisWeek();" class="btn_s_type">지난주</a></span>
            
        </h4>        
        
        <div class="timesheet_admin_wrap" style="overflow-y:scroll;">
        	<table class="tb_time_list" summary="타임시트 마감 관리목록 (기간, 미제출자, 미승인자, 진행상태)" >
            	<caption>타임시트 마감 관리목록</caption>
                <colgroup>
                    <col width="24%" />
                    <col width="*" />
                    <col width="12%" />
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">기간</th>
                    <th scope="col">미제출자/미승인자</th>
                    <th scope="col">진행상태</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
       		</table>
       	</div>
        
        <div id="timesheet_cntnt" class="timesheet_admin_wrap" style="max-height:450px;overflow-y:scroll;">
        	<table id="SGridTarget" class="tb_time_list" summary="타임시트 마감 관리목록 (기간, 미제출자, 미승인자, 진행상태)" >
            	<caption>타임시트 마감 관리목록</caption>
                <colgroup>
                    <col width="24%" />
                    <col width="*" />
                    <col width="12%" />
                </colgroup>
                <thead>
                <%--<tr>
                    <th scope="col">기간</th>
                    <th scope="col">미제출자/미승인자</th>
                    <th scope="col">진행상태</th>
                </tr> --%>
                </thead>
                <tbody>
                <tr class="finish_line">
                    <th><strong>09월 1주차</strong> (08/30~09/05)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="finish_line">
                    <th><strong>09월 2주차</strong> (09/06~09/12)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="finish_line">
                    <th><strong>09월 3주차</strong> (09/13~09/19)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="finish_line">
                    <th><strong>09월 4주차</strong> (09/20~09/26)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="finish_line">
                    <th><strong>09월 5주차</strong> (09/27~10/04)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="finish_line tr_divide_line">
                    <th><strong>10월 2주차</strong> (10/05~10/11)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="finish_line">
                    <th><strong>10월 3주차</strong> (10/12~10/18)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="finish_line">
                    <th><strong>10월 4주차</strong> (10/19~10/25)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="finish_line">
                    <th><strong>10월 5주차</strong> (10/26~11/01)</th>
                    <td><span class="f_subscript">타임시트가 마감되었습니다.</span></td>
                    <td>마감완료</td>
                </tr>
                <tr class="tr_divide_line">
                    <th><strong>11월 2주차</strong> (11/02~11/08)</th>
                    <td>&nbsp;</td>
                    <td><a href="" class="btn_finish_ok">마감가능</a></td>
                </tr>
                <tr>
                    <th><strong>11월 3주차</strong> (11/09~11/15)</th>
                    <td>&nbsp;</td>
                    <td><a href="" class="btn_finish_ok">마감가능</a></td>
                </tr>
                <tr>
                    <th><strong>11월 4주차</strong> (11/16~11/22)</th>
                    <td>&nbsp;</td>
                    <td><a href="" class="btn_finish_ok">마감가능</a></td>
                </tr>
                
                <tr>
                    <th><strong>11월 5주차</strong> (11/23~11/29)</th>
                    <td class="txt_left">
                    	<dl class="no_submit_list">
                        	<dt>[미승인자]</dt>
                            <dd>서상옥, 구자형, 김정태, 이명철<a href="" class="btn_press_ok"><em class="blind">승인재촉</em></a></dd>
                        </dl>
                    </td>
                    <td><a href="" class="btn_no_finish">마감불가</a></td>
                </tr>
                <tr>
                    <th rowspan="2"><strong>11월 6주차</strong> (11/30~12/06)</th>
                    <td class="txt_left">
                    	<dl class="no_submit_list">
                        	<dt>[미제출자]</dt>
                            <dd>박정인, 김선희, 전신혜, 오영식, 박상현<a href="" class="btn_press_write"><em class="blind">작성재촉</em></a></dd>
                        </dl>
                    </td>
                    <td rowspan="2"><a href="" class="btn_no_finish">마감불가</a></td>
                </tr>
                <tr>
                    <td class="txt_left dot_line_top">
                    	<dl class="no_submit_list">
                        	<dt>[미승인자]</dt>
                            <dd>서상옥, 구자형, 김정태, 이명철<a href="" class="btn_press_ok"><em class="blind">승인재촉</em></a></dd>
                        </dl>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <!--//타임시트목록//-->

        
    </section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

var searchDate;							//검색할 기준일 (기본은..당일)
//var todayIndex = -1;					//7일중 오늘이 되는 index (1~7 중 오늘의 index 값)

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
var myPaging = new SPaging();	// instance		new sjs
var mySorting = new SSorting();	// instance		new sjs


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
            						var termStr = '<strong>' + obj.item.month + '월 ' + obj.item.week + '주차 </strong>(' + obj.item.stDt + ' ~ ' + obj.item.edDt + ')';
            						var preWeek = new Date();
            						preWeek.setDate(preWeek.getDate() - 7);
            						if(obj.item.sDate <= preWeek.yyyy_mm_dd() && preWeek.yyyy_mm_dd() <= obj.item.tDate){	//현재 주에서는 승인요청 숨긴다
            							termStr += '<span style="font-size:11px!important;font-weight:bold!important;padding-left:20px;color:#5555FF!important;">지난주</span>';
            						}
            						/* if(obj.item.sDate <= new Date().yyyy_mm_dd() && new Date().yyyy_mm_dd() <= obj.item.tDate){	//현재 주에서는 승인요청 숨긴다
            							termStr += '<span style="font-size:11px!important;font-weight:bold!important;padding-left:20px;color:#995555!important;">이번주</span>';
            						} */
            						return termStr;
            					}},
            					
            {key:"personList",	formatter:function(obj){
					            	var val = obj.value==null?'':obj.value;
									
									if(obj.item.open == 'C'){ val = '<span class="f_subscript">타임시트가 마감되었습니다. &nbsp;&nbsp;&nbsp;(등록수: ' + (obj.item.closedCnt==0?'<font color="#BBBBBB">0</font>개':obj.item.closedCnt+'개') + ')</span>';
									}else if(obj.item.open == 'W'){ val = '<span class="f_subscript">오픈전 입니다.</span>';
									}else{
									
										if(obj.item.closedCnt > 0 && obj.item.closedCnt==obj.item.allCnt){		//모든 타임시트가 마감처리되었을때
											return '<span class="f_subscript">타임시트가 마감되었습니다. &nbsp;&nbsp;&nbsp;(등록수: ' + (obj.item.closedCnt==0?'<font color="#BBBBBB">0</font>개':obj.item.closedCnt+'개') + ')</span>';											
										}
										
										
										var pArray = val.split('||');
										if(pArray.length > 1){
									
											val = '<dl class="no_submit_list">';
											if(pArray[0].length>0){
												val +='<dt>[미제출자]</dt><dd>';
												val +=pArray[0];
												val +='<a href="javascript:;" class="btn_press_write" style="opacity:0.2;"><em class="blind">작성재촉</em></a></dd>';
											}
											if(pArray[0].length>0 && pArray[1].length>0){
												val +='<dd style="height:7px; border-top:1px dotted #ccc; margin-top:7px;"></dd>';	//---- 미제출자, 미승인자 두개모두 존재할때만 추가!!
											}
											if(pArray[1].length>0){
												val +='<dt>[미승인자]</dt><dd>';
												val +=pArray[1];
												val +='<a href="javascript:;" class="btn_press_ok" style="opacity:0.2;"><em class="blind">승인재촉</em></a></dd>';
											}
											val +='</dl>';
											
											//모두 준비되었을때
											if(pArray[0].length==0 && pArray[1].length==0){
												val = '<span style="font-size:11px;color:purple;">작성완료</span>';
											}
										}
									}//else
									return val;
								}},
			{key:"personStyle",	formatter:function(obj){
									var pArray = obj.item.personList.split('||');
									
									if(pArray.length>1){
										
										if(obj.item.closedCnt > 0 && obj.item.closedCnt==obj.item.allCnt || obj.item.open == 'C'){		//모든 타임시트가 마감처리되었을때 or 마감
											return '';	//마감 상태는 align center (기본 중앙정렬이므로 그냥 ... return '';)
										}
										
										if(pArray[0].length > 0 || pArray[1].length > 0){
											return 'text-align:left;';
										}										
									}
									
									return '';
        						}},
            {key:"statusNm",	formatter:function(obj){
            						var val = obj.value==null?'':obj.value;
            						
            						if(obj.item.closedCnt > 0 && obj.item.closedCnt==obj.item.allCnt){		//모든 타임시트가 마감처리되었을때
            							return '마감완료';
            						}
            						
            						if(obj.item.open == 'C'){ val = '마감완료';
            						}else if(obj.item.open == 'W'){ val = '오픈전';
            						}else{
            							var pArray = obj.item.personList.split('||');
            							if(pArray.length >1){
											var classNm = (pArray[0].length>0||pArray[1].length>0?'btn_no_finish':'btn_finish_ok');
	            							val = '<a href="';
	            							val += (pArray[0].length>0||pArray[1].length>0?'javascript:;':'javascript:fnObj.setTsClose(' + obj.item.calYear + ',' + obj.item.week + ');' );
	            							val += '" class="' + classNm + '">마감처리</a>';
            							}
            						}
            						
            						/* if(obj.item.status != null && obj.item.status != 'CLOSED'){
            							val = '<span class="state_txt">' + obj.value + '</span>';
            						} */
           							return val;
           						}},
           	{key:"finishClass",	formatter:function(obj){
        							if(obj.item.open == 'C' || obj.item.open == 'W' || obj.item.status == 'CLOSED'){
        								return 'finish_line';
        							}
        							if(obj.item.closedCnt > 0 && obj.item.closedCnt==obj.item.allCnt){		//모든 타임시트가 마감처리되었을때
        								return 'finish_line';
        							}
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
	            	//if(obj.c > 0){
	            	//fnObj.clickTimesheet(obj.index, obj.item);	//.tDate, obj.item.tsHeaderId, obj.item.calYear, obj.item.week);
	            	//}
	            }
	        }
	        
    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr class="#[4]">';    	
    	rowHtmlStr +=	 '<td>#[0]</th>';    	
    	rowHtmlStr +=	 '<td style="#[2]">#[1]</td>';
    	rowHtmlStr +=	 '<td>#[3]</td>';    	
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
    getTimesheetAll: function(oriRowIdx){
    	
    	var url = contextRoot + "/work/getTsListAdmin.do";
    	var param = {    			
    			year: $('select[name=selSrchYear]').val(),
    			stMonth: $('select[name=selSrchSMonth]').val(),
    			edMonth: $('select[name=selSrchEMonth]').val(),
    			applyOrgId: '${baseUserLoginInfo.applyOrgId}',
    			sDate: new Date().yyyy_mm_dd()
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
			
    		myGrid.setGridData({list:list});		//그리드 데이터 세팅
    		
    		//스크롤 제일 아래로    		
    		$("#timesheet_cntnt").scrollTop($("#timesheet_cntnt")[0].scrollHeight);
    		
    	};
    	
    	commonAjax("POST", url, param, callback);
    	
    },


    //지난주
    getTsAllThisWeek: function(){
    	//var cdYr = codeYear.length;
    	$('#selSrchYear').val(new Date().getFullYear());		//codeYear[cdYr-1].CD
    	
    	$('#selSrchSMonth').val(1);
    	$('#selSrchEMonth').val(new Date().getMonth() + 1);
    	
    	fnObj.getTimesheetAll();		//조회
    },
    
    
  	//마감처리
  	setTsClose: function(year, week){
  		
    	
    	if(confirm('마감처리 하시겠습니까?')){
    		
    		var url = contextRoot + "/work/doCloseWeekTs.do";
        	var param = {        			        			
        			calYear		: year,
        			yearWeek	: week
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
        			
        			toast.push("마감처리OK!");
        			    			
        			//fnObj.viewProject(projectId);
        			
        			fnObj.getTimesheetAll();		//목록 재조회
        			
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
	
	fnObj.getTimesheetAll();	//타임시트
	//fnObj.doSearchWeek();		//화면 정보 세팅(디폴트는 전주)
	
	
});
</script>