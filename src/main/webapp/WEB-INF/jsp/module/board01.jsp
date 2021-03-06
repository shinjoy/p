<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script>
    $(document).ready(function(){
        //최초 정보셋팅
        board1Obj.doSearch();
    });
    var board1Obj = {
            doSearch : function(){
                $("#board1Frm").attr("action",contextRoot+"/basic/board/getBoard1List.do");
                commonAjaxSubmit("POST",$("#board1Frm"),board1Obj.mainboardObjCallback);

            },
            moveMorePage : function(){
                location.href = contextRoot+"/board/boardList/notice/noticeAll.do";

            },
            mainboardObjCallback:function(data){
                $("#board1_list").empty();

                var list = data.resultList;
                //console.log(list);

                if(list == undefined || list.length<1){
                    //nodata
                    $("#board1_conBox").append("<div class=\"m_nocontxt\">내용이 없습니다.</div>");
                }else{
                    for(var i = 0 ; i <list.length ; i++){

                        var dataObj = list[i];
                        //tmpl txt
                        var board1Tmpl = $("#board1Tmpl").text();

                        board1Tmpl = board1Tmpl.split("##boardTypeCss##").join(dataObj.boardTypeCss);
                        board1Tmpl = board1Tmpl.split("##boardTypeName##").join(dataObj.boardTypeName);

                        board1Tmpl = board1Tmpl.split("##board1ContentId##").join(dataObj.contentId);
                        board1Tmpl = board1Tmpl.split("##boardType##").join(dataObj.boardType);
                        board1Tmpl = board1Tmpl.split("##boardId##").join(dataObj.boardId);
                        board1Tmpl = board1Tmpl.split("##dtlYn##").join(dataObj.dtlYn);

                        if(dataObj.allOrg == 'Y' && dataObj.checkNotice == 'Y'){
                            board1Tmpl = board1Tmpl.split("##board1Message##").join('<strong class="noti_comname">['+dataObj.message+']</strong>');
                        }else if(dataObj.message == '' && dataObj.checkNotice == 'Y'){
                            board1Tmpl = board1Tmpl.split("##board1Message##").join('<span class="icon_notice"><em>[공지]</em></span>');
                        }else{
                            board1Tmpl = board1Tmpl.split("##board1Message##").join('');
                        }
                        board1Tmpl = board1Tmpl.split("##board1Title##").join(devUtil.fn_escapeReplace(dataObj.title));

                        //코멘트가 있는 경우
                        if(parseInt(dataObj.commentCnt) != 0){
                            board1Tmpl = board1Tmpl.split("##board1CommentCnt##").join(dataObj.commentCnt);
                            board1Tmpl = board1Tmpl.split("##board1CommentCntCss##").join("inline");
                        }else{
                            board1Tmpl = board1Tmpl.split("##board1CommentCntCss##").join("none");
                        }

                        //오늘 올라온 글인 경우
                        if(dataObj.newYn == 'Y'){
                            board1Tmpl = board1Tmpl.split("##board1NewCss##").join("inline-block");
                        }else{
                            board1Tmpl = board1Tmpl.split("##board1NewCss##").join("none");
                        }

                        //비공개 글인 경우
                        if(dataObj.openFlag == 'N'){
                            board1Tmpl = board1Tmpl.split("##openFlagCss##").join("inline-block");
                        }else{
                            board1Tmpl = board1Tmpl.split("##openFlagCss##").join("none");
                        }

                        board1Tmpl = board1Tmpl.split("##board1Date##").join(dataObj.creDate);

                        $("#board1_list").append(board1Tmpl);
                    }

                }

            },
            //상세팝업
            openDetailPop : function(contentId,boardType,boardId,dtlYn){
                var frm = $("#board1Frm")[0];
                frm.contentId.value = contentId;
                if(boardType == "noticeAll"){
                    frm.cboardId.value = boardId;
                    frm.action = contextRoot+"/board/boardContentView/notice/noticeAll.do";
                }else if(boardType == "improvement"){
                    frm.cboardId.value = boardId;
                    frm.action = contextRoot+"/board/boardContentView/qna/improvement.do";
                }else{
                    if(dtlYn != 'Y'){
                        alert("해당 게시글에 보기 권한이 없습니다.");
                        return;
                    }
                    frm.gboardId.value = boardId;
                    frm.action = contextRoot+"/gboard/gboardList.do";
                }
				var newWin = window.open("about:blank","mainBoardNewWin");
				frm.target="mainBoardNewWin";
                frm.submit();
            },
            doSearchHeadline : function(obj){
                if($("#btn_board_headline").attr("class")== "btn_board_headline"){
                    $("#btn_board_headline").addClass("on");
                    $("#btn_board_headline").html("전사공지 숨김");

                    $("#noticeYn").val("Y");
                    board1Obj.doSaveUserProfile("Y");
                }else{
                    $("#btn_board_headline").removeClass("on");
                    $("#btn_board_headline").html("전사공지 보기");
                    $("#noticeYn").val("N");
                    board1Obj.doSaveUserProfile("N");

                }
                board1Obj.doSearch();
            },
          doSaveUserProfile: function(mainBoardHeadlineYn){
                var url = contextRoot + "/user/changeUserProfile.do";
                var param = {
                        userId          : '${baseUserLoginInfo.userId}',                             //id
                        mainBoardHeadlineYn      : mainBoardHeadlineYn,
                        mainReqYn : 'Y'
                };

                var callback = function(result){

                    var obj = JSON.parse(result);

                    //세션로그아웃 >> 재로그인
                    if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
                        window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
                    }

                    var cnt = obj.resultVal;    //결과수

                    if(obj.result == "SUCCESS"){
                        //parent.toast.push("저장OK!");
                    }else{
                        //alertMsg();
                    }
                };
                commonAjax("POST", url, param, callback);
            }
    }

</script>
<!-- List Tmpl... -->
<script type="text" id = "board1Tmpl">
        <li>
            <div class="fl_block">
                <a href="javascript:board1Obj.openDetailPop('##board1ContentId##','##boardType##','##boardId##','##dtlYn##')" class="with80">
                    <span class="##boardTypeCss##">##boardTypeName##</span>
                    <span class="bs_title">##board1Message## ##board1Title##</span>
                </a>
                <span class="icon_comment" style="display:##board1CommentCntCss##">(##board1CommentCnt##)</span>
                <span class="icon_new" style="display:##board1NewCss##"><em>new</em></span>
                <span class="board_secret" style="display:##openFlagCss##"></span>
            </div>
            <div class="fr_block"><span class="bs_date">##board1Date##</span></div>
        </li>
</script>
<form id = "board1Frm" name = "board1Frm" method="get">
    <!-- 상세화면 이동을 위한 파라미터  :S -->
    <input type="hidden" name = "contentId">
    <input type="hidden" name = "cboardId">
    <input type="hidden" name = "gboardId">
    <input type="hidden" id="noticeYn" name = "noticeYn" value="${baseUserLoginInfo.mainBoardHeadlineYn}">

    <!-- 상세화면 이동을 위한 파라미터  :E -->
    <h2 class="module_title">
        <strong onclick="board1Obj.moveMorePage()">게시판</strong>
        <c:if test="${baseUserLoginInfo.vipAuthYn eq 'Y'}"><span>(전체)</span></c:if>
        <a href="javascript:board1Obj.doSearchHeadline(this);"  id="btn_board_headline" class="btn_board_headline${baseUserLoginInfo.mainBoardHeadlineYn eq 'Y' ? ' on':''}">
            전사공지 ${baseUserLoginInfo.mainBoardHeadlineYn eq 'Y' ? ' 숨김':' 보기'}
        </a>
        <!-- <a href="#" class="btn_board_headline on">전사공지 숨김</a> -->
    </h2>

    <div class="module_conBox" id="board1_conBox">
        <ul class="board_mbs_list"  id="board1_list"></ul>
        <%--<div class="m_nocontxt">내용이 없습니다.</div>--%>
    </div>
    <a href="javascript:board1Obj.moveMorePage();" class="btn_more"><em>더보기</em></a>
</form>