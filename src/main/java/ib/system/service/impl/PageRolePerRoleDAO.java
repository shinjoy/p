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
 * filename	: PageRolePerRoleDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 10. 28.
 * @version : 
 *
 */
@Repository("pageRolePerRoleDAO")
public class PageRolePerRoleDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(PageRolePerRoleDAO.class);

	
	/**
	 * 권한별 화면권한 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 10. 28.
	 */
	public List<Map> getPageRoleList(Map<String, String> mParam) throws Exception{
		
		return list("system.selectPageRoleList", mParam);
	}

	
	/**
	 * 화면권한변경 저장
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 10. 28.
	 */
	public int mergePageRole(Map<String, String> param) throws Exception{
		return update("system.mergePageRole", param);
	}


	/**
	 * 화면권한 일괄 변경(컬럼헤드 체크박스)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 10. 28.
	 */
	public int changePageRoleAll(Map<String, String> param) throws Exception{
		return update("system.changePageRoleAll", param);
	}
	
	



}