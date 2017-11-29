package ib.car.service;

import ib.cmm.ComDefaultVO;
import ib.work.service.WorkVO;

/**
 * <pre>
 * package  : ib.card.service
 * filename : CardVO.java
 * </pre>
 * 
 * @author  : ChanWoo Lee
 * @since   : 2012. 11. 14.
 * @version : 1.0.0
 */
@SuppressWarnings("serial")
public class CarVO  extends WorkVO{
	
	private String sNb = "";
	private String staffNm = "";
	private String tmDt = "";
	private String carNum = "";
	private String privateUse = "";
	private String departurePoint = "";
	private String destination = "";
	private String departureTime = "";
	private String arriveTime = "";
	private String estimatedTime = "";
	private String mileage = "";
	private String totalDistance = "";
	private String floor = "";
	private String price = "";
	private String note = "";
	private String oil = "";
	private String rgDt = "";
	private String rgId = "";
	private String upDt = "";
	private String upId = "";
	
	
	private String choiceYear = "";
	private String choiceMonthS = "";
	private String choiceMonth = "";
	private String total = "";
	
	private String sort_date = "";
	private String sort_cst = "";
	private String sort_price = "";
	
	private String etcNum = "";
	
	private String sort_t = "";
	private String staffId = "";
	/**
	 * @return the sNb
	 */
	public String getsNb() {
		return sNb;
	}
	/**
	 * @param sNb the sNb to set
	 */
	public void setsNb(String sNb) {
		this.sNb = sNb;
	}
	/**
	 * @return the staffNm
	 */
	public String getStaffNm() {
		return staffNm;
	}
	/**
	 * @param staffNm the staffNm to set
	 */
	public void setStaffNm(String staffNm) {
		this.staffNm = staffNm;
	}
	/**
	 * @return the tmDt
	 */
	public String getTmDt() {
		return tmDt;
	}
	/**
	 * @param tmDt the tmDt to set
	 */
	public void setTmDt(String tmDt) {
		this.tmDt = tmDt;
	}
	/**
	 * @return the carNum
	 */
	public String getCarNum() {
		return carNum;
	}
	/**
	 * @param carNum the carNum to set
	 */
	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}
	/**
	 * @return the privateUse
	 */
	public String getPrivateUse() {
		return privateUse;
	}
	/**
	 * @param privateUse the privateUse to set
	 */
	public void setPrivateUse(String privateUse) {
		this.privateUse = privateUse;
	}
	/**
	 * @return the departurePoint
	 */
	public String getDeparturePoint() {
		return departurePoint;
	}
	/**
	 * @param departurePoint the departurePoint to set
	 */
	public void setDeparturePoint(String departurePoint) {
		this.departurePoint = departurePoint;
	}
	/**
	 * @return the destination
	 */
	public String getDestination() {
		return destination;
	}
	/**
	 * @param destination the destination to set
	 */
	public void setDestination(String destination) {
		this.destination = destination;
	}
	/**
	 * @return the departureTime
	 */
	public String getDepartureTime() {
		return departureTime;
	}
	/**
	 * @param departureTime the departureTime to set
	 */
	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}
	/**
	 * @return the arriveTime
	 */
	public String getArriveTime() {
		return arriveTime;
	}
	/**
	 * @param arriveTime the arriveTime to set
	 */
	public void setArriveTime(String arriveTime) {
		this.arriveTime = arriveTime;
	}
	/**
	 * @return the estimatedTime
	 */
	public String getEstimatedTime() {
		return estimatedTime;
	}
	/**
	 * @param estimatedTime the estimatedTime to set
	 */
	public void setEstimatedTime(String estimatedTime) {
		this.estimatedTime = estimatedTime;
	}
	/**
	 * @return the floor
	 */
	public String getFloor() {
		return floor;
	}
	/**
	 * @param floor the floor to set
	 */
	public void setFloor(String floor) {
		this.floor = floor;
	}
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}
	/**
	 * @return the rgDt
	 */
	public String getRgDt() {
		return rgDt;
	}
	/**
	 * @param rgDt the rgDt to set
	 */
	public void setRgDt(String rgDt) {
		this.rgDt = rgDt;
	}
	/**
	 * @return the rgId
	 */
	public String getRgId() {
		return rgId;
	}
	/**
	 * @param rgId the rgId to set
	 */
	public void setRgId(String rgId) {
		this.rgId = rgId;
	}
	/**
	 * @return the upDt
	 */
	public String getUpDt() {
		return upDt;
	}
	/**
	 * @param upDt the upDt to set
	 */
	public void setUpDt(String upDt) {
		this.upDt = upDt;
	}
	/**
	 * @return the upId
	 */
	public String getUpId() {
		return upId;
	}
	/**
	 * @param upId the upId to set
	 */
	public void setUpId(String upId) {
		this.upId = upId;
	}
	/**
	 * @return the choiceYear
	 */
	public String getChoiceYear() {
		return choiceYear;
	}
	/**
	 * @param choiceYear the choiceYear to set
	 */
	public void setChoiceYear(String choiceYear) {
		this.choiceYear = choiceYear;
	}
	/**
	 * @return the choiceMonthS
	 */
	public String getChoiceMonthS() {
		return choiceMonthS;
	}
	/**
	 * @param choiceMonthS the choiceMonthS to set
	 */
	public void setChoiceMonthS(String choiceMonthS) {
		this.choiceMonthS = choiceMonthS;
	}
	/**
	 * @return the choiceMonth
	 */
	public String getChoiceMonth() {
		return choiceMonth;
	}
	/**
	 * @param choiceMonth the choiceMonth to set
	 */
	public void setChoiceMonth(String choiceMonth) {
		this.choiceMonth = choiceMonth;
	}
	/**
	 * @return the total
	 */
	public String getTotal() {
		return total;
	}
	/**
	 * @param total the total to set
	 */
	public void setTotal(String total) {
		this.total = total;
	}
	/**
	 * @return the sort_date
	 */
	public String getSort_date() {
		return sort_date;
	}
	/**
	 * @param sort_date the sort_date to set
	 */
	public void setSort_date(String sort_date) {
		this.sort_date = sort_date;
	}
	/**
	 * @return the sort_cst
	 */
	public String getSort_cst() {
		return sort_cst;
	}
	/**
	 * @param sort_cst the sort_cst to set
	 */
	public void setSort_cst(String sort_cst) {
		this.sort_cst = sort_cst;
	}
	/**
	 * @return the sort_price
	 */
	public String getSort_price() {
		return sort_price;
	}
	/**
	 * @param sort_price the sort_price to set
	 */
	public void setSort_price(String sort_price) {
		this.sort_price = sort_price;
	}
	/**
	 * @return the etcNum
	 */
	public String getEtcNum() {
		return etcNum;
	}
	/**
	 * @param etcNum the etcNum to set
	 */
	public void setEtcNum(String etcNum) {
		this.etcNum = etcNum;
	}
	/**
	 * @return the sort_t
	 */
	public String getSort_t() {
		return sort_t;
	}
	/**
	 * @param sort_t the sort_t to set
	 */
	public void setSort_t(String sort_t) {
		this.sort_t = sort_t;
	}
	/**
	 * @return the staffId
	 */
	public String getStaffId() {
		return staffId;
	}
	/**
	 * @param staffId the staffId to set
	 */
	public void setStaffId(String staffId) {
		this.staffId = staffId;
	}
	/**
	 * @return the mileage
	 */
	public String getMileage() {
		return mileage;
	}
	/**
	 * @param mileage the mileage to set
	 */
	public void setMileage(String mileage) {
		this.mileage = mileage;
	}
	/**
	 * @return the totalDistance
	 */
	public String getTotalDistance() {
		return totalDistance;
	}
	/**
	 * @param totalDistance the totalDistance to set
	 */
	public void setTotalDistance(String totalDistance) {
		this.totalDistance = totalDistance;
	}
	/**
	 * @return the price
	 */
	public String getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(String price) {
		this.price = price;
	}
	/**
	 * @return the oil
	 */
	public String getOil() {
		return oil;
	}
	/**
	 * @param oil the oil to set
	 */
	public void setOil(String oil) {
		this.oil = oil;
	}


 
}