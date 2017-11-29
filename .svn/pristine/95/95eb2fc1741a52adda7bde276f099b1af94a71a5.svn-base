package ib.system.service.impl;


import ib.system.service.MenuPerOrgService;

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


@Service("menuPerOrgService")
public class MenuPerOrgServiceImpl extends AbstractServiceImpl implements MenuPerOrgService {

    @Resource(name="menuPerOrgDAO")
    private MenuPerOrgDAO menuPerOrgDAO;
    
    protected static final Log logger = LogFactory.getLog(MenuPerOrgServiceImpl.class);

	public List<Map> getMenuListByOrg(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return menuPerOrgDAO.getMenuListByOrg(map);
	}

	public int saveMenuListByOrg(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		logger.debug("################## menuPerOrgService.saveMenuListByOrg() ########## ["+ map+ "]");
		
		JSONArray array = JSONArray.fromObject(map.get("pList"));
		
		//저장전 이전 관계사 메뉴 전체 삭제.
		menuPerOrgDAO.deleteMenuListByOrg(map);
		
		Iterator<String> iter = array.iterator();
		int cnt = 1;
		while(iter.hasNext()){
			JSONObject obj = JSONObject.fromObject(iter.next());
			Map param = new HashMap<String,Object>();
			param.put("menuId", obj.getLong("menuId"));
			param.put("orgId", obj.getLong("orgId"));
			param.put("sort", obj.getInt("sort"));
			param.put("userRegId", map.get("userRegId"));
			menuPerOrgDAO.saveMenuListByOrg(param);
			cnt++;
		}
		
		return cnt;
	}

    
}
