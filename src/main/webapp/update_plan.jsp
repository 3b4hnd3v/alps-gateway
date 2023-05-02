<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%! public String pid = "", desc = "", prof = "", dur = "", unit = "", price = "", sharing = "", stat = "";  %>
<%
try{
	String id = request.getParameter("item");
	connect();
	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `purchase_plans` WHERE `id`="+id);
	
	while(rs1.next()){
		pid = rs1.getString("id"); 
		desc =rs1.getString("description"); 
		prof = rs1.getString("gateway_plan"); 
		dur = rs1.getString("duration");
		unit = rs1.getString("unit"); 
		price = rs1.getString("price"); 
		sharing = rs1.getString("sharing"); 
		stat = rs1.getString("enable"); 
	}
	cn.close();
}catch(Exception e){e.printStackTrace();}%>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Update Guest Plan")) {
	System.out.print("update");
	try {
		connect();
		String pid = request.getParameter("pid").toString();
		String desc = request.getParameter("desc").toString();
		String prof = request.getParameter("prof").toString();
		String dur = request.getParameter("dur").toString();
		String unit = request.getParameter("unit").toString();
		String price = request.getParameter("price").toString();
		String sharing = request.getParameter("share").toString();
		String stat = request.getParameter("stat").toString();
		
		PreparedStatement ps = cn.prepareStatement("UPDATE `purchase_plans` SET description=?, duration=?, unit=?, sharing=?, price=?, gateway_plan=?, `enable`=? WHERE `id`=?");
			
			ps.setString(1,desc);
			ps.setString(2,dur);
			ps.setString(3,unit);
			ps.setString(4,sharing);
			ps.setString(5,price);		
			ps.setString(6,prof);
			ps.setString(7,stat);
			ps.setString(8,pid);
			ps.executeUpdate();
			System.out.println("Record Saved!");
			cn.close();
		String logact = "Guest Plan "+desc+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
		al.addLog(logact);
		response.sendRedirect("guest_room.jsp?q=gr_plans&msg=Guest Plan Updated&type=success");
		
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
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Update Gateway Plan
    <small>Update Voucher Gateway Plan</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="hotspot.jsp?q=users">User Profile</a></li>
    <li class="active">Update</li>
  </ol>
</section>

<section class="content-header">
	<div class="panel box box-primary">
    <div class="box-header with-border">
      <h4 class="box-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Edit User Profile
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse-in">
      <div class="box-body">
      <form action="update_plan.jsp" method="post">
      				 <label>Plan Description</label>
						<input type="text" class="form-control" name="pid" value="<% out.println(pid);%>"><br />
					 <div class="form-group">
	                      <label>Gateway Plan</label>
	                      <select class="form-control" name="prof">
	                      		<option><% out.println(prof);%></option>
			                    <option></option>
	                      <% 
	                      	for (Map<String,String> mp : g.userprofile()) {
					  		String s = mp.get("name");
					  		if (s.substring(0,4).equals("gwp_")){
					  			
	                        	out.println("<option>"+s+"</option>");}
	                      	}
	                        %>
	                      </select>
	                  </div>
				
					 <label>Plan Description</label>
						<input type="text" class="form-control" name="desc" value="<% out.println(desc);%>"><br />
					 <div class="col-sm-6">
					 <label>Duration</label>
						<input type="text" class="form-control" name="dur" value="<% out.println(dur);%>"><br />
					 </div>
					 <div class="form-group col-sm-6">
	                      <label>Unit</label>
	                      <select class="form-control" name="unit">
	                      <option><% out.println(unit);%></option>
	                      <option></option>
	                      <option>DAYS</option>
	                      <option>DAY</option>
	                      <option>MINUTES</option>
	                      <option>HOURS</option>
	                      <option>HOUR</option>
	                      </select>
	                      <br>
	                  </div>
	                  <div class="col-sm-6">
		              <label>Price</label>
						<input type="text" class="form-control" name="price" value="<% out.println(price);%>"><br />
		              </div>
		              <div class="col-sm-6">
		              <label>Device Sharing</label>
						<input type="text" class="form-control" name="share" value="<% out.println(sharing);%>"><br />
		              </div>
		              <div class="form-group col-sm-6">
	                      <label>Status</label>
	                      <select class="form-control" name="stat">
	                      <option><% out.println(stat);%></option>
	                      <option></option>
	                      <option>Enabled</option>
	                      <option>Disabled</option>
	                      </select>
	                      <br>
	                  </div>
					<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Update Guest Plan" />
				</form>
      <a href="guest_room.jsp?q=gr_plan"></a><button class="btn btn-info pull-right">Cancel</button>
      </div>
    </div>
  </div>
</section>
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