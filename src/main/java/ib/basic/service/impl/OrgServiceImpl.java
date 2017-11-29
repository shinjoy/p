package ib.basic.service.impl;

import ib.basic.service.OrgService;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("orgService")
public class OrgServiceImpl extends AbstractServiceImpl implements OrgService {

	@Resource(name = "orgDAO")
	private OrgDAO orgDAO;

	protected static final Log logger = LogFactory.getLog(OrgServiceImpl.class);

	//조직도의 등록된 회사 리스트
	public List<Map> getCompanyStructList(Map map) throws Exception {

		return orgDAO.getCompanyStructList(map);
	}

	//조직도의 등록 가능 회사 리스트
	public List<Map> getCompanyList(Map map) throws Exception {

		return orgDAO.getCompanyList(map);
	}

	//조직도 등록 및 수정
	public void saveCompanyStruct(Map map) throws Exception{
		if(map.get("companyStructId").toString().equals("0")){
			orgDAO.insertCompanyStruct(map);
		}else{
			orgDAO.updateCompanyStruct(map);
		}

	}

	//조직도 삭제
	public void deleteCompanyStruct(Map map) throws Exception{
		orgDAO.deleteCompanyStruct(map);

	}

	public List<Map> getDeptListForOrg(Map map) throws Exception {
		// TODO Auto-generated method stub
		logger.debug("################### orgService.getDeptListForOrg() ############## param : [ "+ map +" ]########");
		//회사명을 통하여 관계사 검색
		Map comInfo = orgDAO.selectCompInfo(map);
		if(comInfo == null){
			return new ArrayList<Map>();
		}
		//해당 관계사에 포함된 부서 검색
		return orgDAO.selectDeptList(comInfo);
	}


	public List<Map> selectDeptUserList(Map map)  throws Exception {
		logger.debug("#################### orgService.selectDeptUserList ############# param : ["+ map+"]###########");
		return orgDAO.selectDeptUserList(map);
	}


	public Map selectUserDetailInfoForOrg(Map map ) throws Exception {
		logger.debug("#################### orgService.selectUserDetailInfoForOrg ############# param : ["+ map+"]###########");
		Map resultMap = new HashMap();

		//01. 사용자의 기본정보를 조회한다.
		Map userDetail = orgDAO.getPersonnelDetail(map);
		map.put("orgId", userDetail.get("orgId"));

		//04. 사용자의 학력사항을 조회한다
		List<Map> userAcademic = orgDAO.getUserAcademic(map);

		//05. 사용자의경력사항을 조회한다
		List<Map> userCareer = orgDAO.getUserCareer(map);

		//07 . 사용자의 부서 리스트를 가져온다.
		List<Map> userDeptList = orgDAO.getUserDeptList(map);

		//사용자의 사진 검색
		Map photoMap = orgDAO.getFileInfoImage(map);
		if(photoMap != null){
			fileCopy((String)photoMap.get("path"), (String)map.get("realPath"), (String)photoMap.get("makeName"));
		}


		resultMap.put("userDetail", userDetail);
		resultMap.put("userAcademic", userAcademic);
		resultMap.put("userCareer", userCareer);
		resultMap.put("userDeptList", userDeptList);
		resultMap.put("photoMap", photoMap);
		return resultMap;
	}



    /**
     *
     * @MethodName : fileCopy
     * @param srcFolder 파일이 위치한 폴더
     * @param targetFolder 복사할 폴더
     * @param fileName 파일 이름
     */
	private void fileCopy(String srcFolder, String targetFolder, String fileName) throws Exception{
    	String inFileName = srcFolder+"/"+fileName;
    	String outFileName = targetFolder+"/"+fileName;

    	File f = new File(targetFolder);
	    f.mkdirs();//파일 저장될 폴더 생성

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
    		e.printStackTrace();
    	}
    }


	//인사정보 검색(직원명, 직무명)
	public List<Map> searchStaffNmOrWorkForOrg(Map map) throws Exception {
		// TODO Auto-generated method stub
		logger.debug("#################### orgService.searchStaffNmOrWorkForOrg ############# param : ["+ map+"]###########");
		return orgDAO.searchUserList(map);
	}
	//User Group 관리 팝업에서 조회하는 조직도...psj
	public List<Map> getOrganizationListInfoList(Map map ) throws Exception{
		return orgDAO.getOrganizationListInfoList(map);
	}



}
