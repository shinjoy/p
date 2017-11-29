package ib.personnel.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.approve.service.ApproveService;
import ib.basic.service.OrgService;
import ib.basic.web.MultiFileUpload;
import ib.business.service.BusinessService;
import ib.card.service.CardService;
import ib.cmm.FileUpDbVO;
import ib.cmm.service.CmmUseService;
import ib.cmm.service.CommonService;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.email.service.EmailService;
import ib.file.service.FileService;
import ib.person.service.PersonService;
import ib.personnel.service.ManagementPersonnelListVO;
import ib.personnel.service.ManagementService;
import ib.user.service.UserService;
import ib.work.service.WorkDailyService;
import ib.work.service.WorkService;
import ib.work.service.impl.WorkDAO;

/**
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 12. 06.
 * @filename : ManagementController.java
 * @version : 1.0.0
 * @see
 *
 * <pre>
 * package  : ib.personnel.web
 * </pre>
 */
@Controller
public class ManagementController {

	/** CmmUseService */
	@Resource(name="CmmUseService")
	private CmmUseService cmm;

	@Resource(name="commonService")
	private CommonService commonService;

    @Resource(name = "managementService")
    private ManagementService managementService;

    @Resource(name = "workService")
    private WorkService workService;

    @Resource(name = "workDAO")
    private WorkDAO workDAO;

    @Resource(name="approveService")
	private ApproveService approveService;

	@Resource
	private BusinessService businessService;

	@Resource(name="workDailyService")
	private WorkDailyService workDailyService;

	@Resource(name = "userService")
	private UserService userService;

	@Value("${Globals.fileStorePath2}")
	private String globalsFolderPath2;

    @Resource(name = "fileService")
    private FileService fileService;

    @Resource(name = "emailService")
    private EmailService emailService;

    @Resource(name = "cardService")
    private CardService cardService;

    @Resource(name = "personService")
    private PersonService personService;


    /** log */
    protected static final Log LOG = LogFactory.getLog(ManagementController.class);

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

	///////////////////////////park ////////////////////////////////////////////////////
	/**
	 * 인사관리 기본화면
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/personnel/management/index.do")
	public String index( @RequestParam Map<String,Object> paramMap
						,Model model
						,HttpSession session 	) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		String orgId = baseUserLoginInfo.get("applyOrgId").toString();
		paramMap.put("hideSynergyUserYn", baseUserLoginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부

		List<Map> accessOrgIdList = (List<Map>)session.getAttribute("accessOrgIdList");

		List<String> orgIdList = new ArrayList<String>();
		if(accessOrgIdList!=null && accessOrgIdList.size()>0){

			//검색 In절에 넣기 위한 컬렉션을 만든다.
			for(Map orgListBuf:accessOrgIdList){
				orgIdList.add(orgListBuf.get("orgId").toString());
			}
			paramMap.put("orgIdList", orgIdList);

			/////////////////////////////////////////페이징 : S
			PaginationInfo paginationInfo = new PaginationInfo();
			//현재 페이지
			Integer pageIndex = 1;

			if(paramMap.containsKey("pageIndex")&& !paramMap.get("pageIndex").toString().equals("")){
				pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
			}

			paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

			Integer recordCountPerPage = 15;

			if(paramMap.containsKey("recordCountPerPage")&& !paramMap.get("recordCountPerPage").toString().equals("")){
		        	recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
			}


			paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();

	        paramMap.put("firstIndex", firstRecordIndex);
			paramMap.put("recordCountPerPage", recordCountPerPage);
			/////////////////////////////////////////페이징 : E
			if(paramMap.get("searchDeptIdBuf")!=null && !paramMap.get("searchDeptIdBuf").toString().equals("")){
				String searchDeptIdBuf = paramMap.get("searchDeptIdBuf").toString();
				paramMap.put("searchDeptId", searchDeptIdBuf.split("_")[2]);
			}
			if(!paramMap.containsKey("searchOrdId")) paramMap.put("searchOrdId", orgId);
			//검색가능한 orgId가 있으므로 조회
			List<EgovMap> accessOrgUserList = managementService.getAccessOrgUserList(paramMap);

			Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);

			model.addAttribute("accessOrgUserList", accessOrgUserList);

			//검색 가능한 부서 가져오기
			List<EgovMap> accessOrgDeptUserList = managementService.getAccessOrgDeptUserList(paramMap);
			model.addAttribute("accessOrgDeptUserList", accessOrgDeptUserList);
			model.addAttribute("searchMap", paramMap);
		}


		return "personnel/management/personnelInfoList";
	}

	/**
	 * 인사관리 기본화면 Ajax
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/personnel/getManagementListAjax.do")
	public String index( @RequestParam Map<String,Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpSession session 	) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();
		paramMap.put("hideSynergyUserYn", baseUserLoginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부

		List<Map> accessOrgIdList = (List<Map>)session.getAttribute("accessOrgIdList");

		List<String> orgIdList = new ArrayList<String>();
		if(accessOrgIdList!=null && accessOrgIdList.size()>0){

			//검색 In절에 넣기 위한 컬렉션을 만든다.
			for(Map orgListBuf:accessOrgIdList){
				orgIdList.add(orgListBuf.get("orgId").toString());
			}
			paramMap.put("orgIdList", orgIdList);

			/////////////////////////////////////////페이징 : S
			PaginationInfo paginationInfo = new PaginationInfo();
			//현재 페이지
			Integer pageIndex = 1;

			if(paramMap.containsKey("pageIndex")&& !paramMap.get("pageIndex").toString().equals("")){
				pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
			}

			paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

			Integer recordCountPerPage = 10;

			if(paramMap.containsKey("recordCountPerPage")&& !paramMap.get("recordCountPerPage").toString().equals("")){
		        	recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
			}


			paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();

	        paramMap.put("firstIndex", firstRecordIndex);
			paramMap.put("recordCountPerPage", recordCountPerPage);
			/////////////////////////////////////////페이징 : E
			String searchDeptIdBuf = paramMap.get("searchDeptIdBuf").toString();
			if(searchDeptIdBuf!=null && !searchDeptIdBuf.equals("")){
				paramMap.put("searchDeptId", searchDeptIdBuf.split("_")[2]);
			}

			//검색가능한 orgId가 있으므로 조회
			List<EgovMap> accessOrgUserList = managementService.getAccessOrgUserList(paramMap);

			Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);

			model.addAttribute("accessOrgUserList", accessOrgUserList);
		}
		return "personnel/management/include/personnelInfoList_INC";
	}
	/**
	 * 인사관리 상세/수정
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/personnel/getPersonnelInfo.do")
	public String getManagementDetail( @RequestParam Map<String,Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpServletRequest request
			,HttpSession session 	) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		LOG.info(baseUserLoginInfo.get("loginId").toString());

		//01. 사용자의 기본정보를 조회한다.
		EgovMap userDetail = managementService.getPersonnelDetail(paramMap);

		paramMap.put("orgId", userDetail.get("orgId"));

		//02. 사용자의 직급사항을 조회한다
		List<EgovMap> userInsideCareer = managementService.getuserInsideCareer(paramMap);

		//03. 사용자의 가족관계를 조회한다.
		List<EgovMap> userFamily = managementService.getUserFamily(paramMap);

		//04. 사용자의 학력사항을 조회한다
		List<EgovMap> userAcademic = managementService.getUserAcademic(paramMap);

		//05. 사용자의경력사항을 조회한다
		List<EgovMap> userCareer = managementService.getUserCareer(paramMap);

		//06. 사용자의 자격증을 조회한다
		List<EgovMap> userLicense = managementService.getUserLicense(paramMap);

		//07 . 사용자의 부서 리스트를 가져온다.
		List<EgovMap> userDeptList = managementService.getUserDeptList(paramMap);

		//08 . 사용자의 재직상태정보를 가져온다.(휴직/병가)
		List<EgovMap> userSttsHist = managementService.getUserSttsHist(paramMap);
		//09 . 사용자의 퇴직/해고 정보를 가져온다.
		EgovMap fireInfo = managementService.getUserSttsHistFireInfo(paramMap);

		model.addAttribute("userDetail", userDetail);
		model.addAttribute("userInsideCareer", userInsideCareer);
		model.addAttribute("userFamily", userFamily);
		model.addAttribute("userAcademic", userAcademic);
		model.addAttribute("userCareer", userCareer);
		model.addAttribute("userLicense", userLicense);
		model.addAttribute("userDeptList", userDeptList);
		model.addAttribute("userSttsHist", userSttsHist);
		model.addAttribute("fireInfo", fireInfo);
		model.addAttribute("searchMap", paramMap);

		paramMap.put("uploadType","PROFILEIMG");
		Integer profileImgSeq = fileService.getUserProfileImgSeq(paramMap);
		model.addAttribute("profileImgSeq", profileImgSeq);

		/*FileUpDbVO Filevo = new FileUpDbVO();
		List<FileUpDbVO> imgFile = null;
		Filevo.setSubCd(paramMap.get("userId").toString());
		Filevo.setFileCategory("00001");//00000:정보정리, 00001: staff사진 ,  00002: 댓글 첨부파일, 00003: 인사관리->이력서파일
		Filevo.setRecordCountPerPage(0);
		imgFile = workService.selectFileInfo(Filevo);//첨부사진

		if(!imgFile.isEmpty()){
		System.out.println("===========================================================\n"
				+request.getRealPath("/data/")+"\n"+imgFile.get(0).getPath()+"\n"+imgFile.get(0).getRealName()
				+"\n===========================================================\n");
			fileCopy(imgFile.get(0).getPath(), request.getRealPath("/data/"), imgFile.get(0).getMakeName());
			model.addAttribute("realNm", imgFile.get(0).getRealName());
			model.addAttribute("makeNm", imgFile.get(0).getMakeName());
		}*/

		return "personnel/management/personnelInfo";
	}
	/**
	 * 인사관리 상세/수정
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mypersonnel/getMyPersonnelInfo.do")
	public String getMyPersonnelInfo( @RequestParam Map<String,Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpServletRequest request
			,HttpSession session 	) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		LOG.info(baseUserLoginInfo.get("loginId").toString());
		paramMap.put("userId",baseUserLoginInfo.get("userId"));
		//01. 사용자의 기본정보를 조회한다.
		EgovMap userDetail = managementService.getPersonnelDetail(paramMap);

		paramMap.put("orgId", userDetail.get("orgId"));

		//02. 사용자의 직급사항을 조회한다
		List<EgovMap> userInsideCareer = managementService.getuserInsideCareer(paramMap);

		//03. 사용자의 가족관계를 조회한다.
		List<EgovMap> userFamily = managementService.getUserFamily(paramMap);

		//04. 사용자의 학력사항을 조회한다
		List<EgovMap> userAcademic = managementService.getUserAcademic(paramMap);

		//05. 사용자의경력사항을 조회한다
		List<EgovMap> userCareer = managementService.getUserCareer(paramMap);

		//06. 사용자의 자격증을 조회한다
		List<EgovMap> userLicense = managementService.getUserLicense(paramMap);

		//07 . 사용자의 부서 리스트를 가져온다.
		List<EgovMap> userDeptList = managementService.getUserDeptList(paramMap);

		//08 . 사용자의 재직상태정보를 가져온다.(휴직/병가)
		List<EgovMap> userSttsHist = managementService.getUserSttsHist(paramMap);
		//09 . 사용자의 퇴직/해고 정보를 가져온다.
		EgovMap fireInfo = managementService.getUserSttsHistFireInfo(paramMap);

		model.addAttribute("userDetail", userDetail);
		model.addAttribute("userInsideCareer", userInsideCareer);
		model.addAttribute("userFamily", userFamily);
		model.addAttribute("userAcademic", userAcademic);
		model.addAttribute("userCareer", userCareer);
		model.addAttribute("userLicense", userLicense);
		model.addAttribute("userDeptList", userDeptList);
		model.addAttribute("userSttsHist", userSttsHist);
		model.addAttribute("fireInfo", fireInfo);
		model.addAttribute("searchMap", paramMap);


		paramMap.put("uploadType","PROFILEIMG");
		Integer profileImgSeq = fileService.getUserProfileImgSeq(paramMap);
		model.addAttribute("profileImgSeq", profileImgSeq);

		model.addAttribute("leftMenuStr", "myPersonnelInfo");
		model.addAttribute("currentMenuKor", "인사정보");
		model.addAttribute("menuKorPath","<span class='divide'>My Page</span><span class='divide current'>인사정보</span>");
		return "personnel/management/myPersonnelInfo/fixLeft";
	}

	/**
	 * 마이페이지 메인
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mypersonnel/myPageMain.do")
	public String myPageMain( @RequestParam Map<String,Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpServletRequest request
			,HttpSession session 	) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
        paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
        paramMap.put("roleId",baseUserLoginInfo.get("userRoleId").toString());
        if(baseUserLoginInfo.get("orgId").toString().equals(baseUserLoginInfo.get("applyOrgId").toString())){
	        //현재시간 조회
	        Date now = managementService.getCurTimeInfo();

	        model.addAttribute("curTime", now);

	        //오늘의 근태정보 조회
	        EgovMap todayWorkInfo = managementService.getTodayWorkInfo(paramMap);
	        model.addAttribute("todayWorkInfo", todayWorkInfo);

			//////////////////////////////////////////Cnt 정보 Start:S/////////////////////////////////////////////
			//전자결재 진행중 문서 cnt
			paramMap.put("searchMainCnt","Y");
			Integer approveWorkingCnt = approveService.getDraftDocListTotalCnt(paramMap);
			model.addAttribute("approveWorkingCnt", approveWorkingCnt);
			//전자결재 결재할 문서 cnt..
			paramMap.put("searchAppvStatus","REQ");
			paramMap.put("searchDocStatus","APPROVE");
			Integer approveReqCnt = approveService.getReqDocListTotalCnt(paramMap);
			model.addAttribute("approveReqCnt", approveReqCnt);

			//전자결재 참조문서 cnt..
			paramMap.put("searchAppvStatus",null);
			paramMap.put("searchDocStatus",null);
			Integer approveRefCnt = approveService.getRefDocListTotalCnt(paramMap);
			model.addAttribute("approveRefCnt", approveRefCnt);

			//전자결재 취소승인 권한을 조회한다
			Integer approveCancelRoleCnt = approveService.getCancelRoleCnt(paramMap);
			model.addAttribute("approveCancelRoleCnt", approveCancelRoleCnt);
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

			Integer attendCount = userService.getUserAttendCnt(paramMap);
			model.addAttribute("attendCount", attendCount);

			paramMap.put("roleId",baseUserLoginInfo.get("userRoleId").toString());
			 //모듈 리스트
	        List<EgovMap> moduleList = userService.getModuleList(paramMap);

			String moduleCodeStr = "";
			for(int i = 0 ; i < moduleList.size();i++){
				moduleCodeStr += "|"+moduleList.get(i).get("moduleCode");
			}

			model.addAttribute("moduleCodeStr", moduleCodeStr);

			// 메일 정보 추가
			Map emailMap = emailService.getEmailLinkInfo(baseUserLoginInfo);
			model.addAttribute("emailId", emailMap.get("mailId").toString());
        }
		model.addAttribute("leftMenuStr", "myPageMain");
		//model.addAttribute("currentMenuKor", "마이페이지 메인");
		model.addAttribute("menuKorPath","<span class='divide'>My Page</span><span class='divide current'>마이페이지 메인</span>");
		return "personnel/management/myPageMain/fixLeft";
	}
	/**
	 *
	 * 사용자 프로필 사진 수정
	 *
	 * @param : HttpSession
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @
	 */
	@RequestMapping(value = "/personnel/management/basicInfoImg.do")
	public void basicInfoImg(HttpSession session,
			HttpServletResponse response,
			Model model,
			MultipartHttpServletRequest request,
			@RequestParam Map<String,Object> paramMap,
			ManagementPersonnelListVO arrVo
			) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		List<Map<String , Object>> resultList = new ArrayList();
		// 정보 받기
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		List<MultipartFile> fileList = request.getFiles("shadowFile");

		String folderPath2 = globalsFolderPath2;

		//os가 리눅스면 D:를 제거한다
		if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") < 0)
        {
			if(folderPath2.indexOf("D:")>=0){
				folderPath2 = folderPath2.split("D:")[1];
			}
        }
		//관계사 ORG_CODE를 경로에 포함시킨다.
		if(baseUserLoginInfo.get("orgCode") != null){
			folderPath2 = folderPath2 + baseUserLoginInfo.get("orgCode").toString() +"/";
		}

		//저장폴더에 년도 추가
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date(System.currentTimeMillis()) );
		String farmatYear = new SimpleDateFormat("yyyy").format( cal.getTime() );
		folderPath2 = folderPath2 + farmatYear +"/";

		for(int i=0;i<fileList.size();i++){
			String fileNm = fileList.get(i).getOriginalFilename();
			String orgFileName = fileNm.replaceAll(",", "");
  			//String saveFileName = System.currentTimeMillis() + "_" + orgFileName;
			String tempFileName[] = orgFileName.split("\\.");
			String extFileName = "";
			if(tempFileName.length > 0)  extFileName = "." + tempFileName[tempFileName.length-1];
  			String saveFileName = System.currentTimeMillis() + extFileName;

  			File f = new File(folderPath2);
  		  	f.mkdirs();//파일 저장될 폴더 생성
  			File uploadFile = new File(folderPath2 + saveFileName);
  			fileList.get(i).transferTo(uploadFile);
  			//mfile.transferTo(uploadFile);
  			HashMap<String, Object>map = new HashMap();
  			//map.put("contentId", contentId);
			map.put("orgFileNm", orgFileName);
			map.put("newFileNm", saveFileName);
			map.put("filePath", folderPath2);
			map.put("fileSize", fileList.get(i).getSize());
			map.put("uploadType","PROFILEIMG");

			resultList.add(i, map);
			//i++;
  		}

		System.out.println(paramMap.get("userId"));

  		/*
         * 파일처리
        */
        if(resultList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", resultList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);

            paramMap.put("fileList", param);
            paramMap.put("usrSeq", baseUserLoginInfo.get("userId"));
            paramMap.put("uploadId", paramMap.get("userId"));
            paramMap.put("uploadType", "PROFILEIMG");
            //기존 프로필사진이 있다면 DELETE
            fileService.deleteUserProfileImg(paramMap);

            fileService.insertFileListJson(paramMap);                //파일 db저장
        }

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 *
	 * 사용자 프로필 사진 삭제
	 *
	 * @param : HttpSession
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @
	 */
	@RequestMapping(value = "/personnel/management/deleteBasicInfoImg.do")
	public void deleteBasicInfoImg(HttpSession session,
			HttpServletResponse response,
			Model model,
			HttpServletRequest request,
			@RequestParam Map<String,Object> paramMap
			) throws Exception {
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		paramMap.put("uploadType","PROFILEIMG");
		//기존 프로필사진이 있다면 DELETE
        fileService.deleteUserProfileImg(paramMap);

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}


	/**
	 *
	 * 사용자 정보 수정
	 *
	 * @param : HttpSession
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/personnel/management/processPersonnerInfo.do")
	public void processPersonnerInfo(HttpSession session,
			HttpServletResponse response,
			Model model,
			HttpServletRequest request,
			@RequestParam Map<String,Object> paramMap,
			ManagementPersonnelListVO arrVo
			) throws Exception {



		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("sessionUserId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("userLoginId", baseUserLoginInfo.get("loginId").toString());

		managementService.processPersonnerInfo(paramMap,arrVo);
		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달

	}

	/**
	 *
	 * 재직상태 , 진급정보 업데이트 배치
	 *
	 * @param :
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/batch/management/updateUserInfoBatch.do")
	public void updateUserInfoBatch(HttpServletResponse response) throws Exception {
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("batchId", -1);
		managementService.updateUserInfoBatch(paramMap);
		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 * 년차관리 기본화면
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/personnel/annual/annualInfoList.do")
	public String getAnnualInfoList( @RequestParam Map<String,Object> paramMap
						,Model model
						,HttpSession session 	) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		/////////////////////////////////////////페이징 : S
		PaginationInfo paginationInfo = new PaginationInfo();
		//현재 페이지
		Integer pageIndex = 1;

		if(paramMap.containsKey("pageIndex")&& !paramMap.get("pageIndex").toString().equals("")){
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

		Integer recordCountPerPage = 10;

		if(paramMap.containsKey("recordCountPerPage")&& !paramMap.get("recordCountPerPage").toString().equals("")){
	        	recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();

        paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);
		/////////////////////////////////////////페이징 : E

		//연차목록 조회 , 검색가능한 orgId가 있으므로 조회
		List<EgovMap> accessOrgUserList = managementService.getAnnualUserList(paramMap);

		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("accessOrgUserList", accessOrgUserList);

		//검색 가능한 부서 가져오기
		List<EgovMap> accessOrgDeptUserList = managementService.getAccessOrgDeptUserList(paramMap);
		model.addAttribute("accessOrgDeptUserList", accessOrgDeptUserList);
		model.addAttribute("searchMap", paramMap);

		return "personnel/annual/annualInfoList";
	}

	/**
	 * 인사관리 기본화면 Ajax
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/personnel/getAnnualInfoListAjax.do")
	public String getAnnualInfoListAjax( @RequestParam Map<String,Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpSession session 	) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

		/////////////////////////////////////////페이징 : S
		PaginationInfo paginationInfo = new PaginationInfo();
		//현재 페이지
		Integer pageIndex = 1;

		if(paramMap.containsKey("pageIndex")&& !paramMap.get("pageIndex").toString().equals("")){
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

		Integer recordCountPerPage = 10;

		if(paramMap.containsKey("recordCountPerPage")&& !paramMap.get("recordCountPerPage").toString().equals("")){
	        	recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}


		paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();

        paramMap.put("firstIndex", firstRecordIndex);
		paramMap.put("recordCountPerPage", recordCountPerPage);
		/////////////////////////////////////////페이징 : E
		String searchDeptIdBuf = paramMap.get("searchDeptIdBuf").toString();
		if(searchDeptIdBuf!=null && !searchDeptIdBuf.equals("")){
			paramMap.put("searchDeptId", searchDeptIdBuf.split("_")[2]);
		}

		//연차목록 조회 , 검색가능한 orgId가 있으므로 조회
		List<EgovMap> accessOrgUserList = managementService.getAnnualUserList(paramMap);

		Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("accessOrgUserList", accessOrgUserList);

		return "personnel/annual/include/annualInfoList_INC";
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
	@RequestMapping(value = "/personnel/doSaveUserLeaveH.do")
	public void doSaveUserLeaveH(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		//if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("updatedBy", baseUserLoginInfo.get("userId").toString());
		/*map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());*/

		int cnt = managementService.doSaveUserLeaveH(map);

		AjaxResponse.responseAjaxSave(response, cnt); // 결과전송
	}

	/**
	 *
	 * 출근부 생성 배치
	 *
	 * @param :
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/batch/workTime/insertWorkTime.do")
	public void insertWorkTime(HttpServletResponse response) throws Exception {
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("batchId", -1);
		managementService.insertWorkTime(paramMap);
		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 *
	 * 배치 연동된 법인 카드 사용내역 불러오기
	 *
	 * @param     : map :
	 * @return    :
	 * @exception : throws
	 * @author    : inee
	 * @date      : 2017.08.22
	 */
	@RequestMapping("/batch/card/getBarobillCardUsedList.do")
	public void getBarobillCardCorpList(HttpServletResponse response) throws Exception {

		Map<String,Object> paramMap = new HashMap<String,Object>();

		// baseDate 기준
		// 지정일 없을 경우 기준일(오늘) 하루전으로 지정(카드사 데이타 업데이트 시점 불일치로 인해 7일치 데이타 확보)
		// 주말, 공휴일에 대한 체크로직 필요
		paramMap.put("baseDate", getBaseDate(-1));
		cardService.getBarobillCardUsedList(paramMap);

		paramMap.put("baseDate", getBaseDate(-2));
		cardService.getBarobillCardUsedList(paramMap);

		paramMap.put("baseDate", getBaseDate(-3));
		cardService.getBarobillCardUsedList(paramMap);

		paramMap.put("baseDate", getBaseDate(-4));
		cardService.getBarobillCardUsedList(paramMap);

		paramMap.put("baseDate", getBaseDate(-5));
		cardService.getBarobillCardUsedList(paramMap);

		paramMap.put("baseDate", getBaseDate(-6));
		cardService.getBarobillCardUsedList(paramMap);

		paramMap.put("baseDate", getBaseDate(-7));
		cardService.getBarobillCardUsedList(paramMap);
	}

	// 오늘일자 기준으로 day 일만큼 더하고 뺀 날짜값 계산
	private String getBaseDate(int day){
		Calendar cal = Calendar.getInstance();

		cal.add(cal.DATE, day);
		SimpleDateFormat yesterday = new SimpleDateFormat("yyyyMMdd");
		return yesterday.format(cal.getTime());
	}

	/**
	 *
	 * 사용자 출근처리
	 *
	 * @param : HttpSession
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/mypersonnel/processWorcAjax.do")
	public void processWorcAjax(HttpSession session,
			HttpServletResponse response,
			Model model,
			HttpServletRequest request,
			@RequestParam Map<String,Object> paramMap
			) throws Exception {



		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
        paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

        //오늘의 근태정보 조회
        EgovMap todayWorkInfo = managementService.getTodayWorkInfo(paramMap);
        if(todayWorkInfo.get("workYn")!=null &&!todayWorkInfo.get("workYn").equals("Y")){
        	obj.put("msg", "퇴근시간이 지나서 출근처리할 수 없습니다. ");
        	obj.put("result", "FAIL");
    		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
    		return;
        }

        //출근정보
        String contactDevice = paramMap.get("loginLoc").toString();				//접속 정보(PC or Mobile)

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

		managementService.processWorcAjax(paramMap);

		obj.put("result", "SUCCESS");

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달

	}

	/**
	 *
	 * 사용자 퇴근처리
	 *
	 * @param : HttpSession
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/mypersonnel/processWorcEndAjax.do")
	public void processWorcEndAjax(HttpSession session,
			HttpServletResponse response,
			Model model,
			HttpServletRequest request,
			@RequestParam Map<String,Object> paramMap
			) throws Exception {



		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
        paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());

       //오늘의 근태정보 조회
       EgovMap todayWorkInfo = managementService.getTodayWorkInfo(paramMap);
       if(todayWorkInfo.get("inTime")==null ||todayWorkInfo.get("inTime").equals("")){
       	obj.put("msg", "오늘 출근하지 않았습니다. 출근버튼을 눌러주세요.");
       	obj.put("result", "FAIL");
   		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
   		return;
       }

       //퇴근위치
       String contactDevice = paramMap.get("loginLoc").toString();				//접속 정보(PC or Mobile)

       if((contactDevice.toLowerCase()).equals("mobile")) paramMap.put("outContactLoc","mobile");
       else paramMap.put("outContactLoc","pc");

	   managementService.processWorcEndAjax(paramMap);

	   obj.put("result", "SUCCESS");

	   AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달

	}
	//////////////////////////////////////User Group 관리 팝업에서 조회하는 조직도...psj/////////////////////////////////////////////////////

	@Resource(name="orgService")
	private OrgService orgService;

	/**
	 *
	 * 그룹관리 - 관계사 조직도 트리를 그린다.
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/personnel/getOrganizationListInfoList.do")
	public void getCompanyStructList(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		List<Map> organizationList= orgService.getOrganizationListInfoList(map);

		AjaxResponse.responseAjaxSelect(response, organizationList);		//"SUCCESS" 전달

	}

	/**
	 *
	 * 그룹관리 - 관계사or부서별 회원 리스트를 조회
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/personnel/getOrgUserList.do")
	public void getOrgUserList(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		List<Map> orgUserList= userService.getOrgOrDeptUserList(map);

		AjaxResponse.responseAjaxSelect(response, orgUserList);		//"SUCCESS" 전달

	}
	/**
	 *
	 * 그룹관리 - 그룹별 사용자 리스트 조회
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/personnel/getGroupDetailUserListAjax.do")
	public void getGroupDetailUserListAjax(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		List<Map> orgUserGroupList= userService.getGroupDetailUserList(map);

		AjaxResponse.responseAjaxSelect(response, orgUserGroupList);		//"SUCCESS" 전달

	}

	/**
	 *
	 * 그룹관리 - 그룹 수정/저장
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/personnel/processUserGroupAjax.do")
	public void processUserGroupAjax(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		//사용여부는 Y
		map.put("enable", "Y");
		Integer returnCnt = 0;
		String userGroupId = map.get("userGroupId").toString();
		if(userGroupId.equals("")){
			returnCnt = userService.createUserGroup(map);
		}else{
			returnCnt = userService.modifyUserGroup(map);
		}
		Map<String,Object> returnMap = new HashMap<String,Object>();
		returnMap.put("result", "SUCCESS");
		returnMap.put("returnCnt", returnCnt);
		AjaxResponse.responseAjaxObject(response, returnMap);		//"SUCCESS" 전달

	}

	/**
	 *
	 * 그룹관리 - 그룹 삭제
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/personnel/deleteUserGroupAjax.do")
	public void deleteUserGroupAjax(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		userService.deleteUserGroup(map);

		Map<String,Object> returnMap = new HashMap<String,Object>();
		returnMap.put("result", "SUCCESS");
		AjaxResponse.responseAjaxObject(response, returnMap);		//"SUCCESS" 전달

	}
	/**
	 *
	 * 그룹관리 - 그룹 수정/저장
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/personnel/procUserGroupDetailAjax.do")
	public void procUserGroupDetailAjax(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		String userIdStr = map.get("userListStr").toString();

		String[] userIdArr = userIdStr.split(",");
		map.put("userIdArr", userIdArr);

		userService.procUserGroupDetail(map);

		Map<String,Object> returnMap = new HashMap<String,Object>();
		returnMap.put("result", "SUCCESS");
		AjaxResponse.responseAjaxObject(response, returnMap);		//"SUCCESS" 전달

	}
	/**
	 *
	 * 그룹관리 - 그룹 복사
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/personnel/copyUserGroupAjax.do")
	public void copyUserGroupAjax(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		Integer returnCnt = userService.copyUserGroup(map);

		Map<String,Object> returnMap = new HashMap<String,Object>();
		returnMap.put("result", "SUCCESS");
		returnMap.put("returnCnt", returnCnt);
		AjaxResponse.responseAjaxObject(response, returnMap);		//"SUCCESS" 전달

	}
	/**
	 *
	 * 그룹관리 - 그룹 순서 변경
	 *
	 * @param : Map map
	 * @return : String
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value="/personnel/procUserGroupSortOrderAjax.do")
	public void procUserGroupSortOrderAjax(@RequestParam Map map, HttpServletResponse response
	,HttpSession session, HttpServletRequest request) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("orgId").toString());
		map.put("userId", baseUserLoginInfo.get("userId").toString());

		userService.procUserGroupSortOrder(map);

		Map<String,Object> returnMap = new HashMap<String,Object>();
		returnMap.put("result", "SUCCESS");
		AjaxResponse.responseAjaxObject(response, returnMap);		//"SUCCESS" 전달

	}

	/**
	 * 로그인 이력 화면
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/personnel/management/loginHistList.do")
	public String loginHistList( @RequestParam Map<String,Object> paramMap
						,Model model
						,HttpSession session 	) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		String orgId = baseUserLoginInfo.get("applyOrgId").toString();

		List<Map> accessOrgIdList = (List<Map>)session.getAttribute("accessOrgIdList");

		List<String> orgIdList = new ArrayList<String>();
		if(accessOrgIdList!=null && accessOrgIdList.size()>0){

			//검색 In절에 넣기 위한 컬렉션을 만든다.
			for(Map orgListBuf:accessOrgIdList){
				orgIdList.add(orgListBuf.get("orgId").toString());
			}
			paramMap.put("orgIdList", orgIdList);

			/////////////////////////////////////////페이징 : S
			PaginationInfo paginationInfo = new PaginationInfo();
			//현재 페이지
			Integer pageIndex = 1;

			if(paramMap.containsKey("pageIndex")&& !paramMap.get("pageIndex").toString().equals("")){
				pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
			}

			paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

			Integer recordCountPerPage = 10;

			if(paramMap.containsKey("recordCountPerPage")&& !paramMap.get("recordCountPerPage").toString().equals("")){
		        	recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
			}


			paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();

	        paramMap.put("firstIndex", firstRecordIndex);
			paramMap.put("recordCountPerPage", recordCountPerPage);
			/////////////////////////////////////////페이징 : E
			if(paramMap.get("searchDeptIdBuf")!=null && !paramMap.get("searchDeptIdBuf").toString().equals("")){
				String searchDeptIdBuf = paramMap.get("searchDeptIdBuf").toString();
				paramMap.put("searchDeptId", searchDeptIdBuf.split("_")[2]);
			}
			if(!paramMap.containsKey("searchOrdId")) paramMap.put("searchOrdId", orgId);
			//검색가능한 orgId가 있으므로 조회
			//List<EgovMap> accessOrgUserList = managementService.getAccessOrgUserList(paramMap);
			List<EgovMap> loginHistList = managementService.getLoginHistList(paramMap);

			Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);

			model.addAttribute("loginHistList", loginHistList);

			//검색 가능한 부서 가져오기
			List<EgovMap> accessOrgDeptUserList = managementService.getAccessOrgDeptUserList(paramMap);
			model.addAttribute("accessOrgDeptUserList", accessOrgDeptUserList);
			model.addAttribute("searchMap", paramMap);
		}


		return "personnel/management/loginHistList";
	}

	/**
	 * 인사관리 기본화면 Ajax
	 * @MethodName : index
	 * @param vo
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/personnel/getLoginHistListAjax.do")
	public String getLoginHistListAjax( @RequestParam Map<String,Object> paramMap
			,Model model
			,HttpServletResponse response
			,HttpSession session 	) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		String orgId = baseUserLoginInfo.get("orgId").toString();

		List<Map> accessOrgIdList = (List<Map>)session.getAttribute("accessOrgIdList");

		List<String> orgIdList = new ArrayList<String>();
		if(accessOrgIdList!=null && accessOrgIdList.size()>0){

			//검색 In절에 넣기 위한 컬렉션을 만든다.
			for(Map orgListBuf:accessOrgIdList){
				orgIdList.add(orgListBuf.get("orgId").toString());
			}
			paramMap.put("orgIdList", orgIdList);

			/////////////////////////////////////////페이징 : S
			PaginationInfo paginationInfo = new PaginationInfo();
			//현재 페이지
			Integer pageIndex = 1;

			if(paramMap.containsKey("pageIndex")&& !paramMap.get("pageIndex").toString().equals("")){
				pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
			}

			paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

			Integer recordCountPerPage = 10;

			if(paramMap.containsKey("recordCountPerPage")&& !paramMap.get("recordCountPerPage").toString().equals("")){
		        	recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
			}


			paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
	        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

	        int firstRecordIndex = paginationInfo.getFirstRecordIndex();

	        paramMap.put("firstIndex", firstRecordIndex);
			paramMap.put("recordCountPerPage", recordCountPerPage);
			/////////////////////////////////////////페이징 : E
			String searchDeptIdBuf = paramMap.get("searchDeptIdBuf").toString();
			if(searchDeptIdBuf!=null && !searchDeptIdBuf.equals("")){
				paramMap.put("searchDeptId", searchDeptIdBuf.split("_")[2]);
			}

			//검색가능한 orgId가 있으므로 조회
			List<EgovMap> loginHistList = managementService.getLoginHistList(paramMap);

			Integer totCnt = Integer.parseInt(paramMap.get("totCnt").toString());

	        paginationInfo.setTotalRecordCount(totCnt);
	        model.addAttribute("paginationInfo", paginationInfo);

			model.addAttribute("loginHistList", loginHistList);
		}
		return "personnel/management/include/loginHistList_INC";
	}

	/**
	 *
	 * 품의서 문서번호 화면
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/personnel/management/markRuleList.do")
	public String approveDocNumList(HttpSession session,Model model) throws Exception{

		Map<String,Object> map = new HashMap<String, Object>();
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", loginInfo.get("applyOrgId").toString());

		List<EgovMap> markRuleList = managementService.markRuleListList(map);

		model.addAttribute("markRuleList", markRuleList);

		return "personnel/management/markRuleList";
	}

	/**
	 *
	 * 품의서 문서번호 재조회
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/personnel/management/getMarkRuleListAjax.do")
	public String getAppvDocNumRuleAjax(HttpSession session,Model model) throws Exception{

		Map<String,Object> map = new HashMap<String, Object>();
		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", loginInfo.get("applyOrgId").toString());

		List<EgovMap> markRuleList = managementService.markRuleListList(map);

		model.addAttribute("markRuleList", markRuleList);

		return "personnel/management/include/markRuleList_INC";
	}

	/**
	 *
	 * 품의서 문서번호 저장
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/personnel/management/processMarkRule.do")
	public void processAppvDocNumRule(HttpSession session
			, @RequestParam Map<String,Object> paramMap
			, HttpServletResponse response
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		managementService.processMarkRule(paramMap);

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");
		//obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 *
	 * 퀵링크관리
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/management/quickLinkList.do")
	public String getQuickLinkList(@RequestParam Map<String,Object> paramMap
								,Model model
								,HttpServletResponse response
								,HttpSession session) throws Exception{

		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", loginInfo.get("applyOrgId").toString());

		List<EgovMap> quickLinkList = managementService.getQuickLinkList(paramMap);

		model.addAttribute("quickLinkList", quickLinkList);

		return "quickLink/quickLinkList";
	}

	/**
	 *
	 * 퀵링크관리Ajax
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/management/getQuickLinkListAjax.do")
	public String getQuickLinkListAjax(@RequestParam Map<String,Object> paramMap
								,Model model
								,HttpServletResponse response
								,HttpSession session) throws Exception{

		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", loginInfo.get("applyOrgId").toString());

		List<EgovMap> quickLinkList = managementService.getQuickLinkList(paramMap);

		model.addAttribute("quickLinkList", quickLinkList);

		return "quickLink/include/quickLinkList_INC/inc";
	}

	/**
	 *
	 * 퀵링크관리 사용안내 팝업
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping("/management/quickLinkHelpPop.do")
	public String quickLinkHelpPop(@RequestParam Map<String,Object> paramMap
								,Model model
								,HttpServletResponse response
								,HttpSession session) throws Exception{


		return "quickLink/pop/quickLinkHelpPop/pop";
	}

	/**
	 *
	 * 퀵링크 저장
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/management/processQuickLink.do")
	public void processQuickLink(HttpSession session
			, @RequestParam Map<String,Object> paramMap
			, HttpServletResponse response
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		managementService.processQuickLink(paramMap);

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");
		//obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 *
	 * 퀵링크 삭제
	 *
	 * @param : HttpSession
	 * @return :
	 * @exception : throws
	 * @author :  Park
	 * @date : 2016. 10. 20.
	 */
	@RequestMapping(value = "/management/deleteQuickLink.do")
	public void deleteQuickLink(HttpSession session
			, @RequestParam Map<String,Object> paramMap
			, HttpServletResponse response
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());

		managementService.deleteQuickLink(paramMap);

		//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

		obj.put("result", "SUCCESS");
		//obj.put("appvBuyId", paramMap.get("appvBuyId").toString());

		AjaxResponse.responseAjaxObject(response, obj);		//"SUCCESS" 전달
	}

	/**
	 * 이용약관
	 */
	@RequestMapping("/mypersonnel/userRuleInfo.do")
	public String userRuleInfo(@RequestParam Map<String,Object> paramMap
								,Model model
								,HttpServletResponse response
								,HttpSession session) throws Exception{

		model.addAttribute("leftMenuStr", "userRuleInfo");
		return "personnel/management/userRuleInfo/fixLeft";
	}

	/**
	 * 개인정보 처리방침
	 */
	@RequestMapping("/mypersonnel/userProcessInfo.do")
	public String userProcessInfo(@RequestParam Map<String,Object> paramMap
								,Model model
								,HttpServletResponse response
								,HttpSession session) throws Exception{

		model.addAttribute("leftMenuStr", "userProcessInfo");
		return "personnel/management/userProcessInfo/fixLeft";
	}

	/**
	 * 이용약관 팝업
	 */
	@RequestMapping("/mypersonnel/userRuleAgreePop.do")
	public String userRuleAgreePop(@RequestParam Map<String,Object> paramMap
								,Model model
								,HttpServletResponse response
								,HttpSession session) throws Exception{


		return "personnel/management/userRuleAgreePop/pop";
	}

	//이용약관 동의
	@RequestMapping(value = "/mypersonnel/updateRuleAjax.do")
	public void updateRuleAjax(HttpSession session,
			@RequestParam Map<String,Object> map,
			HttpServletResponse response
			) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) throw new Exception();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		int saveCnt =0;

		map.put("userId", baseUserLoginInfo.get("userId"));
		saveCnt = personService.updateUserRule(map);

		if(saveCnt == 1) session.setAttribute("ruleAgreeYn", "Y");

		AjaxResponse.responseAjaxSave(response, saveCnt);
	}


}