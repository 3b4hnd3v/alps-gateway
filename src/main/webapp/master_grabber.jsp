<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="
javax.servlet.*,
java.io.BufferedReader,
java.io.BufferedWriter,
java.io.File,
java.io.FileWriter,
java.io.IOException,
java.io.InputStreamReader,
java.net.MalformedURLException,
java.net.URL,
java.net.URLConnection,
com.alps.master.Mao,
com.alps.Dao"
%>
<%
URL url;
Mao dao = new Mao();
String gip = dao.getSetting("default_ip");
String graph = "";
if(request.getParameter("q")!=null){
	graph = request.getParameter("q");
}else{
	response.sendRedirect("master_reports.jsp");
}
try {
	String src="http://"+gip+"/graphs/"+graph;
	//System.out.println(src);
	// get URL content
	url = new URL(src);
	URLConnection conn = url.openConnection();

	// open the stream and put it into BufferedReader
	BufferedReader br = new BufferedReader(
                       new InputStreamReader(conn.getInputStream()));

	String inputLine;
	String content = "";

	while ((inputLine = br.readLine()) != null) {
		content = content + inputLine;
	}
	String alt = "You Should Access System Report Inside Your Network. Information is too sensitive to share externally.";
	content = content.replace("Traffic and system resource graphing", "ALPS System Resource And Traffic Monitor");
	content = content.replace("src='", "alt='"+alt+"' src='"+src);
	content = content.replace("<a href=\"/graphs/\">Main page</a>", "");
	content = content.replace("Queue", "Network");
	content = content.replace("queues", "Networks");
	content = content.replace("<body>", "<body style='backgroundColor:lightblue;'>");
	out.println(content);
	br.close();

	//System.out.println(content);
	//System.out.println("Done");

} catch (MalformedURLException e) {
	e.printStackTrace();
} catch (IOException e) {
	e.printStackTrace();
}
%>