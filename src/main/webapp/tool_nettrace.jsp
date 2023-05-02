<%@include file="header.jsp" %>
<style>
	/* Center the loader */
	#loader {
	  position: absolute;
	  left: 60%;
	  top: 50%;
	  z-index: 1;
	  width: 150px;
	  height: 150px;
	  margin: -75px 0 0 -75px;
	  border: 16px solid #f3f3f3;
	  border-radius: 50%;
	  border-top: 16px solid #3498db;
	  width: 120px;
	  height: 120px;
	  -webkit-animation: spin 2s linear infinite;
	  animation: spin 2s linear infinite;
	}
	
	@-webkit-keyframes spin {
	  0% { -webkit-transform: rotate(0deg); }
	  100% { -webkit-transform: rotate(360deg); }
	}
	
	@keyframes spin {
	  0% { transform: rotate(0deg); }
	  100% { transform: rotate(360deg); }
	}
	
	/* Add animation to "page content" */
	.animate-bottom {
	  position: relative;
	  -webkit-animation-name: animatebottom;
	  -webkit-animation-duration: 1s;
	  animation-name: animatebottom;
	  animation-duration: 1s
	}
	
	@-webkit-keyframes animatebottom {
	  from { bottom:-100px; opacity:0 } 
	  to { bottom:0px; opacity:1 }
	}
	
	@keyframes animatebottom { 
	  from{ bottom:-100px; opacity:0 } 
	  to{ bottom:0; opacity:1 }
	}
	
	#myDiv {
	  display: none;
	}
</style>
<script>
	var myVar;
	
	function myFunction() {
	  //alert("Kill");
	  myVar = setTimeout(showPage, 3000);
	}
	
	function showPage() {
	  document.getElementById("loader").style.display = "none";
	  document.getElementById("myDiv").style.display = "block";
	}
</script>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="toolbar.jsp" %>
<%
String ipmessage = "",
address = "", duration = ""; 
List<Map<String, String>> rs = new ArrayList<Map<String, String>>();
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
	    ALPS NetTrace<sup>TM</sup>
	    <small>NetTrace<sup>TM</sup> Utility</small>
	  </h1>
	  <ol class="breadcrumb">
	    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	    <li><a href="#">Main</a></li>
	    <li class="">WAN</li>
	    <li class="active">Interfaces</li>
	  </ol>
	</section>
	<section class="content-header"><p></p></section>	
	
	<section class="content">
	  <div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title" style="width:100%;">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                NetTrace<sup>TM</sup> Address
              </a>
              <span class="pull-right"><i class="fa fa-angle-double-down"></i></span>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse collapse in">
            <div class="box-body">
            <form method="post" action="#">
				<div class="box-body">
					<div class="row">
						 <div class="form-group col-sm-10">
						     <label for="ip" class="control-label"> Device / Server IP </label><br />
						     <input type="text" class="form-control" required id="inip" name="inip" value="<%= address %>">
						 </div>
						 <div class="form-group col-sm-2">
						   <label for="netmask" class="control-label"> Duration </label><br />
						   <input type="number" min="10" max="60" class="form-control" required id="duration" name="duration" placeholder="10">
						 </div>
					</div>
				</div><!-- /.box-body -->
				<div class="box-footer">
				  <a href="#" ><button class="btn btn-default">Cancel</button></a>
				  <input type="submit" name="submit" class="btn btn-info pull-right" value="Trace Address">
				</div><!-- /.box-footer -->
			</form>
           </div>
         </div>
      </div>
      <%
      if(request.getParameter("submit") != null && request.getParameter("submit").equals("Trace Address")) {
    		address = request.getParameter("inip");
    		duration = request.getParameter("duration");
    		//out.print("<div id='loader'></div>");
    		
      %>
	  <div id="loader">Please Wait...</div>
	  <div class="box" id="myDiv">
        <div class="box-header">
          <h3 class="box-title">Devices <small>Select Device To Monitor</small></h3>
        </div><!-- /.box-header -->
        <div class="box-body table-responsive" style="max-height:800px; overflow-y:scroll;">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
              	<!-- <th>Section</th>  -->
                <th width="20%">Address</th>
                <th>Average(Seconds)</th>
                <th>Best / Worst (Seconds)</th>
                <th>Last (Seconds)</th>
                <th>STD Dev</th>
              </tr>
            </thead>
            <tbody>
            <%
            rs = mg.traceRoute(address, duration);
          	for (Map<String,String> mp : rs) {
          		int s = Integer.valueOf(mp.get(".section"));
          		if(s == 2){
              		if(mp.get("address") != null && mp.get("address") != "" && mp.get("last") != "timeout"){
					  	out.println("<tr>");
						//out.println("<td>"+mp.get(".section")+"</td>");
						out.println("<td>"+mp.get("address")+"</td>");
						out.println("<td>"+mp.get("avg")+"</td>");
						out.println("<td>"+mp.get("best")+" / "+mp.get("worst")+"</td>");
						out.println("<td>"+mp.get("last")+"</td>");
						out.println("<td>"+mp.get("std-dev")+"</td>");
						out.println("</tr>");
              		}
          		}
			}
			%>
           	</tbody>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
      <script>myFunction()</script>
      <% } %>
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