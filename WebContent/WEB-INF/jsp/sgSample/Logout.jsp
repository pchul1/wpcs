<!--
	Filename : Logout.jsp
-->

<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
<title>Logout Page Sample</title>
</head>

<body onLoad="javascript:do_logout()">

<%@ include file="signgate_common.jsp" %>

<%
	// �α׾ƿ��� �� ��쿡 ����ڰ� ������ �������� ������ ����� PC�� �޸𸮿��� ����� �ʱ�ȭ�ϱ� ���Ͽ�
	// ������� �α��� ID�� <form>�� hidden Ÿ�� <input>�� �����Ѵ�.
	String strUserLoginID = (String) session.getAttribute( "LOGINID" );
	if ( strUserLoginID == null )
	{
		// �α��� ���������� ����� ���� �����͸� �˻��ϴٰ� ������ ��쿡
		// ����ڰ� ������ ������ ������ �޸𸮿��� ����� ���Ͽ� ����Ѵ�.
		strUserLoginID = (String) session.getAttribute( "TEMPID" );
		if ( strUserLoginID == null )
		{
			strUserLoginID = "";
		}
	}

	// WAS ���ǿ��� �α��� ���� �Ǵ��� ���� ������ �����.
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
