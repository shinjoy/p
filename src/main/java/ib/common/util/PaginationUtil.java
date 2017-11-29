package ib.common.util;

import java.util.Map;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


public class PaginationUtil {
	/**
     * Paging 기본정보를 셋팅한 PaginationInfo 를 리턴한다.
     *
     * @param paramMap : page기본정보를 가지고있는 맵
     * @param recordCountPerPage : 한 페이지에 보여줄 로우개수
     * @param pageSize : 페이지 max개수
     * @author psj
     * @return PaginationInfo
     */
    public static PaginationInfo getPaginationInfo(Map paramMap,Integer recordCountPerPage ,Integer pageSize){

    	PaginationInfo paginationInfo = new PaginationInfo();

		// 현재 페이지
		Integer pageIndex = 1;

		if (paramMap.containsKey("pageIndex") && !paramMap.get("pageIndex").toString().equals("")) {
			pageIndex = Integer.parseInt(paramMap.get("pageIndex").toString());
		}

		paginationInfo.setCurrentPageNo(pageIndex);// 현재 페이지 번호

		if (paramMap.containsKey("recordCountPerPage") && !paramMap.get("recordCountPerPage").toString().equals("")) {
			recordCountPerPage = Integer.parseInt(paramMap.get("recordCountPerPage").toString());
		}

		paginationInfo.setRecordCountPerPage(recordCountPerPage);// 한 페이지에 게시되는
																	// 게시물 건수
		paginationInfo.setPageSize(pageSize);// 페이징 리스트의 사이즈

        return paginationInfo;
    }
}
