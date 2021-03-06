<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<section id="detail_contents">

	<div class="carSearchBox">


		<label for="orgSelBox"><span class="carSearchtitle">회사선택</span></label>
		<select class="select_b mgr20" id="orgSelBox" name = "orgSelBox" title="회사선택" onchange="fnObj.doSearch();">
			<!-- <option value="">전체</option> -->
			<c:forEach items="${accessOrgIdList }" var = "data">
				<option value="${data.orgId }"  targetAuth = "${data.orgAccessAuthType }"
					<c:if test = "${data.orgId eq baseUserLoginInfo.applyOrgId}">selected="selected"</c:if>
				>${data.cpnNm }</option>
			</c:forEach>
		</select>

		<span class="carSearchtitle">퇴사여부 :</span>
		<span class="rd_List">
			<label><input type="radio" name = "firedType" value="" onclick="fnObj.doSearch();"/><span>전체보기</span></label>
			<label><input type="radio" name = "firedType" value="1" onclick="fnObj.doSearch();" checked="checked"/><span>유효사용자</span></label>
			<label><input type="radio" name = "firedType" value="0" onclick="fnObj.doSearch();"/><span>퇴사자</span></label>
		</span>
		<input class="input_b2 w200px mgl20" id = "search" name = "search" placeholder="직원검색" onkeypress="if(event.keyCode==13) {fnObj.doSearch(); return false;}">
		<a href="javascript:fnObj.doSearch();" class="btn_g_black mgl10"><em>검색</em></a>
		<div class="btnRightZone">
			<button name="reg_btn" class="btn_b2_skyblue" onclick="fnObj.excelDownload();"><em class="icon_XLS">파일로 저장</em></button>
		</div>
	</div>

	<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span class="pointB">사용자정보</span><span>는 해당 사용자 셀 클릭 시 볼 수 있습니다.</span></div>
	<div id="AXGridTarget"></div>

	<div class="systemBtnzone">
		<button type="button" class="AXButton Classic btn_auth" onclick="fnObj.viewUserProfile();"><i class="axi axi-search3" style="font-size:12px;"></i> 사용자프로파일</button>
		<button type="button" class="AXButton Classic btn_auth" onclick="fnObj.addOpen();"><i class="axi axi-add" style="font-size:12px;"></i> 신규등록</button>
	</div>


</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var orgCodeCombo;				//ORG 코드

var mySearch = new AXSearch(); 	// instance
var myGrid = new AXGrid(); 		// instance

var myModal = new AXModal();	// instance
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드

		var params = null;
		params = {'authOrgId':'Y', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', '', '전체', 'SELECT', '/common/getOrgCodeCombo.do', params);		//ORG코드(콤보용) 호출

	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 :S -------------------------
    	myGrid.setConfig({
            targetID : "AXGridTarget",
            theme : "AXGrid",

            fixedColSeq : 5,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

            height: 570,		//grid height
            //width: '95%',

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            //passiveMode:true,
			//passiveRemoveHide:false,

            colGroup : [
                {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<span class='fontGray\'>" + (this.index + 1) + "</font>");
                }},

                /* {key:"userId", 		label:"ID", 			width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}}, */
                {key:"chk", 		label:" ",  			width:"30",		align:"center", sort: false,  formatter:function(){return ("<input type='radio' name='mCheck' onclick='fnObj.clickRadio(this, " + this.index + ");' " + ((this.value==1)?"checked":"") + "/>");}},
                {key:"showEmpNo", 		label:"사번", 			width:"90",	align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"loginId",		label:"로그인ID",		width:"110",	align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"name",		label:"이름", 			width:"65",		align:"center"},
                {key:"empTypeNm",	label:"채용형태", 		width:"65",		align:"center"},
                {key:"companyNm", 	label:"소속회사", 		width:"120",	align:"left"},
                {key:"orgNm", 		label:"관계사명", 		width:"120",	align:"left"},
                {key:"roleNm", 		label:"권한", 		width:"120",	align:"left"},
                {key:"rankNm", 		label:"직위", 			width:"65",		align:"center"},
                {key:"work", 		label:"담당업무", 		width:"120",	align:"left"},
                {key:"deptInchargeObj",label:"부서(직책)", 	width:"170",	align:"left", formatter:function(){
                																					var result = "";
                																					if(this.value != null){
                																						var obj = JSON.parse(this.value);
                    																					for(var i=0; i<obj.length; i++){
                    																						result += obj[i].deptNm;
                    																						if(obj[i].incharge == 'DEPT_MGR')
                    																							result += ' <strong style="color:#407bea;">(부서장)</strong>';
                    																						if(i!=obj.length-1){
                    																							result += ", ";
                    																						}
                    																					}
                																					}
                																					return result;
                																				}},

                {key:"mobileTel", 	label:"핸드폰", 			width:"95",		align:"center",	formatter:function(){return toPhoneFormat(this.value);}},
                {key:"email", 		label:"이메일", 			width:"160",	align:"left"},
                {key:"cusNm", 		label:"네트워크고객",		width:"95",		align:"center",	formatter:function(){
                																					if(isEmpty(this.value)){
                																						return '<font color=red>미등록</font>';
                																					}else{
                																						return this.value;
                																					}
																								}},
                {key:"companyTel", 	label:"회사전화", 		width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
                {key:"companyFax", 	label:"회사팩스", 		width:"90",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
                {key:"hiredDate", 	label:"입사일", 			width:"75",		align:"center"},
                {key:"joinDate", 	label:"정식입사일", 		width:"75",		align:"center"},
                {key:"userStatusNm",label:"상태", 			width:"70",		align:"center"},
                {key:"homeZip", 	label:"집우편번호", 		width:"80",		align:"center"},
                {key:"homeAddr1", 	label:"집기본주소", 		width:"130",	align:"left"},
                {key:"homeAddr2", 	label:"집나머지주소", 	width:"110",	align:"left"},
                {key:"homeTel", 	label:"집전화", 			width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
               /*  {key:"homepage", 	label:"홈페이지", 		width:"130",	align:"left"}, */
                {key:"hobby", 		label:"취미", 			width:"70",		align:"center"},
                {key:"sosTel", 		label:"비상연락처", 		width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
                {key:"sosRelationNm", label:"비상연락처관계",	width:"70",		align:"center"},
                {key:"bloodNm", 	label:"혈액형", 			width:"70",		align:"center"},
                {key:"religionNm", 	label:"종교", 			width:"70",		align:"center"},
                {key:"passport", 	label:"여권번호", 		width:"70",		align:"center"},
                {key:"marriedDate", label:"결혼일", 			width:"75",		align:"center"},
                {key:"firedDate", 	label:"퇴사일", 			width:"75",		align:"center"},
                {key:"createDate", 	label:"등록일", 			width:"75",		align:"center"},
                {key:"createNm", 	label:"등록자", 			width:"70",		align:"center"},
                {key:"updateDate", 	label:"수정일", 			width:"75",		align:"center"},
                {key:"updateNm", 	label:"수정자", 			width:"70",		align:"center"}

                /*{key:"USER_ROLE", label:"권한 <i class='axi axi-help2'></i>", width:"200", align:"center", sort: false, formatter: function(val){
                		var colorObj = {'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
						return createSelectTag('selUserRole'+(this.index), comCodeRoleCd, 'CD', 'NM', this.item.roleCode, 'fnObj.changeRoleCode(this,' + this.item.userId + ');', colorObj);	//select tag creator 함수 호출 (common.js)
					}
				}*/
                //{key:"USER_ROLE",		label:"권한", 	width:"200",	align:"center"},
            ],
            body : {
                onclick: function(){
                    if(this.c >= 3){		//this.c == 1 || this.c == 3 || this.c == 4 || this.c == 5 ){		//메뉴보기
                		//fnObj.viewMenu(this.item.menuId);
                		fnObj.viewUser(this.list[this.index]);	//메뉴정보보기 (메뉴정보 객체전달)
                	}

                },

                ondblclick: function(){
                	//fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
                }

            },
			page:{
				fullSizeButton: true,		//grid full size button

				paging:false,
				status:{formatter: null}
			}

        });
    	//-------------------------- 그리드 :E -------------------------

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
    		}
            ,contentDivClass: "popup_outline"
    	});
    	//-------------------------- 모달창 :E -------------------------



    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	//var pars = mySearch.getParam();


    	var auth = $("#orgSelBox option:selected").attr("targetAuth");
    	if(auth == "READ"){
			$(".btn_auth").hide();
		}else{
			$(".btn_auth").show();
		}

    	var url = contextRoot + "/user/getUserList.do";
    	/* var param = mySearch.getParam().queryToObjectDec();			//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    		param.orgId = $('select[name=orgSelBox]').val();	//선택 ORG id  */

    	var param = {
    					orgId 		: $("#orgSelBox").val(),
    					firedType 	: $('input[name=firedType]:checked').val(),
    					search		: $("#search").val(),
    	};


    	var callback = function(result){

    		var obj = JSON.parse(result);


    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		var gridData = {list:list,
    						page:{listCount:cnt}};

    		myGrid.clearSort();			//소팅초기화
    		myGrid.setData(gridData);	//그리드에결과반영
    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


    //엑셀다운
    excelDownload: function(){
    	 excelDown(myGrid.getExcelFormat('html'), "download");		//common.js
    },


    //툴팁 세팅
    setTooltip: function(){
    	var tooltipStr = '';

    	tooltipStr += "수정을 하시려면 해당 사용자를 클릭하시기 바랍니다";

  		AXPopOver.bind({
  	        id:"myPopOver",
  	        theme:"AXPopOverTooltip", 	// 선택항목
  	        width:"200", 				// 선택항목
  	        body:tooltipStr				//"설명입니다.<br/>액시스제이는 이렇게 유용 합니다."
  	    });
  		$("#ttipUserRole").bind("mouseover", function(event){
  	        AXPopOver.open({id:"myPopOver", sendObj:{}}, event); // event 직접 연결 방식
  	    });
  	},

  	//사용자등록 버튼 클릭
    addOpen: function(){
    	var url = "<c:url value='/user/addUser.do'/>";
    	var params = {mode:'new'};	//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

    	//params 에 코드리스트 전달------
    	var list = myGrid.getList();	//그리드 데이터(array object)
    	var codeList  = '';				//코드리스트(','로 연결된 문자열)
    	for(var i=0; i<list.length; i++){
    		codeList += list[i].loginId.toUpperCase() + ',';
    	}
    	params.codeList = codeList;		//파라미터에 추가(key,value)
    	params.orgId = $('#orgSelBox').val();

    	var obj = getRowObjectWithValue(orgCodeCombo, 'orgId', $('#orgSelBox').val());
    	var orgName = obj.orgNm;
    	params.orgName = orgName;//$('select[name=orgSelBox] option:selected').text();

    	//-----------------------------

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '사용자등록',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 150,
    		width: 850,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },//end writeOpen


  	//사용자보기
    viewUser: function(userInfoObj){

    	var deptInchargeObj = userInfoObj.deptInchargeObj;		//부서(직책) 정보 객체

    	var newUserInfoObj = JSON.parse(JSON.stringify(userInfoObj));	//객체 카피(하단에서 객체값을 바꾸므로, 원 데이터를 유지 시켜주기위해)
    	newUserInfoObj.deptInchargeObj = "";					//파싱에러를 막기위해 객체값은 없애준다.(위에서 따로 뺐으므로)

    	//console.log(JSON.stringify(newUserInfoObj));
    	var url = "<c:url value='/user/addUser.do'/>";
    	var params = {mode : 'update',
    				  userInfoObj : JSON.stringify(newUserInfoObj),
    				  deptInchargeObj : deptInchargeObj
    				};

    	//params 에 코드리스트 전달------
    	var list = myGrid.getList();	//그리드 데이터(array object)
    	var codeList  = '';				//코드리스트(','로 연결된 문자열)
    	for(var i=0; i<list.length; i++){
    		codeList += list[i].loginId.toUpperCase() + ',';
    	}
    	params.codeList = codeList;		//파라미터에 추가(key,value)
    	//-----------------------------

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '사용자보기',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 150,
    		width: 850,
    		closeByEscKey: true			//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },//end writeOpen


  	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },


    //사용자프로파일 팝업 위해 체크박스 validation
    checkChkValidUpDown: function(){

    	var list = myGrid.getList();
    	var chkCnt = 0;
    	var chkIndex = -1;
    	for(var i=0; i<list.length; i++){
    		if(list[i].chk == 1){
    			chkCnt++;
    			chkIndex = i;
    		}
    	}

    	if(chkCnt==0){
    		alertM("사용자를 먼저 선택해주세요! (라디오버튼)");
    		return -1;
    	}else{
    		return chkIndex;
    	}
    },

    //사용자프로파일 팝업
    viewUserProfile: function(){
    	//체크박스 체크 validation
    	var chkIndex = this.checkChkValidUpDown();
    	if(chkIndex == -1){		//false(체크된것이 없거나, 2개이상)
    		return;				//끝낸다.
    	}


    	// 팝업
    	var url = "<c:url value='/user/popupUserProfile.do'/>";
    	var params = {mode:'update',	//사용자 프로파일은 수정모드(mode:"update")만 존재한다.(최초등록은 사용자 등록때 동시실행)
    				  empNo:myGrid.getList()[chkIndex].empNo,
    				  targetOrgId : myGrid.getList()[chkIndex].orgId
    				  }; 	//사번만을 넘겨 재조회하도록 한다.

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '사용자 프로파일',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 100,
    		width: 700,
    		closeByEscKey: true			//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },

  	//그리드 라디오 클릭 이벤트 핸들러 (그리드 data Sync)
    clickRadio: function(obj, idx){

    	var list = myGrid.getList();
    	for(var i=0; i<list.length; i++){

    		if(idx == i){
    			list[i].chk = 1;
    		}else{
    			list[i].chk = 0;
    		}

    	}

    },

  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색
	fnObj.setTooltip();
});
</script>