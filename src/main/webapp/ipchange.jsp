<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% ComExec cex = new ComExec(); MasterApi mg = new MasterApi(); Mao mao = new Mao(); String ipmessage = "", submitbtn = "";
String ident="", name="", address="", ip="", nm="", gateway="", gstat="", result="", dfi="", dfo="", dfm=""; %>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("pingip")) {
	try {
		String gip = dao.getip();
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
%>
<% 
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Change IP")) {
	System.out.println("anas");
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
		String dfmr = request.getParameter("dfm");
		String dns = request.getParameter("dns");
		
		try{
			boolean drf = true;
			/*if(nname.equals("WAN")){
				drf = dao.updateIP("default_ip",nip);
			}else{drf=true;}*/
			if(drf){
				 mao.updateSetting(nname.replace("WAN", "ip"), nip);
				 
				 //This changes default ip in masterset to the new ip. This is not needed.
				 //mao.updateSetting("default_ip", nip);
				 
				 mg.changeForwardingRule(nip, dfii, "dfi");
				 mg.changeForwardingRule(nip, dfoi, "dfo");
				 mg.changeMangleRule(ipadd, dfmr);
				 mg.changeRouteRule(defgateway, nname);
				 if(mg.changeIp(id, nname, ipadd, network, defgateway, dns)){
					String rswar = dao.getIpPath().replace("setip", "restartwar");
					cex.comExec(""+rswar);
						
					String def = mao.getSetting("ip");
					response.sendRedirect("http://"+def+"");
				 }else{
					ipmessage="Gateway Unreachable. Please Try Again. You can try pinging the default Ip address first";
				 }
			}
		} catch(Exception e) {
			ipmessage="Gateway Unreachable. Please Try Again. You can try pinging the default Ip address first!";
		}
		
		String logact = "IP address changed to "+ipadd+"/"+netmask+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Alps WAN Settings
    <small>WAN IP Settings</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Main</a></li>
    <li class="active">WAN IP</li>
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
<% 
try{
	for (Map<String,String> mp : mg.ipaddress()) {
		if(mp.get("interface").contains("WAN")){ 
			ident = mp.get(".id");
			name = mp.get("interface");
		 	address = mp.get("address");
		 	String[] add = address.split("/");
		 	ip = add[0];
		 	nm = add[1];
		 	gateway = mp.get("network");
		 	dfi = mg.getForwardingRule(name+"I");
		 	dfo = mg.getForwardingRule(name+"O");
		 	dfm = mg.getMangleRule(name);
%>
<section class="content">
<!-- Horizontal Form -->
<div class="box box-info">
  <div class="box-header with-border">
    <h3 class="box-title"><small>Please Confirm Your Network Settings Before Changing.</small></h3>
  </div><!-- /.box-header -->
  <!-- form start -->
  <form class="form-horizontal">
    <div class="box-body">
      <input type="hidden" required class="form-control" readonly id="dfi" name="dfi" value="<%out.println(dfi);%>">
      <input type="hidden" required class="form-control" readonly id="dfo" name="dfo" value="<%out.println(dfo);%>">
      <input type="hidden" required class="form-control" readonly id="ident" name="ident" value="<%out.println(ident);%>">
      <input type="hidden" required class="form-control" readonly id="dfm" name="dfm" value="<%out.println(dfm);%>">
        
      <div class="form-group col-sm-4">
        <label for="ip" class="col-sm-6 control-label">Interface Name</label><br />
        <div class="col-sm-10">
          <input type="text" class="form-control" required id="interf" name="interf" value="<%out.println(name);%>">
        </div>
      </div>
      <div class="form-group col-sm-4">
        <label for="ip" class="col-sm-6 control-label">IP Address</label><br />
        <div class="col-sm-10">
          <input type="text" required class="form-control" id="ip" name="ip" placeholder="0.0.0.0" value="<%out.println(ip);%>">
        </div>
      </div>
      <div class="form-group col-sm-4">
        <label for="netmask" class="col-sm-6 control-label">Netmask</label><br />
        <div class="col-sm-10">
          <input type="text" required class="form-control" id="netmask" name="netmask" placeholder="0.0.0.0/24" value="<%out.println(nm);%>">
        </div>
      </div>
      <div class="form-group col-sm-4">
        <label for="netmask" class="col-sm-6 control-label">Network</label><br />
        <div class="col-sm-10">
          <input type="text" required class="form-control" id="network" name="network" placeholder="0.0.0.0/24" value="<%out.println(gateway);%>">
        </div>
      </div>
      <div class="form-group col-sm-4">
        <label for="netmask" class="col-sm-6 control-label">Default Gateway</label><br />
        <div class="col-sm-10">
          <input type="text" required class="form-control" id="defgateway" name="defgateway" placeholder="0.0.0.0">
        </div>
      </div>
      <div class="form-group col-sm-4">
        <label for="netmask" class="col-sm-6 control-label">DNS</label><br />
        <div class="col-sm-12">
          <input type="text" required class="form-control" id="dns" name="dns" value="8.8.8.8,8.8.4.4">
          <small>Append More DNS with ","</small>
        </div>
        
      </div>
    </div><!-- /.box-body -->
    <div class="box-footer">
      
      <input type="submit" <%out.println(submitbtn);%> name="submit" class="btn btn-info pull-right" value="Change IP">
    </div><!-- /.box-footer -->
  </form>
</div><!-- /.box -->
</section>
<% }
	}
}catch(Exception e){System.out.println(e);
name = "WAN";
response.sendRedirect("mw_prefs.jsp");
}%>
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