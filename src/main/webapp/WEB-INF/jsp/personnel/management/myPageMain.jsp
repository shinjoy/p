<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	var innerHour = '<fmt:formatDate value="${curTime}" type="both" pattern="HH"/>';
	var innerMin = '<fmt:formatDate value="${curTime}" type="both" pattern="mm"/>';
	var innerSec = '<fmt:formatDate value="${curTime}" type="both" pattern="ss"/>';

	var hour = parseInt(innerHour);
	var min = parseInt(innerMin);
	var sec = parseInt(innerSec);

	var timer;

	$(document).ready(function(){

		$("#hourArea").text(innerHour);
		$("#minArea").text(innerMin);
		$("#secArea").text(innerSec);
		timer = setInterval(function () {
			sec++;

			if(sec==60){
				sec = 0;
				min++;
				if(min==60){
					hour ++;
					min = 0;
					if(hour == 24) hour = 0;
				}
			}

			$("#secArea").text(sec<10?"0"+sec:sec);
			$("#minArea").text(min<10?"0"+min:min);
			$("#hourArea").text(hour<10?"0"+hour:hour);
	    }, 1000); /* millisecond 단위의 인터벌 */
	});

	//출근
	function procWork(){

		if("${todayWorkInfo.workType}" == "NO_WORK"){
			alert("[결근]상태일때는 출근처리할수 없습니다.");
			return;
		}

		if("${todayWorkInfo.inTime}" != ""){
			//alert("이미 출근처리 되었습니다.");
			return;
		}
		var url = contextRoot + "/mypersonnel/processWorcAjax.do";
    	/*=========== 첨부파일 : E =========== */
    	
    	var loginLoc = contactDeviceChk();
    	
    	var param = {
    			
    			loginLoc : loginLoc
    	}
    	var callbackProcWork = function(data){
    		data = JSON.parse(data);
    		if(data.resultObject.result =="SUCCESS"){
        		alert("출근처리되었습니다.");

        		location.href = contextRoot + '/mypersonnel/myPageMain.do';
    		}else{
    			if(data.resultObject.msg != null){
        			alert(data.resultObject.msg);
        			return;
        		}
    		}
    	};
    	commonAjax('POST', url, param, callbackProcWork);
	}

	//퇴근
	function procWorkEnd(){

		if("${todayWorkInfo.workType}" == "NO_WORK"){
			alert("[결근]상태일때는 퇴근처리할수 없습니다.");
			return;
		}
		var url = contextRoot + "/mypersonnel/processWorcEndAjax.do";
    	/*=========== 첨부파일 : E =========== */
    	var loginLoc = contactDeviceChk();
    	
    	var param = {
    			
    			loginLoc : loginLoc
    	}
    	
    	var callbackProcWorkEnd = function(data){
    		data = JSON.parse(data);
    		if(data.resultObject.result =="SUCCESS"){
        		alert("퇴근처리되었습니다.");

        		location.href = contextRoot + '/mypersonnel/myPageMain.do';
    		}else{
    			if(data.resultObject.msg != null){
        			//alert(data.resultObject.msg);
        			return;
        		}
    		}


    	};
    	commonAjax('POST', url, param, callbackProcWorkEnd);
	}

	////----------- 메일 읽지 않은 갯수 ----------------
	function getEmailCount2(mailAccount){

		//var url = "http://mail.synergynet.co.kr/api/api_mail_get.php";
		var url = "http://${baseUserLoginInfo.mailUrl}/api/api_mail_get.php";
		var param = {
				"id":mailAccount.trim(),
				"returntype":"json"
		};

		var callback = function(result){
			var obj = JSON.parse(result);

			if(obj.result > 0){
				//999건 이 넘어갈때는 999+ 로 표현
				$('#card_mail').addClass('update');
				if(obj.result>999) {
					$('#cardf_mail_count').html('999<sup>+</sup>');
					$('#cardb_mail_count').html('999+');
				}
				else{
					$('#cardf_mail_count').html(obj.result);
					$('#cardb_mail_count').html(obj.result);
				}
			}
			else{
				$('#cardf_mail_count_ballon').hide()
			}
		};
		var failcallback = function(result){

		};

		$.support.cors = true; // ie9에서 발생하는 크로스도메인 이슈해결하기 위한 코드
		commonAjaxForFail("POST", url, param, callback, failcallback);
	}


	function movePage(type){
		switch(type){
		case 'approveWorking':
			//검색조건 셋팅 : S
			//var $searchInput = $("<input></input>").attr("type","hidden").attr("name","searchDocStatus").val("WORKING");
			//$("#mainPageLeftFrm").append($searchInput);
			//검색조건 셋팅 : E

			$("#mainPageLeftFrm").attr("action",contextRoot+"/approve/draftDocList.do").submit();
			break;
		case 'approveReq':
			//검색조건 셋팅 : S
			var $searchInput = $("<input></input>").attr("type","hidden").attr("name","searchAppvStatus").val("REQ");
			$("#mainPageLeftFrm").append($searchInput);
			//검색조건 셋팅 : S
			var $searchInput2 = $("<input></input>").attr("type","hidden").attr("name","searchDocStatus").val("APPROVE");
			$("#mainPageLeftFrm").append($searchInput2);
			//검색조건 셋팅 : E

			$("#mainPageLeftFrm").attr("action",contextRoot+"/approve/approveReqList.do").submit();
			break;
		case 'approveRef':

			$("#mainPageLeftFrm").attr("action",contextRoot+"/approve/approveRefList.do").submit();
			break;
		case 'info':
			//검색조건 셋팅 : S
			var $searchInput = $("<input></input>").attr("type","hidden").attr("name","searchMyList").val("Y");
			$("#mainPageLeftFrm").append($searchInput);
			//검색조건 셋팅 : E

			$("#mainPageLeftFrm").attr("action",contextRoot+"/business/businessInfoList.do").submit();
			break;
		case 'infoComment':
			//검색조건 셋팅 : S
			var $searchInput = $("<input></input>").attr("type","hidden").attr("name","searchMyList").val("Y");
			$("#mainPageLeftFrm").append($searchInput);
			//검색조건 셋팅 : E

			$("#mainPageLeftFrm").attr("action",contextRoot+"/business/businessCommentList.do").submit();
			break;
		case 'improvement':  //PASS 개선신청

            $("#mainPageLeftFrm").attr("action",contextRoot+"/board/boardList/qna/improvement.do").submit();
            break;
        case 'modifyUsrInfo':  //비밀번호 변경

            $("#mainPageLeftFrm").attr("action",contextRoot+"/login/modifyUsrInfo.do").submit();
            break;
        case 'workDaily':  //오늘할일
        	$("#mainPageLeftFrm").attr("action",contextRoot+"/work/getDailyWork.do").submit();
        	break;
        case 'newMemo':  //업무메모
        	$("#mainPageLeftFrm").attr("action",contextRoot+"/work/getDailyWork.do").submit();
        	break;
        case 'personnelInfo':  //인사정보
        	$("#mainPageLeftFrm").attr("action",contextRoot+"/mypersonnel/getMyPersonnelInfo.do").submit();
        	break;
        case 'myMenu':  //메뉴 바로가기
        	$("#mainPageLeftFrm").attr("action",contextRoot+"/basic/bookMarkList.do").submit();
        	break;
        case 'mailLinkView':
        	$("#mainPageLeftFrm").attr("action",contextRoot+"/email/emailView.do").submit();
        	break;
        case 'mailLinkSetup':
        	$("#mainPageLeftFrm").attr("action",contextRoot+"/email/emailLinkSetup.do").submit();
        	break;
		}
	}
</script>
<form id = "mainPageLeftFrm" name = "mainPageLeftFrm" method="post"></form>
<section id="detail_contents">
	<div class="mypageCardWrap">
		<ul id="grid-containter" class="mypageCardList">
			<c:if test="${baseUserLoginInfo.orgId eq baseUserLoginInfo.applyOrgId }">
			<c:if test="${attendCount>0 }">
			<!--근태정보-->
			<li class="attendance_checkBox <c:if test = "${!empty todayWorkInfo.workType }">update</c:if>">
				<div>
					<h5 class="card_title">근태정보</h5>
					<div class="card_con">
						<p class="date_box">
							<span>
							<fmt:formatDate value="${curTime}" type="both" pattern="yyyy/MM/dd"/>
							</span>
							<em>(<fmt:formatDate value="${curTime}" type="both" pattern="E"/>)</em>
						</p>
						<div class="time_box"><span id = "hourArea">00</span>:<span id = "minArea">00</span>:<span id = "secArea">00</span></div>

						<c:if test="${todayWorkInfo.inTime ne null}">
							<p class="ip_box"><span class="icon_PC"><em>PC</em></span><span>(${todayWorkInfo.inContactIp })</span></p>
							<c:choose>
								<c:when test="${todayWorkInfo.workType eq 'WORK' or todayWorkInfo.workType eq 'HOLIDAY'}"><p class="atten_result"><span>'출근 _ <fmt:formatDate value="${todayWorkInfo.inTime}" type="both" pattern="HH:mm"/>'</span></p></c:when>
								<c:when test="${todayWorkInfo.workType eq 'LATE' }"><p class="atten_result"><span class="wrong">'지각 _ <fmt:formatDate value="${todayWorkInfo.inTime}" type="both" pattern="HH:mm"/>'</span></p></c:when>
								<c:when test="${todayWorkInfo.workType eq 'NO_WORK' }"><p class="atten_result"><span class="wrong">'결근'</span></p></c:when>
							</c:choose>
						</c:if>
						<c:if test="${todayWorkInfo.outTime ne null}">
							<p class="atten_result offwork"><span>'퇴근 _ <fmt:formatDate value="${todayWorkInfo.outTime}" type="both" pattern="HH:mm"/>'</span></p>
						</c:if>
						<%--<p class="ip_box"><span class="icon_secom"><em>SECOM</em></span><span>세콤인증</span></p>
						<p class="ip_box"><span class="icon_mobile"><em>Mobile</em></span><span>모바일접속</span></p>--%>
					</div>
					<c:if test="${checkLogin eq true}">
						<div class="card_btnArea">
							<button
								<%-- <c:choose>
									<c:when test="${todayWorkInfo.inTime eq null and todayWorkInfo.workYn eq 'Y'}">class="need_check"</c:when>
									<c:otherwise>disabled="disabled"</c:otherwise>
								</c:choose> --%>
							 type="button" onclick="procWork()">출근</button>
							 <button
							 	<c:if test="${todayWorkInfo.inTime ne null}">class="need_check"</c:if>
							 type="button" onclick="procWorkEnd()">퇴근</button>
						</div>
			    </c:if>
					<span class="update_icon"><em>NEW</em></span>
				</div>
			</li>
			</c:if>
			<!--//근태정보//-->
			<c:if test="${fn:indexOf(moduleCodeStr,'CALENDAR')>0}">
			<!--업무일지_오늘할일-->
			<li class="card-grid cd_todolist <c:if test="${workDailyCnt >0}">update</c:if>">
				<div class="front">
					<h5 class="card_title">오늘 할일</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
					<c:if test="${workDailyCnt >0}">
						<c:set var = "workDailyCntBuf" value="${workDailyCnt>99?99:workDailyCnt }"/>
						<span class="count_new">
							<span>${workDailyCntBuf }</span>
							<c:if test="${workDailyCnt >99}">
								<sup>+</sup>
							</c:if>

						</span>
					</c:if>

				</div>
				<div class="back">
					<h5 class="card_title">오늘 할일</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('workDaily')">Read More</button>
					</div>
				</div>
			</li>
			</c:if>
			<!--//업무일지_오늘할일//-->
			<!--업무일지_업무메모-->
			<c:if test="${fn:indexOf(moduleCodeStr,'MEMO')>0 }">
			<li class="card-grid cd_memobox <c:if test="${newMemoCount >0}">update</c:if>">
				<div class="front">
					<h5 class="card_title">업무메모</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
					<c:if test="${newMemoCount >0}">
						<c:set var = "newMemoCountBuf" value="${newMemoCount>99?99:newMemoCount }"/>
						<span class="count_new">
							<span>${newMemoCountBuf }</span>
							<c:if test="${newMemoCount >99}">
								<sup>+</sup>
							</c:if>

						</span>
					</c:if>
				</div>
				<div class="back">
					<h5 class="card_title">업무메모</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('newMemo')">Read More</button>
					</div>
				</div>
			</li>
			</c:if>
			<!--//업무일지_업무메모//-->

			<!--
			메일 셋업
			모듈코드에 EMAIL 포함되도록 해야 함
			and
			관계사 메일사용이 'Y'
			-->
			<c:if test="${fn:indexOf(moduleCodeStr,'APPROVE')>0 and baseUserLoginInfo.mailUseYn ne 'N' }">
			<li id="card_mail" class="card-grid cd_mailbox">
				<div class="front">
					<h5 class="card_title">메일</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
					<span id="cardf_mail_count_ballon" class="count_new">
						<span id="cardf_mail_count">0</span>
					</span>
				</div>


				<div class="back">
					<h5 class="card_title">메일</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('mailLinkSetup')">
							<p class="btn_tt">계정설정<p>
							<p class="countnum"></p>
						</button>
						<button type="button" class="rdmore_btn" onclick="movePage('mailLinkView')">
							<p class="btn_tt">신규메일<p>
							<p id="cardb_mail_count" class="countnum"></p>
						</button>
					</div>
				</div>
			</li>
			</c:if>
			<!--//전자결재//-->


			<!--전자결재-->
			<c:if test="${fn:indexOf(moduleCodeStr,'APPROVE')>0 }">
			<c:set var = "approveCnt" value="${approveWorkingCnt+approveReqCnt }"></c:set>
			<li class="card-grid cd_approvbox <c:if test="${approveCnt >0}">update</c:if>">
				<div class="front">
					<h5 class="card_title">전자결재</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
					<c:if test="${approveCnt >0}">
						<c:set var = "approveCntBuf" value="${approveCnt>99?99:approveCnt }"/>
						<span class="count_new">
							<span>${approveCntBuf }</span>
							<c:if test="${approveCnt >99}">
								<sup>+</sup>
							</c:if>

						</span>
					</c:if>
				</div>


				<div class="back">
					<h5 class="card_title">전자결재</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('approveWorking')">
							<p class="btn_tt">진행중문서<p>
							<p class="countnum">${approveWorkingCnt }</p>
						</button>
						<button type="button" class="rdmore_btn" onclick="movePage('approveReq')">
							<p class="btn_tt">결재할문서<p>
							<p class="countnum">${approveReqCnt }</p>
						</button>
					</div>
				</div>
			</li>
			</c:if>
			<!--//전자결재//-->
			<!--정보공유-->
			<c:if test="${fn:indexOf(moduleCodeStr,'COMMENT')>0 }">
			<li class="card-grid cd_shareinfo <c:if test="${myBusinessComenntCnt >0}">update</c:if>">
				<div class="front">
					<h5 class="card_title">영업정보</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
					<c:if test="${myBusinessComenntCnt >0}">
						<c:set var = "myBusinessComenntCntBuf" value="${myBusinessComenntCnt>99?99:myBusinessComenntCnt }"/>
						<span class="count_new">
							<span>${myBusinessComenntCntBuf }</span>
							<c:if test="${myBusinessComenntCnt >99}">
								<sup>+</sup>
							</c:if>
						</span>
					</c:if>
				</div>
				<div class="back">
					<h5 class="card_title">영업정보</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('info')">Read More</button>
					</div>

				</div>
			</li>
			<!--//정보공유//-->
			<!--정보 코멘트-->
			<li class="card-grid cd_infocomment <c:if test="${myCommentListCnt >0}">update</c:if>">
				<div class="front">
					<h5 class="card_title">영업정보 코멘트</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
					<c:if test="${myCommentListCnt >0}">
						<c:set var = "myCommentListCntBuf" value="${myCommentListCnt>99?99:myCommentListCnt }"/>
						<span class="count_new">
							<span>${myCommentListCntBuf }</span>
							<c:if test="${myCommentListCnt >99}">
								<sup>+</sup>
							</c:if>
						</span>
					</c:if>
				</div>
				<div class="back">
					<h5 class="card_title">영업정보 코멘트</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('infoComment')">Read More</button>
					</div>

				</div>
			</li>
			</c:if>
			<!--//정보 코멘트//-->
			<!--인사정보-->
			<li class="card-grid cd_infoprofile">
				<div class="front">
					<h5 class="card_title">인사정보</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
				</div>
				<div class="back">
					<h5 class="card_title">인사정보</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('personnelInfo')">Read More</button>
					</div>
				</div>
			</li>
			<!--//인사정보//-->
			<!--비밀번호 변경-->
			<li class="card-grid cd_changepw">
				<div class="front">
					<h5 class="card_title">비밀번호 변경</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
				</div>
				<div class="back">
					<h5 class="card_title">비밀번호 변경</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('modifyUsrInfo')">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
				</div>
			</li>
			<!--//비밀번호 변경//-->
			</c:if>
			<!--메뉴바로가기-->
			<li class="card-grid cd_favorMgt">
				<div class="front">
					<h5 class="card_title">메뉴 바로가기</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
				</div>
				<div class="back">
					<h5 class="card_title">메뉴 바로가기</h5>
					<div class="card_con">
						<div class="img_visual_icon"></div>
						<p class="cardmn_des">메뉴바로가기 메뉴로 이동합니다 자주사용하는 메뉴를 편집해서 사용하세요.</p>
					</div>
					<div class="card_btnArea">
						<button type="button" class="rdmore_btn" onclick="movePage('myMenu')">Read More</button>
					</div>
					<span class="update_icon"><em>NEW</em></span>
				</div>
			</li>
			<!--//메뉴바로가기//-->
		</ul>
	</div>
</section>
<script src="${pageContext.request.contextPath}/js/prettify.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.mobile-events.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.flip.min.js"></script>
<script type="text/javascript">
	 $(function(){
	   prettyPrint();

	   $(".card-grid").flip({
	     trigger: 'hover'
	   });

	   getEmailCount2('${emailId}');
	 });
</script>