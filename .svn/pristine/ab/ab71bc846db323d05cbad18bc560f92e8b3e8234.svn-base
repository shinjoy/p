package ib.schedule.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import ib.schedule.service.FormDocService;
import ib.schedule.service.FormDocVO;

@Service("formService")
public class FormDocServiceImpl extends AbstractServiceImpl implements FormDocService {

	@Resource(name = "formDAO")
	private FormDocDAO formDAO;

	// 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getPerList() throws Exception {
		return formDAO.getPerList();
	}
	// 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getPerList(Map p) throws Exception {
		return formDAO.getPerList(p);
	}

	// 선택 사원 정보 받아오기
	public FormDocVO getPerInfo(FormDocVO vo) throws Exception {
		return formDAO.getPerInfo(vo);
	}

	// 증명서 발급 요청 완료
	public void formDocReqEnd(FormDocVO vo) throws Exception {
		formDAO.formDocReqEnd(vo);
	}

	// 증명서 정보 받아오기
	public FormDocVO getFormDocInfo(FormDocVO vo) throws Exception {
		return formDAO.getFormDocInfo(vo);
	}

	// 증명서 상태 변경 완료
	public void formDocStatusEditEnd(FormDocVO vo) throws Exception {
		formDAO.formDocStatusEditEnd(vo);
	}

	// 증명서 요청 취소 완료
	public void formDocCancelEnd(FormDocVO vo) throws Exception {
		formDAO.formDocCancelEnd(vo);
	}
}