package ib.meetingRoom.service;

import java.util.List;
import java.util.Map;

public interface MeetingRoomService {
	
	
	/**
	 * 회의실  내역 
	 * @param 
	 * @return List
	 */
	public List<Map> getMeetingRoomList(Map<String, Object> map)throws Exception;
	
	
	/**
	 * 회의실 등록
	 * @param 
	 * @return int
	 */
	
	public int doSaveMeetingRoom(Map<String, Object> map) throws Exception;
	
	/**
	 * 회의실 순서 변경
	 * @param 
	 * @return int
	 */
	
	public int doSortChange(Map<String, Object> map) throws Exception;

	/**
	 * 회의실 예약 내역
	 * @param 
	 * @return List
	 */
	public List<Map> getMeetingRoomRsvList(Map<String, Object> map)throws Exception;
	
	/**
	 * 스케줄 내역
	 * @param 
	 * @return List
	 */
	public List<Map> getScheduleList(Map<String, Object> map)throws Exception;
	
	
	
	
	/**
	 * 회의실 예약
	 * @param 
	 * @return int
	 */
	
	public int doSaveRsvMeetingRoom(Map<String, Object> map) throws Exception;
	
	/**
	 * 삭제
	 * @param 
	 * @return void
	 */
	
	public void doDeleteRsvMeetingRoom(Map<String, Object> map) throws Exception;
	
	
	
	
}
