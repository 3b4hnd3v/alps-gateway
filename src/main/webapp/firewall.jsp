<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Block Web Page")) {
	System.out.print(request.getParameter("submit"));
	try {
		String site = request.getParameter("webadd").toString();
		String site_ip = g.resolveSite(site);
		if(g.addWebFilter(site_ip, site)){
			String logact = "The Site "+site+" has been blocked By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			
			response.sendRedirect("firewall.jsp?q=webfiltering&msg=Blocked Successfully&type=success");
		}else{response.sendRedirect("firewall.jsp?q=webfiltering&msg=Fail to block&type=error");}
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Block Device")) {
	
	try {
		String dmac = request.getParameter("mac");
		
		if(g.addDevFilter(dmac)){
			String logact = "Device with MAC: "+dmac+" has been blocked By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			
			response.sendRedirect("firewall.jsp?q=devicefiltering&msg=Blocked Successfully&type=success");
		}else{response.sendRedirect("firewall.jsp?q=devicefiltering&msg=Fail to block&type=error");}
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Block Key Word")) {
	
	try {
		String key = request.getParameter("key").toString();
		
		if(g.addKeyFilter(key)){
			String logact = "Keyword '"+key+"' has been blocked By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			
			response.sendRedirect("firewall.jsp?q=keyfiltering&msg=Blocked Successfully&type=success");
		}else{response.sendRedirect("firewall.jsp?q=keyfiltering&msg=Fail to block&type=error");}
	} catch (Exception e1) { 
		System.out.println(e1); }
}%>
<% 
if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("filter")) {
	
	try {
		String item = request.getParameter("item").toString();
		String q = request.getParameter("from").toString();
		
		if(g.removeFilter(item)){
			response.sendRedirect("firewall.jsp?q="+q+"&msg=Remove Successfully&type=success");
		}else{response.sendRedirect("firewall.jsp?q="+q+"g&msg=Fail to Remove Filter&type=error");}
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("enable")&& request.getParameter("type").equals("filter")) {
	
	try {
		String item = request.getParameter("item").toString();
		String q = request.getParameter("from").toString();
		
		if(g.enableFilter(item)){
			response.sendRedirect("firewall.jsp?q="+q+"&msg=Enabled Successfully&type=success");
		}else{response.sendRedirect("firewall.jsp?q="+q+"g&msg=Fail to enable filter&type=error");}
		
	} catch (Exception e1) { System.out.println(e1); }
}else if(request.getParameter("q") != null && request.getParameter("q").equals("disable")&& request.getParameter("type").equals("filter")) {
	
	try {
		String item = request.getParameter("item").toString();
		String q = request.getParameter("from").toString();
		
		if(g.disableFilter(item)){
			response.sendRedirect("firewall.jsp?q="+q+"&msg=Disabled Successfully&type=success");
		}else{response.sendRedirect("firewall.jsp?q="+q+"g&msg=Fail to disable filter&type=error");}
		
	} catch (Exception e1) { System.out.println(e1); }
}%>
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
<% if(request.getParameter("q") != null && request.getParameter("q").equals("webfiltering")) { %>
	
	<!-- Content Header (Page header) -->
    <section class="content-header">
         <h1>
           Web Filtering
           <small>Block Specific Web Pages</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Filtering</a></li>
           <li class="active">Web</li>
         </ol>
    </section>
	<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Block Web Page <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="firewall.jsp" method="post">
	                  <div class="form-group">
		              	<label>Address</label>
						<input type="text" class="form-control" name="webadd" placeholder="www.site-to-block.com"><br />
		              </div>
					<input type="submit" name="submit" class="form-control btn btn-info" value="Block Web Page" />
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
              <h3 class="box-title">Web Page Filters</h3>
              <div class="btn-group pull-right">
				<button class="btn btn-danger dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bars"></i> Export Data</button>
				<ul class="dropdown-menu">
					<li><a href="#" onClick ="$('#example1').tableExport({type:'json', tableName:'users'});"><img src='dist/img/icons/json.png' width="24"/> JSON</a></li>
					<li class="divider"></li>
					<li><a href="#" onClick ="$('#example1').tableExport({type:'xml', tableName:'users'});"><img src='dist/img/icons/xml.png' width="24"/> XML</a></li>
					<li><a href="#" onClick ="$('#example1').tableExport({type:'sql', tableName:'users'});"><img src='dist/img/icons/sql.png' width="24"/> SQL</a></li>
					<li class="divider"></li>
					<li><a href="#" onClick ="try{$('#example1').tableExport({type:'excel'});}catch(err){alert(err.message);}"><img src='dist/img/icons/xls.png' width="24"/> XLS</a></li>
					<li><a href="#" onClick ="$('#example1').tableExport({type:'doc',escape:'false'});"><img src='dist/img/icons/word.png' width="24"/> Word</a></li>
				</ul>
              </div>
            </div><!-- /.box-header -->
            <div class="box-body">
            <div class="dataTable_wrapper">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Address</th>
                    <th>Comment</th>
                    <th>Rule</th>
                    <th>Protocol</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                <%
	              for (Map<String,String> mp : g.firewallRules1("webfil")) {
				  	//System.out.println(r);
				  	if(mp.containsKey("comment")&&!mp.get("comment").equalsIgnoreCase("Default")){
					  	String s = mp.get(".id");
					  	String btn_en = "<a href='?q=enable&type=filter&item="+s+"&from=webfiltering'><button class='btn btn-xs btn-success'>En</button></a>";
					  	String btn_ds = "<a href='?q=disable&type=filter&item="+s+"&from=webfiltering'><button class='btn btn-xs btn-warning'>Dis</button></a>";
					  	String btn_dl = "<a href='?q=remove&type=filter&item="+s+"&from=webfiltering'><button class='btn btn-xs btn-danger'>Del</button></a>";
					  	out.println("<tr>");
						out.println("<td>"+s+"</td>");
						out.println("<td>"+mp.get("dst-address")+"</td>");
						out.println("<td>"+mp.get("comment")+"</td>");
						out.println("<td>"+mp.get("action")+"</td>");
						out.println("<td>"+mp.get("protocol")+":"+mp.get("port")+"</td>");
						out.println("<td>"+mp.get("disabled")+"</td>");
						out.println("<td>"+btn_en+"  "+btn_ds+"  "+btn_dl+" </td>");
						out.println("</tr>");
				  	}
				  }
				%>
                </tbody>
                <tfoot>
                  
                </tfoot>
              </table>
              </div>
            </div><!-- /.box-body -->
          </div><!-- /.box -->
        </div><!-- /.col -->
      </div><!-- /.row -->
    </section><!-- /.content -->
    <script>
	   $(document).ready(function() {
	       $('#example1').DataTable({
	               responsive: true
	        });
	    });
   </script>
   <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("keyfiltering")) { %>

	<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Key Word Filtering
        <small>Block Specific Key Words</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">Filtering</a></li>
        <li class="active">Key Word</li>
      </ol>
    </section>
	<section class="content-header">
         <div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                 Key Word Filtering <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseTwo" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="firewall.jsp" method="post">
	                  <div class="form-group">
		              	<label>Enter Key Word</label>
						<input type="text" class="form-control" name="key" placeholder="KeyWord"><br />
		              </div>
					<input type="submit" name="submit" class="form-control btn btn-info" value="Block Key Word" />
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
                 <h3 class="box-title">Keyword Filters</h3>
                 <div class="btn-group pull-right">
					<button class="btn btn-danger dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bars"></i> Export Data</button>
					<ul class="dropdown-menu">
						<li><a href="#" onClick ="$('#example1').tableExport({type:'json', tableName:'users'});"><img src='dist/img/icons/json.png' width="24"/> JSON</a></li>
						<li class="divider"></li>
						<li><a href="#" onClick ="$('#example1').tableExport({type:'xml', tableName:'users'});"><img src='dist/img/icons/xml.png' width="24"/> XML</a></li>
						<li><a href="#" onClick ="$('#example1').tableExport({type:'sql', tableName:'users'});"><img src='dist/img/icons/sql.png' width="24"/> SQL</a></li>
						<li class="divider"></li>
						<li><a href="#" onClick ="try{$('#example1').tableExport({type:'excel'});}catch(err){alert(err.message);}"><img src='dist/img/icons/xls.png' width="24"/> XLS</a></li>
						<li><a href="#" onClick ="$('#example1').tableExport({type:'doc',escape:'false'});"><img src='dist/img/icons/word.png' width="24"/> Word</a></li>
					</ul>
                 </div>
                 <hr>
               </div><!-- /.box-header -->
               <div class="box-body">
               <div class="dataTable_wrapper">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Content</th>
                       <th>Rule</th>
                       <th>Protocol</th>
                       <th>Comment</th>
                       <th>Status</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
	                for (Map<String,String> mp : g.firewallRules1("keyfil")) {
				  		//System.out.println(r);
				  		if(mp.containsKey("comment")&&!mp.get("comment").equalsIgnoreCase("Default")){
						  	String s = mp.get(".id");
						  	String btn_en = "<a href='?q=enable&type=filter&item="+s+"&from=keyfiltering'><button class='btn btn-xs btn-success'>En</button></a>";
						  	String btn_ds = "<a href='?q=disable&type=filter&item="+s+"&from=keyfiltering'><button class='btn btn-xs btn-warning'>Dis</button></a>";
						  	String btn_dl = "<a href='?q=remove&type=filter&item="+s+"&from=keyfiltering'><button class='btn btn-xs btn-danger'>Del</button></a>";
						  	out.println("<tr>");
							out.println("<td>"+s+"</td>");
							out.println("<td>"+mp.get("content")+"</td>");
							out.println("<td>"+mp.get("action")+"</td>");
							out.println("<td>"+mp.get("protocol")+"</td>");
							out.println("<td>"+mp.get("comment")+"</td>");
							out.println("<td>"+mp.get("disabled")+"</td>");
							out.println("<td>"+btn_en+"  "+btn_ds+"  "+btn_dl+" </td>");
							out.println("</tr>");
				  		}
				  
					}%>
                   </tbody>
                   <tfoot>
                     
                   </tfoot>
                 </table>
                 </div>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
	<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("devicefiltering")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Device Filtering
           <small>Block Specific Devices</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Filtering</a></li>
           <li class="active">Device</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Block Device <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="firewall.jsp" method="post">
             		<div class="form-group">
					 	<label>Mac Address:</label>
						<input type="text" class="form-control" name="mac"><br />
	                </div>     
					<input type="submit" name="submit" class="form-control btn btn-info" value="Block Device" />
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
                 <h3 class="box-title">Device Filters</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped table-responsive">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Device Mac</th>
                       <th>Comment</th>
                       <th>Rule</th>
                       <th>Protocol</th>
                       <th>Status</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   
	                for (Map<String,String> mp : g.firewallRules1("macfil")) {
	                	if(mp.containsKey("comment")&&!mp.get("comment").equalsIgnoreCase("Default")){
		                	String s = mp.get(".id");
						  	String btn_dl = "<a href='?q=remove&type=filter&item="+s+"&from=devicefiltering'><button class='btn btn-xs btn-danger'>Del</button></a>";
						  	String btn_en = "<a href='?q=enable&type=filter&item="+s+"&from=devicefiltering'><button class='btn btn-xs btn-success'>En</button></a>";
						  	String btn_ds = "<a href='?q=disable&type=filter&item="+s+"&from=devicefiltering'><button class='btn btn-xs btn-warning'>Dis</button></a>";
	
						  	out.println("<tr>");
							out.println("<td>"+s+"</td>");
							out.println("<td>"+mp.get("src-mac-address")+"</td>");
							out.println("<td>"+mp.get("comment")+"</td>");
							out.println("<td>"+mp.get("action")+"</td>");
							out.println("<td>"+mp.get("protocol")+"</td>");
							out.println("<td>"+mp.get("disabled")+"</td>");
							out.println("<td>"+btn_dl+"  "+btn_en+"  "+btn_ds+"</td>");
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
       <%}else if(request.getParameter("q") != null && request.getParameter("q").equals("filterreport")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Filter Report
           <small>Filterred Hits Report</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Firewall</a></li>
           <li class="active">Filters</li>
         </ol>
       </section>
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">Filter Reports</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped table-responsive">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Content</th>
                       <th>Type</th>
                       <th>Protocol</th>
                       <th>Port</th>
                       <th>Packets</th>
                       <th>Bytes</th>
                       <th>Rule</th>
                       <th>Comment</th>
                       <th>Invalid</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   String btn_en = "";
	                for (Map<String,String> mp : g.firewallRules()) {
				  		//System.out.println(r);
				  		if(mp.containsKey("comment")&&!mp.get("comment").equalsIgnoreCase("Default")&&mp.get("log-prefix")!=null&&mp.get("log-prefix")!=""){
						  	String s = mp.get(".id");
						  	if(mp.get("disabled")!=null&&mp.get("disabled").equals("true")){
						  		btn_en = "<a href='?q=enable&type=filter&item="+s+"&from=filterreport'><button class='btn btn-sm btn-warning'>Enable</button></a>";
						  	}else{
						  		btn_en = "<a href='?q=disable&type=filter&item="+s+"&from=filterreport'><button class='btn btn-sm btn-danger'>Disable</button></a>";
						  	}
						  	out.println("<tr>");
							out.println("<td>"+s+"</td>");
							if(mp.containsKey("src-mac-address")){
								out.println("<td>"+mp.get("src-mac-address")+"</td>");
							}else if(mp.containsKey("dst-address")){
								out.println("<td>"+mp.get("dst-address")+"</td>");
							}else if(mp.containsKey("content")){
								out.println("<td>"+mp.get("content")+"</td>");
							}else{
								out.println("<td>"+mp.get("chain")+"</td>");
							}
							out.println("<td>"+mp.get("log-prefix")+"</td>");
							out.println("<td>"+mp.get("protocol")+"</td>");
							out.println("<td>"+mp.get("port")+"</td>");
							out.println("<td>"+mp.get("packets")+"</td>");
							out.println("<td>"+mp.get("bytes")+"</td>");
							out.println("<td>"+mp.get("action")+"</td>");
							out.println("<td>"+mp.get("comment")+"</td>");
							out.println("<td>"+mp.get("invalid")+"</td>");
							out.println("<td>"+btn_en+"</td>");
							out.println("</tr>");
				  		}
					}%>
                   
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
       
       <%}%>
</div>
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