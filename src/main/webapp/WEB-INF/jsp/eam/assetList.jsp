<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<section id="detail_contents">
	<table class="datagrid_basic lineadd" summary="차량관리 리스트(차량코드, 차량번호, 모델명, 오토, 누적거리, 사용여부, 상태, 사진)">
		<colgroup>
		<col>
		<col span="4">
		<col>
		<col>
		<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">회사명</th>
				<th scope="col">자산 분류</th>
				<th scope="col">규격(모델명)</th>
				<th scope="col">최초 취득 원가</th>
				<th scope="col">최초 취득일</th>
				<th scope="col">위치</th>
				<th scope="col">운용자(운용부서)</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${baseUserLoginInfo.applyOrgId eq '1' }">
			<!--시너지-->
			<tr>
				<th scope="row">㈜시너지이노베이션</th>
				<td>차량</td>
				<td>냉동탑차</td>
				<td class="num_money_type">₩23,851,963</td>
				<td>2015.01.26</td>
				<td>본점소재지</td>
				<td>영업지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">에이엠테크놀로지</th>
				<td>차량</td>
				<td>렉서스</td>
				<td class="num_money_type">₩26,019,296</td>
				<td>2015.04.17</td>
				<td>본사</td>
				<td>대표이사</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">에이엠테크놀로지</th>
				<td>건물</td>
				<td>본사</td>
				<td class="num_money_type">₩1,188,508,507</td>
				<td>2010.05.19</td>
				<td>본사</td>
				<td>대표이사</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">에이엠테크놀로지</th>
				<td>건물</td>
				<td>생산동</td>
				<td class="num_money_type">₩1,149,510,880</td>
				<td>2011.09.19</td>
				<td>본사</td>
				<td>대표이사</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">에이엠테크놀로지</th>
				<td>토지</td>
				<td>&nbsp;-&nbsp;</td>
				<td class="num_money_type">₩1,851,283,430</td>
				<td>2010.05.19</td>
				<td>본사</td>
				<td>대표이사</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜휴버트바이오</th>
				<td>건물</td>
				<td>네오메디클리닉</td>
				<td class="num_money_type">₩2,831,000,000</td>
				<td>&nbsp;-&nbsp;</td>
				<td>충청북도    충주시 성서도 228외 2필지 (8개 호실)</td>
				<td>관리부</td>
				<td>현재 매각 진행 중.</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>차량</td>
				<td>모닝</td>
				<td class="num_money_type">₩1,007,816</td>
				<td>2017.06.13</td>
				<td>성남 지점</td>
				<td>쇄석기사업본부</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>차량</td>
				<td>모닝</td>
				<td class="num_money_type">₩1,538,584</td>
				<td>2017.06.14</td>
				<td>성남    지점</td>
				<td>쇄석기사업본부</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>차량</td>
				<td>레이</td>
				<td class="num_money_type">₩4,289,443</td>
				<td>2017.06.15</td>
				<td>성남    지점</td>
				<td>쇄석기사업본부</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>차량</td>
				<td>모닝</td>
				<td class="num_money_type">₩1,318,959</td>
				<td>2017.06.16</td>
				<td>성남    지점</td>
				<td>쇄석기사업본부</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>토지</td>
				<td>본사(평택)</td>
				<td class="num_money_type">₩373,352,300</td>
				<td>2002.08.09</td>
				<td>하북리    241-3외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>토지</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩923,537,870</td>
				<td>2006.12.31</td>
				<td>봉남리    46-1외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>토지</td>
				<td>제천</td>
				<td class="num_money_type">₩42,083,340</td>
				<td>2008.01.07</td>
				<td>월악리    729-1</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>토지</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩42,391,000</td>
				<td>2010.07.27</td>
				<td>봉남리44-2외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>건물</td>
				<td>본사(평택)</td>
				<td class="num_money_type">₩1,799,554,376</td>
				<td>2003.08.01</td>
				<td>하북리    241-3외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>건물</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩734,373,260</td>
				<td>2011.01.31</td>
				<td>봉남리    46-1외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>건물</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩294,629,000</td>
				<td>2015.11.27</td>
				<td>봉남리    46-1외<br>
					(증축)</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>건물</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩187,751,200</td>
				<td>2016.05.09</td>
				<td>봉남리    46-외<br>
					(창고)</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>콘도 회원권</td>
				<td>㈜대명리조트</td>
				<td class="num_money_type">₩77,051,360</td>
				<td>2014.05.15</td>
				<td>&nbsp;-&nbsp;</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>콘도 회원권</td>
				<td>㈜리솜리조트</td>
				<td class="num_money_type">₩38,435,750</td>
				<td>2015.09.04</td>
				<td>&nbsp;-&nbsp;</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>골프 회원권</td>
				<td>기흥CC</td>
				<td class="num_money_type">₩221,919,690</td>
				<td>2014.09.05</td>
				<td>본사(평택)</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>골프 회원권</td>
				<td>양주CC</td>
				<td class="num_money_type">₩72,500,190</td>
				<td>2015.05.08</td>
				<td>본사(평택)</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">혜성씨앤씨㈜</th>
				<td>차량</td>
				<td>포터/소형화물</td>
				<td class="num_money_type">₩5,335,120</td>
				<td>2000.03.08</td>
				<td>전북 익산시</td>
				<td>물류팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">혜성씨앤씨㈜</th>
				<td>토지</td>
				<td>공장부지</td>
				<td class="num_money_type">₩590,314,875</td>
				<td>2001.6.01    외</td>
				<td>전북    익산시 삼기면 기산리 325-21,23,25</td>
				<td>공장&nbsp;</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">혜성씨앤씨㈜</th>
				<td>건물</td>
				<td>공장건물</td>
				<td class="num_money_type">₩2,262,800,177</td>
				<td>2001.06.01    외</td>
				<td>전북    익산시 삼기면 기산리 325-21,23,25</td>
				<td>공장&nbsp;</td>
				<td>2016년    결산건물가액</td>
			</tr>
			<tr>
				<th scope="row">재원씨앤씨</th>
				<td>차량</td>
				<td>아우디</td>
				<td class="num_money_type">&nbsp;-&nbsp;</td>
				<td>&nbsp;-&nbsp;</td>
				<td>&nbsp;-&nbsp;</td>
				<td>대표이사</td>
				<td>리스차량</td>
			</tr>
			<!-- //시너지// -->
		</c:when>
		
		<c:when test="${baseUserLoginInfo.applyOrgId eq '55' }">
			<!--시너지이노베이션-->
			<tr>
				<th scope="row">㈜시너지이노베이션</th>
				<td>차량</td>
				<td>냉동탑차</td>
				<td class="num_money_type">₩23,851,963</td>
				<td>2015.01.26</td>
				<td>본점소재지</td>
				<td>영업지원팀</td>
				<td>　</td>
			</tr>
			<!--//시너지이노베이션//-->
		</c:when>
		
		<c:when test="${baseUserLoginInfo.applyOrgId eq '59' }">
			<!--에이엠테크놀로지-->
			<tr>
				<th scope="row">에이엠테크놀로지</th>
				<td>차량</td>
				<td>렉서스</td>
				<td class="num_money_type">₩26,019,296</td>
				<td>2015.04.17</td>
				<td>본사</td>
				<td>대표이사</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">에이엠테크놀로지</th>
				<td>건물</td>
				<td>본사</td>
				<td class="num_money_type">₩1,188,508,507</td>
				<td>2010.05.19</td>
				<td>본사</td>
				<td>대표이사</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">에이엠테크놀로지</th>
				<td>건물</td>
				<td>생산동</td>
				<td class="num_money_type">₩1,149,510,880</td>
				<td>2011.09.19</td>
				<td>본사</td>
				<td>대표이사</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">에이엠테크놀로지</th>
				<td>토지</td>
				<td>&nbsp;-&nbsp;</td>
				<td class="num_money_type">₩1,851,283,430</td>
				<td>2010.05.19</td>
				<td>본사</td>
				<td>대표이사</td>
				<td>　</td>
			</tr>
			<!--//에이엠테크놀로지//-->
		</c:when>
		
		<c:when test="${baseUserLoginInfo.applyOrgId eq '54' }">
			<!--휴버트바이오-->
			<tr>
				<th scope="row">㈜휴버트바이오</th>
				<td>건물</td>
				<td>네오메디클리닉</td>
				<td class="num_money_type">₩2,831,000,000</td>
				<td>&nbsp;-&nbsp;</td>
				<td>충청북도    충주시 성서도 228외 2필지 (8개 호실)</td>
				<td>관리부</td>
				<td>현재 매각 진행 중.</td>
			</tr>
			<!--//휴버트바이오//-->
		</c:when>
		
		<c:when test="${baseUserLoginInfo.applyOrgId eq '56' }">
			<!--엠아이텍-->
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>차량</td>
				<td>모닝</td>
				<td class="num_money_type">₩1,007,816</td>
				<td>2017.06.13</td>
				<td>성남 지점</td>
				<td>쇄석기사업본부</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>차량</td>
				<td>모닝</td>
				<td class="num_money_type">₩1,538,584</td>
				<td>2017.06.14</td>
				<td>성남    지점</td>
				<td>쇄석기사업본부</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>차량</td>
				<td>레이</td>
				<td class="num_money_type">₩4,289,443</td>
				<td>2017.06.15</td>
				<td>성남    지점</td>
				<td>쇄석기사업본부</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>차량</td>
				<td>모닝</td>
				<td class="num_money_type">₩1,318,959</td>
				<td>2017.06.16</td>
				<td>성남    지점</td>
				<td>쇄석기사업본부</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>토지</td>
				<td>본사(평택)</td>
				<td class="num_money_type">₩373,352,300</td>
				<td>2002.08.09</td>
				<td>하북리    241-3외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>토지</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩923,537,870</td>
				<td>2006.12.31</td>
				<td>봉남리    46-1외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>토지</td>
				<td>제천</td>
				<td class="num_money_type">₩42,083,340</td>
				<td>2008.01.07</td>
				<td>월악리    729-1</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>토지</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩42,391,000</td>
				<td>2010.07.27</td>
				<td>봉남리44-2외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>건물</td>
				<td>본사(평택)</td>
				<td class="num_money_type">₩1,799,554,376</td>
				<td>2003.08.01</td>
				<td>하북리    241-3외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>건물</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩734,373,260</td>
				<td>2011.01.31</td>
				<td>봉남리    46-1외</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>건물</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩294,629,000</td>
				<td>2015.11.27</td>
				<td>봉남리    46-1외<br>
					(증축)</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>건물</td>
				<td>연구소(평택)</td>
				<td class="num_money_type">₩187,751,200</td>
				<td>2016.05.09</td>
				<td>봉남리    46-외<br>
					(창고)</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>콘도 회원권</td>
				<td>㈜대명리조트</td>
				<td class="num_money_type">₩77,051,360</td>
				<td>2014.05.15</td>
				<td>&nbsp;-&nbsp;</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>콘도 회원권</td>
				<td>㈜리솜리조트</td>
				<td class="num_money_type">₩38,435,750</td>
				<td>2015.09.04</td>
				<td>&nbsp;-&nbsp;</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>골프 회원권</td>
				<td>기흥CC</td>
				<td class="num_money_type">₩221,919,690</td>
				<td>2014.09.05</td>
				<td>본사(평택)</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">㈜엠아이텍</th>
				<td>골프 회원권</td>
				<td>양주CC</td>
				<td class="num_money_type">₩72,500,190</td>
				<td>2015.05.08</td>
				<td>본사(평택)</td>
				<td>경영지원팀</td>
				<td>　</td>
			</tr>
			<!--//엠아이텍//-->
		</c:when>
		
		<c:when test="${baseUserLoginInfo.applyOrgId eq '62' }">
			<!--혜성씨앤씨-->
			<tr>
				<th scope="row">혜성씨앤씨㈜</th>
				<td>차량</td>
				<td>포터/소형화물</td>
				<td class="num_money_type">₩5,335,120</td>
				<td>2000.03.08</td>
				<td>전북 익산시</td>
				<td>물류팀</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">혜성씨앤씨㈜</th>
				<td>토지</td>
				<td>공장부지</td>
				<td class="num_money_type">₩590,314,875</td>
				<td>2001.6.01    외</td>
				<td>전북    익산시 삼기면 기산리 325-21,23,25</td>
				<td>공장&nbsp;</td>
				<td>　</td>
			</tr>
			<tr>
				<th scope="row">혜성씨앤씨㈜</th>
				<td>건물</td>
				<td>공장건물</td>
				<td class="num_money_type">₩2,262,800,177</td>
				<td>2001.06.01    외</td>
				<td>전북    익산시 삼기면 기산리 325-21,23,25</td>
				<td>공장&nbsp;</td>
				<td>2016년    결산건물가액</td>
			</tr>
			<!--//혜성씨앤씨//-->
		</c:when>
		
		<c:when test="${baseUserLoginInfo.applyOrgId eq '60' }">
			<!--재원씨앤씨-->
			<tr>
				<th scope="row">재원씨앤씨</th>
				<td>차량</td>
				<td>아우디</td>
				<td class="num_money_type">&nbsp;-&nbsp;</td>
				<td>&nbsp;-&nbsp;</td>
				<td>&nbsp;-&nbsp;</td>
				<td>대표이사</td>
				<td>리스차량</td>
			</tr>
			<!--//재원씨앤씨//-->
		</c:when>
		
		<c:otherwise>
			<tr>
				<td colspan="8">데이터가 없습니다.</th>
			</tr>	
		</c:otherwise>
	</c:choose>
	</tbody>
</table>

</section>
