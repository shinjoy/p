package ib.project.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;
import ib.cmm.util.sim.service.EtcUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package	: ibiss.project.service.impl
 * filename	: ProjectStatisDAO.java
 * </pre>
 *
 *
 *
 * @author	:
 * @date	:
 * @version :
 *
 */
@Repository("projectStatisDAO")
public class ProjectStatisDAO extends ComAbstractDAO{

	protected static final Log logger = LogFactory.getLog(ProjectStatisDAO.class);

	// 부서별 목록
	@SuppressWarnings("unchecked")
	public EgovMap getDeptStatis(Map<String, Object> paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("projectStatisDAO.getDeptStatis", paramMap);
	}

	// 부서별 프로젝트전체
	@SuppressWarnings("unchecked")
	public EgovMap getProjectStatus(Map<String, Object> paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("projectStatisDAO.getProjectStatus", paramMap);
	}

	// 부서별 액티비티전체
	@SuppressWarnings("unchecked")
	public EgovMap getActivityStatus(Map<String, Object> paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("projectStatisDAO.getActivityStatus", paramMap);
	}

	// 부서별 업무일지전체
	@SuppressWarnings("unchecked")
	public EgovMap getOfficeDaily(Map<String, Object> paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("projectStatisDAO.getOfficeDaily", paramMap);
	}

	// 부서별 비교
	@SuppressWarnings("unchecked")
	public List<Map> getDeptCompareList(Map<String, Object> paramMap) throws Exception {
		return list("projectStatisDAO.getDeptCompareList", paramMap);
	}

	// 부서별 프로젝트정보
	@SuppressWarnings("unchecked")
	public List<Map> getProjectInfoList(Map<String, Object> paramMap) throws Exception {
		return list("projectStatisDAO.getProjectInfoList", paramMap);
	}

	// 유저네임
	@SuppressWarnings("unchecked")
	public EgovMap getUserName(Map<String, Object> paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("projectStatisDAO.getUserName", paramMap);
	}

	// 부서네임
	@SuppressWarnings("unchecked")
	public EgovMap getDeptName(Map<String, Object> paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("projectStatisDAO.getDeptName", paramMap);
	}

	// 프로젝트별 액티비티전체
	@SuppressWarnings("unchecked")
	public EgovMap getProjectActivityStatus(Map<String, Object> paramMap) throws Exception {
		return (EgovMap)getSqlMapClientTemplate().queryForObject("projectStatisDAO.getProjectActivityStatus", paramMap);
	}

	// 프로젝트정보 팀업무, 개인업무, 업무전체
	@SuppressWarnings("unchecked")
	public List<Map> getProjectTeamPrivateWorkList(Map<String, Object> paramMap) throws Exception {
		return list("projectStatisDAO.getProjectTeamPrivateWorkList", paramMap);
	}

	// 직원
	@SuppressWarnings("unchecked")
	public List<Map> getProjectUserList(Map<String, Object> paramMap) throws Exception {
		return list("projectStatisDAO.getProjectUserList", paramMap);
	}

	// 액티비티
	@SuppressWarnings("unchecked")
	public List<Map> getActivityList(Map<String, Object> paramMap) throws Exception {
		return list("projectStatisDAO.getActivityList", paramMap);
	}

	// 프로젝트정보 팀업무, 개인업무, 업무전체
	@SuppressWarnings("unchecked")
	public List<Map> getProjectWorkList(Map<String, Object> paramMap) throws Exception {
		return list("projectStatisDAO.getProjectWorkList", paramMap);
	}

}