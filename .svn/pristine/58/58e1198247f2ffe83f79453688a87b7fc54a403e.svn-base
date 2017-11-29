<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main</title>
<script src="<c:url value='/js/html5.js'/>"></script>
<script src="<c:url value='/js/jquery.min.js'/>" type="text/JavaScript" ></script>
<script src="<c:url value='/js/highcharts/highcharts.js'/>" type="text/JavaScript" ></script>
<script src="<c:url value='/js/highcharts/exporting.js'/>" type="text/JavaScript" ></script>
<style>p{font-size:11px;}</style>
<script>

$(document).ready(function(){
	$(function () {
		var arr = new Array();
		var cnt = 0, cntData = 0,
			objDay = $('input[name^=day]'),
			objTitle = $('.title'),
			objData = $('.data'),
			leng = 0,
			dayLeng = objDay.length;
		while(dayLeng !== cnt){
			arr[cnt++] = objDay.val().substring(5,10);
			objDay = objDay.next();
		}
		cnt = 0,cntData=0,
		leng=objTitle.length;

		var arr2 = new Array()
		, arrData = new Array();
		while(leng!==cnt){
			objTitle = $('.title:eq('+cnt+')');
			objData = $('.data:eq('+cnt+')');
			arrData = objData.val().split(',');
			var i=0,len = arrData.length;
			//console.log(dayLeng+";;"+arrData[i]);
			while((dayLeng-1)!==i){
				if(arrData[i]==null) arrData[i]=0;
				else arrData[i]=parseInt(arrData[i]);
				i++;
			}
			arr2[cnt] = {
				name: objTitle.val(),
				data: arrData
			};
			// console.log(arr2[cnt].name+"||"+cnt+"||"+arr2[cnt].data);
			cnt+=1;
		}

        $('#container').highcharts({
            title: {
                text: 'Weekly Average Contact',
                x: -20 //center
            },
            subtitle: {
                text: 'Source: ib system',
                x: -20
            },
            xAxis: {
                categories: arr
            },
            yAxis: {
                title: {
                    text: '접속횟수'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: ' 회'
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: arr2
        });
    });
});
function chngTitle(th){
	var obj = $(th);
	var chId = $("#chId").val();
	$(".logLine").css('display','none');
	$("[class*="+obj.val()+"][class*="+chId+"]").css('display','');
}
function chngId(th){
	var obj = $(th);
	var chTitle = $("#chTitle").val();
	$(".logLine").css('display','none');
	$("[class*="+obj.val()+"][class*="+chTitle+"]").css('display','');
}
</script>
</head>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
<body>
	<section>
		<article>
		<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
			<div class="clear">
				<c:forEach var="t" items="${title}" varStatus="dcnt"><input type="hidden" name="title" class="title" value="${t.title}"/><input type="hidden" name="data" class="data" value="${t.count}"/></c:forEach>
				<c:forEach var="d" items="${day}" varStatus="tcnt"><input type="hidden" name="day" value="${d.day}"/></c:forEach>
			</div>
			<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
			<%--<br/><div><p>${title}</p></div>--%>
		</article>
	</section>
</body>
</html>