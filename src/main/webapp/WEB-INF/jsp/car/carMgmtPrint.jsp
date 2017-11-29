<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/process.min.js" ></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/calendar_beans_v2.0.js" ></script>

<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<fmt:formatDate var="nowMonth" value='<%= new java.util.Date() %>' pattern='yyyy-MM'/>
<fmt:formatDate var="nowDay" value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd'/>
<style>
/* print style */
@media print {

	#IB_Navi, #footer, #header_menutab { display:none; }
	.carSearchBox, .printAreaLine { display:none; }
	}

div.subTabon{
    cursor: pointer;
    background: url(../images/cssimg/malis5tabon.gif) no-repeat;
    color: #202020;
    font-weight: bold;
    float: left;
    width:90px;
    height: 26px;
    line-height: 29px;
    text-align: center;
    display: block;
    position: relative;
    z-index: 1;
    font-family: "NanumGothic", 맑은 고딕 , "돋움",Dotum,"굴림",Gulim,arial,sans-serif;
   }
   
   .selUserStyle1{
   		height:25px;
   		margin-bottom:4px;
   }
 </style>
 
 
 
 
<div class="wrap-loading display-none">
    <div><img src="${pageContext.request.contextPath}/images/ajax_loading.gif" /></div>
</div>

<div id="wrap">
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
	
	<!--업무승용차운행기록부-->
	 
<div style="margin-top:50px;margin-left:20px;">
	    <div id="excel_data" style="width: 1000px;">
	    <p class="car_attachment"><strong>[</strong>업무용승용차 운행기록부에 관한 별지 서식<strong>]</strong> &lt;2016.04.01 제정&gt;</p>
	    <table class="carList_title_st" id="topTitle">
	    	<colgroup>
	        	<col width="100" />
	            <col width="120" />
	            <col colspan=3 width="*" />
	            <col width="10" />
	            <col width="10" />
	        </colgroup>
	        <tr>
	            <td rowspan="2" class="th_w_title">과세기간</td>
	            <td><span id="startday"></span></td>
	            <td rowspan="2" colspan="5" class="note_title">업무승용차 운행기록부</td>
	            <td class="th_w_title">상호명</td>
	            <td><div id="hqName"></div></td>
	        </tr>
	      <tr>
	        <td><span id="endday"></span></td>
	        <td class="th_w_title">사업자등록번호</td>
	        <td><div id="regNumber"></div></td>
	      </tr>
	    </table>
	    <h3 class="prt_title_b">1. 기본정보</h3>
	    <table class="carList_tb_st01" id="carTitle" summary="기본정보(차종, 자동차등록번호)">
	    	
	        <colgroup>
	            <col width="200" />
	            <col width="300" />
	        </colgroup>
	        <thead>
	            <tr>
	                <th>① 차종</th>
	                <th  colspan="3" >② 자동차등록번호</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <td><span id="carModel"></span></td>
	                <td colspan="3" ><span id="carNumber"></span></td>
	            </tr> 
	        </tbody>
	    </table>
	
		<h3 class="prt_title_b">2. 업무용 사용비율 계산</h3>
	    <table id="SGridTarget" class="carList_tb_st02" summary="업무용 사용비율 계산내역 (사용일자, 사용자, 주행거리, 업무내용)">
	      
	        <colgroup>
	            <col width="120" /><!--사용일자-->
	            <col width="60" /><!--부서-->
	            <col width="60" /><!--성명-->
	            <col width="*" /><!--주행전계기판-->
	            <col width="*" /><!--주행후계기판-->
	            <col width="*" /><!--주행거리-->
	            <col width="*" /><!--출퇴근용-->
	            <col width="*" /><!--일반업무용-->
	            <col width="180" /><!--업무내용-->
	        </colgroup>
	        <thead id="Title">
	            <tr>
	                <th rowspan="3" scope="col">③ 사용일자<br>(요일)</th>
	                <th colspan="2" scope="col">④ 사용자</th>
	                <th colspan="6" scope="col">운행내역</th>
	            </tr>
	            <tr>
	                <th rowspan="2" scope="col">부서</th>
	                <th rowspan="2" scope="col">성명</th>
	                <th rowspan="2" scope="col">⑤ 주행전<br>계기판의 거리(km)</th>
	                <th rowspan="2" scope="col">⑥ 주행후<br>계기판의 거리(km)</th>
	                <th rowspan="2" scope="col">⑦ 주행거리<br>(km)</th>
	                <th colspan="2" scope="col">업무용사용거리(km)</th>
	                <th rowspan="2" scope="col">⑩ 업무내용</th>
	            </tr>
	            <tr>
	                <td>⑧ 출ㆍ퇴근용<br>(km)</td>
	                <td>⑨ 일반업무용<br>(km)</td>
	            </tr>
	        </thead>
	        <tbody>
	       
	        </tbody>
	        <tfoot>
	            <tr>
	                <th colspan="3" rowspan="2" class="bgcolor_gray">총계</th>
	                <td colspan="3">⑪ 과세기간총주행거리</td>
	                <td colspan="2">⑫ 과세기간업무용 사용거리</td>
	                <td>⑬ 업무사용비율 (⑫/⑪)</td>
	            </tr>
	            <tr>
	                <td colspan="3"><span id="total"></span></td>
	                <td colspan="2"><span id="business"></span></td>
	                <td><span id="businessRate"></span></td>
	            </tr>
	        </tfoot>     
	    </table>
	    </div>
	</div>
	<!--//업무승용차운행기록부//-->
	
</div>


<script type="text/javascript">

//Global variables :S ---------------

//공통코드
var comCodeCstType;			//고객구분


var myGrid = new SGrid();		// instance		new sjs
//var g_gridListStr;										//그리드 데이터 string (객체화되기전 문자열 json... JSON.parse 로 객체로 만들어사용) (증권사 필터링을 위해..)


var g_carId = '${carId}';
var g_startDate = '${startDate}';
var g_endDate = '${endDate}';

var carList='';
    	
//Global variables :E ---------------




/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	

	//선로딩코드
	preloadCode: function(){
		//공통코드
		
	 	var colorObj = {};
		carList = getCodeInfo(null,'','',null, null, null,'/car2/carList.do',{});		//owned : 'B'	//법인차량
		//console.log(carList);
	
		for(var i=0; i<carList.length; i++){
			carList[i].carModel = '&nbsp;' + carList[i].carNumber + '&nbsp;&nbsp;-&nbsp;&nbsp;' + carList[i].carModel; 
		}
	
		
		/* var cstSelectTag = createSelectTag('carId', carList, 'carId', 'carModel','${baseUserLoginInfo.cusId}', 'fnObj.doSearch()', colorObj, 180, 'selUserStyle1');		
		$("#carSelect").html(cstSelectTag); */
		

		fnObj.carChangeSelect();
		
		/* 
		//캘린더 세팅 
		$("#inputStartDate").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true, 
			changeYear: true,
			yearRange: 'c-7:c+7',
			maxDate: new Date(),
			showButtonPanel: true,
			isRTL: false,
		    buttonImageOnly: true
		});	
		var startDate = new Date();
		startDate.setDate('01');
		$("#inputStartDate").datepicker('setDate', startDate);
		
		//캘린더 세팅 
		$("#inputEndDate").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true, 
			changeYear: true,
			yearRange: 'c-7:c+7',
			maxDate: new Date(),
			showButtonPanel: true,
			isRTL: false,
		    buttonImageOnly: true
		});	
		var endDate = new Date();
		$("#inputEndDate").datepicker('setDate', endDate);
		fnObj.setDate();
		 */
		//유저 리스트
		
	},

	//화면세팅
    pageStart: function(){
    	
    	//$("#inputUseDate").bindDate();			
    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {
    		
    		targetID : "SGridTarget",		//테이블
    		
    		//그리드 컬럼 정보
    		colGroup : [    		
            {key:"startTime"},
            {key:"deptNm"},            
            {key:"userNm"},
           	{key:"beMileage", formatter:function(obj){return Number(obj.item.beMileage).toLocaleString().split(".")[0];}},
            {key:"afMileage", formatter:function(obj){return Number(obj.item.afMileage).toLocaleString().split(".")[0];}},	
            {key:"gap" , formatter:function(obj){return Number(obj.item.afMileage-obj.item.beMileage).toLocaleString().split(".")[0];}},
            {key:"businessN",formatter:function(obj){
										            	if(obj.item.businessYn=='N'){
										            		return Number(obj.item.afMileage-obj.item.beMileage).toLocaleString().split(".")[0];	
										            	}
            }},
            {key:"businessY",formatter:function(obj){
										            	if(obj.item.businessYn=='Y'){
										            		return Number(obj.item.afMileage-obj.item.beMileage).toLocaleString().split(".")[0];
											
										            	}
            }},
          	{key:"memo"}
            ],
            
            body : {
                onclick: function(obj, e){
                
                }
    		}
            
    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td style="text-align:center;">#[0]</td>';
    	rowHtmlStr +=	 '<td class="left_txt">#[1]</td>';
    	rowHtmlStr +=	 '<td style="text-align:center;">#[2]</td>';
    	rowHtmlStr +=	 '<td style="text-align:right;padding-right:20px!important;">#[3] </td>';				
    	rowHtmlStr +=	 '<td style="text-align:right;padding-right:20px!important;">#[4] </td>';	
    	rowHtmlStr +=	 '<td style="text-align:right;padding-right:20px!important;">#[5] </td>';	
    	rowHtmlStr +=	 '<td style="text-align:center;">#[6]</td>';	
    	rowHtmlStr +=	 '<td style="text-align:center;">#[7]</td>';	
    	rowHtmlStr +=	 '<td class="left_txt">#[8]</td>';			
    	rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr; 
        
    	
    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------
    	
     	//-------------------------- 모달창 :S -------------------------
   
    
    },//end pageStart.
    
    
    //검색
    doSearch: function(){ 
    	
    	//차량 아이디와 날짜
    	var carId = g_carId;    
    	var selectDay = g_startDate;
    	var endDay = g_endDate;
    
    	var url = contextRoot + "/car2/getCarLogList.do";
    	var param = {
		    			carId : carId,
		    			selectDay : selectDay,
		    			endDay : endDay
    				};
    	
    	    	
    	//alert(JSON.stringify(param));
    	    	    	
    	var callback = function(result){
    		
    		var obj = JSON.parse(result);
    		    
    		//alert(JSON.stringify(obj));
    		//return;
    		
    		//var cnt = obj.resultVal;		//결과수
    		//var list = obj.resultList;		//결과데이터JSON
			
    		var list = obj.logList;
    		
    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
								list: list		//그리드 테이터
							   });
    		
    		//g_gridListStr = result;				//따로 전역변수에 넣어둔다
    	
    		var total = 0;
    		var business = 0;
    		var avg = 0;
    		for(var i=0; i<list.length; i++){
    			total += parseInt(list[i].afMileage) - parseInt(list[i].beMileage);
    			if(list[i].businessYn=='Y'){
    				business += parseInt(list[i].afMileage) - parseInt(list[i].beMileage);
    			}
    		}
    		$("#total").html(total + ' km');
    		$("#business").html(business+' km');
    		if(business>0 || total>0 ){
    			avg=(business/total);
    		}
    		$("#businessRate").html((avg*100).toFixed(1)+' %');
    		//전체 건수 세팅
			//$('#total_count').html(cnt);
    		
    		
    		fnObj.carChangeSelect();
        	fnObj.setDate();
        	
        	
        	window.print();		//인쇄
		};
    	
    	//로딩 이미지 보여주기 위한 리스너 함수 :S -----------
    	var beforeFn = function(){
    		// 로딩 이미지 보여주기 처리
    		//$('.wrap-loading', wrap.document).removeClass('display-none');
    	};
    
    	var completeFn = function(){
    		// 로딩 이미지 감추기 처리
	       // $('.wrap-loading', wrap.document).addClass('display-none');
    	}; 
    	//로딩 이미지 보여주기 위한 리스너 함수 :E -----------
    	
    	
    	commonAjax("POST", url, param, callback, true, beforeFn, completeFn);
    	
    },//end doSearch
  
	//select 차종에 따른  model 변경
    carChangeSelect: function(){
    	var selectCarId = g_carId;
    	for(var i=0;i<carList.length;i++){
    		var carId = carList[i].carId;
    		if(carId==selectCarId){
    			$("#carModel").html(carList[i].carOrgModel);
    			$("#carNumber").html(carList[i].carNumber);
    			$("#hqName").html(carList[i].hqName);
    			$("#regNumber").html(carList[i].regNumber);
    			break;
    		}
    	}
     }, //end carChangeSelect
  	

   setDate: function(type){
    	
    	//var inputStartDate =$("#inputStartDate").val().replace(/-/gi,".");
    	//var inputEndDate=$("#inputEndDate").val().replace(/-/gi,".");
    	$("#startday").html(g_startDate);
     	$("#endday").html(g_endDate);
		
	 },//end setDate
  	
   
     //차이계산
     calculateGap: function(){
    	 fnObj.setComma();
     	$("#calGap").empty();
     	var totalDistance = parseInt($("#totalDistance").val().replace(/,/g,''));
     	var beforeDistance=parseInt($("#beforeDistance").text().replace(/,/g,''));
     	$("#calGap").append(Number(totalDistance-beforeDistance).toLocaleString().split(".")[0]);
     },//end calculateGap
     
    excel : function(){
    	
    	var str = '<table>';
    	str+=  ' <tr bgcolor=silver><td bgcolor=white></td>';
    	str+=   $('#excel_data').html();
   
    	str+=  '  </table>';
    	excelDown(str, '차량운행일지'+(new Date().yyyy_mm_dd()));
    },//end excel
 	excelDown: function(htmlStr, fileName, sheetName){	//excelDown(html문자열, 파일명, 시트명)
    	
    	var sheetNm = '다운로드';
    	if(sheetName!=null) sheetNm = sheetName;
    	
    	var tableToExcel = (function() {
        	var uri = 'data:application/vnd.ms-excel;base64,'
        	, template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
        	, base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))); }
        	, format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }); };
        	
        	return function() {	    	
    	    	var ctx = {worksheet: sheetNm || 'Worksheet', table: htmlStr};	    	
        		var link = document.createElement('a');
    			link.download = fileName +".xls";
    			link.href = uri + base64(format(template, ctx));
    			link.click();	    	
        	};
        })();	
    	tableToExcel();
    },//end excelDown
    
    
    
    /* printPage : function(){
    	window.print(); 
    }, */
 
    //인쇄	... 임시
    /* printPage: function(){		
    	var initBody = document.body.innerHTML;
    	document.body.innerHTML = document.getElementById("excel_data").innerHTML;
    	window.print();
		document.body.innerHTML = initBody;
		document.location.reload();
	}, */
	    
	printPage: function(){
		
		var url =  contextRoot + "/car2/getCarLogList.do";

		window.open(url, 'memoResendPop', 'scrollbars=no width=500 height=320');		
	},
	
    
 	//페이지 사이즈 세팅
    setPageSize: function(isSearch){
    	
    	pageSize = $('#sel_page_size').val();
    	
    	//검색도 바로할 경우 ... isSearch ... true
		if(isSearch){
			fnObj.doSearch(1);
    	}
    },//end setPageSize

	//그리드 div height toggle
    showAllGrid: function(){
    	var gridH = $('#SGridTarget').height() + 100;
    	if($('.scroll_body').height() == 450){
    		$('.scroll_body').css('height', gridH);
    		$('.scroll_body').css('max-height', gridH);
    	}else{
    		$('.scroll_body').css('height', '450px');
    		$('.scroll_body').css('max-height', '450px');
    	}
    },//end showAllGrid
};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
		fnObj.preloadCode();	//선코딩		
		fnObj.pageStart();		//화면세팅
		
		fnObj.doSearch(); 	    //해당 차량 리스트
});
</script>

<style>
/* print style */
@media print {

#gnb_wrap, #main_header, #footer { display:none; }
.carSearchBox, .printAreaLine { display:none; }

}
#wrap { background:#fff; }
/* .carMgmt_wrap { padding: 25px;}  */
/*검색영역*/

.carSearchBox .input_b { border:#bfbfbf solid 1px; height:24px; box-sizing:border-box; width:80px; color:#666; }
.carSearchBox .select_b { border:#bfbfbf solid 1px; height:24px; box-sizing:border-box; color:#666; }
.carSearchBox span, .carSearchBox button, .carSearchBox input { vertical-align:middle; }

.carSearchBox .carSearchtitle { font-weight:bold; color:#3a485e; padding-right:5px; }
.between_txt { padding:0 5px; text-align:center; }
.btn_calendar { background:url(../images/common/board/btn_board_collection.gif) no-repeat; width:18px; height:18px; display:inline-block; vertical-align:middle; background-position:-27px 3px; padding:5px 8px 5px 6px; font-size:11px; }
.btn_calendar em { font-size:0; visibility:hidden; height:0px; }

/*btn모음 조회*/
.btn_b_black { background:#595959; font-weight:bold; color:#fff; border:#484848 solid 1px; height:24px; box-sizing:border-box; display:inline-block; font-size:12px; min-width:60px; border-radius:2px; }

/*오른쪽 btn모음*/
.btnRightZone { position:absolute; right:15px; top:12px; }
/*XLS파일로저장*/
.btn_b2_skyblue { background:url(../images/work/bg_btn_skyblue.gif) repeat-x; font-weight:bold; color:#fff; border:#a1a6ac solid 1px; height:24px; box-sizing:border-box; display:inline-block; font-size:11px; border-radius:2px; }
.btn_b2_skyblue em { color:#555; line-height:1; letter-spacing:-0.1em; }
/*인쇄,검증*/
.btn_b_skyblue { background:url(../images/work/bg_btn_skyblue.gif) repeat-x; font-weight:bold; color:#fff; border:#a1a6ac solid 1px; height:24px; padding:0 5px; box-sizing:border-box; display:inline-block; font-size:11px; border-radius:2px; }
.btn_b_skyblue em { color:#555; line-height:1; vertical-align:middle; display:inline-block; }
.icon_XLS { background:url(../images/work/icon_xls.png) no-repeat 0 center; margin-left:-1px; padding:2px 5px 2px 34px;  }
.icon_print { background:url(../images/work/icon_print.png) no-repeat 0 center;  padding:2px 0px 2px 18px; }
.icon_check { background:url(../images/work/icon_check.png) no-repeat 0 center; padding:2px 0px 2px 10px; }

/*프린트영역설정*/
.printAreaLine { background:url(../images/work/bg_print_area.gif) repeat-x center; margin-top:34px; margin-bottom:26px; text-align:center; }
.printAreaLine .icon_print { background:url(../images/work/icon_print2.gif) no-repeat 10px center #FFF; padding:10px 11px 10px 28px; line-height:1; vertical-align:middle; display:inline-block; color:#898989; letter-spacing:-0.1em; font-size:11px; }

/*인쇄영역 타이틀 및 주의사항*/
.prt_title_b { font-size:14px; font-weight:bold; color:#202020; margin-top:30px; margin-bottom:8px; }
.car_attachment { color:#202020; margin-bottom:8px; }

/*테이블*/
.carList_title_st { width:100%; border-bottom:#c1c1c1 solid 1px; border-top:#202020 solid 1px; table-layout:fixed; }
.carList_title_st td { padding:3px 10px; border-right:#c1c1c1 solid 1px; border-top:#c1c1c1 solid 1px; text-align:center; color:#202020; }
.carList_title_st td:first-child { border-left:#c1c1c1 solid 1px; }
.carList_title_st tr:first-child td { border-top:none; }
.carList_title_st .th_w_title { text-align:justify; text-align:center; }
.carList_title_st .note_title { font-size:16px; font-weight:bold; color:#202020; }

.carList_tb_st01 { border-bottom:#c1c1c1 solid 1px; border-top:#202020 solid 1px; table-layout:fixed; }
.carList_tb_st01 th { padding:3px 10px; border-right:#c1c1c1 solid 1px; border-top:#c1c1c1 solid 1px; text-align:center; box-sizing:border-box; color:#202020; font-weight:normal; }
.carList_tb_st01 td { padding:5px 10px; border-right:#c1c1c1 solid 1px; border-top:#c1c1c1 solid 1px; text-align:center; color:#202020; }
.carList_tb_st01 th:first-child { border-left:#c1c1c1 solid 1px; }
.carList_tb_st01 td:first-child { border-left:#c1c1c1 solid 1px; }
.carList_tb_st01 thead tr:first-child td, .carList_tb_st01 thead tr:first-child th { border-top:none; }

.carList_tb_st02 { width:100%; border-bottom:#c1c1c1 solid 1px; border-top:#202020 solid 1px; table-layout:fixed; }
.carList_tb_st02 th { padding:3px 10px; border-right:#c1c1c1 solid 1px; border-top:#c1c1c1 solid 1px; text-align:center; box-sizing:border-box; color:#202020; font-weight:normal; }
.carList_tb_st02 td { padding:5px 10px; border-right:#c1c1c1 solid 1px; border-top:#c1c1c1 solid 1px; text-align:center; color:#555; }
.carList_tb_st02 th:first-child { border-left:#c1c1c1 solid 1px; }
.carList_tb_st02 td:first-child { border-left:#c1c1c1 solid 1px; }
.carList_tb_st02 thead  tr:first-child td, .carList_tb_st02 thead tr:first-child th { border-top:none; }
.carList_tb_st02 .bgcolor_gray { background:#f2f2f2; }
.carList_title_st caption, .carList_tb_st01 caption, .carList_tb_st02 caption { display:none; }
.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
    z-index: 1000000;
}
.wrap-loading div{ /*로딩 이미지*/
    position: fixed;
    top:50%;
    left:50%;
    margin-left: -21px;
    margin-top: -21px;
    z-index: 1000000;
}
.display-none{ /*감추기*/
    display:none;
}
</style>