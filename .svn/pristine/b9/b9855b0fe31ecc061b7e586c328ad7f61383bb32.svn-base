package ib.system.service.impl;


import ib.system.service.RolePerUserService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("rolePerUserService")
public class RolePerUserServiceImpl extends AbstractServiceImpl implements RolePerUserService {

    @Resource(name="rolePerUserDAO")
    private RolePerUserDAO rolePerUserDAO;
    
    protected static final Log logger = LogFactory.getLog(RolePerUserServiceImpl.class);

    

	//자용자리스트
	public List<Map> getUserList(Map<String, String> param) throws Exception {
		return rolePerUserDAO.getUserList(param); 
	}
	
	
	//사용자리스트 - 권한설정을 위한
	public List<Map> getUserListByRole(Map<String, String> map) throws Exception {
		return rolePerUserDAO.getUserListByRole(map); 
	}


	//권한변경 저장
	public int mergeRoleCode(Map<String, String> param) throws Exception {
		String roleId = String.valueOf(param.get("userRole"));
		if(StringUtils.isEmpty(roleId)){
			param.put("userRole",  "0");
		}
		rolePerUserDAO.mergeRoleCode(param);					//권한코드 변경
		
		return rolePerUserDAO.updateOrgAccessAuthType(param);	//권한 관계사 접근 권한 타입 변경
	}
	
	//권한 삭제
	public void deleteUserRole(Map<String, String> map) throws Exception{
		rolePerUserDAO.deleteUserRole(map);
	}
    
    
}
