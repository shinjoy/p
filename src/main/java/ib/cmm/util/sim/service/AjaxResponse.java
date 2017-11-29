package ib.cmm.util.sim.service;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import ib.cmm.util.fcc.service.StringUtil;

/**
 * <pre>
 * package	: eam.common.util
 * filename	: AjaxResponse.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 6. 16.
 * @version :
 *
 */
public class AjaxResponse {

	protected static final Log logger = LogFactory.getLog(AjaxResponse.class);


	/**
	 * 세션아웃 결과전송 공통함수
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 11.
	 */
	public static void responseAjaxSessionOut(HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HashMap result = new HashMap();

		//Gson gson = new Gson();
		Gson gson = new GsonBuilder().serializeNulls().create();

		//세션아웃 상태이므로 실패전송

		result.put("result", 	"FAIL");
		result.put("resultVal",	"SESSION");
		result.put("resultMsg",	URLEncoder.encode("세션아웃", "UTF-8"));


		logger.debug("######result json string######:"+gson.toJson(result));
		out.print(gson.toJson(result));
	}


	/**
	 * 결과전송 공통함수 (SELECT)
	 *
	 * @param		: obj ...List type (select 의 결과로 List 통일)
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 11.
	 */
	public static void responseAjaxSelect(HttpServletResponse response, List<Map> listObj) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HashMap result = new HashMap();

		//Gson gson = new Gson();
		/*GsonBuilder gb = new GsonBuilder();
		gb.registerTypeAdapter(String.class, new StringConverter());
		Gson gson = gb.create();*/
		Gson gson = new GsonBuilder().serializeNulls().create();

		result.put("result", 	"SUCCESS");
		result.put("resultVal",	listObj.size());
		result.put("resultMsg",	"");
		result.put("resultList", listObj);


		//logger.debug("######result json string11111111######:"+gson.toJson(result));
		out.print(gson.toJson(result));
	}


	/**
	 * 결과전송 공통함수 (SELECT) (with paging)
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 15.
	 */
	public static void responseAjaxSelectForPage(HttpServletResponse response, Object obj) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HashMap result = new HashMap();

		//Gson gson = new Gson();
		Gson gson = new GsonBuilder().serializeNulls().create();

		/*
		Map<String, Object>
			obj			: pageNo(페이지번호)
			totalCount	: Integer (총 건수),
			pageCount	: Integer (총 페이지수),
			list		: List<Map> (사원리스트)
		 */

		result.put("result", 	"SUCCESS");
		result.put("resultVal",	Integer.parseInt(((Map)obj).get("totalCount").toString()));
		result.put("resultMsg",	"");
		result.put("resultList", ((Map)obj).get("list"));

		//paging values
		result.put("pageNo", Integer.parseInt(((Map)obj).get("pageNo").toString()));
		result.put("totalCount", result.get("resultVal"));
		result.put("pageCount", Integer.parseInt(((Map)obj).get("pageCount").toString()));


		logger.debug("######result json string######:"+gson.toJson(result));
		out.print(gson.toJson(result));
	}


	/**
	 * 결과전송 공통함수 (INSERT, UPDATE, DELETE)
	 *
	 * @param		: res 		- HttpServletResponse
	 * 				  saveCnt	- 수정건수
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 5. 28.
	 */
	public static void responseAjaxSave(HttpServletResponse response, int saveCnt) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HashMap result = new HashMap();

		//Gson gson = new Gson();
		Gson gson = new GsonBuilder().serializeNulls().create();

		//수정건수에 따른 성공 실패 전송
		if(saveCnt>0){
			result.put("result", 	"SUCCESS");
			result.put("resultVal",	saveCnt);
			result.put("resultMsg",	URLEncoder.encode("저장성공", "UTF-8"));
		}else{
			result.put("result", 	"FAIL");
			result.put("resultVal",	saveCnt);
			result.put("resultMsg",	URLEncoder.encode("저장실패", "UTF-8"));
		}

		logger.debug("######result json string######:"+gson.toJson(result));
		out.print(gson.toJson(result));
	}

	/**
	 * 결과전송 공통함수 (INSERT, UPDATE, DELETE),  결과메시지 추가(2016.10.23 이인희)
	 *
	 * @param		: res 		- HttpServletResponse
	 * 				  saveCnt	- 수정건수
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 5. 28.
	 */
	public static void responseAjaxSave(HttpServletResponse response, int saveCnt,String errMsg) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HashMap result = new HashMap();

		//Gson gson = new Gson();
		Gson gson = new GsonBuilder().serializeNulls().create();

		//수정건수에 따른 성공 실패 전송
		if(StringUtil.isEmpty(errMsg)){
			if(saveCnt>0){
				result.put("result", 	"SUCCESS");
				result.put("resultVal",	saveCnt);
				result.put("resultMsg",	URLEncoder.encode("저장성공", "UTF-8"));
			}else{
				result.put("result", 	"FAIL");
				result.put("resultVal",	saveCnt);
				result.put("resultMsg",	URLEncoder.encode("저장실패", "UTF-8"));
			}
		}else{
			result.put("result", 	errMsg);
			result.put("resultVal",	saveCnt);
			result.put("resultMsg",	URLEncoder.encode("저장실패", "UTF-8"));
		}


		logger.debug("######result json string######:"+gson.toJson(result));
		out.print(gson.toJson(result));
	}


	/**
	 * 결과전송 공통함수 (다양한 형태의 Object 를 전달)
	 *
	 * @param		: obj
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 19.
	 */
	public static void responseAjaxObject(HttpServletResponse response, Object obj) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HashMap result = new HashMap();

		//Gson gson = new Gson();
		Gson gson = new GsonBuilder().serializeNulls().create();

		result.put("result", 	"SUCCESS");
		result.put("resultVal",	1);
		result.put("resultMsg",	"");
		result.put("resultObject", obj);


		logger.debug("######result json string######:"+gson.toJson(result));
		out.print(gson.toJson(result));
	}


	/**
	 * 결과전송 공통함수 (실패전용 - 메세지 전달하는경우. ( 예)검색건수0, 실패메세지 전달위해) )
	 *
	 * @param		: fail reason
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 6. 24.
	 */
	public static void responseAjaxFailWithMsg(HttpServletResponse response, String msg) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HashMap result = new HashMap();

		//Gson gson = new Gson();
		Gson gson = new GsonBuilder().serializeNulls().create();

		result.put("result", 	"FAIL");		//실패
		result.put("resultVal",	0);
		result.put("resultMsg",	URLEncoder.encode(msg, "UTF-8"));

		logger.debug("######result json string######:"+gson.toJson(result));
		out.print(gson.toJson(result));
	}


	/**
	 * 맵 으로 다양한 결과값을 전달해주기위한 함수.
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2016. 8. 16.
	 */
	public static void responseAjaxMap(HttpServletResponse response, Map map) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

	    //JSONObject jsonObject = JSONObject.fromObject(map);
		Gson gson = new GsonBuilder().serializeNulls().create();

		out.println(gson.toJson(map));
	}



}