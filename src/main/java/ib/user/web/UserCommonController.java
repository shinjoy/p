package ib.user.web;


import ib.cmm.util.sim.service.AjaxResponse;
import ib.user.service.UserCommonService;

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
public class UserCommonController {

	@Resource(name = "userCommonService")
	private UserCommonService userCommonService;

	
	protected static final Log logger = LogFactory.getLog(UserCommonController.class);


	/**
	 * 사용자 or 부서 선택 공통 팝업창
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 8. 17.
	 */
	@RequestMapping(value = "/user/selectUserOrDeptPopup.do")
	public String selectUserPopup(HttpServletRequest request,
			HttpSession session, @RequestParam Map<String,Object> map, HttpServletResponse response, ModelMap model) throws Exception {
		
		
		
		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
		
		return "user/selectUserOrDeptPopup/pop";
	}
	
	
	/**
	 * 부서정보 TREE
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 11. 12.
	 */
	@RequestMapping(value = "/user/getDeptListForTree.do")
	public void getDeptListForTree(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {

		
		map.put("root", "yes");											//일단 root 노드 들만 불러오고..
		List<Map> list = userCommonService.getDeptListForTree(map);
		
		StringBuffer tree = new StringBuffer();							//최종 tree
		
		tree.append("[");
		
		int cnt = list.size();
		for(int i=0; i<cnt; i++){
			
			tree.append("{id:'" 	+ list.get(i).get("deptId").toString())
				.append("',text:'" 	+ list.get(i).get("korName").toString());
				
			if("0".equals(list.get(i).get("childCnt").toString())){		//leaf 노드 이면
				tree.append("'}");
			}else {
				tree.append("',children:[" + getDeptListForTreeChildren(list.get(i).get("deptId").toString(), map) +"]}");	//자식 노드 세팅(자식노드 함수호출)
			}
			
			if(i != cnt-1)
				tree.append(",");
		}
		
		tree.append("]");
		
		AjaxResponse.responseAjaxObject(response, tree.toString());		//결과전송
	}
	
	//자식 노드
	String getDeptListForTreeChildren(String deptId, Map map) throws Exception{
		
		Map<String,String> param = new HashMap<String,String>();		//dept_id 를 담아 찾아올 map
		param.put("parentId",	deptId);		//parameter
		param.put("deptClass", 	map.get("deptClass").toString());
		
		List<Map> list = userCommonService.getDeptListForTree(param);
		
		StringBuffer tree = new StringBuffer();							//자식 tree
		
		int cnt = list.size();
		for(int i=0; i<cnt; i++){
			
			tree.append("{id:'" 	+ list.get(i).get("deptId").toString())
				.append("',text:'" 	+ list.get(i).get("korName").toString());
				
			if("0".equals(list.get(i).get("childCnt").toString())){		//leaf 노드 이면
				tree.append("'}");
			}else {
				tree.append("',children:[" + getDeptListForTreeChildren(list.get(i).get("deptId").toString(), map) +"]}");	//자식 노드 세팅(자식노드 함수 재귀호출)
			}
			
			if(i != cnt-1)
				tree.append(",");
		}
		
		return tree.toString();
	}
	
	
	/**
	 * 부서별 사원
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 11. 13.
	 */
	@RequestMapping(value = "/user/getUserListInDept.do")
	public void getUserListInDept(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session, ModelMap model,
			@RequestParam Map<String,String> map) throws Exception {
		
		List<Map> list = userCommonService.getUserListInDept(map);
				
		AjaxResponse.responseAjaxSelect(response, list);	//결과전송
	}
	
	
	/**
	 * 부서 및 직책 선택 팝업창
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 8. 17.
	 */
	@RequestMapping(value = "/user/selectDeptInchargePopup.do")
	public String selectDeptInchargePopup(HttpServletRequest request,
			HttpSession session, @RequestParam Map<String,Object> map, HttpServletResponse response, ModelMap model) throws Exception {
		
		
		
		model.addAllAttributes(map);	//받은 파라미터 화면으로 그대로 전달.
		
		return "user/selectDeptInchargePopup/pop";
	}
	
	
	
	/**
	 * 사용자 선택 공통 팝업
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: sjy
	 * @date		: 2017. 1. 31.
	 */
	@RequestMapping(value="user/selectUserCheckPopup/pop.do")
	public String selectUserCheckPopup(HttpServletRequest request,
			HttpSession session,HttpServletResponse response,
			@RequestParam Map<String,Object> map,
			ModelMap model) throws Exception{
		
		model.addAllAttributes(map);
		return "user/selectUserCheckPopup/pop";
	}
	
}