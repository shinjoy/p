package ib.system.service;

import ib.system.service.impl.CertificationRqmtVO;

import java.util.List;
import java.util.Map;

public interface CertificationRqmtService {

	// 증명서 발급 내역 리스트
	public Map getCertDocRqmtList(Map param) throws Exception;

	// 사원리스트 받아오기
	public List getPerList(Map map) throws Exception;

	// 선택된 사원정보 받아오기
	public Map getPerInfo(Map param) throws Exception;

	// 퇴사자 포함 사원리스트 받아오기
	public List getAllPerList(Map map) throws Exception;

	// 시너지그룹인 경우 회사정보 가져오기
	public Map getComInfoForSynergy(Map param) throws Exception;

	// 증명서 상세정보 반환
	public Map getCertDocView(Map param) throws Exception;

	// 증명서 상태 수정.
	public void updateCertDocStatus(Map param) throws Exception;

	//증명서 취소
	public void cancelCertDoc(Map param) throws Exception;

	//반려
	public void returnCertDoc(Map param) throws Exception;

	//증명서 요청
	public int insertCertDoc(Map param) throws Exception;

	//경력증명서 관리자 처리
	public void certDocReqProc(Map param) throws Exception;

	//선택가능한 관계사 리스트 반환.
	public List<Map> getOrgListByUser(Map map) throws Exception;

	//증명서 발급을 위한 관계사 정보
	public Map getOrgCompanyInfo(Map param) throws Exception;

	// 증명서 발급 내역 리스트 totCnt
	public Integer getCertDocRqmtListCnt(Map param) throws Exception;
}
