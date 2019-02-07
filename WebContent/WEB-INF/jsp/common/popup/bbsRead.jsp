<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8;" />
<title><c:out value="${brdMstrVO.bbsNm}"/></title>
<link href="<c:url value='/css/board.css' />" rel="stylesheet" type="text/css"/>
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css"/>
<link href="<c:url value='/css/popup.css'/>" rel="stylesheet" type="text/css"/>
<style type="text/css">
	html {height:100%;}
</style>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />"></script>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
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
</script>
</head>

<body class="pop_board" onload="onloading();">
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
<%-- 			<h1><img src="<c:url value='/images/popup/h1_notice.gif'/>" alt="공지사항" /></h1> --%>
			<h1>공지사항</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad">
				<div class="pop_notice">
					<form name="frm" method="post" action="">
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
						<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
						<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
						<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" />
						<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" />
						<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" />
						<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" />
						<input type="hidden" name="viewFlag" value="popup" />
						<div class="board_wrap">
							<!-- 글보기 내용 -->
							<div class="board_view">
								<div class="innerBox">
									<h2><span>제목   test</span><c:out value="${result.nttSj}" /></h2><!-- //타이틀 -->
									<a href="javascript:fn_egov_delete_notice()" class="btn_basic btn_bgBlue"><span>삭제</span></a>
									<p class="date_name_file">
										<span>[<c:out value="${result.frstRegisterPnttm}" />] <c:out value="${result.frstRegisterNm}" /></span>
									</p><!-- //날짜 이름 파일명 -->
									<p class="content">
										<c:out value="${result.nttCn}" escapeXml="false" />
									</p><!-- //내용 -->
									<div class="addFile">
										<h3>첨부파일</h3>
										<ul>
											<li>
												<c:import url="/cmmn/selectFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${result.atchFileId}" />
												</c:import>
											</li>
										</ul>
									</div>
								</div>
								<!-- 버튼 메뉴 -->
								<ul class="btn_menu">
									<c:if test="${result.frstRegisterId == sessionUniqId}">     
										<li><a href="javascript:fn_egov_moveUpdt_notice()" class="btn_basic btn_bgBlue"><span>수정</span></a></li>
									    <li><a href="javascript:fn_egov_delete_notice()" class="btn_basic btn_bgBlue"><span>삭제</span></a></li>
									</c:if>
									<c:if test="${result.replyPosblAt == 'Y'}">     
									    <li><a href="javascript:fn_egov_addReply()" class="btn_basic btn_bgBlue"><span>답변</span></a></li>
							        </c:if>
									<li><a href="javascript:fn_egov_select_noticeList('<c:out value='${searchVO.pageIndex}'/>')" class="btn_basic btn_bgBlue"><span>목록</span></a></li>
								</ul>
								<!-- //버튼 메뉴 -->
							</div>
							<!-- //글보기 내용 -->
							
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div>
</body>
</html>
