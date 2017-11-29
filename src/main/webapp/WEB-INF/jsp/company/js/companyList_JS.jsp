<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" defer="defer">

//화면 리로딩
function openPage(){
	linkPage($("#pageIndex").val());
}

function linkPage(pageNo){
	$("#pageIndex").val(pageNo);
	//document.searchCpn.submit();
	//Ajax 요청으로 바꿈
	commonAjaxSubmit("POST",$("#searchCpn"),callback);
}
//Ajax Callback
function callback(data){
	$("#listArea").empty();
	$("#listArea").append(data);

    //검색어 하이라이트
    if($("#searchText").val() != "" && $("#searchType").val() != "customer"){
        $('.txt_b_title').highlight($("#searchText").val());
    }
}
//회사 상세 팝업 open....
function slctCpn(cpnId){
	$("#detailFrm #cpnId").val(cpnId);

	var option = "width=968px,height=550px,resizable=yes,scrollbars = yes";
	window.open(contextRoot+"/company/main.do?cpnId="+cpnId,"companyPop",option);
}
//csv업로드팝업
function openCsvPop(type){
	var option = 'resizable=no,width=968px,height=300,scrollbars=yes,resizable=yes,';
	var url = "";
	if(type == "company") url = "/company/uploadCompanyByCsv.do";
	else if(type == "companyInfo") url = "/company/uploadCompanyInfoByCsv.do";
	else if(type == "stock") url = "/company/uploadStockInfoByCsv.do";

	window.open(contextRoot+url,"csvPop",option);
	//commonPopupOpen("csvPop",contextRoot+"/company/uploadCompanyByCsv.do",option,$("#detailFrm"));
}
//회사신규등록 팝업
function openProcessCpnPop(){
	//$("#detailFrm input").val("");
	var option = "width=968px,height=550px,resizable=yes,scrollbars = yes";
	window.open(contextRoot+"/company/rgstCpn.do","companyProcessPop",option);
	//commonPopupOpen("companyProcessPop",contextRoot+"/company/rgstCpn.do",option,$("#detailFrm"));
}

//인물팝업 오픈
function openPersonPop(sNb){
	 var url = "<c:url value='/person/main.do'/>?sNb=" + sNb+"&tabType=NETWORK";
	 var popup = window.open(url, 'cstView', 'resizable=no,width=968,height=720,scrollbars=yes');
}
/*************************************************************
 *
 *oldFnc
 *
 */

/* 하이라이트 설정 */
jQuery.fn.highlight = function(pat) {
 function innerHighlight(node, pat) {
  var skip = 0;
  if (node.nodeType == 3) {
   var pos = node.data.toUpperCase().indexOf(pat);
   pos -= (node.data.substr(0, pos).toUpperCase().length - node.data.substr(0, pos).length);
   if (pos >= 0) {
    var spannode = document.createElement('strong');
    spannode.className = 'mark_tag';
    var middlebit = node.splitText(pos);
    var endbit = middlebit.splitText(pat.length);
    var middleclone = middlebit.cloneNode(true);
    spannode.appendChild(middleclone);
    middlebit.parentNode.replaceChild(spannode, middlebit);
    skip = 1;
   }
  }
  else if (node.nodeType == 1 && node.childNodes && !/(script|style)/i.test(node.tagName)) {
   for (var i = 0; i < node.childNodes.length; ++i) {
    i += innerHighlight(node.childNodes[i], pat);
   }
  }
  return skip;
 }
 return this.length && pat && pat.length ? this.each(function() {
  innerHighlight(this, pat.toUpperCase());
 }) : this;
};

/* 하이라이트 해제 */
jQuery.fn.removeHighlight = function() {
 return this.find("strong.mark_tag").each(function() {
  this.parentNode.firstChild.nodeName;
  with (this.parentNode) {
   replaceChild(this.firstChild, this);
   normalize();
  }
 }).end();
};
/*********** Content Function : S ***************/

</script>
