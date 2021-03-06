package daewooInfo.cmmn.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.alert.service.AlertStepService;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.login.bean.SessionVO;
import daewooInfo.common.util.CommonUtil;
import daewooInfo.common.util.fcc.StringUtil;

/**
 * @Class Name : EgovImageProcessController.java
 * @Description : 
 * @Modification Information
 *
 * 수정일			수정자		수정내용
 * -------		-------		-------------------
 * 2009.4.2.	이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009.4.2.
 * @version
 * @see
 */
@SuppressWarnings("serial")
@Controller
public class EgovImageProcessController extends HttpServlet {

	/**
	 * @uml.property  name="fileService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;

	
	/**
	 * @uml.property  name="alertStepService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertStepService")
	private AlertStepService alertStepService;
	 
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());

	/**
	 * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
	 * 
	 * @param atchFileId
	 * @param fileSn
	 * @param sessionVO
	 * @param model
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/getImage.do")
	public void getImageInf(SessionVO sessionVO, ModelMap model, Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

	//@RequestParam("atchFileId") String atchFileId,
	//@RequestParam("fileSn") String fileSn,
	String atchFileId = (String)commandMap.get("atchFileId");
	String fileSn = (String)commandMap.get("fileSn");
	
	String thumbnailFlag = (String)commandMap.get("thumbnailFlag"); 

	FileVO vo = new FileVO();

	vo.setAtchFileId(atchFileId);
	vo.setFileSn(fileSn);

	FileVO fvo = fileService.selectFileInf(vo);

	//String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();
	
	File file = null;
	
	if (thumbnailFlag != null && "Y".equals(thumbnailFlag)) {
		file = new File(fvo.getFileStreCours(), fvo.getStreFileNm()+"_t");
	} else {
		file = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
	}
	
		try
		{
			FileInputStream fis = new FileInputStream(file);
		
			BufferedInputStream in = new BufferedInputStream(fis);
			ByteArrayOutputStream bStream = new ByteArrayOutputStream();
		
			int imgByte;
			while ((imgByte = in.read()) != -1) {
				bStream.write(imgByte);
			}
			in.close();
		
			String type = "";
		
			if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
				if ("jpg".equals(StringUtil.lowerCase(fvo.getFileExtsn()))) {
				type = "image/jpeg"; //TODO 정말 이런걸까?
				} else {
				type = "image/" + StringUtil.lowerCase(fvo.getFileExtsn());
				}
				type = "image/" + StringUtil.lowerCase(fvo.getFileExtsn());
		
			} else {
				log.debug("Image fileType is null.");
			}
		
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());
			
			bStream.writeTo(response.getOutputStream());
			
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
		catch(FileNotFoundException fnfe)
		{
			
		}

	}
	
	@RequestMapping("/cmmn/getAlertImage.do")
	public void getAlertImageInf(SessionVO sessionVO, ModelMap model, Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

	//@RequestParam("atchFileId") String atchFileId,
	//@RequestParam("fileSn") String fileSn,
	String atchFileId = (String)commandMap.get("atchFileId"); 
	String thumbnailFlag = (String)commandMap.get("thumbnailFlag"); 
//	System.out.println("atchFileId : "+atchFileId);
	
	FileVO vo = new FileVO();

	vo.setAtchFileId(atchFileId);
	
	FileVO fvo = alertStepService.selectAlertFileInf(vo); 
	File file = null;
	
	if (thumbnailFlag != null && "Y".equals(thumbnailFlag)) {
		file = new File(fvo.getFileStreCours(), fvo.getStreFileNm()+"_t");
	} else {
		file = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
	}
	
	FileInputStream fis = new FileInputStream(file);

	BufferedInputStream in = new BufferedInputStream(fis);
	ByteArrayOutputStream bStream = new ByteArrayOutputStream();

	int imgByte;
	while ((imgByte = in.read()) != -1) {
		bStream.write(imgByte);
	}
	in.close();

	String type = "";

	if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
		if ("jpg".equals(StringUtil.lowerCase(fvo.getFileExtsn())) || 
			"jpeg".equals(StringUtil.lowerCase(fvo.getFileExtsn())) ||
			"jpe".equals(StringUtil.lowerCase(fvo.getFileExtsn())) ) {
			type = "image/jpeg";
		} else if("gif".equals(StringUtil.lowerCase(fvo.getFileExtsn()))){
			type = "image/gif";
		} else if("tif".equals(StringUtil.lowerCase(fvo.getFileExtsn())) ||
				"tiff".equals(StringUtil.lowerCase(fvo.getFileExtsn()))){
			type = "image/tiff";
		} else if("png".equals(StringUtil.lowerCase(fvo.getFileExtsn()))){
			type = "image/png";
		} else {
			// 지원되지 않는 이미지
			//type = "image/" + StringUtil.lowerCase(fvo.getFileExtsn());
			type = "application/octet-stream";
		}

	} else {
		log.debug("Image fileType is null.");
	}

	response.setHeader("Content-Type", type);
	response.setContentLength(bStream.size());
	
	bStream.writeTo(response.getOutputStream());
	
	response.getOutputStream().flush();
	response.getOutputStream().close();

	}
	
	/**
	 * 첨부된 동영상에 대한 미리보기 기능을 제공한다.
	 * 
	 * @param atchFileId
	 * @param fileSn
	 * @param sessionVO
	 * @param model
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/getVideo.do")
	public void getVideoInf(SessionVO sessionVO
							, ModelMap model
							, Map<String, Object> commandMap, 
								HttpServletResponse response) throws Exception {
	
		String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
		
		String thumbnailFlag = (String)commandMap.get("thumbnailFlag"); 
	
		FileVO vo = new FileVO();
	
		vo.setAtchFileId(atchFileId);
		vo.setFileSn(fileSn);
	
		FileVO fvo = fileService.selectFileInf(vo);
		
		File file = null;
		
		if (thumbnailFlag != null && "Y".equals(thumbnailFlag)) {
			file = new File(fvo.getFileStreCours(), fvo.getStreFileNm()+"_t");
		} else {
			file = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
		}
		
		String type = "";
		String extSn = "";
		if(fvo.getFileExtsn() != null) extSn = StringUtil.lowerCase(fvo.getFileExtsn());
		if (!"".equals(extSn)) {
			if ("mp4".equals(extSn)) {
				type = "video/mp4";
			} else if("ogv".equals(extSn)){
				type = "video/ogg";
			} else if("webm".equals(extSn)){
				type = "video/x-webm";
			} else if("3gp".equals(extSn)){
				type = "video/3gp";
			} else if("avi".equals(extSn)){
				type = "video/avi";
			} else {
				// 지원하지 않는 동영상 확장자
				type = "application/octet-stream";
			}
		} else {
			log.debug("Video fileType is null.");
		}
		
		FileInputStream fis = null;
		BufferedInputStream in = null;
		ByteArrayOutputStream bStream =null;
		
		try{
			fis = new FileInputStream(file);
			in = new BufferedInputStream(fis);
			bStream = new ByteArrayOutputStream();
			
			int videoByte;
			while ((videoByte = in.read()) != -1) {
				bStream.write(videoByte);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			fis.close();
			in.close();
	
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());
			
			bStream.writeTo(response.getOutputStream());
			bStream.close();
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
		
	}
	
	@RequestMapping("/cmmn/getQRCodeImage.do")
	public void getQRCodeImage(SessionVO sessionVO
							, ModelMap model
							, Map<String, Object> commandMap, 
								HttpServletResponse response) throws Exception {
		
		String itemCode = (String)commandMap.get("itemCode");
		String itemCodeNum = (String)commandMap.get("itemCodeNum");
		String qrCodeSize = (String)commandMap.get("qrCodeSize");
		String qrUseType = (String)commandMap.get("qrUseType");
		String defaultSize = "140";
		
		String qrCodeurl = "http://www.waterkorea.or.kr/";
		
		if("warehouse".equals(qrUseType)) {
			qrCodeurl += "warehouse/itemQRDetail.do?itemCode=";
			qrCodeurl += itemCode.trim();
			qrCodeurl += "&itemCodeNum=";
			qrCodeurl += itemCodeNum.trim();
		}
		if(qrCodeSize == null || "".equals(qrCodeSize.trim())){
			qrCodeSize = defaultSize;
		}
		ByteArrayOutputStream bStream = null;

		try{
			bStream = new ByteArrayOutputStream();
			bStream = CommonUtil.generateQRCode(qrCodeurl, "jpg", Integer.parseInt(qrCodeSize.trim()));
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
			response.setHeader("Content-Type", "image/jpeg");
			response.setContentLength(bStream.size());
			
			bStream.writeTo(response.getOutputStream());
			bStream.close();
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
		
	}
}
