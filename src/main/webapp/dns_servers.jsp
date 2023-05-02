<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>

<%
String servers="";
for (Map<String,String> mp : g.dns()) {
	   servers=mp.get("servers");
}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Settings")) {
	try {
		String alls[] = request.getParameterValues("servers");
		String newserver = request.getParameter("newserver");
		String new_servers = "";
		
		for (int i = 0; i < alls.length; i++) {
			if(i>0){
				new_servers = new_servers + "," + alls[i];
			}else{
				new_servers = new_servers + alls[i];
			}
		}
		
		
		if(newserver != ""){
			new_servers = new_servers + "," + newserver;
		}
		System.out.println(new_servers);
		
		g.updateDNSServer(new_servers);
		
		String logact = "DNS Settings Updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("dns_servers.jsp?q=dnssettings&msg=Settings Updated Successfully&type=success");
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		e1.printStackTrace();
		response.sendRedirect("dns_servers.jsp?q=dnssettings&msg=Settings Could Not Be Updated.&type=error");
	}
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
           DNS Settings
           <small>Domain Name Server Settings</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">IP</a></li>
           <li class="active">DNS</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a>
                 DNS Settings  <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse in">
             <div class="box-body">
	             <form action="#" method="post">
	             	<% 
	             	String[] all = servers.split(",");
	             	for(String each : all){
	             		if(!each.contains("10.11.12.")){
	             	%>
		             	<div class="form-group">
			             	<label>Servers</label>
			             	<input type="text" class="form-control" name="servers" value="<% out.println(each);%>">
			             	<small> Edit this DNS entry or add new below.</small>
			             	<br />
		             	</div>
					<% } } %>	
					<div class="form-group">
		             	<label>Add New Server</label>
		             	<input type="text" class="form-control" name="newserver" placeholder="0.0.0.0">
	             	</div>
					<input type="submit" name="submit" class="form-control btn btn-info col-md-12" value="Update Settings" />
	             </form>
             </div>
           </div>
         </div>
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
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
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
<!--Table Export-->
<script>
function tableExport() {
   // check whether tableExport plugin is loaded
   if (typeof $.tableExport !== "function") {
   	$.getScript("js/tableexport/tableExport.js");
   	$.getScript("js/tableexport/jquery.base64.js");
   	$.getScript("js/tableexport/html2canvas.js");
   	$.getScript("js/tableexport/jspdf/libs/sprintf.js");
   	$.getScript("js/tableexport/jspdf/jspdf.js");
   	$.getScript("js/tableexport/jspdf/libs/base64.js");
   }
};
</script>
<!-- page script -->
</body>
</html>