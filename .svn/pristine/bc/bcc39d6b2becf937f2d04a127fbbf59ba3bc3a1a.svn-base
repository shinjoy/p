<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>


                        <div class="wrap_autoscroll2">
                            <h3 class="title">
                                <c:forEach var="data" items="${worktimeList}" varStatus="status"><c:if test="${status.first}">${data.name }(${data.position })</c:if></c:forEach>_ 근태목록</h3>
                            <span class="intext">
                                <table class="tb_list_basic3">
                                    <colgroup>
                                        <col width="50%">
                                        <col width="*">
                                        <%-- <col width="*"> --%>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">날짜</th>
                                            <th scope="col">구분</th>
                                            <!-- <th scope="col">내용</th> -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="data" items="${worktimeList}" varStatus="status">
	                                        <tr>
	                                            <td class=" txt_letter0">${data.workDate }</td>
	                                            <td><span class="st_at_late">${data.workTypeNm }</span></td>
	                                            <!-- <td class="txt_left">늦잠잤습니다. 죄송합니다.</td> -->
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="btn_popZone2 mgt15">
                                    <a class="btn_witheline" href="javascript:closeShowlayer('attendanceBox_${searchUserId }${searchMonth }');">닫힘</a>
                                </div>
                            </span>
                            <em class="edge_bottomcenter"></em>
                        </div>