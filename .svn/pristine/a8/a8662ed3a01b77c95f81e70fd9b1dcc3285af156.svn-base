package ib.person.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.basic.service.CpnExcelVO;
import ib.company.service.CompanyVO;
import ib.login.service.StaffVO;
import ib.work.service.WorkVO;

/**
 * <pre>
 * package	:
 * filename	:
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2016. 01. 15.
 * @version :
 *
 */
public interface PersonMgmtService {

	//회사별 부서 리스트
	List<Map> getCpnDeptList(Map map) throws Exception;

	//고객리스트
	List<Map> getCustListForExcel(Map<String, Object> map) throws Exception;

	Map<String, Object> getCustList(Map<String, Object> map) throws Exception;

	//신규할당 고객
	List<Map> getCustListNewInCharge(Map<String, String> map) throws Exception;

	//할당고객 수락
	int doAcceptCstManager(Map<String, Object> map) throws Exception;

	//고객등록(기본 + 네트워크) ... by Map
	int regCustomer(Map<String, Object> map,PersonVO personVO) throws Exception;

	//고객찾기(이름으로)
	Map getCustomerByName(Map<String, Object> map) throws Exception;

	//고객 정보 (1명) ... 핸드폰번호 중복자 체크
	public Map getCustomerSameMobile(Map<String, Object> map) throws Exception;

	//고객 정보 (1명) ... 이름 중복자 체크
	public Map getCustomerSameName(Map<String, Object> map) throws Exception;

	//고객 삭제
	int doDelCst(Map<String, Object> map) throws Exception;

	 List getPerList(Map<String,Object> map) throws Exception ;

	 /**
	 *
	 * @MethodName : selectPersonList
	 * @param personVO
	 * @return
	 * @throws Exception
	 */
	public List<PersonVO> selectPersonList(PersonVO personVO) throws Exception;
	/**
	 *
	 * @MethodName : selectPersonListCnt
	 * @param personVO
	 * @return
	 */
	public int selectPersonListCnt(PersonVO personVO) throws Exception;
	/**
	 *
	 * @MethodName : selectMainPersonList
	 * @param personVO
	 * @return
	 * @throws Exception
	 */
	public List<PersonVO> selectMainPersonList(PersonVO personVO) throws Exception;

	/**
	 *
	 * @MethodName : selectNetworkList
	 * @param personVO
	 * @return
	 */
	public List<EgovMap> selectNetworkList(PersonVO VO,PaginationInfo paginationInfo) throws Exception;
	/**
	 *
	 * @MethodName : selectNetworkListTotalCnt
	 * @param personVO
	 * @return
	 */
	public Integer selectNetworkListTotalCnt(PersonVO VO) throws Exception;

	/**
	 *
	 * @MethodName : selectMaxSnb
	 * @param personVO
	 * @return
	 * @throws Exception
	 */
	public List<PersonVO> selectMaxSnb(PersonVO personVO) throws Exception;
	/**
	 *
	 * @MethodName : insertNetworkCst
	 * @param personVO
	 * @return
	 * @throws Exception
	 */
	public int insertNetworkCst(PersonVO personVO) throws Exception;

	/**
	 *
	 * @MethodName : insertNote
	 * @param personVO
	 * @return
	 * @throws Exception
	 */
	public int insertNote(PersonVO personVO) throws Exception;
	/**
	 *
	 * @MethodName : updateCustomerByIbSystem
	 * @param personVO
	 * @return
	 * @throws Exception
	 */
	public int updateCustomerByIbSystem(PersonVO personVO,Map<String, Object> map) throws Exception;
	/**
	 *
	 * @MethodName : updateCustomerByIbSystem
	 * @param personVO
	 * @return
	 * @throws Exception
	 */
	public int updateCstPhnByIbSystem(PersonVO personVO) throws Exception;
	/**
	 *
	 * @MethodName : excelInsertNote
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int excelInsertNote(CpnExcelVO vo) throws Exception;
	/**
	 *
	 * @MethodName : selectExcelDown
	 * @param VO
	 * @return
	 * @throws Exception
	 */
	public List<PersonVO> selectExcelDown(PersonVO VO) throws Exception;
	/**
	 * 증권사 IB 고객 담당자 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 2. 19.
	 */
	public int doSaveCstManager(Map<String, Object> map) throws Exception;


	/**
	 *
	 * @MethodName : deletePersonNetInfo
	 * @param personVO
	 * @return
	 */
	public int deletePersonNetInfo(PersonVO VO) throws Exception;

	/**
	 *
	 * @MethodName : modifyNetPoint
	 * @param personVO
	 * @return
	 */
	public int modifyNetPoint(PersonVO VO) throws Exception ;


	/**
	 * 담당자 바로 등록 (상태값 'Y')
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 3. 16.
	 */
	public int doSaveCstManagerDirect(Map<String, Object> map) throws Exception;
	/**
	 *
	 * @MethodName : selectSearchDuplicateB4excelInsert
	 * @param psnVo
	 * @return
	 */
	public int selectSearchDuplicateB4excelInsert(WorkVO psnVo) throws Exception;
	/**
	 *
	 * @MethodName : excelInsertCustomer
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int excelInsertCustomer(CpnExcelVO vo) throws Exception ;


	/**
	 *
	 * @MethodName : updateStaffInformation
	 * @param psnVo
	 */
	public int updateStaffInformation(StaffVO VO) throws Exception;

	/**
	 *
	 * @MethodName : updateIBstaffwithInside
	 * @param stVo
	 * @return
	 */
	public Integer updateIBstaffwithInside(StaffVO VO) throws Exception;


	public List<Map> selectStaffList(Map<String,Object>map) throws Exception;

	/**
	 * 고객이력 목록
	 * @MethodName : selectCustomerCareerList
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCustomerCareerList(PersonVO VO) throws Exception;

	/**
	 * 고객학력 목록
	 * @MethodName : selectCustomerCareerList
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCustomerSchoolList(PersonVO VO) throws Exception;

	/**
	 * 고객 정보 (1명)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 3. 16.
	 */
	public PersonVO getCustomer(PersonVO personVO) throws Exception;

	public List<EgovMap> getCpnUserList(String cpnId) throws Exception;

	//고객의 orgIdList를 조회한다
	public List<EgovMap> getCustomerOrgIdList(PersonVO personVO) throws Exception;

	//담당자 정보를 조회한다
	public EgovMap getOtherOrgStaff(Map<String,Object> map) throws Exception;

	//사용자이름 가져오기
	public List<EgovMap> getUserNameList(Map<String, Object> map) throws Exception;
	//전체 관계사 목록 (네트워크 > 고객 > 상세팝업)
	public List<Map> getOrgIdListForCustomer(PersonVO personVO) throws Exception;

	//담당고객정보수정확인 리스트
	List<Map> getCustomerChangeConfirmList(Map<String, Object> map) throws Exception;

	//고객 알림 팝업 노출 여부 판단
	public Integer getChkPersonNoticeInfo(Map<String, Object> map) throws Exception;
	//고객 알림 데이터 삭제
	public Integer deleteCustomerInfoChange(Map<String, Object> map) throws Exception;
	//인물삭제
	public String deleteCustomer(Map<String,Object> paramMap) throws Exception;
}
