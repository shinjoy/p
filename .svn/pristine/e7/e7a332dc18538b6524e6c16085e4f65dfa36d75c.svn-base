package ib.system.service.impl;


import ib.system.service.MenuRegService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("menuRegService")
public class MenuRegServiceImpl extends AbstractServiceImpl implements MenuRegService {

    @Resource(name="menuRegDAO")
    private MenuRegDAO menuRegDAO;
    
    protected static final Log logger = LogFactory.getLog(MenuRegServiceImpl.class);

    
    //권한별 메뉴(로그인시)
  	public List<Map> getMenuByRole(Map<String, String> mParam) throws Exception {
  		
  		return menuRegDAO.getMenuByRole(mParam);
  	}

    
    //메뉴
	public List<Map> getMenuList(Map<String, String> mParam) throws Exception {
		
		return menuRegDAO.getMenuList(mParam);
	}

	
	//권한별 메뉴
	public List<Map> getMenuListByOrg(Map<String, String> mParam) throws Exception{
		return menuRegDAO.getMenuListByOrg(mParam);
	}
	
	//메뉴등록(신규)
	public int insertMenu(Map<String, Object> map) throws Exception {
		
		int boardSeq = menuRegDAO.insertMenu(map);			//메뉴등록
		
		//탭 권한 등록
		if(map.get("menuType").equals("TAB") || map.get("menuType").equals("ALONE")){
			doSaveTab(map,boardSeq);
		}
		return boardSeq;
	}


	//메뉴등록(수정)
	public int updateMenu(Map<String, Object> map) throws Exception {
		
		int svCnt = menuRegDAO.updateMenu(map);				//메뉴수정
		
		//탭 권한 등록
		if(map.get("menuType").equals("TAB") || map.get("menuType").equals("ALONE")){
			doSaveTab(map,Integer.parseInt(map.get("menuId").toString()));
		}
		return svCnt;
	}
	
	//탭 등록 or 수정
	public int doSaveTab(Map<String, Object> map,int menuId) throws Exception {
		int cnt = 0;
		
		if(map.get("roleMenuId").equals("0")){		//등록
			map.put("roleId", "-1");
			cnt = menuRegDAO.insertTabToRole(map);
			
		}else{										//수정
			map.put("roleId", "-1");
			menuRegDAO.updateTabToRole(map);
			cnt = 1;
		}
		return cnt;
	}
	

	//메뉴삭제
	public int deleteMenu(Map<String, Object> param) throws Exception {
		
		return menuRegDAO.deleteMenu(param);
	}


	//메뉴 유효체크 (이미 존재하는지)
	public String getMenuCodeExistYn(Map<String, String> map) throws Exception {
		
		return menuRegDAO.getMenuCodeExistYn(map);
	}
    
    
}
