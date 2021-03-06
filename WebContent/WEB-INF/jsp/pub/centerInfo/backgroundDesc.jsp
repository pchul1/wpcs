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
					<p class="spot">홈 &gt; 센터소개 &gt; <span class="point">추진배경 및 경위</span></p>
					<h3>추진배경 및 경위</h3>
					<!-- Navi -->
					<div class="list_type01" style="margin-top:40px;">
						<h4>추진배경</h4>
						<div style="font-size: 14px;">
						<b><span style="font-size: 18px;">공공수역</span></b>의 수질오염사고 예방·감시 및 사고발생 시 신속한 대응을 위하여 수질오염방제정보시스템 구축 등 방제지원<br/>
						<span style="color:#ff0000;">수질오염 통합감시, 위치정보 기반 방제지원 시스템 구축·운영을 통한 방제지원 체계 구성</span> <br/><br/>
						<span style="background-image: url(/images/index/sub/blit_2.gif); background-repeat: no-repeat; background-position: left; padding-left: 10px; line-height: 18px;">국가 수질 자동 측정망, 수질TMS, 이동형 측정기기 등을 통한 사전 감시 체계 구축</span><br/>
						<span style="background-image: url(/images/index/sub/blit_2.gif); background-repeat: no-repeat; background-position: left; padding-left: 10px; line-height: 18px;">수질오염 감시 예방 및 방제지원을 위한 전문 기관 설치 필요</span>
						</div>
					</div>
					<div class="list_type01">
						<h4>추진 경위</h4>
						<img src="/images/new/centerInfo.png"alt="수질오염방제정보시스템"/>
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