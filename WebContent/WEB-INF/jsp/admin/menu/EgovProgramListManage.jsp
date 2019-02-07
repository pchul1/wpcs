<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : EgovProgramListManage.jsp
	* Description : 프로그램목록조회 화면
	* Modification Information
	* 
	* 수정일			수정자			수정내용
	* -------		--------	---------------------------
	* 2009.03.10	이용			최초 수정
	* 2013.11.01	lkh			리뉴얼
	* 
	* author 공통서비스개발팀 이용
	* since 2009.03.10
	* 
	* Copyright (C) 2009 by 이용 All right reserved.
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
	//모두선택 처리 함수
	function fCheckAll() {
		var checkField = document.progrmManageForm.checkField;
		if(document.progrmManageForm.checkAll.checked) {
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
	
	//멀티삭제 처리 함수
	function fDeleteProgrmManageList() {
		var checkField = document.progrmManageForm.checkField;
		var ProgrmKoreanNm = document.progrmManageForm.checkProgrmKoreanNm;
		var checkProgrmKoreanNms = "";
		var checkedCount = 0;
		if(checkField) {
			if(checkField.length > 1) {
				for(var i=0; i < checkField.length; i++) {
					if(checkField[i].checked) {
						checkProgrmKoreanNms += ((checkedCount==0? "" : ",") + ProgrmKoreanNm[i].value);
						checkedCount++;
					}
				}
			} else {
				if(checkField.checked) {
					checkProgrmKoreanNms = ProgrmKoreanNm.value;
				}
			}
		}	
	
		document.progrmManageForm.checkedProgrmKoreanNmForDel.value=checkProgrmKoreanNms;
		document.progrmManageForm.action = "<c:url value='/admin/menu/EgovProgrmManageListDelete.do'/>";
		document.progrmManageForm.submit();
	}
	//페이징 처리 함수
	function linkPage(pageNo){
	//	document.menuManageForm.searchKeyword.value = 
		document.progrmManageForm.pageIndex.value = pageNo;
		document.progrmManageForm.action = "<c:url value='/admin/menu/EgovProgramListManageSelect.do'/>";
		document.progrmManageForm.submit();
	}
	
	//조회 처리 함수
	function selectProgramListManage() {
		document.progrmManageForm.pageIndex.value = 1;
		document.progrmManageForm.action = "<c:url value='/admin/menu/EgovProgramListManageSelect.do'/>";
		document.progrmManageForm.submit();
	}
	
	//입력 화면 호출 함수
	function insertProgramListManage() {
		document.progrmManageForm.action = "<c:url value='/admin/menu/EgovProgramListRegist.do'/>";
		document.progrmManageForm.submit();
	}
	
	//상세조회처리 함수
	function selectUpdtProgramListDetail(progrmFileNm) {
		document.progrmManageForm.tmp_progrmNm.value = progrmFileNm;
		document.progrmManageForm.action = "<c:url value='/admin/menu/EgovProgramListDetailSelect.do'/>";
		document.progrmManageForm.submit();
	}
	
	//focus 시작점 지정함수
	function fn_FocusStart(){
		var objFocus = document.getElementById('F1');
		objFocus.focus();
	}
	
	function press() {
	
		if (event.keyCode==13) {
			selectProgramListManage();
		}
	}
	<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
//]]>
</script>
</head>

<body onfocus="fn_FocusStart()"> 
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
						
						<form name="progrmManageForm" action ="/admin/menu/EgovProgramListManageSelect.do" method="post">
							<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
							<input name="checkedProgrmKoreanNmForDel" type="hidden" />
							
							<!--top Search Start-->
							<div class="topBx">
								프로그램명 :
								<input name="searchKeyword" type="text" size="40" value="" maxlength="40" id="F1" onkeypress="press();">
								<input type="button" id="btnMenuList" name="btnMenuList" value="조회" class="btn btn_search" onclick="javascript:selectProgramListManage();" alt="조회" />
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
							
								<table summary="메뉴권한정보">
									<colgroup>
										<col width="30">
										<col width="160">
										<col width="150">
										<col width="290">
										<col />
									</colgroup>
									<thead>
										<tr>
											<th class="noOption"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fCheckAll();"></th>  
											<th>프로그램 파일명</th>
											<th>프로그램명</th>
											<th>URL</th>
											<th>프로그램 설명</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
											<c:set var = "checkFilterNo" value="${filterNo}" />
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
										<tr class="<c:out value="${even}"/>">
											<td class="noOption">
												<input type="checkbox" name="checkField" class="check2">
												<input type="hidden" name="checkProgrmKoreanNm" value="<c:out value='${result.progrmKoreanNm}'/>"/>
											</td>
											<td>
												<a href="javascript:selectUpdtProgramListDetail('<c:out value="${result.progrmKoreanNm}"/>')"><c:out value="${result.progrmFileNm}"/></a>
											</td>
											<td><c:out value="${result.progrmKoreanNm}"/></td>
											<td class="txtL"><c:out value="${result.URL}"/></td>
											<td class="txtL"><c:out value="${result.progrmDc}" escapeXml="false"/></td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
								
								<div class="paging">
									<div id="page_number">
										<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="linkPage"/>
									</div>
								</div>
								<div style="float:right;">
									<input type="button" id="btnInsertProgramList" name="btnInsertProgramList" value="등록" class="btn btn_basic" onclick="javascript:insertProgramListManage();" alt="등록" />
									<input type="button" id="btnDeleteProgramList" name="btnDeleteProgramList" value="삭제" class="btn btn_basic" onclick="javascript:fDeleteProgrmManageList();" alt="삭제" />
								</div>
							</div>
							
							<input type="hidden" name="tmp_progrmNm"/>
							<input type="hidden" name="cmd"/>
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