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
<%! public String url = "SELECT * FROM `meeting_rooms` ORDER BY `name` ASC", rid="", rnm="", rstat="", gpc="", cvp="collapse";%>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Room")) {
	
	try {
		String roomid = request.getParameter("roomid").toString();
		String roomname = request.getParameter("roomname").toString();
		String roomstatus = request.getParameter("roomstatus").toString();
		connect();
		PreparedStatement ps = cn.prepareStatement("UPDATE `meeting_rooms` SET name=?, status=? WHERE `id`=?");
			
			ps.setString(1,roomname);
			ps.setString(2,roomstatus);
			ps.setString(3,roomid);
			ps.executeUpdate();
			System.out.println("Record Saved!");
		cn.close();
		String logact = "Guest Plan "+roomname+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.setStatus(response.SC_MOVED_TEMPORARILY); 
		response.setHeader("Location", "conf_rooms.jsp?msg=Room Update Successful.&type=success");
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("id")!= null) {
	
	try {
		String item = request.getParameter("id").toString();
		connect();
		String deleteSQL = "DELETE FROM `meeting_rooms` WHERE id="+item;
        if(cn1.createStatement().execute(deleteSQL)){
        	String logact = "Conference Room Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
    		al.addLog(logact);
    		response.sendRedirect("conf_rooms.jsp?msg=Successfully Deleted.&type=success");
        }
        cn.close();
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("conf_rooms.jsp?msg=Meeting Room could not be deleted.&type=error");
		}
}
%>
<%
if(request.getParameter("search") != null && request.getParameter("search").equals("Search!")) {
	
	try {
		String param = request.getParameter("st").toString().toLowerCase();
		String val = request.getParameter("item").toString();
		
		url = "SELECT * FROM `meeting_rooms` WHERE "+param+" LIKE '%"+val+"%' ORDER BY `name` ASC";
		//System.out.println(url);
		
	} catch (Exception e1) { 
		System.out.println(e1); }
}else{
	url = "SELECT * FROM `meeting_rooms` ORDER BY `name` ASC";
}
%>
<% if(request.getParameter("q") != null && request.getParameter("q").equals("edit") && request.getParameter("id")!= null) { %>
<%! public String id = "", action = "", rn = "", rstatus = "";  %>

<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Edit Conference Room
    <small>Update Conference Room Information</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=walledgarden">EBS</a></li>
    <li class="active">Conference Rooms</li>
  </ol>
</section>

<section class="content-header">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit Conference Room
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse-in">
      <div class="box-body">
      	<% 
			id=request.getParameter("id");
			rn=request.getParameter("rn");
			rstatus=request.getParameter("rstat");
		%>
      <form action="conf_rooms.jsp" method="post">
      	<label>ID</label>
			<input type="text" class="form-control" readonly name="roomid" value="<% out.println(id);%>"><br />
		<label>Room Name</label>
			<input type="text" class="form-control" name="roomname" value="<% out.println(rn);%>"><br />
		<label>Room Status</label>
			<input type="text" class="form-control" name="roomstatus" value="<% out.println(rstatus);%>"><br />
      	<input type="submit" name="submit" class="form-control btn btn-info col-md-8" value="Update Room" />
      </form>
      <a href="conf_rooms.jsp"><button class="btn btn-info pull-right col-md-2">Cancel</button></a>
      </div>
    </div>
  </div>
</section>
<%}else{ %>
<!-- Table List -->
       <section class="content">
         <div class="row">
           <div class="col-xs-12"><!-- /.box -->

             <div class="box">
               <div class="box-header">
                 <h3 class="box-title col-sm-4">Conference Rooms</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Name</th>
                       <th>Status</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   	 <%
                   	 connect();
                   	 try {
                   		ResultSet rs = cn.createStatement().executeQuery(url);
                   	  	
                   	  	while(rs.next()){
                   	  		
						   String dlbtn="<a href='conf_rooms.jsp?q=delete&id="+rs.getString("id")+"' target='_self'><button class='btn btn-xs btn-danger'>Delete</button></a>";
						   String edbtn="<a href='conf_rooms.jsp?q=edit&id="+rs.getString("id")+"&rn="+rs.getString("name")+"&rstat="+rs.getString("status")+"' target='_self'><button class='btn btn-xs btn-info'>Edit</button></a>";
						   String schbtn="<a href='room_schedule.jsp?id="+rs.getString("id")+"' target='_self'><button class='btn btn-xs btn-warning'>Schedule</button></a>";

						   out.println("<tr>");
						   out.println("<td>"+rs.getString("id")+"</td>");
						   out.println("<td>"+rs.getString("name")+"</td>");
						   out.println("<td>"+rs.getString("status")+"</td>");
						   out.println("<td>"+edbtn+""+dlbtn+""+schbtn+"</td>");
						   
						   //System.out.println(obj2.get("id"));
						   out.println("</tr>");
					   }
                 		cn.close();
					   } catch(Exception e) { 
						   System.out.print(e);
						out.println("<tr>");
	        		 	out.println("<td>Could Not Get User Records at the Moment</td>");
	        		 	out.println("</tr>");
						}
					%>
				</tbody>
				</table>
				</div>
			</div>
		</div>
	</div>
</section>
<%} %>
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