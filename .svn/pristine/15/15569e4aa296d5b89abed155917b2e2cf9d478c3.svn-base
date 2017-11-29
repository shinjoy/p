package ib.sample.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ib.approve.service.ApproveService;
import ib.business.service.BusinessService;
import ib.cmm.FileUpDbVO;
import ib.company.service.CompanyService;
import ib.work.service.WorkService;

//테스트 컨트롤러 (삭제예정)
@Controller
public class SampleController {

	 /** log */
    protected static final Log LOG = LogFactory.getLog(SampleController.class);

    @Resource(name = "companyService")
    protected CompanyService companyService;

    @Resource(name = "workService")
    private WorkService workService;

    @Resource(name="approveService")
	private ApproveService approveService;

    @Resource
	private BusinessService businessService;


	@RequestMapping(value="/basic/sample/mainSample.do")
	public String popUpReplyDisposal(
			@RequestParam Map<String,Object> paramMap,
			HttpServletRequest request,
			HttpSession session,
			Model model) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		paramMap.put("userId", baseUserLoginInfo.get("userId").toString());
		paramMap.put("orgId", baseUserLoginInfo.get("orgId").toString());
        paramMap.put("applyOrgId", baseUserLoginInfo.get("applyOrgId").toString());
		//모듈 리스트
		//model.addAttribute("moduleList", companyService.getModuleList(paramMap));

		//본인 사진
		FileUpDbVO Filevo = new FileUpDbVO();
		List<FileUpDbVO> imgFile = null;
		Filevo.setSubCd(baseUserLoginInfo.get("userId").toString());
		Filevo.setFileCategory("00001");//00000:정보정리, 00001: staff사진 ,  00002: 댓글 첨부파일, 00003: 인사관리->이력서파일
		Filevo.setRecordCountPerPage(0);
		imgFile = workService.selectFileInfo(Filevo);//첨부사진

		if(!imgFile.isEmpty()){
		/*System.out.println("===========================================================\n"
				+request.getRealPath("/data/")+"\n"+imgFile.get(0).getPath()+"\n"+imgFile.get(0).getRealName()
				+"\n===========================================================\n");*/
			fileCopy(imgFile.get(0).getPath(), request.getRealPath("/data/"), imgFile.get(0).getMakeName());
			model.addAttribute("realNm", imgFile.get(0).getRealName());
			model.addAttribute("makeNm", imgFile.get(0).getMakeName());
		}

		////////////////////////////////////////// Cnt 정보 Start:S/////////////////////////////////////////////
		//전자결재 작성중 문서 cnt
		paramMap.put("searchDocStatus","WORKING");
		Integer approveWorkingCnt = approveService.getDraftDocListTotalCnt(paramMap);
		model.addAttribute("approveWorkingCnt", approveWorkingCnt);
		//전자결재 결재할 문서 cnt..
		paramMap.put("searchAppvStatus","REQ");
		Integer approveReqCnt = approveService.getReqDocListTotalCnt(paramMap);
		model.addAttribute("approveReqCnt", approveReqCnt);

		//전자결재 참조문서 cnt..
		Integer approveRefCnt = approveService.getRefDocListTotalCnt(paramMap);
		model.addAttribute("approveRefCnt", approveRefCnt);

		//정보공유 > 정보코멘트 CNT...
		paramMap.put("searchMyList","Y");
		Integer infoCnt = businessService.getBusinessCommentListTotalCnt(paramMap);
		model.addAttribute("infoCnt", infoCnt);


		return "sample/main";
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
}
