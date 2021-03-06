package ib.user.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface UserService {

	//로그인시 사용자 정보
	public Map<String, Object> getUserLoginInfo(Map<String, Object> map) throws Exception;

	//로그인시 사용자 정보
	public Map<String, Object> getBaseUserInfo(Map<String, Object> map) throws Exception;

    //String searchPassword(LoginVO vo) throws Exception;

	public List<Map> getUserList(Map<String, Object> map) throws Exception;

	public List<Map> getCompanyCode(Map<String, String> map) throws Exception;

	//사용자등록(신규)
	public int insertUser(Map<String, Object> map) throws Exception;

	//사용자등록(수정)
	public int updateUser(Map<String, Object> map) throws Exception;

	//신규 사원번호
	public String getNewUserNo(String string) throws Exception;

	//비밀번호 초기화
	public int doInitPwd(Map<String, Object> map) throws Exception;

	//조회 권한이 있는 관계사 리스트
	public List<Map> getAccessOrgIdList(Map baseInfo) throws Exception;

	//전체 관계사 목록
	public List<Map> getOrgIdList(String userId) throws Exception;

	//요청 orgId 의 권한이 있는지 체크
	public Integer getAccessOrgIdCnt(Map<String, Object> map) throws Exception;

	//같은 비즈니스 그룹에 속하는 회사 리스트 반환.
	public 	Map getCompanyByGroupingList(Map<String, Object> param) throws Exception;

	//사용자 등록시 사번 체크 및 관계사 코드 반환
	public Map getOrgPersabun(Map param) throws Exception;

	//사용자 등록 - 소속 관계사 리스트
	public Map getAccessOrgInfoList(Map<String, Object> param) throws Exception;

	//관계사 세부 정보 반환 - 관계사 코드 및 그룹핑 관계사 정보
	public Map getOrgInfoForGrouping(Map<String, Object> map)  throws Exception;
	//사용자 메인화면모듈리스트
	public List<EgovMap> getModuleList(Map<String,Object> map) throws Exception;


	//사용자 메인화면모듈리스트(171123 PSJ 추가..............)
	public List<EgovMap> getUserModuleList(Map<String,Object> map) throws Exception;

	//로그인 출근 연동여부를 판단하여 출근처리한다.
	public Integer getUserAttendCnt(Map<String,Object> map) throws Exception;
	//유저 그룹관리 팝업에서 관계사 or 부서별 유저 조회
	public List<Map> getOrgOrDeptUserList(Map map ) throws Exception;
	//유저 그룹 생성
	public Integer createUserGroup(Map<String,Object> map) throws Exception;
	//유저 그룹 수정
	public Integer modifyUserGroup(Map<String,Object> map) throws Exception;
	//유저그룹 조회
	public List<Map> getUserGroupList(Map map ) throws Exception;
	//유저 그룹별 사용자 리스트 조회
	public List<Map> getGroupDetailUserList(Map map ) throws Exception;

	//유저 그룹 삭제
	public Integer deleteUserGroup(Map<String,Object> map) throws Exception;
	//유저 그룹 복사
	public Integer copyUserGroup(Map<String,Object> map) throws Exception;
	//유저 그룹 유저 삭제/복사
	public Integer procUserGroupDetail(Map<String,Object> map) throws Exception;
	//유저 그룹 순서변경
	public Integer procUserGroupSortOrder(Map<String,Object> map) throws Exception;
	//유저 프로필박스
	public EgovMap getUserProfile(Map map ) throws Exception;

	//메인 유저 모듈 순번 처리
	public Integer processUserMainModule(Map<String,Object> map) throws Exception;

	/**
	 * 사용자 validation체크
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 20.
	 */
	public int chkValidation(Map<String, Object> map) throws Exception;

}
