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
<%! public String url = "SELECT * FROM `mr_purchase_line` ORDER BY `purchase` DESC", mrid="", mrn="", lnm="", gpc="", cvp="collapse";%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("id")!= null) {
	
	try {
		String item = request.getParameter("id").toString();
		connectpms();
		String deleteSQL = "DELETE FROM `mr_purchase_line` WHERE purchase="+item;
        if(cn1.createStatement().execute(deleteSQL)){
        	String logact = "PMS Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
    		al.addLog(logact);
    		response.sendRedirect("room_sched.jsp?msg=Delete Succesful");
        }
        cn1.close();
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("room_sched.jsp?error=Delete Not Successful");
		}
}
%>
<%
if(request.getParameter("search") != null && request.getParameter("search").equals("Search!")) {
	
	try {
		String param = request.getParameter("st").toString().toLowerCase();
		String val = request.getParameter("item").toString();
		mrid = request.getParameter("mrid").toString();
		mrn = request.getParameter("mrn").toString();
		
		
		url = "SELECT * FROM `mr_purchase_line` WHERE `meeting_room_id`="+mrid+" AND `meeting_room`="+mrn+" AND "+param+" LIKE '%"+val+"%' ORDER BY `start_time` DESC";
		System.out.println(url);
		
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else{
	url = "SELECT * FROM `mr_purchase_line` ORDER BY `start_time` DESC";
}
%>
<%
if(request.getParameter("mrid") != null && request.getParameter("mrn") != null) {
	
	try {
		String mrid = request.getParameter("mrid").toString().toLowerCase();
		String mrn = request.getParameter("mrn").toString();
		
		url = "SELECT * FROM `mr_purchase_line` WHERE `meeting_room_id`="+mrid+" AND `meeting_room`="+mrn+" ORDER BY `start_time` DESC";
		System.out.println(url);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else{
	url = "SELECT * FROM `mr_purchase_line` ORDER BY `start_time` DESC";
}
%>
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
	 <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title col-sm-4">Conference Room Schedule</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>Line</th>
                       <th>Purchase</th>
                       <th>Room ID</th>
                       <th>Meeting Room</th>
                       <th>Start Time</th>
                       <th>End Time</th>
                       <th>Connections</th>
                       <th>Amount</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   	 <%
                   	 connect();
                   	 try {
                   		ResultSet rs = cn.createStatement().executeQuery(url);
                   	  	
                   	  	while(rs.next()){
                   	  		
 						   String dlbtn="<a href='conf_sched.jsp?q=delete&id="+rs.getString("line_id")+"' target='_self'><button class='btn btn-xs btn-danger'>Delete</button></a>";

						   out.println("<tr>");
						   out.println("<td>"+rs.getString("line_id")+"</td>");
						   out.println("<td>"+rs.getString("purchase")+"</td>");
						   out.println("<td>"+rs.getString("meeting_room_id")+"</td>");
						   out.println("<td>"+rs.getString("meeting_room")+"</td>");
						   out.println("<td>"+rs.getString("start_time")+"</td>");
						   out.println("<td>"+rs.getString("end_time")+"</td>");
						   out.println("<td>"+rs.getString("connections")+"</td>");
						   out.println("<td>"+rs.getString("amount")+"</td>");
						   out.println("<td>"+dlbtn+"</td>");
						   
						   //System.out.println(obj2.get("id"));
						   out.println("</tr>");
					   }
                 		cn.close();
					   } catch(Exception e) { 
						   System.out.println(e);
						   out.println("</tbody>");
						   out.println("</table>");
	        		 	   out.println("<div>Could Not Get User Records at the Moment</div>");
	        		 	
						}
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