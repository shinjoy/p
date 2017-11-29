
package ib.car.sevice.impl;



import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("car2DAO")
public class Car2DAO extends ComAbstractDAO{
	
	
	@SuppressWarnings("unchecked")
	public List<Map> selectCarList(Map<String, Object> param) throws Exception {
		return list("car2.selectCarList",param);
	}

	@SuppressWarnings("unchecked")
	public List<Map> selectCarLogList(Map<String, Object> param) throws Exception {
		return list("car2.selectCarLogList",param);
	}
	@SuppressWarnings("unchecked")
	public List<Map> selectLimitCarLogList(Map<String, Object> param) throws Exception {
		return list("car2.selectLimitCarLogList",param);
	}
	@SuppressWarnings("unchecked")
	public List<Map> selectScheList(Map<String, Object> param) throws Exception {
		return list("car2.selectScheList",param);
	}
	@SuppressWarnings("unchecked")
	public int intsertCarLog(Map<String, Object> param) throws Exception {
		int key = -1;
		Object rslt = insert("car2.intsertCarLog", param);
		if(rslt != null)
			key = Integer.parseInt(rslt.toString());
		return key;
	}
	@SuppressWarnings("unchecked")
	public List<Map> chkDistance(Map<String, Object> param) throws Exception {
		return list("car2.chkDistance",param);
	}
	@SuppressWarnings("unchecked")
	public String selectCarName(Map<String, Object> param) throws Exception {
		return (String) selectByPk("car2.selectCarName",param);
	}
	@SuppressWarnings("unchecked")
	public String maxDistance(Map<String, Object> param) throws Exception {
		return (String) selectByPk("car2.maxDistance",param);
	}
	
	
}