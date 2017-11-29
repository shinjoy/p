<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>PASS</title>
<script src='<c:url value="/daumeditor/js/popup.js"/>' type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href='<c:url value="/daumeditor/css/popup.css"/>' type="text/css"  charset="utf-8"/>
<script type="text/JavaScript">
var port = "${pageContext.request.serverPort}" ==""?"":":${pageContext.request.serverPort}";
//<![CDATA[
var contextRoot="${pageContext.request.scheme}://${pageContext.request.serverName}"+port+"${pageContext.request.contextPath}";
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>				<!-- design css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">								<!-- jquery-ui -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/common.js?ver=0.78"></script><!-- jquery , ajaxRequest, etc -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/sys/utils.js?ver=0.4"></script><!-- util folder -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/html5.js"></script>
<!-- -------------- 파일 업로드 :S  ----------------- -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<!-- -------------- 파일 업로드 :E  ----------------- -->
<script type="text/javascript">
function uploadImg(){
	var re = /^.+\.((jpg)|(jpeg)|(gif)|(png)|(bmp))$/i;
    if (!re.test($("#fileupload").val())) {
        alert("이미지 파일만 첨부 가능합니다.");  //이미지 파일만 첨부 가능합니다.
        return;
    }
    var url = contextRoot+"/file/uploadFilesForEdior.do"


	var callback = function(result){
    	var rs_imageurl = contextRoot + "/file/downFile.do?uploadType=EDITOR&downFileList="+result.resultObject.seq;
        var rs_filename = result.resultObject.fileOrgnNm;
        var rs_filesize = result.resultObject.volume;//file.volume
        rs_filesize = 0;
        rs_filesize = parseInt(rs_filesize);
        //alert("jsonData.fileSize : " + jsonData.fileSize + "\n" + "rs_filesize : " + rs_filesize);

        var _mockdata = {
                "imageurl" : rs_imageurl,
                "filename" : rs_filename,
                "filesize" : rs_filesize,
                "imagealign" : "C",
                "originalurl" : rs_imageurl,
                "thumburl" : rs_imageurl
            };
        execAttach(_mockdata);
        closeWindow();
	}


	commonAjaxForFileCreateForm(url,"","file","","", callback , "");

}


	function done() {
		$("#fForm").attr("target","ifm_frm_submit");
		$("#fForm").submit(function(){
			$("#ifm_frm_submit").load(function(){
				var timer2 = setInterval(function(){
					var returnText = "";
					returnText = $("#ifm_frm_submit").contents().text();
					if(returnText != ""){
						clearInterval(timer2);
						editorSet(returnText);
					}
				}, 500);
			});
		}).submit();
	}


	function getRealPath(input){

        var re = /^.+\.((jpg)|(jpeg)|(gif)|(png)|(bmp))$/i;
        if (!re.test($("#fileupload").val())) {
        	alert("이미지 파일만 첨부 가능합니다.");  //이미지 파일만 첨부 가능합니다.
            return;
        }
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
    			var imgHtml = "<img src='" + e.target.result + "' border='0' width='200' height='150' />";
    			$(".preview").remove();
    			$("#ids_form").append("<dd class='preview'>" + imgHtml + "</dd>");
            }
            reader.readAsDataURL(input.files[0]);
        }
	}

	function initUploader(){
        var _opener = PopupUtil.getOpener();
        if (!_opener) {
            alert("잘못된 경로로 접근하셨습니다.");  //잘못된 경로로 접근하셨습니다.
            return;
        }
        var _attacher = getAttacher('image', _opener);
        registerAction(_attacher);
    }
// ]]>
</script>
</head>
<body onload="initUploader();">
<div class="modalWrap2">
	<h1><strong>사진 첨부</strong></h1>
	<div class="wrapper">
		<div class="body">
			<form name="fForm" id="fForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id = "fileTypeCd" name = "fileTypeCd" value="EDT">
			<dl class="alert" id="ids_form">
			    <dt>사진 첨부 확인</dt>
			    <dd><input id="fileupload" type="file" name="file" onchange="getRealPath(this);" /><input type="hidden" id="real_path" name="real_path" value="" /></dd>
			    <dd class='preview'>
			    	<img src='<c:url value="/daumeditor/images/icon/editor/pn_preview.gif"/>' border='0' width='200' height='150' />
			    </dd>
			</dl>
			</form>
		</div>

		<div class="footer">
			<ul>
				<!-- <li class="submit"><a href="javascript:;" id="btnRegist" title="등록" class="btnlink" onclick="uploadImg()">등록</a> </li>
				<li class="cancel"><a href="#" onclick="closeWindow();" title="취소" class="btnlink">취소</a></li> -->
			</ul>
			<!--//일정등록화면//-->
                <span id="AddEnd" class="btn_auth"><a href="javascript:uploadImg();" class="p_blueblack_btn"><strong>등록</strong></a></span>
                <!-- <span id="EditEnd" class="btn_auth" style="display:none;"><a href="javascript:ScheduleProcEnd();" class="p_blueblack_btn" >수정</a></span> -->
                <a href="javascript:closeWindow();" class="p_withelin_btn" >취소</a>
		</div>
		<div style="display:none;width:200px;height:100px;">
		<iframe name="ifm_frm_submit" id="ifm_frm_submit" src="" style="width:100%;height:100%;"></iframe>
		</div>
	</div>
</div>

</body>
</html>