package ib.basic.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("menuNavigationService")
public class MenuNavigationServiceImpl extends AbstractServiceImpl implements MenuNavigationService {
	
	protected static final Log logger = LogFactory.getLog(MenuNavigationServiceImpl.class);
	
	@Resource(name="menuNavigationDAO")
	private MenuNavigationDAO menuNavigationDAO;

	/**
	 * 좌측 메뉴 리스트 반환
	 * (호출된 requestURL을 토대로 메뉴 리스트 반환)
	 * 
	 * @param userRoleId : 사용자 role Id
	 * @param menuPath : 메뉴 URL
	 */
	public List<MenuVO> getMenuInfo(String userRoleId, String menuPath) throws Exception {
		// TODO Auto-generated method stub
		
		logger.debug("##### MenuNavigationService.getMenuInfo() [ param = roleId :  "+ userRoleId +", path : "+ menuPath +"] #####");
		
		if(StringUtils.isEmpty(menuPath)){
			throw new Exception("'manuPath' can't not be null!");
		}
		
		MenuVO menuVO = new MenuVO();
		menuVO.setRoleId(Integer.parseInt(userRoleId));
		menuVO.setMenuPath(menuPath);
		
		//앞에 prefix만 반환.(unique한 값이므로)
		if(StringUtils.indexOf(menuPath, "/") > -1){
			String topMenu = menuPath.substring(0, StringUtils.indexOf(menuPath, "/"));
			logger.debug("############"+ topMenu);
			menuVO.setMenuPath(topMenu);
		}
				
		//left에서 보여질 메뉴 정보 반환.
		List<MenuVO> menuList = menuNavigationDAO.selectLeftMenuList(menuVO);
		logger.debug("########################");
		logger.debug(menuList.toString());
		logger.debug("########################");
		return menuList;
	}

	public Map getMenusInfo(String userRoleId, String menuPath) throws Exception {		
		
		Map map = new HashMap<String,Object>();
		map.put("userRoleId", userRoleId);
		map.put("menuPath",menuPath);
		
		return menuNavigationDAO.selectLeftMenu(map);
	}
	
	//해당 URL을 통해 메뉴 정보 반환(메뉴 종류, 상위메뉴아이디정보)
	public MenuVO selectMenuInfoBasic(String userRoleId, String menuPath) throws Exception {		
		
		MenuVO menuVO = new MenuVO();
		menuVO.setRoleId(Integer.parseInt(userRoleId));
		menuVO.setMenuPath(menuPath);
		
		return menuNavigationDAO.selectMenuInfoBasic(menuVO);
	}
		

	//탭 정보에 있는 상위 메뉴 정보를 통하여 속한 화면 정보 반환 
	public MenuVO selectMenuInfo(MenuVO tabMenuVO) throws Exception {
		
		MenuVO vo = new MenuVO();
		vo.setRoleId(tabMenuVO.getRoleId());
		
		//탭,버튼,팝업의 직속 상위 메뉴 정보
		vo.setMenuId(tabMenuVO.getDirectMenuParentId());
		
		return menuNavigationDAO.selectMenuInfoBasic(vo);
	}
	

	//현재 메뉴를 중심으로 속한 탭 정보 반환
	public List<MenuVO> getSearchTabList(HttpServletRequest request, Map baseLoginUser) throws Exception {
				
		List<MenuVO> subList = null;
		String requestUrl = request.getRequestURI().trim();
		String contextPath = request.getContextPath(); //contextpath

		if (requestUrl.indexOf(contextPath) > -1) {
			// contextpath가 붙은 경우 제거해준다.
			int len = StringUtils.length(contextPath) + 1;
			requestUrl = requestUrl.substring(len);
		}
		
		
		int userRoleId = Integer.parseInt(String.valueOf(baseLoginUser.get("userRoleId")));
		int currentMenuId = 0;
		MenuVO menuVo = new MenuVO();
		menuVo.setRoleId(userRoleId);
		menuVo.setMenuPath(requestUrl);
		//현재 화면 정보의 메뉴 아이디 검색
		MenuVO resultVo = menuNavigationDAO.selectMenuToTab(menuVo);
		
		if(resultVo != null){		
			//현재 화면에 대한 메뉴 아이디
			currentMenuId = resultVo.getMenuId();
			
			//메뉴 아이디를 부모로 갖는 탭 메뉴들 반환
			MenuVO paramVO = new MenuVO();
			paramVO.setRoleId(userRoleId);
			paramVO.setMenuId(currentMenuId);
			subList = menuNavigationDAO.getSearchTabList(paramVO);
		}
		return subList;
	}

}
