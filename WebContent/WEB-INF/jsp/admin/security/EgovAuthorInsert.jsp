<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovAuthorInsert.jsp
	 * Description : 그룹관리등록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2009.02.01	lee.m.j		최초 생성
	 * 2013.11.01	lkh			리뉴얼
	 *
	 * author lee.m.j
	 * since 2009.02.01
	 *  
	 * Copyright (C) 2009 by lee.m.j  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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

</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
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
						
							<div class="table_wrapper">
								<table  style="text-align:left" summary="그룹정보" >
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<thead>
									<tr>
										<th>권한  코드 <span class="red">*</span></th>
										<td class="txtL">
											<input name="authorCode" id="authorCode" type="text" value="<c:out value='${authorManage.authorCode}'/>" size="40" />&nbsp;<form:errors path="authorCode" />
										</td>
									</tr>
									<tr>  
										<th>권한 명 <span class="red">*</span></th>
										<td class="txtL">
											<input name="authorNm" id="authorNm" type="text" value="<c:out value='${authorManage.authorNm}'/>" required="true" fieldTitle="권한 명" maxLength="50" char="s" size="40" />&nbsp;<form:errors path="authorNm" />
										</td>
									</tr>
									<tr>  
										<th>설명</th>
										<td class="txtL">
											<input name="authorDc" id="authorDc" type="text" value="<c:out value="${authorManage.authorDc}"/>" required="true" fieldTitle="설명" maxLength="50" char="s" size="50" />	
										</td>
									</tr>
									<tr>
										<th>등록일자</th>
										<td class="txtL">
											<input name="authorCreatDe" id="authorCreatDe" type="text" value="<c:out value="${authorManage.authorCreatDe}"/>" required="true" fieldTitle="등록일자" maxLength="50" char="s" size="80" readonly/>
										</td>
									</tr>
									</thead>
								</table>
							</div>
							<!--top Search Start-->
							<div class="topBx">
								<input type="button" id="btnGroupList" name="btnGroupList" value="목록" class="btn btn_basic" onclick="javascript:fncSelectAuthorList();" alt="목록" />
								<input type="button" id="btnGroupInsert" name="btnGroupInsert" value="등록" class="btn btn_basic" onclick="javascript:fncAuthorInsert();" alt="등록" />
							</div>
							<!--top Search End-->
						</form:form>
						
					</div>
					<!--tab Contnet End-->
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