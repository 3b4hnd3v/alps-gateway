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
com.alps.Gateway
"%>
<%!
ComExec cex = new ComExec();
Dao dao = new Dao();
Gateway g = new Gateway();
%>

<%
if(request.getParameter("q")!=null && request.getParameter("q").equals("reboot")){
	g.reboot();	
	response.sendRedirect("login.jsp");
}
else if(request.getParameter("q")!=null && request.getParameter("q").equals("refresh")){
	String rs = dao.getIpPath().replace("setip", "restartwar");
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
}else if(request.getParameter("q")!=null && request.getParameter("q").equals("multiwan")){
	String act = request.getParameter("ports");
	if(dao.resetIP(act)){
		if(g.multiWan(act)){
			response.sendRedirect("multiwan_qki.jsp?type=success&message="+act+" Successfully Activated");
		}else{if(session.getAttribute("ip") != null){dao.updateIP("ip", session.getAttribute("ip").toString());}
			  if(session.getAttribute("ip1") != null){dao.updateIP("ip1", session.getAttribute("ip1").toString());}
			  if(session.getAttribute("ip2") != null){dao.updateIP("ip2", session.getAttribute("ip2").toString());}
		      if(session.getAttribute("ip3") != null){dao.updateIP("ip3", session.getAttribute("ip3").toString());}
		  	  response.sendRedirect("action.jsp?q=restart");
		}
	}else{
		response.sendRedirect("multiwan_qki.jsp?type=error&message=Problem Activating "+act+". Please Try Again.");
	}
	
}
%>