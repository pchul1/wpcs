<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovMenuCreat.jsp
	 * Description : 메뉴생성 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    	--------    ---------------------------
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

<script src="<c:url value='/js/admin/menu/EgovMenuCreatSelect.js'/>"/></script>
<script type="text/javascript">
<!--
	/* ********************************************************
	 * 조회 함수
	 ******************************************************** */
	function selectMenuCreatTmp() {
	    document.menuCreatManageForm.action = "<c:url value='/admin/menu/EgovMenuCreatSelect.do'/>";
	    document.menuCreatManageForm.submit();
	}
	
	/* ********************************************************
	 * 멀티입력 처리 함수
	 ******************************************************** */
	function fInsertMenuCreat() {
	    var checkField = document.menuCreatManageForm.checkField;
	    var checkMenuNos = "";
	    var checkedCount = 0;
	    if(checkField) {
	    	if(checkField.length > 1) {
	            for(var i=0; i < checkField.length; i++) {
	                if(checkField[i].checked) {
	                    checkMenuNos += ((checkedCount==0? "" : ",") + checkField[i].value);
	                    checkedCount++;
	                }
	            }
	        } else {
	            if(checkField.checked) {
	                checkMenuNos = checkField.value;
	            }
	        }
	    }   
	    document.menuCreatManageFormSubmit.checkedMenuNoForInsert.value=checkMenuNos;
	    document.menuCreatManageFormSubmit.checkedAuthorForInsert.value=document.menuCreatManageForm.authorCode.value;
	    document.menuCreatManageFormSubmit.action = "<c:url value='/admin/menu/EgovMenuCreatInsert.do'/>";
	
	    document.menuCreatManageFormSubmit.submit(); 
	}
	/* ********************************************************
	 * 메뉴사이트맵 생성 화면 호출
	 ******************************************************** */
	function fMenuCreatSiteMap() {
		id = document.menuCreatManageForm.authorCode.value;
		window.open('/admin/menu/EgovMenuCreatSiteMapSelect.do?authorCode='+id,'Pop_SiteMap','scrollbars=yes, width=500, height=700');
	}
	<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
//-->
</script>

</head>
<body> 
<%-- 	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div> --%>
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

						<form name="menuCreatManageFormSubmit" action ="/admin/menu/EgovMenuCreatSelect.do" method="post">
							<input name="checkedMenuNoForInsert" type="hidden" />
							<input name="checkedAuthorForInsert"  type="hidden" />
							<input name="authorCode" type="hidden" value="${resultVO.authorCode}">
						</form>
						<form name="menuCreatManageForm">
							<c:forEach var="result1" items="${list_menulist}" varStatus="status" > 
							<input type="hidden" name="tmp_menuNmVal" value="${result1.menuNo}|${result1.upperMenuId}|${result1.menuNm}|${result1.progrmFileNm}|${result1.chkYeoBu}|">
							</c:forEach>
							
							<!--top Search Start-->
							<div class="topBx">
								<input type="button" id="btnMenuList" name="btnMenuList" value="목록" class="btn btn_search" onclick="javascript:location.href='/admin/menu/EgovMenuCreatManageSelect.do'" alt="목록" />
								<input type="button" id="btntMenuCreat" name="btntMenuCreat" value="메뉴생성" class="btn btn_search" onclick="javascript:fInsertMenuCreat();" alt="메뉴생성" />
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
							
								<table summary="메뉴권한정보">
									<colgroup>
										<col width="120px" />
										<col />
									</colgroup>
									<tr>
										<th scope="row">권한코드</th>
										<td><input name="authorCode" type="text" size="80" value="${resultVO.authorCode}"  maxlength="80" readOnly></td>
									</tr>
									<tr>
										<th scope="row">메뉴</th>
										<td class="txtL" style="padding:10px" id="tdAuthor">
											<script language="javascript">
											    var chk_Object = true;
											    var chk_browse = "";
												if (eval(document.menuCreatManageForm.authorCode)=="[object]") chk_browse = "IE";
												if (eval(document.menuCreatManageForm.authorCode)=="[object NodeList]") chk_browse = "Fox";
												if (eval(document.menuCreatManageForm.authorCode)=="[object Collection]") chk_browse = "safai";
									
												var Tree = new Array;
												if(chk_browse=="IE"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object]"){
												   alert("메뉴 목록 데이타가 존재하지 않습니다.");
												   chk_Object = false;
												}
												if(chk_browse=="Fox"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object NodeList]"){
												   alert("메뉴 목록 데이타가 존재하지 않습니다.");
												   chk_Object = false;
												}
												if(chk_browse=="safai"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object Collection]"){
													   alert("메뉴 목록 데이타가 존재하지 않습니다.");
													   chk_Object = false;
												}
												if( chk_Object ){
													for (var j = 0; j < document.menuCreatManageForm.tmp_menuNmVal.length; j++) {
														Tree[j] = document.menuCreatManageForm.tmp_menuNmVal[j].value;
												    }
												    createTree(Tree);
									            }else{
									                alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.");
									                window.close();
									            }
											</script>
										</td>
									</tr>
								</table>
								
							</div>
							<input type="hidden" name="req_menuNo">
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