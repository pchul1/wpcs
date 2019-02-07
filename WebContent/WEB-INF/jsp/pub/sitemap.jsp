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
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu5.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; <span class="point">사이트맵</span></p>
					<!-- Navi -->
					<div class="list_type01" style="margin-top:40px;">
						<dl class="sitemap_dl1">
                            <dt class="sitemap_dt">
                            	<strong style="display:block; padding-top:1px">센터소개</strong>
                            </dt>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1'/>">- 추진 배경 및 경위</a></dd>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/roleMng&menu=1'/>">- 역할 및 주요 기능</a></dd>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/infoFlow&menu=1'/>">- 운영 체계 및 조직안내</a></dd>
                            <dd style="padding-left:13px; margin-top:11px; margin-bottom:15px;"><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/gearStat&menu=1'/>">- 보유 장비 현황</a></dd>
                        </dl>                    
                        <dl class="sitemap_dl1">
                            <dt class="sitemap_dt">
                            	<strong style="display:block; padding-top:1px">시스템 소개</strong>
                            </dt>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/systemFlow&menu=2'/>">- 시스템 구성도</a></dd>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/totalMnt&menu=2'/>">- 예방</a></dd>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/preventSupport&menu=2'/>">- 대비</a></dd>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/statMnt&menu=2'/>">- 복구 & 지원</a></dd>
                        </dl>  
                        <dl class="sitemap_dl1">
                            <dt class="sitemap_dt">
                            	<strong style="display:block; padding-top:1px">방제 정보 소개</strong>
                            </dt>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3'/>">- 운영 체계도</a></dd>
                            <dd class="sitemap_dd"><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3'/>">- 수질오염 사고 조치 매뉴얼</a></dd>
                        </dl>  
                        <dl class="sitemap_dl1">
                            <dt class="sitemap_dt">
                            	<strong style="display:block; padding-top:1px">정보마당</strong>
                            </dt>
                            <dd class="sitemap_dd"><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4&no=1'/>">- 공지사항</a></dd>
                            <dd class="sitemap_dd1"><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&view=pub&menu=4&no=3'/>">- FAQ</a></dd>
                            <dd class="sitemap_dd1"><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000120&view=pub&menu=4&no=7'/>">- 동영상 갤러리</a></dd>
                            <dd class="sitemap_dd1"><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000060&view=pub&menu=4&no=4'/>">- 자료실</a></dd>
                            <dd class="sitemap_dd1"><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000040&view=pub&menu=4&no=5'/>">- 수질 오염 사례 갤러리</a></dd>
                            <dd class="sitemap_dd1"><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000020&view=pub&menu=4&no=6'/>">- 방제 지원 사례 갤러리</a></dd>
                            <dd class="sitemap_dd1"><a href="<c:url value='/rss/rssDataSelect.do?view=pub&menu=4&no=2'/>">- 보도자료</a></dd>
                        </dl>  
                        <dl class="sitemap_dl2">
                            <dt class="sitemap_dt">
                            	<strong style="display:block; padding-top:1px">회원 서비스</strong>
                            </dt>
                            <dd class="sitemap_dd"><a href="<c:url value='/index.do'/>">- 로그인</a></dd>
                            <dd class="sitemap_dd"><a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountApp&menu=6'/>">- 계정신청</a></dd>
                            <dd class="sitemap_dd"><a href="<c:url value='/acc/accountFindId.do'/>">- ID/PW 찾기</a></dd>
                        </dl>   
                        <dl class="sitemap_dl2">
                            <dt class="sitemap_dt">
                            	<strong style="display:block; padding-top:1px">개인 정보 정책</strong>
                            </dt>
                            <dd class="sitemap_dd"><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/privacy1_1.do','','scrollbars=yes,width=777,height=800')">- 개인정보처리방침</a></dd>
                            <dd class="sitemap_dd"><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/copyright.do','','width=794,height=480')">- 저작권보호정책</a></dd>
                            <dd class="sitemap_dd"><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/denyemail.do','','width=794,height=480')">- 이메일무단수집거부</a></dd>
                        </dl>  
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