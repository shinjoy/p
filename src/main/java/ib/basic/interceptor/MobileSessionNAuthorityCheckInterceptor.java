package ib.basic.interceptor;

import ib.cmm.IBsMessageSource;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.AccessDeniedException;
import org.springframework.web.HttpSessionRequiredException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class MobileSessionNAuthorityCheckInterceptor extends HandlerInterceptorAdapter{	
	
	protected static final Log logger = LogFactory.getLog(MobileSessionNAuthorityCheckInterceptor.class);
	
	@Resource
	public IBsMessageSource iBsMessageSource;
	
	private Set<String> authorityCheckURL;
	
	
	public void setAuthorityCheckURL(Set<String> authorityCheckURL) {
		this.authorityCheckURL = authorityCheckURL;
	}

	@Override
	public boolean preHandle(HttpServletRequest request,
							HttpServletResponse response, Object handler) throws Exception {

		logger.debug("######## MobileSessionNAuthorityCheckInterceptor.preHandle() ############");
		
		String requestURI = request.getRequestURI(); // 요청 URI
		String contextPath = request.getContextPath(); //contextpath
	
		HttpSession session = request.getSession();
		Map baseLoginUser = (Map) session.getAttribute("baseUserLoginInfo");
				
		
		//세션 체크 :S ---------------------------------------------------------------------------------
		if(baseLoginUser == null) {
			throw new HttpSessionRequiredMobileException(iBsMessageSource.getMessage("fail.session.out"));						
		}
		//세션 체크 :E ---------------------------------------------------------------------------------
		
		
		
		//메뉴 권한 체크 :S -----------------------------------------------------------------------------
		if(requestURI.indexOf(contextPath) > -1) {
			//contextpath가 붙은 경우 제거해준다.
			int len = StringUtils.length(contextPath) + 1;
			requestURI = requestURI.substring(len);
		}
		
		//체크해야하는 URL과 비교후 처리(메뉴 체크 대상 URL이 아닌경우 return true)
		boolean checkedYn = false;
		for(String includeUrl : authorityCheckURL){
			if(StringUtils.endsWithIgnoreCase(includeUrl, requestURI)){
				checkedYn =  true;
			}
		}
		
		if(!checkedYn){		//메뉴 체크 대상 URL이 아닌경우 return true
			return true;
		}
		
		//메뉴 체크 대상 URL인 경우 next step
		
		//저장된 사용자의 사용가능 메뉴 정보와 비교하기 위해 .do를 제거함.
		requestURI = requestURI.substring(0,requestURI.indexOf(".do"));		
				
		
		//메뉴 권한체크
		String menufilter = (String) session.getAttribute("m_menuFilterStr");		//허용메뉴 리스트 문자열		
		if(menufilter == null || menufilter.indexOf(requestURI) == -1 || "".equals(menufilter)){		//허용메뉴에 존재하지 않는 요청이 온 경우
			throw new AccessDeniedException(iBsMessageSource.getMessage("fail.access.menu"));
		}
		//메뉴 권한 체크 :E -----------------------------------------------------------------------------
		
		
		return true;
		
	}
}
