package ib.system.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package	: ibiss.system.service.impl 
 * filename	: MenuPerRoleDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version : 
 *
 */
@Repository("menuPerRoleDAO")
public class MenuPerRoleDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(MenuPerRoleDAO.class);

	
	/**
	 * 권한별 메뉴리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	public List<Map> getMenuByRoleMenu(Map<String, String> mParam) throws Exception{
		
		return list("system.selectMenuTreeByRole", mParam);
	}

	
	/**
	 * 권한별 메뉴 등록
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 23.
	 */
	public int doSaveMenuByRole(Map<String, Object> map) throws Exception{
		
		//삭제
		delete("system.deleteRoleMenuList", map);		//일단 해당 권한별 메뉴위치별 메뉴리스트를 모두 삭제한다.
		
		//입력
		if(((ArrayList)map.get("pList")).size() > 0){	//저장할 것이 있을때
			insert("system.insertRoleMenuList", map);		//새로 구정된 메뉴구조 저장
		}
		
		return 0;
	}


	/**
	 * 권한별 메뉴 복사
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	public int doCopyMenuByRole(Map<String, Object> map) throws Exception{
		int upCnt = 1;
		
		//삭제
		delete("system.deleteRoleMenuListAll", map);		//일단 해당 권한별 메뉴리스트를 모두 삭제한다.
		
		//입력		
		insert("system.copyRoleMenuList", map);				//복사
		
		
		return upCnt;
	}
	
	
	/**
	 * 권한별 메뉴 복사(상단메뉴와 동일하게 복사)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	public int doCopyByTop(Map<String, Object> map) throws Exception{
		int upCnt = 1;
		
		//삭제
		delete("system.deleteRoleMenuListAllByTop", map);		//일단 해당 권한별, 메뉴위치(좌측)별 메뉴리스트를 모두 삭제한다.
		
		//입력		
		insert("system.copyRoleMenuListByTop", map);			//복사
		
		
		return upCnt;
	}
	
	/**
	 * 권한별 메뉴 검사
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	public Map getRoleMenuByMenuId(Map<String, String> map) throws Exception{
		
		return (Map)selectByPk("system.getRoleMenuByMenuId", map); // list("system.selectMenuTreeByRole", mParam);
	}
	

	//권한별 메뉴 선택복사 
	public int insertRoleMenuList(Map<String, Object> map) throws Exception{
		
		
		return Integer.parseInt(insert("system.insertRoleMenuCopyList", map).toString());
	}
	
	//권한별 메뉴 선택복사 
	public int updateRoleMenuSort(Map<String, Object> map) throws Exception{
		int upCnt = 1;
		
		update("system.updateRoleMenuSort", map);
		
		return upCnt;
	}
	
	//메뉴 사용 가능 여부 체크 ( 권한 + 메뉴코드)
	public int chkMenuRoleExist(Map<String, Object> map) throws Exception{
		
		return Integer.parseInt(selectByPk("menu.chkMenuRoleExist", map).toString());
	}
	
	

}