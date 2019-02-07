<!--
	Filename : ClientPKCS7.jsp
-->

<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
<title>Client-side PKCS7 Sample</title>
</head>

<body>

<%@ include file="signgate_common.jsp" %>

<script>
	var LogoutPageUrl = 'Logout.jsp';
</script>

<%
	// 사용자가 선택한 인증서를 KICA SecuKit JavaScript API에서 추적하는데 사용할 값을 임의로 생성한다.
	session.removeAttribute( "certId" );
	String strCertId = Base64Util.encode( RandomUtil.genRand() );
	session.setAttribute( "certId", strCertId );	
%>

<h2><font color="red">클라이언트에서 PKCS7  메시지 생성 및 검증 예제</font></h2>

<form name="input_form">
<font color="blue">사용자 ID</font><br>
	<input type="text" name="LoginID" value="" ><br>
<br><font color="blue">원문메시지1</font><br>
	<textarea name="msg1" rows="5" cols="80" >PKCS7 메시지 예제</textarea><br>
<br><font color="blue">PKCS7 Message</font><br>
	<textarea name="PKCS7Msg" rows="7" cols="80"></textarea><br>
<table>
	<tr><td>
		<input type="button" value="PKCS7 Signed Message" onClick="pkcs7_signed()" >
	</td></tr>
	<tr><td>
		<input type="button" value="PKCS7 Signed Message에 전자서명 추가하기" onClick="pkcs7_multi_signed()" >
	</td></tr>
	<tr><td>
		<input type="button" value="PKCS7 Enveloped Message" onClick="pkcs7_enveloped()" >
	</td></tr>
	<tr><td>
		<input type="button" value="PKCS7 Signed And Enveloped Message" onClick="pkcs7_signed_enveloped()" >
	</td></tr>
	<tr><td>
		<input type="button" value="클라이언트에서 PKCS7 Message 검사하고 원문 얻기" onClick="verify_pkcs7()" >
	</td></tr>
	<tr><td>
		<input type="button" value="전송" onClick="do_submit()" >
	</td></tr>
	<input type="hidden" name="UserKmCert">
	<input type="hidden" name="ServerKmCert" value="<%=ServerKmCertPem%>"> 
</table>
</form>

<script language="javascript">
var strCertID = "<%=strCertId%>";
function pkcs7_signed()
{
	var strOriginalMessage = document.input_form.msg1.value;

	if ( strOriginalMessage == "" || strOriginalMessage == null )
	{
		alert( "메시지를 입력하십시오." );
		return;
	}

	// 로그인 과정에서 사용자가 선택한 인증서 정보를 지우지 않고 로그인에서 사용한 CERT ID를 사용하면
	// 사용자가 다시 인증서를 선택하지 않아도 된다.
	clearCertificateInfo( strCertID );
	var strPKCS7Message = generatePKCS7SignedMsg( strCertID, strOriginalMessage );
	if ( strPKCS7Message == "" )
	{
		var strErr = getErrorString();
		if ( strErr == "" )	//	사용자가 인증서 선택을 취소한 경우
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
		document.input_form.PKCS7Msg.value = strPKCS7Message;
	}
}

function pkcs7_multi_signed()
{
	var strCertIDForAddSign = "CertIDForAddSign";
	var strPKCS7Message = document.input_form.PKCS7Msg.value;

	if ( strPKCS7Message == "" || strPKCS7Message == null )
	{
		alert( "PKCS7 메시지가 없습니다." );
		return;
	}

	var strType = getPKCS7TypeMsg( strPKCS7Message );
	if ( strType == "PKCS7SignedMessage" )
	{
		//PKCS7 signed message에 전자서명 추가하기
		var strPKCS7MultiSignMessage = addPKCS7SignMsg( strCertIDForAddSign, strPKCS7Message );
		if ( strPKCS7MultiSignMessage == "" )
		{
			var strErr = getErrorString();
			if ( strErr == "" )	//	사용자가 인증서 선택을 취소한 경우
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
		alert( "PKCS7 Signed massage가 아닙니다." );
	}
}

function pkcs7_enveloped()
{
	var strOriginalMessage = document.input_form.msg1.value;
	var strServerKmCert = document.input_form.ServerKmCert.value;

	if ( strServerKmCert == "" || strServerKmCert == null )
	{
		alert( "서버의 암호화용 인증서가 없습니다." );
		return;
	}

	if ( strOriginalMessage == "" || strOriginalMessage == null )
	{
		alert( "메시지를 입력하십시오." );
		return;
	}

	var strUserKmCert = getUserKMCert( strCertID );

	// 사용자와 WAS 서버 둘다 열어볼 수 있는 PKCS7 Enveloped 메시지를 만든다.
	// 사용자의 암호화용 인증서는 없어도 PKCS7 Enveloped 메시지를 만들 수 있다.
	var strPKCS7Message = generatePKCS7EnvelopedMsg( strOriginalMessage, "", strServerKmCert )
	if ( strPKCS7Message == "" )
	{
		alert( getErrorString() );
		return;
	}
	else
	{
		document.input_form.PKCS7Msg.value = strPKCS7Message;
	}

	// 서버에서 사용자의 암호화용 인증서로 PKCS7 Enveloped Message를 만들때 사용하기 위하여 함께 전송한다.
	document.input_form.UserKmCert.value = strUserKmCert;
}

function pkcs7_signed_enveloped()
{
	var strOriginalMessage = document.input_form.msg1.value;
	var strServerKmCert = document.input_form.ServerKmCert.value;

	if ( strServerKmCert == "" || strServerKmCert == null )
	{
		alert( "서버의 암호화용 인증서가 없습니다." );
		return;
	}

	if ( strOriginalMessage == "" || strOriginalMessage == null )
	{
		alert( "메시지를 입력하십시오." );
		return;
	}

	var strUserKmCert = getUserKMCert( strCertID );

	// 사용자와 WAS 서버 둘다 풀어볼 수 있는 PKCS7 Signed and Enveloped 메시지를 만든다.
	// 사용자의 암호화용 인증서는 없어도 PKCS7 Signed and Enveloped 메시지를 만들 수 있다.
	var strPKCS7Message = generatePKCS7SignedEnvelopedMsg( strCertID, strOriginalMessage, "", strServerKmCert );
	if ( strPKCS7Message == "" )
	{
		var strErr = getErrorString();
		if ( strErr == "" )	// 사용자가 인증서 선택을 취소한 경우
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
		document.input_form.PKCS7Msg.value = strPKCS7Message;
	}

	// 서버에서 사용자의 암호화용 인증서로 PKCS7 Enveloped Message를 만들때 사용하기 위하여 함께 전송한다.
	document.input_form.UserKmCert.value = strUserKmCert;
}

function verify_pkcs7()
{
	var strPKCS7Message = document.input_form.PKCS7Msg.value;

	if ( strPKCS7Message == "" || strPKCS7Message == null )
	{
		alert( "PKCS7 메시지가 없습니다." );
		return;
	}

	var strType = getPKCS7TypeMsg( strPKCS7Message );

	if ( strType == "PKCS7SignedMessage" )
	{
		alert( strType );
		//	PKCS7 signed message 검사하고 원문 얻기
		var strOriginalMessage = verifyPKCS7SignedMsg( strPKCS7Message );
		if ( strOriginalMessage == "" )
		{
			alert( getErrorString() );
			return;
		}
		else
		{
			alert( "원문 데이터: " + strOriginalMessage );
			var count = getPKCS7SignerCount();
			alert( "count: " + count );
			var i = 1;
			for ( i = 1; i <= count; i++ )
			{
				var strSignCert = getPKCS7SignerCert(i)
				alert( i + " 번째 전자서명 인증서: " + strSignCert );
				alert( i + " 번째 전자서명 시각: " + getPKCS7SigningTime(i) );
				alert( i + " 번째 전자서명 인증서 소유자 식별명칭: " + getCertSubjectDN( strSignCert ) );
				alert( i + " 번째 전자서명 인증서 일련번호: " + getCertSerialNumber( strSignCert ) );
			}
		}
		clearPKCS7MessageInfo();
	}
	else if ( strType == "PKCS7EnvelopedMessage" || strType == "PKCS7SignedAndEnvelopedMessage" )
	{
		alert( strType );
		clearCertificateInfo( strCertID );
		var strOriginalMessage = verifyPKCS7EnvelopedMsg( strCertID, strPKCS7Message );
		if ( strOriginalMessage == "" )
		{
			var strErr = getErrorString();
			if ( strErr == "" )	//	사용자가 인증서 선택을 취소한 경우
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
			alert( "원문 데이터: " + strOriginalMessage );
			var count = getPKCS7SignerCount();
			alert( "count: " + count );
			var i = 1;
			for ( i = 1; i <= count; i++ )
			{
				var strSignCert = getPKCS7SignerCert(i)
				alert( i + " 번째 전자서명 인증서: " + strSignCert );
				alert( i + " 번째 전자서명 시각: " + getPKCS7SigningTime(i) );
				alert( i + " 번째 전자서명 인증서 소유자 식별명칭: " + getCertSubjectDN( strSignCert ) );
				alert( i + " 번째 전자서명 인증서 일련번호: " + getCertSerialNumber( strSignCert ) );
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
<a href="Logout.jsp">로그아웃</a>
<br>
<a href="list.html">리스트</a>
</body>
</html>

