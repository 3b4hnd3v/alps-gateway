<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="toolbar.jsp" %>
<% 
	ComExec cex = new ComExec(); MasterApi mg = new MasterApi(); Mao mao = new Mao(); 
	String ipmessage = "", submitbtn = "", ipbtn = "", actpl = "collapse";
	String ident="", name="", address="", ip="", nm="", gateway="", pr="", gstat="", result="", dfi="", dfo="", dr="", drm=""; 
%>
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	  <h1>
	    LetMeOut<sup>TM</sup> IP Settings
	    <small>WAN LetMeOut<sup>TM</sup> IP Settings</small>
	  </h1>
	  <ol class="breadcrumb">
	    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	    <li><a href="#">Main</a></li>
	    <li class="">WAN</li>
	    <li class="active">Interfaces</li>
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
		for (Map<String,String> mt : mg.interfaces()) {
			String intname = mt.get("name");
			String intid = mt.get(".id");
			if(intname.contains("WAN")){
	%>
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
									<a href="?q=activate&interf=<%=intname%>&ident=<%=intid%>">
										<button class="btn btn-info col-sm-12">Activate <%out.println(intname);%></button>
									</a>
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
					 	
					 	submitbtn="<a href='letmeout_ip.jsp?interf="+name+"&interf_id="+intid+"'><button class='btn btn-info pull-right'>Setup LetMeOut<sup>TM</sup></button></a>";
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
				<% } %>
				<div class="box-footer">
				    <%=submitbtn %>
				</div><!-- /.box-footer -->
			</div><!-- /.box -->
			<%
			}
		}
		
	}catch(Exception e){
		System.out.println(e);
		name = "WAN";
		response.sendRedirect("mw_prefs.jsp");
	}
	%>
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