<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

%>

<!-- <style type="text/css">

#SGridTarget .car2Popup_tb_st { }
.supplie_table{
	border-top:2px solid #c7c9cc;
	border-right:1px solid #c7c9cc;
	border-left:1px solid #c7c9cc;
	width: 90%;
}
.supplie_table tr{
	border-bottom:1px solid #c7c9cc;
}
.supplie_table tr td{
	border-left:1px solid #c7c9cc;
	text-align:center;
}


</style>
 -->



<!--========== 스케쥴 DIV : S ==========-->
<!-- <div style="display:none; position:absolute; width:70%;  height: expression( this.scrollHeight > 99 ? 200px : auto ); border:2px solid rgb(81, 84, 97);  background-color:white; z-index:1;" id="scheListArea" >
	<div id="listDiv" style="background:#4d4f52;"></div>
</div> -->
<!--=========== 스케쥴 DIV : E ==========-->

	<input type="hidden" id="cstSnb" value="0">	<!-- 고객ID -->
	<input type="hidden" id="schSeq" value="0">	<!-- 스케쥴seq -->
	<input type="hidden" id="dv2">	<!-- dv2 -->
	<div class="popModal_wrap">
		<h3 class="pop_title">지출 ${cardSnb == 0 ? '등록' : '수정'}</h3>
		<div class="conBox">
		<table id="SGridTarget" class="tb_basic_left" summary="지출등록">
	        <caption>
	         	지출등록
	        </caption>
	        <colgroup>
	       	    <col width="120"/>
	            <col width="*"/>
	        </colgroup>
	        <!--=============================카드선택 입력란 : S================================-->
            <tr id="cardTr">
               <th scope="row">카드선택</th>
               <td>
                   <div id="cardDiv"></div>
               </td>
            </tr>
            <!--=============================카드선택 입력란 : E================================-->
	        <tr>
			    <th scope="row"><span id="tmDtSpan" class="star">* </span>일자</th>
				<td>
				    <input type="text" id="tmDt" class="input_b input_date_type" onchange="chkCalendar();" readonly="readonly"/>
					<a href="#" id = "btnTmdt" onclick="fnObj.setEleSchedule(); $('#tmDt').datepicker('show');return false;"  class="icon_calendar"></a>
				</td>
            </tr>
			<tr>
				<th scope="row"><span id="tmDtSpan" class="star">* </span>${baseUserLoginInfo.projectTitle }</th>
				<td id = "projectAreaTd">
					<span id = "projectArea"></span>
					<span id = "activityArea">
						<select id = "activityId" name = "activityId" class="select_b mgl6">
							<option value="">${baseUserLoginInfo.activityTitle }  </option>
						</select>
					</span>
					<span id = "activityDescArea" class="mgl10"></span>
				</td>
			</tr>
	       	<tr>
				<th><span id="dvSpan" class="star">* </span>계정과목</th>
				<td>
					<span id="dvSelect"></span>		<!-- 계정과목선택 SELECT -->
					<span class="tooltip1">
						<!-- 레이어
						<a href="javascript:showlayer(cardHlep)" class="btn_icon_advice"><em>도움말</em></a>
						-->
						<!-- 레이어->팝업 변경 -->
						<a href="javascript:showPopup()" class="btn_icon_advice"><em>도움말</em></a>
						<div id="cardHlep" class="tooltip_box" style="display:none;">
							<div class="wrap_autoscroll">
							   <span class="intext">
							        <span id ="accountToolTip"></span><!-- 계정과목 안내 툴팁 -->

										<c:choose>
											<c:when test="${setupNote.note != null }">
											    <ul class="list_st_dot3 mgb10">
												    ${setupNote.note }
											 	</ul>
											</c:when>
										    <c:otherwise>
					                            <h3 class="title">1. 영업관련 지출 등록 시!</h3>
								                <ul class="list_st_dot3 mgb10">
								                    <li class="f11">일정 필수</li>
								                </ul>
									            <h3 class="title">2. 교육비, 부서회식 지출 등록 시!</h3>
									            <ul class="list_st_dot3 mgb10">
								                    <li class="f11">대중교통비 : 해당일의 일정 필수, 부서회식 : 해당 일정 필수</li>
								                </ul>
									            <h3 class="title">3. 소모품 지출 등록 시!</h3>
									            <ul class="list_st_dot3 mgb10">
								                    <li class="f11">구입품목 개별 입력(영수증 내역과 동일할 경우 인정)</li>
								                </ul>
							                </c:otherwise>
						                </c:choose>
								    </span>
						        </span>
					            <em class="edge_topleft"></em>
					            <a href="javascript:showlayer(cardHlep)" class="closebtn_s"><img src="${pageContext.request.contextPath}/images/common/icon_car_tooltip_close.gif" alt="닫기" /></a>
					        </div>
					    </div>
					</span>
	       		 </td>
	       		 </tr>

	       		<tr id="areaTr">
	         	 	<th  scope="row">사용처/장소</th>
	       		 	<td>
	       		 		<input type="text" id="place" class="input_basic w_st18" />
	       		 	</td>
	       		</tr>
	       		<tr id="priceTr">
	         	 	<th scope="row"><span id="noteSpan" class="star">* </span>금액</th>
	       		 	<td>
	       		 		<input type="text" id="price" name="price" class="input_basic w_st18 number" />
	       		 	</td>
	       		</tr>
	       		<tr>
	         	 	<th scope="row"><span id="noteSpan" class="star">* </span>내용</th>
	       		 	<td>
	       		 		<input type="text" id="note" class="input_basic w_st19" />
	       		 	</td>
	       		</tr>
	       		<tr class="userTr" id="dotUserBtnLine" style="border-bottom: #9298a2 solid 1px;">
	         	 	<th scope="row" id="dotUserBtnLineTh" <c:if test="${selectUserCnt eq 0}">rowspan='2'</c:if>><span id="noteSpan" class="star">* </span>사원선택</th>
	       		 	<td>
	       		 		<a href="javascript:fnObj.userPop();" class="btn_select_employee"><em>직원선택</em></a>
	       		 	</td>
	       		</tr>
	       		<tr class="dot_line userTr" id="dotUserLine">
	       			<td>
	       				<div id="userSelectArea">
	       					<c:if test="${selectUserCnt eq 0}">
	       						<span class="employee_list" id="userOneArea_0" style="display:inline-block;width:140px;">
	       							<span>${baseUserLoginInfo.userName}</span>
	       							<em>(${baseUserLoginInfo.rankNm})</em>
	       							<a onclick="javascript:fnObj.deleteUser(0);" class="btn_delete_employee">
	       								<em>삭제</em>
	       							</a>
	       							<input type="hidden" name="selectUserId" value="${baseUserLoginInfo.userId}"></span>
	       					</c:if>
	       				</div>
	       			</td>
	       		</tr>
	       		<tr>
                    <th scope="row"></span>지출결의서</th>
                    <td>
                        <span class="radio_list2">
                            <label><input type="checkbox" name="expenseDocYn" id="expenseDocYn"/>지출결의서 기작성건</label>
                        </span>
                        <span class="spe_color_st4 mgl6">(* 체크하시면 ${baseUserLoginInfo.projectTitle} 예산에서 차감되지 않습니다.)</span>
                    </td>
                </tr>

	       		<!--================================ 일정 입력란 :S=====================================-->
	       		<tr id="scheduleTr">
                    <th scope="row">일정</th>
                    <td>
                        <span class="cartooltip" style="display:none;" id="scheListArea" >
                            <div id="nowCarpop2" class="tooltip_box">
                                <table class="car2Popup_tb_st">
                                    <colgroup>
                                        <col width="20%">
                                        <col width="20%">
                                        <col width="*">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th><strong>날짜</strong></th>
                                            <th><strong>시간</strong></th>
                                            <th><strong>내용</strong></th>
                                        </tr>
                                    </thead>
                                    <tbody id="scheArea"></tbody>
                                </table>
                                <p class="sys_p_noti mgt10"><span>* 원하는 일정이 없을시</span><a href="javascript:fnObj.scheAdd();" class="pointB">[일정등록]</a><span>하기 에서 신규로 등록해주세요.</span></p>
                                <div class="s_btnZone">
                                    <a href="javascript:$('#scheListArea').hide();" class="p_withelin_btn"><strong>닫기</strong></a>
                                </div>
                            </div>
                        </span>
                        <input type="text" id="scheTitle" placeholder="일정선택" class="input_basic w_st19" readonly="readonly" onclick="fnObj.getScheduleList(this);" />
                        <button id="btnInitPwd" type="button" class="btn_s_type_g mgl6" onclick="fnObj.setEleSchedule();"><em class="p_reset">초기화</em></button>
                    </td>
                 </tr>
                 <!--================================ 일정 입력란 :E=====================================-->

                 <!--================================ 회사/고객 입력란 :S=====================================-->
                 <tr id="companyTr">
                    <th scope="row"  id="dotCusUserBtnLineTh">회사/고객</th>
                    <td>
                        <a name="reg_btn" class="p_grayline_btn" onclick="fnObj.openCustPopup();"><span id="sltCpn" style="cursor:pointer"></span><span id="sltNm" style="cursor:pointer">대상자</span></a>
                        <span id="sltCst" style="display:none;"><span id = "etcNumArea">외 <span id="etcNum" name="etcNum" ></span> 명</span></span>
                        <span id="extraSpan" style="display:none;">
                            <input type="text" id="extraName" placeholder="추가 대상자명을 입력하세요" class="input_basic w_st18" />
                        </span>
                    </td>
                 </tr>
                 <tr class="dot_line userTr" id="dotCusLine" style="display: none;">
	       			<td>
	       				<div id="cusUserSelectArea">

	       				</div>
	       			</td>
	       		</tr>
                 <!--================================ 회사/고객 입력란 :E=====================================-->

                 <!--=============================차량선택 입력란 : S================================-->
                 <tr id="carTr">
                    <th scope="row"><span id="carSpan" class="star"></span>차량선택</th>
                    <td>
                        <div id="carDiv"></div>
                    </td>
                 </tr>
                 <!--================================ 차량선택 입력란 :E=====================================-->

                 <!--================================ 목적지 입력란 :E=====================================-->
                 <tr id="destinationTr">
                    <th scope="row"><span id="destinationSpan" class="star"></span>목적지</th>
                    <td>
                        <span>출발지:
                            <input type="text" id="fromLoc" class="input_basic w_st18" />
                        </span>
                        <span>/ 도착지:
                        <input type="text" id="toLoc" class="input_basic w_st18" />
                        </span>
                    </td>
                 </tr>
            <!--================================ 목적지 입력란 :E=====================================-->

	       	<!--================================ 소모품 입력란 :S=====================================-->
	       		<tr id="supplieTr">
	    			<td colspan="2">
	    	 			<div id="supplieDiv" style="padding:10px 20px;"></div>
	    	 		</td>
	    	 	</tr>
	    	<!--================================ 소모품 입력란 :E=====================================-->
        </table>
        <div class="btnZoneBox" >
        	<span <c:if test="${param.projectViewYn eq 'Y' }">style="display: none;"</c:if>>
				<a href="javascript:fnObj.calendarChk();" class="p_blueblack_btn"><strong><span id="regTxtSpan">등록</span></strong></a>
				<a href="javascript:fnObj.doDelete();" id="deleteBtnSpan" style="display:none;" class="p_blueblack_btn"><strong>삭제</strong></a>
			</span>
			<a href="javascript:window.close();" class="p_withelin_btn">닫기</a>
		</div>
   </div>


<script type="text/javascript">
var isCardChk = false;
//일정등록 에서 호출
function LayerClose (flag) {
	$("#ViewDiv").hide();
	$("#scheListArea").css("display","none");
	if(flag == 'Add'){
		setTimeout(function(){
			$("#scheTitle").trigger("click");
		}, 2000);
	}

}

//달력 오픈 여부 판별
function chkCalendar(){

	if(cardSnb > 0){		//수정일땐 체크하지 않음
		return false;
	}
	var url = contextRoot + "/system/selectCalendarOpenChk.do";
   	var param = {selectDate : $("#tmDt").val()};
   	var callback = function(result){
   		var obj = JSON.parse(result);
   		var chk = obj.resultVal;
   		if(chk>0){
   			alert("해당일의 달력이 마감되어 등록이 불가합니다.");

   			return false;
   		}

   	};

	commonAjax("POST", url, param, callback, false, null, null);


}
//Global variables :S ---------------

//공통코드

var myGrid = new SGrid();		// instance		new sjs
var myModal = new AXModal();		// instance

var sNb='${baseUserLoginInfo.userId}'; 		  //로그인 유저의 sNb
var permission='${baseUserLoginInfo.permission}'; //로그인 유저의 permission
var division='${baseUserLoginInfo.orgId}';
var deptId='${baseUserLoginInfo.deptId}';		  //팀 시퀀스
var cardSnb='${cardSnb}';					  //지출 시퀀스
var g_gridListStr;							  //그리드 데이터 string (객체화되기전 문자열 json... JSON.parse 로 객체로 만들어사용) (증권사 필터링을 위해..)
//Global variables :E ---------------
var userList;				//전체 유저리스트
var entryList =[];			//참가자 리스트
var scheduleList;			//스케쥴 리스트
var g_rowId =0;				//동적 table tr 고유 ID
var mroList;				//소모품 리스트
var cardObj = {};			//지출 내역
var dv2List=[];				//dv2 리스트
var dvList=[];				//dv 리스트
var schedulePopup;			//스케쥴 팝업 자식창

var colorObj = {};
var orgId = "${baseUserLoginInfo.orgId}";
var nowStr =new Date().yyyy_mm_dd();

var sumPrice = 0; 			//구매내역 입력값의 총합
/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {


	//선로딩코드
	preloadCode: function(){
		numberFormatForNumberClass();
		//공통코드
		//캘린더 세팅
		fnObj.setDatepicker('tmDt');

		//$("#dotUserLine").css("border","1px solid black;!important");

		/*================ 계정과목 SELECT :S ===============*/
		dv2List = getBaseCommonCode('ACCOUNT_SUBJECT', '', 'CD', 'NM', null, '', '', { orgId : "${baseUserLoginInfo.applyOrgId}"});
		if(dv2List == null){
			dv2List = [{ 'CD': '', 'NM' :'선택'}];
		}
		dvList = getBaseCommonCode('', '', 'CD', 'NM', null, '', '',{sSortOrder : 'Y' , parentCodeSetNm : 'ACCOUNT_SUBJECT', orgId : "${baseUserLoginInfo.applyOrgId}"});
		if(dvList == null){
			dvList = [{ 'CD': '', 'NM' :'선택'}];
		}
		var beforeCodeName ='';
		var str = '<select id="dv" class="select_b w_st18">';
		str+='<option value="">선택</option>';
		for(var i=0; i< dv2List.length; i++){
			if(beforeCodeName != dv2List[i].codeName){
				if(i!=0){
					str += '</optgroup>';
				}
				str += '<optgroup label="'+dv2List[i].NM+'">';
			}
			for(var k=0; k<dvList.length; k++){
				if(dvList[k].codeName == dv2List[i].sonCodeName){
					str += '<option value="'+dvList[k].CD+'">'+dvList[k].NM+'</option>';
				}
			}
			beforeDtailCd = dv2List[i].codeName;
		}
		$("#dvSelect").html(str);
		/*================ 계정과목 SELECT :E ===============*/

		/*================ 계정과목 안내 툴팁 :S ===============*/
		var toolTipHtml = "";

		toolTipHtml += '                <table class="tb_list_basic5 mgb10">';
		toolTipHtml += '                    <colgroup>';
		toolTipHtml += '                        <col width="85" />';
		toolTipHtml += '                        <col width="80" />';
		toolTipHtml += '                        <col width="*" />';
		toolTipHtml += '                    </colgroup>';
		toolTipHtml += '                    <thead>';
		toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <th scope="col">대분류</th>';
		toolTipHtml += '                            <th scope="col">소분류</th>';
		toolTipHtml += '                            <th scope="col">내용</th>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                    </thead>';
		toolTipHtml += '                    <tbody>';

		//rowspan 구하기
		var cdObj = {};
		var beforeDtailCd ='';
		var cdCnt = 0;
		beforeCodeName ='';
        for(var i=0; i< dv2List.length; i++){
        	if(beforeDtailCd != dv2List[i].sonCodeName){
                if(i!=0){
                	cdObj[beforeDtailCd] = cdCnt;
                    cdCnt = 0;
                }
            }
            for(var k=0; k<dvList.length; k++){
                if(dvList[k].codeName == dv2List[i].sonCodeName){
                	cdCnt++;
                }
            }
            beforeDtailCd = dv2List[i].sonCodeName;
        }

		for(var i=0; i< dv2List.length; i++){
			var sameCnt = 0;
            for(var k=0; k<dvList.length; k++){
                if(dvList[k].codeName == dv2List[i].sonCodeName){
                    toolTipHtml += '                        <tr>';
                    if(sameCnt == 0){
                    	toolTipHtml += '                            <td rowspan="'+cdObj[dv2List[i].CD]+'" class="center_txt_bold">'+dv2List[i].NM+'</td>';
                    }
                    toolTipHtml += '                            <td class="car_member">'+dvList[k].NM+'</td>';
                    toolTipHtml += '                            <td class="left_txt">'+dvList[k].valueDesc+'</td>';
                    toolTipHtml += '                        </tr>';

                    sameCnt++;
                }
            }
        }

		/* toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <td class="car_member">저녁업무</td>';
		toolTipHtml += '                            <td class="left_txt">업무 관계자와 저녁식사</td>';
		toolTipHtml += '                   </tr>';
		toolTipHtml += '                   <tr>';
		toolTipHtml += '                            <td class="car_member">회식업무</td>';
		toolTipHtml += '                            <td class="left_txt">업무 관계자와 저녁회식 - 저녁식사 외 별도인 경우</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <td class="car_member">커피업무</td>';
		toolTipHtml += '                            <td class="left_txt">업무 관계자와 식사 외 비용 - 간식 포함</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                    <tr>';
		toolTipHtml += '                            <td class="center_txt_red">기타업무</td>';
		toolTipHtml += '                            <td class="left_txt">고객 방문시 접대 선물 및 기타 물품 구매용</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                    <tr>';
		toolTipHtml += '                            <td rowspan="5" class="center_txt_bold">복리후생</td>';
		toolTipHtml += '                            <td class="car_member">저녁야근</td>';
		toolTipHtml += '                            <td class="left_txt">본사 야근시 저녁 식사비용</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <td class="car_member">부서회식</td>';
		toolTipHtml += '                            <td class="left_txt">부서 회식비</td>';
		toolTipHtml += '                   </tr>';
		toolTipHtml += '                   <tr>';
		toolTipHtml += '                            <td class="car_member">워크샵식비</td>';
		toolTipHtml += '                            <td class="left_txt">워크샵 비용 중 식대 관련 비용 - 식사, 커피, 간식</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <td class="car_member">워크샵회식</td>';
		toolTipHtml += '                            <td class="left_txt">워크샵 비용 중 회식 관련 비용</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                    <tr>';
		toolTipHtml += '                            <td class="center_txt_red">점심-직원</td>';
		toolTipHtml += '                            <td class="left_txt">고객과의 점심이 아닌 일상적인 점심</td>';
		toolTipHtml += '                        </tr>'; */
		toolTipHtml += '                    </tbody>';
		toolTipHtml += '                </table>';

		$("#accountToolTip").html(toolTipHtml);
		/*================ 계정과목 안내 툴팁 :E ===============*/

		/*================ 차량리스트 :S ===============*/
		var carList = getCodeInfo(null,'','',null, null, null,'/car2/carList.do',{sNb : sNb , enable : 'Y'});

		if(carList == null){
			carList = [];
		}

		carList=sortByKey(carList, 'owned', 'ASC');			//개인차량을 아래로

		var beforOwned='';
		var str='<select id="carSelect" onchange="fnObj.carChage();">';
		for(var i=0; i<carList.length; i++){

			if(beforOwned !=carList[i].owned){
				if(i!=0){
					str += '</optgroup>';
				}
				var type = '';
				if(carList[i].owned == 'B'){
					type = '법인';
				}else if(carList[i].owned == 'P'){
					type = '개인';
				}
				str += '<optgroup label="'+type+'차량">';
			}
			str += '<option value="'+carList[i].carId+'">'+''+carList[i].owned+'&nbsp;'+carList[i].carNumber + '&nbsp;-' + carList[i].carModel+'</option>';
			//carList[i].carModel = carList[i].carNumber + '&nbsp;-' + carList[i].carModel;
			beforOwned = carList[i].owned;
		}
		str += '</optgroup>';
		str += '</select>';
		$("#carDiv").html(str);
		$("#carSelect").append('<option value="0" selected="selected">=====차량선택====</option>');
		$("#carSelect").css('height','22px');
		/*================ 차량리스트 :E ===============*/

		/*================ 카드선택 :S ===============*/
		fnObj.getCardSelect(); // 카드선택 리스트
		var myCardCnt = 0;
		if( cardSelectList != null ){
			var str = '<select id="cardSelect">';
			str += '<option value="">선택안함</option>';
			for( var i=0; i<cardSelectList.length; i++ ){

				var cardNum = cardSelectList[i].cardNum;
				str += '<option value="'+cardSelectList[i].cardCorpInfoId+'" ';

				if(cardSelectList[i].cardOwnerUserId!=null&&myCardCnt==0){
					if(parseInt(cardSelectList[i].cardOwnerUserId) == parseInt("${baseUserLoginInfo.userId}")){
						str += "selected='selected'";
						myCardCnt++;
					}
				}

				str += '>'+''+cardSelectList[i].cardNickname+"("+cardNum.split("-")[3]+")"+'</option>';
			}
			str += '</select>';
			$("#cardDiv").html(str);
			$("#carSelect").css('height','22px');

			isCardChk = true;
		}else{
			$("#cardTr").hide();
		}
		/*================ 카드선택 :E ===============*/

		if(cardSnb == 0){	//등록일떄 기본 날짜 오늘 세팅.
			var nowDate = new Date();
			$("#tmDt").val(new Date().yyyy_mm_dd());
		}

	},
	//화면세팅
    pageStart: function(){
		// 수정
    	if(cardSnb != 0){
    		//-- 수정일때 지출 데이터 가져오기

    		fnObj.getCardUse();
    		var rgId = cardObj.rgId;

    		//-- 법인카드 등록정보ID
    		//var cardCorpInfoId = cardObj.cardCorpInfoId;
    		var cardNickname = cardObj.cardNickname;
    		if( cardNickname==null ) $("#cardTr").hide();

    		//-- 법인카드 연동 서비스 사용의 경우 금액과 장소 사용일자는 수정 불가
    		var cardCorpUseYn = cardObj.cardCorpUseYn;
    		if( cardCorpUseYn=="Y" ){
    			$("#price").prop("disabled", true); // 금액
    			$("#place").prop("disabled", true); // 장소
    			$("#tmDt").prop("disabled", true);  // 사용일자
    		}

    		var otExpense = cardObj.otExpense;
    		if(otExpense == "Y"){
    			$('#tmDt').datepicker("option", "minDate", cardObj.projectStartDate);
    		}else{
    			$('#tmDt').datepicker("option", "minDate", cardObj.activityStartDate);
    		}
    	}else{

    		var commonPropject = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.projectTitle } 선택', { orgId : orgId,userId : "${baseUserLoginInfo.userId}",type:"PROJECT",incApproveActivity:"N",incCardActivity:"Y",startDate:nowStr });
        	var projectTag = createSelectTagForProject('projectId', commonPropject, 'CD', 'NM', '', null, {}, null, 'select_b','PROJECT');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
    		$("#projectArea").html(projectTag);
    		$("#projectId").change(function(){
            	chgProjectId();
            });
    		if($("#projectId").val()!="") $("#projectId").change();

    		$('#tmDt').datepicker("option", "onSelect", function ( selectedDate ) {

    			fnObj.tmdtChk();

    			commonPropject = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.projectTitle } 선택', { orgId : orgId,userId : "${baseUserLoginInfo.userId}",type:"PROJECT",incApproveActivity:"N",incCardActivity:"Y",startDate:$("#tmDt").val() });
    			var projectTag = createSelectTagForProject('projectId', commonPropject, 'CD', 'NM', '', null, {}, null, 'select_b','PROJECT');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
    	        //$("#scheType").html(projectTag);
    	        $("#projectArea").html(projectTag);

    	        $("#projectId").change(function(){
    	        	chgProjectId();
    	        });
    	        if($("#projectId").val()!="") $("#projectId").change();
    	        $("#activityDescArea").text("");
    	        $("#activityId").html("<option value = ''>${baseUserLoginInfo.activityTitle } 선택</option>");
    		});

    	}




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
    //검색
    doSearch: function(page){
    },//end doSearch

/*======================================기본세팅 관련 func : S ============================================== */

    //tr display 기본 초기화.
    eleDisplay : function(){
    	$("#dotUserBtnLine").css("display","");
    	$("#dotUserBtnLine").attr("style", "border-bottom: #9298a2 solid 1px;");

    	//value 초기화.
    	fnObj.setEleSchedule(); 	//일정관련
    	$("#fromLoc").val('');
    	$("#toLoc").val('');
    	$("#carSelect").val('0');
    	//$("#cardSelect").val('0');
    	$("#place").val('');
    	$("#price").val('');
    	$("#note").val('');
    	$('input:checkbox[name="expenseDocYn"]').attr("checked", false);
    	//fnObj.divisionList();
	},

	//datepicker 설정
    setDatepicker : function(obj){
		$('#'+obj).datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			maxDate: new Date(),
			yearRange: 'c-7:c+7',
		 	monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		    monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		    dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'], // 요일 텍스트 설정
		    dayNamesShort: ['일','월','화','수','목','금','토'], // 요일 텍스트 축약 설정
		    dayNamesMin: ['일','월','화','수','목','금','토'], // 요일 최소 축약 텍스트 설정
		    showButtonPanel: false,
			isRTL: false,

		    buttonText: ""
		});
    },

    //출발지 입력시 장소 자동 입력
    setArea : function(){
	   $("#place").val($("#fromLoc").val());
    },

    //차량 변경시 메모 자동입력
    carChage : function(){
       $("#note").val('['+$("#carSelect option:selected").text()+']');
    },

    //외 몇 명 이름 세팅
    displayEtcName : function(){
    	var etcNum = $("#etcNum").val();
    	if(strInNum(etcNum)){
	    	if(etcNum>0){
	    		$("#extraSpan").css("display","");
	    		$("#extraName").focus();
	    	}else{
	    		$("#extraSpan").css("display","none");
	    	}
    	}else{
    		alert("숫자만 입력 가능합니다.");
    		$("#etcNum").val("0");
    		$("#etcNum").focus();
    	}
    },

/*=======================================기본세팅 관련 func : E ============================================== */

/* ======================================사원선택 관련 func : S ============================================== */

  	//유저선택 공통 팝업
    userPop : function(){

    	var userStr ='';
    	var arr =[];
    	var selectUserList =$("input[name=selectUserId]");

    	for(var i=0;i<selectUserList.length;i++){
    		arr.push(selectUserList[i].value);
  		}
    	userStr = arr.join(',');

    	var paramList = [];
        var paramObj ={ name : 'userList'   ,value : userStr};
        paramList.push(paramObj);
        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
        paramList.push(paramObj);
        paramObj ={ name : 'isAllOrgSelect' ,value : 'N'};
        paramList.push(paramObj);
        paramObj ={ name : 'oneOrgId' ,value : '${baseUserLoginInfo.orgId}'};
        paramList.push(paramObj);

        userSelectPopCall(paramList);		//공통 선택 팝업 호출


 	},

 	//직원 선택
  	getResult : function(resultList){

  		var str ='';
  		var seqArr =[];
  		var selectList = [];

		var brCnt = 1;

  		for(var i=0;i<resultList.length;i++){

  			str +='<span class="employee_list" id="userOneArea_'+resultList[i].userId+'" style="display:inline-block;width:140px;"><span>'+resultList[i].userName+'</span><em>(';
  			str +=resultList[i].position+')</em><a onclick="javascript:fnObj.deleteUser('+resultList[i].userId+');" class="btn_delete_employee"><em>삭제</em></a>';
  			str +='<input type="hidden" name="selectUserId" value="'+resultList[i].userId+'"/>';
  			if(i<resultList.length-1){
    				str+=',';
    		}
  			str+='</span>';
  			brCnt++;

  		}
  		$("#userSelectArea").html(str);					//참여자 이름

  		fnObj.dotLineDisplaySet();

  	},

 	//삭제버튼 클릭
 	deleteUser : function(userId){
 		$("#userOneArea_"+userId).remove();
 		fnObj.dotLineDisplaySet();
 	},
 	//사원 삭제버튼 클릭
 	deleteCusUser : function(userId){
 		$("#cusUserOneArea_"+userId).remove();
 	},

 	//점선줄 판별
    dotLineDisplaySet : function(){
        var selectUserIdList = $("input[name=selectUserId]");   //시퀀스 리스트

        //점선 줄 보이기
        if(selectUserIdList.length>0){
            $("#dotUserLine").show();
            $("#dotUserBtnLine").attr("style", "border-bottom:0px; !important");
            $("#dotUserBtnLineTh").attr("rowspan","2");
        }
        else{
            $("#dotUserLine").hide();
            $("#dotUserBtnLine").attr("style", "border-bottom: #9298a2 solid 1px;");
            $("#dotUserBtnLineTh").attr("rowspan","1");
        }
    },



/* ======================================사원선택 관련 func : E ============================================== */

/* ======================================소모품 관련 func : S ================================================ */

	//소모품 세팅영역
	supplieDivSet :function(){
		var str = '<span style="color:#a5a4a4;font-weight:bold;">*구매내역을 입력해 주세요.</span>';
		str += '<div class="addLine mgt10 mgb20"><table id="supplieAll" class="supplie_table" style="width:100%;">';
		str += '<colgroup>';
		str += '<col width="5%">';
	    str += '<col width="*%">';
	    str += '<col width="20%">';
	    str += '<col width="10%">';
	    str += '<col width="20%">';
	    str += '<col width="15%">';
	    str += '</colgroup>';
	    str += '<tr>';
	    str += '<td style="text-align:center;"></td>';
	    str += '<td style="text-align:center;"><b>목록</b></td>';
	    str += '<td style="text-align:center;"><b>단가</b></td>';
	    str += '<td style="text-align:center;"><b>수량</b></td>';
	    str += '<td style="text-align:center;"><b>금액</b></td>';
	    str += '<td style="text-align:center;"><b>관리</b></td>';
	    str += '</tr>';

		/*======================== 합계======================= */
	    str += '<tr>';
	    str += '<td colspan="3" style="text-align:center;"><b>합   계</b></td>';
	    str += '<td colspan="3" style="text-align:center;"><span id="sumDiv"></span></td>';
	    str += '</tr>';
	    /*======================== 합계======================= */
	    str += '</table></div>';

	    $("#supplieDiv").html(str);
	    if(cardSnb!=0){		//수정일때

	    	if(mroList.length == 0){
	    		fnObj.appendTr('',0,1,0,0);	//첫번째 row 생성
	    	}else{

			    for(var i=0; i<mroList.length;i++){	//소모품 리스트
			    	fnObj.appendTr(mroList[i].mroName,mroList[i].price,mroList[i].qty,mroList[i].price*mroList[i].qty);	//tr세팅
		    	}
	    	}
		    fnObj.priceTotalCal();
	    }else{			//등록일때
	    	fnObj.appendTr('',0,1,0,0);	//첫번째 row 생성
	    }
	},

	//추가 버튼 클릭시
	appendTr : function(name,price,qty,totalPrice){
		var table = document.getElementById("supplieAll");
		var rowIndex = table.rows.length-1;      // 테이블(TR) row 개수 행의 idx 를 찾을때 사용.
		newTr = table.insertRow(rowIndex);
		newTr.id = "newTr" + g_rowId;			 //g_rowId -> 전역변수로 세팅 tr 생성시마다 1증가. (고유 아이디값을 주어 삭제시 삭제하기위해) 이후, 삭제시 해당 tr 삭제.
		newTd=newTr.insertCell(0);
		newTd.style = "text-align:center";
		newTd.innerHTML= '<span name="plusBtn" id="addBtn_'+g_rowId+'"><b><i class="axi axi-square-plus" style="cursor:pointer;font-size: 15px;" title="추가" onclick="fnObj.appendTr(\'\',0,1,0);"></i></b></span>';
		newTd=newTr.insertCell(1);
		newTd.style = "text-align:center";
		newTd.innerHTML= '<input type="text" name="supplieName"  id="supplieName_'+g_rowId+'" onchange="fnObj.chkEqName(\''+(g_rowId)+'\');"   class="applyinput_B w_st06" style="width:150px;" value="'+name+'"/>';
		newTd=newTr.insertCell(2);
		newTd.style = "text-align:center";
		newTd.innerHTML= '<input type="text" name="supplieUnitPrice" id="supplieUnitPrice_'+g_rowId+'" onkeyup="fnObj.priceOneCal(\'supplieUnitPrice_\',\''+(g_rowId)+'\');" class="applyinput_B w_st06 number" style="width:80px;text-align:right;padding:5px;" value="'+Number(price).toLocaleString().split(".")[0]+'"/>';
		newTd=newTr.insertCell(3);
		newTd.style = "text-align:center";
		newTd.innerHTML= '<input type="text" name="supplieCount" id="supplieCount_'+g_rowId+'" onkeyup="fnObj.priceOneCal(\'supplieCount_\',\''+(g_rowId)+'\');" class="applyinput_B w_st06 number" style="width:30px;text-align:right;padding:2px;" value="'+Number(qty).toLocaleString().split(".")[0]+'"/>';
		newTd=newTr.insertCell(4);
		newTd.style = "text-align:center";
		newTd.innerHTML= '<input type="text" name="suppliePrice" id="suppliePrice_'+g_rowId+'" class="applyinput_B w_st06" style="width:80px;text-align:right;padding:5px;" readonly value="'+Number(totalPrice).toLocaleString().split(".")[0]+'"/>';
		newTd=newTr.insertCell(5);
		newTd.style = "text-align:center";
		if(rowIndex>1){								//첫번째 제외 삭제버튼 세팅
			newTd.innerHTML= '<button name="reg_btn" class="btn_s_type_g" onclick="fnObj.deleteTr('+g_rowId+');">삭제</button>';
		}
		g_rowId =g_rowId+1;
		numberFormatForNumberClass();
		fnObj.resetPlusBtn();						//추가버튼리셋(마지막에만)
	},

	//삭제버튼 클릭시
	deleteTr : function(g_rowId){
		$("#newTr"+g_rowId).remove();				//g_rowId -> 전역변수로 세팅 tr 생성시마다 1증가. 이후, 삭제시 해당 tr 삭제.
		fnObj.resetPlusBtn();						//추가버튼리셋(마지막에만)
		fnObj.priceTotalCal();
	},

	//추가버튼리셋(마지막에만)
	resetPlusBtn: function(){
		var plusList =$('span[name=plusBtn]');
		for(var i=0; i<plusList.length;i++){
			$(plusList[i]).hide();
			if(i == plusList.length-1){				//마지막 버튼만 보이게
				$(plusList[i]).show();
			}
		}
	},

	//콤마생성.
	setComma : function(obj,g_rowId) {
		var setValue = $("#"+obj+g_rowId).val();
		var p = setValue;
		if(setValue.length>3){
			 p =setValue.match(/\d+/g).join('');
		}

		var reg = /(^[+-]?\d+)(\d{3})/;
		p += '';
		while (reg.test(p)) p = p.replace(reg, '$1' + ',' + '$2');
		$("#"+obj+g_rowId).val(p);
	},

	//소모품 한개 계산.
	priceOneCal : function(obj,g_rowId){
		fnObj.setComma(obj,g_rowId);	//콤마생성
		var supplieUnitPrice =$("#supplieUnitPrice_"+g_rowId).val(); 		//g_rowId(고유값) 단가
		var supplieCount 	 =$("#supplieCount_"+g_rowId).val();			//g_rowId(고유값) 수량
		var suppliePrice	 =$("#suppliePrice_"+g_rowId).val(); 			//g_rowId(고유값) 금액
		var total = '0';
		if(supplieUnitPrice != '' && supplieCount != ''){
			var reg = /(^[+-]?\d+)(\d{3})/;
			//계산
			total = parseInt(supplieUnitPrice.replace(/,/g,'')) * parseInt(supplieCount.replace(/,/g,''));
			//계산 값 콤마 생성
			total+='';
			while (reg.test(total)) total = total.replace(reg, '$1' + ',' + '$2');
		}
		$("#suppliePrice_"+g_rowId).val(total);								//개별 금액 세팅(한개row)
		fnObj.priceTotalCal();												//전체 금액 세팅(전체row)
	},

	//소모품 합계.
	priceTotalCal : function(){
		var supplieUnitPriceList = $('input[name=supplieUnitPrice]');	//단가 리스트
		var supplieCountList 	 = $('input[name=supplieCount]');		//수량 리스트
		var total = 0;
		for(var i =0; i<supplieUnitPriceList.length;i++){
			var supplieUnitPrice = supplieUnitPriceList[i].value.replace(/,/g,'');		//idx 단가(row)
			var supplieCount = supplieCountList[i].value.replace(/,/g,'');				//idx 수량(row)
			if(supplieUnitPrice!='' && supplieCount!=''){								//둘다 값이 있을때 계산
				total+=  parseInt(supplieUnitPrice)*parseInt(supplieCount);
			}
		}
		//$("#price").val(total);
		sumPrice = total;
		$("#sumDiv").html(Number(total).toLocaleString().split(".")[0]);
	},

	//이름 체크
	chkEqName :function(g_rowId){
		var supplieNameList = $('input[name=supplieName]');				//이름 리스트
		var cnt =0;														//동일한 이름 카운트
		var idx =-1;													//동일한 이름 idx
		var lastIdx =0;
		for(var i=0;i<supplieNameList.length;i++){
			var supplieName = supplieNameList[i].value;					//idx 이름(row)
			if(supplieName ==  $("#supplieName_"+g_rowId).val()){
				cnt ++;
				if(idx==-1){idx = i;}			//제일 처음 idx 세팅
				else if(idx==0){idx = 0;}		//이미 idx 세팅되있지만, 첫번째 행일때
				lastIdx = i;					//마지막 값 세팅
			}
		}
		if(cnt>1){																//동일한 이름이 지금 입력 +1 이면,
			if(confirm("동일한 이름이 존재합니다.동일 내역에 입력하시겠습니까?")){
				supplieNameList[idx].focus();									//처음 동일이름 focus
				if(g_rowId!=0){fnObj.deleteTr(g_rowId);}						//방금 입력한 행 삭제.(첫번째 행이 아닐때)
				else{															//첫번째 행을 일때
				 	var supplieNameId = $(supplieNameList[lastIdx]).attr('id'); //동일 이름의 마지막 아이디를 가져와
				 	var rowIdx = supplieNameId.split("_")[1];					//번호
				 	fnObj.deleteTr(rowIdx);
				}
			}
		}
	},
/* ======================================소모품 관련 func : E ================================================ */

/* ======================================일정 관련 func : S ================================================ */

   //해당 사람 스케쥴 리스트
   getScheduleList : function(th){

		var url = contextRoot + "/car2/popUpmemoAjax.do";
		var selectDate = $("#tmDt").val();
		var scheduleType = $("#dv").val();
		var param = { date: selectDate , sabun:'${baseUserLoginInfo.empNo}' , scheduleType: scheduleType};
	   	var callback = function(result){

	   		var obj = JSON.parse(result);
	   		var cnt = obj.resultVal;		//결과수
	   		var list = obj.resultList;		//결과데이터JSON */
	   		scheduleList = list;
	   		if(list.length>0){				//등록된 일정이 있을때,
	   			//var left = $(th).offset().left;
	    		//var top = $(th).position().top + $(th).height()+10;
		    	//$("#scheListArea").css({display:"",left:left,top:top});
		   		fnObj.divScheduleSet();		//스케쥴 레이어 팝업 세팅
	   		}else{
	   			if(confirm("등록된 일정이 없습니다.일정을 등록하시겠습니까?")){
	   				fnObj.scheAdd();		//일정 등록 팝업
	   			}
	   		}

	   	};
	   	commonAjax("POST", url, param, callback, false, null, null);
   },

   //스케쥴 div 세팅
   divScheduleSet : function(){
	   var str ='';
	  /*  str += ' <div id="nowCarpop" class="tooltip_box" style="overflow:auto; overflow-x:hidden;"><p style="padding:5px 0px;text-align:right;"><a href="javascript:fnObj.scheAdd();" class="p_withelin_btn"><strong>일정등록</strong></a></p>';
	   str += '<div class="car2Popup_st_box">';
	   str += '<table class="car2Popup_tb_st">';
	   str += '<colgroup>';
	   str += '<col width="20%">';
	   str += '<col width="20%">';
	   str += '<col width="*%">';
	   str += '</colgroup>';
       str += '<thead><tr>';
	   str += '<th><strong>날짜</strong></th>';
	   str += '<th><strong>시간</strong></th>';
	   str += '<th><strong>내용</strong></th>';
	   str += '</tr></thead><tbody>'; */

	   for(var i=0;i<scheduleList.length;i++){

		   str += '<tr id="schedule_'+i+'" style="cursor:pointer;" onclick="fnObj.setSchedule(this,\''+scheduleList[i].ScheSeq+'\',\''+scheduleList[i].ScheTitle+'\',\''+scheduleList[i].customerCpnNm+'\',\''+scheduleList[i].customer+'\',\''+scheduleList[i].customerId+'\');">';
		   str += '	<td>'+scheduleList[i].ScheEMonth+'/'+scheduleList[i].ScheEDay+'</td>';
		   str += '	<td>'+scheduleList[i].ScheETime+'</td>';
		   str += '	<td class="txt_left">'+scheduleList[i].ScheTitle+'</td>';
		   str += '</tr>';
	   }
	  /*  str += '</tbody></table></div>';
	   str += '<em class="edge_topcenter"></em>';
	   str += '<a href="javascript:fnObj.divClear();" class="closebtn_s"><img src="../images/common/icon_car_tooltip_close.gif" alt="닫기" /></a></div>';
	    */
	  // $("#listDiv").html(str);
	   $("#scheArea").html(str);
	   $("#scheListArea").css("display","");
   },

   //일정 영역(회사/고객/일정) 세팅
   setSchedule : function(th,schSeq,scheTitle,companyNm,customer,customerId){	//스케쥴 시퀀스,내용,회사명,고객명,고객아이디
	   var dv = $("#dv").val();
	   var dv2 = $("#dv2").val();
	   $(".click_tr").removeClass();
	   if(th != ''){
		   $(th).addClass('click_tr');
	   }
	   $("#scheTitle").val(scheTitle);
	   $("#note").val(scheTitle);
	   $("#schSeq").val(schSeq);						//선택 스케쥴 시퀀스
	   $("#extraSpan").hide();							//추가 대상자
	   $("#etcNum").val('0');							//~명 초기화
       $("#extraName").val('');							//추가 대상자 초기화
	   $("#sltCst").css('display','');					//~외 ~명

		if(customerId!=null&&customerId!='0' && customerId!=''){
			//$("#sltNm").html(customer);					//이름
			//$("#sltCpn").html(companyNm);				//회사
			//$("#cstSnb").val(customerId);				//고객아이디
			cstPopupCallback(customerId,null,customer,companyNm,null,null);

			$("#etcNumArea").hide();
		}

   	   $("#scheListArea").css("display","none");
 	},

	//일정 영역(회사/고객/일정) 초기화
	setEleSchedule : function(){
	   $("#scheListArea").css("display","none");	//일정 div 숨기기
	   $("#scheTitle").val('');
	   $("#note").val('');
       $("#schSeq").val('0');					//선택 스케쥴 시퀀스
 	   /* $("#sltNm").html('대상자');				//이름
       $("#sltCpn").html('');					//회사
       $("#sltCst").css('display','none');		// ~외 ~명
       $("#extraSpan").css('display','none');	// 추가 대상자
       $("#cstSnb").val('0');					//히든값 초기화
       $("#etcNum").val('0');					//~명 초기화
       $("#extraName").val('');					//추가 대상자 초기화 */
    },

	//일정 등록
    scheAdd : function() {
       var SelDate =$("#tmDt").val()
       var url = "${pageContext.request.contextPath}/scheduleProc.do?EventType=Add&ParentPage=card&ScheSDate="+SelDate;
       var option = "left=" + (screen.width > 1400?"700":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=900, height=860, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
       schedulePopup = window.open(url, "_blank", option);


 	},

/* ======================================일정 관련 func : E ================================================ */

	//원본 검색
    getCardUse: function(){

    	var url = contextRoot + "/card/getCardDetail.do";
    	var param = {sNb : cardSnb};
    	var callback = function(result){
    		var obj = JSON.parse(result);
    		entryList= obj.userList;
    		cardObj = obj.card;
    		mroList = obj.mroList;

    		var cusUserList = obj.cusUserList;


    		if(cardObj != null){
    			fnObj.setDataCard();
    		}
    		if(entryList.length>0)
    		fnObj.getResult(entryList);
    		if(cusUserList!=null && cusUserList.length>0){
    			for(var i = 0 ; i <cusUserList.length; i++){

    				var cusObj = cusUserList[i];

    				cstPopupCallback(cusObj.cstSnb,null,cusObj.cstNm,cusObj.cpnNm,null,null);
    			}


    		}

    	};
    	commonAjax("POST", url, param, callback, false, null, null);
    },//end getCardUse

	//카드선택
    getCardSelect: function(){

    	var url      = contextRoot + "/card/getCardSelectList.do";
    	var param    = {applyOrgId : "${baseUserLoginInfo.applyOrgId}"};

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		cardSelectList = obj.cardSelectList;
    	};
    	commonAjax("POST", url, param, callback, false, null, null);
    },//end getCardUse

	//수정시 데이터 세팅
    setDataCard : function (){
		$("#cardSelect").val(cardObj.cardCorpInfoId); //카드선택
		// 연동서비스를 사용하는 경우 카드 승인일 자동 노출
		var approveDate = cardObj.approveDate;
		if( approveDate != null ){
			$("#tmDt").val(cardObj.approveDate);
		}else{
			$("#tmDt").val(cardObj.tmDt);				  //날짜세팅
		}
	   	if( cardObj.dv==null || cardObj.dv=="" ){
	   		$("#dv").val('');
	   	}else{
			$("#dv").val(cardObj.dv);					  //계정과목세팅
	   	}
		//////////////////////////
		fnObj.eleDisplay();               //tr display 기본 초기화.
        fnObj.setEleSchedule();
        var dv = $("#dv").val();
        var dv2 = 0;
        var dvInfo = getRowObjectWithValue(dvList, 'CD', dv);       //리스트에서 해당 dv에 대한 공통코드 추출.
        if(dvInfo!=null&&dvInfo!=""){
        	var dv2Info = getRowObjectWithValue(dv2List, 'sonCodeName', dvInfo.codeName);       //리스트에서 해당 dv에 대한 공통코드 추출.
	        dv2 = dv2Info.CD;
	        $("#dv2").val(dv2); //그룹핑
        }
        /////////////////////////////////////

		$("#price").val(Number(cardObj.price).toLocaleString().split(".")[0]);	//금액세팅
		//$("#price").val(cardObj.price);	//금액세팅
		//alert(Number(cardObj.price))
		fnObj.setSchedule('',cardObj.schSeq,cardObj.scheTitle,cardObj.cstCpnNm,cardObj.cstNm,cardObj.cstSnb);//일정 부분 세팅

		$("#note").val(cardObj.note);		//내용세팅
		$("#place").val(cardObj.place);		//장소세팅

		var etcNum = cardObj.etcNum;
		if(cardObj.etcNum>0){
			$("#etcNum").text(cardObj.etcNum);	//인원세팅

			$("#etcNumArea").show();
		}else{
			$("#etcNumArea").hide();
		}
		$("#fromLoc").val(cardObj.fromLoc);	//출발지세팅
		$("#toLoc").val(cardObj.toLoc);		//도착지세팅
		$("#carSelect").val(cardObj.carId);	//차량세팅

		if(cardObj.expenseDocYn == "Y") $('input:checkbox[name="expenseDocYn"]').attr("checked", true);
		else $('input:checkbox[name="expenseDocYn"]').attr("checked", false);

		/* if(cardObj.etcNum != 0 && cardObj.schSeq!=0){	//추가 대상자 세팅
			$("#extraName").val(cardObj.extraName);
			$("#extraSpan").css('display','');
		} */

		//카드연동이됬을때
		if(cardObj.cardCorpUseYn == "Y"){
			//카드정보를 텍스트로 바꾼다.
			var cardNum = cardObj.cardNum;
			var stStr = cardObj.cardNickname + "(" +cardNum.split("-")[3]+")";
				stStr+= "<input type = 'hidden' id = 'cardSelect' name = 'cardSelect' value = '"+cardObj.cardCorpInfoId+"'>";

			$("#cardDiv").html(stStr);

			//일자를 텍스트로 바꾼다.
			$("#btnTmdt").hide();

			if(cardObj.projectNm !=null){
				//프로젝트 정보
				var stStr = "<div><strong>["+cardObj.projectNm+"-"+cardObj.activityNm+"]</strong> 기간 : "+cardObj.activityStartDate+" ~ "+cardObj.activityEndDate+"</div>";
				$("#projectAreaTd").html(stStr);
			}else{
				var commonPropject = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.projectTitle } 선택', { orgId : orgId,userId : "${baseUserLoginInfo.userId}",type:"PROJECT",incApproveActivity:"N",incCardActivity:"Y",startDate:nowStr });
	        	var projectTag = createSelectTagForProject('projectId', commonPropject, 'CD', 'NM', '', null, {}, null, 'select_b','PROJECT');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	    		$("#projectArea").html(projectTag);
	    		$("#projectId").change(function(){
	            	chgProjectId();
	            });
	    		if($("#projectId").val()!="") $("#projectId").change();

	    		$('#tmDt').datepicker("option", "onSelect", function ( selectedDate ) {

	    			fnObj.tmdtChk();

	    			commonPropject = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.projectTitle } 선택', { orgId : orgId,userId : "${baseUserLoginInfo.userId}",type:"PROJECT",incApproveActivity:"N",incCardActivity:"Y",startDate:$("#tmDt").val() });
	    			var projectTag = createSelectTagForProject('projectId', commonPropject, 'CD', 'NM', '', null, {}, null, 'select_b','PROJECT');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	    	        //$("#scheType").html(projectTag);
	    	        $("#projectArea").html(projectTag);

	    	        $("#projectId").change(function(){
	    	        	chgProjectId();
	    	        });
	    	        if($("#projectId").val()!="") $("#projectId").change();
	    	        $("#activityDescArea").text("");
	    	        $("#activityId").html("<option value = ''>${baseUserLoginInfo.activityTitle } 선택</option>");
	    		});
			}

		}else{
			//프로젝트 정보
			var stStr = "<div><strong>["+cardObj.projectNm+"-"+cardObj.activityNm+"]</strong> 기간 : "+cardObj.activityStartDate+" ~ "+cardObj.activityEndDate+"</div>";
			$("#projectAreaTd").html(stStr);
		}
    },
    tmdtChk : function(){
    	if(cardSnb == 0){		//수정일땐 체크하지 않음
   			var url = contextRoot + "/system/selectCalendarOpenChk.do";
	       	var param = {selectDate : $("#tmDt").val()};
	       	var callback = function(result){
	       		var obj = JSON.parse(result);
	       		var chk = obj.resultVal;
	       		if(chk>0){
	       			alert("해당일의 달력이 마감되어 등록이 불가합니다.");

	       			return false;
	       		}
	       	};

	    	commonAjax("POST", url, param, callback, false, null, null);
   		}
    },
   	calendarChk : function(){
   		if(cardSnb == 0){		//수정일땐 체크하지 않음
   			var url = contextRoot + "/system/selectCalendarOpenChk.do";
	       	var param = {selectDate : $("#tmDt").val()};
	       	var callback = function(result){
	       		var obj = JSON.parse(result);
	       		var chk = obj.resultVal;
	       		if(chk>0){
	       			alert("해당일의 달력이 마감되어 등록이 불가합니다.");

	       			return false;
	       		}else{
	       			fnObj.doSave();
	       		}

	       	};

	    	commonAjax("POST", url, param, callback, false, null, null);
   		}else{
   			fnObj.doSave();
   		}
   	},

    //등록 및 수정
    doSave : function(){
    	if('${baseUserLoginInfo.orgId}' != '${baseUserLoginInfo.applyOrgId}'){
    		alert("해당 회사에선 작성할 수 없습니다.회사를 변경하여주세요");
    		return false;
    	}

	    var tmDt = $("#tmDt").val();
	    var type = $("#dv").val();
	    var cstSnb = $("#cstSnb").val();
	    var place = $("#place").val();
	    var dv = $("#dv").val();

	    var price = $("#price").val().replace(/,/g,'');
		//alert("price---->"+price)

	    var note = $("#note").val();
	    var expenseDocYn = "N";
	    if($("input:checkbox[id='expenseDocYn']").is(":checked")){
	    	expenseDocYn = "Y";
        }else{
        	expenseDocYn = "N";
        }
	    ///추가
	    var schSeq = $("#schSeq").val();
	    var extraName = $("#extraName").val();
	    var scheTitle = $("#scheTitle").val();
	    var etcNum = $("#etcNum").val();
	    var fromLoc = $("#fromLoc").val();
	    var toLoc = $("#toLoc").val();
	    var carId = $("#carSelect").val();

	    var cardId = $("#cardSelect").val(); // 수정


	    if( isCardChk&&cardId=="" ){
	    	if(!confirm( "카드를 선택하지 않았습니다.\n이대로 등록하시겠습니까?")){
	    		$("#cardSelect").focus();
	    		return;
	    	}
	    }

	    var supplies ='';
	    var userList = [];				//선택한 유저리스트
	    var userListStr = '';			//선택한 유저리스트String
	    var beforeDv = '';
	    var feedback='';
	    var year ='';
	    var month='';

	    var projectId ="";
	    var activityId ="";


	    //프로젝트
	   // var projectId = cardSnb != 0?cardObj.projectId:$("#projectId").val();
	    //var activityId = cardSnb != 0?cardObj.activityId:$("#activityId").val();

	    //프로젝트
	    var projectId = cardObj.projectId!=null?cardObj.projectId:$("#projectId").val();
	    var activityId = cardObj.activityId!=null?cardObj.activityId:$("#activityId").val();
	    /*======================================== 유효성 검사 : S================================== */

	    /* ============유효성 공통=============== */
	    if(projectId == ""){
			alert("${baseUserLoginInfo.projectTitle }을(를) 선택해 주세요.");
			$("#projectId").focus();
			return;
		}

		if(activityId == ""){
			alert("${baseUserLoginInfo.activityTitle }을(를) 선택해 주세요.");
			$("#activityId").focus();
			return;
		}

// 	    if(dv == '' ){
// 	    	alert("분류를 선택해주세요.");
// 	    	$("#dv").focus();
// 	    	return false;
// 	    }
	    if(tmDt == ''){
	    	alert("날짜를 선택해주세요.");
	    	$("#tmDt").focus();
	    	return false;
	    }

 	    if(dv == ''){
 	    	alert("계정과목을 선택해주세요.");
 	    	$("#dv").focus();
 	    	return false;
 	    }

 	   var dv = $("#dv").val();
       var dv2 = 0;
       var dvInfo = getRowObjectWithValue(dvList, 'CD', dv);       //리스트에서 해당 dv에 대한 공통코드 추출.
       var dv2Info = getRowObjectWithValue(dv2List, 'sonCodeName', dvInfo.codeName);       //리스트에서 해당 dv에 대한 공통코드 추출.
       dv2 = dv2Info.CD;
       $("#dv2").val(dv2); //그룹핑
	    if(price == '' ){
	    	alert("금액을 입력해주세요");
	    	$("#price").focus();
	    	return false;
	    }
	    if(!strInNum(price)){
	    	alert("금액을 숫자로 입력해주세요");
	    	$("#price").focus();
	    	return false;
	    }
	    if(note == ''){
	    	alert("내용을 입력해주세요.");
	    	$("#note").focus();
	    	return false;
	    }

	    if($("input[name = 'selectUserId']").length == 0){
	    	alert("사원을 선택해 주세요.");
	    	return;
	    }

	    /* ============유효성 계정과목 분류=============== */

   		var table = document.getElementById("supplieAll");
   		var rowIndex = table.rows.length-2;      						// 테이블(TR) row 개수 행의 idx 를 찾을때 사용.
   		var supplieNameList = $('input[name=supplieName]');				//이름 리스트
		var supplieUnitPriceList = $('input[name=supplieUnitPrice]');	//단가 리스트
		var supplieCountList = $('input[name=supplieCount]');			//수량 리스트
		var suppliePriceList = $('input[name=suppliePrice]');			//금액 리스트
   		var jArray = new Array();										//obj를 담을 Array

   		var chkPrice = false;
   		for(var i=0;i<supplieNameList.length;i++){
   			var supplieName = supplieNameList[i].value;									//idx 이름(row)
   			var supplieUnitPrice = supplieUnitPriceList[i].value.replace(/,/g,'');		//idx 단가(row)
   			var supplieCount = supplieCountList[i].value.replace(/,/g,'');				//idx 수량(row)
   			var suppliePrice = suppliePriceList[i].value.replace(/,/g,'');				//idx 금액(row)

   			if(supplieUnitPrice!='' && supplieCount!=''
   				&& supplieUnitPrice!=0 && suppliePrice!=0&&sumPrice != 0){			//유효한 값일때.
	   			if(supplieName == ""){
	   				alert("목록을 입려해 주세요.");
	   				chkPrice = false;
	   				supplieNameList[i].focus();
	   				return false;
	   			}
   				if(!strInNum(supplieUnitPrice)){
   					alert("단가 혹은 수량은 숫자만 가능합니다.");
   					supplieCountList[i].focus();
   					chkPrice = false;
   					return false;
   				}else if(!strInNum(supplieCount)){
   					alert("단가 혹은 수량은 숫자만 가능합니다.");
   					supplieCountList[i].focus();
   					chkPrice = false;
   					return false;
   				}else{																	//유효값
   					var jobj = new Object();
       				jobj.code='';
       				jobj.name=supplieName;
       				jobj.count=supplieCount;
       				jobj.price=supplieUnitPrice;
       				jArray.push(jobj);
	   				chkPrice = true;
   				}

   			}

   			if(chkPrice){
   				if(sumPrice != $("#price").val().split(",").join("")){
	   				alert("금액이 지출내역의 합계와 다릅니다. 다시 확인해 주세요.");
	   				return;
   				}
   			}
   			/* else{
   				alert("구매내역 입력칸을 확인해주세요.");
   				if(supplieName=='' || supplieName==0 ){
   					supplieNameList[i].focus();
   				}else if(supplieUnitPrice=='' || supplieUnitPrice==0 ){
   					supplieUnitPriceList[i].focus();
   				}else if(supplieCount=='' || supplieCount==0 ){
   					supplieCountList[i].focus();
   				}
   				return false;
   			} */
    		var totalObj = new Object();
    		totalObj.items=jArray;					//items 란 키값으로 totalObj에 jobj를 담은 jArray를 세팅
    		supplies = JSON.stringify(totalObj);	//totalObj 를 string 변환
    	}
	    /*======================================== 유효성 검사 : E================================== */

	    //유저리스트

    	var selectUserList =$("input[name=selectUserId]");

    	for(var i=0;i<selectUserList.length;i++){
    		userList.push(selectUserList[i].value);
  		}
    	if(userList.length>0 ){
	    	userListStr = userList.join(',');
	    }

    	var cusUserListStr = "";

    	$("input[name='cusUserId']").each(function(i){
    		if(i>0) cusUserListStr+=",";
    		cusUserListStr+=$(this).val();
    	});

	    year = tmDt.split("-")[0];
	    month = tmDt.split("-")[1];

	   	var param = {
	   					sNb			   : cardSnb,		//지출 시퀀스
	   					tmDt		   : tmDt,			//사용일
	   					year		   : year,			//사용년도
	   					month		   : month,			//사용월
	   					dv			   : type,			//계정과목
	   					dv2			   : dv2,			//계정과목 그룹핑
	   					cstSnb  	   : cstSnb,		//고객번호
	   					place 		   : place,			//장소
	   					price 		   : price,			//금액
	   					note 		   : note,			//내용
	   					schSeq 		   : schSeq,		//일정시퀀스
	   					etcNum  	   : 0,				//대상자 숫자
	   					extraName	   : extraName,		//추가대상자 명
	   					fromLoc		   : fromLoc,		//출발지
	   					toLoc  		   : toLoc,			//도착지
	   					carId 		   : carId,			//차량번호
	   					supplies 	   : supplies,		//소모품 (jsonString)
	   					userListStr    : userListStr,	//선택 유저 리스트
	   					cusUserListStr : cusUserListStr,//선택 고객 리스트
	   					progress	   : 'SUBMIT',		//진행 상태 'SUBMIT' 승인요청 , 'APPROVE' 승인완료 'REJECT' 반려
	   					status		   : '',			//정상여부  'W' 경고 , 'Y' 정상
	   					activityId     : activityId,
	   					projectId      : projectId,
	   					expenseDocYn   : expenseDocYn,
	   					cardCorpInfoId : cardId			//카드선택
	   				};

		var confirmStr = "";

		var dateToStr = $("#tmDt").val();
		var dateToBuf = dateToStr.split("-").join("");
		var dateToInt = parseInt(dateToBuf);
		var otExpense = cardSnb != 0?cardObj.otExpense:$("#projectId option:selected").attr("otExpense");

		var startDtStr;
		var endDtStr;
		if(otExpense == "Y"){
			startDtStr = cardObj.projectStartDate!=null?cardObj.projectStartDate:$("#projectId option:selected").attr("startdate");
			endDtStr = cardObj.lastDate!=null?cardObj.lastDate:$("#projectId option:selected").attr("lastdate");
		}else{
			startDtStr = cardObj.activityStartDate!=null?cardObj.activityStartDate:$("#activityId option:selected").attr("startdate");
			endDtStr = cardObj.activityEndDate!=null?cardObj.activityEndDate:$("#activityId option:selected").attr("enddate");
		}

		var startDtBuf = startDtStr.split("-").join("");
		var startDtInt = parseInt(startDtBuf);

		var endDtBuf = endDtStr.split("-").join("");
		var endDtInt = parseInt(endDtBuf);

		if(dateToInt<startDtInt || dateToInt>endDtInt){
			alert("일자가 ${baseUserLoginInfo.projectTitle} 기간과 맞지 않습니다.\n일자를 다시 등록해주세요.\n[${baseUserLoginInfo.projectTitle} 기간: "+startDtStr+" ~ "+endDtStr);
			return;
		}

		var activityEndStr =cardObj.activityEndDate!=null?cardObj.activityEndDate:$("#activityId option:selected").attr("enddate");;
		var activityEndBuf = activityEndStr.split("-").join("");
		var activityEndInt = parseInt(activityEndBuf);

		var activityStratStr =cardObj.activityStartDate!=null?cardObj.activityStartDate:$("#activityId option:selected").attr("startdate");
		var activityStratBuf = activityStratStr.split("-").join("");
		var activityStratInt = parseInt(activityStratBuf);

		if(dateToInt<activityStratInt || dateToInt>activityEndInt){
			confirmStr = "지출일자가 ${baseUserLoginInfo.activityTitle}의 일정을 초과합니다. 저장하시겠습니까?";
		}
		var url = contextRoot + "/project/getProjectExpenseValid.do";

		if(confirmStr!=""){
			if(!confirm(confirmStr)){
				return;
			}
		}

		var projectExpenseValidCallback = function(data){
			var obj = JSON.parse(data);
			var expenseInfo = obj.resultObject;
			var confirmStr = "저장하시겠습니까?";
			if(expenseInfo.activityExpense == "N"){
				alert("선택한 ${baseUserLoginInfo.projectTitle}은/는 지출이 불가능합니다.\n${baseUserLoginInfo.projectTitle} 담당자에게 문의 후 다시 등록해주세요.");
				return;
			}else if(expenseInfo.activityExpense == "Y"){
				var beforePrice = cardSnb != 0?parseInt(cardObj.price):0;
				if(parseInt(expenseInfo.avalAmt)<price-beforePrice ){
					alert("입력한 지출금액이 사용 가능한 지출 범위를 초과하였습니다.\n${baseUserLoginInfo.projectTitle} 담당자에게 문의 후 다시 등록해주세요.");
					return;
				}
			}else{
				alert("선택한 ${baseUserLoginInfo.projectTitle}정보가 조회되지 않습니다. 담당자에게 문의해주세요.");
				return;
			}

			var callback = function(result){
		   		var obj = JSON.parse(result);
		   		var chk = obj.resultVal;
		   		if(chk>0){
			   		alert("완료되었습니다.");
			   		var dateArr = tmDt.split('-');
			   		opener.fnObj.monthClick(parseInt(dateArr[1]));
			   		//opener.fnObj.doSearch();
			   		window.close();
		   		}else{
		   			alert("서버오류!!!.");
		   		}
			};

			if(confirm(confirmStr)){
				url = contextRoot + "/card/regCardUse.do";
				commonAjax("POST", url, param, callback, false, null, null);
			}else{
				numberFormatForNumberClass();
			}
		}

		commonAjax("POST", url, param, projectExpenseValidCallback, false, null, null);





    },//end doSave

    //삭제
    doDelete: function(){
		if(confirm("삭제하시겠습니까?")){
		   	var url = contextRoot + "/card/deleteCardUse.do";
		   	var param = {sNb : cardSnb};
		   	var callback = function(result){
		   		var obj = JSON.parse(result);
		   		var chk = obj.resultVal;
		   		if(chk>0){
		   			alert("삭제되었습니다.");
		   			opener.fnObj.doSearch();
			   		window.close();
		   		}else{
		   			alert("서버오류!!!.");
		   		}
		   	};
			commonAjax("POST", url, param, callback, false, null, null);
		}
     },//end doDelete


   	//인물 검색
 	openCustPopup : function(num){
		var option = "width=650px,height=760px,resizable=yes,scrollbars = yes";
		window.open(contextRoot+"/person/customerListPopup.do", "searchCpnPop" , option);
 	}




};//end fnObj.

//스케쥴 등록후 콜백
function openPageReload(){
	if(schedulePopup!= null) schedulePopup.close();
	$("#scheTitle").trigger("click");
}

//인물 검색 콜백
function cstPopupCallback(sNb,cpnSnb,cstNm,cpnNm,team,position){
	/* $('#sltCpn').html(cpnNm);
	$('#sltNm').html(cstNm);
	$('#sltCst').val(sNb);
	$('#cstSnb').val(sNb);
	$('#sltCst').show(); */
	var chk = true;

	$("input[name = 'cusUserId']").each(function(){
		if(sNb == $(this).val()){
			chk = false;
			return false;
		}
	})
	if(!chk){
		return ;
	}

	var stStr = "<span class=\"employee_list\" id=\"cusUserOneArea";
		stStr+= "_"+sNb+"\"  style=\"display:inline-block;\">";
		stStr+= "<span>"+cstNm+"</span>";
		stStr+= "<em>("+cpnNm+")</em>";
		stStr+= "<a onclick=\"javascript:fnObj.deleteCusUser("+sNb+");\" class=\"btn_delete_employee\">";
		stStr+= "<input type='hidden' name='cusUserId' value = '"+sNb+"'>";
		stStr+= "<em>삭제</em></a>";

	$("#dotCusUserBtnLineTh").attr("rowspan","2");
	$("#dotCusLine").show();
	$("#cusUserSelectArea").append(stStr);

	//$("#etcNumArea").hide();

}

// 계정과목안내-레이어박스
function showlayer(id){
	if(id.style.display == 'none'){
		id.style.display='block';
	}else{
		id.style.display = 'none';
	}
}

// 계정과목안내-팝업
function showPopup(){
	var url = "${pageContext.request.contextPath}/card/dvGuide/pop.do";
	var option = "width=560px,height=750px,resizable=yes,scrollbars = yes";
	window.open(url, "_blank", option);
}

//프로젝트 셀렉트박스 체인지
function chgProjectId(){
	var projectId = $("#projectId").val();
	$("#activityDescArea").text("");
	if(projectId == ""){
		$("#activityId").html("<option value = ''>선택</option>");
		return;
	}
	var commonActivity = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.activityTitle } 선택', { orgId : orgId,projectId : projectId, userId : "${baseUserLoginInfo.userId}" ,type:"ACTIVITY",incApproveActivity:"N",incCardActivity:"Y",startDate:$("#tmDt").val()});
	var activityTag = createSelectTagForProject('activityId', commonActivity, 'CD', 'NM', '', null, colorObj, null, 'select_b mgl6','ACTIVITY');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("#activityArea").html(activityTag);

	$("#activityId").change(function(){
		$("#activityDescArea").text("");
		if($("#activityId").val()==""){
			$("#activityDescArea").text("");
			return;
		}
		var startDateStr = $("#activityId option:selected").attr("startdate");
		var endDateStr = $("#activityId option:selected").attr("enddate");

		$("#activityDescArea").text("기간 : "+startDateStr + " ~ " + endDateStr);
	});
	if($("#activityId").val()!="") $("#activityId").change();
}

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//선코딩
	fnObj.pageStart();		//화면세팅

	g_rowId =0;        // tr Id초기화
    fnObj.supplieDivSet();

    fnObj.dotLineDisplaySet();
});




</script>