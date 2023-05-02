<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%! public String url = "SELECT * FROM `mr_purchase` ORDER BY `created_at` DESC", gid="", gnm="", lnm="", gpc="", cvp="collapse";%>
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
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("id")!= null) {
	
	try {
		String item = request.getParameter("id").toString();
		//String user = request.getParameter("user").toString();
		connect();
		String deleteSQL = "DELETE FROM `mr_purchase` WHERE id="+item;
        if(cn.createStatement().execute(deleteSQL)){
        	
        	String logact = "Event Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
    		al.addLog(logact);
    		response.sendRedirect("events.jsp?msg=Delete Succesful&type=success");
        }
        cn.close();
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("events.jsp?error=Delete Not Successful&type=error");
		}
}
%>
<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           Conference Room Events
           <small>Conference Room Events</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">EBS</a></li>
           <li class="active">Events</li>
         </ol>
       </section>
	<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Create New Event <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="create_event.jsp" method="post">
             		<div class="form-group col-sm-12">
                   	<label>Event Venue</label>
                   	<select class="form-control" name="venue">
	                    <% 
	                    try{
		                    connect();
		                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `meeting_rooms` WHERE `status`='Open'");
		           			while(rs1.next()){
		        	    		String rname =rs1.getString("name"); 
		        	    		String rno =rs1.getString("id"); 
	                        	out.println("<option>"+rno+" - "+rname+"</option>");
		           			}
		           			cn.close();
                      	}catch(Exception e){System.out.print(e);}
                        %>
                 		</select>
                 	</div>
             		<div class="col-sm-6">
			      	<label>Event Name</label>
						<input type="text" class="form-control" name="evn"><br />
					</div>
					<div class="col-sm-6">
			      	<label>Company Name</label>
						<input type="text" class="form-control" name="comp"><br />
					</div>
					<div class="col-sm-4">
					<label>Contact Name</label>
						<input type="text" class="form-control" name="cn"><br />
					</div>
					<div class="col-sm-4">
					<label>Phone #</label>
						<input type="text" class="form-control" name="phone"><br />
					</div>
					<div class="col-sm-4">
					<label>Email</label>
						<input type="email" class="form-control" name="email"><br />
					</div>
					<div class="col-sm-6">
			      	<label>Preferred Username</label>
						<input type="text" class="form-control" name="puser"><br />
					</div>
					<div class="col-sm-6">
			      	<label>Preferred Password</label>
						<input type="text" class="form-control" name="ppass"><br />
					</div>
					<div class="col-sm-6">
					<label>Start Date</label>
						<input type="date" class="form-control" name="stdate"><br />
					</div>
					<div class="col-sm-6">
					<label>End Date</label>
						<input type="date" class="form-control" name="endate"><br />
					</div>
					<div class="col-sm-2">
					<label>Days</label>
						<input type="number" class="form-control" min="1" name="days"><br />
					</div>
					<div class="col-sm-4">
					<label>Rate</label>
						<input type="text" class="form-control" name="dayrate"><br />
					</div>
					<div class="col-sm-2">
					<label>Pax</label>
						<input type="number" class="form-control" min="10" name="pax"><br />
					</div>
					<div class="col-sm-4">
					<label>Rate</label>
						<input type="text" class="form-control" name="paxrate"><br />
					</div>
					<div class="form-group col-sm-6">
                    	<label>Server</label>
                    	<select class="form-control" name="server">
	                    	<option>all</option>
		                    <% 
	                      	for (Map<String,String> mp : g.hsservers()) {
					  		String s = mp.get("name");
	                        out.println("<option>"+s+"</option>");
	                      	}
	                        %>
                  		</select>
                  		<small>Select Meeting Room Vlan as Server</small>
                    </div>
                    <div class="form-group col-sm-6">
                   	<label>Purchase Plan</label>
                   	<select class="form-control" name="plan">
	                    <% 
	                    try{
		                    connect();
		                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans`");
		                   	
		           			while(rs1.next()){
		        	    		
		        	    		String pid = rs1.getString("id"); 
		        	    		String desc =rs1.getString("description"); 
		        	    		String gw =rs1.getString("gateway_plan"); 
		        	    		
		        	    		String plan = pid+"-"+desc+"-"+gw;
	                        	out.println("<option>"+plan+"</option>");
		           			}
		           			cn.close();
                      	}catch(Exception e){System.out.print(e);}
                        %>
                 	</select>
                 	</div>
                 	
			      	<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Create Event" />
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
                 <h3 class="box-title col-sm-4">PMS Guest Information</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Event</th>
                       <th>Company</th>
                       <th>Contact</th>
                       <th>Venue</th>
                       <th>Start</th>
                       <th>End</th>
                       <th>Conn</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   	 <%
                   	 connect();
                   	 try {
                   		ResultSet rs = cn.createStatement().executeQuery(url);
                   	  	while(rs.next()){
						   String dlbtn="<a href='events.jsp?q=delete&id="+rs.getString("id")+"' target='_self'><button class='btn btn-xs btn-danger'>Delete</button></a>";
						   String edbtn="<a href='edit_event.jsp?id="+rs.getString("id")+"' target='_self'><button class='btn btn-xs btn-info'>Edit</button></a>";
						   String pbtn="<a href='print_event.jsp?pid="+rs.getString("id")+"' target='_self'><button class='btn btn-xs btn-info'>Print</button></a>";
						   String embtn="<a href='send_mail.jsp?q=edit&phone="+rs.getString("contact_phone")+"&phone="+rs.getString("contact_email")+"' target='_self'><button class='btn btn-xs btn-warning'>Mail</button></a>";

						   out.println("<tr>");
						   out.println("<td>"+rs.getString("id")+"</td>");
						   out.println("<td>"+rs.getString("description")+"</td>");
						   out.println("<td>"+rs.getString("company_name")+"</td>");
						   out.println("<td>"+rs.getString("contact_person")+"</td>");
						   out.println("<td>"+rs.getString("mr_id")+"-"+rs.getString("mr_name")+"</td>");
						   out.println("<td>"+rs.getString("start_date")+"</td>");
						   out.println("<td>"+rs.getString("end_date")+"</td>");
						   out.println("<td>"+rs.getString("connections")+"</td>");
						   out.println("<td width='15%'>"+edbtn+""+dlbtn+""+pbtn+"</td>");
						   out.println("</tr>");
					   }
                 	   cn.close();
				    } catch(Exception e) {System.out.print(e);}
					%>
				</tbody>
				</table>
				</div>
			</div>
		</div>
	</div>
</section>
<%//} %>
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