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
com.alps.Dao"
%>
<%
URL url;
Dao dao = new Dao();
String gip = dao.getSetting("default_ip");
try {
	String src="http://"+gip+"/graphs/";
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
	content = content.replace("Traffic and system resource graphing", "ALPS System Resource Graph");
	content = content.replace("Queue", "Network");
	content = content.replace("queues", "Networks");
	content = content.replace("href='", "href='showgraphs.jsp?src=grabber.jsp?q=");
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