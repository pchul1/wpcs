<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : EgovAuthorUpdate.jsp
	 * Description : 권한관리변경 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2009.02.01	lee.m.j		  최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * author lee.m.j
	 * since 2009.03.11
	 * 
	 * Copyright (C) 2010 by lee.m.j All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="authorManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript">
//<![CDATA[
	function fncSelectAuthorList() {
		var varFrom = document.getElementById("authorManage");
		varFrom.action = "<c:url value='/admin/security/EgovAuthorList.do'/>";
		varFrom.submit();
	}
	
	function fncAuthorInsert() {
		
		var varFrom = document.getElementById("authorManage");
		varFrom.action = "<c:url value='/admin/security/EgovAuthorInsert.do'/>";
		
		if(confirm("저장 하시겠습니까?")){
			if(!validateAuthorManage(varFrom)){
				return;
			}else{
				varFrom.submit();
			} 
		}
	}
	
	function fncAuthorUpdate() {
		var varFrom = document.getElementById("authorManage");
		varFrom.action = "<c:url value='/admin/security/EgovAuthorUpdate.do'/>";
		
		if(confirm("저장 하시겠습니까?")){
			if(!validateAuthorManage(varFrom)){
				return;
			}else{
				varFrom.submit();
			}
		}
	}
	
	function fncAuthorDelete() {
		var varFrom = document.getElementById("authorManage");
		varFrom.action = "<c:url value='/admin/security/EgovAuthorDelete.do'/>";
		if(confirm("삭제 하시겠습니까?")){
			varFrom.submit();
		}
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
	<div id="wrap">
		
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
						
					<!--tab Contnet Start-->
					<div class="tab_container">
						
						<form:form commandName="authorManage" method="post" >
							
							<div class="topBx" style="display:none;">
								그룹 명 :
								<input id="searchKeyword" name="searchKeyword" type="text" class="fixWidth13" value="${groupManageVO.searchKeyword}" maxlength="35" onkeydown=" javascript:if(event.keyCode==13)fncSelectAuthorList('1');" />
								<input type="button" id="btnInitlDeptList" name="btnInitlDeptList" value="목록" class="btn btn_search" onclick="javascript:fncSelectAuthorList();" alt="목록" />
								<input type="button" id="btnInsertDeptList" name="btnInsertDeptList" value="수정" class="btn btn_search" onclick="javascript:fncAuthorUpdate();" alt="수정" />
								<input type="button" id="btnDeleteDeptList" name="btnDeleteDeptList" value="삭제" class="btn btn_search" onclick="javascript:fncAuthorDelete();" alt="삭제" />
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
								<table class="dataTable" style="text-align:left" summary="그룹정보">
									<colgroup>
										<col width="20%" />
										<col />
									</colgroup>
									<tr>
										<th>권한  코드 <span class="red">*</span></th>
										<td>
											<input name="authorCode" id="authorCode" type="text" readonly="readonly" value="<c:out value='${authorManage.authorCode}'/>" size="40" />&nbsp;<form:errors path="authorCode" />
										</td>
									</tr>
									<tr>
										<th>권한 명 <span class="red">*</span></th>
										<td>
											<input name="authorNm" id="authorNm" type="text" value="<c:out value='${authorManage.authorNm}'/>" required="true" fieldtitle="권한 명" maxlength="50" char="s" size="40" />&nbsp;<form:errors path="authorNm" />
										</td>
									</tr>
									<tr>
										<th>설명</th>
										<td><input name="authorDc" id="authorDc" type="text" value="<c:out value="${authorManage.authorDc}"/>" required="true" fieldtitle="설명" maxlength="50" char="s" size="50" /></td>
									</tr>
									<tr>
										<th>등록일자</th>
										<td><input name="authorCreatDe" id="authorCreatDe" type="text" value="<c:out value="${authorManage.authorCreatDe}"/>" required="true" fieldtitle="등록일자" maxlength="50" char="s" size="80" readonly="readonly" /></td>
									</tr>
								</table>
							</div>
							
							<!-- 검색조건 유지 -->
							<input type="hidden" name="searchCondition" value="<c:out value='${authorManageVO.searchCondition}'/>"/>
							<input type="hidden" name="searchKeyword" value="<c:out value='${authorManageVO.searchKeyword}'/>"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
						</form:form>
					</div>
					<!--//tab Contnet Start-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>