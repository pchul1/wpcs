<!--
	Filename : ClientDigitalSignature.jsp
-->

<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
<title>Client-side Digital Signature Sample</title>
</head>

<body>

<%@ include file="signgate_common.jsp" %>

<script>
	var LogoutPageUrl = 'Logout.jsp';
</script>

<%
	String strUserLoginID = (String) session.getAttribute( "LOGINID" );
	String strUserCertSubjectDn = (String) session.getAttribute( "CERT_SUBJECT_DN" );
	String strUserSignCertSerialNumber = (String) session.getAttribute( "SIGN_CERT_SERIAL" );
	if ( strUserLoginID == null || strUserCertSubjectDn == null || strUserSignCertSerialNumber == null )
	{
		%><script>alert('�α����� �ʿ��մϴ�.'); location.href = LogoutPageUrl;</script><%
		return;
	}
	byte[] SessionKeyForServer = (byte[]) session.getAttribute( "SESSIONKEY" );
	if ( SessionKeyForServer == null )
	{
		%><script>alert('������ ��/��ȣȭ�� �ʿ��� ��ĪŰ�� �����ϴ�.'); location.href = LogoutPageUrl;</script><%
		return;
	}
%>

<h2><font color="red">Ŭ���̾�Ʈ���� ���ڼ��� ���� �� ���� ����</font></h2>

<form name="input_form">
<font color="blue">����� ID</font><br>
	<input type="text" name="LoginID" value="<%=strUserLoginID%>" ><br>
<br><font color="blue">�����޽���1</font><br>
	<input type="text" name="msg1" size="80" value="���ڼ����� �����͸� �Է��Ͻÿ�." ><br>
<br><font color="blue">�����޽���2</font><br>
	<textarea name="msg2" rows="5" cols="80" >���ڼ����� �ؾ� �� �Է� �ʵ尡 �� �̻��� ��쿡�� ������ �Է� �ʵ� ���� �̾ �ϳ��� ������ ��Ʈ������ ���� ������, �� ������ ��Ʈ���� ���� ���ڼ����� �����Ѵ�. ���ڼ��� ���� ���� �޽����� 1����Ʈ�� �޶����� �˻翡 �����ϱ� ������ ���ڼ��� �˻� �� �� ���� �޽����� �籸�� �� ��쿡 ���鹮�ڳ� �ٹٲ� ���� �ϳ��� �ٲ��� �ʵ��� �����Ͽ��� �Ѵ�.</textarea><br>
<br><font color="blue">(����ڰ� ������) ���ڼ��� ��</font><br>
	<textarea name="UserSignValue" rows="3" cols="80"></textarea><br>
<br><font color="blue">���ڼ��� �˻翡 �ʿ��� ������ (������� ���ڼ���� ������)</font><br>
	<textarea name="UserSignCert" rows="7" cols="80"></textarea><br>
<table>
	<tr><td>
		<input type="button" value="Ŭ���̾�Ʈ���� ���ڼ��� ����(�α��ο��� ����� �������� �״�� ���)" onClick="generate_sign()" >
	</td></tr>
	<tr><td>
		<input type="button" value="Ŭ���̾�Ʈ���� ���ڼ��� ����(����ڿ��� �ٽ� �������� �����ϵ��� ��)" onClick="generate_sign_ex()" >
	</td></tr>
	<tr><td>
		<input type="button" value="Ŭ���̾�Ʈ���� ���ڼ��� �˻�" onClick="verify_sign()" >
	</td></tr>
	<tr><td>
		<input type="button" value="�������� ������� ���ڼ��� �˻� �� ������ ���ڼ��� ����" onClick="do_submit()" >
	</td></tr>
</table>
</form>

<script language="javascript">

function generate_sign_ex()
{
	var strDomainName = "@ews.signgate.com"
	var strCertID = document.input_form.LoginID.value + strDomainName;
	// ����ڰ� �ٽ� �������� �����ϵ��� �ϱ� ���ؼ��� ����ڰ� �����Ͽ��� �������� �޸𸮿��� ����� �ʱ�ȭ�Ѵ�.
	clearCertificateInfo( strCertID );

	generate_sign();
}

function generate_sign()
{
	var strDomainName = "@ews.signgate.com"
	var strCertID = document.input_form.LoginID.value + strDomainName;
	var strOriginalMessage = document.input_form.msg1.value + document.input_form.msg2.value;

	if ( strOriginalMessage == "" || strOriginalMessage == null )
	{
		alert( "���ڼ����� ���� �޽����� �Է��Ͻʽÿ�." );
		return;
	}

	// �α��� �������� ����ڰ� ������ ������ ������ ������ �ʰ� �α��ο��� ����� CERT ID�� ����ϸ�
	// ����ڰ� �ٽ� �������� �������� �ʾƵ� �ȴ�.
	var strUserSignValue = generateDigitalSignature( strCertID, strOriginalMessage );
	if ( strUserSignValue == "" )
	{
		var strError = getErrorString();
		if ( strError == "" )
		{
			alert( "����ڰ� ������ ������ ����Ͽ����ϴ�." );
		}
		else
		{
			alert( strError );
		}
		clearCertificateInfo( strCertID );
		return;
	}
	else
	{
		document.input_form.UserSignValue.value = strUserSignValue;
	}

	var strUserSignCert = getUserSignCert( strCertID );
	if ( strUserSignCert == "" )
	{
		clearCertificateInfo( strCertID );
		alert( getErrorString() );
		return;
	}
	else
	{
		document.input_form.UserSignCert.value = strUserSignCert;
	}
}

function verify_sign()
{
	var strUserSignValue = document.input_form.UserSignValue.value;
	var strUserSignCert = document.input_form.UserSignCert.value;
	var strOriginalMessage = document.input_form.msg1.value + document.input_form.msg2.value;

	if ( strOriginalMessage == "" || strOriginalMessage == null )
	{
		alert( "���ڼ����� �˻��� ���� �޽����� �Է��Ͻʽÿ�." );
		return;
	}

	if ( strUserSignValue == "" || strUserSignValue == null )
	{
		alert( "���ڼ��� ���� �Է��Ͻʽÿ�." );
		return;
	}

	if ( strUserSignCert == "" || strUserSignCert == null )
	{
		alert( "���ڼ��� �˻翡 ����� �������� �Է��Ͻʽÿ�." );
		return;
	}

	// ����� PC���� ���ڼ��� �˻縦 �����Ѵ�.
	var bReturn = verifyDigitalSignature( strOriginalMessage, strUserSignValue, strUserSignCert );
	if ( bReturn )
	{
		alert( "���ڼ��� �˻翡 �����Ͽ����ϴ�." );
	}
	else
	{
		alert( getErrorString() );
	}
}

function do_submit()
{
	document.input_form.action = "./ServerDigitalSignature.jsp";
	document.input_form.method = "POST";
	document.input_form.submit();
}

</script>
<a href="Logout.jsp">�α׾ƿ�</a>
<br>
<a href="list.html">����Ʈ</a>
</body>
</html>

