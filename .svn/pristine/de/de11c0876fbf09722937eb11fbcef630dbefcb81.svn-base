package ib.approve.service.impl;


import ib.approve.service.ApproveLineService;
import ib.approve.service.ApproveVo;
import ib.approve.service.ApproveVoList;
import ib.system.service.DeptRegService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service("approveLineService")
public class ApproveLineServiceImpl extends AbstractServiceImpl implements ApproveLineService {

    @Resource(name="approveLineDAO")
    private ApproveLineDAO approveLineDAO;

    @Resource(name="deptRegService")
    private DeptRegService deptRegService;

    protected static final Log logger = LogFactory.getLog(ApproveLineServiceImpl.class);

    /**
	 * 결재선관리 목록조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public List<Map> selectApproveHeaderList(Map<String, Object> map) throws Exception{
		return approveLineDAO.selectApproveHeaderList(map);
	}

	/**
	 * 결재선관리 저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
    public int doSaveApproveHeader(Map<String, String> map) throws Exception {
    	int cnt = 0;

    	String appvDocClass = map.get("appvDocClass");

    	String decisionYn = "";

        //전결규정셋팅
        if(map.containsKey("decisionYn")&&map.get("decisionYn")!=null) decisionYn = map.get("decisionYn").toString();

        //전결규정여부가 사용안함 이거나 넘어오지 않으면 중복체크를한다.
        if(!appvDocClass.equals("BUY")&&(decisionYn.equals("")||decisionYn.equals("N"))){
            cnt = approveLineDAO.getApproveHeaderDupCnt(map);  //결재선관리 중복체크
            if(cnt > 0){
                return -1;
            }
        }



        //구매양식이면서 전결규정사용을 해야 금액 구간 체크를 한다.
        if(appvDocClass.equals("BUY")&&decisionYn.equals("Y")){
    	    cnt = approveLineDAO.getBuyAmountApproveHeaderDupCnt(map);  //구매결재금액 중첩체크
            if(cnt > 0){
                return -2;
            }
        }

    	String actionType = map.get("actionType");
    	if("INSERT".equals(actionType)){
    		cnt = approveLineDAO.insertApproveHeader(map);
    	}else{
    		cnt = approveLineDAO.updateApproveHeader(map);
    	}

		return cnt;
	}

	/**
	 * 결재라인 목록조회
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
	public List<Map> selectApproveLineList(Map<String, Object> map) throws Exception{
		return approveLineDAO.selectApproveLineList(map);
	}

	/**
	 * 결재라인 저장
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
    public int doSaveApproveLine(Map<String, String> map,ApproveVoList appVoList) throws Exception {
    	int cnt = 0;

    	//결재라인 삭제
    	cnt = this.deleteApproveLine(map);

        List<ApproveVo> approveVos = appVoList.getAppVoList();
    	//List<> approveVos = (List)<ApproveVo>map.get("appVoList");

        for(ApproveVo approveVo : approveVos){
        	approveVo.setAppvHeaderId(map.get("appvHeaderId").toString());
        	approveVo.setUserId(map.get("userId").toString());
        	approveVo.setOrgId(map.get("applyOrgId").toString());
            cnt = approveLineDAO.insertApproveLine(approveVo);
        }
		return cnt;
	}

    /**
	 * 결재라인 삭제
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 21
	 */
    public int deleteApproveLine(Map<String, String> map) throws Exception {
    	return approveLineDAO.deleteApproveLine(map);
	}

    //사내서식 문서타입 조회
  	public List<EgovMap> appvCompanyListForLine(Map<String, Object> map) throws Exception{
  		return approveLineDAO.appvCompanyListForLine(map);
  	}
  	//결재라인복사
  	public String processCopyAppvLine(Map<String, String> map) throws Exception{

  		String copyStr = map.get("copyStr");

  		String[] copyStrBuf = copyStr.split(",");

  		String oriCopyStr = copyStrBuf[0];

  		String[] oriCopyStrBuf = oriCopyStr.split("[|]");

  		Map<String,String> copyMap =  new HashMap<String, String>();

  		copyMap.put("oriAppvClass", oriCopyStrBuf[1]);
  		copyMap.put("oriAppvType", oriCopyStrBuf[2]);
  		copyMap.put("oriAppvHeaderId", oriCopyStrBuf[3]);
  		copyMap.put("userId", map.get("userId"));

  		String returnMsg = "SUCCESS";
  		//신규추가일때 유효성 체크
  		for(int i = 1; i <copyStrBuf.length;i++){
  			String validStr = copyStrBuf[i];

  			String[] validStrBuf = validStr.split("[|]");

  			if(validStrBuf[0].equals("insert")){
  				Map<String,String> validMap = new HashMap<String, String>();
  				validMap.put("applyOrgId", map.get("applyOrgId"));
  				validMap.put("appvDocClass", validStrBuf[1]);
  				validMap.put("appvDocType", validStrBuf[2]);
  				validMap.put("appvHeaderName", validStrBuf[4]);

  				Integer validCnt = approveLineDAO.getApproveHeaderDupCnt(validMap);

  				if(validCnt>0){
  					returnMsg = i+"|"+validStrBuf[1]+"|"+validStrBuf[2]+"|결재라인명 ["+ validStrBuf[4]+"] 은(는) 중복된 결재라인명입니다.";
  					break;
  				}
  			}
  		}

  		if(!returnMsg.equals("SUCCESS")) return returnMsg;

  		//저장/update
  		for(int i = 1; i <copyStrBuf.length;i++){
  			String validStr = copyStrBuf[i];

  			String[] validStrBuf = validStr.split("[|]");

  			if(validStrBuf[0].equals("insert")){

  		  		Map<String,String> insertMap = new HashMap<String, String>();
  		  		insertMap.put("applyOrgId", map.get("applyOrgId"));
  		  		insertMap.put("appvDocClass", validStrBuf[1]);
  		  		insertMap.put("appvDocType",  validStrBuf[2]);
  		  		insertMap.put("appvHeaderName",  validStrBuf[4]);
  		  		insertMap.put("enable",  "Y");
  		  		insertMap.put("closed",  "N");
  		  		insertMap.put("userId",   map.get("userId"));

  		  		if(validStrBuf[1].equals("BUY")){
  		  		insertMap.put("decisionYn",  "N");
  		  		}

  		  		Integer appvHeaderId= approveLineDAO.insertApproveHeader(insertMap);

  		  		copyMap.put("targetAppvClass", validStrBuf[1]);
		  		copyMap.put("targetAppvType", validStrBuf[2]);
		  		copyMap.put("targetAppvHeaderId", appvHeaderId.toString());

		  		approveLineDAO.insertCopyApproveLine(copyMap);


  			}else if(validStrBuf[0].equals("update")){
  				copyMap.put("targetAppvClass", validStrBuf[1]);
		  		copyMap.put("targetAppvType", validStrBuf[2]);
		  		copyMap.put("targetAppvHeaderId", validStrBuf[3]);

		  		Map<String,String> deleteMap = new HashMap<String, String>();
		  		deleteMap.put("appvHeaderId", validStrBuf[3]);
		  		deleteMap.put("applyOrgId", map.get("applyOrgId"));
		  		approveLineDAO.deleteApproveLine(deleteMap);

		  		approveLineDAO.insertCopyApproveLine(copyMap);
  			}
  		}

  		return returnMsg;
  	}

	/**
	 * 직원별 상위부서정보. 지우지 말것
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: 이인희
	 * @date		: 2016. 10. 22.
	 */
     /*
    public List<Map> getApproveLineHighDeptInfo(Map<String, String> map) throws Exception {

        List<Map> highDeptInfoListMap = new ArrayList<Map>();

        String downDeptId = map.get("deptId");

        //getDept
        int keyIdx = 0;
        Iterator<String> keys = map.keySet().iterator();
        while(keys.hasNext()){
            String key = keys.next();

            if(key.startsWith("appVoList[") && key.endsWith("].appvLineType")){

                if(map.get(key).equals("HIGH_DEPT")){
                    List<Map> dpetListMap = deptRegService.getDept(downDeptId);

                    if(dpetListMap.size() > 0){
                        Map downDeptInfo = dpetListMap.get(0);
                        String parentDeptId   = ""+downDeptInfo.get("parentDeptId");
                        String parentDeptName = (String)downDeptInfo.get("parentDeptName");

                        Map tempHighDeptInfoMap = new HashMap();
                        tempHighDeptInfoMap.put("objIdx", keyIdx+"");
                        tempHighDeptInfoMap.put("deptId", parentDeptId);
                        tempHighDeptInfoMap.put("deptName", parentDeptName);

                        downDeptId = parentDeptId;

                        highDeptInfoListMap.add(tempHighDeptInfoMap);
                    }
                    else{
                        Map tempHighDeptInfoMap = new HashMap();
                        tempHighDeptInfoMap.put("objIdx", keyIdx+"");
                        tempHighDeptInfoMap.put("deptId", 0);
                        tempHighDeptInfoMap.put("deptName", null);

                        highDeptInfoListMap.add(tempHighDeptInfoMap);
                    }
                }
                else{
                    Map tempHighDeptInfoMap = new HashMap();
                    tempHighDeptInfoMap.put("objIdx", keyIdx+"");
                    tempHighDeptInfoMap.put("deptId", 0);
                    tempHighDeptInfoMap.put("deptName", null);

                    highDeptInfoListMap.add(tempHighDeptInfoMap);
                }

                keyIdx++;
            };
        }

        return highDeptInfoListMap;  //상위부서정보
	}
    */


	/**
	 * 결재자
	 *
	 * @param		:
	 * @return		:
	 * @exception	:

	 */
	public List<Map> getApproveUserList(Map<String, Object> map) throws Exception{
		return approveLineDAO.getApproveUserList(map);
	}

}
