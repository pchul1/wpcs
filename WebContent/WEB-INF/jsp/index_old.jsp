<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%if(TmsUserDetailsHelper.isAuthenticated()) { %>
	<jsp:forward page="/main.do"/>
<%}%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/center.css'/>" />
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />

<script type="text/javascript">
//<![CDATA[
	$(function(){
		// 공지사항 가져오기
		getRecentlyBBS('index', 'notice_div', 'BBSMSTR_000000000030','3');
		// RSS 가져오기
		getRssList('index', 'rss_div');
		// FAQ 가져오기
		getRecentlyBBS('index', 'faq_div', 'BBSMSTR_000000000050','3');
		// 수질오염 사고 갤러리
		getRecentlyBBS('index', 'gallery1_div', 'BBSMSTR_000000000040','4');
		// 방제지원 갤러리
		getRecentlyBBS('index', 'gallery2_div', 'BBSMSTR_000000000020','4');
	});
	
	//****************************************
	// 공지사항,최신뉴스, 갤러리등을 보여준다.
	//****************************************
	function getRecentlyBBS(view, div_id, bbsId, rowPerPage){
	
		
		
		var loading = "<table width=\"100%\" height=\"100\"><tr><td align=\"center\">"
					+ "<img alt=\"loading\" src=\"<c:url value='/images/common/ajax-loader.gif'/>\" />"
					+ "</td></tr></table>";
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/bbs/recentlyBBS.do'/>",
			data: "view="+view+"&bbsId="+bbsId+"&recordCountPerPage="+rowPerPage,
			beforeSend : function(){
							$("#"+div_id).empty();
							$("#"+div_id).append(loading);
						 },				
			success : function(html){
						$("#"+div_id).empty();
						$("#"+div_id).html(html);
					}
		});
	}	

	//****************************************
	//RSS 게시물을 ajax로 가져온다.
	//****************************************
	function getRssList(view, div_id){
		var loading = "<table width=\"100%\" height=\"100\"><tr><td align=\"center\">"
					+ "<img alt=\"loading\" src=\"<c:url value='/images/common/ajax-loader.gif'/>\" />"
					+ "</td></tr></table>";
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/rss/reader.do'/>",
			data: "view="+view,	
			beforeSend : function(){
							$("#"+div_id).empty();
							$("#"+div_id).append(loading);
						 },				
			success : function(html){
						$("#"+div_id).empty();
						$("#"+div_id).html(html);
					}
		});
	}
	
	function actionLogin() {
		if (document.loginForm.id.value =="") {
			alert("아이디를 입력하세요");
			document.loginForm.id.focus();
			return;
		} else if (document.loginForm.password.value =="") {
			alert("비밀번호를 입력하세요");
			document.loginForm.password.focus();
			return;
		} else {
			document.loginForm.action="<c:url value='/common/login/actionLogin.do'/>";
			document.loginForm.submit();
		}
	}
	
	function setCookie (name, value, expires) {
		document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
	}
	
	function getCookie(Name) {
		var search = Name + "=";
		if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
			offset = document.cookie.indexOf(search);
			if (offset != -1) { // 쿠키가 존재하면
				offset += search.length;
				// set index of beginning of value
				end = document.cookie.indexOf(";", offset);
				// 쿠키 값의 마지막 위치 인덱스 번호 설정
				if (end == -1)
					end = document.cookie.length;
				return unescape(document.cookie.substring(offset, end));
			}
		}
		return "";
	}

	function saveid(form) {
		var expdate = new Date();
		// 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
		if (form.checkId.checked)
			expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
		else
			expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
		setCookie("saveid", form.id.value, expdate);
	}

	function getid(form) {
		form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
	}

	function fnInit() {
		var message = document.loginForm.message.value;
		if (message != "") {
			alert(message);
		}
		
		//getid(document.loginForm);
		// 포커스
		document.loginForm.id.focus();
	}
//]]>

</script>

</head>
<body class="mainPage" onload="fnInit();">
	<div id="wrap">
		<div id="header">
			<dl class="hidden">
				<dt>건너뛰기</dt>
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
				<li id="gnbList1"><a href="/cmmn/link.do?page=pub/centerInfo/backgroundDesc&amp;menu=1" class="on" onmouseover="mopen(1)" onfocus="mopen(1)"
				onmouseout="mclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_list1.gif'/>" alt="센터소개" /></a>
					<ul id="gnbSub1" class="sublist1" onmouseover="mcancelclosetime()" onmouseout="mclosetime()" style="display:none">
						<li class="first"><a href="/cmmn/link.do?page=pub/centerInfo/backgroundDesc&amp;menu=1" onfocus="mcancelclosetime();" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub1_1.gif'/>" alt="추진 배경 및 경위" /></a></li>
						<li><a href="/cmmn/link.do?page=pub/centerInfo/roleMng&amp;menu=1" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub1_2.gif'/>" alt="역활 및 주요 기능" /></a></li>
						<li><a href="/cmmn/link.do?page=pub/centerInfo/infoFlow&amp;menu=1" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub1_3.gif'/>" alt="운영체계 및 조직 안내" /></a></li>
						<li class="last"><a href="/cmmn/link.do?page=pub/centerInfo/gearStat&amp;menu=1" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub1_4.gif'/>" alt="보유 장비 현황" /></a></li>
					</ul>
				</li>
				<li id="gnbList2"><a href="/cmmn/link.do?page=pub/systemInfo/systemFlow&amp;menu=2" onmouseover="mopen(2);" onfocus="mopen(2);"
				onmouseout="mclosetime();" onblur="mclosetime();"><img src="<c:url value='/images/center/gnb_list2.gif'/>" alt="시스템소개" /></a>
					<ul id="gnbSub2" class="sublist2" onmouseover="mcancelclosetime()" onmouseout="mclosetime()" style="display:none">
						<li class="first"><a href="/cmmn/link.do?page=pub/systemInfo/systemFlow&amp;menu=2" onfocus="mcancelclosetime();" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub2_1.gif'/>" alt="시스템 구성도" /></a></li>
						<li><a href="/cmmn/link.do?page=pub/systemInfo/totalMnt&amp;menu=2" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub2_2.gif'/>" alt="통합 감시 시스템" /></a></li>
						<li><a href="/cmmn/link.do?page=pub/systemInfo/preventSupport&amp;menu=2" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub2_3.gif'/>" alt="방제 지원 시스템" /></a></li>
						<li class="last"><a href="/cmmn/link.do?page=pub/systemInfo/statMnt&amp;menu=2" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub2_4.gif'/>" alt="상황 관리 시스템" /></a></li>
					</ul>
				</li>
				<li id="gnbList3"><a href="/cmmn/link.do?page=pub/preventInfo/operationFlow&amp;menu=3" onmouseover="mopen(3);" onfocus="mopen(3);"
				onmouseout="mclosetime();" onblur="mclosetime();"><img src="<c:url value='/images/center/gnb_list3.gif'/>" alt="방제정보소개" /></a>
					<ul id="gnbSub3" class="sublist3" onmouseover="mcancelclosetime()" onmouseout="mclosetime()" style="display:none">
						<li class="first"><a href="/cmmn/link.do?page=pub/preventInfo/operationFlow&amp;menu=3" onfocus="mcancelclosetime();" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub3_1.gif'/>" alt="운영체계도" /></a></li>
						<li class="last"><a href="/cmmn/link.do?page=pub/preventInfo/measureMethod&amp;menu=3" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub3_2.gif'/>" alt="오염사고 조치 매뉴얼" /></a></li>
					</ul>
				</li>
				<li id="gnbList4" class="lastMenu"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&amp;view=pub&amp;menu=4&amp;no=1" onmouseover="mopen(4);" onfocus="mopen(4);"
				onmouseout="mclosetime();" onblur="mclosetime();"><img src="<c:url value='/images/center/gnb_list4.gif'/>" alt="정보마당" /></a>
					<ul id="gnbSub4" class="sublist4" onmouseover="mcancelclosetime()" onmouseout="mclosetime()" style="display:none">
						<li class="first"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&amp;view=pub&amp;menu=4&amp;no=1" onfocus="mcancelclosetime();" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_1.gif'/>" alt="공지사항" /></a></li>
						<!-- <li><a href="/rss/reader.do?view=pub&amp;menu=4&amp;no=2" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_2.gif'/>" alt="보도자료" /></a></li>-->
						<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&amp;view=pub&amp;menu=4&amp;no=3" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_3.gif'/>" alt="FAQ" /></a></li>
						<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000060&amp;view=pub&amp;menu=4&amp;no=4" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_4.gif'/>" alt="자료실" /></a></li>
						<li><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000040&amp;view=pub&amp;menu=4&amp;no=5" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_5.gif'/>" alt="수질 오염 사례 갤러리" /></a></li>
						<li class="last"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000020&amp;view=pub&amp;menu=4&amp;no=6" onfocus="mcancelclosetime()" onblur="mclosetime()"><img src="<c:url value='/images/center/gnb_sub4_6.gif'/>" alt="방제 지원 사례 갤러리" /></a></li>
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
				
				var TimeOut = 300;
				var currentLayer = null;
				var currentitem = null;
				var currentLayerNum = 0;
				var noClose = 0;
				var closeTimer = null;
				 
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
			<div class="visual">
				<object type="application/x-shockwave-flash" data="/images/flash/main.swf" width="946px" height="358px">
					<param name="movie" value="/images/flash/main.swf" />
					<param  name="wmode" value="transparent"  />
					<!-- <img src="<c:url value='/images/center/bg_main_visual.png'/>" alt="" />-->
				</object>
			</div>
		</div><!-- //header -->
		<div id="container">
			<!-- content -->
			<div id="content">
				<div class="login">
					<script type="text/javascript">
					<!--
						function CrtLogin() {
							window.name = "waterkorea";
							window.open('/sgSample/LoginForm.jsp','CrtLogin','width=300,height=200');
						}
					//-->
					</script>
					<form name="loginForm" method="post">
						<input type="hidden" name="message" value="${message}"/>
						<fieldset>
							<legend class="hidden_phrase">로그인 폼</legend>
							<p class="txt"><img src="<c:url value='/images/center/p_login.gif'/>" alt="LOGIN 아이디와 비밀번호를 입력하세요" /></p>
							<p class="uId">
								<label for="uId">아이디</label><input type="text" class="inputText" name="id" id="uId" value=""/>
							</p>
							<p class="uPw">
								<label for="uPw">패스워드</label><input type="password" class="inputText" name="password" id="uPw" value=""/>
							</p>
							<p class="btn"><input type="image" src="<c:url value='/images/center/btn_login.gif'/>" alt="로그인" onclick="actionLogin();return false"/></p>
							<p class="join"><a href="javascript:CrtLogin()"><img src="<c:url value='/images/center/btn_join.gif'/>" alt="인증서로그인" /></a></p>
						</fieldset>
					</form>
				</div>
				<div class="board_info">
					<div id="board" class="board">
						<!-- 공지사항 -->
						<div id="board_notice" class="boardBox">
							<ul class="titList">
								<li><a href="#notice" id="notice"><img src="<c:url value='/images/center/tab_notice_on.gif'/>" alt="공지사항 활성" /></a></li>
								<!-- <li><a href="#docu" onclick="docuView(); return false;"><img src="<c:url value='/images/center/tab_docu.gif'/>" alt="보도자료" /></a></li>-->
								<li><a href="#QandA" onclick="QandAView(); return false;"><img src="<c:url value='/images/center/tab_QandA.gif'/>" alt="Q&amp;A" /></a></li>
							</ul>
							<ul class="conList" id="notice_div">
								<li>
									<a href="">
										<span class="num">10.04.06</span> 공지사항
									</a>
								</li>
								<li>
									<a href="">
										<span class="num">10.04.05</span> 호남권 수질TMS 상반기 기술교육 계획 알림이 있었나?~ 아닌가? 잘 모르겟다
									</a>
								</li>
								<li>
									<a href="">
										<span class="num">10.03.29</span> 공공하수처리시설 TN,TP 방류수수질기준 변경안된다. 그렇겠지?
									</a>
								</li>
							</ul>
							<p class="btn"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030&view=pub&menu=4"><img src="<c:url value='/images/center/btn_more.gif'/>" alt="more" /></a></p>
						</div>
						<!-- 보도자료 -->
						<!-- 
						<div id="board_docu" class="boardBox">
							<ul class="titList">
								<li><a href="#notice" onclick="noticeView(); return false;"><img src="<c:url value='/images/center/tab_notice.gif'/>" alt="공지사항" /></a></li>
								<li><a href="#docu" id="docu"><img src="<c:url value='/images/center/tab_docu_on.gif'/>" alt="보도자료 활성" /></a></li>
								<li><a href="#QandA" onclick="QandAView(); return false;"><img src="<c:url value='/images/center/tab_QandA.gif'/>" alt="Q&amp;A" /></a></li>
							</ul>
							<ul class="conList" id="rss_div">
								<li>
									<a href="">
										<span class="num">10.04.06</span> 보도자료
									</a>
								</li>
								<li>
									<a href="">
										<span class="num">10.04.05</span> 호남권 수질TMS 상반기 기술교육 계획 알림이 있었나?~ 아닌가? 잘 모르겟다
									</a>
								</li>
								<li>
									<a href="">
										<span class="num">10.03.29</span> 공공하수처리시설 TN,TP 방류수수질기준 변경안된다. 그렇겠지?
									</a>
								</li>
							</ul>
							<p class="btn"><a href="/rss/reader.do?view=pub&amp;menu=4&amp;no=2"><img src="<c:url value='/images/center/btn_more.gif'/>" alt="more" /></a></p>
						</div>
						-->
						<!-- FAQ -->
						<div id="board_QandA" class="boardBox">
							<ul class="titList">
								<li><a href="#notice" onclick="noticeView(); return false;"><img src="<c:url value='/images/center/tab_notice.gif'/>" alt="공지사항" /></a></li>
								<!-- <li><a href="#docu" onclick="docuView(); return false;"><img src="<c:url value='/images/center/tab_docu.gif'/>" alt="보도자료" /></a></li>-->
								<li><a href="#QandA" id="QandA"><img src="<c:url value='/images/center/tab_QandA_on.gif'/>" alt="Q&amp;A 활성" /></a></li>
							</ul>
							<ul class="conList" id="faq_div">
								<li>
									<a href="">
										<span class="num">10.04.06</span> Q &amp; A
									</a>
								</li>
								<li>
									<a href="">
										<span class="num">10.04.05</span> 호남권 수질TMS 상반기 기술교육 계획 알림이 있었나?~ 아닌가? 잘 모르겟다
									</a>
								</li>
								<li>
									<a href="">
										<span class="num">10.03.29</span> 공공하수처리시설 TN,TP 방류수수질기준 변경안된다. 그렇겠지?
									</a>
								</li>
							</ul>
							<p class="btn"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050&amp;view=pub&amp;menu=4&amp;no=3"><img src="<c:url value='/images/center/btn_more.gif'/>" alt="more" /></a></p>
						</div>
						<script type="text/javascript">
							//<![CDATA[
							var board = document.getElementById('board');
							var boardDiv = board.getElementsByTagName('div');
							var notice = document.getElementById('notice');
							var docu = document.getElementById('docu');
							var QandA = document.getElementById('QandA');
							var board_notice = document.getElementById('board_notice');
							//var board_docu = document.getElementById('board_docu');
							var board_QandA = document.getElementById('board_QandA');
	
							// 1. 모두 숨기기
							function allBoardHide(){
								for(var i = 0; i < boardDiv.length; i++){
									boardDiv[i].style.display = 'none';
								}
							}
							// 2. 문서 로드시 공지사항만 보이기
							window.onload = function(){
								noticeView();
							};
							
							// 3_1. 공지사항만 보이기
							function noticeView(){
								allBoardHide();
								board_notice.style.display = '';
								notice.focus();
							}
							
							// 3_2. 보도자료만 보이기
							/*
							function docuView(){
								allBoardHide();
								board_docu.style.display = '';
								docu.focus();
							}
							*/
							
							// 3_3. Q & A만 보이기
							function QandAView(){
								allBoardHide();
								board_QandA.style.display = '';
								QandA.focus();
							}
							//]]>
						</script>
					</div>
					<div class="info_wrap">
						<div class="infoCenter">
							<p><img src="<c:url value='/images/center/txt_infoCenter.gif'/>" alt="수질오염 방제 센터는" /></p>
							<ul>
								<li><a href="/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1"><img src="<c:url value='/images/center/txt_infoCenter1_1.gif'/>" alt="추진 배경" /></a></li>
								<li><a href="/cmmn/link.do?page=pub/centerInfo/roleMng&menu=1"><img src="<c:url value='/images/center/txt_infoCenter1_2.gif'/>" alt="역할 및 기능" /></a></li>
							</ul>
						</div>
						<div class="infoHow">
							<p><img src="<c:url value='/images/center/txt_infoHow.gif'/>" alt="수질오염 방제는 어떻게?" /></p>
							<ul>
								<li><a href="/cmmn/link.do?page=pub/centerInfo/infoFlow&menu=1"><img src="<c:url value='/images/center/txt_infoHow1_1.gif'/>" alt="운영 체계" /></a></li>
								<li><a href="/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3"><img src="<c:url value='/images/center/txt_infoHow1_2.gif'/>" alt="사고 조치 방법" /></a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="gallery">
					<div class="list first">
						<h2><img src="<c:url value='/images/center/h_gallery1.gif'/>" alt="수질 오염 사례 갤러리" /></h2>
						<ul id="gallery1_div">
							<li><a href="#"><img src="<c:url value='/images/center/img_main1.gif'/>" alt="" /></a></li>
							<li><a href="#"><img src="<c:url value='/images/center/img_main2.gif'/>" alt="" /></a></li>
							<li><a href="#"><img src="<c:url value='/images/center/img_main3.gif'/>" alt="" /></a></li>
							<li><a href="#"><img src="<c:url value='/images/center/img_main4.gif'/>" alt="" /></a></li>
						</ul>
						<p class="btn"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000040&amp;view=pub&amp;menu=4&amp;no=5"><img src="<c:url value='/images/center/btn_more.gif'/>" alt="more" /></a></p>
					</div>
					<div class="list">
						<h2><img src="<c:url value='/images/center/h_gallery2.gif'/>" alt="방제 지원 사례 갤러리" /></h2>
						<ul id="gallery2_div">
							<li><a href="#"><img src="<c:url value='/images/center/img_main1.gif'/>" alt="" /></a></li>
							<li><a href="#"><img src="<c:url value='/images/center/img_main2.gif'/>" alt="" /></a></li>
							<li><a href="#"><img src="<c:url value='/images/center/img_main3.gif'/>" alt="" /></a></li>
							<li><a href="#"><img src="<c:url value='/images/center/img_main4.gif'/>" alt="" /></a></li>
						</ul>
						<p class="btn"><a href="/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000020&amp;view=pub&amp;menu=4&amp;no=6"><img src="<c:url value='/images/center/btn_more.gif'/>" alt="more" /></a></p>
					</div>
				</div>
			</div><!-- //content -->
		</div><!-- //container -->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/pub/include/footer.jsp" />
		</div><!-- //footer -->
	</div>
</body>
</html>
