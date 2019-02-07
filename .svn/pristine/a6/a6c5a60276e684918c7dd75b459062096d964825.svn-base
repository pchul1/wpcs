<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : SmsGroupManage.jsp
	 * Description : 그룹관리 화면
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
<validator:javascript formName="groupManage" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript">

	function fncSelectGroupList() {
		var varFrom = document.getElementById("groupManage");
		varFrom.action = "<c:url value='/admin/security/SmsGroupList.do'/>";
		varFrom.submit();
	}
	
	function fncGroupInsert() {
		var varFrom = document.getElementById("groupManage");
		varFrom.action = "<c:url value='/admin/security/SmsGroupInsert.do'/>";
		
		if(confirm("저장 하시겠습니까?")){
			if(!validateGroupManage(varFrom)){
				return;
			}else{
				varFrom.submit();
			} 
		}
	}
	
	function fncGroupUpdate() {
		var varFrom = document.getElementById("groupManage");
		varFrom.action = "<c:url value='/admin/security/SmsGroupUpdate.do'/>";
	
		if(confirm("저장 하시겠습니까?")){
			if(!validateGroupManage(varFrom)){
				return;
			}else{
				varFrom.submit();
			} 
		}
	}
	
	function fncGroupDelete() {
		var varFrom = document.getElementById("groupManage");
		varFrom.action = "<c:url value='/admin/security/SmsGroupDelete.do'/>";
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
						
						<form:form commandName="groupManage" method="post">
							<div class="table_wrapper">
								<table style="text-align:left" summary="그룹정보">
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<tr>
										<th>그룹 ID <span class="red">*</span></th>
										<td class="txtL"><input name="groupId" id="groupId" type="text" readonly="readonly" value="<c:out value='${groupManage.groupId}'/>" size="40" /></td>
									</tr>
									<tr>  
										<th>그룹 명 <span class="red">*</span></th>
										<td class="txtL"><input name="groupNm" id="groupNm" type="text" value="<c:out value='${groupManage.groupNm}'/>" required="true" fieldtitle="그룹 명" maxlength="50" char="s" size="40" />&nbsp;<form:errors path="groupNm" /></td>
									</tr>
									<tr>  
										<th>설명</th>
										<td class="txtL"><input name="groupDc" id="groupDc" type="text" value="<c:out value="${groupManage.groupDc}"/>" required="true" fieldtitle="설명" maxlength="50" char="s" size="50" /></td>
									</tr>
									<tr>  
										<th>등록일자</th>
										<td class="txtL"><input name="groupCreatDe" id="groupCreatDe" type="text" value="<c:out value="${groupManage.groupCreatDe}"/>" required="true" fieldtitle="등록일자" maxlength="50" char="s" size="80" readonly="readonly" /></td>
									</tr>
								</table>
							</div>
							
							<!-- 검색조건 유지 -->
							<input type="hidden" name="searchCondition" value="<c:out value='${groupManageVO.searchCondition}'/>"/>
							<input type="hidden" name="searchKeyword" value="<c:out value='${groupManageVO.searchKeyword}'/>"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
						</form:form>
						<!--top Search Start-->
						<div class="topBx">
							<input type="button" id="btnGroupList" name="btnGroupList" value="목록" class="btn btn_basic" onclick="javascript:fncSelectGroupList();" alt="목록" />
							<input type="button" id="btnGroupUpdate" name="btnGroupUpdate" value="수정" class="btn btn_basic" onclick="javascript:fncGroupUpdate();" alt="수정" />
							<input type="button" id="btnGroupDelete" name="btnGroupDelete" value="삭제" class="btn btn_basic" onclick="javascript:fncGroupDelete();" alt="삭제" />
						</div>
						<!--top Search End-->
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