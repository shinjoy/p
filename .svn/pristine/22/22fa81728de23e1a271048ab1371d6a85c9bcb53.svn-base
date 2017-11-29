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
public class IbPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public IbPaginationRenderer() {

	}

	public void initVariables(){

		firstPageLabel    = "<button type='button' onclick=\"{0}({1});return false; \" class='pre_end_btn'><em>맨처음 페이지</em></button>";
		previousPageLabel = "<button type='button' onclick=\"{0}({1});return false; \" class='pre_btn'><em>이전 페이지</em></button>";
		currentPageLabel  = "<span class='current'><a href='#'>{0}</a></span>";
		otherPageLabel    = "<span><a href=\"javascript:{0}({1},this);\">{2}</a></span>";
		nextPageLabel     = "<button type='button' onclick=\"{0}({1});return false; \" class='next_btn'><em>다음 페이지</em></button>";
		lastPageLabel     = "<button type='button' onclick=\"{0}({1});return false; \" class='next_end_btn'><em>맨마지막 페이지</em></button>";
	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
