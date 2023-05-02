<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Save This PMS Setting")) {
	String pmsid = request.getParameter("pmsid");
	String pmsname = request.getParameter("pmsname");
	String pmsaddress = request.getParameter("pmsip");
	String pmsport = request.getParameter("pmsport");
	String pmsuser = request.getParameter("pmsuser");
	String pmskey = request.getParameter("pmskey");
	String pmsstatus = request.getParameter("pmsstatus");
	boolean res = dao.updatePMS(pmsid, pmsname, pmsaddress, pmsport,pmsuser,pmskey,pmsstatus);
	if(res && pmsstatus.equals("enable")){
		dao.updateSetting("active_pms", "internal");
	}
}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Save External Interface Server Setting")) {
	String pmsname = request.getParameter("pmsname");
	String pmsaddress = request.getParameter("pmsip");
	String pmsport = request.getParameter("pmsport");
	String pmsuser = request.getParameter("pmsuser");
	String pmskey = request.getParameter("pmskey");
	String pmsstatus = request.getParameter("pmsstatus");
	String value = pmsname+":"+pmsaddress+":"+pmsport+":"+pmsuser+":"+pmskey;
	boolean res = dao.updateSetting("external_pms", value);
	
	if(res && pmsstatus.equals("1")){
		dao.updateSetting("active_pms", "external");
	}
}
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Change Setting")) {
	
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
    PMS Management
    <small>PMS Settings and Preferences</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Policy</a></li>
    <li class="active">PMS</li>
  </ol>
</section>
<div><br /><br /><br /><br /></div>
<section class="content">
  <div class="row">
  <!-- <div class="col-md-12">
	  <div class="panel box box-primary">
	    <div class="box-header with-border">
	      <h4 class="box-title">
	        <a data-toggle="collapse" data-parent="#accordion" href="collapseOne">
	          Quick Switch Activation <span><i class="fa fa-angle-double-down"></i></span>
	        </a>
	      </h4>
	    </div>
	    <div id="collapseOne" class="panel-collapse collapse in">
	      <div class="box-body">
	      	<form action="create_event.jsp" method="post">
	      		<div class="form-group col-sm-12">
					<label>Status</label>
					<select required class="form-control" name="pmsstatus">
						<option value="">Select </option>
						<option value="external">External</option>
						<%
				       	 //connect();
				       	 //try {
				       		//ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `pms`");
				       	  	//while(rs.next()){
				       	  		//String pmsname = rs.getString("name");
				       	%>
				       			<option value=""></option>
				       	<%
				       	 	//}
				     		//cn.close();
						 //} catch(Exception e) { }
						%>
					</select>
				</div>
				<div class="form-group col-sm-12">
		      		<input type="submit" name="submit" class="form-control btn btn-info" value="Change Setting" />
		     	</div>
	      	</form>
	      </div>
	    </div>
	  </div>
  </div> -->
  <div class="col-md-12">
    <!-- Custom Tabs (Pulled to the right) -->
    <div class="nav-tabs-custom">
      <ul class="nav nav-tabs pull-right">
        <!-- <li class="active"><a href="#tab_1-1" data-toggle="tab">LoginAuth</a></li> -->
        <%
       	 connect();
       	 try {
       		ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `pms`");
       	  	while(rs.next()){
       	  		String pmsname = rs.getString("name");
       	%>
       			<li><a href="#<%=pmsname %>" data-toggle="tab"><%=pmsname %></a></li>
       	<%
       	 	}
     		cn.close();
		 } catch(Exception e) { }
		%>
        <li><a href="#External" data-toggle="tab">External Interface</a></li>
        <li class="active"><a href="#Current" data-toggle="tab">Current Settings</a></li>
        <li class="pull-left header"><i class="fa fa-th"></i>PMS Setting Management</li>
      </ul>
      <div class="tab-content">
      	
      	<%
       	 connect();
       	 try {
       		ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `pms`");
       	  	while(rs.next()){
       	  		String pmsid = rs.getString("id");
       	  		String pmsname = rs.getString("name");
       	  		String pmsip = rs.getString("ip");
       	  		String pmsport = rs.getString("port");
       	  		String pmsuser = rs.getString("user");
       	  		String pmskey = rs.getString("key");
       	  		String status = rs.getString("status");
       	%>
       			<div class="tab-pane" id="<%=pmsname %>">
       				<div class="panel box box-primary">
			           <div class="box-header with-border">
			             <h4 class="box-title">
			               <a data-toggle="collapse" data-parent="#accordion" href="collapseOne">
			                 <%=pmsname %> Activation <span><i class="fa fa-angle-double-down"></i></span>
			               </a>
			             </h4>
			           </div>
			           <div id="collapseOne" class="panel-collapse collapse in">
			             <div class="box-body">
			             	<form action="pms_mgt.jsp" method="post">
			             		<div class="form-group col-sm-12">
			                   	<label>Interface Name</label>
			                   		<input type="hidden" readonly class="form-control" name="pmsid" value="<% out.println(pmsid);%>"><br />
			                   		<input type="text" readonly class="form-control" name="pmsname" value="<% out.println(pmsname);%>"><br />
			                 	</div>
			             		<div class="form-group col-sm-12">
						      	<label>Address</label>
									<input type="text" class="form-control" name="pmsip" value="<% out.println(pmsip);%>"><br />
								</div>
								<div class="form-group col-sm-12">
						      	<label>Connection Port</label>
									<input type="text" class="form-control" name="pmsport" value="<% out.println(pmsport);%>"><br />
								</div>
								<div class="form-group col-sm-12">
								<label>User</label>
									<input type="text" class="form-control" name="pmsuser" value="<% out.println(pmsuser);%>"><br />
								</div>
								<div class="form-group col-sm-12">
								<label>Interface Key</label>
									<input type="text" class="form-control" name="pmskey" value="<% out.println(pmskey);%>"><br />
								</div>
								<div class="form-group col-sm-12">
									<label>Status</label>
									<select required class="form-control" name="pmsstatus">
										<option value="">Select </option>
										<option value="1">Enable</option>
										<option value="0">Disable</option>
									</select>
								</div>
								<div class="form-group col-sm-12">
						      		<input type="submit" name="submit" class="form-control btn btn-info" value="Save This PMS Setting" />
						     	</div>
						     </form>
			             </div>
			           </div>
			         </div>
       			</div>
       	<%
       	 	}
     		cn.close();
		 } catch(Exception e) { }
		%>
        <div class="tab-pane" id="External">
        	<%
	       	 connect();
	       	 try {
	       		String external = dao.getSetting("external_pms");
	       	%>
       				<div class="panel box box-primary">
			           <div class="box-header with-border">
			             <h4 class="box-title">
			               <a data-toggle="collapse" data-parent="#accordion" href="collapseOne">
			                 External Interface Activation <span><i class="fa fa-angle-double-down"></i></span>
			               </a>
			             </h4>
			           </div>
			           <div id="collapseOne" class="panel-collapse collapse in">
			             <div class="box-body">
			             	<form action="pms_mgt.jsp" method="post">
			             		<div class="form-group col-sm-12">
			                   	<label>External Database Name</label>
			                   		<input type="text" class="form-control" name="pmsname" value="<% out.println(external.split(":")[2]);%>"><br />
			                 	</div>
			             		<div class="form-group col-sm-12">
						      	<label>External Database Address</label>
									<input type="text" class="form-control" name="pmsip" value="<% out.println(external.split(":")[0]);%>"><br />
								</div>
								<div class="form-group col-sm-12">
						      	<label>External Database Connection Port</label>
									<input type="text" class="form-control" name="pmsport" value="<% out.println(external.split(":")[1]);%>"><br />
								</div>
								<div class="form-group col-sm-12">
								<label>External Database User</label>
									<input type="text" class="form-control" name="pmsuser" value="<% out.println(external.split(":")[3]);%>"><br />
								</div>
								<div class="form-group col-sm-12">
								<label>External Database Password</label>
									<input type="text" class="form-control" name="pmspass" value="<% out.println(external.split(":")[4]);%>"><br />
								</div>
								<div class="form-group col-sm-12">
									<label>Status</label>
									<select required class="form-control" name="pmsstatus">
										<option value="">Select </option>
										<option value="1">Enable</option>
										<option value="0">Disable</option>
									</select>
								</div>
								<div class="form-group col-sm-12">
						      		<input type="submit" name="submit" class="form-control btn btn-info" value="Save External Interface Server Setting" />
						     	</div>
						     </form>
			             </div>
			           </div>
			         </div>
	       	<%
			 } catch(Exception e) { }
			%>
        </div><!-- /.tab-pane -->
        <div class="tab-pane active" id="Current">
      		<% 
      			String active_pms = dao.getSetting("active_pms");
      			connectpms();
      			String active = cn1.toString();
      			cn1.close();
      		%>
      		
      		<p>The PMS Seting currently active on this gateway is: <strong><%=active_pms %></strong></p>
      		<br />
      		<p>The connection to the Integrated PMS Database returns Connection ID: <strong><%out.print(String.valueOf(active).split("@")[1]);%></strong></p>
      		<br />
      		<%if(active!=null){
      			out.print("<p class='text-success'><strong>Connection is active</strong></p>");
      		}else{
      			out.print("<p class='text-danger'><strong>Connection is servered. Please check settings</strong></p>");
      		}%>
      	</div>
      </div><!-- /.tab-content -->
    </div><!-- nav-tabs-custom -->
  </div><!-- /.col -->
  </div>
</section>          
<div><br /><br /><br /><br /></div>
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