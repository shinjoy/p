package ib.control.web;

import ib.basic.web.SCflag;
import ib.cmm.FileUpDbVO;
import ib.cmm.IBsMessageSource;

import ib.cmm.service.CommonService;
import ib.login.service.StaffVO;
import ib.person.service.PersonMgmtService;
import ib.person.service.PersonVO;
import ib.work.service.WorkService;
import ib.work.service.WorkVO;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 *
 * @author  : ChanWoo Lee
 * @since   : 2013. 11. 21.
 * @version : 1.0.0
 *
 * <pre>
 * package  : ib.control.web
 * filename : ControlController.java
 * </pre>
 */
@Controller
public class ControlController {
	/** MessageSource */
    @Resource(name="IBsMessageSource")
    IBsMessageSource MessageSource;

    @Resource(name = "personMgmtService")
    private PersonMgmtService personMgmtService;

    @Resource(name = "workService")
    private WorkService workService;

    @Resource(name = "commonService")
    private CommonService commonService;



	/** log */
    protected static final Log LOG = LogFactory.getLog(ControlController.class);



}