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
 * filename	: CarMgmtDAO.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 12. 2.
 * @version : 
 *
 */
@Repository("carMgmtDAO")
public class CarMgmtDAO extends ComAbstractDAO{
	
	
	protected static final Log logger = LogFactory.getLog(CarMgmtDAO.class);


	/**
	 * 차량 리스트
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 2.
	 */
	public List<Map> getCarList(Map<String, Object> mParam) throws Exception{
		
		return list("eam.selectCarList", mParam);
	}

	
	/**
	 * 차량 리스트 건수
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 2.
	 */
	public int getCarListCount(Map<String, Object> param) throws Exception{
		return Integer.parseInt(selectByPk("eam.selectCarListCount", param).toString());
	}


	/**
	 * 차량 등록
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 2.
	 */
	public int insertCar(Map<String, Object> map) throws Exception{
		
		int key = -1;
		Object rslt = insert("eam.insertCar", map);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		
		return key;
		
	}

	
	/**
	 * 차량 수정
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 12. 2.
	 */
	public void updateCar(Map<String, Object> map) throws Exception{
		update("eam.updateCar", map);		
	}


	/**
	 * 차량 삭제
	 * 
	 * @param map
	 * @throws Exception
	 * @author		: csy
	 * @date		: 2016. 09. 26
	 */
	public void deleteCar(Map<String, Object> map) throws Exception{
		update("eam.deleteCar", map);		
	}
	

}