package ib.pass.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package	: ib.pass.service.impl 
 * filename	: PassDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2017. 1. 26.
 * @version : 
 *
 */
@Repository("passDAO")
public class PassDAO extends ComAbstractDAO{


	//사용자 패스워드
	public String getUserPwdByLoginId(Map<String, String> map) throws Exception{		
		return (String) selectByPk("pass.selectUserPwdByLoginId", map);
	}

	
	//각종 신규 정보 (개선요청게시판 신규건 등..)
	public List<Map> getNewArticleList(Map<String, Object> map) throws Exception{
		return list("pass.selectNewArticleList", map);
	}


	//시너지 사용자 상태 정보
	public List<Map> getSynergyUserStatusList(Map<String, Object> map) throws Exception{
		return list("pass.selectSynergyUserStatusList", map);
	}

	//시너지 사용자 BASE 공통 코드 20170919 ksm
	public List<Map> getSynergyUserBaseCodeList(Map<String, Object> map) throws Exception{
		return list("pass.selectSynergyUserBaseCodeList", map);
	}

	//시너지 사용자 권한코드(콤보용) 20170919 ksm
	public List<Map> getSynergyUserRoleCodeCombo(Map<String, Object> map) throws Exception{
		return list("pass.selectSynergyUserRoleCodeCombo", map);
	}

	//시너지 사용자 소속회사(콤보용) 20170920 ksm
	public List<Map> getSynergyUserRoleCompanyCombo(Map<String, Object> map) throws Exception{
		return list("pass.selectSynergyUserCompanyCombo", map);
	}

	//시너지 사용자 부서(콤보용) 20170920 ksm
	public List<Map> getSynergyDeptCombo(Map<String, Object> map) throws Exception{
		return list("pass.selectSynergyDeptCombo", map);
	}

	//IB LOGIN ID로 해당 PASS 사용자 정보 가져오기 20170921 ksm
	public Map getUserInfoByLoginId(Map<String, Object> map) throws Exception{
		return (Map) selectByPk("pass.selectUserInfoByLoginId", map);
	}

	
}