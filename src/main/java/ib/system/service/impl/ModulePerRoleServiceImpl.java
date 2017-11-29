package ib.system.service.impl;


import ib.system.service.ModulePerRoleService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("modulePerRoleService")
public class ModulePerRoleServiceImpl extends AbstractServiceImpl implements ModulePerRoleService {

    @Resource(name="modulePerRoleDAO")
    private ModulePerRoleDAO modulePerRoleDAO;
    
    protected static final Log logger = LogFactory.getLog(ModulePerRoleServiceImpl.class);

    
    //권한별 메뉴(로그인시)
  	public List<Map> getModulePerRole(Map<String, String> mParam) throws Exception {
  		
  		return modulePerRoleDAO.getModulePerRole(mParam);
  	}


	//권한별 메뉴 등록
	public int doSaveModulePerRole(Map<String, Object> map) throws Exception {
		return modulePerRoleDAO.doSaveModulePerRole(map);
	}

	//권한별 메뉴 복사
	public int doCopyModulePerRole(Map<String, Object> map) throws Exception {
		return modulePerRoleDAO.doCopyModulePerRole(map);
	}

    
    
     
}
