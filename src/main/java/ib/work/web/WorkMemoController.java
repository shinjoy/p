package ib.work.web;

import ib.cmm.service.CommonService;
import ib.cmm.util.sim.service.AjaxResponse;
import ib.company.service.CompanyVO;
import ib.person.service.PersonVO;
import ib.work.service.WorkMemoService;
import ib.work.service.WorkVO;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * <pre>
 * package  : ib.work.web
 * filename : WorkMemoController.java
 * </pre>
 *
 * @author  :
 * @since   :
 * @version :
 */
@Controller
public class WorkMemoController {


    @Resource(name = "workMemoService")
    WorkMemoService workMemoService;

    @Resource(name="commonService")
	private CommonService commonService;

	/** log */
    protected static final Log LOG = LogFactory.getLog(WorkMemoController.class);

	protected static final Calendar cal = Calendar.getInstance();



	/**
	 * 메모박스 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return Main Page
	 * @exception Exception
	 */
	@RequestMapping(value="/work/memoBox.do")
	public String index(@ModelAttribute("personVO") PersonVO personVO,
			CompanyVO companyVO,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		return "work/memoBox/pop";
    }


	/**
	 * 메모리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 15.
	 */
	@RequestMapping(value = "/work/getMemoList.do")
	public void getMemoList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		//map.put("usrId", loginUser.getId());				//사용자 login id
		//map.put("usrCusId", loginUser.getCusId());			//사용자 고객id (sequence)
		map.put("usrNm", loginUser.get("userName").toString());				//사용자 이름

		//List<Map> list = workMemoService.getMemoList(map);
		Map<String, Object> resultMap = workMemoService.getMemoList((Map)map);

		//AjaxResponse.responseAjaxSelect(response, list);	//결과전송
		AjaxResponse.responseAjaxSelectForPage(response, resultMap);	//결과전송

	}


	/**
	 * 메모 상세
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 18.
	 */
	@RequestMapping(value = "/work/getMemoDetail.do")
	public void getMemoDetail(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");

		List<Map> list = workMemoService.getMemoDetail(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송

	}


	/**
	 * 메모 읽음 상태 업데이트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 20.
	 */
	@RequestMapping(value = "/work/updateMemoStatus.do")
	public void updateMemoStatus(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());


		map.put("rgId", loginUser.get("userName").toString());
		map.put("orgId", loginUser.get("orgId").toString());

		int upCnt = 0;

		upCnt = workMemoService.updateMemoStatus(map);

		AjaxResponse.responseAjaxSave(response, upCnt);		//결과전송

	}

	/**
	 * ajax 호출후 단순 성공을 위해 dummy page 연결
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 20.
	 */
	@RequestMapping(value="/work/ajaxDummy.do")
	public String ajaxDummy(@ModelAttribute("personVO") PersonVO personVO,
			CompanyVO companyVO,
			WorkVO workVO,
			HttpSession session,
			ModelMap model) throws Exception{

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		return "basic/result";
    }


	/**
	 * 메모 참여자 수신 확인 정보 json
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 18.
	 */
	@RequestMapping(value = "/work/getMemoRecvInfo.do")
	public void getMemoRecvInfo(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");


		List<Map> list = workMemoService.getMemoRecvInfo(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송

	}


	/**
	 * 메모 참여자 수신 확인 정보
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 4. 22.
	 */
	@RequestMapping(value="/work/memoRecvInfoPopup.do")
	public String memoRecvInfoPopup(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(session.getAttribute("baseUserLoginInfo")==null) return "basic/Content";
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		model.addAllAttributes(map);	//모든 받은 정보 그대로 전달

		return "work/memoRecvInfoPopup";
    }

	/**
	 * 메모 재전송
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 5. 16.
	 */
	@RequestMapping(value = "/work/memoResend.do")
	public void memoResend(HttpServletRequest request,
			HttpServletResponse response, ModelMap model,
			HttpSession session, @RequestParam Map<String,Object> map) throws Exception {

		//SESSION check!
		if(session.getAttribute("baseUserLoginInfo")==null) return;
		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		LOG.info(loginUser.get("loginId").toString());

		//model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.

		int upCnt = 0;

		map.put("usrId", loginUser.get("loginId").toString());
		map.put("orgId", loginUser.get("orgId").toString());
		upCnt = workMemoService.memoResend(map);		//재전송

		AjaxResponse.responseAjaxSave(response, upCnt);		//결과전송
	}


	/**
	 * 메모등록화면
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="/work/memoBox/pop.do")
	public String memoPop(
			@RequestParam Map<String, String> map,
			HttpSession session,ModelMap model) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		//2017.03.16 전체메모 권한여부의 권한이 있는경우 메모 확인가능함
		if("Y".equals(baseUserLoginInfo.get("wholeMemoViewYn").toString())){
			String strUserId = baseUserLoginInfo.get("userId").toString();
			if(!map.get("workUserId").toString().equals(baseUserLoginInfo.get("userId").toString())){
				strUserId = strUserId + "," + map.get("workUserId").toString();
				map.put("userId", strUserId);
				List<Map> userList =  commonService.getUserNameList(map);
				String strUserName = "";
				int idx = 0;
				for(Map userMap : userList){
					if(idx == 0) strUserName = userMap.get("userName").toString();
					else strUserName = strUserName + ","  + userMap.get("userName").toString();
					idx++;
				}
				map.put("arrWorkUserId", strUserId);
				map.put("workUserName", strUserName);
				map.put("workUserCnt", idx+"");
			}
		}

		model.addAllAttributes(map);
		return "work/memoBox/pop";
    }

	/**
	 * 메모등록화면(프로젝트 현황)
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="/work/memoBox2/pop.do")
	public String memoPop2(
			@RequestParam Map<String, String> map,
			HttpSession session,ModelMap model) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		String strUserId = baseUserLoginInfo.get("userId").toString();
		if(!map.get("workUserId").toString().equals(baseUserLoginInfo.get("userId").toString())){
			strUserId = strUserId + "," + map.get("workUserId").toString();
			map.put("userId", strUserId);
			List<Map> userList =  commonService.getUserNameList(map);
			String strUserName = "";
			int idx = 0;
			for(Map userMap : userList){
				if(idx == 0) strUserName = userMap.get("userName").toString();
				else strUserName = strUserName + ","  + userMap.get("userName").toString();
				idx++;
			}
			map.put("arrWorkUserId", strUserId);
			map.put("workUserName", strUserName);
			map.put("workUserCnt", idx+"");
		}

		model.addAllAttributes(map);
		return "work/memoBox2/pop";
    }

	/**
	 * 메모 방 정보
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="/work/getRoomInfo.do")
	public void getRoomInfo(
			@RequestParam Map<String,Object> map,
			HttpServletResponse response,
			HttpSession session,ModelMap model) throws Exception{

		AjaxResponse.responseAjaxSelect(response, workMemoService.getRoomInfo(map));
    }

	/**
	 * 메모 방 참여자 정보
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="/work/getRoomEntryList.do")
	public void getRoomEntryList(
			@RequestParam Map<String,Object> map,
			HttpServletResponse response,
			HttpSession session,ModelMap model) throws Exception{

		AjaxResponse.responseAjaxSelect(response, workMemoService.getRoomEntryList(map));
    }

	/**
	 * 메모 방 글리스트
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="/work/getRoomMemoList.do")
	public void getRoomMemoList(
			@RequestParam Map<String,Object> map,
			HttpServletResponse response,
			HttpSession session,ModelMap model) throws Exception{

		AjaxResponse.responseAjaxSelect(response, workMemoService.getRoomMemoList(map));
    }

	/**
	 * 룸생성 및수정
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="work/saveMemoRoom.do")
	public void saveMemoRoom(
		@RequestParam Map<String,Object> map,
		HttpServletResponse response,
		HttpSession session,ModelMap model) throws Exception{

		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());

		int roomId=workMemoService.saveMemoRoom(map);

		AjaxResponse.responseAjaxSave(response, roomId);
    }

	/**
	 * 메모 참가자 등록 및 수정
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="work/saveRoomEntry.do")
	public void saveEntryRoom(
		@RequestParam Map<String,Object> map,
		HttpServletResponse response,
		HttpSession session,ModelMap model) throws Exception{

		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());

		int roomId=workMemoService.saveRoomEntry(map);

		AjaxResponse.responseAjaxSave(response, roomId);
    }

	/**
	 * 메모 등록 및 수정
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="work/saveMemoComment.do")
	public void saveComment(
		@RequestParam Map<String,Object> map,
		HttpServletResponse response,
		HttpSession session,ModelMap model) throws Exception{

		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());

		int memoCommentId=workMemoService.saveMemoComment(map);

		AjaxResponse.responseAjaxSave(response, memoCommentId);
    }

	/**
	 * 읽음 확인 업데이트
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="work/saveLastReadDate.do")
	public void saveLastReadDate(
		@RequestParam Map<String,Object> map,
		HttpServletResponse response,
		HttpSession session,ModelMap model) throws Exception{

		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());

		workMemoService.updateLastReadDate(map);

		AjaxResponse.responseAjaxSave(response, 1);
    }

	/**
	 * 메모고정여부 업데이트
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="work/saveMemoFixedYn.do")
	public void saveMemoFixedYn(
		@RequestParam Map<String,Object> map,
		HttpServletResponse response,
		HttpSession session,ModelMap model) throws Exception{

		Map loginUser = (Map) session.getAttribute("baseUserLoginInfo");
		map.put("userId", loginUser.get("userId").toString());

		workMemoService.updateMemoFixedYn(map);

		AjaxResponse.responseAjaxSave(response, 1);
    }

	/**
	 * 메모 방 글리스트
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value="/work/getCommentInfo.do")
	public void getCommentInfo(
			@RequestParam Map<String,Object> map,
			HttpServletResponse response,
			HttpSession session,ModelMap model) throws Exception{

		AjaxResponse.responseAjaxSelect(response, workMemoService.getCommentInfo(map));
    }

	// 글 삭제
	@RequestMapping(value = "/work/deleteComment.do")
	public void deleteComment(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("usrSeq", baseUserLoginInfo.get("userId"));

		int chk = workMemoService.deleteComment(map);
		AjaxResponse.responseAjaxSave(response, chk);
	}

	// 첫글 삭제
	@RequestMapping(value = "/work/doDeleteFirstComment.do")
	public void doDeleteFirstComment(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("usrSeq", baseUserLoginInfo.get("userId"));
		map.put("userId", baseUserLoginInfo.get("userId"));

		int chk = workMemoService.doDeleteFirstComment(map);
		System.out.println(chk);
		AjaxResponse.responseAjaxSave(response, chk);
	}

}