package ib.file.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface FileService {

	//파일 리스트
	public List<Map> getFileList(Map<String, Object> map) throws Exception;
	//파일 저장 jsonArray 로 다중 넘김
	public int insertFileListJson(Map<String, Object> map) throws Exception;
	//파일 update -> delFlag : Y
	public void updateDelFlag(Map<String, Object> map) throws Exception;
	//파일 물리 삭제
	public int deleteFile(Map<String, Object> map) throws Exception;
	//파일 다운로드
	public void doFileDownload( String filePath,String fileNm,String orgFileNm, HttpServletRequest req, HttpServletResponse res) throws Exception;

	//기존 프로필사진이 있다면 DELETE
	public int deleteUserProfileImg(Map<String, Object> map) throws Exception;
	//userId 프로필 사진의 fileSeq 조회
	public int getUserProfileImgSeq(Map<String, Object> map) throws Exception;

	//파일 저장 for Editor..
	public int insertFileList(Map<String, Object> map) throws Exception;

}
