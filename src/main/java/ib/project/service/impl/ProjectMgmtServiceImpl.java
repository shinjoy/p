package ib.project.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import ib.cmm.util.sim.service.EtcUtil;
import ib.common.util.DateUtil;
import ib.project.service.ProjectMgmtService;
import ib.work.service.WorkMemoService;


@Service("projectMgmtService")
public class ProjectMgmtServiceImpl extends AbstractServiceImpl implements ProjectMgmtService {

    @Resource(name="projectMgmtDAO")
    private ProjectMgmtDAO projectMgmtDAO;

    @Resource(name="workMemoService")
	private WorkMemoService workMemoService;

    protected static final Log logger = LogFactory.getLog(ProjectMgmtServiceImpl.class);



	//리스트
	public Map<String, Object> getProjectList(Map<String, Object> param) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		//parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());

		map.put("pageNo", param.get("pageNo"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.

		int totalCount = projectMgmtDAO.getProjectListCount(param);			//총 건수
		map.put("totalCount", totalCount);

		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;		//총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를 (+1)여부결정
		map.put("pageCount", pageCount);										//총 페이지수

		param.put("offset", (pageNo-1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize

		map.put("list", projectMgmtDAO.getProjectList(param));				//목록리스트

		return map;		//Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총 페이지수), list(리스트)
	}


	//프로젝트 등록
	public int insertProject(Map<String, Object> map) throws Exception {

		Integer projectHistoryId = 0;
		//--------------------- 프로젝트 등록 :S ---------------------
		int projectId = projectMgmtDAO.insertProject(map);

		//정상 저장 됬고 확정일때(임시저장건은 등록하지 않는다)
		if(projectId >0 && (map.get("confirm").toString()).equals("Y")){

			map.put("projectId", projectId);
			// 프로젝트 이력 남기기
			map.put("updateReason", map.get("sessionProjectTitle").toString()+" 확정");
			projectHistoryId = projectMgmtDAO.insertProjectHistroy(map);
			map.put("projectHistoryId", projectHistoryId);
		}
		//--------------------- 프로젝트 등록 :E ---------------------

		//--------------------- activity 등록 :S ---------------------

		mergeActivity(map);
		//--------------------- activity 등록 :E ---------------------

		//--------------------- 지켜보는직원 등록 :S ---------------------

		insertViewEntryUser(map);

		//--------------------- 지켜보는직원 등록 :E ---------------------

		//프로젝트 히스토리에 정상 저장(확정)
		if(projectHistoryId > 0 && (map.get("enable").toString()).equals("Y")){

			List <Map> beforeProjectInfo = projectMgmtDAO.getProjectInfo(map);		//프로젝트
			Map beforeProjectInfoMap = beforeProjectInfo.get(0);


			Map memoSendMap = new HashMap();

			memoSendMap.put("projectId", projectId);

			memoSendMap.put("orgId", map.get("orgId").toString());
			memoSendMap.put("userId", map.get("userSeq").toString());

			memoSendMap.put("sessionProjectTitle", map.get("sessionProjectTitle").toString());
			memoSendMap.put("projectName", map.get("projectName").toString());
			memoSendMap.put("projectCode", beforeProjectInfoMap.get("projectCode").toString());

			memoSendMap.put("userName", map.get("userName").toString());

			memoSendMap.put("memoKindStr","등록");

			String memoComment ="\n\n 위 "+map.get("sessionProjectTitle").toString()+"이 확정되었으며 참여자로 설정되셨습니다.";
			//바뀐 프로젝트 정보 와 직전 프로젝트 정보 비교

			memoSendMap.put("memoComment", memoComment);

			int cnt = doSendMemoByProject(memoSendMap);		//메모 발송 세팅

		}


		return projectId;
	}

	//기본 프로젝트 등록(관계사 생성시)
	public void insertBaseProject(Map<String, Object> map) throws Exception {
		List<Map> baseProjectMapList = projectMgmtDAO.getBaseProjectList(map);
		for(int i = 0 ; i < baseProjectMapList.size() ; i++){
			Map projectMap = baseProjectMapList.get(i);
			int baseProjectId = Integer.parseInt(projectMap.get("projectId").toString());
			//--------------------- 프로젝트 등록 :S ---------------------
			int projectId = projectMgmtDAO.insertBaseProject(projectMap);
			//--------------------- 프로젝트 등록 :E ---------------------
			projectMap.put("baseProjectId", baseProjectId);
			List<Map> baseActivityMapList = projectMgmtDAO.getBaseActivityList(projectMap);
			if(baseActivityMapList!=null&&baseActivityMapList.size()>0){
				//--------------------- activity 등록 :S ---------------------
				map.put("projectId", projectId);
				map.put("baseActivityMapList", baseActivityMapList);
				projectMgmtDAO.insertBaseActivity(map);
				//--------------------- activity 등록 :E ---------------------
			}
		}
	}

	//프로젝트 수정
	public void updateProject(Map<String, Object> map) throws Exception {

		//--------------------- 프로젝트 저장 :S ---------------------
		Integer projectHistoryId = 0;
		boolean sendMemoYn = false;

		//저장 직전 프로젝트 정보
		Map param = new HashMap();
		param.put("orgId", map.get("orgId").toString());
		param.put("projectId", map.get("projectId").toString());
		List <Map> beforeProjectInfo = projectMgmtDAO.getProjectInfo(param);		//프로젝트
		List <Map> beforeEntryUserList = projectMgmtDAO.getProjectUserList(param);	//참여직원

		if(beforeProjectInfo.size()>0){

			Map beforeProjectInfoMap = beforeProjectInfo.get(0);

			String beforeConfirm = beforeProjectInfoMap.get("confirm").toString();
			String beforeStopFlag = beforeProjectInfoMap.get("stopFlag").toString();
			String beforePendingFlag = beforeProjectInfoMap.get("pendingFlag").toString();
			String beforeProjectCode = beforeProjectInfoMap.get("projectCode").toString();
			String beforeOpenFlag = beforeProjectInfoMap.get("openFlag").toString();

			//map.put("stopFlag",  map.get("enable").toString().equals("Y") ? "N" : "Y");

			projectMgmtDAO.updateProject(map);

			// 프로젝트 이력 남기기
			if((map.get("confirm").toString()).equals("Y")){



				if(!beforeConfirm.equals("Y")) map.put("updateReason", map.get("sessionProjectTitle").toString()+" 확정");
				else map.put("updateReason", map.get("updateReason").toString());

				//중지 보류 값은 전에 값 그대로
				map.put("stopFlag", beforeStopFlag);
				map.put("pendingFlag", beforePendingFlag);
				projectHistoryId = projectMgmtDAO.insertProjectHistroy(map);

				map.put("projectHistoryId", projectHistoryId);
				map.put("projectCode", beforeProjectCode);

				//보류 중지 상태인지(보류중지는 수정화면에서 바꿀수 없음으로 전의 값으로 판별)
				if(beforeStopFlag.equals("N") && beforePendingFlag.equals("N")){
					sendMemoYn = true;

				}


			}

			//--------------------- 프로젝트 저장 :E ---------------------

			//--------------------- activity 등록 :S ---------------------

			map.put("sendMemoYn", sendMemoYn);
			mergeActivity(map);

			//--------------------- activity 등록 :E ---------------------

			//--------------------- 지켜보는직원 등록 :S ---------------------

			projectMgmtDAO.deleteViewEntryUser(map);		//프로젝트 해당 사람들 다지우고
			insertViewEntryUser(map);						//새로 저장

			//--------------------- 지켜보는직원 등록 :E ---------------------

			//--------------------- 수정이력 메모발송 :S ---------------------

			Map memoSendMap = new HashMap();


			memoSendMap.put("sessionProjectTitle", map.get("sessionProjectTitle").toString());
			memoSendMap.put("projectName", map.get("projectName").toString());
			memoSendMap.put("projectCode", beforeProjectCode);
			memoSendMap.put("userName", map.get("userName").toString());
			memoSendMap.put("projectId", map.get("projectId").toString());
			memoSendMap.put("orgId", map.get("orgId").toString());
			memoSendMap.put("userId", map.get("userSeq").toString());

			String memoComment = "";

			//직전 프로젝트 정보(BS_PROJECT)에 있고, 확정상태일때만 메모발송 , 중단 보류 상태가 아닐때만 발송
			if(sendMemoYn){

				//확정된건 수정
				if(beforeConfirm.equals("Y")){

					//사용 여부 Y
					if(map.get("enable").toString().equals("Y")){

						memoSendMap.put("beforeEntryUserList", beforeEntryUserList);
						memoSendMap.put("userUpdateChk", "Y");
						memoSendMap.put("updateReason", map.get("updateReason").toString());
						memoSendMap.put("employee", map.get("employee").toString());
						memoSendMap.put("beforeEmployee", beforeProjectInfoMap.get("employee").toString());

						memoSendMap.put("memoKindStr","수정");


						//기간
						String beforePeriod = beforeProjectInfoMap.get("period").toString();
						String beforeStartDate = beforeProjectInfoMap.get("startDate").toString();
						String beforeEndDate = beforeProjectInfoMap.get("endDate").toString();
						String afterStartDate =  map.get("startDate").toString();
						String afterEndDate =  map.get("endDate").toString();

						//공개여부
						String afterOpenFlag =  map.get("openFlag").toString();


						//바뀐 프로젝트 정보 와 직전 프로젝트 정보 비교

						//기간
						if((!beforeStartDate.equals(afterStartDate) ||  !beforeEndDate.equals(afterEndDate))

							||! map.get("period").toString().equals(beforePeriod)){
							memoComment +=  "[기간변경] \n";


							if(beforePeriod.equals("Y")){
								memoComment +=  "-변경전 : " + beforeStartDate +"~" + beforeEndDate+"\n";

							}else{
								memoComment +=  "-변경전 : 무기한 \n";

							}

							if(map.get("period").toString().equals("Y")){
								memoComment +=  "-변경후 : " + afterStartDate +"~" + afterEndDate+"\n\n";
							}else{
								memoComment +=  "-변경후 : 무기한 \n";
							}

						}

						//공개여부
						if(!beforeOpenFlag.equals(afterOpenFlag)){
							memoComment +=  "[공개여부변경] \n";
							memoComment +=  "-변경전 : " + (beforeOpenFlag.equals("Y") ? "공개" : "비공개") +"\n";
							memoComment +=  "-변경후 : " + (afterOpenFlag.equals("Y") ? "공개" : "비공개") +"\n\n";
						}
					}

					//사용 상태변경
					if(!(map.get("enable").toString()).equals(beforeProjectInfoMap.get("enable").toString())){

						String typeKor = map.get("enable").toString().equals("Y") ? "사용" : "사용중지";

						if(map.get("enable").toString().equals("N")) memoSendMap.put("memoKindStr", "상태변경");

						memoComment +=  "[변경내용]\n"+memoSendMap.get("sessionProjectTitle").toString() +" "+ typeKor + "  처리 됨\n\n" ;
					}

				//확정되지 않은건을 확정 시킴(수정에서)
				}else{

					memoSendMap.put("employee", map.get("employee").toString());
					memoSendMap.put("memoKindStr","등록");


					memoComment ="\n\n 위 "+map.get("sessionProjectTitle").toString()+"이 확정되었으며 참여자로 설정되셨습니다.";
					//바뀐 프로젝트 정보 와 직전 프로젝트 정보 비교

				}

				memoSendMap.put("memoComment", memoComment);
				doSendMemoByProject(memoSendMap);

			}



		}

		//--------------------- 수정이력 메모발송 :E ---------------------

	}

	//프로젝트 정보
	public List<Map> getProjectInfo(Map map) throws Exception {

		List<Map> list = projectMgmtDAO.getProjectInfo(map);

		List<Map> eList = projectMgmtDAO.getProjectUserList(map);		//activity 별 배정직원 리스트
		list.get(0).put("empList", (eList.size()>0)?eList:"");			//배정직원 정보 추가

		return list;
	}

	//activity 리스트
	public List<Map> getActivityList(Map map) throws Exception {

		List<Map> list = projectMgmtDAO.getActivityList(map);			//activity


		List<Map> eList = null;
		for(int i=0; i<list.size(); i++) {
			eList = projectMgmtDAO.getActivityUserList(list.get(i));			//activity 별 배정직원 리스트
			list.get(i).put("empList", (eList.size()>0)?eList:"");		//배정직원 정보 추가
			list.get(i).put("empListDel", "");							//배정직원 삭제 key 추가(화면에서 추가될 빈 key 생성)
		}

		return list;
	}


	//개인별 기본 project 및 activity 등록
	public int changeUserDefaultPjtAct(Map<String, Object> map) throws Exception {

		return projectMgmtDAO.changeUserDefaultPjtAct(map);
	}


	//개인별 프로젝트 리스트
	public Map<String, Object> getUserProjectList(Map<String, Object> param) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		//parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());

		map.put("pageNo", param.get("pageNo"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.
		int totalCount = 0;

		if(param.get("userId") != null){
			totalCount = projectMgmtDAO.getUserProjectListCount(param);			//총 건수
		}

		map.put("totalCount", totalCount);

		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;		//총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를 (+1)여부결정
		map.put("pageCount", pageCount);										//총 페이지수

		param.put("offset", (pageNo-1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize

		List<Map>list = new ArrayList();

		if(param.get("userId") != null){
			list = projectMgmtDAO.getUserProjectList(param);			//총 건수
		}


		map.put("list", list);				//목록리스트

		return map;		//Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총 페이지수), list(리스트)
	}


	//개인별 프로젝트 정보
	public List<Map> getUserProjectInfo(Map map) throws Exception {

		List<Map> list = projectMgmtDAO.getUserProjectList(map);

		List<Map> eList = projectMgmtDAO.getProjectUserList(map);		//프로젝트 별 배정직원 리스트
		list.get(0).put("empList", (eList.size()>0)?eList:"");			//배정직원 정보 추가

		return list;
	}

	//개인별 activity 리스트
	public List<Map> getUserActivityList(Map map) throws Exception {

		List<Map> list = projectMgmtDAO.getUserActivityList(map);			//activity


		List<Map> eList = null;
		for(int i=0; i<list.size(); i++) {
			eList = projectMgmtDAO.getActivityUserList(list.get(i));		//activity 별 배정직원 리스트
			list.get(i).put("empList", (eList.size()>0)?eList:"");		//배정직원 정보 추가
			list.get(i).put("empListDel", "");							//배정직원 삭제 key 추가(화면에서 추가될 빈 key 생성)
		}

		return list;
	}

	//프로젝트, activity 별 배정직원 등록
	public void updateProjectUserAlloc(Map<String, Object> map) throws Exception {

		projectMgmtDAO.mergeActivityUserAlloc(map);			//프로젝트 activity 배정정보 등록

	}


	//프로젝트 삭제
	public void deleteProject(Map<String, Object> map) throws Exception {
		projectMgmtDAO.deleteActivity(map);			//activity
		projectMgmtDAO.deleteProject(map);			//프로젝트
	}


	//개인별 activity list (타임시트 사용)
	public List<Map> getUserActivityListForTimesheet(Map<String, Object> map) throws Exception{
		return projectMgmtDAO.getUserActivityListForTimesheet(map);			//activity
	}

	//프로젝트/엑티비티 조회 (공통js)
	public List<Map> getBaseCommonProject(Map<String, String> param) throws Exception {

        if(param.get("code") == null || param.get("code").equals("")){
            param.put("code", "cd");
        }
        if(param.get("name") == null || param.get("name").equals("")){
            param.put("name", "nm");
        }
        if(param.get("lang") == null || param.get("lang").equals("")){
            param.put("lang", "KOR");
        }
        Map<String,List<Map>> returnMap = new HashMap<String, List<Map>>();

        //프로젝트 조회인지 엑티비티 조회인지 판단한다
        String type = param.get("type").toString();

        String cardYn = param.get("incCardActivity")==null?"N":param.get("incCardActivity").toString();
        String isScheSearch = param.get("isScheSearch")==null?"N":param.get("isScheSearch").toString();  //스케줄 조회용인경우 분기처리함

        if(type.equals("PROJECT")){
        	if(cardYn.equals("Y")){
        		List<Map> resultList = projectMgmtDAO.getBaseCommonProjectForCard(param);
        		returnMap.put("list", resultList);
        	}else if(isScheSearch.equals("Y")){
        		List<Map> resultList = projectMgmtDAO.getBaseCommonProjectForScheSearch(param);
        		returnMap.put("list", resultList);
        	}else{
        		List<Map> resultList = projectMgmtDAO.getBaseCommonProject(param);
        		returnMap.put("list", resultList);
        	}
        }else if(type.equals("ACTIVITY")){
        	if(cardYn.equals("Y")){
        		List<Map> resultList = projectMgmtDAO.getBaseCommonActivityForCard(param);
	        	returnMap.put("list", resultList);
        	}else if(isScheSearch.equals("Y")){
        		List<Map> resultList = projectMgmtDAO.getBaseCommonActivityForScheSearch(param);
	        	returnMap.put("list", resultList);
        	}else{
        		List<Map> resultList = projectMgmtDAO.getBaseCommonActivity(param);
	        	returnMap.put("list", resultList);
        	}
        }

		return returnMap.get("list");
	}

	//마감일에 대한 데이터 조회
	public Map<String, Object> chkCloseDateInfo(Map<String, Object> map) throws Exception{

		return projectMgmtDAO.chkCloseDateInfo(map);
	}

	//출장비, 구매품의 ,교육품의,지출 프로젝트 금액 벨리데이션
	public EgovMap getProjectExpenseValid(Map<String, String> map) throws Exception{
		return projectMgmtDAO.getProjectExpenseValid(map);
	}


	//리스트
	public Map<String, Object> getExpenseList(Map<String, Object> param) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		//parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());

		map.put("pageNo", param.get("pageNo"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.

		int totalCount = projectMgmtDAO.getExpenseListCount(param);			//총 건수
		map.put("totalCount", totalCount);

		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;		//총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를 (+1)여부결정
		map.put("pageCount", pageCount);										//총 페이지수

		param.put("offset", (pageNo-1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize

		map.put("list", projectMgmtDAO.getExpenseList(param));				//목록리스트

		return map;		//Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총 페이지수), list(리스트)
	}


/**
	 * activity 배정직원 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 11. 18.
	 */
	public List<Map> getActivityUserList(Map map) throws Exception{

		return projectMgmtDAO.getActivityUserList(map);
	}

	//프로젝트 수정
	public int copyProject(Map<String, Object> map) throws Exception {
		map.put("oldProjectId", map.get("pId").toString());

		int newProjectId = projectMgmtDAO.copyProject(map);  //프로젝트 복사
		map.put("newProjectId", newProjectId);
		projectMgmtDAO.copyProjectUser(map);  //프로젝트 참여자 복사

		//복사할 Activy 목록 조회
		Map activityMap = new HashMap();
		activityMap.put("projectId", map.get("pId").toString());
		List<Map> activityList = projectMgmtDAO.getActivityList(activityMap);

		for(Map rtnMap : activityList){
			map.put("oldActivityId", rtnMap.get("activityId").toString());
			int newActivityId = projectMgmtDAO.copyActivity(map);  //엑티비티 복사

			map.put("newActivityId", newActivityId);
			projectMgmtDAO.copyActivityUser(map);  //엑티비티 참여자 복사
		}

		return newProjectId;
	}

	/************************************************************************************
	 * 기본 프로젝트
	 ************************************************************************************/

	//프로젝트 ID 값 구하기
	public EgovMap getBaseProjectId(Map<String, Object> map) throws Exception{
		return projectMgmtDAO.getBaseProjectId(map);
	}

	//프로젝트 정보
	public EgovMap getBaseProjectInfo(Map map) throws Exception {

		EgovMap projectMap = projectMgmtDAO.getBaseProjectInfo(map);
		List<Map> eList = projectMgmtDAO.getProjectUserList(map);		//activity 별 배정직원 리스트
		projectMap.put("empList", (eList.size()>0)?eList:"");			//배정직원 정보 추가

		return projectMap;
	}

	//activity 리스트
	public List<Map> getBaseActivityList(Map map) throws Exception {

		List<Map> list = projectMgmtDAO.getBaseActivityList(map);			//activity
		List<Map> eList = null;
		for(int i=0; i<list.size(); i++) {
			list.get(i).put("empList", "");		//배정직원 정보 추가
			list.get(i).put("empListDel", "");							//배정직원 삭제 key 추가(화면에서 추가될 빈 key 생성)
		}
		return list;
	}

	//프로젝트 수정
	public void updateBaseProject(Map<String, Object> map) throws Exception {
		projectMgmtDAO.updateBaseProject(map);
		projectMgmtDAO.mergeBaseActivity(map);
	}

	//프로젝트 상태변경(보류,중단,보류취소,중단취소)
	public int processStatus(Map<String, Object> map) throws Exception{

		int cnt = 0;
		String type = map.get("status").toString();
		String typeKor = "";

		if(type.equals("PENDING")){

			map.put("pendingFlag", "Y");
			map.put("stopFlag", "N");
			typeKor = "보류";

		}else if(type.equals("STOP")){
			map.put("pendingFlag", "N");
			map.put("stopFlag", "Y");
			typeKor = "중단";

		}else if(type.equals("PENDING_CANCEL")){
			map.put("pendingFlag", "N");
			map.put("stopFlag", "N");
			typeKor = "보류취소";

		}else if(type.equals("STOP_CANCEL")){
			map.put("pendingFlag", "N");
			map.put("stopFlag", "N");
			typeKor = "중단취소";
		}
		cnt = projectMgmtDAO.updateProjectStatus(map);



		if(cnt > 0){

			map.put("memoKindStr", "상태변경");

			map.put("projectId", map.get("pId").toString());
			map.put("sessionProjectTitle", map.get("sessionProjectTitle").toString());

			map.put("userName", map.get("userName").toString());
			map.put("userId", map.get("userSeq").toString());
			map.put("orgId", map.get("orgId").toString());

			String memoComment = map.get("sessionProjectTitle").toString() +" "+ typeKor + "  처리 됨" ;

			List <Map> projectInfo =  projectMgmtDAO.getProjectInfo(map);		//프로젝트 정보

			if(projectInfo.size()>0){

				projectInfo.get(0).put("updateReason", memoComment);
				projectInfo.get(0).put("projectName", projectInfo.get(0).get("name").toString());
				projectInfo.get(0).put("projectDesc", projectInfo.get(0).get("description").toString());
				projectInfo.get(0).put("userSeq", map.get("userSeq").toString());

				projectInfo.get(0).put("pendingFlag", projectInfo.get(0).get("pendingFlag").toString());
				projectInfo.get(0).put("stopFlag", projectInfo.get(0).get("stopFlag").toString());

				// 프로젝트 이력 남기기
				Integer projectHistoryId = projectMgmtDAO.insertProjectHistroy(projectInfo.get(0));

				map.put("projectName", projectInfo.get(0).get("projectName").toString());
				map.put("projectCode", projectInfo.get(0).get("projectCode").toString());
				map.put("projectHistoryId", projectHistoryId);
				projectMgmtDAO.insertProjectUserHistAll(map);		//기존 참가자들 히스토리

				map.put("memoComment", "[변경내용]\n"+memoComment);

				//사용 Y 일때만 메모전송
				if((projectInfo.get(0).get("enable")).equals("Y")) doSendMemoByProject(map);

			}

		}

		return cnt;
	}

	// 프로젝트 배정직원 리스트
	public List<Map> getProjectUserList(Map map) throws Exception{
		return projectMgmtDAO.getProjectUserList(map);
	}

	// 프로젝트 현황별 리스트 (프로젝트 현황 디테일 화면)
	public List<Map> searchProjectStatusList(Map map) throws Exception{
    	return projectMgmtDAO.searchProjectStatusList(map);
    }
	// 전자계약 : 기본양식 : 프로젝트 조회
	public List<EgovMap> getAppvProjectList(Map<String,Object> map) throws Exception{
		Integer totCnt =0;

        totCnt = projectMgmtDAO.getAppvProjectListTotalCnt(map);
        map.put("totCnt", totCnt);
		return projectMgmtDAO.getAppvProjectList(map);
	}

	//지출 일괄 비차감 처리
	public Integer processNonExpenseAll(Map map) throws Exception{

		String[] mCheck = (String[])map.get("mCheck");

		//비차감
		map.put("deductYn", "N");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

		String nowDateStr = sdf.format(new Date());
		String comment = nowDateStr + " "+map.get("userName")+" 차감해지함.";
		map.put("comment", comment);

		for(String mCheckStr :mCheck){

			String[] mCheckBuf = mCheckStr.split("[|]");
			String projectId = mCheckBuf[0];
			String activityId = mCheckBuf[1];
			String projectExpenseRefId = mCheckBuf[2];
			String projectExpenseType = mCheckBuf[3];
			String projectExpenseClass = mCheckBuf[4];
			String price = mCheckBuf[5];
			String expenseInputUserId = mCheckBuf[6];
			String expenseDate = mCheckBuf[7];

			map.put("projectId", projectId);
			map.put("activityId", activityId);
			map.put("projectExpenseRefId", projectExpenseRefId);
			map.put("projectExpenseType", projectExpenseType);
			map.put("projectExpenseClass", projectExpenseClass);
			map.put("expenseAmount", price);
			map.put("expenseInputUserId", expenseInputUserId);
			map.put("expenseDate", expenseDate);

			projectMgmtDAO.insertProcessNonExpenseAll(map);

		}

		return 0;
	}

	//지출 차감 처리
    public Integer processExpense(Map map) throws Exception{
    	map.put("deductYn", "Y");

    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

		String nowDateStr = sdf.format(new Date());
		String comment = nowDateStr + " "+map.get("userName")+" 차감처리함.";
		map.put("comment", comment);
    	return projectMgmtDAO.insertProjectExpense(map);
    }
    //지출 관련 상세 팝업 열람 권한 체크
    public String getValidProjectExpenseView(Map map) throws Exception{
    	String resultMsg = "SUCCESS";

    	String projectExpenseType = map.get("projectExpenseType").toString();

    	Integer cnt = 0;

    	if(projectExpenseType.equals("APPROVE")){
    		cnt = projectMgmtDAO.getValidProjectExpenseViewForApprove(map);

    		if(cnt == null ||cnt==0){
    			resultMsg = "문서열람권한이 없습니다.\n상신자, 결재/합의자에게 참조 혹은 수신자로 추가요청 후 적용되면 열람가능해 집니다.";
    		}
    	}else if(projectExpenseType.equals("CARD")){
    		cnt = projectMgmtDAO.getValidProjectExpenseViewForCard(map);

    		if(cnt == null ||cnt==0){
    			resultMsg = "문서열람권한이 없습니다.\n지출입력(법인카드)건은 본인 작성건과 팀장의 경우 팀원이 작성한 내역 열람가능합니다.";
    		}
    	}

    	return resultMsg;
    }

    //리스트
  	public List<Map> getProjectTreeList(Map<String, Object> param) throws Exception {

  		int totalCount = projectMgmtDAO.getProjectListCount(param);			//총 건수
  		param.put("totCnt", totalCount);
  		return projectMgmtDAO.getProjectList(param);
  	}

  	//프로젝트현황 > wbs summarymap
  	public List<EgovMap> searchWbsSummaryMapList(Map<String, Object> map) throws Exception{
  		return projectMgmtDAO.searchWbsSummaryMapList(map);
  	}

  	//해당 연도의 업무를 조회한다
  	public List<EgovMap> getWbsWorkSearchList(Map<String, Object> map) throws Exception{
  		return projectMgmtDAO.getWbsWorkSearchList(map);
  	}
  	//해당 연도의 업무 진척율을 조회한다
  	public EgovMap getWbsWorkActivityTotMap(Map<String, Object> map,List<EgovMap> wbsWorkSearchList) throws Exception{

  		EgovMap getActivityProgress = projectMgmtDAO.getWbsWorkActivityTotMap(map);

  		String endDateStr = map.get("endDate").toString();
  		String endDateYear = endDateStr.split("-")[0];
  		String period = endDateYear.equals("9999")?"Y":"N";
  		if(getActivityProgress==null){

  			getActivityProgress = new EgovMap();

  			getActivityProgress.put("ACTIVITY_PROGRESS_ID", 0);
  			getActivityProgress.put("ACTIVITY_ID", map.get("activityId"));
  			getActivityProgress.put("PROGRESS_YEAR", map.get("year"));
  			getActivityProgress.put("PROGRESS_RATE", 0);
  			getActivityProgress.put("CREATE_DATE",null);
  			getActivityProgress.put("CREATED_BY", null);
  			getActivityProgress.put("UPDATE_DATE", null);
  			getActivityProgress.put("UPDATED_BY", null);
  			getActivityProgress.put("BASE_PROGRESS_YN", "Y");

  			if(period.equals("Y")){

	  			Integer year = Integer.parseInt(map.get("year").toString());

	  			String startDate = map.get("startDate").toString();

	  			Integer startYear = Integer.parseInt(startDate.split("-")[0]);


	  			Date startDt;
	  			Date endDt;


	  			if(startYear<year) startDt = DateUtil.getDate(year+"-01-01","yyyy-MM-dd");
	  			else startDt = DateUtil.getDate(map.get("startDate").toString(),"yyyy-MM-dd");
	  			//String
	  			endDt = DateUtil.getDate(year+"-12-31","yyyy-MM-dd");

	  			Integer activityDateDiff = DateUtil.getDiffDayCountTwoDate(startDt,endDt);

	  			if(activityDateDiff!=null&&activityDateDiff>0){
	  				Date now = new Date();

	  				if(year>startYear){
	  					getActivityProgress.put("PROGRESS_RATE", 100);
	  				}else if(year.equals(startYear)){
	  					Integer afterDateDiff = DateUtil.getDiffDayCountTwoDate(startDt,now);

		  				if(afterDateDiff!=null&&afterDateDiff>0){
		  					Double progressRate = ((afterDateDiff+0.0)/activityDateDiff*100);

		  					getActivityProgress.put("PROGRESS_RATE", progressRate);
		  				}
	  				}

	  			}
  			}else{
  				if(wbsWorkSearchList!=null&&wbsWorkSearchList.size()!=0){
  					float totCnt = wbsWorkSearchList.size();

  					float complentCnt = 0;

  					for(EgovMap workSearch:wbsWorkSearchList){
  						String complete = workSearch.get("complete").toString();
  						if(complete.equals("Y")) complentCnt++;
  					}

  					float progressRate = (complentCnt/totCnt*100);

  					getActivityProgress.put("PROGRESS_RATE", progressRate);
  				}
  			}
  		}

  		return getActivityProgress;
  	}

  	//프로젝트 진척율을 조회한다
  	public Map<String,Object> getProjectProgressInfo(Map<String, Object> map) throws Exception{
  		List<Map<String,Object>> actList = projectMgmtDAO.getActivityListForWbs(map);

  		Map<String,Object> returnMap = new HashMap<String, Object>();
  		returnMap.put("progressRate", 0);

  		float tot = 0;
  		if(actList!=null&&actList.size()>0){
  			for(Map<String,Object> actDtMap : actList){
  				actDtMap.put("year", map.get("year"));

  				List<EgovMap> getWbsWorkSearchList=projectMgmtDAO.getWbsWorkSearchList(actDtMap);

  				EgovMap actProgressMap= this.getWbsWorkActivityTotMap(actDtMap, getWbsWorkSearchList);

  				float progressRate = Float.parseFloat(actProgressMap.get("progressRate").toString());

  				tot+=progressRate;
  			}
  		}

  		if(tot>0){
  			float progressRate = (tot/(actList.size()*100))*100;
  			returnMap.put("progressRate", progressRate);
  		}

  		return returnMap;
  	}

  	//엑티비티 상세 수정
  	public int updateActivityInfo(Map<String, Object> map) throws Exception{


  		Integer chkProjectIngCnt = projectMgmtDAO.chkProjectIngCnt(map);


  		Integer cnt = 0;
  		if(chkProjectIngCnt>0){
	  		///////////////////////////////////메모발송:S


	  		//참여 해제된사람 메모발송
	  		List<Map> beforeActEmpList= getActivityUserList(map);		//activity 별 배정직원 리스트

			Map outSendMap = new HashMap();
			outSendMap.put("bEmpList", beforeActEmpList);
			outSendMap.put("empList", map.get("activityUser"));
			outSendMap.put("sessionActivityTitle", map.get("sessionActivityTitle"));
			outSendMap.put("name", map.get("name").toString());		//액티비티명
			outSendMap.put("orgId", map.get("orgId").toString());

			doSendMemoByOutMemberForActivity(outSendMap);		//메모발송

			//참가자 메모발송
			Map<String,Object> memoMap = new HashMap<String, Object>();


			List entryUserList = new ArrayList();
			String[] activityUserArr = (String[])map.get("activityUser");

			boolean isMemoChk = true;

			if(activityUserArr==null||activityUserArr.length<2){
				isMemoChk = false;
			}
			if(isMemoChk){
				for(String activityUserStr : activityUserArr){
					Map<String,Object> entryUserMap = new HashMap<String, Object>();
					entryUserMap.put("userId", activityUserStr);
					entryUserList.add(entryUserMap);
				}
				memoMap.put("entryUserList", entryUserList);
				memoMap.put("comment", map.get("comment"));
				memoMap.put("userId", map.get("userId").toString());

				workMemoService.autoMemoSend(memoMap);		//메모발송
			}
			///////////////////////////////////메모발송:E
  		}


  		//진척율 처리
  		projectMgmtDAO.deleteActivityProgress(map);

  		String baseProgressYn = map.get("baseProgressYn").toString();
  		if(baseProgressYn.equals("N"))
  			cnt = projectMgmtDAO.insertActivityProgress(map);
  		else{
  			//해당 연도의 업무를 조회한다
  			List<EgovMap> wbsWorkSearchList = this.getWbsWorkSearchList(map);

  			//해당 엑티비티의 전체 진척률을 조회한다.
  			EgovMap wbsWorkActivityTotMap = this.getWbsWorkActivityTotMap(map,wbsWorkSearchList);

  			map.put("progressRate", wbsWorkActivityTotMap.get("progressRate"));
  		}

  		//엑티비티 기간 수정
  		cnt = projectMgmtDAO.updateActivityForWbs(map);

  		//수정 내역 등록
  		Integer  activityHistoryId= projectMgmtDAO.insertActivityHist(map);

  		//엑티비티 참여자 수정
  		if(map.get("activityUser")!=null){

  			String leaderId = map.get("activityLeaderUser").toString();

  			projectMgmtDAO.deleteActivityUser2(map);

  			String[] activityUserArr = (String[])map.get("activityUser");

  			for(String activityUser: activityUserArr){

  				String leaderYn = "N";

  				if(leaderId.equals(activityUser)){
  					leaderYn = "Y";
  				}

  				Map<String,Object> empMap = new HashMap<String, Object>();
				empMap.put("activityId", map.get("activityId"));	//activityId 를 넣어 등록에 태운다
				empMap.put("userSeq", map.get("userId"));			//사용자id
				empMap.put("userId", activityUser);			//사용자id
				empMap.put("enable", "Y");				//enable 'Y' 로 (만약 'N'으로 삭제처리된 것을 복원시킨다)
				empMap.put("leaderYn",leaderYn);
				empMap.put("defaultYn", "N");			//defaultYn 'N' 로
				empMap.put("activityHistoryId", activityHistoryId);			//defaultYn 'N' 로

				projectMgmtDAO.mergeActivityUser(empMap);

				projectMgmtDAO.insertActivityUserHist(empMap);

				//프로젝트직원배정
				Map<String,Object> pEmpMap = new HashMap<String, Object>();
				pEmpMap.put("projectId", map.get("projectId"));		//projectId 를 넣어 등록에 태운다
				pEmpMap.put("userSeq", map.get("userId"));			//사용자id
				pEmpMap.put("userId", activityUser);			//등록할사람
				pEmpMap.put("enable", "Y");				//enable 'Y' 로 (만약 'N'으로 삭제처리된 것을 복원시킨다)
				pEmpMap.put("defaultYn", "N");			//defaultYn 'N' 로
				pEmpMap.put("actionType", "UPDATE");

				projectMgmtDAO.mergeProjectUser(pEmpMap); //project 별 직원배정 등록

  			}
  		}

  		//프로젝트 참여자 정리
  		projectMgmtDAO.deleteProjectUserForActivityInfo(map);
  		return 0;
  	}
  	//수정내역조회
  	public List<EgovMap> viewActivityUpdateHist(Map<String, Object> map) throws Exception{
  		Integer totCnt =0;

        totCnt = projectMgmtDAO.viewActivityUpdateHistTotalCnt(map);
        map.put("totCnt", totCnt);

        return projectMgmtDAO.viewActivityUpdateHist(map);
  	}
  	//엑티비티 일정 상세 팝업(WBS)
  	public List<EgovMap> getWbsActivityViewMonthList(Map<String, Object> map) throws Exception{
  		return projectMgmtDAO.getWbsActivityViewMonthList(map);
  	}
  	//진척율 리셋
  	public Integer updateActivityProgressRate(Map<String, Object> map) throws Exception{
    	return projectMgmtDAO.deleteActivityProgressRate(map);
    }

  	/**
	 *  프로젝트 or 액티비티 등록 업무,일정,전자결재 날짜조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 11.
	 */

  	public List<EgovMap> getEditMinMaxDate(Map<String, Object> map) throws Exception {

  		List<EgovMap> list = projectMgmtDAO.getEditMinMaxDate(map);

  		return list;
  	}

  	 /**
	 *  프로젝트 우선순위
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 12.
	 */

  	public void saveSort(Map<String, Object> map) throws Exception {

  		List list = (List)map.get("dataList");

  		for(int i=0; i<list.size(); i++){

  			Map paramMap = (Map)list.get(i);

  			projectMgmtDAO.saveSort(paramMap);
  		}


  	}

 	 /**
	 *  지켜보는 직원 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 12.
	 */

 	public void insertViewEntryUser(Map<String, Object> map) throws Exception {

 		if(map.get("viewEntryListStr") != null){
			String viewEntryListStr = map.get("viewEntryListStr").toString();

			if(!viewEntryListStr.equals("")){
				map.put("projectId", map.get("projectId"));
				map.put("viewEntryList", viewEntryListStr.split(","));
				projectMgmtDAO.insertViewEntryUser(map);
			}

		}

 	}

 	 /**
	 *  지켜보는 직원 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */

  	public List<EgovMap> getViewEntryList(Map<String, Object> map) throws Exception{

  		return projectMgmtDAO.getViewEntryList(map);
  	}

  	 /**
	 *  프로젝트 수정 이력 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
  	public List<EgovMap> getProjectHistoryList(Map<String, Object> map) throws Exception{
  		Integer totCnt =0;

        totCnt = projectMgmtDAO.getProjectHistoryListCnt(map);
        map.put("totCnt", totCnt);

        List <EgovMap> historyList =  projectMgmtDAO.getProjectHistoryList(map);

        for(int i=0; i<historyList.size(); i++){

        	EgovMap obj = historyList.get(i);
        	Map param = new HashMap();
        	param.put("projectHistoryId", obj.get("projectHistoryId"));
        	param.put("recordCountPerPage", 0);

        	List activityList = projectMgmtDAO.viewActivityUpdateHist(param);

        	((EgovMap) historyList.get(i)).put("activityList", activityList);

        }


        return historyList;
  	}





  	/**
	 * Activity 등록 (MERGING)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 10. 14.
	 */
	public int mergeActivity(Map<String, Object> map) throws Exception{

		List<Map> pEmpList = new ArrayList<Map>();					//프로젝트별 배정 직원정보 등록을 위한 LIST 선언

		boolean sendMemoYn = map.get("sendMemoYn") != null ? (Boolean) map.get("sendMemoYn") : false;		//메모 보낼지 말지

		List<Map> beforeActList = new ArrayList();

		//-----------------저장직전 액티비티 정보 : S

		if(sendMemoYn && (map.get("enable").toString()).equals("Y")){

			beforeActList = getActivityList(map);				//activity

			for(int i=0; i<beforeActList.size(); i++) {
				List<Map> beforeActEmpList = new ArrayList();
				beforeActEmpList = getActivityUserList(beforeActList.get(i));		//activity 별 배정직원 리스트
				beforeActList.get(i).put("empList", beforeActEmpList);				//배정직원 정보 추가

			}
		}

		//-----------------저장직전 액티비티 정보 : E

		List list = (ArrayList<Map>)map.get("aList");
		String projectId = map.get("projectId").toString();	//projectId
		String mode = map.get("mode").toString();			//'new' or 'update'
		String userSeq = map.get("userSeq").toString();		//로그인 사용자 id
		String updateReason = map.get("updateReason") != null ? map.get("updateReason").toString() : "";	//수정사유

		String activityLeaderStr = map.get("activityLeaderStr").toString();

		String[] activityLeaderArr = activityLeaderStr.split(",");

		String  projectHistoryId = "";

		Integer  activityHistoryId = 0;

		int cnt = list.size();
		if(cnt > 0){			//저장할 것이 있을때

			projectMgmtDAO.deleteActivity(map);

			for(int i=0; i<cnt; i++) {

				List<Map> entryUserList = new ArrayList<Map>();				//액티비티에서 빠진 직원

				String activityLeader = activityLeaderArr[i];
				Map param = (Map)list.get(i);

				String orgActivityId = (param.get("activityId") == null ? "0" : param.get("activityId").toString());

				if(!"update".equals(mode)){		//new 일때
					param.put("projectId", projectId);
				}

				Object rslt = projectMgmtDAO.mergeActivity(param);			//새로 구성된 구조 저장 insert or update (액티비티 저장)

				//액티비티 수정 내역 등록(history)

				String activityId = "";

				//activityId
				if(orgActivityId.equals("0")) {						//activity 신규
					activityId = rslt.toString();							//신규일땐 저장된 아이디값 넣고

				}else {														//activity 수정
					activityId = param.get("activityId").toString();		//수정일땐 넘어온 아이디값 넣고
				}


				//프로젝트 히스토리에 기록됬으며 확정상태만 액티비티 히스토리 기록
				if(map.get("projectHistoryId") != null && (map.get("confirm").toString()).equals("Y")){

					projectHistoryId = map.get("projectHistoryId").toString();
					param.put("projectHistoryId", projectHistoryId);
					param.put("activityId", activityId);

					param.put("userId", userSeq);
					param.put("updateReason", updateReason);
					Calendar now = Calendar.getInstance();
					Integer year = now.get(Calendar.YEAR);

					Map<String,Object> searchMap = new HashMap<String, Object>();

					searchMap.put("activityId", activityId);
					searchMap.put("projectId", projectId);
					searchMap.put("userId", userSeq);
					searchMap.put("year", year);
					searchMap.put("startDate", param.get("startDate"));
					searchMap.put("endDate", param.get("endDate"));

					//기존 액티비티
					if(!orgActivityId.equals("0")){
						//해당 연도의 업무를 조회한다
			  			List<EgovMap> wbsWorkSearchList = this.getWbsWorkSearchList(searchMap);

			  			//해당 엑티비티의 전체 진척률을 조회한다.
			  			EgovMap wbsWorkActivityTotMap = this.getWbsWorkActivityTotMap(searchMap,wbsWorkSearchList);

			  			param.put("progressRate", wbsWorkActivityTotMap.get("progressRate"));
			  			param.put("baseProgressYn", wbsWorkActivityTotMap.get("baseProgressYn"));

			  		//신규 액티비티
					}else{

						param.put("progressRate", "0");
			  			param.put("baseProgressYn", "Y");
					}


					activityHistoryId = projectMgmtDAO.insertActivityHist(param);

				}

				//------------------- activity 별 직원배정 등록
				if("A".equals(map.get("employee").toString())){  // 전체직원인경우 직원삭제함

					map.put("actionType", "UPDATE");

					if(i==0){
						projectMgmtDAO.deleteActivityUser(map);//activity 유저 삭제(default 'N'인것만)
					}

					Map<String,Object> empMap = new HashMap<String, Object>();
					empMap.put("activityId", activityId);	//activityId 를 넣어 등록에 태운다
					empMap.put("userSeq", userSeq);			//사용자id
					empMap.put("userId", activityLeader);			//사용자id
					empMap.put("enable", "Y");				//enable 'Y' 로 (만약 'N'으로 삭제처리된 것을 복원시킨다)
					empMap.put("leaderYn", "Y");
					empMap.put("defaultYn", "N");			//defaultYn 'N' 로
					empMap.put("actionType", "UPDATE");

					projectMgmtDAO.mergeActivityUser(empMap);//activity 별 직원배정 등록

					//액티비티 유저 히스토리 이력 (액티비티 히스토리에 기록된건) - 리더만 입력됨(전직원배정이니까)
					if(activityHistoryId > 0){

						empMap.put("activityHistoryId", activityHistoryId);
						projectMgmtDAO.insertActivityUserHist(empMap);
					}

				}else{

					//activity 별 직원배정 등록
					if("java.util.ArrayList".equals(param.get("empList").getClass().getCanonicalName())) {	//화면에서 직원배정 정보가 없으면 java.lang.String 으로 넘어온다.

						//---해당 직원배정 정보가 아닌 다른 것들이 있으면 삭제(enable 'N', default 'N')

						//--empList 에 없는 사용자를 enable N 처리후  신규나 기존데이터 insert duplicate update 방식
						projectMgmtDAO.updateDisableActivityUser(param);			//activity 별 직원배정 삭제(enable 'N', default 'N')

						if("N".equals(param.get("employee").toString())) continue;	//직원배정여부가 'N'이면 해당 activity 에 대한 직원배정 정보를 초기화만 하고(바로위에서) 건너뛴다

						List<Map> empList = (List<Map>)param.get("empList");

						for(int t=0; t<empList.size(); t++) {

							empList.get(t).put("activityId", activityId);	//activityId 를 넣어 등록에 태운다
							empList.get(t).put("userSeq", userSeq);			//사용자id
							empList.get(t).put("enable", "Y");				//enable 'Y' 로 (만약 'N'으로 삭제처리된 것을 복원시킨다)
							empList.get(t).put("defaultYn", "N");			//defaultYn 'N' 로
							empList.get(t).put("actionType", "UPDATE");

							//리더 판별
							String empUserId = empList.get(t).get("userId").toString();

							empUserId =empUserId.split("[.]")[0];
							if(empUserId.equals(activityLeader)){
								empList.get(t).put("leaderYn", "Y");
							}else{
								empList.get(t).put("leaderYn", "N");
							}
							projectMgmtDAO.mergeActivityUser(empList.get(t));	//activity 별 직원배정 등록

							//액티비티 유저 히스토리 이력 (액티비티 히스토리에 기록된건)
							if(activityHistoryId > 0){

								empList.get(t).put("activityHistoryId", activityHistoryId);
								projectMgmtDAO.insertActivityUserHist(empList.get(t));
							}

							//--------프로젝트 별 배정직원 정보 추가
							String userId = empList.get(t).get("userId").toString();
							if(EtcUtil.getIndexOFListMap(userId, "userId", pEmpList) == -1) {
								Map m = new HashMap();
								m.put("userId", userId);
								pEmpList.add(m);
							}

						}

						//-------------------------액티비티 참가에서 빠진 직원들 메모 발송 로직 : S

						if(sendMemoYn && (map.get("enable").toString()).equals("Y")){

							for(int j=0; j<beforeActList.size(); j++){

								if((beforeActList.get(j).get("activityId").toString()).equals(activityId)){
									List bEmpList = (List) beforeActList.get(j).get("empList");

									Map outSendMap = new HashMap();
									outSendMap.put("bEmpList", bEmpList);
									outSendMap.put("empList", empList);
									outSendMap.put("sessionActivityTitle", map.get("sessionActivityTitle").toString());
									outSendMap.put("projectCode", map.get("projectCode").toString());
									outSendMap.put("name", param.get("name").toString());		//액티비티명
									outSendMap.put("orgId", map.get("orgId").toString());

									doSendMemoByOutMember(outSendMap);		//메모발송
								}

							}

						}

						//-------------------------액티비티 참가에서 빠진 직원들 메모 발송 로직 : E


					}else {
						logger.debug("############# empList 가 java.util.ArrayList 타입이 아닌것이 존재함!!!!!! (확인!!!!) ############# ");
					}
				}



			}//for

		}//if

		projectMgmtDAO.updateActivityParentId(map);		//activity (parent_id 일괄추가수정)


		//----------------- 프로젝트 직원배정 정보 등록

		if("A".equals(map.get("employee").toString())){
			map.put("actionType", "UPDATE");
			projectMgmtDAO.deleteProjectUser(map);	 	//project 유저 삭제(default 'N'인것만)


		}else{
			//pEmpList
			map.put("pEmpList", pEmpList);
			//해당 직원배정 정보가 아닌 다른 것들이 있으면 삭제(enable 'N', default 'N')
			projectMgmtDAO.updateDisableProjectUser(map);					//project 별 직원배정 삭제(enable 'N', default 'N')

			List<Map> pEList = (ArrayList<Map>)map.get("pEmpList");
			for(int t=0; t<pEList.size(); t++) {
				pEList.get(t).put("projectId", projectId);		//projectId 를 넣어 등록에 태운다
				pEList.get(t).put("userSeq", userSeq);			//사용자id
				pEList.get(t).put("enable", "Y");				//enable 'Y' 로 (만약 'N'으로 삭제처리된 것을 복원시킨다)
				pEList.get(t).put("defaultYn", "N");			//defaultYn 'N' 로
				pEList.get(t).put("actionType", "UPDATE");

				projectMgmtDAO.mergeProjectUser(pEList.get(t)); //project 별 직원배정 등록


				//프로젝트 유저 히스토리 이력 (확정 샅애, 프로젝트 이력 남긴 상태)
				if((map.get("confirm").toString()).equals("Y") && !projectHistoryId.equals("")){

					pEList.get(t).put("projectHistoryId", projectHistoryId);
					projectMgmtDAO.insertProjectUserHist(pEList.get(t));
				}

			}
		}



		return 0;

	}

	 /**
	 *  프로젝트 메모발송
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
  	public int doSendMemoByProject(Map<String, Object> map) throws Exception{

  		/*
  		 * updateReason	    :  사유
  		 * projectId		:  프로젝트 아이디 (필수)
  		 * sessionProjectTitle :  세션 프로젝트 타이틀 명
  		 * projectName		:  프로젝트 제목 (필수)
  		 * projectCode	    :  프로젝트 코드 (필수)
  		 * userName			:  수정자 이름 (필수)
  		 * memoComment		:  사유 입력전 내용들 (필수)
  		 * memoKindStr		:  메모 발송타입 (상태변경 수정 등록 등)
  		 *
  		 * orgId			:  프로젝트 orgId (필수)
  		 * userId			:  등록자 userId (필수)
  		 *
  		 * userUpdateChk	   :  직원 배정 변경 체크 여부	  (세트)
  		 * beforeEntryUserList :  직원 배정 변경 전 직원리스트  (세트)
  		 * beforeEmployee   :  변경 전 직원배정 여부  - A : 전직원 (세트)
  		 * employee			:  직원배정 여부 - A : 전직원 (세트)
  		 *
  		*/

  		//프로젝트 참여 직원 리스트 가져오기
  		List <Map> entryUserList = projectMgmtDAO.getProjectUserList(map);

  		String memoComment =  "*[업무구분 "+map.get("memoKindStr").toString()+" 알림]\n\n";
		memoComment +=  "["+map.get("sessionProjectTitle").toString()+"] :" + map.get("projectName").toString()+"("+map.get("projectCode").toString()+")"+"\n";
		memoComment +=  "[수정자] :" + map.get("userName").toString()+"\n";
		memoComment +=  "[수정일] :"+DateUtil.getTodayDateStr()+"\n\n";

		memoComment += map.get("memoComment") != null ? map.get("memoComment").toString() : "";


		//참여자 변경 체크 Y 일때
		if(map.get("userUpdateChk") != null && (map.get("userUpdateChk").toString()).equals("Y")){

			List <Map> beforeEntryUserList = (List)map.get("beforeEntryUserList");

			List beforeId = new ArrayList();
			String beforeName = "";

			List afterId = new ArrayList();
			String afterName = "";

			for(int i=0; i<beforeEntryUserList.size(); i++){

				Map userMap = beforeEntryUserList.get(i);
				beforeId.add(userMap.get("userId").toString());
				beforeName += userMap.get("userNm").toString();

				if(i+1 < beforeEntryUserList.size()){

					beforeName += ",";
				}
			}

			for(int i=0; i<entryUserList.size(); i++){

				Map userMap = entryUserList.get(i);
				afterId.add(userMap.get("userId").toString());
				afterName += userMap.get("userNm").toString();

				if(i+1 < entryUserList.size()){

					afterName += ",";
				}
			}

			//직원배정 -> 전직원 바뀌었을때
			if(entryUserList.size() == 0 &&  beforeEntryUserList.size() != 0
					&& (map.get("employee").toString()).equals("A") && (map.get("beforeEmployee").toString()).equals("Y")){

				afterName = "전직원";
			}

			boolean editChk1 = false;
			boolean editChk2 = false;

			for(int i=0; i<beforeId.size(); i++) if(!afterId.contains(beforeId.get(i))) editChk1 = true;
			for(int i=0; i<afterId.size(); i++) if(!beforeId.contains(afterId.get(i))) editChk2 = true;


			if(editChk1 || editChk2){
				String comment = "[참여자변경] \n";

				comment +=  "-변경전 : " + beforeName +"\n";
				comment +=  "-변경후 : " + afterName +"\n";

				memoComment += comment;

			}


		}

		if(map.get("updateReason") != null){
			memoComment +=  "\n[사유] \n";
			memoComment +=  map.get("updateReason").toString() +"\n";
		}


		memoComment += "\n\n 상세보기를 통해 추가적 세부내용 확인 가능합니다.\n\n";
		memoComment += " ##moveCommonWbsPage($"+map.get("projectId")+"$)##";


		map.put("comment", memoComment);
		map.put("entryUserList", entryUserList);

		int memoRoomId = workMemoService.autoMemoSend(map);		//메모발송

		return memoRoomId;
  	}


  	/**
	 * 나간 인원 메모발송(프로젝트)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
  	public int doSendMemoByOutMember(Map<String, Object> map) throws Exception{


  		/*
  		 * bEmpList	    	:  변경전 리스트
  		 * empList			:  변경후 리스트
  		 * sessionProjectTitle :  세션 프로젝트 타이틀 명(필수)
  		 * name				:  액티비티 제목 (필수)
  		 * projectCode	    :  프로젝트 코드 (필수)
  		 * orgId			:  orgId (필수)
  		 *
  		*/

  		int memoRoomId = 0;

  		List<Map>bEmpList = (List) map.get("bEmpList");
  		List<Map>empList = (List) map.get("empList");

  		for(int k=0; k<bEmpList.size(); k++){

			Map obj = (Map)bEmpList.get(k);

			String userId = obj.get("userId").toString();

    		int chk =0;

    		if(empList.size() > 0){
    			for(int pp=0; pp<empList.size(); pp++){
    				//더블로옴 ㅡㅡ
    				String nowUserId = (empList.get(pp)).get("userId").toString();
    				int dNowUserId= (int)Double.parseDouble(nowUserId);
    				nowUserId = Integer.toString(dNowUserId);

	    	        if(nowUserId.equals(userId)){
	    	        	chk++;
	    	        }
	    	    }

    			//빠진직원
    			if(chk == 0){

    				List entryUserList = new ArrayList();
    				Map m = new HashMap();
					m.put("userId", userId);
					entryUserList.add(m);

					Map sendMemoMap = new HashMap();
					String comment = "["+map.get("sessionActivityTitle").toString()+" 수정 알림]\n\n";
					comment += map.get("sessionProjectTitle").toString()+" ["+map.get("projectCode").toString()+"] ";
					comment += map.get("name").toString()+" "+DateUtil.getTodayDateStr();
					comment += "일에 참여 해지 되셨습니다.";

					sendMemoMap.put("comment", comment);
					sendMemoMap.put("orgId", map.get("orgId").toString());
					sendMemoMap.put("userId",userId);
					sendMemoMap.put("entryUserList", entryUserList);

					memoRoomId = workMemoService.autoMemoSend(sendMemoMap);
    			}
    		}

		}

  		return memoRoomId;
  	}

  	/**
	 * 나간 인원 메모발송(엑티비티)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
  	public int doSendMemoByOutMemberForActivity(Map<String, Object> map) throws Exception{


  		/*
  		 * bEmpList	    	:  변경전 리스트
  		 * empList			:  변경후 리스트
  		 * sessionProjectTitle :  세션 프로젝트 타이틀 명(필수)
  		 * name				:  액티비티 제목 (필수)
  		 * projectCode	    :  프로젝트 코드 (필수)
  		 * orgId			:  orgId (필수)
  		 *
  		*/

  		int memoRoomId = 0;

  		List<Map>bEmpList = (List) map.get("bEmpList");
  		String[] empList = (String[]) map.get("empList");

  		for(int k=0; k<bEmpList.size(); k++){

			Map obj = (Map)bEmpList.get(k);

			String userId = obj.get("userId").toString();

    		int chk =0;

    		if(empList.length > 0){
    			for(int pp=0; pp<empList.length; pp++){
    				//더블로옴 ㅡㅡ
    				String nowUserId = empList[pp];
    				int dNowUserId= (int)Double.parseDouble(nowUserId);
    				nowUserId = Integer.toString(dNowUserId);

	    	        if(nowUserId.equals(userId)){
	    	        	chk++;
	    	        }
	    	    }

    			//빠진직원
    			if(chk == 0){

    				List entryUserList = new ArrayList();
    				Map m = new HashMap();
					m.put("userId", userId);
					entryUserList.add(m);

					Map sendMemoMap = new HashMap();
					String comment = "["+map.get("sessionActivityTitle").toString()+" 수정 알림]\n\n";
					comment += map.get("sessionActivityTitle").toString()+" ["+map.get("name").toString()+"] ";
					comment += " "+DateUtil.getTodayDateStr();
					comment += "일에 참여 해지 되셨습니다.";

					sendMemoMap.put("comment", comment);
					sendMemoMap.put("orgId", map.get("orgId").toString());
					sendMemoMap.put("userId",userId);
					sendMemoMap.put("entryUserList", entryUserList);

					memoRoomId = workMemoService.autoMemoSend(sendMemoMap);
    			}
    		}

		}

  		return memoRoomId;
  	}
  //wbs조회화면 프로젝트의 정보를 조회한다.
  	public List<EgovMap> getProjectWbsList(Map<String, Object> map) throws Exception{

  		List<EgovMap> projectList = projectMgmtDAO.getProjectWbsList(map);

  		Integer totCnt = projectMgmtDAO.getProjectWbsListTotalCnt(map);

  		map.put("totCnt", totCnt);

  		//조회해온 프로젝트의 진척률을 조회한다.
  		for(EgovMap projectMap :projectList){

  			Calendar cal = Calendar.getInstance();

  			String endDt = projectMap.get("endDate").toString();

  			String startDt = projectMap.get("startDate").toString();

  			String projectId = projectMap.get("projectId").toString();

  			map.put("projectId", projectId);

  			String[] endDtBuf = endDt.split("-");

  			int endYear = Integer.parseInt(endDtBuf[0]);

  			//종료일의 주차 구하기
  			Calendar dateCal = Calendar.getInstance();

  			//오늘주차
  			Integer nowWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);
  			//오늘 달 (calendar class month)
  			Integer nowMonth = dateCal.get(Calendar.MONTH);
  			//오늘 일
  			Integer nowDay = dateCal.get(Calendar.DATE);

  			dateCal.set(Calendar.YEAR, endYear);
  			dateCal.set(Calendar.MONTH, Integer.parseInt(endDtBuf[1])-1);
  			dateCal.set(Calendar.DATE, Integer.parseInt(endDtBuf[2]));

  			Integer endWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);


  			String[] startDtBuf = startDt.split("-");


  			dateCal.set(Calendar.YEAR, Integer.parseInt(startDtBuf[0]));
  			dateCal.set(Calendar.MONTH, Integer.parseInt(startDtBuf[1])-1);
  			dateCal.set(Calendar.DATE, Integer.parseInt(startDtBuf[2]));

  			Integer startWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);

  			int nowYear = cal.get(Calendar.YEAR);

  			//조회연도
  			Integer searchYear = nowYear;
  			map.put("searchYear", searchYear);
  			if(endYear<nowYear){
  				searchYear=endYear;

  				nowWeekNum = 99;

  				cal.set(Calendar.YEAR, searchYear);
  			}

  			//조회 연도/달의 주차를 구함 (index : 0~11<달을 의미한다. )
  			List<Integer> weekNumList = new ArrayList<Integer>();

  			for(int i = 0 ; i <12 ; i++){
  				cal.set(Calendar.MONTH,i);
  				cal.set(Calendar.DATE,1);
  				Integer lastday = cal.getActualMaximum(Calendar.DATE);

  				cal.set(Calendar.DATE, lastday);

  				weekNumList.add(cal.get(Calendar.WEEK_OF_MONTH));
  			}

  			//프로젝트 진척률을 조회한다.
  			map.put("year", searchYear.toString());
  			Map<String,Object> progressMap = this.getProjectProgressInfo(map);

  			projectMap.put("progressMap", progressMap);
  			projectMap.put("weekNumList", weekNumList);
  			projectMap.put("endDt", endDt);
  			projectMap.put("startDt", startDt);
  			projectMap.put("thisYear", searchYear.toString());
  			projectMap.put("projectId",projectId);
  			projectMap.put("endWeekNum",endWeekNum);
  			projectMap.put("startWeekNum",startWeekNum);
  			projectMap.put("nowWeekNum",nowWeekNum);
  			projectMap.put("nowMonth",nowMonth);
  			projectMap.put("nowDay",nowDay);
  			projectMap.put("nowYear",nowYear);
  		}


    	return projectList;
    }

  	//wbs조회화면 엑티비티의 정보를 조회한다.
  	public List<EgovMap> getProjectWbsActivityList(Map<String, Object> map) throws Exception{
  		List<EgovMap> actList = projectMgmtDAO.getActivityWbsList(map);
  		Map<String,Object> searchMap = new HashMap<String, Object>();

  		searchMap.put("year", map.get("thisYear"));
		searchMap.put("userId", map.get("userId"));

  		if(actList!=null&&actList.size()>0){
  			for(EgovMap actDtMap : actList){

  				Calendar cal = Calendar.getInstance();

  				String endDt = actDtMap.get("endDate").toString();

  				String startDt = actDtMap.get("startDate").toString();

  				String[] endDtBuf = endDt.split("-");

  				int endYear = Integer.parseInt(endDtBuf[0]);

  				//종료일의 주차 구하기
  				Calendar dateCal = Calendar.getInstance();

  				//오늘주차
  				Integer nowWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);
  				//오늘 달 (calendar class month)
  				Integer nowMonth = dateCal.get(Calendar.MONTH);
  				//오늘 일
  				Integer nowDay = dateCal.get(Calendar.DATE);

  				dateCal.set(Calendar.YEAR, endYear);
  				dateCal.set(Calendar.MONTH, Integer.parseInt(endDtBuf[1])-1);
  				dateCal.set(Calendar.DATE, Integer.parseInt(endDtBuf[2]));

  				Integer endWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);


  				String[] startDtBuf = startDt.split("-");


  				dateCal.set(Calendar.YEAR, Integer.parseInt(startDtBuf[0]));
  				dateCal.set(Calendar.MONTH, Integer.parseInt(startDtBuf[1])-1);
  				dateCal.set(Calendar.DATE, Integer.parseInt(startDtBuf[2]));

  				Integer startWeekNum = dateCal.get(Calendar.WEEK_OF_MONTH);

  				int nowYear = cal.get(Calendar.YEAR);

  				//조회연도
  				Integer searchYear = Integer.parseInt(map.get("thisYear").toString());
  				searchMap.put("searchYear", searchYear);

  				//조회 연도/달의 주차를 구함 (index : 0~11<달을 의미한다. )
  				List<Integer> weekNumList = new ArrayList<Integer>();

  				for(int i = 0 ; i <12 ; i++){
  					cal.set(Calendar.MONTH,i);
  					cal.set(Calendar.DATE,1);
  					Integer lastday = cal.getActualMaximum(Calendar.DATE);

  					cal.set(Calendar.DATE, lastday);

  					weekNumList.add(cal.get(Calendar.WEEK_OF_MONTH));
  				}

  				searchMap.put("activityId", actDtMap.get("activityId"));

  				searchMap.put("endDate", actDtMap.get("endDate"));
  				searchMap.put("startDate", actDtMap.get("startDate"));

  				//List<EgovMap> getWbsWorkSearchList=projectMgmtDAO.getWbsWorkSearchList(searchMap);

  				//EgovMap actProgressMap= this.getWbsWorkActivityTotMap(searchMap, getWbsWorkSearchList);

  				//actDtMap.put("progressMap", actProgressMap);

  				actDtMap.put("weekNumList", weekNumList);
  				actDtMap.put("endDt", endDt);
  				actDtMap.put("startDt", startDt);
  				actDtMap.put("thisYear", searchYear.toString());
  				actDtMap.put("endWeekNum",endWeekNum);
  				actDtMap.put("startWeekNum",startWeekNum);
  				actDtMap.put("nowWeekNum",nowWeekNum);
  				actDtMap.put("nowMonth",nowMonth);
  				actDtMap.put("nowDay",nowDay);
  				actDtMap.put("nowYear",nowYear);
  			}
  		}


    	return actList;
    }

  	//MY단위업무 프로젝트 검색
    public List<EgovMap> getMyWorkProjectList(Map<String, Object> map) throws Exception{
    	return projectMgmtDAO.getMyWorkProjectList(map);
    }

    //My단위업무 Activity조회
    public List<EgovMap> getProjectMyWorkActivity(Map<String, Object> map) throws Exception{

    	return projectMgmtDAO.getProjectMyWorkActivity(map);
    }

    //My 단위업무 > 프로젝트 우선순위설정
  	public void processProjectUserRank(Map<String, Object> map) throws Exception{

  		if(map.get("projectIdArr") == null) return;

  		String projectIdStr = map.get("projectIdArr").toString();

  		if(!projectIdStr.equals("")){
  			projectMgmtDAO.deleteProjectUserRank(map);

  			String[] projectIdArr = projectIdStr.split(",");

  			for(int i = 0 ; i < projectIdArr.length; i++){
  				map.put("projectId", projectIdArr[i]);
  				map.put("sort", i+1);
  				projectMgmtDAO.insertProjectUserRank(map);
  			}
  		}
  	}

  	/**
	 * 우선순위 체크
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 23.
	 */
	public Integer sortChk(Map<String, Object> map) throws Exception{
		return projectMgmtDAO.sortChk(map);
	}


}
