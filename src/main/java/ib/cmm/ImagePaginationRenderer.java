package ib.cmm;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public ImagePaginationRenderer() {
/*		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><image src=\"/ts/images/btn_p01.gif\" border=0/></a>&#160;";
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><image src=\"/ts/images/btn_p02.gif\" border=0/></a>&#160;";
		currentPageLabel = "<strong>{0}</strong>&#160;";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
		nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><image src=\"/ts/images/btn_p03.gif\" border=0/></a>&#160;";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><image src=\"/ts/images/btn_p04.gif\" border=0/></a>&#160;";
 */
/*
		firstPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"/images/btn_p01.gif\" alt=\"처음\"   border=\"0\"/></a>&#160;";
		previousPageLabel = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"/images/btn_p02.gif\"    alt=\"이전\"   border=\"0\"/></a>&#160;";
		currentPageLabel  = "<strong>{0}</strong>&#160;";
		otherPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a>&#160;";
		nextPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"/images/btn_p03.gif\" alt=\"다음\"  border=\"0\"/></a>&#160;";
		lastPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"/images/btn_p04.gif\" alt=\"마지막\" border=\"0\"/></a>&#160;";
*/
		firstPageLabel    = "<a class='pageBtn' onclick=\"{0}({1},this);return false;\"><img src=\"/images/btn_p01.gif\" alt=\"처음\"   border=\"0\"/></a>";
		previousPageLabel = "<a class='pageBtn' onclick=\"{0}({1},this);return false;\"><img src=\"/images/btn_p02.gif\"    alt=\"이전\"   border=\"0\"/></a>";
		currentPageLabel  = "<b class='pageIdx'>{0}</b>";
		otherPageLabel    = "<a class='pageIdx' onclick=\"{0}({1},this);return false;\">{2}</a>";
		nextPageLabel     = "<a class='pageBtn' onclick=\"{0}({1},this);return false;\"><img src=\"/images/btn_p03.gif\" alt=\"다음\"  border=\"0\"/></a>";
		lastPageLabel     = "<a class='pageBtn' onclick=\"{0}({1},this);return false;\"><img src=\"/images/btn_p04.gif\" alt=\"마지막\" border=\"0\"/></a>";
	}

	public void initVariables(){
/*
		firstPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/btn_p01.gif\" alt=\"처음\"   border=\"0\"/></a>&#160;";
        previousPageLabel = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/btn_p02.gif\"    alt=\"이전\"   border=\"0\"/></a>&#160;";
        currentPageLabel  = "<strong>{0}</strong>&#160;";
        otherPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a>&#160;";
        nextPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/btn_p03.gif\" alt=\"다음\"   border=\"0\"/></a>&#160;";
        lastPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/btn_p04.gif\" alt=\"마지막\" border=\"0\"/></a>&#160;";
*/
		firstPageLabel    = "<a class='pageBtn' onclick=\"{0}({1},this);return false;\"><img src=\"" + servletContext.getContextPath() +  "/images/btn_p01.gif\" alt=\"처음\"   border=\"0\"/></a>";
        previousPageLabel = "<a class='pageBtn' onclick=\"{0}({1},this);return false;\"><img src=\"" + servletContext.getContextPath() +  "/images/btn_p02.gif\"    alt=\"이전\"   border=\"0\"/></a>";
        currentPageLabel  = "<b class='pageIdx'>{0}</b>";
        otherPageLabel    = "<a class='pageIdx' onclick=\"{0}({1},this);return false;\">{2}</a>";
        nextPageLabel     = "<a class='pageBtn' onclick=\"{0}({1},this);return false;\"><img src=\"" + servletContext.getContextPath() +  "/images/btn_p03.gif\" alt=\"다음\"   border=\"0\"/></a>";
        lastPageLabel     = "<a class='pageBtn' onclick=\"{0}({1},this);return false;\"><img src=\"" + servletContext.getContextPath() +  "/images/btn_p04.gif\" alt=\"마지막\" border=\"0\"/></a>";
	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}