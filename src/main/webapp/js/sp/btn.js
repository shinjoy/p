//var BtnBase = "";
////BtnBase += "-moz-box-shadow:inset 0px 1px 0px 0px #d9fbbe;";
////BtnBase += "-webkit-box-shadow:inset 0px 1px 0px 0px #d9fbbe;";
////BtnBase += "box-shadow:inset 0px 1px 0px 0px #d9fbbe;";
//BtnBase += "background-color:BaseBack;";
//BtnBase += "-moz-border-radius:6px;";
//BtnBase += "-webkit-border-radius:6px;";
//BtnBase += "border-radius:5px;";
////BtnBase += "border:1px solid #551A8B;";
//BtnBase += "display:inline-block;";
//BtnBase += "cursor:pointer;";
//BtnBase += "color:#ffffff;";
//BtnBase += "font-family:맑은고딕;";
//BtnBase += "font-size:8pt;";
////BtnBase += "font-weight:bold;";
//BtnBase += "padding:4px 8px;";
//BtnBase += "vertical-align:middle;";
//BtnBase += "text-decoration:none;";
////BtnBase += "text-shadow:0px 1px 0px #000000;";
//
//var BtnOver = "background-color:OverBack;";
//
//
//
//var BtnColor = new Object();
//
//BtnColor["LightOrange"] = {"BaseBack" : "#FB9E25", "OverBack" : "#FFC477"};
//BtnColor["LightGreen"] = {"BaseBack" : "#A5CC52", "OverBack" : "#B8E356"};
//BtnColor["LightBlue"] = {"BaseBack" : "#378DE5", "OverBack" : "#79BBFF"};
//BtnColor["Violet"] = {"BaseBack" : "#8346B5", "OverBack" : "#9560C1"};
//
//
//function BtnSet() {
//	$.each($('.Btn'), function() {
//		BtnBaseTmp = replaceC(BtnBase, 'BaseBack', BtnColor[$(this).attr('name')].BaseBack);
//
//		$(this).attr('style', BtnBaseTmp).mouseover(function() {
//			BtnOverSet(this, 'in');
//		}).mouseout(function() {
//			BtnOverSet(this, 'out');
//		});
//	});
//}
//
//function BtnOverSet(obj, flag) {
//	BtnBaseTmp = replaceC(BtnBase, 'BaseBack', BtnColor[$(obj).attr('name')].BaseBack);
//	BtnOverTmp = replaceC(BtnOver, 'OverBack', BtnColor[$(obj).attr('name')].OverBack);
//
//	if(flag == 'in') $(obj).attr('style', BtnBaseTmp + BtnOverTmp);
//	else $(obj).attr('style', BtnBaseTmp);
//}













var BtnBase = '';
//BtnBase += "-moz-box-shadow:inset 0px 1px 0px 0px #fce2c1;";
//BtnBase += "-webkit-box-shadow:inset 0px 1px 0px 0px #fce2c1;";
//BtnBase += "box-shadow:inset 0px 1px 0px 0px #fce2c1;";
BtnBase += "background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, BaseSColor), color-stop(1, BaseEColor));";
BtnBase += "background:-moz-linear-gradient(top, BaseSColor 5%, BaseEColor 100%);";
BtnBase += "background:-webkit-linear-gradient(top, BaseSColor 5%, BaseEColor 100%);";
BtnBase += "background:-o-linear-gradient(top, BaseSColor 5%, BaseEColor 100%);";
BtnBase += "background:-ms-linear-gradient(top, BaseSColor 5%, BaseEColor 100%);";
BtnBase += "background:linear-gradient(to bottom, BaseSColor 5%, BaseEColor 100%);";
BtnBase += "filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='BaseSColor', endColorstr='BaseEColor',GradientType=0);";
BtnBase += "background-color:BaseSColor;";
BtnBase += "-moz-border-radius:6px;";
BtnBase += "-webkit-border-radius:6px;";
BtnBase += "border-radius:6px;";
//BtnBase += "border:1px solid #eeb44f;";
BtnBase += "display:inline-block;";
BtnBase += "cursor:pointer;";
BtnBase += "color:#FFFFFF;";
BtnBase += "font-family:맑은 고딕;";
BtnBase += "font-size:8pt;";
BtnBase += "font-weight:bold;";
BtnBase += "padding:4px 8px;";
BtnBase += "text-decoration:none;";
//BtnBase += "text-shadow:0px 1px 0px #cc9f52;";

var BtnOver = "";
BtnOver += "background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, OverSColor), color-stop(1, OverEColor));";
BtnOver += "background:-moz-linear-gradient(top, OverSColor 5%, OverEColor 100%);";
BtnOver += "background:-webkit-linear-gradient(top, OverSColor 5%, OverEColor 100%);";
BtnOver += "background:-o-linear-gradient(top, OverSColor 5%, OverEColor 100%);";
BtnOver += "background:-ms-linear-gradient(top, OverSColor 5%, OverEColor 100%);";
BtnOver += "background:linear-gradient(to bottom, OverSColor 5%, OverEColor 100%);";
BtnOver += "filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='OverSColor', endColorstr='OverEColor',GradientType=0);";
BtnOver += "background-color:OverSColor;";

var BtnColor = new Object();
BtnColor["LightGreen"] = {"EColor" : "#A5CC52", "SColor" : "#B8E356"};
BtnColor["LightBlue"] = {"EColor" : "#378DE5", "SColor" : "#79BBFF"};
BtnColor["Violet"] = {"EColor" : "#8346B5", "SColor" : "#B793D5"};
BtnColor["Orange"] = {"EColor" : "#FF8000", "SColor" : "#FFC477"};
BtnColor["Gray"] = {"EColor" : "#8E8E8E", "SColor" : "#D1D1D1"};
BtnColor["Gold"] = {"EColor" : "#FFD700", "SColor" : "#FFED84"};
BtnColor["Silver"] = {"EColor" : "#C0C0C0", "SColor" : "#DFDFDF"};
BtnColor["Green"] = {"EColor" : "#008000", "SColor" : "#00E100"};
BtnColor["Blue"] = {"EColor" : "#0000FF", "SColor" : "#AAAAFF"};
BtnColor["DarkGold"] = {"EColor" : "#B8860B", "SColor" : "#F8D37E"};

function BtnSet() {
	$.each($('.Btn'), function() {
		BtnBaseTmp = replaceC(replaceC(BtnBase, 'BaseSColor', BtnColor[$(this).attr('name')].SColor), 'BaseEColor', BtnColor[$(this).attr('name')].EColor);

		$(this).attr('style', BtnBaseTmp).mouseover(function() {
			BtnOverSet(this, 'in');
		}).mouseout(function() {
			BtnOverSet(this, 'out');
		});
	});
}

function BtnOverSet(obj, flag) {
	BtnBaseTmp = replaceC(replaceC(BtnBase, 'BaseSColor', BtnColor[$(obj).attr('name')].SColor), 'BaseEColor', BtnColor[$(obj).attr('name')].EColor);
	BtnOverTmp = replaceC(replaceC(BtnOver, 'OverSColor', BtnColor[$(obj).attr('name')].EColor), 'OverEColor', BtnColor[$(obj).attr('name')].SColor);

//	if(flag == 'in') $(obj).attr('style', BtnBaseTmp + BtnOverTmp);
//	else $(obj).attr('style', BtnBaseTmp);
	
	if(flag == 'in') $(obj).attr('style', replaceC(BtnBaseTmp, '#FFFFFF', '#FF0000') + BtnOverTmp);
	else $(obj).attr('style', replaceC(BtnBaseTmp, '#FF0000', '#FFFFFF'));
}