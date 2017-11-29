package ib.system.service.impl;


import ib.system.service.ModulePerOrgService;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("modulePerOrgService")
public class ModulePerOrgServiceImpl extends AbstractServiceImpl implements ModulePerOrgService {

    @Resource(name="modulePerOrgDAO")
    private ModulePerOrgDAO ModulePerOrgDAO;
    
    protected static final Log logger = LogFactory.getLog(ModulePerOrgServiceImpl.class);
    
	public List<Map> getModuleListByOrg(Map<String, Object> map)
			throws Exception {
		// TODO Auto-generated method stub
		logger.debug("################## modulePerOrgService.getModuleListByOrg() ########## ["+ map+ "]");
		return ModulePerOrgDAO.getModuleListByOrg(map);
	}

	public int saveModuleListByOrg(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
	logger.debug("################## modulePerOrgService.saveModuleListByOrg() ########## ["+ map+ "]");
		
		JSONArray array = JSONArray.fromObject(map.get("pList"));
		
		//저장전 이전 관계사 메뉴 전체 삭제.
		ModulePerOrgDAO.deleteModuleListByOrg(map);
		
		Iterator<String> iter = array.iterator();
		int cnt = 1;
		while(iter.hasNext()){
			JSONObject obj = JSONObject.fromObject(iter.next());
			Map param = new HashMap<String,Object>();
			param.put("moduleId", obj.getLong("moduleId"));
			param.put("orgId", obj.getLong("orgId"));
			param.put("sort", obj.getInt("sort"));
			param.put("userRegId", map.get("userRegId"));
			ModulePerOrgDAO.saveModuleListByOrg(param);
			cnt++;
		}
		
		return cnt;
	}

    
}
