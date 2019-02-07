<!--
	Filename : LoginForm.jsp
-->

<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
<title>사용자 등록 form 또는 로그인 form 페이지 예제</title>

<%@ include file="signgate_common.jsp" %>

<%
	// 로그인 상태 판단을 위해서 WAS 세션에 저장하여 사용하는 object들을 지워서 초기화한다.
	session.removeAttribute( "CHALLENGE" );
	session.removeAttribute( "LOGINID" );
	session.removeAttribute( "SESSIONKEY" );
	session.removeAttribute( "TEMPID" );
	session.removeAttribute( "CERT_SUBJECT_DN" );
	session.removeAttribute( "SIGN_CERT_SERIAL" );

	// 로그인 과정에서 사용자 인증 데이터가 매번 동일할 경우에,
	// 한번 사용했던 사용자 인증 데이터를 공격자가 다시 사용할 수가 있다.
	// 이를 막기 위해서 매번 변하는 데이터를 사용자 인증 데이터에 포함시킬 필요가 있다.
	// 이를 위해서 서버에서 nonce값을 랜덤하게 생성하여
	// 사용자의 전자서명의 원문 데이터에 포함시킬 수 있도록
	// 입력 <form>의 hidden 타입의 <input>에 저장하고
	// 사용자 인증 데이터 검사 페이지에서 사용할 수 있도록 WAS 세션에도 저장한다.
	String strChallenge = Base64Util.encode( RandomUtil.genRand() );
	session.setAttribute( "CHALLENGE", strChallenge );
%>

<script type="text/javascript">

function check_form()
{
	if ( document.input_form.LoginID.value == "" || document.input_form.LoginID.value == null )
	{
		alert( "ID를 입력하시오" );
		return false;
	}
	if ( document.input_form.UserSSN.value == "" || document.input_form.UserSSN.value == null )
	{
		alert( "주민등록번호를 입력하시오" );
		return false;
	}
	if ( document.input_form.LoginPassword.value == "" || document.input_form.LoginPassword.value == null )
	{
		alert( "비빌번호를 입력하시오" );
		return false;
	}
	return true;
}

function do_login()
{
	if ( !check_form() ) return;

	var strDomainName = "@ews.signgate.com"
	var strCertID = document.input_form.LoginID.value + strDomainName;
	var strKeyIDForServer = strCertID;
	var strServerKmCert = document.input_form.ServerKmCert.value;
	var strUserSSN = document.input_form.UserSSN.value;
	var strLoginPassword = document.input_form.LoginPassword.value;

	// 사용자가 이전에 선택했던 인증서가 있을 경우, 선택했던 인증서에 대한 정보를 사용자 PC의 메모리에서 지우고
	// 초기화한다. 이때 사용자가 선택했던 인증서를 식별하기 위해서 CERT ID를 사용한다.
	clearCertificateInfo( strCertID );

	// WAS 서버와 중요 데이터를 대칭키 암호화 알고리즘인 SEED 알고리즘으로 암호화하여 주고받기 위해서
	// 데이터 암호화에 사용할 대칭키(비밀키 또는 세션키라고도 함: SEED 알고리즘에서 사용)를 생성한다.
	// 또한 이 대칭키를 WAS 서버에 안전하게 전달하기 위하여
	// WAS 서버의 암호화용 인증서(엄밀하게는 인증서에 포함되어 있는 공개키)를 사용하여
	// 공개키 암호화 알고리즘인 RSA 알고리즘으로 암호한다.
	// 이렇게 암호화된 대칭키는 WAS 서버의 암호화용 개인키가 있어야만 복호화할 수 있다.
	// 이때 생성한 대칭키(비밀키 또는 세션키라고도 함: SEED 알고리즘에서 사용)를 식별하기 위하여 KEY ID가 사용된다.
	var strEncryptedSessionKeyForServer = encryptSessionKey( strKeyIDForServer, strServerKmCert );
	if ( strEncryptedSessionKeyForServer == "" )
	{
		alert( getErrorString() );
		return;
	}

	// 데이터를 SEED알고리즘으로 암호화 한다. 이 때 사용할 대칭키를 찾기 위하여 KEY ID가 필요하다.
	// KEY ID를 이용하여 대칭키를 식별하는 이유는, 암호화된 데이터를 주고 받을 상대에 따라서
	// 서로 다른 대칭키를 사용하여야 하기 때문이다.
	// 즉, WAS 서버에 전달할 데이터를 암호화할 때 사용할 대칭키와
	// 다른 사용자에게 전달하기 위하여 암호화된 상태로 DB에 저장될 데이터를 암호화할 때 사용할 대칭키는
	// 서로 다른 것을 사용하여야 한다.
	var strEncryptedLoginPassword = encryptDataString( strKeyIDForServer, strLoginPassword );
	if ( strEncryptedLoginPassword == "" )
	{
		alert( getErrorString() );
		return;
	}

	// 동일한 KEY ID를 사용하면, 동일한 대칭키를 사용하여 데이터를 암호화하게 된다.
	var strEncryptedUserSSN = encryptDataString( strKeyIDForServer, strUserSSN );
	if ( strEncryptedUserSSN == "" )
	{
		alert( getErrorString() );
		return;
	}

	// 사용자가 선택했던 인증서 정보를 지운 뒤에 처음 인증서를 사용하는 함수를 호출하면 인증서 선택창이 뜬다.
	// 이때 사용자가 선택한 인증서를 식별하기 위해서 CERT ID를 사용한다. CERT ID를 사용하여
	// 사용자가 선택한 인증서를 구분할 필요가 있는 것은, 동일한 프로세스의 웹브라우저에서 또다른 인증서를
	// 선택할 필요가 생길 수 있기 때문이다.
	// 예를 들어서 두 개 이상의 인증서를 소유한 사용자가 동일한 프로세스의 인터넷 익스플로러 창을 사용하여
	// 서로 다른 인증서를 사용하는 두 웹사이트에 접속하는 경우를 생각해 볼 수 있다.
	// 즉, 인터넷 뱅킹용 인증서와 증권거래용 인증서와 같은 용도별 인증서를 각각 사용하는 경우도 고려하여야 한다.
	// 만약 사용자가 서로 두 웹사이트 모두 동일한 로그인 ID를 사용할 경우라면, 로그인 ID만 가지고는
	// 서로 다른 인증서를 구분하는 식별자로 사용할 수가 없다. 또한, 도메인 네임만 가지고 인증서를 구분하는
	// 식별자로 사용할 경우에는, 동일한 PC를 여러 사용자가 공용으로 사용하는 환경에서, 나중에 사용하는 사용자가
	// 이전의 사용자가 선택한 인증서를 이용하는 경우가 생길 가능성이 생긴다.
	// 따라서, 웹사이트의 도메인 네임과 사용자의 로그인 ID 두가지를 조합하여 CERT ID를 만드는 것이 바람직하다.
	// 만약에 로그인 ID를 사용하지 않는 웹페이지라면, 주민등록번호 등의 사용자 식별 정보를 활용하거나
	// 아니면 서버에서 랜덤으로 생성한 값을 활용할 수도 있다.
	var strUserSignCert = getUserSignCert( strCertID );

	
	if ( strUserSignCert == "" )
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

	// 사용자가 입력한 데이터의 무결성을 검사하고, 해당 데이터를 생성한 주체가 사용자임을 증명하기 위하여
	// 사용자가 선택한 인증서의 전자서명 생성키(전자서명용 개인키라고도 함)를 가지고
	// 사용자가 입력한 데이터에 대하여 전자서명을 생성한다.
	// 이 때, 사용자가 입력한 데이터 필드 각각에 대하여 전자서명을 생성하는 대신에
	// 사용자가 입력한 데이터 필드를 하나의 데이터 스트링으로 구성하여 전자서명 생성하는 것이 휴율적인 방법이다.
	// 사용자의 전자서명 생성키(전자서명용 개인키)를 찾기 위하여 CERT ID가 사용된다.
	var strOriginalMessage = document.input_form.Challenge.value + strLoginPassword + strUserSSN + document.input_form.LoginID.value;
	var strUserSignValue = generateDigitalSignature( strCertID, strOriginalMessage );
	if ( strUserSignValue == "" )
	{
		clearCertificateInfo( strCertID );
		alert( getErrorString() );
		return;
	}

	// 사용자가 선택한 인증서의 소유자임을 확인하기 위하여 필요한 값을 구한다.
	// 이 값과 사용자의 전자서명용 인증서와 사용자의 주민등록번호/사업자번호를 사용하여
	// 사용자가 해당 인증서의 소유자임을 확인할 수가 있다.
	// 이 값은 사용자의 전자서명 생성키(전자서명용 개인키)에 포함되어 있으므로
	// 마찬가지로 사용자가 선택한 인증서를 찾기 위해서 CERT ID가 필요하다.
	var strUserRandomNumber = getRandomNumber( strCertID );
	if ( strUserRandomNumber == "" )
	{
		clearCertificateInfo( strCertID );
		alert( "인증서에 신원확인을 위한 정보가 포함되어있지 않습니다.\n인증기관의 인증서 관리 페이지에서 상호연동용 인증서로 변환하신 후에 사용하십시오." )
		return;
	}

	// 사용자가 선택한 인증서의 소유자임을 확인하기 위하여 필요한 값은 중요한 데이터이므로 암호화하여 전달하여야 한다.
	// 이 값을 전달받을 대상이 WAS 서버이므로, WAS 서버와 공유할 대칭키를 사용하여 암호화한다.
	var strEncryptedUserRandomNumber = encryptDataString( strKeyIDForServer, strUserRandomNumber );
	if ( strEncryptedUserRandomNumber == "" )
	{
		clearCertificateInfo( strCertID );
		alert( getErrorString() );
		return;
	}

	// 필요한 값들을 전송 <form>의 hidden 타입의 <input>에 저장한다.
	// 입력 <form>과 전송 <form>을 나누어 사용하는 이유는
	// <form>을 전송할 때는 <form>의 모든 <input>이 함께 전송되는데,
	// 사용자가 입력한 암호화되지 않은 데이터를 저장한 <input>이
	// 암호화된 데이터를 저장한 <input>과 함께 전송되는 경우가 생기지 않도록 함이다.
	document.submit_form.UserSignCert.value = strUserSignCert;
	document.submit_form.UserSignValue.value = strUserSignValue;
	document.submit_form.EncryptedSessionKeyForServer.value = strEncryptedSessionKeyForServer;
	document.submit_form.EncryptedUserRandomNumber.value = strEncryptedUserRandomNumber;
	document.submit_form.EncryptedLoginPassword.value = strEncryptedLoginPassword;
	document.submit_form.EncryptedUserSSN.value = strEncryptedUserSSN;

	// 이 예제 프로그램에서는 사용자의 로그인 ID는 암호화하지 않는다.
	document.submit_form.LoginID.value = document.input_form.LoginID.value;

	// 사용자가 선택한 인증서에 대한 정보를 사용자 PC의 메모리에서 지우고 초기화한다.
	// 이때 사용자가 선택했던 인증서를 식별하기 위해서 CERT ID를 사용한다.
	// 로그인 이후에도 전자서명을 생성할 필요가 있는 경우에 인증서를 다시 선택하지 않도록 하려면
	// 여기서 이 함수를 호출하지 말고, 그 대신에 사용자가 로그아웃할 때 반드시 호출하도록 한다.
	// 로그인 후에 전자서명을 사용하지 않거나, 전자서명을 생성할 때 다시 인증서를 선택하도록
	// 하는 경우에는 여기서 이 함수를 호출하도록 하는 것이 바람직하다.
//	clearCertificateInfo( strCertID );

	document.submit_form.method = "POST";
	document.submit_form.action = "LoginCheck.jsp"
	document.submit_form.submit();
}

</script>
</head>

<body>
	<center>
		<strong>
			<font color="blue" size="4">인증서 기반 로그인 또는 사용자 등록(인증서 등록) 페이지 예제</font>
		</strong>
		<br/><br/>
		이 페이지는 사용자 정보를 등록하는 페이지나 로그인 정보를 입력하는 페이지에서 사용될 수 있는 샘플 코드를 보여주는 페이지입니다.
	</center>
	<br/>

<form name="submit_form" method="post">
	<input type="hidden" name="UserSignCert">
	<input type="hidden" name="UserSignValue">
	<input type="hidden" name="EncryptedSessionKeyForServer">
	<input type="hidden" name="EncryptedUserRandomNumber">
	<input type="hidden" name="EncryptedLoginPassword">
	<input type="hidden" name="EncryptedUserSSN">
	<input type="hidden" name="LoginID">
</form>

<form name="input_form">
	<table>
		<tr><td>
			사용자 로그인 ID
		</td><td>
			<input type="text" name="LoginID" value="TestPerson">
		</td></tr>
		<br/>
		<tr><td>
			로그인 비밀번호	<!-- 로그인 비밀번호와 인증서 비밀번호는 별개이다 -->
		</td><td>
			<input type="password" name="LoginPassword" value="ji83sf46">
		</td></tr>
		<br/>
		<tr><td>
			주민등록번호
		</td><td>
			<input type="text" name="UserSSN" value="1234561234563">
		</td></tr>
	</table>

	<!-- 로그인 사용자 인증 데이터를 매번 다르게 하기 위하여 WAS 서버에서 랜덤하게 생성한 nonce 값 -->
	<input type="hidden" name="Challenge" value="<%=strChallenge%>">
	<!-- 대칭키를 RSA 알고리즘으로 암호화하기 위한 WAS 서버의 암호화용 인증서  -->
	<input type="hidden" name="ServerKmCert" value="<%=ServerKmCertPem%>"> 

	<input type="button" value="로그인" onclick="javascript:do_login()">
</form>

<a href="list.html">리스트</a>
</body>
</html>

