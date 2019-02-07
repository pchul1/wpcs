package daewooInfo.common.menu.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.Servlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.ServletRequestUtils;

import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.menu.bean.MyMenuVO;
import daewooInfo.common.menu.dao.MyMenuDAO;
import daewooInfo.common.menu.service.MyMenuService;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("MyMenuService")
public class MyMenuServiceImpl extends AbstractServiceImpl implements MyMenuService {

    /**
	 * @uml.property  name="menuDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="MyMenuDAO")
    private MyMenuDAO myMenuDAO;

	public List<MyMenuVO> TreeselectMenu(MyMenuVO myMenuVO) throws Exception {
		return myMenuDAO.TreeselectMenu(myMenuVO);
	}
	
	public void InsertMyMenu(HttpServletRequest request ,MyMenuVO myMenuVO) throws Exception {
		LoginVO loginvo = LogInfoUtil.GetSessionLogin();
		String id = loginvo.getId();
		myMenuVO.setMember_id(id);
		
		//마이 메뉴테이블에 설정된 회원 메뉴ID 를 전부다 삭제한다.
		myMenuDAO.DeleteMyMenu(myMenuVO);
		String[] menu_id_array = ServletRequestUtils.getStringParameters(request, "menu_id");
		
		for(String menu_id : menu_id_array){
			MyMenuVO insertMyMenuVO = new MyMenuVO();
			insertMyMenuVO.setMember_id(loginvo.getId());
			insertMyMenuVO.setMenuNo(Integer.parseInt(menu_id));
			
			//설정한 마이 메뉴번호를 입력한다.
			myMenuDAO.InsertMyMenu(insertMyMenuVO);
		}
	}
}
