package ib.basic.web;


import ib.basic.service.BookMarkService;
import ib.cmm.util.sim.service.AjaxResponse;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BookMarkController {

	protected static final Log logger = LogFactory.getLog(BookMarkController.class);
	
	@Resource(name="bookMarkService")
	private BookMarkService bookMarkService;
	
	
	@RequestMapping(value="/basic/bookMarkList.do")
	public String bookMarkList(ModelMap model
			,HttpSession session, HttpServletRequest request) throws Exception {
		request.setAttribute("leftMenuStr", "bookmark");
		request.setAttribute("currentMenuKor", "메뉴 바로가기");
		request.setAttribute("menuKorPath","<span class='divide'>My Page</span><span class='divide current'>메뉴 바로가기</span>");
		return "basic/bookmark/fixLeft";
	}
	
//	//좌측 메뉴 리스트 반환
//	@RequestMapping(value="/basic/getMenuListForBookMark.do")
//	public void bookMarkList(ModelMap model, @RequestParam Map param,
//			HttpServletResponse response
//			,HttpSession session, HttpServletRequest request) throws Exception {
//
//		logger.debug("########### BookmarkController.bookMarkList() ####### param : ["+ param + "]####");
//		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
//		param.put("userId",loginUser.get("userId"));
//		param.put("roleId",  loginUser.get("userRoleId"));
//		param.put("orgId",  loginUser.get("orgId"));
//		List<Map> list = bookMarkService.selectMenuForBookMark(param);
//		
//		AjaxResponse.responseAjaxSelect(response, list);			
//		
//	}
//	
//	//우측 사용자별 즐겨찾기 리스트 반환
//	@RequestMapping(value="/basic/getBookMark.do")
//	public void getBookMark(ModelMap model, @RequestParam Map param,
//			HttpServletResponse response
//			,HttpSession session, HttpServletRequest request) throws Exception {
//
//		logger.debug("########### BookmarkController.getBookMark() ####### param : ["+ param + "]####");
//		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
//		param.put("userId",loginUser.get("userId"));
//		param.put("roleId",loginUser.get("userRoleId"));
//		param.put("orgId",loginUser.get("applyOrgId"));
//		List<Map> list = bookMarkService.getBookMarkList(param);
//		
//		AjaxResponse.responseAjaxSelect(response, list);			
//		
//	}
	
	//즐겨찾기 내용 저장
	@RequestMapping(value="/basic/updateBookMark.do")
	public void updateBookMark(ModelMap model, @RequestParam Map param,
			HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {
		try{
			logger.debug("########### BookmarkController.updateBookMark() ####### param : ["+ param + "]####");
			
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			param.put("userId",loginUser.get("userId"));
			param.put("orgId",loginUser.get("orgId"));
			Map resultMap = bookMarkService.updateBookMark(param);
			
			AjaxResponse.responseAjaxObject(response, resultMap);
		}catch(Exception ex){
			ex.printStackTrace();
			AjaxResponse.responseAjaxFailWithMsg(response, "실패하였습니다.");
		}
		
	}
	
	//화면 단축키에 따른 내용 검색
	@RequestMapping(value="/basic/selectMenuNum.do")
	public void selectMenuNum(ModelMap model, @RequestParam Map param,
			HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {
		try{
			logger.debug("########### BookmarkController.selectMenuNum() ####### param : ["+ param + "]####");
			
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			param.put("roleId",  loginUser.get("userRoleId"));
			
			Map resultMap = bookMarkService.moveByMenuNum(param);
			
			AjaxResponse.responseAjaxMap(response, resultMap);
		}catch(Exception ex){
			ex.printStackTrace();
			AjaxResponse.responseAjaxFailWithMsg(response, "검색하는 도중 오류가 발생하였습니다.");
		}
		
	}
	
	//북마크 리스트 등록 팝업
	@RequestMapping(value="/basic/bookmarkListPop/pop.do")
	public String bookmarkListPop(ModelMap model, @RequestParam Map param,
			HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {
		
		return "/basic/bookmarkListPop/pop";
		
	}
	
	//북마크 체크
	@RequestMapping(value="/basic/checkBookmark.do")
	public void checkBookmark(ModelMap model, @RequestParam Map param,
			HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {
		try{
			logger.debug("########### BookmarkController.checkBookmark() ####### param : ["+ param + "]####");
			
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			param.put("userId",  loginUser.get("userId"));
			param.put("roleId", loginUser.get("userRoleId"));
			param.put("orgId", loginUser.get("applyOrgId"));
			
			Map resultMap = bookMarkService.checkBookmark(param);
			
			AjaxResponse.responseAjaxObject(response, resultMap);
		}catch(Exception ex){
			ex.printStackTrace();
			AjaxResponse.responseAjaxFailWithMsg(response, "즐겨찾기 추가/삭제하는 도중 오류가 발생하였습니다.");
		}
		
	}
	
	//사용자 할당 메뉴 리스트
	@RequestMapping(value="/basic/selectUserAllMenuList.do")
	public void userMenuList(ModelMap model, @RequestParam Map param,
			HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {
		
			
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			param.put("userId",  loginUser.get("userId"));
			param.put("applyOrgId", loginUser.get("applyOrgId"));
			param.put("roleId", loginUser.get("userRoleId"));
			
			List<Map> list = bookMarkService.selectUserAllMenuList(param);
			
			AjaxResponse.responseAjaxSelect(response, list);
		
	}
	
	//북마크 저장 및 변경
	@RequestMapping(value="/basic/saveBookmark.do")
	public void saveBookmark(ModelMap model, @RequestParam Map param,
			HttpServletResponse response
			,HttpSession session, HttpServletRequest request) throws Exception {
		try{
			
			Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
			param.put("userId",  loginUser.get("userId"));
			param.put("roleId", loginUser.get("userRoleId"));
			param.put("orgId", loginUser.get("applyOrgId"));
			
			bookMarkService.saveBookmark(param);
			
			AjaxResponse.responseAjaxSave(response, 0);
		}catch(Exception ex){
			ex.printStackTrace();
			AjaxResponse.responseAjaxFailWithMsg(response, "즐겨찾기 추가/삭제하는 도중 오류가 발생하였습니다.");
		}
		
	}
	
}
