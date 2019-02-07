<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * @Class Name : deptTree.jsp
  * @Description : 조직 정보 (트리 - t_dept)
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2010.06.29  kisspa       최초 생성
  *
  *  @author kisspa
  *  @since 2010.06.29
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css' />" />
<title>조직정보</title>
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<script src="<c:url value='/js/DeptTree.js'/>"/></script>
<script>
function selectDept() {
    var checkField = document.deptTreeForm.checkField;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {
    	if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + checkField[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = checkField.value;
            }
        }
    }   
    document.deptTreeForm.checkedDeptNo.value=checkMenuNos;
    alert(document.deptTreeForm.checkedDeptNo.value); 
}

</script>
</head>
<body class="pop_basic"> 
	<div id="managePage">
		<div class="header">
			<h1>조직정보</h1>
		</div>		
		<ul class="menuList menuSpacing">
			<li class="spacing">
				<a href="javascript:selectDept()" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>확인</em></span></a>
			</li>
		</ul>
		<form name="deptTreeForm" method="post">
			<input name="checkedDeptNo" type="hidden" />
			<c:forEach var="result1" items="${result}" varStatus="status" > 
			<input type="hidden" name="tmp_deptNmVal" value="${result1.deptNo}|${result1.upperDeptNo}|${result1.deptName}|">
			</c:forEach>
			
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
								if (eval(document.deptTreeForm.checkedDeptNo)=="[object]") chk_browse = "IE";
								if (eval(document.deptTreeForm.checkedDeptNo)=="[object NodeList]") chk_browse = "Fox";
								if (eval(document.deptTreeForm.checkedDeptNo)=="[object Collection]") chk_browse = "safai";
					
								var Tree = new Array;
								if(chk_browse=="IE"&&eval(document.deptTreeForm.tmp_deptNmVal)!="[object]"){
								   alert("조직정보 데이타가 존재하지 않습니다.");
								   chk_Object = false;
								}
								if(chk_browse=="Fox"&&eval(document.deptTreeForm.tmp_deptNmVal)!="[object NodeList]"){
								   alert("조직정보 데이타가 존재하지 않습니다.");
								   chk_Object = false;
								}
								if(chk_browse=="safai"&&eval(document.deptTreeForm.tmp_deptNmVal)!="[object Collection]"){
									   alert("조직정보 데이타가 존재하지 않습니다.");
									   chk_Object = false;
								}
								if( chk_Object ){
									for (var j = 0; j < document.deptTreeForm.tmp_deptNmVal.length; j++) {
										Tree[j] = document.deptTreeForm.tmp_deptNmVal[j].value;
								    }
								    createTree(Tree);
					            }else{
					                alert("조직정보가 존재하지 않습니다.");
					                window.close();
					            }
							</script>
						</div>
					</td>
				</tr>
			</table>

		</form>
	</div>
</body>
</html>