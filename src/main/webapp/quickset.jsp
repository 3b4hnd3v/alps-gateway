<%@include file="header.jsp" %>

<body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
String message = null, error = null;
boolean dns = false, dos = false, ddos = false, bh = false; 
%>
<% //Walled Garden
if(request.getParameter("update") != null && request.getParameter("update").equals("Update")) {
	
	try {
		String stid = request.getParameter("stid").toString();
		String stn = request.getParameter("setting_name").toString();
		String stv = request.getParameter("setting_value").toString().trim();
		
		if(dao.updateSetting(stid, stn, stv)){
		
			String logact = "Setting "+stn+" updated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			response.sendRedirect("quickset.jsp?type=success&msg=Setting Updated Successfully");
		}else{
			response.sendRedirect("quickset.jsp?type=error&msg=Cannot Update Settings at the moment");
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}

if(request.getParameter("q") != null && request.getParameter("q").equals("ddos")) {
	
	try {
		String action = request.getParameter("act");
		
		if(g.DDosAttack(action)){
			String logact = "DDOS Protection has been "+action+" By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			message = "DDOS Protection has been "+action;
		}else{
			error = "DDOS Protection can not be "+action;
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}
if(request.getParameter("q") != null && request.getParameter("q").equals("dos")) {
	
	try {
		String action = request.getParameter("act");
		
		if(g.DosAttack(action)){
			String logact = "DOS Protection has been "+action+" By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			message = "DOS Protection has been "+action;
		}else{
			error = "DDOS Protection can not be "+action;
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}
if(request.getParameter("q") != null && request.getParameter("q").equals("dns")) {
	
	try {
		String action = request.getParameter("act");
		
		if(mg.DnsAttack(action)){
			String logact = "DDOS Protection has been "+action+" By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			message = "DDOS Protection has been "+action;
		}else{
			error = "DDOS Protection can not be "+action;
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<%
    dns = mg.DNSRuleStatus();
    ddos = g.DDOSRuleStatus();
    dos = g.DOSRuleStatus();
%>
<%
if(request.getParameter("q") != null && request.getParameter("q").equals("blackhole")) {
	
	try {
		String action = request.getParameter("act");
		
		if(g.BlackHoleA(action) && g.BlackHoleF(action)){
			if(!dns && action.equalsIgnoreCase("enable")){mg.DnsAttack(action);}
			if(!ddos  && action.equalsIgnoreCase("enable")){g.DDosAttack(action);}
			if(!dos  && action.equalsIgnoreCase("enable")){g.DosAttack(action);}
			String logact = "Black Hole Protection has been "+action+" By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			message = "Black Hole Protection has been "+action;
		}else{
			error = "Black Hole Protection can not be "+action;
		}
		
	} catch (Exception e1) { System.out.println(e1); }
}
%>
<%
//boolean bha = g.BHRuleStatusA();
//boolean bhf = g.BHRuleStatusF();
//bh = bha && bhf;
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
<%if(message != null){ %>
	<div class="alert alert-success alert-dismissible">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <h4><i class="icon fa fa-info"></i></h4>
	  <%=message %>
	</div>
<%}%>
<%if(error != null){ %>
	<div class="alert alert-danger alert-dismissible">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <h4><i class="icon fa fa-info"></i></h4>
	  <%=error %>
	</div>
<%}%>
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Network Preference
    <small>Gateway Settings</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Settings</a></li>
    <li class="active">Preferences</li>
  </ol>
</section>
<section class="content">
 <div class="row">
   <div class="col-xs-12"><!-- /.box -->

     <div class="box">
       <div class="box-header">
         <h3 class="box-title">Network Preferences</h3>
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
			 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `settings` WHERE `setting_group`='Preference'");
				while(rs1.next()){
					
			 		String stid=rs1.getString("id");
			 		String stn=rs1.getString("setting_name");
					String val = rs1.getString("setting_value");
				  	String btn_ed = "<a href='?q=delete&stid="+stid+"'><button class='btn btn-md btn-danger'><i class='fa fa-times pull-right'></i></button></a>";
			
					out.println("<tr>");
					out.println("<td>"+stid+"</td>");
					out.println("<form><td>"+rs1.getString("setting_name").replace("_", " ")+"<input type='hidden' class='form-control' name='setting_name' value='"+stn+"'></td>");
					out.println("<td width='50%'><div class='form-group'><input type='text' class='form-control' name='setting_value' value='"+val+"'><div></td>");
					out.println("<td><input type='hidden' class='form-control' name='stid' value='"+stid+"'><input type='submit' class='btn btn-info' name='update' value='Update'></td></form></tr>");
			
				 }
				cn.close();
			} catch(Exception e) { System.out.println(e);} 
			%>
			</tbody>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
      <!-- SECURITY DDOS-->
      <div class="box box-danger">
       <div class="box-header">
         <h3 class="box-title">DDOS Protection</h3>
       </div><!-- /.box-header -->
       <div class="box-body">
        <div class="col-lg-10">
        	DDOS Protection Setting
        </div>
        <div class="col-lg-2">
        <%if(ddos){ %>
        	<a href="?q=ddos&act=enable"><button class="btn btn-success">Activate</button></a>
        <%}else{ %>
        	<a href="?q=ddos&act=disable"><button class="btn btn-danger">Suspend</button></a>
        <%}%>
        </div>
       </div><!-- /.box-body -->
      </div><!-- /.box -->
      <!-- SECURITY DOS-->
      <div class="box box-danger">
       <div class="box-header">
         <h3 class="box-title">DOS Protection</h3>
       </div><!-- /.box-header -->
       <div class="box-body">
         <div class="col-lg-10">
        	DOS Protection Setting
         </div>
         <div class="col-lg-2">
         <%if(dos){ %>
         	<a href="?q=dos&act=enable"><button class="btn btn-success">Activate</button></a>
         <%}else{ %>
            <a href="?q=dos&act=disable"><button class="btn btn-danger">Suspend</button></a>
         <%}%>
         </div>
       </div><!-- /.box-body -->
      </div><!-- /.box -->
      <!-- SECURITY DOS-->
      <div class="box box-danger">
       <div class="box-header">
         <h3 class="box-title">DNS Protection</h3>
       </div><!-- /.box-header -->
       <div class="box-body">
         <div class="col-lg-10">
        	DNS Protection Setting
         </div>
         <div class="col-lg-2">
         <%if(dns){ %>
        	<a href="?q=dns&act=enable"><button class="btn btn-success">Activate</button></a>
         <%}else{ %>
         	<a href="?q=dns&act=disable"><button class="btn btn-danger">Suspend</button></a>
         <%}%>
         </div>
       </div><!-- /.box-body -->
      </div><!-- /.box -->
      <!-- SECURITY BLACKHOLE
      <div class="box box-danger">
       <div class="box-header">
         <h3 class="box-title">Black Hole Absolute Protection</h3>
       </div>
       <div class="box-body">
         <div class="col-lg-10">
        	Black Hole Absolute Protection Setting <%//out.print(String.valueOf(bha)+"= "+ String.valueOf(bhf));%>
         </div>
         <div class="col-lg-2">
         <%if(bh){%>
         	<a href="?q=blackhole&act=enable"><button title="Enable for total cyber protection" class="btn btn-success">Activate</button></a>
         <%}else{%>
         	<a href="?q=blackhole&act=disable"><button title="Enable for total cyber protection" class="btn btn-danger">Suspend</button></a>
         <%}%>
         </div>
       </div>
      </div>
      SECURITY BLACKHOLE-->
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