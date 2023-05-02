<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% ComExec cex = new ComExec(); MasterApi mg = new MasterApi(); Mao mao = new Mao(); String ipmessage = "", submitbtn = "", actpl = "collapse";
String ident="", name="", address="", ip="", nm="", gateway="", pr="", gstat="", result="", dfi="", dfo="", dfm=""; %>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("activate")) {
	System.out.println("Activate");
	try {
		ident = request.getParameter("ident");
		name = request.getParameter("interf");
		dfi = mg.getForwardingRule(name+"I");
	 	dfo = mg.getForwardingRule(name+"O");
	 	dfm = mg.getMangleRule(name);
	 	//dfr = mg.getRouteRule(name);
	 	actpl = "collapse in";
		
	} catch (Exception e1) { System.out.println(e1); }
}
if(request.getParameter("q") != null && request.getParameter("q").equals("prioritize")) {
	System.out.println("Prioritize");
	try {
		String prid = request.getParameter("item");
		String intname = request.getParameter("interf");
		if(mg.prioritize(prid) && mg.dePrioritize(intname)){
			ipmessage = request.getParameter("interf")+" is now priority #1";
		}else{
			ipmessage = "Failed to set "+request.getParameter("interf")+" to priority #1";
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<% 
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Activate Interface")) {
	System.out.println("anas");
	try {
		String iid = request.getParameter("ident");
		String nip = request.getParameter("ip");
		String nname = request.getParameter("interf");
		String netmask = request.getParameter("netmask");
		String network = request.getParameter("network");
		String defgateway = request.getParameter("defgateway");
		String ipadd = nip+"/"+netmask;
		String dfii = request.getParameter("dfi");
		String dfoi = request.getParameter("dfo");
		String dfmr = request.getParameter("dfm");
		String def = mao.getSetting("ip");
		
		try{
			if(mg.enableInterface(iid)){
				if(mao.updateSetting("ip"+nname.substring(3),nip)){
					 mg.changeForwardingRule(nip, dfii, "dfi");
					 mg.changeForwardingRule(nip, dfoi, "dfo");
					 mg.changeMangleRule(ipadd, dfmr);
					 mg.changeRouteRule(defgateway, nname);
					 if(mg.changeMaster(nname, ipadd, network, defgateway)){
						String rswar = dao.getIpPath().replace("setip", "restartwar");
						cex.comExec(""+rswar);
						response.sendRedirect("http://"+def+"");
					 }else{
						ipmessage="Gateway Unreachable. Please Try Again. You can try pinging the default Ip address first";
					 }
				}
			}
		} catch(Exception e) {
			ipmessage="Gateway Unreachable. Please Try Again. You can try pinging the default Ip address first!";
		}
		
		String logact = "IP address set to "+ipadd+"/"+netmask+" on "+nname+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Alps Multi-WAN
    <small>Multi-WAN Interface Settings</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Main</a></li>
    <li class="active">Multi-WAN</li>
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

<%-- <section class="content-header">
	<div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                Interface Activation <span><i class="fa fa-angle-double-down"></i></span>
              </a>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse <%=actpl%>">
            <div class="box-body">
            	<form class="form-horizontal">
			    <div class="box-body">
			      <input type="hidden" required class="form-control" readonly id="dfi" name="dfi" value="<%out.println(dfi);%>">
			      <input type="hidden" required class="form-control" readonly id="dfo" name="dfo" value="<%out.println(dfo);%>">
			      <input type="hidden" required class="form-control" readonly id="dfm" name="dfm" value="<%out.println(dfm);%>">
			      <input type="hidden" required class="form-control" readonly id="ident" name="ident" value="<%out.println(ident);%>">
			       
			      <div class="form-group col-sm-4">
			        <label for="ip" class="col-sm-6 control-label">Interface Name</label><br />
			        <div class="col-sm-10">
			          <input type="text" class="form-control" required id="interf" name="interf" value="<%out.println(name);%>">
			        </div>
			      </div>
			      <div class="form-group col-sm-4">
			        <label for="ip" class="col-sm-6 control-label">IP Address</label><br />
			        <div class="col-sm-10">
			          <input type="text" required class="form-control" id="ip" name="ip" placeholder="0.0.0.0">
			        </div>
			      </div>
			      <div class="form-group col-sm-4">
			        <label for="netmask" class="col-sm-6 control-label">Netmask</label><br />
			        <div class="col-sm-10">
			          <input type="text" required class="form-control" id="netmask" name="netmask" placeholder="0.0.0.0">
			        </div>
			      </div>
			      <div class="form-group col-sm-4">
			        <label for="netmask" class="col-sm-6 control-label">Network</label><br />
			        <div class="col-sm-10">
			          <input type="text" required class="form-control" id="network" name="network" placeholder="0.0.0.0">
			        </div>
			      </div>
			      <div class="form-group col-sm-4">
			        <label for="netmask" class="col-sm-6 control-label">Default Gateway</label><br />
			        <div class="col-sm-10">
			          <input type="text" required class="form-control" id="defgateway" name="defgateway" placeholder="0.0.0.0">
			        </div>
			      </div>
			    </div><!-- /.box-body -->
			    <div class="box-footer">
			      <a href="#" ><button class="btn btn-default">Cancel</button></a>
			      <input type="submit" <%out.println(submitbtn);%> name="submit" class="btn btn-info pull-right" value="Activate Interface">
			    </div><!-- /.box-footer -->
			  </form>
            </div>
          </div>
        </div>
</section> --%>
<%try{
	for (Map<String,String> mt : mg.interfaces()) {
		String intname = mt.get("name");
		String intid = mt.get(".id");
		if(intname.contains("WAN")){
		%>
		<section class="content">
			<!-- Horizontal Form -->
			<div class="box box-info">
			  <div class="box-header with-border">
			    <h3 class="box-title"><small><%=intname %></small></h3>
			  </div><!-- /.box-header -->
		<%
			List<Map<String,String>> rs = mg.interfadd(intname);
			if(rs.isEmpty()){
		%>
				<div class="box-body" align="center">
					<div class="form-group" align="center">
				        <label for="netmask" class="control-label"><%out.println(intname);%>Activate This Interface</label><br />
				        <div class="">
				          <a href="?q=activate&interf=<%=intname%>&ident=<%=intid%>"><button class="btn btn-info col-sm-12">Activate <%out.println(intname);%></button></a>
				          
				        </div>
			      </div>
				</div>
		<%
			}else{
				Map<String,String> mp = rs.get(0);
				ident = mp.get(".id");
				name = mp.get("interface");
			 	address = mp.get("address");
			 	String[] add = address.split("/");
			 	ip = add[0];
			 	nm = add[1];
			 	gateway = mp.get("network");
			 	pr = mg.getPriorityRule(name);
			 	
			 	submitbtn="<a href='?q=prioritize&interf="+name+"&item="+pr+"'><button class='btn btn-info pull-right'>Set Priority</button></a>";
		%>
				<div class="box-body">
			      <div class="form-group col-sm-3">
			        <label for="ip" class="col-sm-6 control-label">Name</label><br />
			        <div class="col-sm-10">
			          <%out.println(name);%>
			        </div>
			      </div>
			      <div class="form-group col-sm-3">
			        <label for="ip" class="col-sm-6 control-label">IP Address</label><br />
			        <div class="col-sm-10">
			          <%out.println(ip);%>
			        </div>
			      </div>
			      <div class="form-group col-sm-3">
			        <label for="netmask" class="col-sm-6 control-label">Netmask</label><br />
			        <div class="col-sm-10">
			          <%out.println(nm);%>
			        </div>
			      </div>
			      <div class="form-group col-sm-3">
			        <label for="netmask" class="col-sm-6 control-label">Network</label><br />
			        <div class="col-sm-10">
			          <%out.println(gateway);%>
			        </div>
			      </div>
			    </div> 
		<%
			}
			
		
		%>
			<div class="box-footer">
		    <!-- <a href="#" ><button class="btn btn-default">Cancel</button></a> -->
		    <%=submitbtn %>
		  </div><!-- /.box-footer -->
		</div><!-- /.box -->
		</section>
		<%
		}
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