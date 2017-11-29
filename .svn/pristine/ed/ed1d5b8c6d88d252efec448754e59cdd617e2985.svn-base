package ib.project.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;
import ib.cmm.util.sim.service.EtcUtil;

import ib.common.util.DateUtil;
import ib.work.service.WorkMemoService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package	: ibiss.project.service.impl
 * filename	: ProjectMgmtDAO.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 10. 16.
 * @version :
 *
 */
@Repository("projectMgmtDAO")
public class ProjectMgmtDAO extends ComAbstractDAO{

	@Resource(name="workMemoService")
	private WorkMemoService workMemoService;

	protected static final Log logger = LogFactory.getLog(ProjectMgmtDAO.class);


	/**
	 * 프로젝트 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 16.
	 */
	public List<Map> getProjectList(Map<String, Object> mParam) throws Exception{

		return list("project.selectProjectList", mParam);
	}


	/**
	 * 리스트 건수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 16.
	 */
	public int getProjectListCount(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("project.selectProjectListCount", param).toString());
	}


	/**
	 * 개인별 리스트 건수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 16.
	 */
	public int getUserProjectListCount(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("project.selectUserProjectListCount", param).toString());
	}


	/**
	 * 프로젝트 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int insertProject(Map<String, Object> map) throws Exception{
		int key = -1;
		String newProjectCode = selectByPk("project.getNewProjectCode", map).toString();

		map.put("projectCode", newProjectCode);
		Object rslt = insert("project.insertProject", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());

		return key;
	}
	/**
	 * 기본 프로젝트 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int insertBaseProject(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("project.insertBaseProject", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());

		return key;
	}
	/**
	 * 기본액티비티 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public void insertBaseActivity(Map<String, Object> map) throws Exception{
		insert("project.insertBaseActivity", map);
	}


	/**
	 * 프로젝트 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public void updateProject(Map<String, Object> map) throws Exception{
		update("project.updateProject", map);
	}


	/**
	 * 프로젝트 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 15.
	 */
	public List<Map> getProjectInfo(Map map) throws Exception{

		return list("project.getProjectInfo", map);
	}


	/**
	 * 프로젝트 배정직원 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 24.
	 */
	public List<Map> getProjectUserList(Map map) throws Exception{

		return list("project.selectProjectUserList", map);
	}


	/**
	 * activity 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 15.
	 */
	public List<Map> getActivityList(Map map) throws Exception{

		return list("project.selectActivityList", map);
	}


	/**
	 * 개인별 activity 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 15.
	 */
	public List<Map> getUserActivityList(Map map) throws Exception{

		return list("project.selectUserActivityList", map);
	}


	/**
	 * activity 배정직원 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 18.
	 */
	public List<Map> getActivityUserList(Map map) throws Exception{

		return list("project.selectActivityUserList", map);
	}


	/**
	 * 개인별 기본 project 및 activity 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 25.
	 */
	public int changeUserDefaultPjtAct(Map<String, Object> map) {

		String knd = map.get("knd").toString();							//"PROJECT" or "ACTIVITY"

		int upCnt = 0;
		if("PROJECT".equals(knd)){				//프로젝트 기본에 대한 체크일때
			update("project.updateInitUserDefaultProject", map);		//사용자 기본 초기화

			insert("project.mergeProjectUser", map);					//사용자별 기본 project 등록
			upCnt = 1;


		}else if("ACTIVITY".equals(knd)){		//activity 기본에 대한 체크일때
			update("project.updateInitUserDefaultActivity", map);		//사용자 기본 초기화

			insert("project.mergeActivityUser", map);					//사용자별 기본 activity 등록
			upCnt = 1;

		}

		/*
		else {						//직원 배정에 대한 체크일때
			if("INS".equals(action)){
				insert("project.mergeActivityUser", map);				//activity 별 직원배정 등록
				upCnt = 1;
			}else if("DEL".equals(action)){
				upCnt = delete("project.deleteActivityUser", map);		//activity 별 직원배정 삭제
			}
		}*/


		return upCnt;
	}


	/**
	 * 개인별 프로젝트 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 24.
	 */
	public List<Map> getUserProjectList(Map<String, Object> mParam) throws Exception{

		return list("project.selectUserProjectList", mParam);
	}


	/**
	 * 프로젝트, activity 별 배정직원 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 26.
	 */
	public int mergeActivityUserAlloc(Map<String, Object> map) throws Exception{

		List<Map> pEmpList = new ArrayList<Map>();					//프로젝트별 배정 직원정보 등록을 위한 LIST 선언


		List list = (ArrayList<Map>)map.get("aList");
		String projectId = map.get("projectId").toString();	//projectId
		String userSeq = map.get("userSeq").toString();		//로그인 사용자 id
		int cnt = list.size();
		if(cnt > 0){			//저장할 것이 있을때

			for(int i=0; i<cnt; i++) {

				Map param = (Map)list.get(i);

				////////////// activity 별 직원배정 등록 //////////////
				if("A".equals(map.get("employee").toString())){  // 전체직원인경우 직원삭제함
					map.put("actionType", "UPDATE");
					delete("project.deleteActivityUser", map);  //activity 유저 삭제(default 'N'인것만)
				}else{
					//activityId
					String activityId = param.get("activityId").toString();

					//activity 별 직원배정 등록
					if("java.util.ArrayList".equals(param.get("empList").getClass().getCanonicalName())) {	//화면에서 직원배정 정보가 없으면 java.lang.String 으로 넘어온다.

						////////////해당 직원배정 정보가 아닌 다른 것들이 있으면 삭제(enable 'N', default 'N') ////////////

						//--empList 에 없는 사용자를 enable N 처리후  신규나 기존데이터 insert duplicate update 방식
						update("project.updateDisableActivityUser", param);				//activity 별 직원배정 삭제(enable 'N', default 'N')

						if("N".equals(param.get("employee").toString())) continue;		//직원배정여부가 'N'이면 해당 activity 에 대한 직원배정 정보를 초기화만 하고(바로위에서) 건너뛴다

						List<Map> empList = (List<Map>)param.get("empList");
						for(int t=0; t<empList.size(); t++) {
							empList.get(t).put("activityId", activityId);	//activityId 를 넣어 등록에 태운다
							empList.get(t).put("userSeq", userSeq);			//사용자id
							empList.get(t).put("enable", "Y");				//enable 'Y' 로 (만약 'N'으로 삭제처리된 것을 복원시킨다)
							empList.get(t).put("defaultYn", "N");			//defaultYn 'N' 로
							empList.get(t).put("actionType", "UPDATE");

							insert("project.mergeActivityUser", empList.get(t));		//activity 별 직원배정 등록


							//////// 프로젝트 별 배정직원 정보 추가
							String userId = empList.get(t).get("userId").toString();
							if(EtcUtil.getIndexOFListMap(userId, "userId", pEmpList) == -1) {
								Map m = new HashMap();
								m.put("userId", userId);
								pEmpList.add(m);
							}
						}

					}else {
						logger.debug("############# empList 가 java.util.ArrayList 타입이 아닌것이 존재함!!!!!! (확인!!!!) ############# ");
					}
				}
			}//for

		}//if

		update("project.updateActivityParentId", map);		//activity (parent_id 일괄추가수정)

		//////////////////// 프로젝트 직원배정 정보 등록 ////////////////////
		if("A".equals(map.get("employee").toString())){
			map.put("actionType", "UPDATE");
			delete("project.deleteProjectUser", map);	 //project 유저 삭제(default 'N'인것만)
		}else{
			//pEmpList
			map.put("pEmpList", pEmpList);
			//해당 직원배정 정보가 아닌 다른 것들이 있으면 삭제(enable 'N', default 'N')
			update("project.updateDisableProjectUser", map);					//project 별 직원배정 삭제(enable 'N', default 'N')

			List<Map> pEList = (ArrayList<Map>)map.get("pEmpList");
			for(int t=0; t<pEList.size(); t++) {
				pEList.get(t).put("projectId", projectId);		//projectId 를 넣어 등록에 태운다
				pEList.get(t).put("userSeq", userSeq);			//사용자id
				pEList.get(t).put("enable", "Y");				//enable 'Y' 로 (만약 'N'으로 삭제처리된 것을 복원시킨다)
				pEList.get(t).put("defaultYn", "N");			//defaultYn 'N' 로
				pEList.get(t).put("actionType", "UPDATE");

				insert("project.mergeProjectUser", pEList.get(t));				//project 별 직원배정 등록
			}
		}

		//직원배정 업데이트
		update("project.updateProjectEmployee", map);
		update("project.updateActivityEmployee", map);

		return 0;

	}



	/**
	 * 프로젝트 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 6. 7.
	 */
	public void deleteProject(Map<String, Object> map) {
		delete("project.deleteProjectUser", map);
		delete("project.deleteProject", map);
	}


	/**
	 * activity 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 6. 7.
	 */
	public void deleteActivity(Map<String, Object> map) {
		delete("project.deleteActivityUser", map);
		delete("project.deleteActivity", map);
	}



	/**
	 * 개인별 activity list (타임시트 사용)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 6. 9.
	 */
	public List<Map> getUserActivityListForTimesheet(Map<String, Object> map) {

		return list("project.selectUserActivityListForTimesheet", map);
	}

	/**
	 * 공통프로젝트조회(BASE)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<Map> getBaseCommonProject(Map<String, String> param) throws Exception{

		List<Map> list = list("project.getBaseCommonProject", param);

		return list;
	}

	/**
	 * 공통엑티비티조회(BASE)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<Map> getBaseCommonActivity(Map<String, String> param) throws Exception{

		List<Map> list = list("project.getBaseCommonActivity", param);

		return list;
	}
	/**
	 * 공통프로젝트조회(지출,구매)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<Map> getBaseCommonProjectForCard(Map<String, String> param) throws Exception{

		List<Map> list = list("project.getBaseCommonProjectForCard", param);

		return list;
	}

	/**
	 * 공통엑티비티조회(지출,구매)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<Map> getBaseCommonActivityForCard(Map<String, String> param) throws Exception{

		List<Map> list = list("project.getBaseCommonActivityForCard", param);

		return list;
	}

	/**
	 * 공통프로젝트조회(BASE)- 스케줄 조회용
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<Map> getBaseCommonProjectForScheSearch(Map<String, String> param) throws Exception{

		List<Map> list = list("project.getBaseCommonProjectForScheSearch", param);

		return list;
	}

	/**
	 * 공통엑티비티조회(BASE)- 스케줄 조회용
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<Map> getBaseCommonActivityForScheSearch(Map<String, String> param) throws Exception{

		List<Map> list = list("project.getBaseCommonActivityForScheSearch", param);

		return list;
	}

	//마감일에 대한 데이터 조회
	public Map<String, Object> chkCloseDateInfo(Map<String, Object> map) throws Exception{

		return (Map)selectByPk("project.chkCloseDateInfo", map);
	}

	/**
	 * 출장비, 구매품의 ,교육품의,지출 프로젝트 금액 벨리데이션
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public EgovMap getProjectExpenseValid(Map<String, String> map) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("project.getProjectExpenseValid", map);
	}

	/**
	 * 지출 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		:
	 * @date		:
	 */
	public List<Map> getExpenseList(Map<String, Object> mParam) throws Exception{

		return list("project.getExpenseList", mParam);
	}

	/**
	 * 지출 리스트 건수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		:
	 * @date		:
	 */
	public int getExpenseListCount(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("project.getExpenseListCount", param).toString());
	}

	/**
	 * 프로젝트 복사
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int copyProject(Map<String, Object> map) throws Exception{
		int key = -1;
		String newProjectCode = selectByPk("project.getNewProjectCode", map).toString();
		map.put("projectCode", newProjectCode);

		Object rslt = insert("project.copyProject", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}

	/**
	 * 프로젝트 참여자 복사
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public void copyProjectUser(Map<String, Object> map) throws Exception{
		insert("project.copyProjectUser", map);
	}


	/**
	 *  엑티비티 복사
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int copyActivity(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt = insert("project.copyActivity", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}

	/**
	 * 엑티비티 참여자 복사
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public void copyActivityUser(Map<String, Object> map) throws Exception{
		insert("project.copyActivityUser", map);
	}

	/************************************************************************************
	 * 기본 프로젝트
	 ************************************************************************************/

	//기본프로젝트 조회
	public List<Map> getBaseProjectList(Map<String, Object> map) throws Exception {
		return list("project.getBaseProjectList", map);
	}
	//기본액티비티 조회
	public List<Map> getBaseActivityList(Map<String, Object> map) throws Exception {
		return list("project.getBaseActivityList", map);
	}

	/**
	 * 프로젝트 ID 값 구하기
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public EgovMap getBaseProjectId(Map<String, Object> map) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("project.getBaseProjectId", map);
	}

	/**
	 * 기본프로젝트 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 15.
	 */
	public EgovMap getBaseProjectInfo(Map map) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("project.getBaseProjectInfo", map);
	}


	/**
	 * 프로젝트 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public void updateBaseProject(Map<String, Object> map) throws Exception{
		update("project.updateBaseProject", map);
	}

	/**
	 * Activity 등록 (MERGING)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 14.
	 */
	public int mergeBaseActivity(Map<String, Object> map) throws Exception{

		List<Map> pEmpList = new ArrayList<Map>();					//프로젝트별 배정 직원정보 등록을 위한 LIST 선언
		List list = (ArrayList<Map>)map.get("aList");
		int cnt = list.size();
		if(cnt > 0){			//저장할 것이 있을때
			for(int i=0; i<cnt; i++) {
				Map param = (Map)list.get(i);
				Object rslt = insert("project.mergeBaseActivity", param);		//새로 구성된 구조 저장 insert or update (액티비티 저장)
			}//for
		}//if

		return 0;
	}

	/**
	 * 프로젝트 상태변경(보류,중단,보류취소,중단취소)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int updateProjectStatus(Map<String, Object> map) throws Exception{
		return update("project.updateProjectStatus", map);
	}

	/**
	 * 프로젝트 현황별 리스트 (프로젝트 현황 디테일 화면)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 24.
	 */
	public List<Map> searchProjectStatusList(Map map) throws Exception{

		return list("project.searchProjectStatusList", map);
	}

	/**
	 *  전자계약 : 기본양식 : 프로젝트 조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 24.
	 */
	public List<EgovMap> getAppvProjectList(Map<String,Object> map) throws Exception{
		return list("project.getAppvProjectList", map);
	}

	/**
	 * 전자계약 : 기본양식 : 프로젝트 조회 총개수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public Integer getAppvProjectListTotalCnt(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("project.getAppvProjectListTotalCnt", map);
	}
	/**
	 * 지출 일괄 비차감 처리
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public Integer insertProcessNonExpenseAll(Map map) throws Exception{
    	return (Integer)insert("project.insertProcessNonExpenseAll", map);
    }
    /**
	 * 지출 차감 처리
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public Integer insertProjectExpense(Map map) throws Exception{
    	return (Integer)insert("project.insertProjectExpense", map);
    }

    /**
	 * 지출 관련 상세 팝업 열람 권한 체크(전자결재)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public Integer getValidProjectExpenseViewForApprove(Map map) throws Exception{
    	return (Integer)getSqlMapClientTemplate().queryForObject("project.getValidProjectExpenseViewForApprove", map);
    }
	 /**
	 * /지출 관련 상세 팝업 열람 권한 체크(지출)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public Integer getValidProjectExpenseViewForCard(Map map) throws Exception{
    	return (Integer)getSqlMapClientTemplate().queryForObject("project.getValidProjectExpenseViewForCard", map);
    }

	/**
	 * 프로젝트현황 > wbs summarymap
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 15.
	 */
	public List<EgovMap> searchWbsSummaryMapList(Map map) throws Exception{
		return list("project.searchWbsSummaryMapList", map);
	}

	/**
	 * 해당 연도의 업무를 조회한다
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 15.
	 */
	public List<EgovMap> getWbsWorkSearchList(Map map) throws Exception{
		return list("project.getWbsWorkSearchList", map);
	}

	/**
	 * 해당 연도의 업무 진척율을 조회한다
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 15.
	 */
	public EgovMap getWbsWorkActivityTotMap(Map map) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("project.getWbsWorkActivityTotMap", map);
	}

	/**
	 * 프로젝트의 activity 리스트조회(WBS)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 15.
	 */
	public List<Map<String,Object>> getActivityListForWbs(Map map) throws Exception{
		return list("project.getActivityListForWbs", map);
	}

	/**
	 * 엑티비티 상세 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int updateActivityForWbs(Map<String, Object> map) throws Exception{
		return update("project.updateActivityForWbs", map);
	}

	/**
	 * 엑티비티 진척율 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int deleteActivityProgress(Map<String, Object> map) throws Exception{
		return delete("project.deleteActivityProgress", map);
	}

	/**
	 * 엑티비티진척율 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public Integer insertActivityProgress(Map<String, Object> map) throws Exception{
		return (Integer)insert("project.insertActivityProgress", map);
	}

	/**
	 * 엑티비티수정 내역 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public Integer insertActivityHist(Map<String, Object> map) throws Exception{
		int key = -1;
		Object rslt =(Integer)insert("project.insertActivityHist", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}

	/**
	 * 엑티비티 유저삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int deleteActivityUser(Map<String, Object> map) throws Exception{
		return delete("project.deleteActivityUser", map);
	}

	/**
	 * 엑티비티 유저삭제(엑티비티 아이디 기준)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int deleteActivityUser2(Map<String, Object> map) throws Exception{
		return delete("project.deleteActivityUser2", map);
	}

	/**
	 * 엑티비티유저 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public void mergeActivityUser(Map<String, Object> map) throws Exception{
		insert("project.mergeActivityUser", map);
	}

	/**
	 * 수정내역조회 총개수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public Integer viewActivityUpdateHistTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("project.viewActivityUpdateHistTotalCnt", paramMap);
	}
	/**
	 * 수정내역조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public List<EgovMap> viewActivityUpdateHist(Map<String,Object> paramMap) throws Exception{
		return list("project.viewActivityUpdateHist", paramMap);
	}
	/**
	 * 엑티비티 일정 상세 팝업(WBS)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public List<EgovMap> getWbsActivityViewMonthList(Map<String,Object> paramMap) throws Exception{
		return list("project.getWbsActivityViewMonthList", paramMap);
	}


	/**
	 * 진척율 리셋
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public int deleteActivityProgressRate(Map<String, Object> map) throws Exception{
		return delete("project.deleteActivityProgressRate", map);
	}

	/**
	 * 엑티비티유저 수정 hist등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 22.
	 */
	public Integer insertActivityUserHist(Map<String, Object> map) throws Exception{
		return (Integer)insert("project.insertActivityUserHist", map);
	}

	/**
	 *  wbs조회화면 프로젝트의 정보를 조회한다.
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 13.
	 */
	public List<EgovMap> getProjectWbsList(Map<String,Object> map) throws Exception{
		return list("project.getProjectWbsList", map);
	}
	/**
	 *  wbs조회화면 엑티비티의 정보를 조회한다.
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 13.
	 */
	public List<EgovMap> getActivityWbsList(Map<String,Object> map) throws Exception{
		return list("project.getActivityWbsList", map);
	}
	/**
	 *  wbs조회화면 프로젝트의 정보를 조회 총개수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 13.
	 */
	public Integer getProjectWbsListTotalCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("project.getProjectWbsListTotalCnt", paramMap);
	}

	/**
	 *  MY단위업무 프로젝트 검색
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 13.
	 */
    public List<EgovMap> getMyWorkProjectList(Map<String, Object> map) throws Exception{

    	return list("project.getMyWorkProjectList", map);
    }

    /**
	 * My단위업무 Activity조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 13.
	 */
    public List<EgovMap> getProjectMyWorkActivity(Map<String, Object> map) throws Exception{

    	return list("project.getProjectMyWorkActivity", map);
    }

    /**
	 * My 단위업무 > 프로젝트 우선순위삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 13.
	 */
	public void deleteProjectUserRank(Map<String, Object> map) {
		delete("project.deleteProjectUserRank", map);
	}
	/**
	 *  프로젝트 or 액티비티 등록 업무,일정,전자결재 날짜조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 11.
	 */
	public List<EgovMap> getEditMinMaxDate(Map<String, Object> map) throws Exception{
		return list("project.getEditMinMaxDate", map);
	}

	/**
	 *  프로젝트 우선순위
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 12.
	 */
	public void saveSort(Map<String, Object> map) throws Exception{
		update("project.saveSort", map);
	}

	/**
	 * 지켜보는직원 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
	public Integer insertViewEntryUser(Map<String, Object> map) throws Exception{
		return (Integer)insert("project.insertViewEntryUser", map);
	}

	/**
	 * 지켜보는직원 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
	public void deleteViewEntryUser(Map<String, Object> map) throws Exception{
		delete("project.deleteViewEntryUser", map);
	}

	 /**
	 *  지켜보는 직원 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */

	public List<EgovMap> getViewEntryList(Map<String, Object> map) throws Exception{

		return list("project.getViewEntryList", map);
	}

	/**
	 * 프로젝트 히스토리 기록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
	public Integer insertProjectHistroy(Map<String, Object> map) throws Exception{
		return (Integer)insert("project.insertProjectHistroy", map);
	}

	/**
	 *   프로젝트 유저 수정 hist등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
	public Integer insertProjectUserHist(Map<String, Object> map) throws Exception{
		return (Integer)insert("project.insertProjectUserHist", map);
	}

	/**
	 *   프로젝트 유저 수정 hist등록 (한번에)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 18.
	 */
	public Integer insertProjectUserHistAll(Map<String, Object> map) throws Exception{
		return (Integer)insert("project.insertProjectUserHistAll", map);
	}


	 /**
	 *  프로젝트 히스토리 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */

	public List<EgovMap> getProjectHistoryList(Map<String, Object> map) throws Exception{

		return list("project.getProjectHistoryList", map);
	}

	 /**
	 *  프로젝트 히스토리 리스트 갯수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
	public Integer getProjectHistoryListCnt(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("project.getProjectHistoryListCnt", map);

	}

	//-------------------메소드로 뺌 sjy 2017. 10. 19.

	//새로 구성된 구조 저장 insert or update (액티비티 저장)
	public Object mergeActivity(Map<String, Object> map) throws Exception{

		return insert("project.mergeActivity", map);

	}

	//activity 별 직원배정 삭제(enable 'N', default 'N')
	public void updateDisableActivityUser(Map<String, Object> map) throws Exception{

		update("project.updateDisableActivityUser", map);

	}

	//parent_id 일괄추가수정
	public void updateActivityParentId(Map<String, Object> map) throws Exception{

		update("project.updateActivityParentId", map);

	}

	//project 유저 삭제
	public void deleteProjectUser(Map<String, Object> map) throws Exception{

		delete("project.deleteProjectUser", map);

	}

	//project 별 직원배정 삭제(enable 'N')
	public void updateDisableProjectUser(Map<String, Object> map) throws Exception{

		update("project.updateDisableProjectUser", map);

	}

	//project 별 직원배정 등록
	public void mergeProjectUser(Map<String, Object> map) throws Exception{

		insert("project.mergeProjectUser", map);

	}
	/**
	 * My 단위업무 > 프로젝트 우선순위저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2017. 10. 13.
	 */
	public Integer insertProjectUserRank(Map<String, Object> map) throws Exception{
		return (Integer)insert("project.insertProjectUserRank", map);
	}

	/**
	 * 우선순위 체크
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 23.
	 */
	public Integer sortChk(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("project.sortChk", map);
	}

	/**
	 *  엑티비티 수정 전 프로젝트 메모발송 여부를 체크한다(임시저장,보류,중단을 제외한 프로젝트 cnt)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 13.
	 */
	public Integer chkProjectIngCnt(Map<String,Object> paramMap) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("project.chkProjectIngCnt", paramMap);
	}
	/**
	 *  프로젝트 참여자 정리
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: psj
	 * @date		: 2017. 10. 13.
	 */
	public void deleteProjectUserForActivityInfo(Map<String,Object> paramMap) throws Exception{
		delete("project.deleteProjectUserForActivityInfo", paramMap);
	}

}