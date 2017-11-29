package ib.approve.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package	: ibiss.system.service
 * filename	: ApproveLineService.java
 * </pre>
 *
 *
 *
 * @author	: SangHyun Park
 * @date	: 2015. 9. 14.
 * @version :
 *
 */
public interface ApproveLineService {

	//결재선 목록조회
	public List<Map> selectApproveHeaderList(Map<String, Object> map) throws Exception;

	// 결재선저장
    int doSaveApproveHeader(Map<String, String> map) throws Exception;

    //결재순서 목록조회
	public List<Map> selectApproveLineList(Map<String, Object> map) throws Exception;

	//결재라인 저장
	public int doSaveApproveLine(Map<String, String> map, ApproveVoList appVoList) throws Exception;

	//사내서식 문서타입 조회
	public List<EgovMap> appvCompanyListForLine(Map<String, Object> map) throws Exception;
	//결재라인복사
	public String processCopyAppvLine(Map<String, String> map) throws Exception;

	//직원별 상위부서정보. 지우지 말것
    //public List<Map> getApproveLineHighDeptInfo(Map<String, String> map) throws Exception;
	
	//결재자 리스트
	public List<Map> getApproveUserList(Map<String, Object> map) throws Exception;
}
