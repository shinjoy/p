package ib.system.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package	: ibiss.system.service.impl 
 * filename	: MenuRegDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version : 
 *
 */
@Repository("menuRegDAO")
public class MenuRegDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(MenuRegDAO.class);

	
	/**
	 * 권한별메뉴정보(로그인시)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public List<Map> getMenuByRole(Map<String, String> mParam) throws Exception{
		
		return list("system.selectMenuByRole", mParam);
	}
	
	/**
	 * 메뉴관리 메뉴리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public List<Map> getMenuList(Map<String, String> mParam) throws Exception{
		
		return list("system.selectMenuList", mParam);
	}

	
	/**
	 * 메뉴등록(신규)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public int insertMenu(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("system.insertMenu", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		
		return key;
	}

	/**
	 * 메뉴수정
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 16.
	 */
	public int updateMenu(Map<String, Object> map) throws Exception{
		return update("system.updateMenu", map);
	}
	
	
	/**
	 * 메뉴삭제(DEL_YN 컬럼수정)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 22.
	 */
	public int deleteMenu(Map<String, Object> param) throws Exception{
		return update("system.deleteMenu", param);
	}

	/**
	 * 권한별  메뉴 리스트 by 관리사별
	 * @param mParam
	 * @return
	 * @throws Exception
	 */
	public List<Map> getMenuListByOrg(Map<String, String> mParam) throws Exception{
		return list("system.selectMenuListByOrg", mParam);
	}
	
	/**
	 * 탭 등록시 role_menu_list 에 등록해준다.
	 * @param mParam
	 * @return
	 * @throws Exception
	 */
	public int insertTabToRole(Map<String, Object> param) throws Exception{
		return (Integer)insert("system.insertTabToRole", param);
	}	
	
	/**
	 * 탭 등록시 role_menu_list 에 업데이트해준다.
	 * @param mParam
	 * @return
	 * @throws Exception
	 */
	public int updateTabToRole(Map<String, Object> param) throws Exception{
		return (Integer)update("system.updateTabToRole", param);
	}

	
	//메뉴 유효체크 (이미 존재하는지)
	public String getMenuCodeExistYn(Map<String, String> map) throws Exception{
		
		return (String)selectByPk("system.selectMenuCodeExistYn", map);
	}	
	
	



}