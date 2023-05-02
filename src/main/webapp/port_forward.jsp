<%@include file="header.jsp" %>
 <body class="hold-transition skin-blue layout-boxedxx sidebar-mini">
 <!-- Site wrapper -->
 <div class="wrapper">
<%@include file="header2.jsp" %>
<%@include file="toolbar.jsp" %>
<%
LMOIpList us = new LMOIpList();
String interf="", 
interf_id="", 
ipmessage="", 
ip="", 
ipprefix="", 
nm="", 
network="", 
pr="", 
lop="", device="", mac="", address="",
result=""; 

if(request.getParameter("submit") != null && request.getParameter("submit").equals("Add Forwarding")) {
	String outdev = request.getParameter("device");
	String outmac = request.getParameter("mac");
	String inip = request.getParameter("inip");
	String inport = request.getParameter("inport");
	
	String intout = request.getParameter("intout");
	String outport = request.getParameter("outport");
	String outip = intout.split(":")[1];
	String intname = intout.split(":")[0];
	
	String notes = request.getParameter("notes");
	notes = notes.replace(" ", "");
	notes = notes.replace("_", "");
	
	String com = "PF_"+outmac+"_"+outdev+"_"+notes;
	boolean ir = false;

	ir = mg.portForwarding(intname, outip, outport, inip, inport, com, outmac);
	System.out.println(outdev+outmac+outip+intout);
	
	if(ir){
		response.sendRedirect("letmeout.jsp?interf="+interf+"&interf_id="+interf_id+"&msg=Added Succesfully&type=success");
	}else{
		response.sendRedirect("letmeout.jsp?interf="+interf+"&interf_id="+interf_id+"&msg=Failed To Add IP Range&type=error");
	}
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
	<section class="content-header"><p></p></section>	
	<section class="content">
		<div class="panel box box-primary">
          <div class="box-header with-border">
            <h4 class="box-title" style="width:100%;">
              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                Add Port Forwarding
              </a>
              <span class="pull-right"><i class="fa fa-angle-double-down"></i></span>
            </h4>
          </div>
          <div id="collapseOne" class="panel-collapse collapse <%= lop %>">
            <div class="box-body">
            	<form method="post" action="#">
            	<input type="hidden" class="form-control" required readonly id="device" name="device" value="<%= device %>">
            	<input type="hidden" class="form-control" required readonly id="mac" name="mac" value="<%= mac %>">
            	
			    <div class="box-body">
					<div class="row">
						 <div class="form-group col-sm-6">
						     <label for="ip" class="control-label">From Interface</label><br />
						     <select required class="form-control" id="intout" name="intout">
						     	<option value="">Select Out Interface</option>
						     	<%
						     	List<Map<String,String>> ips = mg.ipaddress();
						    	for(Map<String,String> mp : ips){
						    		String c = String.valueOf(mp.get("comment"));
						    		if(c.equalsIgnoreCase("MainIP")){
						    	%>
						    		<option value="<%= mp.get("interface") %>:<%= mp.get("address") %>"><%= mp.get("interface") %></option>
						    	<%
						    		}
						    	}
						     	%>
						     </select>
						 </div>
						 <div class="form-group col-sm-6">
						   <label for="netmask" class="control-label">From Port</label><br />
						   <input type="number" min="1030" max="49151" class="form-control" required id="outport" name="outport" placeholder="1030-49151">
						 </div>
					</div>
					<div class="row">
						 <div class="form-group col-sm-6">
						     <label for="ip" class="control-label"> Device / Application IP </label><br />
						     <input type="text" class="form-control" required id="inip" name="inip" value="<%= address %>">
						 </div>
						 <div class="form-group col-sm-6">
						   <label for="netmask" class="control-label"> Device / Application Port </label><br />
						   <input type="number" min="1" max="49151" class="form-control" required id="inport" name="inport" placeholder="1-49151">
						 </div>
					</div>
					<div class="row">
						 <div class="form-group col-sm-12">
						     <label for="notes" class="control-label"> Notes </label><br />
						     <input type="text" class="form-control" required id="notes" name="notes" placeholder="e.g: OfficeComputer">
						 </div>
					</div>
			    </div><!-- /.box-body -->
			    <div class="box-footer">
			      <a href="#" ><button class="btn btn-default">Cancel</button></a>
			      <input type="submit" name="submit" class="btn btn-info pull-right" value="Add Forwarding">
			    </div><!-- /.box-footer -->
			  </form>
           </div>
         </div>
      </div>

	  <div class="box">
        <div class="box-header">
          <h3 class="box-title">Devices<small>Select Device To Forward To</small></h3>
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
        		String btn = "<a title='Port Forward To' class='btn btn-sm btn-block btn-warning' href='?q=forward&device="+host+"&mac="+ma+"&address="+add+"'><i class='fa fa-sign-out'></i></a>";
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
      
      <div class="box">
	    <div class="box-header">
	      <h3 class="box-title">Port Forwarding Records</h3>
	    </div><!-- /.box-header -->
	    <div class="box-body">
	      <table id="example1" class="table table-bordered table-striped table-responsive">
	        <thead>
	          <tr>
	            <th>Device</th>
	            <th>MAC</th>
	            <th>Local</th>
	            <th>Remote</th>
	            <th>Notes</th>
	            <th><i class="fa fa-cog"></i></th>
	          </tr>
	        </thead>
	        <tbody>
	        <%
	        List<Map<String,String>> rs = mg.getForwardingRules();
	        for (Map<String,String> mp : rs) {
	        	String com = String.valueOf(mp.get("comment"));
	        	if(com.contains("PF_")){
				  	String chain = mp.get("chain");
				  	if(chain.equalsIgnoreCase("dstnat")){
					  	String s = mp.get(".id");
					  	String btn_dl = "<a href='letmeout_manage.jsp?lmo_reference="+com+"&interf="+interf+"&interf_id="+interf_id+"'><button title='Manage' class='btn btn-sm btn-info'><i class='fa fa-cog'></i></button></a>";
						
					  	out.println("<tr>");
						out.println("<td>"+com.split("_")[2]+"</td>");
						out.println("<td>"+com.split("_")[1]+"</td>");
						out.println("<td>"+mp.get("dst-address")+":"+mp.get("dst-port")+"</td>");
						out.println("<td>"+mp.get("to-addresses")+":"+mp.get("to-ports")+"</td>");
						out.println("<td>"+com.split("_")[3]+"</td>");
						out.println("<td>"+btn_dl+"</td>");
						out.println("</tr>");
				  	}
				  	/*else if(chain.equalsIgnoreCase("srcnat")){
				  		String s = mp.get(".id");
					  	String btn_dl = "<a href='letmeout_manage.jsp?lmo_reference="+com+"&interf="+interf+"&interf_id="+interf_id+"'><button title='Manage' class='btn btn-sm btn-info'><i class='fa fa-cog'></i></button></a>";
						
					  	out.println("<tr>");
						out.println("<td>"+com+"</td>");
						out.println("<td>"+com+"</td>");
						out.println("<td>"+mp.get("src-address")+":"+mp.get("src-port")+"</td>");
						out.println("<td>"+mp.get("to-addresses")+"</td>");
						out.println("<td>"+mp.get("comment")+"</td>");
						out.println("<td>"+btn_dl+"</td>");
						out.println("</tr>");
				  	}*/
	        	}
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