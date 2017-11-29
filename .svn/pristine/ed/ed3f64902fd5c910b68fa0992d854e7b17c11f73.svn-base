package ib.eam.web;


import ib.cmm.util.sim.service.AjaxResponse;
import ib.cmm.util.sim.service.LogUtil;
import ib.eam.service.CarMgmtService;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


/**
 * <pre>
 * package	: ibiss.eam.web
 * filename	: CarMgmtController.java
 * </pre>
 *
 *
 *
 * @author	: oys
 * @date	: 2015. 12. 2.
 * @version :
 *
 */
@Controller
public class CarMgmtController {

	@Resource(name = "carMgmtService")
	private CarMgmtService carMgmtService;


	protected static final Log logger = LogFactory.getLog(CarMgmtController.class);


	/**
	 * 차량리스트 페이지
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 12. 2.
	 */
	@RequestMapping(value = "/eam/carMgmt.do")
	public String projectMgmt(HttpServletRequest request,
			HttpSession session, HttpServletResponse response, ModelMap model) throws Exception {

		// SESSION check!
		if(session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception("session is null!");

		//메뉴 권한체크
		if(session.getAttribute("menuFilterStr").toString().indexOf("eam/carMgmt") == -1){
			return "redirect:/";
		}


		return "eam/carMgmt";
	}


	/**
	 * 차량 리스트 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 12. 1.
	 */
	@RequestMapping(value = "/eam/getCarList.do")
	public void getCarList(HttpServletRequest request,
			HttpServletResponse response, ModelMap model, HttpSession session,
			@RequestParam Map<String, String> map) throws Exception {
		try {
			// SESSION check!
			if(session.getAttribute("baseUserLoginInfo") == null)
				throw new Exception("session is null!");

			Map<String, Object> resultMap;

			resultMap = carMgmtService.getCarList((Map) map);

			List<Map> list = (List) (resultMap.get("list"));
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).get("carImage") != null) {
					// logger.debug("################[][][][][][][]#################:\n"
					// +
					// Base64.encodeBase64URLSafeString((byte[])list.get(i).get("carImage")));

					byte[] img = (byte[]) (list.get(i).get("carImage"));
					Base64 codec = new Base64();
					list.get(i).put("carImage", codec.encodeBase64String(img));
				}
			}

			AjaxResponse.responseAjaxSelectForPage(response, resultMap); // 결과전송
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	/**
	 * 차량 등록 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 12. 2.
	 */
	@RequestMapping(value = "/eam/doSaveCar.do")
	public void doSaveCar(
			HttpServletResponse response,
			MultipartHttpServletRequest request,  HttpSession session, @RequestParam Map<String, Object> map) throws Exception{

		int upCnt = 1; // 성공 '1'(임시값)
		
		// SESSION check!
		if(session.getAttribute("baseUserLoginInfo") == null)
			throw new Exception("session is null!");

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
		map.put("userSeq", baseUserLoginInfo.get("userId").toString()); // staff_snb(sequence)

		// 파일
		Iterator<String> fileNames = request.getFileNames();
		if (fileNames.hasNext()) {
			String fileNm = fileNames.next();
			MultipartFile mfile = request.getFile(fileNm);
			String ext = mfile.getOriginalFilename().toLowerCase();
			System.out.println(ext);
			if(mfile.getSize()>200001){			//200kb 보다 파일사이즈가 클때
				upCnt = -1; 					//실패처리
			}else if(!(ext.endsWith(".jpg") || ext.endsWith(".png")||ext.endsWith(".jpeg") || ext.endsWith(".gif") || ext.endsWith(".bmp"))){	//이미지가 아닐때 실패처리 
				upCnt = -2; 
			}else{
				map.put("carImage", mfile.getBytes()); // 파일데이터 추가
			}
			
		}/* else {
			if(map.get("fileDelYn").toString().equals("Y")){		//파일이 없다.(지운거)
				map.put("carImage", "");
			}
		}*/

		

		String orgId = baseUserLoginInfo.get("applyOrgId").toString();		//applyOrgId
		map.put("orgId", orgId);
		
		if(upCnt>0){	//파일사이즈 정상일때 처리
			if (map.get("carId") == null|| "".equals(map.get("carId").toString())|| "null".equals(map.get("carId").toString())) { // new
	
				upCnt = carMgmtService.insertCar(map); // upCnt : 실제 넘어오는 값은 아이디(carId) 이다
	
			} else { // update
	
				carMgmtService.updateCar(map);
				
				upCnt = Integer.parseInt(map.get("carId").toString()); // upCnt : 수정한  carId
			}
		}

		
		AjaxResponse.responseAjaxSave(response, upCnt);			
	}


	/**
	 * 차량 삭제 ajax
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: oys
	 * @date		: 2015. 12. 2.
	 */
	@RequestMapping(value = "/eam/doDelCar.do")
	public void doDeleteCar(
			HttpServletRequest request,
			HttpServletResponse response,
			 HttpSession session,
			@RequestParam Map<String, Object> map) throws Exception {

		try {

			Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");
			LogUtil.printMap(map); // map console log
			map.put("userSeq", baseUserLoginInfo.get("userId").toString()); // staff_snb(sequence)

			int upCnt = 1; // 성공 '1'(임시값)
			carMgmtService.deleteCar(map); // upCnt : 실제 넘어오는 값은 아이디(carId)
			
			//자산마스터와 자동차 정보는 1:1 이므로 자산마스터도 삭제처리
			//아직 확정 무
			//assetMasterMgmtService.deleteAssetMaster(map);
			
			AjaxResponse.responseAjaxSave(response, upCnt); // 결과전송
		} catch (Exception ex) {
			ex.printStackTrace();
			throw ex;
		}
	}


}
