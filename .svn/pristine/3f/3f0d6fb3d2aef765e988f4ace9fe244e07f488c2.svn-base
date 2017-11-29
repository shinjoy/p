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
		board3Obj.doSearch();
	});
	var board3Obj = {
			doSearch : function(){
				$("#board3Frm").attr("action",contextRoot+"/basic/board/getBoard3List.do");
				commonAjaxSubmit("POST",$("#board3Frm"),board3Obj.mainboardObjCallback);

			},
			moveMorePage : function(){
				location.href = contextRoot+"/board/boardList/general/generalCompany.do";

			},
			mainboardObjCallback:function(data){
				$("#board3_boardlist").empty();

				var list = data.resultList;

				if(list == undefined || list.length<1){
					//nodata
					$("#board3_conBox").append("<div class=\"m_nocontxt\">내용이 없습니다.</div>");
				}else{
					for(var i = 0 ; i <list.length ; i++){

						var dataObj = list[i];
						//tmpl txt
						var board3Tmpl = $("#board3Tmpl").text();

						board3Tmpl = board3Tmpl.split("##board3ContentId##").join(dataObj.contentId);


						if(dataObj.allOrg == 'Y'){
							board3Tmpl = board3Tmpl.split("##board3Message##").join('<strong style="color:#a1a8b3;">['+dataObj.message+']</strong>');
						}else if(dataObj.message == '' && dataObj.checkNotice == 'Y'){
							board3Tmpl = board3Tmpl.split("##board3Message##").join('<strong style="color:#a1a8b3;">[공지]</strong>');
						}else{
							board3Tmpl = board3Tmpl.split("##board3Message##").join(dataObj.message);
						}

						/* if(dataObj.message == "" && dataObj.checkNotice == "Y"){
							board3Tmpl = board3Tmpl.split("##board3Message##").join('[선공지]');
						}else{
							board3Tmpl = board3Tmpl.split("##board3Message##").join(dataObj.message);
						} */
						board3Tmpl = board3Tmpl.split("##board3Title##").join(dataObj.title);

						//코멘트가 있는 경우
						if(parseInt(dataObj.commentCnt) != 0){
							board3Tmpl = board3Tmpl.split("##board3CommentCnt##").join(dataObj.commentCnt);
							board3Tmpl = board3Tmpl.split("##board3CommentCntCss##").join("inline");
						}else{
							board3Tmpl = board3Tmpl.split("##board3CommentCntCss##").join("none");
						}

						//오늘 올라온 글인 경우
						if(dataObj.newYn == 'Y'){
							board3Tmpl = board3Tmpl.split("##board3NewCss##").join("inline-block");
						}else{
							board3Tmpl = board3Tmpl.split("##board3NewCss##").join("none");
						}

						board3Tmpl = board3Tmpl.split("##board3CreateNm##").join(dataObj.createNm);
						board3Tmpl = board3Tmpl.split("##board3Date##").join(dataObj.creDate);

						$("#board3_boardlist").append(board3Tmpl);
					}

				}

			},
			//상세팝업
			openDetailPop : function(contentId){
				var frm = $("#board3Frm")[0];
				frm.contentId.value = contentId;
				frm.cboardId.value = "9";
				frm.action = contextRoot+"/board/boardContentView/general/generalCompany.do";
				frm.submit();
			},
	}

</script>
<!-- List Tmpl... -->
<script type="text" id = "board3Tmpl">
		<li>
			<div class="fl_block">
				<a href="javascript:board3Obj.openDetailPop('##board3ContentId##')" class="with80">
					<span class="bs_title">##board3Message## ##board3Title##</span>
				</a>
				<span class="icon_comment" style="display:##board3CommentCntCss##">(##board3CommentCnt##)</span>
				<span class="icon_new" style="display:##board3NewCss##"><em>new</em></span>
			</div>
			<div class="fr_block"><span class="bs_name">##board3CreateNm##</span><span class="bs_date">##board3Date##</span></div>
		</li>
</script>
<form id = "board3Frm" name = "board3Frm" method="post">
	<!-- 상세화면 이동을 위한 파라미터  :S -->
	<input type="hidden" name = "contentId">
	<input type="hidden" name = "cboardId">
	<!-- 상세화면 이동을 위한 파라미터  :E -->
<h2 class="module_title"><strong onclick="board3Obj.moveMorePage()">사내게시판</strong><span></span></h2>
<div class="module_conBox" id="board3_conBox">
	<ul class="board_mbs_list" id="board3_boardlist">
	</ul>
	<%--<div class="m_nocontxt">내용이 없습니다.</div>--%>
</div>
	<a href="javascript:board3Obj.moveMorePage();" class="btn_more"><em>더보기</em></a>
</form>