<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>
<script type="text/javascript">
	function MM_openBrWindow(theURL,winName,features) { //v2.0
		window.open(theURL,winName,features);
	}
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
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu1.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 센터소개 &gt; <span class="point">운영체계 및 조직안내</span></p>
					<h3>운영체계 및 조직안내</h3>
					<!-- Navi -->
					<div class="list_type01" style="margin-top:40px;">
						<h4>본부</h4>
						<img src="/images/new/infoFlow1.png"alt="물환경본부"/>
						<img src="/images/new/infoFlow3.png"alt="수질오염방제센터"/>
					</div>
					<div class="list_type01" style="margin-top:40px;">
						<h4>지역본부</h4>
						<img src="/images/new/infoFlow2.png"alt="지역본부"/>
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