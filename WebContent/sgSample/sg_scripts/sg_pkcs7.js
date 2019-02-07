//*************************************************************************************
//	파일명		: sg_pkcs7.js
//	작성자		: 김창기
//	최초 작성일	: 2003년  8월  7일
//	최종 수정자	: 박옥자
//	최종 수정일	: 2006년 11월 14일
//*************************************************************************************

var nSignerCount = 0;

function generatePKCS7SignedMsg( strCertID, strMessage )
{
	if ( strMessage == null || strMessage == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7SignedMsg()" );
		return "";
	}

	var bReturn = selectCertificate( strCertID );
	if( !bReturn )
	{
		setErrorFunctionName( "generatePKCS7SignedMsg()" );
		return "";
	}

	// 20061114, modified by ojpark
	var strPKCS7Message = GeneratePKCS7MsgSG( 1, strMessage, "", "" );
	if( strPKCS7Message == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "generatePKCS7SignedMsg()" );
		return "";
	}

	return strPKCS7Message;
}

function generatePKCS7SignedFile( strCertID, strInputFilePath, strOutputFilePath )
{
	if ( strInputFilePath == null || strInputFilePath == ""
		|| strOutputFilePath == null || strOutputFilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7SignedFile()" );
		return false ;
	}

	var bReturn = selectCertificate( strCertID );
	if( !bReturn )
	{
		setErrorFunctionName( "generatePKCS7SignedFile()" );
		return false;
	}

	// 20061114, modified by ojpark
	bReturn = GeneratePKCS7MsgFileSG( 1, strInputFilePath, "", "", strOutputFilePath );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "generatePKCS7SignedFile()" );
		return false;
	}

	return bReturn;
}

function addPKCS7SignMsg( strCertID, strP7Msg )
{
	if( strP7Msg == null || strP7Msg == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "addPKCS7SignMsg()" );
		return "";
	}

	var bReturn = selectCertificate( strCertID );
	if( !bReturn )
	{
		setErrorFunctionName( "addPKCS7SignMsg()" );
		return "";
	}

	var strPKCS7Message = AddPKCS7Signature( strP7Msg );
	if( strPKCS7Message == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "addPKCS7SignMsg()" );
		return "";
	}

	return strPKCS7Message;
}

function addPKCS7SignFile( strCertID, strP7FilePath, strOutputFilePath )
{
	if ( strP7FilePath == null || strP7FilePath == ""
		|| strOutputFilePath == null || strOutputFilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "addPKCS7SignFile()" );
		return false;
	}

	var bReturn = selectCertificate( strCertID );
	if( !bReturn )
	{
		setErrorFunctionName( "addPKCS7SignFile()" );
		return false;
	}

	bReturn = AddPKCS7SignatureFile( strP7FilePath, strOutputFilePath );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "addPKCS7SignFile()" );
		return false;
	}

	return bReturn;
}

function generatePKCS7EnvelopedMsg( strMessage, strMyCert, strRecipientCert )
{
	if ( strMessage == null || strMessage == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7EnvelopedMsg()" );
		return "" ;
	}

	if ( ( strMyCert == null || strMyCert == "" ) && 
		( strRecipientCert == null || strRecipientCert == "" ) )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7EnvelopedMsg()" );
		return "" ;
	}

	// 20061114, modified by ojpark
	var strPKCS7Message = GeneratePKCS7MsgSG( 2, strMessage, strMyCert, strRecipientCert );
	if( strPKCS7Message == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "generatePKCS7EnvelopedMsg()" );
		return "" ;
	}

	return strPKCS7Message ;
}

function generatePKCS7EnvelopedFile( strInputFilePath, strMyCert, strRecipientCert, strOutputFilePath )
{
	if ( strInputFilePath == null || strInputFilePath == ""
		|| strOutputFilePath == null || strOutputFilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7EnvelopedFile()" );
		return false;
	}

	if ( ( strMyCert == null || strMyCert == "" ) && 
		( strRecipientCert == null || strRecipientCert == "" ) )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7EnvelopedFile()" );
		return false;
	}

	// 20061114, modified by ojpark
	var bReturn = GeneratePKCS7MsgFileSG( 2, strInputFilePath, strMyCert, strRecipientCert, strOutputFilePath );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "generatePKCS7EnvelopedFile()" );
		return false;
	}

	return bReturn;
}

function generatePKCS7SignedEnvelopedMsg( strCertID, strMessage, strMyCert, strRecipientCert )
{
	if ( strMessage == null || strMessage == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7SignedEnvelopedMsg()" );
		return "" ;
	}

	if ( ( strMyCert == null || strMyCert == "" ) && 
		( strRecipientCert == null || strRecipientCert == "" ) )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7SignedEnvelopedMsg()" );
		return "" ;
	}

	var bReturn = selectCertificate( strCertID );
	if( !bReturn )
	{
		setErrorFunctionName( "generatePKCS7SignedEnvelopedMsg()" );
		return "" ;
	}

	// 20061114, modified by ojpark
	var strPKCS7Message = GeneratePKCS7MsgSG( 3, strMessage, strMyCert, strRecipientCert );
	if( strPKCS7Message == "" )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "generatePKCS7SignedEnvelopedMsg()" );
		return "" ;
	}

	return strPKCS7Message;
}

function generatePKCS7SignedEnvelopedFile( strCertID, strInputFilePath, strMyCert, strRecipientCert, strOutputFilePath )
{
	if ( strInputFilePath == null || strInputFilePath == ""
		|| strOutputFilePath == null || strOutputFilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7SignedEnvelopedFile()" );
		return false;
	}

	if ( ( strMyCert == null || strMyCert == "" ) && 
		( strRecipientCert == null || strRecipientCert == "" ) )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "generatePKCS7SignedEnvelopedFile()" );
		return false;
	}

	var bReturn = selectCertificate( strCertID );
	if( !bReturn )
	{
		setErrorFunctionName( "generatePKCS7SignedEnvelopedFile()" );
		return false;
	}

	// 20061114, modified by ojpark
	bReturn = GeneratePKCS7MsgFileSG( 3, strInputFilePath, strMyCert, strRecipientCert, strOutputFilePath );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "generatePKCS7SignedEnvelopedFile()" );
		return false;
	}

	return bReturn;
}

function verifyPKCS7SignedMsg( strP7Msg )
{
	if( strP7Msg == null || strP7Msg == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "verifyPKCS7SignedMsg()" );
		return "";
	}

	var strOriginalMessage = VrfPKCS7Msg( strP7Msg );
	if( strOriginalMessage == "")
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "verifyPKCS7SignedMsg()" );
		nSignerCount = 0;
		return "";
	}
	else
	{
		nSignerCount = GetPKCS7SignInfo( strP7Msg );
	}

	return strOriginalMessage;
}

function verifyPKCS7EnvelopedMsg( strCertID, strP7Msg )
{
	if( strP7Msg == null || strP7Msg == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "verifyPKCS7EnvelopedMsg()" );
		return "";
	}

	var bReturn = selectCertificate( strCertID );
	if( !bReturn )
	{
		setErrorFunctionName( "verifyPKCS7EnvelopedMsg()" );
		return "";
	}

	var strOriginalMessage = VrfPKCS7Msg( strP7Msg );
	if( strOriginalMessage == "")
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "verifyPKCS7EnvelopedMsg()" );
		nSignerCount = 0;
		return "";
	}
	else
	{
		nSignerCount = GetPKCS7SignInfo( strP7Msg );
	}

	return strOriginalMessage;
}

function verifyPKCS7SignedFile( strP7FilePath, strOutputFilePath )
{
	if( strP7FilePath == null || strP7FilePath == ""
		|| strOutputFilePath == null || strOutputFilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "verifyPKCS7SignedFile()" );
		return false;
	}

	var bReturn = VrfPKCS7MsgFile( strP7FilePath, strOutputFilePath );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "verifyPKCS7SignedFile()" );
		nSignerCount = 0;
		return false;
	}
	else
	{
		nSignerCount = GetPKCS7SignInfoFile( strP7FilePath );
	}

	return bReturn;
}

function verifyPKCS7EnvelopedFile( strCertID, strP7FilePath, strOutputFilePath )
{
	if( strP7FilePath == null || strP7FilePath == ""
		|| strOutputFilePath == null || strOutputFilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "verifyPKCS7EnvelopedFile()" );
		return false;
	}

	var bReturn = selectCertificate( strCertID );
	if( !bReturn )
	{
		setErrorFunctionName( "verifyPKCS7EnvelopedFile()" );
		return false;
	}

	var bReturn = VrfPKCS7MsgFile( strP7FilePath, strOutputFilePath );
	if( !bReturn )
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "verifyPKCS7EnvelopedFile()" );
		nSignerCount = 0;
		return false;
	}
	else
	{
		nSignerCount = GetPKCS7SignInfoFile( strP7FilePath );
	}

	return bReturn;
}

function getPKCS7SignerCount( )
{
	return nSignerCount;
}

function getPKCS7SignerCert( nIndex )
{
	if( isNaN( nIndex) )
	{
		setErrorCode("NOT_INDEX_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getPKCS7SignerCert()" );
		return "" ;
	}

	var strSignerCert = GetPKCS7SignCert( nIndex );
	if( strSignerCert == "")
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getPKCS7SignerCert()" );
		return "" ;
	}

	return strSignerCert;
}

function getPKCS7SigningTime( nIndex )
{
	if( isNaN( nIndex) )
	{
		setErrorCode("NOT_INDEX_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getPKCS7SigningTime()" );
		return "" ;
	}

	var strTimestamp = GetPKCS7SignTime( nIndex );
	if( strTimestamp == "")
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getPKCS7SigningTime()" );
		return "" ;
	}

	return strTimestamp;
}

function clearPKCS7MessageInfo()
{
	nSignerCount = 0;
	ClearPKCS7SignInfo();
	return;
}

function getPKCS7TypeMsg( strP7Msg )
{
	if( strP7Msg == null || strP7Msg == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getPKCS7TypeMsg()" );
		return "" ;
	}

	var strType = "";
	
	var nType = GetPKCS7MessageType( strP7Msg );
	if ( nType == 1 )
	{
		strType = "PKCS7SignedMessage";
	}
	else if ( nType == 2 )
	{
		strType = "PKCS7EnvelopedMessage";
	}
	else if ( nType == 3 )
	{
		strType = "PKCS7SignedAndEnvelopedMessage";
	}
	else
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getPKCS7TypeMsg()" );
		return "" ;
	}
	
	return strType;
}

function getPKCS7TypeFile( strP7FilePath )
{
	if( strP7FilePath == null || strP7FilePath == "" )
	{
		setErrorCode("NO_DATA_VALUE");
		setErrorMessage( "" );
		setErrorFunctionName( "getPKCS7TypeFile()" );
		return "" ;
	}

	var strType = "";

	var nType = GetPKCS7MessageTypeFile( strP7FilePath );
	if ( nType == 1 )
	{
		strType = "PKCS7SignedMessage";
	}
	else if ( nType == 2 )
	{
		strType = "PKCS7EnvelopedMessage";
	}
	else if ( nType == 3 )
	{
		strType = "PKCS7SignedAndEnvelopedMessage";
	}
	else
	{
		setErrorCode( "" );
		setErrorMessage( GetLastErrMsg() );
		setErrorFunctionName( "getPKCS7TypeFile()" );
		return "" ;
	}
	
	return strType;
}
