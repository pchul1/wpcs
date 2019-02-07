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
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu3.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 방제정보 소개 &gt; <span class="point">수질오염사고 조치 매뉴얼</span></p>
					<h3>수질오염사고 조치 매뉴얼</h3>
					<!-- Navi -->
					<div class="list_type01" style="margin-top:40px;">
						<h4>매뉴얼 배포 목적</h4>
						<div style="font-size: 14px;">
						- 수질 오염 사고가 예상되거나, 수질오염사고 발생 시 현장에서 신속하고 효율적인 수습으로 피해 최소화<br/>
						- 사고 유형별 예방 방안, 방제 방안 등을 제시하여 지자체, 유관기관 등 수질오염사고 담당자의 방제 조치 능력 향상
						</div>
					</div>
					<div class="list_type01">
						<h4>배포 매뉴얼</h4>
						<div class="manual">
							<span style="background-image: url(/images/index/sub/blit_2.gif); background-repeat: no-repeat; background-position: left; padding-left: 10px; line-height: 18px;"><b>하천 공사 사고</b></span>
							<div class="m_down"><a href="/pds/measureMethod_3.pdf" target="_blank" title="새창"><img src="/images/index/sub/manual_down.gif" border="0" alt="매뉴얼다운로드"/></a></div>
						</div>
						<div class="exp_2">
							- 준설 공사 시 저니 용출에 의한 사고<br/>
							- 준설 장비로 인한 오탁수 사고<br/>
							- 준설 장비 전복, 선박사고
						</div> 
						
						<div class="manual">
							<span style="background-image: url(/images/index/sub/blit_2.gif); background-repeat: no-repeat; background-position: left; padding-left: 10px; line-height: 18px;"><b>오염 물질별 사고</b></span>
							<div class="m_down"><a href="/pds/measureMethod_2.pdf" target="_blank" title="새창"><img src="/images/index/sub/manual_down.gif" border="0" alt="매뉴얼다운로드"/></a></div>
						</div>
						<div class="exp_2">
							- 유류 유출 사고<br/>
							- 유해 물질 유출 사고<br/>
							- 수환경 변화 사고
						</div>
						<div class="manual">
							<span style="background-image: url(/images/index/sub/blit_2.gif); background-repeat: no-repeat; background-position: left; padding-left: 10px; line-height: 18px;"><b>취/정수장 수질 오염 사고</b></span>
							<div class="m_down"><a href="/pds/measureMethod_1.pdf" target="_blank" title="새창"><img src="/images/index/sub/manual_down.gif" border="0" alt="매뉴얼다운로드"/></a></div>
						</div>
						<div class="exp_2">
							- 오염물질 취수원 유입 사고<br/>
							- 조류과잉 번식에 따른 사고
						</div>
						<p class="txt_down"><span>다운로드 파일을 보시려면 <strong>PDF Reader</strong>를 설치하셔야 합니다.</span>
							<a href="http://get.adobe.com/kr/reader/" target="_blank" title="새창"><img src="<c:url value='/images/center/img_acrobat.gif'/>" alt="Acrobat Reader 무료 다운로드" /></a>
						</p>
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