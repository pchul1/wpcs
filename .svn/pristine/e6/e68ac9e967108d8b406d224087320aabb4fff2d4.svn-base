<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : CmmnDetailCodeDetail.jsp
	* Description : 공통코드관리 상세 화면
	* Modification Information
	* 
	* 수정일				수정자					수정내용
	* ----------		--------	---------------------------
	* 2010.06.18		kisspa			최초 생성
	* 2013.11.19		lkh		리뉴얼
	* 
	* author kisspa
	* since 2010.06.18
	* 
	* Copyright (C) 2010 by kisspa  All right reserved.
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
<script type="text/javascript">
//<![CDATA[
	//초기화
	function fnInit(){
	}
	
	//목록 으로 가기
	function fnList(){
		location.href = "<c:url value='/admin/cmmncode/CmmnDetailCodeList.do'/>";
	}
	
	//수정화면으로  바로가기
	function fnModify(){
		var varForm = document.all["Form"];
		varForm.action = "<c:url value='/admin/cmmncode/CmmnDetailCodeModify.do'/>";
		varForm.codeId.value = "${result.codeId}";
		varForm.code.value = "${result.code}";
		varForm.submit();
	}
	
	//삭제 처리 함수
	function fnDelete(){
		if (confirm("<spring:message code="common.delete.msg" />")) {
			var varForm = document.all["Form"];
			varForm.action = "<c:url value='/admin/cmmncode/CmmnDetailCodeRemove.do'/>";
			varForm.codeId.value = "${result.codeId}";
			varForm.code.value = "${result.code}";
			varForm.submit();
		}
	}
//]]>
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
						<div class="topBx">
							<input type="button" id="btnFnList" name="btnFnList" value="목록" class="btn btn_basic" onclick="javascript:fnList();" alt="목록"/>
							<input type="button" id="btnFnUpdate" name="btnFnUpdate" value="수정" class="btn btn_basic" onclick="javascript:fnModify();" alt="수정"/>
							<input type="button" id="btnFnDelete" name="btnFnDelete" value="삭제" class="btn btn_basic" onclick="javascript:fnDelete();" alt="삭제"/>
						</div>
						<div class="table_wrapper">
							${result}
							<form name="Form" action="" method="post">
								<input type=hidden name="codeId">
								<input type=hidden name="code">
							</form>
							<table summary="코드정보" style="text-align:left;">
								<colgroup>
									<col width="20%">
									<col>
								</colgroup>
								<tr>
									<th>코드 ID 명<span class="red">*</span></th>
									<td>${result.codeIdName}</td>
								</tr>
								<tr>  
									<th>코드<span class="red">*</span></th>
									<td>${result.code}</td>
								</tr>
								<tr>  
									<th>코드명<span class="red">*</span></th>
									<td>${result.codeName}</td>
								</tr>
								<tr>  
									<th>코드설명<span class="red">*</span></th>
									<td style="padding:4px">
										<textarea class="textarea"  cols="130" rows="6" disabled="disabled">${result.codeDesc}</textarea>
									</td>
								</tr>
								<tr>  
									<th>정렬순서</th>
									<td>${result.codeOrder}</td>
								</tr>
								<tr>
									<th>사용여부</th>
									<td>
										<select name="useFlag" disabled="disabled">
											<option value="Y" <c:if test="${result.useFlag == 'Y'}">selected="selected"</c:if> >Yes</option>
											<option value="N" <c:if test="${result.useFlag == 'N'}">selected="selected"</c:if> >No</option>
										</select>
									</td>
								</tr>
							</table>
						</div>
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