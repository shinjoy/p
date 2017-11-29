package ib.work.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * <pre>
 * package  : ib.work.service.impl
 * filename : workDailyDAO.java
 * </pre>
 *
 * @author  : sjy
 * @since   : 2016. 11. 01.
 * @version : 1.0.0
 */
@Repository("workDailyDAO")
public class WorkDailyDAO extends ComAbstractDAO{

	/**
	 * 업무일지 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getworkDailyList(Map<String, Object> map) throws Exception{

		return list("workDaily.getworkDailyList", map);
	}

	/**
	 * 업무일지 리스트(미완료)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getBeforeWorkDailyList(Map<String, Object> map) throws Exception{

		return list("workDaily.getBeforeWorkDailyList", map);
	}

	/**
	 * 업무일지 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int insertWorkDaily(Map<String, Object> map) throws Exception{
		return Integer.parseInt(insert("workDaily.insertWorkDaily", map).toString());
	}

	/**
	 * 업무일지 수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void updateWorkDaily(Map<String, Object> map) throws Exception{
		update("workDaily.updateWorkDaily", map);
	}

	/**
	 * 업무일지 완료처리
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void endWorkDaily(Map<String, Object> map) throws Exception{
		update("workDaily.endWorkDaily", map);
	}

	/**
	 * 업무일지 삭제처리
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void deleteWorkDaily(Map<String, Object> map) throws Exception{
		delete("workDaily.deleteWorkDaily", map);
	}

	/**
	 * 업무일지 팀 삭제처리
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void deleteTeamWorkDaily(Map<String, Object> map) throws Exception{
		delete("workDaily.deleteTeamWorkDaily", map);
	}

	/**
	 * 업무일지 등록(팀)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void insertTeamWorkDaily(Map<String, Object> map) throws Exception{
		insert("workDaily.insertTeamWorkDaily", map);
	}

	/**
	 * 업무일지 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getWorkDaily(Map<String, Object> map) throws Exception{
		return list("workDaily.getWorkDaily", map);
	}

	/**
	 * 업무일지 정보 (팀원)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getWorkDailyTeam(Map<String, Object> map) throws Exception{
		return list("workDaily.getWorkDailyTeam", map);
	}

	/**
	 * 업무일지 팀 메모나 진행상태 변경
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int updateTeamMemo(Map<String, Object> map) throws Exception{
		int chk=0;
		update("workDaily.updateTeamMemo", map);
		chk=1;
		return chk;
	}

	/**
	 * 일정 상태 변경 처리
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 11. 7.
	 */
	public int updateScheduleStts(Map<String, Object> map) throws Exception{
		int cnt = 0;
		cnt = update("workDaily.updateScheduleStts", map);
		return cnt;
	}

	/**
	 * 업무일지 left count
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 11. 21.
	 */
	public int getWorkDailyLeftCount(Map<String, Object> map) throws Exception{
		return	Integer.parseInt(selectByPk("workDaily.getWorkDailyLeftCount", map).toString());

	}


	/**
	 * 메모 left count
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 11. 21.
	 */
	public int getMemoLeftCount(Map<String, Object> map) throws Exception{
		return	Integer.parseInt(selectByPk("workDaily.getMemoLeftCount", map).toString());

	}

	/**
	 * 메인화면 로그인 유저 프로젝트 종료예정 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 29.
	 */
	public List<EgovMap> getProjectEndList(Map<String, Object> map) throws Exception{
		List<EgovMap> list = list("project.getProjectEndList", map);
		return list;
	}

	/**
	 * 업무일지내용 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int insertWorkMemo(Map<String, Object> map) throws Exception{
		return Integer.parseInt(insert("workDaily.insertWorkMemo", map).toString());
	}

	/**
	 * 팀할당 업무일지내용 등록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int insertTeamWorkMemo(Map<String, Object> map) throws Exception{
		return Integer.parseInt(insert("workDaily.insertTeamWorkMemo", map).toString());
	}

	/**
	 * 업무일지내용 수정 (개인업무)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void updateWorkMemoForPrivate(Map<String, Object> map) throws Exception{
		update("workDaily.updateWorkMemoForPrivate", map);
	}

	/**
	 * 업무일지내용 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void deleteWorkMemo(Map<String, Object> map) throws Exception{
		delete("workDaily.deleteWorkMemo", map);
	}

	/**
	 * 팀할당 업무일지내용 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public void deleteTeamWorkMemo(Map<String, Object> map) throws Exception{
		delete("workDaily.deleteTeamWorkMemo", map);
	}


	/**
	 * 업무일지내용 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getWorkMemoList(Map<String, Object> map) throws Exception{
		return list("workDaily.getWorkMemoList", map);
	}

	/**
	 * 팀할당 업무일지내용 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getTeamWorkMemoList(Map<String, Object> map) throws Exception{
		return list("workDaily.getTeamWorkMemoList", map);
	}
	/**
	 * 개인업무 복사
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int copyDailyWork(Map<String, Object> map) throws Exception{
		return Integer.parseInt(insert("workDaily.copyWorkDaily", map).toString());
	}
	/**
	 * 개인업무 메모 복사
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int copyDailyWorkMemo(Map<String, Object> map) throws Exception{
		return Integer.parseInt(insert("workDaily.copyWorkMemo", map).toString());
	}

	/**
	 * 업무일지 읽기 권한 복사
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int copyWorkReader(Map<String, Object> map) throws Exception{
		return Integer.parseInt(insert("workDaily.copyWorkReader", map).toString());
	}

	/**
	 * 개인업무 이동
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public int moveDailyWork(Map<String, Object> map) throws Exception{
		return update("workDaily.moveDailyWork", map);
	}

	//업무일지읽기권한자 삭제
	public void deleteWorkReader(Map<String, Object> param) throws Exception{
		delete("workDaily.deleteWorkReader", param);
	}


	//업무일지읽기권한자  등록
	public String insertWorkReader(Map<String, Object> param) throws Exception{
		return insert("workDaily.insertWorkReader", param).toString();
	}

	//업무일지읽기권한자 목록
	public List<Map> getWorkReaderList(Map<String, Object> param) throws Exception{
		return list("workDaily.getWorkReaderList", param);
	}

	/**
	 * 업무일지 메인 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> workDailyListByMain(Map<String, Object> map) throws Exception{

		return list("workDaily.workDailyListByMain", map);
	}
	/**
	 * (주간보고)선택한 유저의 기본 정보를 조회한다
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: p
	 * @date		: 2016. 10. 27.
	 */
    public List<EgovMap> getWorkWeekSelectUserList(Map<String, Object> map) throws Exception{
  		return list("workDaily.getWorkWeekSelectUserList", map);
  	}

    /**
	 * 주간보고 비고 등록/수정
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: p
	 * @date		: 2016. 10. 27.
	 */
    public Integer getWorkWeekNoteCnt(Map<String, Object> map) throws Exception{
    	return (Integer)getSqlMapClientTemplate().queryForObject("workDaily.getWorkWeekNoteCnt", map);
  	}

    //주간보고 비고 등록
  	public Integer insertWorkWeekNote(Map<String, Object> param) throws Exception{
  		return (Integer)insert("workDaily.insertWorkWeekNote", param);
  	}
  	//주간보고 비고 수정
  	public Integer updateWorkWeekNote(Map<String, Object> param) throws Exception{
  		return update("workDaily.updateWorkWeekNote", param);
  	}

  	/**
	 * 주간보고 비고 조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: p
	 * @date		: 2016. 10. 27.
	 */
	public List<Map> getWorkWeekNoteList(Map<String, Object> map) throws Exception{

		return list("workDaily.getWorkWeekNoteList", map);
	}

}