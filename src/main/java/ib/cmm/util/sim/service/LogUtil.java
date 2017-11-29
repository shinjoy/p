package ib.cmm.util.sim.service;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <pre>
 * package	: eam.common.util 
 * filename	: LogUtil.java
 * </pre>
 * 
 * 
 * 
 * @author	: YoungSik Oh
 * @date	: 2015. 6. 16.
 * @version : 
 *
 */
public class LogUtil {
	
	protected static final Log logger = LogFactory.getLog(LogUtil.class);
    
	
	/**
	 * map 안의 모든 요소를 console log print
	 *
	 * @param		: 
	 * @return		: 
	 * @exception	: 
	 * @author		: YoungSik Oh
	 * @date		: 2015. 6. 16.
	 */
	public static void printMap(Map map){
		logger.debug("############### MAP parameters :S ################");
		logger.debug("{");
		for(Object s : map.keySet().toArray()){
			String key = s.toString();
			logger.debug(key + " : \"" + map.get(key) + "\"");
		}
		logger.debug("}");
		logger.debug("############### MAP parameters :E ################");
	}
	
}