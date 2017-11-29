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
 * filename	: CodePerRoleDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 10. 29.
 * @version : 
 *
 */
@Repository("codePerRoleDAO")
public class CodePerRoleDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(CodePerRoleDAO.class);


	/**
	 * 권한별 코드SET,값 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 10. 29.
	 */
	public List<Map> getCodeSetValuePerRole(Map<String, String> map) throws Exception{
		
		return  list("system.selectCodeSetValuePerRole", map);
	}

	
	/**
	 * 권한별 코드 제외대상 등록
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys          
	 * @date		: 2015. 10. 29.
	 */
	public int insertCodeSetValuePerRole(Map<String, String> map) throws Exception{
		int key = -1;
		Object rslt = insert("system.insertCodeSetValuePerRole", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		
		return key;
	}	
	

	/**
	 * 권한별 코드 제외대상 에서 제거(결국...권한별 코드 허용)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys          
	 * @date		: 2015. 10. 29.
	 */
	public int deleteCodeSetValuePerRole(Map<String, String> map) throws Exception{
		return delete("system.deleteCodeSetValuePerRole", map);
	}

	

}