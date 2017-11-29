package ib.work.service;

import ib.basic.service.CpnExcelVO;
import ib.cmm.FileUpDbVO;
import ib.login.service.StaffVO;
import ib.person.service.PersonVO;
import ib.recommend.service.RecommendVO;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * <pre>
 * package  : ib.work.service
 * filename : WorkService.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 10.
 * @version : 1.0.0
 */
public interface WorkService {


	/**
	 *
	 * @MethodName : selectBusinessRecordList
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectBusinessRecordList(WorkVO vo) throws Exception;

	/**
	 *
	 * @MethodName : selectStaffList
	 * @param staffVO
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> selectStaffList(StaffVO staffVO) throws Exception;

	/**
	 *
	 * @MethodName : selectMemoList
	 * @param staffVO
	 * @return
	 * @throws Exception
	 */
	List<WorkVO> selectMemoList(WorkVO workVO) throws Exception;

	/**
	 *
	 * @MethodName : selectBusinessRecordStaffList
	 * @param staffVO
	 * @return
	 */
	Map<String, Object> selectBusinessRecordStaffList(WorkVO VO) throws Exception;

	/**
	 *
	 * @MethodName : selectBusinessRecordList
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<WorkVO> selectBusinessRecordList2(WorkVO workVO) throws Exception;

	/**
	 *
	 * @MethodName : selectOutStaffList
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectOutStaffList(StaffVO staffVO) throws Exception;

	/**
	 *
	 * @MethodName : selectMemoList
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public List<WorkVO> selectMemoList2(WorkVO workVO) throws Exception;
	/**
    *
    * @MethodName : selectOfferListNfile
    * @param workVO
    * @return
    * @throws Exception
    */
   public List<WorkVO> selectOfferListNfile(WorkVO workVO) throws Exception;
   /**
	 *
	 * @MethodName : selectNetPoint
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectNetPoint(WorkVO VO) throws Exception;

	/**
	 *
	 * @MethodName : selectSameCommentStaffName
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectSameCommentStaffName(WorkVO vo) throws Exception;

	/**
	 *
	 * @MethodName : selectInsideList
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectInsideList(WorkVO vo) throws Exception ;
	/**
	 *
	 * @MethodName : selectBusinessRecordOne
	 * @param vo
	 * @return
	 */
	public Object selectBusinessRecordOne(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : selectInsideOne
	 * @param vo
	 * @return
	 */
	public Object selectInsideOne(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : insertBusinessRecord
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int insertBusinessRecord(WorkVO workVO) throws Exception ;
	/**
    *
    * @MethodName : updateBusinessRecord
    * @param workVO
    * @throws Exception
    */
   public int updateBusinessRecord(WorkVO workVO) throws Exception;
   /**
	 *
	 * @MethodName : deleteBusinessRecord
	 * @param workVO
	 * @throws Exception
	 */
	public int deleteBusinessRecord(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : selectOfferInfo
	 * @return
	 */
	public List<WorkVO> selectOfferInfo(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : insertOfferInfo
	 * @param workVO
	 * @return
	 */
	public int insertOfferInfo(WorkVO VO) throws Exception;
	//정보등급별 사용자 리스트
	List<Map> getInfoLevelUser(Map<String, String> map) throws Exception;

	//정보등급 리스트
	List<String> getInfoLevelList() throws Exception;

	public List<WorkVO> selectOfferCpnList2(WorkVO VO) throws Exception;

	public List<WorkVO> selectOffercontactPoint(WorkVO workVO) throws Exception;

	public Integer updateOfferInfo(WorkVO VO) throws Exception;

	public List<WorkVO> selectofferInfoInCpnCst(WorkVO vo) throws Exception;

	public List<WorkVO> selectCompanyOpinion(WorkVO wvo) throws Exception;

	public int updateCompanyOpinion(CpnExcelVO vo) throws Exception;
	/**
	 *
	 * @MethodName : selectOfferJointProgress
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectOfferJointProgress(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : updateOfferJointProgress
	 * @param workVO
	 * @return
	 */
	public int updateOfferJointProgress(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : insertOfferJointProgress
	 * @param workVO
	 * @return
	 */
	public int insertOfferJointProgress(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : deleteOfferJointProgress
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int deleteOfferJointProgress(WorkVO workVO) throws Exception;

	/**
	 *
	 * @MethodName : updateDeal
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int updateDeal(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : deleteFileInfoOfOfferSnb
	 * @param fvo
	 */
	public void deleteFileInfoOfOfferSnb(FileUpDbVO vo) throws Exception;
	/**
	 *
	 * @MethodName : getStaffName
	 * @param rgId
	 * @return
	 */
	public String getStaffName(String rgId) throws Exception;
	/**
	 *
	 * @MethodName : selectEncrypt
	 * @return
	 * @author : user
	 * @since : 2015. 2. 11.
	 */
	public String selectEncrypt(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : insertMainMemoNreturnSnb
	 * @param workVO
	 */
	public void insertMainMemoNreturnSnb(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : selectMemoList
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public List<WorkVO> selectMemoListByIbSystem(WorkVO workVO) throws Exception;
	 /**
	    *
	    * @MethodName : insertMemo
	    * @param workVO
	    * @return
	    * @throws Exception
	    */
    public int insertMemo(WorkVO workVO) throws Exception ;
     /**
     *
     * @MethodName : checkMemo
     * @param workVO
     * @return
     * @throws Exception
     */
    public int checkMemo(WorkVO workVO) throws Exception;

	/**
	 *
	 * @MethodName : selectOfferAllDealList
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectOfferAllDealList(WorkVO vo) throws Exception;
	/**
    *
    * @MethodName : selectOfferList
    * @param workVO
    * @return
    * @throws Exception
    */
	public List<WorkVO> selectOfferList(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : updateFeedback
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int updateFeedback(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : updateprogressCd
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int updateprogressCd(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : deleteMnaMatchCpn
	 * @param vo
	 * @return
	 * @author : user
	 * @since : 2015. 3. 31.
	 */
	public int deleteMnaMatchCpn(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : updateDueDate
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int updateDueDate(WorkVO workVO) throws Exception ;
	/**
	 *
	 * @MethodName : updatePrecessResult
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int updatePrecessResult(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : selectMaxSnb
	 * @param VO
	 * @return
	 * @throws Exception
	 */
	public List<WorkVO> selectMaxSnb(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : insertFileInfo
	 * @param fileVo
	 * @return
	 */
	public int insertFileInfo(FileUpDbVO VO) throws Exception ;
	/**
	 *
	 * @MethodName : updateKeyPointChkMemo
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int updateKeyPointChkMemo(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : selectFileInfo
	 * @param fileVO
	 * @return
	 */
	public List<FileUpDbVO> selectFileInfo(FileUpDbVO VO) throws Exception;
	/**
	 *
	 * @MethodName : deleteFile
	 * @param
	 * @return
	 * @author : oys
	 * @since : 2015. 10. 1.
	 */
	public int deleteFile(Map<String, String> map) throws Exception ;
	/**
	 *
	 * @MethodName : updateOfferCoworker
	 * @param workVO
	 * @return
	 */
	public int updateOfferCoworker(WorkVO VO) throws Exception ;
	/**
	 *
	 * @MethodName : updateOfferInfoProcess
	 * @param workVO
	 * @return
	 */
	public int updateOfferInfoProcess(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : updateOfferInfoLv
	 * @param wVO
	 * @return
	 */
	public int updateOfferInfoLv(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : selectRecommendOne
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectRecommendOne(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : selectBusinessTmdt
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectBusinessTmdt(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : updateBusinessTmdt
	 * @param workVO
	 * @return
	 */
	public Integer updateBusinessTmdt(WorkVO VO) throws Exception;
	/**
	 *
	 * @MethodName : updateCompanyPbr
	 * @param vo
	 */
	public int updateCompanyPbr(CpnExcelVO vo) throws Exception;

	/**
	 *
	 * @MethodName : selectMaxSnbINopinion
	 * @param wvo
	 * @return
	 */
	public List<WorkVO> selectMaxSnbINopinion(WorkVO vo) throws Exception ;
	/**
	 *
	 * @MethodName : selectAnalysisCommentsList
	 * @param vo
	 * @return
	 */
	public Object selectAnalysisCommentsList(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : selectMatrixList
	 * @param vo
	 * @return
	 * @author : user
	 * @since : 2015. 4. 10.
	 */
	public List<WorkVO> selectMatrixList(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : updateFileInfoCheckReport
	 * @param vo
	 * @return
	 * @author : user
	 * @since : 2015. 4. 23.
	 */
	public int updateFileInfoCheckReport(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : updateMnaMatchComment
	 * @param vo
	 * @return
	 * @author : user
	 * @since : 2015. 5. 15.
	 */
	public int updateMnaMatchComment(WorkVO vo) throws Exception ;
	/**
	 *
	 * @MethodName : updateMiddleOfferCd
	 * @param vo
	 * @return
	 * @author : user
	 * @since : 2015. 6. 9.
	 */
	public int updateMiddleOfferCd(WorkVO vo) throws Exception ;
	/**
	 *
	 * @MethodName : deleteOffer
	 * @param workVO
	 * @return
	 */
	public int deleteOffer(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : selectSMS
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectSMS(WorkVO VO) throws Exception ;
	/**
	 *
	 * @MethodName : updateCompanyExloring
	 * @param vo
	 */
	public int updateCompanyExloring(CpnExcelVO vo) throws Exception ;

	/**
	 *
	 * @MethodName : selectOpinionNdeal
	 * @param vo
	 * @return
	 */
	public Object selectOpinionNdeal(WorkVO vo) throws Exception;

	/**
	 *
	 * @MethodName : selectMnaMatchCpnList
	 * @param rcmdVO
	 * @return
	 * @author : user
	 * @since : 2015. 3. 26.
	 */
	public List<RecommendVO> selectMnaMatchCpnList(RecommendVO vo) throws Exception;
	/**
	 *
	 * @MethodName : selectStaffOfferList
	 * @param workVO
	 * @return
	 */
	public List<WorkVO> selectStaffOfferList(WorkVO vo) throws Exception;
	/**
	 *
	 * @MethodName : selectStaffOfferListCnt
	 * @param workVO
	 * @return
	 */
	public int selectStaffOfferListCnt(WorkVO vo) throws Exception;

	/**
	 * Controller 비지니스 로직 : 박성진
	 * */
	public Integer insertDealByIbSystem(WorkVO workVO,Map loginUser) throws Exception;

	public List<WorkVO> selectOfferCpnList(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : updateDealByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int updateDealByIbSystem(WorkVO workVO) throws Exception;

	public Map<String,Integer> insertMemoByIbSystem(WorkVO workVO) throws Exception;

	/**
	 *
	 * @MethodName : modifyMemoByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int modifyMemoByIbSystem(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : deleteMemoByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int deleteMemoByIbSystem(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : mnaMatchingStaffsByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public void mnaMatchingStaffsByIbSystem(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : updateprogressCdByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int updateprogressCdByIbSystem(WorkVO workVO,Map loginUser) throws Exception;
	/**
	 *
	 * @MethodName : changeprogressCdNmatchCpnByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int changeprogressCdNmatchCpnByIbSystem(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : modifyDealMemoByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int modifyDealMemoByIbSystem(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : modifyDealResultByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int modifyDealResultByIbSystem(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : modifyKeyPointChkMemoByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int modifyKeyPointChkMemoByIbSystem(WorkVO workVO) throws Exception;
	/**
	 *
	 * @MethodName : updateResultByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int updateResultByIbSystem(RecommendVO rcmdVO) throws Exception;
	/**
	 *
	 * @MethodName : insertDealINallDealByIbSystem
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public void insertDealINallDealByIbSystem(WorkVO workVO,MultipartHttpServletRequest multipartRequest) throws Exception;
	/**
	 *
	 * @MethodName : selectStaffList4ib
	 * @param staffVO
	 * @return
	 */
	public List<StaffVO> selectStaffList4ib(StaffVO vo) throws Exception;

	/**
	 *
	 * @MethodName : selectFileInfoList
	 * @param vo
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FileUpDbVO> selectFileInfoList(FileUpDbVO vo) throws Exception;

	/**
	 *
	 * @param vo
	 * @MethodName : selectFileInfoListCnt
	 * @param vo
	 * @return
	 */
	public int selectFileInfoListCnt(FileUpDbVO vo) throws Exception;

	/**
	 *
	 * @MethodName : deleteFileInfo
	 * @param vo
	 */
	public int deleteFileInfo(FileUpDbVO vo) throws Exception;



	public List<WorkVO> selectComment(WorkVO wVO) throws Exception;

	public List<WorkVO> selectOpinion(WorkVO w1vo) throws Exception;

	public List<WorkVO> selectMainOfferList(WorkVO w3vo) throws Exception;

	public int insertMainTableCheck(WorkVO wvo) throws Exception;

	public String selectMemo4insertFile(WorkVO vo) throws Exception;

	public String selectReply4insertFile(WorkVO vo) throws Exception;


}