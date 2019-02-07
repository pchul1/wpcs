<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertLawA.jsp
	 * Description : VOCs경보기준설정 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.07.19	kisspa		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 *
	 * author kisspa
	 * since 2010.07.19
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

<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/menu/EgovMenuList.js" />"></script>

<script type="text/javascript">
<!--

	/* ********************************************************
	 * 부서등록 처리 함수
	 ******************************************************** */
	function insertDeptList() {
		if(!fn_validatorDeptList()){return;}
		if(document.deptListForm.tmp_CheckVal.value == "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다."); return;}
		document.deptListForm.action = "<c:url value='/admin/dept/DeptListInsert.do'/>";
		document.deptListForm.submit();
	
	}
	
	/* ********************************************************
	 * 부서수정 처리 함수
	 ******************************************************** */
	function updateDeptList() {
		if(!fn_validatorDeptList()){return;}
		if(document.deptListForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다. 초기화 하신 후 등록하세요."); return;}
		document.deptListForm.action = "<c:url value='/admin/dept/DeptListUpdt.do'/>";
		document.deptListForm.submit();
	}
	
	/* ********************************************************
	 * 부서삭제 처리 함수
	 ******************************************************** */
	function deleteDeptList() {
		if(!fn_validatorDeptList()){return;}
		if(document.deptListForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다."); return;}
		document.deptListForm.action = "<c:url value='/admin/dept/DeptListDelete.do'/>";
		document.deptListForm.submit();
	}
	
	/* ********************************************************
	 * 부서리스트 조회 함수
	 ******************************************************** */
	function selectDeptList() {
		document.deptListForm.action = "<c:url value='/admin/dept/DeptListSelect.do'/>";
		document.deptListForm.submit();
	}
	
	/* ********************************************************
	 * 부서이동 화면 호출 함수
	 ******************************************************** */
	function mvmnDeptList() {
		window.open("<c:url value='/admin/dept/DeptListSelectMvmn.do'/>",'Pop_Mvmn','resizable=yes,scrollbars=yes,width=640,height=480');
	}
	
	/* ********************************************************
	 * 초기화 함수
	 ******************************************************** */
	function initlDeptList() {
		document.deptListForm.deptCode.value="";
		document.deptListForm.deptSort.value="";
		document.deptListForm.deptName.value="";
		document.deptListForm.upperDeptCode.value="";
		document.deptListForm.deptCode.readOnly=false;
		document.deptListForm.tmp_CheckVal.value = "";
		document.deptListForm.doCode.value = "";
		document.deptListForm.deptDesc.value = "";
		document.deptListForm.useFlag.value = "Y";
	}
	
	/* ********************************************************
	 * 상세내역조회 함수
	 **********************************************************/
	
	function choiceNodes(nodeNum) {
		var nodeValues = treeNodes[nodeNum].split("|");
		document.deptListForm.deptCode.value = nodeValues[3];
		document.deptListForm.deptSort.value = nodeValues[4];
		document.deptListForm.deptName.value = nodeValues[5];
		document.deptListForm.upperDeptCode.value = nodeValues[6];
		document.deptListForm.deptDesc.value = nodeValues[7];
		document.deptListForm.doCode.value = nodeValues[8];
		document.deptListForm.useFlag.value = nodeValues[9];
		document.deptListForm.deptCode.readOnly=true;
		document.deptListForm.tmp_CheckVal.value = "U";
	}
	
	/* ********************************************************
	 * 입력값 validator 함수
	 ******************************************************** */
	function fn_validatorDeptList() {
		
		if(document.deptListForm.deptCode.value == ""){alert("부서번호는 Not Null 항목입니다."); return false;}
		if(!checkNumber(document.deptListForm.deptCode.value)){alert("부서번호는 숫자만 입력 가능합니다."); return false;}
	
		if(document.deptListForm.deptSort.value == ""){alert("부서순서는 Not Null 항목입니다."); return false;}
		if(!checkNumber(document.deptListForm.deptSort.value)){alert("부서순서는 숫자만 입력 가능합니다."); return false;}
	
		if(document.deptListForm.upperDeptCode.value == ""){alert("상위부서번호는 Not Null 항목입니다."); return false;}
		if(!checkNumber(document.deptListForm.upperDeptCode.value)){alert("상위부서번호는 숫자만 입력 가능합니다."); return false;}
	
		return true;
	}
	
	/* ********************************************************
	 * 필드값 Number 체크 함수
	 ******************************************************** */
	function checkNumber(str) { 
		var flag=true; 
		if (str.length > 0) { 
			for (var i = 0; i < str.length; i++) {  
				if (str.charAt(i) < '0' || str.charAt(i) > '9') { 
					flag=false; 
				} 
			} 
		} 
		return flag; 
	}
	//<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
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
						
						<form name="treeForm">
							<input type="hidden" name="req_RetrunPath" value="<c:url value='/admin/dept/DeptList'/>">
							<c:forEach var="result" items="${list_deptlist}" varStatus="status" > 
								<input type="hidden" name="tmp_deptNmVal" value="${result.deptCode}|${result.upperDeptCode}|${result.deptName}|${result.deptCode}|${result.deptSort}|${result.deptName}|${result.upperDeptCode}|${result.deptDesc}|${result.doCode}|${result.useFlag}|">
							</c:forEach>
						</form>
						<form name="deptListForm" action="<c:url value='/admin/dept/DeptListSelect.do'/>" method="post">
							<div class="divisionBx" style="margin-top:0px">
								<div class="div30">
									<div class="table_wrapper">
										<table summary="메뉴박스">
											<tr>
												<td class="txtL boxp" style="height:325px;vertical-align:top;">
													<script type="text/javascript">
														var chk_Object = true;
														var chk_browse = "";
														if (eval(document.treeForm.req_RetrunPath)=="[object]") chk_browse = "IE";
														if (eval(document.treeForm.req_RetrunPath)=="[object NodeList]") chk_browse = "Fox";
														if (eval(document.treeForm.req_RetrunPath)=="[object Collection]") chk_browse = "safai";
												
														var Tree = new Array;
														if(chk_browse=="IE"&&eval(document.treeForm.tmp_deptNmVal)!="[object]"){
															alert("부서 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														if(chk_browse=="Fox"&&eval(document.treeForm.tmp_deptNmVal)!="[object NodeList]"){
															alert("부서 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														if(chk_browse=="safai"&&eval(document.treeForm.tmp_deptNmVal)!="[object Collection]"){
															alert("부서 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														if( chk_Object ){
															for (var j = 0; j < document.treeForm.tmp_deptNmVal.length; j++) {
																Tree[j] = document.treeForm.tmp_deptNmVal[j].value;
															}
															createTree(Tree);
														}else{
															alert("부서가 존재하지 않습니다. 부서 등록 후 사용하세요.");
														}
													</script>
												</td>
											</tr>
										</table>
									</div>
								</div>
								
								<div class="div70">
									<div class="table_wrapper">
										<table summary="부서정보" style="text-align:left">
											<colgroup>
												<col width="30%" />
												<col />
											</colgroup> 
											<tr> 
												<th>부서No <span class="red">*</span></th> 
												<td class="txtL"><input name="deptCode" type="text" size="20" value="" maxlength="10"> </td> 
											</tr> 
											<tr> 
												<th>부서순서 <span class="red">*</span></th> 
												<td class="txtL"><input name="deptSort" type="text" size="20" value="" maxlength="10"></td> 
											</tr> 
											<tr> 
												<th>부서명 <span class="red">*</span></th> 
												<td class="txtL"><input name="deptName" type="text" size="30" value="" maxlength="30" ></td> 
											</tr> 
											<tr> 
												<th>상위부서No <span class="red">*</span></th> 
												<td class="txtL">
													<input name="upperDeptCode" type="text" size="10" value="" maxlength="10" >
													<a href="javascript:mvmnDeptList();" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/admin/security/icon/search.gif' />"
													 alt='부서선택 검색)' width="15" height="15" /></a>(부서선택 검색)
												</td> 
											</tr> 
											<tr> 
												<th>시도코드(지자체일 경우)</th>
												<td class="txtL"> 
													<select name="doCode">
														<option value="">선택</option>
														<c:forEach var="result" items="${areaDoCode}" varStatus="var">
														<option value="${result.code}">${result.codeName}</option>
														</c:forEach>
													</select>
												</td> 
											</tr> 
											<tr> 
												<th>부서설명</th> 
												<td class="txtL">
													<textarea class="textArea" name="deptDesc" class="textarea"  cols="45" rows="8" style="width:460px;"></textarea>
												</td> 
											</tr> 
											<tr> 
												<th>사용여부</th> 
												<td class="txtL">
													<select name="useFlag">
														<option value="Y">사용</option>
														<option value="N">사용안함</option>
													</select>
												</td> 
											</tr>
										</table>
									</div>
									<!--top Search Start-->
									<div style="float:right;">
										<input type="button" id="btnInitDeptList" name="btnInitDeptList" value="초기화" class="btn btn_basic" onclick="javascript:initlDeptList();" alt="초기화" />
										<input type="button" id="btnInsertDeptList" name="btnInsertDeptList" value="등록" class="btn btn_basic" onclick="javascript:insertDeptList();" alt="등록" />
										<input type="button" id="btnUpdateDeptList" name="btnUpdateDeptList" value="수정" class="btn btn_basic" onclick="javascript:updateDeptList();" alt="수정" />
										<input type="button" id="btnDeleteDeptList" name="btnDeleteDeptList" value="삭제" class="btn btn_basic" onclick="javascript:deleteDeptList();" alt="삭제" />
									</div>
									<!--top Search End-->
								</div>
							</div>
							
							<input type="hidden" name="tmp_SearchElementName" value="">
							<input type="hidden" name="tmp_SearchElementVal" value="">
							<input type="hidden" name="tmp_CheckVal" value="">
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