<%@page import="java.awt.EventQueue,
java.awt.event.ActionListener,
java.awt.event.ActionEvent,
java.util.Date,
java.io.IOException,
java.io.BufferedReader,
java.io.InputStream,
java.io.InputStreamReader,
java.net.URL,
flexjson.*,
java.net.URLConnection,
java.net.HttpURLConnection,
java.util.Date,
java.util.ArrayList,
java.text.DateFormat,
java.text.SimpleDateFormat,
java.util.Calendar,
com.alps.Gateway,
com.alps.AlpsLog,
com.alps.Dao,
com.alps.License,
com.mail.Licmail,
com.alps.GCounter"%>
<%
String tp = request.getParameter("type");
String mt = request.getParameter("method");
//System.out.println(tp+"=="+mt);
%>

<%!
Dao dao = new Dao();
Gateway g = new Gateway(); 
GCounter gc = new GCounter();
AlpsLog al = new AlpsLog();
%>



<%
if(request.getParameter("type") != null && request.getParameter("type").equals("user") && request.getParameter("method").equals("checkuser")) {
	
	String user = "";
	
	//
	String roomnum = request.getParameter("room");
	String lastname = request.getParameter("ln");
	boolean check = g.checkUser(roomnum, lastname);
	System.out.println("call func "+check);
	if(check==true){
		user = "userexist";
	}else{
		user = "userdontexist";
	}
	
	
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(user);
	System.out.println(user);
}

%>