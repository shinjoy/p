package ib.cmm.service.impl;


import ib.cmm.service.CommonService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


/**
 * <pre>
 * package	: eam.common.service.impl
 * filename	: CommonServiceImpl.java
 * </pre>
 *
 *
 *
 * @author	: YoungSik Oh
 * @date	: 2015. 6. 29.
 * @version :
 *
 */
@Service("commonService")
public class CommonServiceImpl extends AbstractServiceImpl implements CommonService {

    @Resource(name="commonDAO")
    private CommonDAO commonDAO;

    protected static final Log logger = LogFactory.getLog(CommonServiceImpl.class);


    //공통코드
	public List<Map> getCommonCode(Map<String, String> param) throws Exception {

		return commonDAO.getCommonCode(param);
	}


	//공통코드 (BASE)
	public List<Map> getBaseCommonCode(Map<String, String> param) throws Exception {

        if(param.get("code") == null || param.get("code").equals("")){
            param.put("code", "cd");
        }
        if(param.get("name") == null || param.get("name").equals("")){
            param.put("name", "nm");
        }
        if(param.get("lang") == null || param.get("lang").equals("")){
            param.put("lang", "KOR");
        }

		return commonDAO.getBaseCommonCode(param);
	}


	//사원리스트
	public List<Map> getStaffList(Map<String, String> param) throws Exception {

		return commonDAO.getStaffList(param);
	}


	//사원리스트(이름정렬)
	public List<Map> getStaffListNameSort(Map<String, String> param) throws Exception {

		return commonDAO.getStaffListNameSort(param);
	}

	//사원이름 목록
	public List<Map> getUserNameList(Map<String, String> param) throws Exception {

		return commonDAO.getUserNameList(param);
	}

	//사원리스트(이름정렬 + paging)
	public Map getStaffListNameSortForPaging(Map<String, String> param) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		//parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());

		map.put("pageNo", param.get("pageNo"));									//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.

		int totalCount = commonDAO.getStaffListNameSort(param).size();			//총 건수 -> 쿼리가 느리면 count 쿼리하나더 추가하자
		map.put("totalCount", totalCount);

		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;
		map.put("pageCount", pageCount);										//총 페이지수

		param.put("offset", Integer.toString(((pageNo-1) * pageSize)));
		param.put("limit", param.get("pageSize").toString());					//페이지크기 pageSize

		map.put("list", commonDAO.getStaffListNameSort(param));					//목록리스트

		return map;		//Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총 페이지수), list(리스트)
	}

	//division 리스트
	public List<Map> getSelectDivisionList(Map<String, String> map) throws Exception {

		return commonDAO.getSelectDivisionList(map);
	}


	//부서 리스트
	public List<Map> getDeptList(Map<String, String> map) throws Exception {

		return commonDAO.getDeptList(map);
	}


	//ORG리스트
	public List<Map> getOrgCodeCombo(Map<String, String> map) throws Exception {

		return commonDAO.getOrgCodeCombo(map);
	}


	//org에 따른 companyList - ib_company 의 ref_org_id
	public List<Map> getCompanyListCombo(Map<String, String> map) throws Exception{

		return commonDAO.getCompanyListCombo(map);
	}


	//사용자 리스트
	public List<Map> getUserList(Map<String, String> map) throws Exception {

		return commonDAO.getUserList(map);
	}

	//유저 그룹 목록
	public List<Map> getUserGroupList(Map<String, String> map) throws Exception {

		return commonDAO.getUserGroupList(map);
	}

	//유저 그룹 상세목록
	public List<Map> getUserGroupDetailList(Map<String, String> map) throws Exception {

		return commonDAO.getUserGroupDetailList(map);
	}
}
