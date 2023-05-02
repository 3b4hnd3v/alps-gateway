<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<%!public String location = "", client ="", fu ="", fp ="";%>
<%
List<Map<String, String>> glogs = g.logs();
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
<section class="content-header"  style="margin-bottom:20px;">
  <h1>
    Systems Log
    <small>Low Level System Log</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li><a href="#">Logs</a></li>
    <li class="active">Systems Logs</li>
  </ol>
</section>
<!-- <hr class="style-eight"> -->
<section class="content">
  <div class="row">
  <div class="col-md-12">
    <!-- Custom Tabs (Pulled to the right) -->
    <div class="nav-tabs-custom">
      <ul class="nav nav-tabs pull-right">
        <li class="active"><a href="#tab_1-1" data-toggle="tab">LoginAuth</a></li>
        <li><a href="#tab_2-2" data-toggle="tab">DHCP</a></li>
        <li><a href="#tab_3-2" data-toggle="tab">Operation</a></li>
        <li><a href="#tab_3-3" data-toggle="tab">Access</a></li>
        <li><a href="#tab_3-4" data-toggle="tab">Errors</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">
           <span class="fa fa-cogs"></span> <span class="caret"></span>
          </a>
          <ul class="dropdown-menu">
            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Action</a></li>
            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Another action</a></li>
            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Something else here</a></li>
            <li role="presentation" class="divider"></li>
            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Separated link</a></li>
          </ul>
        </li>
        <li class="pull-left header"><i class="fa fa-th"></i>System Log</li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active table-responsive " id="tab_1-1">
          <%@include file="import.jsp" %><br><br>
          <table id="example1" class="table table-bordered table-striped table-responsive">
	          <thead>
	            <tr>
	              <th>Time</th>
	              <th>Activity</th>
	              <th>Scope</th>
	            </tr>
	          </thead>
	          <tbody>
	          <%
	              for (Map<String,String> mp : glogs) {
	           	   if(mp.get("topics").equalsIgnoreCase("hotspot,account,info,debug")){
					  	out.println("<tr>");
						out.println("<td>"+mp.get("time")+"</td>");
						out.println("<td>"+mp.get("message")+"</td>");
						out.println("<td>"+mp.get("topics")+"</td>");
						out.println("</tr>");
	           	   }
			  }%>
	          </tbody>
	          <tfoot>
	                    
	          </tfoot>
	      </table>
        </div><!-- /.tab-pane -->
        <div class="tab-pane  table-responsive" id="tab_2-2">
          <%@include file="import.jsp" %><br><br>
          <table id="example2" class="table table-bordered table-striped table-responsive">
	          <thead>
	            <tr>
	              <th>Time</th>
	              <th>Activity</th>
	              <th>Scope</th>
	            </tr>
	          </thead>
	          <tbody>
	          <%
	              for (Map<String,String> mp : glogs) {
	           	   if(mp.get("topics").equalsIgnoreCase("dhcp,info")){
					  	out.println("<tr>");
						out.println("<td>"+mp.get("time")+"</td>");
						out.println("<td>"+mp.get("message")+"</td>");
						out.println("<td>"+mp.get("topics")+"</td>");
						out.println("</tr>");
	           	   }
			  }%>
	          </tbody>
	          <tfoot>
	                    
	          </tfoot>
	      </table>
        </div><!-- /.tab-pane -->
        <div class="tab-pane" id="tab_3-2">
          <%@include file="import.jsp" %><br><br>
          <table id="example3" class="table table-bordered table-striped table-responsive">
	          <thead>
	            <tr>
	              <th>Time</th>
	              <th>Activity</th>
	              <th>Scope</th>
	            </tr>
	          </thead>
	          <tbody>
	          <%
	              for (Map<String,String> mp : glogs) {
	           	   if(mp.get("topics").equalsIgnoreCase("system,info")){
					  	out.println("<tr>");
						out.println("<td>"+mp.get("time")+"</td>");
						out.println("<td>"+mp.get("message")+"</td>");
						out.println("<td>"+mp.get("topics")+"</td>");
						out.println("</tr>");
	           	   }
			  }%>
	          </tbody>
	          <tfoot>
	                    
	          </tfoot>
	      </table>
        </div><!-- /.tab-pane -->
        <div class="tab-pane" id="tab_3-3">
          <%@include file="import.jsp" %><br><br>
          <table id="example4" class="table table-bordered table-striped table-responsive">
	          <thead>
	            <tr>
	              <th>Time</th>
	              <th>Activity</th>
	              <th>Scope</th>
	            </tr>
	          </thead>
	          <tbody>
	          <%
	              for (Map<String,String> mp : glogs) {
	           	   if(!mp.get("message").contains("api") && !mp.get("message").contains("via web") && mp.get("topics").equalsIgnoreCase("system,info,account")){
					  	out.println("<tr>");
						out.println("<td>"+mp.get("time")+"</td>");
						out.println("<td>"+mp.get("message")+"</td>");
						out.println("<td>"+mp.get("topics")+"</td>");
						out.println("</tr>");
	           	   }
			  }%>
	          </tbody>
	          <tfoot>
	                    
	          </tfoot>
	      </table>
        </div><!-- /.tab-pane -->
        <div class="tab-pane" id="tab_3-4">
          <%@include file="import.jsp" %><br><br>
          <table id="example4" class="table table-bordered table-striped table-responsive">
	          <thead>
	            <tr>
	              <th>Time</th>
	              <th>Activity</th>
	              <th>Scope</th>
	            </tr>
	          </thead>
	          <tbody>
	          <%
	              for (Map<String,String> mp : glogs) {
	           	   if(!mp.get("message").contains("api") && !mp.get("message").contains("via web") && !mp.get("message").contains("router") && mp.get("topics").contains("error")){
					  	out.println("<tr>");
						out.println("<td>"+mp.get("time")+"</td>");
						out.println("<td>"+mp.get("message")+"</td>");
						out.println("<td>"+mp.get("topics")+"</td>");
						out.println("</tr>");
	           	   }
			  }%>
	          </tbody>
	          <tfoot>
	          </tfoot>
	      </table>
        </div><!-- /.tab-pane -->
      </div><!-- /.tab-content -->
    </div><!-- nav-tabs-custom -->
  </div><!-- /.col -->
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
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.js"></script>
<script>
  $(function () {
	$("#example1").DataTable({"responsive": true});
	$("#example2").DataTable({"responsive": true});
	$("#example3").DataTable({"responsive": true});
	$("#example4").DataTable({"responsive": true});

    $('#example5').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true
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