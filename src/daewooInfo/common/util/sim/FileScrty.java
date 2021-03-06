/**
 *  Class Name : EgovFileScrty.java
 *  Description : Base64인코딩/디코딩 방식을 이용한 데이터를 암호화/복호화하는 Business Interface class
 *  Modification Information
 * 
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.02.04    박지욱          최초 생성
 *
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 02. 04
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
package daewooInfo.common.util.sim;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.security.MessageDigest;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


//import com.initech.safedb.SimpleSafeDB;
//import com.initech.safedb.common.SafeDBException;

public class FileScrty {

    // 파일구분자
    static final char FILE_SEPARATOR = File.separatorChar;
    
    static final int BUFFER_SIZE = 1024;

    /**
     * 파일을 암호화하는 기능
     * 
     * @param String source 암호화할 파일
     * @param String target 암호화된 파일
     * @return boolean result 암호화여부 True/False
     * @exception Exception
     */
    public static boolean encryptFile(String source, String target) throws Exception {

	// 암호화 여부
	boolean result = false;

	String sourceFile = source.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
	String targetFile = target.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
	File srcFile = new File(sourceFile);
	
	BufferedInputStream input = null;
	BufferedOutputStream output = null;
	
	byte[] buffer = new byte[BUFFER_SIZE];
	
	try {
	    if (srcFile.exists() && srcFile.isFile()) {
		
		input = new BufferedInputStream(new FileInputStream(srcFile));
		output = new BufferedOutputStream(new FileOutputStream(targetFile));
		
		int length = 0;
		while ((length = input.read(buffer)) >= 0) {
		    byte[] data = new byte[length];
		    System.arraycopy(buffer, 0, data, 0, length);
		    output.write(encodeBinary(data).getBytes());
		    output.write(System.getProperty("line.separator").getBytes());
		}
		
		result = true;
	    }
	} catch (Exception ex) {
	    ex.printStackTrace();
	} finally {
	   if (input != null) {
	       try {
		   input.close();
	       } catch (Exception ignore) {
		   // no-op
	           ignore.printStackTrace();
	       }
	   }
	   if (output != null) {
	       try {
		   output.close();
	       } catch (Exception ignore) {
		   // no-op
	           ignore.printStackTrace();
	       }
	   }
	}
	return result;
    }

    /**
     * 파일을 복호화하는 기능
     * 
     * @param String source 복호화할 파일
     * @param String target 복호화된 파일
     * @return boolean result 복호화여부 True/False
     * @exception Exception
     */
    public static boolean decryptFile(String source, String target) throws Exception {

	// 복호화 여부
	boolean result = false;

	String sourceFile = source.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
	String targetFile = target.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
	File srcFile = new File(sourceFile);

	BufferedReader input = null;
	BufferedOutputStream output = null;
	
	//byte[] buffer = new byte[BUFFER_SIZE];
	String line = null;
	
	try {
	    if (srcFile.exists() && srcFile.isFile()) {
		
		input = new BufferedReader(new InputStreamReader(new FileInputStream(srcFile)));
		output = new BufferedOutputStream(new FileOutputStream(targetFile));
		
		while ((line = input.readLine()) != null) {
		    byte[] data = line.getBytes();
		    output.write(decodeBinary(new String(data)));
		}
		
		result = true;
	    }
	} catch (Exception ex) {
	    ex.printStackTrace();
	} finally {
	   if (input != null) {
	       try {
		   input.close();
	       } catch (Exception ignore) {
		   // no-op
	           ignore.printStackTrace();
	       }
	   }
	   if (output != null) {
	       try {
		   output.close();
	       } catch (Exception ignore) {
		   // no-op
	           ignore.printStackTrace();
	       }
	   }
	}
	return result;
    }

    /**
     * 데이터를 암호화하는 기능
     * 
     * @param byte[] data 암호화할 데이터
     * @return String result 암호화된 데이터
     * @exception Exception
     */
    public static String encodeBinary(byte[] data) throws Exception {
	if (data == null) {
	    return "";
	}

	return new String(Base64.encodeBase64(data));
    }
    
    /**
     * 데이터를 암호화하는 기능
     * 
     * @param String data 암호화할 데이터
     * @return String result 암호화된 데이터
     * @exception Exception
     */
    public static String encode(String data) throws Exception {
	return encodeBinary(data.getBytes());
    }
    
    /**
     * 데이터를 복호화하는 기능
     * 
     * @param String data 복호화할 데이터
     * @return String result 복호화된 데이터
     * @exception Exception
     */
    public static byte[] decodeBinary(String data) throws Exception {
	return Base64.decodeBase64(data.getBytes());
    }

    /**
     * 데이터를 복호화하는 기능
     * 
     * @param String data 복호화할 데이터
     * @return String result 복호화된 데이터
     * @exception Exception
     */
    public static String decode(String data) throws Exception {
	return new String(decodeBinary(data));
    }

    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 MD5 인코딩 방식 적용)
     * 
     * @param String data 암호화할 비밀번호
     * @return String result 암호화된 비밀번호
     * @exception Exception
     */
    public static String encryptPassword(String data) throws Exception {
    	
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

//    	if(request.getRequestURL().indexOf("10.101.213.48") > -1 || request.getRequestURL().indexOf("10.101.164.196") > -1 || request.getRequestURL().indexOf("10.101.164.228") > -1|| request.getRequestURL().indexOf("10.101.164.236") > -1){
    		return encryptPasswordlocal(data);
//    	}else{
//    		return encryptPasswordserver(data);
//    	}
    }
    
    public static String encryptPasswordlocal(String data) throws Exception {
    	
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	
		if (data == null) {
		    return "";
		}
	
		byte[] plainText = null; // 평문
		byte[] hashValue = null; // 해쉬값
		plainText = data.getBytes();
	
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		hashValue = md.digest(plainText);
	
		/*
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(hashValue);
		*/
		return new String(Base64.encodeBase64(hashValue));
    }

    /**
     * 서버에 적용하면 됨..
     * 
     * @param String data 암호화할 비밀번호
     * @return String result 암호화된 비밀번호
     * @exception Exception
     * 
     */
    public static String encryptPasswordserver(String data) throws Exception {

    	
		if (data == null) {
		    return "";
		}
		String safedbuserid = "SAFEDB";
		String table = "SAFEDB.POLICY"; //암복호화 정책 테이블명 ( 논리적 )
	    String col = "PASSWORD" ;

	    try{
	    	byte[] enc;

//			import com.initech.safedb.SimpleSafeDB;
//			import com.initech.safedb.common.SafeDBException;
			com.initech.safedb.SimpleSafeDB ssdb = com.initech.safedb.SimpleSafeDB.getInstance();
	    	
	    	byte[] plain = data.getBytes();
            //SimpleSafeDB ssdb = SimpleSafeDB.getInstance("C:\\SafeDBAccess.properties");
            if(ssdb.login()){  		    	
		      //String data = "INITECHTEST1234567890!@#$^&*()-=_+|";
		     // System.out.println("[POLICY ] : ["+table+"] ["+colarr+"]");
		       enc = ssdb.encrypt(safedbuserid,table, col, plain);
		     // System.out.println("[ENC    ] : ["+enc+"]");
		      //String dec = decrypt(table, colarr, enc);
		      //System.out.println("[DEC    ] : ["+dec+"]");
		      //System.out.println("");
		       return new String(enc);
            }	
            
	
	    }catch(Exception ex){
	        ex.printStackTrace();
	    }
	    return null;
    }
        
    
    public String encrypt(String tablename, String columnname, String data) throws Exception
    {
    	com.initech.safedb.SimpleSafeDB ssdb = com.initech.safedb.SimpleSafeDB.getInstance();

    	String safedbuserid = "SAFEDB";//safedb유저ID

    	if(ssdb.login())
        {
        	byte[] plainData = data.getBytes();
            byte[] encryptedData = ssdb.encrypt(safedbuserid, tablename, columnname, plainData);
            return new String(encryptedData);
        } 
        return null;
    }  
    
    public String decrypt(String tablename, String columnname, String data) throws Exception
    {
    	com.initech.safedb.SimpleSafeDB ssdb = com.initech.safedb.SimpleSafeDB.getInstance();
       	//SimpleSafeDB ssdb = SimpleSafeDB.getInstance("C:\\SafeDBAccess.properties");

        String safedbuserid = "SAFEDB";//safedb유저ID

     	if(ssdb.login())
     	{                                 
    	  byte[] encryptedData = data.getBytes();                                                                       
          byte[] decryptedData = ssdb.decrypt(safedbuserid, tablename, columnname, encryptedData);
          return new String(decryptedData);
        }
        return null;
    }           
}
