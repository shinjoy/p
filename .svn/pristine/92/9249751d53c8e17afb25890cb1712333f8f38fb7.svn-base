package ib.board.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;




import ib.schedule.service.impl.ScheduleVO;


@Repository("boardDAO")
public class BoardDAO extends ComAbstractDAO {

	protected static final Log LOG = LogFactory.getLog(BoardDAO.class);

	/*=======================신규 게시판 구현==========================*/

	//게시판 그룹
	public List<Map<String,String>> getBoardGroupList(Map<String, Object> param) throws Exception{
		return list("board.getBoardGroupList", param);
	}

	//게시판 그룹 안에 카테 리스트 ( 및 상세정보)
	public List<Map> getBoardCateList(Map<String, Object> param) throws Exception{
		return list("board.getBoardCateList", param);
	}

	//그룹 Uid 중복검사
	public int countChkGroupUid(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("board.countChkGroupUid", param).toString());
	}

	//그룹등록
	public String insertBoardGroup(Map<String, Object> param) throws Exception{
		return insert("board.insertBoardGroup", param).toString();
	}

	//그룹수정
	public void updateBoardGroup(Map<String, Object> param) throws Exception{
		update("board.updateBoardGroup", param);
	}

	//게시판 카테고리 Uid 중복검사
	public int countChkCboardUid(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("board.countChkCboardUid", param).toString());
	}

	//게시판 카테고리 등록
	public String insertBoardCate(Map<String, Object> param) throws Exception{
		return insert("board.insertBoardCate", param).toString();
	}

	//게시판 카테고리 수정
	public void updateBoardCate(Map<String, Object> param) throws Exception{
		update("board.updateBoardCate", param);
	}

	//게시판 글 전체 갯수
	public int getBoardContentListCount(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("board.getBoardContentListCount", param).toString());
	}

	//게시판 글 리스트
	public List<Map> getBoardContentList(Map<String, Object> param) throws Exception{
		return list("board.getBoardContentList",param);
	}

	//게시판 글 정보
	public List<Map> getBoardContent(Map<String, Object> param) throws Exception{
		return list("board.getBoardContent",param);
	}

	/*//게시판 글 파일리스트
	public List<Map> getBoardContentFileList(Map<String, Object> param) throws Exception{
		return list("board.getBoardContentFileList",param);
	}*/

	//게시판 이전글 정보
	public Object getBoardContentPrev(Map<String, Object> param) throws Exception{
		return selectByPk("board.getBoardContentPrevNext",param);
	}

	//게시판 다음글 정보
	public Object getBoardContentNext(Map<String, Object> param) throws Exception{
		return selectByPk("board.getBoardContentPrevNext",param);
	}

	//게시판 글 등록
	public int insertBoardContent(Map<String, Object> param)throws Exception{
		return Integer.parseInt(insert("board.insertBoardContent", param).toString());
	}

	//게시판 글 수정
	public void updateBoardContent(Map<String, Object> param)throws Exception{
		update("board.updateBoardContent", param);
	}

	//게시판 글 삭제
	public void updateBoardContentDelFlag(Map<String, Object> param)throws Exception{
		update("board.updateBoardContentDelFlag", param);
	}

	//게시판 글 등록
	public int insertBoardComment(Map<String, Object> param)throws Exception{
		return Integer.parseInt(insert("board.insertBoardComment", param).toString());
	}

	//게시판 댓글 리스트
	public List<Map> getBoardCommentList(Map<String, Object> param) throws Exception{
		return list("board.getBoardCommentList",param);
	}

	//게시 댓글 수정
	public void updateBoardComment(Map<String, Object> param)throws Exception{
		update("board.updateBoardComment", param);
	}

	//게시판 글 삭제
	public void updateBoardCommentDelFlag(Map<String, Object> param)throws Exception{
		update("board.updateBoardCommentDelFlag", param);
	}

	//게시판 조회수 올리기
	public void updateViewCount(Map<String, Object> param)throws Exception{
		update("board.updateViewCount", param);
	}

	//공지게시판
	public List<Map> noticeAllForMain(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return list("board.noticeAllForMain",param);
	}


	//업무게시판, 사내게시판
	public List<Map> generalListForMain(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return list("board.generalListForMain", param);
	}

	//유저 열람정보 저장
	public Integer updateReadUserId(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return update("board.updateReadUserId", param);
	}

	/**
	 * 게시판 공개 관계사
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public List<Map> getBoardContentOpenOrg(Map<String, Object> map) throws Exception{
		return list("board.getBoardContentOpenOrg", map);
	}

	 /**
	 * 게시판 공개 유저 리스트
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public List<Map> getBoardContentOpenUser(Map<String, Object> map) throws Exception{

		return list("board.getBoardContentOpenUser", map);
	}

	/**
	 * 게시판 승인자 저장
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public int insertOrgSetup(Map<String, Object> map) throws Exception{

		return Integer.parseInt(insert("board.insertOrgSetup", map).toString());

	}

	/**
	 * 게시판 승인자 삭제
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public void deleteOrgSetup(Map<String, Object> map) throws Exception{

		delete("board.deleteOrgSetup",map);

	}

	 /**
	 * 승인 반송처리
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 23.
	 */
	public void saveApprove(Map<String, Object> map) throws Exception{
		update("board.saveApprove",map);
	}

	 /**
	 * 게시판 관계사  삭제
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 23.
	 */
	public void deleteBoardOpenOrg(Map<String, Object> map) throws Exception{
		delete("board.deleteBoardOpenOrg",map);
	}

	 /**
	 * 게시판 공개 직원삭제
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 23.
	 */
	public void deleteBoardOpenTarget(Map<String, Object> map) throws Exception{
		delete("board.deleteBoardOpenTarget",map);
	}

	/**
	 * 게시판 관계사 공개 등록
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public int insertBoardOpenOrg(Map<String, Object> map) throws Exception{

		return Integer.parseInt(insert("board.insertBoardOpenOrg", map).toString());

	}

	/**
	 * 게시판 관계사 공개 직원 등록
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public void insertBoardOpenTarget(Map<String, Object> map) throws Exception{

		insert("board.insertBoardOpenTarget", map);

	}

	/**
	 * 공개기간수정
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 24.
	 */
	public void editOpenPeriod(Map<String, Object> map) throws Exception{
		update("board.editOpenPeriod", map);
	}

}