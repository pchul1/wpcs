<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp"/>
<script type="text/javascript">
function goSubmit() {
	if(!vailidation($("[name='id']"),'아이디를 입력해 주세요')) return false;
	else if(!vailidation($("[name='password']"),'패스워드를 입력해 주세요')) return false;
	else {document.form1.submit();}
}

$(function(){
	$("body").keyup(function(){
		if(event.keyCode == 13)
		{
			goSubmit();
		}
	});
});
</script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
	<jsp:param value="Y" name="notlogin"/>
</jsp:include>
<c:if test="${fn:indexOf(url,'waterkorea.or.kr') >= 0 }">
<form name="form1" method="post" action="https://www.waterkorea.or.kr:443/mobile/loginAction.do">
</c:if>
<c:if test="${fn:indexOf(url,'waterkorea.or.kr') < 0 }">
<form name="form1" method="post" action="/mobile/loginAction.do">
</c:if>
        <div id="login">  
			<div class="login" align="center">
				<table width="280px">
					<colgroup>
						<col width="30%" />
						<col width="60%" />
						<col width="60%" />
					</colgroup>
					<tr>
						<th colspan="3" height="70px;">수질오염방제시스템</th>
					</tr>
					<tr>
						<td align="left">아이디</td>
						<td><input type="text"  name="id" value=""/></td>
					</tr>
					<tr>
						<td align="left">비밀번호</td>
						<td><input type="password" name="password" value=""/></td>
					</tr>
					<tr>
						<td colspan="3" height="50px" style="color:red;">※ 수질오염방제정보시스템에서 사용하는 아이디와 비밀번호로 로그인 해주세요.</td>
					</tr>
				</table>
			</div>
			<ul class="sbtn">
				<li style="width:90%"><a href="#" onclick="return goSubmit(); return false;">로그인</a></li>
			</ul>
        </div>
</form>        
<jsp:include page="/WEB-INF/jsp/mobile/common/bottom.jsp"/>
</body>
</html>