<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /** 
  * @Class Name : EgovMenuMvmn.jsp
  * @Description : 메뉴이동 화면 (팝업)
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.10    이용          최초 생성
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<link href="<c:url value='/css/content.css' />" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/popup.css' />" rel="stylesheet" type="text/css">
<title>메뉴이동</title>
<script>
	var ROOT_PATH = '<c:url value="/"/>';
</script>
<script language="javascript1.2" src="<c:url value='/js/admin/menu/EgovMenuList.js"'/>/></script>
<script language="javascript1.2">
<!--
function selectProgramListSearch() {  
	progrmManageForm.submit();
}
function choisProgramListSearch(vFileNm) { 
	eval("opener.document.all."+opener.document.all.tmp_SearchElementName.value).value = vFileNm;
    window.close();
}

/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
function choiceNodes(nodeNum) {
	var nodeValues = treeNodes[nodeNum].split("|");
	opener.document.menuListForm.upperMenuId.value = nodeValues[4];
    window.close();
}
/* ********************************************************
 * 조회 함수
 ******************************************************** */
function selectMenuListTmp() {
	document.menuListForm.req_RetrunPath.value = "<c:url value='/admin/menu/EgovMenuMvmn'/>";
    document.menuListForm.action = "<c:url value='/admin/menu/EgovMenuListSelectTmp.do'/>";
    document.menuListForm.submit();
}
-->
</script>
</head>

<body class="subPop"><!-- 추가 및 수정 --> 
<div class="headerWrap"> 
	<div class="headerBg_r"> 
		<div class="header"> 
			<h1>메뉴이동</h1> 
		</div> 
	</div> 
</div> 
<div class="contentWrap"> 
	<div class="contentBg_r"> 
		<div class="contentBox"> 
			<div class="contentPad">
				<!-- 내용 --> 
				<div id="managePage">
					<form name="searchUpperMenuIdForm" action ="<c:url value='/admin/menu/EgovMenuListSelectMvmn.do'/>" method="post">
					<input type="hidden" name="req_RetrunPath" value="<c:url value='/admin/menu/EgovMenuMvmn'/>">
					<c:forEach var="result" items="${list_menulist}" varStatus="status" > 
					<input type="hidden" name="tmp_menuNmVal" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.progrmFileNm}|${result.menuNo}|${result.menuOrdr}|${result.menuNm}|${result.upperMenuId}|${result.menuDc}|${result.relateImagePath}|${result.relateImageNm}|${result.progrmFileNm}|">
					</c:forEach>
					
					<ul class="menuList menuSpacing highIndex">
						<li class="spacing">
							<span class="inputTit">이동할메뉴명 :</span> <input name="progrmFileNm" type="text" size="30" value=""  maxlength="60" >
						</li>
					</ul>
					
					<table class="dataTable">
						<colgroup>
							<col width="120px" />
							<col />
						</colgroup>
						<tr>
							<th scope="row">메뉴</th>
							<td>
								<div class="tree">
									<script language="javascript">
						
								    var chk_Object = true;
								    var chk_browse = "";
									if (eval(document.searchUpperMenuIdForm.req_RetrunPath)=="[object]") chk_browse = "IE";
									if (eval(document.searchUpperMenuIdForm.req_RetrunPath)=="[object NodeList]") chk_browse = "Fox";
									if (eval(document.searchUpperMenuIdForm.req_RetrunPath)=="[object Collection]") chk_browse = "safai";
						
									var Tree = new Array;
									if(chk_browse=="IE"&&eval(document.searchUpperMenuIdForm.tmp_menuNmVal)!="[object]"){
									   alert("메뉴 목록 데이타가 존재하지 않습니다.");
									   chk_Object = false;
									}
									if(chk_browse=="Fox"&&eval(document.searchUpperMenuIdForm.tmp_menuNmVal)!="[object NodeList]"){
									   alert("메뉴 목록 데이타가 존재하지 않습니다.");
									   chk_Object = false;
									}
									if(chk_browse=="safai"&&eval(document.searchUpperMenuIdForm.tmp_menuNmVal)!="[object Collection]"){
										   alert("메뉴 목록 데이타가 존재하지 않습니다.");
										   chk_Object = false;
									}
									if( chk_Object ){
										for (var j = 0; j < document.searchUpperMenuIdForm.tmp_menuNmVal.length; j++) {
											Tree[j] = document.searchUpperMenuIdForm.tmp_menuNmVal[j].value;
									    }
									    createTree(Tree, true);
						            }else{
						                alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요");
						                window.close();
						            }
						           </script>
								</div>
							</td>
						</tr>
					</table>
			
					</form>
				</div>
			</div>
		</div> 
	</div> 
</div> 
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 --> 
</body> 
</html>
