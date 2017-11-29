<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<jsp:useBean id="now" class="java.util.Date" />

 <div class="doc_AllWrap">
     <!--서식셋팅-->
     <h3 class="h3_title_basic mgt20">
         <span>재무담당자 설정</span>
         <a class="s_violet01_btn mgl15" href="javascript:fnObj.openEmpPopup('EXPENSE', '', '');"><em>직원선택</em></a>
     </h3>
     <article class="paymentsetBox">
         <div class="gray_notibox" id="spanExpense">
             <c:forEach items="${appvManagerSetupList}" var="data" varStatus="status">
                <span class="employee_list" >
                  <span>${data.userName }</span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>
                  <input type="hidden" name="arrUserId" id="arrUserId" value="${data.userId }" />
                </span>
            </c:forEach>
             <!-- <span class="employee_list"><span>박정인</span><em>(대리)</em><a class="btn_delete_employee" href="#"><em>삭제</em></a></span> -->
         </div>
         <p class="notice_script">* 설정된 재무담당자는 결재 종결된 지출결의서를 수신하여 지급여부 관리 권한과 지출등록 승인권한을 가지게 됩니다. 재무담당자를 설정하지 않으면 지출결의서를 상신할 수 없습니다.</p>
     </article>
     <h3 class="h3_title_basic"><span>지출일 설정</span>
           <select id = "expenseDay" name = "expenseDay" class="input_b w_date mgr6 mgl15">
           		<c:forEach var="day" begin="1" end="31" step="1">
           			<option value="${day }">${day }일</option>
           		</c:forEach>
               <option value="32">말일</option>
           </select>
           <a class="s_violet01_btn" href="javascript:fnObj.addExpenseDay();"><em>추가</em></a>
     </h3>

     <article class="paymentsetBox">
         <div class="gray_notibox" id="spanExpenseDay">
             <c:forEach items="${appvDaySetupList}" var="data" varStatus="status">
                <span class="employee_list" >
                  <span>${data.expenseDay eq 32?'말':data.expenseDay }일</span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>
                  <input type="hidden" name="arrExpenseDay" id="arrExpenseDay" value="${data.expenseDay }" />
                </span>
            </c:forEach>
         </div>
     </article>
     <h3 class="h3_title_basic">지출결의서 서식 내용란에 보여질 안내 문구</h3>
     <article class="paymentsetBox last">
         <textarea class="txtarea_b w100pro" id="memo" name="memo" placeholder="지출결의서 관련한 상세 내역에 대한 추가적인 설명과 입급 계좌 정보 수령자에 대한 추가 정보 등을 입력해주십시오.">${appvReceiverSetup.memo}</textarea>
     </article>
     <!--//서식셋팅//-->

     <!--버튼영역-->
    <div class="btn_baordZone2">
        <a href="javascript:doSave();" class="btn_blueblack btn_auth">저장</a>
        <a href="javascript:doSearch();" class="btn_witheline btn_auth">취소</a>
    </div>
    <!--//버튼영역//-->
 </div>


<input type="hidden" name = "createdBy" value="${data.createdBy }">
<input type="hidden" name = "createDate" value="${data.createDate }">



