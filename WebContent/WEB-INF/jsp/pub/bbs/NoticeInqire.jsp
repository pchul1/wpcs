<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<c:choose>
	<c:when test="${no == 1}">
		<c:set var="className" value="noticeBoard"/>
		<c:set var="altName" value="공지사항"/>
	</c:when>
	<c:when test="${no == 3}">
		<c:set var="className" value="faqBoard"/>
		<c:set var="altName" value="FAQ"/>
	</c:when>
	<c:when test="${no == 4}">
		<c:set var="className" value="dataBoard"/>
		<c:set var="altName" value="자료실"/>
	</c:when>
	<c:when test="${no == 5}">
		<c:set var="className" value="waterGallery"/>
		<c:set var="altName" value="수질오염사례 갤러리"/>
	</c:when>
	<c:when test="${no == 6}">
		<c:set var="className" value="preventGallery"/>
		<c:set var="altName" value="방제지원사례 갤러리"/>
	</c:when>
	<c:when test="${no == 7}">
		<c:set var="className" value="preventGallery"/>
		<c:set var="altName" value="동영상 갤러리"/>
	</c:when>
	<c:otherwise>
		<c:set var="className" value="noticeBoard"/>
		<c:set var="altName" value="공지사항"/>
	</c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
	function onloading() {
		if ("<c:out value='${msg}'/>" != "") {
			alert("<c:out value='${msg}'/>");
		}
	}
	
	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_delete_notice() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}
		
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.action = "<c:url value='/bbs${prefix}/deleteBoardArticle.do'/>";
			document.frm.submit();
		}	
	}
	
	function fn_egov_moveUpdt_notice() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}

		document.frm.action = "<c:url value='/bbs${prefix}/forUpdateBoardArticle.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_addReply() {
		document.frm.action = "<c:url value='/bbs${prefix}/addReplyBoardArticle.do'/>";
		document.frm.submit();
	}	
//]]>
</script>
</head>
<body>
<!-- wrap -->

<div id="wrap"> 
  
	<!--header -->
	<div class="header_wrap">
		<c:import url="/WEB-INF/jsp/pub/include/client_header.jsp"/>
	</div>
	<!--header --> 
  
	<!--container -->
	<div class="container_wrap">
		<div id="container"> 
		    
			<!--content wrap -->
			<div class="content_wrap">
				<div id="snb">
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu4.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 정보마당 &gt; <span class="point">${altName}</span></p>
					<h3>${altName}</h3>
					<!-- Navi -->
					<div class="section_table02">
						<form name="frm" action ="" method="post">
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
							<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
							<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
							<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" />
							<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" />
							<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" />
							<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" />
							<input type="hidden" name="view" value="pub" />
							<input type="hidden" name="no" value="${no}" />
							<input type="hidden" name="menu" value="${menu}" />
							
							<table>
								<colgroup>
									<col width="100px;" />
									<col />
									<col width="100px;" />
									<col width="150px;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="col">제목</th>
									<td style="text-align:left;padding-left:5px;"><c:out value="${result.nttSj}" /></td>
									<th scope="col">작성자</th>
									<td>[<c:out value="${result.frstRegisterPnttm}" />] <c:out value="${result.frstRegisterNm}" /></td>
								</tr>
								<tr>
									<th scope="col">내용</th>
									<td colspan="3" style="text-align:left;vertical-align:top;padding-left:5px;padding-top:5px;"><c:out value="${result.nttCn}" escapeXml="false" /></td>
								</tr>
								<tr>
									<c:choose>
										<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA04'}">
											<th scope="col">영상파일</th>
										</c:when>
										<c:otherwise>
											<th scope="col">첨부파일</th>
										</c:otherwise>
									</c:choose>
									<td colspan="3" style="text-align:left;">
										<c:if test="${brdMstrVO.bbsAttrbCode != 'BBSA04'}">
										<c:import url="/cmmn/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atchFileId}" />
										</c:import>
										</c:if>
										<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA04'}">
											<video width="640px" src='<c:url value='/cmmn/getVideo.do'/>?atchFileId=<c:out value="${result.atchFileId}"/>&fileSn=0&thumbnailFlag=${thumbnailFlag}' preload controls autoplay>
											더 이상 지원하지 않는 오래된 브라우저를 사용 중입니다. IE 9.0 이상 버전으로 업그레이드해주세요.
											</video>
										</c:if>
									</td>
								</tr>
								</tbody>
							</table>
							<div style="text-align:right;">
								<a href="javascript:fn_egov_select_noticeList('<c:out value='${searchVO.pageIndex}'/>')"><img src="<c:url value='/images/board/new_btn_list.gif'/>" alt ="목록" /></a>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!--content wrap --> 
		    
		</div>
	</div>
	<!--container --> 
  
	<!--footer -->
	<div class="footer_wrap">
		<div id="footer">
			<c:import url="/WEB-INF/jsp/pub/include/client_footer.jsp" />
		</div>
	</div>
	<!--footer --> 
  
</div>
<!-- wrap -->

</body>
</html>