//*************************************************************************************
//	파일명		: sg_basic.js
//	작성자		: 안재형
//	최초 작성일	: 2003년 7월 21일
//	최종 수정자	: 박옥자
//	최종 수정일	: 2007년 8월 7일
//*************************************************************************************

var bUseKMCert;
var strHashAlg;
var bCryptoToolkitInstalled = true;

// 20060920, added by ojpark, for ARIA
var strEncryptAlg;
var szEncryptKeyLen;

//*************************************************************************************
//	이름	: initCryptoApi()
//	기능	: SignGATE2 Toolkit Java Script를 사용하기 위해서 필요한 초기화 설정을 한다.
//		  필요에 따라서 적절한 설정 값을 갖도록 수정하여 사용할 수 있으며, 자동으로 호출된다.
//*************************************************************************************
function initCryptoApi() {
	bUseKMCert = true;
	strHashAlg = "SHA1";	
	strEncryptAlg = "SEED-CBC"	// SEED-CBC or ARIA-CBC		: 대칭키 알고리즘
	szEncryptKeyLen = 16;		// SEED(16), ARIA(16/24/32) : 대칭키 길이
	if ( bCryptoToolkitInstalled )
	{
		SetCertDialogImage( "C:/Tomcat5/webapps/ROOT/ews/images/security.bmp" );
		SetCAInfo( 0 );
	}
	return;
}

//*************************************************************************************
//	이름	: cryptoToolkitNotInstalled()
//	기능	: 클라이언트 툴킷이 정상적으로 설치되지 않았을 때 호출되는 함수로
//		  필요에 따라서 툴킷 설치 페이지로 이동하도록 하거나, 
//		  적절한 메세지를 보여주도록 수정하여 사용할 수 있다.
//*************************************************************************************
function cryptoToolkitNotInstalled() {
	bCryptoToolkitInstalled = false;
	if ( confirm( '보안 소프트웨어가 설치되지 않았습니다. 보안 프로그램을 수동으로 설치하시겠습니까?\n\n확인을 누르시면 파일 다운로드 창이 열립니다.\n저장 버튼을 누르시어 보안 소프트웨어 설치 프로그램을 바탕화면에 저장하신 다음에,\n열려있는 웹 브라우저를 모두 닫으신 후에 실행시켜 주십시오.' ))
	{
		location.href = "http://download.signgate.com/download/ews/ewsinstaller_full.exe";
	}
	return;
}

//*************************************************************************************
//	이하의 함수들은 예고 없이 변경될 수 있으므로,
//	응용프로그램 코드에서 절대로 직접 호출하여 사용하여서는 안됩니다!!
//*************************************************************************************
document.write('<object classid="clsid:9FC84F7D-D177-4A75-A7BB-429DA5BD0A3E" style="display: none;" onError="javascript:cryptoToolkitNotInstalled();" onReadyStateChange="javascript:initCryptoApi()" id="SG_ATL"> </object>' );

//document.write('<OBJECT id="SG_ATL" ');
//document.write('classid="CLSID:9FC84F7D-D177-4A75-A7BB-429DA5BD0A3E" ');
//document.write('codebase="./cab/ewsinstaller_full.cab#version=3,1,4,0" ');
//document.write('VIEWASTEXT onError="javascript:cryptoToolkitNotInstalled();" onReadyStateChange="javascript:initCryptoApi()" style="display: none;"> ');
//document.write('</OBJECT> ');

function SetCAInfo( CACode )
{
	SG_ATL.SetCAInfo( CACode );
	return;
}

function SetSessionID( SessionID )
{
	SG_ATL.SetSessionID( SessionID );
	return;
}

function LoadUserKeyCertDlg( UseKMCert )
{
	return SG_ATL.LoadUserKeyCertDlg( UseKMCert );
}

function UnloadUserKeyCert()
{
	SG_ATL.UnloadUserKeyCert();
	return;
}

function GetUserSignCert()
{
	return SG_ATL.GetUserSignCert();
}

function GetUserKMCert()
{
	return SG_ATL.GetUserKMCert();
}

function GetUserKMKey()
{
	return SG_ATL.GetUserKMKey( "" );
}

function GetUserKMKeyWithNewPassword( strNewPassword )	//	Added 2005.08.03
{
	return SG_ATL.GetUserKMKey( strNewPassword );
}

function GetCertPath()
{
	return SG_ATL.GetCertPath();
}

function GetUserPassword()
{
	return SG_ATL.GetUserPassword();
}

function GetSubjectDNFromCert( Cert )
{
	return SG_ATL.GetSubjectDNFromCert( Cert );
}

function GetSerialNumberFromCert( Cert )
{
	return SG_ATL.GetSerialNumberFromCert( Cert );
}

function GetCertInfoFromCert( Cert, index )
{
	return SG_ATL.GetCertInfoFromCert( Cert, index );
}

function SetCertPolicy( Policies )
{
	SG_ATL.SetCertPolicy( Policies );
	return;
}

function ValidateCert( Cert )
{
	return SG_ATL.ValidateCert( Cert );
}

function GetUserKeyRNumber()
{
	return SG_ATL.GetUserKeyRNumber();
}

function CheckCertOwner( Cert, SSN, RNumber )
{
	return SG_ATL.CheckCertOwner( Cert, SSN, RNumber );
}

function GenPKCS7SignedMsg( InData )
{
	return SG_ATL.GenPKCS7SignedMsg( InData );
}

function GenPKCS7SignedMsgFile( InFile, OutFile )
{
	return SG_ATL.GenPKCS7SignedMsgFile( InFile, OutFile );
}

function AddPKCS7Signature( InData )
{
	return SG_ATL.AddPKCS7Signature( InData );
}

function AddPKCS7SignatureFile( InFile, OutFile )
{
	return SG_ATL.AddPKCS7SignatureFile( InFile, OutFile );
}

function GenPKCS7EnvelopedMsg( InData, MyCert, RcvCert )
{
	return SG_ATL.GenPKCS7EnvelopedMsg( InData, MyCert, RcvCert );
}

function GenPKCS7EnvelopedMsgFile( InFile, MyCert, RcvCert, OutFile )
{
	return SG_ATL.GenPKCS7EnvelopedMsgFile( InFile, MyCert, RcvCert, OutFile );
}

function GenPKCS7SignedEnvelopedMsg( InData, MyCert, RcvCert )
{
	return SG_ATL.GenPKCS7SignedEnvelopedMsg( InData, MyCert, RcvCert );
}

function GenPKCS7SignedEnvelopedMsgFile( InFile, MyCert, RcvCert, OutFile )
{
	return SG_ATL.GenPKCS7SignedEnvelopedMsgFile( InFile, MyCert, RcvCert, OutFile );
}

function VrfPKCS7Msg( InData )
{
	return SG_ATL.VrfPKCS7Msg( InData );
}

function VrfPKCS7MsgFile( InFile, OutFile )
{
	return SG_ATL.VrfPKCS7MsgFile( InFile, OutFile );
}

function GetPKCS7SignInfo( InData )
{
	return SG_ATL.GetPKCS7SignInfo( InData );
}

function GetPKCS7SignInfoFile( InFile )
{
	return SG_ATL.GetPKCS7SignInfoFile( InFile );
}

function GetPKCS7SignCert( index )
{
	return SG_ATL.GetPKCS7SignCert( index );
}

function GetPKCS7SignTime( index )
{
	return SG_ATL.GetPKCS7SignTime( index );
}

function ClearPKCS7SignInfo()
{
	SG_ATL.ClearPKCS7SignInfo();
	return;
}

function GetPKCS7MessageType( InData )
{
	return SG_ATL.GetPKCS7MessageType( InData );
}

function GetPKCS7MessageTypeFile( InFile )
{
	return SG_ATL.GetPKCS7MessageTypeFile( InFile );
}

function GenSignInit()
{
	return SG_ATL.GenSignInit();
}

function GenSignUpdate( InData )
{
	return SG_ATL.GenSignUpdate( InData );
}

function GenSignUpdateFile( InFile )
{
	return SG_ATL.GenSignUpdateFile( InFile );
}

function GenSignFinal()
{
	return SG_ATL.GenSignFinal();
}

function VrfSignInit()
{
	return SG_ATL.VrfSignInit();
}

function VrfSignUpdate( InData )
{
	return SG_ATL.VrfSignUpdate( InData );
}

function VrfSignUpdateFile( InFile )
{
	return SG_ATL.VrfSignUpdateFile( InFile );
}

function VrfSignFinal( Sign, Cert )
{
	return SG_ATL.VrfSignFinal( Sign, Cert );
}

function CheckSymmetricKey()
{
	return SG_ATL.CheckSymmetricKey();
}

function ClearSymmetricKey()
{
	SG_ATL.ClearSymmetricKey();
	return;
}

function GetSymmetricKey( UserID )
{
	return SG_ATL.GetSymmetricKey( UserID );
}

function SetSymmetricKey( UserID )
{
	return SG_ATL.SetSymmetricKey( UserID );
}

function GenSymmetricKey()
{
	return SG_ATL.GenSymmetricKey();
}

function GenCipherSymKey( Cert )
{
	return SG_ATL.GenCipherSymKey( Cert );
}

function EncryptSymKey( Cert )
{
	return SG_ATL.EncryptSymKey( Cert );
}

function DecryptSymKey( CipherSymKey )
{
	return SG_ATL.DecryptSymKey( CipherSymKey );
}

function EncryptData( InData )
{
	return SG_ATL.EncryptData( InData );
}

function EncryptFile( InFile, OutFile )
{
	return SG_ATL.EncryptFile( InFile, OutFile );
}

function DecryptData( InData )
{
	return SG_ATL.DecryptData( InData );
}

function DecryptFile( InFile, OutFile )
{
	return SG_ATL.DecryptFile( InFile, OutFile );
}

function Base64Encode( InData )
{
	return SG_ATL.Base64Encode( InData );
}

function Base64EncodeFile( InFile, OutFile )
{
	return SG_ATL.Base64EncodeFile( InFile, OutFile );
}

function Base64Decode( InData )
{
	return SG_ATL.Base64Decode( InData );
}

function Base64DecodeFile( InFile, OutFile )
{
	return SG_ATL.Base64DecodeFile( InFile, OutFile );
}

function GenHashValue( HashAlg, InData )
{
	return SG_ATL.GenHashValue( HashAlg, InData );
}

function GenHashValueFile( HashAlg, InFile )
{
	return SG_ATL.GenHashValueFile( HashAlg, InFile );
}

function GetLastErrMsg()
{
	return SG_ATL.GetLastErrMsg();
}

function SetCertDialogImage( strImageUrl )
{
	SG_ATL.SetCertDlgImage( strImageUrl );
	return;
}

function FileRead(inFile, TypeFlag)
{
	return SG_ATL.FileUtil(0, inFile, "", TypeFlag );
}

function FileCopy(inFile, outFile)
{
	return SG_ATL.FileUtil(2, inFile, outFile, 0);
}

function FileRename(inFile, outFile)
{
	return SG_ATL.FileUtil(4, inFile, outFile, 0 );
}

function FileChange(inFile, outFile)
{
	return SG_ATL.FileUtil(5, inFile, outFile, 0 );
}

function MakeDir(inFile)
{
	return SG_ATL.FileUtil(6, inFile, "", 0 );
}

function FileUtil(Flag, inFile, outFile, TypeFlag )
{
	return SG_ATL.FileUtil(Flag, inFile, outFile, TypeFlag );
}

function UseSecureKeyInput( code )
{
	SG_ATL.UseSecureKeyInput( code );
	return;
}

function SetKMIParam( code, param1, param2 )
{
	SG_ATL.SetKMIParam( code, param1, param2 );
	return;
}

//*************************************************************************************//
// GPKI & ARIA 추가 함수, 20060920
//*************************************************************************************//
function GenerateDigitalSignatureSG( strInData )
{
	return SG_ATL.GenerateDigitalSignatureSG( strHashAlg, strInData );
}

function VerifyDigitalSignatureSG( strInData, strSignData, signCert )
{
	return SG_ATL.VerifyDigitalSignatureSG( strHashAlg, strInData, strSignData, signCert );
}

function GenerateDigitalSignatureFileSG( InFile )
{
	return SG_ATL.GenerateDigitalSignatureFileSG( strHashAlg, InFile );
}

function VerifyDigitalSignatureFileSG( InFile, strSignData, signCert )
{
	return SG_ATL.VerifyDigitalSignatureFileSG( strHashAlg, InFile, strSignData, signCert );
}

function GenSymmetricKeySG( strKeyID )
{
	return SG_ATL.GenSymmetricKeySG( strKeyID, strEncryptAlg, szEncryptKeyLen );
}

function GetEncryptSymmetricKeySG( strKeyID, kmCert )
{
	return SG_ATL.GetEncryptSymmetricKeySG( strKeyID, kmCert );
}

function SetDecryptSymmetricKeySG( strKeyID, strCipherSymKey )
{
	return SG_ATL.SetDecryptSymmetricKeySG( strKeyID, strCipherSymKey );
}

function GetB64SymmetricKeySG( strKeyID )
{
	return SG_ATL.GetB64SymmetricKeySG( strKeyID );
}

function SetB64SymmetricKeySG( strKeyID, strB64SymKey )
{
	return SG_ATL.SetB64SymmetricKeySG( strKeyID, strB64SymKey );
}

function SetB64SymmetricKeySG( strKeyID, strB64SymKey, strB64IV )
{
	return SG_ATL.SetB64SymmetricKeyExSG( strKeyID, strEncryptAlg, strB64SymKey, strB64IV );
}

function ClearSymmetricKeySG( strKeyID )
{
	return SG_ATL.ClearSymmetricKeySG( strKeyID );
}

function EncryptDataSG( strKeyID, strInData )
{
	// typeFlag(default 1) : 0 (DER type), 1 (Base64Encoded type)
	return SG_ATL.EncryptDataSG( strKeyID, strInData, 1 );
}

function DecryptDataSG( strKeyID, strInData )
{
	// typeFlag(default 1) : 0 (DER type), 1 (Base64Encoded type)
	return SG_ATL.DecryptDataSG( strKeyID, strInData, 1 );
}

function EncryptFileSG( strKeyID, InFile, OutFile )
{
	// typeFlag(default 0) : 0 (DER type), 1 (Base64Encoded type)
	return SG_ATL.EncryptFileSG( strKeyID, InFile, OutFile, 0 );
}

function DecryptFileSG( strKeyID, InFile, OutFile )
{
	// typeFlag(default 0) : 0 (DER type), 1 (Base64Encoded type)
	return SG_ATL.DecryptFileSG( strKeyID, InFile, OutFile, 0 );
}

function EncryptHugeFileSG( strKeyID, InFile, OutFile )
{
	// typeFlag(default 0) : 0 (DER type), 1 (Base64Encoded type)
	return SG_ATL.EncryptHugeFileSG( strKeyID, InFile, OutFile, 0 );
}

function DecryptHugeFileSG( strKeyID, InFile, OutFile )
{
	// typeFlag(default 0) : 0 (DER type), 1 (Base64Encoded type)
	return SG_ATL.DecryptHugeFileSG( strKeyID, InFile, OutFile, 0 );
}

function GeneratePKCS7MsgSG( msgType, strInData, MyCert, RcvCert )
{
	return SG_ATL.GeneratePKCS7MsgSG( msgType, strHashAlg, strEncryptAlg, strInData, MyCert, RcvCert );
}

function GeneratePKCS7MsgFileSG( msgType, InFile, MyCert, RcvCert, OutFile )
{
	return SG_ATL.GeneratePKCS7MsgFileSG( msgType, strHashAlg, strEncryptAlg, InFile, MyCert, RcvCert, OutFile );
}

function SetKMIParamEX( code, param1, param2, param3, param4 )
{
	SG_ATL.SetKMIParamEX( code, param1, param2, param3, param4 );
	return;
}