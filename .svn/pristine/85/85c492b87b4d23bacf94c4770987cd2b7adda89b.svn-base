	
	/*
	 * 앱에서도, 웹에서도 팝업뷰가 close 되도록 하는 함수
	 */
	function procOnClose(){
		var currentOS;
		var mobile = (/iphone|ipad|ipod|android/i.test(navigator.userAgent.toLowerCase()));
	 
	if (mobile) {
		// 유저에이전트를 불러와서 OS를 구분합니다.
		var userAgent = navigator.userAgent.toLowerCase();
		if (userAgent.search("android") > -1)
			currentOS = "android";
		else if ((userAgent.search("iphone") > -1) || (userAgent.search("ipod") > -1)
					|| (userAgent.search("ipad") > -1))
			currentOS = "ios";
		else
			currentOS = "else";
	} else {
		// 모바일이 아닐 때
		currentOS = "nomobile";
	}
	
	if( currentOS == 'android' ){
	
		window.android.setMessage('close');	
	}
	else if( currentOS == 'ios' ){
		open(location, '_self').close();
		}
		else{
			window.close();
		}
	}