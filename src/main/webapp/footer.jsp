
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
        <b>Version</b> 2.5
        </div>
        <strong>Copyright &copy; 2014-2015 <a href="http://www.alpsgateway.com">ALPS Gateway</a>.</strong> All rights reserved.
      </footer>
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
	<script>
	   $(document).ready(function() {
	       $('#example1').DataTable({
	               responsive: true
	        });
	    });
   </script>
	<!-- javascripts -->
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui-1.10.4.min.js"></script>
	<script src="js/jquery-1.8.3.min.js"></script>
	<script src="js/jquery-ui-1.9.2.custom.min.js"></script>   
    <!-- jQuery 2.1.4 -->
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- DataTables -->
    <script src="plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="plugins/datatables/dataTables.bootstrap.js"></script>
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
	  $(function () {
		$("#example1").DataTable();
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
    <!-- page script -->
  </body>
</html>
