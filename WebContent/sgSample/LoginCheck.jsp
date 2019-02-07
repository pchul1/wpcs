<!--
	Filename : LoginCheck.jsp
-->

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.net.*" %>
<html>
<head>
<title>사용자 등록 데이터 또는 로그인 데이터 검사 페이지 예제</title>
</head>

<body style='display:none'>

<%@ include file="signgate_common.jsp" %>
<%
	// 로그인 과정에서 사용자 인증 데이터가 매번 동일할 경우에,
	// 한번 사용했던 사용자 인증 데이터를 공격자가 다시 사용할 수가 있다.
	// 이를 막기 위해서 매번 변하는 데이터를 사용자 인증 데이터에 포함시킬 필요가 있다.
	// 이를 위해서 로그인 form 페이지에서 생성하여 WAS 세션에 저장한 nonce 값이 존재하는지 확인한다.
	// 이 값은 사용자가 생성한 전자서명을 검사할 때 사용된다.
	if ( session.getAttribute("CHALLENGE") == null ) 
	{
		%><script>location.href=LogoutPageUrl;</script><%
		return;
	}
	String mode = request.getParameter( "mode" ) == null ? "login" : request.getParameter( "mode" );

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
<script>
	var LogoutPageUrl = 'LoginForm.jsp?mode=<%=mode%>';
</script>
<center>
<br><br>
이 페이지는 사용자 정보 등록 페이지 또는 로그인 데이터 검사 페이지에서 사용될 수 있는 샘플 코드를 보여주는 페이지 입니다.
<br><br>
</center>
<%
	// 사용자 정보 또는 로그인에 사용되는 사용자 인증 데이터를 검사하는 도중에
	// 오류가 발생하는 경우에 대해서는 각 경우에 적절한 처리를 수행하도록 한다.
	// 예를 들어 사용자의 전자서명용 인증서가 유효하지 않을 경우에는
	// 인증서가 유효하지 않다는 오류메시지를 사용자에게 보여주고 유효한 인증서를 사용하여 다시 시도하도록 하여야만 한다.
	if ( strUserLoginID.equals("") )
	{
		%><script>alert( 'ID가 없습니다.' ); location.href = LogoutPageUrl;</script><%
		return;
	}

	// 로그인 페이지에서 사용자 인증 데이터를 검사하다가 실패한 경우에 LogOut.jsp 페이지에서
	// 사용자가 선택한 인증서 정보를 메모리에서 지우는데 사용하기 위하여 세션에 저장한다.
	session.setAttribute( "TEMPID", strUserLoginID );

	if ( strUserSignCert.equals("") )
	{
		%><script>alert( '인증서가 없습니다.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strUserSignValue.equals("") )
	{
		%><script>alert( '전자서명이 없습니다.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strEncryptedSessionKeyForServer.equals("") )
	{
		%><script>alert( '대칭키가 없습니다.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strEncryptedUserSSN.equals("") )
	{
		%><script>alert( '주민등록번호가 없습니다.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strEncryptedLoginPassword.equals("") )
	{
		%><script>alert( '비밀번호가 없습니다.' ); location.href = LogoutPageUrl;</script><%
		return;
	}
	if ( strEncryptedUserRandomNumber.equals("") )
	{
		%><script>alert( '신원확인정보가 없습니다.' ); location.href = LogoutPageUrl;</script><%
		return;
	}

	// 요청 메시지에서 전송된 form data가 정상적으로 전송되었는지 확인하기 위한 목적으로 보여준다.
	out.println( "replay attack 방지를 위한 챌리지 값: [" + strChallenge + "]<br>" );
	out.println( "사용자 ID: [" + strUserLoginID + "]<br>" );
//	out.println( "사용자의 전자서명용 인증서: [" + strUserSignCert + "]<br>" );
	out.println( "전자서명 값: [" + strUserSignValue + "]<br>" );
	out.println( "암호화된 주민등록번호: [" + strEncryptedUserSSN + "]<br>" );
	out.println( "암호화된 로그인 비밀번호: [" + strEncryptedLoginPassword + "]<br>" );
	out.println( "본인확인용 정보: [" + strEncryptedUserRandomNumber + "]<br>" );

	// 사용자 PC에서 SEED 알고리즘으로 암호화된 데이터를 복호화하기 위해서
	// 암호화에 사용되었던 대칭키(비밀키 또는 세션키라고도 함)가 필요하다.
	// 이 대칭키는 안전하게 전달되도록 WAS 서버의 암호화용 인증서(엄밀하게는 인증서에 포함되어 있는 공개키)를 사용하여
	// RSA 알고리즘으로 암호화되어 있으므로 WAS 서버의 암호화용 개인키로 복호화하한다.
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
			%><script>alert('대칭키 복호화에 실패하였습니다'); //location.href = LogoutPageUrl;</script><%
			return;
		}
	}
	catch(Exception e)
	{
		%><script>alert('<%=e.toString()%>'); location.href = LogoutPageUrl;</script><%
		return;
	}

	// WAS 서버의 암호화용 개인키로 복호화한 대칭키를 사용하여 SEED 알고리즘으로 암호화된 데이터를 복호화한다.
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

	out.println( "주민등록번호: [" + strUserSSN + "]<br>" );
	out.println( "로그인 비밀번호: [" + strLoginPassword + "]<br>" );

	// 대칭키로 복호화하여 얻은 사용자 정보 데이터 또는 사용자 인증 데이터가 위.변조가 되지 않은 그대로임을 확인하고
	// 데이터를 입력한 주체가 인증서의 소유자임을 확인하기 위하여 전자서명 검사를 한다.
	// 무결성(message integrity) 검사, 발신자 인증(sender authentication), 송신 부인봉쇄(non-repudiation)
	// 전자서명을 검사하기 위해서는 전자서명 생성할 때 사용한 그대로의 데이터가 필요하다.
	SignUtil sign = new SignUtil();
	String strOriginalMessage = strChallenge + strLoginPassword + strUserSSN + strUserLoginID;

	out.println( "전자서명 원문 데이터: [" + strOriginalMessage + "]<br>" );

	// 전자 서명을 검사하기 위해서는 사용자의 전자서명용 인증서(엄밀하게는 전자서명용 인증서에 포함된 전자서명 검증키)를 사용하여
	// 원문 데이터에 대한 전자서명 검사를 수행한다.
	try
	{	
		

		sign.verifyInit( strUserSignCert.getBytes() );   //인증서
		sign.verifyUpdate( strOriginalMessage.getBytes() ); // 원문
		
		if ( !sign.verifyFinal( Base64Util.decode( strUserSignValue ) ))  //사인값
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
	out.println( "전자서명 검사 성공<br>" );

	// 사용자의 전자서명용 인증서에서 각종 정보를 구한다.
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

		out.println( "사용자의 전자서명용 인증서의 소유자 식별명칭: [" + strSubjectDn + "]<br>" );
		out.println( "사용자의 전자서명용 인증서의 발급자 식별명칭: [" + strIssuerDn + "]<br>" );
		out.println( "사용자의 전자서명용 인증서의 일련번호: [" + strSerialNumber + "]<br>" );
		out.println( "사용자의 전자서명용 인증서의 유효기간 시작: [" + strNotBefore + "]<br>" );
		out.println( "사용자의 전자서명용 인증서의 유효기간 만료: [" + strNotAfter + "]<br>" );
		out.println( "사용자의 전자서명용 인증서의 유효기간의 남아있는 일 수: [" + nRemainDays + "]<br>" );
		out.println( "사용자의 전자서명용 인증서의 정책 OID: [" + strPolicyOid + "]<br>" );
	}
	catch (Exception e) 
	{
		%><script>alert('올바른 인증서가 아닙니다.'); location.href = LogoutPageUrl;</script><%
		return;
	}

	// 사용자의 인증서가 서비스에 사용할 수 있는 등급의 인증서인지 검사한다.
	// 예) 특수 목적용 인증스는 일반적인 서비스에 사용할 수 없다. 법인용 서비스를 이용하기 위해서 개인용 인증서를 사용할 수는 없다.
	// 실서버 적용시 인증서 정책검증 제외 2010.10.25 append
/*
	if ( !cert.isValidPolicyOid( AllowedPolicyOIDs ) )
	{
		%><script>alert('허용되지 않는 정책의 인증서입니다'); location.href = LogoutPageUrl;</script><%
		return;
	}
	out.println( "인증서 정책 검사 성공<br>" );
*/

	// 주민등록번호/사업자등록번호를 이용하여 인증서 소유자를 확인하는 검사를 한다.
	// 사용자 등록 페이지라면 사용자가 입력한 주민등록번호/사업자등록번호를 사용하고,
	// 로그인 페이지라면, DB에 저장된 사용자의 주민등록번호/사업자등록번호를 사용한다.
	if ( !cert.isValidUser( strUserSSN, strUserRandomNumber) )
	{
		%><script>alert('사용자 본인확인 검사에 실패하였습니다'); location.href = LogoutPageUrl;</script><%
		return;
	}
	out.println( "사용자 본인확인 검사 성공<br>" );

	if("login".equals(mode) && nRemainDays > 0) {
		out.println("<form name='CrtfctLogin' method='POST' action='/common/login/actionCrtfctLogin.do' target='waterkorea'>");
		out.println("<input type='hidden' name='dn' value='" + strSubjectDn + "'>");
		out.println("</form>");
		out.println("<script>document.CrtfctLogin.submit();window.close();</script>");
		return;
	}

	if("update".equals(mode) && nRemainDays > 0) {
		out.println("<form name='updateDn' method='POST' action='/common/login/updateDn.do' target='waterkorea'>");
		out.println("<input type='hidden' name='id' value='" + strUserLoginID + "'>");
		out.println("<input type='hidden' name='password' value='" + strLoginPassword + "'>");
		out.println("<input type='hidden' name='dn' value='" + strSubjectDn + "'>");
		out.println("</form>");
		out.println("<script>document.updateDn.submit();window.close();</script>");
		return;
	}

	// 사용자가 전자서명에 사용한 인증서가 현재 유효한 인증서인지 여부를 확인한다.
	
	OCSPUtil ocsputil = null;


	try 
	{	

		// 실서버 적용시 경로 설정 필수 2010.10.25 append 고정하
		String OCSPServerSignCertFile = "/data/signgate/SG_SecuKit/cert/signCert.der";
		String OCSPServerSignKeyFile ="/data/signgate/SG_SecuKit/cert/signPri.key";
		String signcerpem = CertUtil.derToPem(FileUtil.readBytesFromFileName(OCSPServerSignCertFile));
		String signpripem = KeyUtil.derToPem(FileUtil.readBytesFromFileName(OCSPServerSignKeyFile));
		
		ocsputil = new OCSPUtil();

		//============================ 테스트 경우만 세팅 운영시 주석 처리 ~~~~~~~~~~~~~~~~~~~~~~~~~~~//
		//ocsputil.setTestOcsp(true, "http://ftca.signgate.com:4505"); //(주석처리 하면 자동으로 리얼 OCSP서버로 접속)
		
		ocsputil.setKicaGatewayOcspServer(true);
		//if(ocsputil.isValid(cert, CRLCacheDirectory)){ 
		/*
		1.cert = "사용자 인증서"
		2.signpripem = "OCSP서버인증서 signPri.key"
		3.signcerpem = "OCSP서버인증서 signCert.der"
		4.OCSPServerKeyPassword = "서버인증서 비밀번호"
		5.CRLCacheDirectory = "crl디렉토리"
		*/

		//ocsp 인증서 패스워드 2010.10.25 append 고정하 
		String OCSPServerKeyPassword = "qwer1234";
	

		out.println("CRLCacheDirectory : "+CRLCacheDirectory + "<br>");
		out.println("CRLCacheDirectory : "+signpripem + "<br>");
		out.println("CRLCacheDirectory : "+signcerpem + "<br>");

		if(ocsputil.isValid(cert, signpripem, OCSPServerKeyPassword, signcerpem, CRLCacheDirectory, false)){
			out.println("OCSP 유효성 검증 성공");
		}
		else{
			%><script>alert('OCSP 유효성 검사 실패 : ' + '<%=ocsputil.getErrorMsg()%>');
				location.href = 'LoginForm.jsp?mode=<%=mode%>';</script><%
				return;
		}		
	} 
	catch (Exception e)
	 {
		out.println("Error : " + ocsputil.getErrorMsg());
	 	%><script>alert('인증서 유효성 검사 실패');	location.href = 'LoginForm.jsp?mode=<%=mode%>';</script><%
		return;
	}
	out.println( "인증서 유효성 검증 성공<br>" );

	// 여기까지 성공적으로 수행되면 그 다음은 어플리케이션에서 필요한 절차를 수행하면 된다.

	// 만약 사용자의 전자서명을 DB에 저장하였다가 추후 사용자의 인증서를 가지고 전자서명 검사를 할 필요가 있는
	// 서비스라면 DB의 인증서 테이블에 사용자의 인증서 소유자 식별명칭과 일련번호를 Primary Key로하여
	// 인증서를 저장하여야 한다.

	// 만약, 서비스를 이용하기 위하여 사용자의 인증서를 시스템에 등록하여야 하고,
	// 등록된 인증서만을 사용하여 시스템에 로그인이 가능해야 하는 경우라면
	// DB의 사용자 정보 테이블에 사용자의 인증서 소유자 식별명칭과 일련번호를 저장하거나
	// 이미 저장되어 있는 값과 비교하는 절차가 각각 사용자 등록 페이지나 로그인 검사 페이지에서 필요하다.

	// 샘플 프로그램에서는 사용자의 로그인 ID를 세션에 저장함으로써 로그인 상태를 체크한다.
	// 로그인에서 사용자 인증 데이터로 사용되는 nonce 값은 더 이상 필요가 없으므로 WAS 세션에서 지운다.
	session.removeAttribute( "TEMPID" );
	session.removeAttribute( "CHALLENGE" );
	session.setAttribute( "LOGINID", strUserLoginID );

	// 이후 페이지에서 사용자 PC와 WAS 서버 사이에 데이터를 SEED 알고리즘으로 암호화하여 주고 받을 때
	// 사용하기 위하여 WAS 세션에 저장한다.
	session.setAttribute( "SESSIONKEY", SessionKeyForServer );

	// 로그인 이후에 전자서명 검사에 사용할 인증서가 로그인할 때 사용한 인증서와 같은지 확인하거나
	// DB의 인증서 테이블에서 인증서를 조회할 때 사용할 수 있도록
	// 사용자의 인증서 소유자 식별명칭과 전자서명용 인증서의 일련번호를 WAS 세션에 저장한다.
	session.setAttribute( "CERT_SUBJECT_DN", strSubjectDn );
	session.setAttribute( "SIGN_CERT_SERIAL", strSerialNumber );
%>

<br><br>
<%=session.getAttribute( "LOGINID" )%>님이 로그인하였습니다.
<br><br>
<a href="Logout.jsp">로그아웃</a>
<br>
<a href="list.html">리스트</a>
</body>
</html>

