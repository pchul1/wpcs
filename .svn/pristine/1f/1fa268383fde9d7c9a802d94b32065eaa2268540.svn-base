<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovProgramListDetailSelectUpdt.jsp
	 * Description : 프로그램목록 상세조회및 수정 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2009.03.10	이용			최초 생성
	 * 2013.11.19	lkh			리뉴얼
	 * 
	 * author 공통서비스 개발팀 이용
	 * since 2009.03.10
	 * 
	 * Copyright (C) 2010 by 이용  All right reserved.
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
<validator:javascript formName="progrmManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
	<!--
	//수정처리 함수
	function updateProgramList(form) {
		if(confirm("<spring:message code="common.save.msg" />")){
			if(!validateProgrmManageVO(form)){
				alert("문제");
				return;
			}else{
				alert("성공");
				form.action="<c:url value='/admin/menu/EgovProgramListDetailSelectUpdt.do'/>";
				form.submit();
			}
		}
	}
	
	//삭제처리함수
	function deleteProgramList(form) {
		if(confirm("<spring:message code="common.delete.msg" />")){
			form.action="<c:url value='/admin/menu/EgovProgramListManageDelete.do'/>";
			form.submit();
		}
	}
	
	//목록조회 함수
	function selectList(){
		location.href = "<c:url value='/admin/menu/EgovProgramListManageSelect.do'/>";
	}
	
	<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
	//-->
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
							<input type="button" id="btnSelectList" name="btnSelectList" value="목록" class="btn btn_basic" onclick="javascript:selectList();" alt="목록"/>
							<input type="button" id="btnProgramUpdate" name="btnProgramUpdate" value="수정" class="btn btn_basic" onclick="javascript:updateProgramList(document.forms[1]);" alt="수정"/>
							<input type="button" id="btnProgramDelete" name="btnProgramDelete" value="삭제" class="btn btn_basic" onclick="javascript:deleteProgramList(document.forms[1]);" alt="삭제"/>
						</div>
						
						<div class="table_wrapper">
						
							<form:form commandName="progrmManageVO" >
								<input name="cmd" type="hidden" value="<c:out value='update'/>"/>
								
								<table summary="프로그램정보" style="text-align:left">
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<tr>
										<th>프로그램 파일명 <span class="red">*</span></th>
										<td>
											<form:input path="progrmFileNm" size="60" maxlength="50"/>
											<form:errors path="progrmFileNm"/>
										</td>
									</tr>
									<tr>
										<th>저장경로 <span class="red">*</span></th>
										<td>
<%-- 											<form:input path="progrmStrePath" size="60" maxlength="100"/> --%>
											<input type="text" name="progrmStrePath" size="60" maxlength="100" value="<c:out value="${progrmManageVO.progrmStrePath}" escapeXml="false"/>"/>
											<form:errors path="progrmStrePath"/>
										</td>
									</tr>
									<tr>
										<th>한글명 <span class="red">*</span></th>
										<td>
											<form:input path="progrmKoreanNm" size="60" maxlength="50"/>
											<form:errors path="progrmKoreanNm"/>
										</td>
									</tr>
									<tr>
										<th>URL <span class="red">*</span></th>
										<td>
											<form:input path="URL" size="60" maxlength="100"/>
											<form:errors path="URL"/>
										</td>
									</tr>
									<tr>
										<th>프로그램 설명</th>
										<td style="padding:4px">
<%-- 											<form:textarea path="progrmDc" rows="6" cols="130"/> --%>
											<textarea class="txaClass" name="menuDc" cols="130" rows="6"><c:out value="${progrmManageVO.progrmDc}" escapeXml="false"/></textarea>
											<form:errors path="progrmDc"/>
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