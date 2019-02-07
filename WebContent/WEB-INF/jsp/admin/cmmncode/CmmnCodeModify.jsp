<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : CmmnCodeModify.jsp
	* Description : 공통카테고리 상세수정 화면
	* Modification Information
	* 
	* 수정일			수정자			수정내용
	* ----------	--------	---------------------------
	* 2010.06.18	kisspa		최초 생성
	* 2013.11.19	lkh			리뉴얼
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
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnCode" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
//<![CDATA[
	//목록 으로 가기
	function fn_egov_list_CmmnCode(){
		location.href = "<c:url value='/admin/cmmncode/CmmnCodeList.do'/>";
	}
	
	//저장처리화면
	function fn_egov_modify_CmmnCode(form){
		if(confirm("<spring:message code="common.save.msg" />")){
			if(!validateCmmnCode(form)){
				return;
			}else{
				form.submit();
			}
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
							<input type="button" id="btnFnEgovist" name="btnFnEgovist" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_list_CmmnCode();" alt="목록"/>
							<input type="button" id="btnFnEgovUpdate" name="btnFnEgovUpdate" value="저장" class="btn btn_basic" onclick="javaScript:fn_egov_modify_CmmnCode(document.cmmnCode);" alt="저장"/>
						</div>
						
						<div class="table_wrapper">
							
							<form:form commandName="cmmnCode" name="cmmnCode" method="post">
								<input name="cmd" type="hidden" value="Modify">
								<form:hidden path="codeId"/>
								
								<table summary="코드정보" style="text-align:left;">
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<tr>
										<th>코드 ID <span class="red">*</span></th>
										<td>${cmmnCode.codeId}</td>
									</tr>
									<tr>  
										<th>코드 ID 명 <span class="red">*</span></th>
										<td>
											<form:input  path="codeIdName" size="60" maxlength="60"/>
											<form:errors path="codeIdName"/>
										</td>
									</tr>
									<tr>  
										<th>코드 ID 설명 <span class="red">*</span></th>
										<td style="padding:4px">
											<form:textarea path="codeIdDesc" rows="6" cols="130"/>
											<form:errors	path="codeIdDesc"/>
										</td>
									</tr>
									<tr>  
										<th>사용여부</th>
										<td>
											<form:select path="useFlag">
												<form:option value="Y" label="Yes"/>
												<form:option value="N" label="No"/>
											</form:select>
										</td>
									</tr>
								</table>
							</form:form>
							
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