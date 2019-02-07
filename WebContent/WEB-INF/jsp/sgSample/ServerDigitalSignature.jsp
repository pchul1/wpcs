<!--
	Filename : ServerDigitalSignature.jsp
-->

<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
<title>Server-side Digital Signature Sample</title>
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
	String strUserSignValue = request.getParameter( "UserSignValue" ) == null ? "" : request.getParameter( "UserSignValue" );
	String strMessage1 = request.getParameter( "msg1" ) == null ? "" : new String( request.getParameter( "msg1" ).getBytes( "8859_1" ), "KSC5601" );
	String strMessage2 = request.getParameter( "msg2" ) == null ? "" : new String( request.getParameter( "msg2" ).getBytes( "8859_1" ), "KSC5601" );
%>

<h2><font color="red">서버에서 전자서명 검증 및 생성 예제</font></h2>

<form name="input_form">
<br><font color="blue">원문메시지1</font><br>
	<input type="text" name="msg1" size="80" value="<%=strMessage1%>" ><br>
<br><font color="blue">원문메시지2</font><br>
	<textarea name="msg2" rows="5" cols="80" ><%=strMessage2%></textarea><br>

<%
	// 사용자의 인증서가 GPKI 인지 NPKI 인지 확인한다.
	CertUtil cert = new CertUtil( strUserSignCert.getBytes() );
	boolean gpki_check = false;
	if( cert.getPolicyOid().indexOf("1.2.410.100001") > -1 )
	{
		gpki_check =true;
	}

	String strOriginalMessage = strMessage1 + strMessage2;

	if ( strOriginalMessage.equals( "" ) || strUserSignCert.equals( "" ) || strUserSignValue.equals( "" ) )
	{
		%><script>alert('전자서명 검증에 필요한 데이터가 없습니다.'); </script><%
		return;
	}

	if ( gpki_check )
	{
		%><script>alert('gpki'); </script><%
		
		/* //gpki 검증할 수 있는 모듈과 signgate버전이 설치됬을 경우에만 주석해제 한다.
		 * //GPKI일경우 수행
		GpkiSignUtil gpkiSign = new GpkiSignUtil("SHA1WithKCDSA");
		try
		{
			gpkiSign.verifyInit(CertUtil.pemToDer(strUserSignCert));
			if( gpkiSign.verifyFinal(strOriginalMessage.getBytes(), Base64Util.decode( strUserSignValue )) )
			{
				result = "<b>사용자가 생성한 전자서명 검사에 성공하였습니다.</b>";
				//out.println("<b>사용자가 생성한 전자서명 검사에 성공하였습니다.</b>");
			}
			else
			{
				%><script>alert( '<%=gpkiSign.getErrorMsg()%>' );</script><%
			}
		}
		catch (Exception e) 
		{
			%><script>alert('<%=gpkiSign.getErrorMsg()%>'); </script><%
		}
		*/
	}
	else
	{
		SignUtil sign = new SignUtil();
		try
		{
			sign.verifyInit( strUserSignCert.getBytes() );
			sign.verifyUpdate( strOriginalMessage.getBytes() );
			if ( sign.verifyFinal( Base64Util.decode( strUserSignValue ) ))
			{
				%><script>alert( '사용자가 생성한 전자서명 검사에 성공하였습니다.' );</script><%
			}
			else
			{
				%><script>alert( '<%=sign.getErrorMsg()%>' );</script><%
			}
		}
		catch ( Exception e )
		{
			%><script>alert( '<%=sign.getErrorMsg()%>' );</script><%
		}
	}

	// 사용자가 전자서명에 사용한 인증서가 로그인할 때 사용한 인증서인지 확인한다.
	// 만일 로그인할 때 사용한 인증서와 동일한 인증서라면 인증서 유효성 검사는 생략할 수 있다.
	try
	{
		String strSubjectDn = cert.getSubjectDN();
		String strSerialNumber = cert.getSerialNumber();
		if ( strSubjectDn.compareTo( strUserCertSubjectDn ) != 0
			|| strSerialNumber.compareTo( strUserSignCertSerialNumber ) != 0 )
		{
			%><script>alert('로그인에 사용한 인증서가 아닙니다');</script><%
		}
	}
	catch ( Exception e )
	{
		%><script>alert( '<%=e.toString()%>' );</script><%
	}

	// WAS 서버의 전자서명 생성키(전자서명용 개인키)를 사용하여 원문 데이터에 대한 전자서명을 생성한다.
	// 서버 인증서는 NPKI 인증서.
	byte[] ServerSignValue = null;
	String strServerSignValue = "";
	if ( !strOriginalMessage.equals("") )
	{		
		SignUtil sign = new SignUtil();
		try
		{
			// ServerKeyEncPassword 를 사용하는 함수, 추후 추가.
			//sign.signInit( ServerSignKey, ServerKeyPassword );
			sign.signInit( ServerSignKey, "a123456A" );

			sign.signUpdate( strOriginalMessage.getBytes() );
			ServerSignValue = sign.signFinal();
			strServerSignValue = Base64Util.encode( ServerSignValue );
		}
		catch( Exception e )
		{
			%><script>alert('<%=sign.getErrorMsg()%>');</script><%
		}
	}

%>

<br><font color="blue">(서버가 생성한) 전자서명 값</font><br>
	<textarea name="ServerSignValue" rows="3" cols="80"><%=strServerSignValue%></textarea><br>
<br><font color="blue">전자서명 검사에 필요한 인증서 (서버의 전자서명용 인증서)</font><br>
	<textarea name="ServerSignCert" rows="8" cols="80"><%=ServerSignCertPem%></textarea><br>
<table>
	</td><td>
		<input type="button" value="클라이언트에서 전자서명 검사" onClick="verify_sign()" >
	</td></tr>
	<tr><td>
		<input type="button" value="서버 인증서 정보 보기" onClick="show_cert_info()" >
	</td></tr>
</table>
</form>

<script language="javascript">

function verify_sign()
{
	var strServerSignValue = document.input_form.ServerSignValue.value;
	var strServerSignCert = document.input_form.ServerSignCert.value;
	var strOriginalMessage = document.input_form.msg1.value + document.input_form.msg2.value;

	if ( strOriginalMessage == "" || strOriginalMessage == null )
	{
		alert( "전자서명을 검사할 원문 메시지를 입력하십시오." );
		return;
	}

	if ( strServerSignValue == "" || strServerSignValue == null )
	{
		alert( "전자서명 값을 입력하십시오." );
		return;
	}

	if ( strServerSignCert == "" || strServerSignCert == null )
	{
		alert( "전자서명 검사에 사용할 인증서를 입력하십시오." );
		return;
	}

	// 사용자 PC에서 전자서명 검사를 수행한다.
	var bReturn = verifyDigitalSignature( strOriginalMessage, strServerSignValue, strServerSignCert );
	if ( bReturn )
	{
		alert( "전자서명 검사에 성공하였습니다." );
	}
	else
	{
		alert( getErrorString() );
	}
}

function show_cert_info()
{
	var strCert = document.input_form.ServerSignCert.value;
	if ( strCert == "" || strCert == null )
	{
		alert( "인증서가 없습니다." );
		return;
	}

	// 사용자 PC에서 인증서의 각종 정보를 구한다.
	var strSubject = getCertSubjectDN( strCert );
	if ( strSubject == "" )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "Subject: " + strSubject );
	}
	
	var strIssuer = getCertIssuerDN( strCert );
	if ( strIssuer == "" )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "Issuer: " + strIssuer );
	}

	var nSerial = getCertSerialNumber( strCert );
	if ( nSerial < 0 )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "serial: " + nSerial );
	}

	var strStartTime = getCertNotBefore( strCert );
	if ( strStartTime == "" )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "From: " + strStartTime );
	}
	
	var strEndTime = getCertNotAfter( strCert );
	if ( strEndTime == "" )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "To: " + strEndTime );
	}
	
	var strPublicKey = getCertPublicKey( strCert );
	if ( strPublicKey == "" )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "Public Key: " + strPublicKey );
	}
	
	var strKeyUsage = getCertKeyUsage( strCert );
	if ( strKeyUsage == "" )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "Key Usage: " + strKeyUsage );
	}
	
	var strPolicy = getCertPolicy( strCert );
	if ( strPolicy == "" )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "Policy: " + strPolicy );
	}
	
	var bReturn = checkCertValidity( strCert );
	if ( !bReturn )
	{
		alert( getErrorString() );
	}
	else
	{
		alert( "유효한 인증서 입니다" );
	}
}

</script>
<a href="Logout.jsp">로그아웃</a>
<br>
<a href="list.html">리스트</a>
</body>
</html>

