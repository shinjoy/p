$(document).ready(function(){
	$("#files-upload2").change(function () {
		traverseFiles2(this.files);
	});
});

var g_upIdx = 0;		//전역변수

function traverseFiles2(files) {
	var fileList = $("#file_list2_" + g_upIdx);
	var li, file, input = "", fileInfo = "";
	fileList.html("");
	//var arrName = document.getElementsByName("files-upload2");
	var arrName = $('#files-upload2').get(0);
	
	for (var i = 0, il = files.length; i < il; i++) {
	    file = files[i];
	    fileInfo += "<li style=\"list-style-type: none;\"><img src=\"http://"+location.host+"/"+location.pathname.split('/')[1]+"/images/file/fileDiskSlct.png\" align=\"absmiddle\"/> " + file.name;
	    fileInfo += "<span style='color:#999;font-size:9px;font-weight:bold;'> (" + fileSize(file.size) + ")</span></li>";
	    //li.innerHTML = fileInfo;
	    // $("#file_list").appendChild(li);
	  	// input += "<input type='file' style='display:none;' name='upload"+i+"' filename='"+file.name+"'/>";
	};
    fileList.html(fileInfo);
	$("#uploadsubmitbtn").css('display','');
    // $("#m_files").html(input);
}

/*function fileSize(initSize){
	var rtSize = initSize/1024;
	if(rtSize > 128){
		rtSize /= 1024;
		rtSize = rtSize.toFixed(2) + "MB";
	}else rtSize = rtSize.toFixed(2) + "KB";
	
	return rtSize;
}*/

//의견 수정
function saveComment2(cnt,offerSnb){
	var DATA;
	var tmpN1 = 'ajax'
		,SNB = $('#OPsNb'+cnt).val()
		,cateCd = $("#m_categoryCd").val()
		,usrid = $("#selectST").val();
		
	
	$("#m_offerSnb2").val(offerSnb);
	$("#m_comment2").val($('#toast_comment_text' + cnt).val());
	$("#m_opinion2").val($('#toast_recom_cpn' + cnt).val());
	
	$("#m_sNb").val(SNB);
		
		
	if(confirm("적용하시겠습니까?123")){
		
		$("#multiFile_N_comment2").submit();
		
	}
}

/*function comment_open(th){
	var commentDiv = $(".new_cmt")
		,thisText = $(th).children();
	var dsp = commentDiv.css('display');
	if(dsp == "none") {
		commentDiv.css('display','block');
		thisText.html('▲');
	}else{
		commentDiv.css('display','none');
		thisText.html('▼');
	}
}*/