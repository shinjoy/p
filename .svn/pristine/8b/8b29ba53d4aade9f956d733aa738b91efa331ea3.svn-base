<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<%@ include file="./js/approveLine_JS.jsp" %>



<section id="detail_contents">

<form name="frmApprove" id="frmApprove"  action="<c:url value='/approve/approveHeaderListAjax.do'/>" method="post">
<input type="hidden"  name="actionType"   id="actionType"  value="INSERT">
<input type="hidden" id="appvHeaderId" name="appvHeaderId"/>

    <!--결재라인관리제목-->
	<div class="board_classic">
	    <div class="leftblock">
	        <h3 class="h3_title_basic">결재라인 관리</h3>
	    </div>
	    <div class="rightblock">
	       <span id="searchAppvDocClassTag" ></span>
	    </div>
	</div>
	<!--//결재라인관리제목//-->
	<!-- ======================================= 결재라인 관리 :S ======================================== -->
    <div id = "listArea1">
        <jsp:include page="./include/approveLine_list1_INC.jsp"></jsp:include>
    </div>
    <!-- ======================================= 결재라인 관리 :E ======================================== -->

	<div class="datagrid_basic_wrap2 mgt20">
	    <table class="datagrid_basic" summary="결재라인 관리 (문서이름, 타입, 금액, 사용여부, 마감여부, 수정자, 등록자)">
	        <caption>프로젝트목록</caption>
	        <colgroup>
	            <col width="120px"/>
                <col width="120px"/>
                <col width="180px"  />
                <col width="120px"/>
                <col width="120px"/>
                <col width="120px" />
                <col width="80px" />
                <col width="80px" />
                <col width="100px" />
                <col width="100px" />
	        </colgroup>
	        <thead>
                <tr>
                    <th scope="col" rowspan="2">문서종류</th>
                    <th scope="col" rowspan="2">문서타입</th>
                    <th scope="col" rowspan="2">결재라인명</th>
                    <th scope="col" colspan="3">금액</th>
                    <th scope="col" rowspan="2">사용여부</th>
                    <th scope="col" rowspan="2">마감여부</th>
                </tr>
                <tr>
                	<th scope="col">전결사용</th>
                    <th scope="col">from</th>
                    <th scope="col">to</th>
                </tr>
            </thead>
	        <tbody>
	            <tr class="tr_divide_line inputselect">
	                <td>
	                   <span id="appvDocClassTag" ></span><!-- 문서종류선택 -->
	                </td>
	                <td>
	                   <span id="appvDocTypeTag" >
	                  		<select id = "appvDocType" name = "appvDocType" class="select_b w100pro">
	                  			<option value="">문서타입선택</option>
	                  		</select>
	                   </span><!-- 문서타입선택 :선택한 문서종류-->
	                </td>

	                <td><input type="text" class="input_b w100pro" id = "appvHeaderName" name = "appvHeaderName"> </td>
	                <td>
	                    <span class="radio_list2">
	                        <label><input type="radio"  id="decisionYn" name="decisionYn" onclick="decisionYnChk()"  value="Y" checked disabled="disabled"/><span>YES</span></label>
	                        <label><input type="radio"  id="decisionYn" name="decisionYn" onclick="decisionYnChk()"  value="N" disabled="disabled"><span>NO</span></label>
	                    </span>
	                </td>
	                <td><input type="text" id="minAmount"  name="minAmount"  maxlength="11" class="input_b w100pro num_money_type"  disabled="disabled"/></td>
	                <td><input type="text" id="maxAmount"  name="maxAmount"  maxlength="11"  class="input_b w100pro num_money_type" disabled="disabled" /></td>
	                <td>
	                    <span class="radio_list2">
	                        <label><input type="radio"  id="enable" name="enable"  value="Y" checked /><span>YES</span></label>
	                        <label><input type="radio"  id="enable" name="enable"  value="N" ><span>NO</span></label>
	                    </span>
	                </td>
	                <td>
	                    <span class="radio_list2">
	                        <label><input type="radio" id="closed" name="closed"  value="Y" /><span>YES</span></label>
	                        <label><input type="radio" id="closed" name="closed"  value="N"  checked /><span>NO</span></label>
	                    </span>
	                </td>
	            </tr>
	        </tbody>
	    </table>
	</div>
	<!--버튼영역-->
	<div class="btn_baordZone2">
	    <a href="javascript:setInsFormAppHeader();" class="btn_blueblack btn_auth">신규문서 추가</a>
	    <a href="javascript:doSaveAppHeader();" class="btn_witheline btn_auth">저장</a>
	     <a href="javascript:openCopyAppvLinePop();" class="btn_blueblack btn_auth">결재라인복사</a>
	</div>
	<!--//버튼영역//-->
</form>

	<!-- ======================================= 결재라인 상세정보 :S ======================================== -->
    <div id = "listArea2">
        <jsp:include page="./include/approveLine_list2_INC.jsp"></jsp:include>
    </div>
    <!-- ======================================= 결재라인 상세정보 :E ======================================== -->


	<!--버튼영역-->
	<div class="btn_baordZone2">
	    <a href="javascript:addRowLine();" class="btn_blueblack btn_auth">결재라인 추가</a>
	    <a href="javascript:doSaveAppLine();" class="btn_witheline btn_auth">저장</a>
	</div>
	<!--//버튼영역//-->

</section>