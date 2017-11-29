package ib.cmm.util.sim.service;

import java.util.ArrayList;
import java.util.List;

public class PagingAjax {
	
	public static int getMaxPage(int itemCount, int itemCountPerPage) {
		return (int) Math.ceil((float)itemCount / (float)itemCountPerPage);
	}
	
	/**
	 * 마지막 페이지 번호, 페이징에 나열될 페이지번호의 갯수, 전역변수에 담겨있는 현재 페이지 번호를 통해
	 * 페이징에 나열될 페이지 번호가 담긴 List를 생성하여 반환한다.
	 * @param page : 현재 페이지 번호
	 * @param maxPage : 마지막 페이지 번호
	 * @param pageCountPerPaging : 페이징에 나열될 페이지번호의 갯수
	 * @return
	 */
	public static List getPagingList(int currentPage, int maxPage, int pageCountPerPaging) {
		List paging = new ArrayList();
		int startPage = (currentPage-1)/pageCountPerPaging*pageCountPerPaging+1;
		int pageNum = startPage;
	
		int i=1;
		while (i <= pageCountPerPaging) {
			paging.add(pageNum);
			pageNum++;
			if (pageNum > maxPage) break;
			i++;
		}
		return paging;
	}
	///현재 페이지,토탈 리스트 갯수, 한페이지의 갯수 ,페이징 리스트 사이즈 ,fn 이름 ,기타필드(타입)
	public static String getPaging(int currentPage, int itemCount, int itemCountPerPage, int pageCountPerPaging,String functionName,String type,String type2,String type3) {
		String paging = "";
		
		int maxPage = getMaxPage(itemCount, itemCountPerPage); //총 페이지 갯수를 가져온다. (토탈 리스트 갯수, 한페이지의 리스트 idx 갯수)
		 //페이징에 나열될 페이지 번호가 담긴 List (현재 페이지, 마지막페이지번호, 한페이지의 보여줄 페이지번호 갯수)
		List pagingList = getPagingList(currentPage, maxPage, pageCountPerPaging);
		
		paging += "					<div class=\"btnPageZone\">" + "\n";
		paging += "						<input type=\"hidden\" name=\"currentPage\" value=\""+ currentPage +"\" />" + "\n";
		paging += "" + "\n";
		
		///  << 버튼
		if( currentPage > pageCountPerPaging) {
			paging += "						<button type=\"button\" class=\"pre_end_btn\" onclick=\""+functionName+"(this.form, "+ (currentPage-pageCountPerPaging) +",'"+type+"','"+type2+"','"+type3+"');\"><span><em>맨처음 페이지</em></span></button>" + "\n";
		}
		/// < 버튼
		if (currentPage > 1) {
			paging += "						<button type=\"button\" class=\"pre_btn\" onclick=\""+functionName+"(this.form, "+ (currentPage-1) +",'"+type+"','"+type2+"','"+type3+"');\"><span><em>이전 페이지</em></span></button>" + "\n";
		}
		paging += "" + "\n";
		for (int i=0; i<pagingList.size(); i++) {
			if (Integer.parseInt(pagingList.get(i).toString()) == currentPage) { //현재 페이지
				paging += "								<span class=\"current\"><a href=\"#\">"+pagingList.get(i)+"</a></span>" + "\n";
				//paging += "								<button type=\"button\" class=\"round white\" style=\"font-weight:bold; background:#c4c7d0;\">&nbsp;"+pagingList.get(i)+"&nbsp;</button>" + "\n";
			} else {
				paging += "								<span><a onclick=\""+functionName+"(this.form, "+ pagingList.get(i) +",'"+type+"','"+type2+"','"+type3+"');\">"+pagingList.get(i)+"</a></span>" + "\n";
				//paging += "								<button type=\"button\" class=\"round\" onclick=\""+functionName+"(this.form, "+ pagingList.get(i) +",'"+type+"','"+type2+"','"+type3+"');\">&nbsp;"+pagingList.get(i)+"&nbsp;</button>" + "\n";
			}
		}
		paging += "" + "\n";
		
		// > 버튼
		if (currentPage < maxPage) {
			paging += "							<button type=\"button\" class=\"next_btn\" onclick=\""+functionName+"(this.form, "+ (currentPage+1) +",'"+type+"','"+type2+"','"+type3+"');\"><span><em>다음 페이지</em></span></button>" + "\n";
		} 
		// >>버튼
		if( currentPage < maxPage-pageCountPerPaging) {
			paging += "						<button type=\"button\" class=\"next_end_btn\" onclick=\""+functionName+"(this.form, "+ (currentPage+pageCountPerPaging) +",'"+type+"','"+type2+"','"+type3+"');\"><span><em>맨마지막 페이지</em></span></button>" + "\n";
		}
		paging += "" + "\n";
		paging += "						<div class=\"clear\"></div>" + "\n";
		paging += "					</div>";
		
		return paging;
	}


}







//<span><a href="">2</a></span>
//<span><a href="">3</a></span>
//<span class="current"><a href="">4</a></span>



