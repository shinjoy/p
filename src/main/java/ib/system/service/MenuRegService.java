package ib.system.service;

import ib.basic.interceptor.MenuVO;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	: ibiss.system.service 
 * filename	: MenuRegService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version : 
 *
 */
public interface MenuRegService {

	List<Map> getMenuByRole(Map<String, String> map) throws Exception;
	
	List<Map> getMenuList(Map<String, String> map) throws Exception;

	//메뉴등록(신규)
	int insertMenu(Map<String, Object> map) throws Exception;

	//메뉴등록(수정)
	int updateMenu(Map<String, Object> map) throws Exception;
	
	//메뉴삭제
	int deleteMenu(Map<String, Object> param) throws Exception;

	//권한별 메뉴리스트
	public List<Map> getMenuListByOrg(Map<String, String> map) throws Exception;

	//메뉴 유효체크 (이미 존재하는지)
	String getMenuCodeExistYn(Map<String, String> map) throws Exception;

}
