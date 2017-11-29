package com.baroservice.ws;

public class BaroService_CARDSoapProxy implements com.baroservice.ws.BaroService_CARDSoap {
  private String _endpoint = null;
  private com.baroservice.ws.BaroService_CARDSoap baroService_CARDSoap = null;
  
  public BaroService_CARDSoapProxy() {
    _initBaroService_CARDSoapProxy();
  }
  
  public BaroService_CARDSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initBaroService_CARDSoapProxy();
  }
  
  private void _initBaroService_CARDSoapProxy() {
    try {
      baroService_CARDSoap = (new com.baroservice.ws.BaroService_CARDLocator()).getBaroService_CARDSoap();
      if (baroService_CARDSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)baroService_CARDSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)baroService_CARDSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (baroService_CARDSoap != null)
      ((javax.xml.rpc.Stub)baroService_CARDSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.baroservice.ws.BaroService_CARDSoap getBaroService_CARDSoap() {
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap;
  }
  
  public com.baroservice.ws.Card[] getCard(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCard(CERTKEY, corpNum);
  }
  
  public com.baroservice.ws.PagedCardLog getCardLog(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String cardNum, java.lang.String baseDate, int countPerPage, int currentPage) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCardLog(CERTKEY, corpNum, ID, cardNum, baseDate, countPerPage, currentPage);
  }
  
  public com.baroservice.ws.PagedCardLog getMonthlyCardLog(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String cardNum, java.lang.String baseMonth, int countPerPage, int currentPage, int orderDirection) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getMonthlyCardLog(CERTKEY, corpNum, ID, cardNum, baseMonth, countPerPage, currentPage, orderDirection);
  }
  
  public java.lang.String getCardScrapRequestURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCardScrapRequestURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public java.lang.String getCardManagementURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCardManagementURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public java.lang.String getCardLogURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCardLogURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public int checkCorpIsMember(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String checkCorpNum) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.checkCorpIsMember(CERTKEY, corpNum, checkCorpNum);
  }
  
  public int registCorp(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String corpName, java.lang.String CEOName, java.lang.String bizType, java.lang.String bizClass, java.lang.String postNum, java.lang.String addr1, java.lang.String addr2, java.lang.String memberName, java.lang.String juminNum, java.lang.String ID, java.lang.String PWD, java.lang.String grade, java.lang.String TEL, java.lang.String HP, java.lang.String email) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.registCorp(CERTKEY, corpNum, corpName, CEOName, bizType, bizClass, postNum, addr1, addr2, memberName, juminNum, ID, PWD, grade, TEL, HP, email);
  }
  
  public int addUserToCorp(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String memberName, java.lang.String juminNum, java.lang.String ID, java.lang.String PWD, java.lang.String grade, java.lang.String TEL, java.lang.String HP, java.lang.String email) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.addUserToCorp(CERTKEY, corpNum, memberName, juminNum, ID, PWD, grade, TEL, HP, email);
  }
  
  public int updateCorpInfo(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String corpName, java.lang.String CEOName, java.lang.String bizType, java.lang.String bizClass, java.lang.String postNum, java.lang.String addr1, java.lang.String addr2) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.updateCorpInfo(CERTKEY, corpNum, corpName, CEOName, bizType, bizClass, postNum, addr1, addr2);
  }
  
  public int updateUserInfo(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String memberName, java.lang.String juminNum, java.lang.String TEL, java.lang.String HP, java.lang.String email, java.lang.String grade) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.updateUserInfo(CERTKEY, corpNum, ID, memberName, juminNum, TEL, HP, email, grade);
  }
  
  public int updateUserPWD(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String newPWD) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.updateUserPWD(CERTKEY, corpNum, ID, newPWD);
  }
  
  public int changeCorpManager(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String newManagerID) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.changeCorpManager(CERTKEY, corpNum, newManagerID);
  }
  
  public com.baroservice.ws.Contact[] getCorpMemberContacts(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String checkCorpNum) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCorpMemberContacts(CERTKEY, corpNum, checkCorpNum);
  }
  
  public long getBalanceCostAmount(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getBalanceCostAmount(CERTKEY, corpNum);
  }
  
  public long getBalanceCostAmountOfInterOP(java.lang.String CERTKEY) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getBalanceCostAmountOfInterOP(CERTKEY);
  }
  
  public int checkChargeable(java.lang.String CERTKEY, java.lang.String corpNum, int CType, int docType) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.checkChargeable(CERTKEY, corpNum, CType, docType);
  }
  
  public int getChargeUnitCost(java.lang.String CERTKEY, java.lang.String corpNum, int chargeCode) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getChargeUnitCost(CERTKEY, corpNum, chargeCode);
  }
  
  public java.lang.String getCertificateRegistDate(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCertificateRegistDate(CERTKEY, corpNum);
  }
  
  public java.lang.String getCertificateExpireDate(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCertificateExpireDate(CERTKEY, corpNum);
  }
  
  public int checkCERTIsValid(java.lang.String CERTKEY, java.lang.String corpNum) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.checkCERTIsValid(CERTKEY, corpNum);
  }
  
  public java.lang.String getCertificateRegistURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCertificateRegistURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public java.lang.String getBaroBillURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD, java.lang.String TOGO) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getBaroBillURL(CERTKEY, corpNum, ID, PWD, TOGO);
  }
  
  public java.lang.String getLoginURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getLoginURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public java.lang.String getCashChargeURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getCashChargeURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public java.lang.String getSMSFromNumberURL(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String ID, java.lang.String PWD) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getSMSFromNumberURL(CERTKEY, corpNum, ID, PWD);
  }
  
  public int registSMSFromNumber(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String fromNumber) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.registSMSFromNumber(CERTKEY, corpNum, fromNumber);
  }
  
  public int checkSMSFromNumber(java.lang.String CERTKEY, java.lang.String corpNum, java.lang.String fromNumber) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.checkSMSFromNumber(CERTKEY, corpNum, fromNumber);
  }
  
  public java.lang.String getErrString(java.lang.String CERTKEY, int errCode) throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    return baroService_CARDSoap.getErrString(CERTKEY, errCode);
  }
  
  public void ping() throws java.rmi.RemoteException{
    if (baroService_CARDSoap == null)
      _initBaroService_CARDSoapProxy();
    baroService_CARDSoap.ping();
  }
  
  
}