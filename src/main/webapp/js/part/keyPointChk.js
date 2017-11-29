function subMemo(th){
	if(confirm("적용하시겠습니까?\n메모가 전달됩니다.")){
		var obj = $(th).parent().parent();
		var cont = "[업무일지⇒"+$("#SendReceive").val()+"] - ";
		cont += obj.find('[id^=memoTmDt]').val()+"\n회사명: "+obj.find('[id^=memoCpnNm]').val() + "\n" + obj.find('[id^=memoarea]').val();
		
		var DATA = {
				sNb: obj.find('[id^=dealMemoSNb]').val()
				, memo: obj.find('[id^=memoarea]').val()
				, rgNm: obj.find('[id^=memoRgNm]').val()
				, sttsCd: '00001'
				, tmpNum1 : cont
				, rgId: $('#rgstId').val()};
		var url = "../work/modifyKeyPointChkMemo.do";
		var fn = function(){
			document.modifyRec.submit();
		};
		ajaxModule(DATA,url,fn);
	}
}
function remake(obj, col1, col2){
	$(function(){
		$('#'+obj).each(function() {
			var table = this;
			$.each([col1,col2] /* 합칠 칸 번호 */, function(c, v) {
				var tds = $('>tbody>tr>td:nth-child(' + v + ')', table).toArray(), i = 0, j = 0;
				for(j = 1; j < tds.length; j ++) {
					if(tds[i].innerHTML == '<a></a>' || tds[i].innerHTML != tds[j].innerHTML) {
						$(tds[i]).attr('rowspan', j - i);
						i = j;
						continue;
					}
					$(tds[j]).hide();
				}
				j --;
				if(tds[i].innerHTML == tds[j].innerHTML) {
					$(tds[i]).attr('rowspan', j - i + 1);
				}
			});
		});
	});
}