package ib.cmm.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;



/**
 * <pre>
 * package	: eam.common.service.impl
 * filename	: CommonDAO.java
 * </pre>
 *
 *
 *
 * @author	: YoungSik Oh
 * @date	: 2015. 6. 29.
 * @version :
 *
 */
@Repository("commonDAO")
public class CommonDAO extends ComAbstractDAO{


	protected static final Log logger = LogFactory.getLog(CommonDAO.class);




	/**
	 * 공통코드
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<Map> getCommonCode(Map<String, String> param) throws Exception{

		List<Map> list = list("common.selectCommonCode", param);

		return list;
	}


	/**
	 * 공통코드(BASE)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<Map> getBaseCommonCode(Map<String, String> param) throws Exception{

		List<Map> list = list("common.selectBaseCommonCode", param);

		return list;
	}


	/**
	 * 사원리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 3. 9.
	 */
	public List<Map> getStaffList(Map<String, String> param) throws Exception{

		List<Map> list = list("common.selectStaffList", param);
		return list;
	}


	/**
	 * 사원리스트(이름정렬)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 3. 18.
	 */
	public List<Map> getStaffListNameSort(Map<String, String> param) throws Exception{

		List<Map> list = list("common.selectStaffListNameSort", param);
		return list;
	}

	/**
	 * 사원이름 목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 3. 18.
	 */
	public List<Map> getUserNameList(Map<String, String> param) throws Exception{

		List<Map> list = list("common.selectUserNameList", param);
		return list;
	}

	/**
	 * divisionList(sort 정렬)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 7. 12.
	 */
	public List<Map> getSelectDivisionList(Map<String, String> param) throws Exception{

		List<Map> list = list("common.getSelectDivisionList", param);
		return list;
	}


	/**
	 * 부서 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 8. 10.
	 */
	public List<Map> getDeptList(Map<String, String> map) throws Exception{

		List<Map> list = list("common.selectDeptList", map);
		return list;
	}


	/**
	 * ORG 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 18.
	 */
	public List<Map> getOrgCodeCombo(Map<String, String> map) throws Exception{
		List<Map> list = list("common.selectOrgCodeCombo", map);
		return list;
	}


	/**
	 * org에 따른 companyList - ib_company 의 ref_org_id
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 19.
	 */
	public List<Map> getCompanyListCombo(Map<String, String> map) throws Exception{
		List<Map> list = list("common.getCompanyListCombo", map);
		return list;
	}


	/**
	 * org list
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 31.
	 */
	public List<Map> getOrgList(Map<String, String> map) throws Exception{
		List<Map> list = list("common.getCompanyListCombo", map);
		return list;
	}


	/**
	 * 사용자 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 31.
	 */
	public List<Map> getUserList(Map<String, String> map) {
		List<Map> list = list("common.selectUserList", map);
		return list;
	}

	/**
	 * 유저 그룹 목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 8. 10.
	 */
	public List<Map> getUserGroupList(Map<String, String> map) throws Exception{

		List<Map> list = list("common.getUserGroupList", map);
		return list;
	}

	/**
	 * 유저 그룹 상세목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 8. 10.
	 */
	public List<Map> getUserGroupDetailList(Map<String, String> map) throws Exception{

		List<Map> list = list("common.getUserGroupDetailList", map);
		return list;
	}

}