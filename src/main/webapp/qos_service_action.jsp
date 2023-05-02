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
com.alps.master.*,
com.alps.Gateway"
%>
<%
Mao mao = new Mao();
MasterApi mg = new MasterApi();

if(request.getParameter("submit")!=null && request.getParameter("submit").equals("update_qos")){
	String max_rate = request.getParameter("max_rate");
	String limit_rate = request.getParameter("limit_rate");
	String new_status = request.getParameter("new_status");
	String[] services = request.getParameterValues("service");
	
	max_rate = max_rate + "M";
	limit_rate = limit_rate + "M";
	for(String service : services){
		String service_id = service.split(" : ")[1];
		String service_name = service.split(" : ")[0];
		
		if(service_name.equals("Global")){
			//Update Global
			mg.changeQos(new_status, max_rate, service_id);
		}else{
			//Update Service
			String priority = request.getParameter(service_name + "_priority");
			mg.changeQos(limit_rate, max_rate, priority, service_id);
		}
	}
	
	response.sendRedirect("qos_service_priority.jsp");
}

if(request.getParameter("submit")!=null && request.getParameter("submit").equals("update_qos_priorities")){
	String max_rate = request.getParameter("max_rate");
	String limit_rate = request.getParameter("limit_rate");
	String new_status = request.getParameter("old_status");
	String[] services = request.getParameterValues("service");
	max_rate = max_rate + "M";
	limit_rate = limit_rate + "M";
	for(String service : services){
		String service_id = service.split(" : ")[1];
		String service_name = service.split(" : ")[0];
		
		if(service_name.equals("Global")){
			//Update Global
			mg.changeQos(new_status, max_rate, service_id);
		}else{
			//Update Service
			String priority = request.getParameter(service_name + "_priority");
			mg.changeQos(limit_rate, max_rate, priority, service_id);
		}
	}
	
	response.sendRedirect("qos_service_priority.jsp");
}

if(request.getParameter("submit")!=null && request.getParameter("submit").equals("update_qos_ptop")){
	String ident = request.getParameter("ident");
	String status = request.getParameter("status");
	
	mg.changeP2P(status, ident);
	
	response.sendRedirect("qos_service_priority.jsp");
}
/* else if(request.getParameter("q")!=null && request.getParameter("q").equals("refresh")){
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
} */
%>