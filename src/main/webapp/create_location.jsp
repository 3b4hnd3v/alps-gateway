<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%! Location loc = new Location(); %>
<% //Add Vlan
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create Location")) {
	
	String locname = "", vlanid="", loginby="", vlname = "", poolname="", addrange="", ip="", network="", smask="", ldp="", rad="", rate="", gwip="";
	
	try {
		locname = request.getParameter("locname").toString().replace(" ", "");
		vlanid = request.getParameter("vlanid").toString();
		vlname = request.getParameter("vlname").toString();
		addrange = request.getParameter("addrange").toString();
		ip = request.getParameter("ip").toString();
		network = request.getParameter("network").toString();
		String lb[] = 	request.getParameterValues("lb");
		smask = request.getParameter("smask").toString();
		ldp = request.getParameter("ldp").toString();
		rad = request.getParameter("radius").toString();
		rate = request.getParameter("rate").toString();
		String dns = locname+".alpsgateway.net";
		String cert = request.getParameter("cert").toString();
		for (int i = 0; i < lb.length; i++) {if(i>0){loginby =loginby+","+lb[i];}else{loginby =loginby+lb[i];}}

		String ipmask = ip+smask;
		String badip = ip.replace(".", ":");
		String[] ipchunk = badip.split(":");		
		gwip = ip;
				
		String dhcpname = locname+"_dhcp";
		String pname = locname+"_hsp";
		String sname = locname+"_hotspot";
		poolname = locname+"_pool";
		String cto = "3d";
				
		String interf = "LAN";
		String netadd = network+smask;
		System.out.println("netadd="+netadd);
		
		if(loc.createBridge(locname) && loc.addVlan(vlanid, vlname, interf, "reply-only").equals("Yes") && loc.addPort(vlname, locname)){
			if(loc.addPool(poolname, addrange, "none") && loc.add_dhcp(dhcpname, locname, poolname, "00:10:00", "static") && loc.add_DhcpNet(netadd, gwip, locname)){
				if(loc.addAddress(locname, ip+smask, network )){
					
					loc.addhs_prof(pname, ip, ldp, loginby, cto, rad, dns, cert, rate);
					loc.addhs_server(sname, pname, locname, poolname, "1", "0", "0");
					loc.addMasqurade(locname, netadd);
					
				}else{
					response.sendRedirect("zone_manager.jsp?msg=Location Created. Please Proceed to Add Address and Hotspot&type=error");
				}
			}else{
				response.sendRedirect("zone_manager.jsp?msg=Location Creation Failed.&type=error");
			}
		}else{
			response.sendRedirect("zone_manager.jsp?msg=Location Creation Failed. Vlan or Location Already Exist.&type=error");

		}
		response.sendRedirect("zone_manager.jsp?msg=Location Successfully Created.&type=success");
		
	}catch(Exception e){
		System.out.println(e);
	}

}
%>