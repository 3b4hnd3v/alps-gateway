<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
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
<section class="content">
	<div class="panel box box-primary">
	    <div class="box-header with-border">
	      <h4 class="box-title">
	        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	         Add New Location<span><i class="fa fa-angle-double-down"></i></span>
	        </a>
	      </h4>
	    </div>
	    <div id="collapseOne" class="panel-collapse collapse in">
	    	<form action="create_location.jsp" method="post">
				<div class="box-body">
				<div class="callout callout-info">
				    <h4>Tip!</h4>
				    <p>A zone is a subdivision of your network.</p>
				    <p>You can setup a zone with different DHCP Setup and Assign Multiple VLANS to it.</p>
				    <p>Each Location can have a different captive portal landing page</p>
				</div>
	      		<div class="row">
		      		<div class="col-sm-12">
				      	<label>Name</label>
						<input type="text" class="form-control" name="locname"><br />
					</div>
		      		<div class="col-sm-12" align="center">
						<div class="callout callout-info">
		                    <h4>Starting VLAN</h4>
		            	</div>
					</div>
		      		<div class="col-sm-6">
				      	<label>Vlan ID</label>
						<input type="text" class="form-control" name="vlanid"><br />
					</div>
					<div class="col-sm-6">
				      	<label>Vlan Name</label>
						<input type="text" class="form-control" name="vlname"><br />
					</div>
		      		<div class="col-sm-12" align="center">
						<div class="callout callout-info">
		                    <h4>IP Settings</h4>
		            	</div>
					</div>
		      		<!-- <div class="col-sm-6">
				      	<label>Pool Name</label>
						<input type="text" class="form-control" name="poolname"><br />
					</div> -->
					<div class="col-sm-12">
				      	<label>Address Range</label>
						<input type="text" class="form-control" name="addrange">
						<span>Example: 192.168.1.2-192.168.1.254 (leave first or last IP in the pool for Hotspot IP)</span>
						<br />
					</div>
		      		<!-- <div class="col-sm-12" align="center"><label>IP Setting</label><hr></div>  -->
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
					<div class="form-group col-sm-12">
						<label>Bandwidth Rate</label>
						<input type="text" class="form-control" name="rate" value="" placeholder="5M/5M"><br />
					</div>
					<div class="col-sm-12" align="center">
						<div class="callout callout-info">
		                    <h4>Security and Authentication</h4>
		            	</div>
					</div>
		      		<div class="form-group col-sm-9">
			       		<label>Allowed Authentication Methods</label>
			       		<div>
		                    <label class="checkbox-inline">
		                        <input type="checkbox" name="lb" id="inlineCheckbox1" value="http-chap"> Challenge Handshake
		                    </label>
		                    <label class="checkbox-inline">
		                        <input type="checkbox" name="lb" id="inlineCheckbox2" value="http-pap"> Password Auth
		                    </label>
		                    <label class="checkbox-inline">
		                        <input type="checkbox" name="lb" id="inlineCheckbox3" value="cookie"> Stored Session
		                    </label>
		                    <label class="checkbox-inline">
		                        <input type="checkbox" name="lb" id="inlineCheckbox3" value="https"> Secure HTTPS
		                    </label>
		                </div>
			       	</div>
			       	<div class="form-group col-sm-3">
			       		<label>Allow Radius Authentication</label>
						<select class="form-control" name="radius">
						   <option value="false">No Radius</option>
			               <option value="true">Allow Radius</option>
			            </select>
				    </div>
					<div class="form-group col-sm-6">
				      	<label>Landing Page</label>
				      	<select class="form-control" name="ldp">
				      	<option value="hotspot">Default</option>
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
			       	<div class="form-group col-sm-6">
			       		<label>Secure SSL Certificate</label>
				      	<select class="form-control" name="cert">
					      	<option value="none">No HTTPS</option>
					      	<%for (Map<String,String> r : g.certs()){
					      		String n = r.get("name");
					      	%>
								<option value="<%=n%>"><%=n%></option>
							<%}%>
					    </select>
			       	</div>
	      		</div>
	      	</div>
      		<div class="box-footer">
      			<div class="form-group">
	      			<input type="submit" name="submit" class="form-control btn btn-info col-md-9" value="Create Location" />
	      		</div>
      		</div>
	     </form>
	      
	    </div>
	</div>
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