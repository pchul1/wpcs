<%@ page language="java"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLEncoder"%>
<%!
	public static String getParam(HttpServletRequest request, String name) {
		String rtnURL ="";
		if(name.equals("URL")){
			Map map = (Map) request.getAttribute("Map");
			if (map == null) {
				map = new HashMap();
				
				Enumeration e = request.getParameterNames();
				while (e.hasMoreElements()) {
					
					String key = (String) e.nextElement();
					String value = request.getParameter(key);
					
					try {
						value = new String(value.getBytes("8859_1"), "UTF-8");
						//System.out.println("server request= "+value);
					} catch (Exception ex) {
					}
					map.put(key.toUpperCase(), value);
					
					//System.out.println("key:" + key);
					//System.out.println("value:" + value);
				}
				request.setAttribute("Map", map);
			}
			return (String) map.get(name.toUpperCase());
		}else{
			Enumeration e = request.getParameterNames();
			while (e.hasMoreElements()) {
				
				String key = (String) e.nextElement();
				String value = request.getParameter(key);
				
				if(!key.equals("URL")){
					try {
						
						value = new String(value.getBytes("8859_1"), "UTF-8");
						value = URLEncoder.encode(value, "UTF-8");
						//System.out.println("server request= "+value);
						rtnURL += "&"+key+"="+value;
					} catch (Exception ex) {
					}
				}
			}
			return rtnURL;
		}
	}
	
	public static void proxy(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String urlParam = getParam(request, "URL");
		String urlP = getParam(request, "1");
		Enumeration headerNames = request.getHeaderNames();
		urlParam += urlP;
		
		//System.out.println("URL_PARAM:"+urlParam);
		
		if (urlParam == null || urlParam.trim().length() == 0) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		boolean doPost = request.getMethod().equalsIgnoreCase("POST");
		//System.out.println("doPost == "+doPost);
		
		URL url = new URL(urlParam);
		//System.out.println("url : == "+url);
		HttpURLConnection http = (HttpURLConnection) url.openConnection();
		http.setRequestMethod("GET");
		/*
		Enumeration headerNames = request.getHeaderNames();
		while (headerNames.hasMoreElements()) {
			String key = (String) headerNames.nextElement();
				
			if (!key.equalsIgnoreCase("Host")) {
				System.out.println("KEY = " + key + ", Value = " + request.getHeader(key));
				http.setRequestProperty(key, request.getHeader(key));
			}
		}
		*/
		http.setDoInput(true);
		http.setDoOutput(true);
		
		byte[] buffer = new byte[8192];
		int read = -1;
		
		if (doPost) {
			http.setRequestProperty("content-type",request.getContentType());
			//System.out.println("doPost2 == "+doPost);
			OutputStream os = http.getOutputStream();
			ServletInputStream sis = request.getInputStream();
			while ((read = sis.read(buffer)) != -1) {
				os.write(buffer, 0, read);
			}
			os.close();
		}
		
// 		System.out.println("respCode = "+http.getResponseCode());
// 		System.out.println("length = "+http.getContentLength());
// 		System.out.println("contentType = "+http.getContentType());
		//System.out.println("content = "+http.getContent());
		//System.out.println("http.getResponseCode()=== : "+http.getResponseCode());
		response.setContentType("text/html;charset=euc-kr");
		response.setStatus(http.getResponseCode());
		//response.setContentType("charset=utf-8");
		//response.setCharacterEncoding("utf-8");
		
		Map headerKeys = http.getHeaderFields();
		Set keySet = headerKeys.keySet();
		Iterator iter = keySet.iterator();
		
		while (iter.hasNext()) {
			String key = (String) iter.next();
			String value = http.getHeaderField(key);
			//System.out.println("key22==== "+key);
			//System.out.println("value22=== "+value);
			if (key != null && value != null) {
				response.setHeader(key, value);
			}
		}
		
		InputStream is = http.getInputStream();
		ServletOutputStream sos = response.getOutputStream();
		response.resetBuffer();
		while ((read = is.read(buffer)) != -1) {
			sos.write(buffer, 0, read);
		}
		
		response.flushBuffer();
		sos.close();
	}
%>
<%
	try {
		out.clear();
		proxy(request, response);
	} catch (Exception e) {
		//System.out.println("ERROR");
		//System.out.println(e.getStackTrace().toString());
		//System.out.println(e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber());
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		response.setContentType("text/plain;charset=utf-8");
		%><%=e.getStackTrace()[0].getMethodName() + ":" + e.getStackTrace()[0].getLineNumber()%><%
	}
	if (true) {
		return;
	}
%>
