package ib.basic.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ib.basic.interceptor.MenuVO;
import ib.board.service.impl.BoardDAO;
import ib.cmm.service.impl.ComAbstractDAO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

@Repository("bookMarkDAO")
public class BookMarkDAO extends ComAbstractDAO {
	
	//좌측 사용자의 선택가능메뉴 리스트
	public List<Map> selectMenuForBookMark (Map param){
		return list("bookmark.selectMenuForBookMark", param);
	}

	//즐겨찾기 목록 조회
	public List<Map> getBookMarkList (Map param){
		return list("bookmark.getBookMarkList", param);
	}

	//즐겨찾기 추가
	public void insertBookMark(Map param){
		insert("bookmark.insertBookMark", param);
	}
	
	//즐겨찾기 삭제
	public void deleteBookMark(Map param){
		delete("bookmark.deleteBookMark", param);
	}

	//화면 단축키로 가져오기 
	public Map moveByMenuNum (Map param){
		return (Map) super.getSqlMapClientTemplate().queryForObject("bookmark.moveByMenuNum", param);
	}

	//북마크 정보 반환
	public Map getBookmarkInfo(Map param){
		return (Map) super.getSqlMapClientTemplate().queryForObject("bookmark.getBookmarkInfo", param);
	}

	//북마크 정보 입력
	public void insertBookmarkInfo(Map param){
		insert("bookmark.insertBookmarkInfo", param);
	}
	
	public List<Map> selectUserAllMenuList(Map param){
		
		return list("menu.selectUserAllMenuList", param);
	}
	
}
