package ib.recommend.service;

import ib.work.service.WorkVO;

/**
 * <pre>
 * package  : ib.recommend.service
 * filename : RecommendVO.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2013. 3. 20.
 * @version : 1.0.0
 */
@SuppressWarnings("serial")
public class RecommendVO  extends WorkVO{

	private String staffId = "";
	private String staffNm = "";
	private String ibCpn = "";
	private String ibCst = "";
	private String provider = "";

	private String rcmd = "";
	private String nonrcmd = "";
	private String neutral = "";
	private String offerSnb = "";

	private String ibInfo = "";
	private String ibInfoDealNet = "";


	//------- 딜정보에 기본회사정보 추가 20150703 :S ---------
	private String categoryBusiness;	//업종
	private String majorProduct;		//주요품목
	private String majorProductFull;	//주요품목(full string : 위에 majorProduct 는 너무 길경우 잘라서 쓸 수 있도록 하기 위해 ex)전자기기...)
	private String ceo;					//대표이사
	private String stockValue;			//시가총액
	private String unitPrice;			//주가
	//------- 딜정보에 기본회사정보 추가 20150703 :E ---------


	private String rgStaffPhn1;			//등록자 전화번호

	private String rcmdProposerSnb;


//	private String [] perDay;


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
	 * @return the ibCpn
	 */
	public String getIbCpn() {
		return ibCpn;
	}
	/**
	 * @param ibCpn the ibCpn to set
	 */
	public void setIbCpn(String ibCpn) {
		this.ibCpn = ibCpn;
	}
	/**
	 * @return the ibCst
	 */
	public String getIbCst() {
		return ibCst;
	}
	/**
	 * @param ibCst the ibCst to set
	 */
	public void setIbCst(String ibCst) {
		this.ibCst = ibCst;
	}
	/**
	 * @return the provider
	 */
	public String getProvider() {
		return provider;
	}
	/**
	 * @param provider the provider to set
	 */
	public void setProvider(String provider) {
		this.provider = provider;
	}
	/**
	 * @return the rcmd
	 */
	public String getRcmd() {
		return rcmd;
	}
	/**
	 * @param rcmd the rcmd to set
	 */
	public void setRcmd(String rcmd) {
		this.rcmd = rcmd;
	}
	/**
	 * @return the nonrcmd
	 */
	public String getNonrcmd() {
		return nonrcmd;
	}
	/**
	 * @param nonrcmd the nonrcmd to set
	 */
	public void setNonrcmd(String nonrcmd) {
		this.nonrcmd = nonrcmd;
	}
	/**
	 * @return the neutral
	 */
	public String getNeutral() {
		return neutral;
	}
	/**
	 * @param neutral the neutral to set
	 */
	public void setNeutral(String neutral) {
		this.neutral = neutral;
	}
	/**
	 * @return the ibInfo
	 */
	public String getIbInfo() {
		return ibInfo;
	}
	/**
	 * @param ibInfo the ibInfo to set
	 */
	public void setIbInfo(String ibInfo) {
		this.ibInfo = ibInfo;
	}
	/**
	 * @return the offerSnb
	 */
	public String getOfferSnb() {
		return offerSnb;
	}
	/**
	 * @param offerSnb the offerSnb to set
	 */
	public void setOfferSnb(String offerSnb) {
		this.offerSnb = offerSnb;
	}
	/**
	 * @return the ibInfoDealNet
	 */
	public String getIbInfoDealNet() {
		return ibInfoDealNet;
	}
	/**
	 * @param ibInfoDealNet the ibInfoDealNet to set
	 */
	public void setIbInfoDealNet(String ibInfoDealNet) {
		this.ibInfoDealNet = ibInfoDealNet;
	}
	public String getCategoryBusiness() {
		return categoryBusiness;
	}
	public void setCategoryBusiness(String categoryBusiness) {
		this.categoryBusiness = categoryBusiness;
	}
	public String getMajorProduct() {
		return majorProduct;
	}
	public void setMajorProduct(String majorProduct) {
		this.majorProduct = majorProduct;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public String getStockValue() {
		return stockValue;
	}
	public void setStockValue(String stockValue) {
		this.stockValue = stockValue;
	}
	public String getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getMajorProductFull() {
		return majorProductFull;
	}
	public void setMajorProductFull(String majorProductFull) {
		this.majorProductFull = majorProductFull;
	}
	public String getRgStaffPhn1() {
		return rgStaffPhn1;
	}
	public void setRgStaffPhn1(String rgStaffPhn1) {
		this.rgStaffPhn1 = rgStaffPhn1;
	}
	public String getRcmdProposerSnb() {
		return rcmdProposerSnb;
	}
	public void setRcmdProposerSnb(String rcmdProposerSnb) {
		this.rcmdProposerSnb = rcmdProposerSnb;
	}


}