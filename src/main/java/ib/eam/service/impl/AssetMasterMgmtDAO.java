package ib.eam.service.impl;

import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

/**
 * <pre>
 * package	: ib.eam.service.impl 
 * filename	: AssetMasterMgmtDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 12. 1.
 * @version : 
 *
 */
@Repository("assetMasterMgmtDAO")
public class AssetMasterMgmtDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(AssetMasterMgmtDAO.class);


	/**
	 * 자산마스터 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 1.
	 */
	public List<Map> getAssetMasterList(Map<String, Object> mParam) throws Exception{
		
		return list("eam.selectAssetMasterList", mParam);
	}

	
	/**
	 * 자산마스터 리스트 건수
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 1.
	 */
	public int getAssetMasterListCount(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("eam.selectAssetMasterListCount", param).toString());
	}

	

	/**
	 * 자산마스터 등록
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 1.
	 */
	public int insertAssetMaster(Map<String, Object> map) throws Exception{
		
		int key = -1;
		Object rslt = insert("eam.insertAssetMaster", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		
		return key;
		
	}

	
	/**
	 * 자산마스터 수정
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 1.
	 */
	public void updateAssetMaster(Map<String, Object> map) throws Exception{
		update("eam.updateAssetMaster", map);		
	}


	/**
	 * 자산마스터 삭제
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 2.
	 */
	public int deleteAssetMaster(Map<String, Object> map) throws Exception{
		return update("eam.deleteAssetMaster", map);		
	}

	

}