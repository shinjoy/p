package ib.user.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package	: ibiss.user.service.impl 
 * filename	: UserProfileDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 8. 25.
 * @version : 
 *
 */
@Repository("userProfileDAO")
public class UserProfileDAO extends ComAbstractDAO{

	
	
	/**
	 * 사용자 프로파일 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @param param 
	 * @date		: 2015. 6. 10.
	 */
	@SuppressWarnings("unchecked")
	public List<Map> getUserProfile(Map<String, Object> param) throws Exception{
		return list("user.selectUserProfile", param);
	}


	/**
	 * 사용자 프로파일 수정
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 8. 26.
	 */
	public int changeUserProfile(Map<String, String> map) throws Exception{
		return update("user.updateUserProfile", map);
	}

	
	/**
	 * 사용자 프로파일 최초등록
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 8. 26.
	 */
	public void insertUserProfile(Map<String, Object> map) throws Exception{
		insert("user.insertUserProfile", map);
	}
	
	
	
	
	
//	/**
//	 * 회사 코드
//	 *
//	 * @param		: 
//	 * @return		: 
//	 * @exception	: 
//	 * @author		: oys
//	 * @date		: 2015. 8. 19.
//	 */
//	public List<Map> getCompanyCode(Map<String, String> param) throws Exception{
//		return list("user.selectCompanyCode", param);
//	}
//
//	
//	/**
//	 * 사용자등록(신규)
//	 *
//	 * @param		: 
//	 * @return		: 
//	 * @exception	: 
//	 * @author		: oys
//	 * @date		: 2015. 7. 20.
//	 */
//	public int insertUser(Map<String, Object> map) throws Exception{
//		int key = -1;
//		Object rslt = insert("user.insertUser", map);
//		if(rslt != null)
//			key = Integer.parseInt(rslt.toString());
//		
//		return key;
//	}
//
//	
//	/**
//	 * 사용자수정
//	 *
//	 * @param		: 
//	 * @return		: 
//	 * @exception	: 
//	 * @author		: oys
//	 * @date		: 2015. 6. 16.
//	 */
//	public int updateUser(Map<String, Object> map) throws Exception{
//		return update("user.updateUser", map);
//	}
//
//
//	/**
//	 * 신규 사용자 사번 생성
//	 *
//	 * @param		: 
//	 * @return		: 
//	 * @exception	: 
//	 * @author		: oys
//	 * @date		: 2015. 8. 21.
//	 */
//	public String getNewUserNo() throws Exception{
//		
//		return selectByPk("user.selectNewUserNo", null).toString();
//	}
//
//
//	/**
//	 * 비밀번호 초기화
//	 *
//	 * @param		: 
//	 * @return		: 
//	 * @exception	: 
//	 * @author		: oys
//	 * @date		: 2015. 6. 16.
//	 */
//	public int doInitPwd(Map<String, Object> map) throws Exception{
//		return update("user.updateInitPwd", map);
//	}


	
	
}