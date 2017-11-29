<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javaScript" language="javascript">
	$(document).ready(function () {
		$(window).load(function() {
			$('#PaddingTable').attr('style', 'padding-top:'+$('#TitleTable').height()+'px;');
			if($('#OrderKey').val() != '') ListOrderTitleSet();
			if('${vo.eventType}' == 'Pop' && '${vo.scheSDate}' == '') {
				$('#SearchSDate').focus();

				$('#SearchSDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
				$('#SearchEDate').datepicker(E_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
			}
		});
	});


	// 상세보기
    function ScheView(ScheSeq) {
        $('#eventPage').val("MoreView");
        $('#ScheSeq').val(ScheSeq);
        $('#frmScheduleMore').attr('action', "<c:url value='/ScheduleView.do'/>").submit();
    }

	// 선택일정 수정 페이지
    function ScheduleEdit(ScheSeq) {
    	$('#ScheSeq').val(ScheSeq);
        $('#EventType').val('Edit');

        $('#frmScheduleMore').attr('action', "<c:url value='/scheduleProc.do'/>");
        $('#frmScheduleMore').submit();
    }

	// 마우스오버 참가자 보기
	function OpenEntry(DivID, Entry) {
		if(Entry == "") return false;
		if(Entry.split(",").length > 8) var Con = "<span style=\"display:inline-block;height:25px;padding:5px;font-size:9pt;background-color:#E7E7E7;\">";
		else var Con = "<span style=\"display:inline-block;height:15px;padding:5px;font-size:9pt;background-color:#E7E7E7;\">";
		if(Entry.split(",").length > 8) {
			Con += replaceC(Entry.split(Entry.split(",")[8])[0], ",", ", ") + "<br/>";
			Con += Entry.split(",")[8].replace(",", ", ");
			Con += replaceC(Entry.split(Entry.split(",")[8])[1], ",", ", ");
		}
		else Con += replaceC(Entry, ",", ", ");
		Con += "</span>";

		elDiv = document.createElement("DIV");
		document.body.appendChild(elDiv);
		elDiv.id = DivID;
		elDiv.style.position = "absolute";

		var nMouseTop = window.event.clientY - 20;
		var nMouseLeft = window.event.clientX + 30;

		elDiv.style.top = nMouseTop + 'px';
		elDiv.style.left = nMouseLeft + 'px';
		elDiv.innerHTML = Con;
	}

	function CloseEntry() {
		document.body.removeChild(elDiv);
	}

	//상세보기 열기
	function openDetail(idx){
		if( $("#trDetail"+idx).css("display") != "none" ) {
			$("#trDetail"+idx).hide();
		} else {
			$("#trDetail"+idx).show()
		}
		//$("#trDetail"+idx).toggle();
	}

	// 일정 완료
    function ScheduleChkEnd(ScheSeq) {
    	$('#ScheSeq').val(ScheSeq);
        $('#frmScheduleMore').attr('action', "<c:url value='/ScheduleChkEnd.do'/>");
        commonAjaxSubmit("POST", $("#frmScheduleMore"), ScheduleChkEndCallback);
    }

    //일정 완료 콜백
    function ScheduleChkEndCallback(result){
        if(result.result == "SUCCESS"){
            alert("일정이 완료처리 되었습니다.");
            closeAction();
        }else if(result.result == "FAIL"){
            alert("일정이 완료처리에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        }else{
            alert(result.result);
        }
    }

 // 일정 삭제
    function ScheduleDelEnd(ScheSeq) {
    	$('#ScheSeq').val(ScheSeq);

        if($('#ScheGrpCd').val() == '' || $('#ScheGrpCd').val() == 'Period') {
            if(confirm('일정을 삭제하시겠습니까?')) {
                $('#frmScheduleMore').attr('action', "<c:url value='/ScheduleDelEnd.do'/>");
                commonAjaxSubmit("POST", $("#frmScheduleMore"), ScheduleDelEndCallback);
            }
        } else {
            $('#EventType').val('Del');
            window.open("", 'chkRepeat', 'width=300, height=200, scrollbars=no');
            $('#frmScheduleMore').attr('target','chkRepeat');
            $('#frmScheduleMore').attr('action', "<c:url value='/ScheduleProcFlag.do'/>").submit();
        }
    }

    //일정 삭제후 콜백
    function ScheduleDelEndCallback(result){
        if(result.result == "SUCCESS"){
            alert("정상적으로 삭제되었습니다.");
            closeAction();
        }else if(result.result == "FAIL"){
            alert("삭제에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        }else{
            alert(result.result);
        }
    }

    function closeAction(){
        opener.parent.openPageReload();
        window.close();
    }


</script>
