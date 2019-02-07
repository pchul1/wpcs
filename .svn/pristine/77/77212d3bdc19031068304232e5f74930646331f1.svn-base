<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link href="<c:url value='/css/board.css' />" rel="stylesheet" type="text/css"/>
	<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css"/>
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
		function fn_egov_validateForm(obj){
			return true;
		}
	
		function fn_egov_regist_notice(){
			document.board.onsubmit();
	
			if (!validateBoard(document.board)){
				return;
			}
			
			if (confirm('<spring:message code="common.update.msg" />')) {
				document.board.action = "<c:url value='/bbs${prefix}/updateBoardArticle.do'/>";
				document.board.submit();					
			}
		}	
		
		function fn_egov_select_noticeList() {
			document.board.action = "<c:url value='/bbs${prefix}/selectBoardList.do'/>";
			document.board.submit();	
		}
		
		function fn_egov_check_file(flag) {
			if (flag=="Y") {
				document.getElementById('file_upload_posbl').style.display = "block";
				document.getElementById('file_upload_imposbl').style.display = "none";			
			} else {
				document.getElementById('file_upload_posbl').style.display = "none";
				document.getElementById('file_upload_imposbl').style.display = "block";
			}
		}	
	</script>
	<style type="text/css">
		.noStyle {background:ButtonFace !important; BORDER-TOP:0px !important; BORDER-bottom:0px !important; BORDER-left:0px !important; BORDER-right:0px !important;}
	  	.noStyle th{background:ButtonFace !important; padding-left:0px !important;padding-right:0px !important;}
	  	.noStyle td{background:ButtonFace !important; padding-left:0px !important;padding-right:0px !important;}
	</style>
	<title><c:out value='${bdMstr.bbsNm}'/> - 게시글 수정</title>
</head>
<body onLoad="HTMLArea.init(); HTMLArea.onload = initEditor; document.board.nttSj.focus();">

<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		
		<!-- content -->
		<div id="content">

			<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input type="hidden" name="returnUrl" value="<c:url value='/bbs/forUpdateBoardArticle.do'/>"/>
			
			<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
			<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
			
			<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
			<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
			<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
			<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
			<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
			<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
			<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
			
			<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
			
			<c:if test="${anonymous != 'true'}">
			<input type="hidden" name="ntcrNm" value="dummy">	<!-- validator 처리를 위해 지정 -->
			<input type="hidden" name="password" value="dummy">	<!-- validator 처리를 위해 지정 -->
			</c:if>
			
			<input name="ntceBgnde" type="hidden" value="10000101">
			<input name="ntceEndde" type="hidden" value="99991231">
			
			<div class="board_wrap">
				<!-- 글수정 폼 -->
				<form action="">
					<fieldset>
						<legend class="hidden">글수정 폼</legend>
						<h3 class="PointTit"><c:out value="${brdMstrVO.bbsNm}"/></h3>
						<!-- 현 페이지 경로 -->
						<p class="locationSta">홈 > 수질 오염 감시 > 방제 기술 정보 > 방제 기술 갤러리</p>
						<div class="board_write">
							<div class="innerBox">
								<!-- 글작성 내용 -->
								<table class="writeForm" summary="글수정 폼. 제목, 등록자, E.mail, 비밀번호, 내용, 파일을 입력">
									<colgroup>
										<col width="80px" />
										<col />
										<col width="80px" />
										<col />
									</colgroup>
									<tr>
										<th><label for="">제목</label></th>
										<td colspan="3" class="title">
											<input type="text" name="nttSj" value='<c:out value="${result.nttSj}" />' class="inputText" id="" title="제목 입력" />
										</td>
									</tr>
									<tr>
										<th><label for="">등록자</label></th>
										<td class="border"><input type="text" name="ntcrNm" class="inputText" id="" value='<c:out value="${result.frstRegisterNm}" />'/></td>
										<th><label for="">E.mail</label></th>
										<td><input type="text" name="nttEmail" value='' class="inputText" id="" /></td>
									</tr>
									<c:choose>
									<c:when test="${anonymous == 'true'}">
									<tr>
										<th><label for="">비밀번호</label></th>
										<td colspan="3"><input type="password" name="password" class="inputText pw" id="" /></td>
									</tr>
									</c:when>
									<c:otherwise></c:otherwise>
									</c:choose>
									<tr>
										<th><label for="">내용</label></th>
										<td colspan="3">
											<table width="100%" border="0" cellpadding="0" cellspacing="0" class="noStyle">
										     	<tr><td>
											      	<textarea id="nttCn" name="nttCn" class="textarea" style="height:300px;"><c:out value="${result.nttCn}" escapeXml="false" /></textarea> 
											      	<form:errors path="nttCn" />
										      	</td></tr>
										    </table>
										</td>
									</tr>
									<!-- 기존 첨부파일 -->
									<c:if test="${not empty result.atchFileId}">
										<tr> 
									    	<th ><spring:message code="cop.atchFileList" /></th>
									    	<td colspan="3">
												<c:import url="/cmmn/selectFileInfsForUpdate.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${result.atchFileId}" />
												</c:import>
									    	</td>
									  	</tr>
								  	</c:if>
									
									<!-- 첨부파일을 등록할 수 있는 게시판이라면.. -->
									<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
									  	<c:if test="${empty result.atchFileId}">
									  		<input type="hidden" name="fileListCnt" value="0" />
									  	</c:if> 
										<tr class="borderNone">
											<th ><spring:message code="cop.atchFile" /></th>
										    <td colspan="3">
										    <div id="file_upload_posbl"  style="display:none;" >	
									            <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
												    <tr>
												        <td><input name="file_1" id="egovComFileUploader" class="inputFile" type="file" /></td>
												    </tr>
												    <tr>
												        <td>
												        	<div id="egovComFileList"></div>
												        </td>
												    </tr>
									   	        </table>		  
											</div>
											<div id="file_upload_imposbl"  style="display:none;" >
									            <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
												    <tr>
												        <td><spring:message code="common.imposbl.fileupload" /></td>
												    </tr>
									   	        </table>				
											</div>		    
										</tr>
									   	
									    <script type="text/javascript">
										    var existFileNum = document.board.fileListCnt.value;	    
											var maxFileNum = document.board.posblAtchFileNumber.value;
									
											if (existFileNum=="undefined" || existFileNum ==null) {
												existFileNum = 0;
											}
											if (maxFileNum=="undefined" || maxFileNum ==null) {
												maxFileNum = 0;
											}		
											var uploadableFileNum = maxFileNum - existFileNum;
											if (uploadableFileNum<0) {
												uploadableFileNum = 0;
											}				
											if (uploadableFileNum != 0) {
												fn_egov_check_file('Y');
												var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
												multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
											} else {
												fn_egov_check_file('N');
											}			
								     	</script>
							    	</c:if>
									
								</table>
								<!-- //글수정 내용 -->
							</div>
							<!-- 버튼 메뉴 -->
							<ul class="btn_menu">
								
								<c:if test="${bdMstr.authFlag == 'Y'}">
				     				<c:if test="${result.frstRegisterId == searchVO.frstRegisterId}"> 
										<li><input onclick="javascript:fn_egov_regist_notice();return false;" type="image" src="<c:url value='/images/board/btn_edit.gif'/>" alt="수정" /></li>
										
									</c:if>
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

		</div><!-- //content -->
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
