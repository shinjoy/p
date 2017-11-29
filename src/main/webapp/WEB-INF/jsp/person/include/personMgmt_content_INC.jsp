<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(document).ready(function(){

});
</script>
                            <!--테이블 타이틀-->
                            <h3 class="h3_title_basic mgt30">
                                <span><span id="spanChargeNm">담당자 : ${baseUserLoginInfo.userName}</span> (<span id="total_count"></span> 건)</span>
                            </h3>

                            <!--//테이블 타이틀//-->
                            <!--선택결과-->
                            <div id="divResultStaff" class="chooseResult">
                                <dl>
                                    <dt>선택한 속성</dt>
                                    <dd>
                                        <div id="divStaffNameList" class="ellipsis">
                                        </div>
                                    </dd>
                                </dl>
                            </div>
                            <!--//선택결과//-->

                            <!--네트워크리스트-->
                            <table id="SGridTarget"  class="tb_list_basic" summary="고객관리 리스트(이름, 업종, 회사, 기본정보, 네트워크, 최근정보, 시너지와의 이력)">
                                <caption>고객관리 리스트</caption>
                                <colgroup>
                                    <col width="35" /> <!--선택-->
                                    <col width="70" /> <!--이름-->
                                    <col width="100" /> <!--업종-->
                                     <col width="70" /> <!--이름-->
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
                                        <th rowspan="2" scope="col" class="checkinput"><label><input onclick="fnObj.chkCustAll(this);" type="checkbox" /><em>전체선택</em></label></th>
				                        <th rowspan="2" scope="col">이름</th>
                                        <th rowspan="2" scope="col">인물구분</th>
                                        <th rowspan="2" scope="col">국내외<br>구분</th>
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

                                </tbody>
                            </table>

                            <!--페이지버튼-->
				           <div class="btnPageZoneWrap">
				            <div class="btnPageZone" id="btnPageZone">
				                <button type="button" class="pre_end_btn"><em>맨처음 페이지</em></button>
				                <button type="button" class="pre_btn"><em>이전 페이지</em></button>
				                <!-- ////////// 페이지 숫자 버튼 위치 ///////// -->
				                <button type="button" class="next_btn"><em>다음 페이지</em></button>
				                <button type="button" class="next_end_btn"><em>맨마지막 페이지</em></button>
				            </div>
				           </div>

                            <!--게시판페이지버튼-->
                            <!-- <div class="btnPageZone">
                                <button type="button" class="pre_end_btn"><em>맨처음 페이지</em></button>
                                <button type="button" class="pre_btn"><em>이전 페이지</em></button>
                                <span><a href="#">1</a></span>
                                <span><a href="#">2</a></span>
                                <span><a href="#">3</a></span>
                                <span class="current"><a href="#">4</a></span>
                                <span><a href="#">5</a></span>
                                <span><a href="#">6</a></span>
                                <span><a href="#">7</a></span>
                                <span><a href="#">8</a></span>
                                <span><a href="#">9</a></span>
                                <span><a href="#">10</a></span>
                                <button type="button" class="next_btn"><em>다음 페이지</em></button>
                                <button type="button" class="next_end_btn"><em>맨마지막 페이지</em></button>
                            </div> -->
                            <!--//게시판페이지버튼//-->


