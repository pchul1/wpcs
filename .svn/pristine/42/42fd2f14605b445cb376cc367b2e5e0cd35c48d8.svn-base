<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovMenuRegist.jsp
	 * Description : 메뉴정보등록 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    	--------    ---------------------------
	 * 2010.06.14	이용		최초 수정
	 * 2013.11.01	lkh			리뉴얼
	 *
	 * author 
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

<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<validator:javascript formName="menuManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
<!--
/* ********************************************************
 * 입력처리 함수
 *********************************************************/
function insertMenuManage(form) {
	if(confirm("<spring:message code="common.save.msg"/>")){

		if(!validateMenuManageVO(form)){ 			
			return;
		}else{
			form.submit();
		}
		
	}
}

/* ********************************************************
 * 파일목록조회  함수
 ******************************************************** */
function searchFileNm() {
	document.all.tmp_SearchElementName.value = "progrmFileNm";
	window.open("<c:url value='/admin/menu/EgovProgramListSearch.do'/>","","resizable=yes,scrollbars=yes,width=630,height=480");
}

/* ********************************************************
 * 목록조회  함수
 ******************************************************** */
function selectList(){
	location.href = "<c:url value='/admin/menu/EgovMenuManageSelect.do'/>";
}
/* ********************************************************
 * 파일명 엔터key 목록조회  함수
 ******************************************************** */
function press() {
    if (event.keyCode==13) {
    	searchFileNm();    // 원래 검색 function 호출
    }
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

						<form:form commandName="menuManageVO" method="post">
						
							<!--top Search Start-->
							<div class="topBx">
								메뉴 한글명 :
							   	<input type="text" name="searchKeyword" size="25" title="검색" onkeypress="press();">
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
							
								<table summary="메뉴정보" style="text-align:left">
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<tr>
										<th>메뉴NO <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="menuNo" size="10" maxlength="10" />
						      				<form:errors path="menuNo" />
										</td>
									</tr>
									<tr>  
										<th>메뉴순서 <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="menuOrdr" size="10"  maxlength="10" />
						      				<form:errors path="menuOrdr" />
										</td>
									</tr>
									<tr>  
										<th>메뉴명 <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="menuNm" size="30"  maxlength="30" />
						      				<form:errors path="menuNm" />
										</td>
									</tr>
									<tr>  
										<th>상위메뉴NO <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="upperMenuId" size="10"  maxlength="10" />
						      				<form:errors path="upperMenuId" />
										</td>
									</tr>
									<tr>  
										<th>파일명 <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="progrmFileNm" size="60"  maxlength="60" onkeypress="press();"/>
										    <form:errors path="progrmFileNm" />
									        <a href="javascript:searchFileNm();" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/admin/security/icon/search.gif' />"
									         alt='(프로그램파일명 검색)' width="15" height="15" /></a>(프로그램파일명 검색)
										</td>
									</tr>
									<tr>  
										<th>관련이미지경로</th>
										<td class="txtL">
											<form:input path="relateImagePath" size="30"  maxlength="30" />
							      			<form:errors path="relateImagePath" />
										</td>
									</tr>
									<tr>  
										<th>관련이미지명</th>
										<td class="txtL">
											<form:input path="relateImageNm" size="30"  maxlength="30" />
							      			<form:errors path="relateImageNm" />
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
										<td class="txtL">
											<form:textarea path="menuDc" rows="5" cols="128"/>
						      				<form:errors path="menuDc"/>
										</td>
									</tr>
								</table>
							</div>
								
							<input type="hidden" name="tmp_SearchElementName" value="">
					    	<input type="hidden" name="tmp_SearchElementVal" value="">
					    	<input type="hidden" name="cmd" value="<c:out value='insert'/>"/>
					    	
						</form:form>
						<div style="float:right;">
							<input type="button" id="btnMenuList" name="btnMenuList" value="목록" class="btn btn_basic" onclick="javascript:selectList();" alt="목록" />
							<input type="button" id="btnInsertMenu" name="btnInsertMenu" value="등록" class="btn btn_basic" onclick="javascript:insertMenuManage(document.forms[2]);" alt="등록" />
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