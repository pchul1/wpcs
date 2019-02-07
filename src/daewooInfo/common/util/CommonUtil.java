package daewooInfo.common.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

public class CommonUtil {

	/**
	 * 오늘과 비교하여 입력받은 날이 입력받은 기간내의 날인가
	 *
	 * @param date
	 *            입력 : 1999-01-01, 1999.01.01, 1999/01/01, 19990101
	 * @param period
	 *            1, 2 (일)
	 * @return
	 */
	public static boolean newIcon(String date, int period) {
		java.util.Date yymmdd = new java.util.Date();
		SimpleDateFormat myformat = new SimpleDateFormat("yyyyMMdd");

		try {

			date = date.replaceAll("-", "");
			date = date.replaceAll("/", "");
			date = date.replaceAll("\\.", "");

			String curdate = myformat.format(yymmdd);

			if (Integer.parseInt(date) >= Integer.parseInt(curdate) - period) {
				return true;
			}
		} catch (Exception e) {
		}

		return false;

	}
	
	public static String[] osName(String userAgent )throws Exception {
		
		String return_value[] = new String[2];
		
		String br = "Unknown";
		String os = "Unknown";
		String osName = "Unknown";
		String browserName = "Unknown";
		String verName = "";
		
		try {
			br = (userAgent.substring(userAgent.indexOf(";") + 1, userAgent.indexOf(";", userAgent.indexOf(";") + 1)).trim());
			os = (userAgent.substring(userAgent.indexOf(";", userAgent.indexOf(br)) + 1, userAgent.indexOf(";", userAgent.indexOf(";", userAgent.indexOf(br)) + 1))).trim();
		} catch (Exception e) {
			br = userAgent;
			os = userAgent;
		}
		
		if (os.indexOf("win") >= 0) {
			osName = "Windows";

			if (os.indexOf("s 3.1") >= 0 || os.indexOf("n3.1") >= 0) {
				verName = "3.1";
			} if (os.indexOf("s 95") >= 0 || os.indexOf("n95") >= 0) {
				verName = "95";
			} if (os.indexOf("s 98") >= 0 || os.indexOf("n98") >= 0) {
				verName = "98";
			} if (os.indexOf("s me") >= 0 || os.indexOf("nme") >= 0) {
				verName = "ME";
			} if (os.indexOf("s nt") >= 0 || os.indexOf("nnt") >= 0) {
				verName = "NT";
			} if ((os.indexOf("s nt") >= 0 || os.indexOf("nnt") >= 0) && (os.indexOf("t 5.0") >= 0 || os.indexOf("2000") >= 0)) {
				verName = "2000";
			} if ((os.indexOf("s nt") >= 0 || os.indexOf("nnt") >= 0) && (os.indexOf("t 5.1") >= 0 || os.indexOf("xp") >= 0)) {
				verName = "XP";
			} if ((os.indexOf("s nt") >= 0 || os.indexOf("nnt") >= 0) && (os.indexOf("t 5.2") >= 0 || os.indexOf("2003") >= 0)) {
				verName = "2003";
			} if ((os.indexOf("s nt") >= 0 || os.indexOf("nnt") >= 0) && (os.indexOf("t 6.0") >= 0 || os.indexOf("vista") >= 0)) {
				verName = "vista";
			} if ((os.indexOf("s nt") >= 0 || os.indexOf("nnt") >= 0) && (os.indexOf("t 6.1") >= 0) ) {
				verName = "7";
			} 
			
			osName = verName.equals("") ? os : osName + " " + verName;
		}
		
		
		if (br.indexOf("msie") >= 0) {
			browserName = "IE";
			if (br.indexOf("msie 9.") >= 0 ) {
				browserName = "IE 9";
			}if (br.indexOf("msie 8.") >= 0 ) {
				browserName = "IE 8";
			}if (br.indexOf("msie 7.") >= 0 ) {
				browserName = "IE 7";
			}if (br.indexOf("msie 6.") >= 0 ) {
				browserName = "IE 6";
			}if (br.indexOf("msie 5.") >= 0 ) {
				browserName = "IE 5";
			}if (br.indexOf("msie 4.") >= 0 ) {
				browserName = "IE 4";
			}
		}
		
		if (br.indexOf("netscape") >= 0) {
			browserName = "Netscape";
			if (br.indexOf("netscape/7") >= 0 ) {
				browserName = "Netscape 7";
			} if (br.indexOf("netscape/6") >= 0 ) {
				browserName = "Netscape 6";
			} 
		}
		
		if (br.indexOf("firefox") >= 0) {
			browserName = "Firefox";
			if (br.indexOf("firefox/1.0") >= 0 ) {
				browserName = "Firefox 1";
			} if (br.indexOf("firefox/1.5") >= 0 ) {
				browserName = "Firefox 1.5";
			} if (br.indexOf("firefox/2") >= 0 ) {
				browserName = "Firefox 2";
			} if (br.indexOf("firefox/3") >= 0 ) {
				browserName = "Firefox 3";
			} if (br.indexOf("firefox/4") >= 0 ) {
				browserName = "Firefox 4";
			} if (br.indexOf("firefox/5") >= 0 ) {
				browserName = "Firefox 5";
			} if (br.indexOf("firefox/6") >= 0 ) {
				browserName = "Firefox 6";
			} 
		}
		
		if (br.indexOf("safari") >= 0) {
			browserName = "Safari";
			if (br.indexOf("safari/5") >= 0 ) {
				browserName = "Safari 5";
			} 
		}
			
		//System.out.println(" osName : " +osName);
		//System.out.println(" browserName : " +browserName);
		
		return_value[0] = osName;
		return_value[1] = browserName;
		
		return return_value;
	}
	
	public static String getCurrentDate(){
		
		/*
		TimeZone tz = TimeZone.getTimeZone("GMT+09:00");
		Date date = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		df.setTimeZone(tz);
		*/
		
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.format(Calendar.getInstance(TimeZone.getTimeZone("GMT+09:00")).getTime());
	}
	
	public static String getCurrentDate(String dateFormat){
		return new SimpleDateFormat(dateFormat)
		.format(Calendar.getInstance(TimeZone.getTimeZone("GMT+09:00")).getTime());
	}
	
	public static ByteArrayOutputStream generateQRCode(String url, String fileType, int size) throws Exception{
		
		// size 140 250 390
		// fileType = "png";
		/*
		Map<EncodeHintType, Object> hintMap = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);
		hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		
		// Now with zxing version 3.2.1 you could change border size (white border size to just 1)
		hintMap.put(EncodeHintType.MARGIN, 1); // default = 4 
		hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);

		QRCodeWriter qrCodeWriter = new QRCodeWriter();
		BitMatrix byteMatrix = qrCodeWriter.encode(url, BarcodeFormat.QR_CODE, size,
				size, hintMap);
		int CrunchifyWidth = byteMatrix.getWidth();
		BufferedImage image = new BufferedImage(CrunchifyWidth, CrunchifyWidth,
				BufferedImage.TYPE_INT_RGB);
		image.createGraphics();
 
		Graphics2D graphics = (Graphics2D) image.getGraphics();
		graphics.setColor(Color.WHITE);
		graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
		graphics.setColor(Color.BLACK);
 
		for (int i = 0; i < CrunchifyWidth; i++) {
			for (int j = 0; j < CrunchifyWidth; j++) {
				if (byteMatrix.get(i, j)) {
					graphics.fillRect(i, j, 1, 1);
				}
			}
		}
		*/
		
		// QR 코드 색상, 배경 색상
		int qrcodeColor =   0x00000000;		// 0xFF2e4e96
        int backgroundColor = 0xFFFFFFFF;
		
		QRCodeWriter qrCodeWriter = new QRCodeWriter();
		BitMatrix bitMatrix = qrCodeWriter.encode(url, BarcodeFormat.QR_CODE, size, size);
		
		MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrcodeColor,backgroundColor);
		BufferedImage image = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
		
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		ImageIO.write(image, fileType, outputStream);
    	        
		return outputStream;
	}
}
