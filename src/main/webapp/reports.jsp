<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedx sidebar-mini" onload="tableExport()">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="sidebar.jsp" %>
<% String gip = dao.getSetting("default_ip"); %>
<div class="content-wrapper">
	<section class="content">
		<div class="row">
		  <div class="bs-example col-md-12">
		    <div id="graphic" class="embed-responsive embed-responsive-16by9" style="min-height:900px; max-height:900px; overflow-y:scroll;">
		      
		      <!-- <iframe height="100px" class="embed-responsive-item" src="//<% //out.println(gip); %>/graphs/"></iframe>
		      <div id="graphic"></div> -->
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
<script> 
    $(function(){
      $("#graphic").load("graph.jsp"); 
    });
    </script> 
<script type="text/javascript">
$(document).ready(function () {
    //Disable full page
    $("body").on("contextmenu",function(e){
        return false;
    });
    
    //Disable part of page
    //$("#id").on("contextmenu",function(e){
        //return false;
    //});
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
<!-- page script -->
</body>
</html>