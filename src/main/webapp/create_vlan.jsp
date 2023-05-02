<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%! Location loc = new Location(); %>
<% //Add Vlan
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create VLAN")) {
	
	String locname = "", vlanid="", vlname = "";
	
	try {
		locname = request.getParameter("locname").toString();
		vlanid = request.getParameter("vlanid").toString();
		vlname = request.getParameter("vlname").toString();
		String interf = "LAN";
		String vact = loc.addVlan(vlanid, vlname, interf, "enabled");
		if(vact.equals("Yes")){
			loc.addPort(vlname, locname);
			response.sendRedirect("add_vlan.jsp?location="+locname+"&msg=Vlan Added To Location.&type=success");
		}else if(vact.equals("Exist")){
			response.sendRedirect("add_vlan.jsp?location="+locname+"&msg=Vlan Already Exist.&type=error");
		}else{
			response.sendRedirect("add_vlan.jsp?location="+locname+"&msg=VLAN Can Not Be Added To Location.&type=error");
		}
		
	}catch(Exception e){
		System.out.println(e);
	}

}
%>