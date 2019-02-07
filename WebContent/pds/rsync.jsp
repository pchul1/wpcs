<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*,java.io.*,java.net.*" %>
<%

String path;
path = "/data/wpcs/pds/rsync.sh";

InetAddress addr = InetAddress.getLocalHost();
String hostname = addr.getHostName();

out.print(hostname + "<br>");

try {
	String line;
	Process proc = Runtime.getRuntime().exec(path);
	BufferedReader input = new BufferedReader(new InputStreamReader(proc.getInputStream()));

	while ((line = input.readLine()) != null) {
		out.println(line + "<br>");
	}

	input.close();
} catch(Exception ex) {
	out.println(ex.getMessage());
}
%>