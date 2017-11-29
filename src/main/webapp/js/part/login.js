$(function(){
	$(document).on("click","#chkId", function(){
		var Id = $('#usrId');
		if(Id.val().length==0) {
			alert("아이디를 입력하세요.");
			$('#usrId').focus();
			return;
		}else {
			if(!check_id(Id)){
				Id.focus();
				return;
			}
		}
		$.ajax({
			type:"POST",        //POST GET
			url:"../login/checkUsrId.do",     //PAGEURL
			data : ({usrId: Id.val()}),
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				if(arg=="1") alert( "\""+ Id.val() +"\"는 존재하는 아이디입니다. 다른 아이디를 입력하세요.");
				else alert("\""+ Id.val() +"\"사용할 수 있는 아이디입니다.");
				Id.attr('disabled','true');
				$('#passwd').focus();
			},
			error: function whenError(e){    //ERROR FUNCTION
				alert("code : " + e.status + "\r\nmessage : " + e.responseText);
			}
		});
	});

	String.prototype.trim = function() {
	    return this.replace(/(^\s*)|(\s*$)/gi, "");
	};

	Object.defineProperty(Object.prototype, "is_null", {
		value: function(){
			if (this === null || String(this).trim() === "") return true;
			else return false;
		}
	});


	//비밀번호변경 저장 버튼
	$('#modifyUsr_btnOk').click(function(){
		var snb = $('#snb');
		var preId = $('#id');
		var Id = $('#userId');
		var pw1 = $('#passwd');
		var pw2 = $('#passwd2');
		var name = $('#usrNm');
		var curPw = $("#cuPasswd");

		if(curPw.val() == ''){
			alertM("현재 비밀번호를 입력하세요.");
			curPw.focus();
			return;
		}

		if(pw1.val() == ''){
			alertM("비밀번호를 입력하세요.");
			pw1.focus();
			return;
		}

		if(pw1.val() == curPw.val()){
			alertM("현재 비밀번호와 같습니다.");
			pw1.focus();
			return;
		}
		if(pw1.val() != pw2.val()){
			alertM("비밀번호가 일치하지 않습니다.");
			pw2.focus();
			return;
		}

		if (pw1.val().length < 6 || pw1.val().length > 12){
             alert("비밀번호는 6~12글자 이내로 입력하세요.");
             pw1.focus();
             return;
        }

		var reg_pwd = /^.*(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		if(!reg_pwd.test(pw1.val())){
			alert("비밀번호는 영문, 숫자포함 6자~12자 이내로 입력하세요.");
            pw1.focus();
            return;
		}

		/*var reg_pwd = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		if(reg_pwd.test(pw1.val())){
			alert("비밀번호는 영문, 숫자포함 6자~12자 이내로 입력하세요.");
            pw1.focus();
            return;
		}*/


		if(confirm("적용하시겠습니까?")){
			$.ajax({
				type:"POST",        //POST GET
				url: contextRoot + "/login/updateUsrInfo.do",     //PAGEURL
				data : ({
					sNb: snb.val(),
					usrId: Id.val(),
					usrPw: pw1.val(),
					usrNm: name.val(),
					curPw : curPw.val()
					}),
				timeout : 30000,       //제한시간 지정
				cache : false,        //true, false
				success: function whenSuccess(arg){  //SUCCESS FUNCTION
					var obj = JSON.parse(arg);

					if(obj.result == "FAIL" && obj.resultVal == 0){
						alert("현재비밀번호가 일치하지 않습니다.");
					}else if(obj.result == "FAIL" && obj.resultVal == -1){
						alert("변경도중 오류가 발생하였습니다.");
					}else{
						$("#modifyUsrIng").hide();
						$("#modifyUsrEnd").show();
					}


					$('#passwd').val("");
					$('#passwd2').val("");
					$("#cuPasswd").val("");

					return;
				},
				error: function whenError(e){    //ERROR FUNCTION
					alert("code : " + e.status + "\r\nmessage : " + e.responseText);
					return;
				}
			});
		}
	});
});