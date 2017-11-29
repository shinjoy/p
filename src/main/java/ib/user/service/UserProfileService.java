package ib.user.service;

import java.util.List;
import java.util.Map;


/**
 * <pre>
 * package	: ibiss.user.service 
 * filename	: UserProfileService.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 8. 25.
 * @version : 
 *
 */
public interface UserProfileService {

   
	//사용자 프로파일 리스트
	public List<Map> getUserProfile(Map<String, Object> map) throws Exception;

	//사용자 프로파일 변경
	public int changeUserProfile(Map<String, String> map) throws Exception;

	
//	public List<Map> getCompanyCode(Map<String, String> map) throws Exception;
//	
//	//사용자등록(신규)
//	int insertUser(Map<String, Object> map) throws Exception;
//
//	//사용자등록(수정)
//	int updateUser(Map<String, Object> map) throws Exception;
//
//	//신규 사원번호
//	public String getNewUserNo() throws Exception;
//
//	//비밀번호 초기화
//	public int doInitPwd(Map<String, Object> map) throws Exception;

	
}
