
/**
 * 하위 모든 dom 을 disable
 *
 * @param obj		: 대상dom객체
 *
 */
function setDisableChildren(obj){

	//input elements
	var elementChildren = $(obj).find('input');
	for (var i = 0; i < elementChildren.length; i++) {
	    //console.log(elementChildren[i].tagName);
	    $(elementChildren[i]).attr('disabled', true);
	}

	//select elements
	elementChildren = $(obj).find('select');
	for (var i = 0; i < elementChildren.length; i++) {
	    //console.log(elementChildren[i].tagName);
	    $(elementChildren[i]).attr('disabled', true);
	}
}


/**
 * 하위 모든 dom 을 enable
 *
 * @param obj		: 대상dom객체
 *
 */
function setEnableChildren(obj){

	//input elements
	var elementChildren = $(obj).find('input');
	for (var i = 0; i < elementChildren.length; i++) {
	    //console.log(elementChildren[i].tagName);
	    $(elementChildren[i]).attr('disabled', false);
	}

	//select elements
	elementChildren = $(obj).find('select');
	for (var i = 0; i < elementChildren.length; i++) {
	    //console.log(elementChildren[i].tagName);
	    $(elementChildren[i]).attr('disabled', false);
	}
}
