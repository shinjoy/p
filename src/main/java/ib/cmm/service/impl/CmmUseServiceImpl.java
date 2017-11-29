package ib.cmm.service.impl;

import ib.cmm.ComCodeVO;
import ib.cmm.ComDefaultCodeVO;
import ib.cmm.service.CmmUseService;
import ib.cmm.service.CmmnDetailCode;
import ib.login.service.StaffVO;
import ib.work.service.WorkService;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * @Class Name : CmmUseServiceImpl.java
 * @Description : 공통코드등 전체 업무에서 공용해서 사용해야 하는 서비스를 정의하기위한 서비스 구현 클래스
 * @Modification Information
 * @version
 * @see
 *
 */
@Service("CmmUseService")
public class CmmUseServiceImpl extends AbstractServiceImpl implements CmmUseService {

    @Resource(name = "CmmUseDAO")
    private CmmUseDAO cmmUseDAO;

    @Resource(name = "comCodeDAO")
    private ComCodeDAO comCodeDAO;

    @Resource(name = "workService")
    private WorkService workService;

    /**
     * 공통코드를 조회한다.
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public List<CmmnDetailCode> selectCmmCodeDetail(ComDefaultCodeVO vo) throws Exception {
	return cmmUseDAO.selectCmmCodeDetail(vo);
    }

    /**
     * ComDefaultCodeVO의 리스트를 받아서 여러개의 코드 리스트를 맵에 담아서 리턴한다.
     *
     * @param voList
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, List<CmmnDetailCode>> selectCmmCodeDetails(List voList) throws Exception {
	ComDefaultCodeVO vo;
	Map<String, List<CmmnDetailCode>> map = new HashMap<String, List<CmmnDetailCode>>();

	Iterator iter = voList.iterator();
	while (iter.hasNext()) {
	    vo = (ComDefaultCodeVO)iter.next();
	    map.put(vo.getCodeId(), cmmUseDAO.selectCmmCodeDetail(vo));
	}

	return map;
    }

    /**
     * 조직정보를 코드형태로 리턴한다.
     *
     * @param 조회조건정보 vo
     * @return 조직정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectOgrnztIdDetail(ComDefaultCodeVO vo) throws Exception {
	return cmmUseDAO.selectOgrnztIdDetail(vo);
    }

    /**
     * 그룹정보를 코드형태로 리턴한다.
     *
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectGroupIdDetail(ComDefaultCodeVO vo) throws Exception {
	return cmmUseDAO.selectGroupIdDetail(vo);
    }
	/**
	 *
	 * @MethodName : commonCdList
	 * @param menuCd
	 * @return
	 * @throws Exception
	 */
	public List<ComCodeVO> commonCdList(String menuCd,String id) throws Exception{
		ComCodeVO Cd = new ComCodeVO();
		Cd.setMenuCd(menuCd);
		Cd.setRgId(id);
		List<ComCodeVO> cmCdList = comCodeDAO.selectComCodeDetailPer(Cd);
		return cmCdList;
	}
	/**
	 *
	 * @MethodName : commonCdList
	 * @param menuCd
	 * @return
	 * @throws Exception
	 */
	public List<ComCodeVO> commonCdList(String menuCd) throws Exception{
		ComCodeVO Cd = new ComCodeVO();
		Cd.setMenuCd(menuCd);
		List<ComCodeVO> cmCdList = comCodeDAO.selectComCodeDetail(Cd);
		return cmCdList;
	}
	/**
	 *
	 * @MethodName : userList
	 * @param menuCd
	 * @return
	 * @throws Exception
	 */
	public Object userList(StaffVO staffVO) throws Exception{
		Map<String, Object> map0 = workService.selectStaffList(staffVO);
		return map0.get("resultList");
	}
}
