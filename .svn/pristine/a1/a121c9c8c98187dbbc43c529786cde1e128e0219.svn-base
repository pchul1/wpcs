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

	String strOpenerKmKey = request.getParameter( "OpenerKmKey" ) == null ? "" : request.getParameter( "OpenerKmKey" );
	if ( strOpenerKmKey.equals("") ) 
	{
		%><script>alert( '암호화용 개인키가 없습니다.' ); history.back();</script><%
		return;
	}

	String strOpenerKmCert = request.getParameter( "OpenerKmCert" ) == null ? "" : request.getParameter( "OpenerKmCert" );
	if ( strOpenerKmCert.equals("") ) 
	{
		%><script>alert( '암호화용 인증서가 없습니다.' ); history.back();</script><%
		return;
	}

	String strOneTimePassword = (String) session.getAttribute( "NEWPASSWORD" );
	if ( strOneTimePassword.equals("") ) 
	{
		%><script>alert( '일회용비밀번호가 없습니다.' ); history.back();</script><%
		return;
	}

	// 사용자(개찰 담당관)의 암호화용 인증서에서 소유자 식별명칭과 일련번호를 구한다.
	try
	{
		CertUtil cert = new CertUtil( strOpenerKmCert.getBytes() );
		String strSubjectDn = cert.getSubjectDN();
		String strSerialNumber = cert.getSerialNumber();

		out.println( "개찰 담당관가 선택한 암호화용 인증서의 소유자 식별명칭: [" + strSubjectDn + "]<br>" );
		out.println( "개찰 담당관가 선택한 암호화용 인증서의 일련번호: [" + strSerialNumber + "]<br>" );

		String strUserKmCertSubjectDn = (String) session.getAttribute( "KM_CERT_SUBJECT_DN" );
		String strUserKmCertSerialNumber = (String) session.getAttribute( "KM_CERT_SERIAL" );

		// 사용자가 선택한 암호화용 개인키가 입찰 데이터를 암호화할 때 사용한 암호화용 인증서와 짝을 이루는 개인키인지 확인한다.
		if ( strSubjectDn.compareTo( strUserKmCertSubjectDn ) != 0
			|| strSerialNumber.compareTo( strUserKmCertSerialNumber ) != 0 )
		{
			%><script>alert('암호화용 인증서가 다릅니다');	history.back();</script><%
			return;
		}
	}
	catch (Exception e) 
	{
		%><script>alert('올바른 인증서가 아닙니다.'); history.back();</script><%
		return;
	}

	// DB의 입찰 데이터 테이블에서 암호화된 입찰 데이터와 암호화된 전자서명과 입찰 참여 업체의 전자서명용 인증서의
	// 소유자 식별명칭과 일련번호를 구하고, 이를 이용하여 DB의 인증서 테이블에서 입찰 참여 업체의 전자서명용 인증서를 구한다.
	// 이 예제 프로그램에서는 DB 대신에 WAS 세션에서 데이터를 가져와 사용한다.
	String strUserSignCert = (String) session.getAttribute( "SIGNCERT" );
	String strEncryptedData1 = (String) session.getAttribute( "DATA1" );
	String strEncryptedData2 = (String) session.getAttribute( "DATA2" );
	String strEncryptedSessionKeyForOpener = (String) session.getAttribute( "NEWKEY" );
	String strEncryptedSignValueForOriginalMessage = (String) session.getAttribute( "SIGNVALUE" );

	if ( strUserSignCert.equals("") ) 
	{
		%><script>alert( '전자서명용 인증서가 없습니다.' ); history.back();</script><%
		return;
	}
	if ( strEncryptedSignValueForOriginalMessage.equals("") ) 
	{
		%><script>alert( '평문 데이터에 대한 전자서명이 없습니다.' ); history.back();</script><%
		return;
	}
	if ( strEncryptedSessionKeyForOpener.equals("") ) 
	{
		%><script>alert( '개찰관의 인증서로 암호화된 대칭키가 없습니다.' ); history.back();</script><%
		return;
	}
	if ( strEncryptedData1.equals("") ) 
	{
		%><script>alert( '암호문 데이터1 없습니다.' ); history.back();</script><%
		return;
	}
	if ( strEncryptedData2.equals("") ) 
	{
		%><script>alert( '암호문 데이터2 없습니다.' ); history.back();</script><%
		return;
	}

	// 개찰 담당관의 암호화용 개인키를 사용하여 개찰 담당관의 암호화용 인증서로 암호화된 대칭키를 복호화한다.
	// 개찰 담당관의 암호화용 개인키의 비밀번호로 WAS 세션에 저장된 일회용 비밀번호를 사용한다.
	CipherUtil cipher = new CipherUtil();
	byte[] sessionKeyForOpener = null;
	byte[] data1 = null;
	byte[] data2 = null;
	byte[] signValueForOriginalMessage = null;
	
	try
	{
		sessionKeyForOpener =
			cipher.decryptRSA( strOpenerKmKey.getBytes(), strOneTimePassword, strEncryptedSessionKeyForOpener );

		if ( sessionKeyForOpener == null )
		{
			%><script>alert('대칭키 복호화에 실패하였습니다'); history.back();</script><%
			return;
		}
	}
	catch(Exception e)
	{
		%><script>alert('<%=e.toString()%>'); history.back();</script><%
		return;
	}

	// 개찰 담당관의 암호화용 개인키로 복호화된 대칭키로 SEED 알고리즘으로 암호화된 입찰 데이터를 복호화한다.
	try
	{
		cipher.decryptInit( sessionKeyForOpener );
		data1 = cipher.decryptUpdate( Base64Util.decode( strEncryptedData1 ));
		data2 = cipher.decryptUpdate( Base64Util.decode( strEncryptedData2 ));
		signValueForOriginalMessage = cipher.decryptUpdate( Base64Util.decode( strEncryptedSignValueForOriginalMessage ));
		cipher.decryptFinal();
		
		if ( data1 == null || data2 == null || signValueForOriginalMessage == null )
		{
			%><script>alert('<%=cipher.getErrorMsg()%>');<%
//			return;
		}
	}
	catch(Exception e)
	{
		%><script>alert('<%=cipher.getErrorMsg()%>');
			location.href = LogoutPageUrl;</script><%
		return;
	}

	String strData1 = new String( data1 );
	String strData2	= new String( data2 );
	String strSignValueForOriginalMessage = new String( signValueForOriginalMessage );

	out.println( "복호화된 투찰금액1: [" + strData1 + "]<br>" );
	out.println( "복호화된 투찰금액2: [" + strData2 + "]<br>" );

	SignUtil sign = new SignUtil();
	String strOriginalMessage = strData1 + strData2;

	out.println( "전자서명 원문 데이터: [" + strOriginalMessage + "]<br>" );

	// 입찰 참여 업체의 전자서명용 인증서와 복호화된 입찰 데이터와 복호화된 전자서명으로 전자서명 검사를 수행한다.
	try 
	{
		sign.verifyInit( strUserSignCert.getBytes() );
		sign.verifyUpdate( strOriginalMessage.getBytes() );
		
		if ( !sign.verifyFinal( Base64Util.decode( strSignValueForOriginalMessage ) ))
		{
			%><script>alert('<%=sign.getErrorMsg()%>');</script><%
			return;
		}
	}
	catch (Exception e) 
	{
		%><script>alert('<%=sign.getErrorMsg()%>');</script><%
		return;
	}
	out.println( "전자서명 검사 성공<br>" ); 

	// 복호화된 입찰 데이터와 전자서명을 DB에 저장한다.
%>

<a href="Logout.jsp">로그아웃</a>
<br>
<a href="list.html">리스트</a>
</body>
</html>

