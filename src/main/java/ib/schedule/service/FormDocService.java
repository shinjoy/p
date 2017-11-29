package ib.schedule.service;

import java.util.List;
import java.util.Map;

import ib.schedule.service.FormDocVO;

public interface FormDocService {


	@SuppressWarnings("rawtypes")
	List getPerList() throws Exception;										// 사원리스트 받아오기
	List getPerList(Map vo) throws Exception;										// 사원리스트 받아오기


	FormDocVO getPerInfo(FormDocVO vo) throws Exception;					// 선택 사원 정보 받아오기
	void formDocReqEnd(FormDocVO vo) throws Exception;						// 증명서 발급 요청 완료
	@SuppressWarnings("rawtypes")

	FormDocVO getFormDocInfo(FormDocVO vo) throws Exception;				// 증명서 정보 받아오기
	void formDocStatusEditEnd(FormDocVO vo) throws Exception;				// 증명서 상태 변경 완료
	void formDocCancelEnd(FormDocVO vo) throws Exception;					// 증명서 요청 취소 완료
}