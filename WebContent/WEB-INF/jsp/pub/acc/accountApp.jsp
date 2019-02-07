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
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
	
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
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu6.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 계정신청 &gt; <span class="point">계정신청</span></p>
					<!-- Navi -->
					<div class="list_type01">
						<div style="padding-top:50px;">
							<img src="/images/new/accountApp.png"alt="계정신청"/>
						</div>
						<div style="padding-top:20px;text-align:right;cursor:pointer;">
							<a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountAppStep1&menu=6'/>"><img src="/images/new/btn_account_app.gif"alt="계정신청"/></a>
						</div>
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