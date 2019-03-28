<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.awt.image.RescaleOp"%>
<%@ page import="java.awt.image.BufferedImageOp"%>
<%@ page import="sun.misc.BASE64Decoder"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.awt.Graphics2D"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="org.apache.batik.transcoder.image.PNGTranscoder"%>
<%@ page import="org.apache.batik.transcoder.TranscoderInput"%>
<%@ page import="org.apache.batik.transcoder.TranscoderOutput"%>
<%@ page import="java.net.URL"%>
<%-- <%@page import="java.nio.file.Paths"%> --%>
<%@ page import="javax.imageio.ImageIO"%>

<%@ page import="java.io.*"%>

<%
	response.setHeader("Access-Control-Allow-Origin","*");
	response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");
	try{
		Gson gson = new Gson();
		String fileName = request.getParameter("fileName");
		String arcServiceUrl = request.getParameter("arcServiceUrl");
		String mode = request.getParameter("mode");
		if(fileName==null){
			String svgInfo = request.getParameter("svgInfo");
			if(svgInfo==null || "".equals(svgInfo)){
				//svg못함.
			}else{
				int start = svgInfo.indexOf("<svg");
				int end = svgInfo.indexOf("</svg");
				svgInfo = svgInfo.substring(start, end+6);
				svgInfo = svgInfo.replace("xmlns=\"http://www.w3.org/2000/svg\"", "");
				svgInfo = svgInfo.replaceAll("<svg", "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?> <svg xmlns:svg=\"http://www.w3.org/2000/svg\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" ");
			}
			
			int width = Integer.parseInt(request.getParameter("width"));
			int height = Integer.parseInt(request.getParameter("height"));
			ImageInfo[] imageInfos = gson.fromJson(request.getParameter("imageInfos"), ImageInfo[].class);
			
			String randomId =  UUID.randomUUID().toString();
			String svgFileName = "svg_" + randomId + ".svg";
			String svgPngFileName = "svg_" + randomId + ".png";
			String resultPngFileName = "result_" + randomId + ".png";
			
			File desti = new File("/water_temp");
			if(!desti.exists()){
				desti.mkdirs(); 
			}
			
			BufferedImage svgImg= null;
			if(svgInfo!=null && !"".equals(svgInfo)){
				BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("/water_temp/" + svgFileName), "UTF8"));
			    writer.write(svgInfo);
			    writer.flush();
			    writer.close();
// 			    String svg_URI_input = Paths.get("C:/temp/" + svgFileName).toUri().toURL().toString();
 			    String svg_URI_input = "file:///water_temp/" + svgFileName;
		        TranscoderInput input_svg_image = new TranscoderInput(svg_URI_input);     
			    
			    OutputStream png_ostream = new FileOutputStream("/water_temp/" + svgPngFileName);
			    TranscoderOutput output_png_image = new TranscoderOutput(png_ostream);  
			    PNGTranscoder my_converter = new PNGTranscoder();    
			    
			    my_converter.transcode(input_svg_image, output_png_image);
			    png_ostream.flush();
			    png_ostream.close();  
			    svgImg = ImageIO.read(new File("/water_temp/" + svgPngFileName));
			}
		    
		    BufferedImage newImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
		    Graphics2D graphic = newImage.createGraphics();
		    Color color = graphic.getColor();
		    graphic.setPaint(Color.WHITE);
		    graphic.fillRect(0, 0, width, height);
		    graphic.setColor(color);
		    
		    for(int i=0; i<imageInfos.length; i++){
		    	//BufferedImage baseImage = ImageIO.read(new URL(imageInfos[i].src));
		    	
		    	if(imageInfos[i].base64==null || "".equals(imageInfos[i].base64)){
		    		System.out.println(imageInfos[i].src);
		    		BufferedImage baseImage = ImageIO.read(new URL(imageInfos[i].src));
		            graphic.drawImage(baseImage, null, imageInfos[i].translateX, imageInfos[i].translateY);
		    	}else{
		    		String encodingPrefix = "base64,";
					int contentStartIndex = imageInfos[i].base64.indexOf(encodingPrefix) + encodingPrefix.length();
			    	BASE64Decoder decoder = new BASE64Decoder();
			    	byte[] imageByte = decoder.decodeBuffer(imageInfos[i].base64.substring(contentStartIndex));
		            ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
		            BufferedImage baseImage = ImageIO.read(bis);
		            bis.close();
		            
		            float[] scales = { 1.0f, 1.0f, 1.0f, imageInfos[i].opacity };
		            float[] offsets = new float[4];
		            BufferedImageOp op = new RescaleOp(scales, offsets, null);
		            graphic.drawImage(baseImage, op, imageInfos[i].translateX, imageInfos[i].translateY);
		    	}
		    }
		    
		    if(svgInfo!=null){
			    graphic.drawImage(svgImg, null, 0, 0);
			    graphic.dispose();
		    }
		    
		    File outputfile = new File("/water_temp/" + resultPngFileName);
		    ImageIO.write(newImage, "png", outputfile);
		    
		    HashMap hashMap = new HashMap();
// 		    if(mode.equals("print")){
// 		    	hashMap.put("url", arcServiceUrl + "/rest/directories/arcgisoutput/customPrintTask/" + resultPngFileName);
// 		    }else{
		    	hashMap.put("url", "http://" + request.getServerName()+ ":" + request.getServerPort() + request.getContextPath() + request.getServletPath() + "?fileName=" + resultPngFileName);
// 		    }
	 		out.println(gson.toJson(hashMap));
		}else{
			fileName = fileName.replaceAll("/", "");
			fileName = fileName.replaceAll("\"", "");
			fileName = fileName.replaceAll(".", "");
			fileName = fileName.replaceAll("&", "");
			
			File file = new File("/water_temp/" + fileName);
			FileInputStream fin = new FileInputStream(file);
			int ifilesize = (int)file.length();
			byte b[] = new byte[ifilesize];
			response.setContentLength(ifilesize);
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition","attachment; filename="+fileName+";");
			out.clear();
			out = pageContext.pushBody();
			ServletOutputStream oout = response.getOutputStream();
			fin.read(b);
			oout.write(b,0,ifilesize);
			oout.flush();
			oout.close();
			fin.close();
			fin = null;
			oout = null;
			//Runtime.getRuntime().gc();	
			
		}
	}catch(Exception e){
		//out.println(e);
		e.printStackTrace();
	}
%>

<%!
	class ImageInfo{
		public String src;
		public String base64;
		public int translateX;
		public int translateY;
		public float opacity;
	}
%>