package ib.basic.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("orgDAO")
public class OrgDAO extends ComAbstractDAO {


	// 조직도의 등록된 회사리스트
	public List<Map> getCompanyStructList(Map param) {
		return list("organization.selectCompanyStructList", param);
	}

	// 조직도의 등록가능 회사리스트
	public List<Map> getCompanyList(Map param) {
		return list("organization.getCompanyList", param);
	}

	// 조직도 회사 등록
	public void insertCompanyStruct(Map param) {
		insert("organization.insertCompanyStruct", param);
	}

	// 조직도 회사 수정
	public void updateCompanyStruct(Map param) {
		update("organization.updateCompanyStruct", param);
	}

	// 조직도의 등록가능 회사리스트
	public void deleteCompanyStruct(Map param) {
		delete("organization.deleteCompanyStruct", param);
	}

	// 선택한 관계사의 부서.
	public List<Map> selectDeptList(Map param) {
		return list("system.selectDeptList", param);
	}

	// 선택한 부서의 인원
	public List<Map> selectDeptUserList(Map param){
		return list("organization.selectUserListOfDept", param);
	}

	// 회사 선택에 따른 회사 정보 반환.
	public Map selectCompInfo(Map param){
		return (Map) super.getSqlMapClientTemplate().queryForObject("organization.selectCompInfo", param);
	}

	//사용자의 상세정보를 조회한다
	public Map getPersonnelDetail(Map<String,Object> paramMap) throws Exception{
		return (Map)getSqlMapClientTemplate().queryForObject("organization.getPersonnelDetail", paramMap);
	}

	//사용자의 학력사항을 조회한다
	@SuppressWarnings("unchecked")
	public List<Map> getUserAcademic(Map<String,Object> paramMap) throws Exception{
		return list("organization.getUserAcademic", paramMap);
	}

	//사용자의경력사항을 조회한다
	@SuppressWarnings("unchecked")
	public List<Map> getUserCareer(Map<String,Object> paramMap) throws Exception{
		return list("organization.getUserCareer", paramMap);
	}

	//사용자의 부서리스트를 조회한다.
	@SuppressWarnings("unchecked")
	public List<Map> getUserDeptList(Map<String,Object> paramMap) throws Exception{
		return list("organization.getUserDeptList", paramMap);
	}

	//인사정보 검색.
	public List<Map> searchUserList (Map map) throws Exception{
		return  list("organization.searchUserList", map);
	}

	//직원 사진 정보 검색
	public Map getFileInfoImage(Map map) throws Exception{
		return (Map) super.getSqlMapClientTemplate().queryForObject("organization.getFileInfoImage", map);
	}
	//User Group 관리 팝업에서 조회하는 조직도...psj
	public List<Map> getOrganizationListInfoList (Map map) throws Exception{
		return  list("organization.getOrganizationListInfoList", map);
	}
}