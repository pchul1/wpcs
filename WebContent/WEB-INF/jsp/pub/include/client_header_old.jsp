<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
	
	<div id="header">
		<h1><a href="/index.do"><img src="/images/index/common/logo.gif" width="267" height="60"/></a></h1>
		<ul id="top_util">
			<li><a href="/index.do`"><img src="/images/index/common/top_util_01.gif" width="50" height="17"/></a></li>
<%-- 			<li><a href="#"><img src="<c:url value='/images/common/lnb_contactUs.gif'/>" alt="CONTACT US" /></a></li> --%>
			<li><a href="/cmmn/link.do?page=pub/sitemap"><img src="/images/index/common/top_util_02.gif" width="59" height="17"/></a></li>
		</ul>
		
<!-- 		<ul class="allView"> -->
<%-- 			<li><a href="#"><img src="<c:url value='/images/common/lnb_allMenu.gif'/>" alt="전체메뉴보기" /></a></li> --%>
<!-- 		</ul> -->
	
		<div class="left_item_top_bg"></div>
		<ul id="Top_Menu">
			<li><a href="/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('name_1','','/images/index/common/top_menu_1_over.gif',1)"><img src="/images/index/common/top_menu_1_off.gif" width="189" height="57" id="name_1" onmouseover="MM_showHideLayers('dep_2_1','','show','dep_2_2','','hide','dep_2_3','','hide','dep_2_4','','hide')" /></a></li>
			<li><a href="/cmmn/link.do?page=pub/systemInfo/systemFlow&menu=2" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('name_2','','/images/index/common/top_menu_2_over.gif',1)"><img src="/images/index/common/top_menu_2_off.gif" width="189" height="57" id="name_2" onmouseover="MM_showHideLayers('dep_2_1','','hide','dep_2_2','','show','dep_2_3','','hide','dep_2_4','','hide')" /></a></li>
			<li><a href="/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('name_3','','/images/index/common/top_menu_3_over.gif',1)"><img src="/images/index/common/top_menu_3_off.gif" width="189" height="57" id="name_3" onmouseover="MM_showHideLayers('dep_2_1','','hide','dep_2_2','','hide','dep_2_3','','show','dep_2_4','','hide')" /></a></li>
			<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4&amp;no=1" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('name_4','','/images/index/common/top_menu_4_over.gif',1)"><img src="/images/index/common/top_menu_4_off.gif" width="189" height="57" id="name_4" onmouseover="MM_showHideLayers('dep_2_1','','hide','dep_2_2','','hide','dep_2_3','','hide','dep_2_4','','show')" /></a></li>
		</ul>
		
	</div>
	<div id="visual">
		<div class="section_01">
		
		<!--하위메뉴-->
		<ul id="dep_2_1">
			<li style="margin-left: 62px;"><a href="/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1">추진배경 및 경위</a></li>
			<li><a href="/cmmn/link.do?page=pub/centerInfo/roleMng&menu=1">역할 및 주요기능</a></li>
			<li><a href="/cmmn/link.do?page=pub/centerInfo/infoFlow&menu=1">운영체계 및 조직안내</a></li>
			<li><a href="/cmmn/link.do?page=pub/centerInfo/gearStat&menu=1">보유장비 현황</a></li>
		</ul>
		
		<ul id="dep_2_2">
			<li style="margin-left: 66px;"><a href="/cmmn/link.do?page=pub/systemInfo/systemFlow&menu=2">시스템 구성도</a></li>
			<li><a href="/cmmn/link.do?page=pub/systemInfo/totalMnt&menu=2">통합감시 시스템</a></li>
			<li><a href="/cmmn/link.do?page=pub/systemInfo/preventSupport&menu=2">방제지원 시스템</a></li>
			<li><a href="/cmmn/link.do?page=pub/systemInfo/statMnt&menu=2">상황관리 시스템</a></li>
		</ul>
		
		<ul id="dep_2_3">
			<li style="margin-left: 380px;"><a href="/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3">운영체계도</a></li>
			<li><a href="/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3">오염사고 조치 매뉴얼</a></li>
		</ul>
		
		<ul id="dep_2_4">
			<li style="margin-left: 200px;"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4&amp;no=1">공지사항</a></li>
<!-- 			<li><a href="/rss/reader.do?view=pub&amp;menu=4&amp;no=2">보도자료</a></li> -->
			<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&view=pub&menu=4&amp;no=3">F A Q</a></li>
			<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000060&view=pub&menu=4&amp;no=4">자료실</a></li>
			<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000040&view=pub&menu=4&amp;no=5">수질오염 사례 갤러리</a></li>
			<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000020&view=pub&menu=4&amp;no=6">방제지원 사례 갤러리</a></li>
		</ul>
		</div>
	</div>