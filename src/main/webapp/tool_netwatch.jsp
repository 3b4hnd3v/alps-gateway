<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="toolbar.jsp" %>
<%
String ipmessage = "",
device = "", mac = "", address = "", lop = ""; 

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add To ALPS Sense")) {
	String dev = request.getParameter("device");
	String ma = request.getParameter("mac");
	String inip = request.getParameter("inip");
	
	String interval = request.getParameter("interval");
	String timeout = request.getParameter("timeout");	
	String notes = request.getParameter("notes");
	notes = notes.replace(" ", "");
	notes = notes.replace("_", "");
	
	String com = "ALPSSENSE_"+ma+"_"+dev+"_"+notes;
	boolean ir = false;

	ir = mg.addNetWatch(inip, timeout+"s", interval+"m", ma, com, true);
	
	if(ir){
		response.sendRedirect("tool_netwatch.jsp?msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("tool_netwatch.jsp?msg=Failed To Add IP Range&type=error");
	}
}
if(request.getParameter("start") != null && request.getParameter("start").equals("Add To ALPS Sense")) {
	String dev = request.getParameter("device");
	String ma = request.getParameter("mac");
	String inip = request.getParameter("inip");
	
	String interval = request.getParameter("interval");
	String timeout = request.getParameter("timeout");	
	String notes = request.getParameter("notes");
	notes = notes.replace(" ", "");
	notes = notes.replace("_", "");
	
	String com = "ALPSSENSE_"+ma+"_"+dev+"_"+notes;
	boolean ir = false;

	ir = mg.addNetWatch(inip, timeout+"s", interval+"m", ma, com, false);
	
	if(ir){
		response.sendRedirect("tool_netwatch.jsp?msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("tool_netwatch.jsp?msg=Failed To Add IP Range&type=error");
	}
}
if(request.getParameter("q") != null && request.getParameter("q").equals("remove")) {
	String item = request.getParameter("item");
	mg.removeNetWatch(item);
	
}

if(request.getParameter("q") != null && request.getParameter("q").equals("forward")) {
	device = request.getParameter("device");
	mac = request.getParameter("mac");
	address = request.getParameter("address");
	
	System.out.println(device+mac+address);
	
	lop = "in";
	
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
	    ALPS Sense<sup>TM</sup>
	    <small>ALPS Sense<sup>TM</sup> Setup</small>
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
          
          <div id="collapseOne" class="panel-collapse collapse <%= lop %>">
            <div class="box-body">
            	<form method="post" action="#">
            	<input type="hidden" class="form-control" required readonly id="device" name="device" value="<%= device %>">
            	<input type="hidden" class="form-control" required readonly id="mac" name="mac" value="<%= mac %>">
            	
			    <div class="box-body">
					
					<div class="row">
						 <div class="form-group col-sm-12">
						     <label for="ip" class="control-label"> Device / Server IP </label><br />
						     <input type="text" class="form-control" required id="inip" name="inip" value="<%= address %>">
						 </div>
						 <div class="form-group col-sm-6">
						   <label for="netmask" class="control-label"> Device Check Timeout <small>(seconds)</small></label><br />
						   <input type="number" min="10" max="60" class="form-control" required id="timeout" name="timeout" placeholder="10">
						 </div>
						 <div class="form-group col-sm-6">
						   <label for="netmask" class="control-label"> Device Check Interval <small>(minutes)</small></label><br />
						   <input type="number" min="10" max="60" class="form-control" required id="interval" name="interval" placeholder="10">
						 </div>
					</div>
					<div class="row">
						 <div class="form-group col-sm-12">
						     <label for="notes" class="control-label"> Short Description <small>(Less Than 50 characters)</small> </label><br />
						     <input type="text" class="form-control" required id="notes" name="notes" placeholder="e.g: OfficeComputer">
						 </div>
					</div>
			    </div><!-- /.box-body -->
			    <div class="box-footer">
			      <a href="tool_netwatch.jsp" class="btn btn-default">Cancel </a>
			      <input type="submit" name="submit" class="btn btn-info pull-right" value="Add To ALPS Sense">
			    </div><!-- /.box-footer -->
			  </form>
           </div>
         </div>
      </div>

	  <div class="box">
        <div class="box-header">
          <h3 class="box-title">Monitor Internal Devices <small>Select Device To Monitor</small></h3>
        </div><!-- /.box-header -->
        <div class="box-body table-responsive" style="max-height:500px; overflow-y:scroll;">
          <table id="example2" class="table table-bordered table-striped">
            <thead>
              <tr>
                <th width="25%">Device</th>
                <th width="25%">MAC</th>
                <th>IP</th>
                <th>Zone</th>
                <th><i class="fa fa-cog"></i></th>
              </tr>
            </thead>
            <tbody>
            <%
          	for (Map<String,String> mp : g.dhcpLease()) {
        		String dev = String.valueOf(mp.get("host-name")).replace("null", "Unknown");
        		String ma = mp.get("mac-address");
        		String host = mp.get("host-name");
        		String add = mp.get("address");
        		if(host.equals("null")){ host = mp.get("mac-address"); }
        		String btn = "<a title='Activate Mornitor' class='btn btn-sm btn-block btn-warning' href='?q=forward&device="+host+"&mac="+ma+"&address="+add+"'><i class='fa fa-sign-out'></i></a>";
			  	out.println("<tr>");
				out.println("<td>"+dev+"</td>");
				out.println("<td>"+ma+"</td>");
				out.println("<td>"+mp.get("address")+"</td>");
				out.println("<td>"+mp.get("server")+"</td>");
				out.println("<td>"+btn+"</td>");
				out.println("</tr>");
			}
			%>
           	</tbody>
          </table>
        </div><!-- /.box-body -->
      </div><!-- /.box -->
      
      <div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title" style="width:100%;">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                Monitor External Device <small>Enter Device Information To Monitor</small>
              </a>
              <span class="pull-right"><i class="fa fa-angle-double-down"></i></span>
            </h4>
          </div>
          <div id="collapseTwo" class="panel-collapse collapse">
            <div class="box-body">
            	<form method="post" action="#">
            	
			    <div class="box-body">
					
					<div class="row">
						 <div class="form-group col-sm-6">
						 	<label for="ip" class="control-label"> Device / Server MAC </label>
						 	<input type="text" class="form-control" required id="device" name="device">
						 </div>
						 <div class="form-group col-sm-6">
						 	<label for="ip" class="control-label"> Device / Server Name </label>
            				<input type="text" class="form-control" required id="mac" name="mac">
						 </div>
						 <div class="form-group col-sm-12">
						     <label for="ip" class="control-label"> Device / Server IP </label>
						     <input type="text" class="form-control" required id="inip" name="inip" value="<%= address %>">
						 </div>
						 <div class="form-group col-sm-6">
						   <label for="netmask" class="control-label"> Device Check Timeout <small>(seconds)</small></label>
						   <input type="number" min="10" max="60" class="form-control" required id="timeout" name="timeout" placeholder="10">
						 </div>
						 <div class="form-group col-sm-6">
						   <label for="netmask" class="control-label"> Device Check Interval <small>(minutes)</small></label>
						   <input type="number" min="10" max="60" class="form-control" required id="interval" name="interval" placeholder="10">
						 </div>
					</div>
					<div class="row">
						 <div class="form-group col-sm-12">
						     <label for="notes" class="control-label"> Short Description <small>(Less Than 50 characters)</small> </label>
						     <input type="text" class="form-control" required id="notes" name="notes" placeholder="e.g: OfficeComputer">
						 </div>
					</div>
			    </div><!-- /.box-body -->
			    <div class="box-footer">
			      <a href="#" ><button class="btn btn-default">Cancel</button></a>
			      <input type="submit" name="start" class="btn btn-info pull-right" value="Add To ALPS Sense">
			    </div><!-- /.box-footer -->
			  </form>
           </div>
         </div>
      </div>
      
      <div class="box">
	    <div class="box-header">
	      <h3 class="box-title">Active ALPS Sense<sup>TM</sup> Devices</h3>
	    </div><!-- /.box-header -->
	    <div class="box-body">
	      <table id="example1" class="table table-bordered table-striped table-responsive">
	        <thead>
	          <tr>
	            <th>IP</th>
	            <th>MAC</th>
	            <th>Timeout</th>
	            <th>Interval</th>
	            <th>Since</th>
	            <th>Status</th>
	            <th><i class="fa fa-cog"></i></th>
	          </tr>
	        </thead>
	        <tbody>
	        <%
	        List<Map<String,String>> rs = mg.getNetWatch();
	        for (Map<String,String> mp : rs) {
			  	String s = mp.get(".id");
			  	String com = String.valueOf(mp.get("comment"));
			  	String btn_dl = "<a href='tool_netwatch.jsp?q=remove&item="+s+"&com="+com+"'><button title='Remove' class='btn btn-sm btn-info'><i class='fa fa-trash'></i></button></a>";
			  	String btn_log = "<a href='tool_netwatch_log.jsp?item="+com+"'><button title='View Logs' class='btn btn-sm btn-info'><i class='fa fa-file'></i></button></a>";
			  	out.println("<tr>");
				out.println("<td>"+mp.get("host")+"</td>");
				out.println("<td>"+mp.get("comment")+"</td>");
				out.println("<td>"+mp.get("timeout")+"</td>");
				out.println("<td>"+mp.get("interval")+"</td>");
				out.println("<td>"+mp.get("since")+"</td>");
				out.println("<td>"+mp.get("status")+"</td>");
				out.println("<td>"+btn_dl+" "+btn_log+"</td>");
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