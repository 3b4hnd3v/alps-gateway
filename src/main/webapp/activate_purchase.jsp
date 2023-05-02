<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public InputStream data, error;
String url = "",
charset = "UTF-8";  // Or in Java 7 and later, use the constant: java.nio.charset.StandardCharsets.UTF_8.name()%>
<%!public void changeStat(String id){
	try{
		URL jsonpage = new URL("prepaid.alpsgateway.com/changestat.php?id="+id);
		URLConnection urlcon = jsonpage.openConnection();
	}catch(Exception e){System.out.println(e);}
}%>
<%
connect();
try {
  	ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM `settings` where setting_name='pcode'");
  	
  	while(rs.next()){
  		url = rs.getString("setting_value");
  		
  	}
		
		cn.close();
} catch(Exception e) {  System.out.println(e);}
%>
<%
if (request.getParameter("submit") != null && request.getParameter("submit").equals("Activate Purchase")) {
	try {
	   String pcode = request.getParameter("pcode").toString();
	   
	   String recv;
	   String recvbuff = "";
	   URL jsonpage = new URL(url+"?pcode="+pcode);
	   URLConnection urlcon = jsonpage.openConnection();
	   BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));
	
	   while ((recv = buffread.readLine()) != null){
	    recvbuff += recv;
	    
	   
	   }
	   buffread.close();
	   
	   Object obj=JSONValue.parse(recvbuff);
	   JSONArray array=(JSONArray)obj;
	   connect();
	   for(int i=1; i< array.size(); i++){
		  
		   JSONObject obj2=(JSONObject)array.get(i);
		
		   PreparedStatement ps = cn.prepareStatement("INSERT INTO `voucher` (username, password, profile, pcode, uptime, server) "
 					+ "VALUES(?, ?, ?, ?, ?, ?)");
 			
 			ps.setString(1, obj2.get("username").toString());
 			ps.setString(2,obj2.get("password").toString());
 			ps.setString(3,obj2.get("profile").toString());
 			ps.setString(4,obj2.get("pcode").toString());
 			ps.setString(5,obj2.get("uptime").toString());
 			ps.setString(6,obj2.get("server").toString());
 			if(ps.executeUpdate() == 1){
	 			System.out.println("Voucher Saved!");
	 			
	 			String id = obj2.get("id").toString();
	 			String un = obj2.get("username").toString();
	 			String pw = obj2.get("password").toString();
	 			String prof = obj2.get("profile").toString();
	 			String upt = obj2.get("uptime").toString();
	 			String svr = obj2.get("server").toString().toLowerCase();
	 			
	 			try{if(g.createPrepaidUser(un, pw, prof, upt, svr)){changeStat(id);}} catch(Exception e) {response.sendRedirect("activate_purchase.jsp?msg=Activation facing problem. Please Try Again Later!&type=error"); }
 			}	   
	   }
	   String logact = "Prepaid Purchase With Code "+pcode+" Activated By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
	   al.addLog(logact);
	   cn.close();
	   response.sendRedirect("activate_purchase.jsp?msg=Activation Successful!&type=success");
	   } catch(Exception e) { out.println("<tr>");
	    		 	out.println("<td>Could Not Activate Your Prepaid Purchase at the Moment</td>");
	    		 	 out.println("</tr>");
	    		 	String logact = "ERROR IN Prepaid Activation By = "+session.getAttribute("name")+" from "+session.getAttribute("dept")+". Username: "+session.getAttribute("username");
	    			al.addLog(logact);
		}
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
           Activate Purchase
           <small>Activate Prepaid Purchase</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">Prepaid</a></li>
           <li class="active">Activate Purchase</li>
         </ol>
       </section>
	<section class="content-header">
		<div class="panel box box-primary">
           <div class="box-header with-border">
             <h4 class="box-title">
               <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                 Activate Prepaid Purchase
               </a>
             </h4>
           </div>
           <div id="collapseOne" class="panel-collapse collapse">
             <div class="box-body">
             <form action="activate_purchase.jsp" method="post">
				 <label>Enter Purchase Code</label>
					<input type="text" class="form-control" name="pcode"><br />
				<input type="submit" name="submit" class="form-control btn btn-info" value="Activate Purchase" />
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
                 <h3 class="box-title">Existing Prepaid Users</h3>
               </div><!-- /.box-header -->
               <div class="box-body">
                 <table id="example1" class="table table-bordered table-striped">
                   <thead>
                     <tr>
                       <th>ID</th>
                       <th>Username</th>
                       <th>Password</th>
                       <th>Profile</th>
                       <th>Expiry</th>
                       <th>Login Count</th>
                       <th>Status</th>
                     </tr>
                   </thead>
                   <tbody>
                     <tbody>
                     <%
	                   connect();
	                   try {
		                 	ResultSet rs1 = cn.createStatement().executeQuery("SELECT * FROM `voucher`");
		                 	
		                 	while(rs1.next()){
		                 		out.println("<tr>");
		            		 	out.println("<td>"+rs1.getString("id")+"</td>");
		            		 	out.println("<td>"+rs1.getString("username")+"</td>");
		            		 	out.println("<td>"+rs1.getString("password")+"</td>");
		            		 	out.println("<td>"+rs1.getString("profile")+"</td>");
		            		 	out.println("<td>"+rs1.getString("expiry")+"</td>");
		            		 	out.println("<td>"+rs1.getString("log_count")+"</td>");
		            		 	out.println("<td>"+rs1.getString("status")+"</td>");
		            		 	out.println("</tr>");
		                 	}
		               		
		               		cn.close();
		               	} catch(Exception e) { System.out.print(e);}
	                %>
                   	 
				</tbody>
				</table>
				</div>
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
<!-- ChartJS 1.0.1 -->
<script src="plugins/chartjs/Chart.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard2.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<script>
	$(document).ready(function () {
	    // check whether tableExport plugin is loaded
	    if (typeof $.tableExport !== "function") {
	    	$.getScript("plugins/tableexport/tableExport.js");
	    	$.getScript("plugins/tableexport/jquery.base64.js");
	    	$.getScript("plugins/tableexport/html2canvas.js");
	    	$.getScript("plugins/tableexport/jspdf/libs/sprintf.js");
	    	$.getScript("plugins/tableexport/jspdf/jspdf.js");
	    	$.getScript("plugins/tableexport/jspdf/libs/base64.js");
	        //alert("imported");
	    }
	});
</script>
<!-- page script -->
</body>
</html>