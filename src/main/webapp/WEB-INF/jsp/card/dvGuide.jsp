<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% pageContext.setAttribute("LF", "\n"); %>

<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

%>

<div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>계정과목 안내</strong></h1>
            <div class="mo_container2">
                <div class="popalarmWrap">
                    <h3 class="h3_title_basic">계정과목 안내</h3>

					<div class="popModal_wrap">
					    <div id="cardHlep" class="tooltip_box">
					        <div class="wrap_autoscroll">
					           <span class="intext">
					                <span id ="accountToolTip"></span><!-- 계정과목 안내 툴팁 -->
					                    <c:choose>
					                        <c:when test="${setupNote.note != null }">
					                            <ul class="list_st_dot3 mgb10 mgl10">
					                                 ${fn:replace(setupNote.note, LF,"<br/>")}
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
					        </div>
					    </div>
					</div>


                </div>
            </div>
            <!--창닫기-->
            <div class="todayclosebox">
                <!-- <div class="fl_block"><label><input type="checkbox"  name="check_today" id="check_today"  onclick="closeWin();"/><span>오늘은 그만보기</span></label></div> -->
                <div class="fr_block"><button type="button" class="btn_close" onClick="window.close();"><span>닫기</span><span>X</span></button></div>
            </div>
            <!--//창닫기//-->
        </div>
        <!--//업무일지등록//-->
    </div>
</form>

<script type="text/javascript">
//Global variables :S ---------------
//공통코드
var myGrid  = new SGrid();      // instance     new sjs
var myModal = new AXModal();        // instance

var sNb='${baseUserLoginInfo.userId}';            //로그인 유저의 sNb
var permission='${baseUserLoginInfo.permission}'; //로그인 유저의 permission
var division='${baseUserLoginInfo.orgId}';
var deptId='${baseUserLoginInfo.deptId}';         //팀 시퀀스
var cardSnb='${cardSnb}';                         //지출 시퀀스
var g_gridListStr;                                //그리드 데이터 string (객체화되기전 문자열 json... JSON.parse 로 객체로 만들어사용) (증권사 필터링을 위해..)
var colorObj = {};
var orgId = "${baseUserLoginInfo.orgId}";
//Global variables :E ---------------
/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
// var fnObj = {

//  // 선로딩코드
//  preloadCode: function(){

        // 공통
        dv2List = getBaseCommonCode('ACCOUNT_SUBJECT', '', 'CD', 'NM', null, '', '', { orgId : "${baseUserLoginInfo.applyOrgId}"});
        dvList = getBaseCommonCode('', '', 'CD', 'NM', null, '', '',{sSortOrder : 'Y' , parentCodeSetNm : 'ACCOUNT_SUBJECT', orgId : "${baseUserLoginInfo.applyOrgId}"});

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
        var beforeCodeName = '';
        var cdObj          = {};
        var beforeDtailCd  = '';
        var cdCnt          = 0;

        for( var i=0; i< dv2List.length; i++ ){
            if( beforeDtailCd != dv2List[i].sonCodeName ){
                if( i!=0 ){
                    cdObj[beforeDtailCd] = cdCnt;
                    cdCnt = 0;
                }
            }
            for( var k=0; k<dvList.length; k++ ){
                if( dvList[k].codeName == dv2List[i].sonCodeName ){
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

        toolTipHtml += '                    </tbody>';
        toolTipHtml += '                </table>';

        $("#accountToolTip").html(toolTipHtml);
        /*================ 계정과목 안내 툴팁 :E ===============*/

//  }

// }

function showlayer(id){
//  if(id.style.display == 'none'){
//      id.style.display='block';
//  }else{
//      id.style.display = 'none';
//  }
}

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
    showlayer(cardHlep);
//  fnObj.preloadCode(); //선코딩
});

</script>