<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<form name="myForm" method="post">
	<div class="mo_container">
		<input type="hidden" name="familyEventsId" id = "familyEventsId">
		<table class="tb_basic_left">
	    	<colgroup>
				<col width="130" />
				<col width="*" />
			</colgroup>
			<tbody>
			    <c:choose>
			        <c:when test="${mode eq 'update'}">
			            <tr>
                            <th scope="row"><label for="eventTypeSelectTag">경조사타입</label></th>
                            <td>
                                <input type="hidden" name="eventType" id="eventType" />
                                <input type="hidden" name="eventCode" id="eventCode" />
                                <strong>[<span id="eventTypeNm"></span>-<span id="eventName"></span>]</strong>
                            </td>
                        </tr>
			        </c:when>
			        <c:otherwise>
			            <tr>
                            <th scope="row"><label for="eventTypeSelectTag">경조사타입</label></th>
                            <td><span id="eventTypeSelectTag"></span>
                                <span id="eventCodeSelectTag">
                                    <select id="eventCode" name="eventCode" class="select_b mgl6">
                                        <option value="">선택</option>
                                    </select>
                                </span>
                            </td>
                        </tr>
			        </c:otherwise>
			    </c:choose>

		 		<tr>
		 			<th scope="row"><label for="amount">경조금액</label></th>
		 			<td><input id="amount" type="text" name="amount" placeholder="경조금액 입력" value="" class="input_b w150px number" /></td>
		 		</tr>
				<tr>
		 			<th scope="row"><label for="period">휴가기간</label></th>
		 			<td><input id="period" type="text" name="period" placeholder="휴가기간 입력" value="" class="input_b w150px" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="holiday">휴일포함여부</label></th>
		 			<td>
		  				<select id="holiday" name="holiday" class="select_b">
		   					<option value='Y''>예</option>
		   					<option value='N' style='background-color:silver;'>아니오</option>
		   				</select>
		  			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="useYn">사용여부</label></th>
		 			<td><select id="useYn" name="useYn" class="select_b">
		   					<option value='Y''>예</option>
		   					<option value='N' style='background-color:silver;'>아니오</option>
		   				</select></td>
		 		</tr>
			</tbody>
		</table>
		<div class="btnZoneBox">
			<button id="btnSave" type="button" class="p_blueblack_btn btn_auth" onclick="fnObj.doSave();"><strong>저장</strong></button>
			<!-- <button id="btnDel" type="button" class="p_withelin_btn" onclick="fnObj.tryDelete();">삭제</button> -->
			<button id="btnDel" type="button" class="p_withelin_btn" onclick="parent.myModal.close();">닫기</button>
		</div>
	</div>
</form>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var comCodeEventType = getBaseCommonCode('EVENT_TYPE', lang, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.orgId}" });		//메뉴타입 공통코드 (Sync ajax)

//수정 , 저장시 사용
var codeSetName = "";
var comEventCodeType;
//저장시
var mode = "<c:out value='${mode==null?"new":mode}'/>";	//"new", "update"
//var menuId = "<c:out value='${menuId}'/>";	//"update" mode 메뉴아이디
var menuInfoObj = "<c:out value='${menuInfoObj}'/>";	//"update" mode 메뉴정보
var codeList = "${codeList}";							//기존 등록된 코드 리스트 문자열 ex) 'EAM,SYSTEM,ROL_PER_USER,...'

var inputTitleBorder;				//제목 border style
var contentBorder;					//내용 border style

var colorObj = {};

//Global variables :E ---------------

/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		var eventTypeSelectTag = createSelectTag('eventType', comCodeEventType, 'CD', 'NM', '', null, colorObj, 150, 'select_b');	//radio tag creator 함수 호출 (common.js)
		$("#eventTypeSelectTag").html(eventTypeSelectTag);

		$("#eventCode").prop("disabled",true);

	},
	eventTypeSelect : function(){

		var eventTypeSelect = $("#eventType").val();

		$("#eventCode").val("");
		//빈값으로 선택됬을때는 검색하지 않는다.
		if($("#eventType").val()=="") {
			$("#eventCode").prop("disabled",true);
			return;
		}

		var sonCodeName = "";
		for(var i = 0 ; i < comCodeEventType.length; i++){
			if(comCodeEventType[i].CD == eventTypeSelect){
				sonCodeName = comCodeEventType[i].sonCodeName;
			}
		}
		//공통코드
		comEventCodeType = getBaseCommonCode(sonCodeName, lang, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.orgId}" });		//메뉴타입 공통코드 (Sync ajax)

		var eventCodeSelectTag = createSelectTag('eventCode', comEventCodeType, 'CD', 'NM', '', null, colorObj, 150, 'select_b mgl6');	//radio tag creator 함수 호출 (common.js)
		$("#eventCodeSelectTag").html(eventCodeSelectTag);


		var preStr = $("#eventType").val();

		$("#eventCode option").each(function(){
			if($(this).val()=="") return true;

			var optionVal = $(this).val();
		});
		$("#eventCode").prop("disabled",false);


	},

	//화면세팅
    pageStart: function(){

    	//입력값 패턴 지정
    	$('#amount').bindPattern({pattern:'custome', max_length:9, patternString:'9999'});		//메뉴번호(퀵넘버)
    	$('#period').bindPattern({pattern:'custome', max_length:3, patternString:'9999'});		//메뉴번호(퀵넘버)



    	if(mode=="new")		//신규일때 삭제버튼 hide
    		$('#btnDel').hide();

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//저장
    doSave: function(){

    	//-------------------- validation :S --------------------
    	var frm = document.myForm;

    	if(isEmpty(frm.eventCode.value)){			//코드명
    		dialog.push({body:"<b>확인!</b> 경조사분류를 선택해주세요!", type:"", onConfirm:function(){frm.eventCode.focus();}});
    		return;
    	}
    	if(isEmpty(frm.amount.value)){			//한글명
    		dialog.push({body:"<b>확인!</b> 경조금액을 입력해주세요!", type:"", onConfirm:function(){frm.amount.focus();}});
    		return;
    	}
    	if(isEmpty(frm.period.value)){		//설명
    		dialog.push({body:"<b>확인!</b> 휴가기간을 입력해주세요!", type:"", onConfirm:function(){frm.period.focus();}});
    		return;
    	}

    	/* if(frm.period.value == "0"){
    		dialog.push({body:"<b>확인!</b> 휴가기간은 1일 이상 입력해주세요!", type:"", onConfirm:function(){frm.period.focus();}});
    		return;
    	} */

    	//CODE_SET_NAME
    	if(mode!="update"){
	    	for(var i = 0 ; i < comCodeEventType.length; i++){
				if(comCodeEventType[i].CD == frm.eventType.value){
					codeSetName = comCodeEventType[i].sonCodeName;
				}
			}
    	}
    	//-------------------- validation :E --------------------

    	var amount = frm.amount.value;
    	var url = contextRoot + "/approve/doSaveEventInfo.do";
    	var param = {
    			mode: mode,			//화면 모드 mode : "new", "update"
    			eventCode: frm.eventCode.value,
    			amount: amount.split(",").join(""),
    			period: frm.period.value,
    			holiday: frm.holiday.value,
    			familyEventsId: frm.familyEventsId.value,
    			useYn: frm.useYn.value,
    			codeSetName:codeSetName
    	}



    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    		}

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			parent.fnObj.doSearch(parent.curPageNo);	//목록화면 재조회 호출.
    			parent.myModal.close();						//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("저장OK!");
    		}else{
    			if(cnt == "0"){
					dialog.push({body:"<b>확인!</b> 이미 등록된 경조사입니다.", type:"", onConfirm:function(){parent.myModal.close();}});
		    		return;
				}
    		}

    	};


    	commonAjax("POST", url, param, callback);
    },//end doSave


    //경조사정보 가져오기
    getEventInfo: function(){
		var frm = document.myForm;
    	var menuInfo = JSON.parse(menuInfoObj.replace(/&#034;/gi,'"'));
		$("#eventType").prop("disabled",true);

    	//경조사정보 세팅
		frm.familyEventsId.value = menuInfo.familyEventsId;
		frm.eventType.value = menuInfo.eventType;
		frm.eventCode.value = menuInfo.eventCode;
		frm.amount.value = menuInfo.amount;
		frm.period.value = menuInfo.period;
		frm.holiday.value = menuInfo.holiday;
		frm.useYn.value = menuInfo.useYn;

		$("#eventTypeNm").html(menuInfo.eventTypeNm);
		$("#eventName").html(menuInfo.eventName);

    },//end getArticle


    //메뉴삭제 (일단 enable(사용여부 N 으로... 사용여부N으로 하고 저장하는 부분과 중복이나, 바서 진짜 삭제해도 되면 삭제!!!!!!))
    tryDelete: function(){
    	/*
    	dialog.push({body:'<b>Caution</b> 삭제하시겠습니까?',
    				 type:'Caution',
    				 onConfirm:fnObj.doDelete,
    				 data:'onConfirmData'});
    	*/

    	dialog.push({
		    body:'<b>Caution</b>&nbsp;&nbsp;삭제하시겠습니까?', top:0, type:'Caution', buttons:[
                {buttonValue:'삭제', buttonClass:'Red', onClick:fnObj.doDelete},	//, data:{param:"222"}},	//Red W100
                {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}	//, data:'data2'},
                //{buttonValue:'button3', buttonClass:'Green', onClick:fnObj.btnClick, data:'data3'}
		    ]});
    },
    doDelete: function(){

    	var url = contextRoot + "/approve/deleteEventInfo.do";
    	var param = {
    			familyEventsId: document.myForm.familyEventsId.value
    	}
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    		}

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){
    			parent.fnObj.doSearch(parent.curPageNo);	//목록화면 재조회 호출.
    			parent.myModal.close();						//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("삭제OK!");
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);

    },
  	//################# else function :E #################

};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅

	//수정모드일때 내용가져오기
	if(mode=="update" && menuInfoObj.length>0){
		fnObj.getEventInfo();
	}


	$("#eventType").on("change",function(){
		fnObj.eventTypeSelect();
	});

	numberFormatForNumberClass();

});

</script>