package ib.system.service.impl;


import ib.system.service.MenuPerRoleService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("menuPerRoleService")
public class MenuPerRoleServiceImpl extends AbstractServiceImpl implements MenuPerRoleService {

    @Resource(name="menuPerRoleDAO")
    private MenuPerRoleDAO menuPerRoleDAO;
    
    protected static final Log logger = LogFactory.getLog(MenuPerRoleServiceImpl.class);

    
    //권한별 메뉴(로그인시)
  	public List<Map> getMenuByRoleMenu(Map<String, String> mParam) throws Exception {
  		
  		return menuPerRoleDAO.getMenuByRoleMenu(mParam);
  	}


	//권한별 메뉴 등록
	public int doSaveMenuByRole(Map<String, Object> map) throws Exception {	
		return menuPerRoleDAO.doSaveMenuByRole(map);
	}

	
	//권한별 메뉴 복사
	public int doCopyMenuByRole(Map<String, Object> map) throws Exception {
		return menuPerRoleDAO.doCopyMenuByRole(map);
	}

	
	//권한별 메뉴 복사(상단메뉴와 동일하게 복사)
	public int doCopyByTop(Map<String, Object> map) throws Exception {
		return menuPerRoleDAO.doCopyByTop(map);
	}
	
	//권한별 메뉴 선택 복사
	public int doCopySelectRoleMenuList(Map<String, Object> map) throws Exception {
		
		int chk =0;
		String menuListStr = map.get("menuList").toString();
		
		TypeReference<List<Map>> mapType = new TypeReference<List<Map>>() {};
	 	List<Map> menuList = new ObjectMapper().readValue(menuListStr, mapType);
		
	 	for(int i=0;i<menuList.size();i++){
	 		Map menuObj = menuList.get(i);
	 		menuObj.put("orgId", map.get("orgId"));
	 		menuObj.put("userSeq", map.get("userSeq"));	
	 		menuObj.put("roleId", map.get("roleId"));
	 		
	 		//System.out.println(menuObj.get("menuTitleKor")+"###"+menuObj.get("sort")); 
	 		if(menuObj.get("newYn").equals("Y")){				//신규 추가건
	 			if(menuPerRoleDAO.getRoleMenuByMenuId(menuObj) == null){
	 				
	 				chk=menuPerRoleDAO.insertRoleMenuList(menuObj);		//신규등록 한다
	 		 	}else{
	 		 		
	 		 		chk=menuPerRoleDAO.updateRoleMenuSort(menuObj);
	 		 	}
	 		}else{													//기 등록건 - sort 값 변경시켜준다.
	 			
	 			chk=menuPerRoleDAO.updateRoleMenuSort(menuObj);
	 		}
	 	}
	 	
	 	return chk;
	}
	
	//메뉴 사용 가능 여부 체크 ( 권한 + 메뉴코드)
	public int chkMenuRoleExist(Map<String, Object> map) throws Exception {
		
		return menuPerRoleDAO.chkMenuRoleExist(map);
	}
    
     
}
