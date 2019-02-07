<!--
	Filename : ServerPKCS7.jsp
-->

<%@ page contentType="text/html; charset=utf-8" %>

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
	// 재사용공격을 막기 위해서 사용자 인증 데이터에 포함시킨 nonce가 세션에 없을 경우
	if ( session.getAttribute( "certId" ) == null ) 
	{
		%><script>alert( '접속한지 오래되어서 세션이 끊어졌습니다.\n다시 시도하여 주십시오.' ); location.href=LogoutPageUrl;</script><%
		return;
	}
	String strCertId = (String) session.getAttribute( "certId" ); // 사용자 인증 데이터를 검사할 때 필요한 nonce를 얻는다.

%>

<h2><font color="red">Server에서 PKCS7  메시지 검증 및 생성 예제</font></h2>

<%
	String strUserKmCert	=	request.getParameter( "UserKmCert" ) == null ? "" : request.getParameter( "UserKmCert" );
	String strPKCS7Message	=	request.getParameter( "PKCS7Msg" ) == null ? "" : request.getParameter( "PKCS7Msg" );
	
	PKCS7Util p7util = new PKCS7Util();
	boolean bReturn = false;
	int nType = 1;
	String strOriginalMessage = "Hello World! 안녕하세요?";
	String strSeverPKCS7Message = null;

	if ( !strPKCS7Message.equals("") )
	{
	//	out.println( "클라이언트에서 생성된 PKCS7 메시지 : [" + strPKCS7Message + "]<br>" );

		nType = p7util.getPKCS7Type(strPKCS7Message.getBytes());
		out.println( "PKCS7 메시지 타입 : [" + nType + "]<br>" );

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
			out.println("데이터 : [" + strOriginalMessage + "]<br>" );

			if ( nType == 1 || nType == 3 )
			{
				// PKCS7 Signed 메시지나 PKCS7 Signed and Enveloped 메시지에 포함된 인증서 얻기
				Set certSet  = p7util.getCertificateSet();
				Iterator it = certSet.iterator();
				byte[] signcert = null;

				out.println("전자서명 인증서 갯수 : [" + certSet.size() + "]<br>" );
				while( it.hasNext() ) {
					X509Certificate cert = (X509Certificate)it.next();
					signcert = cert.getEncoded();				
					CertUtil cu = new CertUtil( signcert);

					out.println( "전자서명 인증서의 소유자 식별명칭: [" + cu.getSubjectDN() + "]<br>" );
				}
			}
		}
		else
		{
			out.println("에러 내용: " + p7util.getErrorMsg() + "<br>" );
		}

		if ( nType == 1 )
		{
			// PKCS7 Signed Message에 전자서명을 추가한다.
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
			// PKCS7 Signed message를 생성한다.
			try
			{
				//strSeverPKCS7Message = p7util.genSignedData( ServerSignKey, ServerKeyPassword, ServerSignCert, strOriginalMessage.getBytes() );
				strSeverPKCS7Message = p7util.genEncPassSignedData( ServerSignKey, ServerKeyEncPassword, ServerSignCert, strOriginalMessage.getBytes() );
			}
			catch( Exception e )
			{
				out.println("에러 내용 : [" + p7util.getErrorMsg() + "]");
				return;
			}
		}
	}
	if ( !strUserKmCert.equals("") )
	{
		if ( nType == 2 )
		{
			// PKCS7 Enveloped message를 생성한다.
			try
			{
				strSeverPKCS7Message = p7util.genEnvelopedData( strUserKmCert.getBytes(), strOriginalMessage.getBytes() );
			}
			catch( Exception e )
			{
				out.println("에러 내용 : [" + p7util.getErrorMsg() + "]");
				return;
			}
		}
		else if ( nType == 3 )
		{
			// PKCS7 Signed and Enveloped message를 생성한다.
			try
			{
				//strSeverPKCS7Message = p7util.genSignedAndEnvelopedData(ServerSignKey, "a123456A", ServerSignCert, strUserKmCert.getBytes(), strOriginalMessage.getBytes() );
				//strSeverPKCS7Message = p7util.genEncPassSignedAndEnvelopedData( byte[] signPrivKey, String encpass, byte[] signCert, byte[] recipCert, byte[] data, boolean isSignAttr)
				strSeverPKCS7Message = p7util.genEncPassSignedAndEnvelopedData(ServerSignKey, ServerKeyEncPassword, ServerSignCert, strUserKmCert.getBytes(), strOriginalMessage.getBytes(), true );

			}
			catch( Exception e )
			{
				out.println("에러 내용 : [" + p7util.getErrorMsg() + "]");
				return;
			}
		}
	}
	
%>


<form name="input_form">
<br><font color="blue">서버에서 생성된 PKCS7 Message</font><br>
	<textarea name="PKCS7Msg" rows="7" cols="80"><%=strSeverPKCS7Message%></textarea><br>
<table>
	<tr><td>
		<input type="button" value="클라이언트에서 PKCS7 Message 검사하고 원문 얻기" onClick="verify_pkcs7()" >
	</td></tr>
	<tr><td>
		<input type="button" value="PKCS7 Signed Message에 전자서명 추가하기" onClick="pkcs7_multi_signed()" >
	</td></tr>
	<tr><td>
		<input type="button" value="전송" onClick="do_submit()" >
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
		alert( "PKCS7 메시지가 없습니다." );
		return;
	}

	var strType = getPKCS7TypeMsg( strPKCS7Message );
	if ( strType == "PKCS7SignedMessage" )
	{
		//	PKCS7 signed message에 전자서명 추가하기
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

function verify_pkcs7()
{
	var strCertID = "<%=strCertId%>";
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

