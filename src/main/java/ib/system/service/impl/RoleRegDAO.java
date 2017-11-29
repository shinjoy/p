package ib.system.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;


/**
 * <pre>
 * package	: ibiss.system.service.impl
 * filename	: RoleRegDAO.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version :
 *
 */
@Repository("roleRegDAO")
public class RoleRegDAO extends ComAbstractDAO{


	protected static final Log logger = LogFactory.getLog(RoleRegDAO.class);



	/**
	 * 권한코드(콤보박스용)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	public List<Map> getRoleCodeCombo(Map<String, String> map) throws Exception{

		return  list("system.selectRoleCodeCombo", map);
	}


	/**
	 * 권한코드
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 22.
	 */
	public List<Map> getRoleCodeList(Map<String, String> map) throws Exception{

		return  list("system.selectRoleCodeList", map);
	}


	/**
	 * 권한등록(신규)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 7. 20.
	 */
	public int insertRole(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("system.insertRole", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());

		return key;
	}

	/**
	 * 권한수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 16.
	 */
	public int updateRole(Map<String, Object> map) throws Exception{
		return update("system.updateRole", map);
	}


	/**
	 * 권한삭제(ENABLE 컬럼수정)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 22.
	 */
	public int deleteRole(Map<String, Object> param) throws Exception{
		return update("system.deleteRole", param);
	}


	/**
	 * 관계사별 권한코드(콤보박스용)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 11. 11.
	 */
	public List<Map> getRoleCodeByOrgCombo(Map<String, String> map) throws Exception{
		return list("system.selectRoleCodeByOrgCombo", map);
	}

	/**
	 * 관계사별 결재자공개 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 11. 11.
	 */
	public Integer deleteOrgCommonAppvLine(Map<String, Object> map) throws Exception{
		return (Integer)delete("system.deleteOrgCommonAppvLine", map);
	}

	/**
	 * 관계사별 결재자공개 저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 11. 11.
	 */
	public Integer insertOrgCommonAppvLine(Map<String, Object> paramMap) throws Exception {

		return (Integer)insert("system.insertOrgCommonAppvLine", paramMap);
	}

	/**
	 * 관계사별 결재자공개 조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 11. 11.
	 */
	public List<EgovMap> searchOrgCommonAppvLineList(Map<String, Object> map) throws Exception{
		return list("system.searchOrgCommonAppvLineList", map);
	}
	
	/**
	* 인수인계자 설정 페이지 리스트 
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 12.
	*/
	
	List<EgovMap> transferUserList(Map<String, Object> map) throws Exception{
		
		return list("system.transferUserList", map);
	}
	
	/**
	* 인수인계자 설정 페이지 - 사용여부 수정 
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 13.
	*/
	
	public int modifyTransferUseYn(Map<String, Object> map) throws Exception{
		
		return update("system.modifyTransferUseYn", map);
	}
	
	/**
	* 인수인계자 설정 등록
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 16.
	*/
	
	public Integer createTransferUser(Map<String, Object> map) throws Exception{
		
		return (Integer)insert("system.createTransferUser", map);
	}
	
	/**
	* 인수인계자 설정 체크
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 25.
	*/
	
	public Integer transferDatachk(Map<String, Object> map) throws Exception{
		
		return Integer.parseInt(selectByPk("project.transferDatachk", map).toString());
	}


}