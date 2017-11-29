package ib.schedule.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;
import ib.schedule.service.FormDocVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository("formDAO")
public class FormDocDAO extends ComAbstractDAO {
	// 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getPerList() throws Exception {
		return list("formDAO.GetPerList", new HashMap());
	}
	// 사원리스트 받아오기
	@SuppressWarnings("rawtypes")
	public List getPerList(Map p) throws Exception {
		return list("formDAO.GetPerList", p);
	}

	// 선택 사원 정보 받아오기
	public FormDocVO getPerInfo(FormDocVO vo) throws Exception {
		return (FormDocVO)selectByPk("formDAO.GetPerInfo", vo);
	}

	// 증명서 발급 요청 완료
	public void formDocReqEnd(FormDocVO vo) throws Exception {
		insert("formDAO.FormDocReqEnd", vo);
	}

	// 증명서 정보 받아오기
	public FormDocVO getFormDocInfo(FormDocVO vo) throws Exception {
		return (FormDocVO)selectByPk("formDAO.GetFormDocInfo", vo);
	}

	// 증명서 상태 변경 완료
	public void formDocStatusEditEnd(FormDocVO vo) throws Exception {
		update("formDAO.FormDocStatusEditEnd", vo);
	}

	// 증명서 요청 취소 완료
	public void formDocCancelEnd(FormDocVO vo) throws Exception {
		update("formDAO.FormDocCancelEnd", vo);
	}
}