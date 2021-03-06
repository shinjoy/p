package ib.project.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package	: ibiss.project.service
 * filename	: ProjectMgmtService.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 10. 16.
 * @version :
 *
 */
public interface ProjectMgmtService {

	//프로젝트 리스트
	Map<String, Object> getProjectList(Map<String, Object> map) throws Exception;

	//프로젝트 등록(프로젝트 + activity)
	int insertProject(Map<String, Object> map) throws Exception;
	//기본 프로젝트 등록(프로젝트 + activity)
	void insertBaseProject(Map<String, Object> map) throws Exception;

	//프로젝트 수정(프로젝트 + activity)
	void updateProject(Map<String, Object> map) throws Exception;

	//프로젝트 정보
	List<Map> getProjectInfo(Map<String, Object> map) throws Exception;

	//activity 리스트
	List<Map> getActivityList(Map map) throws Exception;

	//개인별 기본 project 및 activity 등록
	int changeUserDefaultPjtAct(Map<String, Object> map) throws Exception;

	//개인별 프로젝트 리스트
	Map<String, Object> getUserProjectList(Map<String, Object> map) throws Exception;

	//개인별 프로젝트 정보
	List<Map> getUserProjectInfo(Map<String, Object> map) throws Exception;

	//개인별 activity 리스트
	List<Map> getUserActivityList(Map map) throws Exception;

	//프로젝트 수정(프로젝트 + activity 직원배정 정보 저장)
	void updateProjectUserAlloc(Map<String, Object> map) throws Exception;

	//프로젝트 삭제(프로젝트 + activity)
	void deleteProject(Map<String, Object> map) throws Exception;

	//개인별 activity list (타임시트 사용)
	List<Map> getUserActivityListForTimesheet(Map<String, Object> map) throws Exception;

	//프로젝트/엑티비티 조회 (공통js)
	List<Map> getBaseCommonProject(Map<String, String> map) throws Exception;

	//마감일에 대한 데이터 조회
	Map<String, Object> chkCloseDateInfo(Map<String, Object> map) throws Exception;

	//출장비, 구매품의 ,교육품의,지출 프로젝트 금액 벨리데이션
	EgovMap getProjectExpenseValid(Map<String, String> map) throws Exception;

	//지출 리스트
	Map<String, Object> getExpenseList(Map<String, Object> map) throws Exception;

    // activity 배정직원 리스트
	List<Map> getActivityUserList(Map map) throws Exception;

	//프로젝트 수정(프로젝트 + activity)
	int copyProject(Map<String, Object> map) throws Exception;

	/************************************************************************************
	 * 기본 프로젝트
	 ************************************************************************************/

	//프로젝트 ID 값 구하기
	EgovMap getBaseProjectId(Map<String, Object> map) throws Exception;

	//프로젝트 정보
	EgovMap getBaseProjectInfo(Map<String, Object> map) throws Exception;

	//activity 리스트
	List<Map> getBaseActivityList(Map map) throws Exception;

	//프로젝트 수정(프로젝트 + activity)
	void updateBaseProject(Map<String, Object> map) throws Exception;

	//프로젝트 상태변경(보류,중단,보류취소,중단취소)
	int processStatus(Map<String, Object> map) throws Exception;

	// 프로젝트 배정직원 리스트
    List<Map> getProjectUserList(Map map) throws Exception;

    // 프로젝트 현황별 리스트 (프로젝트 현황 디테일 화면)
    List<Map> searchProjectStatusList(Map map) throws Exception;

	/************************************************************************************
	 * 전자계약 : 기본양식 : 프로젝트 조회
	 ************************************************************************************/
    List<EgovMap> getAppvProjectList(Map<String,Object> map) throws Exception;

    //지출 일괄 비차감 처리
    Integer processNonExpenseAll(Map map) throws Exception;

    //지출 차감 처리
    Integer processExpense(Map map) throws Exception;

    //지출 관련 상세 팝업 열람 권한 체크
    String getValidProjectExpenseView(Map map) throws Exception;

    //프로젝트 공통 트리에서 조회
  	List<Map> getProjectTreeList(Map<String, Object> map) throws Exception;

  	//프로젝트현황 > wbs summarymap
  	List<EgovMap> searchWbsSummaryMapList(Map<String, Object> map) throws Exception;

  	//해당 연도의 업무를 조회한다
  	List<EgovMap> getWbsWorkSearchList(Map<String, Object> map) throws Exception;

  	//해당 연도의 업무 진척율을 조회한다
  	EgovMap getWbsWorkActivityTotMap(Map<String, Object> map,List<EgovMap> wbsWorkSearchList) throws Exception;

  	//프로젝트 진척율을 조회한다
  	Map<String,Object> getProjectProgressInfo(Map<String, Object> map) throws Exception;

  	//엑티비티 상세 수정
	int updateActivityInfo(Map<String, Object> map) throws Exception;
	//수정내역조회
  	List<EgovMap> viewActivityUpdateHist(Map<String, Object> map) throws Exception;

  	//엑티비티 일정 상세 팝업(WBS)
  	List<EgovMap> getWbsActivityViewMonthList(Map<String, Object> map) throws Exception;

  	 //진척율 리셋
    Integer updateActivityProgressRate(Map<String, Object> map) throws Exception;

    /**
	 *  프로젝트 or 액티비티 등록 업무,일정,전자결재 날짜조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 11.
	 */

  	public List<EgovMap> getEditMinMaxDate(Map<String, Object> map) throws Exception;

  	 /**
	 *  프로젝트 우선순위
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 12.
	 */

  	public void saveSort(Map<String, Object> map) throws Exception;

  	 /**
	 *  지켜보는 직원 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */

  	public void insertViewEntryUser(Map<String, Object> map) throws Exception;

  	 /**
	 *  지켜보는 직원 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */

  	public List<EgovMap> getViewEntryList(Map<String, Object> map) throws Exception;

  	/**
	 *  프로젝트 히스토리 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */

  	public List<EgovMap> getProjectHistoryList(Map<String, Object> map) throws Exception;




    //wbs조회화면 프로젝트의 정보를 조회한다.
    List<EgovMap> getProjectWbsList(Map<String, Object> map) throws Exception;

    //wbs조회화면 엑티비티의 정보를 조회한다.
    List<EgovMap> getProjectWbsActivityList(Map<String, Object> map) throws Exception;

    //MY단위업무 프로젝트 검색
    List<EgovMap> getMyWorkProjectList(Map<String, Object> map) throws Exception;

    //My단위업무 Activity조회
    List<EgovMap> getProjectMyWorkActivity(Map<String, Object> map) throws Exception;

    //My 단위업무 > 프로젝트 우선순위설정
  	void processProjectUserRank(Map<String, Object> map) throws Exception;

  	/**
	 * 우선순위 체크
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 23.
	 */
	public Integer sortChk(Map<String, Object> map) throws Exception;

}
