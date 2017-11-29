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
 * filename	: ModuleRegDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 8. 5.
 * @version : 
 *
 */
@Repository("moduleRegDAO")
public class ModuleRegDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(ModuleRegDAO.class);

	
	/**
	 * 권한별모듈정보(로그인시)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public List<Map> getModuleByRole(Map<String, String> mParam) throws Exception{
		
		return list("system.selectModuleByRole", mParam);
	}
	
	/**
	 * 모듈등록 모듈리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public List<Map> getModuleList(Map<String, String> mParam) throws Exception{
		
		return list("system.selectModuleList", mParam);
	}

	
	/**
	 * 모듈등록(신규)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public int insertModule(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("system.insertModule", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		
		return key;
	}

	/**
	 * 모듈수정
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 16.
	 */
	public int updateModule(Map<String, Object> map) throws Exception{
		return update("system.updateModule", map);
	}
	
	
	/**
	 * 모듈삭제(ENABLE 컬럼수정)
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 22.
	 */
	public int deleteModule(Map<String, Object> param) throws Exception{
		return update("system.deleteModule", param);
	}


}