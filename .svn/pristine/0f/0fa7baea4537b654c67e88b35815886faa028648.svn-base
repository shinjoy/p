package ib.car.sevice.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ib.car.service.Car2Service;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("car2Service")
public class Car2ServiceImpl extends AbstractServiceImpl implements Car2Service {

	@Resource(name="car2DAO")
	Car2DAO car2Dao;


	public List<Map> selectCarList(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		return car2Dao.selectCarList(param);
	}

	public List<Map> selectCarLogList(Map<String, Object> param)throws Exception{
		// TODO Auto-generated method stub
		return car2Dao.selectCarLogList(param);
	}

	public List<Map> selectLimitCarLogList(Map<String, Object> param)throws Exception{
		// TODO Auto-generated method stub
		return car2Dao.selectLimitCarLogList(param);
	}

	public List<Map> selectScheList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return car2Dao.selectScheList(map);
	}

	public int insertCarLog(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return car2Dao.intsertCarLog(map);
	}

	public int updateCarLog(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return car2Dao.updateCarLog(map);
	}

	public List<Map> chkDistance(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return  car2Dao.chkDistance(map);
	}

	public String selectCarName(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return car2Dao.selectCarName(map);
	}

	public  String maxDistance(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return car2Dao.maxDistance(map);
	}

	/**
	 * 운행 삭제 한다.
	 * @param
	 * @return int
	 */
	public int deleteCarLog(Map<String, Object> map) throws Exception{
		return car2Dao.deleteCarLog(map);
	}



}
