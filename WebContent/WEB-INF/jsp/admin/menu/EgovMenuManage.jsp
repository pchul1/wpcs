<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovMenuManage.jsp
	 * Description : 메뉴관리 리스트형태 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.06.14	kisspa		최초 수정
	 * 2013.11.01	lkh			리뉴얼
	 * 
	 * author
	 * since 2010.06.14
	 * 
	 * Copyright (C) 2010 by kisspa All right reserved.
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
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
	var checkField = document.menuManageForm.checkField;
	if(document.menuManageForm.checkAll.checked) {
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
/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteMenuList() {
	var checkField = document.menuManageForm.checkField;
	var menuNo = document.menuManageForm.checkMenuNo;
	var checkMenuNos = "";
	var checkedCount = 0;
	if(checkField) {

		if(checkField.length > 1) {
			for(var i=0; i < checkField.length; i++) {
				if(checkField[i].checked) {
					checkMenuNos += ((checkedCount==0? "" : ",") + menuNo[i].value);
					checkedCount++;
				}
			}
		} else {
			if(checkField.checked) {
				checkMenuNos = menuNo.value;
			}
		}
	}

	document.menuManageForm.checkedMenuNoForDel.value=checkMenuNos;
	document.menuManageForm.action = "<c:url value='/admin/menu/EgovMenuManageListDelete.do'/>";
	document.menuManageForm.submit(); 
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
//	document.menuManageForm.searchKeyword.value = 
	document.menuManageForm.pageIndex.value = pageNo;
	document.menuManageForm.action = "<c:url value='/admin/menu/EgovMenuManageSelect.do'/>";
	document.menuManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuManageList() { 
	document.menuManageForm.pageIndex.value = 1;
	document.menuManageForm.action = "<c:url value='/admin/menu/EgovMenuManageSelect.do'/>";
	document.menuManageForm.submit();
}

/* ********************************************************
 * 입력 화면 호출 함수
 ******************************************************** */
function insertMenuManage() {
	document.menuManageForm.action = "<c:url value='/admin/menu/EgovMenuRegistInsert.do'/>";
	document.menuManageForm.submit();	
}

/* ********************************************************
 * 일괄처리 화면호출 함수
 ******************************************************** */
 function bndeInsertMenuManage() {
		document.menuManageForm.action = "<c:url value='/admin/menu/EgovMenuRegistInsert.do'/>";
		document.menuManageForm.submit();	
	}
 
function bndeInsertMenuManage() {
	document.menuManageForm.action = "<c:url value='/admin/menu/EgovMenuBndeRegist.do'/>";
	document.menuManageForm.submit();
} 
/* ********************************************************
 * 상세조회처리 함수
 ******************************************************** */
function selectUpdtMenuManageDetail(menuNo) {
	document.menuManageForm.req_menuNo.value = menuNo;
	document.menuManageForm.action = "<c:url value='/admin/menu/EgovMenuManageListDetailSelect.do'/>";
	document.menuManageForm.submit();	
}
/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuManageSelect(){ 
	document.menuManageForm.action = "<c:url value='/admin/menu/EgovMenuManageSelect.do'/>";
	document.menuManageForm.submit();
}

function press() {

	if (event.keyCode==13) {
		selectMenuManageList();
	}
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
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
						
						<form name="menuManageForm" action ="javascript:fMenuManageSelect();" method="post">
						
							<!--top Search Start-->
							<div class="topBx">
								메뉴 한글명 :
								<input type="text" name="searchKeyword" size="25" title="검색" onkeypress="press();">
								<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:selectMenuManageList();" alt="조회" />
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
							
								<table summary="메뉴정보">
									<colgroup>
										<col width="45" />
										<col width="80" />
										<col width="200" />
										<col width="60" />
										<col />
										<col width="80" />
									</colgroup>
									<thead>
										<tr>
											<th>
												<input type="checkbox" name="checkAll" onclick="javascript:fCheckAll();">
											</th>
											<th>메뉴 ID</th>
											<th>메뉴한글명</th>
											<th>메뉴순서</th>
											<th>메뉴설명</th>
											<th>상위메뉴 ID</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach var="result" items="${list_menumanage}" varStatus="status">
											<c:set var = "checkFilterNo" value="${filterNo}" />
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
										<tr class="<c:out value="${even}"/>"> 
											<td>
												<input type="checkbox" name="checkField" />
												<input type="hidden" name="checkMenuNo" value="<c:out value='${result.menuNo}'/>" />
											</td> 
											<td><c:out value="${result.menuNo}"/></td> 
											<td><a href="javascript:selectUpdtMenuManageDetail('<c:out value="${result.menuNo}"/>')"><c:out value="${result.menuNm}"/></a></td> 
											<td><c:out value="${result.menuOrdr}"/></td>
											<td><c:out value="${result.menuDc}" escapeXml="false"/></td>
											<td><c:out value="${result.upperMenuId}"/></td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="paging">
									<div id="page_number">
										<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="linkPage" />
									</div>
								</div>
								<div style="float:right;margin-top:5px;">
									<input type="button" id="btnInsMenu" name="btnInsMenu" value="등록" class="btn btn_basic" onclick="javascript:insertMenuManage();" alt="등록" />
									<input type="button" id="btnDelMenu" name="btnDelMenu" value="삭제" class="btn btn_basic" onclick="javascript:fDeleteMenuList();" alt="삭제" />
								</div>
<!-- 							<p class="mag_msg"><input type="text" class="inputText" name="message" value="정상적으로 조회되었습니다." size="30" readonly></p> -->
								
							</div>
							
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
							<input type="hidden" name="checkedMenuNoForDel" /> 
							<input type="hidden" name="req_menuNo" />
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