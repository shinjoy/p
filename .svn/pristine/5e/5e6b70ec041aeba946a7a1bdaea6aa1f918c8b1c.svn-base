function Request(valuename) {
    var rtnval;
    var nowAddress = unescape(location.href);
    var parameters = new Array();
    parameters = (nowAddress.slice(nowAddress.indexOf("?")+1,nowAddress.length)).split("&");
    for(var i = 0 ; i < parameters.length ; i++){
        if(parameters[i].indexOf(valuename) != -1){
            rtnval = parameters[i].split("=")[1];
            if(rtnval == undefined || rtnval == null){
                rtnval = "";
            }
            return rtnval;
        }
    }
}
function changePage(num,flag,nm,snb){
	var sUrl = '';
	var Param = '';

	if(flag=='rcmdComment'){
		sUrl = "../recommend/comment.do";
		var tmDate = num.split('-');
		Param="?snb="+snb+"&year="+tmDate[0]+"&mon="+tmDate[1]+"&day="+tmDate[2];
	}

///**//
	parent.mainFrame.location.href = sUrl+Param;
	//var rVal = window.open(sUrl, val, option);
///**//
}
