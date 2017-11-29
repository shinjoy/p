package ib.basic.xml;

/**
 * 관계사 공통 코드 수동으로 돌릴때 사용함.
 */
import static org.junit.Assert.fail;
import ib.basic.web.XmlParsingUtil;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 관계사 별로 수동으로 넣어줄 때 사용함.
 * orgId에 관계사 아이디만 넣어주고 주석 풀면 들어감.
 * 
 * @author csy
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/test/resources/applicationContext.xml"
})
public class XmlUtilTest {
	
	@Autowired
	private XmlParsingUtil xmlParsingUtil;
	
	public class AbstractApplicationContextTest {
	    @Autowired ApplicationContext ctx;
	}
	
	 Log logger = LogFactory.getLog(XmlUtilTest.class);
	
	@Test
	public void test() {
		
		try{
			Map param = new HashMap();
			param.put("userSeq", 118);
			param.put("orgId", 11 );
			//xmlParsingUtil.unmarshallXml(param);
			
		}catch(Exception ex){
			ex.printStackTrace();
			fail("Not yet implemented");
		}
		
	}

}
