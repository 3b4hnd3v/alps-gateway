<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>    

<%
if(request.getParameter("type") != null && request.getParameter("type").equals("pool")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.resetPool(item);
		
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "/ippadd.jsp?q=pool");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("type") != null && request.getParameter("type").equals("user")) {
	
	try {
		String uid = request.getParameter("item").toString();
		
		g.resetUser(uid);
		
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "/hotspot.jsp?q=users");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("type") != null && request.getParameter("type").equals("userprof")) {
	
	try {
		String uid = request.getParameter("item").toString();
		
		g.resetUserProf(uid);
		
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "/hotspot.jsp?q=userprofiles");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("type") != null && request.getParameter("type").equals("walledgarden")) {
	
	try {
		String wgid = request.getParameter("item").toString();
		
		g.resetWalledGarden(wgid);
		
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "/hotspot.jsp?q=walledgarden");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("type") != null && request.getParameter("type").equals("ipadd")) {
	
	try {
		String uid = request.getParameter("item").toString();

		g.resetIpadd(uid);
		
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "/ippadd.jsp?q=ipaddress");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("type") != null && request.getParameter("type").equals("hsserver")) {
	
	try {
		String hssid = request.getParameter("item").toString();
		
		g.resetHsserver(hssid);
		
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "/hs_server.jsp?q=servers");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("type") != null && request.getParameter("type").equals("hsserverprof")) {
	
	try {
		String hspid = request.getParameter("item").toString();
		
		g.resetHsserverProf(hspid);
		
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "/hs_server.jsp?q=serverprofiles");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<%
if(request.getParameter("type") != null && request.getParameter("type").equals("interface")) {
	
	try {
		String intid = request.getParameter("intid").toString();
		
		g.resetInterface(intid);
		
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "/ippadd.jsp?q=ipaddress");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
