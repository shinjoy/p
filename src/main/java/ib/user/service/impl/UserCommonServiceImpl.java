package ib.user.service.impl;


import ib.user.service.UserCommonService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * <pre>
 * package	: ibiss.user.service.impl 
 * filename	: UserCommonServiceImpl.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 11. 16.
 * @version : 
 *
 */
@Service("userCommonService")
public class UserCommonServiceImpl extends AbstractServiceImpl implements UserCommonService {

    @Resource(name="userCommonDAO")
    private UserCommonDAO userCommonDAO;
    
    protected static final Log logger = LogFactory.getLog(UserCommonServiceImpl.class);

	//부서 TREE
	public List<Map> getDeptListForTree(Map<String, String> param) throws Exception {
		
		return userCommonDAO.getDeptListForTree(param);
	}

	//부서별 사원
	public List<Map> getUserListInDept(Map<String, String> param) throws Exception {
		
		return userCommonDAO.getUserListInDept(param);
	}
    
}
