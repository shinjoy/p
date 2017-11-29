<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


	<div id="compnay_dinfo">
		<!--회사상세보기(회사정보)-->
		<div class="modalWrap2">
			<h1><strong>인사정보</strong></h1>
			<div class="mo_container">
				<!--검색창-->
				<div  id="personnelSerach">
					<div class="carSearchBox">
					    <label>
					        <span class="carSearchtitle">직원명</span>
					        <input id="staffNm" name="staffNm" value="${userName}" onKeyup="fnObj.checkEnter(event,'emp');" class="input_b2 w180px">
						</label>
						<button type="button" onclick="fnObj.searchEmployee();" class="btn_g_black mgl10">조회</button>
						<label>
						    <span class="carSearchtitle mgl30">직무명</span>
						    <input id="workNm" name="workNm" value="${workStf}" onKeyup="fnObj.checkEnter(event,'work');" class="input_b2 w180px">
						</label>
						<button type="button" onclick="fnObj.searchWork();" class="btn_g_black mgl10">조회</button>
					</div>
				</div>
				<%-- <div id="personnelSerach">
					<table class="tb_ProfileInfo" summary="고객검색">
						<caption>고객검색</caption>
						<colgroup>
							<col width="80" />
							<col width="*" />
							<col width="80" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row" rowspan="2" class="bgGray">
								<label	for="company">직원명</label></th>
								<td><input type="text" id="staffNm" name="staffNm" value="${userName}" onKeyup="fnObj.checkEnter(event,'emp');"	class="applyinput_B" />
								<a href="javascript:fnObj.searchEmployee()" class="mgl8 s_violet01_btn"><em class="search">조회</em></a></td>
								<th scope="row" rowspan="2" class="bgGray">
								<label	for="company">직무명</label></th>
								<td><input type="text" id="workNm" name="workNm"  value="${workStf}" onKeyup="fnObj.checkEnter(event,'work');" class="applyinput_B" />
								<a href="javascript:fnObj.searchWork()" class="mgl8 s_violet01_btn"><em class="search">조회</em></a></td>
							</tr>
						</tbody>
					</table>
				</div> --%>
			<!--검색결과無-->
			<div class="reaserch_result" id="withoutResult" style="display:none;">
				<p class="reNum">
					<span class="search_name_txt">‘홍길’</span> 검색결과 : <strong>0</strong>
				</p>
				<!-- <div class="re_CompanyList">
					<p class="txt">
						<span >‘홍길’</span>에 대한 검색결과가 없습니다.
					</p>
				</div> -->
				<table class="tb_list_basic" summary="직원검색결과 (이름, 소속회사, 부서명, 담당업무, 채용형태)">
					<caption>직원검색결과</caption>
					<thead>
						<tr>
							<th scope='col'>이름</th>
							<th scope='col'>소속회사</th>
							<th scope='col'>부서명</th>
							<th scope='col'>담당업무</th>
							<th scope='col'>채용형태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="8" class="no_result">
			                    <p class="nr_des" id="re_CompanyList"><strong></strong> 검색 결과가 없습니다.</p>
			                </td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//검색결과無//-->


			<!--직원 검색결과有-->
			<div class="reaserch_result" id="withResult" style="display:none;">
				<p class="reNum">
					<span class="search_name_txt">‘홍길’</span> 검색결과 : <strong class="name_cnt">0</strong>
				</p>
				<div class="conBox">
					<table class="tb_list_basic" summary="직원검색결과 (이름, 소속회사, 부서명, 담당업무, 채용형태)">
						<caption>직원검색결과</caption>
						<thead>
							<tr>
								<th scope='col'>이름</th>
								<th scope='col'>소속회사</th>
								<th scope='col'>부서명</th>
								<th scope='col'>담당업무</th>
								<th scope='col'>채용형태</th>
							</tr>
						</thead>
						<tbody id="tbody">
						</tbody>
					</table>
				</div>
			</div>

			<div class="btnZoneBox">
				<a href="javascript:fnObj.doClose();" class="p_withelin_btn">닫기</a>
			</div>
			<!--//검색결과有//-->
		</div>


		<script>
		var type = "${type}";
			var fnObj = {
				preLoad : function(){
					if(type == '1'){
						fnObj.searchEmployee();
					}else{
						fnObj.searchWork();
					}
				},
				//직원 명 조회
				searchEmployee : function() {
					$("#workNm").val("");
					var staffNm = $("#staffNm").val();
					if(staffNm == ''){
						alertM("조회할 직원명을 입력해주세요.");
						return;
					}
					var url = contextRoot + "/basic/searchStaffNmForOrg.do";
					var param = {
						userName : staffNm
					};
					var callback = function(result) {
						$("#tbody").html("");
						var obj = JSON.parse(result);
						var cnt = obj.resultVal;
						var list = obj.resultList;
						if(cnt < 1){
							$("#withoutResult .search_name_txt").html("'"+staffNm+"'");
							$("#withoutResult strong").html(cnt);
							$("#withoutResult #re_CompanyList strong").html("'"+ staffNm +"'");
							$("#withResult").hide();
							$("#withoutResult").show();
						}else{
							$("#withResult").show();
							$("#withoutResult").hide();
							$("#withResult .search_name_txt").html("'"+staffNm+"'");
							$("#withResult .name_cnt").html(cnt);
							//var html = "<tr><th scope='col'>이름</th>	<th scope='col'>소속회사</th><th scope='col'>부서명</th><th scope='col'>담당업무</th><th scope='col'>채용형태</th></tr>";
							var html ="";
							for(var i = 0 ;i < list.length ;i++){
								var item = list[i];
								html += '<tr onClick="javascript:fnObj.searchView(' + item.userId + ')"><td>';
								html += item.userNm + ' <span class="rank_txt">(' + item.rankNm + ')</span></td>';
								html += '<td>'+item.cpnNm+'</td>';
								html += '<td>'+item.deptNm+'</td>';
								html += '<td>'+item.work+'</td>';
								html += '<td>'+('${baseUserLoginInfo.orgId}' != item.orgId ? '*****' : item.empTypeNm + ' <span class="rank_txt">('+ item.userStatusNm +')</span>')+'</td>';
								html += '</tr>';
							}
							$("#tbody").append(html);
						}
					}
					commonAjax("POST", url, param, callback);

				}
				//직무명 조회
				,searchWork : function() {
					$("#staffNm").val("");
					var workNm = $("#workNm").val();
					if(workNm == ''){
						alertM("조회할 직무명을 입력해주세요.");
						return;
					}
					var url = contextRoot + "/basic/searchWorkNmForOrg.do";
					var param = {
						workStr : workNm
					};
					var callback = function(result) {
						//console.log(result);
						$("#tbody").html("");
						var obj = JSON.parse(result);
						var cnt = obj.resultVal;
						var list = obj.resultList;
						if(cnt < 1){
							$("#withoutResult .search_name_txt").html("'"+workNm+"'");
							$("#withoutResult strong").html(cnt);
							$("#withoutResult .re_CompanyList span").html("'"+ workNm +"'");
							$("#withResult").hide();
							$("#withoutResult").show();
						}else{
							$("#withResult").show();
							$("#withoutResult").hide();
							$("#withResult .search_name_txt").html("'"+workNm+"'");
							$("#withResult .name_cnt").html(cnt);
							var html = '';//"<tr><th>이름</th>	<th>소속회사</th><th>부서명</th>	<th>담당업무</th><th>채용형태</th></tr>";
							for(var i = 0 ;i < list.length ;i++){
								var item = list[i];
								html += '<tr><td>';
								html += '<a href="javascript:fnObj.searchView('+item.userId+')" class="rank_txt">'+ item.userNm + '(';
								html += item.rankNm;
								html += ')</span></a></td>';
								html += '<td>'+item.cpnNm+'</td>';
								html += '<td>'+item.deptNm+'</td>';
								html += '<td>'+item.work+'</td>';
								html += '<td>'+ item.empTypeNm + ' <span class="rank_txt">('+ item.userStatusNm +')</span></td>';
								html += '</tr>';
							}
							$("#tbody").html(html);
						}
					}
					commonAjax("POST", url, param, callback);
				}
				//enter 클릭 여부
				, checkEnter : function(e, type){
					if(e.keyCode == 13){
						if(type == 'emp'){
							fnObj.searchEmployee();
						}else{
							fnObj.searchWork();
						}
					}else
						return;
				}
				//조회
				, searchView : function(userId){
					location.href = contextRoot +'/basic/getOrgUserPop.do?userId='+userId;
				}
				//닫기
				,doClose : function(){
					window.close();
				}
			}

			$(function(){
				fnObj.preLoad();
			});
		</script>