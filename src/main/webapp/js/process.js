
 String.prototype.trim = function() {
	    return this.replace(/(^\s*)|(\s*$)/gi, "");
	};

	Object.defineProperty(Object.prototype, "is_null", {
		value: function(){
			if (this === null || String(this).trim() === "") return true;
			else return false;
		}
	});
$(function(){
 if(navigator.userAgent.indexOf('Firefox') >= 0){
  (function(){
   var events = ["mousedown", "mouseover", "mouseout", "mousemove",
                 "mousedrag", "click", "dblclick"];
   for (var i = 0; i < events.length; i++){
    window.addEventListener(events[i], function(e){
     window.event = e;
    }, true);
   }
  }());
 };

/************************************************ work main start *****************************************************************/
	function displayNdeal(dsp){
//		document.getElementById('info').style.display=dsp;
		$('#info').css('display',dsp);
		$('#price').css('display',dsp);
		$('#invest').css('display',dsp);
		$('#comp1').css('display',dsp);
		$('#name1').css('display',dsp);
		$('#team1').css('display',dsp);

		$('#input4').css('display',dsp);
		$('#input5').css('display',dsp);
		$('#input6').css('display',dsp);
		$('#input7').css('display',dsp);
		$('#input8').css('display',dsp);
	}
	function displayDeal(dsp){
		$('#name0').css('display',dsp);
		$('#team0').css('display',dsp);

		$('#input2').css('display',dsp);
		$('#input3').css('display',dsp);
	}
	$('#workMeet').click(function(){
		displayNdeal("none");
		displayDeal("");
	});
	$('#workIR').click(function(){
		displayNdeal("none");
		displayDeal("");
	});
	$('#workVisit').click(function(){
		displayNdeal("none");
		displayDeal("");
	});
	$('#workAnalysis').click(function(){
		displayNdeal("none");
		displayDeal("");
	});
	$('#workSurvey').click(function(){
		displayNdeal("none");
		displayDeal("");
	});
	$('#workDealS').click(function(){
		displayNdeal("");
		displayDeal("none");
	});
	$('#workDealR').click(function(){
		displayNdeal("");
		displayDeal("none");
	});

	$(document).on("change",".offerCd", function(){
		var obj = $(this);

		//dataVisible(obj);

		switch(obj.val()){
		case "00001":
		case "00002":
		case "00003":
			obj.parent().parent().find('[id^=slctPrsn_]').css('display','');
			obj.parent().parent().find('[id^=slctCpn_]').css('display','none');
			obj.parent().parent().find('[id^=CateCd_]').css('display','none');
			obj.parent().parent().find('[id^=AP_price]').css('display','none');
			obj.parent().parent().find('[id^=textTmp_]').css('display','none');
			obj.parent().parent().find('[id^=KP_title_]').css('display','');
			obj.parent().parent().find('[id^=KP_slct_]').css('display','');
			break;
		case "00004":
		case "00005":
			obj.parent().parent().find('[id^=slctCpn_]').css('display','');
			obj.parent().parent().find('[id^=slctPrsn_]').css('display','none');
			//obj.parent().find('span').css('display','none');
			obj.parent().parent().find('[id^=CateCd_]').css('display','none');
			obj.parent().parent().find('[id^=AP_price]').css('display','none');
			obj.parent().parent().find('[id^=textTmp_]').css('display','none');
			obj.parent().parent().find('[id^=KP_title_]').css('display','');
			obj.parent().parent().find('[id^=KP_slct_]').css('display','');
			break;
		case "00006":
		case "00007":
			obj.parent().parent().find('[id^=slctCpn_]').css('display','');
			obj.parent().parent().find('[id^=slctPrsn_]').css('display','');
			//obj.parent().find('span').css('display','');
			obj.parent().parent().find('[id^=CateCd_]').css('display','');
			obj.parent().parent().find('[id^=AP_price]').css('display','');
			obj.parent().parent().find('[id^=textTmp_]').css('display','');
			obj.parent().parent().find('[id^=KP_title_]').css('display','none');
			obj.parent().parent().find('[id^=KP_slct_]').css('display','none');
			break;
		}

	});

	var object = '';
	var divId = '';

	$(document).on("click",".netPnt", function(){
//		$(".title").click(function(){
		var obj = $(this);
		var t_num = obj.attr('id').split('_');//alert((parseInt(t_num)<100?("0"+t_num):t_num));
		divId = (parseInt(t_num[0])<10?("0"+t_num[0]):t_num[0])+t_num[1]+ t_num[2];
		$(".popUpMenu").hide();
		divShow($(this));//alert(divId)
		// $("#foCus_"+t_num[0]+"_"+t_num[2]).focus();
	});
	/* $(".offerCnt").live("click", function(){
//		$(".title").click(function(){
		var obj = $(this);
		var t_num = obj.attr('id').split('_');//alert((parseInt(t_num)<100?("0"+t_num):t_num));
		divId = t_num[0]+'offerPr'+ t_num[2];
		divShow($(this));//alert(divId)
	}); */

	//업무일지 닫기 클릭시
	$(document).on("click",".closePopUpMenu",function(event){
		// $(this).parent().hide();
		$(".popUpMenu").hide();
	});


	$(document).on("click",".memo_m", function(){
//		$(".title").click(function(){
		var t_num = $(this).attr('id').split('_');
		divId = 'memoPr'+ t_num[1];
		$(".popUpMenu").hide();
		divShow($(this));
		// $("#RM_"+ t_num[1]).focus();
		// document.getElementById('RM_'+ t_num[1]).focus();
	});
	$(document).on("click",".result_m", function(){
//		$(".title").click(function(){
		var t_num = $(this).attr('id').split('_');
		divId = 'resultPr'+ t_num[1];
		$(".popUpMenu").hide();
		divShow($(this));
	});

	$(document).on("click",".opinion_m", function(){
//		$(".title").click(function(){
		var t_num = $(this).attr('id').split('_');
		divId = 'opinionPr'+ t_num[1];
		$(".popUpMenu").hide();
		divShow($(this));
	});


	$(document).on("click",".pass2pe", function(){
		var t_num = $(this).attr('id').split('_');
		divId = 'test_'+t_num[1];
		divShow($(this));
	});


	// 추가 버튼 클릭시
	$(".addItemBtn").click(function(){
		// item 의 최대번호 구하기
		var obj = $(this);
		var tmp_arr = obj.attr('name').split('_');
		var idx = tmp_arr[tmp_arr.length-1];

		var id_div = '#dynamicDIV' +idx;
		var lastItemNo0 = $(id_div+" ul:last").attr("class").replace(idx+"_item_", "");
		var newitem0 = $(id_div+" ul:eq(0)").clone();
		newitem0.removeClass();
//		newitem0.find("li:eq(0)").attr("rowspan", "1");
		newitem0.addClass(idx+"_item_"+(parseInt(lastItemNo0)+1));
		newitem0.find("a:eq(0)").attr("id",idx+"_btnPass_"+(parseInt(lastItemNo0)+1));
		newitem0.find("a:eq(1)").attr("id",idx+"_memo_"+(parseInt(lastItemNo0)+1));

		var num_00 = (parseInt(idx)<10?("0"+idx):idx);
		var memoDiv = $("#"+num_00+"memoPr0");
		var newMemoDiv = $(memoDiv).clone();
		newMemoDiv.attr("id",num_00+"memoPr"+(parseInt(lastItemNo0)+1));
		newMemoDiv.find("input").attr("value","");

		$(id_div).append(newitem0);
		$(memoDiv).parent().append(newMemoDiv);

		var c_dbody = "#dbody"+idx;
		$(c_dbody).css('padding-bottom','+=20px');
//		alert($(c_dbody+" li:last").attr("class"));
		$(c_dbody+" li").css('height','+=20px');
		$(".memoLine").css('height','20px');
//		$(id_div).parent('li').parent('ul').parent('div').find('[class=dbody]').css('padding-bottom','+=26px');
	});



	//파일 다운로드
	$(document).on("click",".filePosition",function(){
		var obj = $(this).parent();
		// var frm = document.getElementById('modifyRec');//sender form id
		// frm.action = "downloadProcess.do";//target frame name
		// frm.submit();
		var obj_id = $(this).attr('id');
		var num = obj_id.split('ile');
		$("#makeName").val(obj.find('[id^=mkNames'+num[1]+']').val());
		//$("#downName").submit();
		var url = '../work/downloadProcess.do';
		window.open(url+"?recordCountPerPage=0&makeName="+$("#makeName").val(), '_self');
		// alert("업로드까지는 완료 되었습니다.\n다운로드는 빠른시일내로 완료하겠습니다.");
	});

	//핵심체크 view
	$('.viewKeyP').click(function(){
		var obj = $(this);
		var id = obj.attr('id');
		var num = id.split('_');

		$('#KP_slct_'+num[1]).css('display','');
		$('#'+id).css('display','none');
	});

	//핵심체크사항 약속자 선택
	$(document).on("click",".slctCoworker",function(){
		var obj = $(this).parent().parent().parent();
		var num = obj.attr('id').split('_');

		$("#snb").val($("#snb"+num[1]).val());
		// document.modifyRec.action="coworkerKPC.do";
		// document.modifyRec.submit();
		var frm = document.getElementById('modifyRec');//sender form id
			frm.target = "mainFrame";//target frame name
			frm.submit();
	});

	$(document).on("change",".processKPC",function(){
		var obj = $(this);
		var num = obj.attr('id').split('_');

		var frm = document.getElementById('procKPC'+num[1]);//sender form id
		frm.target = "mainFrame";//target frame name
		frm.submit();
	});



/************************************************ work main end *****************************************************************/
/************************************************ work deal start *****************************************************************/
	$(document).on("change","#feedback",function(){
		var obj = $(this).parent().parent();
		$.ajax({
			type:"POST",        //POST GET
			url:"../work/changeFeedback.do",     //PAGEURL
			//  dataType: "html",       //HTML XML SCRIPT JSON

			data : ({sNb: obj.find('[id^=offerSnb]').val(),
				feedback: $(this).val(),
				rgId: $('#rgstId').val()
				}),
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				document.modifyRec.submit();
			},
			error: function whenError(x,e){    //ERROR FUNCTION
				ajaxErrorAlert(x,e);
			}
		});
	});
	$(document).on("change","#progressCd",function(){
		var obj = $(this).parent().parent();
		var snb = obj.find('[id^=offerSnb]').val();
		if($(this).val() == '00003'){
			popUp('','supporter','',snb);
		}
		$.ajax({
			type:"POST",        //POST GET
			url:"../work/changeprogressCd.do",     //PAGEURL
			//  dataType: "html",       //HTML XML SCRIPT JSON

			data : ({
				sNb: snb,
				cstId: obj.find('[id^=cstSnb]').val(),
				progressCd: $(this).val(),
				rgId: $('#rgstId').val()
				}),
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				document.modifyRec.submit();
			},
			error: function whenError(x,e){    //ERROR FUNCTION
				ajaxErrorAlert(x,e);
			}
		});
	});

	//제안현황에 메모 내용수정 확인
	$(document).on("click",".dealMemo_btnOk", function(){
	if(confirm("적용하시겠습니까?")){
		var obj = $(this).parent().parent().parent();
		$.ajax({
			type:"POST",        //POST GET
			url:"../work/modifyDealMemo.do",     //PAGEURL
			data : ({sNb: obj.find('[id^=dealMemoSNb]').val(),
				// cstNm: obj.find
				cstId: obj.find('[id^=dealResultCstId]').val(),
				memo: obj.find('[id^=memoarea]').val(),
				rgId: $('#rgstId').val()
				}),
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				document.modifyRec.submit();
			},
			error: function whenError(x,e){    //ERROR FUNCTION
				ajaxErrorAlert(x,e);
			}
		});
	}
//	else {
//		$(this).parent().parent().hide();
//	}
});
	//중개,직접발굴에 투자의견/성과 내용수정 확인
	$(document).on("click",".dealResult_btnOk", function(){
		var obj = $(this).parent().parent().parent();
		var idStr = obj.attr('id').split('Pr');
		var DATA = null
			, rgId = $('#rgstId').val();

		if(idStr[0] == 'opinion'){
			if(!confirm("등록하시겠습니까?\n(등록과 함께, 딜 등록자에게 메모가 전달됩니다)")){ return; }
			DATA = {
				sNb: obj.find('[id^=dealOpinionSNb]').val()
				,opinion: obj.find('[id^=opinionarea]').val()
				,rgId: rgId
				,tmpNum1: 'op'
			};
		}else{
			if(!confirm("적용하시겠습니까?")){ return; }
			DATA = {
				sNb: obj.find('[id^=dealResultSNb]').val()
				,result: obj.find('[id^=resultarea]').val()
				,rgId: rgId
				,tmpNum1: 'rs'
			};
		}
		$.ajax({
			type:"POST",        //POST GET
			url:"../work/modifyDealResult.do",     //PAGEURL
			data : DATA,
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				document.modifyRec.submit();
			},
			error: function whenError(x,e){    //ERROR FUNCTION
				ajaxErrorAlert(x,e);
			}
		});
//	else {
//		$(this).parent().parent().hide();
//	}
	});

	$(document).on("click",".comment_m", function(){
		var t_num = $(this).attr('id').split('_');
		divId = 'commentPr'+ t_num[1];
		$("#TMP"+t_num[1]).val(t_num[2]);
		$(".popUpMenu").hide();
		divShow($(this));
	});

//	Mna
	$('.mna_btnOk').click(function(){
//		alert($(this).parent().parent().find('[id^=txtarea]').val());
//		alert($(this).parent().parent().attr('id'))

		if(confirm("적용하시겠습니까?")){
			var obj = $(this).parent().parent().parent();
			var num = obj.find('[id^=TMP]').val();
//			alert(num+";;;;"+$('#offerTmDt'+num).val());
			if(obj.find('[id^=commentSNb]').val()==""){//새로 입력하기
				$.ajax({
					type:"POST",        //POST GET
					url:"../work/insertCommentMna.do",     //PAGEURL
					data : ({
							offerId: $('#offerSnb'+num).val(),
							//cpnId: obj.find('[id^=AP_cpnId]').val(),
							cpnNm: obj.find('[id^=AP_cpnNm]').html(),
							//cstId: obj.find('[id^=AP_cstId]').val(),
							cstNm: obj.find('[id^=AP_cstNm]').html(),
							progressCd: obj.find('[id^=progressCd]').val(),
							categoryCd: obj.find('[id^=categoryCd]').val(),
							tmDt: $('#offerTmDt'+num).val(),
							rgId: $('#rgstId').val(),
							staffSnb: "${baseUserLoginInfo.userId}"
							}),
					timeout : 30000,       //제한시간 지정
					cache : false,        //true, false
					success: function whenSuccess(arg){  //SUCCESS FUNCTION
//						$(obj).hide();
						document.modifyRec.action = "selectWorkMnA.do";
						document.modifyRec.submit();
					},
					error: function whenError(x,e){    //ERROR FUNCTION
						ajaxErrorAlert(x,e);
					}
				});
			}else{//입력된 내용 수정하기
				$.ajax({
					type:"POST",        //POST GET
					url:"../work/updateCommentMna.do",     //PAGEURL
					//  dataType: "html",       //HTML XML SCRIPT JSON

					data : ({sNb: obj.find('[id^=commentSNb]').val(),
							cpnNm: obj.find('[id^=AP_cpnNm]').html(),
							cstNm: obj.find('[id^=AP_cstNm]').html(),
							progressCd: obj.find('[id^=progressCd]').val(),
							categoryCd: obj.find('[id^=categoryCd]').val(),
							tmDt: $('#offerTmDt'+num).val(),
							rgId: $('#rgstId').val(),
							staffSnb: "${baseUserLoginInfo.userId}"
							}),
					timeout : 30000,       //제한시간 지정
					cache : false,        //true, false
					success: function whenSuccess(arg){  //SUCCESS FUNCTION
	//					alert(<c:out value='${message}'/>);
						document.modifyRec.action = "selectWorkMnA.do";
						document.modifyRec.submit();

					},
					error: function whenError(x,e){    //ERROR FUNCTION
						ajaxErrorAlert(x,e);
					}
				});
			}
		}
//		else {
//			$(this).parent().parent().hide();
//		}
	});


	$(document).on("change","#deal_select_year", function(){
		 $("#dayForm").submit();
	});


/************************************************ work deal end *****************************************************************/

///////// work main menu /////////////////////////////////////////////////////////////////////////
/************************************************ company main start *****************************************************************/
	$('#offerListed').click(function(){
		$('#offerNlisted').attr('checked',null);
		$(this).attr('checked', 'checked');
		$('#cpn_id').focus();
		$('#cpn_id').css('display','');
		$('#cpn__id').css('display','none');
	});
	$('#offerNlisted').click(function(){
		$('#offerListed').attr('checked',null);
		$(this).attr('checked', 'checked');
		$('#cpn__id').css('display','');
		$('#cpn_id').css('display','none');
	});

	// 회사 추가하기
	$('.newCpn_btnOk').click(function(){
		var obj = $(this).parent().parent().parent().parent().parent();
		var chkRdo = obj.find('[checked=checked]').attr('id');
		// var cpnId = (chkRdo=='offerListed')?obj.find('[id^=cpn_id]').val():obj.find('[id^=cpn__id]').html();
		// var cpnNm = obj.find('[id^=cpn_nm]').val();
		// var cstId = obj.find('[id^=AP_cstId]').val();
		if(chkRdo=='offerListed'){
			if($("#cpn_id").val().length != 6){
				alert("숫자 6자리 코드를 입력하세요.");
				return;
			}
		}
		var cpnId = (chkRdo=='offerListed')?'A'+$("#cpn_id").val():$("#cpn__id").html();
		var cpnNm = $("#cpn_nm").val();
		var cstId = 0;

		var page = 0;
		if("popUpReg" == $('#tmpTak').val()){
			page = 1;
		}
		$("input").css('background-color','');
		if(cpnId.is_null()){
			$("#cpn_id").css('background-color','#A9F5BC');
			alert("상장코드를 입력하세요.");
			// (chkRdo=='offerListed')?obj.find('[id^=cpn_id]').focus():obj.find('[id^=cpn__id]').focus();
			(chkRdo=='offerListed')?$("#cpn_id").focus():$("#cpn__id").focus();
			return;
		}
		if(cpnNm.is_null()){
			$("#cpn_nm").focus();
			$("#cpn_nm").css('background-color','#A9F5BC');
			alert("회사명을 입력하세요.");
			// obj.find('[id^=cpn_nm]').focus();
			return;
		}
		if(cstId.is_null()){
			//alert("대표이사를 선택하세요.");
			//obj.find('[id^=AP_cstId]').focus();
			//return;
			cstId=0;
		}
		if(confirm("적용하시겠습니까?")){
			$.ajax({
				type:"POST",        //POST GET
				url:"../company/insertCpn.do",     //PAGEURL
				data : ({
					cpnId: cpnId,
					cpnNm: cpnNm,
					ceoId: cstId,
					rgId: $('#rgstId').val()
					}),
				timeout : 30000,       //제한시간 지정
				cache : false,        //true, false
				success: function whenSuccess(arg){  //SUCCESS FUNCTION
	//						$(obj).hide();
					$('#c_Name').val(cpnId);
					if(page != 1){
						var frm = document.getElementById('companyName');//sender form id
						frm.target = "mainFrame";//target frame name
						frm.submit();
						frm = document.getElementById('companyLeft');//sender form id
						frm.target = "leftFrame";//target frame name
						frm.submit();
					}else{
						End(cpnId,cpnNm);
					}

				},
				error: function whenError(x,e){    //ERROR FUNCTION
					ajaxErrorAlert(x,e);
				}
			});
		}

	});
	$('.excel_btnOk').click(function(){
		var fileUrl = $('#fileCpn').val();
		if(confirm("적용하시겠습니까?")){
			$.ajax({
				type:"POST",        //POST GET
				url:"../company/ExcelProcess.do",     //PAGEURL
				data : ({
					fileUrl: fileUrl
				}),
				timeout : 30000,       //제한시간 지정
				cache : false,        //true, false
				success: function whenSuccess(arg){  //SUCCESS FUNCTION
					//						$(obj).hide();
					$('#c_Name').val(cpnId);
					var frm = document.getElementById('companyName');//sender form id
					frm.target = "mainFrame";//target frame name
					frm.submit();
					frm = document.getElementById('companyLeft');//sender form id
					frm.target = "leftFrame";//target frame name
					frm.submit();

				},
				error: function whenError(x,e){    //ERROR FUNCTION
					ajaxErrorAlert(x,e);
				}
			});
		}

	});
/************************************************ company main end *****************************************************************/
/************************************************ person main start *****************************************************************/

	//네트워크 추가 팝업에서 사람클릭 시 메모창 float
	$(document).on("click",".popUpCstNm", function(){
		var obj = $(this);
		var t_num = obj.attr('id').split('_');//alert(t_num);
		divId = 'popUpCstPr'+ t_num[1];

		$('#snb2nd').val($('#sNb2_'+t_num[2]).val());
		$('#name2nd').val($('#name2_'+t_num[2]).val());

		$(".popUpMenu").hide();
		divShow($(this));
	});


	//이력/정보 추가 클릭 시 메모창 float
	$(document).on("click",".addNote", function(){
		var obj = $(this);
		var t_num = obj.attr('id').split('_');//alert(t_num);
		divId = 'addNotePr'+ t_num[1];
		$(".popUpMenu").hide();
		divShow($(this));
		// $('#rtn').val("2");
	});
	//이력/정보 추가 클릭 시 메모창 float
	$(document).on("click",".addNote1", function(){
		// if(rtn==0) return;
		var obj = $(this);
		var t_num = obj.attr('id').split('_');//alert(t_num);
		divId = 'addNotePr'+ t_num[1];
		$(".popUpMenu").hide();

 		var newDiv = $("#"+divId).clone();
		newDiv.attr("id", "addNotePr"+(parseInt(t_num[1])+1));
		newDiv.find("input").attr("id", "txt"+(parseInt(t_num[1])+1));
		newDiv.find("textarea").attr("id", "resultarea"+(parseInt(t_num[1])+1));
		$("#cloneDiv").append(newDiv);

		divShow($(this));
		// if(rtn==2) $('#rtn').val("2");

	});

	//이력/정보 메모창 저장
	$(document).on("click",".cloneOk", function(){
		var obj = $(this);
		var num = obj.parent().parent().attr('id').split('Pr');

		var title = $("#txt"+num[1]).val();
		var text = $("#resultarea"+num[1]).val();

		//clone info to td
		var td = $("#cloneSpan1");
		var newInfo = $("#info"+num[1]).clone();
		newInfo.attr("id", "info"+(parseInt(num[1])+1));
		td.append(newInfo);

		$("#info"+num[1]).html(title+":"+text);

		$("#addNote_"+num[1]).attr("id", "addNote_"+(parseInt(num[1])+1));
		$(".popUpMenu").hide();
	});


	$(document).on("click","#excelDown", function(){
		var frm = document.getElementById('excelDownload');//sender form id
		frm.action = "test.do";//target frame name
		frm.submit();
	});
/************************************************ person main end *****************************************************************/
/************************************************ stats main start *****************************************************************/
	$(document).on("change","#choiceMonthS", function(){
		var frm = document.getElementById('dayForm');//sender form id
		frm.submit();
	});
	$(document).on("click","#totSum", function(){
		$('#choiceMonth').val($('#cur_month').val());
		$('#total').val('tot');
		var frm = document.getElementById('dayForm');//sender form id
		frm.submit();
	});
	$(document).on("click","#carTotSum", function(){
		$('#total').val('tot');
		var frm = document.getElementById('dayForm');//sender form id
		frm.submit();
	});
/************************************************ stats main end *****************************************************************/

	$(document).on("change","#select_year", function(){
		 var frm = document.modifyRec;
		 $('#choiceYear').val($('#select_year').val());
		 $('#choiceMonth').val(null);
		 frm.action = "index.do";
		 frm.submit();
	});
	$(document).on("change","#select_year2", function(){
		 var frm = document.modifyRec;
		 $('#choiceYear').val($('#select_year').val());
		 $('#choiceMonth').val(null);
		 frm.action = "viewIndex.do";
		 frm.submit();
	});
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////// div table /////////////////////////////////////////////////////////////////////////

	function divShow(obj){
		//openModalPop(divId,"","700px","300px");
		var objId = obj.attr('id');
		object = objId;
		divPosition(objId,divId);
		$("#"+divId).css('display','block');
		$("#"+divId).show();

	}

/*	// 외부 화면 클릭시 전달감추기
	$(document).live("click",function(event){
//		alert("oldDivId:"+oldDivId);alert("divId:"+divId);
		if(event.target.id != (oldDivId==null?object:oldDivId) && event.target.name != 'textR' && event.target.name != 'checkR'){
			$("#"+oldDivId).hide();
		}
		oldDivId =(oldDivId==divId? null: divId);
	});*/

	function divPosition(target,id){
		var browserWidth = document.documentElement.clientWidth;
		var tInput  = $("#" + target).offset();
//		var tHeight = $("#" + target).outerHeight();
//		var tWidth 	= $("#" + target).outerWidth();
//		alert(target+":"+id+":"+tInput+":"+tHeight+":"+tWidth);
		var calWidth 	= $("#" + id).outerWidth();

		if( tInput != null){
			$("#" + id).css({"top":tInput.top+15 , "left":(tInput.left+calWidth<browserWidth?tInput.left:browserWidth-(calWidth+8))});
			// $("#" + id).css({"top":tInput.top+tHeight , "left":(tInput.left+calWidth<browserWidth?tInput.left:browserWidth-(calWidth+8))});

//			$("#" + id + "Icon").css({"top":tInput.top+3,"left":tInput.left+tWidth+2});
//			$("#" + target).css({"top":tInput.top+3,"left":tInput.left+tWidth+2});
		}
	}
///////// div table /////////////////////////////////////////////////////////////////////////

///////// dynamic div table /////////////////////////////////////////////////////////////////////////

	// 삭제버튼 클릭시
	$(document).on("change",".delBtn", function(){
		var clickedRow = $(this).parent().parent().parent();
//		var clickedHeight = clickedRow.parent().parent().parent() + " li";
		clickedRow.parent().parent().parent().css('padding-bottom','-=20px');
//		clickedHeight.css('height','-=20px');
		clickedRow.remove();

	});

///////// dynamic div table /////////////////////////////////////////////////////////////////////////

///////// jquery ajax searching left menu /////////////////////////////////////////////////////////////////////////
/*
	$('#nameSearch').keypress(function(){

    	  $.ajax({
    	   type:"POST",        //POST GET
    	   url:"../company/searchName.do",     //PAGEURL
		   //  dataType: "html",       //HTML XML SCRIPT JSON
    	   data : ({cpnNm: $("#nameSearch").val()}),
    	   timeout : 30000,       //제한시간 지정
    	   cache : false,        //true, false
    	   success: function whenSuccess(args){  //SUCCESS FUNCTION
    	    $("#idchk_commit").val("");
    	    switch(args){
    	     case("true"):
    	      show_args="<font color='blue'>사용 가능합니다.</font>";
    	      $("#idchk_commit").val("Y");
    	     break;
    	     case("false"):
    	      show_args="<font color='red'>이미 사용중인 아이디 입니다.</font>";
    	     break;
    	     default:
    	     case("none"):
    	      show_args="<font color='red'>아이디를 입력 해주세요.</font>";
    	     break;
    	     case("short"):
    	      show_args="<font color='red'>아이디는 4자 이상으로 입력 해주세요.</font>";
    	     break;
    	     case("long"):
    	      show_args="<font color='red'>아이디는 16자 미만으로 입력 해주세요.</font>";
    	     break;
    	    }
    	    $('#resultDIV').html(show_args);
    	   },
    	   error: function whenError(x,e){    //ERROR FUNCTION
    	    ajaxErrorAlert(x,e);
    	   }
    	  });
    	 });*/

	mozilaAjax =  function(){
		  $.ajax({
		   type:"POST",        //POST GET
		   url:"../company/searchName.do",     //PAGEURL
			   //  dataType: "html",       //HTML XML SCRIPT JSON
		   data : ({cpnNm: $("#nameSearch").val()}),
		   timeout : 30000,       //제한시간 지정
		   cache : false,        //true, false
		   success: function whenSuccess(args){  //SUCCESS FUNCTION
			$("#idchk_commit").val(args);
		   },
		   error: function whenError(x,e){    //ERROR FUNCTION
			ajaxErrorAlert(x,e);
		   }
		  });
	};
///////// jquery ajax searching left menu /////////////////////////////////////////////////////////////////////////


});


/**
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
	function start 함수
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
**/


function numbersonly(e, decimal) {//input박스 숫자만 입력받기
	var key;
	var keychar;

	if (window.event) {
		key = window.event.keyCode;
	} else if (e) {
		key = e.which;
	} else {
		return true;
	}
	keychar = String.fromCharCode(key);

	if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13)
			|| (key == 27)) {
		return true;
	} else if ((("0123456789").indexOf(keychar) > -1)) {
		return true;
	} else if (decimal && (keychar == ".")) {
		return true;
	} else
		return false;
}

function divPosition(target,id){
	var browserWidth = document.documentElement.clientWidth;
	var tInput  = $("#" + target).offset();
	// var tHeight = $("#" + target).outerHeight();
	// var tWidth 	= $("#" + target).outerWidth();
	var calWidth 	= $("#" + id).outerWidth();

	if( tInput != null){
		$("#" + id).css({"top":tInput.top -130 , "left":(tInput.left+calWidth<browserWidth?tInput.left:browserWidth-(calWidth+8))});
	}
}

/*function divShow(obj,divId){//function 에서 사용 obj:this, divId는 열리게될 div id
	var objId = obj.attr('id');
	divPosition(objId,divId);
	$("#"+divId).css('display','block');
	$("#"+divId).show();
}*/

function Request(valuename)    //javascript로 구현한 Request
{
    var rtnval;
    var nowAddress = location.href;
    var parameters = new Array();
    parameters = (nowAddress.slice(nowAddress.indexOf("?")+1,nowAddress.length)).split("&");

    for(var i = 0 ; i < parameters.length ; i++){
        if(parameters[i].indexOf(valuename) != -1){
            rtnval = parameters[i].split("=")[1];
            if(rtnval == undefined || rtnval == null){
                rtnval = "";
            }
            return rtnval;
        }
    }
}

function popUp(num,flag,nm,snb){

// popUp 규격
	var w = '740';
	var h = '740';
	var ah = screen.availHeight - 30;
	var aw = screen.availWidth - 10;
	/* var option = "left:" + xc + "; " +
				"top:" + yc + "; " +
				"menu:no; " +
				"status:no; " +
				"toolbar:no; " +
				"location:no; " +
				"scrollbars:no; " +
				"resizable:yes; " +
				"dialogWidth:" + w + ";" +
				"dialogHeight:" + h; */
// popUp 규격

	var val = new Object();
	var sUrl = '';

	// var data,fn = function(arg){ window.parent.putModal(arg); };
	if(flag=='c') {
		sUrl = "../work/popUpCpn.do";
		sUrl+='?f='+flag+'&n='+num;
		w='500',h='600';
		// if(typeof(window.parent['allMask'])=='function'){ window.parent.allMask();}

	}else if(flag=='ceo' | flag=='p'  | flag=='pp' | flag=='ppp'  | flag=='workNetp' | flag=='iP'){
		sUrl = "../work/popUpCst.do";
		sUrl+='?f='+flag+'&n='+num;
		w='500',h='600';
		// if(typeof(window.parent['allMask'])=='function'){ window.parent.allMask();}
	}else if(flag=='modiCst') {// 고객 main 페이지 수정  클릭시
		sUrl = "../person/modifyCst.do";
		sUrl+='?f='+flag+'&sNb='+snb+'&nm='+nm;
	}else if(flag=='cExcel') sUrl = "../company/popUpExcel.do";
	else if(flag=='cCsv'){
		sUrl = "../company/uploadCompanyByCsv.do";
		w='740',h='450';
	}
	else if(flag=='files') {
		var numb = (parseInt(num)<10?('0'+num):num);
		if(numb.length===3) numb = numb.substring(1,3);
		day = $('#choiceYear').val()+ $('#choiceMonth').val()+ numb;
		sUrl = "../work/multiUpload.do";
		sUrl+='?f='+flag+'&n='+num+'&nm='+nm+'&snb='+$("#offerSnb").val()+'&day='+day;
		if($("#reportYN_ input:checkbox").is(":checked")==true) sUrl+='&report=Y';
		else sUrl+='&report=N';
		w='500',h='600';
	}
	else if(flag=='files_rcmd') {		//추천종목 화면 파일첨부
		var numb = (parseInt(num)<10?('0'+num):num);
		if(numb.length===3) numb = numb.substring(1,3);
		day = $('#choiceYear').val()+ $('#choiceMonth').val()+ numb;
		sUrl = "../work/multiUpload.do";
		sUrl+='?f='+flag+'&n='+num+'&nm='+nm+'&snb='+$("#offerSnb"+num).val()+'&day='+day;		/* 위 else if(flag=='files') 와 다른 부분... $("#offerSnb"+num) */
		if($("#reportYN_ input:checkbox").is(":checked")==true) sUrl+='&report=Y';
		else sUrl+='&report=N';
		w='500',h='600';
	}
	else if(flag=='rcmdCpn'){
		sUrl = "../company/main.do";
		sUrl+='?sNb='+snb;
		w='860';
	}
	else if(flag=='rcmdCst'){
		sUrl = "../person/main.do";
		sUrl+='?f='+flag+'&sNb='+snb+'&popUp=Y';
	}
	else if(flag=='rcmdComment'){
		sUrl = "../recommend/comment.do";
		var tmDate = num.split('-');
		sUrl+='?sNb='+snb+'&choiceYear='+tmDate[0]+'&choiceMonthS='+tmDate[1]+'&tmDt='+num;
		// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}
	}
	else if(flag=='rcmdWork'){
		sUrl = "../work/popUpRecommend.do";
		sUrl+='?f='+flag+'&n='+num+'&sNb='+snb;
		w='500',h='600';
		// if(typeof(window.parent['allMask'])=='function'){ window.parent.allMask();}
	}
	else if(flag=='workMemo'){
		sUrl = "../work/popUpMemo.do";
	}
	else if(flag=='supporter'){
		sUrl = "../work/popUpSup.do";
		sUrl+='?f='+flag+'&sNb='+snb;
	}
	else if(flag=='introducer'){
		sUrl = "../work/popUpIntroducer.do";
		num = $('#choiceYear').val()+$('#choiceMonth').val()+num;
		sUrl+='?f='+flag+'&dt='+ num+'&sNb='+snb;
 		w='500',h='400';
	}
	/*삭제 이인희 else if(flag=='meeTing'){
		sUrl = "../person/meeTing.do";
		sUrl+='?f='+flag+'&sNb='+snb;
		w='500',h='600';
	}
	else if(flag=='meeTingList'){
		sUrl = "../person/meeTingList.do";
		sUrl+='?f='+flag+'&num='+num;
		w='500',h='600';
	}*/
	// val.cstNm = $("#AP_cpnNm_"+num).html();
	h = (ah-40>h?h:ah-40);
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
	window.open(sUrl, "_blank", option);


	return;

///**//

	/* if(typeof(window.parent['initModal'])=='function'){
		window.parent.initModal();
	}
	ajaxModule(data,sUrl,fn); */

	// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}

///**//

}

function returnPopUp(rVal){

	var flag = rVal.f
	,nm = rVal.nm
	,num = rVal.n;
	if(flag=='c'){
		$("#AP"+num).focus();
		if(rVal.nm != null) $("#AP_cpnNm_"+num).html(rVal.nm);
		if(rVal.snb != null) {
			$("#AP_cpnId_"+num).val(rVal.snb);
			if(rVal.cpnSnb != null) $("#AP_CpnSnb_"+num).val(rVal.cpnSnb);
			if(num=='mc') afterMatchingCpn();//딜 mna 매칭 cpn
			var tmpVal = $("#rcmdWorkSpan_"+num).parent().find('[class^=work-2ndSelect]').val();
			if($("#categoryCd_").val()!='00014' && (tmpVal=='00002'||tmpVal=='00005')){				//제안중(직접발굴) 추가   ||tmpVal=='00005'    20160519
				$("#rcmdWork_"+num).attr('onclick',"popUp('"+num+"','rcmdWork','','"+rVal.snb+"')");
				popUp(num,'rcmdWork','',rVal.snb);
			}
		}
		// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}

	}else if(flag=='p'){
		if(rVal.nm != null) {$(".popUpMenu #AP_cstNm"+num).html(rVal.cpnNm+" : "+rVal.nm);}
		if(rVal.snb != null) {$(".popUpMenu #AP_cstId"+num).val(rVal.snb);}
		if(rVal.snb != null) {$(".popUpMenu #AP_cpnSnb"+num).val(rVal.cpnSnb);}
		if($("#offerCd"+num).val() != '00006' && $("#offerCd"+num).val() != '00007'){ }
		// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}

	}else if(flag=='pp' | flag=='ppp'){
		if(rVal.nm != null){
			if(flag=='pp')$("#intro_cstNm"+num).html("<b>거래상대방</b><br/>"+rVal.cpnNm+"<br/>"+rVal.nm);
			else{$("#intro_cstNm"+num).html(rVal.cpnNm+" : "+rVal.nm);}
		}
		if(rVal.snb != null) {$("#rgSnb"+num).val(rVal.snb);}
		// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}

	}else if(flag=='workNetp'){//업무일지->인물정보->인물선택
		if(rVal.nm != null) {
			$("#sltPerNetName"+num).html(rVal.cpnNm+" : "+rVal.nm);
			$("#perNetName"+num).val(rVal.nm);
		}
		if(rVal.snb != null) {
			$("#perNetSnb"+num).val(rVal.snb);
			popUp('','rcmdCst','',rVal.snb);
		}
		// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}
		return;

	}else if(flag=='rcmdCst'){
		document.modifyRec.submit();

	}else if(flag=='introducer'){
		// document.modifyRec.submit();
		if(rVal.nm == 'del') document.modifyRec.submit();

	}else if(flag=='iP'){
		if(rVal.nm != null) $("#AP_infoProviderNm"+num).html(rVal.cpnNm+" : "+rVal.nm);
		if(rVal.snb != null) $("#AP_infoProviderId"+num).val(rVal.snb);
		// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}

	}else if(flag=='C'||flag=='PersonCPN'||flag=='PersonCPNnet'){
		$("#offerDiv").html('');
		re_fresh();
		//$('#i_Name').val(rVal.snb);
		///$("#companyName").submit();


		//var frm = document.getElementById('customerName');//sender form id
		//commonAjaxSubmit("POST",$("#customerName"),innerMainAreaCallback);
		/*if($("#rtn").val()!='popUp'){
			var target = "mainFrame";
			if(typeof(parent.insertStockFirmIbYN)!='function') {
				parent.parent.location.reload();
				return;
			}
			if(parent.insertStockFirmIbYN()=="Y") target = "stockCstFrame";
			frm.target = target;//target frame name
		}*/
		// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}
		//frm.submit();

	}else if(flag=='workNetC'||flag=='workNetPersonCPN'||flag=='workNetPersonCPNnet'){
		if(rVal.cpNcsNm != null) {
			if(flag=='workNetC') $("#prtPerNet"+num).html(rVal.cpNcsNm+"<br/>"+rVal.note);
			if(flag=='workNetPersonCPNnet') $("#prtCopNet"+num).html(rVal.cpNcsNm+"<br/>"+rVal.note);
			if(flag=='workNetPersonCPN') $("#prtDealNet"+num).html(rVal.cpNcsNm+"<br/>"+rVal.note);
		}

	}else if(flag=='modiCst') {// 고객 main 페이지 저장
		if(rVal.snb != null) {
			alert("저장되었습니다.");
			$("#s_Name").val(rVal.snb);
			$("#customerName").submit();
		}

	}else if(flag=='CC'){
		if(rVal.snb!=null){
			$('#s_Name').val(rVal.snb);
			var frm = document.getElementById('customerName');//sender form id
			frm.target = "mainFrame";//target frame name
			frm.submit();
		}
	}else if(flag=='rcmdWork'){
		if(rVal.snb != null) $('#rcmderSnb_'+num).val(rVal.snb);
		if(rVal.nm  != null) $('#rcmdWork_'+num).html(rVal.nm);

	}
	/*삭제 이인희 else if(flag=='meeTingList'){
		if(rVal.snb != null) $("#meetSnb_"+num).val(rVal.snb);
		if(nm != null) $(".link:eq("+parseInt(num-1)+")").html(nm);

	}*/
	else if(flag=='DD'){

		// var td = $("#cloneSpan1");
		// var newInfo = $("#info"+num[1]).clone();
		// newInfo.attr("id", "info"+(parseInt(num[1])+1));
		// td.append(newInfo);
	}else if(flag=='files'){
		var name = null, img = null;
		var leng = rVal.status;

		if(rVal.nm=='recommend') {
			$("#dayForm").action = 'index.do';
			$("#dayForm").submit();
		}

		if(rVal.snb != null) $('#offerSnb').val(rVal.snb);
		//alert(rVal.snb+"/"+rVal.name1+"/"+rVal.path)

		/* if(rVal.path != null & rVal.name1 != null){
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
		} */
		$('#fileAdd_').attr('style', 'display:none');//파일첨부 후 버튼 없애기

	}

	/*else if(flag=='ceo'){
		// if(typeof(window.parent['delMask'])=='function'){ window.parent.delMask();}
		if(confirm("적용하시겠습니까?")){
			var cpnId = rVal.cpnId;
			$.ajax({
				type:"POST",        //POST GET
				url:"../company/updateCpn.do",     //PAGEURL
				data : ({
					cpnId: cpnId,//회사 아이디 snb에 받음
					ceoId: rVal.snb//선택된 고객의 snb
				}),
				timeout : 30000,       //제한시간 지정
				cache : false,        //true, false
				success: function whenSuccess(arg){  //SUCCESS FUNCTION

					$('#i_Name').val(cpnId);//snb, cpnId 두개 모두 가능

					commonAjaxSubmit("POST",$("#companyName"),innerMainAreaCallback);
					var frm = document.getElementById('companyName');//sender form id
					frm.target = "mainFrame";//target frame name
					frm.submit();
				},
				error: function whenError(x,e){    //ERROR FUNCTION
					ajaxErrorAlert(x,e);
				}
			});
		}
	}*/
}
///////// work left menu /////////////////////////////////////////////////////////////////////////
function sortUser(th,staffName,staffId){
	var obj = $(th);
	$('li .bgOrg').removeClass('bgOrg');
	$('#s_Name').val(staffName);
	$('#s_Id').val(staffId);
	obj.addClass('bgOrg');
	var mainIframeYear = parent.mainFrame.choiceYear;
	$("#s_year").val(mainIframeYear==null?'':mainIframeYear.value);
	var frm = document.getElementById('staffName');//sender form id
	frm.target = "mainFrame";//target frame name
	frm.submit();
}

///////// work left menu /////////////////////////////////////////////////////////////////////////

///////// work main menu /////////////////////////////////////////////////////////////////////////
function month(mon,url){//월 선택
	 var frm = document.modifyRec;
	 $('#choiceMonth').val(mon);
	 $('#cc_year').val($("#choiceYear").val());
	 frm.action = url;
	 frm.submit();
}

function chkval(n) {//check된 staff 이름 배열로 묶어주기
	var nnum = n.checkbox;
	var vchk = false;
	for(var i=0;i<nnum.length;i++){
		vchk = vchk || nnum[i].checked;
	}
	return vchk;
}

function getWeekday(sDate) {//해당 날짜의 요일구하기
    var yy = parseInt(sDate.substr(0, 4), 10);
    var mm = parseInt(sDate.substr(5, 2), 10);
    var dd = parseInt(sDate.substr(8), 10);

    var d = new Date(yy,mm - 1, dd);
    var weekday=new Array(7);
    weekday[0]="일";
    weekday[1]="월";
    weekday[2]="화";
    weekday[3]="수";
    weekday[4]="목";
    weekday[5]="금";
    weekday[6]="토";

    return weekday[d.getDay()];
}


//추천현황에 메모 내용수정 확인
function recommendSubMemo(th,cpnName,rgName,rgName2,prgressCd){
	if(confirm("적용하시겠습니까?")){
		var obj = $(th).parent().parent().parent();
		var tmpNumber = "";
		if(rgName2.length > 0) tmpNumber = "rcmdSendMemo";
		var DATA = {sNb: obj.find('[id^=dealMemoSNb]').val()
				,subMemo: obj.find('[id^=memoarea]').val()
				,tmpNum1: tmpNumber
				,cpnNm: cpnName
				,rgNm: rgName2
				,progressCd: prgressCd
				,rgId: $('#rgstId').val()};
		var url = "../work/modifyDealMemo.do";
		var fn = function(){ document.modifyRec.submit(); };
		ajaxModule(DATA,url,fn);
	}
}

function totalView(flag){
	if(flag == 'total') $("#total").val(flag);
	document.dayForm.submit();
}

function sortTable(flag,tm){
	if(flag == 'total' || flag=='sellBuy'){
		$("#total").val(flag);
		$("#sorting").val(tm);
	}
	else $("#sorting").val(flag);
	document.modifyRec.submit();
}

function selectTab(flag,tm){
	if(flag == 'total' || flag=='sellBuy'){
		$("#total").val(flag);
		$("#tab").val(tm);
	}
	else $("#tab").val(flag);
	document.modifyRec.submit();
}

function selectLv(lv, snb, frmNm){
	var DATA = {sNb:snb, lvCd:"0000"+lv};
	var url = "../work/saveLv.do";
	var fn = function(){
		$("#"+frmNm).submit();
	};
	ajaxModule(DATA,url,fn);
}
///////// work main menu /////////////////////////////////////////////////////////////////////////

///////// company left menu /////////////////////////////////////////////////////////////////////////

function slctCpn(snb,stock){ //psj
	$input = $("<input></input>").attr("type","hidden").attr("id","cpn_Name").attr("name","sNb").val(snb);
	$frm =  $("<form></form>").attr("id","companyName").attr("name","companyName").attr("action","../company/main.do").attr("method","post").append($input);
	commonAjaxSubmit("POST",$frm,innerMainAreaCallback);
	/*$('body').append('<form id="companyName" name="companyName" action="../company/main.do" method="post"><input type="hidden" id="cpn_Name" name="sNb"/></form>');
	var target = "mainFrame";*/
	//$('#cpn_Name').val(snb);//snb, cpnId 두개 모두 가능
	//if(typeof(parent.insertStockFirmIbYN)=='function' && parent.insertStockFirmIbYN()=="Y") target = "stockCstFrame";
	//var frm = document.getElementById('companyName');//sender form id
	//frm.target = target;//target frame name
	//$frm.submit();
}

function rgstCpn(){ //psj
	$('#c_Name').val($('#nameSearch').val());

	commonAjaxSubmit("POST",$("#rgstCpnNm"),rgstCpnCallback);
}
function rgstCpnCallback(data){ //psj
	$("#mainArea").empty();
	$("#mainArea").append(data);
}
function popRgstCpn(){
	var frm = document.getElementById('insertCpn');//sender form id
	frm.action = "popRgstCpn.do";//target frame name
	frm.submit();
}

///////// company left menu /////////////////////////////////////////////////////////////////////////
///////// person left menu /////////////////////////////////////////////////////////////////////////
function slctCst(sNb){ //psj
	if($(".popUpBtn").css("display")=="none") return;
	$('#s_Name').val(sNb);
	var frm = document.getElementById('customerName');//sender form id
	//frm.target = "mainFrame";//target frame name
	if(typeof insertStockFirmIbYN == 'function')
		if("Y"==insertStockFirmIbYN()) frm.target = "stockCstFrame";

	$("#customerName").submit();
	//commonAjaxSubmit("POST",$("#customerName"),innerMainAreaOnlyPopCallback);
}

function popRgstCst(cnt){
	if(cnt==0) cnt='';
	$('#s_Name').val($('#nameSearch').val()+cnt);
	$('#s_Name2').val($('#nameSearch').val()+cnt);
	var frm = document.getElementById('insertCst');//sender form id
	frm.action = "popRgstCst.do";//target frame name
	frm.submit();
}
///////// person left menu /////////////////////////////////////////////////////////////////////////
///////// person main menu /////////////////////////////////////////////////////////////////////////
/*function check_personInput(){
	var cstNm = $('#cst_nm');
	var cpnId = $('#AP_cpnId_0');
	var pst   = $('#position');
	var email = $('#email');
	var phn1   = $('#phn_1');
	var phn2   = $('#phn_2');
	var phn3   = $('#phn_3');

	if(cstNm.val().is_null()){
		alert("이름을 입력하세요.");
		cstNm.focus();
		return 0;
	}
	if(pst.val().is_null()){
		alert("직위을 입력하세요.");
		pst.focus();
		return 0;
	}
	if(email.val().is_null()){
		alert("email을 입력하세요.");
		email.focus();
		return 0;
	}
	if(phn1.val().is_null()){
		alert("전화번호를 입력하세요.");
		phn1.focus();
		return 0;
	}
	if($('#cst_snb').val().length!=0) return 2;

		$.ajax({
			type:"POST",        //POST GET
			url:"../person/AjaxInsertCst.do",     //PAGEURL
			data : ({
				cstNm: cstNm.val(),
				cpnId: cpnId.val(),
				position: pst.val(),
				email: email.val(),
				phn1: phn1.val(),
				phn2: phn2.val(),
				phn3: phn3.val(),
				rgId: $('#rgstId').val()
				}),
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				var arr = arg.split('_');
				var name = arr[0];
				var num = arr[1];
				$('#cst_snb').val(num);
				$('#addNtw').attr('onclick',"popUp('_0','CC','"+name+"','"+num+"'); return false;");
			},
			error: function whenError(x,e){    //ERROR FUNCTION
				ajaxErrorAlert(x,e);
			}
		});
	return 1;
}*/


///////// person main menu /////////////////////////////////////////////////////////////////////////


/*
 * 브라우저 종류,버전 체크
 */

function browserCheck(){
	if(navigator.appName == "Netscape"){
		//FF용 코드
		return "FF";
	}else if(navigator.appName == "Microsoft Internet Explorer"){
		//IE용 코드
		if(navigator.appVersion.indexOf("MSIE6") != -1 ||navigator.appVersion.indexOf("MSIE 6") != -1){
			//ie6 용 코드
			return "IE6";
		}else if(navigator.appVersion.indexOf("MSIE7") != -1||navigator.appVersion.indexOf("MSIE 7") != -1){
			//ie7 용 코드
			return "IE7";
		}else if(navigator.appVersion.indexOf("MSIE8") != -1||navigator.appVersion.indexOf("MSIE 8") != -1){
			//ie8 용 코드
			return "IE8";
		}else if(navigator.appVersion.indexOf("MSIE9") != -1||navigator.appVersion.indexOf("MSIE 9") != -1){
			//ie9 용 코드
			return "IE9";
		}else{
			//기타등등
			return navigator.appVersion;
		}
	}else{
		return "else";
	}
}



/*
* 아이디 체크
*/
	function check_id(field){

		if(2 > field.val().length || field.val().length > 12 ){
			alert('ID는 3~12자 사이로해주세요.');
			return false;
		}

		if(/[a-zA-Z]/.test(field.val())||/[0-9]/.test(field.val())){
//			if(/[a-zA-Z]/.test(field.value)||/[0-9]/.test(field.value)){
		 		return true;
		}else{
			alert('ID는 3~12자 영문과 숫자여야 합니다.');
			return false;
		}
	}
	/*
	 * JSNUMM
	 */
	function jsNull(arguments){
		if ( arguments == "" || arguments == null || arguments == "undefined" )
	        return true;
	    else
	        return false;
	}
	/*
   * 입력된 값이 숫자인지 아닌지 체크
   */
	function jsNumeric(arguments){//alert("ttt");
		if ( jsNull(arguments) ) return true;

		for (var i = 0; i < arguments.length; i++){
			if (arguments.charAt(i) < "0" || arguments.charAt(i) > "9" || arguments.charCodeAt(i) > 127 ){
			    return false;
			}
		}
		return true;
	}
	/*
	 * 패스워드 체크
	 */
	function CheckPassWord(userPassWord){
		if(!userPassWord.match(/([a-zA-Z].*[0-9])|([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~])|([0-9].*[a-zA-Z])|([0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[0-9])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z])/)){
			alert("비밀번호는 문자,숫자,특수문자의 조합으로 10자리까지 입력가능합니다.");
			return false;
		}

		var SamePass_0 = 0; //동일문자 카운트
		var SamePass_1 = 0; //연속성+ 카운트
		var SamePass_2 = 0; //연속성- 카운트

		var chr_pass_0;
		var chr_pass_1;

		for (var i=0;i<userPassWord.length;i++){
			chr_pass_0 = userPassWord.charAt(i);
			chr_pass_1 = userPassWord.charAt(i+1);
			//동일문자 카운트
			if(chr_pass_0 == chr_pass_1){
				SamePass_0 = SamePass_0+1;
			}
			//연속성+카운트
			if(chr_pass_0.charCodeAt(0)-chr_pass_1.charCodeAt(0) == -1){
				SamePass_1 = SamePass_1 + 1;
				if (SamePass_1 > 1){
					alert("연속된 문자열 (123 또는 321,abc,cba 등)을 3자 이상 사용할수 없습니다.");
			 		return false;
		 		}
			}else{
				SamePass_1 = 0;
			}
			//연속성-카운트
			if(chr_pass_0.charCodeAt(0)-chr_pass_1.charCodeAt(0) == 1){
				SamePass_2 = SamePass_2 + 1;
				if (SamePass_2 > 1){
					alert("연속된 문자열 (123 또는 321,abc,cba 등)을 3자 이상 사용할수 없습니다.");
			 		return false;
		 		}
			}else{
				SamePass_2 = 0;
			}
		}
		if(SamePass_0 > 1){
			alert("동일문자를 3번 이상 사용할수 없습니다.");
			return false;
		}
		/*
		if(SamePass_1 > 1 || SamePass_2 > 1)
		{
			alert("연속된 문자열 (123 또는 321,abc,cba 등)을 3자 이상 사용할수 없습니다.");
			return false;
		}
		*/
		return true;
	}

	function ajaxModule(DATA,Url,Fn){
		$.ajax({
			type:"POST",        //POST GET
			url:Url,     //PAGEURL
			data : DATA,
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				Fn(arg);
			},
			error: function whenError(x,e){    //ERROR FUNCTION
				ajaxErrorAlert(x,e);
			}
		});
	}

	function ajaxErrorAlert(x,e){
		if(x.status==0){
			alert('code: '+x.status+"\r\nYou are offline!!\r\nPlease Check Your Network.");
		}else if(x.status==404){
			alert('code: '+x.status+"\r\nRequested URL not found.");
		}else if(x.status==500){
			alert('code: '+x.status+"\r\nInternel Server Error.");
		}else if(e=='parsererror'){
			alert('code: '+x.status+"\r\nError.nParsing JSON Request failed.");
		}else if(e=='timeout'){
			alert('code: '+x.status+"\r\nRequest Time out.");
		}else {
			alert('code: '+x.status+"\r\nUnknow Error.\r\n"+x.responseText);
		}
	}

/************************************************ management main start *****************************************************************/
	function insertDate(e,decimal, obj){
		if(!numbersonly(e,decimal)) return false;
		alert("test");
		alert(obj.parent().val());
		alert(obj.child().val());
		if(4==obj.val().length) obj.val(obj.val()+"-");
		else if(6==obj.val().replace("-","").length) obj.val(obj.val()+"-");
	}
	// 추가 버튼 클릭시
	//$("#addUlBtn").click(function(){
	function insertUl(divNm){
		var newitem = $("#"+divNm+" .tbody:eq(-1)").clone();
		// newitem.removeClass();
		newitem.find("li input:text").val("");
		newitem.find("li select").val("");

		$("#"+divNm).append(newitem);
	}


/************************************************ management main end *****************************************************************/
/************************************************ bsnsPlan main start *****************************************************************/
function downup(num,move){
	var target = $("#dynamicTbl .dnTbl:eq("+(num+move)+")");
	var source = $("#dynamicTbl .dnTbl:eq("+num+")");
	var maxlength = $("#dynamicTbl .dnTbl").length -1;

	if((num+move)==1)
		source.find("input:button").attr("onclick","");
	else
		source.find("input:button").attr("onclick","downup("+(num+move)+",-1)");

	if((num+move) == maxlength)
		source.find("span a").attr("onclick","");
	else
		source.find("span a").attr("onclick","downup("+(num+move)+",1)");

	target.find("input:button").attr("onclick","downup("+num+",-1)");
	target.find("span a").attr("onclick","downup("+num+",1)");
	if(move<0)target.before(source);
	else if(move>0) target.after(source);
}

function removeTr(num){
	var target = $(".tbl"+num);
	if(confirm("삭제하시겠습니까?")){
		target.find("td input, td select").val('');
		//target.find("td").remove();
		var frm = document.getElementById('planForm');//sender form id
		frm.action="insertBsnsPlan.do";
		frm.submit();
	}
}

function bsnsPsave(page, tempNum){
	var num = tempNum.split('_');
	var url = '';
	if(page=='bsnsPlan') url = "../bsnsPlan/insertBsnsPlanNote.do";
	var DATA = {sNb: $('#bsnsPsnb'+num[1]).val(),
				note: $('#memoarea'+num[1]).val(),
				feedback: $('#memoarea'+num[1]).val()};
	var fn = function(){
		$("#bsnsPmemo_"+num[1]).hide();
	};
	ajaxModule(DATA,url,fn);
}
/************************************************ bsnsPlan main end *****************************************************************/
/************************************************ recommend main start *****************************************************************/
function selectOpinion(th,divId,offerSnb){
	$(".popUpMenu").hide();
	$("#insertOpinionBtn").attr('onclick',"saveOpinion('','"+offerSnb+"');");
	divShow($(th),divId);
	var t_num = divId.split("workPr");
	// $("#BN_"+t_num[0]+"_"+t_num[1]).focus();
}

function divUp(th,snb,count){
	var divId = snb+"rcmdDIV"+count;
	$("#updateOpinionBtn"+count).attr('onclick',"saveOpinion('"+count+"','"+snb+"');");
	$("#deleteOpinionBtn"+count).attr('onclick',"saveOpinion('"+count+"');");
	$(".popUpMenu").hide();
	divShow($(th),divId);
	// $("#BN_"+snb+"_"+count).focus();
}

function updateRCMD(tag,rslt,snb,cpnNm){
	var DATA = null;
	if(tag=='rslt') DATA = ({sNb:snb, result:rslt});
	else if(tag=='progress') DATA = ({sNb:snb, progressCd:rslt});
	else if(tag=='proposer') DATA = ({sNb:snb, rcmdProposer: $(".chbox:checked").val(),cpnNm:cpnNm, subMemo: "N"});
	else if(tag=='price') DATA = ({sNb:snb, price:rslt});
	if(confirm("적용하시겠습니까?")){
		var url = "../recommend/updateResult.do";
		var fn = function(){
			document.companyName.action = "index.do";
			document.companyName.submit();
		};
		ajaxModule(DATA,url,fn);
	}
}

function saveOpinion(cnt,offerSnb){
	var DATA;
	if(cnt==''){//insert
		DATA =({ offerSnb:offerSnb, opinion: $('input[name=opinion]:checked').val(), comment: $('#txtarea0').val()});
	}else{
		if(offerSnb!=''){//update
			DATA =({ sNb: $('#OPsNb'+cnt).val(), offerSnb:offerSnb, opinion: $('input[name=opinion'+cnt+']:checked').val(), comment: $('#txtarea'+cnt).val()});
		}else{//delete
			DATA =({ sNb: $('#OPsNb'+cnt).val()});
		}
	}
	if(confirm("적용하시겠습니까?")){
		var url = "../recommend/saveOpinion.do";
		var fn = function(){
			document.companyName.action = "index.do";
			document.companyName.submit();
		};
		ajaxModule(DATA,url,fn);
	}
}

function staffDiv(th,divId,offerSnb,cpnNm){
	$(".popUpMenu").hide();
	$("#saveBTN").attr('onclick',"updateRCMD('proposer','','"+offerSnb+"','"+cpnNm+"');");
	divShow($(th),divId);
	// $("#PM_0").focus();
}

function write_cancle(flag,cnt){
	if(flag=='ist'){
		$(".new_cmt").css('display','none');
		$("#toast_comment_text").val('');
	}else if(flag=='mdf'){
		$("#user_text"+cnt).css('display','block');
		$("#modi_textarea"+cnt).css('display','none');
	}
}

function modify_comment(cnt){
	$("#user_text"+cnt).css('display','none');
	$("#modi_textarea"+cnt).css('display','block');
}
/************************************************ recommend main end *****************************************************************/
/************************************************ person main start *****************************************************************/

/************************************************ person main end *****************************************************************/
//Main Area 에 Ajax 응답값을 넣어준다.
function innerMainAreaCallback(data){ //psj
	if (window.opener) {
		$("#mainArea",opener.document).empty();
		$("#mainArea",opener.document).append(data);
	} else  {
		$("#mainArea").empty();
		$("#mainArea").append(data);
	}
}
function innerMainAreaOnlyPopCallback(data){
	alert(data)
	$("html").empty();
	$("html").append(data);
}

/************************************************텝이동 : 박성진 ************************************************************************/
function moveTab(url){
	window.location.href = contextRoot+url;
}