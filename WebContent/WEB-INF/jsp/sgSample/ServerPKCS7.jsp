<!--
	Filename : ServerPKCS7.jsp
-->

<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
<title>Client-side PKCS7 Sample</title>
</head>

<body>

<%@ page import="java.security.cert.*" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>

<%@ include file="signgate_common.jsp" %>

<script>
	var LogoutPageUrl = 'Logout.jsp';
</script>

<%
	// ��������� ���� ���ؼ� ����� ���� �����Ϳ� ���Խ�Ų nonce�� ���ǿ� ���� ���
	if ( session.getAttribute( "certId" ) == null ) 
	{
		%><script>alert( '�������� �����Ǿ ������ ���������ϴ�.\n�ٽ� �õ��Ͽ� �ֽʽÿ�.' ); location.href=LogoutPageUrl;</script><%
		return;
	}
	String strCertId = (String) session.getAttribute( "certId" ); // ����� ���� �����͸� �˻��� �� �ʿ��� nonce�� ��´�.

%>

<h2><font color="red">Server���� PKCS7  �޽��� ���� �� ���� ����</font></h2>

<%
	String strUserKmCert	=	request.getParameter( "UserKmCert" ) == null ? "" : request.getParameter( "UserKmCert" );
	String strPKCS7Message	=	request.getParameter( "PKCS7Msg" ) == null ? "" : request.getParameter( "PKCS7Msg" );
	
	PKCS7Util p7util = new PKCS7Util();
	boolean bReturn = false;
	int nType = 1;
	String strOriginalMessage = "Hello World! �ȳ��ϼ���?";
	String strSeverPKCS7Message = null;

	if ( !strPKCS7Message.equals("") )
	{
	//	out.println( "Ŭ���̾�Ʈ���� ������ PKCS7 �޽��� : [" + strPKCS7Message + "]<br>" );

		nType = p7util.getPKCS7Type(strPKCS7Message.getBytes());
		out.println( "PKCS7 �޽��� Ÿ�� : [" + nType + "]<br>" );

		if ( nType == 1 ) {
			bReturn = p7util.verify( strPKCS7Message, null, null );
		}
		else {
			//bReturn = p7util.verify( strPKCS7Message, ServerKmKey, ServerKeyPassword );
			bReturn = p7util.verifyEncPass( strPKCS7Message, ServerKmKey, ServerKeyEncPassword );
		}

		if ( bReturn )
		{
			strOriginalMessage = new String( p7util.getRecvData() );
			out.println("������ : [" + strOriginalMessage + "]<br>" );

			if ( nType == 1 || nType == 3 )
			{
				// PKCS7 Signed �޽����� PKCS7 Signed and Enveloped �޽����� ���Ե� ������ ���
				Set certSet  = p7util.getCertificateSet();
				Iterator it = certSet.iterator();
				byte[] signcert = null;

				out.println("���ڼ��� ������ ���� : [" + certSet.size() + "]<br>" );
				while( it.hasNext() ) {
					X509Certificate cert = (X509Certificate)it.next();
					signcert = cert.getEncoded();				
					CertUtil cu = new CertUtil( signcert);

					out.println( "���ڼ��� �������� ������ �ĺ���Ī: [" + cu.getSubjectDN() + "]<br>" );
				}
			}
		}
		else
		{
			out.println("���� ����: " + p7util.getErrorMsg() + "<br>" );
		}

		if ( nType == 1 )
		{
			// PKCS7 Signed Message�� ���ڼ����� �߰��Ѵ�.
			try
			{
				//strSeverPKCS7Message = p7util.addSign( strPKCS7Message, ServerSignKey, ServerKeyPassword, ServerSignCert );
				strSeverPKCS7Message = p7util.addEncPassSign( strPKCS7Message, ServerSignKey, ServerKeyEncPassword, ServerSignCert );
			}
			catch( Exception e )
			{
				out.println("Error : [" + p7util.getErrorMsg() + "]");
				return;
			}
		}
	}
	else
	{
		if ( nType == 1 )
		{
			// PKCS7 Signed message�� �����Ѵ�.
			try
			{
				//strSeverPKCS7Message = p7util.genSignedData( ServerSignKey, ServerKeyPassword, ServerSignCert, strOriginalMessage.getBytes() );
				strSeverPKCS7Message = p7util.genEncPassSignedData( ServerSignKey, ServerKeyEncPassword, ServerSignCert, strOriginalMessage.getBytes() );
			}
			catch( Exception e )
			{
				out.println("���� ���� : [" + p7util.getErrorMsg() + "]");
				return;
			}
		}
	}
	if ( !strUserKmCert.equals("") )
	{
		if ( nType == 2 )
		{
			// PKCS7 Enveloped message�� �����Ѵ�.
			try
			{
				strSeverPKCS7Message = p7util.genEnvelopedData( strUserKmCert.getBytes(), strOriginalMessage.getBytes() );
			}
			catch( Exception e )
			{
				out.println("���� ���� : [" + p7util.getErrorMsg() + "]");
				return;
			}
		}
		else if ( nType == 3 )
		{
			// PKCS7 Signed and Enveloped message�� �����Ѵ�.
			try
			{
				//strSeverPKCS7Message = p7util.genSignedAndEnvelopedData(ServerSignKey, "a123456A", ServerSignCert, strUserKmCert.getBytes(), strOriginalMessage.getBytes() );
				//strSeverPKCS7Message = p7util.genEncPassSignedAndEnvelopedData( byte[] signPrivKey, String encpass, byte[] signCert, byte[] recipCert, byte[] data, boolean isSignAttr)
				strSeverPKCS7Message = p7util.genEncPassSignedAndEnvelopedData(ServerSignKey, ServerKeyEncPassword, ServerSignCert, strUserKmCert.getBytes(), strOriginalMessage.getBytes(), true );

			}
			catch( Exception e )
			{
				out.println("���� ���� : [" + p7util.getErrorMsg() + "]");
				return;
			}
		}
	}
	
%>


<form name="input_form">
<br><font color="blue">�������� ������ PKCS7 Message</font><br>
	<textarea name="PKCS7Msg" rows="7" cols="80"><%=strSeverPKCS7Message%></textarea><br>
<table>
	<tr><td>
		<input type="button" value="Ŭ���̾�Ʈ���� PKCS7 Message �˻��ϰ� ���� ���" onClick="verify_pkcs7()" >
	</td></tr>
	<tr><td>
		<input type="button" value="PKCS7 Signed Message�� ���ڼ��� �߰��ϱ�" onClick="pkcs7_multi_signed()" >
	</td></tr>
	<tr><td>
		<input type="button" value="����" onClick="do_submit()" >
	</td></tr>
	<input type="hidden" name="UserKmCert">
	<input type="hidden" name="ServerKmCert" value="<%=ServerKmCertPem%>"> 
</table>
</form>

<script language="javascript">

function pkcs7_multi_signed()
{
	var strCertIDForAddSign = "CertIDForAddSign";
	var strPKCS7Message = document.input_form.PKCS7Msg.value;

	if ( strPKCS7Message == "" || strPKCS7Message == null )
	{
		alert( "PKCS7 �޽����� �����ϴ�." );
		return;
	}

	var strType = getPKCS7TypeMsg( strPKCS7Message );
	if ( strType == "PKCS7SignedMessage" )
	{
		//	PKCS7 signed message�� ���ڼ��� �߰��ϱ�
		var strPKCS7MultiSignMessage = addPKCS7SignMsg( strCertIDForAddSign, strPKCS7Message );
		if ( strPKCS7MultiSignMessage == "" )
		{
			var strErr = getErrorString();
			if ( strErr == "" )	//	����ڰ� ������ ������ ����� ���
			{
			}
			else
			{
				alert( strErr );
			}
		}
		else
		{
			document.input_form.PKCS7Msg.value = strPKCS7MultiSignMessage;
		}
		clearCertificateInfo( strCertIDForAddSign );
	}
	else
	{
		alert( "PKCS7 Signed massage�� �ƴմϴ�." );
	}
}

function verify_pkcs7()
{
	var strCertID = "<%=strCertId%>";
	var strPKCS7Message = document.input_form.PKCS7Msg.value;

	if ( strPKCS7Message == "" || strPKCS7Message == null )
	{
		alert( "PKCS7 �޽����� �����ϴ�." );
		return;
	}

	var strType = getPKCS7TypeMsg( strPKCS7Message );

	if ( strType == "PKCS7SignedMessage" )
	{
		alert( strType );
		//	PKCS7 signed message �˻��ϰ� ���� ���
		var strOriginalMessage = verifyPKCS7SignedMsg( strPKCS7Message );
		if ( strOriginalMessage == "" )
		{
			alert( getErrorString() );
			return;
		}
		else
		{
			alert( "���� ������: " + strOriginalMessage );
			var count = getPKCS7SignerCount();
			alert( "count: " + count );
			var i = 1;
			for ( i = 1; i <= count; i++ )
			{
				var strSignCert = getPKCS7SignerCert(i)
				alert( i + " ��° ���ڼ��� ������: " + strSignCert );
				alert( i + " ��° ���ڼ��� �ð�: " + getPKCS7SigningTime(i) );
				alert( i + " ��° ���ڼ��� ������ ������ �ĺ���Ī: " + getCertSubjectDN( strSignCert ) );
				alert( i + " ��° ���ڼ��� ������ �Ϸù�ȣ: " + getCertSerialNumber( strSignCert ) );
			}
		}
		clearPKCS7MessageInfo();
	}
	else if ( strType == "PKCS7EnvelopedMessage" || strType == "PKCS7SignedAndEnvelopedMessage" )
	{
		alert( strType );
		var strOriginalMessage = verifyPKCS7EnvelopedMsg( strCertID, strPKCS7Message );
		if ( strOriginalMessage == "" )
		{
			var strErr = getErrorString();
			if ( strErr == "" )	//	����ڰ� ������ ������ ����� ���
			{
				return;
			}
			else
			{
				alert( strErr );
				return;
			}
		}
		else
		{
			alert( "���� ������: " + strOriginalMessage );
			var count = getPKCS7SignerCount();
			alert( "count: " + count );
			var i = 1;
			for ( i = 1; i <= count; i++ )
			{
				var strSignCert = getPKCS7SignerCert(i)
				alert( i + " ��° ���ڼ��� ������: " + strSignCert );
				alert( i + " ��° ���ڼ��� �ð�: " + getPKCS7SigningTime(i) );
				alert( i + " ��° ���ڼ��� ������ ������ �ĺ���Ī: " + getCertSubjectDN( strSignCert ) );
				alert( i + " ��° ���ڼ��� ������ �Ϸù�ȣ: " + getCertSerialNumber( strSignCert ) );
			}
		}
		clearPKCS7MessageInfo();
	}
	if ( strType == "" )
	{
		alert( getErrorString() );
		return;
	}

}

function do_submit()
{
	document.input_form.action = "./ServerPKCS7.jsp";
	document.input_form.method = "POST";
	document.input_form.submit();
}

</script>
<a href="Logout.jsp">�α׾ƿ�</a>
<br>
<a href="list.html">����Ʈ</a>
</body>
</html>

