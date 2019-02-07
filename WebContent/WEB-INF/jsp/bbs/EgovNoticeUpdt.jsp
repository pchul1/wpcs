<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovNoticeUpdt.jsp
	 * Description : 방제기술갤러리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2009.03.10				최초생성
	 * 2013.11.04	lkh			리뉴얼
	 * 
	 * author lkh
	 * since 2009.03.10
	 *  
	 * Copyright (C) 2009 by 이용 All right reserved.
	 */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<!-- <title>한국환경공단 수질오염 방제정보 시스템</title> -->

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

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
			document.board.action = "<c:url value='/bbs/updateBoardArticle.do'/>";
			document.board.submit();
		}
	}	
	
	function fn_egov_select_noticeList() {
		document.board.action = "<c:url value='/bbs/selectBoardList.do'/>";
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

	
	$(function (){
		setDate();
		popupcheck();
		$("input[name='popup_yn']").change(function(){
			popupcheck();
		});
	});
	
	function popupcheck(){
		if($("input[name='popup_yn']:checked").val() == 'Y') {
			$("#popup_startdate").attr("disabled",false);
			$("#popup_enddate").attr("disabled",false);
		}else{
			$("#popup_startdate").attr("disabled",true);
			$("#popup_enddate").attr("disabled",true);
		}
	}
	function setDate() {
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});

		$("#popup_startdate").datepicker({
			buttonText: '시작일'
		});

		$("#popup_enddate").datepicker({
			buttonText: '종료일'
		});

		var todayObj = new Date(); 
		var yday = '<c:out value="${result.popup_startdate}" />';
		var today = '<c:out value="${result.popup_enddate}" />';
		
		if(yday == ''){
			yday = todayObj.getFullYear()+ "/" + addzero(todayObj.getMonth()+1) + "/01";
			today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());
		}


		$("#popup_startdate").val(yday);
		$("#popup_enddate").val(today);
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}

	function commonWork(n) {
		var stdt = document.getElementById("popup_startdate");
		var endt = document.getElementById("popup_enddate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;

		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());

		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
			stdt.focus();
		}

		if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}

		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				stdt.value = "";
				stdt.focus;
				return false;
			}
		}

		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				endt.value = "";
				endt.focus;
				return false;
			}
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
							<input type="hidden" name="ntceBgnde" value="10000101"/>
							<input type="hidden" name="ntceEndde" value="99991231"/>
							
							<c:if test="${anonymous != 'true'}">
								<input type="hidden" name="ntcrNm" value="dummy"/>		<!-- validator 처리를 위해 지정 -->
								<input type="hidden" name="password" value="dummy"/>	<!-- validator 처리를 위해 지정 -->
							</c:if>
							
							<!-- 글수정 폼 -->
							<form action="">
								
									<%-- <h3 class="PointTit"><c:out value="${brdMstrVO.bbsNm}"/></h3>
									<!-- 현 페이지 경로 -->
									<p class="locationSta">홈 > 수질 오염 감시 > 방제 기술 정보 > 방제 기술 갤러리</p> --%>
										
								<div class="table_wrapper">

									<!-- 글작성 내용 -->
									<table summary="글수정 폼. 제목, 등록자, E.mail, 비밀번호, 내용, 파일을 입력">
										<colgroup>
											<col width="100px" />
											<col />
											<col width="100px" />
											<col />
										</colgroup>
										<tr>
											<th><label for="">제목</label></th>
											<td colspan="3" class="txtL">
												<input type="text" name="nttSj" value='<c:out value="${result.nttSj}" />' style="width:850px" id="" title="제목 입력" />
											</td>
										</tr>
										<tr>
											<th><label for="">등록자</label></th>
											<td class="txtL"><input type="text" name="ntcrNm" value='<c:out value="${result.frstRegisterNm}" />' style="width:385px" /></td>
											<th><label for="">E.mail</label></th>
											<td class="txtL"><input type="text" name="nttEmail" style="width:385px" value="<c:out value="${result.email}" />" /></td>
										</tr>
										<c:if test="${searchVO.bbsId eq 'BBSMSTR_000000000030'}">
										<tr>
											<th><label for="">팝업등록여부</label></th>
											<td  style="boder-bottom-width:1px; text-align:left;">
												&nbsp;&nbsp;&nbsp; <input type="radio" name="popup_yn" value='Y' <c:if test="${result.popup_yn eq 'Y'}">checked="checked"</c:if>/> Y
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" name="popup_yn" value='N' <c:if test="${result.popup_yn ne 'Y'}">checked="checked"</c:if>/> N 
											</td>
											<th>팝업기간</th>
											<td class="txtL">
													<input type="text" size="13" id="popup_startdate" name="popup_startdate" onchange="commonWork(this)"/>
													~ <input type="text" size="13" id="popup_enddate" name="popup_enddate" onchange="commonWork(this)"/>
											</td>
										</tr>
										</c:if>
										<c:choose>
										<c:when test="${anonymous == 'true'}">
										<tr>
											<th><label for="">비밀번호</label></th>
											<td colspan="3" class="txtL"><input type="password" name="password" style="width:800px" id="" /></td>
										</tr>
										</c:when>
										<c:otherwise></c:otherwise>
										</c:choose>
										<tr>
											<th><label for="">내용</label></th>
											<td colspan="3" class="txtL">
												<table width="100%" border="0" cellpadding="0" cellspacing="0" class="noStyle">
													<tr>
														<td class="txtL">
															<textarea id="nttCn" name="nttCn" style="width:863px;height:300px;"><c:out value="${result.nttCn}" escapeXml="false" /></textarea> 
															<form:errors path="nttCn" />
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<!-- 기존 첨부파일 -->
										<c:if test="${not empty result.atchFileId}">
											<tr> 
												<th ><spring:message code="cop.atchFileList" /></th>
												<td colspan="3" class="txtL">
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
												<td colspan="3" class="txtL">
													<div id="file_upload_posbl" style="display:none;">	
														<table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
															<tr>
																<td><input name="file_1" id="egovComFileUploader" type="file" /></td>
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
												</td>
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
								
									<div id="btArea" style="margin-top:10px">
										<sec:authorize ifAnyGranted="ROLE_ADMIN"> 
											<input type="button" id="btnRegist" name="btnRegist" value="수정" class="btn btn_basic" onclick="javascript:fn_egov_regist_notice();return false;" />
										</sec:authorize>
										<input type="button" id="btnNoticeList" name="btnNoticeList" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_select_noticeList();" />
									</div>
								</div>
							</form>
							<!-- //글쓰기 폼 -->
							
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