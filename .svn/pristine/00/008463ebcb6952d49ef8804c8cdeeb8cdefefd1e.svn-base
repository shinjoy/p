package ib.business.service.impl;

import ib.business.service.BusinessService;
import ib.file.service.FileService;
import ib.file.service.impl.FileDAO;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("businessService")
public class BusinessServiceImpl implements BusinessService{

	@Resource(name="businessDAO")
	private BusinessDAO businessDAO;

	@Resource(name="fileDAO")
	private FileDAO fileDAO;

	@Resource(name = "fileService")
	private FileService fileService;

	protected static final Log logger = LogFactory.getLog(BusinessServiceImpl.class);

	//경로 코드셋
	private static final String PATH_CODE_SET = "INFO_PATH";
	//구분 코드셋
	private static final String TYPE_CODE_SET = "INFO_TYPE";
	//유형 코드셋
	private static final String CLASS_CODE_SET = "INFO_CLASS";
	//진행상태 코드셋
	private static final String PROGRESS_CODE_SET = "INFO_PROGRESS";
	//파일 업로드 타입 (정보등록)
	private static final String UPLOAD_TYPE_LIST = "INFO_FILE";

	//정보공유 세팅 정보 반환 (org_id로 검색)
	public Map selectBusinessBsInfoSetupInfo(Map param) throws Exception{
		return businessDAO.selectBsInfoSetupInfo(param);
	}

	//코드 셋 정보 반환(org_id  & code_set_name)
	public Map businessSelectCodeSet(Map param) throws Exception{
		return businessDAO.businessSelectCodeSet(param);
	}


	//모든 정보 분류에 해당하는 코드 리스트 반환. ( 구분에 해당하는 지정값이 있는 경우 : conditionMap)
	public Map selectCodeListAll(Map param, Map conditionMap) throws Exception{
		Map resultMap = new HashMap<String,Object>();

		//경로 코드 리스트 반환.
		Map pathMap = param;
		pathMap.put("codeSetName", PATH_CODE_SET);
		pathMap.put("delFlag", "N");
		pathMap.put("orgId", param.get("applyOrgId"));
		pathMap = businessDAO.businessSelectCodeSet(pathMap);
		if(pathMap != null){
			pathMap.put("delFlag", "N");
			List<Map> pathCodeList = businessDAO.selectCodeList(pathMap);
			if(pathCodeList != null && pathCodeList.size() > 0)
				resultMap.put("pathCodeList", pathCodeList);
		}


		//구분 코드 리스트 반환.
		Map typeMap = param;
		typeMap.put("codeSetName", TYPE_CODE_SET);
		typeMap.put("delFlag", "N");
		typeMap.put("orgId", param.get("applyOrgId"));
		typeMap = businessDAO.businessSelectCodeSet(typeMap);
		if(typeMap != null){
			typeMap.put("delFlag", "N");
			List<Map> typeCodeList = businessDAO.selectCodeList(typeMap);
			if(typeCodeList != null && typeCodeList.size() > 0)
				resultMap.put("typeCodeList", typeCodeList);
		}


		//유형 코드 리스트 반환
		if(typeMap !=null){
			List<Map> classCodeList =  selectCodeApplyClassList(typeMap, conditionMap);
			if(classCodeList != null && classCodeList.size() > 0)
				resultMap.put("classCodeList", classCodeList);
		}
		//진행 상태 코드 리스트 반환.
		Map progressMap = param;
		progressMap.put("codeSetName", PROGRESS_CODE_SET);
		progressMap.put("delFlag", "N");
		progressMap.put("orgId", param.get("applyOrgId"));
		progressMap = businessDAO.businessSelectCodeSet(progressMap);
		if(progressMap != null){
			progressMap.put("delFlag", "N");
			List<Map> progressCodeList =businessDAO.selectCodeList(progressMap);
			if(progressCodeList != null && progressCodeList.size() > 0)
				resultMap.put("progressCodeList", progressCodeList);
		}


		return resultMap;
	}


	//정보 분류 - 경로,구분 코드에 해당하는 코드 리스트 반환 (codeSetId로 검색)
	public List<Map> selectCodeList(Map param) throws Exception{
		logger.debug("########## businessService.selectCodeList ########## param : ["+ param+ "]######");
		return businessDAO.selectCodeList(param);
	}

	//업무일지 - 정보공유 리스트 반환
	public List<Map> selectBsInfoListForWork(Map param){

		List<Map> list =  businessDAO.selectBsInfoListForWork(param);
		/*for(Map map : list){
			if(map.get("sonSetId")  != null){
				Map codeMap = new HashMap();
				codeMap.put("codeSetId", map.get("sonSetId"));
				codeMap.put("value", map.get("infoClass"));
				if(!map.get("infoClass").equals("")){
					List<Map> codeList = businessDAO.selectCodeList(codeMap);

					if(codeList != null && codeList.size() > 0){
						map.put("codeList", codeList.get(0));
					}
				}

			}
		}*/
		return list;
	}

	//정보 분류 - 유형에 저장된 리스트 반환.
	public List<Map> selectCodeApplyClassList(Map<String, Object> map,  Map conditionMap) throws Exception{
		logger.debug("########## businessService.selectCodeApplyClassList ########## param : [ 조건 : " + conditionMap +","+ map+ "]######");
		Map typeMap = map;
		typeMap.put("codeSetName", TYPE_CODE_SET);
		typeMap = businessDAO.businessSelectCodeSet(typeMap);
		List<Map> typeCodeList =  businessDAO.selectCodeList(typeMap);
		List<Map> typeCodeFinalList = new ArrayList<Map>();
		for(Map param :typeCodeList){
			if(conditionMap != null){ // 조건이 있는 경우 (선택된 구분값이 존재하는 경우 : 해당 구분과 그 아래 유형 리스트만 반환)
				if(param.get("value").equals(conditionMap.get("infoType"))){
					String sonSetId = String.valueOf(param.get("sonSetId"));
					if(!StringUtils.isEmpty(sonSetId) && !StringUtils.equals("0", sonSetId)){
						//유형에 해당하는 리스트가 있는 경우.
						Map codeMap = new HashMap();
						codeMap.put("codeSetId", param.get("sonSetId"));
						codeMap.put("orgId", map.get("applyOrgId"));
						List<Map> codeList = businessDAO.selectCodeList(codeMap);
						param.put("codeList", codeList);
					}
					typeCodeFinalList.add(param);
				}
			}else{ // 조건이 없는 경우 (모든 구분에 따른 모든 유형 리스트를 반환한다)
				String sonSetId = String.valueOf(param.get("sonSetId"));
				if(!StringUtils.isEmpty(sonSetId) && !StringUtils.equals("0", sonSetId)){
					//유형에 해당하는 리스트가 있는 경우.
					Map codeMap = new HashMap();
					codeMap.put("codeSetId", param.get("sonSetId"));
					codeMap.put("orgId", map.get("applyOrgId"));
					List<Map> codeList = businessDAO.selectCodeList(codeMap);
					param.put("codeList", codeList);
				}
				typeCodeFinalList.add(param);
			}
		}
		return typeCodeFinalList;
	}

	//정보등록관리 정보 저장 혹은 수정
	public void saveBusinessAdminRegist(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		logger.debug("########## businessService.saveBusinessAdminRegist ########## param : ["+ param+ "]######");

			String priceUnit1 = (String)param.get("priceUnit1");
			setMultiple(priceUnit1, "multiple1", param);
			String priceLabel2 = (String)param.get("priceLabel2");
			if(!StringUtils.isEmpty(priceLabel2)){
				setMultiple((String)param.get("priceUnit2"), "multiple2", param);
			}else{
				param.put("multiple2", 0);
				param.put("priceUnit2", null);
			}
			String priceLabel3 = (String)param.get("priceLabel3");
			if(!StringUtils.isEmpty(priceLabel3)){
				setMultiple((String)param.get("priceUnit3"), "multiple3", param);
			}else{
				param.put("multiple3", 0);
				param.put("priceUnit3", null);
			}

			param.put("pathCodeSet", PATH_CODE_SET);
			param.put("typeCodeSet", TYPE_CODE_SET);
			param.put("classCodeSet", CLASS_CODE_SET);
			param.put("progressCodeSet", PROGRESS_CODE_SET);
			businessDAO.insertBsInfoSetup(param);

	}

	//금액 정보 세팅
	private void setMultiple(String unit, String multiple, Map param){
		 if(StringUtils.equals("백만", unit)){
			 param.put(multiple, 10000000);
		}else if(StringUtils.equals("천만", unit)){
			param.put(multiple, 100000000);
		}else if(StringUtils.equals("억", unit)){
			param.put(multiple, 1000000000);
		}else if(StringUtils.equals("원", unit)){
			param.put(multiple, 1);
		}else if(StringUtils.equals("달러", unit)){
			param.put(multiple, 0);
		}
	}

	//코드팝업 - 코드등록 ( 공통코드에서 안보이기 위해 CODE_GROUP :  MASTER 값으로 저장됨)
	public void saveBusinessCodeReg(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		logger.debug("########## businessService.saveBusinessCodeReg ########## param : ["+ param+ "]######");
		//저장할 공통 코드 리스트
		JSONArray array = JSONArray.fromObject(param.get("pArray"));
		Iterator<String> iter = array.iterator();

		//경로 혹은 구분 혹은 진행상황 인 경우
		if(StringUtils.equals(PATH_CODE_SET, (String)param.get("codeType")) || StringUtils.equals(TYPE_CODE_SET, (String)param.get("codeType")) ||  StringUtils.equals(PROGRESS_CODE_SET, (String)param.get("codeType"))){

			while(iter.hasNext()){
				JSONObject obj = JSONObject.fromObject(iter.next());
				Map map = new HashMap<String,Object>();
				String codeListId = (String) obj.get("codeListId");
				if(StringUtils.isNotEmpty(codeListId) || StringUtils.equals("0",codeListId)){
					map.put("codeListId", codeListId);
				}
				map.put("codeSetId", param.get("codeSetId"));
				map.put("sort", obj.getString("sort"));
				map.put("userSeq", param.get("userSeq"));
				map.put("value", obj.getString("value"));
				map.put("meaningKor", obj.getString("meaningKor"));
				map.put("meaningEng", obj.getString("value"));
				map.put("delFlag", obj.getString("delFlag"));
				map.put("description", obj.getString("meaningKor"));
				map.put("sonSetId",obj.getString("sonSetId"));
				//구분의 경우 하위 코드들이 등록할 수 있도록 유형별 codeset을 만든다.
				if(StringUtils.equals(TYPE_CODE_SET, (String)param.get("codeType"))){
					if(StringUtils.isEmpty((String)map.get("sonSetId")) || StringUtils.equals("0",(String)map.get("sonSetId"))){
						//신규등록시에만 저장됨.
						Map codeSet = new HashMap();
						codeSet.put("orgId", param.get("orgId"));
						codeSet.put("userSeq", param.get("userSeq"));
						codeSet.put("codeSetName", CLASS_CODE_SET+"_"+ map.get("value"));
						codeSet.put("meaningKor", map.get("meaningKor"));
						codeSet.put("meaningEng", CLASS_CODE_SET+"_"+map.get("value"));
						codeSet.put("description", map.get("meaningKor"));
						codeSet.put("parentSetId", param.get("codeSetId"));
						businessDAO.insertCodeSet(codeSet);
						map.put("sonSetId",codeSet.get("codeSetId"));
					}
				}

				//같은 코드셋에 같은 value가 있는지 체크
				businessDAO.insertCodeList(map);
			}

		//유형인 경우
		}else if(StringUtils.equals("INFO_CLASS", (String)param.get("codeType"))){
			// 구분이 code_list에 저장이 된 경우 삭제한 경우 code_set에 저장한다.
			// 구분이 code_set에 이미 있는 경우 유형에 대해서 code_list 수정 처리를 한다.
			while(iter.hasNext()){
				JSONObject obj = JSONObject.fromObject(iter.next());
				Map map = new HashMap<String,Object>();
				String codeListId = (String) obj.get("codeListId");
				if(StringUtils.isNotEmpty(codeListId)  || StringUtils.equals("0",codeListId)){
					map.put("codeListId", codeListId);
				}
				map.put("codeSetId", obj.getString("codeSetId"));
				map.put("sort", obj.getString("sort"));
				map.put("userSeq", param.get("userSeq"));
				map.put("value", obj.getString("value"));
				map.put("meaningKor", obj.getString("meaningKor"));
				map.put("meaningEng", obj.getString("value"));
				map.put("delFlag", obj.getString("delFlag"));
				map.put("description", obj.getString("meaningKor"));
				map.put("sonSetId", 0);
				//저장 전 체크하기
				Map condition = new HashMap();
				businessDAO.insertCodeList(map);

			}
		}
	}

	//정보 등록 - 저장하기
	public void savebusinessInfoRegist(Map<String, Object> map) throws Exception {

		//정보 등록
		businessDAO.insertBsInfoList(map);

		//인물1의 정보가 있다면 등록
		if(map.containsKey("staff1IdStr")&&EgovStringUtil.isNotEmpty(map.get("staff1IdStr").toString())){
			String staff1IdStr = map.get("staff1IdStr").toString();

			String[] staff1IdArr = staff1IdStr.split(",");

			//인물 1 등록을 위한 맵
			Map<String,Object> staff1IdMap = new HashMap<String, Object>();

			//기초데이터셋팅
			staff1IdMap.put("infoId", map.get("infoId"));
			staff1IdMap.put("infoStaffType", "STAFF_1");
			staff1IdMap.put("userId", map.get("userSeq"));

			for(String staff1Id:staff1IdArr){
				if(EgovStringUtil.isNotEmpty(staff1Id)){
					staff1IdMap.put("staffId", staff1Id);

					businessDAO.insertInfoStaff(staff1IdMap);
				}
			}

		}

		//인물2의 정보가 있다면 등록
		if(map.containsKey("staff2IdStr")&&EgovStringUtil.isNotEmpty(map.get("staff2IdStr").toString())){
			String staff2IdStr = map.get("staff2IdStr").toString();

			String[] staff2IdArr = staff2IdStr.split(",");

			//인물 2 등록을 위한 맵
			Map<String,Object> staff2IdMap = new HashMap<String, Object>();

			//기초데이터셋팅
			staff2IdMap.put("infoId", map.get("infoId"));
			staff2IdMap.put("infoStaffType", "STAFF_2");
			staff2IdMap.put("userId", map.get("userSeq"));

			for(String staff1Id:staff2IdArr){
				if(EgovStringUtil.isNotEmpty(staff1Id)){
					staff2IdMap.put("staffId", staff1Id);

					businessDAO.insertInfoStaff(staff2IdMap);
				}
			}

		}

		int seq = Integer.parseInt(map.get("infoId").toString());
    	int chk =0;

    	if(seq != 0 && !map.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    		map.put("uploadId",seq);
    		chk = fileService.insertFileListJson(map);					//파일 db저장
    		if(chk==0) seq = 0;
		}


	}

	//정보 등록 - 수정하기
	public void updatebusinessInfoRegist(Map<String, Object> map) throws Exception {

		//정보 수정
		businessDAO.updateBsInfoList(map);

		//인물 정보 삭제
		businessDAO.deleteStaffInfo(map);
		//인물1의 정보가 있다면 등록
		if(map.containsKey("staff1IdStr")&&EgovStringUtil.isNotEmpty(map.get("staff1IdStr").toString())){
			String staff1IdStr = map.get("staff1IdStr").toString();

			String[] staff1IdArr = staff1IdStr.split(",");

			//인물 1 등록을 위한 맵
			Map<String,Object> staff1IdMap = new HashMap<String, Object>();

			//기초데이터셋팅
			staff1IdMap.put("infoId", map.get("infoId"));
			staff1IdMap.put("infoStaffType", "STAFF_1");
			staff1IdMap.put("userId", map.get("userSeq"));

			for(String staff1Id:staff1IdArr){
				if(EgovStringUtil.isNotEmpty(staff1Id)){
					staff1IdMap.put("staffId", staff1Id);

					businessDAO.insertInfoStaff(staff1IdMap);
				}
			}

		}

		//인물2의 정보가 있다면 등록
		if(map.containsKey("staff2IdStr")&&EgovStringUtil.isNotEmpty(map.get("staff2IdStr").toString())){
			String staff2IdStr = map.get("staff2IdStr").toString();

			String[] staff2IdArr = staff2IdStr.split(",");

			//인물 2 등록을 위한 맵
			Map<String,Object> staff2IdMap = new HashMap<String, Object>();

			//기초데이터셋팅
			staff2IdMap.put("infoId", map.get("infoId"));
			staff2IdMap.put("infoStaffType", "STAFF_2");
			staff2IdMap.put("userId", map.get("userSeq"));

			for(String staff1Id:staff2IdArr){
				if(EgovStringUtil.isNotEmpty(staff1Id)){
					staff2IdMap.put("staffId", staff1Id);

					businessDAO.insertInfoStaff(staff2IdMap);
				}
			}

		}

		int seq = Integer.parseInt(map.get("infoId").toString());
    	int chk =0;

		if(!map.get("delFileList").toString().equals("")){				//정상저장 이고 삭제파일이 있을때
			 String [] arr = map.get("delFileList").toString().split(",");
			 map.put("fileArr", arr);
			 fileService.updateDelFlag(map);							//파일 db저장 된거 삭제
		}


    	if(seq!=0 && !map.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    		map.put("uploadId",seq);
    		chk = fileService.insertFileListJson(map);					//파일 db저장
    		if(chk==0) seq = 0;
		}

	}

	// 정보 등록 정보 가져오기 (정보)
	public Map getBusinessInfoListInfo(Map<String, Object> map)
			throws Exception {
		// TODO Auto-generated method stub
		logger.debug("########## businessService.getBusinessInfoListInfo ########## param : ["+ map+ "]######");

		Map resultMap = new HashMap();
		Map info = businessDAO.selectBsInfoList(map);
		resultMap.put("inform", info);
		return resultMap;
	}

	// 정보 등록 정보 가져오기 (파일)
	public List<Map> getBusinessInfoListFileList(Map<String,Object> map) throws Exception{
		logger.debug("########## businessService.getBusinessInfoListFileList ########## param : ["+ map+ "]######");

		map.put("uploadId", map.get("infoId"));
		map.put("uploadType", UPLOAD_TYPE_LIST);
		List<Map> fileList= fileDAO.getFileList(map);
		return fileList;
	}




	//////////////////////////////////////////////////park : S
	/**
	 * 정보 정리 리스트
	 * @param map
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public Map<String,Object> getBusinessInfoList(Map<String, Object> map) throws Exception{

		PaginationInfo paginationInfo = new PaginationInfo();

		//현재 페이지
		Integer pageIndex = 1;

		if(map.containsKey("pageIndex")&& !map.get("pageIndex").toString().equals("")){
			pageIndex = Integer.parseInt(map.get("pageIndex").toString());
		}

        paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

        Integer recordCountPerPage = 10;

        if(map.containsKey("recordCountPerPage")&& !map.get("recordCountPerPage").toString().equals("")){
        	recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}

        paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		//int recordCountPerPage = paginationInfo.getRecordCountPerPage();

        map.put("firstIndex", firstRecordIndex);
        map.put("recordCountPerPage", recordCountPerPage);

        //정보정리 리스트
		List<EgovMap> businessInfoList = businessDAO.getBusinessInfoList(map);

		//총개수
		Integer totalCnt =  businessDAO.getBusinessInfoListTotalCnt(map);


        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String,Object> returnMap = new HashMap<String, Object>();
        //리스트
        returnMap.put("businessInfoList", businessInfoList);
        //페이징
        returnMap.put("paginationInfo", paginationInfo);

		return returnMap;
	}

	/**
	 * 정보 정리 리스트
	 * @param map
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public Map<String,Object> getBusinessCommentList(Map<String, Object> map) throws Exception{

		PaginationInfo paginationInfo = new PaginationInfo();

		//현재 페이지
		Integer pageIndex = 1;

		if(map.containsKey("pageIndex")&& !map.get("pageIndex").toString().equals("")){
			pageIndex = Integer.parseInt(map.get("pageIndex").toString());
		}

        paginationInfo.setCurrentPageNo(pageIndex);//현재 페이지 번호

        Integer recordCountPerPage = 10;

        if(map.containsKey("recordCountPerPage")&& !map.get("recordCountPerPage").toString().equals("")){
        	recordCountPerPage = Integer.parseInt(map.get("recordCountPerPage").toString());
		}

        paginationInfo.setRecordCountPerPage(recordCountPerPage);//한 페이지에 게시되는 게시물 건수
        paginationInfo.setPageSize(10);//페이징 리스트의 사이즈

        int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		//int recordCountPerPage = paginationInfo.getRecordCountPerPage();

        map.put("firstIndex", firstRecordIndex);
        map.put("recordCountPerPage", recordCountPerPage);

        //정보정리 리스트
		List<EgovMap> businessInfoList = businessDAO.getBusinessCommentList(map);

		//총개수
		Integer totalCnt =  businessDAO.getBusinessCommentListTotalCnt(map);


        paginationInfo.setTotalRecordCount(totalCnt);

        Map<String,Object> returnMap = new HashMap<String, Object>();
        //리스트
        returnMap.put("businessInfoList", businessInfoList);
        //페이징
        returnMap.put("paginationInfo", paginationInfo);

		return returnMap;
	}
	/**
	 * 정보 코멘트 총개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int getBusinessCommentListTotalCnt(Map<String, Object> map) throws Exception {
		return businessDAO.getBusinessCommentListTotalCnt(map);
	}
	/**
	 * 정보 정리 상세팝업
	 * @param map
	 * @return EgovMap
	 * @throws Exception
	 */
	public EgovMap getBusinessInfo(Map<String, Object> map) throws Exception{
		return businessDAO.getBusinessInfo(map);
	}



	/**
	 * 게시판 댓글 리스트
	 * @param map
	 * @return List<Map>
	 * @throws Exception
	 */
    public List<Map> getCommentList(Map<String, Object> map) throws Exception{


    	List<Map>resultList = new ArrayList();
    	List<Map>list = businessDAO.getCommentList(map);
    	for(int i=0;i<list.size();i++){
    		Map resultMap = new HashMap();
    		Map param = new HashMap();
    		param.put("uploadId", list.get(i).get("commentId"));
    		param.put("uploadType", "INFO_COMMENT");
    		resultMap.put("commentList", list.get(i));
    		resultMap.put("fileList", fileService.getFileList(param));
    		resultList.add(i, resultMap);
    	}

    	return resultList;
    }
    /**
	 * 게시판 댓글 등록 및 수정
	 * @param map
	 * @return int
	 * @throws Exception
	 */
    public int saveComment(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("commentId").toString());
    	int chk =0;
    	if(seq==0){														//등록
    		seq = businessDAO.insertComment(param);

    	}else{															//수정
    		businessDAO.updateComment(param);

    		if(!param.get("delFileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    			 String [] arr = param.get("delFileList").toString().split(",");
    			 param.put("fileArr", arr);
    			 fileService.updateDelFlag(param);						//파일 db저장 된거 삭제
    		}
    	}

    	if(seq!=0 && !param.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    		param.put("uploadId",seq);
    		chk = fileService.insertFileListJson(param);				//파일 db저장
    		if(chk==0) seq = 0;
		}

    	return seq;
    }
    /**
   	 * 게시판 댓글 삭제
   	 * @param map
   	 * @return int
   	 * @throws Exception
   	 */
    public int deleteComment(Map<String, Object> param) throws Exception {

    	int seq = Integer.parseInt(param.get("commentId").toString());

    	try{
    		//게시글 상태값 바꾸고
    		businessDAO.updateCommentDelFlag(param);
        	//본글 파일 지우고
        	fileService.updateDelFlag(param);

        }catch(Exception e){
    		seq = -1;
    		e.getMessage();
    	}
    	return seq;
    }
    /**
	 * 정보 코멘트(내가쓴 댓글의 댓글) 총개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int getBusinessMyCommentListCnt(Map<String, Object> map) throws Exception{
		return businessDAO.getBusinessMyCommentListCnt(map);
	}
	/**
	 * 정보 코멘트(내가쓴 글의 댓글) 총개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int getMyBusinessComenntCnt(Map<String, Object> map) throws Exception{
		return businessDAO.getMyBusinessComenntCnt(map);
	}
	/**
	 * Staff 정보를 조회
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public List<Map<String,Object>> getBusinessStaffInfoList(Map<String, Object> map) throws Exception{
		return businessDAO.getBusinessStaffInfoList(map);
	}
	//////////////////////////////////////////////////park : E



}
