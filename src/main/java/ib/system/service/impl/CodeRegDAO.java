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
 * filename	: CodeRegDAO.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 8. 10.
 * @version :
 *
 */
@Repository("codeRegDAO")
public class CodeRegDAO extends ComAbstractDAO{


	protected static final Log logger = LogFactory.getLog(CodeRegDAO.class);



	/**
	 * 공통코드 SET
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	public List<Map> getCodeSet(Map<String, String> map) throws Exception{

		return  list("system.selectCodeSet", map);
	}


	/**
	 * 코드SET 등록(신규)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public int insertCodeSet(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("system.insertCodeSet", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());

		return key;
	}

	/**
	 * 코드SET 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 16.
	 */
	public int updateCodeSet(Map<String, Object> map) throws Exception{
		return update("system.updateCodeSet", map);
	}


	/**
	 * 공통코드 LIST
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	public List<Map> getCodeList(Map<String, String> map) throws Exception{

		return  list("system.selectCodeList", map);
	}


	/**
	 * 코드LIST 등록(신규)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public int insertCodeList(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("system.insertCodeList", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());

		return key;
	}

	/**
	 * 코드LIST 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 16.
	 */
	public int updateCodeList(Map<String, Object> map) throws Exception{
		return update("system.updateCodeList", map);
	}

	/**
	 * 코드 set 정보 반환
	 * @param map
	 * @return
	 */
	public Map selectCodeSetForSystem(Map<String,Object> map) throws Exception{
		return (Map) super.getSqlMapClientTemplate().queryForObject("system.selectCodeSetForSystem", map);
	}

	/**
	 * 코드 list 정보 반환
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectCodeListForSystem(Map<String,Object> map) throws Exception{
		return list("system.selectCodeListForSystem", map);
	}

	/**
	 * 코드 셋 정보 업데이트
	 * @param map
	 * @throws Exception
	 */
	public void updateCodeSetForSystem(Map<String,Object> map) throws Exception{
		update("system.updateCodeSetForSystem", map);
	}

	//공통코드,시스템코드 통합 dup chk
	public int getCodeDupChkCnt(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("system.getCodeDupChkCnt", map);
	}

}