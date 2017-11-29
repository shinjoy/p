package ib.system.service;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	: ibiss.system.service 
 * filename	: MenuPerRoleService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version : 
 *
 */
public interface MenuPerRoleService {

	//권한별 메뉴리스트
	List<Map> getMenuByRoleMenu(Map<String, String> map) throws Exception;

	//권한별 메뉴 등록
	int doSaveMenuByRole(Map<String, Object> map) throws Exception;

	//권한별 메뉴 복사
	int doCopyMenuByRole(Map<String, Object> map) throws Exception;
	
	//권한별 메뉴 복사(상단메뉴와 동일하게 복사)
	int doCopyByTop(Map<String, Object> map) throws Exception;
	
	//권한별 메뉴 선택 복사
	int doCopySelectRoleMenuList(Map<String, Object> map) throws Exception;
	
	//메뉴 사용 가능 여부 체크 ( 권한 + 메뉴코드)
	int chkMenuRoleExist(Map<String, Object> map) throws Exception;
}
