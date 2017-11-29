package ib.person.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ib.basic.service.CpnExcelVO;
import ib.cmm.util.fcc.service.StringUtil;
import ib.company.service.CompanyService;
import ib.company.service.CompanyVO;
import ib.login.service.StaffVO;
import ib.person.service.PersonMgmtService;
import ib.person.service.PersonVO;
import ib.sms.service.SmsService;
import ib.work.service.WorkVO;
import ib.work.service.impl.WorkMemoDAO;


@Service("personMgmtService")
public class PersonMgmtServiceImpl extends AbstractServiceImpl implements PersonMgmtService {

    @Resource(name="personDAO")
    private PersonDAO personDAO;

    @Resource(name="companyService")
    private CompanyService companyService;

    @Resource(name = "smsService")
	private SmsService smsService;

    @Resource(name="workMemoDAO")
    private WorkMemoDAO workMemoDAO;

    protected static final Log logger = LogFactory.getLog(PersonMgmtServiceImpl.class);


	//프로젝트 정보
	public List<Map> getCpnDeptList(Map map) throws Exception {

		List<Map> list = personDAO.getCpnDeptList(map);

		return list;
	}



	//고객리스트
	public List<Map> getCustListForExcel(Map<String, Object> param) throws Exception {
		return personDAO.getCustList(param);
	}
	public Map<String, Object> getCustList(Map<String, Object> param) throws Exception {
		//List<Map> list = personDAO.getCustList(param);
		//return list;

		Map<String, Object> map = new HashMap<String, Object>();
		//parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());

		map.put("pageNo", param.get("pageNo"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.

		int totalCount = personDAO.getCustListCount(param);				//총 건수
		map.put("totalCount", totalCount);

		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;		//총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를 (+1)여부결정
		map.put("pageCount", pageCount);										//총 페이지수

		param.put("offset", (pageNo-1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize

		map.put("list", personDAO.getCustList(param));				//목록리스트

		return map;		//Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총 페이지수), list(리스트)
	}


	//신규할당 고객
	public List<Map> getCustListNewInCharge(Map<String, String> param) throws Exception {
		List<Map> list = personDAO.getCustListNewInCharge(param);

		return list;
	}


	//신규할당 고객 수락
	public int doAcceptCstManager(Map<String, Object> param) throws Exception {

		String cstList = param.get("cstList").toString();
		String[] cstListArr = cstList.split(",");

		String custTypeList = param.get("custTypeList").toString();
		String[] custTypeArr = custTypeList.split(",");

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowStr = sdf.format(now);

		Map<String,Object> categoryPersonMap = new HashMap<String, Object>();
		for(int i = 0 ; i<cstListArr.length;i++){
			String cstId = cstListArr[i];

			param.put("cstId", cstId);

			int updateCstCnt = personDAO.updateCstManager(param);  //// *** 1. 기존 담당자 상태코드 'Y' >> 'T'
			int updateAcceptCstCnt = personDAO.updateAcceptCstManager(param);  //// *** 2. 신규 담당자 상태코드 'A' >> 'Y'


			String custType =  custTypeArr[i];

			param.put("managerCstId", cstId);

			categoryPersonMap.put("categoryPersonCd", custType);
			categoryPersonMap.put("orgId", param.get("orgId"));
			categoryPersonMap.put("cusId", cstId);

			personDAO.doSaveOrgCustomerCate(categoryPersonMap);

			Integer chkDupSnb = personDAO.getChkDupNetCnt(param);
			PersonVO personVO = new PersonVO();
			personVO.setAcceptCstManager("Y");

			personVO.setRelDegree("00001");
			personVO.setNote(nowStr+" : 담당자 지정");
			personVO.setRgId(param.get("loginId").toString());

			if(chkDupSnb!=null){
				personVO.setsNb(chkDupSnb.toString());
				personDAO.modifyNetPoint(personVO);				// 네트워크 수정
			}else{
				personVO.setSnb1st(param.get("cusId").toString());
				personVO.setSnb2nd(cstId);
				personVO.setOrgId(param.get("orgId").toString());
				personDAO.insertNetworkCst(personVO);							// 네트워크 등록
			}

			/**************************************************************************
			 * 기존 담당자가 없었던 경우 타사에 담당자 등록  : 팝업, 메모 전송함
			 * (2017.03.31 이인희)
			 *************************************************************************/
			if(updateCstCnt == 0){
				//전송용 현재시간
				Date from = new Date();
				SimpleDateFormat transFormatNow = new SimpleDateFormat("yyyyMMddHHmmss");
				String strNowDate = transFormatNow.format(from);

				/**
				 * 팝업설정하기
				 */
				Map<String,Object> popMap =  new HashMap<String,Object>();
				popMap.put("orgId", param.get("orgId").toString());
				popMap.put("userId", param.get("userSeq").toString());
				popMap.put("sNb", cstId);
				popMap.put("customerInfoChangeType", "MANAGER");  // 'INFO' 데이터 수정, 'MANAGER' 담당자 변경

				personDAO.insertCustomerInfoChangeConfirm(popMap);

				/**
				 * 메모보내기
				 */
				Map<String,Object> memoMap =  new HashMap<String,Object>();
				int adminUserId = workMemoDAO.getUserIdOfAdmin(memoMap);

				//메모 대상자 생성
				memoMap.put("orgId", param.get("orgId").toString());
				memoMap.put("sNb", cstId);
				List<EgovMap> otherStaffList = personDAO.getOtherStaffList(memoMap);

				memoMap.put("important", "3");
				memoMap.put("roomType", "N");
				memoMap.put("viewDate", strNowDate);
				memoMap.put("userId", adminUserId);

				for(EgovMap oterStaff : otherStaffList){
					//메모룸 생성
					int memoRoomId = workMemoDAO.insertMemoRoom(memoMap);
					memoMap.put("deleteFlag", "N");
					memoMap.put("memoRoomId", memoRoomId);
					memoMap.put("userId",  adminUserId);

					//관리자 엔트리 등록
					memoMap.put("entryUserId", adminUserId);
					int memoRoomEntryId = workMemoDAO.insertRoomEntry(memoMap);

					//타관계사 엔트리 등록
					memoMap.put("entryUserId", oterStaff.get("staffId").toString());
					memoRoomEntryId = workMemoDAO.insertRoomEntry(memoMap);

					//메모코멘트 등록
					String comment = oterStaff.get("cstNm").toString() + " 고객의 "+param.get("orgNm").toString() + " 관계사 담당자가 추가 되었습니다.";
					memoMap.put("comment",  comment);
					int memoCommentId = workMemoDAO.insertMemoComment(memoMap);
				}
			}
		}
		return 1;
	}

	//고객이력, 고객학력 등록
	public int insertCustomerEtc(Map<String, Object> map) throws Exception {
		int cnt = 0;
		if(!StringUtil.isEmpty((String)map.get("schoolNm1"))){
			map.put("schoolType", (String)map.get("schoolType1"));
			map.put("schoolNm", (String)map.get("schoolNm1"));
			map.put("major", (String)map.get("major1"));
			map.put("graduate", (String)map.get("graduate1"));
			cnt = personDAO.insertCustomerSchool(map);									//4. 고객학력 등록
		}
		if(!StringUtil.isEmpty((String)map.get("schoolNm2"))){
			map.put("schoolType", (String)map.get("schoolType2"));
			map.put("schoolNm", (String)map.get("schoolNm2"));
			map.put("major", (String)map.get("major2"));
			map.put("graduate", (String)map.get("graduate2"));
			cnt = personDAO.insertCustomerSchool(map);									//4. 고객학력 등록
		}
		if(!StringUtil.isEmpty((String)(String)map.get("schoolNm3"))){
			map.put("schoolType", (String)map.get("schoolType3"));
			map.put("schoolNm", (String)map.get("schoolNm3"));
			map.put("major", (String)map.get("major3"));
			map.put("graduate", (String)map.get("graduate3"));
			cnt = personDAO.insertCustomerSchool(map);									//4. 고객학력 등록
		}

		if(!StringUtil.isEmpty((String)map.get("companyId1"))){
			map.put("companyId", (String)map.get("companyId1"));
			map.put("departTeam", (String)map.get("departTeam1"));
			map.put("careerMemo", (String)map.get("careerMemo1"));
			map.put("startDate", (String)map.get("startDate1"));
			map.put("endDate", (String)map.get("endDate1"));
			cnt = personDAO.insertCustomerCareer(map);									//5. 고객이력 등록
		}
		if(!StringUtil.isEmpty((String)map.get("companyId2"))){
			map.put("companyId", (String)map.get("companyId2"));
			map.put("departTeam", (String)map.get("departTeam2"));
			map.put("careerMemo", (String)map.get("careerMemo2"));
			map.put("startDate", (String)map.get("startDate2"));
			map.put("endDate", (String)map.get("endDate2"));
			cnt = personDAO.insertCustomerCareer(map);									//5. 고객이력 등록
		}
		return cnt;
	}

	//고객등록(기본 + 담당자 + 네트워크) ... by Map
	public int regCustomer(Map<String, Object> map,PersonVO personVO) throws Exception {
		int cstId = personDAO.regCustomer(map);							//1. 고객(인물) 기본등록

		//Map<String,Object> map = new HashMap<String,Object>();
		map.put("cstId", cstId);
		//map.put("usrCusId", personVO.getUsrCusId());	//담당자 cusId
		map.put("memo", map.get("memo"));			//관계메모
		map.put("userSeq", map.get("staffSnb"));
		//orgId 추가...
		map.put("orgId", map.get("orgId"));
		map.put("regOrgId", map.get("orgId"));

		personDAO.doSaveCstManagerDirect(map);							//2. 담당자 등록

		map.put("cusId", cstId);
		personDAO.doSaveOrgCustomerCate(map);					//직원카테고리저장

		map.put("snb1st", map.get("usrCusId"));		//담당자 cusId
		map.put("snb2nd", cstId);					//고객 cusId
		map.put("note",map.get("memo"));
		personDAO.regNetworkCst(map);									//3. 네트워크 등록

		map.put("customerId", cstId);

		int cnt = insertCustomerEtc(map);  //고객이력, 고객학력 등록

		map.put("netYN","Y");
		return cstId;
	}

	public int updateCustomerByIbSystem(PersonVO personVO, Map<String, Object> map) throws Exception {
		int cnt = personDAO.updateCustomer(personVO);
		cnt = companyService.updateCEO();

		map.put("cstId", personVO.getCstId());
		//map.put("usrCusId", personVO.getUsrCusId());	//담당자 cusId
		map.put("memo", map.get("memo"));			//관계메모
		map.put("userSeq", map.get("staffSnb"));
		//orgId 추가...
		map.put("orgId", map.get("orgId"));
		map.put("loginId", personVO.getRgId());
		personDAO.doUpdateCstManagerDirec(map);			//2. 메모 업데이트

		map.put("cusId", personVO.getCstId());
		personDAO.doSaveOrgCustomerCate(map);					//직원카테고리저장

		cnt = personDAO.doUpdateCstManagerLvCd(map);			//3. 친밀도업데이트

		PersonVO rtnPersonVO = this.getCustomer(personVO);

		if(rtnPersonVO.getStaffId() == null ||rtnPersonVO.getStaffId().equals("")){
			map.put("regOrgId", map.get("orgId"));
			personDAO.doSaveCstManagerDirect(map);							//2. 담당자 등록
		}

		//model.addAttribute("choosePopMain", "modifyCstPopUp");

		if(cnt == 0){  //친밀도 데이터가 없는경우 새로 등록함
			map.put("snb1st", map.get("usrCusId"));		//담당자 cusId
			map.put("snb2nd", personVO.getCstId());					//고객 cusId
			map.put("note",map.get("memo"));

			personDAO.regNetworkCst(map);									//3. 네트워크 등록
		}

		//고객학력,이력 삭제
		cnt = personDAO.deleteCustomerSchool(personVO);
		cnt = personDAO.deleteCustomerCareer(personVO);

		map.put("customerId", personVO.getCstId());
		cnt = insertCustomerEtc(map);  //고객이력, 고객학력 등록

		/**************************************************************************
		 * 고객정보 변경, 담당자변경 및 수정시 : 팝업, 메모 전송함(2017.03.31 이인희)
		 * 고객 데이터 수정, 고객 담당자 생성/변경시
		 * 다른관계사의 해당 고객 담당자에게 고객 정보의 변경, 담당자 할당을 알려주기 위함.
		 * 알림정보를 확인하면 데이터 삭제
		 * 담당자 변경되면 기존 담당자의 데이터 삭제
		 * 한 고객사에서 수정이 여러번, 담당자 변경이 여러번 일어나도 마지막 데이터만 저장함.
		 * 그래서 키는 STAFF_ID, CUSTOMER_ID, UPDATED_ORG_ID, CUSTOMER_INFO_CHANGE_TYPE 복합키임.
		 *************************************************************************/

		/////////////////////////////////////////////////////////
		//전송용 현재시간
		Date from = new Date();
		SimpleDateFormat transFormatNow = new SimpleDateFormat("yyyyMMddHHmmss");
		String strNowDate = transFormatNow.format(from);

		/***
		 * 팝업설정하기
		 */
		Map<String,Object> popMap =  new HashMap<String,Object>();
		popMap.put("orgId", personVO.getOrgId());
		popMap.put("userId", map.get("userId").toString());
		popMap.put("sNb", personVO.getsNb());
		popMap.put("customerInfoChangeType", "INFO");  // 'INFO' 데이터 수정, 'MANAGER' 담당자 변경

		cnt = personDAO.insertCustomerInfoChangeConfirm(popMap);

		if(rtnPersonVO.getStaffId() == null || rtnPersonVO.getStaffId().equals("")){  //담당자가 새로 등록된 경우
			popMap.put("customerInfoChangeType", "MANAGER");  // 'INFO' 데이터 수정, 'MANAGER' 담당자 변경
			cnt = personDAO.insertCustomerInfoChangeConfirm(popMap);
		}

		/***
		 * 메모보내기
		 */
		Map<String,Object> memoMap =  new HashMap<String,Object>();
		int adminUserId = workMemoDAO.getUserIdOfAdmin(memoMap);

		//메모 대상자 생성
		memoMap.put("orgId", personVO.getOrgId());
		memoMap.put("sNb", personVO.getsNb());
		List<EgovMap> otherStaffList = personDAO.getOtherStaffList(memoMap);

		memoMap.put("important", "3");
		memoMap.put("roomType", "N");
		memoMap.put("viewDate", strNowDate);
		memoMap.put("userId", adminUserId);

		for(EgovMap oterStaff : otherStaffList){
			//메모룸 생성
			int memoRoomId = workMemoDAO.insertMemoRoom(memoMap);
			memoMap.put("deleteFlag", "N");
			memoMap.put("memoRoomId", memoRoomId);
			memoMap.put("userId",  adminUserId);

			//관리자 엔트리 등록
			memoMap.put("entryUserId", adminUserId);
			int memoRoomEntryId = workMemoDAO.insertRoomEntry(memoMap);

			//타관계사 엔트리 등록
			memoMap.put("entryUserId", oterStaff.get("staffId").toString());
			memoRoomEntryId = workMemoDAO.insertRoomEntry(memoMap);

			//메모코멘트 등록
			String comment = "";
			int memoCommentId;
			if(rtnPersonVO.getStaffId() == null || rtnPersonVO.getStaffId().equals("")){  //담당자가 새로 등록된 경우
				comment = personVO.getCstNm() + " 고객의 "+map.get("orgNm").toString() + " 관계사 담당자가 추가 되었습니다.";
				memoMap.put("comment",  comment);
				memoCommentId = workMemoDAO.insertMemoComment(memoMap);
			}

			comment = personVO.getCstNm() + " 고객의 "+map.get("orgNm").toString() + " 관계사 담당자가 고객 정보를 업데이트 했습니다";
			memoMap.put("comment",  comment);
			memoCommentId = workMemoDAO.insertMemoComment(memoMap);
		}

		return cnt;
	}



	public Map getCustomerByName(Map<String, Object> map) throws Exception {

		return personDAO.getCustomerByName(map);
	}

	/**
	 * 고객 정보 (1명) ... 핸드폰번호 중복자 체크
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 19.
	 */
	public Map getCustomerSameMobile(Map<String, Object> map) throws Exception {
		return personDAO.getCustomerSameMobile(map);
	}

	/**
	 * 고객 정보 (1명) ... 이름 중복자 체크
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 19.
	 */
	public Map getCustomerSameName(Map<String, Object> map) throws Exception {
		return personDAO.getCustomerSameName(map);
	}

	//고객삭제
	public int doDelCst(Map<String, Object> map) throws Exception {

		return personDAO.doDelCst(map);
	}

	// 사원리스트 (해당 회사의 사원리스트)

	public List getPerList(Map<String,Object> map) throws Exception {
		List<Map> list =personDAO.GetPerList(map);

		return list;
	}

	public List<PersonVO> selectPersonList(PersonVO personVO) throws Exception {
		return personDAO.selectPersonList(personVO);
	}
	public int selectPersonListCnt(PersonVO personVO) throws Exception {
		return personDAO.selectPersonListCnt(personVO);
	}
	public List<PersonVO> selectMainPersonList(PersonVO personVO) throws Exception {
		return personDAO.selectMainPersonList(personVO);
	}

	/**
	 *
	 * @MethodName : selectNetworkList
	 * @param personVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectNetworkList(PersonVO VO,PaginationInfo paginationInfo) throws Exception{
		paginationInfo.setTotalRecordCount(personDAO.selectNetworkListTotalCnt(VO));
		return personDAO.selectNetworkList(VO);
	}
	public Integer selectNetworkListTotalCnt(PersonVO VO) throws Exception {
		return personDAO.selectNetworkListTotalCnt(VO);
	}

	public List<PersonVO> selectMaxSnb(PersonVO personVO) throws Exception {
		return personDAO.selectMaxSnb(personVO);
	}
	public int insertNetworkCst(PersonVO personVO) throws Exception {
		return personDAO.insertNetworkCst(personVO);
	}

	public int insertNote(PersonVO personVO) throws Exception {
		return personDAO.insertNote(personVO);
	}

	public int updateCstPhnByIbSystem(PersonVO personVO) throws Exception {
		int cnt = personDAO.updateCstPhn(personVO);
		log.debug(personVO.getRgId()+"^_^personDAO.updateCstPhn^_^"+personVO.getsNb());
		cnt = companyService.updateCEO();
		log.debug(personVO.getRgId()+"^_^companyDAO.updateCEO");
		return cnt;
	}
	public int excelInsertNote(CpnExcelVO vo) throws Exception {
		return personDAO.excelInsertNote(vo);
	}
	public List<PersonVO> selectExcelDown(PersonVO VO) throws Exception {
		return personDAO.selectExcelDown(VO);
	}
	public int doSaveCstManager(Map<String, Object> map) throws Exception {
		return personDAO.doSaveCstManager(map);
	}

	public int deletePersonNetInfo(PersonVO VO) throws Exception {
		return personDAO.deletePersonNetInfo(VO);
	}
	public int modifyNetPoint(PersonVO VO) throws Exception {
		return personDAO.modifyNetPoint(VO);
	}

	public int doSaveCstManagerDirect(Map<String, Object> map) throws Exception {
		return personDAO.doSaveCstManagerDirect(map);
	}
	public int excelInsertCustomer(CpnExcelVO vo) throws Exception {
		return personDAO.excelInsertCustomer(vo);
	}
	public int selectSearchDuplicateB4excelInsert(WorkVO psnVo) throws Exception {
		return personDAO.selectSearchDuplicateB4excelInsert(psnVo);
	}

	/**
	 *
	 * @MethodName : selectStaffList
	 * @param staffVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectStaffList(Map<String,Object>map) throws Exception{
		return personDAO.selectStaffList(map);
	}

	/**
	 *
	 * @MethodName : selectStaff
	 * @param staffVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Map> selectStaff(Map<String, String> map) throws Exception{
		return personDAO.selectStaff(map);
	}


	/**
	 *
	 * @MethodName : updateStaffInformation
	 * @param psnVo
	 */
	public int updateStaffInformation(StaffVO VO) throws Exception {
		return personDAO.updateStaffInformation(VO);
	}

	/**
	 *
	 * @MethodName : updateIBstaffwithInside
	 * @param stVo
	 * @return
	 */
	public Integer updateIBstaffwithInside(StaffVO VO) throws Exception {
		return personDAO.updateIBstaffwithInside(VO);
	}

	/**
	 * 고객이력 목록
	 * @MethodName : selectCustomerCareerList
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCustomerCareerList(PersonVO VO) throws Exception{
		return personDAO.selectCustomerCareerList(VO);
	}

	/**
	 * 고객학력 목록
	 * @MethodName : selectCustomerSchoolList
	 * @param companyVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCustomerSchoolList(PersonVO VO) throws Exception{
		return personDAO.selectCustomerSchoolList(VO);
	}

	/**
	 * 고객 정보 (1명)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 3. 16.
	 */
	public PersonVO getCustomer(PersonVO personVO) throws Exception {
		return personDAO.getCustomer(personVO);
	}
	/**
	 *
	 * @MethodName : getCpnUserList
	 * @param String
	 * @return
	 */
	public List<EgovMap> getCpnUserList(String cpnId) throws Exception {
		return personDAO.getCpnUserList(cpnId);
	}

	public List<EgovMap> getCustomerOrgIdList(PersonVO personVO) throws Exception {
		return personDAO.getCustomerOrgIdList(personVO);
	}

	//담당자 정보를 조회한다
	public EgovMap getOtherOrgStaff(Map<String,Object> map) throws Exception{
		return personDAO.getOtherOrgStaff(map);
	}

	/**
	 * 사용자이름 가져오기
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2017. 2. 13.
	 */
	public List<EgovMap> getUserNameList(Map<String, Object> map) throws Exception {
		return personDAO.getUserNameList(map);
	}

	//전체 관계사 목록 (네트워크 > 고객 > 상세팝업)
	public List<Map> getOrgIdListForCustomer(PersonVO personVO) throws Exception{
		return personDAO.getOrgIdListForCustomer(personVO);
	}
	//담당고객정보수정확인 리스트
	public List<Map> getCustomerChangeConfirmList(Map<String, Object> map) throws Exception{
		return personDAO.getCustomerChangeConfirmList(map);
	}
	//고객 알림 팝업 노출 여부 판단
	public Integer getChkPersonNoticeInfo(Map<String, Object> map) throws Exception{
		return personDAO.getChkPersonNoticeInfo(map);
	}

	//고객 알림 데이터 삭제
	public Integer deleteCustomerInfoChange(Map<String, Object> map) throws Exception{
		return personDAO.deleteCustomerInfoChange(map);
	}
	//인물삭제
	public String deleteCustomer(Map<String,Object> paramMap) throws Exception{
		Integer deleteCompanyInfo = personDAO.getDeleteCustomerInfo(paramMap);
		String returnStr = "SUCCESS";
		if(deleteCompanyInfo > 0){
			returnStr = "FAIL";
		}else {
			Integer cnt = personDAO.deleteCustomerInfo(paramMap);
		}

		return returnStr;
	}
}
