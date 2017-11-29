package ib.system.service;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	: ibiss.system.service
 * filename	: CodeRegService.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 8. 10.
 * @version :
 *
 */
public interface CodeRegService {

	//공통코드 SET
	List<Map> getCodeSet(Map<String, String> map) throws Exception;

	//코드SET 등록(신규)
	int insertCodeSet(Map<String, Object> map) throws Exception;

	//코드SET 등록(수정)
	int updateCodeSet(Map<String, Object> map) throws Exception;

	//공통코드 SET
	List<Map> getCodeList(Map<String, String> map) throws Exception;

	//코드LIST 등록(신규)
	int insertCodeList(Map<String, Object> map) throws Exception;

	//코드LIST 등록(수정)
	int updateCodeList(Map<String, Object> map) throws Exception;

	//코드 set 등록(SYSTEM)
	public int insertCodeSetForSystem(Map<String, Object> map) throws Exception;

	//코드 set 수정(SYSTEM)
	public int updateCodeSetForSystem(Map<String, Object> map) throws Exception;

	//코드 list 등록(SYSTEM)
	public int insertCodeListForSystem(Map<String, Object> map)  throws Exception;

	//코드 list  수졍(SYSTEM)
	public int updateCodeListForSystem(Map<String, Object> map) throws Exception;

	//공통코드,시스템코드 통합 dup chk
	public int getCodeDupChkCnt(Map<String, Object> map) throws Exception;


}
