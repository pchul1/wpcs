package daewooInfo.admin.menu.bean;

/** 
 * 메뉴목록관리 처리를 위한 VO 클래스르를 정의한다
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *
 * </pre>
 */

public class MenuManageVO{

   /** 메뉴정보 */
   /**
 * 메뉴번호
 * @uml.property  name="menuNo"
 */
   private   int      menuNo;
   /**
 * 메뉴순서
 * @uml.property  name="menuOrdr"
 */
   private   int      menuOrdr;
   /**
 * 메뉴명
 * @uml.property  name="menuNm"
 */
   private   String   menuNm;
   /**
 * 상위메뉴번호
 * @uml.property  name="upperMenuId"
 */
   private   int      upperMenuId;
   /**
 * 메뉴설명
 * @uml.property  name="menuDc"
 */
   private   String   menuDc;
   /**
 * 관련이미지경로
 * @uml.property  name="relateImagePath"
 */
   private   String   relateImagePath;
   /**
 * 관련이미지명
 * @uml.property  name="relateImageNm"
 */
   private   String   relateImageNm;
   /**
 * 프로그램파일명
 * @uml.property  name="progrmFileNm"
 */
   private   String   progrmFileNm;

   /** 사이트맵 */
   /**
 * 생성자ID
 * @uml.property  name="creatPersonId"
 */
   private   String   creatPersonId;

   /** 권한정보설정 */
   /**
 * 권한코드
 * @uml.property  name="authorCode"
 */
   private   String   authorCode;

   /**
 * 기타VO변수
 * @uml.property  name="tempValue"
 */
   private   String   tempValue;
   /**
 * @uml.property  name="tempInt"
 */
private   int      tempInt; 
   

   /** Login 메뉴관련 VO변수 */
   /**
 * tmp_Id
 * @uml.property  name="tmp_Id"
 */
   private   String   tmp_Id;
   /**
 * tmp_Password
 * @uml.property  name="tmp_Password"
 */
   private   String   tmp_Password;
   /**
 * tmp_Name
 * @uml.property  name="tmp_Name"
 */
   private   String   tmp_Name;
   /**
 * tmp_UserSe
 * @uml.property  name="tmp_UserSe"
 */
   private   String   tmp_UserSe;
   /**
 * tmp_Email
 * @uml.property  name="tmp_Email"
 */
   private   String   tmp_Email;
   /**
 * tmp_OrgnztId
 * @uml.property  name="tmp_OrgnztId"
 */
   private   String   tmp_OrgnztId;
   /**
 * tmp_UniqId
 * @uml.property  name="tmp_UniqId"
 */
   private   String   tmp_UniqId;
   /**
 * tmp_Cmd
 * @uml.property  name="tmp_Cmd"
 */
   private   String   tmp_Cmd;
   
	/**
	 * menuNo attribute를 리턴한다.
	 * @return  int
	 * @uml.property  name="menuNo"
	 */
	public int getMenuNo() {
		return menuNo;
	}
	/**
	 * menuNo attribute 값을 설정한다.
	 * @param menuNo  int
	 * @uml.property  name="menuNo"
	 */
	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}
	/**
	 * menuOrdr attribute를 리턴한다.
	 * @return  int
	 * @uml.property  name="menuOrdr"
	 */
	public int getMenuOrdr() {
		return menuOrdr;
	}
	/**
	 * menuOrdr attribute 값을 설정한다.
	 * @param menuOrdr  int
	 * @uml.property  name="menuOrdr"
	 */
	public void setMenuOrdr(int menuOrdr) {
		this.menuOrdr = menuOrdr;
	}
	/**
	 * menuNm attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="menuNm"
	 */
	public String getMenuNm() {
		return menuNm;
	}
	/**
	 * menuNm attribute 값을 설정한다.
	 * @param menuNm  String
	 * @uml.property  name="menuNm"
	 */
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	/**
	 * upperMenuId attribute를 리턴한다.
	 * @return  int
	 * @uml.property  name="upperMenuId"
	 */
	public int getUpperMenuId() {
		return upperMenuId;
	}
	/**
	 * upperMenuId attribute 값을 설정한다.
	 * @param upperMenuId  int
	 * @uml.property  name="upperMenuId"
	 */
	public void setUpperMenuId(int upperMenuId) {
		this.upperMenuId = upperMenuId;
	}
	/**
	 * menuDc attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="menuDc"
	 */
	public String getMenuDc() {
		return menuDc;
	}
	/**
	 * menuDc attribute 값을 설정한다.
	 * @param menuDc  String
	 * @uml.property  name="menuDc"
	 */
	public void setMenuDc(String menuDc) {
		this.menuDc = menuDc;
	}
	/**
	 * relateImagePath attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="relateImagePath"
	 */
	public String getRelateImagePath() {
		return relateImagePath;
	}
	/**
	 * relateImagePath attribute 값을 설정한다.
	 * @param relateImagePath  String
	 * @uml.property  name="relateImagePath"
	 */
	public void setRelateImagePath(String relateImagePath) {
		this.relateImagePath = relateImagePath;
	}
	/**
	 * relateImageNm attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="relateImageNm"
	 */
	public String getRelateImageNm() {
		return relateImageNm;
	}
	/**
	 * relateImageNm attribute 값을 설정한다.
	 * @param relateImageNm  String
	 * @uml.property  name="relateImageNm"
	 */
	public void setRelateImageNm(String relateImageNm) {
		this.relateImageNm = relateImageNm;
	}
	/**
	 * progrmFileNm attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="progrmFileNm"
	 */
	public String getProgrmFileNm() {
		return progrmFileNm;
	}
	/**
	 * progrmFileNm attribute 값을 설정한다.
	 * @param progrmFileNm  String
	 * @uml.property  name="progrmFileNm"
	 */
	public void setProgrmFileNm(String progrmFileNm) {
		this.progrmFileNm = progrmFileNm;
	}
	/**
	 * creatPersonId attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="creatPersonId"
	 */
	public String getCreatPersonId() {
		return creatPersonId;
	}
	/**
	 * creatPersonId attribute 값을 설정한다.
	 * @param creatPersonId  String
	 * @uml.property  name="creatPersonId"
	 */
	public void setCreatPersonId(String creatPersonId) {
		this.creatPersonId = creatPersonId;
	}
	/**
	 * authorCode attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="authorCode"
	 */
	public String getAuthorCode() {
		return authorCode;
	}
	/**
	 * authorCode attribute 값을 설정한다.
	 * @param authorCode  String
	 * @uml.property  name="authorCode"
	 */
	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}

	/**
	 * tmp_Id attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_Id"
	 */
	public String getTmp_Id() {
		return tmp_Id;
	}
	/**
	 * tmp_Id attribute 값을 설정한다.
	 * @param tmp_Id  String
	 * @uml.property  name="tmp_Id"
	 */
	public void setTmp_Id(String tmp_Id) {
		this.tmp_Id = tmp_Id;
	}
	/**
	 * tmp_Password attribute를 리턴한다.
	 * @return  String
	 */
	public String getTmp_Password() {
		return tmp_Password;
	}
	/**
	 * tmp_Password attribute 값을 설정한다.
	 * @param tmp_Password  String
	 */
	public void setTmp_Password(String tmp_Password) {
		this.tmp_Password = tmp_Password;
	}
	/**
	 * tmp_Name attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_Name"
	 */
	public String getTmp_Name() {
		return tmp_Name;
	}
	/**
	 * tmp_Name attribute 값을 설정한다.
	 * @param tmp_Name  String
	 * @uml.property  name="tmp_Name"
	 */
	public void setTmp_Name(String tmp_Name) {
		this.tmp_Name = tmp_Name;
	}
	/**
	 * tmp_UserSe attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_UserSe"
	 */
	public String getTmp_UserSe() {
		return tmp_UserSe;
	}
	/**
	 * tmp_UserSe attribute 값을 설정한다.
	 * @param tmp_UserSe  String
	 * @uml.property  name="tmp_UserSe"
	 */
	public void setTmp_UserSe(String tmp_UserSe) {
		this.tmp_UserSe = tmp_UserSe;
	}
	/**
	 * tmp_Email attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_Email"
	 */
	public String getTmp_Email() {
		return tmp_Email;
	}
	/**
	 * tmp_Email attribute 값을 설정한다.
	 * @param tmp_Email  String
	 * @uml.property  name="tmp_Email"
	 */
	public void setTmp_Email(String tmp_Email) {
		this.tmp_Email = tmp_Email;
	}
	/**
	 * tmp_OrgnztId attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_OrgnztId"
	 */
	public String getTmp_OrgnztId() {
		return tmp_OrgnztId;
	}
	/**
	 * tmp_OrgnztId attribute 값을 설정한다.
	 * @param tmp_OrgnztId  String
	 * @uml.property  name="tmp_OrgnztId"
	 */
	public void setTmp_OrgnztId(String tmp_OrgnztId) {
		this.tmp_OrgnztId = tmp_OrgnztId;
	}
	/**
	 * tmp_UniqId attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_UniqId"
	 */
	public String getTmp_UniqId() {
		return tmp_UniqId;
	}
	/**
	 * tmp_UniqId attribute 값을 설정한다.
	 * @param tmp_UniqId  String
	 * @uml.property  name="tmp_UniqId"
	 */
	public void setTmp_UniqId(String tmp_UniqId) {
		this.tmp_UniqId = tmp_UniqId;
	}
	/**
	 * tmp_Cmd attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_Cmd"
	 */
	public String getTmp_Cmd() {
		return tmp_Cmd;
	}
	/**
	 * tmp_Cmd attribute 값을 설정한다.
	 * @param tmp_Cmd  String
	 * @uml.property  name="tmp_Cmd"
	 */
	public void setTmp_Cmd(String tmp_Cmd) {
		this.tmp_Cmd = tmp_Cmd;
	}
	   
	  /**
	 * tempValue attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tempValue"
	 */
	public String getTempValue() {
		return tempValue;
	}
	/**
	 * tempValue attribute 값을 설정한다.
	 * @param tempValue  String
	 * @uml.property  name="tempValue"
	 */
	public void setTempValue(String tempValue) {
		this.tempValue = tempValue;
	}
	/**
	 * tempInt attribute를 리턴한다.
	 * @return  int
	 * @uml.property  name="tempInt"
	 */
	public int getTempInt() {
		return tempInt;
	}
	/**
	 * tempInt attribute 값을 설정한다.
	 * @param tempInt  int
	 * @uml.property  name="tempInt"
	 */
	public void setTempInt(int tempInt) {
		this.tempInt = tempInt;
	}
}