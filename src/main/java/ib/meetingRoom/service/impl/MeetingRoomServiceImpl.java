package ib.meetingRoom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;




import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.stereotype.Service;

import ib.meetingRoom.service.MeetingRoomService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("meetingRoomService")
public class MeetingRoomServiceImpl extends AbstractServiceImpl implements MeetingRoomService {
	
	@Resource(name="meetingRoomDAO")
	MeetingRoomDAO meetingRoomDAO;
	
	//회의실 내역
	public List<Map> getMeetingRoomList(Map<String, Object> map)throws Exception {
		
		return meetingRoomDAO.getMeetingRoomList(map);
	}

	
	//회의실 등록( 등록.수정)
	public int doSaveMeetingRoom(Map<String, Object> map) throws Exception {
		
		String meetingRoomId = map.get("meetingRoomId").toString();
		int cnt = 0;
		
		if(meetingRoomId.equals("0")) cnt = meetingRoomDAO.intsertMeetingRoom(map);
		else cnt =  meetingRoomDAO.updateMeetingRoom(map);
		
		return cnt;
	}
	
	//순서변경
	public int doSortChange(Map<String, Object> map) throws Exception {
		
		String sortListStr = map.get("sortList").toString();

		TypeReference<List<Map>> mapType = new TypeReference<List<Map>>() {};
		List<Map> sortList = new ObjectMapper().readValue(sortListStr, mapType);

		for(int i=0;i<sortList.size();i++){
			Map objMap = sortList.get(i);
			objMap.put("userSeq",map.get("userSeq"));
			meetingRoomDAO.updateMeetingRoom(objMap);
		}
		
		
		return 1;
	}
	
	//회의실 예약 내역
	public List<Map> getMeetingRoomRsvList(Map<String, Object> map) throws Exception {
		
		return meetingRoomDAO.getMeetingRoomRsvList(map);
	}
	
	//스케줄 내역
	public List<Map> getScheduleList(Map<String, Object> map) throws Exception {
		
		return meetingRoomDAO.getScheduleList(map);
	}
	
	//회의실 예약 하기( 등록.수정)
	public int doSaveRsvMeetingRoom(Map<String, Object> map) throws Exception {
		
		String rsvId = map.get("rsvId").toString();
		int cnt = 0;
		
		if(rsvId.equals("0")) cnt = meetingRoomDAO.intsertRsvMeetingRoom(map);
		else cnt =  meetingRoomDAO.updateRsvMeetingRoom(map);
		
		return cnt;
	}
	
	//예약 삭제
	public void doDeleteRsvMeetingRoom(Map<String, Object> map)throws Exception{
		
		 meetingRoomDAO.doDeleteRsvMeetingRoom(map);
	}
	
	
	
	
}
