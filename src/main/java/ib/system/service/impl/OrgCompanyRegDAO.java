package ib.system.service.impl;

import ib.basic.web.Commoncodeset;
import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class OrgCompanyRegDAO  extends ComAbstractDAO{

	protected static final Log logger = LogFactory
			.getLog(OrgCompanyRegDAO.class);

	//관계사 회사정보 리스트
	public List<Map> getOrgCompanyList(Map param) throws Exception{
		return  list("orgCompany.getOrgCompanyList",param);
	}

	//관계사 회사 총갯수
	public int getOrgCompanyTotalCnt(Map param) throws Exception{
		return  (Integer) super.getSqlMapClientTemplate().queryForObject("orgCompany.getOrgCompanyTotalCnt",param);
	}

	//ib_staff+관계사 회사정보 리스트
	public List<Map> getIbCompanyList(Map param) throws Exception{
		return  list("orgCompany.getIbCompanyList",param);
	}

	//ib_staff+관계사 회사 총갯수
	public int getIbCompanyTotalCnt(Map param) throws Exception{
		return  (Integer) super.getSqlMapClientTemplate().queryForObject("orgCompany.getIbCompanyTotalCnt",param);
	}

	// 관계사 정보저장
	public int insertBsOrg(Map param) throws Exception{
		return (Integer) insert("orgCompany.insertBsOrg", param);
	}

	//관계사 정보 수정
	public void updateBsOrg(Map param) throws Exception{
		update("orgCompany.updateBsOrg",param);
	}

	//관계사 달력데이터 출퇴근시간 업데이트
	public void updateBsCalendarForInTime(Map param) throws Exception{
		update("orgCompany.updateBsCalendarForInTime",param);
	}

	//관계사 정보 삭제
	public void deleteBsOrg(Map param) throws Exception{
		update("orgCompany.deleteBsOrg",param);
	}

	//관계사 정보 반환
	public Map selectBsOrgCompany(Map param) throws Exception{
		return  (Map) super.getSqlMapClientTemplate().queryForObject("orgCompany.selectBsOrgCompany",param);
	}

	//비즈니스 그룹 지우기(businessGrpSeq)
	public void deleteBsBusinessGrp(Map param) throws Exception{
		update("orgCompany.deleteBsBusinessGrp",param);
	}

	//비즈니스 그룹 수정하기
	public void updateBsBusinessGrp(Map param) throws Exception{
		update("orgCompany.updateBsBusinessGrp",param);
	}

	//비즈니스 그룹 저장
	public int insertBsBusinessGrp(Map param) throws Exception{
		return (Integer) insert("orgCompany.insertBsBusinessGrp", param);
	}

	//달력등록 프로시저 호출
	public void addCalendarData(Map param) throws Exception{
		 insert("orgCompany.doCalendarDate", param);
	}

	//관계사 등록 전 같은 그룹내에 이미 등록 되어있는지 체크함.
	public int checkOrgCompany(Map param) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("orgCompany.checkOrgCompany", param);
	}

	//비즈니스 그룹 리스트 반환.
	public List<Map> getBusinessGroupList(Map param) throws Exception{
		return list("orgCompany.getBusinessGroupList", param);
	}

	//비즈니스 그룹 리스트 총 갯수
	public int getBusinessGroupTotalCnt(Map param) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("orgCompany.getBusinessGroupTotalCnt", param);
	}

	//비즈니스 그룹(selectbox) 반환
	public List<Map> getBusinessGroupForSelect(Map param) throws Exception{
		return list("orgCompany.getBusinessGroupForSelect", param);
	}

	//IB_COMPANY 정보 수정.
	public void updateIbCompanyInfo(Map param) {
		// TODO Auto-generated method stub
		update("orgCompany.updateIbCompanyInfo", param);
	}

	//사용자 관계사 권한 지정을 위하 관계사 리스트(소속회사 제외)
	public List<Map> getOrgCompanyAuthList(Map param) throws Exception{
		return list("orgCompany.getOrgCompanyAuthList", param);
	}

	//관계사에 소속된 소속회사 정보 반환
	public List<Map> selectBsIncludeOrgCompany(Map param) throws Exception{
		return list("orgCompany.selectBsIncludeOrgCompany", param);
	}

	//관계사별 사용자 권한 지정을 위한 셀렉트 박스
	public List<Map> getOrgCompanyAuthSelectbox(Map param) throws Exception{
		return list("orgCompany.getOrgCompanyAuthSelectbox", param);
	}

	//관계사별 사용자 권한 리스트 총 갯수
	public int getOrgCompanyAuthUserCnt(Map param) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("orgCompany.getOrgCompanyAuthUserCnt", param);
	}


	//관계사별 사용자 권한 리스트
	public List<Map> getOrgCompanyAuthUserList(Map param) throws Exception{
		return list("orgCompany.getOrgCompanyAuthUserList", param);
	}

	//사용자별 관계사 권한 목록
	public List<Map> getOrgRelationAuthList(Map param) throws Exception{
		return list("orgCompany.getOrgRelationAuthList", param);
	}

	//관계사 접근권한 삭제
	public void deleteBsRelationCompanyAccess(Map param) throws Exception{
		delete("orgCompany.deleteBsRelationCompanyAccess", param);
	}

	//관계사 접근권한 저장.
	public void insertBsRelationCompanyAccess(Map param) throws Exception{
		insert("orgCompany.insertBsRelationCompanyAccess", param);
	}

	//사용자별 접근권한 있는 관계사 리스트 반환
	public List<Map> getOrgRelationAuthListOnlyUserId(Map param) throws Exception{
		return list("orgCompany.getOrgRelationAuthListOnlyUserId",param);
	}

	//관계사 코드 중복 여부 체크
	public int checkOrgCompanyCode(Map param) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("orgCompany.checkOrgCompanyCode", param);
	}

	//관계사 등록 - 관계사 소속회사 리스트 반환
	public List<Map> addGroupingCompanyList(Map param) {
		// TODO Auto-generated method stub
		return list("orgCompany.addGroupingCompanyList", param);
	}

	//관계사 등록 - 관계사 소속회사 리스트 갯수
	public int addGroupingCompanycnt(Map param) throws Exception{
		return (Integer) super.getSqlMapClientTemplate().queryForObject("orgCompany.addGroupingCompanyListCnt", param);
	}

	//관계사 등록 - 관계사 소속회사
	public void updateGroupingOrgInfo(Map param) throws Exception{
		// TODO Auto-generated method stub
		update("orgCompany.updateGroupingOrgInfo", param);

	}

	//관계사 등록 - 관계사 소속회사 정보 초기화
	public void updateGroupingOrgInfoRefresh(Map param) throws Exception{
		update("orgCompany.updateGroupingOrgInfoRefresh", param);
	}

	//관계사 등록 - 공통코드 정보 입력
	public int insertCodeSet(Commoncodeset param) throws Exception{
		return (Integer) insert("orgCompany.insertCodeSet", param);
	}

	//관계사 등록 - 공통리스트 정보 입력
	public int insertCodeList(Commoncodeset param) throws Exception{
		return (Integer) insert("orgCompany.insertCodeList", param);
	}

	//관계사 정보 체크 - 오늘일자로 등록된 관계사가 있는지 체크함.
	public int checkOrgList(Map param) throws Exception{
		// TODO Auto-generated method stub
		return (Integer) super.getSqlMapClientTemplate().queryForObject("orgCompany.checkOrgList", param);
	}



	//BS_CODE_SET, BS_CODE_LIST 카피
	public void copyBsCodeByOrg(Map codeMap) throws Exception{

		update("orgCompany.copyBsCodeSet", codeMap);			//BS_CODE_SET 카피
		update("orgCompany.copyBsCodeSetParent", codeMap);		//BS_CODE_SET	PARENT_SET_ID 있는것 카피
		update("orgCompany.copyBsCodeList", codeMap);			//BS_CODE_LIST 카피
		update("orgCompany.copyBsCodeListSon", codeMap);		//BS_CODE_LIST SON_SET_ID 있는것 카피
		update("orgCompany.copyBsCodeSetForBusiness", codeMap);	//CODE_GROUP (MASTER 중 영업관리 페이지 로딩을위해 필요한 INFO_TYPE,INFO_PROGRESS,INFO_PATH 만 카피)
	}

	// 관계사 권한 등록
	public void insertRoleListForOrg(Map param) throws Exception{
		insert("orgCompany.insertRoleListForOrg", param);
	}

	// 관계사 권한별 메뉴 등록
	public void insertRoleMenuListForOrg(Map param) throws Exception{
		insert("orgCompany.insertRoleMenuListForOrg", param);
	}

	// 관계사 권한별 모듈 등록
	public void insertRoleModuleListForOrg(Map param) throws Exception{
		insert("orgCompany.insertRoleModuleListForOrg", param);
	}

	// 관계사 구대표님 READ, 천경민이사님 READ, 시너지시스템관리자에게 WRITE 권한 추가
	public void insertUserRoleListForOrg(Map param) throws Exception{
		insert("orgCompany.insertUserRoleListForOrg", param);
	}

	// 관계사 구대표님 READ, 천경민이사님 READ, 시너지시스템관리자에게 WRITE 권한 추가2
	public void insertRelationCompanyAccessAuthForOrg(Map param) throws Exception{
		insert("orgCompany.insertRelationCompanyAccessAuthForOrg", param);
	}

	//관계사 신규등록된 시스템기획팀 ROLE_ID
	public String getRoleIdBySystem(Map param) throws Exception{
		return (String) super.getSqlMapClientTemplate().queryForObject("orgCompany.getRoleIdBySystem", param);
	}

	//기본 네트워크고객 S_NB
	public String getDefaultCustomerId(Map param) throws Exception{
		return (String) super.getSqlMapClientTemplate().queryForObject("orgCompany.getDefaultCustomerId", param);
	}

	// 관계사에 메뉴 할당
	public void insertMenuListForOrg(Map param) throws Exception{
		insert("orgCompany.insertMenuListForOrg", param);
	}

	// 관계사에 모듈 할당
	public void insertModuleListForOrg(Map param) throws Exception{
		insert("orgCompany.insertModuleListForOrg", param);
	}
	//관계사별 권한 조회
	public List<EgovMap> getRelationCompanyAccessAuthListForOrg(Map param) throws Exception{
		return list("orgCompany.getRelationCompanyAccessAuthListForOrg", param);
	}
}
