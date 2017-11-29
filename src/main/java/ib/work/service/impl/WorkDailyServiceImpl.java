package ib.work.service.impl;

import ib.approve.service.ApproveService;
import ib.file.service.FileService;
import ib.work.service.WorkDailyService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service("workDailyService")
public class WorkDailyServiceImpl extends AbstractServiceImpl implements WorkDailyService {

    @Resource(name="workDailyDAO")
    private WorkDailyDAO workDailyDAO;

    @Resource(name = "fileService")
	private FileService fileService;

    @Resource(name="approveService")
	private ApproveService approveService;


    protected static final Log logger = LogFactory.getLog(WorkDailyServiceImpl.class);

    //업무일지 리스트
  	public List<Map> getworkDailyList(Map<String, Object> map) throws Exception{

  		return workDailyDAO.getworkDailyList(map);
  	}

    //업무일지 리스트 (미완료일정 -하루 )
  	public List<Map> getBeforeWorkDailyList(Map<String, Object> map) throws Exception{

  		return workDailyDAO.getBeforeWorkDailyList(map);
  	}

  	//업무일지 리스트 (미완료일정 -하루 리스트 조합-> 오늘만)
  	public List<Map> getBeforeWorkDailyListByToday(Map<String, Object> map) throws Exception{

  		List<Map>beforeWorkDailyList = new ArrayList();							//날짜별 미완료 일정

  		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date();
		String oTime = mSimpleDateFormat.format ( currentTime ); 				//현재시간 (String)

  		//for(int i=0;i<dayList.size();i++){
  			String selectDate = oTime;//dayList.get(i).get("sysDate").toString();		//날짜
  			if(map.get("selectDate") == null){
  				map.put("selectDate", selectDate);
  			}

			//if(dayList.get(i).get("holiday").toString().equals("N")){			//업무일일때만

				//Date memDelStartDate = mSimpleDateFormat.parse(selectDate);
				//Date currentDate =  mSimpleDateFormat.parse( oTime );
				//int compare = currentDate.compareTo( memDelStartDate ); 		// 날짜비교

				//if(compare>=0){													//날짜 리스트의 날짜가 오늘까지 일때만
					beforeWorkDailyList.addAll((getBeforeWorkDailyList(map)));	//추가
				//}
			//}
		//}

  		return beforeWorkDailyList;

  	}

    //업무일지 등록 및 수정
	public int saveWorkDaily(Map<String, Object> map) throws Exception{
		int listId = Integer.parseInt(map.get("listId").toString());
		int rtn = 0;
		int workMemoId = 0;

		if(listId==0){		//등록

			if(!map.get("teamList").toString().equals("")){  // 팀업무
				listId=workDailyDAO.insertWorkDaily(map);
				map.put("listId", listId);
				workMemoId = workDailyDAO.insertWorkMemo(map);  //메모등록

				insertTeamWorkDaily(map);

				/***********************************************************************
				 *  열람권한 등록
				 ***********************************************************************/
				String readerType = map.get("readerType").toString();
		      	if("ALL".equals(readerType)){
		      		workDailyDAO.deleteWorkReader(map);
		      	}else if("DEPT".equals(readerType)){

		      		String[] arrDeptId = map.get("arrDeptId").toString().split(",");
		      		workDailyDAO.deleteWorkReader(map);

		      		for(String readerDeptId : arrDeptId){
		      			map.put("readerDeptId", readerDeptId);
		      			workDailyDAO.insertWorkReader(map);
		      		}

		      	}else if("USER".equals(readerType)) {
		      		String[] arrUserId = map.get("arrUserId").toString().split(",");
		      		workDailyDAO.deleteWorkReader(map);

		      		for(String readerUserId : arrUserId){
		      			map.put("readerUserId", readerUserId);
		      			workDailyDAO.insertWorkReader(map);
		      		}
		      	}else if("NONE".equals(readerType)) {
		      		workDailyDAO.deleteWorkReader(map);
		      	}
			}else{  //개인업무
				String workDate = map.get("workDate").toString();
				String workDateHolyYn = map.get("workDateHolyYn").toString();
				int workDatePeriod = Integer.parseInt(map.get("workDatePeriod").toString());

				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date tempDate = transFormat.parse(workDate);
				Calendar cal = Calendar.getInstance();
				cal.setTime(tempDate);

				for(int i=0;i<workDatePeriod;i++){
					cal.add(Calendar.DATE, i);
					int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;  // 1일, 2월, 3화, 4수, 5목, 6금, 7토
					if("N".equals(workDateHolyYn)  && (dayNum == 1 || dayNum == 7)){
						cal.setTime(tempDate);
						continue;
					}else{
						map.put("workDate", transFormat.format(cal.getTime()));
						listId=workDailyDAO.insertWorkDaily(map);

						map.put("listId", listId);
						workMemoId = workDailyDAO.insertWorkMemo(map);  //메모등록

						/***********************************************************************
						 *  열람권한 등록
						 ***********************************************************************/
						String readerType = map.get("readerType").toString();
				      	if("ALL".equals(readerType)){
				      		workDailyDAO.deleteWorkReader(map);
				      	}else if("DEPT".equals(readerType)){

				      		String[] arrDeptId = map.get("arrDeptId").toString().split(",");
				      		workDailyDAO.deleteWorkReader(map);

				      		for(String readerDeptId : arrDeptId){
				      			map.put("readerDeptId", readerDeptId);
				      			workDailyDAO.insertWorkReader(map);
				      		}

				      	}else if("USER".equals(readerType)) {
				      		String[] arrUserId = map.get("arrUserId").toString().split(",");
				      		workDailyDAO.deleteWorkReader(map);

				      		for(String readerUserId : arrUserId){
				      			map.put("readerUserId", readerUserId);
				      			workDailyDAO.insertWorkReader(map);
				      		}
				      	}else if("NONE".equals(readerType)) {
				      		workDailyDAO.deleteWorkReader(map);
				      	}
				      	cal.setTime(tempDate);
					}

				}
			}
			/***********************************************************************
			 *  파일첨부
			 ***********************************************************************/
			//int seq = Integer.parseInt(map.get("infoId").toString());
			int seq = workMemoId;
	    	int chk =0;
	    	if(seq != 0 && !map.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
	    		map.put("uploadId",seq);
	    		map.put("usrSeq", map.get("userId").toString());
	    		chk = fileService.insertFileListJson(map);					//파일 db저장
	    		if(chk==0) seq = 0;
			}

		}else{				//수정
			workDailyDAO.updateWorkDaily(map);

			/*workDailyDAO.deleteWorkMemo(map);  //메모삭제
			workMemoId = workDailyDAO.insertWorkMemo(map);  //메모등록
*/
			if(map.get("workType").toString().equals("TEAM")){  // 팀업무
				if(!map.get("teamList").toString().equals("")){
					insertTeamWorkDaily(map);
				}
			}else{  //개인업무
				workDailyDAO.updateWorkMemoForPrivate(map);  //메모수정 (개인업무)

				/***********************************************************************
				 *  파일첨부
				 ***********************************************************************/
				int seq = Integer.parseInt(map.get("workMemoId").toString());
		    	int chk =0;

				if(!map.get("delFileList").toString().equals("")){				//정상저장 이고 삭제파일이 있을때
					 String [] arr = map.get("delFileList").toString().split(",");
					 map.put("fileArr", arr);
					 fileService.updateDelFlag(map);							//파일 db저장 된거 삭제
				}

		    	if(seq!=0 && !map.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
		    		map.put("uploadId",seq);
		    		map.put("usrSeq", map.get("userId").toString());
		    		chk = fileService.insertFileListJson(map);					//파일 db저장
		    		if(chk==0) seq = 0;
				}
			}

			/***********************************************************************
			 *  열람권한 등록
			 ***********************************************************************/
			String readerType = map.get("readerType").toString();
	      	if("ALL".equals(readerType)){
	      		workDailyDAO.deleteWorkReader(map);
	      	}else if("DEPT".equals(readerType)){

	      		String[] arrDeptId = map.get("arrDeptId").toString().split(",");
	      		workDailyDAO.deleteWorkReader(map);

	      		for(String readerDeptId : arrDeptId){
	      			map.put("readerDeptId", readerDeptId);
	      			workDailyDAO.insertWorkReader(map);
	      		}

	      	}else if("USER".equals(readerType)) {
	      		String[] arrUserId = map.get("arrUserId").toString().split(",");
	      		workDailyDAO.deleteWorkReader(map);

	      		for(String readerUserId : arrUserId){
	      			map.put("readerUserId", readerUserId);
	      			workDailyDAO.insertWorkReader(map);
	      		}
	      	}else if("NONE".equals(readerType)) {
	      		workDailyDAO.deleteWorkReader(map);
	      	}
		}

		return listId;
	}

	//업무일지 완료처리
	public void endWorkDaily(Map<String, Object> map) throws Exception{

		workDailyDAO.endWorkDaily(map);
	}

	//업무일지 삭제처리
	public void deleteWorkDaily(Map<String, Object> map) throws Exception{

		workDailyDAO.deleteWorkMemo(map);
		workDailyDAO.deleteWorkReader(map);
		workDailyDAO.deleteWorkDaily(map);

		if(map.get("workType").toString().equals("TEAM")){
			workDailyDAO.deleteTeamWorkMemo(map);
			workDailyDAO.deleteTeamWorkDaily(map);
		}

	}

	//업무일지 등록 (팀)
	public void insertTeamWorkDaily(Map<String, Object> map) throws Exception{


		String [] teamList =  (map.get("teamList").toString()).split(",");
		for(int i=0;i<teamList.length;i++){
			Map<String,Object>teamMap = new HashMap();
			teamMap.put("userId", map.get("userId"));
			teamMap.put("listId", map.get("listId"));
			teamMap.put("empId", teamList[i]);
			teamMap.put("empMemo", "");

			/*if(map.get("empMemo") !=null){					//신규등록(업무일지)
				teamMap.put("empMemo", map.get("empMemo"));
				teamMap.put("newYn", "Y");
			}else{											//참여자만 추가.
				teamMap.put("newYn", "N");
			}*/

			teamMap.put("progress", "PLAN");
			workDailyDAO.insertTeamWorkDaily(teamMap);

		}

	}

	//업무일지 정보
	public List<Map> getWorkDaily(Map<String, Object> map) throws Exception{
		return workDailyDAO.getWorkDaily(map);

	}

	//업무일지 정보(팀원)
	public List<Map> getWorkDailyTeam(Map<String, Object> map) throws Exception{

		return workDailyDAO.getWorkDailyTeam(map);
	}

	//업무일지 (팀원 메모 추가 혹은 상태값 변경)
	public int updateTeamMemo(Map<String, Object> map) throws Exception{

		return workDailyDAO.updateTeamMemo(map);
	}


	//일정 상태 변경 처리
	public int updateScheduleStts(Map<String, Object> map) throws Exception{

		return workDailyDAO.updateScheduleStts(map);
	}

	//업무일지 메인 리스트
	public List<Map> workDailyListByMain(Map<String, Object> map)throws Exception {

		return workDailyDAO.workDailyListByMain(map);
	}

	//업무일지 메인 left count
	public int getWorkDailyLeftCount(Map<String, Object> map) throws Exception{

		return workDailyDAO.getWorkDailyLeftCount(map);
	}

	//메모 메인 left count
	public int getMemoLeftCount(Map<String, Object> map) throws Exception{

		return workDailyDAO.getMemoLeftCount(map);
	}

	//메인화면 로그인 유저 프로젝트 종료예정 팝업
	public List<EgovMap> getProjectEndList(Map<String, Object> map) throws Exception{
		return workDailyDAO.getProjectEndList(map);
	}

	//업무일지내용 등록
	public int insertWorkMemo(Map<String, Object> map) throws Exception{

		int workMemoId = workDailyDAO.insertWorkMemo(map);  //메모등록

		/***********************************************************************
		 *  파일첨부
		 ***********************************************************************/
		//int seq = Integer.parseInt(map.get("infoId").toString());
		int seq = workMemoId;
    	int chk =0;
    	if(seq != 0 && !map.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    		map.put("uploadId",seq);
    		map.put("usrSeq", map.get("userId").toString());
    		chk = fileService.insertFileListJson(map);					//파일 db저장
    		if(chk==0) seq = 0;
		}

		return workMemoId;
	}

	//팀할당 업무일지내용 등록
	public int insertTeamWorkMemo(Map<String, Object> map) throws Exception{

		int teamWorkMemoId = workDailyDAO.insertTeamWorkMemo(map);  //팀메모등록
		/***********************************************************************
		 *  파일첨부
		 ***********************************************************************/
		//int seq = Integer.parseInt(map.get("infoId").toString());
		int seq = teamWorkMemoId;
    	int chk =0;
    	if(seq != 0 && !map.get("fileList").toString().equals("")){		//정상저장 이고 파일이 있을때
    		map.put("uploadId",seq);
    		map.put("usrSeq", map.get("userId").toString());
    		chk = fileService.insertFileListJson(map);					//파일 db저장
    		if(chk==0) seq = 0;
		}

		return teamWorkMemoId;
	}

	//업무일지내용 리스트
	public List<Map> getWorkMemoList(Map<String, Object> map)throws Exception {

		return workDailyDAO.getWorkMemoList(map);
	}

	//팀할당 업무일지내용 리스트
	public List<Map> getTeamWorkMemoList(Map<String, Object> map)throws Exception {

		return workDailyDAO.getTeamWorkMemoList(map);
	}

	//개인업무 복사 , 이동
	public Map processWorkDaily(Map<String, Object> map) throws Exception{

		String type = map.get("type").toString();

		List<Map> detailMapList = workDailyDAO.getworkDailyList(map);

		if(detailMapList!=null){
			Map detailMap = detailMapList.get(0);

			 Integer closeDate = Integer.parseInt(detailMap.get("closeDate").toString());			//프로젝트 마감일
			 String pendingFlag = detailMap.get("pendingFlag").toString();							//프로젝트 보류여부
			 String stopFlag = detailMap.get("stopFlag").toString();								//프로젝트 중단여부
			 Integer startDate =Integer.parseInt(detailMap.get("startDate").toString());			//액티비티 시작일
			 Integer endDate = Integer.parseInt(detailMap.get("endDate").toString());				//액티비티 종료일

		     String targetDt = map.get("targetDt").toString();										//복사,이동 하려는 날짜

		     Integer targetDtInt = Integer.parseInt(targetDt.replaceAll("-", ""));

			 //프로젝트 보류여부
		     if(!pendingFlag.equals("N")){
		    	 String activityName = detailMap.get("activityName").toString();

		    	 map.put("result", "FAIL");
		    	 map.put("msg", "["+activityName+"]는 보류중입니다.");

		    	 return map;
		     }

		     //프로젝트 중단여부
		     if(!stopFlag.equals("N")){
		    	 String activityName = detailMap.get("activityName").toString();

		    	 map.put("result", "FAIL");
		    	 map.put("msg", "["+activityName+"]는 중단되었습니다.");

		    	 return map;

		     }

		     // 프로젝트마감여부
		     Date now = new Date();

		     SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		     String nowStr = sdf.format(now);
		     Integer nowInt = Integer.parseInt(nowStr);

		     if(nowInt>closeDate){
		    	 String activityName = detailMap.get("activityName").toString();

		    	 map.put("result", "FAIL");
		    	 map.put("msg", "["+activityName+"]는 마감되었습니다.");

		    	 return map;
		     }

		     //액티비티 기간 검사
		     if(targetDtInt<startDate || targetDtInt > endDate ){

		    	 String activityName = detailMap.get("activityName").toString();
		    	 String typeNm = type.equals("MOVE")?"이동":"복사";

		    	 map.put("result", "FAIL");
		    	 map.put("msg", typeNm+"하려는 날짜는 ["+activityName+"]의 기간을 벗어납니다.");

		    	 return map;
		     }
		   /***************************************************************************
		    * 참가자가 휴직상태 체크
		    **************************************************************************/
			Map<String,Object> obj = new HashMap<String,Object>();
			Map<String,Object> paramMap = new HashMap<String,Object>();
			Map<String,String> msgMap = new HashMap<String,String>();

			paramMap.put("userId", map.get("userId"));
			msgMap.put(map.get("userId").toString(), "개인업무 진행자");
			msgMap.put("workDatePeriod", "1");
			paramMap.put("dateFrom", map.get("targetDt"));
			paramMap.put("dateTo", map.get("targetDt"));

			obj=approveService.getChkAppointedPerson(paramMap,msgMap);
			if(obj.get("result") =="FAIL" && obj.get("msg") != null){
				 map.put("result", "FAIL");
		    	 map.put("msg", obj.get("msg"));
		    	 return map;
			}

		}else{
			map.put("result", "FAIL");
			map.put("msg", "데이터 조회에 실패했습니다.관리자에게 문의해주세요.");

	    	return map;
		}



		//실제 저장/수정
		int cnt = 0;
		int newListId;
		if(type.equals("COPY")){
			newListId = workDailyDAO.copyDailyWork(map);
			cnt = workDailyDAO.copyDailyWorkMemo(map);

			map.put("newListId", newListId);
			cnt = workDailyDAO.copyWorkReader(map);

		}else if(type.equals("MOVE")){
			cnt = workDailyDAO.moveDailyWork(map);
		}

		if(cnt>0){
			map.put("result", "SUCCESS");
			return map;
		}else{
			map.put("result", "FAIL");
			map.put("msg", "데이터 저장에 실패했습니다.관리자에게 문의해주세요.");

	    	return map;
		}

	}

	//업무일지읽기권한자 목록
    public List<Map> getWorkReaderList(Map<String, Object> map) throws Exception {
    	return workDailyDAO.getWorkReaderList(map);
    }

    //(주간보고)선택한 유저의 기본 정보를 조회한다
    public List<EgovMap> getWorkWeekSelectUserList(Map<String, Object> map) throws Exception{

    	String userIdStr = map.get("userIdStr").toString();

    	String[] userList = userIdStr.split(",");

    	map.put("userList", userList);

  		return workDailyDAO.getWorkWeekSelectUserList(map);
  	}

    //주간보고 비고 등록/수정
  	public Integer processWorkWeekNote(Map<String, Object> map) throws Exception{
  		Integer cnt = 0;

  		Integer noteCnt =workDailyDAO.getWorkWeekNoteCnt(map);

  		if(noteCnt>0){
  			cnt = workDailyDAO.updateWorkWeekNote(map);
  		}else if(noteCnt == 0){
  			cnt = workDailyDAO.insertWorkWeekNote(map);
  		}
  		return cnt;
  	}

  	//주간보고 비고 조회
  	public List<Map> getWorkWeekNoteList(Map<String, Object> map) throws Exception{
  		return workDailyDAO.getWorkWeekNoteList(map);
  	}

}
