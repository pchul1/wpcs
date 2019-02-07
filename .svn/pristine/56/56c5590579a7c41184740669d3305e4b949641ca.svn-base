<!--
	Filename : ClientDigitalSignature.jsp
-->

<%@ page contentType="text/html; charset=utf-8" %>

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
		%><script>alert('로그인이 필요합니다.'); location.href = LogoutPageUrl;</script><%
		return;
	}
	byte[] SessionKeyForServer = (byte[]) session.getAttribute( "SESSIONKEY" );
	if ( SessionKeyForServer == null )
	{
		%><script>alert('데이터 암/복호화에 필요한 대칭키가 없습니다.'); location.href = LogoutPageUrl;</script><%
		return;
	}
%>

<h2><font color="red">클라이언트에서 전자서명 생성 및 검증 예제</font></h2>

<form name="input_form">
<font color="blue">사용자 ID</font><br>
	<input type="text" name="LoginID" value="<%=strUserLoginID%>" ><br>
<br><font color="blue">원문메시지1</font><br>
	<input type="text" name="msg1" size="80" value="전자서명할 데이터를 입력하시오." ><br>
<br><font color="blue">원문메시지2</font><br>
	<textarea name="msg2" rows="5" cols="80" >전자서명을 해야 할 입력 필드가 둘 이상인 경우에는 각각의 입력 필드 값을 이어서 하나의 데이터 스트링으로 만든 다음에, 이 데이터 스트링에 대한 전자서명을 생성한다. 전자서명 값은 원문 메시지가 1바이트라도 달라지면 검사에 실패하기 때문에 전자서명 검사 할 때 원문 메시지를 재구성 할 경우에 공백문자나 줄바꿈 문자 하나라도 바뀌지 않도록 주의하여야 한다.</textarea><br>
<br><font color="blue">(사용자가 생성한) 전자서명 값</font><br>
	<textarea name="UserSignValue" rows="3" cols="80"></textarea><br>
<br><font color="blue">전자서명 검사에 필요한 인증서 (사용자의 전자서명용 인증서)</font><br>
	<textarea name="UserSignCert" rows="7" cols="80"></textarea><br>
<table>
	<tr><td>
		<input type="button" value="클라이언트에서 전자서명 생성(로그인에서 사용한 인증서를 그대로 사용)" onClick="generate_sign()" >
	</td></tr>
	<tr><td>
		<input type="button" value="클라이언트에서 전자서명 생성(사용자에게 다시 인증서를 선택하도록 함)" onClick="generate_sign_ex()" >
	</td></tr>
	<tr><td>
		<input type="button" value="클라이언트에서 전자서명 검사" onClick="verify_sign()" >
	</td></tr>
	<tr><td>
		<input type="button" value="서버에서 사용자의 전자서명 검사 및 서버의 전자서명 생성" onClick="do_submit()" >
	</td></tr>
</table>
</form>

<script language="javascript">

function generate_sign_ex()
{
	var strDomainName = "@ews.signgate.com"
	var strCertID = document.input_form.LoginID.value + strDomainName;
	// 사용자가 다시 인증서를 선택하도록 하기 위해서는 사용자가 선택하였던 인증서를 메모리에서 지우고 초기화한다.
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
		alert( "전자서명할 원문 메시지를 입력하십시오." );
		return;
	}

	// 로그인 과정에서 사용자가 선택한 인증서 정보를 지우지 않고 로그인에서 사용한 CERT ID를 사용하면
	// 사용자가 다시 인증서를 선택하지 않아도 된다.
	var strUserSignValue = generateDigitalSignature( strCertID, strOriginalMessage );
	if ( strUserSignValue == "" )
	{
		var strError = getErrorString();
		if ( strError == "" )
		{
			alert( "사용자가 인증서 선택을 취소하였습니다." );
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
		alert( "전자서명을 검사할 원문 메시지를 입력하십시오." );
		return;
	}

	if ( strUserSignValue == "" || strUserSignValue == null )
	{
		alert( "전자서명 값을 입력하십시오." );
		return;
	}

	if ( strUserSignCert == "" || strUserSignCert == null )
	{
		alert( "전자서명 검사에 사용할 인증서를 입력하십시오." );
		return;
	}

	// 사용자 PC에서 전자서명 검사를 수행한다.
	var bReturn = verifyDigitalSignature( strOriginalMessage, strUserSignValue, strUserSignCert );
	if ( bReturn )
	{
		alert( "전자서명 검사에 성공하였습니다." );
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
<a href="Logout.jsp">로그아웃</a>
<br>
<a href="list.html">리스트</a>
</body>
</html>

