package ib.common.tiles;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
/**
* 관계사 권한에따른 버튼노출태그
*
* @author
*/
@SuppressWarnings("serial")
public class AuthBtnTag extends TagSupport  {
 	String ele;
 	String event;
 	String orgId;
 	String id;
 	String classValue;
 	String txt;
    @Override
    public int doEndTag() throws JspException {
    	 //현재 요청중인 thread local의 HttpServletRequest 객체 가져오기
    	 HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

    	 //HttpSession 객체 가져오기
    	 HttpSession session = request.getSession();
        try {

        	Map baseUserLoginInfo = (Map) session.getAttribute("baseUserLoginInfo");

        	String returnStr = "";

        	JspWriter out = pageContext.getOut();

        	List<Map> accessOrgIdList = (List<Map>)session.getAttribute("accessOrgIdList");

        	boolean isView = false;

        	String orgBasicAuth = baseUserLoginInfo.get("orgBasicAuth").toString();

        	for(Map accessOrgMap : accessOrgIdList){
        		String orgAccessAuthType = accessOrgMap.get("orgAccessAuthType").toString();

        		if(orgId.equals(accessOrgMap.get("orgId").toString())&&!orgAccessAuthType.equals("READ")&&!orgBasicAuth.equals("READ")){
        			isView = true;
        		}
        	}

        	if(isView){
        		returnStr = "<"+ele + " "+event+" id='"+id+"' class='"+classValue+"' >"+txt+"</"+ele+">";
        	}
            out.println(returnStr);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new JspException();
        }
        return EVAL_PAGE;
    }
	public String getEle() {
		return ele;
	}
	public void setEle(String ele) {
		this.ele = ele;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getClassValue() {
		return classValue;
	}
	public void setClassValue(String classValue) {
		this.classValue = classValue;
	}
	public String getTxt() {
		return txt;
	}
	public void setTxt(String txt) {
		this.txt = txt;
	}


}
