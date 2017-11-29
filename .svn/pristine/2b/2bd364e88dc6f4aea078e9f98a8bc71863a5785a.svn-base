package ib.system.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package	: ibiss.system.service
 * filename	: RoleRegService.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version :
 *
 */
public interface RoleRegService {

	//권한코드(콤보박스용)
	List<Map> getRoleCodeCombo(Map<String, String> map) throws Exception;

	//관계사별 권한코드(콤보박스용)
	List<Map> getRoleCodeByOrgCombo(Map<String, String> map) throws Exception;

	//권한코드
	List<Map> getRoleCodeList(Map<String, String> map) throws Exception;

	//권한등록(신규)
	int insertRole(Map<String, Object> map) throws Exception;

	//권한등록(수정)
	int updateRole(Map<String, Object> map) throws Exception;

	//권한삭제
	int deleteRole(Map<String, Object> param) throws Exception;

	//관계사별 결재자공개(삭제 / 저장)
	int processOrgCommonAppvLine(Map<String, Object> param) throws Exception;

	//관계사별 결재자공개 조회
	List<EgovMap> searchOrgCommonAppvLineList(Map<String, Object> map) throws Exception;

	/**
	* 인수인계자 설정 페이지 리스트 
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 12.
	*/
	
	List<EgovMap> transferUserList(Map<String, Object> map) throws Exception;
	
	/**
	* 인수인계자 설정 페이지 - 사용여부 수정 
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 13.
	*/
	
	int modifyTransferUseYn(Map<String, Object> map) throws Exception;
	
	/**
	* 인수인계자 설정 등록
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 16.
	*/
	
	int createTransferUser(Map<String, Object> map) throws Exception;
	
	/**
	* 인수인계자 설정 체크
	*
	* @param		:
	* @return		:
	* @exception	:
	* @author		: sjy
	* @date			: 2017. 10. 25.
	*/
	
	public Integer transferDatachk(Map<String, Object> map) throws Exception;
}
