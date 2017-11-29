package ib.system.service.impl;


import ib.cmm.util.fcc.service.StringUtil;
import ib.system.service.DeptRegService;
import ib.user.service.impl.UserDAO;

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
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service("deptRegService")
public class DeptRegServiceImpl extends AbstractServiceImpl implements DeptRegService {

    @Resource(name="deptRegDAO")
    private DeptRegDAO deptRegDAO;

    @Resource(name="userDAO")
    private UserDAO userDAO;

    protected static final Log logger = LogFactory.getLog(DeptRegServiceImpl.class);



  	//부서리스트
    public List<Map> getDeptList(Map<String, String> map) throws Exception {

		return deptRegDAO.getDeptList(map);
	}

  	//부서
    public List<Map> getDept(String deptId) throws Exception {

		return deptRegDAO.getDept(deptId);
	}


	//부서등록(신규)
	public int insertDept(Map<String, Object> map) throws Exception {

		int boardSeq = deptRegDAO.insertDept(map);			//부서 등록
		return boardSeq;
	}


	//부서등록(수정)
	public int updateDept(Map<String, Object> map) throws Exception {

		int svCnt = deptRegDAO.updateDept(map);				//권한수정

		return svCnt;
	}


	//부서삭제
	public int deleteDept(Map<String, Object> param) throws Exception {

		return deptRegDAO.deleteDept(param);
	}


	//부서리스트(콤보박스)
    public List<Map> getDeptListCombo(Map<String, String> map) throws Exception {

		return deptRegDAO.getDeptListCombo(map);
	}


    //부서별 사용자리스트
    public List<Map> getUserListOfDept(Map<String, String> map) throws Exception {

		return deptRegDAO.getUserListOfDept(map);
	}


    // 부서장 지정
  	public int doSaveManager(Map<String, String> param) throws Exception {

  		return deptRegDAO.doSaveManager(param);
  	}

  	// 부서장 지정
   	public int doSaveParentDept(Map<String, String> param) throws Exception {

   		return deptRegDAO.doSaveParentDept(param);
   	}


   	//부서트리 정보 저장
   	public int doSaveMoveDeptInfo(Map<String, String> param) throws Exception {

   		String deptInfoObj = param.get("deptInfoObj");
   		Gson gson = new Gson();
		ArrayList<Map> depthList = null;
		depthList = gson.fromJson(deptInfoObj, ArrayList.class);
   		for(int i=0;i<depthList.size();i++){
   			Map map = new HashMap();
   			map.put("deptId", depthList.get(i).get("deptId"));
   			map.put("depth", depthList.get(i).get("depth"));
   			map.put("sort", depthList.get(i).get("sort"));
   			map.put("parent", depthList.get(i).get("parent"));

   			deptRegDAO.updateMoveDeptInfo(map);
   		}

   		return depthList.size();
   	}

  //관계사  그룹카운트
  	public int getBusinessGroupCnt(Map<String, Object> param) throws Exception {
  		return deptRegDAO.getBusinessGroupCnt(param);
  	}

  	 // 부서원 이동
  	public int updateUserDepartmentForMove(Map<String, Object> param) throws Exception {
  		List<Map<String, Object>> userList = new ArrayList<Map<String,Object>>();
  		//등록할 사용자
  		String[] userArr = param.get("userList").toString().split(",");
  		String[] mainYnArr = param.get("mainYnList").toString().split(",");

  		//추가등록해야 하는 유저
		for(int i=0;i<userArr.length;i++){
			Map map = new HashMap<String, Object>();
			map.put("userSeq", param.get("userSeq").toString());
			map.put("userId", userArr[i]);

			//이전 부서 내용 지우기
			map.put("oldDeptId", param.get("oldDeptId").toString());
			deptRegDAO.updateUserDepartmentForMove(map);

			//사용자 부서장 초기화(없애기)
			deptRegDAO.deleteDeptManageForMove(map);

			//새로운 부서정보 등록하기
			map.put("deptId", param.get("deptId").toString());
			if("Y".equals(mainYnArr[i])) map.put("mainYn", mainYnArr[i]);
			else map.put("mainYn", null);

			userDAO.mergeDeptInchargeInfo(map);

		}
  		//return deptRegDAO.doSaveManager(param);
  		return 1;
  	}

}
