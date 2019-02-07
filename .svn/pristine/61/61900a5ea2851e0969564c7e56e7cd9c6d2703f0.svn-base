package daewooInfo.cmmn;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.net.URLEncoder;
import java.nio.charset.Charset;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.itextpdf.text.Document;
import com.itextpdf.text.RectangleReadOnly;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import daewooInfo.cmmn.bean.FileVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Repository("PdfUtil")
public class PdfUtil {
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	public void  pdfmake(HttpServletResponse response, String body) throws Exception {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		ServletWebRequest servletWebRequest=new ServletWebRequest(request);
//		HttpServletResponse response=servletWebRequest.getResponse();
		
		String path = this.getClass().getResource("/").getPath();
		String realpath = path.substring(0, path.indexOf("/",path.toLowerCase().lastIndexOf("wpcs")) + 1);
		
		Document document = new Document( new RectangleReadOnly(842.0F, 595.0F), 50, 50, 50, 50); // 용지 및 여백 설정

		// PdfWriter 생성
		PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(propertyService.getString("Globals.fileStorePath") + "/buffer.pdf")); // 바로 다운로드.
		writer.setInitialLeading(12.5f);

		// 파일 다운로드 설정
		response.setContentType("application/pdf");
		String fileName = URLEncoder.encode("한글파일명", "UTF-8"); // 파일명이 한글일 땐 인코딩 필요
		response.setHeader("Content-Transper-Encoding", "binary");
		response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".pdf");

		// Document 오픈
		document.open();
		XMLWorkerHelper helper = XMLWorkerHelper.getInstance();
  
		// CSS
		CSSResolver cssResolver = new StyleAttrCSSResolver();
		CssFile cssFile = helper.getCSS(new FileInputStream(realpath + "WebContent/css/pdf.css"));
		cssResolver.addCss(cssFile);

		// HTML, 폰트 설정
		XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
		fontProvider.register(realpath + "WebContent/css/font/NanumBarunGothic.TTF", "MalgunGothic"); // MalgunGothic은 alias, 
		CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);

		HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
		htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

		// Pipelines
		PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
		HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
		CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);

		XMLWorker worker = new XMLWorker(css, true);
		XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));

		// 폰트 설정에서 별칭으로 줬던 "MalgunGothic"을 html 안에 폰트로 지정한다.
		String htmlStr = "<html><head></head><body style='font-family: MalgunGothic;'>"
            + body
        + "</body></html>";

		StringReader strReader = new StringReader(htmlStr);
		
		xmlParser.parse(strReader);

		document.close();
		writer.close();
    }
	
	public void pdfdownload(HttpServletResponse response) throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		
	    File uFile = new File(propertyService.getString("Globals.fileStorePath") + "/buffer.pdf");
	    int fSize = (int)uFile.length();

	    if (fSize > 0) {
		String mimetype = "application/x-msdownload";

		response.setBufferSize(fSize);
		response.setContentType(mimetype);
//		response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
		setDisposition("applicationForm.pdf", request, response);
		response.setContentLength(fSize);

		/*
		 * FileCopyUtils.copy(in, response.getOutputStream());
		 * in.close(); 
		 * response.getOutputStream().flush();
		 * response.getOutputStream().close();
		 */
		BufferedInputStream in = null;
		BufferedOutputStream out = null;

		try {
		    in = new BufferedInputStream(new FileInputStream(uFile));
		    out = new BufferedOutputStream(response.getOutputStream());

		    FileCopyUtils.copy(in, out);
		    out.flush();
		} catch (Exception ex) {
		} finally {
			    if (in != null) {
					try {
					    in.close();
					} catch (Exception ignore) {
					}
			    }
			    if (out != null) {
					try {
					    out.close();
					} catch (Exception ignore) {
					}
			    }
			}
	    } 
	}
	
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);
		
		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;
		
		if (browser.equals("MSIE")) {
		    encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
		    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
		    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
		    StringBuffer sb = new StringBuffer();
		    for (int i = 0; i < filename.length(); i++) {
			char c = filename.charAt(i);
			if (c > '~') {
			    sb.append(URLEncoder.encode("" + c, "UTF-8"));
			} else {
			    sb.append(c);
			}
		    }
		    encodedFilename = sb.toString();
		} else {
		    //throw new RuntimeException("Not supported browser");
		    throw new IOException("Not supported browser");
		}
		
		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
	
		if ("Opera".equals(browser)){
		    response.setContentType("application/octet-stream;charset=UTF-8");
		}
    }
    
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
}
