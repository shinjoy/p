package ib.system.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package	: ib.system.service.impl 
 * filename	: MenuPerOrgDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2016. 10. 19.
 * @version : 
 *
 */
@Repository("menuPerOrgDAO")
public class MenuPerOrgDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(MenuPerOrgDAO.class);

	//관계사별 메뉴 리스트 반환.
	public List<Map> getMenuListByOrg(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return list("orgCompany.getMenuListByOrg", map);
	}

	//관계사별 메뉴 리스트 저장
	public void saveMenuListByOrg(Map<String, Object> map) {
		// TODO Auto-generated method stub
		insert("orgCompany.saveMenuListByOrg", map);
	}

	//관계사별 메뉴 리스트 삭제 
	public void deleteMenuListByOrg(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		map.put("enable", "N");
		update("orgCompany.deleteMenuListByOrg", map);
	}


}