package ib.personnel.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ManagementService {

	////////////park add method :S////////////////////////////////////
	//인사관리리스트
	public List<EgovMap> getAccessOrgUserList(Map<String,Object> paramMap) throws Exception;
	//검색가능한 부서 가져오기
	public List<EgovMap> getAccessOrgDeptUserList(Map<String,Object> paramMap) throws Exception;
	//사용자의 상세정보를 조회한다
	public EgovMap getPersonnelDetail(Map<String,Object> paramMap) throws Exception;
	//사용자의 퇴직/해고 정보를 가져온다.
	public EgovMap getUserSttsHistFireInfo(Map<String,Object> paramMap) throws Exception;
	//사용자의 직급사항을 조회한다
	public List<EgovMap> getuserInsideCareer(Map<String,Object> paramMap) throws Exception;
	//사용자의 가족관계를 조회한다.
	public List<EgovMap> getUserFamily(Map<String,Object> paramMap) throws Exception;
	//사용자의 학력사항을 조회한다
	public List<EgovMap> getUserAcademic(Map<String,Object> paramMap) throws Exception;
	//사용자의경력사항을 조회한다
	public List<EgovMap> getUserCareer(Map<String,Object> paramMap) throws Exception;
	//사용자의 자격증을 조회한다
	public List<EgovMap> getUserLicense(Map<String,Object> paramMap) throws Exception;
	//사용자의 부서리스트를
	public List<EgovMap> getUserDeptList(Map<String,Object> paramMap) throws Exception;
	//사용자의 재직상태 히스토리 검색
	public List<EgovMap> getUserSttsHist(Map<String,Object> paramMap) throws Exception;
	//사용자 수정
	public Integer processPersonnerInfo(Map<String,Object> paramMap,ManagementPersonnelListVO arrVo) throws Exception;
	//직급 변경 , 재직상태변경:batch
	public void updateUserInfoBatch(Map<String,Object> paramMap) throws Exception;

	//연차관리 목록
	public List<EgovMap> getAnnualUserList(Map<String,Object> paramMap) throws Exception;

	//연차저장
	public int doSaveUserLeaveH(Map<String,Object> paramMap) throws Exception;

	//출근부생성:batch
	public void insertWorkTime(Map<String,Object> paramMap) throws Exception;

	//현재시간조회
	public Date getCurTimeInfo() throws Exception;

	//오늘의 출근정보 조회
	public EgovMap getTodayWorkInfo(Map<String,Object> paramMap) throws Exception;
	//출근처리
	public int processWorcAjax(Map<String,Object> paramMap) throws Exception;
	//퇴근처리
	public int processWorcEndAjax(Map<String,Object> paramMap) throws Exception;
	//로그인 이력 저장
	public int processLoginHist(Map<String,Object> paramMap) throws Exception;

	//로그인 이력 리스트
	public List<EgovMap> getLoginHistList(Map<String,Object> paramMap) throws Exception;

	//새글알림설정 리스트
	public List<EgovMap> markRuleListList(Map<String,Object> paramMap) throws Exception;
	//새글알림설정 저장
    public Integer processMarkRule(Map<String,Object> map) throws Exception;
    // 퀵링크 저장/수정
    public Integer processQuickLink(Map<String,Object> map) throws Exception;
    // 퀵링크 삭제
    public Integer deleteQuickLink(Map<String,Object> map) throws Exception;

    //org별 퀵링크 조회
    public List<EgovMap> getQuickLinkList(Map<String,Object> map) throws Exception;
}
