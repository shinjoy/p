<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="./js/workWeek_JS.jsp" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<style type="text/css">
.icon_teamwork { background:url(../images/work/icon_team_work.jpg) no-repeat 0 0; width:12px; height:12px; display:inline-block; margin-right:5px; vertical-align:middle; }

@page a4sheet {
	size: A4;
}

@media print{
	html,body {
		width : 27.0cm;
		margin : 0;
		padding : 0;
		overflow: visible;
	}

	#weekWorkCalArea{ width: 27.0cm;}
	.print_info_list .info_type_c1 { color:#274f84; margin-right:8px; font-size:11px; letter-spacing:-0.04em; }
	.print_info_list .info_type_c2 { color:#1b95da; margin-right:4px; letter-spacing:-0.04em; }
	.print_info_list .info_type_cway { border:#9aaacc solid 1px; background:#eef2f8; font-size:11px; color:#3d5da1; padding:2px 2px; padding:3px 2px 1px\0/IE8+9; line-height:1; margin-right:10px; min-width:30px; text-align:center; display:inline-block; letter-spacing:-0.02em; }

	/* IE10+ CSS styles go here */
	@media all and (-ms-high-contrast: none), (-ms-high-contrast: active) {
	.print_info_list .info_type_cway { padding:3px 2px 1px; }

	}
	.deatailconWrap .verticalWrap {background: none;}
	.print_info_list { padding:10px 12px 11px 15px;}
	.print_info_list li { float:none; *zoom:1; padding:3px; vertical-align:middle; position:relative; }
	.print_info_list li:hover { outline:#b9c1ce dashed 1px; }
	.print_info_list li:after { content:""; display:block; clear:both; height:0; }
	.print_info_list .fl_block { float:left; display:block; }
	.print_info_list .fl_block a {  color:#6f7073; letter-spacing:-0.05em; box-sizing:border-box; word-break:break-all; }
	.print_info_list .fl_block a span { }
	.print_info_list .fr_block { float:right; width:20%; white-space: nowrap; word-wrap: normal !important; font-size:11px; letter-spacing:-0.05em; padding-right:6px; box-sizing:border-box; text-align:right; }
	.print_info_list .fr_block span { letter-spacing:-0.05em; }

	.con_txt{word-break:break-all;}

	.icon_teamwork{display: block;}

}
.con_txt{word-break:break-all;}
.fl_block{word-break:break-all;}

</style>
<form name="weekWorkFrm" id="weekWorkFrm" method="post">
	<div class="verticalWrap">
		<div class="addAreaZone printOut">
			<div id="userListAreaTree">
			</div>
		</div>
		<section id="detail_contents">
			<!--업무일지-->
			<div class="carSearchBox printOut">
				<span class="carSearchtitle"><label for="choiceYear">년도선택</label></span>
				<span id="yearArea"></span>
				<span id="monthArea" class="btn_monthZone mgl10"></span>
				<div class="btnRightZone">
				    <button type="button" onClick="excelDownload();" class="btn_b2_skyblue"><em class="icon_XLS">파일로 저장</em></button>
				</div>
			</div>

			<!-- 일정부분 incluse -->
			<div id = "weekWorkCalArea">

			</div>

			<div class="btn_baordZone2">
				<a href="javascript:workWeekPrint()" class="btn_blueblack2">인쇄</a>
			</div>
		</section>
	</div>

</form>

<div id = "weekWorkCalAreaExcel" style="display: none;"></div>


