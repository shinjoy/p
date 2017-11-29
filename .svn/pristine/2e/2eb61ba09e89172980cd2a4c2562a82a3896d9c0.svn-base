package ib.basic.web;

import ib.cmm.FileUpDbVO;
import ib.work.service.impl.WorkDAO;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * <pre>
 * package  : ib.basic.service.impl
 * filename : MultiFileUpload.java
 * </pre>
 *
 * @author  : ChanWoo Lee
 * @since   : 2014. 4. 16.
 * @version : 1.0.0
 */
public class MultiFileUpload {

    @Resource(name = "workDAO")
    private WorkDAO workDAO;


    private String folderPath2;



	protected static final Log logger = LogFactory.getLog(MultiFileUpload.class);


	public MultiFileUpload(String path){
		folderPath2 = path;
	}

	/**
	 * 멀티파일 업로드

	 * @MethodName : fileUpload
	 * @param multi
	 * @param vo
	 * @param request
	 * @throws Exception
	 */
	public FileUpDbVO fileUpload(MultipartHttpServletRequest multi, FileUpDbVO vo
			, HttpServletRequest request , WorkDAO workDAO ) throws Exception {
		// 업로드한 파일들을 Enumeration 타입으로 반환
		// Enumeration형은 데이터를 뽑아올때 유용한 인터페이스 Enumeration객체는 java.util 팩키지에 정의 되어있으므로
		// java.util.Enumeration을 import 시켜야 한다.
		//Enumeration files = multi.getFileNames();

		String folderPath = "";// 파일이 저장될 경로
		folderPath = folderPath2;
		vo.setPath(folderPath);

	    File f = new File(folderPath);
	    f.mkdirs();//파일 저장될 폴더 생성

		try{
			// 넘어온 파일을 리스트로 저장
			List<MultipartFile> files = multi.getFiles("files-upload");
			if (files.size() == 1 && files.get(0).getOriginalFilename().equals("")) {

	        } else {
	            for (int i = 0; i < files.size(); i++) {
	                String originalfileName = files.get(i).getOriginalFilename();
	                if("".equals(originalfileName) || originalfileName==null){
	                	continue;
	                }

	                if(originalfileName!=null){
	                	//File fUpload = new File(folderPath + "/" + originalfileName);//파일경로/파일명
	                	//long fileSize = fUpload.length();//파일사이즈
	                	String newFileName = "" + (System.currentTimeMillis() + 1);//새이름
	                	//File fNewname1 = new File(folderPath+"/" + newFileName);
	                	//fUpload.renameTo(fNewname1);
	                	String savePath = folderPath+"/" + newFileName; //저장 될 파일 경로/이름

	                	files.get(i).transferTo(new File(savePath)); // 파일 저장

	                	vo.setRealName(originalfileName.replace(",","_"));
	                	vo.setMakeName(newFileName);
	                	transDB(vo, workDAO);
	                }else{
	                	System.out.println("----------------\n파일이름 가져오지 못함\n-----------------");
	                }
	            }
	        }
		}catch(Exception e){
			e.printStackTrace();
		}
		return vo;
	}

	/**
	 * 멀티파일 업로드

	 * @MethodName : fileUpload
	 * @param multi
	 * @param vo
	 * @param request
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public FileUpDbVO fileUpload(MultipartHttpServletRequest multi, FileUpDbVO vo
			, HttpServletRequest request) throws Exception {
		// 업로드한 파일들을 Enumeration 타입으로 반환
		// Enumeration형은 데이터를 뽑아올때 유용한 인터페이스 Enumeration객체는 java.util 팩키지에 정의 되어있으므로
		// java.util.Enumeration을 import 시켜야 한다.
		//Enumeration files = multi.getFileNames();

		String folderPath = "";// 파일이 저장될 경로
		vo.setPath(folderPath);

	    File f = new File(folderPath);
	    f.mkdirs();//파일 저장될 폴더 생성

		try{
			// 넘어온 파일을 리스트로 저장
			List<MultipartFile> files = multi.getFiles("files-upload");
			if (files.size() == 1 && files.get(0).getOriginalFilename().equals("")) {

	        } else {
	            for (int i = 0; i < files.size(); i++) {
	                String originalfileName = files.get(i).getOriginalFilename();
	                if("".equals(originalfileName) || originalfileName==null){
	                	continue;
	                }

	                if(originalfileName!=null){
	                	//File fUpload = new File(folderPath + "/" + originalfileName);//파일경로/파일명
	                	//long fileSize = fUpload.length();//파일사이즈
	                	String newFileName = "" + (System.currentTimeMillis() + 1);//새이름
	                	//File fNewname1 = new File(folderPath+"/" + newFileName);
	                	//fUpload.renameTo(fNewname1);
	                	String savePath = folderPath+"/" + newFileName; //저장 될 파일 경로/이름

	                	files.get(i).transferTo(new File(savePath)); // 파일 저장

	                	vo.setRealName(originalfileName.replace(",","_"));
	                	vo.setMakeName(newFileName);
	                	transDB(vo, workDAO);
	                }else{
	                	System.out.println("----------------\n파일이름 가져오지 못함\n-----------------");
	                }
	            }
	        }
		}catch(Exception e){
			e.printStackTrace();
		}
		return vo;
	}

	/**
	 * 파일 DB 입력
	 * @MethodName : transDB
	 * @param vo
	 * @throws Exception
	 */
	public void transDB(FileUpDbVO vo, WorkDAO dao) throws Exception{
		try{
			dao.insertFileInfo(vo);
			logger.debug(vo.getRgId()+"^_^dao.insertFileInf^_^"+vo.getRealName());
		}catch(Exception e){
			logger.error(e);
			e.printStackTrace();
		}
	}
	/**
	 * 파일 DB update
	 * @MethodName : uploadDB
	 * @param vo
	 * @param dao
	 * @throws Exception
	 */
	public void uploadDB(FileUpDbVO vo, WorkDAO dao) throws Exception{
		try{
			dao.updateFileInfo(vo);
			logger.debug(vo.getRgId()+"^_^dao.updateFileInfo^_^"+vo.getRealName());
		}catch(Exception e){
			logger.error(e);
			e.printStackTrace();
		}
	}


}