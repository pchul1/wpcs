<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>최신 보도 자료</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<style type="text/css">
		html {height:100%;}
	</style>
	<script>
		var ROOT_PATH = '<c:url value="/"/>';
	</script>
	
	<script type="text/javascript" src="<c:url value='/js/board.js'/>"></script>
</head>
<body class="pop_board pop_boardBg">
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1><img src="<c:url value='/images/popup/h1_news.gif'/>" alt="최신 보도 자료" /></h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad">
				<div class="pop_news">
					<ul id="pop_news_con">
						<c:forEach var="result" items="${feedList}" varStatus="status">
							<c:choose>
								<c:when test="${status.count == 1}">
									<c:set var="open" value="listOpen"/>
								</c:when>
								<c:otherwise>
									<c:set var="open" value="listClose"/>
								</c:otherwise>
							</c:choose>
							
							<li class="${open}">
								<div class="bgBox">
									<div class="title">
										<p class="tit">${result.title}</p>
										<p class="time"><fmt:formatDate value="${result.publishedDate}" pattern="yyyy-MM-dd"/></p>
									</div>
									<div class="con">
										<p class="author">
											<span>${result.author}</span> 
											<fmt:formatDate value="${result.publishedDate}" pattern="yyyy-MM-dd hh:mm"/> 작성 | 
										<c:forEach var="categoryList" items="${result.categories}" varStatus="status2">
											${categoryList.name}
										</c:forEach>
										</p>
										<h2><a href="${result.uri}" target="_blank">${result.title}</a></h2>
										<p class="summary">${result.description.value}</p>
										<p class="link"><a href="${result.uri}" target="_blank">원문보기</a></p>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
					<p class="btn_close"><button type="button" class="pop_close" onclick="window.close();"><span class="hidden">닫기</span></button></p>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div>
</body>
</html>
