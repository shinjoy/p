package ib.cmm;

import ib.work.service.WorkVO;

import java.io.Serializable;

/**
 * <pre>
 * package  : ib.cmm
 * filename : ComCodeVO.java
 * </pre>
 * 
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 27.
 * @version : 1.0.0
 */
@SuppressWarnings("serial")
public class FileUpDbVO extends WorkVO {
    private String sNb = "";
    private String offerSnb = "";
    private String subCd = "";
    private String reportYN = "";
    private String realName = "";
    private String makeName = "";
    private String path = "";
    private String fileCategory = "";
    private String rgDt = "";
    private String upDt = "";
    private String rgId = "";
    private String upId = "";
    
    private String privateYn = "";
    
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
	 * @return the realName
	 */
	public String getRealName() {
		return realName;
	}
	/**
	 * @param realName the realName to set
	 */
	public void setRealName(String realName) {
		this.realName = realName;
	}
	/**
	 * @return the makeName
	 */
	public String getMakeName() {
		return makeName;
	}
	/**
	 * @param makeName the makeName to set
	 */
	public void setMakeName(String makeName) {
		this.makeName = makeName;
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
	 * @return the path
	 */
	public String getPath() {
		return path;
	}
	/**
	 * @param path the path to set
	 */
	public void setPath(String path) {
		this.path = path;
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
	 * @return the reportYN
	 */
	public String getReportYN() {
		return reportYN;
	}
	/**
	 * @param reportYN the reportYN to set
	 */
	public void setReportYN(String reportYN) {
		this.reportYN = reportYN;
	}
	/**
	 * @return the fileCategory
	 */
	public String getFileCategory() {
		return fileCategory;
	}
	/**
	 * @param fileCategory the fileCategory to set
	 */
	public void setFileCategory(String fileCategory) {
		this.fileCategory = fileCategory;
	}
	/**
	 * @return the subCd
	 */
	public String getSubCd() {
		return subCd;
	}
	/**
	 * @param subCd the subCd to set
	 */
	public void setSubCd(String subCd) {
		this.subCd = subCd;
	}
	public String getPrivateYn() {
		return privateYn;
	}
	public void setPrivateYn(String privateYn) {
		this.privateYn = privateYn;
	}



    
}
