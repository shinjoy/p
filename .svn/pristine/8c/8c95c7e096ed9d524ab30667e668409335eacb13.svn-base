$(function() {
	if (navigator.userAgent.indexOf('Firefox') >= 0) {
		(function() {
			var events = [ "mousedown", "mouseover", "mouseout", "mousemove",
					"mousedrag", "click", "dblclick" ];
			for (var i = 0; i < events.length; i++) {
				window.addEventListener(events[i], function(e) {
					window.event = e;
				}, true);
			}
		}());
	}
	$(document).on("click", ".closePopUpMenu", function() {
		$(this).parent().hide();
	});
});
function getPosition(e) {
	e = e || window.event;
	var ddE = document.documentElement;
	var db = document.body;
	var cursor = {
		x : 0,
		y : 0
	};
	if (e.pageX || e.pageY) {
		cursor.x = e.pageX;
		cursor.y = e.pageY;
	} else if (e.clientX || e.clientY) {
		cursor.x = e.clientX + (ddE.scrollLeft || db.scrollLeft)
				- ddE.clientLeft;
		cursor.y = e.clientY + (ddE.scrollTop || db.scrollTop) - ddE.clientTop;
	}
	return cursor;
}
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/gi, "");
};

function view(divId, th, e) {
	var browserWidth = document.documentElement.clientWidth;
	var calWidth = $("#" + divId).outerWidth();
	var pstn = getPosition(e);
	var top = pstn.y;
	var left = pstn.x;
	$("#" + divId).css(	{"top" : top + "px",
						"left" : (left + calWidth < browserWidth ? left : browserWidth	- (calWidth + 8)) + "px"});
	$("#" + divId).css('display', 'block');
	$(".popUpMenu").hide();
	$("#" + divId).show();
}