<!--
	Filename : Logout.jsp
-->

<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head>
<title>Logout Page Sample</title>
</head>

<body onLoad="javascript:do_logout()">

<%@ include file="signgate_common.jsp" %>

<%
	// 로그아웃을 할 경우에 사용자가 선택한 인증서의 정보를 사용자 PC의 메모리에서 지우고 초기화하기 위하여
	// 사용자의 로그인 ID를 <form>의 hidden 타입 <input>에 저장한다.
	String strUserLoginID = (String) session.getAttribute( "LOGINID" );
	if ( strUserLoginID == null )
	{
		// 로그인 페이지에서 사용자 인증 데이터를 검사하다가 실패한 경우에
		// 사용자가 선택한 인증서 정보를 메모리에서 지우기 위하여 사용한다.
		strUserLoginID = (String) session.getAttribute( "TEMPID" );
		if ( strUserLoginID == null )
		{
			strUserLoginID = "";
		}
	}

	// WAS 세션에서 로그인 상태 판단을 위한 정보를 지운다.
	session.removeAttribute( "CHALLENGE" );
	session.removeAttribute( "LOGINID" );
	session.removeAttribute( "SESSIONKEY" );
	session.removeAttribute( "TEMPID" );
	session.removeAttribute( "CERT_SUBJECT_DN" );
	session.removeAttribute( "SIGN_CERT_SERIAL" );
%>

<script language="javascript">

function do_logout()
{
	var strDomainName = "@ews.signgate.com";
	var strCertID = "<%=strUserLoginID%>";
	if ( strCertID != "" )
	{
		strCertID += strDomainName; 
		clearCertificateInfo( strCertID );
	}
	location.href = "./";
}

</script>

</body>
</html>
