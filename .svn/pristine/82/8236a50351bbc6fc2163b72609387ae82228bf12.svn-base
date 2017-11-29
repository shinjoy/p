package ib.cmm.web;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ib.basic.web.SCflag;
import ib.cmm.service.FileMngService;
import ib.cmm.service.FileVO;
import ib.cmm.service.UserDetailsHelper;


/**
 * <pre>
 * package	: ib.cmm.web 
 * filename	: FileRealNmChngController.java
 * </pre>
 * 
 * 
 * 
 * @author	: oys
 * @date	: 2016. 8. 25.
 * @version : 
 *
 */
@Controller
public class FileRealNmChngController {
	
	 

    @Resource(name = "FileMngService")
    private FileMngService fileMngService;

    
    private static final Logger LOG = Logger.getLogger(FileRealNmChngController.class.getName());


    
    /**
     * 파일 원본 파일로 일괄 변환
     *
     * @param		: 
     * @return		: 
     * @exception	: 
     * @author		: oys
     * @date		: 2016. 8. 25.
     */
    @RequestMapping("/file/genOriginFile.do")
    public void selectFileInfs(HttpServletRequest request,
						HttpServletResponse response,
						HttpSession session, ModelMap model,
						@RequestParam Map<String,String> map) throws Exception {
try{		
    	String folderPath = "d:\\OriginFile";	//파일 경로
		
		
	    File f = new File(folderPath);
	    //f.mkdirs();//파일 저장될 폴더 생성

	    
	    List<Map<String,String>> list = fileMngService.getFileListForOri();
	    			
        for (int i=0; i < list.size(); i++) {
        	Map<String,String> file = list.get(i);
            String realNm = file.get("realNm");
            String makeNm = file.get("makeNm");
            String rgId = file.get("rgId");
            
            String prePath = folderPath + "/" + makeNm; 					//변환 전 파일 경로/이름
        	String savePath = folderPath + "\\" + rgId + "\\" + i + "/" + realNm; 	//저장 될 파일 경로/이름
        	
        	File pre = new File(prePath);
        	File post = new File(savePath);
        	
        	if(pre.exists()){        		
        		new File(folderPath + "\\" + rgId + "\\" + i).mkdirs(); 
        		pre.renameTo(post);
        	}
        	
        }
	    
    	
}catch(Exception e){
	e.printStackTrace();
	throw e;
}
    
    }

}