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
	<input type="hidden" id="cstSnb" value="0">	<!-- 고객ID -->
	<input type="hidden" id="schSeq" value="0">	<!-- 스케쥴seq -->
	<input type="hidden" id="dv2">	<!-- dv2 -->
	<div class="popModal_wrap">
		<h3 class="pop_title">지출 상세</h3>
		<div class="conBox">
		<table id="SGridTarget" class="tb_basic_left" summary="지출등록">
	        <caption>
	         	지출등록
	        </caption>
	        <colgroup>
	       	    <col width="120"/>
	            <col width="*"/>
	        </colgroup>
	        <c:if test="${not empty card.cardNickname }">
		        <!--=============================카드선택 입력란 : S================================-->
	            <tr id="cardTr">
	               <th scope="row">카드</th>
	               <td>
	                   <div id="cardDiv">
	                   		<c:set var="cardNumBuf" value="${fn:split(card.cardNum,'-')}"></c:set>
	                   		${card.cardNickname }(${cardNumBuf[3] })
	                   </div>
	               </td>
	            </tr>
	            <!--=============================카드선택 입력란 : E================================-->
            </c:if>
	        <tr>
			    <th scope="row">일자</th>
				<td>
					${card.tmDt }
				</td>
            </tr>
			<tr>
				<th scope="row">${baseUserLoginInfo.projectTitle }</th>
				<td id = "projectAreaTd">
					<div><strong>${card.projectNm }-${card.activityNm }</strong> 기간 : ${card.activityStartDate } ~ ${card.activityEndDate }</div>
				</td>
			</tr>
	       	<tr>
				<th>계정과목</th>
				<td>
					<span id="dvSelect">

					</span>		<!-- 계정과목선택 SELECT -->
					<script type="text/javascript">
						var dvList=[];				//dv 리스트
						var dv2List=[];				//dv2 리스트
						dv2List = getBaseCommonCode('ACCOUNT_SUBJECT', '', 'CD', 'NM', null, '', '', { orgId : "${baseUserLoginInfo.applyOrgId}"});


						for(var i = 0 ; i < dv2List.length ; i++){

							var targetCd = dv2List[i].CD;
							if(targetCd == "${card.dv2}"){
								dvList =  getBaseCommonCode( dv2List[i].sonCodeName, '', 'CD', 'NM', null, '', '', { orgId : "${baseUserLoginInfo.applyOrgId}"});

								for(var j = 0 ; j < dvList.length ; j++){
									var targetCd2 = dvList[j].CD;

									if(targetCd2 == "${card.dv}"){
										 $("#dvSelect").text(dv2List[i].NM + "-" + dvList[j].NM); //그룹핑
									}
								}

							}
						}
					</script>
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
	       		 		${card.place }
	       		 	</td>
	       		</tr>
	       		<tr id="priceTr">
	         	 	<th scope="row">금액</th>
	       		 	<td>
	       		 		<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${card.price}" />
	       		 	</td>
	       		</tr>
	       		<tr>
	         	 	<th scope="row"><span id="noteSpan" class="star">* </span>내용</th>
	       		 	<td>
	       		 		${card.note }
	       		 	</td>
	       		</tr>
	       		<tr class="userTr" id="dotUserBtnLine" style="border-bottom: #9298a2 solid 1px;">
	         	 	<th scope="row" id="dotUserBtnLineTh">사원</th>
	       		 	<td>
	       		 		<c:forEach items="${userList }" var="data" varStatus="i">
	       		 			<c:if test="${i.index>0 }">,</c:if>
	       		 			${data.userName }(${data.position })
	       		 		</c:forEach>
	       		 	</td>
	       		</tr>
				<c:if test="${card.expenseDocYn eq 'Y'}">
		       		<tr>
	                    <th scope="row"></span>지출결의서</th>
	                    <td>
	                    	지출결의서 기작성건 <span class="spe_color_st4 mgl6">(* ${baseUserLoginInfo.projectTitle} 예산에서 차감되지 않습니다.)</span>
	                    </td>
	                </tr>
				</c:if>
	       		<!--================================ 일정 입력란 :S=====================================-->
	       		<tr id="scheduleTr">
                    <th scope="row">일정</th>
                    <td>
                       ${card.scheTitle }
                    </td>
                 </tr>
                 <!--================================ 일정 입력란 :E=====================================-->

                 <!--================================ 회사/고객 입력란 :S=====================================-->
                 <c:if test = "${fn:length(cusUserList)>0 }">
                 	<tr id="companyTr">
	                    <th scope="row">회사/고객</th>
	                    <td>
	                    	<c:forEach items="${cusUserList }" var="data" varStatus="i">
	                    		<c:if test = "${i.index>0 }">,</c:if>
	                    		${data.cstNm }(${data.cpnNm })
	                    	</c:forEach>

	                    	<c:if test="${card.etcNum >0 }"> 외 ${card.etcNum } 명</c:if>
	                    </td>
	                 </tr>
                 </c:if>
                 <!--================================ 회사/고객 입력란 :E=====================================-->

                 <!--=============================차량선택 입력란 : S================================-->
                 <c:if test="${card.carId ne 0 }">
	                 <tr id="carTr">
	                    <th scope="row">차량선택</th>
	                    <td>
	                        <div id="carDiv">${card.carNick }</div>
	                    </td>
	                 </tr>
                 </c:if>
                 <!--================================ 차량선택 입력란 :E=====================================-->

                 <!--================================ 목적지 입력란 :E=====================================-->
                 <tr id="destinationTr">
                    <th scope="row"><span id="destinationSpan" class="star"></span>목적지</th>
                    <td>
                        <span>출발지: ${card.fromLoc }
                        </span>
                        <span>/ 도착지: ${card.toLoc }
                        </span>
                    </td>
                 </tr>
            <!--================================ 목적지 입력란 :E=====================================-->

	       	<!--================================ 소모품 입력란 :S=====================================-->
	       		<c:if test="${fn:length(mroList)>0 }">
		       		<tr id="supplieTr">
		    			<td colspan="2">
		    	 			<div id="supplieDiv" style="padding:10px 20px;">
		    	 				<div class="addLine mgt10 mgb20">
		    	 					<table id="supplieAll" class="supplie_table" style="width:100%;">
		    	 						<colgroup>
		    	 							<col width="*%">
		    	 							<col width="20%">
		    	 							<col width="10%">
		    	 							<col width="20%">
		    	 							<col width="15%">
		    	 						</colgroup>
		    	 						<tbody>
		    	 							<tr>
		    	 								<td style="text-align:center;">
		    	 									<b>목록</b>
		    	 								</td>
		    	 								<td style="text-align:center;">
		    	 									<b>단가</b>
		    	 								</td>
		    	 								<td style="text-align:center;">
		    	 									<b>수량</b>
		    	 								</td>
		    	 								<td style="text-align:center;">
		    	 									<b>금액</b>
		    	 								</td>

		    	 							</tr>
		    	 							<c:set var="sumPrice" value="0"></c:set>
		    	 							<c:forEach items="${mroList }" var="data">
			    	 							<tr id="newTr0">

			    	 								<td style="text-align: center;">
			    	 									${data.mroName }
			    	 								</td>
			    	 								<td style="text-align: center;">
			    	 									<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.price }" />
			    	 								</td>
			    	 								<td style="text-align: center;">
			    	 									<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.qty }" />
			    	 								</td>
			    	 								<td style="text-align: center;">
			    	 									<c:set var="sumPrice" value="${sumPrice+data.price*data.qty }"></c:set>

			    	 									<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.price*data.qty }" />

			    	 								</td>

			    	 							</tr>
		    	 							</c:forEach>
		    	 							<tr>
		    	 								<td colspan="3" style="text-align:center;"><b>합   계</b></td>
		    	 								<td colspan="3" style="text-align:center;">
		    	 									<span id="sumDiv">
		    	 										<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${sumPrice }" />
		    	 									</span>
		    	 								</td>
		    	 							</tr>
		    	 						</tbody>
		    	 					</table>
		    	 				</div>
		    	 			</div>
		    	 		</td>
		    	 	</tr>
	    	 	</c:if>
	    	<!--================================ 소모품 입력란 :E=====================================-->
        </table>
        <div class="btnZoneBox" >
        	<span>
        		<c:if test="${card.sabun eq baseUserLoginInfo.empNo and card.approveYn eq 'N'}">
        			<c:set var="btnNm" value="수정"></c:set>
        			<c:if test="${empty card.dv}"><c:set var="btnNm" value="등록"></c:set></c:if>
					<a href="javascript:goModifyPage();" class="p_blueblack_btn"><strong><span id="regTxtSpan">${btnNm }</span></strong></a>
				</c:if>
			</span>
			<a href="javascript:window.close();" class="p_withelin_btn">닫기</a>
		</div>
   </div>


   <script type="text/javascript">
	   // 계정과목안내-팝업
	   function showPopup(){
		   	var url = "${pageContext.request.contextPath}/card/dvGuide/pop.do";
		   	var option = "width=560px,height=750px,resizable=yes,scrollbars = yes";
		   	window.open(url, "_blank", option);
	   }
	   //수정페이지
	   function goModifyPage(){
	   		location.href = "${pageContext.request.contextPath}/card/regCard/pop.do?cardSnb="+${param.cardSnb};
	   }
   </script>