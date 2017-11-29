package ib.person.service;

import ib.login.service.StaffVO;

import java.util.List;
import java.util.Map;

/**
 * <pre>
 * package	:
 * filename	:
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2016. 01. 15.
 * @version :
 *
 */
public interface PersonService {



	/**
	 * ib 로그인 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 7.
	 */
	public List<StaffVO> checkStaff(StaffVO staffVO) throws Exception;


	/**
	 * 직원정보 수정 화면 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 7.
	 */
	public List<Map> selectStaff(Map<String, String> map) throws Exception;



	/**
	 * 직원정보 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 7.
	 */
	public int updateStaffInfo(Map<String, String> map) throws Exception;
	
	/**
	 * 사용자 이용약관 동의
	 */
	public int updateUserRule(Map<String, Object> map) throws Exception;
}
