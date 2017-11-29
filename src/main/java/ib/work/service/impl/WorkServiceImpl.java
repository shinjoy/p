package ib.work.service.impl;

import ib.basic.service.CpnExcelVO;
import ib.cmm.FileUpDbVO;
import ib.login.service.StaffVO;
import ib.person.service.PersonVO;
import ib.person.service.impl.PersonDAO;
import ib.recommend.service.RecommendVO;
import ib.work.service.WorkService;
import ib.work.service.WorkVO;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * <pre>
 * package  : ib.work.service.impl
 * filename : WorkServiceImpl.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 10.
 * @version : 1.0.0
 */
@Service("workService")
public class WorkServiceImpl extends AbstractServiceImpl implements WorkService{

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name="workDAO")
    private WorkDAO workDAO;

    @Resource(name = "personDAO")
    private PersonDAO personDAO;


	/* (non-Javadoc)
	 * @see ib.work.service.WorkService#selectStaffList(ib.login.service.StaffVO)
	 */
	public Map<String, Object> selectStaffList(StaffVO staffVO) throws Exception {

		List<WorkVO> result = workDAO.selectStaffList(staffVO);

		Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);

        return map;
	}
	public Map<String, Object> selectBusinessRecordStaffList(WorkVO VO) throws Exception {

		List<WorkVO> result = workDAO.selectBusinessRecordStaffList(VO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", result);

		return map;
	}

	/* (non-Javadoc)
	 * @see ib.work.service.WorkService#selectBusinessRecordList(ib.work.service.WorkVO)
	 */
	public Map<String, Object> selectBusinessRecordList(WorkVO vo) throws Exception {

//		WorkVO result = workDAO.selectBusinessRecordResult(vo);

		List<WorkVO> result = workDAO.selectBusinessRecordList(vo);
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("resultList", result);

        return map;
	}

	/* (non-Javadoc)
	 * @see ib.work.service.WorkService#selectMemoList(ib.work.service.WorkVO)
	 */
	public List<WorkVO> selectMemoList(WorkVO workVO) throws Exception {

		List<WorkVO> result = workDAO.selectMemoList(workVO);
		//Map<String, Object> map = new HashMap<String, Object>();
        //map.put("resultList", result);

		return result;
	}


	//정보등급별 사용자 리스트
	public List<Map> getInfoLevelUser(Map<String, String> map) throws Exception {

		if("m".equals(map.get("infoType").toString())){
			return workDAO.getMnaLevelUser(map);
		}else{
			return workDAO.getInfoLevelUser(map);
		}
	}

	//정보등급 리스트
	public List<String> getInfoLevelList() throws Exception {

		return workDAO.getInfoLevelList();
	}

	public List<WorkVO> selectOfferCpnList2(WorkVO VO) throws Exception {
		return workDAO.selectOfferCpnList2(VO);
	}

	public List<WorkVO> selectOffercontactPoint(WorkVO workVO) throws Exception {
		return  workDAO.selectOffercontactPoint(workVO);
	}

	public Integer updateOfferInfo(WorkVO VO) throws Exception {
		return workDAO.updateOfferInfo(VO);
	}

	public List<WorkVO> selectofferInfoInCpnCst(WorkVO vo) throws Exception {
		return workDAO.selectofferInfoInCpnCst(vo);
	}

	public List<WorkVO> selectCompanyOpinion(WorkVO wvo) throws Exception {
		return workDAO.selectCompanyOpinion(wvo);
	}
	public int updateCompanyOpinion(CpnExcelVO vo) throws Exception {
		return workDAO.updateCompanyOpinion(vo);
	}

	public List<WorkVO> selectOutStaffList(StaffVO staffVO) throws Exception {
		return workDAO.selectOutStaffList(staffVO);
	}

	public List<WorkVO> selectBusinessRecordList2(WorkVO workVO) throws Exception {
		return workDAO.selectBusinessRecordList(workVO);
	}

	public List<WorkVO> selectMemoList2(WorkVO workVO) throws Exception {
		return workDAO.selectMemoList(workVO);
	}
	public List<WorkVO> selectOfferListNfile(WorkVO workVO) throws Exception {
		return workDAO.selectOfferListNfile(workVO);
	}
	public List<WorkVO> selectNetPoint(WorkVO VO) throws Exception {
		return workDAO.selectNetPoint(VO);
	}

	public List<WorkVO> selectSameCommentStaffName(WorkVO vo) throws Exception {
		return  workDAO.selectSameCommentStaffName(vo);
	}

	public List<WorkVO> selectInsideList(WorkVO vo) throws Exception {
		return workDAO.selectInsideList(vo);
	}
	public Object selectBusinessRecordOne(WorkVO vo) throws Exception {
		return workDAO.selectBusinessRecordOne(vo);
	}
	public Object selectInsideOne(WorkVO vo) throws Exception {
		return workDAO.selectInsideOne(vo);
	}
	public int insertBusinessRecord(WorkVO workVO) throws Exception {
		return workDAO.insertBusinessRecord(workVO);
	}
	public int updateBusinessRecord(WorkVO workVO) throws Exception {
		return workDAO.updateBusinessRecord(workVO);
	}
	public int deleteBusinessRecord(WorkVO workVO) throws Exception {
		return workDAO.deleteBusinessRecord(workVO);
	}
	public List<WorkVO> selectOfferInfo(WorkVO VO) throws Exception {
		return workDAO.selectOfferInfo(VO);
	}
	public int insertOfferInfo(WorkVO VO) throws Exception {
		return workDAO.insertOfferInfo(VO);
	}
	public List<WorkVO> selectOfferJointProgress(WorkVO vo) throws Exception {
		return workDAO.selectOfferJointProgress(vo);
	}
	public int updateOfferJointProgress(WorkVO VO) throws Exception {
		return workDAO.updateOfferJointProgress(VO);
	}
	public int insertOfferJointProgress(WorkVO VO) throws Exception {
		return workDAO.insertOfferJointProgress(VO);
	}
	public int deleteOfferJointProgress(WorkVO workVO) throws Exception {
		return workDAO.deleteOfferJointProgress(workVO);
	}

	public int updateDeal(WorkVO workVO) throws Exception {
		return workDAO.updateDeal(workVO);
	}
	public void deleteFileInfoOfOfferSnb(FileUpDbVO vo) throws Exception {
		workDAO.deleteFileInfoOfOfferSnb(vo);
	}
	public String getStaffName(String rgId) throws Exception {
		return workDAO.getStaffName(rgId);
	}
	public String selectEncrypt(WorkVO vo) throws Exception {
		return workDAO.selectEncrypt(vo);
	}
	public void insertMainMemoNreturnSnb(WorkVO vo) throws Exception {
		workDAO.insertMainMemoNreturnSnb(vo);

	}
	public List<WorkVO> selectMemoListByIbSystem(WorkVO workVO) throws Exception {
		return workDAO.selectMemoList(workVO);
	}
	public int insertMemo(WorkVO workVO) throws Exception {
		return workDAO.insertMemo(workVO);
	}
	public int checkMemo(WorkVO workVO) throws Exception {
		return workDAO.checkMemo(workVO);
	}

	public List<WorkVO> selectOfferAllDealList(WorkVO vo) throws Exception {
		return workDAO.selectOfferAllDealList(vo);
	}
	public List<WorkVO> selectOfferList(WorkVO workVO) throws Exception {
		return workDAO.selectOfferList(workVO);
	}
	public int updateFeedback(WorkVO workVO) throws Exception {
		return workDAO.updateFeedback(workVO);
	}
	public int updateprogressCd(WorkVO workVO) throws Exception {
		return workDAO.updateprogressCd(workVO);
	}
	public int deleteMnaMatchCpn(WorkVO vo) throws Exception {
		return workDAO.deleteMnaMatchCpn(vo);
	}
	public int updateDueDate(WorkVO workVO) throws Exception {
		return workDAO.updateDueDate(workVO);
	}
	public int updatePrecessResult(WorkVO workVO) throws Exception {
		return workDAO.updatePrecessResult(workVO);
	}
	public List<WorkVO> selectMaxSnb(WorkVO VO) throws Exception {
		return workDAO.selectMaxSnb(VO);
	}
	public int insertFileInfo(FileUpDbVO VO) throws Exception {
		return workDAO.insertFileInfo(VO);
	}

	public int updateKeyPointChkMemo(WorkVO vo) throws Exception {
		return workDAO.updateKeyPointChkMemo(vo);
	}
	public List<FileUpDbVO> selectFileInfo(FileUpDbVO VO) throws Exception {
		return workDAO.selectFileInfo(VO);
	}
	public int deleteFile(Map<String, String> map) throws Exception {
		return workDAO.deleteFile(map);
	}
	public int updateOfferCoworker(WorkVO VO) throws Exception {
		return workDAO.updateOfferCoworker(VO);
	}
	public int updateOfferInfoProcess(WorkVO VO) throws Exception {
		return workDAO.updateOfferInfoProcess(VO);
	}
	public int updateOfferInfoLv(WorkVO VO) throws Exception {
		return workDAO.updateOfferInfoLv(VO);
	}
	public List<WorkVO> selectRecommendOne(WorkVO VO) throws Exception {
		return workDAO.selectRecommendOne(VO);
	}
	public List<WorkVO> selectBusinessTmdt(WorkVO VO) throws Exception {
		return workDAO.selectBusinessTmdt(VO);
	}
	public Integer updateBusinessTmdt(WorkVO VO) throws Exception {
		return workDAO.updateBusinessTmdt(VO);
	}
	public int updateCompanyPbr(CpnExcelVO vo) throws Exception {
		return workDAO.updateCompanyPbr(vo);
	}

	public List<WorkVO> selectMaxSnbINopinion(WorkVO vo) throws Exception {
		return workDAO.selectMaxSnbINopinion(vo);
	}
	public Object selectAnalysisCommentsList(WorkVO vo) throws Exception {
		return workDAO.selectAnalysisCommentsList(vo);
	}
	public List<WorkVO> selectMatrixList(WorkVO vo) throws Exception {
		return workDAO.selectMatrixList(vo);
	}
	public int updateFileInfoCheckReport(WorkVO vo) throws Exception {
		return workDAO.updateFileInfoCheckReport(vo);
	}
	public int updateMnaMatchComment(WorkVO vo) throws Exception {
		return workDAO.updateMnaMatchComment(vo);
	}
	public int updateMiddleOfferCd(WorkVO vo) throws Exception {
		return workDAO.updateMiddleOfferCd(vo);
	}
	public int deleteOffer(WorkVO workVO) throws Exception {
		return workDAO.deleteOffer(workVO);
	}
	public List<WorkVO> selectSMS(WorkVO VO) throws Exception {
		return workDAO.selectSMS(VO);
	}
	public int updateCompanyExloring(CpnExcelVO vo) throws Exception {
		return workDAO.updateCompanyExloring(vo);
	}
	public Object selectOpinionNdeal(WorkVO vo) throws Exception {
		return workDAO.selectOpinionNdeal(vo);
	}

	public List<RecommendVO> selectMnaMatchCpnList(RecommendVO vo) throws Exception {
		return workDAO.selectMnaMatchCpnList(vo);
	}
	public List<WorkVO> selectStaffOfferList(WorkVO vo) throws Exception {
		return workDAO.selectStaffOfferList(vo);
	}
	public List<WorkVO> selectOfferCpnList(WorkVO workVO) throws Exception {
		return workDAO.selectStaffOfferList(workVO);
	}
	public int selectStaffOfferListCnt(WorkVO vo) throws Exception {
		return workDAO.selectStaffOfferListCnt(vo);
	}
	/**
	 * Controller 비지니스 로직 : 박성진
	 * */
	public Integer insertDealByIbSystem(WorkVO workVO,Map loginUser) throws Exception {
		int cnt = 0, cntCus = 0;
		if(!"00011".equals(workVO.getMiddleOfferCd())){
			workVO.setEntrust(null);
		}
		cnt = workDAO.insertDeal(workVO);
		//LOG.debug(loginUser.getId()+"^_^workDAO.insertDeal");
		cnt += insertOfferInfoByIbSystem(workVO);


		//----- 딜 제안중(직접발굴) 입력건에 대해서 추천인(추천종목) 이 있을때, 해당 추천종목(IB_OFFER 에 존재) 의 상태를 '00003' 제안중(구, 성사) 로 업데이트 :S -------
		if(!"0".equals(workVO.getRcmdSnb())){
			//workDAO.updateRcmdStts(workVO);
			Map map = new HashMap();
			map.put("sNb", workVO.getRcmdSnb());
			map.put("usrId", loginUser.get("loginId").toString());
			map.put("orgId", loginUser.get("orgId").toString());
			//recommendDAO.updateRcmdDealStts(map);		//추천종목 상태 변경
		}
		//----- 딜 제안중(직접발굴) 입력건에 대해서 추천인(추천종목) 이 있을때, 해당 추천종목(IB_OFFER 에 존재) 의 상태를 '00003' 제안중(구, 성사) 로 업데이트 :E -------


		// 인물네트워크 자동등록
		String cstId = workVO.getCstId();
		if(!"".equals(cstId) && cstId != null && !"0".equals(cstId)){
			int offerCd = 0;
			if(Integer.parseInt(workVO.getMiddleOfferCd())>10){
				offerCd = Integer.parseInt(workVO.getMiddleOfferCd());
			}else{
				offerCd = Integer.parseInt(workVO.getOfferCd());
			}
			//네트워크 DB에서 직원id와 cstId로 이전 입력 있는지 확인
			int cnt1 = workDAO.selectNetworkCnt(workVO);
			if(cnt1==0) {
				//직원의 cstId query
				//StaffVO svo = new StaffVO();
				Map svo = new HashMap();
				svo.put("loginId", workVO.getRgId());
				//List <StaffVO> rtnStaff = personDAO.selectStaff(svo);
				List <Map> rtnStaff = personDAO.selectStaff(svo);

				String offerNm = null;
				StringBuffer sb = new StringBuffer();
				PersonVO pvo = new PersonVO();
				pvo.setSnb1st(rtnStaff.get(0).get("cusId").toString());
				pvo.setSnb2nd(cstId);
				pvo.setRgId(workVO.getRgId());

				if(1 == offerCd) offerNm="미팅";else if(7 == offerCd) offerNm="받은제안";else if(8 == offerCd) offerNm="저녁미팅";else if(9 == offerCd) offerNm="전화통화";else if(11 == offerCd) offerNm="일임계약";else if(12 == offerCd) offerNm="재매각";
				switch(offerCd){
				case 1:case 7:case 8:case 9:case 11:case 12:
					//인물네트워크 추가
					sb.append(workVO.getTmDt()).append(" : ").append(offerNm); //.append(" / 회사코드 : ").append(workVO.getCpnId())
					pvo.setNote(sb.toString());
					cnt1 = personDAO.insertNetworkCst(pvo);
					log.debug(loginUser.get("loginId").toString()+"^_^personDAO.insertNetworkCst");
					break;
				default: break;
				}
			}
		}
		return cnt;
	}

	public int updateDealByIbSystem(WorkVO workVO) throws Exception {
		int cnt = this.updateDeal(workVO);

		cnt += this.updateNinsertOfferInfo(workVO);
		return cnt;
	}

	public int updateNinsertOfferInfo(WorkVO vo){
		int cnt = 0;
		if(vo.getKeyP().length()<0) return 0;

		String
			   keyPnum 		= vo.getKeyPnum()
			 , keyPsnbNum 	= vo.getKeyPsnbNum()
			 , arrNote[] 	= vo.getKeyP().split(",")
			 , arrNum[] 	= keyPnum.split(",")
			 , arrSnbNum[] 	= keyPsnbNum.split(",")
			 , arrSnb[] 	= vo.getKeyPsnb().split(",");
		// int lengArrNum = arrNum.length<arrSnbNum.length?arrSnbNum.length:arrNum.length;
		int lengArrNum = Integer.parseInt(vo.getKeyPmax());
		StringBuffer cate = null;

		try{
			for(int i=0, j=0; i<lengArrNum; i++){
				if(j<arrSnbNum.length&&!keyPnum.contains(arrSnbNum[j])){
					//delete
					vo.setOfferSnb( arrSnb[j++] );
					workDAO.deleteOfferInfo(vo);
					log.debug(vo.getRgId()+"^_^workDAO.deleteOfferInfo_"+arrSnb[j-1]);
				}
				if(i<arrNum.length){
					vo.setComment(arrNote[i]);
					cate = new StringBuffer();
					switch( arrNum[i].length() ) {
					case 1: cate.append("0000").append(arrNum[i]); break;
					case 2: cate.append("000").append(arrNum[i]); break;
					case 3: cate.append("00").append(arrNum[i]); break;
					}
					if(keyPsnbNum.contains(arrNum[i])){
						//update
						vo.setOfferSnb( arrSnb[j++] );
						workDAO.updateOfferInfo(vo);
						log.debug(vo.getRgId()+"^_^workDAO.updateOfferInfo_"+cate.toString());
					}else{
						//insert
						vo.setCategoryCd( cate.toString() );
						vo.setOfferSnb( vo.getsNb() );
						cnt += workDAO.insertOfferInfo(vo);
						log.debug(vo.getRgId()+"^_^workDAO.insertOfferInfo_"+cate.toString());
					}
				}
			}
		}catch(Exception e){
			log.error(e);
			e.printStackTrace();
		}

		return cnt;
	}
	/**
	 * 핵심체크 내용 DB입력
	 * @MethodName : insertOfferInfo
	 * @param workVO
	 * @return
	 * @throws Exception
	 */
	public int insertOfferInfoByIbSystem(WorkVO vo) throws Exception{
		int cnt = 0;
		List<WorkVO> slctSnb = this.selectOfferInfo(vo);
		vo.setOfferSnb(slctSnb.get(0).getsNb());//input : offerSnb

		if(vo.getKeyP().length()<0) return 0;

		String arrNote[] 	= vo.getKeyP().split(",")
			 , arrNum[] 	= vo.getKeyPnum().split(",");
		int lengArr = arrNum.length;
		StringBuffer cate = null;

		for(int i=0; i<lengArr; i++){
			cate = new StringBuffer();
			switch( arrNum[i].length() ) {
			case 1: cate.append("0000").append(arrNum[i]); break;
			case 2: cate.append("000").append(arrNum[i]); break;
			case 3: cate.append("00").append(arrNum[i]); break;
			}
			vo.setCategoryCd( cate.toString() );
			vo.setComment(arrNote[i]);
			cnt += this.insertOfferInfo(vo);
			log.debug(vo.getRgId()+"^_^workDAO.insertOfferInfo_"+cate.toString());
		}
		return cnt;
	}

	public Map<String,Integer> insertMemoByIbSystem(WorkVO workVO) throws Exception {

		String[] arr = workVO.getArrayName();

		int cnt = 0, smsCnt = 0;
		List <WorkVO> result= null;
		String rgNm = workDAO.getStaffName(workVO.getRgId());
		/** sms */
		if(workVO.getComment().length() > 80) workVO.setSmsType("5");//3-단문문자, 5-LMS(장문문자), 6-MMS(이미지포함문자)
		else workVO.setSmsType("3");
		//workVO.setSmsSendFlag("3");//1-접수여부, 2-성공여부, 3-모두확인, 4-모두확인안함


		//답장을 위한 메모 로직

		//sub메모가 아니다. 입력자 메모..처음입력...
		if("N".equals(workVO.getSubMemo())){
			workVO.setMainSnb("0");
			workVO.setMemoSndName(rgNm);
			if("Y".equals(workVO.getPriv())){
				workVO.setComment((String) this.selectEncrypt(workVO));
			}

			this.insertMainMemoNreturnSnb(workVO);
			workVO.setSttsCd("00001");
		}
		//sub 메모 중에 mainSnb가 없을떄
		else if("".equals(workVO.getMainSnb())||workVO.getMainSnb()==null||workVO.getMainSnb()=="0"){
			try{
				String temp = workVO.getRgId();
				/*if("00010".equals(loginUser.getPermission())) {
					workVO.setRgId(null);
				}*/

				String strTemp = workVO.getComment();
				//workVO.setComment(strTemp.split("]")[0]);
				strTemp = strTemp.replace("\r", "");
				workVO.setComment(strTemp);

				result = workDAO.selectMemoList(workVO);

				workVO.setRgId(temp);
				if(!result.isEmpty())workVO.setMainSnb(result.get(0).getsNb());

				//workVO.setComment(strTemp);
			}catch(Exception e){
				log.error(e);
				e.printStackTrace();
			}
		}

		//비밀글 전달을 할때(최초글 입력이 아닌타이밍때)
		if(!"N".equals(workVO.getSubMemo()) && "Y".equals(workVO.getPriv())){
			workVO.setComment((String) workDAO.selectEncrypt(workVO));
		}

		for(int i=0;i<arr.length;i++){
			if(!arr[i].equals("")){
				if(rgNm.equals(arr[i])) continue;
				workVO.setMemoSndName(arr[i]);

				try{
					cnt = workDAO.insertMemo(workVO);

				}catch(Exception e){
					log.error(e);
					e.printStackTrace();
				}
			}
		}

		Map<String,Integer> returnMap = new HashMap<String, Integer>();
		returnMap.put("cnt", cnt);
		returnMap.put("smsCnt", smsCnt);
		return returnMap;
	}

	public int modifyMemoByIbSystem(WorkVO workVO) throws Exception {
		int cnt = workDAO.updateMemo(workVO);
		//LOG.debug(loginUser.getId()+"^_^workDAO.updateMemo^_^"+workVO.getsNb());
		cnt = workDAO.updateSendedMemo(workVO);
		//LOG.debug(loginUser.getId()+"^_^workDAO.updateSendedMemo^_^"+workVO.getsNb());
		return cnt;
	}

	public int deleteMemoByIbSystem(WorkVO workVO) throws Exception {
		int cnt = workDAO.deleteMemo(workVO);
		workDAO.deleteSubMemo(workVO);
		return cnt;
	}
	public void mnaMatchingStaffsByIbSystem(WorkVO vo) throws Exception {
		String staffsName = vo.getMemoSndName();
		//입력받은 staff_nm 분리
		String[] arr = staffsName.split(",");
		String[] arrMemo = null;
		int idx = 0, sameCnt = 0;
		//offer_snb로 조회
		List<WorkVO> staffsNm = workDAO.selectOfferMnaStaff(vo);

		if(staffsNm.size()>0){//조회한 data null 아니면
			//조회한 staff_nm 구분자 분리
			String[] arrSel = staffsNm.get(0).getUsrNm().split(",");

			//for문으로 입력받은 진행자와 조회한 진행자 비교 -> 중복N면 메모전송
			int lengArr = arr.length;
			int lengArrSel = arrSel.length;
			arrMemo = new String[arr.length];

			for(int i=0;i<lengArr;i++){
				for(int j=0;j<lengArrSel;j++){
					if(arr[i].equals(arrSel[j])){
						sameCnt++;
					}
				}
				if(sameCnt==1){
					arrMemo[idx++]=arr[i];
					sameCnt = 0;
				}
			}
			//offer_snb로 삭제
			workDAO.deleteOfferMnaStaff(vo);

		}else{
			arrMemo = arr;
		}
		//신규 offer mna staffs 입력
		if(staffsName.length()>0) workDAO.insertOfferMnaStaff(vo);

		//메모전송
		int lengArrMemo = arrMemo.length;
		WorkVO memoVo = new WorkVO();
		Calendar cal = Calendar.getInstance();
		String date = new SimpleDateFormat("yyyyMMdd").format( cal.getTime() );
		StringBuffer strB = new StringBuffer();
		strB.append("[M&A 진행자로 지정] 종목: ").append(vo.getCpnNm()).append(" 딜 -> M&A 탭에서 확인바람.");

		memoVo.setTmDt(date);
		memoVo.setComment(strB.toString());
		memoVo.setSttsCd("00001");
		memoVo.setPriv("N");
		memoVo.setMainSnb("0");
		for(int m = 0; m<lengArrMemo; m++){
			memoVo.setMemoSndName(arrMemo[m]);
			workDAO.insertMemo(memoVo);
			//LOG.debug(loginUser.getId()+"^_^workDAO.insertMemo");
		}
	}
	public int updateprogressCdByIbSystem(WorkVO workVO,Map loginUser) throws Exception {
		log.debug(loginUser.get("loginId").toString()+"^_^workDAO.updateprogressCd^_^"+workVO.getsNb());
		int cnt = workDAO.updateprogressCd(workVO);
		//-------------- 딜 등록자에게 메모 전송 :S -------------
		if(!workVO.getRgNm().equals(loginUser.get("userName").toString())){		//상태변경자가 딜 등록자 본인인 경우에는 skip

			RecommendVO rcmdVO = new RecommendVO();
			rcmdVO.setMemoSndName(workVO.getRgNm());       //딜 등록자 이름으로
			rcmdVO.setRgId(workVO.getRgId());
			rcmdVO.setMainSnb("0");


			rcmdVO.setComment(workVO.getMemo());
			rcmdVO.setPriv("N");

			rcmdVO.setSttsCd("");
			Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMMdd").format( cal.getTime() );
			rcmdVO.setTmDt(date);

			workDAO.insertMemo(rcmdVO);
		}
		//-------------- 딜 등록자에게 메모 전송 :E -------------
		return cnt;
	}
	public int changeprogressCdNmatchCpnByIbSystem(WorkVO workVO) throws Exception {
		int cnt = workDAO.updateProgressCdNmatchCpn(workVO);
		//LOG.debug(loginUser.getId()+"^_^workDAO.updateProgressCdNmatchCpn^_^"+workVO.getsNb());

		if("00002".equals(workVO.getProgressCd()) ) {
			workDAO.insertMnaMatchCpn(workVO);
			//LOG.debug(loginUser.getId()+"^_^workDAO.insertMnaMatchCpn^_^"+workVO.getsNb());
		}
		return cnt;
	}
	public int modifyDealMemoByIbSystem(WorkVO workVO) throws Exception {
		int cnt = workDAO.updateDealMemo(workVO);
		//LOG.debug(loginUser.getId()+"^_^workDAO.updateDealMemo^_^"+workVO.getsNb());

		if("rcmdSendMemo".equals(workVO.getTmpNum1())){
			if(Integer.parseInt(workVO.getProgressCd())<3){
				// Calendar cal = Calendar.getInstance();
				Calendar cal = Calendar.getInstance();
				cal.setTime( new Date(System.currentTimeMillis()) );
				String date = new SimpleDateFormat("yyyyMMdd").format( cal.getTime() );

				workVO.setTmDt(date);
				workVO.setMemoSndName(workVO.getRgNm());
				workVO.setComment("[추천] 종목:"+workVO.getCpnNm()+" - "+workVO.getSubMemo());
				workVO.setSttsCd("00001");
				workVO.setPriv("N");
				workVO.setMainSnb("0");
				try{
					workDAO.insertMemo(workVO);
					//LOG.debug(loginUser.getId()+"^_^workDAO.insertMemo");
				}catch(Exception e){
					log.error(e);
					e.printStackTrace();
				}
			}
		}
		return cnt;
	}

	public int modifyDealResultByIbSystem(WorkVO workVO) throws Exception {
		int cnt = workDAO.updateDealResult(workVO);
		//LOG.debug(loginUser.getId()+"^_^workDAO.updateDealResult^_^"+workVO.getsNb());
		if(true){
			Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMMdd").format( cal.getTime() );

			workVO.setTmDt(date);
			workVO.setSttsCd("00001");
			if(workVO.getOpinion().length()>0){
				try{
					workDAO.insertMemoOfDealResult(workVO);
					//LOG.debug(loginUser.getId()+"^_^workDAO.insertMemoOfDealResult");
				}catch(Exception e){
					log.error(e);
					e.printStackTrace();
				}
			}

		}
		return cnt;
	}
	public int modifyKeyPointChkMemoByIbSystem(WorkVO workVO) throws Exception {
		int cnt = workDAO.updateKeyPointChkMemo(workVO);
		//LOG.debug(loginUser.getId()+"^_^workDAO.updateKeyPointChkMemo^_^"+workVO.getsNb());

		if(true) { //메모전달
			Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMMdd").format( cal.getTime() );

			workVO.setTmDt(date);
			workVO.setMemoSndName(workVO.getRgNm());
			workVO.setComment(workVO.getTmpNum1());
			workVO.setSttsCd("00001");
			workVO.setMainSnb("0");
			try{
				workDAO.insertMemo(workVO);
				//LOG.debug(loginUser.getId()+"^_^workDAO.insertMemo");
			}catch(Exception e){
				log.error(e);
				e.printStackTrace();
			}
		}
		return cnt;
	}
	public void insertDealINallDealByIbSystem(WorkVO workVO,MultipartHttpServletRequest multipartRequest) throws Exception {
		// 코멘트 입력
		workDAO.insertDeal(workVO);

		//분석 등록									//20160422
		if("00004".equals(workVO.getOfferCd())){
			//분석의견 등록(ib_offer_info)

			workVO.setKeyPnum("8");		//분석의견 '00008'
			workVO.setKeyP((String) multipartRequest.getParameter("anal"));
			workVO.setStar((String) multipartRequest.getParameter("star"));
			workVO.setExpirationDt((String) multipartRequest.getParameter("exDt"));

			this.insertOfferInfo(workVO);		//핵심체크사항 분석의견 등록
		}
	}
	public int updateResultByIbSystem(RecommendVO rcmdVO) throws Exception {
		//int cnt = recommendDAO.updateResult(rcmdVO);
		log.debug("^_^recommendDAO.updateResult^_^"+rcmdVO.getsNb());

		if(!("".equals(rcmdVO.getRcmdProposer()) | rcmdVO.getRcmdProposer()==null)) {

			 Calendar cal = Calendar.getInstance();
			cal.setTime( new Date(System.currentTimeMillis()) );
			String date = new SimpleDateFormat("yyyyMMdd").format( cal.getTime() );

			rcmdVO.setTmDt(date);
			rcmdVO.setMemoSndName(rcmdVO.getRcmdProposer());
			rcmdVO.setComment("[딜제안자로 지정] 종목:"+rcmdVO.getCpnNm()+" - 추천메뉴에서 확인바람.");
			rcmdVO.setSttsCd("00001");
			rcmdVO.setPriv("N");
			rcmdVO.setRgId("gjh");
			int memoCnt = workDAO.insertMemo(rcmdVO);
			log.debug("^_^workDAO.insertMemo");

//			System.out.println("\n-------------------\n"+rcmdVO.getTmDt()+"\n-------------------\n"+rcmdVO.getComment()+"\n-------------------\n");

			rcmdVO.setMemoSndName("구자형");
			rcmdVO.setComment("<추천>"+rcmdVO.getCpnNm()+" 딜제안자로 "+rcmdVO.getRcmdProposer()+" 지정 - 추천메뉴에서 확인.");
			rcmdVO.setSttsCd("");

			memoCnt = workDAO.insertMemo(rcmdVO);
		}
		return 1;
	}
	public List<StaffVO> selectStaffList4ib(StaffVO vo) throws Exception {
		return workDAO.selectStaffList4ib(vo);
	}

	/**
	 *
	 * @MethodName : selectFileInfoList
	 * @param vo
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<FileUpDbVO> selectFileInfoList(FileUpDbVO vo) throws Exception {
		return workDAO.selectFileInfoList(vo);
	}

	/**
	 *
	 * @param vo
	 * @MethodName : selectFileInfoListCnt
	 * @param vo
	 * @return
	 */
	public int selectFileInfoListCnt(FileUpDbVO vo) throws Exception {
   	return workDAO.selectFileInfoListCnt(vo);
   }

	/**
	 *
	 * @MethodName : deleteFileInfo
	 * @param vo
	 */
	public int deleteFileInfo(FileUpDbVO vo) throws Exception {
		return workDAO.deleteFileInfo(vo);
	}


	public List<WorkVO> selectComment(WorkVO wVO) throws Exception {
		List<WorkVO> list = workDAO.selectComment(wVO);
		return list;
	}
	public List<WorkVO> selectOpinion(WorkVO wVO) throws Exception {
		List<WorkVO> list = workDAO.selectOpinion(wVO);
		return list;
	}
	public List<WorkVO> selectMainOfferList(WorkVO wVO) throws Exception {
		List<WorkVO> list = workDAO.selectMainOfferList(wVO);
		return list;
	}
	public int insertMainTableCheck(WorkVO wvo) throws Exception {
		int cnt = workDAO.insertMainTableCheck(wvo);
		return cnt;
	}
	public String selectMemo4insertFile(WorkVO vo) throws Exception {
		String result = workDAO.selectMemo4insertFile(vo);
		return result;
	}
	public String selectReply4insertFile(WorkVO vo) throws Exception {
		String result = workDAO.selectReply4insertFile(vo);
		return result;
	}
}