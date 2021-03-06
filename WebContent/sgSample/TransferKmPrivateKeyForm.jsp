<!--
	Filename : TransferKmPrivateKeyForm.jsp
-->

<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head>
<title>전자입찰 Sample</title>
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

	String strUserSignCert = request.getParameter( "UserSignCert" ) == null ? "" : request.getParameter( "UserSignCert" );
	String strEncryptedSignValueForOriginalMessage = request.getParameter( "EncryptedSignValueForOriginalMessage" ) == null ? "" : request.getParameter( "EncryptedSignValueForOriginalMessage" );
	String strSignValueForEncryptedData = request.getParameter( "SignValueForEncryptedData" ) == null ? "" : request.getParameter( "SignValueForEncryptedData" );
	String strEncryptedSessionKeyForOpener = request.getParameter( "EncryptedSessionKeyForOpener" ) == null ? "" : request.getParameter( "EncryptedSessionKeyForOpener" );
	String strEncryptedData1 = request.getParameter( "msg1" ) == null ? "" : request.getParameter( "msg1" );
	String strEncryptedData2 = request.getParameter( "msg2" ) == null ? "" : request.getParameter( "msg2" );

	if ( strUserSignCert.equals("") ) 
	{
		%><script>alert( '전자서명용 인증서가 없습니다.' ); history.go(-1);</script><%
		return;
	}
	if ( strEncryptedSignValueForOriginalMessage.equals("") ) 
	{
		%><script>alert( '평문 데이터에 대한 전자서명이 없습니다.' ); history.go(-1);</script><%
		return;
	}
	if ( strSignValueForEncryptedData.equals("") ) 
	{
		%><script>alert( '암호문 데이터에 대한 전자서명이 없습니다.' ); history.go(-1);</script><%
		return;
	}
	if ( strEncryptedSessionKeyForOpener.equals("") ) 
	{
		%><script>alert( '대칭키가 없습니다.' ); history.go(-1);</script><%
		return;
	}
	if ( strEncryptedData1.equals("") ) 
	{
		%><script>alert( '암호문 데이터1 없습니다.' ); history.go(-1);</script><%
		return;
	}
	if ( strEncryptedData2.equals("") ) 
	{
		%><script>alert( '암호문 데이터2 없습니다.' ); history.go(-1);</script><%
		return;
	}

	//	암호화된 데이터가 송수신 과정에서 변경되지 않았음을 확인하기 위하여 암호화된 데이터에 대한 전자서명을 검사한다.
	//	전자서명용 인증서의 유효성 검사는 로그인 시점에 1번하는 것으로 충분하므로 생략한다.
	SignUtil sign = new SignUtil();
	String strEncryptedData = strEncryptedSessionKeyForOpener + strEncryptedData1 + strEncryptedData2 + strEncryptedSignValueForOriginalMessage;

	try
	{
		sign.verifyInit( strUserSignCert.getBytes() );
		sign.verifyUpdate( strEncryptedData.getBytes() );
		if ( sign.verifyFinal( Base64Util.decode( strSignValueForEncryptedData ) ))
		{
			// 암호화된 데이터의 무결성 검사에 성공한 경우
			// DB의 입찰 데이터 테이블에 개찰 담당관의 암호화용 인증서로 암호화된 대칭키와 이 대칭키로 암호된 데이터와 암호화되기 이전의 평문 데이터에 대한 전자서명(암호화된 전자서명)과 전자서명용 인증서의 소유자 식별명칭과 일련번호를 저장한다.
			// 이 예제 프로그램에서는 DB 대신 WAS 세션에 임시로 저장하여 사용한다.
			session.setAttribute( "SIGNVALUE", strEncryptedSignValueForOriginalMessage );
			session.setAttribute( "SIGNCERT", strUserSignCert );
			session.setAttribute( "DATA1", strEncryptedData1 );
			session.setAttribute( "DATA2", strEncryptedData2 );
			session.setAttribute( "NEWKEY", strEncryptedSessionKeyForOpener );
		}
		else
		{
			%><script>alert( '<%=sign.getErrorMsg()%>' ); history.go(-1);</script><%
			return;
		}
	}
	catch ( Exception e )
	{
		%><script>alert( '<%=sign.getErrorMsg()%>' ); history.go(-1);</script><%
		return;
	}

	// 여기서 부터는 개찰 프로그램에 대한 설명이다.
	// 개찰을 하기 위하여 개찰 담당관의 암호화용 개인키를 WAS 서버로 안전하게 전송하여야 한다.
	// 이를 위하여 WAS 서버에서 개찰 담당관의 암호화용 개인키의 새로운 비밀번호로 사용하기 위한
	// 일회용 비밀번호를 랜덤하게 생성한다.
	// 생성된 일회용 비밀번호는 암호화된 입찰 데이터를 복호화하는 프로그램에서 사용하기 위하여 WAS 세션에 저장한다.
	String strOneTimePassword = Base64Util.encode( RandomUtil.genRand() );
	session.setAttribute( "NEWPASSWORD", strOneTimePassword );

	
	// 일회용 비밀번호를 안전하게 사용자 PC에 내려주기 위하여 사용자 PC와 WAS 서버 사이에 공유한 대칭키로
	// 일회용 비밀번호를 암호화하여, <form>의 hidden 타입의 <input>에 저장한다.
	String strEncryptedOneTimePassword = "";
	CipherUtil cipher = new CipherUtil();
	try
	{
		cipher.encryptInitBySeed( SessionKeyForServer );
		byte[] encryptedOneTimePassword = cipher.encryptUpdate( strOneTimePassword.getBytes() );
		cipher.encryptFinal();
		if ( encryptedOneTimePassword == null )
		{
			%><script>alert('<%=cipher.getErrorMsg()%>');</script><%
			return;
		}
		strEncryptedOneTimePassword = Base64Util.encode( encryptedOneTimePassword );
	}
	catch(Exception e)
	{
		%><script>alert('<%=cipher.getErrorMsg()%>');</script><%
		return;
	}

%>

<h2><font color="red">개찰 예제</font></h2>
입찰(개찰)담당자의 암호화용 개인키를 서버에 안전하게 전송하기 위하여, 입찰(개찰)담당자의 암호화용 개인키의 비밀번호를 서버에서 생성한 1회용 비밀번호로 변경하여 서버에 전송한다.<br>
1회용 비밀번호는 웹브라우저와 WAS 서버와 공유한 대칭키를 사용하여 암호화하여 보호한다.<br>

<form name="input_form">
<font color="blue">사용자 ID</font><br>
	<input type="text" name="LoginID" value="<%=strUserLoginID%>" ><br>
<br><font color="blue">암호화된 일회용 비밀번호<font><br>
	<input type="text" name="EncryptedOneTimePassword" size="80" value="<%=strEncryptedOneTimePassword%>" ><br>
</form>

<form name="submit_form">
<br><font color="blue">암호화용 개인키<font><br>
	<textarea name="OpenerKmKey" rows="5" cols="80" ></textarea><br>
<br><font color="blue">암호화용 인증서<font><br>
	<textarea name="OpenerKmCert" rows="5" cols="80" ></textarea><br>
<table>
	<tr><td>
		<input type="button" value="암호화용 개인키 얻기" onClick="get_kmkey()" >
	</td></tr>
	<tr><td>
		<input type="button" value="전송" onClick="do_submit()" >
	</td></tr>
</table>
</form>

<script language="javascript">

function get_kmkey()
{
	var strDomainName = "@ews.signgate.com"
	var strUserID = document.input_form.LoginID.value + strDomainName;
	var strKeyIDForServer = strUserID;
	var strUserIDForKmKey = "KmKeyFor" + strUserID;
	var strEncryptedOneTimePassword = document.input_form.EncryptedOneTimePassword.value;

	if ( strEncryptedOneTimePassword == "" )
	{
		alert( "암호화된 일회용 비밀번호가 없습니다." );
		return;
	}

	// 사용자(개찰 담당관) PC와 WAS 서버 사이에 공유한 대칭키로 암호화된 비밀번호를 복호화한다.
	var strOneTimePassword = decryptDataString( strKeyIDForServer, strEncryptedOneTimePassword );
	if ( strOneTimePassword == "" )
	{
		var strError = getErrorString();
		{
			alert( strError );
			alert( "일회용 비밀번호 복호화에 실패하였습니다." );
		}
		return;
	}

	// 사용자(개찰 담당관)의 암호화용 개인키를 복호화하여 얻은 일회용 비밀번호로 비밀번호를 변경하여 얻는다.
	// 개찰에 필요한 암호화용 개인키가 현재 사용하는 암호화용 개인키와 다를 경우가 있으므로,
	// 사용자가 인증서 선택창에서 선택하도록 하기 위하여 로그인할 때 사용한 CERT ID와는 다른 CERT ID를 사용한다.
	clearCertificateInfo( strUserIDForKmKey );
	var strOpenerKmKey = getUserKMKeyWithNewPassword( strUserIDForKmKey, strOneTimePassword );
	if ( strOpenerKmKey == "" )
	{
		var strErr = getErrorString();
		if ( strErr == "" )
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
		// 사용자의 암호화용 개인키는 일회용 비밀번호로 보호되기 때문에 이 예제프로그램에서는 암호화용 개인키를
		// WAS 서버와 공유한 대칭키로 암호화하여 전송하지는 않는다.
		// 더 높은 보안 수준을 위하여 암호화용 개인키를 WAS 서버와 공유한 대칭키를 가지고 암호화하여 전송할 수도 있다.
		document.submit_form.OpenerKmKey.value = strOpenerKmKey;
	}

	// 개찰에 필요한 개인키가 해당 입찰 건에 대한 입찰 공고 테이블에 저장된 인증서와 맞는지를 확인하기 위하여
	// 선택한 암호화용 인증서를 함께 WAS 서버에 전송한다.
	var strOpenerKmCert = getUserKMCert( strUserIDForKmKey );
	if ( strOpenerKmCert == "" )
	{
		clearCertificateInfo( strUserIDForKmKey );
		alert( getErrorString() );
		return;
	}
	else
	{
		document.submit_form.OpenerKmCert.value = strOpenerKmCert;
	}

	// 개찰에 사용할 암호화용 개인키를 얻기 위하여 선택한 인증서 정보를 사용자 PC의 메모리에서 지우고 초기화한다.
	clearCertificateInfo( strUserIDForKmKey );

}

function do_submit()
{
	document.submit_form.action = "./DecryptionWithNewSessoinKey.jsp";
	document.submit_form.method = "POST";
	document.submit_form.submit();
}

</script>
<a href="Logout.jsp">로그아웃</a>
<br>
<a href="list.html">리스트</a>
</body>
</html>

