<%@include file="header.jsp" %>

 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public String editpool=""; 
public String poolsec="collapse";%>
<% //Walled Garden
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add DNS")) {
	
	try {
		String dname = request.getParameter("dname").toString();
		String addr = request.getParameter("addr").toString();
		String ttl = request.getParameter("ttl").toString();
		
		
		if(g.addDns(dname, addr, ttl)){
			String logact = "New DNS Entry "+dname+" added By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			response.sendRedirect("dns.jsp?q=dns&msg=DNS Successfully added&type=success");
		}else{
			response.sendRedirect("dns.jsp?q=dns&msg=Could Not Add DNS. Please Try Again!&type=error");
		}
		
	} catch (Exception e1) {System.out.println(e1); }
}
%>

<% //Walled Garden
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Settings")) {
	
	try {
		String servers = request.getParameter("servers").toString();
		String arr = request.getParameter("arr").toString();
		String mups = request.getParameter("mups").toString();
		String qsto = request.getParameter("qsto").toString();
		String qtto = request.getParameter("qtto").toString();
		String csize = request.getParameter("csize").toString();
		String cmttl = request.getParameter("cmttl").toString();
		
		g.updateDNS(servers, arr , mups, qsto, qtto, csize, cmttl);
		
		String logact = "DNS Settings Updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("dns.jsp?q=dnssettings&msg=Settings Updated Successfully&type=success");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("dns.jsp?q=dnssettings&msg=Settings Could Not Be Updated.&type=success");
}
}
%>

<% 
//remove walled garden
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("type").equals("dns")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.deleteDNS(item);
		
		String logact = "Address Pool "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=Settings Deleted Successfully&type=success");
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=Settings Could Not Be Deleted.&type=error");
	}
}else if(request.getParameter("q") != null && request.getParameter("q").equals("clear")&& request.getParameter("type").equals("dns")) {
	
	try {
		g.flushDNS();
		
		String logact = "DNS Entries flushed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=DNS Cache Cleared Successfully&type=success");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); 		
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=DNS Could Not Be Cleared.&type=error");
}
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("dns")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.enableDNS(item);
		
		String logact = "DNS Item "+item+" enabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=DNS Enabled Successfully&type=success");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=DNS Could not be enabled.&type=success");
	}
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("dns")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.disableDNS(item);
		
		String logact = "DNS item "+item+" disabled By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=DNS Disabled Successfully&type=success");
		
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("dns.jsp?q=dnsstatic&msg=DNS Could not be disabled.&type=success");
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
<% if(request.getParameter("q") != null && request.getParameter("q").equals("dns")) { %>

<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           DNS
           <small>Domain Name Server</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">IP</a></li>
           <li class="active">DNS</li>
         </ol>
       </section>
       
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title col-md-5">DNS Cache</h3>
                 <%@include file="import.jsp" %>
                 <button class="btn btn-md btn-primary pull-center">Clear Cache &times;</button>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Address</th>
                       <th>Site Name</th>
                       <th>Time To Live</th>
                       <th>Static</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.dnscache()) {
	                	if(!String.valueOf(mp.get("address")).contains("10.11.12") || String.valueOf(mp.get("address")).contains("192.169.0") || !String.valueOf(mp.get("name")).contains("alps")){
						  	out.println("<tr>");
							out.println("<td>"+mp.get("address")+"</td>");
							out.println("<td>"+mp.get("name")+"</td>");
							out.println("<td>"+mp.get("ttl")+"</td>");
							out.println("<td>"+mp.get("static")+"</td>");
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
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("dnsstatic")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Static DNS
           <small>Static Domain Name Server</small>
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
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Add New <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             <form>
	             <label>Name</label>
					<input type="text" class="form-control" name="dname"><br />
	             <label>Address</label>
					<input type="text" class="form-control" name="addr"><br />
				 <label>Time To Leave</label>
					<input type="text" class="form-control" name="ttl"><br />
					
				 <input type="submit" name="submit" class="form-control btn btn-info col-md-12" value="Add DNS" />
				
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
                 <h3 class="box-title">Static DNS</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th class='noExl'><i class="fa fa-edit"></i></th>
                       <th>Address</th>
                       <th>Site Name</th>
                       <th>Time To Leave</th>
                       <th>Disabled</th>
                       <th>Regexp</th>
                       <th class='noExl'><i class="fa fa-cog"></i></th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.staticdns()) {
	                	if(!String.valueOf(mp.get("address")).contains("10.11.12") || !String.valueOf(mp.get("name")).contains("alps")){

		                	if(mp.containsKey("comment") && !String.valueOf(mp.get("comment")).equalsIgnoreCase("Default") && !String.valueOf(mp.get("comment")).contains("Default")&& !String.valueOf(mp.get("comment")).contains("default")){
							    String actbtn = "";
							  	if(mp.get("disabled").equals("true")){
							  		actbtn = "<a href='?q=enable&type=dns&item="+mp.get(".id")+"'><button class='btn btn-xs btn-success'>Enable</button></a>";
							  	}else{
							  		actbtn = "<a href='?q=disable&type=dns&item="+mp.get(".id")+"'><button class='btn btn-xs btn-danger'>Disable</button></a>";
							  	}
							  	String btn_ed = "<a href='update.jsp?q=edit&type=dns&item="+mp.get(".id")+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
							  	String btn_dl = "<a href='?q=delete&type=dns&item="+mp.get(".id")+"'><button class='btn btn-xs btn-danger'>Delete &times;</button></a>";
			
							  	out.println("<tr>");
								out.println("<td>"+btn_ed+" "+mp.get(".id")+"</td>");
								out.println("<td>"+mp.get("address")+"</td>");
								out.println("<td>"+mp.get("name")+"</td>");
								out.println("<td>"+mp.get("ttl")+"</td>");
								out.println("<td>"+mp.get("disabled")+"</td>");
								out.println("<td>"+mp.get("regexp")+"</td>");
								out.println("<td class='noExl'>"+actbtn+"   "+btn_dl+"</td>");
								out.println("</tr>");
		                	}else{
		                		String actbtn = "";
							  	if(mp.get("disabled").equals("true")){
							  		actbtn = "<a href='?q=enable&type=dns&item="+mp.get(".id")+"'><button class='btn btn-xs btn-success'>Enable</button></a>";
							  	}else{
							  		actbtn = "<a href='?q=disable&type=dns&item="+mp.get(".id")+"'><button class='btn btn-xs btn-danger'>Disable</button></a>";
							  	}
							  	String btn_ed = "<a href='update.jsp?q=edit&type=dns&item="+mp.get(".id")+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
							  	String btn_dl = "<a href='?q=delete&type=dns&item="+mp.get(".id")+"'><button class='btn btn-xs btn-danger'>Delete &times;</button></a>";
			
							  	out.println("<tr>");
								out.println("<td>"+btn_ed+" "+mp.get(".id")+"</td>");
								out.println("<td>"+mp.get("address")+"</td>");
								out.println("<td>"+mp.get("name")+"</td>");
								out.println("<td>"+mp.get("ttl")+"</td>");
								out.println("<td>"+mp.get("disabled")+"</td>");
								out.println("<td>"+mp.get("regexp")+"</td>");
								out.println("<td class='noExl'>"+actbtn+"   "+btn_dl+"</td>");
								out.println("</tr>");
		                	}
	                	}
					}%>
                  </tbody>
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("dnssettings")) { %>
	
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
             <%!public static String servers="", arr="", mups="", qsto="", qtto="", csize="", cmttl="", cused="";%>
             <%
               for (Map<String,String> mp : g.dns()) {
            	   servers=mp.get("servers");
            	   arr= mp.get("allow-remote-requests");
            	   mups=mp.get("max-udp-packet-size"); 
            	   qsto=mp.get("query-server-timeout");
            	   qtto=mp.get("query-total-timeout");
            	   csize=mp.get("cache-size");
            	   cmttl=mp.get("cache-max-ttl");
            	   cused=mp.get("cache-used");
               }
             %>
             <form action="#" method="post">
	             <!-- <label>Servers</label> -->
					<input type="hidden" class="form-control" name="servers" value="<% out.println(servers);%>">
					<!-- <small>To add server, append <b class="text-danger">",0.0.0.0"</b> to this field and click Update Setting.</small><br /> -->
	             <label>Allow Remote Request</label>
					<input type="text" class="form-control" name="arr" value="<% out.println(arr);%>"><br />
				 <label>Max UDP Packet Size</label>
					<input type="text" class="form-control" name="mups" value="<% out.println(mups);%>"><br />
				 <label>Query Server Time Out</label>
					<input type="text" class="form-control" name="qsto" value="<% out.println(qsto);%>"><br />
	             <label>Query Total Time Out</label>
					<input type="text" class="form-control" name="qtto" value="<% out.println(qtto);%>"><br />
				 <label>Cache Size (KiB)</label>
					<input type="text" class="form-control" name="csize" value="<% out.println(csize);%>"><br />
				<label>Cache Max Time To Leave(dd 00:00:00)</label>
					<input type="text" class="form-control" name="cmttl" value="<% out.println(cmttl);%>"><br />
				<label>Cache Used (KiB)</label>
					<input type="text" readonly class="form-control" name="cused" value="<% out.println(cused);%>"><br />
					
				 <input type="submit" name="submit" class="form-control btn btn-info col-md-12" value="Update Settings" />
				
             </form>
             </div>
           </div>
         </div>
	</section>
       
       <%} else{%>
          <!-- Error Message -->
			
			<% }%>
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