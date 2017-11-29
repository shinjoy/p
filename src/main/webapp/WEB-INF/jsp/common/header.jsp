<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="customTagUi" uri="/WEB-INF/tlds/ui.tld"%>

<customTagUi:useConstants var="Constants" className="ib.common.constants.Constants" />
<%--
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");

--%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%-- <title><spring:message code='title.pass' /></title> --%>
<title><c:out value="${fn:replace(currentMenuKorTitle,'#PROJECT#',baseUserLoginInfo.projectTitle)}"></c:out><c:if test="${fn:length(currentMenuKorTitle)>0}"> - </c:if>PASS</title>
<%-- <meta property="og:url" content="${pageContext.request.contextPath}"> --%>
<meta property="og:title" content="나의 업무관리 시스템 PASS">
<meta property="og:image" content="${pageContext.request.contextPath}/images/og_pass_11.png">
<meta property="og:description" content="회사 업무관리 시스템 PASS를 통해 업무 효율성을 높이세요.">


<meta name="keywords" content="PASS, 업무파트너, 업무관리시스템, 스케쥴관리, 업무관리, 인사관리, 팀업무관리, 영업관리, 정보관리, 네트워크, 내부인트라넷, 그룹웨어, 지출관리, 지출통계, Project, Activity" />
<meta name="description" content="PASS : Project based Activity Analysis " />
<meta name="author" content="admin@synergynet.co.kr" />
<meta name="copyright" content="COPYRIGHT@ Synergy. All Rights Reserved." />


<!-- ============== ajax화면 마스킹 :S ============== -->
<style type="text/css">
	#ajaxProgress_mask {
		position: absolute;
		z-index: 900000;
		background-color: #A9A9A9;
		display: none;
		left: 0;
		top: 0;
		height: 100%;
	}
	#ajaxProgress_progress {
		position: fixed;
		z-index: 900001;
		display: none;
		left: 50%;
		top: 50%;
	    width: 300px;
	    height: 200px;
	    text-align:center;
	    margin-top: -150px;
	    margin-left: -100px;
	}
	</style>
<!-- ============== ajax화면 마스킹 :E ============== -->
<!-- ============== style css :S ============== -->
<link href="${pageContext.request.contextPath}/images/pass.ico" rel="shortcut icon" type="image/x-icon">		<!-- icon -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jstree/style.css" />					<!-- jstree -->	<!-- style.min.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">								<!-- jquery-ui -->

<!-- 버젼관리 css -->
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/> --%>				<!-- design css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/n_default.css?version=${Constants.DELPOYEE_DATE_VERSION}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/n_font.css?version=${Constants.DELPOYEE_DATE_VERSION}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/n_layout.css?version=${Constants.DELPOYEE_DATE_VERSION}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/n_common.css?version=${Constants.DELPOYEE_DATE_VERSION}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/n_typography.css?version=${Constants.DELPOYEE_DATE_VERSION}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/new_common.css?version=${Constants.DELPOYEE_DATE_VERSION}"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/new_contents.css?version=${Constants.DELPOYEE_DATE_VERSION}"/>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/print.css?version=${Constants.DELPOYEE_DATE_VERSION}"/>
<!--  -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery.orgchart.css"/>
<!-- ============== style css :E ============== -->


<!--html5새로생성된 태그가 IE6~8에서 적용되게 하는 js파일-->
    <!--[if lt IE 9]>
            <script src="${pageContext.request.contextPath}/js/html5shiv.js" ></script>
    <![endif]-->

    <!--미디어쿼리가 IE6~8에서 적용되게 하는 js파일-->
    <!--[if lt IE 9]>
            <script src="${pageContext.request.contextPath}/js/respond.min.js" ></script>
    <![endif]-->

    <!-- Load jQuery Here -->
    <!--이유는 모르겠으나...익스8에서 깨지게 되어서 변경함 로컬에선 문제가 없는데...뭔가 꼬인듯합니다.-->
    <!--[if lt IE 7]>
            <script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js"></script>
            <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
            <script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
    <![endif]-->



<script>var contextRoot="${pageContext.request.contextPath}";</script><!-- necessary! to import js files -->

<!-- 버전관리 js :S-->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/common.js?version=${Constants.DELPOYEE_DATE_VERSION}"></script><!-- jquery , ajaxRequest, etc -->
<!-- 버전관리 js :E-->


<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/sys/utils.js"></script><!-- util folder -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/html5.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/autolink.js"></script><!-- url자동링크 -->

<!-- -------------- axisj source include (JS, CSS) :S -------------- -->
<%@ include file="/includeAxisj.jsp" %>
<!-- -------------- axisj source include (JS, CSS) :E -------------- -->


<!-- -------------- sjs (JS) :S -------------- -->
<!-- 버전관리 js :S-->
<script type="text/javascript" src="${pageContext.request.contextPath}/sjs/SGrid.js?version=${Constants.DELPOYEE_DATE_VERSION}"></script>
<!-- 버전관리 js :E-->
<!-- -------------- sjs (JS) :E -------------- -->


<!-- -------------- jstree :S  ----------------- -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jstree/jstree.min.js"></script>
<!-- 버전관리 js :S-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/UserTree.js?version=${Constants.DELPOYEE_DATE_VERSION}""></script>			<!-- jstree 사용하여 사용자선택 트리 공통 구현 -->
<!-- 버전관리 js :E-->
<!-- -------------- jstree :E  ----------------- -->



<!-- -------------- orgchart :S  ----------------- -->
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/orgchart/jquery.orgchart.js"></script> --%>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.orgchart.js?ver=0.1"></script>

<!-- -------------- orgchart :E  ----------------- -->



<!-- -------------- img 확대 :S  ----------------- -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/image-tooltip.js"></script>
<!-- -------------- img 확대 :E  ----------------- -->


<!-- -------------- 파일 업로드 :S  ----------------- -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<!-- -------------- 파일 업로드 :E  ----------------- -->


<!-- -------------- placeholder ie9 적용 :S  ----------------- -->
<!--[if lte IE 9]>
	<%--<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/placeholders.min.js"></script>--%>
<![endif]-->
<!-- -------------- placeholder ie9 적용 :E  ----------------- -->


<%--</head> layout 에 있다 --%>

<!-- -------------- left menu visible setting :S ------------- -->
<!-- ** 왼쪽 메뉴를 보일지 여부 위한 스크립트 ** -->
<script type="text/javascript" defer="defer">
//유저프로필박스 업무메모보내기 모달
var personnelProfileMemoModal = new AXModal();		// instance
personnelProfileMemoModal.setConfig({
	windowID:"myModalCT",

	width:740,
    mediaQuery: {
        mx:{min:0, max:767}, dx:{min:767}
    },
	displayLoading:true,
    scrollLock: false,
	onclose: function(){
	}
    ,contentDivClass: "popup_outline"

});
//아이작스 화면보호기
$(document).ajaxStart(function(){
	if($(this).context.forms.personnelProfileFrm==undefined||$(this).context.forms.personnelProfileFrm==null){
		progressView();
		wrapWindowByMask();
	}
});
$(document).ajaxStop(function(){
	if($(this).context.forms.personnelProfileFrm==undefined||$(this).context.forms.personnelProfileFrm==null){
		if(spinner_main){
			spinner_main.stop();
			$("#ajaxProgress_progress").hide();
			$('#ajaxProgress_mask').stop(true,true);
			$('#ajaxProgress_mask').hide();
		}
	}

});
function setVisibleLeftMenuSpace(n){

	var containerNm = 'container';

	if(document.getElementById('container')==null){
		containerNm = 'ADM_container';
	}

	var divLeft = $('#' + containerNm + ' > div')[0];		//왼쪽 메뉴 공간 div

	if(n==0){
		$(divLeft).hide();
		$('#btnLeftMenuHide').hide();	//왼쪽메뉴 숨김버튼 숨기기
		$('#btnLeftMenuShow').show();	//왼쪽메뉴 보기버튼 보이게

		$('#contentsWrap').css('width', '100%');	//내용 100%

		//body 왼쪽메뉴 수직라인bg 숨기기
		$('#M_body').css('background', '#eee');
		$('#sub_body').css('background', 'none');

	}else{
		$(divLeft).show();
		$('#btnLeftMenuHide').show();
		$('#btnLeftMenuShow').hide();

		$('#contentsWrap').css('width', 'auto');	//내용 83%(원복)

		//body 왼쪽메뉴 수직라인bg 보이기
		$('#M_body').css('background', 'url(${pageContext.request.contextPath}/images/common/bg_m_body.png) repeat-y 0 0 #eee');
		$('#sub_body').css('background', 'url(${pageContext.request.contextPath}/images/common/bg_snb.png) repeat-y 200px 0');
	}
}


//로그인 사용자의 관계사별 권한을구함
//orgId : 조회할 orgId
//권한이 없을경우 NONE을 반환한다
function getOrgAccessAuth(orgId){
	var orgAuthList = new Array();
	<c:forEach items="${accessOrgIdList}" var = "data">
		var valueStr = "${data.orgId},${data.orgAccessAuthType}";
		orgAuthList.push(valueStr);
	</c:forEach>
	var returnStr = "NONE"
	for(var i = 0 ; i <orgAuthList.length; i++){
		var value = orgAuthList[i].split(",");
		if(orgId == value[0]) returnStr = value[1];
	}
	return returnStr;
}

//로그인한 ORG ID값리턴
var mainObj = {
		getOrgId : function(){  //적용된 ORG ID값 리턴
		    return '${baseUserLoginInfo.orgId}';
	    },

	    getApplyOrgId : function(){
	    	return '${baseUserLoginInfo.applyOrgId}';
        },

        getSynergyYn : function(){  //시너지 여부
        	return "${baseUserLoginInfo.orgId eq '1' ? 'Y' : 'N'}";
        }
}


</script>
<c:choose>
	<c:when test="${baseUserLoginInfo.orgId eq baseUserLoginInfo.applyOrgId}"> <%-- 부서가 회장, 그룹대표, 대표 여부(시너지유저포함) 유저설정 위한 설정 --%>
		<script>	<%-- SCRIPT --%>
		var g_other_org_yn = 'N';									/* 다른 관계사를 보고 있는지 */
		</script>
	</c:when>
	<c:when test="${baseUserLoginInfo.orgId ne baseUserLoginInfo.applyOrgId}">	<%-- 다른 관계사를 볼때 --%>
		<script>
		var g_other_org_yn = 'Y';									/* 다른 관계사를 보고 있는지  */
		</script>
	</c:when>
</c:choose>

<!-- 주석아니므로 삭제하지 마세요!!!!!!!!!!!  HTML5 -->

<!--[if lte IE 9]>
<script>
//IE9이하 placeholder 지원하지 않는 케이스에서 사용
jQuery(function(){
	//$('input, textarea').placeholder();
	/* if(!("placeholder" in document.createElement("input"))){
        jQuery(":input[placeholder]").each(function () {
            var $this = jQuery(this);
            var pos = $this.offset();
            if (!this.id) this.id = "jQueryVirtual_" + this.name;

        }).focus(function () {
            var $this = jQuery(this);
            $this.addClass("focusbox");
            jQuery("#jQueryVirtual_label_" + $this.attr("id")).hide();

        }).blur(function () {
            var $this = jQuery(this);
            $this.removeClass("focusbox");
            if(!jQuery.trim($this.val()))
                jQuery("#jQueryVirtual_label_" + $this.attr("id")).show();
            else jQuery("#jQueryVirtual_label_" + $this.attr("id")).hide();
        }).trigger("blur");
    } */
});
</script>
<![endif]-->
<!-- 주석아니므로 삭제하지 마세요!!!!!!!!!!!  HTML5 -->



<!-- -------------- left menu visible setting :E ------------- -->
<!-- 화면 마스크용 -->
<div id="ajaxProgress_mask"></div>
<div id="ajaxProgress_progress"></div>
<div class="printOut" id = "personnelProfileArea" style="display:none;" >
</div>
<span id="memoCommonHelpPop" style="z-index: 9999999999;width: 400px;padding:1px,1px,1px,1px; ">
	<div class="fl_block explain_tooltip">
		<div class="tooltip_box wrap_autoscroll" id = "memoCommonHelpPopTooltipBox">
			 <span class="intext" id = "memoCommonHelpPopStr" style="padding-right: 5px;">
			 </span>
			 <em class="edge_topleft"></em>
			 <a href="javascript:closeMemoHelpArea();" class="closebtn"><img src="${pageContext.request.contextPath}/images/network/btn_tooltip_closed.gif" alt="닫기"></a>
		</div>
	</div>
</span>


