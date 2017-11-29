package ib.basic.interceptor;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

public class MenuVO {

	private int roleId;
	private int menuId;
	private int menuLevel;
	private String menuKor;
	private String menuPath;
	private String menuEng;
	private int menuParentId;
	private int menuRootId;
	private String menuLoc;
	private String menuType;

	private int directMenuParentId;

	// 탭, 버튼, 팝업의 상위 메뉴 정보
	private MenuVO notTreeTopMenuInfo;

	/* depth: 1 메뉴정보 */
	// depth : 1 메뉴 아이디
	private int middleMenuId;
	// depth : 1 상위 메뉴 아이디
	private int middleParentId;
	// depth : 1 메뉴 정보(메뉴 아이디, 메뉴 명, 메뉴 url)
	private String middle;
	private MenuVO middleMenuVo;

	/* depth: 2 메뉴 정보 */
	// depth : 2의 상위메뉴 아이디
	private int bottomParentId;
	private int bottomMenuId;
	// depth : 2 메뉴 정보(메뉴 아이디, 메뉴 명, 메뉴 url)
	private String bottom;
	private List<MenuVO> bottomMenuList;

	public MenuVO getNotTreeTopMenuInfo() {
		return notTreeTopMenuInfo;
	}

	public void setNotTreeTopMenuInfo(MenuVO notTreeTopMenuInfo) {
		this.notTreeTopMenuInfo = notTreeTopMenuInfo;
	}

	public int getDirectMenuParentId() {
		return directMenuParentId;
	}

	public void setDirectMenuParentId(int directMenuParentId) {
		this.directMenuParentId = directMenuParentId;
	}

	public int getBottomMenuId() {
		return bottomMenuId;
	}

	public void setBottomMenuId(int bottomMenuId) {
		this.bottomMenuId = bottomMenuId;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(int menuLevel) {
		this.menuLevel = menuLevel;
	}

	public String getMenuKor() {
		return menuKor;
	}

	public void setMenuKor(String menuKor) {
		this.menuKor = menuKor;
	}

	public String getMenuPath() {
		return menuPath;
	}

	public void setMenuPath(String menuPath) {
		this.menuPath = menuPath;
	}

	public String getMenuEng() {
		return menuEng;
	}

	public void setMenuEng(String menuEng) {
		this.menuEng = menuEng;
	}

	public int getMiddleMenuId() {
		return middleMenuId;
	}

	public void setMiddleMenuId(int middleMenuId) {
		this.middleMenuId = middleMenuId;
	}

	public int getMiddleParentId() {
		return middleParentId;
	}

	public void setMiddleParentId(int middleParentId) {
		this.middleParentId = middleParentId;
	}

	public String getMiddle() {
		return middle;
	}

	public void setMiddle(String middle) {
		System.out.println(middle);
		this.middle = middle;
		if (StringUtils.isNotEmpty(middle)) {
			System.out.println(middle);
			String[] infoArray = middle.split(",");
			this.setMiddleMenuVo(checkMenuVO(infoArray));
		}
	}

	public MenuVO getMiddleMenuVo() {
		return middleMenuVo;
	}

	public void setMiddleMenuVo(MenuVO middleMenuVo) {
		this.middleMenuVo = middleMenuVo;
	}

	public int getBottomParentId() {
		return bottomParentId;
	}

	public void setBottomParentId(int bottomParentId) {
		this.bottomParentId = bottomParentId;
	}

	public String getBottom() {
		return bottom;
	}

	public void setBottom(String bottom) {
		this.bottom = bottom;
		if (bottom != null && StringUtils.isNotEmpty(bottom)) {
			String[] infoArray = bottom.split(":");
			for (int i = 0; i < infoArray.length; i++) {
				String bottomMenuInfo = infoArray[i];
				if (StringUtils.isNotEmpty(bottomMenuInfo)) {
					String[] bottomInfos = bottomMenuInfo.split(",");
					addBottomMenuList(checkMenuVO(bottomInfos));
				}
			}

		}
	}

	public String getMenuType() {
		return menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	public List<MenuVO> getBottomMenuList() {
		return bottomMenuList;
	}

	public void addBottomMenuList(MenuVO menuVO) {
		if (bottomMenuList == null) {
			bottomMenuList = new ArrayList<MenuVO>();
		}
		bottomMenuList.add(menuVO);
	}

	public void setBottomMenuList(List<MenuVO> bottomMenuList) {
		this.bottomMenuList = bottomMenuList;
	}

	public int getMenuParentId() {
		return menuParentId;
	}

	public void setMenuParentId(int menuParentId) {
		this.menuParentId = menuParentId;
	}

	public int getMenuRootId() {
		return menuRootId;
	}

	public void setMenuRootId(int menuRootId) {
		this.menuRootId = menuRootId;
	}

	public String getMenuLoc() {
		return menuLoc;
	}

	public void setMenuLoc(String menuLoc) {
		this.menuLoc = menuLoc;
	}

	// 메뉴 정보 VO 객체화
	private MenuVO checkMenuVO(String[] infoArray) {
		MenuVO vo = new MenuVO();
		for (int i = 0; i < infoArray.length; i++) {
			if (i == 0) {
				vo.setMenuId(Integer.parseInt(infoArray[0]));
			} else if (i == 1) {
				vo.setMenuKor(infoArray[1]);
			} else if (i == 2) {
				vo.setMenuEng(infoArray[2]);
			} else if (i == 3) {
				vo.setMenuPath(infoArray[3]);
			}
		}
		return vo;
	}

	@Override
	public String toString() {
		return "MenuVO [roleId=" + roleId + ", menuId=" + menuId
				+ ", menuLevel=" + menuLevel + ", menuKor=" + menuKor
				+ ", menuPath=" + menuPath + ", menuEng=" + menuEng
				+ ", menuParentId=" + menuParentId + ", menuRootId="
				+ menuRootId + ", menuLoc=" + menuLoc + ", menuType="
				+ menuType + ", notTreeTopMenuInfo=" + notTreeTopMenuInfo
				+ ", middleMenuId=" + middleMenuId + ", middleParentId="
				+ middleParentId + ", middle=" + middle + ", middleMenuVo="
				+ middleMenuVo + ", bottomParentId=" + bottomParentId
				+ ", bottomMenuId=" + bottomMenuId + ", bottom=" + bottom
				+ ", bottomMenuList=" + bottomMenuList + "]";
	}

}
