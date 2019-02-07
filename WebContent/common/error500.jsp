<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/sample.css'/>"/> --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/sample.css'/>"/>
<title>Error페이지</title>
</head>
<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="100%" height="100%" align="center" valign="middle" style="padding-top:150px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<img src="<c:url value='/images/error/error500.jpg'/>" alt="허용되지 않는 요청을 하셨습니다." />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>