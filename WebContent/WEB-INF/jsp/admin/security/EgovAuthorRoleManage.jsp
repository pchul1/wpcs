<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovAuthorRoleManage.jsp
	 * Description : 룰관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2009.03.23	lee.m.j		최초 생성
	 * 2013.11.01	lkh			리뉴얼
	 *
	 * author lee.m.j
	 * since 2009.03.23
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

<script type="text/javaScript">
//<![CDATA[
    $(function(){
    	$("input[name='delYn']").change(function(){
    		$(this).parent().find("input[name='authorCode']").attr("checked",(($(this).attr("checked") == undefined) ? false : true));
    		$(this).parent().find("input[name='checkId']").attr("checked",(($(this).attr("checked") == undefined) ? false : true));
    	});

    	$("input[name='checkAll']").change(function(){
    		$("#authorlist").find("input[name='delYn']").attr("checked",(($(this).attr("checked") == undefined) ? false : true));
    		$("#authorlist").find("input[name='authorCode']").attr("checked",(($(this).attr("checked") == undefined) ? false : true));
    		$("#authorlist").find("input[name='checkId']").attr("checked",(($(this).attr("checked") == undefined) ? false : true));
    	});
    });
	
	function fncManageChecked() {
	
		var checkField = document.listForm.delYn;
		var checkId = document.listForm.checkId;
		var checkRegYn = document.listForm.regYn;
		var returnValue = "";
		var returnRegYns = "";
		var checkedCount = 0;
		var returnBoolean = false;
		
		if(checkField) {
			if(checkField.length > 1) {
				for(var i=0; i<checkField.length; i++) {
					if(checkField[i].checked) {
						checkedCount++;
						checkField[i].value = checkId[i].value;
						
						if(returnValue == "") {
							returnValue = checkField[i].value;
							returnRegYns = checkRegYn[i].value;
						}
						else { 
							returnValue = returnValue + ";" + checkField[i].value;
							returnRegYns = returnRegYns + ";" + checkRegYn[i].value;
						}
					}
				}
				
				if(checkedCount > 0) 
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
					returnRegYns = checkRegYn.value;
					
					returnBoolean = true;
				}
			}
		} else {
			alert("조회된 결과가 없습니다.");
		}
		
		document.listForm.roleCodes.value = returnValue;
		document.listForm.regYns.value = returnRegYns;
		
		return returnBoolean;
	
	}
	
	function fncSelectAuthorRoleList() {
		document.listForm.searchCondition.value = "1";
		document.listForm.pageIndex.value = "1";
		document.listForm.action = "<c:url value='/admin/security/EgovAuthorRoleList.do'/>";
		document.listForm.submit();
	}
	
	function fncSelectAuthorList(){
		// document.listForm.searchCondition.value = "1";
		// document.listForm.pageIndex.value = "1";
		document.listForm.searchKeyword.value = "";
		document.listForm.action = "<c:url value='/admin/security/EgovAuthorList.do'/>";
		document.listForm.submit();
	}
	
	function fncSelectAuthorRole(roleCode) {
		document.listForm.roleCode.value = roleCode;
		document.listForm.action = "<c:url value='/admin/security/EgovRole.do'/>";
		document.listForm.submit();
	}
	
	function fncAddAuthorRoleInsert() {
		if(fncManageChecked()) {
			if(confirm("등록하시겠습니까?")) {
				document.listForm.action = "<c:url value='/admin/security/EgovAuthorRoleInsert.do'/>";
				document.listForm.submit();
			}
		} else return;
	}
	
	function linkPage(pageNo){
		document.listForm.searchCondition.value = "1";
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/admin/security/EgovAuthorRoleList.do'/>";
		document.listForm.submit();
	}
	
	
	function press() {
	
		if (event.keyCode==13) {
			fncSelectAuthorRoleList();
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
						
						<form name="listForm" action="/admin/security/EgovAuthorList.do" method="post">
						
							<!--top Search Start-->
							<div class="topBx">
								롤 ID :
								<input name="searchKeyword" type="text" size="30" value="<c:out value="${authorRoleManageVO.searchKeyword}"/>" title="검색" onkeypress="press();" />
								<input type="button" id="btntAuthorRoleList" name="btntAuthorRoleList" value="조회" class="btn btn_basic" onclick="javascript:fncSelectAuthorRoleList();" alt="조회" />
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
								<table summary="그룹정보">
									<colgroup>
										<col width="3%">
										<col width="10%">
										<col width="10%">
										<col width="8%">
										<col width="8%">
										<col>
										<col width="15%">
										<col width="8%">
									</colgroup>
									<thead>
										<tr>
											<th class="noOption"><input type="checkbox" name="checkAll" class="check2"></th>  
											<th>롤 ID</th>
											<th>롤 명</th>
											<th>롤 타입</th>
											<th>롤 Sort</th>
											<th>롤 설명</th>
											<th>등록일자</th>
											<th>등록여부</th>
										</tr>
									</thead>
									<tbody id="authorlist">
										<c:set var="i" value="0" />
										<c:forEach var="authorRole" items="${authorRoleList}" varStatus="status">
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
										<tr class="<c:out value="${even}"/>">
											<td class="noOption">
												<input type="checkbox" name="delYn" class="check2">
												<div style="display:none;">
													<input type="checkbox" name="authorCode" class="check2" value="<c:out value="${authorRole.authorCode}"/>">
													<input type="checkbox" name="checkId"  value="<c:out value="${authorRole.roleCode}"/>" />
												</div>
											</td>
											<td><c:out value="${authorRole.roleCode}"/></td>
											<td><c:out value="${authorRole.roleNm}"/></td>
											<td><c:out value="${authorRole.roleTyp}"/></td>
											<td><c:out value="${authorRole.roleSort}"/></td>
											<td><c:out value="${authorRole.roleDc}"/></td>
											<td><c:out value="${authorRole.creatDt}"/></td>
											<td>
												<select name="regYn">
													<option value="Y" <c:if test="${authorRole.regYn == 'Y'}">selected</c:if> >등록</option>
													<option value="N" <c:if test="${authorRole.regYn == 'N'}">selected</c:if> >미등록</option>
												</select>
											</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
								<c:if test="${!empty groupManageVO.pageIndex }">
									<div class="paging">
										<div id="page_number">
												<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="linkPage"/>
										</div>
									</div>
								</c:if>
								<div style="float:right;margin-top:5px;">
									<input type="button" id="btntAuthorRoleLSearch" name="btntAuthorRoleLSearch" value="목록" class="btn btn_basic" onclick="javascript:fncSelectAuthorRoleList();" alt="목록" />
									<input type="button" id="btnAuthorRoleInsert" name="btnAuthorRoleInsert" value="저장" class="btn btn_basic" onclick="javascript:fncAddAuthorRoleInsert();" alt="저장" />
								</div>
							</div>
							<%-- <p class="mag_msg">
								<input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly />
							</p> --%>
							
							<input type="hidden" name="roleCodes" />
							<input type="hidden" name="regYns" />
							<input type="hidden" name="pageIndex" value="<c:out value='${authorRoleManageVO.pageIndex}'/>" />
							<input type="hidden" name="searchCondition" />
						</form>
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