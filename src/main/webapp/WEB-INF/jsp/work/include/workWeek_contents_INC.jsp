<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
	$(document).ready(function(){
		doSearchMainContents();
	});
</script>
<c:set var="compareDeptId" value="0"></c:set>
<c:forEach items="${workWeekSelectUserList }" var="data" varStatus="i">

	<c:if test="${data.deptId ne compareDeptId }">
		<c:if test = "${i.index ne 0  }">
			</tbody>
				</table>
					</div><!-- fix Header -->
						</div>
							</div>
								</form>
									</div>
		</c:if>
		<div id = "workWeekArea_${data.deptId }">
			<form id = "workWeekFrm_${data.deptId }">
				<!-- 조회 주차 -->
				<input type="hidden" name = "weekNum" value="${weekNum }">

				<input type="hidden" name = "startStr" value="${startStr }">
				<input type="hidden" name = "endStr" value="${endStr }">
				<input type="hidden" name = "infoId">


				<h3 class="h3_title_basic mgt20"><span>${data.userDeptNm } 주간업무보고</span></h3>
				<c:set var="compareDeptId" value="${data.deptId }"></c:set>

				<div id="calendar">

				<div class="fc_toolbar">
					<%--<div class="fc_left mgl20">
						<span href="javascript:fnObj.doRead();" class="icon_teamname mgr20">IB투자</span>
					</div>--%>
					<%--<div class="fc_right"><a href="javascript:fnObj.doRead();" class="btn_today mgr20">TODAY</a></div>--%>

					<c:set var = "startStrBuf" value="${fn:split(startStr,'-') }"></c:set>
					<c:set var = "endStrBuf" value="${fn:split(endStr,'-') }"></c:set>

					<input type="hidden" name = "weekYear" value="${startStrBuf[0]}">
					<div class="fc_center">
						<a href="javascript:searchDept('${data.deptId }','prev')" class="btn_arrow">&lt;</a>
						${startStrBuf[0] }년${startStrBuf[1] }월<em> - ${startStrBuf[1] }.${startStrBuf[2] }(월) ~ ${endStrBuf[1] }.${endStrBuf[2] }(금)</em>
						<a href="javascript:searchDept('${data.deptId }','next')" class="btn_arrow">&gt;</a>
					</div>
				</div>

				<div id="weekwork_wrap">
					<div class="weekwork_header">

						<c:set var = "tuesStrBuf" value="${fn:split(tuesStr,'-') }"></c:set><!-- 화요일 -->
						<c:set var = "wedneStrBuf" value="${fn:split(wedneStr,'-') }"></c:set><!-- 수요일 -->
						<c:set var = "thursStrBuf" value="${fn:split(thursStr,'-') }"></c:set><!-- 목요일 -->


						<table class="weekwork_tb">
							<colgroup>
								<col width="100" />
								<col width="*" span="5" />
								<col width="200" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><span>이름</span><em>(직급)</em></th>
									<th scope="col"><span>${startStrBuf[1] }/${startStrBuf[2] }</span><em>(월)</em></th>
									<th scope="col"><span>${tuesStrBuf[1] }/${tuesStrBuf[2] }</span><em>(화)</em></th>
									<th scope="col"><span>${wedneStrBuf[1] }/${wedneStrBuf[2] }</span><em>(수)</em></th>
									<th scope="col"><span>${thursStrBuf[1] }/${thursStrBuf[2] }</span><em>(목)</em></th>
									<th scope="col"><span>${endStrBuf[1]}/${endStrBuf[2]}</span><em>(금)</em></th>
									<th scope="col">비고</th>
								</tr>
							</thead>
						</table>
					</div>

					<div class="weekwork_conBox">
						<table class="weekwork_tb">
							<colgroup>
								<col width="100" />
								<col width="*" span="5" />
								<col width="200" />
							</colgroup>
							<tbody>
	</c:if>

					<tr <c:if test = "${data.userId eq baseUserLoginInfo.userId }">class="mine"</c:if>>
						<th scope="row">
							<input type="hidden" name = "weekSearchUserId" value="${data.empNo }">
							<p class="team_mbname">
								<strong>
									<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId}",$(this),"mouseover",null,5,-80,100)'>
									${data.name }
								</strong>
								<em>(${data.rankNm })</em>
							</p>
							<c:if test = "${data.deptMngrYn eq 'Y' }"><p class="team_leader">부서장</p></c:if>
						</th>
						<td>
							<ul class="todo_list" id = "todoList_${data.userId }_${startStrBuf[1] }_${startStrBuf[2] }" >
							</ul>
							<ul class="share_info_list" id = "shareInfo_${data.userId }_${startStrBuf[1] }_${startStrBuf[2] }">
							</ul>
						</td>
						<td>
							<ul class="todo_list" id = "todoList_${data.userId }_${tuesStrBuf[1] }_${tuesStrBuf[2] }" >
							</ul>
							<ul class="share_info_list" id = "shareInfo_${data.userId }_${tuesStrBuf[1] }_${tuesStrBuf[2] }">
							</ul>
						</td>
						<td>
							<ul class="todo_list" id = "todoList_${data.userId }_${wedneStrBuf[1] }_${wedneStrBuf[2] }" >
							</ul>
							<ul class="share_info_list" id = "shareInfo_${data.userId }_${wedneStrBuf[1] }_${wedneStrBuf[2] }">
							</ul>
						</td>
						<td>
							<ul class="todo_list" id = "todoList_${data.userId }_${thursStrBuf[1] }_${thursStrBuf[2] }" >
							</ul>
							<ul class="share_info_list" id = "shareInfo_${data.userId }_${thursStrBuf[1] }_${thursStrBuf[2] }">
							</ul>
						</td>
						<td>
							<ul class="todo_list" id = "todoList_${data.userId }_${endStrBuf[1] }_${endStrBuf[2] }" >
							</ul>
							<ul class="share_info_list" id = "shareInfo_${data.userId }_${endStrBuf[1] }_${endStrBuf[2] }">
							</ul>
						</td>
						<td class="etc_vtop">
							<span class="vm">
								<c:if test = "${data.userId eq baseUserLoginInfo.userId or (data.deptId eq baseUserLoginInfo.deptId and baseUserLoginInfo.deptMngrYn eq 'Y')}">
									<a class="memoBtn" onclick="openMemo('${data.userId }');" style="cursor:pointer;">
										<em>비고입력</em>
									</a>
								</c:if>
								<span id = "memoArea_${data.userId }"></span>
								<div class="memoInnerArea" id = "memoInnerArea_${data.userId }" style="display: none;">
									<div id="memoArea" class="memoAreaWrap">
										<h4 class="memotitle">[비고입력]</h4>
										<div id="memoSpending">
											<textarea class="txtarea_b w100pro" id="memoText_${data.userId }" placeholder="비고내용을 입력해주세요."></textarea>
										</div>
										<div class="btnzone">
											<a href="javascript:regMemo('${data.userId }','${data.deptId }','${startStr }','${endStr }');" id="memoSave" class="btn_s_type_g" style="cursor:pointer;">등록</a>
											<a href="javascript:eleMemoDiv('${data.userId }');" class="btn_s_type_g" style="cursor:pointer;">닫기</a>
										</div>
									</div>
								</div>
							</span>
						</td>
					</tr>


		<c:if test = "${i.index+1 eq fn:length(workWeekSelectUserList)  }">
								</tbody>
				</table>
					</div><!-- fix Header -->
						</div>
							</div>
								</form>
									</div>
		</c:if>

</c:forEach>
