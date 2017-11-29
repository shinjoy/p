/*
 * SGrid.js
 *
 * Class :  1. SGrid (그리드)
 * 			2. SPaging (페이징)
 *
 * (*필요 js : jquery, jquery-ui)
 */


//-------------------------------------------------- SGrid :S -------------------------------------------------------

/**
 * SGrid Class
 *
 * 그리드
 */
function SGrid(){

	//----- member variable :S -----

	this.targetID;					//대상 그리드 id
	this.gridObject;				//대상 그리드 jquery object
	this.gridBodyObject;			//대상 그리드 '<tbody>' jquery object

	this.colArrObj;					//컬럼 정보
	this.rowHtmlStr;				//행의 HTML 문자열
	this.columnCountForEmpty;		//데이터 결과가 없을때 보여질 데이터 없다는 정보 1 row 의 colspan 수
	this.bodyEvent;					//body event handler object

	this.emptyOfList;				//데이터가 없을때 빈 데이터 추가여부(default true)

	this.dataList = new Array();	//그리드데이터객체
	this.etc;						//그리드데이터객체 외 그리드생성시 필요한 데이터를 담아서 사용한다. (ex. formatter 에서 obj.etc. 으로 접근하여 사용)
	this.page;						//페이지데이터객체
	//----- member variable :E -----



	//----- member function (prototype defined) :S -----

	//setConfig(config)		그리드 설정함수
	//setGridData(data)		그리드 데이터 세팅 함수
	//addRow
	//insertRow
	//refresh
	//getList()				그리드 데이터 반환 함수
	//getPaging()			그리드 페이징 데이터 반환 함수
	//setGridDataEmpty()	그리드 데이터 비우기
	//setGridBodyEmpty()	빈그리드세팅(빈 라인추가) 함수
	//clickGridTr(trObj)	그리드 TR 클릭 함수(클릭한 tr 에 클래스 주기)
	//setGridBodyEvent		그리드 tr 클릭등의 이벤트 핸들러 함수 바인딩
	//getDataCount()		그리드 데이터 수
	//getSelectRowIndex()	그리드 선택된 행의 index 리스트
	//setSelectRow(index)	그리드 행 선택

	//----- member function (prototype defined) :E -----

}//SGrid


/**
 * 그리드 설정함수 (SGrid Class prototype function)
 *
 * @param		: config - 설정정보 객체
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SGrid.prototype.setConfig = function(config){
	/* 예시)
		config = {
			targetID	: "SGridTarget",					//대상 그리드 id
			emptyOfList : false,							//데이터가 없을때 빈 데이터 추가여부(default true)
			colGroup	: [],								//컬럼 배열 객체
			rowHtmlStr	: "<tr><td>...#[n]...</td></tr>" 	//행의 HTML 문자열(#[n] 이 삽입되어 있는 1row 포멧 string)
		}
	*/

	/* 예시) rowHtmlStr
	 	// 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 index 순서대로 데이터 세팅)
    	var rowHtmlStr = '<tr>';
    	rowHtmlStr +=	 '<td>#[0]</td>';
    	rowHtmlStr +=	 '<td class="left" onclick="fnObj.viewArticle(#[5]);" style="cursor:pointer;">#[1]</td>';
    	rowHtmlStr +=	 '<td>#[2]</td>';
    	rowHtmlStr +=	 '<td>#[3]</td>';
    	rowHtmlStr +=	 '<td>#[4]</td>';
        rowHtmlStr +=	 '</tr>';
	*/

	this.targetID = config.targetID;				//대상 그리드 id
	this.emptyOfList = config.emptyOfList;			//데이터가 없을때 빈 데이터 추가여부(default true)
	if(config.emptyOfList == undefined) this.emptyOfList = true;
	this.gridObject = $('#'+this.targetID);			//대상 그리드 jquery object
	this.gridBodyObject = this.gridObject.children('tbody');	//tbody (html 구조에 반드시 tbody가 있도록 해준다!!)

	this.colArrObj = config.colGroup;				//컬럼 정보(배열)
	this.rowHtmlStr = config.rowHtmlStr;			//행의 HTML 문자열(#[n] 이 삽입되어 있는 1row 포멧 string)
	this.columnCountForEmpty = config.columnCountForEmpty;	//데이터 결과가 없을때 보여질 데이터 없다는 정보 1 row 의 colspan 수
	this.bodyEvent = config.body;					//그리드 row의 이벤트 핸들러들의 객체

};//setConfig


/**
 * 그리드 데이터 세팅 (SGrid Class prototype function)
 *
 * @param		: dataList - 그리드데이터(배열객체)
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SGrid.prototype.setGridData = function(data){

	this.dataList = data.list;					//리스트 데이터
	this.etc = data.etc;						//리스트 외 참조 데이터
	this.page = data.page;						//페이징 데이터


	//grid redraw
	this.refresh();								//그리드 재세팅

};//setGridData


/**
 * 한줄 추가 (SGrid Class prototype function)
 *
 * @param		: data - 그리드 1 row 데이터
 * @return		:
 * @author		:
 * @date		: 2015. 10. 12.
 */
SGrid.prototype.addRow = function(data){

	this.dataList.push(data);					//리스트 데이터에 추가


	var thisSGrid = this;	//SGrid 를 this 이외에 접근하기 위한 객체변수

	var dataList = this.dataList;
	var etc	= this.etc;
	var page = this.page;

	var gridBodyObject = this.gridBodyObject;	//그리드 tbody dom object

	var colArrObj = this.colArrObj;        		//컬럼 속성(배열)
	var rowHtmlStr = this.rowHtmlStr;      		//행의 HTML 문자열

	//하단사용 변수
	var html;				//1개 row html string (tr)
	var dt;					//보여질 데이터(formatter 가 있으면, formatter 의 결과값)


	html = rowHtmlStr;		//copy
	for(var m=0; m<colArrObj.length; m++){			//컬럼종류를 한개씩 돌면서
		dt = data[colArrObj[m]['key']];		//해당 컬럼의 data 를 뽑아서
		if(colArrObj[m]['formatter'] != undefined){	//formatter 가 존재하면
			dt = colArrObj[m]['formatter']({value:dt, item:data, list:dataList, page:page, etc:etc, index:dataList.length-1});		//formatter 에 데이터정보 객체를 던져 결과를 받는다.
		}
		//html = html.replace('#[' + m + ']', dt);	//데이터(결과)를 행(HTML문자열)에 세팅해줘서 행을 완성해준다.
		html = html.split('#[' + m + ']').join(dt);
	}

	gridBodyObject.append(html);					//그리드 에 추가(완성된 HTML행)

	//click 이벤트 핸들러 추가 (선택 class 속성추가)
	$(gridBodyObject.children('tr')[dataList.length-1]).click(function(){	//tr click 이벤트 핸들러 세팅
		thisSGrid.clickGridTr($(this).get());
	});



	//그리드 body 이벤트 핸들러 바인딩 함수 호출 (그리드 tr 클릭등의 이벤트 핸들러 함수 바인딩)
	this.setGridBodyEvent();


	return dataList.length-1;	//index 반환

};//addRow


/**
 * 한줄 추가 (특정 index) (SGrid Class prototype function)
 *
 * @param		: data	- 그리드 1 row 데이터
 * 				  index	- 특정 index
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SGrid.prototype.insertRow = function(data, index){

	this.dataList = addToArray(this.dataList, index, data);		//한줄 추가


	//grid redraw
	this.refresh();								//그리드 재세팅

};//setGridData


/**
 * 그리드 재세팅 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 10. 12.
 */
SGrid.prototype.refresh = function(){

	var thisSGrid = this;	//SGrid 를 this 이외에 접근하기 위한 객체변수

	var dataList = this.dataList;
	var etc = this.etc;
	var page = this.page;

	var gridBodyObject = this.gridBodyObject;	//그리드 tbody dom object

	var colArrObj = this.colArrObj;        		//컬럼 속성(배열)
	var rowHtmlStr = this.rowHtmlStr;      		//행의 HTML 문자열

	//하단사용 변수
	var html;				//1개 row html string (tr)
	var dt;					//보여질 데이터(formatter 가 있으면, formatter 의 결과값)

	//그리드 데이터 초기화( tr 삭제)
	gridBodyObject.html('');					//그리드 데이터 초기화

	if(dataList.length==0 && this.emptyOfList) this.setGridBodyEmpty();		//빈줄(emtpy of list) 한줄 추가

	for(var i=0; i<dataList.length; i++){				//i : 리스트 index
		html = rowHtmlStr;	//copy
		for(var m=0; m<colArrObj.length; m++){			//컬럼종류를 한개씩 돌면서
			dt = dataList[i][colArrObj[m]['key']];		//해당 컬럼의 data 를 뽑아서
			if(colArrObj[m]['formatter'] != undefined){	//formatter 가 존재하면
				dt = colArrObj[m]['formatter']({value:dt, item:dataList[i], list:dataList, page:page, etc:etc, index:i});		//formatter 에 데이터정보 객체를 던져 결과를 받는다.
			}
			//html = html.replace('#[' + m + ']', dt);	//데이터(결과)를 행(HTML문자열)에 세팅해줘서 행을 완성해준다.
			html = html.split('#[' + m + ']').join(dt==undefined?'':dt);
		}

		gridBodyObject.append(html);					//그리드 에 추가(완성된 HTML행)

		//click 이벤트 핸들러 추가
		$(gridBodyObject.children('tr')[i]).click(function(){	//tr click 이벤트 핸들러 세팅
			thisSGrid.clickGridTr(this);	//$(this).get());
		});
	}


	//그리드 body 이벤트 핸들러 바인딩 함수 호출 (그리드 tr 클릭등의 이벤트 핸들러 함수 바인딩)
	this.setGridBodyEvent();

};//refresh


/**
 * 그리드 데이터 반환 함수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SGrid.prototype.getList = function(){

	return this.dataList;	//그리드 데이터

};//getList

/**
 * 그리드 페이징 데이터 반환 함수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SGrid.prototype.getPaging = function(){

	return this.page;	//그리드 페이징 데이터

};//getPaging


/**
 * 그리드 데이터 비우기 함수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 11. 20.
 */
SGrid.prototype.setGridDataEmpty = function(){

	this.dataList = [];		//데이터가 빈 상태로 다시한번 초기화.(강제 초기화할 경우도 지원하기 위해)

	var gridBodyObject = this.gridBodyObject;	//그리드 tbody dom object

	if(this.emptyOfList){
		var emtpyColspanCnt = (this.columnCountForEmpty==undefined || this.columnCountForEmpty==null)?this.colArrObj.length:this.columnCountForEmpty;
		gridBodyObject.html('<tr><td class="no_result" colspan=' + emtpyColspanCnt + ' align=center bgcolor="#EEEEEE" >조회된 데이터가 없습니다.</td></tr>');	//그리드 데이터 초기화
	}else{
		//그리드 데이터 초기화( tr 삭제)
		gridBodyObject.html('');					//그리드 데이터 초기화
	}


	//grid redraw
	this.refresh();								//그리드 재세팅

};//setGridDataEmpty


/**
 * 빈그리드세팅(빈 라인추가) 함수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SGrid.prototype.setGridBodyEmpty = function(){

	this.dataList = [];		//데이터가 빈 상태로 다시한번 초기화.(강제 초기화할 경우도 지원하기 위해)

	var gridBodyObject = this.gridBodyObject;	//그리드 tbody dom object

	var emtpyColspanCnt = (this.columnCountForEmpty==undefined || this.columnCountForEmpty==null)?this.colArrObj.length:this.columnCountForEmpty;

	gridBodyObject.html('<tr><td class="no_result" colspan=' + emtpyColspanCnt + ' style="text-align:center!important;" bgcolor="#EEEEEE">조회된 데이터가 없습니다.</td></tr>');	//그리드 데이터 초기화

};//setGridBodyEmpty


/**
 * 그리드 TR 클릭 함수(클릭한 tr 에 클래스 주기) (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 25.
 */
SGrid.prototype.clickGridTr = function(trObj){

	var gridBodyObject = this.gridBodyObject;	//그리드 tbody dom object

	//----- 클릭을 통해 TR 에 선택스타일 주기 위한 class 삽입 :S -----
	gridBodyObject.children('tr').each(function(index){
		$(this).removeClass('tr_selected');	//일단 삭제
	});

	$(trObj).addClass('tr_selected');			//해당 tr 에 추가
	//----- 클릭을 통해 TR 에 선택스타일 주기 위한 class 삽입 :E -----



};//clickGridTr


/**
 * 그리드 선택된 행의 index 리스트 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 12. 2.
 */
SGrid.prototype.getSelectRowIndex = function(){

	var gridBodyObject = this.gridBodyObject;	//그리드 tbody dom object

	var idxList = new Array();

	gridBodyObject.children('tr').each(function(index){
		if($(this).hasClass('tr_selected')){	//갖고 있는지 확인
			idxList.push(index);
		}
	});

	return idxList;

};//getSelectRowIndex


/**
 * 그리드 행 선택 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 12. 2.
 */
SGrid.prototype.setSelectRow = function(idx){

	var gridBodyObject = this.gridBodyObject;	//그리드 tbody dom object

	var idxList = new Array();

//	gridBodyObject.children('tr').each(function(index){
//		if($(this).hasClass('tr_selected')){	//갖고 있는지 확인
//			idxList.push(index);
//		}
//	});
	//----- 클릭을 통해 TR 에 선택스타일 주기 위한 class 삽입 :S -----
	gridBodyObject.children('tr').each(function(index){
		$(this).removeClass('tr_selected');	//일단 삭제
	});

	$(gridBodyObject.children('tr')[idx]).addClass('tr_selected');

};//setSelectRow


/**
 * 그리드 tr 클릭등의 이벤트 핸들러 함수 바인딩 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 10. 27.
 */
SGrid.prototype.setGridBodyEvent = function(){

	var thisSGrid = this;	//SGrid 를 this 이외에 접근하기 위한 객체변수

	if(this.bodyEvent != null){

		var bodyEvent = this.bodyEvent;	//그리드 tbody dom object

		if(bodyEvent.onclick != undefined){
			//이벤트 초기화
			this.gridBodyObject.undelegate("td", "click");		//이벤트 삭제(이전 등록된것 모두 삭제)

			this.gridBodyObject.delegate("td", "click", function(e){

				var tr = $(this).closest('tr');		//tr

				(bodyEvent.onclick)({
										c: $(this).index(),
										index: tr.index(),	//JSON.stringify(e.currentTarget),//$(e.currentTarget).index(),
										item: thisSGrid.dataList[tr.index()],
										list: thisSGrid.dataList
									  }, e);
		    });
		}
		if(bodyEvent.ondblclick != undefined){
			//이벤트 초기화
			this.gridBodyObject.undelegate("td", "dblclick");	//이벤트 삭제(이전 등록된것 모두 삭제)

			this.gridBodyObject.delegate("td", "dblclick", function(e){

				var tr = $(this).closest('tr');		//tr

				(bodyEvent.ondblclick)({
										c: $(this).index(),
										index: tr.index(),	//JSON.stringify(e.currentTarget),//$(e.currentTarget).index(),
										item: thisSGrid.dataList[tr.index()],
										list: thisSGrid.dataList
									  }, e);
		    });
		}

	}
};//setGridBodyEvent


/**
 * 그리드 데이터 수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 11. 25.
 */
SGrid.prototype.getDataCount = function(){

	return this.dataList.length;

};//getDataCount


//-------------------------------------------------- SGrid :E -------------------------------------------------------



//-------------------------------------------------- SPaging :S -----------------------------------------------------

/**
 * SPaging Class
 *
 * 페이징 바
 *
 *
 * 예) 화면출력결과
 *
 * <div class="btnPageZone" id="btnPageZone">
 *     <button type="button" class="pre_end_btn"><em>맨처음 페이지</em></button>
 *     <button type="button" class="pre_btn"><em>이전 페이지</em></button>
 *     <span class="current"><a href="">1</a></span>
 *     <span><a href="">2</a></span>
 *     <span><a href="">3</a></span>
 *     <span><a href="">4</a></span>
 *     <span><a href="">5</a></span>
 *     <span><a href="">6</a></span>
 *     <span><a href="">7</a></span>
 *     <span><a href="">8</a></span>
 *     <span><a href="">9</a></span>
 *     <span><a href="">10</a></span>
 *     <button type="button" class="next_btn"><em>다음 페이지</em></button>
 *     <button type="button" class="next_end_btn"><em>맨마지막 페이지</em></button>
 * </div>
 *
 */
function SPaging(){

	//----- member variable :S -----

	this.pageNo;			//현재 페이지
	this.pageCount;			//총 페이지 수
	this.totalCount;		//총 데이터 수

	this.pageSize;			//페이지크기(1페이지 데이터 수)

	this.targetID;			//페이징 div id
	this.pageDivObject;		//페이징 div jquery object

	this.preEndBtnObj;		//맨처음 페이지 	버튼 객체
	this.preBtnObj;			//이전 페이지		버튼 객체
	this.nextBtnObj;		//다음 페이지		버튼 객체
	this.nextEndBtnObj;		//맨마지막 페이지	버튼 객체

	this.curPageNoClass;	//현재페이지를 표시해주기위한 style Class name	... ex) current ... <span class="current"><a href="">1</a></span>

	this.clickFnName;		//페이지 이동 함수명

	//----- member variable :E -----



	//----- member function (prototype defined) :S -----

	//setConfig(config)		페이징 설정함수
	//setPaging(data)		페이징 데이터 세팅 함수

	//----- member function (prototype defined) :S -----

}//SPaging


/**
 * 페이징 설정 함수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SPaging.prototype.setConfig = function(config){
	/* 예시)
	config = {

		targetID		: "SGridTarget",				//대상 페이징 id ... <div id="SGridTarget">
		pageSize		: 10,							//1페이지내 데이터 수

		preEndBtnClass	: '',							//맨처음 페이지 	버튼 클래스명
		preBtnClass		: '',							//이전 페이지		버튼 클래스명
		nextBtnClass	: '',							//다음 페이지		버튼 클래스명
		nextEndBtnClass	: '',							//맨마지막 페이지	버튼 클래스명

		curPageNoClass	: '',							//현재페이지를 표시해주기위한 style Class name
		clickFnName		: ''							//페이지 이동 함수명
	}
	 */

	this.pageSize = config.pageSize;					//페이지크기(1페이지 데이터 수)


	this.targetID = config.targetID;					//대상 페이징 id ... <div>
	this.pageDivObject = $('#'+this.targetID);			//대상 페이징 div jquery object

	if(config.preEndBtnClass!=undefined && config.preBtnClass!=undefined && config.nextBtnClass!=undefined && config.nextEndBtnClass!=undefined){

		this.preEndBtnObj 	= $(this.pageDivObject.children('.'+config.preEndBtnClass).get(0));		//맨처음 페이지 	버튼 객체
		this.preBtnObj 		= $(this.pageDivObject.children('.'+config.preBtnClass).get(0));      	//이전 페이지		버튼 객체
		this.nextBtnObj 	= $(this.pageDivObject.children('.'+config.nextBtnClass).get(0));     	//다음 페이지		버튼 객체
		this.nextEndBtnObj 	= $(this.pageDivObject.children('.'+config.nextEndBtnClass).get(0));  	//맨마지막 페이지	버튼 객체
	}


	this.curPageNoClass	= config.curPageNoClass;		//현재페이지를 표시해주기위한 style Class name	... ex) current ... <span class="current"><a href="">1</a></span>

	this.clickFnName = config.clickFnName;				//페이지 이동 함수명

};


/**
 * 페이징 세팅 함수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SPaging.prototype.setPaging = function(data){
	/* 예시)
	data = {
		pageNo		: 1,		//현재 페이지
		pageSize	: 10,		//페이지 사이즈(1페이지 데이터 수)
		pageCount	: 12,		//총 페이지 수
	}
	*/

	this.pageNo = data.pageNo;				//현재 페이지
	this.pageCount = data.pageCount;		//총 페이지 수


	var pageNo = this.pageNo;
	var pageCount = this.pageCount;


	var pageDivObject = this.pageDivObject;	//페이징 div jquery object


	//페이징 데이터 초기화
	pageDivObject.children('span').each(function(){
		$(this).remove();						//삭제
	});


	var html = '';							//숫자버튼 html
	var startNo;			//화면상 뿌려줄 첫번째 숫자 버튼
	var lastNo;				//화면상 뿌려줄 마지막 숫자 버튼

	var befObj;				//화면상 뿌려줄 숫자가 위치할 바로 이전 dom object.

	if(this.preEndBtnObj==null && this.preBtnObj==null){	//case1. 맨처음페이지 버튼 X, 이전페이지 버튼 X ... 모두 없는경우
		befObj = this.pageDivObject;
	}else if(this.preEndBtnObj==null){						//case2. 맨처음페이지 버튼 X, 이전페이지 버튼 O
		befObj = this.preBtnObj;
	}else{													//case3. 맨처음페이지 버튼 O, 이전페이지 버튼 O
		befObj = this.preBtnObj;
	}//** 위 조건문이 만족하기 위해서는, 페이징 div > 맨처음페이지버튼 > 이전페이지 버튼 순서로 존재(html dom tree)하고,
	 //	  이전페이지버튼없이 맨처음페이지버튼만 있는경우는 없는것을 반드시 지키는 디자인이어야함

	startNo = parseInt((pageNo - 1) / 10) * 10 + 1;			//첫번째 숫자 버튼 숫자.
	if(pageCount<startNo+9) lastNo = pageCount;		//마지막 숫자 버튼 숫자.(전체 버튼 수보다 작으면 전체버튼숫자가 마지막 숫자로)
	else lastNo = startNo+9;


	for(var i=startNo; i<=lastNo; i++){				//숫자버튼 html 만들기
		html += ('<span' + ((i==pageNo)?(' class="'+this.curPageNoClass+'"'):'') + '>');
		html += '<a href="#" onclick="' + ((i==pageNo)?'':(this.clickFnName + '(' + i + ');')) + 'return false;">'+i+'</a>';
		html += '</span>';
	}
	befObj.after(html);		//숫자버튼 세팅


	//------------- 숫자외버튼 :S -------------
	//숫자외버튼 클릭함수 세팅
	this.preEndBtnObj.attr('onclick', this.clickFnName + '(1);');											//맨처음 페이지 	버튼 객체
	this.preBtnObj.attr('onclick', this.clickFnName + '(' + ((1==pageNo)?1:pageNo-1) + ');');      			//이전 페이지		버튼 객체
	this.nextBtnObj.attr('onclick', this.clickFnName + '(' + ((pageCount==pageNo)?pageNo:pageNo+1) + ');');	//다음 페이지		버튼 객체
	this.nextEndBtnObj.attr('onclick', this.clickFnName + '(' + pageCount + ');');  						//맨마지막 페이지	버튼 객체
	//숫자외버튼 활성화 세팅
	this.preEndBtnObj.show();		//초기화(보이게)
	this.preBtnObj.show();			//초기화(보이게)
	this.nextBtnObj.show();			//초기화(보이게)
	this.nextEndBtnObj.show();		//초기화(보이게)


	//일단 모두 보이게
	this.preEndBtnObj.css('visibility', '');			//보이기
	this.preBtnObj.css('visibility', '');				//보이기
	this.nextBtnObj.css('visibility', '');				//보이기
	this.nextEndBtnObj.css('visibility', '');			//보이기

	if(1==pageNo){
		//this.preEndBtnObj.hide();		//숨기기
		//this.preBtnObj.hide();			//숨기기
		this.preEndBtnObj.css('visibility', 'hidden');	//숨기기
		this.preBtnObj.css('visibility', 'hidden');		//숨기기
	}

	if(pageCount==pageNo || pageCount==0){
		//this.nextBtnObj.hide();			//숨기기
		//this.nextEndBtnObj.hide();		//숨기기
		this.nextBtnObj.css('visibility', 'hidden');	//숨기기
		this.nextEndBtnObj.css('visibility', 'hidden');	//숨기기
	}

	//------------- 숫자외버튼 :E -------------

};//setPaging

/*
 <span class="current"><a href="">1</a></span>
        <span><a href="">2</a></span>
        <span><a href="">3</a></span>
 */

//-------------------------------------------------- SPaging :E -----------------------------------------------------



//-------------------------------------------------- SSorting :S -----------------------------------------------------

/**
 * SSorting Class
 *
 * 소팅 정보 클래스
 *
 *
 * 예) 화면출력결과
 *
 *	<th scope="col"><a href="" class="sort_normal">타입<em>정렬</em></a></th>			//정렬기본
 *  <th scope="col">설명</th>  																		//정렬없는 컬럼
 *  <th scope="col"><a href="" class="sort_lowtohigh">기한<em>오름차순</em></a></th>		//오름차순
 *  <th scope="col"><a href="" class="sort_hightolow">예산<em>내림차순</em></a></th>		//내림차순
 *
 */
function SSorting(){

	//----- member variable :S -----

	this.colList = new Array();		//정렬 버튼 있을 컬럼들(배열)

	this.nowSortCol = '';			//현재 소팅된 컬럼 값(배열의 값중 한개)
	this.nowSortColIdx = -1;		//현재 소팅된 컬럼의 밸열의 index
	this.nowDirection = '';			//ASC, DESC

	this.classNameNormal = '';		//정렬기본 아이콘 css class
	this.classNameLowToHigh = '';	//오름정렬 아이콘 css class
	this.classNameHighToLow = '';	//내림정렬 아이콘 css class

	this.defaultSortDirection = '';	//기본 정렬 방향 'ASC' or 'DESC'

	//----- member variable :E -----



	//----- member function (prototype defined) :S -----

	//setConfig(data)	소팅 설정함수
	//setSort(col)		신규 소팅 상태로의 데이터 세팅 함수
	//applySortIcon()	신규 소팅 마무리후 화면 소팅아이콘 설정 함수
	//clearSort()		소팅 초기화 함수

	//----- member function (prototype defined) :S -----

}//SSorting


/**
 * 소팅 데이터 설정 함수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SSorting.prototype.setConfig = function(config){
	/* 예시)
		config = {
			colList : ['TEMPLATE_TYPE', 'PERIOD', 'BUDGET'],
			classNameNormal		: 'sort_normal',
			classNameHighToLow	: 'sort_lowtohigh',
			classNameLowToHigh	: 'sort_hightolow'
		};
	*/

	this.colList = config.colList;

	//기본정렬 방향 세팅
	if(config.defaultSortDirection == undefined || config.defaultSortDirection == '' || config.defaultSortDirection == null){
		this.defaultSortDirection = 'ASC';
	}else{
		this.defaultSortDirection = config.defaultSortDirection;
	}


	this.classNameNormal = config.classNameNormal;
	this.classNameHighToLow = config.classNameHighToLow;
	this.classNameLowToHigh = config.classNameLowToHigh;

};//setConfig


/**
 * 신규 소팅 상태로의 데이터 설정 함수 (SGrid Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SSorting.prototype.setSort = function(idx){

	if(idx == this.nowSortColIdx){		//이미 소팅이 이루어진 컬럼을 다시 소팅하는 케이스
		if(this.nowDirection == 'ASC'){
			this.nowDirection = 'DESC';
		}else{
			this.nowDirection = 'ASC';
		}

	}else{		//새로운 소팅 컬럼
		this.nowDirection = this.defaultSortDirection;			//1차적으로

		this.nowSortColIdx = idx;			//소팅할 컬럼의 index
		this.nowSortCol = this.colList[idx];
	}

};//setSort



/**
 * 신규 소팅 마무리후 화면 소팅아이콘 설정 함수 (SSorting Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SSorting.prototype.applySortIcon = function(){

	//아이콘 초기화
	for(var i=0; i<this.colList.length; i++){
		$('#sort_column_prefix' + i).attr('class', this.classNameNormal);
	}

	//해당 컬럼 아이콘 세팅(class 세팅)
	if(this.nowDirection == 'DESC'){
		$('#sort_column_prefix' + this.nowSortColIdx).attr('class', this.classNameHighToLow);
	}else{
		$('#sort_column_prefix' + this.nowSortColIdx).attr('class', this.classNameLowToHigh);
	}

};//applySortIcon
//sort_column_prefix0


/**
 * 소팅 초기화 함수 (SSorting Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
SSorting.prototype.clearSort = function(){

	//맴버변수 초기화
	this.nowSortCol = '';			//현재 소팅된 컬럼 값(배열의 값중 한개)
	this.nowSortColIdx = -1;		//현재 소팅된 컬럼의 밸열의 index
	this.nowDirection = '';			//ASC, DESC


	//아이콘 초기화
	for(var i=0; i<this.colList.length; i++){
		$('#sort_column_prefix' + i).attr('class', this.classNameNormal);
	}

};//clearSort



//-------------------------------------------------- SSorting :E -----------------------------------------------------






/*

//-------------------------- 그리드 :S -------------------------
myGrid.setConfig({
    targetID : "AXGridTarget",
//    theme : "AXGrid",

//    fixedColSeq : 4,	//컬럼고정 index
//    fitToWidth : true,	//true,	//넓이에맞게
//    colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

//    height: 500,		//grid height
    //width: '95%',

//    autoChangeGridView: { // autoChangeGridView by browser width
//        mobile:[0,600], grid:[600]
//    },

    //passiveMode:true,
	//passiveRemoveHide:false,

    colGroup : [
        {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
        	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
        	return ("<font color=silver><b>" + (this.index + 1) + "</b></font>");
        }},

        {key:"userId", 		label:"아이디", 			width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
        {key:"userNo", 		label:"사번", 			width:"100",	align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
        {key:"loginId",		label:"로그인ID",		width:"110",	align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
        {key:"name",		label:"이름", 			width:"65",		align:"center"},
        {key:"empTypeNm",	label:"채용형태", 		width:"65",		align:"center"},
        {key:"company", 	label:"소속회사", 		width:"120",	align:"center"},
        {key:"incharge", 	label:"직책", 			width:"65",		align:"left"},
        {key:"position", 	label:"직위", 			width:"65",		align:"center"},
        {key:"department", 	label:"부서", 			width:"120",	align:"center"},
        {key:"companyTel", 	label:"회사전화", 		width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
        {key:"companyFax", 	label:"회사팩스", 		width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
        {key:"homeZip", 	label:"집우편번호", 		width:"80",		align:"center"},
        {key:"homeAddr1", 	label:"집기본주소", 		width:"170",	align:"left"},
        {key:"homeAddr2", 	label:"집나머지주소", 	width:"110",	align:"left"},
        {key:"homeTel", 	label:"집전화", 			width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
        {key:"mobileTel", 	label:"핸드폰", 			width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
        {key:"email", 		label:"이메일", 			width:"90",		align:"left"},
        {key:"homepage", 	label:"홈페이지", 		width:"130",	align:"left"},
        {key:"hobby", 		label:"취미", 			width:"70",		align:"center"},
        {key:"hiredDate", 	label:"입사일", 			width:"75",		align:"center"},
        {key:"joinDate", 	label:"정식입사일", 		width:"75",		align:"center"},
        {key:"sosTel", 		label:"비상연락처", 		width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
        {key:"sosRelationNm", label:"비상연락처관계",	width:"70",		align:"center"},
        {key:"bloodNm", 	label:"혈액형", 			width:"70",		align:"center"},
        {key:"religionNm", 	label:"종교", 			width:"70",		align:"center"},
        {key:"passport", 	label:"여권번호", 		width:"70",		align:"center"},
        {key:"marriedDate", label:"결혼일", 			width:"75",		align:"center"},
        {key:"userStatusNm",label:"상태", 			width:"70",		align:"center"},
        {key:"firedDate", 	label:"퇴사일", 			width:"75",		align:"center"},
        {key:"createDate", 	label:"등록일", 			width:"75",		align:"center"},
        {key:"createNm", 	label:"등록자", 			width:"70",		align:"center"},
        {key:"updateDate", 	label:"수정일", 			width:"75",		align:"center"},
        {key:"updateNm", 	label:"수정자", 			width:"70",		align:"center"}

    ],
    body : {
        onclick: function(){
            //toast.push(Object.toJSON({index:this.index, item:this.item}));
        	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
        	//alert(JSON.stringify(this));
        	if(this.c == 1 || this.c == 2 || this.c == 3 || this.c == 4 ){		//메뉴보기
        		//fnObj.viewMenu(this.item.menuId);
        		fnObj.viewUser(this.list[this.index]);	//메뉴정보보기 (메뉴정보 객체전달)
        	}

        },

        ondblclick: function(){
        	//fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
        }

    },
	page:{
		paging:false,
		status:{formatter: null}
	}

});
//-------------------------- 그리드 :E -------------------------

*/