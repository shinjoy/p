<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	$(document).ready(function(){
		var fileCnt = 0;
		var fileSize = 0;
		var stStr = "";

		var url = contextRoot + "/file/getFileList.do";

		var fileUploadId = "${fileUploadId}";
		if(fileUploadId.indexOf(",")>-1){
			var fileUploadIdBuf = fileUploadId.split(",");
			for(var i = 0 ; i <fileUploadIdBuf.length ; i++){
				var param = {
						uploadId 	: fileUploadIdBuf[i],
						uploadType  : "${uploadType}"
					}
				var callback = function(result){
					var obj = JSON.parse(result);
					var list = obj.resultList;
					fileList = list;
					var fileHtml = '';
					if(list.length>0){
			    		for(var i=0;i<list.length;i++){

							fileHtml += "<li><a href='javascript:downLoadFile(\"DOWN\",\""+list[i].fileSeq+"\")'>"+list[i].orgFileNm+"</a>";
							fileHtml += "<input type='hidden' name ='fileSeq' value='"+list[i].fileSeq+"'></li>";

							var fileOriginSize = list[i].fileSize/1024;
							fileSize += fileOriginSize.toFixed(2)
							fileCnt++;


						}
					}else{
						//$('#fileList').html('<li>첨부된 파일이 없습니다.</li>');
						//$("#fileBtn").hide();

						//$('#fileArea').hide();		//첨부파일 영역 아예 안보이도록
					}

					$('#fileArea').append(fileHtml);
					var fileStr = fileCnt+"개"+"<em>"+fileSize+"KB</em>"
					$("#fileInfo").text(fileStr);

					if(fileCnt<2) $("#btnAllDown").hide();

				}
				commonAjax("POST", url, param, callback, false);
			}

		}else{
			var param = {
					uploadId 	: fileUploadId,
					uploadType  : "${uploadType}"
				}
			var callback = function(result){
				var obj = JSON.parse(result);
				var list = obj.resultList;
				fileList = list;
				var fileHtml = '';
				if(list.length>0){
		    		for(var i=0;i<list.length;i++){

						fileHtml += "<li><a href='javascript:downLoadFile(\"DOWN\",\""+list[i].fileSeq+"\")'>"+list[i].orgFileNm+"</a>";
						fileHtml += "<input type='hidden' name ='fileSeq' value='"+list[i].fileSeq+"'></li>"
						fileSize += list[i].fileSize/1024;
						fileCnt++;
						$('#fileArea').html(fileHtml);
					}
				}else{
					//$('#fileList').html('<li>첨부된 파일이 없습니다.</li>');
					//$("#fileBtn").hide();

					$('#fileArea').hide();		//첨부파일 영역 아예 안보이도록
				}
				fileSize = fileSize.toFixed(2);
				var fileStr = fileCnt+"개"+"<em>"+fileSize+"KB</em>"
				$("#fileInfo").html(fileStr);

				if(fileCnt<2) $("#btnAllDown").hide();

			}
			commonAjax("POST", url, param, callback, false);
		}

	});
	//파일 다운로드
	function downLoadFile(type,fileSeq){
		var url = "";
		var uploadType = "${uploadType}";
		var downloadFileStr = "";
		if(type == 'ALL'){
			$("input[name='fileSeq']").each(function(i){
				if(i>0) downloadFileStr+=","+$(this).val();
				else downloadFileStr+=$(this).val();
			});
			url = contextRoot + "/file/downFilesTozip.do?uploadType="+uploadType+"&downFileList="+downloadFileStr;
		}else {
			downloadFileStr+=fileSeq;
			url = contextRoot + "/file/downFile.do?uploadType="+uploadType+"&downFileList="+downloadFileStr;
		}
		$("#downForm").attr("action",url);
		$("#downForm").attr("method","POST");

		$("#downForm").submit();
	}

</script>
<form name="downForm" id="downForm" method="post">
	<input type="hidden" name = "downForm">
</form>

<!--파일리스트 모달팝업-->
<div id="compnay_dinfo">
	<div class="modalWrap2">
		<div class="mo_container2">
			<div class="add_fileList_sBox">
				<div class="fileAddList_b">
					<div class="title"><strong>첨부파일</strong><span class="count" id = "fileInfo"></span><a href="javascript:downLoadFile('ALL')" id="btnAllDown" class="s_white01_btn" id="filedownloadAll" style="">모두저장</a></div>
					<ul id="fileArea">
					</ul>
				</div>
			</div>
		</div>
		<!-- 게시판 버튼 -->

       <div class="btn_baordZone2" id = "popBtnArea" >
       <a href="#" onclick="parent.myModal2.close();" class="btn_witheline">닫기</a>
       </div>
       <!--/ 게시판 버튼 /-->
	</div>
</div>
