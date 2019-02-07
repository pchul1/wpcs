<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovBoardMstrUpdt.jsp
	 * Description : 게시판 속성정보 변경 화면
	 * Modification Information
	 * 
	 * 수정일        			 수정자                   수정내용
	 * ----------    	--------    ---------------------------
	 * 2009.03.12		이삼섭      		최초 생성
	 * 2013.11.19		lkh         리뉴얼
	 *
	 * author 공통서비스 개발팀 이삼섭
	 * since 2009.03.10
	 *   
	 * Copyright (C) 2010 by 이삼섭  All right reserved.
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

<script type="text/javascript" src=""<c:url value='/js/bbs/EgovBBSMng.js' /> ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="boardMaster" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
	function fn_egov_validateForm(obj){
		return true;
	}
	
	function fn_egov_update_brdMstr(){
		if (!validateBoardMaster(document.boardMaster)){
			return;
		}

		if(confirm('<spring:message code="common.update.msg" />')){
			document.boardMaster.action = "<c:url value='/admin/bbs/UpdateBBSMasterInf.do'/>";
			document.boardMaster.submit();					
		}
	}	
	
	function fn_egov_select_brdMstrList(){
		document.boardMaster.action = "<c:url value='/admin/bbs/SelectBBSMasterInfs.do'/>";
		document.boardMaster.submit();	
	}	
	
	function fn_egov_delete_brdMstr(){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.boardMaster.action = "<c:url value='/admin/bbs/DeleteBBSMasterInf.do'/>";
			document.boardMaster.submit();	
		}		
	}
	
	function fn_egov_inqire_tmplatInqire(){
		var retVal;
		var url = "<c:url value='/cop/com/openPopup.do?requestUrl=/cop/com/selectTemplateInfsPop.do&typeFlag=BBS&width=850&height=360'/>";		
		var openParam = "dialogWidth: 850px; dialogHeight: 360px; resizable: 0, scroll: 1, center: 1";
		 
		retVal = window.showModalDialog(url,"p_tmplatInqire", openParam);
		if(retVal != null){
			var tmp = retVal.split("|");
			document.boardMaster.tmplatId.value = tmp[0];
			document.boardMaster.tmplatNm.value = tmp[1];
		}
	}	
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
					
						<div class="topBx">
							<input type="button" id="btnEgovSelectList" name="btnEgovSelectList" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_select_brdMstrList();" alt="목록"/>
							<input type="button" id="btnEgovUpdate" name="btnEgovUpdate" value="수정" class="btn btn_basic" onclick="javascript:fn_egov_update_brdMstr();" alt="수정"/>
							<input type="button" id="btnEgovDelete" name="btnEgovDelete" value="삭제" class="btn btn_basic" onclick="javascript:fn_egov_delete_brdMstr();" alt="삭제"/>
						</div>
						
						<div class="table_wrapper">
				
							<form:form commandName="boardMaster" name="boardMaster" method="post">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<input name="bbsId" type="hidden" value="<c:out value='${result.bbsId}'/>" />
								<input name="bbsTyCode" type="hidden" value="<c:out value='${result.bbsTyCode}'/>" />
								<input name="bbsAttrbCode" type="hidden" value="<c:out value='${result.bbsAttrbCode}'/>" />
								<input name="replyPosblAt" type="hidden" value="<c:out value='${result.replyPosblAt}'/>" />

								<table summary="게시판정보" style="text-align:left">
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<tr>
										<th>게시판명 <span class="red">*</span></th>
										<td class="txtL">
											<input name="bbsNm" type="text" size="60" value='<c:out value="${result.bbsNm}"/>' maxlength="60"> 
							      			<br/><form:errors path="bbsNm" />
										</td>
									</tr>
									<tr>  
										<th>게시판 설명 <span class="red">*</span></th>
										<td  class="txtL"style="padding-top:5px; padding-bottom:5px;">
											<textarea name="bbsIntrcn" class="textarea"  cols="130" rows="4"><c:out value="${result.bbsIntrcn}" escapeXml="true" /></textarea> 
							      			<form:errors path="bbsIntrcn" />
										</td>
									</tr>
									<tr>  
										<th>게시판 유형 <span class="red">*</span></th>
										<td class="txtL">
											<c:out value="${result.bbsTyCodeNm}"/>
										</td>
									</tr>
									<tr>  
										<th>게시판 속성 <span class="red">*</span></th>
										<td class="txtL">
											<c:out value="${result.bbsAttrbCodeNm}"/>
										</td>
									</tr>
									<tr>  
										<th>답변 가능여부 <span class="red">*</span></th>
										<td class="txtL">
											<c:choose>
									    		<c:when test="${result.replyPosblAt == 'Y'}">
									    			<spring:message code="button.possible" /> 
									    		</c:when>
									    		<c:otherwise>
									    			<spring:message code="button.impossible" />
									    		</c:otherwise>
									    	</c:choose>
										</td>
									</tr>
									<tr>  
										<th>파일첨부 가능여부 <span class="red">*</span></th>
										<td class="txtL">
											<spring:message code="button.possible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="Y" <c:if test="${result.fileAtchPosblAt == 'Y'}"> checked="checked"</c:if>>&nbsp;
									     	<spring:message code="button.impossible" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="N" <c:if test="${result.fileAtchPosblAt == 'N'}"> checked="checked"</c:if>>
									     	<br/><form:errors path="fileAtchPosblAt" />
										</td>
									</tr>
									<tr>  
										<th>파일첨부 제한개수 <span class="red">*</span></th>
										<td class="txtL">
											<select name="posblAtchFileNumber" class="select">
									  		   <option selected value="0">--선택하세요--</option>
									  		   <option value='1' <c:if test="${result.posblAtchFileNumber == '1'}">selected="selected"</c:if>>1개</option>
									  		   <option value='2' <c:if test="${result.posblAtchFileNumber == '2'}">selected="selected"</c:if>>2개</option>
									  		   <option value='3' <c:if test="${result.posblAtchFileNumber == '3'}">selected="selected"</c:if>>3개</option>
									  	   </select>
									  	   <br/><form:errors path="posblAtchFileNumber" />
										</td>
									</tr>
								</table>
							</form:form>
							
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