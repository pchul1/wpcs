<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<c:set var="on1" value=""/>
<c:set var="on2" value=""/>
<c:set var="on3" value=""/>
<c:set var="on4" value=""/>

<c:if test="${menu == 1}">
	<c:set var="on1" value="_on"/>
</c:if>
<c:if test="${menu == 2}">
	<c:set var="on2" value="_on"/>
</c:if>
<c:if test="${menu == 3}">
	<c:set var="on3" value="_on"/>
</c:if>
<c:if test="${menu == 4}">
	<c:set var="on4" value="_on"/>
</c:if>

<dl class="hidden">
	<dt>바로가기</dt>
	<dd><a href="#snb">좌측메뉴</a></dd>
	<dd><a href="#content">본문</a></dd>
	<dd><a href="#footer">하단영역</a></dd>
</dl>
<h1><a href="/index.do"><img src="<c:url value='/images/center/h1_logo.gif'/>" alt="한국환경공단 수질오염 방제센터" /></a></h1>
<!-- 상단링크 -->
<div class="lnb">
	<ul class="link">
		<li><a href="/index.do"><img src="<c:url value='/images/common/lnb_home.gif'/>" alt="HOME" /></a></li>
		<!-- <li><a href="#"><img src="<c:url value='/images/common/lnb_contactUs.gif'/>" alt="CONTACT US" /></a></li> //-->
		<li><a href="/cmmn/link.do?page=pub/sitemap"><img src="<c:url value='/images/common/lnb_sitemap.gif'/>" alt="SITEMAP" /></a></li>
	</ul>
	<!-- 
	<ul class="allView">
		<li><a href="#"><img src="<c:url value='/images/common/lnb_allMenu.gif'/>" alt="전체메뉴보기" /></a></li>
	</ul>
	 //-->
</div>
<!-- //상단링크 -->
<!-- 네비 -->
<ul id="gnb" class="gnb">
	<li id="gnbList1"><a href="/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1" class="on" onmouseover="mopen(1)" onfocus="mopen(1)"
	onmouseout="mclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_list1${on1}.gif'/>" alt="센터소개" /></a>
		<ul id="gnbSub1" class="sublist1" onmouseover="mcancelclosetime()" onmouseout="mclosetime()" style="display:none">
			<li class="first"><a href="/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1" onfocus="mcancelclosetime();" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub1_1.gif'/>" alt="추진 배경 및 경위" /></a></li>
			<li><a href="/cmmn/link.do?page=pub/centerInfo/roleMng&menu=1" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub1_2.gif'/>" alt="역활 및 주요 기능" /></a></li>
			<li><a href="/cmmn/link.do?page=pub/centerInfo/infoFlow&menu=1" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub1_3.gif'/>" alt="운영체계 및 조직 안내" /></a></li>
			<li class="last"><a href="/cmmn/link.do?page=pub/centerInfo/gearStat&menu=1" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub1_4.gif'/>" alt="보유 장비 현황" /></a></li>
		</ul>
	</li>
	<li id="gnbList2"><a href="/cmmn/link.do?page=pub/systemInfo/systemFlow&menu=2" onmouseover="mopen(2);" onfocus="mopen(2);"
	onmouseout="mclosetime();" onblur="mclosetime();"><img src="<c:url value='/images/center/gnb_list2${on2}.gif'/>" alt="시스템소개" /></a>
		<ul id="gnbSub2" class="sublist2" onmouseover="mcancelclosetime()" onmouseout="mclosetime()" style="display:none">
			<li class="first"><a href="/cmmn/link.do?page=pub/systemInfo/systemFlow&menu=2" onfocus="mcancelclosetime();" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub2_1.gif'/>" alt="시스템 구성도" /></a></li>
			<li><a href="/cmmn/link.do?page=pub/systemInfo/totalMnt&menu=2" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub2_2.gif'/>" alt="통합 감시 시스템" /></a></li>
			<li><a href="/cmmn/link.do?page=pub/systemInfo/preventSupport&menu=2" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub2_3.gif'/>" alt="방제 지원 시스템" /></a></li>
			<li class="last"><a href="/cmmn/link.do?page=pub/systemInfo/statMnt&menu=2" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub2_4.gif'/>" alt="상황 관리 시스템" /></a></li>
		</ul>
	</li>
	<li id="gnbList3"><a href="/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3" onmouseover="mopen(3);" onfocus="mopen(3);"
	onmouseout="mclosetime();" onblur="mclosetime();"><img src="<c:url value='/images/center/gnb_list3${on3}.gif'/>" alt="방제정보소개" /></a>
		<ul id="gnbSub3" class="sublist3" onmouseover="mcancelclosetime()" onmouseout="mclosetime()" style="display:none">
			<li class="first"><a href="/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3" onfocus="mcancelclosetime();" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub3_1.gif'/>" alt="운영체계도" /></a></li>
			<li class="last"><a href="/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub3_2.gif'/>" alt="수질오염사고 조치 매뉴얼" /></a></li>
		</ul>
	</li>
	<li id="gnbList4" class="lastMenu"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4&amp;no=1" onmouseover="mopen(4);" onfocus="mopen(4);"
	onmouseout="mclosetime();" onblur="mclosetime();"><img src="<c:url value='/images/center/gnb_list4${on4}.gif'/>" alt="정보마당" /></a>
		<ul id="gnbSub4" class="sublist4" onmouseover="mcancelclosetime()" onmouseout="mclosetime()" style="display:none">
			<li class="first"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4&amp;no=1" onfocus="mcancelclosetime();" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_1.gif'/>" alt="공지사항" /></a></li>
			<!-- <li><a href="/rss/reader.do?view=pub&amp;menu=4&amp;no=2" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_2.gif'/>" alt="보도자료" /></a></li>-->
			<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&view=pub&menu=4&amp;no=3" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_3.gif'/>" alt="FAQ" /></a></li>
			<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000060&view=pub&menu=4&amp;no=4" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_4.gif'/>" alt="자료실" /></a></li>
			<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000040&view=pub&menu=4&amp;no=5" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_5.gif'/>" alt="수질 오염 사례 갤러리" /></a></li>
			<li class="last"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000020&view=pub&menu=4&amp;no=6" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_6.gif'/>" alt="방제 지원 사례 갤러리" /></a></li>
		</ul>
	</li>
</ul>
<script type="text/javascript">
	//<![CDATA[
	var gnb = document.getElementById("gnb");
	var gnbUl = gnb.getElementsByTagName("ul");
	//alert(gnbUl.length)
	for(var i = 0; i < gnbUl.length; i++){
		gnbUl[i].style.display = "none";
	}

	var TimeOut         = 300;
	var currentLayer    = null;
	var currentitem     = null;
	var currentLayerNum = 0;
	var noClose         = 0;
	var closeTimer      = null;
	 
	// Open Hidden Layer
	function mopen(n){
		var l  = document.getElementById("gnbSub" + n);
		var mm = document.getElementById("gnbList" + n);
		if(l){
			mcancelclosetime();
			l.style.display='';
			if(currentLayer && (currentLayerNum != n)){
				currentLayer.style.display='none';
			}
			currentLayer = l;
			currentitem = mm;
			currentLayerNum = n;
		}else if(currentLayer){
			currentLayer.style.display='none';
			currentLayerNum = 0;
			currentitem = null;
			currentLayer = null;
		}
	}
	 
	// Turn On Close Timer
	function mclosetime(){
		closeTimer = window.setTimeout(mclose, TimeOut);
	}
	 
	// Cancel Close Timer
	function mcancelclosetime(){
		if(closeTimer){
			window.clearTimeout(closeTimer);
			closeTimer = null;
		}
	}
	 
	// Close Showed Layer
	function mclose(){
		if(currentLayer && noClose!=1){
			currentLayer.style.display='none';
			currentLayerNum = 0;
			currentLayer = null;
			currentitem = null;
		}else{
			noClose = 0;
		}
		currentLayer = null;
		currentitem = null;
	}

	// Close Layer Then Click-out
	document.onclick = mclose; 
	//]]>
</script>
<!-- //네비 -->