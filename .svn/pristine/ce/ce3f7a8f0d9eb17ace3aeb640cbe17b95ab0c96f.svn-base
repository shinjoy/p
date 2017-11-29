package ib.file.web;


import ib.cmm.util.sim.service.AjaxResponse;
import ib.file.service.FileService;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileController {

	@Resource(name = "fileService")
	private FileService fileService;

	@Value("${Globals.fileStorePath}")
	private String globalsFolderPath;

	protected static final Log logger = LogFactory.getLog(FileController.class);

	// 게시판 글 파일 리스트
	@RequestMapping(value = "/file/getFileList.do")
	public void getFileList(HttpSession session,
		@RequestParam Map<String,Object>map, Model model,HttpServletResponse response) throws Exception {

		List<Map>list = fileService.getFileList(map);
		AjaxResponse.responseAjaxSelect(response, list);
	}

	//파일 업로드
	@RequestMapping(value="/file/uploadFiles.do")
	public void uploadFiles(MultipartHttpServletRequest request,HttpServletResponse response,
			HttpSession session) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		List<Map> resultList = new ArrayList();
		List<MultipartFile> fileList = request.getFiles("shadowFile");//getFileNames();

		int i=0;

		String folderPath = globalsFolderPath;

		//os가 리눅스면 D:를 제거한다
		if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") < 0)
        {
			if(folderPath.indexOf("D:")>=0){
				folderPath = folderPath.split("D:")[1];
			}
        }

		//관계사 ORG_CODE를 경로에 포함시킨다.
		if(baseUserLoginInfo.get("orgCode") != null){
			folderPath = folderPath + baseUserLoginInfo.get("orgCode").toString() +"/";
		}

		//저장폴더에 년도 추가
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date(System.currentTimeMillis()) );
		String farmatYear = new SimpleDateFormat("yyyy").format( cal.getTime() );
		folderPath = folderPath + farmatYear +"/";


		for(int j=0;j<fileList.size();j++){
  			String fileNm = fileList.get(j).getOriginalFilename();
  			String orgFileName = fileNm.replaceAll(",", "");
  			String saveFileName = System.currentTimeMillis() + "_" + orgFileName;

  			File f = new File(folderPath);
  		  	f.mkdirs();//파일 저장될 폴더 생성
  			File uploadFile = new File(folderPath + saveFileName);

  			fileList.get(j).transferTo(uploadFile);
  			HashMap<String, Object>map = new HashMap();
  			//map.put("contentId", contentId);
			map.put("orgFileNm", orgFileName);
			map.put("newFileNm", saveFileName);
			map.put("filePath", folderPath);
			map.put("fileSize", fileList.get(j).getSize());

			resultList.add(i, map);
			i++;
  		}
  		AjaxResponse.responseAjaxSelect(response, resultList);

	}


	//에디터 파일 업로드
	@RequestMapping(value="/file/uploadFilesForEdior.do")
	public void uploadFilesForEdior(MultipartHttpServletRequest request,HttpServletResponse response,
			HttpSession session) throws Exception{

		Map baseUserLoginInfo = (Map)session.getAttribute("baseUserLoginInfo");

		List<MultipartFile> fileList = request.getFiles("shadowFile");//getFileNames();


		String folderPath = globalsFolderPath;

		//os가 리눅스면 D:를 제거한다
		if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") < 0)
        {
			if(folderPath.indexOf("D:")>=0){
				folderPath = folderPath.split("D:")[1];
			}
        }

		//관계사 ORG_CODE를 경로에 포함시킨다.
		if(baseUserLoginInfo.get("orgCode") != null){
			folderPath = folderPath + baseUserLoginInfo.get("orgCode").toString() +"/";
		}

		//저장폴더에 년도 추가
		Calendar cal = Calendar.getInstance();
		cal.setTime( new Date(System.currentTimeMillis()) );
		String farmatYear = new SimpleDateFormat("yyyy").format( cal.getTime() );
		folderPath = folderPath + farmatYear +"/";


		String fileNm = fileList.get(0).getOriginalFilename();
		String orgFileName = fileNm.replaceAll(",", "");
		String saveFileName = System.currentTimeMillis() + "_" + orgFileName;

		File f = new File(folderPath);
	  	f.mkdirs();//파일 저장될 폴더 생성
		File uploadFile = new File(folderPath + saveFileName);

		fileList.get(0).transferTo(uploadFile);
		HashMap<String, Object>map = new HashMap();
		//map.put("contentId", contentId);
		map.put("orgFileNm", orgFileName);
		map.put("newFileNm", saveFileName);
		map.put("filePath", folderPath);
		map.put("fileSize", fileList.get(0).getSize());

		int seq =0;

		map.put("uploadType", "EDITOR");

		seq=fileService.insertFileList(map);

		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("seq", seq);
		returnMap.put("fileOrgnNm", orgFileName);
		returnMap.put("volume", fileList.get(0).getSize());

  		AjaxResponse.responseAjaxObject(response, returnMap);

	}

	//파일 다운로드(전체 to zip)
	@RequestMapping(value="/file/downFilesTozip.do")
	public void downFiles(
			@RequestParam Map<String,Object> map,
			HttpServletResponse response,
			HttpSession session) throws Exception{
		//logger.debug("################ fileController.downFilesTozip() ##########");
		// 헤더설정


		List<File> files = new ArrayList();
		if (!map.get("downFileList").equals("")) {

			String[] arr = map.get("downFileList").toString().split(","); // 다운 파일 리스트
			map.put("fileArr", arr);
			List<Map> list = fileService.getFileList(map);

			for (int i = 0; i < list.size(); i++) {
				String filePath = list.get(i).get("filePath").toString();
				String fileNm = list.get(i).get("newFileNm").toString();
				files.add(new File(filePath + fileNm));
			}
		}
		int cnt =0;

		///파일 있는지 없는지 체크

		for (File file : files) {
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(file);
			}catch (FileNotFoundException fnfe) { // 파일없을때
				cnt++;
			}

		}


		if(cnt ==0){	//전부 존재하는 파일이면
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename= "+ System.currentTimeMillis() + ".zip");
			ServletOutputStream out = response.getOutputStream();
			//압축 파일 중에 한글명으로된 파일이 있는 경우 zip 파일로 압축되지 않는 부분 수정.
			ZipOutputStream zos = new ZipOutputStream(new BufferedOutputStream(out));// zip
			zos.setEncoding("EUC-KR");

			for (File file : files) {
				System.out.println(file.getName());
				String filename = file.getName();

				zos.putNextEntry(new ZipEntry(filename));
				FileInputStream fis = null;
				try {
					fis = new FileInputStream(file);

					BufferedInputStream fif = new BufferedInputStream(fis);
					IOUtils.copy(fif, zos);
					zos.closeEntry();
					if (fis != null)
						fis.close();
				} catch (FileNotFoundException fnfe) { // 파일없을때
					PrintWriter writer = response.getWriter();
					writer.print("<html><script>alert(\"FILE NOT FOUND!!\");history.back();</script></html>");
					//return false;
					//zos.write(("ERRORld not find file " + file.getName()).getBytes());
					//fnfe.printStackTrace();
					//continue;
				}

			}
			zos.finish();
			zos.close();

		}else{	// 파일없을때
			PrintWriter writer = response.getWriter();
			writer.print("<html><script>alert(\"FILE NOT FOUNT!!\");history.back();</script></html>");
		}

	}


	// 파일 다운로드
	@RequestMapping(value = "/file/downFile.do")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletRequest req, HttpServletResponse res) throws Exception {
		//logger.debug("################ fileController.fileDown() ##########");
		map.put("fileSeq", map.get("downFileList").toString());
		map.put("uploadId", (map.get("uploadId")==null ? "" : map.get("uploadId")));
		List<Map>list = fileService.getFileList(map);

		String getfileNm = list.get(0).get("newFileNm").toString();
		String orgfileNm = list.get(0).get("orgFileNm").toString();
		String filePath = list.get(0).get("filePath").toString();
		fileService.doFileDownload(filePath,getfileNm,orgfileNm, req, res);

	}


	//파일 삭제
	@RequestMapping(value="/file/deleteFile.do")
	public void deleteFile(HttpServletResponse response,
			@RequestParam Map<String,Object>map,
			HttpSession session,ModelMap model) throws Exception{

		int cnt = fileService.deleteFile(map);			//파일 물리적 삭제

  		AjaxResponse.responseAjaxSave(response, cnt);

	}





}