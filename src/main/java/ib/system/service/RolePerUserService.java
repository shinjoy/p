package ib.system.service;

import java.util.List;
import java.util.Map;


/**
 * <pre>
 * package	: ibiss.system.service 
 * filename	: RolePerUserService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 7. 28.
 * @version : 
 *
 */
public interface RolePerUserService {

	List<Map> getUserList(Map<String, String> map) throws Exception;

	int mergeRoleCode(Map<String, String> map) throws Exception;

	List<Map> getUserListByRole(Map<String, String> map) throws Exception;
	
	//권한 삭제
	void deleteUserRole(Map<String, String> map) throws Exception;

}
