package ib.board.service.impl;

import ib.board.service.AlarmService;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("alarmService")
public class AlarmServiceImpl extends AbstractServiceImpl implements AlarmService {

	protected static final Log logger = LogFactory.getLog(BoardDAO.class);

	@Resource(name="alarmDAO")
	private AlarmDAO alarmDAO;

	// 알림공지 목록
	public Map<String, Object> getAlarmBoardList(Map param) throws Exception {
		// TODO Auto-generated method stub

		Map<String, Object> map = new HashMap<String, Object>();
		// parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());

		int pageNo = Integer.parseInt(param.get("pageNo").toString());

		map.put("pageNo", param.get("pageNo")); // 넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.

		int totalCount = alarmDAO.getAlarmListCnt(param); // 총 건수
		map.put("totalCount", totalCount);

		int pageCount = (totalCount / Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount > pageCount * pageSize) ? pageCount + 1 : pageCount; // 총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를 (+1)여부결정
		map.put("pageCount", pageCount); // 총 페이지수

		param.put("offset", (pageNo - 1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString())); // 페이지크기
																				// pageSize

		map.put("list", alarmDAO.getAlarmList(param)); // 사원리스트

		return map; // Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총
					// 페이지수), list(사원리스트)

	}


	//사원 리스트 반환
	public Map<String, Object> getAlarmUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

		Map<String, Object> resultMap = new HashMap<String, Object>();


		//회사정보가 있는 경우.
		if(!StringUtils.isEmpty((String)map.get("division"))){
			map.put("division", (String)map.get("division"));
			resultMap.put("divisionList", alarmDAO.getAlarmDivisionList(map));
		}else{
			//회사정보 가져와서 맨 첫번째 정보 픽스.
			List<Map> divisionList = alarmDAO.getAlarmDivisionList(map);
			resultMap.put("divisionList", divisionList);

			Map divMap = divisionList.get(0);
			map.put("division", divMap.get("divId"));
		}

		/*부서인 경우
		if(StringUtils.equalsIgnoreCase((String)map.get("alarmTarget"), "DEPART")){
			resultMap.put("deptList", alarmDAO.getAlarmDeptList(map));
		}*/

		//사원리스트 반환
		resultMap.put("list", alarmDAO.getAlarmPersonList(map));

		return resultMap;
	}

	//알림 상세
	public List<Map> getAlarmDetail(Map<String, Object> map)throws Exception {
		 List list =alarmDAO.getAlarmList(map);
		 return list;
	}

	/**
	 * 알람관계사목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 08.
	 */
	public List<Map> getAlarmListOrg(Map<String, Object> map)throws Exception {

		List<Map> list =alarmDAO.getAlarmListOrg(map);

		for(int i=0; i<list.size(); i++){
			Map paramMap = list.get(i);
			List targetList = getAlarmTargetList(paramMap);
			list.get(i).put("targetList", targetList);
		}

		 return list;
	}

	//알림 저장
	public int saveAlarm(Map<String, Object> map) throws Exception {
		int alarmId=0;

		if(map.get("alarmId").equals("0")){		//신규
			alarmId=Integer.parseInt(alarmDAO.insertAlarm(map));
		}else{
			alarmDAO.updateAlarm(map);			//수정
			alarmId=Integer.parseInt(map.get("alarmId").toString());

			alarmDAO.deleteAlarmOrg(map);		//알람관계사목록 지우고
			alarmDAO.deleteAlarmTarget(map);	//그 알림에 있는 타겟리스트 지우고
		}
		map.put("alarmId", alarmId);

		/* 2017.11.07 sjy 전사 공지 추가*/

		String alarmOrgScope = map.get("alarmOrgScope").toString();


		if(alarmOrgScope.equals("ORG_CHOICE")){		//관계사 선택일때
			insertAlarmOrg(map);

		}else if(alarmOrgScope.equals("ORG_MY")){	//자사
			insertTarget(map);						/*targetList 저장*/
		}



		return alarmId;
	}


	/**
	 * 알람관계사목록 저장(관계사 선택)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 11. 07.
	 */
	public void insertAlarmOrg(Map<String, Object> map) throws Exception {

		String selectOrgInfoListStr = map.get("selectOrgInfoList").toString();

		if(!selectOrgInfoListStr.equals("")){
			Gson gson = new Gson();
			ArrayList <Map> selectOrgInfoList =null;
			selectOrgInfoList = gson.fromJson(selectOrgInfoListStr, java.util.ArrayList.class);

			for(int i=0; i<selectOrgInfoList.size(); i++){

				Map paramMap = new HashMap(selectOrgInfoList.get(i));
				paramMap.put("alarmId", map.get("alarmId").toString());
				paramMap.put("userId", map.get("userId").toString());
				paramMap.put("orgId", map.get("orgId").toString());		//등록자 orgId



				int alarmListOrgId = alarmDAO.insertAlarmOrg(paramMap);		//알람관계사목록 지우고

				//targetList 저장
				if(!paramMap.get("alarmTargetOrg").toString().equals("NOTICE")
						&& !paramMap.get("targetList").toString().equals("")){

					paramMap.put("alarmListOrgId", alarmListOrgId);
					insertTarget(paramMap);
				}

			}

		}


	}

	//target 테이블에 저장. (보낼사람)
	public void insertTarget(Map<String, Object> map) throws Exception {
		String targetStr =(String)map.get("targetList");
		String [] targetArr = targetStr.split(",");

		map.put("alarmYn", "Y");			//일단 Y로 등록

		map.put("targetArr", targetArr);
		alarmDAO.insertAlarmTarget(map);	//타겟에 저장

	}
	//알림 삭제
	public void deleteAlarm(Map<String, Object> map) throws Exception {
		alarmDAO.deleteAlarm(map);
		alarmDAO.deleteAlarmOrg(map);
		alarmDAO.deleteAlarmTarget(map);
	}

	//알림 팝업 정보 반환
	public Map<String, Object> selectPopupInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return alarmDAO.selectPopupInfo(map);
	}

	//알림 팝업창 조건에 부합하는지 확인
	public Map<String, Object> selectPopUser(Map<String, Object> map) throws Exception{
		return alarmDAO.selectPopUser(map);
	}

	// 알림 팝업창 아이디 리스트 반환.
	public List<Map> selectPopupIds() throws Exception{
		return alarmDAO.selectPopupIds();
	}

	//해당 알림에 targetList
	public List<Map> getAlarmTargetList(Map<String, Object> map)throws Exception {
		List<Map>list=alarmDAO.getAlarmTargetList(map);
		return list;
	}

	// 알림 공지대상자 리스트 반환
	public Map selectAlarmUsers(Map<String, Object> param) throws Exception{

		Map<String, Object> map = new HashMap<String, Object>();
		//parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());

		map.put("pageNo", param.get("pageNo"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.

		int totalCount = alarmDAO.selectAlarmUsersCount(param);				//총 건수
		map.put("totalCount", totalCount);

		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;
		map.put("pageCount", pageCount);										//총 페이지수

		param.put("offset", (pageNo-1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize

		map.put("list", alarmDAO.selectAlarmUsers(param));				//목록리스트

		return map;		//Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총 페이지수), list(리스트)
	}

	//소속 부서 리스트 반환
	public List<Map> selectDeptList(Map<String, Object> param) throws Exception{
		return alarmDAO.selectDeptList(param);
	}

}
