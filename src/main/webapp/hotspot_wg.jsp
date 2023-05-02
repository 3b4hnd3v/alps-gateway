<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
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
<% 
String entry = "", type="";
if(request.getParameter("q") != null && request.getParameter("item") != null) {
	try {
		type = request.getParameter("q");
		entry = request.getParameter("item");
		
	} catch (Exception e1) { System.out.println(e1); }
}else{
	response.sendRedirect("hotspot.jsp?q=walledgarden");
}
%>
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Listed Walled Garden
           <small>List of Walled garden entry instances</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Hotspot Management</a></li>
           <li class="active">Walled Garden Entry</li>
         </ol>
       </section>
       
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">Walled Garden Instances For </h3><span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://<%=entry %>" class="btn btn-primary" target="_blank"><%=entry %></a></span>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Type</th>
                       <th>Address</th>
                       <th>Comment</th>
                       <th>Action</th>
                       <th>Hits</th>
                       <th>Dynamic</th>
                       <th>Disabled</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%for (Map<String,String> mp : g.allWalledGarden(entry, type)) {
                	    String f = String.valueOf(mp.get("comment"));
		                String i = mp.get(".id");
		                String da = mp.get("dst-address");
		                
					  	out.println("<tr>");
					  	if (mp.containsKey("dst-address")){
					  		out.println("<td>IP</td>");
					  		out.println("<td>"+mp.get("dst-address")+"</td>");
					  	}else if (mp.containsKey("dst-host")){
					  		out.println("<td>SITE</td>");
					  		out.println("<td>"+mp.get("dst-host")+"</td>");
					  	}else{
					  		out.println("<td>Location</td>");
					  		out.println("<td>"+mp.get("server")+"</td>");
					  	}
					  	out.println("<td>"+((f == "null") ? "No Comment" : f)+"</td>");
						out.println("<td>"+mp.get("action")+"</td>");
						out.println("<td>"+mp.get("hits")+"</td>");
						out.println("<td>"+mp.get("dynamic")+"</td>");
						out.println("<td>"+mp.get("disabled")+"</td>");
						out.println("</tr>");
					}%>
                   
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
</div><!-- /.content-wrapper -->  
<footer class="main-footer">
  <div class="pull-right hidden-xs">
    <b>Version</b> <%=sysver%>
  </div>
  <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">Alps Gateway</a>.</strong> All rights reserved.
</footer>
</div> <!-- /.content -->
<!-- /Table Export -->   
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
<!-- page script -->
</body>
</html>