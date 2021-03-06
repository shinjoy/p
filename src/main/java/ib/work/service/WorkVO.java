package ib.work.service;

import ib.cmm.ComDefaultVO;

/**
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 10.
 * @filename : WorkVO.java
 * @version : 1.0.0
 * @see
 *
 * <pre>
 * package  : ib.work.service
 * </pre>
 */
@SuppressWarnings("serial")
public class WorkVO  extends ComDefaultVO{

	public final String ccdOffCd            = "00002";        //00002
	public final String ccdInfoRegType      = "INFO_REG_TYPE";          //00002 00000
	public final String ccdOfferType        = "OFFER_TYPE";             //00002 00001
	public final String ccdPublicRelation   = "PUBLIC_RELATION";        //00002 00002

	public final String ccdPrgressCd        = "DEAL_PROCESS_STATUS";    //00004
	public final String ccdCateCd           = "DEAL_KIND";              //00005

    public final String ccdMidOffCd         = "00011";          //00011
    public final String ccdSourcingType     = "SOURCING_TYPE";          //00011 00000
    public final String ccdAttractFunc      = "ATTRACT_FUND";          //00011 00001
    public final String ccdShareHolder      = "SHARE_HOLDER";          //00011 00007

	public final String ccdFamily           = "FAMILY_RELATION";        //00012
	public final String ccdNWstaff          = "CUSTOMER_TYPE";          //00013
	public final String ccdKeyPoint         = "INFO_CORE_CHECK";        //00018
	public final String ccdMainMenu         = "00019";



	private String cusId;		//고객번호 추가 20160307
	private String sNb     = "";
	private String rgDt    = "";
	private String upDt    = "";
	private String tmDt    = "";
	private String name    = "";
	private String title   = "";
	private String note    = "";
	private String bsnsRecPrivate    = "";
	private String cateBsns    = "";
	private String process = "";
	private String processNm = "";
	private String rgId    = "";
	private String usrId    = "";
	private String usrNm    = "";
	private String team    = "";

	private String focus    = "";

	private String memo4db = "";
	private String sorting = "";
	private String tab = "";
	private String listed = "";			//상장여부 'Y'	20160127
	private String isEtc = "";			//제안기타 'Y'	20160127

	private String choiceYear = "";
	private String choiceYearS = "";
	private String choiceMonth = "";
	private String choiceMonthS = "";
	private String choiceDay = "";
	private String choiceDayS = "";

	private String mainYn = "";

//	memo
	private String memoSNb = "";
	private String sttsCd = "";
	private String comment = "";
	private String importance = "";
	private String oldcomment = "";
	private String memoSndName = "";
	private String memoSndSnb = "";
	private String day = "";
	private String dayF = "";
	private String[] arrayName;
	private String priv = "";//private
	private String cmntStaffs = "";

//제안
	private String middleOfferCd = "";
	private String offerCd = "";
	private String entrust = "";
	private String cpnCst = "";
	private String prevCpnCst = "";
	private String cpnSnb = "";
	private String offerId = "";
	private String middleOfferNm = "";
	private String offerNm = "";
	private String rgNm = "";
	private String cstId = "";
	private String cstNm = "";
	private String cstCpnNm = "";
	private String cstCpnNm2 = "";
	private String cstCpnId = "";
	private String cstAcpnId = "";
	private String position = "";
	private String cpnId = "";
	private String aCpnId = "";
	private String cpnNm = "";
	private String categoryCd = "";
	private String categoryNm = "";
	private String price = "";
	private String investPrice = "";
	private String dueDt = "";
	private String diffDt = "";
	private String feedback = "";
	private String progressCd = "";
	private String result = "";
	private String memo = "";
	private String used = "";
	private String netYn = "";
	private String sellBuy = "";
	private String cpnType = "";
	private String cpnTypeCd = "";
	private String cpnTypeCdNm = "";
	private String categoryBusiness = "";

	private String keyPmax = "";
	private String keyP = "";
	private String keyPnum = "";
	private String keyPsnb = "";
	private String keyPsnbNum = "";
	private String offerSnb = "";
	private String financing = "";
	private String management = "";
	private String mna = "";
	private String etc = "";
	private String share = "";
	private String resource = "";
	private String humanNet = "";
	private String audit = "";
	private String investInte = "";
	private String servey = "";
	private String snbFinancing = "";
	private String snbManagement = "";
	private String snbMna = "";
	private String snbEtc = "";
	private String snbShare = "";
	private String snbResource = "";
	private String snbHumanNet = "";
	private String snbAudit = "";
	private String snbInvestInte = "";
	private String snbServey = "";
	private String cdFinancing = "";
	private String cdManagement = "";
	private String cdMna = "";
	private String cdEtc = "";
	private String cdShare = "";
	private String cdResource = "";
	private String cdHumanNet = "";
	private String cdAudit = "";
	private String cdInvestInte = "";
	private String cdServey = "";
	private String lvCd = "";

	private String rcmdProposer = "";
	private String rcmdProposerNm = "";

	private String selectInfo = "";
	private String infoProvider = "";
	private String infoProviderNm = "";
	private String infoProviderCpnNm = "";
	private String supporter = "";
	private String supporterRatio = "";
	private String supporterText = "";
	private String supporterCd = "";
	private String supporterNm = "";

	private String kpcProcess = "";
	private String coworker = "";
	private String coworkerNm = "";
	private String url = "";

//공동진행 팝업
	private String staffSnb = "";
	private String rgStaffSnb;
	private String ratio = "";
	private String[] arrSnb;
	private String[] arrStaffSnb;
	private String[] arrRatio;
	private String[] arrComment;
	private String[] arrOfferSnb;
	private String[] arrSupSnb;
	private String[] arrPrice;
	private String[] arrMargin;
	private String[] arrSnb1st;
	private String[] arrSnb2nd;
	private String jointCnt = "";

//파일업로드
	private String rgSnb = "";


//파일업로드
	private String realNm = "";
	private String makeNm = "";
	private String fileCategory = "";
	private String path = "";
	private String reportYN = "";
	private String subCd = "";
	private String maxSnb = "";
	private String folderPath = "";


	private String sort_t = "";
	private String sort_joint = "";

	private String permission = "";
	private String total = "";

//sms
	private String smsSeq = "";
	private String smsTitle = "";
	private String smsType = "";
	private String smsToNum = "";
	private String smsFromNum = "";
	private String smsContent = "";
	private String smsReserTime = "";
	private String smsSendTime = "";
	private String smsEndTime = "";
	private String smsSendFlag = "";

	private String subMemo = "";
	private String mainSnb = "";
	private String repSnb = "";
	private String tmpId = "";
	private String major = "";


	private String limit = "";
	private String cusRealMoney = "";
	private String cusReSaleMoney = "";

	private String tmpNum1 = "";
	private String tmpNum2 = "";
	private String text = "";
	private String text0 = "";


// net
	private String snb1st = "";
	private String cstNm1st = "";
	private String cpnNm1st = "";
	private String position1st = "";
	private String cpnSnb1st = "";

	private String snb2nd = "";
	private String cstNm2nd = "";
	private String cpnNm2nd = "";
	private String position2nd = "";
	private String cpnSnb2nd = "";

	private String snb3rd = "";
	private String cstNm3rd = "";
	private String cpnNm3rd = "";
	private String position3rd = "";
	private String cpnSnb3rd = "";

	private String netCd = "";
	private String netCnt = "";
	private String cstSnb = "";


	private String importance5 = "";
	private String importance4 = "";
	private String importance3 = "";
	private String importance2 = "";
	private String importance1 = "";


	private String star = "";
	private String expirationDt = "";
	private String starSnb = "";
	private String rcmdSnb = "";


	private String callCnt = "";
	private String meetCnt = "";
	private String nightMeetCnt = "";
	private String dealCnt = "";
	private String dealSCnt = "";
	private String fileCnt = "";
	private String commentFileCnt = "";

	private String opinion = "";
	private String investOpinion = "";
	private String analysis = "";
	private String office = "";
	private String exploring = "";
	private String exploringCnt = "";
	private String viewTime = "";
	private String page = "";

	private String regPrice = "";
	private String minPrice = "";
	private String maxPrice = "";
	private String curPrice = "";
	private String maxDate = "";
	private String maxRatio = "";
	private String curRatio = "";

	private String search = "";

	private String matchCpn = "";
	private String matchCpnNm = "";

	private String modalFlag = "";
	private String modalNum = "";

	private String rtnVal = "";

	//모임
	private String[] arrMeetSnb;
	private String[] arrDelYn;
	private String meetSnb;
	private String delYn;


	private String source;
	private String target;
	private String type;


	private String cpnAddr;


	private String infoLevel;

	private String recommendNm;

	private String analVal;

	private String division;

	private String mezzL; 			//메자닌상장 권한여부 		->bs_user_profile
	private String mezzN; 			//메자닌비상장 권한여부	->bs_user_profile

	private String cpnStts;			//상장 비상장 회사 체크 위해 ... 'Q' or 'A' : 상장,  그외 : 비상장

	private String deptId;			//부서 id
	private String deptNm;			//부서 명
	private String deptMngr;		//부서장 사번
	private String memoDeptId;	//메모 대상자의 부서장 사번

	private String schePublicFlag;	//일정 비공개 여부

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
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
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
	 * @return the process
	 */
	public String getProcess() {
		return process;
	}
	/**
	 * @param process the process to set
	 */
	public void setProcess(String process) {
		this.process = process;
	}
	/**
	 * @param choiceYear the choiceYear to set
	 */
	public void setChoiceYear(String choiceYear) {
		this.choiceYear = choiceYear;
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
	 * @return the cstId
	 */
	public String getCstId() {
		return cstId;
	}
	/**
	 * @param cstId the cstId to set
	 */
	public void setCstId(String cstId) {
		this.cstId = cstId;
	}
	/**
	 * @return the choiceYear
	 */
	public String getChoiceYear() {
		return choiceYear;
	}
	/**
	 * @param choiceMonth the choiceMonth to set
	 */
	public void setChoiceMonth(String choiceMonth) {
		this.choiceMonth = choiceMonth;
	}
	/**
	 * @return the choiceMonth
	 */
	public String getChoiceMonth() {
		return choiceMonth;
	}
	/**
	 * @return the sttsCd
	 */
	public String getSttsCd() {
		return sttsCd;
	}
	/**
	 * @param sttsCd the sttsCd to set
	 */
	public void setSttsCd(String sttsCd) {
		this.sttsCd = sttsCd;
	}
	/**
	 * @return the comment
	 */
	public String getComment() {
		return comment;
	}
	/**
	 * @param comment the comment to set
	 */
	public void setComment(String comment) {
		this.comment = comment;
	}
	/**
	 * @return the memoSNb
	 */
	public String getMemoSNb() {
		return memoSNb;
	}
	/**
	 * @param memoSNb the memoSNb to set
	 */
	public void setMemoSNb(String memoSNb) {
		this.memoSNb = memoSNb;
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
	 * @return the memoSndSnb
	 */
	public String getMemoSndSnb() {
		return memoSndSnb;
	}
	/**
	 * @param memoSndSnb the memoSndSnb to set
	 */
	public void setMemoSndSnb(String memoSndSnb) {
		this.memoSndSnb = memoSndSnb;
	}
	/**
	 * @return the offerCd
	 */
	public String getOfferCd() {
		return offerCd;
	}
	/**
	 * @param offerCd the offerCd to set
	 */
	public void setOfferCd(String offerCd) {
		this.offerCd = offerCd;
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
	/**
	 * @return the progressCd
	 */
	public String getProgressCd() {
		return progressCd;
	}
	/**
	 * @param progressCd the progressCd to set
	 */
	public void setProgressCd(String progressCd) {
		this.progressCd = progressCd;
	}
	/**
	 * @return the result
	 */
	public String getResult() {
		return result;
	}
	/**
	 * @param result the result to set
	 */
	public void setResult(String result) {
		this.result = result;
	}
	/**
	 * @return the used
	 */
	public String getUsed() {
		return used;
	}
	/**
	 * @param used the used to set
	 */
	public void setUsed(String used) {
		this.used = used;
	}
	/**
	 * @return the day
	 */
	public String getDay() {
		return day;
	}
	/**
	 * @param day the day to set
	 */
	public void setDay(String day) {
		this.day = day;
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
	 * @return the memo
	 */
	public String getMemo() {
		return memo;
	}
	/**
	 * @param memo the memo to set
	 */
	public void setMemo(String memo) {
		this.memo = memo;
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
	 * @return the offerNm
	 */
	public String getOfferNm() {
		return offerNm;
	}
	/**
	 * @param offerNm the offerNm to set
	 */
	public void setOfferNm(String offerNm) {
		this.offerNm = offerNm;
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
	 * @return the categoryNm
	 */
	public String getCategoryNm() {
		return categoryNm;
	}
	/**
	 * @param categoryNm the categoryNm to set
	 */
	public void setCategoryNm(String categoryNm) {
		this.categoryNm = categoryNm;
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
	 * @return the offerId
	 */
	public String getOfferId() {
		return offerId;
	}
	/**
	 * @param offerId the offerId to set
	 */
	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}
	/**
	 * @return the processNm
	 */
	public String getProcessNm() {
		return processNm;
	}
	/**
	 * @param processNm the processNm to set
	 */
	public void setProcessNm(String processNm) {
		this.processNm = processNm;
	}
	/**
	 * @return the realNm
	 */
	public String getRealNm() {
		return realNm;
	}
	/**
	 * @param realNm the realNm to set
	 */
	public void setRealNm(String realNm) {
		this.realNm = realNm;
	}
	/**
	 * @return the makeNm
	 */
	public String getMakeNm() {
		return makeNm;
	}
	/**
	 * @param makeNm the makeNm to set
	 */
	public void setMakeNm(String makeNm) {
		this.makeNm = makeNm;
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
	 * @return the financing
	 */
	public String getFinancing() {
		return financing;
	}
	/**
	 * @param financing the financing to set
	 */
	public void setFinancing(String financing) {
		this.financing = financing;
	}
	/**
	 * @return the management
	 */
	public String getManagement() {
		return management;
	}
	/**
	 * @param management the management to set
	 */
	public void setManagement(String management) {
		this.management = management;
	}
	/**
	 * @return the mna
	 */
	public String getMna() {
		return mna;
	}
	/**
	 * @param mna the mna to set
	 */
	public void setMna(String mna) {
		this.mna = mna;
	}
	/**
	 * @return the etc
	 */
	public String getEtc() {
		return etc;
	}
	/**
	 * @param etc the etc to set
	 */
	public void setEtc(String etc) {
		this.etc = etc;
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
	 * @return the cstCpnId
	 */
	public String getCstCpnId() {
		return cstCpnId;
	}
	/**
	 * @param cstCpnId the cstCpnId to set
	 */
	public void setCstCpnId(String cstCpnId) {
		this.cstCpnId = cstCpnId;
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
	 * @return the kpcProcess
	 */
	public String getKpcProcess() {
		return kpcProcess;
	}
	/**
	 * @param kpcProcess the kpcProcess to set
	 */
	public void setKpcProcess(String kpcProcess) {
		this.kpcProcess = kpcProcess;
	}
	/**
	 * @return the coworker
	 */
	public String getCoworker() {
		return coworker;
	}
	/**
	 * @param coworker the coworker to set
	 */
	public void setCoworker(String coworker) {
		this.coworker = coworker;
	}
	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}
	/**
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * @return the middleOfferCd
	 */
	public String getMiddleOfferCd() {
		return middleOfferCd;
	}
	/**
	 * @param middleOfferCd the middleOfferCd to set
	 */
	public void setMiddleOfferCd(String middleOfferCd) {
		this.middleOfferCd = middleOfferCd;
	}
	/**
	 * @return the middleOfferNm
	 */
	public String getMiddleOfferNm() {
		return middleOfferNm;
	}
	/**
	 * @param middleOfferNm the middleOfferNm to set
	 */
	public void setMiddleOfferNm(String middleOfferNm) {
		this.middleOfferNm = middleOfferNm;
	}
	/**
	 * @return the oldcomment
	 */
	public String getOldcomment() {
		return oldcomment;
	}
	/**
	 * @param oldcomment the oldcomment to set
	 */
	public void setOldcomment(String oldcomment) {
		this.oldcomment = oldcomment;
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
	 * @return the infoProvider
	 */
	public String getInfoProvider() {
		return infoProvider;
	}
	/**
	 * @param infoProvider the infoProvider to set
	 */
	public void setInfoProvider(String infoProvider) {
		this.infoProvider = infoProvider;
	}
	/**
	 * @return the infoProviderNm
	 */
	public String getInfoProviderNm() {
		return infoProviderNm;
	}
	/**
	 * @param infoProviderNm the infoProviderNm to set
	 */
	public void setInfoProviderNm(String infoProviderNm) {
		this.infoProviderNm = infoProviderNm;
	}
	/**
	 * @return the infoProviderCpnNm
	 */
	public String getInfoProviderCpnNm() {
		return infoProviderCpnNm;
	}
	/**
	 * @param infoProviderCpnNm the infoProviderCpnNm to set
	 */
	public void setInfoProviderCpnNm(String infoProviderCpnNm) {
		this.infoProviderCpnNm = infoProviderCpnNm;
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
	 * @return the rcmdProposer
	 */
	public String getRcmdProposer() {
		return rcmdProposer;
	}
	/**
	 * @param rcmdProposer the rcmdProposer to set
	 */
	public void setRcmdProposer(String rcmdProposer) {
		this.rcmdProposer = rcmdProposer;
	}
	/**
	 * @return the rcmdProposerNm
	 */
	public String getRcmdProposerNm() {
		return rcmdProposerNm;
	}
	/**
	 * @param rcmdProposerNm the rcmdProposerNm to set
	 */
	public void setRcmdProposerNm(String rcmdProposerNm) {
		this.rcmdProposerNm = rcmdProposerNm;
	}
	/**
	 * @return the subMemo
	 */
	public String getSubMemo() {
		return subMemo;
	}
	/**
	 * @param subMemo the subMemo to set
	 */
	public void setSubMemo(String subMemo) {
		this.subMemo = subMemo;
	}
	/**
	 * @return the mainSnb
	 */
	public String getMainSnb() {
		return mainSnb;
	}
	/**
	 * @param mainSnb the mainSnb to set
	 */
	public void setMainSnb(String mainSnb) {
		this.mainSnb = mainSnb;
	}
	/**
	 * @return the repSnb
	 */
	public String getRepSnb() {
		return repSnb;
	}
	/**
	 * @param repSnb the repSnb to set
	 */
	public void setRepSnb(String repSnb) {
		this.repSnb = repSnb;
	}
	/**
	 * @return the tmpId
	 */
	public String getTmpId() {
		return tmpId;
	}
	/**
	 * @param tmpId the tmpId to set
	 */
	public void setTmpId(String tmpId) {
		this.tmpId = tmpId;
	}
	/**
	 * @return the limit
	 */
	public String getLimit() {
		return limit;
	}
	/**
	 * @param limit the limit to set
	 */
	public void setLimit(String limit) {
		this.limit = limit;
	}
	/**
	 * @return the entrust
	 */
	public String getEntrust() {
		return entrust;
	}
	/**
	 * @param entrust the entrust to set
	 */
	public void setEntrust(String entrust) {
		this.entrust = entrust;
	}
	/**
	 * @return the cpnCst
	 */
	public String getCpnCst() {
		return cpnCst;
	}
	/**
	 * @param cpnCst the cpnCst to set
	 */
	public void setCpnCst(String cpnCst) {
		this.cpnCst = cpnCst;
	}
	/**
	 * @return the selectInfo
	 */
	public String getSelectInfo() {
		return selectInfo;
	}
	/**
	 * @param selectInfo the selectInfo to set
	 */
	public void setSelectInfo(String selectInfo) {
		this.selectInfo = selectInfo;
	}
	/**
	 * @return the sorting
	 */
	public String getSorting() {
		return sorting;
	}
	/**
	 * @param sorting the sorting to set
	 */
	public void setSorting(String sorting) {
		this.sorting = sorting;
	}
	/**
	 * @return the cpnSnb
	 */
	public String getCpnSnb() {
		return cpnSnb;
	}
	/**
	 * @param cpnSnb the cpnSnb to set
	 */
	public void setCpnSnb(String cpnSnb) {
		this.cpnSnb = cpnSnb;
	}
	/**
	 * @return the prevCpnCst
	 */
	public String getPrevCpnCst() {
		return prevCpnCst;
	}
	/**
	 * @param prevCpnCst the prevCpnCst to set
	 */
	public void setPrevCpnCst(String prevCpnCst) {
		this.prevCpnCst = prevCpnCst;
	}
	/**
	 * @return the cusRealMoney
	 */
	public String getCusRealMoney() {
		return cusRealMoney;
	}
	/**
	 * @param cusRealMoney the cusRealMoney to set
	 */
	public void setCusRealMoney(String cusRealMoney) {
		this.cusRealMoney = cusRealMoney;
	}
	/**
	 * @return the supporter
	 */
	public String getSupporter() {
		return supporter;
	}
	/**
	 * @param supporter the supporter to set
	 */
	public void setSupporter(String supporter) {
		this.supporter = supporter;
	}
	/**
	 * @return the supporterNm
	 */
	public String getSupporterNm() {
		return supporterNm;
	}
	/**
	 * @param supporterNm the supporterNm to set
	 */
	public void setSupporterNm(String supporterNm) {
		this.supporterNm = supporterNm;
	}
	/**
	 * @return the supporterCd
	 */
	public String getSupporterCd() {
		return supporterCd;
	}
	/**
	 * @param supporterCd the supporterCd to set
	 */
	public void setSupporterCd(String supporterCd) {
		this.supporterCd = supporterCd;
	}
	/**
	 * @return the share
	 */
	public String getShare() {
		return share;
	}
	/**
	 * @param share the share to set
	 */
	public void setShare(String share) {
		this.share = share;
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
	 * @return the snbFinancing
	 */
	public String getSnbFinancing() {
		return snbFinancing;
	}
	/**
	 * @param snbFinancing the snbFinancing to set
	 */
	public void setSnbFinancing(String snbFinancing) {
		this.snbFinancing = snbFinancing;
	}
	/**
	 * @return the snbManagement
	 */
	public String getSnbManagement() {
		return snbManagement;
	}
	/**
	 * @param snbManagement the snbManagement to set
	 */
	public void setSnbManagement(String snbManagement) {
		this.snbManagement = snbManagement;
	}
	/**
	 * @return the snbMna
	 */
	public String getSnbMna() {
		return snbMna;
	}
	/**
	 * @param snbMna the snbMna to set
	 */
	public void setSnbMna(String snbMna) {
		this.snbMna = snbMna;
	}
	/**
	 * @return the snbEtc
	 */
	public String getSnbEtc() {
		return snbEtc;
	}
	/**
	 * @param snbEtc the snbEtc to set
	 */
	public void setSnbEtc(String snbEtc) {
		this.snbEtc = snbEtc;
	}
	/**
	 * @return the snbShare
	 */
	public String getSnbShare() {
		return snbShare;
	}
	/**
	 * @param snbShare the snbShare to set
	 */
	public void setSnbShare(String snbShare) {
		this.snbShare = snbShare;
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
	 * @return the tmpNum1
	 */
	public String getTmpNum1() {
		return tmpNum1;
	}
	/**
	 * @param tmpNum1 the tmpNum1 to set
	 */
	public void setTmpNum1(String tmpNum1) {
		this.tmpNum1 = tmpNum1;
	}
	/**
	 * @return the tmpNum2
	 */
	public String getTmpNum2() {
		return tmpNum2;
	}
	/**
	 * @param tmpNum2 the tmpNum2 to set
	 */
	public void setTmpNum2(String tmpNum2) {
		this.tmpNum2 = tmpNum2;
	}
	/**
	 * @return the cstCpnNm2
	 */
	public String getCstCpnNm2() {
		return cstCpnNm2;
	}
	/**
	 * @param cstCpnNm2 the cstCpnNm2 to set
	 */
	public void setCstCpnNm2(String cstCpnNm2) {
		this.cstCpnNm2 = cstCpnNm2;
	}
	/**
	 * @return the importance
	 */
	public String getImportance() {
		return importance;
	}
	/**
	 * @param importance the importance to set
	 */
	public void setImportance(String importance) {
		this.importance = importance;
	}
	/**
	 * @return the cstNm1st
	 */
	public String getCstNm1st() {
		return cstNm1st;
	}
	/**
	 * @param cstNm1st the cstNm1st to set
	 */
	public void setCstNm1st(String cstNm1st) {
		this.cstNm1st = cstNm1st;
	}
	/**
	 * @return the cpnNm1st
	 */
	public String getCpnNm1st() {
		return cpnNm1st;
	}
	/**
	 * @param cpnNm1st the cpnNm1st to set
	 */
	public void setCpnNm1st(String cpnNm1st) {
		this.cpnNm1st = cpnNm1st;
	}
	/**
	 * @return the position1st
	 */
	public String getPosition1st() {
		return position1st;
	}
	/**
	 * @param position1st the position1st to set
	 */
	public void setPosition1st(String position1st) {
		this.position1st = position1st;
	}
	/**
	 * @return the cstNm2nd
	 */
	public String getCstNm2nd() {
		return cstNm2nd;
	}
	/**
	 * @param cstNm2nd the cstNm2nd to set
	 */
	public void setCstNm2nd(String cstNm2nd) {
		this.cstNm2nd = cstNm2nd;
	}
	/**
	 * @return the cpnNm2nd
	 */
	public String getCpnNm2nd() {
		return cpnNm2nd;
	}
	/**
	 * @param cpnNm2nd the cpnNm2nd to set
	 */
	public void setCpnNm2nd(String cpnNm2nd) {
		this.cpnNm2nd = cpnNm2nd;
	}
	/**
	 * @return the position2nd
	 */
	public String getPosition2nd() {
		return position2nd;
	}
	/**
	 * @param position2nd the position2nd to set
	 */
	public void setPosition2nd(String position2nd) {
		this.position2nd = position2nd;
	}
	/**
	 * @return the cusReSaleMoney
	 */
	public String getCusReSaleMoney() {
		return cusReSaleMoney;
	}
	/**
	 * @param cusReSaleMoney the cusReSaleMoney to set
	 */
	public void setCusReSaleMoney(String cusReSaleMoney) {
		this.cusReSaleMoney = cusReSaleMoney;
	}
	/**
	 * @return the importance5
	 */
	public String getImportance5() {
		return importance5;
	}
	/**
	 * @param importance5 the importance5 to set
	 */
	public void setImportance5(String importance5) {
		this.importance5 = importance5;
	}
	/**
	 * @return the importance4
	 */
	public String getImportance4() {
		return importance4;
	}
	/**
	 * @param importance4 the importance4 to set
	 */
	public void setImportance4(String importance4) {
		this.importance4 = importance4;
	}
	/**
	 * @return the importance3
	 */
	public String getImportance3() {
		return importance3;
	}
	/**
	 * @param importance3 the importance3 to set
	 */
	public void setImportance3(String importance3) {
		this.importance3 = importance3;
	}
	/**
	 * @return the importance2
	 */
	public String getImportance2() {
		return importance2;
	}
	/**
	 * @param importance2 the importance2 to set
	 */
	public void setImportance2(String importance2) {
		this.importance2 = importance2;
	}
	/**
	 * @return the importance1
	 */
	public String getImportance1() {
		return importance1;
	}
	/**
	 * @param importance1 the importance1 to set
	 */
	public void setImportance1(String importance1) {
		this.importance1 = importance1;
	}
	/**
	 * @return the investPrice
	 */
	public String getInvestPrice() {
		return investPrice;
	}
	/**
	 * @param investPrice the investPrice to set
	 */
	public void setInvestPrice(String investPrice) {
		this.investPrice = investPrice;
	}
	/**
	 * @return the star
	 */
	public String getStar() {
		return star;
	}
	/**
	 * @param star the star to set
	 */
	public void setStar(String star) {
		this.star = star;
	}
	/**
	 * @return the starSnb
	 */
	public String getStarSnb() {
		return starSnb;
	}
	/**
	 * @param starSnb the starSnb to set
	 */
	public void setStarSnb(String starSnb) {
		this.starSnb = starSnb;
	}
	/**
	 * @return the rcmdSnb
	 */
	public String getRcmdSnb() {
		return rcmdSnb;
	}
	/**
	 * @param rcmdSnb the rcmdSnb to set
	 */
	public void setRcmdSnb(String rcmdSnb) {
		this.rcmdSnb = rcmdSnb;
	}
	/**
	 * @return the meetCnt
	 */
	public String getMeetCnt() {
		return meetCnt;
	}
	/**
	 * @param meetCnt the meetCnt to set
	 */
	public void setMeetCnt(String meetCnt) {
		this.meetCnt = meetCnt;
	}
	/**
	 * @return the dealCnt
	 */
	public String getDealCnt() {
		return dealCnt;
	}
	/**
	 * @param dealCnt the dealCnt to set
	 */
	public void setDealCnt(String dealCnt) {
		this.dealCnt = dealCnt;
	}
	/**
	 * @return the dealSCnt
	 */
	public String getDealSCnt() {
		return dealSCnt;
	}
	/**
	 * @param dealSCnt the dealSCnt to set
	 */
	public void setDealSCnt(String dealSCnt) {
		this.dealSCnt = dealSCnt;
	}
	/**
	 * @return the opinion
	 */
	public String getOpinion() {
		return opinion;
	}
	/**
	 * @param opinion the opinion to set
	 */
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	/**
	 * @return the analysis
	 */
	public String getAnalysis() {
		return analysis;
	}
	/**
	 * @param analysis the analysis to set
	 */
	public void setAnalysis(String analysis) {
		this.analysis = analysis;
	}
	/**
	 * @return the investOpinion
	 */
	public String getInvestOpinion() {
		return investOpinion;
	}
	/**
	 * @param investOpinion the investOpinion to set
	 */
	public void setInvestOpinion(String investOpinion) {
		this.investOpinion = investOpinion;
	}
	/**
	 * @return the supporterText
	 */
	public String getSupporterText() {
		return supporterText;
	}
	/**
	 * @param supporterText the supporterText to set
	 */
	public void setSupporterText(String supporterText) {
		this.supporterText = supporterText;
	}
	/**
	 * @return the coworkerNm
	 */
	public String getCoworkerNm() {
		return coworkerNm;
	}
	/**
	 * @param coworkerNm the coworkerNm to set
	 */
	public void setCoworkerNm(String coworkerNm) {
		this.coworkerNm = coworkerNm;
	}
	/**
	 * @return the callCnt
	 */
	public String getCallCnt() {
		return callCnt;
	}
	/**
	 * @param callCnt the callCnt to set
	 */
	public void setCallCnt(String callCnt) {
		this.callCnt = callCnt;
	}
	/**
	 * @return the nightMeetCnt
	 */
	public String getNightMeetCnt() {
		return nightMeetCnt;
	}
	/**
	 * @param nightMeetCnt the nightMeetCnt to set
	 */
	public void setNightMeetCnt(String nightMeetCnt) {
		this.nightMeetCnt = nightMeetCnt;
	}
	/**
	 * @return the supporterRatio
	 */
	public String getSupporterRatio() {
		return supporterRatio;
	}
	/**
	 * @param supporterRatio the supporterRatio to set
	 */
	public void setSupporterRatio(String supporterRatio) {
		this.supporterRatio = supporterRatio;
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
	/**
	 * @return the usrId
	 */
	public String getUsrId() {
		return usrId;
	}
	/**
	 * @param usrId the usrId to set
	 */
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	/**
	 * @return the priv
	 */
	public String getPriv() {
		return priv;
	}
	/**
	 * @param priv the priv to set
	 */
	public void setPriv(String priv) {
		this.priv = priv;
	}
	/**
	 * @return the cmntStaffs
	 */
	public String getCmntStaffs() {
		return cmntStaffs;
	}
	/**
	 * @param cmntStaffs the cmntStaffs to set
	 */
	public void setCmntStaffs(String cmntStaffs) {
		this.cmntStaffs = cmntStaffs;
	}
	/**
	 * @return the memo4db
	 */
	public String getMemo4db() {
		return memo4db;
	}
	/**
	 * @param memo4db the memo4db to set
	 */
	public void setMemo4db(String memo4db) {
		this.memo4db = memo4db;
	}
	/**
	 * @return the office
	 */
	public String getOffice() {
		return office;
	}
	/**
	 * @param office the office to set
	 */
	public void setOffice(String office) {
		this.office = office;
	}
	/**
	 * @return the bsnsRecPrivate
	 */
	public String getBsnsRecPrivate() {
		return bsnsRecPrivate;
	}
	/**
	 * @param bsnsRecPrivate the bsnsRecPrivate to set
	 */
	public void setBsnsRecPrivate(String bsnsRecPrivate) {
		this.bsnsRecPrivate = bsnsRecPrivate;
	}
	/**
	 * @return the staffSnb
	 */
	public String getStaffSnb() {
		return staffSnb;
	}
	/**
	 * @param staffSNb the staffSNb to set
	 */
	public void setStaffSnb(String staffSnb) {
		this.staffSnb = staffSnb;
	}

	public String getRgStaffSnb() {
		return rgStaffSnb;
	}
	public void setRgStaffSnb(String rgStaffSnb) {
		this.rgStaffSnb = rgStaffSnb;
	}
	/**
	 * @return the ratio
	 */
	public String getRatio() {
		return ratio;
	}
	/**
	 * @param ratio the ratio to set
	 */
	public void setRatio(String ratio) {
		this.ratio = ratio;
	}
	/**
	 * @return the arrSnb
	 */
	public String[] getArrSnb() {
		return arrSnb;
	}
	/**
	 * @param arrSnb the arrSnb to set
	 */
	public void setArrSnb(String[] arrSnb) {
		this.arrSnb = arrSnb;
	}
	/**
	 * @return the arrStaffSnb
	 */
	public String[] getArrStaffSnb() {
		return arrStaffSnb;
	}
	/**
	 * @param arrStaffSnb the arrStaffSnb to set
	 */
	public void setArrStaffSnb(String[] arrStaffSnb) {
		this.arrStaffSnb = arrStaffSnb;
	}
	/**
	 * @return the arrRatio
	 */
	public String[] getArrRatio() {
		return arrRatio;
	}
	/**
	 * @param arrRatio the arrRatio to set
	 */
	public void setArrRatio(String[] arrRatio) {
		this.arrRatio = arrRatio;
	}
	/**
	 * @return the arrComment
	 */
	public String[] getArrComment() {
		return arrComment;
	}
	/**
	 * @param arrComment the arrComment to set
	 */
	public void setArrComment(String[] arrComment) {
		this.arrComment = arrComment;
	}
	/**
	 * @return the jointCnt
	 */
	public String getJointCnt() {
		return jointCnt;
	}
	/**
	 * @param jointCnt the jointCnt to set
	 */
	public void setJointCnt(String jointCnt) {
		this.jointCnt = jointCnt;
	}
	/**
	 * @return the rgSnb
	 */
	public String getRgSnb() {
		return rgSnb;
	}
	/**
	 * @param rgSnb the rgSnb to set
	 */
	public void setRgSnb(String rgSnb) {
		this.rgSnb = rgSnb;
	}
	/**
	 * @return the text
	 */
	public String getText() {
		return text;
	}
	/**
	 * @param text the text to set
	 */
	public void setText(String text) {
		this.text = text;
	}
	/**
	 * @return the team
	 */
	public String getTeam() {
		return team;
	}
	/**
	 * @param team the team to set
	 */
	public void setTeam(String team) {
		this.team = team;
	}
	/**
	 * @return the exploring
	 */
	public String getExploring() {
		return exploring;
	}
	/**
	 * @param exploring the exploring to set
	 */
	public void setExploring(String exploring) {
		this.exploring = exploring;
	}
	/**
	 * @return the netYn
	 */
	public String getNetYn() {
		return netYn;
	}
	/**
	 * @param netYn the netYn to set
	 */
	public void setNetYn(String netYn) {
		this.netYn = netYn;
	}
	/**
	 * @return the choiceDay
	 */
	public String getChoiceDay() {
		return choiceDay;
	}
	/**
	 * @param choiceDay the choiceDay to set
	 */
	public void setChoiceDay(String choiceDay) {
		this.choiceDay = choiceDay;
	}
	/**
	 * @return the choiceDayS
	 */
	public String getChoiceDayS() {
		return choiceDayS;
	}
	/**
	 * @param choiceDayS the choiceDayS to set
	 */
	public void setChoiceDayS(String choiceDayS) {
		this.choiceDayS = choiceDayS;
	}
	/**
	 * @return the resource
	 */
	public String getResource() {
		return resource;
	}
	/**
	 * @param resource the resource to set
	 */
	public void setResource(String resource) {
		this.resource = resource;
	}
	/**
	 * @return the humanNet
	 */
	public String getHumanNet() {
		return humanNet;
	}
	/**
	 * @param humanNet the humanNet to set
	 */
	public void setHumanNet(String humanNet) {
		this.humanNet = humanNet;
	}
	/**
	 * @return the snbResource
	 */
	public String getSnbResource() {
		return snbResource;
	}
	/**
	 * @param snbResource the snbResource to set
	 */
	public void setSnbResource(String snbResource) {
		this.snbResource = snbResource;
	}
	/**
	 * @return the snbHumanNet
	 */
	public String getSnbHumanNet() {
		return snbHumanNet;
	}
	/**
	 * @param snbHumanNet the snbHumanNet to set
	 */
	public void setSnbHumanNet(String snbHumanNet) {
		this.snbHumanNet = snbHumanNet;
	}

	/**
	 * @return the viewTime
	 */
	public String getViewTime() {
		return viewTime;
	}
	/**
	 * @param viewTime the viewTime to set
	 */
	public void setViewTime(String viewTime) {
		this.viewTime = viewTime;
	}
	/**
	 * @return the audit
	 */
	public String getAudit() {
		return audit;
	}
	/**
	 * @param audit the audit to set
	 */
	public void setAudit(String audit) {
		this.audit = audit;
	}
	/**
	 * @return the investInte
	 */
	public String getInvestInte() {
		return investInte;
	}
	/**
	 * @param investInte the investInte to set
	 */
	public void setInvestInte(String investInte) {
		this.investInte = investInte;
	}
	/**
	 * @return the snbAudit
	 */
	public String getSnbAudit() {
		return snbAudit;
	}
	/**
	 * @param snbAudit the snbAudit to set
	 */
	public void setSnbAudit(String snbAudit) {
		this.snbAudit = snbAudit;
	}
	/**
	 * @return the snbInvestInte
	 */
	public String getSnbInvestInte() {
		return snbInvestInte;
	}
	/**
	 * @param snbInvestInte the snbInvestInte to set
	 */
	public void setSnbInvestInte(String snbInvestInte) {
		this.snbInvestInte = snbInvestInte;
	}

	/**
	 * @return the exploringCnt
	 */
	public String getExploringCnt() {
		return exploringCnt;
	}
	/**
	 * @param exploringCnt the exploringCnt to set
	 */
	public void setExploringCnt(String exploringCnt) {
		this.exploringCnt = exploringCnt;
	}
	/**
	 * @return the cstNm3rd
	 */
	public String getCstNm3rd() {
		return cstNm3rd;
	}
	/**
	 * @param cstNm3rd the cstNm3rd to set
	 */
	public void setCstNm3rd(String cstNm3rd) {
		this.cstNm3rd = cstNm3rd;
	}
	/**
	 * @return the cpnNm3rd
	 */
	public String getCpnNm3rd() {
		return cpnNm3rd;
	}
	/**
	 * @param cpnNm3rd the cpnNm3rd to set
	 */
	public void setCpnNm3rd(String cpnNm3rd) {
		this.cpnNm3rd = cpnNm3rd;
	}
	/**
	 * @return the position3rd
	 */
	public String getPosition3rd() {
		return position3rd;
	}
	/**
	 * @param position3rd the position3rd to set
	 */
	public void setPosition3rd(String position3rd) {
		this.position3rd = position3rd;
	}
	/**
	 * @return the snb1st
	 */
	public String getSnb1st() {
		return snb1st;
	}
	/**
	 * @param snb1st the snb1st to set
	 */
	public void setSnb1st(String snb1st) {
		this.snb1st = snb1st;
	}
	/**
	 * @return the snb2nd
	 */
	public String getSnb2nd() {
		return snb2nd;
	}
	/**
	 * @param snb2nd the snb2nd to set
	 */
	public void setSnb2nd(String snb2nd) {
		this.snb2nd = snb2nd;
	}
	/**
	 * @return the snb3rd
	 */
	public String getSnb3rd() {
		return snb3rd;
	}
	/**
	 * @param snb3rd the snb3rd to set
	 */
	public void setSnb3rd(String snb3rd) {
		this.snb3rd = snb3rd;
	}
	/**
	 * @return the text0
	 */
	public String getText0() {
		return text0;
	}
	/**
	 * @param text0 the text0 to set
	 */
	public void setText0(String text0) {
		this.text0 = text0;
	}
	/**
	 * @return the page
	 */
	public String getPage() {
		return page;
	}
	/**
	 * @param page the page to set
	 */
	public void setPage(String page) {
		this.page = page;
	}
	/**
	 * @return the regPrice
	 */
	public String getRegPrice() {
		return regPrice;
	}
	/**
	 * @param regPrice the regPrice to set
	 */
	public void setRegPrice(String regPrice) {
		this.regPrice = regPrice;
	}
	/**
	 * @return the maxPrice
	 */
	public String getMaxPrice() {
		return maxPrice;
	}
	/**
	 * @param maxPrice the maxPrice to set
	 */
	public void setMaxPrice(String maxPrice) {
		this.maxPrice = maxPrice;
	}
	/**
	 * @return the curPrice
	 */
	public String getCurPrice() {
		return curPrice;
	}
	/**
	 * @param curPrice the curPrice to set
	 */
	public void setCurPrice(String curPrice) {
		this.curPrice = curPrice;
	}
	/**
	 * @return the maxDate
	 */
	public String getMaxDate() {
		return maxDate;
	}
	/**
	 * @param maxDate the maxDate to set
	 */
	public void setMaxDate(String maxDate) {
		this.maxDate = maxDate;
	}
	/**
	 * @return the maxRatio
	 */
	public String getMaxRatio() {
		return maxRatio;
	}
	/**
	 * @param maxRatio the maxRatio to set
	 */
	public void setMaxRatio(String maxRatio) {
		this.maxRatio = maxRatio;
	}
	/**
	 * @return the curRatio
	 */
	public String getCurRatio() {
		return curRatio;
	}
	/**
	 * @param curRatio the curRatio to set
	 */
	public void setCurRatio(String curRatio) {
		this.curRatio = curRatio;
	}
	/**
	 * @return the search
	 */
	public String getSearch() {
		return search;
	}
	/**
	 * @param search the search to set
	 */
	public void setSearch(String search) {
		this.search = search;
	}
	/**
	 * @return the sort_joint
	 */
	public String getSort_joint() {
		return sort_joint;
	}
	/**
	 * @param sort_joint the sort_joint to set
	 */
	public void setSort_joint(String sort_joint) {
		this.sort_joint = sort_joint;
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
	 * @return the maxSnb
	 */
	public String getMaxSnb() {
		return maxSnb;
	}
	/**
	 * @param maxSnb the maxSnb to set
	 */
	public void setMaxSnb(String maxSnb) {
		this.maxSnb = maxSnb;
	}
	/**
	 * @return the folderPath
	 */
	public String getFolderPath() {
		return folderPath;
	}
	/**
	 * @param folderPath the folderPath to set
	 */
	public void setFolderPath(String folderPath) {
		this.folderPath = folderPath;
	}
	/**
	 * @return the fileCnt
	 */
	public String getFileCnt() {
		return fileCnt;
	}
	/**
	 * @param fileCnt the fileCnt to set
	 */
	public void setFileCnt(String fileCnt) {
		this.fileCnt = fileCnt;
	}
	/**
	 * @return the netCd
	 */
	public String getNetCd() {
		return netCd;
	}
	/**
	 * @param netCd the netCd to set
	 */
	public void setNetCd(String netCd) {
		this.netCd = netCd;
	}
	/**
	 * @return the netCnt
	 */
	public String getNetCnt() {
		return netCnt;
	}
	/**
	 * @param netCnt the netCnt to set
	 */
	public void setNetCnt(String netCnt) {
		this.netCnt = netCnt;
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
	 * @return the choiceYearS
	 */
	public String getChoiceYearS() {
		return choiceYearS;
	}
	/**
	 * @param choiceYearS the choiceYearS to set
	 */
	public void setChoiceYearS(String choiceYearS) {
		this.choiceYearS = choiceYearS;
	}
	/**
	 * @return the mainYn
	 */
	public String getMainYn() {
		return mainYn;
	}
	/**
	 * @param mainYn the mainYn to set
	 */
	public void setMainYn(String mainYn) {
		this.mainYn = mainYn;
	}
	/**
	 * @return the usrNm
	 */
	public String getUsrNm() {
		return usrNm;
	}
	/**
	 * @param usrNm the usrNm to set
	 */
	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm;
	}
	/**
	 * @return the commentFileCnt
	 */
	public String getCommentFileCnt() {
		return commentFileCnt;
	}
	/**
	 * @param commentFileCnt the commentFileCnt to set
	 */
	public void setCommentFileCnt(String commentFileCnt) {
		this.commentFileCnt = commentFileCnt;
	}
	/**
	 * @return the diffDt
	 */
	public String getDiffDt() {
		return diffDt;
	}
	/**
	 * @param diffDt the diffDt to set
	 */
	public void setDiffDt(String diffDt) {
		this.diffDt = diffDt;
	}
	/**
	 * @return the minPrice
	 */
	public String getMinPrice() {
		return minPrice;
	}
	/**
	 * @param minPrice the minPrice to set
	 */
	public void setMinPrice(String minPrice) {
		this.minPrice = minPrice;
	}
	/**
	 * @return the sellBuy
	 */
	public String getSellBuy() {
		return sellBuy;
	}
	/**
	 * @param sellBuy the sellBuy to set
	 */
	public void setSellBuy(String sellBuy) {
		this.sellBuy = sellBuy;
	}
	/**
	 * @return the cpnType
	 */
	public String getCpnType() {
		return cpnType;
	}
	/**
	 * @param cpnType the cpnType to set
	 */
	public void setCpnType(String cpnType) {
		this.cpnType = cpnType;
	}
	/**
	 * @return the categoryBusiness
	 */
	public String getCategoryBusiness() {
		return categoryBusiness;
	}
	/**
	 * @param categoryBusiness the categoryBusiness to set
	 */
	public void setCategoryBusiness(String categoryBusiness) {
		this.categoryBusiness = categoryBusiness;
	}
	/**
	 * @return the matchCpn
	 */
	public String getMatchCpn() {
		return matchCpn;
	}
	/**
	 * @param matchCpn the matchCpn to set
	 */
	public void setMatchCpn(String matchCpn) {
		this.matchCpn = matchCpn;
	}
	/**
	 * @return the matchCpnNm
	 */
	public String getMatchCpnNm() {
		return matchCpnNm;
	}
	/**
	 * @param matchCpnNm the matchCpnNm to set
	 */
	public void setMatchCpnNm(String matchCpnNm) {
		this.matchCpnNm = matchCpnNm;
	}
	/**
	 * @return the cpnTypeCd
	 */
	public String getCpnTypeCd() {
		return cpnTypeCd;
	}
	/**
	 * @param cpnTypeCd the cpnTypeCd to set
	 */
	public void setCpnTypeCd(String cpnTypeCd) {
		this.cpnTypeCd = cpnTypeCd;
	}
	/**
	 * @return the cpnTypeCdNm
	 */
	public String getCpnTypeCdNm() {
		return cpnTypeCdNm;
	}
	/**
	 * @param cpnTypeCdNm the cpnTypeCdNm to set
	 */
	public void setCpnTypeCdNm(String cpnTypeCdNm) {
		this.cpnTypeCdNm = cpnTypeCdNm;
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
	 * @return the modalFlag
	 */
	public String getModalFlag() {
		return modalFlag;
	}
	/**
	 * @param modalFlag the modalFlag to set
	 */
	public void setModalFlag(String modalFlag) {
		this.modalFlag = modalFlag;
	}
	/**
	 * @return the modalNum
	 */
	public String getModalNum() {
		return modalNum;
	}
	/**
	 * @param modalNum the modalNum to set
	 */
	public void setModalNum(String modalNum) {
		this.modalNum = modalNum;
	}
	/**
	 * @return the aCpnId
	 */
	public String getaCpnId() {
		return aCpnId;
	}
	/**
	 * @param aCpnId the aCpnId to set
	 */
	public void setaCpnId(String aCpnId) {
		this.aCpnId = aCpnId;
	}
	/**
	 * @return the servey
	 */
	public String getServey() {
		return servey;
	}
	/**
	 * @param servey the servey to set
	 */
	public void setServey(String servey) {
		this.servey = servey;
	}
	/**
	 * @return the snbServey
	 */
	public String getSnbServey() {
		return snbServey;
	}
	/**
	 * @param snbServey the snbServey to set
	 */
	public void setSnbServey(String snbServey) {
		this.snbServey = snbServey;
	}

	/**
	 * @return the arrMeetSnb
	 */
	public String[] getArrMeetSnb() {
		return arrMeetSnb;
	}
	/**
	 * @param arrMeetSnb the arrMeetSnb to set
	 */
	public void setArrMeetSnb(String[] arrMeetSnb) {
		this.arrMeetSnb = arrMeetSnb;
	}
	/**
	 * @return the arrDelYn
	 */
	public String[] getArrDelYn() {
		return arrDelYn;
	}
	/**
	 * @param arrDelYn the arrDelYn to set
	 */
	public void setArrDelYn(String[] arrDelYn) {
		this.arrDelYn = arrDelYn;
	}
	/**
	 * @return the rtnVal
	 */
	public String getRtnVal() {
		return rtnVal;
	}
	/**
	 * @param rtnVal the rtnVal to set
	 */
	public void setRtnVal(String rtnVal) {
		this.rtnVal = rtnVal;
	}
	/**
	 * @return the meetSnb
	 */
	public String getMeetSnb() {
		return meetSnb;
	}
	/**
	 * @param meetSnb the meetSnb to set
	 */
	public void setMeetSnb(String meetSnb) {
		this.meetSnb = meetSnb;
	}
	/**
	 * @return the delYn
	 */
	public String getDelYn() {
		return delYn;
	}
	/**
	 * @param delYn the delYn to set
	 */
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	/**
	 * @return the major
	 */
	public String getMajor() {
		return major;
	}
	/**
	 * @param major the major to set
	 */
	public void setMajor(String major) {
		this.major = major;
	}
	/**
	 * @return the focus
	 */
	public String getFocus() {
		return focus;
	}
	/**
	 * @param focus the focus to set
	 */
	public void setFocus(String focus) {
		this.focus = focus;
	}
	/**
	 * @return the keyP
	 */
	public String getKeyP() {
		return keyP;
	}
	/**
	 * @param keyP the keyP to set
	 */
	public void setKeyP(String keyP) {
		this.keyP = keyP;
	}
	/**
	 * @return the keyPnum
	 */
	public String getKeyPnum() {
		return keyPnum;
	}
	/**
	 * @param keyPnum the keyPnum to set
	 */
	public void setKeyPnum(String keyPnum) {
		this.keyPnum = keyPnum;
	}
	/**
	 * @return the keyPsnb
	 */
	public String getKeyPsnb() {
		return keyPsnb;
	}
	/**
	 * @param keyPsnb the keyPsnb to set
	 */
	public void setKeyPsnb(String keyPsnb) {
		this.keyPsnb = keyPsnb;
	}
	/**
	 * @return the keyPsnbNum
	 */
	public String getKeyPsnbNum() {
		return keyPsnbNum;
	}
	/**
	 * @param keyPsnbNum the keyPsnbNum to set
	 */
	public void setKeyPsnbNum(String keyPsnbNum) {
		this.keyPsnbNum = keyPsnbNum;
	}
	/**
	 * @return the keyPmax
	 */
	public String getKeyPmax() {
		return keyPmax;
	}
	/**
	 * @param keyPmax the keyPmax to set
	 */
	public void setKeyPmax(String keyPmax) {
		this.keyPmax = keyPmax;
	}
	/**
	 * @return the tab
	 */
	public String getTab() {
		return tab;
	}
	/**
	 * @param tab the tab to set
	 */
	public void setTab(String tab) {
		this.tab = tab;
	}
	/**
	 * @return the arrSupSnb
	 */
	public String[] getArrSupSnb() {
		return arrSupSnb;
	}
	/**
	 * @param arrSupSnb the arrSupSnb to set
	 */
	public void setArrSupSnb(String[] arrSupSnb) {
		this.arrSupSnb = arrSupSnb;
	}
	/**
	 * @return the arrPrice
	 */
	public String[] getArrPrice() {
		return arrPrice;
	}
	/**
	 * @param arrPrice the arrPrice to set
	 */
	public void setArrPrice(String[] arrPrice) {
		this.arrPrice = arrPrice;
	}
	/**
	 * @return the arrMargin
	 */
	public String[] getArrMargin() {
		return arrMargin;
	}
	/**
	 * @param arrMargin the arrMargin to set
	 */
	public void setArrMargin(String[] arrMargin) {
		this.arrMargin = arrMargin;
	}
	/**
	 * @return the arrSnb1st
	 */
	public String[] getArrSnb1st() {
		return arrSnb1st;
	}
	/**
	 * @param arrSnb1st the arrSnb1st to set
	 */
	public void setArrSnb1st(String[] arrSnb1st) {
		this.arrSnb1st = arrSnb1st;
	}
	/**
	 * @return the arrSnb2nd
	 */
	public String[] getArrSnb2nd() {
		return arrSnb2nd;
	}
	/**
	 * @param arrSnb2nd the arrSnb2nd to set
	 */
	public void setArrSnb2nd(String[] arrSnb2nd) {
		this.arrSnb2nd = arrSnb2nd;
	}
	/**
	 * @return the arrOfferSnb
	 */
	public String[] getArrOfferSnb() {
		return arrOfferSnb;
	}
	/**
	 * @param arrOfferSnb the arrOfferSnb to set
	 */
	public void setArrOfferSnb(String[] arrOfferSnb) {
		this.arrOfferSnb = arrOfferSnb;
	}
	/**
	 * @return the source
	 */
	public String getSource() {
		return source;
	}
	/**
	 * @param source the source to set
	 */
	public void setSource(String source) {
		this.source = source;
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
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return the cateBsns
	 */
	public String getCateBsns() {
		return cateBsns;
	}
	/**
	 * @param cateBsns the cateBsns to set
	 */
	public void setCateBsns(String cateBsns) {
		this.cateBsns = cateBsns;
	}
	/**
	 * @return the cstAcpnId
	 */
	public String getCstAcpnId() {
		return cstAcpnId;
	}
	/**
	 * @param cstAcpnId the cstAcpnId to set
	 */
	public void setCstAcpnId(String cstAcpnId) {
		this.cstAcpnId = cstAcpnId;
	}
	/**
	 * @return the cpnSnb1st
	 */
	public String getCpnSnb1st() {
		return cpnSnb1st;
	}
	/**
	 * @param cpnSnb1st the cpnSnb1st to set
	 */
	public void setCpnSnb1st(String cpnSnb1st) {
		this.cpnSnb1st = cpnSnb1st;
	}
	/**
	 * @return the cpnSnb2nd
	 */
	public String getCpnSnb2nd() {
		return cpnSnb2nd;
	}
	/**
	 * @param cpnSnb2nd the cpnSnb2nd to set
	 */
	public void setCpnSnb2nd(String cpnSnb2nd) {
		this.cpnSnb2nd = cpnSnb2nd;
	}
	/**
	 * @return the cpnSnb3rd
	 */
	public String getCpnSnb3rd() {
		return cpnSnb3rd;
	}
	/**
	 * @param cpnSnb3rd the cpnSnb3rd to set
	 */
	public void setCpnSnb3rd(String cpnSnb3rd) {
		this.cpnSnb3rd = cpnSnb3rd;
	}
	public String getExpirationDt() {
		return expirationDt;
	}
	public void setExpirationDt(String expirationDt) {
		this.expirationDt = expirationDt;
	}
	public String getListed() {
		return listed;
	}
	public void setListed(String listed) {
		this.listed = listed;
	}
	public String getIsEtc() {
		return isEtc;
	}
	public void setIsEtc(String isEtc) {
		this.isEtc = isEtc;
	}

	public String getCusId() {
		return cusId;
	}
	public void setCusId(String cusId) {
		this.cusId = cusId;
	}
	public String getCpnAddr() {
		return cpnAddr;
	}
	public void setCpnAddr(String cpnAddr) {
		this.cpnAddr = cpnAddr;
	}
	public String getDayF() {
		return dayF;
	}
	public void setDayF(String dayF) {
		this.dayF = dayF;
	}
	public String getInfoLevel() {
		return infoLevel;
	}
	public void setInfoLevel(String infoLevel) {
		this.infoLevel = infoLevel;
	}
	public String getRecommendNm() {
		return recommendNm;
	}
	public void setRecommendNm(String recommendNm) {
		this.recommendNm = recommendNm;
	}
	public String getAnalVal() {
		return analVal;
	}
	public void setAnalVal(String analVal) {
		this.analVal = analVal;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getMezzL() {
		return mezzL;
	}
	public void setMezzL(String mezzL) {
		this.mezzL = mezzL;
	}
	public String getMezzN() {
		return mezzN;
	}
	public void setMezzN(String mezzN) {
		this.mezzN = mezzN;
	}
	public String getCpnStts() {
		return cpnStts;
	}
	public void setCpnStts(String cpnStts) {
		this.cpnStts = cpnStts;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptMngr() {
		return deptMngr;
	}
	public void setDeptMngr(String deptMngr) {
		this.deptMngr = deptMngr;
	}
	public String getMemoDeptId() {
		return memoDeptId;
	}
	public void setMemoDeptId(String memoDeptId) {
		this.memoDeptId = memoDeptId;
	}
	public String getSchePublicFlag() {
		return schePublicFlag;
	}
	public void setSchePublicFlag(String schePublicFlag) {
		this.schePublicFlag = schePublicFlag;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	public String getCdFinancing() {
		return cdFinancing;
	}
	public void setCdFinancing(String cdFinancing) {
		this.cdFinancing = cdFinancing;
	}
	public String getCdManagement() {
		return cdManagement;
	}
	public void setCdManagement(String cdManagement) {
		this.cdManagement = cdManagement;
	}
	public String getCdMna() {
		return cdMna;
	}
	public void setCdMna(String cdMna) {
		this.cdMna = cdMna;
	}
	public String getCdEtc() {
		return cdEtc;
	}
	public void setCdEtc(String cdEtc) {
		this.cdEtc = cdEtc;
	}
	public String getCdShare() {
		return cdShare;
	}
	public void setCdShare(String cdShare) {
		this.cdShare = cdShare;
	}
	public String getCdResource() {
		return cdResource;
	}
	public void setCdResource(String cdResource) {
		this.cdResource = cdResource;
	}
	public String getCdHumanNet() {
		return cdHumanNet;
	}
	public void setCdHumanNet(String cdHumanNet) {
		this.cdHumanNet = cdHumanNet;
	}
	public String getCdAudit() {
		return cdAudit;
	}
	public void setCdAudit(String cdAudit) {
		this.cdAudit = cdAudit;
	}
	public String getCdInvestInte() {
		return cdInvestInte;
	}
	public void setCdInvestInte(String cdInvestInte) {
		this.cdInvestInte = cdInvestInte;
	}
	public String getCdServey() {
		return cdServey;
	}
	public void setCdServey(String cdServey) {
		this.cdServey = cdServey;
	}
	public String getCcdOffCd() {
		return ccdOffCd;
	}
	public String getCcdPrgressCd() {
		return ccdPrgressCd;
	}
	public String getCcdCateCd() {
		return ccdCateCd;
	}
	public String getCcdMidOffCd() {
		return ccdMidOffCd;
	}
	public String getCcdFamily() {
		return ccdFamily;
	}
	public String getCcdNWstaff() {
		return ccdNWstaff;
	}
	public String getCcdKeyPoint() {
		return ccdKeyPoint;
	}
	public String getCcdMainMenu() {
		return ccdMainMenu;
	}
	public String getSmsSeq() {
		return smsSeq;
	}
	public void setSmsSeq(String smsSeq) {
		this.smsSeq = smsSeq;
	}
	public String getSmsTitle() {
		return smsTitle;
	}
	public void setSmsTitle(String smsTitle) {
		this.smsTitle = smsTitle;
	}
	public String getSmsType() {
		return smsType;
	}
	public void setSmsType(String smsType) {
		this.smsType = smsType;
	}
	public String getSmsToNum() {
		return smsToNum;
	}
	public void setSmsToNum(String smsToNum) {
		this.smsToNum = smsToNum;
	}
	public String getSmsFromNum() {
		return smsFromNum;
	}
	public void setSmsFromNum(String smsFromNum) {
		this.smsFromNum = smsFromNum;
	}
	public String getSmsContent() {
		return smsContent;
	}
	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}
	public String getSmsReserTime() {
		return smsReserTime;
	}
	public void setSmsReserTime(String smsReserTime) {
		this.smsReserTime = smsReserTime;
	}
	public String getSmsSendTime() {
		return smsSendTime;
	}
	public void setSmsSendTime(String smsSendTime) {
		this.smsSendTime = smsSendTime;
	}
	public String getSmsEndTime() {
		return smsEndTime;
	}
	public void setSmsEndTime(String smsEndTime) {
		this.smsEndTime = smsEndTime;
	}
	public String getSmsSendFlag() {
		return smsSendFlag;
	}
	public void setSmsSendFlag(String smsSendFlag) {
		this.smsSendFlag = smsSendFlag;
	}
}