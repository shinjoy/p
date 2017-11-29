package ib.system.service.impl;


import ib.system.service.CodePerRoleService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("codePerRoleService")
public class CodePerRoleServiceImpl extends AbstractServiceImpl implements CodePerRoleService {

    @Resource(name="codePerRoleDAO")
    private CodePerRoleDAO codePerRoleDAO;
    
    protected static final Log logger = LogFactory.getLog(CodePerRoleServiceImpl.class);

    
  	//권한별 코드SET,값 리스트
	public List<Map> getCodeSetValuePerRole(Map<String, String> map) throws Exception{

		return codePerRoleDAO.getCodeSetValuePerRole(map);
	}

	//권한 변경
	public int changeExclusion(Map<String, String> map) throws Exception {

		String knd = map.get("knd").toString();
		
		int cnt = 0;
		
		if("INS".equals(knd)){
			cnt = codePerRoleDAO.insertCodeSetValuePerRole(map);
			cnt = 1;
		}else {		//if("DEL".equals(knd)){
			cnt = codePerRoleDAO.deleteCodeSetValuePerRole(map);
		}
		
		return cnt;
	}

	
//	//코드SET 등록(신규)
//	public int insertCodeSet(Map<String, Object> map) throws Exception {
//		
//		int codeSetId = codeRegDAO.insertCodeSet(map);			//코드SET등록 
//				
//		return codeSetId;
//	}
//
//
//	//코드SET 등록(수정)
//	public int updateCodeSet(Map<String, Object> map) throws Exception {
//		
//		int svCnt = codeRegDAO.updateCodeSet(map);				//코드SET수정
//		
//		return svCnt;
//	}
//
//
//	//공통코드 LIST
//	public List<Map> getCodeList(Map<String, String> map) throws Exception {
//
//		return codeRegDAO.getCodeList(map);
//	}
//	
//	
//	//코드LIST 등록(신규)
//	public int insertCodeList(Map<String, Object> map) throws Exception {
//		
//		int codeSetId = codeRegDAO.insertCodeList(map);			//코드LIST 등록 
//				
//		return codeSetId;
//	}
//
//
//	//코드LIST 등록(수정)
//	public int updateCodeList(Map<String, Object> map) throws Exception {
//		
//		int svCnt = codeRegDAO.updateCodeList(map);				//코드LIST 수정
//		
//		return svCnt;
//	}

}
