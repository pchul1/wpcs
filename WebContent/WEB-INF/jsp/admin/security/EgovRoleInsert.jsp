<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * @Class Name  : EgovRoleInsert.java
  * @Description : EgovRoleInsert jsp
  * @Modification Information
  * @
  * @  수정일         수정자          수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.02.01    lee.m.j          최초 생성
  *
  *  @author lee.m.j
  *  @since 2009.03.11
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
<title></title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="roleManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectRoleList() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/admin/security/EgovRoleList.do'/>";
    varFrom.submit();       
}

function fncRoleInsert() {

    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/admin/security/EgovRoleInsert.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateRoleManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncRoleUpdate() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/admin/security/EgovRoleUpdate.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateRoleManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncRoleDelete() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/admin/security/EgovRoleDelete.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        varFrom.submit();
    }
}

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
				<form:form commandName="roleManage" method="post" >  
					<ul class="menuList menuSpacing">
						<li>
							<a href="javascript:fncSelectRoleList()" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>목록</em></span></a>
						</li>
						<li>
							<a href="javascript:fncRoleInsert()" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>등록</em></span></a>
						</li>
					</ul>
					<table class="dataTable">
						<colgroup>
							<col width="20%">
							<col>
						</colgroup>
						<tr>
							<th>롤  코드 <span class="asterisk">*</span></th>
							<td>
								<input name="roleCode" id="roleCode" type="text" value="자동생성" size="30" readOnly />
							</td>
						</tr>
						<tr>  
							<th>롤 명 <span class="asterisk">*</span></th>
							<td>
								<input name="roleNm" id="roleNm" type="text" value="<c:out value='${roleManage.roleNm}'/>" required="true" fieldTitle="롤 명" maxLength="50" char="s" size="30" />&nbsp;<form:errors path="roleNm" />
							</td>
						</tr>
						<tr>  
							<th>롤 패턴 <span class="asterisk">*</span></th>
							<td>
								<input name="rolePtn" id="rolePtn" type="text" value="<c:out value='${roleManage.rolePtn}'/>" required="true" fieldTitle="롤  패턴" maxLength="50" char="s" size="50" />&nbsp;<form:errors path="rolePtn" />
							</td>
						</tr>
						<tr>  
							<th>설명</th>
							<td>
								<input name="roleDc" id="roleDc" type="text" value="<c:out value="${roleManage.roleDc}"/>" required="true" fieldTitle="설명" maxLength="50" char="s" size="50" />	
							</td>
						</tr>
						<tr>  
							<th>롤 타입</th>
							<td>
								<select name="roleTyp">
						        	<c:forEach var="cmmCodeDetail" items="${cmmCodeDetailList}" varStatus="status">
						        	<option value="<c:out value="${cmmCodeDetail.code}"/>" <c:if test="${cmmCodeDetail.code == roleManage.roleTyp}">selected</c:if> ><c:out value="${cmmCodeDetail.codeName}"/></option>
						        	</c:forEach>
						      	</select>
							</td>
						</tr>
						<tr>  
							<th>롤 Sort <span class="asterisk">*</span></th>
							<td>
								<input name="roleSort" id="roleSort" type="text" value="<c:out value='${roleManage.roleSort}'/>" required="true" fieldTitle="롤 Sort" maxLength="50" char="s" size="30" />
							</td>
						</tr>
						<tr>  
							<th>등록일자</th>
							<td>
								<input name="roleCreatDe" id="roleCreatDe" type="text" value="<c:out value="${roleManage.roleCreatDe}"/>" required="true" fieldTitle="등록일자" maxLength="50" char="s" size="20" readonly/>
							</td>
						</tr>
					</table>
					<p class="mag_msg2">
						<input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly />
					</p>
				</form:form>
			</div><!-- //managePage -->
			
		</div><!-- //content -->
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
