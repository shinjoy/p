package ib.pass.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface PassService {

	String getUserPwdByLoginId(Map<String, String> map) throws Exception;

	List<Map> getNewArticleList(Map<String, Object> map) throws Exception;

	List<Map> getSynergyUserStatusList(Map<String, Object> map) throws Exception;

	//BASE 공통코드 20170919 ksm
	List<Map> getSynergyUserBaseCodeList(Map<String, Object> map) throws Exception;

	//권한코드(콤보용) 20170919 ksm
	List<Map> getSynergyUserRoleCodeCombo(Map<String, Object> map) throws Exception;

	//소속회사(콤보용) 20170920 ksm
	List<Map> getSynergyUserRoleCompanyCombo(Map<String, Object> map) throws Exception;
	
	//부서(콤보용) 20170920 ksm
	List<Map> getSynergyDeptCombo(Map<String, Object> map) throws Exception;

	//IB LOGIN ID로 해당 PASS 사용자 정보 가져오기 20170921 ksm 
	Map getUserInfoByLoginId(Map<String, Object> map) throws Exception;

	//퇴직처리 20170921 ksm
	int doSynergyUserFire(Map<String, Object> map) throws Exception;

}
