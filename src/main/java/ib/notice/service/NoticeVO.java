package ib.notice.service;

import ib.work.service.WorkVO;


/**
 * <pre>
 * package  : ib.notice.service
 * filename : NoticeVO.java
 * </pre>
 * 
 * @author  : ChanWoo Lee
 * @since   : 2014. 4. 23.
 * @version : 1.0.0
 */
@SuppressWarnings("serial")
public class NoticeVO extends WorkVO{
	private String tmDt			 = "";// '접수일자' ,
	private String way			 = "";// '사모, 공모, 일반공모, 주주배정 후 일반공모' ,
	private String categoryCd	 = "";// 'CB, BW, EB, 유증, 유무증' ,
	private String cpnId		 = "";// '종목/회사코드' ,
	private String rank			 = "";// '회차' ,
	private String price		 = "";// '굼액(억)' ,
	private String coupon		 = "";// '쿠폰%' ,
	private String ytm			 = "";// '%' ,
	private String ytp			 = "";// '%' ,
	private String payupDt		 = "";// '납입일' ,
	private String btPayUpTmDt		 = "";// '납입일잔여일' ,
	private String dueDt		 = "";// '사채만기' ,
	private String put			 = "";// 'PUT' ,
	private String eventPrice	 = "";// '행사가' ,
	private String wrtDueDt		 = "";// '워런트만기' ,
	private String btWrtTmDt		 = "";// '워런트잔여일' ,
	private String refixSale	 = "";// '메자닌리픽싱 or 증자할인율' ,
	private String superCpn		 = "";// '주관회사(담당자)' ,
	private String underWriter	 = "";// '인수자' ,
	private String buyback		 = "";// 'BUY BACK' ,
	private String premium		 = "";// '프리미엄' ,
	private String target		 = "";// '대상' ,
	private String relation		 = "";// '관계' ,
	private String assignmentDt		 = "";// '배정기준일' ,
	private String subscriptionDt	 = "";// '청약일' ,
	
	private String eventStock	 = "";// '' ,
	private String ipoDt	 	 = "";// '' ,
	private String unchangeStock	 = "";// '' ,
	private String outstandingStock	 = "";// '' ,
	private String eventUser	 = "";// '' ,
	
	//20150901
	private String sortBtn;
	
	
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
	 * @return the way
	 */
	public String getWay() {
		return way;
	}
	/**
	 * @param way the way to set
	 */
	public void setWay(String way) {
		this.way = way;
	}
	/**
	 * @return the categoryCd
	 */
	public String getCategoryCd() {
		return categoryCd;
	}
	/**
	 * @param categoryCd the categoryCd to set
	 */
	public void setCategoryCd(String categoryCd) {
		this.categoryCd = categoryCd;
	}
	/**
	 * @return the cpnId
	 */
	public String getCpnId() {
		return cpnId;
	}
	/**
	 * @param cpnId the cpnId to set
	 */
	public void setCpnId(String cpnId) {
		this.cpnId = cpnId;
	}
	/**
	 * @return the rank
	 */
	public String getRank() {
		return rank;
	}
	/**
	 * @param rank the rank to set
	 */
	public void setRank(String rank) {
		this.rank = rank;
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
	 * @return the coupon
	 */
	public String getCoupon() {
		return coupon;
	}
	/**
	 * @param coupon the coupon to set
	 */
	public void setCoupon(String coupon) {
		this.coupon = coupon;
	}
	/**
	 * @return the ytm
	 */
	public String getYtm() {
		return ytm;
	}
	/**
	 * @param ytm the ytm to set
	 */
	public void setYtm(String ytm) {
		this.ytm = ytm;
	}
	/**
	 * @return the ytp
	 */
	public String getYtp() {
		return ytp;
	}
	/**
	 * @param ytp the ytp to set
	 */
	public void setYtp(String ytp) {
		this.ytp = ytp;
	}
	/**
	 * @return the payupDt
	 */
	public String getPayupDt() {
		return payupDt;
	}
	/**
	 * @param payupDt the payupDt to set
	 */
	public void setPayupDt(String payupDt) {
		this.payupDt = payupDt;
	}
	/**
	 * @return the dueDt
	 */
	public String getDueDt() {
		return dueDt;
	}
	/**
	 * @param dueDt the dueDt to set
	 */
	public void setDueDt(String dueDt) {
		this.dueDt = dueDt;
	}
	/**
	 * @return the put
	 */
	public String getPut() {
		return put;
	}
	/**
	 * @param put the put to set
	 */
	public void setPut(String put) {
		this.put = put;
	}
	/**
	 * @return the eventPrice
	 */
	public String getEventPrice() {
		return eventPrice;
	}
	/**
	 * @param eventPrice the eventPrice to set
	 */
	public void setEventPrice(String eventPrice) {
		this.eventPrice = eventPrice;
	}
	/**
	 * @return the wrtDueDt
	 */
	public String getWrtDueDt() {
		return wrtDueDt;
	}
	/**
	 * @param wrtDueDt the wrtDueDt to set
	 */
	public void setWrtDueDt(String wrtDueDt) {
		this.wrtDueDt = wrtDueDt;
	}
	/**
	 * @return the refixSale
	 */
	public String getRefixSale() {
		return refixSale;
	}
	/**
	 * @param refixSale the refixSale to set
	 */
	public void setRefixSale(String refixSale) {
		this.refixSale = refixSale;
	}
	/**
	 * @return the superCpn
	 */
	public String getSuperCpn() {
		return superCpn;
	}
	/**
	 * @param superCpn the superCpn to set
	 */
	public void setSuperCpn(String superCpn) {
		this.superCpn = superCpn;
	}
	/**
	 * @return the underWriter
	 */
	public String getUnderWriter() {
		return underWriter;
	}
	/**
	 * @param underWriter the underWriter to set
	 */
	public void setUnderWriter(String underWriter) {
		this.underWriter = underWriter;
	}
	/**
	 * @return the buyback
	 */
	public String getBuyback() {
		return buyback;
	}
	/**
	 * @param buyback the buyback to set
	 */
	public void setBuyback(String buyback) {
		this.buyback = buyback;
	}
	/**
	 * @return the premium
	 */
	public String getPremium() {
		return premium;
	}
	/**
	 * @param premium the premium to set
	 */
	public void setPremium(String premium) {
		this.premium = premium;
	}
	/**
	 * @return the target
	 */
	public String getTarget() {
		return target;
	}
	/**
	 * @param target the target to set
	 */
	public void setTarget(String target) {
		this.target = target;
	}
	/**
	 * @return the relation
	 */
	public String getRelation() {
		return relation;
	}
	/**
	 * @param relation the relation to set
	 */
	public void setRelation(String relation) {
		this.relation = relation;
	}
	/**
	 * @return the assignmentDt
	 */
	public String getAssignmentDt() {
		return assignmentDt;
	}
	/**
	 * @param assignmentDt the assignmentDt to set
	 */
	public void setAssignmentDt(String assignmentDt) {
		this.assignmentDt = assignmentDt;
	}
	/**
	 * @return the subscriptionDt
	 */
	public String getSubscriptionDt() {
		return subscriptionDt;
	}
	/**
	 * @param subscriptionDt the subscriptionDt to set
	 */
	public void setSubscriptionDt(String subscriptionDt) {
		this.subscriptionDt = subscriptionDt;
	}
	/**
	 * @return the btWrtTmDt
	 */
	public String getBtWrtTmDt() {
		return btWrtTmDt;
	}
	/**
	 * @param btWrtTmDt the btWrtTmDt to set
	 */
	public void setBtWrtTmDt(String btWrtTmDt) {
		this.btWrtTmDt = btWrtTmDt;
	}
	/**
	 * @return the btPayUpTmDt
	 */
	public String getBtPayUpTmDt() {
		return btPayUpTmDt;
	}
	/**
	 * @param btPayUpTmDt the btPayUpTmDt to set
	 */
	public void setBtPayUpTmDt(String btPayUpTmDt) {
		this.btPayUpTmDt = btPayUpTmDt;
	}
	/**
	 * @return the eventStock
	 */
	public String getEventStock() {
		return eventStock;
	}
	/**
	 * @param eventStock the eventStock to set
	 */
	public void setEventStock(String eventStock) {
		this.eventStock = eventStock;
	}
	/**
	 * @return the ipoDt
	 */
	public String getIpoDt() {
		return ipoDt;
	}
	/**
	 * @param ipoDt the ipoDt to set
	 */
	public void setIpoDt(String ipoDt) {
		this.ipoDt = ipoDt;
	}
	/**
	 * @return the unchangeStock
	 */
	public String getUnchangeStock() {
		return unchangeStock;
	}
	/**
	 * @param unchangeStock the unchangeStock to set
	 */
	public void setUnchangeStock(String unchangeStock) {
		this.unchangeStock = unchangeStock;
	}
	/**
	 * @return the outstandingStock
	 */
	public String getOutstandingStock() {
		return outstandingStock;
	}
	/**
	 * @param outstandingStock the outstandingStock to set
	 */
	public void setOutstandingStock(String outstandingStock) {
		this.outstandingStock = outstandingStock;
	}
	/**
	 * @return the eventUser
	 */
	public String getEventUser() {
		return eventUser;
	}
	/**
	 * @param eventUser the eventUser to set
	 */
	public void setEventUser(String eventUser) {
		this.eventUser = eventUser;
	}
	public String getSortBtn() {
		return sortBtn;
	}
	public void setSortBtn(String sortBtn) {
		this.sortBtn = sortBtn;
	}
}
