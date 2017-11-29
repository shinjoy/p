package ib.system.service.impl;


import ib.system.service.ModuleRegService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("moduleRegService")
public class ModuleRegServiceImpl extends AbstractServiceImpl implements ModuleRegService {

    @Resource(name="moduleRegDAO")
    private ModuleRegDAO moduleRegDAO;
    
    protected static final Log logger = LogFactory.getLog(ModuleRegServiceImpl.class);

    
    //권한별 메뉴(로그인시)
  	public List<Map> getModuleByRole(Map<String, String> mParam) throws Exception {
  		
  		return moduleRegDAO.getModuleByRole(mParam);
  	}

    
    //메뉴
	public List<Map> getModuleList(Map<String, String> mParam) throws Exception {
		
		return moduleRegDAO.getModuleList(mParam);
	}

	
	//메뉴등록(신규)
	public int insertModule(Map<String, Object> map) throws Exception {
		
		int boardSeq = moduleRegDAO.insertModule(map);			//메뉴등록
				
		return boardSeq;
	}


	//메뉴등록(수정)
	public int updateModule(Map<String, Object> map) throws Exception {
		
		int svCnt = moduleRegDAO.updateModule(map);				//메뉴수정
		
		return svCnt;
	}


	//메뉴삭제
	public int deleteModule(Map<String, Object> param) throws Exception {
		
		return moduleRegDAO.deleteModule(param);
	}
    
    
}
