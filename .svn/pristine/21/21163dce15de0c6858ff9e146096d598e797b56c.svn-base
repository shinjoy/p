/**
 * 
 */
package ib.meetingRoom.service.impl;


import ib.cmm.service.impl.ComAbstractDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository("meetingRoomDAO")
public class MeetingRoomDAO extends ComAbstractDAO{
	
	
	//회의실 내역
	@SuppressWarnings("unchecked")
	public List<Map> getMeetingRoomList(Map<String, Object>map) throws Exception {
		
		
		return list("meetingRoom.getMeetingRoomList", map);
	}
	

	//회의실 등록
	public int intsertMeetingRoom(Map<String, Object>map) throws Exception {
		return (Integer)insert("meetingRoom.intsertMeetingRoom", map);
	}

	//회의실 수정
	public int updateMeetingRoom(Map<String, Object>map) throws Exception {
		
		int chk =0;
		update("meetingRoom.updateMeetingRoom", map);
		chk =1;
		
		return chk;
	}
	
	//회의실 예약 내역
	@SuppressWarnings("unchecked")
	public List<Map> getMeetingRoomRsvList(Map<String, Object>map) throws Exception {
		return list("meetingRoom.getMeetingRoomRsvList", map);
	}
	
	//스케줄 내역
	@SuppressWarnings("unchecked")
	public List<Map> getScheduleList(Map<String, Object>map) throws Exception {
		return list("meetingRoom.getScheduleList", map);
	}
	
	//예약 등록
	public int intsertRsvMeetingRoom(Map<String, Object>map) throws Exception {
		return (Integer)insert("meetingRoom.intsertRsvMeetingRoom", map);
	}

	//예약 수정
	public int updateRsvMeetingRoom(Map<String, Object>map) throws Exception {
		
		int chk =0;
		update("meetingRoom.updateRsvMeetingRoom", map);
		chk =1;
		
		return chk;
	}
	
	//삭제
	public void doDeleteRsvMeetingRoom(Map<String, Object>map) throws Exception {
		
		
		delete("meetingRoom.doDeleteRsvMeetingRoom", map);
		
	}
	
	
}