package ib.gboard.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.schedule.service.impl.ScheduleVO;


@Repository("gBoardDAO")
public class GboardDAO extends ComAbstractDAO {

	protected static final Log LOG = LogFactory.getLog(GboardDAO.class);

	//일반게시판 그룹 목록
	public List<EgovMap> getGboardGoupMapList(Map<String,Object> paramMap) throws Exception{
		return list("gboard.getGboardGoupMapList", paramMap);
	}
	//게시판 글 리스트
	public List<Map> getBoardContentList(Map<String, Object> param) throws Exception{
		return list("gboard.getBoardContentList",param);
	}
	//게시판 글 등록
	public int insertBoardContent(Map<String, Object> param)throws Exception{
		return Integer.parseInt(insert("gboard.insertBoardContent", param).toString());
	}
	//게시판 글 정보
	public List<Map> getBoardContent(Map<String, Object> param) throws Exception{
		return list("gboard.getBoardContent",param);
	}
	//게시판 글 수정
	public void updateBoardContent(Map<String, Object> param)throws Exception{
		update("gboard.updateBoardContent", param);
	}
	//게시판 조회수 올리기
	public void updateViewCount(Map<String, Object> param)throws Exception{
		update("gboard.updateViewCount", param);
	}
	//게시판 이전글 정보
	public Object getBoardContentPrev(Map<String, Object> param) throws Exception{
		return selectByPk("gboard.getBoardContentPrevNext",param);
	}

	//게시판 다음글 정보
	public Object getBoardContentNext(Map<String, Object> param) throws Exception{
		return selectByPk("gboard.getBoardContentPrevNext",param);
	}
	//게시판 댓글 리스트
	public List<Map> getBoardCommentList(Map<String, Object> param) throws Exception{
		return list("gboard.getBoardCommentList",param);
	}

	//게시판 그룹 리스트
	public List<Map> getGboardGoupList(Map<String, Object> map) throws Exception{
		return list("gboard.getGboardGoupList",map);
	}
	//게시판 리스트
	public List<Map> getGboardList(Map<String, Object> map) throws Exception{
		return list("gboard.getGboardList",map);
	}

	//게시판 글쓰기 권한
	public String getBoardWriteType(Map<String, Object> map) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject("gboard.getBoardWriteType", map);
	}

	//게시판 글 삭제
	public void updateBoardContentDelFlag(Map<String, Object> param)throws Exception{
		update("gboard.updateBoardContentDelFlag", param);
	}

	//게시판 글 등록
	public int insertBoardComment(Map<String, Object> param)throws Exception{
		return Integer.parseInt(insert("gboard.insertBoardComment", param).toString());
	}

	//게시 댓글 수정
	public void updateBoardComment(Map<String, Object> param)throws Exception{
		update("gboard.updateBoardComment", param);
	}

	//게시판 글 삭제
	public void updateBoardCommentDelFlag(Map<String, Object> param)throws Exception{
		update("gboard.updateBoardCommentDelFlag", param);
	}

	/**************************************************************************************************
	 * 관리자 화면
	 **************************************************************************************************/

	//게시판 그룹
	public List<Map<String,String>> getBoardGroupList(Map<String, Object> param) throws Exception{
		return list("gboard.getBoardGroupList", param);
	}

	//게시판 그룹 안에 카테 리스트 ( 및 상세정보)
	public List<Map> getBoardCateList(Map<String, Object> param) throws Exception{
		return list("gboard.getBoardCateList", param);
	}

	//그룹등록
	public String insertBoardGroup(Map<String, Object> param) throws Exception{
		return insert("gboard.insertBoardGroup", param).toString();
	}

	//그룹수정
	public void updateBoardGroup(Map<String, Object> param) throws Exception{
		update("gboard.updateBoardGroup", param);
	}

	//게시판 카테고리 등록
	public String insertBoardCate(Map<String, Object> param) throws Exception{
		return insert("gboard.insertBoardCate", param).toString();
	}

	//게시판 카테고리 수정
	public void updateBoardCate(Map<String, Object> param) throws Exception{
		update("gboard.updateBoardCate", param);
	}

	//일반게시판쓰기권한자 등록
	public String insertGboardWriter(Map<String, Object> param) throws Exception{
		return insert("gboard.insertGboardWriter", param).toString();
	}

	//일반게시판쓰기권한자 삭제
	public void deleteGboardWriter(Map<String, Object> param) throws Exception{
		delete("gboard.deleteGboardWriter", param);
	}

	//일반게시판쓰기권한자 목록
	public List<Map> getGboardWriterList(Map<String, Object> param) throws Exception{
		return list("gboard.getGboardWriterList", param);
	}

	//일반게시판읽기권한자 목록
	public List<Map> getGboardReaderList(Map<String, Object> param) throws Exception{
		return list("gboard.getGboardReaderList", param);
	}

	//일반게시판읽기권한자 삭제
	public void deleteGboardRead(Map<String, Object> param) throws Exception{
		delete("gboard.deleteGboardRead", param);
	}

	//일반게시판읽기권한자 등록
	public String insertGboardRead(Map<String, Object> param) throws Exception{
		return insert("gboard.insertGboardRead", param).toString();
	}

	//유저 열람정보 저장
	public Integer updateReadUserId(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return update("gboard.updateReadUserId", param);
	}

}