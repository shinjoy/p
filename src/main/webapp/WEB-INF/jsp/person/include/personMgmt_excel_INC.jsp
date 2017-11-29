<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


                            <!-- 네트워크리스트 -->
                            <table id="SGridTarget"  class="tb_list_basic" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
                                <caption>고객관리 리스트</caption>
                                <colgroup>
                                    <col width="70" /> <!--이름-->
                                    <col width="100" /> <!--업종-->
                                    <col width="180" /> <!--회사-->
                                    <col width="100" /> <!--부서-->
                                    <col width="150" /> <!--직책-->
                                    <col width="100" /> <!--연락처-->
                                    <col width="150" /> <!--이메일-->
                                    <col width="60" /> <!--담당자-->
                                    <col width="60" /> <!--친밀도-->
                                    <col width="70" /> <!--연락-->
                                    <col width="90" /> <!--내용-->
                                    <col width="60" /> <!--등록자-->
                                    <col width="80" /> <!--등록일-->
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th rowspan="2" scope="col">이름</th>
                                        <th rowspan="2" scope="col">업종</th>
                                        <th rowspan="2" scope="col">회사</th>
                                        <th colspan="4" scope="col">기본정보</th>
                                        <th colspan="2" scope="col">네트워크</th>
                                        <th colspan="3" scope="col">최근정보</th>
                                        <th rowspan="2" scope="col">등록일</th>
                                    </tr>
                                    <tr>
                                        <th scope="col">부서</th>
                                        <th scope="col">직책</th>
                                        <th scope="col">연락처</th>
                                        <th scope="col">이메일</th>
                                        <th scope="col">담당자</th>
                                        <th scope="col">친밀도</th>
                                        <th scope="col">연락일</th>
                                        <th scope="col">내용</th>
                                        <th scope="col">등록자</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${custList }" var="data" varStatus="status">
                                        <tr>
                                            <td>${data.cstNm }</td>
                                            <td>${data.custTypeNm }</td>
                                            <td>${data.cpnNm }</td>
                                            <td>${data.team }</td>
                                            <td>${data.position }</td>
                                            <td>${data.phn1 }</td>
                                            <td>${data.email }</td>
                                            <td>${data.usrNm }</td>
                                            <td>${data.lvCd }</td>
                                            <td>${data.lastDt }</td>
                                            <td>${data.lastType }</td>
                                            <td>${data.lastNm }</td>
                                            <td>${data.rgDt }</td>
                                        </tr>
                                    </c:forEach>


                                </tbody>
                            </table>


