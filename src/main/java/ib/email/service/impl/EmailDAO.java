package ib.email.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ib.basic.interceptor.MenuVO;
import ib.board.service.impl.BoardDAO;
import ib.cmm.service.impl.ComAbstractDAO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

@Repository("emailDAO")
public class EmailDAO extends ComAbstractDAO {
	
	// 관계사 이메일 서비스 정보 조회
	public Map getEmailServiceInfo(Map param) throws Exception{
		// TODO Auto-generated method stub
		return (Map) super.getSqlMapClientTemplate().queryForObject("email.getEmailServiceInfo", param); 
	}
	
	/**
	 * 사용자 이메일 연동 정보 조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psh
	 * @date		: 2017.01.16
	 */
	public Map getEmailLinkInfo(Map param){
		return (Map) super.getSqlMapClientTemplate().queryForObject("email.getEmailLinkInfo", param);
	}

	public int updateEmailLinkInfo(Map<String, Object> param) {
		return (Integer)update("email.updateEmailLinkInfo", param);
	}
}
