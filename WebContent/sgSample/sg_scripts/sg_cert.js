//*************************************************************************************
//	파일명		: sg_cert.js
//	작성자		: 안재형
//	최초 작성일	: 2003년 7월 21일
//	최종 수정자	: 박옥자
//	최종 수정일	: 2006년 11월 6일
//*************************************************************************************

function selectCertificate( strCertID )
{
	if ( strCertID == null || strCertID == "" )
	{
		setErrorCode( "NO_USER_ID" );
		setErrorMessage( "" );
		setErrorFunctionName( "selectCertificate()" );
		return false;
	}
	SetSessionID( strCertID );
	
	var bReturn = LoadUserKeyCertDlg( bUseKMCert );
	if ( !bReturn )
	{
		setErrorCode( GetLastErrMsg() );
		setErrorMessage( "" );
		setErrorFunctionName( "selectCertificate()" );
		return false;
	}

	return bReturn;
}

function clearCertificateInfo( strCertID )
{
	if ( strCertID == null || strCertID == "" )
	{
		setErrorCode( "NO_USER_ID" );
		setErrorMessage( "" );
		setErrorFunctionName( "clearCertificateInfo()" );
		return false;
	}
	SetSessionID( strCertID );
	UnloadUserKeyCert();

	return true;
}

function reselectCertificate( strCertID )
{
	clearCertificateInfo( strCertID );
	return selectCertificate( strCertID );
}

function getUserSignCert( strCertID )
{
	var bReturn = selectCertificate( strCertID );
	if ( !bReturn )
	{
		setErrorFunctionName( "getUserSignCert()" );
		return "";
	}
	
	var strCert = GetUserSignCert();
	if ( strCert == "" )
	{
		setErrorFunctionName( "getUserSignCert()" );
		return "";
	}

	return strCert;
}

function getUserKMCert( strCertID )
{
	var bReturn = selectCertificate( strCertID );
	if ( !bReturn )
	{
		setErrorFunctionName( "getUserKMCert()" );
		return "";
	}
	
	var strCert = GetUserKMCert();
	if ( strCert == "" )
	{
		setErrorFunctionName( "getUserKMCert()" );
		return "";
	}

	return strCert;	
}

function getUserKMKey( strCertID )
{
	var bReturn = selectCertificate( strCertID );
	if ( !bReturn )
	{
		setErrorFunctionName( "getUserKMKey()" );
		return "";
	}
	
	var strKey = GetUserKMKey();
	if ( strKey == "" )
	{
		setErrorFunctionName( "getUserKMKey()" );
		return "";
	}

	return strKey;
}

function getUserKMKeyWithNewPassword( strCertID, strNewPassword )	//	Added 2005.08.03
{
	var bReturn = selectCertificate( strCertID );
	if ( !bReturn )
	{
		setErrorFunctionName( "getUserKMKeyWithNewPassword()" );
		return "";
	}
	
	var strKey = GetUserKMKeyWithNewPassword( strNewPassword );
	if ( strKey == "" )
	{
		setErrorFunctionName( "getUserKMKeyWithNewPassword()" );
		return "";
	}

	return strKey;
}

function getUserPassword( strCertID )	//	Modified 2005.11.04
{
	return "지원되지 않는 기능입니다.";
}

function getCertPath( strCertID )
{
	var bReturn = selectCertificate( strCertID );
	if ( !bReturn )
	{
		setErrorFunctionName( "getCertPath()" );
		return "";
	}
	
	var strCertPath = GetCertPath();
	if ( strCertPath == "" )
	{
		setErrorFunctionName( "getCertPath()" );
		return "";
	}

	return strCertPath;	
}

function getCertSerialNumber( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertSerialNumber()" );
		return -1;
	}

	// 20061114, modified by ojpark
	//var nSerial = GetSerialNumberFromCert( strCert );
	//if ( nSerial < 0 )
	var nSerial = GetCertInfoFromCert( strCert, 2 );
	if ( nSerial == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertSerialNumber()" );
		return -1;
	}

	return nSerial;
}

function getCertSubjectDN( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertSubjectDN()" );
		return "";
	}

	var buf = GetSubjectDNFromCert( strCert );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertSubjectDN()" );
		return "";
	}
	
	return buf;
}

function getCertIssuerDN( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertIssuerDN()" );
		return "";
	}

	var buf = GetCertInfoFromCert( strCert, 4 );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertIssuerDN()" );
		return "";
	}
	
	return buf;
}

function getCertNotBefore( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertNotBefore()" );
		return "";
	}

	var buf = GetCertInfoFromCert( strCert, 5 );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertNotBefore()" );
		return "";
	}
	
	return buf;
}

function getCertNotAfter( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertNotAfter()" );
		return "";
	}

	var buf = GetCertInfoFromCert( strCert, 6 );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertNotAfter()" );
		return "";
	}
	
	return buf;
}

function getCertPublicKey( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertPublicKey()" );
		return "";
	}

	var buf = GetCertInfoFromCert( strCert, 8 );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertPublicKey()" );
		return "";
	}
	
	return buf;
}

function getCertKeyUsage( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertKeyUsage()" );
		return "";
	}

	var buf = GetCertInfoFromCert( strCert, 9 );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertKeyUsage()" );
		return "";
	}
	
	return buf;
}

function getCertPolicy( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertPolicy()" );
		return "";
	}

	var buf = GetCertInfoFromCert( strCert, 10 );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertPolicy()" );
		return "";
	}
	
	return buf;
}

function getCertInfo( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertInfo()" );
		return "";
	}

	var buf = GetCertInfoFromCert( strCert, 0 );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertInfo()" );
		return "";
	}
	
	return buf;
}

function checkCertValidity( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "checkCertValidity()" );
		return false;
	}

	SetCertPolicy( "ANY" );
	var bReturn = ValidateCert( strCert );
	if ( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "checkCertValidity()" );
		return false;
	}

	return bReturn;
}

function getRandomNumber( strCertID )
{
	var bReturn = selectCertificate( strCertID );
	if ( !bReturn )
	{
		setErrorFunctionName( "getRandomNumber()" );
		return "";
	}

	var strRandomNumber = GetUserKeyRNumber();
	if ( strRandomNumber == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getRandomNumber()" );
		return "";
	}

	return removeCRLF( strRandomNumber );
}

function getEncryptedRandomNumber( strCertID )
{
	var bReturn = selectCertificate( strCertID );
	if ( !bReturn )
	{
		setErrorFunctionName( "getEncryptedRandomNumber()" );
		return "";
	}

	var strRandomNumber = GetUserKeyRNumber();
	if ( strRandomNumber == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getEncryptedRandomNumber()" );
		return "";
	}

	var strEncryptedRandomNumber = encryptDataString( strCertID, strRandomNumber );
	if ( strEncryptedRandomNumber == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getEncryptedRandomNumber()" );
		return "";
	}

	return removeCRLF( strEncryptedRandomNumber );
}

function checkCertOwner( strCert, strSSN, strRandomNumber )	//	Added 2005.11.04
{
	if ( strCert == null || strCert == "" || strSSN == null || strSSN == "" || strRandomNumber == null || strRandomNumber == ""  )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "checkCertOwner()" );
		return false;
	}

	var bReturn = CheckCertOwner( strCert, strSSN, strRandomNumber )
	if ( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "checkCertOwner()" );
		return false;
	}

	return true;
}

// 20061106, by ojpark for gpki
function getCertPublicKeyAlgo( strCert )
{
	if ( strCert == null || strCert == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getCertPolicy()" );
		return "";
	}

	var buf = GetCertInfoFromCert( strCert, 11 );
	if ( buf == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getCertPolicy()" );
		return "";
	}
	
	return buf;
}