<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>



<script type="text/javascript">



//Global variables :S ---------------


var myGridGroup = new SGrid();      // instance     new sjs
var myGridCate = new SGrid();           // instance     new sjs
var myModal = new AXModal();        // instance

var groupList;
var g_groupId =0;           //groupId--> default 0
var g_groupUid='';

//Global variables :E ---------------


var g_tab = 'programMgmt';


var fnObj = {

	setPage : function(){

    	var url = contextRoot + "/board/boardMgmtAjax.do";
		var param = {};

    	var callback = function(result){

			$("#boardMgmtArea").empty();

    		$("#boardMgmtArea").html(result);

    	};

    	 commonAjax("POST", url, param, callback, false);
    },

    //그룹화면세팅
    pageStartGroup: function(){

        //-------------------------- 그리드 설정 :S ----------------------------
        /* 그리드 설정정보 */
        var configObj = {
            columnCountForEmpty : 6,
            targetID : "SGridTargetGroup",      //그리드의 id

            //그리드 컬럼 정보
            colGroup : [
                {key:"no"       ,formatter:function(obj) {return obj.index+1;}},
                {key:"groupUid"},
                {key:"groupName"},
                {key:"groupDesc"},
                {key:"deleteFlag", formatter:function(obj) {
                        return (obj.value == 'Y'?'N':'Y');
                    }
                }
            ],

            body : {
                onclick: function(obj, e){
                    if(obj.c==5){
                        fnObj.addBoardGroup(obj.item.groupId);
                    }else{
                        fnObj.clickGroup(obj.item.groupId);
                    }

                }
            }

        };

    	var rowHtmlStr = '<tr>';
        rowHtmlStr +=    '<td>#[0]</td>';
        rowHtmlStr +=    '<td class="txt_left">#[1]</td>';
        rowHtmlStr +=    '<td class="txt_left">#[2]</td>';
        rowHtmlStr +=    '<td class="txt_left">#[3]</td>';
        rowHtmlStr +=    '<td>#[4]</td>';
        rowHtmlStr +=    '<td><button class="btn_s_type_g btn_auth">수정</button></td>';
        //rowHtmlStr +=  '<td><i class="axi axi-edit2" style="font-size:17px;"></i></td>';
        rowHtmlStr +=    '</tr>';
        configObj.rowHtmlStr = rowHtmlStr;

        myGridGroup.setConfig(configObj);       //그리드 설정정보 세팅


    },//end pageStart.

    //프로그램 화면세팅
    pageStartCate: function(){

        //-------------------------- 그리드 설정 :S ----------------------------
        /* 그리드 설정정보 */
        var configObj = {

            targetID : "SGridTarget",       //그리드의 id
            columnCountForEmpty : 11,
            //그리드 컬럼 정보
            colGroup : [
                {key:"no"       , formatter:function(obj) {return obj.index+1;}},
                {key:"cboardUid"},
                {key:"cboardName"},
                {key:"cboardDesc"},
                {key:"cboardUid", formatter:function(obj) {return ('board/boardList/'+g_groupUid+'/'+obj.item.cboardUid+'.do');}},
                {key:"deleteFlag", formatter:function(obj) {
                        return (obj.value == 'Y'?'N':'Y');
                    }
                },
                {key:"noticeYn"},
                {key:"replyYn"},
                {key:"fileYn"},
                {key:"approveYn"},
                {key:"openPeriodYn"},
                {key:"listCount"},
                {key:"pageCount"},
                {}

            ],

            body : {
                onclick: function(obj, e){
                    if(obj.c!=4 && obj.c!=11){
                        fnObj.addBoardCate(obj.item.cboardId);
                    }

                }
            }

        };
        /* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */
        var rowHtmlStr = '<tr>';
        rowHtmlStr +=    '<td class="txt_center">#[0]</td>';
        rowHtmlStr +=    '<td>#[1]</td>';
        rowHtmlStr +=    '<td>#[2]</td>';
        rowHtmlStr +=    '<td>#[3]</td>';
        rowHtmlStr +=    '<td class="txt_letter0">#[4]</td>';
        rowHtmlStr +=    '<td class="txt_center">#[5]</td>';
        rowHtmlStr +=    '<td class="txt_center">#[6]</td>';
        rowHtmlStr +=    '<td class="txt_center">#[7]</td>';
        rowHtmlStr +=    '<td class="txt_center">#[8]</td>';
        rowHtmlStr +=    '<td class="txt_center">#[9]</td>';
        rowHtmlStr +=    '<td class="txt_center">#[10]</td>';
        rowHtmlStr +=    '<td class="txt_center">#[11]</td>';
        rowHtmlStr +=    '<td class="txt_center">#[12]</td>';
        //rowHtmlStr +=  '<td style="cursor:pointer;"><i class="axi axi-find-in-page" style="font-size:17px;"></i></td>';
        rowHtmlStr +=    '</tr>';
        configObj.rowHtmlStr = rowHtmlStr;

        myGridCate.setConfig(configObj);        //그리드 설정정보 세팅




        //-------------------------- 모달창 :S -------------------------
        myModal.setConfig({
            windowID:"myModalCT",
            //openModalID:"kkkkk",
            width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
            displayLoading:true,
            scrollLock: true,
            onclose: function(){

            }

            ,contentDivClass: "popup_outline"
        });
        //-------------------------- 모달창 :E -------------------------


    },//end pageStart.


    doSearch: function(groupId){
        var url = contextRoot + "/board/getBoardCateList.do";
        var param = {groupId : groupId};
        var callback = function(result){

            var obj = JSON.parse(result);
            var list = obj.resultList;

            myGridCate.setGridData({                    //그리드 데이터 세팅    *** 2 ***
                    list : obj.resultList       //그리드 테이터
            });

        };

        commonAjax("POST", url, param, callback, true);
    },//end doSearch

    //그룹 리스트
    getGroupList : function(){
        var url = contextRoot + "/board/getBoardGroupList.do";
        var param = {};
        var callback = function(result){
            var obj = JSON.parse(result);
            var resultObj = obj.resultObject;
            var list = resultObj.list;
            groupList = list;
            myGridGroup.setGridData({
                list : groupList
            });
            if(list.length>0){g_groupId = list[0].groupId;}
        };
        commonAjax("POST", url, param, callback, false);
    },

    //그룹 클릭
    clickGroup : function(groupId){     //그룹 id
        $("#titleType").html('');
        g_groupId = groupId;                    //누른 값으로 id 변경.(그룹 id)

        var groupName='';
        for(var i=0;i<groupList.length; i++){
            var group = groupList[i];
            if(group.groupId == groupId){
                groupName = group.groupName;
                g_groupUid=group.groupUid

                myGridGroup.setSelectRow(i);        //선택
            }
        }
        if(groupName != ""){
        	$("#titleType").html('<span>[' + groupName + ']</span>');
            fnObj.doSearch(groupId);
        }

    },

    //프로그램 그룹 등록
    addBoardGroup : function(groupId){

        var url = contextRoot + "/board/boardGroupView/pop.do";
        var params = {groupId : groupId};
        myModal.open({
            url: url,
            pars: params,
            titleBarText: '그룹 '+fnObj.txtSet(groupId),
            method:"POST",
            top: 200,
            width: 640,
            closeByEscKey: true             //esc 키로 닫기
        });

        $('#myModalCT').draggable();

    },//end writeOpen

    //프로그램 카테고리 등록
    addBoardCate : function(cboardId){
    	if("${baseUserLoginInfo.orgBasicAuth}" == "READ"){
			alert("수정권한이 없습니다.");
			return;
		}
        var url = contextRoot + "/board/boardCateView/pop.do";
        var params = {cboardId:cboardId,groupId:g_groupId};
        myModal.open({
            url: url,
            pars: params,
            titleBarText: '프로그램 '+fnObj.txtSet(cboardId),
            method:"POST",
            top: 200,
            width: 640,
            closeByEscKey: true             //esc 키로 닫기
        });

        $('#myModalCT').draggable();

    },//end writeOpen

    txtSet : function(num){
        var str ='추가';
        if(num != 0){
            str ='수정';
        }
        return str;
    },

    //그리드 div height toggle
    setGridInit: function(){
        $('#scroll_body_group').css('height', '400px');
        $('#scroll_body_group').css('max-height', '400px');
        $('#scroll_body').css('height', '200px');
        $('#scroll_body').css('max-height', '200px');
    },//end showAllGrid

    showAllGridGroup: function(){
        var gridH = $('#SGridTargetGroup').height() + 50;
        if($('#scroll_body_group').height() == 400){
            $('#scroll_body_group').css('height', gridH);
            $('#scroll_body_group').css('max-height', gridH);
        }else{
            $('#scroll_body_group').css('height', '400px');
            $('#scroll_body_group').css('max-height', '400px');
        }
    },//end showAllGrid

    showAllGrid: function(){
        var gridH = $('#SGridTarget').height() + 50;
        if($('#scroll_body').height() == 200){
            $('#scroll_body').css('height', gridH);
            $('#scroll_body').css('max-height', gridH);
        }else{
            $('#scroll_body').css('height', '200px');
            $('#scroll_body').css('max-height', '200px');
        }
    },//end showAllGrid

};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.setPage();
    fnObj.pageStartGroup(); //화면세팅
    fnObj.getGroupList();

    fnObj.pageStartCate();  //화면세팅
    fnObj.clickGroup(g_groupId);

    fnObj.setGridInit();
});
</script>
