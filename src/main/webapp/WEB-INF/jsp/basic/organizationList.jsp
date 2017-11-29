<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<div class="contents organization">

    <div class="deatailconWrap">
		<section id="detail_contents" style="border-left:0px;">
			 <div class="orglayout">
				<!--STEP01.회사선택-->
				<div class="orgcomWrap">
					<h3 class="org_title_com"><strong>회사선택</strong><span class="org_subtxt">회사를 선택해주세요</span>

					<c:if test="${baseUserLoginInfo.orgRegAuth eq 'Y'}">			<!-- 마스터 권한에만 회사 선택 란이 보인다 -->
						<a href="javascript:fnObj.doEditOrgChart();" id="editMode" class="btn_s_type_g mgl10">수정</a>
						<a href="javascript:fnObj.doViewOrgChart();" id="viewMode" class="btn_s_type_g mgl10" style="display:none;">보기</a>
					</c:if>

					</h3>
					<div id="orgChartContainer">
   						<div id="orgChart" class="orgTree"></div>
 					</div>
		    		<div id="consoleOutput" >
		    		</div>
		 		</div>
				<!--//STEP01.회사선택//-->
				<!--STEP02.부서 및 구성원선택-->
				<div class="orgdepartWrap">
					<h3 class="org_title_com"><strong>부서 및 조직구성원 선택</strong><span class="org_subtxt">회사를 선택하시면 부서 및 소속직원을 확인하실 수 있습니다.</span></h3>
					<div class="orgdepartzone_empty" id="dept1">부서를 선택하세요.</div>
                 	<div class="orgdepartzone" style="display:none;" id="dept2">
						<div class="orgdepart_tree">
							<div id="userListAreaTree">
								<div class="tnavi_title"><span id="selectComp3"></span></div>
								<ul class="tnavi_treezone" id="AXJSTree">
									<li></li>
								</ul>
							</div>
						</div>
						<div class="orgdepart_tb" id="dept4" style="display:none;">
							<h3 class="h3_title_basic"><span id="selectDept"></span></h3>
							<p class="noti_rightzone"><span class="org_icon_leader"><em>(부서장)</em></span><span>부서장</span></p>
							<table class="datagrid_input" summary="리스트(이름, 담당업무, 인사)">
								<caption>프로젝트목록</caption>
									<colgroup>
										<col width="*">
										<col width="*%">
										<col width="20%">
									</colgroup>
									<thead>
									<tr>
										<th scope="col">이름</th>
										<th scope="col">소속회사</th>
										<th scope="col">업무</th>
										<th scope="col">인사정보</th>
									</tr>
								</thead>
								<tbody id="tbody"></tbody>
							</table>
						</div>
					</div>
				<!--//STEP02.부서 및 구성원선택//-->
			</div>
		</section>
	</div>
</div>

<script type="text/javascript">

var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-36251023-1']);
_gaq.push(['_setDomainName', 'jqueryscript.net']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

var myGrid = new AXGrid(); 		// instance
var companyObj =[];

var fnObj = {

	preloadCode : function(){

	},

	//보기 모드
	doViewOrgChart : function(){

		$("#editMode").show();
 		$("#viewMode").hide();

		companyObj = [];
		var url = contextRoot + "/basic/getCompanyStructList.do";
		var param = {};

		var callback = function(result) {
			var obj = JSON.parse(result);

			var list =obj.resultList;

			//데이터 세팅
			for(var i = 0; i < list.length; i++){
				companyObj.push({id: list[i].companyId, name: list[i].viewCompanyNm, parent: list[i].parentCompanyId, orgId: list[i].companyOrgId, enable: list[i].enable}) ;

    		}

			org_chart = $('#orgChart').orgChart({
	            data: companyObj,				//데이터 세팅
	            showControls: null,				//추가 삭제 버튼 생성 옵션
	            allowEdit:null,					//노드의  text 수정 옵션
	            onClickNode: function(node){	//클릭 이벤트
	            	fnObj.selectCompany(node.data.name,node.data.id,node.data.parent,node.data.enable);		//노드 이름, 아이디(companyId), 부모 아이디, 사용가능여부
	            }

	        });

		};
		commonAjax("POST", url, param, callback);

 	},

 	//수정모드
 	doEditOrgChart : function(){

 		$("#editMode").hide();
 		$("#viewMode").show();

 		companyObj = [];
		var url = contextRoot + "/basic/getCompanyStructList.do";
		var param = {};

		var callback = function(result) {
			var obj = JSON.parse(result);

			var list =obj.resultList;

			for(var i = 0; i < list.length; i++){
				companyObj.push({id: list[i].companyId, name: list[i].viewCompanyNm, parent: list[i].parentCompanyId, orgId: list[i].companyOrgId, enable: list[i].enable }) ;

    		}

			org_chart = $('#orgChart').orgChart({
	            data: companyObj,
	            showControls: true,			//컨트롤 여부 (+와 - 버튼 생성)
	            allowEdit:true,				//노드의  text 수정 옵션
	            newNodeText: '',			//+와 - 버튼 사이 글씨

	            onAddNode: function(node){  //추가 버튼 눌렀을때 이벤트

	                org_chart.newNode(node.data.id);
	            },
	            onDeleteNode: function(node){//삭제버튼 눌렀을때 이벤트

	                org_chart.deleteNode(node.data.id);
	            },
	         });
		}
		commonAjax("POST", url, param, callback);
 	},

 	//회사 선택해서 옆에 부서 리스트 세팅
 	selectCompany : function(cpnNm,companySnb,parentId,enable){

 		//-- 최상위 노드(시너지)거나 유효하지 않은 관계사면 이벤트 no  처리
 		if(parentId == 0){
 			return false;
 		}

 		//유효하지 않은 관계사 이벤트 처리
 		if(enable == 'N'){
 			$("#dept1").show();
			$("#dept2").hide();
			$("#dept3").hide();
			$("#dept4").show();
 			$("#dept1").html("조회 불가능한 관계사 입니다.");

 		}else{

	 		$('#selectComp1').html(cpnNm);
	 		$('#selectComp2').html(cpnNm);
	 		$("#selectComp3").html(cpnNm);
	 		$("#dept1").hide();
			$("#dept2").show();
			$("#dept3").show();
			$("#dept4").hide();


			$(".org_group2").find(".org_title_area_off").attr("class", "org_title_area_on");
			$(".org_group2").find(".org_title_off").attr("class", "org_title_on");
			$(".org_group2").find(".org_subtxt_off").attr("class", "org_subtxt_on");
			$(".org_group2_wrap").attr("style","height:500px;");

	 		var url = contextRoot + "/basic/getDeptListForOrg.do";
			var param = {
				companySnb : companySnb
			}

			var callback = function(result) {
				var obj = JSON.parse(result);
				var cnt = obj.resultVal; //결과수
				for(var n = 0; n < obj.resultVal; n++){
	    			if( obj.resultList[n].parent == 0 )
	    				obj.resultList[n].parent = "#";
	    		}

	    		fnObj.viewTree(JSON.stringify(obj.resultList));

			};
			commonAjax("POST", url, param, callback);
 		}

 	},

 	viewTree : function (jsonDeptData) {

    	$('#AXJSTree').jstree('destroy');
    	$('#AXJSTree').jstree({
    					'core' : {
    							"check_callback" : true
    							,'data' : JSON.parse(jsonDeptData)
    					},
  					    "themes" : {
  					    		"variant" : "large",
  					    		"icons": "true"
  						},
  						"plugins" : [
  						              "dnd", "themes", "crrm", "json_data"		//, "wholerow"
  						]
				}).bind("loaded.jstree",function(event,data){
    			     $(this).jstree("open_all");
    		    }).bind("select_node.jstree", function (event, data) {
    		    	var selDeptId = data.node.original.deptId;
    		    	var selLevel = data.node.original.level;
    		    	var selDeptCode = data.node.original.deptCode;
    		    	$("#selectDept").html(data.node.text);
    		    	fnObj.doGetUserListOfDept(data.node.original);	//선택부서 인원정보

    		     });

 	},

 	//사원리스트 가져오기
 	doGetUserListOfDept : function(data){

		$("#dept1").hide();
		$("#dept2").show();
		$("#dept3").hide();
		$("#dept4").show();

 		var url = contextRoot + "/basic/getUserListForDept.do";
 		var param = {
 				deptCode: data.deptCode
 			   ,deptId: data.deptId
 			   ,firedType : 1		//유효사용자
 		};

 		var callback = function(result){
 			var obj = JSON.parse(result);
 			var list = obj.resultList;

 			var html  = "";
 			for(var i = 0 ;i < list.length ;i++){
 				var item = list[i];
 				html += "<tr>";
 				//html += ' <td class="txt_center">'+item.name+'<span class="employee_list">('+ item.rankNm +')</span> ';
 				html += '<td class="txt_center vm">';
 				if(item.isManager == 'Y'){
 					html += '<span class="org_icon_leader"><em>(부서장)</em></span>';
 				}
 				html += '<span>'+item.name+'</span><span class="employee_list">('+ item.rankNm +')</span> ';
 				html += '</td>';
 				html += '<td class="txt_center">'+item.companyNm+'</td>';
 				html += '<td class="txt_center">'+item.work+'</td>';
 				html += '<td class="txt_center">';
 				html += '<a href="javascript:fnObj.openPerInfo('+ item.userId+')" class="s_gray01_btn"><em class="profile">조회</em></a></td>';
 				html += '</tr>';
 			}

			if(obj.resultVal == 0){
				html += "<tr><td colspan=4 style='text-align:center;'>팀에 소속된 직원이 없습니다.</td></tr>";
 			}
 			$("#tbody").html(html);
 		}
 		commonAjax("POST", url, param, callback);

 	},

 	//조회
 	openPerInfo : function(userId){

 		window.open('../basic/getOrgUserPop.do?userId='+userId, 'newinfov','resizable=no,width=968,height=670,scrollbars=yes');
 	},

 	//신규 노드 추가 -> 회사 선택시
 	changeCompany : function(id,name){

 		 $("#inputViewName"+id).val(name);
 	},

 	//노드정보변경
 	doSaveNode : function(id,parentId){


 		if($("#companyId").val() == '' && id == '0'){
 			alert("회사를 선택해 주세요");
 			return false;
 		}

 		var url = contextRoot + "/basic/saveCompanyStruct.do";
		var param = {
			companyId 		: $("#companyId").val(),
			companyViewName : $("#inputViewName"+id).val(),
			parentCompanyId : parentId,
			companyStructId : id
		};


		var callback = function(result) {

			fnObj.doEditOrgChart();
			toast.push("저장하였습니다!");

		};
		commonAjax("POST", url, param, callback);

 	},

 	//노드삭제
 	deleteCompanyStruct : function(id){
 		//alert(id);
 		var url = contextRoot + "/basic/deleteCompanyStruct.do";
		var param = { companyId : id };

		var callback = function(result) {

			fnObj.doEditOrgChart();
			toast.push("삭제되었습니다!");

		};
		commonAjax("POST", url, param, callback);
 	}
};


$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.doViewOrgChart();


	//left menu 숨김버튼 안보이도록
	$('#btnLeftMenuShow').hide();
	$('#btnLeftMenuHide').hide();
});

</script>



