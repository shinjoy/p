package ib.company.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
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
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.basic.service.CpnExcelVO;
import ib.basic.service.impl.CpnUploadExcelMapping;
import ib.cmm.IBsMessageSource;
import ib.cmm.service.CmmUseService;
import ib.cmm.service.CommonService;
import ib.cmm.util.fcc.service.StringUtil;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.company.service.CompanyService;
import ib.company.service.CompanyVO;
import ib.notice.service.NoticeVO;
import ib.person.service.PersonMgmtService;
import ib.person.service.PersonVO;
import ib.recommend.service.RecommendVO;
import ib.schedule.service.Utill;
import ib.user.service.UserService;
import ib.work.service.WorkService;
import ib.work.service.WorkVO;


@Controller
public class CompanyController {

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

    @Resource(name = "companyService")
    protected CompanyService companyService;

    @Resource(name = "workService")
    private WorkService workService;

    @Resource(name = "personMgmtService")
    private PersonMgmtService personMgmtService;

    @Resource(name = "userService")
	private UserService userService;

	/** log */
    protected static final Log LOG = LogFactory.getLog(CompanyController.class);

	/**
	 * Main 화면으로 들어간다
	 * @MethodName : index
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/company/index.do")
	public String index(@ModelAttribute("companyVO") CompanyVO companyVO,
			HttpServletRequest request,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		int totCnt = 0;
		List<CompanyVO> result = null;

		//System.out.println("===========/searchName:"+companyVO.getCpnNm()+"==============");
		model.addAttribute("searchName", companyVO.getCpnNm());

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(12);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈
        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		companyVO.setFirstIndex(firstRecordIndex);
		companyVO.setRecordCountPerPage(recordCountPerPage);

		result = companyService.selectCompanyList(companyVO);
		totCnt = companyService.selectCompanyListCnt(companyVO);

		model.addAttribute("companyListLeft", result);

        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", MessageSource.getMessage("success.common.select"));

    	return "company/companyList";
    }

	/**
	 *
	 * @MethodName : main
	 * @param companyVO
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/main.do")
	public String main(@ModelAttribute("companyVO") CompanyVO companyVO,
			HttpServletRequest request,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		//회사 디테일 : S
		CompanyVO result = null;
		result = companyService.selectMainCompanyList2(companyVO);
		model.addAttribute("companyDetail", result);
		//회사 디테일 : E

    	return "company/pop/companyView/pop";
    }

	/**
	 *
	 * @MethodName : searchName
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/searchName.do")
	public String searchName(@ModelAttribute("companyVO") CompanyVO companyVO,
			HttpSession session,
			ModelMap model) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		int totCnt = 0;
		List<CompanyVO> result = null;

		//System.out.println("===========/searchName:"+companyVO.getCpnNm()+"==============");
        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(12);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		companyVO.setFirstIndex(firstRecordIndex);
		companyVO.setRecordCountPerPage(recordCountPerPage);

		result = companyService.selectCompanyList(companyVO);
		totCnt = companyService.selectCompanyListCnt(companyVO);

		model.addAttribute("companyListLeft", result);

        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", MessageSource.getMessage("success.common.select"));

		return "company/include/companyList_INC/inc";
    }
	/**
	 * ajax 실시간 검색
	 * @MethodName : ajaxSearchName
	 * @param companyVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : user
	 * @since : 2015. 2. 6.
	 */
	@RequestMapping(value="/company/ajaxSearchName.do")
	public String ajaxSearchName(@ModelAttribute("companyVO") CompanyVO companyVO,
			HttpSession session,
			ModelMap model) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String searchName = companyVO.getCpnNm();
		LOG.info(baseUserLoginInfo.get("loginId").toString()+"^_^"+searchName);


		int totCnt = 0;
		List<CompanyVO> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		model.addAttribute("searchName", searchName);

		int pagingListSize = 4;
		/*if(9<companyVO.getPageIndex()){
        	pagingListSize = 5;
        	if(96<companyVO.getPageIndex()) pasingListSize = 3;
        }*/

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
		paginationInfo.setRecordCountPerPage(12);//한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(pagingListSize);//페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		companyVO.setFirstIndex(firstRecordIndex);
		companyVO.setRecordCountPerPage(recordCountPerPage);

		result = companyService.selectCompanyList(companyVO);
		totCnt = companyService.selectCompanyListCnt(companyVO);

		map.put("resultList", result);
		model.addAttribute("companyListLeft", map.get("resultList"));

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("message", MessageSource.getMessage("success.common.select"));

		//System.out.println("===========/searchName:"+companyVO.getCpnNm()+"==============");

		return "company/include/CpnLeft";
	}

	/**
	 * 회사 등록화면 : 관계사 수정 : psj
	 * @MethodName : rgstCpn
	 * @param companyVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/company/rgstCpn.do")
	public String rgstCpn(@ModelAttribute("companyVO") CompanyVO companyVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		//System.out.println("===========등록할 회사이름:"+companyVO.getSearchCpnNm()+"==============");
		//List<CompanyVO> result = null;
		List<Map> result = null;

		//result = companyService.selectMaxCpnId(companyVO);
		result = companyService.selectMaxCpnIds();

		if(companyVO.getCpnId()!=null && !companyVO.getCpnId().equals("")){
			//회사 디테일 : S
			CompanyVO detailVo = null;
			detailVo = companyService.selectMainCompanyList2(companyVO);

			model.addAttribute("companyDetail", detailVo);
			//회사 디테일 : E
		}

		List<Map> contryCodeList = companyService.selectContryCodeList(baseUserLoginInfo);

		model.addAttribute("contryCodeList", contryCodeList);
		//model.addAttribute("maxCpnId", result.get(0).getCpnId());
		model.addAttribute("maxSeq", result.get(0).get("seq"));
		model.addAttribute("maxASeq", result.get(0).get("aSeq"));
		model.addAttribute("maxAFSeq", result.get(0).get("aFSeq"));

		model.addAttribute("cpnNm", companyVO.getSearchCpnNm());
		model.addAttribute("openPage", companyVO.getOpenPage());
		model.addAttribute("workCpnNm", companyVO.getWorkCpnNm());


		return "company/pop/companyRegist/pop";
	}
	/**
	 * 회사 찾기 팝업 : psj 추가
	 * @MethodName : popUpCpn
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/popUpCpn.do")
	public String popUpCpn(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			@RequestParam(value= "type",required=false) String type,
			ModelMap model) throws Exception{


		int totCnt = 0;
		List<CompanyVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", workVO.getCpnNm());
        //if(workVO.getCpnNm()!=null && !workVO.getCpnNm().equals("")){

	        //System.out.println(companyVO.getPageIndex());

	        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
	        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
			int recordCountPerPage = paginationInfo.getRecordCountPerPage();
			companyVO.setFirstIndex(firstRecordIndex);
			companyVO.setRecordCountPerPage(recordCountPerPage);

			try{
				result = companyService.selectCompanyList(companyVO);
				totCnt = companyService.selectCompanyListCnt(companyVO);
			}catch(Exception e){
				LOG.error(e);
				e.printStackTrace();
			}
			model.addAttribute("companyList", result);

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);

	        if(type!=null)
	        	model.addAttribute("type", type);
        //}
		return "company/pop/popSearchCom/pop";
	}

	/**
	 * 회사 찾기 팝업 : psj 추가
	 * @MethodName : popUpCpn
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/popUpCpn2.do")
	public String popUpCpn2(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			@RequestParam(value= "type",required=false) String type,
			ModelMap model) throws Exception{


		int totCnt = 0;
		List<CompanyVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", workVO.getCpnNm());
        //if(workVO.getCpnNm()!=null && !workVO.getCpnNm().equals("")){

	        //System.out.println(companyVO.getPageIndex());

	        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
	        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
			int recordCountPerPage = paginationInfo.getRecordCountPerPage();
			companyVO.setFirstIndex(firstRecordIndex);
			companyVO.setRecordCountPerPage(recordCountPerPage);

			try{
				result = companyService.selectCompanyList(companyVO);
				totCnt = companyService.selectCompanyListCnt(companyVO);
			}catch(Exception e){
				LOG.error(e);
				e.printStackTrace();
			}
			model.addAttribute("companyList", result);

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);

	        if(type!=null)
	        	model.addAttribute("type", type);
        //}
		return "company/pop/popSearchCom2/pop";
	}
	/**
	 * 회사 찾기 팝업 검색 ajax : psj 추가
	 * @MethodName : searchCpnAjax
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/searchCpnAjax.do")
	public String searchCpnAjax(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			ModelMap model) throws Exception{
		int totCnt = 0;
		List<CompanyVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", workVO.getCpnNm());
        /*if(workVO.getCpnNm()!=null && !workVO.getCpnNm().equals("")){*/

	        //System.out.println(companyVO.getPageIndex());

	        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
	        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
			int recordCountPerPage = paginationInfo.getRecordCountPerPage();
			companyVO.setFirstIndex(firstRecordIndex);
			companyVO.setRecordCountPerPage(recordCountPerPage);

			try{
				result = companyService.selectCompanyList(companyVO);
				totCnt = companyService.selectCompanyListCnt(companyVO);
			}catch(Exception e){
				LOG.error(e);
				e.printStackTrace();
			}
			model.addAttribute("companyList", result);

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);
        //}
		return "company/include/popSearchCom_INC/inc";
	}
	/**
	 * 회사 찾기 팝업 검색 ajax : psj 추가
	 * @MethodName : searchCpnAjax
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/searchCpnAjax2.do")
	public String searchCpnAjax2(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			ModelMap model) throws Exception{
		int totCnt = 0;
		List<CompanyVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", workVO.getCpnNm());
        /*if(workVO.getCpnNm()!=null && !workVO.getCpnNm().equals("")){*/

	        //System.out.println(companyVO.getPageIndex());

	        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
	        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
			int recordCountPerPage = paginationInfo.getRecordCountPerPage();
			companyVO.setFirstIndex(firstRecordIndex);
			companyVO.setRecordCountPerPage(recordCountPerPage);

			try{
				result = companyService.selectCompanyList(companyVO);
				totCnt = companyService.selectCompanyListCnt(companyVO);
			}catch(Exception e){
				LOG.error(e);
				e.printStackTrace();
			}
			model.addAttribute("companyList", result);

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);
        //}
		return "company/include/popSearchCom2_INC/inc";
	}

	/**
	 * 회사 등록/수정하기 :psj추가
	 * @MethodName : insertCpn
	 * @param companyVO
	 * @param session
	 * @param
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/company/processCpnAjax.do")
	public void insertCpn(@ModelAttribute("companyVO") CompanyVO companyVO,
			HttpSession session,
			HttpServletResponse response,
			@RequestParam Map<String,Object>map,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		companyVO.setRgId(baseUserLoginInfo.get("loginId").toString());
		companyVO.setOrgId(baseUserLoginInfo.get("orgId").toString());
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		int cnt = 0;
		//담당자가 없다면 0으로 ....
		if(companyVO.getCeoId().equals("")) companyVO.setCeoId("0");

		//국내,해외 여부에 따라 주소 셋팅
		if(companyVO.getDomesticYn().equals("N")){
			if(map.get("overseasZip")!=null&&!map.get("overseasZip").equals("")){
				companyVO.setZip(map.get("overseasZip").toString());
			}

			if(map.get("overseasAddr")!=null&&!map.get("overseasAddr").equals("")){
				companyVO.setAddr(map.get("overseasAddr").toString());
			}

			if(map.get("overseasAddrDetail")!=null&&!map.get("overseasAddrDetail").equals("")){
				companyVO.setAddrDetail(map.get("overseasAddrDetail").toString());
			}
			if(map.get("overseasAddrDetail")!=null&&!map.get("overseasAddrDetail").equals("")){
				companyVO.setAddrDetail(map.get("overseasAddrDetail").toString());
			}

		}else{
			companyVO.setAddrDetail2("");
		}


		if(companyVO.getCpnId() == null || companyVO.getCpnId().equals("")){		//신규 등록
			/*List<CompanyVO> result = null;
			result = companyService.selectMaxCpnId(companyVO);

			if(companyVO.getaCpnId() != null && !companyVO.getaCpnId().equals("")){
				companyVO.setCpnId(companyVO.getaCpnId());
			}else{
				Integer maxCpnId = Integer.parseInt(String.valueOf(result.get(0).getCpnId()));
				companyVO.setCpnId((maxCpnId+1)+"");
			}
			*/
			cnt = companyService.insertCompany2(companyVO);
			LOG.debug(baseUserLoginInfo.get("loginId").toString()+"companyService.insertCompany");

		}else{																		//회사 수정
			if(StringUtil.isEmpty(companyVO.getComCd())) cnt = companyService.updateCompany2(companyVO);
			else cnt = companyService.updateCompany3(companyVO);
		}
		Map obj = new HashMap();

		obj.put("saveCnt", cnt);
		obj.put("cpnId", companyVO.getCpnId());
		obj.put("sNb", companyVO.getsNb());

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 * 회사 디테일 > 인물정보 : psj 추가...
	 * @MethodName : personNet
	 * @param companyVO
	 * @param session
	 * @param
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/company/personNet.do")
	public String personNet(
							@ModelAttribute("companyVO") CompanyVO companyVO,
							ModelMap model,
							HttpSession session
							) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());
		List<EgovMap> cpnUserList =  personMgmtService.getCpnUserList(companyVO.getCpnId());

		model.addAttribute("cpnUserList", cpnUserList);
		if(companyVO.getOrgId()!=null){
			String chkOrg = companyVO.getOrgId().equals(baseUserLoginInfo.get("applyOrgId").toString())?"Y":"N";
			model.addAttribute("chkOrg", chkOrg);
			model.addAttribute("cpnNm", companyVO.getCpnNm());

			//회사 디테일 : S
			CompanyVO detailVo = companyService.selectMainCompanyList2(companyVO);
			model.addAttribute("companyDetail", detailVo);
		}

		List<Map> orgIdList = userService.getOrgIdList("");  //전체 관계사 리스트
		model.addAttribute("orgIdList", orgIdList);

		return "company/pop/personNet/pop";
	}
	/**
	 * 회사 디테일 > 인물정보 네트워크 Ajax: psj 추가...
	 * @MethodName : getPersonNetAjax
	 * @param model
	 * @param paramMap
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/company/getPersonNetAjax.do")
	public String getPersonNetAjax(HttpSession session
			 , Model model
			 , @RequestParam Map<String,Object> paramMap
			) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

	    PaginationInfo paginationInfo = new PaginationInfo();
		//현재 페이지
	    Integer pageIndex = 1;

	    if(paramMap.containsKey("pageIndex")){
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
	    }

        paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

        Integer recordCountPerPage = 10;
        paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();

	    paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);
		//추천네트워크
		PersonVO personVO = new PersonVO();
		personVO.setOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		personVO.setCompanyOrder("Y");
		personVO.setsNb(paramMap.get("sNb").toString());
		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);
		personVO.setSearchOrgId(paramMap.get("searchOrgId").toString());
		personVO.setChkPerson("N");
		//총개수
		//Integer totalCnt = personMgmtService.selectNetworkListTotalCnt(personVO);
		//paginationInfo.setTotalRecordCount(totalCnt);
		model.addAttribute("netList",personMgmtService.selectNetworkList(personVO,paginationInfo));
		model.addAttribute("paginationInfo",paginationInfo);

		model.addAttribute("searchOrgId", paramMap.get("searchOrgId"));

		return "company/include/personNet_INC/inc";
	}

	/**
	 * 회사/인물 페이지 회사 needs 수정
	 * @MethodName : modifyOfferInfo
	 * @param request
	 * @param wVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/modifyOfferInfo.do")
	public String modifyOfferInfo(HttpServletRequest request,
			WorkVO wVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());
		wVO.setRgId(baseUserLoginInfo.get("loginId").toString());
		wVO.setOrgId(baseUserLoginInfo.get("orgId").toString());

		workService.updateOfferInfo(wVO);
		LOG.debug(baseUserLoginInfo.get("loginId").toString()+"workService.updateOfferInfo^_^"+wVO.getsNb());
		model.addAttribute("result", 0);

		return "basic/result";
	}

	/**
	 * 회사 일괄 업로드 엑셀
	 * @MethodName : popUpCst
	 * @param request
	 * @param personVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/popUpExcel.do")
	public String popUpCst(HttpServletRequest request,
			PersonVO personVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		return "company/ExcelRegistCPN/noHeader";
	}


	/**
	 * 회사 일괄 업로드 CSV 파일 ... 20160719
	 * @MethodName : popUpCst
	 * @param request
	 * @param personVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/uploadCompanyByCsv.do")
	public String uploadCompanyByCsv(HttpServletRequest request,
			PersonVO personVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		return "company/uploadCompanyByCsv/noHeader";
	}

	@Value("${Globals.fileStorePath2}")
	private String folderPathBase;
	/**
	 * 회사 일괄 업로드 - CSV
	 * @MethodName : uploadExel
	 * @param request
	 * @param response
	 * @param rcmdVO
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/company/uploadCompanyProcess.do")
	public void uploadCompanyProcess(
			HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("rcmdVO") RecommendVO rcmdVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return;	// "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		response.setCharacterEncoding("EUC-KR");
		PrintWriter out = response.getWriter();

		try{
			// 정보 받기
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
			// 파일업로드 시키기
			String folderPath = folderPathBase + "/PASS_CSV";
			//os가 리눅스면 D:를 제거한다
  			if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") < 0)
  	        {
  				if(folderPath.indexOf("D:")>=0){
  					folderPath = folderPath.split("D:")[1];
  				}
  	        }

		    File f = new File(folderPath);
		    f.mkdirs();//파일 저장될 폴더 생성

			// 넘어온 파일을 리스트에 담아서
			List<MultipartFile> files = multi.getFiles("fileUrl");
			if (files.size() == 1 && files.get(0).getOriginalFilename().equals("")) {

	        } else {
	            for (int i = 0; i < files.size(); i++) {
	                String originalfileName = files.get(i).getOriginalFilename();
	                if("".equals(originalfileName) || originalfileName==null){
	                	continue;
	                }


                	//String newFileName = "" + (System.currentTimeMillis() + 1);		//새이름
                	String newFileName = Utill.upFileReName(files.get(0), originalfileName, folderPath);		//새이름
                	String savePath = folderPath + "/" + newFileName; 					//저장 될 파일 경로/이름

                	files.get(i).transferTo(new File(savePath)); // 파일 저장
                	File fNewname1 = new File(savePath);

                	//----------------------------------- 등록 :S -----------------------------------
                	Map result = companyService.uploadCompanyProcess(baseUserLoginInfo, fNewname1);


                	model.put("upload", result.get("upload"));			//업로드 success



                	if("0".equals(result.get("upload").toString()))
                		out.print(result.get("failMsg").toString());
                		//model.put("failMsg", result.get("failMsg").toString());
                	//model.put("upload", result.get("upload"));			//업로드 fail
                	else
                		out.print("SUCCESS!!");


	            }
	        }
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();

			model.put("upload", 0);			//업로드 fail
        	model.put("failMsg", e.getMessage());

        	throw e;
		}


		//return "company/uploadCompanyByCsv";
	}

	/**
	 * 상장회사 일괄 업로드 - CSV
	 * @MethodName : uploadExel
	 * @param request
	 * @param response
	 * @param rcmdVO
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/company/uploadCompanyInfoProcess.do")
	public void uploadCompanyInfoProcess(
			HttpServletRequest req,
			HttpServletResponse response,
			@ModelAttribute("rcmdVO") RecommendVO rcmdVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return;	// "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		response.setCharacterEncoding("EUC-KR");
		PrintWriter out = response.getWriter();

		try{
			// 정보 받기
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
			// 파일업로드 시키기
			//String folderPath = "c:\\temp"; // 파일이 저장될 경로
			String folderPath = folderPathBase + "/CompanyInfoAdd";
			//os가 리눅스면 D:를 제거한다
  			if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") < 0)
  	        {
  				if(folderPath.indexOf("D:")>=0){
  					folderPath = folderPath.split("D:")[1];
  				}
  	        }

		    File f = new File(folderPath);
		    f.mkdirs();//파일 저장될 폴더 생성

			// 넘어온 파일을 리스트에 담아서
			List<MultipartFile> files = multi.getFiles("fileUrl");
			if (files.size() == 1 && files.get(0).getOriginalFilename().equals("")) {

	        } else {
	            for (int i = 0; i < files.size(); i++) {
	                String originalfileName = files.get(i).getOriginalFilename();
	                if("".equals(originalfileName) || originalfileName==null){
	                	continue;
	                }


                	//String newFileName = "" + (System.currentTimeMillis() + 1);		//새이름
                	String newFileName = Utill.upFileReName(files.get(0), originalfileName, folderPath);		//새이름
                	String savePath = folderPath + "/" + newFileName; 					//저장 될 파일 경로/이름

                	files.get(i).transferTo(new File(savePath)); // 파일 저장
                	File fNewname1 = new File(savePath);

                	//----------------------------------- 등록 :S -----------------------------------
                	Map result = companyService.uploadCompanyInfoProcess(baseUserLoginInfo, fNewname1);


                	model.put("upload", result.get("upload"));			//업로드 success



                	if("0".equals(result.get("upload").toString()))
                		out.print(result.get("failMsg").toString());
                		//model.put("failMsg", result.get("failMsg").toString());
                	//model.put("upload", result.get("upload"));			//업로드 fail
                	else
                		out.print("SUCCESS!!");


	            }
	        }
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();

			model.put("upload", 0);			//업로드 fail
        	model.put("failMsg", e.getMessage());

        	throw e;
		}
	}

	/**
	 * 주가정보 일괄 업로드 - CSV
	 * @MethodName : uploadExel
	 * @param request
	 * @param response
	 * @param rcmdVO
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/company/uploadStockProcess.do")
	public void uploadStockProcess(
			HttpServletRequest req,
			HttpServletResponse response,
			@ModelAttribute("rcmdVO") RecommendVO rcmdVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return;	// "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		response.setCharacterEncoding("EUC-KR");
		PrintWriter out = response.getWriter();

		try{
			// 정보 받기
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
			// 파일업로드 시키기
			//String folderPath = "c:\\temp"; // 파일이 저장될 경로
			String folderPath = folderPathBase + "/StockPriceAdd";
			//os가 리눅스면 D:를 제거한다
  			if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") < 0)
  	        {
  				if(folderPath.indexOf("D:")>=0){
  					folderPath = folderPath.split("D:")[1];
  				}
  	        }

		    File f = new File(folderPath);
		    f.mkdirs();//파일 저장될 폴더 생성

			// 넘어온 파일을 리스트에 담아서
			List<MultipartFile> files = multi.getFiles("fileUrl");
			if (files.size() == 1 && files.get(0).getOriginalFilename().equals("")) {

	        } else {
	            for (int i = 0; i < files.size(); i++) {
	                String originalfileName = files.get(i).getOriginalFilename();
	                if("".equals(originalfileName) || originalfileName==null){
	                	continue;
	                }


                	//String newFileName = "" + (System.currentTimeMillis() + 1);		//새이름
                	String newFileName = Utill.upFileReName(files.get(0), originalfileName, folderPath);		//새이름
                	String savePath = folderPath + "/" + newFileName; 					//저장 될 파일 경로/이름

                	files.get(i).transferTo(new File(savePath)); // 파일 저장
                	File fNewname1 = new File(savePath);

                	//----------------------------------- 등록 :S -----------------------------------
                	Map result = companyService.uploadStockProcess(baseUserLoginInfo, fNewname1);


                	model.put("upload", result.get("upload"));			//업로드 success



                	if("0".equals(result.get("upload").toString()))
                		out.print(result.get("failMsg").toString());
                		//model.put("failMsg", result.get("failMsg").toString());
                	//model.put("upload", result.get("upload"));			//업로드 fail
                	else
                		out.print("SUCCESS!!");


	            }
	        }
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();

			model.put("upload", 0);			//업로드 fail
        	model.put("failMsg", e.getMessage());

        	throw e;
		}
	}

	/***********************************/

	/**
	 * EXCEL 의 IMPORT 할 데이터 내용 console 로 출력
	 * @param row
	 * @return
	 * @throws Exception
	 */
	public boolean processRow(Row row) throws Exception {
		Cell cell = null;
		for (int i = 0; i < row.getLastCellNum(); i++) {
			cell = row.getCell((short) i);

			if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
				System.out.print(row.getCell((short) i));
			} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				System.out.print(row.getCell((short) i));
			}

			System.out.print("\t");
		}
		//System.out.println();
		return true;
	}


	/**
	 * 2014년 현재 주석처리됨////
	 * 실질적으로 IMPORT 하는 메소드
	 * @param fileName 불러읽어들일 파일이름
	 */
	protected static String fileName = "";
	protected int sheetNo = 0;
	public boolean run(String realFileName, String fileUrl, String stuff) {
		FileInputStream myxls = null;
		File fileName = new File(fileUrl);
		CpnExcelVO vo = new CpnExcelVO();
//		List<PersonVO> result = null;
//		PersonVO prsn = new PersonVO();

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
				vo = (CpnExcelVO) xcel.mappingColumn(row, stuff);
				@SuppressWarnings("unused")
				int cnt = 0;
				if("cpn".equals(stuff))	{
					cnt = companyService.insertNupdateCompanyExel(vo); //INSERT DUPLICATED UPDATE

				}else if("exp".equals(stuff))	{
					WorkVO wvo = new WorkVO();
					wvo.setCpnId(vo.getCpnId());
					List<WorkVO> rslt = workService.selectCompanyOpinion(wvo);

					StringBuilder sb = new StringBuilder(vo.getText());
					if(!rslt.isEmpty() && rslt.get(0).getOpinion()!= null){
						sb.append("&#10;");
						sb.append(rslt.get(0).getOpinion());
					}
					vo.setOpinion(sb.toString());
					vo.setTmpNum1(stuff);
					vo.setPbr("ab3");
					//System.out.println("===========\n"+vo.getCpnId()+"\n"+vo.getOpinion()+"\n============");
					cnt = workService.updateCompanyOpinion(vo);
				}

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
	 *
	 * 메인 네트워크 리스트 Ajax
	 *
	 * @param : HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/company/mainListAjax.do")
	public void mainListAjax(HttpSession session
									 , HttpServletResponse response
									 , @RequestParam Map<String,Object> paramMap
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		//////////////////////////조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();


		//현재 페이지
		Integer pageIndex = 1;

		if(paramMap.containsKey("pageIndex")&& !paramMap.get("pageIndex").toString().equals("")){
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

      paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호
      Integer recordCountPerPage = 50;

      paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
      paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

      int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		//int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> mainNetworkList = companyService.getMainNetworkList(paramMap);

		AjaxResponse.responseAjaxObject(response, mainNetworkList);		//"SUCCESS" 전달
		//////////////////////////조회 가능한 기안문서 리스트:E////////////////////////////
	}
	/**
	 *
	 * 회사 상세정보를 조회한다. Ajax
	 *
	 * @param : HttpSession
	 * @return : String "company/getCompanyDetailAjax"
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/company/getCompanyDetailAjax.do")
	public void getCompanyDetailAjax(HttpSession session
			, HttpServletResponse response
			, CompanyVO companyVO
			, @RequestParam Map<String,Object> paramMap
			) throws Exception {
		companyVO.setCpnId(companyVO.getaCpnId());
		//회사 디테일 : S
		EgovMap companyMap = null;
		companyMap = companyService.selectMainCompanyList3(companyVO);

		AjaxResponse.responseAjaxObject(response, companyMap);		//"SUCCESS" 전달
	}
	/***********************************/

	public boolean isNullOrEmpty(Object element){
		boolean status = false;

		if(element==null) status = true;
		else if("".equals(element)) status = true;

		return status;
	}

	/**
	 * 상장회사 일괄 업로드 CSV 파일 ... 20170309
	 * @MethodName : popUpCst
	 * @param request
	 * @param personVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/uploadCompanyInfoByCsv.do")
	public String uploadCompanyInfoByCsv(HttpServletRequest request,
			PersonVO personVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		return "company/uploadCompanyInfoByCsv/noHeader";
	}

	/**
	 * 주가정보 일괄 업로드 CSV 파일 ... 20170309
	 * @MethodName : popUpCst
	 * @param request
	 * @param personVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/uploadStockInfoByCsv.do")
	public String uploadStockInfoByCsv(HttpServletRequest request,
			PersonVO personVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		return "company/uploadStockInfoByCsv/noHeader";
	}

	/**
	 * 회사 찾기 팝업 : psj 추가
	 * @MethodName : popUpCpn
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/popUpCpnDupChk.do")
	public String popUpCpnDupChk(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			@RequestParam(value= "type",required=false) String type,
			ModelMap model) throws Exception{


		int totCnt = 0;
		List<CompanyVO> result = null;
        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", workVO.getCpnNm());
        //if(workVO.getCpnNm()!=null && !workVO.getCpnNm().equals("")){

	        //System.out.println(companyVO.getPageIndex());

	        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
	        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
			int recordCountPerPage = paginationInfo.getRecordCountPerPage();
			companyVO.setFirstIndex(firstRecordIndex);
			companyVO.setRecordCountPerPage(recordCountPerPage);

			try{
				result = companyService.selectCompanyList(companyVO);
				totCnt = companyService.selectCompanyListCnt(companyVO);
			}catch(Exception e){
				LOG.error(e);
				e.printStackTrace();
			}
			model.addAttribute("companyList", result);

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);

	        if(type!=null)
	        	model.addAttribute("type", type);
        //}
		return "company/pop/popUpCpnDupChk/pop";
	}

	/**
	 * 회사 삭제  : psj 추가
	 * @MethodName : popUpCpn
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/company/deleteCompany.do")
	public void deleteCompany(HttpServletRequest request,
							HttpSession session,
							HttpServletResponse response,
							@RequestParam Map<String,Object> map,
							Model model) throws Exception{
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("userId", baseUserLoginInfo.get("userId"));

		String result = companyService.deleteCompany(map);

		Map<String,Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result",result);

		AjaxResponse.responseAjaxObject(response, resultMap);
	}
}