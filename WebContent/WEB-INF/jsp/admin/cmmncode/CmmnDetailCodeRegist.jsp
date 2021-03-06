<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : CmmnDetailCodeRegist.jsp
	 * Description : 카테고리등록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.06.18	이중호			최초 생성
	 * 2013.12.05	lhk			리뉴얼
	 *
	 * author kisspa
	 * since 2010.06.18
	 * version 1.0 
	 * see 
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
<validator:javascript formName="cmmnDetailCode" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
<!--
	//목록 으로 가기
	function fn_egov_list_CmmnDetailCode(){
		location.href = "<c:url value='/admin/cmmncode/CmmnDetailCodeList.do'/>";
	}
	
	//저장처리화면
	function fn_egov_regist_CmmnDetailCode(form){
		if(confirm("<spring:message code="common.save.msg" />")){
			if(!validateCmmnDetailCode(form)){
				return;
			}else{
				form.cmd.value = "Regist";
				form.submit();
			}
		}
	}
	
	//CodeId 가져오기
	function fn_egov_get_CodeId(form){
		form.cmd.value = "";
		form.submit();
	}
-->
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
					
						<form:form commandName="cmmnDetailCode" name="cmmnDetailCode" method="post">
							<input name="cmd" type="hidden" value="<c:out value='Regist'/>"/>
							
							<!--top Search Start-->
							<div class="topBx">
								<input type="button" id="btnEgovListCmmnCode" name="btnEgovListCmmnCode" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_list_CmmnDetailCode();" alt="목록" />
								<input type="button" id="btnEgovRegistCmmnCode" name="btnEgovRegistCmmnCode" value="저장" class="btn btn_basic" onclick="javascript:fn_egov_regist_CmmnDetailCode(document.cmmnDetailCode);" alt="저장" />
							</div>
							<!--top Search End-->
							
							<table summary="카테고리정보" style="text-align:left;margin-top:10px">
								<colgroup>
									<col width="20%">
									<col>
								</colgroup>
								<tr>
									<th>코드 ID<span class="red">*</span></th>
									<td>
										<select name="codeId" class="select">
											<c:forEach var="result" items="${cmmnCodeList}" varStatus="status">
											<option value='<c:out value="${result.codeId}"/>'><c:out value="${result.codeIdName}"/></option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>  
									<th>코드<span class="red">*</span></th>
									<td>
										<form:input  path="code" size="15" maxlength="15"/>
										<form:errors path="code"/>
									</td>
								</tr>
								<tr>  
									<th>코드명<span class="red">*</span></th>
									<td>
										<form:input  path="codeName" size="60" maxlength="60"/>
										<form:errors path="codeName"/>
									</td>
								</tr>
								<tr>  
									<th>코드설명<span class="red">*</span></th>
									<td>
										<form:textarea path="codeDesc" rows="6" cols="60"/>
										<form:errors path="codeDesc"/>
									</td>
								</tr>
								<tr>  
									<th>정렬순서</th>
									<td>
										<form:input  path="codeOrder" size="60" maxlength="60"/>
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