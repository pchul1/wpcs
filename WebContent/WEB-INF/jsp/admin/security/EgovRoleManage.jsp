<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<%

/**
 * @Class Name : EgovRoleManage.java
 * @Description : EgovRoleManage jsp
 * @Modification Information
 * @
 * @  수정일                    수정자                수정내용
 * @ ---------     --------    ---------------------------
 * @ 2009.02.01    lee.m.j     최초 생성
 *
 *  @author lee.m.j
 *  @since 2009.03.21
 *  @version 1.0
 *  @see
 *  
 */
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/com.css' />" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css' />" />
<title>SYSTEM HISTORY</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var returnBoolean = false;
    var checkCount = 0;
    
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                	checkCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else 
                        returnValue = returnValue + ";" + checkField[i].value;
                }
            }
            if(checkCount > 0) 
                returnBoolean = true;
            else {
                alert("선택된  롤이 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된 롤이 없습니다.");
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
    	alert("조회된 결과가 없습니다.");
    }

    document.listForm.roleCodes.value = returnValue;
    return returnBoolean;
}

function fncSelectRoleList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/admin/security/EgovRoleList.do'/>";
    document.listForm.submit();
}

function fncSelectRole(roleCode) {
    document.listForm.roleCode.value = roleCode;
    document.listForm.action = "<c:url value='/admin/security/EgovRole.do'/>";
    document.listForm.submit();     
}

function fncAddRoleInsert() {
    location.replace("<c:url value='/admin/security/EgovRoleInsertView.do'/>"); 
}

function fncRoleListDelete() {
	if(fncManageChecked()) {
        if(confirm("삭제하시겠습니까?")) {
            document.listForm.action = "<c:url value='/admin/security/EgovRoleListDelete.do'/>";
            document.listForm.submit();
        }
    }
}

function fncAddRoleView() {
    document.listForm.action = "<c:url value='/admin/security/EgovRoleUpdate.do'/>";
    document.listForm.submit();     
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/admin/security/EgovRoleList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
    	fncSelectRoleList('1');
    }
}
-->
</script>

</head>

<body>

<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		
		<!-- content -->
		<div id="content">
		
			<div id="managePage">
				<form name="listForm" action="/admin/security/EgovAuthorList.do" method="post"> 
					<ul class="menuList menuSpacing">
						<li class="spacing">
							<span class="inputTit">롤 명 :</span> <input name="searchKeyword" type="text" value="<c:out value="${roleManageVO.searchKeyword}"/>" size="25" title="검색" onkeypress="press();" />
						</li>
						<li>
							<a href="javascript:fncSelectRoleList('1')" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>조회</em></span></a>
						</li>
						<li>
							<a href="javascript:fncAddRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>등록</em></span></a>
						</li>
						<li>
							<a href="javascript:fncRoleListDelete()" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>삭제</em></span></a> 
						</li>
					</ul>
					
					<table class="dataTable">
						<colgroup>
							<col width="3%">
							<col width="10%">
							<col width="15%">
							<col width="10%">
							<col width="10%">
							<col width="30%">
							<col width="17%">
							<col width="5%">
						</colgroup>
						<thead> 
							<tr> 
								<th class="noOption"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()"></th>  
								<th>롤 ID</th> 
								<th>롤 명</th> 
								<th>롤 타입</th> 
								<th>롤 Sort</th> 
								<th>롤 설명</th> 
								<th>등록일자</th>
								<th>상세</th>
							</tr> 
						</thead>
						<tbody>
							<c:forEach var="role" items="${roleList}" varStatus="status">
								<tr> 
									<td class="noOption"><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${role.roleCode}"/>" /></td> 
									<td><a href="javascript:fncSelectRole('<c:out value="${role.roleCode}"/>')"><c:out value="${role.roleCode}"/></a></td> 
									<td><c:out value="${role.roleNm}"/></td> 
									<td><c:out value="${role.roleTyp}"/></td> 
									<td><c:out value="${role.roleSort}"/></td> 
									<td><c:out value="${role.roleDc}"/></td>
									 <td><c:out value="${role.roleCreatDe}"/></td>
									 <td>
									 	<a href="javascript:fncSelectRole('<c:out value="${role.roleCode}"/>')">
									 		<img src="<c:url value='/images/admin/security/icon/search.gif'/>" width="15" height="15" align="absmiddle"  alt="상세조회">
									 	</a>
									 </td>
								</tr>
							</c:forEach> 
						</tbody>
					</table>
					<c:if test="${!empty roleManageVO.pageIndex }">
					<ul class="paginate">
						<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="linkPage"/>
						<!-- 
						<li><a href="#">이전..</a></li>
						<li><em>1</em></li>
						<li><a href="#">2</a></li>
						<li><a href="#">..이후</a></li>
						-->
					</ul>
					</c:if>
					<p class="mag_msg">
						<input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly />
					</p>

					<input type="hidden" name="roleCode"/>
					<input type="hidden" name="roleCodes"/>
					<input type="hidden" name="pageIndex" value="<c:out value='${roleManageVO.pageIndex}'/>"/>
					<input type="hidden" name="searchCondition"/>
				</form>
			</div><!-- //managePage -->
			
			
			
		</div><!-- //content -->
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
