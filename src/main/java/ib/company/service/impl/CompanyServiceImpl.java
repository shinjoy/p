package ib.company.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import au.com.bytecode.opencsv.CSVReader;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.basic.service.CpnExcelVO;
import ib.company.service.CompanyService;
import ib.company.service.CompanyVO;
import ib.work.service.WorkVO;


@Service("companyService")
public class CompanyServiceImpl extends AbstractServiceImpl implements CompanyService {

    @Resource(name="companyDAO")
    private CompanyDAO companyDAO;


    @Autowired
    private DataSourceTransactionManager transactionManager;



    protected static final Log logger = LogFactory.getLog(CompanyServiceImpl.class);



	//회사 일괄 업로드 - CSV
	public Map uploadCompanyProcess(Map baseUserLoginInfo, File fNewname1) throws Exception {
		//----------------------------------- 등록 :S -----------------------------------

    	FileInputStream is = new FileInputStream(fNewname1);
		InputStreamReader isr = new InputStreamReader(is, "EUC-KR");

		CSVReader reader = new CSVReader(isr);
		List myEntries = reader.readAll();				//전체 row 읽어

		//List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		boolean isComplete = true;
		String failMsg = "";			//실패시 전달할 메세지
		for(int m = 1; m < myEntries.size(); m++) {		//index 1(2번째 row...실제 데이터) 부터 등록해준다.
			String[] arr = (String[]) myEntries.get(m);	//한개 row
			//String data = "";

			//CpnExcelVO tmpVO = new CpnExcelVO();
			Map<String, Object> tmpMap = new HashMap<String, Object>();

			//tmpMap.put("cpnId", 			arr[0].toString().trim());		// 회사코드
			tmpMap.put("aCpnId", 			arr[0].toString().trim());		// 상장사코드
			tmpMap.put("cpnNm", 			arr[1].toString().trim());		// 회사명
			tmpMap.put("categoryBusiness", 	arr[2].toString().trim());		// 업종
			tmpMap.put("listedDt", 			arr[3].toString().trim());		// 상장일자
			tmpMap.put("majorProduct", 		arr[4].toString().trim());		// 주요품목

			tmpMap.put("rgId", 				baseUserLoginInfo.get("loginId").toString());				// 등록자 id
			tmpMap.put("upId", 				baseUserLoginInfo.get("loginId").toString());				// 수정자 id

			//list.add(tmpMap);


			//1.cpn_id, a_cpn_id 가 기존에 있는 건의 갯수
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("cpnId", tmpMap.get("cpnId"));
			List<Map> list = companyDAO.selectCompanyForChk(param);
			List<Map> list2 = null;

			int cnt = list.size();		//cpnId 로 검색한 결과수
			int upCnt = 0;				//저장갯수(및 임시변수)


			if(cnt > 0){				//있는 상장코드
	  			companyDAO.updateCompanyList(tmpMap);			//수정
			}else{
				companyDAO.insertCompanyList(tmpMap);			//등록
			}
		}//for


		//reader closing
		reader.close();
		isr.close();
		is.close();

		Map rMap = new HashMap<String, Object>();
		rMap.put("upload", 1);			//업로드 success

		//----------------------------------- 등록 :E -----------------------------------

		return rMap;
	}

	//상장회사 일괄 업로드 - CSV
	public Map uploadCompanyInfoProcess(Map baseUserLoginInfo, File fNewname1) throws Exception {
		//----------------------------------- 등록 :S -----------------------------------

    	FileInputStream is = new FileInputStream(fNewname1);
		InputStreamReader isr = new InputStreamReader(is, "EUC-KR");

		CSVReader reader = new CSVReader(isr);
		List myEntries = reader.readAll();				//전체 row 읽어

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		boolean isComplete = true;
		String failMsg = "";			//실패시 전달할 메세지

		String Data = "";

		for(int m = 13; m < myEntries.size(); m++) {		//index 1(2번째 row...실제 데이터) 부터 등록해준다.
			String[] arr = (String[]) myEntries.get(m);	//한개 row
			//String data = "";
			Map<String, Object> tmpMap = new HashMap<String, Object>();
			for(int k = 0; k < arr.length; k++) {
				Data = arr[k].toString().trim();
					if(k == 0) 		tmpMap.put("ComCd"           ,Data.equals("") ? null :Data);	// 회사코드
					else if(k == 1) tmpMap.put("ComNm"           ,Data.equals("") ? null :Data);// 회사명
					else if(k == 2) tmpMap.put("AccountMonth"    ,Data.equals("") ? null :Data);// 결산월
					else if(k == 3) tmpMap.put("MarketType"      ,Data.equals("") ? null :Data);// 시장구분
					else if(k == 4) tmpMap.put("Addr"            ,Data.equals("") ? null :Data);// 주소
					else if(k == 5) tmpMap.put("Tel"             ,Data.replace(")", "-").equals("") ? null :Data);// 전화번호
					else if(k == 6) tmpMap.put("IRTel"           ,Data.equals("") ? null :Data);// IR담당자
					else if(k == 7) tmpMap.put("CEO"             ,Data.equals("") ? null :Data);	// 대표이사
					else if(k == 8) tmpMap.put("BusiType"        ,Data.equals("") ? null :Data);// WICS업종명(소)
					else if(k == 9) tmpMap.put("MaxHolder"       ,Data.equals("") ? null :Data);// 최대주주명
					else if(k == 10)tmpMap.put("MaxHaveStockRate",Data.equals("") ? null :Data);// 최대주주보유보통주지분율
					else if(k == 11)tmpMap.put("FoundDate"       ,Data.equals("") ? null :Data);// 설립일
					else if(k == 12)tmpMap.put("PublicDate"      ,Data.equals("") ? null :Data);// 상장일
					else if(k == 13)tmpMap.put("EmpCnt"          ,Data.equals("") ? null :Data);// 종업원수
					tmpMap.put("RegPerSabun"        , baseUserLoginInfo.get("empNo"));
					list.add(tmpMap);
			}
		}//for


		//reader closing
		reader.close();
		isr.close();
		is.close();

		/*for(int a = 0; a < list.size(); a++) {
			System.out.println(a+"=="+list.get(a));
		}*/
		System.out.println("list.size()=="+list.size());

		if(list.size() > 0) {
			for(int i = 0 ; i < list.size();i++){
				companyDAO.companyInfoAddEnd(list.get(i));
			}
		}

		Map rMap = new HashMap<String, Object>();
		rMap.put("upload", 1);			//업로드 success

		//----------------------------------- 등록 :E -----------------------------------

		return rMap;
	}

	//주가정보 일괄 업로드 - CSV
	public Map uploadStockProcess(Map baseUserLoginInfo, File fNewname1) throws Exception {
		//----------------------------------- 등록 :S -----------------------------------

    	FileInputStream is = new FileInputStream(fNewname1);
		InputStreamReader isr = new InputStreamReader(is, "EUC-KR");

		CSVReader reader = new CSVReader(isr);
		List myEntries = reader.readAll();				//전체 row 읽어

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		boolean isComplete = true;
		String failMsg = "";			//실패시 전달할 메세지

		for(int m = 9; m < myEntries.size(); m++) {		//index 1(2번째 row...실제 데이터) 부터 등록해준다.
			String Data = "";
			String[] arr = (String[]) myEntries.get(m);	//한개 row
			//String data = "";
			Map<String, Object> tmpMap = new HashMap<String, Object>();
			for(int k = 0; k < arr.length; k++) {
				Data = arr[k].toString().trim();

				if(m > 12) {
					if(k == 0) tmpMap.put("ComCd"           ,Data.equals("") ? null :Data);	// 회사코드
					else if(k == 1) tmpMap.put("ComNm"           ,Data.equals("") ? null :Data);// 회사명
					tmpMap.put("RegPerSabun"        , baseUserLoginInfo.get("empNo"));
					list.add(tmpMap);
				}


			}
		}//for

		if(list.size() > 0) {
			for(int i = 0 ; i < list.size();i++){
				companyDAO.autoCateAddEnd(list.get(i));
			}
		}
		///////////////////
		Map <String,Object> paramMap = new HashMap<String, Object>();

		List<Map<String, Object>> priceList = new ArrayList<Map<String, Object>>();

		paramMap.put("SubCateCd", "2");
		List<Map<String, Object>> PriceAddList = companyDAO.getPriceAddList(paramMap);
		String PriceDate = "";

		Loop1:
		for(int i = 9; i < myEntries.size(); i++) {		//index 1(2번째 row...실제 데이터) 부터 등록해준다.
			String[] arr = (String[]) myEntries.get(i);	//한개 row
			String Data = "";
			//String data = "";
			Map<String, Object> tmpMap = new HashMap<String, Object>();

			for(int m = 0; m < arr.length; m++) {

				Data = arr[m].toString().trim();

				if(i == 9 && m == 2) PriceDate = Data.substring(0, 4) + "-" + Data.substring(4, 6) + "-" + Data.substring(6, 8);	// 날짜

				if(i > 12) {
					if     (m == 0) tmpMap.put("CateCd"           ,Data.equals("") ? null :Data);	// 회사코드
					else if(m == 2) tmpMap.put("UnitPrice"        ,Data.equals("") ? null :Data);// 시가
					else if(m == 3) tmpMap.put("PublicStock"       ,Data.equals("") ? null :Data);// 상장주식수
					else if(m == 4) tmpMap.put("StockValue"             ,Data.equals("") ? null :Data);// 시가총액
					else if(m == 5) tmpMap.put("OwnStock"              ,Data.replace(")", "-").equals("") ? null :Data);// 자기주식수
					else if(m == 6) tmpMap.put("FaceValue"            ,Data.equals("") ? null :Data);// 액면가
					tmpMap.put("PriceDate"        , PriceDate);
				}

			}

			Map<String, Object> paramTemp = new HashMap<String, Object>();
			if(i > 12) {
				for(int cnt = 0; cnt < PriceAddList.size(); cnt++) {
					if(PriceAddList.get(cnt).get("cateCd").toString().equals(tmpMap.get("CateCd"))) {
						try{
							try{
							paramTemp.put("CateCd"     , tmpMap.get("CateCd").toString());
							paramTemp.put("PriceSeq"   , PriceAddList.get(cnt).get("priceSeq").toString());
							paramTemp.put("PriceDate"  , tmpMap.get("PriceDate").toString());
							paramTemp.put("UnitPrice"  ,tmpMap.get("UnitPrice").toString());
							paramTemp.put("PublicStock",tmpMap.get("PublicStock").toString());
							paramTemp.put("StockValue" ,tmpMap.get("StockValue").toString());
							paramTemp.put("OwnStock"   ,tmpMap.get("OwnStock").toString());
							paramTemp.put("FaceValue"  ,tmpMap.get("FaceValue").toString());

							paramTemp.put("RegPerSabun", baseUserLoginInfo.get("empNo"));
							}catch(Exception e){
								continue;
							}
						}catch(Exception e){
							continue;
						}
						if(!tmpMap.get("PriceDate").toString().equals(PriceAddList.get(cnt).get("priceDate").toString())) {		// 등록일과 마지막 등록일이 다르면 무조건 등록
							priceList.add(paramTemp);
						}
						else if(!tmpMap.get("UnitPrice").toString().equals(PriceAddList.get(cnt).get("unitPrice").toString())) {	// 등록일과 마지막 등록일이 같고, 입력하는 금액과 마지막 금액이 다르면 업데이트
							paramTemp.put("PriceSeq", PriceAddList.get(cnt).get("lastPriceSeq").toString());
							priceList.add(paramTemp);
						}
						PriceAddList.remove(cnt);

					}
				}
			}
		}//for


		//reader closing
		reader.close();
		isr.close();
		is.close();

		if(PriceAddList.size() > 0) {
			companyDAO.priceAddEnd(priceList);
		}

		Map rMap = new HashMap<String, Object>();
		rMap.put("upload", 1);			//업로드 success

		//----------------------------------- 등록 :E -----------------------------------

		return rMap;
	}

	public CompanyVO selectMainCompanyList2(CompanyVO companyVO) throws Exception {
		return companyDAO.selectMainCompanyList2(companyVO);
	}
	public EgovMap selectMainCompanyList3(CompanyVO companyVO) throws Exception {
		return companyDAO.selectMainCompanyList3(companyVO);
	}
	public List<CompanyVO> selectMainCompanyList(CompanyVO companyVO) throws Exception {
		return companyDAO.selectMainCompanyList(companyVO);
	}
	public List<CompanyVO> selectNoteList2(CompanyVO companyVO) throws Exception {
		return companyDAO.selectNoteList2(companyVO);
	}

	public List<WorkVO> selectEmployeeList(WorkVO VO) throws Exception {
		return companyDAO.selectEmployeeList(VO);
	}

	public int selectNetPointListCnt(CompanyVO companyVO) throws Exception {
		return companyDAO.selectNetPointListCnt(companyVO);
	}

	public List<CompanyVO> selectNetPointList(CompanyVO companyVO) throws Exception {
		return companyDAO.selectNetPointList(companyVO);
	}

	public List<CompanyVO> selectCompanyList(CompanyVO companyVO) throws Exception {
		return companyDAO.selectCompanyList(companyVO);
	}

	public int selectCompanyListCnt(CompanyVO companyVO) throws Exception {
		return companyDAO.selectCompanyListCnt(companyVO);
	}

	public List<CompanyVO> selectMaxCpnId(CompanyVO companyVO) throws Exception {
		return companyDAO.selectMaxCpnId(companyVO);
	}

	public List<Map> selectMaxCpnIds() throws Exception {
		return companyDAO.selectMaxCpnIds();
	}

	public int insertCompany(CompanyVO companyVO) throws Exception {
		return companyDAO.insertCompany(companyVO);
	}

	public int updateCompany(CompanyVO companyVO) throws Exception {
		return companyDAO.updateCompany(companyVO);
	}

	public Integer insertNupdateCompanyExel(CpnExcelVO vo) throws Exception {
		return companyDAO.insertNupdateCompanyExel(vo);
	}
	public int updateCEO() throws Exception {
		return companyDAO.updateCEO();
	}
	public List<CompanyVO> selectDefaultCompanyList(CompanyVO companyVO) throws Exception {
		return companyDAO.selectDefaultCompanyList(companyVO);
	}

	/**
	 *
	 * @MethodName : insertCompany : psj 추가
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int insertCompany2(CompanyVO companyVO) throws Exception {
		return companyDAO.insertCompany2(companyVO);
	}

	/**
	 *
	 * @MethodName : updateCompany : psj 추가
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int updateCompany2(CompanyVO companyVO) throws Exception {
		return companyDAO.updateCompany2(companyVO);
	}

	/**
	 *
	 * @MethodName : updateCompany : psj 추가
	 * @param companyVO
	 * @return
	 * @throws Exception
	 */
	public int updateCompany3(CompanyVO companyVO) throws Exception {
		return companyDAO.updateCompany3(companyVO);
	}

	//메인화면 네트워크 리스트
	public List<EgovMap> getMainNetworkList(Map<String, Object> paramMap) throws Exception {
		return companyDAO.getMainNetworkList(paramMap);
	}
	//국가코드
	public List<Map> selectContryCodeList(Map map) throws Exception{
		return companyDAO.selectContryCodeList(map);
	}

	//회사삭제
	public String deleteCompany(Map<String,Object> paramMap) throws Exception{

		Integer deleteCompanyInfo = companyDAO.getDeleteCompanyInfo(paramMap);
		String returnStr = "SUCCESS";
		if(deleteCompanyInfo > 0){
			returnStr = "FAIL";
		}else {
			Integer cnt = companyDAO.deleteCompany(paramMap);
			String aCpnId = paramMap.get("aCpnId").toString();
			if(!aCpnId.equals("")){
				cnt = companyDAO.deleteCompanyInfo(paramMap);
			}
		}

		return returnStr;
	}
}
