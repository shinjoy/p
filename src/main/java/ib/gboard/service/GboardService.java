package ib.gboard.service;

import ib.board.service.impl.BoardVO;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;




public interface GboardService {

	/*=======================신규 게시판 구현===================*/

	//일반게시판 그룹 목록
	public List<EgovMap> getGboardGoupMapList(Map<String,Object> paramMap) throws Exception;
	//게시판 글 리스트
	public Map<String, Object> getBoardContentList(Map<String, Object> map) throws Exception;
	//게시판 글 등록 및 수정
	public int saveBoardContent(Map<String, Object> map) throws Exception;
	//게시판 조회수 울리기
	public int updateViewCount(Map<String, Object> map) throws Exception;
	//게시판 이전글 다음글 정보
	public Map<String, Object> getBoardContentPrevNext(Map<String, Object> map) throws Exception;
	//게시판 글 삭제
	public int deleteContent(Map<String, Object> map) throws Exception;
	//게시판 댓글 리스트
	public List<Map> getBoardCommentList(Map<String, Object> map) throws Exception;
	//게시판 그룹 리스트
	public List<Map> getGboardGoupList(Map<String, Object> map) throws Exception;

	//게시판 글 정보
	public List<Map> getBoardContent(Map<String, Object> map) throws Exception;

	//게시판 댓글 등록 및 수정
	public int saveBoardComment(Map<String, Object> map) throws Exception;

	//게시판 댓글 삭제
	public int deleteComment(Map<String, Object> map) throws Exception;
	//게시판 읽음 처리 (리스트)
	public int updateReadUserIdList(Map<String, Object> map) throws Exception;

	/**************************************************************************************************
	 * 관리자 화면
	 **************************************************************************************************/


	//게시판 그룹 리스트
	public Map<String, Object> getBoardGroupList(Map<String, Object> map) throws Exception;

	//게시판 그룹 안에 카테고리 리스트( 및 상세정보)
	public List<Map> getBoardCateList(Map<String, Object> map) throws Exception;

	//그룹 저장
	public String saveBoardGroup(Map<String, Object> map) throws Exception;

	//게시판 카테고리 저장
	public String saveBoardCate(Map<String, Object> map) throws Exception;

	//일반게시판쓰기권한자 목록
    public List<Map> getGboardWriterList(Map<String, Object> map) throws Exception;
    //일반게시판읽기권한자 목록
    public List<Map> getGboardReaderList(Map<String, Object> map) throws Exception;


}