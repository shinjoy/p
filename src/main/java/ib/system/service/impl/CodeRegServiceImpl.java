package ib.system.service.impl;


import ib.cmm.service.impl.CommonDAO;
import ib.system.service.CodeRegService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("codeRegService")
public class CodeRegServiceImpl extends AbstractServiceImpl implements CodeRegService {

    @Resource(name="codeRegDAO")
    private CodeRegDAO codeRegDAO;

    @Resource(name="commonDAO")
    private CommonDAO commonDAO;

    protected static final Log logger = LogFactory.getLog(CodeRegServiceImpl.class);


  	//공통코드 SET
	public List<Map> getCodeSet(Map<String, String> map) throws Exception {

		return codeRegDAO.getCodeSet(map);
	}


	//코드SET 등록(신규)
	public int insertCodeSet(Map<String, Object> map) throws Exception {

		int codeSetId = codeRegDAO.insertCodeSet(map);			//코드SET등록

		return codeSetId;
	}


	//코드SET 등록(수정)
	public int updateCodeSet(Map<String, Object> map) throws Exception {

		int svCnt = codeRegDAO.updateCodeSet(map);				//코드SET수정

		return svCnt;
	}


	//공통코드 LIST
	public List<Map> getCodeList(Map<String, String> map) throws Exception {

		return codeRegDAO.getCodeList(map);
	}


	//코드LIST 등록(신규)
	public int insertCodeList(Map<String, Object> map) throws Exception {

		int codeSetId = codeRegDAO.insertCodeList(map);			//코드LIST 등록

		return codeSetId;
	}


	//코드LIST 등록(수정)
	public int updateCodeList(Map<String, Object> map) throws Exception {

		int svCnt = codeRegDAO.updateCodeList(map);				//코드LIST 수정

		return svCnt;
	}


	//코드 셋 (SYSTEM) 등록
	public int insertCodeSetForSystem(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		logger.debug("##################### CodeRegServiceImpl.insertCodeSetForSystem() ## param : [ "+ map+ "]#######");

		int cnt = 0;
		//관계사 리스트
		Map orgMap = new HashMap();
		orgMap.put("authOrgId", "N");
		orgMap.put("code", "orgId");
		orgMap.put("name", "cpnName");
		List<Map> orgList = commonDAO.getOrgCodeCombo(orgMap);

		for(Map org : orgList){
			Map orgForMap = map;
			orgForMap.put("orgId", org.get("orgId"));
			if(map.get("parentSetName") != null){ //부모 codesetNamem이 있는 경우(parentSetName로 검색)
				Map parentMap = codeRegDAO.selectCodeSetForSystem(map);
				logger.debug("###########검색:"+ parentMap);
				if(parentMap != null){
					orgForMap.put("parentSetId", parentMap.get("codeSetId"));
				}
			}
			logger.debug("###################공통 코드셋 등록#######"+ orgForMap);
			codeRegDAO.insertCodeSet(orgForMap);
			cnt++;
		}

		return cnt;
	}


	//코드 셋(SYSTEM) 수정
	public int updateCodeSetForSystem(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		logger.debug("##################### CodeRegServiceImpl.insertCodeSetForSystem() ## param : [ "+ map+ "]#######");

		int cnt = 0;
		//관계사 리스트
		Map orgMap = new HashMap();
		orgMap.put("authOrgId", "N");
		orgMap.put("code", "orgId");
		orgMap.put("name", "cpnName");
		List<Map> orgList = commonDAO.getOrgCodeCombo(orgMap);

		//관계사 별로 체크
		for(Map org : orgList){
			Map orgForMap = map;
			orgForMap.put("orgId", org.get("orgId"));
			if(map.get("parentSetName") != null){ //부모 codesetNamem이 있는 경우(parentSetName로 검색)
				Map parentMap = codeRegDAO.selectCodeSetForSystem(map);
				logger.debug("###########검색:"+ parentMap);
				if(parentMap != null){
					orgForMap.put("parentSetId", parentMap.get("codeSetId"));
				}
			}
			logger.debug("####################공통 코드셋 업데이트####"+ orgForMap);
			codeRegDAO.updateCodeSetForSystem(orgForMap);
			cnt++;
		}

		return cnt;
	}

	//코드 리스트(SYSTEM) 수정
	public int insertCodeListForSystem(Map<String, Object> map)
			throws Exception {
		// TODO Auto-generated method stub
		logger.debug("##################### CodeRegServiceImpl.insertCodeListForSystem() ## param : [ "+ map+ "]#######");

		int cnt = 0;
		//관계사 리스트
		Map orgMap = new HashMap();
		orgMap.put("authOrgId", "N");
		orgMap.put("code", "orgId");
		orgMap.put("name", "cpnName");
		List<Map> orgList = commonDAO.getOrgCodeCombo(orgMap);

		for(Map comOrg : orgList){
			Map orgForMap = map;

			//코드셋 아이디 구하기 (codeSetName 기준)
			Map codeSetMap = new HashMap();
			codeSetMap.put("parentSetName", map.get("codeSetName"));
			codeSetMap.put("orgId", comOrg.get("orgId"));
			Map parentMap = codeRegDAO.selectCodeSetForSystem(codeSetMap);
			orgForMap.put("codeSetId", parentMap.get("codeSetId"));

			//자식 code set 명으로 sonSetId 구하기
			if(map.get("sonSetName") != null){
				//sonSet 아이디 구하기
				Map sonSetMap = new HashMap();
				sonSetMap.put("parentSetName", map.get("sonSetName"));
				sonSetMap.put("orgId", comOrg.get("orgId"));
				Map sonSetCodeMap = codeRegDAO.selectCodeSetForSystem(sonSetMap);
				if(sonSetCodeMap != null){
					orgForMap.put("sonSetId", sonSetCodeMap.get("codeSetId"));
				}
			}
			logger.debug("#################공통코드 리스트 등록 : "+ orgForMap +"######");
			codeRegDAO.insertCodeList(orgForMap);
			cnt++;
		}

		return cnt;
	}


	//코드 리스트(SYSTEM) 수정
	public int updateCodeListForSystem(Map<String, Object> map) throws Exception {

		logger.debug("##################### CodeRegServiceImpl.updateCodeListForSystem() ## param : [ "+ map+ "]#######");

		int cnt = 0;
		// 코드리스트 아이디 구하기 (기존 코드리스트의 value 기준)
		Map codeSetMap = new HashMap();
		codeSetMap.put("value", map.get("codeValueBefore"));
		List<Map> codeList = codeRegDAO.selectCodeListForSystem(codeSetMap);

		for (Map codes : codeList) {

			if(map.get("codeSetName").toString().equals(codes.get("codeSetName").toString())){		//동일 코드 SET 들에 대해서,

				Map orgForMap = map;
				orgForMap.put("codeListId", codes.get("codeListId"));

				// 자식 code set 명(sonSetName)으로 sonSetId 구하기
				if (map.get("sonSetName") != null) {
					// sonSet 아이디 구하기
					Map sonSetMap = new HashMap();
					sonSetMap.put("parentSetName", map.get("sonSetName"));
					sonSetMap.put("orgId", codes.get("orgId"));
					Map sonSetCodeMap = codeRegDAO.selectCodeSetForSystem(sonSetMap);
					if(sonSetCodeMap != null){
						orgForMap.put("sonSetId", sonSetCodeMap.get("codeSetId"));
					}
				}

				codeRegDAO.updateCodeList(orgForMap);		//공통코드 리스트 업데이트

				cnt++;

			}
		}

		return cnt;
	}
	//공통코드,시스템코드 통합 dup chk
	public int getCodeDupChkCnt(Map<String, Object> map) throws Exception{
		return  codeRegDAO.getCodeDupChkCnt(map);
	}

}
