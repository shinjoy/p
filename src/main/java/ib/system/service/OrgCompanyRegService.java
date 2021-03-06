package ib.system.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface OrgCompanyRegService {

	public Map getOrgCompanyList(Map param) throws Exception;

	public void setOrgCompanyInfo(Map param) throws Exception;

	//관계사로 등록가능한 회사 리스트
	public Map getOrgIbCompanyList(Map param) throws Exception;

	//비즈니스 그룹 리스트 조회
	public Map getBusinessGroupList(Map param) throws Exception;

	//비즈니스 그룹 추가 (등록/수정)
	public void setBusinessGroup(Map param) throws Exception;

	//비즈니스 그룹 삭제
	public void deleteBusinessGroup(Map param)  throws Exception;

	//비즈니스 그룹 명 반환(selectbox)
	public List<Map> getBusinessGroupForSelect(Map param) throws Exception;

	//관계사 삭제하기
	public void deleteOrgCompanyInfo(Map param)  throws Exception;

	//관계사 정보 반환
	public Map selectBsOrgCompany(Map param) throws Exception;

	//관계사 정보 업데이트
	public void updateOrgCompanyInfo(Map param) throws Exception;

	// 관계사 등록된 회사 리스트
	public List<Map> getOrgCompanyAuthList(Map param) throws Exception;

	// 관계사 등록된 회사 셀렉트 박스
	public List<Map> getOrgCompanyAuthSelectbox(Map param) throws Exception;

	// 선택된 관계사에 따른 사용자 리스트 검색
	public Map getUserListForOrgId(Map param) throws Exception;

	// 사용자별 관계사 리스트 (소속 관계사 아이디 제외)
	public List<Map> getOrgRelationAuthList(Map param)  throws Exception;

	//사용자 관계사 별 접근 권한 저장.
	public void setOrgAuthCompany(Map param)  throws Exception;

	//사용자별 관계사 리스트 (only 사용자 아이디)
	public List<Map> getOrgRelationAuthListOnlyUserId(Map paramMap)  throws Exception;

	//관계사 코드 등록 가능 여부 체크
	public Map checkOrgCompanyCode(Map map) throws Exception;

	//관계사 소속회사 리스트
	public Map addGroupingCompanyList(Map param) throws Exception;

	//관계사에 포함된 소속회사 리스트(수정시)
	public List<Map> selectBsIncludeOrgCompany(Map param) throws Exception;

	//오늘 등록된 관계사 정보 반환
	public int checkOrgCompany(Map param) throws Exception;

	//관계사별 권한 조회
	public List<EgovMap> getRelationCompanyAccessAuthListForOrg(Map param) throws Exception;
}
