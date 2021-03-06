<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
		var bsAppvBookmarkForm = "BASIC";

		var favAppvDocId = "";
		var favAppvCompanyId = "";
		if($("#appvDocId").length>0){
			bsAppvBookmarkForm = "APPROVE";
			favAppvDocId=$("#appvDocId").val();
		}else if($("#appvDocClass").val()=="COMPANY"){
			bsAppvBookmarkForm = "COMPANY";

			if($("#appvCompanyFormId").length>0){
				favAppvCompanyId=$("#appvCompanyFormId").val();
			}

		}
		if($(".icon_favor").length>0){

			var url = contextRoot +"/approve/getAppvFavListAjax.do";

			var param = {bsAppvBookmarkForm:bsAppvBookmarkForm,favAppvDocId:favAppvDocId,favAppvCompanyId:favAppvCompanyId};
			var callback = function(result){
				var data = JSON.parse(result);
				var appvFavList = data.resultObject.appvFavList;

				for(var i = 0 ; i < appvFavList.length;i++){
					var bookmarkType = appvFavList[i].bookmarkType;

					var appvDocClass =  appvFavList[i].appvDocClass;
					if(bookmarkType == "BASIC"){
						$("#btn_Fav_"+appvDocClass).addClass("on");
					}else if(bookmarkType == "COMPANY"){
						var appvCompanyId = appvFavList[i].appvCompanyId;
						$("#btn_Fav_"+bookmarkType+"_"+appvCompanyId).addClass("on");
					}else if(bookmarkType == "APPROVE"){
						var appvDocId = appvFavList[i].appvDocId;
						$("#btn_Fav_"+bookmarkType+"_"+appvDocId).addClass("on");
					}


				}
			}
			commonAjax("POST", url, param, callback,true);
		}
		$(".doc_subcon table").each(function(i){
			$(this).css("width","");
			$(this).css("max-width","100%");
			$(this).attr("width","");
		});
	});

	//즐겨찾기 추가/삭제
	function processAppvFavDoc($obj){
		var proc = "inert";

		if($obj.hasClass("on")) proc = "delete";

		var favId = $obj.attr("id");
		var favIdBuf = favId.split("_");

		var favStr = favIdBuf[2];

		if(favStr == "COMPANY"||favStr == "APPROVE") favStr = favStr+="|"+ favIdBuf[3];

		var url = contextRoot +"/approve/processAppvFavListAjax.do";

		var param = {favStr:favStr,proc:proc};
		var callback = function(data){
			$obj.toggleClass("on");
		}
		commonAjax("POST", url, param, callback,true);
	}
</script>
