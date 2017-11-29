package ib.cmm.web;



import ib.cmm.service.CommonService;
import ib.cmm.util.fcc.service.StringUtil;
import ib.cmm.util.sim.service.AjaxResponse;
import java.util.ArrayList;
import java.util.HashMap;
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
public class CommonController {

	@Resource(name = "commonService")
	private CommonService commonService;

	protected static final Log logger = LogFactory.getLog(CommonController.class);



	/**
	 * 공통코드
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/common/getCommonCode.do")
	public void getCommonCode(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {


		List<Map> list = commonService.getCommonCode(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 공통코드(BASE)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/common/getBaseCommonCode.do")
	public void getBaseCommonCode(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("roleId", loginUser.get("userRoleId").toString());		//user_id(sequence)

		List<Map> list = commonService.getBaseCommonCode(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 직원리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/common/getStaffList.do")
	public void getStaffList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("applyOrgId", loginUser.get("applyOrgId").toString());
		map.put("userId", loginUser.get("userId").toString());

		List<Map> list = commonService.getStaffList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 직원리스트 (이름소팅)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/common/getStaffListNameSort.do")
	public void getStaffListNameSort(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {


		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("hideSynergyUserYn", baseUserLoginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부
		List<Map> list = commonService.getStaffListNameSort(map);

		AjaxResponse.responseAjaxSelect(response,list );	//결과전송
	}

	/**
	 * 직원리스트 (이름소팅) + paging
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 24.
	 */
	@RequestMapping(value = "/common/getStaffListNameSortForPaging.do")
	public void getStaffListNameSortForPaging(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map resultMap = commonService.getStaffListNameSortForPaging(map);

		AjaxResponse.responseAjaxSelectForPage(response,resultMap);	//결과전송
	}

	/**
	 * divisionList(sort 정렬)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 7. 12.
	 */
	@RequestMapping(value = "/common/getDivisionList.do")
	public void getDivisionList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {


		List<Map> list = commonService.getSelectDivisionList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 부서 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 8. 10.
	 */
	@RequestMapping(value = "/common/getDeptList.do")
	public void getDeptList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		if(map.get("enable").equals("N")) map.put("allDept", "Y");		//퇴직자 일때 부서 전체 조건으로 검색 2017.10.23 inhee

		List<Map> list = commonService.getDeptList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * ORG 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 18.
	 */
	@RequestMapping(value = "/common/getOrgCodeCombo.do")
	public void getOrgCodeCombo(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		List<Map> list = commonService.getOrgCodeCombo(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * org에 따른 companyList - ib_company 의 ref_org_id
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 10. 19.
	 */
	@RequestMapping(value = "/common/getCompanyListCombo.do")
	public void getCompanyListCombo(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		List<Map> list = commonService.getCompanyListCombo(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}


	/**
	 * 관계사별 부서 사용자 리스트
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 31.
	 */
	@RequestMapping(value = "/common/getOrgDeptUserList.do")
	public void getOrgDeptUserList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map rObj = new HashMap();

		Map loginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("hideSynergyUserYn", loginInfo.get("hideSynergyUserYn").toString());  //관계사 시너지 유저 목록 활성화여부
		map.put("orgBasicAuth",loginInfo.get("orgBasicAuth").toString());
		if(map.get("oneOrg") != null && (map.get("oneOrg").toString().length() > 0)){
			map.put("applyOrgId", map.get("oneOrg").toString());
		}else if(map.get("isAllOrg") != null && "N".equals(map.get("isAllOrg").toString())){
			map.put("authOrgId", "Y");
			map.put("userId", loginInfo.get("userId").toString());
		}

		//org 리스트
		map.put("code", "CD");
		map.put("name", "NM");
		map.put("sortByOrgId", "Y");		//orgId 정렬
		List<Map> olist = commonService.getOrgCodeCombo(map);		//ORG 리스트


		//dept 리스트(org 별)
		String aOrgId = "";
		String cOrgId = "";

		if(map.containsKey("userStatusFire")&& map.get("userStatusFire").equals("Y")) map.put("allDept", "Y");		//퇴직자 일때 부서 전체 조건으로 검색 2017.10.23 sjy

		List<Map> list = commonService.getDeptList(map);						//부서 리스트
		Map deptMap = new HashMap();
		List rList = new ArrayList();
		for(int i=0; i<list.size(); i++){
			cOrgId = list.get(i).get("orgId").toString();
			if(!aOrgId.equals(cOrgId)){
				if(i>0){
					deptMap.put(aOrgId, rList);
				}

				aOrgId = cOrgId;
				rList = new ArrayList();
			}
			rList.add(list.get(i));
		}
		deptMap.put(cOrgId, rList);
		rObj.put("deptObj", deptMap);		//dept list

		//user 리스트
		aOrgId = "";
		cOrgId = "";
		rList = new ArrayList();
		map.put("mainYn", "Y");		//main부서

		// 리턴값에 따른 분기, rtnField : userId, cusId, empNo (2016.11.14. 이인희)
		String rtnField = (String)map.get("rtnField");
		if(StringUtil.isEmpty(rtnField)) rtnField = "userId";

		list = commonService.getUserList(map);						//사용자 리스트
		Map userMap = new HashMap();
		for(int i=0; i<list.size(); i++){
			//리턴값에 따른 분기, rtnField : userId, cusId, empNo (2016.11.14. 이인희)
			if("cusId".equals(rtnField)){
				list.get(i).put("id", list.get(i).get("cusId").toString());
			}else if("empNo".equals(rtnField)){
				list.get(i).put("id", list.get(i).get("empNo").toString());
			}else if("userId".equals(rtnField)){
				list.get(i).put("id", list.get(i).get("userId").toString());
			}else{
				list.get(i).put("id", list.get(i).get("userId").toString());
			}

			cOrgId = list.get(i).get("orgId").toString();
			if(!aOrgId.equals(cOrgId)){
				if(i>0){
					userMap.put(aOrgId, rList);
				}

				aOrgId = cOrgId;
				rList = new ArrayList();
			}
			rList.add(list.get(i));
		}
		userMap.put(cOrgId, rList);
		rObj.put("userObj", userMap);


		//관계사 리스트중 사용자가 있는 관계사만
		for(int i=olist.size()-1; i>=0; i--){
			String orgId = olist.get(i).get("orgId").toString();
			if(!userMap.containsKey(orgId)){
				olist.remove(i);
			}
		}

		if("N".equals(map.get("isUserGroup").toString())){
			rObj.put("orgList", olist);			//org list (부서가 있는 org list)
		}else{
			/*************************************************************************
			 * 그룹별 탭추가
			 *************************************************************************/
			//가상의그룹 추가
			map.put("userId", loginInfo.get("userId").toString());
			Map userGroupMap = new HashMap();
			userGroupMap.put("CD", "0");
			userGroupMap.put("NM", "그룹");
			userGroupMap.put("orgId", "0");
			userGroupMap.put("orgNm", "그룹");
			olist.add(userGroupMap);

			rObj.put("orgList", olist);			//org list (부서가 있는 org list)
			//rObj.put("groupOrgList", olist);			//org list (부서가 있는 org list)

			//유저그룹추가
			rList = commonService.getUserGroupList(map);						//부서 리스트
			deptMap = new HashMap();
			deptMap.put("0", rList);
			rObj.put("groupDeptObj", deptMap);		//dept list

			//유저그룹상세추가
			rList = new ArrayList();
			list = commonService.getUserGroupDetailList(map);						//사용자 리스트
			userMap = new HashMap();
			for(int i=0; i<list.size(); i++){
				//리턴값에 따른 분기, rtnField : userId, cusId, empNo (2016.11.14. 이인희)
				if("cusId".equals(rtnField)){
					list.get(i).put("id", list.get(i).get("cusId").toString() + "_" + list.get(i).get("deptId").toString()+"_"+list.get(i).get("orgId").toString());
				}else if("empNo".equals(rtnField)){
					list.get(i).put("id", list.get(i).get("empNo").toString() + "_" + list.get(i).get("deptId").toString()+"_"+list.get(i).get("orgId").toString());
				}else if("userId".equals(rtnField)){
					list.get(i).put("id", list.get(i).get("userId").toString() + "_" + list.get(i).get("deptId").toString()+"_"+list.get(i).get("orgId").toString());
				}else{
					list.get(i).put("id", list.get(i).get("userId").toString() + "_" + list.get(i).get("deptId").toString()+"_"+list.get(i).get("orgId").toString());
				}
				rList.add(list.get(i));
			}

			userMap.put("0", rList);
			rObj.put("groupUserObj", userMap);
			rObj.put("groupUserList", rList);
		}

		Map orgMap = new HashMap();
		orgMap.put("authOrgId", "Y");
		orgMap.put("userId", loginInfo.get("userId").toString());
		orgMap.put("code", "CD");
		orgMap.put("name", "NM");
		orgMap.put("orgBasicAuth",loginInfo.get("orgBasicAuth").toString());
		orgMap.put("sortByOrgId", "Y");		//orgId 정렬

		List<Map> selectOrgList = commonService.getOrgCodeCombo(orgMap);

		rObj.put("selectOrgList", selectOrgList);

		AjaxResponse.responseAjaxObject(response, rObj);	//결과전송
	}

	/**
	 * 우편번호찾기 공통팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 10. 31.
	 */
	@RequestMapping(value = "/common/postPopup.do")
	public String openPostPopup(){
		return "common/daumPostPop/pop";
	}


	/**
	 * 유저그룹 목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2016. 8. 10.
	 */
	@RequestMapping(value = "/common/getUserGroupList.do")
	public void getUserGroupList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("applyOrgId", loginUser.get("applyOrgId").toString());
		map.put("userId", loginUser.get("userId").toString());

		List<Map> list = commonService.getUserGroupList(map);

		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}

	/**
	 * 유저그룹 상세목록
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	@RequestMapping(value = "/common/getUserGroupDetailList.do")
	public void getUserGroupDetailList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		Map loginUser = (Map)session.getAttribute("baseUserLoginInfo");

		map.put("applyOrgId", loginUser.get("applyOrgId").toString());
		map.put("userId", loginUser.get("userId").toString());

		List<Map> list = commonService.getUserGroupDetailList(map);

		AjaxResponse.responseAjaxSelect(response,list );	//결과전송
	}
}