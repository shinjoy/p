package ib.system.service;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	: ib.system.service 
 * filename	: MenuPerOrgService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2016. 10. 19.
 * @version : 
 *
 */
public interface MenuPerOrgService {

	//관계사별 메뉴 리스트
	public List<Map> getMenuListByOrg(Map<String, Object> map) throws Exception;

	//관계사별 메뉴 리스트 저장
	public int saveMenuListByOrg(Map<String, Object> map)  throws Exception;
}
