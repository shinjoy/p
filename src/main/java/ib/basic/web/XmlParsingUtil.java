package ib.basic.web;

import ib.business.web.BusinessController;
import ib.system.service.impl.OrgCompanyRegDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.xml.transform.stream.StreamSource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.oxm.xstream.XStreamMarshaller;
import org.springframework.stereotype.Service;

@Service
public class XmlParsingUtil {
	
	@Autowired
	@Qualifier(value="xstreamMarshaller")
	private XStreamMarshaller xstreamMarshaller;
	
	@Value("classpath:/xml/bsCodeList.xml")
	private Resource bsCodeList;
	
	@Value("classpath:/xml/bsCodeSet.xml")
	private Resource bsCodeSet;
	
	@Autowired
	@Qualifier(value="orgCompanyRegDAO")
	private OrgCompanyRegDAO orgCompanyRegDAO;
	
	protected static final Log logger = LogFactory.getLog(BusinessController.class);
	
	public void unmarshallXml(Map param) throws Exception{
		
		xstreamMarshaller.getXStream().addImplicitCollection(CommoncodeList.class, "list");
		
		List<Commoncodeset> afterInsertCodeSetList = new ArrayList<Commoncodeset>();
		//bs_code_set 입력하기 
		CommoncodeList codeSetList = (CommoncodeList) xstreamMarshaller.unmarshal(new StreamSource(bsCodeSet.getInputStream()));
		for(Commoncodeset vo : codeSetList.getList()){
			vo.setCREATED_BY(String.valueOf(param.get("userSeq")));
			vo.setUPDATED_BY(String.valueOf(param.get("userSeq")));
			vo.setORG_ID((Integer)param.get("orgId"));
			if(!StringUtils.equals("NULL", vo.getPARENT_SET_ID()) && !StringUtils.equals("0", vo.getPARENT_SET_ID())){
				//parent_set_id에 값이 있는 경우.(0과 null이 아닌 경우 새롭게 저장된 id값으로 업데이트)
				for(Commoncodeset set : afterInsertCodeSetList){
					if(set.getCODE_SET_ID() == Integer.parseInt(vo.getPARENT_SET_ID())){
						vo.setPARENT_SET_ID(String.valueOf(set.getREAL_CODE_SET_ID()));
					}
				}
			}
			
			orgCompanyRegDAO.insertCodeSet(vo);
			logger.debug("###########"+ vo.toString());
			afterInsertCodeSetList.add(vo);
		}
		
		
		//bs_code_list 입력하기

		CommoncodeList codeList = (CommoncodeList) xstreamMarshaller.unmarshal(new StreamSource(bsCodeList.getInputStream()));
		for (Commoncodeset vo : codeList.getList()) {
			
			//BS_CODE_SET 중심으로 돌리기
			for (Commoncodeset set : afterInsertCodeSetList) {
				if(vo.getCODE_SET_ID() == set.getCODE_SET_ID()){
					//code set 아이디 갱신하기
					vo.setCODE_SET_ID(set.getREAL_CODE_SET_ID());
				}
				
				//son_set_id를 입력된 키값으로 갱신
				if (!StringUtils.equals("NULL", vo.getSON_SET_ID())
						&& !StringUtils.equals("0", vo.getSON_SET_ID())) {
					if (set.getCODE_SET_ID() == Integer.parseInt(vo.getSON_SET_ID())) {
						vo.setSON_SET_ID(String.valueOf(set.getREAL_CODE_SET_ID()));
					}
				}
			}
			
			orgCompanyRegDAO.insertCodeList(vo);
			logger.debug("###########"+ vo.toString());
		}
	}
}
