package ib.board.service;

import ib.board.service.impl.BoardVO;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;




public interface BoardService {

	/*=======================신규 게시판 구현===================*/
	//게시판 그룹 안에 카테고리 리스트( 및 상세정보)
	public List<Map> getBoardCateList(Map<String, Object> map) throws Exception;

	//게시판 그룹 리스트
	public Map<String, Object> getBoardGroupList(Map<String, Object> map) throws Exception;

	//그룹 Uid 중복검사
	public int countChkGroupUid(Map<String, Object> map) throws Exception;
	//그룹 저장
	public String saveBoardGroup(Map<String, Object> map) throws Exception;
	//게시판 카테고리 Uid 중복검사
	public int countChkCboardUid(Map<String, Object> map) throws Exception;
	//게시판 카테고리 저장
	public String saveBoardCate(Map<String, Object> map) throws Exception;
	//게시판 글 리스트
	public Map<String, Object> getBoardContentList(Map<String, Object> map) throws Exception;
	//게시판 글 정보
	public List<Map> getBoardContent(Map<String, Object> map) throws Exception;
	//게시판 이전글 다음글 정보
	public Map<String, Object> getBoardContentPrevNext(Map<String, Object> map) throws Exception;
	//게시판 글 등록 및 수정
	public int saveBoardContent(Map<String, Object> map) throws Exception;
	//게시판 글 삭제
	public int deleteContent(Map<String, Object> map) throws Exception;
	//게시판 댓글 등록 및 수정
	public int saveBoardComment(Map<String, Object> map) throws Exception;
	//게시판 댓글 리스트
	public List<Map> getBoardCommentList(Map<String, Object> map) throws Exception;
	//게시판 댓글 삭제
	public int deleteComment(Map<String, Object> map) throws Exception;
	//게시판 조회수 울리기
	public int updateViewCount(Map<String, Object> map) throws Exception;
	//공지게시판 : 메인
	List<Map> getBoard1List(Map<String, Object> map) throws Exception;
	// 업무게시판 : 메인
	List<Map> getBoard2List(Map<String, Object> map) throws Exception;
	// 사내게시판 : 메인
	List<Map> getBoard3List(Map<String, Object> map) throws Exception;
	//게시판 읽음 처리 (리스트)
	public int updateReadUserIdList(Map<String, Object> map) throws Exception;

	 /**
	 * 게시판 공개 관계사 리스트
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public List<Map> getBoardContentOpenOrg(Map<String, Object> map) throws Exception;

	 /**
	 * 게시판 공개 유저 리스트
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public List<Map> getBoardContentOpenUser(Map<String, Object> map) throws Exception;

	 /**
	 * 게시판 승인자 저장
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 21.
	 */
	public int doSaveOrgSetup(Map<String, Object> map) throws Exception;

	 /**
	 * 승인 반송처리
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 23.
	 */
	public void saveApprove(Map<String, Object> map) throws Exception;

	/**
	 * 공개기간수정
	 * @MethodName :
	 * @author		: sjy
	 * @throws Exception
	 * @date		: 2017. 11. 24.
	 */
	public void editOpenPeriod(Map<String, Object> map) throws Exception;



}