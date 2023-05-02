<%@page import="
javax.servlet.*,
java.util.Date,
java.io.*,
java.util.*,
java.sql.Connection,
java.sql.DriverManager,
java.sql.ResultSet,
java.sql.SQLException,
java.sql.Statement,
java.sql.ResultSetMetaData,
java.util.HashMap,
java.sql.PreparedStatement,
com.alps.ComExec,
com.alps.Dao,
com.alps.Gateway"
%>
<%
ComExec cex = new ComExec();
Dao dao = new Dao();
Gateway g = new Gateway();

if(session.getAttribute("logged")==null) { 		
	try { 
		response.sendRedirect("login.jsp"); 
	}catch(Exception e){
		request.setAttribute("q", null);
	}
} 

if(request.getParameter("q")!=null && request.getParameter("q").equals("reboot")){
	g.reboot();	
	//cex.comExec("system reboot path");
	response.sendRedirect("login.jsp");
}
else if(request.getParameter("q")!=null && request.getParameter("q").equals("refresh")){
	String rs = dao.getSetting("restart_path");
	cex.comExec(""+rs);
	response.sendRedirect("login.jsp");
}
else if(request.getParameter("q")!=null && request.getParameter("q").equals("resetgraph")){
	response.sendRedirect("index.jsp?q=resetcomplete");
}
else if(request.getParameter("q")!=null && request.getParameter("q").equals("onlinecheck")){
	String checktime = request.getParameter("q");
	session.setAttribute("checktime", checktime);
	System.out.println("action url work");
}
%>