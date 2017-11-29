package ib.card.service;

import java.util.ArrayList;
import java.util.List;

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
public class CardVO  extends WorkVO{

	private String sNb = "";
	private String cstSnb = "";
	private String staffNm = "";
	private String cstNm = "";
	private String cstCpnNm = "";
	private String position = "";
	private String staff = "";
	private String place = "";
	private String dv = "";
	private String dv2 = "";	//추가 20150713 식사구분(점심 1, 저녁 2)
	private String note = "";
	private String feedback = "";
	private String price = "";
	private String tmDt = "";
	private String rgDt = "";
	private String rgId = "";

	private String memoSndName = "";
	private String[] arrayName;


	private String choice_year = "";
	private String choice_monthS = "";
	private String choice_month = "";
	private String total = "";

	private String sort_date = "";
	private String sort_cst = "";
	private String sort_price = "";

	private String etcNum = "";

	private String sort_t = "";
	private String staffId = "";
	private List staffInfoList=new ArrayList();		//야근일때 사원들의 정보(퇴근시간) 가져오기위해

	private String staffSnb;

	// 2017-08-17:법인카드지출내역
	private String cardCorpInfoId; // 법인카드등록정보ID
	private String cardCorpUseYn;  // 법인카드사용여부
	private String approveYn;      // 지출승인여부
	private String approveUserId;  // 지출승인자ID
	private String approveDate;    // 지출승인일시



	public List getStaffInfoList() {
		return staffInfoList;
	}
	public void setStaffInfoList(List staffInfoList) {
		this.staffInfoList = staffInfoList;
	}
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
	 * @return the cstSnb
	 */
	public String getCstSnb() {
		return cstSnb;
	}
	/**
	 * @param cstSnb the cstSnb to set
	 */
	public void setCstSnb(String cstSnb) {
		this.cstSnb = cstSnb;
	}
	/**
	 * @return the place
	 */
	public String getPlace() {
		return place;
	}
	/**
	 * @param place the place to set
	 */
	public void setPlace(String place) {
		this.place = place;
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
	 * @return the choice_year
	 */
	public String getChoice_year() {
		return choice_year;
	}
	/**
	 * @param choice_year the choice_year to set
	 */
	public void setChoice_year(String choice_year) {
		this.choice_year = choice_year;
	}
	/**
	 * @return the choice_monthS
	 */
	public String getChoice_monthS() {
		return choice_monthS;
	}
	/**
	 * @param choice_monthS the choice_monthS to set
	 */
	public void setChoice_monthS(String choice_monthS) {
		this.choice_monthS = choice_monthS;
	}
	/**
	 * @return the choice_month
	 */
	public String getChoice_month() {
		return choice_month;
	}
	/**
	 * @param choice_month the choice_month to set
	 */
	public void setChoice_month(String choice_month) {
		this.choice_month = choice_month;
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
	 * @return the cstNm
	 */
	public String getCstNm() {
		return cstNm;
	}
	/**
	 * @param cstNm the cstNm to set
	 */
	public void setCstNm(String cstNm) {
		this.cstNm = cstNm;
	}
	/**
	 * @return the cstCpnNm
	 */
	public String getCstCpnNm() {
		return cstCpnNm;
	}
	/**
	 * @param cstCpnNm the cstCpnNm to set
	 */
	public void setCstCpnNm(String cstCpnNm) {
		this.cstCpnNm = cstCpnNm;
	}
	/**
	 * @return the position
	 */
	public String getPosition() {
		return position;
	}
	/**
	 * @param position the position to set
	 */
	public void setPosition(String position) {
		this.position = position;
	}
	/**
	 * @return the memoSndName
	 */
	public String getMemoSndName() {
		return memoSndName;
	}
	/**
	 * @param memoSndName the memoSndName to set
	 */
	public void setMemoSndName(String memoSndName) {
		this.memoSndName = memoSndName;
	}
	/**
	 * @return the arrayName
	 */
	public String[] getArrayName() {
		return arrayName;
	}
	/**
	 * @param arrayName the arrayName to set
	 */
	public void setArrayName(String[] arrayName) {
		this.arrayName = arrayName;
	}
	/**
	 * @return the staff
	 */
	public String getStaff() {
		return staff;
	}
	/**
	 * @param staff the staff to set
	 */
	public void setStaff(String staff) {
		this.staff = staff;
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
	 * @return the dv
	 */
	public String getDv() {
		return dv;
	}
	/**
	 * @param dv the dv to set
	 */
	public void setDv(String dv) {
		this.dv = dv;
	}

	public String getDv2() {
		return dv2;
	}
	public void setDv2(String dv2) {
		this.dv2 = dv2;
	}
	/**
	 * @return the feedback
	 */
	public String getFeedback() {
		return feedback;
	}
	/**
	 * @param feedback the feedback to set
	 */
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}
	public String getStaffSnb() {
		return staffSnb;
	}
	public void setStaffSnb(String staffSnb) {
		this.staffSnb = staffSnb;
	}

	/**
	 * @param cardCorpInfoId the cardCorpInfoId to set
	 */
	public String getCardCorpInfoId() {
		return cardCorpInfoId;
	}
	public void setCardCorpInfoId(String cardCorpInfoId) {
		this.cardCorpInfoId = cardCorpInfoId;
	}
	/**
	 * @param cardCorpUseYn the cardCorpUseYn to set
	 */
	public String getCardCorpUseYn() {
		return cardCorpUseYn;
	}
	public void setCardCorpUseYn(String cardCorpUseYn) {
		this.cardCorpUseYn = cardCorpUseYn;
	}
	/**
	 * @param approveYn the approveYn to set
	 */
	public String getApproveYn() {
		return approveYn;
	}
	public void setApproveYn(String approveYn) {
		this.approveYn = approveYn;
	}
	/**
	 * @param approveUserId the approveUserId to set
	 */
	public String getApproveUserId() {
		return approveUserId;
	}
	public void setApproveUserId(String approveUserId) {
		this.approveUserId = approveUserId;
	}
	/**
	 * @param approveDate the approveDate to set
	 */
	public String getApproveDate() {
		return approveDate;
	}
	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}



}