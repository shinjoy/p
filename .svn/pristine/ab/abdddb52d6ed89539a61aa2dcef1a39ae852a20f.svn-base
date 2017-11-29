package ib.person.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.cmm.IBsMessageSource;
import ib.cmm.service.CmmUseService;
import ib.cmm.service.CommonService;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.company.service.CompanyService;
import ib.company.service.CompanyVO;
import ib.person.service.PersonMgmtService;
import ib.person.service.PersonVO;
import ib.work.service.WorkService;
import ib.work.service.WorkVO;

/**
 * <pre>
 * package  : ib.person.web
 * filename : PersonMgmtController.java
 * </pre>
 *
 * @author  :
 * @since   :
 * @version :
 */
@Controller
public class PersonMgmtController {

	/** CmmUseService */
	@Resource(name="CmmUseService")
	private CmmUseService cmm;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	/** MessageSource */
    @Resource(name="IBsMessageSource")
    IBsMessageSource MessageSource;

    @Resource(name = "workService")
    private WorkService workService;

    @Resource(name = "personMgmtService")
	private PersonMgmtService personMgmtService;

    @Resource(name = "commonService")
	private CommonService commonService;


    @Resource(name="companyService")
    private CompanyService companyService;

    /** log */
    protected static final Log LOG = LogFactory.getLog(PersonMgmtController.class);

	protected static Calendar cal = Calendar.getInstance();

	/**
	 * Main 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return Main Page
	 * @exception Exception
	 */
	@RequestMapping(value="/person/personMgmt.do")
	public String index(@ModelAttribute("personVO") PersonVO personVO,
			CompanyVO companyVO,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		//공통코드 검색
		Map cmmCdCategoryListCodeMap = new HashMap();
        cmmCdCategoryListCodeMap.put("codeSetNm", "CUSTOMER_TYPE");
        cmmCdCategoryListCodeMap.put("orgId", baseUserLoginInfo.get("applyOrgId"));
        model.addAttribute("customerTypeList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		return "person/personMgmt";
    }

	/**
	 * 고객타입
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/person/getCustomerTypeList.do")
	public String getCustomerTypeList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		//공통코드 검색
		Map cmmCdCategoryListCodeMap = new HashMap();
        cmmCdCategoryListCodeMap.put("codeSetNm", "CUSTOMER_TYPE");
        cmmCdCategoryListCodeMap.put("orgId", map.get("searchOrgId").toString());
        model.addAttribute("customerTypeList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		return "person/include/personMgmt_customerType_INC/inc";
	}

	/**
	 * 고객리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/person/getCustList.do")
	public void getCustList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("usrId", baseUserLoginInfo.get("loginId").toString());				//사용자 login id
		map.put("usrCusId", baseUserLoginInfo.get("cusId").toString());				//사용자 고객id (sequence)

		//map.put("orgId", baseUserLoginInfo.get("orgId").toString());			//orgId
		//map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());			//orgId
		map.put("applyOrgId", map.get("searchOrgId").toString());

		//List<Map> list = personMgmtService.getCustList(map);
		Map<String, Object> resultMap = personMgmtService.getCustList((Map)map);

		//AjaxResponse.responseAjaxSelect(response, list);	//결과전송
		AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송

	}

	/**
	 * 고객리스트 엑셀 다운로드
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/person/getCustListForExcel.do")
	public String getCustListForExcel(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("usrId", baseUserLoginInfo.get("loginId").toString());				//사용자 login id
		map.put("usrCusId", baseUserLoginInfo.get("cusId").toString());				//사용자 고객id (sequence)

		//map.put("orgId", baseUserLoginInfo.get("orgId").toString());			//orgId
		//map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());			//orgId
		map.put("applyOrgId", map.get("searchOrgId").toString());

		//List<Map> list = personMgmtService.getCustList(map);
		List<Map> custList = personMgmtService.getCustListForExcel((Map)map);

		model.addAttribute("custList", custList);

		return "person/include/personMgmt_excel_INC/inc";			//인물네트워크
	}


	/**
	 * 회사별 부서 리스트 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 01. 15.
	 */
	@RequestMapping(value = "/person/getCpnDeptList.do")
	public void getCpnDeptList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,String> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		 List<Map> list = personMgmtService.getCpnDeptList((Map)map);
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 신규할당 고객리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/person/getCustListNewInCharge.do")
	public void getCustListNewInCharge(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		//map.put("usrId", baseUserLoginInfo.get("loginId").toString());				//사용자 login id
		map.put("usrId", baseUserLoginInfo.get("userId").toString());			//사용자 고객id (sequence)
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());			//

		List<Map> list = personMgmtService.getCustListNewInCharge(map);
		//Map<String, Object> resultMap = personMgmtService.getCustList((Map)map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
		//AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송
	}


	/**
	 * 신규 할당된 고객리스트 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 03. 16.
	 */
	@RequestMapping(value = "/person/newCstInChargePopup.do")
	public String newCstInChargePopup(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("orgId", baseUserLoginInfo.get("orgId"));

		//정보 변경 조회
		map.put("customerInfoChangeType","INFO");
		List<Map> customerChangeInfoList = personMgmtService.getCustomerChangeConfirmList(map);
		model.addAttribute("customerChangeInfoList", customerChangeInfoList);

		//담당자 변경 조회
		map.put("customerInfoChangeType","MANAGER");
		List<Map> customerChangeManagerList = personMgmtService.getCustomerChangeConfirmList(map);
		model.addAttribute("customerChangeManagerList", customerChangeManagerList);

		personMgmtService.deleteCustomerInfoChange(map);
		return "person/newCstInChargePopup/pop";
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
	@RequestMapping(value = "/person/doAcceptCstManager.do")
	public void doAcceptCstManager(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
//		if(Integer.parseInt(loginUser.getPermission())<11) return "basic/Content";
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		/*
		cstList : cstSnbList	//고객 id list (sequence list)
		*/

		map.put("userSeq", baseUserLoginInfo.get("userId").toString());
		map.put("cusId", baseUserLoginInfo.get("cusId").toString());
		map.put("orgId",baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId",baseUserLoginInfo.get("applyOrgId").toString());
		map.put("loginId",baseUserLoginInfo.get("loginId").toString());
		map.put("orgNm", baseUserLoginInfo.get("orgNm").toString());
		int upCnt = 0;

		upCnt = personMgmtService.doAcceptCstManager(map);

		AjaxResponse.responseAjaxSave(response, upCnt);		//결과전송

	}


	/**
	 * 담당자 변경 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 03. 15.
	 */
	@RequestMapping(value = "/person/chngCstManagerPopup.do")
	public String chngCstManagerPopup(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("mainYn", "Y");
		paramMap.put("hideSynergyUserYn", baseUserLoginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부

		List<Map> staffList =commonService.getUserList(paramMap);						//사용자 리스트

		 //Json 스트링 변환
        ObjectMapper mapper = new ObjectMapper();
        String staffListStr = mapper.writeValueAsString(staffList);
		model.addAttribute("staffList", staffListStr);
		model.addAttribute("cstList", map.get("cstList"));
		//model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "person/chngCstManagerPopup/pop";
	}


	/**
	 * 고객 등록 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 03. 23.
	 */
	@RequestMapping(value = "/person/regCstPopup.do")
	public String regCstPopup(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
		model.addAttribute("actionType", "INSERT");

		List<Map> contryCodeList = companyService.selectContryCodeList(baseUserLoginInfo);

		model.addAttribute("contryCodeList", contryCodeList);
		return "person/regCstPopup/pop";
	}


	/**
	 * 신규 고객 등록 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 2. 23.
	 */
	@RequestMapping(value = "/person/regCustomer.do")
	public void regNewCst(@ModelAttribute("personVO") PersonVO personVO,
			HttpServletRequest request,	HttpServletResponse response,
			ModelMap model,	HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("rgId", baseUserLoginInfo.get("loginId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("staffSnb", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());

		//int upCnt = 0;
		personVO.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		int cstId = personMgmtService.regCustomer(map, personVO);			//담당자등록 및 네트워크 등록을 위한 서비스추가후 연결

		Map obj = new HashMap();
		obj.put("sNb", cstId+"");

		//AjaxResponse.responseAjaxSave(response, upCnt);		//결과전송
		AjaxResponse.responseAjaxObject(response, obj);			//결과전송

	}


	/**
	 * 고객이름 찾기(신규등록을 위해 없는 이름) ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 2. 23.
	 */
	@RequestMapping(value = "/person/getCustomerName.do")
	public void getCustomerName(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		String cstNm = (String)map.get("cstNm");
		String phn1 = (String)map.get("phn1");

		map.put("cstNm", cstNm);
		map.put("phn1", phn1);
		Map obj = new HashMap<String,String>();

		obj.put("isExist", "NONE");		//중복된 데이터 여부 NONE, MOBILE, NAME

		Map cstMobileM = personMgmtService.getCustomerSameMobile(map);	//핸드폰 번호 중복체크
		if(cstMobileM != null){  //핸드폰 번호가 같으면
			obj.put("cstNmMobile", (String)cstMobileM.get("cstNm"));				//핸드폰 중복자 이름
			obj.put("isExist", "MOBILE");		//중복된 데이터 여부 NONE, MOBILE, NAME
		}else{
			Map cstNameM = personMgmtService.getCustomerSameName(map);	//이름 중복체크
			if(cstNameM != null){  //핸드폰 번호가 같으면
				obj.put("isExist", "NAME");		//중복된 데이터 여부 NONE, MOBILE, NAME
			}
		}

		//AjaxResponse.responseAjaxSave(response, upCnt);		//결과전송
		AjaxResponse.responseAjaxObject(response, obj);			//결과전송

	}


	/**
	 * 고객삭제 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 8.
	 */
	@RequestMapping(value = "/person/doDelCst.do")
	public void doDelCst(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
//		if(Integer.parseInt(loginUser.getPermission())<11) return "basic/Content";
		LOG.info(baseUserLoginInfo.get("loginId").toString());

		/*
		cstList : cstSnbList	//고객 id list (sequence list)
		*/

		map.put("userSeq", baseUserLoginInfo.get("userId").toString());

		int upCnt = 0;

		upCnt = personMgmtService.doDelCst(map);

		AjaxResponse.responseAjaxSave(response, upCnt);		//결과전송

	}
	/**
	 * 고객 알림 팝업 노출 여부 판단
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/person/getChkPersonNoticeInfo.do")
	public void getChkPersonNoticeInfo(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("userId", baseUserLoginInfo.get("userId").toString());			//사용자 고객id (sequence)
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());			//

		//List<Map> list = personMgmtService.getCustListNewInCharge(map);
		Integer cnt = personMgmtService.getChkPersonNoticeInfo(map);
		Map<String,Object> obj = new HashMap<String,Object>();
		obj.put("result", "SUCCESS");
		obj.put("cnt", cnt);

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
		//AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송
	}
	/**
	 * 사용자이름 가져오기(트리선택시 고객명 리턴함) ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2017. 2. 13.
	 */
	@RequestMapping(value = "/person/getUserNameList.do")
	public void getUserNameList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		List<EgovMap> userList = personMgmtService.getUserNameList(map);	//사용자명 가져오기
		Map obj = new HashMap();
		obj.put("userList", userList);
		AjaxResponse.responseAjaxObject(response, obj);			//결과전송

	}



}