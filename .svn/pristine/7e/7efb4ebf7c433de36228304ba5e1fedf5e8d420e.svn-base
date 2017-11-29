package ib.work.web;

import ib.cmm.IBsMessageSource;
import ib.cmm.service.CmmUseService;
import ib.cmm.service.CommonService;
import ib.login.service.StaffVO;
import ib.work.service.WorkService;
import ib.work.service.WorkVO;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * <pre>
 * package  : ib.work.web
 * filename : WorkController.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 1.
 * @version : 1.0.0
 */
@Controller
public class MonthlyController {

	/** CmmUseService */
	@Resource(name="CmmUseService")
	private CmmUseService cmm;

	@Resource(name="commonService")
	private CommonService commonService;

	/** MessageSource */
    @Resource(name="IBsMessageSource")
    IBsMessageSource MessageSource;

    @Resource(name = "workService")
    private WorkService workService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Autowired
    private DefaultBeanValidator beanValidator;
	/** log */
    protected static final Log LOG = LogFactory.getLog(WorkController.class);

	protected static Calendar cal = Calendar.getInstance();

	/**
	 *
	 * @MethodName : selectMonthlyLeft
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectMonthlyLeft.do")
	public String selectMonthlyLeft(HttpServletRequest request,
			HttpSession session,
            ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Left";

		StaffVO staffVO = new StaffVO();
		model.addAttribute("userList", cmm.userList(staffVO));

		List<WorkVO> resu = workService.selectOutStaffList(staffVO);
		model.addAttribute("outStaffList", resu);

    	return "work/Left";
    }

	/**
	 *
	 * @MethodName : viewMonthly
	 * @param request
	 * @param session
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectMonthlyV.do")
	public String viewMonthly(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		LOG.info(baseUserLoginInfo.get("loginId").toString());
		if(workVO.getName()=="") workVO.setName(baseUserLoginInfo.get("userName").toString());
		if(workVO.getTmpId()=="")workVO.setTmpId(baseUserLoginInfo.get("loginId").toString());

		String date = null;
		if(workVO.getChoiceYear().equals("") && workVO.getChoiceMonth().equals("")){
			// Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			date = new SimpleDateFormat("yyyyMM").format( cal.getTime() );

			workVO.setChoiceYear(date.substring(0, 4));
			workVO.setChoiceMonth(date.substring(4));

		}else model.addAttribute("choiceYear", workVO.getChoiceYear());
		Calendar now = cal;
		now.set(Integer.parseInt(workVO.getChoiceYear()), Integer.parseInt(workVO.getChoiceMonth())-1, 1);
		model.addAttribute("last_day", now.getActualMaximum(Calendar.DATE));
		model.addAttribute("first_day", now.get(Calendar.DAY_OF_WEEK));

		//model.addAttribute("cmmCdCategoryList", cmm.commonCdList(workVO.ccdCateCd));
        Map cmmCdCategoryListCodeMap = new HashMap();
        cmmCdCategoryListCodeMap.put("codeSetNm", workVO.ccdCateCd);
        model.addAttribute("cmmCdCategoryList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		//model.addAttribute("cmmCdOfferList", cmm.commonCdList(workVO.ccdOffCd));
        Map ccdInfoRegTypeListCodeMap = new HashMap();
        ccdInfoRegTypeListCodeMap.put("codeSetNm", workVO.ccdInfoRegType);
        model.addAttribute("ccdInfoRegTypeList", commonService.getBaseCommonCode(ccdInfoRegTypeListCodeMap));

        Map ccdOfferTypeListCodeMap = new HashMap();
        ccdOfferTypeListCodeMap.put("codeSetNm", workVO.ccdOfferType);
        model.addAttribute("ccdOfferTypeList", commonService.getBaseCommonCode(ccdOfferTypeListCodeMap));

        Map ccdPublicRelationListCodeMap = new HashMap();
        ccdPublicRelationListCodeMap.put("codeSetNm", workVO.ccdPublicRelation);
        model.addAttribute("ccdPublicRelation", commonService.getBaseCommonCode(ccdPublicRelationListCodeMap));

        //model.addAttribute("cmmCd1stSlctList", cmm.commonCdList("00015"));
        Map cmmCd1stSlctListCodeMap = new HashMap();
        cmmCd1stSlctListCodeMap.put("codeSetNm", "INFORM_TYPE");
        model.addAttribute("cmmCd1stSlctList", commonService.getBaseCommonCode(cmmCd1stSlctListCodeMap));

		//model.addAttribute("cmmCdResultList", cmm.commonCdList("00010"));
		Map cmmCdResultListCodeMap = new HashMap();
        cmmCdResultListCodeMap.put("codeSetNm", "WORK_PROGRESS");
        model.addAttribute("cmmCdResultList", commonService.getBaseCommonCode(cmmCdResultListCodeMap));

		//model.addAttribute("cmmCdDealList", cmm.commonCdList("00011"));
		Map ccdSourcingTypeListCodeMap = new HashMap();
        ccdSourcingTypeListCodeMap.put("codeSetNm", "SOURCING_TYPE");
        model.addAttribute("ccdSourcingTypeList", commonService.getBaseCommonCode(ccdSourcingTypeListCodeMap));

		Map ccdAttractFuncListCodeMap = new HashMap();
        ccdAttractFuncListCodeMap.put("codeSetNm", "ATTRACT_FUND");
        model.addAttribute("ccdAttractFuncList", commonService.getBaseCommonCode(ccdAttractFuncListCodeMap));

		Map ccdShareHolderListCodeMap = new HashMap();
        ccdShareHolderListCodeMap.put("codeSetNm", "SHARE_HOLDER");
        model.addAttribute("ccdShareHolderList", commonService.getBaseCommonCode(ccdShareHolderListCodeMap));

		Map<String, Object> map = null;
		List<WorkVO> result0 = null;
		List<WorkVO> inside = null;
		try{
			map = workService.selectBusinessRecordList(workVO);
			result0 = workService.selectOfferListNfile(workVO);
			inside = workService.selectInsideList(workVO);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("offerList",result0);
		model.addAttribute("insideList",inside);

		return "work/monthly/monthly";
	}
}