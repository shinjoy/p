package ib.business.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("businessDAO")
public class BusinessDAO extends ComAbstractDAO {

	/**
	 * 공통코드 리스트 가져오기 ( code_set_id 기준 )
	 * @param param
	 * @return
	 */
	public List<Map> selectCodeList(Map param){
		return list("business.selectCodeList", param);
	}

	/**
	 * 공통 코드 리스트 저장하기
	 * @param param
	 */
	public void insertCodeList(Map param){
		insert("business.insertCodeList", param);
	}

	/**
	 * 공통 코드 셋 리스트 저장하기
	 * @param param
	 */
	public void insertCodeSet(Map param){
		insert("business.insertCodeSet", param);
	}

	/**
	 * 공통 코드 리스트 삭제하기
	 * @param param
	 */
	public void deleteCodeList(Map param){
		delete("business.deleteCodeList", param);
	}

	/**
	 * 공통 코드 set 정보 반환하기.
	 * @param param
	 * @return
	 */
	public Map businessSelectCodeSet(Map param){
		return (Map) super.getSqlMapClientTemplate().queryForObject("business.businessSelectCodeSet", param);
	}

	/**
	 * 공통 코드 리스트 정보 반환하기
	 * @param param
	 * @return
	 */
	public List<Map> businessSelectCodeList(Map param){
		return list("business.businessSelectCodeList", param);
	}
	/**
	 * 정보 공유 세팅 저장하기
	 * @param param
	 */
	public void insertBsInfoSetup(Map param){
		insert("business.insertBsInfoSetup", param);
	}

	/**
	 * 정보 공유 세팅 업데이트
	 * @param param
	 */
	public void updateBsInfoSetup(Map param){
		update("business.updateBsInfoSetup", param);
	}

	/**
	 * 정보 공유 세팅 정보 반환
	 * (orgId 기준)
	 * @param param
	 * @return
	 */
	public Map selectBsInfoSetupInfo(Map param){
		return (Map) super.getSqlMapClientTemplate().queryForObject("business.selectBsInfoSetupInfo", param);
	}

	/**
	 * 정보 공유 리스트 정보 반환
	 * @param param
	 * @return
	 */
	public Map selectBsInfoList(Map param){
		return (Map)super.getSqlMapClientTemplate().queryForObject("business.selectBsInfoList", param);
	}

	/**
	 * 업무일지 - 정보공유 리스트 반환
	 * @param param
	 * @return
	 */
	public List<Map> selectBsInfoListForWork(Map param){
		return list("business.selectBsInfoListForWork", param);
	}

	/**
	 * 정보 공유 리스트 정보 입력
	 * @param param
	 */
	public int insertBsInfoList(Map param){

		int key = -1;
		Object rslt =(Integer)insert("business.insertBsInfoList", param);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}
	/**
	 * 정보 공유 리스트 정보 입력
	 * @param param
	 */
	public void insertInfoStaff(Map param){

		insert("business.insertInfoStaff", param);
	}

	/**
	 * 정보 공유 리스트 정보 업데이트
	 * @param param
	 */
	public void updateBsInfoList(Map param){
		update("business.updateBsInfoList", param);
	}

	/**
	 * 정보 공유 히스토리 정보 반환
	 * @param param
	 * @return
	 */
	public Map selectBsInfoHIstoryInfo(Map param){
		return (Map) super.getSqlMapClientTemplate().queryForObject("business.selectBsInfoHistory", param);
	}

	/**
	 * 정보 공유 히스토리 정보 입력
	 */
	public void insertBsInfoHistory(Map param){
		insert("business.insertBsInfoHistory", param);
	}





	//////////////////////////////////////////////////park : S
	/**
	* 정보 정리 리스트
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getBusinessInfoList(Map<String, Object> map) throws Exception{
		return list("business.getBusinessInfoList", map);
	}
	/**
	 * 정보 정리 총개수
	 * @param map
	 * @return Integer
	 * @throws Exception
	 */
	public Integer getBusinessInfoListTotalCnt(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("business.getBusinessInfoListTotalCnt", map);
	}
	/**
	* 코멘트 리스트
	* @param map
	* @return List<EgovMap>
	* @throws Exception
	*/
	public List<EgovMap> getBusinessCommentList(Map<String, Object> map) throws Exception{
		return list("business.getBusinessCommentList", map);
	}
	/**
	 * 코멘트총개수
	 * @param map
	 * @return Integer
	 * @throws Exception
	 */
	public Integer getBusinessCommentListTotalCnt(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("business.getBusinessCommentListTotalCnt", map);
	}
	/**
	 * 정보 정리 상세팝업
	 * @param map
	 * @return EgovMap
	 * @throws Exception
	 */
	public EgovMap getBusinessInfo(Map<String, Object> map) throws Exception{
		return (EgovMap)getSqlMapClientTemplate().queryForObject("business.getBusinessInfo", map);
	}
	/**
	 * 게시글답변리스트
	 * @param map
	 * @return EgovMap
	 * @throws Exception
	 */
	public List<Map> getCommentList(Map<String, Object> param) throws Exception{
		return list("business.getCommentList",param);
	}
	/**
	 * 게시판 글 등록
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int insertComment(Map<String, Object> param)throws Exception{
		return (Integer)insert("business.insertComment", param);
	}
	/**
	 * 게시 댓글 수정
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public void updateComment(Map<String, Object> param)throws Exception{
		update("business.updateComment", param);
	}
	/**
	 * 게시판 글 삭제
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public void updateCommentDelFlag(Map<String, Object> param)throws Exception{
		update("business.updateCommentDelFlag", param);
	}
	/**
	 * 정보 코멘트(내가쓴 댓글의 댓글) 총개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int getBusinessMyCommentListCnt(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("business.getBusinessMyCommentListCnt", map);
	}
	/**
	 * 정보 코멘트(내가쓴 글의 댓글) 총개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int getMyBusinessComenntCnt(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("business.getMyBusinessComenntCnt", map);
	}
	/**
	 * Staff 정보를 조회
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public List<Map<String,Object>> getBusinessStaffInfoList(Map<String, Object> map) throws Exception{
		return list("business.getBusinessStaffInfoList", map);
	}
	/**
	 * Staff 정보를 삭제
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int deleteStaffInfo(Map<String, Object> map) throws Exception {
		return delete("business.deleteStaffInfo", map);
	}
	//////////////////////////////////////////////////park : E

}
