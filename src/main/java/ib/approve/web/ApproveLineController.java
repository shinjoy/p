package ib.approve.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import ib.approve.service.ApproveLineService;
import ib.approve.service.ApproveService;
import ib.approve.service.ApproveVoList;
import ib.cmm.service.CommonService;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.common.util.DateUtil;
import ib.personnel.service.ManagementService;


/**
 * <pre>
 * package	: ibiss.system.web
 * filename	: ApproveLineController.java
 * </pre>
 *
 *
 *
 * @author : SangHyun Park
 * @date : 2015. 10. 20.
 * @version :
 *
 */
@Controller
public class ApproveLineController {

	@Resource(name = "approveLineService")
	private ApproveLineService approveLineService;

	@Resource(name="commonService")
	private CommonService commonService;
	@Resource(name = "managementService")
	private ManagementService managementService;

	@Resource(name = "approveService")
	private ApproveService approveService;
	protected static final Log logger = LogFactory
			.getLog(ApproveLineController.class);
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
			Map<String, String> menuMap = new HashMap<String, String>();

			///////////////// ajax조회면 실행하지 않는다 : S
			String ajaxHeader = request.getHeader("X-Requested-With");

			String winId = request.getParameter("winID");	//AxisModal

			if ((ajaxHeader != null && ajaxHeader.equals("XMLHttpRequest"))||winId!=null)
				return;
			///////////////// ajax조회면 실행하지 않는다 : E

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
				Date productEndDate = sdfmt.parse("20170901");

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
	 * 결재라인
	 * @param :
	 * @return :
	 * @exception :
	 * @author : 이인희
	 * @date : 2016. 10. 21.
	 */
	@RequestMapping(value = "/approve/approveLine.do")
	public String approveLine(HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		List<Map> approveHeaderList = approveLineService.selectApproveHeaderList(map);
		model.addAttribute("approveHeaderList", approveHeaderList);

		//공통코드
		Map cmmCdCategoryListCodeMap = new HashMap();
		//승인방식
		cmmCdCategoryListCodeMap.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
        cmmCdCategoryListCodeMap.put("codeSetNm", "APPV_CLASS");
        model.addAttribute("cmmCdAppvClassList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

        //결재유형
        cmmCdCategoryListCodeMap.put("codeSetNm", "APPV_LINE_TYPE");
        model.addAttribute("cmmCdAppvLineTypeList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		return "approve/approveLine";
	}

	/**
	 * 결재선관리 리스트(Ajax)
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : 이인희
	 * @date : 2016. 10. 21.
	 */
	@RequestMapping(value = "/approve/getApproveHeaderListAjax.do")
	public String getApproveHeaderListAjax(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam Map<String, Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		List<Map> approveHeaderList = approveLineService.selectApproveHeaderList(map);
		model.addAttribute("approveHeaderList", approveHeaderList);

		return "approve/include/approveLine_list1_INC/inc";
	}

	/**
	 * 결재라인저장 Ajax
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 10. 8.
	 */
	@RequestMapping(value = "/approve/doSaveApproveHeader.do")
	public void doSaveApproveHeader(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, String> map) throws Exception {

		//if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		int cnt = approveLineService.doSaveApproveHeader(map);

		String errMsg = "";
		if(cnt == -1){
			errMsg = "DUPLICATE";
		}
		if(cnt == -2){
			errMsg = "BUY_AMOUNT_DUP";
		}

		AjaxResponse.responseAjaxSave(response, cnt,errMsg); // 결과전송
	}

	/**
	 * 결재라인 리스트(Ajax)
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : 이인희
	 * @date : 2016. 10. 21.
	 */
	@RequestMapping(value = "/approve/getApproveLineListAjax.do")
	public String getApproveLineListAjax(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam Map<String, Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		List<Map> approveLineList = approveLineService.selectApproveLineList(map);
		model.addAttribute("approveLineList", approveLineList);

		//공통코드
		Map cmmCdCategoryListCodeMap = new HashMap();
		//승인방식
		cmmCdCategoryListCodeMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
        cmmCdCategoryListCodeMap.put("codeSetNm", "APPV_CLASS");
        model.addAttribute("cmmCdAppvClassList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

        //결재유형
        cmmCdCategoryListCodeMap.put("codeSetNm", "APPV_LINE_TYPE");
        model.addAttribute("cmmCdAppvLineTypeList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));


		return "approve/include/approveLine_list2_INC/inc";
	}

	/**
	 * 결재라인저장 Ajax
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : 이인희
	 * @date : 2016. 10. 22.
	 */
	@RequestMapping(value = "/approve/doSaveApproveLine.do")
	public void doSaveApproveLine(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, String> map, ApproveVoList appVoList) throws Exception {

		//if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		int cnt = approveLineService.doSaveApproveLine(map, appVoList);

		AjaxResponse.responseAjaxSave(response, cnt); // 결과전송
	}
	/**
	 *
	 * 사내서식 문서타입 조회
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/getAppvCompanyListForLineAjax.do")
	public void appvCompanyListForLineAjax(HttpSession session
			, @RequestParam Map<String,Object> paramMap
			, HttpServletResponse response
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		List<EgovMap> appvCompanyList = approveLineService.appvCompanyListForLine(paramMap);

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		obj.put("appvCompanyList",appvCompanyList);
		//obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 *
	 * 결재라인 복사 팝업
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/approve/copyApproveLinePop.do")
	public String copyApproveLinePop(HttpSession session
			, @RequestParam Map<String,Object> paramMap
			, HttpServletResponse response
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		List<EgovMap> appvCompanyList = approveLineService.appvCompanyListForLine(paramMap);

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		obj.put("appvCompanyList",appvCompanyList);
		//obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		return "approve/pop/copyApproveLinePop/pop";
	}

	/**
	 * 결재라인복사 Ajax
	 *
	 * @param :
	 * @return :
	 * @exception :
	 * @author : SangHyun Park
	 * @date : 2015. 10. 8.
	 */
	@RequestMapping(value = "/approve/processCopyAppvLine.do")
	public void processCopyAppvLine(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, String> map) throws Exception {

		//if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		String msg = approveLineService.processCopyAppvLine(map);

		Map<String,Object> obj = new HashMap<String,Object>();

		if(msg.equals("SUCCESS")){
			obj.put("result", "SUCCESS");
		}else{
			obj.put("result", "FAIL");
			obj.put("msg" , msg);
		}

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

    /**
	 * 직원별 상위부서정보. 지우지 말것
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 22.
	 */
     /*
	@RequestMapping(value = "/approve/getApproveLineHighDeptInfoAjax.do")
	public void getApproveLineHighDeptInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, String> map) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
        map.put("deptId", baseUserLoginInfo.get("deptId").toString());
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		List<Map> list = approveLineService.getApproveLineHighDeptInfo(map);


        for(int i = 0; i < list.size(); i++){
            System.out.println("objIdxobjIdxobjIdx = " + list.get(i).get("objIdx"));
            System.out.println("deptIddeptIddeptId = " + list.get(i).get("deptId"));
            System.out.println("deptNamedeptName = " + list.get(i).get("deptName"));
        }

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
    */
	//////////////////////////////////////////////////////////Util

	/**
	 *
	 * 결재자 지정 리스트
	 *
	 * @param : HttpSession
	 * @return :
	 */
	@RequestMapping(value = "/approve/getApproveUserListAjax.do")
	public void getApproveUserListAjax(HttpSession session
			, @RequestParam Map<String,Object> paramMap
			, HttpServletResponse response
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		List<Map> approveUserList = approveLineService.getApproveUserList(paramMap);


		AjaxResponse.responseAjaxSelect(response, approveUserList);
	}
}