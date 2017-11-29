package ib.cmm.util.sim.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * <pre>
 * package	: ibiss.common.util 
 * filename	: EtcUtil.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2015. 11. 25.
 * @version : 
 *
 */
public class EtcUtil {
	
	protected static final Log logger = LogFactory.getLog(EtcUtil.class);
    
	
	/**
	 * List Map 의 특정 key 값의 index 반환
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: oys
	 * @date		: 2015. 6. 16.
	 */
	public static int getIndexOFListMap(String value, String key, List<Map> listMap) {

	    int i = 0;
	    for(Map<String, String> map : listMap){
	        if(map.get(key).equals(value)){
	            return i;
	        } 
	        i++;
	    }
	    return -1;
	}
	
}