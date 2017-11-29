package ib.company.service;

import ib.cmm.ComDefaultVO;
import ib.cmm.util.fcc.service.StringUtil;
import ib.work.service.WorkVO;

/**
 * <pre>
 * package  : ib.company.service
 * filename : CompanyVO.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 30.
 * @version : 1.0.0
 */
@SuppressWarnings("serial")
public class CompanyVO  extends WorkVO{

	private String sNb = "";
    private String cpnId = "";
    private String aCpnId = "";
    private String cpnNm = "";
    private String ceoId = "";
    private String listedNb = "";
    private String rgId = "";

    private String noteSNb = "";
    private String cstSnb = "";
    private String cstNm = "";
    private String cstNm1 = "";
    private String cstNm2 = "";
    private String cstNm3 = "";
    private String title = "";
    private String note = "";
    private String rgNm = "";
    private String position = "";
    private String lvCd = "";

    private String netSNb = "";
    private String subSNb = "";
    private String cpnSnb = "";
    private String netYN = "";

    private String searchCpnNm = "";
    private String permission = "";

    private String popUp = "";
    private String majorProduct = "";
    private String ceo = "";
    private String zip = "";
    private String addr = "";
    private String addrDetail = "";
    private String addrDetail2 = "";
    private String homepage = "";
    private String maxHolder = "";
    private String tel = "";
    private String irTel = "";
    private String maxStockRate = "";
    private String accountMonth = "";
    private String foundDate = "";
    private String foundDate2 = ""; //ib_company
    private String publicDate = "";
    private String priceDate = "";
    private String unitPrice = "";
    private String stockValue = "";
    private String ownStock = "";
    private String faceValue = "";
    private String money = "";

    private String phone = "";
    //검색어
    private String searchText;

    private String searchType;
    private String searchType2;

    private String comCd;

    private String beforeUnitPrice; //전일주가

    private String lvCdNum;

    private String userId;

    private String sortCol;			//정렬 컬럼
    private String sortAD;			//정렬 방향

    private String listedYn = "";
    private String seq = "";
    private String aSeq = "";		//AN*** 자동증가 상장사코드
    private String aFSeq = "";		//AF*** 자동증가 해외 상장사코드

    private String openPage = "";
    private String workCpnNm = "";

    private String domesticYn = ""; //국내,해외

    private String refOrgId = ""; // 곤계사아이디


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
	public String getaCpnId() {
		return aCpnId;
	}
	public void setaCpnId(String aCpnId) {
		this.aCpnId = aCpnId;
	}
	/**
	 * @return the cpnNm
	 */
	public String getCpnNm() {
		return cpnNm;
	}
	/**
	 * @param cpnNm the cpnNm to set
	 */
	public void setCpnNm(String cpnNm) {
		this.cpnNm = cpnNm;
	}
	/**
	 * @return the ceoId
	 */
	public String getCeoId() {
		return ceoId;
	}
	/**
	 * @param ceoId the ceoId to set
	 */
	public void setCeoId(String ceoId) {
		this.ceoId = ceoId;
	}
	/**
	 * @return the listedNb
	 */
	public String getListedNb() {
		return listedNb;
	}
	/**
	 * @param listedNb the listedNb to set
	 */
	public void setListedNb(String listedNb) {
		this.listedNb = listedNb;
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
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
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
	 * @return the rgNm
	 */
	public String getRgNm() {
		return rgNm;
	}
	/**
	 * @param rgNm the rgNm to set
	 */
	public void setRgNm(String rgNm) {
		this.rgNm = rgNm;
	}
	/**
	 * @return the noteSNb
	 */
	public String getNoteSNb() {
		return noteSNb;
	}
	/**
	 * @param noteSNb the noteSNb to set
	 */
	public void setNoteSNb(String noteSNb) {
		this.noteSNb = noteSNb;
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
	 * @return the netSNb
	 */
	public String getNetSNb() {
		return netSNb;
	}
	/**
	 * @param netSNb the netSNb to set
	 */
	public void setNetSNb(String netSNb) {
		this.netSNb = netSNb;
	}
	/**
	 * @return the subSNb
	 */
	public String getSubSNb() {
		return subSNb;
	}
	/**
	 * @param subSNb the subSNb to set
	 */
	public void setSubSNb(String subSNb) {
		this.subSNb = subSNb;
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
	 * @return the cpnSnb
	 */
	public String getCpnSNb() {
		return cpnSnb;
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
	 * @return the searchCpnNm
	 */
	public String getSearchCpnNm() {
		return searchCpnNm;
	}
	/**
	 * @param searchCpnNm the searchCpnNm to set
	 */
	public void setSearchCpnNm(String searchCpnNm) {
		this.searchCpnNm = searchCpnNm;
	}
	/**
	 * @return the permission
	 */
	public String getPermission() {
		return permission;
	}
	/**
	 * @param permission the permission to set
	 */
	public void setPermission(String permission) {
		this.permission = permission;
	}
	/**
	 * @return the netYN
	 */
	public String getNetYN() {
		return netYN;
	}
	/**
	 * @param netYN the netYN to set
	 */
	public void setNetYN(String netYN) {
		this.netYN = netYN;
	}
	/**
	 * @return the popUp
	 */
	public String getPopUp() {
		return popUp;
	}
	/**
	 * @param popUp the popUp to set
	 */
	public void setPopUp(String popUp) {
		this.popUp = popUp;
	}
	/**
	 * @return the lvCd
	 */
	public String getLvCd() {
		return lvCd;
	}
	/**
	 * @param lvCd the lvCd to set
	 */
	public void setLvCd(String lvCd) {
		this.lvCd = lvCd;
	}
	/**
	 * @return the majorProduct
	 */
	public String getMajorProduct() {
		return majorProduct;
	}
	/**
	 * @param majorProduct the majorProduct to set
	 */
	public void setMajorProduct(String majorProduct) {
		this.majorProduct = majorProduct;
	}
	/**
	 * @return the ceo
	 */
	public String getCeo() {
		return ceo;
	}
	/**
	 * @param ceo the ceo to set
	 */
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	/**
	 * @return the addr
	 */
	public String getAddr() {
		return addr;
	}

	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAddrDetail() {
		return addrDetail;
	}
	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}

	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	/**
	 * @param addr the addr to set
	 */
	public void setAddr(String addr) {
		this.addr = addr;
	}
	/**
	 * @return the maxHolder
	 */
	public String getMaxHolder() {
		return maxHolder;
	}
	/**
	 * @param maxHolder the maxHolder to set
	 */
	public void setMaxHolder(String maxHolder) {
		this.maxHolder = maxHolder;
	}
	/**
	 * @return the tel
	 */
	public String getTel() {
		return tel;
	}
	/**
	 * @param tel the tel to set
	 */
	public void setTel(String tel) {
		this.tel = tel;
	}
	/**
	 * @return the irTel
	 */
	public String getIrTel() {
		return irTel;
	}
	/**
	 * @param irTel the irTel to set
	 */
	public void setIrTel(String irTel) {
		this.irTel = irTel;
	}
	/**
	 * @return the maxStockRate
	 */
	public String getMaxStockRate() {
		return maxStockRate;
	}
	/**
	 * @param maxStockRate the maxStockRate to set
	 */
	public void setMaxStockRate(String maxStockRate) {
		this.maxStockRate = maxStockRate;
	}
	/**
	 * @return the accountMonth
	 */
	public String getAccountMonth() {
		return accountMonth;
	}
	/**
	 * @param accountMonth the accountMonth to set
	 */
	public void setAccountMonth(String accountMonth) {
		this.accountMonth = accountMonth;
	}
	/**
	 * @return the foundDate
	 */
	public String getFoundDate() {
		if(StringUtil.isEmpty(foundDate)) return null;
		else return foundDate;
	}
	/**
	 * @param foundDate the foundDate to set
	 */
	public void setFoundDate(String foundDate) {
		this.foundDate = foundDate;
	}

	public String getFoundDate2() {
		if(StringUtil.isEmpty(foundDate2)) return null;
		else return foundDate2;
	}
	public void setFoundDate2(String foundDate2) {
		this.foundDate2 = foundDate2;
	}
	/**
	 * @return the publicDate
	 */
	public String getPublicDate() {
		return publicDate;
	}
	/**
	 * @param publicDate the publicDate to set
	 */
	public void setPublicDate(String publicDate) {
		this.publicDate = publicDate;
	}
	/**
	 * @return the priceDate
	 */
	public String getPriceDate() {
		return priceDate;
	}
	/**
	 * @param priceDate the priceDate to set
	 */
	public void setPriceDate(String priceDate) {
		this.priceDate = priceDate;
	}
	/**
	 * @return the stockValue
	 */
	public String getStockValue() {
		return stockValue;
	}
	/**
	 * @param stockValue the stockValue to set
	 */
	public void setStockValue(String stockValue) {
		this.stockValue = stockValue;
	}
	/**
	 * @return the ownStock
	 */
	public String getOwnStock() {
		return ownStock;
	}
	/**
	 * @param ownStock the ownStock to set
	 */
	public void setOwnStock(String ownStock) {
		this.ownStock = ownStock;
	}
	/**
	 * @return the faceValue
	 */
	public String getFaceValue() {
		return faceValue;
	}
	/**
	 * @param faceValue the faceValue to set
	 */
	public void setFaceValue(String faceValue) {
		this.faceValue = faceValue;
	}
	/**
	 * @return the money
	 */
	public String getMoney() {
		return money;
	}
	/**
	 * @param money the money to set
	 */
	public void setMoney(String money) {
		this.money = money;
	}


	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	/**
	 * @return the unitPrice
	 */
	public String getUnitPrice() {
		return unitPrice;
	}
	/**
	 * @param unitPrice the unitPrice to set
	 */
	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	/**
	 * @return the cstNm1
	 */
	public String getCstNm1() {
		return cstNm1;
	}
	/**
	 * @param cstNm1 the cstNm1 to set
	 */
	public void setCstNm1(String cstNm1) {
		this.cstNm1 = cstNm1;
	}
	public String getCpnSnb() {
		return cpnSnb;
	}
	public void setCpnSnb(String cpnSnb) {
		this.cpnSnb = cpnSnb;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchType2() {
		return searchType2;
	}
	public void setSearchType2(String searchType2) {
		this.searchType2 = searchType2;
	}
	public String getComCd() {
		return comCd;
	}
	public void setComCd(String comCd) {
		this.comCd = comCd;
	}
	public String getBeforeUnitPrice() {
		return beforeUnitPrice;
	}
	public void setBeforeUnitPrice(String beforeUnitPrice) {
		this.beforeUnitPrice = beforeUnitPrice;
	}
	public String getCstNm2() {
		return cstNm2;
	}
	public void setCstNm2(String cstNm2) {
		this.cstNm2 = cstNm2;
	}
	public String getCstNm3() {
		return cstNm3;
	}
	public void setCstNm3(String cstNm3) {
		this.cstNm3 = cstNm3;
	}
	public String getLvCdNum() {
		return lvCdNum;
	}
	public void setLvCdNum(String lvCdNum) {
		this.lvCdNum = lvCdNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSortCol() {
		return sortCol;
	}
	public void setSortCol(String sortCol) {
		this.sortCol = sortCol;
	}
	public String getSortAD() {
		return sortAD;
	}
	public void setSortAD(String sortAD) {
		this.sortAD = sortAD;
	}
	public String getListedYn() {
		return listedYn;
	}
	public void setListedYn(String listedYn) {
		this.listedYn = listedYn;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getaSeq() {
		return aSeq;
	}
	public void setaSeq(String aSeq) {
		this.aSeq = aSeq;
	}
	public String getOpenPage() {
		return openPage;
	}
	public void setOpenPage(String openPage) {
		this.openPage = openPage;
	}
	public String getWorkCpnNm() {
		return workCpnNm;
	}
	public void setWorkCpnNm(String workCpnNm) {
		this.workCpnNm = workCpnNm;
	}
	public String getAddrDetail2() {
		return addrDetail2;
	}
	public void setAddrDetail2(String addrDetail2) {
		this.addrDetail2 = addrDetail2;
	}
	public String getDomesticYn() {
		return domesticYn;
	}
	public void setDomesticYn(String domesticYn) {
		this.domesticYn = domesticYn;
	}
	public String getaFSeq() {
		return aFSeq;
	}
	public void setaFSeq(String aFSeq) {
		this.aFSeq = aFSeq;
	}
	public String getRefOrgId() {
		return refOrgId;
	}
	public void setRefOrgId(String refOrgId) {
		this.refOrgId = refOrgId;
	}


}