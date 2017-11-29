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

    <!--프로그램그룹 선택-->
    <h3 class="h3_title_basic mgt20">프로그램그룹</h3>
    <div class="car2_st_box">
        <span class="scroll_cover" onclick="fnObj.showAllGridGroup();"></span>
        <div class="scroll_header">
            <table class="car2_tb_st" summary="프로그램그룹(번호, 그룹ID, 그룹명, 그룹설명, 사용여부, 수정)">
                <caption>프로그램그룹</caption>
                <colgroup>
                    <col width="4%" /> <!--번호-->
                    <col width="20%" /> <!--그룹ID-->
                    <col width="20%" /> <!--그룹명-->
                    <col width="*" /> <!--그룹설명-->
                    <col width="8%" /> <!--사용여부-->
                    <col width="8%" /> <!--수정-->
                </colgroup>
                <thead>
                   <tr>
                      <th scope="col">번호</th>
                      <th scope="col">그룹ID</th>
                      <th scope="col">그룹명</th>
                      <th scope="col">그룹설명</th>
                       <th scope="col">사용여부</th>
                       <th scope="col">수정</th>
                   </tr>
                </thead>
           </table>
        </div>
        <div id="scroll_body_group" class="scroll_body">
            <table id="SGridTargetGroup" class="car2_tb_st" summary="프로그램그룹(번호, 그룹ID, 그룹명, 그룹설명, 사용여부, 수정)">
                <colgroup>
                    <col width="4%" /> <!--번호-->
                    <col width="20%" /> <!--그룹ID-->
                    <col width="20%" /> <!--그룹명-->
                    <col width="*" /> <!--그룹설명-->
                    <col width="8%" /> <!--사용여부-->
                    <col width="8%" /> <!--수정-->
                </colgroup>
                  <tbody></tbody>
            </table>
        </div>
    </div>
    <!--//프로그램그룹 선택//-->
    <!--<button type="button" class="AXButton Classic" style="margin-top:3px;" onclick="fnObj.addBoardGroup(0);">
        <i class="axi axi-add" style="font-size:12px;"></i>그룹추가</button>-->
    <div class="btn_baordZone2"><a href="#" onclick="fnObj.addBoardGroup(0);" class="btn_blueblack btn_auth">그룹추가</a></div>

    <!--그룹내 프로그램목록-->
    <h3 id="titleType" class="grid_title"></h3>
        <div class="car2_st_box">
            <span class="scroll_cover" onclick="fnObj.showAllGrid();"></span>
            <div class="scroll_header">
                 <table class="car2_tb_st" >
                     <caption>그룹내 프로그램목록</caption>
                     <colgroup>
                        <col width="4%"> <!--번호-->
                        <col width="8%"> <!--프로그램 ID-->
                        <col width="12%"> <!--프로그램 이름-->
                        <col width="10%"> <!--프로그램 설명-->
                        <col width="*"> <!--프로그램 URL-->
                        <col width="6%"> <!--사용여부-->
                        <col width="6%"> <!--헤드라인기능-->
                        <col width="6%"> <!--답글기능-->
                        <col width="6%"> <!--파일첨부기능-->
                        <col width="6%"> <!--관계사 승인 여부-->
                        <col width="6%"> <!--공개기간 여부-->
                        <col width="8%"> <!--노출목록 갯수-->
                        <col width="8%"> <!--페이지 갯수-->
                    </colgroup>
                     <thead>
                         <tr id="tblHeaderPart">
                            <th scope="col">번호</th>
                            <th scope="col">프로그램 ID</th>
                            <th scope="col">프로그램 이름</th>
                            <th scope="col">프로그램 설명</th>
                            <th scope="col">프로그램 URL</th>
                            <th scope="col">사용여부</th>
                            <th scope="col">헤드라인</th>
                            <th scope="col">답글</th>
                            <th scope="col">파일첨부</th>
                            <th scope="col">관계사 승인여부</th>
                            <th scope="col">공개기간 여부</th>
                            <th scope="col">노출목록 갯수</th>
                            <th scope="col">페이지 갯수</th>
                         </tr>
                     </thead>
                 </table>
             </div>

             <div id="scroll_body"  class="scroll_body">
                <table id="SGridTarget" class="car2_tb_st" summary="그룹내 프로그램목록 (번호, 프로그램 ID, 프로그램 이름, 프로그램 설명, 프로그램 URL, 사용여부, 헤드라인기능, 답글기능, 파일첨부기능, 노출리스트갯수, 페이지갯수)">
                    <colgroup>
                        <col width="4%"> <!--번호-->
                        <col width="8%"> <!--프로그램 ID-->
                        <col width="12%"> <!--프로그램 이름-->
                        <col width="10%"> <!--프로그램 설명-->
                        <col width="*"> <!--프로그램 URL-->
                        <col width="6%"> <!--사용여부-->
                        <col width="6%"> <!--헤드라인기능-->
                        <col width="6%"> <!--답글기능-->
                        <col width="6%"> <!--파일첨부기능-->
                        <col width="6%"> <!--관계사 승인 여부-->
                        <col width="6%"> <!--공개기간 여부-->
                        <col width="8%"> <!--노출리스트 갯수-->
                        <col width="8%"> <!--페이지 갯수-->
                    </colgroup>
                    <tbody></tbody>
                </table>
             </div>
        </div>
        <div class="btn_baordZone2"><a href="#" onclick="fnObj.addBoardCate(0);" class="btn_blueblack btn_auth">프로그램추가</a></div>
        <!--//그룹내 프로그램목록//-->

