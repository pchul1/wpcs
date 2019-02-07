package daewooInfo.common.menu.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import daewooInfo.common.menu.bean.MyMenuVO;

public interface MyMenuService {
	
	/**
	 * 헤더 메뉴를 가져온다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public List<MyMenuVO> TreeselectMenu(MyMenuVO myMenuVO) throws Exception;
    
    public void InsertMyMenu(HttpServletRequest request , MyMenuVO myMenuVO) throws Exception;
}
