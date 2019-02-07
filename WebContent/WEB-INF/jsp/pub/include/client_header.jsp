<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<!-- 2014.02.24 추가된 부분 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="/js/common2.js"></script>
<!-- //2014.02.24 추가된 부분 -->
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>
<!--header -->
<div class="header_wrap">
	<div id="header">
		<div class="leftside">
			<ul>
				<li>☎ 오염사고신고 : <span style="color:red">1666-0128</span></li>
			</ul>
		</div>
		<div class="aside">
			<ul>
				<li class="first"><a href="/index.do">HOME</a></li>
				<li><a href="/cmmn/link.do?page=pub/sitemap">SITEMAP</a></li>
				<li><a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountApp&menu=6'/>">JOIN</a></li>
			</ul>
		</div>
		<div id="gnb">
			<h1><a href="/index.do"><img src="/images/new/logo.gif" width="224" height="32" alt="수질오염방제정보시스템"/></a></h1>
			<ul>
				<li class="first"><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1'/>">센터소개</a></li>
	          <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/systemFlow&menu=2'/>">시스템 소개</a></li>
	          <li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3'/>">방제정보 소개</a></li>
	          <li class="last"><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4&no=1'/>">정보마당</a></li>
			</ul>
		</div>
	</div>
	 <div id="submenu">
     <div class="sub_gnb01">
       <ul class="list">
         <li><a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountApp&menu=6'/>">계정신청</a></li>
         <li><a href="<c:url value='/index.do'/>">로그인</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/privacy1_1.do','','scrollbars=yes,width=777,height=800')">개인정보처리방침</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/copyright.do','','width=794,height=480')">저작권보호정책</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/denyemail.do','','width=794,height=480')">이메일무단수집거부</a></li>
       </ul>
       <ul>
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1'/>"><img src="/images/new/img_submenu01_01.png" alt="추진배경 및 경위" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1'/>">추진배경 및 경위</a></li>
           </ul>
         </li>
       </ul>
       <ul>
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/roleMng&menu=1'/>"><img src="/images/new/img_submenu01_02.png" alt="역할 및 주요기능" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/roleMng&menu=1'/>">역할 및 주요기능</a></li>
           </ul>
         </li>
       </ul>
       <ul>
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/infoFlow&menu=1'/>"><img src="/images/new/img_submenu01_03.png" alt="운영체계 및 조직안내" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/infoFlow&menu=1'/>">운영체계 및 조직안내</a></li>
           </ul>
         </li>
       </ul>
       <ul class="last">
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/gearStat&menu=1'/>"><img src="/images/new/img_submenu01_04.png" alt="보유장비 현황" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/gearStat&menu=1'/>">보유장비 현황</a></li>
           </ul>
         </li>
       </ul>
     </div>
     
     <div class="sub_gnb02">
       <ul class="list">
         <li><a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountApp&menu=6'/>">계정신청</a></li>
         <li><a href="<c:url value='/index.do'/>">로그인</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/privacy1_1.do','','scrollbars=yes,width=777,height=800')">개인정보처리방침</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/copyright.do','','width=794,height=480')">저작권보호정책</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/denyemail.do','','width=794,height=480')">이메일무단수집거부</a></li>
       </ul>
       <ul>
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/systemFlow&menu=2'/>"><img src="/images/new/img_submenu02_01.png" alt="시스템 구성도" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/systemFlow&menu=2'/>">시스템 구성도</a></li>
           </ul>
         </li>
       </ul>
       <ul>
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/totalMnt&menu=2'/>"><img src="/images/new/img_submenu02_02.png" alt="예방" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/totalMnt&menu=2'/>">예방</a></li>
           </ul>
         </li>
       </ul>
       <ul>
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/preventSupport&menu=2'/>"><img src="/images/new/img_submenu02_03.png" alt="대비" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/preventSupport&menu=2'/>">대비</a></li>
           </ul>
         </li>
       </ul>
       <ul class="last">
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/statMnt&menu=2'/>"><img src="/images/new/img_submenu02_04.png" alt="복구 & 지원" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/systemInfo/statMnt&menu=2'/>">복구 &amp; 지원</a></li>
           </ul>
         </li>
       </ul>
     </div>
     
     <div class="sub_gnb03">
       <ul class="list">
         <li><a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountApp&menu=6'/>">계정신청</a></li>
         <li><a href="<c:url value='/index.do'/>">로그인</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/privacy1_1.do','','scrollbars=yes,width=777,height=800')">개인정보처리방침</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/copyright.do','','width=794,height=480')">저작권보호정책</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/denyemail.do','','width=794,height=480')">이메일무단수집거부</a></li>
       </ul>
       <ul class="sub_gnb03_ul">
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3'/>"><img src="/images/new/img_submenu03_01.png" alt="운영체계도" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3'/>">운영체계도</a></li>
           </ul>
         </li>
       </ul>
       <ul class="last sub_gnb03_ul">
         <li>
         	<ul>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3'/>"><img src="/images/new/img_submenu03_02.png" alt="수질오염사고 조치 메뉴얼" /></a></li>
           <li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3'/>">수질오염사고 조치 메뉴얼</a></li>
           </ul>
         </li>
       </ul>
      
     </div>
     
     <div class="sub_gnb04">
       <ul class="list">
         <li><a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountApp&menu=6'/>">계정신청</a></li>
         <li><a href="<c:url value='/index.do'/>">로그인</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/privacy1_1.do','','scrollbars=yes,width=777,height=800')">개인정보처리방침</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/copyright.do','','width=794,height=480')">저작권보호정책</a></li>
         <li><a href="javascript:MM_openBrWindow('http://www.keco.or.kr/kr/util/denyemail.do','','width=794,height=480')">이메일무단수집거부</a></li>
       </ul>
       <ul>
         <li>
         	<ul>
           <li><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4&no=1'/>"><img src="/images/new/img_submenu04_01.png" alt="공지사항" /></a></li>
           <li><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4&no=1'/>">공지사항</a></li>
           </ul>
         </li>
       </ul>
       <ul>
         <!-- <li>
         	<ul>
           <li><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&view=pub&menu=4&no=3'/>"><img src="/images/new/img_submenu04_02.png" alt="FAQ" /></a></li>
           <li><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&view=pub&menu=4&no=3'/>">FAQ</a></li>
           </ul>
         </li> -->
         <li class="mt10">
         	<div>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&view=pub&menu=4&no=3'/>"><img src="/images/new/img_submenu04_07.png" alt="FAQ" /></a></p>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&view=pub&menu=4&no=3'/>">FAQ</a></p>
           </div>
           <div>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000120&view=pub&menu=4&no=7'/>""><img src="/images/new/img_submenu04_08.png" alt="동영상 갤러리" /></a></p>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000120&view=pub&menu=4&no=7'/>"">동영상 갤러리</a></p>
           </div>
         </li>
       </ul>
       <ul>
         <li class="mt10">
         	<div>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000060&view=pub&menu=4&no=4'/>"><img src="/images/new/img_submenu04_03.png" alt="자료실" /></a></p>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000060&view=pub&menu=4&no=4'/>">자료실</a></p>
           </div>
           <div>
           <p><a href="<c:url value='/rss/rssDataSelect.do?view=pub&menu=4&no=2'/>"><img src="/images/new/img_submenu04_04.png" alt="보도자료" /></a></p>
           <p><a href="<c:url value='/rss/rssDataSelect.do?view=pub&menu=4&no=2'/>">보도자료</a></p>
           </div>
         </li>
       </ul>
       <ul class="last">
         <li class="mt10">
         	<div>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000040&view=pub&menu=4&no=5'/>"><img src="/images/new/img_submenu04_05.png" alt="수질오염 사례 갤러리" /></a></p>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000040&view=pub&menu=4&no=5'/>">수질오염 사례 갤러리</a></p>
           </div>
           <div>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000020&view=pub&menu=4&no=6'/>""><img src="/images/new/img_submenu04_06.png" alt="방제지원 사례 갤러리" /></a></p>
           <p><a href="<c:url value='/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000020&view=pub&menu=4&no=6'/>"">방제지원 사례 갤러리</a></p>
           </div>
         </li>
       </ul>
     </div>
   </div>
</div>
<!--header --> 