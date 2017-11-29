package ib.system.service;

import ib.basic.interceptor.MenuVO;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	: ibiss.system.service 
 * filename	: TabPerRoleService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 8. 4.
 * @version : 
 *
 */
public interface TabPerRoleService {
	
	//메뉴별 탭 리스트
	public List<Map> getTabPerMenu(Map<String, String> map) throws Exception;

	//권한별 탭 리스트
	public List<Map> getTabPerRole(Map<String, String> map) throws Exception;
	
	//권한별 메뉴 등록
	int doSaveTabPerRole(Map<String, Object> map) throws Exception;

	//권한별 메뉴 복사
	int doCopyTabPerRole(Map<String, Object> map) throws Exception;
	
	
	//메뉴 등록(탭) 선택 시 메뉴 정보 반환.
	public List<MenuVO> selectMenuForTabRegister(Map<String, Object> map) throws Exception;

	//선택된 메뉴 정보 반환.
	public List<MenuVO> getMenuInfoInfo(Map map) throws Exception;
	
	//권한 selectbox에서 text를 통한 roleId 반환.
	public int selectRoleInfo(Map map) throws Exception;
	
	


	
}
