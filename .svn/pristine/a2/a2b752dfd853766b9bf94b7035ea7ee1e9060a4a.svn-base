package ib.basic.service;

import java.util.List;
import java.util.Map;

public interface OrgService {

	//조직도의 등록된 회사 리스트
	public List<Map> getCompanyStructList(Map map)  throws Exception;

	//조직도의 등록 가능 회사 리스트
	public List<Map> getCompanyList(Map map)  throws Exception;

	//회사 선택에 따른 부서 리스트 결과
	public List<Map> getDeptListForOrg(Map map)  throws Exception;

	//부서 선택에 따른 사원 리스트 반환
	public List<Map> selectDeptUserList(Map map)  throws Exception;

	//사원 상세 정보 반환
	public Map selectUserDetailInfoForOrg(Map map ) throws Exception;

	//직원명 검색 or 직무명 검색
	public List<Map> searchStaffNmOrWorkForOrg(Map map) throws Exception;

	//조직도 저장
	public void saveCompanyStruct(Map map) throws Exception;

	//조직도 삭제
	public void deleteCompanyStruct(Map map) throws Exception;

	//User Group 관리 팝업에서 조회하는 조직도...psj
	public List<Map> getOrganizationListInfoList(Map map ) throws Exception;
}
