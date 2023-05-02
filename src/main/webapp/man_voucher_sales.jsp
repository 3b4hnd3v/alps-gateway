<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
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
<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Voucher Sales
           <small>Manual Voucher Sales</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Guest</a></li>
           <li class="active">Users</li>
         </ol>
       </section>
	<!--<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Create User
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	No Action
             </div>
           </div>
         </div>
	</section>-->
       <!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title">Manual Voucher Sales</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body table-responsive">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Room No.</th>
                       <th>Server</th>
                       <th>Duration</th>
                       <th>Price</th>
                       <th>Username</th>
                       <th>Password</th>
                       <th>Activated</th>
                       <th>Created</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   connect();
                   try {
	                 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `gr_postpaid`");
	                 	String edbtn = "";
	                 	//`gr_postpaid` (`room_no`, `server`, `unit`, `duration`, `price`, `username`, `password`, `wireless_username`, `wireless_password`)
	                 	while(rs1.next()){
	                 		if(rs1.getString("status").equals("0")){edbtn="<a href='man_voucher.jsp?q=cancel&id="+rs1.getString("id")+"&nm="+rs1.getString("username")+"' target='_self'><button class='btn btn-xs btn-info'>Cancel</button></a>";}
							String dlbtn="<a href='man_voucher.jsp?q=delete&id="+rs1.getString("id")+"' target='_self'><button class='btn btn-xs btn-danger'>Delete</button></a>";

	                 		out.println("<tr>");
	            		 	out.println("<td>"+rs1.getString("id")+"</td>");
	            		 	out.println("<td>"+rs1.getString("room_no")+"</td>");
	            		 	out.println("<td>"+rs1.getString("server")+"</td>");
	            		 	out.println("<td>"+rs1.getString("duration")+" "+rs1.getString("unit")+"</td>");
	            		 	out.println("<td>"+rs1.getString("price")+"</td>");
	            		 	out.println("<td>"+rs1.getString("username")+"</td>");
	            		 	out.println("<td>"+rs1.getString("password")+"</td>");
	            		 	out.println("<td>"+rs1.getString("start_time")+"</td>");
	            		 	out.println("<td>"+rs1.getString("created")+"</td>");
	            		 	out.println("<td>"+edbtn+"	"+dlbtn+"</td>");
	            		 	out.println("</tr>");
	                 	}
	               		
	               		cn.close();
	               	} catch(Exception e) { e.printStackTrace(); }
	                %>
				</tbody>
				</table>
				</div>
			</div>
		</div>
	</div>
</section>
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