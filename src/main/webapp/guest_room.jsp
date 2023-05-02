<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create Gateway Plan")) {
	
	try {
		String name = "gwp_"+request.getParameter("name").toString();
		String pool = "none";
		String rate = request.getParameter("rate").toString();
		String share = request.getParameter("share").toString();
		String cookieto = request.getParameter("cookieto").toString();
		String addcookie = request.getParameter("addcookie").toString();
		String sessionto = request.getParameter("sessionto").toString();
		String idleto = request.getParameter("idleto").toString();
		String keepal = request.getParameter("keepal").toString();
		g.createUserProf(name, pool, rate, addcookie, cookieto, share, "always", sessionto, idleto, keepal, "Default Gateway Plan");
		String logact = "Profile "+name+" created By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		
		response.sendRedirect("guest_room.jsp?q=gw_plans&msg=Gateway Plan Created Successfully&type=success");		
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("guest_room.jsp?q=gw_plans&msg=Gateway Plan Creation Failed&type=error");		
	}
}
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("remove")&& request.getParameter("type").equals("userprof")) {
	
	try {
		String item = request.getParameter("item").toString();
		
		g.removeUserProfile(item);
		
		String logact = "User Profile From Guest Plan Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("guest_room.jsp?q=gw_plans&msg=Gateway Plan Removed Successfully&type=success");		
		
		
	} catch (Exception e1) { 
		System.out.println(e1);
		response.sendRedirect("guest_room.jsp?q=gw_plans&msg=Removing Gateway Plan Failed&type=error");		
	}
}
%>

<%
if(request.getParameter("q") != null && request.getParameter("q").equals("delete")&& request.getParameter("type").equals("guestplan")) {
	
	try {
		connect();
		String item = request.getParameter("item").toString();
		
		String deleteSQL = "DELETE FROM purchase_plans WHERE id="+item;
        if(cn.createStatement().execute(deleteSQL)){
        	String logact = "Guest Plan Item "+item+" removed By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
    		al.addLog(logact);
    		response.sendRedirect("guest_room.jsp?q=gr_plans&msg=Guest Plan Removed Successfully&type=success");
        }
		cn.close();
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("guest_room.jsp?q=gr_plans&msg=Removing Guest Plan Failed&type=error");
		}
}
%>

<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Create Guest Plan")) {
	
	try{
		connect();
		String desc = request.getParameter("desc").toString();
		String prof = request.getParameter("prof").toString();
		String dur = request.getParameter("dur").toString();
		String unit = request.getParameter("unit").toString();
		String price = request.getParameter("price").toString();
		String sharing = request.getParameter("share").toString();
		String lbi = request.getParameter("lbi").toString();
		String lbo = request.getParameter("lbo").toString();
		
		PreparedStatement ps = cn.prepareStatement("INSERT INTO `purchase_plans` (description, duration, unit, sharing, price, gateway_plan, bytesin, bytesout, `enable`) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
			
			ps.setString(1,desc);
			ps.setString(2,dur);
			ps.setString(3,unit);
			ps.setString(4,sharing);
			ps.setString(5,price);		
			ps.setString(6,prof);
			ps.setString(7,lbi);
			ps.setString(8,lbo);
			ps.setString(9,"enabled");
			ps.executeUpdate();
			System.out.println("Record Saved!");
			cn.close();
    		response.sendRedirect("guest_room.jsp?q=gr_plans&msg=Guest Plan Created Successfully&type=success");

	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("guest_room.jsp?q=gr_plans&msg=Guest Plan Failed to Create&type=error");
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
<%if(request.getParameter("q") != null && request.getParameter("q").equals("gw_plans")) { %>
	
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           List of Gateway Plans
           <small>User plans</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">eBS</a></li>
           <li class="active">Gateway Plans</li>
         </ol>
       </section>
       <section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Create New Gateway PLan <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="guest_room.jsp" method="post">
					
					 <div class="form-group">
	                    <label>Name:</label>
						<input type="text" class="form-control" name="name"><br />
	                 </div>
					 <div class="form-group">
					 	<label>Sharing Limit</label>
						<input type="number" class="form-control" name="share"><br />
					 </div>
					 <div class="form-group">
	                    <label>Rate Limit:</label>
						<input type="text" class="form-control" name="rate"><br />
	                  </div>
	                  <div class="form-group col-sm-6">
	                  	<label>Store User Session</label><br />
	                  	<select name="addcookie">
	                  		<option value="true">Yes</option>
	                  		<option value="false">No</option>
	                  	</select>
	                  </div>
	                  <div class="form-group col-sm-6">
		              	<label>Keep Stored Session For</label>
						<input type="text" class="form-control" name="sessionto" value="3d 00:00:00"><br />
		              </div>
	                  <div class="form-group col-sm-4">
		              <label>Idle Timeout</label>
						<input type="text" class="form-control" name="idleto" value="none"><br />
		              </div>
		              <div class="form-group col-sm-4">
		              <label>Session Timeout</label>
						<input type="text" class="form-control" name="sessionto" value="00:00:00"><br />
		              </div>
		              <div class="form-group col-sm-4">
		              <label>Keep Alive Timeout</label>
						<input type="text" class="form-control" name="keepal" value="00:02:00"><br />
		              </div>
		              
	                  
					<input type="submit" name="submit" class="form-control btn btn-info" value="Create Gateway Plan" />
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
                 <h3 class="box-title">Gateway Plans</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Name</th>
                       <th>Pool</th>
                       <th>Sharing</th>
                       <th>Trans-Proxy</th>
                       <th>Add Cookie</th>
                       <th>Cookie Timeout</th>
                       <th>Default</th>
                       <th>Action</th>
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   
	                for (Map<String,String> mp : g.gatewayplan()) {
	                	String s = mp.get(".id");
	                	String n = mp.get("name");
	                	//System.out.println(n);
	                	//System.out.println(n+"==="+n.substring(0,4));
	                	//if (n.length()>4 & n.substring(0,4).equals("gwp_")){
	                		//System.out.print("seen = "+n.substring(1,4));
						  	String btn_dl = "<a href='?q=remove&type=userprof&item="+s+"'><button class='btn btn-xs btn-danger'>Del</button></a>";
						  	String btn_ed = "<a href='update.jsp?q=edit&type=userprof&item="+s+"'><button class='btn btn-xs btn-info'>Edit</button></a>";
	
						  	out.println("<tr>");
							out.println("<td>"+btn_ed+" "+s+"</td>");
							out.println("<td>"+mp.get("name")+"</td>");
							out.println("<td>"+mp.get("address-pool")+"</td>");
							out.println("<td>"+mp.get("shared-users")+"</td>");
							out.println("<td>"+mp.get("transparent-proxy")+"</td>");
							out.println("<td>"+mp.get("add-mac-cookie")+"</td>");
							out.println("<td>"+mp.get("mac-cookie-timeout")+"</td>");
							out.println("<td>"+mp.get("default")+"</td>");
							out.println("<td>"+btn_dl+"</td>");
							out.println("</tr>");
	                	//}
				  
				}%>
                   </tbody>
                   
                 </table>
               </div><!-- /.box-body -->
             </div><!-- /.box -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </section><!-- /.content -->
<%}else if(request.getParameter("q") != null && request.getParameter("q").equals("gr_plans")) { %>
	<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           List of Guest Plans
           <small>List Of Guest Plans</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">eBS</a></li>
           <li class="active">Guest Room</li>
         </ol>
       </section>
	<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Create Guest Room Plans <span><i class="fa fa-angle-double-down"></i></span>
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             	<form action="guest_room.jsp" method="post">
					 <div class="form-group">
	                      <label>Gateway Plan</label>
	                      <select class="form-control" name="prof">
	                      <% 
	                      	for (Map<String,String> mp : g.gatewayplan()) {
					  			String s = mp.get("name");
	                        	out.println("<option>"+s+"</option>");
	                      	}
	                        %>
	                      </select>
	                  </div>
				
					 <label>Plan Description</label>
						<input type="text" class="form-control" name="desc"><br />
					 <div class="col-sm-6">
					 <label>Duration</label>
						<input type="text" class="form-control" name="dur"><br />
					 </div>
					 <div class="form-group col-sm-6">
	                      <label>Unit</label>
	                      <select class="form-control" name="unit">
		                      <option>DAYS</option>
		                      <option>MINUTES</option>
		                      <option>HOURS</option>
	                      </select>
	                      <br>
	                  </div>
	                  <div class="col-sm-6">
		              <label>Price</label>
						<input type="text" class="form-control" name="price" value="0.00"><br />
		              </div>
		              <div class="col-sm-6">
		              <label>Device Sharing</label>
						<input type="number" min="1" class="form-control" name="share" value="1"><br />
		              </div>
		              <div class="col-sm-6">
		              <label>Limit Bytes In</label>
						<input type="text" class="form-control" name="lbi" value="0"><br />
		            </div>
		            <div class="col-sm-6">
		              <label>Limit Bytes Out</label>
						<input type="text" class="form-control" name="lbo" value="0"><br />
		            </div>
					<input type="submit" name="submit" class="form-control btn btn-info" value="Create Guest Plan" />
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
                 <h3 class="box-title">Guest Room Plans</h3>
                 <%@include file="import.jsp" %>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Description</th>
                       <th>Duration</th>
                       <th>Price</th> 
                       <th>Gateway Plan</th>
                       <th>Sharing Limit</th> 
                       <th>Status</th>
                       <th>Action</th>  
                     </tr>
                   </thead>
                   <tbody>
                   <%
                   connect();
                   try {
	                 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans`");
	                 	
	                 	while(rs1.next()){
	                 	
	                 		String s = rs1.getString("id");
	                 		String btn_dl = "<a href='?q=delete&type=guestplan&item="+s+"'><button class='btn btn-xs btn-danger'>Del</button></a>";
						  	String btn_ed = "<a href='update_plan.jsp?q=edit&type=guestplan&item="+s+"'><button class='btn btn-xs btn-info'>Edit</button></a>";

						  	
	                 		out.println("<tr>");
	            		 	out.println("<td>"+rs1.getString("id")+"</td>");
	            		 	out.println("<td>"+rs1.getString("description")+"</td>");
	            		 	out.println("<td>"+rs1.getString("duration")+" "+rs1.getString("unit")+"</td>");
	            		 	out.println("<td>"+rs1.getString("price")+"</td>");
	            		 	out.println("<td>"+rs1.getString("gateway_plan")+"</td>");
	            		 	out.println("<td>"+rs1.getString("sharing")+"</td>");
	            		 	out.println("<td>"+rs1.getString("enable")+"</td>");
	            		 	out.println("<td>"+btn_dl+"  "+btn_ed+"</td>");
	            		 	out.println("</tr>");
	                 		
	                 	}
	               		
	               		cn.close();
	               	} catch(Exception e) { out.println("<tr>");
        		 	out.println("<td>error</td>");
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
	$("#example1").DataTable();
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