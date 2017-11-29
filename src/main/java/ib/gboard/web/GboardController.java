package ib.gboard.web;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.gboard.service.GboardService;
import ib.personnel.service.ManagementService;
import ib.schedule.service.FormDocService;
import ib.schedule.service.ScheduleService;

@Controller
public class GboardController {

	@Resource(name = "gBoardService")
	private GboardService gBoardService;

	@Resource(name = "formService")
	private FormDocService formService;

	@Resource(name = "scheService")
	private ScheduleService scheService;

	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	@Resource(name = "managementService")
    private ManagementService managementService;

	//protected static final Log LOG = LogFactory.getLog(BoardController.class);


	/*==============================업무게시판 신규 구현===========================*/
	@RequestMapping(value = "/gboard/getGboardGroupListAjax.do")
	public void getGboardGroupListAjax(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {
		Map rObj = new HashMap();
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("orgId", baseUserLoginInfo.get("applyOrgId"));
		map.put("deptId", baseUserLoginInfo.get("deptId"));
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("deptLevel", baseUserLoginInfo.get("deptLevel"));
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());
		//그룹 리스트(org 별)
		List<Map> groupList = gBoardService.getGboardGoupList(map);						//그룹리스트

		rObj.put("groupList", groupList);		//그룹리스트

		//게시판 리스트(org 별)
		List<EgovMap> gboardList = gBoardService.getGboardGoupMapList(map);						//게시판리스트
		rObj.put("gboardList", gboardList);		//게시판리스트
		AjaxResponse.responseAjaxObject(response, rObj);	//결과전송

	}
	// 업무게시판 메인
	@RequestMapping(value = "/gboard/gboardList.do")
	public String gBoardMain(HttpSession session
							,Model model
							,@RequestParam Map<String,Object> paramMap) throws Exception{
		if(session.getAttribute("baseUserLoginInfo")==null) return "redirect:/";
		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		paramMap.put("orgId", baseUserLoginInfo.get("applyOrgId"));
		paramMap.put("deptId", baseUserLoginInfo.get("deptId"));
		paramMap.put("userId", baseUserLoginInfo.get("userId"));
		paramMap.put("deptLevel", baseUserLoginInfo.get("deptLevel"));
		paramMap.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());
		List<EgovMap> gboardGroupMapList = gBoardService.getGboardGoupMapList(paramMap);

		model.addAttribute("gboardGroupMapList", gboardGroupMapList);

		model.addAllAttributes(paramMap);

		return "gboard/gboardMain";
	}

	// 게시판 리스트
	@RequestMapping(value = "gboard/getGboardListAjax.do")
	public String boardMain() throws Exception {
		return "gboard/gboardList/ajax";
	}
	// 게시판 글 리스트
	@RequestMapping(value = "/gboard/getBoardContentList.do")
	public void getBoardContentList(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("boardInfoLevel", baseUserLoginInfo.get("boardInfoLevel"));
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("orgId", baseUserLoginInfo.get("applyOrgId"));
		map.put("deptId", baseUserLoginInfo.get("deptId"));
		map.put("deptLevel", baseUserLoginInfo.get("deptLevel"));
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());

		map.put("newContentMarkClass", "BOARD");
		map.put("useYn", "Y");

		//조회 후 사용하는 조건이 있을때 Y로 바꾼다.
		map.put("ruleUseYn", "N");

		List<EgovMap> markRuleList = managementService.markRuleListList(map);

		String readTimeYn = "N";

		if(markRuleList != null&&markRuleList.size()==1){

			EgovMap ruleMap = markRuleList.get(0);
			map.put("ruleUseYn", "Y");
			map.put("readTimeYn", ruleMap.get("readTimeYn"));
			map.put("markDayCnt", ruleMap.get("markDayCnt"));

			readTimeYn = ruleMap.get("readTimeYn").toString();
		}
		Map<String,Object> resultMap = gBoardService.getBoardContentList(map);

		resultMap.put("readTimeYn", readTimeYn);

		AjaxResponse.responseAjaxObject(response, resultMap);	//결과전송
	}
	// 게시판 글 쓰기
	@RequestMapping(value = "gboard/boardContentWrite.do")
	public String boardContentWrite(
			) throws Exception {
		return "gboard/gboardWrite/ajax";
	}

	// 게시판 글 등록 및 수정
	@RequestMapping(value = "/gboard/saveBoardContent.do")
	public void saveBoardContent(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("usrSeq", baseUserLoginInfo.get("userId"));
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));

		int chk = gBoardService.saveBoardContent(map);
		AjaxResponse.responseAjaxSave(response, chk);
	}

	// 게시판 글 정보
	@RequestMapping(value = "/gboard/getBoardContent.do")
	public void getBoardContent(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("applyOrgId", baseUserLoginInfo.get("applyOrgId"));
		map.put("orgId", baseUserLoginInfo.get("orgId"));
		map.put("deptId", baseUserLoginInfo.get("deptId"));
		map.put("userId", baseUserLoginInfo.get("userId"));


		AjaxResponse.responseAjaxSelect(response, gBoardService.getBoardContent(map));	//결과전송
	}
	// 게시판 조회수 올리기
	@RequestMapping(value = "/gboard/boardViewCount.do")
	public void boardViewCount(
			@RequestParam Map<String,Object>map,
			HttpServletResponse response,Model model) throws Exception {

		//조회수 올리기
		int chk =gBoardService.updateViewCount(map);
		AjaxResponse.responseAjaxSave(response, chk);

	}
	// 게시판 글 보기
	@RequestMapping(value = "/gboard/boardContentView.do")
	public String boardContentView() throws Exception {

		return "gboard/gboardView/ajax";
	}
	// 게시판 글 이전 및 다음글 정보
	@RequestMapping(value = "/gboard/getBoardContentPrevNext.do")
	public void getBoardContentPrevNext(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("applyOrgId"));
		map.put("deptId", baseUserLoginInfo.get("deptId"));
		map.put("userId", baseUserLoginInfo.get("userId"));
		map.put("deptLevel", baseUserLoginInfo.get("deptLevel"));
		map.put("vipAuthYn", baseUserLoginInfo.get("vipAuthYn").toString());

		Map<String,Object> resultMap = gBoardService.getBoardContentPrevNext(map);
		AjaxResponse.responseAjaxObject(response, resultMap);	//결과전송
	}
	// 게시판 글 삭제
	@RequestMapping(value = "/gboard/deleteContent.do")
	public void deleteContent(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("usrSeq", baseUserLoginInfo.get("userId"));

		int chk = gBoardService.deleteContent(map);
		AjaxResponse.responseAjaxSave(response, chk);
	}
	// 게시판 댓글 등록 및 수정
	@RequestMapping(value = "/gboard/saveBoardComment.do")
	public void saveBoardComment(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("usrSeq", baseUserLoginInfo.get("userId"));

		int chk = gBoardService.saveBoardComment(map);
		AjaxResponse.responseAjaxSave(response, chk);
	}

	// 게시판 댓글 삭제
	@RequestMapping(value = "/gboard/deleteBoardComment.do")
	public void deleteBoardComment(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("usrSeq", baseUserLoginInfo.get("userId"));

		int chk = gBoardService.deleteComment(map);
		AjaxResponse.responseAjaxSave(response, chk);
	}
	// 게시판의 댓글목록 가져오기
	@RequestMapping(value = "/gboard/getBoardCommentList.do")
	public void getCommentList(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model,
			@RequestParam Map<String,Object> map) throws Exception {

		List<Map> list = gBoardService.getBoardCommentList(map);
		AjaxResponse.responseAjaxSelect(response, list);
	}
	//게시글 읽음 처리(리스트)
	@RequestMapping(value = "/gboard/processReadContentList.do")
	public void processReadContentList(HttpSession session,
		@RequestParam Map<String,Object>map,
		Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());

		Map<String,Object> result = new HashMap();
		int upCnt=0;

		//System.out.println(map.get("chkContentId"));
		upCnt=gBoardService.updateReadUserIdList(map);

		result.put("upCnt", upCnt);
		AjaxResponse.responseAjaxObject(response, result);

	}

	/**************************************************************************************************
	 * 관리자 화면
	 **************************************************************************************************/

	// 게시판 관리 메인
	@RequestMapping(value = "/gboard/gboardMgmt.do")
	public String boardMgmt(Model model) throws Exception {

		return "gboard/gboardMgmt";
	}

	// 게시판 관리 그룹 리스트
	@RequestMapping(value = "/gboard/getBoardGroupList.do")
	public void getboardGroupList(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("orgId", baseUserLoginInfo.get("applyOrgId"));

		Map<String,Object> resultMap = gBoardService.getBoardGroupList(map);
		AjaxResponse.responseAjaxObject(response, resultMap);	//결과전송
	}

	// 게시판 관리 그룹 안에 카테고리 리스트( 및 상세정보)
	@RequestMapping(value = "/gboard/getBoardCateList.do")
	public void getBoardCateList(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		List<Map> resultList = gBoardService.getBoardCateList(map);
		AjaxResponse.responseAjaxSelect(response, resultList);	//결과전송
	}

	// 일반게시판쓰기권한자 목록
	@RequestMapping(value = "/gboard/getGboardWriterList.do")
	public void getGboardWriterList(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		List<Map> resultList = gBoardService.getGboardWriterList(map);
		AjaxResponse.responseAjaxSelect(response, resultList);	//결과전송
	}
	// 일반게시판읽기권한자 목록
	@RequestMapping(value = "/gboard/getGboardReaderList.do")
	public void getGboardReaderList(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		List<Map> resultList = gBoardService.getGboardReaderList(map);
		AjaxResponse.responseAjaxSelect(response, resultList);	//결과전송
	}

	// 게시판 관리 그룹  등록 팝업창
	@RequestMapping(value = "/gboard/gboardGroupView/pop.do")
	public String boardGroupView(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		model.addAttribute("groupId", map.get("groupId"));			//그룹 아이디
		return "gboard/gboardGroupPopup/pop";
	}

	// 그룹 등록 및 수정
	@RequestMapping(value = "/gboard/saveBoardGroup.do")
	public void saveBoardGroup(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());

		Map<String,Object>result = new HashMap();
		int groupId = Integer.parseInt(map.get("groupId").toString());
		String saveChk="0";
		saveChk=gBoardService.saveBoardGroup(map);

		result.put("saveChk", saveChk);
		AjaxResponse.responseAjaxObject(response, result);

	}

	// 게시판 관리 그룹 안에 카테고리 등록 팝업창
	@RequestMapping(value = "/gboard/gboardCateView/pop.do")
	public String boardCateView(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		model.addAttribute("gboardId", map.get("gboardId"));		//수정일경우 아이디
		model.addAttribute("groupId", map.get("groupId"));			//그룹 아이디
		return "gboard/gboardCatePopup/pop";
	}

	// 게시판 카테고리 등록 및 수정
	@RequestMapping(value = "/gboard/saveBoardCate.do")
	public void saveBoardCate(HttpSession session,
		@RequestParam Map<String,Object>map,
		Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userId", baseUserLoginInfo.get("userId").toString());
		map.put("orgId", baseUserLoginInfo.get("applyOrgId").toString());

		Map<String,Object> result = new HashMap();
		String saveChk="0";
		saveChk=gBoardService.saveBoardCate(map);

		result.put("saveChk", saveChk);
		AjaxResponse.responseAjaxObject(response, result);

	}

}