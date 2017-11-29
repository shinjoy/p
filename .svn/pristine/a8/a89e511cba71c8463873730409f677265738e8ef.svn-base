package ib.basic.interceptor;

import ib.basic.service.BookMarkService;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.HttpSessionRequiredException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class MenuNavigationInterceptor extends HandlerInterceptorAdapter{

	protected static final Log logger = LogFactory.getLog(MenuNavigationInterceptor.class);

	@Resource
	public MenuNavigationService menuNavigationService;

	@Resource(name = "bookMarkService")
	private BookMarkService bookMarkService;

	
	private Set<String> bookMarkInfoURL = new HashSet<String>();
	private Set<String> extraMenuInfoURL = new HashSet<String>();
	
	public void setBookMarkInfoURL(Set<String> bookMarkInfoURL) {
		this.bookMarkInfoURL = bookMarkInfoURL;
	}
	
	public void setExtraMenuInfoURL(Set<String> extraMenuInfoURL) {
		this.extraMenuInfoURL = extraMenuInfoURL;
	}
	

	@Override
	public boolean preHandle(HttpServletRequest request,
							HttpServletResponse response, Object handler) throws Exception {

		logger.debug("######## MenuNavigationInterceptor.preHandle() ############");
		
		HttpSession session = request.getSession();
		Map baseLoginUser = (Map) session.getAttribute("baseUserLoginInfo");
		if (baseLoginUser == null) {
			throw new HttpSessionRequiredException("session is null!");
		}
						
		//즐겨찾기 정보만을 필요로하는 예외 URL 여부
		boolean isJustBookMark = false;		//기본세팅(false : 아니다)
		
		//메뉴 정보를 필요로하는 모바일 예외 URL 여부
		boolean isMobileExtra = false;		//기본세팅(false : 아니다)
		
		
		//-------------------- 사용자의 사용가능 메뉴 URL인지 CHECK :S ----------------------
		
		String requestURI = request.getRequestURI(); 	//요청 URI
		String contextPath = request.getContextPath(); 	//contextpath
		
		if(requestURI.indexOf(contextPath) > -1) {
			//contextpath가 붙은 경우 제거해준다.
			int len = StringUtils.length(contextPath) + 1;
			requestURI = requestURI.substring(len);
		}
		//사용자의 사용가능 메뉴 정보와 비교하기 위해 .do를 제거함.
		String checkURI = requestURI.substring(0, requestURI.indexOf(".do"));
		
		
		//사용가능 메뉴 정보
		String menufilter = (String)session.getAttribute("menuFilterStr");								//사용가능 메뉴 리스트 (문자열)		
		if(menufilter != null && (menufilter.indexOf(checkURI) == -1 || "".equals(menufilter))){		//사용가능 메뉴 정보가 아닐때는			
			for(String includeUrl : bookMarkInfoURL){													//즐겨찾기 정보만을 필요로 하는 예외 URL에 해당하는지 봐서
				if(includeUrl.equals(requestURI)) isJustBookMark = true;								//해당하면 ... 하단 즐겨찾기만 가져오고
			}
			
			if(!isJustBookMark) return true;												//SKIP  ... 그것도 아니면, 하단 SKIP하고(메뉴정보없이) 컨트롤러로 진행
		}
		
		//사용가능 메뉴 정보 ------ 모바일
		String m_menufilter = (String)session.getAttribute("m_menuFilterStr");							//사용가능 메뉴 리스트 (문자열) - 모바일 메뉴		
		if(m_menufilter != null && (m_menufilter.indexOf(checkURI) == -1 || "".equals(m_menufilter))){	//사용가능 메뉴 정보가 아닐때는			
			for(String includeUrl : extraMenuInfoURL){													//메뉴 정보를 필요로 하는 예외 URL에 해당하는지 봐서
				if(includeUrl.equals(requestURI)) isMobileExtra = true;									//해당하면 ... 하단 정보 가져오고
			}
			
			if(!isMobileExtra) return true;													//SKIP  ... 그것도 아니면, 하단 SKIP하고(메뉴정보없이) 컨트롤러로 진행
		}
		//-------------------- 사용자의 사용가능 메뉴 URL인지 CHECK :E ----------------------

		
		
		
		//-------------------- 즐겨찾기 메뉴 리스트 :S ---------------------
		Map param = new HashMap();
		param.put("userId", baseLoginUser.get("userId"));
		param.put("roleId", baseLoginUser.get("userRoleId"));
		param.put("orgId", 	baseLoginUser.get("applyOrgId"));
		
		List<Map> bookmarkList = bookMarkService.getBookMarkList(param);			//즐겨찾기 리스트
		
		request.setAttribute("bookMarkList", bookmarkList);							//즐겨찾기 리스트 ... ■■■■ 화면전달 ■■■■
		//-------------------- 즐겨찾기 메뉴 리스트 :E ---------------------
		
		if(isJustBookMark) return true;		//즐겨찾기 정보만을 필요로 하는 예외 URL일때, 하단 SKIP하고(메뉴정보없이) 컨트롤러로 진행
		
		
				
		/*
		 요청 경로 추출 
		String requestURI = request.getRequestURI(); 							//요청 URI
		String contextPath = request.getContextPath(); 							//contextpath		
		//contextpath가 붙은 경우 제거해준다.
		if (requestURI.indexOf(contextPath) > -1) {			
			int len = StringUtils.length(contextPath) + 1;
			requestURI = requestURI.substring(len);
		}*/
		
		String userRoleId = String.valueOf(baseLoginUser.get("userRoleId"));	//사용자 권한id
		
		
		MenuVO basicMenuVO = menuNavigationService.selectMenuInfoBasic(userRoleId, requestURI);		//기본 메뉴 정보 조회
		
		String menuType = null;			//메뉴 타입 (TREE, TAB, ALONE)
		
		
		//-------------------- 탭 메뉴일 경우 :S -----------------------
		/* 탭메뉴인지 체크(탭 메뉴명), 탭이 속한 메뉴 경로 정보(requestURI) */
		String tabMenuKor = null;													//메뉴명 (탭 메뉴일 경우)
		String pupupMenuKor = null;													//메뉴명 (팝업 메뉴일 경우)
		if(basicMenuVO != null){
			
			menuType = basicMenuVO.getMenuType();		//메뉴 타입 (TREE, TAB, ALONE)
			
			if("TAB".equals(menuType)){								//탭 메뉴
				tabMenuKor = basicMenuVO.getMenuKor();									//탭 메뉴명
				
				//탭이 속한 메뉴 아이디(basicMenuVO.getDirectMenuParentId())를 통해 정보 조회.			
				basicMenuVO.setRoleId(Integer.parseInt(userRoleId));
				MenuVO menuInfo = menuNavigationService.selectMenuInfo(basicMenuVO);	//탭이 속한 메뉴정보 조회						
				requestURI = menuInfo.getMenuPath();									//탭이 속한 메뉴(탭부모) 경로
				
			}else if("ALONE".equals(menuType)){						//팝업 메뉴
				pupupMenuKor = basicMenuVO.getMenuKor();								//팝업 메뉴명
				
				if(basicMenuVO.getDirectMenuParentId() > 0){							//속한 메뉴가 있는 팝업인경우
					//팝업이 속한 메뉴 아이디(basicMenuVO.getDirectMenuParentId())를 통해 정보 조회.			
					basicMenuVO.setRoleId(Integer.parseInt(userRoleId));
					MenuVO menuInfo = menuNavigationService.selectMenuInfo(basicMenuVO);	//탭이 속한 메뉴정보 조회						
					requestURI = menuInfo.getMenuPath();									//탭이 속한 메뉴(탭부모) 경로
				}
				
			}
			
		}
		//-------------------- 탭 메뉴일경우 :E -----------------------
		
		
		

		//현재화면 메뉴정보 검색 (탭이라면 탭의 부모(부모 requestURI)로 조회)
		Map resultMap = menuNavigationService.getMenusInfo(userRoleId, requestURI);

		//현재화면 메뉴정보 (현 메뉴id (me), 상위 메뉴id (mu), 루트 메뉴id (mr)) ... 단 탭이 현재면 탭이 속한 메뉴
		request.setAttribute("menuParam", resultMap);								//현재화면 메뉴정보  ... ■■■■ 화면전달 ■■■■
		
		
		if(resultMap != null){		//정상
			
			
			String menuKorPath = "<span class='divide'>";		//메뉴 경로정보 표기를 위한 html string
			menuKorPath += (String)resultMap.get("tmk"); 														//최상위 메뉴
			menuKorPath += ((String)resultMap.get("smk") != null)? " > "+(String)resultMap.get("smk") : ""; 	//상위 메뉴
			
			
			if("TAB".equals(menuType)){						//탭 메뉴 일때
				
				//---------- 메뉴 경로정보 표기를 위한 html string :S -----------
				menuKorPath += ((String)resultMap.get("mk") != null)? " > "+(String)resultMap.get("mk") : ""; 	//탭이 속한 메뉴
				menuKorPath += "</span>";
				menuKorPath += "<span class='divide current'>" + tabMenuKor + "</span>";						//탭 메뉴(현재 화면)
				
				request.setAttribute("menuKorPath", menuKorPath);								//메뉴 경로 정보(최종 넘기기) ... ■■■■ 화면전달 ■■■■
				//---------- 메뉴 경로정보 표기를 위한 html string :E -----------
				
								
				//---------- 타이틀명(html title) :S ------------
				StringBuffer tabMenuTitle = new StringBuffer();
				tabMenuTitle.append(tabMenuKor)
							.append(((String)resultMap.get("mk") != null)? " | "+(String)resultMap.get("mk") : "")
							.append(((String)resultMap.get("smk") != null)? " | "+(String)resultMap.get("smk") : "")
							.append(" | " + (String)resultMap.get("tmk"));
				
				request.setAttribute("currentMenuKorTitle", tabMenuTitle.toString() + " ");					//현재 메뉴명(타이틀) ... ■■■■ 화면전달 ■■■■
				//---------- 타이틀명(html title) :E ------------
				
				
				request.setAttribute("currentMenuKor", tabMenuKor);												//현재 메뉴명 ... ■■■■ 화면전달 ■■■■
				
				
			}else if("ALONE".equals(menuType)){				//팝업 메뉴 일때
				
				if(basicMenuVO.getDirectMenuParentId() > 0){		//속한 메뉴가 있는 팝업인경우
				
					//---------- 메뉴 경로정보 표기를 위한 html string :S -----------
					menuKorPath += ((String)resultMap.get("mk") != null)? " > "+(String)resultMap.get("mk") : ""; 	//탭이 속한 메뉴
					menuKorPath += "</span>";
					menuKorPath += "<span class='divide current'>" + tabMenuKor + "</span>";						//탭 메뉴(현재 화면)
					
					request.setAttribute("menuKorPath", menuKorPath);								//메뉴 경로 정보(최종 넘기기) ... ■■■■ 화면전달 ■■■■
					//---------- 메뉴 경로정보 표기를 위한 html string :E -----------
					
									
					//---------- 타이틀명(html title) :S ------------
					StringBuffer pupupMenuTitle = new StringBuffer();
					pupupMenuTitle.append(pupupMenuKor)
									.append(((String)resultMap.get("mk") != null)? " | "+(String)resultMap.get("mk") : "")
									.append(((String)resultMap.get("smk") != null)? " | "+(String)resultMap.get("smk") : "")
									.append(" | " + (String)resultMap.get("tmk"));
					
					request.setAttribute("currentMenuKorTitle", pupupMenuTitle.toString() + " ");					//현재 메뉴명(타이틀) ... ■■■■ 화면전달 ■■■■
					//---------- 타이틀명(html title) :E ------------
					
					
				}else{												//속한 메뉴가 없는 팝업
					
					//---------- 즐겨찾기 추가 버튼 :S -------------------	... 탭이 아닌 메뉴일때 추가버튼 존재
					//추가된 메뉴인지 여부
					Map bookMarkParam = new HashMap<String,String>();
					bookMarkParam.put("menuId", resultMap.get("me"));
					bookMarkParam.put("userId", baseLoginUser.get("userId"));
					bookMarkParam.put("orgId",  baseLoginUser.get("applyOrgId"));
					
					Map bookMark = bookMarkService.getBookmarkInfo(bookMarkParam);
					
					boolean added = false;
					if(bookMark != null){
						for(int i=0; i<bookmarkList.size(); i++){
							if(bookmarkList.get(i).get("bookmarkId").toString().equals(bookMark.get("bookmarkID").toString())){		//등록되어 있는 메뉴이면
								added = true;		//등록 true ... 이미 추가된 메뉴
							}
						}
					}				
					//즐겨찾기 추가 버튼(html)
					String html= "<a href='#' id='imgAtag' class='icon_quicklink "+(added ? " add" : "")+"' onclick='checkBookmark("+resultMap.get("me")+ ");'></a>";
					request.setAttribute("menuBookmark", html);									//즐겨찾기 추가 버튼 tag string ... ■■■■ 화면전달 ■■■■
					//---------- 즐겨찾기 추가 버튼 :E -------------------
					
					
					request.setAttribute("menuKorPath", pupupMenuKor);								//메뉴 경로 정보(최종 넘기기) ... ■■■■ 화면전달 ■■■■
					request.setAttribute("currentMenuKorTitle", pupupMenuKor + " ");								//현재 메뉴명(타이틀) ... ■■■■ 화면전달 ■■■■
				}
				
				request.setAttribute("currentMenuKor", pupupMenuKor);											//현재 메뉴명 ... ■■■■ 화면전달 ■■■■
				request.setAttribute("currentMenuId", resultMap.get("me"));										//현재 메뉴 id ... ■■■■ 화면전달 ■■■■
				
				
			}else{													//일반 메뉴 일때(탭메뉴 아닌)
				
				//---------- 메뉴 경로정보 표기를 위한 html string :S -----------
				menuKorPath += "</span>";
				menuKorPath += ((String)resultMap.get("mk") != null)? "<span class='divide current'>"+(String)resultMap.get("mk")+"</span>" : "";	//현재 메뉴
				
				request.setAttribute("menuKorPath", menuKorPath);								//메뉴 경로 정보(최종 넘기기) ... ■■■■ 화면전달 ■■■■
				//---------- 메뉴 경로정보 표기를 위한 html string :E -----------
				
				
				//---------- 즐겨찾기 추가 버튼 :S -------------------	... 탭이 아닌 메뉴일때 추가버튼 존재
				//추가된 메뉴인지 여부
				Map bookMarkParam = new HashMap<String,String>();
				bookMarkParam.put("menuId", resultMap.get("me"));
				bookMarkParam.put("userId", baseLoginUser.get("userId"));
				bookMarkParam.put("orgId",  baseLoginUser.get("applyOrgId"));
				
				Map bookMark = bookMarkService.getBookmarkInfo(bookMarkParam);
				
				boolean added = false;
				if(bookMark != null){
					for(int i=0; i<bookmarkList.size(); i++){
						if(bookmarkList.get(i).get("bookmarkId").toString().equals(bookMark.get("bookmarkID").toString())){		//등록되어 있는 메뉴이면
							added = true;		//등록 true ... 이미 추가된 메뉴
						}
					}
				}				
				//즐겨찾기 추가 버튼(html)
				String html= "<a href='#' id='imgAtag' class='icon_quicklink "+(added ? " add" : "")+"' onclick='checkBookmark("+resultMap.get("me")+ ");'></a>";
				request.setAttribute("menuBookmark", html);									//즐겨찾기 추가 버튼 tag string ... ■■■■ 화면전달 ■■■■
				//---------- 즐겨찾기 추가 버튼 :E -------------------
				
				
				//---------- 타이틀명(html title) :S ----------------
				StringBuffer tabMenuTitle = new StringBuffer();
				tabMenuTitle.append((String)resultMap.get("mk"))							
							.append(((String)resultMap.get("smk") != null)? " | "+(String)resultMap.get("smk") : "")
							.append(" | " + (String)resultMap.get("tmk"));
				
				request.setAttribute("currentMenuKorTitle", tabMenuTitle.toString() + " ");					//현재 메뉴명(타이틀) ... ■■■■ 화면전달 ■■■■
				//---------- 타이틀명(html title) :E ----------------				
				
				
				request.setAttribute("currentMenuKor", (String)resultMap.get("mk"));							//현재 메뉴명 ... ■■■■ 화면전달 ■■■■			
				request.setAttribute("currentMenuEng", (String)resultMap.get("mte"));							//현재 메뉴명 ... ■■■■ 화면전달 ■■■■								
				request.setAttribute("currentMenuId", resultMap.get("me"));										//현재 메뉴 id ... ■■■■ 화면전달 ■■■■
			}
			
		}

		

		session.setAttribute("menuPath", requestURI);

		return true;
	}
}
