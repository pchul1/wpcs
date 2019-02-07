<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script type="text/javascript">
	_editor_area = "nttCn";
	</script>
	<script type="text/javascript" src="<c:url value='/html/util/htmlarea3.0/htmlarea.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/bbs/EgovMultiFile.js'/>" ></script>
	<script type="text/javascript" src="<c:url value='/js/egovframework/cmm/sym/cal/EgovCalPopup.js'/>" ></script>
	<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
	<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
	<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
	<script type="text/javascript">
	
		function fn_egov_validateForm(obj) {
			return true;
		}
	
		function fn_egov_regist_notice() {
			document.board.onsubmit();
	
			if (!validateBoard(document.board)){
				return;
			}
			
			if (confirm('<spring:message code="common.regist.msg" />')) {
				document.board.action = "<c:url value='/bbs${prefix}/replyBoardArticle.do'/>";
				document.board.submit();					
			}
		}
		
		function fn_egov_select_noticeList() {
			document.board.action = "<c:url value='/bbs${prefix}/selectBoardList.do'/>";
			document.board.submit();	
		}
	</script>
	<style type="text/css">
		.noStyle {background:ButtonFace !important; BORDER-TOP:0px !important; BORDER-bottom:0px !important; BORDER-left:0px !important; BORDER-right:0px !important;}
	  	.noStyle th{background:ButtonFace !important; padding-left:0px !important;padding-right:0px !important;}
	  	.noStyle td{background:ButtonFace !important; padding-left:0px !important;padding-right:0px !important;}
	</style>
	<title><c:out value='${bdMstr.bbsNm}'/> - 답글쓰기</title>
	<link href="<c:url value='/css/board.css' />" rel="stylesheet" type="text/css"/>
	<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css"/>
	<link href="<c:url value='/css/popup.css'/>" rel="stylesheet" type="text/css"/>
	<style type="text/css">
		html {height:100%;}
	</style>
</head>
<body class="pop_board" onLoad="HTMLArea.init(); HTMLArea.onload = initEditor; document.board.nttSj.focus();">
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1><img src="<c:url value='/images/popup/h1_notice.gif'/>" alt="공지사항" /></h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad">
				<div class="pop_notice">
					
					<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
					<input type="hidden" name="replyAt" value="Y" />
					<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="nttId" value="<c:out value='${searchVO.nttId}'/>" />
					<input type="hidden" name="parnts" value="<c:out value='${searchVO.parnts}'/>" />
					<input type="hidden" name="sortOrdr" value="<c:out value='${searchVO.sortOrdr}'/>" />
					<input type="hidden" name="replyLc" value="<c:out value='${searchVO.replyLc}'/>" />
					
					<input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
					<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
					<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
					<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
					<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
					<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
					<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
					<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
					
					<c:if test="${anonymous != 'true'}">
					<input type="hidden" name="ntcrNm" value="dummy">	<!-- validator 처리를 위해 지정 -->
					<input type="hidden" name="password" value="dummy">	<!-- validator 처리를 위해 지정 -->
					</c:if>
					
					<input name="ntceBgnde" type="hidden" value="10000101">
					<input name="ntceEndde" type="hidden" value="99991231">
					
					<input type="hidden" name="viewFlag" value="popup" />
					
					<div class="board_wrap">
						<!-- 글쓰기 폼 -->
						<form action="">
							<fieldset>
								<legend class="hidden">답글쓰기 폼</legend>
								<div class="board_write">
									<div class="innerBox">
										<!-- 글작성 내용 -->
										<table class="writeForm" summary="글쓰기 폼. 제목, 등록자, E.mail, 비밀번호, 내용, 파일을 입력">
											<colgroup>
												<col width="80px" />
												<col />
												<col width="80px" />
												<col />
											</colgroup>
											<tr>
												<th><label for="">제목</label></th>
												<td colspan="3" class="title">
													<input name="nttSj" class="inputText" id="" title="제목 입력" type="text" value="RE: <c:out value='${result.nttSj}'/>"  maxlength="60" > 
				      								<br/><form:errors path="nttSj" />
												</td>
											</tr>
											<tr>
												<c:choose>
												<c:when test="${anonymous == 'true'}">
													<th><label for="">등록자</label></th>
													<td class="border"><input name="ntcrNm" type="text" class="inputText" id="" /></td>
													<th><label for="">E.mail</label></th>
													<td><input name="nttEmail" type="text" class="inputText" id="" /></td>
												</c:when>
												<c:when test="${anonymous != 'true'}">
													<th><label for="">등록자</label></th>
													<td class="border"><input type="text" name="ntcrNm" class="inputText" id="" value="<%=((LoginVO)TmsUserDetailsHelper.getAuthenticatedUser()).getName() %>"/></td>
													<th><label for="">E.mail</label></th>
												<td><input name="nttEmail" type="text" class="inputText" id="" value="<%=((LoginVO)TmsUserDetailsHelper.getAuthenticatedUser()).getEmail() %>"/></td>
												</c:when>
												<c:otherwise></c:otherwise>
												</c:choose>
											</tr>
											<c:choose>
											<c:when test="${anonymous == 'true'}">
												<tr>
													<th><label for="">비밀번호</label></th>
													<td colspan="3"><input name="password" type="password" class="inputText pw" id="" /></td>
												</tr>
											</c:when>
											<c:otherwise></c:otherwise>
											</c:choose>
											<tr>
												<th><label for="">내용</label></th>
												<td colspan="3">
													<table width="100%" border="0" cellpadding="0" cellspacing="0" class="noStyle">
												    	<tr><td>
												      		<textarea id="nttCn" name="nttCn" class="textarea" style="height:300px;"></textarea> 
												      		<form:errors path="nttCn" />
												      	</td></tr>
												    </table>
												</td>
											</tr>
											<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
												<tr class="borderNone">
													<th><label for="">파일</label></th>
													<td colspan="3">
														<input name="file_1" id="egovComFileUploader" class="inputFile" type="file" />
														<div id="egovComFileList"></div>
													</td>
												</tr>
												<script type="text/javascript">
													var maxFileNum = document.board.posblAtchFileNumber.value;
												    	if(maxFileNum==null || maxFileNum==""){
												    		maxFileNum = 3;
												     	}     
													var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
													multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );			
											    </script>	  
											</c:if>
										</table>
										<!-- //글수정 내용 -->
									</div>
									<!-- 버튼 메뉴 -->
									<ul class="btn_menu">
										<c:if test="${bdMstr.authFlag == 'Y'}">
											<li><input onclick="javascript:fn_egov_regist_notice();return false;" type="image" src="<c:url value='/images/board/btn_enter.gif'/>" alt="등록" /></li>
										</c:if>
										<li><a href="javascript:fn_egov_select_noticeList();" class="btn_basic btn_bgBlue"><span>목록</span></a></li>
									</ul>
									<!-- //버튼 메뉴 -->
								</div>
							</fieldset>
						</form>
						<!-- //글쓰기 폼 -->
					</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div>
</body>
</html>
