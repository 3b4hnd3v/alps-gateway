<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxed sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%! String location = ""; %>
<%
if(request.getParameter("location") != null){
	location = request.getParameter("location").toString();
}else{
	%>
	<div class="content-wrapper">
	<section class="content-header">
	  <!--  h1>
	    Create Location
	    <small>Create New Location</small>
	  </h1>-->
	  <div class="panel box box-primary">
	    <div class="box-header with-border">
	      <h4 class="box-title">
	        <a data-toggle="collapse in" data-parent="#accordion" href="#">
	          Select Location <span><i class="fa fa-angle-double-down"></i></span>
	        </a>
	      </h4>
	    </div>
	    <div id="collapseOO" class="panel-collapse collapse in">
	      <div class="box-body">
	      	<form action="new_vlanloc_mw.jsp" method="post">
	      		<div class="col-sm-12">
	      			<div class="form-group">
			      	<!--  label>Name</label>-->
			      	<select class="form-control" name="location">
				      	<option></option>
				      	<% 
				      	for (Map<String,String> mp : g.bridges()) {
					  		String s = mp.get("name");
	                        out.println("<option>"+s+"</option>");
	                     }
		                 %>
					</select>
					</div>
				</div>
      			<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Create Sub-Location" />
	     	</form>
	      </div>
	    </div>
	   </div>
		</section>
	 </div>
	<%
	//response.sendRedirect("location.jsp?msg=Location Can Not Be Found.&type=error");
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
    Create Location
    <small>Create New Location</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Network</a></li>
    <li><a href="#">Location</a></li>
    <li class="active">New Location</li>
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
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="box-body">
      	<form action="create_vlanloc_mw.jsp" method="post">
      		<div class="col-sm-12" align="center"><span>Location</span><hr></div>
      		<div class="col-sm-12">
		      	<label>Name</label>
				<input type="text" class="form-control" name="locname" value="<% out.print(location);%>"><br />
			</div>
      		<div class="col-sm-12" align="center"><span>Sub-Location VLAN</span><hr></div>
      		<div class="col-sm-6">
		      	<label>Vlan ID</label>
				<input type="text" class="form-control" name="vlanid"><br />
			</div>
			<div class="col-sm-6">
		      	<label>Vlan Name</label>
				<input type="text" class="form-control" name="vlname"><br />
			</div>
      		<div class="col-sm-12" align="center"><span>Address Pool</span><hr></div>
      		<div class="col-sm-6">
		      	<label>Pool Name</label>
				<input type="text" class="form-control" name="poolname"><br />
			</div>
			<div class="col-sm-6">
		      	<label>Address Range</label>
				<input type="text" class="form-control" name="addrange"><br />
			</div>
      		<div class="col-sm-12" align="center"><span>IP Setting</span><hr></div>
      		<div class="col-sm-4">
		      	<label>Hotspot IP</label>
				<input type="text" class="form-control" name="ip"><br />
			</div>
			<div class="col-sm-4">
		      	<label>Network</label>
				<input type="text" class="form-control" name="network"><br />
			</div>
			<div class="form-group col-sm-4">
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
      		<div class="col-sm-12" align="center"><span>Hotspot</span><hr></div>
      		<div class="form-group col-sm-6">
	      		<div class="col-sm-6">
			      	<label>Login By</label>
					<input type="text" class="form-control" name="loginby" value="http-chap,https,http-pap,mac-cookie"><br />
				</div>
		      	<label>Landing Page</label>
		      	<select class="form-control" name="ldp">
		      	<option> </option>
		      	<% 
                   try{
	                    connect();
	                    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `captive_type`");
	                   	
	           			while(rs1.next()){
	        	    		
	        	    		String desc =rs1.getString("homepage"); 
	        	    		//String name =rs1.getString("gateway_plan"); 
	        	    		
	        	    		//String plan =desc+"-"+name;
	                       	out.println("<option>"+desc+"</option>");
	           			}
	           			cn.close();
                   	}catch(Exception e){System.out.print(e);}
                %>
				</select>
			</div>
      		
      		<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Create Sub-Location" />
	     </form>
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