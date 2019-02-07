//*************************************************************************************
//	파일명		: sg_encrypt.js
//	작성자		: 고영주
//	최초 작성일	: 2003년 8월 6일
//	최종 수정자	: 박옥자
//	최종 수정일	: 2006년 9월 20일
//*************************************************************************************

function encryptSessionKey( strKeyID, strKmCert )
{
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode( "NO_USER_ID" );
		setErrorMessage( "" );
		setErrorFunctionName( "encryptSessionKey()" );
		return "";
	}

	if ( strKmCert == null || strKmCert == "")
	{
		setErrorCode("NO_DATA_VALUE : KmCert");
		setErrorMessage("");
		setErrorFunctionName( "encryptSessionKey()" );
		return "";
	}

	// 20060920, modified by ojpark
	var bReturn = GenSymmetricKeySG( strKeyID );
	if ( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "encryptSessionKey()" );
		return "";
	}
	
	// 20060920, modified by ojpark
	var strEncryptedSessionKey = GetEncryptSymmetricKeySG( strKeyID, strKmCert );
 	if ( strEncryptedSessionKey == "" )
   	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "encryptSessionKey()" );
		return "";
  	}

        return removeCRLF( strEncryptedSessionKey );
}

function decryptSessionKey( strKeyID, strEncryptedSessionKey )
{
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode( "NO_USER_ID" );
		setErrorMessage( "" );
		setErrorFunctionName( "decryptSessionKey()" );
		return false;
	}

	if ( strEncryptedSessionKey == null || strEncryptedSessionKey == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "decryptSessionKey()" );
		return false;
	}

	var bReturn = selectCertificate( strKeyID );
	if ( !bReturn )
	{
		setErrorFunctionName( "decryptSessionKey()" );
		return false;
	}

	// 20060920, modified by ojpark
	bReturn = SetDecryptSymmetricKeySG( strKeyID, strEncryptedSessionKey );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "decryptSessionKey()" );
        	return false;
    }

	return true;
}

// 20060920, added by ojpark
function decryptSessionKeyEx( strCertID, strKeyID, strEncryptedSessionKey )
{
	if ( strCertID == null || strCertID == "" )
	{
		setErrorCode( "NO_USER_ID" );
		setErrorMessage( "" );
		setErrorFunctionName( "decryptSessionKey()" );
		return false;
	}
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode( "NO_KEY_ID" );
		setErrorMessage( "" );
		setErrorFunctionName( "decryptSessionKey()" );
		return false;
	}
	if ( strEncryptedSessionKey == null || strEncryptedSessionKey == "" )
	{
		setErrorCode("NO_DATA_VALUE : EncryptedSessionKey");
		setErrorMessage( "" );
		setErrorFunctionName( "decryptSessionKey()" );
		return false;
	}

	var bReturn = selectCertificate( strCertID );
	if ( !bReturn )
	{
		setErrorFunctionName( "decryptSessionKey()" );
		return false;
	}

	bReturn = SetDecryptSymmetricKeySG( strKeyID, strEncryptedSessionKey );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "decryptSessionKey()" );
        	return false;
    }

	return true;
}

function encryptDataString( strKeyID, strMessage )
{
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode( "NO_KEY_ID" );
		setErrorMessage( "" );
		setErrorFunctionName( "encryptDataString()" );
		return "";
	}

	if ( strMessage == null || strMessage == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage("");
		setErrorFunctionName( "encryptDataString()" );
		return "";
	}

	// 20060920, modified by ojpark
	var strEncryptedData = EncryptDataSG( strKeyID, strMessage );
	if ( strEncryptedData == "" )
	{                                                                    
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "encryptDataString()" );
		return "";
	}

	return removeCRLF( strEncryptedData );
}

function decryptDataString( strKeyID, strEncryptedMessage )
{
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode("NO_KEY_ID");
		setErrorMessage( "" );
		setErrorFunctionName( "decryptDataString()" );
		return "";
	}

	if ( strEncryptedMessage == null || strEncryptedMessage == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage("");
		setErrorFunctionName( "decryptDataString()" );
		return "";
	}

	// 20060920, modified by ojpark
	var strDecryptedData = DecryptDataSG( strKeyID, strEncryptedMessage );
	if ( strDecryptedData == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "decryptDataString()" );
		return "";
	}

	return strDecryptedData;
}

function encryptDataFile( strKeyID, strInputFilePath, strOutputFilePath )
{
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode("NO_KEY_ID");
		setErrorMessage( "" );
		setErrorFunctionName( "encryptDataFile()" );
		return false;
	}

	if ( strInputFilePath == null || strInputFilePath == ""
		|| strOutputFilePath == null || strOutputFilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage("");
		setErrorFunctionName( "encryptDataFile()" );
		return false;
	}

	// 20060920, modified by ojpark
	bReturn = EncryptFileSG( strKeyID, strInputFilePath, strOutputFilePath );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "encryptDataFile()" );
		return false;
	}

	return bReturn;
}

function decryptDataFile( strKeyID, strInputFilePath, strOutputFilePath )
{
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode("NO_KEY_ID");
		setErrorMessage( "" );
		setErrorFunctionName( "decryptDataFile()" );
		return false;
	}

	if ( strInputFilePath == null || strInputFilePath == ""
		|| strOutputFilePath == null || strOutputFilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage("");
		setErrorFunctionName( "decryptDataFile()" );
		return false;
	}

	// 20060920, modified by ojpark
	var bReturn = DecryptFileSG( strKeyID, strInputFilePath, strOutputFilePath );
        if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "decryptDataFile()" );
		return false;
	}

	return bReturn;
}

function clearSymmetricKey( strKeyID )
{
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode("NO_KEY_ID");
		setErrorMessage( "" );
		setErrorFunctionName( "clearSymmetricKey()" );
		return false;
	}

	// 20060920, modified by ojpark
	var bReturn = ClearSymmetricKeySG( strKeyID );
    if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "clearSymmetricKey()" );
		return false;
	}
	return bReturn;
}

// 20060920, added by ojpark
function setBase64SymmetricKeyIV( strKeyID, strB64SymKey, strB64IV )
{
	if ( strKeyID == null || strKeyID == "" )
	{
		setErrorCode( "NO_KEY_ID" );
		setErrorMessage( "" );
		setErrorFunctionName( "setBase64SymmetricKeyIV()" );
		return false;
	}
	if ( strB64SymKey == null || strB64SymKey == "" 
		|| strB64IV == null || strB64IV == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "setBase64SymmetricKeyIV()" );
		return false;
	}

	bReturn = SetB64SymmetricKeySG( strKeyID, strB64SymKey, strB64IV );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "setBase64SymmetricKeyIV()" );
        	return false;
    }

	return true;
}