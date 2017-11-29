<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section id="detail_contents">
<fmt:formatDate var="nowDay" value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd'/>
<fmt:formatDate var="year" value='<%= new java.util.Date() %>' pattern='yyyy'/>
<fmt:formatDate var="month" value='<%= new java.util.Date() %>' pattern='MM'/>
<fmt:formatDate var="day" value='<%= new java.util.Date() %>' pattern='dd'/>



<input type="hidden" id="sabun" > <!--사번 -->


   <!--차량조회-->
	<div class="carSearchBox noshadow">
 		<span class="carSearchtitle"><label for="carId">차량번호</label></span>
     	<span id="carSelect"></span>
     	<span class="carSearchtitle mgl30">기간</span>
     	<select class="select_b w_date" title="년도선택" id="year" onchange="fnObj.changeYM();"></select>
		<select class="select_b w_date mgl6" title="월선택" id="month" onchange="fnObj.changeYM();"></select>
    </div>
    <!--//차량조회//-->



   <table id="SGridTarget_head" class="car_tb_list_basic">
        <colgroup>
        	<col width="6%" /> <!--차량번호, 사용일-->
            <col width="6%" /> <!--부서-->
            <col width="7%" /> <!--성명-->
            <col width="6%" /> <!--주행전 거리-->
            <col width="6%" /> <!--주행후 거리-->
       		<col width="6%" /> <!--주행거리-->
       		<col width="8%" /> <!--구분-->
            <col width="16%" /><!--내용-->
        </colgroup>
        <thead>

            <tr>
            	<th rowspan="2" scope="col" >사용일</th>
            	<th colspan="2" scope="col">사용자</th>
            	<th colspan="2" scope="col">계기판</th>
            	<th rowspan="2" scope="col">주행거리</th>
            	<th colspan="2" scope="col">업무내용</th>
            </tr>
            <tr id="tblHeaderPart">
            	<th scope="col">부서</th>
            	<th scope="col">성명</th>
            	<th scope="col">주행전 거리</th>
            	<th scope="col">주행후 거리</th>
                <th scope="col">업무 구분</th>
                <th scope="col">내용</th>
            </tr>
        </thead>

        <tbody>
        	<tr>
				<td class="txt_center">
					<input type="text" id="inputUseDate" class="input_b input_date_type" readonly="readonly" onchange="fnObj.changeDate();"/>
					<a href="#" onclick="$('#inputUseDate').datepicker('show');return false;" class="icon_calendar"></a>
				</td>

				<td class="txt_center"><div id="teamNm"></div></td>
				<td class="txt_center"><div id=adminuserDiv></div>
					<div id="normaluserDiv"><input type="hidden" id="userId"></div>
				</td>


				<td class="txt_rignt"><span id="beforeDistance"></span> KM</td>
				<td class="txt_center"><input type="text" name="totalDistance" id="totalDistance" class="AXInput W60 number" style="text-align:center;" onkeyup="fnObj.calculateGap();"> KM</td>
				<td class="txt_center"><span id="calGap"></span> KM</td>

				<td class="txt_center">
					<span class="radio_list2" id="type">
						<label><input type="radio" name="businessYn" value="N"><span>출·퇴근용</span></label>
						<label><input type="radio" name="businessYn" checked value="Y"/><span>일반 업무용</span></label>
					</span>
				</td>
				<td class="txt_left">
					<span class="employee_list">
						<span id="setScheArea"></span>
						<a href="#" onclick="javascript:$('#setScheArea').empty();$('#scheSeq').val('0');$('#aDelCust').hide();$('#scheBtn').show();" id="aDelCust" class="btn_delete_employee"><em>삭제</em></a>
					</span>
					<span class="cartooltip" style="display:none; z-index:10000;" id="spanSelSchedule" ></span>
					<input type="text" id="memoArea" class="AXInput w_st19" onfocus="javascript:fnObj.popUpmemo(this);" onmouseup="javascript:fnObj.popUpmemo(this);" onkeyup="javascript:fnObj.memoDivSet(this);">
					<!-- <a href="#" class="btn_schedule" id="scheBtn" onclick="javascript:fnObj.popUpmemo(this);"><em>일정확인</em></a> -->
					<!-- 내용 팝업 -->


					<input type="hidden" id="scheSeq" value="0">
					<input type="hidden" id="carNick">
				</td>
			</tr>
		</tbody>
	</table>

    <div class="btn_baordZone2" id="buttonArea">
		<a href="#" onclick="javascript:fnObj.doSave();" class="btn_blueblack btn_auth">등록</a>
	</div>

    <div class="car2_st_box">
    	<span class="scroll_cover" onclick="fnObj.showAllGrid();"></span>
    	<div class="scroll_header">
	    	<table class="car2_tb_st" summary="차량일지(사용일, 사용자, 부서, 성명, 계기판, 주행전거리, 주행후거리, 주행거리, 업무내용, 업무용여부, 내용)">
	    		<caption>차량일지거리</caption>
	            <colgroup>
	                <col width="6%" /> <!--차량번호, 사용일-->
	                <col width="6%" /> <!--부서-->
	                <col width="7%" /> <!--성명-->
	                <col width="6%" /> <!--주행전 거리-->
	                <col width="6%" /> <!--주행후 거리-->
	           		<col width="6%" /> <!--주행거리-->
	           		<col width="6%" /> <!--구분-->
	                <col width="18%" /><!--내용-->
	             </colgroup>
	             <thead>
	                 <tr>
	                     <th scope="col">사용일</th>
	                     <th scope="col">부서</th>
	                     <th scope="col">성명</th>
	                     <th scope="col">주행전 거리</th>
	                     <th scope="col">주행후 거리</th>
	                     <th scope="col">주행거리</th>
	                     <th scope="col">업무 구분</th>
	                     <th scope="col">내용</th>

	                </tr>
	             </thead>
	    	 </table>
	    </div><!--  scroll_header -->

	    <div class="scroll_body">
	    	<table class="car2_tb_st" id="SGridTarget_body" summary="차량일지(사용일, 사용자, 부서, 성명, 계기판, 주행전거리, 주행후거리, 주행거리, 업무내용, 업무용여부, 내용)">
				<colgroup>
	                <col width="6%" /> <!--차량번호, 사용일-->
	                <col width="6%" /> <!--부서-->
	                <col width="7%" /> <!--성명-->
	                <col width="6%" /> <!--주행전 거리-->
	                <col width="6%" /> <!--주행후 거리-->
	           		<col width="6%" /> <!--주행거리-->
	           		<col width="6%" /> <!--구분-->
	                <col width="18%" /><!--내용-->
	           	</colgroup>
               	<tbody>

               	</tbody>
             </table>
        </div>
       <!--  <label><a href="#" onclick="fnObj.showAllGrid();" class="btn_wh_bevel sort_normal" style="width:26px;">펼침</a></label> -->
    </div>	<!-- car2_st_box -->

</section>


<script type="text/javascript">

//Global variables :S ---------------

//공통코드

var myGrid = new SGrid();					   // instance		new sjs


var userId = '${baseUserLoginInfo.userId}'; 		  //로그인 유저의 userId
var permission = '${baseUserLoginInfo.permission}'; //로그인 유저의 permission
var division = '${baseUserLoginInfo.orgId}';
var g_gridListStr;							  //그리드 데이터 string (객체화되기전 문자열 json... JSON.parse 로 객체로 만들어사용) (증권사 필터링을 위해..)


//Global variables :E ---------------
var carList;
var userList = new Array();

/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {


	//선로딩코드
	preloadCode: function(){
		//공통코드
		numberFormatForNumberClass();
		var colorObj = {};
		fnObj.permissionChk(colorObj);
		fnObj.getCarList();

		if(carList.length==0){
			carList = [{'carId':'0','carModel':'등록된 차량이없습니다.'}];
		}else{
			for(var i=0; i<carList.length; i++){
				carList[i].carModel = '&nbsp;' + carList[i].carNumber + '&nbsp;&nbsp;-&nbsp;&nbsp;' + carList[i].carModel;
			}
		}


		var cstSelectTag = createSelectTag('carId', carList, 'carId', 'carModel','${baseUserLoginInfo.cusId}', 'fnObj.carChangeSelect();', colorObj, 180, 'select_b');
		$("#carSelect").html(cstSelectTag);



		//캘린더 세팅
		$("#inputUseDate").datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			yearRange: 'c-7:c+7',
			maxDate: new Date(),

			showButtonPanel: true,
			isRTL: false,
		    buttonImageOnly: false,
		    buttonText: ""
		});

		var nDate = new Date();
		$("#inputUseDate").datepicker('setDate', nDate);
	},

	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 설정 :S ----------------------------
    	/* 그리드 설정정보 */
    	var configObj = {

    		targetID : "SGridTarget_body",		//두번째  테이블

    		//그리드 컬럼 정보
    		colGroup : [
            {key:"startTime"},
            {key:"deptNm"},
            {key:"userNm"},
           	{key:"beMileage", formatter:function(obj){return Number(obj.item.beMileage).toLocaleString().split(".")[0];}},
            {key:"afMileage", formatter:function(obj){return Number(obj.item.afMileage).toLocaleString().split(".")[0];}},
            {key:"gap" , formatter:function(obj){return Number(obj.item.afMileage-obj.item.beMileage).toLocaleString().split(".")[0];} },
            {key:"businessYn" , formatter:function(obj){


            			return (obj.item.businessYn == 'Y' ? '일반 업무용' : '출·퇴근용');
            	}

            },
          	{key:"memo"}
            ],

            body : {
                onclick: function(obj, e){

                }
    		}

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td class="txt_center">#[0]</td>';
    	rowHtmlStr +=	 '<td class="txt_center">#[1]</td>';
    	rowHtmlStr +=	 '<td class="txt_center">#[2]</td>';
    	rowHtmlStr +=	 '<td style="text-align:right;padding-right:20px!important;">#[3] </td>';
    	rowHtmlStr +=	 '<td style="text-align:right;padding-right:20px!important;">#[4] </td>';
    	rowHtmlStr +=	 '<td style="text-align:right;padding-right:20px!important;">#[5] </td>';
    	rowHtmlStr +=	 '<td style="text-align:center;">#[6]</td>';
    	rowHtmlStr +=	 '<td class="left_txt" style="cursor:pointer;">#[7]</td>';
    	rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;


    	myGrid.setConfig(configObj);		//그리드 설정정보 세팅
    	//-------------------------- 그리드 설정 :E ----------------------------

     	//-------------------------- 모달창 :S -------------------------
    },//end pageStart.

    //검색
    doSearch: function(type){ 		//YM 년,월  YMD 년,월,일 -> 마지막 주행거리

    	//차량 아이디와 날짜
    	var carId =$("#carId").val();
    	if(carId > 0){

    		var selectDay=$("#year").val()+'-'+fillzero($("#month").val(), 2);

	    	var url = contextRoot + "/car2/getCarLogList.do";
	    	var param = {
			    			carId		:carId,
			    			selectDay	:selectDay,
			    		};


	    	var callback = function(result){

	    		var obj = JSON.parse(result);
	    		var max = obj.max;		//결과수
	    		var list = obj.logList;		//결과데이터JSON
				//console.log(max);
	    		myGrid.setGridData({				//그리드 데이터 세팅	*** 2 ***
									list: list		//그리드 테이터
								   });

	    		g_gridListStr = result;				//따로 전역변수에 넣어둔다
	    		$("#beforeDistance").empty();
	    		if(list.length>0){

	    			if(type == 'YMD'){		//일별로 주행전 거리 세팅

	    				var beforeDistance =0;
	    				var idx = 0;
		    			for(var i =0;i<list.length;i++){

		    				beforeDistance = list[i].beMileage;

		    				if($("#inputUseDate").val() >= list[i].startTime && idx ==0){	//선택일이 >= 시작일 보다 중에 제일 큰 값.
		    					beforeDistance = list[i].afMileage;
		    					idx =i;
		    					break;
		    				}

		    			}

		    			$("#beforeDistance").append(Number(beforeDistance).toLocaleString().split(".")[0]);

	    			}else $("#beforeDistance").append(Number(list[0].afMileage).toLocaleString().split(".")[0]);

	    		}else{
	    			$("#beforeDistance").append(Number(max).toLocaleString().split(".")[0]);
	    		}
	    		$("#totalDistance").val("")
				$("#calGap").empty();
	    		$("#totalDistance").focus();
	    		fnObj.divClear();
	    	};


	    	//로딩 이미지 보여주기 위한 리스너 함수 :E -----------
	    	commonAjax("POST", url, param, callback, true);
    	}

    },//end doSearch


    permissionChk: function(colorObj){


    	var param = {
				mainYn      : 'Y' ,
				searchType	: 'CAR',
				applyOrgId	: '${baseUserLoginInfo.applyOrgId}'
		};



    	userList = getCodeInfo(null,"","",null, null, null,'/common/getStaffListNameSort.do',param);
   		var userSelectTag = createSelectTag('userId', userList, 'userId', 'usrNm', '${baseUserLoginInfo.userId}', 'fnObj.userChangeSelect();', colorObj, 90, 'select_b w60pro');
		$("#normaluserDiv").empty();
		$("#adminuserDiv").html(userSelectTag);

		for(var i=0;i<userList.length;i++){
    		var sNb = userList[i].userId;
    		if(sNb==$("#userId").val()){
    			$("#teamNm").html(userList[i].deptNm);
    			$("#sabun").val(userList[i].sabun);
    			break;
    		}
    	}

	},//end permissionChk


	//차량 리스트 콤보 데이터
    getCarList: function(){

        var url = contextRoot + "/car2/carList.do";
     	var param = { sNb :$("#userId").val(), enable : 'Y'};		//, owned : 'B'		//법인차량

     	var callback = function(result){
     		var obj = JSON.parse(result)
     		carList = obj.resultList;
     	};
     	commonAjaxForSync("POST", url, param, callback);
     },//end getCarList


	//select 차종에 따른  model 변경
    carChangeSelect: function(){
    	var selectCarId = $('#carId').val();
    	for(var i=0;i<carList.length;i++){
    		var carId = carList[i].carId;
    		if(carId==selectCarId){
    			//$("#carModel").html(carList[i].carModel);
    			$("#carNick").val(carList[i].carNick);
    			break;
    		}
    	}
    	//var nDate = new Date();
		//$("#inputUseDate").datepicker('setDate', nDate);
    	fnObj.doSearch('YM');
    	$("#scheSeq").val("0");
    }, //end carChangeSelect

	///select 에 따른 부서 변경
    userChangeSelect: function(){
    	fnObj.divClear();
    	$("#scheSeq").val("0");
    	var selectSnb = $('#userId').val();

    	for(var i=0;i<userList.length;i++){
    		var sNb = userList[i].userId;
    		if(sNb==selectSnb){
    			$("#teamNm").html(userList[i].deptNm);
    			$("#sabun").val(userList[i].sabun);
    			break;
    		}
    	}


    }, //end carChangeSelect

	setYearMonthTag: function(){
		var maxYear = parseInt(new Date().yyyy_mm_dd().split("-")[0]);
    	var str = '';
		for(var i = 2015; i<= maxYear; i++){
			str+='<option value="'+i+'" '+(maxYear == i ? ' selected ="selected"' : '')+'>'+i+'년</option>';
    	}
    	$("#year").html(str);

    	var nowMonth = parseInt(new Date().yyyy_mm_dd().split("-")[1]);
    	str = '';
		for(var i = 1; i<= 12; i++){
			str+='<option value="'+i+'" '+(nowMonth == i ? ' selected ="selected"' : '')+'>'+i+'월</option>';
     	}
		$("#month").html(str);

    },//end setDate

   setDate: function(){

    	var year =$("#year").val();
    	var month=$("#month").val();
    	var nowmonth=$("#nowmonth").val();
    	var day = new Date().yyyy_mm_dd().split("-")[2];
    	var selectMonth;

		if(fullmonth!=new Date().yyyy_mm_dd().split("-")[1]){
			day='01';
		}
		$("#inputUseDate").val($("#year").val()+'-'+fillzero(month, 2) +'-'+fillzero(day, 2));

		fnObj.doSearch('YM');
    },//end setDate

  	popUpmemo: function(th){
   	 	if($("#scheSeq").val()==0){

		    	var url = contextRoot + "/car2/popUpmemo.do";
		     	var date = $("#inputUseDate").val();
		     	var carNick = $("#carNick").val();
		     	var params = {date: date,carNick :carNick,userId : $("#userId").val()};

		     	var callback = function(result){
		     		var obj = result;

		     		$("#spanSelSchedule").html(obj);
		     		$("#spanSelSchedule").show();
	     		};

	     	 $.ajax({
	    		type	: "POST",        			//"POST" "GET"
	    		url		: url,    					//PAGEURL
	    		data	: params,					//parameter object
	    		dataType: "html",
	    		timeout : 100000,       			//제한시간 지정(millisecond)
	    		cache 	: false,        			//true, false
	    		success	: callback,					//SUCCESS FUNCTION
	    		async	: true,
	    		error	: function whenError(x,e){	//ERROR FUNCTION
	    			alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
	    		}
	    	});
     	}
     },//end popUpmemo

     //팝업 메모 세팅
     setMemo: function(ScheSeq,ScheEDate,memo){
    	 if(ScheSeq>0){
     		$("#setScheArea").html(memo);
     		$("#scheSeq").val(ScheSeq);
 	    	if(ScheSeq>0){
 	    		$("#inputUseDate").val(ScheEDate);

 	    	}
 	    	$("#spanSelSchedule").hide();
 	    	$("#aDelCust").css("display","");
 	    	$("#scheBtn").hide();

    	 }

     },//end setMemo
    //################# else function :E #################


     //저장
     doSave: function(){

     	var memo=$("#memoArea").val();
     	var totalDistance=$("#totalDistance").val().replace(/,/g,'');
     	var useDate = $("#inputUseDate").val();
     	var scheSeq = $("#scheSeq").val();
     	var carId=$("#carId").val();

     	if(carId == 0 ){
			alert("차량을 선택해주세요.");
			$("#carId").focus();
			return;
        }

     	if(scheSeq=="0" && memo==""){
			alert("업무내용을 확인해주세요.");
			$("#memoArea").focus();
			return;
        }

        if(totalDistance==""||totalDistance=="0"||!strInNum(totalDistance)){
     	   alert("주행후 거리를 확인해주세요.");
     	  $("#totalDistance").focus();
     	   return;
        }

        var url = contextRoot + "/car2/insertCarLog.do";
     	var param = {
     			        carId   : carId,
     			        useDate : useDate,
     			        type    : $("input:radio[name=businessYn]:checked").val(),
     					totalDistance : totalDistance,
     					memo    :$("#memoArea").val(),
     					scheSeq :$("#scheSeq").val(),
     					sNb     :$("#userId").val()
 		    		};

     	//	alert(JSON.stringify(param));
     	var callback = function(result){
     		var obj = JSON.parse(result);
     		var sub = obj.resultObject;
     		var cnt = sub.cnt;
     		var errDis = sub.errDis;
     		if(cnt > 0){
     			toast.push("등록되었습니다!");
     			$("#scheSeq").val("0");
     			var arr =useDate.split("-");
     			$("#year").val(arr[0]);

     			$("#month").val(parseInt(arr[1]));

     			$("select[id='carId'] option[value="+carId+"]").prop("selected",true);

     			fnObj.doSearch('YM');
     		}else{
     			if(cnt==-2){
     				alert("입력하신 주행후 거리가 전날의 최종거리 보다 같거나 작습니다. 주행후 거리를 확인해주세요. [전날 최종거리:"+errDis+"KM]");
     			}
     			if(cnt==-3){
     				alert("입력하신 주행후 거리가  다음날의 최종거리 보다 같거나 큽니다. 주행후 거리를 확인해주세요. [다음날 최종거리:"+errDis+"KM]" );
     			}
     			if(cnt==-4){
     				alert("이미 등록된 최종 거리가 있습니다. 주행후 거리를 확인해주세요. " );
     			}
     		}
     	};
     	commonAjax("POST", url, param, callback, true, null, null);
     },//end doSave

    //차이계산
     calculateGap: function(){
    	fnObj.setComma();

    	if($("#totalDistance").val() !=''){
     		$("#calGap").empty();
         	var totalDistance = parseInt($("#totalDistance").val().replace(/,/g,''));
         	var beforeDistance=parseInt($("#beforeDistance").text().replace(/,/g,''));
         	$("#calGap").append(Number(totalDistance-beforeDistance).toLocaleString().split(".")[0]);
     	}else{
     		$("#calGap").html('');
     	}

     },//end calculateGap

 	//페이지 사이즈 세팅
    setPageSize: function(isSearch){

    	pageSize = $('#sel_page_size').val();

    	//검색도 바로할 경우 ... isSearch ... true
		if(isSearch){
			fnObj.doSearch('YM');
    	}
    },

	//input , 생성
    setComma : function(){

    	var str =  $("#totalDistance").val();
    	var result = addComma(str.replace(/,/gi,''));	// 천단위 콤마 추가한 결과값 리턴
    	if(result != undefined) $("#totalDistance").val(result);
		else $("#totalDistance").val('');

	},//end setComma

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

    divClear : function(){
    	$("#totalDistance").val("")
		$("#calGap").empty();
    	$("#scheSeq").val("0");
		$("#totalDistance").focus();
   		$("#memoArea").val("");
   		$("#setScheArea").empty();
   		$("#spanSelSchedule").empty();
   		$("#scheListArea").hide();
   		$("#aDelCust").hide();
   		$("#scheBtn").show();
    },//end divClear

    //날짜 변경
    changeDate : function(){
    	fnObj.divClear();

    	$("#year").val(($("#inputUseDate").val()).split("-")[0]);
    	$("#month").val(parseInt(($("#inputUseDate").val()).split("-")[1]));
    	fnObj.doSearch('YMD');
    },

    changeYM : function(){

    	$("#inputUseDate").val($("#year").val()+'-'+fillzero($("#month").val(),2)+'-01');
    	fnObj.doSearch('YMD');
    },

  	memoDivSet : function(obj){

    	if(obj.value==""){
    		$('#spanSelSchedule').show();
    	}else{
    		$('#spanSelSchedule').hide();
    	}


    }

};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){

		fnObj.preloadCode();		//선코딩
		fnObj.pageStart();		//화면세팅
		fnObj.setYearMonthTag();
		if($("#carId").val() != "0"){
			fnObj.carChangeSelect();
		}else{
			fnObj.divClear();
		}
		fnObj.doSearch('YM'); //해당 차량 리스트
});

</script>
