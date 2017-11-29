String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/gi, "");
};

Object.defineProperty(Object.prototype, "is_null", {
	value: function(){
		if (this === null || String(this).trim() === "") return true;
		else return false;
	}
});

	function selfSubmit(th){
		$("input").css('background-color','');
		var obj = $(th).parent().parent().parent();
		var tmdt = $("#tmDt");
		
		var title = obj.find("[id^=title]");
		var issue = obj.find("[id^=issue]");
		var proof = obj.find("[id^=proof]");

		if(tmdt.val().is_null()){
			alert("일자를 선택하세요.");
			return 0;
		}

		if(title.val().is_null()){
			title.focus();
			title.css('background-color','#A9F5BC');
			alert("자격/면허/교육/도서명을 입력하세요.");return 0;
		}
		if(issue.val().is_null()){
			issue.focus();
			issue.css('background-color','#A9F5BC');
			alert("기관명을 선택하세요.");return 0;
		}
		if(proof.val().is_null()){
			proof.focus();
			proof.css('background-color','#A9F5BC');
			alert("증빙자료 내용을 입력하세요.");return 0;
		}
		//$(th).hide();
		var frm = document.getElementById('insertSelf');//sender form id
		frm.action = "insertSelf.do";//target frame name
		frm.submit();
	}
	
	function deleteFileInfo(snb){
		if(confirm("삭제하시겠습니까?")){
			var DATA = ({sNb:snb});
			var url = "../control/deleteFileInfo.do";
			var fn = function(){
				location.href ="<c:url value='index.do' />";
			};
			ajaxModule(DATA,url,fn);
		}
	}
	function delSelf(th, cnt){
		var snb = $("#snb"+cnt).val();
		var pUrl = "../selfImprovement/deleteSelf.do";

		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				type:"POST",        //POST GET
				url:pUrl,     //PAGEURL
				data : ({sNb: snb}),
				timeout : 30000,       //제한시간 지정
				cache : false,        //true, false
				success: function whenSuccess(arg){  //SUCCESS FUNCTION
					$("#insertSelf").submit();
				},
				error: function whenError(e){    //ERROR FUNCTION
					alert("code : " + e.status + "\r\nmessage : " + e.responseText);
				}
			});
		}
	}

	function divShow(obj){
		var objId = obj.attr('id');
		object = objId;
		divPosition(objId,divId);
		$("#"+divId).css('display','block');
		$("#"+divId).show();

	}
	

	function divPosition(target,id){
		var browserWidth = document.documentElement.clientWidth;
		var tInput  = $("#" + target).offset();
//		var tHeight = $("#" + target).outerHeight();
//		var tWidth 	= $("#" + target).outerWidth();
		var calWidth 	= $("#" + id).outerWidth();

		if( tInput != null){
			$("#" + id).css({"top":tInput.top+15 , "left":(tInput.left+calWidth<browserWidth?tInput.left:browserWidth-(calWidth+8))});

		}
	}
	
	function bsnsPsave(tempNum){
//		var obj = $(this);
		var num = tempNum.split('_');
		var pUrl = "../selfImprovement/insertNote.do";
		$.ajax({
			type:"POST",        //POST GET
			url:pUrl,     //PAGEURL
			data : ({sNb: $('#bsnsPsnb'+num[1]).val(),
					note: $('#memoarea'+num[1]).val()
					}),
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				$("#bsnsPmemo_"+num[1]).hide();
				refresh();
			},
			error: function whenError(e){    //ERROR FUNCTION
				alert("code : " + e.status + "\r\nmessage : " + e.responseText);
			}
		});
	}

function popUp(num,flag,nm,snb){
// popUp 규격
	var w = '740';
	var h = '740';
	var ah = screen.availHeight - 30;
	var aw = screen.availWidth - 10;
	var xc = (aw - w) / 2;
	var yc = (ah - h) / 2;
	var option = "left=" + xc
				+",top=" + yc
				+",width=" + w
				+",height=" + h
				+",menubar=no"
				+",status=no"
				+",toolbar=no"
				+",location=no"
				+",scrollbars=yes"
				+",resizable=no"
				;
// popUp 규격

	var sUrl = '';

	if(flag=='files') {
		day = $('#choiceYear').val()+ $('#choiceMonth').val();
		sUrl = "../work/multiUpload.do";
		sUrl+='?f='+flag+'&day='+day+'&subSnb='+$("#snb"+num).val()+'&report=1';
	}
	window.open(sUrl, "_blank", option);
}

function returnPopUp(rVal){
	if(rVal==null) return;
	else if(rVal.f=='files'){
		var name = null, img = null;
		var leng = rVal.status;
		
		if(rVal.path != null & rVal.name1 != null){
			for(var k=1;k<parseInt(leng)+1;k++){//최대 업로드 파일 5개
				var nm = null,dot = null;
				if(k==1) nm = rVal.name1;
				else if(k==2) nm = rVal.name2;
				else if(k==3) nm = rVal.name3;
				else if(k==4) nm = rVal.name4;
				else if(k==5) nm = rVal.name5;

				if(nm != null) name = nm;
				dot = name.split('.');
				var extention = dot.length-1;
				if(dot[extention] == 'doc'||dot[extention] == 'docx')	img = 'doc';
				else if(dot[extention] == 'xls'||dot[extention] == 'xlsx') img = 'xls';
				else if(dot[extention] == 'ppt'||dot[extention] == 'pptx') img = 'ppt';
				else if(dot[extention] == 'pdf') img = 'pdf';
				else img = 'files';

				$('#file'+k+'_'+num).attr('title', name);//floating 되는 파일이름
				$('#file'+k+'_'+num).attr('src', '../images/file/'+img+'.png');//확장자에 따른 이미지
				if(rVal.path != null) $('#'+num).attr(rVal.path + name);//파일을 불러오기위한 경로

			}
		}
		refresh();
	}
	// $("input[id^=foCus"+num+"]").focus();
}	