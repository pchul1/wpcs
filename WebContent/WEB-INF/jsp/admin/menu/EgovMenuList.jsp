<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%@ page import="daewooInfo.common.util.fcc.StringUtil"%>
<%
	/**
	 * Class Name : EgovMenuList.jsp
	 * Description : 메뉴관리 트리형태 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2009.03.10	이용			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author 공통서비스 개발 및 이용
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
<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<script type="text/javascript" src="<c:url value="/js/admin/menu/EgovMenuList.js" />"></script>
<script type="text/javascript">
//<![CDATA[
	//파일검색 화면 호출 함수
	function searchFileNm() {
		document.menuListForm.tmp_SearchElementName.value = "progrmFileNm";
		window.open("<c:url value='/admin/menu/EgovProgramListSearch.do'/>",'','resizable=yes,scrollbars=yes,width=630,height=480');
	}
	
	//메뉴등록 처리 함수
	function insertMenuList() {
		if(confirm('<spring:message code="common.save.msg" />')){
			if(!fn_validatorMenuList()){return;}
			if(document.menuListForm.tmp_CheckVal.value == "U"){alert("상세조회시는 수정 혹은 삭제만 가능합니다."); return;}
			document.menuListForm.action = "<c:url value='/admin/menu/EgovMenuListInsert.do'/>";
			document.menuListForm.submit();
		}
	}
	
	//메뉴수정 처리 함수
	function updateMenuList() {
		if(confirm('<spring:message code="common.update.msg" />')){
			if(!fn_validatorMenuList()){return;}
			if(document.menuListForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정 혹은 삭제만 가능합니다. 초기화 하신 후 등록하세요."); return;}
			document.menuListForm.action = "<c:url value='/admin/menu/EgovMenuListUpdt.do'/>";
			document.menuListForm.submit();
		}
	}
	
	//메뉴삭제 처리 함수
	function deleteMenuList() {
		if(confirm('<spring:message code="common.delete.msg" />')){
			if(!fn_validatorMenuList()){return;}
			if(document.menuListForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다."); return;}
			document.menuListForm.action = "<c:url value='/admin/menu/EgovMenuListDelete.do'/>";
			document.menuListForm.submit();
		}
	}
	
	//메뉴리스트 조회 함수
	function selectMenuList() {
		document.menuListForm.action = "<c:url value='/admin/menu/EgovMenuListSelect.do'/>";
		document.menuListForm.submit();
	}
	
	//메뉴이동 화면 호출 함수
	function mvmnMenuList() {
		window.open("<c:url value='/admin/menu/EgovMenuListSelectMvmn.do'/>",'Pop_Mvmn','resizable=yes,scrollbars=yes,width=640,height=480');
	}
	
	// 초기화 함수
	function initlMenuList() {
		document.menuListForm.menuNo.value="";
		document.menuListForm.menuOrdr.value="";
		document.menuListForm.menuNm.value="";
		document.menuListForm.upperMenuId.value="";
		document.menuListForm.menuDc.value="";
		document.menuListForm.relateImagePath.value="";
		document.menuListForm.relateImageNm.value="";
// 		document.menuListForm.progrmFileNm.value="";
		document.menuListForm.menuNo.readOnly=false;
		document.menuListForm.tmp_CheckVal.value = "";
	}
	
	//조회 함수
	function selectMenuListTmp() {
		document.menuListForm.req_RetrunPath.value = "/admin/menu/EgovMenuList";
		document.menuListForm.action = "<c:url value='/admin/menu/EgovMenuListSelectTmp.do'/>";
		document.menuListForm.submit();
	}
	
	//상세내역조회 함수
	function choiceNodes(nodeNum) {
			var nodeValues = treeNodes[nodeNum].split("|");
			document.menuListForm.menuNo.value = nodeValues[4];
			document.menuListForm.menuOrdr.value = nodeValues[5];
			document.menuListForm.menuNm.value = nodeValues[6];
			document.menuListForm.upperMenuId.value = nodeValues[7];
			document.menuListForm.menuDc.value = nodeValues[8];
			document.menuListForm.relateImagePath.value = nodeValues[9];
			document.menuListForm.relateImageNm.value = nodeValues[10];
// 			document.menuListForm.progrmFileNm.value = nodeValues[11];
			document.menuListForm.menuNo.readOnly = true;
			document.menuListForm.tmp_CheckVal.value = "U";
	}
	
	//입력값 validator 함수
	function fn_validatorMenuList() {
		
		if(document.menuListForm.menuNo.value == ""){alert("메뉴번호는 필수입력 항목입니다."); return false;}
		if(!checkNumber(document.menuListForm.menuNo.value)){alert("메뉴번호는 숫자만 입력 가능합니다."); return false;}
		
		if(document.menuListForm.menuOrdr.value == ""){alert("메뉴순서는 필수입력 항목입니다."); return false;}
		if(!checkNumber(document.menuListForm.menuOrdr.value)){alert("메뉴순서는 숫자만 입력 가능합니다."); return false;}
		
		if(document.menuListForm.upperMenuId.value == ""){alert("상위메뉴번호는 필수입력 항목입니다."); return false;}
		if(!checkNumber(document.menuListForm.upperMenuId.value)){alert("상위메뉴번호는 숫자만 입력 가능합니다."); return false;}
		
// 		if(document.menuListForm.progrmFileNm.value == ""){alert("프로그램파일명은 필수입력 항목입니다."); return false;}
		if(document.menuListForm.menuNm.value == ""){alert("메뉴명은 필수입력 항목입니다."); return false;}
		
		return true;
	}
	
	//필드값 Number 체크 함수
	function checkNumber(str) {
		var flag=true;
		if (str.length > 0) {
			for (i = 0; i < str.length; i++) {
				if (str.charAt(i) < '0' || str.charAt(i) > '9') {
					flag=false; 
				}
			}
		}
		return flag;
	}
// 	<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
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
						
						<form name="treeForm">
							<input type="hidden" name="req_RetrunPath" value="<c:url value='/admin/menu/EgovMenuList'/>" /> 
							<c:forEach var="result" items="${list_menulist}" varStatus="status" > 
							<input type="hidden" name="tmp_menuNmVal" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.progrmFileNm}|${result.menuNo}|${result.menuOrdr}|${result.menuNm}|${result.upperMenuId}|${result.menuDc}|${result.relateImagePath}|${result.relateImageNm}|${result.progrmFileNm}|" />
							</c:forEach>
						</form>
						<form name="menuListForm" action="<c:url value='/admin/menu/EgovMenuListSelect.do'/>" method="post">
							<div class="divisionBx" style="margin-top:0px">
								<div class="div30">
									<div class="table_wrapper">
										<table summary="메뉴박스">
											<tr>
												<td class="txtL boxp" style="height:441px;vertical-align:top;">
													<script type="text/javascript">
														var chk_Object = true;
														var chk_browse = "";
														if (eval(document.treeForm.req_RetrunPath)=="[object]") chk_browse = "IE";
														if (eval(document.treeForm.req_RetrunPath)=="[object NodeList]") chk_browse = "Fox";
														if (eval(document.treeForm.req_RetrunPath)=="[object Collection]") chk_browse = "safai";
														
														var Tree = new Array;
														if(chk_browse=="IE"&&eval(document.treeForm.tmp_menuNmVal)!="[object]"){
															alert("메뉴 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														
														if(chk_browse=="Fox"&&eval(document.treeForm.tmp_menuNmVal)!="[object NodeList]"){
															alert("메뉴 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														
														if(chk_browse=="safai"&&eval(document.treeForm.tmp_menuNmVal)!="[object Collection]"){
															alert("메뉴 목록 데이타가 존재하지 않습니다.");
															chk_Object = false;
														}
														
														if( chk_Object ){
															for (var j = 0; j < document.treeForm.tmp_menuNmVal.length; j++) {
																Tree[j] = document.treeForm.tmp_menuNmVal[j].value;
															}
															createTree(Tree);
														}else{
															alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.");
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
												<th>메뉴No <span class="red">*</span></th>
												<td class="txtL"><input class="inputText" name="menuNo" type="text" size="10" value=""  maxlength="10" /> </td> 
											</tr>
											<tr>
												<th>메뉴순서 <span class="red">*</span></th>
												<td class="txtL"><input class="inputText" name="menuOrdr" type="text" size="10" value=""  maxlength="10" /></td>
											</tr>
											<tr>
												<th>메뉴명 <span class="red">*</span></th>
												<td class="txtL"><input class="inputText" name="menuNm" type="text" size="30" value=""  maxlength="30" /></td>
											</tr>
											<tr>
												<th>상위메뉴No <span class="red">*</span></th>
												<td class="txtL">
													<input class="inputText" name="upperMenuId" type="text" size="10" value=""  maxlength="10" />
													<a href="javascript:mvmnMenuList();" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/admin/security/icon/search.gif' />" alt='메뉴선택 검색)' width="15" height="15" /></a>(메뉴선택 검색)
												</td>
											</tr>
<!-- 											<tr> -->
<!-- 												<th>파일명 <span class="red">*</span></th> -->
<!-- 												<td> -->
<!-- 													<input class="inputText" name="progrmFileNm" type="text" size="30" value=""  maxlength="60" > -->
<%-- 													<a href="javascript:searchFileNm();" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/admin/security/icon/search.gif' />" --%>
<!-- 													 alt='(프로그램파일명 검색)' width="15" height="15" /></a>(프로그램파일명 검색) -->
<!-- 												</td> -->
<!-- 											</tr> -->
											<tr>
												<th>관련이미지경로 <span class="red">*</span></th>
												<td class="txtL">
													<input class="inputText" name="relateImagePath" type="text" size="30" value=""  maxlength="60" /> 이미지 경로를 입력해주세요.
												</td> 
											</tr>
											<tr> 
												<th>관련이미지명 <span class="red">*</span></th>
												<td class="txtL" style="padding-top:5px; padding-bottom:5px;">
													<input class="inputText" name="relateImageNm" type="text" size="30" value=""  maxlength="30" />
													이미지명을 입력해주세요.<br/><br/>
													[서버에 올릴 실제 이미지명]<br/>
													상위메뉴 - 1차메뉴 : gnb_menu1.gif, 2차메뉴 : gnb_menu1_1.gif<br/>
													왼쪽메뉴 - 1차메뉴 : sub_menu1.gif, 2차메뉴 : snb_menu1_1.gif<br/>
													hover시 이미지는 _over를 추가함. ex) gnb_menu1_over.gif<br/><br/>
													[여기에 입력되는 값]<br/>
													menu1.gif, menu1_1.gif<br/>
												</td>
											</tr>
											<tr> 
												<th>메뉴설명</th> 
												<td class="txtL" style="padding-top:5px; padding-bottom:5px;">
													<textarea class="textArea" name="menuDc" class="textarea" cols="45" rows="8"  style="width:460px;"></textarea>
												</td>
											</tr>
										</table>
									</div>
									<!--top Search Start-->
									<div class="topBx">
										<input type="button" id="btnIniMenu" name="btnIniMenu" value="초기화" class="btn btn_basic" onclick="javascript:initlMenuList();" alt="초기화" />
										<input type="button" id="btnInsMenu" name="btnInsMenu" value="등록" class="btn btn_basic" onclick="javascript:insertMenuList();" alt="등록" />
										<input type="button" id="btnUpdMenu" name="btnUpdMenu" value="수정" class="btn btn_basic" onclick="javascript:updateMenuList();" alt="수정" />
										<input type="button" id="btnDelMenu" name="btnDelMenu" value="삭제" class="btn btn_basic" onclick="javascript:deleteMenuList();" alt="삭제" />
									</div>
									<!--top Search End-->
								</div>
								
							</div>
							
							<input type="hidden" name="tmp_SearchElementName" value="" />
							<input type="hidden" name="tmp_SearchElementVal" value="" />
							<input type="hidden" name="tmp_CheckVal" value="" />
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