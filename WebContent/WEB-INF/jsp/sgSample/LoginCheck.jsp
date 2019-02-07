<!--
	Filename : LoginCheck.jsp
-->

<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
<title>����� ��� ������ �Ǵ� �α��� ������ �˻� ������ ����</title>
</head>

<body>

<%@ include file="signgate_common.jsp" %>

<script>
	var LogoutPageUrl = 'Logout.jsp';
</script>

<%
	// �α��� �������� ����� ���� �����Ͱ� �Ź� ������ ��쿡,
	// �ѹ� ����ߴ� ����� ���� �����͸� �����ڰ� �ٽ� ����� ���� �ִ�.
	// �̸� ���� ���ؼ� �Ź� ���ϴ� �����͸� ����� ���� �����Ϳ� ���Խ�ų �ʿ䰡 �ִ�.
	// �̸� ���ؼ� �α��� form ���������� �����Ͽ� WAS ���ǿ� ������ nonce ���� �����ϴ��� Ȯ���Ѵ�.
	// �� ���� ����ڰ� ������ ���ڼ����� �˻��� �� ���ȴ�.
	if ( session.getAttribute("CHALLENGE") == null ) 
	{
		%><script>location.href=LogoutPageUrl;</script><%
		return;
	}
	
	String strChallenge	= (String) session.getAttribute( "CHALLENGE" );

	String strUserLoginID	=	request.getParameter( "LoginID" ) == null ? "" : new String( request.getParameter( "LoginID" ).getBytes( "8859_1" ), "KSC5601" );
	String strUserSignCert	=	request.getParameter( "UserSignCert" ) == null ? 
							"" : request.getParameter( "UserSignCert" );
	String strUserSignValue	=	request.getParameter( "UserSignValue" ) == null ? 
							"" : request.getParameter( "UserSignValue" );
	String strEncryptedSessionKeyForServer	=	request.getParameter( "EncryptedSessionKeyForServer" ) == null ? 
							"" : request.getParameter( "EncryptedSessionKeyForServer" );
	String strEncryptedUserSSN		=	request.getParameter( "EncryptedUserSSN" ) == null ? 
							"" : request.getParameter( "EncryptedUserSSN" );
	String strEncryptedLoginPassword	=	request.getParameter( "EncryptedLoginPassword" ) == null ? 
							"" : request.getParameter( "EncryptedLoginPassword" );
	String strEncryptedUserRandomNumber	=	request.getParameter( "EncryptedUserRandomNumber" ) == null ? 
							"" : request.getParameter( "EncryptedUserRandomNumber" );

%>
<center>
<br><br>
�� �������� ����� ���� ��� ������ �Ǵ� �α��� ������ �˻� ���������� ���� �� �ִ� ���� �ڵ带 �����ִ� ������ �Դϴ�.
<br><br>
</center>
<%
	// ����� ���� �Ǵ� �α��ο� ���Ǵ� ����� ���� �����͸� �˻��ϴ� ���߿�
	// ������ �߻��ϴ� ��쿡 ���ؼ��� �� ��쿡 ������ ó���� �����ϵ��� �Ѵ�.
	// ���� ��� ������� ���ڼ���� �������� ��ȿ���� ���� ��쿡��
	// �������� ��ȿ���� �ʴٴ� �����޽����� ����ڿ��� �����ְ� ��ȿ�� �������� ����Ͽ� �ٽ� �õ��ϵ��� �Ͽ��߸� �Ѵ�.
	if ( strUserLoginID.equals("") )
	{
		%><script>alert( 'ID�� �����ϴ�.' ); location.href = LogoutPageUrl;</script><%
		return;
	}

	// �α��� ���������� ����� ���� �����͸� �˻��ϴٰ� ������ ��쿡 LogOut.jsp ����������
	// ����ڰ� ������ ������ ������ �޸𸮿��� ����µ� ����ϱ� ���Ͽ� ���ǿ� �����Ѵ�.
	session.setAttribute( "TEMPID", strUserLoginID );

	if ( strUserSignCert.equals("") )
	{
		%><script>alert( '�������� �����ϴ�.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strUserSignValue.equals("") )
	{
		%><script>alert( '���ڼ����� �����ϴ�.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strEncryptedSessionKeyForServer.equals("") )
	{
		%><script>alert( '��ĪŰ�� �����ϴ�.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strEncryptedUserSSN.equals("") )
	{
		%><script>alert( '�ֹε�Ϲ�ȣ�� �����ϴ�.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strEncryptedLoginPassword.equals("") )
	{
		%><script>alert( '��й�ȣ�� �����ϴ�.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strEncryptedUserRandomNumber.equals("") )
	{
		%><script>alert( '�ſ�Ȯ�������� �����ϴ�.' ); location.href = LogoutPageUrl;</script><%
		return;
	}

	// ��û �޽������� ���۵� form data�� ���������� ���۵Ǿ����� Ȯ���ϱ� ���� �������� �����ش�.
	out.println( "replay attack ������ ���� ç���� ��: [" + strChallenge + "]<br>" );
	out.println( "����� ID: [" + strUserLoginID + "]<br>" );
//	out.println( "������� ���ڼ���� ������: [" + strUserSignCert + "]<br>" );
	out.println( "���ڼ��� ��: [" + strUserSignValue + "]<br>" );
	out.println( "��ȣȭ�� �ֹε�Ϲ�ȣ: [" + strEncryptedUserSSN + "]<br>" );
	out.println( "��ȣȭ�� �α��� ��й�ȣ: [" + strEncryptedLoginPassword + "]<br>" );
	out.println( "����Ȯ�ο� ����: [" + strEncryptedUserRandomNumber + "]<br>" );

	// ����� PC���� SEED �˰������� ��ȣȭ�� �����͸� ��ȣȭ�ϱ� ���ؼ�
	// ��ȣȭ�� ���Ǿ��� ��ĪŰ(���Ű �Ǵ� ����Ű��� ��)�� �ʿ��ϴ�.
	// �� ��ĪŰ�� �����ϰ� ���޵ǵ��� WAS ������ ��ȣȭ�� ������(�����ϰԴ� �������� ���ԵǾ� �ִ� ����Ű)�� ����Ͽ�
	// RSA �˰������� ��ȣȭ�Ǿ� �����Ƿ� WAS ������ ��ȣȭ�� ����Ű�� ��ȣȭ���Ѵ�.
	CipherUtil cipher = new CipherUtil();
	byte[] UserRandomNumber = null;
	byte[] LoginPassword = null;
	byte[] UserSSN = null;
	byte[] SessionKeyForServer = null;

	try
	{
		//SessionKeyForServer = cipher.decryptRSA( ServerKmKey, ServerKeyPassword, strEncryptedSessionKeyForServer );
		SessionKeyForServer = CipherUtil.decryptEncPassRSA( ServerKmKey, ServerKeyEncPassword, strEncryptedSessionKeyForServer );
		
		if ( SessionKeyForServer == null )
		{
			%><script>alert('��ĪŰ ��ȣȭ�� �����Ͽ����ϴ�'); //location.href = LogoutPageUrl;</script><%
			return;
		}
	}
	catch(Exception e)
	{
		%><script>alert('<%=e.toString()%>'); location.href = LogoutPageUrl;</script><%
		return;
	}

	// WAS ������ ��ȣȭ�� ����Ű�� ��ȣȭ�� ��ĪŰ�� ����Ͽ� SEED �˰������� ��ȣȭ�� �����͸� ��ȣȭ�Ѵ�.
	try
	{
		cipher.decryptInit( SessionKeyForServer );
		UserRandomNumber	= cipher.decryptUpdate( Base64Util.decode( strEncryptedUserRandomNumber ));
		LoginPassword	= cipher.decryptUpdate( Base64Util.decode( strEncryptedLoginPassword ));
		UserSSN 		= cipher.decryptUpdate( Base64Util.decode( strEncryptedUserSSN ));
		cipher.decryptFinal();
		
		if ( UserRandomNumber == null || LoginPassword == null || UserSSN == null )
		{
			%><script>alert('<%=cipher.getErrorMsg()%>'); location.href = LogoutPageUrl;</script><%
			return;
		}
	}
	catch(Exception e)
	{
		%><script>alert('<%=cipher.getErrorMsg()%>'); location.href = LogoutPageUrl;</script><%
		return;
	}

	String strUserRandomNumber = new String( UserRandomNumber );
	String strUserSSN 		= new String( UserSSN );
	String strLoginPassword 	= new String( LoginPassword );

	out.println( "�ֹε�Ϲ�ȣ: [" + strUserSSN + "]<br>" );
	out.println( "�α��� ��й�ȣ: [" + strLoginPassword + "]<br>" );

	// ��ĪŰ�� ��ȣȭ�Ͽ� ���� ����� ���� ������ �Ǵ� ����� ���� �����Ͱ� ��.������ ���� ���� �״������ Ȯ���ϰ�
	// �����͸� �Է��� ��ü�� �������� ���������� Ȯ���ϱ� ���Ͽ� ���ڼ��� �˻縦 �Ѵ�.
	// ���Ἲ(message integrity) �˻�, �߽��� ����(sender authentication), �۽� ���κ���(non-repudiation)
	// ���ڼ����� �˻��ϱ� ���ؼ��� ���ڼ��� ������ �� ����� �״���� �����Ͱ� �ʿ��ϴ�.
	SignUtil sign = new SignUtil();
	String strOriginalMessage = strChallenge + strLoginPassword + strUserSSN + strUserLoginID;

	out.println( "���ڼ��� ���� ������: [" + strOriginalMessage + "]<br>" );

	// ���� ������ �˻��ϱ� ���ؼ��� ������� ���ڼ���� ������(�����ϰԴ� ���ڼ���� �������� ���Ե� ���ڼ��� ����Ű)�� ����Ͽ�
	// ���� �����Ϳ� ���� ���ڼ��� �˻縦 �����Ѵ�.
	try
	{	
		

		sign.verifyInit( strUserSignCert.getBytes() );   //������
		sign.verifyUpdate( strOriginalMessage.getBytes() ); // ����
		
		if ( !sign.verifyFinal( Base64Util.decode( strUserSignValue ) ))  //���ΰ�
		{
			%><script>alert('<%=sign.getErrorMsg()%>'); location.href = LogoutPageUrl;</script><%
			return;
		}
	}
	catch (Exception e) 
	{
		%><script>alert('<%=sign.getErrorMsg()%>'); location.href = LogoutPageUrl;</script><%
		return;
	}
	out.println( "���ڼ��� �˻� ����<br>" );

	// ������� ���ڼ���� ���������� ���� ������ ���Ѵ�.
	CertUtil cert = null;
	String strSubjectDn = null;
	String strIssuerDn = null;
	String strSerialNumber = null;
	String strNotBefore = null;
	String strNotAfter = null;
	int nRemainDays = 0;
	String strPolicyOid = null;
	try
	{
		cert = new CertUtil( strUserSignCert.getBytes() );

		strSubjectDn = cert.getSubjectDN();
		strIssuerDn = cert.getIssuerDN();
		strSerialNumber = cert.getSerialNumber();
		strNotBefore = cert.getNotBefore();
		strNotAfter = cert.getNotAfter();
		nRemainDays = cert.getRemainDay();
		strPolicyOid = cert.getPolicyOid();

		out.println( "������� ���ڼ���� �������� ������ �ĺ���Ī: [" + strSubjectDn + "]<br>" );
		out.println( "������� ���ڼ���� �������� �߱��� �ĺ���Ī: [" + strIssuerDn + "]<br>" );
		out.println( "������� ���ڼ���� �������� �Ϸù�ȣ: [" + strSerialNumber + "]<br>" );
		out.println( "������� ���ڼ���� �������� ��ȿ�Ⱓ ����: [" + strNotBefore + "]<br>" );
		out.println( "������� ���ڼ���� �������� ��ȿ�Ⱓ ����: [" + strNotAfter + "]<br>" );
		out.println( "������� ���ڼ���� �������� ��ȿ�Ⱓ�� �����ִ� �� ��: [" + nRemainDays + "]<br>" );
		out.println( "������� ���ڼ���� �������� ��å OID: [" + strPolicyOid + "]<br>" );
	}
	catch (Exception e) 
	{
		%><script>alert('�ùٸ� �������� �ƴմϴ�.'); location.href = LogoutPageUrl;</script><%
		return;
	}

	// ������� �������� ���񽺿� ����� �� �ִ� ����� ���������� �˻��Ѵ�.
	// ��) Ư�� ������ �������� �Ϲ����� ���񽺿� ����� �� ����. ���ο� ���񽺸� �̿��ϱ� ���ؼ� ���ο� �������� ����� ���� ����.
	// �Ǽ��� ����� ������ ��å���� ���� 2010.10.25 append
	if ( !cert.isValidPolicyOid( AllowedPolicyOIDs ) )
	{
		%><script>alert('������ �ʴ� ��å�� �������Դϴ�'); location.href = LogoutPageUrl;</script><%
		return;
	}
	out.println( "������ ��å �˻� ����<br>" );

	// �ֹε�Ϲ�ȣ/����ڵ�Ϲ�ȣ�� �̿��Ͽ� ������ �����ڸ� Ȯ���ϴ� �˻縦 �Ѵ�.
	// ����� ��� ��������� ����ڰ� �Է��� �ֹε�Ϲ�ȣ/����ڵ�Ϲ�ȣ�� ����ϰ�,
	// �α��� ���������, DB�� ����� ������� �ֹε�Ϲ�ȣ/����ڵ�Ϲ�ȣ�� ����Ѵ�.
	if ( !cert.isValidUser( strUserSSN, strUserRandomNumber) )
	{
		%><script>alert('����� ����Ȯ�� �˻翡 �����Ͽ����ϴ�'); location.href = LogoutPageUrl;</script><%
		return;
	}
	out.println( "����� ����Ȯ�� �˻� ����<br>" );

	// ����ڰ� ���ڼ��� ����� �������� ���� ��ȿ�� ���������� ���θ� Ȯ���Ѵ�.
	
	OCSPUtil ocsputil = null;


	try 
	{	

		// �Ǽ��� ����� ��� ���� �ʼ� 2010.10.25 append ������
		String OCSPServerSignCertFile = "D:/SecuKit/cert/ocsp/signCert.der";
		String OCSPServerSignKeyFile ="D:/SecuKit/cert/ocsp/signPri.key";
		String signcerpem = CertUtil.derToPem(FileUtil.readBytesFromFileName(OCSPServerSignCertFile));
		String signpripem = KeyUtil.derToPem(FileUtil.readBytesFromFileName(OCSPServerSignKeyFile));
		
		ocsputil = new OCSPUtil();

		//============================ �׽�Ʈ ��츸 ���� ��� �ּ� ó�� ~~~~~~~~~~~~~~~~~~~~~~~~~~~//
		ocsputil.setTestOcsp(true, "http://ftca.signgate.com:4505"); //(�ּ�ó�� �ϸ� �ڵ����� ���� OCSP������ ����)
		
		ocsputil.setKicaGatewayOcspServer(true);
		//if(ocsputil.isValid(cert, CRLCacheDirectory)){ 
		/*
		1.cert = "����� ������"
		2.signpripem = "OCSP���������� signPri.key"
		3.signcerpem = "OCSP���������� signCert.der"
		4.OCSPServerKeyPassword = "���������� ��й�ȣ"
		5.CRLCacheDirectory = "crl���丮"
		*/

		//ocsp ������ �н����� 2010.10.25 append ������ 
		String OCSPServerKeyPassword = "qwer1234";
	

		out.println("CRLCacheDirectory : "+CRLCacheDirectory);
		if(ocsputil.isValid(cert, signpripem, OCSPServerKeyPassword, signcerpem, CRLCacheDirectory, false)){
			out.println("OCSP ��ȿ�� ���� ����");
		}
		else{
			%><script>alert('OCSP ��ȿ�� �˻� ���� : ' + '<%=ocsputil.getErrorMsg()%>');
				location.href = 'LogoutOcsp.jsp';</script><%
				return;
		}		
	} 
	catch (Exception e)
	 {
	 	%><script>alert('������ ��ȿ�� �˻� ���� : ' + '<%=ocsputil.getErrorMsg()%>');
				location.href = 'LogoutOcsp.jsp';</script><%
		return;
	}
	out.println( "������ ��ȿ�� ���� ����<br>" );

	// ������� ���������� ����Ǹ� �� ������ ���ø����̼ǿ��� �ʿ��� ������ �����ϸ� �ȴ�.

	// ���� ������� ���ڼ����� DB�� �����Ͽ��ٰ� ���� ������� �������� ������ ���ڼ��� �˻縦 �� �ʿ䰡 �ִ�
	// ���񽺶�� DB�� ������ ���̺� ������� ������ ������ �ĺ���Ī�� �Ϸù�ȣ�� Primary Key���Ͽ�
	// �������� �����Ͽ��� �Ѵ�.

	// ����, ���񽺸� �̿��ϱ� ���Ͽ� ������� �������� �ý��ۿ� ����Ͽ��� �ϰ�,
	// ��ϵ� ���������� ����Ͽ� �ý��ۿ� �α����� �����ؾ� �ϴ� �����
	// DB�� ����� ���� ���̺� ������� ������ ������ �ĺ���Ī�� �Ϸù�ȣ�� �����ϰų�
	// �̹� ����Ǿ� �ִ� ���� ���ϴ� ������ ���� ����� ��� �������� �α��� �˻� ���������� �ʿ��ϴ�.

	// ���� ���α׷������� ������� �α��� ID�� ���ǿ� ���������ν� �α��� ���¸� üũ�Ѵ�.
	// �α��ο��� ����� ���� �����ͷ� ���Ǵ� nonce ���� �� �̻� �ʿ䰡 �����Ƿ� WAS ���ǿ��� �����.
	session.removeAttribute( "TEMPID" );
	session.removeAttribute( "CHALLENGE" );
	session.setAttribute( "LOGINID", strUserLoginID );

	// ���� ���������� ����� PC�� WAS ���� ���̿� �����͸� SEED �˰������� ��ȣȭ�Ͽ� �ְ� ���� ��
	// ����ϱ� ���Ͽ� WAS ���ǿ� �����Ѵ�.
	session.setAttribute( "SESSIONKEY", SessionKeyForServer );

	// �α��� ���Ŀ� ���ڼ��� �˻翡 ����� �������� �α����� �� ����� �������� ������ Ȯ���ϰų�
	// DB�� ������ ���̺��� �������� ��ȸ�� �� ����� �� �ֵ���
	// ������� ������ ������ �ĺ���Ī�� ���ڼ���� �������� �Ϸù�ȣ�� WAS ���ǿ� �����Ѵ�.
	session.setAttribute( "CERT_SUBJECT_DN", strSubjectDn );
	session.setAttribute( "SIGN_CERT_SERIAL", strSerialNumber );
%>

<br><br>
<%=session.getAttribute( "LOGINID" )%>���� �α����Ͽ����ϴ�.
<br><br>
<a href="Logout.jsp">�α׾ƿ�</a>
<br>
<a href="list.html">����Ʈ</a>
</body>
</html>

