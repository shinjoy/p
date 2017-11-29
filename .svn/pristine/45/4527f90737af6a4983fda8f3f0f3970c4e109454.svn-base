package ib.basic.service.impl;

import ib.basic.service.BookMarkService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("bookMarkService")
public class BookMarkServiceImpl extends AbstractServiceImpl implements
		BookMarkService {

	protected static final Log logger = LogFactory
			.getLog(BookMarkServiceImpl.class);

	@Resource(name = "bookMarkDAO")
	private BookMarkDAO bookMarkDAO;

	// 좌측 선택가능 메뉴 리스트
	public List<Map> selectMenuForBookMark(Map param) {
		return bookMarkDAO.selectMenuForBookMark(param);
	}

	// 즐겨찾기 목록 조회
	public List<Map> getBookMarkList(Map param) {
		return bookMarkDAO.getBookMarkList(param);
	}


	// 화면 단축키로 가져오기
	public Map moveByMenuNum(Map param) {
		return bookMarkDAO.moveByMenuNum(param);
	}

	public Map updateBookMark(Map param) throws Exception {
		// TODO Auto-generated method stub
			
		logger.debug("############## bookMarkService.updateBookMark() ########## param : [ "+ param+ "] ####");
		Map resultMap = new HashMap();
		//삭제
		bookMarkDAO.deleteBookMark(param);
		
		if(param.get("pList") != null){
			Gson gson = new Gson();
			ArrayList<Map> p = null;
			p = gson.fromJson((String) param.get("pList"), ArrayList.class);
			if(p != null && !p.isEmpty()){			
				param.put("pList", p);					//json string 을 ArrayList 로 바꿔 전달한다.
				
				bookMarkDAO.insertBookMark(param);
			}
		}
		
		//즐겨찾기 리스트 반환.
		List<Map> list = bookMarkDAO.getBookMarkList(param);
		resultMap.put("bookmarkList", list);
		return resultMap;
	}

	//북마크 정보 반환
	public Map getBookmarkInfo(Map param)  throws Exception {
		logger.debug("############## bookMarkService.getBookmarkInfo() ########## param : [ "+ param+ "] ####");
		return  bookMarkDAO.getBookmarkInfo(param);
	}


	//즐겨찾기 정보 등록/수정
	public Map checkBookmark(Map param) throws Exception {
		
		Map resultMap = bookMarkDAO.getBookmarkInfo(param);
		
		//삭제인 경우
		if(resultMap != null){
			bookMarkDAO.deleteBookMark(param);
			param.put("type", "del");
		}else{
			//등록인 경우
			bookMarkDAO.insertBookmarkInfo(param);
			param.put("type", "add");
		}
		
		//즐겨찾기 리스트 반환.
		List<Map> list = bookMarkDAO.getBookMarkList(param);
		param.put("bookmarkList", list);
		return param;
		
	}
	
	//유저한테 할당된 메뉴리스트
	public List<Map> selectUserAllMenuList(Map map) throws Exception {
		return bookMarkDAO.selectUserAllMenuList(map);
	}
	
	//리스트 형태로 저장.
	public void saveBookmark(Map param) throws Exception {
		
		String deleteStr = param.get("deleteMenuStr").toString();
		String addStr = param.get("addMenuStr").toString();
		if(!deleteStr.equals("")){						//삭제 리스트
			String [] arr = deleteStr.split(",");
			for(int i=0;i<arr.length;i++){
				Map map =  new HashMap();
				param.put("menuId", arr[i]);
				bookMarkDAO.deleteBookMark(param);
				
			}
		}
		
		if(!addStr.equals("")){							//추가 리스트 
			String [] arr = addStr.split(",");
			for(int i=0;i<arr.length;i++){
				Map map =  new HashMap();
				param.put("menuId", arr[i]);
				bookMarkDAO.insertBookmarkInfo(param);
				
			}
		}
		
	}

}
