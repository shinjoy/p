package ib.company.service.impl;

import ib.basic.service.CpnExcelVO;
import ib.cmm.service.impl.ComAbstractDAO;
import ib.company.service.CompanyVO;
import ib.work.service.WorkVO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package  : ib.company.service.impl
 * filename : CompanyDAO.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 28.
 * @version : 1.0.0
 */
@Repository("companyDAO")
public class CompanyDAO extends ComAbstractDAO{

	/**
	 *
	 * @MethodName : selectMainCompanyList
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<CompanyVO> selectMainCompanyList(CompanyVO companyVO) throws Exception{
		return list("companyDAO.selectMainCompanyList", companyVO);
	}
	/**
	 *
	 * @MethodName : selectCompanyList
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<CompanyVO> selectCompanyList(CompanyVO companyVO) throws Exception{
		return list("companyDAO.selectCompanyList", companyVO);
	}

	/**
	 *
	 * @MethodName : selectNetPointList
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CompanyVO> selectNetPointList(CompanyVO companyVO) throws Exception{
		return list("companyDAO.selectNetPointList", companyVO);
	}
	/**
	 *
	 * @MethodName : selectMaxCpnId
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CompanyVO> selectMaxCpnId(CompanyVO companyVO) throws Exception{
		return list("companyDAO.selectMaxCpnId", companyVO);
	}
	/**
	 *
	 * @MethodName : insertCompany
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int insertCompany(CompanyVO companyVO) throws Exception {
		return (Integer)update("companyDAO.insertCompany", companyVO);
	}
	/**
	 *
	 * @MethodName : insertCompany : psj 추가
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int insertCompany2(CompanyVO companyVO) throws Exception {
		List<Map> result = selectMaxCpnIds();
		companyVO.setSeq(result.get(0).get("seq").toString());
		companyVO.setaSeq(result.get(0).get("aSeq").toString());
		companyVO.setaFSeq(result.get(0).get("aFSeq").toString());

		String sNb = insert("companyDAO.insertCompany2", companyVO).toString();
		companyVO.setCpnId(result.get(0).get("seq").toString());
		companyVO.setsNb(sNb);

		return Integer.parseInt(result.get(0).get("seq").toString());
	}
	/**
	 *
	 * @MethodName : selectMainCompanyList2
	 * @param companyVO
	 * @return
	 */
	public CompanyVO selectMainCompanyList2(CompanyVO companyVO) throws Exception{
		return (CompanyVO)getSqlMapClientTemplate().queryForObject("companyDAO.selectMainCompanyList2", companyVO);
	}
	/**
	 *
	 * @MethodName : selectMainCompanyList2
	 * @param companyVO
	 * @return
	 */
	public EgovMap selectMainCompanyList3(CompanyVO companyVO) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("companyDAO.selectMainCompanyList3", companyVO);
	}
	/**
	 *
	 * @MethodName : selectNoteList2
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CompanyVO> selectNoteList2(CompanyVO companyVO) throws Exception{
		return list("companyDAO.selectNoteList2", companyVO);
	}
	/**
	 *
	 * @MethodName : updateCompany
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int updateCompany(CompanyVO companyVO) throws Exception {
		return (Integer)update("companyDAO.updateCompany", companyVO);
	}
	/**
	 *
	 * @MethodName : updateCompany : psj 추가
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int updateCompany2(CompanyVO companyVO) throws Exception {
		return (Integer)update("companyDAO.updateCompany2", companyVO);
	}

	/**
	 *
	 * @MethodName : updateCompany : psj 추가
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int updateCompany3(CompanyVO companyVO) throws Exception {
		return (Integer)update("companyDAO.updateCompany3", companyVO);
	}

	/**
	 *
	 * @MethodName : selectCompanyListCnt
	 * @param companyVO
	 * @return
	 */
	public int selectCompanyListCnt(CompanyVO companyVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("companyDAO.selectCompanyListCnt", companyVO);
    }
	/**
	 *
	 * @MethodName : insertNupdateCompanyExel
	 * @param vo
	 * @return
	 */
	public Integer insertNupdateCompanyExel(CpnExcelVO vo) throws Exception {
		return (Integer)update("companyDAO.updateCompanyExcel", vo);
	}
	/**
	 *
	 * @MethodName : updateCEO
	 * @return
	 */
	public int updateCEO() throws Exception {
		return (Integer)update("companyDAO.updateCEO", null);
	}

	/**
	 *
	 * @MethodName : selectEmployeeList
	 * @param workVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<WorkVO> selectEmployeeList(WorkVO VO) throws Exception {
		return list("companyDAO.selectEmployeeList", VO);
	}

	/**
	 *
	 * @MethodName : selectOpinionListCnt
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int selectOpinionListCnt(WorkVO workVO) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("personDAO.selectOpinionListCnt", workVO);
	}
	/**
	 *
	 * @MethodName : selectNetPointListCnt
	 * @param companyVO
	 * @return
	 */
	public int selectNetPointListCnt(CompanyVO companyVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("companyDAO.selectNetPointListCnt", companyVO);
	}
	/**
	 *
	 * @MethodName : selectCpnIdNewNold
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<WorkVO> selectCpnIdNewNold() throws Exception {
		WorkVO vo = new WorkVO();
		return list("companyDAO.selectCpnIdNewNold",vo);
	}
	/**
	 *
	 * @MethodName : updateCompanyCpnId
	 */
	public int updateCompanyCpnId() {
		WorkVO vo = new WorkVO();
		//return (Integer)update("companyDAO.updateCompanyCpnId", vo);			사용하지 않도록 20160720
		return 0;
	}

	/**
	 *
	 * @MethodName : selectDefaultCompanyList
	 * @param companyVO
	 * @return
	 * @author : user
	 * @since : 2015. 3. 18.
	 */
	@SuppressWarnings("unchecked")
	public List<CompanyVO> selectDefaultCompanyList(CompanyVO companyVO) throws Exception{
		return list("companyDAO.selectDefaultCompanyList", companyVO);
	}


	//기존 회사 리스트 중에서 select 체크 (회사 일괄 업로드 프로세스)
	public List<Map> selectCompanyForChk(Map<String, Object> param) throws Exception {
		return list("companyDAO.selectCompanyForChk", param);
	}

	//회사 인서트 (회사 일괄 업로드 프로세스)
	public int insertCompanyList(Map<String, Object> param) throws Exception {
		List<Map> result = null;
		try{
			result = selectMaxCpnIdForUpload(null);

		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}

		param.put("cpnId", result.get(0).get("seq").toString());

		return update("companyDAO.insertCompanyList", param);
	}
	//회사 업데이트 (회사 일괄 업로드 프로세스)
	public int updateCompanyList(Map<String, Object> param) throws Exception {
		return (Integer)update("companyDAO.updateCompanyList", param);
	}
	//메인화면 네트워크 리스트
	public List<EgovMap> getMainNetworkList(Map<String,Object> paramMap) throws Exception{
		return list("companyDAO.getMainNetworkList", paramMap);
	}

	//회사코드
	public List<Map> selectMaxCpnIds() throws Exception{
		return list("companyDAO.selectMaxCpnIds", null);
	}
	/**
	 *
	 * @MethodName : selectMaxCpnIdForUpload
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectMaxCpnIdForUpload(Map map) throws Exception{
		return list("companyDAO.selectMaxCpnIdForUpload", map);
	}
	/**
	 *
	 * @MethodName : companyInfoAddEnd
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int companyInfoAddEnd(Map<String,Object> paramMap) throws Exception {
		return (Integer)update("companyDAO.companyInfoAddEnd", paramMap);
	}

	// 미등록된 종목 자동 업데이트
	@SuppressWarnings("rawtypes")
	public void autoCateAddEnd(Map<String,Object> paramMap) throws Exception {
		insert("companyDAO.autoCateAddEnd", paramMap);
	}
	/**
	 *
	 * @MethodName : selectMaxCpnIdForUpload
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getPriceAddList(Map map) throws Exception{
		return list("companyDAO.getPriceAddList", map);
	}
	// 시가 등록 완료
	@SuppressWarnings("rawtypes")
	public void priceAddEnd(List list) throws Exception {

		//insert("adminDAO.PriceAddEnd", list);

		for(int i=0; i<list.size(); i++){
			insert("companyDAO.PriceAddEndOneByOne", list.get(i));
		}

	}
	//국가코드
	public List<Map> selectContryCodeList(Map map) throws Exception{
		return list("companyDAO.selectContryCodeList", map);
	}

	//삭제 대상 회사 조회
	public Integer getDeleteCompanyInfo(Map<String,Object> paramMap) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("companyDAO.getDeleteCompanyInfo", paramMap);
	}
	//회사 삭제
	public Integer deleteCompany(Map<String,Object> paramMap) throws Exception {
		return delete("companyDAO.deleteCompany",paramMap);
	}
	//상장회사정보 삭제
	public Integer deleteCompanyInfo(Map<String,Object> paramMap) throws Exception {
		return delete("companyDAO.deleteCompanyInfo",paramMap);
	}
}