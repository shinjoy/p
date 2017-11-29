<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<section id="detail_contents">
	<div class="carSearchBox">

		<label><span class="carSearchtitle">회사선택</span></label>
		<select class="select_b mgr20" id="orgSelBox" name = "orgSelBox" title="회사선택" onchange="fnObj.doSearch();">
			<!-- <option value="">전체</option> -->
			<c:forEach items="${accessOrgIdList }" var = "data">
				<option value="${data.orgId }" targetAuth = "${data.orgAccessAuthType }"
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
	<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span>수정을 하시려면 해당</span><span class="pointB"> 사번, 로그인ID, 이름 </span><span>중 하나를 클릭하시면 수정팝업이 뜹니다.</span></div>
	<div id="AXGridTarget"></div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var comCodeLanguage;				//사용언어
var comCodeTimezone;				//시간대
var orgCodeCombo;					//관계사



var customerInfoLevelObj;			//고객정보 조회권한
var businessInfoLevelObj;			//영업정보 조회권한
var boardInfoLevelObj;				//업무게시판 조회권한


var codeYn;

var mySearch = new AXSearch(); 	// instance
var myGrid = new AXGrid(); 		// instance

var myModal = new AXModal();	// instance

var nonModifyYn = "N";
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

		comCodeLanguage = getBaseCommonCode('LANGUAGE', lang, 'CD', 'NM',null,'','',{ orgId : "${baseUserLoginInfo.applyOrgId}"});		//사용언어 공통코드 (Sync ajax)
		if(comCodeLanguage == null){
			comCodeLanguage = [{'CD': '', 'NM': '선택'}];
		}
		comCodeTimezone = getBaseCommonCode('TIMEZONE', lang, 'CD', 'NM',null,'','',{ orgId : "${baseUserLoginInfo.applyOrgId}"});		//사용언어 공통코드 (Sync ajax)
		if(comCodeTimezone == null){
			comCodeTimezone = [{'CD': '', 'NM': '선택'}];
		}
		codeYn = [{'CD':'Y', 'NM':'Y'}, {'CD':'N', 'NM':'N'}];

		//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
		//this.addComCodeArray(comCodeMenuType);



	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 그리드 :S -------------------------
    	myGrid.setConfig({
            targetID : "AXGridTarget",
            theme : "AXGrid",

            fixedColSeq : 3,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

            height: 620,		//grid height
            //width: '95%',

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            //passiveMode:true,
			//passiveRemoveHide:false,

            colGroup : [
                {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<span class='fontGray/'>" + (this.index + 1) + "</b></font>");
                }},

                {key:"showEmpNo", 	label:"사번", 			width:"100",	align:"center",	formatter:function(){return ("<strong>" + (this.value) + "</strong>");}},
                {key:"loginId",		label:"로그인ID",		width:"110",	align:"center",	formatter:function(){return ("<strong>" + (this.value) + "</strong>");}},
                {key:"name",		label:"이름", 			width:"65",		align:"center",	formatter:function(){return ("<strong>" + (this.value) + "</strong>");}},

                {key:"language",	label:"사용언어", 		width:"80",		align:"center",	sort: false, formatter: function(val){
            			var colorObj = {'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
            			return createSelectTag('selLanguage'+(this.index), comCodeLanguage, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","language")' , colorObj, null, 'change_direct select_b','disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
                {key:"timezone", 	label:"시간대", 			width:"80",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
	        			return createSelectTag('selTimezone'+(this.index), comCodeTimezone, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","timezone")' , colorObj, null, 'change_direct select_b','disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
                {key:"status",	 	label:"사용", 			width:"80",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selStatus'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","status")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"workViewYn", 	label:"업무일지전체열람", 		width:"100",		align:"center",	sort: false, formatter: function(val){
        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
        			return createSelectTag('workViewYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","workViewYn")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				}
				,
	            {key:"cardViewYn", 	label:"지출등록전체열람", 	width:"100",		align:"center",	sort: false, formatter: function(val){
	            	var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
        			return createSelectTag('cardViewYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","cardViewYn")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}

				}
				,
				{key:"scheduleViewYn",	label:"근태전체열람", 	width:"100",		align:"center",	sort: false, formatter: function(val){
					var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	    			return createSelectTag('scheduleViewYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","scheduleViewYn")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				},

                {key:"payrollYn", 	label:"급여대상", 		width:"80",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selPayrollYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","payrollYn")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},

                {key:"systemYn", 	label:"시스템사용", 		width:"80",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selSystemYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","systemYn")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				}
				,
                {key:"wholeMemoViewYn", 	label:"전사메모권한", 	width:"85",		align:"center",	sort: false, formatter: function(val){
                		if(parseInt( this.item.orgId) != 1){
                			return "<span>N</span>";
                		}
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selWholeMemoViewYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","wholeMemoViewYn")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				}
				,
				{key:"businessInfoLevel",	label:"영업정보조회권한", 	width:"95",		align:"center",	sort: false
					, formatter: function(val){
						return createSelectTag('businessInfoLevel'+(this.index), businessInfoLevelObj, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","businessInfoLevel")', {}, null, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));
					}
				},
				{key:"customerInfoLevel",	label:"고객정보조회권한", 	width:"95",		align:"center",	sort: false
					, formatter: function(val){
						return createSelectTag('customerInfoLevel'+(this.index), customerInfoLevelObj, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","customerInfoLevel")', {}, null, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));
					}
				},
				{key:"boardInfoLevel",	label:"업무게시판조회권한", 	width:"95",		align:"center",	sort: false
					, formatter: function(val){
						return createSelectTag('boardInfoLevel'+(this.index), boardInfoLevelObj, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","boardInfoLevel")', {}, null, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));
					}
				},
                {key:"projectYn", 	label:"${baseUserLoginInfo.projectTitle}할당", 	width:"85",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selProjectYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","projectYn")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"carWorkYn", 	label:"차량사용여부", 	width:"85",		align:"center",	sort: false, formatter: function(val){
        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
        			return createSelectTag('selCarWorkYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","carWorkYn")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
                {key:"attendYn", 	label:"출근체크대상", 	width:"85",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selAttendYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","attendYn","' + this.index + '")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				},
                {key:"mobileAttend",label:"모바일출근연동", 		width:"80",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selMobileAttend'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","mobileAttend","' + this.index + '")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"loginAttend",	label:"PC출근연동", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selLoginAttend'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","loginAttend","' + this.index + '")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				},
                {key:"secomAttend",	label:"세콤출근", 		width:"80",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selSecomAttend'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","secomAttend","' + this.index + '")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"expenseYn", 	label:"지출입력필수자", 	width:"95",		align:"center",	sort: false, formatter: function(val){
        				var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
        				return createSelectTag('selExpenseYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","expenseYn")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				},

                {key:"securityLogin",label:"보안서버로그인", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selSecurityLogin'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","securityLogin","' + this.index + '")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
                {key:"singleSignOn",label:"싱글사인온", 		width:"80",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selSingleSignOn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","singleSignOn","' + this.index + '")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},

                {key:"costingYn",	label:"비용분석대상자", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selCostingYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","costingYn")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
                {key:"timesheetYn",	label:"타임시트필수자", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selTimesheetYn'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","timesheetYn")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"makeProject",	label:"${baseUserLoginInfo.projectTitle}생성", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selMakeProject'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","makeProject")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"closeProject",	label:"${baseUserLoginInfo.projectTitle}마감", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selCloseProject'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","closeProject")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"closeTimesheet",	label:"타임시트마감", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selCloseTimesheet'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","closeTimesheet")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"openCalendar",	label:"캘린더오픈", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selOpenCalendar'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","openCalendar")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"closeCalendar",	label:"캘린더마감", 	width:"95",		align:"center",	sort: false, formatter: function(val){
	        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
	        			return createSelectTag('selCloseCalendar'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","closeCalendar")', colorObj, 35, 'change_direct select_b', (nonModifyYn=='Y'?'disabled':''));		//select tag creator 함수 호출 (common.js)
					}
				},
			 	{key:"bCardYn",	label:"법인카드소지여부", 	width:"95",		align:"center",	sort: false, formatter: function(val){
        			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
        			return createSelectTag('selCloseCalendar'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","bCardYn")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},
				{key:"bCardControl",	label:"법인카드관리대상여부", 	width:"95",		align:"center",	sort: false, formatter: function(val){
		    			var colorObj = {'Y':'#ffffff', 'N':'#ededed'};
		    			return createSelectTag('selCloseCalendar'+(this.index), codeYn, 'CD', 'NM', this.value, 'fnObj.doChangeIt(this,"' + this.item.userId + '","bCardControl")', colorObj, 35, 'change_direct select_b', 'disabled');		//select tag creator 함수 호출 (common.js)
					}
				},


				{key:"userStatusNm",label:"상태", 			width:"80",		align:"center"},
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

                	if(this.c == 1 || this.c == 2 || this.c == 3){		//사용자 프로파일 보기
                		//fnObj.viewMenu(this.item.menuId);

                		fnObj.viewUserProfile(this.list[this.index]);	//사용자 프로파일 보기 (사용자 프로파일 객체전달)
                	}

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

    	comCodeLanguage = getBaseCommonCode('LANGUAGE', lang, 'CD', 'NM',null,'','',{ orgId : $("#orgSelBox").val() });		//사용언어 공통코드 (Sync ajax)
		if(comCodeLanguage == null){
			comCodeLanguage = [{'CD': '', 'NM': '선택'}];
		}
		comCodeTimezone = getBaseCommonCode('TIMEZONE', lang, 'CD', 'NM',null,'','',{ orgId : $("#orgSelBox").val()});		//사용언어 공통코드 (Sync ajax)
		if(comCodeTimezone == null){
			comCodeTimezone = [{'CD': '', 'NM': '선택'}];
		}

		customerInfoLevelObj = getBaseCommonCode('CUSTOMER_INFO_LEVEL', lang, 'CD', 'NM',null,'','',{ orgId : $("#orgSelBox").val()});		//사용언어 공통코드 (Sync ajax)
		if(customerInfoLevelObj == null){
			customerInfoLevelObj = [{'CD': '', 'NM': '선택'}];
		}

		boardInfoLevelObj = getBaseCommonCode('BOARD_INFO_LEVEL', lang, 'CD', 'NM',null,'','',{ orgId : $("#orgSelBox").val()});		//사용언어 공통코드 (Sync ajax)
		if(boardInfoLevelObj == null){
			boardInfoLevelObj = [{'CD': '', 'NM': '선택'}];
		}

		businessInfoLevelObj = getBaseCommonCode('BUSINESS_INFO_LEVEL', lang, 'CD', 'NM',null,'','',{ orgId : $("#orgSelBox").val()});		//사용언어 공통코드 (Sync ajax)
		if(businessInfoLevelObj == null){
			businessInfoLevelObj = [{'CD': '', 'NM': '선택'}];
		}

    	var url = contextRoot + "/user/getUserProfile.do";
    	//var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서

    	var param = {
    					targetOrgId : $("#orgSelBox").val(),
    					firedType 	: $('input[name=firedType]:checked').val(),
    					search		: $("#search").val(),
    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var auth = $("#orgSelBox option:selected").attr("targetAuth");

			if(auth == "READ"){
				nonModifyYn = "Y";
			}else{
				nonModifyYn = "N";
			}

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		var gridData = {list:list};

    		myGrid.clearSort();			//소팅초기화
    		myGrid.setData(gridData);	//그리드에결과반영
    	};

    	commonAjax("POST", url, param, callback, false);
    },//end doSearch


    //엑셀다운
    excelDownload: function(){
    	 excelDown(myGrid.getExcelFormat('html'), "download");		//common.js
    },


  	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },

  //셀렉트 박스 이벤트
    doKeyUpEnter: function(event, obj, userId, colNm){

    	//엔터를 친 경우
    	if(event.keyCode == 13){
	    	var url = contextRoot + "/user/changeUserProfile.do";
	    	var param = {
	    			userId: userId    		//사용자 ID
	    	}
	    	param[colNm] = obj.value;		//바꾸려는 컬럼명과 값 으로 (key/value) 전달



	    	var callback = function(result){

	    		var obj = JSON.parse(result);


	    		var cnt = obj.resultVal;	//결과수

	    	    if(obj.result == "SUCCESS"){

	    	    	toast.push("저장하였습니다!");

	    			fnObj.doSearch();	//재검색

	    		}

	    	};

	    	commonAjax("POST", url, param, callback);
    	}
    	return;
    },

    //콤보박스 이벤트 함수
    doChangeIt: function(objSelect, userId, colNm, idx){

    	var selectValue =objSelect.value;

    	var url = contextRoot + "/user/changeUserProfile.do";
    	var param = {
    			userId: userId    		//사용자 ID
    	}
    	if(colNm == "attendYn" && objSelect.value == "N" ){
    		param["mobileAttend"] = "N";
    		param["secomAttend"] = "N";
    		param["loginAttend"] = "N";
    		param["securityLogin"] = "N";
    		param["singleSignOn"] = "N";
    	}else if((colNm == "mobileAttend" || colNm == "secomAttend" || colNm == "loginAttend" || colNm == "securityLogin" || colNm == "singleSignOn")
    			&& objSelect.value == "Y" ){
            param["attendYn"] = "Y";
        }

    	param[colNm] = objSelect.value;      //바꾸려는 컬럼명과 값 으로 (key/value) 전달




    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var cnt = obj.resultVal;	//결과수

    	    if(obj.result == "SUCCESS"){

    	    	toast.push("저장하였습니다!");

    			//fnObj.doSearch();	//재검색

    			$(objSelect).css("background-color",selectValue == "Y" ? "#FFFFF" : "#ededed" );

    	    	if(colNm == "attendYn" && selectValue == "N" ){

    	    		$("#selAttendYn"+idx).val("N").prop("selected", true).css("background-color","#ededed");
    	    		$("#selMobileAttend"+idx).val("N").prop("selected", true).css("background-color","#ededed");
    	    		$("#selLoginAttend"+idx).val("N").prop("selected", true).css("background-color","#ededed");
    	    		$("#selSecomAttend"+idx).val("N").prop("selected", true).css("background-color","#ededed");
    	    		$("#selSecurityLogin"+idx).val("N").prop("selected", true).css("background-color","#ededed");
    	    		$("#selSingleSignOn"+idx).val("N").prop("selected", true).css("background-color","#ededed");

    	    	}else if((colNm == "mobileAttend" || colNm == "secomAttend" || colNm == "loginAttend" || colNm == "securityLogin" || colNm == "singleSignOn")
    	    			&& selectValue == "Y" ){
    	    		$("#selAttendYn"+idx).val("Y").prop("selected", true).css("background-color","#FFFFF");
    	        }

    		}

    	};

    	commonAjax("POST", url, param, callback);
    },


  	//사용자 프로파일 보기
    viewUserProfile: function(userInfoObj){

    	var url = "<c:url value='/user/popupUserProfile.do'/>";
    	var params = {mode:'update',	//사용자 프로파일은 수정모드(mode:"update")만 존재한다.(최초등록은 사용자 등록때 동시실행)
    				  userInfoObj :JSON.stringify(userInfoObj),
    				  targetOrgId : $("#orgSelBox").val()

    	};//("mode=view&boardSeq="+boardSeq+"&btype=1&cate=1").queryToObject();	//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '사용자 프로파일 수정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: 270,
    		width: 800,
    		closeByEscKey: true			//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },//end writeOpen


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