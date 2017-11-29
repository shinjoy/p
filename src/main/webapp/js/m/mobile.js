

/*
 * mobile.js
 * 
 * 
 * 
 * 
 */



////////z-index 는 jsp페이지에 글로벌 변수로 갖고있는다.(g_divZidx)
function createBackDiv(g_divZidx){
	//현재 z-index 의 뒤라는 표시로 아이디값에 z-index -1  을 세팅한다.

	
	$("body", document).append("<div id='backgroundDiv_"+(g_divZidx)+"' class='modalMask' style='z-index:"+(g_divZidx)+";height:" + $(document).height() + "px;'>");		
		
}

function closeDiv(obj){
	$("#"+obj).css("display","none");
	$("#"+obj).empty();
	$("#backgroundDiv_"+(g_divZidx)).remove();
	g_divZidx=g_divZidx-1;
}

function zIdxChk(){ //z-index 가 - 일때 초기화 시킨다.
	if(g_divZidx == 0){ 
			g_divZidx = 1;
	}
	g_divZidx=g_divZidx+1; //현재 z-index 를 증가시켜 맨앞으로 세팅한다.
}

//----------------------------------------- 인물 회사 팝업 : S

/////ajax div 세팅 인물. 회사.
function commonComORCusPop(pageNum,nm,flag,divName){ //페이지번호, 숫자, 인물 회사구분
var url = contextRoot+'/work/popUpCpnDiv.do';
var modalTitleNm = '회사검색';

if(flag == 'iP'){//인물이면
	url = contextRoot+'/work/popUpCstDiv.do';
	modalTitleNm = '인물검색';
}

var params = {f: flag,modalFlag: flag,nm :nm};


commonModal(url,params,divName,modalTitleNm,g_divZidx,'N');
if(flag =='iP') $('#nameSearch').val("");

}

//ajax paging 처리를 이용한 리스트(인물,회사) 가져오기.
function getPagingList(frm,pageIndex,num,flag){ //폼,페이지 번호 flag:c 회사 iP 인물
var sUrl = '';
var Nm =$('#nameSearch').val();
var NmKor=$('#nameSearch').val();

if(Nm!=undefined){ 
	NmKor=engTypeToKor(Nm);
} 
var param = {};

if(flag=='iP'){//인물
	sUrl = "work/popUpCstAjax.do";
	sUrl+='?f='+flag+'&n='+num+'&pageIndex='+pageIndex;
	param.cstNm = Nm;
	param.cstNmKor = NmKor;
	param.modalFlag = flag;
}else{ //회사
	
	flag = $("#modalFlag").val();
	Nm =$('#nameSearch2').val();
	sUrl = "work/popUpCpnAjax.do";
	sUrl+='?f='+flag+'&n='+num+'&fromInside=y&pageIndex='+pageIndex;
	param.cpnNm = Nm;
	param.modalFlag = flag;
}

var callback = function(json){
	var obj = JSON.parse(json);
	var list = obj.searchList;
	var paging = obj.paging;
	var MDf = obj.MDf;
	var MDn = obj.MDn;
	
	if(flag=='iP') { //인물
		setPersonPop(list,paging);
		
	}else{//회사
		
		$("#modalFlag").val(MDf);
		setCompanyPop(list,paging,flag); 
	}
	
	
};

commonAjax("POST", sUrl, param, callback, false, null, null);

}

//리스트에서 클릭시 이벤트. 
function end(nm,snb,cpnId,cpnNm,position,cpnSnb,MDf,MDn){
///인물 cstId,cstNm,cpnId,cpnNm,position,cpnSnb
///회사 cpnNm,cpnId,'','','',cpnSnb

var rVal = new Object();
if(MDf == 'iP'){ ///인물 선택인데
	if(cpnId.length==0 || cpnId=='null'){ //회사가 없다면.
		if(!confirm("회사가 없는 사람은 선택할 수 없습니다.\n회사를 등록하시겠습니까?")){
			return ;
		}
		registPerCom('iP','0',snb);
		return;
	}
}
	
rVal.f = MDf ;
rVal.n = MDn ;
rVal.nm = nm;
rVal.snb = snb;
rVal.cpnId = cpnId;
rVal.cpnNm = cpnNm;
rVal.position = position;
rVal.cpnSnb = cpnSnb;

if(MDf!='iPc'){
	returnPopUp(rVal);
}else{
	returnReg(rVal);
}

};


//인물 화면 세팅
function setPersonPop(list,paging){ //ajax 로 가져온 리스트와, 페이징 처리 html 
	
var str='<table class="pop_tb_basic" >';
str+='		<thead>';
str+='			<tr>';
str+='				<th scope="col">이름</th>';
str+='				<th scope="col">회사</th>';
str+='				<th scope="col">직위</th>';
str+='			</tr>';
str+='		</thead>';
str+='		<tbody>';
for(var i = 0; i<list.length;i++){
	str+='			<tr  name="result_searched'+i+'" class="link" onclick="end(\''+list[i].cstNm+'\',\''+list[i].sNb +'\',\''+list[i].cpnId+'\',\''+list[i].cpnNm+'\',\''+list[i].position+'\',\''+list[i].cpnSnb+'\',\'iP\',\'0\');">';
	str+='				<th scope="row">'+list[i].cstNm+'</th>';

	if(list[i].cpnNm == null){
		str+='				<td> </td>';
	}else{
		str+='				<td>'+list[i].cpnNm+'</td>';
	}
	str+='				<td>'+list[i].position+'</td>';
	str+='			</tr>';	 
}
str+='		</tbody>';
str+='	</table>';
if(list.length>0){//페이징
	str+='<br/>';
	str+='<div align="center">'+paging+'</div>';
}
$("#searchPerson").html(str);
$("#personlistCnt").val(list.length);
}

//회사 화면 세팅
function setCompanyPop(list,paging,f){ //ajax 로 가져온 리스트와, 페이징 처리 html 



var str='<table class="pop_tb_basic" >';
str+='		<thead>';
str+='			<tr>';
str+='				<th scope="col">법인명</th>';
str+='				<th scope="col">코드</th>';
str+='			</tr>';
str+='		</thead>';
str+='		<tbody>';
for(var i = 0; i<list.length;i++){
	str+='			<tr  name="result_searched'+i+'" class="link" onclick="end(\''+list[i].cpnNm+'\',\''+list[i].cpnId +'\',\'\',\'\',\'\',\''+list[i].cpnSnb+'\',\''+f+'\',\'0\');">';
	str+='				<th scope="row"><b>'+list[i].cpnNm+'</b></th>';
	str+='				<td>'+list[i].aCpnId+'</td>';
	str+='			</tr>';	 
}
str+='		</tbody>';
str+='	</table>';

if(list.length>0){ //페이징
	str+='<br/>';
	str+='<div align="center">'+paging+'</div>';
}

$("#searchCompany").html(str);

}

//등록 팝업
function registPerCom(flag,nm,sNb){
	
var name ;
var url ;
var params = {flag: flag,nm:nm};
var cnt ='';
var divName = 'new_company_pool_Wrap';
var modalTitleNm = '회사등록';

if(flag == 'iP'){//인물이면
	name =$('#nameSearch').val(); //검색창에 입력값
	cnt=$("#personlistCnt").val(); //검색한 리스트 갯수
	params.cstNm =$('#nameSearch').val(); //이름 세팅
	params.searchCstNm =$('#nameSearch').val();
	if(name != '' && cnt != 0){
		params.cstNm =$('#nameSearch').val()+cnt; //이름+cnt세팅
		params.searchCstNm =$('#nameSearch').val()+cnt;
	}
	params.sNb =sNb;
	url = contextRoot+'/m/popRegistCst.do';
	divName = 'people_newregi_Wrap';
	modalTitleNm = '인물등록';
	
}else{
	name =$('#nameSearch2').val();
	url = contextRoot+'/m/popRegistCpn.do';
	params.searchCpnNm =name; ///검색창 입력값

}
	

commonModal(url,params,divName,modalTitleNm,g_divZidx,'N');

}

//----------------------------------------- 인물 회사 팝업 : E

//공통 모달 팝업
function commonModal(url, paramObj,divName,modalTitleNm,idx,closeBtnYn,top,zIndex){	
	//url,param,divName(그리드 div), 표시줄 타이틀,구분 고유값,닫기버튼 세팅 여부, 창 위치 클수록 상단에 위치함
	//html 그리드  id  modalContent_divName_idx	
		
		var zIdx = zIndex;
		
		if(closeBtnYn == undefined || closeBtnYn == 'undefined' || closeBtnYn == '')  closeBtnYn = 'Y';		//닫기버튼 세팅유무
		var url = url;
		var params = paramObj;
		if(top == undefined || top == 'undefined' || top == '')  top = 6;									//상단위치 
		
		
	 	var callback = function(result){
	 		
	 		
	 		createBackDiv(g_divZidx);
	 		
	 		zIdxChk();		//g_divZidx 증가
	 	
	 		zIdx = g_divZidx;				//zIndex 
	 		
	 		var obj = result;

	 		var str ='';
	 		str+='<div class="popbasicWrap" id="commonModal_'+divName+'_'+idx+'">';
	 		str+='	<h1 class="poptitle">'+modalTitleNm+'</h1>';
	 		str+='	<div class="popconWrap" id="modalContent_'+divName+'_'+idx+'"></div>';
	 		str+='	<button type="button" class="popclosebtn" onclick="closeDiv(\''+divName+'\');"><span><em>창닫기</em></span></button>';
	 		str+='  <div class="btn_pop_basic mgb1rem">'
	 			
	 		if(closeBtnYn =='Y') str+='	<button type="button" class="btn_pop_white01" onclick="closeDiv(\''+divName+'\');"><span>닫기</span></button>';
	 		
	 		str+='	</div>';
	 		str+='</div>';
	 		
	 		$("#"+divName).html(str);  
	 		$("#modalContent_"+divName+'_'+idx).html(obj);  
	 		
	 		$("#"+divName).show();
			$("#"+divName).css("z-index",zIdx); 
		
			$("#"+divName).css("top", Math.max(0, ($(window).height()/(top*1) + $(window).scrollTop())) + "px");
			$("#"+divName).css("left", Math.max(0, (($(window).width() - $("#"+divName).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
			
		};
		
     	$.ajax({
    		type	: "POST",        			//"POST" "GET"
    		url		: url,    					//PAGEURL
    		data	: params,					//parameter object
    		dataType: "html",
    		timeout : 100000,       			//제한시간 지정(millisecond)
    		cache 	: false,        			//true, false
    		success	: callback,					//SUCCESS FUNCTION
    		async	: true,
    		error	: function whenError(x,e){	//ERROR FUNCTION			
    			alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");			
    		}
     	});
}

//등록 팝업(껍대기만 생성) 
function commonModalOnly(divName,modalTitleNm,idx,closeBtnYn,top){
		
		if(closeBtnYn == undefined || closeBtnYn == 'undefined' || closeBtnYn == '')  closeBtnYn = 'Y';		//닫기버튼 세팅유무
		
	 	zIdxChk();
	 		

 		var str ='';
 		str+='<div class="popbasicWrap" id="commonModal_'+divName+'_'+idx+'">';
 		str+='	<h1 class="poptitle">'+modalTitleNm+'</h1>';
 		str+='	<div class="popconWrap" id="modalContent_'+divName+'_'+idx+'"></div>';
 		str+='	<button type="button" class="popclosebtn" onclick="closeDiv(\''+divName+'\');"><span><em>창닫기</em></span></button>';
 		str+='  <div class="btn_pop_basic mgb1rem">'
 			
 		if(closeBtnYn =='Y') str+='	<button type="button" class="btn_pop_white01" onclick="closeDiv(\''+divName+'\');"><span>닫기</span></button>';
 		
 		str+='	</div>';
 		str+='</div>';
	 	
 		$("#"+divName).html(str);  
 		
 		$("#"+divName).show();
		$("#"+divName).css("z-index",g_divZidx); 
	
		$("#"+divName).css("top", Math.max(0, ($(window).height()/(top*1) + $(window).scrollTop())) + "px");
		$("#"+divName).css("left", Math.max(0, (($(window).width() - $("#"+divName).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
		createBackDiv(g_divZidx);
		
		
}

