package ib.system.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

@Repository("certificationRqmtDAO")
public class CertificationRqmtDAO  extends ComAbstractDAO{


	protected static final Log logger = LogFactory.getLog(CertificationRqmtDAO.class);

	// 증명서 발급 내역 리스트
	@SuppressWarnings("rawtypes")
	public List getCertDocRqmtList(Map map) throws Exception {
		return list("certification.getCertDocRqmtList", map);
	}

	// 선택된 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public Map getPerInfo(Map map) throws Exception {
		return (Map)super.getSqlMapClientTemplate().queryForObject("certification.getPerInfo", map);
	}

	// 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getPerList(Map param) throws Exception {
		return list("certification.getPerList", param);
	}

	// 퇴사자 포함 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getAllPerList(Map param) throws Exception {
		return list("certification.getAllPerList", param);
	}


	//증명서 : 회사구분 가져오기 (본사인 경우만 사용됨)
	public Map getComInfoForSynergy(Map param) throws Exception{
		return (Map) getSqlMapClientTemplate().queryForObject("certification.getComInfoForSynergy", param);
	}

	//증명서 상세정보 반환
	public Map getCertDocView(Map map) throws Exception{
		return (Map) getSqlMapClientTemplate().queryForObject("certification.getCertDocView", map);
	}

	//증명서 상태 수정.
	public void updateCertDocStatus(Map map) throws Exception{
		update("certification.updateCertDocStatus", map);
	}

	//증명서 취소
	public void cancelCertDoc(Map map) throws Exception{
		super.update("certification.cancelCertDoc",map);
	}

	//증명서 반려
	public void returnCertDoc(Map map) throws Exception{
		super.update("certification.returnCertDoc",map);
	}

	//증명서 요청
	public int insertCertDoc(Map map) throws Exception{
		int key = -1;
		Object rslt =(Integer)insert("certification.insertCertDoc" ,map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;

	}

	//경력증명서 관리자 처리
	public void certDocReqProc(Map map) throws Exception{
		update("certification.certDocReqProc" ,map);
	}

	//관계사 리스트 반환 (사용자가 권한 가진 관계사만)
	public List<Map> getOrgListByUser(Map param) throws Exception{
		return list("certification.getOrgListByUser", param);
	}

	//증명서를 위한 관계사 정보 반환
	public Map getOrgCompanyInfo(Map param) throws Exception{
		return (Map) super.getSqlMapClientTemplate().queryForObject("certification.getOrgCompanyInfo", param);
	}
}
