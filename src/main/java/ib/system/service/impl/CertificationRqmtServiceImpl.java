package ib.system.service.impl;

import ib.system.service.CertificationRqmtService;

import java.io.DataOutputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("certificationRqmtService")
public class CertificationRqmtServiceImpl extends AbstractServiceImpl implements
		CertificationRqmtService {

	@Resource(name = "certificationRqmtDAO")
	private CertificationRqmtDAO certificationRqmtDAO;

	protected static final Log logger = LogFactory
			.getLog(CertificationRqmtServiceImpl.class);

	// 증명서 발급 내역 리스트
	@SuppressWarnings("rawtypes")
	public Map getCertDocRqmtList(Map param) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		// parameter
		int pageSize = Integer.parseInt((String)param.get("pageSize"));
		int pageNo = Integer.parseInt((String)param.get("pageNo"));

		map.put("pageNo", param.get("pageNo")); // 넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.

		param.put("offset",0);
		param.put("limit", 0);

		List<CertificationRqmtVO> limit = certificationRqmtDAO.getCertDocRqmtList(param); // 총 건수
		int totalCount = limit.size();
		map.put("totalCount", totalCount);

		int pageCount = (totalCount / pageSize);
		pageCount = (totalCount > pageCount * pageSize) ? pageCount + 1
				: pageCount; // 총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를
								// (+1)여부결정
		map.put("pageCount", pageCount); // 총 페이지수

		param.put("offset",(pageNo - 1) * pageSize);
		param.put("limit", pageSize); // 페이지크기 pageSize

		map.put("list", certificationRqmtDAO.getCertDocRqmtList(param)); // 목록리스트

		return map; // Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총
					// 페이지수), list(리스트)
	}

	// 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getPerList(Map param) throws Exception {
		return certificationRqmtDAO.getPerList(param);
	}

	// 선택된 사원정보 받아오기
	@SuppressWarnings("rawtypes")
	public Map getPerInfo(Map param) throws Exception {
		return certificationRqmtDAO.getPerInfo(param);
	}

	// 퇴사자 포함 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getAllPerList(Map param) throws Exception {
		return certificationRqmtDAO.getAllPerList(param);
	}


	// 시너지그룹일 경우 회사정보(증명서 상세정보) 가져오기
	public Map getComInfoForSynergy(Map param) throws Exception{
		return certificationRqmtDAO.getComInfoForSynergy(param);
	}

	// 증명서 상세정보 반환
	public Map getCertDocView(Map param) throws Exception {
		return certificationRqmtDAO.getCertDocView(param);
	}

	//증명서 상세정보 반환
	public Map getOrgCompanyInfo(Map param) throws Exception{
		Map map = certificationRqmtDAO.getOrgCompanyInfo(param);
		/*byte[] image = (byte[]) map.get("orgLogo");
		if (image != null && image.length > 0)
			map.put("orgLogo", Base64.encodeBase64String(image));
		else
			map.put("orgLogo", null);*/
		return map;
	}

	// 증명서 상태 수정.
	public void updateCertDocStatus(Map param) throws Exception{
		certificationRqmtDAO.updateCertDocStatus(param);
	}

	//증명서 취소
	public void cancelCertDoc(Map param) throws Exception{
		certificationRqmtDAO.cancelCertDoc(param);
	}

	//증명서 반려
	public void returnCertDoc(Map param) throws Exception{
		certificationRqmtDAO.returnCertDoc(param);
	}

	//증명서 요청
	public int insertCertDoc(Map param) throws Exception{
		String formDocCd = param.get("formDocCd").toString();
		if(formDocCd.equals("WorkDoc")){
			param.put("reqStatus", "New");
		}else if(formDocCd.equals("CareerDoc")){
			String mngChk = param.get("mngChk").toString();
			if(mngChk.equals("Y")){
				param.put("reqStatus", param.get("reqStatus"));
				param.put("reqUserId", null);
			}else{
				param.put("reqStatus", "Temp");
			}
		}

		int formDocReqSeq = certificationRqmtDAO.insertCertDoc(param);

		//재직증명서 일 경우만 문자전송.
		if("WorkDoc".equals((String)param.get("formDocCd"))){
			//문자 전송.
			//smsUrlProcess(param);
		}

		return formDocReqSeq;
	}
	//경력증명서 관리자 처리
	public void certDocReqProc(Map param) throws Exception{
		certificationRqmtDAO.certDocReqProc(param);
	}

	//관계사 리스트 반환(사용자가 권한 가진 관계사)
	public List<Map> getOrgListByUser(Map map) throws Exception {
		// TODO Auto-generated method stub
		return certificationRqmtDAO.getOrgListByUser(map);
	}

	//증명서 발급 내역 리스트 totCnt
	@SuppressWarnings("rawtypes")
	public Integer getCertDocRqmtListCnt(Map param) throws Exception {

		List<CertificationRqmtVO> limit = certificationRqmtDAO.getCertDocRqmtList(param); // 총 건수
		int totalCount = limit.size();

		return totalCount;
	}


}
