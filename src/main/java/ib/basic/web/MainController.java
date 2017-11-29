package ib.basic.web;

import ib.approve.service.ApproveService;
//import ib.basic.service.UserModuleService;
import ib.board.service.AlarmService;
import ib.business.service.BusinessService;
import ib.card.service.CardService;
import ib.cmm.FileUpDbVO;
import ib.cmm.LoginVO;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.EgovFileScrty;
import ib.file.service.FileService;
import ib.login.service.StaffVO;
import ib.person.service.PersonService;
import ib.personnel.service.ManagementService;
import ib.project.service.ProjectMgmtService;
import ib.schedule.service.ScheduleService;
import ib.schedule.service.impl.ScheduleVO;
import ib.system.service.MenuRegService;
import ib.system.service.OrgCompanyRegService;
import ib.system.service.TabPerRoleService;
import ib.user.service.UserService;
import ib.work.service.WorkDailyService;
import ib.work.service.WorkService;
import ib.work.service.WorkVO;
import ib.worktime.service.WorktimeService;

import org.apache.commons.codec.binary.Base64;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Arrays;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MainController {


    @Resource(name = "personService")
    private PersonService personService;

    @Resource(name = "workService")
    private WorkService workService;

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "menuRegService")
	private MenuRegService menuRegService;

	@Resource(name = "tabPerRoleService")
	private TabPerRoleService tabPerRoleService;

	@Resource(name = "alarmService")
	private AlarmService alarmService;

	@Resource(name = "orgCompanyRegService")
	private OrgCompanyRegService orgCompanyRegService;

	@Resource(name = "workDailyService")
	private WorkDailyService workDailyService;

	@Resource(name = "scheService")
	private ScheduleService scheService;

	@Resource(name = "approveService")
	private ApproveService approveService;

	@Resource(name = "worktimeService")
	private WorktimeService worktimeService;

    @Resource
	private BusinessService businessService;

    @Resource(name = "managementService")
    private ManagementService managementService;

    @Resource(name = "fileService")
    private FileService fileService;

	@Resource(name = "projectMgmtService")
	private ProjectMgmtService projectMgmtService;

	@Resource(name = "cardService")
	private CardService cardService;
	/*
	@Resource(name="userModuleService")
	private UserModuleService userModuleService;
	*/

	/** log */
    protected static final Log LOG = LogFactory.getLog(MainController.class);


	/**
	 * 기본화면으로 진입
	 *
	 * @param
	 * @return 첫 화면
	 * @exception Exception
	 */
	@RequestMapping(value="/index.do")
	public String index(ModelMap model,
			HttpSession session,
			HttpServletRequest request) throws Exception{

		String targetUrl = "basic/MainLogin/noHeader";

		if(session.getAttribute("baseUserLoginInfo") != null){
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");

			int permission = Integer.parseInt(loginUser.get("permission").toString());

			/*String mobileCheck = "";
			String userAgent = request.getHeader("user-agent");
			String[] browser = {"iPhone", "iPod","Android"};

			for (int i = 0; i < browser.length; i++) {
			    if(userAgent.matches(".*"+browser[i]+".*")){
			    	mobileCheck = "1";
			    	targetUrl = "redirect:m/login.do";
			    }
			}*/



			if( permission == -2000 ) // 외부 1, 당분간 적용되지 않게 -2000 으로 적용
				targetUrl = "basic/MainSis";
			else
				targetUrl = "redirect:basic/mainLogo.do";		//basic/mainNews";
		}

    	return targetUrl;
    }



	/**
	 *
	 * 로그인
	 *
	 * @MethodName : loginProcess
	 * @param
	 * @param session
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/loginProcess.do")
	public void loginProcessAll(
								StaffVO staffVO,
								HttpSession session,
								HttpServletRequest request,
								HttpServletResponse response,
								ModelMap model,
								@RequestParam Map<String,Object> map) throws Exception {


		Map obj = new HashMap();		//결과 반환 obj

		obj.put("loginId", "");

		///////////////// user info ///////////////
		map.put("loginId", staffVO.getUsrId());										//로그인 아이디
		if("Y".equals((String)map.get("pwdNoEnc"))){								//이미 암호화 된 비번인지
			map.put("userPwd", staffVO.getUsrPw());									//그대로 전달세팅
		}else{
			map.put("userPwd", EgovFileScrty.encryptPassword(staffVO.getUsrPw()));	//패스워드 암호화
		}

		Map baseInfo = userService.getUserLoginInfo(map);							//사용자정보 가져옴

		if (baseInfo != null) {		//사용자가 있을때 (정상 로그인)
        	String requestUrl = request.getServerName();  //로그인 접속 URL
        	String domain = baseInfo.get("domain").toString();

        	boolean isOperation = true;  //운영서버여부
        	if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") >= 0)  isOperation = false;  //개발
            else isOperation = true;  // 운영

        	if(requestUrl.indexOf("www") >= 0) requestUrl = requestUrl.replaceAll("www", "synergy");
        	if(domain.indexOf("www") >= 0) domain = domain.replaceAll("www", "synergy");

        	//2016.12.29. 이인희 시스템 사용여부가 'N'이면 로그인 비허용함
        	if("N".equals(baseInfo.get("systemYn").toString())){
        		obj.put("systemYn", "N");		//시스템 사용여부

        	}else if("N".equals(baseInfo.get("enable").toString()) || "N".equals(baseInfo.get("useYn").toString())){  //사용여부 'N' 또는 유효여부 'N' 이면 접속불가
        		obj.put("checkUseYn", "N");		//사용여부

        	}else if(domain.indexOf(requestUrl) < 0 && isOperation){
        		obj.put("domainYn", "N");		//2017.03.15. 등록된 도메인으로 접속하지 않을시 접속불가

        	}else{
        		//---------------------------- 기본 정보 :S ----------------------------
	        	session.setAttribute("baseUserLoginInfo", baseInfo);				//■■ 사용자 기본정보 세션 ■■

	        	//최고권한자 (masterKey=="MASTER")
	        	if("SYS_MGR".equals(baseInfo.get("userRole").toString())){		//권한코드(BS_ROLE_LIST.ROLE_CODE) 가 "SYS_MGR"(시스템매니저) 인 계정만
	        		baseInfo.put("masterKey", "MASTER");
	        	}else{
	        		baseInfo.put("masterKey", "N");
	        	}

	        	//개인정보 동의 여부
	        	String ruleAgreeYn = "N";

	        	if("Y".equals(baseInfo.get("userRuleInfoYn").toString()) && "Y".equals(baseInfo.get("userProcessInfoYn").toString())){
	        		ruleAgreeYn = "Y";
	        	}

	        	session.setAttribute("ruleAgreeYn", ruleAgreeYn);

	        	//---------------------------- 기본 정보 :E ----------------------------



	        	//---------------------------- menu 정보 :S ----------------------------
				Map<String,String> mParam = new HashMap<String,String>();		//parameter map
				///top
				mParam.put("userRoleId", 	baseInfo.get("userRoleId").toString());
				mParam.put("menuLoc", 		"TOP");
				mParam.put("orgId", 		baseInfo.get("applyOrgId").toString());
				mParam.put("vipAuthYn", 	baseInfo.get("vipAuthYn").toString());
				List<Map> top = menuRegService.getMenuByRole(mParam);
				//--- openPageTrgt (열리는 페이지의 페이지정보(해당메뉴 열림 표시 위해))

				StringBuffer menuFilterStr = new StringBuffer();				//화면에 들어가기 전 인터셉터에서 한번 체크하고 들어가도록(보안상추가)


				this.setMenuInfo(top, menuFilterStr, baseInfo.get("userRoleId").toString(), null, null);		//메뉴 정보 및 menuFilterStr 생성 함수 call


				session.setAttribute("menuFilterStr", menuFilterStr.toString());	//■■ 사용자메뉴 세션(허용메뉴 진입체크용) ■■

				//---S 업무일지 > 정보등록(영업정보)시 권한체크 임시로직, 차후삭제 필요 2017.04.13. 이인희
				String isBusinessInfoList = "N";
				for(int i=0; i<top.size(); i++){
					if(top.get(i).get("menuEng") != null && top.get(i).get("menuEng").equals("BUSINESS_INFO_LIST")){
						isBusinessInfoList ="Y";
						break;
					}
				}
				session.setAttribute("isBusinessInfoList", isBusinessInfoList);
				//---E

				//---근태관리 권한유무(메인팝업 권한체크를 위해 - 현지출근 직원안내등
				String isSpotWork = "N";
				for(int i=0; i<top.size(); i++){
					if(top.get(i).get("menuEng") != null && top.get(i).get("menuEng").equals("USER_ATTENDANCE")){
						isSpotWork ="Y";
						break;
					}
				}
				session.setAttribute("isSpotWork", isSpotWork);
				//---E

				obj.put("menu", top);		//메뉴
				//---------------------------- menu 정보 :E ----------------------------

				//---------------------------- 접속 가능한 관계사 리스트 :S ---------------
				List<Map> orgIdList = userService.getAccessOrgIdList(baseInfo);


				//로고 변환
				for (int i = 0; i < orgIdList.size(); i++) {
					if (orgIdList.get(i).get("orgLogo") != null) {

						byte[] img = (byte[]) (orgIdList.get(i).get("orgLogo"));
						Base64 codec = new Base64();
						orgIdList.get(i).put("orgLogo", codec.encodeBase64String(img));
					}
				}

				session.setAttribute("accessOrgIdList", orgIdList);					//■■ 나의 관계사리스트 세션 ■■
				obj.put("accessOrgIdList", orgIdList);		//조회가능 관계사 리스트
				//---------------------------- 접속 가능한 관계사 리스트 :S ---------------


				//오늘 등록된 관계사 수
				int orgCnt = orgCompanyRegService.checkOrgCompany(map);
				if(orgCnt > 0){
					obj.put("orgNewYn", "Y");
				}else
					obj.put("orgNewYn", "N");


				//로그인id 화면반환 - 정상로그인확인용
				obj.put("loginId", baseInfo.get("loginId"));

				//----------------------------------  로그인 출근처리 :S --------------------------------------
				Map<String,Object> paramMap = new HashMap<String, Object>();
		        paramMap.put("userId", baseInfo.get("userId").toString());
				paramMap.put("orgId", baseInfo.get("orgId").toString());
		        paramMap.put("applyOrgId", baseInfo.get("applyOrgId").toString());
		        paramMap.put("loginAttend", "Y");

		        //출근위치는 하드코딩 (16.12.21)
	    		//paramMap.put("inContactLoc",map.get("loginLoc"));

		        String contactDevice = map.get("loginLoc").toString();				//접속 정보(PC or Mobile)

		        if((contactDevice.toLowerCase()).equals("mobile")) paramMap.put("inContactLoc","mobile");
		        else paramMap.put("inContactLoc","pc");


	    		//클라이언트 아이피
	    		String loginIp = request.getHeader("HTTP_X_FORWARDED_FOR");
	            if(loginIp == null || loginIp.length() == 0 || loginIp.toLowerCase().equals("unknown")){
	                loginIp = request.getHeader("REMOTE_ADDR");
	            }

	            if(loginIp == null || loginIp.length() == 0 || loginIp.toLowerCase().equals("unknown")){
	                loginIp = request.getRemoteAddr();
	            }
	            paramMap.put("inContactIp", loginIp);

		        //로그인 출근 연동여부를 판단하여 출근처리한다.
		        /*Integer attendCount = userService.getUserAttendCnt(paramMap);
		        if(attendCount>0){
		        	//오늘의 근태정보 조회
			        EgovMap todayWorkInfo = managementService.getTodayWorkInfo(paramMap);

			        if(todayWorkInfo!=null && todayWorkInfo.get("inTime") == null){
			        	try {
			        		managementService.processWorcAjax(paramMap);
			        	}catch(Exception e) {
			        		LOG.info("근태정보 처리중 오류............................");
			    			e.printStackTrace();
			    			//throw e;
			    		}
			        }
		        }*/

	            /*************수정 - jy 2017.09.29 모바일 여부 추가*************/

	            String attendYn = baseInfo.get("attendYn").toString();				//출근 연동여부
	            String loginAttend = baseInfo.get("loginAttend").toString();		//PC 출근 연동여부
	            String mobileAttend = baseInfo.get("mobileAttend").toString();		//모바일 출근 연동여부


	            boolean checkLogin = false;

	            if(attendYn.equals("Y")){	//출근 연동


	            	if(contactDevice.equals("MOBILE") && mobileAttend.equals("N")) checkLogin = false; //mobile 접속인데 모바일출근 N 이면
	            	else if(contactDevice.equals("PC") && loginAttend.equals("N")) checkLogin = false; //PC 접속인데 PC 출근 N 이면
	            	else  checkLogin = true;

	            	if(checkLogin){
	            		//오늘의 근태정보 조회
				        EgovMap todayWorkInfo = managementService.getTodayWorkInfo(paramMap);

				        if(todayWorkInfo!=null && todayWorkInfo.get("inTime") == null){
				        	try {
				        		managementService.processWorcAjax(paramMap);
				        	}catch(Exception e) {
				        		LOG.info("근태정보 처리중 오류............................");
				    			e.printStackTrace();
				    			//throw e;
				    		}
				        }
				    }
	            }

	            session.setAttribute("checkLogin", checkLogin); //출근 버튼 노출여부

		      //----------------------------------  로그인 출근처리 :E --------------------------------------
		      //----------------------------------  로그인 이력저장 :S --------------------------------------
		      if(map.get("loginLoc")!=null){
		    	  paramMap.put("loginLoc", map.get("loginLoc"));
		    	  String loginLoc = map.get("loginLoc").toString();
		    	  try {
		    		  managementService.processLoginHist(paramMap);
		    	  }catch(Exception e) {
		    		  	LOG.info("로그인 이력 저장 오류............................");
		    			e.printStackTrace();
		    			//throw e;
		    		}
		      }
		      //----------------------------------  로그인 이력저장 :E --------------------------------------

		      //관계사 퀵메뉴 조회
		      paramMap.put("mainYn", "Y");
		      List<EgovMap> sessionQuickLinkList = managementService.getQuickLinkList(paramMap);
		      session.setAttribute("sessionQuickLinkList", sessionQuickLinkList);
        	}

		}
		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}


	//메뉴 정보 세팅
	private void setMenuInfo(List<Map> top, StringBuffer menuFilterStr, String roleId, String orgId, String userId) throws Exception{

		for(int i=0; i<top.size(); i++){
			//K.MENU_ID, '|', K.MENU_PARENT_ID, '|', K.MENU_ROOT_ID, '|', K.MENU_LEVEL
			if(top.get(i).get("openPageTrgt") != null){
				String[] trgt = top.get(i).get("openPageTrgt").toString().split("\\|");
				top.get(i).put("trgtMenuId", trgt[0]);
				top.get(i).put("trgtMenuUpId", trgt[1]);
				top.get(i).put("trgtMenuRootId", trgt[2]);
				top.get(i).put("trgtDepth", trgt[3]);
				top.get(i).put("trgtMenuRootEng", trgt[4]);		//코드

			}else{	//하위메뉴가 없이 root 메뉴 혼자일경우
				top.get(i).put("trgtMenuId", top.get(i).get("menuId"));		//본인 id 로 trgtMenuId 만 세팅
			}



			//menuFilterStr (허용 메뉴 문자열- 진입시 체크)		... ①
			Object obj1 = top.get(i).get("menuPath");
			if(obj1 != null){
				menuFilterStr.append(top.get(i).get("menuPath").toString().replaceAll(".do", ","));
			}

		}


		//menuFilterStr (허용 메뉴 문자열- 진입시 체크)			... ②	 (메뉴 외 탭, 버튼 등 권한 추가)
		Map tParam = new HashMap<String,String>();
		//roleId 만을 가지고 메뉴정보를 가져온다 (로그인 시)
		tParam.put("roleId", 	roleId);
		//orgId 와 userId 를 가지고 메뉴정보를 가져온다 (관계사 applyOrgId 바꿀시)
		tParam.put("orgId",		orgId);
		tParam.put("userId", 	userId);

		List<Map> list = tabPerRoleService.getTabPerRole(tParam);
		for(int i=0; i<list.size(); i++){
			Object obj2 = list.get(i).get("menuPath");
			if(obj2 != null){
				menuFilterStr.append(list.get(i).get("menuPath").toString().replaceAll(".do", ","));
			}
		}

	}


	/**
	 * 권한 관계사 변경시
	 *
	 * @MethodName : processChangeOrgId
	 * @param loginVO
	 * @param session
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/processChangeOrgId.do")
	public void processChangeOrgId(
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response,
									@RequestParam Map<String,Object> map) throws Exception {
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String userId = baseUserLoginInfo.get("userId").toString();

		map.put("userId", userId);

		Map obj = new HashMap<String,String>();

		Integer accessChk = userService.getAccessOrgIdCnt(map);		//요청 orgId 의 권한이 있는지 체크
		Map baseInfo = null;
		if(accessChk >0){											//권한이 있다면
			obj.put("result", "success");

			Map<String,Object> searchMap = new HashMap<String, Object>();

			searchMap.put("orgId", map.get("orgId"));
			searchMap.put("loginId", baseUserLoginInfo.get("loginId"));

			baseInfo = userService.getBaseUserInfo(searchMap);
        	//Map baseInfo = userService.getUserLoginInfo(searchMap);

			if(baseInfo != null){
				//세션에 orgId, userRoleId, orgBasicAuth 변경
	        	baseUserLoginInfo.put("applyOrgId", map.get("orgId"));
	        	baseUserLoginInfo.put("applyOrgNm", baseInfo.get("applyOrgNm"));
	        	baseUserLoginInfo.put("userRoleId", baseInfo.get("userRoleId"));
				baseUserLoginInfo.put("orgBasicAuth",baseInfo.get("orgBasicAuth"));
				baseUserLoginInfo.put("projectTitle",baseInfo.get("projectTitle"));
				baseUserLoginInfo.put("activityTitle",baseInfo.get("activityTitle"));
				baseUserLoginInfo.put("vipAuthYn",baseInfo.get("vipAuthYn"));

				//---------------------------- 접속 가능한 관계사 리스트 :S ---------------
				List<Map> orgIdList = userService.getAccessOrgIdList(baseInfo);


				//로고 변환
				for (int i = 0; i < orgIdList.size(); i++) {
					if (orgIdList.get(i).get("orgLogo") != null) {

						byte[] img = (byte[]) (orgIdList.get(i).get("orgLogo"));
						Base64 codec = new Base64();
						orgIdList.get(i).put("orgLogo", codec.encodeBase64String(img));
					}
				}

				session.setAttribute("accessOrgIdList", orgIdList);					//■■ 나의 관계사리스트 세션 ■■

			}else{
				obj.put("result", "fail");
			}

		}else
			obj.put("result", "fail");



		//------------------------ 해당 관계사 권한의 메뉴정보 :S ------------------------
		if(accessChk >0 && baseInfo != null){

			Map<String,String> mParam = new HashMap<String,String>();		//parameter map
			//top
			mParam.put("userId", 	userId);
			mParam.put("orgId",		map.get("orgId").toString());
			mParam.put("menuLoc", 	"TOP");
			mParam.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());
			List<Map> top = menuRegService.getMenuByRole(mParam);
			//--- openPageTrgt (열리는 페이지의 페이지정보(해당메뉴 열림 표시 위해))

			StringBuffer menuFilterStr = new StringBuffer();				//화면에 들어가기 전 세션에서 한번 체크하고 들어가도록(보안상추가)


			this.setMenuInfo(top, menuFilterStr, "", map.get("orgId").toString(), userId);		//메뉴 정보 및 menuFilterStr 생성 함수 call

			session.setAttribute("menuFilterStr", menuFilterStr.toString());

			obj.put("menu", top);		//메뉴
		}
		//------------------------ 해당 관계사 권한의 메뉴정보 :E ------------------------

		//관계사 퀵메뉴 조회
		Map<String,Object> quickLinkMap = new HashMap<String, Object>();
		quickLinkMap.put("orgId", map.get("orgId"));
		quickLinkMap.put("mainYn", "Y");
        List<EgovMap> sessionQuickLinkList = managementService.getQuickLinkList(quickLinkMap);
        session.setAttribute("sessionQuickLinkList", sessionQuickLinkList);

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}


    /**
     * 로그아웃
     * @MethodName : logout
     * @param session
     * @return
     */
    @RequestMapping("/logout.do")
    public String logout(HttpSession session) {
        //session.setAttribute("userLoginInfo", null);
        session.invalidate();
        return "redirect:/";
    }


	/**
	 * Main - Content
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return Content Page
	 * @exception Exception
	 */
	@RequestMapping(value="/basic/selectContent.do")
	public String selectContent(ModelMap model){
//		System.out.println("===========selectContent==============");
		return "redirect:/";
	}




	/**
	 * 메인 화면 New (161114)
	 * @MethodName : selectMainLogo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/basic/mainLogo.do")
	public String selectMainLogo(
			@RequestParam Map<String,Object> paramMap,
			HttpServletRequest request,
			HttpSession session,
			Model model) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();
		String applyOrgId = baseUserLoginInfo.get("applyOrgId").toString();

		if(!orgId.equals(applyOrgId)){
			paramMap.put("searchApplyOrgId", "Y");
		}

		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", orgId);
        paramMap.put("applyOrgId", applyOrgId);
        paramMap.put("roleId",baseUserLoginInfo.get("userRoleId").toString());


        //모듈 리스트
        List <EgovMap> moduleList = null;

        moduleList = userService.getUserModuleList(paramMap);

        model.addAttribute("moduleList", moduleList);

		/*String moduleCodeStr = "";
		for(int i = 0 ; i < moduleList.size();i++){
			moduleCodeStr += "|"+moduleList.get(i).get("moduleCode")+"|";
		}

		model.addAttribute("moduleCodeStr", moduleCodeStr);*/

		// TO-BE에서 쓰는기능 : S ////////////////////////////////////////////////////

        //////////////좌측 전자결재 :S////////////////////////////////////////////////

		//전자결재 진행중 문서 cnt
		paramMap.put("searchMainCnt","Y");

		paramMap.put("searchMainType","WORKING");
		Integer approveWorkingCnt = approveService.getDraftDocListTotalCnt(paramMap);
		model.addAttribute("approveWorkingCnt", approveWorkingCnt);
		//전자결재 종결 문서 cnt
		paramMap.put("searchMainType","END");
		Integer approveEndCnt = approveService.getDraftDocListTotalCnt(paramMap);
		model.addAttribute("approveEndCnt", approveEndCnt);

		//전자결재 결재할 문서 cnt..
		Map<String, Object> contentMarkRuleMap = new HashMap<String, Object>();
		 if(!orgId.equals(applyOrgId)){
			 contentMarkRuleMap.put("searchApplyOrgId", "Y");
		}
		contentMarkRuleMap.put("orgId", orgId);
		contentMarkRuleMap.put("applyOrgId", applyOrgId);
		contentMarkRuleMap.put("userId", baseUserLoginInfo.get("userId"));
		contentMarkRuleMap.put("useYn", "Y");
		contentMarkRuleMap.put("listType", "pendList");

		contentMarkRuleMap.put("newContentMarkClass", "APPV");
		contentMarkRuleMap.put("newContentMarkType", "APPROVER");

		// 조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		contentMarkRuleMap.put("ruleUseYn", "N");
		List<EgovMap> markRuleList = managementService.markRuleListList(contentMarkRuleMap);
		markRuleList = managementService.markRuleListList(contentMarkRuleMap);

		if (markRuleList != null && markRuleList.size() == 1) {

			EgovMap ruleMap = markRuleList.get(0);
			contentMarkRuleMap.put("ruleUseYn", "Y");
			contentMarkRuleMap.put("readTimeYn", ruleMap.get("readTimeYn"));
			contentMarkRuleMap.put("markDayCnt", ruleMap.get("markDayCnt"));
		}

		Integer menuApprovePending = approveService.getMenuApproveReqList(contentMarkRuleMap);
		model.addAttribute("approveReqCnt", menuApprovePending);
		 //////////////좌측 전자결재 :E////////////////////////////////////////////////

		//////////////좌측 지출등록 :S////////////////////////////////////////////////

		//개인 승인 / 미승인 카운트 조회
		paramMap.put("searchUserYn", "Y");
		List<EgovMap> userCardApproveYnList =  cardService.getApproveYnCntMapList(paramMap);
		model.addAttribute("userCardApproveYnList",userCardApproveYnList);

		//지출 법인카드연동정보
		String orgCardLinkYn = "N";
		EgovMap baseInfo = cardService.baseInfo(paramMap);

		//승인자 여부
		String staffYn = "N";
		if(baseInfo!=null){
			orgCardLinkYn = baseInfo.get("orgCardLinkYn").toString();
		}
		Map<String,Object> cardSearchMap = new HashMap<String, Object>();
		cardSearchMap.put("orgId", applyOrgId);
		cardSearchMap.put("userId", baseUserLoginInfo.get("userId"));
		cardSearchMap.put("mainCnt", "Y");
		// 지출입력설정조회
		EgovMap baseSetupInfo = cardService.getCardExpenseSetupDetail(cardSearchMap);

		String staffUserId = baseSetupInfo == null||baseSetupInfo.get("staffUserId")==null?"":baseSetupInfo.get("staffUserId").toString();
		String staffDeptId = baseSetupInfo == null||baseSetupInfo.get("staffDeptId")==null?"":baseSetupInfo.get("staffDeptId").toString();
		String userId = baseUserLoginInfo.get("userId").toString();
		String deptId = baseUserLoginInfo.get("deptId").toString();
		if(orgCardLinkYn.equals("Y")){

			List<EgovMap> cardCorpUserList = cardService.getCardCorpUsedListForMainPopList(cardSearchMap);

			//개인 미등록 건수
			model.addAttribute("cardCorpUserCnt", cardCorpUserList.size());

			if(staffUserId.equals(userId)||staffDeptId.equals(deptId)){
				cardSearchMap.remove("userId");

				List<EgovMap> cardCorpList = cardService.getCardCorpUsedListForMainPopList(cardSearchMap);

				//전체 미등록 건수
				model.addAttribute("cardCorpCnt", cardCorpList.size());

				cardSearchMap.remove("mainCnt");

				List<EgovMap> cardCorpLongList = cardService.getCardCorpUsedListForMainPopList(cardSearchMap);

				//전체 장기 미등록 건수
				model.addAttribute("cardCorpLongCnt", cardCorpLongList.size());
			}
		}

		if(staffUserId.equals(userId)||staffDeptId.equals(deptId)){
			//전체 승인 / 미승인 카운트 조회
			paramMap.put("searchUserYn", "N");
			List<EgovMap> orgCardApproveYnList =  cardService.getApproveYnCntMapList(paramMap);
			model.addAttribute("orgCardApproveYnList",orgCardApproveYnList);

			staffYn = "Y";
		}

		//승인자여부
		model.addAttribute("staffYn",staffYn);
		//법인카드 연동 y/n
		model.addAttribute("orgCardLinkYn", orgCardLinkYn);
		//////////////좌측 지출등록 :E////////////////////////////////////////////////

		// TO-BE에서 쓰는기능 : E ////////////////////////////////////////////////////







		//////////////////////////////////////////Left 영역 Cnt 정보 Start:S//////////


		/*paramMap.put("searchAppvStatus","REQ");
		paramMap.put("searchDocStatus","APPROVE");
		Integer approveReqCnt = approveService.getReqDocListTotalCnt(paramMap);
		model.addAttribute("approveReqCnt", approveReqCnt);*/
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
		model.addAttribute("approveRefCnt", menuApproveReference);
		//전자결재 참조문서 cnt..
		/*paramMap.put("searchAppvStatus",null);
		paramMap.put("searchDocStatus",null);
		Integer approveRefCnt = approveService.getRefDocListTotalCnt(paramMap);
		model.addAttribute("approveRefCnt", approveRefCnt);*/

		//전자결재 취소승인 권한을 조회한다
		Integer approveExpenseCnt = approveService.getAppvDocExpenseListTotalCnt(paramMap);
		model.addAttribute("approveExpenseCnt", approveExpenseCnt);
		//정보공유 > 정보코멘트 CNT...
		/*paramMap.put("searchMyList","Y");
		Integer infoCnt = businessService.getBusinessCommentListTotalCnt(paramMap);
		model.addAttribute("infoCnt", infoCnt);*/


		//정보공유 > 정보코멘트 CNT...(내가쓴 댓글의 댓글)
		Integer myCommentListCnt = businessService.getBusinessMyCommentListCnt(paramMap);
		model.addAttribute("myCommentListCnt", myCommentListCnt);

		//정보공유 > 정보 공유CNT...(내가쓴 글의 댓글)
		Integer myBusinessComenntCnt = businessService.getMyBusinessComenntCnt(paramMap);
		model.addAttribute("myBusinessComenntCnt", myBusinessComenntCnt);


		//--------업무일지

		paramMap.put("empNo", baseUserLoginInfo.get("empNo").toString());

		//업무일지 > 오늘 내일정
		Integer workDailyCnt = 0;
		if(baseUserLoginInfo.get("orgId").toString().equals(baseUserLoginInfo.get("applyOrgId").toString())){
			workDailyCnt=workDailyService.getWorkDailyLeftCount(paramMap);
		}

		model.addAttribute("workDailyCnt", workDailyCnt);

		//업무일지 > 신규 수신 메모
		Integer newMemoCount = 0;
		if(baseUserLoginInfo.get("orgId").toString().equals(baseUserLoginInfo.get("applyOrgId").toString())){
			newMemoCount=workDailyService.getMemoLeftCount(paramMap);
		}
		model.addAttribute("newMemoCount", newMemoCount);


		//////////////////////////////////////////Left 영역  Cnt 정보 Start:E/////////////////////////////////////////////

		//---------------------------- 알림 팝업 정보 확인 ----------------------------------------
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("orgId", baseUserLoginInfo.get("orgId"));
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));
		Map popupUserInfo = alarmService.selectPopUser(map);		//팝업 해당자 이면 있고 아니면 null

		//알립팝업 조건에 해당하는 사용자에게 팝업 보임
		if(popupUserInfo != null && popupUserInfo.get("alarmIds") != null){
			String alarmIds = (String) popupUserInfo.get("alarmIds");
			String[] idsArray = alarmIds.split(",");
			List<String> popupInfoList = Arrays.asList(idsArray);
			model.addAttribute("popupInfoList", popupInfoList);
			model.addAttribute("popupShow","Y");
		}else{
			model.addAttribute("popupshow", "N");
		}
		//---------------------------- 알림 팝업 정보 확인 ----------------------------------------

		//---------------------------- 일정 알림 팝업 정보 확인 2016.11.24 이인희 추가 ----------------------------------------
		ScheduleVO scheduleVo = new ScheduleVO();
		scheduleVo.setOrgId(baseUserLoginInfo.get("orgId").toString());
		scheduleVo.setApplyOrgId(baseUserLoginInfo.get("applyOrgId").toString());
		scheduleVo.setUserId(baseUserLoginInfo.get("userId").toString());
		scheduleVo.setSearchPerSabun(baseUserLoginInfo.get("empNo").toString());
		scheduleVo.setEventType("Alarm");
		List alarmList = scheService.getScheduleList(scheduleVo);

		//알립팝업 조건에 해당하는 사용자에게 팝업 보임
		if(alarmList.size() > 0){
			model.addAttribute("schedulePopupShow","Y");
		}else{
			model.addAttribute("schedulePopupShow", "N");
		}
		//---------------------------- 일정 알림 팝업 정보 확인 ----------------------------------------

		//---------------------------- 현지출근 알람 팝업 ----------------------------------------
		String isSpotWork = (String)session.getAttribute("isSpotWork");  //근태관리 접근권한 유무
		if("Y".equals(isSpotWork)){
			Map<String,Object> paramSpotWork = new HashMap<String,Object>();
			paramSpotWork.put("orgId", baseUserLoginInfo.get("orgId").toString());
			paramSpotWork.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
			paramSpotWork.put("userId", baseUserLoginInfo.get("userId").toString());
			paramSpotWork.put("mainAlarmType", "scheduleSpotWork");

			List<EgovMap> spotWorkList = scheService.getMainSpotWorkAlarmList(paramSpotWork);

			//알립팝업 조건에 해당하는 사용자에게 팝업 보임
			if(spotWorkList.size() > 0){
				model.addAttribute("spotWorkShow","Y");
			}else{
				model.addAttribute("spotWorkShow", "N");
			}
		}else{
			model.addAttribute("spotWorkShow", "N");
		}
		//---------------------------- 현지출근 알람 팝업----------------------------------------

		//---------------------------- 근태 알림 팝업 정보 확인 2016.12.19 이인희 추가 ----------------------------------------
		Map<String,Object> attendanceParamMap = new HashMap<String,Object>();
		attendanceParamMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		attendanceParamMap.put("searchUserId", baseUserLoginInfo.get("userId").toString());
		attendanceParamMap.put("actionType", "mainPop");

		List<EgovMap> worktimeList = worktimeService.getWorktimeMainList(attendanceParamMap);

		/*model.addAttribute("worktimeList", worktimeList);*/

		//근태알립팝업 조건에 해당하는 사용자에게 팝업 보임
		if(worktimeList.size() > 0){
			model.addAttribute("attendancePopupShow","Y");
		}else{
			model.addAttribute("attendancePopupShow", "N");
		}
		//---------------------------- 휴직 종료 사전 안내 ----------------------------------------
		if("Y".equals(isSpotWork)){
			Map<String,Object> worktimeRestMap = new HashMap<String,Object>();
			worktimeRestMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
			worktimeRestMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
			worktimeRestMap.put("userId", baseUserLoginInfo.get("userId").toString());
			worktimeRestMap.put("mainAlarmType", "worktimeRest");

			//휴직종료 사전안내
			List<EgovMap> worktimeRestList = scheService.getMainSpotWorkAlarmList(worktimeRestMap);

			//출근인정 요청안내
			List<EgovMap> worktimeReqList = worktimeService.getWorktimeReqAlarmList(worktimeRestMap);

			//근태알립팝업 조건에 해당하는 사용자에게 팝업 보임
			if(worktimeRestList.size() > 0 || worktimeReqList.size() > 0){
				model.addAttribute("worktimeRestShow","Y");
			}else{
				model.addAttribute("worktimeRestShow", "N");
			}
		}else{
			model.addAttribute("worktimeRestShow", "N");
		}

		//---------------------------- 전자결재 미결문서 알림 팝업 ----------------------------------------
		Map<String,Object> approveAlarmMap = new HashMap<String, Object>();
		approveAlarmMap.put("type", "pop");
		approveAlarmMap.put("userId", baseUserLoginInfo.get("userId"));
		Integer approveAlarmCnt = approveService.getSendAppvAlarmListTotalCnt(approveAlarmMap);

		if(approveAlarmCnt > 0){
			model.addAttribute("approveAlarmYn","Y");
		}else{
			model.addAttribute("approveAlarmYn", "N");
		}


		//---------------------------- 일정 알림 팝업 정보 확인 ----------------------------------------

		//---------------------------- 알림 팝업 정보 확인 ----------------------------------------

		//---------------------------- 일정 알림 팝업 정보 확인 2016.11.24 이인희 추가 ----------------------------------------

		List<EgovMap> cardCorpUsedList = cardService.getCardCorpUsedListForMainPopList(paramMap);

		//알립팝업 조건에 해당하는 사용자에게 팝업 보임
		if(cardCorpUsedList.size() > 0){
			model.addAttribute("cardCorpUsedPopShow","Y");
		}else{
			model.addAttribute("cardCorpUsedPopShow", "N");
		}
		//---------------------------- 일정 알림 팝업 정보 확인 ----------------------------------------

		//근태권한
		Integer attendCount = userService.getUserAttendCnt(paramMap);
		model.addAttribute("attendCount", attendCount);
		if(attendCount>0){
			//오늘의 근태정보 조회
	        EgovMap todayWorkInfo = managementService.getTodayWorkInfo(paramMap);
	        model.addAttribute("todayWorkInfo", todayWorkInfo);
		}
		String targetUrl = "";
		//int permission = Integer.parseInt(baseUserLoginInfo.get("permission").toString());

		targetUrl = "basic/mainTest";		//targetUrl = "basic/MainLogo";

		return targetUrl;

	}


	/**
	 * 메모 하나 선택
	 * @MethodName : privateMemo
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/main/privateMemo.do")
	public String privateMemo(ModelMap model
			,WorkVO wvo
			,HttpSession session) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";

		try{
			model.addAttribute("cmntStaffNm",workService.selectSameCommentStaffName(wvo));
			model.addAttribute("memoList", workService.selectMemoList(wvo));

			if(wvo.getMainSnb().length()>0){
				wvo.setRepSnb(wvo.getsNb());
				wvo.setsNb(wvo.getMainSnb());
			}
			//model.addAttribute("replyList", workService.selectReplyList(wvo));



		}catch(Exception e){
			e.printStackTrace();
		}
		return "ajaxPopDiv/ajaxMemo/ajax";

	}


	/**
	 * 직원에게 바로 메모보내기
	 * @MethodName : sendNewMemo
	 * @param model
	 * @param wvo
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/main/sendNewMemo.do")
	public String sendNewMemo(ModelMap model
			,WorkVO wvo
			,HttpSession session) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		return "ajaxPopDiv/MainNewMemo/ajax";

	}

	/**
	 * 메인화면 읽은 데이터 확인
	 * db에 insert되면 읽은 것으로 db에 없으면 안읽은 것으로..
	 * @MethodName : checkMainTable
	 * @param model
	 * @param wvo
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/main/checkMainTable.do")
	public String checkMainTable(ModelMap model
			,WorkVO wvo
			,HttpSession session) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";

		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("userId").toString());

		wvo.setRgId(loginUser.get("userId").toString());
		wvo.setOrgId(loginUser.get("orgId").toString());

		try{
			int cnt = workService.insertMainTableCheck(wvo);
			model.addAttribute("save",cnt);

		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/";

	}



	/**
	 *
	 * @MethodName : selectMainLogo2
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login/mainLogo.do")
	public String selectMainLogo2(ModelMap model){
		return "basic/MainLogo";
	}
	/**
	 * 임직원 정보 수정 페이지
	 * @MethodName : viewModifyUsrInfo
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login/modifyUsrInfo.do")
	public String viewModifyUsrInfo(ModelMap model
			,HttpSession session, HttpServletRequest request
			,@RequestParam Map<String,String> map){

		List<Map> result = null;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		request.setAttribute("leftMenuStr", "changePass");
		request.setAttribute("currentMenuKor", "비밀번호 변경");
		request.setAttribute("menuKorPath","<span class='divide'>My Page</span><span class='divide current'>비밀번호 변경</span>");

		try{
			result = personService.selectStaff(loginUser);
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}

		model.addAttribute("userInfo", result.get(0));
		return "login/ModifyUsrInfo/fixLeft";
	}


	/**
	 * 임직원 정보 수정 적용
	 * @MethodName : updateModifyUsrInfo
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login/updateUsrInfo.do")
	public void updateModifyUsrInfo(ModelMap model,
			StaffVO staffVO,  HttpServletResponse response,
			HttpSession session,
			@RequestParam Map<String,String> map) throws Exception{

		//비밀번호 암호화

		int cnt = 0;
		try {

			map.put("userPwd", EgovFileScrty.encryptPassword(map.get("usrPw").toString()));
			map.put("curPw", EgovFileScrty.encryptPassword(map.get("curPw").toString()));

			cnt = personService.updateStaffInfo(map);

		}catch(Exception e){
			e.printStackTrace();
			AjaxResponse.responseAjaxSave(response, -1);
		}

		AjaxResponse.responseAjaxSave(response, cnt);

	}


	/**
	 * 업무일지 메모에서 파일첨부 시
	 * @MethodName : uploadFiles4memo
	 * @param request
	 * @param response
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/basic/filesUpload4memo.do")
	public String uploadFiles4memo(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			ModelMap model){
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("userId").toString());

		String rtn = "";
		try{
			// 정보 받기
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultiFileUpload mUpload = new MultiFileUpload("");
			FileUpDbVO fileVo = new FileUpDbVO();

			rtn = (String) multipartRequest.getParameter("rtn");
			String offersnb = "";
			String filecate = (String) multipartRequest.getParameter("categoryCd");
			fileVo.setFileCategory( filecate );
			fileVo.setReportYN("N");
			fileVo.setRgId(loginUser.get("userId").toString());
			fileVo.setOrgId(loginUser.get("orgId").toString());

			WorkVO vo = new WorkVO();
			vo.setRgId(loginUser.get("userId").toString());
			// 4:메모에 첨부파일, 5:댓글에 첨부파일
			if( "00004".equals(filecate) ) offersnb = workService.selectMemo4insertFile(vo);
			else if( "00005".equals(filecate) ) offersnb = workService.selectReply4insertFile(vo);
			fileVo.setOfferSnb( offersnb );

			// 파일업로드 시키기
			mUpload.fileUpload(multipartRequest, fileVo, request);

		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();
		}
		return "redirect:/"+rtn+".do";
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	*
	* @MethodName : fileCopy
	* @param srcFolder 파일이 위치한 폴더
	* @param targetFolder 복사할 폴더
	* @param fileName 파일 이름
	*/
	public static void fileCopy(String srcFolder, String targetFolder, String fileName) throws Exception{
		String inFileName = srcFolder+"/"+fileName;
		String outFileName = targetFolder+"/"+fileName;

		File f = new File(targetFolder);
		f.mkdirs();//파일 저장될 폴더 생성

		//System.out.println("\n\n"+inFileName+"\n\n"+outFileName+"\n\n\n\n\n");
		try {
		FileInputStream fis = new FileInputStream(inFileName);
		FileOutputStream fos = new FileOutputStream(outFileName);

		int data = 0;

		while((data=fis.read())!=-1) {
		fos.write(data);
		}

		fis.close();
		fos.close();
		} catch (Exception e) {
		LOG.error(e);
		e.printStackTrace();
		}
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 메인 화면 New (161114)
	 * @MethodName : selectMainLogo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/basic/mainTest.do")
	public String mainTest(
			@RequestParam Map<String,Object> paramMap,
			HttpServletRequest request,
			HttpSession session,
			Model model) throws Exception{
		return "basic/mainTest";
	}
}