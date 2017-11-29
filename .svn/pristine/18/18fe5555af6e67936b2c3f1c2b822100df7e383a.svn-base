<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<input type="hidden" id="dateValue" name="dateValue" value="${date}">
<input type="hidden" id="popcarNick" name="popcarNick" value="${carNick}">

<!--일정확인 팝업-->
<div id="nowCarpop" class="tooltip_box">
    <!-- <h3 class="title"><strong> 최근등록일정</strong></h3>
    <h3 class="sub_txt">일정이 등록되어 있다면 선택해주세요.</h3> -->
    <!--최근등록 일정-->
    <div class="car2Popup_st_box">
	    <table class="car2Popup_tb_st" id="SGridTarget_pop" summary="최근등록일정">
	        <caption> 최근등록일정</caption>
	        <colgroup>
	            <col width="36" />
	            <col width="*" />
	            <col width="*" />
	            <col width="*" />
	            <col width="44" />
	        </colgroup>
	        <thead>
	            <th colspan="5">최근등록일정 <span class="days_txt" id="dateArea"></span></th>
	        </thead>
	        <tbody>
	        </tbody>
	   	</table>
	   	<div class="s_btnZone2">
			<a href="#;" onclick="javascript:$('#spanSelSchedule').hide();$('#spanSelSchedule').empty();" class="p_withelin_btn"><strong>닫기</strong></a>
		</div>
   	</div>
</div>


<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var myGridPopup = new SGrid();		// instance		new sjs

//공통코드(외,코드)

var nowList=new Array();



//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObjPopup = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
	},

	//화면세팅
    pageStart: function(){
    	var selectDate=$("#inputUseDate").val();

    	var configObj = {

    		targetID : "SGridTarget_pop",

    		//그리드 컬럼 정보
    		colGroup : [
            {key:""				,	formatter:function(obj){
            								return '<input type="checkbox" /><span class="blind">선택</span></label>';

        	}},
        	{key:"ScheEDate" 	,	formatter:function(obj){
            								return obj.item.ScheEDate.substring(5,10).replace(/-/gi,'/')+' (' +obj.item.ScheETime+')';

        	}},
        	/* {key:"ScheEDate" 	,	formatter:function(obj){
				return obj.item.ScheEDate+' ('+obj.item.ScheETime+')';

			}}, */
            {key:"activityNm"},
            {key:"ScheTitle",	formatter:function(obj){
            	return  obj.item.minScheTitle;

        	}},
        	{key:"",	formatter:function(obj){
        		 			var str='';
        					if(obj.item.ScheEDate == new Date().yyyy_mm_dd()){	//오늘 날짜 일정이면
        						str='<a href="#" class="icon_car_today"><em>TODAY</em></a>';
        					}
            				return  str;

        	}}
            ],

            body : {
                onclick: function(obj, e){
	                	if(obj.item!=null){
	                		fnObj.setMemo(obj.item.ScheSeq,obj.item.ScheEDate,obj.item.ScheTitle);
	                	}
                	}
			}

    	};
    	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td class="right_txt">#[0]</td>';
    	rowHtmlStr +=	 '<td class="left_txt">#[1]</td>';
    	rowHtmlStr +=	 '<td class="txt_blue">#[2]</td>';
    	rowHtmlStr +=	 '<td class="left_txt">#[3]</td>';
    	rowHtmlStr +=	 '<td class="left_txt">#[4]</td>';
    	rowHtmlStr +=	 '</tr>';
    	configObj.rowHtmlStr = rowHtmlStr;


    	myGridPopup.setConfig(configObj);

    },//end pageStart.

	 //스케쥴 가져오기
    getUserscheList: function(){

		var url = contextRoot+"/car2/popUpmemoAjax.do";
		var date = $("#dateValue").val();
		var carNick = $("#popcarNick").val();
		var sNb = $("#userId").val();
		var sabun =$("#sabun").val();
		var carNick = $("#popcarNick").val();
		var param = {
						date	:	date,
						carNick	:	carNick,
						sNb		:	sNb,
						sabun	:	sabun
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
		 	var selectDate=$("#inputUseDate").val();
			var arr = selectDate.split('-');
		 	sortByKey(list,'ScheEDate','ASC');

		 	//(2016/06/28 ~ 2016/07/04)
		 	//3일후
			var afDate = new Date(arr[0], arr[1]-1, arr[2]);
		    afDate.setDate(afDate.getDate()+3);
		    var afDateStr =afDate.getFullYear() + '-' + fillzero(afDate.getMonth()+1, 2) +'-'+fillzero(afDate.getDate(), 2);
		    //3일전
		    var beDate = new Date(arr[0], arr[1]-1, arr[2]);
		    beDate.setDate(beDate.getDate()-3);
		    var beDateStr =beDate.getFullYear() + '-' + fillzero(beDate.getMonth()+1, 2) +'-'+fillzero(beDate.getDate(), 2);
		 	if(new Date().yyyy_mm_dd() < afDateStr) afDateStr=new Date().yyyy_mm_dd();
		 	$("#dateArea").html('('+beDateStr.replace(/-/gi,'/')+' ~ '+afDateStr.replace(/-/gi,'/')+')');

			myGridPopup.setGridData({list:list});
    	};

		commonAjax("POST", url, param, callback);
    },



};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObjPopup.preloadCode();	//공통코드 or 각종선로딩코드
	fnObjPopup.pageStart();
	fnObjPopup.getUserscheList();

});

</script>