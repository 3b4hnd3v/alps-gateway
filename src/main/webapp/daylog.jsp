<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public String dlb;
public String getLogdir() {
	// TODO Auto-generated method stub
	String dir = "";
	connect();
	try {
		ResultSet rs = cn.createStatement().executeQuery("SELECT * FROM settings WHERE setting_name='log_location'"); rs.next();
		dir = rs.getString("setting_value").toString();
		cn.close();
	} catch (SQLException e) { e.printStackTrace(); }
	return dir;
	
}%>
<%
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
DateFormat dateFormat1 = new SimpleDateFormat("dd-MMM-YYYY HH:MM:ss");
Date date = new Date();
String today = dateFormat.format(date);
String logtime = dateFormat1.format(date);
String daylog = "AlpsLog "+today+".txt";
String logdir = getLogdir();
String logfile = logdir + daylog;
Path file = Paths.get(logfile);
String logdata = "";
Charset charset = Charset.forName("US-ASCII");
List<File> loglist = al.listLog(logdir);
try{
	BufferedReader reader = Files.newBufferedReader(file, charset);
    String line = null;
    while ((line = reader.readLine()) != null) {
        logdata=logdata.concat(line+"<hr>");
    }
    reader.close();
} catch (IOException e) {
    System.err.format("IOException: %s%n", e);
}
%>
<div class="content-wrapper">
<!-- Content Header (Page header) -->
       <section class="content-header">
         <h1>
           System Logs
           <small>System Activity Logs</small>
         </h1>
         <ol class="breadcrumb">
           <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="#">System Logs</a></li>
           <li class="active">Activity Logs</li>
         </ol>
       </section>
       <p><br><br></p>
       <hr class="style-eight">
       <section class="content">
	   		<div class="row">
		       <div class="col-md-12">
	             <!-- Custom Tabs (Pulled to the right) -->
	             <div class="nav-tabs-custom">
	               <ul class="nav nav-tabs pull-right">
	                 <li class="active"><a href="#tab_1-1" data-toggle="tab">Today Log</a></li>
	                 <li><a href="#tab_2-2" data-toggle="tab">Archive</a></li>
	                 <li><a href="#tab_3-2" data-toggle="tab">Quick Download</a></li>
	                 <li class="dropdown">
	                   <a class="dropdown-toggle" data-toggle="dropdown" href="#">
	                      <i class="fa fa-cogs"></i><span class="caret"></span>
	                   </a>
	                   <ul class="dropdown-menu">
	                     <li role="presentation"><a role="menuitem" tabindex="-1" href="daylogdl.jsp?q=daylog&fn=<%out.println(daylog);%>&fd=<% out.println(logdir);%>">Download</a></li>
	                     <!--  <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Another action</a></li>
	                     <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Something else here</a></li>-->
	                     <li role="presentation" class="divider"></li>
	                     <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Separated link</a></li>-->
	                   </ul>
	                 </li>
	                 <li class="pull-left header"><i class="fa fa-th"></i> Daily Logs</li>
	               </ul>
	               <div class="tab-content">
	                 <div class="tab-pane active" id="tab_1-1">
	                   <div style="min-height:200px; max-height:900px;overflow-y: scroll;">
	                   		<p>
	                   			<% out.println(logdata); %>
	                   			<br>
	                   		</p>
	                   </div>
	                 </div><!-- /.tab-pane -->
	                 <div class="tab-pane" id="tab_2-2">
	                   <table id="example1" class="table table-bordered table-striped table-responsive">
					      <thead>
					        <tr>
					          <th>File</th>
					          <th>Size</th>
					          <th>Log Date</th>
					          <th>Last Modified</th>
					          <th><i class="fa fa-cog"></i></th>
					        </tr>
					      </thead>
					      <tbody>
					      <%
		         		   try{
		         			  
		         			  for (File mp : loglist) {
		         				   String btn_dl = "<a href='daylogdl.jsp?fn='"+mp.getName()+"'><button class='btn btn-xs btn-warning'><i class='fa fa-download'></i></button></a>";
			         			   out.println("<tr>");
				   				   out.println("<td>"+mp.getName()+"</td>");
				   				   out.println("<td>"+Math.round(mp.length() * 1.000)/1000.000+" kb</td>");
				   				   out.println("<td>"+mp.getName().substring(8, mp.getName().length()-4)+"</td>");
				   				   out.println("<td>"+dateFormat.format(mp.lastModified())+"</td>");
						  %>
								   <td><a href="daylogdl.jsp?fn=<% out.println(mp.getName());%>&qdown=<% out.println(mp.getAbsolutePath());%>"><button class="btn btn-xs btn-bg-navy pull-right"><i class="fa fa-download"></i></button></a></td>
						  <%
				   				   out.println("</tr>");
		         			  }
		         		   }catch(Exception e){}
						%>
				         </tbody>
				       </table>
	                 </div><!-- /.tab-pane -->
	                 <div class="tab-pane" id="tab_3-2">
	                   <b>Enter Date To Download Previous Date Logs:</b>
	                   <p><br><br></p>
	                   <div class="row">
		        			<div class="col-xs-12">
			                   <form action="daylogdl.jsp" class="form-horizontal" method="post">
				                   <input type="hidden" class="form-control" name="fd" value="<% out.println(logdir);%>"/>
				                   <div class="col-md-10">
				                   		<input type="date" class="form-control" name="fn" />
				                   </div>
				                   <input type="submit" class="btn btn-primary pull-right" value="Download" name="download"/>
			                   </form>			                   
			               </div>
			               <div class="col-xs-12">
			               		<p><small class="text-aqua">Date Format Should be [dd/mm/yyyy] e.g: 10/08/2015</small></p>
			               </div>
			           </div>
	                 </div><!-- /.tab-pane -->
	               </div><!-- /.tab-content -->
	             </div><!-- nav-tabs-custom -->
	           </div><!-- /.col -->
         	</div> <!-- /.row -->
         	<!-- END CUSTOM TABS -->
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