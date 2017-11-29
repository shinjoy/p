package ib.system.service;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	: ibiss.system.service 
 * filename	: ModuleRegService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 8. 5.
 * @version : 
 *
 */
public interface ModuleRegService {

	//권한별 메뉴(로그인시)
	List<Map> getModuleByRole(Map<String, String> mParam) throws Exception;
	
	//메뉴
	List<Map> getModuleList(Map<String, String> map) throws Exception;

	//모듈등록(신규)
	int insertModule(Map<String, Object> map) throws Exception;

	//모듈등록(수정)
	int updateModule(Map<String, Object> map) throws Exception;
	
	//모듈삭제
	int deleteModule(Map<String, Object> param) throws Exception;
}
