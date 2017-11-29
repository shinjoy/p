/**
 * 개요
 * - 로그인정책에 대한 VO 클래스를 정의한다.
 * 
 * 상세내용
 * - 로그인정책정보의 목록 항목을 관리한다.
 * @author lee.m.j
 * @version 1.0
 * @created 03-8-2009 오후 2:08:55
 */

package ib.login.service;

import java.util.List;

/**
 * <pre>
 * package  : ib.login.service
 * filename : LoginPolicyVO.java
 * </pre>
 * 
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 17.
 * @version : 1.0.0
 */
public class LoginPolicyVO extends LoginPolicy {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 로그인 정책 목록
	 */
	List<LoginPolicyVO> loginPolicyList;
	/**
	 * 삭제 여부
	 */
	String [] delYn;
	
	/**
	 * @return the loginPolicyList
	 */
	public List<LoginPolicyVO> getLoginPolicyList() {
		return loginPolicyList;
	}
	/**
	 * @param loginPolicyList the loginPolicyList to set
	 */
	public void setLoginPolicyList(List<LoginPolicyVO> loginPolicyList) {
		this.loginPolicyList = loginPolicyList;
	}
	/**
	 * @return the delYn
	 */
	public String[] getDelYn() {
		return delYn;
	}
	/**
	 * @param delYn the delYn to set
	 */
	public void setDelYn(String[] delYn) {
		this.delYn = delYn;
	}
	
	
}
