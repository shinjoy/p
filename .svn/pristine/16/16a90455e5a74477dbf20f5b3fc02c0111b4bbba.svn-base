package ib.file.service.impl;

import java.util.List;
import java.util.Map;

import ib.cmm.service.impl.ComAbstractDAO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("fileDAO")
public class FileDAO extends ComAbstractDAO{

	//파일리스트
	public List<Map> getFileList(Map<String, Object> param) throws Exception{
		return list("file.getFileList",param);
	}

	//파일 DB 등록
	public int insertFileList(Map<String, Object> param) throws Exception{
		return  Integer.parseInt(insert("file.insertFileList", param).toString());
	}

	//파일 update -> delFlag : Y
	public void updateDelFlag(Map<String, Object> param) throws Exception{
		update("file.updateDelFlag", param);
	}

	//파일 update -> delFlag : Y 유저프로필
	public void updateDelFlagUserProfileImg(Map<String, Object> param) throws Exception{
		update("file.updateDelFlagUserProfileImg", param);
	}

	//userId 프로필 사진의 fileSeq 조회
	public int getUserProfileImgSeq(Map<String, Object> map) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("file.getUserProfileImgSeq", map);
	}

}
