package ib.user.service.impl;


import ib.user.service.UserProfileService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;



import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("userProfileService")
public class UserProfileServiceImpl extends AbstractServiceImpl implements UserProfileService {

    @Resource(name="userProfileDAO")
    private UserProfileDAO userProfileDAO;



    //사용자 프로파일 리스트
	public List<Map> getUserProfile(Map<String, Object> param) throws Exception {

		return userProfileDAO.getUserProfile(param);
	}


	//사용자 프로파일 변경
	public int changeUserProfile(Map<String, String> map) throws Exception {
		return userProfileDAO.changeUserProfile(map);
	}


//	//직원형태 코드
//	public List<Map> getCompanyCode(Map<String, String> param) throws Exception {
//
//		return userDAO.getCompanyCode(param);
//	}
//
//	//사용자등록(신규)
//	public int insertUser(Map<String, Object> map) throws Exception {
//		int userId = userDAO.insertUser(map);			//사용자등록
//
//		return userId;
//	}
//
//	//사용자수정
//	public int updateUser(Map<String, Object> map) throws Exception {
//		int svCnt = userDAO.updateUser(map);			//사용자수정
//
//		return svCnt;
//	}
//
//	//신규 사원번호
//	public String getNewUserNo() throws Exception {
//
//		return userDAO.getNewUserNo();
//	}
//
//	//비밀번호 초기화
//	public int doInitPwd(Map<String, Object> map) throws Exception {
//
//		return userDAO.doInitPwd(map);
//	}



}
