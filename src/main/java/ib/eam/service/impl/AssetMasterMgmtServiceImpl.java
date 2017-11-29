package ib.eam.service.impl;

import ib.eam.service.AssetMasterMgmtService;
import ib.eam.service.CarMgmtService;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;


@Service("assetMasterMgmtService")
public class AssetMasterMgmtServiceImpl extends AbstractServiceImpl implements AssetMasterMgmtService {

    @Resource(name="assetMasterMgmtDAO")
    private AssetMasterMgmtDAO assetMasterMgmtDAO;
    
    @Resource(name="carMgmtService")
    private CarMgmtService carMgmtService;
    
    protected static final Log logger = LogFactory.getLog(AssetMasterMgmtServiceImpl.class);


	//리스트
	public Map<String, Object> getAssetMasterList(Map param) throws Exception {
		
		logger.debug("#### assetMasterMgmtService.getAssetMasterList() ####");
		
		Map<String, Object> map = new HashMap<String, Object>();
		//parameter
		int pageSize = Integer.parseInt(param.get("pageSize").toString());
		int pageNo 	 = Integer.parseInt(param.get("pageNo").toString());
		
		map.put("pageNo", param.get("pageNo"));							//넘어온 검색페이지번호도 세팅해서 그대로 반환해준다.
		
		int totalCount = assetMasterMgmtDAO.getAssetMasterListCount(param);			//총 건수
		map.put("totalCount", totalCount);
		
		int pageCount = (totalCount/Integer.parseInt(param.get("pageSize").toString()));
		pageCount = (totalCount>pageCount*pageSize)?pageCount+1:pageCount;		//총 페이지수 ... (총수/페이지크기)떨어지는지, 절삭하는지 확인하여 총페이지크기를 (+1)여부결정
		map.put("pageCount", pageCount);										//총 페이지수
		
		param.put("offset", (pageNo-1) * pageSize);
		param.put("limit", Integer.parseInt(param.get("pageSize").toString()));	//페이지크기 pageSize
		
		map.put("list", assetMasterMgmtDAO.getAssetMasterList(param));				//목록리스트
		
		return map;		//Map map: pageNo(페이지번호), totalCount(총 건수), pageCount(총 페이지수), list(리스트)
	}


	//자산마스터 등록
	public int insertAssetMaster(Map<String, Object> map) throws Exception {
		
		//--------------------- 자산마스터 등록 :S --------------------- 
		logger.debug("#### assetMasterMgmtService.insertAssetMaster() ####");
		
		int assetId = assetMasterMgmtDAO.insertAssetMaster(map);		
		
		//--------------------- 자산마스터 등록 :E ---------------------
		
		return assetId;
	}
	
	//자산마스터 수정
	public void updateAssetMaster(Map<String, Object> map) throws Exception {
		
		//--------------------- 자산마스터 저장 :S --------------------- 
		
		assetMasterMgmtDAO.updateAssetMaster(map);
		
		//--------------------- 자산마스터 저장 :E ---------------------
		
	}

	//자산마스터 삭제
	public int deleteAssetMaster(Map<String, Object> map) throws Exception {
		
		//--------------------- 자산마스터 삭제 :S --------------------- 
		
		return assetMasterMgmtDAO.deleteAssetMaster(map);
		
		//--------------------- 자산마스터 삭제 :E ---------------------
		
	}
	

	
}
