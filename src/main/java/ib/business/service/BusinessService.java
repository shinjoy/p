package ib.business.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface BusinessService {

	/**
	 * 정보공유 세팅 정보 반환
	 * @param param orgId(관계사 아이디)
	 * @return
	 * @throws Exception
	 */
	public Map selectBusinessBsInfoSetupInfo(Map param) throws Exception;

	/**
	 * 업무일지에서 사용하기 위한 정보정리 리스트 반환
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectBsInfoListForWork(Map param) throws Exception;

	/**
	 * 공통코드 셋 정보 반환
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map businessSelectCodeSet(Map param) throws Exception;

	/**
	 * 정보공유 세팅 정보 저장 혹은 수정
	 * @param map
	 * @throws Exception
	 */
	public void saveBusinessAdminRegist(Map<String, Object> param) throws Exception;

	/**
	 * 정보공유 세팅 화면에서 정보분류의 코드리스트들 반환
	 * (경로, 구분, 유형에 해당하는 리스트 모두 반환)
	 * @param param, conditionMap(구분에 선택된 값)
	 * @return
	 * @throws Exception
	 */
	public Map selectCodeListAll(Map param,  Map conditionMap) throws Exception;


	/**
	 * 정보 분류 - 코드에 해당하는 코드 리스트 반환 (code_set_id)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectCodeList(Map param) throws Exception;

	/**
	 * 정보분류 - 코드등록 (저장)
	 * @param map
	 * @throws Exception
	 */
	public void saveBusinessCodeReg(Map<String, Object> param) throws Exception;

	/**
	 * 정보 분류 - 유형에 해당하는 정보 가져오기
	 * @param map , conditionMap(구분에 해당하는 value)
	 * @return
	 * @throws Exception
	 */
	public List<Map> selectCodeApplyClassList(Map<String, Object> map,  Map conditionMap) throws Exception;

	/**
	 * 정보 등록 - 정보 저장하기
	 * @param map
	 * @param request
	 * @throws Exception
	 */
	public void savebusinessInfoRegist(Map<String, Object> map) throws Exception;

	/**
	 * 정보 등록 - 정보 수정하기
	 * @param map
	 * @param request
	 * @throws Exception
	 */
	public void updatebusinessInfoRegist(Map<String, Object> map)  throws Exception;

	/**
	 * 정보 등록 - 등록된 정보 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map getBusinessInfoListInfo(Map<String, Object> map)throws Exception;

	/**
	 * 정보 등록 - 등록된 정보의 파일 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map> getBusinessInfoListFileList(Map<String,Object> map) throws Exception;




	/************************ 정보 등록 화면 *****************************/

	/////////////////////////////////////park : S
	/**
	 * 정보 정리 리스트
	 * @param map
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public Map<String,Object> getBusinessInfoList(Map<String, Object> map) throws Exception;
	/**
	 * 코멘트리스트
	 * @param map
	 * @return List<EgovMap>
	 * @throws Exception
	 */
	public Map<String,Object> getBusinessCommentList(Map<String, Object> map) throws Exception;
	/**
	 * 정보 정리 상세팝업
	 * @param map
	 * @return EgovMap
	 * @throws Exception
	 */
	public EgovMap getBusinessInfo(Map<String, Object> map) throws Exception;
	/**
	 * 정보 정리 댓글 조회
	 * @param map
	 * @return List<Map>
	 * @throws Exception
	 */
	public List<Map> getCommentList(Map<String, Object> map) throws Exception;
	/**
	 * 게시판 댓글 등록 및 수정
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int saveComment(Map<String, Object> map) throws Exception;
	/**
	 * 게시판 댓글 삭제
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int deleteComment(Map<String, Object> map) throws Exception;
	/**
	 * 정보 코멘트 총개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int getBusinessCommentListTotalCnt(Map<String, Object> map) throws Exception;
	/**
	 * 정보 코멘트(내가쓴 댓글의 댓글) 총개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int getBusinessMyCommentListCnt(Map<String, Object> map) throws Exception;
	/**
	 * 정보 코멘트(내가쓴 글의 댓글) 총개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int getMyBusinessComenntCnt(Map<String, Object> map) throws Exception;
	/**
	 * Staff 정보를 조회
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public List<Map<String,Object>> getBusinessStaffInfoList(Map<String, Object> map) throws Exception;
	////////////////////////////////////park: E


}