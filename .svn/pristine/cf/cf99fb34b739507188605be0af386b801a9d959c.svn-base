package ib.project.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.project.service.ProjectStatisService;


@Service("projectStatisService")
public class ProjectStatisServiceImpl extends AbstractServiceImpl implements ProjectStatisService {

    @Resource(name="projectStatisDAO")
    private ProjectStatisDAO projectStatisDAO;

    protected static final Log logger = LogFactory.getLog(ProjectStatisServiceImpl.class);

    // 부서별 목록
	public EgovMap getDeptStatis(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getDeptStatis(paramMap);
	}

	// 부서별 프로젝트전체
	@SuppressWarnings("unchecked")
	public EgovMap getProjectStatus(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getProjectStatus(paramMap);
	}

	// 부서별 액티비티전체
	public EgovMap getActivityStatus(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getActivityStatus(paramMap);
	}

	// 부서별 업무일지전체
	@SuppressWarnings("unchecked")
	public EgovMap getOfficeDaily(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getOfficeDaily(paramMap);
	}

	// 부서별 비교
	public List<Map> getDeptCompareList(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getDeptCompareList(paramMap);
	}

	// 부서별 프로젝트정보
	public List<Map> getProjectInfoList(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getProjectInfoList(paramMap);
	}

	// 유저네임
	public EgovMap getUserName(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getUserName(paramMap);
	}

	// 부서네임
	public EgovMap getDeptName(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getDeptName(paramMap);
	}

	// 프로젝트별 액티비티전체
	public EgovMap getProjectActivityStatus(Map<String, Object> paramMap) throws Exception {

		return projectStatisDAO.getProjectActivityStatus(paramMap);
	}

	// 프로젝트정보 팀업무, 개인업무, 업무전체
	public List<Map> getProjectTeamPrivateWorkList(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getProjectTeamPrivateWorkList(paramMap);
	}

	// 직원
	public List<Map> getProjectUserList(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getProjectUserList(paramMap);
	}

	// 액티비티
	public List<Map> getActivityList(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getActivityList(paramMap);
	}

	// 프로젝트별 업무 참여도
	public List<Map> getProjectWorkList(Map<String, Object> paramMap) throws Exception {
		return projectStatisDAO.getProjectWorkList(paramMap);
	}
}
