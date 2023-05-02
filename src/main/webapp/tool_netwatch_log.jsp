<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="toolbar.jsp" %>
<%
String ipmessage = "", mac = ""; 

if(request.getParameter("item") != null) {
	mac = request.getParameter("item");
}
%>

<div class="content-wrapper">
	<!-- Content Header (Page header) -->
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
	<%} %>
	<%if(ipmessage != null && !ipmessage.equals("")){ %>
		<div class="alert alert-info alert-dismissible">
		  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		  <h4><i class="icon fa fa-info"></i> Alert!</h4>
		  <%out.println(ipmessage); %>
		</div>
	<%} %>
	<section class="content-header">
	  <h1>
	    LetMeOut<sup>TM</sup> Setup
	    <small>WAN LetMeOut<sup>TM</sup> Setup</small>
	  </h1>
	  <ol class="breadcrumb">
	    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	    <li><a href="#">Main</a></li>
	    <li class="">WAN</li>
	    <li class="active">Interfaces</li>
	  </ol>
	</section>
	<section class="content-header"><p></section>	
	<section class="content">
	  <div class="box">
        <div class="box-header">
          <h3 class="box-title"> ALPS Sense<sup>TM</sup> Logs <small>Device Monitor Log</small></h3>
        </div><!-- /.box-header -->
        <div class="box-body table-responsive" style="max-height:500px; overflow-y:scroll;">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>Event</th>
                <th>Device</th>
                <th>MAC</th>
                <th>IP</th>
                <th>Notes</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
            <%
            MonitorLogs ml  = new MonitorLogs();
            ArrayList<MonitorLogs> mls = ml.getBy("mac", mac);
          	for (MonitorLogs mp : mls) {
			  	out.println("<tr>");
				out.println("<td>"+mp.getEvent()+"</td>");
				out.println("<td>"+mp.getDevice()+"</td>");
				out.println("<td>"+mp.getMac()+"</td>");
				out.println("<td>"+mp.getIp()+"</td>");
				out.println("<td>"+mp.getNotes()+"</td>");
				out.println("<td>"+mp.getAdded()+"</td>");
				out.println("</tr>");
			}
			%>
           	</tbody>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
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
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
<script>
  $(function () {
	$("#example1").DataTable({"responsive": true});
	$("#example2").DataTable({"responsive": true});
  });
</script>
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