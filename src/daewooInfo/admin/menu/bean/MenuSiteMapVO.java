package daewooInfo.admin.menu.bean;
/** 
 * 사이트맵/메인메뉴 처리를 위한 VO 클래스르를 정의한다
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

public class MenuSiteMapVO{
	
   /**
 * 메뉴번호
 * @uml.property  name="menuNo"
 */
   private   int      menuNo;
   
   /* 사이트맵 */
   /**
 * 생성자ID
 * @uml.property  name="creatPersonId"
 */
   private   String   creatPersonId;
   /**
 * 맵생성ID
 * @uml.property  name="mapCreatId"
 */
   private   String   mapCreatId;
   /**
 * 맵파일명
 * @uml.property  name="bndeFileNm"
 */
   private   String   bndeFileNm;
   /**
 * 맵파일경로
 * @uml.property  name="bndeFilePath"
 */
   private   String   bndeFilePath;

   /* 권한정보설정 */
   /**
 * 권한코드
 * @uml.property  name="authorCode"
 */
   private   String   authorCode;
   /**
 * 권한명
 * @uml.property  name="authorNm"
 */
   private   String   authorNm;
   /**
 * 권한설명
 * @uml.property  name="authorDc"
 */
   private   String   authorDc;
   /**
 * 권한생성일자
 * @uml.property  name="authorCreatDe"
 */
   private   String   authorCreatDe;

   /* 기타VO변수 */
   /**
 * rootPath Temp
 * @uml.property  name="tmp_rootPath"
 */
   private   String   tmp_rootPath;

/* Login 메뉴관련 VO변수 */
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
	 * mapCreatId attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="mapCreatId"
	 */
	public String getMapCreatId() {
		return mapCreatId;
	}
	/**
	 * mapCreatId attribute 값을 설정한다.
	 * @param mapCreatId  String
	 * @uml.property  name="mapCreatId"
	 */
	public void setMapCreatId(String mapCreatId) {
		this.mapCreatId = mapCreatId;
	}
	/**
	 * bndeFileNm attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="bndeFileNm"
	 */
	public String getBndeFileNm() {
		return bndeFileNm;
	}
	/**
	 * bndeFileNm attribute 값을 설정한다.
	 * @param bndeFileNm  String
	 * @uml.property  name="bndeFileNm"
	 */
	public void setBndeFileNm(String bndeFileNm) {
		this.bndeFileNm = bndeFileNm;
	}
	/**
	 * bndeFilePath attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="bndeFilePath"
	 */
	public String getBndeFilePath() {
		return bndeFilePath;
	}
	/**
	 * bndeFilePath attribute 값을 설정한다.
	 * @param bndeFilePath  String
	 * @uml.property  name="bndeFilePath"
	 */
	public void setBndeFilePath(String bndeFilePath) {
		this.bndeFilePath = bndeFilePath;
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
	 * authorNm attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="authorNm"
	 */
	public String getAuthorNm() {
		return authorNm;
	}
	/**
	 * authorNm attribute 값을 설정한다.
	 * @param authorNm  String
	 * @uml.property  name="authorNm"
	 */
	public void setAuthorNm(String authorNm) {
		this.authorNm = authorNm;
	}
	/**
	 * authorDc attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="authorDc"
	 */
	public String getAuthorDc() {
		return authorDc;
	}
	/**
	 * authorDc attribute 값을 설정한다.
	 * @param authorDc  String
	 * @uml.property  name="authorDc"
	 */
	public void setAuthorDc(String authorDc) {
		this.authorDc = authorDc;
	}
	/**
	 * authorCreatDe attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="authorCreatDe"
	 */
	public String getAuthorCreatDe() {
		return authorCreatDe;
	}
	/**
	 * authorCreatDe attribute 값을 설정한다.
	 * @param authorCreatDe  String
	 * @uml.property  name="authorCreatDe"
	 */
	public void setAuthorCreatDe(String authorCreatDe) {
		this.authorCreatDe = authorCreatDe;
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
	 * tmp_rootPath attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_rootPath"
	 */
	public String getTmp_rootPath() {
		return tmp_rootPath;
	}
	/**
	 * tmp_rootPath attribute 값을 설정한다.
	 * @param tmp_rootPath  String
	 * @uml.property  name="tmp_rootPath"
	 */
	public void setTmp_rootPath(String tmp_rootPath) {
		this.tmp_rootPath = tmp_rootPath;
	}

}