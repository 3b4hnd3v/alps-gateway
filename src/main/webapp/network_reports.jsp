<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
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
	<br>
	  <h1>
	    Network Reports
	    <small>Graphical Network Reports</small>
	  </h1>
	  <ol class="breadcrumb">
	    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	    <li><a href="hotspot.jsp?q=walledgarden">Reports</a></li>
	    <li class="active">Network</li>
	  </ol>
	</section>
	<hr>
	<div class="row col-md-12" align="center">
		<div class="col-md-6">
	        <div class="box box-solid">
	          <div class="box-header with-border">
	            <h3 class="box-title">Location Based Bandwidth Usage - Upload <i class="fa fa-arrow-up"></i></h3>
	          </div><!-- /.box-header -->
	          <div class="box-body">
	          	<img alt="Location Download" src="chart?type=locbandown&w=800&h=500" class="img-responsive">
	          </div>
	          <div class="box-footer with-border">
	            <p></p>
	          </div><!-- /.box-header -->
	        </div>
	    </div>
	    <div class="col-md-6">
	        <div class="box box-solid">
	          <div class="box-header with-border">
	            <h3 class="box-title">Location Based Bandwidth Usage - Download <i class="fa fa-arrow-down"></i></h3>
	          </div><!-- /.box-header -->
	          <div class="box-body">
	          	<img alt="Location Download" src="chart?type=locbanup&w=800&h=500" class="img-responsive">
	          </div>
	          <div class="box-footer with-border">
	            <p></p>
	          </div><!-- /.box-header -->
	        </div>
	    </div>
	</div>
	<div class="row col-md-12" align="center">
		<div class="col-md-6">
	        <div class="box box-solid">
	          <div class="box-header with-border">
	            <h3 class="box-title">VLAN Based Bandwidth Usage - Upload <i class="fa fa-arrow-up"></i></h3>
	          </div><!-- /.box-header -->
	          <div class="box-body">
	          	<img alt="Location Download" src="chart?type=vlbanup&w=800&h=500" class="img-responsive">
	          </div>
	          <div class="box-footer with-border">
	            <p></p>
	          </div><!-- /.box-header -->
	        </div>
	    </div>
	    <div class="col-md-6">
	        <div class="box box-solid">
	          <div class="box-header with-border">
	            <h3 class="box-title">VLAN Based Bandwidth Usage - Download <i class="fa fa-arrow-down"></i></h3>
	          </div><!-- /.box-header -->
	          <div class="box-body">
	          	<img alt="Location Download" src="chart?type=vlbandown&w=800&h=500" class="img-responsive">
	          </div>
	          <div class="box-footer with-border">
	            <p></p>
	          </div><!-- /.box-header -->
	        </div>
	    </div>
	</div>
	
	<div class="row col-md-12" align="center">
		<div class="col-md-6">
	        <div class="box box-solid">
	          <div class="box-header with-border">
	            <h3 class="box-title">Location Based Packet Drops</h3>
	          </div>
	          <div class="box-body">
	          	<img alt="Location Download" src="chart?type=locdrop&w=800&h=500" class="img-responsive">
	          </div>
	          <div class="box-footer with-border">
	            <p></p>
	          </div>
	        </div>
	    </div>
	    <div class="col-md-6">
	        <div class="box box-solid">
	          <div class="box-header with-border">
	            <h3 class="box-title">VLAN Based Packet Drops</h3>
	          </div>
	          <div class="box-body">
	          	<img alt="Vlan Download" src="chart?type=vldrop&w=800&h=500" class="img-responsive">
	          </div>
	          <div class="box-footer with-border">
	            <p></p>
	          </div>
	        </div>
	    </div>
	</div>
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
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard2.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<script>
 $(document).ready(function() {
     $('#example1').DataTable({
             responsive: true
      });
  });
</script>
<!-- page script -->
</body>
</html>