package ib.work.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


/**
 * <pre>
 * package	: ib.work.service
 * filename	: WorkDailyService.java
 * </pre>
 *
 *
 *
 * @author	: sjy
 * @date	: 2016. 11. 01.
 * @version :
 *
 */
public interface WorkDailyService {



	/*신규 구현*/

	//업무일지 리스트
	List<Map> getworkDailyList(Map<String, Object> map) throws Exception;

	//업무일지 리스트 (미완료일정 날짜별)
	List<Map> getBeforeWorkDailyList(Map<String, Object> map) throws Exception;

	//업무일지 리스트 (미완료일정 오늘 까지..)
	List<Map> getBeforeWorkDailyListByToday(Map<String, Object> map) throws Exception;

	//업무일지 등록 및 수정
	int saveWorkDaily(Map<String, Object> map) throws Exception;

	//업무일지 등록(팀)
	void insertTeamWorkDaily(Map<String, Object> map) throws Exception;

	//업무일지 정보 받아오기
	List<Map> getWorkDaily(Map<String, Object> map) throws Exception;

	//업무일지 완료처리
	void endWorkDaily(Map<String, Object> map) throws Exception;

	//업무일지 삭제처리
	void deleteWorkDaily(Map<String, Object> map) throws Exception;

	////업무일지 정보(팀원)
	List<Map> getWorkDailyTeam(Map<String, Object> map) throws Exception;

	//업무일지(팀원 메모 추가 및 상태값 변경)
	int updateTeamMemo(Map<String, Object> map) throws Exception;

	//일정 상태 변경 처리
	int updateScheduleStts(Map<String, Object> map) throws Exception;

	//업무일지 메인 리스트
	List<Map> workDailyListByMain(Map<String, Object> map) throws Exception;

	//업무일지 메인 left count
	int getWorkDailyLeftCount(Map<String, Object> map) throws Exception;

	//메모 메인 left count
	int getMemoLeftCount(Map<String, Object> map) throws Exception;

	//메인화면 로그인 유저 프로젝트 종료예정 팝업
	List<EgovMap> getProjectEndList(Map<String, Object> map) throws Exception;


	//업무일지내용 등록
	int insertWorkMemo(Map<String, Object> map) throws Exception;

	//팀할당 업무일지내용 등록
	int insertTeamWorkMemo(Map<String, Object> map) throws Exception;

	//업무일지내용 리스트
	List<Map> getWorkMemoList(Map<String, Object> map) throws Exception;

	//팀할당 업무일지내용 리스트
	List<Map> getTeamWorkMemoList(Map<String, Object> map) throws Exception;

	//개인업무 복사 , 이동
	Map processWorkDaily(Map<String, Object> map) throws Exception;

	//업무일지읽기권한자 목록
    List<Map> getWorkReaderList(Map<String, Object> map) throws Exception;

    //(주간보고)선택한 유저의 기본 정보를 조회한다
  	List<EgovMap> getWorkWeekSelectUserList(Map<String, Object> map) throws Exception;

  	//주간보고 비고 등록/수정
  	Integer processWorkWeekNote(Map<String, Object> map) throws Exception;

  	//주간보고 비고 조회
  	List<Map> getWorkWeekNoteList(Map<String, Object> map) throws Exception;

}
