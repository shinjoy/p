package ib.schedule.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import ib.schedule.service.CusVO;

public class Utill {

	protected static final Log LOG = LogFactory.getLog(Utill.class);

	// 모바일웹에서 글 등록시 한글 깨짐 해결
	public static String koreanEncoding(String Val) throws Exception {
		String korean = null;
		if (Val == null ) return null;

		try {
			korean = new String(new String(Val.getBytes("8859_1"), "KSC5601"));
		}
		catch( UnsupportedEncodingException e ){
			korean = new String(Val);
		}
		return korean;
	}

	public static String getBrowserName(HttpServletRequest req) {
		String header = req.getHeader("User-Agent");
		if(header.indexOf("MSIE") > -1) return "MSIE";
		else if(header.indexOf("Trident") > -1) return "MSIE";
		else if(header.indexOf("Chrome") > -1) return "Chrome";
		else if(header.indexOf("Opera") > -1) return "Opera";
		return "Firefox";
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



	// 파일명 변경
	public static String upFileReName(MultipartFile file, String FileNm, String FilePath) throws Exception {
		String OnlyFileNm = FileNm.substring(0, FileNm.lastIndexOf('.'));				// 확장자제거 파일명
		String OnlyFileExt = FileNm.substring(FileNm.lastIndexOf('.') + 1);				// 확장자
		String FileUpNm = OnlyFileNm + System.currentTimeMillis() + "." + OnlyFileExt;	// 업로드된 파일명
		File OldFile = new File(FilePath + "\\" + FileNm);
		if(file.isEmpty()) {
			File NewFile = new File(FilePath + "/" + FileUpNm);
			OldFile.renameTo(NewFile);
			FileUpNm = NewFile.getName();
		}
		return FileUpNm;
	}

	// 특수문자 치환
	public static String specialStrChange(String str) throws Exception {
		// '<', '>' 특수문자 HTML언어로 변경
		str = str.replaceAll("&lt;", "<").replaceAll("&gt;", ">");
		// '(', ')' 특수문자 HTML언어로 변경
		str = str.replaceAll("&#40;", "\\(").replaceAll("&#41;", "\\)");
		// 더블쿼테이션(") 특수문자 HTML언어로 변경
		str = str.replaceAll("&quot;", "\"");
		// 싱글쿼테이션(") 특수문자 HTML언어로 변경
		str = str.replaceAll("&apos;", "\'");
		str = str.replaceAll("&amp;", "&");
		return str;
	}

	// 파일 다운로드
	public static void fileDownload(String FilePath, String FileUpNm, String FileNm, HttpServletRequest req, HttpServletResponse res) throws Exception {
		File uFile = new File(FilePath, FileUpNm);
		int fSize = (int) uFile.length();

		if(fSize > 0) {
			String OnlyFileExt = FileNm.substring(FileNm.lastIndexOf('.') + 1).toLowerCase();	// 확장자
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
			System.out.println("mimetype============"+mimetype);
			res.setContentType(mimetype);
			setDisposition(FileNm, req, res);
			res.setContentLength(fSize);

			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(res.getOutputStream());

				FileCopyUtils.copy(in, out);
				out.flush();
			} catch (Exception ex) {
				LOG.debug("IGNORED: " + ex.getMessage());
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (Exception ignore) {
						// no-op
						LOG.debug("IGNORED: " + ignore.getMessage());
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (Exception ignore) {
						// no-op
						LOG.debug("IGNORED: " + ignore.getMessage());
					}
				}
			}
		} else {
			res.setContentType("application/x-msdownload");
			PrintWriter printwriter = res.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + FileNm + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
	}

	// 파일 복사
	public static void fileCopy(String srcFolder, String targetFolder, String fileName) throws Exception{
    	String inFileName = srcFolder+"/"+fileName;
    	String outFileName = targetFolder+"/"+fileName;

    	File f = new File(targetFolder);
	    if(!f.exists() || f.isFile()) {
	    	f.mkdirs(); // 폴더 없으면 폴더 생성
	    	System.out.println("폴더생성중...");
	    }
	    else System.out.println("폴더 있어서 생성 안함!!"+targetFolder);

    	try {
    		File FileFlag = new File(targetFolder + "/" + fileName);
    		if(!FileFlag.isFile()) {	// 파일 없으면 파일 복사
    			FileInputStream fis = new FileInputStream(inFileName);
        		FileOutputStream fos = new FileOutputStream(outFileName);

        		int data = 0;
        		while((data=fis.read())!=-1) {
        			fos.write(data);
        		}

        		fis.close();
        		fos.close();
        		System.out.println("파일복사중...");
    		}
    		else System.out.println("파일 있어서 복사 안함!!");
    	}
    	catch (Exception e) {
    		LOG.error(e);
    		e.printStackTrace();
    	}
    }

	// 파일 삭제
	public static void fileDel(String srcFolder, String fileName) throws Exception {
		System.out.println("FileDel");
		try {
			File f = new File(srcFolder+"\\"+fileName);
	    	if(f.delete()) System.out.println("파일 삭제 중..");
	    	else System.out.println("파일 삭제 에러..");
		}
		catch(Exception e) {
			LOG.error(e);
    		e.printStackTrace();
		}
	}

	// HTML 파일 생성
	public static CusVO createHtmlFile(CusVO vo) {
		File FileDir = new File(vo.getFilePath());
		if(!FileDir.exists() || FileDir.isFile()) FileDir.mkdirs();
		String OnlyFileNm = vo.getDocNm().substring(0, vo.getDocNm().length() - 5);							// 확장자제거 파일명
		String OnlyFileExt = vo.getDocNm().substring(vo.getDocNm().length() - 5, vo.getDocNm().length());	// 확장자
		String FileUpNm = OnlyFileNm + System.currentTimeMillis() + OnlyFileExt;							// 업로드된 파일명
		URL url = null;
		try {
			url = new URL(vo.getUrl());
		}
		catch(MalformedURLException el) {
			System.out.println(el);
			System.exit(1);
		}
		FileOutputStream fos = null;
		try {
			InputStream in = url.openStream();	//  url의 내용을 openStream()으로 읽어 들인다.
			fos = new FileOutputStream(vo.getDocNm());
			byte[] buffer = new byte[512];
			int readcount = 0;

			while((readcount = in.read(buffer)) != -1)  {
				fos.write(buffer, 0, readcount);
			}
		}
		catch (Exception ex) {
			System.out.println(ex);
		}
		finally {
			try {
				if(fos != null) fos.close();
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}

		try {
			FileInputStream fis = new FileInputStream(vo.getDocNm());
			fos = new FileOutputStream(vo.getFilePath() + "\\" + FileUpNm);

			int data = 0;
			while((data=fis.read())!=-1) {
				fos.write(data);
			}
			fis.close();
			fos.close();

			File I = new File(vo.getDocNm());	// 복사한뒤 원본파일을 삭제함
			I.delete();
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		File file = new File(FileDir.toString() + "/" + FileUpNm);
		vo.setFileNm(vo.getDocNm());
		vo.setFileUpNm(FileUpNm); // 파일명 변경
		vo.setFileSize(file.length());
		vo.setFileOrder(1);
		return vo;
	}

	// 오늘 날짜 받아오기
	public static String today(String Type) {
		Calendar calendar = Calendar.getInstance();
		String Year = Integer.toString(calendar.get(Calendar.YEAR));
		String Month = Integer.toString(calendar.get(Calendar.MONTH) + 1);
		String Date = Integer.toString(calendar.get(Calendar.DAY_OF_MONTH));
		String PreYear = Integer.toString(calendar.get(Calendar.YEAR) - 1);
		String PreMonth = "";
		if(calendar.get(Calendar.MONTH) < 1) PreMonth = "12";
		else PreMonth = Integer.toString(calendar.get(Calendar.MONTH));

		String[] Week = {"일", "월", "화", "수", "목", "금", "토"};
		String DayOfWeek = Week[calendar.get(Calendar.DAY_OF_WEEK) - 1];

		if(Month.length() == 1) Month = "0" + Month;
		if(PreMonth.length() == 1) PreMonth = "0" + PreMonth;
		if(Date.length() == 1) Date = "0" + Date;

		String ReStr;
		if(Type.equals("Today")) ReStr = Year + "-" + Month + "-" + Date;
		else if(Type.equals("Year")) ReStr = Year;
		else if(Type.equals("Month")) ReStr = Month;
		else if(Type.equals("PreYear")) ReStr = PreYear;
		else if(Type.equals("PreMonth")) ReStr = PreMonth;
		else if(Type.equals("Date")) ReStr = Date;
		else ReStr = DayOfWeek;
		return ReStr;
	}

	// 날짜 계산하기
	public static String dateCalcu(String RealDate, String CalcuType, int Val) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date SDate = formatter.parse(RealDate);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(SDate);

		if(CalcuType.equals("year")) calendar.add(Calendar.YEAR, Val);
		else if(CalcuType.equals("month")) calendar.add(Calendar.MONTH, Val);
		else if(CalcuType.equals("day")) calendar.add(Calendar.DATE, Val);

		String Year = Integer.toString(calendar.get(Calendar.YEAR));
		String Month = Integer.toString(calendar.get(Calendar.MONTH) + 1);
		String Date = Integer.toString(calendar.get(Calendar.DAY_OF_MONTH));
		if(Month.length() == 1) Month = "0" + Month;
		if(Date.length() == 1) Date = "0" + Date;
		return Year + "-" + Month + "-" + Date;
	}

	// 매도시 매도 계산 기간 받아오기
	public static int periodCalcu(String InvestDate, String SubCateCd) throws Exception {
		int Period = 0;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date = formatter.parse(InvestDate);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);

		if(calendar.get(Calendar.DAY_OF_WEEK) == 2 || calendar.get(Calendar.DAY_OF_WEEK) == 3 || calendar.get(Calendar.DAY_OF_WEEK) == 4) { // 월, 화, 수
			if(SubCateCd.equals("2") || SubCateCd.equals("3")) Period = 2; // 주식, 워런트
			else Period = 1;
		}
		else if(calendar.get(Calendar.DAY_OF_WEEK) == 5) { // 목
			if(SubCateCd.equals("2") || SubCateCd.equals("3")) Period = 4;
			else Period = 1;
		}
		else if(calendar.get(Calendar.DAY_OF_WEEK) == 6) { // 금
			if(SubCateCd.equals("2") || SubCateCd.equals("3")) Period = 4;
			else Period = 3;
		}
		return Period;
	}


	// 메일 전송 완료
	public static boolean mailSendEnd(final String gmailId, final String gmailPw, String Title, Multipart Con, String SePerEMail, String SePerNm, InternetAddress[] RePerList) throws Exception {
		boolean result = false;
		Properties props = new Properties();
		System.out.println("비번==="+gmailPw+"===");
		try {
			props.put("mail.smtp.starttls.enable","true");
			props.put("mail.smtp.auth", "true");												// 인증여부
			props.put("mail.transport.protocol","smtp");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");		// SMTP 서버가 구글일경우 꼭 기재
			props.put("mail.smtp.port", "465");													// SSL 인증이 필요 없다면 미기재
//			props.put("mail.smtp.user", "발송자 메일");
//			props.put("mail.smtp.from", "리턴메일");

//			Authenticator auth = new SMTPAuthenticator();
//			Session session = Session.getDefaultInstance(props, auth);
			Session session = Session.getInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(gmailId, gmailPw);
				}
			});
		   	session.setDebug(true);

	      	Message msg = new MimeMessage(session);
	      	msg.setFrom(new InternetAddress(SePerEMail, MimeUtility.encodeText(SePerNm,"UTF-8","B")));	// 발신자 설정

	      	InternetAddress[] address = RePerList;
			msg.setRecipients(Message.RecipientType.TO, address);										// 받는 사람설정

			msg.setSubject(MimeUtility.encodeText(Title,"UTF-8","B"));									// 제목 설정
			msg.setSentDate(new java.util.Date());														// 보내는 날짜 설정
			msg.setContent(Con,"text/html;charset=UTF-8");												// 내용 설정 (HTML 형식)
			Transport.send(msg);																		// 메일 보내기
			result = true;
		}
		catch(MessagingException ex) {
			System.out.println("MessagingException:"+ex);
			ex.printStackTrace();
		}
		catch(Exception e) {
			System.out.println("Exception:"+e);
			e.printStackTrace();
		}
		return result;
	}


	public static Object createJSON(List list) throws Exception {
		List<Map<String, Object>> datalist = list;
		JSONObject jsonObject = new JSONObject();
		JSONArray cell = new JSONArray();

		for(int oOo = 0; oOo < datalist.size(); oOo++) {
			JSONObject obj = new JSONObject();
			Iterator<String> keys = datalist.get(oOo).keySet().iterator();
			while( keys.hasNext() ){
	            String key = keys.next();
	            System.out.println( String.format("키 : %s, 값 : %s", key, datalist.get(oOo).get(key)) );
	            obj.put(key, datalist.get(oOo).get(key));
	        }
			cell.add(obj);
		}
		jsonObject.put("rows", cell);
		return jsonObject.get("rows");
	}

	// JSON 객체 생성
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Object createJSON(List list, String Value, String Data, HttpServletRequest req) throws Exception {
		List<Map<String, Object>> datalist = list;
		JSONObject jsonObject = new JSONObject();
		JSONArray cell = new JSONArray();

		for(int oOo = 0; oOo < datalist.size(); oOo++) {
			JSONObject obj = new JSONObject();
			obj.put("value", datalist.get(oOo).get(Value).toString());
			obj.put("data", datalist.get(oOo).get(Data).toString());
			cell.add(obj);
		}
		jsonObject.put("rows", cell);
		return jsonObject.get("rows");
	}

	// 숫자 금액 한글 금액 변경
	public static String convertHangul(String money) {
		String[] han1 = {"","일","이","삼","사","오","육","칠","팔","구"};
		String[] han2 = {"","십","백","천"};
		String[] han3 = {"","만","억","조","경"};

		StringBuffer result = new StringBuffer();
		int len = money.length();
		for(int oOo = len - 1; oOo >= 0; oOo--) {
			result.append(han1[Integer.parseInt(money.substring(len - oOo - 1, len - oOo))]);
			if(Integer.parseInt(money.substring(len - oOo - 1, len - oOo)) > 0) result.append(han2[oOo % 4]);
			if(oOo % 4 == 0) result.append(han3[oOo / 4]);
		}
		return result.toString().replace("억만", "억").replace("조억", "조");
	}

	// Request시 null 값 체크
	public static String valSet(String Val) {
		if(Val.equals("")) return "0";
		else return Val;
	}
}