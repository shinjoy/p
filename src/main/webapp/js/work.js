$(document).ready(function(){
/** drag n drop **/
	var leftStart = 0;
	var topStart = 0;
	var notMove = 0;
	var clickObj = null;

	$("a.title").bind('dragstart', function(event){
		topStart = 0;
		leftStart = 0;
		clickObj = $(this);
		if(clickObj.find('img').attr('title')!=null) return;
		var cs = getPosition(event);
		leftStart = event.offsetX;
		topStart = cs.y;
		clickObj.clone().appendTo("#moveTable");
		$("#moveDiv").css({'display':'',opacity:.5});
		$("#moveDiv").css({'font-family':'맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif'});
		$("#moveDiv").css({'font-weight':'bold'});
		$("#moveTable a").removeClass('title');

	}).bind('drag', function(event){
		if(clickObj.find('img').attr('title')!=null) return;
		var cs = getPosition(event);
		var moveLength = Math.abs(topStart-cs.y);
		// console.log(moveLength);
		if(moveLength<5){
			notMove = 1;
			return;
		} else {
			notMove = 0;
			clickObj.css('visibility','hidden');
			return $("#moveDiv").css({ top:cs.y, left:leftStart });
		}
		//$("#moveTable tr").css({'background-color':'#7CB57C','cursor':'move'});

	}).bind('dragend', function(event){
		if(clickObj.find('img').attr('title')!=null) return;
		$("#moveDiv").fadeOut();
		$(this).removeClass('active');
		clickObj.css('visibility','visible');
		$("#moveTable").html('');
	});

	$("a.title").bind('dropstart', function(event){
		if(notMove===1) return;
		if(clickObj.find('img').attr('title')!=null) return;
		if($(this).attr('id').split('_')[0]==clickObj.attr('id').split('_')[0])
			$(this).addClass('active');

	}).bind('drop', function(){
		if(notMove===1) {clkBusiness(event,$(this)); return;}
		if(clickObj.find('img').attr('title')!=null) return;
		var splitThis = $(this).attr('id').split('_');
		var splitClic = clickObj.attr('id').split('_');
		// if(splitClic[0]==splitThis[0]){
		if(splitClic[1]!=splitThis[1]){
			$(this).append('<span>&nbsp;&bull;<span>');
			var DATA='',url=''
				,title = clickObj.html()
				,actFlag = $(this).attr('class').indexOf('active')
				,date = $("#choiceYear").val()+$("#choiceMonth").val()+$(this).attr('name')
				,cntNum = $(this).parent().parent().find("[name="+$(this).attr('name')+"]").index($(this));
			date = actFlag > 0?date:null;
			if(confirm("확인: 복사, 취소 : 이동")){
				DATA = {name: $('#name').val()
					,title: title
					,note: ''
					,bsnsRecPrivate: '1'
					,choiceYear: $("#choiceYear").val()
					,choiceMonth: $("#choiceMonth").val()
					,day: $(this).attr('name')
					,rgId: $('#rgstId').val()
					};
				url = "../work/insertBusinessRecord.do";
			}else{
				DATA = {sNb: splitClic[1]
					,name: $("#name").val()
					,tmDt: date/*날짜*/
					,tmpNum1: '0000'+(cntNum<10?'0'+cntNum:cntNum)/*시간*/
					,tmpNum2: cntNum/*같은날짜에 순서 번호*/
					,tmpId: splitThis[0]/*업무내용, 정보정리 구분 ID*/};
				url = "../work/modifyBusinessRecordTmdt.do";
			}
			//console.log($(this).attr('id')+"::"+clickObj.attr('id')); return;
			var fn = function(arg){
				document.getElementById('focus').value=arg;
				document.modifyRec.action = "selectPrivateWorkV.do";
				document.modifyRec.submit();
			};
			if("<c:out value='${baseUserLoginInfo.userName}'/>" == "<c:out value='${workVO.name}'/>" | "<c:out value='${baseUserLoginInfo.permission}' />" > "00019"){
				ajaxModule(DATA,url,fn);
			}
		}
	}).bind('dropend', function(){
		if(notMove===1) return;
		if(clickObj.find('img').attr('title')!=null) return;
		if($(this).attr('id').split('_')[0]==clickObj.attr('id').split('_')[0])
			$(this).removeClass('active');
	});
});

//업무일지 제목 클릭시 내용, 정보정리 회사이름 클릭시 내용
function clkBusiness(e,th){
	/*
	var obj = $(th);
	var t_num = obj.attr('id').split('_');//alert((parseInt(t_num)<100?("0"+t_num):t_num));
	if(t_num[1]=="title") divId = (parseInt(t_num[0])<10?("0"+t_num[0]):t_num[0])+'workPr'+ t_num[2];
	else if(t_num[1]=="cpnNm") divId = (parseInt(t_num[0])<10?("0"+t_num[0]):t_num[0])+'offerPr'+ t_num[2];

	var browserWidth = document.documentElement.clientWidth;
	var calWidth= $("#" + divId).outerWidth();
	var pstn = getPosition();
	var top = pstn.y;
	var left = pstn.x;
	$("#"+divId).css({"top":top,"left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))});
	$("#"+divId).css('display','block');
	$("#"+divId).show();
	 */
	$(".popUpMenu").hide();
	var titleID = $(th).attr('id').split('_')
		,data = {
				sNb: titleID[1],
				rgNm: $("#name").val(),
				day: $(th).attr('name'),
				tmpNum2:$('#pageName').val()
		}, url = "../work/selectBusinessRecord.do"
		 , fn = function(arg){
			$("#offerDiv").html(arg);
			view("workPr",'',e);
		};
	if(titleID[0]==="titleI") url = "../work/selectInside.do";
	ajaxModule(data,url,fn);

	$("#BN").focus();
}

//진행결과 클릭시 셀렉트 태그 나오고, 버튼없어짐
$(document).on("click",'.processResultBtn',function(){
	var obj = $(this).parent();
	obj.next('select').css('display','');
	obj.next('select').attr('multiple',true);
	obj.css('display','none');
});

$(document).on("change",".processResult", function(){
	var obj = $(this);
	var Id = obj.attr('id');
	var snb = Id.split('_');
	//obj.attr('multiple',false);
	var DATA = {sNb: snb[1], process: obj.val()[0]};
	var url = "../work/updatePrecessResult.do";
	var fn = function(){
		document.modifyRec.action = "selectPrivateWorkV.do";
		document.modifyRec.submit();
	};

	ajaxModule(DATA,url,fn);
});
$(document).on("blur",".processResult", function(){
	$(this).css('display','none');
	$(this).parent().children('span').css('display','');
});

//업종 셀렉트 변경시
$(document).on("change","#cpnTYPEcd", function(){
	var obj = $(this);
	$("#AP_cpnTYPE").val(obj.val());
});

//전달 버튼 클릭시 사람들 이름 보이기
$(document).on("click",".pass2P", function(){
	var t_num = $(this).attr('id').split('_');
	$("#privateYN").val($("#"+t_num[0]+"priv"+t_num[2]+"_"+t_num[3]).val());
	$('#memoDay').val(parseInt(t_num[0])<10?("0"+t_num[0]):t_num[0]);
	$('#comment').val($(this).next('input').val());
	view('test',$(this),event);
	// $("#PM_0").focus();
});

//정보정리 팝업을 위한 ajax
function statsOfferdivAjax(e,rgName, th, snb, report){
	var DATA = {
				sNb: snb,
				tmpNum1: "on",
				rgNm: rgName,
				reportYN: report,
				day: $(th).attr('name'),
				dayF: $('#cc_year').val() + '-' + $('#choiceMonth').val() + '-' + $(th).attr('name'),
				tmpNum2:$('#pageName').val()
		}, fn = function(arg){
			$("#offerDiv").html(arg);

			//--------- 정보정리 팝업 default size 변경 20150703 :S -------
			var dvPop = $('#offerPr').get(0);	//div popup
			dvPop.style.width = "750px";
			var obj = $('#txtarea').get(0);		//textarea
			if(obj==undefined) obj = $('#txtarea1').get(0);
			obj.style.width = "720px";
			obj.style.height = "250px";
			//--------- 정보정리 팝업 default size 변경 20150703 :E -------

			view("offerPr",'',e);
		};
	ajaxModule(DATA,"../stats/statsPrivateOffer.do",fn);
}

//인물정보 펼침/숨김
function prsnInfo(th, num) {
	var obj = $(th).parent().parent().parent();
	if(num==0) {
		obj.find('.prsnInfo').css('display','none');
		$(th).html("+ 펼침");
		$(th).attr('onclick',"prsnInfo(this,'1')");
	}
	else{
		obj.find('.prsnInfo').css('display','');
		$(th).html("- 숨김");
		$(th).attr('onclick',"prsnInfo(this,'0')");
	}
}

//업무일지 확장/축소  <-- 현재 사용안함
function viewNote(){
//	$('.t_note').css('display','block');
	$('#s_month').val($('#choiceMonth').val());
	$('#s_year').val($('#choiceYear').val());

	var frm = document.getElementById('staffName');//sender form id
	frm.target = "mainFrame";//target frame name
	frm.submit();
}

var slctWork = function(th,turn){
	var obj = $(th);
	// var select2nd = obj.parent();
	// var select1st = select2nd.find('[class^=work-1stSelect]:eq(0)');
	var select1st = $('.work-1stSelect');
	var popDivli = select1st.parent();
	var popDiv = popDivli.parent();
///init/////////////
/// view
	var slct4 = 	popDiv.find('[id^=CateCd_]');					//유형
	var caldar = 	popDiv.find('[class^=CaliCalendar]');					//달력
	var introD = 	popDiv.find('[id^=IntroDucer]');					//소개창
	var rdoNnI = 	popDiv.find('[id^=slctNnI]');					//신규증액

	var totlPs = 	popDiv.find('[id^=SlctPerson_]');				//사람선택 전체
		// var titlCw = 	popDiv.find('[id^=coworkerTitle_]');			//약속자
		// var btnCw = 	popDiv.find('[id^=selectStaffCstId_]');			//약속자(직원) 선택버튼
		// var titlSp = 	popDiv.find('[id^=support_]');					//공동진행
		// var btnSp = 	popDiv.find('[id^=support_btn_]');				//공동진행(직원) 선택버튼
	var lineSp = 	popDiv.find('[id^=split_]');					//라인분할 <br/>
		var IF1 = 	popDiv.find('[id^=infoProviderTitle1_]');		//정보제공자
		// var IF2 = 	popDiv.find('[id^=infoProviderTitle2_]');		//소개자
		var IF_BT1 = 	popDiv.find('[id^=selectInfoProvider_]');		//정보제공자,소개자 선택버튼


	var totlCpn = 	popDiv.find('[id^=slctCpn_]');					//회사선택 전체
		var CP1 = 	popDiv.find('[id^=cpnTitle1_]');				//회사
		var CP3 = 	popDiv.find('[id^=textTmp_]');					//(물건)
		var valCpnId = 	popDiv.find('[id^=AP_cpnId_]');					//(물건)

	var cpnType = 	popDiv.find('[id^=cpnTYPE]');					//업종

	var lineSp1 = 	popDiv.find('[id^=split1_]');					//라인분할 <br/>

	var totlCst = 	popDiv.find('[id^=slctPrsn_]');					//고객선택 전체
		var CS1 = 	popDiv.find('[id^=cstTitle1_]');				//중개인
		var CS2 = 	popDiv.find('[id^=cstTitle2_]');				//고객
		var CS3 = 	popDiv.find('[id^=cstTitle3_]');				//회사관계자
		var CS4 = 	popDiv.find('[id^=cstTitle4_]');				//정보제공자
		var CS5 = 	popDiv.find('[id^=cstTitle5_]');				//(법인/개인)
		var CS6 = 	popDiv.find('[id^=cstTitle6_]');				//통화자
		var CS7 = 	popDiv.find('[id^=cstTitle7_]');				//소개자

	var totlFile = 	popDiv.find('[id^=fileAdd_]');					//첨부파일 전체
		var RP = 	popDiv.find('[id^=reportYN_]');					//리포트 체크박스

	var RW = 	popDiv.find('[id^=rcmdWorkSpan_]');				//추천인

	var PE = 	popDiv.find('[id^=AP_price]');					//발행규모
	var IP = 	popDiv.find('[id^=AP_investPrice]');			//투자규모

	var titlKp = 	popDiv.find('[id^=KP_title_]');					//핵심체크사항
	var slctKp = 	popDiv.find('[id^=KP_slct_]');					//핵심체크사항 하위메뉴
	var inveKp = 	popDiv.find('[id^=KP_ivstCmnt]');				//핵심체크사항 분석의견

	var txtBox = 	popDiv.find('[id^=txtarea]').parent('li');		//정보정리 텍스트박스

	var titlNw = 	popDiv.find('[id^=personNetwork]');				//인물정보
	var prnNw = 	popDiv.find('[id^=pltPersonNetwork]');			//인물정보 출력
	var btnNw = 	popDiv.parent().find('[class=bsnsR_btn]');		//인물정보 저장버튼

/// init
	var initOfferCd = popDivli.find('[id^=offerCd_]');
	var initMidOfferCd = popDivli.find('[id^=middleOfferCd_]');
	var initCate = 	slct4.find('[id^=categoryCd_]');					//유형초기화
	var initIf1 = 	popDivli.find('[id^=AP_infoProviderId]');				//사람초기화
	var initIf2 = 	popDivli.find('[id^=AP_infoProviderNm]');				//사람선택버튼 초기화
	var initSellBuy = 	slct4.find('[id^=sellBuy]');					//sell buy 초기화
	var initcpnType = 	popDivli.find('[id^=AP_cpnType]');					//업종 초기화
	var initcpnTypeCd = 	popDivli.find('[id^=AP_cpnTYPE]');					//업종 초기화

	var initCpn1 = 	popDiv.find('[id^=AP_cstId_]');				//고객 초기화
	var initCpn2 = 	popDiv.find('[id^=AP_cstNm_]');				//고객버튼 초기화

	var initNw1 = 	popDiv.find('[id^=sltPerNetName]');			//인물정보 선택버튼 초기화
	var initNw2 = 	popDiv.find('[id^=perNetSnb]');				//인물정보 snb 초기화
	var initNw3 = 	popDiv.find('[id^=perNetName]');			//인물정보 이름 초기화

///1stSelect/////////////
	if(turn=='1'){
		popDivli.find('[class^=work-2ndSelect]').css('display','none');
		popDivli.find('[class^=work-3rdSelect]').css('display','none');
		caldar.css('display','none');
		introD.css('display','none');
		rdoNnI.css('display','none');//신규/증액
		RP.css('display','none');//리포트 체크박스
		titlNw.css('display','none');//네트워크
		prnNw.css('display','none');//네트워크 출력
		btnNw.css('display','');//저장버튼
		lineSp.html('');//라인 분할
		lineSp1.html('');//정보 전용 라인 분할

		CP1.css('display','');//회사: cpn

		// rdoNnI.css('display','none');// 신규/증액
		CS1.css('display','none');//중개인
		CS2.css('display','none');//고객
		CS3.css('display','none');//회사관계자
		CS4.css('display','none');//정보제공자
		CS5.css('display','none');// 고객(법인or개인)
		CS6.css('display','none');//통화자
		CS7.css('display','none');//통화자

		totlPs.css('display','');//정보제공자선택
		titlKp.css('display','none');//핵심체크사항
		slctKp.css('display','none');//핵심체크사항
		inveKp.css('display','none');//핵심체크사항

		IF1.css('display','none');//정보제공자
		// IF2.css('display','none');//소개자
		IF_BT1.css('display','none');//정보제공자,소개자 선택버튼
		// titlCw.css('display','none');//약속자(직원)
		// btnCw.css('display','none');//직원선택버튼
		// titlSp.css('display','none');//공동진행(직원)
		// btnSp.css('display','none');//인물선택(직원)

		PE.css('width','500px');//발행규모
		IP.css('display','none');//투자규모

		txtBox.css('display','');//정보정리 내용입력

		initCpn2.html('인물선택');//인물
		initCpn1.val('');//인물
		popDiv.find('[id^=AP_cpnSnb_]').val('');//인물
		popDiv.find('[id^=rcmderSnb_]').val('');//추천인
		RW.css('display','none');//추천인
		cpnType.css('display','none');
		popDivli.find('[class^=work-2ndSelect]:eq(2) > option').removeAttr('selected');
		$('#AP_cpnTYPE').val('00000');

		$("#selectstaffname").hide();

		if('00010'==obj.val()){//딜
			popDivli.find('[class^=work-2ndSelect]:eq(0)').css('display','');
			popDivli.find('[class^=work-3rdSelect]:eq(0)').css('display','');
			slct4.css('display','');
			cpnType.css('display','');
			caldar.css('display','inline-block');
			CP3.css('display','');
			totlCpn.css('display','');

			lineSp.html('<br/>');//라인 분할
			CS1.css('display','');
			totlCst.css('display','');

			PE.css('display','');
			PE.css('width','246px');
			IP.css('display','');
			totlFile.css('display','');
			// titlCw.css('display','');
			// btnCw.css('display','');
			// titlSp.css('display','');
			// btnSp.css('display','');

			initMidOfferCd.val('00001');
			initOfferCd.val('00007');
			popDivli.find('[class^=work-2ndSelect]:eq(0) > option[value=00001]').attr('selected','true');
			popDivli.find('[class^=work-3rdSelect]:eq(0) > option[value=00007]').attr('selected','true');

		} else if('00011'==obj.val()){//자금
			popDivli.find('[class^=work-2ndSelect]:eq(1)').css('display','');
			slct4.css('display','none');
			rdoNnI.css('display','');
			CP3.css('display','none');
			totlCpn.css('display','none');

			CS5.css('display','');
			CS2.css('display','');
			totlCst.css('display','');

			PE.css('display','');
			totlFile.css('display','none');
			// IF2.css('display','');
			// titlSp.css('display','');
			// btnSp.css('display','');

			// titlCw.css('display','');
			// btnCw.css('display','');

			initMidOfferCd.val('00011');
			initOfferCd.val('00000');
			popDivli.find('[class^=work-2ndSelect]:eq(1) > option[value=00011]').attr('selected','true');
			initCate.val('');//유형초기화
			initSellBuy.val('');//sell buy 초기화
			initcpnType.val('');//업종 초기화
			initcpnTypeCd.val('');//업종 초기화
			popDivli.find('[id^=categoryCd_] > option[value=""]').attr('selected','true');

		} else if('00012'==obj.val()){//정보
			popDivli.find('[class^=work-2ndSelect]:eq(2)').css('display','');
			slct4.css('display','none');

			CS6.css('display','');
			totlCst.css('display','');
			CP1.css('display','');
			totlCpn.css('display','');
			PE.css('display','none');
			titlKp.css('display','');
			slctKp.css('display','');
			inveKp.css('display','none');
			totlFile.css('display','');

			//lineSp1.html('<br/>')

			initMidOfferCd.val('00000');
			initOfferCd.val('00009');
			popDivli.find('[class^=work-2ndSelect]:eq(2) > option[value=00009]').attr('selected','true');
			popDiv.find('[id^=categoryCd_]').val('');//유형초기화
			initIf1.val('');//정보제공자초기화
			initIf2.html('인물선택');//정보제공자초기화

		} else if('00013'==obj.val()){//추천
			slct4.css('display','');//유형
			CP3.css('display','');//(물건) 텍스트
			totlCpn.css('display','');//회사선택
			cpnType.css('display','');

			totlCst.css('display','none');//인물선택

			PE.css('display','');//발행규모
			IF1.css('display','');//정보제공자
			IF_BT1.css('display','');//정보제공자선택버튼

			initCpn2.html('인물선택');//회사관계자 초기화
			initCpn1.val('');//회사관계자 초기화

			initMidOfferCd.val('00000');
			initOfferCd.val('00013');
			initCate.val('');//유형초기화
			initSellBuy.val('');//sell buy 초기화
			initcpnType.val('');//업종 초기화
			initcpnTypeCd.val('');//업종 초기화
			initIf1.val('');//정보제공자초기화
			initIf2.html('인물선택');//정보제공자초기화

		} else if('00014'==obj.val()){//인물
			slct4.css('display','none');//유형
			CP3.css('display','none');//(물건) 텍스트
			totlCpn.css('display','none');//회사선택

			totlCst.css('display','none');//인물선택

			totlPs.css('display','none');//정보제공자선택
			PE.css('display','none');//발행규모
			totlFile.css('display','none');//첨부파일
			IF_BT1.css('display','');//정보제공자선택버튼
			txtBox.css('display','none');//정보정리 내용입력

			initNw1.html('인물선택');//인물정보 네트워크 선택 초기화
			initNw2.val('');//인물정보 snb 초기화
			initNw3.val('');//인물정보 이름 초기화

			initCpn2.html('인물선택');//회사관계자 초기화
			initCpn1.val('');//회사관계자 초기화

			initMidOfferCd.val('00000');
			initOfferCd.val('00000');
			initCate.val('');//유형초기화
			initSellBuy.val('');//sell buy 초기화
			initcpnType.val('');//업종 초기화
			initcpnTypeCd.val('');//업종 초기화
			initIf1.val('');//정보제공자초기화
			initIf2.html('인물선택');//정보제공자초기화

			titlNw.css('display','');//네트워크
			prnNw.css('display','');//네트워크 출력
			btnNw.css('display','none');//저장버튼

		} else if('00015'==obj.val()){//신성장
			popDivli.find('[class^=work-2ndSelect]:eq(3)').css('display','');
			popDivli.find('[class^=work-3rdSelect]:eq(1)').css('display','');
			slct4.css('display','none');
			CP3.css('display','none');
			totlCpn.css('display','');

			totlCst.css('display','none');

			// lineSp.html('<br/>');//라인 분할

			totlPs.css('display','none');//정보제공자선택
			PE.css('display','none');//발행규모
			totlFile.css('display','');

			initMidOfferCd.val('00071');//회원사
			initOfferCd.val('00014');//직접섭외
			popDivli.find('[class^=work-2ndSelect]:eq(3) > option[value=00001]').attr('selected','true');
			popDivli.find('[class^=work-3rdSelect]:eq(1) > option[value=00014]').attr('selected','true');


		}popDiv.parent().find('input[id^=foCus_]').focus();

		if('00012'==select1st.val()) RP.css('display','');
///2ndSelect/////////////
	}else if(turn=='2'){
		popDivli.find('[class^=work-2ndSelect]:eq(2) > option[value=00009]').removeAttr('selected');
		popDiv.find('[id^=rcmderSnb_]').val('');//추천인
		RW.css('display','none');//추천인
		lineSp.html('');

		if(select1st.val()=='00012'){//정보
			initMidOfferCd.val('00000');
			initOfferCd.val(obj.val());
			totlPs.css('display','');//정보제공자
			titlKp.css('display','');//핵심체크사항
			slctKp.css('display','');//핵심체크사항
			inveKp.css('display','none');//핵심체크사항
			RP.css('display','none');//리포트 체크박스
			lineSp1.html('');//정보 전용 라인 분할
			CS3.css('display','none');//회사관계자
			CS4.css('display','none');//정보제공자
			CS6.css('display','none');//통화자
			CS7.css('display','none');//통화자
			introD.css('display','none');//소개창
			popDivli.find('[class^=work-3rdSelect]:eq(2)').css('display','none');
			popDivli.find('[class^=work-3rdSelect]:eq(2) > option[value=00001]').attr('selected','true');

			// titlCw.css('display','none');//약속자(직원)
			// btnCw.css('display','none');//약속자선택버튼
			switch(obj.val()){
				case '00002':
				case '00003':
					introD.css('display','');//소개창
					RP.css('display','');//리포트 체크박스
					inveKp.css('display','');//핵심체크사항
					CS3.css('display','');//회사관계자
					totlCpn.css('display','none');//회사선택
					totlCst.css('display','');//인물선택
					valCpnId.val('');//회사id 값 초기화

				break;
				case '00009':
					totlPs.css('display','none');//정보제공자
					RP.css('display','');//리포트 체크박스
					CP1.css('display','');
					totlCpn.css('display','');
					CS6.css('display','');//통화자
					totlCst.css('display','');//인물선택
				break;

				case '00001':
				case '00008':
					introD.css('display','');//소개창
					// titlCw.css('display','');//약속자(직원)
					// btnCw.css('display','');//약속자선택버튼
					totlCpn.css('display','');//회사선택
					totlCst.css('display','');//인물선택
					// lineSp1.html('<br/>')//정보 전용 라인 분할
					CS4.css('display','');//정보제공자
				break;
				case '00004':
					inveKp.css('display','');//핵심체크사항
					// CS3.css('display','');//회사관계자
					totlCst.css('display','none');//인물선택
					totlCpn.css('display','');//회사선택

					initCpn2.html('인물선택');//인물
					initCpn1.val('');//인물
					popDiv.find('[id^=AP_cpnSnb_]').val('');//인물
				break;
				case '00010':
					inveKp.css('display','');//핵심체크사항
					totlCpn.css('display','none');//회사선택
					totlCst.css('display','none');//인물선택
					popDivli.find('[class^=work-3rdSelect]:eq(2)').css('display','');

					initCpn1.val('');//인물
					popDiv.find('[id^=AP_cpnSnb_]').val('');//인물
				break;
				case '00005'://제안서
					totlPs.css('display','none');//정보제공자선택

					titlKp.css('display','none');//핵심체크사항
					slctKp.css('display','none');//핵심체크사항
					totlCpn.css('display','');//회사선택
					totlCst.css('display','none');//인물선택

					initCpn2.html('인물선택');//인물
					initCpn1.val('');//인물
					popDiv.find('[id^=AP_cpnSnb_]').val('');//인물
				break;
			}

		} else {//딜 & 자금 & 신성장
			initMidOfferCd.val(obj.val());
			CP1.css('display','');//회사: cpn
			CS5.css('display','none');// :

			if(obj.val()==1){//딜 -> 중계
				initOfferCd.val('00007');//받은제안
				popDivli.find('[class^=work-3rdSelect]:eq(0) > option[value=00007]').attr('selected','true');

			} else if(obj.val()==2){//딜 -> 직접발굴
				initOfferCd.val('00006');//제안
				popDivli.find('[class^=work-3rdSelect]:eq(0) > option[value=00006]').attr('selected','true');
				RW.css('display','');//추천인

			} else if(obj.val()==3){//딜 -> 유증			//제안중(중개)		// 제안중(니즈)
				initOfferCd.val('00007');
				popDivli.find('[class^=work-3rdSelect]:eq(0) > option[value=00007]').attr('selected','true');

			} else if(obj.val()==71){//신성장 -> 회원사
				totlCst.css('display','none');
				initOfferCd.val('00014');//직접섭외
				popDivli.find('[class^=work-3rdSelect]:eq(1) > option[value=00014]').attr('selected','true');

			} else if(obj.val()==72){//신성장 -> 주주사
				totlCst.css('display','none');
				initOfferCd.val('00014');//직접섭외
				popDivli.find('[class^=work-3rdSelect]:eq(1) > option[value=00014]').attr('selected','true');

			} else {//자금

				initOfferCd.val('00000');

				if(obj.val()==5){	//딜 -> 제안중(직접발굴)
					RW.css('display','');//추천인

				}else if(obj.val()==11){//자금 -> 일임계약
					lineSp.html('<br/>');//라인 분할
					rdoNnI.css('display','');//신규/증액
					CP3.css('display','none');//(물건) 텍스트
					totlCpn.css('display','none');//회사선택
					CP1.css('display','none');//회사: cpn
					CS2.css('display','');// :
					CS5.css('display','');// :

				}else if(obj.val()==12){//자금 -> 재매각
					rdoNnI.css('display','none');//신규/증액
					CP3.css('display','');//(물건) 텍스트
					totlCpn.css('display','');//회사선택
					popDiv.find('[id^=cstTitle2_] ').css('display','');// :

				}else if(obj.val()==13){//자금 -> 펀드
					lineSp.html('<br/>');//라인 분할
					rdoNnI.css('display','none');//신규/증액
					CP3.css('display','none');//(물건) 텍스트
					totlCpn.css('display','none');//회사선택
					CP1.css('display','none');//회사: cpn
					CS2.css('display','');// :
					CS5.css('display','');// :
				}
			}
		}
///3rdSelect/////////////
	}else if(turn=='3'){
		var select2nd = $('.work-2ndSelect:eq(2) option:selected');
		if(select2nd.val()=='00010'){
			$('#AP_cpnTYPE').val(obj.val());
		}else{
			initOfferCd.val(obj.val());
			if(obj.val()==14){
				totlCst.css('display','none');

			}else if(obj.val()==15){
				totlCst.css('display','');
				CS7.css('display','');
			}
		}
	}
};

//정보정리 유형 선택시
$(document).on("change",'#categoryCd_',function(){
	var obj = $(this);
	var li = obj.parent().parent();
	var direct = obj.parent().parent().find('[class^=work-2ndSelect]:eq(0) > option[value=00002]').attr('selected');
	var deal = obj.parent().parent().find('[class^=work-1stSelect]:eq(0) > option[value=00010]').attr('selected');
	if(!deal) return;
	li.find('[id^=cpnTYPE]').css('display','none');
	$("#totalValue").css('display','none');
	$("#totalMarketValue").val('');
	//프리IPO & M&A 선택하면 업종 노출
	if(obj.val()==='00008' || obj.val()==='00012'){//8: mna, 12: 프리IPO
		li.find('[id^=cpnTYPE]').css('display','');
		if(obj.val()==='00012')
			$("#totalValue").css('display','');
	}
	//기업검토 선택시
	if(direct){
		if(obj.val()==='00014'){//기업검토
			//obj.parent().parent().find('[class^=work-2ndSelect]:eq(0) > option[value=00002]').attr('selected','true');
			//obj.parent().parent().find('[class^=work-3rdSelect]:eq(0) > option[value=00006]').attr('selected','true');
			li.find('[id^=sellBuy]').css('display','none');
			li.find('[id^=cpnTYPE]').css('display','none');
			li.find('[id^=slctPrsn_]').css('display','none');
			li.find('[id^=rcmdWorkSpan_]').css('display','none');//추천인
			li.next().find('[id^=AP_price]').css('display','none');
			li.next().find('[id^=AP_investPrice]').css('display','none');
		}else{
			li.find('[id^=sellBuy]').css('display','');
			li.find('[id^=slctPrsn_]').css('display','');
			li.find('[id^=rcmdWorkSpan_]').css('display','');//추천인
			li.next().find('[id^=AP_price]').css('display','');
			li.next().find('[id^=AP_investPrice]').css('display','');
		}
	}else{
		li.find('[id^=sellBuy]').css('display','');
		li.next().find('[id^=AP_price]').css('display','');
		li.next().find('[id^=AP_investPrice]').css('display','');

	}
});

//정보정리 핵심체크에서 체크박스 클릭시
$(document).on("click",'.input_chk',function(){
	var obj = $(this);
	// var num = obj.attr('id').split('0');
	if(obj.is(':checked') == true){
		jQuery.each('', function(){
			obj.attr('checked','checked');
			// $('#kyPoint0'+num[1]).attr('disabled','disabled');
		});
	} else {
		jQuery.each('', function(){
			obj.attr('checked','');
			// $('#kyPoint0'+num[1]).attr('disabled','');
			obj.parent().parent().find('[id^=kyPoint0]').attr('disabled','');
		});
			// $('#kyPoint0'+num[1]).attr('disabled','');
	}
});


//정보정리 내용 수정
$(document).on("click",'.offerR_btnOk',function(){

	var obj = $(this).parent().parent().parent();
	var getSnb = obj.find('[id^=offerSnb]').val();
	var middleoffercd = obj.find('[id^=middleOfferCd]').val();
	var getOffercd = obj.find('[id^=offerCd]').val();
	var getCpnName = obj.find('[id^=AP_cpnNm]').html();
	var getCstId = obj.find('[id^=AP_cstId]').val();
	var getCpnId = obj.find('[id^=AP_cpnId]').val();
	var getPrice = obj.find('[id^=AP_price]').val();
	var getInvestPrice = obj.find('[id^=AP_investPrice]').val();
	var getInfoprovider = obj.find('[id^=AP_infoProviderId]').val();
	var getCoworker = obj.find('[id^=AP_coworkerId]').val();
	var getSupporter = obj.find('[id^=AP_supporterId]').val();
	var getSupporterRatio = obj.find('[id^=AP_supporterRatio]').val();
	var getSupporterText = obj.find('[id^=AP_supporterText]').val();
	var notNullSupporter = (getSupporter.is_null())?0:getSupporter;
	var getCategoryCd = obj.find('[id^=categoryCd]').val();
	var getSellBuy = obj.find('[id^=sellBuy]').val();
	var getCpnType = obj.find('[id^=AP_cpnType]').val();
	var getCpnTypeCd = obj.find('[id^=AP_cpnTYPE]').val();
	var getRcmderSnb = obj.find('[id^=rcmderSnb]').val();		//추천인
	var getMemo = obj.find('[id^=txtarea]').val();
	var getEntrust = '';
	var getCpnCst = '';
	var getDueDay= obj.find('[id^=iCal]').val();


	var infoLevel = $('#infoLevel').val();		//정보공개등급


	// if((getOffercd>00003 && getOffercd<00006)||getOffercd==00013){
		// if(""==getCpnName || "회사선택"==getCpnName) {alert("회사/사람을 선택하지 않았습니다.\n선택 후 저장하세요.");return;}

	// } else if(getOffercd<00004||getOffercd>00005){
		// if(0==getCstId) {alert("회사/사람을 선택하지 않았습니다.\n선택 후 저장하세요.");return;}

	// }

	switch(getOffercd){
	case '00002':
	case '00003':
	case '00008':
	case '00009':
		if(0==getCstId) {alert("인물을 선택해 주세요.");return;}
		break;

	case '00006':
		if(""==getCategoryCd){alert("유형을 선택해주세요.");return;}
		if("00014"!=getCategoryCd && ""==getRcmderSnb){alert("추천인을 (지정 or 지정취소) 해주세요.");return;}
	case '00004':
	case '00005':
	case '00013':
	case '00014':
		if(""==getCpnName || "회사선택"==getCpnName) {alert("회사를 선택해 주세요.");return;}
		break;

	case '00007':
		if(""==getCategoryCd){alert("유형을 선택해주세요.");return;}
		if(""==getCpnName || "회사선택"==getCpnName) {alert("회사를 선택해 주세요.");return;}
	case '00001':
		if(0==getCstId && (""==getCpnName || "회사선택"==getCpnName)) {alert("회사/인물을 선택해 주세요.");return;}
		break;

	case '00015':
		if(0==getCstId || (""==getCpnName || "회사선택"==getCpnName)) {alert("회사/인물을 선택해 주세요.");return;}
		break;
	}

	switch(middleoffercd){
		case '00005':
			if(getRcmderSnb == "") {alert("추천인(추천종목)을 선택(or 지정취소)해 주세요!");return;}
			if(""==getCpnName || "회사선택"==getCpnName) {alert("회사를 선택해 주세요!");return;}
			break;

		case '00011':
			getEntrust = obj.find('[name^=NnI]:checked').val();
			getCpnCst = obj.find('[name^=CnP]:checked').val();
		case '00012':
			if(0==getCstId) {alert("인물을 선택해 주세요.");return;}
		break;
	}

	if(""==getRcmderSnb) getRcmderSnb=0;

	if(getCategoryCd=='00012'){
		var tmv = $("#totalMarketValue").val();
		if(tmv=='' || tmv==0){
			alert("매매가기준 시가총액을 입력하세요.");
			$("#totalMarketValue").focus();
			return;
		}else if(tmv==undefined){
		}else{
			getMemo = '시가총액: '+tmv+'억\n'+getMemo;
		}
	}

	var price = "";
	var investPrice = "";
	if(getPrice!="발행규모"&&getPrice!=" 발행규모 : ") price = getPrice;
	if(getInvestPrice!="투자규모"&&getInvestPrice!=" 투자규모 : ") investPrice = getInvestPrice;

	// if((obj.find('[id^=chk01_]').is(':checked')==false)&(obj.find('[id^=chk02_]').is(':checked')==false)&(obj.find('[id^=chk03_]').is(':checked')==false)&(obj.find('[id^=chk04_]').is(':checked')==false)) alert("핵심사항체크 및 내용을 입력하세요."); return;


	//핵심체크사항 - 분석의견 을 등록하려는 경우 필수요소 체크 20160106
	if(obj.find('[id^=chk08_0]').is(':checked') == true){		//분석의견 체크박스를 체크했을때
		if(obj.find('[id^=chkStar_]').val().length == 0){		//별 선택을 안했을 경우
			alert("분석의견의 별을 입력하세요!");
			return;
		}

		if(obj.find('[name=expirationDate]:checked').val()==undefined){	//분석 유효기간 입력을 안했을 경우
			alert("분석 유효기간을 선택하세요!");
			return;
		}

		var cntnt = obj.find('[id^=kyPoint08]');
		if(cntnt.val().trim()==''){		//분석내용 입력을 안했을 경우
			alert("분석내용을 입력하세요!");
			cntnt.focus();
			return;
		}
	}


	if(confirm("적용하시겠습니까?")){
		obj.hide();//ajax 보내면서 delay발생으로 저장을 여러번 클릭하는 문제로 div 화면상에서 hide
		var keyPstar = "";
		var expirationDt = "";
		var keyPnum = ""
			,keyP = "";
		var keyPsnbNum = ""
			,keyPsnb = "";

		// var lengChkBox = obj.find('[id^=chk]').length
		var lengChkBox = 10		//$('#kyPmaxLeng').val()
			,lengChkedBox = obj.find('[id^=chk]:checked').length
			,lengModi = obj.find('[id^=kyPointSnb]').length
			,curNumModi = 1
			,curNumChk = 1
			,curSnb = '';

		for(var i=1, numChkBox = 1; i<lengChkBox; i++){
			numChkBox = i<10?'0'+i:i;
			if(obj.find('[id^=chk'+numChkBox+']').is(':checked') == true){
				keyPnum += i;
				keyP += obj.find('[id^=kyPoint'+numChkBox+']').val().replace(/,/g,"，");
				if(i==8) {
					keyPstar = obj.find('[id^=chkStar_]').val();
					expirationDt = obj.find('[name=expirationDate]:checked').val();
				}
				if((curNumChk++)<lengChkedBox) {
					keyPnum+=',';
					keyP+=',';
				}
			}
			curSnb = obj.find('[id^=kyPointSnb'+numChkBox+']').val();
			if( undefined!=curSnb && ''!=curSnb ){
				keyPsnbNum += i;
				keyPsnb += curSnb;
				if((curNumModi++)<lengModi) {
					keyPsnbNum+=',';
					keyPsnb+=',';
				}
			}
		}

		var day = obj.find('[id^=DaY]').val();
		day = parseInt(day)<10?('0'+day):day;
		if(day.length===3) day = day.substring(1,3);

		if(getSnb==""){//새로 입력하기
			$.ajax({
				type:"POST",        //POST GET
				url:"../work/insertDeal.do",     //PAGEURL
				data : ({
						cpnId: getCpnId,
						//cpnNm: obj.find('[id^=AP_cpnNm]').html(),
						cstId: getCstId,
						cstNm: obj.find('[id^=AP_cstNm]').html(),
						price: price,
						investPrice: investPrice,
						entrust: getEntrust,
						cpnCst: getCpnCst,
						memo: getMemo,
						middleOfferCd: middleoffercd,
						offerCd: getOffercd,
						categoryCd: getCategoryCd,
						choiceYear: $('#choiceYear').val(),
						choiceMonth: $('#choiceMonth').val(),
						day: day,
						rgId: $('#rgstId').val(),
						rgNm: $('#loginName').val(),
						keyPmax: lengChkBox,
						keyP: keyP,
						keyPnum: keyPnum,
						star: keyPstar,
						expirationDt: expirationDt,			//유효기간 3,6,9,12,24 개월	20160105
						infoProvider: getInfoprovider,
						coworker: getCoworker,
						rcmdSnb: getRcmderSnb,
						supporter: notNullSupporter,
						supporterRatio: getSupporterRatio,
						supporterText: getSupporterText,
						sellBuy: getSellBuy,
						cpnType: getCpnType,
						cpnTypeCd: getCpnTypeCd,
						dueDt : getDueDay,

						infoLevel: infoLevel		//정보공개등급	20160503

						}),
				timeout : 30000,       //제한시간 지정
				cache : false,        //true, false
				success: function whenSuccess(arg){  //SUCCESS FUNCTION
//						$(obj).hide();
					document.getElementById('focus').value=arg;
					document.modifyRec.action = "selectPrivateWorkV.do";
					document.modifyRec.submit();
				},
				error: function whenError(x,e){    //ERROR FUNCTION
					ajaxErrorAlert(x,e);
				}
			});
		}else{//입력된 내용 수정하기
			$.ajax({
				type:"POST",        //POST GET
				url:"../work/modifyDeal.do",     //PAGEURL
				//  dataType: "html",       //HTML XML SCRIPT JSON

				data : ({sNb: getSnb,
						cpnId: getCpnId,
						cpnSnb: obj.find('[id^=AP_cpnSnb]').val(),
						//cpnNm: obj.find('[id^=AP_cpnNm]').html(),
						cstId: getCstId,
						cstNm: obj.find('[id^=AP_cstNm]').html() +" ; "+ obj.find('[id^=AP_cstNm]').attr('title'),
						price: price,
						investPrice: investPrice,
						entrust: getEntrust,
						cpnCst: getCpnCst,
						prevCpnCst: obj.find('[id^=prevCpnCst]').val(),
						day: day,
						memo: getMemo,
						middleOfferCd: middleoffercd,
						offerCd: getOffercd,
						categoryCd: getCategoryCd,
						rgId: $('#rgstId').val(),
						rgNm: $('#loginName').val(),
						keyPmax: lengChkBox,
						keyP: keyP,
						keyPnum: keyPnum,
						keyPsnb: keyPsnb,
						keyPsnbNum: keyPsnbNum,
						star: keyPstar,
						expirationDt: expirationDt,			//유효기간 3,6,9,12,24 개월	20160105
						infoProvider: getInfoprovider,
						coworker: getCoworker,
						//rcmdSnb: getRcmderSnb,
						supporter: notNullSupporter,
						supporterRatio: getSupporterRatio,
						supporterText: getSupporterText,
						sellBuy: getSellBuy,
						cpnType: getCpnType,
						cpnTypeCd: getCpnTypeCd,
						dueDt : getDueDay,

						infoLevel: infoLevel		//정보공개등급	20160503

						}),
				timeout : 30000,       //제한시간 지정
				cache : false,        //true, false
				success: function whenSuccess(arg){  //SUCCESS FUNCTION
//					alert(<c:out value='${message}'/>);
					if($('#pageName').val()=='reply') document.comment.submit();
					document.getElementById('focus').value=arg;
					document.modifyRec.action = "selectPrivateWorkV.do";
					document.modifyRec.submit();
				},
				error: function whenError(x,e){    //ERROR FUNCTION
					ajaxErrorAlert(x,e);
				}
			});
		}
	}
	else {
		//$(".popUpMenu").hide();
	}
});


//정보정리 내용 삭제
$(document).on("click",".offerR_btnDel",function(){
	if(confirm("DB에서 완전삭제 처리됩니다. \n삭제하시겠습니까?")){
		var obj = $(this).parent().parent().parent();
		var day = obj.find('[id^=DaY]').val();
		day = parseInt(day)<10?('0'+day):day;
		if(day.length===3) day = day.substring(1,3);

		var data = {
				sNb: obj.find('[id^=offerSnb]').val()
				,cstId: obj.find('[id^=AP_cstId]').val()
				,entrust: obj.find('[name^=NnI]:checked').val()
				,focus: day
			},fn = function(arg){
				document.getElementById('focus').value=arg;
				document.modifyRec.action = "selectPrivateWorkV.do";
				document.modifyRec.submit();
			}
		ajaxModule(data,"../work/deleteOffer.do",fn);
	}
});


//업무일지 내용수정 확인
$(document).on("click",'.bsnsR_btnOk', function(){
	var obj = $(this).parent().parent().parent();
	var txtTitle = obj.find('[id^=txt]').val()==="제목"?"":obj.find('[id^=txt]').val();
	if(txtTitle.is_null()){
		alert("제목을 입력하지 않았습니다.\n제목을 입력하세요.");
		return;
	}
	obj.hide();
	var NOtE = obj.find('[id^=txtarea]').val();
	if(NOtE=='일지를 입력하세요.') NOtE = '';

	var fn = function(arg){
		document.getElementById('focus').value=arg;
		document.modifyRec.action = "selectPrivateWorkV.do";
		document.modifyRec.submit();
	};
	var day = obj.find('[id^=DaY]').val();
	day = parseInt(day)<10?('0'+day):day;
	if(day.length===3) day = day.substring(1,3);
	if(obj.find('[id^=bsnsRecSNb]').val()==""){//새로 입력하기
		var DATA = {name: $('#loginName').val(),
					staffSnb : sNb,
					title: obj.find('[id^=txt]').val(),
					note: NOtE,
					bsnsRecPrivate: obj.find('[id^=bsnsRecPriv]').val(),
					choiceYear: $('#choiceYear').val(),
					choiceMonth: $('#choiceMonth').val(),
					day: day,
					rgId: $('#rgstId').val()
					};
		var url = "../work/insertBusinessRecord.do";
		ajaxModule(DATA,url,fn);

	}else{//입력된 내용 수정하기
		var DATA = {sNb: obj.find('[id^=bsnsRecSNb]').val(),
					title: obj.find('[id^=txt]').val(),
					note: NOtE,
					bsnsRecPrivate: obj.find('[id^=bsnsRecPriv]').val(),
					day: day,
					rgId: $('#rgstId').val()
					};
		var url = "../work/modifyBusinessRecord.do";
		ajaxModule(DATA,url,fn);
	}
});

//업무일지 내용 삭제
$(document).on("click",".bsnsR_btnDel",function(){
	if(confirm("DB에서 완전삭제 처리됩니다. \n삭제하시겠습니까?")){
		var obj = $(this).parent().parent().parent();
		var day = obj.find('[id^=DaY]').val();
		day = parseInt(day)<10?('0'+day):day;
		if(day.length===3) day = day.substring(1,3);

		var data = {
				sNb:obj.find('[id^=bsnsRecSNb]').val()
				,focus:day
					}
			,fn = function(arg){
				document.getElementById('focus').value=arg;
				document.modifyRec.action = "selectPrivateWorkV.do";
				document.modifyRec.submit();
			};
		ajaxModule(data,"../work/deleteBusinessRecord.do",fn);
	} else {
		$(".popUpMenu").hide();
	}
});


//메모에서 전체체크
function selectAllforSndMemo(num){
	var checkboxs = $('.popUpMenu input:checkbox').not('#chkSmsSend');
	var allCheck = $('.popUpMenu .allCheck a');
	if(num==0) {
		checkboxs.attr('checked',true);
		allCheck.attr('onclick','selectAllforSndMemo("1")');
	} else if(num==1) {
		checkboxs.attr('checked',false);
		allCheck.attr('onclick','selectAllforSndMemo("0")');
	}
}


//메모에서 전체체크
function selectAllforSndMemoDivName(obj,num,divName){

	var checkboxs = $('#'+divName+' input:checkbox').not('#chkSmsSend');
	var allCheck = $(obj);
	if(num==0) {
		checkboxs.attr('checked',true);
		allCheck.attr('onclick','selectAllforSndMemoDivName(this,1,\''+divName+'\')');
	} else if(num==1) {
		checkboxs.attr('checked',false);
		allCheck.attr('onclick','selectAllforSndMemoDivName(this,0,\''+divName+'\')');
	}
}
function memoSnd(url,th,sms){// 메모 전달하기
	if(confirm("전달하시겠습니까?")){
		var obj = $(th).parent().parent();
		obj.hide();
		$("#sttsCd").val('00001');
		$("#SMSTitle").val(sms);
		var frm = document.modifyRec;
		frm.action = url;
		frm.submit();
	}
}


//정보정리 분석의견 별선택
function slctStar(th){
	var obj = $(th)
		,curNum = obj.attr('id').split('e')[1];
	for(var i=0; i<curNum; i++){
		obj.parent().find('[id^=file'+(i+1)+']').attr('src','../images/figure/star_y.png');
	}for(;i<6;i++){
		obj.parent().find('[id^=file'+(i+1)+']').attr('src','../images/figure/star_g.png');
	}
	obj.parent().parent().find('[id^=chkStar]').val(curNum);
}

//공동진행
/*
function saveStaffName(htmlId,inputId,swit){
	var chbox = $(".chbox0:checked");
	var num = $("#infoDivCnt").val();
	$("#"+htmlId+num).html(chbox.val());

	var staffNum = chbox.attr('id').split('_')[1];
	var cstSnb = $("#staffCstId"+staffNum).val();
	if(swit=='1'|swit=='3') $("#AP_supporterText"+num).val($("#slctStaffText").children().val());
	$("#"+inputId+num).val(cstSnb);
	$("#selectstaffname").hide();
}*/
function saveStaffName(htmlId,inputId,swit){
	var chbox = $(".chbox0:checked");
	var num = $("#infoDivCnt").val();
	$("#"+htmlId+num).html(chbox.val());

	var staffNum = chbox.attr('id').split('_')[1];
	var cstSnb = $("#staffCstId"+staffNum).val();
	if(swit=='1'|swit=='3'){
		$("#AP_supporterText"+num).val($("#slctStaffText").children().val());
		$("#AP_supporterRatio"+num).val($("#supporterRatio").val());
	}
	$("#"+inputId+num).val(cstSnb);
	$("#selectstaffname").hide();
}

function cancleStaffName(htmlId,inputId){
	var num = $("#infoDivCnt").val();
	$("#"+htmlId+num).html('인물선택');

	$("#"+inputId+num).val('');
	$("#selectstaffname").hide();
}


function getPosition(e) {
   e = e || window.event;
   var cursor = {x:0, y:0};
   if (e.pageX || e.pageY) {
       cursor.x = e.pageX;
       cursor.y = e.pageY;
   }
   else {
       cursor.x = e.clientX +
           (document.documentElement.scrollLeft ||
           document.body.scrollLeft) -
           document.documentElement.clientLeft;
       cursor.y = e.clientY +
           (document.documentElement.scrollTop ||
           document.body.scrollTop) -
           document.documentElement.clientTop;
   }
   return cursor;
}

function slctStaff(th,cnt,htmlID,inputID,swit){
	var divId = "selectstaffname";
	if(swit==''|swit==null){
		$("#"+divId).css('width','77px');
		$("#slctStaffRdo").css('float','');
		$("#slctStaffText").css('display','none');
		$("#saveBTN").attr('onclick',"saveStaffName('"+htmlID+"','"+inputID+"')");
		$("#cancleBTN").attr('onclick',"cancleStaffName('"+htmlID+"','"+inputID+"')");
	} else {
		$("#"+divId).css('width','277px');
		$("#slctStaffRdo").css('float','left');
		$("#slctStaffText").css('display','');
		$("#saveBTN").attr('onclick',"saveStaffName('"+htmlID+"','"+inputID+"','"+swit+"')");
		$("#cancleBTN").attr('onclick',"cancleStaffName('"+htmlID+"','"+inputID+"','"+swit+"')");

		if(swit=='3') $("#slctStaffText").children().val($("#AP_supporterText"+cnt).val());
	}
	var browserWidth = document.documentElement.clientWidth;
	var calWidth= $("#" + divId).outerWidth();
	var pstn = getPosition();
	var top = pstn.y;
	var left = pstn.x;
	$("#"+divId).css({"top":top,"left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))});
	$("#"+divId).css('display','block');
	$("#"+divId).show();
	$(".chbox0").removeAttr('checked');

	$("#infoDivCnt").val(cnt);//약속자 div 아래 saveStaffName의 num를 위함
	$("#SSN_0").focus();
}

function view(divId,th,e){ //divId : 보여주기위한 target divId
	var browserWidth = document.documentElement.clientWidth
	   ,browserHeight = document.documentElement.clientHeight;
	var calWidth= $("#" + divId).outerWidth()
	   ,calHeight= $("#" + divId).outerHeight();
	var pstn = getPosition(e)
	    ,top = pstn.y
	    ,left = pstn.x;
	// console.log('browserHeight:'+browserHeight);
	// console.log('top:'+top);
	// console.log('browserTop:'+e.clientY);
	// console.log('calHeight:'+calHeight);
	var rtnTop = e.clientY<calHeight?top:top-(calHeight+5);
	$("#"+divId).css({"top":(e.clientY+calHeight<browserHeight?top:rtnTop)+"px","left":(left+calWidth<browserWidth?left:0)+"px"});
	//$("#"+divId).css({"top":(e.clientY+calHeight<browserHeight?top:rtnTop)+"px","left":(left+calWidth<browserWidth?left:browserWidth - calWidth)+"px"});	//left:browserWidth-(calWidth+8))+"px"});  20160106
	$("#"+divId).css('display','block');
	$(".popUpMenu").hide();
	$("#"+divId).show();
}
/*
function view(divId,th,e){ //divId : 보여주기위한 target divId
	var browserWidth = document.documentElement.clientWidth;
	var calWidth= $("#" + divId).outerWidth();
	var pstn = getPosition(e);
	var top = pstn.y;
	var left = pstn.x;
	$("#"+divId).css({"top":top+"px","left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))+"px"});
	$("#"+divId).css('display','block');
	$(".popUpMenu").hide();
	$("#"+divId).show();
}
*/

function chkBoxViewTextarea(th){
	var obj = $(th);
	var objId = obj.attr('id');
	var objNum = objId.split('chk')[1];
	var textArea = $("#kyPoint"+objNum);
	if(obj.attr('checked')) textArea.css('display','');
	else textArea.css('display','none');
}

function switchIbIns(flag){
		$('.bsns').show();
	if(flag==='ib'){
		$('.inside').hide();
	} else if (flag==='ins'){
		$('.bsns').hide();
		$('.inside').show();
	}
}

function checkReportYN(th){
	var obj = $(th)
	, data;
	if(obj.is(':checked')){
		data = {sNb:$('#offerSnb').val(),reportYN:'Y'};
	}else{
		data = {sNb:$('#offerSnb').val(),reportYN:'N'};
	}
	$.ajax({
		type:"POST",        //POST GET
		url:"../work/updateFileInfoCheckReport.do",     //PAGEURL
		data : data,
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		timeout : 30000,       //제한시간 지정
		cache : false
	});
}