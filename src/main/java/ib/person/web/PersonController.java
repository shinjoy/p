package ib.person.web;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.basic.service.CpnExcelVO;
import ib.basic.service.impl.CpnUploadExcelMapping;
import ib.cmm.IBsMessageSource;
import ib.cmm.service.CmmUseService;
import ib.cmm.service.CommonService;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.company.service.CompanyService;
import ib.company.service.CompanyVO;
import ib.person.service.PersonMgmtService;
import ib.person.service.PersonVO;
import ib.schedule.service.ScheduleService;
import ib.user.service.UserService;
import ib.work.service.WorkVO;

/**
 * <pre>
 * package  : ib.person.web
 * filename : PersonController.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 10.
 * @version :
 */
@Controller
public class PersonController {

	/** CmmUseService */
	@Resource(name="CmmUseService")
	private CmmUseService cmm;

	@Resource(name="commonService")
	private CommonService commonService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	/** MessageSource */
    @Resource(name="IBsMessageSource")
    IBsMessageSource MessageSource;

    @Resource(name="companyService")
    private CompanyService companyService;

    @Resource(name = "personMgmtService")
    private PersonMgmtService personMgmtService;

    @Resource(name = "scheService")
	private ScheduleService scheService;

    @Resource(name = "userService")
	private UserService userService;


    /** log */
    protected static final Log LOG = LogFactory.getLog(PersonController.class);

	protected static Calendar cal = Calendar.getInstance();


	/**
	 * 인물 선택하여 보여지는 내용화면
	 *
	 * @MethodName : main
	 * @param personVO
	 * @param companyVO
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/main.do")
	public String main(@ModelAttribute("personVO") PersonVO personVO,
			CompanyVO companyVO,
			WorkVO workVO,
			HttpSession session,
			HttpServletRequest req,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		model.addAttribute("popUp", personVO.getPopUp());
		model.addAttribute("tabType", personVO.getTabType());

        Map cmmCdProgressCdListCodeMap = new HashMap();
        cmmCdProgressCdListCodeMap.put("codeSetNm", workVO.ccdPrgressCd);
        cmmCdProgressCdListCodeMap.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
        model.addAttribute("cmmCdProgressCdList", commonService.getBaseCommonCode(cmmCdProgressCdListCodeMap));

        Map cmmCdNetCodeMap = new HashMap();
        cmmCdNetCodeMap.put("codeSetNm", "CUSTOMER_TYPE");
        cmmCdNetCodeMap.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
        model.addAttribute("cmmCdNet", commonService.getBaseCommonCode(cmmCdNetCodeMap));

        int firstRecordIndex = 0
        	,pageSize = 7;

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(firstRecordIndex);//현재 페이지 번호
        paginationInfo.setPageSize(pageSize);//페이징 리스트의 사이즈

        companyVO.setFirstIndex(firstRecordIndex);
        companyVO.setRecordCountPerPage(5);//한 페이지에 게시되는 게시물 건수
        workVO.setFirstIndex(firstRecordIndex);
        workVO.setRecordCountPerPage(10);//한 페이지에 게시되는 게시물 건수
        personVO.setFirstIndex(firstRecordIndex);
        personVO.setRecordCountPerPage(10);//한 페이지에 게시되는 게시물 건수

		List<PersonVO> result = null;
		List<CompanyVO> synergyStaff = null;
		PersonVO resultPersonVO = new PersonVO();

		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		result = personMgmtService.selectMainPersonList(personVO);

		if(result.size() == 1) {
			resultPersonVO = result.get(0);
		}

		companyVO.setCstSnb(resultPersonVO.getsNb());
		personVO.setCstSnb(resultPersonVO.getsNb());
		workVO.setCstId(resultPersonVO.getsNb());

		if(companyVO.getCstSnb()!=null && !companyVO.getCstSnb().equals("")){

			companyVO.setOrgId(baseUserLoginInfo.get("applyOrgId").toString());
			//인물네트워크
			model.addAttribute("netList", companyService.selectNetPointList(companyVO));
			//현재 페이지
		    //Integer pageIndex = companyVO.getPageIndex();
			paginationInfo.setCurrentPageNo(companyVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(companyVO.getRecordCountPerPage());
			paginationInfo.setTotalRecordCount(companyService.selectNetPointListCnt(companyVO)); //전체 게시물 건 수
			model.addAttribute("paginationInfo", paginationInfo);

			//추천네트워크
			PaginationInfo paginationInfo2 = new PaginationInfo();

			//현재 페이지
	        paginationInfo2.setCurrentPageNo(1);//현재 페이지 번호

	        Integer recordCountPerPage = 10;
	        paginationInfo2.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
	        paginationInfo2.setPageSize(10);//페이징 리스트의 사이즈

	        int firstRecordIndex2 = paginationInfo2.getFirstRecordIndex();
	        personVO.setFirstIndex(firstRecordIndex2);
			personVO.setRecordCountPerPage(recordCountPerPage);
			personVO.setsNb(personVO.getCstSnb());

			//고객이력
			model.addAttribute("customerCareerList", personMgmtService.selectCustomerCareerList(personVO));

			//고객학력
			model.addAttribute("customerSchoolList", personMgmtService.selectCustomerSchoolList(personVO));

			//최근미팅이력
			Map<String,Object> scheMap = new HashMap();
			scheMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
			scheMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
			scheMap.put("userId", baseUserLoginInfo.get("userId").toString());
			scheMap.put("customerId",companyVO.getCstSnb());

			model.addAttribute("meetList",scheService.getCustomerMeetList(scheMap));  //최근미팅이력
		}

		model.addAttribute("cst", resultPersonVO);

		//List<Map> orgIdList = userService.getOrgIdList("");  //전체 관계사 리스트
		List<Map> orgIdList = personMgmtService.getOrgIdListForCustomer(personVO);  //전체 관계사 리스트
		model.addAttribute("orgIdList", orgIdList);

		return "person/PersonMain/pop";			//상세화면
    }

	/**
	 * 인물네트워크 Ajax 호출
	 *
	 * @MethodName : main
	 * @param personVO
	 * @param companyVO
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/getNetListAjax.do")
	public String getNetListAjax(@ModelAttribute("personVO") PersonVO personVO,
			CompanyVO companyVO,
			WorkVO workVO,
			HttpSession session,
			HttpServletRequest req,
			ModelMap model) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		int firstRecordIndex = 0
		        	,pageSize = 7;

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(firstRecordIndex);//현재 페이지 번호
		paginationInfo.setPageSize(pageSize);//페이징 리스트의 사이즈
		paginationInfo.setRecordCountPerPage(5);
		workVO.setFirstIndex(firstRecordIndex);
		workVO.setRecordCountPerPage(10);//한 페이지에 게시되는 게시물 건수
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(10);//한 페이지에 게시되는 게시물 건수

		List<PersonVO> result = null;
		List<CompanyVO> synergyStaff = null;
		PersonVO resultPersonVO = new PersonVO();

		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		result = personMgmtService.selectMainPersonList(personVO);

		if(result.size() == 1) {
			resultPersonVO = result.get(0);
		}

		companyVO.setCstSnb(resultPersonVO.getsNb());
		personVO.setCstSnb(resultPersonVO.getsNb());
		workVO.setCstId(resultPersonVO.getsNb());

		resultPersonVO.setSortCol(companyVO.getSortCol());
		resultPersonVO.setSortAD(companyVO.getSortAD());

		model.addAttribute("cst", resultPersonVO);

		paginationInfo.setCurrentPageNo(companyVO.getPageIndex());
		companyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		companyVO.setRecordCountPerPage(5);//한 페이지에 게시되는 게시물 건수
		paginationInfo.setTotalRecordCount(companyService.selectNetPointListCnt(companyVO)); //전체 게시물 건 수

		companyVO.setOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		//인물네트워크
		model.addAttribute("netList", companyService.selectNetPointList(companyVO));
		model.addAttribute("paginationInfo", paginationInfo);

		return "person/include/PersonMain_content1_INC/inc";			//인물네트워크
    }

	/**
	 * 추천네트워크 Ajax 호출
	 *
	 * @MethodName : main
	 * @param personVO
	 * @param companyVO
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/getNetworkListAjax.do")
	public String getNetworkListAjax(@ModelAttribute("personVO") PersonVO personVO,
			CompanyVO companyVO,
			WorkVO workVO,
			HttpSession session,
			HttpServletRequest req,
			ModelMap model) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		int firstRecordIndex = 0
	        	,pageSize = 7;

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(firstRecordIndex);//현재 페이지 번호
		paginationInfo.setPageSize(pageSize);//페이징 리스트의 사이즈

		companyVO.setFirstIndex(firstRecordIndex);
		companyVO.setRecordCountPerPage(5);//한 페이지에 게시되는 게시물 건수
		workVO.setFirstIndex(firstRecordIndex);
		workVO.setRecordCountPerPage(10);//한 페이지에 게시되는 게시물 건수
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(10);//한 페이지에 게시되는 게시물 건수

		List<PersonVO> result = null;
		List<CompanyVO> synergyStaff = null;
		PersonVO resultPersonVO = new PersonVO();

		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		result = personMgmtService.selectMainPersonList(personVO);

		if(result.size() == 1) {
			resultPersonVO = result.get(0);
		}


		companyVO.setCstSnb(resultPersonVO.getsNb());
		personVO.setCstSnb(resultPersonVO.getsNb());
		workVO.setCstId(resultPersonVO.getsNb());

		model.addAttribute("cst", resultPersonVO);

		//추천네트워크
        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호

        Integer recordCountPerPage = 10;
        paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

        int firstRecordIndex2 = paginationInfo.getFirstRecordIndex();
        personVO.setFirstIndex(firstRecordIndex2);
		personVO.setRecordCountPerPage(recordCountPerPage);

		personVO.setOrgId(baseUserLoginInfo.get("orgId").toString());

		personVO.setOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		if(personVO.getSearchOrgId()==null)
			personVO.setSearchOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		personVO.setChkPerson("Y");
		model.addAttribute("networkList", personMgmtService.selectNetworkList(personVO,paginationInfo));
		model.addAttribute("paginationInfo2", paginationInfo);

		List<Map> orgIdList = userService.getOrgIdList("");  //전체 관계사 리스트
		model.addAttribute("orgIdList", orgIdList);

		return "person/include/PersonMain_content2_INC/inc";			//인물네트워크

    }

	/**
	 * ajax 인물검색
	 * @MethodName : ajaxSearchName
	 * @param personVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : user
	 * @since : 2015. 2. 6.
	 */
	@RequestMapping(value="/person/ajaxSearchName.do")
	public String ajaxSearchName(@ModelAttribute("personVO") PersonVO personVO,
			HttpSession session,
			ModelMap model) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
//		if(Integer.parseInt(loginUser.getPermission())<11) return "redirect:/";
		LOG.info(baseUserLoginInfo.get("loginId").toString()+"^_^"+personVO.getCstNm());
		int totCnt = 0;
		List<PersonVO> result = null;
		Map<String, Object> map = new HashMap<String, Object>();

        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", personVO.getCstNm());
        model.addAttribute("sortTitle", personVO.getSort_t());

		int pasingListSize = 4;
        /*if(9<personVO.getPageIndex()){
        	pasingListSize = 6;
        	if(96<personVO.getPageIndex()) pasingListSize = 4;
        }*/

        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(12);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(pasingListSize);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);
		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		try{
			result = personMgmtService.selectPersonList(personVO);
			totCnt = personMgmtService.selectPersonListCnt(personVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		map.put("resultList", result);
		model.addAttribute("cstList", map.get("resultList"));

		paginationInfo.setTotalRecordCount(totCnt); //전체 게시물 건 수
		model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", MessageSource.getMessage("success.common.select"));

		//System.out.println("===========/searchName:"+personVO.getCstNm()+"==============");

		return "includeJSP/CstLeft";
    }

	/**
	 * 고객 정보 수정 화면
	 * @MethodName : modifyCst
	 * @param request
	 * @param personVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/person/modifyCst.do")
	public String modifyCst(HttpServletRequest request,
			PersonVO personVO,
			HttpSession session,
			ModelMap model, @RequestParam Map<String,Object> map){

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
//		if(Integer.parseInt(loginUser.getPermission())<11) return "redirect:/";
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		map.put("rgId", baseUserLoginInfo.get("loginId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("staffSnb", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());

		PersonVO rtnPersonVO = null;
		List<Map> contryCodeList = null;
		//model.addAttribute("choosePopMain", "modifyCstPopUp");
		personVO.setRgId(baseUserLoginInfo.get("loginId").toString());
		personVO.setCstId(personVO.getsNb());
		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		try{
			rtnPersonVO = personMgmtService.getCustomer(personVO);
			//고객이력
			model.addAttribute("customerCareerList", personMgmtService.selectCustomerCareerList(personVO));
			//고객학력
			model.addAttribute("customerSchoolList", personMgmtService.selectCustomerSchoolList(personVO));

			contryCodeList = companyService.selectContryCodeList(map);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		model.addAttribute("contryCodeList", contryCodeList);
		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
		model.addAttribute("cst", rtnPersonVO);
		model.addAttribute("actionType", "UPDATE");

		return "person/regCstPopup/pop";
	}
	/**
	 * 고객정보 수정하기
	 * @MethodName : updateCst
	 * @param personVO
	 * @param workVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/person/updateCst.do")
	public void updateCst(@ModelAttribute("personVO") PersonVO personVO,
			HttpSession session,HttpServletResponse response,
			ModelMap model, @RequestParam Map<String,Object> map) throws Exception {

		//if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
//		if(Integer.parseInt(loginUser.getPermission())<11) return "redirect:/";
		LOG.info(baseUserLoginInfo.get("loginId").toString());
		personVO.setRgId(baseUserLoginInfo.get("loginId").toString());
		personVO.setOrgId(baseUserLoginInfo.get("orgId").toString());

		personVO.setCstId(personVO.getsNb());

		map.put("rgId", baseUserLoginInfo.get("loginId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("staffSnb", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("orgNm", baseUserLoginInfo.get("orgNm").toString());

		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		int cnt = 0;
		try{
			cnt = personMgmtService.updateCustomerByIbSystem(personVO,map);

		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		model.addAttribute("updateCnt", cnt);

		Map obj = new HashMap();

		AjaxResponse.responseAjaxObject(response, obj);			//결과전송
	}

	/**
	 * 실질적으로 IMPORT 하는 메소드
	 * @param fileName 불러읽어들일 파일이름
	 */
	protected static String fileName = "";
	protected int sheetNo = 0;
	public boolean run(String realFileName, String fileUrl, String stuff,Map baseUserLoginInfo)  throws Exception{
		FileInputStream myxls = null;
		File fileName = new File(fileUrl);
		List<PersonVO> result = null;
		PersonVO prsn = new PersonVO();
		boolean rtn = false;

		try {
			//System.out.println("Process start : read excel file " + FilenameUtils.getExtension(realFileName));
			myxls = new FileInputStream(fileName);
			Workbook wb = null;

			if("xlsx".equals(FilenameUtils.getExtension(realFileName))){
				wb = new XSSFWorkbook(myxls);
			} else {
//				POIFSFileSystem fileSystem = new POIFSFileSystem(myxls);
				wb = new HSSFWorkbook(myxls);
			}
			Sheet sheet = wb.getSheetAt(sheetNo);

			CpnUploadExcelMapping xcel = new CpnUploadExcelMapping();

			int rowNo = 0;
			Row row = null;
			//System.out.println("row num : "+sheet.getLastRowNum());
			while (rowNo++ < sheet.getLastRowNum()) {
				row = sheet.getRow(rowNo);
				CpnExcelVO vo = (CpnExcelVO) xcel.mappingColumn(row, stuff);

				vo.setRgId(baseUserLoginInfo.get("loginId").toString());
				vo.setOrgId(baseUserLoginInfo.get("orgId").toString());

				@SuppressWarnings("unused")
				int cnt = 0;

				if("cst".equals(stuff)){
					//인물이름과 회사이름으로 중복된 사람을 찾는다.
					if(personMgmtService.selectSearchDuplicateB4excelInsert(vo)>0) continue;

					if(vo.getEmail()==null||vo.getEmail().equals(""))vo.setEmail("-");
					if(vo.getPhn1()==null||vo.getPhn1().equals(""))vo.setPhn1("-");
					if(vo.getPhn2()==null||vo.getPhn2().equals(""))vo.setPhn2("-");
					if(vo.getNote()==null||vo.getNote().equals(""))vo.setNote("");
					// Calendar cal = Calendar.getInstance();
					cal.setTime( new Date(System.currentTimeMillis()) );
					String date = new SimpleDateFormat("yyyyMMdd").format( cal.getTime() );
					if(vo.getRgDt()==null||vo.getRgDt().equals(""))vo.setRgDt(date);
					cnt = personMgmtService.excelInsertCustomer(vo);//customer 입력
					LOG.debug("^_^personMgmtService.excelInsertCustomer");
					result = personMgmtService.selectMaxSnb(prsn);//입력된 customer snb 추출
					vo.setCstSnb(result.get(0).getsNb());
					if(vo.getNote().length() < 90) vo.setTitle(vo.getNote());
					else{
						String[] string;
						String[] sentance = {"소개","친구","방문","미팅","탐방","동기","포럼","담당","bw","/","\\n"};

						for(int i=0;i<sentance.length;i++){
							if(vo.getNote().matches(".*"+sentance[i]+".*")){
								string = vo.getNote().split(sentance[i]);
								if(i>sentance.length-3)vo.setTitle(string[0]);// sentance 배열의 / 와 \n 일 경우
								else vo.setTitle(string[0]+sentance[i]);
							}
							if(i == sentance.length-1){
								vo.setTitle(vo.getNote().substring(0,10)+"..");
							}
						}

						/*if(vo.getNote().matches(".*\\n.*")){
							string = vo.getNote().split("\\n");
							vo.setTitle(string[0]);
						}else if(vo.getNote().matches(".*소개.*")){
							string = vo.getNote().split("소개");
							vo.setTitle(string[0]+"소개");
						}else if(vo.getNote().matches(".*친구.*")){
							string = vo.getNote().split("친구");
							vo.setTitle(string[0]+"친구");
						}else if(vo.getNote().matches(".*방문.*")){
							string = vo.getNote().split("방문");
							vo.setTitle(string[0]+"방문");
						}else if(vo.getNote().matches(".*미팅.*")){
							string = vo.getNote().split("미팅");
							vo.setTitle(string[0]+"미팅");
						}else if(vo.getNote().matches(".*탐방.*")){
							string = vo.getNote().split("탐방");
							vo.setTitle(string[0]+"탐방");
						}else if(vo.getNote().matches(".*동기.*")){
							string = vo.getNote().split("동기");
							vo.setTitle(string[0]+"동기");
						}else if(vo.getNote().matches(".*포럼.*")){
							string = vo.getNote().split("포럼");
							vo.setTitle(string[0]+"포럼");
						}else if(vo.getNote().matches(".*담당.*")){
							string = vo.getNote().split("담당");
							vo.setTitle(string[0]+"담당");
						}else if(vo.getNote().matches(".*bw.*")){
							string = vo.getNote().split("bw");
							vo.setTitle(string[0]+"bw");
						}else{
							vo.setTitle(vo.getNote().substring(0,10)+"..");
						}*/
					}
					if(!vo.getNote().equals("") && vo.getNote()!=null){
						cnt = personMgmtService.excelInsertNote(vo);//노트(비고)입력
						LOG.debug("^_^personMgmtService.excelInsertNote");
					}
				}

//				if (!processRow(row)) break;

			}
			//System.out.println("Process succeed : commit");
			rtn = true;
		} catch (Exception e) {
			LOG.error(e);
			//System.out.println("Process error  : rollback");
			throw new RuntimeException(e);
		} finally {
			//System.out.println("Process end : close");
			if (myxls != null) {
				try {
					myxls.close();
				} catch (Exception e) {
					LOG.error(e);
				}
			}
		}
		return rtn;
	}


	/**
	 * 담당자 지정 등록 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 2. 19.
	 */
	@RequestMapping(value = "/stockFirmManage/doSaveCstManager.do")
	public void doSaveCstManager(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
//		if(Integer.parseInt(loginUser.getPermission())<11) return "redirect:/";
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		/*
		cstList : cstSnbList,	//고객 id list (sequence list)
		usrId	: usrId			//담당자 id (로긴id)
		*/

		List list = null;
		String[] cstIdArry = map.get("cstList").toString().split(",");
		list = new ArrayList<String>(Arrays.asList(cstIdArry));

		list.remove(0);		//첫번째는 값이 없으므로 제거

		map.put("cstArrayList", list);
		map.put("userSeq", baseUserLoginInfo.get("userId").toString());
		map.put("cusId", baseUserLoginInfo.get("cusId").toString());
		map.put("memo", "신규 담당자 지정");
		map.put("lvCd", "00001");
		String orgId = baseUserLoginInfo.get("orgId").toString();

		map.put("orgId", orgId);

		int upCnt = 0;

		upCnt = personMgmtService.doSaveCstManager(map);

		AjaxResponse.responseAjaxSave(response, upCnt);		//결과전송

	}

	/**
	 * 인물 페이지 네트워크 추가하기
	 * @MethodName : insertNetworkCst
	 * @param request
	 * @param personVO
	 * @param loginVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/person/insertNetwork.do")
	public void insertNetworkCst(HttpServletRequest request,HttpServletResponse response,	HttpSession session,
			PersonVO personVO, ModelMap model) throws Exception {
		//if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		personVO.setRgId(baseUserLoginInfo.get("loginId").toString());
		personVO.setOrgId(baseUserLoginInfo.get("orgId").toString());
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		int cnt = 0;
		try{
			cnt = personMgmtService.insertNetworkCst(personVO);
			LOG.debug(baseUserLoginInfo.get("loginId").toString()+"^_^personMgmtService.insertNetworkCst");
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("saveCnt", cnt);

		AjaxResponse.responseAjaxSave(response, cnt);			//결과전송
	}

	/**
	 * 인물 이력/정보, 네트워크, 딜경력 삭제
	 * @MethodName : deleteNetwork
	 * @param personVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/deleteNetwork.do")
	public void deleteNetwork(
			@ModelAttribute("personVO") PersonVO personVO, ModelMap model,
			HttpServletRequest request,	HttpServletResponse response, HttpSession session) throws Exception {

		//if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
//		if(Integer.parseInt(loginUser.getPermission())<11) return "redirect:/";
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		int cnt = 0;
		try{
			cnt = personMgmtService.deletePersonNetInfo(personVO);
			LOG.debug(baseUserLoginInfo.get("loginId").toString()+"^_^personMgmtService.deletePersonNetInfo");
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		AjaxResponse.responseAjaxSave(response, cnt);			//결과전송
	}

	/**
	 *
	 * @MethodName : modifyNetPoint
	 * @param personVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/modifyNetPoint.do")
	public void modifyNetPoint(	@ModelAttribute("personVO") PersonVO personVO,
			HttpServletRequest request,	HttpServletResponse response, HttpSession session,
			ModelMap model) throws Exception {

		//if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
//		if(Integer.parseInt(loginUser.getPermission())<11) return "redirect:/";
		LOG.info(baseUserLoginInfo.get("loginId").toString());
		personVO.setRgId(baseUserLoginInfo.get("loginId").toString());
		personVO.setOrgId(baseUserLoginInfo.get("orgId").toString());

		int cnt = 0;
		try{
			cnt = personMgmtService.modifyNetPoint(personVO);
			LOG.debug(baseUserLoginInfo.get("loginId").toString()+"^_^personMgmtService.modifyNetPoint^_^"+personVO.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		AjaxResponse.responseAjaxSave(response, cnt);			//결과전송
	}

	/**
	 * 네트워크 추가 위해서 사람 선택 팝업
	 * @MethodName : popUpCst
	 * @param request
	 * @param personVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/customerListPopup.do")
	public String getCustomerListPopup(HttpServletRequest request,
			@ModelAttribute("personVO") PersonVO personVO,
			HttpSession session,
			@RequestParam(value= "type",required=false) String type,
			ModelMap model) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		LOG.info(personVO.getRgId());
		model.addAttribute("searchCstNm", personVO.getSearchCstNm());
		model.addAttribute("TempName", personVO.getTempName());
		model.addAttribute("TempSnb", personVO.getTempSnb());
		model.addAttribute("sortTitle", personVO.getSort_t());
		model.addAttribute("MDf", personVO.getModalFlag());
		model.addAttribute("MDn", personVO.getModalNum());

		//park 추가
		model.addAttribute("cpnId", personVO.getCpnId());

		int totCnt = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		List<PersonVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        LOG.info(personVO.getRgId()+"^_^"+personVO.getCpnNm());

        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);
		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		try{
			result = personMgmtService.selectPersonList(personVO);
			totCnt = personMgmtService.selectPersonListCnt(personVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		map.put("resultList", result);
		model.addAttribute("cstList", map.get("resultList"));


		paginationInfo.setTotalRecordCount(totCnt); //전체 게시물 건 수
		model.addAttribute("paginationInfo", paginationInfo);

		if(type!=null)
        	model.addAttribute("type", type);

		return "person/customerListPopup/pop";
	}

	/**
	 * 네트워크 추가 위해서 사람 선택 팝업
	 * @MethodName : popUpCst
	 * @param request
	 * @param personVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/customerListPopupAjax.do")
	public String getCustomerListPopupAjax(HttpServletRequest request,
			PersonVO personVO,
			HttpSession session,
			ModelMap model) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		LOG.info(personVO.getRgId());
		model.addAttribute("searchCstNm", personVO.getSearchCstNm());
		model.addAttribute("TempName", personVO.getTempName());
		model.addAttribute("TempSnb", personVO.getTempSnb());
		model.addAttribute("sortTitle", personVO.getSort_t());
		model.addAttribute("MDf", personVO.getModalFlag());
		model.addAttribute("MDn", personVO.getModalNum());

		//park 추가
		model.addAttribute("cpnId", personVO.getCpnId());

		int totCnt = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		List<PersonVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        LOG.info(personVO.getRgId()+"^_^"+personVO.getCpnNm());

        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);
		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		try{
			result = personMgmtService.selectPersonList(personVO);
			totCnt = personMgmtService.selectPersonListCnt(personVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		map.put("resultList", result);
		model.addAttribute("cstList", map.get("resultList"));

		paginationInfo.setTotalRecordCount(totCnt); //전체 게시물 건 수
		model.addAttribute("paginationInfo", paginationInfo);

		return "person/include/customerListPopup_INC/inc";
	}

	/**
	 * 관계사의 담당자 조회
	 * @MethodName : getOtherOrgStaff
	 * @param session
	 * @param response
	 * @param model
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/person/getOtherOrgStaff.do")
	public void getOtherOrgStaff(
			HttpSession session,HttpServletResponse response,
			ModelMap model, @RequestParam Map<String,Object> map) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map<String,Object> obj = new HashMap<String,Object>();

		EgovMap staffInfo = personMgmtService.getOtherOrgStaff(map);

		if(staffInfo != null) obj.put("result", "SUCCESS");
		else obj.put("result", "FAIL");
		obj.put("staffInfo", staffInfo);
		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	////////////////////////////////////////////////////////
	/**
	 * 고객중복체크 팝업
	 * @MethodName : popUpCst
	 * @param request
	 * @param personVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/customerDupChkPopup.do")
	public String customerDupChkPopup(HttpServletRequest request,
			@ModelAttribute("personVO") PersonVO personVO,
			HttpSession session,
			@RequestParam(value= "type",required=false) String type,
			ModelMap model) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		LOG.info(personVO.getRgId());
		model.addAttribute("searchCstNm", personVO.getSearchCstNm());
		model.addAttribute("TempName", personVO.getTempName());
		model.addAttribute("TempSnb", personVO.getTempSnb());
		model.addAttribute("sortTitle", personVO.getSort_t());
		model.addAttribute("MDf", personVO.getModalFlag());
		model.addAttribute("MDn", personVO.getModalNum());

		//park 추가
		model.addAttribute("cpnId", personVO.getCpnId());

		int totCnt = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		List<PersonVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        LOG.info(personVO.getRgId()+"^_^"+personVO.getCpnNm());

        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(10);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);
		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		try{
			result = personMgmtService.selectPersonList(personVO);
			totCnt = personMgmtService.selectPersonListCnt(personVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		map.put("resultList", result);
		model.addAttribute("cstList", map.get("resultList"));


		paginationInfo.setTotalRecordCount(totCnt); //전체 게시물 건 수
		model.addAttribute("paginationInfo", paginationInfo);

		if(type!=null)
        	model.addAttribute("type", type);

		return "person/customerDupChkPopup/pop";
	}

	/**
	 * 고객중복체크 팝업 조회
	 * @MethodName : popUpCst
	 * @param request
	 * @param personVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/customerDupChkPopupAjax.do")
	public String customerDupChkPopupAjax(HttpServletRequest request,
			PersonVO personVO,
			HttpSession session,
			ModelMap model) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		LOG.info(personVO.getRgId());
		model.addAttribute("searchCstNm", personVO.getSearchCstNm());
		model.addAttribute("TempName", personVO.getTempName());
		model.addAttribute("TempSnb", personVO.getTempSnb());
		model.addAttribute("sortTitle", personVO.getSort_t());
		model.addAttribute("MDf", personVO.getModalFlag());
		model.addAttribute("MDn", personVO.getModalNum());

		//park 추가
		model.addAttribute("cpnId", personVO.getCpnId());

		int totCnt = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		List<PersonVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        LOG.info(personVO.getRgId()+"^_^"+personVO.getCpnNm());

        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(10);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);
		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());

		try{
			result = personMgmtService.selectPersonList(personVO);
			totCnt = personMgmtService.selectPersonListCnt(personVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		map.put("resultList", result);
		model.addAttribute("cstList", map.get("resultList"));

		paginationInfo.setTotalRecordCount(totCnt); //전체 게시물 건 수
		model.addAttribute("paginationInfo", paginationInfo);

		return "person/include/customerDupChkPopup_INC/inc";
	}

	/**
	 * 인물 삭제  : psj 추가
	 * @MethodName : popUpCpn
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/person/deleteCustomer.do")
	public void deleteCustomer(HttpServletRequest request,
							HttpSession session,
							HttpServletResponse response,
							@RequestParam Map<String,Object> map,
							Model model) throws Exception{
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("userId", baseUserLoginInfo.get("userId"));

		String result = personMgmtService.deleteCustomer(map);

		Map<String,Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result",result);

		AjaxResponse.responseAjaxObject(response, resultMap);
	}
}