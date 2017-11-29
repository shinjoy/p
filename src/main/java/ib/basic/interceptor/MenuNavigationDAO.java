package ib.basic.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ib.board.service.impl.BoardDAO;
import ib.cmm.service.impl.ComAbstractDAO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

@Repository("menuNavigationDAO")
public class MenuNavigationDAO extends ComAbstractDAO {
	
	// 왼쪽 메뉴 정보 검색.
	public List<MenuVO> selectLeftMenuList(MenuVO menuVO) throws Exception {
		return list("menu.selectLeftMenuList", menuVO);
	}
	
	// 메뉴 정보 검색
	public Map selectLeftMenu(Map map) throws Exception {
		return (Map)selectByPk("menu.selectMenuPosInfo", map);
	}
	
	//탭/버튼/팝업인 경우 속한 화면 메뉴 아이디 정보 반환.
	public MenuVO selectMenuInfoBasic(MenuVO menuVO) throws Exception{
		return (MenuVO)super.getSqlMapClientTemplate().queryForObject("menu.selectMenuInfoBasic", menuVO);
	}

	//화면 URL에 속한 탭정보 리스트 반환.
	public List<MenuVO> getSearchTabList(MenuVO menuVO) {		
		return list("menu.selectTabMenuList", menuVO);
	}
	
	//화면 URL과 권한 정보로 메뉴 아이디 정보 반환
	public MenuVO selectMenuToTab(MenuVO menuVO){
		return (MenuVO) super.getSqlMapClientTemplate().queryForObject("menu.selectMenuToTab", menuVO);
	}
}
