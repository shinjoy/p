package ib.user.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package	: ibiss.user.service.impl 
 * filename	: UserCommonDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 11. 16.
 * @version : 
 *
 */
@Repository("userCommonDAO")
public class UserCommonDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(UserCommonDAO.class);

		
	/**
	 * 부서 TREE
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 11. 12.
	 */
	public List<Map> getDeptListForTree(Map<String, String> param) throws Exception{
		
		List<Map> list = list("user.selectDeptListForTree", param);
		
		return list;
	}

	
	/**
	 * 부서별 사원
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 11. 13.
	 */
	public List<Map> getUserListInDept(Map<String, String> param) {

		List<Map> list = list("user.selectUserListInDept", param);
		
		return list;
	}

	
	

}