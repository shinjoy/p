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
 * filename	: ModulePerRoleDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 8. 5.
 * @version : 
 *
 */
@Repository("modulePerRoleDAO")
public class ModulePerRoleDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(ModulePerRoleDAO.class);

	
	/**
	 * 권한별 모듈 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	public List<Map> getModulePerRole(Map<String, String> mParam) throws Exception{
		
		return list("system.selectModulePerRole", mParam);
	}


	/**
	 * 권한별 모듈 등록
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 23.
	 */
	public int doSaveModulePerRole(Map<String, Object> map) throws Exception{
		
		//삭제
		delete("system.deleteRoleModuleList", map);			//일단 해당 권한별 모듈 리스트를 모두 삭제한다.
		
		//입력
		if(((ArrayList)map.get("pList")).size() > 0){		//저장할 것이 있을때
			insert("system.insertRoleModuleList", map);		//새로 구정된 모듈구조 저장
		}
		
		return 0;
	}


	/**
	 * 권한별 모듈 복사
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 7. 24.
	 */
	public int doCopyModulePerRole(Map<String, Object> map) throws Exception{
		int upCnt = 1;
		
		//삭제
		delete("system.deleteRoleModuleListAll", map);		//일단 해당 권한별 모듈리스트를 모두 삭제한다.
		
		//입력		
		insert("system.copyRoleModuleList", map);				//복사
		
		
		return upCnt;
	}
	
	


}