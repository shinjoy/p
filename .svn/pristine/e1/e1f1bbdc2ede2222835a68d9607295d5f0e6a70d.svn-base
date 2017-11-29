package ib.system.service.impl;


import ib.system.service.PageRolePerRoleService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("pageRolePerRoleService")
public class PageRolePerRoleServiceImpl extends AbstractServiceImpl implements PageRolePerRoleService {

    @Resource(name="pageRolePerRoleDAO")
    private PageRolePerRoleDAO pageRolePerRoleDAO;
    
    protected static final Log logger = LogFactory.getLog(PageRolePerRoleServiceImpl.class);

    
    //권한별 화면권한 리스트
  	public List<Map> getPageRoleList(Map<String, String> mParam) throws Exception {
  		
  		return pageRolePerRoleDAO.getPageRoleList(mParam);
  	}

  	//권한별 화면권한 저장
	public int mergePageRole(Map<String, String> map) throws Exception {
		return pageRolePerRoleDAO.mergePageRole(map);
	}

	//화면권한 일괄 변경(컬럼헤드 체크박스)
	public int changePageRoleAll(Map<String, String> map) throws Exception {
		return pageRolePerRoleDAO.changePageRoleAll(map);
	}

	
//
//	//권한별 메뉴 등록
//	public int doSaveTabPerRole(Map<String, Object> map) throws Exception {
//		return tabPerRoleDAO.doSaveTabPerRole(map);
//	}
//
//	//권한별 메뉴 복사
//	public int doCopyTabPerRole(Map<String, Object> map) throws Exception {
//		return tabPerRoleDAO.doCopyTabPerRole(map);
//	}

}
