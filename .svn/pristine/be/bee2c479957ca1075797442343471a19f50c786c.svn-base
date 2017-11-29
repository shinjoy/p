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
		board2Obj.doSearch();
	});
	var board2Obj = {
			doSearch : function(){
				$("#board2Frm").attr("action",contextRoot+"/basic/board/getBoard2List.do");
				commonAjaxSubmit("POST",$("#board2Frm"),board2Obj.mainboardObjCallback);

			},
			moveMorePage : function(){
				location.href = contextRoot+"/board/boardList/general/generalWork.do";

			},
			mainboardObjCallback:function(data){
				$("#board2_boardlist").empty();

				var list = data.resultList;
				//console.log(list);

				if(list == undefined || list.length<1){
					//nodata
					$("#board2_conBox").append("<div class=\"m_nocontxt\">내용이 없습니다.</div>");
				}else{
					for(var i = 0 ; i <list.length ; i++){

						var dataObj = list[i];
						//tmpl txt
						var board2Tmpl = $("#board2Tmpl").text();

						board2Tmpl = board2Tmpl.split("##board2ContentId##").join(dataObj.contentId);
						if(dataObj.allOrg == 'Y'){
							board2Tmpl = board2Tmpl.split("##board2Message##").join('<strong style="color:#a1a8b3;">['+dataObj.message+']</strong>');
						}else if(dataObj.message == '' && dataObj.checkNotice == 'Y'){
							board2Tmpl = board2Tmpl.split("##board2Message##").join('<strong style="color:#a1a8b3;">[공지]</strong>');
						}else{
							board2Tmpl = board2Tmpl.split("##board2Message##").join(dataObj.message);
						}
						board2Tmpl = board2Tmpl.split("##board2Title##").join(dataObj.title);

						//코멘트가 있는 경우
						if(parseInt(dataObj.commentCnt) != 0){
							board2Tmpl = board2Tmpl.split("##board2CommentCnt##").join(dataObj.commentCnt);
							board2Tmpl = board2Tmpl.split("##board2CommentCntCss##").join("inline");
						}else{
							board2Tmpl = board2Tmpl.split("##board2CommentCntCss##").join("none");
						}

						//오늘 올라온 글인 경우
						if(dataObj.newYn == 'Y'){
							board2Tmpl = board2Tmpl.split("##board2NewCss##").join("inline-block");
						}else{
							board2Tmpl = board2Tmpl.split("##board2NewCss##").join("none");
						}

						board2Tmpl = board2Tmpl.split("##board2CreateNm##").join(dataObj.createNm);
						board2Tmpl = board2Tmpl.split("##board2Date##").join(dataObj.creDate);

						$("#board2_boardlist").append(board2Tmpl);
					}

				}

			},
			//상세팝업
			openDetailPop : function(contentId){
				var frm = $("#board2Frm")[0];
				frm.contentId.value = contentId;
				frm.cboardId.value = "11";
				frm.action = contextRoot+"/board/boardContentView/general/generalWork.do";
				frm.submit();
			},
	}

</script>
<!-- List Tmpl... -->
<script type="text" id = "board2Tmpl">
		<li>
			<div class="fl_block">
				<a href="javascript:board2Obj.openDetailPop('##board2ContentId##')">
					<span class="bs_title">##board2Message## ##board2Title##</span>
				</a>
				<span class="icon_comment" style="display:##board2CommentCntCss##">(##board2CommentCnt##)</span>
				<span class="icon_new" style="display:##board2NewCss##"><em>new</em></span>
			</div>
			<div class="fr_block"><span class="bs_name">##board2CreateNm##</span><span class="bs_date">##board2Date##</span></div>
		</li>
</script>
<form id = "board2Frm" name = "board2Frm" method="post">
	<!-- 상세화면 이동을 위한 파라미터  :S -->
	<input type="hidden" name = "contentId">
	<input type="hidden" name = "cboardId">
	<!-- 상세화면 이동을 위한 파라미터  :E -->
<h2 class="module_title"><strong onclick="board2Obj.moveMorePage()">업무게시판</strong><span></span></h2>
<div class="module_conBox" id="board2_conBox">
	<ul class="board_mbs_list" id="board2_boardlist">
	</ul>
	<%--<div class="m_nocontxt">내용이 없습니다.</div>--%>
</div>
	<a href="javascript:board2Obj.moveMorePage();" class="btn_more"><em>더보기</em></a>
</form>