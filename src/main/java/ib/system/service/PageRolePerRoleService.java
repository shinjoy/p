package ib.system.service;

import java.util.List;
import java.util.Map;


/**
 * <pre>
 * package	: ibiss.system.service 
 * filename	: PageRolePerRoleService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 10. 28.
 * @version : 
 *
 */
public interface PageRolePerRoleService {


	//권한별 화면권한 리스트
	List<Map> getPageRoleList(Map<String, String> map) throws Exception;

	//화면권한 변경
	int mergePageRole(Map<String, String> map) throws Exception;

	//화면권한 일괄 변경(컬럼헤드 체크박스)
	int changePageRoleAll(Map<String, String> map) throws Exception;

	

//	//권한별 메뉴 등록
//	int doSaveTabPerRole(Map<String, Object> map) throws Exception;
//
//	//권한별 메뉴 복사
//	int doCopyTabPerRole(Map<String, Object> map) throws Exception;
	
}
