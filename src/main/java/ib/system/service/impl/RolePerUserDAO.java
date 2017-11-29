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
 * filename	: RolePerUserDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version : 
 *
 */
@Repository("rolePerUserDAO")
public class RolePerUserDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(RolePerUserDAO.class);

	
	
	/**
	 * 사용자리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 26.
	 */
	public List<Map> getUserList(Map<String, String> param) throws Exception{
		
		return list("system.selectUserList", param);
	}


	/**
	 * 사용자리스트 - 권한설정을 위한
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 11. 9.
	 */
	public List<Map> getUserListByRole(Map<String, String> map) throws Exception{
		return list("system.selectUserListByRole", map);
	}
	

	/**
	 * 권한변경 저장
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 30.
	 */
	public int mergeRoleCode(Map<String, String> param) throws Exception{
		logger.debug("##############"+ param);
		return update("system.mergeRoleCode", param);
	}


	/**
	 * 권한 관계사 접근 권한 타입 변경
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2016. 11. 9.
	 */
	public int updateOrgAccessAuthType(Map<String, String> param) throws Exception{
		return update("system.updateOrgAccessAuthType", param);
	}
	
	//권한 삭제
	public void deleteUserRole(Map<String, String> map) throws Exception{
		delete("system.deleteUserRole", map);
	}


}