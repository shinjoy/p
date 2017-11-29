<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<script>

//동의
function agreeUserRule(){
	
	if(!$("input:checkbox[id=serviceAgree]").is(':checked')){
		
		alert("서비스 이용약관에 동의 부탁드립니다.");
		return;
	}else if(!$("input:checkbox[id=personnelAgree]").is(':checked')){
		
		alert("개인정보 수집·이용 및 제 3자 제공에 동의 부탁드립니다.");
		return;
	}else{
		
		var url = contextRoot + "/mypersonnel/updateRuleAjax.do";
    	
    	var param = {
    			
    			userRuleInfoYn 		: "Y",
    			userProcessInfoYn 	: "Y"
    	}
    	var callback = function(result){
    		
    		var obj = JSON.parse(result);
    		
    		if(obj.resultVal =="1"){
    			//모달 닫고
    			parent.myAgreeModal.close();
    			parent.location.href = contextRoot;
    		}else{
    			alert("ERROR.");
    		}


    	};
    	
    	commonAjax('POST', url, param, callback);
		
	}
	
}

function noAgreeUserRule(){
	if(confirm("미동의시 서비스 이용에 제한이 있습니다. 취소하시겠습니까?")){
		
		//모달 닫고
		parent.myAgreeModal.close();
		//메뉴정보 삭제
		window.localStorage['menuTop'] = "";
		parent.location.href = contextRoot+"/logout.do";
		
	}else return;
}


</script>
	<!--업무일지등록-->
	<div class="modalWrap2">
	
		<div class="mo_container">
			<div class="sys_p_noti dotline_top2"><span class="icon_noti"></span><span>서비스 이용을 원하실 경우, 아래의</span> <span class="pointB">"이용약관, 개인정보 수집ㆍ이용 및 제3자 제공안내"</span><span>에 대한 내용을 읽고 동의해주세요.</span></div>
			<h3 class="h3_title_basic">이용약관</h3>
			<div class="rule_scrollBox">
				<!--약관내용-->
				<%@ include file ="includeRule/s_20170925.html" %>
				<!--//약관내용//-->
			</div>
			<div class="rule_checkBox"><label><input type="checkbox" name="agreeCheck" id="serviceAgree"/><span>서비스 이용약관에 동의합니다.</span></label></div>	
			<h3 class="h3_title_basic mgt20">개인정보 수집ㆍ이용 및 제3자 제공 동의 안내</h3>
			<div class="rule_scrollBox pd01">
				<!--개인정보 처리방침-->
				<div class="ruleWrap">
					<p class="rp_txt">PASS서비스 이용을 위해 아래와 같이 개인정보를 수집∙이용 및 제3자에게 제공하고자 합니다. 내용을 자세히 읽으신 후 동의 여부를 결정하여 주십시오</p>
					<h3 class="r_title" id="rule06_01">□ 개인정보 수집ㆍ이용 내역</h3>
					<table class="rule_tb_st mgt5 mgb10">
						<thead>
							<tr>
								<th scope="col">항목</th>
								<th scope="col">수집목적</th>
								<th scope="col">보유기간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>성명, 성별, 주소, 연락처, 이메일, 학력 및 경력사항, 가족관계, 여권번호, 자격증 정보</td>
								<td>PASS 서비스를 통한 직원 인사관리</td>
								<td>PASS 사용기간 및 재직기간 단, 퇴직후엔 퇴사자 관리를 목적으로 보유</td>
							</tr>
						</tbody>
					</table>
					<p>* 위의 개인정보 수집∙이용에 대한 동의를 거부할 권리가 있습니다. 그러나 동의를 거부할 경우 원활한 서비스 제공에 제한을 받을 수 있습니다.</p>
					<h3 class="r_title" id="rule06_01">□ 개인정보 제3자 제공 내역</h3>
					<table class="rule_tb_st mgt5 mgb10">
						<thead>
							<tr>
								<th scope="col">제공기관</th>
								<th scope="col">수집목적</th>
								<th scope="col">항목</th>
								<th scope="col">보유기간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>리눅스웨어</td>
								<td>메일서비스 제공</td>
								<td>성명, 연락처, 이메일, 아이디</td>
								<td rowspan="3">PASS 사용기간 및 재직기간, 퇴사 후 퇴사자 관리기간</td>
							</tr>
							<tr>
								<td>호스트웨이</td>
								<td>서비스 제공을 위한서버호스팅</td>
								<td>서비스 입력 정보전체</td>
							</tr>
							<tr>
								<td>㈜신안정보통신</td>
								<td>SMS 서비스 제공</td>
								<td>연락처</td>
							</tr>
						</tbody>
					</table>
					<P>* 위의 개인정보 제3자 제공 내역에 대한 동의를 거부할 권리가 있습니다. 그러나 동의를 거부할 경우 원활한 서비스 제공에 제한을 받을 수 있습니다.</P>

				</div>
				
				<!--//개인정보 처리방침//-->
			</div>
			<div class="rule_checkBox"><label><input type="checkbox" name="agreeCheck" id="personnelAgree"/><span>개인정보 수집·이용 및 제3자 제공에 동의합니다.</span></label></div>
			<div class="btnZoneBox"><a href="javascript:agreeUserRule();" class="p_blueblack_btn">동의</a><a href="javascript:noAgreeUserRule();" class="p_withelin_btn">취소</a></div>
		</div>
		
	</div>
	<!--//회사상세보기(회사정보)//-->	
