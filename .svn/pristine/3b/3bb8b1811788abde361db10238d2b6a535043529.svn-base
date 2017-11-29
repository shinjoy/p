package ib.person.service.impl;

import java.util.List;
import java.util.Map;

import ib.login.service.StaffVO;
import ib.person.service.PersonService;
import ib.person.service.PersonVO;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("personService")
public class PersonServiceImpl extends AbstractServiceImpl implements PersonService {

    @Resource(name="personDAO")
    private PersonDAO personDAO;


    protected static final Log logger = LogFactory.getLog(PersonServiceImpl.class);




	//로그인 직원 정보
	public List<StaffVO> checkStaff(StaffVO param) throws Exception {

		List<StaffVO> list = personDAO.checkStaff(param);

		return list;
	}

	//직원정보 수정 화면 정보
	public List<Map> selectStaff(Map<String, String> map) throws Exception {

		List<Map> result = personDAO.selectStaff(map);

		return result;
	}


	//직원정보 수정
	public int updateStaffInfo(Map<String,String> map) throws Exception {

		int cnt = personDAO.updateStaffInfo(map);

		return cnt;
	}
	
	//이용약관 동의
	public int updateUserRule(Map<String,Object> map) throws Exception {

		int cnt = personDAO.updateUserRule(map);

		return cnt;
	}
}
