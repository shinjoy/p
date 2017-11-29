package ib.worktime.service.impl;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ib.common.util.DateUtil;
import ib.worktime.service.WorktimeService;

@Service("worktimeService")
public class WorktimeServiceImpl extends AbstractServiceImpl implements WorktimeService {

	@Resource(name = "worktimeDAO")
    private WorktimeDAO worktimeDAO;

	//근태관리목록
	public List<EgovMap> getWorktimeList(Map<String, Object> paramMap) throws Exception {
		/*Integer totCnt =0;
		totCnt = worktimeDAO.getWorktimeListTotalCnt(paramMap);
		paramMap.put("totCnt", totCnt);*/

		return worktimeDAO.getWorktimeList(paramMap);
	}

	//근태관리목록
	public List<EgovMap> getWorktimeMainList(Map<String, Object> paramMap) throws Exception {
		/*Integer totCnt =0;
		totCnt = worktimeDAO.getWorktimeListTotalCnt(paramMap);
		paramMap.put("totCnt", totCnt);*/

		return worktimeDAO.getWorktimeMainList(paramMap);
	}

	//근태관리목록  : 월별 마감여부
	public List<EgovMap> getWorktimeEndYnByMonthList(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeEndYnByMonthList(paramMap);
	}

	//근태관리목록  : 년별 마감여부
	public List<EgovMap> getWorktimeEndYnByYearList(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeEndYnByYearList(paramMap);
	}

	//근태관리목록  : 월별
	public List<EgovMap> getWorktimeByMonthList(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeByMonthList(paramMap);
	}

	//근태관리목록  : 년별
	public List<EgovMap> getWorktimeByYearList(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeByYearList(paramMap);
	}

	//근태 상세조회
	public EgovMap getWorktime(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktime(paramMap);
	}

	//근태승인 저장
	public int doSaveAttendanceApprov(Map<String, Object> paramMap) throws Exception {
		int rtn = 0;

		//근태승인요청인경우
		if("APPROVE".equals(paramMap.get("actionType").toString())){
			if("Y".equals(paramMap.get("workReqAcceptYn").toString())){  // 승인인경우 근태요청타입값을 입력
				paramMap.put("workType", paramMap.get("workReqType").toString());
			}else{  //반려인경우는 원래값을 유지한다.
				paramMap.put("workType", null);
			}
		}else if("MANAGEMENT".equals(paramMap.get("actionType").toString())){
			paramMap.put("mngWorkPrcType", paramMap.get("workType").toString());
		}else{  //승인수정인경우
			paramMap.put("workReqAcceptYn", "Y");
			paramMap.put("mngWorkPrcType", paramMap.get("workType").toString());
		}

		return worktimeDAO.doSaveAttendanceApprov(paramMap);
	}

	//출근인정요청 저장
	public int doSaveAttendanceApprovReq(Map<String, Object> paramMap) throws Exception {
		int rtn = 0;

		if("LATE".equals(paramMap.get("workReqType").toString())){  // 지각인정인 경우 바로 지각 처리함
			paramMap.put("workType","LATE");
			paramMap.put("workReqAcceptYn","Y");
			rtn = worktimeDAO.doSaveAttendanceApprov(paramMap);
		}else if("NO_WORK".equals(paramMap.get("workReqType").toString())){  // 결근인정인경우 바로 결근 처리함
			paramMap.put("workType","NO_WORK");
			paramMap.put("workReqAcceptYn","Y");
			rtn = worktimeDAO.doSaveAttendanceApprov(paramMap);
		}else{
			rtn = worktimeDAO.doSaveAttendanceApprovReq(paramMap);
		}

		return rtn;
	}

	//근태현황 통계
	public EgovMap getWorktimeStatistics(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeStatistics(paramMap);
	}

	//근태정보 : 년도별
	public List<EgovMap> getWorktimeInfoByYearList(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeInfoByYearList(paramMap);
	}

	//근태마감 여부 : 일
	public EgovMap getWorktimeEndInfoForDay(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeEndInfoForDay(paramMap);
	}

	//근태마감 여부 : 월
	public EgovMap getWorktimeEndInfoForMonth(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeEndInfoForMonth(paramMap);
	}

	//근태마감 여부 : 월
	public EgovMap getWorktimeEndInfoForMonth2(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeEndInfoForMonth2(paramMap);
	}

	//일근태마감처리
	public int processWorkTimeDayEnd(Map<String, Object> paramMap) throws Exception {
		int rtn = 0;
		rtn = worktimeDAO.updateWorkTimeForEndOfNoWork(paramMap);  // 일근태 처리: 결근처리(미로그인시)
		rtn = worktimeDAO.updateWorkTimeEndForEnd(paramMap);  // 일근태마감처리

		return 1;
	}

	//월근태마감처리
	public int processWorkTimeMonthEnd(Map<String, Object> paramMap) throws Exception {
		int rtn = 0;
		rtn = worktimeDAO.updateWorkTimeForEndOfNoWork(paramMap);  // 근태 처리: 결근처리(미로그인시)
		rtn = worktimeDAO.updateWorkTimeEndForEnd(paramMap);  // 근태마감처리

		return 1;
	}

	//달력조회:월별
	public List<EgovMap> getCalendarPerMonth(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getCalendarPerMonth(paramMap);
	}
	//근태일괄관리 업로드엑셀파일리스트
	public List<EgovMap> getWorkTimeExcelFileList(Map<String,Object> paramMap) throws Exception{
		return worktimeDAO.getWorkTimeExcelFileList(paramMap);
	}
	//출근부 엑셀 업로드 일괄 업로드
	public Map uploadWorktimeExcel(Map param, File fNewname1) throws Exception {

		//결과 전송용 맵
		List<Map<String,String>> resultMapList = new ArrayList<Map<String,String>>();

		//이력이 있는 건수
		int attendReqCnt = 0;
		//에러건수
		int errorCnt = 0;
		/**
		 *
		 * 1.엑셀 파싱
		 *
		 * */
		//파일을 읽기위해 엑셀파일을 가져온다
		FileInputStream fis=new FileInputStream(fNewname1);
		XSSFWorkbook workbook=new XSSFWorkbook(fis);
		/*SimpleDateFormat formatterY = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatterH = new SimpleDateFormat("kk:mm");*/

		int rowindex=0;
		int columnindex=0;
		//시트 수 (첫번째에만 존재하므로 0을 준다)
		//만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		XSSFSheet sheet=workbook.getSheetAt(0);
		//행의 수
		int rows=sheet.getLastRowNum()+1;
				//.getPhysicalNumberOfRows();
		for(rowindex=1;rowindex<rows;rowindex++){
			//저장을 위한 맵
			Map<String,String> insertMap = new HashMap<String, String>();

		    //행을읽는다
		    XSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		        //셀의 수
		        int cells=row.getPhysicalNumberOfCells();
		        for(columnindex=0;columnindex<=cells;columnindex++){
		            //셀값을 읽는다
		            XSSFCell cell=row.getCell(columnindex);
		            String value="";
		            //셀이 빈값일경우를 위한 널체크
		            if(cell==null){
		                continue;
		            }else if(cell==null){
		            	continue;
		            }else{
		            	switch (cell.getCellType()) {
						case XSSFCell.CELL_TYPE_FORMULA:
							value =cell.getCellFormula();
							break;
						case XSSFCell.CELL_TYPE_NUMERIC:
							  //현재 엑셀 Template에 Numeric 은 DateType만 허용한다.
							  //출근기준시간,퇴근기준시간,췰근일,출근시간,퇴근일,퇴근시간
							  if (HSSFDateUtil.isCellDateFormatted(cell)){
								  if(columnindex == 2 || columnindex == 3 || columnindex == 5|| columnindex == 7){
							          SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
							          value = formatter.format(cell.getDateCellValue());
								  }else if(columnindex == 4 ||columnindex == 6 ){
									  SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
							          value = formatter.format(cell.getDateCellValue());
								  }
						     }
							break;
						case XSSFCell.CELL_TYPE_STRING:
							value = "" + cell.getStringCellValue();
							break;
						case XSSFCell.CELL_TYPE_BLANK:
							value = "";
							break;
						case XSSFCell.CELL_TYPE_ERROR:
							value = "" + cell.getErrorCellValue();
							break;
						default:
						}
		            	if(EgovStringUtil.isEmpty(value)){
		            		continue;
		            	}
		            	switch (columnindex){
		                case 0:  //이름

		                	insertMap.put("name", value);
		                    break;
		                case 1:  //부서
		                	insertMap.put("deptName", value);
		                    break;
		                case 2:  //출근기준시간
		                	insertMap.put("inTimeBase", value);
		                    break;
		                case 3:  //퇴근기준시간
		                	insertMap.put("outTimeBase", value);
		                    break;
		                case 4:  //출근일
		                	insertMap.put("inTimeDate", value);
		                    break;
		                case 5:  //출근시간
		                	insertMap.put("inTime", value);
		                    break;
		                case 6:  //퇴근일
		                	insertMap.put("outTimeDate", value);
		                    break;
		                case 7:  //퇴근시간
		                	insertMap.put("outTime", value);
		                    break;
		                }

		            }
		        }
		    }

		    if(insertMap.keySet().size()>0){
			    insertMap.put("applyOrgId", param.get("applyOrgId").toString());
				insertMap.put("rgId", param.get("rgId").toString());
			    /**
			     *
			     * 2.벨리데이션
			     * */

			    this.validAttendExcelFile(insertMap);


			    //param.put("errorText", "");


			   resultMapList.add(insertMap);
		    }
		}

		/**
		 *
		 * 3.파일 db저장
		 * */

		Integer worktimeExcelFileId = worktimeDAO.insertWorktimeExcelFile(param);

		/**
	    *
	    * 4. 엑셀 데이터 db저장
	    *
	    * */
		for(Map<String,String> insertMap:resultMapList){
			insertMap.put("worktimeExcelFileId", worktimeExcelFileId.toString());

			//에러 텍스트가 있다면 에러
			if(insertMap.get("errorText")!=null&&EgovStringUtil.isNotEmpty(insertMap.get("errorText")) ){
				errorCnt++;
			}
			//이력 텍스트가 있다면 에러
			if(insertMap.get("warningText")!=null&&EgovStringUtil.isNotEmpty(insertMap.get("warningText")) ){
				attendReqCnt++;
			}
			Integer rtn = worktimeDAO.insertWorktimeExcel(insertMap);  //근태엑셀 등록
		}
		param.put("worktimeExcelFileId", worktimeExcelFileId.toString());

		//Integer cnt =worktimeDAO.updateWorktimeExcelErrorMsg(param);

		/*if(cnt>0){
			errorCnt++;
		}*/

		if(errorCnt>0) param.put("errorYn", "Y");
		else param.put("errorYn", "N");

		param.put("attendReqCnt", attendReqCnt);

		worktimeDAO.updateWorktimeExcelFileResult(param);

		param.put("resultMapList", resultMapList);
		//----------------------------------- 등록 :E -----------------------------------

		return param;
	}

	/**
	 * 근태 엑셀파일 유효성 체크
	 * 01 필수값 체크
	 * 02 필드별 벨리데이션 체크
	 * 03 사용자 조회 및 이력죄회
	 * 04 조회한 사용자의 출근일/퇴근일 벨리데이션
	 *
	 * */
	public void validAttendExcelFile(Map<String,String> insertMap) throws Exception{

		//초기 에러 여부는 N
		insertMap.put("errorYn", "N");

		//에러 텍스트
		String errorText = "";

		//이력 텍스트
		String warningText = "";

		/**
		 * 01 필수값 체크
		 * -requiredPramArr : 필드명|에러 메세지
		 * -에러 발생시 : requiredPramArr의 에러메세지 + 필수값입니다.
		 *
		 * */
		String[] requiredPramArr = {"name|이름은","deptName|부서는","inTimeBase|출근기준시간은","outTimeBase|퇴근기준시간은"};

		for(String requiredParam :requiredPramArr){

			String[] requiredParamBuf =  requiredParam.split("[|]");

			if(EgovStringUtil.isEmpty(insertMap.get(requiredParamBuf[0]))){
				errorText +=requiredParamBuf[1]+" 필수값입니다.|";
				insertMap.put("errorYn", "Y");
			}
		}

		/**
		 * 02-01 세부사항 체크 : 날짜및시간체크
		 * -inTimeBase , outTimeBase ,  inTime , outTime
		 * 						: HH:mm 형식 , HH - > 0~23
		 * 						   			, mm -> 0~59
		 * -inTimeDate , outTimeDate
		 * 						: yyyy-MM-dd 형식
		 *
		 * */
		//시간체크
		String[] detailColArr = {"inTimeBase|출근기준시간","outTimeBase|퇴근기준시간","inTime|출근","outTime|퇴근"};

		for(String detailCol:detailColArr){
			String[] detailColBuf =  detailCol.split("[|]");

			if(EgovStringUtil.isNotEmpty(insertMap.get(detailColBuf[0]))){
				String timeStr = insertMap.get(detailColBuf[0]);

				String[] timeBuf = timeStr.split(":");

				if(timeBuf.length!=2) {
					errorText +=detailColBuf[1]+"은 시간 형식으로 입력하셔야 합니다. ex)23:40|";
					insertMap.put("errorYn", "Y");
				}else{
					//
					try{
						Integer timeHourInt = Integer.parseInt(timeBuf[0]);
						Integer timeMinuteInt = Integer.parseInt(timeBuf[1]);

						String minBuf = "";
						String hourBuf ="";

						if(timeHourInt<0||timeHourInt>23){
							errorText +=detailColBuf[1]+"은 시간 형식으로 입력하셔야 합니다. ex)23:40|";
							insertMap.put("errorYn", "Y");
						}else{
							hourBuf = timeHourInt<10?"0"+timeHourInt:timeHourInt+"";
							insertMap.put(detailColBuf[0], hourBuf);
						}

						if(timeMinuteInt<0||timeMinuteInt>59){
							errorText +=detailColBuf[1]+"은 시간 형식으로 입력하셔야 합니다. ex)23:40|";
							insertMap.put("errorYn", "Y");
						}else{
							minBuf = timeMinuteInt<10?"0"+timeMinuteInt:timeMinuteInt+"";

						}

						insertMap.put(detailColBuf[0], hourBuf+":"+minBuf);

					}catch(Exception e){
						errorText +=detailColBuf[1]+"은 시간 형식으로 입력하셔야 합니다. ex)23:40|";
						insertMap.put("errorYn", "Y");
					}
				}
			}
		}

		//일자체크
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		try{
			if(EgovStringUtil.isNotEmpty(insertMap.get("inTimeDate"))){
				Date inTimeDate= sdf.parse(insertMap.get("inTimeDate").toString());

				if(DateUtil.getDiffDayCountTwoDate(inTimeDate,now)<0){
					errorText +="오늘 이후 출근정보를 입력할 수 없습니다.|";
					insertMap.put("errorYn", "Y");
				}
			}
		}catch (Exception e) {
			errorText +="출근일이 날짜형식에 맞지 않습니다. ex)2017-03-10|";
			insertMap.put("errorYn", "Y");
		}
		try{
			if(EgovStringUtil.isNotEmpty(insertMap.get("outTimeDate"))){
				Date outTimeDate= sdf.parse(insertMap.get("outTimeDate").toString());

				if(DateUtil.getDiffDayCountTwoDate(outTimeDate,now)<0){
					errorText +="오늘 이후 퇴근정보를 입력할 수 없습니다.|";
					insertMap.put("errorYn", "Y");
				}

			}
		}catch (Exception e) {
			errorText +="퇴근일이 날짜형식에 맞지 않습니다. ex)2017-03-10|";
			insertMap.put("errorYn", "Y");
		}

		/**
		 * 02-02 세부사항 체크 : 출근일,출근시간 , 퇴근일,퇴근시간 체크
		 * -출근일,출근시간은 둘다 있거나 둘다 없어야한다.(퇴근동일)
		 * -출근시간과 퇴근시간은 둘중 하나는 있어야한다
		 * */
		if(EgovStringUtil.isNotEmpty(insertMap.get("inTimeDate"))||EgovStringUtil.isNotEmpty(insertMap.get("inTime"))){
			if(EgovStringUtil.isEmpty(insertMap.get("inTimeDate"))||EgovStringUtil.isEmpty(insertMap.get("inTime"))){
				errorText += "출근정보를 정확히 입력해주세요.|";
				insertMap.put("errorYn", "Y");
			}
		}
		if(EgovStringUtil.isNotEmpty(insertMap.get("outTimeDate"))||EgovStringUtil.isNotEmpty(insertMap.get("outTime"))){
			if(EgovStringUtil.isEmpty(insertMap.get("outTimeDate"))||EgovStringUtil.isEmpty(insertMap.get("outTime"))){
				errorText += "퇴근정보를 정확히 입력해주세요.|";
				insertMap.put("errorYn", "Y");
			}
		}
		boolean workInOutTimeChk = true;
		if((EgovStringUtil.isEmpty(insertMap.get("inTimeDate"))&&EgovStringUtil.isEmpty(insertMap.get("inTime")))&&(EgovStringUtil.isEmpty(insertMap.get("outTimeDate"))&&EgovStringUtil.isEmpty(insertMap.get("outTime")))){
			errorText += "출,퇴근정보중 한가지 이상은 필수로 입력해야 합니다.|";
			insertMap.put("errorYn", "Y");
			workInOutTimeChk = false;
		}
		/**
		 * 03 사용자 조회 및 이력죄회
		 * -이름 , 부서 텍스트로 유저를 조회한다. 조회되지 않는다면 에러메세지셋팅
		 * -1건이상 조회되도 에러
		 * -조회한 유저의 출근일/퇴근일의 이력을 셋팅한다.
		 * -입력받은 출근일이 없다면 해당 출근일에 출근정보가 있어야 한다.
		 * */
		List<EgovMap> attendUserMapList = worktimeDAO.getAttendUserInfo(insertMap);

		if(attendUserMapList== null || attendUserMapList.size()<1){
			errorText += "입력받은 직원정보가 조회되지 않습니다.|";
			insertMap.put("errorYn", "Y");
		}else if(attendUserMapList.size()>1){
			errorText += "입력받은 직원정보가 2건이상 조희됩니다. 관리자에게 문의해 주세요.|";
			insertMap.put("errorYn", "Y");
		}else{

			EgovMap attendUserMap = attendUserMapList.get(0);

			insertMap.put("userId", attendUserMap.get("userId").toString());

			//******************이력 메세지:E**********************************************************//
			insertMap.put("warningYn", "N");

			//출근일이 엑셀 데이터에 없다면 db조회결과에라도 있어야한다.
			if(EgovStringUtil.isEmpty(insertMap.get("inTime"))&&workInOutTimeChk){
				if(attendUserMap.get("outInTime")==null||EgovStringUtil.isEmpty(attendUserMap.get("outInTime").toString())){
					warningText += "퇴근일에 출근기록이 없습니다. 일괄적용시 결근처리될수있습니다.|";
					insertMap.put("warningYn", "Y");
				}
			}

			if(EgovStringUtil.isNotEmpty(insertMap.get("inTimeDate"))&&EgovStringUtil.isNotEmpty(insertMap.get("outTimeDate"))&&workInOutTimeChk){
				String inTimeDate = insertMap.get("inTimeDate");
				String outTimeDate = insertMap.get("outTimeDate");
				if(!inTimeDate.equals(outTimeDate)){
					if(attendUserMap.get("outInTime")==null||EgovStringUtil.isEmpty(attendUserMap.get("outInTime").toString())){
						warningText += "퇴근일에 출근기록이 없습니다. 일괄적용시 결근처리될수있습니다.|";
						insertMap.put("warningYn", "Y");
					}
				}
			}

			//출근 이력.....
			if(attendUserMap.get("inWorkReqType")!=null&&!EgovStringUtil.isEmpty(attendUserMap.get("inWorkReqType").toString())){
				String inWorkReqType = attendUserMap.get("inWorkReqType").toString();
				String workReqAcceptYn = "";
				if(attendUserMap.get("inWorkReqAcceptYn")!=null&&!EgovStringUtil.isEmpty(attendUserMap.get("inWorkReqAcceptYn").toString())){
					workReqAcceptYn = attendUserMap.get("inWorkReqAcceptYn").toString();
				}

				if(inWorkReqType.equals("WORK")){

					String str = "요청";
					if(workReqAcceptYn.equals("Y")) str = "인정";
					else if(workReqAcceptYn.equals("N")) str = "반려";

					warningText+="출근인정 "+str+"|";
					insertMap.put("warningYn", "Y");
				}else if(inWorkReqType.equals("LATE")){
					warningText+="지각인정"+"|";
					insertMap.put("warningYn", "Y");
				}else if(inWorkReqType.equals("NO_WORK")){
					warningText+="결근인정"+"|";
					insertMap.put("warningYn", "Y");
				}
			}

			//출근 이력 관리자
			if(attendUserMap.get("inMngWorkPrcType")!=null&&!EgovStringUtil.isEmpty(attendUserMap.get("inMngWorkPrcType").toString())){
				String inMngWorkPrcType = attendUserMap.get("inMngWorkPrcType").toString();

				if(inMngWorkPrcType.equals("WORK")){
					warningText+="관리자근태처리(출근)"+"|";
					insertMap.put("warningYn", "Y");
				}else if(inMngWorkPrcType.equals("LATE")){
					warningText+="관리자근태처리(지각)"+"|";
					insertMap.put("warningYn", "Y");
				}else if(inMngWorkPrcType.equals("NO_WORK")){
					warningText+="관리자근태처리(결근)"+"|";
					insertMap.put("warningYn", "Y");
				}

			}

			//퇴근일<이력있음은 출근시간없음 이력만 보여주기로함 (17.06.21)
			//퇴근 이력.....
			/*if(attendUserMap.get("outWorkReqType")!=null&&!EgovStringUtil.isEmpty(attendUserMap.get("outWorkReqType").toString())){
				String outWorkReqType = attendUserMap.get("outWorkReqType").toString();
				String workReqAcceptYn = "";
				if(attendUserMap.get("outWorkReqAcceptYn")!=null&&!EgovStringUtil.isEmpty(attendUserMap.get("outWorkReqAcceptYn").toString())){
					workReqAcceptYn = attendUserMap.get("outWorkReqAcceptYn").toString();
				}

				if(outWorkReqType.equals("WORK")){

					String str = "요청";
					if(workReqAcceptYn.equals("Y")) str = "인정";
					else if(workReqAcceptYn.equals("N")) str = "반려";

					warningText+="출근인정 "+str+"|";
					insertMap.put("warningYn", "Y");
				}else if(outWorkReqType.equals("LATE")){
					warningText+="지각인정"+"|";
					insertMap.put("warningYn", "Y");
				}else if(outWorkReqType.equals("NO_WORK")){
					warningText+="결근인정"+"|";
					insertMap.put("warningYn", "Y");
				}
			}

			//퇴근 이력 관리자
			if(attendUserMap.get("outMngWorkPrcType")!=null&&!EgovStringUtil.isEmpty(attendUserMap.get("outMngWorkPrcType").toString())){
				String outMngWorkPrcType = attendUserMap.get("outMngWorkPrcType").toString();

				if(outMngWorkPrcType.equals("WORK")){
					warningText+="관리자근태처리(출근)"+"|";
					insertMap.put("warningYn", "Y");
				}else if(outMngWorkPrcType.equals("LATE")){
					warningText+="관리자근태처리(지각)"+"|";
					insertMap.put("warningYn", "Y");
				}else if(outMngWorkPrcType.equals("NO_WORK")){
					warningText+="관리자근태처리(결근)"+"|";
					insertMap.put("warningYn", "Y");
				}

			}*/
			//******************이력 메세지:E**********************************************************//
		}
		insertMap.put("errorText", errorText);
		insertMap.put("warningText", warningText);
	}

	//엑셀 업로드 일괄처리
	public int processAttendanceExcelInfo(Map<String,Object> paramMap) throws Exception{
		int cnt = 0;

		//업로드한 엑셀의 업로드 대상 출근 기록을 조회한다.
		List<EgovMap> worktimeExcelIntimeList = worktimeDAO.getWorktimeExcelIntimeList(paramMap);

		for(EgovMap workIntimeMap : worktimeExcelIntimeList){
			//type : C 등록 , U 수정
			String type = workIntimeMap.get("type").toString();

			workIntimeMap.put("rgId", paramMap.get("userId"));
			if(type.equals("C")){
				cnt = worktimeDAO.insertWorkTimeForExcelUserIntime(workIntimeMap);
			}else if(type.equals("U")){
				cnt = worktimeDAO.updateWorkTimeForExcelUserIntime(workIntimeMap);
			}

			String endType = workIntimeMap.get("endType").toString();

			if(endType.equals("C")){
				Map<String,Object> endMap = new HashMap<String, Object>();
				endMap.put("orgId", paramMap.get("orgId"));
				endMap.put("userId", paramMap.get("userId"));
				worktimeDAO.insertWorkTimeEndByExcelUpload(endMap);
			}else if(endType.equals("Y")){
				Map<String,Object> endMap = new HashMap<String, Object>();
				endMap.put("applyOrgId", paramMap.get("orgId"));
				endMap.put("orgId", paramMap.get("orgId"));
				endMap.put("searchDate", workIntimeMap.get("inTimeDate"));
				endMap.put("updatedBy", paramMap.get("userId"));

				this.processWorkTimeDayEnd(endMap);
			}
		}

		//업로드한 엑셀의 업로드 대상 퇴근 기록을 조회한다.
		List<EgovMap> worktimeExcelOuttimeList = worktimeDAO.getWorktimeExcelOuttimeList(paramMap);

		for(EgovMap workOuttimeMap : worktimeExcelOuttimeList){
			//type : C 등록 , U 수정
			String type = workOuttimeMap.get("type").toString();

			workOuttimeMap.put("rgId", paramMap.get("userId"));
			if(type.equals("C")){
				log.info("퇴근기록 처리는 반드시 출근기록이 있어야 합니다.");
				cnt = worktimeDAO.insertWorkTimeForExcelUserOuttime(workOuttimeMap);
			}else if(type.equals("U")){
				cnt = worktimeDAO.updateWorkTimeForExcelUserOuttime(workOuttimeMap);
			}

			String endType = workOuttimeMap.get("endType").toString();

			if(endType.equals("C")){
				Map<String,Object> endMap = new HashMap<String, Object>();
				endMap.put("orgId", paramMap.get("orgId"));
				endMap.put("userId", paramMap.get("userId"));
				worktimeDAO.insertWorkTimeEndByExcelUpload(endMap);
			}else if(endType.equals("Y")){
				Map<String,Object> endMap = new HashMap<String, Object>();
				endMap.put("applyOrgId", paramMap.get("orgId"));
				endMap.put("orgId", paramMap.get("orgId"));
				endMap.put("searchDate", workOuttimeMap.get("outTimeDate"));
				endMap.put("updatedBy", paramMap.get("userId"));

				this.processWorkTimeDayEnd(endMap);
			}

		}
		cnt = worktimeDAO.updateWorkTimeExcelApply(paramMap);
		return cnt;
	}
	//엑셀 파일 정보
	public EgovMap getExcelFileInfo(Map<String,Object> paramMap) throws Exception{
		return worktimeDAO.getExcelFileInfo(paramMap);
	}
	//엑셀 파일 다운로드
	public void doFileDownloadExcel( String filePath,String fileNm,String orgFileNm, HttpServletRequest req, HttpServletResponse res) throws Exception{
		File uFile = new File(filePath);
		int fSize = (int) uFile.length();

		if(fSize > 0) {

			String mimetype = "vnd.ms-excel";

			res.setContentType(mimetype);
			setDisposition(orgFileNm, req, res);
			res.setContentLength(fSize);

			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(res.getOutputStream());

				FileCopyUtils.copy(in, out);

			} catch (Exception ex) {
				ex.printStackTrace();
				throw ex;
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (Exception ignore) {
						// no-op
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (Exception ignore) {
						// no-op
					}
				}
			}
		} else {

			PrintWriter writer = res.getWriter();
			writer.print("<html><script>alert(\"FILE NOT FOUND!!\");window.close();</script></html>");

		}
	}
	//출근인정 요청안내 : 메인
	public List<EgovMap> getWorktimeReqAlarmList(Map<String, Object> paramMap) throws Exception {
		return worktimeDAO.getWorktimeReqAlarmList(paramMap);
	}
    // Disposition 지정하기
 	private static void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
 		String browser = getBrowser(request);

 		String dispositionPrefix = "attachment; filename=";
 		String encodedFilename = null;

 		if(browser.equals("MSIE")) encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
 		else if(browser.equals("Firefox")) encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
 		else if(browser.equals("Opera")) encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
 		else if(browser.equals("Chrome")) {
 			StringBuffer sb = new StringBuffer();
 			for(int i = 0; i < filename.length(); i++) {
 				char c = filename.charAt(i);
 				if(c > '~') sb.append(URLEncoder.encode("" + c, "UTF-8"));
 				else sb.append(c);
 			}
 			encodedFilename = sb.toString();
 		}
 		else throw new IOException("Not supported browser");
 		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

 		if("Opera".equals(browser)) response.setContentType("application/octet-stream;charset=UTF-8");
 	}
 	// 브라우저 구분 얻기
 	private static String getBrowser(HttpServletRequest request) {
 		String header = request.getHeader("User-Agent");
 		if(header.indexOf("MSIE") > -1) return "MSIE";
 		else if(header.indexOf("Trident") > -1) return "MSIE";
 		else if(header.indexOf("Chrome") > -1) return "Chrome";
 		else if(header.indexOf("Opera") > -1) return "Opera";
 		return "Firefox";
 	}

}
