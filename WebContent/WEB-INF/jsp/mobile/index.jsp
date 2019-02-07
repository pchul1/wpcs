<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp"/>
<script>
$(function(){
	<c:if test="${!empty userPhone}">
	sessionStorage.userPhone = '<c:out value="${userPhone}"/>';
	</c:if>
});

function onetouchclick(){
	if(sessionStorage.userPhone == undefined){
		if(confirm('원터치 신고 기능은 모바일앱에서 이용가능합니다. 앱을 다운 받으시겠습니까?'))
		{
			down(2);
		}		
	}else{
		location.href="/mobile/onetouch/firststep.do";
	}
}

function down(n){
	location.href ='/mobile/download/waterkoreaWeb.apk';
}

function resolution() {
	/* $('#popup').bPopup({
	    content:'image', 
	    contentContainer:'.content',
	    loadUrl:'/images/mobile/main/resolution_cont.png'
	}); */
	$('#popup').bPopup();
}

</script>
</head>
<body>

<div class="main">
    <jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="Y" name="notlogin"/>
	</jsp:include>
	<div>
		<img src="/images/mobile/main/main.gif" width="100%"/>
	</div>
	
	<div class="mainbox100">
		<div style="padding:7px 7px 0 7px;" >
			<a href="#" onclick="onetouchclick(); return false;"><img src="/images/mobile/main/onetouch.gif"  border="0" width="100%"/></a>
		</div>
	</div>
	
	<!-- <div style="width:100%;overflow: hidden;">
		<div class="mainbox100">
			<div style="padding:7px;">
				<div style="width:50%;float:left;">
					<div>
						<a href="#" onclick="down(1);"><img src="/images/mobile/main/down1.gif" border="0" width="100%"/></a>
					</div>
				</div>
				<div style="width:100%;float:left;">
					<div>
						<a href="#" onclick="down(2);"><img src="/images/mobile/main/down2.jpg" border="0" width="100%"/></a>
					</div>
				</div>
			</div>
		</div>
	</div> -->
	
	<div class="mainbox100">
		<div style="padding:7px 7px 0 7px;" >
			<a href="#" onclick="resolution(); return false;"><img src="/images/mobile/main/resolution.png"  border="0" width="100%"/></a>
		</div>
	</div>
	<div id="popup" class="popup">
        <span class="button b-close"><span>X</span></span>
        <!-- <div class="content"></div> -->
        <img src="/images/mobile/main/resolution_cont.png"  border="0" width="100%"/>
    </div>
</div>
<jsp:include page="/WEB-INF/jsp/mobile/common/bottom.jsp"/>
</body>
</html>