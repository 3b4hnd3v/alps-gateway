<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%String editpool="", poolsec="collapse"; %>
<% //Walled Garden
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Pool")) {
	
	try {
		String pname = request.getParameter("poolname").toString();
		String pranges = request.getParameter("ranges").toString();
		String nextpool = request.getParameter("nextpool").toString();
		
		
		g.addPool(pname, pranges, nextpool);
		
		String logact = "New Address pool "+pname+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=pool");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<% //Walled Garden
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Interface")) {
	
	try {
		String interf = request.getParameter("interface").toString();
		String intname = request.getParameter("intname").toString();
		String network = request.getParameter("network").toString();
		String ip = request.getParameter("ip").toString();
		
		
		g.addInterface(interf, intname, ip, network);
		
		String logact = "New Interface "+intname+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=ipaddress");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>

<% 
//remove walled garden
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("type").equals("pool")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.deletePool(item);
		
		String logact = "Address Pool "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=pool");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("service")) {
	
	try {
		String item = request.getParameter("service").toString();
		
		g.enableService(item);
		
		String logact = "Service "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=service");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("service")) {
	
	try {
		String item = request.getParameter("service").toString();
		
		g.disableService(item);
		
		String logact = "Service "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=service");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("revoke")&& request.getParameter("type").equals("lease")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.deleteLease(item);
		
		String logact = "Address Assignment "+item+" revoked By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("ippadd.jsp?q=lease");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
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
<% if(request.getParameter("q") != null && request.getParameter("q").equals("ipaddress")) { %>

<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Interface Addresses
           <small>List of Network Interfaces' IP Address</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">IP</a></li>
           <li class="active">Addresses</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Set Interface Addresses <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="interfaces.jsp" method="post">
               		<div class="form-group">
	                    <label>Interface Name:</label>
	                    <div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-laptop"></i>
	                      </div>
	                      <input type="text" class="form-control" name="intname">
	                    </div><!-- /.input group -->
	                  </div><!-- /.form group -->
	                  <br />
	                  <div class="form-group">
	                    <label>Network:</label>
	                    <div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-laptop"></i>
	                      </div>
	                      <input type="text" class="form-control" name="network">
	                    </div><!-- /.input group -->
	                  </div><!-- /.form group -->
	                  <br />
	                  <div class="form-group">
	                      <label>Interface</label>
	                      <select class="form-control" name="interface">
	                      <%for (Map<String,String> mp : g.interfaces()) {
	                      	out.println("<option>"+mp.get("name")+"</option>");}%>
	                      </select>
	                  </div><br />
	                  <div class="form-group">
	                    <label>IP Address:</label>
	                    <div class="input-group">
	                      <div class="input-group-addon">
	                        <i class="fa fa-globe"></i>
	                      </div>
	                      <input type="text" class="form-control" name="ip" placeholder="0.0.0.0/xx">
	                    </div><!-- /.input group -->
	                  </div><!-- /.form group -->
	                  <br />
	                  <input type="submit" name="submit" class="form-control btn btn-info" value="Add Interface" />
               </form>
             </div>
           </div>
         </div>
	</section>
       
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">Interface IP Addresses</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th><i class="fa fa-edit"></i></th>
                       <th>Interface</th>
                       <th>Address</th>
                       <th>Network</th>
                       <th>Dynamic</th>
                       <th>disabled</th>
                       <th class="text-danger">Invalid</th>
                       <th><i class="fa fa-cog"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   
	                for (Map<String,String> mp : g.ipaddress()) {
	                	String f = mp.get("comment");
	                	if(!String.valueOf(f).contains("default") && !String.valueOf(f).contains("Default")){
		                	//if(mp.get("actual-interface").equalsIgnoreCase("Master") || mp.get("actual-interface").contains("WAN")){
							  	String s = mp.get(".id");
							  	String btn_en = "<a href='?q=enable&type=interface&item="+s+"'><button class='btn btn-xs btn-success'>En</button></a>";
							  	String btn_ds = "<a href='?q=disable&type=interface&item="+s+"'><button class='btn btn-xs btn-warning'>Dis</button></a>";
							  	String btn_dl = "<a href='?q=remove&type=interface&item="+s+"'><button class='btn btn-xs btn-danger'>Del</button></a>";
							  	String btn_ed = "<a href='update.jsp?q=edit&type=ipaddress&item="+s+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
			
							  	out.println("<tr>");
								out.println("<td>"+btn_ed+"</td>");
								out.println("<td>"+mp.get("interface")+"</td>");
								out.println("<td>"+mp.get("address")+"</td>");
								out.println("<td>"+mp.get("network")+"</td>");
								out.println("<td>"+mp.get("dynamic")+"</td>");
								out.println("<td>"+mp.get("disabled")+"</td>");
								out.println("<td>"+mp.get("invalid")+"</td>");
								out.println("<td>"+btn_en+" "+btn_ds+" "+btn_dl+"</td>");
								out.println("</tr>");
		                	//}
	                	}
					}%>
                   </tbody>
                   
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("arp")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           ARP
           <small>- Address Resolution Protocol</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">IP</a></li>
           <li class="active">ARP</li>
         </ol>
       </section>
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">ARP List</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Interface</th>
                       <th>Address</th>
                       <th>Mac - Address</th>
                       <th>DHCP</th>
                       <th>Dynamic</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.arp()) {
					    //System.out.println(r);
					  	out.println("<tr>");
						out.println("<td>"+mp.get("interface")+"</td>");
						out.println("<td>"+mp.get("address")+"</td>");
						out.println("<td>"+mp.get("mac-address")+"</td>");
						out.println("<td>"+mp.get("DHCP")+"</td>");
						out.println("<td>"+mp.get("dynamic")+"</td>");
						out.println("</tr>");
					}%>
                   </tbody>
                   
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->   
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("lease")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Assigned IPs
           <small>Assigned DHCP Addresses</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">IP</a></li>
           <li class="active">Leases</li>
         </ol>
       </section>
       
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">Assigned IP Addresses</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Address</th>
                       <th>MAC</th>
                       <th>Location</th>
                       <th>Device</th>
                       <th>Lease Time</th>
                       <th>Last Seen</th>
                       <th><i class="fa fa-cogs"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.lease()) {
	                	String s = mp.get(".id");
					  	String btn_dl = "<a href='?q=revoke&type=lease&item="+s+"'><button title='Revoke Lease' class='btn btn-sm btn-danger'>Del</button></a>";
					    //System.out.println(r);
					  	out.println("<tr>");
						out.println("<td>"+mp.get("address")+"</td>");
						out.println("<td>"+mp.get("mac-address")+"</td>");
						out.println("<td>"+mp.get("server")+"</td>");
						out.println("<td>"+mp.get("host-name")+"</td>");
						out.println("<td>"+mp.get("expires-after")+"</td>");
						out.println("<td>"+mp.get("last-seen")+"</td>");
						out.println("<td>"+btn_dl+"</td>");
						out.println("</tr>");
					}%>
                   </tbody>
                   
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->   
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("pool")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           List of DHCP Pools
           <small>List of Available DHCP Pools</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">IP</a></li>
           <li class="active">DHCP Pool</li>
         </ol>
       </section>
       
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Add Pool <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             <form action="ippadd.jsp" method="post">
             	<input type="text" name="poolname" id="poolname" class="form-control" placeholder="Pool Name"><br />
             	<input type="text" name="ranges" id="ranges" class="form-control" placeholder="Ranges">
             	<div class="form-group">
                     <label>Next Pool</label>
                     <select class="form-control" name="nextpool">
                     <option></option>
                     <% 
                     	for (Map<String,String> mp : g.pool()) {
				  			String s = mp.get("name");
	                        out.println("<option>"+s+"</option>");
	                     	}
                       %>
                     </select>
                   </div>
             	<input type="submit" id="submit" name="submit" class="btn btn-success" value="Add Pool">
             </form>
             </div>
           </div>
         </div>
	</section>
       
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">DHCP Pools</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body  table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Name</th>
                       <th>Ranges</th>
                       <th>Next Pool</th>
                       <th><i class="fa fa-cogs"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   
	               for (Map<String,String> mp : g.pool()) {
					//System.out.println(r);
						String f = mp.get("comment");
					  	if(!String.valueOf(f).contains("default") && !String.valueOf(f).contains("Default")){
						  	String s = mp.get(".id");
						  	String btn_ed = "<a href='update.jsp?q=edit&type=pool&item="+s+"'><button class='btn btn-sm btn-warning'>Edit</button></a>";
						  	String btn_dl = "<a href='?q=delete&type=pool&item="+s+"'><button class='btn btn-sm btn-danger'>Del</button></a>";
		
						  	out.println("<tr>");
							out.println("<td>"+mp.get("name")+"</td>");
							out.println("<td>"+mp.get("ranges")+"</td>");
							out.println("<td>"+mp.get("next-pool")+"</td>");
							out.println("<td>"+btn_ed+" "+btn_dl+"</td>");
							out.println("</tr>");
					  	}
			  
					}%>
                   </tbody>
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("services")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Gateway Services
           <small>List of Available Gateway Services</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">IP</a></li>
           <li class="active">Services</li>
         </ol>
       </section>
       
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">List of Available Gateway Services</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body  table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Name</th>
                       <th>Port</th>
                       <th>Certificate</th>
                       <th>Disabled</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   	
	                for (Map<String,String> mp : g.services()) {
				    //System.out.println(r);
				  	String s = mp.get(".id");
				  	String btn_en = "<a href='?q=enable&type=service&service="+s+"'><button class='btn btn-sm btn-success'>Enable</button></a>";
				  	String btn_ds = "<a href='?q=disable&type=service&service="+s+"'><button class='btn btn-sm btn-danger'>Disable</button></a>";
				  	out.println("<tr>");
					out.println("<td>"+mp.get(".id")+"</td>");
					out.println("<td>"+mp.get("name")+"</td>");
					out.println("<td>"+mp.get("port")+"</td>");
					out.println("<td>"+mp.get("certificate")+"</td>");
					out.println("<td>"+mp.get("disabled")+"</td>");
					out.println("<td>"+btn_en+"  "+btn_ds+"</td>");
					out.println("</tr>");
				  
				  
				}%>
                   </tbody>
                   
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
       <%}%>
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
<script>
  $(function () {
	$("#example1").DataTable({"responsive": true});
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false
    });
  });
</script>
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