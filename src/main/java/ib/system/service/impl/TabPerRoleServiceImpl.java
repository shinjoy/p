package ib.system.service.impl;


import ib.basic.interceptor.MenuVO;
import ib.system.service.RoleRegService;
import ib.system.service.TabPerRoleService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("tabPerRoleService")
public class TabPerRoleServiceImpl extends AbstractServiceImpl implements TabPerRoleService {

    @Resource(name="tabPerRoleDAO")
    private TabPerRoleDAO tabPerRoleDAO;
    
    @Resource(name = "roleRegService")
    private RoleRegService roleRegService;
    
    protected static final Log logger = LogFactory.getLog(TabPerRoleServiceImpl.class);

    
    
    //권한별 메뉴(로그인시)
  	public List<Map> getTabPerRole(Map<String, String> mParam) throws Exception {
  		
  		return tabPerRoleDAO.getTabPerRole(mParam);
  	}
  	
    
    //메뉴별 탭
  	public List<Map> getTabPerMenu(Map<String, String> mParam) throws Exception {
  		
  		return tabPerRoleDAO.getTabPerMenu(mParam);
  	}


	//권한별 메뉴 등록
	public int doSaveTabPerRole(Map<String, Object> map) throws Exception {
		
//		Map param = new HashMap<String,String>();
//		param.put("code", "CD");
//		param.put("name", "NM");		
//		List<Map> list = roleRegService.getRoleCodeCombo(param);
//		
//		int cnt = 0;
//		for(Map roleMap : list){
//			map.put("roleId", roleMap.get("roleId"));
//			tabPerRoleDAO.doSaveTabPerRole(map);
//			cnt++;
//		}
		
		int cnt = 0;
		
		map.put("roleId", "-1");
		cnt = tabPerRoleDAO.doSaveTabPerRole(map);
		
		return cnt;
	}

	//권한별 메뉴 복사
	public int doCopyTabPerRole(Map<String, Object> map) throws Exception {
		return tabPerRoleDAO.doCopyTabPerRole(map);
	}
	
	public List<MenuVO> selectMenuForTabRegister(Map<String, Object> map)
			throws Exception {
		// TODO Auto-generated method stub
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuType("TREE");
		menuVO.setRoleId((Integer)map.get("roleId"));
		
		//상위 Id가 있는 경우
		String menuParentId = (String)map.get("menuParentId");
		if(StringUtils.isNotEmpty(menuParentId)){
			menuVO.setMenuParentId(Integer.parseInt(menuParentId));
		}
		
		//메뉴 레벨이 없는 경우 최상단 메뉴로 
		String menuLevel = (String) map.get("menuLevel");
		if(StringUtils.isEmpty(menuLevel)){
			menuLevel = "0";
		}
		menuVO.setMenuLevel(Integer.parseInt(menuLevel));
		return tabPerRoleDAO.selectMenuForTabRegister(menuVO);
		
	}

	public int selectRoleInfo(Map map) throws Exception{
		String roleText = (String) map.get("roleText");
		int userRoleId = tabPerRoleDAO.selectRoleInfo(roleText);
		return userRoleId;
	}

	public List<MenuVO> getMenuInfoInfo(Map map) throws Exception{
		// TODO Auto-generated method stub
		
		List<MenuVO> list = new ArrayList<MenuVO>();
		//체크된 메뉴아이디 정보
		String codeList = (String) map.get("codeList");
		String[] codeArray = codeList.split(",");
		for(int i = 0 ;i < codeArray.length ; i++){
			MenuVO vo = new MenuVO();
			vo.setMenuId(Integer.parseInt(codeArray[i]));
			vo.setRoleId((Integer)map.get("roleId"));
			List<MenuVO> menuList = tabPerRoleDAO.selectMenuForTabRegisterNew(vo);
			//roleId로 검색이 안되는 경우 권한이 아직 없는 경우므로 재검색함.
			if(menuList == null || menuList.size() < 1){
				vo.setRoleId(0);
				menuList = tabPerRoleDAO.selectMenuForTabRegisterNew(vo);
			}
			for(MenuVO menu : menuList){
				/*
				 * 선택된 메뉴의 기존 저장된 상위 메뉴 정보를 반환한다.
				 * 기존 정보는 맨 상위 메뉴와 맨 하위 메뉴 정보만 들어가므로 3depth인 메뉴인 경우 
				 * 중간메뉴 정보도 가져온다.
				*/
				MenuVO topMenuVO = new MenuVO();
				topMenuVO.setMenuId(menu.getMenuId());
				topMenuVO.setRoleId((Integer)map.get("roleId"));
				MenuVO topMenuVOForSecond = tabPerRoleDAO.selectMenuForTabForSecondDepth(topMenuVO);
				if(topMenuVOForSecond != null ){
					menu.setNotTreeTopMenuInfo(topMenuVOForSecond);
				}				
			}
			list.addAll(menuList);
		}
		
		return list;
		
	}

}
