package ib.approve.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.approve.service.ApproveService;
import ib.approve.service.ApproveSetService;
import ib.approve.service.ApproveVoList;
import ib.cmm.service.CommonService;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.LogUtil;
import ib.common.util.DateUtil;
import ib.file.service.FileService;
import ib.personnel.service.ManagementService;
import ib.project.service.ProjectMgmtService;

/**
 * <pre>
 * package	: ibiss.approve.web
 * filename	: ApproveController.java
 * </pre>
 *
 * 전자결재 컨트롤러
 *
 * @author : Park
 * @date : 2016. 10. 20.
 * @version :
 *
 */
@Controller
public class ApproveController {

	protected static final Log logger = LogFactory.getLog(ApproveController.class);

	@Resource(name = "approveService")
	private ApproveService approveService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Resource(name = "projectMgmtService")
	private ProjectMgmtService projectMgmtService;

	@Resource(name = "managementService")
	private ManagementService managementService;

	@Resource(name = "commonService")
	private CommonService commonService;

	@Resource(name = "approveSetService")
	private ApproveSetService approveSetService;


	// new아이콘
	String newIcon = "<span class=\"icon_new\"><em>new</em></span>";

	// 카운트 prefix
	String prefix = "<span class=\"menuRipple\">(";
	// 카운트 suffix
	String suffix = ")</span>";

	Date nowDate = new Date();

	// 메뉴의 new갯수를 조회하기위한 맵
	Map<String, Object> contentMarkRuleMap = new HashMap<String, Object>();

	@ModelAttribute
	public void common(Model model, HttpServletRequest request, HttpSession session) {
		///////////////// ajax조회면 실행하지 않는다 : S
		String ajaxHeader = request.getHeader("X-Requested-With");

		String winId = request.getParameter("winID");	//AxisModal

		String url = request.getServletPath();
		if ((ajaxHeader != null && ajaxHeader.equals("XMLHttpRequest"))||winId!=null||url.indexOf("/batch/")>=0)
			return;
		///////////////// ajax조회면 실행하지 않는다 : E
		Map<String, String> menuMap = new HashMap<String, String>();
		try {
			// 기본정보 셋팅
			Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");


			String orgId = baseUserLoginInfo.get("orgId").toString();
			String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();

			contentMarkRuleMap.put("orgId",applyOrgId);
			contentMarkRuleMap.put("applyOrgId",applyOrgId);

			if(!orgId.equals(applyOrgId)){
				contentMarkRuleMap.put("searchApplyOrgId", "Y");
			}else contentMarkRuleMap.put("searchApplyOrgId", "N");

			contentMarkRuleMap.put("userId", baseUserLoginInfo.get("userId"));
			contentMarkRuleMap.put("useYn", "Y");

			//////////////////////// 기본서식 new조회 :S
			SimpleDateFormat sdfmt = new SimpleDateFormat("yyyyMMdd");
			Date productEndDate = sdfmt.parse("20170824");

			Integer productDateCnt = DateUtil.getDiffDayCountTwoDate(nowDate, productEndDate);

			if (productDateCnt > 0)
				menuMap.put("MENU_APPROVE_PRODUCT", newIcon);
			//////////////////////// 기본서식 new조회 :E

			/////////////////////// 사내서식 new 조회:S
			contentMarkRuleMap.put("newContentMarkClass", "APPV");
			contentMarkRuleMap.put("newContentMarkType", "COMPANY");

			// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
			contentMarkRuleMap.put("ruleUseYn", "N");

			List<EgovMap> markRuleList = managementService.markRuleListList(contentMarkRuleMap);

			if (markRuleList != null && markRuleList.size() == 1) {

				EgovMap ruleMap = markRuleList.get(0);
				contentMarkRuleMap.put("ruleUseYn", "Y");
				contentMarkRuleMap.put("readTimeYn", ruleMap.get("readTimeYn"));
				contentMarkRuleMap.put("markDayCnt", ruleMap.get("markDayCnt"));
			}

			Integer menuApproveCompanyCnt = approveService.getMenuApproveCompanyCnt(contentMarkRuleMap);
			if (menuApproveCompanyCnt > 0)
				menuMap.put("MENU_APPROVE_COMPANY", newIcon);
			/////////////////////// 사내서식 new 조회:E

			/////////////////////// 임시저장 new 조회:S

			contentMarkRuleMap.put("approveDraftIngYn", "N");
			Integer menuMenuApproveTemp = approveService.getMenuMenuApproveTemp(contentMarkRuleMap);
			if (menuMenuApproveTemp > 0)
				menuMap.put("MENU_APPROVE_TEMP", prefix + menuMenuApproveTemp + suffix);

			contentMarkRuleMap.put("approveDraftIngYn", "Y");
			Integer menuMenuApproveDraft = approveService.getMenuMenuApproveTemp(contentMarkRuleMap);
			if (menuMenuApproveDraft > 0)
				menuMap.put("MENU_APPROVE_DRFDOC", prefix + menuMenuApproveDraft + suffix);
			/////////////////////// 임시저장 new 조회:E

			/////////////////////// 기결 new 조회:S
			contentMarkRuleMap.put("listType", "reqList");
			Integer menuApproveReq = approveService.getMenuApproveReqList(contentMarkRuleMap);
			if (menuApproveReq > 0)
				menuMap.put("MENU_APPROVE_REQ_PRODUCT", prefix + menuApproveReq + suffix);
			/////////////////////// 기결 new 조회:E

			/////////////////////// 미결 new 조회:S
			contentMarkRuleMap.put("listType", "pendList");

			contentMarkRuleMap.put("newContentMarkClass", "APPV");
			contentMarkRuleMap.put("newContentMarkType", "APPROVER");

			// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
			contentMarkRuleMap.put("ruleUseYn", "N");

			markRuleList = managementService.markRuleListList(contentMarkRuleMap);

			if (markRuleList != null && markRuleList.size() == 1) {

				EgovMap ruleMap = markRuleList.get(0);
				contentMarkRuleMap.put("ruleUseYn", "Y");
				contentMarkRuleMap.put("readTimeYn", ruleMap.get("readTimeYn"));
				contentMarkRuleMap.put("markDayCnt", ruleMap.get("markDayCnt"));
			}

			Integer menuApprovePending = approveService.getMenuApproveReqList(contentMarkRuleMap);
			if (menuApprovePending > 0)
				menuMap.put("MENU_APPROVE_PENDING", prefix + menuApprovePending + suffix);

			contentMarkRuleMap.put("listType", "nextList");
			Integer menuApproveNext = approveService.getMenuApproveReqList(contentMarkRuleMap);
			if (menuApproveNext > 0)
				menuMap.put("MENU_APPROVE_NEXT", prefix + menuApproveNext + suffix);
			/////////////////////// 미결 new 조회:E

			/////////////////////// 선열 new 조회:S
			contentMarkRuleMap.put("listType", "previous");

			contentMarkRuleMap.put("newContentMarkClass", "APPV");
			contentMarkRuleMap.put("newContentMarkType", "PREVIOUS");
			// PREVIOUS
			// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
			contentMarkRuleMap.put("ruleUseYn", "N");

			markRuleList = managementService.markRuleListList(contentMarkRuleMap);

			if (markRuleList != null && markRuleList.size() == 1) {

				EgovMap ruleMap = markRuleList.get(0);
				contentMarkRuleMap.put("ruleUseYn", "Y");
				contentMarkRuleMap.put("readTimeYn", ruleMap.get("readTimeYn"));
				contentMarkRuleMap.put("markDayCnt", ruleMap.get("markDayCnt"));
			}

			Integer menuApprovePrevious = approveService.getMenuApproveReqList(contentMarkRuleMap);
			if (menuApprovePrevious > 0)
				menuMap.put("MENU_APPROVE_PREVIOUS", prefix + menuApprovePrevious + suffix);
			/////////////////////// 선열 new 조회:E

			contentMarkRuleMap.put("ruleUseYn", "N");

			contentMarkRuleMap.put("listType", "proxyList");
			Integer menuApproveProxy = approveService.getMenuApproveReqList(contentMarkRuleMap);
			if (menuApproveProxy > 0)
				menuMap.put("MENU_APPROVE_PROXY", prefix + menuApproveProxy + suffix);

			/////////////////////// 참조문서 new 조회:S
			contentMarkRuleMap.put("newContentMarkClass", "APPV");
			contentMarkRuleMap.put("newContentMarkType", "REFERENTIAL");

			// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
			contentMarkRuleMap.put("ruleUseYn", "N");

			markRuleList = managementService.markRuleListList(contentMarkRuleMap);
			if (markRuleList != null && markRuleList.size() == 1) {

				EgovMap ruleMap = markRuleList.get(0);
				contentMarkRuleMap.put("ruleUseYn", "Y");
				contentMarkRuleMap.put("readTimeYn", ruleMap.get("readTimeYn"));
				contentMarkRuleMap.put("markDayCnt", ruleMap.get("markDayCnt"));

			}
			Integer menuApproveReference = approveService.getMenuApproveReference(contentMarkRuleMap);
			if (menuApproveReference > 0)
				menuMap.put("MENU_APPROVE_REFERENCE", prefix + menuApproveReference + suffix);

			// 수신문서 NEW :S
			contentMarkRuleMap.put("newContentMarkClass", "APPV");
			contentMarkRuleMap.put("newContentMarkType", "RECEIVER");
			// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
			contentMarkRuleMap.put("ruleUseYn", "N");
			markRuleList = managementService.markRuleListList(contentMarkRuleMap);
			if (markRuleList != null && markRuleList.size() == 1) {

				EgovMap ruleMap = markRuleList.get(0);
				contentMarkRuleMap.put("ruleUseYn", "Y");
				contentMarkRuleMap.put("readTimeYn", ruleMap.get("readTimeYn"));
				contentMarkRuleMap.put("markDayCnt", ruleMap.get("markDayCnt"));

			}
			Integer menuApproveReceived = approveService.getMenuApproveReceived(contentMarkRuleMap);
			if (menuApproveReceived > 0)
				menuMap.put("MENU_APPROVE_RECEIVED", prefix + menuApproveReceived + suffix);

			// 지출문서 NEW : S
			Integer menuApproveExpense = approveService.getMenuApproveExpense(contentMarkRuleMap);
			if (menuApproveExpense > 0)
				menuMap.put("MENU_APPROVE_EXPENSE", prefix + menuApproveExpense + suffix);

			model.addAttribute("menuSummaryMap", menuMap);

		} catch (Exception e) {
			logger.info(
					"=========================================Approve좌측메뉴 새글알림 조회도중 오류발생=============================== ");
			e.printStackTrace();
		}
	}

	/**
	 *
	 * 결재품의 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/approveProduct"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/approveProduct.do")
	public String approveProduct(HttpSession session, Model model, @RequestParam Map<String, Object> paramMap)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		model.addAttribute("searchMap", paramMap);

		return "approve/approveProduct";
	}

	/**
	 *
	 * 휴가신청 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqVacation"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/reqVacation.do")
	public String reqVacation(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv Vac create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		// 기본 정보를 셋팅한다.
		paramMap.put("appvDocClass", "VACATION");
		paramMap.put("appvDocType", "ANNUAL");

		Calendar now = Calendar.getInstance();
		paramMap.put("year", now.get(Calendar.YEAR));
		// 연차정보를 조회한다.
		/*
		 * EgovMap userHolidaySumMap =
		 * approveService.getUserHolidaySum(paramMap);
		 *
		 * model.addAttribute("userHolidaySumMap", userHolidaySumMap);
		 */

		// 결재 라인을 조회한다.
		// List<EgovMap> approveLineMap =
		// approveService.getApproveLine(paramMap);

		// model.addAttribute("approveLineMap", approveLineMap);

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);
		model.addAttribute("searchMap", paramMap);

		return "approve/reqVacation";
	}
	/**
	 *
	 * 휴가신청 구분 병경시 종결전 문서열람 정보를 조회한다
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/getVacationAppvReadDocSetup"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/getVacationAppvReadDocSetup.do")
	public void getVacationAppvReadDocSetup(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		obj.put("appvReadDocSetupMap", appvReadDocSetupMap);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}
	/**
	 *
	 * 구매신청 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqPurchase"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/reqPurchase.do")
	public String reqPurchase(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv Purchase create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// 기본 정보를 셋팅한다.
		paramMap.put("orgId", baseUserLoginInfo.get("orgId"));
		paramMap.put("appvDocClass", "BUY");
		paramMap.put("appvDocType", "BUY_IN");

		model.addAttribute("searchMap", paramMap);

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);

		String returnStr = "approve/reqPurchase";

		if(paramMap.containsKey("popYn")){

			String popYn = paramMap.get("popYn").toString();

			if(popYn.equals("M")){
				model.addAttribute("popYn", popYn);
				model.addAttribute("selDate", paramMap.get("selDate"));
				model.addAttribute("projectId", paramMap.get("projectId"));
				model.addAttribute("activityId", paramMap.get("activityId"));
				model.addAttribute("projectName", paramMap.get("projectName"));
				returnStr+="/pop";
			}
		}
		return returnStr;
	}

	/**
	 *
	 * 교육신청 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqEdu"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/reqEdu.do")
	public String reqEdu(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv Edu create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		// 기본 정보를 셋팅한다.
		paramMap.put("appvDocClass", "EDUCATION");
		paramMap.put("appvDocType", "EDU_IN");

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);

		model.addAttribute("searchMap", paramMap);


		String returnStr = "approve/reqEdu";

		if(paramMap.containsKey("popYn")){

			String popYn = paramMap.get("popYn").toString();

			if(popYn.equals("M")){
				model.addAttribute("popYn", popYn);
				model.addAttribute("selDate", paramMap.get("selDate"));
				model.addAttribute("projectId", paramMap.get("projectId"));
				model.addAttribute("activityId", paramMap.get("activityId"));
				model.addAttribute("projectName", paramMap.get("projectName"));
				returnStr+="/pop";
			}
		}
		return returnStr;
	}

	/**
	 *
	 * 출장신청 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqTrip"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/reqTrip.do")
	public String reqTrip(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv Trip create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		// 기본 정보를 셋팅한다.
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("appvDocClass", "TRIP");
		paramMap.put("appvDocType", "TRIP_IN");

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);

		model.addAttribute("searchMap", paramMap);

		String returnStr = "approve/reqTrip";

		if(paramMap.containsKey("popYn")){

			String popYn = paramMap.get("popYn").toString();

			if(popYn.equals("M")){
				model.addAttribute("popYn", popYn);
				model.addAttribute("selDate", paramMap.get("selDate"));
				model.addAttribute("projectId", paramMap.get("projectId"));
				model.addAttribute("activityId", paramMap.get("activityId"));
				model.addAttribute("projectName", paramMap.get("projectName"));
				returnStr+="/pop";
			}
		}
		return returnStr;
	}

	/**
	 *
	 * 경조신청 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqEvent"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/reqEvent.do")
	public String reqEvent(HttpSession session, ModelMap model, @RequestParam Map<String, Object> paramMap)
			throws Exception {

		logger.info("appv Event create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		// 기본 정보를 셋팅한다.
		paramMap.put("appvDocClass", "EVENT");
		paramMap.put("appvDocType", "EVENT");

		// 경조사 분류코드를 조회한다
		List<EgovMap> familyEventsIdList = approveService.familyEventsIdList(paramMap);

		model.addAttribute("familyEventsIdList", familyEventsIdList);

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);

		model.addAttribute("searchMap", paramMap);

		return "approve/reqEvent";
	}

	/**
	 *
	 * 휴직신청 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqRest"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 12. 02.
	 */
	@RequestMapping(value = "/approve/reqRest.do")
	public String reqRest(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv Rest create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		// 기본 정보를 셋팅한다.
		paramMap.put("appvDocClass", "REST");
		paramMap.put("appvDocType", "REST");

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);

		model.addAttribute("searchMap", paramMap);
		return "approve/reqRest";
	}

	/**
	 *
	 * 기본양식작성 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqBasic"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 12. 02.
	 */
	@RequestMapping(value = "/approve/reqBasic.do")
	public String reqBasic(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv Basic create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		// 기본 정보를 셋팅한다.
		paramMap.put("appvDocClass", "BASIC");
		paramMap.put("appvDocType", "BASIC");

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);

		model.addAttribute("searchMap", paramMap);

		String returnStr = "approve/reqBasic";

		if(paramMap.containsKey("popYn")){

			String popYn = paramMap.get("popYn").toString();

			if(popYn.equals("M")){
				model.addAttribute("popYn", popYn);
				model.addAttribute("selDate", paramMap.get("selDate"));
				model.addAttribute("projectId", paramMap.get("projectId"));
				model.addAttribute("activityId", paramMap.get("activityId"));
				model.addAttribute("projectName", paramMap.get("projectName"));

				returnStr+="/pop";
			}
		}
		return returnStr;
	}

	/**
	 *
	 * 지출결의서작성 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqExpense"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/reqExpense.do")
	public String reqExpense(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv Expense create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// 기본 정보를 셋팅한다.
		paramMap.put("appvDocClass", "EXPENSE");
		paramMap.put("appvDocType", "EXPENSE");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());

		// 지출결의서설정
		EgovMap appvReceiverSetup = approveSetService.getAppvExpenseSetupDetail(paramMap);

		// 지출담당자설정 목록
		List<EgovMap> appvManagerSetupList = approveSetService.getAppvManagerSetupList(paramMap);

		// 지출일설정 목록
		List<EgovMap> appvDaySetupList = approveSetService.getAppvDaySetupList(paramMap);

		model.addAttribute("appvReceiverSetup", appvReceiverSetup);
		model.addAttribute("appvManagerSetupList", appvManagerSetupList);
		model.addAttribute("appvDaySetupList", appvDaySetupList);

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);

		model.addAttribute("searchMap", paramMap);

		String returnStr = "approve/reqExpense";

		if(paramMap.containsKey("popYn")){

			String popYn = paramMap.get("popYn").toString();

			if(popYn.equals("M")){
				model.addAttribute("popYn", popYn);
				model.addAttribute("selDate", paramMap.get("selDate"));
				model.addAttribute("projectId", paramMap.get("projectId"));
				model.addAttribute("activityId", paramMap.get("activityId"));
				model.addAttribute("projectName", paramMap.get("projectName"));
				returnStr+="/pop";
			}
		}
		return returnStr;
	}

	/**
	 *
	 * 사내서식 작성 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqCompany"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/reqCompany.do")
	public String reqCompany(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv Company create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		String popYn = "N";
		String returnStr = "approve/reqCompany";
		if (paramMap.containsKey("popYn"))
			popYn = paramMap.get("popYn").toString();
		// 기본 정보를 셋팅한다.
		paramMap.put("appvDocClass", "COMPANY");

		if (!popYn.equals("Y")) {
			EgovMap companyFormMap = approveService.getCompanyFormInfo(paramMap);

			model.addAttribute("companyFormMap", companyFormMap);

			// 종결전 문서열람 정보를 조회한다 : S
			paramMap.put("appvCompanyFormId", companyFormMap.get("appvCompanyFormId"));
			EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);

			model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);
			// 사내서식 user열람 정보를 저장
			approveService.updateCompanyFormReadUserId(paramMap);

			if(popYn.equals("M")){
				model.addAttribute("popYn", popYn);
				model.addAttribute("selDate", paramMap.get("selDate"));
				model.addAttribute("projectId", paramMap.get("projectId"));
				model.addAttribute("activityId", paramMap.get("activityId"));
				model.addAttribute("projectName", paramMap.get("projectName"));
				returnStr = returnStr + "/pop";

			}

		} else {
			model.addAttribute("companyFormMap", paramMap);
			returnStr = returnStr + "/pop";


		}
		// 종결전 문서열람 정보를 조회한다 : E

		model.addAttribute("searchMap", paramMap);


		return returnStr;
	}

	/**
	 *
	 * 기본 양식 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertBasicApprove.do")
	public void insertBasicApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId, ApproveVoList appVoList)
			throws Exception {

		logger.info("appv insert Basic ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);

		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			for (int i = 0; i < fileSeq.length; i++) {
				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}

		approveService.insertBasicApprove(paramMap, fileList, appVoList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 기본양식 수정
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/modifyBasicApprove.do")
	public void modifyBasicApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "delFileList", required = false) String[] delFileList, // 삭제
																							// 파일목록
																							// (리스트페이지에서만.)
			ApproveVoList appVoList) throws Exception {

		logger.info("appv modify Basic ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());
		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();

		if (fileSeq != null) {// 공통처리로직
			Loop1: for (int i = 0; i < fileSeq.length; i++) {

				// 삭제 대상에 있다면 제외한다.
				if (delFileList != null) {
					for (int j = 0; j < delFileList.length; j++) {
						if (delFileList[j].equals(fileSeq[i]))
							continue Loop1;
					}
				}
				// 기존에 있는파일은 제외한다.
				if (!fileSeq[i].equals("0"))
					continue;

				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		approveService.modifyBasicApprove(paramMap, fileList, delFileList, appVoList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 보고서양식작성 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqBasic"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 12. 02.
	 */
	@RequestMapping(value = "/approve/reqReport.do")
	public String reqReport(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv report Create page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		// 기본 정보를 셋팅한다.
		paramMap.put("appvDocClass", "REPORT");
		paramMap.put("appvDocType", "REPORT");

		// 종결전 문서열람 정보를 조회한다 : S
		EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);
		model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);
		model.addAttribute("searchMap", paramMap);

		String returnStr = "approve/reqReport";

		if(paramMap.containsKey("popYn")){

			String popYn = paramMap.get("popYn").toString();

			if(popYn.equals("M")){
				model.addAttribute("popYn", popYn);
				model.addAttribute("selDate", paramMap.get("selDate"));
				model.addAttribute("projectId", paramMap.get("projectId"));
				model.addAttribute("activityId", paramMap.get("activityId"));
				model.addAttribute("projectName", paramMap.get("projectName"));
				returnStr+="/pop";
			}
		}
		return returnStr;
	}

	/**
	 *
	 * 보고서 양식 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertReportApprove.do")
	public void insertReportApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId, ApproveVoList appVoList)
			throws Exception {

		logger.info("appv insert Report ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);

		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			for (int i = 0; i < fileSeq.length; i++) {
				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}

		approveService.insertBasicApprove(paramMap, fileList, appVoList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 보고서양식 수정
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/modifyReportApprove.do")
	public void modifyReportApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "delFileList", required = false) String[] delFileList, // 삭제
																							// 파일목록
																							// (리스트페이지에서만.)
			ApproveVoList appVoList) throws Exception {

		logger.info("appv modify Report ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());
		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();

		if (fileSeq != null) {// 공통처리로직
			Loop1: for (int i = 0; i < fileSeq.length; i++) {

				// 삭제 대상에 있다면 제외한다.
				if (delFileList != null) {
					for (int j = 0; j < delFileList.length; j++) {
						if (delFileList[j].equals(fileSeq[i]))
							continue Loop1;
					}
				}
				// 기존에 있는파일은 제외한다.
				if (!fileSeq[i].equals("0"))
					continue;

				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		approveService.modifyBasicApprove(paramMap, fileList, delFileList, appVoList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 휴가 품의서 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertVacApprove.do")
	public void insertApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId) throws Exception {

		logger.info("appv insert Vac ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);

		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		approveService.insertVacApprove(paramMap);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 사내서식 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertCompanyApprove.do")
	public void insertCompanyApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize, ApproveVoList appVoList)
			throws Exception {

		logger.info("appv insert Company ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		// 참조자
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		// 수신자
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			for (int i = 0; i < fileSeq.length; i++) {
				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}
		}

		approveService.insertCompanyApprove(paramMap, fileList, appVoList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 사내서식 수정
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/modifyCompanyApprove.do")
	public void modifyCompanyApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize, ApproveVoList appVoList,
			@RequestParam(value = "delFileList", required = false) String[] delFileList // 삭제
																						// 파일목록
																						// (리스트페이지에서만.)
	) throws Exception {

		logger.info("appv insert Company ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		// 참조자
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		// 수신자
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			Loop1: for (int i = 0; i < fileSeq.length; i++) {

				// 삭제 대상에 있다면 제외한다.
				if (delFileList != null) {
					for (int j = 0; j < delFileList.length; j++) {
						if (delFileList[j].equals(fileSeq[i]))
							continue Loop1;
					}
				}
				// 기존에 있는파일은 제외한다.
				if (!fileSeq[i].equals("0"))
					continue;

				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}

		approveService.updateCompanyApprove(paramMap, fileList, appVoList, delFileList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 출장 품의서 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertTripApprove.do")
	public void insertTripApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "tripWorkerId", required = false) String[] tripWorkerId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "tripType", required = false) String[] tripType,
			@RequestParam(value = "tripMemo", required = false) String[] tripMemo,
			@RequestParam(value = "price", required = false) String[] price) throws Exception {

		logger.info("appv insert Trip ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		if (tripWorkerId != null)
			paramMap.put("entryId", tripWorkerId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		if (tripType != null) {
			paramMap.put("tripType", tripType);
			paramMap.put("tripMemo", tripMemo);
			paramMap.put("price", price);
		}
		approveService.insertTripApprove(paramMap);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 출장 품의서 수정
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/modifyTripApprove.do")
	public void modifyTripApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "tripWorkerId", required = false) String[] tripWorkerId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "tripType", required = false) String[] tripType,
			@RequestParam(value = "tripMemo", required = false) String[] tripMemo,
			@RequestParam(value = "price", required = false) String[] price) throws Exception {

		logger.info("appv modify Trip ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		if (tripWorkerId != null)
			paramMap.put("entryId", tripWorkerId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		if (tripType != null) {
			paramMap.put("tripType", tripType);
			paramMap.put("tripMemo", tripMemo);
			paramMap.put("price", price);
		}
		approveService.modifyTripApprove(paramMap);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 휴가품의서수정
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/updateVacApprove.do"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/updateVacApprove.do")
	public void modifyVacApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId) throws Exception {

		logger.info("appv modify Vac ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		approveService.updateVacApprove(paramMap);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 구매 품의서 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertPurchaseApprove.do")
	public void insertPurchaseApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap, @RequestParam(value = "itemNm") String[] itemNm,
			@RequestParam(value = "price") String[] price, @RequestParam(value = "qty") String[] qty,
			@RequestParam(value = "purMemo") String[] purMemo,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize) throws Exception {

		logger.info("appv insert Purchase ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		paramMap.put("itemNm", itemNm);
		paramMap.put("price", price);
		paramMap.put("qty", qty);
		paramMap.put("purMemo", purMemo);


		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);

		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);


		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			for (int i = 0; i < fileSeq.length; i++) {
				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}

		approveService.insertPurchaseApprove(paramMap, fileList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 지출결의서 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertExpenseApprove.do")
	public void insertExpenseApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap, @RequestParam(value = "expenseDate") String[] expenseDate,
			@RequestParam(value = "paymentType") String[] paymentType,
			@RequestParam(value = "summary") String[] summary,
			@RequestParam(value = "expenseTypeStr") String[] expenseTypeStr,
			@RequestParam(value = "expenseAmount") String[] expenseAmount,
			@RequestParam(value = "comment") String[] comment,
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId, ApproveVoList appVoList)
			throws Exception {

		logger.info("appv insert Purchase ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		paramMap.put("expenseDate", expenseDate);
		paramMap.put("paymentType", paymentType);
		paramMap.put("summary", summary);
		paramMap.put("expenseTypeStr", expenseTypeStr);
		paramMap.put("expenseAmount", expenseAmount);
		paramMap.put("comment", comment);

		// 참조자
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		// 수신자
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			for (int i = 0; i < fileSeq.length; i++) {
				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}

		approveService.insertExpenseApprove(paramMap, fileList, appVoList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 경조사 품의서 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertEventApprove.do")
	public void insertEventApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize) throws Exception {

		logger.info("appv insert Event ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			for (int i = 0; i < fileSeq.length; i++) {
				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);

		approveService.insertEventApprove(paramMap, fileList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

		// Map chkEnabelApproveMap = chkEnabelApproveMap(paramMap);

		/*
		 * if(chkEnabelApproveMap==null){ //파일리스트 List<Map<String , Object>>
		 * fileList = new ArrayList<Map<String,Object>>();
		 * if(fileSeq!=null){//공통처리로직 for(int i = 0 ; i < fileSeq.length;i++){
		 * //파일정보 맵 Map<String , Object> fileMap = new HashMap<String,
		 * Object>(); fileMap.put("fileSeq",fileSeq[i]);
		 * fileMap.put("orgFileNm",orgFileNm[i]);
		 * fileMap.put("newFileNm",newFileNm[i]);
		 * fileMap.put("filePath",filePath[i]);
		 * fileMap.put("fileSize",fileSize[i]);
		 * fileMap.put("uploadType",paramMap.get("appvDocClass").toString());
		 *
		 * fileList.add(fileMap); }
		 *
		 * } if(approveCcId != null) paramMap.put("approveCcId", approveCcId);
		 * approveService.insertEventApprove(paramMap,fileList);
		 *
		 *
		 *
		 * obj.put("result", "SUCCESS"); obj.put("appvDocId",
		 * paramMap.get("appvDocId").toString());
		 *
		 * AjaxResponse.responseAjaxObject(response, obj); //"SUCCESS" 전달 }else{
		 * AjaxResponse.responseAjaxObject(response, chkEnabelApproveMap);
		 * //"SUCCESS" 전달 }
		 */

	}

	/**
	 *
	 * 지출결의서 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/modifyExpenseApprove.do")
	public void modifyExpenseApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap, @RequestParam(value = "expenseDate") String[] expenseDate,
			@RequestParam(value = "paymentType") String[] paymentType,
			@RequestParam(value = "summary") String[] summary,
			@RequestParam(value = "expenseTypeStr") String[] expenseTypeStr,
			@RequestParam(value = "expenseAmount") String[] expenseAmount,
			@RequestParam(value = "comment") String[] comment,
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId, ApproveVoList appVoList,
			@RequestParam(value = "delFileList", required = false) String[] delFileList // 삭제
																						// 파일목록
																						// (리스트페이지에서만.)
	) throws Exception {

		logger.info("appv insert Purchase ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		paramMap.put("expenseDate", expenseDate);
		paramMap.put("paymentType", paymentType);
		paramMap.put("summary", summary);
		paramMap.put("expenseTypeStr", expenseTypeStr);
		paramMap.put("expenseAmount", expenseAmount);
		paramMap.put("comment", comment);

		// 참조자
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		// 수신자
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			Loop1: for (int i = 0; i < fileSeq.length; i++) {

				// 삭제 대상에 있다면 제외한다.
				if (delFileList != null) {
					for (int j = 0; j < delFileList.length; j++) {
						if (delFileList[j].equals(fileSeq[i]))
							continue Loop1;
					}
				}
				// 기존에 있는파일은 제외한다.
				if (!fileSeq[i].equals("0"))
					continue;

				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}

		approveService.updateExpenseApprove(paramMap, fileList, appVoList, delFileList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 경조사 품의서 수정
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/modifyEventApprove.do")
	public void modifyEventApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "delFileList", required = false) String[] delFileList // 삭제
																						// 파일목록
																						// (리스트페이지에서만.)
	) throws Exception {

		logger.info("appv modify Event ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());
		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			Loop1: for (int i = 0; i < fileSeq.length; i++) {

				// 삭제 대상에 있다면 제외한다.
				if (delFileList != null) {
					for (int j = 0; j < delFileList.length; j++) {
						if (delFileList[j].equals(fileSeq[i]))
							continue Loop1;
					}
				}
				// 기존에 있는파일은 제외한다.
				if (!fileSeq[i].equals("0"))
					continue;

				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		approveService.modifyEventApprove(paramMap, fileList, delFileList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 교육 품의서 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertEduApprove.do")
	public void insertEduApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "eduWorkerId", required = false) String[] eduWorkerId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize) throws Exception {

		logger.info("appv insert Edu ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			for (int i = 0; i < fileSeq.length; i++) {
				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		if (eduWorkerId != null)
			paramMap.put("entryId", eduWorkerId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		approveService.insertEducationApprove(paramMap, fileList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 교육 품의서 수정
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/modifyEduApprove.do")
	public void modifyEduApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "eduWorkerId", required = false) String[] eduWorkerId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "delFileList", required = false) String[] delFileList // 삭제
																						// 파일목록
																						// (리스트페이지에서만.)
	) throws Exception {

		logger.info("appv modify Edu ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());
		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();

		if (fileSeq != null) {// 공통처리로직
			Loop1: for (int i = 0; i < fileSeq.length; i++) {

				// 삭제 대상에 있다면 제외한다.
				if (delFileList != null) {
					for (int j = 0; j < delFileList.length; j++) {
						if (delFileList[j].equals(fileSeq[i]))
							continue Loop1;
					}
				}
				// 기존에 있는파일은 제외한다.
				if (!fileSeq[i].equals("0"))
					continue;

				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}
		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);
		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);
		if (eduWorkerId != null)
			paramMap.put("entryId", eduWorkerId);
		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		approveService.modifyEducationApprove(paramMap, fileList, delFileList);

		obj.put("result", "SUCCESS");
		obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 구매 품의서 수정
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/modifyPurchaseApprove.do")
	public void modifyPurchaseApprove(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap, @RequestParam(value = "itemNm") String[] itemNm,
			@RequestParam(value = "price") String[] price, @RequestParam(value = "qty") String[] qty,
			@RequestParam(value = "purMemo") String[] purMemo,
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId,
			@RequestParam(value = "refDocIdStr", required = false) String[] refDocIdStr, // 연결문서
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "delFileList", required = false) String[] delFileList // 삭제
																						// 파일목록
																						// (리스트페이지에서만.)
	) throws Exception {

		logger.info("appv modify Purchase ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptId", baseUserLoginInfo.get("deptId").toString());
		paramMap.put("itemNm", itemNm);
		paramMap.put("price", price);
		paramMap.put("qty", qty);
		paramMap.put("purMemo", purMemo);

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		if (fileSeq != null) {// 공통처리로직
			Loop1: for (int i = 0; i < fileSeq.length; i++) {

				// 삭제 대상에 있다면 제외한다.
				if (delFileList != null) {
					for (int j = 0; j < delFileList.length; j++) {
						if (delFileList[j].equals(fileSeq[i]))
							continue Loop1;
					}
				}
				// 기존에 있는파일은 제외한다.
				if (!fileSeq[i].equals("0"))
					continue;

				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}

		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);

		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		// 연결문서
		if (refDocIdStr != null)
			paramMap.put("refDocIdStr", refDocIdStr);
		approveService.updatePurchaseApprove(paramMap, fileList, delFileList);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 기안문서 //결재문서//참조문서 상세화면으로 이동한다.
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/getApproveDetail"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/getApproveDrfDetail.do", "/approve/getApproveTempDetail.do",
			"/approve/getApproveReqDetail.do", "/approve/getApproveRefDetail.do", "/approve/getApproveRcDetail.do",
			"/approve/getApproveCancelDetail.do", "/approve/approvePendDetail.do", "/approve/approveProxyDetail.do",
			"/approve/approveNextDetail.do", "/approve/approvePreviousDetail.do","/approve/approveExpenseDetail.do","/approve/approveAllDetail.do" })
	public String getApproveDetail(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model)
			throws Exception {

		logger.info("appv detail page ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		EgovMap detailMap = approveService.getApproveDetail(paramMap);
		model.addAttribute("detailMap", detailMap);

		paramMap.put("appvHeaderId", detailMap.get("appvHeaderId"));
		paramMap.put("docStatus", detailMap.get("docStatus"));
		paramMap.put("appvDocClass", detailMap.get("appvDocClass"));

		String individualYn = detailMap.get("individualYn").toString();

		if (individualYn.equals("Y")) {
			model.addAttribute("approveLineMap", approveService.getApproveLineIndividual(paramMap));
		} else {

			model.addAttribute("approveLineMap", approveService.getApproveLine(paramMap));
		}

		model.addAttribute("searchMap", paramMap);

		// 의견
		if (!detailMap.get("docStatus").toString().equals("WORKING")) {
			model.addAttribute("commentList", approveService.getApproveProcessComment(paramMap));
		} else {
			paramMap.put("docStatus", detailMap.get("docStatus"));
			// 필수 수신자
			paramMap.put("userRoleType", "CC");
			paramMap.put("approveCcType", detailMap.get("approveCcType"));
			List<EgovMap> ccSetupList = approveSetService.getOrgReceiverSetupList(paramMap);
			if (ccSetupList != null && ccSetupList.size() > 0)
				model.addAttribute("ccSetupList", ccSetupList);
			// 필수 참조자
			paramMap.put("userRoleType", "RECEIVER");
			paramMap.put("approveRcType", detailMap.get("approveRcType"));
			List<EgovMap> receiverSetupList = approveSetService.getOrgReceiverSetupList(paramMap);
			if (receiverSetupList != null && receiverSetupList.size() > 0)
				model.addAttribute("receiverSetupList", receiverSetupList);
		}

		String returnStr = "approve/approveDocDetail";

		if (paramMap.containsKey("approveDetailPopYn")) {
			String approveDetailPopYn = paramMap.get("approveDetailPopYn").toString();
			if (approveDetailPopYn.equals("Y")) {
				returnStr = returnStr + "/pop";
				model.addAttribute("popYn", "Y");
			}else if(approveDetailPopYn.equals("A")){
				returnStr = returnStr + "/pop";
				model.addAttribute("popYn", "A");
			}else if(approveDetailPopYn.equals("M")){
				returnStr = returnStr + "/pop";
				model.addAttribute("popYn", "M");
			}
		}else if(paramMap.containsKey("popYn")){

			String popYn = paramMap.get("popYn").toString();

			if(!popYn.equals("")){
				returnStr = returnStr + "/pop";
				model.addAttribute("popYn", paramMap.get("popYn"));
			}
		}
		return returnStr;

	}

	/**
	 *
	 * 기안문서 삭제한다
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/deleteApproveDoc.do")
	public void deleteApproveDoc(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("appv del doc ......" + paramMap.get("appvDocId"));

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		approveService.deleteApproveDoc(paramMap);

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();
		obj.put("result", "SUCCESS");
		// obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 기안문서 수정화면으로 이동한다.
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/modifyApprovePage"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/modifyApproveDocPage.do", "approve/approveBookmarkForm.do" })
	public String modifyApprovePage(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model)
			throws Exception {

		logger.info("appv modify page ......" + paramMap.get("appvDocId"));

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		EgovMap detailMap = approveService.getApproveDetail(paramMap);
		model.addAttribute("detailMap", detailMap);

		String appvDocClass = detailMap.get("appvDocClass").toString();

		model.addAttribute("searchMap", paramMap);

		// 결재 라인을 조회한다.
		paramMap.put("appvHeaderId", detailMap.get("appvHeaderId"));
		String individualYn = detailMap.get("individualYn").toString();

		if (individualYn.equals("Y")) {
			model.addAttribute("approveLineMap", approveService.getApproveLineIndividual(paramMap));

			List<Map> approveLineList = approveService.selectApproveLineListIndividual(paramMap);
			model.addAttribute("approveLineList", approveLineList);

			/*
			 ******************************************* 결재라인 직접선택을 위한 로직 : S
			 */
			// 공통코드
			Map cmmCdCategoryListCodeMap = new HashMap();
			// 승인방식
			cmmCdCategoryListCodeMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
			cmmCdCategoryListCodeMap.put("codeSetNm", "APPV_CLASS");
			model.addAttribute("cmmCdAppvClassList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

			// 결재유형
			cmmCdCategoryListCodeMap.put("codeSetNm", "APPV_LINE_TYPE");
			model.addAttribute("cmmCdAppvLineTypeList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));
			/*
			 ******************************************* 결재라인 직접선택을 위한 로직 : E
			 */

		} else {

			model.addAttribute("approveLineMap", approveService.getApproveLine(paramMap));
		}

		String returnStr ="";
		// 휴가품의서 디테일
		if (appvDocClass.equals("VACATION")) {
			Calendar now = Calendar.getInstance();
			paramMap.put("year", now.get(Calendar.YEAR));
			// 연차정보를 조회한다.
			/*
			 * EgovMap userHolidaySumMap =
			 * approveService.getUserHolidaySum(paramMap);
			 *
			 * model.addAttribute("userHolidaySumMap", userHolidaySumMap);
			 */

			returnStr = "approve/modifyApproveVacation";
		} else if (appvDocClass.equals("BUY")) {
			returnStr = "approve/modifyApprovePurchase";
		} else if (appvDocClass.equals("EDUCATION")) {/////// ps
			returnStr = "approve/modifyApproveEducation";
		} else if (appvDocClass.equals("TRIP")) {/////// ps
			returnStr = "approve/modifyApproveTrip";
		} else if (appvDocClass.equals("EVENT")) {/////// ps
			// 경조사 분류코드를 조회한다
			List<EgovMap> familyEventsIdList = approveService.familyEventsIdList(paramMap);

			model.addAttribute("familyEventsIdList", familyEventsIdList);
			returnStr = "approve/modifyApproveEvent";
		} else if (appvDocClass.equals("REST")) {/////// ps
			returnStr = "approve/modifyApproveRest";
		} else if (appvDocClass.equals("BASIC")) {/////// ps
			returnStr = "approve/modifyApproveBasic";
		} else if (appvDocClass.equals("REPORT")) {/////// ps
			returnStr = "approve/modifyApproveReport";
		} else if (appvDocClass.equals("EXPENSE")) {
			// 지출결의서설정
			EgovMap appvReceiverSetup = approveSetService.getAppvExpenseSetupDetail(paramMap);

			// 지출담당자설정 목록
			List<EgovMap> appvManagerSetupList = approveSetService.getAppvManagerSetupList(paramMap);

			// 지출일설정 목록
			List<EgovMap> appvDaySetupList = approveSetService.getAppvDaySetupList(paramMap);

			model.addAttribute("appvReceiverSetup", appvReceiverSetup);
			model.addAttribute("appvManagerSetupList", appvManagerSetupList);
			model.addAttribute("appvDaySetupList", appvDaySetupList);

			returnStr = "approve/modifyApproveExpense";
		} else if (appvDocClass.equals("COMPANY")) {

			// 기본 정보를 셋팅한다.
			paramMap.put("appvDocClass", "COMPANY");

			paramMap.put("appvCompanyFormId", detailMap.get("appvCompanyFormId"));

			EgovMap companyFormMap = approveService.getCompanyFormInfo(paramMap);

			model.addAttribute("companyFormMap", companyFormMap);

			// 종결전 문서열람 정보를 조회한다 : S
			paramMap.put("appvCompanyFormId", companyFormMap.get("appvCompanyFormId"));
			EgovMap appvReadDocSetupMap = approveService.getAppvReadDocSetup(paramMap);

			model.addAttribute("appvReadDocSetupMap", appvReadDocSetupMap);
			returnStr = "approve/modifyApproveCompany";
		}

		if(paramMap.containsKey("popYn")){

			String popYn = paramMap.get("popYn").toString();

			if(popYn.equals("M")){
				model.addAttribute("popYn", popYn);
				model.addAttribute("selDate", paramMap.get("selDate"));
				model.addAttribute("projectId", paramMap.get("projectId"));
				model.addAttribute("activityId", paramMap.get("activityId"));
				model.addAttribute("projectName", paramMap.get("projectName"));
				model.addAttribute("listType", paramMap.get("listType"));
				returnStr+="/pop";
			}
		}
		return returnStr;

	}

	/**
	 *
	 * 기안문서 리스트/승인취소리스트
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/draftDocList.do", "/approve/tempDocList.do" })
	public String draftDocList(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		String url = request.getRequestURI();

		String type = url.indexOf("draftDocList.do") > 0 ? "draft" : "temp";

		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();
		paramMap.put("orgId", orgId);
		paramMap.put("applyOrgId",applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}


		model.addAttribute("listType", type);

		if (type.equals("draft")) {
			// 기안문서 summary
			//model.addAttribute("draftSummary", approveService.getDraftSummary(paramMap));
			paramMap.put("approveDraftIngYn", "Y");
		} else {
			paramMap.put("approveDraftIngYn", "N");
		}

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> draftDocList = approveService.getDraftDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("draftDocList", draftDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", paramMap);
		return "approve/draftDocList";
	}

	/**
	 *
	 * 기안문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/draftDocListAjax.do" })
	public String draftDocListAjax(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		String returnStr = "approve/include/draftDocList_INC/inc";

		model.addAttribute("listType", paramMap.get("listType"));
		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		if (paramMap.containsKey("listType")) {
			String listType = paramMap.get("listType").toString();

			if (listType.equals("draft"))
				paramMap.put("approveDraftIngYn", "Y");
			else
				paramMap.put("approveDraftIngYn", "N");
		}

		List<EgovMap> draftDocList = approveService.getDraftDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("draftDocList", draftDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		return returnStr;
	}

	/**
	 *
	 * 결재요청 리스트
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/approveReqList.do", "/approve/approveProxyList.do",
			"/approve/approvePendList.do", "approve/approveNextList.do", "approve/approvePreviousList.do" ,"approve/approveAllList.do"})
	public String approveReqList(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();

		paramMap.put("orgId", orgId);
		paramMap.put("applyOrgId", applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}

		String url = request.getRequestURI();
		String type = "";
		if (url.indexOf("approvePendList.do") > 0)
			type = "pendList"; // 미결
		else if (url.indexOf("approveReqList.do") > 0)
			type = "reqList"; // 기결
		else if (url.indexOf("approveProxyList.do") > 0)
			type = "proxyList"; // 대결
		else if (url.indexOf("approveNextList.do") > 0)
			type = "nextList"; // 후결
		else if (url.indexOf("approvePreviousList.do") > 0)
			type = "previous"; // 선열
		else if (url.indexOf("approveAllList.do") > 0){
			type = "allList"; // 전체보기
			paramMap.put("secretYn", "A");
			paramMap.put("searchOrdId", baseUserLoginInfo.get("applyOrgId"));
		}

		paramMap.put("listType", type);

		// 기안문서 summary
		// model.addAttribute("reqSummary",
		// approveService.getReqSummary(paramMap));

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("useYn", "Y");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");
		if (type.equals("pendList") || type.equals("previous")|| type.equals("nextList")) {
			paramMap.put("newContentMarkClass", "APPV");
			if (type.equals("pendList")|| type.equals("nextList"))
				paramMap.put("newContentMarkType", "APPROVER");
			else if (type.equals("previous"))
				paramMap.put("newContentMarkType", "PREVIOUS");

			List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

			if (markRuleList != null && markRuleList.size() == 1) {

				EgovMap ruleMap = markRuleList.get(0);
				paramMap.put("ruleUseYn", "Y");
				paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
				paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));
			}

		}

		List<EgovMap> reqDocList = approveService.getReqDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("reqDocList", reqDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", paramMap);
		return "approve/approveReqList";
	}

	/**
	 *
	 * 결재문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/approveReqDocListAjax.do" })
	public String approveReqDocListAjax(HttpSession session, Model model, @RequestParam Map<String, Object> paramMap)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "APPROVER");
		paramMap.put("useYn", "Y");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));
		}

		String listType = paramMap.get("listType").toString();

		if(listType.equals("allList")) paramMap.put("secretYn", "A");

		List<EgovMap> reqDocList = approveService.getReqDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("reqDocList", reqDocList);

		model.addAttribute("searchMap", paramMap);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		return "approve/include/approveReqList_INC/inc";
	}

	/**
	 *
	 * 취소승인 리스트
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/reqCancelList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/reqCancelList.do" })
	public String reqCancelList(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> cancelDocList = approveService.getCancelDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("cancelDocList", cancelDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", paramMap);
		return "approve/reqCancelList";
	}

	/**
	 *
	 * 취소승인 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/reqCancelListAjax.do" })
	public String reqCancelListAjax(HttpSession session, Model model, @RequestParam Map<String, Object> paramMap)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> cancelDocList = approveService.getCancelDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("cancelDocList", cancelDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		return "approve/include/reqCancelList_INC/inc";
	}

	/**
	 *
	 * 참조문서 리스트
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/approveRefList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/approveRefList.do")
	public String approveRefList(HttpSession session, Model model, @RequestParam Map<String, Object> paramMap)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();
		paramMap.put("orgId",orgId);
		paramMap.put("applyOrgId", applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}
		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "REFERENTIAL");
		paramMap.put("useYn", "Y");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);
		String readTimeYn = "N";
		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));

			readTimeYn = ruleMap.get("readTimeYn").toString();
		}

		List<EgovMap> refDocList = approveService.getRefDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("refDocList", refDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", paramMap);

		// 읽음처리 노출여부
		model.addAttribute("readTimeYn", readTimeYn);
		return "approve/approveRefList";
	}

	/**
	 *
	 * 참조문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/approveRefDocListAjax.do")
	public String approveRefDocListAjax(HttpSession session, Model model, @RequestParam Map<String, Object> paramMap)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "REFERENTIAL");
		paramMap.put("useYn", "Y");
		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

		String readTimeYn = "N";

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));

			readTimeYn = ruleMap.get("readTimeYn").toString();
		}
		List<EgovMap> refDocList = approveService.getRefDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("refDocList", refDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("readTimeYn", readTimeYn);
		return "approve/include/approveRefList_INC/inc";
	}

	/**
	 *
	 * 수신문서 리스트
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/approveRcList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/approveRcList.do" })
	public String approveRcList(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();

		paramMap.put("orgId", orgId);
		paramMap.put("applyOrgId", applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "RECEIVER");
		paramMap.put("useYn", "Y");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));
		}

		List<EgovMap> rcDocList = approveService.getRcDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("rcDocList", rcDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", paramMap);
		return "approve/approveRcList";
	}

	/**
	 *
	 * 수신문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/approveRcDocListAjax"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/approveRcDocListAjax.do")
	public String approveRcDocListAjax(HttpSession session, Model model, @RequestParam Map<String, Object> paramMap)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "RECEIVER");
		paramMap.put("useYn", "Y");
		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));
		}
		List<EgovMap> rcDocList = approveService.getRcDocList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("rcDocList", rcDocList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		return "approve/include/approveRcList_INC/inc";
	}

	/**
	 *
	 * 지출문서 리스트
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/approveRcList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "approve/approveExpenseList.do" })
	public String approveExpenseList(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();

		paramMap.put("orgId",orgId);
		paramMap.put("applyOrgId",applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> approveExpenseList = approveService.getAppvDocExpenseList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("approveExpenseList", approveExpenseList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", paramMap);
		return "approve/approveExpenseList";
	}

	/**
	 *
	 * 지출문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/approveRcDocListAjax"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/approveExpenseDocListAjax.do")
	public String approveExpenseDocListAjax(HttpSession session, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "RECEIVER");
		paramMap.put("useYn", "Y");
		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));
		}

		List<EgovMap> approveExpenseList = approveService.getAppvDocExpenseList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("approveExpenseList", approveExpenseList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		return "approve/include/approveExpenseList_INC/inc";
	}

	/**
	 *
	 * 품의서 상태변경 (다중)
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processDocSubmitAll.do")
	public void processDocSubmitAll(HttpSession session, @RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "chkedDoc", required = false) String[] chkedDoc, HttpServletResponse response)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("loginId", baseUserLoginInfo.get("loginId").toString());

		paramMap.put("docStatus", paramMap.get("processDocStatus"));

		paramMap.put("chkedDoc", chkedDoc);

		// paramMap.put("approveProcessId",paramMap.get("approveProcessId"));
		// 선택한 건수만큼 처리한다.
		for (int i = 0; i < chkedDoc.length; i++) {
			String chkedDocStr = chkedDoc[i];
			String[] chkedDocBuf = chkedDocStr.split("[|]");
			String appvDocId = chkedDocBuf[0];
			String appvDocClass = chkedDocBuf[1];
			String appvDocType = chkedDocBuf[2];
			String appvStatus = chkedDocBuf[3];
			String appvProcessId = chkedDocBuf[4];
			// String dateTo = chkedDocBuf[6];

			paramMap.put("appvDocId", appvDocId);
			paramMap.put("appvDocClass", appvDocClass);
			paramMap.put("appvDocType", appvDocType);
			paramMap.put("appvStatus", appvStatus);
			paramMap.put("appvProcessId", appvProcessId);
			if (chkedDocBuf.length > 6) {
				String dateTo = chkedDocBuf[6];
				paramMap.put("dateTo", dateTo);
			} else {
				paramMap.put("dateTo", "");
			}
			// paramMap.put("dateTo",dateTo);

			approveService.processDocStatus(paramMap);
		}

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");
		// obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 품의서 지급완료처리 (다중)
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processExpenseAll.do")
	public void processExpenseAll(HttpSession session, @RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "chkedDoc", required = false) String[] chkedDoc, HttpServletResponse response)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("loginId", baseUserLoginInfo.get("loginId").toString());

		paramMap.put("docStatus", paramMap.get("processDocStatus"));
		// 선택한 건수만큼 처리한다.
		for (int i = 0; i < chkedDoc.length; i++) {
			String chkedDocStr = chkedDoc[i];

			paramMap.put("appvDocId", chkedDocStr);

			paramMap.put("expensePayComment", "일괄지급처리");

			approveService.processExpenseYn(paramMap);
		}

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");
		// obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 품의서 상신
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processDocSubmit.do")
	public void processDocSubmit(HttpSession session, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();
		obj.put("isActivityValid", true);

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		String approveDocClass = paramMap.get("appvDocClass").toString();



		// 상신하려는 문서의 문서번호 사용여부를 조회한다
		String approveLineUseYn = approveService.appvDocNumUseChk(paramMap);
		if (approveLineUseYn.equals("Y")) {

			//EgovMap detailMap = approveService.getApproveDocDetail(paramMap);


			// 프로젝트 정보가 있다면 상신 시점에 유효한지 검사
			/*if (!approveDocClass.equals("BASIC")&&!approveDocClass.equals("REPORT")&&!approveDocClass.equals("VACATION")&&!approveDocClass.equals("EVENT")&&  detailMap.get("projectId") != null) {

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


				// 엑티비티가 상신시점에 유효한지 조회함다
				Map<String, String> searchMap = new HashMap<String, String>();
				searchMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
				searchMap.put("userId", baseUserLoginInfo.get("userId").toString());
				searchMap.put("type", "ACTIVITY");
				searchMap.put("projectId", paramMap.get("projectId").toString());
				searchMap.put("activityId", paramMap.get("activityId").toString());
				searchMap.put("incCardActivity", "N");
				searchMap.put("startDate", sdf.format(new Date()));

				if(approveDocClass.equals("EXPENSE")){
					searchMap.put("incCardActivity", "Y");
					searchMap.put("startDate",
					sdf.format((Date)detailMap.get("createDate")));
				}else{

					Date startDate = detailMap.get("dateFrom") == null?new Date():(Date)detailMap.get("dateFrom");

					searchMap.put("startDate",sdf.format(startDate));
				}

				List<Map> list = projectMgmtService.getBaseCommonProject(searchMap);

				if (list == null || list.size() == 0) {
					obj.put("isActivityValid", false);
				}
			}*/

			if ((Boolean) obj.get("isActivityValid")) {
				Integer cnt = approveService.processDocSubmit(paramMap);

				/*if(cnt!=null&&cnt==-1){
					obj.put("result", "FAIL");
					obj.put("msg", "전자결재를 위한 기본 정보가 등록 되어있지 않습니다.");
				}else{

					obj.put("result", "SUCCESS");
				}*/
				obj.put("result", "SUCCESS");
			} else {
				obj.put("result", "FAIL");
				obj.put("msg", "선택한 프로젝트정보가 조회되지 않습니다. 담당자에게 문의해주세요.");
			}
		} else {
			obj.put("result", "FAIL");
			obj.put("msg", "해당 문서품의는 사용할 수 없습니다. 담당자에게 문의해주세요.");
		}
		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 품의서 상태변경
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processDocStatus.do")
	public void processDocStatus(HttpSession session, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		approveService.processDocStatus(paramMap);

		Integer chkDupAppvReqUserCnt = approveService.getChkDupAppvReqUserCnt(paramMap);
		obj.put("chkDupAppvReqUserCnt", chkDupAppvReqUserCnt);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 품의서 코멘트입력
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processDocComment.do")
	public String processDocComment(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model,
			HttpServletResponse response) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		approveService.processDocComment(paramMap);

		model.addAttribute("commentList", approveService.getApproveProcessComment(paramMap));

		model.addAttribute("approveLineMap", approveService.getApproveLine(paramMap));

		return "approve/include/approveDocDetail_comment_INC/inc";
	}

	/**
	 *
	 * 경조사 날짜 리턴
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/insertApprove"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/getEventLastDay.do")
	public void getEventLastDay(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap

	) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		String selectedDateStr = paramMap.get("selectedDate").toString();

		Date selectedDate = DateUtil.getDate(selectedDateStr, "yyyy-MM-dd");
		paramMap.put("selectedDate", selectedDate);

		Integer period = Integer.parseInt(paramMap.get("period").toString());

		if (period > 0)
			period--;

		paramMap.put("period", period);
		EgovMap eventLastMap = approveService.getEventLastDay(paramMap);

		obj.put("result", "SUCCESS");
		obj.put("eventLastMap", eventLastMap);

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * dateFrom~dateTo 동안 승인대행자 / 동행자가 휴직상태라면 조회한다.
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/getChkAppointedPerson.do")
	public void getChkAppointedPerson(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "tripWorkerId", required = false) String[] tripWorkerId,
			@RequestParam(value = "eduWorkerId", required = false) String[] eduWorkerId

	) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");

		Map<String, String> msgMap = new HashMap<String, String>();

		List<String> userList = new ArrayList<String>();
		if (paramMap.get("appvAgencyId") != null && !paramMap.get("appvAgencyId").toString().equals("")) {
			userList.add(paramMap.get("appvAgencyId").toString());
			msgMap.put(paramMap.get("appvAgencyId").toString(), "승인대행자");
		}

		if (tripWorkerId != null && tripWorkerId.length > 0) {
			for (int i = 0; i < tripWorkerId.length; i++) {
				userList.add(tripWorkerId[i]);
				msgMap.put(tripWorkerId[i], "출장동행자");
			}
		}

		if (eduWorkerId != null && eduWorkerId.length > 0) {
			for (int i = 0; i < eduWorkerId.length; i++) {
				userList.add(eduWorkerId[i]);
				msgMap.put(eduWorkerId[i], "교육참여자");
			}
		}

		if (userList.size() > 0) {
			paramMap.put("userList", userList);

			obj = approveService.getChkAppointedPerson(paramMap, msgMap);
		}

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 메인화면 전체문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/mainAppvDocListAjax"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/mainAppvDocListAjax.do")
	public void mainAppvDocListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap

	) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 100;
		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> draftDocList = approveService.getAppvDocList(paramMap);

		AjaxResponse.responseAjaxObject(response, draftDocList); // "SUCCESS" 전달
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

	}

	/**
	 *
	 * 메인화면 기안문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/mainDraftDocListAjax"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/mainDraftDocListAjax.do")
	public void mainDraftDocListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap

	) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();
		paramMap.put("orgId",orgId);
		paramMap.put("applyOrgId",applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 100;
		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> draftDocList = approveService.getDraftDocList(paramMap);

		AjaxResponse.responseAjaxObject(response, draftDocList); // "SUCCESS" 전달
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

	}

	/**
	 *
	 * 메인 결재문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/mainReqDocListAjax"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/mainReqDocListAjax.do")
	public void mainReqDocListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();
		paramMap.put("orgId",orgId);
		paramMap.put("applyOrgId",applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}
		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 100;

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "APPROVER");
		paramMap.put("useYn", "Y");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));
		}
		List<EgovMap> reqDocList = approveService.getReqDocListForMain(paramMap);

		paramMap.put("recordCountPerPage", 100);

		AjaxResponse.responseAjaxObject(response, reqDocList); // "SUCCESS" 전달

		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

	}

	/**
	 *
	 * 참조문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/mainRefDocListAjax.do")
	public void mainRefDocListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();
		paramMap.put("orgId",orgId);
		paramMap.put("applyOrgId", applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}
		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 100;

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "REFERENTIAL");
		paramMap.put("useYn", "Y");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));
		}

		List<EgovMap> refDocList = approveService.getRefDocList(paramMap);

		paramMap.put("recordCountPerPage", 100);
		AjaxResponse.responseAjaxObject(response, refDocList); // "SUCCESS" 전달
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////
	}

	/**
	 *
	 * 참조문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/mainRcDocListAjax.do")
	public void mainRcDocListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");


		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();
		paramMap.put("orgId", orgId);
		paramMap.put("applyOrgId", applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}
		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 100;

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		paramMap.put("newContentMarkClass", "APPV");
		paramMap.put("newContentMarkType", "REFERENTIAL");
		paramMap.put("useYn", "Y");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		paramMap.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(paramMap);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			paramMap.put("ruleUseYn", "Y");
			paramMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			paramMap.put("markDayCnt", ruleMap.get("markDayCnt"));
		}

		List<EgovMap> refDocList = approveService.getRcDocList(paramMap);

		paramMap.put("recordCountPerPage", 100);
		AjaxResponse.responseAjaxObject(response, refDocList); // "SUCCESS" 전달
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////
	}

	/**
	 *
	 * 취소승인문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/mainCancelReqDocListAjax.do")
	public void mainCancelReqDocListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 100;

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> refDocList = approveService.getCancelDocList(paramMap);

		paramMap.put("recordCountPerPage", 100);
		AjaxResponse.responseAjaxObject(response, refDocList); // "SUCCESS" 전달
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////
	}

	/**
	 *
	 * 지출문서 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/mainExpenseDocListAjax.do")
	public void mainExpenseDocListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();
		paramMap.put("orgId", orgId);
		paramMap.put("applyOrgId",applyOrgId);
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}
		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호
		Integer recordCountPerPage = 100;

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> refDocList = approveService.getAppvDocExpenseList(paramMap);

		paramMap.put("recordCountPerPage", 100);
		AjaxResponse.responseAjaxObject(response, refDocList); // "SUCCESS" 전달
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////
	}

	/**
	 * 경조사 코드 등록 페이지
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : psj
	 * @date : 2016. 11. 28.
	 */
	@RequestMapping(value = "/approve/management/approveEventCode.do")
	public String memberList(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelMap model) throws Exception {

		// 메뉴 권한체크
		if (session.getAttribute("menuFilterStr").toString().indexOf("approve/management/approveEventCode") == -1) {
			return "redirect:/";
		}

		return "approve/approveEventCode";
	}

	/**
	 * 이벤트 코드 리스트
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : oys
	 * @date : 2015. 7. 20.
	 */
	@RequestMapping(value = "/approve/getEventCodeList.do")
	public void getEventCodeList(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String, Object> map) throws Exception {

		Map loginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", loginInfo.get("orgId").toString());
		map.put("applyOrgId", loginInfo.get("applyOrgId").toString());
		List<Map> list = approveService.getEventCodeList(map);

		AjaxResponse.responseAjaxSelect(response, list); // 결과전송
	}

	/**
	 * 이벤트 코드 등록
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : oys
	 * @date : 2015. 7. 20.
	 */
	@RequestMapping(value = "/approve/addEventCode.do")
	public String addEventCode(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String, Object> map) throws Exception {

		model.addAllAttributes(map); // 받은 파라미터 화면으로 그대로 전달.

		return "approve/addEventCode/pop";
	}

	/**
	 * 결재라인 변경
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : psj
	 * @date : 2016. 12. 01.
	 */
	@RequestMapping(value = "/approve/getApproveLineAjax.do")
	public String getApproveLineAjax(HttpServletRequest request, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		Map loginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", loginInfo.get("orgId").toString());
		map.put("userId", loginInfo.get("userId").toString());

		if (map.get("individualYn") != null) {
			String individualYn = map.get("individualYn").toString();

			if (individualYn.equals("Y")) {
				List<EgovMap> approveLineMap =approveService.getApproveLineIndividual(map);
				Integer approvalCnt = 0;
				for(EgovMap lineMap:approveLineMap){
					String appvClass = lineMap.get("appvClass").toString();
					if(appvClass.equals("APPROVAL")) approvalCnt++;
				}

				if(approvalCnt>0)
					model.addAttribute("approveLineMap", approveLineMap);
			} else {
				List<EgovMap> approveLineMap =approveService.getApproveLine(map);

				Integer approvalCnt = 0;
				for(EgovMap lineMap:approveLineMap){
					String appvClass = lineMap.get("appvClass").toString();
					if(appvClass.equals("APPROVAL")) approvalCnt++;
				}

				if(approvalCnt>0)
					model.addAttribute("approveLineMap", approveService.getApproveLine(map));
			}
		} else {

			// 결재 라인을 조회한다.
			List<EgovMap> approveLineMap = approveService.getApproveLine(map);

			Integer approvalCnt = 0;
			for(EgovMap lineMap:approveLineMap){
				String appvClass = lineMap.get("appvClass").toString();
				if(appvClass.equals("APPROVAL")) approvalCnt++;
			}
			if(approvalCnt>0)
				model.addAttribute("approveLineMap", approveLineMap);
		}



		return "approve/include/reqPageApproveLine_INC/inc";
	}

	/**
	 * 경조사 기준 저장
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : psj
	 * @date : 2016. 11. 29.
	 */
	@RequestMapping(value = "/approve/doSaveEventInfo.do")
	public void doSaveEventInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String, Object> map) throws Exception {

		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");

		LogUtil.printMap(map); // map console log

		// map.put("userSeq", loginUser.getUserId()); //user_id(sequence)
		map.put("userId", loginUser.get("userId").toString()); // user_id(sequence)
		map.put("orgId", loginUser.get("applyOrgId").toString()); // user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());

		String mode = map.get("mode").toString(); // 'new' or 'update'

		int upCnt = 0;
		if ("update".equals(mode)) {
			upCnt = approveService.updateEventInfo(map);
		} else { // "new"
			upCnt = approveService.insertEventInfo(map); // upCnt : 실제 넘어오는 값은
															// 메뉴아이디(menuId) 이다
		}

		AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송

	}

	/**
	 * 경조사 기준 삭제
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : psj
	 * @date : 2016. 11. 29.
	 */
	@RequestMapping(value = "/approve/deleteEventInfo.do")
	public void deleteEventInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String, Object> map) throws Exception {

		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");

		LogUtil.printMap(map); // map console log

		// map.put("userSeq", loginUser.getUserId()); //user_id(sequence)
		map.put("userId", loginUser.get("userId").toString()); // user_id(sequence)
		map.put("orgId", loginUser.get("applyOrgId").toString()); // user_id(sequence)
		map.put("applyOrgId", loginUser.get("applyOrgId").toString());

		Integer delCnt = approveService.deleteEventInfo(map);

		AjaxResponse.responseAjaxSave(response, delCnt); // 결과전송

	}

	/**
	 *
	 * 품의서 승인 취소 요청
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processApproveCancelReq.do")
	public void processApproveCancelReq(HttpSession session, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("loginId", baseUserLoginInfo.get("loginId").toString());
		approveService.processApproveCancelReq(paramMap);

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");
		// obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 품의서 취소 상태변경
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processDocStatusCancel.do")
	public void processDocStatusCancel(HttpSession session, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		// approveService.processDocStatus(paramMap);
		approveService.processDocStatusCancel(paramMap);

		obj.put("result", "SUCCESS");
		// obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 품의서 문서번호 화면
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/approveDocNumList.do")
	public String approveDocNumList(HttpSession session, Model model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		Map loginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", loginInfo.get("orgId").toString());
		map.put("applyOrgId", loginInfo.get("applyOrgId").toString());

		List<EgovMap> approveDocNumList = approveService.approveDocNumList(map);

		model.addAttribute("approveDocNumList", approveDocNumList);

		return "approve/approveDocNumList";
	}

	/**
	 *
	 * 품의서 문서번호 재조회
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/getAppvDocNumRuleAjax.do")
	public String getAppvDocNumRuleAjax(HttpSession session, Model model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		Map loginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", loginInfo.get("orgId").toString());
		map.put("applyOrgId", loginInfo.get("applyOrgId").toString());

		List<EgovMap> approveDocNumList = approveService.approveDocNumList(map);

		model.addAttribute("approveDocNumList", approveDocNumList);

		return "approve/include/approveDocNumList_INC/inc";
	}

	/**
	 *
	 * 품의서 문서번호 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processAppvDocNumRule.do")
	public void processAppvDocNumRule(HttpSession session, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		approveService.processAppvDocNumRule(paramMap);

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");
		// obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 품의서 수신확인
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processAppvRcAjax.do")
	public void processAppvRcAjax(HttpSession session, @RequestParam Map<String, Object> paramMap,
			HttpServletResponse response) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		Integer cnt = approveService.processAppvRc(paramMap);
		if (cnt > 0) {
			obj.put("result", "SUCCESS");
		} else if (cnt == -1) {
			obj.put("result", "FAIL");
			obj.put("msg", "이미 수신확인된 품의서 입니다.");
		} else {
			obj.put("result", "FAIL");
			obj.put("msg", "수신확인에 실패했습니다. 담당자에게 문의해주세요.");
		}
		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 수신확인 내역 팝업
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/getAppvDocReceiverPop.do")
	public String getAppvDocReceiverPop(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model)
			throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId"));
		List<EgovMap> rcReceiverList = approveService.getApproveRcList(paramMap);

		model.addAttribute("rcReceiverList", rcReceiverList);
		return "approve/pop/appvDocReceiverPop/pop";

	}

	/**
	 *
	 * 결재라인명 리스트 조회 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/getAppvHeaderListAjax.do")
	public void getAppvHeaderListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		List<EgovMap> appvHeaderList = approveService.getAppvHeaderList(paramMap);

		AjaxResponse.responseAjaxObject(response, appvHeaderList); // "SUCCESS"
																	// 전달
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////
	}

	/**
	 *
	 * 프로젝트 선택 팝업
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/getAppvProjectListPop.do")
	public String getAppvProjectListPop(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model)
			throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId"));
		paramMap.put("userId", baseUserLoginInfo.get("userId"));

		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		model.addAttribute("paginationInfo", paginationInfo);
		List<EgovMap> appvProjectList = projectMgmtService.getAppvProjectList(paramMap);

		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("appvProjectList", appvProjectList);

		return "approve/pop/appvProjectListPop/pop";

	}

	/**
	 *
	 * 프로젝트 선택 팝업
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/getAppvProjectListPopAjax.do")
	public String getAppvProjectListPopAjax(HttpSession session, @RequestParam Map<String, Object> paramMap,
			Model model) throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId"));
		paramMap.put("userId", baseUserLoginInfo.get("userId"));

		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		model.addAttribute("paginationInfo", paginationInfo);
		List<EgovMap> appvProjectList = projectMgmtService.getAppvProjectList(paramMap);

		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("appvProjectList", appvProjectList);
		return "approve/include/appvProjectListPop_INC/inc";

	}

	/**
	 *
	 * 보고서 - 일정 선택 팝업
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/getAppvScheduleListPop.do")
	public String getAppvScheduleListPop(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model)
			throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		Integer weekNum = cal.get(Calendar.WEEK_OF_YEAR);

		Integer year = cal.get(Calendar.YEAR);

		paramMap.put("orgId", baseUserLoginInfo.get("orgId"));
		paramMap.put("userId", baseUserLoginInfo.get("userId"));
		paramMap.put("sabun", baseUserLoginInfo.get("empNo"));

		paramMap.put("sessionUserId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptLevel", baseUserLoginInfo.get("deptLevel").toString());
		paramMap.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());

		paramMap.put("weekNum", weekNum);
		paramMap.put("year", year);

		// 조회한 주차의 시작일(월)~(일) 구하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar searchDateBuf = Calendar.getInstance();
		searchDateBuf.set(Calendar.YEAR, year);
		searchDateBuf.set(Calendar.WEEK_OF_YEAR, weekNum);

		// 월요일
		searchDateBuf.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

		String startStr = sdf.format(searchDateBuf.getTime());

		paramMap.put("startStr", startStr);

		// 일요일 (Calendar 에서 주차의 시작은 일요일이므로 다음 주차의 일요일을 구한다.)
		searchDateBuf.set(Calendar.WEEK_OF_YEAR, weekNum + 1);
		searchDateBuf.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);

		String endStr = sdf.format(searchDateBuf.getTime());
		paramMap.put("endStr", endStr);
		model.addAttribute("startStr", startStr);
		model.addAttribute("endStr", endStr);

		List<EgovMap> approveScheduleList = approveService.getAppvScheduleList(paramMap);

		model.addAttribute("approveScheduleList", approveScheduleList);
		model.addAttribute("weekNum", weekNum);
		model.addAttribute("year", year);

		return "approve/pop/appvScheduleListPop/pop";

	}

	/**
	 *
	 * 보고서: 일정선택팝업 : 검색
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/getAppvScheduleListPopAjax.do")
	public String getAppvScheduleListPopAjax(HttpSession session, @RequestParam Map<String, Object> paramMap,
			Model model) throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId"));
		paramMap.put("userId", baseUserLoginInfo.get("userId"));
		paramMap.put("sabun", baseUserLoginInfo.get("empNo"));

		paramMap.put("sessionUserId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("deptLevel", baseUserLoginInfo.get("deptLevel").toString());
		paramMap.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());

		String weekType = paramMap.get("weekType").toString();

		Integer weekNum = Integer.parseInt(paramMap.get("weekNum").toString());
		Integer year = Integer.parseInt(paramMap.get("year").toString());

		// 이전주차 조회
		if (weekType.equals("prev")) {

			weekNum--;

			// 첫번째주라면 작년 마지막 일의 주차를 조회한다
			if (weekNum < 1) {

				year = year - 1;

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				Calendar cal = Calendar.getInstance(Locale.KOREA);

				cal.set(Calendar.YEAR, year);

				weekNum = cal.getWeeksInWeekYear();

			}
			// 다음 주차조회
		} else if (weekType.equals("next")) {
			weekNum++;

			Calendar cal = Calendar.getInstance(Locale.KOREA);

			Integer lastWeekNum = cal.getWeeksInWeekYear();

			if (weekNum > lastWeekNum) {
				year = year + 1;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date firstDay = sdf.parse(year + "-01-01");

				cal.setTime(firstDay);

				weekNum = cal.get(Calendar.WEEK_OF_YEAR);
			}
			// 이번주
		} else if (weekType.equals("now")) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -1);
			weekNum = cal.get(Calendar.WEEK_OF_YEAR);

			year = cal.get(Calendar.YEAR);
		}

		paramMap.put("weekNum", weekNum);
		paramMap.put("year", year);

		// 조회한 주차의 시작일(월)~(일) 구하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar searchDateBuf = Calendar.getInstance();
		searchDateBuf.set(Calendar.YEAR, year);
		searchDateBuf.set(Calendar.WEEK_OF_YEAR, weekNum);

		// 월요일
		searchDateBuf.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

		String startStr = sdf.format(searchDateBuf.getTime());

		paramMap.put("startStr", startStr);

		// 일요일 (Calendar 에서 주차의 시작은 일요일이므로 다음 주차의 일요일을 구한다.)
		searchDateBuf.set(Calendar.WEEK_OF_YEAR, weekNum + 1);
		searchDateBuf.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);

		String endStr = sdf.format(searchDateBuf.getTime());
		paramMap.put("endStr", endStr);
		model.addAttribute("startStr", startStr);
		model.addAttribute("endStr", endStr);

		List<EgovMap> approveScheduleList = approveService.getAppvScheduleList(paramMap);

		model.addAttribute("approveScheduleList", approveScheduleList);
		model.addAttribute("weekNum", weekNum);
		model.addAttribute("year", year);

		model.addAttribute("startStr", startStr);
		model.addAttribute("endStr", endStr);

		return "approve/include/appvScheduleListPop_INC/inc";

	}

	/**
	 *
	 * 보고서 - 일정 선택 팝업
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/individualChkPop.do")
	public String individualChkPop(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model)
			throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		/*
		 ******************************************* 결재라인 직접선택을 위한 로직 : S
		 */
		// 공통코드
		Map cmmCdCategoryListCodeMap = new HashMap();
		// 승인방식
		cmmCdCategoryListCodeMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		cmmCdCategoryListCodeMap.put("codeSetNm", "APPV_CLASS");
		model.addAttribute("cmmCdAppvClassList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		// 결재유형
		cmmCdCategoryListCodeMap.put("codeSetNm", "APPV_LINE_TYPE");
		model.addAttribute("cmmCdAppvLineTypeList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));
		/*
		 ******************************************* 결재라인 직접선택을 위한 로직 : E
		 */

		return "approve/pop/individualChkPop/pop";

	}

	// 참조문서 읽음 처리(리스트)
	@RequestMapping(value = "/approve/processReadAppvList.do")
	public void processReadContentList(HttpSession session, @RequestParam Map<String, Object> map, Model model,
			HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());

		Map<String, Object> result = new HashMap();
		int upCnt = 0;

		// System.out.println(map.get("chkContentId"));
		upCnt = approveService.updateReadUserIdList(map);

		result.put("upCnt", upCnt);
		AjaxResponse.responseAjaxObject(response, result);

	}

	// 사내서식관리 화면
	@RequestMapping(value = { "/approve/approveCompanyFormList.do" })
	public String approveCompanyFormList(HttpSession session, @RequestParam Map<String, Object> map, Model model)
			throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (map.containsKey("pageIndex") && !map.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(map.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (map.containsKey("recordCountPerPage") && !map.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		map.put("firstIndex", firstRecordIndex);
		map.put("recordCountPerPage", recordCountPerPage);
		map.put("ruleUseYn", "N");
		List<EgovMap> companyFormList = approveService.getCompanyFormList(map);
		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("companyFormList", companyFormList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", map);
		return "approve/approveCompanyFormList";

	}

	/**
	 *
	 * 사내서식 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/draftDocList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/getApproveCompanyFormListAjax.do" })
	public String approveCompanyFormListAjax(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		String returnStr = "approve/include/approveCompanyFormList_INC/inc";

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		paramMap.put("ruleUseYn", "N");
		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> companyFormList = approveService.getCompanyFormList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("companyFormList", companyFormList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		return returnStr;
	}

	// 문서작성 > 사내서식
	@RequestMapping(value = { "/approve/approveCompany.do" })
	public String approveCompany(HttpSession session, @RequestParam Map<String, Object> map, Model model)
			throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		// 사내서식 구분
		map.put("useDocYn", "Y");

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (map.containsKey("pageIndex") && !map.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(map.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 1000;

		if (map.containsKey("recordCountPerPage") && !map.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		map.put("firstIndex", firstRecordIndex);
		map.put("recordCountPerPage", recordCountPerPage);

		///////////////////////// 새글알림 조회 :S///////////////////////////////////
		map.put("newContentMarkClass", "APPV");
		map.put("newContentMarkType", "COMPANY");
		map.put("useYn", "Y");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		map.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(map);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			map.put("ruleUseYn", "Y");
			map.put("readTimeYn", ruleMap.get("readTimeYn"));
			map.put("markDayCnt", ruleMap.get("markDayCnt"));
		}

		///////////////////////// 새글알림 조회 :E///////////////////////////////////

		List<EgovMap> companyFormList = approveService.getCompanyFormList(map);
		Integer totCnt = Integer.parseInt(map.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("companyFormList", companyFormList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", map);
		return "approve/approveCompany";

	}

	/**
	 *
	 * 사내서식 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/getApproveCompanyAjax.do" })
	public String approveCompanyAjax(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		// 사내서식 구분
		paramMap.put("useDocYn", "Y");
		String returnStr = "approve/include/approveCompany_INC/inc";

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> companyFormList = approveService.getCompanyFormList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("companyFormList", companyFormList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		return returnStr;
	}

	// 사내생성페이지이동
	@RequestMapping(value = "/approve/createApproveCompanyForm.do")
	public String createApproveCompanyForm(HttpSession session, @RequestParam Map<String, Object> map, Model model)
			throws Exception {
		model.addAttribute("searchMap", map);
		return "approve/createApproveCompanyForm";

	}

	/**
	 *
	 * 사내서식 저장
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/insertApproveCompanyFormAjax.do")
	public void insertApproveCompanyForm(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		paramMap.put("appvDocClass", "COMPANY");

		Integer cnt = approveService.getAppvDocTypeNameCnt(paramMap);

		if(cnt>0){
			obj.put("result", "FAIL");
			obj.put("msg", "중복된 문서타입입니다.");
		}else{

			approveService.insertApproveCompanyForm(paramMap);

			obj.put("result", "SUCCESS");
		}

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 사내서식 수정
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/updateApproveCompanyFormAjax.do")
	public void updateApproveCompanyFormAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		paramMap.put("appvDocClass", "COMPANY");
		approveService.updateApproveCompanyForm(paramMap);

		obj.put("result", "SUCCESS");
		// obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 사내서식 삭제
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/deleteApproveCompanyFormAjax.do")
	public void deleteApproveCompanyFormAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		paramMap.put("appvDocClass", "COMPANY");
		approveService.deleteApproveCompanyForm(paramMap);

		obj.put("result", "SUCCESS");
		// obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 사내서식 구분 유효성 체크
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/doAppvDocNumRuleMidNameChk.do")
	public void doAppvDocNumRuleMidNameChk(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		Integer cnt = approveService.getAppvDocNumRuleMidNameCnt(paramMap);

		if (cnt == 0) {
			obj.put("result", "SUCCESS");
		} else {
			obj.put("result", "FAIL");
			obj.put("cnt", cnt);
		}

		// obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 사내서식 수정/상세 페이지
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/processApproveCompanyForm"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processApproveCompanyForm.do")
	public String processApproveCompanyForm(HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelMap model, @RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";

		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		EgovMap companyFormMap = approveService.getCompanyFormInfo(paramMap);

		model.addAttribute("companyFormMap", companyFormMap);
		model.addAttribute("searchMap", paramMap);

		return "approve/updateApproveCompanyForm";
	}

	/**
	 *
	 * 연결 결재문서 선택 팝업
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/getApproveRefDocPop.do")
	public String getApproveRefDocPop(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model)
			throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId"));
		paramMap.put("userId", baseUserLoginInfo.get("userId"));

		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		model.addAttribute("paginationInfo", paginationInfo);
		List<EgovMap> approveRefDocList = approveService.getApproveRefDocList(paramMap);

		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("approveRefDocList", approveRefDocList);

		model.addAttribute("refDocIdStr", paramMap.get("refDocIdStr"));

		return "approve/pop/approveRefDocPop/pop";

	}

	/**
	 *
	 * 연결문서 선택 팝업 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/approve/getApproveRefDocPopAjax.do")
	public String getApproveRefDocPopAjax(HttpSession session, @RequestParam Map<String, Object> paramMap, Model model)
			throws Exception {
		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId"));
		paramMap.put("userId", baseUserLoginInfo.get("userId"));

		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		model.addAttribute("paginationInfo", paginationInfo);
		List<EgovMap> approveRefDocList = approveService.getApproveRefDocList(paramMap);

		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("approveRefDocList", approveRefDocList);
		return "approve/include/approveRefDocPop_INC/inc";

	}

	/**
	 *
	 * 서식 즐겨찾기 프로세스
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processAppvFavListAjax.do")
	public void processAppvFavListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		Integer cnt = approveService.processAppvFavListAjax(paramMap);

		// obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 서식 즐겨찾기 일괄 삭제
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/deleteAppvFavListAjax.do")
	public void deleteAppvFavListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "chkedDoc", required = false) String[] chkedDoc) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		paramMap.put("proc", "delete");
		Integer cnt = 0;
		for(String favStr:chkedDoc){
			paramMap.put("favStr", favStr);
			cnt = approveService.processAppvFavListAjax(paramMap);
		}

		// obj.put("appvDocId", paramMap.get("appvDocId").toString());
		obj.put("result", "SUCCESS");
		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 즐겨찾기 검색
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/getAppvFavListAjax.do")
	public void getAppvFavListAjax(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		List<EgovMap> appvFavList = approveService.getAppvFavListAjax(paramMap);
		obj.put("appvFavList", appvFavList);
		// obj.put("appvDocId", paramMap.get("appvDocId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 즐겨찾는서식리스트
	 *
	 * @param :
	 *            HttpSession
	 * @return : String "approve/approveBookmarkFormList"
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/approveBookmarkFormList.do" })
	public String approveBookmarkFormList(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		String url = request.getRequestURI();

		String type = url.indexOf("draftDocList.do") > 0 ? "draft" : "temp";

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = 10;

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		// int recordCountPerPage = paginationInfo.getRecordCountPerPage();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		List<EgovMap> approveBookmarkFormList = approveService.getApproveBookmarkFormList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("approveBookmarkFormList", approveBookmarkFormList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		model.addAttribute("searchMap", paramMap);
		return "approve/approveBookmarkFormList";
	}

	/**
	 *
	 * 즐겨찾는서식 리스트 Ajax
	 *
	 * @param :
	 *            HttpSession
	 * @return : String
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = { "/approve/approveBookmarkFormListAjax.do" })
	public String approveBookmarkFormListAjax(HttpSession session, HttpServletRequest request, Model model,
			@RequestParam Map<String, Object> paramMap) throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			return "redirect:/";
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		String returnStr = "approve/include/approveBookmarkFormList_INC/inc";

		model.addAttribute("listType", paramMap.get("listType"));
		////////////////////////// 조회 가능한 기안문서 리스트:S////////////////////////////
		PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		Integer recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈

		int firstRecordIndex = paginationInfo.getFirstRecordIndex();

		paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);

		if (paramMap.containsKey("listType")) {
			String listType = paramMap.get("listType").toString();

			if (listType.equals("draft"))
				paramMap.put("approveDraftIngYn", "Y");
			else
				paramMap.put("approveDraftIngYn", "N");
		}

		List<EgovMap> approveBookmarkFormList = approveService.getApproveBookmarkFormList(paramMap);
		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("approveBookmarkFormList", approveBookmarkFormList);
		////////////////////////// 조회 가능한 기안문서 리스트:E////////////////////////////

		return returnStr;
	}

	/**
	 *
	 * 품의서 상신 (다중)
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processDraftDocSubmitAll.do")
	public void processDraftDocSubmitAll(HttpSession session, @RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "chkedDoc", required = false) String[] chkedDoc, HttpServletResponse response)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("loginId", baseUserLoginInfo.get("loginId").toString());

		paramMap.put("docStatus", paramMap.get("processDocStatus"));

		paramMap.put("chkedDoc", chkedDoc);

		// paramMap.put("approveProcessId",paramMap.get("approveProcessId"));
		// 선택한 건수만큼 처리한다.
		for (int i = 0; i < chkedDoc.length; i++) {
			String chkedDocStr = chkedDoc[i];
			String[] chkedDocBuf = chkedDocStr.split("[|]");
			String appvDocId = chkedDocBuf[0];
			String appvDocClass = chkedDocBuf[1];
			String appvDocType = chkedDocBuf[2];
			String appvStatus = chkedDocBuf[3];
			String appvProcessId = chkedDocBuf[4];
			String individualYn = chkedDocBuf[5];
			String appvHeaderId = "";
			if(individualYn.equals("N"))
				if(chkedDocBuf.length>6&&!chkedDocBuf[6].equals(""))
				appvHeaderId = chkedDocBuf[6];
			String familyEventsId = "";
			if(chkedDocBuf.length>7){
				familyEventsId = chkedDocBuf[7];
			}

			paramMap.put("appvDocId", appvDocId);
			paramMap.put("appvDocClass", appvDocClass);
			paramMap.put("appvDocType", appvDocType);
			paramMap.put("appvStatus", appvStatus);
			paramMap.put("appvProcessId", appvProcessId);
			paramMap.put("individualYn", individualYn);
			paramMap.put("appvHeaderId", appvHeaderId);
			paramMap.put("familyEventsId", familyEventsId);

			approveService.processDocSubmit(paramMap);
		}

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");
		// obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달
	}

	/**
	 *
	 * 지출결의서 지급처리
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/processExpenseYn.do")
	public void processExpenseYn(HttpSession session, @RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "chkedDoc", required = false) String[] chkedDoc, HttpServletResponse response)
			throws Exception {

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		approveService.processExpenseYn(paramMap);

		// return obj
		Map<String, Object> obj = new HashMap<String, Object>();

		obj.put("result", "SUCCESS");
		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}
	/**
	 *
	 * 문서내용수정
	 *
	 * @param :
	 *            HttpSession
	 * @return :
	 * @exception :
	 *                throws
	 * @author : Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/doSaveAppvInfoUpdate.do")
	public void doSaveAppvInfoUpdate(HttpSession session, HttpServletResponse response,
			@RequestParam Map<String, Object> paramMap,
			@RequestParam(value = "fileSeq", required = false) String[] fileSeq, // 파일
			@RequestParam(value = "orgFileNm", required = false) String[] orgFileNm,
			@RequestParam(value = "newFileNm", required = false) String[] newFileNm,
			@RequestParam(value = "filePath", required = false) String[] filePath,
			@RequestParam(value = "fileSize", required = false) String[] fileSize,
			@RequestParam(value = "delFileList", required = false) String[] delFileList, // 삭제
			@RequestParam(value = "approveCcId", required = false) String[] approveCcId,
			@RequestParam(value = "approveRcId", required = false) String[] approveRcId
																					) throws Exception {

		logger.info("appv doSaveAppvInfoUpdate ......");

		if (session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception();
		Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

		Map<String, Object> obj = new HashMap<String, Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		// 파일리스트
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();

		if (fileSeq != null) {// 공통처리로직
			Loop1: for (int i = 0; i < fileSeq.length; i++) {

				// 삭제 대상에 있다면 제외한다.
				if (delFileList != null) {
					for (int j = 0; j < delFileList.length; j++) {
						if (delFileList[j].equals(fileSeq[i]))
							continue Loop1;
					}
				}
				// 기존에 있는파일은 제외한다.
				if (!fileSeq[i].equals("0"))
					continue;

				// 파일정보 맵
				Map<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("fileSeq", fileSeq[i]);
				fileMap.put("orgFileNm", orgFileNm[i]);
				fileMap.put("newFileNm", newFileNm[i]);
				fileMap.put("filePath", filePath[i]);
				fileMap.put("fileSize", fileSize[i]);
				fileMap.put("uploadType", paramMap.get("appvDocClass").toString());

				fileList.add(fileMap);
			}

		}

		if (approveCcId != null)
			paramMap.put("approveCcId", approveCcId);

		if (approveRcId != null)
			paramMap.put("approveRcId", approveRcId);

		approveService.doSaveAppvInfoUpdate(paramMap,fileList,delFileList);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj); // "SUCCESS" 전달

	}

	/**
	 *
	 * 메인팝업
	 *
	 * @param     :
	 * @return    :
	 * @exception : throws
	 * @author    : psj
	 * @date      : 2017.11.07
	 */
	@RequestMapping("/approve/approveAlarmMainPop.do")
	public String cardCorpUsedMainPop(@RequestParam Map<String,Object> map
			,Model model, HttpSession session) throws Exception{

		//Map<String,Object> map = new HashMap<String, Object>();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId"));
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("type", "pop");

		List<EgovMap> sendAppvAlarmList = approveService.getSendAppvAlarmList(map);

		model.addAttribute("sendAppvAlarmList",sendAppvAlarmList);
		return "approve/pop/approveAlarmMainPop/pop";
	}

	///////////////////////////////////////////전자결재 배치 url : S///////////////////////////////////////////////////////

	/**
	 *
	 * 전자결재 미결알람 배치
	 *
	 * @param :
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/batch/approve/sendAppvAlam.do")
	public void sendAppvAlam(HttpServletResponse response) throws Exception {

		//오늘이 토요일,일요일이면 실행하지 않는다.
		Calendar now = Calendar.getInstance();

		if(now.get(Calendar.DAY_OF_WEEK)==1||now.get(Calendar.DAY_OF_WEEK) == 7){
			return;
		}



		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("batchId", -1);
		paramMap.put("type", "sms");
		List<EgovMap> sendAppvAlarmList = approveService.getSendAppvAlarmList(paramMap);

		String userId = "";

		String content = "";

		for(EgovMap detailMap : sendAppvAlarmList){
			String userIdDt = detailMap.get("userId").toString();
			if(!userId.equals(userIdDt)){
				if(!userId.equals("")){
					//sms 보내기
					approveService.approveSendSms(content,userId);

					content=approveService.makeSmsMsg(detailMap);
				}else{
					content=approveService.makeSmsMsg(detailMap);
				}

				userId = userIdDt;
			}else{
				content = content+"<p><p>"+approveService.makeSmsMsg(detailMap);
			}
		}

		if(sendAppvAlarmList!=null&&sendAppvAlarmList.size()>0){
			//sms 보내기
			approveService.approveSendSms(content,userId);
		}

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	///////////////////////////////////////////전자결재 배치 url : E///////////////////////////////////////////////////////

}