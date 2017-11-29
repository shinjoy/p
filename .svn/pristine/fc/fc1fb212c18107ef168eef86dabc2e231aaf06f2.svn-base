/**
 * 
 */
package ib.car.sevice.impl;

import ib.car.service.CarVO;
import ib.cmm.service.impl.ComAbstractDAO;

import java.util.List;

import org.springframework.stereotype.Repository;

/**
 * <pre>
 * package  : ib.car.sevice.impl
 * filename : CarDAO.java
 * </pre>
 * 
 * @author  : ChanWoo Lee
 * @since   : 2012. 11. 23.
 * @version : 1.0.0
 */
@Repository("carDAO")
public class CarDAO extends ComAbstractDAO{
	@SuppressWarnings("unchecked")
	public List<CarVO> selectCarUsedList(CarVO VO) throws Exception {
		return list("carDAO.selectCarUsedList", VO);
	}

	/**
	 *
	 * @MethodName : insertCarUsedList
	 * @param carVO
	 * @return
	 */
	public int insertCarUsedList(CarVO VO) throws Exception {
		return (Integer)update("carDAO.insertCarUsedList", VO);
	}

	/**
	 *
	 * @MethodName : selectTotalDistance
	 * @param carVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CarVO> selectTotalDistance(CarVO VO) throws Exception {
		return list("carDAO.selectTotalDistance", VO);
	}

	/**
	 *
	 * @MethodName : selectCarParkingFloorList
	 * @param carVO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CarVO> selectCarParkingFloorList(CarVO VO) throws Exception {
		return list("carDAO.selectCarParkingFloorList", VO);
	}

	/**
	 *
	 * @MethodName : deleteCarUsedList
	 * @param carVO
	 * @return
	 */
	public int deleteCarUsedList(CarVO VO) throws Exception {
		return (Integer)update("carDAO.deleteCarUsedList", VO);
	}

	/**
	 *
	 * @MethodName : updateFloor
	 * @param carVO
	 */
	public int updateFloor(CarVO VO) throws Exception {
		return (Integer)update("carDAO.updateFloor", VO);
	}

}