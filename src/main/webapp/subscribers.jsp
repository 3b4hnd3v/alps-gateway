<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
String msg = "0x0", cvp = "collapse";%>
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
String nextid = dao.SubMax();
%>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Subscribers
    <small>Network Subscribers</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Policy</a></li>
    <li><a href="#">Subscription</a></li>
    <li><a href="#">Subscribers</a></li>
  </ol>
</section>

<section class="content">
<div><br /><br /></div>
<div class="row">
  <div class="col-md-12">
	<div class="panel box box-primary">
	    <div class="box-header with-border">
	      <h4 class="box-title">
	        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	         New Subscriber<span><i class="fa fa-angle-double-down"></i></span>
	        </a>
	      </h4>
	    </div>
	    <div id="collapseOne" class="panel-collapse collapse">
	      <div class="box-body">
	      	<form action="create_subscriber.jsp" method="post">
	      		<div class="col-sm-12" align="center"><span>Subscriber Details</span><hr></div>
	      		
	      		<div class="col-sm-12">
	      			<input type="text" readonly class="form-control" name="nextid" value="<%=nextid%>"><br />
			      	<label>Name</label>
					<input type="text" class="form-control" name="subname"><br />
				</div>
				<div class="col-sm-6">
			      	<label>Email</label>
					<input type="text" class="form-control" name="email"><br />
				</div>
				<div class="col-sm-6">
			      	<label>Mobile</label>
					<input type="text" class="form-control" name="mobile"><br />
				</div>
	      		<div class="col-sm-12" align="center"><label>Subscription Plan</label><hr></div>
				<div class="form-group col-sm-6">
			      	<label>Plan</label>
			      	<select required class="form-control" name="subplan">
			      	<option value="">Select Plan</option>
			      	<option value=""> </option>
			      	<% 
	                   try{
		                    connect();
		                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `subplans`");
		           			while(rs1.next()){
		        	    		String desc =rs1.getString("name")+":"+rs1.getString("rate")+":"+rs1.getString("duration")+":"+rs1.getString("price"); 
		                       	out.println("<option value='"+desc+"'>"+desc+"</option>");
		           			}
		           			cn.close();
	                   	}catch(Exception e){System.out.print(e);}
	                %>
					</select>
				</div>
				<div class="col-sm-6">
			      	<label>Device</label>
					<input type="text" required class="form-control" name="device"><br />
				</div>
				<div class="col-sm-12" align="center"><label>Network</label><hr></div>
				<div class="col-sm-6">
			      	<label>Address Range</label>
					<input type="text" required class="form-control" name="addrange" value="192.168.x.1-192.168.x.10">
					<small>Make Address Range atleast 3 IPs</small>
				</div>
				<div class="col-sm-3">
			      	<label>Network</label>
					<input type="text" class="form-control" name="network"><br />
				</div>
				<div class="form-group col-sm-3">
			      	<label>Subnet Mask</label>
			      	<select class="form-control" name="smask">
			      	<option> </option>
			      	<% 
		               	for (int i = 0; i<=30; i++) {
		                	out.println("<option>/"+i+"</option>");
		               	}
	                 %>
					</select>
				</div>
	      		<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Register New Subscriber" />
		     </form>
	      </div>
	    </div>
	  </div>
	</div>
 </div>
 <div class="row">
   <div class="col-xs-12"><!-- /.box -->

     <div class="box">
       <div class="box-header">
         <h3 class="box-title">Subscribers</h3>
       </div><!-- /.box-header -->
       <div class="box-body table-responsive">
         <table id="example1" class="table table-bordered table-striped">
           <thead>
           <tr>
			<th>ID</th>
			<th>Name</th>
			<th>eMail</th>
			<th>Mobile</th>
			<th>Plan</th>
			<th>Device</th>
			<th>Current Bill</th>
			<th>Registered On</th>
		   </tr>
		   </thead>
           <tbody>
			<% 
			connect();
			try {
			 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `subscribers`");
				while(rs1.next()){
			 		String stid=rs1.getString("id");
			 		String stn=rs1.getString("name");
				  	String btn_rm = "<a href='?q=delete&stid="+stid+"'><button class='btn btn-md btn-danger'><i class='fa fa-times pull-right'></i></button></a>";
				  	String btn_ed = "<a href='?q=delete&stid="+stid+"'><button class='btn btn-md btn-danger'><i class='fa fa-times pull-right'></i></button></a>";
			
					out.println("<tr>");
					out.println("<td>"+stid+"</td>");
					out.println("<td>"+stn+"</td>");
					out.println("<td>"+rs1.getString("email")+"</td>");
					out.println("<td>"+rs1.getString("mobile")+"</td>");
					out.println("<td>"+rs1.getString("plan")+"</td>");
					out.println("<td>"+rs1.getString("device")+"</td>");
					out.println("<td>"+rs1.getString("curr_bill")+"</td>");
					out.println("<td>"+rs1.getString("regdate")+"</td>");
					out.println("</tr>");
				 }
				cn.close();
			} catch(Exception e) { System.out.println(e);} 
			%>
			</tbody>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
    </div><!-- /.col -->
  </div><!-- /.row -->
</section><!-- /.content -->
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
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
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