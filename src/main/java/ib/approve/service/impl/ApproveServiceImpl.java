package ib.approve.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.approve.service.ApproveService;
import ib.approve.service.ApproveVo;
import ib.approve.service.ApproveVoList;
import ib.common.util.DateUtil;
import ib.file.service.FileService;
import ib.personnel.service.impl.ManagementDAO;
import ib.schedule.service.ScheduleService;
import ib.sms.service.SmsService;

@Service("approveService")
public class ApproveServiceImpl  extends AbstractServiceImpl implements ApproveService {

    @Resource(name="approveDAO")
    private ApproveDAO approveDao;

    @Resource(name = "fileService")
    private FileService fileService;

    @Resource(name = "scheService")
	private ScheduleService scheService;

    @Resource(name = "managementDAO")
    private ManagementDAO managementDAO;

    @Resource(name = "smsService")
	private SmsService smsService;


    //휴가 신청서 작성시 연차정보 조회
    public EgovMap getUserHolidaySum(Map map) throws Exception {
        return approveDao.getUserHolidaySum(map);
    }

    //휴가 품의서 저장
    public Integer insertVacApprove(Map<String, Object> paramMap) throws Exception{

    	paramMap.put("attachYn", "N");		//첨부파일이 없는 품의서
        Integer cnt = 0;
        String appvDocType= paramMap.get("appvDocType").toString();
        /*
         * Step 01
         * 휴가 타입 (HALF:반차  , ALL : 종일)
         * 반차일경우 오전 / 오후 구분
        */
        if(paramMap.containsKey("vacType")){
	        String vacType = paramMap.get("vacType").toString();

	        if(vacType.equals("HALF")){
	            paramMap.put("allHalf",paramMap.get("halfAmPm").toString());

	            if(appvDocType.equals("SICK"))
	            	paramMap.put("searchActivityDocType", paramMap.get("appvDocType").toString());
	            else
	            	paramMap.put("searchActivityDocType", appvDocType+"_"+paramMap.get("halfAmPm").toString());
	        }
	        else {
	        	paramMap.put("allHalf",vacType);

	        	if(appvDocType.equals("SICK"))
	            	paramMap.put("searchActivityDocType", paramMap.get("appvDocType").toString());
	        	else
	        		paramMap.put("searchActivityDocType", appvDocType+"_"+vacType);
	        }
        }

        /*
         * Step 02
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }
        /*
         * Step 03
         * 저장
         *
        */
        if(appvDocType.equals("REST"))
        	paramMap.put("searchActivityDocType", paramMap.get("appvDocType").toString());


        EgovMap projectMap = approveDao.getActivityInfo(paramMap);

        paramMap.put("projectId", projectMap.get("projectId"));
        paramMap.put("activityId", projectMap.get("activityId"));

        Integer appvVacId = approveDao.insertApproveDoc(paramMap);

        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }

        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 04
         * 연결 결재문서가 있다면 처리

        */
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        return cnt;
    }
    //기본양식,보고서 저장(저장 로직에 차이가없어 같이씀...)
    public Integer insertBasicApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList ,ApproveVoList appVoList) throws Exception{

        Integer cnt = 0;
        String appvDocType= paramMap.get("appvDocType").toString();
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }
        if(fileList.size()>0){
            paramMap.put("attachYn", "Y");
        }else
            paramMap.put("attachYn", "N");
        /*
         * Step 02
         * 저장
         *
        */
        Integer appvDocId = approveDao.insertApproveDoc(paramMap);

        /*
         * Step 03
         * 파일처리
         *
        */
        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);

            paramMap.put("fileList", param);
            paramMap.put("usrSeq", paramMap.get("userId"));
            paramMap.put("uploadId", appvDocId);
            fileService.insertFileListJson(paramMap);                //파일 db저장
        }


        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }

        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }

        /*
         * Step 05
         * 결재라인
         *
        */
        if(paramMap.get("individualYn")!=null){
        	String individualYn =paramMap.get("individualYn").toString();

        	if(individualYn.equals("Y")){
        		paramMap.put("appvDocId", appvDocId);

        		Integer appvHeaderId = approveDao.insertApproveHeaderIndividual(paramMap);
            	//결재라인 삭제
            	//cnt = approveDao.deleteApproveLineIndividual(paramMap);

                List<ApproveVo> approveVos = appVoList.getAppVoList();
            	//List<> approveVos = (List)<ApproveVo>map.get("appVoList");

                for(ApproveVo approveVo : approveVos){
                	approveVo.setAppvHeaderId(appvHeaderId.toString());
                	approveVo.setUserId(paramMap.get("userId").toString());
                	approveVo.setOrgId(paramMap.get("orgId").toString());
                    cnt = approveDao.insertApproveLineIndividual(approveVo);
                }
        	}
        }
        /*
         * Step 06
         * 연결 결재문서가 있다면 처리

        */
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        return cnt;
    }
    //기본양식 수정
  	public Integer modifyBasicApprove(Map<String,Object> paramMap,List<Map<String , Object>> fileList,String[] delFileList ,ApproveVoList appVoList) throws Exception{
  		Integer cnt = 0;
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 수정
         *
        */
        int delFileListSize = delFileList==null?0:delFileList.length;
        int fileListSize = fileList==null?0:fileList.size();

        if(fileListSize-delFileListSize<=0)
        	paramMap.put("attachYn","N");
        else
        	paramMap.put("attachYn","Y");
        approveDao.updateApproveDoc(paramMap);

        /*
         * Step 04
         * 파일처리
         *
        */
        paramMap.put("usrSeq", paramMap.get("userId"));


        if(delFileList!=null){		//정상저장 이고 파일이 있을때
        	Map<String,Object> deleteFileMap = new HashMap<String, Object>();
        	deleteFileMap.put("fileArr", delFileList);
			fileService.updateDelFlag(deleteFileMap);						//파일 db저장 된거 삭제
		}

        paramMap.put("uploadId", paramMap.get("appvDocId").toString());

        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);
            paramMap.put("fileList", param);

            fileService.insertFileListJson(paramMap);                //파일 db저장
        }

        /*
         * Step 05
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 06
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveRcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }

        /*
         * Step 07
         * 결재라인
         *
        */
        //직접지정 결재라인 삭제
        Integer deleteHeaderId = approveDao.selectApprovalHeaderIdIndividual(paramMap);
        if(deleteHeaderId!=null){
        	paramMap.put("deleteHeaderId", deleteHeaderId);
        	approveDao.deleteApproveHeaderIndividual(paramMap);
        	approveDao.deleteApproveLineIndividual(paramMap);
        }

        if(paramMap.get("individualYn")!=null && appVoList.getAppVoList() != null && appVoList.getAppVoList().size()>0){
        	String individualYn =paramMap.get("individualYn").toString();

        	if(individualYn.equals("Y")){

        		Integer appvHeaderId = approveDao.insertApproveHeaderIndividual(paramMap);
            	//결재라인 삭제
            	//cnt = approveDao.deleteApproveLineIndividual(paramMap);

                List<ApproveVo> approveVos = appVoList.getAppVoList();
            	//List<> approveVos = (List)<ApproveVo>map.get("appVoList");

                for(ApproveVo approveVo : approveVos){
                	approveVo.setAppvHeaderId(appvHeaderId.toString());
                	approveVo.setUserId(paramMap.get("userId").toString());
                	approveVo.setOrgId(paramMap.get("orgId").toString());
                    cnt = approveDao.insertApproveLineIndividual(approveVo);
                }
        	}
        }
        /*
         * Step 08
         * 연결 결재문서가 있다면 처리

        */
        approveDao.deleteLinkRefDoc(paramMap);
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        return cnt;
  	}
    //출장 품의서 저장
    public Integer insertTripApprove(Map<String, Object> paramMap) throws Exception{
        Integer cnt = 0;

        paramMap.put("attachYn", "N");
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }
        /*
         * Step 02
         * 저장
         *
        */
        approveDao.insertApproveDoc(paramMap);
        approveDao.insertTripApprove(paramMap);


        /*
         * Step 03
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 04
         * 출장목록 저장
         *
        */
        Map<String,Object> tripListMap = new HashMap<String, Object>();

        String[] tripType = (String[])paramMap.get("tripType");
        String[] price = (String[])paramMap.get("price");
        String[] tripMemo = (String[])paramMap.get("tripMemo");
        if(tripType!=null&&tripType.length>0&&!tripType[0].equals("")){
		    for(int i = 0 ; i<tripType.length;i++){
		    	tripListMap.put("appvDocId", paramMap.get("appvDocId"));
		    	tripListMap.put("tripType", tripType[i]);
		    	tripListMap.put("price", price[i]);
		    	tripListMap.put("tripMemo", tripMemo[i]);
		        approveDao.insertTripList(tripListMap);
		    }
        }
        /*
         * Step 05
         * 출장동행자 저장
         *
        */
        if(paramMap.get("entryId")!=null){
        	cnt = approveDao.insertEntryWorker(paramMap);
        }
        /*
         * Step 06
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 07
         * 연결 결재문서가 있다면 처리

        */
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        return cnt;
    }
    //사내 품의서 저장
  	public Integer insertCompanyApprove(Map<String,Object> paramMap,List<Map<String , Object>> fileList,ApproveVoList appVoList) throws Exception{
  		Integer cnt = 0;
  		/*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 저장
         *
        */
        if(fileList.size()>0){
            paramMap.put("attachYn", "Y");
        }else
            paramMap.put("attachYn", "N");
        Integer appvDocId = approveDao.insertApproveDoc(paramMap);
        /*
         * Step 03
         * 파일처리
         *
        */
        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);

            paramMap.put("fileList", param);
            paramMap.put("usrSeq", paramMap.get("userId"));
            paramMap.put("uploadId", appvDocId);
            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
  		/*
         * Step 04
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 05
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 06
         * 연결 결재문서가 있다면 처리

        */
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        /*
         * Step 07
         * 결재라인
         *
        */
        if(paramMap.get("individualYn")!=null){
        	String individualYn =paramMap.get("individualYn").toString();

        	if(individualYn.equals("Y")){
        		paramMap.put("appvDocId", appvDocId);

        		Integer appvHeaderId = approveDao.insertApproveHeaderIndividual(paramMap);
            	//결재라인 삭제
            	//cnt = approveDao.deleteApproveLineIndividual(paramMap);

                List<ApproveVo> approveVos = appVoList.getAppVoList();
            	//List<> approveVos = (List)<ApproveVo>map.get("appVoList");

                for(ApproveVo approveVo : approveVos){
                	approveVo.setAppvHeaderId(appvHeaderId.toString());
                	approveVo.setUserId(paramMap.get("userId").toString());
                	approveVo.setOrgId(paramMap.get("orgId").toString());
                    cnt = approveDao.insertApproveLineIndividual(approveVo);
                }
        	}
        }

  		return 0;
  	}
    //출장 품의서 수정
    public Integer modifyTripApprove(Map<String, Object> paramMap) throws Exception{
    	paramMap.put("attachYn", "N");
        Integer cnt = 0;

        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }
        /*
         * Step 02
         * 수정
         *
        */
        approveDao.updateApproveDoc(paramMap);
        approveDao.updateTripApprove(paramMap);

        /*
         * Step 03
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 04
         * 출장목록 저장
         *
        */
        Map<String,Object> tripListMap = new HashMap<String, Object>();

        String[] tripType = (String[])paramMap.get("tripType");
        String[] price = (String[])paramMap.get("price");
        String[] tripMemo = (String[])paramMap.get("tripMemo");
        cnt = approveDao.deleteApproveTripList(paramMap);
        if(tripType!=null&&tripType.length>0&&!tripType[0].equals("")){
		    for(int i = 0 ; i<tripType.length;i++){
		    	tripListMap.put("appvDocId", paramMap.get("appvDocId"));
		    	tripListMap.put("tripType", tripType[i]);
		    	tripListMap.put("price", price[i]);
		    	tripListMap.put("tripMemo", tripMemo[i]);
		        approveDao.insertTripList(tripListMap);
		    }
        }
        /*
         * Step 05
         * 출장동행자 저장
         *
        */
        cnt = approveDao.deleteEntryWorker(paramMap);
        if(paramMap.get("entryId")!=null){
        	cnt = approveDao.insertEntryWorker(paramMap);
        }

        /*
         * Step 06
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 07
         * 연결 결재문서가 있다면 처리

        */

        approveDao.deleteLinkRefDoc(paramMap);
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        return cnt;
    }
    //휴가 품의서 수정
    public Integer updateVacApprove(Map<String, Object> paramMap) throws Exception{
        Integer cnt = 0;
        paramMap.put("attachYn","N");
        String appvDocType= paramMap.get("appvDocType").toString();
        /*
         * Step 01
         * 휴가 타입 (HALF:반차  , ALL : 종일)
         * 반차일경우 오전 / 오후 구분
        */
        if(paramMap.containsKey("vacType")){
	        String vacType = paramMap.get("vacType").toString();

	        if(vacType.equals("HALF")){
	            paramMap.put("allHalf",paramMap.get("halfAmPm").toString());

	            if(appvDocType.equals("SICK"))
	            	paramMap.put("searchActivityDocType", paramMap.get("appvDocType").toString());
	            else
	            	paramMap.put("searchActivityDocType", appvDocType+"_"+paramMap.get("halfAmPm").toString());
	        }
	        else {
	        	paramMap.put("allHalf",vacType);

	        	if(appvDocType.equals("SICK"))
	            	paramMap.put("searchActivityDocType", paramMap.get("appvDocType").toString());
	        	else
	        		paramMap.put("searchActivityDocType", appvDocType+"_"+vacType);
	        }
        }else if(appvDocType.equals("REST")) paramMap.put("searchActivityDocType", paramMap.get("appvDocType").toString());

        /*
         * Step 02
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }
        /*
         * Step 03
         * 저장
         *
        */
        EgovMap projectMap = approveDao.getActivityInfo(paramMap);

        paramMap.put("projectId", projectMap.get("projectId"));
        paramMap.put("activityId", projectMap.get("activityId"));

        cnt = approveDao.updateApproveDoc(paramMap);

        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }

        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 04
         * 연결 결재문서가 있다면 처리

        */

        approveDao.deleteLinkRefDoc(paramMap);
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        return cnt;
    }
    //구매 품의서 저장
    public Integer insertPurchaseApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList) throws Exception{
        Integer cnt = 0;
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 저장
         *
        */
        if(fileList.size()>0){
            paramMap.put("attachYn", "Y");
        }else
            paramMap.put("attachYn", "N");
        Integer appvBuyId = approveDao.insertApproveDoc(paramMap);
        /*
         * Step 04
         * 파일처리
         *
        */
        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);

            paramMap.put("fileList", param);
            paramMap.put("usrSeq", paramMap.get("userId"));
            paramMap.put("uploadId", appvBuyId);
            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
        /*
         * Step 05
         * 구매신청품의목록 저장
         *
        */
        Map<String,Object> buyListMap = new HashMap<String, Object>();

        String[] itemNm = (String[])paramMap.get("itemNm");
        String[] price = (String[])paramMap.get("price");
        String[] qty = (String[])paramMap.get("qty");
        String[] memo = (String[])paramMap.get("purMemo");
        for(int i = 0 ; i<itemNm.length;i++){
            buyListMap.put("appvDocId", appvBuyId);
            buyListMap.put("itemNm", itemNm[i]);
            buyListMap.put("price", price[i]);
            buyListMap.put("qty", qty[i]);
            buyListMap.put("memo", memo[i]);
            approveDao.insertBuyList(buyListMap);
        }
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }

        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 06
         * 연결 결재문서가 있다면 처리

        */
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }

        return cnt;
    }
    //지출결의서 저장
    public Integer insertExpenseApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList,ApproveVoList appVoList) throws Exception{
        Integer cnt = 0;
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 저장
         *
        */
        if(fileList.size()>0){
            paramMap.put("attachYn", "Y");
        }else
            paramMap.put("attachYn", "N");
        Integer appvBuyId = approveDao.insertApproveDoc(paramMap);
        approveDao.insertExpenseApprove(paramMap);
        /*
         * Step 04
         * 파일처리
         *
        */
        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);

            paramMap.put("fileList", param);
            paramMap.put("usrSeq", paramMap.get("userId"));
            paramMap.put("uploadId", appvBuyId);
            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
        /*
         * Step 06
         * 지출품의목록 저장
         *
        */
        Map<String,Object> buyListMap = new HashMap<String, Object>();

        String[] expenseDate = (String[])paramMap.get("expenseDate");
        String[] paymentType = (String[])paramMap.get("paymentType");
        String[] summary = (String[])paramMap.get("summary");
        String[] expenseTypeStr = (String[])paramMap.get("expenseTypeStr");
        String[] expenseAmount = (String[])paramMap.get("expenseAmount");
        String[] comment = (String[])paramMap.get("comment");


        buyListMap.put("userId", paramMap.get("userId"));

        for(int i = 0 ; i<expenseDate.length;i++){
            buyListMap.put("appvDocId", appvBuyId);
            buyListMap.put("expenseDate", expenseDate[i]);
            String expenseTypeStrBuf = expenseTypeStr[i];

            String[] expenseTypeArr = expenseTypeStrBuf.split("[|]");

            buyListMap.put("expenseCodeSetName", expenseTypeArr[0]);
            buyListMap.put("expenseType", expenseTypeArr[1]);
            buyListMap.put("paymentType", paymentType[i]);
            buyListMap.put("summary", summary[i]);
            buyListMap.put("expenseAmount", expenseAmount[i]);
            buyListMap.put("comment", comment[i]);
            approveDao.insertExpenseList(buyListMap);
        }
        /*
         * Step 07
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 08
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 09
         * 연결 결재문서가 있다면 처리

        */
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        /*
         * Step 10
         * 결재라인
         *
        */
        if(paramMap.get("individualYn")!=null){
        	String individualYn =paramMap.get("individualYn").toString();

        	if(individualYn.equals("Y")){
        		paramMap.put("appvDocId", appvBuyId);

        		Integer appvHeaderId = approveDao.insertApproveHeaderIndividual(paramMap);
            	//결재라인 삭제
            	//cnt = approveDao.deleteApproveLineIndividual(paramMap);

                List<ApproveVo> approveVos = appVoList.getAppVoList();
            	//List<> approveVos = (List)<ApproveVo>map.get("appVoList");

                for(ApproveVo approveVo : approveVos){
                	approveVo.setAppvHeaderId(appvHeaderId.toString());
                	approveVo.setUserId(paramMap.get("userId").toString());
                	approveVo.setOrgId(paramMap.get("orgId").toString());
                    cnt = approveDao.insertApproveLineIndividual(approveVo);
                }
        	}
        }
        return cnt;
    }

    //경조사 품의서 저장
    public Integer insertEventApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList) throws Exception{
        Integer cnt = 0;

        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 저장
         *
        */
        if(fileList.size()>0){
            paramMap.put("attachYn", "Y");
        }else
            paramMap.put("attachYn", "N");

        paramMap.put("searchActivityDocType", paramMap.get("appvDocType").toString());
        EgovMap projectMap = approveDao.getActivityInfo(paramMap);

        paramMap.put("projectId", projectMap.get("projectId"));
        paramMap.put("activityId", projectMap.get("activityId"));

        approveDao.insertApproveDoc(paramMap);
        approveDao.insertEventApprove(paramMap);

        /*
         * Step 04
         * 파일처리
         *
        */
        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);

            paramMap.put("fileList", param);
            paramMap.put("usrSeq", paramMap.get("userId"));
            paramMap.put("uploadId", paramMap.get("appvDocId"));
            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
        /*
         * Step 05
         * 참조인이 있다면 참조인 테이블에 삭제 후  업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 06
         * 수신인이 있다면 참조인 테이블에 삭제 후  업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 07
         * 연결 결재문서가 있다면 처리

        */
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        return cnt;
    }
    //경조사 품의서 수정
    public Integer modifyEventApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList,String[] delFileList) throws Exception{
        Integer cnt = 0;

        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 수정
         *
        */
        int delFileListSize = delFileList==null?0:delFileList.length;
        int fileListSize = fileList==null?0:fileList.size();

        if(fileListSize-delFileListSize<=0)
        	paramMap.put("attachYn","N");
        else
        	paramMap.put("attachYn","Y");

        paramMap.put("searchActivityDocType", paramMap.get("appvDocType").toString());
        EgovMap projectMap = approveDao.getActivityInfo(paramMap);

        paramMap.put("projectId", projectMap.get("projectId"));
        paramMap.put("activityId", projectMap.get("activityId"));

        approveDao.updateApproveDoc(paramMap);
        approveDao.modifyEventApprove(paramMap);

        /*
         * Step 04
         * 파일처리
         *
        */
        paramMap.put("usrSeq", paramMap.get("userId"));
        paramMap.put("uploadId", paramMap.get("appvDocId").toString());

        if(delFileList!=null){		//정상저장 이고 파일이 있을때
        	Map<String,Object> deleteFileMap = new HashMap<String, Object>();
        	deleteFileMap.put("fileArr", delFileList);
			fileService.updateDelFlag(deleteFileMap);						//파일 db저장 된거 삭제
		}

        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);
            paramMap.put("fileList", param);

            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
        /*
         * Step 05
         * 참조인이 있다면 참조인 테이블에 삭제 후  업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 06
         * 수신인이 있다면 참조인 테이블에 삭제 후  업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 07
         * 연결 결재문서가 있다면 처리

        */

        approveDao.deleteLinkRefDoc(paramMap);
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        return cnt;
    }
  //지출결의서 수정
    public Integer updateExpenseApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList,ApproveVoList appVoList,String[] delFileList) throws Exception{
        Integer cnt = 0;
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 수정
         *
        */
        int delFileListSize = delFileList==null?0:delFileList.length;
        int fileListSize = fileList==null?0:fileList.size();

        if(fileListSize-delFileListSize<=0)
        	paramMap.put("attachYn","N");
        else
        	paramMap.put("attachYn","Y");
        approveDao.updateApproveDoc(paramMap);
        approveDao.updateExpenseApprove(paramMap);
        /*
         * Step 04
         * 파일처리
         *
        */
        paramMap.put("usrSeq", paramMap.get("userId"));


        if(delFileList!=null){		//정상저장 이고 파일이 있을때
        	Map<String,Object> deleteFileMap = new HashMap<String, Object>();
        	deleteFileMap.put("fileArr", delFileList);
			fileService.updateDelFlag(deleteFileMap);						//파일 db저장 된거 삭제
		}

        paramMap.put("uploadId", paramMap.get("appvDocId").toString());

        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);
            paramMap.put("fileList", param);

            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
        /*
         * Step 06
         * 지출품의목록 저장
         *
        */
        approveDao.deleteExpenseList(paramMap);
        Map<String,Object> buyListMap = new HashMap<String, Object>();

        String[] expenseDate = (String[])paramMap.get("expenseDate");
        String[] paymentType = (String[])paramMap.get("paymentType");
        String[] summary = (String[])paramMap.get("summary");
        String[] expenseTypeStr = (String[])paramMap.get("expenseTypeStr");
        String[] expenseAmount = (String[])paramMap.get("expenseAmount");
        String[] comment = (String[])paramMap.get("comment");


        buyListMap.put("userId", paramMap.get("userId"));

        for(int i = 0 ; i<expenseDate.length;i++){
            buyListMap.put("appvDocId", paramMap.get("appvDocId"));
            buyListMap.put("expenseDate", expenseDate[i]);
            String expenseTypeStrBuf = expenseTypeStr[i];

            String[] expenseTypeArr = expenseTypeStrBuf.split("[|]");

            buyListMap.put("expenseCodeSetName", expenseTypeArr[0]);
            buyListMap.put("expenseType", expenseTypeArr[1]);
            buyListMap.put("paymentType", paymentType[i]);
            buyListMap.put("summary", summary[i]);
            buyListMap.put("expenseAmount", expenseAmount[i]);
            buyListMap.put("comment", comment[i]);
            approveDao.insertExpenseList(buyListMap);
        }
        /*
         * Step 07
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 08
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 09
         * 연결 결재문서가 있다면 처리

        */
        approveDao.deleteLinkRefDoc(paramMap);
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        /*
         * Step 10
         * 결재라인
         *
        */
        Integer deleteHeaderId = approveDao.selectApprovalHeaderIdIndividual(paramMap);
        if(deleteHeaderId!=null){
        	paramMap.put("deleteHeaderId", deleteHeaderId);
        	approveDao.deleteApproveHeaderIndividual(paramMap);
        	approveDao.deleteApproveLineIndividual(paramMap);
        }

        if(paramMap.get("individualYn")!=null && appVoList.getAppVoList() != null && appVoList.getAppVoList().size()>0){
        	String individualYn =paramMap.get("individualYn").toString();

        	if(individualYn.equals("Y")){

        		Integer appvHeaderId = approveDao.insertApproveHeaderIndividual(paramMap);
            	//결재라인 삭제
            	//cnt = approveDao.deleteApproveLineIndividual(paramMap);

                List<ApproveVo> approveVos = appVoList.getAppVoList();
            	//List<> approveVos = (List)<ApproveVo>map.get("appVoList");

                for(ApproveVo approveVo : approveVos){
                	approveVo.setAppvHeaderId(appvHeaderId.toString());
                	approveVo.setUserId(paramMap.get("userId").toString());
                	approveVo.setOrgId(paramMap.get("orgId").toString());
                    cnt = approveDao.insertApproveLineIndividual(approveVo);
                }
        	}
        }
        return cnt;
    }
    //사내 품의서 수정
  	public Integer updateCompanyApprove(Map<String,Object> paramMap,List<Map<String , Object>> fileList,ApproveVoList appVoList,String[] delFileList) throws Exception{
  		Integer cnt = 0;
  		/*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }
        int delFileListSize = delFileList==null?0:delFileList.length;
        int fileListSize = fileList==null?0:fileList.size();

        if(fileListSize-delFileListSize<=0)
        	paramMap.put("attachYn","N");
        else
        	paramMap.put("attachYn","Y");
        /*
         * Step 02
         * 저장
         *
        */
        approveDao.updateApproveDoc(paramMap);
        /*
         * Step 03
         * 파일처리
         *
        */
        paramMap.put("usrSeq", paramMap.get("userId"));
        paramMap.put("uploadId", paramMap.get("appvDocId").toString());

        if(delFileList!=null){		//정상저장 이고 파일이 있을때
        	Map<String,Object> deleteFileMap = new HashMap<String, Object>();
        	deleteFileMap.put("fileArr", delFileList);
			fileService.updateDelFlag(deleteFileMap);						//파일 db저장 된거 삭제
		}

        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);
            paramMap.put("fileList", param);

            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
  		/*
         * Step 04
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 05
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 06
         * 연결 결재문서가 있다면 처리

        */
        approveDao.deleteLinkRefDoc(paramMap);
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }
        /*
         * Step 07
         * 결재라인
         *
        */
        Integer deleteHeaderId = approveDao.selectApprovalHeaderIdIndividual(paramMap);
        if(deleteHeaderId!=null){
        	paramMap.put("deleteHeaderId", deleteHeaderId);
        	approveDao.deleteApproveHeaderIndividual(paramMap);
        	approveDao.deleteApproveLineIndividual(paramMap);
        }

        if(paramMap.get("individualYn")!=null && appVoList.getAppVoList() != null && appVoList.getAppVoList().size()>0){
        	String individualYn =paramMap.get("individualYn").toString();

        	if(individualYn.equals("Y")){

        		Integer appvHeaderId = approveDao.insertApproveHeaderIndividual(paramMap);
            	//결재라인 삭제
            	//cnt = approveDao.deleteApproveLineIndividual(paramMap);

                List<ApproveVo> approveVos = appVoList.getAppVoList();
            	//List<> approveVos = (List)<ApproveVo>map.get("appVoList");

                for(ApproveVo approveVo : approveVos){
                	approveVo.setAppvHeaderId(appvHeaderId.toString());
                	approveVo.setUserId(paramMap.get("userId").toString());
                	approveVo.setOrgId(paramMap.get("orgId").toString());
                    cnt = approveDao.insertApproveLineIndividual(approveVo);
                }
        	}
        }

  		return cnt;
  	}

    //교육 품의서 저장
    public Integer insertEducationApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList) throws Exception{
        Integer cnt = 0;
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 저장
         *
        */
        if(fileList.size()>0){
            paramMap.put("attachYn", "Y");
        }else
            paramMap.put("attachYn", "N");

        Integer appvEduId =approveDao.insertApproveDoc(paramMap);

        approveDao.insertEducationApprove(paramMap);

        /*
         * Step 04
         * 파일처리
         *
        */
        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);

            paramMap.put("fileList", param);
            paramMap.put("usrSeq", paramMap.get("userId"));
            paramMap.put("uploadId", appvEduId);
            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
        /*
         * Step 05
         * 교육참여자 저장
         *
        */
        if(paramMap.get("entryId")!=null){
        	cnt = approveDao.insertEntryWorker(paramMap);
        }
        /*
         * Step 06
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }

        /*
         * Step 07
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveRcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 08
         * 연결 결재문서가 있다면 처리

        */
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }

        return cnt;
    }
    //교육 품의서 수정
    public Integer modifyEducationApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList,String[] delFileList) throws Exception{
        Integer cnt = 0;
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        /*
         * Step 02
         * 수정
         *
        */
        int delFileListSize = delFileList==null?0:delFileList.length;
        int fileListSize = fileList==null?0:fileList.size();

        if(fileListSize-delFileListSize<=0)
        	paramMap.put("attachYn","N");
        else
        	paramMap.put("attachYn","Y");
        approveDao.updateApproveDoc(paramMap);
        approveDao.modifyEducationApprove(paramMap);

        /*
         * Step 04
         * 파일처리
         *
        */
        paramMap.put("usrSeq", paramMap.get("userId"));


        if(delFileList!=null){		//정상저장 이고 파일이 있을때
        	Map<String,Object> deleteFileMap = new HashMap<String, Object>();
        	deleteFileMap.put("fileArr", delFileList);
			fileService.updateDelFlag(deleteFileMap);						//파일 db저장 된거 삭제
		}

        paramMap.put("uploadId", paramMap.get("appvDocId").toString());

        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);
            paramMap.put("fileList", param);

            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
        /*
         * Step 05
         * 교육참여자 삭제/저장
         *
        */
        cnt = approveDao.deleteEntryWorker(paramMap);
        if(paramMap.get("entryId")!=null){
        	cnt = approveDao.insertEntryWorker(paramMap);
        }
        /*
         * Step 06
         * 참조인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }
        /*
         * Step 07
         * 수신인이 있다면 참조인 테이블에 업데이트한다.
         * approveCcType 정리
         * noSelect : 선택안함
         * all : 관계사전체
         * inDept : 소속팅
         * select : 직접선택
        */
        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 08
         * 연결 결재문서가 있다면 처리

        */
        approveDao.deleteLinkRefDoc(paramMap);
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }

        return cnt;
    }

    //구매 품의서 수정
    public Integer updatePurchaseApprove(Map<String, Object> paramMap,List<Map<String , Object>> fileList,String[] delFileList) throws Exception{
        Integer cnt = 0;
        /*
         * Step 01
         * null값 처리
         *
        */
        for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }

        int delFileListSize = delFileList==null?0:delFileList.length;
        int fileListSize = fileList==null?0:fileList.size();

        if(fileListSize-delFileListSize<=0)
        	paramMap.put("attachYn","N");
        else
        	paramMap.put("attachYn","Y");

        /*
         * Step 02
         * 저장
         *
        */
        approveDao.updateApproveDoc(paramMap);

        /*
         * Step 04
         * 파일처리
         *
        */
        paramMap.put("usrSeq", paramMap.get("userId"));
        paramMap.put("uploadId", paramMap.get("appvDocId").toString());

        if(delFileList!=null){		//정상저장 이고 파일이 있을때
        	Map<String,Object> deleteFileMap = new HashMap<String, Object>();
        	deleteFileMap.put("fileArr", delFileList);
			fileService.updateDelFlag(deleteFileMap);						//파일 db저장 된거 삭제
		}

        if(fileList.size()>0){//공통처리로직
            Map<String,Object> items = new HashMap<String, Object>();
            items.put("items", fileList);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();
            String param = mapper.writeValueAsString(items);
            paramMap.put("fileList", param);

            fileService.insertFileListJson(paramMap);                //파일 db저장
        }
        /*
         * Step 05
         * 구매신청품의목록 삭제 후 저장
         *
        */
        approveDao.deleteBuyList(paramMap);

        Map<String,Object> buyListMap = new HashMap<String, Object>();

        String[] itemNm = (String[])paramMap.get("itemNm");
        String[] price = (String[])paramMap.get("price");
        String[] qty = (String[])paramMap.get("qty");
        String[] memo = (String[])paramMap.get("purMemo");
        for(int i = 0 ; i<itemNm.length;i++){
            buyListMap.put("appvDocId",  paramMap.get("appvDocId").toString());
            buyListMap.put("itemNm", itemNm[i]);
            buyListMap.put("price", price[i]);
            buyListMap.put("qty", qty[i]);
            buyListMap.put("memo", memo[i]);
            approveDao.insertBuyList(buyListMap);
        }
        cnt = approveDao.deleteApproveCc(paramMap);
        String approveCcType = paramMap.get("approveCcType").toString();
        if(!approveCcType.equals("NONE")){
            cnt = approveDao.insertApproveCc(paramMap);
        }

        cnt = approveDao.deleteApproveRc(paramMap);
        String approveRcType = paramMap.get("approveRcType").toString();
        if(!approveRcType.equals("NONE")){
            cnt = approveDao.insertApproveRc(paramMap);
        }
        /*
         * Step 06
         * 연결 결재문서가 있다면 처리

        */

        approveDao.deleteLinkRefDoc(paramMap);
        if(paramMap.containsKey("refDocIdStr")){
        	String[] refDocIdStrArr = (String[])paramMap.get("refDocIdStr");

        	for(int i = 0 ; i < refDocIdStrArr.length ; i ++){
        		String refDocIdBuf = refDocIdStrArr[i];

        		String[] refDocIdBufArr = refDocIdBuf.split("[|]");
        		String refDocId = refDocIdBufArr[0];

        		paramMap.put("refDocId", refDocId);

        		 cnt = approveDao.insertLinkRefDocId(paramMap);
        	}
        }

        return cnt;
    }
    //품의 수신자 조회
    public List<EgovMap> getApproveRcList(Map<String, Object> paramMap) throws Exception {
    	return approveDao.getApproveRcList(paramMap);
    }
    //품의서 상세 조회
    public EgovMap getApproveDetail(Map<String, Object> paramMap) throws Exception {

    	//읽음처리
		approveDao.updateAppvDocReadId(paramMap);

    	//품의 수신자를 조회한다
		List<EgovMap> approveRcList = approveDao.getApproveRcList(paramMap);
		if(approveRcList != null && approveRcList.size()>0){
			//수신자가 조회하면 READ_DATE를 업데이트한다
			approveDao.updateAppvRcReadDate(paramMap);
		}

    	EgovMap result = new EgovMap();

        result = approveDao.getApproveDocDetail(paramMap);
        String appvDocClass = result.get("appvDocClass").toString();

        //품의 참조자를 조회한다
		List<EgovMap> approveCcList = approveDao.getApproveCcList(result);
		if(approveCcList != null && approveCcList.size()>0){
			result.put("approveCcList", approveCcList);

			//참조자가 조회하면 READ_DATE를 업데이트한다
			approveDao.updateAppvCcReadDate(paramMap);
		}

		if(approveRcList != null && approveRcList.size()>0){
			result.put("approveRcList", approveRcList);
		}

		//연결 결재문서
		List<EgovMap> approveLinkDocList = approveDao.getApproveLinkDocList(result);
		if(approveLinkDocList != null && approveLinkDocList.size()>0){
			result.put("approveLinkDocList", approveLinkDocList);
		}

		if(appvDocClass.equals("BUY")) result.put("buyList", approveDao.getApproveBuyList(paramMap));  //구매리스트
		else if(appvDocClass.equals("EDUCATION" )) {
			 result.put("eduWorkerList", approveDao.getApproveEntryWokerList(paramMap));   //교육참여자
		}else if(appvDocClass.equals("TRIP")) {
			 result.put("tripList", approveDao.getApproveTripList(paramMap));   //출장비내역

		     result.put("tripWorkerList", approveDao.getApproveEntryWokerList(paramMap));  //출장동행자
		}else if(appvDocClass.equals("EXPENSE")) {
			 result.put("expenseList", approveDao.getApproveExpenseList(paramMap));  //구매리스트
		}

        return result;
    }
    //품의서 상세 조회(기본정보만 조회)
  	public EgovMap getApproveDocDetail(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getApproveDocDetail(paramMap);
  	}

    //기안문서 summary
    public EgovMap getDraftSummary(Map<String,Object> paramMap) throws Exception{
        return approveDao.getDraftSummary(paramMap);
    }

    //결제문서 summary
    public EgovMap getReqSummary(Map<String,Object> paramMap) throws Exception{
        return approveDao.getReqSummary(paramMap);
    }

    //기안문서 List
    public List<EgovMap> getDraftDocList(Map<String,Object> paramMap) throws Exception{
        Integer totCnt =0;

        totCnt = approveDao.getDraftDocListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getDraftDocList(paramMap);
    }

    //내가 작성한 문서 cnt....
    public Integer getDraftDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
    	return approveDao.getDraftDocListTotalCnt(paramMap);
    }
    //결재문서 List
    public List<EgovMap> getReqDocList(Map<String,Object> paramMap) throws Exception{
        Integer totCnt =0;

        totCnt = approveDao.getReqDocListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getReqDocList(paramMap);
    }
    //메인화면결재문서 List
  	public List<EgovMap> getReqDocListForMain(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getReqDocListForMain(paramMap);
  	}
    //취소승인 List
  	public List<EgovMap> getCancelDocList(Map<String,Object> paramMap) throws Exception{
  		Integer totCnt =0;

        totCnt = approveDao.getCancelDocListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getCancelDocList(paramMap);
  	}
    //참조문서 List
    public List<EgovMap> getRefDocList(Map<String,Object> paramMap) throws Exception{
        Integer totCnt =0;

        totCnt = approveDao.getRefDocListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getRefDocList(paramMap);
    }
    //수신문서 List
    public List<EgovMap> getRcDocList(Map<String,Object> paramMap) throws Exception{
        Integer totCnt =0;

        totCnt = approveDao.getRcDocListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getRcDocList(paramMap);
    }
    //지출문서 List
    public List<EgovMap> getAppvDocExpenseList(Map<String,Object> paramMap) throws Exception{
        Integer totCnt =0;

        totCnt = approveDao.getAppvDocExpenseListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getAppvDocExpenseList(paramMap);
    }

    //결재라인을 검색 List
    public List<EgovMap> getApproveLine(Map<String, Object> paramMap) throws Exception {

        String docStatus = (String)paramMap.get("docStatus");
        if(docStatus==null||docStatus.equals("WORKING")){
            this.doSaveApprovaeProcessNoSubmit(paramMap);
        }

        List<EgovMap> approveLineEgovMap = approveDao.getApproveLine(paramMap);

        //List<EgovMap> approveLineEgovMapNew = new ArrayList<EgovMap>();

        if(docStatus==null||docStatus.equals("WORKING")){
            this.deleteApprovaeProcessNoSubmit(paramMap);
        }

        return approveLineEgovMap;
    }

    //직접지정결재라인을 검색 List
    public List<EgovMap> getApproveLineIndividual(Map<String, Object> paramMap) throws Exception {

        String docStatus = (String)paramMap.get("docStatus");

        if(docStatus==null||docStatus.equals("WORKING")){
           this.doSaveApprovaeProcessNoSubmitIndividual(paramMap);
        }

        List<EgovMap> approveLineEgovMap = approveDao.getApproveLineIndividual(paramMap);

        //List<EgovMap> approveLineEgovMapNew = new ArrayList<EgovMap>();

        /*if(docStatus==null||docStatus.equals("WORKING")){
            this.deleteApprovaeProcessNoSubmit(paramMap);

            //중복되는 결재자 제거
            for(int i = 0; i < approveLineEgovMap.size(); i++){
                Long appvAsignUserId = (Long)approveLineEgovMap.get(i).get("appvAssignId");

                boolean isExist = false;
                if(appvAsignUserId != null){
                    for(int j = 0; j < approveLineEgovMapNew.size(); j++){
                        Long apprvAsignedUserId = (Long)approveLineEgovMapNew.get(j).get("appvAssignId");
                        if(appvAsignUserId.equals(apprvAsignedUserId)){
                            isExist = true;
                            break;
                        }
                    }
                }

                if(!isExist){
                    approveLineEgovMapNew.add(approveLineEgovMap.get(i));
                }
            }

            approveLineEgovMap = approveLineEgovMapNew;
        }*/

        return approveLineEgovMap;
    }

    //품의서 승인취소요청
  	public Integer processApproveCancelReq(Map<String,Object> paramMap) throws Exception{
  		return approveDao.processApproveCancelReq(paramMap);
  	}

    //품의서 상신
    public Integer processDocSubmit(Map<String,Object> paramMap) throws Exception{
        String appvDocClass = paramMap.get("appvDocClass").toString();
        Integer cnt = 0;

        paramMap.put("useYn", "Y");
        List<EgovMap> approveDocNumList =approveDao.approveDocNumList(paramMap);

        if(approveDocNumList == null || approveDocNumList.size() ==0) return -1;

        /*
         * Step 01
         * 품의서상태 변경
         *
        */
        paramMap.put("docStatus", "SUBMIT");

        //경조사 품의서 상태변경
        if(appvDocClass.equals("EVENT")){


        	//상신하기위한 정보를 조회한다
        	EgovMap eventIdInfo = approveDao.familyEventsDetail(paramMap);
        	if(eventIdInfo!=null){
        		paramMap.put("holiday",eventIdInfo.get("holiday"));
        		//paramMap.put("amount",eventIdInfo.get("amount"));
        	}else{
        		//정보가 null이거나 다수 데이터가 조회되면 잘못된 조회이다.
        		throw new Exception();
        	}

        	//경조휴가기간이 0일인경우 휴가기간을 업데이트하지 않는다 (17.06.30)

        	if((Integer)eventIdInfo.get("period")>0){
        		cnt = approveDao.modifyApproveEventSubmitInfo(paramMap);
        	}
        }

        /*
         * Step 02
         * 품의서문서번호 설정을 셋팅
         *
        */
        EgovMap appvDocNumMap = approveDocNumList.get(0);
        paramMap.put("appvDocNumRuleDate", appvDocNumMap.get("appvDocNumRuleDate"));
        paramMap.put("appvDocNumRuleMidName", appvDocNumMap.get("appvDocNumRuleMidName"));
        paramMap.put("appvDocNumRuleSeq", appvDocNumMap.get("appvDocNumRuleSeq"));

        cnt=approveDao.modifyAprvStatus(paramMap);
        /*
         * Step 03
         * 상신처리 변경
         *
        */
        String individualYn = paramMap.get("individualYn").toString();

        if(individualYn.equals("N")){

	        //상신전 부서정보 임시 저장
	        this.doSaveApprovaeProcessNoSubmit(paramMap);

	        //결재라인 생성
	        cnt=approveDao.insertApproveProcess(paramMap);

	        //중복결재라인 삭제
	        //for(;approveDao.deleteDupApproveProcess(paramMap).intValue() != 0;);

	        //상신전 부서정보 임시 삭제
	        this.deleteApprovaeProcessNoSubmit(paramMap);
	    }else{
	    	//상신전 부서정보 임시 저장
	        this.doSaveApprovaeProcessNoSubmitIndividual(paramMap);

	        //결재라인 생성
	        cnt=approveDao.insertApproveProcessIndividual(paramMap);

	        //중복결재라인 삭제
	        //for(;approveDao.deleteDupApproveProcess(paramMap).intValue() != 0;);

	        //상신전 부서정보 임시 삭제
	        this.deleteApprovaeProcessNoSubmit(paramMap);
	    }
        /*
         * Step 04
         * 필수 참가자 저장
         *
        */
        cnt=approveDao.insertApproveCcSetup(paramMap);
        /*
         * Step 05
         * 필수 수신자 저장
         *
        */
        cnt=approveDao.insertApproveReceiverSetup(paramMap);

        this.sendSms("NEXT" , paramMap);

        return cnt;
    }
    //처리의견등록
    public Integer processDocComment(Map<String, Object> paramMap) throws Exception {

    	return approveDao.modifyAppvComment(paramMap);
    }
    //품의서 상태변경
    @SuppressWarnings("unchecked")
	public Integer processDocStatus(Map<String, Object> paramMap) throws Exception {

        //품의서 Doc Class..
        String appvDocClass = paramMap.get("appvDocClass").toString();

        //변경될 상태값
        String docStatus = paramMap.get("docStatus").toString();

        Integer cnt = 0;

        paramMap.put("appvStatus", docStatus);

        /*
         * Step 01
         * 품의승인절차 update
         *
        */
        approveDao.updateProcessStatus(paramMap);


        //1206 Step03 , Step04 ---> Step01로 통합 :박성진.....
        /*
         * Step 03
         * 실제 승인/반려자의 id업데이트
         *
        */
        //cnt=approveDao.modifyAprvProcessAprvEmpId(paramMap);
        /*
         * Step 04
         * 실제 승인/반려자의 코멘트 입력
         *
        */
        //cnt=approveDao.modifyAppvComment(paramMap);


        /*
         * Step 02
         * 반려인경우
         *
        */
        if(docStatus.equals("REJECT")){
        	cnt=approveDao.modifyAprvStatus(paramMap);
        /*
         * Step 02
         * 승인인경우
         *
        */
        }else if(docStatus.equals("APPROVE")){
            /*
             * Step 02-1
             * 해당결재라인이 모두 APPROVE인지 검사하기 위해 APPROVE이면 후 처리 진행(동일레벨결재자가 없는경우)
             *
            */
            if(approveDao.getNoApproveCntSemeAppvSeq(paramMap).intValue() == 0){
                /*
                 * Step 02-1-1
                 * 다음결재라인을 REQ로  UPDATE
                 *
                */
            	String listType = paramMap.get("listType").toString();
            	if(!listType.equals("nextList")){
            		 cnt=approveDao.modifyAprvProcessApproveStatus(paramMap);

                /*
                 * Step 02-1-2
                 * 마지막결재라인 승인처리인 경우 각 품의문서의 상태값을 승인으로, 중간단계인 경우 승인진행으로 변경
                 *
                */
                cnt=approveDao.modifyAprvStatusApprove(paramMap);
            	}

                /*
                 * Step 02-1-3
                 * 이전결재라인에 REQ인 상태가 있다면 (후결) WAIT으로변경
                 *
                */
                cnt=approveDao.modifyAprvStatusApproveBefore(paramMap);

            }

            /*
             * Step 5
             * 마지막 결재라인의 승인(완료상태변경시점)일때 후처리
             *
            */
            if(approveDao.getApproveProcessNotCommitCnt(paramMap).intValue() == 0){
            	if(appvDocClass.equals("VACATION")){
            		cnt=approveDao.insertApproveAgency(paramMap);
            		//연차정보 , 병가라면 재직상태 프로세스
            		this.processUserHoliSumInfo1(paramMap);

            		//후처리 로직
                    this.processCompleteApproveDocVac(paramMap);
                //교육 품의서
                }else if(appvDocClass.equals("EDUCATION")){
                	//업무대행자처리
                	cnt=approveDao.insertApproveAgency(paramMap);
                	this.processCompleteApproveDocEdu(paramMap);
                //출장 품의서
                }else if(appvDocClass.equals("TRIP")){
                	//업무대행자처리
                	cnt=approveDao.insertApproveAgency(paramMap);
                	this.processCompleteApproveDocTrip(paramMap);
                //경조사 품의서
                }else if(appvDocClass.equals("EVENT")){
                	if(EgovStringUtil.isNotEmpty(paramMap.get("dateTo").toString())){
    	            	//업무대행자처리
    	            	cnt=approveDao.insertApproveAgency(paramMap);
    	            	this.processCompleteApproveDocEvent(paramMap);
                	}
                //휴직 품의서(휴직 상태변경)
                }else if(appvDocClass.equals("REST")){
                	cnt=approveDao.insertApproveAgency(paramMap);
                	this.processCompleteApproveDocRest(paramMap);
                }

            	this.sendSms("COMMIT" , paramMap);

            }else if(docStatus.equals("APPROVE")){
            	this.sendSms("NEXT" , paramMap);
            }

        }
        //결재자가 경조사의 금액을 변경했는지 체크
       /* if(paramMap.get("amountEvent")!=null&&appvDocClass.equals("EVENT")){
        	int amount = Integer.parseInt(paramMap.get("amount").toString());

        	int amountEvent = Integer.parseInt(paramMap.get("amountEvent").toString());

        	if(amount!=amountEvent){
        		DecimalFormat df = new DecimalFormat("#,##0");

        		String comment = "*경조금액 변경*\\n-변경전 : "+df.format(amount)+" 원\\n-변경후 : "+ df.format(amountEvent)+" 원";

        		paramMap.put("eventAmountComment", comment);

        		cnt=approveDao.modifyAprvEventAmount(paramMap);
        	}
        }*/

        return cnt;
    }
    //품의서 취소 상태변경
    @SuppressWarnings("unchecked")
	public Integer processDocStatusCancel(Map<String, Object> paramMap) throws Exception {

        //품의서 Doc Class..
        String appvDocClass = paramMap.get("appvDocClass").toString();

        //변경될 상태값
        String docStatus = paramMap.get("docStatus").toString();

        Integer cnt = 0;

        paramMap.put("appvStatus", docStatus);

        cnt=approveDao.modifyCancelComment(paramMap);

        Integer cancelChkCnt = approveDao.getCancelChkCnt(paramMap);

        if(cancelChkCnt > 0 ||docStatus.equals("CNL_SUBMIT")){
        	cnt=approveDao.modifyCancelAprvStatus(paramMap);

        	/*
             * Step 02
             * 취소승인인경우
             *
            */
            if(docStatus.equals("CNL_COMMIT")){
            	if(!appvDocClass.equals("BUY")&&!appvDocClass.equals("REST")){
            		//업무대행자처리
                	cnt=approveDao.deleteApproveAgency(paramMap);
                	approveDao.updateErpSchApproveCancel(paramMap);
                	if(appvDocClass.equals("VACATION")){
                		//연차정보 , 병가라면 재직상태 프로세스
                		this.processCancelUserHoliSum(paramMap);
                	}
            	}else if(appvDocClass.equals("REST")){
                	cnt=approveDao.deleteApproveAgency(paramMap);
                	approveDao.updateErpSchApproveCancel(paramMap);
                	this.processCancelApproveDocRest(paramMap);
                }

            }
        }

        return cnt;
    }

    //휴가 품의서 완료 후 처리
    public void processCompleteApproveDocVac(Map<String, Object> paramMap) throws Exception{
    	Integer cnt = 0 ;
    	cnt=approveDao.insertErpSchApproveVacProcessAfter(paramMap);
    	cnt=approveDao.insertErpEntrySchApproveVacProcessAfter(paramMap);
    }
    //교육 품의서 완료 후 처리
    public void processCompleteApproveDocEdu(Map<String, Object> paramMap) throws Exception{
    	Integer cnt = 0 ;
    	cnt=approveDao.insertErpSchApproveEduProcessAfter(paramMap);
    	cnt=approveDao.insertErpEntryApproveEduProcessAfter(paramMap);
    }
    //출장 품의서 완료 후 처리
    public void processCompleteApproveDocTrip(Map<String, Object> paramMap) throws Exception{
    	Integer cnt = 0 ;
    	cnt=approveDao.insertErpSchApproveTripProcessAfter(paramMap);
    	cnt=approveDao.insertErpEntryApproveTripProcessAfter(paramMap);
    }
    //경조사 품의서 완료 후 처리
    public void processCompleteApproveDocEvent(Map<String, Object> paramMap) throws Exception{
    	Integer cnt = 0 ;
    	cnt=approveDao.insertErpSchApproveEventProcessAfter(paramMap);
    	cnt=approveDao.insertErpEntrySchApproveEventProcessAfter(paramMap);
    }
    //휴직 품의서 완료 후 처리
    public void processCompleteApproveDocRest(Map<String, Object> paramMap) throws Exception{
    	EgovMap detailMap = new EgovMap();

		detailMap = approveDao.getApproveDocDetail(paramMap);

    	Map<String,Object> procUserStatusMap = new HashMap<String, Object>();

		procUserStatusMap.put("userId", detailMap.get("userId"));
		procUserStatusMap.put("userStatus", "L");
		procUserStatusMap.put("sttsFromDt", detailMap.get("dateFrom"));
		procUserStatusMap.put("sttsEndDt", detailMap.get("dateTo"));
		procUserStatusMap.put("memo", detailMap.get("memo"));
		procUserStatusMap.put("sessionUserId", paramMap.get("userId"));
		procUserStatusMap.put("userLoginId", paramMap.get("loginId"));
		procUserStatusMap.put("appvDocId", paramMap.get("appvDocId"));

		managementDAO.insertUserSttsHist(procUserStatusMap);

		managementDAO.updateUserStatus(procUserStatusMap);

		//managementDAO.updateFireUserCpnId(procUserStatusMap);

		Integer cnt = 0 ;
    	cnt=approveDao.insertErpSchApproveVacProcessAfter(paramMap);
    	cnt=approveDao.insertErpEntrySchApproveVacProcessAfter(paramMap);

    }
    //휴직 품의서 취소 완료 후 처리
    public void processCancelApproveDocRest(Map<String, Object> paramMap) throws Exception{
    	EgovMap detailMap = new EgovMap();

		detailMap = approveDao.getApproveDocDetail(paramMap);

    	Map<String,Object> procUserStatusMap = new HashMap<String, Object>();

		procUserStatusMap.put("userId", detailMap.get("userId"));
		procUserStatusMap.put("userStatus", "L");
		procUserStatusMap.put("sttsFromDt", detailMap.get("dateFrom"));
		procUserStatusMap.put("sttsEndDt", detailMap.get("dateTo"));
		procUserStatusMap.put("sessionUserId", paramMap.get("userId"));
		procUserStatusMap.put("userLoginId", paramMap.get("loginId"));
		procUserStatusMap.put("appvDocId", paramMap.get("appvDocId"));

		managementDAO.deleteUserSttsHist(procUserStatusMap);

		//뱅가나 휴가인 유저를 재직으로 업데이트한다.
		managementDAO.updateUserStatusBeforeBatch();

		managementDAO.updateUserStatus(procUserStatusMap);
    }


    //결제 처리 코멘트 리스트
  	public List<EgovMap> getApproveProcessComment(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getApproveProcessComment(paramMap);
  	}

	/**
	 * 미상신 결재라인 부서정보 임시 저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 22.
	 */
    public void doSaveApprovaeProcessNoSubmit(Map<String, Object> paramMap) throws Exception {
    	Integer appvHeaderId = null;

    	if(paramMap.get("appvHeaderId")!=null){
    		String appvHeaderIdparam = paramMap.get("appvHeaderId").toString();

    		if(appvHeaderIdparam.equals("")){
    			appvHeaderId = approveDao.selectApprovalHeaderId(paramMap);
    		}else
    			appvHeaderId = Integer.parseInt(paramMap.get("appvHeaderId").toString());
    	}else appvHeaderId = approveDao.selectApprovalHeaderId(paramMap);

        paramMap.put("appvHeaderId", appvHeaderId);

        approveDao.createApprovaeProcessNoSubmit(paramMap);

        int cnt = approveDao.selectApprovaeProcessNoSubmitNoDeptCount(paramMap);

        for(int i = 0; i < cnt; i++){
            approveDao.updateApprovaeProcessNoSubmit(paramMap);
        }
    }
    /**
	 * 미상신 직접지정 결재라인 부서정보 임시 저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 22.
	 */
    public void doSaveApprovaeProcessNoSubmitIndividual(Map<String, Object> paramMap) throws Exception {
    	Integer appvHeaderId = null;

    	appvHeaderId = approveDao.selectApprovalHeaderIdIndividual(paramMap);

        paramMap.put("appvHeaderId", appvHeaderId);

        approveDao.createApprovaeProcessNoSubmitIndividual(paramMap);

        int cnt = approveDao.selectApprovaeProcessNoSubmitNoDeptCountIndividual(paramMap);

        for(int i = 0; i < cnt; i++){
            approveDao.updateApprovaeProcessNoSubmitIndividual(paramMap);
        }
    }

	/**
	 * 미상신 결재라인 부서정보 임시 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 22.
	 */
    public void deleteApprovaeProcessNoSubmit(Map<String, Object> paramMap) throws Exception{
        approveDao.deleteApprovaeProcessNoSubmit(paramMap);
    }

    //경조사 분류코드를 조회한다
    public List<EgovMap> familyEventsIdList(Map<String, Object> paramMap) throws Exception{
    	return approveDao.familyEventsIdList(paramMap);
    }
    //경조사 마지막일 조회
    public EgovMap getEventLastDay(Map<String, Object> paramMap) throws Exception{
    	return approveDao.getEventLastDay(paramMap);
    }
 	//품의서 삭제
    public Integer deleteApproveDoc(Map<String,Object> paramMap) throws Exception{
    	Integer cnt = 0;
    	cnt = approveDao.deleteApproveDoc(paramMap);   //품의서 삭제
    	return cnt;
    }
    //dateFrom~dateTo 동안 승인대행자 / 동행자가 휴직상태라면 조회한다.
    public Map<String,Object> getChkAppointedPerson(Map<String,Object> paramMap,Map<String,String> msgMap) throws Exception{
    	//return obj
		Map<String,Object> obj = new HashMap<String,Object>();

    	List<EgovMap> appointedPersonChkList =approveDao.getChkAppointedPerson(paramMap);
    	Integer listSize = appointedPersonChkList.size();
		if(listSize>0){

			SimpleDateFormat transFormat = new SimpleDateFormat("MM월dd일");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//조회할 날짜 to
			Date dateTo = sdf.parse(paramMap.get("dateTo").toString());
			//조회할 날짜 From
			Date dateFrom = sdf.parse(paramMap.get("dateFrom").toString());
			String userId = "";
			Date fromDt = null;

			boolean isFire = false;
			String msg = "";

			int index = 0;

			for(int i = 0 ; i < listSize ; i++){
				//사용자 상태 from~to
				Date endDt = (Date)appointedPersonChkList.get(i).get("sttsEndDt");

				if(endDt == null){

					//userId가 다르다면 초기값 셋팅
					if(!userId.equals(appointedPersonChkList.get(i).get("userId").toString())){
						//사용자 상태 from~to
						fromDt = (Date)appointedPersonChkList.get(i).get("sttsFromDt");
						userId = appointedPersonChkList.get(i).get("userId").toString();
					}

					//일정 메세지
					if(msgMap == null){
						msg = "참가자로 지정하신 " + appointedPersonChkList.get(0).get("name")+"님은 "+transFormat.format(fromDt)+"부터  퇴직(해고)입니다.\n";
						msg += "참가자로 지정할 수 없습니다.";
					}else{
						int workDatePeriod = Integer.parseInt(msgMap.get("workDatePeriod").toString());
						if(workDatePeriod > 1){
							msg = appointedPersonChkList.get(i).get("name")+"님은 "+transFormat.format(fromDt)+"부터 퇴직(해고)입니다.\n";
							msg += "그래도 참가자로 지정하시겠습니까?";
							obj.put("msgType", "CONFIRM");
						}else{
							msg = appointedPersonChkList.get(i).get("name")+"님은 "+transFormat.format(fromDt)+"부터 퇴직(해고)입니다.\n";
							msg += msgMap.get(appointedPersonChkList.get(i).get("userId").toString())+"로 지정할 수 없습니다.";
						}

					}

					obj.put("result", "FAIL");
					obj.put("msg", msg);
					isFire = true;
					index = i;
					break;
				}else{

					//userId가 다르다면 초기값 셋팅
					if(!userId.equals(appointedPersonChkList.get(i).get("userId").toString())){

						if(dateFrom.before((Date)appointedPersonChkList.get(i).get("sttsFromDt"))) continue;

						//사용자 상태 from~to
						fromDt = (Date)appointedPersonChkList.get(i).get("sttsFromDt");

						userId = appointedPersonChkList.get(i).get("userId").toString();

						if(!msg.equals("")){
							index = i-1;
							break;

						}

					}else {
						if(!msg.equals("")){
							index = i;
							break;

						}else {
							msg = "";
							continue;
						}
					}

					//마지막 날짜가 유효하다면 "" 이 아닌 휴가(병가)의 마지막 날짜를 리턴한다.
					msg = this.getChkAppointedPersonEndDate(appointedPersonChkList,i,userId,dateTo,null);

				}
			}

			if(msg.equals("")){
				obj.put("result", "SUCCESS");
			}else{
				obj.put("result", "FAIL");
				if(!isFire){
					//일정 메세지
					if(msgMap == null){
						msg = "참가자로 지정하신 " + appointedPersonChkList.get(index).get("name")+"님은 "+transFormat.format(fromDt)+"부터 "+msg+"까지 병가(휴직)중입니다.\n";
						msg += "참가자로 지정할 수 없습니다.";
						obj.put("msg", msg);
					}else{
						int workDatePeriod = Integer.parseInt(msgMap.get("workDatePeriod").toString());
						if(workDatePeriod > 1){
							msg = appointedPersonChkList.get(index).get("name")+"님은 "+transFormat.format(fromDt)+"부터 "+msg+"까지 병가(휴직)중입니다.\n";
							msg += "그래도 참가자로 지정하시겠습니까?";
							obj.put("msg", msg);
							obj.put("msgType", "CONFIRM");
						}else{
							msg = appointedPersonChkList.get(index).get("name")+"님은 "+transFormat.format(fromDt)+"부터 "+msg+"까지 병가(휴직)중입니다.\n";
							msg += msgMap.get(appointedPersonChkList.get(index).get("userId").toString())+"로 지정할 수 없습니다.";
							obj.put("msg", msg);
						}

					}
				}
			}
		}else{
			obj.put("result", "SUCCESS");
		}

    	return obj;
    }

    public String getChkAppointedPersonEndDate(List<EgovMap> appointedPersonChkList , int i,String userId,Date dateTo,Date sttsEndDtOver) throws Exception{
		String msg = "";
		Date sttsEndDt = sttsEndDtOver==null?(Date)appointedPersonChkList.get(i).get("sttsEndDt"):sttsEndDtOver;

		if( (dateTo.compareTo(sttsEndDt))==0 ||
				sttsEndDt.after(dateTo) ) {
			SimpleDateFormat sdf = new SimpleDateFormat("MM월dd일");
			      msg = sdf.format(sttsEndDt);
			      return msg;
		}else{
			if(i+1<appointedPersonChkList.size()){
				Date sttsEndDtBuf = (Date)appointedPersonChkList.get(i+1).get("sttsEndDt");
				Date sttsStartBuf = (Date)appointedPersonChkList.get(i+1).get("sttsFromDt");
				int dateCompareTo = DateUtil.getDiffDayCountTwoDate(sttsEndDt,sttsStartBuf); //이전 직원상태 끝날과 다음 직원상태의 시작일의 차이
				if(dateCompareTo  <= 1) { //다음 직원 상태의 일정이 연속으로 이어지면
					if(sttsEndDtBuf.compareTo(sttsEndDt)!=-1){
						msg=getChkAppointedPersonEndDate(appointedPersonChkList,i+1,userId,dateTo,null);
					}else{ // 다음 직원상태의 끝날짜가 이전 상태의 끝날짜보다 이전이면 종료일을 이전 직원상태의 종료일로 간주하기 위해 종료일일 파라미터로 넘김
						msg=getChkAppointedPersonEndDate(appointedPersonChkList,i+1,userId,dateTo,sttsEndDt);
					}
				}
			}
		}
		return msg;
	}

    //결재할 문서 cnt....
    public Integer getReqDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
    	return approveDao.getReqDocListTotalCnt(paramMap);
    }
    //참조문서 cnt....
    public Integer getRefDocListTotalCnt(Map<String,Object> paramMap) throws Exception{
    	return approveDao.getRefDocListTotalCnt(paramMap);
    }

    //경조사 코드관리 페이지의 리스트를 조회한다
    public List<Map> getEventCodeList(Map<String,Object> map) throws Exception{
    	return approveDao.getEventCodeList(map);
    }
    //경조사 기준정보 insert : return 0 일경우 이미등록된 경조사분류
    public Integer insertEventInfo(Map<String,Object> map) throws Exception{
    	Integer cnt = approveDao.getChkEventInfoCount(map);
    	if(cnt > 0) return 0;

    	cnt = approveDao.insertEventInfo(map);
    	return 1;
    }
    //경조사 기준정보 update
    public Integer updateEventInfo(Map<String,Object> map) throws Exception{
    	return approveDao.updateEventInfo(map);
    }
    //경조사 기준정보 delete
    public Integer deleteEventInfo(Map<String,Object> map) throws Exception{
    	return approveDao.deleteEventInfo(map);
    }

    //휴가 완료때 이력저장 , 연차정보 수정을 위한 공통로직1
    public void processUserHoliSumInfo1(Map<String,Object> paramMap) throws Exception{
    	EgovMap detailMap = new EgovMap();
		detailMap = approveDao.getApproveDocDetail(paramMap);

		/*Map<String,Object> searchMap = new HashMap<String, Object>();
		//연차정보 :이력저장 , 연차업데이트를 위한 기초데이터
		searchMap.put("orgId", detailMap.get("orgId"));
		searchMap.put("userId", detailMap.get("userId"));
		searchMap.put("sessionUserId", paramMap.get("userId"));
		searchMap.put("holidayCode",  detailMap.get("appvDocType"));
		searchMap.put("memo",  detailMap.get("memo"));
		searchMap.put("cancelYn", "N");
		searchMap.put("docStatus", paramMap.get("docStatus"));

		String vacType = detailMap.get("allHalf").toString();
		//반차일때..
		if(!vacType.equals("ALL")){
			searchMap.put("halfYn", "Y");		//반차여부

			searchMap.put("dateFrom", detailMap.get("dateFrom"));
    		searchMap.put("dateTo", detailMap.get("dateTo"));

			String dateFrom = detailMap.get("dateFrom").toString();
			String year = dateFrom.substring(0, dateFrom.indexOf("-"));

			searchMap.put("year", year);
			//연차정보를 조회한다.
    		EgovMap userHolidaySumMap = approveDao.getUserHolidaySum(searchMap);

    		//연차이력 저장 / 연차정보 수정
    		this.processUserHoliSumInfo2(userHolidaySumMap, searchMap);

		}else{	//종일휴가일때
			searchMap.put("halfYn", "N");			//반차여부 N

			//시작 년도 셋팅
			String dateFromStr = detailMap.get("dateFrom").toString();
			String fromYear = dateFromStr.substring(0, dateFromStr.indexOf("-"));

			//종료 년도 셋팅
			String dateToStr = detailMap.get("dateTo").toString();
			String toYear = dateToStr.substring(0, dateToStr.indexOf("-"));

			//연도가 넘어갈때..
			if(!fromYear.equals(toYear)){
				Date dateFrom = getDate(detailMap.get("dateFrom").toString(),"yyyy-MM-dd");
				Date dateTo = getDate(fromYear+"-12-31","yyyy-MM-dd");						//마지막 일자를 12월 31일로..

				searchMap.put("year", fromYear);
				searchMap.put("dateFrom", dateFrom);
				searchMap.put("dateTo", dateTo);
				//연차정보를 조회한다.
        		EgovMap userHolidaySumMap = approveDao.getUserHolidaySum(searchMap);

				//연차이력 저장 / 연차정보 수정
        		this.processUserHoliSumInfo2(userHolidaySumMap, searchMap);

        		dateFrom =getDate(toYear+"-01-01","yyyy-MM-dd");
        		dateTo =getDate(detailMap.get("dateTo").toString(),"yyyy-MM-dd");

        		searchMap.put("year", toYear);

        		searchMap.put("dateFrom", dateFrom);
				searchMap.put("dateTo", dateTo);
				//연차정보를 조회한다.
        		EgovMap userHolidaySumMap2 = approveDao.getUserHolidaySum(searchMap);

				//연차이력 저장 / 연차정보 수정
        		this.processUserHoliSumInfo2(userHolidaySumMap2, searchMap);

        	//같은연도일때
			}else{
				Date dateFrom = getDate(detailMap.get("dateFrom").toString(),"yyyy-MM-dd");
				Date dateTo = getDate(detailMap.get("dateTo").toString(),"yyyy-MM-dd");

				searchMap.put("year", fromYear);
				searchMap.put("dateFrom", dateFrom);
				searchMap.put("dateTo", dateTo);
				//연차정보를 조회한다.
        		EgovMap userHolidaySumMap = approveDao.getUserHolidaySum(searchMap);

				//연차이력 저장 / 연차정보 수정
        		this.processUserHoliSumInfo2(userHolidaySumMap, searchMap);
			}

		}*/

		String appvDocType = detailMap.get("appvDocType").toString();

		if(appvDocType.equals("SICK")){
			Map<String,Object> procUserStatusMap = new HashMap<String, Object>();

			procUserStatusMap.put("userId", detailMap.get("userId"));
			procUserStatusMap.put("userStatus", "H");
			procUserStatusMap.put("sttsFromDt", detailMap.get("dateFrom"));
			procUserStatusMap.put("sttsEndDt", detailMap.get("dateTo"));
			procUserStatusMap.put("memo", detailMap.get("memo"));
			procUserStatusMap.put("sessionUserId", paramMap.get("userId"));
			procUserStatusMap.put("userLoginId", paramMap.get("loginId"));
			procUserStatusMap.put("appvDocId", paramMap.get("appvDocId"));

			managementDAO.insertUserSttsHist(procUserStatusMap);

			managementDAO.updateUserStatus(procUserStatusMap);

		}


    }

    //휴가 완료때 이력저장 , 연차정보 수정을 위한 공통로직2
    /*public void processUserHoliSumInfo2(EgovMap userHolidaySumMap,Map<String,Object> searchMap) throws Exception{
    	Double diffDay = 0.0;
    	Double useDay = Double.parseDouble(userHolidaySumMap.get("usedDay").toString());
		Integer leaveDay = Integer.parseInt(userHolidaySumMap.get("leaveDay").toString());
		String halfYn = searchMap.get("halfYn").toString();
		if(!halfYn.equals("N")){
			diffDay = 0.5;
			searchMap.put("diffDay", diffDay);	//사용휴가일수
		}else{
			//Date dateFrom = getDate(searchMap.get("dateFrom").toString(),"yyyy-MM-dd");
			//Date dateTo = getDate(searchMap.get("dateTo").toString(),"yyyy-MM-dd");
			diffDay = Double.parseDouble( String.valueOf(getDiffDayCountTwoDate((Date)searchMap.get("dateFrom"),(Date)searchMap.get("dateTo"))));
			diffDay=diffDay+1;
			searchMap.put("diffDay", diffDay);	//사용휴가일수
		}

		String upDocStatus = searchMap.get("docStatus").toString();	//상태값

		//승인완료
		if(!upDocStatus.equals("CNL_COMMIT")){
			Double chkOverDay = leaveDay-useDay-diffDay;	//초과여부를 판단한다
			if(chkOverDay<0) {								//초과라면
				searchMap.put("overUsedDay", chkOverDay*-1);	//초과일수셋팅
				searchMap.put("overUseYn", "Y");				//초과여부
			}else{												//초과하지않았다면
				searchMap.put("overUseYn", "N");				//초과여부
			}
		//취소완료
		}else{
			searchMap.put("overUseYn", "N");				//초과여부
			searchMap.put("diffDay", diffDay*-1);			//사용휴가차감(취소)
		}

		//연차정보수정
		approveDao.updateUserHoliSum(searchMap);
		//연차이력저장
		approveDao.insertUserHoliSumHist(searchMap);

    }*/

    //승인 취소시 휴가 완료때 이력저장 , 연차정보 수정을 위한 공통로직1
    public void processCancelUserHoliSum(Map<String,Object> paramMap) throws Exception{
    	EgovMap detailMap = new EgovMap();
		detailMap = approveDao.getApproveDocDetail(paramMap);

		/*Map<String,Object> searchMap = new HashMap<String, Object>();
		//연차정보 :이력저장 , 연차업데이트를 위한 기초데이터
		searchMap.put("orgId", detailMap.get("orgId"));
		searchMap.put("userId", detailMap.get("userId"));
		searchMap.put("sessionUserId", paramMap.get("userId"));
		searchMap.put("holidayCode",  detailMap.get("appvDocType"));
		searchMap.put("memo",  "승인 취소");
		searchMap.put("cancelYn", "N");
		searchMap.put("docStatus", paramMap.get("docStatus"));

		String vacType = detailMap.get("allHalf").toString();
		//반차일때..
		if(!vacType.equals("ALL")){
			searchMap.put("halfYn", "Y");		//반차여부

			searchMap.put("dateFrom", detailMap.get("dateFrom"));
    		searchMap.put("dateTo", detailMap.get("dateTo"));

			String dateFrom = detailMap.get("dateFrom").toString();
			String year = dateFrom.substring(0, dateFrom.indexOf("-"));

			searchMap.put("year", year);
			//연차정보를 조회한다.
    		EgovMap userHolidaySumMap = approveDao.getUserHolidaySum(searchMap);

    		//연차이력 저장 / 연차정보 수정
    		this.processUserHoliSumInfo2(userHolidaySumMap, searchMap);

		}else{	//종일휴가일때
			searchMap.put("halfYn", "N");			//반차여부 N

			//시작 년도 셋팅
			String dateFromStr = detailMap.get("dateFrom").toString();
			String fromYear = dateFromStr.substring(0, dateFromStr.indexOf("-"));

			//종료 년도 셋팅
			String dateToStr = detailMap.get("dateTo").toString();
			String toYear = dateToStr.substring(0, dateToStr.indexOf("-"));

			//연도가 넘어갈때..
			if(!fromYear.equals(toYear)){
				Date dateFrom = getDate(detailMap.get("dateFrom").toString(),"yyyy-MM-dd");
				Date dateTo = getDate(fromYear+"-12-31","yyyy-MM-dd");						//마지막 일자를 12월 31일로..

				searchMap.put("year", fromYear);
				searchMap.put("dateFrom", dateFrom);
				searchMap.put("dateTo", dateTo);
				//연차정보를 조회한다.
        		EgovMap userHolidaySumMap = approveDao.getUserHolidaySum(searchMap);

				//연차이력 저장 / 연차정보 수정
        		this.processUserHoliSumInfo2(userHolidaySumMap, searchMap);

        		dateFrom =getDate(toYear+"-01-01","yyyy-MM-dd");
        		dateTo =getDate(detailMap.get("dateTo").toString(),"yyyy-MM-dd");

        		searchMap.put("year", toYear);

        		searchMap.put("dateFrom", dateFrom);
				searchMap.put("dateTo", dateTo);
				//연차정보를 조회한다.
        		EgovMap userHolidaySumMap2 = approveDao.getUserHolidaySum(searchMap);

				//연차이력 저장 / 연차정보 수정
        		this.processUserHoliSumInfo2(userHolidaySumMap2, searchMap);

        	//같은연도일때
			}else{
				Date dateFrom = getDate(detailMap.get("dateFrom").toString(),"yyyy-MM-dd");
				Date dateTo = getDate(detailMap.get("dateTo").toString(),"yyyy-MM-dd");

				searchMap.put("year", fromYear);
				searchMap.put("dateFrom", dateFrom);
				searchMap.put("dateTo", dateTo);
				//연차정보를 조회한다.
        		EgovMap userHolidaySumMap = approveDao.getUserHolidaySum(searchMap);

				//연차이력 저장 / 연차정보 수정
        		this.processUserHoliSumInfo2(userHolidaySumMap, searchMap);
			}

		}*/

		String appvDocType = detailMap.get("appvDocType").toString();

		if(appvDocType.equals("SICK")){
			Map<String,Object> procUserStatusMap = new HashMap<String, Object>();

			procUserStatusMap.put("userId", detailMap.get("userId"));
			procUserStatusMap.put("userStatus", "H");
			procUserStatusMap.put("sttsFromDt", detailMap.get("dateFrom"));
			procUserStatusMap.put("sttsEndDt", detailMap.get("dateTo"));
			procUserStatusMap.put("sessionUserId", paramMap.get("userId"));
			procUserStatusMap.put("userLoginId", paramMap.get("loginId"));
			procUserStatusMap.put("appvDocId", paramMap.get("appvDocId"));

			managementDAO.deleteUserSttsHist(procUserStatusMap);

			//뱅가나 휴가인 유저를 재직으로 업데이트한다.
			managementDAO.updateUserStatusBeforeBatch();

			managementDAO.updateUserStatus(procUserStatusMap);

		}


    }

    //품의서 취소승인권한
  	public Integer getCancelRoleCnt(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getCancelRoleCnt(paramMap);
  	}

    //품의서 문서번호 리스트
  	public List<EgovMap> approveDocNumList(Map<String,Object> paramMap) throws Exception{
  		return approveDao.approveDocNumList(paramMap);
  	}
  	//품의서 문서번호 저장
    public Integer processAppvDocNumRule(Map<String,Object> map) throws Exception{
    	int cnt = 0;

    	//orgId : 문서번호 삭제
    	approveDao.deleteAppvDocNumRule(map);

    	String keyChk = "";
    	Map<String,Object> insertMap = new HashMap<String,Object>();
    	insertMap.put("applyOrgId", map.get("applyOrgId"));
		insertMap.put("userId", map.get("userId"));
    	for(String key : map.keySet()){

    		if(key.indexOf("|")<0) continue;

    		String[] keyBuf = key.split("[|]");

    		if(keyChk.equals("")) keyChk = keyBuf[1];

    		if(!keyChk.equals(keyBuf[1])){
    			keyChk = keyBuf[1];
        		approveDao.insertAppvDocNumRule(insertMap);

        		//초기화
        		insertMap = new HashMap<String,Object>();
            	insertMap.put("applyOrgId", map.get("applyOrgId"));
        		insertMap.put("userId", map.get("userId"));
    		}
    		insertMap.put("appvDocClass", keyBuf[2]);
    		insertMap.put("appvDocType", keyBuf[1]);
    		insertMap.put(keyBuf[0], map.get(key));
		 }
    	approveDao.insertAppvDocNumRule(insertMap);
    	return cnt;
    }
    //품의서 수신확인
    public Integer processAppvRc(Map<String,Object> map) throws Exception{
    	Integer cnt = 0;
    	Integer chkCnt = approveDao.getAppvRcChkCnt(map);

    	if(chkCnt>0){
    		cnt = -1;
    	}else{
    		cnt = approveDao.updateAppvRcReceipt(map);
    	}
    	return cnt;
    }
    //결재라인명 리스트 조회
  	public List<EgovMap> getAppvHeaderList(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getAppvHeaderList(paramMap);
  	}
    //보고서 - 일정 선택 팝업
  	public List<EgovMap> getAppvScheduleList(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getAppvScheduleList(paramMap);
  	}
  	//결재순서 목록조회
  	public List<Map> selectApproveLineListIndividual(Map<String, Object> map) throws Exception{
  		return approveDao.selectApproveLineListIndividual(map);
  	}
  	// 읽음 처리 (참조문서)
  	public int updateReadUserIdList(Map<String, Object> map) throws Exception{
  		String chkContentId = map.get("chkContentId").toString();
  		chkContentId = chkContentId.replaceAll("\"", "");
  		chkContentId = chkContentId.replaceAll("\\[", "");
  		chkContentId = chkContentId.replaceAll("\\]", "");
  		String[] chkContentIdArr = chkContentId.split(",");
  		int cnt = 0;
  		for(int i = 0 ; i < chkContentIdArr.length;i++){
  			map.put("appvDocId", chkContentIdArr[i]);
  			approveDao.updateAppvCcReadDate(map);
  		}

  		return cnt;
  	}
  	//상신하려는 문서의 문서번호 사용여부를 조회한다
  	public String appvDocNumUseChk(Map<String, Object> map) throws Exception{
  		String returnStr = "N";

  		Integer chkCnt = approveDao.appvDocNumUseChk(map);

  		if(chkCnt!=null&&chkCnt>0) returnStr="Y";
  		return returnStr;
  	}
  	//다음 결재도 같은사람인지 체크
  	public Integer getChkDupAppvReqUserCnt(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getChkDupAppvReqUserCnt(paramMap);
  	}

  	////////////////////////////////////////////////////////////////////////////////////////////////////
  	//전체문서 List
    public List<EgovMap> getAppvDocList(Map<String,Object> paramMap) throws Exception{

    	/*Integer totCnt =0;

        totCnt = approveDao.getDraftDocListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getDraftDocList(paramMap);*/

        Integer totCnt =0;

        totCnt = approveDao.getAppvDocListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getAppvDocList(paramMap);
    }
	//사내서식 저장
  	public Integer insertApproveCompanyForm(Map<String,Object> paramMap) throws Exception{
  		return approveDao.insertApproveCompanyForm(paramMap);
  	}
  	//사내서식 수정
  	public Integer updateApproveCompanyForm(Map<String,Object> paramMap) throws Exception{
  		//사내서식 수정 전 결재라인이 있다면 문서타입을 업데이트한다
  		approveDao.updateApproveLineForCompanyForm(paramMap);

  		return approveDao.updateApproveCompanyForm(paramMap);
  	}
  	//사내서식 삭제
  	public Integer deleteApproveCompanyForm(Map<String,Object> paramMap) throws Exception{
  		return approveDao.deleteApproveCompanyForm(paramMap);
  	}
  	//사내서식 구분 유효성 체크
  	public Integer getAppvDocNumRuleMidNameCnt(Map<String, Object> map) throws Exception{
  		return approveDao.getAppvDocNumRuleMidNameCnt(map);
  	}
  	//사내서식 List
  	public List<EgovMap> getCompanyFormList(Map<String,Object> paramMap) throws Exception{
  		Integer totCnt =0;

        totCnt = approveDao.getCompanyFormListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

        return approveDao.getCompanyFormList(paramMap);
  	}
  	//사내서식 폼 상세
  	public EgovMap getCompanyFormInfo(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getCompanyFormInfo(paramMap);
  	}
  	//연결 결재문서 List
  	public List<EgovMap> getApproveRefDocList(Map<String,Object> paramMap) throws Exception{
  		Integer totCnt =0;

        totCnt = approveDao.getApproveRefDocListTotalCnt(paramMap);

        paramMap.put("totCnt", totCnt);
  		return approveDao.getApproveRefDocList(paramMap);
  	}

  	//종결전 문서열람 정보를 조회
  	public EgovMap getAppvReadDocSetup(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getAppvReadDocSetup(paramMap);
  	}
  	//서식 즐겨찾기 프로세스
  	public Integer processAppvFavListAjax(Map<String,Object> paramMap) throws Exception{
  		String favStr = paramMap.get("favStr").toString();

  		String[] appvClassBuf = favStr.split("[|]");

  		String appvClass = appvClassBuf[0];
  		paramMap.put("appvDocClass", appvClass);

  		if(appvClass.equals("COMPANY")){
  			paramMap.put("appvCompanyId", appvClassBuf[1]);
  			paramMap.put("bookmarkType", appvClass);
  			paramMap.put("appvDocClass", null);
  		}else if(appvClass.equals("APPROVE")){
  			paramMap.put("appvDocId", appvClassBuf[1]);
  			paramMap.put("bookmarkType", appvClass);
  			paramMap.put("appvDocClass", null);
  		}else{
  			paramMap.put("bookmarkType", "BASIC");

  			if(appvClassBuf.length>2){
  				String appvDocClass =appvClassBuf[2];
  				if(!appvDocClass.equals(""))
  					paramMap.put("appvDocClass", appvClassBuf[2]);
  			}
  			if(appvClassBuf.length>3){
  				String appvDocId = appvClassBuf[3];

  				if(!appvDocId.equals("")&&!appvDocId.equals("0")){
  					paramMap.put("bookmarkType", "APPROVE");
  					paramMap.put("appvDocClass", "");
  					paramMap.put("appvDocId", appvDocId);
  				}
  			}
  		}
  		Integer cnt = 0;

  		String proc = paramMap.get("proc").toString();

  		if(proc.equals("inert")){
  			cnt = approveDao.insertAppvFavList(paramMap);
  		}else if(proc.equals("delete")){
  			cnt = approveDao.deleteAppvFavList(paramMap);
  		}
  		return cnt;
  	}

  	//즐겨찾기 서식 리스트
  	public List<EgovMap> getAppvFavListAjax(Map<String,Object> paramMap) throws Exception{
  		for(String key : paramMap.keySet()){
            if(paramMap.get(key).toString().equals("")) paramMap.put(key,null);
        }
  		return approveDao.getAppvFavListAjax(paramMap);
  	}
  	//사내서식 user열람 정보를 저장
  	public Integer updateCompanyFormReadUserId(Map<String,Object> paramMap) throws Exception{
  		return approveDao.updateCompanyFormReadUserId(paramMap);
  	}
  	//즐겨찾기 서식 리스트
  	public List<EgovMap> getApproveBookmarkFormList(Map<String,Object> paramMap) throws Exception{
  		Integer totCnt =0;

        totCnt = approveDao.getApproveBookmarkFormListTotalCnt(paramMap);
        paramMap.put("totCnt", totCnt);

  		return approveDao.getApproveBookmarkFormList(paramMap);
  	}

  	//My업무구분에서 전자결재 SELECT박스 즐겨찾기 조회
  	public List<EgovMap> getApproveBookmarkFormListForMyWorkList(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getApproveBookmarkFormListForMyWorkList(paramMap);
  	}
  	//지출결의서 지급처리
  	public Integer processExpenseYn(Map<String,Object> paramMap) throws Exception{
  		return approveDao.processExpenseYn(paramMap);
  	}
  	//결재품의서 내영 수정
  	public Integer doSaveAppvInfoUpdate(Map<String,Object> paramMap,List<Map<String , Object>> fileList,String[] delFileList) throws Exception{

   		String updateType = paramMap.get("updateType").toString();
   		Integer cnt = 0;

   		String comment = "";

  		if(updateType.equals("CONTENTS")){

  			comment = "*내용변경*\\n";
   			approveDao.updateAppvMemoInfo(paramMap);
  		}else if(updateType.equals("FILE")){
  			comment = "*파일변경*\\n";
  	        paramMap.put("usrSeq", paramMap.get("userId"));


  	        if(delFileList!=null){		//정상저장 이고 파일이 있을때
  	        	Map<String,Object> deleteFileMap = new HashMap<String, Object>();
  	        	deleteFileMap.put("fileArr", delFileList);
  				fileService.updateDelFlag(deleteFileMap);						//파일 db저장 된거 삭제
  			}

  	        paramMap.put("uploadId", paramMap.get("appvDocId").toString());

  	        if(fileList.size()>0){//공통처리로직
  	            Map<String,Object> items = new HashMap<String, Object>();
  	            items.put("items", fileList);
  	            //Json 스트링 변환
  	            ObjectMapper mapper = new ObjectMapper();
  	            String param = mapper.writeValueAsString(items);
  	            paramMap.put("fileList", param);

  	            fileService.insertFileListJson(paramMap);                //파일 db저장
  	        }
  		}else if(updateType.equals("CC")){
  			comment = "*참조인변경*\\n";

  			cnt = approveDao.updateApproveCcType(paramMap);
  			cnt = approveDao.deleteApproveCc(paramMap);
  	        String approveCcType = paramMap.get("approveCcType").toString();
  	        if(!approveCcType.equals("NONE")){
  	            cnt = approveDao.insertApproveCc(paramMap);
  	        }

  	        /*
  	         *
  	         * 필수 참가자 저장
  	         *
  	        */
  	        cnt=approveDao.insertApproveCcSetup(paramMap);



  		}else if(updateType.equals("RECEIVER")){
  			comment = "*수신인변경*\\n";
  			cnt = approveDao.updateApproveRcType(paramMap);
  			cnt = approveDao.deleteApproveRc(paramMap);
   	        String approveRcType = paramMap.get("approveRcType").toString();
   	        if(!approveRcType.equals("NONE")){
   	            cnt = approveDao.insertApproveRc(paramMap);
   	        }

   	        /*
  	         *
  	         * 필수 수신자 저장
  	         *
  	        */
  	        cnt=approveDao.insertApproveReceiverSetup(paramMap);
  		}else if(updateType.equals("AMOUNT")){
  			comment = "*경조금액변경*\\n";
  			cnt=approveDao.modifyAprvEventAmount(paramMap);

  		}
  		String updateComment = comment+paramMap.get("updateComment");

  		paramMap.put("updateComment", updateComment);

  		cnt = approveDao.insertUpdateAppvComment(paramMap);
  		return cnt;
  	}

  	//중복 문서타입 카운트
  	public Integer getAppvDocTypeNameCnt(Map<String,Object> paramMap) throws Exception{
  		return  approveDao.getAppvDocTypeNameCnt(paramMap);
  	}
  	//지출문서총개수
  	public Integer getAppvDocExpenseListTotalCnt(Map<String,Object> paramMap) throws Exception{
  		return  approveDao.getAppvDocExpenseListTotalCnt(paramMap);
  	}

	////////////////////////////////좌측메뉴 새글알림///////////////////////////////
	//사내서식 조회
	public Integer getMenuApproveCompanyCnt(Map<String,Object> paramMap) throws Exception{
		return approveDao.getMenuApproveCompanyCnt(paramMap);
	}
	//임시저장 new 조회
  	public Integer getMenuMenuApproveTemp(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getMenuMenuApproveTemp(paramMap);
  	}
  	//받은결재 new
  	public Integer getMenuApproveReqList(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getMenuApproveReqList(paramMap);
  	}
  	//참조문서 new
  	public Integer getMenuApproveReference(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getMenuApproveReference(paramMap);
  	}
  	//수신문서 new
  	public Integer getMenuApproveReceived(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getMenuApproveReceived(paramMap);
  	}
  	//지출문서 NEW
  	public Integer getMenuApproveExpense(Map<String,Object> paramMap) throws Exception{
  		return approveDao.getMenuApproveExpense(paramMap);
  	}




	///////////////////////////////////////////전자결재 배치 url : S///////////////////////////////////////////////////////
	//전자결재 미결알람 보내기
	public List<EgovMap> getSendAppvAlarmList(Map<String,Object> paramMap) throws Exception{
		return approveDao.getSendAppvAlarmList(paramMap);
	}

	//전자결재 미결알람 보내기 개수
	public  Integer getSendAppvAlarmListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return approveDao.getSendAppvAlarmListTotalCnt(paramMap);
	}
	///////////////////////////////////////////전자결재 배치 url : E///////////////////////////////////////////////////////
	public void sendSms(String type , Map<String,Object > paramMap){
		try{
			List<EgovMap> sendAppvAlarmList = new ArrayList<EgovMap>();
			if(type.equals("NEXT")){
				sendAppvAlarmList = approveDao.getApproveImApproveAlarmList(paramMap);

			}else if(type.equals("COMMIT")){
				sendAppvAlarmList = approveDao.getApproveImCommitAlarmList(paramMap);
			}

			String userId = "";

			String content = "";

			for(EgovMap detailMap : sendAppvAlarmList){
				String userIdDt = detailMap.get("userId").toString();
				if(!userId.equals(userIdDt)){
					if(!userId.equals("")){
						//sms 보내기
						this.approveSendSms(content,userId);

						content=this.makeSmsMsg(detailMap);
					}else{
						content=this.makeSmsMsg(detailMap);
					}

					userId = userIdDt;
				}else{
					content = content+"<p><p>"+this.makeSmsMsg(detailMap);
				}
			}

			if(sendAppvAlarmList!=null&&sendAppvAlarmList.size()>0){
				//sms 보내기
				this.approveSendSms(content,userId);
			}
		}catch(Exception e){
			e.printStackTrace();
			log.info("미결알림 sms 전송 도중 오류.......");
		}
	}

	//전자결재 배치 SMS 내용을 만드는 메서드
	public String makeSmsMsg(EgovMap detailMap) throws Exception{

		String targetDateStr = detailMap.get("targetDateStr").toString();

		String type = detailMap.get("type").toString();

		String returnStr = "전자결재에 ";

		//미결
		if(type.equals("APPROVE")||type.equals("AGREE")){
		returnStr += "승인대기중인 문서가 있습니다.";
		returnStr += "<p> -상신일 : " + detailMap.get("submitDateStr").toString();
		//수신인
		}else if(type.equals("RECEIVE")){
		returnStr += "수신인 대기중인 문서가 있습니다.";
		returnStr += "<p> -종결일 : " + targetDateStr;
		}else if(type.equals("FINANCE")){
		returnStr += "지출확인 대기중인 문서가 있습니다.";
		returnStr += "<p> -종결일 : " + targetDateStr;
		}

		return returnStr;
	}
	//전자결재 배치에서 sms보내는 메서드
	public void approveSendSms(String comment,String selectUserId) throws Exception{

		// 01047115394로만 보냄 지울것!!!!! 테스트할때 본인 유저넘버로하세요~
		//if(!selectUserId.equals("383")) return;

		Map<String,Object> param = new HashMap<String, Object>();
		//SMS 전송용 현재시간
		Date from = new Date();
		SimpleDateFormat transFormatNow = new SimpleDateFormat("yyyyMMddHHmmss");
		String strNowDate = transFormatNow.format(from);

		param.put("smsTitle", "");
		param.put("sendUserId", selectUserId);
		param.put("recieveUserId",param.get("selectUserId"));
		param.put("recieveCustomerId", null);
		param.put("content", comment);
		param.put("reserveDate", strNowDate);
		param.put("userId", selectUserId);
		param.put("userIdList", selectUserId);
		param.put("customerList", "");
		param.put("type", "");

		smsService.insertSmsLog(param);
	}
}
