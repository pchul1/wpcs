<%@page import="java.util.Random, java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper"%>
<%@ page import="daewooInfo.common.login.bean.LoginVO"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<c:set var="url" value="<%=request.getRequestURL()%>"/>
<%if(TmsUserDetailsHelper.isAuthenticated()) {%>
	<jsp:forward page="/main.do"/>
<%}%>
<%
//난수 발생 
Random rand = new Random();
String Rnd = rand.nextInt(10000000) + "";
request.getSession().setAttribute("NormalityLogin", Rnd); 
%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1"/> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<!-- 2014.02.24 추가된 부분 -->
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script> -->
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/common2.js"></script>
<!-- //2014.02.24 추가된 부분 -->
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>

<!-- 2015.11.06 Nethru 로그분석 스크립트 추가 -->
<script type="text/javascript" src="/js/makePCookie.js"></script>

<!-- 2018.05.30 AES 스크립트 추가 -->
<script type="text/javascript" src="/js/aes.js"></script>
<script type="text/javascript" src="/js/AesUtil.js"></script>
<script type="text/javascript" src="/js/pbkdf2.js"></script>

<script type="text/javascript">

<c:if test="${param.maxsession eq 'y'}">alert('다른PC에서 같은계정으로 로그인 하였습니다.');</c:if>

<c:forEach items="${popupList}" var="item" varStatus="status">
	if(getCookie("popup<c:out value="${item.nttId}"/>") != "O"){
		window.open("/popupNotice.do?nttId=<c:out value="${item.nttId}"/>","<c:out value="${item.nttId}"/>","top=<c:out value="${(status.count * 10) + 100}"/>,left=<c:out value="${status.count * 100}"/>,width=400,height=600")
	}
</c:forEach>

//<![CDATA[
 	mobileCheck();
	$(function(){
	
		// 익스 9이하 체크 
		var ua = window.navigator.userAgent
		if(ua.indexOf("MSIE") > -1){
			if(Number(ua.substring(ua.indexOf("MSIE")+5,ua.indexOf(";",ua.indexOf("MSIE")))) < 9) {
				$("#ie8div").css("display","");
				$("#ieversion").html(ua.substring(ua.indexOf("MSIE")+5,ua.indexOf(".",ua.indexOf("MSIE"))));
			}
		}
		// RSS 가져오기
// 		getRssList('index', 'rss_div');
		// 공지사항 가져오기
		getRecentlyBBS('index', 'content3_1', 'BBSMSTR_000000000030','6');
		// FAQ 가져오기
		getItemCondition('index', 'content3_2');
		// 수질오염 사례 갤러리
		getRecentlyBBS('index', 'content3_3', 'BBSMSTR_000000000040','5');
		// 방제지원 사례 갤러리
		getRecentlyBBS('index', 'content3_4', 'BBSMSTR_000000000020','5');
		// 교육정보 가져오기
		//getRecentlyBBS('index', 'content3_3', 'BBSMSTR_000000000020','5');
		// 방제영상
		getRecentlyBBS('index', 'content3_5', 'BBSMSTR_000000000120','5');
		var today = new Date(); 
		today = today.getFullYear()
		//chartload(today);
		
		mainGrid($("#tabimg1_1"));
		$("#mainWaterSysgrid img").click(function(i){
			mainGrid(this);
		});
	});
 	
	function mainGrid(n){
		$("#mainWaterSysgrid img").each(function(i){
			$(this).attr("src","/images/new/water_tab0"+ (i+1) +".gif");
		});
		$(n).attr("src","/images/new/water_tab0"+ ($("#mainWaterSysgrid img").index(n) + 1) +"_on.gif");
		

		$("#tdton").html("-");
		$("#tdphy").html("-");
		$("#tdcon").html("-");
		$("#tddow").html("-");
		$("#tdtmp").html("-");
		$("#tdtoc").html("-");
		$("#tdtof").html("-");
		
		adjustGongku($(n).attr("river_div"));
	}
	
	function IndexWaterSysMainDetail(val){
		if(jQuery.type(val) == 'undefined' ){
			val = $("#fact_code").val();
		}
		$.ajax({
			type: "POST",
			url: "<c:url value='/IndexWaterSysMainDetail.do'/>",
			data: 
				{
					fact_code:val
				},
			dataType: 'json',  
			success : function(result){
				$("#tdton").html((result.data[0].ton == "") ? "-" : result.data[0].ton);
				$("#tdphy").html((result.data[0].phy == "") ? "-" : result.data[0].phy);
				$("#tdcon").html((result.data[0].con == "") ? "-" : result.data[0].con);
				$("#tddow").html((result.data[0].dow == "") ? "-" : result.data[0].dow);
				$("#tdtmp").html((result.data[0].tmp == "") ? "-" : result.data[0].tmp);
				$("#tdtoc").html((result.data[0].toc == "") ? "-" : result.data[0].toc);
				$("#tdtof").html((result.data[0].tof == "") ? "-" : result.data[0].tof);
			},
			 error: function(data) {
				alert('에러! 상태 = ' + data.status);
			 }
		});
	}
	
	function adjustGongku(river_div) {
		var sugyeCd = river_div;
		var sys_kind = "A";
		var dropDownSet = $('#fact_code');
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#fact_code>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("/waterpolmnt/waterinfo/getGongkuList.do",
					{sugye:sugyeCd, system:sys_kind}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					if (sys_kind == "U"){
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
					}
					IndexWaterSysMainDetail($("#fact_code").val());
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
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
			var uId = $('#uId').val();
			$.getJSON("<c:url value='/common/login/getApprovalIdCheck.do'/>", {uId:uId}, function (data, status){
				 if(status == 'success'){
					 var keySize = 128;
					 var iterations = iterationCount = 10000;
					  
					 var iv = "F27D5C9927726BCEFE7510B1BDD3D137";
					 var salt = "3FF2EC019C627B945225DEBAD71A01B6985FE84C95A70EB132882F88C0A59A55";
					 var passPhrase = "waterkorea aes encoding algorithm";
					  
					 var aesUtil = new AesUtil(keySize, iterationCount);
					 var encryptId = aesUtil.encrypt(salt, iv, passPhrase, document.loginForm.id.value);
					 var encryptPassword = aesUtil.encrypt(salt, iv, passPhrase, document.loginForm.password.value);
					 
					 document.loginForm.id.value = encryptId;
					 document.loginForm.password.value = encryptPassword;
					 
					if(data.approvalFlag=='Y' || data.approvalFlag=='S'){
						<c:if test="${fn:indexOf(url,'waterkorea.or.kr') >= 0 }">
						document.loginForm.action="<c:url value='https://www.waterkorea.or.kr:443/common/login/actionLogin.do'/>";
						</c:if>
						<c:if test="${fn:indexOf(url,'waterkorea.or.kr') < 0 }">
						document.loginForm.action="<c:url value='/common/login/actionLogin.do'/>";
						//document.loginForm.action="<c:url value='https://www.waterkorea.or.kr:443/common/login/actionLogin.do'/>";
						</c:if>
//			 			document.loginForm.action="https://www.waterkorea.or.kr:443/common/login/actionLogin.do"; //운영에서 사용할 것 
						document.loginForm.submit();
					/*}else if(data.approvalFlag=='S'){
						if(confirm("계정승인 요청 중입니다. 계정신청 내역을 확인 하시겠습니까?")){
							$("#memberId").val(uId);
							document.loginForm.action="<c:url value='/acc/accountAppFinish.do'/>";
							document.loginForm.submit();
						}
						alert("계정승인 요청 중입니다. 계정 승인이 완료된 후에 서비스를 이용하실 수 있습니다.");
						return;*/
					}else if(data.approvalFlag=='X'){
						alert("로그인 정보가 올바르지 않습니다.");
						return;
					}else if(data.approvalFlag=='N'){
						alert("로그인 하실 수 없습니다.");
						return;
					}
					
				 } else { 
					return;
				 }
			});
			
		}
	}
	
	function mobileCheck(){
		//check browser
		var tmpUser = navigator.userAgent;
		
		if (tmpUser.indexOf("iPhone") > 0 || tmpUser.indexOf("iPod") > 0 || tmpUser.indexOf("Android ") > 0 )
		{
			window.location = "/mobile/";
		}
	}
	
	function fnLoginType(){
		var type = $('input:radio[name="loginType"]:checked').val();
		if(type=='type1'){
			$("#loginType1").attr("class", "show");
			$("#loginType2").attr("class", "hide");
		}else{
			$("#loginType1").attr("class", "hide");
			$("#loginType2").attr("class", "show");
			CrtLogin();
		}
	}
	
	//인증서로그인
	function CrtLogin() {
		window.name = "waterkorea";
		window.open('/sgSample/LoginForm.jsp','CrtLogin','width=300,height=200');
	}
	
	function MM_openBrWindow(theURL,winName,features) { //v2.0
		window.open(theURL,winName,features);
	}
	
	var loading = "<table width='100%' height='100'><tr><td align='center'>"
		+ "<img alt='loading' src=<c:url value='/images/common/ajax-loader.gif'/> />"
		+ "</td></tr></table>";
		
	//공지사항, 최신뉴스, 갤러리등을 보여준다.
	function getRecentlyBBS(view, div_id, bbsId, rowPerPage){
		
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
						
						if(bbsId == "BBSMSTR_000000000040" || bbsId == "BBSMSTR_000000000020")
						{
							$("#"+div_id).find("img").attr("width","140");
							$("#"+div_id).find("img").attr("height","100");
						}
					}
		});
	}
	
	//방제장비물품현황 가져오기.
	function getItemCondition(view, div_id){
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/recentlyItemCondition.do'/>",
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
	
	//RSS 게시물을 ajax로 가져온다.
	function getRssList(view, div_id){
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
	
	function mainchartwaterpollyear(n){
// 		var year = $("#waterYear").html();
// 		if(n == "-") chartload(Number(year) - 1);
// 		else chartload(Number(year) + 1);
	}
	
	function chartload(year){
// 		$("#waterYear").html(year);
		$("#chart1").attr("src","");
		/* $("#chart2").attr("src","");
		$("#chart3").attr("src","");
		$("#chart4").attr("src",""); */
		$("#chart1").attr("src","/indexWaterPollutionChart.do");
		/* $("#chart2").attr("src","/indexWaterPollutionChart.do?year="+year+"&river_div=R02");
		$("#chart3").attr("src","/indexWaterPollutionChart.do?year="+year+"&river_div=R03");
		$("#chart4").attr("src","/indexWaterPollutionChart.do?year="+year+"&river_div=R04"); */
	}
	
	function setCookie (name, value, expires) {
	    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
	}

	function getCookie(Name) {
	    var search = Name + "="
	    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
	        offset = document.cookie.indexOf(search)
	        if (offset != -1) { // 쿠키가 존재하면
	            offset += search.length
	            // set index of beginning of value
	            end = document.cookie.indexOf(";", offset)
	            // 쿠키 값의 마지막 위치 인덱스 번호 설정
	            if (end == -1)
	                end = document.cookie.length
	            return unescape(document.cookie.substring(offset, end))
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
	    
	    getid(document.loginForm);
	    // 포커스
	    //document.loginForm.id.focus();
	}
 //]]>
</script>
</head>

<body onload="fnInit()">
<!-- wrap -->
<div id="wrap"> 
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
            <li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3'/>"><img src="/images/new/img_submenu03_02.png" alt="오염사고 조치 메뉴얼" /></a></li>
            <li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3'/>">오염사고 조치 메뉴얼</a></li>
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
	
	<!--container -->
	<div class="container_wrap">
		<div style="width:100%;position:absolute;z-index:10000;display:none;" id="ie8div">
			<div style="background-color:white;margin:0 auto;width: 964px;padding:20px;height:175px;border: 1px solid #666666;background-color:#DDDDDD;border-radius: 5px;">
				<div>
					<div style="float:left;"><img src="/images/new/noie.png" alt="None Internet Explorer"/></div>
					<div style="position:relative;">
						<div style="position:absolute;right:-5px;top:-10px;font-size:18px;"><a href="#" onclick="$('#ie8div').css('display','none'); return false;">X</a></div>
						<div style="padding-left:180px;">
							<div style="color:blue;font-size:20px;">익스플로러 <span id="ieversion"></span>로 접속하셨습니다.</div>
							<div style="padding-top:20px;font-size:13px;width:760px;">수질오염방제정보 시스템은 <span style="color:blue;font-weight: bold;">익스플로러9</span> 미만에서는 속도저하, 해킹, 악성코드 감염의 원인이 되어 더 이상 지원하지 않습니다. 안전한 인터넷이용을 위해 브라우저를 업그레이드 하시길 바랍니다.</div>
						</div>
						<div style="background: linear-gradient(to bottom, rgb(139, 189, 255) 0%, rgb(86, 153, 216) 100%) repeat scroll 0px 0px transparent; border: 1px solid #AAAAAA;border-radius: 5px; width: 300px; position: absolute; padding: 10px; left: 370px; height: 40px; top: 114px;cursor: pointer;" onclick="location.href='/bbs/selectBoardArticle.do?bbsId=BBSMSTR_000000000050&nttId=127&view=pub&menu=4&no=3';">
							<div style="margin:0 auto;width: 255px;cursor: pointer;">
								<div style="float:left;cursor: pointer;"><img src="/images/new/ie.png" width="40px" alt="Internet Explorer"/></div>
								<div style="padding:9px 0 15px 55px;font-size:15px;color:white;cursor: pointer;">익스플로러 9업그레이드 하기 &gt;</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="container">
			<div class="section_visual">
				<ul>
					<!-- <li><a href="https://www.safepeople.go.kr/api?apiKey=B55258493Y1K0S2P7BOB884708W" target="_blank" title="함께하는 안전점검! 함께가는 안전강국! 2017 국가안전대진단(2.6~3.31) 새창열림"><img src="/images/new/img_visual04.gif"/></a></li> -->
					<li><img src="/images/new/img_visual01.gif"  alt="안정한 물환경 조성으로 자연 가까이 사람 가까이" /></li>
			        <li><img src="/images/new/img_visual02.gif"  alt="누구나 쉽게 즐길 수 있는 물환경과 자연생태계 유지" /></li>
			        <li><img src="/images/new/img_visual03.png"  alt="모두가 누리는 안전하고 깨끗한 물, 물관리 일원화로 시작하겠습니다." /></li>
				</ul>
				<p class="point">
		          <img src="/images/new/bu_round01.png" alt="1" /> 
		          <img src="/images/new/bu_round02.png" alt="2" /> 
		          <img src="/images/new/bu_round02.png" alt="3" />
		          <!-- <img src="/images/new/bu_round02.png" alt="4" /> -->
		        </p>
			</div>
			<div class="section_login">
				<h2><img src="/images/new/img_login_title.gif" width="153" height="27" alt="keco login" /></h2>
				<ul class="section_login_select">
					<li>
						<input name="loginType" type="radio" value="type1" id="id" checked="checked" onclick="fnLoginType();"/>
						<label for="id">ID/PW 로그인</label>
					</li>
					<li>
						<input name="loginType" type="radio" value="type2" id="cert"  onclick="fnLoginType();"/>
						<label for="cert">인증서 로그인</label>
					</li>
				</ul>
			
				<!-- id/pw 로그인 -->
				<div>
					<div class="section_login_box">
						<div id="loginType1">
							<form name="loginForm" method="post">
							<input type="hidden" name="message" value="${message}"/>
							<input type="hidden" name="NormalityLogin" value="<%=Rnd %>"/>
							<input type="hidden" name="memberId" id="memberId"/>
							<ul>
								<li>
									<input type="text" title="아이디" class="login_id" id="uId" name="id" onkeydown="javascript: if(event.keyCode == 13) actionLogin();"/>
								</li>
								<li>
									<input type="password" title="비밀번호" class="login_pw" id="uPw" name="password" onkeydown="javascript: if(event.keyCode == 13) actionLogin();"/>
								</li>
							</ul>
							<p><img src="/images/new/btn_login.gif" alt="로그인" style="cursor:pointer;" onclick="javascript:actionLogin(); return false;"/></p>
							<p class="section_missing"><input type="checkbox" name="checkId" onClick="javascript:saveid(document.loginForm);" id="checkId"/> <label for="checkId">아이디저장</label></p>
							</form>
						</div>
						<div id="loginType2" class="hide" style="height:70px;">
							<p style="text-align:center;"><img src="/images/new/btn_login02.gif" alt="로그인" style="cursor:pointer;" onclick="javascript:CrtLogin();" /></p>
						</div>
					</div>
					<p class="section_missing"><a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountApp&menu=6'/>" class="first">계정신청</a>|<a href="<c:url value='/acc/accountFindId.do'/>">아이디/비밀번호 찾기</a></p>
				</div>
			</div>
			<div class="section_content02">
				<%-- <div class="section_quality">
					  <h3>수질측정 (국가수질)</h3>
					  <p class="tab cursor" id="mainWaterSysgrid"><span><img src="/images/new/water_tab01_on.gif" id="tabimg1_1" alt="산업통상지원부 소식" river_div="R01"/></span><span><img src="/images/new/water_tab02.gif" id="tabimg1_2" alt="입찰공고" river_div="R02"/></span><span><img src="/images/new/water_tab03.gif" alt="입찰공고" id="tabimg1_3"  river_div="R03"/></span><span><img src="/images/new/water_tab04.gif" alt="입찰공고" id="tabimg1_4"  river_div="R04"/></span></p>
					<div class="section_quality01">
						<div id="content1" class="show">
							<ul>
								<li style="float:left;"><select name="fact_code" id="fact_code" style="width:140px;"></select></li>
<!-- 								<li> -->
<!-- 								<select name="toDate" id="toDate" style="width:75px;"> -->
									<c:forEach begin="${pj:toDay('yyyy') - 5}" end="${pj:toDay('yyyy')}" step="1" var="i">
										<option value="<c:out value="${i}"/>" <c:if test="${i eq pj:toDay('yyyy')}">selected="selected"</c:if>><c:out value="${i}"/>년</option>
									</c:forEach>
<!-- 								</select> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<select name="toTime" id="toTime" style="width:60px;"> -->
										<c:forEach begin="1" end="12" step="1" var="i">
											<c:set value="${i}" var="min"/>
											<c:if test="${i<10}">
												<c:set value="0${i}" var="min"/>
											</c:if>
											<option value="<c:out value="${min}"/>" <c:if test="${min eq pj:toDay('MM')}">selected="selected"</c:if>><c:out value="${min}"/>월</option>
										</c:forEach>
<!-- 									</select> -->
<!-- 								</li>   -->
								<li style="float:right;"><img src="/images/new/btn_search.gif" alt="조회" onclick="IndexWaterSysMainDetail()" style="cursor: pointer;"/></li>
							</ul>
							<div class="section_table01">
								<table width="200" border="0">
									<tbody>
									<tr>
										<th style="width:27px;font-size:11px;text-align:center;padding:3px;"><strong>수온</strong>(℃)</th>
										<th style="width:40px;font-size:11px;text-align:center;padding:3px;"><strong>용존산소</strong>(㎎/L)</th>
										<th style="width:52px;font-size:11px;text-align:center;padding:3px;"><strong>전기전도도</strong>(㎲/㎝)</th>
										<th style="width:36px;font-size:11px;text-align:center;padding:3px;"><strong>수소이온농도</strong></th>
									</tr>
									<tr>
										<td style="font-size:11px;text-align:center;padding:3px;" id="tdtmp">-</td>
										<td style="font-size:11px;text-align:center;padding:3px;" id="tddow">-</td>
										<td style="font-size:11px;text-align:center;padding:3px;" id="tdcon">-</td>
										<td style="font-size:11px;text-align:center;padding:3px;" id="tdphy">-</td>  
									</tr>
									<tr>
										<th style="font-size:11px;text-align:center;padding:3px;"><strong>총인</strong>(㎎/L)</th>
										<th style="font-size:11px;text-align:center;padding:3px;"><strong>총질소</strong>(㎎/L)</th>
										<th style="font-size:11px;text-align:center;padding:3px;"><strong>총유기탄소</strong>(㎎/L)</th>
										<th style="font-size:11px;text-align:center;padding:3px;"></th>
									</tr>
									<tr>
										<td style="font-size:11px;text-align:center;padding:3px;" id="tdton">-</td>
										<td style="font-size:11px;text-align:center;padding:3px;" id="tdtof">-</td>
										<td style="font-size:11px;text-align:center;padding:3px;" id="tdtoc">-</td>
										<td style="font-size:11px;text-align:center;padding:3px;"></td>
									</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div> --%>
				<div class="section_quality"><c:set var="now" value="<%=new java.util.Date() %>"/>
					<h3 style="width:100%;"><div style="float:left;width:80%;">'<fmt:formatDate value="${now }" pattern="yy" />년도 방제지원 현황 <c:if test="${WaterCount ne 0 }">(<c:out value="${WaterCount }"/>)</c:if></div>
						<div style="float:right;width:20%;margin-top:5px;">
							<div style="background-color:#C73800;width:10px;height:10px;float:left;padding:2px;margin-top:4px;margin-right:4px;"></div>
							<div style="float:left;font-size:14px;">지원&nbsp;&nbsp;</div>
							<div style="background-color:#46B1C2;width:10px;height:10px;float:left;padding:2px;margin-top:4px;margin-right:4px;"></div> 
							<div style="float:left;font-size:14px;">접수</div>
						</div>
					</h3>
					<p class="tab cursor"><!-- <span><img src="/images/new/water_tab01_on.gif" id="tabimg2_1" onclick="tab2(1)"  alt="산업통상지원부 소식" /></span><span><img src="/images/new/water_tab02.gif" id="tabimg2_2" onclick="tab2(2)"  alt="입찰공고" /></span><span><img src="/images/new/water_tab03.gif" alt="입찰공고" id="tabimg2_3" onclick="tab2(3)"  /></span><span><img src="/images/new/water_tab04.gif" alt="입찰공고" id="tabimg2_4" onclick="tab2(4)"   /></span> --></p>
					<div class="section_quality02">
						<div id="content2_1" class="show">
							<img src="/indexWaterPollutionChart.do" alt="chart alt test"/>
							<!-- <p><iframe frameborder="0" marginheight="0" marginwidth="0" id="chart1" width="733px" height="182px" scrolling="no" title="chart"></iframe></p> -->
						</div>
						<!-- <div id="content2_2" class="hide">
							<p><iframe frameborder="0" marginheight="0" marginwidth="0" id="chart2" width="357px" height="152px" scrolling="no"></iframe></p>
						</div>
						<div id="content2_3" class="hide">
							<p><iframe frameborder="0" marginheight="0" marginwidth="0" id="chart3" width="357px" height="152px" scrolling="no"></iframe></p>
						</div>
						<div id="content2_4" class="hide">
							<p><iframe frameborder="0" marginheight="0" marginwidth="0" id="chart4" width="357px" height="152px" scrolling="no"></iframe></p>
						</div> -->
					</div>
				</div>
				<div class="section_defence">
					<h3><img src="/images/new/h3_defence.gif" alt="수질오염방지센터는" /></h3>
					<p><img src="/images/new/img_defence_text.gif" width="207" height="27" alt="수질오염 생태계 훼손으로부터 안전한 물환경 조성" /></p>
					<ul>
						<li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/backgroundDesc&menu=1'/>"><img src="/images/new/img_defence01.gif" width="87" height="109" alt="추진 배경"/></a></li>
						<li><a href="<c:url value='/cmmn/link.do?page=pub/centerInfo/roleMng&menu=1'/>"><img src="/images/new/img_defence02.gif" width="87" height="109" alt="역할 및 기능" /></a></li>
					</ul>
				</div>
			</div>
			<div class="section_content03">
				<div class="section_notice">
					<p class="tab cursor"><span><img src="/images/new/notice_tab01_on.gif" id="tabimg3_1" onclick="tab3(1)"  alt="공지사항" /></span><span><img src="/images/new/notice_tab02.gif" id="tabimg3_2" onclick="tab3(2)"  alt="방제장비물품현황" /></span><span><img src="/images/new/notice_tab03.gif" alt="방제사진" id="tabimg3_3" onclick="tab3(3)"  /></span><span><img src="/images/new/notice_tab04.gif" alt="교육" id="tabimg3_4" onclick="tab3(4)"   /></span><span><img src="/images/new/notice_tab05.gif" alt="방제영상" id="tabimg3_5" onclick="tab3(5)"   /></span></p>
					<div class="section_notice01">
						<div id="content3_1" class="show">
						</div>
						<div id="content3_2" class="hide">
						</div>
						<div id="content3_3" class="hide">
							<ul>
								<li><img src="/images/new/img_pic01.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic02.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic03.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic04.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic05.gif" alt="image" /></li>
							</ul>
						</div>
						<div id="content3_4" class="hide">
							<ul>
								<li><img src="/images/new/img_pic01.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic02.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic03.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic04.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic05.gif" alt="image" /></li>
							</ul>
<!-- 							<p class="left"><img src="/images/new/btn_left.png" alt="left" /></p> -->
<!-- 							<p class="right"><img src="/images/new/btn_right.png" alt="right" /></p> -->
						</div>
						<div id="content3_5" class="hide">
							<ul>
								<li><img src="/images/new/img_pic01.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic02.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic03.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic04.gif" alt="image" /></li>
								<li><img src="/images/new/img_pic05.gif" alt="image" /></li>
							</ul>
<!-- 							<p class="left"><img src="/images/new/btn_left.png" alt="left" /></p> -->
<!-- 							<p class="right"><img src="/images/new/btn_right.png" alt="right" /></p> -->
						</div>
					</div>
				</div>
				<div class="section_dhow">
					<h3><img src="/images/new/h3_dhow.gif" alt="수질오염방제센터는" /></h3>
					<p><img src="/images/new/img_dhow_text.gif" width="208" height="44" alt="수질오염 생태계 훼손으로부터 안전한 물환경 조성" /></p>
					<ul>
						<li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/operationFlow&menu=3'/>"><img src="/images/new/img_operating.gif" width="83" height="104" alt="운영체계" /></a></li>
						<li><a href="<c:url value='/cmmn/link.do?page=pub/preventInfo/measureMethod&menu=3'/>"><img src="/images/new/img_accident.gif" width="83" height="104" alt="사고조치방법" /></a></li>
						</ul>
				</div>
			</div>
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

