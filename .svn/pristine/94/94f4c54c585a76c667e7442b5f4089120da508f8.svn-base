package ib.basic.interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface MenuNavigationService {

	//좌측 메뉴 리스트 반환.
	public  List<MenuVO> getMenuInfo(String userRoleId, String menuPath) throws Exception;
	
	//좌측 메뉴 정보 반환.
	public Map getMenusInfo(String userRoleId, String menuPath) throws Exception;

	//이동하는 페이지에 속한 탭/버튼 정보 반환
	public List<MenuVO> getSearchTabList(HttpServletRequest request, Map baseLoginUser) throws Exception;
	
	public MenuVO selectMenuInfoBasic(String userRoleId, String menuPath) throws Exception;

	public MenuVO selectMenuInfo(MenuVO tabMenuVO) throws Exception;

}
