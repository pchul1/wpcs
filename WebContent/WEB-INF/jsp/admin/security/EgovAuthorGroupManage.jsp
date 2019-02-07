<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovAuthorGroupManage.jsp
	 * Description : 사용자권한지정 화면
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
		
		var resultCheck = false;
		
		var checkField = document.listForm.delYn;
		var checkId = document.listForm.checkId;
		var selectAuthor = document.listForm.authorManageCombo;
		var booleanRegYn = document.listForm.regYn;
			
		var returnId = "";
		var returnAuthor = "";
		var returnRegYn = "";
		
		var checkedCount = 0;
		
		if(checkField) {
			if(checkField.length > 1) {
				for(var i=0; i<checkField.length; i++) {
					if(checkField[i].checked) {
						checkedCount++;
						checkField[i].value = checkId[i].value;
						if(returnId == "") {
							returnId = checkField[i].value;
							returnAuthor = selectAuthor[i].value;
							returnRegYn = booleanRegYn[i].value;
						}
						else {
							returnId = returnId + ":" + checkField[i].value;
							returnAuthor = returnAuthor + ":" + selectAuthor[i].value;
							returnRegYn = returnRegYn + ":" + booleanRegYn[i].value;
						}
					}
				}
				
				if(checkedCount > 0) 
					resultCheck = true;
				else {
					alert("선택된  항목이 없습니다.");
					resultCheck = false;
				}
				
			} else {
				 if(document.listForm.delYn.checked == false) {
					alert("선택 항목이 없습니다.");
					resultCheck = false;
				}
				else {
					returnId = checkId.value;
					returnAuthor = selectAuthor.value;
					returnRegYn = booleanRegYn.value;
					
					resultCheck = true;
				}
			} 
		} else {
			alert("조회된 결과가 없습니다.");
		}
		
		document.listForm.userIds.value = returnId;
		document.listForm.authorCodes.value = returnAuthor;
		document.listForm.regYns.value = returnRegYn;
		
		return resultCheck;
	}
	
	function fncSelectAuthorGroupList(pageNo){
		//document.listForm.searchCondition.value = "1";
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/admin/security/EgovAuthorGroupList.do'/>";
		document.listForm.submit();
	}
	
	function fncAddAuthorGroupInsert() {
		if(!fncManageChecked()) return;
		
		if(confirm("등록하시겠습니까?")) {
			document.listForm.action = "<c:url value='/admin/security/EgovAuthorGroupInsert.do'/>";
			document.listForm.submit();
		}
	}
	
	function fncAuthorGroupDeleteList() {
		if(!fncManageChecked()) return;
	//2016-02-25 comment 변경 : 삭제하시겠습니까? -> 권한을 해제하시겠습니까?
		if(confirm("권한을 해제하시겠습니까?")) {
			document.listForm.action = "<c:url value='/admin/security/EgovAuthorGroupDelete.do'/>";
			document.listForm.submit(); 
		}
	}
	
	function linkPage(pageNo){
		//document.listForm.searchCondition.value = "1";
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/admin/security/EgovAuthorGroupList.do'/>";
		document.listForm.submit();
	}
	
	function fncSelectAuthorGroupPop() {
	
		if(document.listForm.searchCondition.value == '3') {
			window.open("/admin/security/EgovGroupSearchView.do","notice","height=480,width=630,top=50,left=20,scrollbars=yes,resizable=yes");
		} else {
			alert("조회 조건을 그룹으로 선택하세요.");
			return;
		}
		
		/*
		var url = "<c:url value='/cmm/sec/ram/EgovGroupSearchView.do'/>";
		var varParam = new Object();
		var openParam = "dialogWidth:500px;dialogHeight:485px;scroll:no;status:no;center:yes;resizable:yes;";
		var retVal;
	
		if(document.listForm.searchCondition.value == '3') {
			retVal = window.showModalDialog(url, varParam, openParam);
			if(retVal) {
				document.listForm.searchKeyword.value = retVal;
			}
		} else {
			alert("그룹을 선택하세요.");
			return;
		}
		*/
	
	}

	function onSearchCondition() {
		document.listForm.searchKeyword.value = "";
		if(document.listForm.searchCondition.value == '3') {
			document.listForm.searchKeyword.readOnly = true;
		} else {
			document.listForm.searchKeyword.readOnly = false;
		}
	}
	
	function press() {
	
		if (event.keyCode==13) {
			fncSelectAuthorGroupList('1');
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
					
						<form name="listForm" _action="/admin/security/EgovAuthorList.do" method="post">
						
							<!--top Search Start-->
							<div class="topBx">
								
								조회조건 :
								<select id="searchCondition" name="searchCondition" class="select" onchange="onSearchCondition()">
									<option value="1" <c:if test="${authorGroupVO.searchCondition == '1'}">selected</c:if> >사용자 ID</option>
									<option value="2" <c:if test="${authorGroupVO.searchCondition == '2'}">selected</c:if> >사용자 명</option>
									<option value="3" <c:if test="${authorGroupVO.searchCondition == '3'}">selected</c:if> >그룹</option>
								</select>
								<input id="searchKeyword" name="searchKeyword" type="text" class="fixWidth13" value="${authorGroupVO.searchKeyword}" maxlength="35" onkeydown="javascript:if(event.keyCode==13) reloadData()">
<%--								<input name="searchKeyword" type="text" value="<c:out value="${authorGroupVO.searchKeyword}"/>" size="25" title="검색" onkeypress="press();" /> --%>
								<input type="button" id="btnAuthorGroupPop" name="btnAuthorGroupPop" value="그룹찾기" class="btn btn_search" onclick="javascript:fncSelectAuthorGroupPop();" alt="그룹찾기" />
								<input type="button" id="btnAuthorGroupList" name="btnAuthorGroupList" value="조회" class="btn btn_search" onclick="javascript:fncSelectAuthorGroupList('1');" alt="조회" />
<!-- 								<input type="button" id="btnAuthorGroupList" name="btnAuthorGroupList" value="조회" class="btn btn_search" onclick="javascript:reloadData();" alt="조회" /> -->
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
								<table summary="그룹정보">
									<colgroup>
										<col width="3%">
										<col width="10%">
										<col width="10%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
									</colgroup>
									<thead> 
										<tr> 
											<th class="noOption"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()"></th>  
											<th>사용자 ID</th> 
											<th>사용자 명</th> 
											<th>관련부서</th>
											<th>그룹</th>
											<th>권한</th> 
											<th>등록여부</th> 
										</tr> 
									</thead> 
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach var="authorGroup" items="${authorGroupList}" varStatus="status">
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
											<tr class="<c:out value="${even}"/>"> 
												<td><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${authorGroup.uniqId}"/>" /></td> 
												<td><c:out value="${authorGroup.userId}"/></td> 
												<td><c:out value="${authorGroup.userNm}"/></td> 
												<td><c:out value="${authorGroup.deptNoName}"/></td>
												<td><c:out value="${authorGroup.groupName}"/></td>
												<td>
													<select name="authorManageCombo">
														<c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
															<option value="<c:out value="${authorManage.authorCode}"/>" 
																<c:if test="${authorManage.authorCode == authorGroup.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/>
															</option>
														</c:forEach>
													</select>
												</td> 
<%-- 												<td><c:out value="${authorGroup.regYn}"/><input type="hidden" name="regYn" value="<c:out value="${authorGroup.regYn}"/>"></td> --%>
												<td><c:out value="${authorGroup.regYn == 'Y' ? '등록' : '미등록'}"/><input type="hidden" name="regYn" value="<c:out value="${authorGroup.regYn}"/>"></td> 
											</tr> 
										</c:forEach>
									</tbody>
								</table>
<%-- 								${authorGroupVO} --%>
								<c:if test="${!empty authorGroupVO.pageIndex }">
									<div class="paging">
										<div id="page_number">
											<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="linkPage"/>
										</div>
									</div>
									<div style="float:right;">
										<input type="button" id="btnAuthorGroupInsert" name="btnAuthorGroupInsert" value="등록" class="btn btn_basic" onclick="javascript:fncAddAuthorGroupInsert();" alt="등록" />
										<!-- 2016-02-25 삭제에서 권한해제로 변경 -->
										<input type="button" id="btnAuthorGroupDeleteList" name="btnAuthorGroupDeleteList" value="권한해제" class="btn btn_basic" onclick="javascript:fncAuthorGroupDeleteList();" alt="권한해제" />
									</div>
								</c:if>
							</div>
							
<%-- 						<p class="mag_msg"><input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly/></p> --%>
							
							<!-- 검색조건 유지 -->
							<input type="hidden" name="userId"/>
							<input type="hidden" name="userIds"/>
							<input type="hidden" name="authorCodes"/>
							<input type="hidden" name="regYns"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${authorGroupVO.pageIndex}'/>"/>
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