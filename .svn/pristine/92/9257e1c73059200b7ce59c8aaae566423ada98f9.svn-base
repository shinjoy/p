package ib.project.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package	: ibiss.project.service
 * filename	: ProjectStatisService.java
 * </pre>
 *
 *
 * @author	:
 * @date	:
 * @version :
 *
 */
public interface ProjectStatisService {

	// 부서별 목록
	public EgovMap getDeptStatis(Map<String, Object> paramMap) throws Exception;

	// 부서별 프로젝트전체
	public EgovMap getProjectStatus(Map<String, Object> paramMap) throws Exception;

	// 부서별 액티비티전체
	public EgovMap getActivityStatus(Map<String, Object> paramMap) throws Exception;

	// 부서별 업무일지전체
	public EgovMap getOfficeDaily(Map<String, Object> paramMap) throws Exception;

	// 부서별 비교
	public List<Map> getDeptCompareList(Map<String, Object> paramMap) throws Exception;

	// 부서별 프로젝트정보
	public List<Map> getProjectInfoList(Map<String, Object> paramMap) throws Exception;

	// 유저
	public EgovMap getUserName(Map<String, Object> paramMap) throws Exception;

	// 부서
	public EgovMap getDeptName(Map<String, Object> paramMap) throws Exception;

	// 프로젝트별 액티비티전체
	public EgovMap getProjectActivityStatus(Map<String, Object> paramMap) throws Exception;

	// 프로젝트정보 팀업무, 개인업무, 업무전체
	public List<Map> getProjectTeamPrivateWorkList(Map<String, Object> paramMap) throws Exception;

	// 직원
	public List<Map> getProjectUserList(Map<String, Object> paramMap) throws Exception;

	// 액티비티
	public List<Map> getActivityList(Map<String, Object> paramMap) throws Exception;

	// 프로젝트별 업무 참여도
	public List<Map> getProjectWorkList(Map<String, Object> paramMap) throws Exception;

}
