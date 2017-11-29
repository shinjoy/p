package ib.basic.service.impl;

import ib.basic.service.CpnExcelVO;
import ib.cmm.FileUpDbVO;
import ib.company.service.impl.CompanyDAO;
import ib.notice.service.NoticeVO;
import ib.person.service.PersonVO;
import ib.person.service.impl.PersonDAO;
import ib.personnel.web.ManagementController;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Controller;

import com.ibm.icu.text.DecimalFormat;
import com.ibm.icu.text.SimpleDateFormat;

import egovframework.rte.fdl.excel.EgovExcelMapping;

/**
 * <pre>
 * package  : ib.basic.service.impl
 * filename : CpnUploadExcelMapping.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2012. 10. 20.
 * @version : 1.0.0
 */
@Controller
public class CpnUploadExcelMapping extends EgovExcelMapping {


    @Resource(name = "companyDAO")
    private CompanyDAO companyDAO;

    @Resource(name = "personDAO")
    private PersonDAO personDAO;

    protected static final Log LOG = LogFactory.getLog(ManagementController.class);

    /**
     * 엑셀 타이틀과 문자배열의 타이틀 비교하여 위치 찾기
     * @MethodName : titleMapping
     * @param what
     * @param row
     * @return
     */
    public int[] titleMapping(String what, Row row){
    	int titleNmLeng = 0;
    	String[] titleName = null;

    	if("cpn".equals(what)) {
    		titleName= new String[] {
    				"법인코드","법인명","시장","업종","주요품목","상장일자","지역","시가총액","차입금","PBR","PER","지분율","자사주","부채비율","CB","BW","EB","현금성"
    		};
    		titleNmLeng = titleName.length;

    	}else if("cst".equals(what)) {
    		titleName= new String[] {"aa"};
    		titleNmLeng = titleName.length;

    	}else if("notice".equals(what)) {
    		titleName = new String[] {
    				"TM_DT","WAY","CATEGORY_CD","CPN_ID","RANK","PRICE","COUPON","YTM","YTP","PAYUP_DT","DUE_DT","PUT","EVENT_PRICE","WRT_DUE_DT","REFIX_SALE","SUPER_CPN","UNDER_WRITER","BUYBACK","PREMIUM","TARGET","RELATION","ASSIGNMENT_DT","SUBSCRIPTION_DT"
    				};
    		//titleName = new String[] {"접수일자","방법","구분","회사명","종목코드","회차","금액","쿠폰","YTM","YTP","납입일","사채만기","PUT","행사가","워런트만기","리픽싱","주관회사","인수자","BUYBACK","프리미엄","대상","관계","배정기준일","청약일"};

    		titleNmLeng = titleName.length;
    	}

    	String cell[] = initCell(row);
    	int[] position = new int[cell.length];
    	int k = 0;

    	if(titleNmLeng == 0) return position;
    	for(int i=row.getFirstCellNum();i<row.getLastCellNum(); i++){
			for(int j=0; j< titleNmLeng; j++){
				if(titleName[j].equals(cell[i].toString())) {
					position[k++] = j;
					j=titleNmLeng;
				}
    		}
    	}
    	return position;
    }

    public CpnExcelVO fillCpnVO(int[] position, Row row){
    	CpnExcelVO vo = new CpnExcelVO();
    	String cell[] = initCell(row);
    	//vo.setPbr("0");
    	//vo.setShare("0");
    	//vo.setDebtRatio("0");

    	for(int i = 0; i< position.length; i++){
    		String cellComment = "";
    		if(i>=row.getLastCellNum()) {
    			cellComment = null;
    		} else {
    			cellComment = cell[i];
    		}
    		//System.out.println("====="+cellComment+":"+i+":"+row.getLastCellNum()+"=====");
    		switch(position[i]){
			case  0: vo.setCpnId			 (cellComment); break;
			case  1: vo.setCpnNm			 (cellComment); break;
			case  2: vo.setMarket			 (cellComment==null?"": cellComment); break;
			case  3: vo.setCategoryBusiness	 (cellComment==null?"": cellComment); break;
			case  4: vo.setMajorProduct		 (cellComment==null?"": cellComment); break;
			case  5: vo.setListedDt			 (cellComment==null?"": cellComment); break;
			case  6: vo.setRegion			 (cellComment==null?"": cellComment); break;
			case  7: vo.setCapitalization	 (cellComment==null?"": cellComment); break;
			case  8: vo.setFluctuation		 (cellComment==null?"": cellComment); break;
			case  9: vo.setPbr				 (cellComment==null?null:cellComment); break;
			case 10: vo.setPer				 (cellComment==null?null:cellComment); break;
			case 11: vo.setShare			 (cellComment==null?null:cellComment); break;
			case 12: vo.setStock			 (cellComment==null?"": cellComment); break;
			case 13: vo.setDebtRatio		 (cellComment==null?null:cellComment); break;
			case 14: vo.setCb				 (cellComment); break;
			case 15: vo.setBw				 (cellComment); break;
			case 17: vo.setEb				 (cellComment); break;
			case 18: vo.setCashable			 (cellComment); break;
    		}
    	}

		return vo;
    }

    public PersonVO fillCstVO(int[] position, Row row){
    	PersonVO vo = new PersonVO();
    	String cell[] = initCell(row);

    	return vo;
    }

    /**
     * row를 받아서 vo에 넣어 반환
     * @MethodName : fillNoticeVO
     * @param position
     * @param row
     * @return
     */
    public NoticeVO fillNoticeVO(int[] position, Row row){
    	NoticeVO vo = new NoticeVO();
    	String cell[] = initCell(row);
    	vo.setRank(null);
    	vo.setPayupDt(null);
    	vo.setDueDt(null);
    	vo.setWrtDueDt(null);
    	vo.setAssignmentDt(null);
    	vo.setSubscriptionDt(null);

    	for(int i = 0; i< position.length; i++){
    		String cellComment = "";
    		if(i>=row.getLastCellNum()) {
    			cellComment = "";
    		} else {
    			cellComment = cell[i]==null?"":cell[i];
    		}

    		switch(position[i]){
			case  0: vo.setTmDt			(cellComment); break;
			case  1: vo.setWay			(cellComment); break;
			case  2: vo.setCategoryCd	(cellComment); break;
			case  3: vo.setCpnId		(cellComment); break;
			case  4: vo.setRank			(cellComment==""?null:cellComment); break;
			case  5: vo.setPrice		(cellComment); break;
			case  6: vo.setCoupon		(cellComment); break;
			case  7: vo.setYtm			(cellComment); break;
			case  8: vo.setYtp			(cellComment); break;
			case  9: vo.setPayupDt		(cellComment==""?null:cellComment); break;
			case 10: vo.setDueDt		(cellComment==""?null:cellComment); break;
			case 11: vo.setPut			(cellComment); break;
			case 12: vo.setEventPrice	(cellComment); break;
			case 13: vo.setWrtDueDt		(cellComment==""?null:cellComment); break;
			case 14: vo.setRefixSale	(cellComment); break;
			case 15: vo.setSuperCpn		(cellComment); break;
			case 16: vo.setUnderWriter	(cellComment); break;
			case 17: vo.setBuyback		(cellComment); break;
			case 18: vo.setPremium		(cellComment); break;
			case 19: vo.setTarget		(cellComment); break;
			case 20: vo.setRelation	    (cellComment); break;
			case 21: vo.setAssignmentDt	    (cellComment==""?null:cellComment); break;
			case 22: vo.setSubscriptionDt   (cellComment==""?null:cellComment); break;
    		}
    	}
    	return vo;
    }




	/**
	 * row를 cell로 배열화
	 * @MethodName : initCell
	 * @param row
	 * @return
	 */
	private String[] initCell(Row row){
    	int column = row.getLastCellNum();
    	DecimalFormat df = new DecimalFormat("0.###");

		Cell cell[] = new Cell[column];
		String str[] = new String[column];
		for(int i =0;i<column;i++){
			cell[i] = row.getCell((short) i);
		}
		for(int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++){  // 각 행의 마지막 cell까지
			//행에대한 셀을 하나씩 추출하여 셀 타입에 따라 처리

			if(cell[c] != null){
				String data = null;  // 여기서는 모든 cell의 값을 string으로 변환 한다.

				switch (cell[c].getCellType()) {
//				case HSSFCell.CELL_TYPE_BOOLEAN:
				case Cell.CELL_TYPE_BOOLEAN:
					boolean bdata = cell[c].getBooleanCellValue();
					data = String.valueOf(bdata);
					break;
				case Cell.CELL_TYPE_NUMERIC:

					// cell의 값이 numeric일 경우 날짜와 숫자 두가지일 경우이다. 아래와 같이 확인
//					if (HSSFDateUtil.isCellDateFormatted(cell[c])){
					if (DateUtil.isCellDateFormatted(cell[c])){
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
						data = formatter.format(cell[c].getDateCellValue());
					} else if(cell[c].toString().matches(".*..*")) {
						if(c==8)data = df.format( (int)cell[c].getNumericCellValue() );
						else data = df.format( cell[c].getNumericCellValue() );
					} else if(cell[c].toString().length()>=8) {
						int ddata = (int)cell[c].getNumericCellValue();
						data = df.format(ddata);
						data = data.replaceAll(",", "");
					} else {
						data = String.valueOf(cell[c].getNumericCellValue());
						//data = df.format(ddata);
					}
					break;
				case Cell.CELL_TYPE_STRING:
					data = cell[c].toString();
					break;
				case Cell.CELL_TYPE_BLANK:
				case Cell.CELL_TYPE_ERROR:
					// 수식일 경우 기존의 바로 처리하는 방식이 아니라 수식을 다시 계산한 후 해당 값이 어떤 type인지 확인해서 처리한다.

				case Cell.CELL_TYPE_FORMULA:
					/*
					if(!(cell[c].toString()=="") ){
						if(evaluator.evaluateFormulaCell(cell[c])==HSSFCell.CELL_TYPE_NUMERIC){
							double fddata = cell[c].getNumericCellValue();
							data = df.format(fddata);
						}else if(evaluator.evaluateFormulaCell(cell[c])==HSSFCell.CELL_TYPE_STRING){
							data = cell[c].getStringCellValue();
						}else if(evaluator.evaluateFormulaCell(cell[c])==HSSFCell.CELL_TYPE_BOOLEAN){
							boolean fbdata = cell[c].getBooleanCellValue();
							data = String.valueOf(fbdata);
						}
						break;
					}
					*/
				default:
					continue;
				}
				//cell[c].setCellValue(data);
				str[c] = data;
			}
		}
		return str;
    }



//	public CpnExcelVO mappingColumn(Row row, String stuff) {
	public Object mappingColumn(Row row, String stuff) {
		Object obj = new Object();
//		NumberFormat df = new DecimalFormat();
		String cell[] = initCell(row);

		CpnExcelVO vo = new CpnExcelVO();
		NoticeVO voN = new NoticeVO();


		if("exp".equals(stuff)){
			//System.out.println("=========\n 퍼센트 \n"+cell[11].toString()+";;"+cell[10].toString());
			int c = row.getLastCellNum();
			if(c> 0) vo.setCpnId		( cell[0].toString());
			if(c> 1) vo.setText			( cell[1].toString());
			obj = vo;
		}
		if("cpn".equals(stuff)){
			//System.out.println("=========\n 퍼센트 \n"+cell[11].toString()+";;"+cell[10].toString());
			int c = row.getLastCellNum();
			if(c> 0) vo.setCpnId			 ( cell[0].toString());
			if(c> 1) vo.setCpnNm			 ( cell[1].toString());
			if(c> 2) vo.setMarket			 ( cell[2]==null?"": cell[2].toString());
			if(c> 3) vo.setCategoryBusiness	 ( cell[3]==null?"": cell[3].toString());
			if(c> 4) vo.setMajorProduct		 ( cell[4]==null?"": cell[4].toString());
			if(c> 5) vo.setListedDt			 ( cell[5]==null?"": cell[5].toString());
			if(c> 6) vo.setRegion			 ( cell[6]==null?"": cell[6].toString());
			if(c> 7) vo.setCapitalization	 ( cell[7]==null?"": cell[7].toString());
			if(c> 8) vo.setFluctuation		 ( cell[8]==null?"": cell[8].toString());
			if(c> 9) vo.setPbr				 ( cell[9]==null?null: cell[9].toString());
			if(c>10) vo.setPer				 (cell[10]==null?null: cell[10].toString());
			if(c>11) vo.setShare			 (cell[11]==null?"0": cell[11].toString());
			if(c>12) vo.setStock			 (cell[12]==null?"": cell[12].toString());
			if(c>13) vo.setDebtRatio		 (cell[13]==null?"": cell[13].toString());
			if(c>14) vo.setCb				 (cell[14].toString());
			if(c>15) vo.setBw				 (cell[15].toString());
			if(c>17) vo.setEb				 (cell[17].toString());
			if(c>18) vo.setCashable			 (cell[18].toString());
	//		vo.setPut					(cell16.getRichStringCellValue().toString());
	//		vo.setCeoId					(cell.getRichStringCellValue().toString());
	//		vo.setCpnListedCd			(cell.getRichStringCellValue().toString());
	//		vo.setIr					(cell.getRichStringCellValue().toString());
	//		vo.setAddr					(cell.getRichStringCellValue().toString());
	//		vo.setAddrDetail			(cell.getRichStringCellValue().toString());
	//		vo.setQnA					(cell.getRichStringCellValue().toString());
	//		vo.setHomepage				(cell.getRichStringCellValue().toString());
	//		vo.setRgDt					(cell.getRichStringCellValue().toString());
	//		vo.setRgId					(cell.getRichStringCellValue().toString());
	//		vo.setUpDt					(cell.getRichStringCellValue().toString());
	//		vo.setUpId					(cell.getRichStringCellValue().toString());
			obj = vo;

		}else if("cst".equals(stuff)){
			int c = row.getLastCellNum();
			if(c> 0) vo.setRgDt					(cell[0].toString());
			if(c> 1) vo.setCstNm				(cell[1].toString());
			if(c> 2) vo.setCpnNm				(cell[2].toString());
			if(c> 3) vo.setPosition				(cell[3]==null?null:cell[3].toString());
			if(c> 4) vo.setPhn2					(cell[4]==null?null:cell[4].toString());
			if(c> 5) vo.setPhn1					(cell[5]==null?null:cell[5].toString());
			if(c> 6) vo.setEmail				(cell[6]==null?null:cell[6].toString());
			if(c> 7) vo.setNote					(cell[7]==null?null:cell[7].toString());
			if(c> 8) vo.setRgId					(cell[8].toString());
			obj = vo;

		}else if("book".equals(stuff)){
			int c = row.getLastCellNum();
			if(c> 0) vo.setBookNumber					(cell[0].toString());
			if(c> 1) vo.setTitle				(cell[1].toString());
			if(c> 2) vo.setAuthor				(cell[2].toString());
			if(c> 3) vo.setPublisher				(cell[3].toString());
			obj = vo;

		}else if("noticeM".equals(stuff)){
			int c = row.getLastCellNum();
			if(c>  0)voN.setTmDt			(cell[ 0].toString());
			if(c>  1)voN.setWay				(cell[ 1].toString());
			if(c>  2)voN.setCategoryCd		(cell[ 2].toString());
			if(c>  3)voN.setCpnId			(cell[ 3].toString());
			if(c>  4)voN.setRank			(cell[ 4].toString());
			if(c>  5)voN.setPrice			(cell[ 5].toString());
			if(c>  6)voN.setCoupon			(cell[ 6].toString());
			if(c>  7)voN.setYtm				(cell[ 7].toString());
			if(c>  8)voN.setYtp				(cell[ 8].toString());
			if(c>  9)voN.setPayupDt			(cell[ 9].toString());
			if(c> 10)voN.setDueDt			(cell[10].toString());
			if(c> 11)voN.setPut				(cell[11].toString());
			if(c> 12)voN.setEventPrice		(cell[12].toString());
			if(c> 13)voN.setWrtDueDt		(cell[13].toString());
			if(c> 14)voN.setRefixSale		(cell[14].toString());
			if(c> 15)voN.setSuperCpn		(cell[15].toString());
			if(c> 16)voN.setUnderWriter		(cell[16].toString());
			if(c> 17)voN.setBuyback			(cell[17].toString());
			if(c> 18)voN.setPremium			(cell[18].toString());
			if(c> 19)voN.setTarget			(cell[19].toString());
			if(c> 20)voN.setRelation	    (cell[20].toString());

			voN.setRgId("excel");
			obj = voN;
		}
		return obj;
	}




	/* (non-Javadoc)
	 * @see egovframework.rte.fdl.excel.EgovExcelMapping#mappingColumn(org.apache.poi.hssf.usermodel.HSSFRow)
	 */
	@Override
	public Object mappingColumn(HSSFRow row) throws Exception {
		return null;
	}


	public static void doGet(HttpServletRequest request, HttpServletResponse response, List<FileUpDbVO> fileUp)
	throws ServletException, IOException
	{
		doPost(request, response, fileUp);
	}

	private static String setDownFileName(HttpServletRequest req, String realName) throws IOException{
		String rtnName = null;
		String userAgent = req.getHeader("User-Agent");

		if (userAgent.toUpperCase().indexOf("CHROME") != -1) {
			rtnName = new String(realName.getBytes("EUC-KR"), "ISO-8859-1");

		} else if (userAgent.toUpperCase().indexOf("IPHONE") != -1) {
			rtnName = new String(realName.getBytes("UTF-8"),"ISO-8859-1");

		//} else if (userAgent.toUpperCase().indexOf("ANDROID") != -1) {
		//	webKind = "Android";

		} else if (userAgent.toUpperCase().indexOf("GECKO") != -1) {
			rtnName = new String(realName.getBytes("EUC-KR"), "ISO-8859-1");

		} else if (userAgent.toUpperCase().indexOf("MSIE") != -1) {

			if (userAgent.toUpperCase().indexOf("OPERA") != -1) {
				rtnName = new String(realName.getBytes("UTF-8"),"ISO-8859-1");
			} else {
				rtnName = new String(realName.getBytes("EUC-KR"),"ISO-8859-1").replaceAll("\\+","%20");
			}

		} else if (userAgent.toUpperCase().indexOf("SAFARI") != -1) {
			rtnName = new String(realName.getBytes("UTF-8"), "ISO-8859-1");

		} else {
			rtnName = new String(realName.getBytes("EUC-KR"), "ISO-8859-1");
		}

		return rtnName;
	}
	private static String setMimetype(String realName){
		String OnlyFileExt = realName.substring(realName.lastIndexOf('.') + 1).toLowerCase();	// 확장자
		String mimetype = "";

		if(OnlyFileExt.equals("doc") || OnlyFileExt.equals("docx")) mimetype = "application/msword";
		else if(OnlyFileExt.equals("xls") || OnlyFileExt.equals("xlsx")) mimetype = "vnd.ms-excel";			// x-msexcel
		else if(OnlyFileExt.equals("ppt") || OnlyFileExt.equals("pptx")) mimetype = "vnd.ms-powerpoint";	// x-mspowerpoint
		else if(OnlyFileExt.equals("pdf")) mimetype = "application/pdf";
		else if(OnlyFileExt.equals("txt")) mimetype = "text/plain";
		else if(OnlyFileExt.equals("htm") || OnlyFileExt.equals("html")) mimetype = "text/html";

		else if(OnlyFileExt.equals("png")) mimetype = "image/png";
		else if(OnlyFileExt.equals("gif")) mimetype = "image/gif";
		else if(OnlyFileExt.equals("jpg") || OnlyFileExt.equals("jpeg") || OnlyFileExt.equals("jpe")) mimetype = "image/jpeg";
		else if(OnlyFileExt.equals("tif") || OnlyFileExt.equals("tiff")) mimetype = "image/tiff";
		else mimetype = "image/x-msdownload";
		//System.out.println("mimetype============"+mimetype);

		return mimetype;
	}
	protected static void doPost(HttpServletRequest request, HttpServletResponse response, List<FileUpDbVO> fileUp)
	throws ServletException, IOException
	{
		// ① 파일명 가져오기
//		String fileName = request.getParameter("filename");
		String makeName = fileUp.get(0).getMakeName();
		String realName = fileUp.get(0).getRealName();
		// ② 경로 가져오기
//		String saveDir = request.getSession().getServletContext().getRealPath("/ex0820/");
		String saveDir = fileUp.get(0).getPath();
		File file = new File(saveDir + "/" + makeName);
		int fSize = (int) file.length();
		//System.out.println("파일명 : " + makeName +" / "+realName);

		// ③ MIMETYPE 설정하기
		String mimetype = setMimetype(realName);
		//String mimeType = request.getSession().getServletContext().getMimeType(file.toString());
		//if(mimeType == null)
		//{
		//	response.setContentType("application/octet-stream");
		//}
		// ④ 다운로드용 파일명을 설정
		String downName = setDownFileName(request, realName);

		response.setContentType(mimetype);

		response.setContentLength(fSize);

		// ⑤ 무조건 다운로드하도록 설정
		response.setHeader("Content-Disposition","attachment; filename=\"" + downName + "\";");
		//response.setHeader("Content-Type", "application/octet-stream");
		//response.setHeader("Content-Transfer-Encoding", "binary;");
		//response.setHeader("Pragma", "no-cache;");
		//response.setHeader("Expires", "-1;");

	    // attachment; 가 붙으면 IE의 경우 무조건 다운로드창이 뜬다. 상황에 따라 써야한다.
	    /*
	    if (userAgent != null && userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
	      response.setHeader("Content-Disposition", "filename=" + java.net.URLEncoder.encode(realName, "UTF-8") + ";");
	    } else if (userAgent != null && (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1)) { // MS IE (보통은 6.x 이상 가정)
	      response.setHeader("Content-Disposition", "attachment; filename="
	          + java.net.URLEncoder.encode(realName, "UTF-8") + ";");
	    } else { // 모질라나 오페라
	      response.setHeader("Content-Disposition", "attachment; filename="
	          + new String(realName.getBytes("EUC-KR"), "8859_1") + ";");
	    }*/
		// ⑥ 요청된 파일을 읽어서 클라이언트쪽으로 저장한다.
	    FileInputStream in = new FileInputStream(file);
	    ServletOutputStream out = response.getOutputStream();
		byte b [] = new byte[4096];
		int data = 0;
		try{
			while((data=(in.read(b, 0, b.length))) != -1){
				out.write(b, 0, data);
			}
		}catch(Exception e){
			LOG.error(e);
			e.printStackTrace();

		}finally{
			in.close();
			out.flush();
			out.close();
		}
	}
}