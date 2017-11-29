package ib.work.web;

import java.io.IOException;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.idgnr.impl.Base64;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.basic.service.CpnExcelVO;
import ib.basic.service.impl.CpnUploadExcelMapping;
import ib.basic.web.MultiFileUpload;
import ib.basic.web.UtilReplaceTag;
import ib.cmm.ComCodeVO;
import ib.cmm.FileUpDbVO;
import ib.cmm.IBsMessageSource;
import ib.cmm.service.CmmUseService;
import ib.cmm.service.CommonService;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.PagingAjax;
import ib.company.service.CompanyService;
import ib.company.service.CompanyVO;
import ib.login.service.StaffVO;
import ib.person.service.PersonMgmtService;
import ib.person.service.PersonVO;
import ib.work.service.WorkService;
import ib.work.service.WorkVO;

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
public class WorkController {

	/** CmmUseService */
	@Resource(name="CmmUseService")
	private CmmUseService cmm;

	@Resource(name="commonService")
	private CommonService commonService;

    @Resource(name = "companyService")
    protected CompanyService companyService;
    @Resource(name = "personMgmtService")
	private PersonMgmtService personMgmtService;

	/** MessageSource */
    @Resource(name="IBsMessageSource")
    IBsMessageSource MessageSource;

    @Resource(name = "workService")
    private WorkService workService;

    @Autowired
    private DefaultBeanValidator beanValidator;
	/** log */
    protected static final Log LOG = LogFactory.getLog(WorkController.class);

	protected static final Calendar cal = Calendar.getInstance();

	/**
	 * Main - Left
	 * @MethodName : selectWork
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectLeft.do")
	public String selectWork(HttpServletRequest request,
			HttpSession session,
            ModelMap model) throws Exception{
		HashMap map = new HashMap();
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Left";

    	return "work/Left";
    }

	@RequestMapping(value="/work/selectuserList.do")
	public void selectuserList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
            ModelMap model,
            @RequestParam Map<String, String> map) throws Exception{


		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		StaffVO staffVO = new StaffVO();

		List<Map>list =  commonService.getStaffListNameSort(map);


		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
    }


	@RequestMapping(value="/work/outStaffList.do")
	public void selectWorkAjax(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			StaffVO staffVO,
            ModelMap model) throws Exception{

		List<WorkVO> resu = workService.selectOutStaffList(staffVO);

		AjaxResponse.responseAjaxObject(response, resu);	//결과전송
    }

	@RequestMapping(value="/work/selectCommonCdList.do")
	public void selectCdAjax(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			StaffVO staffVO,
            ModelMap model) throws Exception{

        Map ccdKeyPoinListCodeMap = new HashMap();
        ccdKeyPoinListCodeMap.put("codeSetNm", staffVO.ccdKeyPoint);
        ccdKeyPoinListCodeMap.put("roleId", ((Map)session.getAttribute("baseUserLoginInfo")).get("userRoleId").toString());
		AjaxResponse.responseAjaxObject(response, commonService.getBaseCommonCode(ccdKeyPoinListCodeMap));	//결과전송
    }

	/**
	 * 업무일지 업무내용 조회
	 * @MethodName : selectBusinessRecord
	 * @param request
	 * @param session
	 * @param vo
	 * @param loginVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectBusinessRecord.do")
	public String selectBusinessRecord(HttpServletRequest request,
			HttpSession session,
			WorkVO vo,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		vo.setRgId(loginUser.get("loginId").toString());
		vo.setOrgId(loginUser.get("orgId").toString());

		model.addAttribute("DaY", vo.getDay());
		try{
			if(vo.getsNb()!=null && !vo.getsNb().equals("n") && vo.getsNb().length()>0){
				model.addAttribute("bsnsList", workService.selectBusinessRecordOne(vo));
				LOG.debug(loginUser.get("loginId").toString()+"^_^workService.selectBusinessRecordOne");
			}
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		return "ajaxPopDiv/bsns_data/ajax";
	}
	/**
	 * 업무일지 인사이드 조회
	 * @MethodName : selectInside
	 * @param request
	 * @param session
	 * @param vo
	 * @param loginVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectInside.do")
	public String selectInside(HttpServletRequest request,
			HttpSession session,
			WorkVO vo,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		vo.setRgId(loginUser.get("loginId").toString());
		vo.setOrgId(loginUser.get("orgId").toString());


		model.addAttribute("DaY", vo.getDay());
		try{
			model.addAttribute("insideList", workService.selectInsideOne(vo));
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.selectInsideOne");
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		return "ajaxPopDiv/bsns_data/noHeader";
	}

	/**
	 * 업무일지 업무내용 입력
	 * @MethodName : insertBusinessRecord
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/insertBusinessRecord.do")
	public String insertBusinessRecord(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		model.addAttribute("result", workVO.getDay());
		workVO.setTmDt(workVO.getChoiceYear()+workVO.getChoiceMonth()+workVO.getDay());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		//orgId set.....:S
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();

		workVO.setOrgId(orgId);
		//orgId set.....:E

		int cnt = 0;
		try{
			cnt = workService.insertBusinessRecord(workVO);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.insertBusinessRecord");
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("saveCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "basic/result/ajax";
	}

	/**
	 * 업무일지 업무내용 수정
	 * @MethodName : modifyBusinessRecord
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyBusinessRecord.do")
	public String modifyBusinessRecord(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		int cnt = workService.updateBusinessRecord(workVO);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateBusinessRecord^_^"+workVO.getsNb());
		model.addAttribute("saveCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));
		model.addAttribute("result", workVO.getDay());

		return "basic/result/ajax";
	}

	/**
	 * 업무일지 업무내용 삭제
	 * @MethodName : deleteBusinessRecord
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/deleteBusinessRecord.do")
	public String deleteBusinessRecord(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		int cnt = workService.deleteBusinessRecord(workVO);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.deleteBusinessRecord^_^"+workVO.getsNb());
		model.addAttribute("deleteCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.delete"));

		model.addAttribute("result", workVO.getFocus());
		return "basic/result";
	}


	/**
	 * 정보정리 입력
	 * @MethodName : insertDeal
	 * @param request
	 * @param workVO
	 * @param loginVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/insertDeal.do")
	public String insertDeal(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		if(workVO.getDay()!=null&workVO.getDay().length()!=0) workVO.setTmDt(workVO.getChoiceYear()+workVO.getChoiceMonth()+workVO.getDay());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		workVO.setRgNm(loginUser.get("userName").toString());
		if("".equals(workVO.getMiddleOfferCd())||workVO.getMiddleOfferCd()==null)workVO.setMiddleOfferCd("00000");
		if("".equals(workVO.getInfoProvider())||workVO.getInfoProvider()==null)workVO.setInfoProvider("0");
		if("".equals(workVO.getSupporter())||workVO.getSupporter()==null)workVO.setSupporter("0");
		if("".equals(workVO.getRcmdSnb())||workVO.getRcmdSnb()==null)workVO.setRcmdSnb("0");
		int cnt = 0;
		try{
			cnt = workService.insertDealByIbSystem(workVO,loginUser);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("insertCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		/** 고객관리 시스템 연동 **/
/*		if("00011".equals(workVO.getMiddleOfferCd())){
			cntCus = cusManagementSystem(workVO);
		}if(cntCus==0) System.out.println("------------error------------\n---------고객관리시스템 insert---------");
	*/
		model.addAttribute("result", workVO.getDay());
		return "basic/result/ajax";
	}
	/**
	 * 공동진행 팝업
	 * @MethodName : popUpSup
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpSup.do")
	public String popUpSup(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		StaffVO staffVO = new StaffVO();
		model.addAttribute("userList", cmm.userList(staffVO));



		if(workVO.getsNb()!=null && !"".equals(workVO.getsNb())){
			List <WorkVO> result= null;
			workVO.setOfferSnb(workVO.getsNb());
			model.addAttribute("parentSNB", workVO.getsNb());
			model.addAttribute("pop", "ok");
			try{
				result = workService.selectOfferJointProgress(workVO);
				model.addAttribute("jointList", result);
			}catch(Exception e){
				LOG.error(e);
				e.printStackTrace();
			}
		}
		return "work/popUp/PopUpSup";
	}

	/**
	 * 팝업 공동진행 저장
	 * @MethodName : popUpSupJoint
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpSupJoint.do")
	public String popUpSupJoint(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{
try {
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		for(int i=0;i<workVO.getArrStaffSnb().length;i++){		//공동진행 사원 id 배열
			String staffSnb = workVO.getArrStaffSnb()[i];	//사원 id
			String ratio = workVO.getArrRatio()[i];			//비율
			String snb = workVO.getArrSnb()[i];				//

			if(staffSnb!=null && !"".equals(staffSnb) && !"0".equals(staffSnb)){
				if(ratio!=null && !"".equals(ratio) && !"0".equals(ratio)){
					workVO.setStaffSnb(staffSnb);
					workVO.setRatio(ratio);
					workVO.setComment(workVO.getArrComment()[i]);
					try{
						if(snb!=null && !"".equals(snb)) {
							//update
							workVO.setsNb(snb);
							workService.updateOfferJointProgress(workVO);
							LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateOfferJointProgress^_^"+workVO.getsNb());
						}else{
							//insert
							workService.insertOfferJointProgress(workVO);
							LOG.debug(loginUser.get("loginId").toString()+"^_^workService.insertOfferJointProgress^_^"+workVO.getsNb());
						}
					}catch(Exception e){
						LOG.error(e);
						e.printStackTrace();
						throw e;
					}
				}
			}
		}

		StaffVO staffVO = new StaffVO();
		model.addAttribute("userList", cmm.userList(staffVO));

		List <WorkVO> result= null;
		model.addAttribute("parentSNB", workVO.getOfferSnb());
		model.addAttribute("pop", "ok");
		try{
			result = workService.selectOfferJointProgress(workVO);
			model.addAttribute("jointList", result);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		return "work/funds/PopUpSup";
}catch(Exception e) {
	e.printStackTrace();
	throw e;
}
	}

	/**
	 * 공동진행 삭제
	 * @MethodName : deletePopUpSupJoint
	 * @param request
	 * @param session
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/deletePopUpSupJoint.do")
	public String deletePopUpSupJoint(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		try{
			workService.deleteOfferJointProgress(workVO);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.deleteOfferJointProgress^_^"+workVO.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		return "work/funds/PopUpSup";
	}


	/**
	 * 정보정리 수정
	 * @MethodName : modifyDeal
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyDeal.do")
	public String modifyDeal(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		if("".equals(workVO.getMiddleOfferCd())||workVO.getMiddleOfferCd()==null)workVO.setMiddleOfferCd("00000");
		if("".equals(workVO.getInfoProvider())||workVO.getInfoProvider()==null)workVO.setInfoProvider("0");
		if("".equals(workVO.getCstId())||workVO.getCstId()==null)workVO.setCstId("0");
		if("".equals(workVO.getSupporterRatio())||workVO.getSupporterRatio()==null)workVO.setSupporterRatio("0");

		int cnt = workService.updateDealByIbSystem(workVO);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateDeal^_^"+workVO.getsNb());

		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		model.addAttribute("result", workVO.getDay());
		return "basic/result/ajax";
	}

	/**
	 * 정보정리 삭제
	 * @MethodName : deleteOffer
	 * @param request
	 * @param session
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/deleteOffer.do")
	public String deleteOffer(HttpServletRequest request,
			HttpSession session,
			WorkVO vo,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		FileUpDbVO fvo = new FileUpDbVO();
		fvo.setOfferSnb(vo.getsNb());
		System.out.println("---snb:"+fvo.getOfferSnb());

		int cnt = workService.deleteOffer(vo);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.deleteOffer^_^"+vo.getsNb());

		workService.deleteFileInfoOfOfferSnb(fvo);

		model.addAttribute("deleteCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.delete"));

		model.addAttribute("result", vo.getFocus());
		return "basic/result";
	}
	/**
	 * 메모 전달
	 * @MethodName : insertMemo
	 * @param request
	 * @param workVO
	 * @param loginVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/insertMemo.do")
	public String insertMemo(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{
		try {
				System.out.println(workVO.getStaffSnb());
				if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
				Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
				LOG.info(loginUser.get("loginId").toString());
				model.addAttribute("focus", workVO.getDay());


				workVO.setRgId(loginUser.get("loginId").toString());
				workVO.setOrgId(loginUser.get("orgId").toString());
				workVO.setStaffSnb(loginUser.get("userId").toString());
				workVO.setArrayName(workVO.getMemoSndName().split(","));

				String returnPage = "work/PrivateWorkView";

				if("".equals(workVO.getMemoSndName())){
				//	viewPrivateWork(request, session, workVO,  model);
					return "work/PrivateWorkView";
				}
				//orgId set.....:S
				Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
				String orgId = baseUserLoginInfo.get("orgId").toString();

				workVO.setOrgId(orgId);
				//orgId set.....:E
				workVO.setTmDt(workVO.getChoiceYear()+workVO.getChoiceMonth()+workVO.getDay());
				workVO.setChoiceMonthS(workVO.getChoiceMonth());

				Map<String,Integer> returnMap = workService.insertMemoByIbSystem(workVO);
				int smsCnt = returnMap.get("smsCnt");
				int cnt = returnMap.get("cnt");
				if(smsCnt !=0){
					List<WorkVO> rsltSMS = null;
					UtilReplaceTag rpTag = new UtilReplaceTag();
					try{
						rsltSMS = workService.selectSMS(workVO);
					}catch(Exception e){
						LOG.error(e);
						e.printStackTrace();
					}
					rsltSMS.get(0).setSmsContent(rpTag.replaceTag(rsltSMS.get(0).getSmsContent(),"decode"));
					model.addAttribute("resultSMS", rsltSMS);
					if("N".equals(workVO.getSubMemo())){
						returnPage = "basic/result_SMS";
						model.addAttribute("smsType",rsltSMS.get(0).getSmsType());
						model.addAttribute("smsToNum",rsltSMS.get(0).getSmsToNum());
						model.addAttribute("smsContent",rsltSMS.get(0).getSmsContent());
						model.addAttribute("smsFromNum",rsltSMS.get(0).getSmsFromNum());
						model.addAttribute("smsReserTime",rsltSMS.get(0).getSmsReserTime());
						model.addAttribute("smsSeq",rsltSMS.get(0).getSmsSeq());
						model.addAttribute("smsOK","SMSreturnValueOK");
					}
				}

				model.addAttribute("saveCnt", cnt);
			//	viewPrivateWork(request, session, workVO, model);
		//		return "work/PrivateWorkView";
				return returnPage;
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	/**
	 * 다른 사람이 전달한 메모확인
	 * @MethodName : checkMemo
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/checkMemo.do")
	public String checkMemo(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

//		System.out.println("---note:"+workVO.getNote());
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());


		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		model.addAttribute("result", workVO.getFocus());

		int cnt = 0;
		try{
			cnt = workService.checkMemo(workVO);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.checkMemo^_^"+workVO.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "basic/result";
	}

	/**
	 * 메모 수정
	 * @MethodName : modifyMemo
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyMemo.do")
	public String modifyMemo(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		model.addAttribute("focus", workVO.getTmDt().substring(8,10));

		int cnt = 0;
		try{
			cnt = workService.modifyMemoByIbSystem(workVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "work/PrivateWorkView";
	}

	/**
	 * 메모 삭제
	 * @MethodName : deleteMemo
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/deleteMemo.do")
	public String deleteMemo(HttpServletRequest request,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
//		System.out.println("---snb:"+workVO.getsNb());
		int cnt = workService.deleteMemoByIbSystem(workVO);

		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.deleteMemo^_^"+workVO.getsNb());
		model.addAttribute("deleteCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.delete"));

		model.addAttribute("result", workVO.getFocus());
		return "basic/result";
	}


/*******************************************************************************************************************************/

/*******************************************************************************************************************************/


	/**
	 * 딜업무 전체딜
	 * @MethodName : selectWorkAllDeal
	 * @param request
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectWorkAllDeal.do")
	public String selectWorkAllDeal(HttpServletRequest request,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		String tab = workVO.getSorting();
		String search = workVO.getSearch();
		model.addAttribute("ttT", workVO.getTotal());
		model.addAttribute("searchName", search);

		try{
			//model.addAttribute("cmmCdCategoryList", cmm.commonCdList(workVO.ccdCateCd));	//public final String ccdCateCd = "00005";
            Map cmmCdCategoryListCodeMap = new HashMap();
            cmmCdCategoryListCodeMap.put("codeSetNm", workVO.ccdCateCd);
            model.addAttribute("cmmCdCategoryList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

			//List<ComCodeVO> cmvo = cmm.commonCdList(workVO.ccdCateCd,loginUser.getId());
			//model.addAttribute("cmmCdCategoryPerList", cmvo);
            Map cmmCdCategoryPerListCodeMap = new HashMap();
            cmmCdCategoryPerListCodeMap.put("codeSetNm", workVO.ccdCateCd);
            cmmCdCategoryPerListCodeMap.put("roleId", ((Map)session.getAttribute("baseUserLoginInfo")).get("userRoleId").toString());
            List<Map> cmvo = commonService.getBaseCommonCode(cmmCdCategoryPerListCodeMap);
            model.addAttribute("cmmCdCategoryPerList", cmvo);

			//model.addAttribute("cmmCdAllDealTabList", cmm.commonCdList("00021"));

			//탭 첫번째가 뭔지 확인
			if(tab.length()==0) {
				tab = ((Map)cmvo.get(0)).get("cd").toString();
				if(Integer.parseInt(tab)<8) tab = "";
			}//유형별로 쿼리날리기위한 조건추가

			if(!"SYNERGY".equals(loginUser.get("orgId").toString())){
				if(tab.length()==0){	//디폴트 탭(탭선택 안했을때)
					tab = "T1";
				}
			}

			workVO.setSorting(tab);

			if(search.length()!=0) model.addAttribute("TAB", "0");
			else model.addAttribute("TAB", tab);

			if("00008".equals(tab)){//mna
				//model.addAttribute("cmmCdMnaPgCdList", cmm.commonCdList("00016"));
                Map cmmCdMnaPgCdListCodeMap = new HashMap();
                cmmCdMnaPgCdListCodeMap.put("codeSetNm", "MNA_STATUS");
                model.addAttribute("cmmCdMnaPgCdList", commonService.getBaseCommonCode(cmmCdMnaPgCdListCodeMap));
			}
			if("00004".equals(tab)){
				workVO.setMiddleOfferCd(tab);
				workVO.setSorting("null");
			}
			/*if("T1".equals(tab)){			//딜(유증,블록딜,실권주,워런트)
				workVO.setSorting("T1");
			}*/
			if("no_listed".equals(tab)){	//딜(비상장)
				workVO.setSorting("");
				workVO.setListed("N");
			}


			if(workVO.getChoiceYear().equals("")){
				cal.setTime( new Date(System.currentTimeMillis()) );
				String date = new SimpleDateFormat("yyyyMM").format( cal.getTime() );
				workVO.setChoiceYear(date.substring(0, 4));
			}
			model.addAttribute("choiceYear", workVO.getChoiceYear());

			workVO.setChoiceYearS( Integer.toString( Integer.parseInt(workVO.getChoiceYear())-1) );
			workVO.setChoiceMonthS("01");
			workVO.setChoiceMonth("12");
			if("statsPrivateList".equals(workVO.getTmpNum2()) ) workVO.setTmpNum2("");

			//division 정보 포함 전달
			workVO.setDivision(loginUser.get("orgId").toString());

			model.addAttribute("offerList", workService.selectOfferAllDealList(workVO));
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		return "deal/AllDeal";
	}

	/**
	 * 직접발굴 제안
	 * @MethodName : selectWorkDirectDealS
	 * @param request
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectWorkDirectDealS.do")
	public String selectWorkDirectDealS(HttpServletRequest request,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		model.addAttribute("ttT", workVO.getTotal());

		workVO.setOfferCd("00006");//제안
		workVO.setMiddleOfferCd("00002");//직접발굴

		if(workVO.getChoiceYear().equals("")){
			// Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMM").format( cal.getTime() );

			workVO.setChoiceYear(date.substring(0, 4));
			//System.out.println(date);
		}
		model.addAttribute("choiceYear", workVO.getChoiceYear());
		workVO.setChoiceMonthS("01");
		workVO.setChoiceMonth("12");

		List<WorkVO> result = null;
		try{
			result = workService.selectOfferList(workVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", result);
		model.addAttribute("offerList", map.get("resultList"));

		//model.addAttribute("cmmCdProgressList", cmm.commonCdList("00003"));
		Map cmmCdProgressListCodeMap = new HashMap();
        cmmCdProgressListCodeMap.put("codeSetNm", "SYNEGY_RELATION");
        model.addAttribute("cmmCdProgressList", commonService.getBaseCommonCode(cmmCdProgressListCodeMap));

        //model.addAttribute("cmmCdCategoryList", cmm.commonCdList(workVO.ccdCateCd));
		Map cmmCdCategoryListCodeMap = new HashMap();
        cmmCdCategoryListCodeMap.put("codeSetNm", workVO.ccdCateCd);
        model.addAttribute("cmmCdCategoryList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		//model.addAttribute("cmmCdFeedbackList", cmm.commonCdList("00007"));
		Map cmmCdFeedbackListCodeMap = new HashMap();
        cmmCdFeedbackListCodeMap.put("codeSetNm", "YSE_NO_FLAG");
        model.addAttribute("cmmCdFeedbackList", commonService.getBaseCommonCode(cmmCdFeedbackListCodeMap));

		model.addAttribute("middleT", "직접발굴");

		return "work/deal/DealSend";
	}
	/**
	 * 딜 유형중 mna만 따로
	 * @MethodName : selectWorkMnaDeal
	 * @param request
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectWorkMnaDeal.do")
	public String selectWorkMnaDeal(HttpServletRequest request,
			WorkVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		model.addAttribute("ttT", vo.getTotal());

		//model.addAttribute("cmmCdProgressList", cmm.commonCdList("00003"));
		Map cmmCdProgressListCodeMap = new HashMap();
        cmmCdProgressListCodeMap.put("codeSetNm", "SYNEGY_RELATION");
        model.addAttribute("cmmCdProgressList", commonService.getBaseCommonCode(cmmCdProgressListCodeMap));

        //model.addAttribute("cmmCdCategoryList", cmm.commonCdList(vo.ccdCateCd));
		Map cmmCdCategoryListCodeMap = new HashMap();
        cmmCdCategoryListCodeMap.put("codeSetNm", vo.ccdCateCd);
        model.addAttribute("cmmCdCategoryList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		//model.addAttribute("cmmCdFeedbackList", cmm.commonCdList("00007"));
		Map cmmCdFeedbackListCodeMap = new HashMap();
        cmmCdFeedbackListCodeMap.put("codeSetNm", "YSE_NO_FLAG");
        model.addAttribute("cmmCdFeedbackList", commonService.getBaseCommonCode(cmmCdFeedbackListCodeMap));

		vo.setCategoryCd("00008");//mna

		if(vo.getChoiceYear().equals("")){
			// Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMM").format( cal.getTime() );

			vo.setChoiceYear(date.substring(0, 4));
			//System.out.println(date);
		}
		model.addAttribute("choiceYear", vo.getChoiceYear());
		vo.setChoiceMonthS("01");
		vo.setChoiceMonth("12");

		List<WorkVO> result = null;
		try{
			result = workService.selectOfferList(vo);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", result);
		model.addAttribute("offerList", map.get("resultList"));
		model.addAttribute("middleT", "딜 > M&A");
		model.addAttribute("rqMap", "/work/selectWorkMnaDeal.do");

		return "work/deal/Deal4categoryCd";
	}
	/**
	 * 딜 유형중 프리IPO만 따로
	 * @MethodName : selectWorkIPO
	 * @param request
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectWorkIPO.do")
	public String selectWorkIPO(HttpServletRequest request,
			WorkVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		model.addAttribute("ttT", vo.getTotal());

		//model.addAttribute("cmmCdProgressList", cmm.commonCdList("00003"));
		Map cmmCdProgressListCodeMap = new HashMap();
        cmmCdProgressListCodeMap.put("codeSetNm", "SYNEGY_RELATION");
        model.addAttribute("cmmCdProgressList", commonService.getBaseCommonCode(cmmCdProgressListCodeMap));

        //model.addAttribute("cmmCdCategoryList", cmm.commonCdList(vo.ccdCateCd));
		Map cmmCdCategoryListCodeMap = new HashMap();
        cmmCdCategoryListCodeMap.put("codeSetNm", vo.ccdCateCd);
        model.addAttribute("cmmCdCategoryList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		//model.addAttribute("cmmCdFeedbackList", cmm.commonCdList("00007"));
		Map cmmCdFeedbackListCodeMap = new HashMap();
        cmmCdFeedbackListCodeMap.put("codeSetNm", "YSE_NO_FLAG");
        model.addAttribute("cmmCdFeedbackList", commonService.getBaseCommonCode(cmmCdFeedbackListCodeMap));

		vo.setCategoryCd("00012");//프리IPO

		if(vo.getChoiceYear().equals("")){
			// Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMM").format( cal.getTime() );

			vo.setChoiceYear(date.substring(0, 4));
			//System.out.println(date);
		}
		model.addAttribute("choiceYear", vo.getChoiceYear());
		vo.setChoiceMonthS("01");
		vo.setChoiceMonth("12");

		List<WorkVO> result = null;
		try{
			result = workService.selectOfferList(vo);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", result);
		model.addAttribute("offerList", map.get("resultList"));
		model.addAttribute("middleT", "딜 > 프리IPO");
		model.addAttribute("rqMap", "/work/selectWorkIPO.do");

		return "work/deal/Deal4categoryCd";
	}

	/**
	 * 딜 -> MnA 진행자 입력/수정
	 * @MethodName : mnaMatchingStaffs
	 * @param request
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/mnaMatchingStaffs.do")
	public String mnaMatchingStaffs(HttpServletRequest request,
			WorkVO vo,
			HttpSession session,
			ModelMap model) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		vo.setRgId(loginUser.get("loginId").toString());
		vo.setOrgId(loginUser.get("orgId").toString());

		String staffsName = vo.getMemoSndName();
		model.addAttribute("result", staffsName);

		//orgId set.....:S
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();

		vo.setOrgId(orgId);
		//orgId set.....:E

	try{
		workService.mnaMatchingStaffsByIbSystem(vo);

	}catch(Exception e){
		// e.printStackTrace();
		throw e;
	}
		return "basic/result";
	}


	/**
	 * 피드백 select 옵션 수정
	 * @MethodName : changeFeedback
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/changeFeedback.do")
	public String changeFeedback(HttpServletRequest request,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());


		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		int cnt = 0;
		try{
			cnt = workService.updateFeedback(workVO);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateFeedback^_^"+workVO.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "work/deal/DealSend";
	}
	/**
	 * 진행상황 select 옵션 수정
	 * @MethodName : changeprogressCd
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/changeprogressCd.do")
	public String changeprogressCd(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());


		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		int cnt = 0, cntCus = 0;
		try{
			cnt = workService.updateprogressCdByIbSystem(workVO,loginUser);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));
		return "work/deal/DealSend";
	}
	/**
	 * 진행사항 & 매칭회사 수정 (딜 -> mna)
	 * @MethodName : changeprogressCdNmatchCpn
	 * @param request
	 * @param session
	 * @param loginVO
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/changeprogressCdNmatchCpn.do")
	public String changeprogressCdNmatchCpn(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		int cnt = 0;
		try{
			cnt = workService.changeprogressCdNmatchCpnByIbSystem(workVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "work/deal/DealSend";
	}

	/**
	 * 매칭회사 삭제
	 * @MethodName : delMnaMatchCpn
	 * @param request
	 * @param session
	 * @param vo
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : chan
	 * @since : 2015. 3. 31.
	 */
	@RequestMapping(value="/work/delMnaMatchCpn.do")
	public String delMnaMatchCpn(HttpServletRequest request,
			HttpSession session,
			WorkVO vo,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		int cnt = 0;
		try{
			cnt = workService.deleteMnaMatchCpn(vo);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.deleteMnaMatchCpn^_^"+vo.getsNb());

		}catch(Exception e){
			e.printStackTrace();
			LOG.error(e);
		}
		model.addAttribute("result", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "basic/result";
	}

	/**
	 * 제안 메모 수정
	 * @MethodName : modifyDealMemo
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyDealMemo.do")
	public String modifyDealMemo(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		int cnt = workService.modifyDealMemoByIbSystem(workVO);

		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "work/deal/DealSend";
	}
	/**
	 * 성과/중요도 & 투자의견
	 * @MethodName : modifyDealResult
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyDealResult.do")
	public String modifyDealResult(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		int cnt = workService.modifyDealResultByIbSystem(workVO);

		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "work/deal/DealSend";
	}
	/**
	 * 기한 수정
	 * @MethodName : modifyDueDate
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyDueDate.do")
	public String modifyDueDate(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		int cnt = workService.updateDueDate(workVO);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateDueDate^_^"+workVO.getsNb());
		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "work/deal/DealSend";
	}

	/**
	 * 중개 제안받은딜현황
	 * @MethodName : receiveDeal
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectWorkMediateDealR.do")
	public String selectWorkMediateDealR(HttpServletRequest request,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		model.addAttribute("ttT", workVO.getTotal());

		workVO.setOfferCd("00007");//받은제안
		workVO.setMiddleOfferCd("00001");//중개

		//int mon = 0;
		if(workVO.getChoiceYear().equals("")){
			// Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMM").format( cal.getTime() );

			workVO.setChoiceYear(date.substring(0, 4));
			//mon = Integer.parseInt(date.substring(4, 6));
		}
		model.addAttribute("choiceYear", workVO.getChoiceYear());

		workVO.setChoiceMonthS("01");
		workVO.setChoiceMonth("12");

		List<WorkVO> result = null;
		try{
			result = workService.selectOfferList(workVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("offerList", result);

		//model.addAttribute("cmmCdProgressList", cmm.commonCdList(workVO.ccdPrgressCd));
		Map cmmCdProgressListCodeMap = new HashMap();
        cmmCdProgressListCodeMap.put("codeSetNm", workVO.ccdPrgressCd);
        model.addAttribute("cmmCdProgressList", commonService.getBaseCommonCode(cmmCdProgressListCodeMap));

        //model.addAttribute("cmmCdCategoryList", cmm.commonCdList(workVO.ccdCateCd));
		Map cmmCdCategoryListCodeMap = new HashMap();
        cmmCdCategoryListCodeMap.put("codeSetNm", workVO.ccdCateCd);
        model.addAttribute("cmmCdCategoryList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		//model.addAttribute("cmmCdFeedbackList", cmm.commonCdList("00007"));
		Map cmmCdFeedbackListCodeMap = new HashMap();
        cmmCdFeedbackListCodeMap.put("codeSetNm", "YSE_NO_FLAG");
        model.addAttribute("cmmCdFeedbackList", commonService.getBaseCommonCode(cmmCdFeedbackListCodeMap));

		model.addAttribute("middleT", "중개");

		return "work/deal/DealReceive";
	}
/*******************************************************************************************************************************/

	/**
	 * 회사 찾기 팝업
	 * @MethodName : popUpCpn
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpCpn.do")
	public String popUpCpn(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			ModelMap model) throws Exception{


		int totCnt = 0;
		List<CompanyVO> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", workVO.getCpnNm());
        model.addAttribute("MDf", workVO.getModalFlag());
        model.addAttribute("MDn", workVO.getModalNum());

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
		map.put("resultList", result);
		model.addAttribute("companyList", map.get("resultList"));

        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

		return "work/popUp/PopUpCpn/pop";
	}
	/**
	 * 팝업 실시간 회사검색
	 * @MethodName : ajaxPopUpCpnSearchName
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : user
	 * @since : 2015. 2. 9.
	 */
	@RequestMapping(value="/work/ajaxPopUpCpnSearchName.do")
	public String ajaxPopUpCpnSearchName(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
        LOG.info(loginUser.get("loginId").toString()+"^_^"+workVO.getCpnNm());

		int totCnt = 0;
		List<CompanyVO> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", workVO.getCpnNm());
        model.addAttribute("MDf", workVO.getModalFlag());
        model.addAttribute("MDn", workVO.getModalNum());

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
		map.put("resultList", result);
		model.addAttribute("companyList", map.get("resultList"));

        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

		return "includeJSP/PopUpCpn";
	}
	/**
	 * 사람 찾기 팝업
	 * @MethodName : popUpCst
	 * @param request
	 * @param workVO
	 * @param personVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpCst.do")
	public String popUpCst(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			PersonVO personVO,
			ModelMap model) throws Exception{

		int totCnt = 0;
		List<PersonVO> result = null;
		Map<String, Object> map = new HashMap<String, Object>();

        PaginationInfo paginationInfo = new PaginationInfo();
        model.addAttribute("searchName", workVO.getCstNm());
        model.addAttribute("MDf", workVO.getModalFlag());
        model.addAttribute("MDn", workVO.getModalNum());
        model.addAttribute("sortTitle", workVO.getSort_t());


        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);

		if(personVO.getCpnNm() != null && personVO.getCpnNm().length() != 0) model.addAttribute("YN", "Y");


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

		return "work/popUp/PopUpCst/pop";
	}

	/**
	 * 팝업 실시간 인물검색
	 * @MethodName : ajaxPopUpCstSearchName
	 * @param request
	 * @param workVO
	 * @param personVO
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : user
	 * @since : 2015. 2. 9.
	 */
	@RequestMapping(value="/work/ajaxPopUpCstSearchName.do")
	public String ajaxPopUpCstSearchName(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			PersonVO personVO,
			ModelMap model) throws Exception{

//		업무일지 기입시 회사 선택한 후 사람선택시 해당 회사 사람만 소팅하기 위한 부분
		if(session.getAttribute("userLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
        LOG.info(loginUser.get("loginId").toString()+"^_^"+workVO.getCstNm());

		int totCnt = 0;
		List<PersonVO> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
        PaginationInfo paginationInfo = new PaginationInfo();

        model.addAttribute("searchName", workVO.getCstNm());
        model.addAttribute("MDf", workVO.getModalFlag());
        model.addAttribute("MDn", workVO.getModalNum());
        model.addAttribute("sortTitle", workVO.getSort_t());


        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(15);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);

		if(personVO.getCpnNm() != null && personVO.getCpnNm().length() != 0) model.addAttribute("YN", "Y");

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

		return "includeJSP/PopUpCst/ajax";
	}
	/**
	 * 진행상태 수정
	 * @MethodName : updatePrecessResult
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/updatePrecessResult.do")
	public String updatePrecessResult(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		int cnt = 0;
		try{
			cnt = workService.updatePrecessResult(workVO);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updatePrecessResult^_^"+workVO.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", cnt);

		return "work/PrivateWorkView";
	}

	/**
	 * 회사 등록화면
	 * @MethodName : rgstCpn
	 * @param companyVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/work/popRgstCpn.do")
	public String rgstCpn(@ModelAttribute("companyVO") CompanyVO companyVO,
			HttpSession session,
			ModelMap model){

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		//System.out.println("===========등록할 회사이름:"+companyVO.getSearchCpnNm()+"==============");
		List<CompanyVO> result = null;
		try{
			result = companyService.selectMaxCpnId(companyVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("maxCpnId", result.get(0).getCpnId());
		model.addAttribute("cpnNm", companyVO.getSearchCpnNm());
		model.addAttribute("MDf", companyVO.getModalFlag());
		model.addAttribute("MDn", companyVO.getModalNum());
		LOG.info(loginUser.get("loginId").toString()+"^_^"+companyVO.getSearchCpnNm());

		return "work/RegistCPN";
	}

	/**
	 * 다중업로드 등록화면
	 * @MethodName : multiUploadV
	 * @param personVO
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/work/multiUpload.do")
	public String multiUploadV(@ModelAttribute("personVO") PersonVO personVO,
			WorkVO workVO,
			HttpSession session,
			ModelMap model){

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		return "work/popUp/MultiUpload";
	}
	/**
	 * 다중업로드 process
	 * @MethodName : multiUploadProcess
	 * @param request
	 * @param response
	 * @param personVO
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/work/multiUploadProcess.do")
	public String multiUploadProcess(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("personVO") PersonVO personVO,
			WorkVO workVO,
			HttpSession session,
			ModelMap model){

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		model.addAttribute("MDn", workVO.getModalNum());
		model.addAttribute("nm", workVO.getTmpNum1());

		String maxSnb = "";
		List<WorkVO> offerVo = null;

		// snb를 알기위해 offer //
		workVO.setOfferCd("00000");
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		workVO.setRgNm(loginUser.get("userName").toString());

	    try{
			// 정보 받기
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;

		    workVO.setTmDt((String)multi.getParameter("tmDt"));
		    workVO.setsNb((String)multi.getParameter("sNb"));
		    workVO.setReportYN((String)multi.getParameter("reportYN"));
		    workVO.setSubCd((String)multi.getParameter("subCd"));

		    if(workVO.getsNb()==null || "".equals(workVO.getsNb())){
		    	workVO.setOfferCd("11111");
			    try{
			    	insertDeal(request,session,workVO,model);
			    	// maxSnb 구하기
			    	offerVo = workService.selectMaxSnb(workVO);
			    }catch(Exception e){
			    	LOG.error(e);
			    	e.printStackTrace();
			    }
			    maxSnb = offerVo.get(0).getsNb();
			    workVO.setOfferCd("00000");
		    }else{
		    	maxSnb = workVO.getsNb();
		    }

		    FileUpDbVO fileVo = new FileUpDbVO();
		    fileVo.setOfferSnb(maxSnb);
		    fileVo.setReportYN((String)multi.getParameter("reportYN"));
		    fileVo.setFileCategory("00000");//00000:정보정리, 00001: staff사진 ,  00002: 댓글 첨부파일, 00003: 인사관리->이력서파일


		    fileVo.setRgId(loginUser.get("loginId").toString());
		    fileVo.setOrgId(loginUser.get("orgId").toString());
		    // 파일업로드 시키기
		    MultiFileUpload mUpload = new MultiFileUpload("");
		    mUpload.fileUpload(multi, fileVo, request);

	    }catch(Exception e){
	    	LOG.error(e);
	    	e.printStackTrace();
	    }
		model.addAttribute("upload", 1);
		model.addAttribute("maxSnb", maxSnb);


		return "work/popUp/MultiUpload";
	}

	/**
	 * 핵심체크사항 메모수정
	 * @MethodName : modifyKeyPointChkMemo
	 * @param request
	 * @param session
	 * @param loginVO
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyKeyPointChkMemo.do")
	public String modifyKeyPointChkMemo(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());
		int cnt = workService.modifyKeyPointChkMemoByIbSystem(workVO);

		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		return "work/deal/DealSend";
	}

	/**
	 * 파일 다운로드 포로세스
	 * @MethodName : downloadProcess
	 * @param request
	 * @param response
	 * @param fileVO
	 * @return
	 */
	@RequestMapping(value="/work/downloadProcess.do")
	public void downloadProcess(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			FileUpDbVO fileVO){
		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");

		List<FileUpDbVO> fileUp = null;

		try {
			fileUp = workService.selectFileInfo(fileVO);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		LOG.debug(loginUser.get("loginId").toString()+"^_^"+fileUp.get(0).getRealName());
		try {
			CpnUploadExcelMapping.doGet(request, response, fileUp);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}


	/**
	 * 파일 삭제	20151001
	 * @MethodName : downloadProcess
	 * @param request
	 * @param response
	 * @param fileVO
	 * @return
	 */
	@RequestMapping(value="/work/deleteFileOne.do")
	public void deleteFileOne(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			@RequestParam Map<String,String> map){

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");


		try {
			int upCnt = workService.deleteFile(map);
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		return;
	}


	/**
	 * 핵심체크사항 협력자 추가
	 * @MethodName : coworkerKeyPointChk
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/coworkerKPC.do")
	public String coworkerKeyPointChk(WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());


		int cnt = 0;
		//String str = "";
		StringBuffer strB = new StringBuffer();
		String rtn = null;
		rtn = workVO.getUrl();

		if(workVO.getArrayName() != null){
			for(int i=0;i<workVO.getArrayName().length;i++){
				if(i!=0){
					//str += ", ";
					strB.append(strB).append(", ");
				}
				//str += workVO.getArrayName()[i];
				strB.append(strB).append(workVO.getArrayName()[i]);
			}
		}
		//workVO.setCoworker(str);
		workVO.setCoworker(strB.toString());
		try{
			cnt = workService.updateOfferCoworker(workVO);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateOfferCowerker^_^"+workVO.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("saveCnt", cnt);
		if(rtn==null||"".equals(rtn)) return "forward:/work/financing.do";
		else return "forward:/work/" +rtn+".do";
	}


	/**
	 * 핵심체크사항 - 진행사항
	 * @MethodName : processKeyPointChk
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/processKPC.do")
	public String processKeyPointChk(WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		int cnt = 0;
		String rtn = null;
		rtn = workVO.getUrl();

		try{
			cnt = workService.updateOfferInfoProcess(workVO);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateOfferInfoProcess^_^"+workVO.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("saveCnt", cnt);
		if(rtn==null||"".equals(rtn)) return "forward:/work/financing.do";
		else return "forward:/work/" +rtn+".do";
	}

	/**
	 * 일임
	 * @MethodName : entrust
	 * @param request
	 * @param workVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/selectWorkEntrust.do")
	public String entrust(HttpServletRequest request,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

//		System.out.println("---total:"+workVO.getTotal());
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

        //model.addAttribute("cmmCdProgressList", cmm.commonCdList("00003"));
		Map cmmCdProgressListCodeMap = new HashMap();
        cmmCdProgressListCodeMap.put("codeSetNm", "SYNEGY_RELATION");
        model.addAttribute("cmmCdProgressList", commonService.getBaseCommonCode(cmmCdProgressListCodeMap));

		//model.addAttribute("cmmCdCategoryList", cmm.commonCdList(workVO.ccdCateCd));
		Map cmmCdCategoryListCodeMap = new HashMap();
        cmmCdCategoryListCodeMap.put("codeSetNm", workVO.ccdCateCd);
        model.addAttribute("cmmCdCategoryList", commonService.getBaseCommonCode(cmmCdCategoryListCodeMap));

		//model.addAttribute("cmmCdFeedbackList", cmm.commonCdList("00007"));
		Map cmmCdFeedbackListCodeMap = new HashMap();
        cmmCdFeedbackListCodeMap.put("codeSetNm", "YSE_NO_FLAG");
        model.addAttribute("cmmCdFeedbackList", commonService.getBaseCommonCode(cmmCdFeedbackListCodeMap));

		model.addAttribute("ttT", workVO.getTotal());

		//workVO.setOfferCd("00006");//제안
		workVO.setMiddleOfferCd("00011");//일임

		if(workVO.getChoiceYear().equals("")){
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMM").format( cal.getTime() );

			workVO.setChoiceYear(date.substring(0, 4));
			//mon = Integer.parseInt(date.substring(4, 6));
		}
		model.addAttribute("choiceYear", workVO.getChoiceYear());

		//workVO.setChoiceYear("2013");
		workVO.setChoiceMonthS("01");
		workVO.setChoiceMonth("12");

		try{
			model.addAttribute("offerList", workService.selectOfferList(workVO));
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		return "work/funds/Entrust";
	}

	/**
	 * 정보 페이지 중요도 저장
	 * @MethodName : saveLevel
	 * @param request
	 * @param wVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/saveLv.do")
	public String saveLevel(HttpServletRequest request,
			WorkVO wVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		wVO.setRgId(loginUser.get("loginId").toString());
		wVO.setOrgId(loginUser.get("orgId").toString());

		workService.updateOfferInfoLv(wVO);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateOfferInfoLv^_^"+wVO.getsNb());

		return "work/keyPointChk/Financing";
	}

	/**
	 * 추천인 팝업
	 * @MethodName : popUpRecommend
	 * @param request
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpRecommend.do")
	public String popUpRecommend(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		model.addAttribute("MDf", workVO.getModalFlag());
		model.addAttribute("MDn", workVO.getModalNum());

		try{
			List<WorkVO> result = workService.selectRecommendOne(workVO);
			model.addAttribute("rcmdList", result);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		if("1".equals(workVO.getTmpNum1()))
			model.addAttribute("pop", "ok");

		return "work/popUp/PopUpRecommend";
	}

	/**
	 * 드래그 앤 드롭으로 업무내용 일자수정
	 * @MethodName : modifyBusinessRecordTmdt
	 * @param request
	 * @param session
	 * @param workVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyBusinessRecordTmdt.do")
	public String modifyBusinessRecordTmdt(HttpServletRequest request,
			HttpSession session,
			WorkVO workVO,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		workVO.setRgId(loginUser.get("loginId").toString());
		workVO.setOrgId(loginUser.get("orgId").toString());

		model.addAttribute("result", workVO.getTmDt().substring(6,8));

		List<WorkVO> result = null;
		int cnt = 0;
		try{
			result = workService.selectBusinessTmdt(workVO);

			int inTurn = Integer.parseInt(workVO.getTmpNum2())
				,lsTurn = 1
				,idx = 0
				,lsMax = result.size()
				,max = lsMax<(inTurn+1)?(inTurn+1):lsMax ;
			String inSnb = workVO.getsNb();
			StringBuffer bufTmDt = new StringBuffer();
			if(inTurn==0)lsTurn = 0;

			while(idx<max & (idx+lsTurn)<=(idx+lsMax)){
				//System.out.println("\n\n====================\n"+inTurn+"::"+idx+":"+lsTurn+"::"+lsMax+":"+max+"\n====================\n");
				if(inTurn==lsTurn){
					workVO.setsNb(inSnb);
				}else{
					String lsSnb = result.get(idx).getsNb();
					idx++;
					if(inSnb.equals(lsSnb)){
						continue;
					}else{
						workVO.setsNb(lsSnb);
					}
				}
				bufTmDt.delete(0,bufTmDt.capacity());
				bufTmDt.append(workVO.getTmDt().substring(0,8));
				bufTmDt.append("0000");
				bufTmDt.append(lsTurn < 10?"0"+lsTurn:lsTurn);

				workVO.setTmDt(bufTmDt.toString());
				//System.out.println("\n====================\n"+workVO.getTmDt()+"\n====================\n\n");
				lsTurn++;
				cnt = workService.updateBusinessTmdt(workVO);
				LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateBusinessTmdt^_^"+workVO.getsNb());
			}

		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("saveCnt", cnt);
		//model.addAttribute("message", MessageSource.getMessage("success.common.update"));

		//return "work/PrivateWorkView";
		return "basic/result";
	}

	/**
	 * 메모 모아보기 팝업
	 * @MethodName : popUpMemo
	 * @param request
	 * @param personVO
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpMemo.do")
	public String popUpMemo(HttpServletRequest request,
			WorkVO wWo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		if(wWo.getChoiceYear().equals("")){
			// Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMM").format( cal.getTime() );

			wWo.setChoiceYear(date.substring(0, 4));
			//mon = Integer.parseInt(date.substring(4, 6));
			//System.out.println(date);
		}
		wWo.setChoiceMonthS("01");
		wWo.setChoiceMonth("12");
		model.addAttribute("choiceYear", wWo.getChoiceYear());

		if("".equals(wWo.getName())) wWo.setName(loginUser.get("userName").toString());
		if("".equals(wWo.getTmpId()))wWo.setTmpId(loginUser.get("loginId").toString());
		model.addAttribute("tmpId", wWo.getTmpId());

		wWo.setMemo4db("memo");
		try{
			model.addAttribute("memoList", workService.selectMemoList2(wWo));
			//model.addAttribute("replyList", workService.selectReplyList(wWo));
			model.addAttribute("cmntStaffNm",workService.selectSameCommentStaffName(wWo));
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		return "work/popUp/PopUpMemo";
	}

	/**
	 * 탐방 발굴 검토 수정
	 * @MethodName : modifyExploring
	 * @param request
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyExploring.do")
	public String modifyExploring(HttpServletRequest request,
			CpnExcelVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		vo.setRgId(loginUser.get("loginId").toString());
		vo.setOrgId(loginUser.get("orgId").toString());
		model.addAttribute("name", vo.getName());

		workService.updateCompanyExloring(vo);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateCompanyExloring^_^"+vo.getsNb());

		return "work/deal/Exploring";
	}

	/**
	 * 탐방발굴 대상확인 수정
	 * @MethodName : modifyPbr
	 * @param request
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyPbr.do")
	public String modifyPbr(HttpServletRequest request,
			CpnExcelVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		vo.setRgId(loginUser.get("loginId").toString());
		vo.setOrgId(loginUser.get("orgId").toString());
		model.addAttribute("name", vo.getName());

		workService.updateCompanyPbr(vo);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateCompanyPbr^_^"+vo.getsNb());

		return "work/deal/Exploring";
	}

	/**
	 * 탐방발굴 의견 수정
	 * @MethodName : modifyOpinion
	 * @param request
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/modifyOpinion.do")
	public String modifyOpinion(HttpServletRequest request,
			CpnExcelVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		vo.setRgId(loginUser.get("loginId").toString());
		vo.setOrgId(loginUser.get("orgId").toString());
		model.addAttribute("name", vo.getName());

		workService.updateCompanyOpinion(vo);
		LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateCompanyOpinion^_^"+vo.getsNb());

		return "work/deal/Exploring";
	}

	/**
	 * 딜 > 의견팝업페이지에서 분석, 제안서 입력
	 * @MethodName : insertDealINallDeal
	 * @param request
	 * @param response
	 * @param wvo
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/work/insertDealINallDeal.do")
	public String insertDealINallDeal(
			HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("wvo") WorkVO wvo,
			HttpSession session,
			ModelMap model){
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		wvo.setRgId(loginUser.get("loginId").toString());
		wvo.setOrgId(loginUser.get("orgId").toString());
		String rtnPath = "";

		cal.setTime( new Date(System.currentTimeMillis()) );
		String date = new SimpleDateFormat("yyyyMMdd").format( cal.getTime() );

		wvo.setRgNm(loginUser.get("userName").toString());
		wvo.setMiddleOfferCd("00000");
		wvo.setInfoProvider("0");
		wvo.setSupporter("0");
		wvo.setRcmdSnb("0");

		try{
			// 정보 받기
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
				//choiceYear=2016&choiceMonthS=09&tmDt=2016-09-07

			//rtnPath = "redirect:/recommend/comment.do?sNb="+(String) multipartRequest.getParameter("tmpNum1") + "&tmDt=" + (String)multipartRequest.getParameter("tmDt");
			wvo.setCpnId( (String) multipartRequest.getParameter("cpnId"));
			wvo.setMemo( (String) multipartRequest.getParameter("memo"));
			wvo.setOfferCd( (String) multipartRequest.getParameter("offerCd"));
			wvo.setTmDt(date);

			workService.insertDealINallDealByIbSystem(wvo,multipartRequest);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.insertDeal");


			// maxSnb 구하기
			List<WorkVO> rslt = workService.selectMaxSnbINopinion(wvo);

			// 파일업로드 시키기
			MultiFileUpload mUpload = new MultiFileUpload("");
			FileUpDbVO fileVo = new FileUpDbVO();

			fileVo.setOfferSnb(rslt.get(0).getsNb());
			fileVo.setReportYN("N");
			fileVo.setFileCategory("00000"); //00000:정보정리, 00001: staff사진 ,  00002: 댓글 첨부파일, 00003: 인사관리->이력서파일

			fileVo.setRgId(loginUser.get("loginId").toString());
			fileVo.setOrgId(loginUser.get("orgId").toString());

			mUpload.fileUpload(multipartRequest, fileVo, request);

		}catch (Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		return rtnPath;
	}
	/**
	 * 업무일지 > 정보 > 분석의견
	 * @MethodName : analysisComments
	 * @param request
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/analysisComments.do")
	public String analysisComments(HttpServletRequest request,
			WorkVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		model.addAttribute("ttT", vo.getTotal());
		model.addAttribute("TAB", vo.getPage());
		model.addAttribute("name", vo.getName());

		try{
			model.addAttribute("financingList", workService.selectAnalysisCommentsList(vo));
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}


		return "work/keyPointChk/AnalysisComments";
	}

	/**
	 * 업무일지 > 정보 > matrix
	 * @MethodName : matrix
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : user
	 * @since : 2015. 4. 9.
	 */
	@RequestMapping(value="/work/matrix.do")
	public String matrix(WorkVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());
		model.addAttribute("search", vo.getSearch());
		model.addAttribute("tmpNum", vo.getTmpNum1());

		if(vo.getTmpNum1().equals("1")) {//needs
			vo.setTmpNum2(vo.getSearch());
			vo.setSearch("");
		}
		try{
			List<WorkVO> result = workService.selectMatrixList(vo);
			model.addAttribute("matrixList", result);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		return "work/keyPointChk/Matrix";
	}
	/**
	 * 업무일지 > 정보정리 > 정보등록 : 리포트 체크박스 ajax
	 * @MethodName : updateFileInfoCheckReport
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : user
	 * @since : 2015. 4. 23.
	 */
	@RequestMapping(value="/work/updateFileInfoCheckReport.do")
	public String updateFileInfoCheckReport(WorkVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		try{
			model.addAttribute("result",workService.updateFileInfoCheckReport(vo));
		}catch(Exception e){
			e.printStackTrace();
		}

		return "basic/result";
	}

	/**
	 * 딜 > mna > 매칭회사 의견 수정
	 * @MethodName : matchComment
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : user
	 * @since : 2015. 5. 15.
	 */
	@RequestMapping(value="/work/matchComment.do")
	public String matchComment(WorkVO vo,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		vo.setRgId(loginUser.get("loginId").toString());
		vo.setOrgId(loginUser.get("orgId").toString());
		LOG.info(loginUser.get("loginId").toString());

		try{
			workService.updateMnaMatchComment(vo);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateMnaMatchComment^_^"+vo.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		return "work/keyPointChk/Matrix2";
	}

	/**
	 *
	 * @MethodName : changeMiddleOfferCd
	 * @param request
	 * @param session
	 * @param vo
	 * @param model
	 * @return
	 * @throws Exception
	 * @author : user
	 * @since : 2015. 6. 9.
	 */
	@RequestMapping(value="/work/changeMiddleOfferCd.do")
	public String changeMiddleOfferCd(HttpServletRequest request,
			WorkVO vo,
			ModelMap model) throws Exception{

		HttpSession session = request.getSession();
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		vo.setRgId(loginUser.get("loginId").toString());
		vo.setOrgId(loginUser.get("orgId").toString());
		LOG.info(loginUser.get("loginId").toString());

		int cnt = 0;
		try{
			cnt = workService.updateMiddleOfferCd(vo);
			LOG.debug(loginUser.get("loginId").toString()+"^_^workService.updateMiddleOfferCd^_^"+vo.getsNb());
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", cnt);
		model.addAttribute("message", MessageSource.getMessage("success.common.update"));
		return "work/deal/DealSend";
	}






	//------------------------------------------- 정보등급 관련 :S ----------------------------------------------

	/**
	 * 정보등급보기 팝업 화면
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 22.
	 */
	@RequestMapping(value="/work/infoLevelPopup.do")
	public String infoLevelPopup(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		model.addAllAttributes(map);	//모든 받은 정보 그대로 전달

		return "work/infoLevelPopup";
    }


	/**
	 * 정보등급별 사용자 리스트 json
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 5. 2.
	 */
	@RequestMapping(value = "/work/getInfoLevelUser.do")
	public void getInfoLevelUser(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());


		List<Map> list = workService.getInfoLevelUser(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송

	}


	/**
	 * 투자심의 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 05. 25.
	 */
	@RequestMapping(value = "/work/investPopup.do")
	public String investPopup(HttpServletRequest request, HttpServletResponse response, ModelMap model,
								HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());


		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		return "work/investPopup/pop";
	}





	//////////////////////////////////////////모바일 추가구현.
	/**
	 * 사람 찾기 jsp 호출 (모바일 ajax)
	 * @MethodName : popUpCst
	 * @param request
	 * @param workVO
	 * @param personVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpCstDiv.do")
	public String popUpCstDiv(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			WorkVO workVO,
			PersonVO personVO,
			ModelMap model) throws Exception{
		model.addAttribute("MDf", workVO.getModalFlag());
		return "m/schedule/personPopUp";
	}
	/**
	 * 회사 찾기 jsp 호출 (모바일 ajax)
	 * @MethodName : popUpCst
	 * @param request
	 * @param workVO
	 * @param personVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpCpnDiv.do")
	public String popUpCpnDiv(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			WorkVO workVO,
			PersonVO personVO,
			ModelMap model) throws Exception{
		System.out.println(workVO.getModalFlag());
		 model.addAttribute("MDf", workVO.getModalFlag());
		return "m/schedule/companyPopUp";
	}
	/**
	 * 사람 찾기 리스트 및 페이징 (모바일 ajax)

	 */
	@RequestMapping(value="/work/popUpCstAjax.do")
	public void popUpCstAjax(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			WorkVO workVO,
			PersonVO personVO,
			ModelMap model) throws Exception{
		request.setCharacterEncoding("UTF-8");
		int totCnt = 0;
		List<PersonVO> result = null;
		Map<String, Object> map = new HashMap<String, Object>();

		Map<String,Object> resultmap = new HashMap<String, Object>();
        PaginationInfo paginationInfo = new PaginationInfo();
        resultmap.put("searchName", workVO.getCstNm());
        resultmap.put("MDf", workVO.getModalFlag());
        resultmap.put("MDn", workVO.getModalNum());
        resultmap.put("sortTitle", workVO.getSort_t());


        paginationInfo.setCurrentPageNo(personVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(5);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(5);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		personVO.setFirstIndex(firstRecordIndex);
		personVO.setRecordCountPerPage(recordCountPerPage);

		if(personVO.getCpnNm() != null && personVO.getCpnNm().length() != 0)  resultmap.put("YN", "Y");


		try{
			result = personMgmtService.selectPersonList(personVO);
			totCnt = personMgmtService.selectPersonListCnt(personVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		map.put("resultList", result);
		String  paging = PagingAjax.getPaging(personVO.getPageIndex(), totCnt, paginationInfo.getRecordCountPerPage(),  paginationInfo.getPageSize(),"getPagingList","0","iP","");
		resultmap.put("paging",  paging);
		resultmap.put("searchList",  map.get("resultList"));

		AjaxResponse.responseAjaxMap(response, resultmap);
	}

	/**
	 * 회사 찾기 리스트 및 페이징 (모바일 ajax)
	 * @MethodName : popUpCpn
	 * @param request
	 * @param workVO
	 * @param companyVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/work/popUpCpnAjax.do")
	public void popUpCpnAjax(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			WorkVO workVO,
			CompanyVO companyVO,
			ModelMap model) throws Exception{

		int totCnt = 0;
		List<CompanyVO> result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String,Object> resultmap = new HashMap<String, Object>();
        PaginationInfo paginationInfo = new PaginationInfo();
        resultmap.put("searchName", workVO.getCpnNm());
        resultmap.put("MDf", workVO.getModalFlag());
        resultmap.put("MDn", workVO.getModalNum());

        //System.out.println(companyVO.getPageIndex());

        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());//현재 페이지 번호
        paginationInfo.setRecordCountPerPage(5);//한 페이지에 게시되는 게시물 건수
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
		map.put("resultList", result);

        paginationInfo.setTotalRecordCount(totCnt);
        String  paging = PagingAjax.getPaging(companyVO.getPageIndex(), totCnt, paginationInfo.getRecordCountPerPage(),  paginationInfo.getPageSize(),"getPagingList","0","c","");
		resultmap.put("paging",  paging);
		resultmap.put("searchList",  map.get("resultList"));

		AjaxResponse.responseAjaxMap(response, resultmap);
	}

	/**
	 * 회사 등록화면(모바일)
	 * @MethodName : rgstCst
	 * @param companyVO
	 * @param personVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/m/popRegistCpn.do")
	public String popRegistCpnt(@ModelAttribute("companyVO") CompanyVO companyVO,
			HttpSession session,
			ModelMap model){

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		//System.out.println("===========등록할 회사이름:"+companyVO.getSearchCpnNm()+"==============");
		List<CompanyVO> result = null;
		try{
			result = companyService.selectMaxCpnId(companyVO);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		model.addAttribute("maxCpnId", result.get(0).getCpnId());
		model.addAttribute("cpnNm", companyVO.getSearchCpnNm());
		model.addAttribute("MDf", companyVO.getModalFlag());
		model.addAttribute("MDn", companyVO.getModalNum());
		LOG.info(loginUser.get("loginId").toString()+"^_^"+companyVO.getSearchCpnNm());

		return "m/schedule/RegistCPN";
	}
}