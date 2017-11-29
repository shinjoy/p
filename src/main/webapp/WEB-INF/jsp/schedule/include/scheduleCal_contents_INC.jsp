<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
.highlight {
    border: 1px solid red;
    font-weight: bold;
    font-size: 45px;
    background-color: lightblue;
}
</style>

<script>
//업무 드래그 이동/복사에 필요한 파라미터
var listScheSeq = "";
var listTargetDay ="";

$(document).ready(function () {

	var strHtml = "${dateVO.selYear}년 ${dateVO.selMonth}월<em> - ${dateVO.selMonth}.01(${dateVO.startWeek}) ~ ${dateVO.selMonth}.${dateVO.endDay}(${dateVO.endWeek})</em>";
    $("#spanSearchMonth").html(strHtml);

    var selYear = '${dateVO.selYear}';
    var selMonth = '${dateVO.selMonth}';
    var endDay = '${dateVO.endDay}';
    if(selMonth.length == 1) selMonth = "0" + selMonth;
    if(endDay.length == 1) endDay = "0" + endDay;

    var startDate = selYear + '-' + selMonth + '-01';
    var endDate = selYear + '-' + selMonth + '-' + endDay;
    $("#startDate").val(startDate);
    $("#endDate").val(endDate);

    if ( $.browser.msie ) {
        var expr = new RegExp('>[ \t\r\n\v\f]*<', 'g');
        $('#contentsArea').html( ($('#contentsArea').html() + "").replace(expr, '><')  );
    }

    //일정 옮기는 기능 로딩
    moveScheduleInit();

   /*  var width_c = ((document.body.clientWidth - 50) / 7) - 50;
    //$('.ellipsis').css('width', width_c);
    $('td[name=Caltitle]').css('width', width_c); */
});

//일정 옮기는 기능 로딩
function moveScheduleInit(){

	var receivChk = false;
    /** drag n drop **/
    $( ".darggableUl" ).sortable({
        start: function (event, ui) {
             receivChk = false;
             var targetId = ui.item.context.id;
             /* ui.item.toggleClass("schedule_conBox3 height30"); */
        },
        stop: function (event, ui) {
            if(!receivChk) return false;
            var targetId = ui.item.context.id;

            listScheSeq = $("#"+targetId).attr("id");

             var $target = $("#"+targetId).parent().parent();
             dialogChk = false;
             listTargetDay = $target.attr("id");
             dialog.push({body:'<b>확인</b> 선택하신 일정에\n원하는 액션을 선택해 주세요', type:'Caution', buttons:[
                    {buttonValue:'이동', buttonClass:'Blue', onClick:moveDateForSchedule, data:'MOVE'},
                    {buttonValue:'취소', buttonClass:'Green', onClick:moveDateForSchedule, data:'CANCEL'}
                ],
                onclose:function(){
                    if(!dialogChk) fnObj.doSearch();
                }
             });


         },
         receive : function (event, ui){
            receivChk = true;
         },

         connectWith : ".darggableUl",
         items: "li:not(.notDraggable)",
         placeholder: "schedule_conBox3 height30",
         /* axis:"y", */
         scrollSensitivity: 10,
         forcePlaceholderSize: true,
         /* appendTo: '#helperArea', */
         helper: 'clone'
    }).disableSelection();
     $(".darggableLi").disableSelection();
     /* $(".darggableUl").bind( "sortstart", function (event, ui) {
         ui.helper.css('margin-left', '90px' );
     }); */
}

//스케줄 일정이동
function moveDateForSchedule(type){

    dialogChk = true;
    if(type == 'CANCEL'){
        fnObj.doSearch();
        return false;
    }

    var url = contextRoot + "/schedule/moveDateForSchedule.do";

    var targetScheSeq = listScheSeq.split("_")[1];
    var targetTargetDay = listTargetDay.split("_")[1];

    var selYear = '${dateVO.selYear}';
    var selMonth = '${dateVO.selMonth}';
    var selDay = targetTargetDay;
    if(selMonth.length == 1) selMonth = "0" + selMonth;
    if(selDay.length == 1) selDay = "0" + selDay;

    var targetScheSDate = selYear + '-' + selMonth + '-' + selDay;

    /* alert(targetScheSeq);
    alert(targetTargetDay);
    alert(targetScheSDate); */

    var param = {
    		scheSeq      : targetScheSeq,
    		scheSDay    : targetTargetDay,
    		scheSDate : targetScheSDate
    };
    var callback = function(data){
        var result = JSON.parse(data);
        //성공이면 성공메세지를 , 실패면 서버단에서 보내온 실패 메세지를 보여준다.
        if(result.resultObject.result=="SUCCESS"){
            toast.push('저장되었습니다.');
        }else{
            dialog.push({body:"<b>확인!</b> "+result.resultObject.msg, type:""});
        }

        fnObj.doSearch();

    };
    commonAjax("POST", url, param, callback, false);
}
</script>
<input type="hidden" name="nextMonthEnd"  id="nextMonthEnd"        value="${nextMonthEnd}"/>

                            <!--/캘린더버튼/-->
                            <div id="contentsArea" class="fc_view_container">
                                <div class="calander_month_wrap">
                                    <table class="calander_month_st">
                                        <colgroup>
                                            <col width="14.5%" />
                                            <col width="14.5%" />
                                            <col width="14.5%" />
                                            <col width="14.5%" />
                                            <col width="14.5%" />
                                            <col width="13.75%" />
                                            <col width="13.75%" />
                                        </colgroup>
                                        <thead>
                                            <fmt:parseNumber var="width" value="${100/7}%" integerOnly="true"/>
                                            <tr>
                                                <th name="Caltitle" scope="col">SUN</th>
                                                <th name="Caltitle" scope="col">MON</th>
                                                <th name="Caltitle" scope="col">TUE</th>
                                                <th name="Caltitle" scope="col">WED</th>
                                                <th name="Caltitle" scope="col">THU</th>
                                                <th name="Caltitle" scope="col">FRI</th>
                                                <th name="Caltitle" scope="col">SAT</th>
                                            </tr>
                                            <c:set var="WeekSeq" value="0"/>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <c:forEach var="data" begin="1" end="${dateVO.startPosition - 1}" step="1" varStatus="status" >
                                                    <td><span class="dateNum blur">&nbsp;</span></td>
                                                    <c:set var="WeekSeq" value="${WeekSeq + 1}"/>
                                                </c:forEach>
                                                <c:forEach var="data" begin="1" end="${dateVO.endDay}" step="1" varStatus="status" >
                                                    <c:set var="Event" value="onclick=\"if(event.srcElement.id != 'MoreView${status.count}') ScheAdd('${status.count}');\" style=\"cursor:pointer;\""/>
                                                    <c:choose>
								                        <c:when test="${WeekSeq == 0}"><c:set var="FontColor" value="red"/></c:when>
								                        <c:when test="${WeekSeq == 6}"><c:set var="FontColor" value="blue"/></c:when>
								                        <c:otherwise><c:set var="FontColor" value="black"/></c:otherwise>
								                    </c:choose>
								                    <c:choose>
													    <c:when test="${dateVO.nowYear == dateVO.selYear && dateVO.nowMonth == dateVO.selMonth && status.count == dateVO.selDay}">
								                            <c:set var="TodayColor" value="today_bg"/>
								                        </c:when>
								                        <c:otherwise>
								                            <c:set var="TodayColor" value=""/>
								                        </c:otherwise>
								                    </c:choose>
                                                    <td id="scheSDay_${status.count}"  class="conrelative draggableTd ${TodayColor}" onClick="ScheAdd('${status.count}');" style="cursor:pointer">
                                                        <ul class="darggableUl ui-sortable">
                                                        <span id="${status.count}"  class="dateNum" >${status.count}</span>

                                                        <!-- -이번달 일정 Start -->
                                                        <!-- 휴일 -->
                                                          <div class="explain_tooltip"  onClick="event.stopPropagation();">
                                                            <div class="spe_datetxt">
                                                               <c:forEach var="holiResult" items="${HoliList}" varStatus="holiStatus">
                                                                      <c:if test="${status.count eq  holiResult.scheCalDay}">
		                                                               <c:choose>
		                                                                  <c:when test="${holiResult.nationalHol eq 'Y'}">
		                                                                      <span class="common">${holiResult.holiName}</span>
		                                                                  </c:when>
		                                                                  <c:when test="${holiResult.formalHol eq 'Y'}">
		                                                                      <span>[${holiResult.cpnNm}] ${holiResult.holiName}</span>
		                                                                  </c:when>
		                                                               </c:choose>
		                                                           </c:if>
		                                                       </c:forEach>
                                                            </div>
                                                            <div class="tooltip_box">
                                                                <span class="intext">
                                                                    <ul class="list_st_dash">
                                                                          <c:forEach var="holiResult" items="${HoliList}" varStatus="holiStatus">
                                                                                    <c:if test="${status.count eq  holiResult.scheCalDay}">
                                                                                          <c:choose>
	                                                                                  <c:when test="${holiResult.nationalHol eq 'Y'}">
	                                                                                      <li>${holiResult.holiName}</li>
	                                                                                  </c:when>
	                                                                                  <c:when test="${holiResult.formalHol eq 'Y'}">
	                                                                                      <li>[${holiResult.cpnNm}] ${holiResult.holiName}</li>
	                                                                                  </c:when>
	                                                                               </c:choose>
                                                                              </c:if>
                                                                          </c:forEach>
                                                                    </ul>
                                                                </span>
                                                                <em class="edge_topcenter"></em>
                                                            </div>
                                                        </div>
                                                        <!-- 일정 -->
                                                        <c:set var="viewCnt" value="0" />
                                                        <c:set var="calDayCnt" value="" />
								                        <c:forEach var="scheResult" items="${ScheList}" varStatus="scheStatus">
								                            <c:if test="${status.count eq  scheResult.scheCalDay}">
								                                <c:set var="calDayCnt" value="scheResult.calDayCnt" />
									                            <c:choose>
	                                                                <c:when test="${scheResult.calDayCnt eq 1}">
	                                                                    <li id="scheSeq_${scheResult.scheSeq}_${status.count}" class="${scheResult.cssMoveDate} schedule_conBox3 height90 bgtype${scheResult.projectCss}">
		                                                                   <div class="con_txt">
		                                                                      <a id="MoreView${status.count}"  onClick="event.stopPropagation();scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');" style="cursor:pointer" class="worktitle ellipsis">
		                                                                       <span class="time">
		                                                                          <c:choose>
		                                                                              <c:when test="${scheResult.scheAllTime eq 'Y'}">
		                                                                                  <span class="lang_kor">(종일)</span>
		                                                                              </c:when>
		                                                                              <c:otherwise>
		                                                                                  ${scheResult.scheSTime}~${scheResult.scheETime}
		                                                                              </c:otherwise>
		                                                                          </c:choose>
		                                                                       </span>
		                                                                       <br/>[${scheResult.activityNm}]<c:out value="${scheResult.scheTitle}"/>
		                                                                       </a>
		                                                                       <a id="MoreView${status.count}"  onClick="event.stopPropagation();scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');" style="cursor:pointer" class="worktitle ellipsis">
		                                                                       <p class="join_list ellipsis">${scheResult.entryNm}</p>
		                                                                       </a>
		                                                                   </div>
		                                                                 </li>
		                                                                 <c:set var="viewCnt" value="0" />
	                                                                </c:when>
	                                                                <c:when test="${scheResult.calDayCnt eq 2}">
	                                                                    <li id="scheSeq_${scheResult.scheSeq}_${status.count}" class="${scheResult.cssMoveDate} schedule_conBox3 height60 bgtype${scheResult.projectCss}">
					                                                        <div class="con_txt">
					                                                            <a id="MoreView${status.count}"  onClick="event.stopPropagation();scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');" style="cursor:pointer" class="worktitle ellipsis">
					                                                            <span class="time">
                                                                                  <c:choose>
                                                                                      <c:when test="${scheResult.scheAllTime eq 'Y'}">
                                                                                          <span class="lang_kor">(종일)</span>
                                                                                      </c:when>
                                                                                      <c:otherwise>
                                                                                          ${scheResult.scheSTime}~${scheResult.scheETime}
                                                                                      </c:otherwise>
                                                                                  </c:choose>
                                                                               </span>
					                                                            <br/>[${scheResult.activityNm}]<c:out value="${scheResult.scheTitle}"/>
					                                                            </a>
					                                                        </div>
					                                                    </li>
					                                                    <c:set var="viewCnt" value="0" />
	                                                                </c:when>
	                                                                <c:when test="${scheResult.calDayCnt eq 3}">
                                                                         <li id="scheSeq_${scheResult.scheSeq}_${status.count}" class="${scheResult.cssMoveDate} schedule_conBox3 height30 bgtype${scheResult.projectCss}">
                                                                              <div class="con_txt">
                                                                                  <a id="MoreView${status.count}"  onClick="event.stopPropagation();scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');"  style="cursor:pointer" class="worktitle ellipsis">
                                                                                  <span class="time">
                                                                                  <c:choose>
                                                                                      <c:when test="${scheResult.scheAllTime eq 'Y'}">
                                                                                          <span class="lang_kor">(종일)</span>
                                                                                      </c:when>
                                                                                      <c:otherwise>
                                                                                          ${scheResult.scheSTime}~${scheResult.scheETime}
                                                                                      </c:otherwise>
                                                                                  </c:choose>
                                                                               </span>
                                                                                  [${scheResult.activityNm}]<c:out value="${scheResult.scheTitle}"/>
                                                                                  </a>
                                                                              </div>
                                                                          </li>
	                                                                </c:when>
	                                                                <c:when test="${scheResult.calDayCnt > 3}">
	                                                                   <c:choose>
	                                                                       <c:when test="${viewCnt eq scheResult.calDayCnt}">
                                                                               <c:set var="viewCnt" value="0" />
                                                                            </c:when>
	                                                                         <c:when test="${viewCnt < 4}">
                                                                                <li id="scheSeq_${scheResult.scheSeq}_${status.count}" class="${scheResult.cssMoveDate} schedule_conBox3 height30 bgtype${scheResult.projectCss}">
                                                                                   <div class="con_txt">
                                                                                       <a id="MoreView${status.count}"  onClick="event.stopPropagation();scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');"  style="cursor:pointer" class="worktitle ellipsis">
                                                                                       <span class="time">
		                                                                                  <c:choose>
		                                                                                      <c:when test="${scheResult.scheAllTime eq 'Y'}">
		                                                                                          <span class="lang_kor">(종일)</span>
		                                                                                      </c:when>
		                                                                                      <c:otherwise>
		                                                                                          ${scheResult.scheSTime}~${scheResult.scheETime}
		                                                                                      </c:otherwise>
		                                                                                  </c:choose>
		                                                                               </span>
                                                                                       [${scheResult.activityNm}]<c:out value="${scheResult.scheTitle}"/>
                                                                                       </a>
                                                                                   </div>
                                                                               </li>
                                                                               <c:set var="viewCnt" value="${viewCnt+1}" />
                                                                           </c:when>
	                                                                   </c:choose>
	                                                                </c:when>
	                                                            </c:choose>
	                                                            <c:if test="${scheResult.calDayCnt > 4 && viewCnt eq 4}">
                                                                    <a id="MoreView${status.count}"  class="btn_more" onClick="event.stopPropagation();selDateScheduleList('${dateVO.selYear}', '${dateVO.selMonth}', '${status.count}');"  style="cursor:pointer"><em>일정더보기</em></a>
                                                                    <c:set var="viewCnt" value="${viewCnt+1}" />
                                                                </c:if>
	                                                        </c:if>
	                                                    </c:forEach>
	                                                    <c:if test="${calDayCnt eq ''}"><!-- 일정이없는날짜이면 || scheResult.cssMoveDate eq 'notDraggable' -->
	                                                        <li id="" class="height30"></li>
                                                        </c:if>
	                                                    </ul>
	                                                    <!-- -이번달 일정 End -->
                                                    </td>
                                                    <c:set var="WeekSeq" value="${WeekSeq + 1}"/>
								                    <c:if test="${WeekSeq == 7 && status.count != dateVO.endDay}">
								                    <c:set var="WeekSeq" value="0"/>
                                            </tr>
                                            <tr>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${WeekSeq == 7}">
                                                <c:set var="WeekSeq" value="0"/>
                                            </tr>
                                            <tr>
                                                </c:if>
                                                <c:set var="NextDay" value="1"/>
								                <c:forEach var="data" begin="1" end="${nextMonthEnd}" step="1" varStatus="status">
								                    <c:choose>
								                        <c:when test="${WeekSeq == 0}"><c:set var="FontColor" value="red"/></c:when>
								                        <c:when test="${WeekSeq == 6}"><c:set var="FontColor" value="blue"/></c:when>
								                        <c:otherwise><c:set var="FontColor" value="black"/></c:otherwise>
								                    </c:choose>
                                                    <td>
                                                        <span id="Next${status.count}"  class="dateNum blur">${NextDay}</span>
								                        <div id="NextScheView${status.count}"></div>
								                        <!-- -다음달 일정 Start -->
								                        <!-- 휴일 -->
                                                          <div class="explain_tooltip" onClick="event.stopPropagation();">
                                                            <div class="spe_datetxt">
                                                               <c:forEach var="holiResult" items="${NextHoliList}" varStatus="holiStatus">
                                                                      <c:if test="${status.count eq  holiResult.scheCalDay}">
                                                                       <c:choose>
                                                                          <c:when test="${holiResult.nationalHol eq 'Y'}">
                                                                              <span class="common">${holiResult.holiName}</span>
                                                                          </c:when>
                                                                          <c:when test="${holiResult.formalHol eq 'Y'}">
                                                                              <span>[${holiResult.cpnNm}] ${holiResult.holiName}</span>
                                                                          </c:when>
                                                                       </c:choose>
                                                                   </c:if>
                                                               </c:forEach>
                                                            </div>
                                                            <div class="tooltip_box">
                                                                <span class="intext">
                                                                    <ul class="list_st_dash">
                                                                          <c:forEach var="holiResult" items="${NextHoliList}" varStatus="holiStatus">
                                                                                    <c:if test="${status.count eq  holiResult.scheCalDay}">
                                                                                          <c:choose>
                                                                                      <c:when test="${holiResult.nationalHol eq 'Y'}">
                                                                                          <li>${holiResult.holiName}</li>
                                                                                      </c:when>
                                                                                      <c:when test="${holiResult.formalHol eq 'Y'}">
                                                                                          <li>[${holiResult.cpnNm}] ${holiResult.holiName}</li>
                                                                                      </c:when>
                                                                                   </c:choose>
                                                                              </c:if>
                                                                          </c:forEach>
                                                                    </ul>
                                                                </span>
                                                                <em class="edge_topcenter"></em>
                                                            </div>
                                                        </div>
                                                        <!-- 일정 -->
                                                        <c:set var="viewCnt" value="0" />
								                        <c:forEach var="scheResult" items="${NextScheList}" varStatus="scheStatus">
                                                            <c:if test="${status.count eq  scheResult.scheCalDay}">
                                                                <c:choose>
                                                                    <c:when test="${scheResult.calDayCnt eq 1}">
                                                                        <div id="" class="schedule_conBox3 height90 bgtype${scheResult.projectCss}">
                                                                           <div class="con_txt">
                                                                               <a href="javascript:scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');" class="worktitle ellipsis">
                                                                               <span class="time">
                                                                                  <c:choose>
                                                                                      <c:when test="${scheResult.scheAllTime eq 'Y'}">
                                                                                          <span class="lang_kor">(종일)</span>
                                                                                      </c:when>
                                                                                      <c:otherwise>
                                                                                          ${scheResult.scheSTime}~${scheResult.scheETime}
                                                                                      </c:otherwise>
                                                                                  </c:choose>
                                                                               </span>
                                                                               <br/>[${scheResult.activityNm}]<c:out value="${scheResult.scheTitle}"/>
                                                                               </a>
                                                                               <a href="javascript:scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');" class="worktitle ellipsis">
                                                                                   <p class="join_list ellipsis">${scheResult.entryNm}</p>
                                                                               </a>
                                                                           </div>
                                                                         </div>
                                                                         <c:set var="viewCnt" value="0" />
                                                                    </c:when>
                                                                    <c:when test="${scheResult.calDayCnt eq 2}">
                                                                        <div id="" class="schedule_conBox3 height60 bgtype${scheResult.projectCss}">
                                                                            <div class="con_txt">
                                                                                <a href="javascript:scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');" class="worktitle ellipsis">
                                                                                <span class="time">
                                                                                  <c:choose>
                                                                                      <c:when test="${scheResult.scheAllTime eq 'Y'}">
                                                                                          <span class="lang_kor">(종일)</span>
                                                                                      </c:when>
                                                                                      <c:otherwise>
                                                                                          ${scheResult.scheSTime}~${scheResult.scheETime}
                                                                                      </c:otherwise>
                                                                                  </c:choose>
                                                                               </span>
                                                                                <br/>[${scheResult.activityNm}]<c:out value="${scheResult.scheTitle}"/>
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                        <c:set var="viewCnt" value="0" />
                                                                    </c:when>
                                                                    <c:when test="${scheResult.calDayCnt eq 3}">
                                                                         <div id="" class="schedule_conBox3 height30 bgtype${scheResult.projectCss}">
                                                                              <div class="con_txt">
                                                                                  <a href="javascript:scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');" class="worktitle ellipsis">
                                                                                  <span class="time">
	                                                                                  <c:choose>
	                                                                                      <c:when test="${scheResult.scheAllTime eq 'Y'}">
	                                                                                          <span class="lang_kor">(종일)</span>
	                                                                                      </c:when>
	                                                                                      <c:otherwise>
	                                                                                          ${scheResult.scheSTime}~${scheResult.scheETime}
	                                                                                      </c:otherwise>
	                                                                                  </c:choose>
	                                                                               </span>
                                                                                  [${scheResult.activityNm}]<c:out value="${scheResult.scheTitle}"/>
                                                                                  </a>
                                                                              </div>
                                                                          </div>
                                                                    </c:when>
                                                                    <c:when test="${scheResult.calDayCnt > 3}">
                                                                       <c:choose>
                                                                           <c:when test="${viewCnt eq scheResult.calDayCnt}">
                                                                               <c:set var="viewCnt" value="0" />
                                                                            </c:when>
                                                                             <c:when test="${viewCnt < 4}">
                                                                                <div id="" class="schedule_conBox3 height30 bgtype${scheResult.projectCss}">
                                                                                   <div class="con_txt">
                                                                                       <a href="javascript:scheView('${scheResult.perSabun}', '${scheResult.scheSeq}', '${scheResult.projectId}', '');" class="worktitle ellipsis">
                                                                                       <span class="time">
		                                                                                  <c:choose>
		                                                                                      <c:when test="${scheResult.scheAllTime eq 'Y'}">
		                                                                                          <span class="lang_kor">(종일)</span>
		                                                                                      </c:when>
		                                                                                      <c:otherwise>
		                                                                                          ${scheResult.scheSTime}~${scheResult.scheETime}
		                                                                                      </c:otherwise>
		                                                                                  </c:choose>
		                                                                               </span>
                                                                                       [${scheResult.activityNm}]<c:out value="${scheResult.scheTitle}"/>
                                                                                       </a>
                                                                                   </div>
                                                                               </div>
                                                                               <c:set var="viewCnt" value="${viewCnt+1}" />
                                                                           </c:when>
                                                                       </c:choose>
                                                                    </c:when>
                                                                </c:choose>
                                                                <c:if test="${scheResult.calDayCnt > 4 && viewCnt eq 4}">
                                                                    <a id="NextMoreView${status.count}"  class="btn_more" href="javascript:selDateScheduleList('${dateVO.selYear}', '${dateVO.selMonth + 1}', '${status.count}');" ><em>일정더보기</em></a>
                                                                    <c:set var="viewCnt" value="${viewCnt+1}" />
                                                                </c:if>
                                                            </c:if>
                                                        </c:forEach>
								                        <!-- 다음달 일정 End  -->
                                                    </td>
                                                    <c:set var="NextDay" value="${NextDay + 1}"/>
								                    <c:set var="WeekSeq" value="${WeekSeq + 1}"/>

								                    <c:if test="${WeekSeq == 7 && status.count != nextMonthEnd}">
								                    <c:set var="WeekSeq" value="0"/>
                                              </tr>
                                              <tr>
                                                  </c:if>
                                              </c:forEach>
								              </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>