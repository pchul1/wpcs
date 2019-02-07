<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /** 
  * @Class Name : DeptMvmn.jsp
  * @Description : 부서이동 화면 (팝업)
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 201007.19  kisspa        최초 생성
  *
  * @author kisspa
  * @since 2010.07.19
  * @version 1.0
  * @see
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
<%
	String type = (String)request.getParameter("type");
%>
<title>부서검색</title>
<script>
	var ROOT_PATH = '<c:url value="/"/>';
</script>
<script language="javascript1.2" src="<c:url value='/js/admin/menu/EgovMenuList.js"'/>/></script>
<script language="javascript1.2">
<!--
/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
function choiceNodes(nodeNum) {
	var nodeValues = treeNodes[nodeNum].split("|");
	
	var strType = '<%=type%>';
	
	var strCode  = nodeValues[3];
	var strValue = nodeValues[2];
	window.opener.searchAdminMember(strCode, strValue, strType);		
	
    window.close();
}
/* ********************************************************
 * 조회 함수
 ******************************************************** */
function selectDeptListTmp() {
	document.deptListForm.req_RetrunPath.value = "<c:url value='/admin/dept/DeptMvmn'/>";
    document.deptListForm.action = "<c:url value='/admin/dept/DeptListSelectTmp.do'/>";
    document.deptListForm.submit();
}
-->
</script>
</head>

<body class="subPop"><!-- 추가 및 수정 --> 
<div class="headerWrap"> 
	<div class="headerBg_r"> 
		<div class="header"> 
			<h1>상위부서를 선택해주세요</h1>
		</div> 
	</div> 
</div> 
<div class="contentWrap"> 
	<div class="contentBg_r"> 
		<div class="contentBox"> 
			<div class="contentPad">
				<!-- 내용 --> 
				<div id="managePage">
				<form name="searchUpperDeptCodeForm" action ="<c:url value='/admin/dept/DeptListSelectMvmn.do'/>" method="post">
				<input type="hidden" name="req_RetrunPath" value="<c:url value='/admin/dept/DeptMvmn'/>">
				<c:forEach var="result" items="${list_deptlist}" varStatus="status" > 
				<input type="hidden" name="tmp_deptNmVal" value="${result.deptCode}|${result.upperDeptCode}|${result.deptName}|${result.deptCode}|${result.deptSort}|${result.deptName}|${result.upperDeptCode}|${result.deptDesc}|">
				</c:forEach>
				
				<table class="dataTable">
					<colgroup>
						<col width="120px" />
						<col />
					</colgroup>
					<tr>
						<th scope="row">부서</th>
						<td>
							<div class="tree">
								<script language="javascript">
					
							    var chk_Object = true;
							    var chk_browse = "";
								if (eval(document.searchUpperDeptCodeForm.req_RetrunPath)=="[object]") chk_browse = "IE";
								if (eval(document.searchUpperDeptCodeForm.req_RetrunPath)=="[object NodeList]") chk_browse = "Fox";
								if (eval(document.searchUpperDeptCodeForm.req_RetrunPath)=="[object Collection]") chk_browse = "safai";
					
								var Tree = new Array;
								if(chk_browse=="IE"&&eval(document.searchUpperDeptCodeForm.tmp_deptNmVal)!="[object]"){
								   alert("부서 목록 데이타가 존재하지 않습니다.");
								   chk_Object = false;
								}
								if(chk_browse=="Fox"&&eval(document.searchUpperDeptCodeForm.tmp_deptNmVal)!="[object NodeList]"){
								   alert("부서 목록 데이타가 존재하지 않습니다.");
								   chk_Object = false;
								}
								if(chk_browse=="safai"&&eval(document.searchUpperDeptCodeForm.tmp_deptNmVal)!="[object Collection]"){
									   alert("부서 목록 데이타가 존재하지 않습니다.");
									   chk_Object = false;
								}
								if( chk_Object ){
									for (var j = 0; j < document.searchUpperDeptCodeForm.tmp_deptNmVal.length; j++) {
										Tree[j] = document.searchUpperDeptCodeForm.tmp_deptNmVal[j].value;
								    }
								    createTree(Tree, true);
					            }else{
					                alert("부서가 존재하지 않습니다. 부서 등록 후 사용하세요");
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


