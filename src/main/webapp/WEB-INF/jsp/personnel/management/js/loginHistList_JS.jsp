<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">

	var orderList = ["EMP_NO","NAME","DEPT_NM","POSITION","LOGIN_TIME"];
	var orderEleIdx = -1;
	var orderEleClass = "";

	$(document).ready(function(){
		searchOrgId("FIRST");

		if($("#searchOrder").val()!=""){
			var searchOrder = $("#searchOrder").val();
			var serachOrderArr = searchOrder.split(" ");

			for(var i = 0 ; i < orderList.length;i++){
				if(orderList[i]==serachOrderArr[0]){
					orderEleIdx = i;
					if(serachOrderArr[1] == "DESC") orderEleClass = "sort_hightolow";
					else orderEleClass = "sort_lowtohigh";
				}
			}
			$("#sort_column_prefix"+orderEleIdx).attr("class" , orderEleClass);
		}
	});
	//컬럼 소팅
    function doSort(idx){

		var beforeClass = $("#sort_column_prefix"+idx).attr("class");
		var afterClass = "";
		if(beforeClass == "sort_normal"||beforeClass == "sort_hightolow"){
			afterClass = "sort_lowtohigh";
		}else if(beforeClass == "sort_lowtohigh"){
			afterClass = "sort_hightolow";
		}
		var sort = afterClass == "sort_hightolow"?"DESC":"ASC";
		var sortSql = orderList[idx]+" "+sort;
		$("#searchOrder").val(sortSql);

    	linkPage(1);

    	$("#sort_column_prefix"+idx).attr("class" , afterClass);
    	orderEleIdx = idx;
    	orderEleClass = afterClass;

    	for(var i = 0 ; i < orderList.length ; i++){
    		if(i!=idx) $("#sort_column_prefix"+i).attr("class" , "sort_normal");
    	}
    }
	//회사선택 selectbox onchange
	function searchOrgId(loadType){
		var orgId = $("#searchOrdId").val();
		$("#searchDeptIdBuf").html("<option value=\"\">전체</option>");
		var allChk = false;
		if(orgId != ""){
			$("#deptListAllTmpl option").each(function(){
					if($(this).val().indexOf("value_"+orgId+"_")<0){
						//$(this).hide();
					}else{
						$("#searchDeptIdBuf").append($(this).clone());
						//$(this).show();
					}
			});
		}else{
			//$(this).show();
			$("#searchDeptIdBuf").append($("#deptListAllTmpl").html());
			allChk = true;
		}

		if(allChk){
			$("#searchDeptIdBuf").val("");
		}
		$("#searchDeptIdBuf").change(function(){
			searchDeptId();
		});
		$("#searchDeptId").val("");

		if(loadType == "RELOAD"){
			linkPage('1');  //처음로딩이 아니면 조회함
		}
	}
	//부서선택 selectbox onchange
	function searchDeptId(){
		var deptIdBuf = $("#searchDeptIdBuf").val();
		if(deptIdBuf!=""){
			var deptId = deptIdBuf.split("_")[2];
			$("#searchDeptId").val(deptId);
		}else{
			$("#searchDeptId").val("");
		}

		linkPage('1');
	}
	//검색
	function linkPage(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action",contextRoot+"/personnel/getLoginHistListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),searchCallback,false);
	}

	// 검색 콜백
	function searchCallback(data){
		$("#listArea").html(data);

    	if(orderEleIdx>-1){
    		$("#sort_column_prefix"+orderEleIdx).attr("class" , orderEleClass);
    	}

	}
</script>
