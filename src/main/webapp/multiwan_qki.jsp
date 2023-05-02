<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% 
ComExec cex = new ComExec(); MasterApi mg = new MasterApi(); Mao mao = new Mao(); String ipmessage = "", act_int = "";
String ident="", name="", address="", ip="", nm="", gateway="", gstat="", result="", dfi="", dfo="", dr="", drm=""; 
String intro = "Please Confirm Your Network Settings Before Changing.",
submitbtn = "<input type='submit' name='submit' class='btn btn-info pull-right' value='Change IP'>";
if(request.getParameter("interface") != null) {
	act_int = request.getParameter("interface");
}
if(request.getParameter("q") != null && request.getParameter("q").equals("pingip")) {
	try {
		String gip = dao.getSetting("ip");
		InetAddress iaddress = InetAddress.getByName(gip);
		boolean chkConnection = iaddress.isReachable(6000);
		if (chkConnection == true){
			gstat = "Reached";
			result = "Reachable";
		} else {
			gstat = "Unreached";
			result = "Unreachable";
		}
	} catch (Exception e1) { System.out.println(e1); }
}

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Change IP")) {
	//System.out.println("");
	try {
		String id = request.getParameter("ident").toString();
		String nip = request.getParameter("ip").toString();
		String nname = request.getParameter("interf").toString();
		String netmask = request.getParameter("netmask").toString();
		String network = request.getParameter("network").toString();
		String defgateway = request.getParameter("defgateway").toString();
		String ipadd = nip+"/"+netmask;
		String dfii = request.getParameter("dfi");
		String dfoi = request.getParameter("dfo");
		String dri = request.getParameter("dr");
		String drmi = request.getParameter("drm");
		String def = mao.getSetting("ip");
		
		try{
			boolean drf = true;
			//If WAN Interface IP is changed, change default ip in settings
			//if(nname.equals("WAN")){ drf = dao.updateIP("default_ip",nip);}
			
			if(drf){
				 //Change the IP entry for ip, ip1 or Ip2
				 mao.updateSetting(nname.replace("WAN", "ip"), nip);
				 
				 //This changes default ip in masterset to the new ip. This is not needed.
				 //mao.updateSetting("default_ip", nip);
				 
				 mg.changeForwardingRule(nip, dfii, "dfi");
				 mg.changeForwardingRule(nip, dfoi, "dfo");
				 mg.changeRoute(defgateway, dri);
				 mg.changeRoute(defgateway, drmi);
				 //mg.changeRouteRule(defgateway, nname);
				 if(mg.changeIp(id, nname, ipadd, network, defgateway)){
					 String rswar = dao.getSetting("restart_path");
					cex.comExec(""+rswar);
					
					ipmessage="multiwan_int.jsp?msg=IP Setup Sucessfully Done&type=success";					
					
				 }else{
					ipmessage="multiwan_int.jsp?msg=Gateway Unreachable. Please Try Again. You can try pinging the default Ip address first&type=error";
				 }
			}
		} catch(Exception e) {
			ipmessage="multiwan_int.jsp?msg=Gateway Unreachable. Please Try Again. You can try pinging the default Ip address first!&type=error";
		}
		
		String logact = "IP address changed to "+ipadd+"/"+netmask+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect(ipmessage);
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<div class="content-wrapper">
<%if(request.getParameter("msg") != null && request.getParameter("type").equals("error")){ %>
	<div class="alert alert-danger alert-dismissible">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <h4><i class="icon fa fa-ban"></i> Oops :( !</h4>
	  <%out.println(request.getParameter("msg")); %>
	</div>
<%}else if(request.getParameter("msg") != null && request.getParameter("type").equals("success")){ %>
	<div class="alert alert-info alert-dismissible">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <h4><i class="icon fa fa-info"></i> Alert!</h4>
	  <%out.println(request.getParameter("msg")); %>
	</div>
<%}%>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    WAN Settings
    <small>Interface IP Setup</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">MultiWan</a></li>
    <li class="active">Quick IP Setup</li>
  </ol>
</section>

<section class="content-header"><p></p></section>
<%if(request.getParameter("msg") != null && request.getParameter("type").equals("error")){ %>
<div class="alert alert-danger alert-dismissible">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4><i class="icon fa fa-ban"></i> Oops :( !</h4>
  <%out.println(request.getParameter("msg")); %>
</div>
<%}else if(request.getParameter("msg") != null && request.getParameter("type").equals("success")){ %>
<div class="alert alert-info alert-dismissible">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4><i class="icon fa fa-info"></i> Alert!</h4>
  <%out.println(request.getParameter("msg")); %>
</div>

<%} %>
<%if(ipmessage != null && !ipmessage.equals("")){ %>
<div class="alert alert-info alert-dismissible">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4><i class="icon fa fa-info"></i> Alert!</h4>
  <%out.println(ipmessage); %>
</div>
<%} %>

<section class="content">
<% 
try{
	for (Map<String,String> mp : mg.ipaddress()) {
		if(mp.get("interface").equals(act_int)){ 
			ident = mp.get(".id");
			name = mp.get("interface");
		 	address = mp.get("address");
		 	
		 	if(address.contains("/")){
			 	String[] add = address.split("/");
			 	ip = add[0];
			 	nm = add[1];
		 	}else{
		 		ip = address;
			 	nm = "29";
		 	}
		 	gateway = mp.get("network");
		 	dfi = mg.getForwardingRule(name+"I");
		 	dfo = mg.getForwardingRule(name+"O");
		 	dr = mg.WBRoute(name,"DefaultRoute");
		 	drm = mg.WBRoute(name,"DefaultRouteMark");
		 	
		 	if(String.valueOf(dfi).equals("0") || String.valueOf(dfo).equals("0") || String.valueOf(dr).equals("0") || String.valueOf(drm).equals("0")){
		 		submitbtn = "<input disabled type='submit' name='notallowed' value='Not Allowed' class='btn btn-info pull-right fa fa-block' value=''>";
		 		intro = "IP for "+name+" can not be change because one of it's firewall rules are missing.";
		 	}
		 	//System.out.println("ADDRESS ON:"+address);
%>

<!-- Horizontal Form -->
<div class="box box-info">
  <div class="box-header with-border">
    <h3 class="box-title"><small><%= intro %></small></h3>
  </div><!-- /.box-header -->
  <!-- form start -->
  <form action="#" method="post">
    <div class="box-body">
      <input type="hidden" required class="form-control" readonly id="dfi" name="dfi" value="<%out.println(dfi);%>">
      <input type="hidden" required class="form-control" readonly id="dfo" name="dfo" value="<%out.println(dfo);%>">
      <input type="hidden" required class="form-control" readonly id="ident" name="ident" value="<%out.println(ident);%>">
      <input type="hidden" required class="form-control" readonly id="dr" name="dr" value="<%out.println(dr);%>">
      <input type="hidden" required class="form-control" readonly id="drm" name="drm" value="<%out.println(drm);%>">
      <div class="row">
	      <div class="form-group col-sm-6">
	        <label for="ip" class="col-sm-12 control-label">Interface Name</label><br />
	        <div class="col-sm-12">
	          <input type="text" class="form-control" readonly required id="interf" name="interf" value="<%out.println(name);%>">
	        </div>
	      </div>
	      <div class="form-group col-sm-6">
	        <label for="ip" class="col-sm-12 control-label">IP Address</label><br />
	        <div class="col-sm-12">
	          <input type="text" required class="form-control" id="ip" name="ip" placeholder="0.0.0.0" value="<%out.println(ip);%>">
	        </div>
	      </div>
	      <div class="form-group col-sm-6">
	        <label for="netmask" class="col-sm-12 control-label">Netmask</label><br />
	        <div class="col-sm-12">
	          <input type="text" required class="form-control" style="width:100%" id="netmask" name="netmask" placeholder="0.0.0.0/24" value="<%out.println(nm);%>">
	        </div>
	      </div>
	      <div class="form-group col-sm-6">
	        <label for="netmask" class="col-sm-12 control-label">Network</label><br />
	        <div class="col-sm-12">
	          <input type="text" required class="form-control" id="network" name="network" placeholder="0.0.0.0/24" value="<%out.println(gateway);%>">
	        </div>
	      </div>
	      <div class="form-group col-sm-12">
	        <label for="netmask" class="col-sm-12 control-label">Default Gateway</label><br />
	        <div class="col-sm-12">
	          <input type="text" required class="form-control" id="defgateway" name="defgateway" placeholder="0.0.0.0">
	        </div>
	      </div>
	      
      </div>
    </div><!-- /.box-body -->
    <div class="box-footer">
     	<%= submitbtn %>
    </div><!-- /.box-footer -->
  </form>
</div><!-- /.box -->

<% 		}
	}
}catch(Exception e){
	System.out.println(e);
	response.sendRedirect("mw_prefs.jsp");
}%>
</section>
</div><!-- /.content-wrapper -->
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> <%=sysver%>
  </div>
  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">Alps Gateway</a>.</strong> All rights reserved.
</footer>
</div> <!-- /.content -->
<!-- jQuery 2.1.4-->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script> 
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- ChartJS 1.0.1 -->
<script src="plugins/chartjs/Chart.min.js"></script>
<!-- page script -->
</body>
</html>