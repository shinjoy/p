package ib.cmm.service.impl;

import ib.cmm.ComCodeVO;
import ib.cmm.service.impl.ComAbstractDAO;
import java.util.List;

import org.springframework.stereotype.Repository;


/**
 * <pre>
 * package  : ib.cmm.service.impl
 * filename : ComCodeDAO.java
 * </pre>
 * 
 * @author  : ChanWoo Lee
 * @since   : 2012. 8. 27.
 * @version : 1.0.0
 */
@Repository("comCodeDAO")
public class ComCodeDAO extends ComAbstractDAO {

    /**
     * 주어진 조건에 따른 공통코드를 불러온다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<ComCodeVO> selectComCodeDetailPer(ComCodeVO vo) throws Exception {
    	return list("comCodeVO.selectComCodeDetailPer", vo);
    }
    @SuppressWarnings("unchecked")
    public List<ComCodeVO> selectComCodeDetail(ComCodeVO vo) throws Exception {
    	return list("comCodeVO.selectComCodeDetail", vo);
    }

}