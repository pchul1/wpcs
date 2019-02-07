package daewooInfo.common.util;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.Globals;
import daewooInfo.common.TmsProperties;
import daewooInfo.common.util.fcc.StringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name  : EgovFileMngUtil.java
 * @Description : 메시지 처리 관련 유틸리티
 * @Modification Information
 * 
 *	 수정일		 수정자				   수정내용
 *	 -------		  --------		---------------------------
 *   2009.02.13	   이삼섭				  최초 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see 
 * 
 */
@Component("EgovFileMngUtil")
public class EgovFileMngUtil {

	public static final int BUFF_SIZE = 2048;

	/**
	 * @uml.property  name="propertyService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * @uml.property  name="idgenService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "egovFileIdGnrService")
	private EgovIdGnrService idgenService;

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());

	/**
	 * 첨부파일에 대한 목록 정보를 취득한다.
	 * 
	 * @param files
	 * @return
	 * @throws Exception
	 */
	public List<FileVO> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
	int fileKey = fileKeyParam;
	
	String storePathString = "";
	String atchFileIdString = "";

	if ("".equals(storePath) || storePath == null) {
		storePathString = propertyService.getString("Globals.fileStorePath");
	} else {
		storePathString = propertyService.getString(storePath);
	}

	if ("".equals(atchFileId) || atchFileId == null) {
		atchFileIdString = idgenService.getNextStringId();
	} else {
		atchFileIdString = atchFileId;
	}

	File saveFolder = new File(storePathString);
	
	if (!saveFolder.exists() || saveFolder.isFile()) {
		saveFolder.mkdirs();
	}

	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	MultipartFile file;
	String filePath = "";
	List<FileVO> result  = new ArrayList<FileVO>();
	FileVO fvo;

	while (itr.hasNext()) {
		Entry<String, MultipartFile> entry = itr.next();

		file = entry.getValue();
		String orginFileName = file.getOriginalFilename();
		
		//--------------------------------------
		// 원 파일명이 없는 경우 처리
		// (첨부가 되지 않은 input file type)
		//--------------------------------------
		if ("".equals(orginFileName)) {
		continue;
		}
		////------------------------------------

		int index = orginFileName.lastIndexOf(".");
		//String fileName = orginFileName.substring(0, index);
		String fileExt = orginFileName.substring(index + 1);
		String newName = KeyStr + StringUtil.getTimeStamp() + fileKey;
		long _size = file.getSize();

		if (!"".equals(orginFileName)) {
			filePath = storePathString + File.separator + newName;
			//System.out.println("filePath : "+filePath);
			file.transferTo(new File(filePath));
			
			// 썸네일도 만들자..(썸네일은 저장된 파일명 뒤에 "_t"를 붙여서 사용하자~ ^^) 
			resizeImage(filePath,filePath+"_t", 80, 60);
		}
		fvo = new FileVO();
		fvo.setFileExtsn(fileExt);
		fvo.setFileStreCours(storePathString);
		fvo.setFileMg(Long.toString(_size));
		fvo.setOrignlFileNm(orginFileName);
		fvo.setStreFileNm(newName);
		fvo.setAtchFileId(atchFileIdString);
		fvo.setFileSn(String.valueOf(fileKey));

		//writeFile(file, newName, storePathString);
		result.add(fvo);
		
		fileKey++;
	}

	return result;
	}
	
	/** 사고접수관련
	 * @param files
	 * @param KeyStr
	 * @param fileKeyParam
	 * @param atchFileId
	 * @param storePath
	 * @return
	 * @throws Exception
	 */
	public List<FileVO> parseAlertFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
		int fileKey = fileKeyParam;
		
		String storePathString = "";
		String atchFileIdString = "";

		if ("".equals(storePath) || storePath == null) {
			storePathString = propertyService.getString("Globals.alertPath");
		} else {
			storePathString = propertyService.getString(storePath);
		}

		if ("".equals(atchFileId) || atchFileId == null) {
			atchFileIdString = idgenService.getNextStringId();
		} else {
			atchFileIdString = atchFileId;
		}

		File saveFolder = new File(storePathString);
		
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = "";
		List<FileVO> result  = new ArrayList<FileVO>();
		FileVO fvo;

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			String orginFileName = file.getOriginalFilename();
			
			//--------------------------------------
			// 원 파일명이 없는 경우 처리
			// (첨부가 되지 않은 input file type)
			//--------------------------------------
			if ("".equals(orginFileName)) {
			continue;
			}
			////------------------------------------

			int index = orginFileName.lastIndexOf(".");
			//String fileName = orginFileName.substring(0, index);
			String fileExt = orginFileName.substring(index + 1);
			String newName = KeyStr + StringUtil.getTimeStamp() + fileKey;
			long _size = file.getSize();

			if (!"".equals(orginFileName)) {
				filePath = storePathString + File.separator + newName;
				file.transferTo(new File(filePath));
				
				// 썸네일도 만들자..(썸네일은 저장된 파일명 뒤에 "_t"를 붙여서 사용하자~ ^^) 
				resizeImage(filePath,filePath+"_t", 80, 60);
			}
			fvo = new FileVO();
			fvo.setFileExtsn(fileExt);
			fvo.setFileStreCours(storePathString);
			fvo.setFileMg(Long.toString(_size));
			fvo.setOrignlFileNm(orginFileName);
			fvo.setStreFileNm(newName);
			fvo.setAtchFileId(atchFileIdString);
			fvo.setFileSn(String.valueOf(fileKey));

			//writeFile(file, newName, storePathString);
			result.add(fvo);
			
			fileKey++;
		}

		return result;
	}
	
	/**
	 * 썸네일 이미지 만들기 (사이즈 강제 지정)
	 * @param loadFile
	 * @param saveFile
	 * @param zoom
	 * @throws IOException
	 */
	public void resizeImage(String loadFile, String saveFile, int width, int height)throws IOException{
		
		File save = new File(saveFile);
		BufferedImage im = ImageIO.read(new File(loadFile));
		
		BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g2 = thumb.createGraphics();
		
		g2.drawImage(im, 0, 0, width, height, null);
		
		ImageIO.write(thumb, "jpg", save);
		
	}
	
	/**
	 * 썸네일 만들기 (배율로 지정하삼~)
	 * @param loadFile
	 * @param saveFile
	 * @param zoom
	 * @throws IOException
	 */
	public void resizeImage(String loadFile, String saveFile, int zoom)throws IOException{
		File save = new File(saveFile);
		BufferedImage im = ImageIO.read(new File(loadFile));
		
		if(zoom <= 0)zoom = 1;
		
		int width = im.getWidth() / zoom;
		int height = im.getHeight() / zoom;
		
		BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g2 = thumb.createGraphics();
		
		g2.drawImage(im, 0, 0, width, height, null);
		
		ImageIO.write(thumb, "jpg", save);
	}

	/**
	 * 첨부파일을 서버에 저장한다.
	 * 
	 * @param file
	 * @param newName
	 * @param stordFilePath
	 * @throws Exception
	 */
	protected void writeUploadedFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
	InputStream stream = null;
	OutputStream bos = null;
	
	try {
		stream = file.getInputStream();
		File cFile = new File(stordFilePath);

		if (!cFile.isDirectory()) {
		boolean _flag = cFile.mkdir();
		if (!_flag) {
			throw new IOException("Directory creation Failed ");
		}
		}

		bos = new FileOutputStream(stordFilePath + File.separator + newName);

		int bytesRead = 0;
		byte[] buffer = new byte[BUFF_SIZE];

		while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
		bos.write(buffer, 0, bytesRead);
		}
	} catch (FileNotFoundException fnfe) {
		fnfe.printStackTrace();
	} catch (IOException ioe) {
		ioe.printStackTrace();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (bos != null) {
		try {
			bos.close();
		} catch (Exception ignore) {
			log.debug("IGNORED: " + ignore.getMessage());
		}
		}
		if (stream != null) {
		try {
			stream.close();
		} catch (Exception ignore) {
			log.debug("IGNORED: " + ignore.getMessage());
		}
		}
	}
	}	
	
	/**
	 * 서버의 파일을 다운로드한다.
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public static void downFile(HttpServletRequest request, HttpServletResponse response) throws Exception {

	String downFileName = "";
	String orgFileName = "";

	if ((String)request.getAttribute("downFile") == null) {
		downFileName = "";
	} else {
		downFileName = (String)request.getAttribute("downFile");
	}

	if ((String)request.getAttribute("orgFileName") == null) {
		orgFileName = "";
	} else {
		orgFileName = (String)request.getAttribute("orginFile");
	}

	File file = new File(downFileName);

	if (!file.exists()) {
		throw new FileNotFoundException(downFileName);
	}

	if (!file.isFile()) {
		throw new FileNotFoundException(downFileName);
	}

	byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.

	response.setContentType("application/x-msdownload");
	response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(), "UTF-8"));
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");

	BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
	int read = 0;

	while ((read = fin.read(b)) != -1) {
		outs.write(b, 0, read);
	}

	outs.close();
	fin.close();
	}

	
	/**
	 * 파일을 서버에 업로드한다.
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public static HashMap<String, String> upload(MultipartFile file) throws Exception {

	HashMap<String, String> map = new HashMap<String, String>();
	//Write File 이후 Move File????
	String newName = "";
	
	//테스트용
	//String stordFilePath = "c:\\dev\\upload";
	
	String stordFilePath = TmsProperties.getProperty("Globals.fileStorePath");
	//String stordFilePath = propertyService.getString("Globals.fileStorePath");
	String orginFileName = file.getOriginalFilename();

	int index = orginFileName.lastIndexOf(".");
	String fileExt = orginFileName.substring(index + 1);
	String fileName = orginFileName.substring(0, index);
	long size = file.getSize();

	//newName 은 Naming Convention에 의해서 생성
	newName = fileName + "_" + StringUtil.getTimeStamp() + "." + fileExt;
	writeFile(file, newName, stordFilePath);
	//storedFilePath는 지정		
	map.put(Globals.ORIGIN_FILE_NM, orginFileName);
	map.put(Globals.UPLOAD_FILE_NM, newName);
	map.put(Globals.FILE_EXT, fileExt);
	map.put(Globals.FILE_PATH, stordFilePath);
	map.put(Globals.FILE_SIZE, String.valueOf(size));

	return map;
	}
	
	
	/**
	 * 첨부로 등록된 파일을 서버에 업로드한다.
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public static HashMap<String, String> uploadFile(MultipartFile file) throws Exception {

	HashMap<String, String> map = new HashMap<String, String>();
	//Write File 이후 Move File????
	String newName = "";
	String stordFilePath = TmsProperties.getProperty("Globals.fileStorePath");
	String orginFileName = file.getOriginalFilename();

	int index = orginFileName.lastIndexOf(".");
	//String fileName = orginFileName.substring(0, _index);
	String fileExt = orginFileName.substring(index + 1);
	long size = file.getSize();

	//newName 은 Naming Convention에 의해서 생성
	newName = StringUtil.getTimeStamp() + "." + fileExt;
	writeFile(file, newName, stordFilePath);
	//storedFilePath는 지정		
	map.put(Globals.ORIGIN_FILE_NM, orginFileName);
	map.put(Globals.UPLOAD_FILE_NM, newName);
	map.put(Globals.FILE_EXT, fileExt);
	map.put(Globals.FILE_PATH, stordFilePath);
	map.put(Globals.FILE_SIZE, String.valueOf(size));

	return map;
	}

	/**
	 * 파일을 실제 물리적인 경로에서 삭제한다
	 * 
	 */
	public static void deleteFile(String filePath) throws Exception {

		File f = new File(filePath); // 파일 객체생성
		if(f.exists()) 
		{
			boolean ok = f.delete(); // 파일이 존재하면 파일을 삭제한다.
		}
	}
	
	/**
	 * 파일을 실제 물리적인 경로에 생성한다.
	 * 
	 * @param file
	 * @param newName
	 * @param stordFilePath
	 * @throws Exception
	 */
	protected static void writeFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
	InputStream stream = null;
	OutputStream bos = null;
	
	try {
		stream = file.getInputStream();
		File cFile = new File(stordFilePath);

		if (!cFile.isDirectory())
		cFile.mkdir();

		bos = new FileOutputStream(stordFilePath + File.separator + newName);

		int bytesRead = 0;
		byte[] buffer = new byte[BUFF_SIZE];

		while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
		bos.write(buffer, 0, bytesRead);
		}
	} catch (FileNotFoundException fnfe) {
		fnfe.printStackTrace();
	} catch (IOException ioe) {
		ioe.printStackTrace();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (bos != null) {
		try {
			bos.close();
		} catch (Exception ignore) {
			Logger.getLogger(EgovFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
		}
		}
		if (stream != null) {
		try {
			stream.close();
		} catch (Exception ignore) {
			Logger.getLogger(EgovFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
		}
		}
	}
	}

	/**
	 * 서버 파일에 대하여 다운로드를 처리한다.
	 * 
	 * @param response
	 * @param streFileNm
	 *			: 파일저장 경로가 포함된 형태
	 * @param orignFileNm
	 * @throws Exception
	 */
	public void downFile(HttpServletResponse response, String streFileNm, String orignFileNm) throws Exception {
	String downFileName = streFileNm;
	String orgFileName = orignFileNm;

	File file = new File(downFileName);
	//log.debug(this.getClass().getName()+" downFile downFileName "+downFileName);
	//log.debug(this.getClass().getName()+" downFile orgFileName "+orgFileName);

	if (!file.exists()) {
		throw new FileNotFoundException(downFileName);
	}

	if (!file.isFile()) {
		throw new FileNotFoundException(downFileName);
	}

	//byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.
	int fSize = (int)file.length();
	if (fSize > 0) {
		BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
		String mimetype = "text/html"; //"application/x-msdownload"

		response.setBufferSize(fSize);
		response.setContentType(mimetype);
		response.setHeader("Content-Disposition:", "attachment; filename=" + orgFileName);
		response.setContentLength(fSize);
		//response.setHeader("Content-Transfer-Encoding","binary");
		//response.setHeader("Pragma","no-cache");
		//response.setHeader("Expires","0");
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
		
	/*
	String uploadPath = propertiesService.getString("fileDir");

	File uFile = new File(uploadPath, requestedFile);
	int fSize = (int) uFile.length();

	if (fSize > 0) {
		BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));

		String mimetype = "text/html";

		response.setBufferSize(fSize);
		response.setContentType(mimetype);
		response.setHeader("Content-Disposition", "attachment; filename=\""
					+ requestedFile + "\"");
		response.setContentLength(fSize);

		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
		response.getOutputStream().flush();
		response.getOutputStream().close();
	} else {
		response.setContentType("text/html");
		PrintWriter printwriter = response.getWriter();
		printwriter.println("<html>");
		printwriter.println("<br><br><br><h2>Could not get file name:<br>" + requestedFile + "</h2>");
		printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
		printwriter.println("<br><br><br>&copy; webAccess");
		printwriter.println("</html>");
		printwriter.flush();
		printwriter.close();
	}
	//*/
		
		
	/*
	response.setContentType("application/x-msdownload");			
	response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(),"UTF-8" ));
	response.setHeader("Content-Transfer-Encoding","binary");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Expires","0");

	BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
	int read = 0;
	
	while ((read = fin.read(b)) != -1) {
		outs.write(b,0,read);
	}	
	log.debug(this.getClass().getName()+" BufferedOutputStream Write Complete!!! ");
		
	outs.close();
		fin.close();
	//*/
	}
	
	/**
	 * 수질오염사고 접수 단계별 첨부파일
	 * @param files
	 * @param KeyStr
	 * @param fileKeyParam
	 * @param atchFileId
	 * @param storePath
	 * @return
	 * @throws Exception
	 */
	public List<FileVO> parseWpStepFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
		int fileKey = fileKeyParam;
		
		String storePathString = "";
		String atchFileIdString = "";
		
		storePathString  = propertyService.getString("Globals.fileStorePath");
		if(!"FILE_000000000000001".equals(KeyStr))
			atchFileIdString = idgenService.getNextStringId();
		else
			atchFileIdString = KeyStr;
			
		//System.out.println("YIK>>>>storePathString : " + storePathString);
		//System.out.println("YIK>>>>atchFileIdString : " + atchFileIdString);
		
		/*
		if ("".equals(storePath) || storePath == null) {
			storePathString = propertyService.getString("Globals.fileStorePath");
		} else {
			storePathString = propertyService.getString(storePath);
		}
		

		if ("".equals(atchFileId) || atchFileId == null) {
			atchFileIdString = idgenService.getNextStringId();
		} else {
			atchFileIdString = atchFileId;
		}
		*/

		File saveFolder = new File(storePathString);
		
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = "";
		List<FileVO> result  = new ArrayList<FileVO>();
		FileVO fvo;

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			String orginFileName = file.getOriginalFilename();
			
			//--------------------------------------
			// 원 파일명이 없는 경우 처리
			// (첨부가 되지 않은 input file type)
			//--------------------------------------
			if ("".equals(orginFileName)) {
			continue;
			}
			////------------------------------------

			int index = orginFileName.lastIndexOf(".");
			String fileName = orginFileName.substring(0, index);
			String fileExt = orginFileName.substring(index + 1);
			String newName = KeyStr + StringUtil.getTimeStamp() + fileKey;
			long _size = file.getSize();
			
			//System.out.println("----------------------- YIK START ---------------------------------------");
			//System.out.println("File.separator>>>>>>>>>>>>>" + File.separator);
			//System.out.println("newName>>>>>>>>>>>>>" + newName);
			//System.out.println("orginFileName>>>>>>>>>>>>>" + orginFileName);
			//System.out.println("----------------------- YIK END ---------------------------------------");

			if (!"".equals(orginFileName)) {
				filePath = storePathString + File.separator + newName;
				file.transferTo(new File(filePath));
				
				// 썸네일도 만들자..(썸네일은 저장된 파일명 뒤에 "_t"를 붙여서 사용하자~ ^^) 
				if(!"WKJN_".equals(KeyStr))
					resizeImage(filePath,filePath+"_t", 80, 60);
			}
			fvo = new FileVO();
			fvo.setFileExtsn(fileExt);
			fvo.setFileStreCours(storePathString);
			fvo.setFileMg(Long.toString(_size));
			fvo.setOrignlFileNm(orginFileName);
			fvo.setStreFileNm(newName);
			fvo.setAtchFileId(atchFileIdString);
			fvo.setFileSn(String.valueOf(fileKey));

			writeFile(file, newName, storePathString);
			result.add(fvo);
			
			fileKey++;
		}

		return result;
	}
	
	/**
	 * 엑셀파일을 서버에 업로드한다.
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, String> uploadExcelFile(MultipartFile file) throws Exception {

		HashMap<String, String> map = new HashMap<String, String>();
		//Write File 이후 Move File????
		String newName = "";
		
		//테스트용
		//String stordFilePath = "c:\\dev\\upload";
		
		String stordFilePath = propertyService.getString("Globals.fileStorePath");
		String orginFileName = file.getOriginalFilename();
	
		int index = orginFileName.lastIndexOf(".");
		String fileExt = orginFileName.substring(index + 1);
		String fileName = orginFileName.substring(0, index);
		long size = file.getSize();
	
		//newName 은 Naming Convention에 의해서 생성
		newName = fileName + "_" + StringUtil.getTimeStamp() + "." + fileExt;
		writeFile(file, newName, stordFilePath);
		//storedFilePath는 지정		
		map.put(Globals.ORIGIN_FILE_NM, orginFileName);
		map.put(Globals.UPLOAD_FILE_NM, newName);
		map.put(Globals.FILE_EXT, fileExt);
		map.put(Globals.FILE_PATH, stordFilePath);
		map.put(Globals.FILE_SIZE, String.valueOf(size));
	
		return map;
	}
	
	/**
	 * 첨부파일에 대한 목록 정보를 취득한다.
	 * 
	 * @param files
	 * @return
	 * @throws Exception
	 */
	public List<FileVO> parseChkUseFileInf(List<MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
		int fileKey = fileKeyParam;
		
		String storePathString = "";
		String atchFileIdString = "";
	
		if ("".equals(storePath) || storePath == null) {
			storePathString = propertyService.getString("Globals.fileStorePath");
		} else {
			storePathString = propertyService.getString(storePath);
		}
	
		File saveFolder = new File(storePathString);
		
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
	
		MultipartFile file;
		String filePath = "";
		List<FileVO> result  = new ArrayList<FileVO>();
		FileVO fvo;
	
		for(int i=0;i<files.size();i++) {
			file = files.get(i);
			String orginFileName = file.getOriginalFilename();
			
			//--------------------------------------
			// 원 파일명이 없는 경우 처리
			// (첨부가 되지 않은 input file type)
			//--------------------------------------
			if ("".equals(orginFileName)) {
				continue;
			}
			////------------------------------------
	
			int index = orginFileName.lastIndexOf(".");
			String fileExt = orginFileName.substring(index + 1);
			String newName = KeyStr + StringUtil.getTimeStamp() + fileKey;
			long _size = file.getSize();
	
			if (!"".equals(orginFileName)) {
				filePath = storePathString + File.separator + newName;
				//System.out.println("filePath : "+filePath);
				file.transferTo(new File(filePath));
			}
			
			if ("".equals(atchFileId) || atchFileId == null) {
				if("".equals(atchFileIdString) || atchFileIdString == null) {
					atchFileIdString = idgenService.getNextStringId();
				} else {
					atchFileIdString = atchFileIdString;
				}
			} 
			
			fvo = new FileVO();
			fvo.setFileExtsn(fileExt);
			fvo.setFileStreCours(storePathString);
			fvo.setFileMg(Long.toString(_size));
			fvo.setOrignlFileNm(orginFileName);
			fvo.setStreFileNm(newName);
			fvo.setAtchFileId(atchFileIdString);
			fvo.setFileSn(String.valueOf(fileKey));
	
			result.add(fvo);
			
			fileKey++;
		}
	
		return result;
	}
	
	/**
	 * 첨부로 등록된 파일을 서버에 업로드한다.
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public FileVO uploadCheckUseFile(MultipartFile file, String KeyStr, int fileKeyParam, String atchFileId) throws Exception {

		int fileKey = fileKeyParam;
		
		String storePathString = "";
		String atchFileIdString = "";
		
		FileVO vo = new FileVO();
		//Write File 이후 Move File????
		String newName = "";
		//propertyService.getString("Globals.fileStorePath");
		//String stordFilePath = TmsProperties.getProperty("Globals.fileStorePath");
		String stordFilePath = propertyService.getString("Globals.fileStorePath");
		String orginFileName = file.getOriginalFilename();
	
		int index = orginFileName.lastIndexOf(".");
		//String fileName = orginFileName.substring(0, _index);
		String fileExt = orginFileName.substring(index + 1);
		long size = file.getSize();
	
		//newName 은 Naming Convention에 의해서 생성
		newName = KeyStr + StringUtil.getTimeStamp() + "." + fileExt;
		writeFile(file, newName, stordFilePath);
		//storedFilePath는 지정		
		if ("".equals(atchFileId) || atchFileId == null) {
			if("".equals(atchFileIdString) || atchFileIdString == null) {
				atchFileIdString = idgenService.getNextStringId();
			} else {
				atchFileIdString = atchFileIdString;
			}
		} 
	
		vo.setFileExtsn(fileExt);
		vo.setFileStreCours(stordFilePath);
		vo.setFileMg(Long.toString(size));
		vo.setOrignlFileNm(orginFileName);
		vo.setStreFileNm(newName);
		vo.setAtchFileId(atchFileIdString);
		vo.setFileSn(String.valueOf(fileKey));
		
		return vo;
	}
	
	/**
	 * 파일을 실제 물리적인 경로에서 삭제한다
	 * 
	 */
	public void deleteCheckUseFile(String filePath) throws Exception {

		File f = new File(filePath); // 파일 객체생성
		if(f.exists()) 
		{
			boolean ok = f.delete(); // 파일이 존재하면 파일을 삭제한다.
		}
	}
}
