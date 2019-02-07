<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<script>
// init
function InfoPopup() {
	window.open("/common/member/InfoModify.do", "InfoModify", "width=750,height=350");
}

$(function(){

	//$('#gnb a[class=on] img').attr('src', ($('#gnb a[class=on] img').attr('src').replace('.gif','_over.gif')));
	
	$('#gnb a img').hover(
		function() {
			var selectedClass = $(this).parent().attr('class');
			if (selectedClass != 'on') {
				var over_img = $(this).attr('src');
				if (over_img.length > 7) {
					$(this).attr('src',over_img.replace('.gif','_over.gif'));
				}
			}
		},
		function() {
			var selectedClass = $(this).parent().attr('class');
			if (selectedClass != 'on') {
				var over_img = $(this).attr('src');
				if (over_img.length > 7) {
					$(this).attr('src',over_img.replace('_over.gif','.gif'));
				}
			}
		}
	);

	$('#snb a img').hover(
		function() {
			var selectedClass = $(this).parent().attr('class');
			if (selectedClass != 'on') {
				var over_img = $(this).attr('src');
				if (over_img.length > 7) {
					$(this).attr('src',over_img.replace('.gif','_over.gif'));
				}
			}
		},
		function() {
			var selectedClass = $(this).parent().attr('class');
			if (selectedClass != 'on') {
				var over_img = $(this).attr('src');
				if (over_img.length > 7) {
					$(this).attr('src',over_img.replace('_over.gif','.gif'));
				}
			}
		}
	);
})
</script>
<h1><a href="<c:url value='/main.do'/>"><img src="<c:url value='/images/menu_renewal/h1_logo.gif'/>" alt="한국환경공단 수질오염 방제정보 시스템" /></a></h1>
<dl class="hidden">
	<dt>건너뛰기</dt>
	<dd><a href="#content">본문</a></dd>
	<dd><a href="#footer">하단영역</a></dd>
</dl>
<!-- 상단링크 -->
<div class="lnb">
	<sec:authorize ifAllGranted="ROLE_USER">
		<p><img src="<c:url value='/images/menu_renewal/top_info_icon_1.gif'/>" alt="정보수정" /><sec:authentication property="principal.userVO.name"/>님 환영합니다.</p>
	</sec:authorize>
	<ul class="uInfo">
		<li><a href="javascript:InfoPopup()"><img src="<c:url value='/images/menu_renewal/top_info_icon_2.gif'/>" alt="정보수정" />정보수정</a></li>
		<li><a href="<c:url value='/common/login/actionLogout.do'/>"><img src="<c:url value='/images/menu_renewal/top_info_icon_3.gif'/>" alt="로그아웃" />로그아웃</a></li>
		<li><a href="<c:url value='/main.do'/>"><img src="<c:url value='/images/menu_renewal/top_info_icon_4.gif'/>" alt="HOME" />HOME</a></li>
	</ul>
</div>
<!-- //상단링크 -->
<!-- 네비 -->
<ul id="gnb" class="gnb">
<c:if test="${ not empty menuList}">
<c:forEach var="result" items="${menuList}" varStatus="status">
	<c:choose>
		<c:when test="${result.selected == 'true'}">
			<c:set var="on" value="on"/>
		</c:when>
		<c:otherwise>
			<c:set var="on" value=""/>
		</c:otherwise>
	</c:choose>
	
	<c:choose>
		<c:when test="${status.last}">
			<c:set var="lastMenu" value="lastMenu"/>
		</c:when>
		<c:otherwise>
			<c:set var="lastMenu" value=""/>
		</c:otherwise>
	</c:choose>
	
	<li class="${lastMenu}" id="gnbList${status.count}">
	 
		<a href="javascript:goTitleMenu('${result.menuNo}')" class="${on}" onmouseover="mopen(${status.count})" onfocus="mopen(${status.count})" onmouseout="mclosetime()" onblur="mclosetime()">
			<img src="<c:url value='${result.relateImagePath}gnb_${result.relateImageName}'/>" alt="${result.menuName}" />
		</a>
	 
		<ul id="gnbSub${status.count}" class="sublist${status.count}" onmouseover="mcancelclosetime();" onmouseout="mclosetime()">
			<c:choose>
		    	<c:when test="${status.first}">
		    		<c:set var="lastMenu2" value="first"/>
		    	</c:when>
		    	<c:when test="${status.last}">
		    		<c:set var="lastMenu2" value="last"/>
		    	</c:when>
		    	<c:otherwise>
		    		<c:set var="lastMenu2" value=""/>
		   		</c:otherwise>
		    </c:choose>
			<c:forEach var="result2" items="${result.subMenuList}" varStatus="status2">
			   <li class="${lastMenu2}">  
	    			<a href="javascript:goMenu('${empty result2.url ? '#': result2.url}','${result2.menuNo}')" onfocus="mcancelclosetime()" onblur="mclosetime()">
	    				<%-- <img src="<c:url value='${result2.relateImagePath}gnb_${result2.relateImageName}'/>" alt="${result2.menuName}" /> --%>
	    				${result2.menuName}
	    			</a>
	    	   </li>  
			</c:forEach>
		</ul>
	</li>
</c:forEach>
</c:if>
</ul>


<form name="menuForm" method="post">
	<input type="hidden" name="clickMenu"/>
</form>
<script type="text/javascript">
	//<![CDATA[
	// 메뉴이동 함수
	var ROOT_PATH = '<c:url value="/"/>';
	
	function goMenu(url,menuNo) {

		if (url.lastIndexOf("javascript") > -1) {
			eval(url.substr(11,url.length));
		} else {
			//document.menuForm.action = url;
			document.menuForm.action = ROOT_PATH+url.substring(1, url.length);
			document.menuForm.clickMenu.value = menuNo;
			document.menuForm.submit();
		}
	}

	function goTitleMenu(menuNo){
		var url = '';
		var subMenuNo = '';		
		
		if(menuNo == '10000'){
			url = '/waterpolmnt/waterinfo/goFactDetail.do';
			subMenuNo = '11000';

			goMenu(url,subMenuNo);
		}else if(menuNo == '20000'){
			url = '/psupport/psupport.do?param=psupport/list&menuID=4100';
			subMenuNo = '21000';

			goMenu(url,subMenuNo);
		}else if(menuNo == '30000'){
			url = '/psupport/psupport.do?param=psupport/list&menuID=5110';
			subMenuNo = '31000';

			goMenu(url,subMenuNo);
		}else if(menuNo == '40000'){
			url = '/admin/member/MemberList.do';
			subMenuNo = '41000';

			goMenu(url,subMenuNo);
		}else if(menuNo == '50000'){
			url = '/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030';
			subMenuNo = '51000';

			goMenu(url,subMenuNo);
		}
	}
	
	var gnb = document.getElementById("gnb");
	var gnbUl = gnb.getElementsByTagName("ul");
	//alert(gnbUl.length)
	for(var i = 0; i < gnbUl.length; i++){
		gnbUl[i].style.display = "none";
	}

	var TimeOut         = 10000;
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

	function admin_popup() {
		
		var sw=screen.width;var sh=screen.height;var winHeight = 795;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("<c:url value='/waterpolmnt/situationctl/goTotalMntMainTS.do'/>?", 
				'DetailView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}

	function manager_popup() {

		var sw=screen.width;var sh=screen.height;var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("<c:url value='/waterpolmnt/situationctl/goWATERSYSMNT.do?'/>", 
				'DetailView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
</script>
<!-- //네비 -->
