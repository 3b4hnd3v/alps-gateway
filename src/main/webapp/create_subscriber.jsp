<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%! Location loc = new Location(); %>
<% //Add Vlan
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Register New Subscriber")) {
	String locname = "", vlanid="", loginby="", vlname = "", poolname="", addrange="", ip="", network="", smask="", ldp="", rad="", rate="", gwip="";
	
	try {
		String xid = request.getParameter("nextid");
		String name = request.getParameter("subname").toLowerCase().replace(" ", "");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String[] plans = request.getParameter("subplan").split(":");
		String device = request.getParameter("device");
		String range = request.getParameter("addrange");
		String net = request.getParameter("network");
		String subnet = request.getParameter("smask");
		System.out.println("Pass here"+range);

		String xip = range.split("-")[0];
		String plan = plans[0];
		String duration = plans[2];
		String amount = plans[3];
		locname = name.toLowerCase().replace(" ", "");
		System.out.println("Pass here"+locname);
		vlanid = xid;
		vlname = "vlan"+xid;
		poolname = locname+"pool";
		addrange = range;
		loginby = 	"http-chap,http-pap";
		smask = request.getParameter("smask");
		network = request.getParameter("network");
		ldp = "hotspot";
		rad = "false";
		rate = plans[1];
		String dns = locname+".alpsgateway.com";
		String cert = "none";
		
		String badip = xip.replace(".", ":");
		String[] ipchunk = badip.split(":");
		
  	  	//System.out.println(ipchunk.length);
		gwip = range.split("-")[0];
		int last = Integer.parseInt(ipchunk[3])+1;
		ip = ipchunk[0]+"."+ipchunk[1]+"."+ipchunk[2]+"."+String.valueOf(last);
		//network = ipchunk[0]+"."+ipchunk[1]+"."+ipchunk[2]+".0";
		String ipmask = ip+smask;
				
		String dhcpname = locname+"dhcp";
		String pname = locname+"hsp";
		String sname = locname+"hotspot";
		String cto = "3d";
		
		//System.out.println("gwip="+gwip);
		//System.out.println("addrange="+addrange);
		
		String interf = "LAN";
		String netadd = network+smask;
		System.out.println("netadd="+netadd);

		
		if(loc.createBridge(locname) && loc.addVlan(vlanid, vlname, interf, "enabled").equals("Yes") && loc.addPort(vlname, locname)){
			if(loc.addPool(poolname, addrange, "none") && loc.add_dhcp(dhcpname, locname, poolname, "00:10:00", "static") && loc.add_DhcpNet(netadd, gwip, locname)){
				if(loc.addAddress(locname, ip+smask, network )){
					loc.addhs_prof(pname, ip, ldp, loginby, cto, rad, dns, cert, rate);
					loc.addhs_server(sname, pname, locname, "none", "1", "0", "0");
					dao.addSubscriber(name, email, mobile, plan, device, duration);
					dao.addBilling(xid, plan, amount, duration);
				}else{
					response.sendRedirect("subscribers.jsp?msg=Location Created. Please Proceed to Add Address and Hotspot&type=error");
				}
			}else{
				response.sendRedirect("subscribers.jsp?msg=Location Creation Failed.&type=error");
			}
		}else{
			response.sendRedirect("subscribers.jsp?msg=Location Creation Failed. Vlan or Location Already Exist.&type=error");

		}
		response.sendRedirect("subscribers.jsp?msg=Location Successfully Created.&type=success");
		/*
		//create bridge
		loc.createBridge(locname);
				
		//create vlan
		loc.addVlan(vlanid, vlname, interf, "enabled");

		//add port
		loc.addPort(vlname, locname);
		
		//create pool
		loc.addPool(poolname, addrange, "none");
		
		//dhcp server
		loc.add_dhcp(dhcpname, locname, poolname, "00:10:00", "static");
		
		//dhcp server network
		loc.add_DhcpNet(netadd, gwip);
		
		//address
		loc.addAddress(locname, ip, netadd );
		
		//hsprof
		loc.addhs_prof(pname, ip, ldp, loginby, cto);
		
		//hsserver
		loc.addhs_server(sname, pname, interf, poolname, "1", "0", "0");
		*/
	}catch(Exception e){
		System.out.println(e);
	}

}
%>