package ib.company.service;

import ib.basic.service.CpnExcelVO;

import ib.work.service.WorkVO;

import java.io.File;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

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
public interface CompanyService {

	//회사 일괄 업로드 - CSV
	//Map regCustomer(Map<String, Object> map) throws Exception;
	Map uploadCompanyProcess(Map<String, Object> map, File fNewname1) throws Exception;

	//상장회사 일괄 업로드 - CSV
	Map uploadCompanyInfoProcess(Map<String, Object> map, File fNewname1) throws Exception;

	//주가정보 일괄 업로드 - CSV
	Map uploadStockProcess(Map<String, Object> map, File fNewname1) throws Exception;


	public CompanyVO selectMainCompanyList2(CompanyVO companyVO) throws Exception;
	public EgovMap selectMainCompanyList3(CompanyVO companyVO) throws Exception;

	public List<CompanyVO> selectMainCompanyList(CompanyVO companyVO) throws Exception;

	public List<CompanyVO> selectNoteList2(CompanyVO companyVO) throws Exception;

	public List<WorkVO> selectEmployeeList(WorkVO VO) throws Exception;

	public int selectNetPointListCnt(CompanyVO companyVO) throws Exception;

	public List<CompanyVO> selectNetPointList(CompanyVO companyVO) throws Exception;

	public List<CompanyVO> selectCompanyList(CompanyVO companyVO) throws Exception;

	public int selectCompanyListCnt(CompanyVO companyVO) throws Exception;

	public List<CompanyVO> selectMaxCpnId(CompanyVO companyVO) throws Exception;

	public int insertCompany(CompanyVO companyVO) throws Exception;
	//psj추가
	public int insertCompany2(CompanyVO companyVO) throws Exception;

	public int updateCompany(CompanyVO companyVO) throws Exception;
	//psj 추가
	public int updateCompany2(CompanyVO companyVO) throws Exception;

	//psj 추가
	public int updateCompany3(CompanyVO companyVO) throws Exception;

	public Integer insertNupdateCompanyExel(CpnExcelVO vo) throws Exception;
	/**
	 *
	 * @MethodName : updateCEO
	 * @return
	 */
	public int updateCEO() throws Exception;
	/**
	 *
	 * @MethodName : selectDefaultCompanyList
	 * @param companyVO
	 * @return
	 * @author : user
	 * @since : 2015. 3. 18.
	 */
	public List<CompanyVO> selectDefaultCompanyList(CompanyVO companyVO) throws Exception;

	//메인화면 네트워크 리스트
	public List<EgovMap> getMainNetworkList(Map<String,Object> paramMap) throws Exception;

	//회사코드
	public List<Map> selectMaxCpnIds() throws Exception;

	//국가코드
	public List<Map> selectContryCodeList(Map map) throws Exception;

	//회사삭제
	public String deleteCompany(Map<String,Object> paramMap) throws Exception;
}
