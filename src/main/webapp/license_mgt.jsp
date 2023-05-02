<%@include file="header.jsp" %>

<body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
String license = "No-Generated-License", gendate = "";
String lic  = dao.checklicense();
if(request.getParameter("update") != null && request.getParameter("update").equals("Update")) {
	
	try {
		String stid = request.getParameter("stid");
		String stn = request.getParameter("setting_name");
		String stv = request.getParameter("setting_value");
		
		if(dao.updateSetting(stid, stn, stv)){
		
			String logact = "Setting "+stn+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			response.sendRedirect("quickset.jsp?type=success&msg=Setting Updated Successfully");
		}else{
			response.sendRedirect("quickset.jsp?type=error&msg=Cannot Update Settings at the moment");
		}
		
	} catch (Exception e1) { System.out.println(e1); }
	
	
}

try{
    connect();
    ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `system_license` WHERE `status`='New'");
	while(rs1.next()){
		license =rs1.getString("license"); 
		gendate =rs1.getString("gendate"); 
	}
	cn.close();
}catch(Exception e){System.out.print(e);}
%>
<div class="content-wrapper">
<!-- Error Message -->
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
    ALPS License Manager
    <small>System License</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Settings</a></li>
    <li class="active">System License</li>
  </ol>
</section>
<section class="content" style="margin-top:20px;">
	<div class="row">
		<div class="col-xs-12"><!-- /.box -->
			<!-- Profile Image -->
              <div class="box box-primary">
                <div class="box-body box-profile">
                  <!-- <img class="profile-user-img img-responsive img-circle" src="../../dist/img/user4-128x128.jpg" alt="User profile picture"> -->
                  <h3 class="profile-username text-center"><%= dao.getDashValue("client") %></h3>
                  <p class="text-muted text-center"><%= dao.getDashValue("location") %></p>

                  <ul class="list-group list-group-unbordered">
                    <li class="list-group-item">
                      <b>License</b> <a class="pull-right"><%= dao.getDashValue("license") %></a>
                    </li>
                    <li class="list-group-item">
                      <b>User License</b> <a class="pull-right"><%= dao.getSetting("guest_cap") %></a>
                    </li>
                    <li class="list-group-item">
                      <b>Expiry Date</b> <a class="pull-right"><%= dao.getDashValue("licexp") %></a>
                    </li>
                    <li class="list-group-item">
                      <b>Activation Date</b> <a class="pull-right"><%= dao.getDashValue("licact") %></a>
                    </li>
                    <li class="list-group-item">
                      <b>License Validity</b> <a class="pull-right"><%= lic %></a>
                    </li>
                    
                  </ul>
				  <% if(!lic.equalsIgnoreCase("valid")){ %>
				  	<form action="" method="post">
				  		<input type="hidden" value="<%= dao.getDashValue("client") %>" name="client" />
				  		<input type="hidden" value="<%= dao.getDashValue("location") %>" name="location" />
				  		<input type="hidden" value="<%= dao.getDashValue("guest_cap") %>" name="guestcap" />
                  		<button type="submit" name="request_renew" class="btn btn-primary btn-block"><b>Request License Renewal</b></button>
				  	</form>
                  <% } %>
                </div><!-- /.box-body -->
              </div><!-- /.box -->
			  <!-- Get A List Of Available Licenses For This Client -->
			  <% if(!license.equalsIgnoreCase("No-Generated-License") && !lic.equalsIgnoreCase("valid")){ %>
			  <!-- Horizontal Form -->
			  <div class="box box-info">
			   <div class="box-header with-border">
			     <h3 class="box-title">Activate New License</h3>
			   </div><!-- /.box-header -->
			   <!-- form start -->
			   <form action="license_admin.jsp" method="post" class="form-horizontal">
			     <div class="box-body">
				   <div class="form-group">
			       	<label for="ip" class="col-sm-2 control-label">Generated License</label>
			         <div class="col-sm-10">
			           <input type="text" class="form-control" id="genlic" name="genlic" value="<% out.print(license); %>">
			           <input type="text" class="form-control" id="gendate" name="gendate" value="<% out.print(gendate); %>">
			         </div>
			       </div>
			     </div>
			     
			     <div class="box-footer">
			       <!--  a href="alpsonline.alpsgateway.com"><button type="submit" class="btn btn-info">Order Now</button></a>-->
			       <input type="submit" name="submit" class="btn btn-info pull-right" value="Activate License" />
			     </div><!-- /.box-footer -->
			     </form>
			 </div><!-- /.box -->
			 <% } %>
              
		</div><!-- /.col -->
	</div><!-- /.row -->
</section><!-- /.content -->
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