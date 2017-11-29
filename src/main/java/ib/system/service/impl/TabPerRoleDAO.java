package ib.system.service.impl;


import ib.basic.interceptor.MenuVO;
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
 * filename	: TabPerRoleDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 8. 4.
 * @version : 
 *
 */
@Repository("tabPerRoleDAO")
public class TabPerRoleDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(TabPerRoleDAO.class);

	
	/**
	 * 권한별 탭 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	public List<Map> getTabPerRole(Map<String, String> mParam) throws Exception{
		
		return list("system.selectTabPerRole", mParam);
	}

	
	/**
	 * 메뉴 별 탭
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 10. 21.
	 */
	public List<Map> getTabPerMenu(Map<String, String> mParam) {
		return list("system.selectTabPerMenu", mParam);
	}
	

	/**
	 * 권한별 탭 등록
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 8. 4.
	 */
	public int doSaveTabPerRole(Map<String, Object> map) throws Exception{
		
		//삭제
		delete("system.deleteTabPerMenuList", map);		//일단 해당 메뉴별 탭 리스트를 모두 삭제한다.
		
		//입력
		if(((ArrayList)map.get("pList")).size() > 0){	//저장할 것이 있을때
			insert("system.insertRoleMenuList", map);	//새로 구정된 탭메뉴구조 저장
		}
		
		return 0;
	}


	/**
	 * 권한별 탭 복사
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 8. 4.
	 */
	public int doCopyTabPerRole(Map<String, Object> map) throws Exception{
		int upCnt = 1;
		
		//삭제
		delete("system.deleteRoleTabListAll", map);		//일단 해당 권한별 메뉴리스트를 모두 삭제한다.
		
		//입력		
		insert("system.copyRoleTabList", map);				//복사
		
		
		return upCnt;
	}
	
	/**
	 * 메뉴등록(탭) 선택 시 메뉴 정보 반환.
	 * @param menuVO
	 * @return
	 * @throws Exception
	 */
	public List<MenuVO> selectMenuForTabRegister(MenuVO menuVO) throws Exception{
		return list("system.selectMenuForTabAuthRegister", menuVO);
	}

	/**
	 * selectbox의 선택된 권한을 통해 roleid값 반환.
	 * @param roleText
	 * @return
	 */
	public int selectRoleInfo(String roleText) {
		// TODO Auto-generated method stub
		return (Integer) super.getSqlMapClientTemplate().queryForObject("system.selectUserRoleId", roleText);
	}


	/**
	 * 선택한 메뉴의 3depth의 모든 메뉴 아이디 검색
	 * @param topMenuVO
	 * @return
	 */
	public MenuVO selectMenuForTabForSecondDepth(MenuVO menuVO) {
		// TODO Auto-generated method stub
		return (MenuVO) super.getSqlMapClientTemplate().queryForObject("system.selectMenuForTabForSecondDepth", menuVO);
	}


	/**
	 * 권한별 탭/버튼/팝업에서 상위메뉴 설정 시 체크한 메뉴들의 정보 반환.
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: csy
	 * @date		: 2016. 10. 21.
	 */
	public List<MenuVO> selectMenuForTabRegisterNew(MenuVO menuVO) {
		return list("system.selectMenuForTabRegisterNew", menuVO);
	}


	
	


}