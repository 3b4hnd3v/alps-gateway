<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%Mao mao = new Mao(); ComExec cex = new ComExec();%>
<% //Walled Garden
String def = mao.getSetting("default_ip");
if(request.getParameter("q") != null && request.getParameter("q").equals("rt")){
	String rswar = dao.getSetting("restart_path");
	cex.comExec(""+rswar);
		
	response.sendRedirect("http://"+def+"");
}
if(request.getParameter("update") != null && request.getParameter("update").equals("Update")) {
	
	try {
		String stid = request.getParameter("stid").toString();
		String stn = request.getParameter("setting_name").toString();
		String stv = request.getParameter("setting_value").toString();
		String qv = "rs";
		if(stn.equalsIgnoreCase("default_ip")){qv="rt";}
		if(mao.updateSetting(stid, stn, stv)){
		
			String logact = "Setting "+stn+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			response.sendRedirect("mw_prefs.jsp?q="+qv+"&type=success&msg=Setting Updated Successfully");
		}else{
			response.sendRedirect("mw_prefs.jsp?type=error&msg=Cannot Update Settings at the moment");
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}
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
    MultiWan - Settings
    <small>MultiWan Settings</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">MultiWan</a></li>
    <li class="active">Preferences</li>
  </ol>
</section>
<section class="content">
 <div class="row">
   <div class="col-xs-12"><!-- /.box -->

     <div class="box">
       <div class="box-header">
         <h3 class="box-title">Multi - WAN Preferences </h3>
       </div><!-- /.box-header -->
       <div class="box-body">
         <table id="example1" class="table table-bordered table-striped">
           <thead>
           <tr>
			<th>ID</th>
			<th>Setting Name</th>
			<th>Setting Value</th>
			<th>Update Setting</th>
		   </tr>
		   </thead>
           <tbody>
			<% 
			connect();
			try {
			 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `master_set` WHERE `setting_group`='preferences'");
				while(rs1.next()){
			 		String stid=rs1.getString("id");
			 		String stn=rs1.getString("setting_name");
					String val = rs1.getString("setting_value");
			
					out.println("<tr>");
					out.println("<td>"+stid+"</td>");
					out.println("<form><td>"+rs1.getString("setting_name")+"<input type='hidden' class='form-control' name='setting_name' value="+stn+"></td>");
					out.println("<td><input type='text' class='form-control' name='setting_value' value="+val+"></td>");
					out.println("<td><input type='hidden' class='form-control' name='stid' value="+stid+"><input type='submit' class='btn btn-info' name='update' value='Update'></td></form></tr>");
			
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