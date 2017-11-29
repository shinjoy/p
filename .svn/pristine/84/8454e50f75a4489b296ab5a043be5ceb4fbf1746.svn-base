package ib.basic.service;

import java.util.List;
import java.util.Map;

public interface BookMarkService {

	// 좌측 선택가능 메뉴 리스트
	public List<Map> selectMenuForBookMark(Map param) throws Exception;

	// 즐겨찾기 목록 조회
	public List<Map> getBookMarkList(Map param) throws Exception;

	// 화면 단축키로 가져오기
	public Map moveByMenuNum(Map param) throws Exception;

	//즐겨찾기 저장/수정
	public Map updateBookMark(Map param) throws Exception;

	//북마크 정보 반환
	public Map getBookmarkInfo(Map param)  throws Exception;

	//북마크 등록/수정하기
	public Map checkBookmark(Map param)   throws Exception;

	//유저한테 할당된 메뉴리스트
	public List<Map> selectUserAllMenuList(Map map) throws Exception;
	
	//북마크 등록/수정 (리스트 형태)
	public void saveBookmark(Map param)   throws Exception;

}
