<%@page import="
javax.servlet.*,
com.alps.Dao,
com.alps.ComExec"
%>

<%
Dao dao = new Dao();
ComExec cex = new ComExec();
%>
<%
String rs = dao.getSetting("ip_path").replace("setip", "restartwar");
cex.comExec("."+rs);
response.sendRedirect("dhcpws.jsp");
%>