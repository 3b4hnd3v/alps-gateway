<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%
String client = dao.getDashValue("client");
String license = "No-Generated-License", gendate = "";%>

<% //connect and disconnect ip
if(request.getParameter("submit") != null && request.getParameter("submit").equals("Generate New License")) {
	
	try {
		System.out.println("lic = "+license);
		String cli = request.getParameter("client");
		String date = request.getParameter("exd");
		String fulldate = date+" 00:00:00 GMT";
		gendate = date;
		license = License.generateLicense(cli, fulldate);
		System.out.println("lic = "+license);
		
		if(license.equals(null)){
			response.sendRedirect("license_admin.jsp?msg=Wrong Date Input&type=error");
		}else{
			dao.addLicense(license, gendate);
			
			String logact = "New License "+license+" generated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
		}
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("license_admin.jsp?msg=Wrong Date Input&type=error");
	}
}else if(request.getParameter("submit") != null && request.getParameter("submit").equals("Activate License")) {
	connect();
	try {
		String genlic = request.getParameter("genlic").toString();
		String expdate = request.getParameter("gendate").toString();
		String actdate = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());

		
		String licunix = genlic.split("-")[1];
		
		long timestamp = System.currentTimeMillis()/1000;
		String s = String.valueOf(timestamp);
		System.out.println(timestamp+"=="+licunix);
		String info = "company="+client+"&date="+expdate+"&act="+actdate;
		if(timestamp < Integer.parseInt(licunix)){
			cn.createStatement().execute("UPDATE settings SET setting_value='"+genlic+"' WHERE setting_name='license'");
			cn.createStatement().execute("UPDATE dashboard SET value='"+genlic+"' info='"+info+"' WHERE name='license'");	
			cn.createStatement().execute("UPDATE dashboard SET value='"+expdate+"' WHERE name='licexp'");	
			cn.createStatement().execute("UPDATE dashboard SET value='"+actdate+"' WHERE name='licact'");	
			cn.createStatement().execute("UPDATE `modules` SET active=1 where acquired='1'");
			cn.close();
			String logact = "New License "+genlic+" Activated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
			al.addLog(logact);
			System.out.println("Activated!");
			response.sendRedirect("index.jsp?msg=License Activated Successfully");
		}else{
			response.sendRedirect("license_admin.jsp?msg=Generated License is expired. Cannot Activate an expired license.&type=error");
		}
		
	} catch (Exception e1) { 
		System.out.println(e1); 
		response.sendRedirect("license_admin.jsp?msg=Cannot Activate Purchases at the moment&type=error");}
}
%>
<div class="content-wrapper">
<!-- Error Message -->
<%if(request.getParameter("msg") != null && request.getParameter("type").equals("error")){ %>
<div class="alert alert-danger alert-dismissible">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4><i class="icon fa fa-ban"></i> Oops :( !</h4>
  <%out.println(request.getParameter("msg").toString()); %>
</div>
<%}else if(request.getParameter("msg") != null && request.getParameter("type").equals("success")){ %>
<div class="alert alert-info alert-dismissible">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <h4><i class="icon fa fa-info"></i> Alert!</h4>
  <%out.println(request.getParameter("msg")); %>
</div>

<%} %>
<!-- Horizontal Form -->
 <div class="box box-info">
   <div class="box-header with-border">
     <h3 class="box-title">Activation</h3>
   </div><!-- /.box-header -->
   <!-- form start -->
   <form action="license_admin.jsp" method="post" class="form-horizontal">
     <div class="box-body">
       <div class="form-group">
       	<label for="ip" class="col-sm-2 control-label">Client</label>
         <div class="col-sm-10">
           <input type="text" class="form-control" id="client" name="client" value="<% out.println(client);%>" >
         </div>
       </div>
       <div class="form-group">
         <label for="ip" class="col-sm-2 control-label">Expiry Date</label>
         <div class="col-sm-10">
           <input type="text" class="form-control" id="exd" name="exd" placeholder="Fri, 25 Dec 2016">
           <small class="text-danger">* Date Format: "ddd, dd MMM yyyy"      e.g: Fri, 25 Dec 2016</small>
         </div>
       </div>
     </div>
     <div class="box-footer">
       <a href="index.jsp" ><button class="btn btn-default">Cancel</button></a>
       <input type="submit" name="submit" class="btn btn-info pull-right" value="Generate New License" />
     </div><!-- /.box-footer -->
   </form>
 </div><!-- /.box -->


 <!-- Horizontal Form -->
 <div class="box box-info">
   <div class="box-header with-border">
     <h3 class="box-title">Activate License</h3>
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