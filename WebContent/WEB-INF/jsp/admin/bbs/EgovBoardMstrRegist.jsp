<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * Class Name : EgovBoardMstrRegist.jsp
  * Description : 게시판 생성 화면
  * Modification Information
  * 
  * 수정일				수정자			수정내용
  * -------			--------	---------------------------
  * 2009.03.12		이삼섭			최초 생성
  * 2013.12.05		lhk			리뉴얼
  *
  * author 공통서비스 개발팀 이삼섭
  * since 2009.03.12
  * version 1.0 
  * see 
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

<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
	function fn_egov_regist_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}
		
		if (confirm('<spring:message code="common.regist.msg" />')) {
			form = document.boardMaster;
			form.action = "<c:url value='/admin/bbs/insertBBSMasterInf.do'/>";
			form.submit();
		}
	}
	
	function fn_egov_select_brdMstrList(){
		form = document.boardMaster;
		form.action = "<c:url value='/admin/bbs/SelectBBSMasterInfs.do'/>";
		form.submit();	
	}
	
	function fn_egov_inqire_tmplatInqire(){
		form = document.boardMaster;
		var retVal;
		var url = "<c:url value='/common/openPopup.do?requestUrl=/admin/bbs/selectTemplateInfsPop.do&typeFlag=BBS&width=850&height=360'/>";
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			form.tmplatId.value = tmp[0];
			form.tmplatNm.value = tmp[1];
		}
	}
	
</script>

<title>게시판 생성</title>
</head>
<body>
	<%-- <div id='loadingDiv' style="visibility: hidden; position: absolute;">
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
					
						<form:form commandName="boardMaster" name="boardMaster" method="post">
							<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>
							
							<!--top Search Start-->
							<div class="topBx">
								<input type="button" id="btnEgovSelectBrdMstrList" name="btnEgovSelectBrdMstrList" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_select_brdMstrList();" alt="목록" />
								<input type="button" id="btnEgovRegistBrdMstr" name="btnEgovRegistBrdMstr" value="등록" class="btn btn_basic" onclick="javascript:fn_egov_regist_brdMstr();" alt="들록" />
							</div>
							<!--top Search End-->
							
							<table summary="게시판정보" style="text-align:left;margin-top:10px">
								<colgroup>
									<col width="20%">
									<col>
								</colgroup>
								<tr>
									<th>게시판명 <span class="red">*</span></th>
									<td class="txtL">
										<form:input path="bbsNm" size="60"/>
										<br/><form:errors path="bbsNm" />
									</td>
								</tr>
								<tr>  
									<th>게시판 설명 <span class="red">*</span></th>
									<td class="txtL" style="padding-top:5px; padding-bottom:5px;">
										<form:textarea path="bbsIntrcn" cols="120" rows="4"/>
										<br/><form:errors path="bbsIntrcn" />
									</td>
								</tr>
								<tr>  
									<th>게시판 유형 <span class="red">*</span></th>
									<td class="txtL">
										<form:select path="bbsTyCode">
											<form:option value='' label="--선택하세요--" />
											<form:options items="${typeList}" itemValue="code" itemLabel="codeName"/>
										</form:select>
										<br/><form:errors path="bbsTyCode" />
									</td>
								</tr>
								<tr>  
									<th>게시판 속성 <span class="red">*</span></th>
									<td class="txtL">
										<form:select path="bbsAttrbCode">
											<form:option value='' label="--선택하세요--" />
											<form:options items="${attrbList}" itemValue="code" itemLabel="codeName"/>
										</form:select>		
										<br/><form:errors path="bbsAttrbCode" />
									</td>
								</tr>
								<tr>  
									<th>답변 가능여부 <span class="red">*</span></th>
									<td class="txtL">
										<spring:message code="button.possible" /> : <form:radiobutton path="replyPosblAt"  value="Y" />&nbsp;
										<spring:message code="button.impossible" /> : <form:radiobutton path="replyPosblAt"  value="N"  />
										<br/><form:errors path="replyPosblAt" />
									</td>
								</tr>
								<tr>  
									<th>파일첨부 가능여부 <span class="red">*</span></th>
									<td class="txtL">
										<spring:message code="button.possible" /> : <form:radiobutton path="fileAtchPosblAt"  value="Y" />&nbsp;
										<spring:message code="button.impossible" /> : <form:radiobutton path="fileAtchPosblAt"  value="N"  />
										<br/><form:errors path="fileAtchPosblAt" />
									</td>
								</tr>
								<tr>  
									<th>파일첨부 제한개수 <span class="red">*</span></th>
									<td class="txtL">
										<form:select path="posblAtchFileNumber" >
											<form:option value="0"  label="---선택하세요--" />
											<form:option value='1'>1개</form:option>
											<form:option value='2'>2개</form:option>
											<form:option value='3'>3개</form:option>
										</form:select>
										<br/><form:errors path="posblAtchFileNumber" />
									</td>
								</tr>
							</table>
						</form:form>
						
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